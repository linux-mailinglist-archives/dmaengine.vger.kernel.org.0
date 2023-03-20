Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6AC6C22D0
	for <lists+dmaengine@lfdr.de>; Mon, 20 Mar 2023 21:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjCTUfG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 20 Mar 2023 16:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjCTUe4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 20 Mar 2023 16:34:56 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E646410D0;
        Mon, 20 Mar 2023 13:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679344494; x=1710880494;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xhl0RgABhwMl2wPVtTOZVbAXgf0Te8pbChDi1La+ZXA=;
  b=ZD8gdnyMzb3xiLs0kjy7hxSJbdLlPTzZeEneTT0BYSUXq9HuNoAQEhuh
   ZBDNuNtjfFVuYFhwN5zESxC06hUm/BefC9mKvLAkMGOhlN8GSY4ShLj7Y
   wBb14OdoMZI7pw8UAe3YTs4l985IMWhh7p0kSDCBtCZ3o49r+RMd+LpOy
   1uKq6JgXM5MhOnfc+IIcsP+7yzzJXbf8mSnPXVatSLxPGyJhQfHzEu3wy
   K9kwTmoOWlQxz5huc0rm4MAzYDU08OFvkbekVxu6E9YZEvbyV6zhOHeMn
   MyX4G5yMgH62lWkYAk66bxSfWOnClHpTF1Lv4ZfJvWGsAbghuBW/4EKjA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="322614567"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="322614567"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 13:34:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="658504127"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="658504127"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 13:34:53 -0700
Date:   Mon, 20 Mar 2023 13:38:52 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Robin Murphy <robin.murphy@arm.com>,
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
Subject: Re: [PATCH v7 6/7] iommu/ioasid: Rename INVALID_IOASID
Message-ID: <20230320133852.7535292d@jacob-builder>
In-Reply-To: <b1a380ad-50b4-4a00-2480-ac4d1542c71f@intel.com>
References: <20230320185910.2643260-1-jacob.jun.pan@linux.intel.com>
        <20230320185910.2643260-7-jacob.jun.pan@linux.intel.com>
        <b1a380ad-50b4-4a00-2480-ac4d1542c71f@intel.com>
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

Hi Dave,

On Mon, 20 Mar 2023 11:58:14 -0700, Dave Hansen <dave.hansen@intel.com>
wrote:

> On 3/20/23 11:59, Jacob Pan wrote:
> > --- a/arch/x86/kernel/traps.c
> > +++ b/arch/x86/kernel/traps.c
> > @@ -40,7 +40,10 @@
> >  #include <linux/io.h>
> >  #include <linux/hardirq.h>
> >  #include <linux/atomic.h>
> > -#include <linux/ioasid.h>
> > +
> > +#ifdef CONFIG_IOMMU_SVA
> > +#include <linux/iommu.h>
> > +#endif  
> 
> What's the deal with the #ifdef'd #include?
> 
> What's the harm of just making it unconditional?
No harm for this version. I will remove.

Thanks,

Jacob
