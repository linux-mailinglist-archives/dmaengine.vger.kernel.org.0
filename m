Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE1C506DDE
	for <lists+dmaengine@lfdr.de>; Tue, 19 Apr 2022 15:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352483AbiDSNol (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Apr 2022 09:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352621AbiDSNnX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Apr 2022 09:43:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38D7182;
        Tue, 19 Apr 2022 06:40:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 441C4B8197F;
        Tue, 19 Apr 2022 13:40:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF713C385A7;
        Tue, 19 Apr 2022 13:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650375638;
        bh=oS0YRuMwauHV77a/RWwiH3yEgHRO8x+QFp2K7j65xos=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QunDt7eWVmo28eUVZu9UHc5suCYpMGj+4JLni2IARp821nSt8uFbgl939uUCYSRpA
         PxsB7GMbCapGsEMRTY921XMHJlFjFiFC5XgxN/yTQcpLOG0T87+wsAMhlPoTxVCTdy
         qMkSm/O4UHq8I2m2twis5Ar3U2NmjNf8p78YGeW4zCXxTcTHqMO9dUCsp6/B4xUer2
         xNwUIzAoowxi9QKFChZTh5g3bQExsAJAL9slz/9O+8JnLrPHq0BKOznGXx9LOrTTt1
         nQc43BQvq0/NVCoUERTHShP9hv98faBOm1I2DUm8je01yVkrpUlWYNIDo6Kd2KpLqE
         kN8JkbmkVLH9g==
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
Subject: [PATCH 24/41] ARM: omap: un-merge plat/sram.c
Date:   Tue, 19 Apr 2022 15:37:06 +0200
Message-Id: <20220419133723.1394715-25-arnd@kernel.org>
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

The sram initialization code is the only shared omap1/2 code that
is not a standalone driver, but it is very short. Having two copies
of this code means some duplication of the sources, but actually
saves object code size as it can be inlined better.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-omap1/devices.c          |   2 +-
 arch/arm/mach-omap1/sram-init.c        |  91 +++++++++++++++--
 arch/arm/mach-omap1/sram.h             |   4 +-
 arch/arm/mach-omap2/sram.c             |  91 ++++++++++++++++-
 arch/arm/mach-omap2/sram.h             |   5 +-
 arch/arm/plat-omap/Makefile            |   2 +-
 arch/arm/plat-omap/include/plat/sram.h |   8 --
 arch/arm/plat-omap/sram.c              | 129 -------------------------
 8 files changed, 182 insertions(+), 150 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/plat/sram.h
 delete mode 100644 arch/arm/plat-omap/sram.c

diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
index eb0f09edb3d1..6bc32ebda7a7 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -356,7 +356,7 @@ static int __init omap1_init_devices(void)
 	if (!cpu_class_is_omap1())
 		return -ENODEV;
 
-	omap_sram_init();
+	omap1_sram_init();
 	omap1_clk_late_init();
 
 	/* please keep these calls, and their implementations above,
diff --git a/arch/arm/mach-omap1/sram-init.c b/arch/arm/mach-omap1/sram-init.c
index 3bd60708c345..0e3ec32a008e 100644
--- a/arch/arm/mach-omap1/sram-init.c
+++ b/arch/arm/mach-omap1/sram-init.c
@@ -14,6 +14,7 @@
 #include <asm/fncpy.h>
 #include <asm/tlb.h>
 #include <asm/cacheflush.h>
+#include <asm/set_memory.h>
 
 #include <asm/mach/map.h>
 
@@ -22,18 +23,77 @@
 
 #define OMAP1_SRAM_PA		0x20000000
 #define SRAM_BOOTLOADER_SZ	0x80
+#define ROUND_DOWN(value,boundary)	((value) & (~((boundary)-1)))
+
+static void __iomem *omap_sram_base;
+static unsigned long omap_sram_start;
+static unsigned long omap_sram_skip;
+static unsigned long omap_sram_size;
+static void __iomem *omap_sram_ceil;
+
+/*
+ * Memory allocator for SRAM: calculates the new ceiling address
+ * for pushing a function using the fncpy API.
+ *
+ * Note that fncpy requires the returned address to be aligned
+ * to an 8-byte boundary.
+ */
+static void *omap_sram_push_address(unsigned long size)
+{
+	unsigned long available, new_ceil = (unsigned long)omap_sram_ceil;
+
+	available = omap_sram_ceil - (omap_sram_base + omap_sram_skip);
+
+	if (size > available) {
+		pr_err("Not enough space in SRAM\n");
+		return NULL;
+	}
+
+	new_ceil -= size;
+	new_ceil = ROUND_DOWN(new_ceil, FNCPY_ALIGN);
+	omap_sram_ceil = IOMEM(new_ceil);
+
+	return (void *)omap_sram_ceil;
+}
+
+void *omap_sram_push(void *funcp, unsigned long size)
+{
+	void *sram;
+	unsigned long base;
+	int pages;
+	void *dst = NULL;
+
+	sram = omap_sram_push_address(size);
+	if (!sram)
+		return NULL;
+
+	base = (unsigned long)sram & PAGE_MASK;
+	pages = PAGE_ALIGN(size) / PAGE_SIZE;
+
+	set_memory_rw(base, pages);
+
+	dst = fncpy(sram, funcp, size);
+
+	set_memory_ro(base, pages);
+	set_memory_x(base, pages);
+
+	return dst;
+}
 
 /*
  * The amount of SRAM depends on the core type.
  * Note that we cannot try to test for SRAM here because writes
  * to secure SRAM will hang the system. Also the SRAM is not
  * yet mapped at this point.
+ * Note that we cannot use ioremap for SRAM, as clock init needs SRAM early.
  */
 static void __init omap_detect_and_map_sram(void)
 {
-	unsigned long omap_sram_skip = SRAM_BOOTLOADER_SZ;
-	unsigned long omap_sram_start = OMAP1_SRAM_PA;
-	unsigned long omap_sram_size;
+	unsigned long base;
+	int pages;
+
+	omap_sram_skip = SRAM_BOOTLOADER_SZ;
+	omap_sram_start = OMAP1_SRAM_PA;
 
 	if (cpu_is_omap7xx())
 		omap_sram_size = 0x32000;	/* 200K */
@@ -47,8 +107,27 @@ static void __init omap_detect_and_map_sram(void)
 		omap_sram_size = 0x4000;
 	}
 
-	omap_map_sram(omap_sram_start, omap_sram_size,
-		omap_sram_skip, 1);
+	omap_sram_start = ROUND_DOWN(omap_sram_start, PAGE_SIZE);
+	omap_sram_base = __arm_ioremap_exec(omap_sram_start, omap_sram_size, 1);
+	if (!omap_sram_base) {
+		pr_err("SRAM: Could not map\n");
+		return;
+	}
+
+	omap_sram_ceil = omap_sram_base + omap_sram_size;
+
+	/*
+	 * Looks like we need to preserve some bootloader code at the
+	 * beginning of SRAM for jumping to flash for reboot to work...
+	 */
+	memset_io(omap_sram_base + omap_sram_skip, 0,
+		  omap_sram_size - omap_sram_skip);
+
+	base = (unsigned long)omap_sram_base;
+	pages = PAGE_ALIGN(omap_sram_size) / PAGE_SIZE;
+
+	set_memory_ro(base, pages);
+	set_memory_x(base, pages);
 }
 
 static void (*_omap_sram_reprogram_clock)(u32 dpllctl, u32 ckctl);
