Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8237C773078
	for <lists+dmaengine@lfdr.de>; Mon,  7 Aug 2023 22:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjHGUiU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Aug 2023 16:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjHGUiJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 7 Aug 2023 16:38:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BCFE62;
        Mon,  7 Aug 2023 13:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691440688; x=1722976688;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XDP/Lzh/PA2NjJl2oSljk0y1i7dKPRi9KQWpDqSxAlk=;
  b=fy3Udp6IXulHTuFsDYNX6kXJkYtNpZgGpVR1C89q/HQh5KBj+jsXaDib
   40JQMYsI9jKam7VwAeOMJ7uA7FuXT3fjnqqx4v0/NOhjBpb9M8jDU9DBe
   kVnTy8z9jJ3R2aD7DiCrOp3P2iXtza23oxLh/ycIQ4zMrUSy0yElOEsSt
   CCWQzobZdKiEuyoLc+pVJxpsYzSEvrhmvba59SIptrsxGjfRJn1KhBpbv
   oTd3vEQKx2dD0HW+Qnh5+v80LAIivvrKibA7bwk28v1+Q68YaKyF9wtsm
   lm6kCP/NNwCiFT2r+AuBY9joX8jLnHk3iRZLzrQe7PEx/c0GnwF0cvdB9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="374319685"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="374319685"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 13:37:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="766123350"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="766123350"
Received: from eeroesle-mobl.amr.corp.intel.com (HELO tzanussi-mobl1.intel.com) ([10.212.81.193])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 13:37:46 -0700
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        fenghua.yu@intel.com, vkoul@kernel.org
Cc:     dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, vinodh.gopal@intel.com,
        giovanni.cabiddu@intel.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
Subject: [PATCH v9 06/14] dmaengine: idxd: Add wq private data accessors
Date:   Mon,  7 Aug 2023 15:37:18 -0500
Message-Id: <20230807203726.1682123-7-tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807203726.1682123-1-tom.zanussi@linux.intel.com>
References: <20230807203726.1682123-1-tom.zanussi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add the accessors idxd_wq_set_private() and idxd_wq_get_private()
allowing users to set and retrieve a private void * associated with an
idxd_wq.

The private data is stored in the idxd_dev.conf_dev associated with
each idxd_wq.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/idxd/idxd.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index f58df2cd9cf5..0c7974383c71 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -609,6 +609,16 @@ static inline int idxd_wq_refcount(struct idxd_wq *wq)
 	return wq->client_count;
 };
 
+static inline void idxd_wq_set_private(struct idxd_wq *wq, void *private)
+{
+	dev_set_drvdata(wq_confdev(wq), private);
+}
+
+static inline void *idxd_wq_get_private(struct idxd_wq *wq)
+{
+	return dev_get_drvdata(wq_confdev(wq));
+}
+
 /*
  * Intel IAA does not support batch processing.
  * The max batch size of device, max batch size of wq and
-- 
2.34.1

