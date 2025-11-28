Return-Path: <dmaengine+bounces-7368-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B48C91D67
	for <lists+dmaengine@lfdr.de>; Fri, 28 Nov 2025 12:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 018A03AD43B
	for <lists+dmaengine@lfdr.de>; Fri, 28 Nov 2025 11:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AF930FF2F;
	Fri, 28 Nov 2025 11:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="QryRi1MW"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7348930F956
	for <dmaengine@vger.kernel.org>; Fri, 28 Nov 2025 11:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764330260; cv=none; b=O0K6ZC8ixpOvl0aVp3uYUIP+Y6JAtExPvTxxui5AstfC2T9aPRx60Q5lTamsmJ+LIA6BWQhdUFcE1UR4Rm7YOixVxMijdIJ2GI5lMdQqL3BbwLBtoC+jzYEETZeN7+dbuIvfBQH9K2Z4EBCH/2ZxRnGOOfnOSrIf0Mnun7OI8kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764330260; c=relaxed/simple;
	bh=5SsNI5wfu5lgcHaZXoeNIbiqegsl+8DrxdkhAnC6fZc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GGkcjkdif5DpKzTL2PP1ybY0pq/lYD1V0ZBiJjy8G93nQ4IXkxN27QG3fLSwZTFl2nPRLRaxb0zLexLboCnsewF38mu2+g8IFRzP4r7dNxg7FuODQ1wopyQleYWPWIfNIeQukvBlEuOtr/wKzPryjy80QJm6XfHhjh7xwceZTiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=QryRi1MW; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4779d47be12so14205355e9.2
        for <dmaengine@vger.kernel.org>; Fri, 28 Nov 2025 03:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1764330257; x=1764935057; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VmhVBdK9hHhNfy5tpBEdaPEwqaqku3n1Rc+zuO8j938=;
        b=QryRi1MWqlxRWHkvA3oieaugv3WBMCa6ZQZ84qEx1PvWQc8anfeV2rw9EP9n15hgmp
         CHqeCAZT7AUb9hDcWACI2HyW39mmK5L1l0JWj59t9nlyaHoK35DKX7wI04nggoHTsi5k
         TlOCNGxUOaZKvDkwn2iiQdAHiVzbX7wAyWwZROZfVST8Rh30VHxeS1s4H+SoWONE3xFY
         Wfx9+ZSEUPZl7csid8ByVjQLWHIT69lscOHXVZN9JR1CVefa+RLZ3LOQmj4Tcgumo7nt
         q7BJ3Bkt9kVcuf1HbtdkCI5um0akwjM690fGgLNWNdIKbiU6MWX7FmmCGaQXroNntZDj
         Bhsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764330257; x=1764935057;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VmhVBdK9hHhNfy5tpBEdaPEwqaqku3n1Rc+zuO8j938=;
        b=L4iYEQidCd0hmbtxnUmSTfiL13XUOjckWya+nreDyZGZYVcjZI1KViEafkYMWd3yuu
         KG01SrF7H4YorRd41SKoYhmkBidvzI6vZ2+/oABRuPaR/VHnOAojLeMXOmrko/4Bffa3
         o5dzUQuhYQxjBb66a1Z3hj9P4e/F1zoeL5NRyFnl8EwOmx2aPkGeR5nOpvr/izzFpwfy
         BqBxyFk8goR3hQ8z14eSII90vBLI5mG8c/Rv3Ydyt9/viW3EoYwQAbE2e59gFyD2yB9E
         3c2C57qw0p9V8PkhdPwfm4I9HeSix+QiGv66zDK52AIcmt6Q2ANwD/mA/G3wugqD+CCP
         +QcQ==
X-Gm-Message-State: AOJu0YxWWtoBXph+KSQbbsopvKyzMpxevs9V38Ab+3YeKVdW6uwrE8g2
	nKOMapCoqmM35xBC58doLoCqTNqbrtysFLkrFcapTyHbNxRBvOTI/p5bbno+1E18MZo=
