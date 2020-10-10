lambda(1) = 200;
lambda(2) = 300;
lambda(3) = 500;
lambda(4) = 1000;
lambda(5) = 2000;

numAPackets1(1) = 2023;
numAPackets1(2) = 3009;
numAPackets1(3) = 5055;
numAPackets1(4) = 9962;
numAPackets1(5) = 19624;

numCPackets1(1) = 1952;
numCPackets1(2) = 3039;
numCPackets1(3) = 5058;
numCPackets1(4) = 9929;
numCPackets1(5) = 19891;

numCollisions1(1) = 5;
numCollisions1(2) = 7;
numCollisions1(3) = 21;
numCollisions1(4) = 110;
numCollisions1(5) = 421;

throA1 = numAPackets1 * 1500 * 8 / 10;
throC1 = numCPackets1 * 1500 * 8 / 10;
fair1 = (numAPackets1./numCPackets1);


numAPackets2(1) = 1969;
numAPackets2(2) = 2974;
numAPackets2(3) = 4926;
numAPackets2(4) = 9764;
numAPackets2(5) = 19893;

numCPackets2(1) = 2005;
numCPackets2(2) = 3002;
numCPackets2(3) = 4964;
numCPackets2(4) = 10026;
numCPackets2(5) = 19958;

numCollisions2(1) = 4;
numCollisions2(2) = 9;
numCollisions2(3) = 41;
numCollisions2(4) = 107;
numCollisions2(5) = 412;

throA2 = numAPackets2 * 1500 * 8 / 10;
throC2 = numCPackets2 * 1500 * 8 / 10;
fair2 = (numAPackets2./numCPackets2);



numAPackets3(1) = 1909;
numAPackets3(2) = 2982;
numAPackets3(3) = 5046;
numAPackets3(4) = 9889;
numAPackets3(5) = 19757;

numCPackets3(1) = 2047;
numCPackets3(2) = 2958;
numCPackets3(3) = 5037;
numCPackets3(4) = 9731;
numCPackets3(5) = 19680;

numCollisions3(1) = 1855;
numCollisions3(2) = 3649;
numCollisions3(3) = 8808;
numCollisions3(4) = 20556;
numCollisions3(5) = 35055;


throA3 = numAPackets3 * 1500 * 8 / 10;
throC3 = numCPackets3 * 1500 * 8 / 10;
fair3 = (numAPackets3./numCPackets3);


numAPackets4(1) = 1973;
numAPackets4(2) = 2948;
numAPackets4(3) = 5026;
numAPackets4(4) = 9906;
numAPackets4(5) = 19819;

numCPackets4(1) = 1988;
numCPackets4(2) = 3029;
numCPackets4(3) = 4860;
numCPackets4(4) = 9870;
numCPackets4(5) = 19777;

numCollisions4(1) = 24;
numCollisions4(2) = 75;
numCollisions4(3) = 192;
numCollisions4(4) = 848;
numCollisions4(5) = 3179;

throA4 = numAPackets4 * 1500 * 8 / 10;
throC4 = numCPackets4 * 1500 * 8 / 10;
fair4 = (numAPackets4./numCPackets4);





set(0,'defaulttextinterpreter','latex');
set(0,'defaultlinelinewidth',2); 
set(0,'DefaultLineMarkerSize',10);
set(0,'DefaultTextFontSize', 16);
set(0,'DefaultAxesFontSize',16);

figure(1)
plot(lambda,throA1,'-bo',lambda,throA2,'-rs',lambda,throA3,'-c+',lambda,throA4,'-g*');
grid on;
legend('Single Domain CSMA', 'Single Domain CSMA w.  virtual Sensing', 'Hidden Terminals CSMA', 'Hidden Terminals CSMA w.  virtual Sensing');
title('Throughput of Node A');
ylabel('$T$ (Kbps)');
xlabel('lambda (frames/sec)');

figure(2)
plot(lambda,throC1,'-bo',lambda,throC2,'-rs',lambda,throC3,'-c+',lambda,throC4,'-g*');
grid on;
legend('Single Domain CSMA', 'Single Domain CSMA w.  virtual Sensing', 'Hidden Terminals CSMA', 'Hidden Terminals CSMA w.  virtual Sensing');
title('Throughput of Node C');
ylabel('$T$ (Kbps)');
xlabel('lambda (frames/sec)');

figure(3)
plot(lambda,numCollisions1,'-bo',lambda,numCollisions2,'-rs',lambda,numCollisions3,'-c+',lambda,numCollisions4,'-g*');
grid on;
legend('Single Domain CSMA', 'Single Domain CSMA w.  virtual Sensing', 'Hidden Terminals CSMA', 'Hidden Terminals CSMA w.  virtual Sensing');
title('Collisions');
ylabel('$T$ (Kbps)');
xlabel('lambda (frames/sec)');

figure(4)
plot(lambda,fair1,'-bo',lambda,fair2,'-rs',lambda,fair3,'-c+',lambda,fair4,'-g*');
grid on;
legend('Single Domain CSMA', 'Single Domain CSMA w.  virtual Sensing', 'Hidden Terminals CSMA', 'Hidden Terminals CSMA w.  virtual Sensing');
title('Fairness Index (NodeA/NodeC)');
ylabel('$T$ (Kbps)');
xlabel('lambda');
