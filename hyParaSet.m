function  [para] = hyParaSet( )
% ==========================

% 
    getDemoFile = dir('hyDemo.m');
%    DemoFolder = getDemoFile.folder;
%    para.image = strcat(DemoFolder, '\images\','Cameraman256.png'); % original image
    para.image = strcat( '.\images\','Cameraman256.png'); % original image
%     para.nSigma = [10];
    para.nSigma = [10,20,30,40,50,75,100]; % noise deviation
    para.iter  = 10; % maximum number of iterations
    para.delta = 0.1; % The scaled factor 
    para.thrNum = 30; % The threshold that controls the cut-off point, theta.
    para.numPoly = 9; % [1 2 5 7 8 9] , order of polynomial
    para.patchSize   =   12; % non-locak similar patch size
    para.patchNum    =   para.patchSize.^2; % ROSM size
    para.step        =   2; % [1 2 3], Lower sampling step size
end
