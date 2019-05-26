function deNoiseIm = hyDenoising(noiseIm, oriIm, para)

evolutionIm = noiseIm;
[imHight, imWidth] = size(noiseIm);
patchSize   = para.patchSize;
patchX      = im2col(oriIm, [patchSize patchSize], 'sliding');
keyPatchArr = int32(hykeyPatchArr(noiseIm, para));

fp1 = fopen('hytestLater.txt','at+');
fprintf(fp1,'\n');
for i = 1:para.iter %while(iter ~= 0) %1:para.iter
    PSNR0  = hyCSNR(oriIm, evolutionIm, 0, 0);
    tempEvolutionIm = evolutionIm;
    evolutionIm = evolutionIm + para.delta * (noiseIm - evolutionIm);
    nSigma = sqrt(mean(mean((evolutionIm - oriIm).^2)));
    patchY        = im2col(evolutionIm, [patchSize patchSize], 'sliding');
    simiArrBatch  = hyBlockMatching(patchY, keyPatchArr, para.patchNum);
    
    [cureFitPara, lineFitPara, firstPixel] = hyTrainingPara(patchX, patchY, keyPatchArr, simiArrBatch, nSigma, para);
    
    [evoPatchX, accumNum] = hyPatchEstimation(patchY, keyPatchArr, simiArrBatch, cureFitPara, lineFitPara, firstPixel, para);
    evolutionIm = hyPatchX2Im(evoPatchX, accumNum, patchSize, imHight, imWidth);
    PSNR  = hyCSNR(oriIm, evolutionIm, 0, 0);
    fprintf(fp1, '%13s%6d%6d%7d%7.2f%7.2f\n', para.image, para.step, para.numPoly, i, PSNR0, PSNR); 
    if(PSNR<0 || PSNR-PSNR0<=0.3)
        break;
    end
end
fprintf(fp1, '\n');
fclose(fp1);
deNoiseIm = tempEvolutionIm;

return;
