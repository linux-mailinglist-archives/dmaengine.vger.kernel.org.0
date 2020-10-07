Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 304BA285A81
	for <lists+dmaengine@lfdr.de>; Wed,  7 Oct 2020 10:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgJGIbi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 7 Oct 2020 04:31:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:58554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbgJGIbg (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 7 Oct 2020 04:31:36 -0400
Received: from localhost.localdomain (unknown [122.171.222.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F14462076C;
        Wed,  7 Oct 2020 08:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602059495;
        bh=z77TDlqXGTSR2SEmqCrrUYWAnL4vzFADbu2U+U93cwM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UNgU/WONYGJToMrduhLMRaa6AJmp1sn7iWoJCTbjWqkuvfFxpRsBn7ik4CcGQMo88
         JTEyZeiyP3rNsnzffENXn6yg4BB4MyFzkKAyuGUoq4YmRity72QUx2kaN2bls5tEDa
         2qkucrhEUok9rfC7VjFw9UVGgKsKSgI8Pn4KqL5I=
From:   Vinod Koul <vkoul@kernel.org>
To:     dmaengine@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>, Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH 2/5] dmaengine: qcom: bam_dma: fix kernel-doc style for tasklet
Date:   Wed,  7 Oct 2020 14:01:10 +0530
Message-Id: <20201007083113.567559-3-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201007083113.567559-1-vkoul@kernel.org>
References: <20201007083113.567559-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Commit 00c4747a2f64 ("dmaengine: qcom: convert tasklets to use new
tasklet_setup() API") updated driver to use new tasklet_setup() API but
missed to update the documentation for the tasklet function.

Fixes: 00c4747a2f64 ("dmaengine: qcom: convert tasklets to use new tasklet_setup() API")
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/qcom/bam_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index 0ea9b9c9ce85..4eeb8bb27279 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -1070,7 +1070,7 @@ static void bam_start_dma(struct bam_chan *bchan)
 
 /**
  * dma_tasklet - DMA IRQ tasklet
- * @data: tasklet argument (bam controller structure)
+ * @t: tasklet argument (bam controller structure)
  *
  * Sets up next DMA operation and then processes all completed transactions
  */
-- 
2.26.2

