Return-Path: <dmaengine+bounces-7367-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BDBC91D64
	for <lists+dmaengine@lfdr.de>; Fri, 28 Nov 2025 12:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A8B064E468A
	for <lists+dmaengine@lfdr.de>; Fri, 28 Nov 2025 11:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EBB30FC05;
	Fri, 28 Nov 2025 11:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="zK2vRFbF"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C934230F81B
	for <dmaengine@vger.kernel.org>; Fri, 28 Nov 2025 11:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764330258; cv=none; b=sgUV/G871cDcoyX+dMG3ppVbZUZrq36rYVRzW+ArFpjADwijfcz8klSh4Uf5jJ9e3y28NDLbYMviV3+3B8YhMU7aUYUxHB6vz1BRPJX/r4ReQ+bYoMu/MGgbUwq/BE2RRse9okhpmPzAqjiOc/sqeG+hDLtkr46rCnzfgSpJDo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764330258; c=relaxed/simple;
	bh=0cf2sYKS2TgBzFYc/lqN/kXN1VBlxGschLMTqCaHz40=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S0utP9ZFhH3IxXuYLM3N55kfQ67qg2vsG8t/eL0z++FuUIQQQxAD/zTHjj5Mr4l85VbyM6P4H0iWUh2Z4pcttKos7FFy4KY3AuJzyB4YAc21uGhi2ueUyjvhXg11+hoy2dF1xN212efLaWoX5ssWk7294dcoEMxd4vtqwyyzfeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=zK2vRFbF; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-477632b0621so10000575e9.2
        for <dmaengine@vger.kernel.org>; Fri, 28 Nov 2025 03:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1764330255; x=1764935055; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VMOh3EBYtYfHeuhJAyRcwyFC4rtu5MrYV13Tg8Gi6xw=;
        b=zK2vRFbFL9InZcNsrqUNABaSrNTv3aeUTCdq+okGh8Ta5RJ/s+GJMsFXH0xA2WQuz4
         4lTineQ7RipTPuyUPYZbh6JE6N33i8e05GsWvzgO+RrEhLz/QbJik87443R0cl4Rub7L
         QfKI26vsewF8o5wzQVhXf3gYJKxsx0dYNS2f/+h9IU3scoNZe1JY7VU2LHv6xC7w8lwV
         fJSTkxKsw+Djn3Wan8pf77GhPzBuQR0XeanryKa4fraBhgjE1jd+n5Ly2u4HFpKpowjc
         hNmd+uub6PGWDDNf/bZaUzAxl2kuiN+6j01Oxcjp6gkidi2+trFG89l1FnAF0wfhrUNp
         fShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764330255; x=1764935055;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VMOh3EBYtYfHeuhJAyRcwyFC4rtu5MrYV13Tg8Gi6xw=;
        b=eECQG9yFL+xICR9+48PFcxzSwoSrIQ9XgOFWj7853Xf4R//L2a9JgEsg+mcJwV2iss
         bCLBjpR/EJ8N0uCJ8MdO43OwzvzcTVSP1h1lABsEdtprj1V1IovISrCWM7BP6501o5Zw
         /iBae0uRKMYHVFM5cqSIB00znESHnZyImcXhdu5+T8Blp8AvY2SHKGEvkupkjILC8cod
         5VImPM8LCaknEnp1pupr0BoQwluWASCHPWxjQW1O6RrozVN/AYkavCkLv6fE359N1y8a
         J6QWuzHSHYr/yIkZB9RjQf6MJ/BxfTJE2DSng55l+qepyzH0bJjpSlTwlqapAiYLvPbQ
         cx6g==
X-Gm-Message-State: AOJu0YzQlpIE3h9HIdSpFfHWUNchlptVJFY78qMeUB/rCrEat7/mRQJv
	CmNp5W16DGs8qfnPyBZW5xhr5Vj2BOZMVn0iSF6pErVm2P5Wmr5MvzOi/SnePQAdNMo=
