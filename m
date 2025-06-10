Return-Path: <dmaengine+bounces-5334-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36538AD3020
	for <lists+dmaengine@lfdr.de>; Tue, 10 Jun 2025 10:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 541413B6C4E
	for <lists+dmaengine@lfdr.de>; Tue, 10 Jun 2025 08:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120B2280CCD;
	Tue, 10 Jun 2025 08:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="KqYL8leP"
X-Original-To: dmaengine@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1371B280001;
	Tue, 10 Jun 2025 08:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749543783; cv=none; b=irulSgZaHDkHYneKIydCdt9EyIKLnZqHMhxsMKi3OEEYqgqMWgkUaXzdrXP/CTeEs3TjTPhznOPro2z9jtlalRYUIzbjg0JbxrEC0+CC3vUKCfU3oq/tC9NegGH/KTmMswzOJZoLmO3tEA6U0cvF6dglSCzgXwEQD2QJ5J4xJNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749543783; c=relaxed/simple;
	bh=RZYIPXpDN8oj5s1t15Isb+e1NRle6tqtT7usLRhl1MM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oOLEhm51/6PY+kHhm35uzRlfmp3WOidCXG0o8x/A2DD31/iT9a9FRc1Z1jbgd8gAf7amgz14N7cQNY6Q4gBMwSTqZ9/Tyxv7uqUtF2aoBpRcSBQoNR4unNFprEB/2yKLuNCbk/APesX5d7ItJMpW37y58jbRZHMEKf5v7UuJa1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=KqYL8leP; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 13436A0403;
	Tue, 10 Jun 2025 10:23:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=Pdrk+9maRsee0qVYskeN
	GJ6hDw5zw0BT5yTDbtuUL8o=; b=KqYL8lePuGKIAp2vckOl5PFO/lSuKWly+jUp
	iMCbuVBeW6yv+fGXONBocsQUNm30RuM+pFwi2DXY+W6+UmcmltQUYsm4h2704ETe
	P4tcMzFjJExDKEMagaEaFgc9q3EBHuqfB0HYQF085t2XzKNpDjSWad0Ge3dUFxvd
	bVenmrx2KoPNoVmgt2TmdtOOA99W8jnDU3+TnvShl2V95MAQELlABhxa/j/kFxLu
	OOdNdGuTvtjWT3UTTB2/s+00clIMlevN/RXIL63/2Oh7jaJM88YrBMqVXgurvEal
	pxtUlQfyoN9Ex74plaJ4b3nrMM8jtKl6lH68esWnmH/WKONThLbNg8kmBupXuVve
	pweIGNUxAaRGhw3dV6qga3Q3dVteSHLykiMCSKvd3r6f6e8YE+dRSYoYirxB6GN0
	+QPp2CUg+Yk0HtslvbKltcd0I+3FlebiiCQO+cI/lbRXKNqcG7+rPrUAM4fdapnK
	Olr54XX43t6Cor+D2EzO/tT7k1MCvh/qkFLwyG/W/wZKCoJwAW62X/j6bSt1Ow/9
	WEAYi3x7YClOD1NTviSN4WbiYgok7KYEM3kzz+zI7bEfP/++3lM1b5oG7Cosi+pQ
	Lwm5XUXZF6cFSDPnM+aPHymVlQjXCrxs5zr6k9GJ3FtCt3FHBxmLFxRavMt1Dc27
	SMcGUZ4=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>, Vinod Koul
	<vkoul@kernel.org>
Subject: [PATCH v7 1/2] dma: Add devm_dma_request_chan()
Date: Tue, 10 Jun 2025 10:22:53 +0200
Message-ID: <20250610082256.400492-2-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250610082256.400492-1-csokas.bence@prolan.hu>
References: <20250610082256.400492-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1749543779;VERSION=7993;MC=4106326459;ID=452479;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A296767155D62776A

Expand the arsenal of devm functions for DMA devices, this time for
requesting channels.

Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
---
 drivers/dma/dmaengine.c   | 30 ++++++++++++++++++++++++++++++
 include/linux/dmaengine.h |  7 +++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 758fcd0546d8..ca13cd39330b 100644
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
index bb146c5ac3e4..6de7c05d6bd8 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -1524,6 +1524,7 @@ struct dma_chan *__dma_request_channel(const dma_cap_mask_t *mask,
 
 struct dma_chan *dma_request_chan(struct device *dev, const char *name);
 struct dma_chan *dma_request_chan_by_mask(const dma_cap_mask_t *mask);
+struct dma_chan *devm_dma_request_chan(struct device *dev, const char *name);
 
 void dma_release_channel(struct dma_chan *chan);
 int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps);
@@ -1560,6 +1561,12 @@ static inline struct dma_chan *dma_request_chan_by_mask(
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
2.43.0



