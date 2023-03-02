Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D250B6A7E30
	for <lists+dmaengine@lfdr.de>; Thu,  2 Mar 2023 10:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjCBJnU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Mar 2023 04:43:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjCBJnI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 2 Mar 2023 04:43:08 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070DD144B4;
        Thu,  2 Mar 2023 01:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677750187; x=1709286187;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+iZWxfl+e0M6chnZcbPXdHB/qASyOWkNRwpDQI8M9ww=;
  b=nSnEGL5u7Yj1t8b9NJ6hORRovIIju9tlVqyNRIkOJA/rgoLVwniNemmU
   /SOOqEsHYKU9olzeV9L6lXewBVArD5KTFe2X+KDTOTvK/qOlmKi67dZ7z
   XaGf+r1b9GsuiqeQCY65oxV0xBylDK66sLl487zWtuU1TaPEM2gD55gop
   cHP6lBQLLoNwkuRvCVA8YziXhgT62Xt22kKgNbuIqjJqYygQs+I6hfQRs
   h7+vKfk7I40HxafKecneJFHIQEiFQVHcUSIQOy+8R2QEbrPxRtttY2msZ
   NL4i0KB5c/sf1t4jgWn30kHBSO3qgxr+IkUlR9u17zGTWjLsNFZCRn42j
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="362266294"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="362266294"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 01:43:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="1004047206"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="1004047206"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 02 Mar 2023 01:43:05 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 01:43:05 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 2 Mar 2023 01:43:05 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 2 Mar 2023 01:43:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LuJX8eTphAQxY+SWHpPCg4bn0rGyLwqmvyLy+qPhbn24fmAK8xQ9oBMc6sbfNMK+18awaj45TvGMEld07pebkFq77yVXXqQMbrisVCCFz8rp/n/QCWTGDJFJ7HgzqVR81RKnCizUl1wCEoHCXf7AuJKl/hP1QjaPBvRIq2ndBF6c7WbRFG6aW/5hMMH7WKuZ2BN8mImuoEEf+rKTmDYOuR/sMMWFfEUtrNNjn0mQgNrusMb30BLg4lgjI+DEIRNadqg3NXWrefcWF2IePYnTUhfzbwvRaCs3/SNhFMAwO098cUmFXCxmreGXj3p9vTUw66y2goWkbrCZt9WMAxPO6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eVBnND5Nqr7uZYX0oADWJU97B0DrvSvAOTIIBhpUVjY=;
 b=kFDxJ3nJ4wY0perutHbAxOdssQRX/i2XZ52r2M8WTg+ZnSiRXfFb5XG3ySAHirtvmqaNuQdaUOqlRqoAWhQ+IFzc24jbGuE5aI2BnMt7K+ywxcjxASgAFpDMrXQ+wOj+vpX2JB9Rq/CpSs/d00In5cwhkFZgDNjsFySIUowYlUdNAAmaMegkza/XmAn0MnmGgUo5l0yQnXqbSU4Fq3IXeZ8z9rSwVYS+eY/ii+aGFbbUWV9pi5OA0RfRkvXPKwmfvDOlJGkuUevQgNQxAj6EJEecg1bnpR5LlLjQbnEbdPkhyTEaMUSymkAGG0iNWxaaKmE5SznYDnZ4nzRWl5KUvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB8122.namprd11.prod.outlook.com (2603:10b6:510:235::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Thu, 2 Mar
 2023 09:43:03 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%9]) with mapi id 15.20.6156.019; Thu, 2 Mar 2023
 09:43:03 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>
CC:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
        "David Woodhouse" <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>
Subject: RE: [PATCH 3/4] iommu/sva: Support reservation of global PASIDs
Thread-Topic: [PATCH 3/4] iommu/sva: Support reservation of global PASIDs
Thread-Index: AQHZTKHLpFv8Ca2hQ0+TT/QlO+gFRa7nPClw
Date:   Thu, 2 Mar 2023 09:43:03 +0000
Message-ID: <BN9PR11MB52765C5E0DC0759880C08E258CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230302005959.2695267-1-jacob.jun.pan@linux.intel.com>
 <20230302005959.2695267-4-jacob.jun.pan@linux.intel.com>
