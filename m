Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71AD1274A76
	for <lists+dmaengine@lfdr.de>; Tue, 22 Sep 2020 22:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgIVU5l (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 22 Sep 2020 16:57:41 -0400
Received: from ale.deltatee.com ([204.191.154.188]:49992 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgIVU5l (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 22 Sep 2020 16:57:41 -0400
X-Greylist: delayed 2926 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Sep 2020 16:57:41 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=79PSozI9m8qEzrG9Klfx1TLRdoa057EVPadwK1EgUac=; b=KW7paQGHjjmNPAK1+iHprV2RrP
        Pjyn36ukSG61uAPUratvBrwg0QAQLCIhj6j+CwQVXDCNBhi5cV99jqm2aBMwI+AAWfQPrViRkAHR0
        S3sV51L7gORzwW5hSB3WDY8YFodZWDAVdtxrwwzH62oMjvEtkrDF3gyyOAqallQSAU2lkWtFbpjB9
        0LbFszfeaKVc21J5NhCNk8z5ZxFqw6G5XD9eLCQ85jmwTqMlfuiSsI4CFbY3N+wEZ8aEH3eHWUg3f
        AGghPAgk93qR9h8EvEtkoNh7B7YtfiStvUuhXoNsAP8Tr86tFQtwt7f9DQrQ95ApiRsFEOhDNCoyF
        at4/8fww==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1kKoar-00058z-R0; Tue, 22 Sep 2020 14:08:55 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1kKoaq-0000mq-D4; Tue, 22 Sep 2020 14:08:52 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 22 Sep 2020 14:08:44 -0600
Message-Id: <20200922200844.2982-1-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, logang@deltatee.com, robin.murphy@arm.com, vkoul@kernel.org, dave.jiang@intel.com, dan.j.williams@intel.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        MYRULES_FREE,MYRULES_NO_TEXT,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.2
Subject: [PATCH] dmaengine: ioat: Allocate correct size for descriptor chunk
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

dma_alloc_coherent() is called with a fixed SZ_2M size, but frees happen
with IOAT_CHUNK_SIZE. Recently, IOAT_CHUNK_SIZE was reduced to 512M but
the allocation did not change. To fix, change to using the
IOAT_CHUNK_SIZE define.

This was caught with the upcoming patchset for converting Intel platforms to the
dma-iommu implementation. It has a warning when the unmapped size differs from
the mapped size.

Fixes: a02254f8a676 ("dmaengine: ioat: Decreasing allocation chunk size 2M->512K")
Link: https://lore.kernel.org/intel-gfx/776771a2-247a-d1be-d882-bee02d919ae0@deltatee.com/
Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dma/ioat/dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/ioat/dma.c b/drivers/dma/ioat/dma.c
index a814b200299b..07296171e2bb 100644
--- a/drivers/dma/ioat/dma.c
+++ b/drivers/dma/ioat/dma.c
@@ -389,7 +389,7 @@ ioat_alloc_ring(struct dma_chan *c, int order, gfp_t flags)
 		struct ioat_descs *descs = &ioat_chan->descs[i];
 
 		descs->virt = dma_alloc_coherent(to_dev(ioat_chan),
-						 SZ_2M, &descs->hw, flags);
+					IOAT_CHUNK_SIZE, &descs->hw, flags);
 		if (!descs->virt) {
 			int idx;
 

base-commit: ba4f184e126b751d1bffad5897f263108befc780
-- 
2.20.1

