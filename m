Return-Path: <dmaengine+bounces-2623-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2833A9279D1
	for <lists+dmaengine@lfdr.de>; Thu,  4 Jul 2024 17:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D179B28290D
	for <lists+dmaengine@lfdr.de>; Thu,  4 Jul 2024 15:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD26B1B0108;
	Thu,  4 Jul 2024 15:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKNCx/0K"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9ACC1AED21;
	Thu,  4 Jul 2024 15:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720106295; cv=none; b=kq5sB5KegC3MD1VibK7jtRojPckA/zsTzlMedp7unQcVptG7p3bxLFwG20Q0VQQjc3P6p3fQodgxCphw1RnLB1iY93/ce1TDXvR/KjLfh0dP7Fr8vQmKUrklAtLQk4p6FTACqi3BpeD/efuxC/qgQHJ/sL2tfOH4CIP+/4W7XYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720106295; c=relaxed/simple;
	bh=8ntllYaKa6d9xBl+TeVwYUVXMLN9YI/S3tM52qkEd7c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dOBML6VJ/GQe1lYxpdTEJi+8FgzsJ5mTB6s+FRwvV9MyZ9bLe4IyK87DJe6newx63d5wEQlR7gPJ5UqNwWbDdRcm8ShiXhbx7m+JHUXpgU3Fq1ZMNbHlQSCZpkraBDo3n18p2TBxpCE2WGj60Ed/C7MbDDIBrEuLhBPN4R04FVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BKNCx/0K; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ee7885aa5fso7808321fa.1;
        Thu, 04 Jul 2024 08:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720106292; x=1720711092; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=40CvHXXsQPeuesSUVpIVWndQJcWkhp14iToEHWAsuQ8=;
        b=BKNCx/0Kf8dTx4DDZZGu64Z5iOGbcz9M4yf3TICdTqOpZAYfa8nLK2q/UmZnyU0oB5
         WM7mJfXN1Hz58AdCLlzbNsk64aJTPlLtIRESFv6Fa/reZLe6WLKrWMSdCzHCsJc1hz7z
         urEgibuk2bHgJBBb+y3WbmqPABCb5P/MnwEE7Q3VwbBo3quGEuVxLtS0ZDe2q+jxfJ31
         IMF8kGmw161w2JaMYFvyFQrZs7FxBVLkpxhFfO7oYu7TvH3+P4V5OSbhWUNgZbYYWHds
         n9cOiouHQ3zdMDrDY1LWNwnQKlaBQvDSpTj7DoXvr8K8Q6Lw1WXTaYYHBmGqQzPZ0OY4
         Df6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720106292; x=1720711092;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=40CvHXXsQPeuesSUVpIVWndQJcWkhp14iToEHWAsuQ8=;
        b=jVIpvVKm6VvANbauVJa/aJms2tWfnkkkNW46UjufJ5JRAHNJEHwsMBeFS9qX0jSuQ8
         z55hy49rxsSiohZlGpWozI7Hr1UQaHwxXyJ1LhkVjeg0donLBGH5cESnBc6j6ioMdzr8
         HjCjCfK9ZJ/98IU7uxyRB7cFMqC2Vf/zh9KEqFHtjaKcZ1nn6xrRie0DBWeEq0miiTpz
         jM69VsURe92QaDFeDaNsMEX1Lo1eIWTmO/Q+HsXefZxQMXtKnRGmI9IwdsUI+rRMa15N
         W+I7gmoRsEX9nhKku6nUJNtIjiEzNJK8JrvKgQ3IOUKgWh7BTg8Q26Fqb3LEPU/51F0x
         NzVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIU14K5xDVfrcyJ26We4b+dZI1cGNU+6oGOJYHh8vBTdWEXBhYdwu/eBiLQUBKrcuS1HM9Ywmxh8iIiJw1+MHPMzCYyA9g2g9k1vaGuvnOppkawYXSZlesBk1IeiZDyTc9imN7ubVjTw==
X-Gm-Message-State: AOJu0YzTKM6rIp7Tb2ypKB5oUn4kBKmVwqWu/ijm930zH452SS+3oFqm
	1X3hVSQySkhPt3ZxunxiihsO7a74vH2OCjGfj9yUMUDzeIuViuHP
X-Google-Smtp-Source: AGHT+IF/lUMrIea0dxlcR4IrKB7HH5WFyi9+huVCzYZCBDL5FV1VRMkBT826Q1LFT2E4ZQpGOU5zCw==
X-Received: by 2002:a2e:8187:0:b0:2ee:4e67:85ec with SMTP id 38308e7fff4ca-2ee8ed5ee05mr13057891fa.5.1720106291574;
        Thu, 04 Jul 2024 08:18:11 -0700 (PDT)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3679224d11dsm4702550f8f.12.2024.07.04.08.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 08:18:11 -0700 (PDT)
