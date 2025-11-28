Return-Path: <dmaengine+bounces-7375-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6203DC91E24
	for <lists+dmaengine@lfdr.de>; Fri, 28 Nov 2025 12:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE19E4E979E
	for <lists+dmaengine@lfdr.de>; Fri, 28 Nov 2025 11:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1929D314B71;
	Fri, 28 Nov 2025 11:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="AOlZ8DDQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7ED9313295
	for <dmaengine@vger.kernel.org>; Fri, 28 Nov 2025 11:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764330276; cv=none; b=iltPGHR9dazVrYjf08LYHtxXkvu2HZt8e/8e1/J3x5C5lWjT1Yh2gd1d8uBk8ofoYMxFZG0SqC3jT4u7aKgYwyKD27RHei/DqxKWeVb9Da6wS+7cSXt/usgjF/mfbuiGHOF96iMQfAwS7qamyGr851otn6enNi2BijnznfhBZkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764330276; c=relaxed/simple;
	bh=DCCMlvDGThFFIvgY86LqD197iJw6Jsoi16VgT7CHNFQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cxIIJ796p9WiRLCgbAo6e3OvMKXnNBZ10StWAdP9M+R95eLb/+LRDGOAwq6mfMm0WMPyD8dg5tX8wP4/+IiqJbvxvTr0UhBTI0sRzcUzZXoMxAeEY+K0T7CmCfohJKYmTlN1/F7PLmwTBB0j95N38b6deZ933XdlpKzn9yViYVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=AOlZ8DDQ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4779d47be12so14206845e9.2
        for <dmaengine@vger.kernel.org>; Fri, 28 Nov 2025 03:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1764330268; x=1764935068; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tw3tkmAmu4OrMkcprgGA2oojzoMKM9441R1Qh3dnLxQ=;
        b=AOlZ8DDQxopy8SEaQLQG516GV7n2z9u5pbNvxuqJxmlyi0zOoqqRNKQE4WRvmo6NrD
         LrGBQbZjUyB+Jc+i2vGKOcN4M8gWb4GqBQyq9ZiGBG1INqy8vG5OspUKkDhfCufA/3dq
         VvVJE2VdJlm4+T3m1Ib0bwjMZdJYrO3evJ2vNu53YmZU6QUdrGFJyIGnkzjqlXkw+NfQ
         7mSV5zwSRchQaPK5EkaDb5BwOqLAizpCWu3C9/j3FbRsBVisDX47MIlgeZ8v7nc1AenA
         kMe0gyMiOQSo1iZ+7O2+dE0K6RfXEXAoT3+RkUKPYNCSvJihOshJ9Ov+Dj6IyQlw4dq3
         nsAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764330268; x=1764935068;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Tw3tkmAmu4OrMkcprgGA2oojzoMKM9441R1Qh3dnLxQ=;
        b=QAorCXvLwDQcGPW3rUNxKFQPHzkdgnd3ve61WSSbBNs1aYtNJ7vmAMHkWSFlc2QxUw
         BZCvThNEGC+H/nM+2V79D8wa3XlfRsvCnWXkyI01ihpKnO3irpL6qYw/+AiISIz16gOh
         q+szkLVgm1CV4y6YocNuCuQdZP9t7K3RBmWmumaXvAisEQWhsGvWTs61azggVTbgDNff
         KUhZ3SrktpbWv/IzNR+hw1OCFO7WQDCyMLE2e1B7WT2svpQ+L1ojtiSuzptCUNwHTHtE
         4MRu7BF0F1tWIDLFnJtDNT1IB2yElgGfW2DRzKPGFJbq+nDwHHC4m7wmL9MZRRbvesUO
         PKAw==
X-Gm-Message-State: AOJu0YzozK99UVY+TgLjHxtt37+PrPBBts8Lt1gQgmhZAZob/WKPHnGw
	+H8YTwp4UrS0vIQsnUxORk39KpO5rZJ5/RWj0mpbqBhVaNBDazbjRhJ92NpuBaEixPY=
X-Gm-Gg: ASbGncuvqaogXFepyoImYo7ihuQxnQRIa6Z+78ou7EpOwaHyr9oRRCDlqfEsPL0gIhb
	ZJ3foC104XTu+AMJp5Wh8wtkK3hANejS7919yTdqkSYdEbVqHcXIrrQhF7v2gOxP3K4WFS6LfU4
	PWQZQRVD3kBnNaFP5jmr8v8PvRSHP56fUu+uINnv9thoVLo39mi8khpsP/6pAe+2Z8w4tLcNTbN
	PPrze8udaZBPRcWallIhiJtsVxKpVw0FCBDUH0NlgpaKstfJYOVGBK4uGhNVhEYDwpmVC+RwY76
	QGvI1IL5iMWAC+tJl5CWK9PPrY6PmotwrCLNYhnG8V39QJbJkvCih9DWsiuUqfLyBbhlMXir7Kh
	PbTgo4EH4YX0SFpbTGslDjxH90LNhaPhyQtQm/AHUuuZkbtv9Xovsp8/w4WwSY0mTIaRtltla+E
	lnSUy2ZA==
