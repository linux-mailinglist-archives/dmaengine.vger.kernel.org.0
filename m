Return-Path: <dmaengine+bounces-4698-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 753E2A5BC33
	for <lists+dmaengine@lfdr.de>; Tue, 11 Mar 2025 10:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 416573A5507
	for <lists+dmaengine@lfdr.de>; Tue, 11 Mar 2025 09:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C99237173;
	Tue, 11 Mar 2025 09:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Cg2VAVnJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA76423372F
	for <dmaengine@vger.kernel.org>; Tue, 11 Mar 2025 09:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741685155; cv=none; b=XOSCcB5Bh5o37F0ZOTdsaLutq0upr1T8qbwCbc4lEciFBtrPStGUvpTe6SC6Djbn2mjkHOwFujMpvUl7B4IUmkd3tWHrQe95MvCVUDiwlQjlqH5aPYfdJhZEgHEYZPQIDUV/albQxOfr/dAlwc8CmSdfaO79zMKqUVFQoLlUHd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741685155; c=relaxed/simple;
	bh=lfAJChJjLz/lSW1KpKvETKFQV5YDFy9aq4Cf9KsGSok=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YFw3K9uC1PxFkcT2tER8QxXDgCMolYHLb7cmdysDPxfSA9Z28lL9y5VhaHcswuauEs2bVGfx+wN4L++KXDshfduB35DEj0aGJyj/W/M/S6/dQZJVBU0qTxr0fPv/dRc/U/nvrRYA7JN0NWQ865pqFZT9KAmSpf98Gwjx7lXASF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Cg2VAVnJ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43d04dc73b7so3134335e9.3
        for <dmaengine@vger.kernel.org>; Tue, 11 Mar 2025 02:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741685150; x=1742289950; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XswlyUnyyTTPtOrJW2CN4t34TCQGsofR+8BBQ7qqS3U=;
        b=Cg2VAVnJ4KzAVoaBM7z0/g+bCwlRLGBDoWBPFP9qiWU5si+fQYUbCkmYan39gQpKr3
         CFpa5sZaj7ePAvz0npamqhaIKHYGDOBEAQoi1DSUHkHj2GJraBF/Itls3yQ/xzD/zkVx
         FzYhhDDWEcOmP51FyqdUgVaBuQcZws+FDjDALfIoXHtLub/nLKbVQig8ZUvoUdA7pa1m
         ++B5f8gkrtZX4s3oKERAHiIv4jsfv6tgSIZNq2qXegdzu0NaPzYrjSsjPdx+M/5w213r
         9yTnDWmGSUVw+Qz89hzh0C7Ph7Bu3GyJFy0AkjBPAIi10SVDa0bj/VMz6E30YpUlT2I9
         VJYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741685150; x=1742289950;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XswlyUnyyTTPtOrJW2CN4t34TCQGsofR+8BBQ7qqS3U=;
        b=qpoS3+lTdjL+zfudPnwxr8o73H4kiHrSuRmZP05hfcmWKcIlNG4AoLJjNLFh3gVx7G
         Oa7TwiIrGwzH8wqJ6XBOEhGS6dvbadY/rZZlGJiXea2dQf8aJE66f6jEopIgq9rwpn1c
         njzSx6sztwNwHWL1Uel3YBkmCYKmA1yuZ+NkkD8IA2MU8cBfh0T/9fDHuSAJK6TsAQ0U
         bAPlIXMjcCsB8I1o0EpJR2XIIGzrSMwza5m+UuU2LLY2ytQE1URmfeeGGsQUFSAcufpl
         p1b5dG3hME4EHjwiLEQICGdy2gYquq86MjEM93Tb37KoxQ/NNBis/mMJJVjzthPP6Iwr
         YLJw==
X-Forwarded-Encrypted: i=1; AJvYcCV3qNG9gr+QiEC4Vqn54oVnKlJ4kqFj+Q3Fiz7G+Q9C7Yoq1Z9bSAtuMDlcfI87O7dkZ3HgaFp970o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeCvsv71Sanl5lzevAwH0S+42+sAoR+ET6seEckOJ8vvRovcSc
	lQQFy8lIJ1PmTS0lZMX9Urme/ZixtjlQk0+Oie9E4ed/wtshN/EH1BCcYIfv4Pc=
