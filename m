Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3260C73416F
	for <lists+dmaengine@lfdr.de>; Sat, 17 Jun 2023 15:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346127AbjFQNma (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 17 Jun 2023 09:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236455AbjFQNm1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 17 Jun 2023 09:42:27 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1E819A2;
        Sat, 17 Jun 2023 06:42:22 -0700 (PDT)
Received: from stefanw-SCHENKER ([37.4.248.58]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M2fDr-1q7UlX1Vhn-0048wI; Sat, 17 Jun 2023 15:36:44 +0200
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
        Stefan Wahren <stefan.wahren@i2se.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH V2 7/7] dt-bindings: timer: convert bcm2835-system-timer bindings to YAML
Date:   Sat, 17 Jun 2023 15:36:20 +0200
Message-Id: <20230617133620.53129-8-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230617133620.53129-1-stefan.wahren@i2se.com>
References: <20230617133620.53129-1-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:mVFiliFboW4LEd+X1TQBa6vvRmi7USdo/RW69BmRyNa/pJtjGzS
 tVQ6dwdnHEHr/ZHHezkQhqcYQeI6DcMTENVHZf6OczxoEATjvn8NKf1lIAxB1OpX4zWvY08
 1sP8GK5j5nAf4xocAOTABS5MDo/6bn++VaK84cFyxqD07Z80Bj2+pOq//rMnClwhW6nUT7s
 OL/kAvNBJ4QbODLW9ofkQ==
UI-OutboundReport: notjunk:1;M01:P0:inw7a/j3P4k=;k+yIdptIj0BhoNOoxCn068igPV4
 pOdv6vS4XPRfjQPY+0tiABzI5rL/li6o7aLPUKu0+vnm8sELegztndB4AWp6kSatbYEMVl/Rl
 dmofJCZDR+0nNYJ9IA2zvBFjwmKZJ5OuZfKbMf54zg4R6piKdgtKxhXpc5dm4pPql2k58PHVZ
 MMits6+0gfWFcw8fFgH6aKYjupSOMbvR491t7i7m5SQqtlS5Cj7eb6vcdFO06EFOo3w55uVVO
 8J5z1G5S+4GfED4nhRqqf94urrlTa5f+FqLnLMHF73PYePsrxL2WpIFbsVgYrTDYQk+4JUKH/
 9M19uFHpSDk96dBA8DOV9ktUAn1r5dnO/wH9Z+3ttGfXf/6pTlmhutwTuRH2t6D2r/5gm1TmX
 JoS8p5nbkFSJI659bjrpCLQZWTYSYA1/+BYsXm6R65xipi9S0hggFPy5ZwP+5cVo11d1XiZg9
 3onxo7vKD4LHGnh4XO6ErFtxx0pWJcOd81KBgamDmYK4mDiQCSMj6VdrEn0qCu0HsG70DNuly
 jIh1kUSbQQI5+fc+DT6/0cXStqt92tYgZ3JtJULUALmWsLBTcP4wlLXecp4zzsacdr26kbmYb
 nVYOgJAc/+f9OSjjr/h1Mb9pKaMbM6hvj/W/PhoGLVZyjdaR5RscxMlAxqEVlZNj8q59uUy5V
 A8XOBwuZyW1K2+/+sN8OspHzNhiHDiJMZdxhjJjkhQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Convert the DT binding document for bcm2835-system-timer from .txt
to YAML.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../timer/brcm,bcm2835-system-timer.txt       | 22 ---------
 .../timer/brcm,bcm2835-system-timer.yaml      | 48 +++++++++++++++++++
 2 files changed, 48 insertions(+), 22 deletions(-)
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
index 000000000000..227b44788a48
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/brcm,bcm2835-system-timer.yaml
@@ -0,0 +1,48 @@
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
+    items:
+      - description: System Timer Compare 0 match (used by VideoCore GPU)
+      - description: System Timer Compare 1 match (usable for ARM core)
+      - description: System Timer Compare 2 match (used by VideoCore GPU)
+      - description: System Timer Compare 3 match (usable for ARM core)
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

