Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C196B19AD
	for <lists+dmaengine@lfdr.de>; Thu,  9 Mar 2023 03:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjCIC5r (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 8 Mar 2023 21:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjCIC5q (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 8 Mar 2023 21:57:46 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E438483F;
        Wed,  8 Mar 2023 18:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678330665; x=1709866665;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+VIsfsC+ed2JLTW7RF02HMNBvU/A0rEn7DhKk0iBQSM=;
  b=KS01tzCBQWnBOzBFBsSAMgrqNVLJmxLQ75m7hOYOFTkiVSfcwtMkg1Pk
   3GOsW4YFL1OKaW84/1SXjxU7BmmiERsN/1DaBTGw6GL/nGdKvgn6Opl+G
   RFs/0P/qHTaihoK+E0mVF3ob8SwB9DgD8CF7KP7Ap5GxuiU8gb4M1xvX6
   O1Xq+FdStV+/CKIg5BQ/F9IA281ICIEbChNXgIgrDvxu/i+oZUK5f6nLt
   zybxysvpBlqnFEUkMlRrPFjdYZTDcU50PUQdWSUHUTDc0Up2hJ392sUw1
   Nopk59vHFtKUNUtwXSnoptHdTaJJ9yqjKUcdTpuix0HmkoUoWWRH3Egs9
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="316732634"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="316732634"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 18:57:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="746144602"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="746144602"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga004.fm.intel.com with ESMTP; 08 Mar 2023 18:57:42 -0800
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
Subject: [PATCH v2 0/5] Refactor code for non-PRI IOPF
Date:   Thu,  9 Mar 2023 10:56:34 +0800
Message-Id: <20230309025639.26109-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
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

The existing SVA and IOPF implementation assumes that devices report I/O
page faults via PCI PRI. This is not always true as some emerging
devices are designed to handle the I/O page faults by themselves without
ever sending PCI page requests nor advertising PRI capability.

Refactor the SVA and IOPF code to allow SVA support with IOPF handled
either by IOMMU (PCI PRI) or device driver (device-specific IOPF).

This series is based on v6.3-rc1 and also available at github:
https://github.com/LuBaolu/intel-iommu/commits/intel-iommu-refactor-iopf-v2

Change log:
v2:
 - Separate a fix patch and merge it into v6. 3-rc1 [commit 60b1daa3b168
   ("iommu/vt-d: Fix error handling in sva enable/disable paths")]
 - Disallow device-specific IOPF is device advertising PRI capability;
 - Add some extra patches to move all IOPF related code to the IOPF
   enabling/disabling paths.

v1: Initial post
 - https://lore.kernel.org/linux-iommu/20230203084456.469641-1-baolu.lu@linux.intel.com/

Lu Baolu (5):
  dmaengine: idxd: Add enable/disable device IOPF feature
  iommu/vt-d: Allow SVA with device-specific IOPF
  iommu/vt-d: Move iopf code from SVA to IOPF enabling path
  iommu/vt-d: Move pfsid and ats_qdep calculation to device probe path
  iommu/vt-d: Move PRI handling to IOPF feature path

 drivers/dma/idxd/init.c     |  31 ++++++++--
 drivers/iommu/intel/iommu.c | 120 ++++++++++++++++++++++--------------
 2 files changed, 100 insertions(+), 51 deletions(-)

-- 
2.34.1

