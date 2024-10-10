Return-Path: <dmaengine+bounces-3320-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C403998A04
	for <lists+dmaengine@lfdr.de>; Thu, 10 Oct 2024 16:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5128287927
	for <lists+dmaengine@lfdr.de>; Thu, 10 Oct 2024 14:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5811F8927;
	Thu, 10 Oct 2024 14:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="FC+P2JHh"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB42E1E501C;
	Thu, 10 Oct 2024 14:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728570707; cv=none; b=Psl+O9Qk4wYVZ5/8QGxy2h0dS7gtWzhKB1fqzz2Qc9TDeM83huh3UDl4slVD67MRBX3Aeefac8acEzGhW/Y3Pz69WF75d89OUiGD7tuowfCAXhDCTaLjvt//YwcstyWFDw3JSkGFEQtm2JC9wIbybDOutlEOUkDEgrQOnVXF7qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728570707; c=relaxed/simple;
	bh=Wl7mJJHMHC5fbp4XDTf6oU21ajk9DYyVD4gVRn4ZCJk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=clw/lq9C442pXStwokscQoGgWcSXLprCRXAYNKQY58Lh0rhinusBcWkBorF3QAJo/0c2GDOmyBmkruORBHsPDsTf393VHFAm8IQ95jWhKXuUeIv5LQUfuO87lOQcp7FttCQwz4L+m6pFhHd9IEIaAmbAyPEJBPhok5UGOE01bTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=FC+P2JHh; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49AEBqR0015320;
	Thu, 10 Oct 2024 16:31:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	3tg5heSL9K2PVAn49c6WcA9lpmDYzguhmN52wf4h1Nw=; b=FC+P2JHhQ0B2FzuZ
	OhFNJ6mHadbx4tePNYTJbVUkK9gqv13OlzwwQ5p+B8Bz5hsgAPkMZ0oqXlnGjX1Q
	/Z62ZNXdPJjrQpXwZ1slzmkLOHNP81QD7uBC7UV9Ez4QWNLDT/wHpGly2xxCKSSe
	jSJ25n6vCHu6M3Y9pjjb4aEV/bZZcVuYFqDBMJZiCnLKUUyMFYGBCWxAbIrVGXg/
	igMwMXu8R0L8oAbrNZmKWW9yGnRPMJCLSuEgk1ftyVTP08XzflZFrgPCwDKqMPoH
	z5JUORT7YuazqpBhsPzMTRuaL0v0tA853+1/Jt3S8i1WtzfRZwZDleqCI8Qk7I/P
	WAvSEg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 425q97xxb8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 16:31:35 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 1C02740063;
	Thu, 10 Oct 2024 16:30:22 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1CC0229ADCD;
	Thu, 10 Oct 2024 16:28:11 +0200 (CEST)
Received: from localhost (10.252.31.182) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Thu, 10 Oct
 2024 16:28:10 +0200
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
Date: Thu, 10 Oct 2024 16:27:56 +0200
Subject: [PATCH 06/11] dt-bindings: dma: stm32-dma3: introduce
 st,axi-max-burst-len property
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241010-dma3-mp25-updates-v1-6-adf0633981ea@foss.st.com>
References: <20241010-dma3-mp25-updates-v1-0-adf0633981ea@foss.st.com>
In-Reply-To: <20241010-dma3-mp25-updates-v1-0-adf0633981ea@foss.st.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime
 Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: <dmaengine@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

DMA3 maximum burst length (in unit of beat) may be restricted depending
on bus interconnect.

As mentionned in STM32MP2 reference manual [1], "the maximum allowed AXI
burst length is 16. The user must set [S|D]BL_1 lower or equal to 15
if the Source/Destination allocated port is AXI (if [S|D]AP=0)".

Introduce st,axi-max-burst-len. If used, it will clamp the burst length
to that value if AXI port is used, if not, the maximum burst length value
supported by DMA3 is used.

[1] https://www.st.com/resource/en/reference_manual/rm0457-stm32mp2325xx-advanced-armbased-3264bit-mpus-stmicroelectronics.pdf

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 .../devicetree/bindings/dma/stm32/st,stm32-dma3.yaml          | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/stm32/st,stm32-dma3.yaml b/Documentation/devicetree/bindings/dma/stm32/st,stm32-dma3.yaml
index 38c30271f732e0c8da48199a224a88bb647eeca7..90ad70bb24eb790afe72bf2085478fa4cec60b94 100644
--- a/Documentation/devicetree/bindings/dma/stm32/st,stm32-dma3.yaml
+++ b/Documentation/devicetree/bindings/dma/stm32/st,stm32-dma3.yaml
@@ -51,6 +51,16 @@ properties:
   power-domains:
     maxItems: 1
 
+  st,axi-max-burst-len:
+    description: |
+      Restrict AXI burst length in unit of beat by value specified in this property.
+      The value specified in this property is clamped to the maximum burst length supported by DMA3.
+      If this property is missing, the maximum burst length supported by DMA3 is used.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 256
+    default: 64
+
   "#dma-cells":
     const: 3
     description: |
@@ -137,5 +147,6 @@ examples:
                    <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
       clocks = <&rcc CK_BUS_HPDMA1>;
       #dma-cells = <3>;
+      st,axi-max-burst-len = <16>;
     };
 ...

-- 
2.25.1


