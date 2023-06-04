Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA4572169B
	for <lists+dmaengine@lfdr.de>; Sun,  4 Jun 2023 14:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbjFDMN1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 4 Jun 2023 08:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbjFDMNZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 4 Jun 2023 08:13:25 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BA8DC;
        Sun,  4 Jun 2023 05:13:21 -0700 (PDT)
Received: from stefanw-SCHENKER ([37.4.248.58]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mjjvp-1qUtfQ1qzT-00lBNY; Sun, 04 Jun 2023 14:12:47 +0200
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
Subject: [PATCH 07/10] dt-bindings: mailbox: convert bcm2835-mbox bindings to YAML
Date:   Sun,  4 Jun 2023 14:12:20 +0200
Message-Id: <20230604121223.9625-8-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230604121223.9625-1-stefan.wahren@i2se.com>
References: <20230604121223.9625-1-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:s9bqnOjBvZVCsDcyHb08k0nMCZ7YVUD8Zw1OzqniAuKGjhTPZKf
 rpBfQJ3D6yT29NzeLHRWuKxFV8oD/cm3Wl4OdqRGRi0EG/4QwcLM6oPiXLq2Fihww/laM5M
 msjMkQdDTZ1VHJUD709v3+c4NytU68OPdJvB0NjGNzKr3YXOmYp8cF3U+vM44aujBXGw/Jt
 /NVJMGpfQ+BZ6n9uW4FaQ==
UI-OutboundReport: notjunk:1;M01:P0:4yU37JCi/f8=;BE+D+f70115NohCmZRFqLmk4xoG
 /Jug1/zF1OIgoRntxGJnLtSi06FetwUFpoOQghme3GIXzunnILiywTzf7l4hA9G9Lh4Kulypc
 WyjZpRdH1Sh2jjouHSKajaVu8U39LCnMw1gt80uMEedbrEpxoAZZo3FGMyzi1A8RxlO87+8qL
 tF2rxU+wDVZfeoem1hc2Xw06QUflUh1qp8tu3x6FFht60wMngAEOL8hluIio45n7c1QMU1S58
 FYat5mBpP91tY9wo98UQ14Xtme1ytmKFgAAt1WpJSTCH/Bu0SphBnoggAKZOjSEVAQGfWaroM
 U5bVcQuoz3mESDHJQ27Nw6Sq+/8lCtTzBsLTdZGju/yf0+buT/cpRxJEnQ2X0gSRSkf8GoM8w
 XLr0pnBNh97NvdXsFqGrIxM1NeEt0b0jaVY/LpgsNDNu5KplxgVL5sGzKDXylJSy+TL1X/IBH
 LOaIBl1NBDWAiDdaCmtRCj8xvlrtKbN4TS1lVnqadF4rFmcCjqKtYYVKb5aK23JvTRNtA/kUB
 4/o5MqYFibWw362xhIjqd9q0HLBK5UngGzuskE7V36unDmzkrUBf3MSneGNdmSZNhBx6vWfi7
 VRmSzXmz+w27U2EuShu+LOa7mKhWD3M0UuLOwdc9pYfijWctwHbo8uC1svAjLDEj9bU4Zsk3y
 596p4X0Cdao9P3Dbk/C0LXysGd5ff0L6mCk0hsgkTg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

