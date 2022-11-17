Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24AC62D2D7
	for <lists+dmaengine@lfdr.de>; Thu, 17 Nov 2022 06:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234522AbiKQFmD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 17 Nov 2022 00:42:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233899AbiKQFmB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 17 Nov 2022 00:42:01 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1029512AB1;
        Wed, 16 Nov 2022 21:41:59 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NCTLs4DTfz5BNS0;
        Thu, 17 Nov 2022 13:41:57 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl2.zte.com.cn with SMTP id 2AH5fkwM060327;
        Thu, 17 Nov 2022 13:41:46 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Thu, 17 Nov 2022 13:41:47 +0800 (CST)
Date:   Thu, 17 Nov 2022 13:41:47 +0800 (CST)
X-Zmail-TransId: 2af96375c99bffffffff8020bc7a
X-Mailer: Zmail v1.0
Message-ID: <202211171341474562261@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <vkoul@kernel.org>
Cc:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIGRtYWVuZ2luZTogb2YtZG1hOiBVc2UgZGV2aWNlX21hdGNoX29mX25vZGUoKQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2AH5fkwM060327
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 6375C9A5.000 by FangMail milter!
X-FangMail-Envelope: 1668663717/4NCTLs4DTfz5BNS0/6375C9A5.000/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6375C9A5.000/4NCTLs4DTfz5BNS0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Replace the open-code with device_match_of_node().

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/dma/of-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/of-dma.c b/drivers/dma/of-dma.c
index ac61ecda2926..8281a4aebca8 100644
--- a/drivers/dma/of-dma.c
+++ b/drivers/dma/of-dma.c
@@ -157,7 +157,7 @@ void of_dma_controller_free(struct device_node *np)
 	mutex_lock(&of_dma_lock);

 	list_for_each_entry(ofdma, &of_dma_list, of_dma_controllers)
-		if (ofdma->of_node == np) {
+		if (device_match_of_node(ofdma, np)) {
 			list_del(&ofdma->of_dma_controllers);
 			kfree(ofdma);
 			break;
-- 
2.25.1
