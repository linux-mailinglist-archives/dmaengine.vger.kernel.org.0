Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D331962FF9F
	for <lists+dmaengine@lfdr.de>; Fri, 18 Nov 2022 22:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbiKRVyj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 18 Nov 2022 16:54:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiKRVyg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 18 Nov 2022 16:54:36 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971547C445
        for <dmaengine@vger.kernel.org>; Fri, 18 Nov 2022 13:54:35 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ow9JN-0001VE-Mm; Fri, 18 Nov 2022 22:54:13 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ow9JI-0057eY-6O; Fri, 18 Nov 2022 22:54:09 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ow9JI-00HaPG-6M; Fri, 18 Nov 2022 22:54:08 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Arnd Bergmann <arnd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        dmaengine@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH] ARM: s3c: Fix a build error after the s3c24xx dma driver was removed
Date:   Fri, 18 Nov 2022 22:54:01 +0100
Message-Id: <20221118215401.505480-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221021203329.4143397-14-arnd@kernel.org>
References: <20221021203329.4143397-14-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=789; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=MQY1mKOHphIR2YvCjrphAII3VS7+7iYHC7fhsww+j8w=; b=owGbwMvMwMV48I9IxdpTbzgZT6slMSSX//ua9fr08cpF3wMzXx2QYMvNjLz6dYfKM7P3JcWrNxZy BM1c1clozMLAyMUgK6bIUlekJTZBYs1/u5Il3DCDWJlApjBwcQrARE5UsP+PV9M77fDWfJM8w+2Kw8 UnfiWJ7znC2f3T54qeT6laQu8n5yq9n1tdlneoO14WtnjDwrr4YamuzIS5rCsk/6XFPxXzSVHNPDy5 ved3nIHfkc6bmvYKgbaV3GfYHMwSS8qidL/rTza8GTuf9X3azfOCASYz1n9bmHa58XsKp2Rty1cGn6 D2nZEzws13pTv0KjRPXemQGxPVqDvZZldAbqnN3LN2YWZTN+/2/ZH+53Lcw9gbjmJel6ZLKekwL9jH 1P+C4/L7+v3Ft40P9Xmum72Py23dyyrNmp+1STqOcfWVBsq7L0fu7mDpY1U3rEjiy/xaW6LTqbmqSt Ti4hMZvQrtlzlsFq3Xt9XOtRIBAA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The linux/platform_data/dma-s3c24xx.h header file was removed. It didn't
declare or define any symbol needed in devs.c though, so the #include
can just be dropped.

Fixes: cccc46ae3623 ("dmaengine: remove s3c24xx driver")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-s3c/devs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-s3c/devs.c b/arch/arm/mach-s3c/devs.c
index 9ac07c023adf..a31d1c3038e8 100644
--- a/arch/arm/mach-s3c/devs.c
+++ b/arch/arm/mach-s3c/devs.c
@@ -29,7 +29,6 @@
 #include <linux/sizes.h>
 #include <linux/platform_data/s3c-hsudc.h>
 #include <linux/platform_data/s3c-hsotg.h>
-#include <linux/platform_data/dma-s3c24xx.h>
 
 #include <linux/platform_data/media/s5p_hdmi.h>
 
-- 
2.38.1

