Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2589B2DB2A4
	for <lists+dmaengine@lfdr.de>; Tue, 15 Dec 2020 18:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731317AbgLORcF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Dec 2020 12:32:05 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:46054 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731294AbgLORbs (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 15 Dec 2020 12:31:48 -0500
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 83BD0C04D7;
        Tue, 15 Dec 2020 17:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1608053447; bh=yp46md2f1aLH/kML4cPAiVttSwNoyzCG7t+Fe4rx+gc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=BT9Nm9/wdBndulKVY0glbXtCF06MvMwdoGS/OZXWAbLQtyLaoriJOEyZcHpfZDqUl
         MoDYyRa/Q5rMdFyfubpcxc0FvX0ytp7eGT5AaGVqzyUywrUs/S0jkTGZZOy75qY6v2
         QaS/zWtX9uCl8x1WKX1/iEGdrZOAuvX0TVikL2+QkXlzwqQvqqMYCAWd93iklSda70
         FzsX5HlR0qVvH6H2wU1QERUUYi63F02y2mj94hryzb7whJSIyvfyG7KAKAoWrrfuBT
         hJy5lM3gTp4sWhoweAPSkaygNRaWIuWXmk2Aw/c0mfZ8Y0fj8BmhO7HCBnqR1d9IHh
         IEhWxnmGy2A3w==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 19361A024D;
        Tue, 15 Dec 2020 17:30:46 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/15] dmaengine: dw-edma: Change DMA abreviation from lower into upper case
Date:   Tue, 15 Dec 2020 18:30:22 +0100
Message-Id: <c89f736c42dbd1fa7fd5255525542e4c0e3149a1.1608053262.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1608053262.git.gustavo.pimentel@synopsys.com>
References: <cover.1608053262.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1608053262.git.gustavo.pimentel@synopsys.com>
References: <cover.1608053262.git.gustavo.pimentel@synopsys.com>
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

