Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B037216B1
	for <lists+dmaengine@lfdr.de>; Sun,  4 Jun 2023 14:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbjFDMNa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 4 Jun 2023 08:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbjFDMN1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 4 Jun 2023 08:13:27 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3547DB;
        Sun,  4 Jun 2023 05:13:25 -0700 (PDT)
Received: from stefanw-SCHENKER ([37.4.248.58]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MLhwM-1po7By0Ya0-00HjUJ; Sun, 04 Jun 2023 14:12:50 +0200
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
Subject: [PATCH 10/10] dt-bindings: timer: convert bcm2835-system-timer bindings to YAML
Date:   Sun,  4 Jun 2023 14:12:23 +0200
Message-Id: <20230604121223.9625-11-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230604121223.9625-1-stefan.wahren@i2se.com>
References: <20230604121223.9625-1-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:oMr1lTfefQ7XSyP/6XiPy6FpM+TVqfrRR0B16B0MUjm0fmnsWJ9
 tXpqm4A8tBbCHLxJpHHVJam+o9XaRneH/yvew6r3hok0Oln6lu/xjV0oeAZYuwvBmg6Q3Og
 Yw9s7SjyFl5sAsxTyW4l2GJOER0A/jGMj13s2Bk2a7BkPNysFRc5ADTze+J+SR6UijgLaUJ
 CjXVFOYus+JCSVK6Zickg==
UI-OutboundReport: notjunk:1;M01:P0:3fgNAr6VTfc=;0X5GpLSO88Vwv0T2LGOU/vv/rFC
 apzcUSG1Umg593oEieEHm1Cspgd9S2BGndtOWJ8jTS0udRb9zbiQCt93rT/oSFv2ZB8hWhoP1
 ligzgL35FqamqGJ14zITAFDkWmcUycEEVrnArVkPhuBES+WFA+tgETzWWor6Ty1yyIoqAmKgD
 5EW1UqzI4FPaDy5jo0tCkyYdq+aCymSDTTQQl48XNCYAHyXfCRs75CFUTvo4cGD0QqvI8OoZS
 ZzBff+wrS2TknYHK6tzbvW4GJ0Uh7fV0Nq+qe1UjzXgzsIPyivRw5E6rBaxLEyp7Evmkc0sIA
 NyCVuy1qyb7KaUNe2mZos5GryPirvuceUjgPCItg6wddGxjLu7M94nLFeieq4kJ/1Ee27dLRA
 GvHKCS6bZhyynA0E8ncn8SY0ob+jl6eMIezQmRmOhygA/z9RHHVbH983iFygs2PYs9AGUwZ+P
 5M7SojbIWflmDMzpdySxIhBNDJPdPQDRDX4+s1iLY7AXbsGYqYL6/MVMBx96g5aWqOBgmxpOV
 dPf0qedK+gt2kotQCeZovS0651yTOYDdnTdiJDTuSahcz623FkV0jxemZMmiWqP7jEw90k7kC
 dkmjYL52sgz0rvWJs4PtAoNQpdYPK+E/Ky46ya+CTTQk+4+ngH41L0pkfQa+1deo+4LZ1A1ZZ
 pJ0nrEH15l2gen6cxgH0vco6jBe1pJEBRCSNEl+GPA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Convert the DT binding document for bcm2835-system-timer from .txt
to YAML.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 .../timer/brcm,bcm2835-system-timer.txt       | 22 ----------
 .../timer/brcm,bcm2835-system-timer.yaml      | 44 +++++++++++++++++++
 2 files changed, 44 insertions(+), 22 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/brcm,bcm2835-system-timer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/brcm,bcm2835-system-timer.yaml

diff --git a/Documentation/devicetree/bindings/timer/brcm,bcm2835-system-timer.txt b/Documentation/devicetree/bindings/timer/brcm,bcm2835-system-timer.txt
deleted file mode 100644
index 844bd5fbd04c..000000000000
--- a/Documentation/devicetree/bindings/timer/brcm,bcm2835-system-timer.txt
+++ /dev/null
@@ -1,22 +0,0 @@
-BCM2835 System Timer
-
-The System Timer peripheral provides four 32-bit timer channels and a
-single 64-bit free running counter. Each channel has an output compare
-register, which is compared against the 32 least significant bits of the
-free running counter values, and generates an interrupt.
-
-Required properties:
-
-- compatible : should be "brcm,bcm2835-system-timer"
-- reg : Specifies base physical address and size of the registers.
-- interrupts : A list of 4 interrupt sinks; one per timer channel.
-- clock-frequency : The frequency of the clock that drives the counter, in Hz.
-
-Example:
-
-timer {
-	compatible = "brcm,bcm2835-system-timer";
-	reg = <0x7e003000 0x1000>;
-	interrupts = <1 0>, <1 1>, <1 2>, <1 3>;
-	clock-frequency = <1000000>;
-};
diff --git a/Documentation/devicetree/bindings/timer/brcm,bcm2835-system-timer.yaml b/Documentation/devicetree/bindings/timer/brcm,bcm2835-system-timer.yaml
new file mode 100644
index 000000000000..555fca4897e7
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/brcm,bcm2835-system-timer.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/brcm,bcm2835-system-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: BCM2835 System Timer
+
+maintainers:
+  - Stefan Wahren <stefan.wahren@i2se.com>
+
+description:
+  The System Timer peripheral provides four 32-bit timer channels and a
+  single 64-bit free running counter. Each channel has an output compare
+  register, which is compared against the 32 least significant bits of the
+  free running counter values, and generates an interrupt.
+
+properties:
+  compatible:
+    const: brcm,bcm2835-system-timer
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 4
+
+  clock-frequency: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    timer@7e003000 {
+      compatible = "brcm,bcm2835-system-timer";
+      reg = <0x7e003000 0x1000>;
+      interrupts = <1 0>, <1 1>, <1 2>, <1 3>;
+      clock-frequency = <1000000>;
+    };
-- 
2.34.1

