Return-Path: <dmaengine+bounces-6386-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B819B4407D
	for <lists+dmaengine@lfdr.de>; Thu,  4 Sep 2025 17:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2436D1762D6
	for <lists+dmaengine@lfdr.de>; Thu,  4 Sep 2025 15:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC83244690;
	Thu,  4 Sep 2025 15:25:20 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6584521CC44;
	Thu,  4 Sep 2025 15:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756999520; cv=none; b=AO/9EzKLMQN2ZSGxZivKNVSPfG/m1BILHNXOa5bhxDwKMLgrwTp4ywBFP/QQwwNg8EHwH8us3VMKGiznFiSv76/E9MMgJQBkgc7iIS+/Zm5QOQCSl3GQFNZOPSTUaKtqdNAJFLzK60Hnet3ly8l4KpCb3Bq5dWgRZcUEFrM2t+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756999520; c=relaxed/simple;
	bh=/lh5dv0kjsOBpFk3AFUs/SfkJP1vvKYKfGJDOyWqMn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TVwJ1D7SYlDFGfwVoS7tl+ujSK+nWxAvlC/kbaK5QoposmGbr8Jj5ELxrT0M9R2IykMchkN7NYNw3OruO9vliEZhuywfb7uOGeFYBZqH+juw2cRC7a/jCDSN2nRb3RTxTg3zGU29hoO6TdjxOys1zzMu5xHGFhSM/cuG9hmmBio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09668C4CEF0;
	Thu,  4 Sep 2025 15:25:18 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Vinod Koul <vkoul@kernel.org>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: dmaengine@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/2] dmaengine: rcar-dmac: Convert to NOIRQ_SYSTEM_SLEEP/RUNTIME_PM_OPS()
Date: Thu,  4 Sep 2025 17:25:10 +0200
Message-ID: <0dc29f693d40fb4004f21ac816b2d005bd350675.1756999325.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756999325.git.geert+renesas@glider.be>
References: <cover.1756999325.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Renesas R-Car DMA Controller driver from
SET_NOIRQ_SYSTEM_SLEEP_PM_OPS() and SET_RUNTIME_PM_OPS() to
NOIRQ_SYSTEM_SLEEP_PM_OPS(), RUNTIME_PM_OPS(), and pm_ptr().  This lets
us drop the check for CONFIG_PM, and reduces kernel size in case
CONFIG_PM is disabled, while increasing build coverage.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/dma/sh/rcar-dmac.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index 6a6c3234702c648e..78dafa24c112ef3a 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -1728,14 +1728,12 @@ static struct dma_chan *rcar_dmac_of_xlate(struct of_phandle_args *dma_spec,
  * Power management
  */
 
-#ifdef CONFIG_PM
 static int rcar_dmac_runtime_resume(struct device *dev)
 {
 	struct rcar_dmac *dmac = dev_get_drvdata(dev);
 
 	return rcar_dmac_init(dmac);
 }
-#endif
 
 static const struct dev_pm_ops rcar_dmac_pm = {
 	/*
@@ -1743,9 +1741,9 @@ static const struct dev_pm_ops rcar_dmac_pm = {
 	 *   - Wait for the current transfer to complete and stop the device,
 	 *   - Resume transfers, if any.
 	 */
-	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-				      pm_runtime_force_resume)
-	SET_RUNTIME_PM_OPS(NULL, rcar_dmac_runtime_resume, NULL)
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				  pm_runtime_force_resume)
+	RUNTIME_PM_OPS(NULL, rcar_dmac_runtime_resume, NULL)
 };
 
 /* -----------------------------------------------------------------------------
@@ -2030,7 +2028,7 @@ MODULE_DEVICE_TABLE(of, rcar_dmac_of_ids);
 
 static struct platform_driver rcar_dmac_driver = {
 	.driver		= {
-		.pm	= &rcar_dmac_pm,
+		.pm	= pm_ptr(&rcar_dmac_pm),
 		.name	= "rcar-dmac",
 		.of_match_table = rcar_dmac_of_ids,
 	},
-- 
2.43.0


