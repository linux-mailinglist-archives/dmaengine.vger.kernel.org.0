Return-Path: <dmaengine+bounces-3995-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B03C9F3C2E
	for <lists+dmaengine@lfdr.de>; Mon, 16 Dec 2024 22:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C44191890DC6
	for <lists+dmaengine@lfdr.de>; Mon, 16 Dec 2024 21:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B201D89F7;
	Mon, 16 Dec 2024 20:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VxlE730G"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19E71D5AB6
	for <dmaengine@vger.kernel.org>; Mon, 16 Dec 2024 20:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734382278; cv=none; b=k6/Q9Wmy5AQZbuHsIUey3nMJ7faaRPQdN7ktO0XLKb+9bzPL+dGQ5JYT7iCS6+6jQAQaeNogJ9urg33Ech0+h+pr5nygmdhF0Qhlttzg5UPVUx0lI6Get4rLzun95bpPaUPykf5gPuZuUZa/DuGa20vNu5nMo0jsgVGCgvwKB4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734382278; c=relaxed/simple;
	bh=danaVODVXkLeC5gzVn7osW8hxozzikG3OiO4q8icIp4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jyZEp4IJHbYJYRep1wDBv6qbNjsTL1f+KczEiz+y44JsazM2P+HmYBuPbwqJfgsBlzw7XKM/9ZHquqr4++zbmEPGqf2r8JzXU6JENDMOgLCmAJoFdbw3xtKxTxV9qkEpKHbCwpoBx+ZDXUnT43gKZTmyS5Q6Cf6okCO3xXZCUD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VxlE730G; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-71e1d7130a5so2256177a34.0
        for <dmaengine@vger.kernel.org>; Mon, 16 Dec 2024 12:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734382275; x=1734987075; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IHXQr6r16gcrgHlysP6o6NtlaUWh1zq2HgI0QnXfDLc=;
        b=VxlE730Gv6ZYshkyWk9c7ISjXbnGq0rqfGs35zjnfUhX8QRGpitqTFJgr12w9RwXhP
         AGtd3WKBc6WqY0oaqEULi7JH/22UE8vq3rIXJZXPW3VPnIoaYDT2XX3VvKjLRv/MQ4QK
         LxwWdpP2uTb6Tf957xbUKahWCu3k7bS5Wvk68UwxD7+C7as9u5gycv5rZ2Dl7ReZKBVL
         CSS2E16I9LNFJhJSisXxXsrF+o9lDB3tiqBUcnMRoLFMPLfm1/mNt4Duoa9ABB4jAU48
         MHRQklwhxii5FX4DGY1tQw5dWYZClCQ0NY6LvinlsEDzNAsjTYttIUZi6ZpxYpRGW2h1
         DwlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734382275; x=1734987075;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IHXQr6r16gcrgHlysP6o6NtlaUWh1zq2HgI0QnXfDLc=;
        b=BGZkCprh6aoxFWOwTuuBJn0BKVVaLUP0GPFnocbf/RrdbsME4hArXRMvMlf6cCQSYG
         FC5sobABHrUe+/2sDOpws5n9ipEM8YeZEGYEttoWa0j9/FhMhpni6cSKwow4zVtcQHuD
         cThLSDX+2KGH3dC4pXKYJs5g5kY7BnF9CgbdOasNeZRxKv+A7vc7LVLVZIQMsYm80FD9
         7Qe1sR2A6topU2RGU0Jx0isP0P+VgPCdsHCili6vYn9cXXDpzX7mds2qaNtCwOVXE+QW
         mQb2GfIXZe/EAOH/CQPaKAQlclpEJWZPUD2Q3hwT3H6mCoojPoERLONR5B4oFVn5+Gka
         yj9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXaBdiFfkLv8D//Se2uzv46go1EpNMOjlXorsXeNxnYpLPvUL0OIqXb19MovyyJDuo0sWn7TQEkJmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSuGcNLLJZvuz1PZ0zNDV05ihGznH0U0NaiYPHJttZC+nrcDxr
	NS+trkikIXkIanBBAXE19Zabzkx2CBOo5ywWILwE5sr7hFna7uAa41tWnxllK3oC6+5kLkx9+qQ
	n
