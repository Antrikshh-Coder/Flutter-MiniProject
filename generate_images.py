import os
from PIL import Image, ImageDraw, ImageFont, ImageFilter

output_dir = "/Users/antriksh.manwadkar/ShopEase/assets/images"
os.makedirs(output_dir, exist_ok=True)

W, H = 400, 400

def create_base_canvas(bg_gradient):
    img = Image.new("RGBA", (W, H), (255, 255, 255, 0))
    draw = ImageDraw.Draw(img)
    # Background rounded rectangle card with subtle gradient fill
    c1, c2 = bg_gradient
    for y in range(H):
        t = y / H
        r = int(c1[0] * (1 - t) + c2[0] * t)
        g = int(c1[1] * (1 - t) + c2[1] * t)
        b = int(c1[2] * (1 - t) + c2[2] * t)
        draw.line([(0, y), (W, y)], fill=(r, g, b, 255))
    return img, draw

# 1. Headphones
def make_headphones():
    img, draw = create_base_canvas(((238, 242, 255), (224, 231, 255)))
    # Outer glow / aura
    draw.ellipse((80, 80, 320, 320), fill=(99, 102, 241, 30))
    # Headband arc
    draw.arc((100, 70, 300, 270), start=180, end=0, fill=(30, 41, 59), width=24)
    # Inner headband pad
    draw.arc((110, 80, 290, 260), start=180, end=0, fill=(79, 70, 229), width=10)
    # Left Ear Cup
    draw.rounded_rectangle((75, 170, 145, 280), radius=25, fill=(30, 41, 59))
    draw.rounded_rectangle((85, 180, 140, 270), radius=18, fill=(79, 70, 229))
    draw.rounded_rectangle((95, 190, 135, 260), radius=12, fill=(99, 102, 241))
    # Right Ear Cup
    draw.rounded_rectangle((255, 170, 325, 280), radius=25, fill=(30, 41, 59))
    draw.rounded_rectangle((260, 180, 315, 270), radius=18, fill=(79, 70, 229))
    draw.rounded_rectangle((265, 190, 305, 260), radius=12, fill=(99, 102, 241))
    # Metal accents
    draw.rectangle((105, 160, 115, 180), fill=(203, 213, 225))
    draw.rectangle((285, 160, 295, 180), fill=(203, 213, 225))
    # Sound waves
    for offset in range(3):
        draw.arc((30 + offset*10, 190 - offset*10, 70 + offset*10, 260 + offset*10), start=120, end=240, fill=(79, 70, 229, 180), width=3)
        draw.arc((330 - offset*10, 190 - offset*10, 370 - offset*10, 260 + offset*10), start=300, end=60, fill=(79, 70, 229, 180), width=3)
    return img

# 2. Smart Watch
def make_smartwatch():
    img, draw = create_base_canvas(((240, 253, 250), (204, 251, 241)))
    # Straps
    draw.rectangle((145, 20, 255, 110), fill=(30, 41, 59))
    draw.rectangle((145, 290, 255, 380), fill=(30, 41, 59))
    # Strap texture grooves
    for y in range(30, 100, 12):
        draw.line([(155, y), (245, y)], fill=(51, 65, 85), width=3)
    for y in range(300, 370, 12):
        draw.line([(155, y), (245, y)], fill=(51, 65, 85), width=3)
    # Watch Case shadow
    draw.rounded_rectangle((115, 95, 285, 305), radius=35, fill=(15, 23, 42))
    # Outer Bezel Metallic
    draw.rounded_rectangle((120, 100, 280, 300), radius=30, fill=(71, 85, 105))
    # Screen Frame
    draw.rounded_rectangle((130, 110, 270, 290), radius=22, fill=(15, 23, 42))
    # AMOLED Screen
    draw.rounded_rectangle((135, 115, 265, 285), radius=18, fill=(13, 148, 136))
    # Watch face graphics
    draw.text((160, 130), "10:42", fill=(255, 255, 255))
    draw.text((165, 155), "MON 14", fill=(153, 246, 228))
    # Heart rate graph line
    pts = [(145, 220), (165, 220), (175, 195), (185, 240), (195, 205), (205, 225), (215, 220), (255, 220)]
    draw.line(pts, fill=(244, 63, 94), width=4)
    # Activity Ring
    draw.arc((165, 225, 235, 275), start=0, end=270, fill=(250, 204, 21), width=6)
    draw.arc((173, 233, 227, 267), start=0, end=190, fill=(6, 182, 212), width=5)
    # Side Button Crown
    draw.rounded_rectangle((280, 170, 292, 210), radius=4, fill=(148, 163, 184))
    return img

