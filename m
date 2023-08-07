Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A235377194D
	for <lists+dmaengine@lfdr.de>; Mon,  7 Aug 2023 07:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjHGFTq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Aug 2023 01:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjHGFTp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 7 Aug 2023 01:19:45 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BEF1722;
        Sun,  6 Aug 2023 22:19:40 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 3775JDpj015992;
        Mon, 7 Aug 2023 13:19:13 +0800 (+08)
        (envelope-from Kaiwei.Liu@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx07.spreadtrum.com [10.0.1.12])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4RK4M50K7xz2P5F6B;
        Mon,  7 Aug 2023 13:17:21 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx07.spreadtrum.com
 (10.0.1.12) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Mon, 7 Aug 2023
 13:19:11 +0800
From:   Kaiwei Liu <kaiwei.liu@unisoc.com>
To:     Vinod Koul <vkoul@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        kaiwei liu <liukaiwei086@gmail.com>,
        Wenming Wu <wenming.wu@unisoc.com>
Subject: [PATCH 1/5] dma: delect redundant parameter for dma driver function
Date:   Mon, 7 Aug 2023 13:19:07 +0800
Message-ID: <20230807051907.2713-1-kaiwei.liu@unisoc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.2.29]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx07.spreadtrum.com (10.0.1.12)
X-MAIL: SHSQR01.spreadtrum.com 3775JDpj015992
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The parameter *sdesc in function sprd_dma_check_trans_done is not
used, so here delect redundant parameter.

Signed-off-by: Kaiwei Liu <kaiwei.liu@unisoc.com>
---
 drivers/dma/sprd-dma.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index 2b639adb48ba..20c3cb1ef2f5 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -572,8 +572,7 @@ static void sprd_dma_stop(struct sprd_dma_chn *schan)
 	schan->cur_desc = NULL;
 }
 
-static bool sprd_dma_check_trans_done(struct sprd_dma_desc *sdesc,
-				      enum sprd_dma_int_type int_type,
+static bool sprd_dma_check_trans_done(enum sprd_dma_int_type int_type,
 				      enum sprd_dma_req_mode req_mode)
 {
 	if (int_type == SPRD_DMA_NO_INT)
@@ -619,8 +618,7 @@ static irqreturn_t dma_irq_handle(int irq, void *dev_id)
 			vchan_cyclic_callback(&sdesc->vd);
 		} else {
 			/* Check if the dma request descriptor is done. */
-			trans_done = sprd_dma_check_trans_done(sdesc, int_type,
-							       req_type);
+			trans_done = sprd_dma_check_trans_done(int_type, req_type);
 			if (trans_done == true) {
 				vchan_cookie_complete(&sdesc->vd);
 				schan->cur_desc = NULL;
-- 
2.17.1

