Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAC4620AB1
	for <lists+dmaengine@lfdr.de>; Tue,  8 Nov 2022 08:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233631AbiKHHtY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 8 Nov 2022 02:49:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233412AbiKHHtW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 8 Nov 2022 02:49:22 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314FA13D3F;
        Mon,  7 Nov 2022 23:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667893762; x=1699429762;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rDiKYYjFpjjWtrYxiCT/r9k/W3/JQ0t2Kz7s3ZTXOAY=;
  b=OGYPdk5HR54T6Nok04p9yKDoruiDGhvy/1O5LKFej1fCCuzldNF3+qzP
   aEyC1hD9GRCq1T3qGHRVd8JgqmJKqjV5Vq6wH2FIDt/mi92cfv7YIuwfS
   QziVKOqrwWJrLxGcmG5mTMwC6/wx/Pjdf/Ha8eUZtuZ54bKolXDkrNSSV
   ST7UaxzYXFyz2fCDFLs607BOoSKTGdi2F1C2lzsmNNFG24rSwBR4eZ3wP
   eYAkb27iubQP3aSEsWk5Is/9AAe23LDFhNYl3iI8LOh5XeDg+FKUp0yHL
   X95sAmjmpb6Lu94miqQTZkQP7eCYUPaSYpmudwBa0sxOgrGHahFWeJ1a6
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="308252779"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="308252779"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 23:49:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="725470502"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="725470502"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Nov 2022 23:49:19 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5DCE9B7; Tue,  8 Nov 2022 09:49:43 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/2] at_hdmac: return actual status when txstatus parameter is NULL
Date:   Tue,  8 Nov 2022 09:49:38 +0200
Message-Id: <20221108074938.48853-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221108074938.48853-1-andriy.shevchenko@linux.intel.com>
References: <20221108074938.48853-1-andriy.shevchenko@linux.intel.com>
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

There is no point to return DMA_ERROR if txstatus parameter is NULL. It's a
valid case and should be handled correspondingly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/at_hdmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index a9d8dd990d6e..4035d5438530 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -1679,7 +1679,7 @@ atc_tx_status(struct dma_chan *chan,
 	if (!txstate) {
 		if (test_bit(ATC_IS_PAUSED, &atchan->status))
 			return DMA_PAUSED;
-		return DMA_ERROR;
+		return dma_status;
 	}
 
 	spin_lock_irqsave(&atchan->vc.lock, flags);
-- 
2.35.1

