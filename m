Return-Path: <dmaengine+bounces-4755-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C7EA651E1
	for <lists+dmaengine@lfdr.de>; Mon, 17 Mar 2025 14:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 104483A9112
	for <lists+dmaengine@lfdr.de>; Mon, 17 Mar 2025 13:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8679223ED6F;
	Mon, 17 Mar 2025 13:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="FR70WLvu"
X-Original-To: dmaengine@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E178523ED62;
	Mon, 17 Mar 2025 13:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742219636; cv=none; b=hQpJB/pgDVReiFsV+QOSaFBP8GeLbGAvfKPkAKcYHgQ9XcI4XdtuVCDlnEqiWj2t3NND3US9d0MOPqT98g3rvQHCxd8Oy6EhDPP0xkMJz4oYnQRQ+97jW8A60Y/g56Cj8TF13JMwQJA82GiwO0F3oLnRWegEnYKxWvXqck6Axcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742219636; c=relaxed/simple;
	bh=8o2FV10LXPS4y7YD+bAR/nC38xtiWW6pVIGBKd15Qgc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ffe1obXIkzq1YkqHzkg3UfzU34pqFB3CY0HdHUcSTTQYbiy/WC+MLpMeK6XCX9fe1qAcjqY/3v8abhYWX8tkOP0zLYt4zKW0ce78McLZVQKzskROdmNPRxU4GSYXSvpUqP1SHeYZxWyvmdpnN4eiFRyio/L1SPUQQ3H9wY/+0LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=FR70WLvu; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id BEAA7A0467;
	Mon, 17 Mar 2025 14:53:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=0o1CqcnBoa+erxXQ17CZ
	+o4z6tIXyZBWdDbU2LmsN1k=; b=FR70WLvufFS1XAW4FDl9sbvqGKaMAd556gTP
	HHK3QzFWZXQJmhHdrlN7wd6SfDae3q+/TyJXn324oJy+/nEC6WRLPXpHbQgDCu8j
	jkCsfKwSxSl5L+dA8G4UshCyxMdbjCBf2Hd5CIwI0N3yNF908QdK7sMkwdwVEBRh
	mBg/KQrJgyJxDKliq80tPPvsF6wLHqiQx6ccVbMIrim3DiKA5sBiVG08NcuY0WLv
	aEPPrPR5Xs+BL/M0B27hjFk5+lNtZbKe1NSfKTRthkbNzOKHzl434ot8Dk0a0O4I
	guxQciGRCFDCCrgDQfMQ8c7H7n+SNLkHKQ79OMvp9Wn2vjkipdzqE94zxYCO12HA
	7Ort2EGIsRtlt0Jh+x1/qF9xyqt1ksAMJ8x1dyoujWAZ3SwDr8338DoPkx9WMoH1
	53NJbgI4H+3+TSvBWzNfkGR0uhYU2Sw7vCiGBwQnueT7c/VHZB2jdLxePGSuMfGP
	qLog3rMy8YaEbKwu7Oq/9ScZiOu8qdno4EQQzk2Dkz1MGje9U0rHa+2YTWwbbYv8
	DqCrfFJlhyjXztE4FV+XoaZ8EzPjPheS7fxHeq+nME+WEhfDT0FgiBjQRHlUrk4k
	67pRzl1EhR4G09+XTfLjioaQSJ60TWQbtCIHJNkoLGHWFsgnyT6zBLh41q+ClHHb
	rV4YvZs=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>, Vinod Koul
	<vkoul@kernel.org>
Subject: [PATCH v4 1/2] dma: Add devm_dma_request_chan()
Date: Mon, 17 Mar 2025 14:53:37 +0100
Message-ID: <20250317135340.382532-2-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250317135340.382532-1-csokas.bence@prolan.hu>
References: <20250317135340.382532-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1742219631;VERSION=7985;MC=2159532761;ID=155897;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD948526D7460

Expand the arsenal of devm functions for DMA devices, this time for
requesting channels.

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



