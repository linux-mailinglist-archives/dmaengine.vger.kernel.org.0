Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F2951528E
	for <lists+dmaengine@lfdr.de>; Fri, 29 Apr 2022 19:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354902AbiD2Rrk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 29 Apr 2022 13:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344488AbiD2Rrk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 29 Apr 2022 13:47:40 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1A7D39B4
        for <dmaengine@vger.kernel.org>; Fri, 29 Apr 2022 10:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651254261; x=1682790261;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aWqEodQe74p97F/7S2jOdriz6/nhyD4qahp50cRELuU=;
  b=oAi8N+EBdS2h98qL6YAn7yRNqVoA1jzq3ECg8AOeqqU9RBIoNRJFrjcM
   i8Lvwf6hCewWXCbBgkbSZoSmvqt3knPWu0xARyyPsH9XL8Hvw4SuzMWhV
   OF+7O9oHucYwF3c7ia6CBGqGq7vtrfPVRHE6cy/iPKzcZ37euynTikrW1
   Y9l+S/3qeic0NP8oPm8fx9bLBhHEhjXO9ccpXDaWcigI/+mX1fzV6qp76
   y2oAKYPOHNDnXdCoOlmK1xs4PKF5IJDfx7rksbjAT762F4BxtTNGp2TQz
   hZYGPXUT8sdwGCrYFdPUlyd9FFWcObfGCHuCtpK94hACUeEhvCO9E4iu/
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="264308671"
X-IronPort-AV: E=Sophos;i="5.91,185,1647327600"; 
   d="scan'208";a="264308671"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 10:36:17 -0700
X-IronPort-AV: E=Sophos;i="5.91,185,1647327600"; 
   d="scan'208";a="651846139"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 10:36:17 -0700
Subject: [PATCH] dmaengine: idxd: rate limit printk in misc interrupt thread
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Sanjay Kumar <sanjay.k.kumar@intel.com>, dmaengine@vger.kernel.org
Date:   Fri, 29 Apr 2022 10:36:17 -0700
Message-ID: <165125377735.312075.15715853788802098990.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add rate limit to the dev_warn() call in the misc interrupt thread. This
limits dmesg getting spammed if a descriptor submitter is spamming bad
descriptors with invalid completion records and resulting the errors being
continuously reported by the misc interrupt handling thread.

Reported-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/irq.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index 98aad8a9ed2c..0d43ba228f0d 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -272,8 +272,8 @@ irqreturn_t idxd_misc_thread(int vec, void *data)
 		val |= IDXD_INTC_ERR;
 
 		for (i = 0; i < 4; i++)
-			dev_warn(dev, "err[%d]: %#16.16llx\n",
-				 i, idxd->sw_err.bits[i]);
+			dev_warn_ratelimited(dev, "err[%d]: %#16.16llx\n",
+					     i, idxd->sw_err.bits[i]);
 		err = true;
 	}
 


