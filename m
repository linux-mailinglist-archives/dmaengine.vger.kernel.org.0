Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8363573BE7
	for <lists+dmaengine@lfdr.de>; Wed, 13 Jul 2022 19:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbiGMRWc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 Jul 2022 13:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbiGMRWc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 13 Jul 2022 13:22:32 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7FF3B2;
        Wed, 13 Jul 2022 10:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657732951; x=1689268951;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qJ+3C/9Ncktz1eaPrbq5aFlCXzUnpfcZFwBPkdPd2uM=;
  b=WOvqeqSQdxhw1xMljBsuTukwvOWl/W491Z6fyWh1wYvEE7ad8QQ2iMfi
   1OrjSpwuQJ0n6xiS5Etk0zl4XUAAzWXMpezpy0VdqlV/Z47UGB8U3oSZY
   4hZnW19e8908miUm/9P8JHhBgi7i0T/Vy7xCCtRbray+PW57lKnLQTkk0
   R/rc8MYWn+anVXSLnCIpWDp64AKsakmPGCTwCnsX+eJf+cQjrH6hSi1Jl
   hf8wMg20TSI9yhEt9ZkFKvVw9tdF6MfDjVxnzThIiDXHXDO6idmYcxQfo
   UCyfrC14R7BhLaVa0hyPl03FG4A9n6q59U3H6MGvKa+hMuBWkstxLAEaE
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="284048068"
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="284048068"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 10:22:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="685247907"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Jul 2022 10:22:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3DD4DCE; Wed, 13 Jul 2022 20:22:38 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v1 2/4] dmaengine: hsu: using for_each_set_bit to simplify the code
Date:   Wed, 13 Jul 2022 20:22:33 +0300
Message-Id: <20220713172235.22611-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220713172235.22611-1-andriy.shevchenko@linux.intel.com>
References: <20220713172235.22611-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

It's more cleanly to use for_each_set_bit() instead of opencoding it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/hsu/pci.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/hsu/pci.c b/drivers/dma/hsu/pci.c
index 4ed6a4ef1512..8cdf715a7e9e 100644
--- a/drivers/dma/hsu/pci.c
+++ b/drivers/dma/hsu/pci.c
@@ -26,22 +26,19 @@
 static irqreturn_t hsu_pci_irq(int irq, void *dev)
 {
 	struct hsu_dma_chip *chip = dev;
-	u32 dmaisr;
-	u32 status;
+	unsigned long dmaisr;
 	unsigned short i;
+	u32 status;
 	int ret = 0;
 	int err;
 
 	dmaisr = readl(chip->regs + HSU_PCI_DMAISR);
-	for (i = 0; i < chip->hsu->nr_channels; i++) {
-		if (dmaisr & 0x1) {
-			err = hsu_dma_get_status(chip, i, &status);
-			if (err > 0)
-				ret |= 1;
-			else if (err == 0)
-				ret |= hsu_dma_do_irq(chip, i, status);
-		}
-		dmaisr >>= 1;
+	for_each_set_bit(i, &dmaisr, chip->hsu->nr_channels) {
+		err = hsu_dma_get_status(chip, i, &status);
+		if (err > 0)
+			ret |= 1;
+		else if (err == 0)
+			ret |= hsu_dma_do_irq(chip, i, status);
 	}
 
 	return IRQ_RETVAL(ret);
-- 
2.35.1