# 3. Smartphone
def make_smartphone():
    img, draw = create_base_canvas(((245, 245, 245), (226, 232, 240)))
    # Phone Body Shadow / Frame
    draw.rounded_rectangle((110, 40, 290, 360), radius=32, fill=(15, 23, 42))
    # Outer Metallic Border
    draw.rounded_rectangle((114, 44, 286, 356), radius=28, fill=(100, 116, 139))
    # Screen Display
    draw.rounded_rectangle((120, 50, 280, 350), radius=24, fill=(79, 70, 229))
    # Screen Gradient Wallpaper
    for y in range(54, 346):
        t = (y - 54) / 292
        r = int(99 * (1 - t) + 236 * t)
        g = int(102 * (1 - t) + 72 * t)
        b = int(241 * (1 - t) + 153 * t)
        draw.line([(124, y), (276, y)], fill=(r, g, b))
    # Notch / Camera Island
    draw.rounded_rectangle((170, 60, 230, 76), radius=8, fill=(15, 23, 42))
    draw.ellipse((176, 64, 184, 72), fill=(30, 41, 59))
    # App Icons on screen
    colors = [(239, 68, 68), (16, 185, 129), (245, 158, 11), (6, 182, 212), (139, 92, 246), (236, 72, 153)]
    idx = 0
    for row in range(3):
        for col in range(2):
            cx = 160 + col * 80
            cy = 120 + row * 60
            draw.rounded_rectangle((cx-18, cy-18, cx+18, cy+18), radius=10, fill=colors[idx % len(colors)])
            idx += 1
    # Home bar
    draw.rounded_rectangle((170, 335, 230, 340), radius=3, fill=(255, 255, 255, 200))
    return img

# 4. Laptop
def make_laptop():
    img, draw = create_base_canvas(((248, 250, 252), (226, 232, 240)))
    # Open Screen Box
    draw.rounded_rectangle((60, 60, 340, 260), radius=16, fill=(30, 41, 59))
    draw.rounded_rectangle((68, 68, 332, 252), radius=10, fill=(15, 23, 42))
    # Display wallpaper code window
    draw.rounded_rectangle((74, 74, 326, 246), radius=6, fill=(24, 24, 27))
    # Code lines visual
    lines = [
        ((85, 90, 140, 90), (99, 102, 241)),
        ((150, 90, 210, 90), (236, 72, 153)),
        ((95, 110, 180, 110), (16, 185, 129)),
        ((95, 130, 250, 130), (245, 158, 11)),
        ((110, 150, 200, 150), (6, 182, 212)),
        ((85, 180, 160, 180), (239, 68, 68)),
        ((170, 180, 280, 180), (168, 85, 247)),
    ]
    for (x1, y1, x2, y2), col in lines:
        draw.line([(x1, y1), (x2, y2)], fill=col, width=6)
    # Webcam notch
    draw.ellipse((196, 62, 204, 70), fill=(71, 85, 105))
    # Base / Keyboard deck
    draw.polygon([(40, 260), (360, 260), (380, 310), (20, 310)], fill=(203, 213, 225))
    draw.polygon([(20, 310), (380, 310), (380, 320), (20, 320)], fill=(148, 163, 184))
    # Keyboard area
    draw.polygon([(70, 268), (330, 268), (345, 295), (55, 295)], fill=(51, 65, 85))
    # Trackpad
    draw.polygon([(160, 298), (240, 298), (245, 310), (155, 310)], fill=(148, 163, 184))
    return img

# 5. Sports Shoes
def make_shoes():
    img, draw = create_base_canvas(((253, 242, 248), (251, 207, 232)))
    # Sole outline
    draw.polygon([(50, 270), (120, 280), (280, 285), (350, 275), (360, 250), (340, 240), (270, 250), (100, 250), (50, 250)], fill=(255, 255, 255))
    # Cushion Air sole
    draw.rounded_rectangle((60, 250, 340, 285), radius=15, fill=(236, 72, 153))
    # Bottom tread
    draw.rounded_rectangle((55, 275, 345, 290), radius=8, fill=(30, 41, 59))
    # Shoe upper body
    draw.polygon([(80, 250), (130, 180), (210, 140), (280, 180), (330, 230), (340, 250)], fill=(219, 39, 119))
    # Mesh texture overlays
    draw.polygon([(140, 185), (200, 155), (260, 185), (310, 235), (120, 235)], fill=(190, 24, 93))
    # Swoosh / Stripe
    pts = [(120, 230), (190, 200), (280, 180), (220, 220), (150, 235)]
    draw.polygon(pts, fill=(255, 255, 255))
    # Laces
    for i in range(4):
        x = 170 + i * 20
        y = 160 + i * 12
        draw.line([(x, y), (x + 25, y - 10)], fill=(255, 255, 255), width=4)
    # Heel tab
    draw.rounded_rectangle((70, 210, 95, 250), radius=6, fill=(157, 23, 77))
    return img

