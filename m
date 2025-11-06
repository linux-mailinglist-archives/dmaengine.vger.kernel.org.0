Return-Path: <dmaengine+bounces-7077-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC13C3A985
	for <lists+dmaengine@lfdr.de>; Thu, 06 Nov 2025 12:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4FA8734F890
	for <lists+dmaengine@lfdr.de>; Thu,  6 Nov 2025 11:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661963126D6;
	Thu,  6 Nov 2025 11:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Ma5hXJlN"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76032310629
	for <dmaengine@vger.kernel.org>; Thu,  6 Nov 2025 11:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762428872; cv=none; b=KRW7gaZyQKejkksCPWAAJhXtuhqucXp/DYtt5B12oNvJ/XceQAN/+OZ9f8+f0vJ7jTFVkPvoB2DFnEQjUQiHI5UefCXQvaLM9yI9DYHDg2RTs39bDXX6M7mLcslTnd/uOUkKzXSxvJ9JcMXVZlDVJc2ELMxHMBYa0e5QRaSNR9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762428872; c=relaxed/simple;
	bh=a7wQEf6egR4mPuv5cdjgCNZ6WeJSo3nSIgoNmPEuE3E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gec8JjSKtd0d4X1s6DNjfGWKFus4JQYfmvUhpF4jeqFTWTr0Zujy5ajC5GtEeMHl/pvVcZJdkX4b0VOOMyxMPN9AjVcyO1iFKLyF66+CYrEdgP2eHyL7dTbQ9eF+UrWdz6aO8+vv4xtM02E6fdj7OomFEY7rZNBhGdCuAbmAcqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Ma5hXJlN; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-429b7eecf7cso589898f8f.0
        for <dmaengine@vger.kernel.org>; Thu, 06 Nov 2025 03:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762428869; x=1763033669; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PD+rs5pOYQ8OCsF4o4tgFNdDCvK3XuPAT18E201qmow=;
        b=Ma5hXJlNfP9rAldaxbjYNN+Y6dJsEchEFnZMhMp/wzb74Nx8BUGeR4eonGeYeLDRzn
         s9Ar62qlMUQzWN47RiKnvvoIBhDSIrH3MPFiav7i/J2AMnv36NL0f5e0ETQElhVvbg8y
         NUeHGBnq7mXMpEST+vVzfvefTLif0DD99K25LOcGSzs1TdbsLlL6GkTXVKq7vCCQsIGF
         cfPHKCLf28sOXyGLFaIxsRgt3YolEE1HdKiSRCdOOwFaMHBo7yX6D8RCOxNpQuBnrmrV
         u737ornnnETJWfddlzyjIo5DimeOrzWgCjGJiwUH7wi+WSCRcFx6dv3+hM0qqX2TWOBH
         B6Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762428869; x=1763033669;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PD+rs5pOYQ8OCsF4o4tgFNdDCvK3XuPAT18E201qmow=;
        b=JK2wu28JYLB+n3an8Km0vO9urE5IIWCbYbQcmxHiRd1Qfh+PZSShCg/hOsv7hL02sO
         XMvr5ph6/KTAFRDHnx3iDHo/9x3ORz7oBr3tJHzXB2H6twE6Abe9m0KgNWcvcK/MN8G0
         vE7wghRiHU2K4JUtge3nVUo2cTpSIystGPk+peafdgzt5oqZ8nts/TXdymIvvWOeTeUH
         4frQ//2chO2uD6u9E0SkCcgEx3qTBrxv5vq2rfM/qmTecJK2Ey+C8H0B28Kx18BPWn8c
         khJKVTCw8isu6Igk4Un/0CA0mXMi23pQVlcfRq9Ge//JWhf3ruLY7+w8a/TRXIWXbWWW
         L9Gg==
X-Gm-Message-State: AOJu0YwbYUARQmg8V5jfWKO6HybFBDdzjdBm5GOylc5pq6TLSYqVX3yX
	yKPHHQz1wIDk/p7sTfLAihAEmv+vfpNBzoFzm+TW1Fnlz0aGo0OniW8QBjCTjjrj9tpDBzMVMrH
	dC3Hb0OE=
