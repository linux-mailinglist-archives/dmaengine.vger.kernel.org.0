Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0F5114387
	for <lists+dmaengine@lfdr.de>; Mon,  6 May 2019 04:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbfEFC26 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 5 May 2019 22:28:58 -0400
Received: from inva021.nxp.com ([92.121.34.21]:56766 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbfEFC26 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 5 May 2019 22:28:58 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CBB182001EB;
        Mon,  6 May 2019 04:28:56 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B71CF2001A7;
        Mon,  6 May 2019 04:28:53 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 8147A402EC;
        Mon,  6 May 2019 10:28:49 +0800 (SGT)
From:   Peng Ma <peng.ma@nxp.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com, leoyang.li@nxp.com
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Ma <peng.ma@nxp.com>
Subject: [V2 2/2] dmaengine: fsl-qdma: Add improvement
Date:   Mon,  6 May 2019 10:21:11 +0800
Message-Id: <20190506022111.31751-2-peng.ma@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20190506022111.31751-1-peng.ma@nxp.com>
References: <20190506022111.31751-1-peng.ma@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

When an error occurs we should clean the error register then to return

Signed-off-by: Peng Ma <peng.ma@nxp.com>
---
changed for V2:
	- Separate one patch to two patchs

 drivers/dma/fsl-qdma.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/fsl-qdma.c b/drivers/dma/fsl-qdma.c
index 2e8b46b..542765a 100644
--- a/drivers/dma/fsl-qdma.c
+++ b/drivers/dma/fsl-qdma.c
@@ -710,10 +710,8 @@ static irqreturn_t fsl_qdma_error_handler(int irq, void *dev_id)
 
 	intr = qdma_readl(fsl_qdma, status + FSL_QDMA_DEDR);
 
-	if (intr) {
+	if (intr)
 		dev_err(fsl_qdma->dma_dev.dev, "DMA transaction error!\n");
-		return IRQ_NONE;
-	}
 
 	qdma_writel(fsl_qdma, FSL_QDMA_DEDR_CLEAR, status + FSL_QDMA_DEDR);
 	return IRQ_HANDLED;
-- 
1.7.1

