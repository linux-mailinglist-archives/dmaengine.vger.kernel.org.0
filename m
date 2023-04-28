Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02BA6F144B
	for <lists+dmaengine@lfdr.de>; Fri, 28 Apr 2023 11:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345054AbjD1JkT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Apr 2023 05:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjD1JkS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 28 Apr 2023 05:40:18 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF022680;
        Fri, 28 Apr 2023 02:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682674817; x=1714210817;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=J4312gBpHoD9PayLywnYXZFhdCh7zurLDQTjbf1/6VA=;
  b=F90iHwaO/yGlCKiqjNlAsFDQ3n3X5lsnf+4kEnJ6ZSkLrHgE+Ja2H8Ik
   bS7Ul6mEaSrWguorUEcHQBK6Jk8kYkXNJb48bLLDBhLS5JJPYSaAYnUKQ
   sFMjqoRsCk0M8imfAOG7S+WV94snqnkf3bmK/qvryBWfimBWX7NIOSjze
   AXOZLBoWszAIfb2NM2wKhV7mMyp6WX+oImxs9nBL3AVEe824H3mQPtET2
   F2vAgdMKAJlY/A6k6HBGG94ggQ6odjyznp/KbTdoD/lEzcG3h820yUMtp
   eipbyJmmIYf0uqZzJExcegIa/oTlh7PfKzJB6cti3NchhP12KWO29HY0z
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="332012542"
X-IronPort-AV: E=Sophos;i="5.99,234,1677571200"; 
   d="scan'208";a="332012542"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 02:40:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="697473915"
X-IronPort-AV: E=Sophos;i="5.99,234,1677571200"; 
   d="scan'208";a="697473915"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP; 28 Apr 2023 02:40:14 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 28 Apr 2023 02:40:14 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 28 Apr 2023 02:40:14 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 28 Apr 2023 02:40:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MuxIeghBiLWcj4ANCpXrdAF0icl4r5D0e25qrR3T5eNMFEwMx41AKdVbLQ1Nu1fiGoH5rfY2GG8AZhVU1qojlejHlooMMynhIKS/aBDTbpwL0Mwv6yNtG9FHUQjRCeO8Yl7QMObjz9cQjb7bLNCcmUNWikWA0/QxHj0nsJ6jw6AwNqjraVkGfE10SX3HdJE7FOpb7udVJaEBScOfl8VnqGmGQV59P7d6jd5w3GIvSiv7e49TSRvXlFN5TZ64YdzDDlzGaVlQrZEj6AQKndmCvqig9zRJL11S0y8xi+GdRBpu7YPq9TjwbtCSh6e3ldLhLZrdDu1jOvR+iTi62kHyOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oe9AHrZJpFZBcWKqM5XZEaZ3/bHx4eH96H/QDoI2bkc=;
 b=koRb898jMyW9fb8dzdcH8ImglFz8knmgffa7Ce1usbTErHqAALoCiWaP0/M44/st/n/cVh9laQNw6DHyPD7zmVHMk7e8E15eqEepDMH1UE9kOdv2VxoXlypsZiwNsGBwQ/LZ7MD76okr8qMSBkStKpfFbD2sNSMxCfp+obH1t/qZ8YcDbRcX4NafBnG0srGeU3iJCUPKWtkm9p5OaJ9IvfscpLTi2SDt3Io6me/Uu+jJ0N4Kq5yKaLRT4ltyKimI9sD96V4UHU1sJoCORyLC6Zl9e9+UXQrireG4L46uIlZS4ceN5kijpuiLdtWNpgYMlRLUmoPdxvTWIHihrTVzew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY8PR11MB6938.namprd11.prod.outlook.com (2603:10b6:930:5a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Fri, 28 Apr
 2023 09:40:12 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174%6]) with mapi id 15.20.6340.022; Fri, 28 Apr 2023
 09:40:12 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
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
Subject: RE: [PATCH v5 2/7] iommu/sva: Explicitly exclude RID_PASID from SVA
Thread-Topic: [PATCH v5 2/7] iommu/sva: Explicitly exclude RID_PASID from SVA
Thread-Index: AQHZeTAT/rkavmSXnkuwelIyLgcV1K9AeBIw
Date:   Fri, 28 Apr 2023 09:40:12 +0000
Message-ID: <BN9PR11MB52760C0384F37927AEAB0C1C8C6B9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230427174937.471668-1-jacob.jun.pan@linux.intel.com>
 <20230427174937.471668-3-jacob.jun.pan@linux.intel.com>
