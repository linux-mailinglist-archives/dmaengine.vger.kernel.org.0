Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C862FA791
	for <lists+dmaengine@lfdr.de>; Mon, 18 Jan 2021 18:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406999AbhARRaK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 18 Jan 2021 12:30:10 -0500
Received: from mga06.intel.com ([134.134.136.31]:11696 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406875AbhARR31 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 18 Jan 2021 12:29:27 -0500
IronPort-SDR: xK8wIbvizMjVtwK7u0LRyzLF3GuTK+IfRb5VlMUV57WlohTPdubfUXBvHhNSE3KHBG/iHFFOGJ
 veRxSrBo/0LQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9868"; a="240371394"
X-IronPort-AV: E=Sophos;i="5.79,356,1602572400"; 
   d="scan'208";a="240371394"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 09:28:45 -0800
IronPort-SDR: 3uftMfIwn7WvMnEaOiif2VxsUi1ADIx+y+4e/B3EigqBhp/IaN3W5k1DZx5PStLSS/PUHMbswt
 9XH4D72AB8ow==
X-IronPort-AV: E=Sophos;i="5.79,356,1602572400"; 
   d="scan'208";a="355257674"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 09:28:45 -0800
Subject: [PATCH] dmaengine: move channel device_node deletion to driver
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, radheys@xilinx.com,
        pthomas8589@gmail.com
Date:   Mon, 18 Jan 2021 10:28:44 -0700
Message-ID: <161099092469.2495902.5064826526660062342.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Channel device_node deletion is managed by the device driver rather than
the dmaengine core. The deletion was accidentally introduced when making
channel unregister dynamic. It causes xilinx_dma module to crash on unload
as reported by Radhey. Remove chan->device_node delete in dmaengine and
also fix up idxd driver.

[   42.142705] Internal error: Oops: 96000044 [#1] SMP
[   42.147566] Modules linked in: xilinx_dma(-) clk_xlnx_clock_wizard uio_pdrv_genirq
[   42.155139] CPU: 1 PID: 2075 Comm: rmmod Not tainted 5.10.1-00026-g3a2e6dd7a05-dirty #192
[   42.163302] Hardware name: Enclustra XU5 SOM (DT)
[   42.167992] pstate: 40000005 (nZcv daif -PAN -UAO -TCO BTYPE=--)
[   42.173996] pc : xilinx_dma_chan_remove+0x74/0xa0 [xilinx_dma]
[   42.179815] lr : xilinx_dma_chan_remove+0x70/0xa0 [xilinx_dma]
[   42.185636] sp : ffffffc01112bca0
[   42.188935] x29: ffffffc01112bca0 x28: ffffff80402ea640

xilinx_dma_chan_remove+0x74/0xa0:
__list_del at ./include/linux/list.h:112 (inlined by)
__list_del_entry at./include/linux/list.h:135 (inlined by)
list_del at ./include/linux/list.h:146 (inlined by)
xilinx_dma_chan_remove at drivers/dma/xilinx/xilinx_dma.c:2546

Reported-by: Radhey Shyam Pandey <radheys@xilinx.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Fixes: e81274cd6b52 ("dmaengine: add support to dynamic register/unregister of channels")
---
 drivers/dma/dmaengine.c |    1 -
 drivers/dma/idxd/dma.c  |    5 ++++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 962cbb5e5f7f..fe6a460c4373 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -1110,7 +1110,6 @@ static void __dma_async_device_channel_unregister(struct dma_device *device,
 		  "%s called while %d clients hold a reference\n",
 		  __func__, chan->client_count);
 	mutex_lock(&dma_list_mutex);
-	list_del(&chan->device_node);
 	device->chancnt--;
 	chan->dev->chan = NULL;
 	mutex_unlock(&dma_list_mutex);
diff --git a/drivers/dma/idxd/dma.c b/drivers/dma/idxd/dma.c
index 90d19d06783a..a15e50126434 100644
--- a/drivers/dma/idxd/dma.c
+++ b/drivers/dma/idxd/dma.c
@@ -206,5 +206,8 @@ int idxd_register_dma_channel(struct idxd_wq *wq)
 
 void idxd_unregister_dma_channel(struct idxd_wq *wq)
 {
-	dma_async_device_channel_unregister(&wq->idxd->dma_dev, &wq->dma_chan);
+	struct dma_chan *chan = &wq->dma_chan;
+
+	dma_async_device_channel_unregister(&wq->idxd->dma_dev, chan);
+	list_del(&chan->device_node);
 }


