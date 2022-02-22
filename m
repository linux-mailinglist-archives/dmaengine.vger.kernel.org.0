Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88CB4BF452
	for <lists+dmaengine@lfdr.de>; Tue, 22 Feb 2022 10:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiBVJFN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 22 Feb 2022 04:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiBVJFL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 22 Feb 2022 04:05:11 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51748137599;
        Tue, 22 Feb 2022 01:04:44 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 071BB1F39A;
        Tue, 22 Feb 2022 09:04:43 +0000 (UTC)
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 91254A3B89;
        Tue, 22 Feb 2022 09:04:42 +0000 (UTC)
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Paul Cercueil <paul@crapouillou.net>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: [PATCH] MIPS: Remove TX39XX support
Date:   Tue, 22 Feb 2022 10:04:28 +0100
Message-Id: <20220222090435.62571-1-tsbogend@alpha.franken.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

No (active) developer owns this hardware, so let's remove Linux support.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
 arch/mips/Kbuild.platforms                    |   1 -
 arch/mips/Kconfig                             |  24 +-
 arch/mips/Makefile                            |   1 -
 arch/mips/configs/jmr3927_defconfig           |  50 ---
 arch/mips/include/asm/cpu-features.h          |   3 -
 arch/mips/include/asm/cpu-type.h              |   6 -
 arch/mips/include/asm/cpu.h                   |   6 -
 arch/mips/include/asm/isadep.h                |   2 +-
 .../asm/mach-ath25/cpu-feature-overrides.h    |   1 -
 .../asm/mach-ath79/cpu-feature-overrides.h    |   1 -
 .../asm/mach-au1x00/cpu-feature-overrides.h   |   1 -
 .../asm/mach-bcm47xx/cpu-feature-overrides.h  |   1 -
 .../cpu-feature-overrides.h                   |   1 -
 .../asm/mach-cobalt/cpu-feature-overrides.h   |   1 -
 .../asm/mach-dec/cpu-feature-overrides.h      |   1 -
 .../asm/mach-ingenic/cpu-feature-overrides.h  |   1 -
 .../asm/mach-ip27/cpu-feature-overrides.h     |   1 -
 .../asm/mach-ip30/cpu-feature-overrides.h     |   1 -
 .../falcon/cpu-feature-overrides.h            |   1 -
 .../mach-loongson2ef/cpu-feature-overrides.h  |   1 -
 .../mach-loongson64/cpu-feature-overrides.h   |   1 -
 .../mt7620/cpu-feature-overrides.h            |   1 -
 .../mt7621/cpu-feature-overrides.h            |   1 -
 .../rt288x/cpu-feature-overrides.h            |   1 -
 .../rt305x/cpu-feature-overrides.h            |   1 -
 .../rt3883/cpu-feature-overrides.h            |   1 -
 .../asm/mach-rc32434/cpu-feature-overrides.h  |   1 -
 arch/mips/include/asm/mach-tx39xx/ioremap.h   |  25 --
 .../include/asm/mach-tx39xx/mangle-port.h     |  24 -
 arch/mips/include/asm/mach-tx39xx/spaces.h    |  17 -
 arch/mips/include/asm/stackframe.h            |   6 +-
 arch/mips/include/asm/txx9/boards.h           |   3 -
 arch/mips/include/asm/txx9/jmr3927.h          | 179 --------
 arch/mips/include/asm/txx9/tx3927.h           | 341 ---------------
 arch/mips/include/asm/txx9irq.h               |   4 -
 arch/mips/include/asm/txx9tmr.h               |   4 -
 arch/mips/include/asm/vermagic.h              |   2 -
 arch/mips/kernel/Makefile                     |   1 -
 arch/mips/kernel/cpu-probe.c                  |  23 -
 arch/mips/kernel/cpu-r3k-probe.c              |  22 -
 arch/mips/kernel/entry.S                      |   2 +-
 arch/mips/kernel/genex.S                      |   4 +-
 arch/mips/kernel/idle.c                       |  10 -
 arch/mips/kernel/irq_txx9.c                   |  13 -
 arch/mips/kernel/proc.c                       |   2 -
 arch/mips/kernel/process.c                    |   2 +-
 arch/mips/lib/Makefile                        |   1 -
 arch/mips/lib/r3k_dump_tlb.c                  |   4 -
 arch/mips/mm/Makefile                         |   1 -
 arch/mips/mm/c-tx39.c                         | 414 ------------------
 arch/mips/mm/cache.c                          |   5 -
 arch/mips/mm/tlb-r3k.c                        |  40 +-
 arch/mips/pci/Makefile                        |   2 -
 arch/mips/pci/fixup-jmr3927.c                 |  79 ----
 arch/mips/pci/ops-tx3927.c                    | 231 ----------
 arch/mips/txx9/Kconfig                        |  18 -
 arch/mips/txx9/Makefile                       |   6 -
 arch/mips/txx9/Platform                       |   3 -
 arch/mips/txx9/generic/Makefile               |   1 -
 arch/mips/txx9/generic/irq_tx3927.c           |  25 --
 arch/mips/txx9/generic/setup.c                |  55 ---
 arch/mips/txx9/generic/setup_tx3927.c         | 136 ------
 arch/mips/txx9/jmr3927/Makefile               |   6 -
 arch/mips/txx9/jmr3927/irq.c                  | 128 ------
 arch/mips/txx9/jmr3927/prom.c                 |  52 ---
 arch/mips/txx9/jmr3927/setup.c                | 223 ----------
 drivers/dma/Kconfig                           |   2 +-
 drivers/watchdog/Kconfig                      |   2 +-
 68 files changed, 18 insertions(+), 2212 deletions(-)
 delete mode 100644 arch/mips/configs/jmr3927_defconfig
 delete mode 100644 arch/mips/include/asm/mach-tx39xx/ioremap.h
 delete mode 100644 arch/mips/include/asm/mach-tx39xx/mangle-port.h
 delete mode 100644 arch/mips/include/asm/mach-tx39xx/spaces.h
 delete mode 100644 arch/mips/include/asm/txx9/jmr3927.h
 delete mode 100644 arch/mips/include/asm/txx9/tx3927.h
 delete mode 100644 arch/mips/mm/c-tx39.c
 delete mode 100644 arch/mips/pci/fixup-jmr3927.c
 delete mode 100644 arch/mips/pci/ops-tx3927.c
 delete mode 100644 arch/mips/txx9/generic/irq_tx3927.c
 delete mode 100644 arch/mips/txx9/generic/setup_tx3927.c
 delete mode 100644 arch/mips/txx9/jmr3927/Makefile
 delete mode 100644 arch/mips/txx9/jmr3927/irq.c
 delete mode 100644 arch/mips/txx9/jmr3927/prom.c
 delete mode 100644 arch/mips/txx9/jmr3927/setup.c

diff --git a/arch/mips/Kbuild.platforms b/arch/mips/Kbuild.platforms
index 30193bcf9caa..1bc4282af064 100644
--- a/arch/mips/Kbuild.platforms
+++ b/arch/mips/Kbuild.platforms
@@ -32,7 +32,6 @@ platform-$(CONFIG_SIBYTE_SB1250)	+= sibyte/
 platform-$(CONFIG_SIBYTE_BCM1x55)	+= sibyte/
 platform-$(CONFIG_SIBYTE_BCM1x80)	+= sibyte/
 platform-$(CONFIG_SNI_RM)		+= sni/
-platform-$(CONFIG_MACH_TX39XX)		+= txx9/
 platform-$(CONFIG_MACH_TX49XX)		+= txx9/
 platform-$(CONFIG_MACH_VR41XX)		+= vr41xx/
 
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index f8f11542d044..59dabfd5a129 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -927,9 +927,6 @@ config SNI_RM
 	  Technology and now in turn merged with Fujitsu.  Say Y here to
 	  support this machine type.
 
-config MACH_TX39XX
-	bool "Toshiba TX39 series based machines"
-
 config MACH_TX49XX
 	bool "Toshiba TX49 series based machines"
 	select WAR_TX49XX_ICACHE_INDEX_INV
@@ -1584,12 +1581,6 @@ config CPU_R3000
 	  might be a safe bet.  If the resulting kernel does not work,
 	  try to recompile with R3000.
 
-config CPU_TX39XX
-	bool "R39XX"
-	depends on SYS_HAS_CPU_TX39XX
-	select CPU_SUPPORTS_32BIT_KERNEL
-	select CPU_R3K_TLB
-
 config CPU_VR41XX
 	bool "R41xx"
 	depends on SYS_HAS_CPU_VR41XX
@@ -1916,9 +1907,6 @@ config SYS_HAS_CPU_P5600
 config SYS_HAS_CPU_R3000
 	bool
 
-config SYS_HAS_CPU_TX39XX
-	bool
-
 config SYS_HAS_CPU_VR41XX
 	bool
 
@@ -2149,7 +2137,7 @@ config PAGE_SIZE_8KB
 
 config PAGE_SIZE_16KB
 	bool "16kB"
-	depends on !CPU_R3000 && !CPU_TX39XX
+	depends on !CPU_R3000
 	help
 	  Using 16kB page size will result in higher performance kernel at
 	  the price of higher memory consumption.  This option is available on
@@ -2168,7 +2156,7 @@ config PAGE_SIZE_32KB
 
 config PAGE_SIZE_64KB
 	bool "64kB"
-	depends on !CPU_R3000 && !CPU_TX39XX
+	depends on !CPU_R3000
 	help
 	  Using 64kB page size will result in higher performance kernel at
 	  the price of higher memory consumption.  This option is available on
@@ -2236,7 +2224,7 @@ config CPU_HAS_PREFETCH
 
 config CPU_GENERIC_DUMP_TLB
 	bool
-	default y if !(CPU_R3000 || CPU_TX39XX)
+	default y if !CPU_R3000
 
 config MIPS_FP_SUPPORT
 	bool "Floating Point support" if EXPERT
@@ -2256,7 +2244,7 @@ config MIPS_FP_SUPPORT
 config CPU_R2300_FPU
 	bool
 	depends on MIPS_FP_SUPPORT
-	default y if CPU_R3000 || CPU_TX39XX
+	default y if CPU_R3000
 
 config CPU_R3K_TLB
 	bool
@@ -2575,13 +2563,13 @@ config CPU_R4X00_BUGS64
 
 config MIPS_ASID_SHIFT
 	int
-	default 6 if CPU_R3000 || CPU_TX39XX
+	default 6 if CPU_R3000
 	default 0
 
 config MIPS_ASID_BITS
 	int
 	default 0 if MIPS_ASID_BITS_VARIABLE
-	default 6 if CPU_R3000 || CPU_TX39XX
+	default 6 if CPU_R3000
 	default 8
 
 config MIPS_ASID_BITS_VARIABLE
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index e036fc025ccc..47ca5488434a 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -158,7 +158,6 @@ cflags-y += $(call as-option,-Wa$(comma)-mno-fix-loongson3-llsc,)
 # CPU-dependent compiler/assembler options for optimization.
 #
 cflags-$(CONFIG_CPU_R3000)	+= -march=r3000
-cflags-$(CONFIG_CPU_TX39XX)	+= -march=r3900
 cflags-$(CONFIG_CPU_R4300)	+= -march=r4300 -Wa,--trap
 cflags-$(CONFIG_CPU_VR41XX)	+= -march=r4100 -Wa,--trap
 cflags-$(CONFIG_CPU_R4X00)	+= -march=r4600 -Wa,--trap
diff --git a/arch/mips/configs/jmr3927_defconfig b/arch/mips/configs/jmr3927_defconfig
deleted file mode 100644
index 24b96faf9b4e..000000000000
--- a/arch/mips/configs/jmr3927_defconfig
+++ /dev/null
@@ -1,50 +0,0 @@
-CONFIG_SYSVIPC=y
-CONFIG_LOG_BUF_SHIFT=14
-CONFIG_EXPERT=y
-CONFIG_SLAB=y
-CONFIG_MACH_TX39XX=y
-CONFIG_TOSHIBA_JMR3927=y
-# CONFIG_SECCOMP is not set
-CONFIG_PCI=y
-CONFIG_NET=y
-CONFIG_PACKET=y
-CONFIG_UNIX=y
-CONFIG_INET=y
-CONFIG_IP_PNP=y
-CONFIG_IP_PNP_BOOTP=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_DIAG is not set
-# CONFIG_IPV6 is not set
-CONFIG_MTD=y
-CONFIG_MTD_CMDLINE_PARTS=y
-CONFIG_MTD_CFI=y
-CONFIG_MTD_JEDECPROBE=y
-CONFIG_MTD_CFI_AMDSTD=y
-CONFIG_MTD_PHYSMAP=y
-CONFIG_NETDEVICES=y
-CONFIG_TC35815=y
-# CONFIG_INPUT is not set
-# CONFIG_SERIO is not set
-# CONFIG_VT is not set
-# CONFIG_UNIX98_PTYS is not set
-CONFIG_SERIAL_NONSTANDARD=y
-CONFIG_SERIAL_TXX9_CONSOLE=y
-CONFIG_SERIAL_TXX9_STDSERIAL=y
-# CONFIG_HW_RANDOM is not set
-# CONFIG_HWMON is not set
-CONFIG_WATCHDOG=y
-CONFIG_TXX9_WDT=y
-# CONFIG_USB_SUPPORT is not set
-CONFIG_NEW_LEDS=y
-CONFIG_LEDS_CLASS=y
-CONFIG_LEDS_GPIO=y
-CONFIG_LEDS_TRIGGERS=y
-CONFIG_LEDS_TRIGGER_HEARTBEAT=y
-CONFIG_RTC_CLASS=y
-CONFIG_RTC_DRV_DS1742=y
-CONFIG_PROC_KCORE=y
-# CONFIG_MISC_FILESYSTEMS is not set
-CONFIG_NFS_FS=y
-CONFIG_ROOT_NFS=y
diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index 3d71081afc55..de8cb2ccb781 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -120,9 +120,6 @@
 #ifndef cpu_has_4k_cache
 #define cpu_has_4k_cache	__isa_ge_or_opt(1, MIPS_CPU_4K_CACHE)
 #endif
-#ifndef cpu_has_tx39_cache
-#define cpu_has_tx39_cache	__opt(MIPS_CPU_TX39_CACHE)
-#endif
 #ifndef cpu_has_octeon_cache
 #define cpu_has_octeon_cache	0
 #endif
diff --git a/arch/mips/include/asm/cpu-type.h b/arch/mips/include/asm/cpu-type.h
index 5efe8c8b854e..5582ff0c247e 100644
--- a/arch/mips/include/asm/cpu-type.h
+++ b/arch/mips/include/asm/cpu-type.h
@@ -105,12 +105,6 @@ static inline int __pure __get_cpu_type(const int cpu_type)
 	case CPU_R3081E:
 #endif
 
-#ifdef CONFIG_SYS_HAS_CPU_TX39XX
-	case CPU_TX3912:
-	case CPU_TX3922:
-	case CPU_TX3927:
-#endif
-
 #ifdef CONFIG_SYS_HAS_CPU_VR41XX
 	case CPU_VR41XX:
 	case CPU_VR4111:
diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index 5c2f8d9cb7cf..00a3fc7d778d 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -309,11 +309,6 @@ enum cpu_type_enum {
 	CPU_VR4122, CPU_VR4131, CPU_VR4133, CPU_VR4181, CPU_VR4181A, CPU_RM7000,
 	CPU_SR71000, CPU_TX49XX,
 
-	/*
-	 * TX3900 class processors
-	 */
-	CPU_TX3912, CPU_TX3922, CPU_TX3927,
-
 	/*
 	 * MIPS32 class processors
 	 */
@@ -367,7 +362,6 @@ enum cpu_type_enum {
 #define MIPS_CPU_4KEX		BIT_ULL( 1)	/* "R4K" exception model */
 #define MIPS_CPU_3K_CACHE	BIT_ULL( 2)	/* R3000-style caches */
 #define MIPS_CPU_4K_CACHE	BIT_ULL( 3)	/* R4000-style caches */
-#define MIPS_CPU_TX39_CACHE	BIT_ULL( 4)	/* TX3900-style caches */
 #define MIPS_CPU_FPU		BIT_ULL( 5)	/* CPU has FPU */
 #define MIPS_CPU_32FPR		BIT_ULL( 6)	/* 32 dbl. prec. FP registers */
 #define MIPS_CPU_COUNTER	BIT_ULL( 7)	/* Cycle count/compare */
diff --git a/arch/mips/include/asm/isadep.h b/arch/mips/include/asm/isadep.h
index d1683202399b..8fc1e3ae8d0c 100644
--- a/arch/mips/include/asm/isadep.h
+++ b/arch/mips/include/asm/isadep.h
@@ -10,7 +10,7 @@
 #ifndef __ASM_ISADEP_H
 #define __ASM_ISADEP_H
 
-#if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX)
+#if defined(CONFIG_CPU_R3000)
 /*
  * R2000 or R3000
  */
diff --git a/arch/mips/include/asm/mach-ath25/cpu-feature-overrides.h b/arch/mips/include/asm/mach-ath25/cpu-feature-overrides.h
index a54f20d956a2..ec3604c44ef2 100644
--- a/arch/mips/include/asm/mach-ath25/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-ath25/cpu-feature-overrides.h
@@ -18,7 +18,6 @@
 #define cpu_has_4kex			1
 #define cpu_has_3k_cache		0
 #define cpu_has_4k_cache		1
-#define cpu_has_tx39_cache		0
 #define cpu_has_sb1_cache		0
 #define cpu_has_fpu			0
 #define cpu_has_32fpr			0
diff --git a/arch/mips/include/asm/mach-ath79/cpu-feature-overrides.h b/arch/mips/include/asm/mach-ath79/cpu-feature-overrides.h
index 79ab3ad9fee8..44fd44a5fc42 100644
--- a/arch/mips/include/asm/mach-ath79/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-ath79/cpu-feature-overrides.h
@@ -16,7 +16,6 @@
 #define cpu_has_4kex		1
 #define cpu_has_3k_cache	0
 #define cpu_has_4k_cache	1
-#define cpu_has_tx39_cache	0
 #define cpu_has_sb1_cache	0
 #define cpu_has_fpu		0
 #define cpu_has_32fpr		0
diff --git a/arch/mips/include/asm/mach-au1x00/cpu-feature-overrides.h b/arch/mips/include/asm/mach-au1x00/cpu-feature-overrides.h
index e6e527224a15..3c200303ae55 100644
--- a/arch/mips/include/asm/mach-au1x00/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-au1x00/cpu-feature-overrides.h
@@ -21,7 +21,6 @@
 #define cpu_has_4kex			1
 #define cpu_has_3k_cache		0
 #define cpu_has_4k_cache		1
-#define cpu_has_tx39_cache		0
 #define cpu_has_fpu			0
 #define cpu_has_32fpr			0
 #define cpu_has_counter			1
diff --git a/arch/mips/include/asm/mach-bcm47xx/cpu-feature-overrides.h b/arch/mips/include/asm/mach-bcm47xx/cpu-feature-overrides.h
index b23ff47ea475..69899c1e122d 100644
--- a/arch/mips/include/asm/mach-bcm47xx/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-bcm47xx/cpu-feature-overrides.h
@@ -6,7 +6,6 @@
 #define cpu_has_4kex			1
 #define cpu_has_3k_cache		0
 #define cpu_has_4k_cache		1
-#define cpu_has_tx39_cache		0
 #define cpu_has_fpu			0
 #define cpu_has_32fpr			0
 #define cpu_has_counter			1
diff --git a/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h b/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
index 513270c8adb9..9151dcd9d0d5 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
@@ -21,7 +21,6 @@
 #define cpu_has_4kex		1
 #define cpu_has_3k_cache	0
 #define cpu_has_4k_cache	0
-#define cpu_has_tx39_cache	0
 #define cpu_has_counter		1
 #define cpu_has_watch		1
 #define cpu_has_divec		1
diff --git a/arch/mips/include/asm/mach-cobalt/cpu-feature-overrides.h b/arch/mips/include/asm/mach-cobalt/cpu-feature-overrides.h
index 291fe90aafa5..03192458471d 100644
--- a/arch/mips/include/asm/mach-cobalt/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-cobalt/cpu-feature-overrides.h
@@ -13,7 +13,6 @@
 #define cpu_has_4kex		1
 #define cpu_has_3k_cache	0
 #define cpu_has_4k_cache	1
-#define cpu_has_tx39_cache	0
 #define cpu_has_32fpr		1
 #define cpu_has_counter		1
 #define cpu_has_watch		0
diff --git a/arch/mips/include/asm/mach-dec/cpu-feature-overrides.h b/arch/mips/include/asm/mach-dec/cpu-feature-overrides.h
index 1896e88f6000..3ddc4b4dca26 100644
--- a/arch/mips/include/asm/mach-dec/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-dec/cpu-feature-overrides.h
@@ -17,7 +17,6 @@
 #define cpu_has_rixiex			0
 #define cpu_has_maar			0
 #define cpu_has_rw_llb			0
-#define cpu_has_tx39_cache		0
 #define cpu_has_divec			0
 #define cpu_has_prefetch		0
 #define cpu_has_mcheck			0
diff --git a/arch/mips/include/asm/mach-ingenic/cpu-feature-overrides.h b/arch/mips/include/asm/mach-ingenic/cpu-feature-overrides.h
index 7c5e576f9d96..7ace50127f5a 100644
--- a/arch/mips/include/asm/mach-ingenic/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-ingenic/cpu-feature-overrides.h
@@ -11,7 +11,6 @@
 #define cpu_has_4kex		1
 #define cpu_has_3k_cache	0
 #define cpu_has_4k_cache	1
-#define cpu_has_tx39_cache	0
 #define cpu_has_counter		0
 #define cpu_has_watch		1
 #define cpu_has_divec		1
diff --git a/arch/mips/include/asm/mach-ip27/cpu-feature-overrides.h b/arch/mips/include/asm/mach-ip27/cpu-feature-overrides.h
index 58f829c9b6c7..c8385c4e8664 100644
--- a/arch/mips/include/asm/mach-ip27/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-ip27/cpu-feature-overrides.h
@@ -25,7 +25,6 @@
 #define cpu_has_4kex			1
 #define cpu_has_3k_cache		0
 #define cpu_has_4k_cache		1
-#define cpu_has_tx39_cache		0
 #define cpu_has_fpu			1
 #define cpu_has_nofpuex			0
 #define cpu_has_32fpr			1
diff --git a/arch/mips/include/asm/mach-ip30/cpu-feature-overrides.h b/arch/mips/include/asm/mach-ip30/cpu-feature-overrides.h
index 49a93e82c252..8ad0c424a9af 100644
--- a/arch/mips/include/asm/mach-ip30/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-ip30/cpu-feature-overrides.h
@@ -28,7 +28,6 @@
 #define cpu_has_4kex			1
 #define cpu_has_3k_cache		0
 #define cpu_has_4k_cache		1
-#define cpu_has_tx39_cache		0
 #define cpu_has_fpu			1
 #define cpu_has_nofpuex			0
 #define cpu_has_32fpr			1
diff --git a/arch/mips/include/asm/mach-lantiq/falcon/cpu-feature-overrides.h b/arch/mips/include/asm/mach-lantiq/falcon/cpu-feature-overrides.h
index 10226976f7b7..22607e61e57b 100644
--- a/arch/mips/include/asm/mach-lantiq/falcon/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-lantiq/falcon/cpu-feature-overrides.h
@@ -15,7 +15,6 @@
 #define cpu_has_4kex		1
 #define cpu_has_3k_cache	0
 #define cpu_has_4k_cache	1
-#define cpu_has_tx39_cache	0
 #define cpu_has_sb1_cache	0
 #define cpu_has_fpu		0
 #define cpu_has_32fpr		0
diff --git a/arch/mips/include/asm/mach-loongson2ef/cpu-feature-overrides.h b/arch/mips/include/asm/mach-loongson2ef/cpu-feature-overrides.h
index b2ee859ca0b7..eb0d1cfb9f3b 100644
--- a/arch/mips/include/asm/mach-loongson2ef/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-loongson2ef/cpu-feature-overrides.h
@@ -34,7 +34,6 @@
 #define cpu_has_mipsmt		0
 #define cpu_has_smartmips	0
 #define cpu_has_tlb		1
-#define cpu_has_tx39_cache	0
 #define cpu_has_vce		0
 #define cpu_has_veic		0
 #define cpu_has_vint		0
diff --git a/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h b/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h
index eb181224eb4c..ebace9e4bdc1 100644
--- a/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h
@@ -36,7 +36,6 @@
 #define cpu_has_mipsmt		0
 #define cpu_has_smartmips	0
 #define cpu_has_tlb		1
-#define cpu_has_tx39_cache	0
 #define cpu_has_vce		0
 #define cpu_has_veic		0
 #define cpu_has_vint		0
diff --git a/arch/mips/include/asm/mach-ralink/mt7620/cpu-feature-overrides.h b/arch/mips/include/asm/mach-ralink/mt7620/cpu-feature-overrides.h
index c4579f1705c2..85a62c99a52a 100644
--- a/arch/mips/include/asm/mach-ralink/mt7620/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-ralink/mt7620/cpu-feature-overrides.h
@@ -16,7 +16,6 @@
 #define cpu_has_4kex		1
 #define cpu_has_3k_cache	0
 #define cpu_has_4k_cache	1
-#define cpu_has_tx39_cache	0
 #define cpu_has_sb1_cache	0
 #define cpu_has_fpu		0
 #define cpu_has_32fpr		0
diff --git a/arch/mips/include/asm/mach-ralink/mt7621/cpu-feature-overrides.h b/arch/mips/include/asm/mach-ralink/mt7621/cpu-feature-overrides.h
index 168359a0a58d..3c19a94f5432 100644
--- a/arch/mips/include/asm/mach-ralink/mt7621/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-ralink/mt7621/cpu-feature-overrides.h
@@ -17,7 +17,6 @@
 #define cpu_has_4kex		1
 #define cpu_has_3k_cache	0
 #define cpu_has_4k_cache	1
-#define cpu_has_tx39_cache	0
 #define cpu_has_sb1_cache	0
 #define cpu_has_fpu		0
 #define cpu_has_32fpr		0
diff --git a/arch/mips/include/asm/mach-ralink/rt288x/cpu-feature-overrides.h b/arch/mips/include/asm/mach-ralink/rt288x/cpu-feature-overrides.h
index fdaf8c9182bc..a850c1e46134 100644
--- a/arch/mips/include/asm/mach-ralink/rt288x/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-ralink/rt288x/cpu-feature-overrides.h
@@ -16,7 +16,6 @@
 #define cpu_has_4kex		1
 #define cpu_has_3k_cache	0
 #define cpu_has_4k_cache	1
-#define cpu_has_tx39_cache	0
 #define cpu_has_sb1_cache	0
 #define cpu_has_fpu		0
 #define cpu_has_32fpr		0
diff --git a/arch/mips/include/asm/mach-ralink/rt305x/cpu-feature-overrides.h b/arch/mips/include/asm/mach-ralink/rt305x/cpu-feature-overrides.h
index 7a385fe784a6..2d75264a9166 100644
--- a/arch/mips/include/asm/mach-ralink/rt305x/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-ralink/rt305x/cpu-feature-overrides.h
@@ -16,7 +16,6 @@
 #define cpu_has_4kex		1
 #define cpu_has_3k_cache	0
 #define cpu_has_4k_cache	1
-#define cpu_has_tx39_cache	0
 #define cpu_has_sb1_cache	0
 #define cpu_has_fpu		0
 #define cpu_has_32fpr		0
diff --git a/arch/mips/include/asm/mach-ralink/rt3883/cpu-feature-overrides.h b/arch/mips/include/asm/mach-ralink/rt3883/cpu-feature-overrides.h
index 0a61910f6521..accf2a325343 100644
--- a/arch/mips/include/asm/mach-ralink/rt3883/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-ralink/rt3883/cpu-feature-overrides.h
@@ -15,7 +15,6 @@
 #define cpu_has_4kex		1
 #define cpu_has_3k_cache	0
 #define cpu_has_4k_cache	1
-#define cpu_has_tx39_cache	0
 #define cpu_has_sb1_cache	0
 #define cpu_has_fpu		0
 #define cpu_has_32fpr		0
diff --git a/arch/mips/include/asm/mach-rc32434/cpu-feature-overrides.h b/arch/mips/include/asm/mach-rc32434/cpu-feature-overrides.h
index 8539ccfb69b7..36d45c9cf09c 100644
--- a/arch/mips/include/asm/mach-rc32434/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-rc32434/cpu-feature-overrides.h
@@ -18,7 +18,6 @@
 #define cpu_has_4kex			1
 #define cpu_has_3k_cache		0
 #define cpu_has_4k_cache		1
-#define cpu_has_tx39_cache		0
 #define cpu_has_sb1_cache		0
 #define cpu_has_fpu			0
 #define cpu_has_32fpr			0
diff --git a/arch/mips/include/asm/mach-tx39xx/ioremap.h b/arch/mips/include/asm/mach-tx39xx/ioremap.h
deleted file mode 100644
index 157a7292397e..000000000000
--- a/arch/mips/include/asm/mach-tx39xx/ioremap.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- *	include/asm-mips/mach-tx39xx/ioremap.h
- */
-#ifndef __ASM_MACH_TX39XX_IOREMAP_H
-#define __ASM_MACH_TX39XX_IOREMAP_H
-
-#include <linux/types.h>
-
-static inline void __iomem *plat_ioremap(phys_addr_t offset, unsigned long size,
-	unsigned long flags)
-{
-#define TXX9_DIRECTMAP_BASE	0xff000000ul
-	if (offset >= TXX9_DIRECTMAP_BASE &&
-	    offset < TXX9_DIRECTMAP_BASE + 0xff0000)
-		return (void __iomem *)offset;
-	return NULL;
-}
-
-static inline int plat_iounmap(const volatile void __iomem *addr)
-{
-	return (unsigned long)addr >= TXX9_DIRECTMAP_BASE;
-}
-
-#endif /* __ASM_MACH_TX39XX_IOREMAP_H */
diff --git a/arch/mips/include/asm/mach-tx39xx/mangle-port.h b/arch/mips/include/asm/mach-tx39xx/mangle-port.h
deleted file mode 100644
index 95be459950f7..000000000000
--- a/arch/mips/include/asm/mach-tx39xx/mangle-port.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __ASM_MACH_TX39XX_MANGLE_PORT_H
-#define __ASM_MACH_TX39XX_MANGLE_PORT_H
-
-#if defined(CONFIG_TOSHIBA_JMR3927)
-extern unsigned long (*__swizzle_addr_b)(unsigned long port);
-#define NEEDS_TXX9_SWIZZLE_ADDR_B
-#else
-#define __swizzle_addr_b(port)	(port)
-#endif
-#define __swizzle_addr_w(port)	(port)
-#define __swizzle_addr_l(port)	(port)
-#define __swizzle_addr_q(port)	(port)
-
-#define ioswabb(a, x)		(x)
-#define __mem_ioswabb(a, x)	(x)
-#define ioswabw(a, x)		le16_to_cpu((__force __le16)(x))
-#define __mem_ioswabw(a, x)	(x)
-#define ioswabl(a, x)		le32_to_cpu((__force __le32)(x))
-#define __mem_ioswabl(a, x)	(x)
-#define ioswabq(a, x)		le64_to_cpu((__force __le64)(x))
-#define __mem_ioswabq(a, x)	(x)
-
-#endif /* __ASM_MACH_TX39XX_MANGLE_PORT_H */
diff --git a/arch/mips/include/asm/mach-tx39xx/spaces.h b/arch/mips/include/asm/mach-tx39xx/spaces.h
deleted file mode 100644
index 151fe7a1cf1d..000000000000
--- a/arch/mips/include/asm/mach-tx39xx/spaces.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 1994 - 1999, 2000, 03, 04 Ralf Baechle
- * Copyright (C) 2000, 2002  Maciej W. Rozycki
- * Copyright (C) 1990, 1999, 2000 Silicon Graphics, Inc.
- */
-#ifndef _ASM_TX39XX_SPACES_H
-#define _ASM_TX39XX_SPACES_H
-
-#define FIXADDR_TOP		((unsigned long)(long)(int)0xfefe0000)
-
-#include <asm/mach-generic/spaces.h>
-
-#endif /* __ASM_TX39XX_SPACES_H */
diff --git a/arch/mips/include/asm/stackframe.h b/arch/mips/include/asm/stackframe.h
index aa430a6c68b2..a8705aef47e1 100644
--- a/arch/mips/include/asm/stackframe.h
+++ b/arch/mips/include/asm/stackframe.h
@@ -42,7 +42,7 @@
 	cfi_restore \reg \offset \docfi
 	.endm
 
-#if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX)
+#if defined(CONFIG_CPU_R3000)
 #define STATMASK 0x3f
 #else
 #define STATMASK 0x1f
@@ -349,7 +349,7 @@
 		cfi_ld	sp, PT_R29, \docfi
 		.endm
 
-#if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX)
+#if defined(CONFIG_CPU_R3000)
 
 		.macro	RESTORE_SOME docfi=0
 		.set	push
@@ -478,7 +478,7 @@
 		.macro	KMODE
 		mfc0	t0, CP0_STATUS
 		li	t1, ST0_KERNEL_CUMASK | (STATMASK & ~1)
-#if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX)
+#if defined(CONFIG_CPU_R3000)
 		andi	t2, t0, ST0_IEP
 		srl	t2, 2
 		or	t0, t2
diff --git a/arch/mips/include/asm/txx9/boards.h b/arch/mips/include/asm/txx9/boards.h
index 70284e90dc53..6897ca4366d5 100644
--- a/arch/mips/include/asm/txx9/boards.h
+++ b/arch/mips/include/asm/txx9/boards.h
@@ -1,7 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifdef CONFIG_TOSHIBA_JMR3927
-BOARD_VEC(jmr3927_vec)
-#endif
 #ifdef CONFIG_TOSHIBA_RBTX4927
 BOARD_VEC(rbtx4927_vec)
 BOARD_VEC(rbtx4937_vec)
diff --git a/arch/mips/include/asm/txx9/jmr3927.h b/arch/mips/include/asm/txx9/jmr3927.h
deleted file mode 100644
index aab959dc30ba..000000000000
--- a/arch/mips/include/asm/txx9/jmr3927.h
+++ /dev/null
@@ -1,179 +0,0 @@
-/*
- * Defines for the TJSYS JMR-TX3927
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2000-2001 Toshiba Corporation
- */
-#ifndef __ASM_TXX9_JMR3927_H
-#define __ASM_TXX9_JMR3927_H
-
-#include <asm/txx9/tx3927.h>
-#include <asm/addrspace.h>
-#include <asm/txx9irq.h>
-
-/* CS */
-#define JMR3927_ROMCE0	0x1fc00000	/* 4M */
-#define JMR3927_ROMCE1	0x1e000000	/* 4M */
-#define JMR3927_ROMCE2	0x14000000	/* 16M */
-#define JMR3927_ROMCE3	0x10000000	/* 64M */
-#define JMR3927_ROMCE5	0x1d000000	/* 4M */
-#define JMR3927_SDCS0	0x00000000	/* 32M */
-#define JMR3927_SDCS1	0x02000000	/* 32M */
-/* PCI Direct Mappings */
-
-#define JMR3927_PCIMEM	0x08000000
-#define JMR3927_PCIMEM_SIZE	0x08000000	/* 128M */
-#define JMR3927_PCIIO	0x15000000
-#define JMR3927_PCIIO_SIZE	0x01000000	/* 16M */
-
-#define JMR3927_SDRAM_SIZE	0x02000000	/* 32M */
-#define JMR3927_PORT_BASE	KSEG1
-
-/* Address map (virtual address) */
-#define JMR3927_ROM0_BASE	(KSEG1 + JMR3927_ROMCE0)
-#define JMR3927_ROM1_BASE	(KSEG1 + JMR3927_ROMCE1)
-#define JMR3927_IOC_BASE	(KSEG1 + JMR3927_ROMCE2)
-#define JMR3927_PCIMEM_BASE	(KSEG1 + JMR3927_PCIMEM)
-#define JMR3927_PCIIO_BASE	(KSEG1 + JMR3927_PCIIO)
-
-#define JMR3927_IOC_REV_ADDR	(JMR3927_IOC_BASE + 0x00000000)
-#define JMR3927_IOC_NVRAMB_ADDR (JMR3927_IOC_BASE + 0x00010000)
-#define JMR3927_IOC_LED_ADDR	(JMR3927_IOC_BASE + 0x00020000)
-#define JMR3927_IOC_DIPSW_ADDR	(JMR3927_IOC_BASE + 0x00030000)
-#define JMR3927_IOC_BREV_ADDR	(JMR3927_IOC_BASE + 0x00040000)
-#define JMR3927_IOC_DTR_ADDR	(JMR3927_IOC_BASE + 0x00050000)
-#define JMR3927_IOC_INTS1_ADDR	(JMR3927_IOC_BASE + 0x00080000)
-#define JMR3927_IOC_INTS2_ADDR	(JMR3927_IOC_BASE + 0x00090000)
-#define JMR3927_IOC_INTM_ADDR	(JMR3927_IOC_BASE + 0x000a0000)
-#define JMR3927_IOC_INTP_ADDR	(JMR3927_IOC_BASE + 0x000b0000)
-#define JMR3927_IOC_RESET_ADDR	(JMR3927_IOC_BASE + 0x000f0000)
-
-/* Flash ROM */
-#define JMR3927_FLASH_BASE	(JMR3927_ROM0_BASE)
-#define JMR3927_FLASH_SIZE	0x00400000
-
-/* bits for IOC_REV/IOC_BREV (high byte) */
-#define JMR3927_IDT_MASK	0xfc
-#define JMR3927_REV_MASK	0x03
-#define JMR3927_IOC_IDT		0xe0
-
-/* bits for IOC_INTS1/IOC_INTS2/IOC_INTM/IOC_INTP (high byte) */
-#define JMR3927_IOC_INTB_PCIA	0
-#define JMR3927_IOC_INTB_PCIB	1
-#define JMR3927_IOC_INTB_PCIC	2
-#define JMR3927_IOC_INTB_PCID	3
-#define JMR3927_IOC_INTB_MODEM	4
-#define JMR3927_IOC_INTB_INT6	5
-#define JMR3927_IOC_INTB_INT7	6
-#define JMR3927_IOC_INTB_SOFT	7
-#define JMR3927_IOC_INTF_PCIA	(1 << JMR3927_IOC_INTF_PCIA)
-#define JMR3927_IOC_INTF_PCIB	(1 << JMR3927_IOC_INTB_PCIB)
-#define JMR3927_IOC_INTF_PCIC	(1 << JMR3927_IOC_INTB_PCIC)
-#define JMR3927_IOC_INTF_PCID	(1 << JMR3927_IOC_INTB_PCID)
-#define JMR3927_IOC_INTF_MODEM	(1 << JMR3927_IOC_INTB_MODEM)
-#define JMR3927_IOC_INTF_INT6	(1 << JMR3927_IOC_INTB_INT6)
-#define JMR3927_IOC_INTF_INT7	(1 << JMR3927_IOC_INTB_INT7)
-#define JMR3927_IOC_INTF_SOFT	(1 << JMR3927_IOC_INTB_SOFT)
-
-/* bits for IOC_RESET (high byte) */
-#define JMR3927_IOC_RESET_CPU	1
-#define JMR3927_IOC_RESET_PCI	2
-
-#if defined(__BIG_ENDIAN)
-#define jmr3927_ioc_reg_out(d, a)	((*(volatile unsigned char *)(a)) = (d))
-#define jmr3927_ioc_reg_in(a)		(*(volatile unsigned char *)(a))
-#elif defined(__LITTLE_ENDIAN)
-#define jmr3927_ioc_reg_out(d, a)	((*(volatile unsigned char *)((a)^1)) = (d))
-#define jmr3927_ioc_reg_in(a)		(*(volatile unsigned char *)((a)^1))
-#else
-#error "No Endian"
-#endif
-
-/* LED macro */
-#define jmr3927_led_set(n/*0-16*/)	jmr3927_ioc_reg_out(~(n), JMR3927_IOC_LED_ADDR)
-
-#define jmr3927_led_and_set(n/*0-16*/)	jmr3927_ioc_reg_out((~(n)) & jmr3927_ioc_reg_in(JMR3927_IOC_LED_ADDR), JMR3927_IOC_LED_ADDR)
-
-/* DIPSW4 macro */
-#define jmr3927_dipsw1()	(gpio_get_value(11) == 0)
-#define jmr3927_dipsw2()	(gpio_get_value(10) == 0)
-#define jmr3927_dipsw3()	((jmr3927_ioc_reg_in(JMR3927_IOC_DIPSW_ADDR) & 2) == 0)
-#define jmr3927_dipsw4()	((jmr3927_ioc_reg_in(JMR3927_IOC_DIPSW_ADDR) & 1) == 0)
-
-/*
- * IRQ mappings
- */
-
-/* These are the virtual IRQ numbers, we divide all IRQ's into
- * 'spaces', the 'space' determines where and how to enable/disable
- * that particular IRQ on an JMR machine.  Add new 'spaces' as new
- * IRQ hardware is supported.
- */
-#define JMR3927_NR_IRQ_IRC	16	/* On-Chip IRC */
-#define JMR3927_NR_IRQ_IOC	8	/* PCI/MODEM/INT[6:7] */
-
-#define JMR3927_IRQ_IRC TXX9_IRQ_BASE
-#define JMR3927_IRQ_IOC (JMR3927_IRQ_IRC + JMR3927_NR_IRQ_IRC)
-#define JMR3927_IRQ_END (JMR3927_IRQ_IOC + JMR3927_NR_IRQ_IOC)
-
-#define JMR3927_IRQ_IRC_INT0	(JMR3927_IRQ_IRC + TX3927_IR_INT0)
-#define JMR3927_IRQ_IRC_INT1	(JMR3927_IRQ_IRC + TX3927_IR_INT1)
-#define JMR3927_IRQ_IRC_INT2	(JMR3927_IRQ_IRC + TX3927_IR_INT2)
-#define JMR3927_IRQ_IRC_INT3	(JMR3927_IRQ_IRC + TX3927_IR_INT3)
-#define JMR3927_IRQ_IRC_INT4	(JMR3927_IRQ_IRC + TX3927_IR_INT4)
-#define JMR3927_IRQ_IRC_INT5	(JMR3927_IRQ_IRC + TX3927_IR_INT5)
-#define JMR3927_IRQ_IRC_SIO0	(JMR3927_IRQ_IRC + TX3927_IR_SIO0)
-#define JMR3927_IRQ_IRC_SIO1	(JMR3927_IRQ_IRC + TX3927_IR_SIO1)
-#define JMR3927_IRQ_IRC_SIO(ch) (JMR3927_IRQ_IRC + TX3927_IR_SIO(ch))
-#define JMR3927_IRQ_IRC_DMA	(JMR3927_IRQ_IRC + TX3927_IR_DMA)
-#define JMR3927_IRQ_IRC_PIO	(JMR3927_IRQ_IRC + TX3927_IR_PIO)
-#define JMR3927_IRQ_IRC_PCI	(JMR3927_IRQ_IRC + TX3927_IR_PCI)
-#define JMR3927_IRQ_IRC_TMR(ch) (JMR3927_IRQ_IRC + TX3927_IR_TMR(ch))
-#define JMR3927_IRQ_IOC_PCIA	(JMR3927_IRQ_IOC + JMR3927_IOC_INTB_PCIA)
-#define JMR3927_IRQ_IOC_PCIB	(JMR3927_IRQ_IOC + JMR3927_IOC_INTB_PCIB)
-#define JMR3927_IRQ_IOC_PCIC	(JMR3927_IRQ_IOC + JMR3927_IOC_INTB_PCIC)
-#define JMR3927_IRQ_IOC_PCID	(JMR3927_IRQ_IOC + JMR3927_IOC_INTB_PCID)
-#define JMR3927_IRQ_IOC_MODEM	(JMR3927_IRQ_IOC + JMR3927_IOC_INTB_MODEM)
-#define JMR3927_IRQ_IOC_INT6	(JMR3927_IRQ_IOC + JMR3927_IOC_INTB_INT6)
-#define JMR3927_IRQ_IOC_INT7	(JMR3927_IRQ_IOC + JMR3927_IOC_INTB_INT7)
-#define JMR3927_IRQ_IOC_SOFT	(JMR3927_IRQ_IOC + JMR3927_IOC_INTB_SOFT)
-
-/* IOC (PCI, MODEM) */
-#define JMR3927_IRQ_IOCINT	JMR3927_IRQ_IRC_INT1
-/* TC35815 100M Ether (JMR-TX3912:JPW4:2-3 Short) */
-#define JMR3927_IRQ_ETHER0	JMR3927_IRQ_IRC_INT3
-
-/* Clocks */
-#define JMR3927_CORECLK 132710400	/* 132.7MHz */
-
-/*
- * TX3927 Pin Configuration:
- *
- *	PCFG bits		Avail			Dead
- *	SELSIO[1:0]:11		RXD[1:0], TXD[1:0]	PIO[6:3]
- *	SELSIOC[0]:1		CTS[0], RTS[0]		INT[5:4]
- *	SELSIOC[1]:0,SELDSF:0,	GSDAO[0],GPCST[3]	CTS[1], RTS[1],DSF,
- *	  GDBGE*					  PIO[2:1]
- *	SELDMA[2]:1		DMAREQ[2],DMAACK[2]	PIO[13:12]
- *	SELTMR[2:0]:000					TIMER[1:0]
- *	SELCS:0,SELDMA[1]:0	PIO[11;10]		SDCS_CE[7:6],
- *							  DMAREQ[1],DMAACK[1]
- *	SELDMA[0]:1		DMAREQ[0],DMAACK[0]	PIO[9:8]
- *	SELDMA[3]:1		DMAREQ[3],DMAACK[3]	PIO[15:14]
- *	SELDONE:1		DMADONE			PIO[7]
- *
- * Usable pins are:
- *	RXD[1;0],TXD[1:0],CTS[0],RTS[0],
- *	DMAREQ[0,2,3],DMAACK[0,2,3],DMADONE,PIO[0,10,11]
- *	INT[3:0]
- */
-
-void jmr3927_prom_init(void);
-void jmr3927_irq_setup(void);
-struct pci_dev;
-int jmr3927_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin);
-
-#endif /* __ASM_TXX9_JMR3927_H */
diff --git a/arch/mips/include/asm/txx9/tx3927.h b/arch/mips/include/asm/txx9/tx3927.h
deleted file mode 100644
index 149fab4f8327..000000000000
--- a/arch/mips/include/asm/txx9/tx3927.h
+++ /dev/null
@@ -1,341 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2000 Toshiba Corporation
- */
-#ifndef __ASM_TXX9_TX3927_H
-#define __ASM_TXX9_TX3927_H
-
-#define TX3927_REG_BASE 0xfffe0000UL
-#define TX3927_REG_SIZE 0x00010000
-#define TX3927_SDRAMC_REG	(TX3927_REG_BASE + 0x8000)
-#define TX3927_ROMC_REG		(TX3927_REG_BASE + 0x9000)
-#define TX3927_DMA_REG		(TX3927_REG_BASE + 0xb000)
-#define TX3927_IRC_REG		(TX3927_REG_BASE + 0xc000)
-#define TX3927_PCIC_REG		(TX3927_REG_BASE + 0xd000)
-#define TX3927_CCFG_REG		(TX3927_REG_BASE + 0xe000)
-#define TX3927_NR_TMR	3
-#define TX3927_TMR_REG(ch)	(TX3927_REG_BASE + 0xf000 + (ch) * 0x100)
-#define TX3927_NR_SIO	2
-#define TX3927_SIO_REG(ch)	(TX3927_REG_BASE + 0xf300 + (ch) * 0x100)
-#define TX3927_PIO_REG		(TX3927_REG_BASE + 0xf500)
-
-struct tx3927_sdramc_reg {
-	volatile unsigned long cr[8];
-	volatile unsigned long tr[3];
-	volatile unsigned long cmd;
-	volatile unsigned long smrs[2];
-};
-
-struct tx3927_romc_reg {
-	volatile unsigned long cr[8];
-};
-
-struct tx3927_dma_reg {
-	struct tx3927_dma_ch_reg {
-		volatile unsigned long cha;
-		volatile unsigned long sar;
-		volatile unsigned long dar;
-		volatile unsigned long cntr;
-		volatile unsigned long sair;
-		volatile unsigned long dair;
-		volatile unsigned long ccr;
-		volatile unsigned long csr;
-	} ch[4];
-	volatile unsigned long dbr[8];
-	volatile unsigned long tdhr;
-	volatile unsigned long mcr;
-	volatile unsigned long unused0;
-};
-
-#include <asm/byteorder.h>
-
-#ifdef __BIG_ENDIAN
-#define endian_def_s2(e1, e2)	\
-	volatile unsigned short e1, e2
-#define endian_def_sb2(e1, e2, e3)	\
-	volatile unsigned short e1;volatile unsigned char e2, e3
-#define endian_def_b2s(e1, e2, e3)	\
-	volatile unsigned char e1, e2;volatile unsigned short e3
-#define endian_def_b4(e1, e2, e3, e4)	\
-	volatile unsigned char e1, e2, e3, e4
-#else
-#define endian_def_s2(e1, e2)	\
-	volatile unsigned short e2, e1
-#define endian_def_sb2(e1, e2, e3)	\
-	volatile unsigned char e3, e2;volatile unsigned short e1
-#define endian_def_b2s(e1, e2, e3)	\
-	volatile unsigned short e3;volatile unsigned char e2, e1
-#define endian_def_b4(e1, e2, e3, e4)	\
-	volatile unsigned char e4, e3, e2, e1
-#endif
-
-struct tx3927_pcic_reg {
-	endian_def_s2(did, vid);
-	endian_def_s2(pcistat, pcicmd);
-	endian_def_b4(cc, scc, rpli, rid);
-	endian_def_b4(unused0, ht, mlt, cls);
-	volatile unsigned long ioba;		/* +10 */
-	volatile unsigned long mba;
-	volatile unsigned long unused1[5];
-	endian_def_s2(svid, ssvid);
-	volatile unsigned long unused2;		/* +30 */
-	endian_def_sb2(unused3, unused4, capptr);
-	volatile unsigned long unused5;
-	endian_def_b4(ml, mg, ip, il);
-	volatile unsigned long unused6;		/* +40 */
-	volatile unsigned long istat;
-	volatile unsigned long iim;
-	volatile unsigned long rrt;
-	volatile unsigned long unused7[3];		/* +50 */
-	volatile unsigned long ipbmma;
-	volatile unsigned long ipbioma;		/* +60 */
-	volatile unsigned long ilbmma;
-	volatile unsigned long ilbioma;
-	volatile unsigned long unused8[9];
-	volatile unsigned long tc;		/* +90 */
-	volatile unsigned long tstat;
-	volatile unsigned long tim;
-	volatile unsigned long tccmd;
-	volatile unsigned long pcirrt;		/* +a0 */
-	volatile unsigned long pcirrt_cmd;
-	volatile unsigned long pcirrdt;
-	volatile unsigned long unused9[3];
-	volatile unsigned long tlboap;
-	volatile unsigned long tlbiap;
-	volatile unsigned long tlbmma;		/* +c0 */
-	volatile unsigned long tlbioma;
-	volatile unsigned long sc_msg;
-	volatile unsigned long sc_be;
-	volatile unsigned long tbl;		/* +d0 */
-	volatile unsigned long unused10[3];
-	volatile unsigned long pwmng;		/* +e0 */
-	volatile unsigned long pwmngs;
-	volatile unsigned long unused11[6];
-	volatile unsigned long req_trace;		/* +100 */
-	volatile unsigned long pbapmc;
-	volatile unsigned long pbapms;
-	volatile unsigned long pbapmim;
-	volatile unsigned long bm;		/* +110 */
-	volatile unsigned long cpcibrs;
-	volatile unsigned long cpcibgs;
-	volatile unsigned long pbacs;
-	volatile unsigned long iobas;		/* +120 */
-	volatile unsigned long mbas;
-	volatile unsigned long lbc;
-	volatile unsigned long lbstat;
-	volatile unsigned long lbim;		/* +130 */
-	volatile unsigned long pcistatim;
-	volatile unsigned long ica;
-	volatile unsigned long icd;
-	volatile unsigned long iiadp;		/* +140 */
-	volatile unsigned long iscdp;
-	volatile unsigned long mmas;
-	volatile unsigned long iomas;
-	volatile unsigned long ipciaddr;		/* +150 */
-	volatile unsigned long ipcidata;
-	volatile unsigned long ipcibe;
-};
-
-struct tx3927_ccfg_reg {
-	volatile unsigned long ccfg;
-	volatile unsigned long crir;
-	volatile unsigned long pcfg;
-	volatile unsigned long tear;
-	volatile unsigned long pdcr;
-};
-
-/*
- * SDRAMC
- */
-
-/*
- * ROMC
- */
-
-/*
- * DMA
- */
-/* bits for MCR */
-#define TX3927_DMA_MCR_EIS(ch)	(0x10000000<<(ch))
-#define TX3927_DMA_MCR_DIS(ch)	(0x01000000<<(ch))
-#define TX3927_DMA_MCR_RSFIF	0x00000080
-#define TX3927_DMA_MCR_FIFUM(ch)	(0x00000008<<(ch))
-#define TX3927_DMA_MCR_LE	0x00000004
-#define TX3927_DMA_MCR_RPRT	0x00000002
-#define TX3927_DMA_MCR_MSTEN	0x00000001
-
-/* bits for CCRn */
-#define TX3927_DMA_CCR_DBINH	0x04000000
-#define TX3927_DMA_CCR_SBINH	0x02000000
-#define TX3927_DMA_CCR_CHRST	0x01000000
-#define TX3927_DMA_CCR_RVBYTE	0x00800000
-#define TX3927_DMA_CCR_ACKPOL	0x00400000
-#define TX3927_DMA_CCR_REQPL	0x00200000
-#define TX3927_DMA_CCR_EGREQ	0x00100000
-#define TX3927_DMA_CCR_CHDN	0x00080000
-#define TX3927_DMA_CCR_DNCTL	0x00060000
-#define TX3927_DMA_CCR_EXTRQ	0x00010000
-#define TX3927_DMA_CCR_INTRQD	0x0000e000
-#define TX3927_DMA_CCR_INTENE	0x00001000
-#define TX3927_DMA_CCR_INTENC	0x00000800
-#define TX3927_DMA_CCR_INTENT	0x00000400
-#define TX3927_DMA_CCR_CHNEN	0x00000200
-#define TX3927_DMA_CCR_XFACT	0x00000100
-#define TX3927_DMA_CCR_SNOP	0x00000080
-#define TX3927_DMA_CCR_DSTINC	0x00000040
-#define TX3927_DMA_CCR_SRCINC	0x00000020
-#define TX3927_DMA_CCR_XFSZ(order)	(((order) << 2) & 0x0000001c)
-#define TX3927_DMA_CCR_XFSZ_1W	TX3927_DMA_CCR_XFSZ(2)
-#define TX3927_DMA_CCR_XFSZ_4W	TX3927_DMA_CCR_XFSZ(4)
-#define TX3927_DMA_CCR_XFSZ_8W	TX3927_DMA_CCR_XFSZ(5)
-#define TX3927_DMA_CCR_XFSZ_16W TX3927_DMA_CCR_XFSZ(6)
-#define TX3927_DMA_CCR_XFSZ_32W TX3927_DMA_CCR_XFSZ(7)
-#define TX3927_DMA_CCR_MEMIO	0x00000002
-#define TX3927_DMA_CCR_ONEAD	0x00000001
-
-/* bits for CSRn */
-#define TX3927_DMA_CSR_CHNACT	0x00000100
-#define TX3927_DMA_CSR_ABCHC	0x00000080
-#define TX3927_DMA_CSR_NCHNC	0x00000040
-#define TX3927_DMA_CSR_NTRNFC	0x00000020
-#define TX3927_DMA_CSR_EXTDN	0x00000010
-#define TX3927_DMA_CSR_CFERR	0x00000008
-#define TX3927_DMA_CSR_CHERR	0x00000004
-#define TX3927_DMA_CSR_DESERR	0x00000002
-#define TX3927_DMA_CSR_SORERR	0x00000001
-
-/*
- * IRC
- */
-#define TX3927_IR_INT0	0
-#define TX3927_IR_INT1	1
-#define TX3927_IR_INT2	2
-#define TX3927_IR_INT3	3
-#define TX3927_IR_INT4	4
-#define TX3927_IR_INT5	5
-#define TX3927_IR_SIO0	6
-#define TX3927_IR_SIO1	7
-#define TX3927_IR_SIO(ch)	(6 + (ch))
-#define TX3927_IR_DMA	8
-#define TX3927_IR_PIO	9
-#define TX3927_IR_PCI	10
-#define TX3927_IR_TMR(ch)	(13 + (ch))
-#define TX3927_NUM_IR	16
-
-/*
- * PCIC
- */
-/* bits for PCICMD */
-/* see PCI_COMMAND_XXX in linux/pci.h */
-
-/* bits for PCISTAT */
-/* see PCI_STATUS_XXX in linux/pci.h */
-#define PCI_STATUS_NEW_CAP	0x0010
-
-/* bits for ISTAT/IIM */
-#define TX3927_PCIC_IIM_ALL	0x00001600
-
-/* bits for TC */
-#define TX3927_PCIC_TC_OF16E	0x00000020
-#define TX3927_PCIC_TC_IF8E	0x00000010
-#define TX3927_PCIC_TC_OF8E	0x00000008
-
-/* bits for TSTAT/TIM */
-#define TX3927_PCIC_TIM_ALL	0x0003ffff
-
-/* bits for IOBA/MBA */
-/* see PCI_BASE_ADDRESS_XXX in linux/pci.h */
-
-/* bits for PBAPMC */
-#define TX3927_PCIC_PBAPMC_RPBA 0x00000004
-#define TX3927_PCIC_PBAPMC_PBAEN	0x00000002
-#define TX3927_PCIC_PBAPMC_BMCEN	0x00000001
-
-/* bits for LBSTAT/LBIM */
-#define TX3927_PCIC_LBIM_ALL	0x0000003e
-
-/* bits for PCISTATIM (see also PCI_STATUS_XXX in linux/pci.h */
-#define TX3927_PCIC_PCISTATIM_ALL	0x0000f900
-
-/* bits for LBC */
-#define TX3927_PCIC_LBC_IBSE	0x00004000
-#define TX3927_PCIC_LBC_TIBSE	0x00002000
-#define TX3927_PCIC_LBC_TMFBSE	0x00001000
-#define TX3927_PCIC_LBC_HRST	0x00000800
-#define TX3927_PCIC_LBC_SRST	0x00000400
-#define TX3927_PCIC_LBC_EPCAD	0x00000200
-#define TX3927_PCIC_LBC_MSDSE	0x00000100
-#define TX3927_PCIC_LBC_CRR	0x00000080
-#define TX3927_PCIC_LBC_ILMDE	0x00000040
-#define TX3927_PCIC_LBC_ILIDE	0x00000020
-
-#define TX3927_PCIC_IDSEL_AD_TO_SLOT(ad)	((ad) - 11)
-#define TX3927_PCIC_MAX_DEVNU	TX3927_PCIC_IDSEL_AD_TO_SLOT(32)
-
-/*
- * CCFG
- */
-/* CCFG : Chip Configuration */
-#define TX3927_CCFG_TLBOFF	0x00020000
-#define TX3927_CCFG_BEOW	0x00010000
-#define TX3927_CCFG_WR	0x00008000
-#define TX3927_CCFG_TOE 0x00004000
-#define TX3927_CCFG_PCIXARB	0x00002000
-#define TX3927_CCFG_PCI3	0x00001000
-#define TX3927_CCFG_PSNP	0x00000800
-#define TX3927_CCFG_PPRI	0x00000400
-#define TX3927_CCFG_PLLM	0x00000030
-#define TX3927_CCFG_ENDIAN	0x00000004
-#define TX3927_CCFG_HALT	0x00000002
-#define TX3927_CCFG_ACEHOLD	0x00000001
-
-/* PCFG : Pin Configuration */
-#define TX3927_PCFG_SYSCLKEN	0x08000000
-#define TX3927_PCFG_SDRCLKEN_ALL	0x07c00000
-#define TX3927_PCFG_SDRCLKEN(ch)	(0x00400000<<(ch))
-#define TX3927_PCFG_PCICLKEN_ALL	0x003c0000
-#define TX3927_PCFG_PCICLKEN(ch)	(0x00040000<<(ch))
-#define TX3927_PCFG_SELALL	0x0003ffff
-#define TX3927_PCFG_SELCS	0x00020000
-#define TX3927_PCFG_SELDSF	0x00010000
-#define TX3927_PCFG_SELSIOC_ALL 0x0000c000
-#define TX3927_PCFG_SELSIOC(ch) (0x00004000<<(ch))
-#define TX3927_PCFG_SELSIO_ALL	0x00003000
-#define TX3927_PCFG_SELSIO(ch)	(0x00001000<<(ch))
-#define TX3927_PCFG_SELTMR_ALL	0x00000e00
-#define TX3927_PCFG_SELTMR(ch)	(0x00000200<<(ch))
-#define TX3927_PCFG_SELDONE	0x00000100
-#define TX3927_PCFG_INTDMA_ALL	0x000000f0
-#define TX3927_PCFG_INTDMA(ch)	(0x00000010<<(ch))
-#define TX3927_PCFG_SELDMA_ALL	0x0000000f
-#define TX3927_PCFG_SELDMA(ch)	(0x00000001<<(ch))
-
-#define tx3927_sdramcptr	((struct tx3927_sdramc_reg *)TX3927_SDRAMC_REG)
-#define tx3927_romcptr		((struct tx3927_romc_reg *)TX3927_ROMC_REG)
-#define tx3927_dmaptr		((struct tx3927_dma_reg *)TX3927_DMA_REG)
-#define tx3927_pcicptr		((struct tx3927_pcic_reg *)TX3927_PCIC_REG)
-#define tx3927_ccfgptr		((struct tx3927_ccfg_reg *)TX3927_CCFG_REG)
-#define tx3927_sioptr(ch)	((struct txx927_sio_reg *)TX3927_SIO_REG(ch))
-#define tx3927_pioptr		((struct txx9_pio_reg __iomem *)TX3927_PIO_REG)
-
-#define TX3927_REV_PCODE()	(tx3927_ccfgptr->crir >> 16)
-#define TX3927_ROMC_BA(ch)	(tx3927_romcptr->cr[(ch)] & 0xfff00000)
-#define TX3927_ROMC_SIZE(ch)	\
-	(0x00100000 << ((tx3927_romcptr->cr[(ch)] >> 8) & 0xf))
-#define TX3927_ROMC_WIDTH(ch)	(32 >> ((tx3927_romcptr->cr[(ch)] >> 7) & 0x1))
-
-void tx3927_wdt_init(void);
-void tx3927_setup(void);
-void tx3927_time_init(unsigned int evt_tmrnr, unsigned int src_tmrnr);
-void tx3927_sio_init(unsigned int sclk, unsigned int cts_mask);
-struct pci_controller;
-void tx3927_pcic_setup(struct pci_controller *channel,
-		       unsigned long sdram_size, int extarb);
-void tx3927_setup_pcierr_irq(void);
-void tx3927_irq_init(void);
-void tx3927_mtd_init(int ch);
-
-#endif /* __ASM_TXX9_TX3927_H */
diff --git a/arch/mips/include/asm/txx9irq.h b/arch/mips/include/asm/txx9irq.h
index 68a6650a4025..3875243bb56b 100644
--- a/arch/mips/include/asm/txx9irq.h
+++ b/arch/mips/include/asm/txx9irq.h
@@ -21,11 +21,7 @@
 #endif
 #endif
 
-#ifdef CONFIG_CPU_TX39XX
-#define TXx9_MAX_IR 16
-#else
 #define TXx9_MAX_IR 32
-#endif
 
 void txx9_irq_init(unsigned long baseaddr);
 int txx9_irq(void);
diff --git a/arch/mips/include/asm/txx9tmr.h b/arch/mips/include/asm/txx9tmr.h
index 466a3def3866..a051b411368e 100644
--- a/arch/mips/include/asm/txx9tmr.h
+++ b/arch/mips/include/asm/txx9tmr.h
@@ -58,10 +58,6 @@ void txx9_clockevent_init(unsigned long baseaddr, int irq,
 			  unsigned int imbusclk);
 void txx9_tmr_init(unsigned long baseaddr);
 
-#ifdef CONFIG_CPU_TX39XX
-#define TXX9_TIMER_BITS 24
-#else
 #define TXX9_TIMER_BITS 32
-#endif
 
 #endif /* __ASM_TXX9TMR_H */
diff --git a/arch/mips/include/asm/vermagic.h b/arch/mips/include/asm/vermagic.h
index 0904de0b5e09..1c33922eb945 100644
--- a/arch/mips/include/asm/vermagic.h
+++ b/arch/mips/include/asm/vermagic.h
@@ -22,8 +22,6 @@
 #define MODULE_PROC_FAMILY "MIPS64_R6 "
 #elif defined CONFIG_CPU_R3000
 #define MODULE_PROC_FAMILY "R3000 "
-#elif defined CONFIG_CPU_TX39XX
-#define MODULE_PROC_FAMILY "TX39XX "
 #elif defined CONFIG_CPU_VR41XX
 #define MODULE_PROC_FAMILY "VR41XX "
 #elif defined CONFIG_CPU_R4300
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 814b3da30501..7c96282bff2e 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -44,7 +44,6 @@ obj-$(CONFIG_FUNCTION_TRACER)	+= mcount.o ftrace.o
 
 sw-y				:= r4k_switch.o
 sw-$(CONFIG_CPU_R3000)		:= r2300_switch.o
-sw-$(CONFIG_CPU_TX39XX)		:= r2300_switch.o
 sw-$(CONFIG_CPU_CAVIUM_OCTEON)	:= octeon_switch.o
 obj-y				+= $(sw-y)
 
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 24a529c6c4be..f0ea92937546 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1189,29 +1189,6 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 		c->tlbsize = 48;
 		break;
 	#endif
-	case PRID_IMP_TX39:
-		c->fpu_msk31 |= FPU_CSR_CONDX | FPU_CSR_FS;
-		c->options = MIPS_CPU_TLB | MIPS_CPU_TX39_CACHE;
-
-		if ((c->processor_id & 0xf0) == (PRID_REV_TX3927 & 0xf0)) {
-			c->cputype = CPU_TX3927;
-			__cpu_name[cpu] = "TX3927";
-			c->tlbsize = 64;
-		} else {
-			switch (c->processor_id & PRID_REV_MASK) {
-			case PRID_REV_TX3912:
-				c->cputype = CPU_TX3912;
-				__cpu_name[cpu] = "TX3912";
-				c->tlbsize = 32;
-				break;
-			case PRID_REV_TX3922:
-				c->cputype = CPU_TX3922;
-				__cpu_name[cpu] = "TX3922";
-				c->tlbsize = 64;
-				break;
-			}
-		}
-		break;
 	case PRID_IMP_R4700:
 		c->cputype = CPU_R4700;
 		__cpu_name[cpu] = "R4700";
diff --git a/arch/mips/kernel/cpu-r3k-probe.c b/arch/mips/kernel/cpu-r3k-probe.c
index af654771918c..be93469c0e0e 100644
--- a/arch/mips/kernel/cpu-r3k-probe.c
+++ b/arch/mips/kernel/cpu-r3k-probe.c
@@ -118,28 +118,6 @@ void cpu_probe(void)
 			c->options |= MIPS_CPU_FPU;
 		c->tlbsize = 64;
 		break;
-	case PRID_COMP_LEGACY | PRID_IMP_TX39:
-		c->options = MIPS_CPU_TLB | MIPS_CPU_TX39_CACHE;
-
-		if ((c->processor_id & 0xf0) == (PRID_REV_TX3927 & 0xf0)) {
-			c->cputype = CPU_TX3927;
-			__cpu_name[cpu] = "TX3927";
-			c->tlbsize = 64;
-		} else {
-			switch (c->processor_id & PRID_REV_MASK) {
-			case PRID_REV_TX3912:
-				c->cputype = CPU_TX3912;
-				__cpu_name[cpu] = "TX3912";
-				c->tlbsize = 32;
-				break;
-			case PRID_REV_TX3922:
-				c->cputype = CPU_TX3922;
-				__cpu_name[cpu] = "TX3922";
-				c->tlbsize = 64;
-				break;
-			}
-		}
-		break;
 	}
 
 	BUG_ON(!__cpu_name[cpu]);