X-Gm-Gg: ASbGncsg2TlFbkcTbxeTzqojMwPK40JQUD+pSBCPQrmQ+DJ3U7eM35SHyoz6ri7g6cg
	pplVBgPFr9x4f74fJR4YjpCejAUIVg2KT42heKp0/GIYVLM4mDM/A9sdYMywZUbMOpijFkvs5B/
	66t1c2ZxIiZzcrgWfEOr08tQGCaM3d+mSoaS8DiI3+WN3Yzh5jz9GykYl4QaI/p5PibjSO5ec+X
	m97cAQpO7GRO6cJBK/bGlTtnneLRRSc3kCaui5j5BdmkjIAl02ooUEn2LUkeUEox42FF1RmxAnv
	3BIptgw+jGRimwb+pdc6bpc9rmCXREnyJH+rpiSBf75WDrMc2XWvtUVxVeuNL8Vpufz4tqdAC1W
	iytLErUlXCVutcrM+9WfrEDDCzTA0mh4Owa0l4n8t1vT92w+1tI8PvGBZ9dipMMH6YtNR6/+DeE
	gRvbwVng==
X-Google-Smtp-Source: AGHT+IH/bPNb3tVGWmJ/mGLu86EetmMP4HcttQUvxHAOsCb0caYPMCirnCTECzvOSEb1zaAT/soKMA==
X-Received: by 2002:a05:600c:5494:b0:477:93f7:bbc5 with SMTP id 5b1f17b1804b1-477c0184c3amr265902295e9.10.1764330256743;
        Fri, 28 Nov 2025 03:44:16 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:f3c6:aa54:79d2:8979])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47906cb1f60sm89888445e9.1.2025.11.28.03.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 03:44:15 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 28 Nov 2025 12:44:01 +0100
Subject: [PATCH v9 03/11] dmaengine: qcom: bam_dma: implement support for
 BAM locking
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251128-qcom-qce-cmd-descr-v9-3-9a5f72b89722@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4643;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=bgfjrE+6MFW+6aVmOB3gB7d/udRvEErQgUFqpC2tACA=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpKYsHYVr6kP3v2MpJMD3MUjt+93xs4Q5OR/N4i
 KwVVlINvBOJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaSmLBwAKCRAFnS7L/zaE
 wxRvD/9SGzVhWyOF9I8dJDSeLS24uqlLTy2z4SKX7R/h8xESixJzPD+t+G9aB9Y4i9PHI3Fuq1s
 he1BEkdT8/3LWdvsC6WuwdNAIXixk+HBnDqs4KyV/vig0n2ggSdCOzOoFR/1tntCtkPiM8JRUVr
 adBzk0yunOV38MnFXFXM+A/8Odh7gzieX1cHfnJGIV0724ZqqiUFtz40y5v2eZVrBzD2mhpF+Am
 CXQLxtq0xnYzRaukp49ciK6JYK7/9RKR5ob47keNwNBEGJAkSR6su+L26Bv99PJ0RzLtoA0l2pW
 YGagCp5LCYTzmOENnRO+N3Pwo1zTjT2TXiMkdruToLxhT4FtZ3CcUYS7L4UkBEDWw5LdJ+5ZBZq
 +qag9trswjADTegjZKulZmaqOL8/7im4D67vUw3yj3GNU7kIoUJR28jRCFpmne30ffDpzrsz7rM
 SXnpng3qsx3ezkFJajadHQeQDj/ozANMo2dF8r5go07a8H1Zbx+LI7kJlNknZ3veM/08icvh11q
 YE5kyYEwrcBJHu+ejqyR0TY8k71aV6dKn9gijmq9SmKewhmdaxNbNt/xKMVOju/djJQfoD3wYVH
 ag+ibcBG2RXb4fM8CoyKA1gYOfx3wnXrgK7mttyHeYgMGu05Fn45U9NFdLHP0FuLY4jIMYIpnQJ
 8ES/g4BaDZ9+oaA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Use metadata operations in DMA descriptors to allow BAM users to pass
additional information to the engine. To that end: define a new
structure - struct bam_desc_metadata - as a medium and define two new
commands: for locking and unlocking the BAM respectively. Handle the
locking in the .attach() callback.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/dma/qcom/bam_dma.c       | 59 +++++++++++++++++++++++++++++++++++++++-
 include/linux/dma/qcom_bam_dma.h | 12 ++++++++
 2 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index c9ae1fffe44d79c5eb59b8bbf7f147a8fa3aa0bd..d1dc80b29818897b333cd223ec7306a169cc51fd 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -30,6 +30,7 @@
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/dma-mapping.h>
+#include <linux/dma/qcom_bam_dma.h>
 #include <linux/scatterlist.h>
 #include <linux/device.h>
 #include <linux/platform_device.h>
@@ -391,6 +392,8 @@ struct bam_chan {
 	struct list_head desc_list;
 
 	struct list_head node;
+
+	bool bam_locked;
 };
 
 static inline struct bam_chan *to_bam_chan(struct dma_chan *common)
