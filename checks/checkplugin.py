smart_temp_default_values = (35, 40)

def inventory_smart_temp(info):
   for line in info:
      disk = line[0]
      field = line[2]
      if field == "Temperature_Celsius":
          yield disk, "smart_temp_default_values"

def check_smart_temp(item, params, info):
   # unpack check parameters
   warn, crit = params

   for line in info:
      if line[0] == item and line[2] == "Temperature_Celsius":
         celsius = int(line[10])
         perfdata = [ ( "temp", celsius, warn, crit ) ]
         if celsius > crit:
            return 2, "Temperature is %dC" % celsius, perfdata
         elif celsius > warn:
            return 1, "Temperature is %dC" % celsius, perfdata
         else:
            return 0, "Temperature is %dC" % celsius, perfdata

check_info["smart.temp"] = {
    'check_function':            check_smart_temp,
    'inventory_function':        inventory_smart_temp,
    'service_description':       'SMART drive %s',
    'has_perfdata':              True,
}
