Return-Path: <dmaengine+bounces-7003-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFB2C0DF3C
	for <lists+dmaengine@lfdr.de>; Mon, 27 Oct 2025 14:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F0159503644
	for <lists+dmaengine@lfdr.de>; Mon, 27 Oct 2025 12:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF574263F28;
	Mon, 27 Oct 2025 12:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHZDMTLr"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656CE25D202;
	Mon, 27 Oct 2025 12:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761569820; cv=none; b=T36VdFTBt/tgPo8vbJBk5ferupslNJ0a4Fh6+Q5ku6UaF59wLYLDk+Xa37mSFl8i+wUYT+vjyrIjnTJY9pzUJbba71ngA71HQ+bEUhsMGAd2QPcncOCFaCI9CouhOMZ/aS+zeP53VqEbOemuh2Zt/15cPodKWP1uZ700ZOhOtGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761569820; c=relaxed/simple;
	bh=zxJ79mA1lCmnOVxEdjNKKgjbhpuWz79NbCyv/SzMZnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sV0DUhKxSlLLIuCkincZeGztwJ1xTK6UwL4bD+WTpG3LomElM5fwRf7DnNhqH4vm/VTndTOgqGRj5OiZFs3lC71m+ME3uwJ/y8J9OdxwmJUXjVI5tPsioErahR1yC+E6wjiU0VfSzy9Z+L8QnHCoB72KPNXNHH0YG8SOgVTfmFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YHZDMTLr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9365C19421;
	Mon, 27 Oct 2025 12:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761569820;
	bh=zxJ79mA1lCmnOVxEdjNKKgjbhpuWz79NbCyv/SzMZnU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YHZDMTLr3lwyO8l6wrInwbdUuhdncaCwZ9Zhr1SZXbEfLFaNW0Fea+0g8ZCksTdXl
	 w3jM0ZTCu/3tEkV2pcKDgTzYmob7A8A/UtHCOUcHvfDjprmNT+rdrFj+vWZCyeUf8b
	 kLGIOCIz+FqoySc3Apx1fY7Yc+iwzlWUV0DkNM41wWLEHi4rd8m2yJBtqAJBAmHxBr
	 BPzovagqCU838CIrey56iuHp75/IxTxqYCecIqs8Cr0euOhjxzw1tv0w6CMwzhId+H
	 J9xRafULE7Txu4/Dm5OewCkiPep+pOYHJUbBTEZdynXcx92f2h6g7OFvu0AKhBeSiV
	 emgADGE+zq/Lg==
Received: by wens.tw (Postfix, from userid 1000)
	id 89EE15FF19; Mon, 27 Oct 2025 20:56:57 +0800 (CST)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/10] ASoC: sun4i-spdif: Support SPDIF output on A523 family
Date: Mon, 27 Oct 2025 20:56:45 +0800
Message-ID: <20251027125655.793277-5-wens@kernel.org>
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

The TX side of the SPDIF block on the A523 is almost the same the
previous generations, the only difference being that it has separate
module clock inputs for the TX and RX side.

Since this driver currently only supports TX, add support for a
different clock name so that TX and RX clocks can be separated
if RX support is ever added. Then add support for the A523.

Signed-off-by: Chen-Yu Tsai <wens@kernel.org>

---
Changes since v1:
- Dropped bogus name removal
- Dropped clock rate debug message
---
 sound/soc/sunxi/sun4i-spdif.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-spdif.c b/sound/soc/sunxi/sun4i-spdif.c
index 34e5bd94e9af..2e7ac8ab71bb 100644
--- a/sound/soc/sunxi/sun4i-spdif.c
+++ b/sound/soc/sunxi/sun4i-spdif.c
@@ -177,6 +177,7 @@ struct sun4i_spdif_quirks {
 	bool has_reset;
 	unsigned int val_fctl_ftx;
 	unsigned int mclk_multiplier;
+	const char *tx_clk_name;
 };
 
 struct sun4i_spdif_dev {
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


