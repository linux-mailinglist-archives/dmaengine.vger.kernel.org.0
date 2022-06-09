Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C217544E7E
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jun 2022 16:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236881AbiFIOPC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 9 Jun 2022 10:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232769AbiFIOPB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 9 Jun 2022 10:15:01 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D2970900
        for <dmaengine@vger.kernel.org>; Thu,  9 Jun 2022 07:14:59 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 02422C0006;
        Thu,  9 Jun 2022 14:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1654784098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qU4oagj4tmBBbz/bXVPLwpPMYm3wl3oHGQ/HFAFCC5Y=;
        b=EGZd6e6Fs515CU8ZS4Sy+XqXDCeDiRqd4feWmuVhO6vQTXKnvZ4zdBtFJrXUJev61USXdN
        t1ai5aHYGNiVoIoatXn4MhFONyKrFSPShREyFUh38f5PTGO6pjutoX1Cl4qVZT5EqZOpBQ
        4OxfjjHLShaMtcDVSlNNQEhpUki1ks2MTcocMua2Iha7iyN5RIfjdaorg4RegKdG/V41Ck
        15gDQOAnVT47HBF/lnfI2n0rZxGIyufEN9iMGQOehh8kRQ8bahuyuY8g4PbmTeL5Vsibmu
        c+hzxj2/AUigwAC2wxn/eahMh9/EEkaRj1xZ0b1lZFH0LskoxWeuDqdx0cSJag==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Cc:     Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        ilpo.jarvinen@linux.intel.com,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v3 2/2] dmaengine: dw: dmamux: Fix build without CONFIG_OF
Date:   Thu,  9 Jun 2022 16:14:55 +0200
Message-Id: <20220609141455.300879-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220609141455.300879-1-miquel.raynal@bootlin.com>
References: <20220609141455.300879-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

When built without OF support, of_match_node() expands to NULL, which
produces the following output:
>> drivers/dma/dw/rzn1-dmamux.c:105:34: warning: unused variable 'rzn1_dmac_match' [-Wunused-const-variable]
   static const struct of_device_id rzn1_dmac_match[] = {

One way to silence the warning is to enclose the structure definition
with an #ifdef CONFIG_OF/#endif block.

Fixes: 134d9c52fca2 ("dmaengine: dw: dmamux: Introduce RZN1 DMA router support")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---

Changes in v3:
* Did not extend the change to the second match table as requested by Andy.
* Added a Fixes tag.

Changes in v2:
* Used the #ifdef solution rather than the __maybe_unused keyword.

 drivers/dma/dw/rzn1-dmamux.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/dw/rzn1-dmamux.c b/drivers/dma/dw/rzn1-dmamux.c
index 0ce4fb58185e..f9912c3dd4d7 100644
--- a/drivers/dma/dw/rzn1-dmamux.c
+++ b/drivers/dma/dw/rzn1-dmamux.c
@@ -102,10 +102,12 @@ static void *rzn1_dmamux_route_allocate(struct of_phandle_args *dma_spec,
 	return ERR_PTR(ret);
 }
 
+#ifdef CONFIG_OF
 static const struct of_device_id rzn1_dmac_match[] = {
 	{ .compatible = "renesas,rzn1-dma" },
 	{}
 };
+#endif
 
 static int rzn1_dmamux_probe(struct platform_device *pdev)
 {
-- 
2.34.1

