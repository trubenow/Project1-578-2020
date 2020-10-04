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

%Create Poisson distributions for A and C
%Put those into arrays
uniformFramesA = unifrnd(0,1,1,10*lambda);
uniformFramesC = unifrnd(0,1,1,10*lambda);
logMatrixA = log(1 - uniformFramesA);
logMatrixC = log(1 - uniformFramesC);
expFramesA = (-1/lambda)*logMatrixA;
expFramesC = (-1/lambda)*logMatrixC;

slotDiffA = ceil(expFramesA / 0.00001);
slotDiffC = ceil(expFramesC / 0.00001);

for i = 1:1:length(slotDiffA)
    total = total + slotDiffA(i);
    framesA(i) = total;
end

total = 0;

for i = 1:1:length(slotDiffC)
    total = total + slotDiffC(i);
    framesC(i) = total;
end

%For i < total number of slots
while(T < 1000000)  %check this number
    
    if(backoffA < 0)
        backoffA = floor(rand * CW);
    end
    if(backoffC < 0)
        backoffC = floor(rand * CW);
    end
    
    %Check A and C, the smaller slot # wins
    if((framesA(currentA) + backoffA) < (framesC(currentC) + backoffC))
        if((framesC(currentC) + backoffC) - (framesA(currentA) + backoffA) <= backoffC)
           backoffC = (framesC(currentC) + backoffC) - (framesA(currentA) + backoffA);
        end
        
        %add all needed slots up, advance T to that time
    
        timePassed = difs + backoffA + frameSize + sifs + ack;
    
        T = timePassed + framesA(currentA);
        currentA = currentA + 1;
        numPacketsASent = numPacketsASent + 1;
        backoffA = -1;
    
    elseif((framesC(currentC) + backoffC) < (framesA(currentA) + backoffA))
                %add all needed slots up, advance T to that time
        if((framesA(currentA) + backoffA) - (framesC(currentC) + backoffC) <= backoffA)
           backoffC = (framesA(currentA) + backoffA) - (framesC(currentC) + backoffC);
        end
    
        timePassed = difs + backoffC + frameSize + sifs + ack;
    
    	T = timePassed + framesC(currentC);
        currentC = currentC + 1;
        numPacketsCSent = numPacketsCSent + 1;
        backoffC = -1;
            
    else % if A and C are equal
        timePassed = difs + backoffA + frameSize + sifs + ack;
        backoffA = -1;
        backoffC = -1;
        if(CW < 1024)
           CW = CW*2;
        end
        T = timePassed + framesA(currentA);
    end
        
end