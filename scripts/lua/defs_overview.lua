--
-- (C) 2013-20 - ntop.org
--

dirs = ntop.getDirs()
package.path = dirs.installdir .. "/scripts/lua/modules/?.lua;" .. package.path
require "lua_utils"
local alert_consts = require("alert_consts")
local flow_consts = require("flow_consts")
local page_utils = require("page_utils")

sendHTTPContentTypeHeader('text/html')

page_utils.set_active_menu_entry(page_utils.menu_entries.alert_definitions)

dofile(dirs.installdir .. "/scripts/lua/inc/menu.lua")

print([[
<div class="row">
  <div class="col-md-12">]])
page_utils.print_page_title(i18n("about.alert_defines"))
print([[
  </div>
</div>
]])

print [[
<div class="row">
<div class="col col-md-5">
<table class="table table-bordered table-sm">
<tr><th class='text-center'>]] print(i18n("plugins_overview.alert_key")) print[[</th><th>]] print(i18n("plugins_overview.alert_key")) print[[</th></tr>]]

local id_start = 0
local id_end = 63

for alert_key = 0, 65535 do
  local alert_type = alert_consts.getAlertType(alert_key)

  if alert_type then 
     print[[<td class='text-right'>]] print(string.format("%i", alert_key)) print[[</td>]]
     print[[<td>]] print(string.format("%s", alert_type)) print[[</td></tr>]]
  end
end

print[[</table>
</div>
<div class="col offset-1 col-md-5">
<table class="table table-bordered table-sm">
<tr><th class='text-center'>]] print(i18n("plugins_overview.status_key")) print[[</th><th>]] print(i18n("plugins_overview.status_key")) print[[</th></tr>]]

for status_id = id_start,id_end do
  local status_type = flow_consts.getStatusType(status_id)
  local status_info = flow_consts.status_types[status_type]

  if status_type and status_info then
    print[[<tr><td class='text-center'>]] print(string.format("%d", status_id)) print[[</td>]]
    print[[<td>]] print(status_type) print[[</td>]]
   end  
end

print[[</table>
</div>
</div>]]

--~ tprint(alert_consts.alert_types)
--~ tprint(alert_consts.flow_consts)

dofile(dirs.installdir .. "/scripts/lua/inc/footer.lua")

