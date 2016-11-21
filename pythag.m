function [xn,k] = pythag(x,y,d,noprnt)
%PYTHAG    Pythagorean sum in variable precision arithmetic.
%    p = PYTHAG(x,y,d) computes the Pythagorean sum
%    sqrt(x^2+y^2) of the real numbers x and y correct to about d
%    significant digits, using an iteration that avoids computing 
%    square roots.  d defaults to 50.
%    By default, the progress of the iteration is printed;
%    the call PYTHAG(x,y,d,1) suppresses this.
%    [x,k] = PYTHAG(x,y,d) returns also the number of
%    iterations, k.

narginchk(2,4)    % Check number of input arguments.
if nargin < 4, noprnt = 0; end
if nargin < 3, d = 50; end

d_old = digits;
% Work with slightly more accuracy than requested for final result.
digits(d+10)
x = abs(vpa(x)); y = abs(vpa(y));

xn = max(x,y); % Take max since xn increases to Pyth. sum.
yn = min(x,y);

k = 0;
x_change = 0;

while abs(x_change) < d
      k = k +1;
      yn2 = yn^2;
      temp = yn2/(4*xn^2+yn2);
      xnp1 = xn*(1 + 2*temp);
      ynp1 = yn*temp;
      x_change = double( log10(abs((xnp1-xn)/xnp1)) );
      y_exp = double( log10(ynp1) );
      if ~noprnt
        fprintf('log(rel_change_x_n): %6.0f, log(y_n): %6.0f\n', ...
                 x_change, y_exp)
      end
      xn = xnp1; yn = ynp1;
end
xn = vpa(xn,d); % Return requested number of digits.
digits(d_old)   % Restore original value.
