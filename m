Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36F4721691
	for <lists+dmaengine@lfdr.de>; Sun,  4 Jun 2023 14:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbjFDMNZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 4 Jun 2023 08:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjFDMNY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 4 Jun 2023 08:13:24 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98484CA;
        Sun,  4 Jun 2023 05:13:21 -0700 (PDT)
Received: from stefanw-SCHENKER ([37.4.248.58]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mcp7M-1qffJY2DxK-00Zx5t; Sun, 04 Jun 2023 14:12:42 +0200
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-pm@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Stefan Wahren <stefan.wahren@i2se.com>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH 02/10] dmaengine: bcm2835: also support generic dma-channel-mask
Date:   Sun,  4 Jun 2023 14:12:15 +0200
Message-Id: <20230604121223.9625-3-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230604121223.9625-1-stefan.wahren@i2se.com>
References: <20230604121223.9625-1-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:KxozCg8oOnQt3q5mPq0HbQmy7gi7fAIS5EtgBua5Q0tEKepPwM4
 ThwXX6hVibrvtiDk4KSOo1i5qFwNGWAgDBCECMdgx99Cz2gDbAB22klR7Ok4sC5IRkIUeEM
 mmTaqvDKrjvtDo4JxaeHOtZaxmXJKxbDLbNa1x5uRrtE11Qm5okqHnknE4MvezqO+3byol4
 tHPvCKsEZCFDD4h+F4nDA==
UI-OutboundReport: notjunk:1;M01:P0:+kYEE+ZQyz4=;RtH81khKORI85HByj5ZYkPReo/I
 STW/PQS3ERuAkrJh/N2ZQABRkZDVuLch7HQ6MCtKykWAxd1wELzuk9EplU7RFQ58M59EnCaSu
 ZEAggFm5MO6eIRKXEekcgRwRJz9Ncsw0z5OKIIlI/LBCAKwezdC3g6mzfR8RdBu/5m3/0Lece
 kmdPP5dvwhEGlrYO4HfH5z1Fj+qqsnYNZHJohJbVXBGVFOAo9chTmQeR0L0ST3vTYLRFQ+S5J
 WDkI2UKcbc2wrw1eJ32v+47ub0Y2N5wIuh1U94q5ulMP+wLYO8G/fxWc/tzl3grAdal93CwKZ
 Ote7f5Jvx9TjWNiJjYMNrPN7wdjy3EjWSAlf6yXXpEYhlmOnHW7CwI/Ob/VX5cgFqmXFEkCbr
 aPU3w2z7vy/rPYLJ4QEGqThrxQFABDZwn4Ld+MiyrhMlJ/lvFzaN36owiksOSGlOvEzZJvG5h
 pTLqv36TvzWaxLSndGSbuICmbdHw1wtcDPkvxvUEqklUkPhutcQQTGIyvC9vXTQ//IBgO3Tnb
 Wi8CX4+LaqRpcEUeYbwp9/UvsRV8UZuZXjWUwOlq/yBqMPzfJ7Nkp1vGah+kDKi1T0Ea8sLNn
 +cZ2rio0AAizNtEACKzu2NC5Pg3SEJvNpSGXkmm5rxf0u//UcAfndWokWSk2GqprNrWyKdbIL
 Ry+CFeqzsNb1afwQbjZr2jLgFaHlMkaqS2QSgtxP3g==
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Since commit e2d896c08ca3 ("Documentation: bindings: dma: Add
binding for dma-channel-mask") there is a generic property to list
available DMA channels for the kernel to use. The generic property
has been implemented by some other platforms.
So implement support for the generic one and consider the
vendor specific one as deprecated. This also simplifies the YAML
conversion of the BCM2835 DMA DT bindings a little bit.

Cc: John Stultz <john.stultz@linaro.org>
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/dma/bcm2835-dma.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 0807fb9eb262..a0573977a373 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -941,12 +941,18 @@ static int bcm2835_dma_probe(struct platform_device *pdev)
 	}
 
 	/* Request DMA channel mask from device tree */
-	if (of_property_read_u32(pdev->dev.of_node,
-			"brcm,dma-channel-mask",
-			&chans_available)) {
-		dev_err(&pdev->dev, "Failed to get channel mask\n");
-		rc = -EINVAL;
-		goto err_no_dma;
+	if (of_property_read_u32(pdev->dev.of_node, "dma-channel-mask",
+				 &chans_available)) {
+		if (of_property_read_u32(pdev->dev.of_node,
+					 "brcm,dma-channel-mask",
+					 &chans_available)) {
+			dev_err(&pdev->dev, "Failed to get channel mask\n");
+			rc = -EINVAL;
+			goto err_no_dma;
+		} else {
+			dev_warn(&pdev->dev,
+				 "brcm,dma-channel-mask is deprecated, update your device-tree\n");
+		}
 	}
 
 	/* get irqs for each channel that we support */
-- 
2.34.1

