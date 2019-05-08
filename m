Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F99818248
	for <lists+dmaengine@lfdr.de>; Thu,  9 May 2019 00:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfEHWdf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 8 May 2019 18:33:35 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54335 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbfEHWdf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 8 May 2019 18:33:35 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hOV7y-0001Rt-83; Wed, 08 May 2019 22:33:30 +0000
From:   Colin King <colin.king@canonical.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Huang Shijie <sjhuang@iluvatar.ai>, dmaengine@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dma: dw-axi-dmac: fix null dereference when pointer first is null
Date:   Wed,  8 May 2019 23:33:29 +0100
Message-Id: <20190508223329.26796-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

In the unlikely event that axi_desc_get returns a null desc in the
very first iteration of the while-loop the error exit path ends
up calling axi_desc_put on a null pointer 'first' and this causes
a null pointer dereference.  Fix this by adding a null check on
pointer 'first' before calling axi_desc_put.

Addresses-Coverity: ("Explicit null dereference")
fixes: 1fe20f1b8454 ("dmaengine: Introduce DW AXI DMAC driver")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index b2ac1d2c5b86..a1ce307c502f 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -512,7 +512,8 @@ dma_chan_prep_dma_memcpy(struct dma_chan *dchan, dma_addr_t dst_adr,
 	return vchan_tx_prep(&chan->vc, &first->vd, flags);
 
 err_desc_get:
-	axi_desc_put(first);
+	if (first)
+		axi_desc_put(first);
 	return NULL;
 }
 
-- 
2.20.1

