Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504577208E7
	for <lists+dmaengine@lfdr.de>; Fri,  2 Jun 2023 20:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237018AbjFBSRo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 2 Jun 2023 14:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235298AbjFBSRn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 2 Jun 2023 14:17:43 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE313197;
        Fri,  2 Jun 2023 11:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685729858; x=1717265858;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3FVtuc/IjJgA/TQjAer/Ui08hmWExZQThjvT0VtpwAU=;
  b=c5t+JsZJdQFgxtJV0Qo2D3FT8affeJD0+m8JMG45NrP6/dF9jMVSBdUR
   KeTcpR6njCSY4q5ATq0v7lLWbGJD5/JxOkSe/NBBEinsvJYpyd3TU/L6n
   3V9+itIB8UzHuPxCsdZ7eSbE83D0k7PWDoBMR6D3yVslBr6h6cUMhvhiB
   HRfwD7+Ygqg+sA8T8sZObdXwEQPKKQixq1Z3wODECqtKct+634uup/9C5
   BrijoYKypYj6PKNtjULNyKwfEBIhrkg/+TXs4if9W3+qr0j7zaWb/Lw1+
   bftHNi+w0jdeTGQuYTzHUYnxKX9rL8FFQgk27M0NxjiTWQEzFhZBzXUqF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="442310213"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="442310213"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 11:17:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="832060958"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="832060958"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.97.184])
  by orsmga004.jf.intel.com with ESMTP; 02 Jun 2023 11:17:37 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        dmaengine@vger.kernel.org, vkoul@kernel.org
Cc:     "Will Deacon" <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>, rex.zhang@intel.com,
        xiaochen.shen@intel.com, narayan.ranganathan@intel.com,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v8 1/7] iommu: Generalize PASID 0 for normal DMA w/o PASID
Date:   Fri,  2 Jun 2023 11:22:06 -0700
Message-Id: <20230602182212.150825-2-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230602182212.150825-1-jacob.jun.pan@linux.intel.com>
References: <20230602182212.150825-1-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

PCIe Process address space ID (PASID) is used to tag DMA traffic, it
provides finer grained isolation than requester ID (RID).

For each device/RID, 0 is a special PASID for the normal DMA (no
PASID). This is universal across all architectures that supports PASID,
therefore warranted to be reserved globally and declared in the common
header. Consequently, we can avoid the conflict between different PASID
use cases in the generic code. e.g. SVA and DMA API with PASIDs.

This paved away for device drivers to choose global PASID policy while
continue doing normal DMA.

Noting that VT-d could support none-zero RID/NO_PASID, but currently not
used.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
v8:
   - make consistent use of NO_PASID in SMMU code
   - remove PASID_MIN
v7:
   - renamed IOMMU_DEF_RID_PASID to be IOMMU_NO_PASID to be more generic
v6:
   - let SMMU code use the common RID_PASID macro
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 16 ++++++-------
 drivers/iommu/intel/iommu.c                   | 24 +++++++++----------
 drivers/iommu/intel/pasid.c                   |  2 +-
 drivers/iommu/intel/pasid.h                   |  2 --
 include/linux/iommu.h                         |  1 +
 6 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index a5a63b1c947e..5e6b39881c04 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -80,7 +80,7 @@ arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
 	 * be some overlap between use of both ASIDs, until we invalidate the
 	 * TLB.
 	 */
-	arm_smmu_write_ctx_desc(smmu_domain, 0, cd);
+	arm_smmu_write_ctx_desc(smmu_domain, IOMMU_NO_PASID, cd);
 
 	/* Invalidate TLB entries previously associated with that context */
 	arm_smmu_tlb_inv_asid(smmu, asid);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 3fd83fb75722..c97710635796 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1053,7 +1053,7 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
 	/*
 	 * This function handles the following cases:
 	 *
-	 * (1) Install primary CD, for normal DMA traffic (SSID = 0).
+	 * (1) Install primary CD, for normal DMA traffic (SSID = IOMMU_NO_PASID = 0).
 	 * (2) Install a secondary CD, for SID+SSID traffic.
 	 * (3) Update ASID of a CD. Atomically write the first 64 bits of the
 	 *     CD, then invalidate the old entry and mappings.
@@ -1601,7 +1601,7 @@ static void arm_smmu_handle_ppr(struct arm_smmu_device *smmu, u64 *evt)
 
 	sid = FIELD_GET(PRIQ_0_SID, evt[0]);
 	ssv = FIELD_GET(PRIQ_0_SSID_V, evt[0]);
-	ssid = ssv ? FIELD_GET(PRIQ_0_SSID, evt[0]) : 0;
+	ssid = ssv ? FIELD_GET(PRIQ_0_SSID, evt[0]) : IOMMU_NO_PASID;
 	last = FIELD_GET(PRIQ_0_PRG_LAST, evt[0]);
 	grpid = FIELD_GET(PRIQ_1_PRG_IDX, evt[1]);
 
@@ -1742,7 +1742,7 @@ arm_smmu_atc_inv_to_cmd(int ssid, unsigned long iova, size_t size,
 	 */
 	*cmd = (struct arm_smmu_cmdq_ent) {
 		.opcode			= CMDQ_OP_ATC_INV,
-		.substream_valid	= !!ssid,
+		.substream_valid	= (ssid != IOMMU_NO_PASID),
 		.atc.ssid		= ssid,
 	};
 
