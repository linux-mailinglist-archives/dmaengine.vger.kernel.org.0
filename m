Return-Path: <dmaengine+bounces-792-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3D7836E0B
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jan 2024 18:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C5CE1F24DBA
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jan 2024 17:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF3E4879E;
	Mon, 22 Jan 2024 17:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p/7p2wvY"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1616B482FF;
	Mon, 22 Jan 2024 17:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705943133; cv=none; b=uwZKOUlfpJR7PyylEiqAcRBa3w5N8CjJ+oes7cpSTIFz+tH+AcaTHg7JVZpRbnMo8IfsUsQLyZ3I4t5aEfA39ovfS5TAcOgMXjVMWDnJYMKhhC3Pf8L9wlsxMHwTV/69U1z+HZ+npW/UPM2rx1+RE902XEnXsTWK2Mdc3HQoFd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705943133; c=relaxed/simple;
	bh=D4Sbqcpeq8NQUiUA6r8dDLIKkjJnY3txceHj/LWQjDU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aTW+zg7adfxQqodeWQOe+RHYNY/IHGHJVCb2jnBlmQxqnfGEjhuzOVA5UR+sMTXhxAQf7WoqiSBbRw4fe+Ku2qlklLkPefU2sCJyKtQjTAdCySoejifM8sLSnPkEVQlZo2PIO7AUUjOXsP0S2AMVorTkN2eCHe3mgxtwVOjfAJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p/7p2wvY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60C5DC433C7;
	Mon, 22 Jan 2024 17:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705943132;
	bh=D4Sbqcpeq8NQUiUA6r8dDLIKkjJnY3txceHj/LWQjDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p/7p2wvYMlTdP94HXxpN1cEiiKF/xUKljKopS2B5leeAYirfrkCYsknZIuSgrRZgv
	 D3sWInZ7PzgCccyg4TnjZrviuZr3ahcpMbeLqRQA1TOQBZbf38BUuSfIts6I9rhZVg
	 Mj5MSDoRrFacqoQd085ezjmy62ud+/OxQc6lJrIaYivMX1ZJXXvJNqG5aHqs/IjULj
	 wkrcsd1GAugkzQlFP5Mj8AQoazXQL5CvER2s3xaOgI0OUTUEBQXhv+vrg/NQJ+njPX
	 0adOkuWMtzCGnSn8ZUPYSamp9yZ49WERonkl1YoxhMxR6UiUgvFiubzIt5bfaF9MWi
	 Ck4Lgwg52dJ+A==
Received: by wens.tw (Postfix, from userid 1000)
	id BC7A35F725; Tue, 23 Jan 2024 01:05:29 +0800 (CST)
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
Subject: [PATCH 1/7] dt-bindings: sound: sun4i-spdif: Fix requirements for H6
Date: Tue, 23 Jan 2024 01:05:12 +0800
Message-Id: <20240122170518.3090814-2-wens@kernel.org>
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


