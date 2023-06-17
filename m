Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9FA734147
	for <lists+dmaengine@lfdr.de>; Sat, 17 Jun 2023 15:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235778AbjFQNhJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 17 Jun 2023 09:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233241AbjFQNhH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 17 Jun 2023 09:37:07 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9170DA;
        Sat, 17 Jun 2023 06:37:05 -0700 (PDT)
Received: from stefanw-SCHENKER ([37.4.248.58]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M3DBd-1q6wnn1KRx-003ahw; Sat, 17 Jun 2023 15:36:42 +0200
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
Subject: [PATCH V2 4/7] dt-bindings: pwm: convert pwm-bcm2835 bindings to YAML
Date:   Sat, 17 Jun 2023 15:36:17 +0200
Message-Id: <20230617133620.53129-5-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230617133620.53129-1-stefan.wahren@i2se.com>
References: <20230617133620.53129-1-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:TYFuVqZD3jYtkk6+GD5UzcN2416fgXqjUg2mFaGJe6WHPTO7HPH
 7oEIfw5baV63U/v7VUx0ZmLTD0Boi51cYj9b962jzufJE4xE1lZo4v1mbPRcQh9zIacH8aJ
 R/2TXdcQ4FysRSsCfwbESdTPDpsgF23mqfQ1evY3a8f525ge+36+OejV6xoKw1gyLxDpxWk
 ujo9SJDRLTvDUnzCt4GAg==
UI-OutboundReport: notjunk:1;M01:P0:fhUkDUnOG2A=;JiD8inveuTdBC4Sifc1wUqYzewa
 sOlxnFzOJblh67R7ZAyUU9QH3YDDo13rT9JFwxqPnzNxhtbrjlqWUDxk2JHrjBZ/t8eLd4J7v
 GRMj9DveSXPwqCX9kL2jiEt02+TxxU5+alKcvDBfJKVFIw/UPVjwQpj+TG12xM2gQCxaTpTaS
 JM5pEwkWav2fxGs16tA1cHPbEX92yP1pC48dYYNPojyCCKyPuMd4mO+jAsTkATtHDC7eq0Yqv
 kZC+2s7VK+rl4n5eHRjurOR5ez5OZ9OX0VNUJ+Hwh/ES4KIe/OU1VLDBlpOFlLB0PArNn4FtX
 CePmKtKR6WdubRjWyjmP7bc5GLLhGkYntG7qGdKnwKrE3N2jZntzkJgVitrxCvMeMBewQxok6
 s3GUA0b8QS0Zd5g0vIYcDF497nRtFaXP9gNkxGM1ixYysWPtVMuRoqf/49YQkPGx6wxADHmBc
 jAPMtd6nJlsuNJ+F6+aYagEeU4TOivc0k3xiLh6cLYBk2v6BC2j7LLlFsVP4ZD2dQqNPpqDmJ
 uBjOP4aOybwCLlHAL521YHob6/rZb7aGDvY1FTqX8rHduN6f4+472cuPgJxN3vFviTahQSCmu
 HsOfqfdrpsBa/Zg0mvi5XcVuxddGhmB/0BzW9lE6PsDhdWO+4fdsStwgpi0KdTKyF/iCqcs91
 znVOcWSQ8FUpcMBO6NG+J1HobKqWg9vwEJa6uWqgDQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Convert the DT binding document for pwm-bcm2835 from .txt to YAML.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
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

