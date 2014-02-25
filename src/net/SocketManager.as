package net 
{
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	/**
	 * ...
	 * @author alexfeeling
	 */
	public class SocketManager 
	{
		
		//alexfeeling.wicp.net:18483
		private static const SERVER_HOST:String = "alexfeeling.wicp.net";
		private static const SERVER_PORT:int = 18483;
		
		private var _socket:Socket;
		
		private static var _instance:SocketManager;
		
		public function SocketManager() 
		{
			if (_instance) {
				throw "already exits.";
			}
		}
		
		public static function get instance():SocketManager {
			if (!_instance) {
				_instance = new SocketManager();
			}
			return _instance;
		}
		
		public static function sendDataToServer(data:Object):void {
			instance.sendPackage(new SocketPackage(data));
		}
		
		public function connectToServer():void {
			_socket = new Socket();
			_socket.addEventListener(Event.CONNECT, connectSucc);
			_socket.addEventListener(Event.CLOSE, socketClose);
			_socket.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			_socket.addEventListener(ProgressEvent.SOCKET_DATA, onSocketData);
			_socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecuError);
			_socket.connect(SERVER_HOST, SERVER_PORT);
		}
		
		public function closeConnection():void {
			if (_socket) {
				if (_socket.connected) {
					_socket.close();
				}
				_socket = null;
			}
		}
		
		private function connectSucc(event:Event):void {
			//var str:String = "hello server!";
			//_socket.writeByte(str.length);
			//_socket.writeUTFBytes(str);
			//_socket.flush();
			trace("connect server success");
			this.sendPackage(new SocketPackage( {name:"login", un:"alex",psw:"1234" } ));
		}
		
		private function socketClose(event:Event):void {
			trace("socket close");
			if (this._socket.connected) {
				this._socket.close();
			}
			this._socket = null;
		}
		
		private function onIOError(event:IOErrorEvent):void {
			trace(event.text);
		}
		
		private function onSecuError(event:SecurityErrorEvent):void {
			trace(event.text);
		}
		
		private function onSocketData(event:ProgressEvent):void {
			try 
			{
				trace("byteTotal", event.bytesLoaded);
				while (_socket.bytesAvailable) {
					
					var dataLen:int = _socket.readInt();
					trace("dataLen", dataLen);
					var pack:SocketPackage = new SocketPackage();
					//pack.data = 
					trace("data", SocketPackage.encodeData(_socket.readUTFBytes(event.bytesTotal-4)));
					//trace(pack.data);
					handlerPackage(pack);
				}
				
			} 
			catch (err:Error) 
			{
				trace("socket data",err);
				_socket.close();
				_socket = null;
			}
		}
		
		public function sendPackage(pack:SocketPackage):void {
			var dataStr:String = pack.getDataStr();
			_socket.writeInt(dataStr.length);
			_socket.writeUTFBytes(dataStr);
			_socket.flush();
		}
		
		private function handlerPackage(pack:SocketPackage):void {
			switch(pack.data.name) {
				case "login_rep":
					trace("receive login reponse", pack.data.id);
					break;
			}
		}
	}

}