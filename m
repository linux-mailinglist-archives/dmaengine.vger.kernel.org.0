Return-Path: <dmaengine+bounces-2738-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BA893C19D
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jul 2024 14:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBDBD1F24399
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jul 2024 12:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F06919AA66;
	Thu, 25 Jul 2024 12:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Dh+5JKe7"
X-Original-To: dmaengine@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D766F1991A9;
	Thu, 25 Jul 2024 12:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721909808; cv=none; b=oHbamvL8DK0ebghXuKHG3CCdVUnT95cFMntQFifsogQi4C88Fe/Jm+wkJbbhALWmSGAZ+hIFxoBDtk+i9CfJUouu4f6azCWT4ry7qGHo2OJR5wK1jvpuWJEZSNg9JAheCVxW9L6uMC6t7w70RMXPFDzXM4+i6SHN0pnGNyWBLR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721909808; c=relaxed/simple;
	bh=nLkCuTBPfpbqNBH1j3e2/aPI6MfTBWdislcAckUBGL0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LD8r1sETSUjekMCVCKLwrX9QHnHPd0n8ilEI5TND8OB6KG9koKlKrOvXJhP41a8xSocqrPC2CGOX24UIIVB6m4rTTbgL30KzSJZmwvQA5mOWOgaZHe+t6FVJsceKd2iB1T79X9Kw0CRYp/gCbE6A7mM+uVz14SRuje0kvXgzFSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Dh+5JKe7; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1721909806; x=1753445806;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nLkCuTBPfpbqNBH1j3e2/aPI6MfTBWdislcAckUBGL0=;
  b=Dh+5JKe7PE7LLfur69kF39G67TG6xTCuyoEBcDMlhRTWKSC1i/991BbS
   /CajmRaZ94ydKqy1FKSrLCuKR56VzYoUX7FTOxNxY+dDslYqhOZW93Vce
   gXlAhUmrBapcV/I2ra043j6JRw7pP5425bHLoSIjwJ48+ruyB9Iw5npo7
   iEujgTInuq7WXKz/XXzfG+2HDQOEAte/MGsSMP/hSnqvfVSMEI/dJ1yaq
   bnKNdftGRveIfTQw7R9CdLRmeAuhmolPl/4dvLCQZbJWnFhqQGhIcp/+G
   zaUT4QbAoZX7R3dlIKSNvBdElzQ+h61KzS2adNDBH0ndd0eW4O8yV7Nf1
   A==;
X-CSE-ConnectionGUID: 7H0adE5mRmid6ymnvkB3VA==
X-CSE-MsgGUID: QB6OQBHnTN+Wj2m9Fj8muA==
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; 
   d="scan'208";a="197092682"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jul 2024 05:16:43 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Jul 2024 05:16:40 -0700
Received: from ph-emdalo.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 25 Jul 2024 05:16:37 -0700
From: <pierre-henry.moussay@microchip.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Paul
 Walmsley" <paul.walmsley@sifive.com>, Samuel Holland
	<samuel.holland@sifive.com>, Green Wan <green.wan@sifive.com>, Palmer Debbelt
	<palmer@sifive.com>
CC: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>,
	<dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 09/17] dt-bindings: dma: sifive pdma: Add PIC64GX to compatibles
Date: Thu, 25 Jul 2024 13:16:01 +0100
Message-ID: <20240725121609.13101-10-pierre-henry.moussay@microchip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240725121609.13101-1-pierre-henry.moussay@microchip.com>
References: <20240725121609.13101-1-pierre-henry.moussay@microchip.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>

PIC64GX is compatible as out of order DMA capable, just like the MPFS
version, therefore we add it with microchip,mpfs-pdma as a fallback

Signed-off-by: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
---
 .../bindings/dma/sifive,fu540-c000-pdma.yaml      | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
index 3b22183a1a37..609e38901434 100644
--- a/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
+++ b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
@@ -27,11 +27,16 @@ allOf:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - microchip,mpfs-pdma
-          - sifive,fu540-c000-pdma
-      - const: sifive,pdma0
+    oneOf:
+      - items:
+          - const: microchip,pic64gx-pdma
+          - const: microchip,mpfs-pdma
+          - const: sifive,pdma0
+      - items:
+          - enum:
+              - microchip,mpfs-pdma
+              - sifive,fu540-c000-pdma
+          - const: sifive,pdma0
     description:
       Should be "sifive,<chip>-pdma" and "sifive,pdma<version>".
       Supported compatible strings are -
-- 
2.30.2


