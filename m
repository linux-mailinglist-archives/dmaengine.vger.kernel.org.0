Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0AD6D7EB1
	for <lists+dmaengine@lfdr.de>; Wed,  5 Apr 2023 16:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238347AbjDEOKg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 5 Apr 2023 10:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238709AbjDEOKR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 5 Apr 2023 10:10:17 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 749706A4E;
        Wed,  5 Apr 2023 07:09:41 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.98,319,1673881200"; 
   d="scan'208";a="158393591"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 05 Apr 2023 23:08:55 +0900
Received: from localhost.localdomain (unknown [10.226.93.81])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 9CFC442D7816;
        Wed,  5 Apr 2023 23:08:53 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 0/5] RZ/G2L DMAC enhancements
Date:   Wed,  5 Apr 2023 15:08:37 +0100
Message-Id: <20230405140842.201883-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.0 required=5.0 tests=AC_FROM_MANY_DOTS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This patch series aims to add enhancement to RZ/G2L DMAC driver.
It is basically for supporting SCIF DMA.

It is based on a patch in the BSP by Long Luu which is similar to
rcar-dmac implementation.

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
 
Tested audio, RSPI and scifa with these changes.
 14:      67366          0     GICv3 157 Edge      11820000.dma-controller:0
 15:      67410          0     GICv3 158 Edge      11820000.dma-controller:1
 16:      56353          0     GICv3 159 Edge      11820000.dma-controller:2
 17:      56353          0     GICv3 160 Edge      11820000.dma-controller:3
 18:       8192          0     GICv3 161 Edge      11820000.dma-controller:4
 19:       5952          0     GICv3 162 Edge      11820000.dma-controller:5
 20:          0          0     GICv3 163 Edge      11820000.dma-controller:6
 21:          0          0     GICv3 164 Edge      11820000.dma-controller:7
 22:          0          0     GICv3 165 Edge      11820000.dma-controller:8
 23:          0          0     GICv3 166 Edge      11820000.dma-controller:9
 24:          0          0     GICv3 167 Edge      11820000.dma-controller:10
 25:          0          0     GICv3 168 Edge      11820000.dma-controller:11
 26:          0          0     GICv3 169 Edge      11820000.dma-controller:12
 27:          0          0     GICv3 170 Edge      11820000.dma-controller:13
 28:          0          0     GICv3 171 Edge      11820000.dma-controller:14
 29:          0          0     GICv3 172 Edge      11820000.dma-controller:15

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

