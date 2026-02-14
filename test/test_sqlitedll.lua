WorkingFolder = "C:\\MyFiles\\Lua\\lsqlite3_fsl09y\\lsqlite3_fsl09y\\win_vs2022\\x64\\Release"
package.cpath = WorkingFolder .. "\\?.dll;"
local sqlite = require("lsqlite3")

-- Узнаем текущую рабочую папку
local function get_current_dir()
    local handle = io.popen("cd")
    local result = handle:read("*a")
    handle:close()
    return result:gsub("%s+", "")
end

print("Current working directory:", get_current_dir())

-- Указываем полный путь к БД
local db_path = WorkingFolder .. "\\test.db"
local db = sqlite.open(db_path)
print("Database opened")

-- Проверим, существует ли файл
local function file_exists(name)
    local f = io.open(name, "r")
    if f then
        f:close()
        return true
    end
    return false
end

print("test.db exists in current dir:", file_exists("test.db"))
print("test.db exists in WorkingFolder:", file_exists(WorkingFolder .. "\\test.db"))

-- Создадим таблицу
db:exec[[
    CREATE TABLE IF NOT EXISTS test(id INTEGER, name TEXT);
    INSERT INTO test VALUES(1, 'Hello');
]]

-- Закроем БД
db:close()

-- Проверим еще раз после закрытия
print("After close - test.db exists:", file_exists("test.db"))