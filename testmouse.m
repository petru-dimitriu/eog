import java.awt.Robot;
mouse = Robot;

Robot.mouseMove(0, 0);
screenSize = get(0, 'screensize');
for i = 1: screenSize(4)
    mouse.mouseMove(i, i);
    pause(0.00001);
end
