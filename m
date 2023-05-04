Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B857C6F783A
	for <lists+dmaengine@lfdr.de>; Thu,  4 May 2023 23:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjEDVeu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 4 May 2023 17:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjEDVep (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 4 May 2023 17:34:45 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B514713C1E;
        Thu,  4 May 2023 14:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683236084; x=1714772084;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EP+qQVPq1TXsIe51i7OOoP+qvywU7gMPQc8clIWQK4s=;
  b=lHV9BfJQ6q8LxVpEe3RsmCKsH0AvNqEI/xYZAs3RRP5BkCjdimt3kOR7
   VgRghuxY894usLDupH1af7/h2NVFDcRjuSBpMeWTQnf22yW1/9AJHBO1e
   UTemnGA39yRZCkUXXsa84GLQ/l+ekTxCSJTHT3tBBHY7Xm8iWK9ffuwk0
   oMTy7HjaHPgALAN6RbokJFxjvtT9Iath4eH6e9DOnXwxKmdbpPk6iJCKS
   Tizj1Yp7vWISKAAW4UyNv9+YSDNijXuSc5zPzxm0Y7ea7lXNb1PIeusNl
   W+ViWylCNlQeiEdqE+3ic6lxp+syqOregW/pUk0kc5BSVrRsNostl2BpW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="414585942"
X-IronPort-AV: E=Sophos;i="5.99,250,1677571200"; 
   d="scan'208";a="414585942"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 14:34:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="943531835"
X-IronPort-AV: E=Sophos;i="5.99,250,1677571200"; 
   d="scan'208";a="943531835"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 14:34:43 -0700
Date:   Thu, 4 May 2023 14:39:05 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        "Ranganathan, Narayan" <narayan.ranganathan@intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v5 4/7] iommu/vt-d: Factoring out PASID set up helper
 function
Message-ID: <20230504143905.66fd14c7@jacob-builder>
In-Reply-To: <9fb1c0dd-ea78-a3f7-9eac-3154f5d08ad5@linux.intel.com>
References: <20230427174937.471668-1-jacob.jun.pan@linux.intel.com>
        <20230427174937.471668-5-jacob.jun.pan@linux.intel.com>
        <BN9PR11MB5276726E67301703BD10833B8C6B9@BN9PR11MB5276.namprd11.prod.outlook.com>
        <9fb1c0dd-ea78-a3f7-9eac-3154f5d08ad5@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Baolu,

On Wed, 3 May 2023 14:37:16 +0800, Baolu Lu <baolu.lu@linux.intel.com>
wrote:

> On 4/28/23 5:47 PM, Tian, Kevin wrote:
> >> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> >> Sent: Friday, April 28, 2023 1:50 AM
> >>
> >>
> >> +static int dmar_domain_attach_device_pasid(struct dmar_domain *domain,
> >> +					   struct intel_iommu *iommu,
> >> +					   struct device *dev,
> >> ioasid_t pasid) +{
> >> +	int ret;
> >> +
> >> +	/* PASID table is mandatory for a PCI device in scalable
> >> mode. */
> >> +	if (!sm_supported(iommu) && dev_is_real_dma_subdevice(dev))
> >> +		return -EOPNOTSUPP;  
> > 
> > "&&" should be "||"
> >   
> 
> Also should return success instead if this is a RID case. Perhaps,
> 
> 	if (!sm_supported(iommu) || dev_is_real_dma_subdevice(dev))
> 		return pasid == RID2PASID ? 0 : -EOPNOTSUPP;
> 
Yeah,  I think this is better.  will do.

I was hoping not to treat RIDPASID special here. The caller of this
function does the check if that is RIDPASID but code is duplicated.

Thanks,

Jacob
