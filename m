Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430436B8440
	for <lists+dmaengine@lfdr.de>; Mon, 13 Mar 2023 22:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjCMVwm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Mar 2023 17:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjCMVwl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Mar 2023 17:52:41 -0400
Received: from smtp.smtpout.orange.fr (smtp-13.smtpout.orange.fr [80.12.242.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A62898F0
        for <dmaengine@vger.kernel.org>; Mon, 13 Mar 2023 14:52:39 -0700 (PDT)
Received: from localhost.localdomain ([185.117.37.92])
        by smtp.orange.fr with ESMTPA
        id bq5ppwjxtFvkEbq5pp0ucl; Mon, 13 Mar 2023 22:52:37 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 13 Mar 2023 22:52:37 +0100
X-ME-IP: 185.117.37.92
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     vkoul@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] dmaengine: imx-dma: Remove a redundant memset() call
Date:   Mon, 13 Mar 2023 22:52:31 +0100
Message-Id: <95a81d623bffde2e5d14e22fad7e8c9a9a7203f6.1678743528.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The desc->desc structure is already zeroed when 'desc' is kzalloc()'ed.
There is no need to clear it twice.

Remove the redundant memset().

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/dma/imx-dma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/imx-dma.c b/drivers/dma/imx-dma.c
index 3bffe3ecbd1b..ee864128334a 100644
--- a/drivers/dma/imx-dma.c
+++ b/drivers/dma/imx-dma.c
@@ -750,7 +750,6 @@ static int imxdma_alloc_chan_resources(struct dma_chan *chan)
 		desc = kzalloc(sizeof(*desc), GFP_KERNEL);
 		if (!desc)
 			break;
-		memset(&desc->desc, 0, sizeof(struct dma_async_tx_descriptor));
 		dma_async_tx_descriptor_init(&desc->desc, chan);
 		desc->desc.tx_submit = imxdma_tx_submit;
 		/* txd.flags will be overwritten in prep funcs */
-- 
2.32.0

