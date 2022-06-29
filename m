Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3C3560966
	for <lists+dmaengine@lfdr.de>; Wed, 29 Jun 2022 20:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbiF2Sos (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Jun 2022 14:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbiF2Son (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 29 Jun 2022 14:44:43 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B277255B2
        for <dmaengine@vger.kernel.org>; Wed, 29 Jun 2022 11:44:42 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id g39-20020a05600c4ca700b003a03ac7d540so169872wmp.3
        for <dmaengine@vger.kernel.org>; Wed, 29 Jun 2022 11:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lrMawgZzQlWfxvBPxcN2X1PdlhBSF2KCk9YZdZ5lbYA=;
        b=UZFE16ya+AhstVdc8+8PMjE1GOjuS02LHwYmtTTvWlnaw0JNzT8UivtB0HUSn2Fehs
         UcO/Kh8301nI9Y236WXJxSTARpOq9aANariOPe4TPKATPB706htP3/Hm8gLciQ6UUFto
         ZkfbHRvMtF6PrR8hyQ8v/olYBu0GD8fKKimD7yS7a/YvhUyrh/0svjksmlGJqrAcRCkj
         zI1gYBorCLXs9cJyTjmOhRaEHYhEM9zJQWx/dxjB3LUZk9Q/1bfk28AF94NfENY9bUQ9
         bHoitafl7IPZo20bQoU6rZfgzGh3/7bSGBIryzeQg9yuXosCnzERLniwu/VmzUrE7u47
         aYrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lrMawgZzQlWfxvBPxcN2X1PdlhBSF2KCk9YZdZ5lbYA=;
        b=MmM/N/CBtPtRYfTvRIrEgIh/yfDBeffoUx++Zk3JhkkL5Qwz78M0dAFYTJmffseJit
         rfbpJT3DAq/GaQFFTbe8pVB25vFfDD/mPtdldRLuEbAXgNiY/BOQZTcFaQr03pyNcbJZ
         Tyx4/Y3Ud8u3oMJt+EXLxHjKLoQLydSfpJU3x9oAmT16Y6ENqAGOOSLAoPy3EgC6qVd8
         ksqBph9RTHGQ7uwdyeG2KKcpfrDVtCsRcG9a2qv0SRlevKXPwrteRUe+WTRQx+AAZulj
         9D8f0HAQqfwkA9E8H86w1IQurn1Patp/EH26OIurvDyQl2xnDPFoSiuNoRuoG6xiu9sb
         9HmQ==
X-Gm-Message-State: AJIora9uSQA+OBDm1lbjZWT9rYEyTSVRzwJy6w/jemMHq12MVZm2gUTp
        vrFDLcCfApwSGktal0X+gtiC2g==
X-Google-Smtp-Source: AGRyM1spM09NZGEglzK2GcCvBNzf6+IwTXB36BnCjHt1M/6JzCPwKo0eKihFk+O4Q05Ie7dCQ7fFbg==
X-Received: by 2002:a7b:c242:0:b0:3a0:3ba5:81fd with SMTP id b2-20020a7bc242000000b003a03ba581fdmr7196335wmj.47.1656528281039;
        Wed, 29 Jun 2022 11:44:41 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id u23-20020a7bcb17000000b0039aef592ca0sm3834371wmj.35.2022.06.29.11.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 11:44:40 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Dillon Min <dillon.minfei@gmail.com>,
        Jose Abreu <joabreu@synopsys.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v3 03/15] ASoC: dt-bindings: convert designware-i2s to dt-schema
Date:   Wed, 29 Jun 2022 19:43:32 +0100
Message-Id: <20220629184343.3438856-4-mail@conchuod.ie>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220629184343.3438856-1-mail@conchuod.ie>
References: <20220629184343.3438856-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

Convert the Synopsys DesignWare I2S controller binding to dt-schema.
There was no listed maintainer but Jose Abreu was the last editor of the
txt binding so add him as maintainer.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/sound/designware-i2s.txt         | 35 -------
 .../bindings/sound/snps,designware-i2s.yaml   | 94 +++++++++++++++++++
 2 files changed, 94 insertions(+), 35 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/designware-i2s.txt
 create mode 100644 Documentation/devicetree/bindings/sound/snps,designware-i2s.yaml

diff --git a/Documentation/devicetree/bindings/sound/designware-i2s.txt b/Documentation/devicetree/bindings/sound/designware-i2s.txt
deleted file mode 100644
index 6a536d570e29..000000000000
--- a/Documentation/devicetree/bindings/sound/designware-i2s.txt
+++ /dev/null
@@ -1,35 +0,0 @@
-DesignWare I2S controller
-
-Required properties:
- - compatible : Must be "snps,designware-i2s"
- - reg : Must contain the I2S core's registers location and length
- - clocks : Pairs of phandle and specifier referencing the controller's
-   clocks. The controller expects one clock: the clock used as the sampling
-   rate reference clock sample.
- - clock-names : "i2sclk" for the sample rate reference clock.
- - dmas: Pairs of phandle and specifier for the DMA channels that are used by
-   the core. The core expects one or two dma channels: one for transmit and
-   one for receive.
- - dma-names : "tx" for the transmit channel, "rx" for the receive channel.
-
-Optional properties:
- - interrupts: The interrupt line number for the I2S controller. Add this
-   parameter if the I2S controller that you are using does not support DMA.
-
-For more details on the 'dma', 'dma-names', 'clock' and 'clock-names'
-properties please check:
-	* resource-names.txt
-	* clock/clock-bindings.txt
-	* dma/dma.txt
-
-Example:
-
-	soc_i2s: i2s@7ff90000 {
-		compatible = "snps,designware-i2s";
-		reg = <0x0 0x7ff90000 0x0 0x1000>;
-		clocks = <&scpi_i2sclk 0>;
-		clock-names = "i2sclk";
-		#sound-dai-cells = <0>;
-		dmas = <&dma0 5>;
-		dma-names = "tx";
-	};
diff --git a/Documentation/devicetree/bindings/sound/snps,designware-i2s.yaml b/Documentation/devicetree/bindings/sound/snps,designware-i2s.yaml
new file mode 100644
index 000000000000..4b0795819064
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/snps,designware-i2s.yaml
@@ -0,0 +1,94 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/snps,designware-i2s.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: DesignWare I2S controller
+
+maintainers:
+  - Jose Abreu <joabreu@synopsys.com>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: canaan,k210-i2s
+          - const: snps,designware-i2s
+      - enum:
+          - snps,designware-i2s
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description: |
+      The interrupt line number for the I2S controller. Add this
+      parameter if the I2S controller that you are using does not
+      support DMA.
+    maxItems: 1
+
+  clocks:
+    description: Sampling rate reference clock
+    maxItems: 1
+
+  clock-names:
+    const: i2sclk
+
+  resets:
+    maxItems: 1
+
+  dmas:
+    items:
+      - description: TX DMA Channel
+      - description: RX DMA Channel
+    minItems: 1
+
+  dma-names:
+    items:
+      - const: tx
+      - const: rx
+    minItems: 1
+
+if:
+  properties:
+    compatible:
+      contains:
+        const: canaan,k210-i2s
+
+then:
+  properties:
+    "#sound-dai-cells":
+      const: 1
+
+else:
+  properties:
+    "#sound-dai-cells":
+      const: 0
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+
+oneOf:
+  - required:
+      - dmas
+      - dma-names
+  - required:
+      - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    soc_i2s: i2s@7ff90000 {
+      compatible = "snps,designware-i2s";
+      reg = <0x7ff90000 0x1000>;
+      clocks = <&scpi_i2sclk 0>;
+      clock-names = "i2sclk";
+      #sound-dai-cells = <0>;
+      dmas = <&dma0 5>;
+      dma-names = "tx";
+    };
-- 
2.36.1

