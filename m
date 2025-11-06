Return-Path: <dmaengine+bounces-7083-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AEBC3AA12
	for <lists+dmaengine@lfdr.de>; Thu, 06 Nov 2025 12:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9FA184E92B1
	for <lists+dmaengine@lfdr.de>; Thu,  6 Nov 2025 11:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0724316917;
	Thu,  6 Nov 2025 11:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ANcSafSn"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13D1316187
	for <dmaengine@vger.kernel.org>; Thu,  6 Nov 2025 11:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762428884; cv=none; b=dacPabaS2Wzyr1aQVcoivD63gTK9AEhwiGL3nRn2Y0105XFmh8ti/ruWiyqWqIwUgH4pzwK+SjTQiDGPen4YViz7ziQB6yKQrT7ab9lQDf6PLEvMBKzMEgqZGFNNtaGoKMsFJRcoDrccCabk9thdCtVU8/MVLBerfigPoOHgpp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762428884; c=relaxed/simple;
	bh=zl255ALAQZaKEsmkiwDZiuDGm964w4gYAhEZIIzCFA4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I1yKg5SvgFxm/qv9eBwcAzer4DGYMMdTxTS3sBvzSCG/dIV2h068MVVSQ+OVv1Pre6wC0U75RaKbLoLguQorhqfO1gThv3id64Ri1+mqnzCbLc2hc21U9UXaDllGBz6dPeOHR7te1G9fyvVvfBiQ2QuHL+m7yQXDiNfSAr7iSF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ANcSafSn; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-429bf011e6cso855479f8f.1
        for <dmaengine@vger.kernel.org>; Thu, 06 Nov 2025 03:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762428880; x=1763033680; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u1AelrTrZ5vi1Hql7yAT/NtmBB7MkGXnoGFEtYAxb6s=;
        b=ANcSafSnKUYBXZJBT404r8HUcWU5EAXmoWGSiT8EV+n2+NjH3u6m2NVZZfdAomhRy7
         WMDx+KlBThnHPy69CN4RWutIws7eAOV/gGVz6wQt/HPlr7QFaueKNti+iZNj2I2j2PS0
         uFbAge1+BtYfETcyvJr/11iSNd+YTnblkm5hle6l2CLKbygFbLecJUE8oyFS/iGUgUQN
         +1c0FUpoPdZY/wpWxhwxH3npYIuweGBQ8dJgHWJ1ZcdiT8kTOUVWTpMfnjjdhG55Feh8
         PqYWiZYnfio1PFTFQmZCGDo76hpsNrrb1p0kHOgW11JSVYgRXGcVxfwEvZifl5/oMr2i
         O4BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762428880; x=1763033680;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u1AelrTrZ5vi1Hql7yAT/NtmBB7MkGXnoGFEtYAxb6s=;
        b=pf/9U+b4Cg9NqRe3aCh3mIQTYvvgEeQ7AKp2v2UhGNQ94fQpCRyhC54YDbkmlefG7h
         aj9VXJ53ciFr1TMhlYUH3urZ3jrEORyCIpmnu0CArEH9B24L4hj6u3IZ2OGGBkUlpf46
         B7muxvJjV7y+co86YLB+MXSDu43kQ/8Eu8zXF258i9X0Jvxd2rM5dYezM0jKZXcTO4Pd
         SsjQGSG5t+ZQNtzcZSyCF/JzXZnp5aup/h4FamM/lMTA2yokmqj6x/oKJlWm556WcPbX
         oSwbeqG6Lb6JVImFWi91uDtdunljfNIK8DXos3WCFSTi+YvGO3LnwgzLHgVA+2AE9acX
         9+Mw==
X-Gm-Message-State: AOJu0Yy4LlN0iKQEk0J+Lm2u0dXFUe2kBCoqWf0eHIkVR9gBKotXofRF
	9bfpt6gO6Gsj9XhBboOWNt0++OVeowrpba2GNEJMlCecfzu/YrE/Zmvwax9ZDlehZP8=
