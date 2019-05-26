function [keypatSimilarArr] = hysimiArrBatch(X, Y, par, keypatchArr, simiArrBatch)

numkeyPatches = length(keypatchArr);
numSimiPatches = par.patnum;
[dimPatch, numPatches] = size(X); %#ok<*NASGU>
keypatSimilarArr = zeros(dimPatch, numSimiPatches, numkeyPatches);
for i = 1:1:numkeyPatches
    keypatSimilarArr(:,:,i,1) = X(:, simiArrBatch(1:numSimiPatches, i));
    keypatSimilarArr(:,:,i,2) = Y(:, simiArrBatch(1:numSimiPatches, i));
end
% save fsimiPathesY keypatSimilarArr;