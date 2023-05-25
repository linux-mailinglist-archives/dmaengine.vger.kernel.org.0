Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE22A7105D7
	for <lists+dmaengine@lfdr.de>; Thu, 25 May 2023 08:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjEYG45 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 25 May 2023 02:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEYG44 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 25 May 2023 02:56:56 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861A2C0;
        Wed, 24 May 2023 23:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684997814; x=1716533814;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4TIoKgqxhRvDKzXbnDf83EfY4O5HLsv17GznI7l5NQc=;
  b=QqayjDg9VHae+qPLxc/FlJhNuI8iwO0ERLsmmPLdLcUU0O3I+AFpMogY
   kg0u6WyxRqH3asNrAwn+o2bz0eG9iTvDEsI1xpMrtqP68G4LHmmQT2fDh
   s5VTzOlltezZTtODuyXu7pbRu/DdG8Q80JW2xPioGvV07Zb64fK9XWb5c
   94rfjk3ufQPwnSLLPSo9oUB4laJ/e1L9HbVTr6RH90uqEdqGHUymr5PGy
   xl8Z4WFEUEX90/7TmJDmaeW41z2Srtqmhh5WZ0YkTmyUW13lJKefc5Dto
   0X+toYRhaCANFy2iUdQL0QkfUehE5eapf+EwvOt+gAExksGbmfM9lbODc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="338377246"
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; 
   d="scan'208";a="338377246"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 23:56:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="655087552"
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; 
   d="scan'208";a="655087552"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 24 May 2023 23:56:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 24 May 2023 23:56:36 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 24 May 2023 23:56:36 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 24 May 2023 23:56:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rb60pRHdn1Zs3fdMRU6And/I9fq5+whz+lziSJqxBHpo7kRDX0Q2sTsccewzI3H9He6K3BkWvmaJ9YzQiBEqbMnhCFB0ZKayXKX553pQ7oBaxnevreCFTdP/n4lMQfmvOETSOIQZMCpsVru3of6Nik5OPQ625Eu5UlbIj1uG+pSh1CqJIlrcswv3K1hJmJxIdEoNAoHS7VbudY0cN+0xCGLvyeV4YGMtELo6BX4Us294YO0dzsWZu5UQhZ+fjPyMu+a+urdac8FHUf4qA4mOdi5AT31aTpH6DkVrf+HYp6Mp1nJ5Mx7wFarWYLW45+bxdmCgASV0khPzRBZiHzquKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJusnAPyo5KjF4o0yJvgYKeFg8b0YHl30c0Lr1w7pK0=;
 b=Q6T46QQ7FzK3PLP0MTi5e1apgre2dPejzJUElF9zxEhsEEyYcnTZ4ZFH0PyEmVuqqyfZyS8VKCcV585efccS5SEHoEhjlqkyUcwi+igzvHk7jUgIYJlnPyhAn63eQKayeMtbSv9VEgUnSjzV2KesfjydZZKmSxyvmGPGt92cRVmBPMYz+C2umhSr0OMPzES9QsDKmzeIv4h1dP8frJtQPFlz86AzzakZiAWEqmElfM8f5wyq8JkB+VdmTNKTUCyDaxYwQ1iuOSQmRhCQIa17sfR3VF11fLYSikTf8ZY6Y2F5gyiETIQQFF/TISpcpDkkCcM+0rpA7jf3+mSxv+QXAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by LV2PR11MB6024.namprd11.prod.outlook.com (2603:10b6:408:17a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Thu, 25 May
 2023 06:56:34 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dd3:4277:e348:9e00]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dd3:4277:e348:9e00%3]) with mapi id 15.20.6433.015; Thu, 25 May 2023
 06:56:34 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>
CC:     Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        "Ranganathan, Narayan" <narayan.ranganathan@intel.com>
Subject: RE: [PATCH v7 3/4] iommu/vt-d: Add set_dev_pasid callback for dma
 domain
Thread-Topic: [PATCH v7 3/4] iommu/vt-d: Add set_dev_pasid callback for dma
 domain
Thread-Index: AQHZjZxI8RRUCSa7gUG6SDjy6Qi7Gq9qiM7g
Date:   Thu, 25 May 2023 06:56:33 +0000
Message-ID: <BN9PR11MB52760139A4844C8DF0EE1BE98C469@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230523173451.2932113-1-jacob.jun.pan@linux.intel.com>
 <20230523173451.2932113-4-jacob.jun.pan@linux.intel.com>
