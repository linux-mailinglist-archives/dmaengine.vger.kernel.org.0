Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC08734168
	for <lists+dmaengine@lfdr.de>; Sat, 17 Jun 2023 15:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbjFQNm2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 17 Jun 2023 09:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235937AbjFQNmZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 17 Jun 2023 09:42:25 -0400
X-Greylist: delayed 313 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 17 Jun 2023 06:42:21 PDT
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A8A1FCC;
        Sat, 17 Jun 2023 06:42:20 -0700 (PDT)
Received: from stefanw-SCHENKER ([37.4.248.58]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MF39M-1qLTON09jk-00FRDF; Sat, 17 Jun 2023 15:36:43 +0200
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
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-pm@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH V2 5/7] ARM: dts: bcm283x: Increase pwm-cells
Date:   Sat, 17 Jun 2023 15:36:18 +0200
Message-Id: <20230617133620.53129-6-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230617133620.53129-1-stefan.wahren@i2se.com>
References: <20230617133620.53129-1-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:HwZ2By+DqYznZAq+JpbxaECqFpuhlzYBGthEdyq3eKs4ULiL2QJ
 DwzNWFpWI3tiEeJ8J97YVaRX4ByZbuCwPFymzrPyobGGP7Zke7QoCE8ayY+q9JkfrfD/tfR
 T8BIyqDhqidMQ+fCsEBYY93A9mfvRMJ9fH4x4gI2EzgIzgnGEWDu9ilUF54zbqPBqX0GtjI
 WlzJwV1owq8KPemtsNcuQ==
UI-OutboundReport: notjunk:1;M01:P0:pq1CVBGtzM8=;t3dZ2HxvYVosjVMGjhJNVPg/oIO
 C3l1kw5VGkIWydv60GC5iYnt42COx6iNCH7xsSy2jRi8NcTTpVBg3aM1S/bIr11FWt02wgNDM
 wVp7/i4KG9Z53Tl77AG3F7PiVTYacSs1wZogEVpdwORUpRLU/LAa4C7ecrxCAYpovnfqOmAD+
 rvxNFR43c9T/HM4CYwmIDfBWwGGRex09uehxYkMJoa/1AoBf7sN9iTvHTtUpDbH88kgKZnpnV
 FvRSFPaTnH6fg98Qy3yA3k7UvISFlRFT4rb1FImD/ZLmorLdF+VNiJpSVU1HLzzVs7uncoIX/
 aMQh1qkxLo0DW1RLtFBQcb3q8hkx0s3VS0AUnB0I0JcVXSkgFh5l+3ro6WYjYbfAZvwL12mXe
 CWp8NH/X/fd2pXKITcmNRy34e84Aj3F+vkOtGOGpQ7Fri19EvOCrd1zmmaXLNrTRJ2/zeBjJh
 4fOWLLYGgtdgLHX2LgRQye69F+9oO/sH8kyxqj0uCoaS5F2tnY2C0i8pz8pyrfH4ERRt0p6zI
 FB/D8i2NsNHCeq4Caea7S9wM3VL/5oVUQ1bfYbpcFPJnkmuPUdWKbduxAxchZ4H7xemBVxL3c
 gKmtV7WWU2dIWHyVLXTRPuSVAKxHFPawzt4Sc9T0I0XJOE6SRIxcAbpkm9NAw9kopj/MepM9T
 K03W6ixIZpUj6FqYAwoK2ZhMkWeBgR+twnxpV1MeOA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The pwm-bcm2835 supports PWM polarity, so adjust the affected dtsi
files accordingly and fix the dtbs_check warning:

pwm@7e20c000: #pwm-cells:0:0: 3 was expected

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 arch/arm/boot/dts/bcm2711.dtsi | 2 +-
 arch/arm/boot/dts/bcm283x.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/bcm2711.dtsi b/arch/arm/boot/dts/bcm2711.dtsi
index d30c19311145..4a379a14966d 100644
--- a/arch/arm/boot/dts/bcm2711.dtsi
+++ b/arch/arm/boot/dts/bcm2711.dtsi
@@ -278,7 +278,7 @@ pwm1: pwm@7e20c800 {
 			clocks = <&clocks BCM2835_CLOCK_PWM>;
 			assigned-clocks = <&clocks BCM2835_CLOCK_PWM>;
 			assigned-clock-rates = <10000000>;
-			#pwm-cells = <2>;
+			#pwm-cells = <3>;
 			status = "disabled";
 		};
 
diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index c9c52a19ef3b..2ca8a2505a4d 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -416,7 +416,7 @@ pwm: pwm@7e20c000 {
 			clocks = <&clocks BCM2835_CLOCK_PWM>;
 			assigned-clocks = <&clocks BCM2835_CLOCK_PWM>;
 			assigned-clock-rates = <10000000>;
-			#pwm-cells = <2>;
+			#pwm-cells = <3>;
 			status = "disabled";
 		};
 
-- 
2.34.1

