Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C676CCB86
	for <lists+dmaengine@lfdr.de>; Tue, 28 Mar 2023 22:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjC1Uf1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Mar 2023 16:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjC1Uf0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Mar 2023 16:35:26 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8F81985;
        Tue, 28 Mar 2023 13:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680035725; x=1711571725;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JwzUa3WrFrFqZeBAjs/FmiYkt2mKxkOcX0p1HF8/DO4=;
  b=AuaUrF5S77u3JuY012QLh0b7uQ/KvGj3GGpPYTQyx8qDduseTdg6SV47
   rtJs+q+zuNLZXJONNRBJNwARjYXPrNlAk5AYmFgiTzo7NbB+5y9YCzXC0
   tU+54/ENYtSf7ArbxJ7E8DbjYczGyBT4QUijpRKHIEgknLxwsACahbF/T
   LNfCfbe688sBrkB2YkPYoIMmzTNIatQEM4wspgC7Nt60GoDTOhN5Gazzg
   h26QCTsS7RdExwtmgMtRogT8hqRUnMPamXi8l0aP0Jkqn/rdIwztt8UB2
   qOEtCz3KuZPSKcuKqv3QHbr485T2OA3bvWOwgTH0ZwIG0kyRvpLQ2B6mV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="340706733"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="340706733"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 13:35:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="794953437"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="794953437"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 13:35:24 -0700
Date:   Tue, 28 Mar 2023 13:39:26 -0700
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
Subject: Re: [PATCH v2 5/8] iommu/vt-d: Make device pasid attachment
 explicit
Message-ID: <20230328133926.6f6c2ed2@jacob-builder>
In-Reply-To: <BN9PR11MB5276BCF726D0B813046479A18C889@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230327232138.1490712-1-jacob.jun.pan@linux.intel.com>
        <20230327232138.1490712-6-jacob.jun.pan@linux.intel.com>
        <71b60cc2-4ab0-3777-6bc9-3a6a4174f743@linux.intel.com>
        <BN9PR11MB5276BCF726D0B813046479A18C889@BN9PR11MB5276.namprd11.prod.outlook.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Kevin,

On Tue, 28 Mar 2023 07:44:52 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Baolu Lu <baolu.lu@linux.intel.com>
> > Sent: Tuesday, March 28, 2023 1:49 PM
> >=20
> > On 3/28/23 7:21 AM, Jacob Pan wrote: =20
> > > diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> > > index 65b15be72878..b6c26f25d1ba 100644
> > > --- a/drivers/iommu/intel/iommu.h
> > > +++ b/drivers/iommu/intel/iommu.h
> > > @@ -595,6 +595,7 @@ struct dmar_domain {
> > >
> > >   	spinlock_t lock;		/* Protect device tracking
> > > lists */ struct list_head devices;	/* all devices' list */
> > > +	struct list_head dev_pasids;	/* all attached pasids */
> > >
> > >   	struct dma_pte	*pgd;		/* virtual
> > > address */ int		gaw;		/* max guest
> > > address width */ @@ -708,6 +709,7 @@ struct device_domain_info {
> > >   	u8 ats_supported:1;
> > >   	u8 ats_enabled:1;
> > >   	u8 dtlb_extra_inval:1;	/* Quirk for devices need
> > > extra flush */
> > > +	u8 dev_attached:1;	/* Device context activated */
> > >   	u8 ats_qdep;
> > >   	struct device *dev; /* it's NULL for PCIe-to-PCI bridge */
> > >   	struct intel_iommu *iommu; /* IOMMU used by this device */
> > > @@ -715,6 +717,12 @@ struct device_domain_info {
> > >   	struct pasid_table *pasid_table; /* pasid table */
> > >   };
> > >
> > > +struct device_pasid_info {
> > > +	struct list_head link_domain;	/* link to domain
> > > siblings */
> > > +	struct device *dev;		/* physical device
> > > derived from */
> > > +	ioasid_t pasid;			/* PASID on physical
> > > device */ +}; =20
> >=20
> > The dev_pasids list seems to be duplicate with iommu_group::pasid_array.
> >=20
> > The pasid_array is de facto per-device as the PCI subsystem requires ACS
> > to be enabled on the upstream path to the root port.
> >=20
> > pci_enable_pasid():
> > 385         if (!pci_acs_path_enabled(pdev, NULL, PCI_ACS_RR |
> > PCI_ACS_UF)) 386                 return -EINVAL;
> >=20
> > For such PCI topology, pci_device_group() always assigns an exclusive
> > iommu group (a.k.a. singleton group).
> >=20
> > So, how about moving the pasid_array from struct iommu_group to struct
> > dev_iommu? With this refactoring, the individual iommu driver has no
> > need to create their own pasid array or list.
> >=20
> > Instead of using iommu_group::mutex, perhaps the pasid_array needs its
> > own lock in struct dev_iommu after moving.
> >  =20
>=20
> What you suggested is a right thing and more friendly to pasid attach
> in iommufd [1].
>=20
> but dev_pasids list here is a different thing. It tracks which [device,
> pasid] is attached to the domain. w/o this information you'll have to
> walk the pasid_array of every attached device under the domain and search
> for every pasid entry pointing to the said domain. It's very inefficient.=
=20
>=20
> of course if this can be done more generally it'd be nice.=F0=9F=98=8A
>=20
> [1] https://lore.kernel.org/linux-iommu/ZAjbDxSzxYPqSCjo@nvidia.com/
Yes, it would be nice as the next step. But so far only ENQCMDS usages may
not justify.

Thanks,

Jacob
