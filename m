Return-Path: <dmaengine+bounces-7001-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F37FC0DEEC
	for <lists+dmaengine@lfdr.de>; Mon, 27 Oct 2025 14:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 684174FC6D6
	for <lists+dmaengine@lfdr.de>; Mon, 27 Oct 2025 12:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92173261586;
	Mon, 27 Oct 2025 12:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDpZx8JT"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AEC25CC5E;
	Mon, 27 Oct 2025 12:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761569820; cv=none; b=IbsfZWjrmZMcTa3P+BfOYC14ERy3MvJdbUxahbhsoPW0AiEbyj94zECLNjo73qtxqx4tgcSVwLUfOqVxnLKzO9IqmcxNMLyk2OSVmdygl48wDIcTNQOkyaZh6A9NIka3/2CF/SAUagsXINn0ihYyyNHBUFE+ghoaDU9G5qG0OqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761569820; c=relaxed/simple;
	bh=C8ZaO/vclhrRJ/sXVWYmHzL2b2GlrrEHt+/9PpUhHqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H53wu900lt+EVy7NarKIr/mKEm10K2Rg4n08b9UqCZhvQqvZfrmCifpxi+svdypS8zGajXXbtiMswX3i/eetXYmqGac01uFhLAEr9bqI0NypINgEZcOWuf3NuzRJMNj+C/qlDjEllK0irIT2q8tyeeB+ngZru2R9hgBMO3sE12U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDpZx8JT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFBBAC116D0;
	Mon, 27 Oct 2025 12:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761569819;
	bh=C8ZaO/vclhrRJ/sXVWYmHzL2b2GlrrEHt+/9PpUhHqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SDpZx8JTOCG0wRJg0weXMLzBMOKL3CC40Xm7nOBQYuKbOmthaI+FftWarXiTp+UWn
	 02Kmhs06jxILnPOt44lobvccd9IQfQikm9RdesoQGDQuoYLGutkfPJptcQocV4HPXj
	 NTlCbumL91ih/jBOmL5LHVV8PKoSDkI3EBxPesdU2oRdJeBIkVEDd1ONVbf4Y44uWT
	 M4totbnOLEgSZE8p/1MSXWujDst7x/Xf4ahQL+WX79Z14KRJXYWwZjoBjM4f38z5W4
	 Z+KOZuJSn2xXPoFANLwZBUyrH9EglolNIW7RanbsBNEclZGg5pZ08I/0etAIgDTHfm
	 SrEJx7cPvWsCQ==
Received: by wens.tw (Postfix, from userid 1000)
	id 73D5F5FE34; Mon, 27 Oct 2025 20:56:57 +0800 (CST)
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
Subject: [PATCH v2 02/10] ASoC: dt-bindings: allwinner,sun4i-a10-i2s: Add compatible for A523
Date: Mon, 27 Oct 2025 20:56:43 +0800
Message-ID: <20251027125655.793277-3-wens@kernel.org>
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

As far as the author can tell, based on their respective manuals,
the I2S interface controllers found in the Allwinner A523 SoC is the
same as ones in the R329 SoC.

Add a SoC-specific compatible for it, with a fallback to the R329's
compatible.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
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


