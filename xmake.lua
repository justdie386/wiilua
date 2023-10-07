package("wiiuse")
set_homepage("github.com/wiiuse/wiiuse")
set_description("wii remote library for C")
add_urls("https://github.com/wiiuse/wiiuse.git")
add_deps("cmake")
if is_plat("linux") then
  add_syslinks("bluetooth")
elseif is_plat("windows") then
  add_syslinks("ws2_32", "Hid", "Setupapi")
elseif is_plat("macosx") then
  add_frameworks("IOBluetooth", "CoreBluetooth")
end
on_load(function(package)
  if not package:config("shared") then
    package:add("defines", "WIIUSE_STATIC")
  end
end)

on_install(function(package)
  local configs = {}
  table.insert(configs, "-DCMAKE_BUILD_TYPE=" .. (package:debug() and "Debug" or "Release"))
  table.insert(configs, "-DBUILD_SHARED_LIBS=" .. (package:config("shared") and "ON" or "OFF"))
  import("package.tools.cmake").install(package, configs)
end)

on_test(function(package)
  assert(package:has_cfuncs("wiiuse_version", { includes = "wiiuse.h" }))
end)
package_end()
option("setup")
set_default(true)
set_description("setup the folders to work with wiilua")
option_end()
add_requires("wiiuse", { configs = { shared = true } })
if is_plat("windows") then
  target_name = "libwiilua"
else
  target_name = "wiilua"
end
target(target_name)
add_options("setup")
add_packages("wiiuse")
set_kind("shared")
add_files("src/wiilua.c")
after_link(function(target)
  if has_config("setup") then
    os.mkdir("wiidev")
    for _, file in pairs(target:pkg("wiiuse"):get("libfiles")) do
      os.cp(tostring(file), "wiidev")
      break
    end
    os.cp("build/*/*/release/libwiilua.*", "wiidev")
    os.cp("wiiffi.lua", "wiidev")
    os.cp("main.lua", "wiidev")
    cprint('${bright blue}wiilua has been setup for you, open the wiidev folder and get started developing!')
  end
end)
target_end()
