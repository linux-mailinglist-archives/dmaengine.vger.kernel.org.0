Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E011459AE0D
	for <lists+dmaengine@lfdr.de>; Sat, 20 Aug 2022 15:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347162AbiHTM73 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 20 Aug 2022 08:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347168AbiHTM7F (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 20 Aug 2022 08:59:05 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB0D4BD34;
        Sat, 20 Aug 2022 05:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661000313; x=1692536313;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EqIew9+MpGCMfwN/RDi+KIL5lpl8bJVTG4PPXYs0/14=;
  b=tbNuvNqlMruD+NnZTmUswFG3XxaOvDVbAEV9TXGdvc9UGfgfpkyUbgxQ
   NDWu74/NOUGy/DKyyeHBEL0AM8y7msqbYix6QbW7NxJSHH2UvjaNVrYew
   eGAlDX2FbCR9pABqUOP5y2oL+uJS6h9+Qmw+c9rcuB77IzD2dw7VBOqB3
   YGwkji2RmmP/SxTWLO/4EGGacJnX2c6I73tdNiSXaUghxIiA6Ma08hsQX
   tOwTleJE8T0ACQJxc9Ax5aX1g7uYP89rhLqjr3vQtjxTSBk8t+YbOL4Zj
   ZjXmjbOqQyJhw6PGNocaAyxqWMIMOCvfliDsaG8HcdqYBZtVw4CbFyAzB
   w==;
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="187325681"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Aug 2022 05:58:32 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Sat, 20 Aug 2022 05:58:32 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Sat, 20 Aug 2022 05:58:29 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <vkoul@kernel.org>, <peda@axentia.se>, <du@axentia.se>,
        <regressions@leemhuis.info>
CC:     <ludovic.desroches@microchip.com>, <maciej.sosnowski@intel.com>,
        <tudor.ambarus@microchip.com>, <dan.j.williams@intel.com>,
        <nicolas.ferre@microchip.com>, <mripard@kernel.org>,
        <torfl6749@gmail.com>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 20/33] dmaengine: at_hdmac: Do not print messages on console while holding the lock
Date:   Sat, 20 Aug 2022 15:57:04 +0300
Message-ID: <20220820125717.588722-21-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220820125717.588722-1-tudor.ambarus@microchip.com>
References: <20220820125717.588722-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index 1cb0d26d30ed..16cea65a708d 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -983,6 +983,8 @@ static void atc_handle_error(struct at_dma_chan *atchan)
 		atc_dostart(atchan, desc);
 	}
 
+	spin_unlock_irqrestore(&atchan->lock, flags);
+
 	/*
 	 * KERN_CRITICAL may seem harsh, but since this only happens
 	 * when someone submits a bad physical address in a
@@ -998,8 +1000,6 @@ static void atc_handle_error(struct at_dma_chan *atchan)
 	list_for_each_entry(child, &bad_desc->tx_list, desc_node)
 		atc_dump_lli(atchan, &child->lli);
 
-	spin_unlock_irqrestore(&atchan->lock, flags);
-
 	/* Pretend the descriptor completed successfully */
 	atc_chain_complete(atchan, bad_desc);
 }
-- 
2.25.1

