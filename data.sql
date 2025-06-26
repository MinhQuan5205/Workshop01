/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/SQLTemplate.sql to edit this template
 */
/**
 * Author:  ACER
 * Created: Jun 22, 2025
 */

CREATE DATABASE PRJ301_WORKSHOP01
USE PRJ301_WORKSHOP01
-- Tạo bảng người dùng
CREATE TABLE tblUsers (
    Username VARCHAR(50) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Password VARCHAR(255) NOT NULL,
    Role VARCHAR(20) NOT NULL CHECK (Role IN ('Founder', 'Team Member'))
);

-- Tạo bảng dự án khởi nghiệp
CREATE TABLE tblStartupProjects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(100) NOT NULL,
    Description TEXT,
    Status VARCHAR(20) NOT NULL CHECK (Status IN ('Ideation', 'Development', 'Launch', 'Scaling')),
    estimated_launch DATE NOT NULL
);

-- Them du lieu mau vao bang nguoi dung (tblUsers)
INSERT INTO tblUsers (Username, Name, Password, Role) VALUES
('alice123', 'Alice Nguyen', 'pass123', 'Founder'),
('bobteam', 'Bob Tran', 'pass456', 'Team Member'),
('charlief', 'Charlie Le', 'le2024', 'Founder'),
('diana_tm', 'Diana Pham', 'pham2025', 'Team Member'),
('ericdo', 'Eric Do', 'Do2021', 'Team Member'),
('fiona_f', 'Fiona Bui', 'Bui2019', 'Founder');

-- Them du lieu mau vao bang du an khoi nghiep (tblStartupProjects)
INSERT INTO tblStartupProjects (project_id, project_name, Description, Status, estimated_launch) VALUES
(1, 'EduTech AI', 'Nen tang hoc tap ca nhan hoa su dung tri tue nhan tao.', 'Ideation', '2025-10-01'),
(2, 'GreenFarm', 'He thong giam sat nong nghiep thong minh.', 'Development', '2025-12-15'),
(3, 'HealthSync', 'Ung dung dong bo du lieu suc khoe.', 'Launch', '2025-07-10'),
(4, 'CityRides', 'Dich vu giao thong than thien voi moi truong trong thanh pho.', 'Scaling', '2025-08-20'),
(5, 'CodeBridge', 'Cong cu cong tac lap trinh truc tuyen.', 'Development', '2025-11-05'),
(6, 'FoodSavr', 'Ung dung chia se thuc pham du thua de giam lang phi.', 'Ideation', '2025-09-12');
