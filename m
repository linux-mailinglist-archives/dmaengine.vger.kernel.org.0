Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801FE729290
	for <lists+dmaengine@lfdr.de>; Fri,  9 Jun 2023 10:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240172AbjFIIRt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 9 Jun 2023 04:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240207AbjFIIRk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 9 Jun 2023 04:17:40 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EDD2D7B;
        Fri,  9 Jun 2023 01:17:06 -0700 (PDT)
X-GND-Sasl: kory.maincent@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686298623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oCPB9Nf3YZqvG1rzu67yQSLPi8ZPt/80c1MDnzGqrYE=;
        b=d+AW7TcbsOXUczeTbAj0+f1hTV3cgIhoVMCMFoZUmd4pq1hiPoV7nM3TWzrjrDqXxJGIBH
        WCZWVzTHH9uIxpnW0agbTU70MjQKdEYkKJ7vevRIvaRfuuQTAlh3+AjAuDTXNqoRf/Ziza
        eN7Wrz+IPBv6JEfNn2zGCeCXpUmJ2U/Gz1N8NZRZLCTIlfidyUzxTmRk6N/v4VZSBzDLVV
        YQ4nYhGhNZ/Bcis2Jav4orHvVEQbrbBBMLhx3HI39x/F0zCUpGZ99YnFbF/PquYBo7Zmvl
        c476gy+A60kmmPotp6HPPLqNwdZkIBglcWZEx62DbPGosO0elJnd8DGVeg1lSw==
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 47970C0010;
        Fri,  9 Jun 2023 08:17:02 +0000 (UTC)
From:   =?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>
To:     Cai Huoqing <cai.huoqing@linux.dev>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH 6/9] dmaengine: dw-edma: HDMA: Fix possible race condition in local setup
Date:   Fri,  9 Jun 2023 10:16:51 +0200
Message-Id: <20230609081654.330857-7-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230609081654.330857-1-kory.maincent@bootlin.com>
References: <20230609081654.330857-1-kory.maincent@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Spam-Score: 300
X-GND-Status: SPAM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Kory Maincent <kory.maincent@bootlin.com>

When writing the linked list elements and pointer the control need to be
written at the end. If the control is written and the SAR and DAR not
stored we could face a race condition. Added a memory barrier to make sure
the memory has been written.

Fixes: e74c39573d35 ("dmaengine: dw-edma: Add support for native HDMA")
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

This patch has not been tested since I don't have board with HDMA in local
setup.

This patch is fixing a commit which is only in dmaengine tree and not
merged mainline.
---
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index f28e1671a753..d3c70500496c 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -155,10 +155,13 @@ static void dw_hdma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
 	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
 		struct dw_hdma_v0_lli *lli = chunk->ll_region.vaddr.mem + ofs;
 
-		lli->control = control;
 		lli->transfer_size = size;
 		lli->sar.reg = sar;
 		lli->dar.reg = dar;
+
+		/* Make sure sar and dar is written before writing control */
+		dma_wmb();
+		lli->control = control;
 	} else {
 		struct dw_hdma_v0_lli __iomem *lli = chunk->ll_region.vaddr.io + ofs;
 
@@ -177,8 +180,11 @@ static void dw_hdma_v0_write_ll_link(struct dw_edma_chunk *chunk,
 	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
 		struct dw_hdma_v0_llp *llp = chunk->ll_region.vaddr.mem + ofs;
 
-		llp->control = control;
 		llp->llp.reg = pointer;
+
+		/* Make sure sar and dar is written before writing control */
+		dma_wmb();
+		llp->control = control;
 	} else {
 		struct dw_hdma_v0_llp __iomem *llp = chunk->ll_region.vaddr.io + ofs;
 
-- 
2.25.1