X-Google-Smtp-Source: AGHT+IFY+Z1hsVNocOJg3NO1dMXyuSIVF4z5Hq+Vdu8X38RpK9J7FuZL5nWRH5tcw+Lx885k5tTgfg==
X-Received: by 2002:a05:600c:6d56:b0:479:1a09:1c4a with SMTP id 5b1f17b1804b1-4791a091c4emr4042835e9.31.1764330268163;
        Fri, 28 Nov 2025 03:44:28 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:f3c6:aa54:79d2:8979])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47906cb1f60sm89888445e9.1.2025.11.28.03.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 03:44:27 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 28 Nov 2025 12:44:08 +0100
Subject: [PATCH v9 10/11] crypto: qce - Add support for BAM locking
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251128-qcom-qce-cmd-descr-v9-10-9a5f72b89722@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4359;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=GYMvWd4G2OtMriFfOvACVEj/3rVgLKC4UYGoghgUhI0=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpKYsKPeo2cebRHz/smU6qyWPz+EA205XyjrMye
 TGvcJ4alE6JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaSmLCgAKCRAFnS7L/zaE
 w78cEACGsGB8VrsYSRk7Htz+ngRasAWx7hSIWcx0SzmZX4Q/Ot0gNhZ0wxd6/HCKgDiZbKexEUI
 K+wir4BZdm0/TMOynQL10S47WqI42vcFqhst6dkQ7kJqLdmh9+cbCgO99RCT3MP6TUh8/b4hz9t
 ey5WqZkW1HXo682CydqukZ9DTzkV+Umzp/JnwPHDnjkOI9Bi9nFfED+1Mqcnf1K7ztlXNOlqoLL
 YrRtobLM5KqvGUFMEAoULNlubmv08Zt1GhsHT0TrY8aWVYJrvqSD1F0zSeySREivImmc9Qy3mKF
 USLEMI0TwWDm1Esj486MBOG+bVKKmH5xds+nMEoxaDiVtL9Kp95mPIbUk7rLMta1t2a7OXAGyP6
 Cd+9JgU83Rj9enfAmR7encxpBwOgw4Ma0eN1eKCTpKvvR08uzQDhMgrmVYeX8IN2l2iY3wiseXb
 cYA+AekmsrClCitQIkP7zVSTQFXQvI2bmnb0kQuS5hHNAALI13TWYbt59K+doEMr6t4PLwnyUiu
 KETDzQNbN1dkIvhJ5rMhkQ+o/lrvy0KNDE/zwtusugIuyZR/iTIPJ8mizFuU2GZt3rBwuwMbxXy
 ZplfO9G1FRIcDRrVBv3DvbNfeXigSQvcjx1QF9pfXI+wvwhWCr2b44Hjh/OqezfcrLBBypdf64m
 8vCsrZGFMr859wQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Implement the infrastructure for using the new DMA controller lock/unlock
feature of the BAM driver. No functional change for now.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/crypto/qce/common.c | 18 ++++++++++++++++++
 drivers/crypto/qce/dma.c    | 39 ++++++++++++++++++++++++++++++++++-----
 drivers/crypto/qce/dma.h    |  4 ++++
 3 files changed, 56 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/qce/common.c b/drivers/crypto/qce/common.c
index 04253a8d33409a2a51db527435d09ae85a7880af..74756c222fed6d0298eb6c957ed15b8b7083b72f 100644
--- a/drivers/crypto/qce/common.c
+++ b/drivers/crypto/qce/common.c
@@ -593,3 +593,21 @@ void qce_get_version(struct qce_device *qce, u32 *major, u32 *minor, u32 *step)
 	*minor = (val & CORE_MINOR_REV_MASK) >> CORE_MINOR_REV_SHIFT;
 	*step = (val & CORE_STEP_REV_MASK) >> CORE_STEP_REV_SHIFT;
 }
