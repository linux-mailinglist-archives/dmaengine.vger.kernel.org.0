Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8137216C4
	for <lists+dmaengine@lfdr.de>; Sun,  4 Jun 2023 14:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjFDMNd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 4 Jun 2023 08:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbjFDMNa (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 4 Jun 2023 08:13:30 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2E1E3;
        Sun,  4 Jun 2023 05:13:29 -0700 (PDT)
Received: from stefanw-SCHENKER ([37.4.248.58]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MBmI6-1ptdVR1w9U-00C7LT; Sun, 04 Jun 2023 14:12:45 +0200
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
Subject: [PATCH 05/10] dt-bindings: pwm: convert pwm-bcm2835 bindings to YAML
Date:   Sun,  4 Jun 2023 14:12:18 +0200
Message-Id: <20230604121223.9625-6-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230604121223.9625-1-stefan.wahren@i2se.com>
References: <20230604121223.9625-1-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:yEqjFtXc/3vGmTSJ7Dy2Z8p775o68ILE0NDuwSUWovXrpTHthm4
 FKr5gNBh7xasgmosXf5YxVHhdkWm9XJLb/gjD/NCM93yHuAn2oc+MbZn36mQEOhyiyYVp5b
 8he2l2knb/bZlBQMolO6Nc2WJqnUIl9OgzIyJ84oR++6vQEA0K2SiW/HCxcstvBUV/QE6Fo
 A7TZp7Q7AdvNk5Gm6fQWQ==
UI-OutboundReport: notjunk:1;M01:P0:H0tTJbhnCxM=;5C7Ip//JOF9H88HOGXhCQghs37M
 +2AOYrTihZ9ogAa1Ld5EC4aM/ovwSFqOt3HWhh1WE6Y/4rFyQEnL6JBzbE+d2Fnx2HJr7DtpM
 zgRnuJdbtDrX+EKVIHG8WZ/j6COsghNMrJCK8YjaONRDPjSrlnDpOy4Ge+zWRXlKiokW8gOdG
 kAKkWECaBUYN75zKL/rOcJvH4jhrPIivMWD3UG1UkLCaYb9mLSKTz772MIqmzcHrlX5kXbl5q
 PLm5K49yHrVqAm+/0grw0cdAk5WC4UDDSVPY5UUU+LSWBV+vLxf6NrrUEtOrlImJd56X6K8In
 ruldsRb13XcA5MscluhQfHzFbY5ts0RaPxuh1NRNy1MHbwCAT2H689XX4DCLkgCYvNaWy8GUG
 moD29tyADPmIX7hd6x42HsnC6wQLOraKaqqM0FojfHnZOxQLSabAPgmcJqA3LyymN/Q3cs+qg
 i/m7rTpcqiDPjP+4nocPwLq+iRSolvb1dDQSrAzgjVmLZkYCAtbcngL1VoyVYdMVonmjqLcUN
 9MtNipE9vkwJEGkgeuwm6WIoO41dnB9wBAmZ5KRBRG9P4Ss2iqlWCWKfM6gejwKnH6jZ2dBIf
 WxAJKepGsIHkGpESWOqN6fFV5ypOiPfiSrCRXeDYFeXgs7a6cFH0QxblcwZs4+fs/UMqjRwFM
 Rr684lCeLd9artVpCgO9t/ReWce0Ls2xbzr9Kg1JCw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Convert the DT binding document for pwm-bcm2835 from .txt to YAML.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 .../devicetree/bindings/pwm/pwm-bcm2835.txt   | 30 -------------
 .../devicetree/bindings/pwm/pwm-bcm2835.yaml  | 43 +++++++++++++++++++
 2 files changed, 43 insertions(+), 30 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-bcm2835.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-bcm2835.yaml

diff --git a/Documentation/devicetree/bindings/pwm/pwm-bcm2835.txt b/Documentation/devicetree/bindings/pwm/pwm-bcm2835.txt
deleted file mode 100644
index f5753b3f79df..000000000000
--- a/Documentation/devicetree/bindings/pwm/pwm-bcm2835.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-BCM2835 PWM controller (Raspberry Pi controller)
-
-Required properties:
-- compatible: should be "brcm,bcm2835-pwm"
-- reg: physical base address and length of the controller's registers
-- clocks: This clock defines the base clock frequency of the PWM hardware
-  system, the period and the duty_cycle of the PWM signal is a multiple of
-  the base period.
-- #pwm-cells: Should be 3. See pwm.yaml in this directory for a description of
-  the cells format.
-
-Examples:
-
-pwm@2020c000 {
-	compatible = "brcm,bcm2835-pwm";
-	reg = <0x2020c000 0x28>;
-	clocks = <&clk_pwm>;
-	#pwm-cells = <3>;
-};
-
-clocks {
-	....
-		clk_pwm: pwm {
-			compatible = "fixed-clock";
-			reg = <3>;
-			#clock-cells = <0>;
-			clock-frequency = <9200000>;
-		};
-	....
-};
diff --git a/Documentation/devicetree/bindings/pwm/pwm-bcm2835.yaml b/Documentation/devicetree/bindings/pwm/pwm-bcm2835.yaml
new file mode 100644
index 000000000000..15e7fd98defc
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-bcm2835.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/pwm-bcm2835.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: BCM2835 PWM controller (Raspberry Pi controller)
+
+maintainers:
+  - Stefan Wahren <stefan.wahren@i2se.com>
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    const: brcm,bcm2835-pwm
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 3
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - "#pwm-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    pwm@2020c000 {
+      compatible = "brcm,bcm2835-pwm";
+      reg = <0x2020c000 0x28>;
+      clocks = <&clk_pwm>;
+      #pwm-cells = <3>;
+    };
-- 
2.34.1

