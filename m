Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA42B40C445
	for <lists+dmaengine@lfdr.de>; Wed, 15 Sep 2021 13:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232729AbhIOLVM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Sep 2021 07:21:12 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:54650
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232699AbhIOLVM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Sep 2021 07:21:12 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 0F8483F245;
        Wed, 15 Sep 2021 11:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631704792;
        bh=WVCnoP1McqLMZ2VjfLfuYtx94nrxfK/vPmHsWXhCKjg=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=C6IAgxupSeHodhJuUrda+Quo8wDS56uxJLCwwNvI5D1UOWVlTWOB/BLXhyu3FD58D
         3cjIOi3qwV1/dycmxoNQ/24ipUDKxs3glkXjerlSGzGPa7JRWajQ9qSw24u3tP3zpZ
         Gkr/SQRfWGzFBfYfayvkXfpcNnXt7+8HvUelSNtG5FsqhPRnA4bvXgyrr/WfqPEuHx
         zE5jX17yedgNqPfxwQG1v7JjKdjrD/quDAuOWQN5JqlrcMPDsQ8n/cWUWS70gVtG8y
         XUzZc76EbUqpGoUAem7+cOSGTKoKee1CxN19ePYZMo3y9901YQPessJL3TbiN0N57L
         kPg/0ydduttBg==
From:   Colin King <colin.king@canonical.com>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: sh: make array descs static
Date:   Wed, 15 Sep 2021 12:19:51 +0100
Message-Id: <20210915111951.12326-1-colin.king@canonical.com>
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

