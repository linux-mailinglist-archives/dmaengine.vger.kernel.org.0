Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A61D285A7F
	for <lists+dmaengine@lfdr.de>; Wed,  7 Oct 2020 10:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbgJGIbd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 7 Oct 2020 04:31:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:58404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbgJGIbc (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 7 Oct 2020 04:31:32 -0400
Received: from localhost.localdomain (unknown [122.171.222.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAE9220870;
        Wed,  7 Oct 2020 08:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602059492;
        bh=2gd/3/74qE00gFvagsA46KcH0+7qFIXEYq//HO7jQnI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lJ3PlMH4o01MLlZvK9sosp4w1wPl1YKytayFro2szUBhPJgClwtAuiuya7djM+oJK
         SGIz/wdmmiF6OH8OPywoafM7pY05dGgYO83Q9mZ0X6p7WyKKo8P8pqaJchtWt0LVsI
         AkTzlk3PilSTXdTartK78PsT/93bijMUcIMuW3lI=
From:   Vinod Koul <vkoul@kernel.org>
To:     dmaengine@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>, Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] dmaengine: altera-msgdma: fix kernel-doc style for tasklet
Date:   Wed,  7 Oct 2020 14:01:09 +0530
Message-Id: <20201007083113.567559-2-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201007083113.567559-1-vkoul@kernel.org>
References: <20201007083113.567559-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Commit 6752e40d669a ("dmaengine: altera-msgdma: convert tasklets to use
new tasklet_setup() API") updated driver to use new tasklet_setup() API
but missed to update the documentation for the tasklet function.

Fixes: 6752e40d669a ("dmaengine: altera-msgdma: convert tasklets to use new tasklet_setup() API")
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/altera-msgdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/altera-msgdma.c b/drivers/dma/altera-msgdma.c
index 4d6751bf6f11..9a841ce5f0c5 100644
--- a/drivers/dma/altera-msgdma.c
+++ b/drivers/dma/altera-msgdma.c
@@ -678,7 +678,7 @@ static int msgdma_alloc_chan_resources(struct dma_chan *dchan)
 
 /**
  * msgdma_tasklet - Schedule completion tasklet
- * @data: Pointer to the Altera sSGDMA channel structure
+ * @t: Pointer to the Altera sSGDMA channel structure
  */
 static void msgdma_tasklet(struct tasklet_struct *t)
 {
-- 
2.26.2

