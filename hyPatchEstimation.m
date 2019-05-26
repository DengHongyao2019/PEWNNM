function [evoPatchX, accumNum] = hyPatchEstimation(patchY, keyPatchArr, similarArr, cureFitPara, lineFitPara, firstPixel, para)

evoPatchX = zeros(size(patchY));
accumNum  = zeros(size(patchY));
L         = length(keyPatchArr);
numSimilarPatch = para.patchNum;

for i = 1:1:L
    similarPatches = patchY(:, similarArr(1:numSimilarPatch, i));
    meanSimiPatch  = 0; %repmat(mean(similarPatches, 2), 1, numSimilarPatch);
%     similarPatches = similarPatches - meanSimiPatch; 
    
    estSimilarPatch = hySimiPatchEstimating(similarPatches, meanSimiPatch, cureFitPara, lineFitPara, firstPixel, para);
    
    evoPatchX(:, similarArr(1:numSimilarPatch, i)) = evoPatchX(:, similarArr(1:numSimilarPatch, i)) + estSimilarPatch;
    accumNum(:, similarArr(1:numSimilarPatch, i))  = accumNum(:, similarArr(1:numSimilarPatch, i)) + ...
        ones(size(patchY, 1), size(similarArr(1:numSimilarPatch, i), 1));
end
return;


function estSimilarPatch = hySimiPatchEstimating(similarPatches, meanSimiPatch, cureFitPara, lineFitPara, firstPixel, para)

firstInd = firstPixel;
lastInd = para.patchSize.^2;
x = firstInd:1:lastInd;
slope = lineFitPara(2);
intercept = lineFitPara(1);
wRight = slope * x + repmat(intercept, size(x));
% wLeft = zeros(1, para.patchSize.^2 - length(x));
wLeft = polyval(cureFitPara, 1:firstInd -1);
weight = ([wLeft, wRight])';
weight = max(weight, 0);
[U, sigmaY, V] = svd(full(similarPatches),'econ');
tempSigmaX = diag(sigmaY) - weight;
tempSigmaX = tempSigmaX.*(tempSigmaX>=0);
sigmaX = diag(tempSigmaX);
% sigmaX = diag(max(diag(sigmaY)-weight, 0));
% sigmaX = sign(sigmaY).*max(abs(sigmaY) - diag(weight), 0);
estSimilarPatch = U*sigmaX*V' + meanSimiPatch;
return;