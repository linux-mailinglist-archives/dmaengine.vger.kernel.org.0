Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18CA46E4E82
	for <lists+dmaengine@lfdr.de>; Mon, 17 Apr 2023 18:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjDQQpX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Apr 2023 12:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjDQQpW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 17 Apr 2023 12:45:22 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB247AB9;
        Mon, 17 Apr 2023 09:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681749921; x=1713285921;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mejMMiNRr2sdE/HkEC1Fb36Btw2PJ43aaguwXoKkpZo=;
  b=JMSCSx47KBmAR56jqhazXIuEFLvCftJ7Jr3e7ZsIR0tb6awXNERevdz0
   yhJj+eYUMnsqrIMgVQnnaDJbdXv2QRMksyu2X+Fl/dqi9DeRxkSRbGrE5
   GZh0mcQFPj/OUrO3fW+VmZG3GeRDQktHSc04pMoMqvpmzzFG4DqFlgpB6
   Lf40MmVsy9O37b83Cn07lLKAiQENOgUMgEEaqDcsfmbi8snELitQdDAu1
   DRcFRGUmsycb8IEBjb5QY7rUMI6n3JEA48N1f/iVflDxouo6tSMDzVun6
   CtNZuY9RaBS+lWkFON/mpzKsdyDQRydTAL2hKKxrzenaaMNuigmOYU9ul
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="347685912"
X-IronPort-AV: E=Sophos;i="5.99,204,1677571200"; 
   d="scan'208";a="347685912"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 09:42:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="640989218"
X-IronPort-AV: E=Sophos;i="5.99,204,1677571200"; 
   d="scan'208";a="640989218"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 09:42:16 -0700
Date:   Mon, 17 Apr 2023 09:46:29 -0700
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
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v4 3/7] iommu: Support allocation of global PASIDs
 outside SVA
Message-ID: <20230417094629.59fcfde6@jacob-builder>
In-Reply-To: <5882ee52-9657-250d-0474-13edffa7b6b9@linux.intel.com>
References: <20230407180554.2784285-1-jacob.jun.pan@linux.intel.com>
        <20230407180554.2784285-4-jacob.jun.pan@linux.intel.com>
        <BN9PR11MB5276D09F18BA65AD074777948C9A9@BN9PR11MB5276.namprd11.prod.outlook.com>
        <5882ee52-9657-250d-0474-13edffa7b6b9@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Baolu,

On Wed, 12 Apr 2023 09:37:48 +0800, Baolu Lu <baolu.lu@linux.intel.com>
wrote:

> On 4/11/23 4:02 PM, Tian, Kevin wrote:
> >> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> >> Sent: Saturday, April 8, 2023 2:06 AM
> >> @@ -28,8 +26,8 @@ static int iommu_sva_alloc_pasid(struct mm_struct
> >> *mm, ioasid_t min, ioasid_t ma
> >>   		goto out;
> >>   	}
> >>
> >> -	ret = ida_alloc_range(&iommu_global_pasid_ida, min, max,
> >> GFP_KERNEL);
> >> -	if (ret < min)
> >> +	ret = iommu_alloc_global_pasid(min, max);  
> > 
> > I wonder whether this can take a device pointer so
> > dev->iommu->max_pasids is enforced inside the alloc function.  
> 
> Agreed. Instead of using the open code, it looks better to have a helper
> like dev_iommu_max_pasids().
yes, probably export dev_iommu_get_max_pasids(dev)?

But if I understood Kevin correctly, he's also suggesting that the
interface should be changed to iommu_alloc_global_pasid(dev), my concern is
that how do we use this function to reserve RID_PASID which is not specific
to a device?

> 
> > 
> > and do we even need the min/max parameters? With special pasids reserved
> > then what driver needs is just to get a free pasid from the global
> > space within dev->iommu->max_pasids constraint...
> > 
> > iommu_sva_alloc_pasid() can be reworked to avoid min/max by taking a
> > device pointer too.  
> 
> Best regards,
> baolu


Thanks,

Jacob
