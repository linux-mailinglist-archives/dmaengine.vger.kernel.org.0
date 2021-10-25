Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC6B4390A0
	for <lists+dmaengine@lfdr.de>; Mon, 25 Oct 2021 09:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhJYH5a (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Oct 2021 03:57:30 -0400
Received: from www381.your-server.de ([78.46.137.84]:60352 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbhJYH5a (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 25 Oct 2021 03:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=7m8Y+ZYuMiBlsCVYLHf1KYkymvw2bBRXh6KjWHXt4Ro=; b=F0eBgwkIoI401V+/Wfd3ft10Dn
        Knyv6QT7ZewWc6I+8+GzKLpIcqquWI8VB4Sj+UFFiIvX4E7DbZgas4Z/hqQXV3rP3y7NdCWU/1fsU
        RIuxQJd6p03myY5ex7picT84+eDT1dStnAA6jqLN4KC6RVjd5/Jeg6bRtj/MwOg76zI6WFy4MZ2qZ
        LAWwGPG+PTKqKCsTmn7k4eRk1mxWM1mvJk9VxJu+CoNqYBF06EiIHSzxRklnDOulqyBm4WHENb4XG
        fW7ii655809bdOgUSCbG34m1yDVKqrxIChBF+9iznOe8r765Mrda1UZ1p1taOCjIFLt80DxE8IR6z
        9eNdrhBQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1meup1-000AAo-BL; Mon, 25 Oct 2021 09:55:07 +0200
Received: from [82.135.83.71] (helo=lars-desktop.fritz.box)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1meup0-000TdK-OO; Mon, 25 Oct 2021 09:55:06 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Stefan Roese <sr@denx.de>, Michal Simek <michal.simek@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
        dmaengine@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/3] dmaengine: zynqmp_dma: Correctly handle descriptor callbacks
Date:   Mon, 25 Oct 2021 09:54:28 +0200
Message-Id: <20211025075428.2094-3-lars@metafoo.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211025075428.2094-1-lars@metafoo.de>
References: <20211025075428.2094-1-lars@metafoo.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26332/Sun Oct 24 10:18:48 2021)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

DMA clients can provide one of two types of callbacks. For this reason
dmaengine drivers should not directly invoke `callback`, but always use
`dmaengine_desc_callback_invoke()`. This makes sure that both types of
callbacks are handled correctly.

The zynqmp_dma driver currently doesn't do this and only handles the
`callback` type callback. If the client used the `callback_result` type
callback it will not be called.

Fix this by switching to `dmaengine_desc_callback_valid()` and
`dmaengine_desc_callback_invoke()`.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/dma/xilinx/zynqmp_dma.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
index 54adac6391ef..7aa63b652027 100644
--- a/drivers/dma/xilinx/zynqmp_dma.c
+++ b/drivers/dma/xilinx/zynqmp_dma.c
@@ -605,14 +605,12 @@ static void zynqmp_dma_chan_desc_cleanup(struct zynqmp_dma_chan *chan)
 	spin_lock_irqsave(&chan->lock, irqflags);
 
 	list_for_each_entry_safe(desc, next, &chan->done_list, node) {
-		dma_async_tx_callback callback;
-		void *callback_param;
+		struct dmaengine_desc_callback cb;
 
-		callback = desc->async_tx.callback;
-		callback_param = desc->async_tx.callback_param;
-		if (callback) {
+		dmaengine_desc_get_callback(&desc->async_tx, &cb);
+		if (dmaengine_desc_callback_valid(&cb)) {
 			spin_unlock_irqrestore(&chan->lock, irqflags);
-			callback(callback_param);
+			dmaengine_desc_callback_invoke(&cb, NULL);
 			spin_lock_irqsave(&chan->lock, irqflags);
 		}
 
-- 
2.20.1

