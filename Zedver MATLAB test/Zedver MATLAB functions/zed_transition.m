function [tup, tdown] = zed_transition (sign, x1perc, x2perc)
% Search levels
[top , flat] = zed_state_levels(sign,0);
A = top - flat;
if(A < 0) % Never launched
    A = -A;
end
% Reference levels
yx1 = flat + (A * x1perc)/100;
yx2 = flat + (A * x2perc)/100;
% Reference levels instants
up_tx1 = 0;
up_tx2 = 0;
down_tx1 = 0;
up_tx2 = 0;
ready_1 = 0;
% Find up transition reference levels
for n = 1:length(sign)
    if(ready_1 == 0)
        if(sign(n) > yx1)
            up_tx11 = n;
            ready_1 = 1;
        end
    else
        if(sign(n) > yx2)
            up_tx21 = n;
            break;
        end
    end
end
ready_1 = 0;
% Find down transition reference levels
for n = length(sign):-1:1
    if(ready_1 == 0)
        if(sign(n) > yx1)
            down_tx11 = n;
            ready_1 = 1;
        end
    else
        if(sign(n) > yx2)
            down_tx21 = n;
            break;
        end
    end
end
% Calculate reference level instant using linear interpolation
% Instant: Low reference, up transition
up_tx10 = (up_tx11 + 1);
up_tx12 = (up_tx11 - 1);
up_tx11 = up_tx10 + (sign(up_tx11)-sign(up_tx10))*((up_tx12 - up_tx10)/(sign(up_tx12)-sign(up_tx10)));
% Instant: High reference, up transition
up_tx20 = (up_tx21 + 1);
up_tx22 = (up_tx21 - 1);
up_tx21 = up_tx20 + (sign(up_tx21)-sign(up_tx20))*((up_tx22 - up_tx20)/(sign(up_tx22)-sign(up_tx20)));
% Instant: Low reference, down transition
down_tx10 = (down_tx11 + 1);
down_tx12 = (down_tx11 - 1);
down_tx11 = down_tx10 + (sign(down_tx11)-sign(down_tx10))*((down_tx12 - down_tx10)/(sign(down_tx12)-sign(down_tx10)));
% Instant: High reference, down transition
down_tx20 = (down_tx21 + 1);
down_tx22 = (down_tx21 - 1);
down_tx21 = down_tx20 + (sign(down_tx21)-sign(down_tx20))*((down_tx22 - down_tx20)/(sign(down_tx22)-sign(down_tx20)));

tup = up_tx21 - up_tx11;
if(tup < 0)
    tup = -tup;
end
tdown = down_tx11 - down_tx21;
if(tdown < 0)
    tdown = -tdown;
end
end