local event = Event()
event.onTradeAccept = function(self, target, item, targetItem)
	file = io.open('data/logs/trade.txt',"a")
    file:write(""..os.date("%c")..": "..self:getName().." traded:")
    if item:isContainer() then
            file:write(string.format(' %s (%s)(%s),',  item:getName(), item:getId(), item:getCount() > 1 and item:getCount()))
    else
        file:write(string.format(' %s (%s)(%s),', item:getName(), item:getId(), item:getCount() > 1 and item:getCount()))
    end
    file:write(" with "..target:getName().." for:")
    if targetItem:isContainer() then
            file:write(string.format(' %s (%s)(%s),', targetItem:getName(), targetItem:getId(), targetItem:getCount() > 1 and targetItem:getCount()))
			self:sendTextMessage(MESSAGE_INFO_DESCR, "You just trade with "..target:getName()..". Exchanged an "..item:getName().." for "..targetItem:getName()..".")
    else
        file:write(string.format(' %s (%s)(%s).', targetItem:getName(), targetItem:getId(), targetItem:getCount() > 1 and targetItem:getCount()))
		self:sendTextMessage(MESSAGE_INFO_DESCR, "You just trade with "..target:getName()..". Exchanged an "..item:getName().." for "..targetItem:getName()..".")
	end
    file:write('\n-------------------------\n\n')
    file:close()
	return true
end

event:register()
