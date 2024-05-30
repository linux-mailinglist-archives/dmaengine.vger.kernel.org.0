Return-Path: <dmaengine+bounces-2211-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D0B8D45F5
	for <lists+dmaengine@lfdr.de>; Thu, 30 May 2024 09:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6A5228457D
	for <lists+dmaengine@lfdr.de>; Thu, 30 May 2024 07:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99F87316F;
	Thu, 30 May 2024 07:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZeFwQfqD"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565011CD20;
	Thu, 30 May 2024 07:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717053719; cv=none; b=mwUbb5ei7d8AqdfudnVeJEMMCe+4fQTRVv4y09YNfAPxUw22DtSzZvvjm0Jzz/O+oTh/s0oSWpsOejFTyFATuYay61VLKANxfg0/l6bsTaik7hp+Y1Jivl3VFEddCicekq9Ynuzqrjs1Z94vInQ8FuVW6hmIofX2fvcX9uuBdPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717053719; c=relaxed/simple;
	bh=jJhmiG8KehPBL2jJ7s4/R8p14YnNFAx4zWKUCdgG0Hk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E4V6E/3Ce7MqSiKftOGNMuY/IWWlxh5+ZuudCO5PlY3+PJyR+qBiMysJnrgROFmDz5T5v5XrvBoiPMgRkcz5b7za/xBXcdWd/fG/gaVswOCg4P0+/inEVKabc8AihNRWSa3L3ZRE46OXGYath/LxVAsXP1KypZJRyOpkl7ABbM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZeFwQfqD; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70109d34a16so518822b3a.2;
        Thu, 30 May 2024 00:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717053717; x=1717658517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wwEQ2aSFxNGCmqcaa7Y6YTRAbWdn03vUjAsreQHummw=;
        b=ZeFwQfqDe+F0kn8I/hOyzNNKMNv8zQ2JRNGNfVMNoXLX8cUEirlNhykPFwrHz6lLHK
         HL2cNSJLi2j7JThtD7xGwyuS6T2gDErsY3UCs1NIUmsGesWZksJSo9FsnCg1Uq9wa6BJ
         WUBZO1LQXbvR+j+/Ta6sxv+7lN1Xi7/RV1EVjZvWQ+DFC8J2BIec02fvNaK9LSUSCXNX
         NLbFlkr8JSUu8jjCwoB7P+x4aPL55nmiGloqO2w+ky5fRe4qwN1eTe1ob/hevzg4PjEi
         l3zhBWJ71BiHe1rTqZzOqtwAFTtisEZD9F8D0KAxh/9jT856VSxazFw0OsRrVHk2l6nt
         vLwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717053717; x=1717658517;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wwEQ2aSFxNGCmqcaa7Y6YTRAbWdn03vUjAsreQHummw=;
        b=aZkXVyDsgBcnh2IGLcMbcRLQc4pm1615ZUHf7BzSO6PAi4aAwngh3Q8+tRUA59VS6n
         y5rXGeRLwI7DMlH5a2cd6lDZrFoHroRREkToje0dQUsEY4GGlZXeGuHdt2PMEa+q+TGt
         rkdhEHB5cAA6fnNXsyuhmgJytIlot7On/LnLlivttqt7cEsPV84NTlpCYpdzsY02LQUF
         z3RHasEUlVN3TrwC86eox0TTBj5s+C5T2lDz5PTdCuvS0hPzOiGgqRXgq/uCbN+JaZom
         TOkS0p2zdx/PwCPcRskeemoMtz+ChlDSkRG91hes0ELDzLH5JjVM2xH2qAWKjekUdmmR
         oTtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWd339fuhkKguAofJt5Rb75yTq5As4vm7EGhcU5BZiKAv0j5S7cxOxOgtX3m+2zZXOFEfHGxJgl5nxaSLWtkjpOR+nOvtColzNCDxzz38whWz8LdjQWpQFIWo20NvSarMz5pqzNVqAyhwYoSjyHW245n1yjRZ46Hei2pMvSsHIme7A9Vg==
X-Gm-Message-State: AOJu0YzI5HN4W5sv/Jn2mLtVUgW4/XOsy7Q2iDeEzDCwQMpUhA6eMBoW
	gNMSPdCDpGDTZ6s3LihnHtLHjz4vyFoTSMa31v78BeJNpg8bD4F9
