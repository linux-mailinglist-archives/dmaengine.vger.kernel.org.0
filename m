Return-Path: <dmaengine+bounces-6388-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3652CB440A2
	for <lists+dmaengine@lfdr.de>; Thu,  4 Sep 2025 17:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F269E168DCE
	for <lists+dmaengine@lfdr.de>; Thu,  4 Sep 2025 15:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082811ADFFE;
	Thu,  4 Sep 2025 15:30:16 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E140A1A288;
	Thu,  4 Sep 2025 15:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756999815; cv=none; b=FqesoLXUpHlaPrChbGZg1oUXjxAAIt4Y0XlSC58cbj+nIu/oJbXhxLzqvSDmDc9e4lE4IouDsw/3elS8AgwtoaYzxrjQ788f1bKlQyOc+rHlkWPDaE0PmXzgI3Q4VY2XJFjPNWwqTvGdhH5uyZEtBBMBwKdYiV2uQaL9Es9zBQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756999815; c=relaxed/simple;
	bh=LshMpuJ/WWW1PZtS6QMbKpsOqsD23JypN7dKT/OmCaM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZGC9o90QZXXQGoU8aU4KurcXPp9FCEwmdpu7aV4h61gqsDxt73oyw5GveJCJ28seYRqNM2OLUacSGuhHMM0ids6oCNFEF2e3LO4BkJfNI+E8AGX3HJImBe2D2+A1b0KUB8T/ZyxxTDg+xJraPyn8dHCvdywGEtHv0RUoVZ6fHBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABD3AC4CEF0;
	Thu,  4 Sep 2025 15:30:14 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Vinod Koul <vkoul@kernel.org>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: dmaengine@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] dmaengine: sh: usb-dmac: Convert to NOIRQ_SYSTEM_SLEEP/RUNTIME_PM_OPS()
Date: Thu,  4 Sep 2025 17:30:08 +0200
Message-ID: <f456411acfab95f8a4213156fbbabfb90e220a59.1756999732.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Renesas USB-DMA Controller driver from
SET_NOIRQ_SYSTEM_SLEEP_PM_OPS() and SET_RUNTIME_PM_OPS() to
NOIRQ_SYSTEM_SLEEP_PM_OPS(), RUNTIME_PM_OPS(), and pm_ptr().  This lets
us drop the check for CONFIG_PM, and reduces kernel size in case
CONFIG_PM is disabled, while increasing build coverage.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/dma/sh/usb-dmac.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/sh/usb-dmac.c b/drivers/dma/sh/usb-dmac.c
index 7e2b6c97fa2f97f2..b42e5a66fd95759e 100644
--- a/drivers/dma/sh/usb-dmac.c
+++ b/drivers/dma/sh/usb-dmac.c
@@ -670,7 +670,6 @@ static struct dma_chan *usb_dmac_of_xlate(struct of_phandle_args *dma_spec,
  * Power management
  */
 
-#ifdef CONFIG_PM
 static int usb_dmac_runtime_suspend(struct device *dev)
 {
 	struct usb_dmac *dmac = dev_get_drvdata(dev);
@@ -691,13 +690,11 @@ static int usb_dmac_runtime_resume(struct device *dev)
 
 	return usb_dmac_init(dmac);
 }
-#endif /* CONFIG_PM */
 
 static const struct dev_pm_ops usb_dmac_pm = {
-	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-				      pm_runtime_force_resume)
-	SET_RUNTIME_PM_OPS(usb_dmac_runtime_suspend, usb_dmac_runtime_resume,
-			   NULL)
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				  pm_runtime_force_resume)
+	RUNTIME_PM_OPS(usb_dmac_runtime_suspend, usb_dmac_runtime_resume, NULL)
 };
 
 /* -----------------------------------------------------------------------------
@@ -894,7 +891,7 @@ MODULE_DEVICE_TABLE(of, usb_dmac_of_ids);
 
 static struct platform_driver usb_dmac_driver = {
 	.driver		= {
-		.pm	= &usb_dmac_pm,
+		.pm	= pm_ptr(&usb_dmac_pm),
 		.name	= "usb-dmac",
 		.of_match_table = usb_dmac_of_ids,
 	},
-- 
2.43.0


