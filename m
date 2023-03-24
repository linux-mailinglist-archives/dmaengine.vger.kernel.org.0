Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9516C7D9D
	for <lists+dmaengine@lfdr.de>; Fri, 24 Mar 2023 13:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbjCXMCZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 24 Mar 2023 08:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjCXMCY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 24 Mar 2023 08:02:24 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B794F23C74;
        Fri, 24 Mar 2023 05:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679659343; x=1711195343;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tEg9Nbf7D8iSqWKP78j00E29FBsj6/xmQlqzwzykS7Q=;
  b=Ld7YqzebQ8tj/UO6sUG3Koh5Vw406VM1Twe7SYsPXMltLemdXXeFbsb3
   vUaTQ/Qd96xlz7Ikds3wFcIjbzCDCe4FHpZIdPHJJ1SXAYMog3mz8Y/r2
   l5RgqcfDNfJQIoUKIiDbga9VQQTn0/+ddJxsJHubM13KWxDOXVmL07djO
   wt/Visb0kCQ3zI5DscOqPQL9/xEi5oVBkMOAKGiafbDpccQ1cIkcjb0qL
   LNajrnhbrnvu5g20vlukp1C/Z5TMAUWVX1uOUT+0m9RGhnnZyXhgvwUZ7
   miw1C2Jn+p3XH7P4PNmAblO/qktqV9PBxeYmOzemDCFi/xaxfNuUkkjMf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="323634123"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="323634123"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 05:02:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="682674688"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="682674688"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga002.jf.intel.com with ESMTP; 24 Mar 2023 05:02:20 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux.dev, dmaengine@vger.kernel.org
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 0/6] iommu/vt-d: Refactor code for non-PRI IOPF
Date:   Fri, 24 Mar 2023 20:02:28 +0800
Message-Id: <20230324120234.313643-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The existing SVA and IOPF implementation assumes that devices report I/O
page faults via PCI PRI. This is not always true as some emerging
devices are designed to handle the I/O page faults by themselves without
ever sending PCI page requests nor advertising PRI capability.

Refactor the SVA and IOPF code to allow SVA support with IOPF handled
either by IOMMU (PCI PRI) or device driver (device-specific IOPF).

This series is based on v6.3-rc1 and also available at github:
https://github.com/LuBaolu/intel-iommu/commits/intel-iommu-refactor-iopf-v3

Change log:
v3:
 - Split removing unnecessary checks in iopf disabling path into a
   separate patch.
 - Add some in-line comments.

v2:
 - https://lore.kernel.org/linux-iommu/20230309025639.26109-1-baolu.lu@linux.intel.com/
 - Separate a fix patch and merge it into v6. 3-rc1 [commit 60b1daa3b168
   ("iommu/vt-d: Fix error handling in sva enable/disable paths")]
 - Disallow device-specific IOPF is device advertising PRI capability;
 - Add some extra patches to move all IOPF related code to the IOPF
   enabling/disabling paths.

v1: Initial post
 - https://lore.kernel.org/linux-iommu/20230203084456.469641-1-baolu.lu@linux.intel.com/

Lu Baolu (6):
  dmaengine: idxd: Add enable/disable device IOPF feature
  iommu/vt-d: Allow SVA with device-specific IOPF
  iommu/vt-d: Move iopf code from SVA to IOPF enabling path
  iommu/vt-d: Move pfsid and ats_qdep calculation to device probe path
  iommu/vt-d: Move PRI handling to IOPF feature path
  iommu/vt-d: Remove unnecessary checks in iopf disabling path

 drivers/dma/idxd/init.c     |  31 +++++++--
 drivers/iommu/intel/iommu.c | 132 ++++++++++++++++++++++++------------
 2 files changed, 112 insertions(+), 51 deletions(-)

-- 
2.34.1

