Return-Path: <dmaengine+bounces-4327-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FCDA2C2FE
	for <lists+dmaengine@lfdr.de>; Fri,  7 Feb 2025 13:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53BB63A5078
	for <lists+dmaengine@lfdr.de>; Fri,  7 Feb 2025 12:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0222417C9;
	Fri,  7 Feb 2025 12:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="Cj49GtWn"
X-Original-To: dmaengine@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6354E1DED70;
	Fri,  7 Feb 2025 12:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738932490; cv=none; b=sLGQ4u2qbDc0t7vtQanqGUqlJaCvthGwLUpPg6QQYi1hPpoMclKd82xXtOgEdWcHF8DhdoXBXllWeQIJyNeQ8/0rB5X8YTgtrE8VrHMRXNgcljy3tjS4rjbEqxZJKPThKnpD8+tz7YjQAXLeReGyQSysJTZ5VClxE/+wG4tV4s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738932490; c=relaxed/simple;
	bh=x39wM5IEXku0agPTtfPWYboyk7mBbtqeLmPY+Swh07A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rk1c443lQoiop6oNmGAG+L+z7IsOTjBVVXThni+uqB0YCW6hm1RoeFLGkEcrJGhU+mcvIexhWtyR76IoNjRRNMKjPetJjLEDYbIAsWfEUi0ybbmcW+J2pyVMxtXbXT1a4MgdVypdMeGuBy0T1MlWk5h3NpBuNyXKoH95tUkO77k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=Cj49GtWn; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id B1951A09FC;
	Fri,  7 Feb 2025 13:48:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=/dPRX9W95wzwQTmmvdwr
	EPqh/JERYDW6ukU8wyxlrOs=; b=Cj49GtWnNikMKrlhBy9CrWtuFG7ToGN7lYLN
	roKdArvClJN/66DZiL8F8W8Qid4j3VOuOCNz5izilCAtQb+TmVCfnIoY5n5y1fQ8
	kHrm2+lFA4GX9fAOaV7r7LzZFaQu6o4hqThrXbnsNXrnOOA2qV8gxCVMlY+UnKLc
	PKFiaLMoiCHvzOcturt6qeJceXeJz0R/gNjipw8r7vj9rsm/TQVFEISewEjoJDcL
	cIjPr8jM6rSQPxuFFVYx5MktzOjjtybPGsf22pmBFL8Xd5bNkzlJ+EMqDGoY9A9y
	frYVt6CY1o1VGkjtG5tqP6qFyd6iTwP/rrNypraXurwOu1Ox0qJue0WRYkVioFNa
	e/dxfx4JrKvMzq5LQtPi98uVaiovjrsjykE52IJ8GhOspvm92SIeNv+4sqN7Ds+3
	WNPVMVOyqE6whXTL9O9L5QMkegz30J+J/ajxEEE2BvUMQdKCX8PVhO2+eR1SvNNo
	GsEfm8oAb1CM+pC5Sva3oB2VfDYZNN9v6GQ/EPJj30DORQ54ZlZ9xMhlfMSz1ZJo
	z+GJQFtAojXh4I9e0sJ5eeIYoZKXLaAaFKaXjVrgIBT6jrOW26zazPWdmWzdCk5u
	wA2UCKOypjeMjDhu9sRxPOBy2KfOot2qAyFYZ/7OnMiRgyvqMSIujLzJHf+gWmJK
	Ef7fnPQ=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>, Vinod Koul
	<vkoul@kernel.org>
Subject: [PATCH for-6.14 v3 1/4] dma: Add devm_dma_request_chan()
Date: Fri, 7 Feb 2025 13:47:56 +0100
Message-ID: <20250207124802.165408-2-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250207124802.165408-1-csokas.bence@prolan.hu>
References: <20250207124802.165408-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1738932486;VERSION=7985;MC=2997032330;ID=401533;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD94852617560

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



