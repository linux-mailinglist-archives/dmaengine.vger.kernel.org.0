Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20613506DE9
	for <lists+dmaengine@lfdr.de>; Tue, 19 Apr 2022 15:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352541AbiDSNnV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Apr 2022 09:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352809AbiDSNmx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Apr 2022 09:42:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBE9182;
        Tue, 19 Apr 2022 06:40:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B94DB81983;
        Tue, 19 Apr 2022 13:40:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9990AC385AF;
        Tue, 19 Apr 2022 13:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650375608;
        bh=9+ljq5dQueH2G15TUC+ZLkwgSkKDWfTDa0M3UxfDvzI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UZEWjobJJdf/97+RsHjNB+jMk4tP3Pl4vgk6cxlQnhU41tj2I/yINK+gRoMdoNOUR
         Y7MRcUEAGnlNliwHS5DlBG2gtVRR+NX39wFuq/IGF0bnCo9HD4/Ko6wpnFF46X1ylv
         iALan+QzhQpH4nbYopoyAajxQA2oBzcqItCFMpy/SY9vH4HlIcvpT8NRLMP54afeyx
         u1+GxMJCkZOQYlBflCn6XehmD8eQEUOxgT0Tgy+CE5qdUt9iLLhEzYm8twoL8sueZd
         +tmqfAeeno42q0iwsr0p6BakCbrKJuvbO2sq+/dI7pXW42969rnsk5HKJ4ZbkYUR14
         LrA6BeSwSde3w==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-omap@vger.kernel.org, tony@atomide.com, aaro.koskinen@iki.fi,
        jmkrzyszt@gmail.com
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Paul Walmsley <paul@pwsan.com>,
        Kevin Hilman <khilman@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Mark Brown <broonie@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-input@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-serial@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH 20/41] dma: omap: hide legacy interface
Date:   Tue, 19 Apr 2022 15:37:02 +0200
Message-Id: <20220419133723.1394715-21-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220419133723.1394715-1-arnd@kernel.org>
References: <20220419133723.1394715-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The legacy interface for omap-dma is only used on OMAP1, and the
same is true for the non-DT case. Make both of these conditional on
CONFIG_ARCH_OMAP1 being set to simplify the dependency.

The non-OMAP stub functions in include/linux/omap-dma.h are note needed
any more either now, because they are only called on OMAP1.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/dma/ti/omap-dma.c | 19 +++++++++++++------
 include/linux/omap-dma.h  | 22 ----------------------
 2 files changed, 13 insertions(+), 28 deletions(-)

diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
index 8e52a0dc1f78..27f5019bdc1e 100644
--- a/drivers/dma/ti/omap-dma.c
+++ b/drivers/dma/ti/omap-dma.c
@@ -699,6 +699,11 @@ static void omap_dma_put_lch(struct omap_dmadev *od, int lch)
 	mutex_unlock(&od->lch_lock);
 }
 
+static inline bool omap_dma_legacy(struct omap_dmadev *od)
+{
+	return IS_ENABLED(CONFIG_ARCH_OMAP1) && od->legacy;
+}
+
 static int omap_dma_alloc_chan_resources(struct dma_chan *chan)
 {
 	struct omap_dmadev *od = to_omap_dma_dev(chan->device);
@@ -706,7 +711,7 @@ static int omap_dma_alloc_chan_resources(struct dma_chan *chan)
 	struct device *dev = od->ddev.dev;
 	int ret;
 
-	if (od->legacy) {
+	if (omap_dma_legacy(od)) {
 		ret = omap_request_dma(c->dma_sig, "DMA engine",
 				       omap_dma_callback, c, &c->dma_ch);
 	} else {
@@ -718,7 +723,7 @@ static int omap_dma_alloc_chan_resources(struct dma_chan *chan)
 	if (ret >= 0) {
 		omap_dma_assign(od, c, c->dma_ch);
 
-		if (!od->legacy) {
+		if (!omap_dma_legacy(od)) {
 			unsigned val;
 
 			spin_lock_irq(&od->irq_lock);
@@ -757,7 +762,7 @@ static void omap_dma_free_chan_resources(struct dma_chan *chan)
 	struct omap_dmadev *od = to_omap_dma_dev(chan->device);
 	struct omap_chan *c = to_omap_dma_chan(chan);
 
-	if (!od->legacy) {
+	if (!omap_dma_legacy(od)) {
 		spin_lock_irq(&od->irq_lock);
 		od->irq_enable_mask &= ~BIT(c->dma_ch);
 		omap_dma_glbl_write(od, IRQENABLE_L1, od->irq_enable_mask);
@@ -768,7 +773,7 @@ static void omap_dma_free_chan_resources(struct dma_chan *chan)
 	od->lch_map[c->dma_ch] = NULL;
 	vchan_free_chan_resources(&c->vc);
 
-	if (od->legacy)
+	if (omap_dma_legacy(od))
 		omap_free_dma(c->dma_ch);
 	else
 		omap_dma_put_lch(od, c->dma_ch);
@@ -1674,12 +1679,14 @@ static int omap_dma_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev, "omap_system_dma_plat_info is missing");
 			return -ENODEV;
 		}
-	} else {
+	} else if (IS_ENABLED(CONFIG_ARCH_OMAP1)) {
 		od->cfg = &default_cfg;
 
 		od->plat = omap_get_plat_info();
 		if (!od->plat)
 			return -EPROBE_DEFER;
+	} else {
+		return -ENODEV;
 	}
 
 	od->reg_map = od->plat->reg_map;
@@ -1855,7 +1862,7 @@ static int omap_dma_remove(struct platform_device *pdev)
 
 	dma_async_device_unregister(&od->ddev);
 
-	if (!od->legacy) {
+	if (!omap_dma_legacy(od)) {
 		/* Disable all interrupts */
 		omap_dma_glbl_write(od, IRQENABLE_L0, 0);
 	}
diff --git a/include/linux/omap-dma.h b/include/linux/omap-dma.h
index 07fa58ae9902..254b4e10511b 100644
--- a/include/linux/omap-dma.h
+++ b/include/linux/omap-dma.h
@@ -292,7 +292,6 @@ struct omap_system_dma_plat_info {
 #define dma_omap15xx()	__dma_omap15xx(d)
 #define dma_omap16xx()	__dma_omap16xx(d)
 
-#if defined(CONFIG_ARCH_OMAP)
 extern struct omap_system_dma_plat_info *omap_get_plat_info(void);
 
 extern void omap_set_dma_priority(int lch, int dst_port, int priority);
@@ -340,25 +339,4 @@ static inline int omap_lcd_dma_running(void)
 }
 #endif
 
-#else /* CONFIG_ARCH_OMAP */
-static inline void omap_set_dma_priority(int lch, int dst_port, int priority)
-{
-}
-
-static inline struct omap_system_dma_plat_info *omap_get_plat_info(void)
-{
-	return NULL;
-}
-
-static inline int omap_request_dma(int dev_id, const char *dev_name,
-			void (*callback)(int lch, u16 ch_status, void *data),
-			void *data, int *dma_ch)
-{
-	return -ENODEV;
-}
-
-static inline void omap_free_dma(int ch) { }
-
-#endif /* CONFIG_ARCH_OMAP */
-
 #endif /* __LINUX_OMAP_DMA_H */
-- 
2.29.2

