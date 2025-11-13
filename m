Return-Path: <dmaengine+bounces-7145-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5977FC57622
	for <lists+dmaengine@lfdr.de>; Thu, 13 Nov 2025 13:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E76CE4E5BD8
	for <lists+dmaengine@lfdr.de>; Thu, 13 Nov 2025 12:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5586C34E75C;
	Thu, 13 Nov 2025 12:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XwrrrDvM"
X-Original-To: dmaengine@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718B234DCE0;
	Thu, 13 Nov 2025 12:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763036567; cv=none; b=owfsXT2tkOmljhomP6adMHANW0cBvocD1lT2aWxfQLhDfjEvIw3zYMXT2W9nOhXEcAw1qUsiz1P+h4Q0ajHpqWsuGihZ4xSZtivdZXm1/u4zLBdBCJCQfckmI6Vn5aOcQ3NpzOx2rc9tv9d5gV0nfOvqnf/Ebx8ksEoVBHYo6lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763036567; c=relaxed/simple;
	bh=gSetVXNwTu3ErxPtff5STPeDGtcsAkwzq3hIlW9FP2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XVsCadpsjBaidwIsy1gBXjOD5uTKq0McBNFrhEdIthrgqBndWCVMQhmtcdktXs09tPN5L/eKgh+dxd7wseBQvwum84TgJ+tOsCs4EN2qXYDe1DAgiQTovmrRXpyQ6WT09QsOiCugjhOXNUGDgfMB8qHOZ/LMrmazlypAlU6Bxyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XwrrrDvM; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1763036558;
	bh=gSetVXNwTu3ErxPtff5STPeDGtcsAkwzq3hIlW9FP2g=;
	h=From:To:Cc:Subject:Date:From;
	b=XwrrrDvMb7wF5kwZug7cwna6/PxLeDa1QDMIKCdVXoSLNvh5LbhSVD+vUj7JdiiIN
	 jhnJduU6liMaI23kxV8K4cThDEimm4wIQ+o6r+sSHwx/2cGcxWvjMD+ZZ7ckzj9J0C
	 DZ1wiFVOqLjBRjAFuEy1rI6sjeWTnPNwencmE4p7+eLh3/EgRCOHYdZ71EAchK98Dk
	 csZKS5L/PqgjpGq5+jO1tLeekwsPZ7I3JoppYbuaa3mTE1odVzOTj+i26QcUscRzq8
	 kg8dp6wVXtaXxYNpHwk7vBIweXhgVLyroOaZZajijIjQUJeWVPpy8pfs6Ffi2XevaV
	 CDqlQLS2Xa68g==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E593217E0364;
	Thu, 13 Nov 2025 13:22:37 +0100 (CET)
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
Subject: [PATCH 0/8] MediaTek UART DMA: Fixes, improvements and new SoCs
Date: Thu, 13 Nov 2025 13:22:21 +0100
Message-ID: <20251113122229.23998-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series performs fixes the MediaTek UART DMA driver to be able
to correctly program AP_DMA controllers that support extended
addressing, performs some cleanups to improve code readability
and adds support for *all* of the SoCs generations that are upstream.

This includes MT6795, MT7988, MT8173, MT8183, MT8186, MT8188, MT8195,
other than all of their Genio variants (where applicable), all of
their Smartphone variants (where applicable), and also some newer
generation SoCs that are in the process of being upstreamed, like
MT8196 and MT8189.

Devicetrees are also already done, but not included here, and will be
sent in a different series (probably after this one gets upstreamed,
as I have to decide what to do with MT8196 - integrate it in the first
devicetree submission/commit or add it later - depends on whether this
one gets upstreamed first or not).

AngeloGioacchino Del Regno (8):
  dt-bindings: dma: mediatek,uart-dma: Allow MT6795 single compatible
  dt-bindings: dma: mediatek,uart-dma: Deprecate mediatek,dma-33bits
  dt-bindings: dma: mediatek,uart-dma: Support all SoC generations
  dmaengine: mediatek: uart-apdma: Get addressing bits from match data
  dmaengine: mediatek: uart-apdma: Fix above 4G addressing TX/RX
  dmaengine: mediatek: mtk-uart-apdma: Rename support_33bits to
    support_ext_addr
  dmaengine: mediatek: mtk-uart-apdma: Add support for Dimensity 6300
  dmaengine: mediatek: mtk-uart-apdma: Add support for Dimensity 9200

 .../bindings/dma/mediatek,uart-dma.yaml       | 20 +++++++++++
 drivers/dma/mediatek/mtk-uart-apdma.c         | 35 ++++++++++---------
 2 files changed, 38 insertions(+), 17 deletions(-)

-- 
2.51.1


