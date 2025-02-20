Return-Path: <dmaengine+bounces-4552-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BA4A3DDBD
	for <lists+dmaengine@lfdr.de>; Thu, 20 Feb 2025 16:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 602FD7AB141
	for <lists+dmaengine@lfdr.de>; Thu, 20 Feb 2025 15:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850B21D5CFD;
	Thu, 20 Feb 2025 15:01:39 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A201FFC4F;
	Thu, 20 Feb 2025 15:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740063699; cv=none; b=kySUHcPtLjF20imV4HQ68jQwKWcb1wxI9U3Vy61SNIXgounbjn4QVFWi3zupU7U1HgOeM9L5dZ/dZQExLsp56TvOQgN4tFif/HsZ3zo+xATWdug0cKej8vQ/3pHadQhXdNIw7WaPPOQnpV+HbhEJrwgF0mzOEaKH+Qx+GnnUIKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740063699; c=relaxed/simple;
	bh=cjmOHVDYR8SwVVCp12Im8zt+Kqj9gz0OIyTnKL7MArw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=neer8w6KegZKR3ceA2QbigTUJ91VAgZgQ8OSflzAf05bEW25/CfWAoLMzMq/xTUueJgxNgSIFnreTI6XQZa1qVXQIluQRUIa2L4RklZbr2ZqDlNFJwj4x64TYzwtRCRfAsZu3RarrE3u5/tJY2vNoF83eogm910U9j8WVhbfs2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: 6oJCmpt8QYekCr1YT9f8GQ==
X-CSE-MsgGUID: JLLFulMIR7CYukh4izCFxg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 21 Feb 2025 00:01:37 +0900
Received: from mulinux.example.org (unknown [10.226.92.65])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7857342C8306;
	Fri, 21 Feb 2025 00:01:34 +0900 (JST)
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
Subject: [PATCH v4 5/7] dmaengine: sh: rz-dmac: Allow for multiple DMACs
Date: Thu, 20 Feb 2025 15:01:08 +0000
Message-Id: <20250220150110.738619-6-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250220150110.738619-1-fabrizio.castro.jz@renesas.com>
References: <20250220150110.738619-1-fabrizio.castro.jz@renesas.com>
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
---
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


