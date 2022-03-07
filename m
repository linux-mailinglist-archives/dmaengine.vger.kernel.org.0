Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705D24D075D
	for <lists+dmaengine@lfdr.de>; Mon,  7 Mar 2022 20:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245013AbiCGTNS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Mar 2022 14:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240284AbiCGTNP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 7 Mar 2022 14:13:15 -0500
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 76860583B3;
        Mon,  7 Mar 2022 11:12:20 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.90,162,1643641200"; 
   d="scan'208";a="112773446"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 08 Mar 2022 04:12:19 +0900
Received: from localhost.localdomain (unknown [10.226.92.211])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 43BA040D6A32;
        Tue,  8 Mar 2022 04:12:17 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Colin Ian King <colin.king@intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        dmaengine@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH 2/2] dmaengine: sh: rz-dmac: Fix dma_set_max_seg_size
Date:   Mon,  7 Mar 2022 19:12:11 +0000
Message-Id: <20220307191211.12087-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220307191211.12087-1-biju.das.jz@bp.renesas.com>
References: <20220307191211.12087-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

As per Hardware manual, maximum transfer count is  2^32 − 1 bytes.
This patch fixes this issue by replacing 'U32_MAX'->'U32_MAX - 1'.

Fixes: 5000d37042a61ca55 ("dmaengine: sh: Add DMAC driver for RZ/G2L SoC")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 52d82f67d3dd..b35bea56e475 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -913,7 +913,7 @@ static int rz_dmac_probe(struct platform_device *pdev)
 	engine->device_issue_pending = rz_dmac_issue_pending;
 
 	engine->copy_align = DMAENGINE_ALIGN_1_BYTE;
-	dma_set_max_seg_size(engine->dev, U32_MAX);
+	dma_set_max_seg_size(engine->dev, U32_MAX - 1);
 
 	ret = dma_async_device_register(engine);
 	if (ret < 0) {
-- 
2.17.1

