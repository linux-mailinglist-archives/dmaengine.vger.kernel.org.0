Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5453E506E8B
	for <lists+dmaengine@lfdr.de>; Tue, 19 Apr 2022 15:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352518AbiDSNom (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Apr 2022 09:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244866AbiDSNnp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Apr 2022 09:43:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8E8182;
        Tue, 19 Apr 2022 06:41:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DF144B8197F;
        Tue, 19 Apr 2022 13:41:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1808EC385A5;
        Tue, 19 Apr 2022 13:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650375659;
        bh=0G3cWV48CpbBHTE2pnfpd8IteUQx33zVzk5I5jOHq28=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tcaHuW+qziDrvzUpHuEMFKwFU24gmYLLaVW/lH4YSmvt7xGUnfF0sNVHp802pMZbG
         K6J/uNMNn5vL9mXzi8X3zRI/z8lzVEB3EuRwjjxKiFdSM+arUaoowF1MoiFyyH8XVV
         /v4R5gyMXGZMU1ta0p9hOmph2xXY8RLU5gpqA4zETCrSrM5Xh09D1z+ACK4EbozYv5
         9Sive/zvlpYwCeQ4lV4Bn/MYQu9361EX6fnn4oEfAgmr8UYhW5oVkAM1jX9gnVVYhJ
         ZhuIwaJaHXeGR4SyNhWN+K44rhkpWMXYC38ShwJwl87he4xwz0XOvHfjHqz/624Ycs
         325kt1woDgtcA==
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
Subject: [PATCH 27/41] ARM: omap1: use pci_remap_iospace() for omap_cf
Date:   Tue, 19 Apr 2022 15:37:09 +0200
Message-Id: <20220419133723.1394715-28-arnd@kernel.org>
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

The ISA I/O space handling in omap_cf is incompatible with
PCI drivers in a multiplatform kernel, and requires a custom
mach/io.h.

Change the driver to use pci_remap_iospace() like PCI drivers do,
so the generic ioport access can work across platforms.

To actually use that code, we have to select CONFIG_PCI
here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig                      |  2 +-
 arch/arm/mach-omap1/include/mach/io.h | 45 ---------------------------
 drivers/pcmcia/omap_cf.c              | 10 +++---
 3 files changed, 5 insertions(+), 52 deletions(-)
 delete mode 100644 arch/arm/mach-omap1/include/mach/io.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 700655e31b04..a57ad0928edc 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -487,11 +487,11 @@ config ARCH_OMAP1
 	bool "TI OMAP1"
 	select ARCH_OMAP
 	select CLKSRC_MMIO
+	select FORCE_PCI if PCCARD
 	select GENERIC_IRQ_CHIP
 	select GPIOLIB
 	select HAVE_LEGACY_CLK
 	select IRQ_DOMAIN
-	select NEED_MACH_IO_H if PCCARD
 	select NEED_MACH_MEMORY_H
 	select SPARSE_IRQ
 	help
diff --git a/arch/arm/mach-omap1/include/mach/io.h b/arch/arm/mach-omap1/include/mach/io.h
deleted file mode 100644
index ce4f8005b26f..000000000000
--- a/arch/arm/mach-omap1/include/mach/io.h
+++ /dev/null
@@ -1,45 +0,0 @@
-/*
- * arch/arm/mach-omap1/include/mach/io.h
- *
- * IO definitions for TI OMAP processors and boards
- *
- * Copied from arch/arm/mach-sa1100/include/mach/io.h
- * Copyright (C) 1997-1999 Russell King
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the
- * Free Software Foundation; either version 2 of the License, or (at your
- * option) any later version.
- *
- * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
- * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
- * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
- * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
- * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 675 Mass Ave, Cambridge, MA 02139, USA.
- *
- * Modifications:
- *  06-12-1997	RMK	Created.
- *  07-04-1999	RMK	Major cleanup
- */
-
-#ifndef __ASM_ARM_ARCH_IO_H
-#define __ASM_ARM_ARCH_IO_H
-
-#define IO_SPACE_LIMIT 0xffffffff
-
-/*
- * We don't actually have real ISA nor PCI buses, but there is so many
- * drivers out there that might just work if we fake them...
- */
-#define __io(a)		__typesafe_io(a)
-
-#endif
diff --git a/drivers/pcmcia/omap_cf.c b/drivers/pcmcia/omap_cf.c
index 093022ce7d91..1972a8f6fa8e 100644
--- a/drivers/pcmcia/omap_cf.c
+++ b/drivers/pcmcia/omap_cf.c
@@ -205,6 +205,7 @@ static int __init omap_cf_probe(struct platform_device *pdev)
 	int			irq;
 	int			status;
 	struct resource		*res;
+	struct resource		iospace = DEFINE_RES_IO(SZ_64, SZ_4K);
 
 	seg = (int) pdev->dev.platform_data;
 	if (seg == 0 || seg > 3)
@@ -235,9 +236,9 @@ static int __init omap_cf_probe(struct platform_device *pdev)
 	cf->phys_cf = res->start;
 
 	/* pcmcia layer only remaps "real" memory */
-	cf->socket.io_offset = (unsigned long)
-			ioremap(cf->phys_cf + SZ_4K, SZ_2K);
-	if (!cf->socket.io_offset) {
+	cf->socket.io_offset = iospace.start;
+	status = pci_remap_iospace(&iospace, cf->phys_cf + SZ_4K);
+	if (status) {
 		status = -ENOMEM;
 		goto fail1;
 	}
@@ -285,8 +286,6 @@ static int __init omap_cf_probe(struct platform_device *pdev)
 fail2:
 	release_mem_region(cf->phys_cf, SZ_8K);
 fail1:
-	if (cf->socket.io_offset)
-		iounmap((void __iomem *) cf->socket.io_offset);
 	free_irq(irq, cf);
 fail0:
 	kfree(cf);
@@ -300,7 +299,6 @@ static int __exit omap_cf_remove(struct platform_device *pdev)
 	cf->active = 0;
 	pcmcia_unregister_socket(&cf->socket);
 	del_timer_sync(&cf->timer);
-	iounmap((void __iomem *) cf->socket.io_offset);
 	release_mem_region(cf->phys_cf, SZ_8K);
 	free_irq(cf->irq, cf);
 	kfree(cf);
-- 
2.29.2

