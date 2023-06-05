Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2BA7230D4
	for <lists+dmaengine@lfdr.de>; Mon,  5 Jun 2023 22:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbjFEUQF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 5 Jun 2023 16:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbjFEUPz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 5 Jun 2023 16:15:55 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BBA10B;
        Mon,  5 Jun 2023 13:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685996152; x=1717532152;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bcf35D7IfQE8V0L8poAmnD7F4eeWOCF5TiyphB5oags=;
  b=Iu6OgaITiybAzDX98TbKIOir6zQlPDUBI7hmKggJvoJgigGyoyiMqJ/x
   Q9h/w52/2r8FAEuhYC7XmBWuDorhP8UCL4WfnjU7fKwTv0xtuw65+UD//
   Ois/mOGI9momT54svsIuZjAfqkYJnCzpq8YkCBRcMB2gJG+GOeFopVaoz
   HAW+l5dzVPuBm+xPKDFkUzH3nXLHjVHk4OPDxZRwIn39MgjN2Fd6SyzpA
   yzeaL9IufxL4ME7EOzzQLg/1ffYgwF5zvcnyqv62y3dM2ANxGIkGE9e73
   87oYScde8VDghSxpl8ojHZQ8uxdRI5BsaY38+gl5aqNtkBdUSx0mlB8CP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="356480267"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="356480267"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 13:15:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="711934354"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="711934354"
Received: from rkbrewer-mobl1.amr.corp.intel.com (HELO tzanussi-mobl1.intel.com) ([10.212.33.16])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 13:15:44 -0700
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        fenghua.yu@intel.com, vkoul@kernel.org
Cc:     dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, vinodh.gopal@intel.com,
        giovanni.cabiddu@intel.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
Subject: [PATCH v6 03/15] dmaengine: idxd: Export drv_enable/disable and related functions
Date:   Mon,  5 Jun 2023 15:15:24 -0500
Message-Id: <20230605201536.738396-4-tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605201536.738396-1-tom.zanussi@linux.intel.com>
References: <20230605201536.738396-1-tom.zanussi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

