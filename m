Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7636A8970
	for <lists+dmaengine@lfdr.de>; Thu,  2 Mar 2023 20:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjCBTVb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Mar 2023 14:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCBTVa (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 2 Mar 2023 14:21:30 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7C739B9D;
        Thu,  2 Mar 2023 11:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677784889; x=1709320889;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=185T5+NRzBkDdWR4gv2cKMGAHH4lIzpAm3CJgwITzls=;
  b=a7VuexwhX5s0l+fIOYGR7e0iHkuPUOobyW+CTWjfRX2ZbxSmV0SiSjqT
   83Md6norXdI0NkamvYBKUh+MHlSvf5MXyzg2fvmKqt9E9rhmWFa+haPDG
   2BTsztIBfY9p+OeL1Uby2rT27Ks5ZkLLIspgiD9iPteq5F5yupY1XzEPC
   eAoJ4V6xDAliEJkkkaSztx33HefLAZCfGBZTKi16keHfv1BcLYWS6mE8h
   flscoL7lENM288JDAQnTTYmrLfkpraer1t2wP0Hb4ri8X99F5IzHN0rpC
   de0EmBjdqoVg2Ni9jOdIijky7Ii3PXMLGsKlcncmwWoIXBittRRCxibi8
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="318647371"
X-IronPort-AV: E=Sophos;i="5.98,228,1673942400"; 
   d="scan'208";a="318647371"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 11:21:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="764136375"
X-IronPort-AV: E=Sophos;i="5.98,228,1673942400"; 
   d="scan'208";a="764136375"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 11:21:28 -0800
Date:   Thu, 2 Mar 2023 11:25:17 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        "David Woodhouse" <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 1/4] iommu/vt-d: Implement set device pasid op for
 default domain
Message-ID: <20230302112517.17819fb2@jacob-builder>
In-Reply-To: <BN9PR11MB52760B805DDD6CC70C0E1D6D8CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230302005959.2695267-1-jacob.jun.pan@linux.intel.com>
        <20230302005959.2695267-2-jacob.jun.pan@linux.intel.com>
        <BN9PR11MB52760B805DDD6CC70C0E1D6D8CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Kevin,

On Thu, 2 Mar 2023 09:37:30 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Thursday, March 2, 2023 9:00 AM
> > 
> > @@ -4675,6 +4679,33 @@ static void
> > intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
> >  	intel_pasid_tear_down_entry(iommu, dev, pasid, false);
> >  }
> > 
> > +static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
> > +				   struct device *dev, ioasid_t pasid)
> > +{
> > +	struct device_domain_info *info = dev_iommu_priv_get(dev);
> > +	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
> > +	struct intel_iommu *iommu = info->iommu;
> > +	int ret = 0;
> > +
> > +	if (!sm_supported(iommu) || !info)
> > +		return -ENODEV;
> > +
> > +	if (WARN_ON(pasid == PASID_RID2PASID))
> > +		return -EINVAL;
> > +
> > +	if (hw_pass_through && domain_type_is_si(dmar_domain))
> > +		ret = intel_pasid_setup_pass_through(iommu,
> > dmar_domain,
> > +						     dev, pasid);
> > +	else if (dmar_domain->use_first_level)
> > +		ret = domain_setup_first_level(iommu, dmar_domain,
> > +					       dev, pasid);
> > +	else
> > +		ret = intel_pasid_setup_second_level(iommu,
> > dmar_domain,
> > +						     dev, pasid);
> > +  
> 
> check whether pasid capability has been enabled on this device.
> 
> it's unlike SVA which has separate capability to tell.
yes, it is a little tricky in that enabling PASID should be done before ATS
but for now anything uses ENQCMDS should support ATS. I will add
	/*
	 * PASID should be enabled as part of PCI caps enabling where
	 * ordering is required relative to ATS.
	 */
	if (WARN_ON(!pdev->pasid_enabled))
		return -ENODEV;

Thanks,

Jacob
