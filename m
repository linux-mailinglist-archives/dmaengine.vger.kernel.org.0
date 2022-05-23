Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 648C5530C2D
	for <lists+dmaengine@lfdr.de>; Mon, 23 May 2022 11:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbiEWILl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 23 May 2022 04:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbiEWILf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 23 May 2022 04:11:35 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DA2DA0;
        Mon, 23 May 2022 01:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653293489; x=1684829489;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sl6/9JLUHTFJB+ti4PlENudXA/E1AmkbR7NoHaodVzs=;
  b=HyQP6uuRNIZuhtcsTUrEYMuPXLMf10UrVZiqvSZcExnGba9h9jmJX1jt
   zdhISQEa/CO/bTD4Tln+dcdzNlzTjgZIjT49iYjwLkKT4M9h7QO3Ke46b
   CvNC071O/H/FxpcNONIkn9DKwfeSES6vPOIkXDcrcalYAYrbL5oTrrOxN
   94g3ICaI/UQRr6vFDSyCUs8hI1in1w1KhLjx9HvRo1yRota5v0D5mu2wP
   iNsW38xMf+4ArgqVvYM9y00dk7/avxAb8bEaNYytwOX0llYntPDxHWgw7
   DdlQKQdMbvs/92ZiXEQkYY0cdvDRUb+t0R574hvi4EeMfp5vXfSSID1Td
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10355"; a="273259735"
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="273259735"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 00:55:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="663313840"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by FMSMGA003.fm.intel.com with ESMTP; 23 May 2022 00:55:10 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 23 May 2022 00:55:09 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 23 May 2022 00:55:09 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 23 May 2022 00:55:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GaSkl4ZTjFNUKSM5a5qKjw8Lb3ecotqtFSDsXBM8ntpXIODgmEjfFhQVTCgqXVcrYQrBMDSgfSVmUGFTjlHpU1yLK2pz73tLgb83KkG0JxR0Sw00iOXie5VRH/JFm8ndOTIc1rdjs2AMA+6pHk9hBRF82L49oswLdZQ0m8HjaJKUNpOaic154fRW483W6zIA0rosxWYOvECzevyUzbLmbefmTNJ9FfK+YoOZQlwCs+dKwJqngZEMpENjDlHhpIYWA9aGnNzxvA3aY789oEoKqmD8MEz18D8tEVeX88IuUVB28wcCT2PknA+X/idykziMBb3ioDwDLl0f5ZqM+2j1Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGgM54O4wWvAciivwpAF9r0vnhZaW1Lo6WSkDbkqLpY=;
 b=K+OsCZIFjRALL8rED/L9iW0znZFtZx1T2pQDW8VO8pK3wFTUcMVObnS4clt8mmwbVzF8xRyIaCWlOuFwG+i918lwShepBk/g0XNjk7OdzGxt7WQctWw4LuRIBfO++k99M6I1liMLgsJb8rpXyNqgrgldV7UH3wbfB6ejqnxjwXyCxXGB1I5+SZhzSt4hb7bW6v7X2AENQLiYucm3Gq44hDQPCm0Xpykmjr/wa3GI9GRoSkxyw7VMB6b41yq0FkZCLdZZiIwV3NaFXH7wnj3/g01z/5/SFh8NZtB7EUxbAOo3oSFYHjQZENiwwETFkRLVGaD5yilY8sSFP+3EeFXtEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW3PR11MB4684.namprd11.prod.outlook.com (2603:10b6:303:5d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Mon, 23 May
 2022 07:55:02 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb%2]) with mapi id 15.20.5273.022; Mon, 23 May 2022
 07:55:01 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "will@kernel.org" <will@kernel.org>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Eric Auger <eric.auger@redhat.com>
Subject: RE: [PATCH v4 2/6] iommu: Add a helper to do PASID lookup from domain
Thread-Topic: [PATCH v4 2/6] iommu: Add a helper to do PASID lookup from
 domain
Thread-Index: AQHYauORUoINsxb/TUyuLPLPKASxAK0sHSGA
Date:   Mon, 23 May 2022 07:55:01 +0000
Message-ID: <BN9PR11MB52761FDB9388AFAA530544248CD49@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220518182120.1136715-1-jacob.jun.pan@linux.intel.com>
 <20220518182120.1136715-3-jacob.jun.pan@linux.intel.com>
