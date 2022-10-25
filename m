Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13FE60C771
	for <lists+dmaengine@lfdr.de>; Tue, 25 Oct 2022 11:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiJYJGW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Oct 2022 05:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232225AbiJYJFI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 25 Oct 2022 05:05:08 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB9515A8F6;
        Tue, 25 Oct 2022 02:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1666688644; x=1698224644;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kDm2uPx3R/Ls2XXpsY+sy6aD5vNdGltPVO6OtLCRB/w=;
  b=YhkYd1nrGYmhA5Q4c4yMR4hoBVOATQ3u1NrT58y33Bo1JXEiht+hZvkN
   4C2l9VtZM5B1PhSzFWjihN5lVW6xnBAq08RUDzRT1ltXJK91Jymjv7Jm9
   O98YrmiSJVEhi2Rbh7joXQzAgfc5F1TKPBrAAmyQ6mk2YtE9wf0CVcHr9
   Y+wgYsC+gxp8VMqhPXci/hBgIphM6/EjiDbsdA5jguzXXtiENSdCfux9O
   ZY5wKjnXXgAukhXAfw6EDcjZzjhb+Ckn3A6dbIpA5Ug70RPcm1EyFDAN9
   j1f3jlwXsEbdj1bdpRQzv448PiJlv5ig0X2pHqJYWC8JoS359ixKt+/8F
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="120221319"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Oct 2022 02:04:04 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 25 Oct 2022 02:04:00 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Tue, 25 Oct 2022 02:03:58 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <vkoul@kernel.org>, <peda@axentia.se>, <du@axentia.se>
CC:     <maciej.sosnowski@intel.com>, <nicolas.ferre@microchip.com>,
        <mripard@kernel.org>, <torfl6749@gmail.com>,
        <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH v2 16/32] dmaengine: at_hdmac: Do not print messages on console while holding the lock
Date:   Tue, 25 Oct 2022 12:02:50 +0300
Message-ID: <20221025090306.297886-17-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221025090306.297886-1-tudor.ambarus@microchip.com>
References: <20221025090306.297886-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The descriptor was already removed from the transfer list, there's no
reason to keep the channel lock while printing desc info, thus do the
prints without holding the lock.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/dma/at_hdmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 858bd64f1313..f365ac4d87ff 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -549,6 +549,8 @@ static void atc_handle_error(struct at_dma_chan *atchan)
 		atc_dostart(atchan, desc);
 	}
 
+	spin_unlock_irqrestore(&atchan->lock, flags);
+
 	/*
 	 * KERN_CRITICAL may seem harsh, but since this only happens
 	 * when someone submits a bad physical address in a
@@ -564,8 +566,6 @@ static void atc_handle_error(struct at_dma_chan *atchan)
 	list_for_each_entry(child, &bad_desc->tx_list, desc_node)
 		atc_dump_lli(atchan, &child->lli);
 
-	spin_unlock_irqrestore(&atchan->lock, flags);
-
 	/* Pretend the descriptor completed successfully */
 	atc_chain_complete(atchan, bad_desc);
 }
-- 
2.25.1

