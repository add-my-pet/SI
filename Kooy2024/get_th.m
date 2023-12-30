function th = get_th(b_X, b_Y, k_E, k_YO)
  th_X = 1 / (1 + k_E / b_X + b_Y * k_E / b_X / k_YO + b_Y / (k_E + k_YO) * (1 + k_E / k_YO + k_E / b_X + k_E * b_Y / k_YO / b_X));
  th_0 = th_X * k_E / b_X * (1 + b_Y/ (k_E + k_YO));
  th_XY = th_X * b_Y/ (k_E + k_YO);
  th_Y = 1 - th_0 - th_X - th_XY;
  th = [th_0 th_X th_Y th_XY];
end