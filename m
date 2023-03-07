Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E113D6AD961
	for <lists+dmaengine@lfdr.de>; Tue,  7 Mar 2023 09:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjCGIlE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Mar 2023 03:41:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjCGIlA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 Mar 2023 03:41:00 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166F1460A9
        for <dmaengine@vger.kernel.org>; Tue,  7 Mar 2023 00:40:58 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id k37so7261958wms.0
        for <dmaengine@vger.kernel.org>; Tue, 07 Mar 2023 00:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678178456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+0UKndbP14gZjHXMQXXDLbDlp36Mnb3xL7pi3Fj5BQw=;
        b=P3b/7PQEXKyg73nyy4qZAscI5K/g2NnKp93Uh+3PIwOrasFJedSSjOLLd1bd903q4c
         HMysVB702K66d76WiAOLkWrWKNwQiTrGtWV+zjvvDevRqA/j/TkzdsNPog4+X+2JOVdv
         6gADtaQnNjnFICS84aOnziUt5awhzqAGZqsHGnkn8OIdIlFOntuSLRjggSpM6PqXcx59
         /8lOei7vUv42kDrAjnMiBC7LIIcqDvehKjClc6DGa9ZbjLhXPRt2+ibjyeKoKcTOTChL
         enw/VngLPJjqIKyEXmHn3YnrusHkHqvLFG590sGP1UnlFiihReClvyytQGXC6l98zu7Z
         qexg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678178456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+0UKndbP14gZjHXMQXXDLbDlp36Mnb3xL7pi3Fj5BQw=;
        b=74PnC0XYc4I7+OMopRNwHRo+LT6MfdslXU8sdc9HmFhw0y2TFxZ2GJBOCQ0Ub1PM+F
         1+4Wo/B08Mk8ihjNavPsFD9Y+2UmwLyTkws0EGalwwddCOq9v1IlQErWitLY2DFxQV0A
         vfgClYycVgpg8cdYwGq4re4nRlCH3QEUpDRCXMG58O4rNPh0hDZm280bxvD68p42F9SM
         dnuvZP6TqNTNgx/g/yVKhIMFqu7U83OgR5diwrEMBR4kyX096rV+2u6u+Gh06eBbBNVA
         QbiHwBZb3JkAC68+gUqRKFKBMaxrFGylkgWYHSZ8xZbxA8EN+FE68MXYNC+d64D8OcmT
         K2RQ==
X-Gm-Message-State: AO0yUKWZhdl9ZCs4+34W6mGeNC1Oe5tOXeHwk3qksiaYHqLQdxJGxZiC
        LMjzuMeA1Fmxsa/csXiO3MZolg==
X-Google-Smtp-Source: AK7set+52QDU/ZyulReQ++I2BeOAZ7h56nRoRwlNzYV9UZ5O+BKWRWrAUuleGQszagPqAWonnp2Bbg==
X-Received: by 2002:a05:600c:1c1f:b0:3eb:3b7e:7b89 with SMTP id j31-20020a05600c1c1f00b003eb3b7e7b89mr12353899wms.3.1678178456567;
        Tue, 07 Mar 2023 00:40:56 -0800 (PST)
Received: from myrica (054592b0.skybroadband.com. [5.69.146.176])
        by smtp.gmail.com with ESMTPSA id l8-20020a05600c4f0800b003b47b80cec3sm18273948wmq.42.2023.03.07.00.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 00:40:56 -0800 (PST)
Date:   Tue, 7 Mar 2023 08:40:58 +0000
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
        dmaengine@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alistair Popple <apopple@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>, iommu@lists.linux.dev
Subject: Re: [PATCH v2 08/16] iommu: define and export
 iommu_access_remote_vm()
Message-ID: <20230307084058.GA1330745@myrica>
References: <20230306163138.587484-1-fenghua.yu@intel.com>
 <20230306163138.587484-9-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306163138.587484-9-fenghua.yu@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Fenghua,

