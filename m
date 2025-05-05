Return-Path: <dmaengine+bounces-5067-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A97AA9BEA
	for <lists+dmaengine@lfdr.de>; Mon,  5 May 2025 20:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB5F816F4C1
	for <lists+dmaengine@lfdr.de>; Mon,  5 May 2025 18:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7187826E17D;
	Mon,  5 May 2025 18:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="e8cXzcSy"
X-Original-To: dmaengine@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66CB269B02;
	Mon,  5 May 2025 18:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746470986; cv=none; b=XgmP0euhSCZ1V/23lf6f1Iax7twsldZraC/GVvCfbxh/ajVr8MCBDsXVbTk8HADYacxFlvmAmEcOlg0gEp3IkrzYu2bemPmzTVS11uZGKtNMzn5ZD+93fiPioNaBNSrra3Xkg5tJJgX9tXu8bCM1G+29rwQ0OYOqrUHvoLhrJ0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746470986; c=relaxed/simple;
	bh=R8M59vxHAjUlkD4wexaKntih0q/NCGKUE+K4wXaJ7YA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AMUkZcUP/bZ62JdiLUOXqK2hXqKGy32UR+O48gHhR+7G19bGuXxxOz7HzmUIv5fn74Ln+RfTGIuvFDHESK0rlyUzTd9Q9YE0ax6wYBXMk2xpNmXpHNlaCs/NFmUb8JsmDaXJXrETUXQrNGSZACrB2Lzxg0okEIOnl1MObFmLRYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=e8cXzcSy; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 73B05A09FF;
	Mon,  5 May 2025 20:49:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=Ev/Q0RIsmgy1mBqoL4mI
	cg60ZAPn1CqjIwINVPt8wj8=; b=e8cXzcSyQPxXYdsu/U42CdYPKRUSg0Z0SQ1z
	Y3SasSSCXe5iGzcK1CoS5lrAyoqikJpJi9PjpfMRaDgnsmCME0dwDDNx+KuQ9L6F
	7XNNhlN8znhvOADpwDfzWtBWjAEGXL2SyZ8hrKJ3DXgwPWKsb6icoFLB5GfXP0cb
	MoBjdjue4nQ+oWPayhOWopS+05UHMhCnBnpG5oH4Hzh6suAcyNYt7Ld2x/UCyQB0
	2VdmOiAOUf8+/VXNtmF9uuapIdO15TYg95PZTcaSiAGnDg6svQLEdW/VS6nsuYdN
	feukDGtGCe7ghrlOefnAdsy6fC0/26+GUua34Su7IP19JtejdWik81D5XzKoSpNY
	JJ3C7V4LCvTe9rSn4sZQlIZz7OSH1fzeKf9YtiotGTa5fvdf9CgVytJv6bjZY1Ls
	pbm4U0nuMxNycvNkXIt/X4PHwiJDGG+VZXANtY+zEan+P5cCRHCHXv5OyuBpOnI/
	mNtb2Oziv72ETHwECJcO/6ybG2J8JcQZ0kEB1o1Qw9tDEaLTpmt7NyGxxHKUWvQR
	93OqPDPkIFmTMiDbHKbfXoZLO/7G95N3B3/bTVD8e7qcrKJYEyZtZ8tI3Pld8vph
	z5qxcNOgPF/ALp5nOgCoYhqzuhnn0GL7vKh27cKgW6pmUFmfDdPp5o34P/IL/lX0
	njMOkMI=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>, Vinod Koul
	<vkoul@kernel.org>
Subject: [PATCH v5 1/2] dma: Add devm_dma_request_chan()
Date: Mon, 5 May 2025 20:49:33 +0200
Message-ID: <20250505184936.312274-2-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250505184936.312274-1-csokas.bence@prolan.hu>
References: <20250505184936.312274-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1746470979;VERSION=7990;MC=2492889595;ID=217952;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94853667166

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
2.49.0



