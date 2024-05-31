Return-Path: <dmaengine+bounces-2228-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D06F8D653D
	for <lists+dmaengine@lfdr.de>; Fri, 31 May 2024 17:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8F451F23EF7
	for <lists+dmaengine@lfdr.de>; Fri, 31 May 2024 15:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C751586C7;
	Fri, 31 May 2024 15:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="CYqpz41o"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0C3155CA1;
	Fri, 31 May 2024 15:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717168127; cv=none; b=Ol+RPgffaHV8LOQXScsj1K+Yy0XzgEU5dx1vpgLQU7gZvdlkRsWe4cxcnOqcsrR9QM3P19sJMolsJG8oR9t20kbx//SCLXTInbt+I0yDvhVr44Cmv2CgRMzqBhr6G6zLJ9v2qgT+ffEIv2Ci9bT6edpAjoI3hYKKX079IGylw+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717168127; c=relaxed/simple;
	bh=yV5iOHU9O5l3IsItj0MV2p/yMgz5ufKY1w8HZ+A87wg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dGN3ylMSqVzGTebsWIhhdzQIegy8j44Sv9DVKEprELT9TYaG82xSJ6aOktdY0jZmSCMy1+ZwWxY1/4fn9x4CgmiNegcSnVA5ZQLMruWouL1X4KEqS32ugj9NFs31TP0bHiA+qIRjNUkyTT2BjLih//7o0WLSb1EEmWkEgt+Xdg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=CYqpz41o; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44VCG2DZ017618;
	Fri, 31 May 2024 17:08:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	NEQelZNKvc9c31ZCOvgIZW3SK83XULz7eEcsjEdQR/U=; b=CYqpz41od5zp6wpX
	JlmWx114FU4t2Mg5/AblczFCwTbswukoXA15Vmu0G1gPY+XcUwCtos8uhu18ygo8
	+8pdtHCXMVW01xUaQIKEoagPiVsSkGvr+lyGAeL4TiEmwO8uED+qvIetYHviFTdz
	eFpV8EWzXHqkh2j/f2TZISUXM0RxUIe/tGVL+ki0HmLpbfUxYzwQbS7pKkLi4Jyv
	S42OE+flEsVxn0YR/RzhBgyvI3nAXRKw0bRtVgkhEcPVbiLtdg18calRDgbjW0x3
	EWLqxOq3w/Pd3OQZPVGqdhLegKOgehXzIT6diIbQ1ilA5H2uN4PnIV8LXoA993Qg
	3r5XAA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ybsj134xh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 17:08:12 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id CABD240050;
	Fri, 31 May 2024 17:08:06 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F16B422364D;
	Fri, 31 May 2024 17:07:16 +0200 (CEST)
Received: from localhost (10.252.27.179) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 17:07:16 +0200
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre
 Torgue <alexandre.torgue@foss.st.com>
CC: <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        Amelie Delaunay
	<amelie.delaunay@foss.st.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 01/12] dt-bindings: dma: New directory for STM32 DMA controllers bindings
Date: Fri, 31 May 2024 17:07:01 +0200
Message-ID: <20240531150712.2503554-2-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240531150712.2503554-1-amelie.delaunay@foss.st.com>
References: <20240531150712.2503554-1-amelie.delaunay@foss.st.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_11,2024-05-30_01,2024-05-17_01

Gather the STM32 DMA controllers bindings under ./dma/stm32/.
Then fix reference to old path in spi/st,stm32-spi.yaml: update the dmas
property description by referring to all STM32 DMA controllers bindings.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
v3:
- add Rob's Acked-by
v2:
- fix reference in spi/st,stm32-spi.yaml with an updated description of the
  dmas property to reflect the new path of STM32 DMA controllers bindings.
---
 .../devicetree/bindings/dma/{ => stm32}/st,stm32-dma.yaml     | 4 ++--
 .../devicetree/bindings/dma/{ => stm32}/st,stm32-dmamux.yaml  | 4 ++--
 .../devicetree/bindings/dma/{ => stm32}/st,stm32-mdma.yaml    | 4 ++--
 Documentation/devicetree/bindings/spi/st,stm32-spi.yaml       | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)
 rename Documentation/devicetree/bindings/dma/{ => stm32}/st,stm32-dma.yaml (97%)
 rename Documentation/devicetree/bindings/dma/{ => stm32}/st,stm32-dmamux.yaml (90%)
 rename Documentation/devicetree/bindings/dma/{ => stm32}/st,stm32-mdma.yaml (96%)

