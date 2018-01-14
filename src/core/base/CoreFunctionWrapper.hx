package core.base;


	 class CoreFunctionWrapper extends CoreParameterHolder
	{
		@protected var name : String;


		@protected var reference : Dynamic;

		public function new (name : String , reference : Dynamic) : Void
		{
			this.name = name;
			this.reference = reference;
		}

		@protected function call ( ) : Dynamic
		{
			return this.reference( this.params );
		}

		override public function has (reference : Dynamic) : Bool
		{
			return (this.reference == reference);	
		}

		//Abstract function
		public function clone () : Dynamic
		{
			return null;
		}
	}

