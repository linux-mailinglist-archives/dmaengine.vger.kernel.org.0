Return-Path: <dmaengine+bounces-5064-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBCDAA9B17
	for <lists+dmaengine@lfdr.de>; Mon,  5 May 2025 19:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8874C1A80BFE
	for <lists+dmaengine@lfdr.de>; Mon,  5 May 2025 17:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CAD129A78;
	Mon,  5 May 2025 17:53:25 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E131DEFFE
	for <dmaengine@vger.kernel.org>; Mon,  5 May 2025 17:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746467605; cv=none; b=Wew+AxvgO1XEiIWBoNZK7ebBosZaVjyesmAWYw0I7LQw3MUIuVeTfSGNHJHspC3NIZhjnfHQSRKPGWtSMaNEkPSaohQo3EkBc6UTiz4bXDO0daPNx/ARLwtqH7khDIK8XTZDPM8D4iZm8LCNGLEJ1W86K3DE6FWTyg4NZ+leYh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746467605; c=relaxed/simple;
	bh=PB5Fp54bJa+r3bYxl1gPK2+wal+UWWfSGN4P2ziupo8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UoxmjmOoPpc+BT01kl5LFcSIn2uqaFQy1urJnHIApbiduyA83PdeZN19uMDAWt6rNwn4TPsTGXAoX0aHxZ2AfLNDRfhgkRSxHnmJny0O2JWEZDyNQNdhA7fqSh9dh61zLSBGoiuRe0o207mhV8AWlZ+sn9ZIwt/0Rnqs4PmCars=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 5 May 2025 13:53:07 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ben Collins <bcollins@kernel.org>
To: dmaengine@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Vinod Koul <vkoul@kernel.org>, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] fsldma: Set correct dma_mask based on hw capability
Message-ID: <2025050513-complex-crane-2babb6@boujee-and-buff>
Mail-Followup-To: dmaengine@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Vinod Koul <vkoul@kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

The driver currently hardcodes DMA_BIT_MASK to 36-bits, which is only
correct on eloplus:

elo3		supports 40-bits
eloplus		supports 36-bits
elo		supports 32-bits

This is based on 0x08 cdar register documention in the respective
reference manuals. Set the dma mask accordingly.

Feedback from Arnd Bergmann:

- Use match data to set address bit mask

Signed-off-by: Ben Collins <bcollins@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: dmaengine@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/dma/fsldma.c | 20 ++++++++++++++++----
 drivers/dma/fsldma.h |  1 +
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index b5e7d18b97669..566db5a1b0bab 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1226,6 +1226,8 @@ static int fsldma_of_probe(struct platform_device *op)
 
 	fdev->dev = &op->dev;
 	INIT_LIST_HEAD(&fdev->common.channels);
+	/* The DMA address bits supported for this device. */
+	fdev->addr_bits = (long)device_get_match_data(fdev->dev);
 
 	/* ioremap the registers for use */
 	fdev->regs = of_iomap(op->dev.of_node, 0);
@@ -1254,7 +1256,7 @@ static int fsldma_of_probe(struct platform_device *op)
 	fdev->common.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
 	fdev->common.residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
 
-	dma_set_mask(&(op->dev), DMA_BIT_MASK(36));
+	dma_set_mask(&(op->dev), DMA_BIT_MASK(fdev->addr_bits));
 
 	platform_set_drvdata(op, fdev);
 
@@ -1387,10 +1389,20 @@ static const struct dev_pm_ops fsldma_pm_ops = {
 };
 #endif
 
+/* The .data field is used for dma-bit-mask. */
 static const struct of_device_id fsldma_of_ids[] = {
-	{ .compatible = "fsl,elo3-dma", },
-	{ .compatible = "fsl,eloplus-dma", },
-	{ .compatible = "fsl,elo-dma", },
+	{
+		.compatible = "fsl,elo3-dma",
+		.data = (void *)40,
+	},
+	{
+		.compatible = "fsl,eloplus-dma",
+		.data = (void *)36,
+	},
+	{
+		.compatible = "fsl,elo-dma",
+		.data = (void *)32,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, fsldma_of_ids);
diff --git a/drivers/dma/fsldma.h b/drivers/dma/fsldma.h
index 308bed0a560ac..2ea57df9b7f7d 100644
--- a/drivers/dma/fsldma.h
+++ b/drivers/dma/fsldma.h
@@ -124,6 +124,7 @@ struct fsldma_device {
 	struct fsldma_chan *chan[FSL_DMA_MAX_CHANS_PER_DEVICE];
 	u32 feature;		/* The same as DMA channels */
 	int irq;		/* Channel IRQ */
+	int addr_bits;		/* DMA addressing bits supported */
 };
 
 /* Define macros for fsldma_chan->feature property */
-- 
2.49.0


-- 
 Ben Collins
 https://libjwt.io
 https://github.com/benmcollins
 --
 3EC9 7598 1672 961A 1139  173A 5D5A 57C7 242B 22CF