On Mon, Mar 06, 2023 at 08:31:30AM -0800, Fenghua Yu wrote:
> Define and export iommu_access_remote_vm() to allow IOMMU related
> drivers to access user address space by PASID.
> 
> The IDXD driver would like to use it to write the user's completion
> record that the hardware device is not able to write to due to user
> page fault.
> 
> Without the API, it's complex for IDXD driver to copy completion record
> to a process' fault address for two reasons:
> 1. access_remote_vm() is not exported and shouldn't be exported for
>    drivers because drivers may easily cause mm reference issue.
> 2. user frees fault address pages to trigger fault by IDXD device.
> 
> The driver has to call iommu_sva_find(), kthread_use_mm(), re-implement
> majority of access_remote_vm() etc to access remote vm.
> 
> This IOMMU specific API hides these details and provides a clean interface
> for idxd driver and potentially other IOMMU related drivers.
> 
> Suggested-by: Alistair Popple <apopple@nvidia.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: Lorenzo Stoakes <lstoakes@gmail.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: iommu@lists.linux.dev
> ---
> v2:
> - Define and export iommu_access_remote_vm() for IDXD driver to write
>   completion record to user address space. This change removes
>   patch 8 and 9 in v1 (Alistair Popple)
> 
>  drivers/iommu/iommu-sva.c | 35 +++++++++++++++++++++++++++++++++++
>  include/linux/iommu.h     |  9 +++++++++
>  2 files changed, 44 insertions(+)
> 
> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> index 24bf9b2b58aa..1d7a0aee58f7 100644
> --- a/drivers/iommu/iommu-sva.c
> +++ b/drivers/iommu/iommu-sva.c
> @@ -71,6 +71,41 @@ struct mm_struct *iommu_sva_find(ioasid_t pasid)
>  }
>  EXPORT_SYMBOL_GPL(iommu_sva_find);
>  
> +/**
> + * iommu_access_remote_vm - access another process' address space by PASID
> + * @pasid:	Process Address Space ID assigned to the mm
> + * @addr:	start address to access
> + * @buf:	source or destination buffer
> + * @len:	number of bytes to transfer
> + * @gup_flags:	flags modifying lookup behaviour
> + *
> + * Another process' address space is found by PASID. A reference on @mm
> + * is taken and released inside the function.
> + *
> + * Return: number of bytes copied from source to destination.
> + */
> +int iommu_access_remote_vm(ioasid_t pasid, unsigned long addr, void *buf,
> +			   int len, unsigned int gup_flags)
> +{
> +	struct mm_struct *mm;
> +	int copied;
> +
> +	mm = iommu_sva_find(pasid);

The ability to find a mm by PASID is being removed, see 
https://lore.kernel.org/linux-iommu/20230301235646.2692846-4-jacob.jun.pan@linux.intel.com/

Thanks,
Jean

> +	if (IS_ERR_OR_NULL(mm))
> +		return 0;
> +
> +	/*
> +	 * A reference on @mm has been held by mmget_not_zero()
> +	 * during iommu_sva_find().
> +	 */
> +	copied = access_remote_vm(mm, addr, buf, len, gup_flags);
> +	/* The reference is released. */
> +	mmput(mm);
> +
> +	return copied;
> +}
> +EXPORT_SYMBOL_GPL(iommu_access_remote_vm);
> +
>  /**
>   * iommu_sva_bind_device() - Bind a process address space to a device
>   * @dev: the device
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 6595454d4f48..414a46a53799 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -1177,6 +1177,8 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev,
>  					struct mm_struct *mm);
>  void iommu_sva_unbind_device(struct iommu_sva *handle);
>  u32 iommu_sva_get_pasid(struct iommu_sva *handle);
> +int iommu_access_remote_vm(ioasid_t pasid, unsigned long addr, void *buf,
> +			   int len, unsigned int gup_flags);
>  #else
>  static inline struct iommu_sva *
>  iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
> @@ -1192,6 +1194,13 @@ static inline u32 iommu_sva_get_pasid(struct iommu_sva *handle)
>  {
>  	return IOMMU_PASID_INVALID;
>  }
> +
> +static inline int iommu_access_remote_vm(ioasid_t pasid, unsigned long addr,
> +					 void *buf, int len,
> +					 unsigned int gup_flags)
> +{
> +	return 0;
> +}
>  #endif /* CONFIG_IOMMU_SVA */
>  
>  #endif /* __LINUX_IOMMU_H */
> -- 
> 2.37.1
> 
> 
