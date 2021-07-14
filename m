Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 215DA3C84A4
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jul 2021 14:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbhGNMsf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Jul 2021 08:48:35 -0400
Received: from mga18.intel.com ([134.134.136.126]:41862 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231260AbhGNMsf (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 14 Jul 2021 08:48:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10044"; a="197608762"
X-IronPort-AV: E=Sophos;i="5.84,239,1620716400"; 
   d="scan'208";a="197608762"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 05:45:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,239,1620716400"; 
   d="scan'208";a="413277253"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga003.jf.intel.com with ESMTP; 14 Jul 2021 05:45:43 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Wed, 14 Jul 2021 05:45:42 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Wed, 14 Jul 2021 05:45:42 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Wed, 14 Jul 2021 05:45:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nVjPUSoBYTg/ME7FfQzcx1GHZ21DLQeAfNf6gbaFhQY4pOCyNjVGfr9IvBfiyXGudOGl8x6vPCezePz8GrWoF6HyVZwHWoqR2zCC1EYzwDz0sKsaWN+zx+E2EDwUziKWZWSRG+DFMkBUMK92zYx7iSSuZUiWZ1SsLkr6pel7PqlIRyslz3WWxfnbFjTMGpqPtbzdoBnT1GzABjCyGaI+HwXh1ZZsOt0BdKgYYrG8JARSj97LmipHUhOtAbrfj/0EUyK3Haby4VMJXG1KgJLN5Y/pKUHAH2eqXUPhhI2CK96AV5oOVV1spU2zvuVXxlosQjSkPeY8Pt0A5lJyJ1AK9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iu44hiLS6XSarD4k90d+qT+kXQ8NX3911/XPhLB22Ko=;
 b=ab203ohTM7pC3qX4Rh9VRtaQQ68fkR017L7OJK0Rh1rmwxIs7EjsyfzefceniUMeJN1yBcuvH59CGTnbKlqCp7qNMS9cetWGbiyh4zF+Hq6nshL6DnaPE00vqKMZ4caPj796XElFOJw1HSC+P2WaLo8iZwHvJ6B56+6DiSCqxQaqNADiiLx5JO4OmJA1tbx2QZx92sLhOkLBthnPzYHdRW5u+/Wrp/2/jsf1HDZipw9DPc2Cl+KLEXVjugzan7D8Zo/kDBapx5tsyiUXZEI+wmuDJpKQs+gETbCSSn0gRealf2k5o8GhQfQgybvFEYs7isODxTGPb53cCEI7yQn1bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iu44hiLS6XSarD4k90d+qT+kXQ8NX3911/XPhLB22Ko=;
 b=C82ITIQIyQcCMKgDsY051KKgB3cu40CZwN6x51pC13V8BjeT4kYM//nzhHAkNyGrf61O71+asYSAOvF5l2O1jaEIf3PkQVurSXXqK71IwCTkJxaYpbFqih1vAGOhUnU8cb6lEHPguiImzkqdW4Nv6wQD/DdxRFoeAFHFAyPF3yo=
Received: from BYAPR11MB3528.namprd11.prod.outlook.com (2603:10b6:a03:87::26)
 by BY5PR11MB3991.namprd11.prod.outlook.com (2603:10b6:a03:186::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Wed, 14 Jul
 2021 12:45:40 +0000
Received: from BYAPR11MB3528.namprd11.prod.outlook.com
 ([fe80::b945:edd0:ebd5:12f2]) by BYAPR11MB3528.namprd11.prod.outlook.com
 ([fe80::b945:edd0:ebd5:12f2%6]) with mapi id 15.20.4308.027; Wed, 14 Jul 2021
 12:45:40 +0000
From:   "N, Pandith" <pandith.n@intel.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Pan, Kris" <kris.pan@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "Thokala, Srikanth" <srikanth.thokala@intel.com>
Subject: RE: [linux-drivers-review] [PATCH V2 1/1] dmaengine: dw-axi-dmac:
 support parallel memory <--> peripheral transfers
Thread-Topic: [linux-drivers-review] [PATCH V2 1/1] dmaengine: dw-axi-dmac:
 support parallel memory <--> peripheral transfers
Thread-Index: AQHXdKgkyV1Y50Hac0Ove3ZiMlgriatB7iIAgACBuDA=
Date:   Wed, 14 Jul 2021 12:45:39 +0000
Message-ID: <BYAPR11MB35282B43582FAB4C6619790EE1139@BYAPR11MB3528.namprd11.prod.outlook.com>
References: <20210709095133.26867-1-pandith.n@intel.com>
 <YO5tAlVshNLat2jt@matsya>
In-Reply-To: <YO5tAlVshNLat2jt@matsya>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c052050e-f9d5-4f0b-931b-08d946c5493e
x-ms-traffictypediagnostic: BY5PR11MB3991:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB3991F11A6F45592C67C34224E1139@BY5PR11MB3991.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PEC7Th88yIpJ2HZ0Ftjf1Dkb3k9XZxPbqR+FjdbqD1sIRwCYmwppC7lvnuPuWK+NJL5u32voMAZFti+KZ/jp1sS/tg03Ka6Rli9kJl2+d1/NwOoheQi7bREG3+D7JwYZ+KmVsqim156YP8giu9DOSv3D6x0akfmz3qASIrc6biIsEu26P3WBg+C91rG56d7VM3EjkUGuDqyECnmYGvq6Iyhi0SjEHiQDH6zUMV1bWMrTKJ5J3xO57sE36fFC2BQmKYVSzPZe7Q0NNsoFKePIElm8AkMW7UI5TyXXVhCwUXYpHZsQ5ATjFLxTqPTdjHxE+h82DamRQz6XjMh+mX4cG1sV3kt769j8zPqTC85Fpd2QXEwCiJuYpsn1fHBmwFeZstGjFE/BMuA5XQ6RAzXB0saztMvV91+FxzznP6zqdKKVEeVUBx4XxPXwC4nTFrF+gXIl5JYxBicemSEtLUc5WT9W5RYildnluDkOsFxIOlCxqgoDkRK5MxrH6vzXT2F6fdsy0coezOzHqucPx828s4grvFjvJj5soWaUo1qNtV1OrknQzl320nLfz2G/NVFj9vbWzxjtvWdVKjom2R3Q0bC3ScSC1+UC0cSL3SmOXaiAvzHXDhsXJ1UGvd0k/Rhmg7bl8usJQPXQnBYd2B3JU1zDbG8oPso/Gl4U74Iqu7NYDjtfv7pJmT8mv7kpkUY+b8/c3F3IAhMGLR8A5kRpcA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3528.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(396003)(136003)(376002)(39860400002)(6506007)(53546011)(66946007)(316002)(64756008)(66446008)(76116006)(55236004)(66556008)(8936002)(2906002)(66476007)(478600001)(71200400001)(107886003)(4326008)(52536014)(7696005)(9686003)(54906003)(5660300002)(55016002)(26005)(6916009)(86362001)(83380400001)(33656002)(122000001)(38100700002)(8676002)(186003)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KGugrmO8w0cxiao6kCxP8fOnmD3q9EIz1aGxSzj0U0UXjv9C/FpMxNWqXRsx?=
 =?us-ascii?Q?eMHDwntnBwp/+17UykXBZ2omUtOZ3qNOqhCG8piEXFObO3uuHOquSLwobgBw?=
 =?us-ascii?Q?wJ423S4QQJK2Qq2kfzClpXWuq+NISuo+nkyjyF2/Y8JQffadaL6WPUc75O59?=
 =?us-ascii?Q?hivHdKZNCdTfScoFWmhnx9OymDKj6Ub/qZIRVmBCWh6zuL9d9uEHv/Js9dlQ?=
 =?us-ascii?Q?NYTV2evQae0zsLZ52/5lfWx+SSfHEskt2pwpagsqOcq8MEpUvh06EQ/ivqmt?=
 =?us-ascii?Q?lmZvRX6DSykRXOiLbxf5FqjmeO55dra1PdOUrR4AyaZh4QIfI5+md/UR1w7+?=
 =?us-ascii?Q?3ncFPOUnwPGLIPrU3KnXAuaReZJaZxn8L4UG9tpHOuf4niT3VsxMoc2AjjB7?=
 =?us-ascii?Q?jGHPKqfnVL4SFq0EQxFD+QSqmns4MjHlSHyES8mlTg9X8CqbWc+YP+mWyFBc?=
 =?us-ascii?Q?4ga0EvFu/KhSy83Z+hxE1YBL1JJHm/7ySMY3XM00sq6gaV+1Pr78X/2rdp4b?=
 =?us-ascii?Q?kaehsLdxKlEPo5inBaML3KZX9/HcuElrXmcREMq8RoxsWyQx1aBHQIwvZRkv?=
 =?us-ascii?Q?L/2r/TY3uXDpCzM7evdvV8hw9ihbIemAtxLbiEr3494rvXcSwsWxZDJGien5?=
 =?us-ascii?Q?Y33XTGGxBGwaH4YXu6qkzua9zgtZ75mrNsz6VDLYq+j2jNpiCTzX6PNheMnr?=
 =?us-ascii?Q?qhVeGO8jJhRq/LZILTZMRiS3W4V8shPJNswRWPwN127P+/mC2AWMYzWfOWc0?=
 =?us-ascii?Q?GcOgtQM/Ke2toRScgXmxarl8rPEp1tNEQxEVZna9y/QaI0y5tUi2WE/yMANr?=
 =?us-ascii?Q?c4a6Y7oUbJHsvEYRV5e6bV/Z6ECI5bW7vKayzFF6RUnI/oJstjkY43VyuKJp?=
 =?us-ascii?Q?X5UyKShQcFZhdjYrD65cbR/UygX5YpAkOH9WTwqzGigEaLU/AxRuAPkLC2Vy?=
 =?us-ascii?Q?d8VouWbjEeQpKOCATjShLSwF1NknjdJmXB/2IIeXdxvU+3cfXVZ2FxVgi3R6?=
 =?us-ascii?Q?I0k3pm7TmyndZF2Cxr8APD3MvTBgJmxbsoBqp+zRsn6QtMukBJc4cFXND6VP?=
 =?us-ascii?Q?3NPTj/hgoAnC5oSIEOV+bvoWlUd7YGXNO+ItFibbuOM3JIjnDAxsvBdd6UgR?=
 =?us-ascii?Q?YWTQ0GRhvLWGe04r0AYlb6BZlWvlTOtIMIvSsR3xUps++xYHn1f+zSZGRux8?=
 =?us-ascii?Q?Ml5F55BnYbQScSP/c9rkLuCUBW2WMSZcREUaUuGi9tr2qqx7+Zgg1Q9ZMFye?=
 =?us-ascii?Q?5G5W5o3W48t/swrogXkoBTBUpHlpl6iwh/u+yuFIvDYhh3CHMH76D59lq4II?=
 =?us-ascii?Q?fmw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3528.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c052050e-f9d5-4f0b-931b-08d946c5493e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2021 12:45:39.9176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TzzuIijwJSDX9RmVhFFmp9OeihLwPJzh2xJrQb0s5KK/lPoOqkraxD3n+/yORVM56y7jLyuEp1G8ZGucUXI2Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3991
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

Thanks for review, Please check for in-line response for the comments

Regards
Pandith

> -----Original Message-----
> From: Vinod Koul <vkoul@kernel.org>
> Sent: Wednesday, July 14, 2021 10:20 AM
> To: N, Pandith <pandith.n@intel.com>
> Cc: Eugeniy.Paltsev@synopsys.com; dmaengine@vger.kernel.org; Raja
> Subramanian, Lakshmi Bai <lakshmi.bai.raja.subramanian@intel.com>; Pan, K=
ris
> <kris.pan@intel.com>; Sangannavar, Mallikarjunappa
> <mallikarjunappa.sangannavar@intel.com>; Thokala, Srikanth
> <srikanth.thokala@intel.com>
> Subject: Re: [linux-drivers-review] [PATCH V2 1/1] dmaengine: dw-axi-dmac=
:
> support parallel memory <--> peripheral transfers
>=20
> On 09-07-21, 15:21, pandith.n@intel.com wrote:
> > From: Pandith N <pandith.n@intel.com>
> >
> > Added support for multiple DMA_MEM_TO_DEV, DMA_DEV_TO_MEM
> transfers in
> > parallel. This is required for peripherals using DMA for transmit and
> > receive operations at the same time. APB slot number needs to be
> > programmed in channel hardware handshaking interface.
> >
> > Removed free slot check algorithm in dw_axi_dma_set_hw_channel. For 8
> > DMA channels, use respective handshake slot in DMA_HS_SEL APB register.
>=20
> and why was that removed, maybe a different patch for that?
>=20
For every channel, an dedicated slot is provided in  hardware handshake reg=
ister.
Peripheral source number is programmed in respective channel slots.

> >
> > Burst length, DMA HW capability set in dt-binding is now used in driver=
.
>=20
> Another patch...
>=20
> So, too many changes below for the description above, pls split
>=20
I will split the changes as separate patches in next version.

> --
> ~Vinod
