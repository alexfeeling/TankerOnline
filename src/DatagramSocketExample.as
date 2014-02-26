package
{
    import flash.display.Sprite;
    import flash.events.DatagramSocketDataEvent;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.events.TimerEvent;
    import flash.net.DatagramSocket;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    import flash.text.TextFieldType;
    import flash.utils.ByteArray;
    import flash.utils.Timer;
    
    public class DatagramSocketExample extends Sprite
    {
        private var datagramSocket:DatagramSocket = new DatagramSocket();;

        private var localIP:TextField;
        private var localPort:TextField;
        private var logField:TextField;
        private var targetIP:TextField;
        private var targetPort:TextField;
        private var message:TextField;
        
        public function DatagramSocketExample()
        {
            setupUI();
        }

        private function bind( event:Event ):void
        {
            if( datagramSocket.bound ) 
            {
                datagramSocket.close();
                datagramSocket = new DatagramSocket();
                
            }
            datagramSocket.bind( parseInt( localPort.text ), localIP.text );
            datagramSocket.addEventListener( DatagramSocketDataEvent.DATA, dataReceived );
            datagramSocket.receive();
            log( "Bound to: " + datagramSocket.localAddress + ":" + datagramSocket.localPort );
        }
        
        private function dataReceived( event:DatagramSocketDataEvent ):void
        {
            //Read the data from the datagram
            log("Received from " + event.srcAddress + ":" + event.srcPort + "> " + 
                event.data.readUTFBytes( event.data.bytesAvailable ) );
        }
        
        private function send( event:Event ):void
        {
            //Create a message in a ByteArray
            var data:ByteArray = new ByteArray();
            data.writeUTFBytes( message.text );
            
            //Send a datagram to the target
            try
            {
                datagramSocket.send( data, 0, 0, targetIP.text, parseInt( targetPort.text )); 
                log( "Sent message to " + targetIP.text + ":" + targetPort.text );
            }
            catch ( error:Error )
            {
                log( error.message );
            }
        }
        
        private function log( text:String ):void
        {
            logField.appendText( text + "\n" );
            logField.scrollV = logField.maxScrollV;
            trace( text );
        }
        private function setupUI():void
        {
            targetIP = createTextField( 10, 10, "Target IP:", "192.168.0.1" );
            targetPort = createTextField( 10, 35, "Target port:", "8989" );
            message = createTextField( 10, 60, "Message:", "Lucy can't drink milk." );
            localIP = createTextField( 10, 85, "Local IP", "0.0.0.0");
            localPort = createTextField( 10, 110, "Local port:", "0" );
            createTextButton( 250, 135, "Bind", bind );
            createTextButton( 300, 135, "Send", send );
            logField = createTextField( 10, 160, "Log:", "", false, 200 )
                
            //this.stage.nativeWindow.activate();
        }
        
        private function createTextField( x:int, y:int, label:String, defaultValue:String = '', editable:Boolean = true, height:int = 20 ):TextField
        {
            var labelField:TextField = new TextField();
            labelField.text = label;
            labelField.type = TextFieldType.DYNAMIC;
            labelField.width = 180;
            labelField.x = x;
            labelField.y = y;
            
            var input:TextField = new TextField();
            input.text = defaultValue;
            input.type = TextFieldType.INPUT;
            input.border = editable;
            input.selectable = editable;
            input.width = 280;
            input.height = height;
            input.x = x + labelField.width;
            input.y = y;
            
            this.addChild( labelField );
            this.addChild( input );
            
            return input;
        }
        
        private function createTextButton( x:int, y:int, label:String, clickHandler:Function ):TextField
        {
            var button:TextField = new TextField();
            button.htmlText = "<u><b>" + label + "</b></u>";
            button.type = TextFieldType.DYNAMIC;
            button.selectable = false;
            button.width = 180;
            button.x = x;
            button.y = y;
            button.addEventListener( MouseEvent.CLICK, clickHandler );
            
            this.addChild( button );
            return button;
            
        }
    }
}