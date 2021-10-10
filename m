Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23711427F55
	for <lists+dmaengine@lfdr.de>; Sun, 10 Oct 2021 08:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbhJJGbd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 10 Oct 2021 02:31:33 -0400
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:43154 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbhJJGbd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 10 Oct 2021 02:31:33 -0400
Received: from pop-os.home ([90.126.248.220])
        by mwinf5d27 with ME
        id 46VX260044m3Hzu036VXqP; Sun, 10 Oct 2021 08:29:32 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 10 Oct 2021 08:29:32 +0200
X-ME-IP: 90.126.248.220
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     gustavo.pimentel@synopsys.com, vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] dmaengine: dw-edma: Remove an unused variable
Date:   Sun, 10 Oct 2021 08:29:29 +0200
Message-Id: <46e071be21fbc5ac5c35d4796a7e4249e94c3a77.1633847306.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

'head' is unused, remove it.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/dma/dw-edma/dw-edma-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 53289927dd0d..468d1097a1ec 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -249,7 +249,6 @@ static int dw_edma_device_terminate_all(struct dma_chan *dchan)
 {
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
 	int err = 0;
-	LIST_HEAD(head);
 
 	if (!chan->configured) {
 		/* Do nothing */
-- 
2.30.2

