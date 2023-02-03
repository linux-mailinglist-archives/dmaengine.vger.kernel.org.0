Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB15689860
	for <lists+dmaengine@lfdr.de>; Fri,  3 Feb 2023 13:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbjBCMRV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 3 Feb 2023 07:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbjBCMRU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 3 Feb 2023 07:17:20 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395EF9DEDE;
        Fri,  3 Feb 2023 04:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675426639; x=1706962639;
  h=from:to:cc:subject:date:message-id;
  bh=HDkCFge+HqbMLRAoh8YMHpbr8i9UoJQNnlQE7bkgs/E=;
  b=kBxQ5785R40kP66iMabySlwvUvAEF1F4E9dr3G90TWcfDiKfADNms5Wl
   BuLhZDaW5/2YB3K1HVUTc8pqm4YEtlLiwe75h+0tzglFN+4UcaAWhQKBa
   I5xiSIGh9fin7za/gq0gZu9n6uUchGi7PkOTHYcnF/GpaFYXqfK5k5qnO
   JPEdzh5VhgtK8aYlCT0CqKD4H1Us7fGQEUzOTbT5uD8taZU+97mmExfOH
   IbEqgt57nekgioRqz1e+muCBFYK76XBt3lTsmXRhaty+7JlhGRRAhxjoq
   mAw3p4DYxvpZv1VBxdcrkrNZ2C176cyfCpPa1sHCgGnq8dbM7o3W3YvE/
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="328749774"
X-IronPort-AV: E=Sophos;i="5.97,270,1669104000"; 
   d="scan'208";a="328749774"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 04:17:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="665701557"
X-IronPort-AV: E=Sophos;i="5.97,270,1669104000"; 
   d="scan'208";a="665701557"
Received: from uzel-8i-t02.iind.intel.com ([10.49.2.69])
  by orsmga002.jf.intel.com with ESMTP; 03 Feb 2023 04:17:16 -0800
From:   aman.kumar@intel.com
To:     vkoul@kernel.org, dmaengine@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, srikanth.thokala@intel.com,
        aman.kumar@intel.com, mallikarjunappa.sangannavar@intel.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] dmaengine: idma64: Update bytes_transferred field
Date:   Fri,  3 Feb 2023 17:47:02 +0530
Message-Id: <20230203121702.15725-1-aman.kumar@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Aman Kumar <aman.kumar@intel.com>

Currently when 8250 data transfer is done, bytes_tranferred always returns
0 at /sys/devices/pci0000\:\:**.*/dma/dma*chan*/bytes_transferred.
In many cases it gives false impression that data is not being
trasferred via DMA.

So, updating the bytes_transferred field to count the bytes
whenever there is data transfer using idma64.

Co-developed-by: Srikanth Thokala <srikanth.thokala@intel.com>
Signed-off-by: Srikanth Thokala <srikanth.thokala@intel.com>
Signed-off-by: Aman Kumar <aman.kumar@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/idma64.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/idma64.c b/drivers/dma/idma64.c
index c33087c5cd02..8880d2b91bf5 100644
--- a/drivers/dma/idma64.c
+++ b/drivers/dma/idma64.c
@@ -137,8 +137,11 @@ static void idma64_chan_irq(struct idma64 *idma64, unsigned short c,
 		u32 status_err, u32 status_xfer)
 {
 	struct idma64_chan *idma64c = &idma64->chan[c];
+	struct dma_chan_percpu *stat;
 	struct idma64_desc *desc;
 
+	stat = this_cpu_ptr(idma64c->vchan.chan.local);
+
 	spin_lock(&idma64c->vchan.lock);
 	desc = idma64c->desc;
 	if (desc) {
@@ -149,6 +152,7 @@ static void idma64_chan_irq(struct idma64 *idma64, unsigned short c,
 			dma_writel(idma64, CLEAR(XFER), idma64c->mask);
 			desc->status = DMA_COMPLETE;
 			vchan_cookie_complete(&desc->vdesc);
+			stat->bytes_transferred += desc->length;
 			idma64_start_transfer(idma64c);
 		}
 
-- 
2.17.1

