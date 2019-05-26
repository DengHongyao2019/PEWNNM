   
   %             Function Name: hyDemo.m
   % =================================================
   %  It is available from the website at https://github.com/DengHongyao2019/PEWNNM
   % This is a main function. The parameters can be set in the function
   % called "hyParaSet.m". When you execute the program, 
   % you will see the PSNR/MSSIM results in Command Window and 
   % the visual results in a Figure Window. Meanwhile, the program records 
   % the PSNR results in the file called¡± PSNR.txt¡± and the MSSIM results
   % in the file called ¡°MSSIM.txt¡±. Besides, it saves the noise images and
   % the de-noised images in noiseImg folder and outputImg folder, respectively. 
   % The both folders are under the current work-path.
   % ----------------------------------------------------------------------------------------
  
   clear all; clc;
   warning off;
   DemoPath = dir('');
%    DemoFolder = DemoPath.folder;
   mkdir('outputImg'); mkdir('noiseImg');
   %outImgPath = strcat(DemoPath.folder, '\', 'outputImg', '\');
   outImgPath = strcat('.\\', 'outputImg', '\');
   %noiseImgPath = strcat(DemoPath.folder, '.\\', 'noiseImg', '\');
   noiseImgPath = strcat('.\\', 'noiseImg', '\');
   tic;
    para = hyParaSet();
    nSigma = para.nSigma;
    numJ = length(nSigma);
%     oriIm   =   double(imread(para.image)); % read image
    oriIm   =   imread(para.image);
    imshow(oriIm, []);
    title('The noise-free image, Cameraman','fontname','Times New Roman','Color','k','FontSize',16);
    
    oriIm = double(oriIm(1:100, 1:100));
    [imH, imW]  =   size(oriIm);
    figure; clf;
%     imshow(uint8(oriIm), []);
%     figure; clf;
%     image(reshape(oriIm, [imH imW]));
%     colormap(gray(256)); axis image; axis off;
    
    randn('seed', 0);
    fp1 = fopen('PSNR.txt','at+');
    fp2 = fopen('MSSIM.txt','at+');
    fprintf(fp1,'%-90s%6d%6d', para.image, para.step, para.numPoly);
    fprintf(fp2,'%-90s%6d%6d', para.image, para.step, para.numPoly);
    for k = 1:numJ
        fprintf('-%d  When the standard deviation of noise is %d, \n',k, para.nSigma(k));
        nSig = nSigma(k);
        noiseIm     =   oriIm + nSig * randn(size(oriIm));
        PSNR = hyCSNR(oriIm, noiseIm, 0, 0);
        MSSIM = hyMetricSSIM(oriIm, noiseIm, 0, 0);
        fprintf('    PSNR = %-5.2f,   MSSIM = %-5.2f, for Cameraman image with noise, \n', PSNR, MSSIM);
        
%         figure;clf;  imshow(uint8(noiseIm), []); 
        subplot(7,2,2*k-1); 
        imshow(uint8(noiseIm), []); hold on;   
        scrsz = get(0,'ScreenSize'); 
        set(gcf,'Position',scrsz);
        if k == 1
            title(['The left-column is the noise images'],'fontname','Arial', 'FontWeight','bold','Color','b','FontSize',14);
        end
        strPM = sprintf('PSNR=%-5.2f,  MSSIM=%-5.2f', PSNR, MSSIM);
        xlabel(strPM, 'Color','b');
%          image(uint8(noiseIm));     colormap(gray(256)); axis image; axis off; hold on; 
%         image(reshape(noiseIm, [imH imW]));
%         print('-djpeg', strcat('Osigma',num2str(nSig), '-step', num2str(para.step), '-order',num2str(para.numPoly), '.jpg'));
        imwrite(uint8(noiseIm), strcat('noiseImg\', 'Osigma',num2str(nSig), '-step', num2str(para.step), '-order',num2str(para.numPoly), '.tiff'));
        
        deNoiseIm = hyDenoising(noiseIm, oriIm, para);
        PSNR  = hyCSNR(oriIm, deNoiseIm, 0, 0);
        MSSIM = hyMetricSSIM(oriIm, deNoiseIm, 0, 0);
        fprintf('    PSNR = %-5.2f,   MSSIM = %-5.2f, for the estimated image. \n\n', PSNR, MSSIM);
        fprintf(fp1,'%7.2f',PSNR);
        fprintf(fp2,'%7.3f',MSSIM);
        
%         figure; clf;  imshow(uint8(deNoiseIm), []);
        subplot(7,2,2*k); 
        imshow(uint8(deNoiseIm), []); hold on;
        if k == 1
            title(['The right-column is the estimated images'],'fontname','Arial', 'FontWeight','bold', 'Color','r','FontSize',14);
        end
        strPM = sprintf('PSNR=%-5.2f,  MSSIM=%-5.2f', PSNR, MSSIM);
        xlabel(strPM, 'Color','r');
%         image(uint8(deNoiseIm));     colormap(gray(256)); axis image; axis off; hold on;
%         image(reshape(deNoiseIm, [imH imW]));
%         colormap(gray(256)); axis image; axis off;
%         print('-djpeg', strcat('sigma',num2str(nSig), '-step', num2str(para.step), '-order',num2str(para.numPoly), '.jpg'));
         
        imwrite(uint8(deNoiseIm), strcat('outputImg\', 'sigma',num2str(nSig), '-step', num2str(para.step), '-order',num2str(para.numPoly), '.tiff'));
    end
    
    fprintf(fp1,'\n');
    fprintf(fp2,'\n');
    fclose(fp1);
    fclose(fp2);
    % -------------------------------
% % %     deBarbara100 = uint8(deNoiseIm);
% % %     save Barbara100-1.mat deBarbara100
    % ------------------------------- 
    
    fprintf('\n\n --  The runtime for this execution is about %-0.4f minutes\n',toc/60);
 