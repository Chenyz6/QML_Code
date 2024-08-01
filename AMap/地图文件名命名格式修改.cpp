#include <iostream>
#include <string>
#include <vector>
#include <dirent.h>
#include <cstring>
#include <string>
#include <sys/stat.h>
#include <unistd.h>
#include <sstream>
using namespace std;

// 函数用于修改文件名
void renameFile(const std::string& oldPath, const std::string& newPath) {
    if (rename(oldPath.c_str(), newPath.c_str()) == -1) {
        perror("Failed to rename file");
    }
}

std::vector<std::string> split(const std::string &s, char delimiter) {
    std::vector<std::string> tokens;
    std::string token;
    std::istringstream tokenStream(s);
    while (std::getline(tokenStream, token, delimiter)) {
        tokens.push_back(token);
    }
    return tokens;
}

// 递归函数用于遍历文件夹
void traverseAndRename(const std::string& path, const std::string& baseFormat) {
    DIR* dir;
    struct dirent* entry;
    char newFileName[1024];

    if ((dir = opendir(path.c_str())) == NULL) {
        perror("Error opening directory");
        return;
    }

    while ((entry = readdir(dir)) != NULL) {
        std::string entryName = entry->d_name;
        // 忽略"."和".."
        if (entryName != "." && entryName != "..") {
            std::string currentPath = path + "/" + entryName;
            struct stat statbuf;
            if (stat(currentPath.c_str(), &statbuf) == -1) {
                perror("Error getting file status");
                continue;
            }

            if (S_ISDIR(statbuf.st_mode)) {
                // 如果是目录，则递归调用
                traverseAndRename(currentPath, baseFormat);
            } else if (S_ISREG(statbuf.st_mode)) {
                // 如果是文件，则重命名
                std::string fileName = entryName;
                std::string extension = fileName.substr(fileName.find_last_of('.'));

                std::vector<string> name = split(currentPath, '/');

                std::string newFileName = "amap_100-";
                newFileName += "1-";
                newFileName += name[name.size() - 3]; newFileName += "-";
                newFileName += name[name.size() - 2]; newFileName += "-";
                newFileName += fileName;

                string newPath = path;
                newPath += "/"; newPath += newFileName;
                renameFile(currentPath, newPath);
                std::cout << "Renamed " << currentPath << " to " << newPath << std::endl;
            }
        }
    }
    closedir(dir);
}

int main() {
    // 指定要遍历的文件夹路径
    std::string folderPath = "/home/ze/Desktop/amap";
    // 指定新的文件名格式，例如："amap_%s-%s-%s-%s%s"
    std::string newFormat = "amap_%s-%s-%s-%s%s";

    // 开始递归遍历和重命名
    traverseAndRename(folderPath, newFormat);

    return 0;
}