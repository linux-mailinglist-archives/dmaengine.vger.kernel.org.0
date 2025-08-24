Return-Path: <dmaengine+bounces-6181-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0259BB32D63
	for <lists+dmaengine@lfdr.de>; Sun, 24 Aug 2025 05:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6CAE4425A3
	for <lists+dmaengine@lfdr.de>; Sun, 24 Aug 2025 03:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16481DE2D8;
	Sun, 24 Aug 2025 03:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1GyrSCy"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0160119CCEC;
	Sun, 24 Aug 2025 03:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756007120; cv=none; b=Zu8y4/cGb12xGhsdjSDL/IWMUjMtLE+1jVrvdDMEcplyo9j9qrVgOwAH7asIP4vBMNWuVdhx6b4ohiF9kjyDTXG3/cddGl9HauqmOclGFvik+fT6hG1vsuNWtSimZwHIK++hoRW7sTKX2xj3uv9pCGXicj7b6+9GlyMejTJSphM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756007120; c=relaxed/simple;
	bh=Fobfznerq163i338BAGNATR36BkRUL2Fo6o5aL4g2TQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cssb3/GKZ7Md7jqvkYJpiXf2q1y12MzVC7EhN3mlrqB/76a6CX3z/Zs21TPKdVQfmmeDod1ZMB6NfPojHCzufFsVDH+JlUEGOQzoX5hUPjJShNircJYlqauRWo2oLjr4OHHsQPtnLjKlvqWnxiZrqkzSF+9UIpQcWxSy5+EZRHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H1GyrSCy; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b476c67c5easo2081223a12.0;
        Sat, 23 Aug 2025 20:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756007118; x=1756611918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7KqycpELhCWaVApA3dTlAE5icBtVyPG6RcdSJ5TYwHo=;
        b=H1GyrSCyxiydizqLNpnrKEpvzbOmHsWh/VMxV29KQYfx3o9mmhKrPfpxcHNlPgEuaK
         2xtxuV6UvqjUwT4dQSyDPRWi/+r7cOWHPwDb4CcWs+c6THcxPF4Ztiw+J+vjLZebYuLw
         EW25so1y6dfBfb8c4wxSw9xjRB7WoY4Vxe7mC25XGOcRQ82/bchEd7BNDSUJBb+wpG17
         VtLwDMKy+sW7k9vCVVBlepO+Sf71f1TCryoVUbV8AAG4P/DanXwFyg8ZgHAP5alQJrEq
         gP55t0cNxiEMIi9BAs1dN1iG7kIgwWp9GKWe3/qU18Az1hYfZEhgLmFR/0aeQrExfovW
         w2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756007118; x=1756611918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7KqycpELhCWaVApA3dTlAE5icBtVyPG6RcdSJ5TYwHo=;
        b=p4EPvY7oMe5+0NAU2L64H9O3dWY9ekvdAL17yBK3ZgO5E8yO3jOZHFFDq8si5jyJnF
         XEiNzrqKPzjc8RhL7d14BM5FTMkEafPB7lH96+BCmLj03n63S7WySKJgbc0heomIcz/H
         vxdmHQ3ZnRwJ+ESXRi85DeFUVs3uSO0XlWJr7VhB5uYwwrzo2f4gIepG2UWGobkCuOvC
         G9xsXG+zN8lzh3eIx9oiF/MVV+/n3DGao5bWeOS8EvcJ771SVfKVtoWwG1DyY3OYkcd3
         o/7TgA2qEjCH8fKt/DZZL9WVNyjcXM4qEDAaSu9bYG7w/p4AvPB1V/DG43MhXfi83Dra
         IKhA==
