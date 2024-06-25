Return-Path: <dmaengine+bounces-2534-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D21C916ED8
	for <lists+dmaengine@lfdr.de>; Tue, 25 Jun 2024 19:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C0C81C234CB
	for <lists+dmaengine@lfdr.de>; Tue, 25 Jun 2024 17:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69900176AA8;
	Tue, 25 Jun 2024 17:06:36 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FD917623C;
	Tue, 25 Jun 2024 17:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719335196; cv=none; b=U8ZzwAw6XnGCgQOo4Q0bjGpbFbveAXJ+uytkndtKVml+Np8UerqYE2Y4sCOczGKWY9B2R4AjTMidMcj0PeqRJ1VLS58kFFekJW869vp2yr76ieqSa6+ZHpZRCp7buLsPmxxXYnCHA5anVTcbrmsDeCiUch9M9y3ZvvxuU2q6OyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719335196; c=relaxed/simple;
	bh=AmQcH99wesQyPwPybq2zCnSfdpSm+mPftv4qMZLncZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lW96LUQJlvwAVPve3qDj/VvCteZs9OXO1ygWpbgIcdmLhHDjm/n7wYfGAlBqvaE6cehqu+5XEmHxCPDB5ttxAOG3VL3XgQkUXkV5tF9yr2VFmyb0Kw37PYZunpd3QyOfofL7l4fIBLdI2BYl6wdLIfvMFD91OOOwpl6PWLFi8Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.08,264,1712588400"; 
   d="scan'208";a="213211394"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 26 Jun 2024 02:01:24 +0900
Received: from localhost.localdomain (unknown [10.226.92.128])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 54C21400D4CB;
	Wed, 26 Jun 2024 02:01:21 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Pavel Machek <pavel@denx.de>,
	Hien Huynh <hien.huynh.px@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	dmaengine@vger.kernel.org,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH] dmaengine: sh: rz-dmac: Fix lockdep assert warning
Date: Tue, 25 Jun 2024 18:01:16 +0100
Message-ID: <20240625170119.173595-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the below lockdep assert warning by holding vc.lock for
vchan_get_all_descriptors().

WARNING: virt-dma.h:188 rz_dmac_terminate_all
pc : rz_dmac_terminate_all

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 1f1e86ba5c66..65a27c5a7bce 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -540,8 +540,8 @@ static int rz_dmac_terminate_all(struct dma_chan *chan)
 	spin_lock_irqsave(&channel->vc.lock, flags);
 	list_splice_tail_init(&channel->ld_active, &channel->ld_free);
 	list_splice_tail_init(&channel->ld_queue, &channel->ld_free);
-	spin_unlock_irqrestore(&channel->vc.lock, flags);
 	vchan_get_all_descriptors(&channel->vc, &head);
+	spin_unlock_irqrestore(&channel->vc.lock, flags);
 	vchan_dma_desc_free_list(&channel->vc, &head);
 
 	return 0;
-- 
2.43.0


