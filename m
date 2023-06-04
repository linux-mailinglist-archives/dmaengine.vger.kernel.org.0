Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBCF37216BF
	for <lists+dmaengine@lfdr.de>; Sun,  4 Jun 2023 14:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbjFDMNc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 4 Jun 2023 08:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbjFDMN2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 4 Jun 2023 08:13:28 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E3913A;
        Sun,  4 Jun 2023 05:13:25 -0700 (PDT)
Received: from stefanw-SCHENKER ([37.4.248.58]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MYvLi-1parfS299k-00UseR; Sun, 04 Jun 2023 14:12:46 +0200
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
Subject: [PATCH 06/10] ARM: dts: bcm283x: Increase pwm-cells
Date:   Sun,  4 Jun 2023 14:12:19 +0200
Message-Id: <20230604121223.9625-7-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230604121223.9625-1-stefan.wahren@i2se.com>
References: <20230604121223.9625-1-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Ay9E1GOc/hVwhqqW+B2nos8Az5+GOBVwcX2XGQbjPiYWqWsvowg
 q1p7h8OQiAoT4f/pWfsqadTmYhWyZsW502ec0xUNLJCEVZNguwCoc1EHLcew251qly/P63j
 /Ch0om9DtfThmHWeiCvu75nDZDOGWbYIMjEJZlFxTTZjqsQDGZZEDGYDI5Fy44PhVTWNy2N
 bylzZawBR9NUqpWUenzlA==
UI-OutboundReport: notjunk:1;M01:P0:xK69g/38ndo=;YN0PURB2/gwSWuPHUPRS+xc01hv
 8tFg7cH60CtI4rBpwgfpRLAErmDRrIvC0v95mMjqsiDUsNhbENhTZltka04KxeY2SslrntzUr
 IXkAv/din40cmDNmAjZw/pE57o+Nvj+YYzonbG740Dtz3c3sXHizic7+AOQl/lwEs7pUOb1fz
 bxT+k34nJ0i6qIdgwnegD3K3HHmn/Dm7f27xCJZDU9Rb5V7vFHd2Wi9E3ET/RvjJKSM+j+rfD
 aAnQErNy3zMQ2rWiGccTUJ87htbhUjITXWAHCbuVTmXMoVbB9oRiVMwloQyeWXhcvSbA8glCP
 2o2jqYP+lSm8GaRMJ1qB/to5JK3OD/Q+R5Fpmvy0gQH611Mafen3LdM4tZ7RXjvWr6/4AesPp
 5a+adF8VOIko3uS96VKSi2BbWOK+dRsyybBw54XNUPu8SDhgRHP80Z0O1H8vjPL1easlWnELV
 r0xHi1SK+R1249+CC2+3x0jlfl6sb3zzcpLQc1uHjOvZbvPwgy+hYSHWDj1qv7+vx6NMfo36G
 dvrPvtFXH6Q1NMDc/5sxiOumvxEOvIZemE8ZtMY+S6QXoiuTVFJVX89viz9/rUpr2hgyTlVET
 SChzj7y4a08GZKeVxnkuqL9ymVQMGJATXOG9c0SO73h3fV8bS2LJ3nXzTvCreCRghhDUnm2qP
 jiatEHDANkw/Liib+lvlVM6H9G61FwgzinpEhTZTEw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The pwm-bcm2835 supports PWM polarity, so adjust the affected dtsi
files accordingly and fix the dtbs_check warning:

pwm@7e20c000: #pwm-cells:0:0: 3 was expected

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/bcm2711.dtsi | 2 +-
 arch/arm/boot/dts/bcm283x.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/bcm2711.dtsi b/arch/arm/boot/dts/bcm2711.dtsi
index 83745672a120..239db6927a02 100644
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