X-Gm-Gg: ASbGncuex4zLCmjQTrpH0ETJzTD2ZnPaGjyvpzIbm9Xbro9ouWIrqVsUj36tCqj3Bho
	jKuagddrq0af64FfwX+2w5w0w8+tzNbTZEQH1HLu+DlOlgh5rU22e16njeacvYI1dOOO8r/Kkvv
	9/p7IT+hpAgsVl7874I1ylLJzkvCpqafu1FpJdIyq35dEvHTmBxrWeF+6tJLQVXogRvxqYoscZR
	Nv5TLC/HpSxm95h8e0VxuEbW7fluISe0d04qQRvXfpA6en4Sz6mMlpRuabJKDWvYHljNSze/WY2
	oC3FyB1UVBSn
X-Google-Smtp-Source: AGHT+IHkAgry4uogh9KF8nM8CgQC+tXAZL78hX82olRnIk4sB1KGjrd4SuWb7fgYr0sE4H8VXM9b9A==
X-Received: by 2002:a05:6830:6f06:b0:71d:f239:c0a8 with SMTP id 46e09a7af769-71efdb58c82mr764830a34.6.1734382275091;
        Mon, 16 Dec 2024 12:51:15 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71e48355dc0sm1649022a34.25.2024.12.16.12.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 12:51:14 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 16 Dec 2024 14:51:01 -0600
Subject: [PATCH RESEND v3 1/2] dt-bindings: dma: adi,axi-dmac: convert to
 yaml schema
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-axi-dma-dt-yaml-v3-1-7b994710c43f@baylibre.com>
References: <20241216-axi-dma-dt-yaml-v3-0-7b994710c43f@baylibre.com>
In-Reply-To: <20241216-axi-dma-dt-yaml-v3-0-7b994710c43f@baylibre.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

Convert the AXI DMAC bindings from .txt to .yaml.

Acked-by: Nuno Sa <nuno.sa@analog.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

For the maintainer, Lars is the original author, but isn't really
active with ADI anymore, so I have added Nuno instead since he is the
most active ADI representative currently and is knowledgeable about this
hardware.

As in v1, the rob-bot is likely to complain with the following:

	Documentation/devicetree/bindings/dma/adi,axi-dmac.yaml: properties:adi,channels:type: 'boolean' was expected
		hint: A vendor boolean property can use "type: boolean"
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	DTC [C] Documentation/devicetree/bindings/dma/adi,axi-dmac.example.dtb

This is due to the fact that we have a vendor prefix on an object node.
We can't change that since it is an existing binding. Rob said he will
fix this in dtschema.
---
 .../devicetree/bindings/dma/adi,axi-dmac.txt       |  61 ---------
 .../devicetree/bindings/dma/adi,axi-dmac.yaml      | 139 +++++++++++++++++++++
 2 files changed, 139 insertions(+), 61 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/adi,axi-dmac.txt b/Documentation/devicetree/bindings/dma/adi,axi-dmac.txt
