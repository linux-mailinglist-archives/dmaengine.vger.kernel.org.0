Return-Path: <dmaengine+bounces-6192-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B00B337FE
	for <lists+dmaengine@lfdr.de>; Mon, 25 Aug 2025 09:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D5EB7A8684
	for <lists+dmaengine@lfdr.de>; Mon, 25 Aug 2025 07:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1732980A8;
	Mon, 25 Aug 2025 07:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5XCEXJ3"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CF524A074;
	Mon, 25 Aug 2025 07:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756107766; cv=none; b=TZIKPw53KYH7zb/HOY2IoNnZw9PUvfjvdOuFQ9aY9n89ffddacpgtIbopcxGJAJ3NRSUPev26YyobtV0AxrRImtx4QzhVPWXwth5oGCkrOUMM3RH7ekJuxqgMcTF6eD+KkU0oNPiutObAmkbgmfuIY9lyKydNXMok4TepCtF4hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756107766; c=relaxed/simple;
	bh=CF3nCaQrlkAeMy06uuovK8drERouHS65tJ8iar6vLsY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mvSAg8rkLMCV+TDliBbbHYHe7ZYAfmCTSCnyZTKwRFAqTKQQy1wWKU/SODfl+z/vJ6Foseb0ft2lwqEaXfh8Jkii/UiumxbTm2tnuMrzEkQg3H3rqlywCLp6DUEAq/2fLXM5TJ0OHNELNuxoz4w23p+2vs8x83tjmMPZVcaoc50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k5XCEXJ3; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-324fb2bb058so2615939a91.3;
        Mon, 25 Aug 2025 00:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756107764; x=1756712564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+iedLlKmbf9rTuBT+gfMn79Q+NQYLm/fmWWO3YkJIA=;
        b=k5XCEXJ3o1OjlfxfaQWd0sLNV24GpXXvTq9+DQuk54Y1kzpZpMsr147sSaCNfa1MDg
         jkQwqfHbxCTlLPT5wcozPspeTf8K4zIT0/Oa+grK2d5UwIFBXZRYsZTsPGzKGdpik8VN
         7OkiTWKiJR3YaDwxBccAMbZAT7R5v2uS/KTebZ8GqknhVyHPoZJBMOp1JNUnGLJaFA+I
         /qHlwk26yFXj19eVSRdtF9o3PJVxpMgH2CNslSrhqyTLCPfPuwz1GeYc2yUHaIPCr0cK
         Y6S/CeGLPSK+9DwOUYZG0dTs54Z6QZ6vihi0oj1WMWwtn+HAsz/WLGXQhbXjvuiP7+b8
         DuMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756107764; x=1756712564;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z+iedLlKmbf9rTuBT+gfMn79Q+NQYLm/fmWWO3YkJIA=;
        b=Jkphi2peJv5v0ml6OMFrYGbI4Pv5+OEIpcaNsIVnc89krucReO0XE1YxKR4cFKHO4r
         MOlOtsp9oO9RhRDgt+42mwmf/ehAsOThcvrhnC/9SrtFtUS3++lcp1lSrhzNYcNWZgny
         4FHnqFgSbujLtkZ/BhMyitLtk8NbImT0v/kOy5Q043ZY7bXMMWugkq9YFvn8M00eE7gQ
         I2e83atsapDQ2uJwm4vJVRQHJhhr/Yjmmay9YXLQJJgMsNX7GgVmFtjwJjKJLXt+uXSY
         SrifcibOXYRu3a6zSH+UsKQaJMd/gGkRIPt7h4AZPuHKZkVP7lnG/Gz2WYeKIQ1562SJ
         0Tyg==