X-Gm-Gg: ASbGncv69A2OpZ6Q/GK0yEuHx0L6bXZ9UA5pa0ty5+uUuEEr2iEQAKhGO9Y22VpcJLY
	JyuDBFlwZQJFNntmwLd4s5P3vbDAowcLP7x0FH1fM0ijjHeop2uXLzQmFq1OlONR0aI4Bgz8K1Y
	6diFNDz3Mwlj8DqFIYmiBDjEQYbH1Anrdl7L4C7bnNOcBkGW5s6LlK5Oc3nn8dBUeOcMhRofDRD
	89jHck3QSmOhsmDmOt/NsOJIaANx0g7w+20N5abdDscO5Xx+wEcrBLL0VxqbeFokrRq9mCdi3KP
	41mtYpa/P8iZXUWZHbu8fDdSoIuICvw7M5y/5EP4J6Bm4IE=
X-Google-Smtp-Source: AGHT+IGi+IPBAqmAbbUAkHrv3Jb4DEucJtkroObv0fvnsxaYpxpE6miTIuthB5uIRwYBZX4ziiwNOg==
X-Received: by 2002:a05:600c:da:b0:43c:f629:66f3 with SMTP id 5b1f17b1804b1-43cf62968b0mr72870215e9.18.1741685150224;
        Tue, 11 Mar 2025 02:25:50 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:5946:3143:114d:3f3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43cea8076fcsm107436465e9.15.2025.03.11.02.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 02:25:49 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 11 Mar 2025 10:25:37 +0100
Subject: [PATCH v7 6/8] crypto: qce - Add BAM DMA support for crypto
 register I/O
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-qce-cmd-descr-v7-6-db613f5d9c9f@linaro.org>
References: <20250311-qce-cmd-descr-v7-0-db613f5d9c9f@linaro.org>
In-Reply-To: <20250311-qce-cmd-descr-v7-0-db613f5d9c9f@linaro.org>
To: Thara Gopinath <thara.gopinath@gmail.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, Vinod Koul <vkoul@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Md Sadre Alam <quic_mdalam@quicinc.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-crypto@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=7268;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=SEtk1J0aHmReVO5qvg2CJQYibstzqGHei3j1EagqZzQ=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBn0AGWWyW4/po0MIHlVXsLPUJZuSDfQ4OEd9Xit
 SeCx9k8FKeJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ9ABlgAKCRARpy6gFHHX
 cq4VD/9FDpLWt9mPryfeerf+nPVXJLK6pl7LZQ9bw8MBT20l732sLFeEo1fBmFryCq1e8VSqaOy
 KzOFaDxuetC95xDRefpPGkFDnaP8gQqKchFGjyGW63WhklMmI6ejpdqjM2lLDGhw0pmHwuUixr0
 RyIoREuHVYjhCsO/r7Ak1DOqPHX9GvFy4nbWiz5gHFuNeKKnPCIn00IJ13F4wY5SlWrmops+/bJ
 FiKEFkEj5t8Dq/hhx1IYosQnSvhaQeYlDu83HwsiT5sgPhz9SSy4xR4Fro3Rpd8imzt/8oe3qPz
 7aMCrXUjiJTW7RU9ImUcrxg6weDieddBisaB9EITyX6wCAlraPMkPPNQZx2gKMMFlP5MCr9mZnJ
 HBVMnaWgjbpqit9mMF4Zpev5lKpvz2XaMCZHWoPj216/WVF1GwL5z161Zl84U0mbEOl11+dt3gC
 Xmb/mkq22/eyWgNvpc3eFFo8rjpsIIctA7RgMDE4Su1cFisReSsDPcLv0oJy/ehLtVUxl7j+HnA
 LqFpDM625qnIlJ/M0d01QnAdC+Rv+w97EEnIetgwwzLop7imKwr0zMh1OwoUUu95Nusn1Yqinb2
 g1N6GeeiGkuceqVBoYXtjjn/xcwMt6/SJKoJ8LyiFriKee3h/gwKxwtt7GZT2oe2EAARGCZNb+4
 z+kmGPdAXpvB/Kw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Md Sadre Alam <quic_mdalam@quicinc.com>

Add BAM/DMA support infrastructure. These interfaces will allow us to
port the algorithm implementations to use DMA for transaction with BAM
locking.

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
[Bartosz: remove unused code, rework coding style, shuffle code around
for better readability, simplify resource management, many other tweaks]
Co-developed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/crypto/qce/dma.c | 139 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/crypto/qce/dma.h |  17 ++++++
 2 files changed, 156 insertions(+)

diff --git a/drivers/crypto/qce/dma.c b/drivers/crypto/qce/dma.c
index 6ac2efb7c2f7..71b191944e3f 100644
--- a/drivers/crypto/qce/dma.c
+++ b/drivers/crypto/qce/dma.c
@@ -5,10 +5,135 @@
 
 #include <linux/device.h>
 #include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
 #include <crypto/scatterwalk.h>
 
