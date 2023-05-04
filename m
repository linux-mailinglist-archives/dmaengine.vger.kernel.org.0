Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D3C6F77F4
	for <lists+dmaengine@lfdr.de>; Thu,  4 May 2023 23:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjEDVWN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 4 May 2023 17:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjEDVWM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 4 May 2023 17:22:12 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE5F13C09;
        Thu,  4 May 2023 14:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683235331; x=1714771331;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yoXBNYJ/UPota7gNEgZ5BSyK4zH3Zyhjtbi1BVTh/7U=;
  b=KerhoHOWGSAf9tVtgwsSR4Frkg0W5jeyD9NLs9QXS4B/Dul0xy+1hdW3
   nMWEn1WrylgtprGu/kD2lvGx1K/urv4zTyUdTMCfz/3h1u78vLDE41Bcw
   5HjKMjQ7moXm94VGGB9ogwuo+USnlEzMJ0a35+KM2lO+GO8lgGrDZmAeu
   SseUbxQZEGOyZtorGJEb7DGribfQSIMh4jjrWhGrxdjCNW+X5RR6LzuTg
   vaXC7T2j3DsY7CDK38q3Ny9MOJmpMD8FZPK1yaVj+inEiai62kEyFPTiP
   NCucJnT4oYABu2QjfwByVV7KZmDb+HocyAP4lL88JvTxJZ0+RVIC6+g3h
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="435378030"
X-IronPort-AV: E=Sophos;i="5.99,250,1677571200"; 
   d="scan'208";a="435378030"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 14:22:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="762115908"
X-IronPort-AV: E=Sophos;i="5.99,250,1677571200"; 
   d="scan'208";a="762115908"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 14:22:10 -0700
Date:   Thu, 4 May 2023 14:26:33 -0700
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
Subject: Re: [PATCH v5 3/7] iommu: Move global PASID allocation from SVA to
 core
Message-ID: <20230504142633.1a7e78ae@jacob-builder>
In-Reply-To: <db3be8a2-6520-9652-6bee-dbceb320cfc2@linux.intel.com>
References: <20230427174937.471668-1-jacob.jun.pan@linux.intel.com>
        <20230427174937.471668-4-jacob.jun.pan@linux.intel.com>
        <db3be8a2-6520-9652-6bee-dbceb320cfc2@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Baolu,

On Wed, 3 May 2023 14:32:15 +0800, Baolu Lu <baolu.lu@linux.intel.com>
wrote:

> On 4/28/23 1:49 AM, Jacob Pan wrote:
> > +ioasid_t iommu_alloc_global_pasid_dev(struct device *dev)
> > +{
> > +	int ret;
> > +	ioasid_t max;
> > +
> > +	max = dev_iommu_get_max_pasids(dev);  
> 
> Perhaps you can use dev->iommu->max_pasids. It's static, so no need to
> recalculate it.
> 
sounds good!


Thanks,

Jacob
