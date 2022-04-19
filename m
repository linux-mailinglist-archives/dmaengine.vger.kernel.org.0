Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87789506F42
	for <lists+dmaengine@lfdr.de>; Tue, 19 Apr 2022 15:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242585AbiDSNqo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Apr 2022 09:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243252AbiDSNpW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Apr 2022 09:45:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E1938DA8;
        Tue, 19 Apr 2022 06:41:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 57A0AB81987;
        Tue, 19 Apr 2022 13:41:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BB39C385A8;
        Tue, 19 Apr 2022 13:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650375692;
        bh=tnWw7oBH8X/XBSc06dB4T/Xrxth9FWCIgmXAbL0gUiI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l353b3xn7RP12XuOF9Cs9zO9tge/orX72WpKCH58E7muL7FyXckbWebpZVTgREpYO
         94nj83AEJ8G4ma3/hGOjwiDA7u44mm32sOWTOmedTY1j9E754Khi/eBhNw7sZcR/fP
         sEELa4g6tqqCHlME51Brhwnr6YLWLyI8Af7wRGM8o8xD8amnnB09engI4zVkiclXXu
         mCNS0Sb+wp3+DZySStUMonTFolm2Ob9v/CLQNN4JWPX7Aweoh7N2XbyQM1ddcyBgBz
         1g2qalhGNLlbW40TdlyWoLmDXnGz4w+LLuOQpSk9G4QwyJjZxE6HKbSgWD1lwNbvb3
         UwCXSJ2vUo86g==
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
Subject: [PATCH 31/41] ARM: OMAP1: clock: Fix early UART rate issues
Date:   Tue, 19 Apr 2022 15:37:13 +0200
Message-Id: <20220419133723.1394715-32-arnd@kernel.org>
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

Commit ef772f2ee31e ("ARM: OMAP: Fix CONFIG_DEBUG_LL") was supposed to fix
low level debugging, most possibly by early enabling UART clocks.  The fix
actually introduced early reset of most bits of MOD_CONF_CTRL_0 register,
with the exception of UART1 and UART2 clock related bits which were set
high.  However, UART1 clock bit can play different roles on different
OMAP1 variants.  On OMAP1610 it enables the clock as intended, but on
OMAP1510 it switches the clock rate from 12 to 48 MHz.  Even worth, for
UART2 the bit changes its clock rate also on OMAP1610.  As a result, UART
rates set by a bootloader can be unintentionally changed early on kernel
boot and low level debugging broken, not fixed.  Besides, reset of all
other bits was not justified.

Don't touch register bits not related to UART clocks.  Also, don't touch
the bit of UART2 clock.  Make sure UART1 and UART3 are enabled early on
relevant OMAP1610 machine types while preserving bootloader UART clock
rates on others.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-omap1/clock_data.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap1/clock_data.c b/arch/arm/mach-omap1/clock_data.c
index 36f04da4b939..57d3752babf8 100644
--- a/arch/arm/mach-omap1/clock_data.c
+++ b/arch/arm/mach-omap1/clock_data.c
@@ -766,11 +766,11 @@ int __init omap1_clk_init(void)
 	u32 reg;
 
 #ifdef CONFIG_DEBUG_LL
-	/*
-	 * Resets some clocks that may be left on from bootloader,
-	 * but leaves serial clocks on.
-	 */
-	omap_writel(0x3 << 29, MOD_CONF_CTRL_0);
+	/* Make sure UART clocks are enabled early */
+	if (cpu_is_omap16xx())
+		omap_writel(omap_readl(MOD_CONF_CTRL_0) |
+			    CONF_MOD_UART1_CLK_MODE_R |
+			    CONF_MOD_UART3_CLK_MODE_R, MOD_CONF_CTRL_0);
 #endif
 
 	/* USB_REQ_EN will be disabled later if necessary (usb_dc_ck) */
-- 
2.29.2

