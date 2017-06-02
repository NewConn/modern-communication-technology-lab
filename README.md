# ModernCommunicationTechnologyLab
## 现代通信技术实验：
- 图片
      
- 音频

      1、准备工作
        (1)各位同学准备一段语音文件，30S 左右即可，内容任意，歌曲朗诵均可，
           保存为单声道，44kbps 采样率的 wav 文件。
           
        (2)在 matlab 中编写程序，可以读入 WAV 文件，获得每个采样点的声音幅
           值信息。
           
           
      2、采样率作业
        (1)将 WAV 文件读入后，首先查看文件采样率是否符合 44kbps 的要求。
        (2)将采样率改变，例如 fs=8.8kbps，并保存进行播放，与原文件进行比对，
           感觉变化，并记录。
           
           
      3、量化编码作业
        (1)读取 2 中降低采样率后的文件，在时域内画出幅值变化；进行归一化，将
           幅值限制在一定范围内，进行均匀量化，量化完成后进行 PCM 编码，将得到的数
           据保存为 CSV 格式。
           
        (2)对编码后的二进制数据，加高斯白噪声，模拟信道噪声。
        
        (3)对(2)中的数据进行判决，得到的数据进行保存，与(1)中的原始数据进行
           比对，算出 BER 误码率。
           
        (4)将判决后的数据进行译码，恢复出模拟信号，画出时域内幅值变化，与(1)
           中的图像进行对比；保存译码后数据为 WAV 格式并播放，对比加噪声前后的声音
           变化。
           
        (5)将均匀量化改为 A 律 13 折线量化方法，重复以上步骤，在误码率相同的
           情况下，比对两种方法的声音清晰度。
           
           
  4、基于傅里叶运算频域滤波作业
           读取 2 中降低采样率后的文件，对数据进行 FFT 变换，画出幅频曲线。
           
        (1)观察幅频曲线，对声音集中的频率进行滤波（带通滤波，低通滤波等）。
        
        (2)对滤波后的数据进行逆变换，保存为 WAV 文件，进行播放，与原文件声音
           进行对比。
