Return-Path: <dmaengine+bounces-7080-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C6FC3AAA8
	for <lists+dmaengine@lfdr.de>; Thu, 06 Nov 2025 12:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7470356057C
	for <lists+dmaengine@lfdr.de>; Thu,  6 Nov 2025 11:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9E9314B74;
	Thu,  6 Nov 2025 11:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="nQZyM8O6"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F747313E2A
	for <dmaengine@vger.kernel.org>; Thu,  6 Nov 2025 11:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762428878; cv=none; b=dIRGsrCENIep8c7sTQQJszPS6L72qNi1Z9rGR14vO5HRuWNI4l0H3sDtkwFR1DO3IkZ9P1KFd2EIlsyigwAXgOeJsSMOARrXF5cDMnK41wpG7J8KAw7cj6Hq2n/z0ZHD/LEbwdD/iWXdzid70a00rct0b0/TJ6gttKJhjuVKn8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762428878; c=relaxed/simple;
	bh=D9uhShmSvaScrB4GZnuqnNJP9xg1MzacdZg5nrPGQA8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=amHILDQPl0mGvMlPJxDhUznCBKPYTfmjUicfGuA9N8wAUZwlkkNRWmkFuVz5tmPJbYXS0NIWJ5boa+SOeN0WoCe829C9yiSc3gwXmUIWEnMh9U6LtDSrP/KsFCkS5KqCkKiO/DuSalOKE0JTaqpkRrcSDaCyGcSElaE7pxWoGQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=nQZyM8O6; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-429c7e438a8so819169f8f.2
        for <dmaengine@vger.kernel.org>; Thu, 06 Nov 2025 03:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762428875; x=1763033675; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l2o6e8yKaUyRVohH0rydhHaeWDHZmkPZViVKmV/j0dw=;
        b=nQZyM8O6V5e/yUHJp43IWavW+jZbNbJkUihtXtDlYbjFHF580NCnriDoKSITggAq4g
         mlfAUHr/kVFr8lkir3R2dsyJ37e2e1D4At4Je2TTwpvkpHJGCO9X1VXkGmrG5vWo23NH
         +OABCQ9ThElRmhTBNGtRVZTSSTwUghi9psOemnvUB8kAyTALE/Smlf4vKfAvQG+rA5OS
         5TXa4R7toUC3lJJ98oPMblBqerheM6Z2i+3ij/2xZ1Y2+DmbtWrfgj++TXoU7UmLIHaa
         fpRWXjfd54r5QRdHiyL3uAPcd3GQELgTgJuI8FwVOhjsMBoGjOwxuoLrcSDPTxw1D89O
         s56A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762428875; x=1763033675;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l2o6e8yKaUyRVohH0rydhHaeWDHZmkPZViVKmV/j0dw=;
        b=QmsgKwl8g5fbtqxcz/SU1K1dPLVEzbjWQXSJp5odDpdUX/kVpiRx8PTfPCiyb1XuhS
         KxTJiiYUDSdABOmitwIRRF3rS9HJLuHAp5T1aWHFaPfxo3/K0Nxp/zhhyBYLgnBSE6nu
         C0gz5qa7sNvQIfN/3hpPXmZIK5Yx3FUQSu+peaXB/aKlrE+/T27jmadZGFyhszSwgVzv
         B0RfUIDK25Y3xWoPs7YPk5I8uv+8ctjK2YFu/em/35IVMkIlYrQostnG/3qlW573nqMa
         PAAxcu33QDGAtqeo6PmxvgibWND91510hKAVjQRYfexsR01nwIX/9vsJ9cWJXjw2RNHD
         kanQ==
X-Gm-Message-State: AOJu0YwX9WVBa1mcSiLxDOyc6jE2ZaIFitK/+m2iH4EJTqWhNYeCE7Sl
	rU/GTGf56NSf/Uu30ri/7jFWjOCcfqhnr/C57cehUqwumCVNOEYep8xNM0x8/dmZXd25NxrlUZB
	1RG3x+MM=
X-Gm-Gg: ASbGncudvvlF/LqBRULCf33ZekZJy9vLBgoU4rJdANXZR5eLxuNcmfU9o0NHNZvpk90
	QVqhht1tjHDM0i4fw1bWKuYHZZ+n+XVB3PBGAYs13HNTq6m5bJDf45eAhgdt/kPdqiA3yXor8BK
	9/gHTTJNoUERuXY31bDMyR8dVQ0v+kmpGGd+HeZny97Dbl4BHZNSkMOjd268KWfVD4gnKcdF2vo
	kbF4iz5vCM2eiV9YWlXxG3RA+ABvGGh3mIlNdK0DUPF6IgWrOdktXaqO0MJXfFbh9ZvqYmHWprg
	zq3/qinlu0ruKol5IBlpuVKxwyPAQsoq4rffTYGMJUSNsIMVec7M8tzIv52n7/z1jgcYnc5o1Dd
	4h9Baw8G3ge58eSUg1gojkbMemYVhTdtww/AcC7xeyxtT69jTrZ86b2KWf0NcI+M19w+iiorjnR
	Ibs8E=
X-Google-Smtp-Source: AGHT+IERQUCsT9/K+EK42FlU5rD13+DKKUBZoGLOBrpfWCcavhFwwhcjhsMGRsrk3LgLdPK4Pnr4FA==
X-Received: by 2002:a05:6000:646:b0:425:7406:d298 with SMTP id ffacd0b85a97d-429e32dd8a7mr5384377f8f.5.1762428875011;
        Thu, 06 Nov 2025 03:34:35 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:d9de:4038:a78:acab])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb40379esm4389459f8f.9.2025.11.06.03.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 03:34:33 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 06 Nov 2025 12:34:02 +0100
