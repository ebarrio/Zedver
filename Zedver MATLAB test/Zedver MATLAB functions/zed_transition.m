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
    if(ready_1 == 1)
        if(sign(n) > yx1)
            up_tx1 = n;
            ready_1 = 1;
        end
    else
        if(sign(n) > yx2)
            up_tx2 = n;
            break;
        end
    end
end
ready_1 = 0;
% Find down transition reference levels
for n = length(sign):-1:1
    if(ready_1 == 1)
        if(sign(n) > yx1)
            down_tx1 = n;
            ready_1 = 1;
        end
    else
        if(sign(n) > yx2)
            down_tx2 = n;
            break;
        end
    end
end
%Transition duration between x1 and x2
tup = up_tx2 - up_tx1;
tdown = down_tx1 - down_tx2;
end