+#include "core.h"
 #include "dma.h"
 
+struct qce_bam_transaction {
+	struct bam_cmd_element qce_bam_ce[QCE_BAM_CMD_ELEMENT_SIZE];
+	struct scatterlist qce_reg_write_sgl[QCE_BAM_CMD_SGL_SIZE];
+	struct qce_desc_info *qce_desc;
+	u32 qce_bam_ce_index;
+	u32 qce_pre_bam_ce_index;
+	u32 qce_write_sgl_cnt;
+};
+
+void qce_clear_bam_transaction(struct qce_device *qce)
+{
+	struct qce_bam_transaction *qce_bam_txn = qce->dma.qce_bam_txn;
+
+	memset(&qce_bam_txn->qce_bam_ce_index, 0, sizeof(u32) * 8);
+}
+
+static int qce_dma_prep_cmd_sg(struct qce_device *qce, struct dma_chan *chan,
+			       struct scatterlist *qce_bam_sgl,
+			       int qce_sgl_cnt, unsigned long flags,
+			       enum dma_transfer_direction dir_eng,
+			       dma_async_tx_callback cb, void *cb_param)
+{
+	struct dma_async_tx_descriptor *dma_desc;
+	struct qce_desc_info *desc;
+	dma_cookie_t cookie;
+
+	desc = qce->dma.qce_bam_txn->qce_desc;
+
+	if (dir_eng == DMA_MEM_TO_DEV)
+		desc->dir = DMA_TO_DEVICE;
+	if (dir_eng == DMA_DEV_TO_MEM)
+		desc->dir = DMA_FROM_DEVICE;
+
+	if (!qce_bam_sgl || !qce_sgl_cnt)
+		return -EINVAL;
+
+	if (!dma_map_sg(qce->dev, qce_bam_sgl,
+			qce_sgl_cnt, desc->dir)) {
+		dev_err(qce->dev, "failure in mapping sgl for cmd desc\n");
+		return -ENOMEM;
+	}
+
+	dma_desc = dmaengine_prep_slave_sg(chan, qce_bam_sgl, qce_sgl_cnt,
+					   dir_eng, flags);
+	if (!dma_desc) {
+		dev_err(qce->dev, "failed to prepare the command descriptor\n");
+		dma_unmap_sg(qce->dev, qce_bam_sgl, qce_sgl_cnt, desc->dir);
+		kfree(desc);
+		return -EINVAL;
+	}
+
+	desc->dma_desc = dma_desc;
+	desc->dma_desc->callback = cb;
+	desc->dma_desc->callback_param = cb_param;
+
+	cookie = dmaengine_submit(desc->dma_desc);
+
+	return dma_submit_error(cookie);
+}
+
+int qce_submit_cmd_desc(struct qce_device *qce, unsigned long flags)
+{
+	struct qce_bam_transaction *qce_bam_txn = qce->dma.qce_bam_txn;
+	struct dma_chan *chan = qce->dma.rxchan;
+	unsigned long desc_flags;
+	int ret = 0;
+
+	desc_flags = DMA_PREP_CMD;
+
+	/*
+	 * The HPG recommends always using the consumer pipe for command
+	 * descriptors.
+	 */
+	if (qce_bam_txn->qce_write_sgl_cnt)
+		ret = qce_dma_prep_cmd_sg(qce, chan, qce_bam_txn->qce_reg_write_sgl,
+					  qce_bam_txn->qce_write_sgl_cnt,
+					  desc_flags, DMA_MEM_TO_DEV,
+					  NULL, NULL);
+	if (ret) {
+		dev_err(qce->dev,
+			"error while submitting the command descriptor for TX: %d\n",
+			ret);
+		return ret;
+	}
+
+	qce_dma_issue_pending(&qce->dma);
+
+	if (qce_bam_txn->qce_write_sgl_cnt)
+		dma_unmap_sg(qce->dev, qce_bam_txn->qce_reg_write_sgl,
+			     qce_bam_txn->qce_write_sgl_cnt,
+			     DMA_TO_DEVICE);
+
+	return ret;
+}
+
+static __maybe_unused void
+qce_prep_dma_command_desc(struct qce_device *qce, struct qce_dma_data *dma,
+			  unsigned int addr, void *buff)
+{
+	struct qce_bam_transaction *qce_bam_txn = dma->qce_bam_txn;
+	struct bam_cmd_element *qce_bam_ce_buffer;
+	int qce_bam_ce_size, cnt, index;
+
+	index = qce_bam_txn->qce_bam_ce_index;
+	qce_bam_ce_buffer = &qce_bam_txn->qce_bam_ce[index];
+	bam_prep_ce_le32(qce_bam_ce_buffer, addr, BAM_WRITE_COMMAND,
+			 *((__le32 *)buff));
+
+	cnt = qce_bam_txn->qce_write_sgl_cnt;
+	qce_bam_ce_buffer =
+		&qce_bam_txn->qce_bam_ce[qce_bam_txn->qce_pre_bam_ce_index];
+	++qce_bam_txn->qce_bam_ce_index;
+	qce_bam_ce_size = (qce_bam_txn->qce_bam_ce_index -
+			   qce_bam_txn->qce_pre_bam_ce_index) *
+			  sizeof(struct bam_cmd_element);
+
+	sg_set_buf(&qce_bam_txn->qce_reg_write_sgl[cnt], qce_bam_ce_buffer,
+		   qce_bam_ce_size);
+
+	++qce_bam_txn->qce_write_sgl_cnt;
+	qce_bam_txn->qce_pre_bam_ce_index = qce_bam_txn->qce_bam_ce_index;
+}
+
 static void qce_dma_release(void *data)
 {
 	struct qce_dma_data *dma = data;
@@ -19,6 +144,7 @@ static void qce_dma_release(void *data)
 
 int devm_qce_dma_request(struct device *dev, struct qce_dma_data *dma)
 {
+	struct qce_bam_transaction *qce_bam_txn;
 	int ret;
 
 	dma->txchan = dma_request_chan(dev, "tx");
@@ -43,6 +169,19 @@ int devm_qce_dma_request(struct device *dev, struct qce_dma_data *dma)
 
 	dma->ignore_buf = dma->result_buf + QCE_RESULT_BUF_SZ;
 
+	dma->qce_bam_txn = devm_kmalloc(dev, sizeof(*qce_bam_txn), GFP_KERNEL);
+	if (!dma->qce_bam_txn)
+		return -ENOMEM;
+
+	dma->qce_bam_txn->qce_desc = devm_kzalloc(dev,
+					sizeof(*dma->qce_bam_txn->qce_desc),
+					GFP_KERNEL);
+	if (!dma->qce_bam_txn->qce_desc)
+		return -ENOMEM;
+
+	sg_init_table(dma->qce_bam_txn->qce_reg_write_sgl,
+		      QCE_BAM_CMD_SGL_SIZE);
+
 	return 0;
 }
 
diff --git a/drivers/crypto/qce/dma.h b/drivers/crypto/qce/dma.h
index 31629185000e..7d9d58b414ed 100644
--- a/drivers/crypto/qce/dma.h
+++ b/drivers/crypto/qce/dma.h
@@ -6,14 +6,22 @@
 #ifndef _DMA_H_
 #define _DMA_H_
 
+#include <linux/dma/qcom_bam_dma.h>
 #include <linux/dmaengine.h>
 
+struct qce_device;
+
 /* maximum data transfer block size between BAM and CE */
 #define QCE_BAM_BURST_SIZE		64
 
 #define QCE_AUTHIV_REGS_CNT		16
 #define QCE_AUTH_BYTECOUNT_REGS_CNT	4
 #define QCE_CNTRIV_REGS_CNT		4
+#define QCE_BAM_CMD_SGL_SIZE           64
+#define QCE_BAM_CMD_ELEMENT_SIZE       64
+#define QCE_DMA_DESC_FLAG_BAM_NWD      (0x0004)
+#define QCE_MAX_REG_READ               8
+
 
 struct qce_result_dump {
 	u32 auth_iv[QCE_AUTHIV_REGS_CNT];
@@ -31,9 +39,15 @@ struct qce_dma_data {
 	struct dma_chan *txchan;
 	struct dma_chan *rxchan;
 	struct qce_result_dump *result_buf;
+	struct qce_bam_transaction *qce_bam_txn;
 	void *ignore_buf;
 };
 
+struct qce_desc_info {
+	struct dma_async_tx_descriptor *dma_desc;
+	enum dma_data_direction dir;
+};
+
 int devm_qce_dma_request(struct device *dev, struct qce_dma_data *dma);
 int qce_dma_prep_sgs(struct qce_dma_data *dma, struct scatterlist *sg_in,
 		     int in_ents, struct scatterlist *sg_out, int out_ents,
@@ -44,4 +58,7 @@ struct scatterlist *
 qce_sgtable_add(struct sg_table *sgt, struct scatterlist *sg_add,
 		unsigned int max_len);
 
+void qce_clear_bam_transaction(struct qce_device *qce);
+int qce_submit_cmd_desc(struct qce_device *qce, unsigned long flags);
+
 #endif /* _DMA_H_ */

-- 
2.45.2


