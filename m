Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD8F4395E
	for <lists+dmaengine@lfdr.de>; Thu, 13 Jun 2019 17:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732295AbfFMPN0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 13 Jun 2019 11:13:26 -0400
Received: from mga14.intel.com ([192.55.52.115]:50404 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732265AbfFMNcg (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 13 Jun 2019 09:32:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jun 2019 06:32:36 -0700
X-ExtLoop1: 1
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 13 Jun 2019 06:32:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 600FD239; Thu, 13 Jun 2019 16:32:33 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] dmaengine: hsu: Revert "set HSU_CH_MTSR to memory width"
Date:   Thu, 13 Jun 2019 16:32:32 +0300
Message-Id: <20190613133232.49971-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The commit

  080edf75d337 ("dmaengine: hsu: set HSU_CH_MTSR to memory width")

has been mistakenly submitted. The further investigations show that
the original code does better job since the memory side transfer size
has never been configured by DMA users.

As per latest revision of documentation: "Channel minimum transfer size
(CHnMTSR)... For IOSF UART, maximum value that can be programmed is 64 and
minimum value that can be programmed is 1."

This reverts commit 080edf75d337d35faa6fc3df99342b10d2848d16.

Fixes: 080edf75d337 ("dmaengine: hsu: set HSU_CH_MTSR to memory width")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/hsu/hsu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/hsu/hsu.c b/drivers/dma/hsu/hsu.c
index e06f20272fd7..dfabc64c2ab0 100644
--- a/drivers/dma/hsu/hsu.c
+++ b/drivers/dma/hsu/hsu.c
@@ -64,10 +64,10 @@ static void hsu_dma_chan_start(struct hsu_dma_chan *hsuc)
 
 	if (hsuc->direction == DMA_MEM_TO_DEV) {
 		bsr = config->dst_maxburst;
-		mtsr = config->src_addr_width;
+		mtsr = config->dst_addr_width;
 	} else if (hsuc->direction == DMA_DEV_TO_MEM) {
 		bsr = config->src_maxburst;
-		mtsr = config->dst_addr_width;
+		mtsr = config->src_addr_width;
 	}
 
 	hsu_chan_disable(hsuc);
-- 
2.20.1

