Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04354170827
	for <lists+dmaengine@lfdr.de>; Wed, 26 Feb 2020 19:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbgBZS71 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 26 Feb 2020 13:59:27 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:57732 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbgBZS71 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 26 Feb 2020 13:59:27 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1j71tx-0005OH-Rj; Wed, 26 Feb 2020 18:59:21 +0000
From:   Colin King <colin.king@canonical.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        dmaengine@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] dmaengine: ti: edma: fix null dereference because of a typo in pointer name
Date:   Wed, 26 Feb 2020 18:59:21 +0000
Message-Id: <20200226185921.351693-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently there is a dereference of the null pointer m_ddev.  This appears
to be a typo on the pointer, I believe s_ddev should be used instead.
Fix this by using the correct pointer.

Addresses-Coverity: ("Explicit null dereferenced")
Fixes: eb0249d50153 ("dmaengine: ti: edma: Support for interleaved mem to mem transfer")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/dma/ti/edma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index 2b1fdd438e7f..c4a5c170c1f9 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -1992,7 +1992,7 @@ static void edma_dma_init(struct edma_cc *ecc, bool legacy_mode)
 			 "Legacy memcpy is enabled, things might not work\n");
 
 		dma_cap_set(DMA_MEMCPY, s_ddev->cap_mask);
-		dma_cap_set(DMA_INTERLEAVE, m_ddev->cap_mask);
+		dma_cap_set(DMA_INTERLEAVE, s_ddev->cap_mask);
 		s_ddev->device_prep_dma_memcpy = edma_prep_dma_memcpy;
 		s_ddev->device_prep_interleaved_dma = edma_prep_dma_interleaved;
 		s_ddev->directions = BIT(DMA_MEM_TO_MEM);
-- 
2.25.0