In-Reply-To: <20230523173451.2932113-4-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|LV2PR11MB6024:EE_
x-ms-office365-filtering-correlation-id: 7864e0ac-ded4-46a5-5c00-08db5ced2d49
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q0RMcPYR1HuBjBLqdky6rReGPx5rYqDIi0ZIoqEqtp53IoJkhzE8R3cxr4wPXg/b9aRRMWtWxJWBbKEPlpQ14bnNjmh55fXvSG+W4tY3wx0uz4csIo4pRasdPh9lMWYktXCKbZuCpGWrLzG4UJSvaOeb7Ih1ROx1dHa2afhSxisYQfsxxBpGRzeXWIln/3Ms6AsQ8RhIakqx2dhLoYKZQaIqx7IJWLdS5q5nD35SNQwahyBp9q0wjqmGL28Q6Yh5mppMxopMkCCf03q5awKFG3Ml+FTsSpa/UNUNSNaK6h+C0tk8JuOFZ489FLd/UC8GTRsdlTtE+IXTmxYGEUCsWc0YQ/FrcjwZ166NMitROoNk3eFydPi4USZjbv3SLSywV0DWWcDYUVheDe3b7Qc3li9YIDDeRoLaL6gcyf6TiuAEuptgJqUvdzOyASZdwSEvAZ4xoieqO3F5Rf66PfTyl6jbcYj2WK5aW7rMAb6RPcOiK3NB8KHsroyW0ffAXb+VP8t2KiF4M/pO66TDT0Acpz2KMzswN9bG4e8mmOnJANkF9G5fq6wwNDzEle4FM90UMgZnAmw7xYKWnjexBAl9dWYEsOi3GLlgq1YtzgwJWcap5af32CRni7Zfso9jMUrO8r9RUr1SobAhWlfl3kzZ/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(39860400002)(396003)(346002)(376002)(451199021)(122000001)(9686003)(6506007)(26005)(82960400001)(186003)(33656002)(921005)(7416002)(38100700002)(83380400001)(2906002)(110136005)(41300700001)(5660300002)(7696005)(71200400001)(316002)(86362001)(54906003)(478600001)(66476007)(76116006)(66446008)(66946007)(66556008)(64756008)(4326008)(38070700005)(55016003)(8936002)(8676002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KUOR4mZaHituXwYc4Ytpd2qYr8YL5JfHP/ChnzE5xIRxbqQ//UmoOxVjV1P6?=
 =?us-ascii?Q?BMs1BtIBwg+8m9RrLx3ZeZsegBfpwMQszQONQqjBEta6f4Y9WcuqgZhX1pVw?=
 =?us-ascii?Q?OPfBiPTFOf/PLWRt3NP86lzvhe/qpJ6w4QjZuWVhh4O9tc/hipPreNfT+u4P?=
 =?us-ascii?Q?avpLJEqYZCFYAO7IJjjWJlrQN9WMVkwLA8cTEpuGkrvQaOX6Za0MHeguDJyp?=
 =?us-ascii?Q?58WN+2wl2sUL6cud2acfUBYNkhvY+2MgvP2o+1N45O1luYELio4h95hdYwlc?=
 =?us-ascii?Q?bwKAJJT1zYH1IYYard/G0CWzuZDTdboIyl6v6M375y7Z9G1dlUhXFJ8/Ninb?=
 =?us-ascii?Q?u59wmNtgUNtEh3UuAcdFXPYAPASqSdgu/5RuzKNPUVH7+yHO+i9JPdVuz5Gt?=
 =?us-ascii?Q?tTjWNhghV/AJwpFCWd3U8eeavysGgv61907C8FfkD+4Rdu6XrfQDbqduCubV?=
 =?us-ascii?Q?0OsU+6d+25NxOEOeWNXm4WLtF23CWYs0zxfFhhwEu6ojFmkBcQECxgRCArKd?=
 =?us-ascii?Q?cCZ3tfvlI287M6InGGgHQ+lyMaxvW2eNBNnBtFtsSgZrh9LoAZyLTuiWg7WF?=
 =?us-ascii?Q?SW4evB2KNf1S6KhEv/ys2Iy9N+nmsbpxTOdC8Hp6hWpsm3P1LnHI+vMd4vwm?=
 =?us-ascii?Q?TXso0U8Hy3Zf8pRVlAjNp8tGz2n0bYFSXSvddRtHQroL8r507tT68oOjZIX7?=
 =?us-ascii?Q?ZEsWy31BnSJFc0An71vMKXbcBvw9eUWQ387L6kBqgB6Fk6fDGPD+06IGRymM?=
 =?us-ascii?Q?lrpEdPwrWvMZis/zi6wWLHO0e3ntplqhczmYFsv0M+x+fY+iuZthtDwS9Rkr?=
 =?us-ascii?Q?zNJuxr4xogp68EneEbxFDC2jfyY430vRmpmG56TZpFXg7HUsiM7CPXGr/Rgo?=
 =?us-ascii?Q?1yekiHTpIkkZhi5mvR9fayMH0yc4XUqPeVqP/M/bL6BJj5eD/+IuU3xjwE8U?=
 =?us-ascii?Q?3GjHJqIpGPPRiJawHiSWtme5STsYo/kGWH71eNViJpVQE2vwmS1UrbeT+VQr?=
 =?us-ascii?Q?CoYv9Mav++tSB6AIxqCD4HPD8euAvSaj72ag3OxsGBLvu9qI1ZIyAKuhkjVM?=
 =?us-ascii?Q?W1vEc5QLlhxRlJpptrvfLRJtyTPmQzwN9twFVWqMI+IVIt+GOwvdVgdWFsIA?=
 =?us-ascii?Q?eJE5Z7lnMCaqFLq6qUE/c6413gBp/cxLNJZyeKwCbetecKljN+YQCBfFoM8k?=
 =?us-ascii?Q?a4sV+mMTw41GTBh3/y3yhtHO33U5heOtQ7A60Ln8LOJ2el+1OAyv2a7wrtD5?=
 =?us-ascii?Q?Ils8jP93eFypYPLJ0FhXGlOnpdKsUq2kVc/Supmb/IzPK18yVs3lMvEGQULY?=
 =?us-ascii?Q?LJEPFmhXfLnWI/nhX6ydoUj5irR+cAjXMtL7d6XfTtuhe3NXPnmsdSHQjUma?=
 =?us-ascii?Q?hGwPA/Lg83frOKLfJgWoEndEAXT5wzkFILGvVUTbloUtwJbhTLpE2EZ66eUh?=
 =?us-ascii?Q?O44+0VHnv/nVvpD8li717RnR96eJ8TgTff9enXL9/pJ9IhO98R+Z8ZWx2CJk?=
 =?us-ascii?Q?R73mj0FBJ7WrBgJhcSMi9AStgR6JSiLji9TsUroXBrRP0DJjqjvQYqIqUheX?=
 =?us-ascii?Q?4atwYicKl276soQa/EHu+kbQa6OQFbUSA0wuM+eB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7864e0ac-ded4-46a5-5c00-08db5ced2d49
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2023 06:56:33.9415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6NbrVTRt0dvHDuhUuIDw16cGawYriMchOrWh3sYwYPGp071zoExr3KDxmH27HH56uTYGiCtCXTGLGdrHNMPbbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6024
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Wednesday, May 24, 2023 1:35 AM
>=20
> @@ -1472,6 +1482,37 @@ static void iommu_flush_dev_iotlb(struct
> dmar_domain *domain,
>  	spin_lock_irqsave(&domain->lock, flags);
>  	list_for_each_entry(info, &domain->devices, link)
>  		__iommu_flush_dev_iotlb(info, addr, mask);
> +
> +	list_for_each_entry(dev_pasid, &domain->dev_pasids, link_domain)
> {
> +		info =3D dev_iommu_priv_get(dev_pasid->dev);
> +		qi_flush_dev_iotlb_pasid(info->iommu,
> +					 PCI_DEVID(info->bus, info->devfn),
> +					 info->pfsid, dev_pasid->pasid,
> +					 info->ats_qdep, addr,
> +					 mask);
> +	}

Check info->ats_enabled instead of doing it blindly.

> +static void domain_flush_pasid_iotlb(struct intel_iommu *iommu,
> +				     struct dmar_domain *domain, u64 addr,
> +				     unsigned long npages, bool ih)
> +{
> +	u16 did =3D domain_id_iommu(domain, iommu);
> +	struct dev_pasid_info *dev_pasid;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&domain->lock, flags);
> +	list_for_each_entry(dev_pasid, &domain->dev_pasids, link_domain)
> +		qi_flush_piotlb(iommu, did, dev_pasid->pasid, addr, npages,
> ih);
> +
> +	if (!list_empty(&domain->devices))
> +		qi_flush_piotlb(iommu, did, IOMMU_NO_PASID, addr,
> npages, ih);

Old code doesn't have this empty list check. I'm not sure whether any
corner case might exist but if you do plan to add it it's better to put it
in a separate patch to allow bisect.

>  	spin_unlock_irqrestore(&domain->lock, flags);
>  }
>=20
> @@ -1492,7 +1533,7 @@ static void iommu_flush_iotlb_psi(struct
> intel_iommu *iommu,
>  		ih =3D 1 << 6;
>=20
>  	if (domain->use_first_level) {
> -		qi_flush_piotlb(iommu, did, IOMMU_NO_PASID, addr, pages,
> ih);
> +		domain_flush_pasid_iotlb(iommu, domain, addr, pages, ih);
>  	} else {
>  		unsigned long bitmask =3D aligned_pages - 1;
>=20

Why cannot this pasid be used with a second level config?

> @@ -4720,25 +4762,99 @@ static void intel_iommu_iotlb_sync_map(struct
> iommu_domain *domain,
>  static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t
> pasid)
>  {
>  	struct intel_iommu *iommu =3D device_to_iommu(dev, NULL, NULL);
> +	struct dev_pasid_info *curr, *dev_pasid =3D NULL;
> +	struct dmar_domain *dmar_domain;
>  	struct iommu_domain *domain;
> +	unsigned long flags;
>=20
> -	/* Domain type specific cleanup: */
>  	domain =3D iommu_get_domain_for_dev_pasid(dev, pasid, 0);
> -	if (domain) {
> -		switch (domain->type) {
> -		case IOMMU_DOMAIN_SVA:
> -			intel_svm_remove_dev_pasid(dev, pasid);
> -			break;
> -		default:
> -			/* should never reach here */
> -			WARN_ON(1);
> +	if (!domain)
> +		goto out_tear_down;
> +
> +	/*
> +	 * The SVA implementation needs to stop mm notification, drain the
> +	 * pending page fault requests before tearing down the pasid entry.
> +	 * The VT-d spec (section 6.2.3.1) also recommends that software
> +	 * could use a reserved domain id for all first-only and pass-through
> +	 * translations. Hence there's no need to call
> domain_detach_iommu()
> +	 * in the sva domain case.
> +	 */

It's probably clearer to say:

/*
 * SVA domain requires special treatment before tearing down the pasid
 * entry:
 *   1) pasid is stored in mm instead of in dev_pasid;
 *   2) all SVA domains share a reserved domain id per recommendation
 *      from VT-d spec (section 6.2.3.1) so domain_detach_iommu() is
 *      not required;
 *   3) additional cleanup is required e.g. stopping mm notification,
 *      draining the pending page fault requests, etc.
 * Better handle it in a separate helper.
 */

>=20
> +static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
> +				     struct device *dev, ioasid_t pasid)
> +{
> +	struct device_domain_info *info =3D dev_iommu_priv_get(dev);
> +	struct dmar_domain *dmar_domain =3D to_dmar_domain(domain);
> +	struct intel_iommu *iommu =3D info->iommu;
> +	struct dev_pasid_info *dev_pasid;
> +	unsigned long flags;
> +	int ret;
> +
> +	if (!pasid_supported(iommu) || dev_is_real_dma_subdevice(dev))
> +		return -EOPNOTSUPP;
> +
> +	if (context_copied(iommu, info->bus, info->devfn))
> +		return -EBUSY;
> +
> +	ret =3D prepare_domain_attach_device(domain, dev);
> +	if (ret)
> +		return ret;
> +
> +	dev_pasid =3D kzalloc(sizeof(*dev_pasid), GFP_KERNEL);
> +	if (!dev_pasid)
> +		return -ENOMEM;

should it check whether this pasid has been attached?

> +
> +	ret =3D domain_attach_iommu(dmar_domain, iommu);
> +	if (ret)
> +		goto out_free;
> +
> +	if (domain_type_is_si(dmar_domain))
> +		ret =3D intel_pasid_setup_pass_through(iommu, dmar_domain,
> +						     dev, pasid);
> +	else if (dmar_domain->use_first_level)
> +		ret =3D domain_setup_first_level(iommu, dmar_domain,
> +					       dev, pasid);
> +	else
> +		ret =3D intel_pasid_setup_second_level(iommu, dmar_domain,
> +						     dev, pasid);

Here you allow attaching pasid to a domain using second-level but all
prior changes are only for first-level.

