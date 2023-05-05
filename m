Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B386F8A24
	for <lists+dmaengine@lfdr.de>; Fri,  5 May 2023 22:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbjEEU2C (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 5 May 2023 16:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjEEU2B (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 5 May 2023 16:28:01 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE6A40FB;
        Fri,  5 May 2023 13:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683318479; x=1714854479;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=attubp1Y5SHGM2s6fxrjpGYDxEhvZVo+MggS/87KNmo=;
  b=S0BIIfpSuK978Q+FSEQb84SjBLw4FRB/sdbeE0ywaWOmYS8b9kDlGDKy
   Dxe1H/3odER7prUYg/cTQS1xpK4gcf0IjV23DyiyLM36fEqeuHpg/+vbg
   64u0zIk1+YR0DUxCDQtxrUx2HnbSJxXe818iIMlvFqkFvkV+HJA5gWtAv
   tKIC5OLs5Ck50m/q4BL69ePOHIMLzliIx5frb8UoNcnbTMCyR8ZaSSZWe
   fc+lsPfddsgOG2vcZj/imvOm4/byvxizkFjfN3a1CT0DKj2lHrfHzL+e7
   sSkFpQyyMHpyrg59YnsaOprVSL/XnvTkDrEKfuXZzEb4p4lTjz+0elaeT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="338495577"
X-IronPort-AV: E=Sophos;i="5.99,253,1677571200"; 
   d="scan'208";a="338495577"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 13:27:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="767259577"
X-IronPort-AV: E=Sophos;i="5.99,253,1677571200"; 
   d="scan'208";a="767259577"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 13:27:39 -0700
Date:   Fri, 5 May 2023 13:32:02 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>, dmaengine@vger.kernel.org,
        vkoul@kernel.org, Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        narayan.ranganathan@intel.com, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v5 6/7] iommu/vt-d: Implement set_dev_pasid domain op
Message-ID: <20230505133202.094bf8be@jacob-builder>
In-Reply-To: <35ceffc2-e306-6215-e90a-43548f6feca6@linux.intel.com>
References: <20230427174937.471668-1-jacob.jun.pan@linux.intel.com>
        <20230427174937.471668-7-jacob.jun.pan@linux.intel.com>
        <76c98e62-1cac-2ab6-7721-08ec2c1fceb8@linux.intel.com>
        <20230504160334.496085db@jacob-builder>
        <35ceffc2-e306-6215-e90a-43548f6feca6@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Baolu,

On Fri, 5 May 2023 10:58:38 +0800, Baolu Lu <baolu.lu@linux.intel.com>
wrote:

> On 5/5/23 7:03 AM, Jacob Pan wrote:
> >>> +static int intel_iommu_attach_device_pasid(struct iommu_domain
> >>> *domain,
> >>> +					   struct device *dev,
> >>> ioasid_t pasid) +{
> >>> +	struct device_domain_info *info = dev_iommu_priv_get(dev);
> >>> +	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
> >>> +	struct intel_iommu *iommu = info->iommu;
> >>> +	int ret;
> >>> +
> >>> +	if (!pasid_supported(iommu))
> >>> +		return -ENODEV;
> >>> +
> >>> +	ret = prepare_domain_attach_device(domain, dev);
> >>> +	if (ret)
> >>> +		return ret;
> >>> +
> >>> +	/*
> >>> +	 * Most likely the device context has already been set up,
> >>> will only
> >>> +	 * take a domain ID reference. Otherwise, device context will
> >>> be set
> >>> +	 * up here.  
> >> The "otherwise" case is only default domain deferred attaching case,
> >> right?  
> > it might be the only case so far, but my intention is to be general.
> > i.e. no ordering requirements. I believe it is more future proof in case
> > device_attach_pasid called before device_attach.  
> 
> Let's put aside deferred attach and talk about it later.
> 
> The device's context entry is configured when the default domain is
> being attached to the device. And, the default domain attaching is in
> the iommu probe_device path. It always happens before set_device_pasid
> which is designed to be called by the device driver. So the real
> situation is that when the device driver calls set_device_pasid, the
> context entry should already have been configured.
> 
> Then let's pick up the deferred attach case. It is a workaround for
> kdump (Documentation/admin-guide/kdump/kdump.rst). I don't think PASID
> feature is functionally required by any kdump capture kernel as its
> main purpose is to dump the memory of a panic kernel.
> 
> In summary, it seems to be reasonable for the vt-d driver to return
> -EBUSY when a device's context was copied. The idxd driver should
> continue to work without kernel DMA with PASID support.
> 
> 	if (context_copied(iommu, bus, devfn))
> 		return -EBUSY;
> 
> Make things general is always good, but this doesn't mean that we need
> to make the code complex to support cases that do not exist or are not
> used. Thoughts?
> 
Good point, it is better not put dead code in. Let me also document this
behavior for future change that may affect the ordering requirement.

Thanks,

Jacob
