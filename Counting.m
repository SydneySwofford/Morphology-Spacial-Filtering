%Sydney Swofford
% Cell Counting using morphological processes

% Create structing element and read in image
structuringElement=strel("square",7);
cells=imread("cell.jpg", 'jpg');
figure(1), imshow(cells);

%convert to grayscale and binarize 
cell=rgb2gray(cells);
level=graythresh(cell);
BW=imbinarize(cell,level);
figure(2), imshow(BW);
imwrite(BW, 'bwBinarizeImage.png');

%dilate multiple times to get white cell spaces 
dilate1=imdilate(BW, structuringElement);
figure(3), imshow(dilate1);
imwrite(dilate1, 'firstDialtion.png');

dilate2=imdilate(dilate1, structuringElement);
figure(4), imshow(dilate2);
imwrite(dilate2, 'secondDilation.png');

dilate3=imdilate(dilate2, structuringElement);
figure(5), imshow(dilate3);
imwrite(dilate3, 'thirdDilation.png');

% Count number of cells in image
totalCells=bwconncomp(dilate3);
disp('Total Number of Cells in Image: ');
disp(totalCells); % we get 16

% Cell Boundriesof each cell overlayed on origional
[B,L]=bwboundaries(dilate3,'holes');
disp('The cell boundaries are: ');

figure(6),imshow(cells)
hold on
for k = 1:length(B)
   boundary = B{k};
   plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 2)
end
disp(B);
%https://www.mathworks.com/help/images/ref/bwboundaries.html#bu1wval-1-L


% Find the cell areas
areas=regionprops('table',totalCells, 'Area');
disp('The Cell Areas Are: ')
disp([areas.Area]);

%Isolate largest cell 
areasArray=areas.Area;
[maxArea, maxIndex] = max(areasArray);
largestCell = ismember(labelmatrix(totalCells), maxIndex);
figure(7), imshow(largestCell);
imwrite(largestCell, 'largestCell.png');

