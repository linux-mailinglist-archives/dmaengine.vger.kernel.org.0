Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6815C43909E
	for <lists+dmaengine@lfdr.de>; Mon, 25 Oct 2021 09:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbhJYH53 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Oct 2021 03:57:29 -0400
Received: from www381.your-server.de ([78.46.137.84]:60304 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbhJYH53 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 25 Oct 2021 03:57:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References;
        bh=u1OewFAutiuId7aMDyslvsL/AcE/PBcZ1CnWQYFZRso=; b=SBaLcr+4HRDmee7RQb9ZNwIHge
        pCt12qmZK3c3ObQMd4e4qIPKIVeujyaK/WfURdWM80Tinq+OF47XA3eqbGT3KP2aRqyxyBh+CCOZv
        znaRcfSVuYtVne0ngDMX0a+AN9OoUlbuY3X9cLIFZweC9HVapGMwOTfweB2iEDYg0wCZ0kd9XkPIy
        b5OoNwHan2O8LjXfmOaM8MKRgRE8zHUd7U8tVXeHvfVXsIJ/MTWI2dJ7nutOwI8I2N1q3f7SoHzY4
        DRcBxVA+LrEo725SGu+VJMkoAnmGPiIa0V8H6rrq7K9Pbzmlp7O2TsKfjUmhNeWUGdzHzWjpJ925B
        L+jWvICQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1meuoz-000AAW-Ss; Mon, 25 Oct 2021 09:55:05 +0200
Received: from [82.135.83.71] (helo=lars-desktop.fritz.box)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1meuoz-000TdK-F3; Mon, 25 Oct 2021 09:55:05 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Stefan Roese <sr@denx.de>, Michal Simek <michal.simek@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
        dmaengine@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/3] dmaengine: altera-msgdma: Correctly handle descriptor callbacks
Date:   Mon, 25 Oct 2021 09:54:26 +0200
Message-Id: <20211025075428.2094-1-lars@metafoo.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26332/Sun Oct 24 10:18:48 2021)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

DMA clients can provide one of two types of callbacks. For this reason
dmaengine drivers should not directly invoke `callback`, but always use
dmaengine_desc_callback_invoke(). This makes sure that both types of
callbacks are handled correctly.

The altera-msgdma driver currently doesn't do this and only handles the
`callback` type callback. If the client used the `callback_result` type
callback it will not be called.

Fix this by switching to `dmaengine_desc_callback_valid()` and
`dmaengine_desc_callback_invoke()`.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/dma/altera-msgdma.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/altera-msgdma.c b/drivers/dma/altera-msgdma.c
index 5a2c7573b692..f5b885d69cd3 100644
--- a/drivers/dma/altera-msgdma.c
+++ b/drivers/dma/altera-msgdma.c
@@ -585,16 +585,14 @@ static void msgdma_chan_desc_cleanup(struct msgdma_device *mdev)
 	struct msgdma_sw_desc *desc, *next;
 
 	list_for_each_entry_safe(desc, next, &mdev->done_list, node) {
-		dma_async_tx_callback callback;
-		void *callback_param;
+		struct dmaengine_desc_callback cb;
 
 		list_del(&desc->node);
 
-		callback = desc->async_tx.callback;
-		callback_param = desc->async_tx.callback_param;
-		if (callback) {
+		dmaengine_desc_get_callback(&desc->async_tx, &cb);
+		if (dmaengine_desc_callback_valid(&cb)) {
 			spin_unlock(&mdev->lock);
-			callback(callback_param);
+			dmaengine_desc_callback_invoke(&cb, NULL);
 			spin_lock(&mdev->lock);
 		}
 
-- 
2.20.1

