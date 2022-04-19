Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A14E506E19
	for <lists+dmaengine@lfdr.de>; Tue, 19 Apr 2022 15:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244506AbiDSNnT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Apr 2022 09:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352514AbiDSNmE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Apr 2022 09:42:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0DE37BF2;
        Tue, 19 Apr 2022 06:39:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7101616A8;
        Tue, 19 Apr 2022 13:39:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A81EFC385AC;
        Tue, 19 Apr 2022 13:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650375556;
        bh=f9Y/96hrDNAN/+YDT6y/IETuuHURcMDkd3mR04iG5MY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ebr5utca6XgjB3tSpUqlgAxa1J/VO+5Up3W225Ck2Y1KV0kHl25WxqiLaxQnTrrDP
         o4ZMRT5uiqJlbasFReJEEjIucMAj0DIkjrh7yNwei7KTqUAxhrCrbIU9vS1MWfztjT
         pnZZDXwYX8Bp58oIwWuMxVkm3t1lAwr40PquGM25WMYWoQU4zuhNhfylYnCyYIm7KS
         AxbhGnhgw8s8/7Sp0BNcsDkI0IMc9J8IbULGpS4rd/U42TIh6dRRUrDsawrsOWc7ZZ
         Lnc4CsAY2Xr00xDadJHWFy5+sqJIjPU+QvQwa5Q0tAKRS7Lo54LfD5qNiWFtBeJuUY
         ATdlp/KQHWVdA==
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
        linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 13/41] clocksource: ti-dmtimer: avoid using mach/hardware.h
Date:   Tue, 19 Apr 2022 15:36:55 +0200
Message-Id: <20220419133723.1394715-14-arnd@kernel.org>
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

As a preparation for future omap1 multiplatform support, stop
using mach/hardware.h and instead include the omap1-io.h
for low-level register access to MOD_CONF_CTRL_1.

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/clocksource/timer-ti-dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index 3e52c5226c4d..df4a73ea6651 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -433,7 +433,7 @@ int omap_dm_timer_get_irq(struct omap_dm_timer *timer)
 }
 
 #if defined(CONFIG_ARCH_OMAP1)
-#include <mach/hardware.h>
+#include <linux/soc/ti/omap1-io.h>
 
 static struct clk *omap_dm_timer_get_fclk(struct omap_dm_timer *timer)
 {
-- 
2.29.2

