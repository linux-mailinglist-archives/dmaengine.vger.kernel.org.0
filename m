Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09616CCB66
	for <lists+dmaengine@lfdr.de>; Tue, 28 Mar 2023 22:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjC1UUA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Mar 2023 16:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjC1UT5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Mar 2023 16:19:57 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630442D65;
        Tue, 28 Mar 2023 13:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680034796; x=1711570796;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mH70rbuQZIz3ZfAr/wAHligzMtrkQB/RhbsvSVS8yiM=;
  b=OBG3Jgf3UvXKBNfDYDTTvzTjzYTTTlH2WOfVck+iPVSqg55szhbKo01F
   ybFxZY9IX2evr7ovfHBU+UjUs1n7TtkXd/C3TPZ/4V7j4XB4TcDORaGSh
   51J4qCgfUldtPnvIpdw5cAzX2wFuQOxTZuulWSJ3AZS1nx/nSCk/C9s42
   jd6JxkVthe/pBWBfsgtkfwNxOn+L2zppIWBiLi+J6VY1oE65TnVUGvIsY
   3EzvCtkKWRG+JxBaOluWLzjFlnPvFWNc2BNWN344umZ+EUHe5YQ7IKA3Q
   TnVFinmyuQZfhGjKdU1fobj03kaVA9aiBHBbO40jKMxAdAUi0Eiw/8KLT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="343094085"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="343094085"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 13:19:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="748520724"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="748520724"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 13:19:54 -0700
Date:   Tue, 28 Mar 2023 13:23:57 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, <dmaengine@vger.kernel.org>,
        <vkoul@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        "David Woodhouse" <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 8/8] dmaengine/idxd: Re-enable kernel workqueue under
 DMA API
Message-ID: <20230328132357.5f6bdf6c@jacob-builder>
In-Reply-To: <a2a107ce-3ebd-0876-e720-cae07e75fb09@intel.com>
References: <20230327232138.1490712-1-jacob.jun.pan@linux.intel.com>
        <20230327232138.1490712-9-jacob.jun.pan@linux.intel.com>
        <a2a107ce-3ebd-0876-e720-cae07e75fb09@intel.com>
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

Hi Fenghua,

On Tue, 28 Mar 2023 11:16:31 -0700, Fenghua Yu <fenghua.yu@intel.com> wrote:

> Hi, Jacob,
> 
> On 3/27/23 16:21, Jacob Pan wrote:
> > Kernel workqueues were disabled due to flawed use of kernel VA and SVA
> > API. Now That we have the support for attaching PASID to the device's  
> 
> s/That/that/
will fix

