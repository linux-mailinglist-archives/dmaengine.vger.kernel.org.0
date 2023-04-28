Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6AE66F1BF0
	for <lists+dmaengine@lfdr.de>; Fri, 28 Apr 2023 17:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjD1Pv7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Apr 2023 11:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjD1Pv6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 28 Apr 2023 11:51:58 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917D21984;
        Fri, 28 Apr 2023 08:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682697117; x=1714233117;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vrd2psdUQes7KhjYx4FBAisXAZuT9MhfS8Jsg+nYJhs=;
  b=jy7dWJppzhEZhNt80Fuyo0Br5jiJa5VY2+EmWZPxOBdVxpJyFapw8ngx
   EiIkgoMntyNaPvDaATskLIGMGrBFibRq/cYK1yr+HOnr075VUdjWjUHA0
   wP8AkacSkHK5fBwkh+kIqbx9ZxEHB9GzGoTDWH5b+KninxsHbE4oMMnjZ
   tifLOlv/UfcRuFsiIfQdJ7ddB4r03W6IJypZwnrETftLSkbOp06/ySw5U
   NqxjGlIuSq3aJzZK3A8rE+5TqlghgEjpqdI/lb/9hyMDdwKDMhZgXJdW1
   u9V57OSXLgaf8naHQiK0KO1Z2+Sjv0DhaOJMEoVSSZOnVc76wwk9AUPhj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="434072115"
X-IronPort-AV: E=Sophos;i="5.99,235,1677571200"; 
   d="scan'208";a="434072115"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 08:51:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="941136513"
X-IronPort-AV: E=Sophos;i="5.99,235,1677571200"; 
   d="scan'208";a="941136513"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 08:51:56 -0700
Date:   Fri, 28 Apr 2023 08:56:15 -0700
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
Subject: Re: [PATCH v5 1/7] iommu: Generalize default PCIe requester ID
 PASID
Message-ID: <20230428085615.58e437c9@jacob-builder>
In-Reply-To: <BN9PR11MB5276FD027EC3D6BAA24046F58C6B9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230427174937.471668-1-jacob.jun.pan@linux.intel.com>
        <20230427174937.471668-2-jacob.jun.pan@linux.intel.com>
        <BN9PR11MB5276FD027EC3D6BAA24046F58C6B9@BN9PR11MB5276.namprd11.prod.outlook.com>
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

Hi Kevin,

On Fri, 28 Apr 2023 09:38:32 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Friday, April 28, 2023 1:50 AM
> > 
> > PCIe Process address space ID (PASID) is used to tag DMA traffic, it
> > provides finer grained isolation than requester ID (RID).
> > 
> > For each RID, 0 is as a special PASID for the legacy DMA (without
> > PASID), thus RID_PASID. This is universal across all architectures,
> > therefore warranted to be declared in the common header.
> > Noting that VT-d could support none-zero RID_PASID, but currently not
> > used.
> > 
> > By having a common RID_PASID, we can avoid conflicts between different
> > use cases in the generic code. e.g. SVA and DMA API with PASIDs.  
> 
> You intend it to be generic but in the end only vt-d driver is changed
> to use it in this series...
change for SVA is in the patch.

> > @@ -190,6 +190,7 @@ enum iommu_dev_features {
> >  	IOMMU_DEV_FEAT_IOPF,
> >  };
> > 
> > +#define IOMMU_DEF_RID_PASID	(0U) /* Reserved for DMA w/o PASID
> > */  
> 
> Is RID a general team on other platform?
RID, aka  requester id is a PCI term. so I this it is common though on SMMU
might be better called stream ID PASID?

> Would IOMMU_DEF_NO_PASID serve the purpose better?
not sure, it is still a PASID. For completeness, might be called
IOMMU_DEF_PASID_FOR_DMA_NO_PASID :)

other suggestions?

Thanks,

Jacob