In-Reply-To: <20230302005959.2695267-4-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB8122:EE_
x-ms-office365-filtering-correlation-id: 07922732-21d4-4fa7-fc75-08db1b0284b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IAAzz5WCQUeYkBAsF64Fc6Yn43CIUoz2TQ0bCgi8sVm0L7DhVE2l4iHck6voPmkR6ALfQcoROGPfvXHicu/0jGKMKzm0YesQW5gnCgGVCQ27POLmV/ZCuq0LcGvEq/OtDdh42NAyV/+dINg2Ah5W1NuSsDv834miTNGRT8CPdFq8ZFFImKqcJ00YTT6WBWoFeUlYKnJKkMzy4whGZtMqct+uimEw06BE6akNGX9PRKWdV8V4AiuDjUWoS8jkRpRsEErCvK49RTpb5yLP1Fy2jLnhDcadw96qWd8b7gLiuYnojHTLj3ncLldFLux7y6FFHCDuXwUyaPNaXtjA7euZF/gySsHvqCyRthS5BffNxrxpVgDk0NQ8htFx4BrWCSvjH/O/bQu8tqhbhPloIW7B3tk/F31+EthpU0vFiHqvRPDbT/cCKAqLK4jBZCGoiz+7tuXONxOWllTLcnkpyZMWWJfopqC6AvSNP/jKLfuvXrSNofOL0pt784WoQElAXd9KYbe63fHQ6eqoVvNRHU73k9Z0KtmSM6Kr5T9EeHqaOoOreFpfEbyxANP87Pof4j+E+s8rg9FQvPFf4RD6GTL3LCGxLD4UHgg5KSvMzq+cnX1jf8yRtZCMsh+B6P4eO4yaB3s0vBTYYVxL2ewKhmBKI1PK/RGxcPyJl+sy6ATZEhr55POELi0pnYBDnvwhSRgX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(346002)(136003)(376002)(396003)(451199018)(38100700002)(186003)(122000001)(26005)(9686003)(82960400001)(8936002)(52536014)(38070700005)(966005)(2906002)(6506007)(7416002)(5660300002)(33656002)(478600001)(64756008)(8676002)(66556008)(66946007)(76116006)(66476007)(66446008)(4326008)(55016003)(41300700001)(71200400001)(110136005)(316002)(54906003)(86362001)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wpwJFpChuAlZXKS4Yj5bQJucN/JpY6vgEbPBQPMUW/y8byc5kfeaqAjfwzVX?=
 =?us-ascii?Q?Uji9cuAvnJCBgOZLo3Zj+f0JVSfP/tEUi5NNoKiCkT6DFqYEVW8KGgOULSTx?=
 =?us-ascii?Q?OzBU4nobVsDytY2U+qEEn6lvo6AJlC5fFqCBj3Mi9oBwnG5vqd1ZtmqgAiXQ?=
 =?us-ascii?Q?osCNEKFdJogKVz4CzYUvbUEWegReCs+fQWuISw3BN6n7S+Io3+2vLSRrj1iL?=
 =?us-ascii?Q?LGJCF3xvVYktMBQgPAZPIVntV8XMLlNQnckBpO4hoWhDY0AS9MiRhMXB25+m?=
 =?us-ascii?Q?M5JHJLsVekIcLm5J6z89facyGKTjV/K0b2LnVafgCNvwIT64Vu+8gE4XSzNd?=
 =?us-ascii?Q?Jp4c4mU90KEa5LoiflkIMe3XJ2XKDbeLBNwbHEzp8C4eJwW/Gmrzm5k2IzfV?=
 =?us-ascii?Q?aohyNUrxV4OsoxAq7ZlOy6VFIEFFGXXvWK1Im7Lr03g+gMnAiYAD7BrVuJbw?=
 =?us-ascii?Q?IZOBdtEcMfjz73wysya+WDdlrA+Y2iJTF6Q1EziP/lSdl4jFMBvovnMRbj0P?=
 =?us-ascii?Q?xOLN02z+bBd3xm8O5HHNqFH5X9WaTaEVuyTWRs2OXWFMd5vKTZda489ZdYDj?=
 =?us-ascii?Q?pTjAXDNAWxq5KEvwQShZDBm2K+08CZOyimIgFSjNEKtwulKbeXSPssLoZ+pP?=
 =?us-ascii?Q?IrWZ9ilCqlbk6Ms+Mf5aT5UAXZT9erlhV/3kIVQVEK4hT3QKkRE6vRdGpLtQ?=
 =?us-ascii?Q?EVRefdGokOgiGEB5WosuAz8t+lv5+gMFAKgboUJbw4odomy9g3maRi2Jix7B?=
 =?us-ascii?Q?YjAVD9oxXglWLPY7dq1uQF+H3obWoUOUC/J269mBj3ct5QVMXSsGIywenyiD?=
 =?us-ascii?Q?nENSZJxmy2YM470cM+jFWSQ66E6PW+MCfO3YnL4Z8TSmbkAlrMtFGCxM5xH3?=
 =?us-ascii?Q?L15lPYsbfJSb6wl/VJ41RLbpIOtyETG3OF7TGgLeMNHkyMRnDqeDZ9uEqtcH?=
 =?us-ascii?Q?NJtXRYn4bIM+59CjbPAn6MCYfLUpQg4iWkhY36U+TcWrO6s1Ab0sBj+duXB3?=
 =?us-ascii?Q?3ZWZic4JqiYOHyPm97fQddTmKRYoz0F4rFRseURQer/ePIHzsLoAxeQGWbKU?=
 =?us-ascii?Q?XlrvokzgLBZWcUiIx9EvpciWk2qdaIaunIbyW3pEPnhpmF2snfwhwWwtGAEY?=
 =?us-ascii?Q?O63TNO1YGxT/U+tXZYUxfrfm8nQcA1JdVxpz5Ruhrqdjcjyiw3BByf+3OXHz?=
 =?us-ascii?Q?e8de2+Af8Ts7Nl81e1qWaYq5DyzGp/ETA87w7XTrcN4iTdjUTSVHz36EX1OV?=
 =?us-ascii?Q?Eb8mNcGfESGiXySe75qGqvU/vAeXEo3ffKm+q3T8ROidJ8ZEG+OlC3BsA6Aw?=
 =?us-ascii?Q?o5M6tlBlwvn0NEEdz8MMrAX6IU6IiO1raCkFP7B08z2JC2qsqZ/g4uTf5IXf?=
 =?us-ascii?Q?Et5fNnomiNcfO77bRUfDwNo7YPRHOBRKZv5W6OAeaOSi0T1e9vWjSZPLZN1A?=
 =?us-ascii?Q?KjQRSstXW2Up3KDc86j3gRRa08CLwlqjNWSrQ3q2wu89ca4ogsaoExBdwNMx?=
 =?us-ascii?Q?zcEhKqBFZL0uk8DpZ3qVUfkf8bRRFC0tYwP02Rk31Qh16u3HT4bp5NOvUD41?=
 =?us-ascii?Q?IlyfHwoqhBB9KzwiYD36aIQ4vtEGk9YDbh1rUXgB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07922732-21d4-4fa7-fc75-08db1b0284b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 09:43:03.3435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ubRo8bxbQeOmQfyM9qBmBxCfIedl1klnpKp+EPCCWdDAK0njoX6RCJKt8wgly1Rdy0Hf13RX0i985wO1ZC6Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8122
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Thursday, March 2, 2023 9:00 AM
>=20
> Global PASID allocation is under IOMMU SVA code since it is the primary
> use case.  However, some architecture such as VT-d, global PASIDs are
> necessary for its internal use of DMA API with PASID.

