Return-Path: <dmaengine+bounces-5095-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A92AAD4B2
	for <lists+dmaengine@lfdr.de>; Wed,  7 May 2025 06:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CC26503294
	for <lists+dmaengine@lfdr.de>; Wed,  7 May 2025 04:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4421DF725;
	Wed,  7 May 2025 04:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nv7c+6Jn"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4A31DF265;
	Wed,  7 May 2025 04:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746593903; cv=none; b=TGjwQ3IesAiM+rSQct8r6ltY+nKCqYfycm4oXX/WpmqRala0nBwVPxtG0ipwYVOlbJ7ug62RsRiYonhhTCK6VaxLwbbBsGmjYdBGVH0e/vqmVRzbtPukpASdRoZhSCgAxjPXI2qEMq/qxbBl1uueWkXGUhjDgkNDjUiq8aGJl7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746593903; c=relaxed/simple;
	bh=R3BeY5y8gh/r0wH5u5tbT7hSme6I1qiOGTHfI8yxsMs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FrCpmh+oEXOV5G6565cWhPYSLkZvY29bLb9RyH0xRu/DWMafntoyktrG3nV/eJx9m00zoXvhyrV57eOuYBx1peJW1+62f+cziOkgvgnfOjbVzfeRXYMmKpSLzkArqS4dIdNPoAneH0Gwjh2RfjlNCvNnzy7oUnQG/8Mo6xH1sAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nv7c+6Jn; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22c33ac23edso69662915ad.0;
        Tue, 06 May 2025 21:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746593901; x=1747198701; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gp8EMudo+l8hHuGJwav45n96UcZGrxVsrevK5zrEmwM=;
        b=Nv7c+6Jnl66skABgW2VHV/SBP3KPiZ6+sJLz+RzuCvMRcLeAP9BGYcAs5+ECgJUnTi
         UDu7KJHkK768fw6GEIsMuol46QDF+mNa2v6jywcUoOILcbRUydZqyk9FiFwgyqB84TRU
         eAb7xLynMxpVT2YRCPoZwhyPvaIX+QdAnKdAMlmYSANcBBEz0kcvTHW4M7P/RTSMlYoK
         7Ioc6HP213dSeLyOQaPT0s0xFwV6b2f6jVRuyrLY9SgWVJjxW/lknqs805BVCzwZyUwC
         GCju3WW6mqRUOlgy+PmadPWVrq6qze5X+BNgKgSj3HNGVcLVWHOgsI2uZ/Cso8dEKeNn
         6fcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746593901; x=1747198701;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gp8EMudo+l8hHuGJwav45n96UcZGrxVsrevK5zrEmwM=;
        b=cR8Wnlyvkmg85xvm3NgxKITZXpykYIqjhJLsH/ece4JK395KG9Z4xRlU9pAA2bWhYB
         cD1Uso2rZ/90BJdS75sOZfoi4nDOyxZtR+FheYKn7reZRI9QzXU4PGSrqML5Dmo/3pCV
         NFaut1XdCgU25qzzZoZdxRnBKKlQyQZqJerf0DyK4HLC7d62ffRJSj3egsPkyM35kiOB
         GI6G3V4HAyjCiRM+NROOW9R1xYeFWF9aOD4EouEeku38mQ2k2sY2K/PyCtGERpmC+9/m
         xJsN9dCPU10T0mZFD6vvkaqCjtxgAIJKKjR8s53yyJLQE8Z7xvDMYkh2ZTKqqR6vbmGJ
         pg4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUJni1rur0gnoWUJQoVGmq9jsi8G8iuULoqX6nPjJ/mq52qt9PBDoxJQ3ZGf7ujFA+kTIscng7NRKrQ@vger.kernel.org, AJvYcCULhSa+bvhXxxOMZRaJbt1OcMSrPGpniE73g4zuzP5Ec6fKPhHxSDxc7rIST12DnWNMhasJBSfRwRbjH20g@vger.kernel.org, AJvYcCXV/osQ+02znYfz9w9ADwOEPTMlAgmOFJX2nG0LeHbM7CyMRBBEOjfWom/dKd4L4mLnZ3LR5Y6As5cwJDc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf+sLLih+ra830wjrWmvpFThsqY6CCxeeigBhe2BmjIeABor8l
	HJGo/HJLopj1TGpviqbljlJyMJkIcPzpgBC/BeCBgK/GC9NOxNqBSAQmG9Kx
X-Gm-Gg: ASbGncsXqVUCY6ZlpHfbH+4rERBY/L+TflHzLcPQHqE2onGJbzfNpyCWG1/u0SwRW+i
	29dxy/j3wrcgp3i5r82C/1LmwdOdiaScznQ7N6jnIbnfAdS/vWrRFxF4uCXzVtB866V0Ew9by3g
	tQ/4oGg28WTCFu067MSsHYyOHXHyfbIDpqOAWjHtger2rPVFiiigCjBeUzGV8uD9vLMVbRP6Gva
	OJH7j/O1rI9Nkqi5fUXZBJ8ZY4zkFEqbJt4p/xiO6WpPYFW9nRxbeASvIj+ZHxu/8ghRU+RVOdD
	fZ3qXMueKB00nZFU1JVctZi1+dyNoKbWk8hlmEx4E+7haH790jCpubYLSXsiuA==
