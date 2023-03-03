Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237A36AA3BB
	for <lists+dmaengine@lfdr.de>; Fri,  3 Mar 2023 23:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233559AbjCCWDw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 3 Mar 2023 17:03:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233568AbjCCWDY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 3 Mar 2023 17:03:24 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51AAC664F3;
        Fri,  3 Mar 2023 13:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677880423; x=1709416423;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qxJfn1HMo5o/TEK84TFNUVCEuwu46pEXGqZ2QTppX2c=;
  b=gNIpRPK8y43yn/q7QNe7cjMBmXt7QFF5J021G4hevFWd3xR6RM97PhiQ
   UpCm2qAjw1DM4d1BwA94AR38ZRX450hYZ5qqnLhUHzGPj+TpaIA44f1pZ
   0psJROt+JHrgDMXMZPXSJULeZUp49J51gDoI1Y85jSUKudSkAz9TJSxOr
   x59LN129nnw7U2cJ8+ztjvCrm8c+IGiyquMsuBetnQstQyWFqW2SUKBFh
   FI9pGorJpFw7Su1N+Y5wYtQQWhtKrppJKWHp4Ocmsp2dSROxgKR/mi9Ow
   vYEeq92ndSqlqWrULlvY8G/AYTsJsTp5Ky6kKrYR4aGVO0PEZzLBPWZ/B
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="318989793"
X-IronPort-AV: E=Sophos;i="5.98,231,1673942400"; 
   d="scan'208";a="318989793"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 13:48:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="921252005"
X-IronPort-AV: E=Sophos;i="5.98,231,1673942400"; 
   d="scan'208";a="921252005"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 13:48:20 -0800
Date:   Fri, 3 Mar 2023 13:52:09 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Jason Gunthorpe <jgg@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>, dmaengine@vger.kernel.org,
        vkoul@kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 4/4] dmaengine/idxd: Re-enable kernel workqueue under
 DMA API
Message-ID: <20230303135209.16caf5ad@jacob-builder>
In-Reply-To: <063ed735-b8d1-1b44-67d7-78c3adb34074@linux.intel.com>
References: <20230302005959.2695267-1-jacob.jun.pan@linux.intel.com>
        <20230302005959.2695267-5-jacob.jun.pan@linux.intel.com>
        <063ed735-b8d1-1b44-67d7-78c3adb34074@linux.intel.com>
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

Hi Baolu,

On Fri, 3 Mar 2023 09:19:48 +0800, Baolu Lu <baolu.lu@linux.intel.com>
wrote:

> On 3/2/23 8:59 AM, Jacob Pan wrote:
> > diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> > index f30eef701970..dadc908318aa 100644
> > --- a/drivers/dma/idxd/init.c
> > +++ b/drivers/dma/idxd/init.c
> > @@ -501,14 +501,52 @@ static struct idxd_device *idxd_alloc(struct
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
> > +	domain = iommu_get_domain_for_dev(dev);
> > +	if (!domain || domain->type == IOMMU_DOMAIN_BLOCKED)
> > +		return -EPERM;  
> 
> The idxd driver has claimed the DMA ownership of this device. Unless the
> idxd driver itself attached another domain, iommu_get_domain_for_dev()
> should never return a blocking domain.
> 
> "domain == NULL" happens when CONFIG_IOMMU_API is not set.
> 
> Furthermore, iommu_get_domain_for_dev() doesn't hold any refcount from
> the domain, so in theory it's not safe here because it possibly causes
> use-after-release case.
> 
> I would say iommu_get_dma_domain() or something similar is more suitable
> for use here. It directly returns the device's default domain and the
> iommu core guarantees that default domain will always valid during the
> life cycle of any device driver.
> 
will do, same as Jason's comments.

Thanks,

Jacob