@@ -655,6 +658,53 @@ static int bam_slave_config(struct dma_chan *chan,
 	return 0;
 }
 
+static int bam_metadata_attach(struct dma_async_tx_descriptor *desc, void *data, size_t len)
+{
+	struct virt_dma_desc *vd = container_of(desc, struct virt_dma_desc, tx);
+	struct bam_async_desc *async_desc = container_of(vd, struct bam_async_desc,  vd);
+	struct bam_desc_hw *hw_desc = async_desc->desc;
+	struct bam_desc_metadata *metadata = data;
+	struct bam_chan *bchan = to_bam_chan(metadata->chan);
+	struct bam_device *bdev = bchan->bdev;
+
+	if (!data)
+		return -EINVAL;
+
+	if (metadata->op == BAM_META_CMD_LOCK || metadata->op == BAM_META_CMD_UNLOCK) {
+		if (!bdev->dev_data->bam_pipe_lock)
+			return -EOPNOTSUPP;
+
+		/* Expecting a dummy write when locking, only one descriptor allowed. */
+		if (async_desc->num_desc != 1)
+			return -EINVAL;
+	}
+
+	switch (metadata->op) {
+	case BAM_META_CMD_LOCK:
+		if (bchan->bam_locked)
+			return -EBUSY;
+
+		hw_desc->flags |= DESC_FLAG_LOCK;
+		bchan->bam_locked = true;
+		break;
+	case BAM_META_CMD_UNLOCK:
+		if (!bchan->bam_locked)
+			return -EPERM;
+
+		hw_desc->flags |= DESC_FLAG_UNLOCK;
+		bchan->bam_locked = false;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static struct dma_descriptor_metadata_ops bam_metadata_ops = {
+	.attach = bam_metadata_attach,
+};
+
 /**
  * bam_prep_slave_sg - Prep slave sg transaction
  *
@@ -671,6 +721,7 @@ static struct dma_async_tx_descriptor *bam_prep_slave_sg(struct dma_chan *chan,
 	void *context)
 {
 	struct bam_chan *bchan = to_bam_chan(chan);
+	struct dma_async_tx_descriptor *tx_desc;
 	struct bam_device *bdev = bchan->bdev;
 	struct bam_async_desc *async_desc;
 	struct scatterlist *sg;
@@ -732,7 +783,12 @@ static struct dma_async_tx_descriptor *bam_prep_slave_sg(struct dma_chan *chan,
 		} while (remainder > 0);
 	}
 
-	return vchan_tx_prep(&bchan->vc, &async_desc->vd, flags);
+	tx_desc = vchan_tx_prep(&bchan->vc, &async_desc->vd, flags);
+	if (!tx_desc)
+		return NULL;
+
+	tx_desc->metadata_ops = &bam_metadata_ops;
+	return tx_desc;
 }
 
 /**
@@ -1372,6 +1428,7 @@ static int bam_dma_probe(struct platform_device *pdev)
 	bdev->common.device_terminate_all = bam_dma_terminate_all;
 	bdev->common.device_issue_pending = bam_issue_pending;
 	bdev->common.device_tx_status = bam_tx_status;
+	bdev->common.desc_metadata_modes = DESC_METADATA_CLIENT;
 	bdev->common.dev = bdev->dev;
 
 	ret = dma_async_device_register(&bdev->common);
diff --git a/include/linux/dma/qcom_bam_dma.h b/include/linux/dma/qcom_bam_dma.h
index 68fc0e643b1b97fe4520d5878daa322b81f4f559..dd30bb9c520fac7bd98c5a47e56a5a286331461a 100644
--- a/include/linux/dma/qcom_bam_dma.h
+++ b/include/linux/dma/qcom_bam_dma.h
@@ -8,6 +8,8 @@
 
 #include <asm/byteorder.h>
 
+struct dma_chan;
+
 /*
  * This data type corresponds to the native Command Element
  * supported by BAM DMA Engine.
@@ -34,6 +36,16 @@ enum bam_command_type {
 	BAM_READ_COMMAND,
 };
 
+enum bam_desc_metadata_op {
+	BAM_META_CMD_LOCK = 1,
+	BAM_META_CMD_UNLOCK,
+};
+
+struct bam_desc_metadata {
+	enum bam_desc_metadata_op op;
+	struct dma_chan *chan;
+};
+
 /*
  * prep_bam_ce_le32 - Wrapper function to prepare a single BAM command
  * element with the data already in le32 format.

-- 
2.51.0


