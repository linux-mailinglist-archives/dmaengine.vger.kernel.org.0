Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2B350E7A9
	for <lists+dmaengine@lfdr.de>; Mon, 25 Apr 2022 20:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244186AbiDYSC7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Apr 2022 14:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244188AbiDYSC6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 25 Apr 2022 14:02:58 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F9527FFD
        for <dmaengine@vger.kernel.org>; Mon, 25 Apr 2022 10:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650909593; x=1682445593;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3t8YbVF45jmWiH4ipZW+vJCdqzVizOr13i3lTD+2Gbo=;
  b=VO6C7eqwE9qNaTsPoHrwNE+fozSdyHF9rOTJ4aUqf7WG3CR6mEUdq5Q3
   aAeenuhaCPtgtoiRXcodhHcmLpSaxxm8r6rhy741gpfPtZfv8mOo6cEoE
   IfXFhoYKsbDKHU8W/GCsotJPkMZe3ykwAKl2xnGyBf4DJbj+nlsNHjVKl
   fyEugXZejol7QTCJDhM00oAB6KGSkcSz5rXPpEF81MpxCkyyIXWIuBU+i
   x5J1l79PZyq2TOThW3mcCZ23e9v15YZ5X/Aum2sy1bB7xsCdxS1halSI0
   IV/UBZHRyTO+UkuszRIOpZ4LVqFR+YHqy5kdgZdmNOkbGRwLzZLy2Vj7x
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="351768831"
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="351768831"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 10:59:53 -0700
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="537702210"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 10:59:52 -0700
Subject: [PATCH] dmaengine: idxd: force wq context cleanup on device disable
 path
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Tony Zhu <tony.zhu@intel.com>, Tony Zhu <tony.zhu@intel.com>,
        dmaengine@vger.kernel.org
Date:   Mon, 25 Apr 2022 10:59:52 -0700
Message-ID: <165090959239.1376825.18183942742142655091.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Testing shown that when a wq mode is setup to be dedicated and then torn
down and reconfigured to shared, the wq configured end up being dedicated
anyays. The root cause is when idxd_device_wqs_clear_state() gets called
during idxd_driver removal, idxd_wq_disable_cleanup() does not get called
vs when the wq driver is removed first. The check of wq state being
"enabled" causes the cleanup to be bypassed. However, idxd_driver->remove()
releases all wq drivers. So the wqs goes to "disabled" state and will never
be "enabled". By that point, the driver has no idea if the wq was
previously configured or clean. So force call idxd_wq_disable_cleanup() on
all wqs always to make sure everything gets cleaned up.

Reported-by: Tony Zhu <tony.zhu@intel.com>
Tested-by: Tony Zhu <tony.zhu@intel.com>
Fixes: 0dcfe41e9a4c ("dmanegine: idxd: cleanup all device related bits after disabling device")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/device.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index f652da6ab47d..58490289efc3 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -698,10 +698,7 @@ static void idxd_device_wqs_clear_state(struct idxd_device *idxd)
 	for (i = 0; i < idxd->max_wqs; i++) {
 		struct idxd_wq *wq = idxd->wqs[i];
 
-		if (wq->state == IDXD_WQ_ENABLED) {
-			idxd_wq_disable_cleanup(wq);
-			wq->state = IDXD_WQ_DISABLED;
-		}
+		idxd_wq_disable_cleanup(wq);
 		idxd_wq_device_reset_cleanup(wq);
 	}
 }


