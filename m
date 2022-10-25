Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E71060C772
	for <lists+dmaengine@lfdr.de>; Tue, 25 Oct 2022 11:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbiJYJGY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Oct 2022 05:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232244AbiJYJFI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 25 Oct 2022 05:05:08 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFAF15A956;
        Tue, 25 Oct 2022 02:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1666688646; x=1698224646;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DsvW/rKm/Jcsqloupeh0C4YEYWkE77L/ilnhpT2+emo=;
  b=Vw5PZh5nirrRBSshYfWOdkdxr9451VCKffQqlyua/MVTH72/8GBg/TuF
   ehL41j3sKVgFOYYZ1OLtiV+i5PJBctuwUJZMf4QrzEUKP9z+3IjpWSax0
   3ibsEO+jyQMijTiowZAOZa4AJqMDK4i/pWlEzYI4sbVlRKeWOko675zvR
   mq1aBXNQGGoo4wXtdMOr2g/JuUmFsBKUVbyL76Z/QAWlBdzmZcn1KWTrn
   PtnnrRVt8zzw/IrbwyLsjpGFw6YJF0SuqscOpSYRdAbnfht6oK5I7Jy64
   Vx7hxXUPqArQEfrZZ5qbGTjJC1U4kQyk/AeNzrsPW5nvfdE+ie9GaCOeL
   A==;
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="120221326"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Oct 2022 02:04:04 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 25 Oct 2022 02:04:03 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Tue, 25 Oct 2022 02:04:01 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <vkoul@kernel.org>, <peda@axentia.se>, <du@axentia.se>
CC:     <maciej.sosnowski@intel.com>, <nicolas.ferre@microchip.com>,
        <mripard@kernel.org>, <torfl6749@gmail.com>,
        <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH v2 17/32] dmaengine: at_hdmac: Return dma_cookie_status()'s ret code when txstate is NULL
Date:   Tue, 25 Oct 2022 12:02:51 +0300
Message-ID: <20221025090306.297886-18-tudor.ambarus@microchip.com>
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

txstate is an optional parameter used to get a struct with auxilary
transfer status information. When not provided the call to
device_tx_status() should return the status of the dma cookie. Return the
status of dma cookie when the txstate optional parameter is not provided.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/dma/at_hdmac.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index f365ac4d87ff..10b6b0435d52 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -1461,14 +1461,8 @@ atc_tx_status(struct dma_chan *chan,
 	int bytes = 0;
 
 	ret = dma_cookie_status(chan, cookie, txstate);
-	if (ret == DMA_COMPLETE)
+	if (ret == DMA_COMPLETE || !txstate)
 		return ret;
-	/*
-	 * There's no point calculating the residue if there's
-	 * no txstate to store the value.
-	 */
-	if (!txstate)
-		return DMA_ERROR;
 
 	spin_lock_irqsave(&atchan->lock, flags);
 
-- 
2.25.1

