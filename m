Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD4D6F1CB4
	for <lists+dmaengine@lfdr.de>; Fri, 28 Apr 2023 18:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240110AbjD1QgA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Apr 2023 12:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjD1QgA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 28 Apr 2023 12:36:00 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473582D67;
        Fri, 28 Apr 2023 09:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682699759; x=1714235759;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G9QHAq3wbr4zgk8yG3XHRnhnEvrVjVaInnC7sn3kSCA=;
  b=eYBDzHyCrTTSW3vuBzb6VF7Nb90OPHjydh4Wfc0iuN+aVuFvPALyCwwp
   r7dSXzMuh/4QsfpECBi3XoIL8CxE5l7obJYcPSJBDGP61L2fcza1plrED
   b6jdhf13d41olFzgV65JpnwGKz2FDzp7/ddO+6WeYNoTHOKXIf5Fe4IxK
   kCb0rKWaJ/WANRg8ZZdf/e0PA5SlE/vk8PFdsXdNy5rSVyaPu7/EnZX6N
   160YZW9ElJmVQGHqizUKL+vf57pyrdAeStUsNRQY5HF8w7YwaWJN41U7+
   rbkyb4QYiZ+gCSL4DJV9tmEVj6KsNXblzKvIz0gvqG7R9UxLaQ3CTMYha
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="336867580"
X-IronPort-AV: E=Sophos;i="5.99,235,1677571200"; 
   d="scan'208";a="336867580"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 09:35:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="672246110"
X-IronPort-AV: E=Sophos;i="5.99,235,1677571200"; 
   d="scan'208";a="672246110"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 09:35:58 -0700
Date:   Fri, 28 Apr 2023 09:40:17 -0700
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
Subject: Re: [PATCH v5 3/7] iommu: Move global PASID allocation from SVA to
 core
Message-ID: <20230428094017.715dda3f@jacob-builder>
In-Reply-To: <BN9PR11MB5276C41CCCCF3FDEA7DDF7AC8C6B9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230427174937.471668-1-jacob.jun.pan@linux.intel.com>
        <20230427174937.471668-4-jacob.jun.pan@linux.intel.com>
        <BN9PR11MB5276C41CCCCF3FDEA7DDF7AC8C6B9@BN9PR11MB5276.namprd11.prod.outlook.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Fri, 28 Apr 2023 09:46:25 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Friday, April 28, 2023 1:50 AM
> >=20
> > Devices that use Intel ENQCMD to submit work must use global PASIDs in
> > that the PASID are stored in a per CPU MSR. When such device need to
> > submit work for in-kernel DMA with PASID, it must allocate PASIDs from
> > the same global number space to avoid conflict. =20
>=20
> well the device itself cannot submit work to itself. It's software to
> submit work to the device. =F0=9F=98=8A
will rephrase, how about:
Intel ENQCMD work submission requires the use of global PASIDs in ...
> > that the PASID are stored in a per CPU MSR
>=20
> >  /* Allocate a PASID for the mm within range (inclusive) */
> > -static int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min,
> > ioasid_t max)
> > +static int iommu_sva_alloc_pasid(struct mm_struct *mm, struct device
> > *dev) {
> >  	int ret =3D 0;
> >=20
> > -	if (!pasid_valid(min) || !pasid_valid(max) ||
> > -	    min =3D=3D 0 || max < min)
> > -		return -EINVAL;
> > -
> >  	mutex_lock(&iommu_sva_lock);
> >  	/* Is a PASID already associated with this mm? */
> > -	if (pasid_valid(mm->pasid)) {
> > -		if (mm->pasid < min || mm->pasid > max)
> > -			ret =3D -EOVERFLOW;
> > +	if (pasid_valid(mm->pasid))
> >  		goto out; =20
>=20
> emmm here you still want to check whether mm->pasid exceeds
> the max pasid width of the bound device.
good point, existing mm->pasid could be from another device that has a
larger pasid range.


Thanks,

Jacob
