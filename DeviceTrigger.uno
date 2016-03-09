using Uno;
using Uno.Collections;
using Fuse;
using Uno.Compiler.ExportTargetInterop;

public class DeviceTrigger : Fuse.Triggers.Trigger
{
	static DeviceTrigger () {
		Init();
	}

	public static extern(CIL) void Init() {
		_Platform = "CIL";
	}

	[Foreign(Language.Java)]
	public static extern (Android) void Init() 
	@{
		@{_Platform:Set("Android")};
		@{_OsVersion:Set(System.getProperty("os.version"))};
		@{_OsBuildVersion:Set(android.os.Build.VERSION.INCREMENTAL)};
		@{_OsAPILevel:Set(String.valueOf(android.os.Build.VERSION.SDK_INT))};
		@{_Brand:Set(android.os.Build.BRAND)};
		@{_Display:Set(android.os.Build.DISPLAY)};
		@{_Fingerprint:Set(android.os.Build.FINGERPRINT)};
		@{_Hardware:Set(android.os.Build.HARDWARE)};
		@{_ID:Set(android.os.Build.ID)};
		@{_Manufacturer:Set(android.os.Build.MANUFACTURER)};
		@{_Device:Set(android.os.Build.DEVICE)};
		@{_Model:Set(android.os.Build.MODEL)};
		@{_Product:Set(android.os.Build.PRODUCT)};
	@}

	[Require("Source.Include", "sys/utsname.h")]
	[Foreign(Language.ObjC)]
	public static extern (iOS) void Init() 
	@{
		@{_Platform:Set(@"iOS")};
		NSOperatingSystemVersion osv = [[NSProcessInfo processInfo] operatingSystemVersion];
		NSString *verString = [NSString stringWithFormat:@"%d.%d.%d", osv.majorVersion, osv.minorVersion, osv.patchVersion];
		@{_OsVersion:Set(verString)};
		@{_OsAPILevel:Set([[UIDevice currentDevice] systemVersion])};
		@{_Brand:Set(@"Apple")};
		@{_Manufacturer:Set(@"Apple")};

		struct utsname systemInfo;
		uname(&systemInfo);

		NSString *device = [NSString stringWithCString:systemInfo.machine
		                          encoding:NSUTF8StringEncoding];
		@{_Device:Set(device)};
		@{_Model:Set(device)};
		@{_Product:Set(device)};
	@}

	static string _Platform { get; set; } // Android, iOS, CIL
	static string _OsVersion { get; set; } // 3.10.49-perf-g75e6207, 9.2.0
	static string _OsBuildVersion { get; set; }
	static string _OsAPILevel { get; set; } // 22, 9.2.0
	static string _Brand { get; set; } // Sony, Apple
	static string _Display { get; set; } // 32.0.A.6.200
	static string _Fingerprint { get; set; } // Sony/E6653/E6653:5.1.1/32.0.A.6.200/2002872085:user/release-keys
	static string _Hardware { get; set; } // qcom
	static string _ID { get; set; } // 32.0.A.6.200
	static string _Manufacturer { get; set; } // Sony
	static string _Device { get; set; } // E6653
	static string _Model { get; set; } // E6653
	static string _Product { get; set; } // E6653

	string _aPlatform;
	public string Platform {
		get { return _aPlatform; } 
		set { 
			if (Debug) debug_log "Platform set " + value;
			_aPlatform = value;
			RecalcActivate();
		}
	}

	string _aOsVersion;
	public string OsVersion {
		get { return _aOsVersion; } 
		set { 
			if (Debug) debug_log "OsVersion set " + value;
			_aOsVersion = value;
			RecalcActivate();
		}
	}

	string _aOsBuildVersion;
	public string OsBuildVersion {
		get { return _aOsBuildVersion; } 
		set { 
			if (Debug) debug_log "OsBuildVersion set " + value;
			_aOsBuildVersion = value;
			RecalcActivate();
		}
	}

	string _aOsAPILevel;
	public string OsAPILevel {
		get { return _aOsAPILevel; } 
		set { 
			if (Debug) debug_log "OsAPILevel set " + value;
			_aOsAPILevel = value;
			RecalcActivate();
		}
	}

