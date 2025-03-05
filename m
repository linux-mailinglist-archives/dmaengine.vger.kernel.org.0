Return-Path: <dmaengine+bounces-4647-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0378A4F26A
	for <lists+dmaengine@lfdr.de>; Wed,  5 Mar 2025 01:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19570165CDB
	for <lists+dmaengine@lfdr.de>; Wed,  5 Mar 2025 00:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D27136672;
	Wed,  5 Mar 2025 00:21:44 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20EC17579;
	Wed,  5 Mar 2025 00:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741134104; cv=none; b=i3VYITLYRnnrf9IusrGKILiyEnkuewtiOaqTj7HCrur1pATQqEar4v9EwUees0B27OX8vgm73Nc9ZjH5JrE0T0IvETpjwHkZkz+5zbZ+lQHUss7q93Pliq70wPzl7hnT0rjzCFvISoE8ZJtoLeIKo+boQPVQenJTl+NWQ6jzpVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741134104; c=relaxed/simple;
	bh=1eYBHK2jK3Z8vffzm6LiVczTEWJbraeVdnF8vnVR7mI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oqc/NBCirrk8t9zS+a+wFlLZE0zVgWlrymrCKMUaW79pCGkErGz5XHr96+l9AU+dsd0GSftZ1G93yUMsySYLegvb4R1jx3LWEdzHoq15NHpXJYz1nImv0B12Rb3Npy3wsBF4693WnYRsaVwk/W8/wuWaNxtEbRv0N5riA7+6rmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: EyVrHvYITLSlBgWGcav/PQ==
X-CSE-MsgGUID: pnv5NGh1SECGRKiH+Cc9DQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 05 Mar 2025 09:21:41 +0900
Received: from mulinux.home (unknown [10.226.92.17])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id E7D28404E421;
	Wed,  5 Mar 2025 09:21:38 +0900 (JST)
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: Vinod Koul <vkoul@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v5 4/6] dmaengine: sh: rz-dmac: Allow for multiple DMACs
Date: Wed,  5 Mar 2025 00:21:10 +0000
Message-Id: <20250305002112.5289-5-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250305002112.5289-1-fabrizio.castro.jz@renesas.com>
References: <20250305002112.5289-1-fabrizio.castro.jz@renesas.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dma_request_channel() calls into __dma_request_channel() with
NULL as value for np, which won't allow for the selection of the
correct DMAC when multiple DMACs are available.

Switch to using __dma_request_channel() directly so that we can
choose the desired DMA for the channel. This is in preparation
of adding DMAC support for the Renesas RZ/V2H(P) and similar SoCs.

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v4->v5:
* Collected tags.
v3->v4:
* No change.
v2->v3:
* Added () for calls in changelog.
v1->v2:
* No change.
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


