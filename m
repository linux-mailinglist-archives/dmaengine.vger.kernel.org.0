Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4E9506E90
	for <lists+dmaengine@lfdr.de>; Tue, 19 Apr 2022 15:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352624AbiDSNpG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Apr 2022 09:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352812AbiDSNoC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Apr 2022 09:44:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6752AB876;
        Tue, 19 Apr 2022 06:41:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA6E2616BF;
        Tue, 19 Apr 2022 13:41:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BA99C385AC;
        Tue, 19 Apr 2022 13:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650375675;
        bh=Zu+s/Y6CPoLWnIUPjVgATnzi0v1z3Jhkw2fBKn8V10M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U5cHM84vrLY3O3eyj59RLMY2m4fa/fIXcrDCJ9kjqXW9XoISe3lQxXTO6L1dAaoQk
         oQoOecRjFl/5jFqnm0E7okbJ6ifMuDNAdWBOnlrkhp25WpgKIJYVTtI7PuyR0j44Wt
         7VsEFwWnvRKUEPainDkDn9AuVbG7J1W7AlpltYmSzKoWeF58QXmvv/f82nxuMT/W8N
         aPUFb2G2ez74e0BV9D2X9qJaN5aJ9wiK14osJsk3UfjTmuRqz6tm7WcpnIOvwfOH1f
         Xlf8Y8XE35dK5tWzEayPKnnm9LQnhR2Mue+H9vmhX/9J78LZeH0skpwslSkMEsZyAj
         DLN5B2SpMEUCQ==
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
Subject: [PATCH 29/41] ARM: omap1: fix build with no SoC selected
Date:   Tue, 19 Apr 2022 15:37:11 +0200
Message-Id: <20220419133723.1394715-30-arnd@kernel.org>
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

In a multiplatform randconfig kernel, one can have
CONFIG_ARCH_OMAP1 enabled, but none of the specific SoCs.
This leads to some build issues as the code is not
meant to deal with this configuration at the moment:

arch/arm/mach-omap1/io.c:86:20: error: unused function 'omap1_map_common_io' [-Werror,-Wunused-function]
arch/arm/mach-omap1/pm.h:113:2: error: "Power management for this processor not implemented yet" [-Werror,-W#warnings]

Use the same trick as on OMAP2 and guard the actual compilation
of platform code with another Makefile ifdef check based
on an option that depends on having at least one SoC enabled.

The io.c file still needs to get compiled to allow building
device drivers with a dependency on CONFIG_ARCH_OMAP1.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig                | 1 -
 arch/arm/mach-omap1/Kconfig     | 4 ++++
 arch/arm/mach-omap1/Makefile    | 4 ++++
 include/linux/soc/ti/omap1-io.h | 4 ++--
 4 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index fb6afa6bbc8f..a65f2c05f01c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -485,7 +485,6 @@ config ARCH_S3C24XX
 
 config ARCH_OMAP1
 	bool "TI OMAP1"
-	select ARCH_OMAP
 	select CLKSRC_MMIO
 	select FORCE_PCI if PCCARD
 	select GENERIC_IRQ_CHIP
diff --git a/arch/arm/mach-omap1/Kconfig b/arch/arm/mach-omap1/Kconfig
index 93ea86954a84..d4b0cd91a4f9 100644
--- a/arch/arm/mach-omap1/Kconfig
+++ b/arch/arm/mach-omap1/Kconfig
@@ -28,6 +28,10 @@ config ARCH_OMAP16XX
 	select CPU_ARM926T
 	select OMAP_DM_TIMER
 
+config ARCH_OMAP1_ANY
+	select ARCH_OMAP
+	def_bool ARCH_OMAP730 || ARCH_OMAP850 || ARCH_OMAP15XX || ARCH_OMAP16XX
+
 config ARCH_OMAP
 	bool
 
diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makefile
index 0615cb0ba580..506074b86333 100644
--- a/arch/arm/mach-omap1/Makefile
+++ b/arch/arm/mach-omap1/Makefile
@@ -3,6 +3,8 @@
 # Makefile for the linux kernel.
 #
 
+ifdef CONFIG_ARCH_OMAP1_ANY
+
 # Common support
 obj-y := io.o id.o sram-init.o sram.o time.o irq.o mux.o flash.o \
 	 serial.o devices.o dma.o omap-dma.o fb.o
@@ -57,3 +59,5 @@ obj-$(CONFIG_ARCH_OMAP730)		+= gpio7xx.o
 obj-$(CONFIG_ARCH_OMAP850)		+= gpio7xx.o
 obj-$(CONFIG_ARCH_OMAP15XX)		+= gpio15xx.o
 obj-$(CONFIG_ARCH_OMAP16XX)		+= gpio16xx.o
+
+endif
diff --git a/include/linux/soc/ti/omap1-io.h b/include/linux/soc/ti/omap1-io.h
index 9332c92690f4..f7f12728d4a6 100644
--- a/include/linux/soc/ti/omap1-io.h
+++ b/include/linux/soc/ti/omap1-io.h
@@ -5,7 +5,7 @@
 #ifndef __ASSEMBLER__
 #include <linux/types.h>
 
-#if defined(CONFIG_ARCH_OMAP) && defined(CONFIG_ARCH_OMAP1)
+#ifdef CONFIG_ARCH_OMAP1_ANY
 /*
  * NOTE: Please use ioremap + __raw_read/write where possible instead of these
  */
@@ -15,7 +15,7 @@ extern u32 omap_readl(u32 pa);
 extern void omap_writeb(u8 v, u32 pa);
 extern void omap_writew(u16 v, u32 pa);
 extern void omap_writel(u32 v, u32 pa);
-#elif defined(CONFIG_COMPILE_TEST)
+#else
 static inline u8 omap_readb(u32 pa)  { return 0; }
 static inline u16 omap_readw(u32 pa) { return 0; }
 static inline u32 omap_readl(u32 pa) { return 0; }
-- 
2.29.2

