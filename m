Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45A5C3FAC98
	for <lists+dmaengine@lfdr.de>; Sun, 29 Aug 2021 17:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235595AbhH2P3F (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 29 Aug 2021 11:29:05 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:48766
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235561AbhH2P3F (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 29 Aug 2021 11:29:05 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id AD4BB3F339;
        Sun, 29 Aug 2021 15:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1630250891;
        bh=gqWXc3i3SzkWPvLgtgv3WIqDOFamnAqAjp2Txwu5dQg=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=k8/wq/0SIHgDBR4R6/Zhu4Z50CubNdLU4lPFeErPqovkNTBRElPzgunSrsqo+eJPG
         VJV3a36tEs98rVxR+q4MUmD3b/CNTFcb4UJRah8+5OKOTzGwwD2i3NDDrlmSYK/MdE
         AbQlJKdt5tQaak4iQpdI9ZEJyHPd8ACKVSHjR6HCVnMHUcYIFHKllTHpF1/Bql1WEc
         ndWO0qWljnmeeT99HTPcl4rRQp3SQV54olWP9INV4gnni9h1JanVfHMnTpN77TMWol
         qVbiW5Ug0+F2XRECojsc4T2Lo+ygDG+KmbTjRrhqBV59JXfoEwpwr0ib54dR7iywj/
         93EoRVB/seeiQ==
From:   Colin King <colin.king@canonical.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        dmaengine@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] dmaengine: sh: Fix unused initialization of pointer lmdesc
Date:   Sun, 29 Aug 2021 16:28:11 +0100
Message-Id: <20210829152811.529766-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointer lmdesc is being inintialized with a value that is never read,
it is later being re-assigned a new value. Fix this by initializing
it with the latter value.

Addresses-Coverity: ("Unused value")
Fixes: 550c591a89a1 ("dmaengine: sh: Add DMAC driver for RZ/G2L SoC")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/dma/sh/rz-dmac.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 11986a8d22fc..3d1c239de306 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -308,12 +308,10 @@ static void rz_dmac_prepare_desc_for_memcpy(struct rz_dmac_chan *channel)
 {
 	struct dma_chan *chan = &channel->vc.chan;
 	struct rz_dmac *dmac = to_rz_dmac(chan->device);
-	struct rz_lmdesc *lmdesc = channel->lmdesc.base;
+	struct rz_lmdesc *lmdesc = channel->lmdesc.tail;
 	struct rz_dmac_desc *d = channel->desc;
 	u32 chcfg = CHCFG_MEM_COPY;
 
-	lmdesc = channel->lmdesc.tail;
-
 	/* prepare descriptor */
 	lmdesc->sa = d->src;
 	lmdesc->da = d->dest;
-- 
2.32.0

