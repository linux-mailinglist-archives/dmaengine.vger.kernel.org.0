Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED7992A4F13
	for <lists+dmaengine@lfdr.de>; Tue,  3 Nov 2020 19:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbgKCSjn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 Nov 2020 13:39:43 -0500
Received: from mga02.intel.com ([134.134.136.20]:57364 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729345AbgKCSjn (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 3 Nov 2020 13:39:43 -0500
IronPort-SDR: vf5oqmu6AYiIjOlC5Jwyu8LNtMVo5FY13C7BHqnfQ3mw0mhpErKYRv6JugZlcle5akjEKDDEpM
 uyNKNcARjKkA==
X-IronPort-AV: E=McAfee;i="6000,8403,9794"; a="156093470"
X-IronPort-AV: E=Sophos;i="5.77,448,1596524400"; 
   d="scan'208";a="156093470"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 10:39:42 -0800
IronPort-SDR: kW4VHpB8EENvxwCMRdcrQ6fqtyP3/iCWSl/fQne2OEDMr6+dcv9xUt6iRZqoxFnqoimWGfSNkd
 Jb0s1GxrKAEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,448,1596524400"; 
   d="scan'208";a="527260724"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 03 Nov 2020 10:39:40 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0DDDB76; Tue,  3 Nov 2020 20:39:39 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Viresh Kumar <vireshk@kernel.org>, dmaengine@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] dmaengine: dw: Enable runtime PM
Date:   Tue,  3 Nov 2020 20:39:38 +0200
Message-Id: <20201103183938.64752-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

When consumer requests channel power on the DMA controller device
and otherwise on the freeing channel resources.

Note, in some cases consumer acquires channel at the ->probe() stage and
releases it at the ->remove() stage. It will mean that DMA controller device
will be powered during all this time if there is no assist from hardware
to idle it. The above mentioned cases should be investigated separately
and individually.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/dw/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 7ab83fe601ed..19a23767533a 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -982,8 +982,11 @@ static int dwc_alloc_chan_resources(struct dma_chan *chan)
 
 	dev_vdbg(chan2dev(chan), "%s\n", __func__);
 
+	pm_runtime_get_sync(dw->dma.dev);
+
 	/* ASSERT:  channel is idle */
 	if (dma_readl(dw, CH_EN) & dwc->mask) {
+		pm_runtime_put_sync_suspend(dw->dma.dev);
 		dev_dbg(chan2dev(chan), "DMA channel not idle?\n");
 		return -EIO;
 	}
@@ -1000,6 +1003,7 @@ static int dwc_alloc_chan_resources(struct dma_chan *chan)
 	 * We need controller-specific data to set up slave transfers.
 	 */
 	if (chan->private && !dw_dma_filter(chan, chan->private)) {
+		pm_runtime_put_sync_suspend(dw->dma.dev);
 		dev_warn(chan2dev(chan), "Wrong controller-specific data\n");
 		return -EINVAL;
 	}
@@ -1043,6 +1047,8 @@ static void dwc_free_chan_resources(struct dma_chan *chan)
 	if (!dw->in_use)
 		do_dw_dma_off(dw);
 
+	pm_runtime_put_sync_suspend(dw->dma.dev);
+
 	dev_vdbg(chan2dev(chan), "%s: done\n", __func__);
 }
 
-- 
2.28.0

