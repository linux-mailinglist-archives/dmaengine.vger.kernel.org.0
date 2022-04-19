Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7E2506EAC
	for <lists+dmaengine@lfdr.de>; Tue, 19 Apr 2022 15:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352250AbiDSNkg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Apr 2022 09:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238412AbiDSNkf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Apr 2022 09:40:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46EE437A8F;
        Tue, 19 Apr 2022 06:37:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F22EBB8197F;
        Tue, 19 Apr 2022 13:37:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D00DC385AF;
        Tue, 19 Apr 2022 13:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650375466;
        bh=uk85dachbI2QOyzEdf35KpbxClyHjIWRAqDWzdDgdhI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mruYOH8ME/Vh1wQ1pMChS4oLgW9pQabgidhmksrUD2v1VpjqEkYSVaL8F5/Jx1fJt
         iWfATQhXYZ2HF/JTCtVwo5XrFWHmaEHiE6zg5UuUIOuzgkBcy0V016jiFYV+rfjvg4
         nbWIXvEBktWlCb8U/NzpxCV5jRa0vQe1kx5vmEE+PwnJ8xlKsar1yUF2Ek65ppTRI1
         gNA1cS2olATNCQ5F6ThWgt7qsMKQf7IGjg6mb0lxFK6DB8LW3fweuNrfnHKFsjWXSP
         2dckRazl0o0Sf/B+mK1VM7FPMYVZMNP94kAS5WiC3zL0qcWam2pXKjNXDyEDSaifQB
         FGhlzS9XXadRA==
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
Subject: [PATCH 01/41] video: fbdev: omapfb: lcd_ams_delta: fix unused variable warning
Date:   Tue, 19 Apr 2022 15:36:43 +0200
Message-Id: <20220419133723.1394715-2-arnd@kernel.org>
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

A recent cleanup patch removed the only reference to a local variable
in some configurations.

Move the variable into the one block it is still used in, inside
of an #ifdef, to avoid this warning.

Fixes: 9d773f103b89 ("video: fbdev: omapfb: lcd_ams_delta: Make use of the helper function dev_err_probe()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/fbdev/omap/lcd_ams_delta.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/omap/lcd_ams_delta.c b/drivers/video/fbdev/omap/lcd_ams_delta.c
index bbf871f9d862..01944ce46aa1 100644
--- a/drivers/video/fbdev/omap/lcd_ams_delta.c
+++ b/drivers/video/fbdev/omap/lcd_ams_delta.c
@@ -128,7 +128,6 @@ static struct lcd_panel ams_delta_panel = {
 static int ams_delta_panel_probe(struct platform_device *pdev)
 {
 	struct lcd_device *lcd_device = NULL;
-	int ret;
 
 	gpiod_vblen = devm_gpiod_get(&pdev->dev, "vblen", GPIOD_OUT_LOW);
 	if (IS_ERR(gpiod_vblen))
@@ -145,7 +144,7 @@ static int ams_delta_panel_probe(struct platform_device *pdev)
 						&ams_delta_lcd_ops);
 
 	if (IS_ERR(lcd_device)) {
-		ret = PTR_ERR(lcd_device);
+		int ret = PTR_ERR(lcd_device);
 		dev_err(&pdev->dev, "failed to register device\n");
 		return ret;
 	}
-- 
2.29.2