X-Gm-Gg: ASbGncuBuQEteqjMKhg3O7+e/Dk1pU4ua1e1Uj+54MNLxmPq13xp7ITZDW/whOXV6XP
	RE3IP4zvKeme1Gk1ubv7ItlF8ZFw+VcDOYM+MZztBzFTs0tyxngIlPnZWMiiyYXUf6TZW5nuhg+
	Jr2m0Pb4SRYS+2N3l6UPSvDMMXsb0L/GMu2X8Nqlh7Wuzs6d9HQOI7GPZ/hyKk5CPsDbXBvK25b
	38g5HDew8CUPVaPFKsY8zt8SNtEHdK/ocej97utLKGFK9jISqorXxVIU1xtbbrVdOleypXo/LHY
	2BbM4HIUiyN8THfgOA9XzFKlvgYS0roNhC3E4xEFfdMKYZlnCY5whq+QaeoQX9sBwNRec6nPmHC
	s3t8Qeaw0iNMXBXlbjFpFM1AYjJc4U5eASrb4FEE3FlRA2VIothd9Ast/6H4PNBppuceKKuM/e1
	6JDQs=
X-Google-Smtp-Source: AGHT+IFj1cZgTujF+up66uGuYayospRqE039BqOL/vh201PFxdzzhjBpqpQn48ZfPe8i7w7L93Qd+g==
X-Received: by 2002:a05:6000:220e:b0:429:b1e4:1f8f with SMTP id ffacd0b85a97d-429e32e5070mr6497326f8f.26.1762428880275;
        Thu, 06 Nov 2025 03:34:40 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:d9de:4038:a78:acab])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb40379esm4389459f8f.9.2025.11.06.03.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 03:34:38 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 06 Nov 2025 12:34:05 +0100
Subject: [PATCH v8 09/11] crypto: qce - Add BAM DMA support for crypto
 register I/O
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-qcom-qce-cmd-descr-v8-9-ecddca23ca26@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6220;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=M4HnnFvam5oHPkSCa/uXNClDyduly5DTAPL1JsMNmgQ=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBpDIe9uaFsYlEGaYn2NGGdVlGgTHNmB4zrBOISN
 JQXO9aEbQmJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaQyHvQAKCRARpy6gFHHX
 cloMD/9OF3fFH2ocL8Z7nOwKg8hP3vnD3EG40rjc7S45XAgFiuaaVtEYGt47J1hn5auhZhE2IAK
 kljR1tQxdyDJW1iqFp7nDuO/6cR87scNn07feUv4MqrP/yjCnDSRBaY8DfzMzyeioKtW0c4E0cO
 u4IM29wIE7jBKe7FvbkNWyEqyNTA9yE/4pKY26qtWErFlFGfGis6PogGVvL34xh0vrPOTclL5b/
 I61MlHHlV/T5frrjCBD+E6okzpEbUhXzDWewFOeWArXuPtzbtu4PkrIuG81lVG9nFBmjEDpP67w
 akLLNOZ0l7MfRCa61ndHr1qc5Dk9mmL2ch8OKfzHr0KuCfngaNyNaCxKv69yLKsvd89UdhYVgxB
 uF0y5bbl3nX9j0zu+UqZjNhJcaSenCGyAZIHrw5wOZp+IXQ6UP4JWJqaIdLEqSWBcp88s8sdQYD
 +a3Tk2pfDYFS+iE76C7u8daHc0E27rpHcvFF4KQJnC0WQEFWrCkM7ORDJf8ZuqREmTewbUCVDmC
 fbxCzT4h0rlJIZmqVX4W7zUMhiGoOjVUgHGBeHPodk0P4qfOcGEfvmlKmktTJvJdFoie8341Nxu
 VJ8ghg8DGUAysH97WgUNNEdnQ3twkr0TPoMUzlF5u+5kcn7n7kCsGA+P8DKBcvFDV0HwPL22Nz7
 HlMl68BdRVIuL1w==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Implement the infrastructure for performing register I/O over BAM DMA,
not CPU. No functional change yet.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/crypto/qce/core.h |   4 ++
 drivers/crypto/qce/dma.c  | 109 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/crypto/qce/dma.h  |   5 +++
 3 files changed, 118 insertions(+)

