%% Calculate a signal's eye diagram
%
% (c) 2021 Miguel Bazdresch <mxbiee@rit.edu>
%
% Calculate a signal's eye diagram.
%
% Input arguments:
%
% s      : signal
% M      : number of samples in a pulse interval
% neye   : how many eyes to include in diagram (default = 3)
% F      : starting sample (default = 1)
% N      : number of symbols to plot (default = as many as possible)
%
% Output
%
% P : a matrix whose columns correspond to each line in the diagram.

function P = geteyed(s, M, neye, F, N)
    % validate signal has enough samples
    if F+N*M > length(s)
        N = floor((length(s)-F)/M); % trim number of symbols to plot
    end

	x = s(F:N*M);
	c = floor(length(x)/(neye*M));
	xp = x(end-neye*M*c+1:end);
	P = reshape(xp,neye*M,c);
end
