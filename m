Return-Path: <dmaengine+bounces-6922-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CD148BFA9E8
	for <lists+dmaengine@lfdr.de>; Wed, 22 Oct 2025 09:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4C65D4ECD70
	for <lists+dmaengine@lfdr.de>; Wed, 22 Oct 2025 07:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D296B2FB966;
	Wed, 22 Oct 2025 07:39:08 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D8D2F363E;
	Wed, 22 Oct 2025 07:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761118748; cv=none; b=inO1b0VRQHPjtles9DHMHTS75vCg6uCfbZ0rdxGuw9EvkRHyb9UbO5UhWObBNswjs9DqEnQY+armP0tYMYZjvyM3V8obQGakVXHCnRVgEsJwM9vq9wwbz1/u6cNY2jqgnATzytFZHxcB36ouv4YlU52qpPrHeUZKnDTSBu8ge+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761118748; c=relaxed/simple;
	bh=SVhcG/IkEsCLlLoYPNdIRgyFtOQdzIcIRvyXcYlz5XY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LgF3UdZO69SR3aLl/kA5EKQvb85RT25QXgxKHfKZJghjK9QJf7NmNArWG107D6Z0H6Ru1d+mc/XpTyfryMTk0FUbEuYNNckkIU/vThIVJ6Uc7vVm7N/lWOQju6Z756wu8LT5/kL2dJDbqRd9bsTCPxpoQcKXFKjLlbQKwu8hfwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: X+cxSG5tTriEpfsJ3S5Cog==
X-CSE-MsgGUID: zo+bzUg2TzKy/vu0s6E1Pw==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 22 Oct 2025 16:39:02 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.88])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 56E654005E3B;
	Wed, 22 Oct 2025 16:39:00 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: 
Cc: Vinod Koul <vkoul@kernel.org>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH] dmaengine: sh: rz_dmac: remove braces around single statement if block
Date: Wed, 22 Oct 2025 10:37:57 +0300
Message-ID: <20251022073800.1993223-1-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.51.1.dirty
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Braces around single statement if blocks are unnecessary, remove them.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 1f687b08d6b8..a6db74e86c18 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -336,13 +336,12 @@ static void rz_dmac_prepare_desc_for_memcpy(struct rz_dmac_chan *channel)
 	lmdesc->chext = 0;
 	lmdesc->header = HEADER_LV;
 
-	if (dmac->has_icu) {
+	if (dmac->has_icu)
 		rzv2h_icu_register_dma_req(dmac->icu.pdev, dmac->icu.dmac_index,
 					   channel->index,
 					   RZV2H_ICU_DMAC_REQ_NO_DEFAULT);
-	} else {
+	else
 		rz_dmac_set_dmars_register(dmac, channel->index, 0);
-	}
 
 	channel->chcfg = chcfg;
 	channel->chctrl = CHCTRL_STG | CHCTRL_SETEN;
@@ -393,12 +392,11 @@ static void rz_dmac_prepare_descs_for_slave_sg(struct rz_dmac_chan *channel)
 
 	channel->lmdesc.tail = lmdesc;
 
-	if (dmac->has_icu) {
+	if (dmac->has_icu)
 		rzv2h_icu_register_dma_req(dmac->icu.pdev, dmac->icu.dmac_index,
 					   channel->index, channel->mid_rid);
-	} else {
+	else
 		rz_dmac_set_dmars_register(dmac, channel->index, channel->mid_rid);
-	}
 
 	channel->chctrl = CHCTRL_SETEN;
 }
@@ -671,13 +669,12 @@ static void rz_dmac_device_synchronize(struct dma_chan *chan)
 	if (ret < 0)
 		dev_warn(dmac->dev, "DMA Timeout");
 
-	if (dmac->has_icu) {
+	if (dmac->has_icu)
 		rzv2h_icu_register_dma_req(dmac->icu.pdev, dmac->icu.dmac_index,
 					   channel->index,
 					   RZV2H_ICU_DMAC_REQ_NO_DEFAULT);
-	} else {
+	else
 		rz_dmac_set_dmars_register(dmac, channel->index, 0);
-	}
 }
 
 /*
-- 
2.51.1.dirty


