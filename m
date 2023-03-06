Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34436ACA98
	for <lists+dmaengine@lfdr.de>; Mon,  6 Mar 2023 18:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjCFRfL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Mar 2023 12:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjCFRfK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Mar 2023 12:35:10 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4B167020;
        Mon,  6 Mar 2023 09:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678124078; x=1709660078;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DUxKUZFXlH9ieOprWzSIsATKqQ+Kr3d5N+BZv+HPjN8=;
  b=ZqrftcwLR2/7ATmkjnbaGMN59LPlwGoRli0v+/esKl79PSjxrbBO/qx9
   JMPi5NUx7h10bGnaRBZ5PF7n/ONWFE7a50ItEB/N/9MROtKLsgkJRPGqa
   ZwvZ9ylx/NxZxufPQpVxgUyFdQDrkFj2n1CpMhyf84DDlpBTaoUZnBbpw
   oYQ7t44ISEXUEjS0jvq40Q/Wboq3xHkjxvUVzgm0n/i8ilmrQDqsd0x6J
   C4Cn1eUKB8bBKCT3OmnFi4yQLXwr4CrhMzzlWysI+6ZsA3kAWLLU2rJPy
   vwr+NrTLpVdOVZm65LXKfFftxaVIDC01EgdXN8w8NJTdDHf5xAIJJphk1
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="363240590"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="363240590"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 09:32:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="745155575"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="745155575"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 09:32:36 -0800
Date:   Mon, 6 Mar 2023 09:36:26 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Lu Baolu <baolu.lu@linux.intel.com>,
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
Subject: Re: [PATCH 1/4] iommu/vt-d: Implement set device pasid op for
 default domain
Message-ID: <20230306093626.31c1573e@jacob-builder>
In-Reply-To: <ZAXjVaucrkEvrfsw@nvidia.com>
References: <20230302005959.2695267-1-jacob.jun.pan@linux.intel.com>
        <20230302005959.2695267-2-jacob.jun.pan@linux.intel.com>
        <ZAXjVaucrkEvrfsw@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Jason,

On Mon, 6 Mar 2023 08:57:57 -0400, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, Mar 01, 2023 at 04:59:56PM -0800, Jacob Pan wrote:
> > On VT-d platforms, legacy DMA requests without PASID use device=E2=80=
=99s
> > default domain, where RID_PASID is always attached. Device drivers
> > can then use the DMA API for all in-kernel DMA on the RID.
> >=20
> > Ideally, devices capable of using ENQCMDS can also transparently use the
> > default domain, consequently DMA API. However, VT-d architecture
> > dictates that the PASID used by ENQCMDS must be different from the
> > RID_PASID value.
> >=20
> > To provide support for transparent use of DMA API with non-RID_PASID
> > value, this patch implements the set_dev_pasid() function for the
> > default domain. The idea is that device drivers wishing to use ENQCMDS
> > to submit work on buffers mapped by DMA API will call
> > iommu_attach_device_pasid() beforehand.
> >=20
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/iommu/intel/iommu.c | 32 ++++++++++++++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> >=20
> > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > index 10f657828d3a..a0cb3bc851ac 100644
> > --- a/drivers/iommu/intel/iommu.c
> > +++ b/drivers/iommu/intel/iommu.c
> > @@ -4665,6 +4665,10 @@ static void intel_iommu_remove_dev_pasid(struct
> > device *dev, ioasid_t pasid) case IOMMU_DOMAIN_SVA:
> >  			intel_svm_remove_dev_pasid(dev, pasid);
> >  			break;
> > +		case IOMMU_DOMAIN_DMA:
> > +		case IOMMU_DOMAIN_DMA_FQ:
> > +		case IOMMU_DOMAIN_IDENTITY: =20
>=20
> Why do we need this switch statement anyhow?
For DMA API pasid, there is nothing special just let it fall through and
call=20
	intel_pasid_tear_down_entry(iommu, dev, pasid, false);

> Something seems to have
> gone wrong here.. SVM shouldn't be special,=20
I think all the trouble is caused by  the asymmetrical setup of
iommu_op.remove_dev_pasid() and iommu_domain_ops.set_dev_pasid()
Perhaps, we should "demote" remove_dev_pasid to iommu_domain_ops then we
don't have to check SVA specific things.

> and why does this call intel_pasid_tear_down_entry() twice on the SVA
> path?
Good catch, that seems to be unnecessary.

> It seems like all this is doing is flushing the PRI queue.
> A domain should have a dedicated flag unrelated to the type if it is
> using PRI and all PRI using domains should have the PRI queue flushed
> here, using the same code as flushing the PRI for a RID attachment.
Yes, or if the teardown op is domain-specific, then it works too?


Thanks,

Jacob
