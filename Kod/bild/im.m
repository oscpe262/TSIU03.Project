% M = im(cmds,fn)
% * cmds is a commaseparated string of the commands:
%   * 'loadPNG'
%   * 'savePNG'
%   * 'loadBin'
%   * 'saveBin'
%   * 'n,saveBin' - where n is a number '0' to '255' - fill rest of ROM with value n
%                   (default: Do not fill. The file ends after the picture);
%   * 'show' - plot the image.
%   * 'setM' - load fn as the internal image (as return by M).
%   Default is 'loadPNG,saveBin'
% * fn is a file name, excluding file extension.
%   Default file name is "HaveYouPassed"
% * M is the internal image. A 640x480 matrix with integers 0-255
% 
% This version handles the following colors (each pixel in M is eight bits, indexed 7..0):
% bit7 = 0: Grayscale
% * bit[6..0] = grayscale
% bit7 = 1: Color
% * bit[6..5] = red
% * bit[4..2] = green
% * bit[1..0] = blue
function M = im(cmds,fn)
  if nargin < 2, fn = 'BILD6'; end
  if nargin < 1, cmds = 'loadPNG,saveBin'; end
  persistent Mint % keep this value between the calls
  cmds = cmds(cmds~=' '); % remove blanks
  fix = [0, find(cmds == ','), length(cmds)+1];
  % Ex: cmds = 'loadPNG,saveBin'
  % => fix = [0 8 16]
  n = -1;
  for i=1:length(fix)-1
    cmd = cmds((fix(i)+1):fix(i+1)-1); % => 1:7, then 9:15
    switch lower(cmd)
      case 'loadpng', Mint = loadPNG(fn);
      case 'savepng', savePNG(Mint,fn);
      case 'loadbin', Mint = loadBin(fn);
      case 'savebin', saveBin(Mint,fn,n);
      case 'show', show(Mint);
      case 'setm', Mint = fn;
      otherwise
        if '0' <= cmd(1) && cmd(1) <= '9'
          n = eval(cmd);
        else
          fprintf(2,'Error: ''%s'' is an invalid command. Aborting.\n', cmd);
          if nargout, M = Mint; end
          return
        end
    end
  end
  if nargout, M = Mint; end
end

function M = loadPNG(fn)
  M = rgb2ind(imread([fn '.png']),get_cmap(),'nodither');
end

function savePNG(M,fn)
  imwrite(M,get_cmap(), [fn '.png'],'png')
end

function M = loadBin(fn)
  fp = fopen([fn '.bin'],'r');
  M = uint8(fread(fp));
  fclose(fp);
  M = reshape(M(1:640*480),640,480)';
end

function saveBin(M,fn,n)
  assert(isa(M,'uint8') && numel(M)==640*480, 'im:saveBin:M_error', 'Error in M: Wrong size or format');
  M = M'; M = M(:)';   % read in row order, make column vector
  if n>=0
    M(end+1:2^22) = n;     % extend with value n up to 4 MiB
  end
  fp = fopen([fn '.bin'],'w');
  fwrite(fp,M);
  fclose(fp);
end

function show(M)
  colormap(get_cmap());
  image(M);
  axis equal; % make the pixels square
end

function cmap = get_cmap()
  persistent mymap;
  if isempty(mymap)
    mymap = zeros([256,3]);
    % Generate grayscale part:
    gray = linspace(0,1,128)';
    mymap(1:128,:) = [gray gray gray];
    % Generate RGB part:
    R=linspace(0, 1, 4)';
    G=linspace(0, 1, 8)';
    B=linspace(0, 1, 4)';
    ix=(0:127)';
    mymap(129:256,1) = R(1+mod(floor(ix/32),4)); % Red
    mymap(129:256,2) = G(1+mod(floor(ix/4),8)); % Green
    mymap(129:256,3) = B(1+mod(floor(ix/1),4)); % Blue
  end
  cmap = mymap;
end
% bit7 = 0: Grayscale
% * bit[6..0] = grayscale
% bit7 = 1: Color
% * bit[6..5] = red
% * bit[4..2] = green
% * bit[1..0] = blue

