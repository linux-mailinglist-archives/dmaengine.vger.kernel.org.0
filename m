Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD8C6D23E3
	for <lists+dmaengine@lfdr.de>; Fri, 31 Mar 2023 17:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbjCaPVK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 31 Mar 2023 11:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233194AbjCaPVJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 31 Mar 2023 11:21:09 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2118.outbound.protection.outlook.com [40.107.114.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64492D43;
        Fri, 31 Mar 2023 08:21:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IDrRZOOJF2EW8Ztxp7ZbBY+ifPXsf5n75lNNe+4vjR/EgUHX61rpXuOY4edeVDuhWy+YECfZXQIJcrn4RzGWZPis50kPtbuIihvjy9hMFUcA23nxTrg6pxLTPyZoNSUB2r1LL7jIzkptMvQkeYmRMrer+Gel54nsxh4mUy6HQzT2k3JgCHhwZ3uliQvW0rRYqruHdGABgQRK0/PFIU1lTtJUeLmOCLVS6fAVia+FHq9CuxCh5TtJYzM5v6F+uSix83rrrdVMzuhq2Bi4cMycgqxPKPMqKy9vo57Vj/1FI7faBz52PYTHLgPQ2BkvnS3RUIUj9NhTgGFalYlzjqyyWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zhlg7sEEiT1Wn6EusZ7Ah7EUACPJnZ5GZN+zxsDBcYE=;
 b=L+2v4oXBjMEZ2VwgvjNc3yyOSLwcnnatfkHmIozO0579yh+6+qGovXsiRhVjSBaTC5eaCq007nHjGQyZNubgfVXBuwTEhoCnPrrV/cBVUKeZe0PMO0F4tNeiMd4dYoT6mzZafXfefsrtFhb5RoFoxh/dbZauV+GiZS+A2RA2gjXOA1eH+4p5aX0zoS7eWn+p0+6OKcVhNjUCn/zgKXcI48xTQ91sgyKcgTFqputZH/6mzH+xrIfW+s2Gv9iXaZ1EI982KmuXiq2RS9DOq5uUv8Mg38+16OjhXLWvveWtjvtBR0Lj24B6hG6KjBD3ul3IygbsB1+ul+DSdKukDBJeTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhlg7sEEiT1Wn6EusZ7Ah7EUACPJnZ5GZN+zxsDBcYE=;
 b=UeFeYQ6Jm2yWcsETuCYkm4gDIbYFhLHWYbdTbi0DeBFefWtHY8BJy9bCv0E5baTaT9344HaSibz7U5ZF0uU/r9li7MUn5RHf24VYNqXGZtU3HCzdTHf0KNsLWWAa4whLVdxo/9Bal3fPMR1RrZYdvBm9K9Tqax3n+Y6f1dsLWLU=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB6104.jpnprd01.prod.outlook.com (2603:1096:604:d1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.24; Fri, 31 Mar
 2023 15:20:59 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::e521:994c:bb0e:9bf6]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::e521:994c:bb0e:9bf6%8]) with mapi id 15.20.6254.024; Fri, 31 Mar 2023
 15:20:57 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 1/3] dmaengine: sh: rz-dmac: Reinitialize lmdescriptor
 head
Thread-Topic: [PATCH 1/3] dmaengine: sh: rz-dmac: Reinitialize lmdescriptor
 head
Thread-Index: AQHZXjYDRJNb+Bi3cUaVVV+lnaSf6a8U2FcAgAASfjA=
Date:   Fri, 31 Mar 2023 15:20:56 +0000
Message-ID: <OS0PR01MB5922320042416294F810828C868F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230324094957.115071-1-biju.das.jz@bp.renesas.com>
 <20230324094957.115071-2-biju.das.jz@bp.renesas.com>
 <ZCbOtrbTUlxGVWHd@matsya>
