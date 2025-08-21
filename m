Return-Path: <dmaengine+bounces-6101-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC53B2FDE1
	for <lists+dmaengine@lfdr.de>; Thu, 21 Aug 2025 17:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7233BAC2850
	for <lists+dmaengine@lfdr.de>; Thu, 21 Aug 2025 15:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5EF26C393;
	Thu, 21 Aug 2025 15:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/oPIkoz"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179B8258CCE;
	Thu, 21 Aug 2025 15:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755788623; cv=none; b=miu56zdXSWIBfa6Ryb+mSP63TtgLVmI2HGCuHCpDGdsNUFk9qqR3nr92lzIfsaKP83b+CU+iSX2AjuZ0+6Zw7egWz6xqd6Bm1AQ3c70+6uBjP5Zy2F5VLc2hXia2l2NMoaVsEYv4nlBjBDcVDet106u2GzR7vchM8AnKcgfkUnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755788623; c=relaxed/simple;
	bh=h371o2hzH3tZKoqACDWOVEr36SHsFleFuZ1OPZTfAcY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rif2vW86uqOKL+hd9PE614DfqUGqVtdE8QJxfwfsY8KAc61sDE49lJFUxtDC9HHIapsUlPYfoENzAGB0v8fEYBqUBKfs3PsCbI+gdl7NHA2bRPMQ8vUHlFpSfGgDizbw9xr6O+nTJ6uOz551Uyk9eRQYXh2YADdHw8fj22Aym2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/oPIkoz; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-321cfa7ad29so1695755a91.1;
        Thu, 21 Aug 2025 08:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755788621; x=1756393421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a2XqFRw9eH+6wkvyUC3rjDH+my91KUOFvRO62mw4XIM=;
        b=F/oPIkozA0SMc7khg7b7JhN6ZYvkLtN2OL+YJMDNGilKQmTs8tXtIjIuu9qT9HotgC
         KszP2tnVyn3suAgh0EOVXypsi0tT9xm8n/BkCslJfQmNv3q0O2Y2p9xsED2pWl0SqngZ
         wfpv8Yg6nKG9px1p76eeMkwKwxhCpZbE/ksjGDJgCa2cCHVO0qAVxOsc3w8CDrr1scRt
         a00qSAk80BQKmMjBl2G3xVAuK4z5pRQaz7Th3rkMrWErQpI24CbvbAg/dMKit8YJZhxa
         T0K9OYqczw4r7TIQ3kP5n4xm0DYYLFavIvhogzghdNM9PNELwbn38QSSDBrDhiMRajYY
         BtvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755788621; x=1756393421;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a2XqFRw9eH+6wkvyUC3rjDH+my91KUOFvRO62mw4XIM=;
        b=dpSqrOLaL0jA+Pa+1iy88qopDwCGNfSta/1Jn2GHRAB/BrKWeb+QoYMD3AbNl6Ck9O
         G3wCvl1z3QoEjhz0Bkku2ABsFnfdzyF69Gu/Jwg+8+6nht2CIO2TgHMxQG03ADBxPHLk
         BSddfJ+IFD5Bj2MYHmTYRrTJ5UWSAN/BUC2aNIT4j4V1UFjPJOWU8lB6QcIytLTJU0CO
         gtiY2mg69fWg0GBCF61Z9yrqGebKsmh4xqgLSMG8K5IFHigSSWkRzEuU9gs1Jb2TKsTo
         hkqpnp38otNHm0lu/NkMkoURfyQXFUuiV5+Q3dmLoFHDEINZYmZlq4oFX5MhD03FzghU
         uiFA==
X-Forwarded-Encrypted: i=1; AJvYcCUivplRwVNjrNNnfP3esMrxvhsL0cVBlmCsQ2cp7QPL/Gu1b+a1UizmcQFmbPXLtNgnRp7QcrOwh5kx74wl@vger.kernel.org, AJvYcCV0XPLxPyY/H54mSyDl+XcudTIDmAN74Z2oAU2OPSPBbC4k5Kp+pp8nYSev8k567qi5DPyTgFEQDtXP@vger.kernel.org, AJvYcCVE5DnPQaenmxCP347ZsFHvxhDqnnEq70eER4zAjQCvlhyOKaplZVq9IDkDl1ZD2oTgX2rIm90beX3j@vger.kernel.org
X-Gm-Message-State: AOJu0YzS/SvV8ZT+TsuMNZAgjDDRXv7O3lwuC9LshxIVgH4/HQ57x8zF
	bDZhQuKrAz5ILhUTy0bLnTb7Nes73IpBEYpJ1AOnsshtKyLoY1f7uNefdJFsnQ==
