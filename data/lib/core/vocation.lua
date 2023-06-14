function Vocation.getBase(self)
	local base = self
	while base:getDemotion() do
		base = base:getDemotion()
	end
	return base
end

function Player.isSorcerer(self)
    return isInArray({1, 5}, self:getVocation():getId())
end

function Player.isDruid(self)
    return isInArray({2, 6}, self:getVocation():getId())
end

function Player.isPaladin(self)
    return isInArray({3, 7}, self:getVocation():getId())
end

function Player.isKnight(self)
    return isInArray({4, 8}, self:getVocation():getId())
end

function Player.isMage(self)
    return isInArray({1, 2, 5, 6}, self:getVocation():getId())
end
