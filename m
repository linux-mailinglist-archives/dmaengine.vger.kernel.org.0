Return-Path: <dmaengine+bounces-4284-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B859A283D5
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2025 06:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98E8B7A3259
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2025 05:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273AC221D9F;
	Wed,  5 Feb 2025 05:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="hNMWcNQB"
X-Original-To: dmaengine@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DB3221D89;
	Wed,  5 Feb 2025 05:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738734461; cv=none; b=Bksanf3JEAw6tkkKxt+Oalea8PlJJ+zxARPHLk54DEIjO8RVrK8LPnQxqbE3qIupFHyyb6mEBKDFOe19m2OtAnyG5XO1RhkUu+popkCSOvODtGmugqbfmDKn+T/rp44XBRxF/StAQNCcg3JlRtNzp36qsuKho6CFF3jk5030nNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738734461; c=relaxed/simple;
	bh=03binLSyY8x9MAEINWCcoaRHc+hMDevy5AFcDXVUMG8=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=f1WCh41mQddokRWgvAr48JRGCRNKmBC4O3vyXW9+BC+LH/zYef0frMvO2UKOBNByc+tB3bY6TmH7Q9RPv2dTYr2yr8tOjYRhhUpmYI/rR8O0tjecW6BgwplK/Oqnnd/AP24Q31x3bZNsU0tS7H+mhkHc6HeenZ8Tt/FkfUqKQ1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=hNMWcNQB; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1738734459; x=1770270459;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=03binLSyY8x9MAEINWCcoaRHc+hMDevy5AFcDXVUMG8=;
  b=hNMWcNQBnBqZnFzEqxcTwnKgrpFI/h1RVIFs+ysM25teI5zbR12mifZ/
   cTMgbiv4YfWn0k5RJ8KclbpL5wPsFsaQnkhof4bQuiSTGN0t24J5wKNQA
   qelhQXzKysCn+DCY64/XafGtqNOtaaVrjpILLUeLMhEGRkf7/0S9VLKTd
   MBr9yX2hOmZEiKGJsPe/xM/vnG7u5eWW9EH3LebN5mAV4692zSf1RelRb
   acbdnYU/gv0Ap8wwK+dZQknWxCZPGV1Sdv/mI0Sp7zD7FBkbjfPnr1Giu
   dAzQPE6ysTX9TI1KR6/joLlCptjQZ2X9dHDmsJkKM4HVvwVn4ft/HBk1b
   w==;
X-CSE-ConnectionGUID: SlhoVWEVQYiqxuNbYIUogA==
X-CSE-MsgGUID: cskGm2+uQIO7CUWRde8SSA==
X-IronPort-AV: E=Sophos;i="6.13,260,1732604400"; 
   d="scan'208";a="204805605"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Feb 2025 22:47:38 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 4 Feb 2025 22:47:11 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 4 Feb 2025 22:47:06 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
Subject: [PATCH 0/2] dmaengine: at_xdmac: retrieve DMA channels from device
 tree
Date: Wed, 5 Feb 2025 11:17:01 +0530
Message-ID: <20250205-mchp-dma-v1-0-124b639d5afe@microchip.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFX7omcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIwNT3dzkjALdlNxEXWNT02QLY4s0I7M0EyWg8oKi1LTMCrBR0bG1tQC
 9h3W+WgAAAA==
To: Ludovic Desroches <ludovic.desroches@microchip.com>, Vinod Koul
	<vkoul@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nicolas Ferre
	<nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Charan Pedumuru <charan.pedumuru@microchip.com>
CC: <linux-arm-kernel@lists.infradead.org>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, "Dharma
 Balasubiramani" <dharma.b@microchip.com>, Tony Han <tony.han@microchip.com>,
	Cristian Birsan <cristian.birsan@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738734425; l=910;
 i=dharma.b@microchip.com; s=20240209; h=from:subject:message-id;
 bh=03binLSyY8x9MAEINWCcoaRHc+hMDevy5AFcDXVUMG8=;
 b=gYeZSfAOX1Ed6HExseu4wcvUQyH86wo9IXZQ5i4SsunRZ6suTFpNaHmtLG2qXkpWFTG+Vs81c
 pMTbLWCVuK4CNxrX232xzq2meh21eA3Yx/X6WL7QyCW07N/vy3NdohD
X-Developer-Key: i=dharma.b@microchip.com; a=ed25519;
 pk=kCq31LcpLAe9HDfIz9ZJ1U7T+osjOi7OZSbe0gqtyQ4=

This patch series adds support to get the number of DMA channels available in
XDMAC from dts. This property is required when the channel count cannot be read
from the XDMAC_GTYPE register (which occurs when accessing from non-secure
world on certain devices)

Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
---
Dharma Balasubiramani (1):
      dt-bindings: dma: at_xdmac: document dma-channels property

Tony Han (1):
      dmaengine: at_xdmac: get the number of DMA channels from device tree

 .../devicetree/bindings/dma/atmel,sama5d4-dma.yaml | 26 ++++++++++++++--------
 drivers/dma/at_xdmac.c                             | 26 +++++++++++++++++++---
 2 files changed, 40 insertions(+), 12 deletions(-)
---
base-commit: 40b8e93e17bff4a4e0cc129e04f9fdf5daa5397e
change-id: 20250205-mchp-dma-355c838f26f4

Best regards,
-- 
Dharma Balasubiramani <dharma.b@microchip.com>