# 6. Backpack
def make_backpack():
    img, draw = create_base_canvas(((236, 254, 255), (207, 250, 254)))
    # Top Handle Loop
    draw.arc((170, 40, 230, 100), start=180, end=0, fill=(30, 41, 59), width=12)
    # Main Backpack Bag Body
    draw.rounded_rectangle((90, 80, 310, 350), radius=50, fill=(8, 145, 178))
    # Side panel shadow
    draw.rounded_rectangle((90, 80, 140, 350), radius=40, fill=(14, 116, 144))
    # Front Pocket
    draw.rounded_rectangle((110, 200, 290, 330), radius=25, fill=(6, 182, 212))
    # Zipper line top main
    draw.arc((105, 95, 295, 250), start=180, end=0, fill=(203, 213, 225), width=5)
    # Zipper line front pocket
    draw.line([(125, 215), (275, 215)], fill=(203, 213, 225), width=4)
    # Zipper puller tag
    draw.rounded_rectangle((260, 215, 270, 240), radius=3, fill=(245, 158, 11))
    # Leather/Fabric Badge Logo
    draw.rounded_rectangle((175, 120, 225, 160), radius=8, fill=(217, 119, 6))
    draw.rectangle((185, 135, 215, 145), fill=(255, 255, 255))
    return img

# 7. Sunglasses
def make_sunglasses():
    img, draw = create_base_canvas(((254, 243, 199), (253, 230, 138)))
    # Temples / Arms
    draw.line([(40, 170), (100, 170)], fill=(30, 41, 59), width=8)
    draw.line([(300, 170), (360, 170)], fill=(30, 41, 59), width=8)
    # Frame Bridge
    draw.arc((180, 155, 220, 185), start=180, end=0, fill=(30, 41, 59), width=10)
    # Left Lens Frame
    draw.ellipse((80, 150, 185, 255), fill=(30, 41, 59))
    draw.ellipse((88, 158, 177, 247), fill=(217, 119, 6))
    # Left Lens Tint Gradient fill
    draw.ellipse((92, 162, 173, 243), fill=(180, 83, 9))
    draw.polygon([(95, 170), (160, 165), (140, 240)], fill=(251, 191, 36, 160))
    # Right Lens Frame
    draw.ellipse((215, 150, 320, 255), fill=(30, 41, 59))
    draw.ellipse((223, 158, 312, 247), fill=(217, 119, 6))
    draw.ellipse((227, 162, 308, 243), fill=(180, 83, 9))
    draw.polygon([(230, 170), (295, 165), (275, 240)], fill=(251, 191, 36, 160))
    # Gloss Lens Glare Reflections
    draw.line([(105, 175), (135, 230)], fill=(255, 255, 255), width=6)
    draw.line([(240, 175), (270, 230)], fill=(255, 255, 255), width=6)
    return img

# 8. Speaker
def make_speaker():
    img, draw = create_base_canvas(((241, 245, 249), (203, 213, 225)))
    # Speaker Main Cylinder Body
    draw.rounded_rectangle((120, 70, 280, 330), radius=50, fill=(30, 41, 59))
    # Top Cap LED Glow Ring
    draw.ellipse((130, 60, 270, 110), fill=(79, 70, 229))
    draw.ellipse((140, 68, 260, 102), fill=(15, 23, 42))
    # Mesh Grill texture pattern
    for y in range(120, 280, 14):
        draw.line([(135, y), (265, y)], fill=(51, 65, 85), width=4)
    # Brand Emblem Center Ring
    draw.ellipse((170, 170, 230, 230), fill=(79, 70, 229))
    draw.ellipse((180, 180, 220, 220), fill=(255, 255, 255))
    # Bottom Base Cap
    draw.ellipse((130, 290, 270, 340), fill=(15, 23, 42))
    # Control Buttons (+, -)
    draw.rectangle((192, 125, 208, 145), fill=(255, 255, 255))
    draw.rectangle((185, 132, 215, 138), fill=(255, 255, 255))
    return img

