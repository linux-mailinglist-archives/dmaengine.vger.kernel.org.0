Return-Path: <dmaengine+bounces-6174-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF25B32A2D
	for <lists+dmaengine@lfdr.de>; Sat, 23 Aug 2025 18:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA64C3B4603
	for <lists+dmaengine@lfdr.de>; Sat, 23 Aug 2025 16:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDB22ED17C;
	Sat, 23 Aug 2025 15:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ncOwNiWH"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423522ED174;
	Sat, 23 Aug 2025 15:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755964690; cv=none; b=u9Tdvb4lVsuKIOV8WNACf4j3TU1iicXkxNO1TO2xQtOTD15yFMsT4x2UkMdOxOOkh30xHZPClvYAy4jdy8UMc2y0aAs+CkcMsJa1ttmN6os0DXrLUkdQ46WIhwQnQ7qpbEyJNFij1MAcfbSMDLSnf4ClBaq5wePUyTqJB5C3ZbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755964690; c=relaxed/simple;
	bh=cowF/ZJoltkSCoRh1kuPJeC/P6BXvPb4vKx2M+p/Qgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XO/3phD5jBmvi9yOUlb1T0cXfLIikp0PPO4r2yYwAD4hCjnqIkp3QzqRtbQen6j50h7T1SHLfGYcVrNinkYwxYY8tn4JUt2tx2Q4zNhrSxBvReORj8SgY0HYte17nFxjBHGeKAw1SMER/QJAwLA6K8h8xJpIuHEhH9rAm6HcJZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ncOwNiWH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8845AC113CF;
	Sat, 23 Aug 2025 15:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755964690;
	bh=cowF/ZJoltkSCoRh1kuPJeC/P6BXvPb4vKx2M+p/Qgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ncOwNiWHrg0uqXBHtqGU2zpI4ptLy+6dHbnRxhBhadiKRfQKlPvQErpYLuBIFi6HE
	 pg1gEutx0p5TDSGh/f4H3G42H8Gg+c1MoenTjJlqkNC+Q1ghCax+8dOBOGjErZ7xs0
	 sCaaDQ6Bgt3NnISicdp1K6qih8a6Jt60DgOnShrP6N8oNi6MxkI2FIQ8kHM7Vb/vOH
	 LdLBoSqxkFTSsju+K4cmjR6VyiEcxdB9qgfwGWH3xsGZMLT/NLclvQRNPFPXrNFflR
	 KUS96xTbDsi4NZWCa5pefrQv8hG0h0LSmjD2+Wcd2Tc1Nsy3EpKOyMkfR3QmpaBJho
	 yo57AuLjsB96w==
From: Jisheng Zhang <jszhang@kernel.org>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 13/14] dt-bindings: dma: dma350: Support ARM DMA-250
Date: Sat, 23 Aug 2025 23:40:08 +0800
Message-ID: <20250823154009.25992-14-jszhang@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250823154009.25992-1-jszhang@kernel.org>
References: <20250823154009.25992-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Compared with ARM DMA-350, DMA-250 is a simplified version, they share
many common parts, but they do have difference. The difference will be
handled in next driver patch, while let's add DMA-250 compatible string
to dt-binding now.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 Documentation/devicetree/bindings/dma/arm,dma-350.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/arm,dma-350.yaml b/Documentation/devicetree/bindings/dma/arm,dma-350.yaml
index 94752516e51a..d49736b7de5e 100644
--- a/Documentation/devicetree/bindings/dma/arm,dma-350.yaml
+++ b/Documentation/devicetree/bindings/dma/arm,dma-350.yaml
@@ -15,6 +15,7 @@ allOf:
 properties:
   compatible:
     const: arm,dma-350
+    const: arm,dma-250
 
   reg:
     items:
-- 
2.50.0


