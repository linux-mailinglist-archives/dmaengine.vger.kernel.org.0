Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B69520BA2
	for <lists+dmaengine@lfdr.de>; Thu, 16 May 2019 17:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbfEPPyC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 May 2019 11:54:02 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:14964 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfEPPyB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 May 2019 11:54:01 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cdd879f0000>; Thu, 16 May 2019 08:54:07 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 16 May 2019 08:54:01 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 16 May 2019 08:54:01 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 May
 2019 15:54:00 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 May
 2019 15:54:00 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 16 May 2019 15:54:00 +0000
Received: from moonraker.nvidia.com (Not Verified[10.21.132.148]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cdd87970000>; Thu, 16 May 2019 08:54:00 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        Sameer Pujar <spujar@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 1/3] dmaengine: tegra210-adma: Fix crash during probe
Date:   Thu, 16 May 2019 16:53:52 +0100
Message-ID: <1558022034-19911-2-git-send-email-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558022034-19911-1-git-send-email-jonathanh@nvidia.com>
References: <1558022034-19911-1-git-send-email-jonathanh@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1558022047; bh=H7yKOiWn/gWJCKzXmHm6sWp1R0p9KhjBr8HlVmTSUs4=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=Sc7VcSqOp8RiOQMulfNdhHvf7G8231rhH+Ju7f72YjJXVtRckUfIPhm/lJGElb3xd
         xl7HEw0eXfirkySbYdMcG+7oyuXiwJpgZUc2L73V6fOx9+qaK2nreZ0TozDK0dSRAo
         ABnNdk+Xxf8eWCjnqOVASWaB5x7Q3M/ZRGh6BXq5oT5cGOnY57JECMPjU2JBSbJnJm
         PuEanaYrekPybcCO6WJDXWiSPWA/xSxg/Zi6AMMxmClaEqC6T0cs8fOSnnkFPWnemz
         lCnLO9KQT9lZ6Mt+dz+jXZEOOYKLUjMtX6vILwXlTP3eCkmZ2HFzw/6LDBZkm+bLWq
         TleKn5z6lDZHg==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Commit f33e7bb3eb92 ("dmaengine: tegra210-adma: restore channel status")
added support to save and restore the DMA channel registers when runtime
suspending the ADMA. This change is causing the kernel to crash when
probing the ADMA, if the device is probed deferred when looking up the
channel interrupts. The crash occurs because not all of the channel base
addresses have been setup at this point and in the clean-up path of the
probe, pm_runtime_suspend() is called invoking its callback which
expects all the channel base addresses to be initialised.

Although this could be fixed by simply checking for a NULL address, on
further review of the driver it seems more appropriate that we only call
pm_runtime_get_sync() after all the channel interrupts and base
addresses have been configured. Therefore, fix this crash by moving the
calls to pm_runtime_enable(), pm_runtime_get_sync() and
tegra_adma_init() after the DMA channels have been initialised.

Fixes: f33e7bb3eb92 ("dmaengine: tegra210-adma: restore channel status")

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/dma/tegra210-adma.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index 21f6be16d013..3ec3d71acd25 100644
--- a/drivers/dma/tegra210-adma.c
+++ b/drivers/dma/tegra210-adma.c
@@ -845,16 +845,6 @@ static int tegra_adma_probe(struct platform_device *pdev)
 		return PTR_ERR(tdma->ahub_clk);
 	}
 
-	pm_runtime_enable(&pdev->dev);
-
-	ret = pm_runtime_get_sync(&pdev->dev);
-	if (ret < 0)
-		goto rpm_disable;
-
-	ret = tegra_adma_init(tdma);
-	if (ret)
-		goto rpm_put;
-
 	INIT_LIST_HEAD(&tdma->dma_dev.channels);
 	for (i = 0; i < tdma->nr_channels; i++) {
 		struct tegra_adma_chan *tdc = &tdma->channels[i];
@@ -873,6 +863,16 @@ static int tegra_adma_probe(struct platform_device *pdev)
 		tdc->tdma = tdma;
 	}
 
+	pm_runtime_enable(&pdev->dev);
+
+	ret = pm_runtime_get_sync(&pdev->dev);
+	if (ret < 0)
+		goto rpm_disable;
+
+	ret = tegra_adma_init(tdma);
+	if (ret)
+		goto rpm_put;
+
 	dma_cap_set(DMA_SLAVE, tdma->dma_dev.cap_mask);
 	dma_cap_set(DMA_PRIVATE, tdma->dma_dev.cap_mask);
 	dma_cap_set(DMA_CYCLIC, tdma->dma_dev.cap_mask);
@@ -916,13 +916,13 @@ static int tegra_adma_probe(struct platform_device *pdev)
 
 dma_remove:
 	dma_async_device_unregister(&tdma->dma_dev);
-irq_dispose:
-	while (--i >= 0)
-		irq_dispose_mapping(tdma->channels[i].irq);
 rpm_put:
 	pm_runtime_put_sync(&pdev->dev);
 rpm_disable:
 	pm_runtime_disable(&pdev->dev);
+irq_dispose:
+	while (--i >= 0)
+		irq_dispose_mapping(tdma->channels[i].irq);
 
 	return ret;
 }
-- 
2.7.4

