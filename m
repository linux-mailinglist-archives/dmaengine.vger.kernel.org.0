Return-Path: <dmaengine+bounces-7081-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F891C3AAC6
	for <lists+dmaengine@lfdr.de>; Thu, 06 Nov 2025 12:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A932560866
	for <lists+dmaengine@lfdr.de>; Thu,  6 Nov 2025 11:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5CD314D21;
	Thu,  6 Nov 2025 11:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="cozPM+gq"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50820314A94
	for <dmaengine@vger.kernel.org>; Thu,  6 Nov 2025 11:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762428880; cv=none; b=OHgFqhiJZvbTKlMBfKwQ2FfZbGwTWpdRxisEMDbmrO/z0OERHx1iS1hFvI6554z72Ehikas4sjCaMvtk1/7drx5IMfXeFraCZEysLRlhq/CeYItDKzZa1kXqIqDrN962Ww/bkQbqfemAE+LW9y+gbBUWC9I6tjnwmp4nqy84xvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762428880; c=relaxed/simple;
	bh=/4QBhPILX+5X6ezhag3LzaL8aK4X9XYd5TN1S9llZuQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q/+9ar1rRTCulKb0ymies2/Ifi1wr5FMx0FS+LyY2m66G9mmZxOmvCe2gIscsB1V2fkaX2scBcMVRqsh3pTticWJA0m5EQJdfStxn2ZEDChFVB5OVwa+GMBqlonyDVXUZLDQw/ZSEgU7Hdzgdou27GbiMSdVRjLcIH1w6fo1P+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=cozPM+gq; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4711b95226dso10046955e9.0
        for <dmaengine@vger.kernel.org>; Thu, 06 Nov 2025 03:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762428877; x=1763033677; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CZCZoXJ9tyVK56ZhBsaXTFl9gWPV9NIZVv0TaZjVvdM=;
        b=cozPM+gqPF257/AAvUHF4OUxs9MiaUza0s09GA/T2VQF+ZDJfF+s4G4mFRla2dnico
         2hGpS6k+8aqcy3L2Ye8kxwNnh6/n97WFndnKlZQfXhUyPejsFPKCBKXjJKcke85/zH1H
         YvbaO5vw8S+0FO9zHLCgjK/EVp8wuO8aNKAiOWM/bMX6DOnjHs//ulByqcTOPbWMdrvk
         TUiV74CdJCUU6oYc8hf1ZXHsSR8ISskjKSmSgfhPJS0Fqhj+HrGKVC2QXB0jeTCWFjAc
         R16U528dhCp3nKEEySIzWXmVZp+zPCS4gqWphggPx2hl5yZ/BS9U2DoIBgKUPopZVeAC
         DRpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762428877; x=1763033677;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CZCZoXJ9tyVK56ZhBsaXTFl9gWPV9NIZVv0TaZjVvdM=;
        b=jiAIFDu8mZEFgdOEyvpHj8+vlEyrLYYkPCR0412Xu0EkNUAI0/84roXEj+i0/16QQ3
         OUClQRc6P6X+2JtJMLo/iozhN4T5yylQ0ynI2un2/r1wpyibeXUznkt5vgNm8jXGaQwR
         5DUIkacwVm+c8WmGRokJUVAvxF3e+aReK4YBnmlqD0YB5TuDnC6PyUKwXe+MmMkxvkxs
         o4IjBGR+ef0k/WoUpeZQBm8+jRKEZbmrG07vPuSuXi04oNqfyvxiOH4cbZ/sg+WkjLTr
         h/stKMrpuUNMd3K8ZZ8z6NB6Kk3S0dw5jiVT9yiuH53ey5JgqVWL4XTca0w616K+iRdm
         LGuQ==
X-Gm-Message-State: AOJu0YwehIxzD8ZlwH8ukStnOYuGXh3nefC8gtYZZwYjpgxbskJi9mAr
	PGL2SUcWnDuQryqcCYkKTliUo6aBEerdpRsBYn3UiAAWKtNYSqPzQDDXINXYub2SKhQ=
X-Gm-Gg: ASbGnctUErq49mmPndwURD91XwGlZBSQCluUa8NSyBJ1hBrqS5Sdi6AhsVBCYOsqPYj
	/PYpUT+4Wm/p+sC7ssz1sOZvpjQaI/ffzixgSkHt0pc4qwhkMh3yf969S40PMWaz2jOaqYM71q+
	RX5+qXDoS6GkEDG5Gy2AkWz7uz/o9urin0ctUHlyuiNvqbS2jSekz7h4tJMOwprx4RxmJ9Su1Hg
	S9VGHJJJ2r2Vr0WjCyM84U8zwB86flXGUaOn5fKplWJqv536eLlgEKZ6W+vWVvz5CxyxBaOZxvu
	MZ3WrVJgOISf2wUtOnlC0P4Ui4B+vJbZ6VMmcVSzIESCN5YRYMt7rZ+kRjtMiTYq8j6B+4Y8WsP
	6GJtx8yoQ/YnbOH1hZvYuFfHdPhvwEwMY7HluXsKBbEZy+uLvTGZPp26TpezL0/xOdyaMYOYXOq
	O5TLk=
X-Google-Smtp-Source: AGHT+IEoXAUh9y67MgtZ/T4+RHHzxUkHerOKyg5NFcea653MMAitTHLap8TN4SHlWCmAxqH1lFJlTA==
X-Received: by 2002:a05:600c:528d:b0:477:582e:7a81 with SMTP id 5b1f17b1804b1-4775cdbe164mr62433665e9.4.1762428876702;
        Thu, 06 Nov 2025 03:34:36 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:d9de:4038:a78:acab])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb40379esm4389459f8f.9.2025.11.06.03.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 03:34:35 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 06 Nov 2025 12:34:03 +0100
