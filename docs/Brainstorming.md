Date - 10/06/2026
1. Mujhe poore acche se detail me samajhna hoga uss business problem ko.

2. Business problem ko acche se samajhne ke liye mujhe aise keywords ke baare me research karna padega jo mujhe bata nahi hai ?

3. Iss business problem me `git pull` ke baare me address kiya gaya hai toh mujhe samjhna hoga ki ye `git pull` kya hai aur isse kyu use kiya jaata hai

4. `git pull` kya hota hai mujhe poori tarah se samajh aa gaya hai. Research.md me point no. 1 me document kiya gaya hai.

5. Agar hum code ko server me deploy karte hai only `git pull` use karke without implemented ci/cd pipeline toh wo kyu break ho jaata hai?

6. mujhe ab poora samajh aa gaya kyu kewal `git pull` without implemented ci/cd pipeline break hota hai. Research.md me point no. 2 me document kiya gaya hai.

7. Reason kya hai ki developer code ko wrong branch pe push kar dete hai? aur .env file bhool jaate hai? 

8. mujhe poora samajh aa gaya kyu developer code ko wrong branch pe push kar dete hai aur .env file bool jaate hai. Research.md me point no. 3 me document kiya gaya hai.

9. ye node process kya hota hai ?

10. mujhe samajh me aa gaya ye node process hota kya hai. Research.md me point no. 4 me document kiya gaya hai.

11. kabhi node process hang hone ka reason kya hai ? aur isko kaise avoid kar sakte hai

12. mujhe samajh me aa gaya kyu node process hang ho jaata hai aur usko avoid kaise karna hai. Research.md me point no. 5 me document kiya gaya hai.
 
13. Ye rollback strategy kya hota hai ? Aur isko use karne ke benefits kya hai ? agar rollback strategy use nahi kiya toh kya hoga ?

14. mujhe rollback strategy ke baare me samajh aa gaya. Research.md me point no. 6 me document kiya gaya hai.

15. Maine jab rollback strategy ke baare me research kiye toh mujhe rollback strategy ke types pata chala aur usme blue-green deployment bhi tha jisse mai thoda bahut fimilier hun.

16. Ye Blue-Green Deployment kya hota hai ? Isko use karne ke benefits kya hai ? Agar use nahi kiya toh kya hoga ?

17. Mujhe Blue-Green Deployment ke baare me samajh aa gaya.  Research.md me point no. 7 me document kiya gaya hai.

18. Iss business problem ko solve karne ke liye mujhe sabse phela step kya lena chahiye ?

19. Ab Mujhe Samajh Aa gaya ki mujhe sabse phele solution ka architecture create karna hai

20. Toh mujhe architecture diagram ke samajh aa raha hai ki ek central repository hoga jisme developer code push karega.

Date - 11/06/2026

21. Toh mujhe sabse phele decide karna padega ki ye central code repository konsa hoga.

22. maine decide karke ARD.md me point no. 1 me document kar liya hai.

23. Ab mujhe decide karna hai ki konsa ci/cd pipeline tools use karna hai ?

24. maine decide karke ARD.md me point no. 2 me document kar liya hai.

25. Ab mujhe containerization ke baare me jaana padega kyuki application ko remote ec2 server pe run karna hai aur 'it's works on my machine' wali problem na ho.

26. Ab ye containers kya hote hai aur inka kya kaam aur hum containers use na kare toh kya hoga ?

27. Mujhe samajh me aa gya ki ye containers kya hote hai aur maine isko Research.md me point no. 8 me document kar liya hai

28. Ab mujhe decision making karna hai containerization tools ko choose karne ke liye.

29. Mai containerization tool ko choose kar liya hai aur usko ARD.md me point no. 3 me document kar diya hai 

30. Ab mujhe samajhna padega ki Dockerfile kaise likhte hai aur fir Dockerfile se image kaise banate hai fir uss image ko remote docker image repository me push kaise karte hai aur fir uss docker image se container kaise banate hai fir run kaise karte hai aur saath hi docker compose kya hai aur kyu use hota hai

31. Ab mujhe sab samajh me aa gaya Dockerfile banane se lekar image build karne tak, fir image se lekar usko remote registry me push karne tak, fir remote registry se pull kar ke deploy karke container ko run karne tak , Aur usko mai Research.md ke point no. 9 me document kiya hai.

32. ab mujhe samajhna padega ki mai kaise blue-green deployment strategy ko apply kar sakta hun

33. leking usse phele mujhe ye jaan na padega ki mai application code ko github me push karunga, toh github action trigger hoga, toh uss code ka image build hoke container registory me push hoga, fir wo uss build image ko container registory se aur code ko github se kaise pull karke remote server me kaise deploy karunga

34. ab isko samajhne ke liye mujhe phele central image registory ko choose karne liye decison making karna padega

35. maine ECR choose kiya hai aur ARD.md me point no. 4 me document kiya hai

36. ab deployment pe aate hai, mujhe jaana padega ki kaise mai AWS ECR se docker image ko pull karke ec2 me deploy kar sakta hun

