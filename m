Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739696D53FC
	for <lists+dmaengine@lfdr.de>; Mon,  3 Apr 2023 23:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbjDCVu4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 3 Apr 2023 17:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233626AbjDCVuy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 3 Apr 2023 17:50:54 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB8610C6;
        Mon,  3 Apr 2023 14:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680558652; x=1712094652;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BcRLMcu8Iblq5KidLgO+FxXKs6iVdXYPJX2NID33tnU=;
  b=FSdjMcMY9lv7aXjvENTv/PPA/gRJet5NRd8kRZacg+62ZlzVk3GPTF8e
   LVjwasOxYzLKZ2UMDC97+tbNkd+fza41/6mQYvoqctFjewI55Ba81jYv6
   3fSV46A9lS1TGU8+OXqUcEeNj2BoQ+kd2R2nJik/moCNkrPx7PbXr8Gp7
   J9CbdA5QmKzb29xYlH2Gk7pLcEXp/E2VTJaHCmqFmogLwxu7z5IUy/EX8
   7i3hZuShPhpzNLM7BEqMS8Yg1We4O56/aC8gmpKVvz3ICh+iKMBviLkUf
   +BWMg4FmdDCaYYKBvCi2zGwsPn/LAU6TnkcVpjsZYq4g+KV1rphbMt8tM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="343718126"
X-IronPort-AV: E=Sophos;i="5.98,315,1673942400"; 
   d="scan'208";a="343718126"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 14:50:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="663352503"
X-IronPort-AV: E=Sophos;i="5.98,315,1673942400"; 
   d="scan'208";a="663352503"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 14:50:52 -0700
Date:   Mon, 3 Apr 2023 14:54:58 -0700
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
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v3 7/7] dmaengine/idxd: Re-enable kernel workqueue under
 DMA API
Message-ID: <20230403145458.5c30d5c6@jacob-builder>
In-Reply-To: <07b7a01f-8a0d-6eca-e436-df5135d679cb@linux.intel.com>
References: <20230331231137.1947675-1-jacob.jun.pan@linux.intel.com>
        <20230331231137.1947675-8-jacob.jun.pan@linux.intel.com>
        <07b7a01f-8a0d-6eca-e436-df5135d679cb@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Baolu,

On Sat, 1 Apr 2023 21:39:32 +0800, Baolu Lu <baolu.lu@linux.intel.com>
wrote:

> On 2023/4/1 7:11, Jacob Pan wrote:
> >   static void idxd_disable_system_pasid(struct idxd_device *idxd)
> >   {
> > +	struct pci_dev *pdev = idxd->pdev;
> > +	struct device *dev = &pdev->dev;
> > +	struct iommu_domain *domain;
> > +	union gencfg_reg gencfg;
> > +
> > +	domain = iommu_get_domain_for_dev(dev);
> > +	if (!domain || domain->type == IOMMU_DOMAIN_BLOCKED)
> > +		return;  
> 
> Out of curiosity, why do you need to check the domain type? And, in
> which case could the domain for the device be changed to a blocking one?
> 
> Once a driver is bound to the device, the driver "owns" the DMA of the
> device. No one else could change the domain except the driver itself.
nothing particular just for precaution, I can drop the check or add a
warn_on.

> > +
> > +	iommu_detach_device_pasid(domain, dev, idxd->pasid);
> > +	iommu_free_global_pasid(idxd->pasid);
> >   
> > -	iommu_sva_unbind_device(idxd->sva);
> > +	gencfg.bits = ioread32(idxd->reg_base + IDXD_GENCFG_OFFSET);
> > +	gencfg.user_int_en = 0;
> > +	iowrite32(gencfg.bits, idxd->reg_base + IDXD_GENCFG_OFFSET);
> >   	idxd->sva = NULL;
> > +	idxd->pasid = IOMMU_PASID_INVALID;
> >   }  
> 
> Best regards,
> baolu


Thanks,

Jacob
