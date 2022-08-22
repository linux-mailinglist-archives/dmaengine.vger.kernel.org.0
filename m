Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C25059BC93
	for <lists+dmaengine@lfdr.de>; Mon, 22 Aug 2022 11:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbiHVJRY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Aug 2022 05:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234586AbiHVJPw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 22 Aug 2022 05:15:52 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014F31A04D;
        Mon, 22 Aug 2022 02:15:36 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 27M9FXj6036832;
        Mon, 22 Aug 2022 04:15:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1661159733;
        bh=roTfperRVByHKT6yxJjjvpXH17NlwkzLgVIKQfXQcDc=;
        h=From:To:CC:Subject:Date;
        b=xpesxG5BVQ0y821yOZBos08Xelt3RuvB2lcys1LLChf02ZZk07LI983hVB3CdR8vo
         IUrKrYRFNihgsg9O2pYYvBtVwW1TvELFw8SOyyrGWEXdB7x7Azv2yJWg1h5S22JAmp
         ooPnVMFjL1TzTsXC9iJHVNNRrFzmTqQpbKlzfoys=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 27M9FXJl111233
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 Aug 2022 04:15:33 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 22
 Aug 2022 04:15:32 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 22 Aug 2022 04:15:32 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 27M9FVXQ037023;
        Mon, 22 Aug 2022 04:15:32 -0500
From:   Vaishnav Achath <vaishnav.a@ti.com>
To:     <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>,
        <broonie@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
CC:     <vigneshr@ti.com>, <kishon@ti.com>, <vaishnav.a@ti.com>
Subject: [PATCH 0/2] spi: spi-omap2-mcspi: Use EOW interrupt for transfer completion
Date:   Mon, 22 Aug 2022 14:45:29 +0530
Message-ID: <20220822091531.27827-1-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

When using MCSPI with DMA enabled in Master/Slave mode, real-time 
performance issues were observed which were root caused to the 
uncertain delays in the  TX completion calculation mechanism in
k3-udma driver.

This series updates the omap2-mcspi driver to use End of Word(EOW)
interrupt to identify transaction completion and remove the usage
of DMA rx_completion and tx_completion for identifying transaction
completion.

Tested on J721E SK (for both Master and Slave Mode) for Full Duplex,
TX Only and RX Only mode transactions.Also tested with ILI9225 based
SPI TFT Display.

Vaishnav Achath (2):
  dmaengine: ti: k3-udma: Respond TX done if DMA_PREP_INTERRUPT is not
    requested
  spi: spi-omap2-mcspi: Use EOW interrupt for completion when DMA
    enabled

 drivers/dma/ti/k3-udma.c      |   5 +-
 drivers/spi/spi-omap2-mcspi.c | 141 +++++++++-------------------------
 2 files changed, 40 insertions(+), 106 deletions(-)

-- 
2.17.1

