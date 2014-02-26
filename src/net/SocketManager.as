package net
{
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	import util.PackageConst;
	
	/**
	 * ...
	 * @author alexfeeling
	 */
	public class SocketManager
	{
		
		//alexfeeling.wicp.net:18483
		private static const SERVER_HOST:String = "192.168.1.192"; // "alexfeeling.wicp.net";
		private static const SERVER_PORT:int = 61345; // 18483;
		
		private var _socket:Socket;
		
		private static var _instance:SocketManager;
		
		public function SocketManager()
		{
			if (_instance)
			{
				throw "already exits.";
			}
		}
		
		public static function get instance():SocketManager
		{
			if (!_instance)
			{
				_instance = new SocketManager();
			}
			return _instance;
		}
		
		public static function sendDataToServer(data:Object):void
		{
			instance.sendPackage(new SocketPackage("",data));
		}
		
		public function connectToServer():void
		{
			_socket = new Socket();
			_socket.addEventListener(Event.CONNECT, connectSucc);
			_socket.addEventListener(Event.CLOSE, socketClose);
			_socket.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			_socket.addEventListener(ProgressEvent.SOCKET_DATA, onSocketData);
			_socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecuError);
			_socket.connect(SERVER_HOST, SERVER_PORT);
		}
		
		public function closeConnection():void
		{
			if (_socket)
			{
				if (_socket.connected)
				{
					_socket.close();
				}
				_socket = null;
			}
		}
		
		private function connectSucc(event:Event):void
		{
			trace("connect server success");
			this.sendPackage(new SocketPackage("",{name: "login", un: "alex", psw: "1234"}));
		}
		
		private function socketClose(event:Event):void
		{
			trace("socket close");
			if (this._socket.connected)
			{
				this._socket.close();
			}
			this._socket = null;
		}
		
		private function onIOError(event:IOErrorEvent):void
		{
			trace(event.text);
		}
		
		private function onSecuError(event:SecurityErrorEvent):void
		{
			trace(event.text);
		}
		
		private function onSocketData(event:ProgressEvent):void
		{
			try
			{
				while (_socket.bytesAvailable)
				{
					var code:int = _socket.readUnsignedShort();
					var dataLen:int = _socket.readUnsignedShort();
					var pack:SocketPackage = new SocketPackage();
					pack.code = code;
					pack.setDataByStr(_socket.readUTFBytes(dataLen));
					dealPackage(pack);
				}
			}
			catch (err:Error)
			{
				trace("socket data", err);
				_socket.close();
				_socket = null;
			}
		}
		
		///向服务器发包
		public function sendPackage(pack:SocketPackage):void
		{
			var dataStr:String = pack.getDataStr();
			_socket.writeShort(pack.code);//16位无符号整数应该够用了，最大值65536
			_socket.writeShort(dataStr.length);
			_socket.writeUTFBytes(dataStr);
			_socket.flush();
		}
		
		///处理服务器发包
		private function dealPackage(pack:SocketPackage):void
		{
			switch (pack.code)
			{
				case PackageConst.LOGIN_CODE: 
					trace("receive login response", pack.data[PackageConst.LOGIN_REP_RESULT]);
					break;
			}
		}
	}

}