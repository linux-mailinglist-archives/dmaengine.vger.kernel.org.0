Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3445B9944
	for <lists+dmaengine@lfdr.de>; Thu, 15 Sep 2022 13:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiIOLDK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 15 Sep 2022 07:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiIOLDH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 15 Sep 2022 07:03:07 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87BF9926A;
        Thu, 15 Sep 2022 04:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663239786; x=1694775786;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JJnRYj7NPQDMFAirw9QUIbVf7WfT2dsZ/Q12yTqq4GA=;
  b=W8RO/lQkeR9E0CbmZGKTyUEj0Xd2F6ASI24ceEIHNd64U93ho++LNkWl
   j/z1FMuJtdZ+VvIShXJ02ty6cDmOkI7J1L6Dw69xBx5/RFfKzCahGlmLj
   E8gqB/UbQPCepksZ7/0msDXb0WXlIpGSFTTV8bboQdUNXF4mxEGbWN5ND
   S14IBfVV3ZkPr518R4ok9QEYEV2wScvc63LNSlp/i4mygT8SnzkH2RqCE
   1b68ycrx2idE13E/lXWuAyEpu94UY0zsq1vsWMiwiUXs1430v7P69GCeb
   Jhutkgl1WlPzMxqGhPsCaeS3PHWlUzDBDOzn1edbuj05T5o2JGjYLxqLx
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,317,1654585200"; 
   d="scan'208";a="113813874"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Sep 2022 04:03:06 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 15 Sep 2022 04:03:04 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Thu, 15 Sep 2022 04:03:03 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <ludovic.desroches@microchip.com>, <tudor.ambarus@microchip.com>,
        <vkoul@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 3/3] dmaengine: at_xdmac: remove empty line
Date:   Thu, 15 Sep 2022 14:05:16 +0300
Message-ID: <20220915110516.4160443-4-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220915110516.4160443-1-claudiu.beznea@microchip.com>
References: <20220915110516.4160443-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Remove empty line.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/dma/at_xdmac.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index a9278bf4c17b..1f0fab180f8f 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -533,7 +533,6 @@ static void at_xdmac_start_xfer(struct at_xdmac_chan *atchan,
 		 at_xdmac_chan_read(atchan, AT_XDMAC_CSA),
 		 at_xdmac_chan_read(atchan, AT_XDMAC_CDA),
 		 at_xdmac_chan_read(atchan, AT_XDMAC_CUBC));
-
 }
 
 static dma_cookie_t at_xdmac_tx_submit(struct dma_async_tx_descriptor *tx)
-- 
2.34.1