In-Reply-To: <20220518182120.1136715-3-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b9ba1a10-19b1-4491-4f1a-08da3c918a89
x-ms-traffictypediagnostic: MW3PR11MB4684:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MW3PR11MB4684CE82D626FF153858C7D58CD49@MW3PR11MB4684.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3dDbggtWZds7WUGdl0Ug1MFNo47XvAMSoLqqP9pctiuteiOqpY5FU4/7fQwzMDi5z6evlCJhMPQxmJyrI3w8RSPqjXJRvgFwGoqeMNzWEvu5O+L3DoH2iraQVqQ3ZUhLRUK/VVrnaAl4K0rCkqnqqOiwtHHk4OCZVJIqNMW1hh/uXS3d5GxI6p4GdAdaAcjxUgNnB0sBpKXJZxe1kGJgH5xUjHrqZAroBs8FgPYmIJ6ULL1bfQc9KdyTt2tCn6Y8r1+Rh05cW6cMvvR6Ru7+0W6ZN8kQpZSuVpnMX/2oZfmiyEtJ/WqDzqDDDCLzkKCamK5IX2u38kYhKvPN27CUoxgEaZUvuBVrSuhPmWXA1CVvtGHse8EUK8mcNRF4AL0OxXpEwtMEtD5RC7Dua3OT4rzKSmtjm52ookBnBntV1EOSkZkSxIx6ig0V9hxjLK+f7/WoqRAY3HYiqJPzu004/uWj736zATrtjTneYuNKokMfKjJI8fMXCOJp4VnQclJiChA1IiYuWiJzp2GYp9qQzYVvia5dQPJshpXdwRa60xJJ0QKaGUWqDq3rCfA1ZvASR9IkrFb0D7znnDmNVaIoMvv8T5HnUmTHp2UONa3JhJQFFQVxT74Id2h0zMLdhgdALelUNv/+JcIFzCqB4U8C2xC8gLsnu857OnZfoKm7XHld5mVZveFGakyQ9KGKp4q3t7bAKMQIGtF6/wO47ijawC8CKLAdcBWBV7TtGIFULaU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(71200400001)(316002)(9686003)(110136005)(54906003)(55016003)(33656002)(2906002)(7696005)(6506007)(186003)(26005)(86362001)(66446008)(8676002)(4326008)(64756008)(82960400001)(5660300002)(8936002)(38100700002)(66476007)(83380400001)(122000001)(921005)(66946007)(66556008)(38070700005)(52536014)(7416002)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LGcZe//3lp9epTlZB+0iBHaG7n1SpBIOvz5fb2C8RFIe9JK2+bjSu1oCXIo8?=
 =?us-ascii?Q?yyLs79fTg3Gg0VGEK26ZHJoeW4d4p0zXwruDLYM4ZpdgxH7yN5m3gniVK7tx?=
 =?us-ascii?Q?AdsBl7oHr9M0KfbfNuLVAJdrzLMejC8KR4eVEvST9Bg62r7cDT9q0NV0thJ1?=
 =?us-ascii?Q?2f3Pb0rmMzWr2UfY8ZjfpeBfJ3vFwsRL+T+X2WCUrk+/SsFBcw5eJD+6wWru?=
 =?us-ascii?Q?qVN/wjFu5Idb0IAuKPHn3/x8IqIWGRKWDw1nHnS/SdTzUKDYdM43h3Tn/Muo?=
 =?us-ascii?Q?jXRUOW0ssLGXxuaKziyNfSLe65XdoY/Dgfmd/T0j4sDCMDu1yxVzokvFe6QI?=
 =?us-ascii?Q?yma5fgxR2bw/tdZWy/4kog9fevZW+t8nlNJOS2EypXKWe/Wih+mN5537jCMt?=
 =?us-ascii?Q?ATje4I8pSin+Ah66RIGpf0zXnhkkb7dmYyPk8GcRNblSfwRdIbQ/LBtc/vlt?=
 =?us-ascii?Q?On/dqP0cNfr9sS6shymOunL/Svhu0LkS6HB8IPRXZPNrgXHqmc62xBYgksdH?=
 =?us-ascii?Q?XMgkLqt4prc8OtpOXH5HIS/JmVl3lTmAPnHpGJe5fz4kB6Ic0JVoL23Sg6V2?=
 =?us-ascii?Q?TZnjPVKmvQa5sxLSYqoCIO+qOkZ2kZk7mSDA8p6X5Iu6V5/XMnmO0krvtzAy?=
 =?us-ascii?Q?DlbUAXS9YiZD48SALEGu3inkRTXtaGxOJAhJu5veGLgw092ZX2g+xy+txKCA?=
 =?us-ascii?Q?UMLOR4CyC2hvdPbnuwnQQdt+7hHpl97/4aPsitqk0OfFhJk6H5WzPhxaJTRJ?=
 =?us-ascii?Q?ZZAYAcm+aE9G5d3oeltw6j+b1W+6CBV+IFQDS1j2868B/GRV/AZS+rZRiePN?=
 =?us-ascii?Q?Ppp8lIZ/0HAS+HWSqyp8gVo0iT8HFubhU22R7ZOUbFkROBkk2GYnWI4CPxzw?=
 =?us-ascii?Q?n4pskd4i1Y9doX7ihhvimNV/4HFPJa2IQCjTLPYXMEPbeFcoaRBr6IaPVlzp?=
 =?us-ascii?Q?ErQFxOc/OF90CotdWovQ7ksXiw46nkX0wBBnPA/IOBFd+lLaF6VQ++L6B7i1?=
 =?us-ascii?Q?B3IOrgMdRBu36XAOopif/vHGMmq4MUsIcosYA0yNSyovDeuDlYwv6G01p366?=
 =?us-ascii?Q?GjjlPs78cyRlNcKkxgdDeCsvKMkflQciMERGVCAIJfaNs6GDxwH05vT8bo9w?=
 =?us-ascii?Q?td1XSeJkwdk6xANrWAXcPMP9PEnmBQZqUA3VBFw5BwBCDtsRBaCzq4GsmC4h?=
 =?us-ascii?Q?s2I1hjNa+nP6E00/U6Z1cQa4OQxyoOkIWs+uqbh1+XlM6npK5ZF6f7OMVBR+?=
 =?us-ascii?Q?PINynCqtiUoCV2KaH/obj7mdHTmpStjBBJzPEzEUKZX6bXMCjjhg+h+MLvg1?=
 =?us-ascii?Q?aaVKAEW+fCyvm86ge6yuajyeRQkRqJG9hz41JYOB6aIvFt/1Tcyn2PTKxzK4?=
 =?us-ascii?Q?SuR6D+rqF5R/itWlR5SAHPOv/qwLqJewkDfGB9vf0Hg6j11WwCFsy5nxnlTQ?=
 =?us-ascii?Q?pRULELGpm481xKaKRT49kKUiFkB0ExTP3x8qE+Ebggm+O0i/hU6c4y5iLXti?=
 =?us-ascii?Q?jtZkbycqLAr4YRlNiwnn8NA5i8gMp+9a5oh1BhdHyxO3FexKrg/2D1PrXK+i?=
 =?us-ascii?Q?qfBvkaYSEbbG1jkr4vZbiYoTtZj2ShzS/CvYxsDz08/RxNq/uJBD1PVKARwd?=
 =?us-ascii?Q?DaLAQLMAgAZKxi9kU+zD4OlMT1osMP8YYx+FpVGey8ib0dU4kSJT4cWeNHv2?=
 =?us-ascii?Q?PquP8dUJO5wtHRrqkpO4ZCt+vdDhJqTeR/bJpXwuSclTnKlozqMDDhgyCUEZ?=
 =?us-ascii?Q?bpPUg86dtw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ba1a10-19b1-4491-4f1a-08da3c918a89
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2022 07:55:01.7901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SLVt25K+OC/wMFygT3paD3fEAN++ApJwn2K48rj+3FnjaguiAMVfgaWAxn6pVSA5g0EGhH8b54aG6dF+z9p7EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4684
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Thursday, May 19, 2022 2:21 AM
>=20
> IOMMU group maintains a PASID array which stores the associated IOMMU
> domains. This patch introduces a helper function to do domain to PASID
> look up. It will be used by TLB flush and device-PASID attach verificatio=
n.
>=20
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/iommu.c | 22 ++++++++++++++++++++++
>  include/linux/iommu.h |  6 +++++-
>  2 files changed, 27 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 00d0262a1fe9..22f44833db64 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -3199,3 +3199,25 @@ struct iommu_domain
> *iommu_get_domain_for_iopf(struct device *dev,
>=20
>  	return domain;
>  }
> +
> +ioasid_t iommu_get_pasid_from_domain(struct device *dev, struct
> iommu_domain *domain)
> +{
> +	struct iommu_domain *tdomain;
> +	struct iommu_group *group;
> +	unsigned long index;
> +	ioasid_t pasid =3D INVALID_IOASID;
> +
> +	group =3D iommu_group_get(dev);
> +	if (!group)
> +		return pasid;
> +
> +	xa_for_each(&group->pasid_array, index, tdomain) {
> +		if (domain =3D=3D tdomain) {
> +			pasid =3D index;
> +			break;
> +		}
> +	}

Don't we need to acquire the group lock here?

Btw the intention of this function is a bit confusing. Patch01 already
stores the pasid under domain hence it's redundant to get it=20
indirectly from xarray index. You could simply introduce a flag bit
(e.g. dma_pasid_enabled) in device_domain_info and then directly
use domain->dma_pasid once the flag is true.

> +	iommu_group_put(group);
> +
> +	return pasid;
> +}
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 36ad007084cc..c0440a4be699 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -694,7 +694,7 @@ void iommu_detach_device_pasid(struct
> iommu_domain *domain,
>  			       struct device *dev, ioasid_t pasid);
>  struct iommu_domain *
>  iommu_get_domain_for_iopf(struct device *dev, ioasid_t pasid);
> -
> +ioasid_t iommu_get_pasid_from_domain(struct device *dev, struct
> iommu_domain *domain);
>  #else /* CONFIG_IOMMU_API */
>=20
>  struct iommu_ops {};
> @@ -1070,6 +1070,10 @@ iommu_get_domain_for_iopf(struct device *dev,
> ioasid_t pasid)
>  {
>  	return NULL;
>  }
> +static ioasid_t iommu_get_pasid_from_domain(struct device *dev, struct
> iommu_domain *domain)
> +{
> +	return INVALID_IOASID;
> +}
>  #endif /* CONFIG_IOMMU_API */
>=20
>  #ifdef CONFIG_IOMMU_SVA
> --
> 2.25.1

