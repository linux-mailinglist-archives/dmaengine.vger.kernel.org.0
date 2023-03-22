Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66AF6C572A
	for <lists+dmaengine@lfdr.de>; Wed, 22 Mar 2023 21:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbjCVUN5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Mar 2023 16:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbjCVUNj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Mar 2023 16:13:39 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B22E80E13;
        Wed, 22 Mar 2023 13:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679515500; x=1711051500;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=a8YkKlN2oKnSi1BC3A2diPgc104NuJ1ZJiB6GyG9A2k=;
  b=M0+RtruKBflVeTY5tcMZJRG45AoDM75Fm/M+dDOoXdFCyNrBEYMMm/Pl
   /JEFb29A9rKU+T6/iW7C1UCFsUK7nt3Q3rw02d0XCLtdczsDw3ki+m7JB
   r03PheuwZMFIHNH03jtaCfpXLMETorUnB4iU3II6eqBLb1B/8Tzfv4pcm
   QAgM5P3o56vhX9dB9sMwc7jkIcu7EZdtLE3vdx/qyxTkBahOxuEzvouJI
   7qUwJhISLHzMeJZ7zhFXxRpgsVi/5mQUSOiYh+xs6ACXLV/unP5+GcdPY
   /4bprK0FGbR63Ft6RfCCjTY7SRQAp9LCH/3oqwBfp6H2BuU+RTcVLgF1i
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="339356785"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="339356785"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 13:04:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="682039315"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="682039315"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.106])
  by orsmga002.jf.intel.com with ESMTP; 22 Mar 2023 13:04:04 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Robin Murphy" <robin.murphy@arm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        X86 Kernel <x86@kernel.org>, bp@alien8.de,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, corbet@lwn.net,
        vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     "Will Deacon" <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v8 0/7] Remove VT-d virtual command interface and IOASID
Date:   Wed, 22 Mar 2023 13:07:56 -0700
Message-Id: <20230322200803.869130-1-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=AC_FROM_MANY_DOTS,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi all,

This patch set removes unused VT-d virtual command interface followed by
removal of the IOASID infrastructure.

This has only been tested on x86 platforms, need help with testing on ARM
SMMU and other architectures.


Thanks,

Jacob

ChangeLog:
v8:
 - remove #ifdef CONFIG_IOMMU_SVA since we have dummy inline functions.
 - fixed a compile bug that affects bisectability

v7:
 - use CONFIG_IOMMU_SVA around PASID helpers in fork.c, Fixes a
   compile problem.
 - Fix extra space

v6:
 - put pasid helpers under iommu.h instead of iommu-helper.h
 - add comments for pasid allocation function to clarify inclusive range

v5:
 - rebased on v6.3-rc1
 - put removing iommu_sva_find() in a separate patch (Kevin)
 - move definition of helpers to iommu code to be consistent with
   declarations. (Kevin)
 - misc fixes

v4:
 - keep mm_pasid helpers inline as much as we can for fork performance
 - separate GFP_ATOMIC to GFP_KERNEL change for bisectability

v3:
 - moved helper functions for PASID under SVA code, avoided circular inclusion
   between mm.h and iommu.h
 - deleted makefiles
 - put rename under a different patch



Jacob Pan (5):
  iommu/vt-d: Remove virtual command interface
  iommu/sva: Move PASID helpers to sva code
  iommu/sva: Remove PASID to mm lookup function
  iommu/sva: Use GFP_KERNEL for pasid allocation
  iommu/ioasid: Rename INVALID_IOASID

Jason Gunthorpe (2):
  iommu/sva: Stop using ioasid_set for SVA
  iommu: Remove ioasid infrastructure

 Documentation/x86/sva.rst       |   2 +-
 arch/x86/kernel/traps.c         |   2 +-
 drivers/dma/idxd/device.c       |   8 +-
 drivers/dma/idxd/idxd.h         |   2 +-
 drivers/dma/idxd/init.c         |   2 +-
 drivers/dma/idxd/irq.c          |   2 +-
 drivers/iommu/Kconfig           |   5 -
 drivers/iommu/Makefile          |   1 -
 drivers/iommu/intel/cap_audit.c |   2 -
 drivers/iommu/intel/dmar.c      |   6 +-
 drivers/iommu/intel/iommu.c     |  87 +------
 drivers/iommu/intel/iommu.h     |   3 -
 drivers/iommu/intel/svm.c       |   3 +-
 drivers/iommu/ioasid.c          | 422 --------------------------------
 drivers/iommu/iommu-sva.c       |  61 ++---
 drivers/iommu/iommu-sva.h       |   4 -
 include/linux/ioasid.h          |  83 -------
 include/linux/iommu.h           |  14 +-
 include/linux/sched/mm.h        |  26 --
 kernel/fork.c                   |   1 +
 mm/init-mm.c                    |   4 +-
 21 files changed, 47 insertions(+), 693 deletions(-)
 delete mode 100644 drivers/iommu/ioasid.c
 delete mode 100644 include/linux/ioasid.h

-- 
2.25.1

