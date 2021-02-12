Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A96131A3DB
	for <lists+dmaengine@lfdr.de>; Fri, 12 Feb 2021 18:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbhBLRjo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 12 Feb 2021 12:39:44 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:42868 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229832AbhBLRjK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 12 Feb 2021 12:39:10 -0500
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A822D40C7A;
        Fri, 12 Feb 2021 17:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1613151490; bh=yp46md2f1aLH/kML4cPAiVttSwNoyzCG7t+Fe4rx+gc=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=dCU0xkpQDg3e2cDnmtl42JJWH05Z/ygwOkuPy76tJXxrPN/a3t3sp3Hr3AGP5JZnb
         bX6YmBcD6A5PpiIeBw3oMwr/YI8RE0l+oHxTXblmMp4976oLq+C9ZK53ZHS+XFanDk
         KrUyQEzILcFEaCfPpoVJfg/G3vx92AnkA2/RKCHV7KTfnepVPzWOWB4o88jVR3Sab8
         9lMW7ORiDjdYFUKD0MTSuki2QlS4vxLVTI1HD8Phchx0jLTujyULTfscUnfAaRmDbt
         +OOjOKMhwsr+9djHqPP+dwQJymhzvLuUIypJn5Q6eOKwrfOIJN4MGvuZeh5ju1Cj+Y
         HgV3G0ReZ8Cyg==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 7B551A005C;
        Fri, 12 Feb 2021 17:38:09 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH v6 13/15] dmaengine: dw-edma: Change DMA abreviation from lower into upper case
Date:   Fri, 12 Feb 2021 18:37:48 +0100
Message-Id: <2e58130bb350ce5f1848b13bf66d615c092464e7.1613151392.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1613151392.git.gustavo.pimentel@synopsys.com>
References: <cover.1613151392.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1613151392.git.gustavo.pimentel@synopsys.com>
References: <cover.1613151392.git.gustavo.pimentel@synopsys.com>
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

