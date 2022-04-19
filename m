Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDA0506E98
	for <lists+dmaengine@lfdr.de>; Tue, 19 Apr 2022 15:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351067AbiDSNoi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Apr 2022 09:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352699AbiDSNnh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Apr 2022 09:43:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102ED24F;
        Tue, 19 Apr 2022 06:40:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C68D6B8197F;
        Tue, 19 Apr 2022 13:40:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD49CC385AA;
        Tue, 19 Apr 2022 13:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650375652;
        bh=++wgzzP18IgZjv9gq3IHjeFk3mw3AxMESGKM1bss8GE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t77plAsS6dzi52zALntxTrIsGvlZ7TVWnBbbBL6BHh9HDB22Vsg+GSU1TUGr/L7yo
         4VED/jnUp/m/iprQbhEzkF/oCLBhn5mjye8/COB4ccOhKBk+sJixyUn/j4z5hhYvAS
         fOMPXYC1p6lswgiO83CT8qRkpbcih1isQSb5qwxzvrTQT+MaBaR+iH3FJlzRpZeFL+
         xLv4MH8XhKivg2WwM9SJ6+BOtF2fIbLSMuGDS0PC2ZNc4r0d6HSPSj40prxX3RgJXN
         wDqi6ESmFTYAF/uvoZWrHFUtV7uChc7cszyCFCMHFQ8dub8SswJUKqRzrKaa1+D2F9
         cs9GhVWEGvR5A==
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
Subject: [PATCH 26/41] ARM: omap1: relocate static I/O mapping
Date:   Tue, 19 Apr 2022 15:37:08 +0200
Message-Id: <20220419133723.1394715-27-arnd@kernel.org>
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

The address range 0xfee00000-0xfeffffff is used for PCI and
PCMCIA I/O port mappings, but OMAP1 has its static mappings
there as well.

Move the OMAP1 addresses a little higher to avoid crashing
at boot.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig.debug                      | 6 +++---
 arch/arm/mach-omap1/include/mach/hardware.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 0c9497d549e3..f57b449000f7 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1837,9 +1837,9 @@ config DEBUG_UART_VIRT
 	default 0xfec00000 if ARCH_IXP4XX && !CPU_BIG_ENDIAN
 	default 0xfec00003 if ARCH_IXP4XX && CPU_BIG_ENDIAN
 	default 0xfef36000 if DEBUG_HIGHBANK_UART
-	default 0xfefb0000 if DEBUG_OMAP1UART1 || DEBUG_OMAP7XXUART1
-	default 0xfefb0800 if DEBUG_OMAP1UART2 || DEBUG_OMAP7XXUART2
-	default 0xfefb9800 if DEBUG_OMAP1UART3 || DEBUG_OMAP7XXUART3
+	default 0xff000000 if DEBUG_OMAP1UART1 || DEBUG_OMAP7XXUART1
+	default 0xff000800 if DEBUG_OMAP1UART2 || DEBUG_OMAP7XXUART2
+	default 0xff009800 if DEBUG_OMAP1UART3 || DEBUG_OMAP7XXUART3
 	default 0xffd01000 if DEBUG_HIP01_UART
 	default DEBUG_UART_PHYS if !MMU
 	depends on DEBUG_LL_UART_8250 || DEBUG_LL_UART_PL01X || \
diff --git a/arch/arm/mach-omap1/include/mach/hardware.h b/arch/arm/mach-omap1/include/mach/hardware.h
index 05c5cd3e95f4..e3522e601ccd 100644
--- a/arch/arm/mach-omap1/include/mach/hardware.h
+++ b/arch/arm/mach-omap1/include/mach/hardware.h
@@ -63,7 +63,7 @@ static inline u32 omap_cs3_phys(void)
 
 #endif	/* ifndef __ASSEMBLER__ */
 
-#define OMAP1_IO_OFFSET		0x01000000	/* Virtual IO = 0xfefb0000 */
+#define OMAP1_IO_OFFSET		0x00fb0000	/* Virtual IO = 0xff000000 */
 #define OMAP1_IO_ADDRESS(pa)	IOMEM((pa) - OMAP1_IO_OFFSET)
 
 #include <mach/serial.h>
-- 
2.29.2

