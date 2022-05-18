Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9279252C237
	for <lists+dmaengine@lfdr.de>; Wed, 18 May 2022 20:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241341AbiERSRj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 18 May 2022 14:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241335AbiERSRi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 18 May 2022 14:17:38 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128FF17EC3F;
        Wed, 18 May 2022 11:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652897857; x=1684433857;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jiWNr+sMv+2JyZnQPheEt7B1dprQHk1BBtw/ckfenU8=;
  b=OKGHwRqBVZD11M6oK9F0PNkvMzO82Hd8gneZxbULIP0VkyQceGonZ6AA
   3ILc+3sAYwfZ72MqakbkoOYRHgClOWPBtCTMnUeEhKqrfOD5TwvFk+0WS
   X4bz1BV1aMeoX/aW6qI417HrtVYab1lnC+iGpyay4Ffl01+PpBBD9LPFO
   Hrmf5re5Fwb4LfNOnWE/y0hSUZmHa2mKRRjfC9IROv8oSrEaxILiLcWAe
   33CBnuCTasretJabVMkqRyq1f17ljBaR6gfZS+AxsQrT/K2HWu9kj1ILo
   sATdHwZqonnM9jBn0Vb0HgxMDLy/obrlzLvYs9OHFf6DrNDzzzJuOD4GU
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="270648737"
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="270648737"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 11:17:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="639405492"
Received: from otc-wp-03.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.79])
  by fmsmga004.fm.intel.com with ESMTP; 18 May 2022 11:17:30 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>, dmaengine@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Christoph Hellwig" <hch@infradead.org>, vkoul@kernel.org,
        robin.murphy@arm.com, will@kernel.org
Cc:     Yi Liu <yi.l.liu@intel.com>, Dave Jiang <dave.jiang@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v4 0/6] Enable PASID for DMA API users
Date:   Wed, 18 May 2022 11:21:14 -0700
Message-Id: <20220518182120.1136715-1-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Some modern accelerators such as Intel's Data Streaming Accelerator (DSA)
require PASID in DMA requests to be operational. Specifically, the work
submissions with ENQCMD on shared work queues require PASIDs. The use cases
include both user DMA with shared virtual addressing (SVA) and in-kernel
DMA similar to legacy DMA w/o PASID. Here we address the latter.

DMA mapping API is the de facto standard for in-kernel DMA. However, it
operates on a per device or Requester ID(RID) basis which is not
PASID-aware. To leverage DMA API for devices relies on PASIDs, this
patchset introduces the following APIs

1. A driver facing API that enables DMA API PASID usage:
iommu_attach_dma_pasid(struct device *dev, ioasid_t &pasid);
2. VT-d driver default domain op that allows attaching device-domain-PASID

Once PASID DMA is enabled and attached to the appropriate IOMMU domain,
device drivers can continue to use DMA APIs as-is. There is no difference
in terms of mapping in dma_handle between without PASID and with PASID.
The DMA mapping performed by IOMMU will be identical for both requests, let
it be IOVA or PA in case of pass-through.

In addition, this set converts DSA driver in-kernel DMA with PASID from SVA
lib to DMA API. There have been security and functional issues with the
kernel SVA approach:
(https://lore.kernel.org/linux-iommu/20210511194726.GP1002214@nvidia.com/)
The highlights are as the following:
 - The lack of IOTLB synchronization upon kernel page table updates.
   (vmalloc, module/BPF loading, CONFIG_DEBUG_PAGEALLOC etc.)
 - Other than slight more protection, using kernel virtual address (KVA)
has little advantage over physical address. There are also no use cases yet
where DMA engines need kernel virtual addresses for in-kernel DMA.

Subsequently, cleanup is done around the usage of sva_bind_device() for
in-kernel DMA. Removing special casing code in VT-d driver and tightening
SVA lib API.

This work and idea behind it is a collaboration with many people, many
thanks to Baolu Lu, Jason Gunthorpe, Dave Jiang, and others.


ChangeLog:
v4
	- Rebased on "Baolu's SVA and IOPF refactoring" series v6.
	(https://github.com/LuBaolu/intel-iommu/commits/iommu-sva-refactoring-v6)
	- Fixed locking for protecting iommu domain PASID data
	- Use iommu_attach_device_pasid() API instead of calling domain
	  ops directly. This will leverage the common pasid_array that
	  replaces driver specific storage in device_domain_info.
	- Added a helper function to do look up in pasid_array from
	  domain

v3
	- Rebased on "Baolu's SVA and IOPF refactoring" series v5.
	(https://github.com/LuBaolu/intel-iommu/commits/iommu-sva-refactoring-v5)
	This version is significantly simplified by leveraging IOMMU domain
	ops, attach_dev_pasid() op is implemented differently on a DMA domain
	than on a SVA domain.
	We currently have no need to support multiple PASIDs per DMA domain.
	(https://lore.kernel.org/lkml/20220315142216.GV11336@nvidia.com/).
	Removed PASID-device list from V2, a PASID field is introduced to
	struct iommu_domain instead. It is intended for DMA requests with
	PASID by all devices attached to the domain.

v2
	- Do not reserve a special PASID for DMA API usage. Use IOASID
	  allocation instead.
	- Introduced a generic device-pasid-domain attachment IOMMU op.
	  Replaced the DMA API only IOMMU op.
	- Removed supervisor SVA support in VT-d
	- Removed unused sva_bind_device parameters
	- Use IOMMU specific data instead of struct device to store PASID
	  info




*** SUBJECT HERE ***

*** BLURB HERE ***

Jacob Pan (6):
  iommu: Add a per domain PASID for DMA API
  iommu: Add a helper to do PASID lookup from domain
  iommu/vt-d: Implement domain ops for attach_dev_pasid
  iommu: Add PASID support for DMA mapping API users
  dmaengine: idxd: Use DMA API for in-kernel DMA with PASID
  iommu/vt-d: Delete unused SVM flag

 drivers/dma/idxd/idxd.h     |   1 -
 drivers/dma/idxd/init.c     |  34 +++--------
 drivers/dma/idxd/sysfs.c    |   7 ---
 drivers/iommu/dma-iommu.c   | 114 ++++++++++++++++++++++++++++++++++++
 drivers/iommu/intel/iommu.c |  72 ++++++++++++++++++++++-
 drivers/iommu/intel/svm.c   |   2 +-
 drivers/iommu/iommu.c       |  22 +++++++
 include/linux/dma-iommu.h   |   3 +
 include/linux/intel-svm.h   |  13 ----
 include/linux/iommu.h       |   8 ++-
 10 files changed, 226 insertions(+), 50 deletions(-)

-- 
2.25.1

