Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327566AF8B2
	for <lists+dmaengine@lfdr.de>; Tue,  7 Mar 2023 23:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjCGW3e (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Mar 2023 17:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjCGW3P (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 Mar 2023 17:29:15 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E5C9BA76;
        Tue,  7 Mar 2023 14:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678228102; x=1709764102;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yuyXsGR1whfmHiXJsv4+qjpy0Dresym5ojZswg7XH3A=;
  b=JI7uRhF/EcegyWUNuG0QJb4DAVE9iRQdzVLIlteZTrpeeRj/5ZbB+//Y
   BkxmJzJm8wSViL7xM8o0yRx7etrTTOkqk0itpWZM0JvEhogMp0+mKwvJo
   eTFMmKAzFSL5hQHiD8f5ABYtJ/tk844auUPwukx94Fp/uIHzbLEnuBDpv
   Uf96amDVpIj+Ck2jqqFwsSi9VBn8or6MKtSW0h1w86dbUykbup5esdqsk
   mgqXxLDXMETqsOIPxIUp50yJs5wVhfnjBrt9X9dYCwzRn6oufquzp1kP7
   A+9/Z7Tx7GeeDfB1P10X0Nr/14+vk5hj70XOqXTTouvO7c4UzxQs0OfLY
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="336010941"
X-IronPort-AV: E=Sophos;i="5.98,242,1673942400"; 
   d="scan'208";a="336010941"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 14:28:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="676725345"
X-IronPort-AV: E=Sophos;i="5.98,242,1673942400"; 
   d="scan'208";a="676725345"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 14:28:17 -0800
Date:   Tue, 7 Mar 2023 14:32:09 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
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
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v4 3/6] iommu/sva: Stop using ioasid_set for SVA
Message-ID: <20230307143209.2873d9e2@jacob-builder>
In-Reply-To: <ZAHzAa0mnilf0N9K@nvidia.com>
References: <20230301235646.2692846-1-jacob.jun.pan@linux.intel.com>
        <20230301235646.2692846-4-jacob.jun.pan@linux.intel.com>
        <3b7fb4d3-1fe9-a3be-46ad-c271be9f96c7@linux.intel.com>
        <20230302091707.58d59964@jacob-builder>
        <794c7dad-2e62-3afa-ea10-92179b0d1659@linux.intel.com>
        <20230303093235.GB361458@myrica>
        <3b2c6fe9-821f-9b84-acb6-777e8517a0fc@linux.intel.com>
        <ZAHzAa0mnilf0N9K@nvidia.com>
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

On Fri, 3 Mar 2023 09:15:45 -0400, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Fri, Mar 03, 2023 at 05:57:41PM +0800, Baolu Lu wrote:
> > On 2023/3/3 17:32, Jean-Philippe Brucker wrote:  
> > > > I suppose the common thing is reserving some kind of special
> > > > PASIDs.  
> > > Are you planning to use RID_PASID != 0 in VT-d?  Otherwise we could
> > > just communicate min_pasid from the IOMMU driver the same way we do
> > > max_pasid.
> > > 
> > > Otherwise I guess re-introduce a lighter ioasid_alloc() that the IOMMU
> > > driver calls to reserve PASID0/RID_PASID.  
> > 
> > Yes. We probably will use a non-zero RID_PASID in the future. An
> > interface to reserve (or allocate) a PASID from iommu_global_pasid_ida
> > should work then.  
> 
> Just allowing the driver to store XA_ZERO_ENTRY would be fine
> 
It looks like there are incoming users of iommu_sva_find()
https://lore.kernel.org/lkml/20230306163138.587484-1-fenghua.yu@intel.com/T/#m1fc97725a0e56ea269c8bdabacee447070d51846
Should we keep the xa here instead of the global ida?

 
Thanks,

Jacob
