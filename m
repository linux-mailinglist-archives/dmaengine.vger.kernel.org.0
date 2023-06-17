Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F070734155
	for <lists+dmaengine@lfdr.de>; Sat, 17 Jun 2023 15:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236398AbjFQNhO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 17 Jun 2023 09:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234607AbjFQNhM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 17 Jun 2023 09:37:12 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5B7DA;
        Sat, 17 Jun 2023 06:37:11 -0700 (PDT)
Received: from stefanw-SCHENKER ([37.4.248.58]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N7zJj-1q6GnA2pc3-0154nC; Sat, 17 Jun 2023 15:36:43 +0200
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
Subject: [PATCH V2 6/7] dt-bindings: mailbox: convert bcm2835-mbox bindings to YAML
Date:   Sat, 17 Jun 2023 15:36:19 +0200
Message-Id: <20230617133620.53129-7-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230617133620.53129-1-stefan.wahren@i2se.com>
References: <20230617133620.53129-1-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:BN/G7vW9/+OwrOJf64TGPnwW5YzRRIk27PgTlhcRzCSfc0brUlW
 ksBPxIXOOflP29UVRJOMrUXLvyz7paYxVQKtRebHImuLSZEQYMhW4HLut1gLnlP0nZjTlrz
 J+KXcOrxBNo2L2+aSHOU6bcKtRLFcb92XLDnjMNjC7c1k85gf2Xv4UwY4xK3kbWGxpBo7US
 o7UJRe9alQqQ9hyQfgzGw==
UI-OutboundReport: notjunk:1;M01:P0:EUvzvJRXwIs=;PHI27EI6rgPYtu1TJFYQ9ZkqTdl
 jmu3db43i6TwbJSn+BV2022WjElLQab0IsbgYi/5OE2HeCPbmSYa719xd8tI5287nZs8Xmmpg
 INyL2p7d8pYBzhiEhL0QP5mU32yfIP/oPPmrwGnX5nKjkeFftEcbSCjdeVDCh2sxUAbqOSkHN
 pf58TnJp+yI0WrF8Cfnv4kKqJhKnRTuAEtVVkc/Jo8+v1vhND1G074AXJ0tkA7qH/1ZuAHWto
 +JSnUBSZIf80+8iQ5R8RlIF0WqABRic2ZEFia4Sk2JqQHMmAw3b/5/47wL0lQhalyZd1BrKbs
 F4ctHvm7Z+eTESeRsX2FEocXdHK2Tx4kKlCL3FQhsDtlHPL+Z3JxTRZ+Mac5zk6oIhXxkwyfw
 tLmlHCftHDGZoN2+uezOeKNrnaackdD7N79BEzbGeiC01yFqY/B5f+C0hvyDnADhGVeFa8pWA
 VwtwRKcX8cajG5sfLVpuy0DlI5ZDAEIs3m2Bvogp41oIi/pOH1nNnho7a9f9Lg9bk9N10DceD
 ox2cTsAB2Fdkgdp//EEe64n0ZkIfMOhrlS54sSUzhjuxTLgwq0ab2i4Rpy4LGNhYAnB2a/San
 FkcvHTT/fimrd+ptx2z7SFkN5+8VNGFTKnpoJ3XqxowHBdzcBP+y6KhkhlSgwMNbd7i3uiTSg
 0Qvuqhj0b+AiDbWjvLRzK/8Lxolqe8ooJ5VklVoLpg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Convert the DT binding document for bcm2835-mbox from .txt to YAML.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 .../bindings/mailbox/brcm,bcm2835-mbox.txt    | 26 ------------
 .../bindings/mailbox/brcm,bcm2835-mbox.yaml   | 40 +++++++++++++++++++
 2 files changed, 40 insertions(+), 26 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mailbox/brcm,bcm2835-mbox.txt
 create mode 100644 Documentation/devicetree/bindings/mailbox/brcm,bcm2835-mbox.yaml

diff --git a/Documentation/devicetree/bindings/mailbox/brcm,bcm2835-mbox.txt b/Documentation/devicetree/bindings/mailbox/brcm,bcm2835-mbox.txt
deleted file mode 100644
index b48d7d30012c..000000000000
--- a/Documentation/devicetree/bindings/mailbox/brcm,bcm2835-mbox.txt
+++ /dev/null
@@ -1,26 +0,0 @@
-Broadcom BCM2835 VideoCore mailbox IPC
-
-Required properties:
-
-- compatible:	Should be "brcm,bcm2835-mbox"
-- reg:		Specifies base physical address and size of the registers
-- interrupts:	The interrupt number
-		  See bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt
-- #mbox-cells:	Specifies the number of cells needed to encode a mailbox
-		  channel. The value shall be 0, since there is only one
-		  mailbox channel implemented by the device.
-
-Example:
-
-mailbox: mailbox@7e00b880 {
-	compatible = "brcm,bcm2835-mbox";
-	reg = <0x7e00b880 0x40>;
-	interrupts = <0 1>;
-	#mbox-cells = <0>;
-};
-
-firmware: firmware {
-	compatible = "raspberrypi,firmware";
-	mboxes = <&mailbox>;
-	#power-domain-cells = <1>;
-};
diff --git a/Documentation/devicetree/bindings/mailbox/brcm,bcm2835-mbox.yaml b/Documentation/devicetree/bindings/mailbox/brcm,bcm2835-mbox.yaml
new file mode 100644
index 000000000000..9588817f4511
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/brcm,bcm2835-mbox.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mailbox/brcm,bcm2835-mbox.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom BCM2835 VideoCore mailbox IPC
+
+maintainers:
+  - Stefan Wahren <stefan.wahren@i2se.com>
+
+properties:
+  compatible:
+    const: brcm,bcm2835-mbox
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  "#mbox-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - "#mbox-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    mailbox@7e00b880 {
+      compatible = "brcm,bcm2835-mbox";
+      reg = <0x7e00b880 0x40>;
+      interrupts = <0 1>;
+      #mbox-cells = <0>;
+    };
-- 
2.34.1

