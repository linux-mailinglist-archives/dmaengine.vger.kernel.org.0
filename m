Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9F56B2BA1
	for <lists+dmaengine@lfdr.de>; Thu,  9 Mar 2023 18:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjCIRIb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 9 Mar 2023 12:08:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbjCIRIK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 9 Mar 2023 12:08:10 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE96E6D9B;
        Thu,  9 Mar 2023 09:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678381491; x=1709917491;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7G0O80eoi717307ESCF3NXvsdQ1Hks/w/yE5W6NxlwA=;
  b=hu4T1vRH2Jr7FYKWqEjn6k0D8EmqaPKqTGlTkl/iETZewK9CgcEKPdsM
   BLsaEJEA+vlopVrbRsUWfrqhsItEUtHlWEXTLksCmKjlcAfEbDpgJCHh4
   jEIapWZjzsNjb/NuKvsJUF5z/SSEzxIh6FI4ElKTW13jtSXmYljcHrHgL
   W41DSFVzpYImffTa/wk303nIZ8LK5b2OxRkz7QaHnfaj+pmEynvmOUcI3
   50bMbWammJihTBpqLru+ihoZcYhATQ+Re9arbzjgcevHR+BQAZDQThyjq
   PVL8OQTdkqqUWpcNBwDmLcAApYHrY0xiTrf0M1MMJIz310YNwaMWSaORv
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="333975373"
X-IronPort-AV: E=Sophos;i="5.98,247,1673942400"; 
   d="scan'208";a="333975373"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 09:02:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="787663874"
X-IronPort-AV: E=Sophos;i="5.98,247,1673942400"; 
   d="scan'208";a="787663874"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 09:02:31 -0800
Date:   Thu, 9 Mar 2023 09:06:23 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Lu Baolu <baolu.lu@linux.intel.com>,
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
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 3/4] iommu/sva: Support reservation of global PASIDs
Message-ID: <20230309090623.7ea2c3fe@jacob-builder>
In-Reply-To: <ZAY5d2MSXjWRGF0n@nvidia.com>
References: <20230302005959.2695267-1-jacob.jun.pan@linux.intel.com>
        <20230302005959.2695267-4-jacob.jun.pan@linux.intel.com>
        <BN9PR11MB52765C5E0DC0759880C08E258CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
        <20230303134753.660d0755@jacob-builder>
        <ZAXkLN39VUSl+t65@nvidia.com>
        <20230306094408.2d675d5b@jacob-builder>
        <ZAYmS4Sx6bm+ziDY@nvidia.com>
        <20230306095759.1dd65cca@jacob-builder>
        <ZAYunPcgSOGFK8Qi@nvidia.com>
        <SJ1PR11MB6083DFA2C1D00B00C3918982FCB69@SJ1PR11MB6083.namprd11.prod.outlook.com>
        <ZAY5d2MSXjWRGF0n@nvidia.com>
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

Hi Jason,

On Mon, 6 Mar 2023 15:05:27 -0400, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Mon, Mar 06, 2023 at 06:48:43PM +0000, Luck, Tony wrote:
> > >> ENQCMDS does not have the restriction of using a single CPU MSR to
> > >> store PASIDs, PASID is supplied to the instruction operand.   
> > >
> > > Huh? That isn't what it says in the programming manual. It says the
> > > PASID only comes from the IA32_PASID msr and the only two operands are
> > > the destination MMIO and the memory source for the rest of the
> > > payload.  
> > 
> > Jason,
> > 
> > Two different instructions with only one letter different in the name.
> > 
> > ENQCMD - ring 3 instruction. The PASID is inserted into the descriptor
> > pushed to the device from the IA32_PASID MSR.
> > 
> > ENQCMDS - ring 0 instruction (see that trailing "S" for Supervisor
> > mode). In this case the submitter can include any PASID value they want
> > in the in-memory copy of the descriptor and ENQCMDS will pass that to
> > the device.  
> 
> Ah, well, my comment wasn't talking about ENQCMDS :)
> 
> If ENQCMDS can take in an arbitary PASID then there is no
> justification here to use the global allocator.
> 
> The rational is more like:
> 
>  IDXD uses PASIDs that come from the SVA allocator. It needs to create
>  an internal kernel-only PASID that is non-overlapping so allow the SVA
>  allocator to reserve PASIDs for driver use.
> 
>  IDXD has to use the global SVA PASID allocator beacuse its userspace
>  will use ENQCMD which requires global PASIDs.
> 
yes, great summary. I think that is the same as what I was trying to say
earlier :)
"due the unforgiving nature of ENQCMD that requires global PASIDs, ENQCMDS
has no choice but to allocate from the same numberspace to avoid conflict."

In that sense, I feel the global allocator should be staying with SVA
instead of moving to iommu core (as Kevin suggested). Because we are trying
to have non-overlapping pasid with SVA.

Thanks,

Jacob
