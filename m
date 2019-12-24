Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17770129D97
	for <lists+dmaengine@lfdr.de>; Tue, 24 Dec 2019 06:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725858AbfLXFDm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 Dec 2019 00:03:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:33740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbfLXFDm (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 24 Dec 2019 00:03:42 -0500
Received: from localhost.localdomain (unknown [122.167.68.227])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C26F2071E;
        Tue, 24 Dec 2019 05:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577163821;
        bh=+IGau3AyCY8MYwyo4wJdg0D20GhOXqWNP0G6ezWvWRo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B4MLPnYJqBEvQRd632dzBaLgux506TtiO0gJlSESoC0183S44n5kK1SuFTIvELNK+
         I4zRBsPsQMy/M2fy3J40gCHnzPFX5kk3uVwes3J8qV8IwJNITZ6u1LLKaLv+2Vll6V
         1Zbwz6kxf2sOyYF3Gpr33MXNWj0Mik1te2D/rLmA=
From:   Vinod Koul <vkoul@kernel.org>
To:     dmaengine@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: [PATCH 2/2] dmaengine: print more meaningful error message
Date:   Tue, 24 Dec 2019 10:33:26 +0530
Message-Id: <20191224050326.3481588-2-vkoul@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191224050326.3481588-1-vkoul@kernel.org>
References: <20191224050326.3481588-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

error log for dma_channel_table_init() failure pointed a mere
"initialization failure", which is not very helpful message, so print
additional details like function name and error code.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/dmaengine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 0505ea5b002f..4ac77456e830 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -206,7 +206,7 @@ static int __init dma_channel_table_init(void)
 	}
 
 	if (err) {
-		pr_err("initialization failure\n");
+		pr_err("dmaengine dma_channel_table_init failure: %d\n", err);
 		for_each_dma_cap_mask(cap, dma_cap_mask_all)
 			free_percpu(channel_table[cap]);
 	}
-- 
2.23.0