+
+int qce_bam_lock(struct qce_device *qce)
+{
+	qce_clear_bam_transaction(qce);
+	/* Dummy write to acquire the lock on the BAM pipe. */
+	qce_write(qce, REG_AUTH_SEG_CFG, 0);
+
+	return qce_submit_cmd_desc_lock(qce);
+}
+
+int qce_bam_unlock(struct qce_device *qce)
+{
+	qce_clear_bam_transaction(qce);
+	/* Dummy write to release the lock on the BAM pipe. */
+	qce_write(qce, REG_AUTH_SEG_CFG, 0);
+
+	return qce_submit_cmd_desc_unlock(qce);
+}
diff --git a/drivers/crypto/qce/dma.c b/drivers/crypto/qce/dma.c
index ba7a52fd4c6349d59c075c346f75741defeb6034..885053955ac3dc95efefef541907f57844b60a3d 100644
--- a/drivers/crypto/qce/dma.c
+++ b/drivers/crypto/qce/dma.c
@@ -41,7 +41,7 @@ void qce_clear_bam_transaction(struct qce_device *qce)
 	bam_txn->pre_bam_ce_idx = 0;
 }
 
-int qce_submit_cmd_desc(struct qce_device *qce)
+static int qce_do_submit_cmd_desc(struct qce_device *qce, struct bam_desc_metadata *meta)
 {
 	struct qce_desc_info *qce_desc = qce->dma.bam_txn->desc;
 	struct qce_bam_transaction *bam_txn = qce->dma.bam_txn;
@@ -50,7 +50,7 @@ int qce_submit_cmd_desc(struct qce_device *qce)
 	unsigned long attrs = DMA_PREP_CMD;
 	dma_cookie_t cookie;
 	unsigned int mapped;
-	int ret;
+	int ret = -ENOMEM;
 
 	mapped = dma_map_sg_attrs(qce->dev, bam_txn->wr_sgl, bam_txn->wr_sgl_cnt,
 				  DMA_TO_DEVICE, attrs);
@@ -59,9 +59,15 @@ int qce_submit_cmd_desc(struct qce_device *qce)
 
 	dma_desc = dmaengine_prep_slave_sg(chan, bam_txn->wr_sgl, bam_txn->wr_sgl_cnt,
 					   DMA_MEM_TO_DEV, attrs);
-	if (!dma_desc) {
-		dma_unmap_sg(qce->dev, bam_txn->wr_sgl, bam_txn->wr_sgl_cnt, DMA_TO_DEVICE);
-		return -ENOMEM;
+	if (!dma_desc)
+		goto err_out;
+
+	if (meta) {
+		meta->chan = chan;
+
+		ret = dmaengine_desc_attach_metadata(dma_desc, meta, 0);
+		if (ret)
+			goto err_out;
 	}
 
 	qce_desc->dma_desc = dma_desc;
@@ -74,6 +80,29 @@ int qce_submit_cmd_desc(struct qce_device *qce)
 	qce_dma_issue_pending(&qce->dma);
 
 	return 0;
+
+err_out:
+	dma_unmap_sg(qce->dev, bam_txn->wr_sgl, bam_txn->wr_sgl_cnt, DMA_TO_DEVICE);
+	return ret;
+}
+
+int qce_submit_cmd_desc(struct qce_device *qce)
+{
+	return qce_do_submit_cmd_desc(qce, NULL);
+}
+
+int qce_submit_cmd_desc_lock(struct qce_device *qce)
+{
+	struct bam_desc_metadata meta = { .op = BAM_META_CMD_LOCK, };
+
+	return qce_do_submit_cmd_desc(qce, &meta);
+}
+
+int qce_submit_cmd_desc_unlock(struct qce_device *qce)
+{
+	struct bam_desc_metadata meta = { .op = BAM_META_CMD_UNLOCK };
+
+	return qce_do_submit_cmd_desc(qce, &meta);
 }
 
 static void qce_prep_dma_cmd_desc(struct qce_device *qce, struct qce_dma_data *dma,
diff --git a/drivers/crypto/qce/dma.h b/drivers/crypto/qce/dma.h
index f05dfa9e6b25bd60e32f45079a8bc7e6a4cf81f9..4b3ee17db72e29b9f417994477ad8a0ec2294db1 100644
--- a/drivers/crypto/qce/dma.h
+++ b/drivers/crypto/qce/dma.h
@@ -47,6 +47,10 @@ qce_sgtable_add(struct sg_table *sgt, struct scatterlist *sg_add,
 		unsigned int max_len);
 void qce_write_dma(struct qce_device *qce, unsigned int offset, u32 val);
 int qce_submit_cmd_desc(struct qce_device *qce);
+int qce_submit_cmd_desc_lock(struct qce_device *qce);
+int qce_submit_cmd_desc_unlock(struct qce_device *qce);
 void qce_clear_bam_transaction(struct qce_device *qce);
+int qce_bam_lock(struct qce_device *qce);
+int qce_bam_unlock(struct qce_device *qce);
 
 #endif /* _DMA_H_ */

-- 
2.51.0


