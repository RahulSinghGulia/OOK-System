%% Obtain a signal's spectrum
%
% (c) 2021 Miguel Bazdresch <mxbiee@rit.edu>
%
% Calculate the spectrum of a signal and the corresponding frequency vector.
%
% input arguments:
%
% x   : signal
% Ts  : sampling period (real > 0, default = 0.5)
% pad : padding factor (will use `pad*length(x)` samples, default 10)

function [m, f] = getspectrum(x, Ts, pad)
    % set default values
    if nargin < 3
        pad = 10;
    end
    if nargin < 2
        Ts = 0.5;
    end

    N = pad*length(x);        % FFT size
	f = (-N/2:N/2-1)/(N*Ts);  % frequency vector
	fx = fftshift(fft(x,N));
	m = abs(fx);              % magnitude spectrum
end
