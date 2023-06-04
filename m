Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFC67216B2
	for <lists+dmaengine@lfdr.de>; Sun,  4 Jun 2023 14:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjFDMNb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 4 Jun 2023 08:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbjFDMN1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 4 Jun 2023 08:13:27 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB0BFA;
        Sun,  4 Jun 2023 05:13:23 -0700 (PDT)
Received: from stefanw-SCHENKER ([37.4.248.58]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MI4cT-1psFYU0nYt-00F8Q0; Sun, 04 Jun 2023 14:12:49 +0200
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
Subject: [PATCH 09/10] dt-bindings: thermal: convert bcm2835-thermal bindings to YAML
Date:   Sun,  4 Jun 2023 14:12:22 +0200
Message-Id: <20230604121223.9625-10-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230604121223.9625-1-stefan.wahren@i2se.com>
References: <20230604121223.9625-1-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:nMYk1gRGD+2AiImzkO6DtPOxKPY+MYA5ImlbZwhx4QpHbydnjwi
 sFqFSyvDUR+sI4OmmfBzssR2ybgas4BCOwvRshfr5mAz4rH/ZPsXIBe0MikVM0aRNTbhgjH
 34ndg/Gfi2TtUZrqMz9Oo4xR146EK/e1IQY0giLEQggJQAF3ogRwJBrdbNmVVC6W7Tf+CmQ
 3CEzDZjUQmwU9w6//7x9Q==
UI-OutboundReport: notjunk:1;M01:P0:AFBIMyp3Zyw=;qMpPxv3dGa4DbTK46rNrQprBpkF
 QHEiLJ3yBaYzi330gDjoYrsdsRzCvZdh0FmRbzELpn0pIJYYsapD6B4cHe9DzYg0ILeSrC2Tv
 d8RJmbv5GjPHsS8agmhchDhBoiEvIPlwZOUIAcCzryUlqx6BryQwNVEMK189HC9mbS5mV/lmZ
 FiqlpO3wwWW/4xZx0aeVN1+Z3PP6uz+riYr3WYjUWP5Go+lsM4SeErLYr4r2dJ2BGPUqhtHv6
 922VC4V8NroIiB9slXXaetiCnLtRBmcW+3XBA02YxCm7cpcGlqk+SXnWpYZVNaazNzelEKIYh
 MpmY8uQ4bLr9JFDWaSGp2pFRboqey14VyBwG9DemKcMnyy9QvhVumXXUgRcXiD/r4PR2l/f5x
 UcKW8ArZT5Hujnez4FYEv+dHdyipoE6TqONYz95dTJxM8XYWsMWQuqtF57uw/ym1xI1gTxWLr
 7Nbv89/hElqLUqpz1sLW/+OYS7i0KFgOShHED/V9OWaItxJdl9B4hcBCOIOihedH2Pr4qTe3W
 0sEyFKnBOY0bK/jHo6rJuZhXyl6Cy2bBOVWVyg+mwL3R2IYsYvZGn+/RlQH5ZGDCneOrE6WLP
 Cw08ETMd+Oa8FceXrFS8a0XDMt1APk/Uxg822co3FGblw0nedjBnB8gHMG/gWiXYkSwQUtNPK
 OH3JR6dpvnD3QBGoSL1Swk9tOF4LxMP7BUdCmfhMkQ==
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Convert the DT binding document for bcm2835-thermal from .txt to YAML.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 .../bindings/thermal/brcm,bcm2835-thermal.txt | 41 ----------------
 .../thermal/brcm,bcm2835-thermal.yaml         | 48 +++++++++++++++++++
 2 files changed, 48 insertions(+), 41 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/thermal/brcm,bcm2835-thermal.txt
 create mode 100644 Documentation/devicetree/bindings/thermal/brcm,bcm2835-thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/brcm,bcm2835-thermal.txt b/Documentation/devicetree/bindings/thermal/brcm,bcm2835-thermal.txt
deleted file mode 100644
index a3e9ec5dc7ac..000000000000
--- a/Documentation/devicetree/bindings/thermal/brcm,bcm2835-thermal.txt
+++ /dev/null
@@ -1,41 +0,0 @@
-Binding for Thermal Sensor driver for BCM2835 SoCs.
-
-Required parameters:
--------------------
-
-compatible: 		should be one of: "brcm,bcm2835-thermal",
-			"brcm,bcm2836-thermal" or "brcm,bcm2837-thermal"
-reg:			Address range of the thermal registers.
-clocks: 		Phandle of the clock used by the thermal sensor.
-#thermal-sensor-cells:	should be 0 (see Documentation/devicetree/bindings/thermal/thermal-sensor.yaml)
-
-Example:
-
-thermal-zones {
-	cpu_thermal: cpu-thermal {
-		polling-delay-passive = <0>;
-		polling-delay = <1000>;
-
-		thermal-sensors = <&thermal>;
-
-		trips {
-			cpu-crit {
-				temperature	= <80000>;
-				hysteresis	= <0>;
-				type		= "critical";
-			};
-		};
-
-		coefficients = <(-538)	407000>;
-
-		cooling-maps {
-		};
-	};
-};
-
-thermal: thermal@7e212000 {
-	compatible = "brcm,bcm2835-thermal";
-	reg = <0x7e212000 0x8>;
-	clocks = <&clocks BCM2835_CLOCK_TSENS>;
-	#thermal-sensor-cells = <0>;
-};
diff --git a/Documentation/devicetree/bindings/thermal/brcm,bcm2835-thermal.yaml b/Documentation/devicetree/bindings/thermal/brcm,bcm2835-thermal.yaml
new file mode 100644
index 000000000000..2b6026d9fbcf
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/brcm,bcm2835-thermal.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/brcm,bcm2835-thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom BCM2835 thermal sensor
+
+maintainers:
+  - Stefan Wahren <stefan.wahren@i2se.com>
+
+allOf:
+  - $ref: thermal-sensor.yaml#
+
+properties:
+  compatible:
+    enum:
+      - brcm,bcm2835-thermal
+      - brcm,bcm2836-thermal
+      - brcm,bcm2837-thermal
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  "#thermal-sensor-cells":
+    const: 0
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - '#thermal-sensor-cells'
+
+examples:
+  - |
+    #include <dt-bindings/clock/bcm2835.h>
+
+    thermal@7e212000 {
+      compatible = "brcm,bcm2835-thermal";
+      reg = <0x7e212000 0x8>;
+      clocks = <&clocks BCM2835_CLOCK_TSENS>;
+      #thermal-sensor-cells = <0>;
+    };
-- 
2.34.1

