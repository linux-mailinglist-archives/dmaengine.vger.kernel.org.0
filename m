Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5CD25C29
	for <lists+dmaengine@lfdr.de>; Wed, 22 May 2019 05:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbfEVD3E (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 May 2019 23:29:04 -0400
Received: from inva021.nxp.com ([92.121.34.21]:45342 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727733AbfEVD3E (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 21 May 2019 23:29:04 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C452F20002D;
        Wed, 22 May 2019 05:29:02 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 365F7200033;
        Wed, 22 May 2019 05:29:00 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 8BAE1402E7;
        Wed, 22 May 2019 11:28:56 +0800 (SGT)
From:   Peng Ma <peng.ma@nxp.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Ma <peng.ma@nxp.com>
Subject: [V3 2/2] dmaengine: fsl-qdma: Add improvement
Date:   Wed, 22 May 2019 03:21:03 +0000
Message-Id: <20190522032103.13713-2-peng.ma@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20190522032103.13713-1-peng.ma@nxp.com>
References: <20190522032103.13713-1-peng.ma@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

When an error occurs we should clean the error register then to return

Signed-off-by: Peng Ma <peng.ma@nxp.com>
---
changed for V3:
	- no changed.

 drivers/dma/fsl-qdma.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/fsl-qdma.c b/drivers/dma/fsl-qdma.c
index da8fdf5..8e341c0 100644
--- a/drivers/dma/fsl-qdma.c
+++ b/drivers/dma/fsl-qdma.c
@@ -703,10 +703,8 @@ static irqreturn_t fsl_qdma_error_handler(int irq, void *dev_id)
 
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

