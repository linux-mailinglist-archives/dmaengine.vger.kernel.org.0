Return-Path: <dmaengine+bounces-829-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DC483EE9E
	for <lists+dmaengine@lfdr.de>; Sat, 27 Jan 2024 17:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8692282F42
	for <lists+dmaengine@lfdr.de>; Sat, 27 Jan 2024 16:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2E52576D;
	Sat, 27 Jan 2024 16:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5iClA6L"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C601B812;
	Sat, 27 Jan 2024 16:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706373175; cv=none; b=LKqKALkki6yiEn5jt+IYbulEPbaLif1Vf2mTKcOl91nBkwordNPPJKuxywoFN0YhQ1GiabUhLLoyUguMudBg7L+x12hp48PotpYgE2XplZywWocLGds+ZuVenjJFN6Uj4pyCoirJPGe8oeRXi7iVIBLwPlbI8OsBRFKSp43z6aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706373175; c=relaxed/simple;
	bh=vsL0mbXsOusXWQQoLV0+ENppFAA94idE+K76ih4R3EY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YuTRKB3xexFcgSKSCeqgGBhF6wLtIRY+HEtST01mnrj7Jf7wlG6IzLzADBb24utOmyH7BhfnvkJLenY7fG3BqeSouoAxtttg9FlGygqzK7l9Rtk+5ZPtTTinBgZ0qqsixMwDa5cRH2P50m3AzLskwKMpRDKAgSoaZIIUmrWJg9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5iClA6L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B36B6C433C7;
	Sat, 27 Jan 2024 16:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706373174;
	bh=vsL0mbXsOusXWQQoLV0+ENppFAA94idE+K76ih4R3EY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f5iClA6LGijEWwjkd3JAyCqVl96GzTg73GnRC2fvLKT+m6IUiGiC3W0oDeF6N4z5d
	 RQfxt4c2fXpZXqd9Cq6MJpMqH9QSuM8ueQPpnfDfi7TNAy3sHueUo7KCjAs/BM4MNd
	 w5iqzM3q8A/GqmDmI1o74TiGz1I2JhH8htUq8djsqyDpOYwwXn6Bk0EvZI0xrjoTM1
	 OWOM7m7QRPaQnfcxwpBogHsvDWfiu4/+YVjtUSvDzVXheiJ4/byOV4lJqGQf0a5piF
	 hvi1W1KfZPWkNqITxNhOB5R69uRMZR4Bm1igljypmNR4hP16HJ7N+31Ssfy53loYWU
	 PnfYgW2gvwMSQ==
Received: by wens.tw (Postfix, from userid 1000)
	id 4B4D15FA14; Sun, 28 Jan 2024 00:32:52 +0800 (CST)
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
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 1/7] dt-bindings: sound: sun4i-spdif: Fix requirements for H6
Date: Sun, 28 Jan 2024 00:32:41 +0800
Message-Id: <20240127163247.384439-2-wens@kernel.org>
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

When the H6 was added to the bindings, only the TX DMA channel was
added. As the hardware supports both transmit and receive functions,
the binding is missing the RX DMA channel and is thus incorrect.
Also, the reset control was not made mandatory.

Add the RX DMA channel for SPDIF on H6 by removing the compatible from
the list of compatibles that should only have a TX DMA channel. And add
the H6 compatible to the list of compatibles that require the reset
control to be present.

Fixes: b20453031472 ("dt-bindings: sound: sun4i-spdif: Add Allwinner H6 compatible")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 .../devicetree/bindings/sound/allwinner,sun4i-a10-spdif.yaml    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-spdif.yaml b/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-spdif.yaml
index 8108c564dd78..98e2e053fa19 100644
--- a/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-spdif.yaml
+++ b/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-spdif.yaml
@@ -62,6 +62,7 @@ allOf:
             enum:
               - allwinner,sun6i-a31-spdif
               - allwinner,sun8i-h3-spdif
+              - allwinner,sun50i-h6-spdif
 
     then:
       required:
@@ -73,7 +74,6 @@ allOf:
           contains:
             enum:
               - allwinner,sun8i-h3-spdif
-              - allwinner,sun50i-h6-spdif
 
     then:
       properties:
-- 
2.39.2