	string _aBrand;
	public string Brand {
		get { return _aBrand; } 
		set { 
			if (Debug) debug_log "Brand set " + value;
			_aBrand = value;
			RecalcActivate();
		}
	}
	string _aDisplay;
	public string Display {
		get { return _aDisplay; } 
		set { 
			if (Debug) debug_log "Display set " + value;
			_aDisplay = value;
			RecalcActivate();
		}
	}
	string _aFingerprint;
	public string Fingerprint {
		get { return _aFingerprint; } 
		set { 
			if (Debug) debug_log "Fingerprint set " + value;
			_aFingerprint = value;
			RecalcActivate();
		}
	}
	string _aHardware;
	public string Hardware {
		get { return _aHardware; } 
		set { 
			if (Debug) debug_log "Hardware set " + value;
			_aHardware = value;
			RecalcActivate();
		}
	}
	string _aID;
	public string ID {
		get { return _aID; } 
		set { 
			if (Debug) debug_log "ID set " + value;
			_aID = value;
			RecalcActivate();
		}
	}
	string _aManufacturer;
	public string Manufacturer {
		get { return _aManufacturer; } 
		set { 
			if (Debug) debug_log "Manufacturer set " + value;
			_aManufacturer = value;
			RecalcActivate();
		}
	}

	string _aDevice;
	public string Device {
		get { return _aDevice; } 
		set { 
			if (Debug) debug_log "Device set " + value;
			_aDevice = value;
			RecalcActivate();
		}
	}

	string _aModel;
	public string Model {
		get { return _aModel; } 
		set { 
			if (Debug) debug_log "Model set " + value;
			_aModel = value;
			RecalcActivate();
		}
	}

	string _aProduct;
	public string Product {
		get { return _aProduct; } 
		set { 
			if (Debug) debug_log "Product set " + value;
			_aProduct = value;
			RecalcActivate();
		}
	}

	public bool Debug {
		get; set;
	}

	public bool Invert {
		get; set;
	}

	public void SetOn (string s1, string s2)
	{
		if (s1 != null) {
			if (s1 != s2) {
				_on = false;
			}
		}
	}

	bool _on = false;
	public void RecalcActivate ()
	{
		_on = true;
		SetOn(Platform, _Platform);
		SetOn(OsVersion, _OsVersion);
		SetOn(OsBuildVersion, _OsBuildVersion);
		SetOn(OsAPILevel, _OsAPILevel);
		SetOn(Brand, _Brand);
		SetOn(Display, _Display);
		SetOn(Fingerprint, _Fingerprint);
		SetOn(Hardware, _Hardware);
		SetOn(ID, _ID);
		SetOn(Manufacturer, _Manufacturer);
		SetOn(Device, _Device);
		SetOn(Model, _Model);
		SetOn(Product, _Product);
		if (Debug) {
			debug_log "Device:";
			debug_log _Platform;
			debug_log _OsVersion;
			debug_log _OsBuildVersion;
			debug_log _OsAPILevel;
			debug_log _Brand;
			debug_log _Display;
			debug_log _Fingerprint;
			debug_log _Hardware;
			debug_log _ID;
			debug_log _Manufacturer;
			debug_log _Device;
			debug_log _Model;
			debug_log _Product;
			debug_log "Trigger:";
			debug_log Platform;
			debug_log OsVersion;
			debug_log OsBuildVersion;
			debug_log OsAPILevel;
			debug_log Brand;
			debug_log Display;
			debug_log Fingerprint;
			debug_log Hardware;
			debug_log ID;
			debug_log Manufacturer;
			debug_log Device;
			debug_log Model;
			debug_log Product;
			debug_log "Result: " + _on;
		}

		if (ParentNode != null) {
			if (_on) {
				Activate();
			}
			else {
				Deactivate();
			}
		}
	}

	protected override void OnRooted(Node parentNode)
	{
		base.OnRooted(parentNode);
		if (_on) {
			BypassActivate();
		}
	}

	protected override void OnUnrooted(Node parentNode)
	{
		Deactivate();
		base.OnUnrooted(parentNode);
	}
}
