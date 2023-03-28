Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D17C76CCC27
	for <lists+dmaengine@lfdr.de>; Tue, 28 Mar 2023 23:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjC1Vg5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Mar 2023 17:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjC1Vg4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Mar 2023 17:36:56 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263ED26BE;
        Tue, 28 Mar 2023 14:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680039416; x=1711575416;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lRUDa9QZQb0fXRVcvHKDEfHg8a2PZVa5X7ucZyjCT30=;
  b=Z+dtVwNP4mFnIWP6WhNN23LsHkxdihkHjHsjHXJwZ/TOZgNcyL7rxGFA
   n1+2MN0ASbKDguIk9LdeVpNhw5ggI4hq2xmA1Xxm2fv2bwtN9aIqaNeKw
   4lXlMIhOSO1fdAUKw2uc4q5WQ4qJmKfN+styqGcAJKRJJBE4heZMpD0i4
   srMf3sTlnJ3VKD5BcDoUfyECIBR0dvkdgpM4rs4R5SFfphoXZPLzYDfYx
   EWLElmvPwluyPumGY8WywYitLIAIUthti8UgiEGr0yhvL3LAUQfAy5YCz
   fikeNYYYR6QxkRCUAIe/WaMdp0+z2Y5s6/C4OU6MA9Oc2eioU0KwEtVFR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="403313675"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="403313675"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 14:36:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="748539872"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="748539872"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 14:36:54 -0700
Date:   Tue, 28 Mar 2023 14:40:57 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        X86 Kernel <x86@kernel.org>, bp@alien8.de,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, corbet@lwn.net,
        vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-doc@vger.kernel.org, Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v8 0/7] Remove VT-d virtual command interface and IOASID
Message-ID: <20230328144057.73ce8565@jacob-builder>
In-Reply-To: <ZBxl3FgN/m2Qus7V@nvidia.com>
References: <20230322200803.869130-1-jacob.jun.pan@linux.intel.com>
        <ZBxl3FgN/m2Qus7V@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Joerg et al,

Just wondering if there are any other comments? Should i spin another
version to include Reviewed-by tags from Kevin?

I have a patchset below depends on this one.

https://lore.kernel.org/linux-iommu/20230327232138.1490712-1-jacob.jun.pan@linux.intel.com/T/#t

Thank you everyone,

Jacob

On Thu, 23 Mar 2023 11:44:44 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, Mar 22, 2023 at 01:07:56PM -0700, Jacob Pan wrote:
> > Hi all,
> > 
> > This patch set removes unused VT-d virtual command interface followed by
> > removal of the IOASID infrastructure.
> > 
> > This has only been tested on x86 platforms, need help with testing on
> > ARM SMMU and other architectures.
> > 
> > 
> > Thanks,
> > 
> > Jacob
> > 
> > ChangeLog:
> > v8:
> >  - remove #ifdef CONFIG_IOMMU_SVA since we have dummy inline functions.
> >  - fixed a compile bug that affects bisectability  
> 
> I think this looks OK now, thanks
> 
> Jason


Thanks,

Jacob
