Return-Path: <dmaengine+bounces-4053-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 368069FA5FA
	for <lists+dmaengine@lfdr.de>; Sun, 22 Dec 2024 15:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 495DE163914
	for <lists+dmaengine@lfdr.de>; Sun, 22 Dec 2024 14:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D621E18BC06;
	Sun, 22 Dec 2024 14:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="H2ZO4sXR"
X-Original-To: dmaengine@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438DA944E;
	Sun, 22 Dec 2024 14:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734877341; cv=none; b=slWJY/xOwBXYQ7MzSEiCQqQUeIBbhTuxkWWCjjoR+GOIDvtVp5FzVlj1bitwkdOv5GHhY12TKjGDIn9MTXzrS1XwETvKbQxB5LGEtZLZEQNfZ4xoTr3A7HE2mlVQ3gbd3cpx3qk4bdrtqV88KmyyLbNjGQgP3Mk3cqeweHCnGRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734877341; c=relaxed/simple;
	bh=IEGvSFhtVaU7IIg+F5rNbkx+gAhz+j91Vd0PypKoxKk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ucuf7pMhNs8AnvAqhSHqakE1EbIcfcnpgqVGHlTHubU+5BgTZa/Ap9QdVgSNZxfMY6Bdl/dGaazg+PTFgGDaDtxz6n6QQB+REg7EpF7vCLvF7JmWl9BXIPT0CUiF+MVcO++X9ltLbNo0uxE8hz8+LUxOAyQBlDxdKx2b4rLOxKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=H2ZO4sXR; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 50F3AA0935;
	Sun, 22 Dec 2024 15:16:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=VxhcYhOSj+LsVywMUc6Ud+OSD2VqhTC1vahQGzjEy6w=; b=
	H2ZO4sXR5zhQfkJ/iu2Bfm38BqpE+IXyfvWZVAUj0cW78cz/oXxuuIvq2eVlvr8Q
	BPgZUx4Or9swHyDuiUMEpelweS6OWaK32Gcq6jRuTgT/NMHzaLjbu5YE0rNFm1ml
	8MTkC0hQfwx2mb+md43Xi7OqB266XZjuzkqc+d2nvchav+qZVVPnhTbXEh5oajP5
	SKBW6/FKd8ziv6hb07crZEPcb++/GnJeHcksX7T1Dsv8IDdDcosA6MwDsb7YcCwu
	65T07qyr74D8hrZqbwYFxk8PBW7PJZq23FTclbo1+RE7+Tg4emVBHDgbN/UpjJi3
	8V91O+M6OukCrPROBjn8J61Q4SYpGGQmUwIhLSHlkYaPhku2BSyz2lOGOjdP46zx
	f8oqioNa3L61GPNJK6nxPuilKNzhXwSEf/PdF8et7j/lQw2Rt1ndLrqWNaUV4pmL
	R8SWrPXEVednBXjm/jkKJW08l3ZwZacSXpKuYmbqeZCZhydUAYzNBtCGhbvnkiXE
	V7IlXKUFyE73pFd1nmMWyGCB8fMDFENjNm3aG5wx2mZ3HohEPeXDst7/NwZmOW35
	lsvknuhTUINld3+FdI2gyzqazOlxYaN6jcpMW4nQk++8YzyC8+tZ1z2xxNGxwzJG
	0c0xOsNsbKz22yqTPsO1FDGKdu6rHbE0JOd/5INpWDQ=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>, Vinod Koul
	<vkoul@kernel.org>
Subject: [PATCH v2] dma: Add devm_dma_request_chan()
Date: Sun, 22 Dec 2024 15:14:28 +0100
Message-ID: <20241222141427.819222-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1734876971;VERSION=7982;MC=3328339104;ID=117901;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D948556D7C61

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
index b137fdb56093..631519552c5a 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -1521,6 +1521,7 @@ struct dma_chan *__dma_request_channel(const dma_cap_mask_t *mask,
 
 struct dma_chan *dma_request_chan(struct device *dev, const char *name);
 struct dma_chan *dma_request_chan_by_mask(const dma_cap_mask_t *mask);
+struct dma_chan *devm_dma_request_chan(struct device *dev, const char *name);
 
 void dma_release_channel(struct dma_chan *chan);
 int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps);
@@ -1557,6 +1558,12 @@ static inline struct dma_chan *dma_request_chan_by_mask(
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
2.34.1



