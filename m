Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA2C6A7D20
	for <lists+dmaengine@lfdr.de>; Thu,  2 Mar 2023 09:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjCBI6e (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Mar 2023 03:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjCBI6d (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 2 Mar 2023 03:58:33 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE3A11660;
        Thu,  2 Mar 2023 00:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677747511; x=1709283511;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=K0RV9EhTqhTGljKlC2IbaRmRcgqalRllmbURsHBspAw=;
  b=F9zBpcVX1fZAYw+QT8mF5GkS9nyo+8xc0++qqD+AMEMNzeblWjcxGrNw
   87HOSi4W83QxYwizCrE62pcWE2vFg0+TYwsaJ7sKJuq2AvYVnmeJD88Dz
   3vFcYjoEuHg6PgUT6kLML/HtWY+x6T3Y7ic6KQ+0xdz7ToR+KulUrJUk+
   Rdejcm+Zj/FuwO/j5bXXg1YJ5JVcZctctCn/b+G8Q3OZQbeMr6axeEbtm
   6ZcVnUoXCOBPxjnD1MHyxDXHsA8xAY8m5erClvl45F2jNvAtb9XmCnLV2
   xQROpohvQVxVyI14+qpOMgMraFBni9W0w/ZjO1cN6eLOcc1tx7rjghpNa
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="336963839"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="336963839"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 00:58:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="652333600"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="652333600"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 02 Mar 2023 00:58:25 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 00:58:24 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 2 Mar 2023 00:58:24 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 2 Mar 2023 00:58:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j532yXZ0dVONgEv6dDReTulyoNwzPGr8vOQLuxU5Q5/p7VBHWi8C0Wx/yZlw8Jw3qjyTZLq82afPLd3tu+3GGsXsYT/rzon65fjjlsywtrXJcLsLyrHZpSYRHbKtia/HJSmr8Sj+O6RJ6jB1aEZ4J/5IluRio8eTNztdG2q2XRsDbbP1HrZOPQ7pQQg3ySanbetz5Sq/PRLSEn8oXQhOAC4m75BpdCgfbweXOxttHHZX+Yh/KwkX9qQhM1GmZnCJhQSfSJXNc56QcFlmb2zUZyoBdd9G+CUt6UgGLtoKKaxeFM0fvTDFNWm3NdfpICHanpNAwSnqGYl9cBdefBwQVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ggpJCex18A9uxQ9njvHLJDLjhR+D+ygZzmM+5S5k6E8=;
 b=hL3Wjj/oPviYeYOtiTrfiTesKD2VW9Q7QtTlYRPRuJZ7NLvxtZ608fQBaqGLbxaSTPf6tlHUf0+hzHyQ0x0xvSFI3dWQIwk9GK7QXsPON7B+pajQK/1EvG1lDLBk+xFbBtHOjhKehZi0tgFmGjrRqobnPAKqHbd3bMYP4ASuWL2vUohyXxCxtByQ/dulUBWRH3tYvkQlc/tGlWyi31dLfG04etKB3GOYuctJLTBcbVrlWmmcmf4dmiMhB2bbiWIQLte6GI1vGwcc0j0AaycpAyOJQRm0RQjP7a9vXq7tcuOPkLJPHBCFCn1zce7Xhp/3p2EKuMbxVgg72rm9RVpeEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB5015.namprd11.prod.outlook.com (2603:10b6:510:39::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Thu, 2 Mar
 2023 08:58:21 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%9]) with mapi id 15.20.6156.019; Thu, 2 Mar 2023
 08:58:21 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        X86 Kernel <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
CC:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
        "David Woodhouse" <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>
Subject: RE: [PATCH v4 3/6] iommu/sva: Stop using ioasid_set for SVA
Thread-Topic: [PATCH v4 3/6] iommu/sva: Stop using ioasid_set for SVA
Thread-Index: AQHZTJj76eQP8uX72EyfrDQEvPOjua7nMKtw
Date:   Thu, 2 Mar 2023 08:58:21 +0000
Message-ID: <BN9PR11MB52769D24FF395C1D42F33E2A8CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230301235646.2692846-1-jacob.jun.pan@linux.intel.com>
 <20230301235646.2692846-4-jacob.jun.pan@linux.intel.com>
In-Reply-To: <20230301235646.2692846-4-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH0PR11MB5015:EE_
x-ms-office365-filtering-correlation-id: 83cf4789-84cb-4f2b-47ac-08db1afc4634
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4uUjVNgw9opaLKqmVxRg92pLhGS7WIQ7/PTSxyDga52kKka0VP5uTSc9zPN6loaWFyJCVvHGnv4mSluEFfOeFFuBcOevr5w0tcNzwa94NJohrE4Twl5uErY80Rd0ynO+d9yzRCVVdgz9vH3/vRxz6QvvU77SCJ1yJugv1WafmSrLJHTwsr2snOHZacklYZlTAJqn8JNeOnKJPlnEWebS2LtVFUiJ+5eU+YNLepJnx2qdJdKMh1hvlCMZnoHEzLQt3vFwQKadCM8glrNMRbnL7GMCH9xYLW5Ejfy9T13Aqw/2xjta+xbjRrG6CWsDwAjc9HaEcE3oSdHNyDzc6Lk4IepIMhhkpo859VOKK36KoKCNbi/0OtuH61T9FmxWowyKgj/JbaCNiH+qAfoCRA/Kbq2+3AiMgxcKfYZCyAgpaEreQ1O8S2Xj9YDrD0wyiErqDRX9ZIIQ5ASIeE0ahp582Rh0etDuOhxjQejMtgh6q4mmydhIq5E66nZJtj7ONAbxqQu2amo0g0AGSq1e85bxYfCbAyR9ktrsnUTsYSM92KezOqMQdfpvHqTtYVwk7eZWEQQ/NIJWxNlWODdSjqVHDKx+r9Du8WWNUcajhQZWC8q7GJfu9t7sdVCzovsdZu90FIRWgpwdka3MSQK/nUf3XGqKq8Vk5Exd9UzxnMp4VEssPheGFSXFhzc2i9ENpXm1e19AHEGIKubnk9uS7KeVmA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(396003)(136003)(346002)(376002)(451199018)(33656002)(122000001)(52536014)(5660300002)(8936002)(82960400001)(7416002)(478600001)(921005)(66946007)(71200400001)(55016003)(86362001)(38070700005)(38100700002)(26005)(9686003)(186003)(6506007)(76116006)(66556008)(4744005)(64756008)(2906002)(8676002)(66476007)(7696005)(66446008)(316002)(41300700001)(4326008)(110136005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bMZnNDnxCduoL2PKI5qgoeW2a/Ba92P44wRnf3LQVH3NicXUykRMeN6XkyR1?=
 =?us-ascii?Q?v9VZDLAOKfj1ChX3RJQViIF2Rv85V8dfBVUYcnAZqgzF7pZrTB3REe7qIpIE?=
 =?us-ascii?Q?SPWMhcdElGRpOkz8niwu2Wq+3zuTRrMTD9Vmyk+G1XboVsRrKubaZFvwsgPV?=
 =?us-ascii?Q?6IZ4iDHJPFe0d9nTn8dR39F8WRea7TOdFGd55Xpm6jA73CfqaHLVNW1joUr7?=
 =?us-ascii?Q?kTbYT/2FSpsZLTR+K0tDcEzA1GBKLEdylaEXgTiR9mW9rGvpstsNExnlaYAv?=
 =?us-ascii?Q?T0rCk6ysj+nUOmAN46AWdBukotwwc6oTckJUjA0Cqy+Bql5Mve0XT4rimgR8?=
 =?us-ascii?Q?1OPScdVO3QUBeThsVhRDOuDDmSIQZQhV4cnmpCGWzC1oNi+nTOYadUmBands?=
 =?us-ascii?Q?OZfKOH/7c2CDDfaH6vXcBE0lR3Sj9nYZvX2hCUOdS5DBWjocng+T+i7OXtae?=
 =?us-ascii?Q?yeXEpVg8cJKksmKl5wbzh2MTPJbNLHTi5oWGCcsS2rcpSU8NaCFiiorvCkfu?=
 =?us-ascii?Q?9dx+qzomOt5Jrkrs1K2mwsw1JmfyQwPc87XICZ9ipnSX0mA5yTaZzywVOyQm?=
 =?us-ascii?Q?3JKxIIP8stkbharibHOpE2Vw9UK6/04xA9XnF08YXdgJEfg6a+nRE9Nk37NV?=
 =?us-ascii?Q?alxCEXUGgkSaG1G1ngwD1ftXjS8lE0zX/8kHnK2onUJj3/7Xj8BP7Jskgr4L?=
 =?us-ascii?Q?Rua52lNT6W1IxcBjXz6CVAqpdcb7pvLAuu8Oh+4YbhSYUfWMK7tay4zKSbmT?=
 =?us-ascii?Q?shS1XkRkLS7/L8t60PlooALG4q9tDNU8TCSJ0j6LLLtZp0U0YM1jRwsO1rXx?=
 =?us-ascii?Q?yqfr/2KpNtVafWAkyBPxvo45vD3ZH84j5cYwh2xXhTklXEHIRkcvD3ngHiPj?=
 =?us-ascii?Q?3UhgtpIQRiBgzGjUUCVgJVNaAqwNJDSXNLy9kfZh0A8WTgfczoCwFPqYg1ni?=
 =?us-ascii?Q?0ZzBg7CjXYM3CqWsay9IWkKTkN+9KpeQOUJDwPBG5izzqCeMBdHcdWXSTMIF?=
 =?us-ascii?Q?jY1nTRLDgMyzivSlyVeZMSfDuIVHp2nejGMmnU1TMBsBD5u3Cz5+9ltNe/sE?=
 =?us-ascii?Q?1zYPRG3a5OXew8YnN5xlbU2RTCzvbXXUGJCqL3SWN+fW0scJmA9N3lf6VpkQ?=
 =?us-ascii?Q?QMPv9ilPtLJKySsJFpu5kKeRE0nmVVEmPb+PuBSVLZqwQRCYV6G1WKVq7oQv?=
 =?us-ascii?Q?7WukDCkuzSgSqAb+sEuRzlgbJlCKCrEJJGSbLEA8QJFrBWgc9QDwd0vMvWEQ?=
 =?us-ascii?Q?e4ynLrvhh4xj6AFp3Rx3+bM0NyRm5LN4soCKes+lFm+2cT51yJ9iWMQe4i/p?=
 =?us-ascii?Q?Ysgk8IotARpCHZmaBI5j78YkgHwDQ0eAbD1kTQv51ymW4WIyLo+B3+Bj5gw9?=
 =?us-ascii?Q?un58ZsG8Ek92tVYpoZ44QzSPWaZzvSUcOn9iJS1v4BHNTCYvCad+1Rf0dUG6?=
 =?us-ascii?Q?OOV4C6DWoliN88w59k0LraZBdOvfQrZVFSUKssLnoml2Y0ffWUxfJANS4xqd?=
 =?us-ascii?Q?uAfTqn1GykaT6jM59k3BKvfWuCosE0CjSwoZ0CYcN7PHKA4ma9RgPlCz0g7H?=
 =?us-ascii?Q?B6LjOu+ay8kn1lp6bkeiq0Xh6Oqx9y/MZXTyIcMR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83cf4789-84cb-4f2b-47ac-08db1afc4634
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 08:58:21.4812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mxx/yLv1LIGU9Hv5JBhZ8RGW7HZJnnOrsoe20K3iFLJYXAIMM847ZLiIR6Jn/IU4ywUbEIfAieks0lswkkLP1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5015
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Thursday, March 2, 2023 7:57 AM
>=20
>=20
> -	if (min =3D=3D INVALID_IOASID || max =3D=3D INVALID_IOASID ||
> +	if (min =3D=3D IOMMU_PASID_INVALID || max =3D=3D
> IOMMU_PASID_INVALID ||
>  	    min =3D=3D 0 || max < min)
>  		return -EINVAL;
>=20

if (!pasid_valid(min) || !pasid_valid(max) || ...)

with that,

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
