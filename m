Return-Path: <dmaengine+bounces-4129-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE93AA12808
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jan 2025 17:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90D5F3A793B
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jan 2025 16:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E61146D40;
	Wed, 15 Jan 2025 16:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="tqNLRBDy"
X-Original-To: dmaengine@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7757015535B;
	Wed, 15 Jan 2025 16:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736956978; cv=none; b=OCYqB+VXK29USaebc9DFeSM5riO/YUb/JjX2VSuDvOpGAXKPkEhxmcMMUtHr9Akl7SxestM5EZppZNP3mTnNUj6PtuufsGdSYI2yebQLJX76sQyIUo+x2uG/Apa+v5VNIUvzLMxA7+VO45UxhYzUqrJY6uhJ9MR4M4E59EbzTpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736956978; c=relaxed/simple;
	bh=lv2VJeVi//u4tS+31Few2FFXGhtnTnhbk6hd4mxTSBA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pK9kwTIBYKTXHls413AxyHMaGmpm7r0U40Qj1Ub636EbqHBSz4P782piCAUXqJ+JEZtWg741q7xDsxWW3Coznjz3wdLN1k+ZEwlb4ilUIKfhDjFFiOT2cbgiBysHV+MuwAzIhZND9crmzTGG7n3Y/w2fOqs/0VxgT2hQFs63cwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=tqNLRBDy; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 26C6EA0805;
	Wed, 15 Jan 2025 17:02:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=vHzHRMeaUNUBZ6ey2JqX4aAaicN8Iz7fOt7BdV4FyeM=; b=
	tqNLRBDycCUCN4u9OEsrXdYcObZRG7BzDVueT5OSXKcrD7+07qTYxAPzdY2r6Fvh
	sLQ88NSs0+B0+/PdxWdCL3GtMhYLouneUh86mEu95rif6JsnAxQbRG76P5Ejx04o
	maPEGDedne6+JxsY5wYjRmGDqk24jnJIE8CJPJjjhNWHHMXJR2lNslJxRLeioTWQ
	koQGaXLYZuXHm6QOBOO564BLP+UePwZPIAjWQ9JJ/4zKXE9N2mH9DZhf+howYvYP
	xZY891qhF+8B3WUulrpk0Ex8BxrB495CTt7ALi3ryFTIQ+semAvkdj4/CdPBn7gq
	ydZ7Kbc8Ox60VFpUu6oWmDAGRZ6Kv7jN1mJnn+nOx+ZYJYEFbIgWVggP1daQHJds
	r7h9EWbEGT2uYYZlle42Ej0WrmIcU43AvegC7ENEpKjBUecZYjHEHEV+OXd/xPrg
	O/ziU6C78m0BssX5j6dVAt0kRvRnbxGCkwLi7QA8B4dTWH1J6HtglOV6rPKk8N48
	VOJnjDK1+d0GO8Ybw3VhupCjCFNcwyqGGRToFmlqMI5ogc8CkBpJQYI2j5MtlXa6
	IxOrYjZq8slPpbDmlGZY101CYOUONG1h3+f8gpefRP8ohF0eEJFs8O6oPKqpoaki
	zim157uwjOZX1jhwXqeGl89ofo8r/Lx1P6fChwgTs14=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>, Vinod Koul
	<vkoul@kernel.org>
Subject: [PATCH 1/4] dma: Add devm_dma_request_chan()
Date: Wed, 15 Jan 2025 17:02:38 +0100
Message-ID: <20250115160244.1102881-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.48.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1736956966;VERSION=7983;MC=3912407175;ID=287147;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD94852647067

Expand the arsenal of devm functions for DMA
devices, this time for requesting channels.

Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
---

Notes:
    Changes in v2:
    * add prototype to header
    * fix ERR_PTR() mixup

 drivers/dma/dmaengine.c   | 30 ++++++++++++++++++++++++++++++
 include/linux/dmaengine.h |  7 +++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index c1357d7f3dc6..02c29d26ac85 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -926,6 +926,36 @@ void dma_release_channel(struct dma_chan *chan)
 }
 EXPORT_SYMBOL_GPL(dma_release_channel);
 
+static void dmaenginem_release_channel(void *chan)
+{
+	dma_release_channel(chan);
+}
+
+/**
+ * devm_dma_request_chan - try to allocate an exclusive slave channel
+ * @dev:	pointer to client device structure
+ * @name:	slave channel name
+ *
+ * Returns pointer to appropriate DMA channel on success or an error pointer.
+ *
+ * The operation is managed and will be undone on driver detach.
+ */
+
+struct dma_chan *devm_dma_request_chan(struct device *dev, const char *name)
+{
+	struct dma_chan *chan = dma_request_chan(dev, name);
+	int ret = 0;
+
+	if (!IS_ERR(chan))
+		ret = devm_add_action_or_reset(dev, dmaenginem_release_channel, chan);
+
+	if (ret)
+		return ERR_PTR(ret);
+
+	return chan;
+}
+EXPORT_SYMBOL_GPL(devm_dma_request_chan);
+
 /**
  * dmaengine_get - register interest in dma_channels
  */
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 346251bf1026..ffb54b52ef0c 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -1528,6 +1528,7 @@ struct dma_chan *__dma_request_channel(const dma_cap_mask_t *mask,
 
 struct dma_chan *dma_request_chan(struct device *dev, const char *name);
 struct dma_chan *dma_request_chan_by_mask(const dma_cap_mask_t *mask);
+struct dma_chan *devm_dma_request_chan(struct device *dev, const char *name);
 
 void dma_release_channel(struct dma_chan *chan);
 int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps);
@@ -1564,6 +1565,12 @@ static inline struct dma_chan *dma_request_chan_by_mask(
 {
 	return ERR_PTR(-ENODEV);
 }
+
+static inline struct dma_chan *devm_dma_request_chan(struct device *dev, const char *name)
+{
+	return ERR_PTR(-ENODEV);
+}
+
 static inline void dma_release_channel(struct dma_chan *chan)
 {
 }
-- 
2.48.0