In-Reply-To: <20230427174937.471668-3-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY8PR11MB6938:EE_
x-ms-office365-filtering-correlation-id: 68091c2e-49a4-4c85-9019-08db47cc9040
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w4VdUZxQ/ahwpM9aRxl0N/Kv/nNASzk6mQdBcU9PkoBCmdGGbW/+iN9Swe0vICDqJqNCqJ4v70RQijnL+mazeE99J+PJ/Dhb2sPb9fIo4jq3nt0cH/PABhXVaYDC49Zz8uUeyUEQK+w4n3HC1sMEv4v8C8Lr8iB2SIHqlwxT2Jb7U3eNcRZvl/VhSrs7g2zo9BuemIvFr56SKloTvy0MwEuxvBqs8cHWNKGZcwsDkMKuBYbczblKYNcn8MTbXqDmP5k9dzRn46//LZW+iEseqM+MowPT1Icn6vCenqP+VheOOzwt1Z3yhnySZlnyW7iHO6pioEtmAT1bq777JTTTCYb+nAUonlmFe+R8k8yzmV057yN6dE/sHb3e3nex9McK4KbR51uKkyzIQgJmg7a9LGVT3DpbOHtG5FQVFfdAcj4QzYfn/56a1SUDn0v73hzNRNQjeXU+r3oZqFin6lcMHvTH3RsuXFyhtr7TiBs0ns0g/z8srupUvqclTK2e/AsgG4gXSS7okp3q9qQjVEQR0+UE5zs74Zi30fBO7YenHuitzLtL5SgYv9yAntODybmpQOW6k8NNGyjOTJ2nu6JwRib7axGJAdqBXR9EGWGIteYJtbR8OIamc00/Jg9LPQ65
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199021)(86362001)(7416002)(41300700001)(26005)(9686003)(6506007)(2906002)(4744005)(55016003)(52536014)(5660300002)(8676002)(8936002)(38070700005)(122000001)(33656002)(83380400001)(478600001)(38100700002)(7696005)(54906003)(186003)(110136005)(71200400001)(82960400001)(66556008)(66476007)(66446008)(64756008)(4326008)(316002)(66946007)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?T+NtBC8bX8MJH/XtZCic1UAYmjdmJOdbYtni8c2Ukgjv7aEz2rBk22OmrE31?=
 =?us-ascii?Q?zKrYKExB5Z0iBEZn7Bi/gsVv2aAsUUuDEqBzcVD8FxefIP6W1xtE/99dL8D+?=
 =?us-ascii?Q?0RNxli9jpxARwDl5tAshT8XVPo/ShctMR7PR1WnoafDhZ3MfiwVI0dwTm0KU?=
 =?us-ascii?Q?7BDwKy/6raj3VpxqEgwqnEaqNgQ2wMh5oFB2Dp23aO6W9mRoHffdO+pi1zu0?=
 =?us-ascii?Q?VfmYLv2Fd63Zs6pT19BIAX9Ke5DbRxzhFKJQpOnt/QeIn3yRjCXNj8gkw2sR?=
 =?us-ascii?Q?1TJ/ehXY9zga94YctkcRgF3usCzVfa5eAetMslzrpLMp5HV+Ro5o3Bd+neav?=
 =?us-ascii?Q?+Jl53OVN3brpLTrpMPDoT+NOwsIp0QKNREo1FkpIOYrOmBiAR/WDkLMLJQtP?=
 =?us-ascii?Q?I7asP2Sfvvkhv3VZhPQx+fgM4/22J3WbNQv0P3xbJl2MKJRNGTZOjaCdcLou?=
 =?us-ascii?Q?25ML2ChT8pylm5tyibsVVZPfPgX/wPuICm1luNj9ryAa9MJWx8LjfzYKRhCM?=
 =?us-ascii?Q?k8IS53An++iFBIYFuiZVsLfUF4u0eierjoy6HH/02rDdFEPdF+HT80qFPfe7?=
 =?us-ascii?Q?ukM1jya7zTmhVoobbCbVm9PwlSnZJxGKuWdhRgOqxM/6+9ysP/r/BbfrlFnp?=
 =?us-ascii?Q?69whJ1eVC2s0I7iZYFWn1fZYvMPbgOVXnglqidD6iVsN+PTqylka78qCtZRH?=
 =?us-ascii?Q?MibjrwV9MCNWk3SjzDA4yylRnKrVmBq+U4MaXOXWhFmwf06x0OGm4SopnpFg?=
 =?us-ascii?Q?B/VfCVGCqE12EE21kcUJY6z3/mYU32UAyB5ESkbYmH1nKq4BoRsVdA+PjSOy?=
 =?us-ascii?Q?rTuFifUITR5TAsWfwPDo7NRFCavw69XPso8GOqnCT3YR9Imn0mUXXDMImOoF?=
 =?us-ascii?Q?hvTPuCzkoWxwPV+sWmKBCgJ1FHmxO9yjAinefqLcxMNy9/WvCCovbbNdxsae?=
 =?us-ascii?Q?Qxdyo361NHlIOdpKsRmbrvRVlKrrVQT0E8w4qTDy0eEdEGsngv0x9Filpz14?=
 =?us-ascii?Q?P1EbYRMMFs+3Xvm8DzfTlUWdAdoGhU6p/SLKELC8zYk8t/IsmSwmPKX4t2jM?=
 =?us-ascii?Q?aVmMq7lijcXTgkb2A9F2fBn2GJoy+vFThVJN73K11yeecL4Z5Kr+a5Eo82hb?=
 =?us-ascii?Q?cAqKKqMZwzS5Nye6f82jRa9m7am1TrwVkFBO1SeRGIjlCFDe11DMiVLfMpL8?=
 =?us-ascii?Q?jnBA4zTqoJJdsI0DO5h4+FVRM/KJDTlvKK/GhgHxxBQuIJQa7CQ3pQTid7I6?=
 =?us-ascii?Q?mk22EEQEb5JdfDpP4R24IQcyJ/tGrJAOYc7BVIaSxGebBphb48G7kgJYEBD7?=
 =?us-ascii?Q?EwkiybKwe/gQKj41Z5iH0oWAvg6T+Na7GkXi+paRD35PSQ3cOUBKPPHCu2hc?=
 =?us-ascii?Q?D3AxT+7FwGh2NWaAOVsVXWiSuLfBk5Pk01uQDEUeE6VtUKZT5PA+doQC7Xy1?=
 =?us-ascii?Q?B/I2HU7ATQ/hRrzeChFANBt6HEGaWcrB1FtqMjJEfQhhN9IAOQiUn/0tZwH2?=
 =?us-ascii?Q?fb8LWvL1h/dleb/NIWiuwfQCeoH3GnNyi4ZI71KnSsp2ZwzNaouWyigUwIxx?=
 =?us-ascii?Q?OFZAKuOjeNxeYCrUC4EZSLbHpsBzl6ExUMqUGZ4C?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68091c2e-49a4-4c85-9019-08db47cc9040
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2023 09:40:12.1939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e8ckLRB/CkZbDcVblzBaFRJUWGQshCL5RdduH75EFAkjl6aOERjopMEfKKqnG52qZWHwnUPN5DYtVM7yF/jSpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6938
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Friday, April 28, 2023 1:50 AM
>=20
> SVA PASID allocation is hardcoded to start from 1 because 0 is used for
> RID_PASID, let's make it explicit to avoid the potential conflicts.
>=20
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/iommu-sva.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> index c434b95dc8eb..ac7c93bacb5c 100644
> --- a/drivers/iommu/iommu-sva.c
> +++ b/drivers/iommu/iommu-sva.c
> @@ -66,7 +66,7 @@ struct iommu_sva *iommu_sva_bind_device(struct
> device *dev, struct mm_struct *mm
>  		return ERR_PTR(-EOPNOTSUPP);
>=20
>  	/* Allocate mm->pasid if necessary. */
> -	ret =3D iommu_sva_alloc_pasid(mm, 1, max_pasids - 1);
> +	ret =3D iommu_sva_alloc_pasid(mm, IOMMU_DEF_RID_PASID + 1,
> max_pasids - 1);

To be future proof it's probably cleaner to define a
IOMMU_MAX_RSVD_PASID in case there may be more reserved
pasids in future usages?