X-Forwarded-Encrypted: i=1; AJvYcCV4jMEVHqvIpSY02CNBpg5Y1m5YeNQrBR0IVkDzl9JXAMZZTCmW2/7R6NjWQSxvwXIAuItGJhXmyykQAA==@vger.kernel.org, AJvYcCVZTlIdOuor2gZUtod3hiehFW7FRU6y1TAVtinQnke49hw+BiPPEsrw9wlSSlmnndiLT1YHfRtIXB8=@vger.kernel.org, AJvYcCVx/Sx9wqWH4WeXCl6SSJ+Uhecc7QnV9zxZxTF99K1pZz5b47BKnNDjzA/pj5l3ZpUuau+dF4YyPdbCEzcC@vger.kernel.org
X-Gm-Message-State: AOJu0YwfKvNkHwuARiOEvBCE+Y2Y3eKVbmR9jPGUHp6jUkLWsFsdLouz
	taSw0wMy/xcdoEQF68DE4OdQOAzAVgKcGlLeEDfS6prLrSK1XG87Cz11/BtpPtcA
X-Gm-Gg: ASbGncuzpFCBonXAG1rwoL3mGOpPbbaVnmTXngzAVt2hgN5UfKyIIk2YYEbJeb6ZWTH
	GYBuTzF4Eroj7NE3KG3R/CCoUOrzJR5TqR26benbSrfwbTI/sxcaX+1JkM3eqGywiu7FkLWaxLm
	7OvKDyeF1KFMUy3XrS/n2FiwQHaXLMwzAavIM5zoUXHOWqhvs0olmlZ9XvqjuDs5Ta0HlJ9OLYI
	fg96fRTtD9G+2RlyW/vXbIdwYAGd4o2a3RpdE36oo+90X/nTDtHocu8w94Nu3NrqJRJzgVngW97
	6xLaAu5tGkitqQt5OE7XE23jlRCSUBNFwOTOvHVAwRp7Xe8I0czmdr4emdezR0XSudDMRDhtINJ
	K2BLvNDH2nsJQ06ENAnub/7rIbR3dsqZ3yTwQmjzScIJlWQ4JMGqt8A==
X-Google-Smtp-Source: AGHT+IEaUrxdiHAQTBJbTzF/2pJwOoJ4BhJ3kWnE128jOIU8pVoa9qAhPX9k9LAdpusHHPu7o458fw==
X-Received: by 2002:a17:90b:278b:b0:324:ffcf:153a with SMTP id 98e67ed59e1d1-32515eaeef7mr14636408a91.20.1756107763923;
        Mon, 25 Aug 2025 00:42:43 -0700 (PDT)
Received: from 100ask.localdomain ([116.234.74.152])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3252e7433ccsm3513423a91.8.2025.08.25.00.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 00:42:43 -0700 (PDT)
From: Nino Zhang <ninozhang001@gmail.com>
To: devicetree@vger.kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	vkoul@kernel.org,
	rahulbedarkar89@gmail.com,
	linux-mips@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nino Zhang <ninozhang001@gmail.com>
Subject: [PATCH v3] dt-bindings: dma: img-mdc-dma: convert to DT schema
Date: Mon, 25 Aug 2025 15:41:41 +0800
Message-ID: <20250825074141.560141-1-ninozhang001@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the img-mdc-dma binding from txt to YAML schema.
No functional changes except dropping the consumer node
(spi@18100f00) from the example, which belongs to the
consumer binding instead.

Signed-off-by: Nino Zhang <ninozhang001@gmail.com>
---
v2 -> v3:
- Fix remaining issues based on Rob's and Krzysztof's comments.
- Link to v2: https://lore.kernel.org/all/20250824034509.445743-1-ninozhang001@gmail.com/

v1 -> v2:
- Addressed review comments from Rob.
- Link to v1: https://lore.kernel.org/all/20250821150255.236884-1-ninozhang001@gmail.com/

 .../bindings/dma/img,pistachio-mdc-dma.yaml   | 89 +++++++++++++++++++
 .../devicetree/bindings/dma/img-mdc-dma.txt   | 57 ------------
 2 files changed, 89 insertions(+), 57 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/img,pistachio-mdc-dma.yaml
 delete mode 100644 Documentation/devicetree/bindings/dma/img-mdc-dma.txt