Subject: [PATCH v8 07/11] crypto: qce - Use existing devres APIs in
 devm_qce_dma_request()
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-qcom-qce-cmd-descr-v8-7-ecddca23ca26@linaro.org>
References: <20251106-qcom-qce-cmd-descr-v8-0-ecddca23ca26@linaro.org>
In-Reply-To: <20251106-qcom-qce-cmd-descr-v8-0-ecddca23ca26@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, 
 Udit Tiwari <quic_utiwari@quicinc.com>, 
 Daniel Perez-Zoghbi <dperezzo@quicinc.com>, 
 Md Sadre Alam <mdalam@qti.qualcomm.com>
Cc: dmaengine@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-crypto@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1934;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=KihkhkXsgDZVFVp7bMRhRGSm4F/l7kYDlH9NjlkYozI=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBpDIe8Ry42D3ryUjeP0c/0Pmqoo9z4r8wyiSqXR
 SFSlEAdOBSJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaQyHvAAKCRARpy6gFHHX
 cqF4EADO++008kQ6Q9EDWBZgxlmhMZczuLDY93SmZLHXETOPEMuKPH2bcqkP4XJ0tjidhHLsrJu
 SZLvk/98dkqELZlj9RE6wdE4r+BmgqFlt7l/LxhhCkDLxoC47Ngi+XsQqxG68SP+RnJOjxdQc/f
 wYpSlMwh+YH2oJ4jI87elMTWEWlH/4t817TWLTp4fUnDFmpKSiv+LZ17fAsJUzOxlK68/NUovbZ
 s3MH/9Z5JIXVD/npEUUTrehWYIBybRRTeZ+svv4RHQ4xZr7DyoszfO7E+XGoPopxta3Q54x60Jr
 QgpV+SNqpf6VKViBoxMg+9hzh/uRfu+K0PcesR2QblmkuB64DTjxb+kB/CaVY7LOsZ7k+YPDkmB
 LTD5WVP9wvlCZ5uWwqcMSQK6IIC1chxJjdne5bzVwyuK8BP8s0pl3lQS8uiRcEraD6/O64w1Vky
 aKrkQRx7J4UrZUV7vwUz6NOGMC/2jE6fBGvieEpk9N8zHbqiHGm6fJNy014mxwQhTnFJoM4anmC
 o2SZh7XqPHrXLlN8Tk6PJnqo8gjojBGIY7aF1QuBWEaKudcfKkMJyceOHIhOTMXBFiX7MujpA4M
 /hhQ9G4+TZDJijq0LnhvBPNCjAA/FfmwjVy5T8DOcpi5lm0+hFLvEvXZdd68hslsmL3XgqkFFx4
 dDGrrcS1dexY/5g==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Switch to devm_kmalloc() and devm_dma_alloc_chan() in
devm_qce_dma_request(). This allows us to drop two labels and shrink the
function.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/crypto/qce/dma.c | 37 ++++++++-----------------------------
 1 file changed, 8 insertions(+), 29 deletions(-)

diff --git a/drivers/crypto/qce/dma.c b/drivers/crypto/qce/dma.c
index 4c15dd8bbeb85f6ac0e463d7b9eab70faeb2be94..bfa54d3401ca095a089656e81a37474d6f788acf 100644
--- a/drivers/crypto/qce/dma.c
+++ b/drivers/crypto/qce/dma.c
@@ -12,45 +12,24 @@
 
 #define QCE_IGNORE_BUF_SZ		(2 * QCE_BAM_BURST_SIZE)
 
-static void qce_dma_release(void *data)
-{
-	struct qce_dma_data *dma = data;
-
-	dma_release_channel(dma->txchan);
-	dma_release_channel(dma->rxchan);
-	kfree(dma->result_buf);
-}
-
 int devm_qce_dma_request(struct qce_device *qce)
 {
 	struct qce_dma_data *dma = &qce->dma;
 	struct device *dev = qce->dev;
-	int ret;
 
-	dma->txchan = dma_request_chan(dev, "tx");
+	dma->txchan = devm_dma_request_chan(dev, "tx");
 	if (IS_ERR(dma->txchan))
 		return PTR_ERR(dma->txchan);
 
-	dma->rxchan = dma_request_chan(dev, "rx");
-	if (IS_ERR(dma->rxchan)) {
-		ret = PTR_ERR(dma->rxchan);
-		goto error_rx;
-	}
+	dma->rxchan = devm_dma_request_chan(dev, "rx");
+	if (IS_ERR(dma->rxchan))
+		return PTR_ERR(dma->rxchan);
 
-	dma->result_buf = kmalloc(QCE_RESULT_BUF_SZ + QCE_IGNORE_BUF_SZ,
-				  GFP_KERNEL);
-	if (!dma->result_buf) {
-		ret = -ENOMEM;
-		goto error_nomem;
-	}
+	dma->result_buf = devm_kmalloc(dev, QCE_RESULT_BUF_SZ + QCE_IGNORE_BUF_SZ, GFP_KERNEL);
+	if (!dma->result_buf)
+		return -ENOMEM;
 
-	return devm_add_action_or_reset(dev, qce_dma_release, dma);
-
-error_nomem:
-	dma_release_channel(dma->rxchan);
-error_rx:
-	dma_release_channel(dma->txchan);
-	return ret;
+	return 0;
 }
 
 struct scatterlist *

-- 
2.51.0