@@ -1789,7 +1789,7 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master)
 	struct arm_smmu_cmdq_ent cmd;
 	struct arm_smmu_cmdq_batch cmds;
 
-	arm_smmu_atc_inv_to_cmd(0, 0, 0, &cmd);
+	arm_smmu_atc_inv_to_cmd(IOMMU_NO_PASID, 0, 0, &cmd);
 
 	cmds.num = 0;
 	for (i = 0; i < master->num_streams; i++) {
@@ -1869,7 +1869,7 @@ static void arm_smmu_tlb_inv_context(void *cookie)
 		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
 		arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
 	}
-	arm_smmu_atc_inv_domain(smmu_domain, 0, 0, 0);
+	arm_smmu_atc_inv_domain(smmu_domain, IOMMU_NO_PASID, 0, 0);
 }
 
 static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
@@ -1957,7 +1957,7 @@ static void arm_smmu_tlb_inv_range_domain(unsigned long iova, size_t size,
 	 * Unfortunately, this can't be leaf-only since we may have
 	 * zapped an entire table.
 	 */
-	arm_smmu_atc_inv_domain(smmu_domain, 0, iova, size);
+	arm_smmu_atc_inv_domain(smmu_domain, IOMMU_NO_PASID, iova, size);
 }
 
 void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
@@ -2131,7 +2131,7 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	 * the master has been added to the devices list for this domain.
 	 * This isn't an issue because the STE hasn't been installed yet.
 	 */
-	ret = arm_smmu_write_ctx_desc(smmu_domain, 0, &cfg->cd);
+	ret = arm_smmu_write_ctx_desc(smmu_domain, IOMMU_NO_PASID, &cfg->cd);
 	if (ret)
 		goto out_free_cd_tables;
 
@@ -2317,7 +2317,7 @@ static void arm_smmu_enable_ats(struct arm_smmu_master *master)
 	pdev = to_pci_dev(master->dev);
 
 	atomic_inc(&smmu_domain->nr_ats_masters);
-	arm_smmu_atc_inv_domain(smmu_domain, 0, 0, 0);
+	arm_smmu_atc_inv_domain(smmu_domain, IOMMU_NO_PASID, 0, 0);
 	if (pci_enable_ats(pdev, stu))
 		dev_err(master->dev, "Failed to enable ATS (STU %zu)\n", stu);
 }
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index b871a6afd803..4eba9973f537 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -877,7 +877,7 @@ void dmar_fault_dump_ptes(struct intel_iommu *iommu, u16 source_id,
 	}
 	/* For request-without-pasid, get the pasid from context entry */
 	if (intel_iommu_sm && pasid == IOMMU_PASID_INVALID)
-		pasid = PASID_RID2PASID;
+		pasid = IOMMU_NO_PASID;
 
 	dir_index = pasid >> PASID_PDE_SHIFT;
 	pde = &dir[dir_index];
@@ -1457,7 +1457,7 @@ static void __iommu_flush_dev_iotlb(struct device_domain_info *info,
 	qdep = info->ats_qdep;
 	qi_flush_dev_iotlb(info->iommu, sid, info->pfsid,
 			   qdep, addr, mask);
-	quirk_extra_dev_tlb_flush(info, addr, mask, PASID_RID2PASID, qdep);
+	quirk_extra_dev_tlb_flush(info, addr, mask, IOMMU_NO_PASID, qdep);
 }
 
 static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
