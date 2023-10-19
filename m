Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484D97CECEF
	for <lists+dmaengine@lfdr.de>; Thu, 19 Oct 2023 02:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjJSAss (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 18 Oct 2023 20:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjJSAsr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 18 Oct 2023 20:48:47 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E038124;
        Wed, 18 Oct 2023 17:48:44 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VuRvLSx_1697676520;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VuRvLSx_1697676520)
          by smtp.aliyun-inc.com;
          Thu, 19 Oct 2023 08:48:41 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     Eugeniy.Paltsev@synopsys.com, vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] dmaengine: dw-axi-dmac: drm/amd/display: clean up some inconsistent indentings
Date:   Thu, 19 Oct 2023 08:48:28 +0800
Message-Id: <20231019004828.124756-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:1239 dma_chan_pause() warn: inconsistent indenting
drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:1286 axi_chan_resume() warn: inconsistent indenting

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=6932
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index a86a81ff0caa..79c96b8a63c1 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1235,8 +1235,8 @@ static int dma_chan_pause(struct dma_chan *dchan)
 		} else {
 			val |= BIT(chan->id) << DMAC_CHAN_SUSP2_SHIFT |
 			       BIT(chan->id) << DMAC_CHAN_SUSP2_WE_SHIFT;
-			}
-			axi_dma_iowrite64(chan->chip, DMAC_CHSUSPREG, val);
+		}
+		axi_dma_iowrite64(chan->chip, DMAC_CHSUSPREG, val);
 	} else {
 		if (chan->chip->dw->hdata->reg_map_8_channels) {
 			val = axi_dma_ioread32(chan->chip, DMAC_CHEN);
@@ -1283,7 +1283,7 @@ static inline void axi_chan_resume(struct axi_dma_chan *chan)
 			val &= ~(BIT(chan->id) << DMAC_CHAN_SUSP2_SHIFT);
 			val |=  (BIT(chan->id) << DMAC_CHAN_SUSP2_WE_SHIFT);
 		}
-			axi_dma_iowrite64(chan->chip, DMAC_CHSUSPREG, val);
+		axi_dma_iowrite64(chan->chip, DMAC_CHSUSPREG, val);
 	} else {
 		if (chan->chip->dw->hdata->reg_map_8_channels) {
 			val = axi_dma_ioread32(chan->chip, DMAC_CHEN);
-- 
2.20.1.7.g153144c

