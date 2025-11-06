Return-Path: <dmaengine+bounces-7082-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1E1C3A9FD
	for <lists+dmaengine@lfdr.de>; Thu, 06 Nov 2025 12:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E6F414E5787
	for <lists+dmaengine@lfdr.de>; Thu,  6 Nov 2025 11:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0336316182;
	Thu,  6 Nov 2025 11:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="VHcONQdh"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3952314D0C
	for <dmaengine@vger.kernel.org>; Thu,  6 Nov 2025 11:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762428881; cv=none; b=A4e8uoWGE55BSszLnq/fiTjHBr5eC0aBQzNlZfYyExjxHVeZ6ZpyA8/0Z7FfMvHnYhFvyEJXKZmmOSfaUcT4oYoO7Rr/3tnPlGbxnl8NjfEhi4AjBW9xsGOyA/NXoidn5xCDCBgnzV5251PxOIDV6ZZsNAHJQR8CzJqzfZegzrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762428881; c=relaxed/simple;
	bh=HmUXLW2y1rVjaif1QbzcfjuElUDdKXykWdLm9c4LpXI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RhWpvymm+KIDUZzZ1BhPUskGCi10QSnWqtIX+1xMdXEW6d7sT2upg4v5eSiOnnUDRg1rygw5OkOvHNGCBoLXSJZzLdJqn3XY0T+xtKsAn2StCu0vPwuxYPMaQDu8g/B4qAyhkcaSpDrUnV/gnen22DCnN5c9qvGIvx4AS+QhULM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=VHcONQdh; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-429eb7fafc7so584808f8f.2
        for <dmaengine@vger.kernel.org>; Thu, 06 Nov 2025 03:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762428878; x=1763033678; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t7aHWUrzlgxNBbKWCNeGhQi8iWZi43My+Fzs3phWPnY=;
        b=VHcONQdhjwWlt7k4S0daRAlmy3l2i8S88cmTgbJbowhe3knjB2JAE2sVULWNh78ecO
         hn2M+xbyph+FJiyO9jq4GOWBkLYN7xRDmYRJsCP3AzxnMF0WQL3Oqt5mQVTeoPi/ocg+
         VSW9Rcke1uVSR2dHoLdYvuotAEzE29AA+tLMeElp/Tf8lDXahjUCmKAD0k51riARVOBq
         4jDEhZZ/ysGLA1UEh/MzenzZLvJoQO9aSlO2QBtRksWidF+gCllO29pN9vS6Sa1zgChX
         p0jWoEX2iJQdFWwZPSaaH6BN9wS2mFv0bdhHhK3UVKHFivpUrmXBbzBoAVRUXzI/s0gb
         Tz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762428878; x=1763033678;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t7aHWUrzlgxNBbKWCNeGhQi8iWZi43My+Fzs3phWPnY=;
        b=rJL3PM0VKQ3TBoMCjyoVD2DOPZkCrBN1gc26EvtizIUOEl+BKh/otyTxIGjNm8D2Yy
         YAfvleSJXUTcnzSQ+toWSA/HokG4z9GshdjrbHPdCeg37yS21qFKxJg2PFg1mZYU1RlL
         JDohVQ600p59Ez5bquPT+Us50/ctdK30QtPQRIQvnZyCno3UJWjg79DWkuw6CaEV9qll
         5y6AirloIgeA8t30ifHbv61cF6cjOuAVsHTB/oDPDsWijDbFWbM2iEMNudkNmYF2ii7A
         tZ21l780VVo036tRH2UaSwMVLJIJESLZV+TlAoJ6DNzzqL3qVSXgsjz/DZZ6D/ObvGkL
         x/HQ==
X-Gm-Message-State: AOJu0Yzr7tP/EMm9GN5ZNs8sjEQoN0sK+0BK7ddAaBKhddtmmkhVhCQC
	ZdQrb0aFY36zorQUaxvjF/NZZY/Uz4m2k+R2V/f0CLHNfIRyMGumrzw9GhyFRYhJUA8=
X-Gm-Gg: ASbGncuW2RUVhVAxaDZVgEa+Qg3Fx2vKHloaSqslcgFDD9otuRlQ5S2ApeKjk/NeWKA
	hcUUFM5cwa4uBM4lNM1/rcUYmQdmuqbxMy/OmejMTb6z2sDjGx2qlQObTj69fPVnZnZkBNPjhSV
	og+jDhAUGrhOltnQBFMgbYn4487QvzPRVFxXh4b4RyQHiXLYpUeQoDV3O2UXtL7XF1lHvD9AbkD
	hLlSHQi1ArwjGdkVXdYeKgIbggGVS5ASqX7A4YQdr7FKXLZLHR6wjnku0jkzjaLM+ZiWJtL3KYW
	llxCu78NLH2NETwyGSboMZQrLc9b3usY2ByUJU/bTOk4KztwZ96+hyjGznnzRCTU7L118V6WfS8
	I3jffQlQoqCCB/Emz7jMcXqEX8THehjgIQSRxYHykta21uFSwywVn40/mEXelzje+8msb
X-Google-Smtp-Source: AGHT+IHoK1O/+JDQW0JFse0/zrHgzULYmUJO8yjsG0GrRdQ5S3RvCjLR1rPwRSyZQozg3pEN49UEFQ==
X-Received: by 2002:a05:6000:2585:b0:429:cacf:1075 with SMTP id ffacd0b85a97d-429e32e4649mr6174613f8f.17.1762428878188;
        Thu, 06 Nov 2025 03:34:38 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:d9de:4038:a78:acab])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb40379esm4389459f8f.9.2025.11.06.03.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 03:34:37 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 06 Nov 2025 12:34:04 +0100
