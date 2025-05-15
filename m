Return-Path: <dmaengine+bounces-5174-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF7BAB80E6
	for <lists+dmaengine@lfdr.de>; Thu, 15 May 2025 10:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A8639E1D4A
	for <lists+dmaengine@lfdr.de>; Thu, 15 May 2025 08:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377552920AF;
	Thu, 15 May 2025 08:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="Ou8e9/td"
X-Original-To: dmaengine@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9261A288519;
	Thu, 15 May 2025 08:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747297905; cv=none; b=Ss1itlNOuJIVsapmJpGdWGgYylp0izW/WDKQWR80DSexwiiPUajlD0X/Yas6yNy4N3nF81V/1yAo0pzeaVtwc+MXy7HCkwmteuDyEzLrjt20dOCOwg4YrYqcXPRnICGXVinqXS0gOJgILRQSSR3cwPhCcD4k0F2ECmYPs2Rlro0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747297905; c=relaxed/simple;
	bh=RZYIPXpDN8oj5s1t15Isb+e1NRle6tqtT7usLRhl1MM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qALVBLqj1mut+Of9SPW1pgTWFis6G9hl4FH3jDuv05o9JjkcyqmuFitS37rQPK7JuL38DbOfGIAnO4mSHIwvpFJJ7Ki661UtyKM66DYdKOrB99lVbKlN/sKm+9+vsLfHHkLQ6t5fli0UBojr5IBdmoIKkDL6m9HDeR04wYgAljM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=Ou8e9/td; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id D1672A066B;
	Thu, 15 May 2025 10:31:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=Pdrk+9maRsee0qVYskeN
	GJ6hDw5zw0BT5yTDbtuUL8o=; b=Ou8e9/tdpwv/ky4sJqkdizpTc86Vbsy41D7k
	7dtyy5NbG6EGVlRPaHJJUwP65Fl7Cpkt9UyX2mKuA8YyI+eVyy/yCY8Q2yE8P+2r
	CpWG+gzlqS5h5PlYzlfsy+wnAS4uYXg0XU4kwk9GQdPCodKF5Cgtct6Q+QHiTv4h
	80vcQFjCwA2ICbc4yb++mNjbouEi3dujYLTsFN+dAzySNbQ/gk0Dd4j+roaIsuX5
	bvcpoZbeSpY1CWJ2n7/UUfndhON9j74py+fKqG5A3JHI90uOc/PlrZasUE+qKUt+
	9ZRFFGDMEV4Ikh4BtkxfZt1EEBJ0vx2HNcFV98vtGKlFiR6NRL6PH9Qr3A2A2pOr
	pkAUMqwsZrtg+r2KqB916/ix21PWzRLOcvcwPna/bgVKTx2/lnqrg5KTeWkWZr/G
	5+dvNLg/NxKABi9ucv6SulsI6ad/oSMCRcR5iJP4lRfjwjqnEVXPda/h2mcd/Hey
	Apr+VijNHbtVbBRtoLgMy0il4sUMVeazzjIcNDeje4wDzlrcv3iSpDlzoupVJAnb
	Ro2u9f9AtB64ZgC9COZSim1NwmpViJPTasGap7gpZxSwJG6XaPN6gNASVrN+ccDQ
	qGznIU2z+go78l01LtrIUtYjlf+r0I8h89c7ASmj0VAhifLu2mgChxGvWCIRG8UA
	i6zyeTA=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>, Vinod Koul
	<vkoul@kernel.org>
Subject: [PATCH v6 1/2] dma: Add devm_dma_request_chan()
Date: Thu, 15 May 2025 10:31:29 +0200
Message-ID: <20250515083132.255410-2-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515083132.255410-1-csokas.bence@prolan.hu>
References: <20250515083132.255410-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1747297898;VERSION=7990;MC=3872013306;ID=2670053223;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29BB64155D617062

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



