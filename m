Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF40473C24
	for <lists+dmaengine@lfdr.de>; Tue, 14 Dec 2021 05:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbhLNEms (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Dec 2021 23:42:48 -0500
Received: from mx.socionext.com ([202.248.49.38]:50380 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229624AbhLNEms (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 13 Dec 2021 23:42:48 -0500
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 14 Dec 2021 13:42:46 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id B56892059054;
        Tue, 14 Dec 2021 13:42:46 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 14 Dec 2021 13:42:46 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 776E7B568B;
        Tue, 14 Dec 2021 13:42:46 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH] dmaengine: uniphier-xdmac: Fix type of address variables
Date:   Tue, 14 Dec 2021 13:42:43 +0900
Message-Id: <1639456963-10232-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The variables src_addr and dst_addr handle DMA addresses, so these should
be declared as dma_addr_t.

Fixes: 667b9251440b ("dmaengine: uniphier-xdmac: Add UniPhier external DMA controller driver")
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/dma/uniphier-xdmac.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/uniphier-xdmac.c b/drivers/dma/uniphier-xdmac.c
index d6b8a202474f..290836b7e1be 100644
--- a/drivers/dma/uniphier-xdmac.c
+++ b/drivers/dma/uniphier-xdmac.c
@@ -131,8 +131,9 @@ uniphier_xdmac_next_desc(struct uniphier_xdmac_chan *xc)
 static void uniphier_xdmac_chan_start(struct uniphier_xdmac_chan *xc,
 				      struct uniphier_xdmac_desc *xd)
 {
-	u32 src_mode, src_addr, src_width;
-	u32 dst_mode, dst_addr, dst_width;
+	u32 src_mode, src_width;
+	u32 dst_mode, dst_width;
+	dma_addr_t src_addr, dst_addr;
 	u32 val, its, tnum;
 	enum dma_slave_buswidth buswidth;
 
-- 
2.7.4

