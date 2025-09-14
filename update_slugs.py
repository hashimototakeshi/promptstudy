import os
import re

def update_file(file_path, old_num, new_num):
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Update slug
    content = re.sub(
        r'slug: chapter05/work' + str(old_num).zfill(2) + r'\b', 
        'slug: chapter05/work' + str(new_num), 
        content
    )
    
    # Update relations
    content = re.sub(
        r'relation: (.*)work' + str(old_num).zfill(2) + r'\b', 
        'relation: \\1work' + str(new_num), 
        content
    )
    
    with open(file_path, 'w', encoding='utf-8') as f:
        f.write(content)

def main():
    base_dir = '/home/hashimoto/contents/prompt_engineering/PromptEngineering_lv01_ja/chapter05'
    
    # Map old file numbers to new numbers (1-13 -> 36-48)
    num_mapping = {i: 35 + i for i in range(1, 14)}
    
    # Update each file
    for old_num, new_num in num_mapping.items():
        old_file = os.path.join(base_dir, f'work{old_num:02d}.md')
        new_file = os.path.join(base_dir, f'work{new_num}.md')
        
        # If file exists with old name, rename it
        if os.path.exists(old_file) and not os.path.exists(new_file):
            os.rename(old_file, new_file)
            print(f'Renamed: {old_file} -> {new_file}')
        
        # Update content of the new file
        if os.path.exists(new_file):
            update_file(new_file, old_num, new_num)
            print(f'Updated: {new_file}')

if __name__ == '__main__':
    main()
