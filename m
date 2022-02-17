Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0354B9547
	for <lists+dmaengine@lfdr.de>; Thu, 17 Feb 2022 02:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiBQBQY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 16 Feb 2022 20:16:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiBQBQX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 16 Feb 2022 20:16:23 -0500
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAD729B9E7;
        Wed, 16 Feb 2022 17:16:09 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0V4fY1fA_1645060566;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V4fY1fA_1645060566)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 17 Feb 2022 09:16:06 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     vkoul@kernel.org
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] dmaengine: imx-sdma: clean up some inconsistent indenting
Date:   Thu, 17 Feb 2022 09:16:04 +0800
Message-Id: <20220217011604.123106-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Eliminate the following coccicheck warning:
./drivers/dma/imx-sdma.c:896:3-16: code aligned with following code on
line 897

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/dma/imx-sdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 8cc5103193c3..70c0aa931ddf 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -892,9 +892,9 @@ static void mxc_sdma_handle_channel_normal(struct sdma_channel *data)
 	for (i = 0; i < sdmac->desc->num_bd; i++) {
 		bd = &sdmac->desc->bd[i];
 
-		 if (bd->mode.status & (BD_DONE | BD_RROR))
+		if (bd->mode.status & (BD_DONE | BD_RROR))
 			error = -EIO;
-		 sdmac->desc->chn_real_count += bd->mode.count;
+		sdmac->desc->chn_real_count += bd->mode.count;
 	}
 
 	if (error)
-- 
2.20.1.7.g153144c

