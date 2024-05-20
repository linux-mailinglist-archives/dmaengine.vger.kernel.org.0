Return-Path: <dmaengine+bounces-2083-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BE98C9FE9
	for <lists+dmaengine@lfdr.de>; Mon, 20 May 2024 17:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 902961F21BFF
	for <lists+dmaengine@lfdr.de>; Mon, 20 May 2024 15:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFEB13790A;
	Mon, 20 May 2024 15:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="FaaVJoYh"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C713213774A;
	Mon, 20 May 2024 15:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716219807; cv=none; b=ktCmcJHsGem8AlhA1TVEpbtlDQfUm/vznDW1asSwBm60oWuRJZcDxZs1HHyaXJVz5ICjzDkJNkPIWVUfkkbFLoafXH73VhjfI9TXwhnrU2yhwQ0IaQd9wV/HJZuMshn2LJQCw9NEriDL13ZQsHqYy/ZSnBUVllX9YKrEKIZRRHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716219807; c=relaxed/simple;
	bh=sAAVjhRTwMAPa2V5DDeV1SVtdBzM+7gv5eTX/okq9Pw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eBx3ROeL4Ketc3QXbspN936h7M/Qo2GTZGDULsaoBv2L69UPZqNEkyJl7tqAN+7NAS0HhfULvHbn4O7S9UZbsnjTYRZrQi2XdMKyTv6McEl+qgDdZffyZgjO0GVV7opNDcbYABWZyIBigQ/yS78HbhL6rzgq3qPNYoPDkKDIBIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=FaaVJoYh; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44KE5J9U021962;
	Mon, 20 May 2024 17:43:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=VNobvMn6oLwWbtmyiUKPCjbx1HSAH//23odYE9Vnlr8=; b=Fa
	aVJoYhoc+X4SaoOPyfAHXuARN5Q2U9m4TYgFHoqPD7aOsYfaVSglZewHzvM69p9Q
	91gT7jOpz8Mwu38cAI0tRXQ5mvuhRfcMD6InXpdcZBtUu95tqjNT9PRcYdzJe/bD
	WpQIqv61spGA+w0/6cpoIumIA3XF2gwHJV2Df4yetj+2ypznZOycriwQ2by1r5+n
	RItF+GG94dl7xZfZfu5EzhUV7m6ZOCirfeHsKsWxsv5ZZCVYRKFCli9RDUI6azot
	JN0Qc5ZzuhvilTZosUyfwbCeYZtdMo6YZbcJSi+JvkRFds1JuBu34n9HIa39l206
	Lo4L3fTpedfv1tzGLteg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3y6n42807e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 17:43:10 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 368F84004B;
	Mon, 20 May 2024 17:43:06 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C1094226FB4;
	Mon, 20 May 2024 17:42:16 +0200 (CEST)
Received: from localhost (10.252.8.132) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 20 May
 2024 17:42:16 +0200
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
Subject: [PATCH v3 01/12] dt-bindings: dma: New directory for STM32 DMA controllers bindings
Date: Mon, 20 May 2024 17:42:02 +0200
Message-ID: <20240520154213.689699-2-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240520154213.689699-1-amelie.delaunay@foss.st.com>
References: <20240520154213.689699-1-amelie.delaunay@foss.st.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-20_05,2024-05-17_03,2024-05-17_01

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
 rename Documentation/devicetree/bindings/dma/{ => stm32}/st,stm32-dmamux.yaml (89%)
 rename Documentation/devicetree/bindings/dma/{ => stm32}/st,stm32-mdma.yaml (96%)

diff --git a/Documentation/devicetree/bindings/dma/st,stm32-dma.yaml b/Documentation/devicetree/bindings/dma/stm32/st,stm32-dma.yaml
similarity index 97%
rename from Documentation/devicetree/bindings/dma/st,stm32-dma.yaml
rename to Documentation/devicetree/bindings/dma/stm32/st,stm32-dma.yaml
index 329847ef096a..071363d18443 100644
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
similarity index 89%
rename from Documentation/devicetree/bindings/dma/st,stm32-dmamux.yaml
rename to Documentation/devicetree/bindings/dma/stm32/st,stm32-dmamux.yaml
index e722fbcd8a5f..88c9e88cf3d5 100644
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
index 4bd9aeb81208..de431e8306cd 100644
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


