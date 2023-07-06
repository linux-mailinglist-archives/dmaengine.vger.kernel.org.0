Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B510E749603
	for <lists+dmaengine@lfdr.de>; Thu,  6 Jul 2023 09:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbjGFHHA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 6 Jul 2023 03:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233511AbjGFHG7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 6 Jul 2023 03:06:59 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2137.outbound.protection.outlook.com [40.107.113.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F3912A;
        Thu,  6 Jul 2023 00:06:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LWU96TWGAoz/FNm7YY9AEd0elphNJIX0aigLsDcKtLaM4Poe7BK5E3URAimgmVf5LTD46vcpmzYFihHMwp2rNOia0E7IoYofGfNKgL7iTVVBGjgILDK6pi6EAEAGwIOG63jTwm48ReGa0hOHLXOaqdewOdvHRVRpXfOFfAXF/YHZGY8A54wnahvFHD1LiECxpcZQ1PWqNkC4Ya9cBzGZkfCegt6hc3zx2asnMeSjLqGXFlyw158zxuT84y1DGP9yweKKAfFPbMKeG3t0jOCLiYlMDHc4b5iZN6bZWsa21/SCpSdIainIRi7tXIh18RgtwX9QM9MriXgAGuHjNdIMtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zcVniUqcCfOe9iB9WVjr8rmf1b0Yy9qCLw5MvV2XXFg=;
 b=b5k5z/va1/jFmniT/pFSYyBTTFDTLfYPU+cyirA5RXdZOSkB7bY73tItZYyRx2aUUfnoSoZWGRoiFKmQyoxqJeUfvkOlqv4trs85rjcstW+kfFIXtlfpkeY8+pIlRiw7ZQDUdQ80VL+0NAot3PEm7ujyXjGiL6ybYla6GC5kbywoZfvrvHf4FDwobeIL655VqXn1UMi7lpmvBOmlRkrNvaUE/ytAFPW++s/ai1biz96pdU32lm4jIYD/xIwPr42O4OrD1Lp3H+nZfhSMqF6OMS5M5/5ldgIz8aZzFxHHMdywrxnGm54204aT7QAgpmvmiLMHi0K+dCGQ0v/VUh4GiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcVniUqcCfOe9iB9WVjr8rmf1b0Yy9qCLw5MvV2XXFg=;
 b=Ous7OHP3NZlk1Lg54oUwZjbDmuBWyjOcGcKodmP+VEd9TG0WvA3EVDe0hNrwtROzR0H16lKiUKzTuzsEoziGjKJBekuZqponnbGv0ycgFPJlrrMZ7StdZ7VoOy46Uu4l+SLrh8dP8bUnBIT/4XwjRWm4ayffYLe4i4xKGNDxPiM=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSZPR01MB9649.jpnprd01.prod.outlook.com (2603:1096:604:1d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 07:06:54 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fc77:6148:d6a:c72b]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fc77:6148:d6a:c72b%4]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 07:06:52 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Hien Huynh <hien.huynh.px@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] dma: rz-dmac: Fix destination and source data size
 setting
Thread-Topic: [PATCH v2 2/2] dma: rz-dmac: Fix destination and source data
 size setting
Thread-Index: AQHZq25ew3IkCL4qWUi7XN/bzkogTq+sS3KAgAAOPPA=
Date:   Thu, 6 Jul 2023 07:06:52 +0000
Message-ID: <OS0PR01MB5922CD72EA3EFB960698A7E8862CA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230630161716.586552-1-biju.das.jz@bp.renesas.com>
 <20230630161716.586552-3-biju.das.jz@bp.renesas.com>
 <ZKZb0x/WCWfghIrr@matsya>
