Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E3F4BBF2B
	for <lists+dmaengine@lfdr.de>; Fri, 18 Feb 2022 19:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239023AbiBRSNA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 18 Feb 2022 13:13:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239026AbiBRSM7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 18 Feb 2022 13:12:59 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109293630E;
        Fri, 18 Feb 2022 10:12:41 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id EC4D720007;
        Fri, 18 Feb 2022 18:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1645207958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pO+KRyzg9QXvLLS1vxx5wuXMcb4+oWxgonKkd1sluA4=;
        b=Kgo34du3V2GiYduH6vpZpZRUPe8x5/MPmUYTpGwmr592Ufn1FM1TGvEsqyMvn5ETgEpNYF
        IgHIJV22opL8fGAkmxcfn3jTZpLUwHR31tGDv6tVqDgS7DUjSo9/oz9+EdCY6lKtz1nClS
        cAD+if4ba9fD+faeKJJTV7SkaRO1iE+pATDmBhWxlsPbSKe+Z7vNLmk6sEEuFBUiRuJwca
        R4NfWpZg+srzG7L3GnZmX41ZBV9mA5/NR13u+d3pHMAh3yVUM1IyYkzL0DIVs3dkVAzhga
        jYH/hDVps0lHxS1s0PpDpyt1X4cOBgKzY6GY8s0R74YYvLOMeETnjK1N/t0G4g==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Laetitia MARIOTTINI <laetitia.mariottini@se.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 5/8] dma: dw: Avoid partial transfers
Date:   Fri, 18 Feb 2022 19:12:23 +0100
Message-Id: <20220218181226.431098-6-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220218181226.431098-1-miquel.raynal@bootlin.com>
References: <20220218181226.431098-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Phil Edworthy <phil.edworthy@renesas.com>

Pausing a partial transfer only causes data to be written to mem that is
a multiple of the memory width setting.

However, when a DMA client driver finishes DMA early, e.g. due to UART
char timeout interrupt, all data read from the DEV must be written to MEM.

Therefore, allow the slave to limit the memory width to ensure all data
read from the DEV is written to MEM when DMA is paused.

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

