DataCorrection;
load Data_1.mat;

% Data Input
%-----------------------    
Lens_Pos_rec		= Data_1(1).Reading - OffsetLens;
Lens_Pos		= SIConv(Lens_Pos_rec,'milli');
%
Image_Pos_rec		= Data_1(2).Reading + OffsetScreen;
Image_Pos		= SIConv(Image_Pos_rec,'milli');
Image_Pos_m		= mean(Image_Pos,2);
Image_Disp		= Image_Pos_m - Lens_Pos;
%
ImageSize_rec		= Data_1(3).Reading;
ImageSize		= SIConv(ImageSize_rec,'milli');
ImageSize_m		= mean(ImageSize,2);
% Magnification
ObjectSize_rec		= 20;
ObjectSize		= SIConv(ObjectSize_rec,'milli');
Magnification		= -ImageSize_m/ObjectSize;


% Error
%-----------------------    
eImage			= SIConv(eOffScreen_rec,'milli');
eImage_fit		= InpError(Image_Disp,eImage,'abs');
eObjectSize		= SIConv(0.5,'milli');
eMagnif			= CombiError(ImageSize_m,eImage_fit,ObjectSize,eObjectSize,'/');


% Graph
%-----------------------
GraphSettings(Image_Disp,0.1,Magnification,0.5);
errorsquare(Image_Disp,eImage_fit,Magnification,eMagnif,'default');
LinDataFit(Image_Disp,eImage_fit,Magnification,eMagnif);
ax = gca;
ax.YLim = [ax.YLim(1), -1];
ax.XAxisLocation 	= 'top';
