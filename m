Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4589E6ACC7E
	for <lists+dmaengine@lfdr.de>; Mon,  6 Mar 2023 19:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjCFS0X (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Mar 2023 13:26:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjCFS0V (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Mar 2023 13:26:21 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55EFA7431E;
        Mon,  6 Mar 2023 10:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678127152; x=1709663152;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SYxEnLu9FHhcZWF+7is1RQbEqS+MDzdMBJ+igGqK7HE=;
  b=XNchJy3srTShHJCbv2xJUjV1YFQ4nO4BbtEWRI+oRFzTgL06JB462Zma
   qgrKT+Hv6YjlPRX4MgQHMQT5gBzC80eVC47h0V33uXkkKPVBhI3NmGxAM
   qrcc9N6ucE0bGPTMnya/KqdNYsbPaeHL0E4mkhd3vr6kvzX0G0jSfzJ6x
   8bjByMDaSzK81LYXXW8QxaBhKAfeXIw/MrHwALwcv1+FVVO0rxWJLgSNH
   ziCLSKQeM79/RI3UtbRoK3DQezfq6OeDL85tuTawUZt4CRhBNhLo4WeRO
   XpMWOavR5x9PvSLDXOpZ9T7MpZx1LS5jF6trIL2/mFhVaWTFJgSPM4/qR
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="421911937"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="421911937"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 10:25:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="819396352"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="819396352"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 10:25:09 -0800
Date:   Mon, 6 Mar 2023 10:29:00 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 1/4] iommu/vt-d: Implement set device pasid op for
 default domain
Message-ID: <20230306102900.0fa3a4b2@jacob-builder>
In-Reply-To: <c54aebf7-4282-b8a6-f03b-03af2deea59c@linux.intel.com>
References: <20230302005959.2695267-1-jacob.jun.pan@linux.intel.com>
        <20230302005959.2695267-2-jacob.jun.pan@linux.intel.com>
        <fad7f28f-b4e8-c1c3-4ca4-a48c5c6d7f4a@linux.intel.com>
        <BN9PR11MB527627C597F6478536477A8F8CB39@BN9PR11MB5276.namprd11.prod.outlook.com>
        <20230303083512.663ce758@jacob-builder>
        <c54aebf7-4282-b8a6-f03b-03af2deea59c@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Baolu,

On Sun, 5 Mar 2023 11:05:50 +0800, Baolu Lu <baolu.lu@linux.intel.com>
wrote:

> On 3/4/23 12:35 AM, Jacob Pan wrote:
> >>> From: Baolu Lu<baolu.lu@linux.intel.com>
> >>> Sent: Thursday, March 2, 2023 10:07 PM
> >>>      
> >>>> +
> >>>> +	if (hw_pass_through && domain_type_is_si(dmar_domain))
> >>>> +		ret = intel_pasid_setup_pass_through(iommu,
> >>>> dmar_domain,
> >>>> +						     dev, pasid);
> >>>> +	else if (dmar_domain->use_first_level)
> >>>> +		ret = domain_setup_first_level(iommu, dmar_domain,
> >>>> +					       dev, pasid);
> >>>> +	else
> >>>> +		ret = intel_pasid_setup_second_level(iommu,
> >>>> dmar_domain,
> >>>> +						     dev, pasid);
> >>>> +
> >>>> +	return ret;
> >>>> +}  
> >>> Do you need to consider pasid cache invalidation?
> >>>      
> >> To avoid confusion this is not about invalidation of pasid cache itself
> >> which should be covered by above setup functions already.
> >>
> >> Here actually means per-PASID invalidation in iotlb and devtlb. Today
> >> only RID is tracked per domain for invalidation. it needs extension to
> >> walk attached pasid too.  
> > Yes, will add.
> > 
> > For the set up path, there is no need to flush IOTLBs,  because we're
> > going from non present to present.
> > 
> > On the remove path, IOTLB flush should be covered when device driver
> > calls iommu_detach_device_pasid(). Covered with this patch.  
> 
> It's not only for the PASID teardown path, but also for unmap(). As the
> device has issued DMA requests with PASID, the IOMMU probably will cache
> the DMA translation with PASID tagged. Hence, we need to invalidate the
> PASID-specific IOTLB and device TLB in the unmap() path.
> 
> I once had a patch for this:
> 
> https://lore.kernel.org/linux-iommu/20220614034411.1634238-1-baolu.lu@linux.intel.com/
> 
> Probably you can use it as a starting point.
understood, actually my previous version had unmap flush, based on yours as
well.
https://lore.kernel.org/lkml/20220518182120.1136715-1-jacob.jun.pan@linux.intel.com/T/
> 
> Best regards,
> baolu


Thanks,

Jacob
