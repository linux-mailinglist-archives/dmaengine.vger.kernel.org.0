Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B722DB2C3
	for <lists+dmaengine@lfdr.de>; Tue, 15 Dec 2020 18:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbgLORgc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Dec 2020 12:36:32 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:54442 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731289AbgLORbq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 15 Dec 2020 12:31:46 -0500
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 742E240476;
        Tue, 15 Dec 2020 17:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1608053446; bh=71t8kLn/h4uRT+rZrsVOIM9WjcoyjC97XsyNd4xo0/8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=HuUgsMsuLEO9vN/oLpFFd64Zo/Lspv/eMNDAnfOaiTxniSA8gQET3IunQiD4MI47z
         imXKsIWSBvrbZ4Vt1wpy79u9po+5cOCXW1rLSU2qAZycUTpifBGBKFoxei498HQ1MH
         ycCoMaDCwjOPo+KLoH78MOxhv8zvW8tAUFVnvdV8lqYE6VAOlU2poqbEOVSkEWNuDF
         mIVEGkGnO4JrvH1OIRvTFZ9EQOMBfhgsVOmYiA9e9SMoFvBbugdVwuy30ZStXVnHF9
         h4vxbO0HxxCep37eabbglneohB+2GovV76N/p547o6431q5bEhGVpt+PZLzd44viFW
         cTqIAY4ejaj7g==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 51D56A024A;
        Tue, 15 Dec 2020 17:30:45 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/15] dmaengine: dw-edma: Fix crash on loading/unloading driver
Date:   Tue, 15 Dec 2020 18:30:21 +0100
Message-Id: <615cabee7443a8f6fd054e6bf18c75985e81131c.1608053262.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1608053262.git.gustavo.pimentel@synopsys.com>
References: <cover.1608053262.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1608053262.git.gustavo.pimentel@synopsys.com>
References: <cover.1608053262.git.gustavo.pimentel@synopsys.com>
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

