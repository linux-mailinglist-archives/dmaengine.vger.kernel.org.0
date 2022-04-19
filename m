Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA95506F06
	for <lists+dmaengine@lfdr.de>; Tue, 19 Apr 2022 15:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbiDSNsP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Apr 2022 09:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353004AbiDSNru (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Apr 2022 09:47:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BD239839;
        Tue, 19 Apr 2022 06:42:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 88111B81986;
        Tue, 19 Apr 2022 13:42:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D256C385A5;
        Tue, 19 Apr 2022 13:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650375722;
        bh=b8M7Htp8PC1M3UqN4COpkh3W696Svq9K1vaNWm/6ehg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WO+hx1jvcO8sNvVYXwtk9yzViyIi/AeD0vyEdyCzAJ0epFG3OGq2Fn7Q2EGQVFZtL
         lxuUOfpn5uHFQi9GsZUgd6pDtHMGP4raATiMUNW5ZDgt1Mx2Nw3Wma2I/LO2HpIx7E
         xUcwEuvzj7umr7FkY4CRlMIXjMQvfrB/eUY+gzYzcxeP8V0TSSePzn/s5Bzv+cR+NL
         E7plBnP5gpO17xOQMhGm9BvxgJ5ifb3qFbpNxGlNnaeWblY970wnie8dXu9AYsKFAH
         ZR4rCJZff8i/YehkU19EDTDNz/bmaatCQOWZ7ZUnBrKD8BeNNfnxpY761tWUDxDIY6
         FSC+791LABy0A==
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
Subject: [PATCH 35/41] usb: host: ohci-omap: Make it CCF clk API compatible
Date:   Tue, 19 Apr 2022 15:37:17 +0200
Message-Id: <20220419133723.1394715-36-arnd@kernel.org>
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
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/host/ohci-omap.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ohci-omap.c b/drivers/usb/host/ohci-omap.c
index 069791d25abb..f5bc9c8bdc9a 100644
--- a/drivers/usb/host/ohci-omap.c
+++ b/drivers/usb/host/ohci-omap.c
@@ -259,6 +259,10 @@ static int ohci_hcd_omap_probe(struct platform_device *pdev)
 		goto err_put_hcd;
 	}
 
+	retval = clk_prepare(priv->usb_host_ck);
+	if (retval)
+		goto err_put_host_ck;
+
 	if (!cpu_is_omap15xx())
 		priv->usb_dc_ck = clk_get(&pdev->dev, "usb_dc_ck");
 	else
@@ -266,13 +270,17 @@ static int ohci_hcd_omap_probe(struct platform_device *pdev)
 
 	if (IS_ERR(priv->usb_dc_ck)) {
 		retval = PTR_ERR(priv->usb_dc_ck);
-		goto err_put_host_ck;
+		goto err_unprepare_host_ck;
 	}
 
+	retval = clk_prepare(priv->usb_dc_ck);
+	if (retval)
+		goto err_put_dc_ck;
+
 	if (!request_mem_region(hcd->rsrc_start, hcd->rsrc_len, hcd_name)) {
 		dev_dbg(&pdev->dev, "request_mem_region failed\n");
 		retval = -EBUSY;
-		goto err_put_dc_ck;
+		goto err_unprepare_dc_ck;
 	}
 
 	hcd->regs = ioremap(hcd->rsrc_start, hcd->rsrc_len);
@@ -297,8 +305,12 @@ static int ohci_hcd_omap_probe(struct platform_device *pdev)
 	iounmap(hcd->regs);
 err2:
 	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
+err_unprepare_dc_ck:
+	clk_unprepare(priv->usb_dc_ck);
 err_put_dc_ck:
 	clk_put(priv->usb_dc_ck);
+err_unprepare_host_ck:
+	clk_unprepare(priv->usb_host_ck);
 err_put_host_ck:
 	clk_put(priv->usb_host_ck);
 err_put_hcd:
@@ -333,7 +345,9 @@ static int ohci_hcd_omap_remove(struct platform_device *pdev)
 	}
 	iounmap(hcd->regs);
 	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
+	clk_unprepare(priv->usb_dc_ck);
 	clk_put(priv->usb_dc_ck);
+	clk_unprepare(priv->usb_host_ck);
 	clk_put(priv->usb_host_ck);
 	usb_put_hcd(hcd);
 	return 0;
-- 
2.29.2