@@ -1492,7 +1492,7 @@ static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
 		ih = 1 << 6;
 
 	if (domain->use_first_level) {
-		qi_flush_piotlb(iommu, did, PASID_RID2PASID, addr, pages, ih);
+		qi_flush_piotlb(iommu, did, IOMMU_NO_PASID, addr, pages, ih);
 	} else {
 		unsigned long bitmask = aligned_pages - 1;
 
@@ -1562,7 +1562,7 @@ static void intel_flush_iotlb_all(struct iommu_domain *domain)
 		u16 did = domain_id_iommu(dmar_domain, iommu);
 
 		if (dmar_domain->use_first_level)
-			qi_flush_piotlb(iommu, did, PASID_RID2PASID, 0, -1, 0);
+			qi_flush_piotlb(iommu, did, IOMMU_NO_PASID, 0, -1, 0);
 		else
 			iommu->flush.flush_iotlb(iommu, did, 0, 0,
 						 DMA_TLB_DSI_FLUSH);
@@ -1952,7 +1952,7 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 				context_pdts(pds);
 
 		/* Setup the RID_PASID field: */
-		context_set_sm_rid2pasid(context, PASID_RID2PASID);
+		context_set_sm_rid2pasid(context, IOMMU_NO_PASID);
 
 		/*
 		 * Setup the Device-TLB enable bit and Page request
@@ -2432,13 +2432,13 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
 		/* Setup the PASID entry for requests without PASID: */
 		if (hw_pass_through && domain_type_is_si(domain))
 			ret = intel_pasid_setup_pass_through(iommu, domain,
-					dev, PASID_RID2PASID);
+					dev, IOMMU_NO_PASID);
 		else if (domain->use_first_level)
 			ret = domain_setup_first_level(iommu, domain, dev,
-					PASID_RID2PASID);
+					IOMMU_NO_PASID);
 		else
 			ret = intel_pasid_setup_second_level(iommu, domain,
-					dev, PASID_RID2PASID);
+					dev, IOMMU_NO_PASID);
 		if (ret) {
 			dev_err(dev, "Setup RID2PASID failed\n");
 			device_block_translation(dev);
@@ -3975,7 +3975,7 @@ static void dmar_remove_one_dev_info(struct device *dev)
 	if (!dev_is_real_dma_subdevice(info->dev)) {
 		if (dev_is_pci(info->dev) && sm_supported(iommu))
 			intel_pasid_tear_down_entry(iommu, info->dev,
-					PASID_RID2PASID, false);
+					IOMMU_NO_PASID, false);
 
 		iommu_disable_pci_caps(info);
 		domain_context_clear(info);
@@ -4004,7 +4004,7 @@ static void device_block_translation(struct device *dev)
 	if (!dev_is_real_dma_subdevice(dev)) {
 		if (sm_supported(iommu))
 			intel_pasid_tear_down_entry(iommu, dev,
-						    PASID_RID2PASID, false);
+						    IOMMU_NO_PASID, false);
 		else
 			domain_context_clear(info);
 	}
@@ -4339,7 +4339,7 @@ static void domain_set_force_snooping(struct dmar_domain *domain)
 
 	list_for_each_entry(info, &domain->devices, link)
 		intel_pasid_setup_page_snoop_control(info->iommu, info->dev,
-						     PASID_RID2PASID);
+						     IOMMU_NO_PASID);
 }
 
 static bool intel_iommu_enforce_cache_coherency(struct iommu_domain *domain)
@@ -4994,7 +4994,7 @@ void quirk_extra_dev_tlb_flush(struct device_domain_info *info,
 		return;
 
 	sid = PCI_DEVID(info->bus, info->devfn);
-	if (pasid == PASID_RID2PASID) {
+	if (pasid == IOMMU_NO_PASID) {
 		qi_flush_dev_iotlb(info->iommu, sid, info->pfsid,
 				   qdep, address, mask);
 	} else {
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index c5d479770e12..23dca3bc319d 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -438,7 +438,7 @@ devtlb_invalidation_with_pasid(struct intel_iommu *iommu,
 	 * SVA usage, device could do DMA with multiple PASIDs. It is more
 	 * efficient to flush devTLB specific to the PASID.
 	 */
-	if (pasid == PASID_RID2PASID)
+	if (pasid == IOMMU_NO_PASID)
 		qi_flush_dev_iotlb(iommu, sid, pfsid, qdep, 0, 64 - VTD_PAGE_SHIFT);
 	else
 		qi_flush_dev_iotlb_pasid(iommu, sid, pfsid, pasid, qdep, 0, 64 - VTD_PAGE_SHIFT);
diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
index d6b7d21244b1..4e9e68c3c388 100644
--- a/drivers/iommu/intel/pasid.h
+++ b/drivers/iommu/intel/pasid.h
@@ -10,8 +10,6 @@
 #ifndef __INTEL_PASID_H
 #define __INTEL_PASID_H
 
-#define PASID_RID2PASID			0x0
-#define PASID_MIN			0x1
 #define PASID_MAX			0x100000
 #define PASID_PTE_MASK			0x3F
 #define PASID_PTE_PRESENT		1
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index e8c9a7da1060..c714d659d114 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -190,6 +190,7 @@ enum iommu_dev_features {
 	IOMMU_DEV_FEAT_IOPF,
 };
 
+#define IOMMU_NO_PASID	(0U) /* Reserved for DMA w/o PASID */
 #define IOMMU_PASID_INVALID	(-1U)
 typedef unsigned int ioasid_t;
 
-- 
2.25.1