X-Gm-Gg: ASbGncuBHx9DELw5i1LABjLMxHu9HGVecbhBwZcqNGnC/25JwOSbYyA95e/VZHEmyav
	VGHB8A3XfInu3TVFq+vrOPK+NylIzgyS1h6N+Or0383cV7wxO6Z+HUre6S8+R6mUJWgruNNBpTN
	ljFy0QRar2iwhouOs5CTbcRrLIE2HO/sDdJ/UhMiw0c9EACOGbogg/kNzlotqhxOlROpnbaYp+X
	QvI3EbCCb1MSki1AfLc4FUVPbo8cLcVjsvquxRiJoF2M/08z9ZegGmMawCoIeL0AhdBNU/51FvF
	lGvOW/vFql4rD1cmmD6e2MAF2gqaK7afwiho6uXEq108dhgzSisEBNT5lPpMnyQe+XhcmbBcWTR
	pQ3QHeJcWMoALInZ+X/ogbG9iglIvhnT9vKX5DCdT5o/VM9HIjt9m3U8k03uiavKTyNuqdrfO4H
	btPsfSxoaPC+UikA==
X-Google-Smtp-Source: AGHT+IFgtVKctrlOuzKQectqSEwKB2ayhahJJEey2N61I2W/lfSJB2I/53UnlfLzRQMvbCarVAJhsg==
X-Received: by 2002:a5d:64c4:0:b0:429:bc68:6ca0 with SMTP id ffacd0b85a97d-429eb12fb84mr2538324f8f.4.1762428868641;
        Thu, 06 Nov 2025 03:34:28 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:d9de:4038:a78:acab])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb40379esm4389459f8f.9.2025.11.06.03.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 03:34:27 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 06 Nov 2025 12:33:59 +0100
Subject: [PATCH v8 03/11] dmaengine: qcom: bam_dma: Add bam_pipe_lock flag
 support
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-qcom-qce-cmd-descr-v8-3-ecddca23ca26@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3204;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=qu1xfYVQtzlM9Gqzgkm1BqB5ZitfYYPCUMV4Og+CRDo=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBpDIe89GdN/Ar44t5r8WnhaHrBfOPqYa8CKf7cs
 8exTYFLr9qJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaQyHvAAKCRARpy6gFHHX
 cqW2EADe+TsFJg+T/SYNyFg8jW7yGLupg/8qCkMSkRipiwwmuO5kMlhyTmSTWIb4cBBjjcXnyqI
 9iqwPS5Rl6+ZCdzHSJlhhGJTCbeMcraPicuujhsUjSFle5cb8M38heAJ2B2buD/2TCw/+oD8TZ6
 IeujESttv94uaR5D+8wYDT0SkrFxWnO2oJdEqoZ42w+I2CnIUoNkxEbAErInw/GbClt7CUjP+ys
 wrlzkgXZmx3+u3XZHftUWg3CkqC/IbQofwY6n/naqiIAWCsQ+QJqu/1w4sQBO/xQyEHoes5HZmV
 oCDJ3BJa+XGw9FYKD6NgxySFr6pE837fWhTCDOqnJ3JSvCWFxJtN+rs5f3rg9dqIiQBMWcburH7
 /vEWzjWcFS7RUVQH7D8RSypiAqUnZu4yyWvVtBq9wnwVjC3Uy/RNE4sqpgkQKdbvMsDETxrQAOW
 ahSW8FjL8H81NS3eqfIhxN5Vj+cFNMeo+VUdIyDky2XDzYG9t88agarsN6/mifiRT4CyDPrsqo3
 DV8Mg0qcZkAutoOkdgLS0ZGIjcVq/s8kzudJl09WOD4BgmJbdvFyg2vFAbbbHSDy6rHnrLiXAzV
 xvkdg2Ka9dm0mI+ZHmNJBzMrarkWX+GdTQLbbUSSRZ5WolvZJrP9hwl4udloyjQ44BDbSphivy3
 xxHtuqNAmDmKe6g==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Extend the device match data with a flag indicating whether the IP
