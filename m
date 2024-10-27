Return-Path: <dmaengine+bounces-3602-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7C29B1CA9
	for <lists+dmaengine@lfdr.de>; Sun, 27 Oct 2024 10:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA7851F2187C
	for <lists+dmaengine@lfdr.de>; Sun, 27 Oct 2024 09:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BB05464B;
	Sun, 27 Oct 2024 09:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="l/glu0QV"
X-Original-To: dmaengine@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBEB44375;
	Sun, 27 Oct 2024 09:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730020676; cv=none; b=tH1JCOIceX0gLObshwcBouvK6J82S/HbbIv4RPfaVKTXKICNQajt4PfplLUTiSXTI5xy2KKLrGmh68XMUMhcTMzWq6f6KZlIG7EI23Zo9FynkvIr7aS5iJVIYxJR76Yl5TaktPxL0BIA2qDj5RvxJPtCM8rBNXMf+Xs4dTGoQEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730020676; c=relaxed/simple;
	bh=on+3n6AX8EH0bGq2EJvJqehiEym1ZHFWXYiM7nG3xAY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tqM+qHSjXtBZ1Oc8MPqgyRVFgT9ShFx5Wve8hIB/Oa2rUnY+FAqMgi8xAUBQdBlfbNe+6KQEVcmD07aswnMefuQzMt8waCl9VlWo/py14+0etdKirmZRJfA5rCUQapEMibfBS+eKQGYbg+fSHdF64qRNaQSi4qyYZihy0BpMbdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=l/glu0QV; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id BE55FA064A;
	Sun, 27 Oct 2024 10:17:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=EWnfSa/E3TDYuPzWXzSP
	ismhOqK3UCMzs66VsrbxYl4=; b=l/glu0QV8NTIZ66YNSVUhoaR9YoRGczU1InJ
	urCfdoQXlCnVVekGVY8sXpGWIpk1DixcjFP0pRwXKfpM7S00tDXZDQuXiBpskaZO
	g3E4wkDmAG2cmdw0Y8/8HPbyTQuffWO60Rgoy/zAgpWRnUVvWVOH1VYq7qkxFQfR
	DBWnjjFZAQlCBWrJw2ihcV7OGMXQTVmMI66sgfZc21MZnn3hpj+aikG+ezC09iTz
	Z3xwl60rkNknhTZuPH5bIbZKPdMID5+672RUHkh9Q4W54upHiVpxCNDZ/xrl4YAF
	2NBawj4SikdUaIrxuhDn3kwJs2MeVhD0aeCVi0kN91rPUMhRijm7bYWC7suxWTr5
	dAAv9mK5GR8gSE/XpRPyWlUbbonLUgtC0KukRETRm0qhdiImW097gwahnzLFJ0w+
	UoIwJbHC8utUFqhg8dgaafyYCaY2/5z93JZCUTgeVVLD3IFXODeyA/IaM7DL+sch
	xJ5vcMJZDCodFDsuEzggrb1EsQk/RqXYG+FEJxMdP2aTKoBkyTyT7ztO0Xk+MLFi
	NS4kE4VIDA7mKYFGMtzjRoFbDn0bW23072QZcLgxFnoIbUPDHXs0DWcOEK9x2RpQ
	GFQWTfMTqzfC/KDe3dZJG5Z8oO7t0yYPh1/wJbuItePk5LIJlW3E8w4zwv0kuhKn
	fDYuiu4=
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
Subject: [PATCH v2 03/10] dt-bindings: dmaengine: Add Allwinner suniv F1C100s DMA
Date: Sun, 27 Oct 2024 10:14:34 +0100
Message-ID: <20241027091440.1913863-3-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241027091440.1913863-1-csokas.bence@prolan.hu>
References: <20241027091440.1913863-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1730020672;VERSION=7978;MC=2900419732;ID=156038;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD94855677D65

Add compatible string for Allwinner suniv F1C100s DMA.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://lore.kernel.org/linux-kernel/20241024-recycler-borrowing-5d4296fd4a56@spud/
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



