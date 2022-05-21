Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E09C52FE8B
	for <lists+dmaengine@lfdr.de>; Sat, 21 May 2022 19:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344115AbiEUR0a (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 21 May 2022 13:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233987AbiEUR00 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 21 May 2022 13:26:26 -0400
Received: from smtp.smtpout.orange.fr (smtp09.smtpout.orange.fr [80.12.242.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46982182C
        for <dmaengine@vger.kernel.org>; Sat, 21 May 2022 10:26:21 -0700 (PDT)
Received: from pop-os.home ([86.243.180.246])
        by smtp.orange.fr with ESMTPA
        id sSrpnEgTlOXCysSrpnRCQC; Sat, 21 May 2022 19:26:19 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 21 May 2022 19:26:19 +0200
X-ME-IP: 86.243.180.246
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     dan.carpenter@oracle.com,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, Joel Fernandes <joelf@ti.com>,
        Sekhar Nori <nsekhar@ti.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        dmaengine@vger.kernel.org
Subject: [PATCH] dmaengine: ti: Fix a potential under memory allocation issue in edma_setup_from_hw()
Date:   Sat, 21 May 2022 19:26:15 +0200
Message-Id: <8c95c485be294e64457606089a2a56e68e2ebd1a.1653153959.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

If the 'queue_priority_mapping' is not provided, we need to allocate the
correct amount of memory. Each entry takes 2 s8, so actually less memory
than needed is allocated.

Update the size of each entry when the memory is devm_kcalloc'ed.

Fixes: 6d10c3950bf4 ("ARM: edma: Get IP configuration from HW (number of channels, tc, etc)")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Note that the devm_kcalloc() in edma_xbar_event_map() looks also spurious.
However, this looks fine to me because of the 'nelm >>= 1;' before the
'for' loop.
---
 drivers/dma/ti/edma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index 3ea8ef7f57df..f313e2cf542c 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -2121,7 +2121,7 @@ static int edma_setup_from_hw(struct device *dev, struct edma_soc_info *pdata,
 	 * priority. So Q0 is the highest priority queue and the last queue has
 	 * the lowest priority.
 	 */
-	queue_priority_map = devm_kcalloc(dev, ecc->num_tc + 1, sizeof(s8),
+	queue_priority_map = devm_kcalloc(dev, ecc->num_tc + 1, sizeof(s8) * 2,
 					  GFP_KERNEL);
 	if (!queue_priority_map)
 		return -ENOMEM;
-- 
2.34.1

