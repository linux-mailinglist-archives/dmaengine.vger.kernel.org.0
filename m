Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D627BC70E
	for <lists+dmaengine@lfdr.de>; Sat,  7 Oct 2023 13:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234087AbjJGLU7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 7 Oct 2023 07:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234166AbjJGLU6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 7 Oct 2023 07:20:58 -0400
X-Greylist: delayed 450 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 07 Oct 2023 04:20:57 PDT
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 892C2B9
        for <dmaengine@vger.kernel.org>; Sat,  7 Oct 2023 04:20:57 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id p5FLqUFvtkkaep5FLqw9nt; Sat, 07 Oct 2023 13:13:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1696677205;
        bh=jCnIoIQF1DC9kwrL6dXuT211TCz3UEY3JUvXyvj4/xA=;
        h=From:To:Cc:Subject:Date;
        b=Bz4ajFDCdsu6VLEUWlJxz+ijo79EHIaWdKaD8IFozP5GoVggXqYNJurHxg9jfLDrm
         Px3gKMs4reBgrw6vI2PGmDIUUEJTMEU/33Otfpt8Q8W1BsWAc8kmio886Bcr8WFN29
         0/3QG1V7ul7xji93lwONquEqbdiH+v2y7VyXAvP9+1W+o5NtIQXs/Yo+ECEpBr3lIX
         GiIMQYJ5FtVCsxRdNqzNa/BKr+6T4R/0dM8YrUbhuQRc2KF9in/qpXgLrctRJuN0MH
         zNij+/NOZS8GuDWL5wna3C6W5BTagVUXYMSa6jAPiSvBMt7kzmyEh5dmS56BUgu/rt
         Nbz/n1XTUwl3Q==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 07 Oct 2023 13:13:25 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     keescook@chromium.org, gustavoars@kernel.org,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org
Subject: [PATCH 1/2] dmaengine: pxa_dma: Remove an erroneous BUG_ON() in pxad_free_desc()
Date:   Sat,  7 Oct 2023 13:13:09 +0200
Message-Id: <c8fc5563c9593c914fde41f0f7d1489a21b45a9a.1696676782.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

If pxad_alloc_desc() fails on the first dma_pool_alloc() call, then
sw_desc->nb_desc is zero.
In such a case pxad_free_desc() is called and it will BUG_ON().

Remove this erroneous BUG_ON().

It is also useless, because if "sw_desc->nb_desc == 0", then, on the first
iteration of the for loop, i is -1 and the loop will not be executed.
(both i and sw_desc->nb_desc are 'int')

Fixes: a57e16cf0333 ("dmaengine: pxa: add pxa dmaengine driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/dma/pxa_dma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
index 3c574dc0613b..94cef2905940 100644
--- a/drivers/dma/pxa_dma.c
+++ b/drivers/dma/pxa_dma.c
@@ -722,7 +722,6 @@ static void pxad_free_desc(struct virt_dma_desc *vd)
 	dma_addr_t dma;
 	struct pxad_desc_sw *sw_desc = to_pxad_sw_desc(vd);
 
-	BUG_ON(sw_desc->nb_desc == 0);
 	for (i = sw_desc->nb_desc - 1; i >= 0; i--) {
 		if (i > 0)
 			dma = sw_desc->hw_desc[i - 1]->ddadr;
-- 
2.34.1

