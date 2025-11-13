Return-Path: <dmaengine+bounces-7148-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 796E6C5760D
	for <lists+dmaengine@lfdr.de>; Thu, 13 Nov 2025 13:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BFAD3BA16C
	for <lists+dmaengine@lfdr.de>; Thu, 13 Nov 2025 12:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0BA34F481;
	Thu, 13 Nov 2025 12:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WncOjzC8"
X-Original-To: dmaengine@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5465434E74C;
	Thu, 13 Nov 2025 12:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763036569; cv=none; b=K2FQQlLXBtPPK1BL2YZtEY78sFmeebeqkhmu3VRWem4Z4nW5ORPRz6J2vXb7lJHWkPwprKnidZPQtOaj9YOz0qfZzqnNZHjz12NHzPzHYbB0MybYoL9dveMThSD+a9+v3dOLDxi42A+Nrn/92V2+qbzUT1v6CitpXElcCq6njVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763036569; c=relaxed/simple;
	bh=xJZtDnfK8GMEfZFtF4HpAbyGTAoHHKqHXm4cdP6YgTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VzEZCROuKP0RMKir1o4ayESP8rfa7oZLmfGFfO+59yWNhlxTQ6wk9GW+0xKRHRmBk+aj1Nf5mGmuD/4K+TXwlmjyQvqWInTrk6izp4CuSI2ZKZNUZG2Ss4U+hmfYXQvnid8WPkRdLlSSlqBvEe215DRtjw9uACEYaK+Mr8CFpIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WncOjzC8; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1763036560;
	bh=xJZtDnfK8GMEfZFtF4HpAbyGTAoHHKqHXm4cdP6YgTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WncOjzC8pUS07cXVHCSq/GxiDUzrGXEn6Y1QvhMojLj4KsguE2QSgLJOdj0XSVb3V
	 6Qy8LneWGdWK9J/c+mCBXaf9bvWHZKoRoQU9VANVbZU22rFSZbIKhuU5ZK1t5JK1ip
	 MfGsf97AhCBkc3X8gEKy5ioQuvUpEN+1VzFFzlUoJhz0YG7K51aAPNGRTJBdpfaHh0
	 OSBoUssxpzmecp5yzWNaS4zVTZwNpYTJcRyPPZ2asiViKy0jxLytGJY/D7ONzYiS7J
	 9dbATBQAvcNGDKYGSELGcKI2XTTtKPnQM0EclxQdyAmHVVbqTwe1ZSJoXf9X4aCy3D
	 tFMEJU2OSIxEw==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id ECDFC17E13B5;
	Thu, 13 Nov 2025 13:22:39 +0100 (CET)
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
Subject: [PATCH 3/8] dt-bindings: dma: mediatek,uart-dma: Support all SoC generations
Date: Thu, 13 Nov 2025 13:22:24 +0100
Message-ID: <20251113122229.23998-4-angelogioacchino.delregno@collabora.com>
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

Add support for the APDMA IP found in all of the SoC generations
that are currently supported upstream; this includes:
 - MT8173, MT8183, fully compatible with MT6577 (32-bits)
 - MT7988, MT8186, MT8188, MT8192, MT8195 and MT6835 (34-bits)
 - MT6991, MT8196 and MT6985 (35-bits)

...where:
 - MT6835 is the first SoC where the AP_DMA IP supports 34-bits
   addressing; and
 - MT6985 is the first SoC where the AP_DMA IP supports 35-bits
   addressing.

While at it, also add myself in the maintainers list.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../bindings/dma/mediatek,uart-dma.yaml        | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml b/Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml
index 4d927726df93..3708518fe7fc 100644
--- a/Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml
@@ -7,6 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: MediaTek UART APDMA controller
 
 maintainers:
+  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
   - Long Cheng <long.cheng@mediatek.com>
 
 description: |
@@ -23,12 +24,29 @@ properties:
           - enum:
               - mediatek,mt2712-uart-dma
               - mediatek,mt6795-uart-dma
+              - mediatek,mt8173-uart-dma
+              - mediatek,mt8183-uart-dma
               - mediatek,mt8365-uart-dma
               - mediatek,mt8516-uart-dma
           - const: mediatek,mt6577-uart-dma
+      - items:
+          - enum:
+              - mediatek,mt7988-uart-dma
+              - mediatek,mt8186-uart-dma
+              - mediatek,mt8188-uart-dma
+              - mediatek,mt8192-uart-dma
+              - mediatek,mt8195-uart-dma
+          - const: mediatek,mt6835-uart-dma
+      - items:
+          - enum:
+              - mediatek,mt6991-uart-dma
+              - mediatek,mt8196-uart-dma
+          - const: mediatek,mt6985-uart-dma
       - enum:
           - mediatek,mt6577-uart-dma
           - mediatek,mt6795-uart-dma
+          - mediatek,mt6835-uart-dma
+          - mediatek,mt6985-uart-dma
 
   reg:
     minItems: 1
-- 
2.51.1


