Return-Path: <dmaengine+bounces-2220-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3138D5DB8
	for <lists+dmaengine@lfdr.de>; Fri, 31 May 2024 11:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89BEA1F2299C
	for <lists+dmaengine@lfdr.de>; Fri, 31 May 2024 09:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E944158A34;
	Fri, 31 May 2024 09:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="diRdJuWk"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249A4158A08;
	Fri, 31 May 2024 09:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717146318; cv=none; b=Vdku7if5/no360Xd2vCo6byOcJBzWNKLkc03JCPPqlgVdxvr6yms7A2PffCT1y3bAtmLPvvlUJGhTQK9KOioHcXhJal0wc3E+ISVGPUIKUnR41nrQ4pIOP0k50unw3j9+oGm21XH0xiVCN8mXVAVYeJqpY2yI+k1ItfVpGAy2BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717146318; c=relaxed/simple;
	bh=l9od8fUQjOt1e50pDgBVKHh7h1Sq3qEMWS9k7Ol8kHs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZixX7PhmDSSMT6Y1RDJNe0G1FJ5Q1YpZ4NmxLjfWGtG3vk0sOuoSudkzkL2qVD4X3nVhrkdZCxt8/tafl26xYQYdzl007UflcY+xXNDuNWWPJTc7/zmmRcK2aTBV0hqK+lweFDRxIHHNxt+rTI9PHVa0Ihk5z6WKJYosReap/4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=diRdJuWk; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f63642ab8aso3920845ad.3;
        Fri, 31 May 2024 02:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717146315; x=1717751115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cIqlWuPqBxRMmc3AFgZJ/wVDP6Hh20wzHjGm/ayLPpw=;
        b=diRdJuWkEJBpje1sMRWu3ZQQJhRjgeBTfzhyZwQ7VPHwmeFrnwwbY1yJBWL77L40LV
         AitIr0qXXoI+AQ5104uKe0SqoIN5yzF5PjiuyHv0z2WwtHAFbmxhq4vRQY+BIdbJEs6C
         JyWxHwVB3T9OqlcZuv+KuA2IpleQZWFT/39xVlCbDcpQewgZMZIhaZ/w4/HUhMbZj7ES
         JCD+U8OZ0+GMXBD4IgASM4li0/ydwAJUwNv5BC4/axyaSTiym2Ioddt/zhtpijz+LCoP
         qHkebbTJwBF7IYCJkqT4elJ3VNgIIIbAp4q0KTN0JejSuEFvLKUKpe0mLCSBkxqQ1RaS
         1JoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717146315; x=1717751115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cIqlWuPqBxRMmc3AFgZJ/wVDP6Hh20wzHjGm/ayLPpw=;
        b=bagoR4PbFJAKf4z2YiOAy2ITQEj8qdIdt0hAAbCb0FZq3yz5YwO3b3uXzd7D+l7I0v
         pJHcS7/vG6bBDNO/taz8T1MYOdi+wBkSf12JsUFw31epS7WnnZQdRD60peDzg1UIynAw
         KS9vV/IDUUEqDuLs8J0eRI9ElFexaUawjorv/xlSrUkzOOilEOaido1OW3O2fKFcKO12
         FrmgXIlzALTdapZguaT7H9ORQBc6i1Xy5M5U4sZhR8QOtpj6kNXzi5plGMoz4RN+nOu8
         E1frm0cNPwvo5FHpOA06zRgr04tgfehIOiGYFZZ+pMrPsrqPdhh9ZAMHDMhRXORgqxsa
         6u6Q==
X-Forwarded-Encrypted: i=1; AJvYcCU3cuFw+LtE5glYGIk4Hg5wBz8YqXMIuc+fV06APw+u1AVEfNdDDeY/mxWppMcQ3Zhr7oVn5iLhBcwtUNOVsGxlqDXofv3SvX0k11/hQo6skq+8b72Pk6VI6BmG8xpqsDFPV87rUiOkmvTNkXMEgTrRmuFW32OcbtCzgXY6KYHFztMqpQ==
X-Gm-Message-State: AOJu0YzP8PtKtpbeXpiosaqhQWegqtl55r/7l2OWofm0RF21X8qywS5X
	Gs1SG5VomtKBKd9K6E3QZqHb03yesHLFUAPZx3ROslZ4KFpcCjRj
X-Google-Smtp-Source: AGHT+IEcCbIUb7FLaS1kv0Gl0B/d0JLuJYOBmQuhl+Pn9+ipuPL8cfMSAbBqrvyB9DDLlJppJJN4Lg==
X-Received: by 2002:a17:902:e88f:b0:1f2:fe12:b79e with SMTP id d9443c01a7336-1f637012f93mr15319515ad.17.1717146315068;
        Fri, 31 May 2024 02:05:15 -0700 (PDT)
Received: from fedora.pi.hole ([2405:201:6013:c0b2:b3f7:7c95:a370:4345])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323ec184sm11572445ad.209.2024.05.31.02.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 02:05:14 -0700 (PDT)
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
Subject: [PATCH v2] dt-bindings: dma: fsl,imx-dma: Convert to dtschema
Date: Fri, 31 May 2024 14:34:51 +0530
Message-ID: <20240531090458.99744-1-animeshagarwal28@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the fsl i.MX DMA controller bindings to DT schema.

Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
---
 .../devicetree/bindings/dma/fsl,imx-dma.yaml  | 56 +++++++++++++++++++
 .../devicetree/bindings/dma/fsl-imx-dma.txt   | 50 -----------------
 2 files changed, 56 insertions(+), 50 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/fsl,imx-dma.yaml
 delete mode 100644 Documentation/devicetree/bindings/dma/fsl-imx-dma.txt

diff --git a/Documentation/devicetree/bindings/dma/fsl,imx-dma.yaml b/Documentation/devicetree/bindings/dma/fsl,imx-dma.yaml
new file mode 100644
index 000000000000..13ac6d6ad49f
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
+    maximum: 16
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


