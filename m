Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14486AA40D
	for <lists+dmaengine@lfdr.de>; Fri,  3 Mar 2023 23:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbjCCWSn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 3 Mar 2023 17:18:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233469AbjCCWSZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 3 Mar 2023 17:18:25 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7066BC26;
        Fri,  3 Mar 2023 14:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677881361; x=1709417361;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F0jJypZHaRaBJ6BMYaW1CHf7YuZJ1wW4P1q1vVBdKzE=;
  b=CgXJzl2QPyJCfpYz3gwPd2tiPmkjVSQhsMM5H+M2eh9E5uvtzx6WPR3w
   epSp3BGMJGbMZ+Eg0WP6cCoJ6Mxdz3xJ0KL4i8FckOdXHADMSg8N6dY5K
   LlrDQkdRNrPMx2SUczGgKaNDMyAPOAZh0/OsslWT4xblato/u4iiFqDSe
   LZL/usCaVKZ16mCM/3LTqxVG7PSdiuMx8IF7dEJQ5Zv3ze58DSJu4kFoS
   idNgm3ZBALcg8J7R3JZQ7DatXEwm75LsLvt31mN3HTPjlxRV70oskUVNq
   VPn2b25lqL1rxYnYtiqFGv0DloKL/nUNghibqaSj45GGeUMuLgRUUSk31
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="421443552"
X-IronPort-AV: E=Sophos;i="5.98,231,1673942400"; 
   d="scan'208";a="421443552"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 14:08:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="677809639"
X-IronPort-AV: E=Sophos;i="5.98,231,1673942400"; 
   d="scan'208";a="677809639"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 14:08:34 -0800
Date:   Fri, 3 Mar 2023 14:12:24 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        "David Woodhouse" <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 4/4] dmaengine/idxd: Re-enable kernel workqueue under
 DMA API
Message-ID: <20230303141224.7f1bf7e0@jacob-builder>
In-Reply-To: <BN9PR11MB527624EDB9FCD26751C73B128CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230302005959.2695267-1-jacob.jun.pan@linux.intel.com>
        <20230302005959.2695267-5-jacob.jun.pan@linux.intel.com>
        <BN9PR11MB527624EDB9FCD26751C73B128CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
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

Hi Kevin,

On Thu, 2 Mar 2023 09:47:00 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Thursday, March 2, 2023 9:00 AM
> > 
> >  static int idxd_enable_system_pasid(struct idxd_device *idxd)
> >  {
> > -	return -EOPNOTSUPP;
> > +	struct pci_dev *pdev = idxd->pdev;
> > +	struct device *dev = &pdev->dev;
> > +	struct iommu_domain *domain;
> > +	union gencfg_reg gencfg;
> > +	ioasid_t pasid;
> > +	int ret;
> > +
> > +	domain = iommu_get_domain_for_dev(dev);
> > +	if (!domain || domain->type == IOMMU_DOMAIN_BLOCKED)
> > +		return -EPERM;  
> 
> what about UNMANAGED?
will fix this by getting the dma domain.
> 
> > +
> > +	pasid = iommu_sva_reserve_pasid(1, dev->iommu->max_pasids);
> > +	if (pasid == IOMMU_PASID_INVALID)
> > +		return -ENOSPC;  
> 
> as commented in last patch we can just pass a device pointer to a
> general allocation interface.
will do
> 
> > +
> > +	ret = iommu_attach_device_pasid(domain, dev, pasid);
> > +	if (ret) {
> > +		dev_err(dev, "failed to attach device pasid %d, domain
> > type %d",
> > +			pasid, domain->type);
> > +		iommu_sva_unreserve_pasid(pasid);
> > +		return ret;
> > +	}
> > +
> > +	/* Since we set user privilege for kernel DMA, enable
> > completion IRQ */
> > +	gencfg.bits = ioread32(idxd->reg_base + IDXD_GENCFG_OFFSET);
> > +	gencfg.user_int_en = 1;
> > +	iowrite32(gencfg.bits, idxd->reg_base + IDXD_GENCFG_OFFSET);
> > +	idxd->pasid = pasid;  
> 
> Why does user privilege requires a completion interrupt?
> 
> Or instead it's more due to doing kernel DMA itself then we certainly
> don't want to poll in the kernel?
yes, kernel wq does not support polling, therefore it needs interrupts.
Without user_int_en bit set, there would be no interrupts if we use user
privilege for kernel wq.

Thanks,

Jacob
