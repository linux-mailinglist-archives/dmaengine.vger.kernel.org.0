Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F8052B398
	for <lists+dmaengine@lfdr.de>; Wed, 18 May 2022 09:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbiERHeg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 18 May 2022 03:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbiERHeX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 18 May 2022 03:34:23 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE4DC9EC9;
        Wed, 18 May 2022 00:34:21 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8FD2D1A0C9B;
        Wed, 18 May 2022 09:34:20 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 587141A0CBC;
        Wed, 18 May 2022 09:34:20 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id EEFF0180031F;
        Wed, 18 May 2022 15:34:18 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     vkoul@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: imx-sdma: Fix compile warning 'Function parameter not described'
Date:   Wed, 18 May 2022 15:21:47 +0800
Message-Id: <1652858507-12628-1-git-send-email-shengjiu.wang@nxp.com>
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

There is no description for struct sdma_script_start_addrs, so use /*
instead of /**

Add missed description for struct sdma_desc

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 drivers/dma/imx-sdma.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 95367a8a81a5..111beb7138e0 100644
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

