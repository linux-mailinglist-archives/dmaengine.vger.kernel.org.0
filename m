Return-Path: <dmaengine+bounces-7000-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A68C0DC6C
	for <lists+dmaengine@lfdr.de>; Mon, 27 Oct 2025 14:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54A1719C14C4
	for <lists+dmaengine@lfdr.de>; Mon, 27 Oct 2025 12:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFA825A33A;
	Mon, 27 Oct 2025 12:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oxxn+ju1"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB813244668;
	Mon, 27 Oct 2025 12:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761569820; cv=none; b=JrnyS7j5KN0pHz+z3iIZ5BzLaP5cCSGSPz2LsTQStavhJdGh3NlOoPOZH7eh5gPHQ5NKRmRwjKXJwM3oYRHaL2uNVelWXFe1a7p2jjaeRkx1Z5mksaRIYXRYxTyEXJjSpdvWAgQMGk7TRFasDw7roicB9J0DFgEbOveRE809XF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761569820; c=relaxed/simple;
	bh=fHOStHU8iPV24HUnkdIweLHy8WakycAIf7e5q0yhXig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qxZPKWWoZaUhNFODR1NZx53zGMSNiKzEPQQkOn55zG7X2ZN5nguBFQolbHt/GEiYRZanAK6v8iyJwjs+JW7bQmwFASlmnXf4+KZUEYmEeT+UuFnM/odAXuTPWGOOdudsA5kpvNT4dOGQUOlJAh5vIHRc8fELkJ3X0J7oz6FWC8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oxxn+ju1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FDA8C4CEFF;
	Mon, 27 Oct 2025 12:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761569819;
	bh=fHOStHU8iPV24HUnkdIweLHy8WakycAIf7e5q0yhXig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oxxn+ju1l1rZrihiBgso9u9BBjSAS/FhnaJRzZdarxEuKtSpRtSf5fqjjOwMBbivl
	 NI9k+q3LmooVQs9qeRPxH8wcIKn0UodDzTuDdwdVmBw/bS9qVuDbnW/knnCpPB0gQB
	 jiaQaV7yxOpf0ZN2//uUpAAVFI/089gonDn85pLiRkEGehvBcqhNRKBSpt2yKDUFZg
	 OotIs24M7QPN+q+r3e448MpqaJAE4xmEZJroe62ZLaLRSUtt0y/rMr4VGyGv2Gu8w3
	 Ac59jKopBQ5ui77x9xnBdyuS6bNDte0R8wAcodmw+d6eejMpcVJ1eWgRZGHubKuu0m
	 kzj6eg9OOJcXw==
Received: by wens.tw (Postfix, from userid 1000)
	id 6CF805FCB3; Mon, 27 Oct 2025 20:56:57 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Mark Brown <broonie@kernel.org>,
	Vinod Koul <vkoul@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-sunxi@lists.linux.dev,
	linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 01/10] dt-bindings: dma: allwinner,sun50i-a64-dma: Add compatibles for A523
Date: Mon, 27 Oct 2025 20:56:42 +0800
Message-ID: <20251027125655.793277-2-wens@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251027125655.793277-1-wens@kernel.org>
References: <20251027125655.793277-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are two DMA controllers on the A523, one in the main system area
and the other for the MCU. These are the same as the one found on the
A100. The only difference is the DMA endpoint (DRQ) layout.

Since the number of channels and endpoints are described with additional
generic properties, just add new A523-specific compatible strings and
fallback to the A100 one.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Chen-Yu Tsai <wens@kernel.org>
---
 .../devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml    | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml b/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml
index 0f2501f72cca..c3e14eb6cfff 100644
--- a/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml
@@ -29,7 +29,10 @@ properties:
           - const: allwinner,sun8i-r40-dma
           - const: allwinner,sun50i-a64-dma
       - items:
-          - const: allwinner,sun50i-h616-dma
+          - enum:
+              - allwinner,sun50i-h616-dma
+              - allwinner,sun55i-a523-dma
+              - allwinner,sun55i-a523-mcu-dma
           - const: allwinner,sun50i-a100-dma
 
   reg:
-- 
2.47.3


