Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF27674DDC8
	for <lists+dmaengine@lfdr.de>; Mon, 10 Jul 2023 21:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjGJTHO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 10 Jul 2023 15:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbjGJTHG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 10 Jul 2023 15:07:06 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9885A9D;
        Mon, 10 Jul 2023 12:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689016025; x=1720552025;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bcf35D7IfQE8V0L8poAmnD7F4eeWOCF5TiyphB5oags=;
  b=g/AZVmF3d/AnS2zL9+RS9x2TWJR8Xy0bOTRjGh8HB4lmER/UWGmdpMyr
   w0x2Nli3/HdOjH/Nw1tptrA7fSu8olgIjYokotOuaby+fAXkyECuJ1fX6
   hXkMv7tPvcd9o6SSl4hss2LH5usGriTY8/jjY+1tyoE17UrSiNTy9M60T
   lcmMbnBlZ0ua3IHzFPi4zOIpGRC2IDHlxnnIbkTd3LSJpvEzEAgDPOw6i
   8/HH9fRSu1bfr6PwWDIb9YBQdeC/Fxdq/VuDry38m60wKPg3l8sSicE9M
   Cn4NfW53xmtji/vjNgug7vNuBOS8E3oRIVISiNUtihs2e5MEiXU+SQ6Pa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="354290752"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="354290752"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 12:07:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="844991014"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="844991014"
Received: from jdmillsx-mobl1.amr.corp.intel.com (HELO tzanussi-mobl1.intel.com) ([10.212.107.12])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 12:07:03 -0700
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        fenghua.yu@intel.com, vkoul@kernel.org
Cc:     dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, vinodh.gopal@intel.com,
        giovanni.cabiddu@intel.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
Subject: [PATCH v7 03/14] dmaengine: idxd: Export drv_enable/disable and related functions
Date:   Mon, 10 Jul 2023 14:06:43 -0500
Message-Id: <20230710190654.299639-4-tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230710190654.299639-1-tom.zanussi@linux.intel.com>
References: <20230710190654.299639-1-tom.zanussi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

To allow idxd sub-drivers to enable and disable wqs, export them.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
---
 drivers/dma/idxd/device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 5abbcc61c528..87ad95fa3f98 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -1505,6 +1505,7 @@ int drv_enable_wq(struct idxd_wq *wq)
 err:
 	return rc;
 }
+EXPORT_SYMBOL_NS_GPL(drv_enable_wq, IDXD);
 
 void drv_disable_wq(struct idxd_wq *wq)
 {
@@ -1526,6 +1527,7 @@ void drv_disable_wq(struct idxd_wq *wq)
 	wq->type = IDXD_WQT_NONE;
 	wq->client_count = 0;
 }
+EXPORT_SYMBOL_NS_GPL(drv_disable_wq, IDXD);
 
 int idxd_device_drv_probe(struct idxd_dev *idxd_dev)
 {
-- 
2.34.1

