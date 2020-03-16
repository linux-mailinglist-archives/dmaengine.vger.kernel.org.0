Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C41691867A6
	for <lists+dmaengine@lfdr.de>; Mon, 16 Mar 2020 10:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730126AbgCPJQ6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 Mar 2020 05:16:58 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56309 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730025AbgCPJQ5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 16 Mar 2020 05:16:57 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jDlrh-0006T8-Od; Mon, 16 Mar 2020 09:16:53 +0000
From:   Colin King <colin.king@canonical.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: fix spelling mistake "exceds" -> "exceeds"
Date:   Mon, 16 Mar 2020 09:16:53 +0000
Message-Id: <20200316091653.110984-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are a couple of spelling mistakes in dev_err error messages.
Fix them.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/dma/sh/rcar-dmac.c  | 2 +-
 drivers/dma/sh/shdma-base.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index f06016d38a05..59b36ab5d684 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -1219,7 +1219,7 @@ rcar_dmac_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr,
 	sg_len = buf_len / period_len;
 	if (sg_len > RCAR_DMAC_MAX_SG_LEN) {
 		dev_err(chan->device->dev,
-			"chan%u: sg length %d exceds limit %d",
+			"chan%u: sg length %d exceeds limit %d",
 			rchan->index, sg_len, RCAR_DMAC_MAX_SG_LEN);
 		return NULL;
 	}
diff --git a/drivers/dma/sh/shdma-base.c b/drivers/dma/sh/shdma-base.c
index c51de498b5b4..2deeaab078a4 100644
--- a/drivers/dma/sh/shdma-base.c
+++ b/drivers/dma/sh/shdma-base.c
@@ -709,7 +709,7 @@ static struct dma_async_tx_descriptor *shdma_prep_dma_cyclic(
 	BUG_ON(!schan->desc_num);
 
 	if (sg_len > SHDMA_MAX_SG_LEN) {
-		dev_err(schan->dev, "sg length %d exceds limit %d",
+		dev_err(schan->dev, "sg length %d exceeds limit %d",
 				sg_len, SHDMA_MAX_SG_LEN);
 		return NULL;
 	}
-- 
2.25.1

