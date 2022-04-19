Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13AF5506E50
	for <lists+dmaengine@lfdr.de>; Tue, 19 Apr 2022 15:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352135AbiDSNkj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Apr 2022 09:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352384AbiDSNkh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Apr 2022 09:40:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006F837A3F;
        Tue, 19 Apr 2022 06:37:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81025616A6;
        Tue, 19 Apr 2022 13:37:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39DE8C385A8;
        Tue, 19 Apr 2022 13:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650375473;
        bh=t86HMs480nJ81wDi3aXmoHW9AjEzd927cpvY7iUPkRA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q1oWQPoZS7/CENhb5OPLC7YJ2sk5BX0Sd+TR7Ne2RbCX+e8cAKq8cwuskbrP54N8y
         stQZ598/GBeuriRAogXLbe7l2++zRj9NvvKdunSnGmHIycGC7BrO0A6CdtSklsrDOc
         hCpSAcyylOign9vUpLxEd7s3xbU8j0GLafaS11OmXeTYCHwfoODc14V2+61/hy14jV
         V3DE6MU1MIbRw0VhLnmngnMuv5cH7WF6tiE/ouBgQn9Bq49QmvAKcXEu8Yo+jYH8JT
         k3XjmyW8CWF3oBmp9Ft52/Ap2qUIjZrTYHUIc5Ot7q4x0/rQS5znuTVT5ci9wr0C6Y
         uHZkXXfi0EBrQ==
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
        linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 02/41] ARM: omap1: innovator: pass lcd control address as pdata
Date:   Tue, 19 Apr 2022 15:36:44 +0200
Message-Id: <20220419133723.1394715-3-arnd@kernel.org>
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

To avoid using the mach/omap1510.h header file, pass the correct
address as platform data.

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-omap1/board-innovator.c  | 3 +++
 drivers/video/fbdev/omap/lcd_inn1510.c | 7 +++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap1/board-innovator.c b/arch/arm/mach-omap1/board-innovator.c
index cbe093f969d5..2425f1bacb33 100644
--- a/arch/arm/mach-omap1/board-innovator.c
+++ b/arch/arm/mach-omap1/board-innovator.c
@@ -194,6 +194,9 @@ static struct platform_device innovator1510_smc91x_device = {
 static struct platform_device innovator1510_lcd_device = {
 	.name		= "lcd_inn1510",
 	.id		= -1,
+	.dev	= {
+		.platform_data = (void __force *)OMAP1510_FPGA_LCD_PANEL_CONTROL,
+	}
 };
 
 static struct platform_device innovator1510_spi_device = {
diff --git a/drivers/video/fbdev/omap/lcd_inn1510.c b/drivers/video/fbdev/omap/lcd_inn1510.c
index 776e7f8d656e..37ed0c14aa5a 100644
--- a/drivers/video/fbdev/omap/lcd_inn1510.c
+++ b/drivers/video/fbdev/omap/lcd_inn1510.c
@@ -14,15 +14,17 @@
 
 #include "omapfb.h"
 
+static void __iomem *omap1510_fpga_lcd_panel_control;
+
 static int innovator1510_panel_enable(struct lcd_panel *panel)
 {
-	__raw_writeb(0x7, OMAP1510_FPGA_LCD_PANEL_CONTROL);
+	__raw_writeb(0x7, omap1510_fpga_lcd_panel_control);
 	return 0;
 }
 
 static void innovator1510_panel_disable(struct lcd_panel *panel)
 {
-	__raw_writeb(0x0, OMAP1510_FPGA_LCD_PANEL_CONTROL);
+	__raw_writeb(0x0, omap1510_fpga_lcd_panel_control);
 }
 
 static struct lcd_panel innovator1510_panel = {
@@ -48,6 +50,7 @@ static struct lcd_panel innovator1510_panel = {
 
 static int innovator1510_panel_probe(struct platform_device *pdev)
 {
+	omap1510_fpga_lcd_panel_control = (void __iomem *)pdev->dev.platform_data;
 	omapfb_register_panel(&innovator1510_panel);
 	return 0;
 }
-- 
2.29.2

