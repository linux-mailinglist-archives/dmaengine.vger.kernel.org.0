Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71F27305BE
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jun 2023 19:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233272AbjFNRPK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Jun 2023 13:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236424AbjFNRPI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 14 Jun 2023 13:15:08 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DB4E69;
        Wed, 14 Jun 2023 10:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686762907; x=1718298907;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+axceMY/sA0RUPEI/SsihcSDgTCdjPx1bekyxvK9JBw=;
  b=KKKI/h1h8X+yQQpGCcoiKJ3ysnWoOrR9qHIyu1eLidhLHOr0SOEDOPib
   gR4PmJlYtTHmufRRGc9Vai0WqWbeM4fxPDBXot6G/qoDZ6Cu639jUBDXZ
   R5UlIrypyLWhAaWUmPdRScknt4cHgBLrQs29wxiDGm4zv3KlWjWS8dYoD
   MU+DR99F13unH8sP7VOnmT4a8/BMx7IxBQx4KuyvdoyFl7jI/oIgIi/OE
   g4uGCrdmqjNRKixP3dye+Gqc1y68fAkX1QGj7NpWePuO+rtIXx0gF4MlH
   MEzj7OLPseG4jvOwFAjUm3eLFuP3tusM6UKRd6wP26MXDBJb6TeYsVNFm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="358678789"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="358678789"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 10:15:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="801998912"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="801998912"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 10:15:06 -0700
Date:   Wed, 14 Jun 2023 10:19:49 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Jason Gunthorpe <jgg@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        dmaengine@vger.kernel.org, vkoul@kernel.org,
        Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>, rex.zhang@intel.com,
        xiaochen.shen@intel.com, narayan.ranganathan@intel.com,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v8 2/7] iommu: Move global PASID allocation from SVA to
 core
Message-ID: <20230614101949.1164f33f@jacob-builder>
In-Reply-To: <b5a6a7ad-bfad-b550-f4be-f5ec0679f3d2@linux.intel.com>
References: <20230602182212.150825-1-jacob.jun.pan@linux.intel.com>
        <20230602182212.150825-3-jacob.jun.pan@linux.intel.com>
        <08830c11-5528-0c42-0bc3-89c3796611fe@linux.intel.com>
        <b5a6a7ad-bfad-b550-f4be-f5ec0679f3d2@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Baolu,

On Tue, 13 Jun 2023 11:06:03 +0800, Baolu Lu <baolu.lu@linux.intel.com>
wrote:

> On 6/10/23 8:13 PM, Baolu Lu wrote:
> > On 6/3/23 2:22 AM, Jacob Pan wrote: =20
> >> +ioasid_t iommu_alloc_global_pasid_dev(struct device *dev)
> >> +{
> >> +=C2=A0=C2=A0=C2=A0 int ret;
> >> +=C2=A0=C2=A0=C2=A0 ioasid_t max;
> >> +
> >> +=C2=A0=C2=A0=C2=A0 max =3D dev->iommu->max_pasids;
> >> +=C2=A0=C2=A0=C2=A0 /*
> >> +=C2=A0=C2=A0=C2=A0=C2=A0 * max_pasids is set up by vendor driver base=
d on number of PASID=20
> >> bits
> >> +=C2=A0=C2=A0=C2=A0=C2=A0 * supported but the IDA allocation is inclus=
ive.
> >> +=C2=A0=C2=A0=C2=A0=C2=A0 */
> >> +=C2=A0=C2=A0=C2=A0 ret =3D ida_alloc_range(&iommu_global_pasid_ida,=20
> >> IOMMU_FIRST_GLOBAL_PASID, max - 1, GFP_KERNEL);
> >> +=C2=A0=C2=A0=C2=A0 if (ret < 0)
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return IOMMU_PASID_INVALID;
> >> +
> >> +=C2=A0=C2=A0=C2=A0 return ret;
> >> +}
> >> +EXPORT_SYMBOL_GPL(iommu_alloc_global_pasid_dev); =20
> >=20
> > "dev->iommu->max_pasids =3D=3D 0" indicates no pasid support on the dev=
ice.
> > The code should return IOMMU_PASID_INVALID explicitly. Perhaps we can
> > make this function like this:
> >=20
> > ioasid_t iommu_alloc_global_pasid_dev(struct device *dev)
> > {
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> >=20
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!dev->iommu->max_pasids)
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return IOMMU_PASID_INVALID;
> >=20
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * max_pasids is set u=
p by vendor driver based on number of=20
> > PASID bits
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * supported but the I=
DA allocation is inclusive.
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D ida_alloc_range(&io=
mmu_global_pasid_ida,=20
> > IOMMU_FIRST_GLOBAL_PASID,
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev->iommu->max_pasids - 1, GFP_KERNEL);
> >=20
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret < 0 ? IOMMU_PASI=
D_INVALID : ret;
> > }
> > EXPORT_SYMBOL_GPL(iommu_alloc_global_pasid_dev);
> >=20
> > Other change in this series looks good to me.
> >=20
> > I hope I can queue this series including above change as part of my VT-d
> > update for v6.5 to Joerg if no objection.
> >=20
> > Let's try to re-enable this key feature of Intel idxd driver in v6.5. =
=20
>=20
> This series didn't pass my test.
>=20
> The first time when I run "idxd_ktest.sh -c 1 -t 1 -i 100 -m shared", it
> passed. But when I run it again, the idxd hardware operation resulted in
> timed-out issues.
>=20
Hmm, not sure what happened. Are you using the out of tree idxd_ktest
kernel module or the dmaengine test sysfs?

e.g.
echo "Config params for DMA test"                  =20
echo $1 > /sys/module/dmatest/parameters/iterations=20
#echo 1 > /sys/module/dmatest/parameters/noverify  =20
echo "" > /sys/module/dmatest/parameters/channel   =20
echo 1 > /sys/module/dmatest/parameters/run        =20
sleep 2                                            =20
echo 0 > /sys/module/dmatest/parameters/run        =20
echo "Completed!"                                  =20

It passed my test many iterations for shared
in-kernel DSA test, will get your tree and test again.


Thanks,

Jacob
