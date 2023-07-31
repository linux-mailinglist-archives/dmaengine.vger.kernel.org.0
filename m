Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008F176A2B6
	for <lists+dmaengine@lfdr.de>; Mon, 31 Jul 2023 23:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbjGaVaa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Jul 2023 17:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjGaVaT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Jul 2023 17:30:19 -0400
Received: from mgamail.intel.com (unknown [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B32E1FD7;
        Mon, 31 Jul 2023 14:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690838999; x=1722374999;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u0UMBVW3l+F9e5mDgg+KhXAyOX8BUkUD7y/i3+dhuQw=;
  b=US5x1UXOJ8snKSStvSkjxnG44Fk2cBhpB0ytAXW/szuGMsjBX+lWVeeB
   1B4PCl7ez4tj693LQkZbILPh7ctwoJc4BhX05FWDZtVMRtoBQghwRUtrK
   lho3R75g+YsiP/aNZmCdR/clLUJSwIMIFz1w/8bejMyQ3mEvez7HUGMY1
   XaioDfTamucZXmHWpmHZwG6Bo3sRDUqKpDGy79Svswh7JEKM0io+Ekz/H
   TLJWsLNp9SZI8It15KsBUSlK032SWoLAJguvHcErSy+V3WM6SmCD4LkzM
   pHMfeSiLjaBY8tsY4o91W1pMV3FKNDG5WWFvPWPhhz3OjOZtMhm3ARs2b
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="349425813"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="349425813"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 14:29:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="728428422"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="728428422"
Received: from sgimmeke-mobl.amr.corp.intel.com (HELO tzanussi-mobl1.intel.com) ([10.212.91.213])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 14:29:57 -0700
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        fenghua.yu@intel.com, vkoul@kernel.org
Cc:     dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, vinodh.gopal@intel.com,
        giovanni.cabiddu@intel.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
Subject: [PATCH v8 06/14] dmaengine: idxd: Add wq private data accessors
Date:   Mon, 31 Jul 2023 16:29:31 -0500
Message-Id: <20230731212939.1391453-7-tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230731212939.1391453-1-tom.zanussi@linux.intel.com>
References: <20230731212939.1391453-1-tom.zanussi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
---
 drivers/dma/idxd/idxd.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 276b5f9cf967..971daf323655 100644
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