In-Reply-To: <ZCbOtrbTUlxGVWHd@matsya>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS3PR01MB6104:EE_
x-ms-office365-filtering-correlation-id: c9b53be9-b729-4184-f800-08db31fb86bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qq3BOraSwOfKJ734twQlulam7q0N5JhfLWMXUcEfwXQFggIPNilS+6c7SoGIJLz7BBJ4VEeCkmYI8VPqe9yb7QtmzaR3PTlf6ouDL+Jam6GJ8nLSfK3u0KrOhybmBm2vsgfwNVab6n8u4Cjvw+qIpJSDd3Zy03DSrl5lLcP/ywsSZZwGAULvZEbil5dchOy/coQhGosO91jYkoyCDj4kt6R5q9HMBlQCmuH9xA4+jWIld0f/4DjHJrs+apJ+Ojdza2hGguZT1GC0XY1pwO6ddCo4y85nJCYoiS7YQa93tfj7/wgpUb43He0PR+JVr7RAyDyeYHEpS0SidPKpP7/B7GeXm4F9rjetTvZ0whVBiINzwVC5HxfUAYD2byPUCA4K87VDB4x/6emF0kW/Fq590IvoP+KIOGR5L7HwJl9Ddc8sMwj1NoelEpy24P/qH+D2UuIS9gx3vqPBQasGRf1ARHbfKbBIXMVChcZdHmFHaQyAFjGD+2P/98e4kGTO50qORn6Jq7FaP/mnF595eScJL51h6q0L8JHNf0IR19fX/Q21vSXkjmeN1Pn4BkpWm83KsU6vgRByCvu1meFNXTfj1rysyqzAOTbYXSj01uL3ziOzC54zXQjOJ0bDKbX8oJT/R65D7qhJebJSV04nEUz76w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(451199021)(38100700002)(2906002)(122000001)(52536014)(41300700001)(5660300002)(8936002)(55016003)(86362001)(33656002)(38070700005)(478600001)(9686003)(53546011)(6506007)(26005)(316002)(54906003)(966005)(71200400001)(7696005)(83380400001)(64756008)(66476007)(66556008)(66446008)(8676002)(66946007)(6916009)(186003)(4326008)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UmjZu5jAEtWBhb8dONJhlYdNvrHpWTXgPLeQKWNqRxiUXF+8uQuZEg71hVqo?=
 =?us-ascii?Q?/1S4RCUUR9euqQhfnMOVtlbUfgZcHEubmNcs6BIWkt76EGiGZFCIKYcZwtlQ?=
 =?us-ascii?Q?HpAJPUuohr97xYDFQsn9yzWnU0fkToUpgYMzqk8NX4MJo96Yv9wCeFL/qSwK?=
 =?us-ascii?Q?JTfw4nNu7CrqF2t8hKWSuryQi9mEvpuniUfTZs8HeWiPZqmndMWyKeAXmWXG?=
 =?us-ascii?Q?yyQzTfSP65NGnjSGrlYsWcXEeCPWOQr0B5qggpWkHRrxWMznDYORJSPdcKlp?=
 =?us-ascii?Q?tNkeqxyZeBxNpxs+AzYAqoQpiFvdjHPiWWU5HjUmBXpdefiyI8/D4o7Z50rF?=
 =?us-ascii?Q?esWdDaIHm1/JaXDt4TVxrefSYX+lGix2Yi+KtwpA0VRNBRrdlA5xd/FIFpVT?=
 =?us-ascii?Q?rOmLzco/aAceLHxroE66sjR6GXARPXFAAcsh8g27GirhWtlODgW6E4qbE5XA?=
 =?us-ascii?Q?tH3QH4o1a6qWMyftC3esTMmMrEEuAvkdqVXi6E+Z2Fzni3mTnU67aBZmAV/q?=
 =?us-ascii?Q?Q7U2KZ7x8VH1oXafs8WS44BwaP7J9WSSPMMgzEvQvJFNZ0nhyxehjLGr2ov9?=
 =?us-ascii?Q?vAbpF3GYjtVx/OtbwXuyniyOGIMHUStoHdzAyOTV7DJnrS3wLkMagESLx/jx?=
 =?us-ascii?Q?pGTImlv5Qc0LQJWFgEppUKWYFWLATXjkXoRrZMZQI8UWwqawoS/JSwAAmXkj?=
 =?us-ascii?Q?wSYyZrP/BMKvo6SIrDEWa049iwCfPZidQ0lsIEHsLPAG2FSZesaAtqhr6IlQ?=
 =?us-ascii?Q?l3p6AjRw+XjATG2+eAcohN32gYirp8xnox/mHxvSRkHvTHKLR/xJUyVbqRaa?=
 =?us-ascii?Q?wquHnMLQ6c2556owL8aIdKGP0uM6RfYB94KHd2YzerjLnOWZtAO5ozp9jjSV?=
 =?us-ascii?Q?V9MH11e4l/V47V5rVCqo/3yj02OQx81eImWs0FXKSVHym0FneEBfq1Ew7LJd?=
 =?us-ascii?Q?JL03z5GVeH0kCVD/tnGVyivU6HgZFj30t3jJZotKL62007yQtw+itrEYBMI6?=
 =?us-ascii?Q?8DAnP1UTLvM5SgxEq6sibls7wV2+1xdvUIm+dRih1ZgNRdAfZwW6NvE/ccys?=
 =?us-ascii?Q?Km297KuVvtqFnDGJ9oA/NBayLrQWfgJ5cfnVB4x409IpoG5Pk0s0nwQkr1MK?=
 =?us-ascii?Q?Oampx1GzestK19vTiHbrJfgPzvwLszvDcY8NHOkng19xoDwTQk5nKEwyM2/X?=
 =?us-ascii?Q?yWeXGWhH/TqvJ8D/fmDZ4GmsV1eCs3xrSoODDOch22aSYfMZw5oMgQho97pN?=
 =?us-ascii?Q?ENcDL7GCNYzXlwcOeVppGBqt26IvDQ5zTpf68OT93QSsTFG6xwF/RHmHWmxk?=
 =?us-ascii?Q?Ix59KOjHh33rTgorOxV9KmzZR89cL2DKeJX9xXXEG7DOBmElQ7xWtZz+Nrle?=
 =?us-ascii?Q?FSlcX3ndMQ8q5IlYc1vt6L7td+HWhIIWqTz0JcjKihFGl8n38/ZextCRz9R4?=
 =?us-ascii?Q?ezlleuyh27ZALXc7Q8MDRO0kH6/mXAtySh/OCJKrBrWj34NOzeOS1dusBdZE?=
 =?us-ascii?Q?VFy8ipNE/Zuo7Mr7IAFeJ/fDPppbAzwy451yhi8hPMZdLlsxqoDk3Zil8GhJ?=
 =?us-ascii?Q?hYcl/NVwNKHsE1lZoPr7vYRo40lFLXyhRXtvo6I4zmFqplpDpVklF/8YV8Pg?=
 =?us-ascii?Q?sw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9b53be9-b729-4184-f800-08db31fb86bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2023 15:20:56.9832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aSHAJ/gD19WSihsNdcD9Csh/Mw2ijB2w3McMNQeafRa5g874keaiS57w0anML2Kv525XHsJzCvN24loWUqZCRBdlCflo46fdmk89WkXf8qk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6104
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

