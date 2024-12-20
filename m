Return-Path: <dmaengine+bounces-4047-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F104A9F92E8
	for <lists+dmaengine@lfdr.de>; Fri, 20 Dec 2024 14:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C747167D29
	for <lists+dmaengine@lfdr.de>; Fri, 20 Dec 2024 13:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22CC204567;
	Fri, 20 Dec 2024 13:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="uPYi5/R6"
X-Original-To: dmaengine@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5CB1C5F08;
	Fri, 20 Dec 2024 13:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734700490; cv=none; b=PoQkzK0p0pOc8NYorar1esBqPPIecj9s+q4DrdYH6qp6lNf7XBMo3l57UjDMbMN934zH3jgVSqvTcjr6HOLweRiIKZoOqlI9UmfujAEjBQWVtBeO2GzKjfUpPgH4wnf+XoGxT74+8WBi9GHKIb4A9B8/9Pi1xNLHgd95zAfPN10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734700490; c=relaxed/simple;
	bh=J9s++7+n7Osjq4FuA9y/ZlxSsDdN1LHBgNaYzPsz0Z4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fOXjlPxnYI+jdEQ6sdczezp505BvLnPHbxx6AGp8bmzyjLmxZe0VWt1kvC1Ed2cm8ChRbld6k/BarvA9yeI2Geg6N036fkEemhVPM7eSlVeNa1Ouiu7tW1642Nas+6eGMZjKH0Xqv71W16eJrsIRduVVbQxsfKykPz65X5rRqWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=uPYi5/R6; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id A7CAEA0678;
	Fri, 20 Dec 2024 14:14:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=ubX47GRgDZiiX4C3rh2YehKOAgk4ebD9j/yjMeGAS08=; b=
	uPYi5/R62pcZNenlo6c/4pxKsWGnRASWf73U5ZIhRRdEnqkHk1xzB0l5n1grZXa7
	tS+Z7rKYUolYwLcFbhvSrkgWkQc3AhYtxV5t86KWy3XkrTehBSyMZmrwoCFyyyIs
	NaBp11ditDU8wRAKP2aAemm3JT7qGoOUppICfHfnpc9C1dbLg3B8WJXLqP1WJ4U9
	ML6HfNKIQ61xq3BObTgGVPFNG/iyLlfqoOpt/jkH6Rx3otTYhC5kq45Y7DMtrph3
	4uIPARPn6iBSDmQ5UbQWBhh4f/8WMksfQw48dH1+PbSy+Z+AwIB7ZVx7pErI0XoH
	RcEN8P3YpTPGmXTWQVagD5kJ566uayYSRld9Hwh9rZ72krm43vaDzXYipO3/jnms
	f0S6siyB5suCNMnvZudM3d8MhJvRilxqG4Ylfnx2XxaNlMcjqYs4mc68hXMPz63Q
	MmTuiTrvSyb1PqEPABIB0U+Pk56JNU66vagBj8Scyg4vRx4/UTs55Qteb6b919Pn
	GOKKPygyAV8WfBTa0UN3Fyn+pUnSnV7EB2r6uSTvbysOtUj1YbLPMxJ94ivtt3Sc
	I1u9Voov7cXwf2LVuTs5c/qHxhzYdGKWnCquBq3zZQgui/bSKrYX4A6fBYgF+a4+
	UbYmKVpx5SYxxVIaYuOBujWxS/73hF/Vak2XqrJamGU=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>, Vinod Koul
	<vkoul@kernel.org>
Subject: [PATCH next] dma: Add devm_dma_request_chan()
Date: Fri, 20 Dec 2024 14:13:49 +0100
Message-ID: <20241220131350.544009-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1734700476;VERSION=7982;MC=2694048673;ID=103848;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D948556D7261

Expand the arsenal of devm functions for DMA
devices, this time for requesting channels.

Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
---
 drivers/dma/dmaengine.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index c1357d7f3dc6..51c41664838d 100644
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
+		return PTR_ERR(ret);
+
+	return chan;
+}
+EXPORT_SYMBOL_GPL(devm_dma_request_chan);
+
 /**
  * dmaengine_get - register interest in dma_channels
  */
-- 
2.34.1



