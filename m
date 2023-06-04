Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529637216AB
	for <lists+dmaengine@lfdr.de>; Sun,  4 Jun 2023 14:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbjFDMN3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 4 Jun 2023 08:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbjFDMN0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 4 Jun 2023 08:13:26 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD9ADF;
        Sun,  4 Jun 2023 05:13:22 -0700 (PDT)
Received: from stefanw-SCHENKER ([37.4.248.58]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MORVA-1pgvvi1H4g-00PxEL; Sun, 04 Jun 2023 14:12:48 +0200
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
Subject: [PATCH 08/10] dt-bindings: mmc: convert bcm2835-sdhost bindings to YAML
Date:   Sun,  4 Jun 2023 14:12:21 +0200
Message-Id: <20230604121223.9625-9-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230604121223.9625-1-stefan.wahren@i2se.com>
References: <20230604121223.9625-1-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:foogFTxftYvxx0yiHrFE16uks19QrCnC8HH3ae90EqYe99lsUrJ
 0V1Ex5ERGkktRr5VKMfruARlqiTli4OCKIgdmgyyKGDyMDGmtiNRqvsC7zh4v1lCkeDzOgg
 dRL0KiBp28PmlWQX0cK9C12X7tVsj5Wr8UIBmSH04Z0w+QtkfZmiRRd0MplQX6P6GvxiOmC
 skP4ftc3f1GmijzExRr8w==
UI-OutboundReport: notjunk:1;M01:P0:FYmh3L5uoWE=;+L6An8kNOoyMWyRK1uZ2fyOwVVi
 x7rg4AZbBz/oFY77feJ0cDnQeVECPvGSZzRyuOCoAWPnLPKXNkV1TlfOY7hQYjJxb1v1gJgzl
 Wc+V4OUWocJbyzyXP/lon16MVPCRyiveYvONFVv3lnBGGxFjnRhVY2929AHRImEt2AbPh6fBz
 9AcSjJ/Ah0+Liec7qhp4Ae7noFbuiDsOiDN0jOmcw+mReRxl/1lUhzYohGFFtX3eGN0tE1cAX
 h6POHKSN5HuyAO/tn7c3LpwU1kkLfC7XmWMEWVRJNJAaWo2NXKQkM1h3pxISJWlwqnNjwiQmF
 IeFBcHQRB38SWTJ1yTGyh1UBajqWUydyszbQq4BeyNffHeJ7xO1VhxnOpvRIkqE/W041TAA+H
 5VEEMIbRH1SWiso/urkCdPVft1dKpze8WjefqWcOwUhdNFuCv/kk0u1D342KErklWJIJB/Uls
 s6WwzOg7VU/VI3RqErSL4RuVOVXt3nXRf9v0HcQIgIAAp2hnD0Lkykd8RIGkyPM0uyKaNmFVM
 yBkjifKX7JtvMh+qxt+iXqsmvk/hmHo6tPv7FuVma2lnwlH1HZJZ9Ibn3oEFbo1SRfKPk8Sqx
 1Ew2DhLHjExfWKYDeCLXzUWhACCucwjJcsCDzmKzugkwvuWZm5DfK6B0qKMCyL3MMSbP7xCO0
 A0LUSpgVXoUPhrg+Ph/PhCcYwwpegDySaeEkiX/Lsg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Convert the DT binding document for bcm2835-sdhost from .txt to YAML.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 .../bindings/mmc/brcm,bcm2835-sdhost.txt      | 23 --------
 .../bindings/mmc/brcm,bcm2835-sdhost.yaml     | 54 +++++++++++++++++++
 2 files changed, 54 insertions(+), 23 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mmc/brcm,bcm2835-sdhost.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/brcm,bcm2835-sdhost.yaml

diff --git a/Documentation/devicetree/bindings/mmc/brcm,bcm2835-sdhost.txt b/Documentation/devicetree/bindings/mmc/brcm,bcm2835-sdhost.txt
deleted file mode 100644
index d876580ae3b8..000000000000
--- a/Documentation/devicetree/bindings/mmc/brcm,bcm2835-sdhost.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-Broadcom BCM2835 SDHOST controller
-
-This file documents differences between the core properties described
-by mmc.txt and the properties that represent the BCM2835 controller.
-
-Required properties:
-- compatible: Should be "brcm,bcm2835-sdhost".
-- clocks: The clock feeding the SDHOST controller.
-
-Optional properties:
-- dmas: DMA channel for read and write.
-          See Documentation/devicetree/bindings/dma/dma.txt for details
-
-Example:
-
-sdhost: mmc@7e202000 {
-	compatible = "brcm,bcm2835-sdhost";
-	reg = <0x7e202000 0x100>;
-	interrupts = <2 24>;
-	clocks = <&clocks BCM2835_CLOCK_VPU>;
-	dmas = <&dma 13>;
-	dma-names = "rx-tx";
-};
diff --git a/Documentation/devicetree/bindings/mmc/brcm,bcm2835-sdhost.yaml b/Documentation/devicetree/bindings/mmc/brcm,bcm2835-sdhost.yaml
new file mode 100644
index 000000000000..3a5a44800675
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/brcm,bcm2835-sdhost.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/brcm,bcm2835-sdhost.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom BCM2835 SDHOST controller
+
+maintainers:
+  - Stefan Wahren <stefan.wahren@i2se.com>
+
+allOf:
+  - $ref: mmc-controller.yaml
+
+properties:
+  compatible:
+    const: brcm,bcm2835-sdhost
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  dmas:
+    maxItems: 1
+
+  dma-names:
+    const: rx-tx
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/bcm2835.h>
+
+    sdhost: mmc@7e202000 {
+      compatible = "brcm,bcm2835-sdhost";
+      reg = <0x7e202000 0x100>;
+      interrupts = <2 24>;
+      clocks = <&clocks BCM2835_CLOCK_VPU>;
+      dmas = <&dma 13>;
+      dma-names = "rx-tx";
+      bus-width = <4>;
+    };
-- 
2.34.1

