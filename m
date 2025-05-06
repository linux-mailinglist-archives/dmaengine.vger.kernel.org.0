Return-Path: <dmaengine+bounces-5078-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DAD2AAC1F1
	for <lists+dmaengine@lfdr.de>; Tue,  6 May 2025 13:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B870D1C20A54
	for <lists+dmaengine@lfdr.de>; Tue,  6 May 2025 11:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5EC27A445;
	Tue,  6 May 2025 11:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+I2JD9a"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5178127990E;
	Tue,  6 May 2025 11:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746529432; cv=none; b=Bkdq7eVLrzX594nENTYjrL9FRPNQfAYFWKS5OLnbWMcZUf59BU/pkglGpyFCVtzKy1wWGPSTjIJgjlWYGcNHJ1pdNetfTfKs0pT2EG9aUSF7BYRZyvp/L1iNObFklbFDCrPg5Jhz4OSla2Dk7MCxyOB6Whgu0e8xKjnd5kWEbQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746529432; c=relaxed/simple;
	bh=h/Uqlu4kKYQM7JmNGl2AReRXzwSIPS7FBPcFG4LB57E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r3GVp3U9F1wa0WC3p+vJvBRSGEHLTkSm5Xau9JPsRjPN9mfg5E0s2Up+nLmxjbUPhezNQ/G7QX+GagF/dshntA2iVQ4Vm28WDHAJBHHBv4No3WVqvPtpJaHfMN0koMjbv2+OfI7aa1aw+5BbtWq05Xbn5nLOe1ZXgUfVNsMg75s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+I2JD9a; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so4957307b3a.0;
        Tue, 06 May 2025 04:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746529430; x=1747134230; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wM2g9uEnYrlE9sYlFYL1eToHFvmsEzdILXV4x0QZNjI=;
        b=P+I2JD9atsBi/eb5nNeRiwkzhxIipOR33W+99Kp67bTR+aWAaO74nUxew0rb1SQYoO
         9uqQCsQL16X46YDTOLjv4QwVANOUDQFdVq3cMPWyC4WHMTOFgFVJwjhZV6wfCsiR5DkO
         AEtgJAjwiBYjpeZnPsn66m/tETIyqX3lWXV/BsHfdEOhkLGschkUOHcooF49Hw4zSEpD
         IXsRlcVEm3Eoj7PfNA2jhw51dvba1B2VRvA23W39bgmeZVIKN2x8pcbA81lZKjHNpDIr
         s9ybCPILzF00FWkp2gU7uDQY+EDHKb7Wx0554pioTK9vKpk9rXPBziY/NpoMKX6CpcOo
         pteg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746529430; x=1747134230;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wM2g9uEnYrlE9sYlFYL1eToHFvmsEzdILXV4x0QZNjI=;
        b=K+laPTySL2Srh6s3+w+qgMOcMSwD1+o2cvutIxHfJBdL/sLRy17fnFvYZDJQCVppvt
         n57GA+bjc+urwrOvp531Zsach5BqkWPfNIMmK0uCnni/IQM4QhudooP4NTd7JhHdnsjV
         QXz5WaEkiVn42Aa/LmVhjTZCJV/i6x69hMDLdt3gH5tsi+H8KDd1kbMb8nA8nwdIgCSt
         OkrL+LLo7YuEkC2xUZoVZG6Z8s2kBWZwyqnOjegn8+CvIxMxZqk78pBIYKlEPvGZFGUu
         /ikzpXfLOEFMT9EKb+oTMQgzwCFHa2pZuew4a5LWVa65Jl45ahN0i2xII4FNNK/phdsP
         zYzw==
X-Forwarded-Encrypted: i=1; AJvYcCUnov6Jd/P9tXaFZj2mp0oQgCTZQ7uJIyzpM35JaeuuepnutKETW2j7cL3uXT5Ok0RyQbvrlzQxD1LsPVc=@vger.kernel.org, AJvYcCV1DvcvnZQDoi9Z3hcFPL0JhHXTzEXmnT5olSEMJY6QwmhSHghb3A0yrUwFTcPD5ol60Ll3WoRDb52+@vger.kernel.org, AJvYcCVF3uwiah1mpI/7igcEObVKULM2bMGXy5KyKHWlVYbC/u6JoNIG6GviKIuqsgZVKeLQr0Lf48HlV1uunBBI@vger.kernel.org
X-Gm-Message-State: AOJu0YwYMkOO9M4FD9j6sX13OxQ57IQklocqrq/x/cwBw/szlqoZ9P2C
	nthcCxx3nWS1TZPHBAbU6hKQQsQn12pb1DhH2Q8pqOSpv9Ro4sjAkginIpnG
X-Gm-Gg: ASbGncvHsPtaGfotnSmbjKRbe2YBNPGmZqL5FA/SdkLDZyL6osuiqy6TA5dKtn86HI+
	e/F7WKaMLkIm95wDolHKIfutPl4Ue7a353K2Pgglw4bAUciucZYNXCyN6DzWrgLvnmVTKhi0IQH
	9HZF7P2pin3AXrr9xtao1gMm79H6ZduRv8/YJ3KBOgxNbJR0Gbo+KTticS9PCp+tqAZ8Sbtpgoi
	XCtrdgQ5JJT06nRfFXE6aeyPe3k7VhFHdmbNZPDXi75k1YjCiePuERBRg/LgCUQNGCVnchkqBrw
	vHxiR9/6lee5rgr8BqQZPae9pCP16WVMQ51K3BLLRQbwtKPz0Q==
X-Google-Smtp-Source: AGHT+IGk1MCmqv7AicEGePYRlxlGc9w4nFkK1Ws3eZGw/OAZ97Ob5aqbdoQgetr0rDdnQ6GX0418Rg==
X-Received: by 2002:a05:6a00:8e02:b0:736:34ff:be7 with SMTP id d2e1a72fcca58-74091adf553mr3185409b3a.15.1746529430432;
        Tue, 06 May 2025 04:03:50 -0700 (PDT)
Received: from Black-Pearl. ([122.174.61.156])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-74058d7a3bdsm8613778b3a.9.2025.05.06.04.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 04:03:50 -0700 (PDT)
From: Charan Pedumuru <charan.pedumuru@gmail.com>
Date: Tue, 06 May 2025 11:02:25 +0000
Subject: [PATCH v3 2/2] dt-bindings: dma: nvidia,tegra20-apbdma: convert
 text based binding to json schema
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250506-nvidea-dma-v3-2-3add38d49c03@gmail.com>
References: <20250506-nvidea-dma-v3-0-3add38d49c03@gmail.com>
In-Reply-To: <20250506-nvidea-dma-v3-0-3add38d49c03@gmail.com>
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
 .../bindings/dma/nvidia,tegra20-apbdma.yaml        | 89 ++++++++++++++++++++++
 2 files changed, 89 insertions(+), 44 deletions(-)

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
index 0000000000000000000000000000000000000000..9ff2bc279f839658e707552856ab5f559093ff33
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/nvidia,tegra20-apbdma.yaml
@@ -0,0 +1,89 @@
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
+    #include <dt-bindings/reset/tegra186-reset.h>
+    dma-controller@6000a000 {
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

-- 
2.43.0