diff --git a/arch/mips/kernel/entry.S b/arch/mips/kernel/entry.S
index d8ca173680f9..891393626dc6 100644
--- a/arch/mips/kernel/entry.S
+++ b/arch/mips/kernel/entry.S
@@ -100,7 +100,7 @@ restore_partial:		# restore partial frame
 	SAVE_AT
 	SAVE_TEMP
 	LONG_L	v0, PT_STATUS(sp)
-#if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX)
+#if defined(CONFIG_CPU_R3000)
 	and	v0, ST0_IEP
 #else
 	and	v0, ST0_IE
diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index fc53ea2cf850..3425df6019c0 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -162,7 +162,7 @@ NESTED(handle_int, PT_SIZE, sp)
 	.set	push
 	.set	noat
 	mfc0	k0, CP0_STATUS
-#if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX)
+#if defined(CONFIG_CPU_R3000)
 	and	k0, ST0_IEP
 	bnez	k0, 1f
 
@@ -644,7 +644,7 @@ isrdhwr:
 	get_saved_sp	/* k1 := current_thread_info */
 	.set	noreorder
 	MFC0	k0, CP0_EPC
-#if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX)
+#if defined(CONFIG_CPU_R3000)
 	ori	k1, _THREAD_MASK
 	xori	k1, _THREAD_MASK
 	LONG_L	v1, TI_TP_VALUE(k1)
