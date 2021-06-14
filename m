Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97FEC3A6B4B
	for <lists+dmaengine@lfdr.de>; Mon, 14 Jun 2021 18:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234013AbhFNQLL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 14 Jun 2021 12:11:11 -0400
Received: from mail-eopbgr1410111.outbound.protection.outlook.com ([40.107.141.111]:60356
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233135AbhFNQLL (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 14 Jun 2021 12:11:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ge/cJ0eEGlDBb61yOze0cKTyTfi4fvvblqvj2l1o0RvwQG0jo+yERMwiXsQ7+1bcSrwKBp0AhXPNiDC+FA8iOlWX1XQmV2xK2uV2PSuuyI/KyP/QzOJEHA/ko1zZxZIkxdhLFA90aGG/ukZvcxmhCjAzLepevk8dVN8QdZGR1hyuFLwFqjlO9q09lFa5FelQf/ic9GTR0QPjzZ46kKoFtno0KsOLhz7VTXUO2eg04+5qUPaVDlT7KLyvU302hU6THdLmCrL1jfREiQIdrk35SZG6dvDbFMC9vvgUVQ+qyLjrBNJiEuEjpVh5IdhIBQGi90GjJ0kxM3jsQE0CH10tag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+oBATD5WKTU+lsrm8/F/QSLGUqVrt395O+JSoZ3dNY=;
 b=O6bqHme3bEDqHw/xdLKZmqE35Y2ZA5ZnZsvHfka+l8TJx/lr5O+nZLcdIwoLUGkFJU29jTwHmqauQbPCIm80e+f39F6zaYlBwVhkjQCK0K1vs2QBtJcycFoTM4j/qgXI95ZCtyfytnLFZoSYBEUMS0vbXpOVEO9aE+3gLfv3QvBtv6yHxNZNiKDGgUOYpiqeLIbS6mMWlLK3qEhOJl0KsxiUGsjFn4GhdzJ5KGg8ZqkA58WS74bAlyCA4x3o+GLAOqjej5+J29KLUPKFSsotpFuvign0DxjMkh1sVAitnnTnmOThaFaIrsFQXTTA3HxiIvA+OoUX+njyR6Kojb0x8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+oBATD5WKTU+lsrm8/F/QSLGUqVrt395O+JSoZ3dNY=;
 b=b7R211bZPS1bIP0qTjMZ8xWW7CIrFuNFjMNWpNZvix9EELcx9nOmNayR+/fHniaNQlfFnhA9aVh7jFsHYc+fuLhyUHCtDbcFz0WLjFaWtCJkSgZOXrVN78CQv1WdBJW8KjRRuzEmV5BqXMtdSwrJ9OCQBn/fJDT2in54/l2aIB0=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSAPR01MB1907.jpnprd01.prod.outlook.com (2603:1096:603:18::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Mon, 14 Jun
 2021 16:09:04 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b834:5e50:2ce8:9ae0]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b834:5e50:2ce8:9ae0%3]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 16:09:04 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chris Brandt <Chris.Brandt@renesas.com>,
        dmaengine <dmaengine@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 1/5] dt-bindings: dma: Document RZ/G2L bindings
Thread-Topic: [PATCH 1/5] dt-bindings: dma: Document RZ/G2L bindings
Thread-Index: AQHXXrYS1Y35K9bUV02GRKgFCWvED6sTb4CAgAAIHiCAAB5YgIAAGrag
Date:   Mon, 14 Jun 2021 16:09:04 +0000
Message-ID: <OS0PR01MB59227DFC38FD6CF6C568A90E86319@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20210611113642.18457-1-biju.das.jz@bp.renesas.com>
 <20210611113642.18457-2-biju.das.jz@bp.renesas.com>
 <CAMuHMdUQRHtVFhqmgi5EE2TNobspM3tNTP10gz-yPDJSK31ytA@mail.gmail.com>
 <OS0PR01MB5922B2355864A98B14C6DE6D86319@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <YMdnzdCvX/ur9qVr@pendragon.ideasonboard.com>
