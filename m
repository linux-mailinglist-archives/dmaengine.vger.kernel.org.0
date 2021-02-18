Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD26231F002
	for <lists+dmaengine@lfdr.de>; Thu, 18 Feb 2021 20:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbhBRTjf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 18 Feb 2021 14:39:35 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:37768 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233720AbhBRTFk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 18 Feb 2021 14:05:40 -0500
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 30A4DC00A1;
        Thu, 18 Feb 2021 19:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1613675068; bh=ihJyBFKL01a29YggVG9CNl6OEXj0a5ndJ0t7B8pMh6E=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=eChp5WyzOT8V2jTilL6b6lJSrYtZvYbu/bQATUyfGn2p4yZaPYo7Ke5qlz1k4zb2y
         8VjiCxT1wua8W13RK3wQ5TFWh7CpcidCzqrEI4GXRvVkMOnNp9FXXeR/BcprN6R9h7
         SyVSVWY4O3BD89O0sRpyTAi8p6XqSg6e/3dcpMecPLx4HkZ9wKBdziYNI/CxSpiO21
         4Aln58kQ858QaPdheFpWjNfmd3dB4h/Aj8HZcdWSxsAWjxpHCdowKWlVydYhDRPhPe
         Y3UC1PI230q9yRL3mDANBbwok02JYHHMC6RVUMbVgIZA6QEtX6iHmAVfj9ulcbxpGQ
         tLksauah8vZLQ==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 02010A0063;
        Thu, 18 Feb 2021 19:04:27 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH v7 12/15] dmaengine: dw-edma: Fix crash on loading/unloading driver
Date:   Thu, 18 Feb 2021 20:04:06 +0100
Message-Id: <4aa850c035cf7ee488f1d3fb6dee0e37be0dce0a.1613674948.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1613674948.git.gustavo.pimentel@synopsys.com>
References: <cover.1613674948.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1613674948.git.gustavo.pimentel@synopsys.com>
References: <cover.1613674948.git.gustavo.pimentel@synopsys.com>
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
index bc94c8d..a26d0d5 100644
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