X-Gm-Gg: ASbGnctBI6PdJMN0GzzV8x+Xn/YOnTeFC1RB87iNWrFvf7oXkwGt7rOnGOA+r/cpQWa
	Qp85wDF7tLdOHZ4z94Ji8vKwkJkjroJ00U3kP42rhj1vKXD2HBivo/w9vhw0NIV/Lb73tCGSSzc
	ejI5EjhN/UvtWRTSx0c0pWJQ+CKE/IBkPOb1k9lNjo+RkAjxGWKqaZPaBuAmYeI+tXXaRJxYgLt
	OFnaHcEsdF4jGUItk+xH1uMKQEJD6tIwdnYeKvSmv2cc3hVvZITF8K2ysxiPV6OWH/n0zQ5f9Lw
	Mr9D9ST/s4S81AcMxWcY6oPNEr+T6TX8R7+QsrPGBf7/DJ19s77PMzWiLdkZS+C9NUdjGinefDw
	cM9+kDwccsH52fkeD3slcP92OUosAGKGzJ4y5ro57iprUBYkZXJK/eA==
X-Google-Smtp-Source: AGHT+IGo51RnWNkJJqoY3Tb/drct9JSrKqU6imDiOlEGu0tkpF0QxW7Ed4K86cDj1q3P/AkaZXvv0Q==
X-Received: by 2002:a17:90b:4d06:b0:321:82a0:fe50 with SMTP id 98e67ed59e1d1-324eed1c184mr3024224a91.5.1755788620319;
        Thu, 21 Aug 2025 08:03:40 -0700 (PDT)
Received: from 100ask.localdomain ([116.234.74.152])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32512d83c22sm30254a91.9.2025.08.21.08.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 08:03:39 -0700 (PDT)
From: Nino Zhang <ninozhang001@gmail.com>
To: vkoul@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nino Zhang <ninozhang001@gmail.com>
Subject: [PATCH] dt-bindings: dma: img-mdc-dma: convert to DT schema
Date: Thu, 21 Aug 2025 23:02:55 +0800
Message-ID: <20250821150255.236884-1-ninozhang001@gmail.com>
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

Tested with 'make dt_binding_check'.

Signed-off-by: Nino Zhang <ninozhang001@gmail.com>
---
 .../devicetree/bindings/dma/img-mdc-dma.txt   | 57 -----------
 .../devicetree/bindings/dma/img-mdc-dma.yaml  | 98 +++++++++++++++++++
 2 files changed, 98 insertions(+), 57 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/dma/img-mdc-dma.txt
 create mode 100644 Documentation/devicetree/bindings/dma/img-mdc-dma.yaml

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
diff --git a/Documentation/devicetree/bindings/dma/img-mdc-dma.yaml b/Documentation/devicetree/bindings/dma/img-mdc-dma.yaml
new file mode 100644
index 000000000000..b635125d7ae3
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/img-mdc-dma.yaml
@@ -0,0 +1,98 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/img-mdc-dma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: IMG Multi-threaded DMA Controller (MDC)
+
+maintainers:
+  - Vinod Koul <vkoul@kernel.org>
+
+allOf:
+  - $ref: /schemas/dma/dma-controller.yaml#
+
+properties:
+  compatible:
+    description: Must be "img,pistachio-mdc-dma".
+    const: img,pistachio-mdc-dma
+
+  reg:
+    description:
+      Must contain the base address and length of the MDC registers.
+    minItems: 1
+
+  interrupts:
+    description:
+      Must contain all the per-channel DMA interrupts.
+
+  clocks:
+    description: |
+      Must contain an entry for each entry in clock-names.
+      See clock/clock.yaml for details.
+
+  clock-names:
+    description: |
+      Must include the following entries:
+        - sys: MDC system interface clock.
+    minItems: 1
+    contains: { const: sys }
+
+  img,cr-periph:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: |
+      Must contain a phandle to the peripheral control syscon node
+      which contains the DMA request to channel mapping registers.
+
+  img,max-burst-multiplier:
+    description: |
+      Must be the maximum supported burst size multiplier.
+      The maximum burst size is this value multiplied by the
+      hardware-reported bus width.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  "#dma-cells":
+    description: |
+      Must be 3:
+        - The first cell is the peripheral's DMA request line.
+        - The second cell is a bitmap specifying to which channels the DMA request
+          line may be mapped (i.e. bit N set indicates channel N is usable).
+        - The third cell is the thread ID to be used by the channel.
+    const: 3
+
+  dma-channels:
+    description: |
+      Number of supported DMA channels, up to 32. If not specified
+      the number reported by the hardware is used.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 32
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - "img,cr-periph"
+  - "img,max-burst-multiplier"
+  - "#dma-cells"
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/mips-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    mdc: dma-controller@18143000 {
+      compatible = "img,pistachio-mdc-dma";
+      reg = <0x18143000 0x1000>;
+      interrupts = <GIC_SHARED 27 IRQ_TYPE_LEVEL_HIGH>,
+            <GIC_SHARED 28 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&system_clk>;
+      clock-names = "sys";
+
+      img,max-burst-multiplier = <16>;
+      img,cr-periph = <&cr_periph>;
+
+      #dma-cells = <3>;
+    };
-- 
2.43.0