X-Google-Smtp-Source: AGHT+IHm8CThq7x4u28tGzaiRwu0dXSkjGYx78ZeeID2h/0ElC/teNL2bCFK3G+FY+BOPAg92MAnPQ==
X-Received: by 2002:a05:6a00:2909:b0:6f6:9601:b0b9 with SMTP id d2e1a72fcca58-70231116613mr1179612b3a.11.1717053716346;
        Thu, 30 May 2024 00:21:56 -0700 (PDT)
Received: from fedora.pi.hole ([2405:201:6013:c0b2:b3f7:7c95:a370:4345])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-702390b6fa3sm88609b3a.119.2024.05.30.00.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 00:21:55 -0700 (PDT)
From: Animesh Agarwal <animeshagarwal28@gmail.com>
To: 
Cc: animeshagarwal28@gmail.com,
	Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: dma: fsl,imx-dma: Convert to dtschema
Date: Thu, 30 May 2024 12:51:07 +0530
Message-ID: <20240530072113.30410-1-animeshagarwal28@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the fsl i.MX DMA controller bindings to DT schema

Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
---
 .../devicetree/bindings/dma/fsl,imx-dma.yaml  | 58 +++++++++++++++++++
 .../devicetree/bindings/dma/fsl-imx-dma.txt   | 50 ----------------
 2 files changed, 58 insertions(+), 50 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/fsl,imx-dma.yaml
 delete mode 100644 Documentation/devicetree/bindings/dma/fsl-imx-dma.txt

diff --git a/Documentation/devicetree/bindings/dma/fsl,imx-dma.yaml b/Documentation/devicetree/bindings/dma/fsl,imx-dma.yaml
new file mode 100644
index 000000000000..f36ab5425bdb
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/fsl,imx-dma.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/fsl,imx-dma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale Direct Memory Access (DMA) Controller for i.MX
+
+maintainers:
+  - Animesh Agarwal <animeshagarwal28@gmail.com>
+
+allOf:
+  - $ref: dma-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx1-dma
+      - fsl,imx21-dma
+      - fsl,imx27-dma
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description: |
+      First item should be DMA interrupt, second one is optional and
+      should contain DMA Error interrupt.
+    minItems: 1
+    maxItems: 2
+
+  "#dma-cells":
+    const: 1
+
+  dma-channels:
+    const: 16
+
+  dma-requests:
+    description: |
+      Number of DMA requests supported.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - "#dma-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    dma: dma-controller@10001000 {
+      compatible = "fsl,imx27-dma";
+      reg = <0x10001000 0x1000>;
+      interrupts = <32 33>;
+      #dma-cells = <1>;
+      dma-channels = <16>;
+    };
diff --git a/Documentation/devicetree/bindings/dma/fsl-imx-dma.txt b/Documentation/devicetree/bindings/dma/fsl-imx-dma.txt
deleted file mode 100644
index 1c9929d53727..000000000000
--- a/Documentation/devicetree/bindings/dma/fsl-imx-dma.txt
+++ /dev/null
@@ -1,50 +0,0 @@
-* Freescale Direct Memory Access (DMA) Controller for i.MX
-
-This document will only describe differences to the generic DMA Controller and
-DMA request bindings as described in dma/dma.txt .
-
-* DMA controller
-
-Required properties:
-- compatible : Should be "fsl,<chip>-dma". chip can be imx1, imx21 or imx27
-- reg : Should contain DMA registers location and length
-- interrupts : First item should be DMA interrupt, second one is optional and
-    should contain DMA Error interrupt
-- #dma-cells : Has to be 1. imx-dma does not support anything else.
-
-Optional properties:
-- dma-channels : Number of DMA channels supported. Should be 16.
-- #dma-channels : deprecated
-- dma-requests : Number of DMA requests supported.
-- #dma-requests : deprecated
-
-Example:
-
-	dma: dma@10001000 {
-		compatible = "fsl,imx27-dma";
-		reg = <0x10001000 0x1000>;
-		interrupts = <32 33>;
-		#dma-cells = <1>;
-		dma-channels = <16>;
-	};
-
-
-* DMA client
-
-Clients have to specify the DMA requests with phandles in a list.
-
-Required properties:
-- dmas: List of one or more DMA request specifiers. One DMA request specifier
-    consists of a phandle to the DMA controller followed by the integer
-    specifying the request line.
-- dma-names: List of string identifiers for the DMA requests. For the correct
-    names, have a look at the specific client driver.
-
-Example:
-
-	sdhci1: sdhci@10013000 {
-		...
-		dmas = <&dma 7>;
-		dma-names = "rx-tx";
-		...
-	};
-- 
2.45.1


