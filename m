Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E2A40C44D
	for <lists+dmaengine@lfdr.de>; Wed, 15 Sep 2021 13:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232729AbhIOLV7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Sep 2021 07:21:59 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:44172
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232626AbhIOLV6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Sep 2021 07:21:58 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id CF44640199;
        Wed, 15 Sep 2021 11:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631704838;
        bh=gUevQNSrU/fI4A+JuUNHLjo/ApT0Jo049hkkZ7obUHI=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=REOF3dxYIyce6DmMAQ2rHRYak4YY2APi5f6MdSy9OhpLYQdjuguuJi8PyHeG+bkyw
         NI8GfIFZ9gMwIZGN4wheRqh+bVcuNRa/vKiP2Rm7mbO0jL9O5OKAjlAeCr5jMzkvA9
         JdOm+2ELt3LIBed0UFk7OHhvHh+DrUs5ggWY6Hukk4IU7l3sIH/JXOMKlRLV7phevP
         F/X/fZNOF79mdFz99vmV/IowT841XM8EunLSV2DvyUcpQ6cvrGZJyCRTd4OdH/uZ7O
         XRltXDUe+ULMNu7YZJOp6RP5sYmfzzOIyIc7Py55wuCOP0S03yveGYV9/3mkpfSzVy
         VOdY6krwukqbg==
From:   Colin King <colin.king@canonical.com>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][V2] dmaengine: sh: make array ds_lut static
Date:   Wed, 15 Sep 2021 12:20:38 +0100
Message-Id: <20210915112038.12407-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate the read-only array ds_lut on the stack but instead it
static. Also makes the object code smaller by 163 bytes:

Before:
   text    data     bss     dec     hex filename
  23508    4796       0   28304    6e90 ./drivers/dma/sh/rz-dmac.o

After:
   text    data     bss     dec     hex filename
  23281    4860       0   28141    6ded ./drivers/dma/sh/rz-dmac.o

(gcc version 11.2.0)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
V2: Fix $SUBJECT, array name should be ds_lut
---
 drivers/dma/sh/rz-dmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index f9f30cbeccbe..005f1a3ff634 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -573,7 +573,7 @@ static void rz_dmac_issue_pending(struct dma_chan *chan)
 static u8 rz_dmac_ds_to_val_mapping(enum dma_slave_buswidth ds)
 {
 	u8 i;
-	const enum dma_slave_buswidth ds_lut[] = {
+	static const enum dma_slave_buswidth ds_lut[] = {
 		DMA_SLAVE_BUSWIDTH_1_BYTE,
 		DMA_SLAVE_BUSWIDTH_2_BYTES,
 		DMA_SLAVE_BUSWIDTH_4_BYTES,
-- 
2.32.0

