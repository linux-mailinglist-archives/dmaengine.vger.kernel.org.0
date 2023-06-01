Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD607196E3
	for <lists+dmaengine@lfdr.de>; Thu,  1 Jun 2023 11:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbjFAJ0p (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 1 Jun 2023 05:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbjFAJ0n (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 1 Jun 2023 05:26:43 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D3511F
        for <dmaengine@vger.kernel.org>; Thu,  1 Jun 2023 02:26:41 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f3b4ed6fdeso623644e87.3
        for <dmaengine@vger.kernel.org>; Thu, 01 Jun 2023 02:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685611599; x=1688203599;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zVFNX3zBr144yloFjBpc+DF1izqPZvrTSNy+oaQ0gEw=;
        b=jFmfkxombN6/nnnv1lrM8/pSBthA85NbrMdUkWp3PeiSm3qEMBTWzTvyfHruvO207f
         Z/hpkndz9S7tiA+hegXOTR3WUeu+X+eWMwfkD0aFYm86Qu/h+kLt3fXrzYNnGzo0ipYy
         3Mh0eUvdyJBMD6PLhGYPrArORLVhznQ6L8SivJnJjCbBoKmHFIZTIoAzlbWwsQ2QX+6z
         lztu5y0YI3YnAHZqRBD9he341Xsu++9+2ZSnxcP6wIfnNhDjxJ/3c0nG9pyvAGyoDGuQ
         0dZl9BsUhQz7zeeQ+cdmV86LwzkSNaJo+2nx4sa6zxCM5fQiDi0/NQuwhlf2j1zT3ILF
         BysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685611599; x=1688203599;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zVFNX3zBr144yloFjBpc+DF1izqPZvrTSNy+oaQ0gEw=;
        b=LsWkXELvo4aqgPm5rYugPXJT6OhDp6CtXnovNtCkW6uOrCsqLB3avICQ7sTD5NsHIT
         CDb4PxXEvxsEaCwlAcX24jEEGcUMRX6ruNIB/AVNHV6fgW3ERh/X2a/nJyBzr/pY58Ah
         ziy14uddvwzgKDaD0tKVRB4/YZQNoeWe7TDGbOmyxUxx9QGdGSi1y2u4k2RR+JRkegtl
         6/ev8Ob2fV0b+V037aA5Fxjan40Q4YoyqO+vkK5nf0tXgv2yjc7E6wIbdxYpLjieLKb4
         tbUBMFwsCB+j5uJh3LEfbu9kG76opKWKN43sf7GOKpuKUZv/QIOUBv6pVhqt+lDAkZ/F
         Qrtg==
X-Gm-Message-State: AC+VfDzWzrRec8dz6Ab2Jh+DLZASDahYTBdVj+3CV6+4M1/n8hnnUcZl
        xtpnhGqjjlIfXTRv9Z0f1ZD2BQ==
X-Google-Smtp-Source: ACHHUZ6qUwSfXgjFll3OhFMDEEdvNv/jw2fpES6Wr4ZhOXI3g9wDa0fPGHI9DGQf//Q45HEyfRrqKA==
X-Received: by 2002:ac2:5306:0:b0:4ee:5aeb:e2f2 with SMTP id c6-20020ac25306000000b004ee5aebe2f2mr885985lfh.38.1685611599527;
        Thu, 01 Jun 2023 02:26:39 -0700 (PDT)
Received: from myrica (5750a5b3.skybroadband.com. [87.80.165.179])
        by smtp.gmail.com with ESMTPSA id 8-20020a05600c230800b003f6cf9afc25sm1651626wmo.40.2023.06.01.02.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 02:26:38 -0700 (PDT)
Date:   Thu, 1 Jun 2023 10:26:34 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        dmaengine@vger.kernel.org, vkoul@kernel.org,
        Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        narayan.ranganathan@intel.com
Subject: Re: [PATCH v7 1/4] iommu: Generalize PASID 0 for normal DMA w/o PASID
Message-ID: <20230601092634.GA3059361@myrica>
References: <20230523173451.2932113-1-jacob.jun.pan@linux.intel.com>
 <20230523173451.2932113-2-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523173451.2932113-2-jacob.jun.pan@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Jacob,

On Tue, May 23, 2023 at 10:34:48AM -0700, Jacob Pan wrote:
> PCIe Process address space ID (PASID) is used to tag DMA traffic, it
> provides finer grained isolation than requester ID (RID).
> 
> For each device/RID, 0 is a special PASID for the normal DMA (no
> PASID). This is universal across all architectures that supports PASID,
> therefore warranted to be reserved globally and declared in the common
> header. Consequently, we can avoid the conflict between different PASID
> use cases in the generic code. e.g. SVA and DMA API with PASIDs.
> 
> This paved away for device drivers to choose global PASID policy while
> continue doing normal DMA.
> 
> Noting that VT-d could support none-zero RID/NO_PASID, but currently not
> used.
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
> v7:
>    - renamed IOMMU_DEF_RID_PASID to be IOMMU_NO_PASID to be more generic
> v6:
>    - let SMMU code use the common RID_PASID macro
> ---
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  2 +-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 10 ++++----
>  drivers/iommu/intel/iommu.c                   | 24 +++++++++----------
>  drivers/iommu/intel/pasid.c                   |  2 +-
>  drivers/iommu/intel/pasid.h                   |  1 -
>  include/linux/iommu.h                         |  1 +
>  6 files changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> index a5a63b1c947e..5e6b39881c04 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> @@ -80,7 +80,7 @@ arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
>  	 * be some overlap between use of both ASIDs, until we invalidate the
>  	 * TLB.
>  	 */
> -	arm_smmu_write_ctx_desc(smmu_domain, 0, cd);
> +	arm_smmu_write_ctx_desc(smmu_domain, IOMMU_NO_PASID, cd);
>  
>  	/* Invalidate TLB entries previously associated with that context */
>  	arm_smmu_tlb_inv_asid(smmu, asid);
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 3fd83fb75722..6d64c8fc923f 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1053,7 +1053,7 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
>  	/*
>  	 * This function handles the following cases:
>  	 *
> -	 * (1) Install primary CD, for normal DMA traffic (SSID = 0).
> +	 * (1) Install primary CD, for normal DMA traffic (SSID = IOMMU_NO_PASID = 0).
>  	 * (2) Install a secondary CD, for SID+SSID traffic.
>  	 * (3) Update ASID of a CD. Atomically write the first 64 bits of the
>  	 *     CD, then invalidate the old entry and mappings.
> @@ -1869,7 +1869,7 @@ static void arm_smmu_tlb_inv_context(void *cookie)
>  		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
>  		arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
>  	}
> -	arm_smmu_atc_inv_domain(smmu_domain, 0, 0, 0);
> +	arm_smmu_atc_inv_domain(smmu_domain, IOMMU_NO_PASID, 0, 0);
>  }
>  
>  static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
> @@ -1957,7 +1957,7 @@ static void arm_smmu_tlb_inv_range_domain(unsigned long iova, size_t size,
>  	 * Unfortunately, this can't be leaf-only since we may have
>  	 * zapped an entire table.
>  	 */
> -	arm_smmu_atc_inv_domain(smmu_domain, 0, iova, size);
> +	arm_smmu_atc_inv_domain(smmu_domain, IOMMU_NO_PASID, iova, size);
>  }
>  
>  void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
> @@ -2131,7 +2131,7 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
>  	 * the master has been added to the devices list for this domain.
>  	 * This isn't an issue because the STE hasn't been installed yet.
>  	 */
> -	ret = arm_smmu_write_ctx_desc(smmu_domain, 0, &cfg->cd);
> +	ret = arm_smmu_write_ctx_desc(smmu_domain, IOMMU_NO_PASID, &cfg->cd);
>  	if (ret)
>  		goto out_free_cd_tables;
>  
> @@ -2317,7 +2317,7 @@ static void arm_smmu_enable_ats(struct arm_smmu_master *master)
>  	pdev = to_pci_dev(master->dev);
>  
>  	atomic_inc(&smmu_domain->nr_ats_masters);
> -	arm_smmu_atc_inv_domain(smmu_domain, 0, 0, 0);
> +	arm_smmu_atc_inv_domain(smmu_domain, IOMMU_NO_PASID, 0, 0);
>  	if (pci_enable_ats(pdev, stu))
>  		dev_err(master->dev, "Failed to enable ATS (STU %zu)\n", stu);
>  }

Thanks, I think this makes the code clearer. For consistency you could
also add these:

---
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 6d64c8fc923fc..c977106357961 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
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
---

With that, for SMMU:

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