X-Gm-Gg: ASbGncvKMh3OIDeq9MqT5G+Iy5MhJd+XAIJHVnA1BSINFCUYzgQogXuLMio96qmSxsE
	Zmlrs2z4q58ffQLaUvstcGP90WK8aYVT0lyGY4vVJLNWRfPvVZChgYlBcbahE1JG2X61Pi050Fs
	nefdNEcvOv6OyKvqzEd7XQvutjIW4xuZbuZOZWmBY/GYxP82D8ppydidU55Ip7jP1CZF/9SfBz3
	kY+w6mmU5aH2ymkXGST6v5xL6i+ToIlDzOjddJNGeYpKxOXFTnkQ0czFa/9C1N5p1HgaSoRfJ6b
	cQN3T25mZ7fhgOXLbOpIwDDfT8eWfI20Z/jf1ATTz4Ngw3kSDskd5T6TPC9VPYMtA5T5UQt4bR8
	EqzDtvj4WRaNGdJMxQnLjhOK9U1t/DMXly33dW6yNGEylRivZVfYa1E2Gp3O6QhL5x1ctoBXWDB
	WhunNY+A==
X-Google-Smtp-Source: AGHT+IHYDT8265UCPLrcHldT6Cbr99LyQV0pdk7UJQ9F9zFrQVOxHXVebZp3Vbnh7paEy79wIqESwQ==
X-Received: by 2002:a05:600c:524c:b0:477:9976:9e1a with SMTP id 5b1f17b1804b1-477c10c887bmr261551685e9.6.1764330255054;
        Fri, 28 Nov 2025 03:44:15 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:f3c6:aa54:79d2:8979])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47906cb1f60sm89888445e9.1.2025.11.28.03.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 03:44:13 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 28 Nov 2025 12:44:00 +0100
Subject: [PATCH v9 02/11] dmaengine: qcom: bam_dma: Add bam_pipe_lock flag
 support
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251128-qcom-qce-cmd-descr-v9-2-9a5f72b89722@linaro.org>
References: <20251128-qcom-qce-cmd-descr-v9-0-9a5f72b89722@linaro.org>
In-Reply-To: <20251128-qcom-qce-cmd-descr-v9-0-9a5f72b89722@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, 
 Udit Tiwari <quic_utiwari@quicinc.com>, 
 Daniel Perez-Zoghbi <dperezzo@quicinc.com>, 
 Md Sadre Alam <mdalam@qti.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-crypto@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1527;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=p9Va/58wF8Fjgoq2zpqVnJ+LhDyGow0rENCMKQ+9sJY=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpKYsHwzwo4ZQ+YyP3lY0RkcVBWJl0Pu9UcNY7U
 D4Ni3P7XVuJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaSmLBwAKCRAFnS7L/zaE
 wzazEACKqiqPyDSxCpX3RMA/OGSXlWSSDpAOHqGTID043zIFmbd8VLAcA1JGAHy39KfY3g+8Z72
 q8y3l+rzjCr8J0s6dCjQg+XjTUzWUv2IW5F83SSqYqfMnyO8PaQuJE1sRDxfinHSYpGzhH+Rkwm
 ZqaG0PJy9pBNZ0XsKGGe+4nzbMG+A7eOHcSDOuTFDoCvNguNoeCQN2JqGatFKvNeqfBl4S9u+dB
 dBJkA+XxRCjRcgLCAMEQS1tguTejCy9VLNDnNhrkNz3sOsBDh3029fblFvutY+aWvEx7O3fJnuo
 LzpBD5vk72+J4hUYYnxXZ/BwBgptpcDOnt/pCLG/lXh/JKMVOgMdhnDQdd9Ks44rdGh42naB2u8
 aqbhbmjW+xW4RG50P984sL7jsUJ6pWEbf+XINYRc5thLLvRBLwmNBTS/2wOXvuvHFJvqmZdhlSy
 n13XO9YvK6Gcrn1T7rpTPlCsbNfiuJTyhU0do3DWKVRESrfDV88qf6isIL/T9ETx0wr6hhAJ/nE
 ArY4fhXJdQoNytF9PBZlGegC4zRokbmOVUha9yqwoRzs/tMyHXZwt0l72Ug6w2Wo5Ax7Pre+q7K
 aMoVBsk0kWJhdmNUC1s7BRoschoGgPRx7PzqPp+znSW0Z4zYNnGOulp+3bmMmibgEpuiaTtu1xU
 v2k78Q0tTYVmEmg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Extend the device match data with a flag indicating whether the IP
supports the BAM lock/unlock feature. Set it to true on BAM IP versions
1.4.0 and above.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/dma/qcom/bam_dma.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index 8861245314b1d13c1abb78f474fd0749fea52f06..c9ae1fffe44d79c5eb59b8bbf7f147a8fa3aa0bd 100644
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

-- 
2.51.0