In-Reply-To: <ZKZb0x/WCWfghIrr@matsya>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OSZPR01MB9649:EE_
x-ms-office365-filtering-correlation-id: 091b6acf-359a-4f2c-5894-08db7def9365
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ApQYannVt6hsQh+6PHBs/FDE0DpWoI2KME9obTXZYigJ6K/UGfdWFb5SaZW6b35GQ2IyOp8LRSnM8V+fan8CNVr4d3Yn3pumRjr8ycZy0W/UsIEAF6fWzdrXe58736Fbn1V17LyhRj2VCk5h4k9lLsNCSCgQYYccv1X/VP5scSH9C5EXDED3fF4W+UdD6+0gS/l0yYCdqBIWe93Wg+HW39SI8rI+PDH5CVeXqH21XbKPGMsRyw/kUnnPjZwXVP5JO2zTJbseVpNwnT+rT4mFJbkpUQxWCc9AVDdpwbQl3bAl6Gnxdc+cKK4iX4KmI4TqldGaN9qxraWvjJEw0rCD0KlGtZ85ka5r7dgErr+uF/s+unPyhJ0g72qv+m30Cd/rIHNFeefuyllg7IXhKvS/cUfwmKAJ96v765RmH4Y1QPNUHup40zl+hRP/UWFxeTkOH4BWXiqfbMHc8c9Ibb8i/XzOrW3gSls2o3YU2CYhgVw8QmbQkWXCVK4ygL4Q0CI4JhWMOdFgQ1FZcsv81DgvmFrQrJ1kzeOK8h1AydlG0DxcG/LkpbPxOe3asTKa9MHGLfRhIFiygz8ClpilYV3elZJa8VdsNbfbDdQ+QZkaZeMaDxdCnaW9wF+rxWDKRjKuDq/ur/yAZRslBtGKc87rXw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(346002)(136003)(39860400002)(376002)(451199021)(6506007)(76116006)(64756008)(66476007)(38100700002)(66556008)(66446008)(4326008)(6916009)(66946007)(122000001)(55016003)(186003)(86362001)(33656002)(7696005)(71200400001)(38070700005)(26005)(9686003)(478600001)(53546011)(54906003)(8936002)(41300700001)(8676002)(5660300002)(52536014)(2906002)(316002)(83380400001)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Cp4yDlCgfSnc9HbqOG7hqg1BYtJUNGgqg3QpXhcdOC6Eg2HkxiKv+DxhwYoI?=
 =?us-ascii?Q?FvRlajnM9BXWkzE1SCHzGXKkU6y+zGvA25b5sMOloVDpxYSgxlP4HiX+tq+0?=
 =?us-ascii?Q?vQBgaHv95tmqQo8gkorxUdQf+uVoP/UuR1kaobzNJgFpaPQRMdOxrqg/Wert?=
 =?us-ascii?Q?zV3JRTy5kJSmx4DAdsyMb/g9aTO34pYWTeoWp1lOwm1RrjUWE0GMbHKQ6GD9?=
 =?us-ascii?Q?/Habj1BsY01hfaAgE8UeO/oLrBfP/AAGwZtTZxybYb4qkRCW7SwMLeHWZMgy?=
 =?us-ascii?Q?ool9DpxLpcMZNbaeBVt09CtfUpPs+eDU7cEow8a3UYHoerucvnURd0Y0VSYl?=
 =?us-ascii?Q?GdYterBpODDe98mC5I7GF6AdeAaUHsgpPY02uYjsS7qqXxBk0CHE7tRSO/oy?=
 =?us-ascii?Q?p/SaiQkIEPrYL0k/uNJdkmAxyXYjU/vT9pr4z8biOlbtMiF6Ww+Ioen6i3q+?=
 =?us-ascii?Q?09emv0xlGCGj7RyvwwfcWt+s5pYzq226wJ1w/mYMzSx6PD0OHE5yL4rOhNaQ?=
 =?us-ascii?Q?RH/CCO143H9WC7B8iSgHy5r/oRl7QExWPiA6hQYokVHkxqcPCNnN0pd6WdbU?=
 =?us-ascii?Q?n0bIwpU4pMhr7lov0cG+CyLFev4iRMgCxDcyNKRWdmUxnLFxJZ9XhsDEDD7D?=
 =?us-ascii?Q?WdQrXtXgd3x3++lp4s73yH96+kbIZxbJF5Ftzj8AjQd5d/pLTWhT7QUu66CO?=
 =?us-ascii?Q?a2a/ZDBPXnV7lNstrQfZmJnrJynjPE+NdCA2gC6VVpx160Kma9ZCtqxTvkbA?=
 =?us-ascii?Q?bv/5llgjNb8W/hPBjLMvvmfDF9X+aWn3XK9ISWCqr8u/rold0eQd0U0o0dAF?=
 =?us-ascii?Q?WZW8vEFXlZSrl/CfDUel7J6d4E9YTS64BY5oF7niMVZRnGc1off2oh2I5KhE?=
 =?us-ascii?Q?fjCUVntRvgnkZik7v2o3SuHsCkmkxcnCX3HVHIGaCGf8wY3HcxslNKsylXY8?=
 =?us-ascii?Q?XR4oo/OW4igTv1umaryKBPnPx+JFVg0/2GMcElPxKCK3V6FvJ82KpRyECESK?=
 =?us-ascii?Q?XXyAKx1ScWKGZJTbcDaIoEkehNjfhPlNs4QRj5HeoZQMhrF5i5FA1/oIfVR+?=
 =?us-ascii?Q?oemShOMMSZzO+z998sM0gXr69RviiGJGwyO0KX/ibV9ZBXGyNvhHJa6dfhe6?=
 =?us-ascii?Q?uNES6TZp7O+ec2KGJ/F8eAB3Rc4jasNPejHSugCXbyGmw0f624Nu+7ZTeZFi?=
 =?us-ascii?Q?CgGjLccWo+nuhopcnEGYb3XnYNc1RegMS1E1tooscgKlulL5hRQXHFXaOHMR?=
 =?us-ascii?Q?/k/IRYzi5xa2mnLJHb/bdlAcXmoB51W4rwhbIAssl+CCgKQrqgCg/EU+PCxS?=
 =?us-ascii?Q?Zd5uLZTT64W4HnFa3cz7QUH335MYmjNPnIU5GfZ4+QYvqv4ujopwn5oGLlE9?=
 =?us-ascii?Q?+xCB98jnxnm4zo8tedLMm0yWJ4Z2cSPx/kyvgKuTG9ERjnTVuWJpVPTIIGJa?=
 =?us-ascii?Q?0E+YyZ85MEg7e15T1Ig+VmPzDahU4KfY5G+/zJjK4wDhBw7PlVJsRJO3zNb9?=
 =?us-ascii?Q?IXS29EpUsHaZTFMx9pS7TYL+/QIZUEMslhTUsRDt5nzDPhoHzXRis7g1+Niw?=
 =?us-ascii?Q?7l3xI9eOSvRazQb/aQdLma3UzCR4mAL4MVNpfruW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 091b6acf-359a-4f2c-5894-08db7def9365
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 07:06:52.6598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ynF8oVgTGlksrKFNS4ebnIL0DfdKTtgOPIAAQmqOsYmapt6yikgA8K0fXrCpe8UUUdNz5HfUO3GwJ5x6m6ebL8y7xuXZAjbGFn/KOFnL9/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9649
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

