Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E23506F76
	for <lists+dmaengine@lfdr.de>; Tue, 19 Apr 2022 15:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352662AbiDSNsV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Apr 2022 09:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353027AbiDSNrv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Apr 2022 09:47:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707EC39B94;
        Tue, 19 Apr 2022 06:42:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 062FC61703;
        Tue, 19 Apr 2022 13:42:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C584EC385AF;
        Tue, 19 Apr 2022 13:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650375729;
        bh=Nld9/TUbdgbuYnE7Z7eTyTcTbCiTvbx9DCX+XPf/dIk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fTaW3ZmdkeE3M3MSimua2kQNujfUwk186UwRzP9feCXD7A+q0u7XKDY/iN7u67RMI
         /AWDexKMBep9fzvxSbNH4rFQvJW4X70cPKHbziWo9zYxu4dheQ24oukIZKWAh8DZA6
         G7AHSK8r2efuyEv8w5DHvzk2D7nULMqc1uRCM6XYyi22XTK9k/NAuvFApEZoC1QcJo
         UH6QNxvMI8+ltP6+J4YHtROdU3WWDzA7+Awo68f+DUWX04woHy9iwLoJQCA/wwXqZK
         CQBhDEmafMImWeCYVDSlKu5aMItJmzaoZNI+PtUjVqnuByOBHAfhzWLLIyM7DBeWKU
         pUR94w4Aj7p7Q==
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
Subject: [PATCH 36/41] usb: gadget: omap_udc: Make it CCF clk API compatible
Date:   Tue, 19 Apr 2022 15:37:18 +0200
Message-Id: <20220419133723.1394715-37-arnd@kernel.org>
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

From: Janusz Krzysztofik <jmkrzyszt@gmail.com>

The driver, OMAP1 specific, now omits clk_prepare/unprepare() steps, not
supported by OMAP1 custom implementation of clock API.  However, non-CCF
stubs of those functions exist for use on such platforms until converted
to CCF.

Update the driver to be compatible with CCF implementation of clock API.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/gadget/udc/omap_udc.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/gadget/udc/omap_udc.c b/drivers/usb/gadget/udc/omap_udc.c
index 5096d24915ce..9ee472937482 100644
--- a/drivers/usb/gadget/udc/omap_udc.c
+++ b/drivers/usb/gadget/udc/omap_udc.c
@@ -2609,6 +2609,8 @@ static void omap_udc_release(struct device *dev)
 	if (udc->dc_clk) {
 		if (udc->clk_requested)
 			omap_udc_enable_clock(0);
+		clk_unprepare(udc->hhc_clk);
+		clk_unprepare(udc->dc_clk);
 		clk_put(udc->hhc_clk);
 		clk_put(udc->dc_clk);
 	}
@@ -2773,8 +2775,8 @@ static int omap_udc_probe(struct platform_device *pdev)
 		hhc_clk = clk_get(&pdev->dev, "usb_hhc_ck");
 		BUG_ON(IS_ERR(dc_clk) || IS_ERR(hhc_clk));
 		/* can't use omap_udc_enable_clock yet */
-		clk_enable(dc_clk);
-		clk_enable(hhc_clk);
+		clk_prepare_enable(dc_clk);
+		clk_prepare_enable(hhc_clk);
 		udelay(100);
 	}
 
@@ -2783,8 +2785,8 @@ static int omap_udc_probe(struct platform_device *pdev)
 		hhc_clk = clk_get(&pdev->dev, "l3_ocpi_ck");
 		BUG_ON(IS_ERR(dc_clk) || IS_ERR(hhc_clk));
 		/* can't use omap_udc_enable_clock yet */
-		clk_enable(dc_clk);
-		clk_enable(hhc_clk);
+		clk_prepare_enable(dc_clk);
+		clk_prepare_enable(hhc_clk);
 		udelay(100);
 	}
 
@@ -2932,8 +2934,8 @@ static int omap_udc_probe(struct platform_device *pdev)
 		usb_put_phy(xceiv);
 
 	if (cpu_is_omap16xx() || cpu_is_omap7xx()) {
-		clk_disable(hhc_clk);
-		clk_disable(dc_clk);
+		clk_disable_unprepare(hhc_clk);
+		clk_disable_unprepare(dc_clk);
 		clk_put(hhc_clk);
 		clk_put(dc_clk);
 	}
-- 
2.29.2

