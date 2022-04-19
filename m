Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B98506EAA
	for <lists+dmaengine@lfdr.de>; Tue, 19 Apr 2022 15:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbiDSNnS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Apr 2022 09:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352670AbiDSNmh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Apr 2022 09:42:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBAF038BDA;
        Tue, 19 Apr 2022 06:39:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A6A30B81980;
        Tue, 19 Apr 2022 13:39:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6057C385A7;
        Tue, 19 Apr 2022 13:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650375570;
        bh=B7GGzQK0KIjiwCxoEg1dXjX6/oLgtetrXN0VV1GNBGs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TOpp36+rC0pDLis7adjFpLtRxKwHifzqT8ATqBoHM3otXvUperBtVcs1FifHc5yyB
         rqLPC7rYbjq0Cf9Ys1ZbJ2P/GGpYZjaZv29gcfAMIMSQP3xSrwfLAML/qNNhmU/GVd
         gH/ywtlMj8E5lIgxWXQ0d1WKgZnNBdasQLQRmukrsvNWTS1WfVWbNuYArE2MVzLjOQ
         7HngWtMC/2cYvIPEoUHdURPi61wEmycHnijfRFxP36EiMPOyusZ0YufgRWJ+JHp9ci
         tnu1W78uOh80vxB8EvHIbeFZxxM2wIE9VFANNL583gMp6zk/BtWTAHQhAPI0pKoXd2
         RNXWpAmIMsrlg==
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
Subject: [PATCH 15/41] input: omap: void using mach/*.h headers
Date:   Tue, 19 Apr 2022 15:36:57 +0200
Message-Id: <20220419133723.1394715-16-arnd@kernel.org>
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

The omap-keypad driver currently relies on including mach/memory.h
implicitly, but that won't happen once omap1 is converted to
CONFIG_ARCH_MULTIPLATFORM. Include the required header
explicitly.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/input/keyboard/omap-keypad.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/keyboard/omap-keypad.c b/drivers/input/keyboard/omap-keypad.c
index eb3a687796e7..57447d6c9007 100644
--- a/drivers/input/keyboard/omap-keypad.c
+++ b/drivers/input/keyboard/omap-keypad.c
@@ -24,6 +24,7 @@
 #include <linux/gpio.h>
 #include <linux/platform_data/gpio-omap.h>
 #include <linux/platform_data/keypad-omap.h>
+#include <linux/soc/ti/omap1-io.h>
 
 #undef NEW_BOARD_LEARNING_MODE
 
-- 
2.29.2

