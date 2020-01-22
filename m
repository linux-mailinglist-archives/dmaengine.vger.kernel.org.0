Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9C801450F8
	for <lists+dmaengine@lfdr.de>; Wed, 22 Jan 2020 10:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbgAVJu0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Jan 2020 04:50:26 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:36150 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732960AbgAVJiY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Jan 2020 04:38:24 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iuCSp-0003cj-3Y; Wed, 22 Jan 2020 09:38:19 +0000
From:   Colin King <colin.king@canonical.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        dmaengine@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] dmaengine: ti: k3-udma: fix spelling mistake "limted" -> "limited"
Date:   Wed, 22 Jan 2020 09:38:18 +0000
Message-Id: <20200122093818.2800743-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are spelling mistakes in dev_err messages. Fix them.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/dma/ti/k3-udma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 9974e72cdc50..ea79c2df28e0 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -2300,7 +2300,7 @@ udma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	/* static TR for remote PDMA */
 	if (udma_configure_statictr(uc, d, dev_width, burst)) {
 		dev_err(uc->ud->dev,
-			"%s: StaticTR Z is limted to maximum 4095 (%u)\n",
+			"%s: StaticTR Z is limited to maximum 4095 (%u)\n",
 			__func__, d->static_tr.bstcnt);
 
 		udma_free_hwdesc(uc, d);
@@ -2483,7 +2483,7 @@ udma_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
 	/* static TR for remote PDMA */
 	if (udma_configure_statictr(uc, d, dev_width, burst)) {
 		dev_err(uc->ud->dev,
-			"%s: StaticTR Z is limted to maximum 4095 (%u)\n",
+			"%s: StaticTR Z is limited to maximum 4095 (%u)\n",
 			__func__, d->static_tr.bstcnt);
 
 		udma_free_hwdesc(uc, d);
-- 
2.24.0

