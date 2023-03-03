Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C016A9BC6
	for <lists+dmaengine@lfdr.de>; Fri,  3 Mar 2023 17:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjCCQb0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 3 Mar 2023 11:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjCCQb0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 3 Mar 2023 11:31:26 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B51B762;
        Fri,  3 Mar 2023 08:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677861085; x=1709397085;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V/kvVu8XIUvkR96Nr+xnjCp5r6slkD+5sLn+iA7nJBw=;
  b=ZtDNe4Pr92JvV+KuJl4jhtnV+GuxrYsPi4B167BH92ZIrFpFHK+pnjLp
   wIqnhBAR/fofASrbkhCjpLm2nGU++tzMuxfNh2osvTHVMCibKU6PoMGL1
   3InU939utbuolxpRjE88SR/TXzM0pFAAU5TEEz4IZ7P/dRN/rBo05PKzw
   44BJJn34tmjJWkZzlwb8X5k5mw6/aT6v9DOptVdWQuiwzfcb4mRbVK7XA
   Q2QWvgpjltSQhU1wc2b6W+yUfIfvmAXQYFtB+YFW4wokjYwheB7nfGPpf
   N6D8iuVT5460+odGSFsnjn+tiGp/X4/Euj5Kcrcxtu23WVvNz+UUiTcEj
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="323379968"
X-IronPort-AV: E=Sophos;i="5.98,231,1673942400"; 
   d="scan'208";a="323379968"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 08:31:24 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="785315906"
X-IronPort-AV: E=Sophos;i="5.98,231,1673942400"; 
   d="scan'208";a="785315906"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 08:31:23 -0800
Date:   Fri, 3 Mar 2023 08:35:12 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Jason Gunthorpe <jgg@nvidia.com>,
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
Subject: Re: [PATCH 1/4] iommu/vt-d: Implement set device pasid op for
 default domain
Message-ID: <20230303083512.663ce758@jacob-builder>
In-Reply-To: <BN9PR11MB527627C597F6478536477A8F8CB39@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230302005959.2695267-1-jacob.jun.pan@linux.intel.com>
        <20230302005959.2695267-2-jacob.jun.pan@linux.intel.com>
        <fad7f28f-b4e8-c1c3-4ca4-a48c5c6d7f4a@linux.intel.com>
        <BN9PR11MB527627C597F6478536477A8F8CB39@BN9PR11MB5276.namprd11.prod.outlook.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Kevin,

On Fri, 3 Mar 2023 05:38:19 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Baolu Lu <baolu.lu@linux.intel.com>
> > Sent: Thursday, March 2, 2023 10:07 PM
> >   
> > > +
> > > +	if (hw_pass_through && domain_type_is_si(dmar_domain))
> > > +		ret = intel_pasid_setup_pass_through(iommu,
> > > dmar_domain,
> > > +						     dev, pasid);
> > > +	else if (dmar_domain->use_first_level)
> > > +		ret = domain_setup_first_level(iommu, dmar_domain,
> > > +					       dev, pasid);
> > > +	else
> > > +		ret = intel_pasid_setup_second_level(iommu,
> > > dmar_domain,
> > > +						     dev, pasid);
> > > +
> > > +	return ret;
> > > +}  
> > 
> > Do you need to consider pasid cache invalidation?
> >   
> 
> To avoid confusion this is not about invalidation of pasid cache itself
> which should be covered by above setup functions already.
> 
> Here actually means per-PASID invalidation in iotlb and devtlb. Today
> only RID is tracked per domain for invalidation. it needs extension to
> walk attached pasid too.

Yes, will add.

For the set up path, there is no need to flush IOTLBs,  because we're going
from non present to present.

On the remove path, IOTLB flush should be covered when device driver
calls iommu_detach_device_pasid(). Covered with this patch.


Thanks,

Jacob