diff --git a/arch/mips/kernel/idle.c b/arch/mips/kernel/idle.c
index c81b3a039470..146d9fa77f75 100644
--- a/arch/mips/kernel/idle.c
+++ b/arch/mips/kernel/idle.c
@@ -36,13 +36,6 @@ static void __cpuidle r3081_wait(void)
 	raw_local_irq_enable();
 }
 
-static void __cpuidle r39xx_wait(void)
-{
-	if (!need_resched())
-		write_c0_conf(read_c0_conf() | TX39_CONF_HALT);
-	raw_local_irq_enable();
-}
-
 void __cpuidle r4k_wait(void)
 {
 	raw_local_irq_enable();
@@ -147,9 +140,6 @@ void __init check_wait(void)
 	case CPU_R3081E:
 		cpu_wait = r3081_wait;
 		break;
-	case CPU_TX3927:
-		cpu_wait = r39xx_wait;
-		break;
 	case CPU_R4200:
 /*	case CPU_R4300: */
 	case CPU_R4600:
diff --git a/arch/mips/kernel/irq_txx9.c b/arch/mips/kernel/irq_txx9.c
index ab00e490482f..af3ef4c9f7de 100644
--- a/arch/mips/kernel/irq_txx9.c
+++ b/arch/mips/kernel/irq_txx9.c
@@ -72,11 +72,6 @@ static void txx9_irq_unmask(struct irq_data *d)
 	__raw_writel((__raw_readl(ilrp) & ~(0xff << ofs))
 		     | (txx9irq[irq_nr].level << ofs),
 		     ilrp);
-#ifdef CONFIG_CPU_TX39XX
-	/* update IRCSR */
-	__raw_writel(0, &txx9_ircptr->imr);
-	__raw_writel(irc_elevel, &txx9_ircptr->imr);
-#endif
 }
 
 static inline void txx9_irq_mask(struct irq_data *d)
