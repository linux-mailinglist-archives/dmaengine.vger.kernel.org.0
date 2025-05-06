Return-Path: <dmaengine+bounces-5071-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDAEAABC31
	for <lists+dmaengine@lfdr.de>; Tue,  6 May 2025 09:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CD9B189DBAC
	for <lists+dmaengine@lfdr.de>; Tue,  6 May 2025 07:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6117E22ACFB;
	Tue,  6 May 2025 07:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOwsGBw8"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BF9223DDC;
	Tue,  6 May 2025 07:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746515366; cv=none; b=azmcdqldf+egXjxYai9DmE8tCiODuX7cTeCSC8liEru5UopFnMbApAHaZVALzkhJQtom/rrd64nmpgz4XTqpwP0o2v4NhO2C4RHfCeWgDdTwjRmh/wag7lvUXbfwBiH11eCzENLXX5VJIYUNsYPOKsD/mImSOg2G5HUb3gRT5p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746515366; c=relaxed/simple;
	bh=P5EmTiMSeLYBzJfWXs1YT/MElCklreU1qLGK902UT3g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ATcvEE5S3c5NMQmgj3q0qz0dndjiVaoWrIl9TA6pZyDyrAojh6zEoeEA3xY55nMzZ8cYe3KU0biHNnHrZ57xS5epbe8q1TNp0EU4k1O1nGbd1L5AZHauAmiv2eHSbB7z9L6Q7t2jg+zPFoICO2A5RCm6eDfZDMNQjJj8bSoAXc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOwsGBw8; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7394945d37eso4404260b3a.3;
        Tue, 06 May 2025 00:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746515363; x=1747120163; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ya+cfQw4BioH1SaVqdcgbuSQ7TM9XaNzAHTMfg0Yoy4=;
        b=VOwsGBw8QsgDyfXOPaMLWcuxs79QkNrGUOa0+ELvcohKrgtjkQ8MtWPPI2U/6xLtT5
         MrGRP3BpkAQB4B4X03Th/gP7NZWVU5kH50XmMJUoZbvgGbJy5ajFoD5SmrEvlQq9Bekr
         BOd+oifr3233A4Hiz004YiEgadB2FGz434yrfekr0Yas54o6KLjCU/me9tgNBiPHtb+z
         d+oZS8rfrkb41WKmfU/YZ6JC/6sBsWvWMCds/+hoOINf6uKjbrWPUvudLyN85UJFFcn2
         P3HLb8y0iPSRze7t6tnfSaXes0Zpg0+hP4BShAxUXMGTpHqYkLO1B2+TkUi9hs4qbYBI
         ROEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746515363; x=1747120163;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ya+cfQw4BioH1SaVqdcgbuSQ7TM9XaNzAHTMfg0Yoy4=;
        b=U0c1lwZHJHRAQ6uz6lwoJkYYYC5GPZlXrwn5HtecOTtVeygsrHk/q1sTC6fV8BPWJW
         5R9i3N/pXkAUMo4hzer9PI1p13fEgx+EqRghcTii5yFMha+RtYA+dBZ6qcENnJJlCVdQ
         8sD72AXDXYNULgJLv4tP939Ro3lZ91HR5u4ziKvaektEYjnn8qoogAYjG/xpcCfBceTz
         uzt9o/Rm5bDEs6aYDImfdnVh2IL60fEZNRxXIE05hkWCzlbgnpd+R/6QcPndS3R4KV+G
         8dFQca5HxuT5CsLw7HD9aNm19UqDFoSVeJnhCVU7nO83grdbz6pMusw3GgOGh9p74/i+
         D1vA==
X-Forwarded-Encrypted: i=1; AJvYcCVl9UEtAOZ1JA3xX6dcl12el0wtluu0dY7L41dJObl2J74Ch3xwebV3Qhkk6xzgx5i961qwfItwVwzhK/I=@vger.kernel.org, AJvYcCWqp9I52I3wUZaoF5oX2lizdTF3JqmYMB3fcPuIeXstAWuv3wB/6gEKAAOjR3ctWD62WF1GEBkhwl6y@vger.kernel.org, AJvYcCXz42pJMNfF0CLgo0kgMDZF6zkKu51UmiTKH8yii9x78RG1FKZ4/YHUlv7ELHRFo+9OPJKRRHcF20Ggxdcw@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3qhitxFT1YR2COQIcPP5S3IxKixvcNpFKy6M3B+t10dlF1MyU
	Nam1kkDGZyGyutl0im3CZnYIMPIGMe76HOoM5A3eclIIA+66f9bVwzZlkLvD
X-Gm-Gg: ASbGncu2EzwAbGmPRItT81zXAFBwYCzl8RZIY0+NrwD7Bv0rhAbvE7UetHNKol27XeO
	rD9nA/pPSsPk99xUzcdp9frz5KspQHAtIGGogG1mrJ6Hs8g+FBWDHxB4dcDMq+YS8S/N6Rt6uZo
	Vs2Pf4/0zbTGTsrEMH4j7v8/eSYQ8y4gO7baW77QXBuwdHxfALVh5oNa6emu0bWbbTOwIkI0ZEf
	9S7czjBaGCbYQYhvTNdbhVXcnix8KrUMiYpbbcQpeQ5z8r6XAYDnWbuzP8O6ktLWGsGZ7Bbp7QF
	JKgNLaz9msQ7zGVENaI1gD9DhJCxB+/7iupfyj6leFeT5CjDzw==
X-Google-Smtp-Source: AGHT+IHfygRWfg5iEaEenRq3QwT0c16gCKWtMWIvkYbKNonhq9V6auiUyilKNVqcQaBfH4wcd4Nclg==
X-Received: by 2002:a05:6a00:44c6:b0:740:6630:633f with SMTP id d2e1a72fcca58-7406f0adc51mr15563131b3a.8.1746515363530;
        Tue, 06 May 2025 00:09:23 -0700 (PDT)
Received: from Black-Pearl. ([122.174.61.156])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-74058dc768dsm8124025b3a.72.2025.05.06.00.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 00:09:23 -0700 (PDT)
From: Charan Pedumuru <charan.pedumuru@gmail.com>
Date: Tue, 06 May 2025 07:07:28 +0000
Subject: [PATCH v2 2/2] dt-bindings: dma: nvidia,tegra20-apbdma: convert
 text based binding to json schema
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250506-nvidea-dma-v2-2-2427159c4c4b@gmail.com>
References: <20250506-nvidea-dma-v2-0-2427159c4c4b@gmail.com>
In-Reply-To: <20250506-nvidea-dma-v2-0-2427159c4c4b@gmail.com>
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
index 0000000000000000000000000000000000000000..8a6e0fc9897550815c21beb179946856f8db1b16
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
+    #include <dt-bindings/interrupt-controller/irq.h>
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


