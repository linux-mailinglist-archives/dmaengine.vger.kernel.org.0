Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95572506E09
	for <lists+dmaengine@lfdr.de>; Tue, 19 Apr 2022 15:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352558AbiDSNnX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Apr 2022 09:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234762AbiDSNnI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Apr 2022 09:43:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35AE182;
        Tue, 19 Apr 2022 06:40:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A754B81983;
        Tue, 19 Apr 2022 13:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B32FFC385A5;
        Tue, 19 Apr 2022 13:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650375623;
        bh=R5zRvKa0SoyT3N6cs+9ATf3vspiQLolbMLlEiLA/7fA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h4qvsRlCqc1+D/Un3T++kg9XOlylFj9tu57mNt8nm00hUNQ6OKBJwfaNIy8CUc5b/
         qlJ5Qll9E9CFFYZxtIhDJzmK+qDlqq4+ArAd2BBXudLqHYrCpKgbUoCnwsfLaR2pgk
         Q7EkW4bPFi3bk0l1eRnod+7F8TcxdVYbp1x3X1kd6GHmuGnsuLz3ITS24UVsnNzXdg
         x/K6BdB+SIi+C9NttQpeR53oMsrljIEQWrLP8CdiwfvAVwJt/CIv2ZT1IB0hwp9ZMU
         YhjJTR86Ah4hamcr5wDfPSVrUyclrlzsHDyDQ4lgL5SrWli+rzKao8UrzltowcxyNH
         vWiGzLOvfg/Eg==
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
Subject: [PATCH 22/41] ARM: omap1: move plat/dma.c to mach/omap-dma.c
Date:   Tue, 19 Apr 2022 15:37:04 +0200
Message-Id: <20220419133723.1394715-23-arnd@kernel.org>
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

Most of the interface functions in plat/dma.c are only used from the
USB driver, which is practically OMAP1 specific, except for compile
testing.

The omap_get_plat_info(), omap_request_dma() and omap_free_dma()
functions are never called on omap2 because of runtime checks.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-omap1/Makefile                        | 2 +-
 arch/arm/{plat-omap/dma.c => mach-omap1/omap-dma.c} | 0
 arch/arm/plat-omap/Makefile                         | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename arch/arm/{plat-omap/dma.c => mach-omap1/omap-dma.c} (100%)

diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makefile
index 450bbf552b57..0615cb0ba580 100644
--- a/arch/arm/mach-omap1/Makefile
+++ b/arch/arm/mach-omap1/Makefile
@@ -5,7 +5,7 @@
 
 # Common support
 obj-y := io.o id.o sram-init.o sram.o time.o irq.o mux.o flash.o \
-	 serial.o devices.o dma.o fb.o
+	 serial.o devices.o dma.o omap-dma.o fb.o
 obj-y += clock.o clock_data.o opp_data.o reset.o pm_bus.o timer.o
 
 ifneq ($(CONFIG_SND_SOC_OMAP_MCBSP),)
diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/mach-omap1/omap-dma.c
similarity index 100%
rename from arch/arm/plat-omap/dma.c
rename to arch/arm/mach-omap1/omap-dma.c
diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index 68ccec9de106..5d55295a14ee 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -6,4 +6,4 @@
 ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/arch/arm/plat-omap/include
 
 # Common support
-obj-y := sram.o dma.o
+obj-y := sram.o
-- 
2.29.2

