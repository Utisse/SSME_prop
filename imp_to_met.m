function out = imp_to_met(unit,val)
	temperatura = {'t','temp'};
	pressione = {'p'};
	portata = {'q'};
	if (sum(strcmp(unit,temperatura))>=1)
		out = (val-32) * 5/9 + 273.15;
	elseif (sum(strcmp(unit,pressione))>=1)
		    out = val *0.0689475728 *10^5;
	elseif (sum(strcmp(unit,portata))>=1)
		out = val /2.2046244201838;
	end
end