Date: Thu, 4 Jul 2024 17:18:09 +0200
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Baolin Wang <baolin.wang7@gmail.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: dma: sprd,sc9860-dma: convert to YAML
Message-ID: <Zoa9MfYsAuqgh2Vb@standask-GA-A55M-S2HP>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Convert the Spreadtrum SC9860 DMA bindings to DT schema.

Changes during conversion:
  - rename file to match compatible
  - make interrupts optional, the AGCP DMA controller doesn't need it
  - describe the optional ashb_eb clock for the AGCP DMA controller

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
 .../bindings/dma/sprd,sc9860-dma.yaml         | 92 +++++++++++++++++++
 .../devicetree/bindings/dma/sprd-dma.txt      | 44 ---------
 2 files changed, 92 insertions(+), 44 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/sprd,sc9860-dma.yaml
 delete mode 100644 Documentation/devicetree/bindings/dma/sprd-dma.txt

diff --git a/Documentation/devicetree/bindings/dma/sprd,sc9860-dma.yaml b/Documentation/devicetree/bindings/dma/sprd,sc9860-dma.yaml
new file mode 100644
index 000000000000..e1639593d26d
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/sprd,sc9860-dma.yaml
@@ -0,0 +1,92 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/sprd,sc9860-dma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Spreadtrum SC9860 DMA controller
+
+description: |
+  There are three DMA controllers: AP DMA, AON DMA and AGCP DMA. For AGCP
+  DMA controller, it can or do not request the IRQ, which will save
+  system power without resuming system by DMA interrupts if AGCP DMA
+  does not request the IRQ.
+
+maintainers:
+  - Orson Zhai <orsonzhai@gmail.com>
+  - Baolin Wang <baolin.wang7@gmail.com>
+  - Chunyan Zhang <zhang.lyra@gmail.com>
+
+properties:
+  compatible:
+    const: sprd,sc9860-dma
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    oneOf:
+      - const: enable
+      # The ashb_eb clock is optional and only for AGCP DMA controller
+      - items:
+          - const: enable
+          - const: ashb_eb
+
+  '#dma-cells':
+    const: 1
+
+  dma-channels:
+    const: 32
+
+  '#dma-channels':
+    const: 32
+    deprecated: true
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - '#dma-cells'
+  - dma-channels
+
+allOf:
+  - $ref: dma-controller.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/sprd,sc9860-clk.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    /* AP DMA controller */
+    dma-controller@20100000 {
+      compatible = "sprd,sc9860-dma";
+      reg = <0x20100000 0x4000>;
+      interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&apahb_gate CLK_DMA_EB>;
+      clock-names = "enable";
+      #dma-cells = <1>;
+      dma-channels = <32>;
+    };
+
+    /* AGCP DMA controller */
+    dma-controller@41580000 {
+      compatible = "sprd,sc9860-dma";
+      reg = <0x41580000 0x4000>;
+      clocks = <&agcp_gate CLK_AGCP_DMAAP_EB>,
+               <&agcp_gate CLK_AGCP_AP_ASHB_EB>;
+      clock-names = "enable", "ashb_eb";
+      #dma-cells = <1>;
+      dma-channels = <32>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/dma/sprd-dma.txt b/Documentation/devicetree/bindings/dma/sprd-dma.txt
deleted file mode 100644
index c7e9b5fd50e7..000000000000
--- a/Documentation/devicetree/bindings/dma/sprd-dma.txt
+++ /dev/null
@@ -1,44 +0,0 @@
-* Spreadtrum DMA controller
-
-This binding follows the generic DMA bindings defined in dma.txt.
-
-Required properties:
-- compatible: Should be "sprd,sc9860-dma".
-- reg: Should contain DMA registers location and length.
-- interrupts: Should contain one interrupt shared by all channel.
-- #dma-cells: must be <1>. Used to represent the number of integer
-	cells in the dmas property of client device.
-- dma-channels : Number of DMA channels supported. Should be 32.
-- clock-names: Should contain the clock of the DMA controller.
-- clocks: Should contain a clock specifier for each entry in clock-names.
-
-Deprecated properties:
-- #dma-channels : Number of DMA channels supported. Should be 32.
-
-Example:
-
-Controller:
-apdma: dma-controller@20100000 {
-	compatible = "sprd,sc9860-dma";
-	reg = <0x20100000 0x4000>;
-	interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
-	#dma-cells = <1>;
-	dma-channels = <32>;
-	clock-names = "enable";
-	clocks = <&clk_ap_ahb_gates 5>;
-};
-
-
-Client:
-DMA clients connected to the Spreadtrum DMA controller must use the format
-described in the dma.txt file, using a two-cell specifier for each channel.
-The two cells in order are:
-1. A phandle pointing to the DMA controller.
-2. The slave id.
-
-spi0: spi@70a00000{
-	...
-	dma-names = "rx_chn", "tx_chn";
-	dmas = <&apdma 11>, <&apdma 12>;
-	...
-};
-- 
2.34.1