Subject: [PATCH v8 08/11] crypto: qce - Map crypto memory for DMA
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-qcom-qce-cmd-descr-v8-8-ecddca23ca26@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3084;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=YrlK+FCBMpnN0mtgQnv4x5y020oK7SmjbrJXDNXzn5g=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBpDIe9PAKKUyb4afZt0r5bIvZ+oWZJdtCAEcub9
 pOHJZBRI7qJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaQyHvQAKCRARpy6gFHHX
 chpXD/9NByZYb24rxG/Ghz2t9YYbHOU4a7LXMIg07ieVmtBqJwlhLP7h0sKuRaxHxREFUKO2Cac
 XvK0LjqloxZ6+ORHjrLB9zCDOAYud6CAbxZASMdM7nlv4LdWV8xPTxtHpM5KkGRPDSOkSW5WCch
 eBBrjBHTUQSdNUi+Z3/KrrBzuIIlk+LQzgQ4wPLqDf9mJ0YMemD2clgtLdILmqyYzWX8Wzt5iBp
 Clru+Ab+RQ8AD4rZP8+UMMUcQ1QMCZZ8C54WNeJPUgDsRlGJ/oGhZBiMuFOZrFIHB3UqdrrnRR5
 e8Zl4xh90DX51C9Ga5vCx6lgB37BT+dMpUTzW4vI6MnO6VRDLHRN2oudv2jv0MI/5HtC3rzFdMD
 sSR4wRIz+hVgpOj3t1jjdn2l5wmf7Ri/UzhbnfZKIY+PVFqBlcV4HnNG1eHKo+2x4imE5UGYd/J
 FWP/rUBnoI7G9ld+50zwCE2kNXsFcRB0ug5fDM0VCvja8L4UxhvbYY0MqL40j3BiwdKJapuRBY2
 iYbjGh9rI6R5NFLgeCEeYKNk2jrCi8sRZTlzpXP0rERk2yPNHSbaBi1T+52NzxOry3uZ6BGN/Yg
 hEpEM2VJXEIiH/UBD+o1L3l0Cln4piKV9RagSk83wK3BgvIfskBCmMikKWvtFqJqU2oFMeGd2yw
 WsgEqAgozobeU4A==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

As the first step in converting the driver to using DMA for register
I/O, let's map the crypto memory range.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/crypto/qce/core.c | 25 +++++++++++++++++++++++--
 drivers/crypto/qce/core.h |  6 ++++++
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index aac65041f585221b800f4d7756e4bf9d9f21d0a0..e486d366c0d63aa0e1f545da9265e8ce689b50e0 100644
--- a/drivers/crypto/qce/core.c
+++ b/drivers/crypto/qce/core.c
@@ -186,10 +186,19 @@ static int qce_check_version(struct qce_device *qce)
 	return 0;
 }
 
+static void qce_crypto_unmap_dma(void *data)
+{
+	struct qce_device *qce = data;
+
+	dma_unmap_resource(qce->dev, qce->base_dma, qce->dma_size,
+			   DMA_BIDIRECTIONAL, 0);
+}
+
 static int qce_crypto_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct qce_device *qce;
+	struct resource *res;
 	int ret;
 
 	qce = devm_kzalloc(dev, sizeof(*qce), GFP_KERNEL);
@@ -199,7 +208,7 @@ static int qce_crypto_probe(struct platform_device *pdev)
 	qce->dev = dev;
 	platform_set_drvdata(pdev, qce);
 
-	qce->base = devm_platform_ioremap_resource(pdev, 0);
+	qce->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(qce->base))
 		return PTR_ERR(qce->base);
 
@@ -245,7 +254,19 @@ static int qce_crypto_probe(struct platform_device *pdev)
 	qce->async_req_enqueue = qce_async_request_enqueue;
 	qce->async_req_done = qce_async_request_done;
 
-	return devm_qce_register_algs(qce);
+	ret = devm_qce_register_algs(qce);
+	if (ret)
+		return ret;
+
+	qce->dma_size = resource_size(res);
+	qce->base_dma = dma_map_resource(dev, res->start, qce->dma_size,
+					 DMA_BIDIRECTIONAL, 0);
+	qce->base_phys = res->start;
+	ret = dma_mapping_error(dev, qce->base_dma);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(qce->dev, qce_crypto_unmap_dma, qce);
 }
 
 static const struct of_device_id qce_crypto_of_match[] = {
diff --git a/drivers/crypto/qce/core.h b/drivers/crypto/qce/core.h
index f092ce2d3b04a936a37805c20ac5ba78d8fdd2df..a80e12eac6c87e5321cce16c56a4bf5003474ef0 100644
--- a/drivers/crypto/qce/core.h
+++ b/drivers/crypto/qce/core.h
@@ -27,6 +27,9 @@
  * @dma: pointer to dma data
  * @burst_size: the crypto burst size
  * @pipe_pair_id: which pipe pair id the device using
+ * @base_dma: base DMA address
+ * @base_phys: base physical address
+ * @dma_size: size of memory mapped for DMA
  * @async_req_enqueue: invoked by every algorithm to enqueue a request
  * @async_req_done: invoked by every algorithm to finish its request
  */
@@ -43,6 +46,9 @@ struct qce_device {
 	struct qce_dma_data dma;
 	int burst_size;
 	unsigned int pipe_pair_id;
+	dma_addr_t base_dma;
+	phys_addr_t base_phys;
+	size_t dma_size;
 	int (*async_req_enqueue)(struct qce_device *qce,
 				 struct crypto_async_request *req);
 	void (*async_req_done)(struct qce_device *qce, int ret);

-- 
2.51.0