> > default domain and the ability to reserve global PASIDs from SVA APIs,
> > we can re-enable the kernel work queues and use them under DMA API.
> > 
> > We also use non-privileged access for in-kernel DMA to be consistent
> > with the IOMMU settings. Consequently, interrupt for user privilege is
> > enabled for work completion IRQs.
> > 
> > Link:https://lore.kernel.org/linux-iommu/20210511194726.GP1002214@nvidia.com/
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >   drivers/dma/idxd/device.c | 30 ++++-------------------
> >   drivers/dma/idxd/init.c   | 51 ++++++++++++++++++++++++++++++++++++---
> >   drivers/dma/idxd/sysfs.c  |  7 ------
> >   3 files changed, 52 insertions(+), 36 deletions(-)
> > 
> > diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
> > index 6fca8fa8d3a8..f6b133d61a04 100644
> > --- a/drivers/dma/idxd/device.c
> > +++ b/drivers/dma/idxd/device.c
> > @@ -299,21 +299,6 @@ void idxd_wqs_unmap_portal(struct idxd_device
> > *idxd) }
> >   }
> >   
> > -static void __idxd_wq_set_priv_locked(struct idxd_wq *wq, int priv)
> > -{
> > -	struct idxd_device *idxd = wq->idxd;
> > -	union wqcfg wqcfg;
> > -	unsigned int offset;
> > -
> > -	offset = WQCFG_OFFSET(idxd, wq->id, WQCFG_PRIVL_IDX);
> > -	spin_lock(&idxd->dev_lock);
> > -	wqcfg.bits[WQCFG_PRIVL_IDX] = ioread32(idxd->reg_base +
> > offset);
> > -	wqcfg.priv = priv;
> > -	wq->wqcfg->bits[WQCFG_PRIVL_IDX] = wqcfg.bits[WQCFG_PRIVL_IDX];
> > -	iowrite32(wqcfg.bits[WQCFG_PRIVL_IDX], idxd->reg_base +
> > offset);
> > -	spin_unlock(&idxd->dev_lock);
> > -}
> > -
> >   static void __idxd_wq_set_pasid_locked(struct idxd_wq *wq, int pasid)
> >   {
> >   	struct idxd_device *idxd = wq->idxd;
> > @@ -1324,15 +1309,14 @@ int drv_enable_wq(struct idxd_wq *wq)
> >   	}
> >   
> >   	/*
> > -	 * In the event that the WQ is configurable for pasid and priv
> > bits.
> > -	 * For kernel wq, the driver should setup the pasid, pasid_en,
> > and priv bit.
> > -	 * However, for non-kernel wq, the driver should only set the
> > pasid_en bit for
> > -	 * shared wq. A dedicated wq that is not 'kernel' type will
> > configure pasid and
> > +	 * In the event that the WQ is configurable for pasid, the
> > driver
> > +	 * should setup the pasid, pasid_en bit. This is true for both
> > kernel
> > +	 * and user shared workqueues. There is no need to setup priv
> > bit in
> > +	 * that in-kernel DMA will also do user privileged requests.
> > +	 * A dedicated wq that is not 'kernel' type will configure
> > pasid and
> >   	 * pasid_en later on so there is no need to setup.
> >   	 */
> >   	if (test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags)) {
> > -		int priv = 0;
> > -
> >   		if (wq_pasid_enabled(wq)) {
> >   			if (is_idxd_wq_kernel(wq) || wq_shared(wq)) {
> >   				u32 pasid = wq_dedicated(wq) ?
> > idxd->pasid : 0; @@ -1340,10 +1324,6 @@ int drv_enable_wq(struct
> > idxd_wq *wq) __idxd_wq_set_pasid_locked(wq, pasid);
> >   			}
> >   		}
> > -
> > -		if (is_idxd_wq_kernel(wq))
> > -			priv = 1;
> > -		__idxd_wq_set_priv_locked(wq, priv);
> >   	}
> >   
> >   	rc = 0;
> > diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> > index e6ee267da0ff..a3396e1b38f1 100644
> > --- a/drivers/dma/idxd/init.c
> > +++ b/drivers/dma/idxd/init.c
> > @@ -506,14 +506,56 @@ static struct idxd_device *idxd_alloc(struct
> > pci_dev *pdev, struct idxd_driver_d 
> >   static int idxd_enable_system_pasid(struct idxd_device *idxd)
> >   {
> > -	return -EOPNOTSUPP;
> > +	struct pci_dev *pdev = idxd->pdev;
> > +	struct device *dev = &pdev->dev;
> > +	struct iommu_domain *domain;
> > +	union gencfg_reg gencfg;
> > +	ioasid_t pasid;
> > +	int ret;
> > +
> > +	/*
> > +	 * Attach a global PASID to the DMA domain so that we can use
> > ENQCMDS
> > +	 * to submit work on buffers mapped by DMA API.
> > +	 */
> > +	domain = iommu_get_dma_domain(dev);
> > +	if (!domain)
> > +		return -EPERM;
> > +
> > +	pasid = iommu_sva_reserve_pasid(1, dev->iommu->max_pasids);
> > +	if (pasid == IOMMU_PASID_INVALID)
> > +		return -ENOSPC;
> > +
> > +	ret = iommu_attach_device_pasid(domain, dev, pasid);
> > +	if (ret) {
> > +		dev_err(dev, "failed to attach device pasid %d, domain
> > type %d",
> > +			pasid, domain->type);
> > +		iommu_sva_release_pasid(pasid);
> > +		return ret;
> > +	}
> > +
> > +	/* Since we set user privilege for kernel DMA, enable
> > completion IRQ */
> > +	gencfg.bits = ioread32(idxd->reg_base + IDXD_GENCFG_OFFSET);
> > +	gencfg.user_int_en = 1;
> > +	iowrite32(gencfg.bits, idxd->reg_base + IDXD_GENCFG_OFFSET);
> > +	idxd->pasid = pasid;
> > +
> > +	return ret;
> >   }
> >   
> >   static void idxd_disable_system_pasid(struct idxd_device *idxd)
> >   {
> > +	struct pci_dev *pdev = idxd->pdev;
> > +	struct device *dev = &pdev->dev;
> > +	struct iommu_domain *domain;
> > +
> > +	domain = iommu_get_domain_for_dev(dev);
> > +	if (!domain || domain->type == IOMMU_DOMAIN_BLOCKED)
> > +		return;
> >   
> > -	iommu_sva_unbind_device(idxd->sva);
> > +	iommu_detach_device_pasid(domain, dev, idxd->pasid);
> > +	iommu_sva_release_pasid(idxd->pasid);  
> 
> May need gencfg.user_int_en = 0 here.
Yes, good catch! 


Thanks,

Jacob
