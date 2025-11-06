Return-Path: <dmaengine+bounces-7086-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AD8C3B089
	for <lists+dmaengine@lfdr.de>; Thu, 06 Nov 2025 13:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 738353BDA81
	for <lists+dmaengine@lfdr.de>; Thu,  6 Nov 2025 12:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79262332913;
	Thu,  6 Nov 2025 12:53:22 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2305E31A810;
	Thu,  6 Nov 2025 12:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762433602; cv=none; b=OrFcFFja98o5lkyiKB6NfPLHv90DY1x7SxXueb5SX00GGImvzJ3WnGxy1m13Q0G4K7WP4yODYYjbbTu+6JXiEvCqk7q0SCg7i78q/IKExsbWOuhxpTgcMygCEUxXlv6f/488UHXYXlqfBU3qDlvTo+GPthXQOv2guE7GQ9HNdvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762433602; c=relaxed/simple;
	bh=WTVcx2KLxkIz8uaXTCSQ2TLKErp2R1ohNeaYXev727E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kDwgO41vQ6UgnfhFLfsSDVxTTZucMvySzWRtYwv8D5dKHy49WmMHiXoRt2GYLoPXe+rbiiGpZt2ze9q+31P/tEVuqn/loQeU4u0UehDUKmXksHpyQiwX+iS5vdV9D5qWx6ZmRoIPrDCOf5zOhmzTXvbDthcIFK/gBnkfMtO+5Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: WXpibZ6/SbaEOQVH1JovGg==
X-CSE-MsgGUID: +jBFCvyYTSShP8cvR+ngsA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 06 Nov 2025 21:53:12 +0900
Received: from localhost.localdomain (unknown [10.226.92.193])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id A942841A6E43;
	Thu,  6 Nov 2025 21:53:09 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org,
	stable@kernel.org
Subject: [PATCH] dmaengine: sh: rz-dmac: Fix rz_dmac_terminate_all()
Date: Thu,  6 Nov 2025 12:52:54 +0000
Message-ID: <20251106125256.122133-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After audio full duplex testing, playing the recorded file contains a few
playback frames for the first time. The rz_dmac_terminate_all() does not
reset all the hardware descriptors queued previously, leading to the wrong
descriptor being picked up during the next DMA transfer. Fix this issue by
resetting all descriptor headers for a channel in rz_dmac_terminate_all()
as rz_dmac_lmdesc_recycle() points to the proper descriptor header filled
by the rz_dmac_prepare_descs_for_slave_sg().

Cc: stable@kernel.org
Fixes: 5000d37042a6 ("dmaengine: sh: Add DMAC driver for RZ/G2L SoC")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 1f687b08d6b8..3087bbd11d59 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -557,11 +557,16 @@ rz_dmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 static int rz_dmac_terminate_all(struct dma_chan *chan)
 {
 	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
+	struct rz_lmdesc *lmdesc = channel->lmdesc.base;
 	unsigned long flags;
+	unsigned int i;
 	LIST_HEAD(head);
 
 	rz_dmac_disable_hw(channel);
 	spin_lock_irqsave(&channel->vc.lock, flags);
+	for (i = 0; i < DMAC_NR_LMDESC; i++)
+		lmdesc[i].header = 0;
+
 	list_splice_tail_init(&channel->ld_active, &channel->ld_free);
 	list_splice_tail_init(&channel->ld_queue, &channel->ld_free);
 	vchan_get_all_descriptors(&channel->vc, &head);
-- 
2.43.0