Thanks for the feedback.

> -----Original Message-----
> From: Vinod Koul <vkoul@kernel.org>
> Sent: Thursday, July 6, 2023 7:15 AM
> To: Biju Das <biju.das.jz@bp.renesas.com>
> Cc: Hien Huynh <hien.huynh.px@renesas.com>; Geert Uytterhoeven
> <geert+renesas@glider.be>; Prabhakar Mahadev Lad <prabhakar.mahadev-
> lad.rj@bp.renesas.com>; dmaengine@vger.kernel.org; linux-renesas-
> soc@vger.kernel.org
> Subject: Re: [PATCH v2 2/2] dma: rz-dmac: Fix destination and source
> data size setting
>=20
> On 30-06-23, 17:17, Biju Das wrote:
> > From: Hien Huynh <hien.huynh.px@renesas.com>
>=20
> patch title should be dmaengine: xxx

Oops, missed that.

>=20
> >
> > Before setting DDS and SDS values, we need to clear its value first
> > otherwise, we get incorrect results when we change/update the DMA bus
> > width several times due to the 'OR' expression.
>=20
>=20
> >
> > Fixes: 5000d37042a6 ("dmaengine: sh: Add DMAC driver for RZ/G2L SoC")
> > Signed-off-by: Hien Huynh <hien.huynh.px@renesas.com>
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> > v1->v2:
> >  * Updated patch header.
> > ---
> >  drivers/dma/sh/rz-dmac.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c index
> > 229f642fde6b..331ea80f21b0 100644
> > --- a/drivers/dma/sh/rz-dmac.c
> > +++ b/drivers/dma/sh/rz-dmac.c
> > @@ -145,8 +145,10 @@ struct rz_dmac {
> >  #define CHCFG_REQD			BIT(3)
> >  #define CHCFG_SEL(bits)			((bits) & 0x07)
> >  #define CHCFG_MEM_COPY			(0x80400008)
> > -#define CHCFG_FILL_DDS(a)		(((a) << 16) & GENMASK(19, 16))
> > -#define CHCFG_FILL_SDS(a)		(((a) << 12) & GENMASK(15, 12))
> > +#define CHCFG_FILL_DDS_MASK		GENMASK(19, 16)
> > +#define CHCFG_FILL_DDS(a)		(((a) << 16) & CHCFG_FILL_DDS_MASK)
> > +#define CHCFG_FILL_SDS_MASK		GENMASK(15, 12)
> > +#define CHCFG_FILL_SDS(a)		(((a) << 12) & CHCFG_FILL_SDS_MASK)
>=20
> Suggestion: Consider using FIELD_PREP and FIELD_GET for this

Agreed, will send v3 with these changes.

Cheers,
Biju

>=20
> >  #define CHCFG_FILL_TM(a)		(((a) & BIT(5)) << 22)
> >  #define CHCFG_FILL_AM(a)		(((a) & GENMASK(4, 2)) << 6)
> >  #define CHCFG_FILL_LVL(a)		(((a) & BIT(1)) << 5)
> > @@ -607,12 +609,14 @@ static int rz_dmac_config(struct dma_chan *chan,
> >  	if (val =3D=3D CHCFG_DS_INVALID)
> >  		return -EINVAL;
> >
> > +	channel->chcfg &=3D ~CHCFG_FILL_DDS_MASK;
> >  	channel->chcfg |=3D CHCFG_FILL_DDS(val);
> >
> >  	val =3D rz_dmac_ds_to_val_mapping(config->src_addr_width);
> >  	if (val =3D=3D CHCFG_DS_INVALID)
> >  		return -EINVAL;
> >
> > +	channel->chcfg &=3D ~CHCFG_FILL_SDS_MASK;
> >  	channel->chcfg |=3D CHCFG_FILL_SDS(val);
> >
> >  	return 0;
> > --
> > 2.25.1
>=20
> --
> ~Vinod
