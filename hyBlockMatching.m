% =====================================================================
function  [similarIdxArr] = hyBlockMatching(X, keypatchArr, patchNum)
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
L               =  length(keypatchArr);
M               =  size(X,2);
similarIdxArr   =  int32(zeros(patchNum, L));
indX            =  int32((1:M)');

h = waitbar(0, 'The similar Measurement');
for  i  =  1 : L
    waitbar(i/L);
    Patch               = X(:,keypatchArr(i));
    Dist                = sum((repmat(Patch,1,M) - X).^2);    
    [val, index]          = sort(Dist);
    similarIdxArr(:,i)	= indX(index(1:patchNum)');
end
close(h);

