Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3A684383D4
	for <lists+dmaengine@lfdr.de>; Sat, 23 Oct 2021 15:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbhJWNnx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 23 Oct 2021 09:43:53 -0400
Received: from www381.your-server.de ([78.46.137.84]:35292 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbhJWNnw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 23 Oct 2021 09:43:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References;
        bh=d+hgxX4jJYF26CkNDNNduedpUDzvtOT9wysZnWWk5Zo=; b=C0wqXdT39shFYJU60M26cL7jfL
        GmhFl3X5bxGiTO6F3sBDy3PQkzQFLNtYBAdITro1V/+XbU7cqtsUiGG64wbw9oGErCjKIiCF+Oelh
        4JGELNNj2oR+uE7onUxJ8Ajqk2GFm1Q84mm/XqeTEvwpzBr9GssqrVfuuXS93X22QqKrJGyLncqoV
        3o4zCewcJ5olvi0YrB/jg2ku+J2tevRpjtgAsO2XpC4WobOLVQ9HUUVkkBkqxrO6pcvkGNmBXRtU2
        nwKO3xFnygePuCTZBU1VYX9WDLNiUHEX9QGNfeqD9FEXEnok/Do8PtEhY5l8nBB1DVKuslRsTb+wg
        E2quCwyg==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1meHH9-000F1u-Rn; Sat, 23 Oct 2021 15:41:31 +0200
Received: from [82.135.83.71] (helo=lars-desktop.fritz.box)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1meHH9-000R8x-MH; Sat, 23 Oct 2021 15:41:31 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Dave Jiang <dave.jiang@intel.com>, dmaengine@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] dmaengine: dmaengine_desc_callback_valid(): Check for `callback_result`
Date:   Sat, 23 Oct 2021 15:41:01 +0200
Message-Id: <20211023134101.28042-1-lars@metafoo.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26331/Sat Oct 23 10:18:59 2021)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Before the `callback_result` callback was introduced drivers coded their
invocation to the callback in a similar way to:

	if (cb->callback) {
		spin_unlock(&dma->lock);
		cb->callback(cb->callback_param);
		spin_lock(&dma->lock);
	}

With the introduction of `callback_result` two helpers where introduced to
transparently handle both types of callbacks. And drivers where updated to
look like this:

	if (dmaengine_desc_callback_valid(cb)) {
		spin_unlock(&dma->lock);
		dmaengine_desc_callback_invoke(cb, ...);
		spin_lock(&dma->lock);
	}

dmaengine_desc_callback_invoke() correctly handles both `callback_result`
and `callback`. But we forgot to update the dmaengine_desc_callback_valid()
function to check for `callback_result`. As a result DMA descriptors that
use the `callback_result` rather than `callback` don't have their callback
invoked by drivers that follow the pattern above.

Fix this by checking for both `callback` and `callback_result` in
dmaengine_desc_callback_valid().

Fixes: f067025bc676 ("dmaengine: add support to provide error result from a DMA transation")
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/dma/dmaengine.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/dmaengine.h b/drivers/dma/dmaengine.h
index 1bfbd64b1371..53f16d3f0029 100644
--- a/drivers/dma/dmaengine.h
+++ b/drivers/dma/dmaengine.h
@@ -176,7 +176,7 @@ dmaengine_desc_get_callback_invoke(struct dma_async_tx_descriptor *tx,
 static inline bool
 dmaengine_desc_callback_valid(struct dmaengine_desc_callback *cb)
 {
-	return (cb->callback) ? true : false;
+	return cb->callback || cb->callback_result;
 }
 
 struct dma_chan *dma_get_slave_channel(struct dma_chan *chan);
-- 
2.20.1

