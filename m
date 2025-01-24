Return-Path: <dmaengine+bounces-4183-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CCCA1B202
	for <lists+dmaengine@lfdr.de>; Fri, 24 Jan 2025 09:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FE1E188F24C
	for <lists+dmaengine@lfdr.de>; Fri, 24 Jan 2025 08:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FD3218ADD;
	Fri, 24 Jan 2025 08:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="HRJ3XRli"
X-Original-To: dmaengine@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206EE1DB134;
	Fri, 24 Jan 2025 08:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737709004; cv=none; b=gtj2OOofPFG/yEoYUWvhpajUtpjXtrRn75TeMAPnRzHQWSDum5o3r8ohpJt2dSgPgY+snQ3d/8y+nUw4IimFk30iCQt04qRiM02yqP73a2s7D/iWaJz2yMwvioqdTvUiiNN/JVDenw9XBDqdkPeGjshK3p3aJb4ydHObrg5BGrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737709004; c=relaxed/simple;
	bh=x39wM5IEXku0agPTtfPWYboyk7mBbtqeLmPY+Swh07A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e7xiDU7m+v3iKHTsHgi8Fkrp9z9QfCLmtVBCi3Nh58vg6n3ZV+jK9jSfHXuVn2qG+g5GZ7Te78eRdAMLyVLVJ8+kqmWcCuaQnykeqlAmTYzzEH7Jn37zva6QG3KyhklDCbuOLShjiEvB4DYAcUBXrTbcNR1BVKuRam2VOWTuk7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=HRJ3XRli; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id DCBF1A09FF;
	Fri, 24 Jan 2025 09:56:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=/dPRX9W95wzwQTmmvdwr
	EPqh/JERYDW6ukU8wyxlrOs=; b=HRJ3XRli0bJqmqEkA5XizKxZ08cudSvu96Iw
	VumzdC99vsEJnvFL4SgTXbOd837Y795TwlVsW0Dk9j4J6GL1oxG9Eb+aPUHMo77L
	jGtLasYkWxk6enfuuSjXEiRjLNQr+efAuhn6RVLpe76HEWGbgVDYFtAZGohE8pw/
	vPdLzKhHsnpPXqEv5jU0MXPDdGL7/Uf1tgb92HDTAgLBfXhZsOm/ro605IOmy6is
	Pu8e/3b1ITFXd7ORkYXaWRdDO5SEdxzfqDsTQ5D3K3yMbaIag9h0Ya50RfXFVWfe
	Gj1DF7GRZ1QOgeLYkGZfpRQLe1IYxstFPYZzc60gW1jNwmpii57++Kq7Py2w/HNp
	Ci8HVZr9mxIPCL3bW4Ml8wW7llqrsnriL4UutQpgmmq/kF8ctA5i5XWIfqDd9OnA
	/fkhiYKYk5ry8T0OdRBWgWzXpGRAlv0CLdFBmQBsXxjzwZnpCzSeaMpEzrv/3AhJ
	VAG3XQIeKQBmDYGKVUlOlumZOrw6gRFvCxArevfYiV2SbbKzIteCw+a+LY2+L6lv
	P+2FLybnzYO/0SFJdw7HqRTyqktRu5i8LOaEG/5X0twYCOd3ZhGzIPNbN849NGn1
	mCB6pgKe8RyVjBrQ8kTHXaOIvF8vAs9OYP5qWjZt5magzJ82FiwLRMYM5aEbBiq1
	XboyO1Y=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>, Mark Brown
	<broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>, "Rafael J . Wysocki"
	<rafael@kernel.org>, <linux-spi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH v2 1/4] dma: Add devm_dma_request_chan()
Date: Fri, 24 Jan 2025 09:52:20 +0100
Message-ID: <20250124085221.766303-8-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250124085221.766303-4-csokas.bence@prolan.hu>
References: <20250124085221.766303-4-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1737708998;VERSION=7984;MC=241928571;ID=70499;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD94852677063

Expand the arsenal of devm functions for DMA
devices, this time for requesting channels.

Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
---
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
2.48.1