diff --git a/Documentation/devicetree/bindings/dma/st,stm32-dma.yaml b/Documentation/devicetree/bindings/dma/stm32/st,stm32-dma.yaml
similarity index 97%
rename from Documentation/devicetree/bindings/dma/st,stm32-dma.yaml
rename to Documentation/devicetree/bindings/dma/stm32/st,stm32-dma.yaml
index ff935a0068ec..11a289f1d505 100644
--- a/Documentation/devicetree/bindings/dma/st,stm32-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/stm32/st,stm32-dma.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/dma/st,stm32-dma.yaml#
+$id: http://devicetree.org/schemas/dma/stm32/st,stm32-dma.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: STMicroelectronics STM32 DMA Controller
@@ -53,7 +53,7 @@ maintainers:
   - Amelie Delaunay <amelie.delaunay@foss.st.com>
 
 allOf:
-  - $ref: dma-controller.yaml#
+  - $ref: /schemas/dma/dma-controller.yaml#
 
 properties:
   "#dma-cells":
diff --git a/Documentation/devicetree/bindings/dma/st,stm32-dmamux.yaml b/Documentation/devicetree/bindings/dma/stm32/st,stm32-dmamux.yaml
similarity index 90%
rename from Documentation/devicetree/bindings/dma/st,stm32-dmamux.yaml
rename to Documentation/devicetree/bindings/dma/stm32/st,stm32-dmamux.yaml
index ddf82bf1e71a..f26c914a3a9a 100644
--- a/Documentation/devicetree/bindings/dma/st,stm32-dmamux.yaml
+++ b/Documentation/devicetree/bindings/dma/stm32/st,stm32-dmamux.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/dma/st,stm32-dmamux.yaml#
+$id: http://devicetree.org/schemas/dma/stm32/st,stm32-dmamux.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: STMicroelectronics STM32 DMA MUX (DMA request router)
@@ -10,7 +10,7 @@ maintainers:
   - Amelie Delaunay <amelie.delaunay@foss.st.com>
 
 allOf:
-  - $ref: dma-router.yaml#
+  - $ref: /schemas/dma/dma-router.yaml#
 
 properties:
   "#dma-cells":
diff --git a/Documentation/devicetree/bindings/dma/st,stm32-mdma.yaml b/Documentation/devicetree/bindings/dma/stm32/st,stm32-mdma.yaml
similarity index 96%
rename from Documentation/devicetree/bindings/dma/st,stm32-mdma.yaml
rename to Documentation/devicetree/bindings/dma/stm32/st,stm32-mdma.yaml
index 3874544dfa74..45fe91db11db 100644
--- a/Documentation/devicetree/bindings/dma/st,stm32-mdma.yaml
+++ b/Documentation/devicetree/bindings/dma/stm32/st,stm32-mdma.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/dma/st,stm32-mdma.yaml#
+$id: http://devicetree.org/schemas/dma/stm32/st,stm32-mdma.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: STMicroelectronics STM32 MDMA Controller
@@ -53,7 +53,7 @@ maintainers:
   - Amelie Delaunay <amelie.delaunay@foss.st.com>
 
 allOf:
-  - $ref: dma-controller.yaml#
+  - $ref: /schemas/dma/dma-controller.yaml#
 
 properties:
   "#dma-cells":
diff --git a/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml b/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
index a55c8633c32c..76e43c0ce36c 100644
--- a/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
@@ -42,7 +42,7 @@ properties:
   dmas:
     description: |
       DMA specifiers for tx and rx dma. DMA fifo mode must be used. See
-      the STM32 DMA bindings Documentation/devicetree/bindings/dma/st,stm32-dma.yaml.
+      the STM32 DMA controllers bindings Documentation/devicetree/bindings/dma/stm32/*.yaml.
     items:
       - description: rx DMA channel
       - description: tx DMA channel
-- 
2.25.1


