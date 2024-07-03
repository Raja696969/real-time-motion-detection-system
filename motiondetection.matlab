% Create a video reader object
videoFile = 'motion5.mp4';
videoReader = VideoReader(videoFile);

% Read the first frame as the background
background = readFrame(videoReader);

% Define threshold for detecting motion
threshold = 30;

% Main loop for processing each frame
while hasFrame(videoReader)
    % Read current frame
    currentFrame = readFrame(videoReader);
    
    % Compute absolute difference between current frame and background
    diffFrame = abs(rgb2gray(currentFrame) - rgb2gray(background));
    
    % Apply threshold to identify motion regions
    motionMask = diffFrame > threshold;
    
    % Perform blob analysis to detect connected regions
    blobAnalysis = regionprops(motionMask, 'BoundingBox', 'Area');
    
    % Display original frame with detected motion regions
    figure;
    imshow(currentFrame);
    hold on;
    for i = 1:numel(blobAnalysis)
        rectangle('Position', blobAnalysis(i).BoundingBox, 'EdgeColor', 'r', 'LineWidth', 2);
    end
    hold off;
    
    % Update background for next iteration
    background = 0.9 * background + 0.1 * currentFrame;
end
