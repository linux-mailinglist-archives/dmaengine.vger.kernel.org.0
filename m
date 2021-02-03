Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A525730E1A6
	for <lists+dmaengine@lfdr.de>; Wed,  3 Feb 2021 18:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbhBCR7A (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 3 Feb 2021 12:59:00 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:40808 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232456AbhBCR6a (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 3 Feb 2021 12:58:30 -0500
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 9BDA7C010D;
        Wed,  3 Feb 2021 17:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1612375048; bh=yp46md2f1aLH/kML4cPAiVttSwNoyzCG7t+Fe4rx+gc=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=AYF4Q+SXLVxKuAk2dZ8EWMXP3sMaMQjnC+LlP/P14v1Zv8OEfDvOJtpbW1opdTWsS
         XMkEYsoJys61Nwdtfn8Jgmjb0zQHI3bWtOnmXks3y1RKKln7Jt05DiVV9ztYCi0P51
         vLlR6/V1l5W5UaLIeoiT07LtXDz1jp7emd5PLXVZRpNaEDFddEaA5oOlaIPtup4QzA
         K9mDGEOYoZfpwXa6h3hGVW1lBJvRzj3gEiVeeYLO6qS2Po9JddXGJuFBDpVCklJ2zX
         sDAQP9iWgfD4ugX469nEnp9mWeYnmIhdClAax+NHdjPhwbVjtIYLkT3t9wXPw9JEou
         LifwDKMWavWYA==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 62C83A005E;
        Wed,  3 Feb 2021 17:57:27 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH v3 13/15] dmaengine: dw-edma: Change DMA abreviation from lower into upper case
Date:   Wed,  3 Feb 2021 18:57:05 +0100
Message-Id: <829eec03dac218df96cb945b72e58e20d25773e9.1612374941.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1612374941.git.gustavo.pimentel@synopsys.com>
References: <cover.1612374941.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1612374941.git.gustavo.pimentel@synopsys.com>
References: <cover.1612374941.git.gustavo.pimentel@synopsys.com>
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