Subject: [PATCH v8 06/11] crypto: qce - Simplify arguments of
 devm_qce_dma_request()
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-qcom-qce-cmd-descr-v8-6-ecddca23ca26@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2545;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=JYgzjck2CuPcYXJ6P1UUpTPVBg5UfKOlRAlVywM/5yo=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBpDIe8Zb/QqUX5hqxfcaPffhFDw7Q9GIm8ZMQcH
 ee/tj8DmuaJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaQyHvAAKCRARpy6gFHHX
 cvRMEACllNsILUmgwRfS8eXNCjFlp0V4MCPnLNPyzoQmLgPJMUCbVZAirZknewnsH5bxee4LVCp
 /INqNHdquHKRRGb6puJjNDJYY+0wAb45UhHrzJ8eWIwr5rRSwM6UczevsULrota4TrtupoIaFQe
 Ft59PyLP4nZZv9F+SNhUcNU4RU+0RyPmw1nTfA2P7KBE5XEMdzr1amIdJMVvORQPFqWWr4XblIx
 7HI6ojLH/tXB1Q1KgOFTjkwJKmVAjAOIG0SJHmUR7vvOGP/8h9nBI1bCRZUndZutTX4EWzW1Jwi
 U6BPk71QkrFfLumwCbcZZwE/OJddFP9YI0eAn+qMT0A+0eMsZlkQL26tCYq7pURtSG0A3jSjMmj
 5N/rj32tHn6wmRSeGMEM1sDugwuA6319QsnWe0Dbcn3L4g1UXrUSevYccteN+JOkcrM/8at8D4M
 pOJDMHxL2KdBJ1jbJ5jT58Az2Z3dn4WZt1RfED6vNlDSdmwidIXnnzJX1RhsRal7kyJPMxjqgrG
 LyeiAsv2E5b9XKEzqXEShZa+tKC96pvfGH12OCsmUV1Pokd8oFBMjY3CgcU9Q83JHfmrxMbeK4G
 dHmsxZ+frN26A54Ckkywd7N10R4q04r3gp7KJfKAT1JqM/o3cCKxYejIQRNhYuuHtLac775b/lp
 6RdCsyVYicjKjEw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This function can extract all the information it needs from struct
qce_device alone so simplify its arguments. This is done in preparation
for adding support for register I/O over DMA which will require
accessing even more fields from struct qce_device.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/crypto/qce/core.c | 2 +-
 drivers/crypto/qce/dma.c  | 5 ++++-
 drivers/crypto/qce/dma.h  | 4 +++-
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index 3114b7f458de0c1cd8527e602b408958f224a7d0..aac65041f585221b800f4d7756e4bf9d9f21d0a0 100644
--- a/drivers/crypto/qce/core.c
+++ b/drivers/crypto/qce/core.c
@@ -227,7 +227,7 @@ static int qce_crypto_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = devm_qce_dma_request(qce->dev, &qce->dma);
+	ret = devm_qce_dma_request(qce);
 	if (ret)
 		return ret;
 
diff --git a/drivers/crypto/qce/dma.c b/drivers/crypto/qce/dma.c
index f9581d53fe4033aa1982964d1038097fff0e8250..4c15dd8bbeb85f6ac0e463d7b9eab70faeb2be94 100644
--- a/drivers/crypto/qce/dma.c
+++ b/drivers/crypto/qce/dma.c
@@ -7,6 +7,7 @@
 #include <linux/dmaengine.h>
 #include <crypto/scatterwalk.h>
 
+#include "core.h"
 #include "dma.h"
 
 #define QCE_IGNORE_BUF_SZ		(2 * QCE_BAM_BURST_SIZE)
@@ -20,8 +21,10 @@ static void qce_dma_release(void *data)
 	kfree(dma->result_buf);
 }
 
-int devm_qce_dma_request(struct device *dev, struct qce_dma_data *dma)
+int devm_qce_dma_request(struct qce_device *qce)
 {
+	struct qce_dma_data *dma = &qce->dma;
+	struct device *dev = qce->dev;
 	int ret;
 
 	dma->txchan = dma_request_chan(dev, "tx");
diff --git a/drivers/crypto/qce/dma.h b/drivers/crypto/qce/dma.h
index fc337c435cd14917bdfb99febcf9119275afdeba..483789d9fa98e79d1283de8297bf2fc2a773f3a7 100644
--- a/drivers/crypto/qce/dma.h
+++ b/drivers/crypto/qce/dma.h
@@ -8,6 +8,8 @@
 
 #include <linux/dmaengine.h>
 
+struct qce_device;
+
 /* maximum data transfer block size between BAM and CE */
 #define QCE_BAM_BURST_SIZE		64
 
@@ -32,7 +34,7 @@ struct qce_dma_data {
 	struct qce_result_dump *result_buf;
 };
 
-int devm_qce_dma_request(struct device *dev, struct qce_dma_data *dma);
+int devm_qce_dma_request(struct qce_device *qce);
 int qce_dma_prep_sgs(struct qce_dma_data *dma, struct scatterlist *sg_in,
 		     int in_ents, struct scatterlist *sg_out, int out_ents,
 		     dma_async_tx_callback cb, void *cb_param);

-- 
2.51.0


