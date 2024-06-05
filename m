Return-Path: <dmaengine+bounces-2257-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 958798FC0D7
	for <lists+dmaengine@lfdr.de>; Wed,  5 Jun 2024 02:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 143D71F233E3
	for <lists+dmaengine@lfdr.de>; Wed,  5 Jun 2024 00:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB80E17D2;
	Wed,  5 Jun 2024 00:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FtO0gLp+"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89DB2F44;
	Wed,  5 Jun 2024 00:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717547705; cv=none; b=NSAMKmoWgwYBTb9tEnf+kG0DKF/jSPanpgwqLhdDrTWFZdzCkPPhXiICiw6wu/+x12tF6LS6uIwhluKJPT+txSaQ0ODCb43tMXE/grwYM+85Del1q2RmqntmNzYVWADhH8sPqogN8n/DVBOA6EKKYqfqSmanT0SvDzjd1JmuFI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717547705; c=relaxed/simple;
	bh=nJ/nEYVjM0S0TNeLxm7CEnmYiaqvjtnz4Lb/QIwyR1I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=asvI6tSa8crDQBt4ochD5VhTE+CQNfLwk0iQ/G6gigJi90wxq2DfuXKB7jRlNFg3y8DBzRmHWhZDqJyB61fkDHS1bIjQYZmz+jIfHav+j81RporIEh6DQSteFjIDnuUUC0HncOoqbZOV7nAux3hLIkHCzOxX8ESK++eFebiGB40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FtO0gLp+; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70264bcb631so2558853b3a.2;
        Tue, 04 Jun 2024 17:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717547702; x=1718152502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aA1Z+/uHiESL1C6u0AjoSDSysxD/CrSzTPkHsaRkf14=;
        b=FtO0gLp+7OFQGV3T1UkxXxNzGbca9I3DpKpCi+WcnXePhYj3/XogGcWCGM4IhRkfmx
         1kNof7/s+CbtnFDWefODkOh/ZEKIeVtUe0/Qlj2g78uux9hMmhu2tfCnVopwGZ2Fpdcv
         dRMlFNzrhASV0tq507nhSzr9yFouKmT9xE5nEFdGbGqa2RhNMjxdowZvD/Ma6YPvqmAJ
         O54ZZVnHcip2WxUMmbG6DUrzyg4A4ZlSvIfcSZfbfmHsxpsvcP4OJ8L+4f4LUbT3b4in
         fNHcQZ5c2dtBijMpvVM/L1gSSJyQWIcwOaHRTv2BH7hd5ql8+QKom9harCpsLxoZr7iY
         hdBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717547702; x=1718152502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aA1Z+/uHiESL1C6u0AjoSDSysxD/CrSzTPkHsaRkf14=;
        b=muqtgOCyGXcpYmMT9gxU45OjZzfk00yyjyf0Ikro6TYuAVuPKmAiEO9JawKBowvOlA
         Q6tQEcQQAPGBHUn8RYieCAGoYKDEm77F5Iw4nQm9RxwohMVGsXne3DQEceWHuY7lgdAz
         LvzYmG/I3ObQWH6iXLNKFfjh/Z1lvimsxire3r7fRtmigCmHmeq1sGNmt3T0ANO1bh/9
         1cc0Xkgy9SPmVtbhmXFS16uxGLWG10zdCP7BrvLKWUp64EI19g6G7SUSKknIgFLUCsNx
         pcz8S3n3b2TctODUkj32V0Hbo3da5oMUeUbD4CZak3AeM714zqLb+2o3IqauU87cJVDL
         EWIw==
X-Forwarded-Encrypted: i=1; AJvYcCVCrIxMF+k6eaZHmHdZr6QXdFmI1EPp515niXQ4ivtMGfNJ6XB3yCfVkTgN6GnAtPcnfRbr6cvQirFxfBp+3505tXsVwugO2TPIfTfq1ajblpcN38dy0PGdDtXWu6IXvX3bzgwstFtoqbfiuATuyBbfFMBwkhfuWLKKiqAxVAM/xMiglA==
X-Gm-Message-State: AOJu0YwAK164ZMqiNpnzO057I5iyoZPd5KhLeElIBRTc+pqX9YixZXdW
	jBhxhwJBOWS/jA8ZgUJH4Fo8oW/KikaM/MsJhlWhzhAzGadUdws+
X-Google-Smtp-Source: AGHT+IECMtofxgy9m+D2qICFDygqTx1znDOV3RpwpoCHC+OgquuNMQwqWRxprF0EbPSuxaU3FXhRcw==
X-Received: by 2002:a05:6a20:3c90:b0:1b1:d2a5:c7b1 with SMTP id adf61e73a8af0-1b2b713c6d7mr1471794637.49.1717547701948;
        Tue, 04 Jun 2024 17:35:01 -0700 (PDT)
Received: from fedora.one.one.one.one ([2405:201:6013:c0b2:ea4b:30e0:4e3a:ab56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70262c7d382sm4557087b3a.106.2024.06.04.17.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 17:35:01 -0700 (PDT)
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
Subject: [PATCH v3] dt-bindings: dma: fsl,imx-dma: Convert to dtschema
Date: Wed,  5 Jun 2024 06:03:49 +0530
Message-ID: <20240605003356.46458-1-animeshagarwal28@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the fsl i.MX DMA controller bindings to DT schema. Remove old
and deprecated properties #dma-channels and #dma-requests.

Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>

---
Changes in v3:
- Changed maximum: 16 back to const: 16 as the device use exactly 16
channels.

Changes in v2:
- Added description for each interrupt item.
- Changed dma-channels: const: 16 to maximum: 16.
- Removed unnecessary '|' character.
- Dropped unused label.
---
 .../devicetree/bindings/dma/fsl,imx-dma.yaml  | 56 +++++++++++++++++++
 .../devicetree/bindings/dma/fsl-imx-dma.txt   | 50 -----------------
 2 files changed, 56 insertions(+), 50 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/fsl,imx-dma.yaml
 delete mode 100644 Documentation/devicetree/bindings/dma/fsl-imx-dma.txt

diff --git a/Documentation/devicetree/bindings/dma/fsl,imx-dma.yaml b/Documentation/devicetree/bindings/dma/fsl,imx-dma.yaml
new file mode 100644
index 000000000000..902a11f65be2
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/fsl,imx-dma.yaml
@@ -0,0 +1,56 @@
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
+    items:
+      - description: DMA complete interrupt
+      - description: DMA Error interrupt
+    minItems: 1
+
+  "#dma-cells":
+    const: 1
+
+  dma-channels:
+    const: 16
+
+  dma-requests:
+    description: Number of DMA requests supported.
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
+    dma-controller@10001000 {
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


