Window = {}
Window.prototype = { x = 0, y = 0, width = 100, height = 100 }
Window.mt = {}

Window.mt.__tostring = function(t)
    return "Window".." "..t.x.." "..t.y.." "..t.width.." "..t.height
end

Window.mt.__index = function(t, key)
    return Window.prototype[key]
end

function Window.new(o)
    setmetatable(o, Window.mt)
    return o
end

w = Window.new { x = 1, y = 20 }
print(w)