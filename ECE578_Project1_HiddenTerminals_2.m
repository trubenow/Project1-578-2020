%Global counter T = 0;
T = 0;
lambda = 200;
currentA = 1;
currentC = 1;
total = 0;
backoffA = -1;
backoffC = -1;
difs = 2;
frameSize = 50;
sifs = 1;
ack = 2;
CW = 4;
numPacketsASent = 0;
numPacketsCSent = 0;
collisions = 0;
RTS = 2;
CTS = 2;

%Create Poisson distributions for A and C
%Put those into arrays
uniformFramesA = unifrnd(0,1,1,11*lambda);
uniformFramesC = unifrnd(0,1,1,11*lambda);
logMatrixA = log(1 - uniformFramesA);
logMatrixC = log(1 - uniformFramesC);
expFramesA = (-1/lambda)*logMatrixA;
expFramesC = (-1/lambda)*logMatrixC;

slotDiffA = ceil(expFramesA / 0.00001);
slotDiffC = ceil(expFramesC / 0.00001);

% Index the time each frame starts to send from A
for i = 1:1:length(slotDiffA)
    total = total + slotDiffA(i);
    framesA(i) = total;
end

total = 0;

% Index the time each frame starts to send from C
for i = 1:1:length(slotDiffC)
    total = total + slotDiffC(i);
    framesC(i) = total;
end

%For T < total number of slots
while(T < 1000000) 
    
    %New backoff after every transmission attempt
    if(backoffA < 0)
        backoffA = floor(rand * CW);
    end
    if(backoffC < 0)
        backoffC = floor(rand * CW);
    end
    
    %Check if A RTS transmits before C tries to transmit RTS
    if((framesA(currentA) + difs + backoffA + RTS) < (framesC(currentC) + difs + backoffC))
        timePassed = difs + backoffA + RTS + sifs + CTS + sifs + frameSize + sifs + ack;
        T = timePassed + framesA(currentA);
        currentA = currentA + 1;
        numPacketsASent = numPacketsASent + 1;
        backoffA = -1;
        CW = 4;
        
    %Check if C RTS transmits before A tries to transmit RTS
    elseif((framesC(currentC) + difs + backoffC + CTS) < (framesA(currentA) + difs + backoffA))
        timePassed = difs + backoffC + RTS + sifs + CTS + sifs + frameSize + sifs + ack;
    	T = timePassed + framesC(currentC);
        currentC = currentC + 1;
        numPacketsCSent = numPacketsCSent + 1;
        backoffC = -1;
        CW = 4;   
        
    else % If A and C collide
        % Frame A is ready first
        if ((framesA(currentA) + backoffA) < (framesC(currentC) + backoffC))
            timePassed = difs + backoffC + RTS + sifs + CTS;
            backoffA = -1;
            backoffC = -1;
            collisions = collisions + 1;
            T = timePassed + framesC(currentC);
        % Frame c is ready first
        else
            timePassed = difs + backoffA + RTS + sifs + CTS;
            backoffA = -1;
            backoffC = -1;
            collisions = collisions + 1;
            T = timePassed + framesA(currentA);
        end
        % Double CW when collide
        if(CW < 1024)
           CW = CW*2;
        end
  
    end
        
end