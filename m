Return-Path: <dmaengine+bounces-2627-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03211927DB9
	for <lists+dmaengine@lfdr.de>; Thu,  4 Jul 2024 21:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE08F286AF4
	for <lists+dmaengine@lfdr.de>; Thu,  4 Jul 2024 19:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591A64D112;
	Thu,  4 Jul 2024 19:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7cfKon3"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7836B136995;
	Thu,  4 Jul 2024 19:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720120832; cv=none; b=TOr7hvL+7HOCB3gKretT0zfSgp4E6/KcmmD8t8p1iOYhVh0XQmzbbWdhIW6p4C3F6TehBUbLv7Z4+nqXfXNaQwH97IMSDi7H6bxOrWItzwSzXda4qnoH2QBOvi3TTgnL1NuPMsVMFnSLqZws/mIlVYdkZWVpfPJUsJm+haMEjao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720120832; c=relaxed/simple;
	bh=C7n8SF9Yy0W8Wqsogc/ADklPy1DxlEbaXcIgrDMBVzw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HXviCGi5HNORrYL+rq0V+m+Z4Wgnx9984qR65DW2lg/uLKhIfHUC6a733qBIoJrezycJEsfO/CAMz4YRBk8sjydqdC4DD8oP20WYXJ2fra59gv9nNDRkgCh7xiWSSU2wlKz9VENNrkZyUutWiyYEn0i7c4AlebC8lwuQc8nHT9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f7cfKon3; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ee90f56e02so6068191fa.2;
        Thu, 04 Jul 2024 12:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720120829; x=1720725629; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=49WF/G+olApH1oz6KDU9yQLMCw9oaA68O+yMVenGtgk=;
        b=f7cfKon3USEQq6ntSoVtTb2P/52u2H6Nf/WtSb3pZqBHO9+yexHwKO44hyVDZeiusQ
         DEbj3US4LLOLq2XyRa9QFlx6XRK5QqT8QVv+F/QTuiJM5DikwYrr9U9QJzK+ZGBisP4l
         dm7JEEJiC2rMG5QTexudXL6LTt5MCsjmBSqtGpWK8E4y5F3a+WpvkC9TDX2BrlrLsYZ6
         2mNFV5og1RvFyHimGZ3qMrtmOkCK0al6+j8NvLdCgC5m5li4d1+V/f3HwJ6xPJ3G6n+Y
         7dwKpvcgsFL32n89jeFL6ecLyJ0/FvHTh+xkoj/TBNgwX5/X8xDzgiUKyY9ir5aoIqlF
         6Q4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720120829; x=1720725629;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=49WF/G+olApH1oz6KDU9yQLMCw9oaA68O+yMVenGtgk=;
        b=qU/Mkp+l2RnVPYBEshAJ2Wc/JLzDRRG1eVa+iq6yCU+fP24selb7888ftJTpjCtbdP
         H5GS4ibEbsaDDoE2QCTWCf3lGfWiIcvtYxvpnQkdnVXy8wjXVIginm5KeYWCb13DWAUj
         uPjbMa4CqFs284DFV4RoHVxnipTS9/5kp5xFcu/g1QXLnNRMIEswPvoC+4DSk9lzLnX4
         P5iujYTqC/AUqvjWKVjMgFuMHjPsgAPZi+x4P8mZbmJX0hxAFfJ2v6uszmPtta9JGP1P
         AhzIb8R04fIVu2Hxe8vFZSJUvvNDjKcYUP3BDCJd6WQrsSzoZiKkuES3iiSpvjqVGC6+
         TO1g==
X-Forwarded-Encrypted: i=1; AJvYcCX9yZw92FM+IF7BBBIgevoTikm0l6eRyzm1L7BYQ7sUkw2vqv7iNIiPXG+yckXvDaEWOhxMb9/eJyKMBKGzXJ2V1xGgpQW5cPLuQyi6fKIA1niUd+m+jsNiOw5MkGhB9XWkn47iBUBI4g==
X-Gm-Message-State: AOJu0YzKxY1hYotWmpQk2SxtAaXZ8l+IKzJ7ZRse0qdXbQpHReF+FRzA
	jVePbmrqx6pOHNnjxpCGWko74IPT87IIwEuA/s9dtnIh6JHwhIxY
X-Google-Smtp-Source: AGHT+IGEc5Ox24Iuy+ng6AX2B2GFe2auxjFis+01tI7qkSYcPt6iIrJdnwlk3IoN5jYoOJqBtnCHMA==
X-Received: by 2002:a05:651c:30b:b0:2ec:3d74:88ca with SMTP id 38308e7fff4ca-2ee8eda710emr17496311fa.25.1720120828357;
        Thu, 04 Jul 2024 12:20:28 -0700 (PDT)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a28355csm33818625e9.43.2024.07.04.12.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 12:20:28 -0700 (PDT)
Date: Thu, 4 Jul 2024 21:20:26 +0200
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
Subject: [PATCH v2] dt-bindings: dma: sprd,sc9860-dma: convert to YAML
Message-ID: <Zob1+kGW1xeBKehA@standask-GA-A55M-S2HP>
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
Changes in V2:
  - rework clocks, clock-names (Conor)

 .../bindings/dma/sprd,sc9860-dma.yaml         | 92 +++++++++++++++++++
 .../devicetree/bindings/dma/sprd-dma.txt      | 44 ---------
 2 files changed, 92 insertions(+), 44 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/sprd,sc9860-dma.yaml
 delete mode 100644 Documentation/devicetree/bindings/dma/sprd-dma.txt

diff --git a/Documentation/devicetree/bindings/dma/sprd,sc9860-dma.yaml b/Documentation/devicetree/bindings/dma/sprd,sc9860-dma.yaml
new file mode 100644
index 000000000000..94647219c021
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
+    items:
+      - description: DMA enable clock
+      - description: optional ashb_eb clock, only for the AGCP DMA controller
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: enable
+      - const: ashb_eb
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