No, global PASID is not a VT-d restriction. It's from ENQCMD/S hence a
device requirement.

>=20
> This patch introduces SVA APIs to reserve and release global PASIDs.
>=20
> Link: https://lore.kernel.org/all/20230301235646.2692846-4-
> jacob.jun.pan@linux.intel.com/
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/iommu-sva.c | 25 +++++++++++++++++++++++++
>  include/linux/iommu.h     | 14 ++++++++++++++
>  2 files changed, 39 insertions(+)
>=20
> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> index 8c92a145e15d..cfdeafde88a9 100644
> --- a/drivers/iommu/iommu-sva.c
> +++ b/drivers/iommu/iommu-sva.c
> @@ -149,6 +149,31 @@ u32 iommu_sva_get_pasid(struct iommu_sva
> *handle)
>  }
>  EXPORT_SYMBOL_GPL(iommu_sva_get_pasid);
>=20
> +ioasid_t iommu_sva_reserve_pasid(ioasid_t min, ioasid_t max)
> +{
> +	int ret;
> +
> +	if (min =3D=3D IOMMU_PASID_INVALID || max =3D=3D
> IOMMU_PASID_INVALID ||
> +	    min =3D=3D 0 || max < min)
> +		return IOMMU_PASID_INVALID;
> +
> +	ret =3D ida_alloc_range(&iommu_global_pasid_ida, min, max,
> GFP_KERNEL);
> +	if (ret < 0)
> +		return IOMMU_PASID_INVALID;
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iommu_sva_reserve_pasid);
> +

I'm not sure it's the right way. It's not related to SVA.

We should move iommu_global_pasid_ida to iomm.c and then have
another interface for allocation.

Above is pretty generic so probably a general one like:

	ioasid_t iommu_allocate_global_pasid(struct device *dev)

internally it can use [1, dev->iommu->max_pasids] as min/max instead
of passed in from the caller.


