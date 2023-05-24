X=X;
D=D;      
W1 = 2*rand(100, 30) - 1;
W2 = 2*rand(50, 100) - 1;
W3 = 2*rand(17, 50) - 1;

for epoch = 1:300           % train
  Alpha = 0.5;
  
  
  for k2 = 1:340
    x = X(:, k2);
    d = D(:,k2);
    
    v1 = W1*x;
    y1 = Sigmoid(v1);

    v2 = W2*y1;
    y2 = Sigmoid(v2);

    v  = W3*y2;
    y  = Softmax(v);
    
    e     = d - y;
    delta = e;

    e1     = W3'*delta;
    delta1 = y2.*(1-y2).*e1; 
    
    e2     = W2'*delta1;
    delta2 = y1.*(1-y1).*e2;
    
    dW1 = Alpha*delta2*x';
    W1 = W1 + dW1;
    
    dW2 = Alpha*delta1*y1';   
    W2 = W2 + dW2;
    
    dW3 = Alpha*delta*y2';   
    W3 = W3 + dW3;
  end
end

                       % inference
for k = 1:21025
  x = P(:, k);
  v1 = W1*x;
  y1 = Sigmoid(v1);
  v2 = W2*y1;
  y2 = Sigmoid(v2);
  v  = W3*y2;
  y  = Softmax(v);
  Z(:,k)=y;
end