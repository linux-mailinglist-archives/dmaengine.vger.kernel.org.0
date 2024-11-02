Return-Path: <dmaengine+bounces-3675-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8419B9E46
	for <lists+dmaengine@lfdr.de>; Sat,  2 Nov 2024 10:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C6EB2810CE
	for <lists+dmaengine@lfdr.de>; Sat,  2 Nov 2024 09:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7673A16133C;
	Sat,  2 Nov 2024 09:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="D8Zbu/bs"
X-Original-To: dmaengine@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B880E7602D;
	Sat,  2 Nov 2024 09:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730540137; cv=none; b=mK6fWJiQNGgCtC5BxdaeNhq1mofb3bi/mv+/glxq2R9IPY86P+JIPe3iFMYQEmzAJudIjux0miIvlhD269DrFWt2/rU1gpx2C8rzmz5FiHyRjQPkas+/SwoBRA67oSLpeGRPAMohV0miRApZHMl+YKWreHXmrPg47kORpowAKWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730540137; c=relaxed/simple;
	bh=ir6r4uve2AbZDqjyE5oHzV6jdFhDtSE6EcSXfu8OCAw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L6OvhdVTWFsiCRtZ0jba3ggFzsnhEUL8cZvbWjcbgEyJf+XIiCA1REW1H4gRG8sqGM7lSznhBzqPqdk92n90kKNJNOGf2xwpdDThLzL3f7ujFZBuKlPR8WEw3SmYYnOOmvJu4NzM8y+Z2n83xxK1R8oGM6V1BqE69G9OAAXmsVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=D8Zbu/bs; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 39507A0B13;
	Sat,  2 Nov 2024 10:35:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=IJZcZJ9UkGG88e0G4cRY
	DgpG4uPgV6cApvRZoFsAFwQ=; b=D8Zbu/bskVQpbJkw8hvklIWpJD6uEwdyatPh
	/atkFTTpLgmF0iYLikM4tathVSmKAwi/XBwz9du0xi4bLVSlC7DqFleNtzMDCg2t
	+jBSOTlR6399KA9ERmfVZE42YgzH/rxvckTAtiumj40a+W+Js0OZUhNLT99mz5T9
	kenb3IJUQN2xKP9SOt55+zfNg65RBbKqc0dMcVBt7eeN3sJuoo7ki/28fn1WBIol
	vsVuMEKN/36cX05KVi9dUCaKW2nNnt3yolUE7R71ENF45BaxdiFEOyQ/8QhaeZWU
	dahdwBF01n81rcgBY6a/ED3N3OPINLLYl3Mh1HDQuEU76mgKp8XvuuUxDNjVEdv3
	EZbWYzIVFmKlQOfxEH/WsbIiozk7LAwS+Cf0jn82XSOn9hzQ4RssuM8RcJqDQYzr
	WTTssXImKErCalGMJyUAQbOc0N7JtVPTV+YYb/eoK9J1HWwCQZEXJ6w0nCVhOA8t
	BiFzaOl+BiTJAzbKSIf3FAydHZSEPJJnVYn55RppFrUIu+boJg5FMVz8PwPnsY+f
	tA7AOJKWytLrPWdY56HlgQ/YKvX+2Z3nz29gHcANFlb/b7lw58CKnSYCLJouykJv
	ZfFrgsWnS53ZaKW4ePpr3IwDPbaMalLrUEucaYHPwgigcwghHQfMSnD0f9tF+fEU
	LSNrJ8w=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <mripard@kernel.org>,
	<dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-sunxi@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, "Conor
 Dooley" <conor.dooley@microchip.com>, Vinod Koul <vkoul@kernel.org>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Subject: [PATCH v5 3/5] dt-bindings: dmaengine: Add Allwinner suniv F1C100s DMA
Date: Sat, 2 Nov 2024 10:31:42 +0100
Message-ID: <20241102093140.2625230-4-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241102093140.2625230-1-csokas.bence@prolan.hu>
References: <20241102093140.2625230-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1730540133;VERSION=7979;MC=3378102548;ID=220020;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855667067

Add compatible string for Allwinner suniv F1C100s DMA.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
[ csokas.bence: Reimplemented Mesih Kilinc's binding in YAML ]
Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
---
 .../devicetree/bindings/dma/allwinner,sun4i-a10-dma.yaml      | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/allwinner,sun4i-a10-dma.yaml b/Documentation/devicetree/bindings/dma/allwinner,sun4i-a10-dma.yaml
index 02d5bd035409..9b5180c0a7c4 100644
--- a/Documentation/devicetree/bindings/dma/allwinner,sun4i-a10-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/allwinner,sun4i-a10-dma.yaml
@@ -22,7 +22,9 @@ properties:
       number.
 
   compatible:
-    const: allwinner,sun4i-a10-dma
+    enum:
+      - allwinner,sun4i-a10-dma
+      - allwinner,suniv-f1c100s-dma
 
   reg:
     maxItems: 1
-- 
2.34.1



