Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18E213DA121
	for <lists+dmaengine@lfdr.de>; Thu, 29 Jul 2021 12:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235607AbhG2KgM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Jul 2021 06:36:12 -0400
Received: from mga12.intel.com ([192.55.52.136]:56306 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233273AbhG2KgL (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 29 Jul 2021 06:36:11 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10059"; a="192448580"
X-IronPort-AV: E=Sophos;i="5.84,278,1620716400"; 
   d="scan'208";a="192448580"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2021 03:36:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,278,1620716400"; 
   d="scan'208";a="567182877"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 29 Jul 2021 03:36:07 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Thu, 29 Jul 2021 03:36:06 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Thu, 29 Jul 2021 03:36:06 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Thu, 29 Jul 2021 03:36:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLyOHZQsO2nx4SPjfzHBUzxh2aKE9J60jx+SGGcIpd9t5btvooLeu8obW23hHjeUNJTijXQmsWIG/UBhadfJgG9pyyXEpLWBJMoOCvoXQDzBu1xA+sPrCGTq7pQ1he5aGX+st1b3YuK3MEuvCtIpy+30gNRiWfCpANWdrcCfIzT1sXSx6X5WYmsI7vApXqTP7Cs5oPTcr6Vh57XXGfLn9SI0ZHyDUmrvjR8rrA9HZUpK/cbjUtJWmVu5RyjmCwosxjQOGjv1PWebobtE/6O1aOjuaaZNp8FaqefMX/ol/lvueuvx/xEh6QYmr8VarnwWhDkPO9xRdBacUeuZiuSflg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WRe4WfP5+M/Gy82IWSeLsuq/vmngaLJLSOkhKpRQr1Y=;
 b=GuUU/FCL0cHgLlNnII5PwAhUQYIwS+C0yhHtnTuGNlBMLYEMseR+MOvOMstdEMGM2NX6VHmqncxa2MAicqqlIx+WXxhK8iQhtSZiwvZ/NSVTFQlmC8drGnEtZNEdKc3gpLLBvixsH3k1Wdmbmp7ZDElEUZXxCOI15f2eQ0S/owtWSkAXYFq1+oEQZs70bgjYWQn0l2Dmiv8XM1kMynx3DYpIWUnLlEwx5Xdqox31/O0G0TAvbMkgVK3h3d7PlMiDFlKXbqb25eR82Kyiv7W/mYovuMJCGnd0oGXbX8FT/+DPZRH44SBk/bIYxh2sSOV/gsQdC8kVzNJOIR9LQpI6eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WRe4WfP5+M/Gy82IWSeLsuq/vmngaLJLSOkhKpRQr1Y=;
 b=j1WgvLo4VqyZmtnVKGBPNrinJxcmoYJf6x+4BHa9tx78pL4aFNcj2RE4Z4D4kYIQe1TRjygMP9i8EKSUPNP4NtZIbVv/S5uKZiUs+Oi/vbTwDyOxyOvSX1ZTKgrTRFmPpl+U3dnbKYSg7soXdh3Dk5N7WDIvs0k/0L6T+4eE6Tg=
Received: from BYAPR11MB3528.namprd11.prod.outlook.com (2603:10b6:a03:87::26)
 by BYAPR11MB2709.namprd11.prod.outlook.com (2603:10b6:a02:be::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Thu, 29 Jul
 2021 10:35:58 +0000
Received: from BYAPR11MB3528.namprd11.prod.outlook.com
 ([fe80::b945:edd0:ebd5:12f2]) by BYAPR11MB3528.namprd11.prod.outlook.com
 ([fe80::b945:edd0:ebd5:12f2%6]) with mapi id 15.20.4352.031; Thu, 29 Jul 2021
 10:35:57 +0000
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
Subject: RE: [PATCH V4 1/3] dmaengine: dw-axi-dmac: Remove free slot check
 algorithm in dw_axi_dma_set_hw_channel
Thread-Topic: [PATCH V4 1/3] dmaengine: dw-axi-dmac: Remove free slot check
 algorithm in dw_axi_dma_set_hw_channel
Thread-Index: AQHXfY9NAhHk4jKSS0m098OCM0JyJKtYB6WAgAHF3wA=
Date:   Thu, 29 Jul 2021 10:35:57 +0000
Message-ID: <BYAPR11MB3528B7DFB2136D35C6B96AF6E1EB9@BYAPR11MB3528.namprd11.prod.outlook.com>
References: <20210720174713.13282-1-pandith.n@intel.com>
 <20210720174713.13282-2-pandith.n@intel.com> <YQEFzyJnXvQg/uh9@matsya>
In-Reply-To: <YQEFzyJnXvQg/uh9@matsya>
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
x-ms-office365-filtering-correlation-id: f0dcb08e-a2ce-4577-12cd-08d9527ca6f0
x-ms-traffictypediagnostic: BYAPR11MB2709:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB2709CCA644DBC8EE2A4097A6E1EB9@BYAPR11MB2709.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b2AfnHeEa54UgJ4sM/BwvIhuxx7jnHHVfCnAaGzpieI9rBHgHSnQ8UgJkA6F/yZ78HCZndY5TFj1xrPFgL0ZmqgrINXgloMCtcZGNA2JNAMpj5iSgWcGneKtoSFA2ScZUBxFK6Leo4TXvvyrSfvUzcBpATB694lIGFFq88FciwSYxyA6Rb6MnGWJ/G6lngSKo4ABT+ZEO3Pc5ToSEQC3Gmx4EsPSS5IheB6a0mDVk5CbI1tNeDV5Ch17af3Ti65ARAw1iLgaoo71zfwaZL5dNA6r0a6SSZKxyifu/Aj84+6AktqqLLdf4lEPYBsXWh8OlfxsTfJu6CFLxwtl2LPVRZQD6cf2CO7oVJjhk48uwLcMcT9ImaBBuE5ovYipxn7ZLVgfDB5IeJoGANpwWcAk0c92N+9OHSeatvtN4l1Vkxi3L8ElMFxVAppDmqpyO5zthBiXFhQ9j0jpP8ukWsI+zO9RK+/KvBI2BhLZNnalZJupmAjQNKY0Hi5BjTa+skAChpji1sqPd/Mm9JtMnqhopITiK+4KdQGteS7N9Vme8TtBN/C3F/7QGdjD2P2D1fzfp3nO8wyvB2cVbzUQx+NrApsUhNPU2EZJpyPbzNerwG4tEqQLiswQsoR+G/KT3f9mHWBCoDBCccte9W7MgLGw1p5kQ1pbhnWsQV9eH/HClOEjQ9onDgfeEiAfFmX1akh32u64ghkrqLWJ01fw4DDZFg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3528.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(66446008)(55236004)(9686003)(8676002)(53546011)(76116006)(478600001)(8936002)(5660300002)(55016002)(38100700002)(6506007)(316002)(107886003)(7696005)(86362001)(38070700005)(66476007)(66556008)(83380400001)(4326008)(71200400001)(122000001)(26005)(64756008)(2906002)(33656002)(54906003)(6916009)(52536014)(66946007)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?M3i5OEh5yeN7PDLpRaOi8idpeJEYDzKAlonY/dy7ReQ1VSWREd1KHLD9tnzn?=
 =?us-ascii?Q?nmlZFVk1axpPP0EP9F6+cCB6KOUf+YxP9MWWPuxH6V6gjkdpCgzw+RpoCUgv?=
 =?us-ascii?Q?Y9ZByq1JMW4zZ8FTRTT6bxnEf18O0vZeHv9ZVXWoyNr03X1zPShzdTeEg8NT?=
 =?us-ascii?Q?H15up5VyX9SOJKUACRp5CEJAIYpI5zbKmHXsvADPHQpIP+hEs/q6LgFCCgzv?=
 =?us-ascii?Q?BNRdApiBpre3I49sYHVZ3ahbYdJFvI9+F7iDDWdTaLNvvQ3qaJUl+tdNcfuq?=
 =?us-ascii?Q?zYAKkoMgWki5shQ9rEBGFX+M4XGf9EjmZ6mNwmGCYZZYlL1cnP3yz7kb8UBG?=
 =?us-ascii?Q?+n6hQStpwJe5t0hO8GUXsUTFuTMohk+Mc6PNMKurn+22ZvArsiNFzjrwfcx5?=
 =?us-ascii?Q?xpFdt+STcKEc73PxxpF/uu743AAw4fpx/P5UvhqRVygYqv2tVRF4I+cJ3GnP?=
 =?us-ascii?Q?ybItK/EIcpYd542BXRuSJys0B/dBHryfyrH5iyc7Ty6nTVDJUii4aZ+jawjy?=
 =?us-ascii?Q?2bHp66QCx5j9K4gsnhZCOvmTmvmg18KxV+sou8AcaA7cL4wC4IhWrvVMV6aq?=
 =?us-ascii?Q?xo0nE1pChmxldaFumkItTt+C5L+Nfp88NkTh2pL0fuAt8f3sp4GmppwvXnmN?=
 =?us-ascii?Q?MWb6DzCApw1qQPojfrygfwOW57lWNKuBt8jdPWPWo4ykvzgQrCAg1kXP16cr?=
 =?us-ascii?Q?IlPQcasMe0TMXbFPNRRHgG4htcgG0VDmAe/ghnfSH1U3tFHQsfkXuosY9LIa?=
 =?us-ascii?Q?1IKNAfhe3LZnnJfCkp96G1du8DXaZxZWhdPhS60pTLHmdhhQoODIopuAjhQb?=
 =?us-ascii?Q?+cPagCW4L0Uq2v1MNcvPIGrda7u5qNfWjnI0cS93qeeE7AS/RX+4yXy7kqaH?=
 =?us-ascii?Q?atF4kGNgFmtbG0BkaLCwnCjKrlQlOR0fn3n0vuH6uYIFdUuvUyvbynBjhPtj?=
 =?us-ascii?Q?hlyJY9MNjTZUH8nldT9pIbGKVTfxMRPD4lMOYG6yjHAJOKrw17ZbNojGQdrU?=
 =?us-ascii?Q?f4ap7bteB73fbrkt2SQkvUVMsnOwUvSEDJnt72ntV+/pApe1aCZEXP8Nsa/A?=
 =?us-ascii?Q?cXSUsH8K1iTuFtaDFIj5dSpLyDB5wz2ykm7GUzdZQK9ywjPyq7GT13myPxl8?=
 =?us-ascii?Q?zIY1T5RRhqs49mlR/Yt+m/rlG0lf8n+iy78bW+JiG2ZTt/HqDMKW7waWeYe5?=
 =?us-ascii?Q?cq7rt239f83f2OCjwI0qPSMVNHBJMG3/i8w2IcVkzG+h4GFJK16CB8WeZGm0?=
 =?us-ascii?Q?KaoG0GO9UKnvDqVnvFpPBO3T5LvUXHWFCdwSYcnZnJwjAZjyofGHRFY+b91M?=
 =?us-ascii?Q?TXg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3528.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0dcb08e-a2ce-4577-12cd-08d9527ca6f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2021 10:35:57.7211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rt2CMgQ+ZfsR6q/aWS4LJsLkuNfPmHPj5ULto0pfA2zdvnLCwq7YDqRKvi49kXxRcRuQ1SZJ9ABUqraAyLG5AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2709
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



> -----Original Message-----
> From: Vinod Koul <vkoul@kernel.org>
> Sent: Wednesday, July 28, 2021 12:53 PM
> To: N, Pandith <pandith.n@intel.com>
> Cc: Eugeniy.Paltsev@synopsys.com; dmaengine@vger.kernel.org; Raja
> Subramanian, Lakshmi Bai <lakshmi.bai.raja.subramanian@intel.com>; Pan, K=
ris
> <kris.pan@intel.com>; Sangannavar, Mallikarjunappa
> <mallikarjunappa.sangannavar@intel.com>; Thokala, Srikanth
> <srikanth.thokala@intel.com>
> Subject: Re: [PATCH V4 1/3] dmaengine: dw-axi-dmac: Remove free slot chec=
k
> algorithm in dw_axi_dma_set_hw_channel
>=20
> On 20-07-21, 23:17, pandith.n@intel.com wrote:
> > From: Pandith N <pandith.n@intel.com>
> >
> > Removed free slot check algorithm in dw_axi_dma_set_hw_channel. For 8
> > DMA channels, use respective handshake slot in DMA_HS_SEL APB register.
> >
> > For every channel, an dedicated slot is provided in  hardware
> > handshake register AXIDMA_CTRL_DMA_HS_SEL_n. Peripheral source number
> > is programmed in respective channel slots.
> >
> > Signed-off-by: Pandith N <pandith.n@intel.com>
> > Tested-by: Pan Kris <kris.pan@intel.com>
> > ---
> >  .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 49 +++++++------------
> >  drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  2 +
> >  2 files changed, 21 insertions(+), 30 deletions(-)
> >
> > diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> > b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> > index d9e4ac3edb4e..6b871e20ae27 100644
> > --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> > +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> > @@ -470,19 +470,14 @@ static void dma_chan_free_chan_resources(struct
> dma_chan *dchan)
> >  	pm_runtime_put(chan->chip->dev);
> >  }
> >
> > -static void dw_axi_dma_set_hw_channel(struct axi_dma_chip *chip,
> > -				      u32 handshake_num, bool set)
> > +static int dw_axi_dma_set_hw_channel(struct axi_dma_chan *chan, bool
> > +set)
>=20
> what is point of returning error if that is not checked and action taken =
in caller?
>=20
Yes, change of function return type is not required here.  API signature wi=
ll be:
static void dw_axi_dma_set_hw_channel(struct axi_dma_chan *chan, bool set)
> >  {
> > -	unsigned long start =3D 0;
> > -	unsigned long reg_value;
> > -	unsigned long reg_mask;
> > -	unsigned long reg_set;
> > -	unsigned long mask;
> > -	unsigned long val;
> > +	struct axi_dma_chip *chip =3D chan->chip;
> > +	unsigned long reg_value, val;
> >
> >  	if (!chip->apb_regs) {
> >  		dev_dbg(chip->dev, "apb_regs not initialized\n");
> > -		return;
> > +		return -EINVAL;
>=20
> should the above log not be error now?
Will change this to dev_err
> --
> ~Vinod
