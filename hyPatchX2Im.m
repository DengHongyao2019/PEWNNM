% ======================================================================
function evolutionIm = hyPatchX2Im(evoPatchX,accumNum,patchSize,imHeight,imWidth)

    tempR        =   imHeight-patchSize+1;
    tempC        =   imWidth-patchSize+1;
    tempOffsetR  =   [1:tempR];
    tempOffsetC  =   [1:tempC];    

    evolutionIm  	=  zeros(imHeight,imWidth);
    accumNumWeight 	=  zeros(imHeight,imWidth);
    k               =  0;
    for j = 1:patchSize
        for i = 1:patchSize
            k = k+1;
            evolutionIm(tempOffsetR-1+i,tempOffsetC-1+j)  =  evolutionIm(tempOffsetR-1+i,tempOffsetC-1+j) + reshape( evoPatchX(k,:)', [tempR tempC]);
            accumNumWeight(tempOffsetR-1+i,tempOffsetC-1+j)  =  accumNumWeight(tempOffsetR-1+i,tempOffsetC-1+j) + reshape( accumNum(k,:)',  [tempR tempC]);
        end
    end
    evolutionIm  =  evolutionIm./(accumNumWeight+eps);