In-Reply-To: <YMdnzdCvX/ur9qVr@pendragon.ideasonboard.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ideasonboard.com; dkim=none (message not signed)
 header.d=none;ideasonboard.com; dmarc=none action=none
 header.from=bp.renesas.com;
x-originating-ip: [193.141.219.20]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 112dd953-3d82-4724-f4ba-08d92f4ebb4f
x-ms-traffictypediagnostic: OSAPR01MB1907:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSAPR01MB19071BCE34631E907605827D86319@OSAPR01MB1907.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W5FjAlctoS1zL2kbIOSVU8ypnBwXPE0OxG+CBvkKx0Njsrmhs3ohfTlMi2S1Ilvjm9RGulwpeQJvD6k55+KVYRI7BL7LWvUohSMTQr7Tbn17THJtiXbpy+Co8JXkhKFhHmO9WKCyBojDRNnjK4FVTes7RvCLHJkrUcuuzS7kJsyjuAEipzmDF0bFM+Xym17nrURq9Zsx5w9yOoYBQg7wSq2tzprYA2HetIekmiLfx10hYCWFr3zUoUyEV+Ao/GzSiInypkkq1Y8Jp0PmDyxclSkXrLMZ7Gyz4wi/rwpY4kXaiht9EfqB9MjvOZSu1eilg3xGgeVvmS2Wb5FWytc6ruolBOKjxg8k3tMC2p0Np8c6gOyoZPt1GV1hskx07q59m3hLPkPzPceOALLt/ia0fafGzWXFreiZKhDu1iCFTuaaIR9kRL8JpYNBG1OMrSz+rTnW+B64ymhigqF7NGYwj9qwz+5Y/cFp2FR+4R9KhoTUE/aibCJtuCsLyMmCLBUi0aGyakJhLUHECI8tgatmCHkHWtgLvfCIf9QNxDggFzgoWyzA3eoYdxss7yqcvKxsWgG95a+sqozAo3CdsosN/TiqLNYmrGN/cambYR10J7XR4oBYS2YQY/2YMuK26A6mApgu4W7NH4IxLqXgwDUyCDP7OFTlcl8FCctkHQCElgarhDq7u/nc30sozWZrryl2jDCFo+YbrjiC8WHHFbH9nN8a4Tg+0IVBOC0KqqfMzpQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(39850400004)(346002)(396003)(136003)(45080400002)(26005)(64756008)(66556008)(4326008)(316002)(54906003)(5660300002)(7696005)(66946007)(8676002)(52536014)(66446008)(6506007)(53546011)(55016002)(6916009)(66476007)(9686003)(186003)(478600001)(83380400001)(86362001)(38100700002)(122000001)(76116006)(8936002)(71200400001)(33656002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?+GhJU6O8fi5dkbRLLM3lzcFk8fmFTr1v8Q0EFjj9KJGWDaAAbmak19zqnlMq?=
 =?us-ascii?Q?LDly0aQv452e1UmfPRXRpLuUllf50YgVAz+RmR/SgpMJuNnci5+ocTKi96Vq?=
 =?us-ascii?Q?Z82UWYT4J6w8ZgQagFBZw3KjSq2DRXXE7Lpb29FMtY4scKqdvQXOg5aBwiz3?=
 =?us-ascii?Q?NVZcdoN595HnFGgVCaj6UhX17XkNV08pGwW+GvWIs6tks6+MpOL2Pgjv+5mt?=
 =?us-ascii?Q?VCQyTb0VNLCzAvSu+mV8y6ok3uppQaG78GDwEb1eyFFTkojGx9fL6chp7lZP?=
 =?us-ascii?Q?iXb6xznddOwoxPIReZW5E5kn7GsczeisDoDIjKQS308MDvTe9mkjiSeE93Vx?=
 =?us-ascii?Q?ZqtpRAc5PKRpwSQJKC8SgMqrNdxHpr0/BknLDCnL+4tpVxLVIifLXJJhPHIj?=
 =?us-ascii?Q?nRTcALL5nxzzvEVI66f/7NTh5mruobL3KMNB9QVwkx587djhDRSECAJWx0wY?=
 =?us-ascii?Q?wxKbHU6vChkE6DUivYajyx9CY4Ng2E+AaS33q/6VfrwpBYGEmt67fNftqNMc?=
 =?us-ascii?Q?n3bVCPxkRH99IK8TIl110+FPkgsfI+Yv77sKJLV8Samsxcnz/RknDQWPtz/i?=
 =?us-ascii?Q?j9u0S3q5xD3MVMBzWsk3f2L2zKniQXc9NuY+xxLm30k0d9Cqe5onGtwrXX8A?=
 =?us-ascii?Q?aB0ZM0TvZWeprO+wQG3ZZxc81ssAvENEWWUMSMLfA1JKEreaFinMx5JR8hUc?=
 =?us-ascii?Q?eYUERYeX/DMVdCcVwf6as31PaDO7YF70bkyJwuTVy+t1zMbOOPTpW5AZMQ+C?=
 =?us-ascii?Q?NRQBaprH5I2WPp95F40/RVO4A++TUryHXGYy7FAHbWT/mzRYxLYIYX7dYm3O?=
 =?us-ascii?Q?TzSi91zfk6PQNwb9/BVDrNC734DvIDRofPCcLH++tX+VxGl7CxG4wickw6Sc?=
 =?us-ascii?Q?wuuLlxx0m7phf2DhAwpJE8QX9lR92k5UZK29Zplu8puGfCpxqcCMtGMfSD2y?=
 =?us-ascii?Q?APjfRV9gjjIcejhY43y8eqvPGeX+AMER4UQYXa3gbOAm0JkmE7DW3MmxrRxf?=
 =?us-ascii?Q?OpOrnwZWjU/wilpI+9sJ42KIpL/52ClNR/6zUMcGBNtQhYMl18ODmYhOka44?=
 =?us-ascii?Q?0RrgLvYLz/XKQyJoR3IAH7w4J5sv/taMw5BgyKiJt6uz3QREH8IT9CMAvupT?=
 =?us-ascii?Q?wohyK/tqf8JM2P39ReaJQ2ihjVkmUmr0IWdnEWT3BezuKp8Nwhq6Vehr1GWx?=
 =?us-ascii?Q?8xs4LnZ0J93vHOE3o1XeQ7b7ohCHJa9nDMufR3RGE/QhqAxKaGls+zoS6GfN?=
 =?us-ascii?Q?5OxtLg+Vav6FKUnF45fYg7K4t92Avf0hgGVmUZeEqiJkU6LU86jKLjhCC/og?=
 =?us-ascii?Q?+PSj6w481X46ZnLQ/+W0Qw8W?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 112dd953-3d82-4724-f4ba-08d92f4ebb4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2021 16:09:04.4367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HO64Sjggdo4aDF+Jy10+sdCpvUY3PoSBG48u1Z8wWugZ4tRQLejBHwcwiuTmQ+DRKm7/HJdM+KSIo6uX1KXG7s3y0S8sEjpfxOENtfvIAnU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB1907
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Laurent,

Thanks for the feedback.

> Subject: Re: [PATCH 1/5] dt-bindings: dma: Document RZ/G2L bindings
>=20
> On Mon, Jun 14, 2021 at 12:54:02PM +0000, Biju Das wrote:
> > > -----Original Message-----
> > > Subject: Re: [PATCH 1/5] dt-bindings: dma: Document RZ/G2L bindings
> > >
> > > Hi Biju,
> > >
> > > On Fri, Jun 11, 2021 at 1:36 PM Biju Das
> > > <biju.das.jz@bp.renesas.com>
> > > wrote:
> > > > Document RZ/G2L DMAC bindings.
> > > >
> > > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > > Reviewed-by: Lad Prabhakar
> > > > <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > Thanks for your patch!
> > >
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> > > > @@ -0,0 +1,132 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML
> > > > +1.2
> > > > +---
> > > > +$id:
> > > > +https://jpn01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2=
F
> > > > +devi
> > > > +cetree.org%2Fschemas%2Fdma%2Frenesas%2Crz-dmac.yaml%23&amp;data=3D=
0
> > > > +4%7C
> > > > +01%7Cbiju.das.jz%40bp.renesas.com%7C4b547e10cbe64b6f4d8508d92f2da
> > > > +0c0%
> > > > +7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C637592695286846809%7
> > > > +CUnk
> > > > +nown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik
> > > > +1haW
> > > > +wiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D5Jh%2FxPaia5ZOY0CrViQCcrNtzuDe=
j
> > > > +p8wo
> > > > +Nrx9iO0ht8%3D&amp;reserved=3D0
> > > > +$schema:
> > > > +https://jpn01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2=
F
> > > > +devi
> > > > +cetree.org%2Fmeta-
> schemas%2Fcore.yaml%23&amp;data=3D04%7C01%7Cbiju.das.
> > > > +jz%40bp.renesas.com%7C4b547e10cbe64b6f4d8508d92f2da0c0%7C53d82571
> > > > +da19
> > > > +47e49cb4625a166a4a2a%7C0%7C0%7C637592695286846809%7CUnknown%7CTWF
> > > > +pbGZ
> > > > +sb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6
> > > > +Mn0%
> > > > +3D%7C1000&amp;sdata=3D5qQ1PljM3e4Bn4%2FjdldYUHRBQL3jArJgRIAdLnhJra=
w
> > > > +%3D&
> > > > +amp;reserved=3D0
>=20
> *sigh*
>=20
> > > > +
> > > > +title: Renesas RZ/G2L DMA Controller
> > > > +
> > > > +maintainers:
> > > > +  - Biju Das <biju.das.jz@bp.renesas.com>
> > > > +
> > > > +allOf:
> > > > +  - $ref: "dma-controller.yaml#"
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    items:
> > > > +      - enum:
> > > > +          - renesas,dmac-r9a07g044  # RZ/G2{L,LC}
> > >
> > > Please use "renesas,r9a07g044-dmac".
> >
> > OK. Will change.
> >
> > > > +      - const: renesas,rz-dmac
> > >
> > > Does this need many changes for RZ/A1H and RZ/A2M?
> >
> > It will work on both RZ/A1H and RZ/A2M. I have n't tested since I don't
> have the board.
> > There is some difference in MID bit size. Other wise both identical.
> >
> >
> > > > +  renesas,rz-dmac-slavecfg:
> > > > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > > > +    description: |
> > > > +      DMA configuration for a slave channel. Each channel must
> > > > + have an
> > > array of
> > > > +      3 items as below.
> > > > +      first item in the array is MID+RID
> > >
> > > Already in dmas.
> > >
> > > > +      second item in the array is slave src or dst address
> > >
> > > As pointed out by Rob, already known by the slave driver.
> > >
> > > > +      third item in the array is channel configuration value.
> > >
> > > What exactly is this?
>=20
> What would prevent the DMA client from passing the configuration to the
> DMA channel through the DMA engine API, just like it passes the slave
> source or destination address ?

On RZ/G2L, there is 1 case(SSIF ch2) where MID+RID is same for both tx and =
rx.=20
The only way we can distinguish it is from channel configuration value.

Cheers,
Biju


>=20
> > > Does the R-Car DMAC have this too? If yes, how does its driver handle
> it?
> >
> > On R-CAR DMAC, we have only MID + RID values. Where as here we have
> channel configuration value With different set of parameter as mentioned
> in Table 16.4.
> >
> > Please see Page 569, Table 16.4 On-Chip Module requests section.
> >
> > For eg:- as per Rob's suggestion, I have modelled the driver with the
> below entries in ALSA driver for playback/record use case.
> >
> > dmas =3D <&dmac 0x255 0x10049c18 CH_CFG(0x1,0x0,0x1,0x0,0x2,0x1,0x1,0x0=
)>,
> >        <&dmac 0x256 0x10049c1c
> > CH_CFG(0x0,0x0,0x1,0x0,0x2,0x1,0x1,0x0)>;
> > dma-names =3D "tx", "rx";
> >
> > Using first parameter, it gets dmac channel. using second and third
> > parameter it configures the channel.
>=20
> --
> Regards,
>=20
> Laurent Pinchart
