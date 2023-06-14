Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A770372F4C2
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jun 2023 08:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243138AbjFNG1V (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Jun 2023 02:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242281AbjFNG1U (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 14 Jun 2023 02:27:20 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CC110E3
        for <dmaengine@vger.kernel.org>; Tue, 13 Jun 2023 23:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686724039; x=1718260039;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fIxeHj97LZx9dgC11r28UEXB75hD3EgHjNg+NPgV75I=;
  b=mB4pMvL+yURyyg2L5600QDWUWqBHT88couakS8TIeKWOIE+WyO+kokMs
   kaYh7Ry/gPD2KpkeKXPU8ICrOb2SnoExadHNKuQOS3hwnnVlOMhgDR+fb
   CH96HEUVqtOFZl0hIpWUf6Q9KElx5hx6/gK4DCy5De4xVFL1yaT/PqDoA
   qbJmb/yE9WDcU9Ke1PEFqH3N2t/s2JXa0VhiyDmLvYaaWd6UD6DJbI2BD
   aQtPr2ytKIy918TlJGd8wLgae6oELeuMRhIulIUWv2xQZ9ze7HhyKO1U1
   gK3u96DkkhkUYOWtPBARWWbat6JIsc2Lu9PtAGyL6SN960F+CXr4BnLT7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="356026627"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="356026627"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 23:27:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="801788832"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="801788832"
Received: from rex-z390-aorus-pro.sh.intel.com ([10.239.161.21])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Jun 2023 23:27:17 -0700
From:   rex.zhang@intel.com
To:     vkoul@kernel.org, fenghua.yu@intel.com, dave.jiang@intel.com,
        dmaengine@vger.kernel.org
Cc:     ramesh.thomas@intel.com, tony.zhu@intel.com, rex.zhang@intel.com
Subject: [PATCH 1/2] dmaengine: idxd: Modify the dependence of attribute pasid_enabled
Date:   Wed, 14 Jun 2023 14:27:06 +0800
Message-Id: <20230614062706.1743078-1-rex.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Rex Zhang <rex.zhang@intel.com>

Kernel PASID and user PASID are separately enabled. User needs to know the
user PASID enabling status to decide how to use IDXD device in user space.
This is done via the attribute /sys/bus/dsa/devices/dsa0/pasid_enabled.
It's unnecessary for user to know the kernel PASID enabling status because
user won't use the kernel PASID. But instead of showing the user PASID
enabling status, the attribute shows the kernel PASID enabling status. Fix
the issue by showing the user PASID enabling status in the attribute.

Fixes: 42a1b73852c4 ("dmaengine: idxd: Separate user and kernel pasid enabling")
Signed-off-by: Rex Zhang <rex.zhang@intel.com>
Acked-by: Fenghua Yu <fenghua.yu@intel.com>
Acked-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 293739ac5596..b6a0a12412af 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -1480,7 +1480,7 @@ static ssize_t pasid_enabled_show(struct device *dev,
 {
 	struct idxd_device *idxd = confdev_to_idxd(dev);
 
-	return sysfs_emit(buf, "%u\n", device_pasid_enabled(idxd));
+	return sysfs_emit(buf, "%u\n", device_user_pasid_enabled(idxd));
 }
 static DEVICE_ATTR_RO(pasid_enabled);
 
-- 
2.25.1

