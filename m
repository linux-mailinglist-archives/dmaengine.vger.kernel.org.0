Return-Path: <dmaengine+bounces-4322-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC47A2B4B3
	for <lists+dmaengine@lfdr.de>; Thu,  6 Feb 2025 23:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D45E166102
	for <lists+dmaengine@lfdr.de>; Thu,  6 Feb 2025 22:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9CE23AE93;
	Thu,  6 Feb 2025 22:03:40 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0932323AE84;
	Thu,  6 Feb 2025 22:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738879419; cv=none; b=m4KYB9mPnn/SaexhwhhD647ylBfTDABxvGa4hVR3YRNYE2gSlV5mTmS7hDvBKy5XtXQ0HFRWCVrQ4+VwQKSBPERUeAdIMwsPs0GdxrsPdfk5WMn8zih3D0tYJSIL0u0AyUGqZEHFSJxNUqHoFCpUbRAuFEEughpnWqkProLbPvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738879419; c=relaxed/simple;
	bh=gPWwEg+c0RVkib5Dg5atR5RUelEO6ntOqIKyfs1WOk8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FDisT+j/0DQOJXe5/7MAi8mfo68TE+R6+QRX9KSXXH43V8BHX5tzOYjJcniY858DuitnS+9qZQHsowiY4yyJZOg+/wxmpfJw2sOS78IEH9sWZQuiYvuFO1MxRA1VZy0o5WXiMCLOnsC8fSyWITljxyhoVt2I05Yz6PdjnFbIJqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: mSjcAm+cQN6f6blKrBQi2w==
X-CSE-MsgGUID: kH+sbF2QR+u9zUte5Ou0+Q==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 07 Feb 2025 07:03:37 +0900
Received: from mulinux.example.org (unknown [10.226.93.55])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id B200340AF4BB;
	Fri,  7 Feb 2025 07:03:34 +0900 (JST)
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: Vinod Koul <vkoul@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH 5/7] dmaengine: sh: rz-dmac: Allow for multiple DMACs
Date: Thu,  6 Feb 2025 22:03:06 +0000
Message-Id: <20250206220308.76669-6-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250206220308.76669-1-fabrizio.castro.jz@renesas.com>
References: <20250206220308.76669-1-fabrizio.castro.jz@renesas.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dma_request_channel calls into __dma_request_channel with NULL
as value for np, which won't allow for the selection of the
correct DMAC when multiple DMACs are available.

Switch to using __dma_request_channel directly so that we can
choose the desired DMA for the channel. This is in preparation
of adding DMAC support for the Renesas RZ/V2H(P) and similar SoCs.

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 9235db551026..d7a4ce28040b 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -748,7 +748,8 @@ static struct dma_chan *rz_dmac_of_xlate(struct of_phandle_args *dma_spec,
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
 
-	return dma_request_channel(mask, rz_dmac_chan_filter, dma_spec);
+	return __dma_request_channel(&mask, rz_dmac_chan_filter, dma_spec,
+				     ofdma->of_node);
 }
 
 /*
-- 
2.34.1