@@ -88,15 +83,7 @@ static inline void txx9_irq_mask(struct irq_data *d)
 	__raw_writel((__raw_readl(ilrp) & ~(0xff << ofs))
 		     | (irc_dlevel << ofs),
 		     ilrp);
-#ifdef CONFIG_CPU_TX39XX
-	/* update IRCSR */
-	__raw_writel(0, &txx9_ircptr->imr);
-	__raw_writel(irc_elevel, &txx9_ircptr->imr);
-	/* flush write buffer */
-	__raw_readl(&txx9_ircptr->ssr);
-#else
 	mmiowb();
-#endif
 }
 
 static void txx9_irq_mask_ack(struct irq_data *d)
diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
index 9f47a889b047..bb43bf850314 100644
--- a/arch/mips/kernel/proc.c
+++ b/arch/mips/kernel/proc.c
@@ -181,8 +181,6 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 		seq_puts(m, " 3k_cache");
 	if (cpu_has_4k_cache)
 		seq_puts(m, " 4k_cache");
-	if (cpu_has_tx39_cache)
-		seq_puts(m, " tx39_cache");
 	if (cpu_has_octeon_cache)
 		seq_puts(m, " octeon_cache");
 	if (raw_cpu_has_fpu)
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index cbff1b974f88..c2d5f4bfe1f3 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -128,7 +128,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 		p->thread.reg17 = kthread_arg;
 		p->thread.reg29 = childksp;
 		p->thread.reg31 = (unsigned long) ret_from_kernel_thread;
-#if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX)
+#if defined(CONFIG_CPU_R3000)
 		status = (status & ~(ST0_KUP | ST0_IEP | ST0_IEC)) |
 			 ((status & (ST0_KUC | ST0_IEC)) << 2);
 #else
diff --git a/arch/mips/lib/Makefile b/arch/mips/lib/Makefile
index 479f50559c83..5d5b993cbc2b 100644
--- a/arch/mips/lib/Makefile
+++ b/arch/mips/lib/Makefile
@@ -13,7 +13,6 @@ lib-$(CONFIG_GENERIC_CSUM)	:= $(filter-out csum_partial.o, $(lib-y))
 
 obj-$(CONFIG_CPU_GENERIC_DUMP_TLB) += dump_tlb.o
 obj-$(CONFIG_CPU_R3000)		+= r3k_dump_tlb.o
-obj-$(CONFIG_CPU_TX39XX)	+= r3k_dump_tlb.o
 
 # libgcc-style stuff needed in the kernel
 obj-y += bswapsi.o bswapdi.o multi3.o
diff --git a/arch/mips/lib/r3k_dump_tlb.c b/arch/mips/lib/r3k_dump_tlb.c
index 10b4bf7f70a3..fcf594af0002 100644
--- a/arch/mips/lib/r3k_dump_tlb.c
+++ b/arch/mips/lib/r3k_dump_tlb.c
@@ -14,15 +14,11 @@
 #include <asm/page.h>
 #include <asm/tlbdebug.h>
 
-extern int r3k_have_wired_reg;
-
 void dump_tlb_regs(void)
 {
 	pr_info("Index    : %0x\n", read_c0_index());
 	pr_info("EntryHi  : %0lx\n", read_c0_entryhi());
 	pr_info("EntryLo  : %0lx\n", read_c0_entrylo0());
-	if (r3k_have_wired_reg)
-		pr_info("Wired    : %0x\n", read_c0_wired());
 }
 
 static void dump_tlb(int first, int last)
diff --git a/arch/mips/mm/Makefile b/arch/mips/mm/Makefile
index 4acc4f3d31f8..304692391519 100644
--- a/arch/mips/mm/Makefile
+++ b/arch/mips/mm/Makefile
@@ -36,7 +36,6 @@ obj-$(CONFIG_CPU_R3K_TLB)	+= tlb-r3k.o
 obj-$(CONFIG_CPU_R4K_CACHE_TLB) += c-r4k.o cex-gen.o tlb-r4k.o
 obj-$(CONFIG_CPU_R3000)		+= c-r3k.o
 obj-$(CONFIG_CPU_SB1)		+= c-r4k.o cerr-sb1.o cex-sb1.o tlb-r4k.o
-obj-$(CONFIG_CPU_TX39XX)	+= c-tx39.o
 obj-$(CONFIG_CPU_CAVIUM_OCTEON) += c-octeon.o cex-oct.o tlb-r4k.o
 
 obj-$(CONFIG_IP22_CPU_SCACHE)	+= sc-ip22.o
diff --git a/arch/mips/mm/c-tx39.c b/arch/mips/mm/c-tx39.c
deleted file mode 100644
index 03dfbb40ec73..000000000000
--- a/arch/mips/mm/c-tx39.c
+++ /dev/null
@@ -1,414 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * r2300.c: R2000 and R3000 specific mmu/cache code.
- *
- * Copyright (C) 1996 David S. Miller (davem@davemloft.net)
- *
- * with a lot of changes to make this thing work for R3000s
- * Tx39XX R4k style caches added. HK
- * Copyright (C) 1998, 1999, 2000 Harald Koerfgen
- * Copyright (C) 1998 Gleb Raiko & Vladimir Roganov
- */
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/sched.h>
-#include <linux/smp.h>
-#include <linux/mm.h>
-
-#include <asm/cacheops.h>
-#include <asm/page.h>
-#include <asm/mmu_context.h>
-#include <asm/isadep.h>
-#include <asm/io.h>
-#include <asm/bootinfo.h>
-#include <asm/cpu.h>
-
-/* For R3000 cores with R4000 style caches */
-static unsigned long icache_size, dcache_size;		/* Size in bytes */
-
-#include <asm/r4kcache.h>
-
-/* This sequence is required to ensure icache is disabled immediately */
-#define TX39_STOP_STREAMING() \
-__asm__ __volatile__( \
-	".set	 push\n\t" \
-	".set	 noreorder\n\t" \
-	"b	 1f\n\t" \
-	"nop\n\t" \
-	"1:\n\t" \
-	".set pop" \
-	)
-
-/* TX39H-style cache flush routines. */
-static void tx39h_flush_icache_all(void)
-{
-	unsigned long flags, config;
-
-	/* disable icache (set ICE#) */
-	local_irq_save(flags);
-	config = read_c0_conf();
-	write_c0_conf(config & ~TX39_CONF_ICE);
-	TX39_STOP_STREAMING();
-	blast_icache16();
-	write_c0_conf(config);
-	local_irq_restore(flags);
-}
-
-static void tx39h_dma_cache_wback_inv(unsigned long addr, unsigned long size)
-{
-	/* Catch bad driver code */
-	BUG_ON(size == 0);
-
-	iob();
-	blast_inv_dcache_range(addr, addr + size);
-}
-
-
-/* TX39H2,TX39H3 */
-static inline void tx39_blast_dcache_page(unsigned long addr)
-{
-	if (current_cpu_type() != CPU_TX3912)
-		blast_dcache16_page(addr);
-}
-
-static inline void tx39_blast_dcache_page_indexed(unsigned long addr)
-{
-	blast_dcache16_page_indexed(addr);
-}
-
-static inline void tx39_blast_dcache(void)
-{
-	blast_dcache16();
-}
-
-static inline void tx39_blast_icache_page(unsigned long addr)
-{
-	unsigned long flags, config;
-	/* disable icache (set ICE#) */
-	local_irq_save(flags);
-	config = read_c0_conf();
-	write_c0_conf(config & ~TX39_CONF_ICE);
-	TX39_STOP_STREAMING();
-	blast_icache16_page(addr);
-	write_c0_conf(config);
-	local_irq_restore(flags);
-}
-
-static inline void tx39_blast_icache_page_indexed(unsigned long addr)
-{
-	unsigned long flags, config;
-	/* disable icache (set ICE#) */
-	local_irq_save(flags);
-	config = read_c0_conf();
-	write_c0_conf(config & ~TX39_CONF_ICE);
-	TX39_STOP_STREAMING();
-	blast_icache16_page_indexed(addr);
-	write_c0_conf(config);
-	local_irq_restore(flags);
-}
-
-static inline void tx39_blast_icache(void)
-{
-	unsigned long flags, config;
-	/* disable icache (set ICE#) */
-	local_irq_save(flags);
-	config = read_c0_conf();
-	write_c0_conf(config & ~TX39_CONF_ICE);
-	TX39_STOP_STREAMING();
-	blast_icache16();
-	write_c0_conf(config);
-	local_irq_restore(flags);
-}
-
-static void tx39__flush_cache_vmap(void)
-{
-	tx39_blast_dcache();
-}
-
-static void tx39__flush_cache_vunmap(void)
-{
-	tx39_blast_dcache();
-}
-
-static inline void tx39_flush_cache_all(void)
-{
-	if (!cpu_has_dc_aliases)
-		return;
-
-	tx39_blast_dcache();
-}
-
-static inline void tx39___flush_cache_all(void)
-{
-	tx39_blast_dcache();
-	tx39_blast_icache();
-}
-
-static void tx39_flush_cache_mm(struct mm_struct *mm)
-{
-	if (!cpu_has_dc_aliases)
-		return;
-
-	if (cpu_context(smp_processor_id(), mm) != 0)
-		tx39_blast_dcache();
-}
-
-static void tx39_flush_cache_range(struct vm_area_struct *vma,
-	unsigned long start, unsigned long end)
-{
-	if (!cpu_has_dc_aliases)
-		return;
-	if (!(cpu_context(smp_processor_id(), vma->vm_mm)))
-		return;
-
-	tx39_blast_dcache();
-}
-
-static void tx39_flush_cache_page(struct vm_area_struct *vma, unsigned long page, unsigned long pfn)
-{
-	int exec = vma->vm_flags & VM_EXEC;
-	struct mm_struct *mm = vma->vm_mm;
-	pmd_t *pmdp;
-	pte_t *ptep;
-
-	/*
-	 * If ownes no valid ASID yet, cannot possibly have gotten
-	 * this page into the cache.
-	 */
-	if (cpu_context(smp_processor_id(), mm) == 0)
-		return;
-
-	page &= PAGE_MASK;
-	pmdp = pmd_off(mm, page);
-	ptep = pte_offset_kernel(pmdp, page);
-
-	/*
-	 * If the page isn't marked valid, the page cannot possibly be
-	 * in the cache.
-	 */
-	if (!(pte_val(*ptep) & _PAGE_PRESENT))
-		return;
-
-	/*
-	 * Doing flushes for another ASID than the current one is
-	 * too difficult since stupid R4k caches do a TLB translation
-	 * for every cache flush operation.  So we do indexed flushes
-	 * in that case, which doesn't overly flush the cache too much.
-	 */
-	if ((mm == current->active_mm) && (pte_val(*ptep) & _PAGE_VALID)) {
-		if (cpu_has_dc_aliases || exec)
-			tx39_blast_dcache_page(page);
-		if (exec)
-			tx39_blast_icache_page(page);
-
-		return;
-	}
-
-	/*
-	 * Do indexed flush, too much work to get the (possible) TLB refills
-	 * to work correctly.
-	 */
-	if (cpu_has_dc_aliases || exec)
-		tx39_blast_dcache_page_indexed(page);
-	if (exec)
-		tx39_blast_icache_page_indexed(page);
-}
-
-static void local_tx39_flush_data_cache_page(void * addr)
-{
-	tx39_blast_dcache_page((unsigned long)addr);
-}
-
-static void tx39_flush_data_cache_page(unsigned long addr)
-{
-	tx39_blast_dcache_page(addr);
-}
-
-static void tx39_flush_icache_range(unsigned long start, unsigned long end)
-{
-	if (end - start > dcache_size)
-		tx39_blast_dcache();
-	else
-		protected_blast_dcache_range(start, end);
-
-	if (end - start > icache_size)
-		tx39_blast_icache();
-	else {
-		unsigned long flags, config;
-		/* disable icache (set ICE#) */
-		local_irq_save(flags);
-		config = read_c0_conf();
-		write_c0_conf(config & ~TX39_CONF_ICE);
-		TX39_STOP_STREAMING();
-		protected_blast_icache_range(start, end);
-		write_c0_conf(config);
-		local_irq_restore(flags);
-	}
-}
-
-static void tx39_flush_kernel_vmap_range(unsigned long vaddr, int size)
-{
-	BUG();
-}
-
-static void tx39_dma_cache_wback_inv(unsigned long addr, unsigned long size)
-{
-	unsigned long end;
-
-	if (((size | addr) & (PAGE_SIZE - 1)) == 0) {
-		end = addr + size;
-		do {
-			tx39_blast_dcache_page(addr);
-			addr += PAGE_SIZE;
-		} while(addr != end);
-	} else if (size > dcache_size) {
-		tx39_blast_dcache();
-	} else {
-		blast_dcache_range(addr, addr + size);
-	}
-}
-
-static void tx39_dma_cache_inv(unsigned long addr, unsigned long size)
-{
-	unsigned long end;
-
-	if (((size | addr) & (PAGE_SIZE - 1)) == 0) {
-		end = addr + size;
-		do {
-			tx39_blast_dcache_page(addr);
-			addr += PAGE_SIZE;
-		} while(addr != end);
-	} else if (size > dcache_size) {
-		tx39_blast_dcache();
-	} else {
-		blast_inv_dcache_range(addr, addr + size);
-	}
-}
-
-static __init void tx39_probe_cache(void)
-{
-	unsigned long config;
-
-	config = read_c0_conf();
-
-	icache_size = 1 << (10 + ((config & TX39_CONF_ICS_MASK) >>
-				  TX39_CONF_ICS_SHIFT));
-	dcache_size = 1 << (10 + ((config & TX39_CONF_DCS_MASK) >>
-				  TX39_CONF_DCS_SHIFT));
-
-	current_cpu_data.icache.linesz = 16;
-	switch (current_cpu_type()) {
-	case CPU_TX3912:
-		current_cpu_data.icache.ways = 1;
-		current_cpu_data.dcache.ways = 1;
-		current_cpu_data.dcache.linesz = 4;
-		break;
-
-	case CPU_TX3927:
-		current_cpu_data.icache.ways = 2;
-		current_cpu_data.dcache.ways = 2;
-		current_cpu_data.dcache.linesz = 16;
-		break;
-
-	case CPU_TX3922:
-	default:
-		current_cpu_data.icache.ways = 1;
-		current_cpu_data.dcache.ways = 1;
-		current_cpu_data.dcache.linesz = 16;
-		break;
-	}
-}
-
-void tx39_cache_init(void)
-{
-	extern void build_clear_page(void);
-	extern void build_copy_page(void);
-	unsigned long config;
-
-	config = read_c0_conf();
-	config &= ~TX39_CONF_WBON;
-	write_c0_conf(config);
-
-	tx39_probe_cache();
-
-	switch (current_cpu_type()) {
-	case CPU_TX3912:
-		/* TX39/H core (writethru direct-map cache) */
-		__flush_cache_vmap	= tx39__flush_cache_vmap;
-		__flush_cache_vunmap	= tx39__flush_cache_vunmap;
-		flush_cache_all = tx39h_flush_icache_all;
-		__flush_cache_all	= tx39h_flush_icache_all;
-		flush_cache_mm		= (void *) tx39h_flush_icache_all;
-		flush_cache_range	= (void *) tx39h_flush_icache_all;
-		flush_cache_page	= (void *) tx39h_flush_icache_all;
-		flush_icache_range	= (void *) tx39h_flush_icache_all;
-		local_flush_icache_range = (void *) tx39h_flush_icache_all;
-
-		local_flush_data_cache_page	= (void *) tx39h_flush_icache_all;
-		flush_data_cache_page	= (void *) tx39h_flush_icache_all;
-
-		_dma_cache_wback_inv	= tx39h_dma_cache_wback_inv;
-
-		shm_align_mask		= PAGE_SIZE - 1;
-
-		break;
-
-	case CPU_TX3922:
-	case CPU_TX3927:
-	default:
-		/* TX39/H2,H3 core (writeback 2way-set-associative cache) */
-		/* board-dependent init code may set WBON */
-
-		__flush_cache_vmap	= tx39__flush_cache_vmap;
-		__flush_cache_vunmap	= tx39__flush_cache_vunmap;
-
-		flush_cache_all = tx39_flush_cache_all;
-		__flush_cache_all = tx39___flush_cache_all;
-		flush_cache_mm = tx39_flush_cache_mm;
-		flush_cache_range = tx39_flush_cache_range;
-		flush_cache_page = tx39_flush_cache_page;
-		flush_icache_range = tx39_flush_icache_range;
-		local_flush_icache_range = tx39_flush_icache_range;
-
-		__flush_kernel_vmap_range = tx39_flush_kernel_vmap_range;
-
-		local_flush_data_cache_page = local_tx39_flush_data_cache_page;
-		flush_data_cache_page = tx39_flush_data_cache_page;
-
-		_dma_cache_wback_inv = tx39_dma_cache_wback_inv;
-		_dma_cache_wback = tx39_dma_cache_wback_inv;
-		_dma_cache_inv = tx39_dma_cache_inv;
-
-		shm_align_mask = max_t(unsigned long,
-				       (dcache_size / current_cpu_data.dcache.ways) - 1,
-				       PAGE_SIZE - 1);
-
-		break;
-	}
-
-	__flush_icache_user_range = flush_icache_range;
-	__local_flush_icache_user_range = local_flush_icache_range;
-
-	current_cpu_data.icache.waysize = icache_size / current_cpu_data.icache.ways;
-	current_cpu_data.dcache.waysize = dcache_size / current_cpu_data.dcache.ways;
-
-	current_cpu_data.icache.sets =
-		current_cpu_data.icache.waysize / current_cpu_data.icache.linesz;
-	current_cpu_data.dcache.sets =
-		current_cpu_data.dcache.waysize / current_cpu_data.dcache.linesz;
-
-	if (current_cpu_data.dcache.waysize > PAGE_SIZE)
-		current_cpu_data.dcache.flags |= MIPS_CACHE_ALIASES;
-
-	current_cpu_data.icache.waybit = 0;
-	current_cpu_data.dcache.waybit = 0;
-
-	pr_info("Primary instruction cache %ldkB, linesize %d bytes\n",
-		icache_size >> 10, current_cpu_data.icache.linesz);
-	pr_info("Primary data cache %ldkB, linesize %d bytes\n",
-		dcache_size >> 10, current_cpu_data.dcache.linesz);
-
-	build_clear_page();
-	build_copy_page();
-	tx39h_flush_icache_all();
-}
diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index 830ab91e574f..7be7240f7703 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -195,11 +195,6 @@ void cpu_cache_init(void)
 
 		r4k_cache_init();
 	}
