Return-Path: <dmaengine+bounces-7146-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A65FC575FB
	for <lists+dmaengine@lfdr.de>; Thu, 13 Nov 2025 13:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90F3C3B94F5
	for <lists+dmaengine@lfdr.de>; Thu, 13 Nov 2025 12:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4198C34EEFA;
	Thu, 13 Nov 2025 12:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Pif3DHdG"
X-Original-To: dmaengine@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5446434DCFF;
	Thu, 13 Nov 2025 12:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763036568; cv=none; b=iow6nSCXyGwMRkqCIEWQQ8SI3cPKT7ea1oX2pocieSB6pl+U2nb4HOE7+X8w56y0Wcd5zPIpXSf9eD/N9YyS/EawMjRQhBUgYqqk9VSKqUMicvlGcBH6Uwpvn3uA6CUdH7eXSfzQFZfGtI6DSRg+GPyra7JtZQKLseoTTU+OfiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763036568; c=relaxed/simple;
	bh=TbcA0pAYmyWmxfp86PUKSTB7vNHLm5tB2SOEjyV+PpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BB3DHpFV0Mrhfbg0+5nPVv8kpmU5EqGU9ZVEggbsqeJKboZUEW1Hart8GyfUY9J7Yl365pLvEs8VSo3imw5p1v9gGwseBmk6DNpsc6uUirZzGaWLO03+AUymbiDqGmv0/m+BDknnzp/agbfjp+qOXxqUF3zuPskbRc7zC/bSkwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Pif3DHdG; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1763036559;
	bh=TbcA0pAYmyWmxfp86PUKSTB7vNHLm5tB2SOEjyV+PpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pif3DHdGQ2W2wihUPxEsLj0clgNC5bMmqwVN6bV/BWjSkzfFpXIMCAzAycDerydIn
	 K7DZAjROsCtR4afAGOi3gcx5EFcj81FTlqr5ZLYI5T/qoMlif6oLWaim+c8aIvpy2h
	 tNmMwOHW6CQHyoYgOnpGI/I5NyXDjGVP3Kq720X1ufyduFU1YEkUuJj4MloAuOQbfA
	 IXwcKwQBer8la4vAA2Uvt6y6oZ1g3sTI7nuJILIN+DSkPTH94thF4MVH/muUmyf+vG
	 rR1Vbn5G98qhqxKtAcH1ym1NUNrGVKByw/efVgA7NxV+amFQg1GS7blFtTCOXzKz3E
	 295yLHyRc4/2Q==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9AB1A17E127F;
	Thu, 13 Nov 2025 13:22:38 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: dmaengine@vger.kernel.org
Cc: sean.wang@mediatek.com,
	vkoul@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	long.cheng@mediatek.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH 1/8] dt-bindings: dma: mediatek,uart-dma: Allow MT6795 single compatible
Date: Thu, 13 Nov 2025 13:22:22 +0100
Message-ID: <20251113122229.23998-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251113122229.23998-1-angelogioacchino.delregno@collabora.com>
References: <20251113122229.23998-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While it is true that this SoC is compatible with the MT6577 APDMA
IP, that is valid only when the IP is used in 32-bits addressing
mode, and, by the way there is no good reason to do so.

Since the APDMA IP in MT6795 supports 33 bits addressing, this
means that it is a newer revision compared to the one found in
MT6577, hence only partially compatible with it.

Allow nodes to specify "mediatek,mt6795-uart-dma" as their only
compatible in the case of MT6795; this is done in lieu of the fact
that there are other SoCs integrating the same version of this IP
as MT6795, and those will eventually get their own compatible that
expresses full compatibility with this SoC.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml b/Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml
index dab468a88942..10fc92b60de5 100644
--- a/Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml
@@ -28,6 +28,7 @@ properties:
           - const: mediatek,mt6577-uart-dma
       - enum:
           - mediatek,mt6577-uart-dma
+          - mediatek,mt6795-uart-dma
 
   reg:
     minItems: 1
-- 
2.51.1


