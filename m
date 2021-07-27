Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C71403D6E47
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jul 2021 07:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234905AbhG0Frm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 27 Jul 2021 01:47:42 -0400
Received: from mx.socionext.com ([202.248.49.38]:47031 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233553AbhG0Frm (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 27 Jul 2021 01:47:42 -0400
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 27 Jul 2021 14:47:42 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 30E2F205902A;
        Tue, 27 Jul 2021 14:47:42 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 27 Jul 2021 14:47:42 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 8AA62B633F;
        Tue, 27 Jul 2021 14:47:41 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH] dmaengine: uniphier-xdmac: Use readl_poll_timeout_atomic() in atomic state
Date:   Tue, 27 Jul 2021 14:47:32 +0900
Message-Id: <1627364852-28432-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The function uniphier_xdmac_chan_stop() is only called in atomic state.
Should use readl_poll_timeout_atomic() there instead of
readl_poll_timeout().

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: 667b9251440b ("dmaengine: uniphier-xdmac: Add UniPhier external DMA controller driver")
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/dma/uniphier-xdmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/uniphier-xdmac.c b/drivers/dma/uniphier-xdmac.c
index 16b1965..d6b8a20 100644
--- a/drivers/dma/uniphier-xdmac.c
+++ b/drivers/dma/uniphier-xdmac.c
@@ -209,8 +209,8 @@ static int uniphier_xdmac_chan_stop(struct uniphier_xdmac_chan *xc)
 	writel(0, xc->reg_ch_base + XDMAC_TSS);
 
 	/* wait until transfer is stopped */
-	return readl_poll_timeout(xc->reg_ch_base + XDMAC_STAT, val,
-				  !(val & XDMAC_STAT_TENF), 100, 1000);
+	return readl_poll_timeout_atomic(xc->reg_ch_base + XDMAC_STAT, val,
+					 !(val & XDMAC_STAT_TENF), 100, 1000);
 }
 
 /* xc->vc.lock must be held by caller */
-- 
2.7.4