X-Google-Smtp-Source: AGHT+IFzi/hDZOXFzqno4SLNlk6HwNaZM+JUmfFyAeb+L2b/PyXhuJZsMzw1R9UcMW1WC7fwLGWsaw==
X-Received: by 2002:a17:903:2a83:b0:224:a74:28cd with SMTP id d9443c01a7336-22e5ea91fb0mr27861065ad.31.1746593901320;
        Tue, 06 May 2025 21:58:21 -0700 (PDT)
Received: from Black-Pearl. ([122.162.204.119])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-22e1521fd12sm84261505ad.127.2025.05.06.21.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 21:58:20 -0700 (PDT)
From: Charan Pedumuru <charan.pedumuru@gmail.com>
Date: Wed, 07 May 2025 04:57:34 +0000
Subject: [PATCH v4 2/2] dt-bindings: dma: nvidia,tegra20-apbdma: convert
 text based binding to json schema
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250507-nvidea-dma-v4-2-6161a8de376f@gmail.com>
References: <20250507-nvidea-dma-v4-0-6161a8de376f@gmail.com>
In-Reply-To: <20250507-nvidea-dma-v4-0-6161a8de376f@gmail.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Charan Pedumuru <charan.pedumuru@gmail.com>
X-Mailer: b4 0.14.2

Update text binding to YAML.
Changes during conversion:
- Add a fallback for "nvidia,tegra30-apbdma" as it is
  compatible with the IP core on "nvidia,tegra20-apbdma".
- Update examples and include appropriate file directives to resolve
  errors identified by `dt_binding_check` and `dtbs_check`.

Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
---
 .../bindings/dma/nvidia,tegra20-apbdma.txt         | 44 -----------
 .../bindings/dma/nvidia,tegra20-apbdma.yaml        | 90 ++++++++++++++++++++++
 2 files changed, 90 insertions(+), 44 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra20-apbdma.txt b/Documentation/devicetree/bindings/dma/nvidia,tegra20-apbdma.txt
deleted file mode 100644
index 447fb44e7abeaa7ca3010b9518533e786cce56a8..0000000000000000000000000000000000000000
--- a/Documentation/devicetree/bindings/dma/nvidia,tegra20-apbdma.txt
+++ /dev/null
@@ -1,44 +0,0 @@
-* NVIDIA Tegra APB DMA controller
-
-Required properties:
-- compatible: Should be "nvidia,<chip>-apbdma"
-- reg: Should contain DMA registers location and length. This should include
-  all of the per-channel registers.
-- interrupts: Should contain all of the per-channel DMA interrupts.
-- clocks: Must contain one entry, for the module clock.
-  See ../clocks/clock-bindings.txt for details.
-- resets : Must contain an entry for each entry in reset-names.
-  See ../reset/reset.txt for details.
-- reset-names : Must include the following entries:
-  - dma
-- #dma-cells : Must be <1>. This dictates the length of DMA specifiers in
-  client nodes' dmas properties. The specifier represents the DMA request
-  select value for the peripheral. For more details, consult the Tegra TRM's
-  documentation of the APB DMA channel control register REQ_SEL field.
-
-Examples:
-
-apbdma: dma@6000a000 {
-	compatible = "nvidia,tegra20-apbdma";
-	reg = <0x6000a000 0x1200>;
-	interrupts = < 0 136 0x04
-		       0 137 0x04
-		       0 138 0x04
-		       0 139 0x04
-		       0 140 0x04
-		       0 141 0x04
-		       0 142 0x04
-		       0 143 0x04
-		       0 144 0x04
-		       0 145 0x04
-		       0 146 0x04
-		       0 147 0x04
-		       0 148 0x04
-		       0 149 0x04
-		       0 150 0x04
-		       0 151 0x04 >;
-	clocks = <&tegra_car 34>;
-	resets = <&tegra_car 34>;
-	reset-names = "dma";
-	#dma-cells = <1>;
-};
diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra20-apbdma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra20-apbdma.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..a2ffd5209b3bf3f2171b55351a557a6e2085987d
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/nvidia,tegra20-apbdma.yaml
@@ -0,0 +1,90 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/nvidia,tegra20-apbdma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVIDIA Tegra APB DMA Controller
+
+description:
+  The NVIDIA Tegra APB DMA controller is a hardware component that
+  enables direct memory access (DMA) on Tegra systems. It facilitates
+  data transfer between I/O devices and main memory without constant
+  CPU intervention.
+
+maintainers:
+  - Jonathan Hunter <jonathanh@nvidia.com>
+
+properties:
+  compatible:
+    oneOf:
+      - const: nvidia,tegra20-apbdma
+      - items:
+          - const: nvidia,tegra30-apbdma
+          - const: nvidia,tegra20-apbdma
+
+  reg:
+    maxItems: 1
+
+  "#dma-cells":
+    const: 1
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    description:
+      Should contain all of the per-channel DMA interrupts in
+      ascending order with respect to the DMA channel index.
+    minItems: 1
+    maxItems: 32
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    const: dma
+
+required:
+  - compatible
+  - reg
+  - "#dma-cells"
+  - clocks
+  - interrupts
+  - resets
+  - reset-names
+
+allOf:
+  - $ref: dma-controller.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/reset/tegra186-reset.h>
+    dma-controller@6000a000 {
+        compatible = "nvidia,tegra30-apbdma", "nvidia,tegra20-apbdma";
+        reg = <0x6000a000 0x1200>;
+        interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&tegra_car 34>;
+        resets = <&tegra_car 34>;
+        reset-names = "dma";
+        #dma-cells = <1>;
+    };
+...

-- 
2.43.0


