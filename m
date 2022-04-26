Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D78F510C11
	for <lists+dmaengine@lfdr.de>; Wed, 27 Apr 2022 00:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243349AbiDZWfR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 26 Apr 2022 18:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241713AbiDZWfQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 26 Apr 2022 18:35:16 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8F4C90C9
        for <dmaengine@vger.kernel.org>; Tue, 26 Apr 2022 15:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651012327; x=1682548327;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tpq+lf25/cwsIy1SnI7DQgYxijoOTCa0+vgPBpfQO88=;
  b=GZMM0D7Q18gkfZtCcQqnikPSf4MZDTTfP6l8L/8k7w85wCjaGGsUpDsV
   1m3Eq8pTdQwHJrxzb+99O8JLCXDzdDTOLzets/ADS4uKM/VHZqVW+BKhT
   3b/gl9eKWdEaf0jVSmfH8fnJ6SgMbcS+/7yxC334nOTqo/gZpY0437+jf
   3Qbn9rKyxOx3NaYejt67qb3W+qZJsyexjh2olanhk3xkACRaC72p3wsW6
   Vo+Z/54yWhy1O+JneF9E0kcCEg/F9OCRRSEmaeSMs0eTXZir9BKtm2xf2
   SPBX969MUgi/LJqhjJ4nPUza3NVKaOlU/s81czUjlXXe607Y3eFF/+rKT
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="265264644"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="265264644"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 15:32:07 -0700
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="679318450"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 15:32:06 -0700
Subject: [PATCH] dmaengine: idxd: add missing callback function to support
 DMA_INTERRUPT
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Tue, 26 Apr 2022 15:32:06 -0700
Message-ID: <165101232637.3951447.15765792791591763119.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

When setting DMA_INTERRUPT capability, a callback function
dma->device_prep_dma_interrupt() is needed to support this capability.
Without setting the callback, dma_async_device_register() will fail dma
capability check.

Fixes: 4e5a4eb20393 ("dmaengine: idxd: set DMA_INTERRUPT cap bit")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/dma.c |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/dma/idxd/dma.c b/drivers/dma/idxd/dma.c
index 950f06c8aad5..d66cef5a918e 100644
--- a/drivers/dma/idxd/dma.c
+++ b/drivers/dma/idxd/dma.c
@@ -87,6 +87,27 @@ static inline void idxd_prep_desc_common(struct idxd_wq *wq,
 	hw->completion_addr = compl;
 }
 
+static struct dma_async_tx_descriptor *
+idxd_dma_prep_interrupt(struct dma_chan *c, unsigned long flags)
+{
+	struct idxd_wq *wq = to_idxd_wq(c);
+	u32 desc_flags;
+	struct idxd_desc *desc;
+
+	if (wq->state != IDXD_WQ_ENABLED)
+		return NULL;
+
+	op_flag_setup(flags, &desc_flags);
+	desc = idxd_alloc_desc(wq, IDXD_OP_BLOCK);
+	if (IS_ERR(desc))
+		return NULL;
+
+	idxd_prep_desc_common(wq, desc->hw, DSA_OPCODE_NOOP,
+			      0, 0, 0, desc->compl_dma, desc_flags);
+	desc->txd.flags = flags;
+	return &desc->txd;
+}
+
 static struct dma_async_tx_descriptor *
 idxd_dma_submit_memcpy(struct dma_chan *c, dma_addr_t dma_dest,
 		       dma_addr_t dma_src, size_t len, unsigned long flags)
@@ -198,6 +219,7 @@ int idxd_register_dma_device(struct idxd_device *idxd)
 	dma_cap_set(DMA_COMPLETION_NO_ORDER, dma->cap_mask);
 	dma->device_release = idxd_dma_release;
 
+	dma->device_prep_dma_interrupt = idxd_dma_prep_interrupt;
 	if (idxd->hw.opcap.bits[0] & IDXD_OPCAP_MEMMOVE) {
 		dma_cap_set(DMA_MEMCPY, dma->cap_mask);
 		dma->device_prep_dma_memcpy = idxd_dma_submit_memcpy;


