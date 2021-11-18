Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE1145637E
	for <lists+dmaengine@lfdr.de>; Thu, 18 Nov 2021 20:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbhKRTbH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 18 Nov 2021 14:31:07 -0500
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:51961 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbhKRTbG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 18 Nov 2021 14:31:06 -0500
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id nn4lmyHdmMxZunn4mmeLiM; Thu, 18 Nov 2021 20:28:04 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Thu, 18 Nov 2021 20:28:04 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     peter.ujfalusi@gmail.com, vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] dmaengine: ti: edma: Use 'for_each_set_bit' when possible
Date:   Thu, 18 Nov 2021 20:28:02 +0100
Message-Id: <47a7415d3aff8dfb66780bd6f80b085db4503bf7.1637263609.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Use 'for_each_set_bit()' instead of hand wrinting it. It is much less
version.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/dma/ti/edma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index caa4050ecc02..08e47f44d325 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -1681,8 +1681,7 @@ static irqreturn_t dma_ccerr_handler(int irq, void *data)
 
 			dev_dbg(ecc->dev, "EMR%d 0x%08x\n", j, val);
 			emr = val;
-			for (i = find_first_bit(&emr, 32); i < 32;
-			     i = find_next_bit(&emr, 32, i + 1)) {
+			for_each_set_bit(i, &emr, 32) {
 				int k = (j << 5) + i;
 
 				/* Clear the corresponding EMR bits */
-- 
2.30.2

