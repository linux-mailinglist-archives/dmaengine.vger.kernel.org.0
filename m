Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B7A72F4C5
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jun 2023 08:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242549AbjFNG2a (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Jun 2023 02:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234691AbjFNG23 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 14 Jun 2023 02:28:29 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9C4199
        for <dmaengine@vger.kernel.org>; Tue, 13 Jun 2023 23:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686724108; x=1718260108;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YsAuy37whDbFap+QQxD/rhhZq3K/u2UHV/jCPDSRsZ4=;
  b=NKwUWkomj+lvrF0ilCeQp5XdhQL7jazStJZKquGeJkjZbqtDDuLKTMeN
   kaNivcw4uqjwyQ40vBTTNp0Nh1s3Y/DiOCWrZtj8GPr5tmfa6WzizdJKV
   M3TVlrcVSsZk9tStg2PPHv/BK/XxdIpG9m8LsAKY+5LPly4sSPZAnY0ke
   iQtvA1QSGpRJkks4ASVfcla8ngl3AlK0IXpluMyE+Qi4VHfMEoRgSExLp
   NOIEwyYwZ3CKR5N6CFdQIgex8b9eV2NKParhtnMy0ybaobzILq6aSEm9Z
   xyUboM1vWImZIAXILk31vBYgxEv/iMIDN6z4uH1paTpYEVu9QDgMfcWVM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="444906209"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="444906209"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 23:28:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="662277517"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="662277517"
Received: from rex-z390-aorus-pro.sh.intel.com ([10.239.161.21])
  by orsmga003.jf.intel.com with ESMTP; 13 Jun 2023 23:28:25 -0700
From:   rex.zhang@intel.com
To:     vkoul@kernel.org, fenghua.yu@intel.com, dave.jiang@intel.com,
        dmaengine@vger.kernel.org
Cc:     ramesh.thomas@intel.com, tony.zhu@intel.com, rex.zhang@intel.com
Subject: [PATCH 2/2] dmaengine: idxd: Modify ABI documentation for attribute pasid_enabled
Date:   Wed, 14 Jun 2023 14:28:23 +0800
Message-Id: <20230614062823.1743180-1-rex.zhang@intel.com>
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

Modify the sysfs attribute description in ABI/stable documentation for
the attribute /sys/bus/dsa/devices/dsa0/pasid_enabled.

Signed-off-by: Rex Zhang <rex.zhang@intel.com>
Acked-by: Fenghua Yu <fenghua.yu@intel.com>
Acked-by: Dave Jiang <dave.jiang@intel.com>
---
 Documentation/ABI/stable/sysfs-driver-dma-idxd | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/stable/sysfs-driver-dma-idxd b/Documentation/ABI/stable/sysfs-driver-dma-idxd
index 534b7a3d59fc..825e619250bf 100644
--- a/Documentation/ABI/stable/sysfs-driver-dma-idxd
+++ b/Documentation/ABI/stable/sysfs-driver-dma-idxd
@@ -84,7 +84,7 @@ What:		/sys/bus/dsa/devices/dsa<m>/pasid_enabled
 Date:		Oct 27, 2020
 KernelVersion:	5.11.0
 Contact:	dmaengine@vger.kernel.org
-Description:	To indicate if PASID (process address space identifier) is
+Description:	To indicate if user PASID (process address space identifier) is
 		enabled or not for this device.
 
 What:           /sys/bus/dsa/devices/dsa<m>/state
-- 
2.25.1

