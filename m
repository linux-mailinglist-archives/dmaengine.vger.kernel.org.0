Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5395050E7C1
	for <lists+dmaengine@lfdr.de>; Mon, 25 Apr 2022 20:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237772AbiDYSGg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Apr 2022 14:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237371AbiDYSGf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 25 Apr 2022 14:06:35 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3AD47041
        for <dmaengine@vger.kernel.org>; Mon, 25 Apr 2022 11:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650909810; x=1682445810;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=z2H6SyZjL2aQcSVOFHgUsJK+dElcpMSkvsfdZxkiq40=;
  b=apNZSCstK7y8TsDq8ueVn5n3Y0Fz5J0+DyHhaTAMqciF6ZxThAk2jYay
   HN+MKtTRAq1CsSW/UDm6iaEFFb7xh+SyTl4iJbSQuRAYhZQkGkqHGuZo9
   26lKLwxFMFJ9vNVWLSxOxB65R7QNtBQf7zzlE8lNw5Gr0ytXboJOm3cOT
   YuaJuGZWhUtOeL2xt8J4P76XZH95wuCocB3jSg3GlpeZcsx85bH41o5V6
   zpjGFjoML7X6DnidEuF1PmyWm09cKKFKKSRo78j99icohXSIiYvMWWXYc
   rvk2HevXucUA9nmf0Ra6HTztCPSmsVXiYCFPenhrCPEOixFi1HCU8SzOp
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="247252735"
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="247252735"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 11:03:29 -0700
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="628149557"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 11:03:29 -0700
Subject: [PATCH] dmaengine: idxd: make idxd_wq_enable() return 0 if wq is
 already enabled
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Mon, 25 Apr 2022 11:03:29 -0700
Message-ID: <165090980906.1378449.1939401700832432886.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

When calling idxd_wq_enable() and wq is already enabled, code should return 0
and indicate function is successful instead of return error code and fail.
This should also put idxd_wq_enable() in sync with idxd_wq_disable() where
it returns 0 if wq is already disabled.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/device.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 22ad9ee383e2..93cbfd726904 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -184,7 +184,7 @@ int idxd_wq_enable(struct idxd_wq *wq)
 
 	if (wq->state == IDXD_WQ_ENABLED) {
 		dev_dbg(dev, "WQ %d already enabled\n", wq->id);
-		return -ENXIO;
+		return 0;
 	}
 
 	idxd_cmd_exec(idxd, IDXD_CMD_ENABLE_WQ, wq->id, &status);


