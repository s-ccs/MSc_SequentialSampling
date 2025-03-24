import pygame
import random
import sys

# Initialize Pygame
pygame.init()

# Screen dimensions and settings
SCREEN_WIDTH, SCREEN_HEIGHT = 800, 600
DOT_COUNT = 200
COHERENCE_LEVEL = 0.3  # Fraction of dots moving coherently
DOT_SPEED = 2
DOT_RADIUS = 2
CENTER_RADIUS = 200  # Radius of the central ball of dots
FPS = 60

# Colors
WHITE = (255, 255, 255)
BLACK = (0, 0, 0)
BLUE = (0, 0, 200)
GRAY = (50, 50, 50)

# Initialize screen
screen = pygame.display.set_mode((SCREEN_WIDTH, SCREEN_HEIGHT))
pygame.display.set_caption("Random Dot Motion Task")
clock = pygame.time.Clock()

def reset_task():
    global dots, direction
    direction = random.choice([-1, 1])  # -1 for left, 1 for right
    dots = [Dot() for _ in range(DOT_COUNT)]

# Dot class
class Dot:
    def __init__(self):
        # Generate dots within the central ball area
        self.x = random.randint(SCREEN_WIDTH // 2 - CENTER_RADIUS, SCREEN_WIDTH // 2 + CENTER_RADIUS)
        self.y = random.randint(SCREEN_HEIGHT // 2 - CENTER_RADIUS, SCREEN_HEIGHT // 2 + CENTER_RADIUS)
        self.coherent = random.random() < COHERENCE_LEVEL

    def update(self):
        if self.coherent:
            self.x += DOT_SPEED * direction
        else:
            self.x += random.randint(-1, 1) * DOT_SPEED
            self.y += random.randint(-1, 1) * DOT_SPEED

        # Wrap around within the central ball area
        if self.x > SCREEN_WIDTH // 2 + CENTER_RADIUS:
            self.x = SCREEN_WIDTH // 2 - CENTER_RADIUS
        elif self.x < SCREEN_WIDTH // 2 - CENTER_RADIUS:
            self.x = SCREEN_WIDTH // 2 + CENTER_RADIUS
        if self.y > SCREEN_HEIGHT // 2 + CENTER_RADIUS:
            self.y = SCREEN_HEIGHT // 2 - CENTER_RADIUS
        elif self.y < SCREEN_HEIGHT // 2 - CENTER_RADIUS:
            self.y = SCREEN_HEIGHT // 2 + CENTER_RADIUS

    def draw(self):
        pygame.draw.circle(screen, BLACK, (int(self.x), int(self.y)), DOT_RADIUS)

# Create initial dots and direction
reset_task()

# Circles for left and right responses
circle_left = (100, SCREEN_HEIGHT // 2)
circle_right = (SCREEN_WIDTH - 100, SCREEN_HEIGHT // 2)
circle_radius = 30

# Game loop
while True:
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            pygame.quit()
            sys.exit()
        elif event.type == pygame.MOUSEBUTTONDOWN:
            mouse_pos = pygame.mouse.get_pos()
            if (mouse_pos[0] - circle_left[0])**2 + (mouse_pos[1] - circle_left[1])**2 <= circle_radius**2:
                print("You clicked LEFT")
                reset_task()
            elif (mouse_pos[0] - circle_right[0])**2 + (mouse_pos[1] - circle_right[1])**2 <= circle_radius**2:
                print("You clicked RIGHT")
                reset_task()
        elif event.type == pygame.KEYDOWN:
            if event.key == pygame.K_LEFT:
                print("You pressed LEFT")
            elif event.key == pygame.K_RIGHT:
                print("You pressed RIGHT")

    # Update dots
    screen.fill(WHITE)
    for dot in dots:
        dot.update()
        dot.draw()

    # Draw circles
    pygame.draw.circle(screen, BLUE, circle_left, circle_radius)
    pygame.draw.circle(screen, BLUE, circle_right, circle_radius)

    # Add circle labels
    font = pygame.font.Font(None, 36)
    text_left = font.render("L", True, WHITE)
    text_right = font.render("R", True, WHITE)
    screen.blit(text_left, (circle_left[0] - 10, circle_left[1] - 10))
    screen.blit(text_right, (circle_right[0] - 10, circle_right[1] - 10))

    pygame.display.flip()
    clock.tick(FPS)
