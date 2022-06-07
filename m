Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D609354024D
	for <lists+dmaengine@lfdr.de>; Tue,  7 Jun 2022 17:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343980AbiFGPWZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Jun 2022 11:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiFGPWX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 Jun 2022 11:22:23 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD09D3BA52
        for <dmaengine@vger.kernel.org>; Tue,  7 Jun 2022 08:22:22 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 8A16A240002;
        Tue,  7 Jun 2022 15:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1654615341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r2SpG72SGdf7h1xIMyGh4cAh+JsP/rqtRpGMF70ed/U=;
        b=iwtxUUFqGZE3cg8b+uIP1zZuxTZn9ZuyQR7EDiQXwSxf+9PGwAfAQQFyPGkezooOs9JYsF
        zbV9cgWn00auYfPej8g0ErJrkeGl8HgbK+ACGl08nWMPUE7XLea4oAjA+Iqxj/PDtfCAPW
        ev8qPS3uLGfFJn9ouNp5100a5KD8RDudehy37toVBraOECdFswEEbbAYYxaTHF6KYLSGRH
        3QItSkWvHUJrj+cpp1hbciGnmVZ9KAnRiZl4buYBabCYO5zNJgBbFyyh2u4/5RWRFqS1RI
        GVSVW1iALbZ3ttkVCU41i1P7t3yOKqqu1oC+gnnOffHkZtLWH0f3vvo0t1pbRA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2 2/2] dmaengine: dw: dmamux: Fix build without CONFIG_OF
Date:   Tue,  7 Jun 2022 17:22:15 +0200
Message-Id: <20220607152215.46731-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220607152215.46731-1-miquel.raynal@bootlin.com>
References: <20220607152215.46731-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

When built without OF support, of_match_node() expands to NULL, which
produces the following output:
>> drivers/dma/dw/rzn1-dmamux.c:105:34: warning: unused variable 'rzn1_dmac_match' [-Wunused-const-variable]
   static const struct of_device_id rzn1_dmac_match[] = {

One way to silence the warning is to enclose the structure definition
with an #ifdef CONFIG_OF/#endif block.

In order to keep the harmony in the driver, the second match table is
also enclosed with the same #ifdef CONFIG_OF/#endif block and the use of
the match table forwarded by the of_match_ptr() macro.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---

Changes in v2:
* Used the #ifdef solution rather than the __maybe_unused keyword.

 drivers/dma/dw/rzn1-dmamux.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dw/rzn1-dmamux.c b/drivers/dma/dw/rzn1-dmamux.c
index 0ce4fb58185e..6ab33614e91e 100644
--- a/drivers/dma/dw/rzn1-dmamux.c
+++ b/drivers/dma/dw/rzn1-dmamux.c
@@ -102,10 +102,12 @@ static void *rzn1_dmamux_route_allocate(struct of_phandle_args *dma_spec,
 	return ERR_PTR(ret);
 }
 
+#ifdef CONFIG_OF
 static const struct of_device_id rzn1_dmac_match[] = {
 	{ .compatible = "renesas,rzn1-dma" },
 	{}
 };
+#endif
 
 static int rzn1_dmamux_probe(struct platform_device *pdev)
 {
@@ -136,16 +138,18 @@ static int rzn1_dmamux_probe(struct platform_device *pdev)
 				      &dmamux->dmarouter);
 }
 
+#ifdef CONFIG_OF
 static const struct of_device_id rzn1_dmamux_match[] = {
 	{ .compatible = "renesas,rzn1-dmamux" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, rzn1_dmamux_match);
+#endif
 
 static struct platform_driver rzn1_dmamux_driver = {
 	.driver = {
 		.name = "renesas,rzn1-dmamux",
-		.of_match_table = rzn1_dmamux_match,
+		.of_match_table = of_match_ptr(rzn1_dmamux_match),
 	},
 	.probe	= rzn1_dmamux_probe,
 };
-- 
2.34.1

