Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7A3F9968
	for <lists+dmaengine@lfdr.de>; Tue, 12 Nov 2019 20:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfKLTLr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 Nov 2019 14:11:47 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33234 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbfKLTLr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 12 Nov 2019 14:11:47 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iUbZn-0002hx-Qf; Tue, 12 Nov 2019 19:11:43 +0000
From:   Colin King <colin.king@canonical.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: iop-adma: clean up an indentation issue
Date:   Tue, 12 Nov 2019 19:11:43 +0000
Message-Id: <20191112191143.282814-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a statement that is indented too deeply, remove
the extraneous indentation.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/dma/iop-adma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/iop-adma.c b/drivers/dma/iop-adma.c
index 4dc5478fc156..db0e274126fb 100644
--- a/drivers/dma/iop-adma.c
+++ b/drivers/dma/iop-adma.c
@@ -173,7 +173,7 @@ static void __iop_adma_slot_cleanup(struct iop_adma_chan *iop_chan)
 					&iop_chan->chain, chain_node) {
 					zero_sum_result |=
 					    iop_desc_get_zero_result(grp_iter);
-					    pr_debug("\titer%d result: %d\n",
+					pr_debug("\titer%d result: %d\n",
 					    grp_iter->idx, zero_sum_result);
 					slot_cnt -= slots_per_op;
 					if (slot_cnt == 0)
-- 
2.20.1

