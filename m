Return-Path: <dmaengine+bounces-6891-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFF2BF29EE
	for <lists+dmaengine@lfdr.de>; Mon, 20 Oct 2025 19:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D3EF421D27
	for <lists+dmaengine@lfdr.de>; Mon, 20 Oct 2025 17:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22998331A79;
	Mon, 20 Oct 2025 17:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWdrNuSx"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1635330320;
	Mon, 20 Oct 2025 17:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760980281; cv=none; b=HFfiIqaK388dSC0WuUDPtSDN6V5Lhx2RCUjmg/lXd4/uNflsYzb5yxXAjRj9JGtmkumuvNzDyf7pyIE9NZ1oM+5RGPWl+xTLu8eGNBn83sNpc8U1bBnSB5Fdp1rmMEjv4keCYy0s3zS8Hxndz1YBeff7dWbt8colXNEQy4n6dCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760980281; c=relaxed/simple;
	bh=y56EJjskppbR+/rkKdNbFUjyY8BC1025ZtXtMgp99fA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WVhYnOUy88xn2INzFk3vwTmY9/4M+Wlz3VQJlUrxOTOSzwhwS4BjbRU1I163B9HTCx/0kpU4/bYGlDzD/Xjayu8HYaKq3Gj2JqtGOXw9p2pzWmLpYkUzQYsfGYzOn+zfOdsa08vUXirLDIplNkio5W8voyKDdp6cxaZZ2u4R56g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWdrNuSx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B601C4AF0B;
	Mon, 20 Oct 2025 17:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760980280;
	bh=y56EJjskppbR+/rkKdNbFUjyY8BC1025ZtXtMgp99fA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AWdrNuSx2oo2kKoNLDRwFOI+ta0fWeipsRkJtycyKAs8R6VgZTE+U+gAuq4mRQGVb
	 4MuZPrA8qZQOL+YkkaM/nMEbjhnAJh+kTEOProDZY5Eb8rTuy2NM80bBzhzKPYOwwi
	 bnsXxRTbX7UFNdOgN80sf0ZPoGvkILMO2TYcXRhcFFWR28+KOd8iyOabAd/10iiGrt
	 6r/DLmIlcFvSSzf0j/3sBUcQobSAzwhDlIkY/kuoTR6WLEh1rXl7PSAeADFChD/CgR
	 +NWmHgob6V3MPJfv8cuJl8uhKYwxS02j+CbjAR83SlmUYnTTi+mKfxPymhnIq0laGP
	 OWS1xwwnN2wXQ==
Received: by wens.tw (Postfix, from userid 1000)
	id 431FD5FE78; Tue, 21 Oct 2025 01:11:18 +0800 (CST)
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
Subject: [PATCH 04/11] ASoC: sun4i-spdif: Support SPDIF output on A523 family
Date: Tue, 21 Oct 2025 01:10:50 +0800
Message-ID: <20251020171059.2786070-5-wens@kernel.org>
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

The TX side of the SPDIF block on the A523 is almost the same the
previous generations, the only difference being that it has separate
module clock inputs for the TX and RX side.

Since this driver currently only supports TX, add support for a
different clock name so that TX and RX clocks can be separated
if RX support is ever added. Then add support for the A523.

Signed-off-by: Chen-Yu Tsai <wens@kernel.org>
---
 sound/soc/sunxi/sun4i-spdif.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-spdif.c b/sound/soc/sunxi/sun4i-spdif.c
index 34e5bd94e9af..6a58dc4311de 100644
--- a/sound/soc/sunxi/sun4i-spdif.c
+++ b/sound/soc/sunxi/sun4i-spdif.c
@@ -177,6 +177,7 @@ struct sun4i_spdif_quirks {
 	bool has_reset;
 	unsigned int val_fctl_ftx;
 	unsigned int mclk_multiplier;
+	const char *tx_clk_name;
 };
 
 struct sun4i_spdif_dev {
@@ -323,6 +324,7 @@ static int sun4i_spdif_hw_params(struct snd_pcm_substream *substream,
 	}
 	mclk *= host->quirks->mclk_multiplier;
 
+	dev_info(&pdev->dev, "Setting SPDIF clock rate to %u\n", mclk);
 	ret = clk_set_rate(host->spdif_clk, mclk);
 	if (ret < 0) {
 		dev_err(&pdev->dev,
@@ -542,7 +544,6 @@ static struct snd_soc_dai_driver sun4i_spdif_dai = {
 		.formats = SUN4I_FORMATS,
 	},
 	.ops = &sun4i_spdif_dai_ops,
-	.name = "spdif",
 };
 
 static const struct sun4i_spdif_quirks sun4i_a10_spdif_quirks = {
@@ -572,6 +573,14 @@ static const struct sun4i_spdif_quirks sun50i_h6_spdif_quirks = {
 	.mclk_multiplier = 1,
 };
 
+static const struct sun4i_spdif_quirks sun55i_a523_spdif_quirks = {
+	.reg_dac_txdata = SUN8I_SPDIF_TXFIFO,
+	.val_fctl_ftx   = SUN50I_H6_SPDIF_FCTL_FTX,
+	.has_reset      = true,
+	.mclk_multiplier = 1,
+	.tx_clk_name	= "tx",
+};
+
 static const struct of_device_id sun4i_spdif_of_match[] = {
 	{
 		.compatible = "allwinner,sun4i-a10-spdif",
@@ -594,6 +603,15 @@ static const struct of_device_id sun4i_spdif_of_match[] = {
 		/* Essentially the same as the H6, but without RX */
 		.data = &sun50i_h6_spdif_quirks,
 	},
+	{
+		.compatible = "allwinner,sun55i-a523-spdif",
+		/*
+		 * Almost the same as H6, but has split the TX and RX clocks,
+		 * has a separate reset bit for the RX side, and has some
+		 * expanded features for the RX side.
+		 */
+		.data = &sun55i_a523_spdif_quirks,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sun4i_spdif_of_match);
@@ -635,6 +653,7 @@ static int sun4i_spdif_probe(struct platform_device *pdev)
 	const struct sun4i_spdif_quirks *quirks;
 	int ret;
 	void __iomem *base;
+	const char *tx_clk_name = "spdif";
 
 	dev_dbg(&pdev->dev, "Entered %s\n", __func__);
 
@@ -671,9 +690,12 @@ static int sun4i_spdif_probe(struct platform_device *pdev)
 		return PTR_ERR(host->apb_clk);
 	}
 
-	host->spdif_clk = devm_clk_get(&pdev->dev, "spdif");
+	if (quirks->tx_clk_name)
+		tx_clk_name = quirks->tx_clk_name;
+	host->spdif_clk = devm_clk_get(&pdev->dev, tx_clk_name);
 	if (IS_ERR(host->spdif_clk)) {
-		dev_err(&pdev->dev, "failed to get a spdif clock.\n");
+		dev_err(&pdev->dev, "failed to get the \"%s\" clock.\n",
+			tx_clk_name);
 		return PTR_ERR(host->spdif_clk);
 	}
 
-- 
2.47.3


