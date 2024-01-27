Return-Path: <dmaengine+bounces-832-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F12B183EEA5
	for <lists+dmaengine@lfdr.de>; Sat, 27 Jan 2024 17:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8893FB21A07
	for <lists+dmaengine@lfdr.de>; Sat, 27 Jan 2024 16:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3A92C6B2;
	Sat, 27 Jan 2024 16:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQsh7erl"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FE92206B;
	Sat, 27 Jan 2024 16:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706373175; cv=none; b=eBpl5wvmti5xO1ufbWjRpHyo1GASdedEciicElP+kHg744zzZbjZHnAg7+7klgorL+EAXXqaGDeVfyZosS6STYzTmpsRoxzGT73Pzd2lymIa+D6/iNOVjD7d3DhiKakhxXOyEeOXSE/Zr4UdGhLMYp6EG4RsWcGHQA0ijNyzCe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706373175; c=relaxed/simple;
	bh=8BAcimB2vVPlYBPHFOIgIFLTY9STdBweYW7HvMTKlig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KObxB3yqkIA/tbWZ0PMmdVdOEXoKJkCmEodp7Rc3iPwPFLRp5yRQ7HQOSrjbaRJGp7eUGwSR8dHAFKnUVQa8i8EYytm5BV0xz6vkdJf7ikFL13AZzQcrmw3O7zSzkhYl1gx9G2hJnliHfgm6NikcSNb3H4OCJhzYtuZxCvSvIuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQsh7erl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF956C43390;
	Sat, 27 Jan 2024 16:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706373175;
	bh=8BAcimB2vVPlYBPHFOIgIFLTY9STdBweYW7HvMTKlig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CQsh7erls6X9hzFBwfJisBWdG+uNFUXpVtcq3aeOAr4bonKNh7KrKqcVTYS/H33nR
	 GbbNia0jpKlDaTHaEPPGPkAISjY1KySI7lOdBnhGKQXDXJReWiA0R+e0N1Eq2lJiGY
	 9eBCg6CYKVzqKBXvs26LWpGaGZwkV3Z6s5mJXVGh+pYDLb1P4YrT336qn94G1fvVba
	 h4jPrd38Og0jAI4w2gA1G3BaMY38cL38ikhWpPBNOZEN1tL0azvpqjIT4w2O/YcdY7
	 pDAdu/BUoRF4vJpfC1ctDao4+veLTtduKXKUjO7XNccNBAz1AIj0tAU/+Esj2+Jkbv
	 GBjpRjUTblf2A==
Received: by wens.tw (Postfix, from userid 1000)
	id 712EF5FDC7; Sun, 28 Jan 2024 00:32:52 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Vinod Koul <vkoul@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-sound@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/7] dt-bindings: dma: allwinner,sun50i-a64-dma: Add compatible for H616
Date: Sun, 28 Jan 2024 00:32:44 +0800
Message-Id: <20240127163247.384439-5-wens@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240127163247.384439-1-wens@kernel.org>
References: <20240127163247.384439-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wens@csie.org>

The DMA controllers found on the H616 and H618 are the same as the one
found on the A100. The only difference is the DMA endpoint (DRQ) layout.

Since the number of channels and endpoints are described with additional
generic properties, just add a new H616-specific compatible string and
fallback to the A100 one.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
Changes since v1:
- Switch to "contains" for if-properties statement
- Fall back to A100 instead of H6

 .../bindings/dma/allwinner,sun50i-a64-dma.yaml       | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml b/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml
index ec2d7a789ffe..0f2501f72cca 100644
--- a/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml
@@ -28,6 +28,9 @@ properties:
       - items:
           - const: allwinner,sun8i-r40-dma
           - const: allwinner,sun50i-a64-dma
+      - items:
+          - const: allwinner,sun50i-h616-dma
+          - const: allwinner,sun50i-a100-dma
 
   reg:
     maxItems: 1
@@ -59,10 +62,11 @@ required:
 if:
   properties:
     compatible:
-      enum:
-        - allwinner,sun20i-d1-dma
-        - allwinner,sun50i-a100-dma
-        - allwinner,sun50i-h6-dma
+      contains:
+        enum:
+          - allwinner,sun20i-d1-dma
+          - allwinner,sun50i-a100-dma
+          - allwinner,sun50i-h6-dma
 
 then:
   properties:
-- 
2.39.2