diff --git a/drivers/crypto/qce/core.h b/drivers/crypto/qce/core.h
index a80e12eac6c87e5321cce16c56a4bf5003474ef0..d238097f834e4605f3825f23d0316d4196439116 100644
--- a/drivers/crypto/qce/core.h
+++ b/drivers/crypto/qce/core.h
@@ -30,6 +30,8 @@
  * @base_dma: base DMA address
  * @base_phys: base physical address
  * @dma_size: size of memory mapped for DMA
+ * @read_buf: Buffer for DMA to write back to
+ * @read_buf_dma: Mapped address of the read buffer
  * @async_req_enqueue: invoked by every algorithm to enqueue a request
  * @async_req_done: invoked by every algorithm to finish its request
  */
@@ -49,6 +51,8 @@ struct qce_device {
 	dma_addr_t base_dma;
 	phys_addr_t base_phys;
 	size_t dma_size;
+	__le32 *read_buf;
+	dma_addr_t read_buf_dma;
 	int (*async_req_enqueue)(struct qce_device *qce,
 				 struct crypto_async_request *req);
 	void (*async_req_done)(struct qce_device *qce, int ret);
diff --git a/drivers/crypto/qce/dma.c b/drivers/crypto/qce/dma.c
index bfa54d3401ca095a089656e81a37474d6f788acf..9bb9a8246cb054dd16b9ab6cf5cfabef51b1ef83 100644
--- a/drivers/crypto/qce/dma.c
+++ b/drivers/crypto/qce/dma.c
@@ -4,6 +4,8 @@
  */
 
 #include <linux/device.h>
+#include <linux/dma/qcom_bam_dma.h>
+#include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <crypto/scatterwalk.h>
 
@@ -11,6 +13,98 @@
 #include "dma.h"
 
 #define QCE_IGNORE_BUF_SZ		(2 * QCE_BAM_BURST_SIZE)
+#define QCE_BAM_CMD_SGL_SIZE		128
+#define QCE_BAM_CMD_ELEMENT_SIZE	128
+#define QCE_MAX_REG_READ		8
+
+struct qce_desc_info {
+	struct dma_async_tx_descriptor *dma_desc;
+	enum dma_data_direction dir;
+};
+
+struct qce_bam_transaction {
+	struct bam_cmd_element bam_ce[QCE_BAM_CMD_ELEMENT_SIZE];
+	struct scatterlist wr_sgl[QCE_BAM_CMD_SGL_SIZE];
+	struct qce_desc_info *desc;
+	u32 bam_ce_idx;
+	u32 pre_bam_ce_idx;
+	u32 wr_sgl_cnt;
+};
+
+void qce_clear_bam_transaction(struct qce_device *qce)
+{
+	struct qce_bam_transaction *bam_txn = qce->dma.bam_txn;
+
+	bam_txn->bam_ce_idx = 0;
+	bam_txn->wr_sgl_cnt = 0;
+	bam_txn->bam_ce_idx = 0;
+	bam_txn->pre_bam_ce_idx = 0;
+}
+
+int qce_submit_cmd_desc(struct qce_device *qce)
+{
+	struct qce_desc_info *qce_desc = qce->dma.bam_txn->desc;
+	struct qce_bam_transaction *bam_txn = qce->dma.bam_txn;
+	struct dma_async_tx_descriptor *dma_desc;
+	struct dma_chan *chan = qce->dma.rxchan;
+	unsigned long attrs = DMA_PREP_CMD;
+	dma_cookie_t cookie;
+	unsigned int mapped;
+	int ret;
+
+	mapped = dma_map_sg_attrs(qce->dev, bam_txn->wr_sgl, bam_txn->wr_sgl_cnt,
+				  DMA_TO_DEVICE, attrs);
+	if (!mapped)
+		return -ENOMEM;
+
+	dma_desc = dmaengine_prep_slave_sg(chan, bam_txn->wr_sgl, bam_txn->wr_sgl_cnt,
+					   DMA_MEM_TO_DEV, attrs);
+	if (!dma_desc) {
+		dma_unmap_sg(qce->dev, bam_txn->wr_sgl, bam_txn->wr_sgl_cnt, DMA_TO_DEVICE);
+		return -ENOMEM;
+	}
+
+	qce_desc->dma_desc = dma_desc;
+	cookie = dmaengine_submit(qce_desc->dma_desc);
+
+	ret = dma_submit_error(cookie);
+	if (ret)
+		return ret;
+
+	qce_dma_issue_pending(&qce->dma);
+
+	return 0;
+}
+
+static void qce_prep_dma_cmd_desc(struct qce_device *qce, struct qce_dma_data *dma,
+				  unsigned int addr, void *buf)
+{
+	struct qce_bam_transaction *bam_txn = dma->bam_txn;
+	struct bam_cmd_element *bam_ce_buf;
+	int bam_ce_size, cnt, idx;
+
+	idx = bam_txn->bam_ce_idx;
+	bam_ce_buf = &bam_txn->bam_ce[idx];
+	bam_prep_ce_le32(bam_ce_buf, addr, BAM_WRITE_COMMAND, *((__le32 *)buf));
+
+	bam_ce_buf = &bam_txn->bam_ce[bam_txn->pre_bam_ce_idx];
+	bam_txn->bam_ce_idx++;
+	bam_ce_size = (bam_txn->bam_ce_idx - bam_txn->pre_bam_ce_idx) * sizeof(*bam_ce_buf);
+
+	cnt = bam_txn->wr_sgl_cnt;
+
+	sg_set_buf(&bam_txn->wr_sgl[cnt], bam_ce_buf, bam_ce_size);
+
+	++bam_txn->wr_sgl_cnt;
+	bam_txn->pre_bam_ce_idx = bam_txn->bam_ce_idx;
+}
+
+void qce_write_dma(struct qce_device *qce, unsigned int offset, u32 val)
+{
+	unsigned int reg_addr = ((unsigned int)(qce->base_phys) + offset);
+
+	qce_prep_dma_cmd_desc(qce, &qce->dma, reg_addr, &val);
+}
 
 int devm_qce_dma_request(struct qce_device *qce)
 {
@@ -29,6 +123,21 @@ int devm_qce_dma_request(struct qce_device *qce)
 	if (!dma->result_buf)
 		return -ENOMEM;
 
+	dma->bam_txn = devm_kzalloc(dev, sizeof(*dma->bam_txn), GFP_KERNEL);
+	if (!dma->bam_txn)
+		return -ENOMEM;
+
+	dma->bam_txn->desc = devm_kzalloc(dev, sizeof(*dma->bam_txn->desc), GFP_KERNEL);
+	if (!dma->bam_txn->desc)
+		return -ENOMEM;
+
+	sg_init_table(dma->bam_txn->wr_sgl, QCE_BAM_CMD_SGL_SIZE);
+
+	qce->read_buf = dmam_alloc_coherent(qce->dev, QCE_MAX_REG_READ * sizeof(*qce->read_buf),
+					    &qce->read_buf_dma, GFP_KERNEL);
+	if (!qce->read_buf)
+		return -ENOMEM;
+
 	return 0;
 }
 
diff --git a/drivers/crypto/qce/dma.h b/drivers/crypto/qce/dma.h
index 483789d9fa98e79d1283de8297bf2fc2a773f3a7..f05dfa9e6b25bd60e32f45079a8bc7e6a4cf81f9 100644
--- a/drivers/crypto/qce/dma.h
+++ b/drivers/crypto/qce/dma.h
@@ -8,6 +8,7 @@
 
 #include <linux/dmaengine.h>
 
+struct qce_bam_transaction;
 struct qce_device;
 
 /* maximum data transfer block size between BAM and CE */
@@ -32,6 +33,7 @@ struct qce_dma_data {
 	struct dma_chan *txchan;
 	struct dma_chan *rxchan;
 	struct qce_result_dump *result_buf;
+	struct qce_bam_transaction *bam_txn;
 };
 
 int devm_qce_dma_request(struct qce_device *qce);
@@ -43,5 +45,8 @@ int qce_dma_terminate_all(struct qce_dma_data *dma);
 struct scatterlist *
 qce_sgtable_add(struct sg_table *sgt, struct scatterlist *sg_add,
 		unsigned int max_len);
+void qce_write_dma(struct qce_device *qce, unsigned int offset, u32 val);
+int qce_submit_cmd_desc(struct qce_device *qce);
+void qce_clear_bam_transaction(struct qce_device *qce);
 
 #endif /* _DMA_H_ */

-- 
2.51.0


