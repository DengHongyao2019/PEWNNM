function PSNR = hyCSNR(oriIm,noiseIm,firstRow,firstCol)

[imH,imW,imD]=size(oriIm);

if imD == 1
   imError = oriIm - noiseIm;
   imError = imError(firstRow+1:imH-firstRow, firstCol+1:imW-firstCol);
   imMSE   = mean(mean(imError.^2));
   PSNR    = 10 * log10( 255^2 / imMSE );
else
   imError = oriIm-noiseIm;
   imError = imError(firstRow+1:imH-firstRow, firstCol+1:imW-firstCol,:);
   e1=imError(:,:,1);e2=imError(:,:,2);e3=imError(:,:,3);
   me1=mean(mean(e1.^2));
   me2=mean(mean(e2.^2));
   me3=mean(mean(e3.^2));
   mse=(me1+me2+me3)/3;
   PSNR  = 10*log10(255^2/mse);
%    PSNR(1)=10*log10(255^2/me1);
%    PSNR(2)=10*log10(255^2/me2);
%    PSNR(3)=10*log10(255^2/me3);
end


return;