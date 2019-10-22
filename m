Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D487E0DE0
	for <lists+dmaengine@lfdr.de>; Tue, 22 Oct 2019 23:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732091AbfJVVqV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 22 Oct 2019 17:46:21 -0400
Received: from ale.deltatee.com ([207.54.116.67]:33056 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731271AbfJVVqU (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 22 Oct 2019 17:46:20 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1iN1ys-00049O-Rf; Tue, 22 Oct 2019 15:46:20 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1iN1ys-000250-6w; Tue, 22 Oct 2019 15:46:18 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Tue, 22 Oct 2019 15:46:13 -0600
Message-Id: <20191022214616.7943-3-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191022214616.7943-1-logang@deltatee.com>
References: <20191022214616.7943-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org, dan.j.williams@intel.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_FREE,MYRULES_NO_TEXT autolearn=ham
        autolearn_force=no version=3.4.2
Subject: [PATCH 2/5] dmaengine: Call module_put() after device_free_chan_resources()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The module reference is taken to ensure the callbacks still exist
when they are called. If the channel holds the last reference to the
module, the module can disappear before device_free_chan_resources() is
called and would cause a call into free'd memory.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/dma/dmaengine.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 4b604086b1b3..776fdf535a3a 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -250,7 +250,6 @@ static void dma_chan_put(struct dma_chan *chan)
 		return;
 
 	chan->client_count--;
-	module_put(dma_chan_to_owner(chan));
 
 	/* This channel is not in use anymore, free it */
 	if (!chan->client_count && chan->device->device_free_chan_resources) {
@@ -259,6 +258,8 @@ static void dma_chan_put(struct dma_chan *chan)
 		chan->device->device_free_chan_resources(chan);
 	}
 
+	module_put(dma_chan_to_owner(chan));
+
 	/* If the channel is used via a DMA request router, free the mapping */
 	if (chan->router && chan->router->route_free) {
 		chan->router->route_free(chan->router->dev, chan->route_data);
-- 
2.20.1

