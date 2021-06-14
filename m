Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4C253A672E
	for <lists+dmaengine@lfdr.de>; Mon, 14 Jun 2021 14:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbhFNM4J (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 14 Jun 2021 08:56:09 -0400
Received: from mail-eopbgr1400097.outbound.protection.outlook.com ([40.107.140.97]:16293
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232901AbhFNM4I (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 14 Jun 2021 08:56:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EuZFsxrdTJGYsaUoMYCoJTYrKC8may2jiCtsxXRQvrriS+7n9nN8Cdp/uMUZElAh4nDvI0Ukt+Rjtq52UjvhDHFvATzJYUzcvCU6JW5mh9fDtioFy3IgaexBZVRvBwl2CM/nwL6vEWfCYez9CfbneL4nFreD029g7ORvX8UDAFrP9JrRU5EVnGq1EbRWuk1f7MuQgaw4fprVv+1NoVg/J2NdLv5Bs1XssRvlvP+gL3xoRylG+UJGXcGvM+Ypm+iQzdox5A7l3vuQAlh4qVEvEoOqMf5yXPsH2H/CKO3FZAeFcIhdVq3QUR9D0gitBYpa8JUROK5EXHP6Rjs+dviUZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUrm29er9fIZ5k4h1XWh991PYwky8HH6aibPA/rR9bI=;
 b=PFgYNuWeA2kA9eLQSQnclW0jJfM+XcRAt26UwLW0ix4TVUAw/Zu3LM/KuVipqnE+lUVV4miVZYAb4e7R8CCIN+KBpTk6ku3IegCS8HencKvI2MlKXOFHv1igVEicXSra93/bHVzMw4x0b2qs7cGwLnjQhLTCd9YiguKECFLKZDsvUu8+OYpBcDZJS7aA8tE9h0ajya0lQt9c/VMZCHH39cJUJm8C6QVBMM37OO+RjaNRchmY0w7DDfvyWVvL21iH1evxBVoXDLwo03qoxUvZRVjHBGa/W6e19Y0u6HaviW0g20L7mA4+mOv8ZhzdjBgwIZ1nrMztMlVCsMH4370EVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUrm29er9fIZ5k4h1XWh991PYwky8HH6aibPA/rR9bI=;
 b=nRZAt2piEeGFL77lCHZDXa4tfVzWpd9vSYCuDcRGWG1h2tzAfWaEiljS2Cim0T0ZOgrpDosayT/KBLqA0t3QwFFkoGCnI0YqirTMWGn6eJZWF+hjbbAF9iBlk1uwqwkM6nBU6yPwFWArD4ctf7JuCmlQbZWWgvS+51yBQ8+mRhY=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSBPR01MB4021.jpnprd01.prod.outlook.com (2603:1096:604:4f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Mon, 14 Jun
 2021 12:54:02 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b834:5e50:2ce8:9ae0]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b834:5e50:2ce8:9ae0%3]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 12:54:02 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Chris Brandt <Chris.Brandt@renesas.com>,
        dmaengine <dmaengine@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: RE: [PATCH 1/5] dt-bindings: dma: Document RZ/G2L bindings
Thread-Topic: [PATCH 1/5] dt-bindings: dma: Document RZ/G2L bindings
Thread-Index: AQHXXrYS1Y35K9bUV02GRKgFCWvED6sTb4CAgAAIHiA=
Date:   Mon, 14 Jun 2021 12:54:02 +0000
Message-ID: <OS0PR01MB5922B2355864A98B14C6DE6D86319@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20210611113642.18457-1-biju.das.jz@bp.renesas.com>
 <20210611113642.18457-2-biju.das.jz@bp.renesas.com>
 <CAMuHMdUQRHtVFhqmgi5EE2TNobspM3tNTP10gz-yPDJSK31ytA@mail.gmail.com>
In-Reply-To: <CAMuHMdUQRHtVFhqmgi5EE2TNobspM3tNTP10gz-yPDJSK31ytA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux-m68k.org; dkim=none (message not signed)
 header.d=none;linux-m68k.org; dmarc=none action=none
 header.from=bp.renesas.com;
x-originating-ip: [193.141.219.20]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bdac68df-0814-4bb6-8ffc-08d92f337c27
x-ms-traffictypediagnostic: OSBPR01MB4021:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSBPR01MB4021CF88E27F55B971145A6C86319@OSBPR01MB4021.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZYuIulsLlsdMhZRRpufCJzCOZEcP7YETLYbbpXHjwQD6kovAT+NqQb+A7nHymXybq1uSnWGW8D/Lx5ZCYly3hdPpNGFvtnePkucgrY6o9DoM2cgy/FlF8sdBOexik5BNuERWgog+S4RLhiFkD33FcdxmuA8Xm6fM98FjWi5ONbkxZn9T1r1hcrV2NJ3SyBZ6o4ytmpxS/RSgpLCj7lWDk09E64++FHFq56z2z/FadyuisKK0Do0khnivpYI2Yop/D3KWW/l1mCcz4+mCxKQaoKBHjeGIb7CQRYBmK09TXwpLimtbcI6O+Sk6pp3iDSCkV7Oqj+JdMiLshIhMvX+ruE39NdlXOUwvgXKtsl8Ym6Ck1jXnWnePU+gFU0b6Q/hI711273LUVdZ+B00ODiDOquMzZGFx/W95uALZ5hE9yHb/B4B767+3ITpaST8eaRyDBKOAr24fAbmBOe+TLeE+jVxOlShTE5Nrjj8lHRbVwJM/xYuXX28Tz1aMxPNAbPrSgcVBz7tkPv88y17xBfhALQMt0oo/YRzoAVNc9mLVAczU4dFMX5+a9yDCA/3OSsMZJ+2/DU2zB6E+pWEIWnyweNHG/FUF/Lm89qUUsI/s67fMXbIpGYhp4RurOG8jLjY93n92TtvMtLmnaSFsfFrSTM7oRxoP37+o2iHrRxKqGDlqIY6DMvfNWxvAQt+CFlVLLflUy8VDr4wEuVSauGCU5w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(83380400001)(8676002)(64756008)(54906003)(66446008)(66476007)(86362001)(66556008)(66946007)(2906002)(8936002)(71200400001)(55016002)(5660300002)(316002)(45080400002)(478600001)(52536014)(9686003)(6506007)(53546011)(76116006)(4326008)(7696005)(26005)(38100700002)(186003)(33656002)(6916009)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?H8LuPAPYFHOotVOD0wp+C++8y1oo9Y4yYxcUUhXIDxpuZEsIvOow3xU7BiMu?=
 =?us-ascii?Q?nW62j+1JRa+593eOloUtoupuC88OdkJXHiUU4G2ak+GUjqRtNILiK9lgDZRz?=
 =?us-ascii?Q?wYOQWbW9TbLYjfSeZqkgEneVtUn6zXemxgJtnd4ZBgu0yds8saA71LB8DH3n?=
 =?us-ascii?Q?L48gYnEn5mG6B0ihmU8XIPz8QLlNr4jxM76vAWAQLFhqSVJHWkhKt4OAs9nu?=
 =?us-ascii?Q?w9yMuWAY7OZuNICed2j4vfESUCFSpoZzwST2v5/D9D3rWcBmWrGFDAwwE1ye?=
 =?us-ascii?Q?u1WQgCUgj+/tDqvLqxjheeRlupMIHWX5ATp2QE7Ql7KfHkhQKJjsEfqx47Zp?=
 =?us-ascii?Q?xyy2c8Py26x6Dhj52fhJLLQ6UsdtIWv+oldAPAOPrT+1PE4Ej1sAuC9VEUOt?=
 =?us-ascii?Q?GPQeF7+e5JahgOdoy2qR0XOoOLLnOFuQhcIWj7SGI0nP2t9I++vSLubR7D1s?=
 =?us-ascii?Q?K5nlOe+tNg5LAna9tCG7CbzOVfFEKrtuaOGgAr2rDTSUMG0MiRTY6CvF8qNY?=
 =?us-ascii?Q?ErOWhioErTcZLwz5XqUfx7KKDLZq26JDysWJMKjmJw1EyXf7By7c/vavTguf?=
 =?us-ascii?Q?HNr7fsMuePjOVi/r9mai3u6fzmDD8IuT5FCsrJdAgnf1a9KdMTJ/NWf3FFTX?=
 =?us-ascii?Q?0af++KUB/9T92/M25NwZmKmlVUSw4HHU0cTA/UXJ3P3bcgek1zHK/ZHiwxbA?=
 =?us-ascii?Q?07MfYOF5FqTW965YwWWrOXNzCeCNVGiTGhLp5eSTcAlkRHBLNLfulha63kf+?=
 =?us-ascii?Q?Na7BC/CIBF+l4z7qk7Mx50dyh2ymxjg2vVLMfjfxf4EgIb/jIajnobGR2HKT?=
 =?us-ascii?Q?jauapM1rWUambIc6GPDxIBjWoikh7+H7xIf0fUm+ICLs2T0uVpteW8Funfzq?=
 =?us-ascii?Q?DbtsZFmFVjRYioX1uFBSCz5adZZvackQg+00dYE3GuuqQhNNJonFd0bR2oAg?=
 =?us-ascii?Q?5rxNVu5Kmud7ALgIX8n7SlSAw7TcKFNhqpgsmvR9rsHQdTISXeXbluTIPUzf?=
 =?us-ascii?Q?I9N7J14436lQCBV6CeDW5EE3LpcpxcRn4oDP/UeUpfZePz3PxlGCkczSYzJ5?=
 =?us-ascii?Q?DWJDVXdvmSq49NkXpy/TQBQish4fHB+kjE72/Xj2IMPzTRpEWZhJYio1mICe?=
 =?us-ascii?Q?vF+4i+myXilBEjQlaP5+VFxxAfzP/39LeqbnY8IlMRPY8YeUsoHPJVJ090xH?=
 =?us-ascii?Q?fqfsa7N3/fm3loHKXP3agC6Ms8EkzDSJBu6LXXnPfhAGYsX1KL94OXjBfvSi?=
 =?us-ascii?Q?byjDlyYzKNi/9J6uewZ8jm+GkkEEl/SSuWdDHOiQ0I9fHBCrDgQoIkiSJnrk?=
 =?us-ascii?Q?0WtS9U2ES50hyyqzT6f3KMhT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdac68df-0814-4bb6-8ffc-08d92f337c27
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2021 12:54:02.0340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eoGDIWm0BGgQPlauI54cgYWPz69X/F+TT3L4FeEk3UwHI7op47F+jVxo4XfI2Y3VLFq1Kzm5gue911P+a1jI4pmLRu+gHCjZSTB6BccqAAc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4021
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Geert,

Thanks for the feedback.

> -----Original Message-----
> Subject: Re: [PATCH 1/5] dt-bindings: dma: Document RZ/G2L bindings
>=20
> Hi Biju,
>=20
> On Fri, Jun 11, 2021 at 1:36 PM Biju Das <biju.das.jz@bp.renesas.com>
> wrote:
> > Document RZ/G2L DMAC bindings.
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> Thanks for your patch!
>=20
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> > @@ -0,0 +1,132 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id:
> > +https://jpn01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdev=
i
> > +cetree.org%2Fschemas%2Fdma%2Frenesas%2Crz-dmac.yaml%23&amp;data=3D04%7=
C
> > +01%7Cbiju.das.jz%40bp.renesas.com%7C4b547e10cbe64b6f4d8508d92f2da0c0%
> > +7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C637592695286846809%7CUnk
> > +nown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haW
> > +wiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D5Jh%2FxPaia5ZOY0CrViQCcrNtzuDejp8w=
o
> > +Nrx9iO0ht8%3D&amp;reserved=3D0
> > +$schema:
> > +https://jpn01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdev=
i
> > +cetree.org%2Fmeta-schemas%2Fcore.yaml%23&amp;data=3D04%7C01%7Cbiju.das=
.
> > +jz%40bp.renesas.com%7C4b547e10cbe64b6f4d8508d92f2da0c0%7C53d82571da19
> > +47e49cb4625a166a4a2a%7C0%7C0%7C637592695286846809%7CUnknown%7CTWFpbGZ
> > +sb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%
> > +3D%7C1000&amp;sdata=3D5qQ1PljM3e4Bn4%2FjdldYUHRBQL3jArJgRIAdLnhJraw%3D=
&
> > +amp;reserved=3D0
> > +
> > +title: Renesas RZ/G2L DMA Controller
> > +
> > +maintainers:
> > +  - Biju Das <biju.das.jz@bp.renesas.com>
> > +
> > +allOf:
> > +  - $ref: "dma-controller.yaml#"
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - renesas,dmac-r9a07g044  # RZ/G2{L,LC}
>=20
> Please use "renesas,r9a07g044-dmac".

OK. Will change.

> > +      - const: renesas,rz-dmac
>=20
> Does this need many changes for RZ/A1H and RZ/A2M?

It will work on both RZ/A1H and RZ/A2M. I have n't tested since I don't hav=
e the board.
There is some difference in MID bit size. Other wise both identical.

=20
> > +  renesas,rz-dmac-slavecfg:
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > +    description: |
> > +      DMA configuration for a slave channel. Each channel must have an
> array of
> > +      3 items as below.
> > +      first item in the array is MID+RID
>=20
> Already in dmas.
>=20
> > +      second item in the array is slave src or dst address
>=20
> As pointed out by Rob, already known by the slave driver.
>=20
> > +      third item in the array is channel configuration value.
>=20
> What exactly is this?
> Does the R-Car DMAC have this too? If yes, how does its driver handle it?

On R-CAR DMAC, we have only MID + RID values. Where as here we have channel=
 configuration value With different set of parameter as mentioned in Table =
16.4.

Please see Page 569, Table 16.4 On-Chip Module requests section.=20

For eg:- as per Rob's suggestion, I have modelled the driver with the below=
 entries in ALSA driver for playback/record use case.

dmas =3D <&dmac 0x255 0x10049c18 CH_CFG(0x1,0x0,0x1,0x0,0x2,0x1,0x1,0x0)>,
       <&dmac 0x256 0x10049c1c CH_CFG(0x0,0x0,0x1,0x0,0x2,0x1,0x1,0x0)>;
dma-names =3D "tx", "rx";

Using first parameter, it gets dmac channel. using second and third paramet=
er it configures=20
the channel.

Regards,
Biju

>=20
> Gr{oetje,eeting}s,
>=20
>                         Geert
>=20
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-
> m68k.org
>=20
> In personal conversations with technical people, I call myself a hacker.
> But when I'm talking to journalists I just say "programmer" or something
> like that.
>                                 -- Linus Torvalds
