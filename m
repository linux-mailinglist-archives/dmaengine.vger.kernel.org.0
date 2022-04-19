Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFDD1506E9B
	for <lists+dmaengine@lfdr.de>; Tue, 19 Apr 2022 15:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352524AbiDSNlQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Apr 2022 09:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352490AbiDSNk4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Apr 2022 09:40:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BE53818D;
        Tue, 19 Apr 2022 06:38:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 038E2616A3;
        Tue, 19 Apr 2022 13:38:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90F89C385A5;
        Tue, 19 Apr 2022 13:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650375488;
        bh=MZYlA7Z/cfhwWB+m0aX3wfxPDdGSvAoxapWbog01ZUk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MdZyrL2KRzGofp4P5QTIbBmZ0XyiPDEb8w8y28sLj+tarhQKLn07vB63wnc/YADun
         PU7PvbaS3DDxQTwk4r5YG2+bHNT4S4FLmZ/oPTK7Gd5u14hl/54byIoriPsb1/0/j9
         B7tlavvL9imuJwBR+QRCpa1TkY5grKm440xc2QgNCXswxLctzeCsUmzlGTTgKIm64y
         deeYlDPZvYme04F6wXyybloglv6pE3/opuw9/Y/kzutWgv3lWUPl2TFn1k/LeqS+T+
         pc0fhu1DxU6BEdl20vjgvKKR5517wr05DaOEJuhu+i3bk7HLcp24nnQYomoQZOSYSL
         c+2Hz7W+Q/R+g==
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
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 04/41] ARM: omap1: declare a dummy omap_set_dma_priority
Date:   Tue, 19 Apr 2022 15:36:46 +0200
Message-Id: <20220419133723.1394715-5-arnd@kernel.org>
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

omapfb calls directly into the omap_set_dma_priority() function in
the DMA driver. This prevents compile-testing omapfb on other
architectures. Add an inline function next to the other ones
for non-omap configurations.

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/omap-dma.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/omap-dma.h b/include/linux/omap-dma.h
index 441f5f0919c6..5e228428fda1 100644
--- a/include/linux/omap-dma.h
+++ b/include/linux/omap-dma.h
@@ -338,6 +338,9 @@ static inline int omap_lcd_dma_running(void)
 #endif
 
 #else /* CONFIG_ARCH_OMAP */
+static inline void omap_set_dma_priority(int lch, int dst_port, int priority)
+{
+}
 
 static inline struct omap_system_dma_plat_info *omap_get_plat_info(void)
 {
-- 
2.29.2

