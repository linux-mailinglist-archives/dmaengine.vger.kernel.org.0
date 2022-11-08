Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D75620AB0
	for <lists+dmaengine@lfdr.de>; Tue,  8 Nov 2022 08:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbiKHHtX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 8 Nov 2022 02:49:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233301AbiKHHtW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 8 Nov 2022 02:49:22 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6BB13D2E;
        Mon,  7 Nov 2022 23:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667893761; x=1699429761;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4dh3IRHYQd4HH6cn+7mT19zqVvTBD88fHDivkBet2uM=;
  b=Imdug1vo9Jjmv1Jp2a+lwGzXlQsPKsQ4ulmFIUl4YtJaLrZcFiTMkUx+
   LX9ZU7eJ7cLI2g7MSSMFeDLqoscts3Puow/zUu90tWYSVgvjD1h8rcfdl
   fMJXAZovkg3e+MNuvH7AtufU3gbzCDIC7ipVs4uLLHFONgajjhljrAb12
   0XQRQJfCu05oDHZ8nr0FlW9ItKccxiGbDMQRlrhTxrsEjO2zykbqas6RO
   E5QO2nug5eNGWZ25WHU/jUCcmhZP480vAlzBIsBk1JBokjKJMfEAoTyYj
   mogEUHURaoBijKkmoN294LR2iLR2kORfoKPWNoXsDbryR/tvPDiMd1acE
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="310630781"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="310630781"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 23:49:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="881423689"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="881423689"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 07 Nov 2022 23:49:19 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4E12DF7; Tue,  8 Nov 2022 09:49:43 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] at_hdmac: check and return DMA_PAUSED status when suitable
Date:   Tue,  8 Nov 2022 09:49:37 +0200
Message-Id: <20221108074938.48853-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

device_tx_status() may return DMA_PAUSED status when driver supports it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/at_hdmac.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 8858470246e1..a9d8dd990d6e 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -1669,9 +1669,19 @@ atc_tx_status(struct dma_chan *chan,
 	int ret;
 
 	dma_status = dma_cookie_status(chan, cookie, txstate);
-	if (dma_status == DMA_COMPLETE || !txstate)
+	if (dma_status == DMA_COMPLETE)
 		return dma_status;
 
+	/*
+	 * There's no point in calculating the residue if there's
+	 * no txstate to store the value.
+	 */
+	if (!txstate) {
+		if (test_bit(ATC_IS_PAUSED, &atchan->status))
+			return DMA_PAUSED;
+		return DMA_ERROR;
+	}
+
 	spin_lock_irqsave(&atchan->vc.lock, flags);
 	/*  Get number of bytes left in the active transactions */
 	ret = atc_get_residue(chan, cookie, &residue);
@@ -1684,6 +1694,9 @@ atc_tx_status(struct dma_chan *chan,
 		dma_set_residue(txstate, residue);
 	}
 
+	if (test_bit(ATC_IS_PAUSED, &atchan->status))
+		dma_status = DMA_PAUSED;
+
 	dev_vdbg(chan2dev(chan), "tx_status %d: cookie = %d residue = %u\n",
 		 dma_status, cookie, residue);
 
-- 
2.35.1