supports the BAM lock/unlock feature. Set it to true on BAM IP versions
1.4.0 and above.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/dma/qcom/bam_dma.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index 8861245314b1d13c1abb78f474fd0749fea52f06..68921d22ad7abfef7059b1db78052ff48e842952 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -58,6 +58,8 @@ struct bam_desc_hw {
 #define DESC_FLAG_EOB BIT(13)
 #define DESC_FLAG_NWD BIT(12)
 #define DESC_FLAG_CMD BIT(11)
+#define DESC_FLAG_LOCK BIT(10)
+#define DESC_FLAG_UNLOCK BIT(9)
 
 struct bam_async_desc {
 	struct virt_dma_desc vd;
@@ -113,6 +115,7 @@ struct reg_offset_data {
 
 struct bam_device_data {
 	const struct reg_offset_data *reg_info;
+	bool bam_pipe_lock;
 };
 
 static const struct reg_offset_data bam_v1_3_reg_info[] = {
@@ -179,6 +182,7 @@ static const struct reg_offset_data bam_v1_4_reg_info[] = {
 
 static const struct bam_device_data bam_v1_4_data = {
 	.reg_info = bam_v1_4_reg_info,
+	.bam_pipe_lock = true,
 };
 
 static const struct reg_offset_data bam_v1_7_reg_info[] = {
@@ -212,6 +216,7 @@ static const struct reg_offset_data bam_v1_7_reg_info[] = {
 
 static const struct bam_device_data bam_v1_7_data = {
 	.reg_info = bam_v1_7_reg_info,
+	.bam_pipe_lock = true,
 };
 
 /* BAM CTRL */
@@ -386,6 +391,9 @@ struct bam_chan {
 	struct list_head desc_list;
 
 	struct list_head node;
+
+	/* Is the BAM currently locked? */
+	bool locked;
 };
 
 static inline struct bam_chan *to_bam_chan(struct dma_chan *common)
@@ -667,6 +675,7 @@ static struct dma_async_tx_descriptor *bam_prep_slave_sg(struct dma_chan *chan,
 {
 	struct bam_chan *bchan = to_bam_chan(chan);
 	struct bam_device *bdev = bchan->bdev;
+	const struct bam_device_data *bdata = bdev->dev_data;
 	struct bam_async_desc *async_desc;
 	struct scatterlist *sg;
 	u32 i;
@@ -707,9 +716,34 @@ static struct dma_async_tx_descriptor *bam_prep_slave_sg(struct dma_chan *chan,
 		unsigned int curr_offset = 0;
 
 		do {
-			if (flags & DMA_PREP_CMD)
+			if (flags & DMA_PREP_CMD) {
+				if (!bdata->bam_pipe_lock &&
+				    (flags & (DMA_PREP_LOCK | DMA_PREP_UNLOCK))) {
+					dev_err(bdev->dev, "Device doesn't support BAM locking\n");
+					return NULL;
+				}
+
 				desc->flags |= cpu_to_le16(DESC_FLAG_CMD);
 
+				if (bdata->bam_pipe_lock && (flags & DMA_PREP_LOCK)) {
+					if (bchan->locked) {
+						dev_err(bdev->dev, "BAM already locked\n");
+						return NULL;
+					}
+
+					desc->flags |= cpu_to_le16(DESC_FLAG_LOCK);
+					bchan->locked = true;
+				} else if (bdata->bam_pipe_lock && (flags & DMA_PREP_UNLOCK)) {
+					if (!bchan->locked) {
+						dev_err(bdev->dev, "BAM is not locked\n");
+						return NULL;
+					}
+
+					desc->flags |= cpu_to_le16(DESC_FLAG_UNLOCK);
+					bchan->locked = false;
+				}
+			}
+
 			desc->addr = cpu_to_le32(sg_dma_address(sg) +
 						 curr_offset);
 

-- 
2.51.0


