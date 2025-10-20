Return-Path: <dmaengine+bounces-6892-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0192EBF29F5
	for <lists+dmaengine@lfdr.de>; Mon, 20 Oct 2025 19:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A02594E8D19
	for <lists+dmaengine@lfdr.de>; Mon, 20 Oct 2025 17:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502B13321BB;
	Mon, 20 Oct 2025 17:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2j2ylcR"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E961B330D23;
	Mon, 20 Oct 2025 17:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760980281; cv=none; b=jbSBPfYEmoT1sG6azbcYjUvq9i5LpG86Gw6RauhWhT1FiuZeH4l9cey0QBlEhuPNLqDpswJY6plgmJYgyNSgleKFwOTGb6A5gSeqBQQGvHwBSpWi6KAE36xs+XMuZJ20Q0C+QN4MohfPxOpHeGm6HATPXlHV4mM30Uhi/72m9hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760980281; c=relaxed/simple;
	bh=YIPTcjtisaZ5yPU39cB2poEgXiC9oxSbvqACMF7guZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cMYPkc8qn/C0hPHdcBJCJtwWg5srwNTNkh4MG5ctObFWz3rk8uZf1V0szjchGN3Cj4WQVwv0AOBhiPt1v4QB9z1gp20QE42vxxA1tU8Fz7gBkvYq3GLrq1nyvEXlD39di1EdJ0Ns7Bj6xBm+U5SOeDRURnap5M5UVVhv7joxNA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2j2ylcR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B660C19423;
	Mon, 20 Oct 2025 17:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760980280;
	bh=YIPTcjtisaZ5yPU39cB2poEgXiC9oxSbvqACMF7guZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z2j2ylcRsPrmU7y/m750/X9+1N5xr2bBqx9A+QSEXxwY+9gtT7A7NnP65B/pv7Gn2
	 u32eHV6WYAZBxdpfKfLs35SfOdk3Wv9F8TsqxGm9fH+BLPjt+p1s5DsWYNAgGV0oA9
	 H/pbvK/CWheUeHx85405QQn3q74qyJnxQ53LmlTERDER2xQPN8QL+gwM02SYpOGo7o
	 qejrhZmMP2FvP/q1BoHm0e8Gl8vcyBeCn1B36empLQOoaTzT3RKdaYIcTj47HG1Qg9
	 xKps1E7fosHAK1eIRSRdvqPkQzp+JGquO8hVdjmbmO6pxwbW90dZBx5kpfTNYW/dYP
	 mQ2aiX9+YFJ4A==
Received: by wens.tw (Postfix, from userid 1000)
	id 2A8285F952; Tue, 21 Oct 2025 01:11:18 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Mark Brown <broonie@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>,
	linux-sunxi@lists.linux.dev,
	linux-sound@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] dt-bindings: dma: allwinner,sun50i-a64-dma: Add compatibles for A523
Date: Tue, 21 Oct 2025 01:10:47 +0800
Message-ID: <20251020171059.2786070-2-wens@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251020171059.2786070-1-wens@kernel.org>
References: <20251020171059.2786070-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wens@csie.org>

There are two DMA controllers on the A523, one in the main system area
and the other for the MCU. These are the same as the one found on the
A100. The only difference is the DMA endpoint (DRQ) layout.

Since the number of channels and endpoints are described with additional
generic properties, just add new A523-specific compatible strings and
fallback to the A100 one.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
I could probably take this through the soc tree if Vinod gives an ack.

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


