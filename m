Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA1507216A3
	for <lists+dmaengine@lfdr.de>; Sun,  4 Jun 2023 14:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbjFDMN1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 4 Jun 2023 08:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbjFDMNZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 4 Jun 2023 08:13:25 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE1CE0;
        Sun,  4 Jun 2023 05:13:22 -0700 (PDT)
Received: from stefanw-SCHENKER ([37.4.248.58]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MY6P5-1pXpGD14MX-00YRQM; Sun, 04 Jun 2023 14:12:44 +0200
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
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 04/10] ARM: dts: bcm2835: adjust DMA nodes
Date:   Sun,  4 Jun 2023 14:12:17 +0200
Message-Id: <20230604121223.9625-5-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230604121223.9625-1-stefan.wahren@i2se.com>
References: <20230604121223.9625-1-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:MlCIRO9pga208xxruv+F0H86jIzbBCoc9x+fOZ2eGZ2WniNufy7
 192tUzznPMa6Hhsu0FfCQMa3h6BTG0u62e8mkasHZcTrJWYG63mAhQwoOjmLAGORe7HyeaK
 wIa31cUeHV/9IKX3o8Cr8yT35ZJI486R3/+Cx69A0ytMonG90cvHbESnCpTfpEAE05tHNMi
 BpdDJ6ftElBO/E02n3fXQ==
UI-OutboundReport: notjunk:1;M01:P0:O+MH+gDO2dY=;z0hesc/5QyYxSW+vBB08V6bSOfC
 JqNpomBhLzTp/JbbmCpzvFIvnHRH2KfsvWDdegB1lC6gjatYyi+EgZuSi636cCMnlkkht0QNy
 Zgre4pa7j+4yhUe1eZuZJt+JOa+jXnjI27+wG/vK19YXcC5C6HzAGlLapN1kZs6DOYFIvhGtN
 N6KYe9/nlLN53DzNCyTih9AuGJbwevI4nfE0kfM5Zoh3n8SKHs2xis3HJ26trEpSQ4ftSiw/K
 OE7wJ3GSE8by6+vmM3XAi5Hjm08mMyrVe8bXr/YLifs4MIu0DRj3ObmNzeNFqBHSHFeE1c8hu
 bwayWRJoYmtRNT9bjeuIowRCDFeCJzyeYf1T//OKF4cUTUILGopEjj3Fe4+GbkumQdy/a/aV8
 FL9Gw42jPVRNq/E5lzIsupvlEDomoaXdDbtavKk97mww1pqOPWPbrJxbUKXAaBh30H01x24bR
 3Q4M3UDjskcGSfvJ9w2S41L+zqm22Oghfg+XVllzuyIqV7OLsb3uN2U1yUx4ECuiclezmz5kq
 T0nDsIefWnvzlr08Mh4nHQvQ3ukvnslBDeNYy8S0IT21o/3wrc4a6uvE/ctFFD9NH3t8jUQcp
 ffd5CACOSwcbqGo9urmVMzSzMvFkKjzszXlQvuusgzjivWgwPexdaD2N0VF3tk6dDkhwvh82q
 Ko4LGNBOb1xZHR28TChK3on5F01WzLO3tdeaqyiA3w==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

After converting the bcm2835-dma DT binding to YAML, the DT schema
checks gave warnings like:

$nodename:0: 'dma@7e007000' does not match '^dma-controller(@.*)?$'
'dma-channel-mask' is a required property
Unevaluated properties are not allowed ('brcm,dma-channel-mask' was unexpected)

So fix them accordingly.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/bcm2711.dtsi        | 4 ++--
 arch/arm/boot/dts/bcm2835-common.dtsi | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/bcm2711.dtsi b/arch/arm/boot/dts/bcm2711.dtsi
index 097e9f252235..83745672a120 100644
--- a/arch/arm/boot/dts/bcm2711.dtsi
+++ b/arch/arm/boot/dts/bcm2711.dtsi
@@ -76,7 +76,7 @@ thermal: thermal {
 			};
 		};
 
-		dma: dma@7e007000 {
+		dma: dma-controller@7e007000 {
 			compatible = "brcm,bcm2835-dma";
 			reg = <0x7e007000 0xb00>;
 			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>,
@@ -103,7 +103,7 @@ dma: dma@7e007000 {
 					  "dma9",
 					  "dma10";
 			#dma-cells = <1>;
-			brcm,dma-channel-mask = <0x07f5>;
+			dma-channel-mask = <0x07f5>;
 		};
 
 		pm: watchdog@7e100000 {
diff --git a/arch/arm/boot/dts/bcm2835-common.dtsi b/arch/arm/boot/dts/bcm2835-common.dtsi
index bb7e8f7facaf..3ba8db8eed0f 100644
--- a/arch/arm/boot/dts/bcm2835-common.dtsi
+++ b/arch/arm/boot/dts/bcm2835-common.dtsi
@@ -8,7 +8,7 @@ / {
 	interrupt-parent = <&intc>;
 
 	soc {
-		dma: dma@7e007000 {
+		dma: dma-controller@7e007000 {
 			compatible = "brcm,bcm2835-dma";
 			reg = <0x7e007000 0xf00>;
 			interrupts = <1 16>,
@@ -46,7 +46,7 @@ dma: dma@7e007000 {
 					  "dma14",
 					  "dma-shared-all";
 			#dma-cells = <1>;
-			brcm,dma-channel-mask = <0x7f35>;
+			dma-channel-mask = <0x7f35>;
 		};
 
 		intc: interrupt-controller@7e00b200 {
-- 
2.34.1

