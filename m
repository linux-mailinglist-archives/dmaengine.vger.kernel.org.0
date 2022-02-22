Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816384BF60D
	for <lists+dmaengine@lfdr.de>; Tue, 22 Feb 2022 11:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbiBVKfk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 22 Feb 2022 05:35:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbiBVKfj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 22 Feb 2022 05:35:39 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148B015B982;
        Tue, 22 Feb 2022 02:35:13 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A87B9FF802;
        Tue, 22 Feb 2022 10:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1645526112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RRNdYi6Xz1yqhHctAJQ2hLqQsjF5keNJokZ+KOZpDMs=;
        b=FqabDjkxfVRDyaq1p5LvqJoB00lu6GJi84Sr1VmWzxONSbW8vUGgpwgJ5qiBWIxvqbuhnX
        CdVabLbWaLpD8RG0eahDr8RNdmifflp48NdXk44mnqIgZSc7OoM93dPgfPEeepkSuj9CEH
        q9ZGFC3+WuCLybm1EPp4vIDsuB980KQFm9YN9q07p8K4UVXP2u/1IMFFiKzs58dmZqB3z+
        FjGAT70kPSIGUHzKMp0Gii7MoCj0lnzQq9Djhya3YeZi+j3OstWGBh7QN9ZhmYDvNcUr+a
        Lqm4+CetYBsWY2o9xzvM9mqNubkGhrgCWpp7kPBfWkZdMK+Nq3evIFYIeiG/EA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     dmaengine@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 5/8] dma: dw: Avoid partial transfers
Date:   Tue, 22 Feb 2022 11:34:34 +0100
Message-Id: <20220222103437.194779-6-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220222103437.194779-1-miquel.raynal@bootlin.com>
References: <20220222103437.194779-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Phil Edworthy <phil.edworthy@renesas.com>

Pausing a partial transfer only causes data to be written to memory that
is a multiple of the memory width setting.

However, when a DMA client driver finishes DMA early, e.g. due to UART
char timeout interrupt, all data read from the device must be written to
memory.

Therefore, allow the slave to limit the memory width to ensure all data
read from the device is written to memory when DMA is paused.

This change only applies to the DMA_DEV_TO_MEM case.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/dma/dw/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 7ab83fe601ed..48cdefe997f1 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -705,6 +705,9 @@ dwc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 		ctllo |= sconfig->device_fc ? DWC_CTLL_FC(DW_DMA_FC_P_P2M) :
 			DWC_CTLL_FC(DW_DMA_FC_D_P2M);
 
+		if (sconfig->dst_addr_width && sconfig->dst_addr_width < data_width)
+			data_width = sconfig->dst_addr_width;
+
 		for_each_sg(sgl, sg, sg_len, i) {
 			struct dw_desc	*desc;
 			u32		len, mem;
-- 
2.27.0