# 9. T-Shirt
def make_tshirt():
    img, draw = create_base_canvas(((245, 243, 255), (221, 214, 254)))
    # T-Shirt Polygon Silhouette
    pts = [
        (140, 80), (170, 105), (230, 105), (260, 80), # Collar
        (330, 120), (300, 180), (270, 160), # Right Sleeve
        (270, 340), (130, 340), # Bottom Hem
        (130, 160), (100, 180), (70, 120)  # Left Sleeve
    ]
    draw.polygon(pts, fill=(124, 58, 237))
    # Sleeve Shadows & Folds
    draw.polygon([(70, 120), (100, 180), (130, 160)], fill=(109, 40, 217))
    draw.polygon([(330, 120), (300, 180), (270, 160)], fill=(109, 40, 217))
    # Collar Rim
    draw.arc((160, 80, 240, 120), start=0, end=180, fill=(255, 255, 255), width=6)
    # Chest Crest Design / Emblem
    draw.rounded_rectangle((175, 150, 225, 200), radius=12, fill=(255, 255, 255))
    draw.polygon([(200, 160), (215, 190), (185, 190)], fill=(124, 58, 237))
    return img

# 10. Table Lamp
def make_table_lamp():
    img, draw = create_base_canvas(((254, 243, 199), (254, 215, 170)))
    # Glowing Light Cone Beam
    draw.polygon([(160, 160), (240, 160), (340, 340), (60, 340)], fill=(253, 224, 71, 140))
    # Base Pedestal
    draw.ellipse((140, 320, 260, 360), fill=(30, 41, 59))
    # Vertical Arc Stand Rod
    draw.line([(200, 330), (200, 180)], fill=(71, 85, 105), width=10)
    draw.arc((140, 120, 260, 220), start=270, end=90, fill=(71, 85, 105), width=10)
    # Lamp Shade Dome
    draw.chord((130, 100, 270, 200), start=180, end=0, fill=(217, 119, 6))
    draw.ellipse((130, 140, 270, 160), fill=(245, 158, 11))
    # Glowing Bulb
    draw.ellipse((180, 150, 220, 180), fill=(255, 255, 255))
    return img

# 11. Earbuds
def make_earbuds():
    img, draw = create_base_canvas(((238, 242, 255), (224, 231, 255)))
    # Open Charging Case Base
    draw.rounded_rectangle((120, 140, 280, 330), radius=40, fill=(30, 41, 59))
    draw.rounded_rectangle((130, 150, 270, 320), radius=30, fill=(51, 65, 85))
    # Case Inner Cavities
    draw.ellipse((145, 170, 195, 260), fill=(15, 23, 42))
    draw.ellipse((205, 170, 255, 260), fill=(15, 23, 42))
    # Left Earbud in cavity
    draw.ellipse((150, 175, 190, 220), fill=(99, 102, 241))
    draw.rectangle((165, 205, 175, 250), fill=(224, 231, 255))
    # Right Earbud in cavity
    draw.ellipse((210, 175, 250, 220), fill=(99, 102, 241))
    draw.rectangle((225, 205, 235, 250), fill=(224, 231, 255))
    # Charging LED Light Indicator
    draw.ellipse((195, 290, 205, 300), fill=(16, 185, 129))
    return img

# 12. Keyboard
def make_keyboard():
    img, draw = create_base_canvas(((241, 245, 249), (203, 213, 225)))
    # Keyboard Aluminum Body Base
    draw.rounded_rectangle((40, 120, 360, 280), radius=20, fill=(30, 41, 59))
    draw.rounded_rectangle((50, 130, 350, 270), radius=14, fill=(15, 23, 42))
    # RGB Underglow Bar
    draw.rounded_rectangle((45, 272, 355, 278), radius=3, fill=(236, 72, 153))
    # Keycaps Grid RGB Colors
    colors = [(239, 68, 68), (245, 158, 11), (16, 185, 129), (6, 182, 212), (99, 102, 241), (236, 72, 153)]
    for row in range(4):
        for col in range(10):
            x = 60 + col * 28
            y = 140 + row * 28
            w = 24
            if row == 3 and col == 3: # Spacebar
                w = 80
            draw.rounded_rectangle((x, y, x + w, y + 22), radius=4, fill=colors[(row + col) % len(colors)])
    return img

generators = {
    "headphones.png": make_headphones,
    "smartwatch.png": make_smartwatch,
    "watch.png": make_smartwatch,
    "smartphone.png": make_smartphone,
    "laptop.png": make_laptop,
    "running_shoes.png": make_shoes,
    "shoes.png": make_shoes,
    "backpack.png": make_backpack,
    "sunglasses.png": make_sunglasses,
    "speaker.png": make_speaker,
    "tshirt.png": make_tshirt,
    "table_lamp.png": make_table_lamp,
    "lamp.png": make_table_lamp,
    "earbuds.png": make_earbuds,
    "keyboard.png": make_keyboard,
}

for filename, func in generators.items():
    image = func()
    filepath = os.path.join(output_dir, filename)
    image.save(filepath, "PNG")
    print(f"Generated {filepath} ({os.path.getsize(filepath)} bytes)")

print("All product assets generated successfully!")
