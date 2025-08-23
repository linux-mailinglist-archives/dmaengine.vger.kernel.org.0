Return-Path: <dmaengine+bounces-6170-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC24AB32A10
	for <lists+dmaengine@lfdr.de>; Sat, 23 Aug 2025 17:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD5E11BC33C6
	for <lists+dmaengine@lfdr.de>; Sat, 23 Aug 2025 15:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C3C2EBDD0;
	Sat, 23 Aug 2025 15:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAgudiOB"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08AB2EBBBE;
	Sat, 23 Aug 2025 15:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755964678; cv=none; b=WeaLRJB9JVUbRX6Hask25J1CpBnJxW4EkYd6n3kH+KXh5RIBZB9E2B7CqSS061IfQKhmaMyiIYBPZ1DcGFgNhDqJlxQcshfQHr4Hvf7QOWJOkv/9H6EOiG/95dDdw8/fmakvHG5SLe6821d097Oz+fgLQISE6b/qI7xkfF86BcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755964678; c=relaxed/simple;
	bh=pVQUvqJRO5H4sWHsAkGOHbGYc59txE4I2DP6q9gpHjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qfBga8hEpWgvgCAhUCgdKWT1gj7ueFhzovjo3sjrQtBmebQTGKyT2ylFnyC/X03aVq+Gxz4OVjXRexgBCUqZRdf7MgWNI1Kq0UONTZ9eUg+hF+5nM1MOKwvRd680+lug7AAImh/bcO9UOS/dgQQjkf7na1TAuL9Ron2HmuVb/CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KAgudiOB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD23BC116B1;
	Sat, 23 Aug 2025 15:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755964677;
	bh=pVQUvqJRO5H4sWHsAkGOHbGYc59txE4I2DP6q9gpHjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KAgudiOBs/ydEz7Y58Rut0JazrdH1up7gt3gCUfUXKuw+UnVYsonvPtJg3vchhnM7
	 kOfA9WWGjieQlf68ZZs7oj6+fL9R9SZOVUssw6YaLnKJrMgiy1D6wRHzp53xyUUk7g
	 r3bbW89sWFMnv7ct8puViNlM/ZeSTPlkS0BHydhJCZPtUo2JuE+kbO0GCXNDZ3ieds
	 jFXzWZSFHnJ+YP72rg4kENj7myFu8IkVw91IiTW0OVtXpKp9l4PWy2EULSjoy7bZXu
	 7evyz9/jIoOtmeEcqcbkMNNbuUD5LJAeic3whvG1tiGEQ/Ju93efldoTWG0sEygFl8
	 cDEGXocRB0zXQ==
From: Jisheng Zhang <jszhang@kernel.org>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/14] dmaengine: dma350: Support dma-channel-mask
Date: Sat, 23 Aug 2025 23:40:04 +0800
Message-ID: <20250823154009.25992-10-jszhang@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250823154009.25992-1-jszhang@kernel.org>
References: <20250823154009.25992-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Not all channels are available to kernel, we need to support
dma-channel-mask.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/dma/arm-dma350.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/arm-dma350.c b/drivers/dma/arm-dma350.c
index 6a6d1c2a3ee6..72067518799e 100644
--- a/drivers/dma/arm-dma350.c
+++ b/drivers/dma/arm-dma350.c
@@ -534,7 +534,7 @@ static int d350_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct d350 *dmac;
 	void __iomem *base;
-	u32 reg;
+	u32 reg, dma_chan_mask;
 	int ret, nchan, dw, aw, r, p;
 	bool coherent, memset;
 
@@ -563,6 +563,15 @@ static int d350_probe(struct platform_device *pdev)
 
 	dmac->nchan = nchan;
 
+	/* Enable all channels by default */
+	dma_chan_mask = nchan - 1;
+
+	ret = of_property_read_u32(dev->of_node, "dma-channel-mask", &dma_chan_mask);
+	if (ret < 0 && (ret != -EINVAL)) {
+		dev_err(&pdev->dev, "dma-channel-mask is not complete.\n");
+		return ret;
+	}
+
 	reg = readl_relaxed(base + DMAINFO + DMA_BUILDCFG1);
 	dmac->nreq = FIELD_GET(DMA_CFG_NUM_TRIGGER_IN, reg);
 
@@ -592,6 +601,11 @@ static int d350_probe(struct platform_device *pdev)
 	memset = true;
 	for (int i = 0; i < nchan; i++) {
 		struct d350_chan *dch = &dmac->channels[i];
+		char ch_irqname[8];
+
+		/* skip for reserved channels */
+		if (!test_bit(i, (unsigned long *)&dma_chan_mask))
+			continue;
 
 		dch->coherent = coherent;
 		dch->base = base + DMACH(i);
@@ -602,7 +616,9 @@ static int d350_probe(struct platform_device *pdev)
 			dev_warn(dev, "No command link support on channel %d\n", i);
 			continue;
 		}
-		dch->irq = platform_get_irq(pdev, i);
+
+		snprintf(ch_irqname, sizeof(ch_irqname), "ch%d", i);
+		dch->irq = platform_get_irq_byname(pdev, ch_irqname);
 		if (dch->irq < 0)
 			return dch->irq;
 
-- 
2.50.0


