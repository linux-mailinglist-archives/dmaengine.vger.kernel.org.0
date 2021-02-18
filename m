Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 486B431F003
	for <lists+dmaengine@lfdr.de>; Thu, 18 Feb 2021 20:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbhBRTji (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 18 Feb 2021 14:39:38 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:33176 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233722AbhBRTFk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 18 Feb 2021 14:05:40 -0500
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C5C8F4017D;
        Thu, 18 Feb 2021 19:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1613675068; bh=HgBWigwAxB7eheFeZ/WqKgGaKwYGWPCGszdI1WGyB1o=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=jBewgOC5hJEKTHMvMLVCF0wVmSaTPDO3h8du7VZJOQpTvEArdVPtPrsicw7OEfSng
         fsDjZU+DnzJkC0ml/xcDWrnxjgWHp7Sbkka4Mcxw0lxK3LuuucRGQmi6kS2h4Y8mEs
         QIGj5x80X75yf5BNvfsS3Xd3YT1yeyXnIT3NM/oQVmNPZXYQBBrqbJzDsE8WKq9UHb
         i95ydLtvZIoH5L2NqB3ozRFKl+DUwnok80/Fo9jXZJZrAIsa9C6H1nRE4gd0XP1TaR
         9afo9m8V8GR/tjBZzK0jjqH0zgiy7fp6o0u6Gp2kaZ8J9Kt5PEDVa9JEzomiGVJn4O
         Cnv/pmWCbuGug==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 932A3A01F1;
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
Subject: [PATCH v7 13/15] dmaengine: dw-edma: Change DMA abreviation from lower into upper case
Date:   Thu, 18 Feb 2021 20:04:07 +0100
Message-Id: <8c4b3db90767972a2b4cbb6fa818cf0e9c3d6fe3.1613674948.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1613674948.git.gustavo.pimentel@synopsys.com>
References: <cover.1613674948.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1613674948.git.gustavo.pimentel@synopsys.com>
References: <cover.1613674948.git.gustavo.pimentel@synopsys.com>
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
index a26d0d5..0793df1 100644
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

