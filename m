Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8F0680B96
	for <lists+dmaengine@lfdr.de>; Mon, 30 Jan 2023 12:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236274AbjA3LF5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 30 Jan 2023 06:05:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236472AbjA3LFY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 30 Jan 2023 06:05:24 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EF016ACA;
        Mon, 30 Jan 2023 03:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675076670; x=1706612670;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0h0zHmH8o9/zwwr3cv/ujF3OJpLPSvSFjp9kwMeCR9I=;
  b=dIZE/58+h9mA7eJs0+XQ5irLrX1U2fkotiRNsdLvcTlx3z5v/HGaj+gU
   LdzRhb0DNLZdvNBy3RF9boPFQGP2GC966ad4OayWXy/i7BunEsS3dzJIE
   kyZ/arO0H8+/wRgVcA9wXp19ZLocZckwEj3s3f61D9E4GkRLrqmHnsoIS
   PcOcxMFTnxgbV7VOh6i8UR235hguWnhXKheE75Z95znw4nTYcjzRfI4dl
   XUSnjDWvcY03PMLZNuyd4K1zmAEFOY11OSKPUgq02o5UiB2dTliGFZibw
   POFFJWKobCwMeu/01XLRNW8TxhD2rAxqB5AKrPz+GUhs8ZFdb2ObPK/US
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="325228095"
X-IronPort-AV: E=Sophos;i="5.97,257,1669104000"; 
   d="scan'208";a="325228095"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 03:04:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="727461051"
X-IronPort-AV: E=Sophos;i="5.97,257,1669104000"; 
   d="scan'208";a="727461051"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 30 Jan 2023 03:04:28 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D1EF7337; Mon, 30 Jan 2023 13:05:05 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] dmaengine: Make an order in struct dma_device definition
Date:   Mon, 30 Jan 2023 13:05:03 +0200
Message-Id: <20230130110503.52250-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Make an order in struct dma_device:
- added missing kernel doc descriptions
- put descriptions in the order of appearance in the code
- updated indentation where it makes sense

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/dmaengine.h | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 0c020682d894..c3656e590213 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -773,6 +773,7 @@ struct dma_filter {
 
 /**
  * struct dma_device - info on the entity supplying DMA services
+ * @ref: reference is taken and put every time a channel is allocated or freed
  * @chancnt: how many DMA channels are supported
  * @privatecnt: how many DMA channels are requested by dma_request_channel
  * @channels: the list of struct dma_chan
@@ -789,6 +790,7 @@ struct dma_filter {
  * @dev_id: unique device ID
  * @dev: struct device reference for dma mapping api
  * @owner: owner module (automatically set based on the provided dev)
+ * @chan_ida: unique channel ID
  * @src_addr_widths: bit mask of src addr widths the device supports
  *	Width is specified in bytes, e.g. for a device supporting
  *	a width of 4 the mask should have BIT(4) set.
@@ -802,6 +804,7 @@ struct dma_filter {
  * @max_sg_burst: max number of SG list entries executed in a single burst
  *	DMA tansaction with no software intervention for reinitialization.
  *	Zero value means unlimited number of entries.
+ * @descriptor_reuse: a submitted transfer can be resubmitted after completion
  * @residue_granularity: granularity of the transfer residue reported
  *	by tx_status
  * @device_alloc_chan_resources: allocate resources and return the
@@ -839,7 +842,6 @@ struct dma_filter {
  *	struct with auxiliary transfer status information, otherwise the call
  *	will just return a simple status code
  * @device_issue_pending: push pending transactions to hardware
- * @descriptor_reuse: a submitted transfer can be resubmitted after completion
  * @device_release: called sometime atfer dma_async_device_unregister() is
  *     called and there are no further references to this structure. This
  *     must be implemented to free resources however many existing drivers
@@ -847,6 +849,7 @@ struct dma_filter {
  * @dbg_summary_show: optional routine to show contents in debugfs; default code
  *     will be used when this is omitted, but custom code can show extra,
  *     controller specific information.
+ * @dbg_dev_root: the root folder in debugfs for this device
  */
 struct dma_device {
 	struct kref ref;
@@ -855,7 +858,7 @@ struct dma_device {
 	struct list_head channels;
 	struct list_head global_node;
 	struct dma_filter filter;
-	dma_cap_mask_t  cap_mask;
+	dma_cap_mask_t cap_mask;
 	enum dma_desc_metadata_mode desc_metadata_modes;
 	unsigned short max_xor;
 	unsigned short max_pq;
@@ -924,10 +927,8 @@ struct dma_device {
 		struct dma_chan *chan, dma_addr_t dst, u64 data,
 		unsigned long flags);
 
-	void (*device_caps)(struct dma_chan *chan,
-			    struct dma_slave_caps *caps);
-	int (*device_config)(struct dma_chan *chan,
-			     struct dma_slave_config *config);
+	void (*device_caps)(struct dma_chan *chan, struct dma_slave_caps *caps);
+	int (*device_config)(struct dma_chan *chan, struct dma_slave_config *config);
 	int (*device_pause)(struct dma_chan *chan);
 	int (*device_resume)(struct dma_chan *chan);
 	int (*device_terminate_all)(struct dma_chan *chan);
-- 
2.39.0

