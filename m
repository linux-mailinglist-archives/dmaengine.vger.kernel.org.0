Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B133186F1
	for <lists+dmaengine@lfdr.de>; Thu, 11 Feb 2021 10:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhBKJTv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 11 Feb 2021 04:19:51 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:56858 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230124AbhBKJOM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 11 Feb 2021 04:14:12 -0500
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 07DFEC00C9;
        Thu, 11 Feb 2021 09:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1613034789; bh=yp46md2f1aLH/kML4cPAiVttSwNoyzCG7t+Fe4rx+gc=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=RQg2PShq6RJa6t+/+akzZDq4lUTz6F4oGYSvy1RjQzC2bYST0nBUsQd7NhhBmfLZf
         +NA9Df3BOUjLVzZCsnxcbO7L6czCr97f4esA4gXcK06Be5uJYcIopHoAIhj4UQ1y3c
         r/tvzMWDm61awmdU0FSw5ORxu0CAsGUGnRpnfIC9h/3RUFJMLfo9JTBva2OHSYu1G9
         iLM4Q1GB9On5nfH107qVNTUuO9tQXPLOQsNz+lnhQTSeRBJVq+Ohwq/Ni7xJl+IJbG
         hXe2whNAS2yL5F1N/N16SEs6aLfO8I+qR39eSeCgVoCjzI4eT8qSX145a+oktn+2kw
         tkJH17tyZEGkw==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id C3AC7A005D;
        Thu, 11 Feb 2021 09:13:07 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH v5 13/15] dmaengine: dw-edma: Change DMA abreviation from lower into upper case
Date:   Thu, 11 Feb 2021 10:12:46 +0100
Message-Id: <3d3eb4fbf48cb5a2eee54332f3f09cdb541b5718.1613034728.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1613034728.git.gustavo.pimentel@synopsys.com>
References: <cover.1613034728.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1613034728.git.gustavo.pimentel@synopsys.com>
References: <cover.1613034728.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

To keep code consistent, some comments with dma keyword written in lower
case are now in upper case.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/dma/dw-edma/dw-edma-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index f7a1930..a299eed 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -341,15 +341,15 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 		return NULL;
 
 	switch (chan->config.direction) {
-	case DMA_DEV_TO_MEM: /* local dma */
+	case DMA_DEV_TO_MEM: /* local DMA */
 		if (dir == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_READ)
 			break;
 		return NULL;
-	case DMA_MEM_TO_DEV: /* local dma */
+	case DMA_MEM_TO_DEV: /* local DMA */
 		if (dir == DMA_MEM_TO_DEV && chan->dir == EDMA_DIR_WRITE)
 			break;
 		return NULL;
-	default: /* remote dma */
+	default: /* remote DMA */
 		if (dir == DMA_MEM_TO_DEV && chan->dir == EDMA_DIR_READ)
 			break;
 		if (dir == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_WRITE)
-- 
2.7.4