37. ab mujhe code ko github me push karne se lekar deployment karne tak ka complete picture samajh aa gaya hai aur mai usko Research.md me point no. 10 me document kiya hu

38. ab main jo bhi research kiya hun uss basis par implement karunga

Date - 12/06/2022

39. ab mujhe ek application banana padega just for demo usme nextjs se frontend banega aur backend fastapi se aur mysql database bhi connect hoga 

40. aur mujhe uss application me database se jitna bhi data hai usko frontend me display karna hai  

41. fir mai unke liye Dockerfile bana ke unka image create karunga 

42. mai Dockerfile banane start karne ke phele mujhe ek confusion hai ki d2c-fashion-app ek fullstack application hai jisme frontend aur backend dono hai, toh fir mujhe dono ek liye seperate Dockerfile banana padega ya fir ek hi Dockerfile me dono rahega ?

43. mujhe samajh aa gaya unn dono ke liye seperate Dockerfile banana padega aur root folder me kewal docker-compose.yaml file rahega aur mai isko Research.md me point no. 11 me document kiya hai 

44. chalo ab d2c fashion app ready ho gayi hai

45. Ab mai Dockerfile likh sakta hun frontend aur backend ke liye aur saath hi .dockerignore file bhi add karna padega.

46. Application ke frontend aur backend ke liye maine Dockerfile aur .gitignore likh liya hai aur mai isko implementations.md me point no. 1 me document kiya hu

Date - 14/06/2026

47. Application ke frontend and backend ke liye main Docker images create kiya hai aur usko implementations.md me point no. 1 and 2 me document kiya hu 

48. Kyuki d2c fashion application me frontend + backend + database hai toh mujhe inke images ko docker-compose se manage karna padega.

49. Lekin docker-compose se phele mujhe samajhna padega ki ye hota kya aur iska use kya hai aur hum isko use na kare toh fir kya hoga ?

50. Ab mujhe acche se pata chal gaya, docker-composer kyu use hota hai aur use nahi kiya jaaye toh kya hoga aur mai isko research karke Research.md me point no. 12 me document kiya hua hai.

51. Mai docker-compose.yaml file create kar liya hai ab mujhe `docker compose up -d` command use karke multiple containers ko orchestration implement karna hai

Date - 15/06/2026

52. maine `docker compose up -d` command run karke multiple containers ko orchestration implement karke Implementation.md me point no. 4 me document kiya hu

53. mera d2c fashion application consists of frontend(nextjs) + backend(fastapi) + database(mysql), toh mujhe nahi lagta ki inke images ec2 me container ban ke run ho paayenge and most likely ec2 OoM(Out of Memory) ho jaayega kyuki mai aws ke free tier me hu aur mai ec2 type t3.micro use kar raha hun jisme only 1gb memory hoti hai

54. Fir bhi mai ek baar try karke dekhunga bhale hi fail kyu na ho jaaye

55. lekin usse phele mujhe frontend(nextjs) + backend(fastapi) ke docker images ko ek central image registry me push karna padega 

56. Maine phele decide kiya tha ECR me docker images ko push karunga but uski free tier ki limit 500mb ki hai aur application ke docker images ki size 500mb ko bhi exceed kar rahi hai toh mujhe inhe kisi doosre image registory me push karna padega jiski free limit 500mb ko exceed karti ho.

57. Maine GHCR(GitHub Container Registry) ko choose kiya kyuki ye public images ke liye 100% free unlimited storage provide karta hai aur private images ke liye only 500mb , toh ye mere liye kaafi hai

58. Maine GHCR(GitHub Container Registry) ko choose kar liya hai aur iske trade-offs aur consequences ko maine ARD.md me point no. 5 me document kiya hai

59. Ab mujhe sabse phele research karna padega ki docker images ko kaise GHCR(GitHub Container Registry) me push karte hai 

60. maine GHCR(GitHub Container Registry) me kaise push karte hai uska research karke Research.md me point no. 12 me document kiya hun.

61. mai apna PAT(Personal Access Token) successfully generate kar liya hai

62. ab mai frontend(nextjs) aur backend(fastapi) ke docker images ko HCR(GitHub Container Registry) me push karne jaa raha hun

63. frontend(nextjs) aur backend(fastapi) ke docker images ko GHCR(GitHub Container Registry) me successfully push ho gaya hai aur usko Implementation.md me point no. 5 me document kiya gaya hai

64. ab mujhe pata karna padega ki mai docker-compose.yaml me wo images ka name likhu jo GHCR(itHub Container Registry) me push kiya hu toh kya wo uss image ko automatically pull karke container run karega ya nahi.

65. agar docker images public image registry me hai toh bina kisi login ke automatically pull karlega lekin agar wo docker image private image registry me hai toh fir remote server me login karke PAT(Personal Access Token) dena hoga fir wo automatically pull kar lega

66. mai GHCR(GitHub Container Registry) ke images ki visibiliy ko private se change karke public kar diya hun

67. ab mai apne ec2 me d2c fashion application ka code ko github se clone karke usme `docker-compose.yaml` file se `docker compose up -d` command run karunga

68. mai d2c fashion application ke docker image se container run kiya aur wo successfully run ho gaya ✅

69. 