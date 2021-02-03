Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4820330E572
	for <lists+dmaengine@lfdr.de>; Wed,  3 Feb 2021 23:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232768AbhBCWAd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 3 Feb 2021 17:00:33 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:52244 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232313AbhBCV70 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 3 Feb 2021 16:59:26 -0500
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E769FC011B;
        Wed,  3 Feb 2021 21:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1612389506; bh=71t8kLn/h4uRT+rZrsVOIM9WjcoyjC97XsyNd4xo0/8=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=RgfJV1LBCuVzrk7nQeg5tDASzoie2bzlzyQv4mQhuaIsPuFBooMy1T2A8eX/4hly3
         r25bPn02ezYWW96rZiXQPpaVF5uc77i2vKRpBk8cHnksostFwm6dJxHdi8TB65Mvd/
         LmKMQT1r/3TSV7L/Fv77g5h/DephWcfwm4/a7cS41RmNv9CY8EOBGtQYVdsyoDE3Nc
         U5+Qwg1HGfahlameacyYLeuqa6R4SlwAKr0+IPbKUs8NMDOv1KZb03fdLgxbptWnVT
         3bYtEq7IoYRWau1Gnbish55wTo3onD8fqFL4zMXbf7FQbeRoMDD7tVsHqpCaU1XKdB
         3tcn6Y46P9KqQ==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id B94FBA024B;
        Wed,  3 Feb 2021 21:58:24 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH v4 12/15] dmaengine: dw-edma: Fix crash on loading/unloading driver
Date:   Wed,  3 Feb 2021 22:58:03 +0100
Message-Id: <50d35480bcb5a7ea33649bbbcf296e148f5977b5.1612389406.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1612389406.git.gustavo.pimentel@synopsys.com>
References: <cover.1612389406.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1612389406.git.gustavo.pimentel@synopsys.com>
References: <cover.1612389406.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

When the driver is compiled as a module and loaded if we try to unload
it, the Kernel shows a crash log. This Kernel crash is due to the
dma_async_device_unregister() call done after deleting the channels,
this patch fixes this issue.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/dma/dw-edma/dw-edma-core.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 8d8292e..f7a1930 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -986,22 +986,21 @@ int dw_edma_remove(struct dw_edma_chip *chip)
 	/* Power management */
 	pm_runtime_disable(dev);
 
+	/* Deregister eDMA device */
+	dma_async_device_unregister(&dw->wr_edma);
 	list_for_each_entry_safe(chan, _chan, &dw->wr_edma.channels,
 				 vc.chan.device_node) {
-		list_del(&chan->vc.chan.device_node);
 		tasklet_kill(&chan->vc.task);
+		list_del(&chan->vc.chan.device_node);
 	}
 
+	dma_async_device_unregister(&dw->rd_edma);
 	list_for_each_entry_safe(chan, _chan, &dw->rd_edma.channels,
 				 vc.chan.device_node) {
-		list_del(&chan->vc.chan.device_node);
 		tasklet_kill(&chan->vc.task);
+		list_del(&chan->vc.chan.device_node);
 	}
 
-	/* Deregister eDMA device */
-	dma_async_device_unregister(&dw->wr_edma);
-	dma_async_device_unregister(&dw->rd_edma);
-
 	/* Turn debugfs off */
 	dw_edma_v0_core_debugfs_off(chip);
 
-- 
2.7.4

