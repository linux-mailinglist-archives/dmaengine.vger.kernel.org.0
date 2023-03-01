Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18D76A7806
	for <lists+dmaengine@lfdr.de>; Thu,  2 Mar 2023 00:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjCAXxt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 1 Mar 2023 18:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjCAXxs (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 1 Mar 2023 18:53:48 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE9E1A66B;
        Wed,  1 Mar 2023 15:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677714827; x=1709250827;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QOd5AAG+EZGbuAGfUXscK1yyzYiihDtrdKAjjEtJTkE=;
  b=e4KcHa8aE0T1T5VtBjzJq/OVQf25f14/Fh4bQWp1WSv50P8EjPFCEV+R
   f8nTduA+0ErQ6OR0+5B77thafrac5zmAvAqcnH8Jn7+FH1H4517jkAsVe
   jnsWp1V912HInlwfHqSNA/HjrCp2XWfCrGpvuoAWa6G9bbKt2f2m65k9K
   HveWuZUHctmJZNyEhJLAn0upV2XhFK2BHxKMXfs+fqnrMpNN3esPEYEJv
   wSnZYXStb8jsYP2L7YnAOPGR+CTx0g3gPw6/06JZJpltHQDHOzs0KhvRC
   vQLP4rR6F3OKwuvI0ExOVp3iS9Nhdom8j1HkB6XhG6LQKvl9AlaLH7D5z
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="397127609"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="397127609"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 15:53:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="1003880312"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="1003880312"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.106])
  by fmsmga005.fm.intel.com with ESMTP; 01 Mar 2023 15:52:58 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        X86 Kernel <x86@kernel.org>, bp@alien8.de,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, corbet@lwn.net,
        vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     "Robin Murphy" <robin.murphy@arm.com>,
        "Will Deacon" <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v4 0/6] Remove VT-d virtual command interface and IOASID
Date:   Wed,  1 Mar 2023 15:56:40 -0800
Message-Id: <20230301235646.2692846-1-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

This patch set removes unused VT-d virtual command interface followed by
removal of the IOASID infrastructure.

This has only been tested on x86 platforms, need help with testing on ARM
SMMU and other architectures.


Thanks,

Jacob

ChangeLog:
v4:
 - keep mm_pasid helpers inline as much as we can for fork performance
 - separate GFP_ATOMIC to GFP_KERNEL change for bisectability

v3:
 - moved helper functions for PASID under SVA code, avoided circular inclusion
   between mm.h and iommu.h
 - deleted makefiles
 - put rename under a different patch


Jacob Pan (4):
  iommu/vt-d: Remove virtual command interface
  iommu/sva: Move PASID helpers to sva code
  iommu/sva: Use GFP_KERNEL for pasid allocation
  iommu/ioasid: Rename INVALID_IOASID

Jason Gunthorpe (2):
  iommu/sva: Stop using ioasid_set for SVA
  iommu: Remove ioasid infrastructure

 Documentation/x86/sva.rst       |   2 +-
 arch/x86/kernel/traps.c         |   5 +-
 drivers/dma/idxd/device.c       |   8 +-
 drivers/dma/idxd/idxd.h         |   2 +-
 drivers/dma/idxd/init.c         |   2 +-
 drivers/dma/idxd/irq.c          |   2 +-
 drivers/iommu/Kconfig           |   5 -
 drivers/iommu/Makefile          |   1 -
 drivers/iommu/intel/cap_audit.c |   2 -
 drivers/iommu/intel/dmar.c      |   6 +-
 drivers/iommu/intel/iommu.c     |  87 +------
 drivers/iommu/intel/iommu.h     |   9 -
 drivers/iommu/intel/svm.c       |   3 +-
 drivers/iommu/ioasid.c          | 422 --------------------------------
 drivers/iommu/iommu-sva.c       |  62 ++---
 drivers/iommu/iommu-sva.h       |   4 -
 include/linux/ioasid.h          |  83 -------
 include/linux/iommu-helper.h    |   1 +
 include/linux/iommu.h           |   8 +-
 include/linux/sched/mm.h        |  20 +-
 mm/init-mm.c                    |   4 +-
 21 files changed, 46 insertions(+), 692 deletions(-)
 delete mode 100644 drivers/iommu/ioasid.c
 delete mode 100644 include/linux/ioasid.h

-- 
2.25.1

