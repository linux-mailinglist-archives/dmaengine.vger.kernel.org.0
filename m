Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01171567E1C
	for <lists+dmaengine@lfdr.de>; Wed,  6 Jul 2022 08:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbiGFGAS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 Jul 2022 02:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiGFGAP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 6 Jul 2022 02:00:15 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4301812AD2;
        Tue,  5 Jul 2022 23:00:14 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C51A8200626;
        Wed,  6 Jul 2022 08:00:12 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 96040200622;
        Wed,  6 Jul 2022 08:00:12 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 241D41802204;
        Wed,  6 Jul 2022 14:00:11 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     vkoul@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, shengjiu.wang@gmail.com,
        linux-imx@nxp.com, dmaengine@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] dmaengine: imx-sdma: Add missing struct documentation
Date:   Wed,  6 Jul 2022 13:45:09 +0800
Message-Id: <1657086309-7964-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Fix compile warning that 'Function parameter or member not described'
with 'W=1' option:

Add missing description for struct sdma_desc

There is not any description for struct sdma_script_start_addrs,
so use /* instead of /**

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
changes in v2
- refine the patch title

 drivers/dma/imx-sdma.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 8535018ee7a2..39d70ef1caf0 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -188,7 +188,7 @@
 #define SDMA_DONE0_CONFIG_DONE_SEL	BIT(7)
 #define SDMA_DONE0_CONFIG_DONE_DIS	BIT(6)
 
-/**
+/*
  * struct sdma_script_start_addrs - SDMA script start pointers
  *
  * start addresses of the different functions in the physical
@@ -424,6 +424,11 @@ struct sdma_desc {
  * @data:		specific sdma interface structure
  * @bd_pool:		dma_pool for bd
  * @terminate_worker:	used to call back into terminate work function
+ * @terminated:		terminated list
+ * @is_ram_script:	flag for script in ram
+ * @n_fifos_src:	number of source device fifos
+ * @n_fifos_dst:	number of destination device fifos
+ * @sw_done:		software done flag
  */
 struct sdma_channel {
 	struct virt_dma_chan		vc;
-- 
2.17.1

