Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355A66DF9D9
	for <lists+dmaengine@lfdr.de>; Wed, 12 Apr 2023 17:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjDLPZB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 12 Apr 2023 11:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjDLPYv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 12 Apr 2023 11:24:51 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 112FBE5D;
        Wed, 12 Apr 2023 08:24:49 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.98,339,1673881200"; 
   d="scan'208";a="159192065"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 13 Apr 2023 00:24:49 +0900
Received: from localhost.localdomain (unknown [10.226.93.18])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4755C4006A77;
        Thu, 13 Apr 2023 00:24:47 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: [PATCH v3 0/5] RZ/G2L DMAC enhancements
Date:   Wed, 12 Apr 2023 16:24:40 +0100
Message-Id: <20230412152445.117439-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This patch series aims to add enhancement to RZ/G2L DMAC driver.
It is basically for supporting SCIF DMA.

It is based on a patch in the BSP by Long Luu which is similar to
rcar-dmac implementation.

v2->v3:
 * Updated commit description for patch#4 and patch#5.
 * Assign header after chcfg to make sure there is no code flow change.
v1->v2:
 * Updated commit description for patch#{1,2,3}
 * Introduced rz_dmac_invalidate_lmdesc(), so that same code is shared
   between rz_dmac_free_chan_resources() and rz_dmac_terminate_all()
   for invalidating hardware descriptors.
 * Replaced the loop for->for_each_sg and dropped sgl and sg_len variables
   from calculate_total_bytes_in_vd().
 * Added resume callback().
 * Added patch#4 trivial code clean-ups for rz_dmac_lmdesc_recycle() and
   rz_dmac_prep_slave_sg().
 * Added patch#5 for rz_dmac_prepare_descs_for_slave_sg() improvements.

Biju Das (5):
  dmaengine: sh: rz-dmac: Add rz_dmac_invalidate_lmdesc()
  dmaengine: sh: rz-dmac: Add device_tx_status() callback
  dmaengine: sh: rz-dmac: Add device_{pause,resume}() callbacks
  dmaengine: sh: rz-dmac: Trivial code clean-ups
  dmaengine: sh: rz-dmac: rz_dmac_prepare_descs_for_slave_sg()
    improvements

 drivers/dma/sh/rz-dmac.c | 246 +++++++++++++++++++++++++++++++++++----
 1 file changed, 222 insertions(+), 24 deletions(-)

-- 
2.25.1

