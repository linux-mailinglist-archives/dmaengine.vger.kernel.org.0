Return-Path: <dmaengine+bounces-791-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FDA836E0A
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jan 2024 18:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 508EC282925
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jan 2024 17:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADA34879B;
	Mon, 22 Jan 2024 17:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zipi+Xj+"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16134482FC;
	Mon, 22 Jan 2024 17:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705943133; cv=none; b=LZLlTI2IZGM8hF+a5nBD5ZJepuncS1poO+b4rJlq4mas6jBv9rgrtFsR5Fc4MfrvQuW1fOAgxwwD5k/xWDpxdmycCnJOLXvXuXxkqLq7g01+ELuxuozG03P1tpYDG8A0EFM2MnGQ3O8NRUVijmzVpo5O8VOLdcjHsqlVPZLDwmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705943133; c=relaxed/simple;
	bh=JdOHpoopJxRFnjbFQBUm9b3RMTijAagwBCFmoFDWfog=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VlxzEAaIWVPYxjG0y7CDLvh+lDi7A15JI6zPMwppOq/ESdUGeJb6ZEVHkFOKqlgUEyjRdrgyS9QPRY89COdlxq0AS0bvaNz22H5dpvVJ0zsVAWho+/hO8r+iPbmReitQRvruAcNDwRw+2ng4h0fZ6UIV8JGZe0og/8Y3zEgqiI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zipi+Xj+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88155C43394;
	Mon, 22 Jan 2024 17:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705943132;
	bh=JdOHpoopJxRFnjbFQBUm9b3RMTijAagwBCFmoFDWfog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zipi+Xj+/jgKkYfY1ZTFr/SWeePZYEaELd9CMz2ZBHo0BJzFH0fsmxI/0g9h5ma5p
	 +UzAyg/pwdYibC7tzW8FhgaFb14pKR6Krc/U2QoLvaNiXZR2OqogtLcryKb7yGd4IO
	 s4rsPh9nT59QIz5ULDfIPlg1ZEYA2zBKIsj/U8M0q19Es2+ZaH8282OJmMVPoLH8KD
	 Mh/hiz6RnV2/9PFhOkooIeGSwxS1ir+L3+MBi251vYM99iBCk11zOHQ9jIzwnbdt0L
	 JchWknEfmyDpo9GkQw84o2izZ1eoMiMVPGuo8MGJnQfl3mLIZ/WGoXZkpiijLRat24
	 XPCUV1JtCr1OQ==
Received: by wens.tw (Postfix, from userid 1000)
	id D68205FFB2; Tue, 23 Jan 2024 01:05:29 +0800 (CST)
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
Subject: [PATCH 2/7] dt-bindings: sound: sun4i-spdif: Add Allwinner H616 compatible
Date: Tue, 23 Jan 2024 01:05:13 +0800
Message-Id: <20240122170518.3090814-3-wens@kernel.org>
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

Add a new compatible string for it.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../devicetree/bindings/sound/allwinner,sun4i-a10-spdif.yaml   | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-spdif.yaml b/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-spdif.yaml
index 98e2e053fa19..aa32dc950e72 100644
--- a/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-spdif.yaml
+++ b/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-spdif.yaml
@@ -22,6 +22,7 @@ properties:
       - const: allwinner,sun6i-a31-spdif
       - const: allwinner,sun8i-h3-spdif
       - const: allwinner,sun50i-h6-spdif
+      - const: allwinner,sun50i-h616-spdif
       - items:
           - const: allwinner,sun8i-a83t-spdif
           - const: allwinner,sun8i-h3-spdif
@@ -63,6 +64,7 @@ allOf:
               - allwinner,sun6i-a31-spdif
               - allwinner,sun8i-h3-spdif
               - allwinner,sun50i-h6-spdif
+              - allwinner,sun50i-h616-spdif
 
     then:
       required:
@@ -74,6 +76,7 @@ allOf:
           contains:
             enum:
               - allwinner,sun8i-h3-spdif
+              - allwinner,sun50i-h616-spdif
 
     then:
       properties:
-- 
2.39.2


