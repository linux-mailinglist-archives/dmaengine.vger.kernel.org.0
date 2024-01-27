Return-Path: <dmaengine+bounces-833-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFC183EEA6
	for <lists+dmaengine@lfdr.de>; Sat, 27 Jan 2024 17:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BDBA1C2211D
	for <lists+dmaengine@lfdr.de>; Sat, 27 Jan 2024 16:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CA42CCB4;
	Sat, 27 Jan 2024 16:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2laxqYa"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A444C2C68B;
	Sat, 27 Jan 2024 16:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706373175; cv=none; b=NCRGadzofvjzQy64qpRkqeRt48hxttXCkRe0QfkRtN3INm6EZp/lH/iOXqFWZUzhb//GriFww1/rCZYkDXf6kWlV+P8bK59+RmzJ9c69mMyWKwCiho6Sf4AvRff+w4Ptt8Jrcm9To6mSDsfO/R7lujwXIv4/udfz7OqeGzmTsKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706373175; c=relaxed/simple;
	bh=UV5vUtB55jwJjSHcj4dFELiMmvh+A8Qx1KiXYwwaOdg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jhW9N4EWH/uLq9OPeKWzQr0/hV/aIjHCUynPbc5/9Obdu76VtqthXbGsJ+DLP3X9EacNgCfWFGJa463f92JtdZFFqt2QceDhiAVQ9WnRZEAakaEraZMRqhi2tHhDPeLNrnGLIPVn6kvLWXV+lOTd4itM2t44TPibPzCL2gn/+RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U2laxqYa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21DD4C43330;
	Sat, 27 Jan 2024 16:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706373175;
	bh=UV5vUtB55jwJjSHcj4dFELiMmvh+A8Qx1KiXYwwaOdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U2laxqYaYIfMWNW+FebTG7Hp8zE4EwXty2oystY1/hs3eXZEc8jB+BUmgZQqcOr+2
	 Mqg/rvm/WMyizloRS+sMFhizfAVrJ1VukgJZr8yeTGUXYkOn3yn4vQjBPwVf9vULZS
	 JusJRPqfVJZSs9ucVReRxUJKNX9/WkylUjxrrJz6I3LluAvLWMTiBEGsAyl/pu7v+V
	 3/mapLOWcy2vGO/4aAgtdvnLMIa4dUzZ0eyjhafu56TDpiuYralUG6h4XsIrCdvdNY
	 DAMS5+mFJ0b89V4sRzwv7mK7eTtwpyrXuTfyjGebW2RqE+xla6iN/YZ8k1TYxjetoi
	 3k+gtIyCpLOCQ==
Received: by wens.tw (Postfix, from userid 1000)
	id 6B21B5FDDF; Sun, 28 Jan 2024 00:32:52 +0800 (CST)
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
Subject: [PATCH v2 2/7] dt-bindings: sound: sun4i-spdif: Add Allwinner H616 compatible
Date: Sun, 28 Jan 2024 00:32:42 +0800
Message-Id: <20240127163247.384439-3-wens@kernel.org>
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

Add a new compatible string for it.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
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


