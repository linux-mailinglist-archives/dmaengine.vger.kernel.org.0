Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB836F7865
	for <lists+dmaengine@lfdr.de>; Thu,  4 May 2023 23:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjEDV50 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 4 May 2023 17:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjEDV5Y (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 4 May 2023 17:57:24 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94DA13289;
        Thu,  4 May 2023 14:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683237443; x=1714773443;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4Q0HgYS8fBg0x+XSACWujM6Ax818ZMRS1g2rWv1t5c0=;
  b=VvKG1F4c+OE3S6VlePVAYkPf8Kpk/l0WVwWcbYi9md4XE2JqIF/sIe6E
   kaLV+l/4bwQv0N5P/owYKUq8TKRxRQdt8YwNO2RwlO0hfi7jl17+M+O5o
   C4sLojKmoVpRF0LsszLMBzorflH+y0uw23QwCg+ksFD1m6PHZyRLhLRdA
   /JaLTw1xKaiTWKRG97+70+zB+RVdYX7EGL5ihjp82Q37N2tAsZdjAcAmv
   5zzXDAK72Mc6TCLoi/x+Rci+eKv5r038p+0XlbSjKg3bsrZo2PL6e/pgl
   bc/1AKkmfgPnIfiZ2VTSrJzrg0iudC0exz1wkPCHK0yWFCgcEcMNjqZZy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="351187040"
X-IronPort-AV: E=Sophos;i="5.99,250,1677571200"; 
   d="scan'208";a="351187040"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 14:23:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="697233794"
X-IronPort-AV: E=Sophos;i="5.99,250,1677571200"; 
   d="scan'208";a="697233794"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 14:23:05 -0700
Date:   Thu, 4 May 2023 14:27:27 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        "Ranganathan, Narayan" <narayan.ranganathan@intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v5 4/7] iommu/vt-d: Factoring out PASID set up helper
 function
Message-ID: <20230504142727.4bd2206a@jacob-builder>
In-Reply-To: <BN9PR11MB5276726E67301703BD10833B8C6B9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230427174937.471668-1-jacob.jun.pan@linux.intel.com>
        <20230427174937.471668-5-jacob.jun.pan@linux.intel.com>
        <BN9PR11MB5276726E67301703BD10833B8C6B9@BN9PR11MB5276.namprd11.prod.outlook.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Kevin,

On Fri, 28 Apr 2023 09:47:45 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Friday, April 28, 2023 1:50 AM
> > 
> > 
> > +static int dmar_domain_attach_device_pasid(struct dmar_domain *domain,
> > +					   struct intel_iommu *iommu,
> > +					   struct device *dev,
> > ioasid_t pasid) +{
> > +	int ret;
> > +
> > +	/* PASID table is mandatory for a PCI device in scalable mode.
> > */
> > +	if (!sm_supported(iommu) && dev_is_real_dma_subdevice(dev))
> > +		return -EOPNOTSUPP;  
> 
> "&&" should be "||"
> 
good catch,

Thanks,

Jacob
