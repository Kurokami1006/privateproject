# 1. Môn học được học nhiều nhất
SELECT SUBJECT, sum(NUM_SUBSCRIBERS) AS 'Quantity'  FROM DATACLEANED_CSV
GROUP BY SUBJECT
ORDER BY Quantity DESC LIMIT 1

# 2. Tìm ra khóa học thu được nhiều tiền nhất.
SELECT COURSE_TITLE, SUM(PRICE * NUM_SUBSCRIBERS) AS 'Money' FROM DATACLEANED_CSV
GROUP BY COURSE_TITLE
ORDER BY Money DESC LIMIT 1

# 3. Tìm ra giá của 10 khóa học có số lượng đánh giá cao nhất
SELECT COURSE_TITLE, sum(NUM_REVIEWS) AS 'Reviews', sum(PRICE) AS 'Money' FROM DATACLEANED_CSV
GROUP BY COURSE_TITLE 
ORDER BY Reviews DESC LIMIT 10

# 4. Tìm ra số lượng subcribe 10 khóa học có lượng đánh giá thấp nhất
SELECT COURSE_TITLE, SUM(NUM_SUBSCRIBERS), sum(NUM_REVIEWS) FROM DATACLEANED_CSV
GROUP BY COURSE_TITLE
ORDER BY sum(NUM_REVIEWS) ASC LIMIT 10

# 5. Tim ra top 5 khóa học có doanh thu cao nhất trong 10 khóa học có nhiều subcribe nhất
WITH DoanhThu AS
(
SELECT COURSE_TITLE, SUM(PRICE * NUM_SUBSCRIBERS) AS 'Money' FROM DATACLEANED_CSV
GROUP BY COURSE_TITLE
#ORDER BY Money DESC
),
Max_Subs AS
(
SELECT COURSE_TITLE, sum(NUM_SUBSCRIBERS) AS 'SUBs' FROM DATACLEANED_CSV
GROUP BY COURSE_TITLE 
#ORDER BY SUBs DESC
)
SELECT DoanhThu.COURSE_TITLE, DoanhThu.Money AS 'Revenue', Max_Subs.SUBs AS 'Subs' FROM DoanhThu
LEFT JOIN Max_Subs
ON DoanhThu.COURSE_TITLE = Max_Subs.COURSE_TITLE
ORDER BY Money DESC LIMIT 5