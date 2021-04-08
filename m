Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C37535800A
	for <lists+dmaengine@lfdr.de>; Thu,  8 Apr 2021 11:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbhDHJ5M (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 8 Apr 2021 05:57:12 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:13222 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbhDHJ5M (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 8 Apr 2021 05:57:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617875821; x=1649411821;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xYqSTkq9Z3lQ3Arw0meQKfnygfV6K0U4f94ZaE6VJ68=;
  b=pIrmuPJVp1epTlDszqFCOoNVno4Rni/1OFC51xihU4Ho3UZ2EoD188xr
   WtGEgttgC1Pr4YAVeZmhYhUBl4rNElGDy9dsd5BGRpXGd+ZC1x68koQva
   dcfrgyivAh5vaAdT6uBxELXAsrqrqg0+uX/zOHqyR+rPvgBFZBgyKv2Za
   dQRukX6F1TcgHtrQosvAKn/84N7b/raJd6cJg0hwsbOLWe1ng4QIeWEWG
   IHwaxfP+7OvJe4KycqPDrK0icUov72Cng8KY5ghQWtf93jFdELiRrHXZ5
   pjunLR8B9RmKz/pZguwy9UnWIB4qkbxzPjJpWiR5sfIySWcmOUloanxsM
   g==;
IronPort-SDR: R2H/Qv6cYa2GbKnTuDQd1PRLH9RsY/mxOPf52hZUp24pILAA/et4JNJgPsfGUpsxwKa0tU4NIf
 NIeJCS+k1VN3dojFEVCnHpe4zv8ACtyOjVVdgFooyDg+zhD+jp9aqaHNNgncHvgoZgL4IH+NTJ
 d1kbSU7cFsqcfa+gL1s0YPjZSdNfrteRw20wZyH7Wj3ZmHuyyAV6pq420+3ukiga6KaFXrNk04
 icQYR9E60/vbdeVVW5MCl+Z75BHy803ivFSsm8x3OUBN1TfjLa6RM7A6eeQgFWWdSSr9O+Z4mW
 gcE=
X-IronPort-AV: E=Sophos;i="5.82,206,1613458800"; 
   d="scan'208";a="116270388"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Apr 2021 02:57:01 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 8 Apr 2021 02:57:00 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2 via Frontend
 Transport; Thu, 8 Apr 2021 02:57:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LbpfoBHv26grpw8/s4yo8YC4VAiGYH0lK+5O6Y5fqjbBtPtvMOWLz6FiAtWizY/sYifycxZeNmqAs7NgG3Ej4q0FfCglJyCSNCOCvUyp2HjmrAQLV3KWgVqC4QK5eTEUFRjeTvjq8BMWOYXatbPEcPmQkHjvbcJlV5SbBOHiKprLQDh5vdQ8J/0T5xE7uMBvhBtdSuMqnTae0U18mA1N6tdiEGyN+eJO6V9vqhvCi693n/kp1sJvKHPG6BB/EMeZ0z16Xs0ESBxqGVUl7lPPbxuvswu15EDpcynfuVpV5kwO4ztLxCH+H4wMFfKLh3awsLuaehOuYb35uOCdRIIRjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZSfxpFg5AN+YrHVSW5ncf9OLk+qVyBAn3AvSoR0EFw=;
 b=l3TvSaU3beygyE6mGBd2acwQFaxZj6qFTYYr7H1FmCLB1Ij5KodajLiWjSYg5/ccyLCYcHix/Mr9qB+2lPBQPW2W/Q7tiGQwl3M9UFlUJ6dKLFyV/HRHHLFcNhvQ2UxVWtaBNcDCZ6721PfvLAkwEAKQSRdDtUEZYZzmzzpuTZYwk3bZ1gMReansvNqM8Oj3hGY3+a2KHLi60hp3H9geQPOMKvxh8E44Qo7RanPBgf2Iqo+SJErNmrYcnfyPZae5cz9+/zIaBA/MY3rHKMVmyGgu4c5nc6/oZkvOytNDSlnw3o8JN15vJMe+YksqQTLNMWWu4uj9JKSSSapzx8WsTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZSfxpFg5AN+YrHVSW5ncf9OLk+qVyBAn3AvSoR0EFw=;
 b=OL8/wlucXclEFLl2OfSMEo2Z7NyQYAzVMNhYIAuxoKr7Vuq4agYj3hQk3vSs4h5CCrbYShQIKyyHvz5nD9SoJ4HloMb6gjRGPNOsn0aw4EFcGJEheWrMpoTVi0gD+RrSSi9Hc1FO5g8SA1fTtZfqTWeC1TB/6hKdK/dkhbI5ins=
Received: from DM6PR11MB2777.namprd11.prod.outlook.com (20.176.95.159) by
 DM6PR11MB4563.namprd11.prod.outlook.com (10.141.125.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.17; Thu, 8 Apr 2021 09:56:59 +0000
Received: from DM6PR11MB2777.namprd11.prod.outlook.com
 ([fe80::380f:b21a:cba2:7c18]) by DM6PR11MB2777.namprd11.prod.outlook.com
 ([fe80::380f:b21a:cba2:7c18%5]) with mapi id 15.20.3999.034; Thu, 8 Apr 2021
 09:56:59 +0000
From:   <Ludovic.Desroches@microchip.com>
To:     <yuehaibing@huawei.com>
CC:     <Tudor.Ambarus@microchip.com>, <vkoul@kernel.org>,
        <Eugen.Hristev@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 -next] dmaengine: at_xdmac: Remove unused inline
 function at_xdmac_csize()
Thread-Topic: [PATCH v2 -next] dmaengine: at_xdmac: Remove unused inline
 function at_xdmac_csize()
Thread-Index: AQHXK7GbBSUPHpYL/kysFfGJ/FG09aqqY6MA
Date:   Thu, 8 Apr 2021 09:56:59 +0000
Message-ID: <20210408095658.ev5pziemtwtx4op2@sekiro>
References: <20210407132543.23652-1-yuehaibing@huawei.com>
In-Reply-To: <20210407132543.23652-1-yuehaibing@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [109.210.128.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ab113bca-0d22-43c6-cd3e-08d8fa74a701
x-ms-traffictypediagnostic: DM6PR11MB4563:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB456364B5D02F9190403A4D56EF749@DM6PR11MB4563.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:194;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /CygJnod30Kb4EDNZXDawQWF3BdPpq/Z3kvAyNdd67oOM4az8kKjyyWeoXGsHpRTwQoCpzCPBj+jzkdfoPP+U5O39PjCbPeKsMXrDLcwR+3m6FReRdltEjPGe2RYY9pIiowL22x4djmJ4rFtI7ZTeIWcHOY9C6wQZUsA2fXqyeCtiOyjgmssSmE6zOi6jggr8AjVa5RXCaDOWh7KJZswS1rcCixRNNkGofCboXQxsUzsSpx9UWDzOK6ok2RuvTjR+rUsah86FogQ4q+0wB1vr9DjKPu/RBat59HutwF89jVGZMvCJNNz6edeyhYtGSW4vKox5HkeZ25e+aJ20nm6qAumcGHmdia5t5gezaWooQmLt+G+nWveIOwcIS3Ou5ZL3P+y7+/1O28XU+O7qqhd45vRQCABzBMiiA3NsjKRSrsMXWLAvsWqqbsuaufj2JcP8iCgKr2CqvAnM+21k9MjPo8p0F2q9bR0fScmPZgy4edxhfF52qtaKYRyI0t6EuRCpv2Lcg+pUmaPvxa+rF1jYdWPPkJdTT1LXjRtJlNA/MXQjEvclwkfL/7ZqKW7t1SXTL/L+3BxLNGYr96CJcKR7zoYA86i06O9wTrQlzSOjiGe2kX2V65RQBrsloXUUnTlJzInilSX4P5vIvvH+A0fjqwNLLTnMOc9cZlFBIZn8nc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2777.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(376002)(396003)(39860400002)(136003)(346002)(86362001)(9686003)(66446008)(38100700001)(33716001)(66946007)(6916009)(64756008)(26005)(76116006)(66556008)(91956017)(6512007)(66476007)(4326008)(5660300002)(316002)(71200400001)(1076003)(6486002)(54906003)(8676002)(8936002)(186003)(2906002)(83380400001)(6506007)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?7Q0QUmigorQOlBjQYNKJx9/PtNI7cS+fbDFLUvYPYej9RVizC3dsNOI3ECs7?=
 =?us-ascii?Q?vCQPvWAkIUXzQ30I8RXDRkHQgu2G7qdLud0jDeMxPb3Hw19MpO7maFRuL2fk?=
 =?us-ascii?Q?adWXJTPRHDD6NTipwnsY+9yRJziLVr93miWl4CIDIZs8ZspUBLIJ9DbQpYkf?=
 =?us-ascii?Q?GtanBhQmEAdi0PpgO4B1LEBvsu2njjMCyucaIvzVtZ73Uf/GGBQgAuBtGNsc?=
 =?us-ascii?Q?YyunBHv+b5Y7AvV9Um1zyoKXT61wA89OpK6NJZI4/xsEFOvAuXzMuv2vpZVn?=
 =?us-ascii?Q?lxQiGvFBTgBJunUrYntf86Y37USbY6sZeEwLfLYi6dyp1w/7CCoYjPrALHUD?=
 =?us-ascii?Q?9RCIxoQfopJrEbtGHuPjVqjgQgq9wwn1BAq7hj2qp3yU+uuYpyf7/khXlDNW?=
 =?us-ascii?Q?pARwodqfqitg+MYq831yOI0LOeq9XV5BPulPnR30ikYxhWEFjekP/aHJJN/Z?=
 =?us-ascii?Q?2JEPjuVQ0U+5CM6cUDahc+icK8Ro0z2PsYgsmnwmut9I/GSWwcLcmLd33XXz?=
 =?us-ascii?Q?DoqKI5yznqf4CSw/CEtX78gKKqgd2lrhQyjbkZ1ETr3YPRbfCq5TWAtj62z0?=
 =?us-ascii?Q?J5RjmZgZ0grM2WeuRI1hdS2Felfn0n8mhJ5jh2rJ4BLMGxRJFHpok3ajqMbL?=
 =?us-ascii?Q?cw29gRb95OK8Z2QVCrwSbR8VG9Y/WTokVUaRoI1wEMygmvPse4MTlGg/qmkd?=
 =?us-ascii?Q?MXjxwPXUa6i5EB8E2OG3QwwL+k+rl5Tx0y9ExZO/uA6zCBj9Fb0O/WX8jxIc?=
 =?us-ascii?Q?iucRoecGxyuE5BiBqjSnSQp/EF88CxooZ19/YX+b6arYH9G+VopquJlXPYEE?=
 =?us-ascii?Q?CQCbA5lAbZtnQUj8m/1RZUQYiIB+4er7npLvbuQ7cyH4aZOAOMTEdMSgOrzd?=
 =?us-ascii?Q?C8MP2Szjjv/oS9ziJW46tmdb1NZ+9tXOhbCpDb7m/ntC+xwKM8VXK9G+bQ4r?=
 =?us-ascii?Q?mu0YzWQNdgDGMzpUVvCVPKj+FJqUHkXsRZUdMWxU2JjN0NvGVbnS4bI8vAjD?=
 =?us-ascii?Q?2A6rqzGRqU0vaw+GN9U/BWbGGx9ITjhbdzH2dA1aMRG3ooPlb6B9e5p5rRfX?=
 =?us-ascii?Q?mWEfWV6NN9RSnGGjgXnbCzALXrW9MD2lz7Zb4VV3gBF1gpVTZJNEyLBayYKi?=
 =?us-ascii?Q?IH1aFmRrwmj3h9aTYO2exMJYPQ2z7w46dTKPEzPz5gUjSQeWt8q9my4dk595?=
 =?us-ascii?Q?pwd/hti8nt9S3BrKRrjEbPRbWY/XIjZRWRtuMvvXjL7wKFKSlF4z+QFm/hdq?=
 =?us-ascii?Q?h18yEqLHEb+tSy3d4U5eDOx9xQrqydvGR031XpqVFwZtjA/f9H+HwHRNP2i2?=
 =?us-ascii?Q?cK1d63Wfg0ZjlQZNEtlyvSl912fwHAnzGjXqdfLBJ1tbjQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E45B7000A30BD2489ABFBC7C9DB0B767@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2777.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab113bca-0d22-43c6-cd3e-08d8fa74a701
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2021 09:56:59.7349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: niuW0hU1t5CEf8kfLWnthb06XQaxFacy4hYGqBMbDp/tiisY+LY+pV//eAvb3lYhknGmevg3htI8WQm6Vei0eAfCtWpCHiAyQ5d22WDSvt8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4563
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Apr 07, 2021 at 09:25:43PM +0800, YueHaibing wrote:
>=20
> commit 765c37d87669 ("dmaengine: at_xdmac: rework slave configuration par=
t")
> left behind this, so can remove it.
>=20
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>

Thanks for the cleanup.

Regards,
Ludovic

> ---
> v2: Fix commit log
> ---
>  drivers/dma/at_xdmac.c | 11 -----------
>  1 file changed, 11 deletions(-)
>=20
> diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
> index fe45ad5d06c4..64a52bf4d737 100644
> --- a/drivers/dma/at_xdmac.c
> +++ b/drivers/dma/at_xdmac.c
> @@ -344,17 +344,6 @@ static inline int at_xdmac_chan_is_paused(struct at_=
xdmac_chan *atchan)
>         return test_bit(AT_XDMAC_CHAN_IS_PAUSED, &atchan->status);
>  }
>=20
> -static inline int at_xdmac_csize(u32 maxburst)
> -{
> -       int csize;
> -
> -       csize =3D ffs(maxburst) - 1;
> -       if (csize > 4)
> -               csize =3D -EINVAL;
> -
> -       return csize;
> -};
> -
>  static inline bool at_xdmac_chan_is_peripheral_xfer(u32 cfg)
>  {
>         return cfg & AT_XDMAC_CC_TYPE_PER_TRAN;
> --
> 2.17.1
> =
