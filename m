Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31E65368A6
	for <lists+dmaengine@lfdr.de>; Fri, 27 May 2022 23:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbiE0V5P (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 27 May 2022 17:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiE0V5O (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 27 May 2022 17:57:14 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1800863393
        for <dmaengine@vger.kernel.org>; Fri, 27 May 2022 14:57:13 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id a23so6223529ljd.9
        for <dmaengine@vger.kernel.org>; Fri, 27 May 2022 14:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TTkFFJWiGQsszaptj0zwEzjUmbbtBVgiZScQuKDSU+A=;
        b=JTu9/4vP8K290bnailpAakp45NIhtHVTymPXI203da08EDsUGlB77lT2Zwn7CmHK1b
         K3Jk78sReFb0N6ZsnbOL0Nnq7DpAX71BvCErtguWVRI5WwZxjrhYimnyly/+ptl9CNVX
         CPWSVSL9f5yGiP6VWxTNnM5Y1X2qIx1KKQJYONzoe52U9Q9EM3L473nQ2qn/tHdtdycJ
         9K6lcq5YrgVmNxymqVeWlEV+3huSATwj56QKrbzshpn9pUKRpPudltE4VmFz7QyRPZfK
         cv2adr4sMdZUQS2HPbpLz9ozT2A+mofbcwYwdUalYpN6DnrKann5dnh+HiOGRmhNvYuU
         jpfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TTkFFJWiGQsszaptj0zwEzjUmbbtBVgiZScQuKDSU+A=;
        b=mrzjHmpL1A6e6corC+grMSwvIeYcfnOkDu5WfBUeEFSEDBAiCk5YuswmuECfolDmsX
         N9Jsha2DI22OwYXLJsIFKEBaSGdaJSjTAzc4n8qyESUXwbF+wOPU5xquRsurrP/XvEen
         DeWeZ+HRzvkZY40EsBZlju/tIWJ5BkO2P1LAbgxM7gHYMGHUmcywFVkjjQdpvnncxWGu
         UU7TOVrJX1yYzbqklu2XhKdfiRyzgLkyANO3pDQ8W48sTvN7uvixG0Q4n108lm20se3w
         oXctgdz7o/zp/+wlJ1Kf+DYeGHyxYjiA9AHxMVsrliJ5YvtU5ApiMHqXV+7036Ng7Mh8
         v5nA==
X-Gm-Message-State: AOAM533NDaTgwyO0CAjmooR6PBc7BEFcx+Vvk55x+uS7YufZVYzJPdGp
        oXJT/Z3uniDSqXO5mC53XCvsvQ==
X-Google-Smtp-Source: ABdhPJxmyUBtcpLNRPm9IGYlwLl/0kWqngy9V3wAdhmQcZ6lsarjSkFMP724DvtIRIk8ulm08GbuWQ==
X-Received: by 2002:a2e:9d96:0:b0:253:e0cf:4be4 with SMTP id c22-20020a2e9d96000000b00253e0cf4be4mr21417642ljj.185.1653688631269;
        Fri, 27 May 2022 14:57:11 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id 29-20020a2e145d000000b0024f555d863csm1218100lju.135.2022.05.27.14.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 14:57:10 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: dma: Rewrite ST-Ericsson DMA40 to YAML
Date:   Fri, 27 May 2022 23:55:08 +0200
Message-Id: <20220527215508.622374-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This rewrites the ST-Ericsson DMA40 bindings in YAML.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../devicetree/bindings/dma/ste-dma40.txt     | 138 ---------------
 .../bindings/dma/stericsson,dma40.yaml        | 159 ++++++++++++++++++
 2 files changed, 159 insertions(+), 138 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/dma/ste-dma40.txt
 create mode 100644 Documentation/devicetree/bindings/dma/stericsson,dma40.yaml

diff --git a/Documentation/devicetree/bindings/dma/ste-dma40.txt b/Documentation/devicetree/bindings/dma/ste-dma40.txt
deleted file mode 100644
index 99ab5c4d331e..000000000000
--- a/Documentation/devicetree/bindings/dma/ste-dma40.txt
+++ /dev/null
@@ -1,138 +0,0 @@
-* DMA40 DMA Controller
-
-Required properties:
-- compatible: "stericsson,dma40"
-- reg: Address range of the DMAC registers
-- reg-names: Names of the above areas to use during resource look-up
-- interrupt: Should contain the DMAC interrupt number
-- #dma-cells: must be <3>
-- memcpy-channels: Channels to be used for memcpy
-
-Optional properties:
-- dma-channels: Number of channels supported by hardware - if not present
-		the driver will attempt to obtain the information from H/W
-- disabled-channels: Channels which can not be used
-
-Example:
-
-	dma: dma-controller@801c0000 {
-		compatible = "stericsson,db8500-dma40", "stericsson,dma40";
-		reg = <0x801C0000 0x1000  0x40010000 0x800>;
-		reg-names = "base", "lcpa";
-		interrupt-parent = <&intc>;
-		interrupts = <0 25 0x4>;
-
-		#dma-cells = <2>;
-		memcpy-channels  = <56 57 58 59 60>;
-		disabled-channels  = <12>;
-		dma-channels = <8>;
-	};
-
-Clients
-Required properties:
-- dmas: Comma separated list of dma channel requests
-- dma-names: Names of the aforementioned requested channels
-
-Each dmas request consists of 4 cells:
-  1. A phandle pointing to the DMA controller
-  2. Device signal number, the signal line for single and burst requests
-     connected from the device to the DMA40 engine
-  3. The DMA request line number (only when 'use fixed channel' is set)
-  4. A 32bit mask specifying; mode, direction and endianness
-     [NB: This list will grow]
-        0x00000001: Mode:
-                Logical channel when unset
-                Physical channel when set
-        0x00000002: Direction:
-                Memory to Device when unset
-                Device to Memory when set
-        0x00000004: Endianness:
-                Little endian when unset
-                Big endian when set
-        0x00000008: Use fixed channel:
-                Use automatic channel selection when unset
-                Use DMA request line number when set
-        0x00000010: Set channel as high priority:
-                Normal priority when unset
-                High priority when set
-
-Existing signal numbers for the DB8500 ASIC. Unless specified, the signals are
-bidirectional, i.e. the same for RX and TX operations:
-
-0:  SPI controller 0
-1:  SD/MMC controller 0 (unused)
-2:  SD/MMC controller 1 (unused)
-3:  SD/MMC controller 2 (unused)
-4:  I2C port 1
-5:  I2C port 3
-6:  I2C port 2
-7:  I2C port 4
-8:  Synchronous Serial Port SSP0
-9:  Synchronous Serial Port SSP1
-10: Multi-Channel Display Engine MCDE RX
-11: UART port 2
-12: UART port 1
-13: UART port 0
-14: Multirate Serial Port MSP2
-15: I2C port 0
-16: USB OTG in/out endpoints 7 & 15
-17: USB OTG in/out endpoints 6 & 14
-18: USB OTG in/out endpoints 5 & 13
-19: USB OTG in/out endpoints 4 & 12
-20: SLIMbus or HSI channel 0
-21: SLIMbus or HSI channel 1
-22: SLIMbus or HSI channel 2
-23: SLIMbus or HSI channel 3
-24: Multimedia DSP SXA0
-25: Multimedia DSP SXA1
-26: Multimedia DSP SXA2
-27: Multimedia DSP SXA3
-28: SD/MM controller 2
-29: SD/MM controller 0
-30: MSP port 1 on DB8500 v1, MSP port 3 on DB8500 v2
-31: MSP port 0 or SLIMbus channel 0
-32: SD/MM controller 1
-33: SPI controller 2
-34: i2c3 RX2 TX2
-35: SPI controller 1
-36: USB OTG in/out endpoints 3 & 11
-37: USB OTG in/out endpoints 2 & 10
-38: USB OTG in/out endpoints 1 & 9
-39: USB OTG in/out endpoints 8
-40: SPI controller 3
-41: SD/MM controller 3
-42: SD/MM controller 4
-43: SD/MM controller 5
-44: Multimedia DSP SXA4
-45: Multimedia DSP SXA5
-46: SLIMbus channel 8 or Multimedia DSP SXA6
-47: SLIMbus channel 9 or Multimedia DSP SXA7
-48: Crypto Accelerator 1
-49: Crypto Accelerator 1 TX or Hash Accelerator 1 TX
-50: Hash Accelerator 1 TX
-51: memcpy TX (to be used by the DMA driver for memcpy operations)
-52: SLIMbus or HSI channel 4
-53: SLIMbus or HSI channel 5
-54: SLIMbus or HSI channel 6
-55: SLIMbus or HSI channel 7
-56: memcpy (to be used by the DMA driver for memcpy operations)
-57: memcpy (to be used by the DMA driver for memcpy operations)
-58: memcpy (to be used by the DMA driver for memcpy operations)
-59: memcpy (to be used by the DMA driver for memcpy operations)
-60: memcpy (to be used by the DMA driver for memcpy operations)
-61: Crypto Accelerator 0
-62: Crypto Accelerator 0 TX or Hash Accelerator 0 TX
-63: Hash Accelerator 0 TX
-
-Example:
-
-	uart@80120000 {
-		compatible = "arm,pl011", "arm,primecell";
-		reg = <0x80120000 0x1000>;
-		interrupts = <0 11 0x4>;
-
-		dmas = <&dma 13 0 0x2>, /* Logical - DevToMem */
-		       <&dma 13 0 0x0>; /* Logical - MemToDev */
-		dma-names = "rx", "rx";
-
-	};
diff --git a/Documentation/devicetree/bindings/dma/stericsson,dma40.yaml b/Documentation/devicetree/bindings/dma/stericsson,dma40.yaml
new file mode 100644
index 000000000000..8bddfb3b6fa0
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/stericsson,dma40.yaml
@@ -0,0 +1,159 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/stericsson,dma40.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ST-Ericsson DMA40 DMA Engine
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+
+allOf:
+  - $ref: "dma-controller.yaml#"
+
+properties:
+  "#dma-cells":
+    const: 3
+    description: |
+      The first cell is the unique device channel number as indicated by this
+      table for DB8500 which is the only ASIC known to use DMA40:
+
+      0:  SPI controller 0
+      1:  SD/MMC controller 0 (unused)
+      2:  SD/MMC controller 1 (unused)
+      3:  SD/MMC controller 2 (unused)
+      4:  I2C port 1
+      5:  I2C port 3
+      6:  I2C port 2
+      7:  I2C port 4
+      8:  Synchronous Serial Port SSP0
+      9:  Synchronous Serial Port SSP1
+      10: Multi-Channel Display Engine MCDE RX
+      11: UART port 2
+      12: UART port 1
+      13: UART port 0
+      14: Multirate Serial Port MSP2
+      15: I2C port 0
+      16: USB OTG in/out endpoints 7 & 15
+      17: USB OTG in/out endpoints 6 & 14
+      18: USB OTG in/out endpoints 5 & 13
+      19: USB OTG in/out endpoints 4 & 12
+      20: SLIMbus or HSI channel 0
+      21: SLIMbus or HSI channel 1
+      22: SLIMbus or HSI channel 2
+      23: SLIMbus or HSI channel 3
+      24: Multimedia DSP SXA0
+      25: Multimedia DSP SXA1
+      26: Multimedia DSP SXA2
+      27: Multimedia DSP SXA3
+      28: SD/MMC controller 2
+      29: SD/MMC controller 0
+      30: MSP port 1 on DB8500 v1, MSP port 3 on DB8500 v2
+      31: MSP port 0 or SLIMbus channel 0
+      32: SD/MMC controller 1
+      33: SPI controller 2
+      34: i2c3 RX2 TX2
+      35: SPI controller 1
+      36: USB OTG in/out endpoints 3 & 11
+      37: USB OTG in/out endpoints 2 & 10
+      38: USB OTG in/out endpoints 1 & 9
+      39: USB OTG in/out endpoints 8
+      40: SPI controller 3
+      41: SD/MMC controller 3
+      42: SD/MMC controller 4
+      43: SD/MMC controller 5
+      44: Multimedia DSP SXA4
+      45: Multimedia DSP SXA5
+      46: SLIMbus channel 8 or Multimedia DSP SXA6
+      47: SLIMbus channel 9 or Multimedia DSP SXA7
+      48: Crypto Accelerator 1
+      49: Crypto Accelerator 1 TX or Hash Accelerator 1 TX
+      50: Hash Accelerator 1 TX
+      51: memcpy TX (to be used by the DMA driver for memcpy operations)
+      52: SLIMbus or HSI channel 4
+      53: SLIMbus or HSI channel 5
+      54: SLIMbus or HSI channel 6
+      55: SLIMbus or HSI channel 7
+      56: memcpy (to be used by the DMA driver for memcpy operations)
+      57: memcpy (to be used by the DMA driver for memcpy operations)
+      58: memcpy (to be used by the DMA driver for memcpy operations)
+      59: memcpy (to be used by the DMA driver for memcpy operations)
+      60: memcpy (to be used by the DMA driver for memcpy operations)
+      61: Crypto Accelerator 0
+      62: Crypto Accelerator 0 TX or Hash Accelerator 0 TX
+      63: Hash Accelerator 0 TX
+
+      The second cell is the DMA request line number. This is only used when
+      a fixed channel is allocated, and indicated by setting bit 3 in the
+      flags field (see below).
+
+      The third cell is a 32bit flags bitfield with the following possible
+      bits set:
+      0x00000001 (bit 0) - mode:
+        Logical channel when unset
+        Physical channel when set
+      0x00000002 (bit 1) - direction:
+        Memory to Device when unset
+        Device to Memory when set
+      0x00000004 (bit 2) - endianness:
+        Little endian when unset
+        Big endian when set
+      0x00000008 (bit 3) - use fixed channel:
+        Use automatic channel selection when unset
+        Use DMA request line number when set
+      0x00000010 (bit 4) - set channel as high priority:
+        Normal priority when unset
+        High priority when set
+
+  compatible:
+    items:
+      - const: stericsson,db8500-dma40
+      - const: stericsson,dma40
+
+  reg:
+    items:
+      - description: DMA40 memory base
+      - description: LCPA memory base
+
+  reg-names:
+    items:
+      - const: base
+      - const: lcpa
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  memcpy-channels:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: Array of u32 elements indicating which channels on the DMA
+      engine are elegible for memcpy transfers
+
+required:
+  - "#dma-cells"
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - memcpy-channels
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/mfd/dbx500-prcmu.h>
+    dma-controller@801C0000 {
+      compatible = "stericsson,db8500-dma40", "stericsson,dma40";
+      reg = <0x801C0000 0x1000>, <0x40010000 0x800>;
+      reg-names = "base", "lcpa";
+      interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+      #dma-cells = <3>;
+      memcpy-channels = <56 57 58 59 60>;
+      clocks = <&prcmu_clk PRCMU_DMACLK>;
+    };
+...
-- 
2.35.3

