Return-Path: <dmaengine+bounces-6888-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 812F6BF29D9
	for <lists+dmaengine@lfdr.de>; Mon, 20 Oct 2025 19:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A5D6421D2B
	for <lists+dmaengine@lfdr.de>; Mon, 20 Oct 2025 17:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001F2331A5A;
	Mon, 20 Oct 2025 17:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gy4iVDXJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D952D1F44;
	Mon, 20 Oct 2025 17:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760980280; cv=none; b=aElnK2fiSE50XDhFWTfYs4La9TKdqfGoCEthFmQKywdhab6E05CzcMJy0RpXIea1Fx2j53X5EDuJLohwGwIf5Z34peimWHjpcsaRy8mGV5tS9cgS+6ZYUSNTZ17pG79uE3p0bVcii/9qW8zZCL7J6LPYSwy55T3GF5CJdYkgPyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760980280; c=relaxed/simple;
	bh=scg+/vO8bFxkmmzsBeRqdeZzJ1dGRrmJ/AeHk9Ng2s0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LqgvjlYkJ0vf+Vvbh3pTI7sf4pptuFH/IvdUAMBbVobDnq3MZVff1kCjluifU4jienBiVI7nPf3gf4aKN7FcMXp2aoWqigWEzizj5TPCWzjrzFMQqCksbKM5c0KCF9AdNt59bwepoVf/EgC4XiP2HEaEyQSzruN7xwEwL7cfVms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gy4iVDXJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 482EEC113D0;
	Mon, 20 Oct 2025 17:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760980280;
	bh=scg+/vO8bFxkmmzsBeRqdeZzJ1dGRrmJ/AeHk9Ng2s0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gy4iVDXJWPC5L6y6UGyZNPo1lTkIFG+bSMJ3dmQuCn4YSDVdoZO6n7pLVV7CmH4RA
	 K2IdzWv4HUJdz6a7QyNz6Fkz3s5IEm22PF1bQQo+GXfG6rW2u6ADBT9Kd5tEPIyA9I
	 SAqqzGT62WZfYIC8H87SqEnyyJT7Qep5vR9wvouCiHE6gJqodbcrY/OpOlMCInb5G6
	 PNW9S6EsKppFRgFGqBHMMN4dT/HmB8AjB9bWiufu+0VZJj2QatzvL2TlHqtN2DvAo+
	 zcxZK5zdadGd2C6f75ZqiasnwzAwdr7mNjrqcUJJqHkXOB/QTFmFy821qOGMn/v3TW
	 lriRxPotYO48g==
Received: by wens.tw (Postfix, from userid 1000)
	id 344895FE2C; Tue, 21 Oct 2025 01:11:18 +0800 (CST)
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
Cc: linux-sunxi@lists.linux.dev,
	linux-sound@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/11] ASoC: dt-bindings: allwinner,sun4i-a10-i2s: Add compatible for A523
Date: Tue, 21 Oct 2025 01:10:48 +0800
Message-ID: <20251020171059.2786070-3-wens@kernel.org>
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

As far as the author can tell, based on their respective manuals,
the I2S interface controllers found in the Allwinner A523 SoC is the
same as ones in the R329 SoC.

Add a SoC-specific compatible for it, with a fallback to the R329's
compatible.

Signed-off-by: Chen-Yu Tsai <wens@kernel.org>
---
 .../devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml    | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml b/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml
index 739114fb6549..ae86cb5f0a74 100644
--- a/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml
+++ b/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml
@@ -33,7 +33,9 @@ properties:
       - const: allwinner,sun50i-h6-i2s
       - const: allwinner,sun50i-r329-i2s
       - items:
-          - const: allwinner,sun20i-d1-i2s
+          - enum:
+              - allwinner,sun20i-d1-i2s
+              - allwinner,sun55i-a523-i2s
           - const: allwinner,sun50i-r329-i2s
 
   reg:
-- 
2.47.3


