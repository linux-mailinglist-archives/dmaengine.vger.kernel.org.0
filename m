Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2D46B50CF
	for <lists+dmaengine@lfdr.de>; Fri, 10 Mar 2023 20:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjCJTTT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Mar 2023 14:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjCJTTS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 10 Mar 2023 14:19:18 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41E9120E8C;
        Fri, 10 Mar 2023 11:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678475956; x=1710011956;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6TjAizJZ0Z7OgkuuCfD17cXy68nJRib2Dg7u3RNtp2M=;
  b=hIXejWL+tPB0mthmYeF3+GqKjYQYtRG6zfYk56Blx1MBd4zQzW3hRSYF
   cNRoQ9FCYug5lDAHMqOZ1GeGuq8o5Yp/emqe5dnOz3O996OsSABJq1gRA
   Vtful8oBZIb2ysYS3A0RARL1d7Ms7jqn6C50WCmdyeXXSFaL53CsBjo57
   wFMjtIp2Tn7CtXCEmOvitjFd1jQg3NmiIWBb7osyHhlwBVT3jjke1uaNV
   eM3i3vTyOPD+wPkZr8zBxKKZa/Fnk6gpx2EweGCOxMRWL/clvtu887xxI
   l+hscfeapTlvYVGgIq5OMoDpTGEN4xOm8MU7eTPZOxeeq61dFuJcmlW8c
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="336830636"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="336830636"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 11:19:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="708122699"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="708122699"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 11:19:16 -0800
Date:   Fri, 10 Mar 2023 11:23:09 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        X86 Kernel <x86@kernel.org>, bp@alien8.de,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, corbet@lwn.net,
        vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-doc@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v5 2/7] iommu/sva: Move PASID helpers to sva code
Message-ID: <20230310112309.024f6558@jacob-builder>
In-Reply-To: <ZAqLUG0uhACSMeXP@nvidia.com>
References: <20230309222159.487826-1-jacob.jun.pan@linux.intel.com>
        <20230309222159.487826-4-jacob.jun.pan@linux.intel.com>
        <ZAqLUG0uhACSMeXP@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Jason,

On Thu, 9 Mar 2023 21:43:44 -0400, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Thu, Mar 09, 2023 at 02:21:54PM -0800, Jacob Pan wrote:
> > diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> > index 2a243616f222..f341a7a855e8 100644
> > --- a/include/linux/sched/mm.h
> > +++ b/include/linux/sched/mm.h
> > @@ -8,7 +8,7 @@
> >  #include <linux/mm_types.h>
> >  #include <linux/gfp.h>
> >  #include <linux/sync_core.h>
> > -#include <linux/ioasid.h>
> > +#include <linux/iommu-helper.h>  
> 
> Don't include this here, fork.cc is the only caller put the include
> there
make sense, will do.

Thanks,

Jacob