Thanks for the feedback.

> -----Original Message-----
> From: Vinod Koul <vkoul@kernel.org>
> Sent: Friday, March 31, 2023 1:15 PM
> To: Biju Das <biju.das.jz@bp.renesas.com>
> Cc: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>; Geer=
t
> Uytterhoeven <geert+renesas@glider.be>; dmaengine@vger.kernel.org; linux-
> renesas-soc@vger.kernel.org
> Subject: Re: [PATCH 1/3] dmaengine: sh: rz-dmac: Reinitialize lmdescripto=
r
> head
>=20
> On 24-03-23, 09:49, Biju Das wrote:
> > Reinitialize link mode descriptor head during terminate_all().
> > It fixes the incorrect serial messages during serial transfer when DMA
> > is enabled.
> >
> > Based on a patch in the BSP by Long Luu <long.luu.ur@renesas.com>
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> >  drivers/dma/sh/rz-dmac.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c index
> > 6b62e01ba658..a04a37ce03fd 100644
> > --- a/drivers/dma/sh/rz-dmac.c
> > +++ b/drivers/dma/sh/rz-dmac.c
> > @@ -534,11 +534,18 @@ rz_dmac_prep_slave_sg(struct dma_chan *chan,
> > struct scatterlist *sgl,  static int rz_dmac_terminate_all(struct
> > dma_chan *chan)  {
> >  	struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
> > +	struct rz_lmdesc *lmdesc =3D channel->lmdesc.base;
> >  	unsigned long flags;
> > +	unsigned int i;
> > +
> >  	LIST_HEAD(head);
> >
> >  	rz_dmac_disable_hw(channel);
> >  	spin_lock_irqsave(&channel->vc.lock, flags);
> > +
> > +	for (i =3D 0; i < DMAC_NR_LMDESC; i++)
> > +		lmdesc[i].header =3D 0;
>=20
> Any reason not to use memset for this?

1) If I use memset, then it need to set 64 * 8 * 4 =3D 2048 bytes compared =
to=20
64 * 4 =3D256 bytes here and consistently we use the above logic in the dri=
ver.
https://elixir.bootlin.com/linux/v6.0-rc4/source/drivers/dma/sh/rz-dmac.c#L=
239

2) Another reason is if we do memset, eventhough there will not be any new =
irq,
irqthread may be still running which can cause DMA bus Error due to nxla
being null with memset. Currently nxla being assigned during probe.

https://elixir.bootlin.com/linux/v6.0-rc4/source/drivers/dma/sh/rz-dmac.c#L=
214

Cheers,
Biju


>=20
> > +
> >  	list_splice_tail_init(&channel->ld_active, &channel->ld_free);
> >  	list_splice_tail_init(&channel->ld_queue, &channel->ld_free);
> >  	spin_unlock_irqrestore(&channel->vc.lock, flags);
> > --
> > 2.25.1
>=20
> --
> ~Vinod
