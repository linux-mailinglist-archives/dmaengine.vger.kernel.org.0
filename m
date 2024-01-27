Return-Path: <dmaengine+bounces-830-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C472C83EE9F
	for <lists+dmaengine@lfdr.de>; Sat, 27 Jan 2024 17:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8114F1F2281D
	for <lists+dmaengine@lfdr.de>; Sat, 27 Jan 2024 16:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973D52C1A6;
	Sat, 27 Jan 2024 16:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ECaen3DG"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C1B1E531;
	Sat, 27 Jan 2024 16:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706373175; cv=none; b=l6O+yyFpEe5rPcCTTOrKYoRYpctBJcrQ2HvMp43yQEYW9QfwbjKgDCTYRsxqC6G4eBSbyHxHU/gejxLGM84+aViai5X3eTUew5zk9GQ5xbQG6AXkErvSStj9CcwaPoakJTLVsZZAJqyytzaVw3/f0hiaHfdEHmKFrlW3pxm2yGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706373175; c=relaxed/simple;
	bh=Kh4LgU41ucmqLDiWgVW2g3izu0jN4Zn5A+1gSaj5/7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X0EDAh4oEORhBeX9nD4VdwM/NSRwDrXDtcoVDMgbgWW20K6tDBqx7gJKJ1yHzc+waG+Zos9u16zZPUut+hIyoaYVprs1zYxY0hVE50pbIzdNcVICbdNABneE7OVwI5Axd5Thdl+POHYL2lYIE2PYpCWutNHvLNcxU2cAhLuJrkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ECaen3DG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0953FC433B1;
	Sat, 27 Jan 2024 16:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706373175;
	bh=Kh4LgU41ucmqLDiWgVW2g3izu0jN4Zn5A+1gSaj5/7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ECaen3DGTCwiDfEdSEhDXDOCJGuemFmKJspx8UTpp6bKZdHf7jLXsocEl551KtgbN
	 TdRlg/y15p9f6mBBkiZi+h1v/vXCbHAxBro51mI9TSz7O/ckhcdckFWlR1tEZgVKJ/
	 0LogHQQp+/FBvRMYMHLPiVGWzWoPMdMPawwNcn5weK4p781dCdisDFikAQlor2IVQL
	 MEPYpXV6VA2PwnNDUfzSp0qo9dZPMTzOBqPSxf/vypMyjBazHnyzotGGnoNbRM6jW5
	 /ZHZCwffvyIWgNjRiOkPk1m22SuyU1PB2unZUJZ/kacpLhuzRfsGWdUISq5QJQF0Xa
	 SX8C1PnHBao/g==
Received: by wens.tw (Postfix, from userid 1000)
	id 611C55FBBD; Sun, 28 Jan 2024 00:32:52 +0800 (CST)
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
	Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH v2 3/7] ASoC: sunxi: sun4i-spdif: Add support for Allwinner H616
Date: Sun, 28 Jan 2024 00:32:43 +0800
Message-Id: <20240127163247.384439-4-wens@kernel.org>
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

The SPDIF hardware block found in the H616 SoC has the same layout as
the one found in the H6 SoC, except that it is missing the receiver
side.

Since the driver currently only supports the transmit function, support
for the H616 is identical to what is currently done for the H6.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
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


