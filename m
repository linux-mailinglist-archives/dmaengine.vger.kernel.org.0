Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D31F6AA2C7
	for <lists+dmaengine@lfdr.de>; Fri,  3 Mar 2023 22:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbjCCVve (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 3 Mar 2023 16:51:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbjCCVue (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 3 Mar 2023 16:50:34 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452CB1FF0;
        Fri,  3 Mar 2023 13:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677879994; x=1709415994;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qGV5bJjDHw2ZzOUEb+Ljo+MxhpwEmK8AGP04i4kgrdk=;
  b=QK3H3na/NMHjUAUvhEOBkeGE5IozNLzwZc9q2GYxY7v8HARORkjrfYXi
   IgZ3co8XHw4p7L8PnRt427pGtBbWevjOkMwh7cwS77NThFqQjJHEgDvQX
   63xZGN0m4BcWuduzi5bXTXd0y4W+188NLI/s6udOO2y9PynALsqI7EOvJ
   A6sAA6/9Lhrr/PFvPqHsbcex8OVCfTJjuIPVGBRQOL9L5oOdBSuDRMVka
   KjanuMvFwdlu37obH/IqXrPMvijYrRgO8R0npA/kfHgdsXsOwKFD+GznE
   /KY5OQNfQICARXhoftLL4r8t9AbBNx2+A2gLP357cRPeOd2hFEGP6vYW1
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="397753654"
X-IronPort-AV: E=Sophos;i="5.98,231,1673942400"; 
   d="scan'208";a="397753654"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 13:45:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="707993274"
X-IronPort-AV: E=Sophos;i="5.98,231,1673942400"; 
   d="scan'208";a="707993274"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 13:45:33 -0800
Date:   Fri, 3 Mar 2023 13:49:23 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
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
        "Luck, Tony" <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 4/4] dmaengine/idxd: Re-enable kernel workqueue under
 DMA API
Message-ID: <20230303134923.22b7686f@jacob-builder>
In-Reply-To: <ZACdTG4QZSHF2QRj@nvidia.com>
References: <20230302005959.2695267-1-jacob.jun.pan@linux.intel.com>
        <20230302005959.2695267-5-jacob.jun.pan@linux.intel.com>
        <BN9PR11MB527624EDB9FCD26751C73B128CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
        <ZACdTG4QZSHF2QRj@nvidia.com>
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

On Thu, 2 Mar 2023 08:57:48 -0400, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Thu, Mar 02, 2023 at 09:47:00AM +0000, Tian, Kevin wrote:
> > > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > Sent: Thursday, March 2, 2023 9:00 AM
> > > 
> > >  static int idxd_enable_system_pasid(struct idxd_device *idxd)
> > >  {
> > > -	return -EOPNOTSUPP;
> > > +	struct pci_dev *pdev = idxd->pdev;
> > > +	struct device *dev = &pdev->dev;
> > > +	struct iommu_domain *domain;
> > > +	union gencfg_reg gencfg;
> > > +	ioasid_t pasid;
> > > +	int ret;
> > > +
> > > +	domain = iommu_get_domain_for_dev(dev);
> > > +	if (!domain || domain->type == IOMMU_DOMAIN_BLOCKED)
> > > +		return -EPERM;  
> > 
> > what about UNMANAGED?  
> 
> Why are we checking this anyhow?
> 
> Get the domain the DMA API is using and feed it to
> iommu_attach_device_pasid(). If the driver can't mirror the DMA API's
> domain onto the PASID then it will just fail the attach. A domain
> cannot even be NULL on x86.
makes sense,

Thanks,

Jacob
