Return-Path: <dmaengine+bounces-793-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E4A836E0E
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jan 2024 18:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AB351C27023
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jan 2024 17:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B33348CC9;
	Mon, 22 Jan 2024 17:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RRGc0ACc"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1CA487AF;
	Mon, 22 Jan 2024 17:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705943133; cv=none; b=rAi+RSOHlxE7YzpSXIm0MpL+067++i60VkmkYDlusdwCHo5JIrp9QTi94cAgtEZHOTEtmwlYN/6eSO6gJCNy+j+6SmRDSmvfuhJ+KUgnM5NJbOaa6QbpZoC+qe6jcjV5AOFCm5fQAASr5p0lCer7kaId32qo5n9lxOg6xC2o53E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705943133; c=relaxed/simple;
	bh=Xm8PplLtMeyRnn4CAuMxfRssboO0T91G8ByncCA6dSw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DpB2SlA8JasyHJGkZSGq4Ki/TKt0eFsTEkxbMZj1yM89yUCkHqwArhjzDPRq+heEab28PlMyp9PV97jj8at5HLwXG9Ja5JhqaYdy726GbByXuX2aj3QeAkKc5FW7P4OmgfM9+tHmmgRjmABLbq09OAqua0k7/quGIqth4LdpFeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RRGc0ACc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2026C4166D;
	Mon, 22 Jan 2024 17:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705943133;
	bh=Xm8PplLtMeyRnn4CAuMxfRssboO0T91G8ByncCA6dSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RRGc0ACcvQUq1KvnIRCnD8xBhNgvfPM6Wm3Cwb6g14mDxirVCEJY1iBF9DHntZBDj
	 VuQt7JZ0uolIhxb3iH89sx7h5A2XBIm0x4dEs58HYTHY9bH3X+yv6FwOO1xPUdj3tK
	 VOUOT6S1FrQVY9MRTIFe7jhhoz0DVjI1Lf3ScnwGhGgohoUTP9ZdDGjf3n/jv3eSja
	 mZtWKssbmOF4N2DA54NqxB9dxlkpOl3KBvzFbpQ5ZlFkr6auGLAHxOyQ2DDC5pNgi+
	 uLQPrkLQEH2A1JL9ZEDYHzTmxmEm0yEjxJUo7pzTWZXWRLBeUB13keU2NCajZvGMjy
	 ytMsJurJl4aSQ==
Received: by wens.tw (Postfix, from userid 1000)
	id 0DB9D600B2; Tue, 23 Jan 2024 01:05:29 +0800 (CST)
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
Subject: [PATCH 3/7] ASoC: sunxi: sun4i-spdif: Add support for Allwinner H616
Date: Tue, 23 Jan 2024 01:05:14 +0800
Message-Id: <20240122170518.3090814-4-wens@kernel.org>
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

The SPDIF hardware block found in the H616 SoC has the same layout as
the one found in the H6 SoC, except that it is missing the receiver
side.

Since the driver currently only supports the transmit function, support
for the H616 is identical to what is currently done for the H6.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 sound/soc/sunxi/sun4i-spdif.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-spdif.c b/sound/soc/sunxi/sun4i-spdif.c
index 702386823d17..f41c30955857 100644
--- a/sound/soc/sunxi/sun4i-spdif.c
+++ b/sound/soc/sunxi/sun4i-spdif.c
@@ -577,6 +577,11 @@ static const struct of_device_id sun4i_spdif_of_match[] = {
 		.compatible = "allwinner,sun50i-h6-spdif",
 		.data = &sun50i_h6_spdif_quirks,
 	},
+	{
+		.compatible = "allwinner,sun50i-h616-spdif",
+		/* Essentially the same as the H6, but without RX */
+		.data = &sun50i_h6_spdif_quirks,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sun4i_spdif_of_match);
-- 
2.39.2


