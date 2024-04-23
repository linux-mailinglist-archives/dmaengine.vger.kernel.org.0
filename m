Return-Path: <dmaengine+bounces-1921-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C69CC8AE61B
	for <lists+dmaengine@lfdr.de>; Tue, 23 Apr 2024 14:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CAFC283CF0
	for <lists+dmaengine@lfdr.de>; Tue, 23 Apr 2024 12:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CE1127E0B;
	Tue, 23 Apr 2024 12:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="rXdZtibI"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BFD51C5C;
	Tue, 23 Apr 2024 12:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713875688; cv=none; b=ElRQIc4KgBa5ZkeJg0WztpMPhUkrgOsPpzNeKBCld4XvagWLVdSu1WRsKTuDakCaE2KlpPyXQYIeYedGfWwzia//wgWT12I6RsJ8juphk3wdbbboqReLRdMF3B8t4tKPHKbItYQHDO39J1U0Mar9twGKAINPwzMdcqdgnRUEIms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713875688; c=relaxed/simple;
	bh=XFDm/IfzLS5tfCPOEj8/vVIIpckUPOzrOKN0r2YQkeg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uIr3EbzpNqeNzHZPKgv+NvcxSPp3aHmbrBTAKUO8H50oa5D/sVm0h48uzPqMhYKrJimdBAiy4sD52+tUxD+JHXQSucYZKpwDjo0ZZlyKw9Frzs+ycqsgy2HsdQr2RpQfYEnW1kgDXYAR7v7uMFd6XUZ1ut7tgkUNT0fKuKsQXuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=rXdZtibI; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43N8BEAF022031;
	Tue, 23 Apr 2024 14:34:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=lCZb1ivZkuBP+EDUqDQJfohdqRSB9Q5mDHNFqvtQciU=; b=rX
	dZtibIzKTMfRk1IabY2Kg2rL9yxDChZpeXiMCF8o3h5Fy7Epk8Un0SMA7zzn4WeC
	1+IcNdJxLwd9nGWqPwKUbznDqmYRbAtEZmXzD+B3e3S5AQVYnEJJBHxyYu0Z8Wyz
	GbEbyrCFTkfxkgXFio09gSP1mHQlkk1um9XTShcurAN9l7F/uZyWtxeQzgwEpgE7
	0loa1WhUYAd6rxOE1FgOdO6bYhqg1Cmx73Q7lVTScEcVM8AHr+deNCQAsA7rZPmh
	7VwGBX1iU3iQ3sSfBeyQR7ukWWSghyTDkIgrjJbnrFeuOroQZucF3CXMhuBQs27V
	6QiFTNoOHuCrdkp0/MVw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xm4edudpa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 14:34:14 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 4254940044;
	Tue, 23 Apr 2024 14:34:09 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8FA6D21A237;
	Tue, 23 Apr 2024 14:33:24 +0200 (CEST)
Received: from localhost (10.48.86.143) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Apr
 2024 14:33:24 +0200
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
	<amelie.delaunay@foss.st.com>
Subject: [PATCH 01/12] dt-bindings: dma: New directory for STM32 DMA controllers bindings
Date: Tue, 23 Apr 2024 14:32:51 +0200
Message-ID: <20240423123302.1550592-2-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240423123302.1550592-1-amelie.delaunay@foss.st.com>
References: <20240423123302.1550592-1-amelie.delaunay@foss.st.com>
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
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-23_11,2024-04-23_01,2023-05-22_02

Gather the STM32 DMA controllers bindings under ./dma/stm32/

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 .../devicetree/bindings/dma/{ => stm32}/st,stm32-dma.yaml     | 4 ++--
 .../devicetree/bindings/dma/{ => stm32}/st,stm32-dmamux.yaml  | 4 ++--
 .../devicetree/bindings/dma/{ => stm32}/st,stm32-mdma.yaml    | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)
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
-- 
2.25.1


