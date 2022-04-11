Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C1C4FC763
	for <lists+dmaengine@lfdr.de>; Tue, 12 Apr 2022 00:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235263AbiDKWNi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Apr 2022 18:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235026AbiDKWNh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Apr 2022 18:13:37 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0182462E8
        for <dmaengine@vger.kernel.org>; Mon, 11 Apr 2022 15:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649715081; x=1681251081;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WvHYHTlmVTzJmKnxy/6GVshs4FLTe5vUP12XP4sV8Pc=;
  b=EjkiqXAW/bbaUN+cQ700FiciljRR2CaaSSPhLCrPXrXE21Tykh+wcCkf
   toQ3GVn0L34PA2IujfwxnDn2QEgmCXrbJQyxOu0l7h8QykBvEM5jj1abp
   bLoofxJID5u3UT86o2mbXFnmEceVBq+iC0Vg9kjlvfxrde0R5HTHuZ08N
   tW3Y2ZpvfyrC0f9eSh001Z4RqdRt8WMAGyIMXUZ9SMp95DOZz2UAfW3EN
   jI5ErwZILNm5YsqulwETiBRy5XlpuzUwHl3w2YoVeNDrLqAorasWy4/HE
   MqDcsmY8mniu9loavrlnDQvZRTf4518vDvF3ShQbLXp0J/ZG/lkJVMwzp
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="242813192"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="242813192"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 15:11:17 -0700
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="525747400"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 15:11:17 -0700
Subject: [PATCH] dmaengine: idxd: set max_xfer and max_batch for RO device
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Mon, 11 Apr 2022 15:11:16 -0700
Message-ID: <164971507673.2201761.11244446608988838897.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Load the max_xfer_size and max_batch_size values from the values read from
registers to the shadow variables. This will allow the read-only device to
display the correct values for the sysfs attributes.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/device.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index f652da6ab47d..95c8c7d8d419 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -1018,6 +1018,9 @@ static int idxd_wq_load_config(struct idxd_wq *wq)
 
 	wq->priority = wq->wqcfg->priority;
 
+	wq->max_xfer_bytes = 1ULL << wq->wqcfg->max_xfer_shift;
+	wq->max_batch_size = 1ULL << wq->wqcfg->max_batch_shift;
+
 	for (i = 0; i < WQCFG_STRIDES(idxd); i++) {
 		wqcfg_offset = WQCFG_OFFSET(idxd, wq->id, i);
 		dev_dbg(dev, "WQ[%d][%d][%#x]: %#x\n", wq->id, i, wqcfg_offset, wq->wqcfg->bits[i]);


