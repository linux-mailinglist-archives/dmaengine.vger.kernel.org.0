Return-Path: <dmaengine+bounces-5045-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F04AA5F0B
	for <lists+dmaengine@lfdr.de>; Thu,  1 May 2025 15:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B1A61BA5DA6
	for <lists+dmaengine@lfdr.de>; Thu,  1 May 2025 13:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5938C17B505;
	Thu,  1 May 2025 13:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDgEOT2M"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65BB174EF0;
	Thu,  1 May 2025 13:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746105219; cv=none; b=DY6kb/DucmVsZchEOvBn1CEunYnJ68DQTyqdKFKKXv9BT3QU+bH2z4uw+yjvsoeiWXHlsl954Jb+n7YwvfGX4MszDxWnor7e+VprODkcCSkYwqJh0ZOmcI4y6Zb0APK5iMGihH196UcDFt+OHT5L8ZZV3klk2CAle8HMagq8ttY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746105219; c=relaxed/simple;
	bh=RDaGjhb6CLrz8nAp0mDGS3MCpW/LRQ28yHAfL5/xlP8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=siBNbSitUOoQauVin2DGDyZxURSZjFc4CgTExQbYzkZwisJ7d9I8pYSHD0opwdmpSeEEYbHJd692BXDjf9NvTfBC3dg/Xg1MBpcXokDFQhTOG1uImQ9rCyVXxuTyu5TqkwFrkart+PpDipKX+KzIblLJ/xjWqqkEJRuZB1E5UQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CDgEOT2M; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-30384072398so734072a91.0;
        Thu, 01 May 2025 06:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746105217; x=1746710017; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9/lHepDmfNzk/dMT78MMtoVF7nNV1GEq10f/wXak/5U=;
        b=CDgEOT2MRCM7Uh8ckqVuiwWp3e42WnwFvanIRNpffTjRfCCXf4fapakj4inWmB7j8I
         y2hLgi3eK/cQD2QzzkeJfwOthXgjmJar3/oxYjmFx4rc1Vmi0g/bDD7nfNDthYKuF89G
         +PWUvguTgI5MTcKvHSKjKalQ8t3U5ny+CaxbseQtncr5rFLQuo87eN4UFijyUiydd+zD
         dJf279gvphkaF0Mu0GO60XYLdu8I7MlCg/+VV8Z2zANEpWxb7/HE2fhEg63AkQ/s1UvG
         0RZm93AeeQJE4HiJPuh+DzYVrIliJuB1U2iTdDdv+KU44+LGF+rKKi66ErbKawT6k1Yd
         fInQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746105217; x=1746710017;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9/lHepDmfNzk/dMT78MMtoVF7nNV1GEq10f/wXak/5U=;
        b=qwq8A26yMCUDq3d3GXZBSbJWIVZGhnMonT+Ak+EJ7QmANmh03HQLMWm+yrVMsAkLh8
         yTGWtf4sLuAHyZ+1uvYzabckUTIdbbC7BTel64zTOQRXCHIWJ8ge1moL7cuRL7zAETpy
         g4ac5WsTtK0PWuJ+s7UilyCWOwVPp+7teF+3NR51M3Bk3KWNE8WG5WeLmdl5v7qkVBFu
         j5AvW+472R96WBvZdhhb3H1LWv6qiycI10HyRvnwz+g2RtJXvrTNiaSifaw8aDfmA7DK
         Jgdn0fp641aaXU8esMFrhi2Nc5T5Ki6+5YlcwOb1zoMxUP3gprsYEPJ+ta6EXpoMAmxr
         sfjQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1oR9mGAqGSvs1dvOIaucFokLHeK5//I8RChDLC6EnItLIj3wq3kan7uDvjMwdTX0qecbHVo+cVXh4@vger.kernel.org, AJvYcCWIS91P0rT/kjsqG86UY1jQSWFGmDbvLCRz/Y+3LeJ/jNNaQ5dolA+uyC/VGtclswb3jN3OALmXMoTsaI7V@vger.kernel.org, AJvYcCXNKHXGo1SKqFZr/KiabuRN/vwqoHSFf9VeS58Z+HKdWODETECtL9Yb9sn9o/Gj3LEubTzl+UM3OjmFQLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtmXgFOM7zzF6IzMxVG1AzEMirINuL4qfxzTNz05+cdFHmYpj8
	M5kZ2CFrDlwqOqcuza6Vo/rTySC4gmi9bCQ96ZfbYwEAcft9/8wb