@@ -62,7 +141,7 @@ void omap_sram_reprogram_clock(u32 dpllctl, u32 ckctl)
 	_omap_sram_reprogram_clock(dpllctl, ckctl);
 }
 
-int __init omap_sram_init(void)
+int __init omap1_sram_init(void)
 {
 	omap_detect_and_map_sram();
 	_omap_sram_reprogram_clock =
diff --git a/arch/arm/mach-omap1/sram.h b/arch/arm/mach-omap1/sram.h
index 73efabd119e8..f45e6dd6d7e5 100644
--- a/arch/arm/mach-omap1/sram.h
+++ b/arch/arm/mach-omap1/sram.h
@@ -1,8 +1,10 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#include <plat/sram.h>
 
 extern void omap_sram_reprogram_clock(u32 dpllctl, u32 ckctl);
 
+int omap1_sram_init(void);
+void *omap_sram_push(void *funcp, unsigned long size);
+
 /* Do not use these */
 extern void omap1_sram_reprogram_clock(u32 ckctl, u32 dpllctl);
 extern unsigned long omap1_sram_reprogram_clock_sz;
diff --git a/arch/arm/mach-omap2/sram.c b/arch/arm/mach-omap2/sram.c
index c98855f5594b..c685afb8bd03 100644
--- a/arch/arm/mach-omap2/sram.c
+++ b/arch/arm/mach-omap2/sram.c
@@ -18,6 +18,7 @@
 #include <asm/fncpy.h>
 #include <asm/tlb.h>
 #include <asm/cacheflush.h>
+#include <asm/set_memory.h>
 
 #include <asm/mach/map.h>
 
@@ -47,8 +48,68 @@
 #define ROUND_DOWN(value,boundary)	((value) & (~((boundary)-1)))
 
 static unsigned long omap_sram_start;
-static unsigned long omap_sram_skip;
 static unsigned long omap_sram_size;
+static void __iomem *omap_sram_base;
+static unsigned long omap_sram_skip;
+static void __iomem *omap_sram_ceil;
+
+/*
+ * Memory allocator for SRAM: calculates the new ceiling address
+ * for pushing a function using the fncpy API.
+ *
+ * Note that fncpy requires the returned address to be aligned
+ * to an 8-byte boundary.
+ */
+static void *omap_sram_push_address(unsigned long size)
+{
+	unsigned long available, new_ceil = (unsigned long)omap_sram_ceil;
+
+	available = omap_sram_ceil - (omap_sram_base + omap_sram_skip);
+
+	if (size > available) {
+		pr_err("Not enough space in SRAM\n");
+		return NULL;
+	}
+
+	new_ceil -= size;
+	new_ceil = ROUND_DOWN(new_ceil, FNCPY_ALIGN);
+	omap_sram_ceil = IOMEM(new_ceil);
+
+	return (void *)omap_sram_ceil;
+}
+
+void *omap_sram_push(void *funcp, unsigned long size)
+{
+	void *sram;
+	unsigned long base;
+	int pages;
+	void *dst = NULL;
+
+	sram = omap_sram_push_address(size);
+	if (!sram)
+		return NULL;
+
+	base = (unsigned long)sram & PAGE_MASK;
+	pages = PAGE_ALIGN(size) / PAGE_SIZE;
+
+	set_memory_rw(base, pages);
+
+	dst = fncpy(sram, funcp, size);
+
+	set_memory_ro(base, pages);
+	set_memory_x(base, pages);
+
+	return dst;
+}
+
+/*
+ * The SRAM context is lost during off-idle and stack
+ * needs to be reset.
+ */
+static void omap_sram_reset(void)
+{
+	omap_sram_ceil = omap_sram_base + omap_sram_size;
+}
 
 /*
  * Depending on the target RAMFS firewall setup, the public usable amount of
@@ -119,6 +180,8 @@ static void __init omap_detect_sram(void)
  */
 static void __init omap2_map_sram(void)
 {
+	unsigned long base;
+	int pages;
 	int cached = 1;
 
 	if (cpu_is_omap34xx()) {
@@ -132,8 +195,30 @@ static void __init omap2_map_sram(void)
 		cached = 0;
 	}
 
-	omap_map_sram(omap_sram_start, omap_sram_size,
-			omap_sram_skip, cached);
+	if (omap_sram_size == 0)
+		return;
+
+	omap_sram_start = ROUND_DOWN(omap_sram_start, PAGE_SIZE);
+	omap_sram_base = __arm_ioremap_exec(omap_sram_start, omap_sram_size, cached);
+	if (!omap_sram_base) {
+		pr_err("SRAM: Could not map\n");
+		return;
+	}
+
+	omap_sram_reset();
+
+	/*
+	 * Looks like we need to preserve some bootloader code at the
+	 * beginning of SRAM for jumping to flash for reboot to work...
+	 */
+	memset_io(omap_sram_base + omap_sram_skip, 0,
+		  omap_sram_size - omap_sram_skip);
+
+	base = (unsigned long)omap_sram_base;
+	pages = PAGE_ALIGN(omap_sram_size) / PAGE_SIZE;
+
+	set_memory_ro(base, pages);
+	set_memory_x(base, pages);
 }
 
 static void (*_omap2_sram_ddr_init)(u32 *slow_dll_ctrl, u32 fast_dll_ctrl,
diff --git a/arch/arm/mach-omap2/sram.h b/arch/arm/mach-omap2/sram.h
index 447bd3eed0fd..271062f23482 100644
--- a/arch/arm/mach-omap2/sram.h
+++ b/arch/arm/mach-omap2/sram.h
@@ -4,7 +4,6 @@
  */
 
 #ifndef __ASSEMBLY__
-#include <plat/sram.h>
 
 extern void omap2_sram_ddr_init(u32 *slow_dll_ctrl, u32 fast_dll_ctrl,
 				u32 base_cs, u32 force_unlock);
@@ -14,6 +13,10 @@ extern u32 omap2_set_prcm(u32 dpll_ctrl_val, u32 sdrc_rfr_val, int bypass);
 
 extern void omap3_sram_restore_context(void);
 
+extern int __init omap_sram_init(void);
+
+extern void *omap_sram_push(void *funcp, unsigned long size);
+
 /* Do not use these */
 extern void omap24xx_sram_reprogram_clock(u32 ckctl, u32 dpllctl);
 extern unsigned long omap24xx_sram_reprogram_clock_sz;
diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index 5d55295a14ee..fefce2e1eaf3 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -6,4 +6,4 @@
 ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/arch/arm/plat-omap/include
 
 # Common support
-obj-y := sram.o
+obj-y :=
diff --git a/arch/arm/plat-omap/include/plat/sram.h b/arch/arm/plat-omap/include/plat/sram.h
deleted file mode 100644
index 30a07730807a..000000000000
--- a/arch/arm/plat-omap/include/plat/sram.h
+++ /dev/null
@@ -1,8 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-int omap_sram_init(void);
-
-void omap_map_sram(unsigned long start, unsigned long size,
-			unsigned long skip, int cached);
-void omap_sram_reset(void);
-
-extern void *omap_sram_push(void *funcp, unsigned long size);
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
deleted file mode 100644
index 0f1eacad7fe3..000000000000
--- a/arch/arm/plat-omap/sram.c
+++ /dev/null
@@ -1,129 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * linux/arch/arm/plat-omap/sram.c
- *
- * OMAP SRAM detection and management
- *
- * Copyright (C) 2005 Nokia Corporation
- * Written by Tony Lindgren <tony@atomide.com>
- *
- * Copyright (C) 2009-2012 Texas Instruments
- * Added OMAP4/5 support - Santosh Shilimkar <santosh.shilimkar@ti.com>
- */
-#undef DEBUG
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/io.h>
-
-#include <asm/fncpy.h>
-#include <asm/tlb.h>
-#include <asm/cacheflush.h>
-#include <asm/set_memory.h>
-
-#include <asm/mach/map.h>
-
-#include <plat/sram.h>
-
-#define ROUND_DOWN(value,boundary)	((value) & (~((boundary)-1)))
-
-static void __iomem *omap_sram_base;
-static unsigned long omap_sram_skip;
-static unsigned long omap_sram_size;
-static void __iomem *omap_sram_ceil;
-
-/*
- * Memory allocator for SRAM: calculates the new ceiling address
- * for pushing a function using the fncpy API.
- *
- * Note that fncpy requires the returned address to be aligned
- * to an 8-byte boundary.
- */
-static void *omap_sram_push_address(unsigned long size)
-{
-	unsigned long available, new_ceil = (unsigned long)omap_sram_ceil;
-
-	available = omap_sram_ceil - (omap_sram_base + omap_sram_skip);
-
-	if (size > available) {
-		pr_err("Not enough space in SRAM\n");
-		return NULL;
-	}
-
-	new_ceil -= size;
-	new_ceil = ROUND_DOWN(new_ceil, FNCPY_ALIGN);
-	omap_sram_ceil = IOMEM(new_ceil);
-
-	return (void *)omap_sram_ceil;
-}
-
-void *omap_sram_push(void *funcp, unsigned long size)
-{
-	void *sram;
-	unsigned long base;
-	int pages;
-	void *dst = NULL;
-
-	sram = omap_sram_push_address(size);
-	if (!sram)
-		return NULL;
-
-	base = (unsigned long)sram & PAGE_MASK;
-	pages = PAGE_ALIGN(size) / PAGE_SIZE;
-
-	set_memory_rw(base, pages);
-
-	dst = fncpy(sram, funcp, size);
-
-	set_memory_ro(base, pages);
-	set_memory_x(base, pages);
-
-	return dst;
-}
-
-/*
- * The SRAM context is lost during off-idle and stack
- * needs to be reset.
- */
-void omap_sram_reset(void)
-{
-	omap_sram_ceil = omap_sram_base + omap_sram_size;
-}
-
-/*
- * Note that we cannot use ioremap for SRAM, as clock init needs SRAM early.
- */
-void __init omap_map_sram(unsigned long start, unsigned long size,
-				 unsigned long skip, int cached)
-{
-	unsigned long base;
-	int pages;
-
-	if (size == 0)
-		return;
-
-	start = ROUND_DOWN(start, PAGE_SIZE);
-	omap_sram_size = size;
-	omap_sram_skip = skip;
-	omap_sram_base = __arm_ioremap_exec(start, size, cached);
-	if (!omap_sram_base) {
-		pr_err("SRAM: Could not map\n");
-		return;
-	}
-
-	omap_sram_reset();
-
-	/*
-	 * Looks like we need to preserve some bootloader code at the
-	 * beginning of SRAM for jumping to flash for reboot to work...
-	 */
-	memset_io(omap_sram_base + omap_sram_skip, 0,
-		  omap_sram_size - omap_sram_skip);
-
-	base = (unsigned long)omap_sram_base;
-	pages = PAGE_ALIGN(omap_sram_size) / PAGE_SIZE;
-
-	set_memory_ro(base, pages);
-	set_memory_x(base, pages);
-}
-- 
2.29.2

