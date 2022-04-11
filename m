Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC014FC753
	for <lists+dmaengine@lfdr.de>; Tue, 12 Apr 2022 00:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243238AbiDKWIv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Apr 2022 18:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241902AbiDKWIv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Apr 2022 18:08:51 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC06205DA
        for <dmaengine@vger.kernel.org>; Mon, 11 Apr 2022 15:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649714796; x=1681250796;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DA0U4deF17FC2GUQpx4txE2PV2xKeeCrS1D8dyboh9o=;
  b=bw4VIMbhAEQ7zHdu9xQ5ec8lM2D85zG74ExVblYMWNXBv3eTRWEcOkhx
   QzdkkNyKG1PGBB8YGw/P4MXTzQNZt5Z1T4SG+RT2ui107rGXeiW3j1Uai
   KlqpwFBMeq7GQBZPcCyInA7KMaQbL2BGlndwdiv7+0xtrsHZJwDPR1gfp
   /uUXKquhL/HmZjXFcGwfP55JwHY29RGN6E0X7BF2R1Mp5Z5wdsSjqrb0y
   I2v55tQhMiXueADB3KdgXyH1VHwFEaKzzXpt13YKFTZptfN0ZUrhuY75w
   sivuDOg7xTF1NJeaizxJzSMLqKP1LGvD7SYbEpLXurq5SKdL9Mej0PX2q
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="261072419"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="261072419"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 15:06:35 -0700
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="572438758"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 15:06:35 -0700
Subject: [PATCH] dmaengine: idxd: skip clearing device context when device is
 read-only
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Mon, 11 Apr 2022 15:06:34 -0700
Message-ID: <164971479479.2200566.13980022473526292759.stgit@djiang5-desk3.ch.intel.com>
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

If the device shows up as read-only configuration, skip the clearing of the
state as the context must be preserved for device re-enable after being
disabled.

Fixes: 0dcfe41e9a4c ("dmanegine: idxd: cleanup all device related bits after disabling device")
Reported-by: Tony Zhu <tony.zhu@intel.com>
Tested-by: Tony Zhu <tony.zhu@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/device.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 5a0535a0f850..f652da6ab47d 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -708,6 +708,9 @@ static void idxd_device_wqs_clear_state(struct idxd_device *idxd)
 
 void idxd_device_clear_state(struct idxd_device *idxd)
 {
+	if (!test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
+		return;
+
 	idxd_groups_clear_state(idxd);
 	idxd_engines_clear_state(idxd);
 	idxd_device_wqs_clear_state(idxd);