-	if (cpu_has_tx39_cache) {
-		extern void __weak tx39_cache_init(void);
-
-		tx39_cache_init();
-	}
 
 	if (cpu_has_octeon_cache) {
 		extern void __weak octeon_cache_init(void);
diff --git a/arch/mips/mm/tlb-r3k.c b/arch/mips/mm/tlb-r3k.c
index a36622ebea55..53dfa2b9316b 100644
--- a/arch/mips/mm/tlb-r3k.c
+++ b/arch/mips/mm/tlb-r3k.c
@@ -36,8 +36,6 @@ extern void build_tlb_refill_handler(void);
 		"nop\n\t"		\
 		".set	pop\n\t")
 
-int r3k_have_wired_reg;			/* Should be in cpu_data? */
-
 /* TLB operations. */
 static void local_flush_tlb_from(int entry)
 {
@@ -62,7 +60,7 @@ void local_flush_tlb_all(void)
 	printk("[tlball]");
 #endif
 	local_irq_save(flags);
-	local_flush_tlb_from(r3k_have_wired_reg ? read_c0_wired() : 8);
+	local_flush_tlb_from(8);
 	local_irq_restore(flags);
 }
 
@@ -224,34 +222,7 @@ void add_wired_entry(unsigned long entrylo0, unsigned long entrylo1,
 	unsigned long old_ctx;
 	static unsigned long wired = 0;
 
-	if (r3k_have_wired_reg) {			/* TX39XX */
-		unsigned long old_pagemask;
-		unsigned long w;
-
-#ifdef DEBUG_TLB
-		printk("[tlbwired<entry lo0 %8x, hi %8x\n, pagemask %8x>]\n",
-		       entrylo0, entryhi, pagemask);
-#endif
-
-		local_irq_save(flags);
-		/* Save old context and create impossible VPN2 value */
-		old_ctx = read_c0_entryhi() & asid_mask;
-		old_pagemask = read_c0_pagemask();
-		w = read_c0_wired();
-		write_c0_wired(w + 1);
-		write_c0_index(w << 8);
-		write_c0_pagemask(pagemask);
-		write_c0_entryhi(entryhi);
-		write_c0_entrylo0(entrylo0);
-		BARRIER;
-		tlb_write_indexed();
-
-		write_c0_entryhi(old_ctx);
-		write_c0_pagemask(old_pagemask);
-		local_flush_tlb_all();
-		local_irq_restore(flags);
-
-	} else if (wired < 8) {
+	if (wired < 8) {
 #ifdef DEBUG_TLB
 		printk("[tlbwired<entry lo0 %8x, hi %8x\n>]\n",
 		       entrylo0, entryhi);
@@ -272,13 +243,6 @@ void add_wired_entry(unsigned long entrylo0, unsigned long entrylo1,
 
 void tlb_init(void)
 {
-	switch (current_cpu_type()) {
-	case CPU_TX3922:
-	case CPU_TX3927:
-		r3k_have_wired_reg = 1;
-		write_c0_wired(0);		/* Set to 8 on reset... */
-		break;
-	}
 	local_flush_tlb_from(0);
 	build_tlb_refill_handler();
 }
diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
index 9a6bc702608c..ed0388485a15 100644
--- a/arch/mips/pci/Makefile
+++ b/arch/mips/pci/Makefile
@@ -13,7 +13,6 @@ obj-$(CONFIG_PCI_DRIVERS_GENERIC)+= pci-generic.o
 obj-$(CONFIG_MIPS_BONITO64)	+= ops-bonito64.o
 obj-$(CONFIG_PCI_GT64XXX_PCI0)	+= ops-gt64xxx_pci0.o
 obj-$(CONFIG_MIPS_MSC)		+= ops-msc.o
-obj-$(CONFIG_SOC_TX3927)	+= ops-tx3927.o
 obj-$(CONFIG_PCI_VR41XX)	+= ops-vr41xx.o pci-vr41xx.o
 obj-$(CONFIG_PCI_TX4927)	+= ops-tx4927.o
 obj-$(CONFIG_BCM47XX)		+= pci-bcm47xx.o
@@ -46,7 +45,6 @@ obj-$(CONFIG_SOC_RT3883)	+= pci-rt3883.o
 obj-$(CONFIG_TANBAC_TB0219)	+= fixup-tb0219.o
 obj-$(CONFIG_TANBAC_TB0226)	+= fixup-tb0226.o
 obj-$(CONFIG_TANBAC_TB0287)	+= fixup-tb0287.o
-obj-$(CONFIG_TOSHIBA_JMR3927)	+= fixup-jmr3927.o
 obj-$(CONFIG_SOC_TX4927)	+= pci-tx4927.o
 obj-$(CONFIG_SOC_TX4938)	+= pci-tx4938.o
 obj-$(CONFIG_TOSHIBA_RBTX4927)	+= fixup-rbtx4927.o
diff --git a/arch/mips/pci/fixup-jmr3927.c b/arch/mips/pci/fixup-jmr3927.c
deleted file mode 100644
index d3102eeea898..000000000000
--- a/arch/mips/pci/fixup-jmr3927.c
+++ /dev/null
@@ -1,79 +0,0 @@
-/*
- *
- * BRIEF MODULE DESCRIPTION
- *	Board specific pci fixups.
- *
- * Copyright 2001 MontaVista Software Inc.
- * Author: MontaVista Software, Inc.
- *         	ppopov@mvista.com or source@mvista.com
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-#include <linux/types.h>
-#include <asm/txx9/pci.h>
-#include <asm/txx9/jmr3927.h>
-
-int jmr3927_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
-{
-	unsigned char irq = pin;
-
-	/* IRQ rotation (PICMG) */
-	irq--;			/* 0-3 */
-	if (slot == TX3927_PCIC_IDSEL_AD_TO_SLOT(23)) {
-		/* PCI CardSlot (IDSEL=A23, DevNu=12) */
-		/* PCIA => PCIC (IDSEL=A23) */
-		/* NOTE: JMR3927 JP1 must be set to OPEN */
-		irq = (irq + 2) % 4;
-	} else if (slot == TX3927_PCIC_IDSEL_AD_TO_SLOT(22)) {
-		/* PCI CardSlot (IDSEL=A22, DevNu=11) */
-		/* PCIA => PCIA (IDSEL=A22) */
-		/* NOTE: JMR3927 JP1 must be set to OPEN */
-		irq = (irq + 0) % 4;
-	} else {
-		/* PCI Backplane */
-		if (txx9_pci_option & TXX9_PCI_OPT_PICMG)
-			irq = (irq + 33 - slot) % 4;
-		else
-			irq = (irq + 3 + slot) % 4;
-	}
-	irq++;			/* 1-4 */
-
-	switch (irq) {
-	case 1:
-		irq = JMR3927_IRQ_IOC_PCIA;
-		break;
-	case 2:
-		irq = JMR3927_IRQ_IOC_PCIB;
-		break;
-	case 3:
-		irq = JMR3927_IRQ_IOC_PCIC;
-		break;
-	case 4:
-		irq = JMR3927_IRQ_IOC_PCID;
-		break;
-	}
-
-	/* Check OnBoard Ethernet (IDSEL=A24, DevNu=13) */
-	if (dev->bus->parent == NULL &&
-	    slot == TX3927_PCIC_IDSEL_AD_TO_SLOT(24))
-		irq = JMR3927_IRQ_ETHER0;
-	return irq;
-}
diff --git a/arch/mips/pci/ops-tx3927.c b/arch/mips/pci/ops-tx3927.c
deleted file mode 100644
index d35dc9c9ab9d..000000000000
--- a/arch/mips/pci/ops-tx3927.c
+++ /dev/null
@@ -1,231 +0,0 @@
-/*
- * Copyright 2001 MontaVista Software Inc.
- * Author: MontaVista Software, Inc.
- *              ahennessy@mvista.com
- *
- * Copyright (C) 2000-2001 Toshiba Corporation
- * Copyright (C) 2004 by Ralf Baechle (ralf@linux-mips.org)
- *
- * Based on arch/mips/ddb5xxx/ddb5477/pci_ops.c
- *
- *     Define the pci_ops for TX3927.
- *
- * Much of the code is derived from the original DDB5074 port by
- * Geert Uytterhoeven <geert@linux-m68k.org>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-#include <linux/types.h>
-#include <linux/pci.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-
-#include <asm/addrspace.h>
-#include <asm/txx9irq.h>
-#include <asm/txx9/pci.h>
-#include <asm/txx9/tx3927.h>
-
-static int mkaddr(struct pci_bus *bus, unsigned char devfn, unsigned char where)
-{
-	if (bus->parent == NULL &&
-	    devfn >= PCI_DEVFN(TX3927_PCIC_MAX_DEVNU, 0))
-		return -1;
-	tx3927_pcicptr->ica =
-		((bus->number & 0xff) << 0x10) |
-		((devfn & 0xff) << 0x08) |
-		(where & 0xfc) | (bus->parent ? 1 : 0);
-
-	/* clear M_ABORT and Disable M_ABORT Int. */
-	tx3927_pcicptr->pcistat |= PCI_STATUS_REC_MASTER_ABORT;
-	tx3927_pcicptr->pcistatim &= ~PCI_STATUS_REC_MASTER_ABORT;
-	return 0;
-}
-
-static inline int check_abort(void)
-{
-	if (tx3927_pcicptr->pcistat & PCI_STATUS_REC_MASTER_ABORT) {
-		tx3927_pcicptr->pcistat |= PCI_STATUS_REC_MASTER_ABORT;
-		tx3927_pcicptr->pcistatim |= PCI_STATUS_REC_MASTER_ABORT;
-		/* flush write buffer */
-		iob();
-		return PCIBIOS_DEVICE_NOT_FOUND;
-	}
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int tx3927_pci_read_config(struct pci_bus *bus, unsigned int devfn,
-	int where, int size, u32 * val)
-{
-	if (mkaddr(bus, devfn, where)) {
-		*val = 0xffffffff;
-		return PCIBIOS_DEVICE_NOT_FOUND;
-	}
-
-	switch (size) {
-	case 1:
-		*val = *(volatile u8 *) ((unsigned long) & tx3927_pcicptr->icd | (where & 3));
-		break;
-
-	case 2:
-		*val = le16_to_cpu(*(volatile u16 *) ((unsigned long) & tx3927_pcicptr->icd | (where & 3)));
-		break;
-
-	case 4:
-		*val = le32_to_cpu(tx3927_pcicptr->icd);
-		break;
-	}
-
-	return check_abort();
-}
-
-static int tx3927_pci_write_config(struct pci_bus *bus, unsigned int devfn,
-	int where, int size, u32 val)
-{
-	if (mkaddr(bus, devfn, where))
-		return PCIBIOS_DEVICE_NOT_FOUND;
-
-	switch (size) {
-	case 1:
-		*(volatile u8 *) ((unsigned long) & tx3927_pcicptr->icd | (where & 3)) = val;
-		break;
-
-	case 2:
-		*(volatile u16 *) ((unsigned long) & tx3927_pcicptr->icd | (where & 2)) =
-	    cpu_to_le16(val);
-		break;
-
-	case 4:
-		tx3927_pcicptr->icd = cpu_to_le32(val);
-	}
-
-	return check_abort();
-}
-
-static struct pci_ops tx3927_pci_ops = {
-	.read = tx3927_pci_read_config,
-	.write = tx3927_pci_write_config,
-};
-
-void __init tx3927_pcic_setup(struct pci_controller *channel,
-			      unsigned long sdram_size, int extarb)
-{
-	unsigned long flags;
-	unsigned long io_base =
-		channel->io_resource->start + mips_io_port_base - IO_BASE;
-	unsigned long io_size =
-		channel->io_resource->end - channel->io_resource->start;
-	unsigned long io_pciaddr =
-		channel->io_resource->start - channel->io_offset;
-	unsigned long mem_base =
-		channel->mem_resource->start;
-	unsigned long mem_size =
-		channel->mem_resource->end - channel->mem_resource->start;
-	unsigned long mem_pciaddr =
-		channel->mem_resource->start - channel->mem_offset;
-
-	printk(KERN_INFO "TX3927 PCIC -- DID:%04x VID:%04x RID:%02x Arbiter:%s",
-	       tx3927_pcicptr->did, tx3927_pcicptr->vid,
-	       tx3927_pcicptr->rid,
-	       extarb ? "External" : "Internal");
-	channel->pci_ops = &tx3927_pci_ops;
-
-	local_irq_save(flags);
-	/* Disable External PCI Config. Access */
-	tx3927_pcicptr->lbc = TX3927_PCIC_LBC_EPCAD;
-#ifdef __BIG_ENDIAN
-	tx3927_pcicptr->lbc |= TX3927_PCIC_LBC_IBSE |
-		TX3927_PCIC_LBC_TIBSE |
-		TX3927_PCIC_LBC_TMFBSE | TX3927_PCIC_LBC_MSDSE;
-#endif
-	/* LB->PCI mappings */
-	tx3927_pcicptr->iomas = ~(io_size - 1);
-	tx3927_pcicptr->ilbioma = io_base;
-	tx3927_pcicptr->ipbioma = io_pciaddr;
-	tx3927_pcicptr->mmas = ~(mem_size - 1);
-	tx3927_pcicptr->ilbmma = mem_base;
-	tx3927_pcicptr->ipbmma = mem_pciaddr;
-	/* PCI->LB mappings */
-	tx3927_pcicptr->iobas = 0xffffffff;
-	tx3927_pcicptr->ioba = 0;
-	tx3927_pcicptr->tlbioma = 0;
-	tx3927_pcicptr->mbas = ~(sdram_size - 1);
-	tx3927_pcicptr->mba = 0;
-	tx3927_pcicptr->tlbmma = 0;
-	/* Enable Direct mapping Address Space Decoder */
-	tx3927_pcicptr->lbc |= TX3927_PCIC_LBC_ILMDE | TX3927_PCIC_LBC_ILIDE;
-
-	/* Clear All Local Bus Status */
-	tx3927_pcicptr->lbstat = TX3927_PCIC_LBIM_ALL;
-	/* Enable All Local Bus Interrupts */
-	tx3927_pcicptr->lbim = TX3927_PCIC_LBIM_ALL;
-	/* Clear All PCI Status Error */
-	tx3927_pcicptr->pcistat = TX3927_PCIC_PCISTATIM_ALL;
-	/* Enable All PCI Status Error Interrupts */
-	tx3927_pcicptr->pcistatim = TX3927_PCIC_PCISTATIM_ALL;
-
-	/* PCIC Int => IRC IRQ10 */
-	tx3927_pcicptr->il = TX3927_IR_PCI;
-	/* Target Control (per errata) */
-	tx3927_pcicptr->tc = TX3927_PCIC_TC_OF8E | TX3927_PCIC_TC_IF8E;
-
-	/* Enable Bus Arbiter */
-	if (!extarb)
-		tx3927_pcicptr->pbapmc = TX3927_PCIC_PBAPMC_PBAEN;
-
-	tx3927_pcicptr->pcicmd = PCI_COMMAND_MASTER |
-		PCI_COMMAND_MEMORY |
-		PCI_COMMAND_IO |
-		PCI_COMMAND_PARITY | PCI_COMMAND_SERR;
-	local_irq_restore(flags);
-}
-
-static irqreturn_t tx3927_pcierr_interrupt(int irq, void *dev_id)
-{
-	struct pt_regs *regs = get_irq_regs();
-
-	if (txx9_pci_err_action != TXX9_PCI_ERR_IGNORE) {
-		printk(KERN_WARNING "PCI error interrupt at 0x%08lx.\n",
-		       regs->cp0_epc);
-		printk(KERN_WARNING "pcistat:%02x, lbstat:%04lx\n",
-		       tx3927_pcicptr->pcistat, tx3927_pcicptr->lbstat);
-	}
-	if (txx9_pci_err_action != TXX9_PCI_ERR_PANIC) {
-		/* clear all pci errors */
-		tx3927_pcicptr->pcistat |= TX3927_PCIC_PCISTATIM_ALL;
-		tx3927_pcicptr->istat = TX3927_PCIC_IIM_ALL;
-		tx3927_pcicptr->tstat = TX3927_PCIC_TIM_ALL;
-		tx3927_pcicptr->lbstat = TX3927_PCIC_LBIM_ALL;
-		return IRQ_HANDLED;
-	}
-	console_verbose();
-	panic("PCI error.");
-}
-
-void __init tx3927_setup_pcierr_irq(void)
-{
-	if (request_irq(TXX9_IRQ_BASE + TX3927_IR_PCI,
-			tx3927_pcierr_interrupt,
-			0, "PCI error",
-			(void *)TX3927_PCIC_REG))
-		printk(KERN_WARNING "Failed to request irq for PCIERR\n");
-}
diff --git a/arch/mips/txx9/Kconfig b/arch/mips/txx9/Kconfig
index 6c61feee6dd3..7335efa4d528 100644
--- a/arch/mips/txx9/Kconfig
+++ b/arch/mips/txx9/Kconfig
@@ -1,9 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-config MACH_TX39XX
-	bool
-	select MACH_TXX9
-	select SYS_HAS_CPU_TX39XX
-
 config MACH_TX49XX
 	bool
 	select BOOT_ELF32
@@ -24,11 +19,6 @@ config MACH_TXX9
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select COMMON_CLK
 
-config TOSHIBA_JMR3927
-	bool "Toshiba JMR-TX3927 board"
-	depends on MACH_TX39XX
-	select SOC_TX3927
-
 config TOSHIBA_RBTX4927
 	bool "Toshiba RBTX49[23]7 board"
 	depends on MACH_TX49XX
@@ -39,14 +29,6 @@ config TOSHIBA_RBTX4927
 	  This Toshiba board is based on the TX4927 processor. Say Y here to
 	  support this machine type
 
-config SOC_TX3927
-	bool
-	select CEVT_TXX9
-	imply HAS_TXX9_SERIAL
-	select HAVE_PCI
-	select IRQ_TXX9
-	select GPIO_TXX9
-
 config SOC_TX4927
 	bool
 	select CEVT_TXX9
diff --git a/arch/mips/txx9/Makefile b/arch/mips/txx9/Makefile
index 53269910a48b..14c91f2678a3 100644
--- a/arch/mips/txx9/Makefile
+++ b/arch/mips/txx9/Makefile
@@ -2,14 +2,8 @@
 #
 # Common TXx9
 #
-obj-$(CONFIG_MACH_TX39XX)      += generic/
 obj-$(CONFIG_MACH_TX49XX)      += generic/
 
-#
-# Toshiba JMR-TX3927 board
-#
-obj-$(CONFIG_TOSHIBA_JMR3927)  += jmr3927/
-
 #
 # Toshiba RBTX49XX boards
 #
diff --git a/arch/mips/txx9/Platform b/arch/mips/txx9/Platform
index 7f4429ba22eb..e5a295068b3e 100644
--- a/arch/mips/txx9/Platform
+++ b/arch/mips/txx9/Platform
@@ -1,7 +1,4 @@
-cflags-$(CONFIG_MACH_TX39XX)	+=					\
-		-I$(srctree)/arch/mips/include/asm/mach-tx39xx
 cflags-$(CONFIG_MACH_TX49XX)	+=					\
 		 -I$(srctree)/arch/mips/include/asm/mach-tx49xx
 
-load-$(CONFIG_MACH_TX39XX)	+= 0xffffffff80050000
 load-$(CONFIG_MACH_TX49XX)	+= 0xffffffff80100000
diff --git a/arch/mips/txx9/generic/Makefile b/arch/mips/txx9/generic/Makefile
index be5af9fe7c11..3c155c7e2be8 100644
--- a/arch/mips/txx9/generic/Makefile
+++ b/arch/mips/txx9/generic/Makefile
@@ -5,7 +5,6 @@
 
 obj-y	+= setup.o
 obj-$(CONFIG_PCI)	+= pci.o
-obj-$(CONFIG_SOC_TX3927)	+= setup_tx3927.o irq_tx3927.o
 obj-$(CONFIG_SOC_TX4927)	+= mem_tx4927.o setup_tx4927.o irq_tx4927.o
 obj-$(CONFIG_SOC_TX4938)	+= mem_tx4927.o setup_tx4938.o irq_tx4938.o
 obj-$(CONFIG_TOSHIBA_FPCIB0)	+= smsc_fdc37m81x.o
diff --git a/arch/mips/txx9/generic/irq_tx3927.c b/arch/mips/txx9/generic/irq_tx3927.c
deleted file mode 100644
index c683f593eda2..000000000000
--- a/arch/mips/txx9/generic/irq_tx3927.c
+++ /dev/null
@@ -1,25 +0,0 @@
-/*
- * Common tx3927 irq handler
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright 2001 MontaVista Software Inc.
- * Copyright (C) 2000-2001 Toshiba Corporation
- */
-#include <linux/init.h>
-#include <asm/txx9irq.h>
-#include <asm/txx9/tx3927.h>
-
-void __init tx3927_irq_init(void)
-{
-	int i;
-
-	txx9_irq_init(TX3927_IRC_REG);
-	/* raise priority for timers, sio */
-	for (i = 0; i < TX3927_NR_TMR; i++)
-		txx9_irq_set_pri(TX3927_IR_TMR(i), 6);
-	for (i = 0; i < TX3927_NR_SIO; i++)
-		txx9_irq_set_pri(TX3927_IR_SIO(i), 7);
-}
diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index 39cd1edf9d80..b098a3c76ae9 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -78,12 +78,7 @@ unsigned int txx9_master_clock;
 unsigned int txx9_cpu_clock;
 unsigned int txx9_gbus_clock;
 
-#ifdef CONFIG_CPU_TX39XX
-/* don't enable by default - see errata */
-int txx9_ccfg_toeon __initdata;
-#else
 int txx9_ccfg_toeon __initdata = 1;
-#endif
 
 #define BOARD_VEC(board)	extern struct txx9_board_vec board;
 #include <asm/txx9/boards.h>
@@ -194,53 +189,6 @@ static void __init txx9_cache_fixup(void)
 	if (conf & TX49_CONF_DC)
 		pr_info("TX49XX D-Cache disabled.\n");
 }
-#elif defined(CONFIG_CPU_TX39XX)
-/* flush all cache on very early stage (before tx39_cache_init) */
-static void __init early_flush_dcache(void)
-{
-	unsigned int conf = read_c0_config();
-	unsigned int dc_size = 1 << (10 + ((conf & TX39_CONF_DCS_MASK) >>
-					   TX39_CONF_DCS_SHIFT));
-	unsigned int linesz = 16;
-	unsigned long addr, end;
-
-	end = INDEX_BASE + dc_size / 2;
-	/* 2way, waybit=0 */
-	for (addr = INDEX_BASE; addr < end; addr += linesz) {
-		cache_op(Index_Writeback_Inv_D, addr | 0);
-		cache_op(Index_Writeback_Inv_D, addr | 1);
-	}
-}
-
-static void __init txx9_cache_fixup(void)
-{
-	unsigned int conf;
-
-	conf = read_c0_config();
-	/* flush and disable */
-	if (txx9_ic_disable) {
-		conf &= ~TX39_CONF_ICE;
-		write_c0_config(conf);
-	}
-	if (txx9_dc_disable) {
-		early_flush_dcache();
-		conf &= ~TX39_CONF_DCE;
-		write_c0_config(conf);
-	}
-
-	/* enable cache */
-	conf = read_c0_config();
-	if (!txx9_ic_disable)
-		conf |= TX39_CONF_ICE;
-	if (!txx9_dc_disable)
-		conf |= TX39_CONF_DCE;
-	write_c0_config(conf);
-
-	if (!(conf & TX39_CONF_ICE))
-		pr_info("TX39XX I-Cache disabled.\n");
-	if (!(conf & TX39_CONF_DCE))
-		pr_info("TX39XX D-Cache disabled.\n");
-}
 #else
 static inline void txx9_cache_fixup(void)
 {
@@ -302,9 +250,6 @@ static void __init select_board(void)
 	}
 
 	/* select "default" board */
-#ifdef CONFIG_TOSHIBA_JMR3927
-	txx9_board_vec = &jmr3927_vec;
-#endif
 #ifdef CONFIG_CPU_TX49XX
 	switch (TX4938_REV_PCODE()) {
 #ifdef CONFIG_TOSHIBA_RBTX4927
diff --git a/arch/mips/txx9/generic/setup_tx3927.c b/arch/mips/txx9/generic/setup_tx3927.c
deleted file mode 100644
index 33f7a7253963..000000000000
--- a/arch/mips/txx9/generic/setup_tx3927.c
+++ /dev/null
@@ -1,136 +0,0 @@
-/*
- * TX3927 setup routines
- * Based on linux/arch/mips/txx9/jmr3927/setup.c
- *
- * Copyright 2001 MontaVista Software Inc.
- * Copyright (C) 2000-2001 Toshiba Corporation
- * Copyright (C) 2007 Ralf Baechle (ralf@linux-mips.org)
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-#include <linux/init.h>
-#include <linux/ioport.h>
-#include <linux/delay.h>
-#include <linux/param.h>
-#include <linux/io.h>
-#include <linux/mtd/physmap.h>
-#include <asm/mipsregs.h>
-#include <asm/txx9irq.h>
-#include <asm/txx9tmr.h>
-#include <asm/txx9pio.h>
-#include <asm/txx9/generic.h>
-#include <asm/txx9/tx3927.h>
-
-void __init tx3927_wdt_init(void)
-{
-	txx9_wdt_init(TX3927_TMR_REG(2));
-}
-
-void __init tx3927_setup(void)
-{
-	int i;
-	unsigned int conf;
-
-	txx9_reg_res_init(TX3927_REV_PCODE(), TX3927_REG_BASE,
-			  TX3927_REG_SIZE);
-
-	/* SDRAMC,ROMC are configured by PROM */
-	for (i = 0; i < 8; i++) {
-		if (!(tx3927_romcptr->cr[i] & 0x8))
-			continue;	/* disabled */
-		txx9_ce_res[i].start = (unsigned long)TX3927_ROMC_BA(i);
-		txx9_ce_res[i].end =
-			txx9_ce_res[i].start + TX3927_ROMC_SIZE(i) - 1;
-		request_resource(&iomem_resource, &txx9_ce_res[i]);
-	}
-
-	/* clocks */
-	txx9_gbus_clock = txx9_cpu_clock / 2;
-	/* change default value to udelay/mdelay take reasonable time */
-	loops_per_jiffy = txx9_cpu_clock / HZ / 2;
-
-	/* CCFG */
-	/* enable Timeout BusError */
-	if (txx9_ccfg_toeon)
-		tx3927_ccfgptr->ccfg |= TX3927_CCFG_TOE;
-
-	/* clear BusErrorOnWrite flag */
-	tx3927_ccfgptr->ccfg &= ~TX3927_CCFG_BEOW;
-	if (read_c0_conf() & TX39_CONF_WBON)
-		/* Disable PCI snoop */
-		tx3927_ccfgptr->ccfg &= ~TX3927_CCFG_PSNP;
-	else
-		/* Enable PCI SNOOP - with write through only */
-		tx3927_ccfgptr->ccfg |= TX3927_CCFG_PSNP;
-	/* do reset on watchdog */
-	tx3927_ccfgptr->ccfg |= TX3927_CCFG_WR;
-
-	pr_info("TX3927 -- CRIR:%08lx CCFG:%08lx PCFG:%08lx\n",
-		tx3927_ccfgptr->crir, tx3927_ccfgptr->ccfg,
-		tx3927_ccfgptr->pcfg);
-
-	/* TMR */
-	for (i = 0; i < TX3927_NR_TMR; i++)
-		txx9_tmr_init(TX3927_TMR_REG(i));
-
-	/* DMA */
-	tx3927_dmaptr->mcr = 0;
-	for (i = 0; i < ARRAY_SIZE(tx3927_dmaptr->ch); i++) {
-		/* reset channel */
-		tx3927_dmaptr->ch[i].ccr = TX3927_DMA_CCR_CHRST;
-		tx3927_dmaptr->ch[i].ccr = 0;
-	}
-	/* enable DMA */
-#ifdef __BIG_ENDIAN
-	tx3927_dmaptr->mcr = TX3927_DMA_MCR_MSTEN;
-#else
-	tx3927_dmaptr->mcr = TX3927_DMA_MCR_MSTEN | TX3927_DMA_MCR_LE;
-#endif
-
-	/* PIO */
-	__raw_writel(0, &tx3927_pioptr->maskcpu);
-	__raw_writel(0, &tx3927_pioptr->maskext);
-
-	conf = read_c0_conf();
-	if (conf & TX39_CONF_DCE) {
-		if (!(conf & TX39_CONF_WBON))
-			pr_info("TX3927 D-Cache WriteThrough.\n");
-		else if (!(conf & TX39_CONF_CWFON))
-			pr_info("TX3927 D-Cache WriteBack.\n");
-		else
-			pr_info("TX3927 D-Cache WriteBack (CWF) .\n");
-	}
-}
-
-void __init tx3927_time_init(unsigned int evt_tmrnr, unsigned int src_tmrnr)
-{
-	txx9_clockevent_init(TX3927_TMR_REG(evt_tmrnr),
-			     TXX9_IRQ_BASE + TX3927_IR_TMR(evt_tmrnr),
-			     TXX9_IMCLK);
-	txx9_clocksource_init(TX3927_TMR_REG(src_tmrnr), TXX9_IMCLK);
-}
-
-void __init tx3927_sio_init(unsigned int sclk, unsigned int cts_mask)
-{
-	int i;
-
-	for (i = 0; i < 2; i++)
-		txx9_sio_init(TX3927_SIO_REG(i),
-			      TXX9_IRQ_BASE + TX3927_IR_SIO(i),
-			      i, sclk, (1 << i) & cts_mask);
-}
-
-void __init tx3927_mtd_init(int ch)
-{
-	struct physmap_flash_data pdata = {
-		.width = TX3927_ROMC_WIDTH(ch) / 8,
-	};
-	unsigned long start = txx9_ce_res[ch].start;
-	unsigned long size = txx9_ce_res[ch].end - start + 1;
-
-	if (!(tx3927_romcptr->cr[ch] & 0x8))
-		return; /* disabled */
-	txx9_physmap_flash_init(ch, start, size, &pdata);
-}
diff --git a/arch/mips/txx9/jmr3927/Makefile b/arch/mips/txx9/jmr3927/Makefile
deleted file mode 100644
index 4bda0615d27e..000000000000
--- a/arch/mips/txx9/jmr3927/Makefile
+++ /dev/null
@@ -1,6 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-#
-# Makefile for TOSHIBA JMR-TX3927 board
-#
-
-obj-y	+= prom.o irq.o setup.o
diff --git a/arch/mips/txx9/jmr3927/irq.c b/arch/mips/txx9/jmr3927/irq.c
deleted file mode 100644
index c22c859a2c49..000000000000
--- a/arch/mips/txx9/jmr3927/irq.c
+++ /dev/null
@@ -1,128 +0,0 @@
-/*
- * Copyright 2001 MontaVista Software Inc.
- * Author: MontaVista Software, Inc.
- *              ahennessy@mvista.com
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2000-2001 Toshiba Corporation
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-#include <linux/init.h>
-#include <linux/types.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-
-#include <asm/io.h>
-#include <asm/mipsregs.h>
-#include <asm/txx9/generic.h>
-#include <asm/txx9/jmr3927.h>
-
-#if JMR3927_IRQ_END > NR_IRQS
-#error JMR3927_IRQ_END > NR_IRQS
-#endif
-
-/*
- * CP0_STATUS is a thread's resource (saved/restored on context switch).
- * So disable_irq/enable_irq MUST handle IOC/IRC registers.
- */
-static void mask_irq_ioc(struct irq_data *d)
-{
-	/* 0: mask */
-	unsigned int irq_nr = d->irq - JMR3927_IRQ_IOC;
-	unsigned char imask = jmr3927_ioc_reg_in(JMR3927_IOC_INTM_ADDR);
-	unsigned int bit = 1 << irq_nr;
-	jmr3927_ioc_reg_out(imask & ~bit, JMR3927_IOC_INTM_ADDR);
-	/* flush write buffer */
-	(void)jmr3927_ioc_reg_in(JMR3927_IOC_REV_ADDR);
-}
-static void unmask_irq_ioc(struct irq_data *d)
-{
-	/* 0: mask */
-	unsigned int irq_nr = d->irq - JMR3927_IRQ_IOC;
-	unsigned char imask = jmr3927_ioc_reg_in(JMR3927_IOC_INTM_ADDR);
-	unsigned int bit = 1 << irq_nr;
-	jmr3927_ioc_reg_out(imask | bit, JMR3927_IOC_INTM_ADDR);
-	/* flush write buffer */
-	(void)jmr3927_ioc_reg_in(JMR3927_IOC_REV_ADDR);
-}
-
-static int jmr3927_ioc_irqroute(void)
-{
-	unsigned char istat = jmr3927_ioc_reg_in(JMR3927_IOC_INTS2_ADDR);
-	int i;
-
-	for (i = 0; i < JMR3927_NR_IRQ_IOC; i++) {
-		if (istat & (1 << i))
-			return JMR3927_IRQ_IOC + i;
-	}
-	return -1;
-}
-
-static int jmr3927_irq_dispatch(int pending)
-{
-	int irq;
-
-	if ((pending & CAUSEF_IP7) == 0)
-		return -1;
-	irq = (pending >> CAUSEB_IP2) & 0x0f;
-	irq += JMR3927_IRQ_IRC;
-	if (irq == JMR3927_IRQ_IOCINT)
-		irq = jmr3927_ioc_irqroute();
-	return irq;
-}
-
-static struct irq_chip jmr3927_irq_ioc = {
-	.name = "jmr3927_ioc",
-	.irq_mask = mask_irq_ioc,
-	.irq_unmask = unmask_irq_ioc,
-};
-
-void __init jmr3927_irq_setup(void)
-{
-	int i;
-
-	txx9_irq_dispatch = jmr3927_irq_dispatch;
-	/* Now, interrupt control disabled, */
-	/* all IRC interrupts are masked, */
-	/* all IRC interrupt mode are Low Active. */
-
-	/* mask all IOC interrupts */
-	jmr3927_ioc_reg_out(0, JMR3927_IOC_INTM_ADDR);
-	/* setup IOC interrupt mode (SOFT:High Active, Others:Low Active) */
-	jmr3927_ioc_reg_out(JMR3927_IOC_INTF_SOFT, JMR3927_IOC_INTP_ADDR);
-
-	/* clear PCI Soft interrupts */
-	jmr3927_ioc_reg_out(0, JMR3927_IOC_INTS1_ADDR);
-	/* clear PCI Reset interrupts */
-	jmr3927_ioc_reg_out(0, JMR3927_IOC_RESET_ADDR);
-
-	tx3927_irq_init();
-	for (i = JMR3927_IRQ_IOC; i < JMR3927_IRQ_IOC + JMR3927_NR_IRQ_IOC; i++)
-		irq_set_chip_and_handler(i, &jmr3927_irq_ioc,
-					 handle_level_irq);
-
-	/* setup IOC interrupt 1 (PCI, MODEM) */
-	irq_set_chained_handler(JMR3927_IRQ_IOCINT, handle_simple_irq);
-}
diff --git a/arch/mips/txx9/jmr3927/prom.c b/arch/mips/txx9/jmr3927/prom.c
deleted file mode 100644
index 53c68de54d30..000000000000
--- a/arch/mips/txx9/jmr3927/prom.c
+++ /dev/null
@@ -1,52 +0,0 @@
-/*
- * BRIEF MODULE DESCRIPTION
- *    PROM library initialisation code, assuming a version of
- *    pmon is the boot code.
- *
- * Copyright 2001 MontaVista Software Inc.
- * Author: MontaVista Software, Inc.
- *              ahennessy@mvista.com
- *
- * Based on arch/mips/au1000/common/prom.c
- *
- * This file was derived from Carsten Langgaard's
- * arch/mips/mips-boards/xx files.
- *
- * Carsten Langgaard, carstenl@mips.com
- * Copyright (C) 1999,2000 MIPS Technologies, Inc.  All rights reserved.
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/memblock.h>
-#include <asm/txx9/generic.h>
-#include <asm/txx9/jmr3927.h>
-
-void __init jmr3927_prom_init(void)
-{
-	/* CCFG */
-	if ((tx3927_ccfgptr->ccfg & TX3927_CCFG_TLBOFF) == 0)
-		pr_err("TX3927 TLB off\n");
-
-	memblock_add(0, JMR3927_SDRAM_SIZE);
-	txx9_sio_putchar_init(TX3927_SIO_REG(1));
-}
diff --git a/arch/mips/txx9/jmr3927/setup.c b/arch/mips/txx9/jmr3927/setup.c
deleted file mode 100644
index 613943886e34..000000000000
--- a/arch/mips/txx9/jmr3927/setup.c
+++ /dev/null
@@ -1,223 +0,0 @@
-/*
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- *
- * Copyright 2001 MontaVista Software Inc.
- * Author: MontaVista Software, Inc.
- *              ahennessy@mvista.com
- *
- * Copyright (C) 2000-2001 Toshiba Corporation
- * Copyright (C) 2007 Ralf Baechle (ralf@linux-mips.org)
- */
-
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/ioport.h>
-#include <linux/delay.h>
-#include <linux/platform_device.h>
-#include <linux/gpio.h>
-#include <asm/reboot.h>
-#include <asm/txx9pio.h>
-#include <asm/txx9/generic.h>
-#include <asm/txx9/pci.h>
-#include <asm/txx9/jmr3927.h>
-#include <asm/mipsregs.h>
-
-static void jmr3927_machine_restart(char *command)
-{
-	local_irq_disable();
-#if 1	/* Resetting PCI bus */
-	jmr3927_ioc_reg_out(0, JMR3927_IOC_RESET_ADDR);
-	jmr3927_ioc_reg_out(JMR3927_IOC_RESET_PCI, JMR3927_IOC_RESET_ADDR);
-	(void)jmr3927_ioc_reg_in(JMR3927_IOC_RESET_ADDR);	/* flush WB */
-	mdelay(1);
-	jmr3927_ioc_reg_out(0, JMR3927_IOC_RESET_ADDR);
-#endif
-	jmr3927_ioc_reg_out(JMR3927_IOC_RESET_CPU, JMR3927_IOC_RESET_ADDR);
-	/* fallback */
-	(*_machine_halt)();
-}
-
-static void __init jmr3927_time_init(void)
-{
-	tx3927_time_init(0, 1);
-}
-
-#define DO_WRITE_THROUGH
-
-static void jmr3927_board_init(void);
-
-static void __init jmr3927_mem_setup(void)
-{
-	set_io_port_base(JMR3927_PORT_BASE + JMR3927_PCIIO);
-
-	_machine_restart = jmr3927_machine_restart;
-
-	/* cache setup */
-	{
-		unsigned int conf;
-#ifdef DO_WRITE_THROUGH
-		int mips_config_cwfon = 0;
-		int mips_config_wbon = 0;
-#else
-		int mips_config_cwfon = 1;
-		int mips_config_wbon = 1;
-#endif
-
-		conf = read_c0_conf();
-		conf &= ~(TX39_CONF_WBON | TX39_CONF_CWFON);
-		conf |= mips_config_wbon ? TX39_CONF_WBON : 0;
-		conf |= mips_config_cwfon ? TX39_CONF_CWFON : 0;
-
-		write_c0_conf(conf);
-		write_c0_cache(0);
-	}
-
-	/* initialize board */
-	jmr3927_board_init();
-
-	tx3927_sio_init(0, 1 << 1); /* ch1: noCTS */
-}
-
-static void __init jmr3927_pci_setup(void)
-{
-#ifdef CONFIG_PCI
-	int extarb = !(tx3927_ccfgptr->ccfg & TX3927_CCFG_PCIXARB);
-	struct pci_controller *c;
-
-	c = txx9_alloc_pci_controller(&txx9_primary_pcic,
-				      JMR3927_PCIMEM, JMR3927_PCIMEM_SIZE,
-				      JMR3927_PCIIO, JMR3927_PCIIO_SIZE);
-	register_pci_controller(c);
-	if (!extarb) {
-		/* Reset PCI Bus */
-		jmr3927_ioc_reg_out(0, JMR3927_IOC_RESET_ADDR);
-		udelay(100);
-		jmr3927_ioc_reg_out(JMR3927_IOC_RESET_PCI,
-				    JMR3927_IOC_RESET_ADDR);
-		udelay(100);
-		jmr3927_ioc_reg_out(0, JMR3927_IOC_RESET_ADDR);
-	}
-	tx3927_pcic_setup(c, JMR3927_SDRAM_SIZE, extarb);
-	tx3927_setup_pcierr_irq();
-#endif /* CONFIG_PCI */
-}
-
-static void __init jmr3927_board_init(void)
-{
-	txx9_cpu_clock = JMR3927_CORECLK;
-	/* SDRAMC are configured by PROM */
-
-	/* ROMC */
-	tx3927_romcptr->cr[1] = JMR3927_ROMCE1 | 0x00030048;
-	tx3927_romcptr->cr[2] = JMR3927_ROMCE2 | 0x000064c8;
-	tx3927_romcptr->cr[3] = JMR3927_ROMCE3 | 0x0003f698;
-	tx3927_romcptr->cr[5] = JMR3927_ROMCE5 | 0x0000f218;
-
-	/* Pin selection */
-	tx3927_ccfgptr->pcfg &= ~TX3927_PCFG_SELALL;
-	tx3927_ccfgptr->pcfg |=
-		TX3927_PCFG_SELSIOC(0) | TX3927_PCFG_SELSIO_ALL |
-		(TX3927_PCFG_SELDMA_ALL & ~TX3927_PCFG_SELDMA(1));
-
-	tx3927_setup();
-
-	/* PIO[15:12] connected to LEDs */
-	__raw_writel(0x0000f000, &tx3927_pioptr->dir);
-
-	jmr3927_pci_setup();
-
-	/* SIO0 DTR on */
-	jmr3927_ioc_reg_out(0, JMR3927_IOC_DTR_ADDR);
-
-	jmr3927_led_set(0);
-
-	pr_info("JMR-TX3927 (Rev %d) --- IOC(Rev %d) DIPSW:%d,%d,%d,%d\n",
-		jmr3927_ioc_reg_in(JMR3927_IOC_BREV_ADDR) & JMR3927_REV_MASK,
-		jmr3927_ioc_reg_in(JMR3927_IOC_REV_ADDR) & JMR3927_REV_MASK,
-		jmr3927_dipsw1(), jmr3927_dipsw2(),
-		jmr3927_dipsw3(), jmr3927_dipsw4());
-}
-
-/* This trick makes rtc-ds1742 driver usable as is. */
-static unsigned long jmr3927_swizzle_addr_b(unsigned long port)
-{
-	if ((port & 0xffff0000) != JMR3927_IOC_NVRAMB_ADDR)
-		return port;
-	port = (port & 0xffff0000) | (port & 0x7fff << 1);
-#ifdef __BIG_ENDIAN
-	return port;
-#else
-	return port | 1;
-#endif
-}
-
-static void __init jmr3927_rtc_init(void)
-{
-	static struct resource __initdata res = {
-		.start	= JMR3927_IOC_NVRAMB_ADDR - IO_BASE,
-		.end	= JMR3927_IOC_NVRAMB_ADDR - IO_BASE + 0x800 - 1,
-		.flags	= IORESOURCE_MEM,
-	};
-	platform_device_register_simple("rtc-ds1742", -1, &res, 1);
-}
-
-static void __init jmr3927_mtd_init(void)
-{
-	int i;
-
-	for (i = 0; i < 2; i++)
-		tx3927_mtd_init(i);
-}
-
-static void __init jmr3927_device_init(void)
-{
-	unsigned long iocled_base = JMR3927_IOC_LED_ADDR - IO_BASE;
-#ifdef __LITTLE_ENDIAN
-	iocled_base |= 1;
-#endif
-	__swizzle_addr_b = jmr3927_swizzle_addr_b;
-	jmr3927_rtc_init();
-	tx3927_wdt_init();
-	jmr3927_mtd_init();
-	txx9_iocled_init(iocled_base, -1, 8, 1, "green", NULL);
-}
-
-static void __init jmr3927_arch_init(void)
-{
-	txx9_gpio_init(TX3927_PIO_REG, 0, 16);
-
-	gpio_request(11, "dipsw1");
-	gpio_request(10, "dipsw2");
-}
-
-struct txx9_board_vec jmr3927_vec __initdata = {
-	.system = "Toshiba JMR_TX3927",
-	.prom_init = jmr3927_prom_init,
-	.mem_setup = jmr3927_mem_setup,
-	.irq_setup = jmr3927_irq_setup,
-	.time_init = jmr3927_time_init,
-	.device_init = jmr3927_device_init,
-	.arch_init = jmr3927_arch_init,
-#ifdef CONFIG_PCI
-	.pci_map_irq = jmr3927_pci_map_irq,
-#endif
-};
diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 6bcdb4e6a0d1..d5de3f77d3aa 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -623,7 +623,7 @@ config S3C24XX_DMAC
 
 config TXX9_DMAC
 	tristate "Toshiba TXx9 SoC DMA support"
-	depends on MACH_TX49XX || MACH_TX39XX
+	depends on MACH_TX49XX
 	select DMA_ENGINE
 	help
 	  Support the TXx9 SoC internal DMA controller.  This can be
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index c8fa79da23b3..aa42f0686591 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1718,7 +1718,7 @@ config AR7_WDT
 
 config TXX9_WDT
 	tristate "Toshiba TXx9 Watchdog Timer"
-	depends on CPU_TX39XX || CPU_TX49XX || (MIPS && COMPILE_TEST)
+	depends on CPU_TX49XX || (MIPS && COMPILE_TEST)
 	select WATCHDOG_CORE
 	help
 	  Hardware driver for the built-in watchdog timer on TXx9 MIPS SoCs.
-- 
2.29.2