X-Gm-Gg: ASbGnctZZp6kpePjaKNpQdNzf9JoSHPFBNfcCqrEz3J2oIYFwJXNYWIdGloqCPx4eqC
	asquhwTTXiLS6BsdwMtfbGGen4IFl+O1t8Am3tyX6gVFzWGtFIwjj+VJgbyyUz1V+cRhd4rXtuf
	AN9gm3pMbjtAcdp5vgyb9OSfw50AzOnWAdbptqj7jRQrzfSrbDehraS81aZ7E74w4qSaI+UGx9p
	VvonnWK74nARnjcnbqsgRwAy0Ur2iZNIpefPB/xjuqspgW/9bIp6bGamt6UACs8I66+fZOrb9K/
	cDBjIsftw7jJFtJ1hP5Ebl2p982/f83j8NP1hph2En4WW2zQ+Q==
X-Google-Smtp-Source: AGHT+IE+nV3BX0N2nAoX9cmzKwU9eZ6V/oqEsyX4ll06AYTgvgTYCZB09JmCJBgntZsJ8nSgyaFGEQ==
X-Received: by 2002:a17:90b:5827:b0:303:75a7:26a4 with SMTP id 98e67ed59e1d1-30a332df593mr10706164a91.7.1746105216776;
        Thu, 01 May 2025 06:13:36 -0700 (PDT)
Received: from Black-Pearl. ([122.169.148.15])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-30a4764226csm853277a91.43.2025.05.01.06.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 06:13:36 -0700 (PDT)
From: Charan Pedumuru <charan.pedumuru@gmail.com>
Date: Thu, 01 May 2025 13:12:36 +0000
Subject: [PATCH] dt-bindings: dma: convert text based binding to json
 schema
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250501-nvidea-dma-v1-1-a29187f574ba@gmail.com>
X-B4-Tracking: v=1; b=H4sIAENzE2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDE2MD3byyzJTURN2UXCBOtjA3STRKMzNNM1cCaigoSk3LrAAbFh1bWws
 ADJ3eKVwAAAA=
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Charan Pedumuru <charan.pedumuru@gmail.com>
X-Mailer: b4 0.13.0

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
index 447fb44e7abe..000000000000
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
index 000000000000..fc800231b39b
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
+description: |
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
+  "#dma-cells":
+    description:
+      Must be <1>. This dictates the length of DMA specifiers
+      in client node's dmas properties.
+    const: 1
+
+  clocks:
+    maxItems: 1
+
+  reg:
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
+  - interrupts
+  - clocks
+  - resets
+  - reset-names
+  - "#dma-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/reset/tegra186-reset.h>
+    dma@6000a000 {
+        compatible = "nvidia,tegra30-apbdma", "nvidia,tegra20-apbdma";
+        reg = <0x6000a000 0x1200>;
+        interrupts = <0 136 0x04>,
+                     <0 137 0x04>,
+                     <0 138 0x04>,
+                     <0 139 0x04>,
+                     <0 140 0x04>,
+                     <0 141 0x04>,
+                     <0 142 0x04>,
+                     <0 143 0x04>,
+                     <0 144 0x04>,
+                     <0 145 0x04>,
+                     <0 146 0x04>,
+                     <0 147 0x04>,
+                     <0 148 0x04>,
+                     <0 149 0x04>,
+                     <0 150 0x04>,
+                     <0 151 0x04>;
+        clocks = <&tegra_car 34>;
+        resets = <&tegra_car 34>;
+        reset-names = "dma";
+        #dma-cells = <1>;
+    };
+...

---
base-commit: 9d9096722447b77662d4237a09909bde7774f22e
change-id: 20250430-nvidea-dma-dc874a2f65f7

Best regards,
-- 
Charan Pedumuru <charan.pedumuru@gmail.com>