diff --git a/Documentation/devicetree/bindings/dma/img,pistachio-mdc-dma.yaml b/Documentation/devicetree/bindings/dma/img,pistachio-mdc-dma.yaml
new file mode 100644
index 000000000000..198e80b528c8
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/img,pistachio-mdc-dma.yaml
@@ -0,0 +1,89 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/img,pistachio-mdc-dma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: IMG Multi-threaded DMA Controller (MDC)
+
+maintainers:
+  - Rahul Bedarkar <rahulbedarkar89@gmail.com>
+  - linux-mips@vger.kernel.org
+
+allOf:
+  - $ref: /schemas/dma/dma-controller.yaml#
+
+properties:
+  compatible:
+    const: img,pistachio-mdc-dma
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 1
+    maxItems: 32
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: sys
+
+  img,cr-periph:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to peripheral control syscon node with DMA request to channel
+      mapping registers.
+
+  img,max-burst-multiplier:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    description:
+      Maximum supported burst size multiplier. The maximum burst size is this
+      value multiplied by the hardware-reported bus width.
+
+  "#dma-cells":
+    const: 3
+    description: |
+      DMA specifier cells:
+        1: peripheral's DMA request line
+        2: channel bitmap: bit N set indicates channel N is usable
+        3: thread ID to be used by the channel
+
+  dma-channels:
+    minimum: 1
+    maximum: 32
+    description: Defaults to HW-reported value if not specified.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - img,cr-periph
+  - img,max-burst-multiplier
+  - "#dma-cells"
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/mips-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    dma-controller@18143000 {
+      compatible = "img,pistachio-mdc-dma";
+      reg = <0x18143000 0x1000>;
+      interrupts = <GIC_SHARED 27 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SHARED 28 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&system_clk>;
+      clock-names = "sys";
+
+      img,max-burst-multiplier = <16>;
+      img,cr-periph = <&cr_periph>;
+
+      #dma-cells = <3>;
+    };
diff --git a/Documentation/devicetree/bindings/dma/img-mdc-dma.txt b/Documentation/devicetree/bindings/dma/img-mdc-dma.txt
deleted file mode 100644
index 28c1341db346..000000000000
--- a/Documentation/devicetree/bindings/dma/img-mdc-dma.txt
+++ /dev/null
@@ -1,57 +0,0 @@
-* IMG Multi-threaded DMA Controller (MDC)
-
-Required properties:
-- compatible: Must be "img,pistachio-mdc-dma".
-- reg: Must contain the base address and length of the MDC registers.
-- interrupts: Must contain all the per-channel DMA interrupts.
-- clocks: Must contain an entry for each entry in clock-names.
-  See ../clock/clock-bindings.txt for details.
-- clock-names: Must include the following entries:
-  - sys: MDC system interface clock.
-- img,cr-periph: Must contain a phandle to the peripheral control syscon
-  node which contains the DMA request to channel mapping registers.
-- img,max-burst-multiplier: Must be the maximum supported burst size multiplier.
-  The maximum burst size is this value multiplied by the hardware-reported bus
-  width.
-- #dma-cells: Must be 3:
-  - The first cell is the peripheral's DMA request line.
-  - The second cell is a bitmap specifying to which channels the DMA request
-    line may be mapped (i.e. bit N set indicates channel N is usable).
-  - The third cell is the thread ID to be used by the channel.
-
-Optional properties:
-- dma-channels: Number of supported DMA channels, up to 32.  If not specified
-  the number reported by the hardware is used.
-
-Example:
-
-mdc: dma-controller@18143000 {
-	compatible = "img,pistachio-mdc-dma";
-	reg = <0x18143000 0x1000>;
-	interrupts = <GIC_SHARED 27 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SHARED 28 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SHARED 29 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SHARED 30 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SHARED 31 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SHARED 32 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SHARED 33 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SHARED 34 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SHARED 35 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SHARED 36 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SHARED 37 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SHARED 38 IRQ_TYPE_LEVEL_HIGH>;
-	clocks = <&system_clk>;
-	clock-names = "sys";
-
-	img,max-burst-multiplier = <16>;
-	img,cr-periph = <&cr_periph>;
-
-	#dma-cells = <3>;
-};
-
-spi@18100f00 {
-	...
-	dmas = <&mdc 9 0xffffffff 0>, <&mdc 10 0xffffffff 0>;
-	dma-names = "tx", "rx";
-	...
-};
-- 
2.43.0


