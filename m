Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32AA76F1FC8
	for <lists+dmaengine@lfdr.de>; Fri, 28 Apr 2023 22:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346777AbjD1Uz7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Apr 2023 16:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346764AbjD1Uz4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 28 Apr 2023 16:55:56 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1341719;
        Fri, 28 Apr 2023 13:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682715355; x=1714251355;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LXsQK8TukVyQm+lDiXEHCmOKMbCLHF5W6zenC6HO9JE=;
  b=MYr0BtdmWck5UcNcm+jh1d9UWi7UkBvO68KCBvl3pxtm4s50+NFeUslS
   DC/0wXZ6Fz+SUy/9F7Rwp78OZz+dlRpmlNIVVNlc4WHV6roRa0Z3lyCrL
   l475Gb0arMhFeJaGZ6fQdypcPVO5ZdM+31NcKnXoFErbtW+WCblmoz8QU
   Ocx0NEBY47OQwEkz6hl6IVPDjFdJGDkOyotjo2o91oLvo+prJeHqOiD08
   X8QvTZJjbJvN0RzznZ6duii4ATnHvAeKjxIUxuGR2PK+LCxkj3Pm9wIco
   6SbYYV3DmpLaAFa48Ew9HaQAmTCE7FL0tsVjr0JL0GAJfzOMijAOdX1Fk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="336937640"
X-IronPort-AV: E=Sophos;i="5.99,235,1677571200"; 
   d="scan'208";a="336937640"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 13:55:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="838980363"
X-IronPort-AV: E=Sophos;i="5.99,235,1677571200"; 
   d="scan'208";a="838980363"
Received: from ykaur1-mobl2.amr.corp.intel.com (HELO tzanussi-mobl1.intel.com) ([10.209.181.29])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 13:55:50 -0700
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        fenghua.yu@intel.com, vkoul@kernel.org
Cc:     dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, giovanni.cabiddu@intel.com,
        hdanton@sina.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
Subject: [PATCH v3 03/15] dmaengine: idxd: Export drv_enable/disable and related functions
Date:   Fri, 28 Apr 2023 15:55:27 -0500
Message-Id: <20230428205539.113902-4-tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230428205539.113902-1-tom.zanussi@linux.intel.com>
References: <20230428205539.113902-1-tom.zanussi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

To allow idxd sub-drivers to enable and disable wqs, export them.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 5f321f3b4242..af1aa88a66c1 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -1406,6 +1406,7 @@ int drv_enable_wq(struct idxd_wq *wq)
 err:
 	return rc;
 }
+EXPORT_SYMBOL_NS_GPL(drv_enable_wq, IDXD);
 
 void drv_disable_wq(struct idxd_wq *wq)
 {
@@ -1427,6 +1428,7 @@ void drv_disable_wq(struct idxd_wq *wq)
 	wq->type = IDXD_WQT_NONE;
 	wq->client_count = 0;
 }
+EXPORT_SYMBOL_NS_GPL(drv_disable_wq, IDXD);
 
 int idxd_device_drv_probe(struct idxd_dev *idxd_dev)
 {
-- 
2.34.1