X-Forwarded-Encrypted: i=1; AJvYcCUegiYD3Thm5nYRbxNWtVxpJFY1JWbe1fp08jcoizSZwoZLU8xaE+m6LnKcE2wd++6fdDR9oixGoLY=@vger.kernel.org, AJvYcCUk6UFpXICTkpSVfR6JJZqPGBAnOdaxGqBZfIJtI9vr2wM6ENUVdXfw/+8OVacDnksQlaS+Z1o+6QK0YQWb@vger.kernel.org, AJvYcCVUo3n52Z1DYq5JaoNKXJonmQxiom1Vd941l8X4HkJrIWiM7xuGIj6WGofvBJC+wZk/OFGdP54UPYY68Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxNeNy2a2EF2oV6/vp11f50jw2+AjOjcuxcuisZjs+s+5uTunw3
	TOAYDgpMX1nbs+8O9nASFfiDxNyZfu5sBGp1Qm0mgjhn2RXQUzKxN7w2I/IwgQvp
X-Gm-Gg: ASbGncvQDAj2SEDakOYsny2hp2Bi7RKHrQymDgV1JiRLXMiCuVNaT7ludMNb7rnJ+Yl
	jQAkqKo6kBZM6SGYjsPBnvNwaqlmZL8gNhe0WGrd2NUkpihTtIYfKusFWDQ2PD/5m+x8K5dQT2J
	8aC6ySRFYOrEC6NN30FOGTrg4kiPmYVLUpo/TpUrDAcTIZj4KIBbOBKXiJzugrzlMvohx4OiO+z
	zQ/IH8cMqrjaXOltp0uLQvWz6pGfl0o7g/5UMbi+qoS63BURcB3AVks+ogauGS5mYpbjmNg92uN
	Hfovf2cxHm3sttvGrCwlXCDeJfdForevkIBtQoyUarBynjYGxbHL2PcrpVx7PhbHTPxV2G0++U0
	4d0OukeCwXCYSZIR9Lu5f9rAaKxvcpZCiqsrdkd/Dbj/rrWYiPDsH8g==
X-Google-Smtp-Source: AGHT+IHhhmvTD0z6paM5o8siIs3IUwj8S/aQcL+EZ/xGaDk7HxEkYscU/Ezyh2RqpPyvpIhDvynD9g==
X-Received: by 2002:a17:902:f711:b0:246:a8c3:99fe with SMTP id d9443c01a7336-246a8c3b8e1mr15090055ad.9.1756007117716;
        Sat, 23 Aug 2025 20:45:17 -0700 (PDT)
Received: from 100ask.localdomain ([116.234.74.152])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24668896cb9sm33474565ad.133.2025.08.23.20.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 20:45:17 -0700 (PDT)
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
Subject: [PATCH v2] dt-bindings: dma: img-mdc-dma: convert to DT schema
Date: Sun, 24 Aug 2025 11:45:09 +0800
Message-ID: <20250824034509.445743-1-ninozhang001@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250821150255.236884-1-ninozhang001@gmail.com>
References: <20250821150255.236884-1-ninozhang001@gmail.com>
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
Changes since v1:
- All review comments addressed.

Open:
- Maintainers: set to Rahul Bedarkar + linux-mips per MAINTAINERS entry
  for Pistachio/CI40 device tree. This seems the closest match to the
  hardware. Happy to adjust if platform maintainers suggest otherwise.
- img,max-burst-multiplier: defined as uint32. A minimum of 1 is used to
  exclude the invalid case of 0, but the actual supported range has not
  been confirmed in available documentation. Example uses 16. A maximum
  will be added once confirmed by platform maintainers or hardware docs.

 .../bindings/dma/img,pistachio-mdc-dma.yaml   | 90 +++++++++++++++++++
 .../devicetree/bindings/dma/img-mdc-dma.txt   | 57 ------------
 2 files changed, 90 insertions(+), 57 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/img,pistachio-mdc-dma.yaml
 delete mode 100644 Documentation/devicetree/bindings/dma/img-mdc-dma.txt

diff --git a/Documentation/devicetree/bindings/dma/img,pistachio-mdc-dma.yaml b/Documentation/devicetree/bindings/dma/img,pistachio-mdc-dma.yaml
new file mode 100644
index 000000000000..4dde54a17f52
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/img,pistachio-mdc-dma.yaml
@@ -0,0 +1,90 @@
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
+    description: >
+      Phandle to peripheral control syscon node with DMA request to channel
+      mapping registers.
+
+  img,max-burst-multiplier:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    description: >
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
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 32
+    description: Number of supported DMA channels (defaults to HW-reported value)
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


