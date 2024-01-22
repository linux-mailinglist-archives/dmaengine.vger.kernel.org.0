Return-Path: <dmaengine+bounces-789-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB46836EA0
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jan 2024 18:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1D7CB28F91
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jan 2024 17:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3F048786;
	Mon, 22 Jan 2024 17:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="We0IU1KN"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDEB3D990;
	Mon, 22 Jan 2024 17:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705943133; cv=none; b=nQ/nO1M0cHzn05oUl17dTLv0Q2E/Eqgi0UA2e2ITLwhJxXWqex1dCUlE7Sf3RDp2A2FZGMAha+9mx3lmseqgHSgLYxcDzCbcuEFEughPI2lLmTtlRD+P55bmsg/6JMj3P4YJv/qt8Or0IIgLp8yNNFLQb4fBhlkNVcK7+CnPPSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705943133; c=relaxed/simple;
	bh=S1UkfK4/p0h181iT92j9rPEO3r0iRuL3QMMsPwiuSjY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iqQDlhH2w/n1h0DAXaGyB5Ah02UHJTKhnj/EI+G4ETAbUdf14S0e8NHwBY5+DkHFrITgtmIM2SPzGxfVSWeAyHF9nARNO+mWlyb5oAS0fP3D+/tHXRcUb/LQO8ZVh5aAyKxULXTle4pMlAWBOxDXDM8mQOsFW8cXQOckNEen99o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=We0IU1KN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98346C433A6;
	Mon, 22 Jan 2024 17:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705943132;
	bh=S1UkfK4/p0h181iT92j9rPEO3r0iRuL3QMMsPwiuSjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=We0IU1KNz5olxvNKbzGISxymnsCBPYNEmHnBPYe0KSnaa6SFlpW03oES+JnMoq8YC
	 juiRstM9skTINNEATDvPHQnKam5PnTYkgPkjl75W4Uwc+hLPU5ivjvbKSei7e86HMd
	 cZkSDUKl1F8DszivK2iiyOZ6e5c/AnwfwjECbGHRMXOfWGblEi5xvJbOMcq2UEW+PO
	 KMJhRu7hoeT9sdEsnob11MVrjW48vsZA4IhXI8XEIL3mvpUIfrxnHmH8yD/HluAjzN
	 p//aoMFPhYpwaUDmbEdrAfJpIDSz7ZsmyknDJAECmzoscNByaRjXo/2foseJm8Okxs
	 Zf7i0qWj3zg/A==
Received: by wens.tw (Postfix, from userid 1000)
	id F13F66001C; Tue, 23 Jan 2024 01:05:29 +0800 (CST)
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
Subject: [PATCH 4/7] dt-bindings: dma: allwinner,sun50i-a64-dma: Add compatible for H616
Date: Tue, 23 Jan 2024 01:05:15 +0800
Message-Id: <20240122170518.3090814-5-wens@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240122170518.3090814-1-wens@kernel.org>
References: <20240122170518.3090814-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wens@csie.org>

The DMA controllers found on the H616 and H618 are the same as the one
found on the H6. The only difference is the DMA endpoint (DRQ) layout.

Since the number of channels and endpoints are described with additional
generic properties, just add a new H616-specific compatible string and
fallback to the H6 one.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../bindings/dma/allwinner,sun50i-a64-dma.yaml    | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml b/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml
index ec2d7a789ffe..e5693be378bd 100644
--- a/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml
@@ -28,6 +28,9 @@ properties:
       - items:
           - const: allwinner,sun8i-r40-dma
           - const: allwinner,sun50i-a64-dma
+      - items:
+          - const: allwinner,sun50i-h616-dma
+          - const: allwinner,sun50i-h6-dma
 
   reg:
     maxItems: 1
@@ -59,10 +62,14 @@ required:
 if:
   properties:
     compatible:
-      enum:
-        - allwinner,sun20i-d1-dma
-        - allwinner,sun50i-a100-dma
-        - allwinner,sun50i-h6-dma
+      oneOf:
+        - enum:
+            - allwinner,sun20i-d1-dma
+            - allwinner,sun50i-a100-dma
+            - allwinner,sun50i-h6-dma
+        - items:
+            - const: allwinner,sun50i-h616-dma
+            - const: allwinner,sun50i-h6-dma
 
 then:
   properties:
-- 
2.39.2


