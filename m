Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 687EFA311B
	for <lists+dmaengine@lfdr.de>; Fri, 30 Aug 2019 09:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbfH3HiO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 30 Aug 2019 03:38:14 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42481 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbfH3HiN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 30 Aug 2019 03:38:13 -0400
Received: by mail-pg1-f193.google.com with SMTP id p3so3094227pgb.9
        for <dmaengine@vger.kernel.org>; Fri, 30 Aug 2019 00:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=v5xyixMQpdnvsR85DjQFgmM24utx1QoiwCBrTyF/frg=;
        b=Grs7Mr/kb+erqCA+QcT/K0ygk8yUOU+cOayf7fRm/iYs/sK5SMsg/Nhkyw28NnPaeB
         njw6NpYe7ZN1z/SJOj/32nI9QCSXsEPPAopB39aBmH/nckAImHnf8bMbqOo0abLy+KiA
         wzSU+G0/Chy4UekpPbEl6lx05fTwPT8hDhE15+IGk3v9XoUV49tzu7KE+pKHYcP/UARf
         hPJx9MAuJrbPgUgnKxWuER0p+qoUWRZvt8OPkh6wW+on69na7borZhEuOwbZ/zz0FTI2
         jNEtyZw7QBWGb+VSH5SEvu8AkmuDPgIO23O+TOstZytvgQIyYEXDP9fIUAbK95pi6nxn
         MLMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=v5xyixMQpdnvsR85DjQFgmM24utx1QoiwCBrTyF/frg=;
        b=Zl/t1tvBv1pszsCYuKndZyPNsciG6ngswUvAY3llY44pzEZ1iPjUfMUa4mioNzC+Zx
         YvsEeySSQGelWoXq2DFbHZz86b8V0uZHCblJv8US3YKKnDfOvPNq/GxMCPqg4yjmyef1
         vnd1MSl+ZxzwK1Fa44/56arZPJA1ruWDHSgcs5dY/8P5CS61vzvc8peNcwgwTjYYouMl
         pOUzKACV+P06UQztvj7LzgmQHG1mQoysjkBkFX3NbGH4FA5DiPyz1kIxsrukZ0FVG7R4
         dFkyRWu/Dfs6ETFIYZ9lGzI1tCwE6ZkRqgWB0MUVTAuC+jdqv9IdJi7HeotoS13fIWQC
         iFQQ==
X-Gm-Message-State: APjAAAWvQrdxRAgjWGYdz1hLpw1mAzCXHQvbC02BRpjq8qlCRg/tWK00
        jlah8pHeBNcluvogykzTclcjFQ==
X-Google-Smtp-Source: APXvYqzDpmQvEW7+jkTs8Tps24AKLrQHBYSttRFZtZ8yU2QTCVGvVlI2lfsCP4wPD1x6JrkEMz54MQ==
X-Received: by 2002:a62:641:: with SMTP id 62mr16324411pfg.55.1567150693260;
        Fri, 30 Aug 2019 00:38:13 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id k8sm4036197pgm.14.2019.08.30.00.38.10
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 30 Aug 2019 00:38:12 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     vkoul@kernel.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, eric.long@unisoc.com,
        baolin.wang@linaro.org
Subject: [PATCH] dmaengine: sprd: Fix the DMA link-list configuration
Date:   Fri, 30 Aug 2019 15:37:45 +0800
Message-Id: <77868edb7aff9d5cb12ac3af8827ef2e244441a6.1567150471.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

For the Spreadtrum DMA link-list mode, when the DMA engine got a slave
hardware request, which will trigger the DMA engine to load the DMA
configuration from the link-list memory automatically. But before the
slave hardware request, the slave will get an incorrect residue due
to the first node used to trigger the link-list was configured as the
last source address and destination address.

Thus we should make sure the first node was configured the start source
address and destination address, which can fix this issue.

Fixes: 4ac695464763 ("dmaengine: sprd: Support DMA link-list mode")
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/dma/sprd-dma.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index baac476..525dc73 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -908,6 +908,7 @@ static int sprd_dma_fill_linklist_desc(struct dma_chan *chan,
 	struct sprd_dma_chn *schan = to_sprd_dma_chan(chan);
 	struct dma_slave_config *slave_cfg = &schan->slave_cfg;
 	dma_addr_t src = 0, dst = 0;
+	dma_addr_t start_src = 0, start_dst = 0;
 	struct sprd_dma_desc *sdesc;
 	struct scatterlist *sg;
 	u32 len = 0;
@@ -954,6 +955,11 @@ static int sprd_dma_fill_linklist_desc(struct dma_chan *chan,
 			dst = sg_dma_address(sg);
 		}
 
+		if (!i) {
+			start_src = src;
+			start_dst = dst;
+		}
+
 		/*
 		 * The link-list mode needs at least 2 link-list
 		 * configurations. If there is only one sg, it doesn't
@@ -970,8 +976,8 @@ static int sprd_dma_fill_linklist_desc(struct dma_chan *chan,
 		}
 	}
 
-	ret = sprd_dma_fill_desc(chan, &sdesc->chn_hw, 0, 0, src, dst, len,
-				 dir, flags, slave_cfg);
+	ret = sprd_dma_fill_desc(chan, &sdesc->chn_hw, 0, 0, start_src,
+				 start_dst, len, dir, flags, slave_cfg);
 	if (ret) {
 		kfree(sdesc);
 		return NULL;
-- 
1.7.9.5

