% srrcpulse.m
%
% (c) 2021 Miguel Bazdresch <mxbiee@rit.edu>
%
% Create a square-root raised-cosine pulse. The energy is normalized to
% one.
%
% input arguments:
%
%    beta = rolloff factor
%    T = pulse (symbol) interval
%    ts = sampling interval
%    rip: number of ripples on each side
%
% outputs:
%
%    p = pulse samples
%    t = time vector that corresponds to the pulse
%
% references:
%  Telecommunication breakdown, pages 217 and 225
%  http://www.dsplog.com/2008/04/22/raised-cosine-filter-for-transmit-pulse-shaping/
%  http://en.wikipedia.org/wiki/Root-raised-cosine_filter

function [p, t] = srrcpulse(beta, T, ts, rip)

if nargin < 4
    error('Error: At least four arguments are needed.');
end

% Tp must be an integer multiple of Ts
if abs(round(T/ts) - T/ts) > 1e-6
	error('Error: Tp must be an integer multiple of Ts');
end

%%% time vector
t = -rip*T:ts:rip*T;

% square-root raised cosine pulse
% it is calculated in three parts: negative time, 0, positive time
t1 = -rip*T:ts:-ts;
t2 = ts:ts:rip*T;

x1 = pi*(1-beta)*t1/T;
x2 = pi*(1+beta)*t1/T;
x3 = 4*beta*t1/T;
num = sin(x1)+x3.*cos(x2);
den = sqrt(T).*(pi*t1./T).*(1-x3.^2);
p1 = num./den;
p1(abs(den)<1e-9)=(beta/sqrt(2*T))* ...
    ((1+2/pi)*sin(pi/(4*beta))+(1-2/pi)*cos(pi/(4*beta)));

p2 = 1/sqrt(T)*(1-beta+4*beta/pi);

x1 = pi*(1-beta)*t2/T;
x2 = pi*(1+beta)*t2/T;
x3 = 4*beta*t2/T;
num = sin(x1)+x3.*cos(x2);
den = sqrt(T).*(pi*t2./T).*(1-x3.^2);
p3 = num./den;
p3(abs(den)<1e-9)=(beta/sqrt(2*T))* ...
    ((1+2/pi)*sin(pi/(4*beta))+(1-2/pi)*cos(pi/(4*beta)));

pp = [p1 p2 p3];

% energy normalization
p = pp./sqrt(sum(pp.*pp));

end