deleted file mode 100644
index cd17684aaab5bcd38bb8b1d7644601ae0a0186a1..0000000000000000000000000000000000000000
--- a/Documentation/devicetree/bindings/dma/adi,axi-dmac.txt
+++ /dev/null
@@ -1,61 +0,0 @@
-Analog Devices AXI-DMAC DMA controller
-
-Required properties:
- - compatible: Must be "adi,axi-dmac-1.00.a".
- - reg: Specification for the controllers memory mapped register map.
- - interrupts: Specification for the controllers interrupt.
- - clocks: Phandle and specifier to the controllers AXI interface clock
- - #dma-cells: Must be 1.
-
-Required sub-nodes:
- - adi,channels: This sub-node must contain a sub-node for each DMA channel. For
-   the channel sub-nodes the following bindings apply. They must match the
-   configuration options of the peripheral as it was instantiated.
-
-Required properties for adi,channels sub-node:
- - #size-cells: Must be 0
- - #address-cells: Must be 1
-
-Required channel sub-node properties:
- - reg: Which channel this node refers to.
- - adi,source-bus-width,
-   adi,destination-bus-width: Width of the source or destination bus in bits.
- - adi,source-bus-type,
-   adi,destination-bus-type: Type of the source or destination bus. Must be one
-   of the following:
-	0 (AXI_DMAC_TYPE_AXI_MM): Memory mapped AXI interface
-	1 (AXI_DMAC_TYPE_AXI_STREAM): Streaming AXI interface
-	2 (AXI_DMAC_TYPE_AXI_FIFO): FIFO interface
-
-Deprecated optional channel properties:
- - adi,length-width: Width of the DMA transfer length register.
- - adi,cyclic: Must be set if the channel supports hardware cyclic DMA
-   transfers.
- - adi,2d: Must be set if the channel supports hardware 2D DMA transfers.
-
-DMA clients connected to the AXI-DMAC DMA controller must use the format
-described in the dma.txt file using a one-cell specifier. The value of the
-specifier refers to the DMA channel index.
-
-Example:
-
-dma: dma@7c420000 {
-	compatible = "adi,axi-dmac-1.00.a";
-	reg = <0x7c420000 0x10000>;
-	interrupts = <0 57 0>;
-	clocks = <&clkc 16>;
-	#dma-cells = <1>;
-
-	adi,channels {
-		#size-cells = <0>;
-		#address-cells = <1>;
-
-		dma-channel@0 {
-			reg = <0>;
-			adi,source-bus-width = <32>;
-			adi,source-bus-type = <ADI_AXI_DMAC_TYPE_MM_AXI>;
-			adi,destination-bus-width = <64>;
-			adi,destination-bus-type = <ADI_AXI_DMAC_TYPE_FIFO>;
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/dma/adi,axi-dmac.yaml b/Documentation/devicetree/bindings/dma/adi,axi-dmac.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..b1f4bdcab4fd373b6ad7bfae763f70209eb1b65b
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/adi,axi-dmac.yaml
@@ -0,0 +1,139 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/adi,axi-dmac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AXI-DMAC DMA controller
+
+description: |
+  FPGA-based DMA controller designed for use with high-speed converter hardware.
+
+  http://analogdevicesinc.github.io/hdl/library/axi_dmac/index.html
+
+maintainers:
+  - Nuno Sa <nuno.sa@analog.com>
+
+additionalProperties: false
+
+properties:
+  compatible:
+    const: adi,axi-dmac-1.00.a
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
+  "#dma-cells":
+    const: 1
+
+  adi,channels:
+    type: object
+    description: This sub-node must contain a sub-node for each DMA channel.
+    additionalProperties: false
+
+    properties:
+      "#size-cells":
+        const: 0
+      "#address-cells":
+        const: 1
+
+    patternProperties:
+      "^dma-channel@[0-9a-f]+$":
+        type: object
+        description:
+          DMA channel properties based on HDL compile-time configuration.
+        additionalProperties: false
+
+        properties:
+          reg:
+            maxItems: 1
+
+          adi,source-bus-width:
+            $ref: /schemas/types.yaml#/definitions/uint32
+            description: Width of the source bus in bits.
+            enum: [8, 16, 32, 64, 128]
+
+          adi,destination-bus-width:
+            $ref: /schemas/types.yaml#/definitions/uint32
+            description: Width of the destination bus in bits.
+            enum: [8, 16, 32, 64, 128]
+
+          adi,source-bus-type:
+            $ref: /schemas/types.yaml#/definitions/uint32
+            description: |
+              Type of the source bus.
+
+              0: Memory mapped AXI interface
+              1: Streaming AXI interface
+              2: FIFO interface
+            enum: [0, 1, 2]
+
+          adi,destination-bus-type:
+            $ref: /schemas/types.yaml#/definitions/uint32
+            description: Type of the destination bus (see adi,source-bus-type).
+            enum: [0, 1, 2]
+
+          adi,length-width:
+            deprecated: true
+            $ref: /schemas/types.yaml#/definitions/uint32
+            description: Width of the DMA transfer length register.
+
+          adi,cyclic:
+            deprecated: true
+            type: boolean
+            description:
+              Must be set if the channel supports hardware cyclic DMA transfers.
+
+          adi,2d:
+            deprecated: true
+            type: boolean
+            description:
+              Must be set if the channel supports hardware 2D DMA transfers.
+
+        required:
+          - reg
+          - adi,source-bus-width
+          - adi,destination-bus-width
+          - adi,source-bus-type
+          - adi,destination-bus-type
+
+    required:
+      - "#size-cells"
+      - "#address-cells"
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - "#dma-cells"
+  - adi,channels
+
+examples:
+  - |
+    dma-controller@7c420000 {
+        compatible = "adi,axi-dmac-1.00.a";
+        reg = <0x7c420000 0x10000>;
+        interrupts = <0 57 0>;
+        clocks = <&clkc 16>;
+        #dma-cells = <1>;
+
+        adi,channels {
+            #size-cells = <0>;
+            #address-cells = <1>;
+
+            dma-channel@0 {
+                reg = <0>;
+                adi,source-bus-width = <32>;
+                adi,source-bus-type = <0>; /* Memory mapped */
+                adi,destination-bus-width = <64>;
+                adi,destination-bus-type = <2>; /* FIFO */
+            };
+        };
+    };

-- 
2.43.0


