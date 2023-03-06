Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84046ACD17
	for <lists+dmaengine@lfdr.de>; Mon,  6 Mar 2023 19:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjCFSwt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Mar 2023 13:52:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjCFSwl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Mar 2023 13:52:41 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0F56A05C;
        Mon,  6 Mar 2023 10:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678128759; x=1709664759;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OtM3rn2qVNEodUF6b7WwLHWyrC+y34N0YmCPeW0BQzE=;
  b=W91YTFjnHYD/cTQduA+KXpXaq3CMFHxZkWjXym/eokwl2KPBcdeqzQd0
   gR1JrG321whGXwr1FY9FXweufScAjRsFeQ/eSnv5nPnAzMtpA23HTvipR
   MgNREecmbUJX3/3eOY9sgceKu0JS3/annAseNT9uMCfp0xGEvYh36j7Jz
   VTodgPa4zk8aZVWaIFJ3pWEotNI/ogxAtgos+AIzUpules1LXUtYN/N/A
   +6eBqorQlM7JZy2Hso9TzUBNOD4+l6ljMBxUW2Wm5Xzxs7+NVYP4V92Qz
   ZTGWtCAQbqXZkWpPSBhH8waU/cK4Qezv8P60eofWF875x6aelJhnDhBqM
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="398227689"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="398227689"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 10:52:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="626255759"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="626255759"
Received: from jeblanco-mobl.amr.corp.intel.com (HELO tzanussi-mobl1.hsd1.il.comcast.net) ([10.212.118.26])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 10:52:37 -0800
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        fenghua.yu@intel.com, vkoul@kernel.org
Cc:     dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
Subject: [PATCH 03/16] dmaengine: idxd: Export drv_enable/disable and related functions
Date:   Mon,  6 Mar 2023 12:52:13 -0600
Message-Id: <20230306185226.26483-4-tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230306185226.26483-1-tom.zanussi@linux.intel.com>
References: <20230306185226.26483-1-tom.zanussi@linux.intel.com>
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

To allow idxd sub-drivers to enable and disable wqs, export them.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
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

