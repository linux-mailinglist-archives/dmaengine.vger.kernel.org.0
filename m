Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1466D3A78BA
	for <lists+dmaengine@lfdr.de>; Tue, 15 Jun 2021 10:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbhFOIIu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Jun 2021 04:08:50 -0400
Received: from mail-eopbgr1400108.outbound.protection.outlook.com ([40.107.140.108]:60160
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230332AbhFOIIs (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 15 Jun 2021 04:08:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W1HmhGppKW4x/VXXyuG4c1oPX9ASDycJcNjkEqkA0ThSkcWcMzYCndMHvGUZFHgCX7i68PP/+d6w9vxRlfajywMF6NYsZuAQxbYVajWw5VQ95lJ8c4rTvDK41bPzx2dKeUCtK9k/xiUoEnuhrkcLYk/+EERlNulhb3I45sBQSNTN7xk4kagUcLZa8L6Gh3na/YHUi/hDp7TP43+rdc3sjMD7oTjvJfPyPSDKWSkoY1GKx+j2RGK6IztTcMISOQWy4X1YkaHbr0+Swqp2uJKbaKLNlYuHNTRA3PQZvhJKB0Ktn8WgNjbxzTVmffqlUW4PHv1Kl9sYBqSgBq2JnVLwaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OVB3WYdMl/3R82/4KBgXLuOxO4TJp5xVd+OU0vPaRW0=;
 b=iS6gjhUskxYxeuOnJdPk0sSyLIvlD8D32HgVLjsTX53p0diiTTqlCaTQFHAC8sv8bqFTJYvGAXN5U7zu3sgQ+4mCmEhlcrxQBvibIL1bh5xuckxEz2iUe9t6DrHzt1ZTn9gPwtFkFK1OQ0b/zgtFEDiTaWjwNioRXLuBPjSlchtoI8PG4v15lwOC4P9X2ZnTJb5iAx3sr5pcM5owjHibXwze3eOijZQJK4BvV6RZtt86GtkOY0lGS3YPn9aqaVqDs0AXlAQV3GqN+P08ikiNl9Xw71P4gb4bkvosq1AnkkaaAtuKmEmsjMt2GoO3go3I4Geu9FtQsc1R8eneESHCLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OVB3WYdMl/3R82/4KBgXLuOxO4TJp5xVd+OU0vPaRW0=;
 b=fiUga6SX6oj5Qoplh6TUwQePYqC/i4BpDXse8l284UNYYvhKi02smttGErKLB1FpH1Jr8wJhs2BzFla5N++aqio2h5LrjqAuXkpGjqree1zWmIm70hwryCZZsQmvGCtWsKMmD/PC8G93DexZ95lq3lkcFhqCAjtEy32WHvBnFv8=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSBPR01MB2519.jpnprd01.prod.outlook.com (2603:1096:604:22::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Tue, 15 Jun
 2021 08:06:34 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b834:5e50:2ce8:9ae0]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b834:5e50:2ce8:9ae0%3]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 08:06:33 +0000
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
Thread-Index: AQHXXrYS1Y35K9bUV02GRKgFCWvED6sTb4CAgAAIHiCAAB5YgIAAGraggAADZICAAABasIAAAroAgAAAsKCAABDLAIAA6wHw
Date:   Tue, 15 Jun 2021 08:06:33 +0000
Message-ID: <OS0PR01MB5922C23FE23E0D3BD4A71CBC86309@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20210611113642.18457-1-biju.das.jz@bp.renesas.com>
 <20210611113642.18457-2-biju.das.jz@bp.renesas.com>
 <CAMuHMdUQRHtVFhqmgi5EE2TNobspM3tNTP10gz-yPDJSK31ytA@mail.gmail.com>
 <OS0PR01MB5922B2355864A98B14C6DE6D86319@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <YMdnzdCvX/ur9qVr@pendragon.ideasonboard.com>
 <OS0PR01MB59227DFC38FD6CF6C568A90E86319@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <YMeBDfrVLZxSkVnL@pendragon.ideasonboard.com>
 <OS0PR01MB592282EC4F5779A2169D6AB086319@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <YMeDoj5RFZgbbRSO@pendragon.ideasonboard.com>
 <OS0PR01MB5922D0054E5A5EEFF8B4A92F86319@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <YMeSTBzIPWTDQiJQ@pendragon.ideasonboard.com>
In-Reply-To: <YMeSTBzIPWTDQiJQ@pendragon.ideasonboard.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ideasonboard.com; dkim=none (message not signed)
 header.d=none;ideasonboard.com; dmarc=none action=none
 header.from=bp.renesas.com;
x-originating-ip: [86.139.26.177]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9dde043e-ec0f-4e2d-aa5e-08d92fd47d9d
x-ms-traffictypediagnostic: OSBPR01MB2519:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSBPR01MB2519BB5AAD081CAD908FBD1486309@OSBPR01MB2519.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zdXYsYdiPUoy4fB5ucaSztrESkgQ8isP4zexBHvxwT8SmzX423WwHh8BA2wVkEaW5jV4Ir43oyGH8gYcPbcbudJMhBpP+b15QZUecjGX7a3JpNghu3xzKFgn2HDrqRLKo7Idtq4t9gt/qVp5Ibmd7pzEx8N9J4nwexuGVcrh9tJTBsJWMk32MS+SF9CYrrGL23VJVUma1b30uT/MYEgwdmbWRmagdT3MZZ2aKF5O6zdZ4iq7hntT7xknXXyx/xKz3B97wXFQY4k+txoEu+OjKCAPZFZT8Ahnx3j4wpmb6Ew1vRb0rgF1pvWd/KXuQDwlSpotKNMjCrXDY6Ye3Db3NRWOl9D8j6Vpnu/6TZuTWMHy32tWJrnziqjym8EbNZxoHYJSlX9c98DO0/edS2067Jsv2509s/FgWAlw/KoZh+Cx4yX5MRf8p8OUMI5hH1d2casBmcQeR4xHHbTbKGU+3yxA8SHNRRs3hu8RhD2jQfMtln8kkjEEe/wRFL6qGwyrvc+lsIautGq78UzFhrTzDzxVRtfd+eh1RzadTLXZGItXIRICcTJQgtj6XQC5SGlFIqmUXuhP/J2sGSVtuIpBkSL3DQb/AYSRi93kfepB0Ue9T7UeiUfRrNQq3sLlNxwTE0inI32vdSoLxL09f4jqe0LNMHFejf4hPlLuEljh56P1qGwjA+niQ1RHihye7puV5cpOJU94HCYLwKCFW91QIuLAZeL32DynxXlfByquIJk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(39860400002)(366004)(136003)(4326008)(66946007)(8936002)(6916009)(33656002)(53546011)(66556008)(26005)(66476007)(6506007)(186003)(7696005)(66446008)(71200400001)(122000001)(316002)(2906002)(52536014)(83380400001)(76116006)(86362001)(9686003)(5660300002)(38100700002)(8676002)(478600001)(54906003)(64756008)(45080400002)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vsSpyujHppnMMqsjskQ3zi8EPwOzXZFkEjDABlBRavktZAwF3TPvOFTTaxmR?=
 =?us-ascii?Q?tK+tx/XjCbDxeQ+6gzpS6Haqi7/8RVVHD2iW8eA3hj7lSQdv2Q0CaYhVSYBm?=
 =?us-ascii?Q?8G4EK41PPGPQmH+4vUsxbb5V7m4UAvfM5MD5x1YJ2qIrs5wJ/+IY+fYUq92Q?=
 =?us-ascii?Q?r1chUC9wv63UNiXZLEMdq2hw6zgDyeQW3oP2U7uT2c22wwkWzWVbc8Ft9XYP?=
 =?us-ascii?Q?2dmCiCZKizrTjIzopRBRZEhe5dkwTjcRYRaLHgx8EQgkMifxm2Jf8NmU9VbC?=
 =?us-ascii?Q?0MDETi3nfi/EeZIJ76rBOqy+vjSJsKl3j7a4PCBKvauDBtMic/i+MvGkVNlP?=
 =?us-ascii?Q?MEM2ZR0vOn8RId8vaCsTzJkRuBvgIwSbqnmyWwclHV8mbRHKPOdYqCzR6mqC?=
 =?us-ascii?Q?iEjmaOgzHpmX+hMkr+a5FK2QF+tj5JgTHt8D7ww2b9yuNnnr8njyDqZTw0N5?=
 =?us-ascii?Q?LYeYrAjYS+dD2JmBVyKrh6/t7gqaiR1qe4FhlcwIEX2DdnRqOgVIQebDU6Vr?=
 =?us-ascii?Q?klc3YyFChjnAx2CgVSheC7gJNJS3O1soGS3+4gX8X/yzgsxU3Vhsm04C7MEU?=
 =?us-ascii?Q?gkJmEmSDKr2BN8cD+SPdTwcVZWr3WB+Jc6Vby1NqzanAr//95ye3ZLmRMZJF?=
 =?us-ascii?Q?+ww6Cu++n+XzCGBxhg45c0rkh/eUQYqda43Ij8g2OYWv/5EvBWPglOqFEpTT?=
 =?us-ascii?Q?JDW11IrQx2Hudav3SO66siI5Cbm4AjHikr2Wvf6RWsUXnkH/muyIaLpWzhLx?=
 =?us-ascii?Q?pXCFOepYznH/Tl+a5TB7kkxeQTl1uxpzgngSHacCToqHBgRfxn/MObuJFZDk?=
 =?us-ascii?Q?rl8l+8cjdEknlp3eLu+ixEzSXWrH3dF+qUyrfic0qR35A/RjZfec1/qvtPOX?=
 =?us-ascii?Q?COORRg72rUa9+cL4qP+K8QMESNvEjV3jt7lts3emEb/HaZXJxz2XJMG1f84Q?=
 =?us-ascii?Q?dwJZJ8rzUveFzB+3kbRaRTBhyRUux3sV0+ul/tClHKZSeAerLWybMIT+EvOV?=
 =?us-ascii?Q?3ZaFKi5tldlxco4PVrIZlqqmT1b3YlwjZy3Wluwmy0yol8xsHoU8lD7mDgGr?=
 =?us-ascii?Q?sBQc4F39mfE3tFeUGXSs8oekomDYjITR8GS/BsaBXyWHyA8IvPepW6Iw7j7C?=
 =?us-ascii?Q?P3mscpJKrkyugCaVOEbhYSsawFFCZXOr0BckkqCyronNu4IWS2V8rLyVXKJq?=
 =?us-ascii?Q?VH3Q3kzd6OGLwXVojbIFzergNaLbP73/Ds0mWEUzL82CRESCm7i3ZPsgW2nL?=
 =?us-ascii?Q?Kz6MicmjN7mUWzLpNBoDyIBESuNONp5T96V435W5iEdBO5iwgBTRCWm08R1z?=
 =?us-ascii?Q?zJEnoPlgRgSn9go/93orYWuG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dde043e-ec0f-4e2d-aa5e-08d92fd47d9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2021 08:06:33.3467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z/eF2fsoQO0irGp3T42nulGfhNaeZ8KNUf0ttxGYR6Mo3H8sFsf6DuTf339ns682df+txsUami5qmO3N9lehEPBJuf/fFhCtQk+nQ5kWxr8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2519
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Laurent,

Thanks for the feedback.

> Subject: Re: [PATCH 1/5] dt-bindings: dma: Document RZ/G2L bindings
>=20
> Hi Biju,
>=20
> On Mon, Jun 14, 2021 at 04:33:03PM +0000, Biju Das wrote:
> > > On Mon, Jun 14, 2021 at 04:24:38PM +0000, Biju Das wrote:
> > > > > On Mon, Jun 14, 2021 at 04:09:04PM +0000, Biju Das wrote:
> > > > > > > On Mon, Jun 14, 2021 at 12:54:02PM +0000, Biju Das wrote:
> > > > > > > > > On Fri, Jun 11, 2021 at 1:36 PM Biju Das wrote:
> > > > > > > > > > Document RZ/G2L DMAC bindings.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > > > > > > > > Reviewed-by: Lad Prabhakar
> > > > > > > > > > <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > > > > > >
> > > > > > > > > Thanks for your patch!
> > > > > > > > >
> > > > > > > > > > --- /dev/null
> > > > > > > > > > +++ b/Documentation/devicetree/bindings/dma/renesas,rz
> > > > > > > > > > +++ -dma
> > > > > > > > > > +++ c.ya
> > > > > > > > > > +++ ml
> > > > > > > > > > @@ -0,0 +1,132 @@
> > > > > > > > > > +# SPDX-License-Identifier: (GPL-2.0-only OR
> > > > > > > > > > +BSD-2-Clause) %YAML
> > > > > > > > > > +1.2
> > > > > > > > > > +---
> > > > > > > > > > +$id:
> > > > > > > > > > +https://jpn01.safelinks.protection.outlook.com/?url=3D=
h
> > > > > > > > > > +ttp%
> > > > > > > > > > +3A%2
> > > > > > > > > > +F%2F
> > > > > > > > > > +devi
> > > > > > > > > > +cetree.org%2Fschemas%2Fdma%2Frenesas%2Crz-dmac.yaml%2
> > > > > > > > > > +3&am
> > > > > > > > > > +p;da
> > > > > > > > > > +ta=3D0
> > > > > > > > > > +4%7C
> > > > > > > > > > +01%7Cbiju.das.jz%40bp.renesas.com%7C4b547e10cbe64b6f4
> > > > > > > > > > +d850
> > > > > > > > > > +8d92
> > > > > > > > > > +f2da
> > > > > > > > > > +0c0%
> > > > > > > > > > +7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C63759269
> > > > > > > > > > +5286
> > > > > > > > > > +8468
> > > > > > > > > > +09%7
> > > > > > > > > > +CUnk
> > > > > > > > > > +nown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMz
> > > > > > > > > > +IiLC
> > > > > > > > > > +JBTi
> > > > > > > > > > +I6Ik
> > > > > > > > > > +1haW
> > > > > > > > > > +wiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D5Jh%2FxPaia5ZOY0Cr=
V
> > > > > > > > > > +iQCc
> > > > > > > > > > +rNtz
> > > > > > > > > > +uDej
> > > > > > > > > > +p8wo
> > > > > > > > > > +Nrx9iO0ht8%3D&amp;reserved=3D0
> > > > > > > > > > +$schema:
> > > > > > > > > > +https://jpn01.safelinks.protection.outlook.com/?url=3D=
h
> > > > > > > > > > +ttp%
> > > > > > > > > > +3A%2
> > > > > > > > > > +F%2F
> > > > > > > > > > +devi
> > > > > > > > > > +cetree.org%2Fmeta-
> > > > > > > schemas%2Fcore.yaml%23&amp;data=3D04%7C01%7Cbiju.das.
> > > > > > > > > > +jz%40bp.renesas.com%7C4b547e10cbe64b6f4d8508d92f2da0c
> > > > > > > > > > +0%7C
> > > > > > > > > > +53d8
> > > > > > > > > > +2571
> > > > > > > > > > +da19
> > > > > > > > > > +47e49cb4625a166a4a2a%7C0%7C0%7C637592695286846809%7CU
> > > > > > > > > > +nkno
> > > > > > > > > > +wn%7
> > > > > > > > > > +CTWF
> > > > > > > > > > +pbGZ
> > > > > > > > > > +sb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1h
> > > > > > > > > > +aWwi
> > > > > > > > > > +LCJX
> > > > > > > > > > +VCI6
> > > > > > > > > > +Mn0%
> > > > > > > > > > +3D%7C1000&amp;sdata=3D5qQ1PljM3e4Bn4%2FjdldYUHRBQL3jAr=
J
> > > > > > > > > > +gRIA
> > > > > > > > > > +dLnh
> > > > > > > > > > +Jraw
> > > > > > > > > > +%3D&
> > > > > > > > > > +amp;reserved=3D0
> > > > > > >
> > > > > > > *sigh*
> > > > > > >
> > > > > > > > > > +
> > > > > > > > > > +title: Renesas RZ/G2L DMA Controller
> > > > > > > > > > +
> > > > > > > > > > +maintainers:
> > > > > > > > > > +  - Biju Das <biju.das.jz@bp.renesas.com>
> > > > > > > > > > +
> > > > > > > > > > +allOf:
> > > > > > > > > > +  - $ref: "dma-controller.yaml#"
> > > > > > > > > > +
> > > > > > > > > > +properties:
> > > > > > > > > > +  compatible:
> > > > > > > > > > +    items:
> > > > > > > > > > +      - enum:
> > > > > > > > > > +          - renesas,dmac-r9a07g044  # RZ/G2{L,LC}
> > > > > > > > >
> > > > > > > > > Please use "renesas,r9a07g044-dmac".
> > > > > > > >
> > > > > > > > OK. Will change.
> > > > > > > >
> > > > > > > > > > +      - const: renesas,rz-dmac
> > > > > > > > >
> > > > > > > > > Does this need many changes for RZ/A1H and RZ/A2M?
> > > > > > > >
> > > > > > > > It will work on both RZ/A1H and RZ/A2M. I have n't tested
> since I don't have the board.
> > > > > > > > There is some difference in MID bit size. Other wise both
> identical.
> > > > > > > >
> > > > > > > > > > +  renesas,rz-dmac-slavecfg:
> > > > > > > > > > +    $ref: /schemas/types.yaml#/definitions/uint32-arra=
y
> > > > > > > > > > +    description: |
> > > > > > > > > > +      DMA configuration for a slave channel. Each
> > > > > > > > > > + channel must have an array of
> > > > > > > > > > +      3 items as below.
> > > > > > > > > > +      first item in the array is MID+RID
> > > > > > > > >
> > > > > > > > > Already in dmas.
> > > > > > > > >
> > > > > > > > > > +      second item in the array is slave src or dst
> > > > > > > > > > + address
> > > > > > > > >
> > > > > > > > > As pointed out by Rob, already known by the slave driver.
> > > > > > > > >
> > > > > > > > > > +      third item in the array is channel configuration
> value.
> > > > > > > > >
> > > > > > > > > What exactly is this?
> > > > > > >
> > > > > > > What would prevent the DMA client from passing the
> > > > > > > configuration to the DMA channel through the DMA engine API,
> > > > > > > just like it passes the slave source or destination address ?
> > > > > >
> > > > > > On RZ/G2L, there is 1 case(SSIF ch2) where MID+RID is same for
> both tx and rx.
> > > > > > The only way we can distinguish it is from channel configuratio=
n
> value.
> > > > >
> > > > > Are those two different hardware DMA channels ? And
> > > > > configuration values change between the two ?
> > > >
> > > > Yes, REQD is different, apart from this Rx have transfer source
> > > > and Tx have Transfer destination.
> > > > This particular SSIF ch2 is used only for half duplex compared to
> > > > other SSIF channels.
> > >
> > > Does this mean there's a single DMA channel, used by two clients,
> > > but not at the same time as it only supports half-duplex ?
> >
> > From hardware perspective, it is 2 channel. For eg:- playback/recording
> use case.
> > You cannot do simultaneous playback, but you can do playback or record
> separately.
>=20
> If the two channels have the same MID+RID and only differ by the
> direction, I'd add a cell in the dmas property with the direction only.
> The source/destination address should be dropped, as it's already known b=
y
> the driver.

I have cross checked the manual again and it seems it is same DMA Tranfer r=
equest signal(ssif_dma_rt) for that
particular Dma client (SSIF ch2). So it is just one DMA. SO I will drop cel=
l2 and cell3 and just use cell1 with=20
MID+RID values in next version.


> This being said, in your example below, you have
>=20
> dmas =3D <&dmac 0x255 0x10049c18 CH_CFG(0x1,0x0,0x1,0x0,0x2,0x1,0x1,0x0)>=
,
>        <&dmac 0x256 0x10049c1c CH_CFG(0x0,0x0,0x1,0x0,0x2,0x1,0x1,0x0)>;
> dma-names =3D "tx", "rx";
>=20
> This looks like different MID+RID values for the two channels.

Yes, it is for SSIF ch0. Where it supports full duplex and it has DMA Tranf=
er request signal
ssif_dma_rx0 for receive and ssif_dma_tx0 for transmit.

Thanks,
Biju

>=20
> > > > > > > > > Does the R-Car DMAC have this too? If yes, how does its
> > > > > > > > > driver handle it?
> > > > > > > >
> > > > > > > > On R-CAR DMAC, we have only MID + RID values. Where as
> > > > > > > > here we have channel configuration value With different
> > > > > > > > set of parameter as mentioned in Table 16.4.
> > > > > > > >
> > > > > > > > Please see Page 569, Table 16.4 On-Chip Module requests
> section.
> > > > > > > >
> > > > > > > > For eg:- as per Rob's suggestion, I have modelled the
> > > > > > > > driver with the below entries in ALSA driver for
> playback/record use case.
> > > > > > > >
> > > > > > > > dmas =3D <&dmac 0x255 0x10049c18
> CH_CFG(0x1,0x0,0x1,0x0,0x2,0x1,0x1,0x0)>,
> > > > > > > >        <&dmac 0x256 0x10049c1c
> > > > > > > > CH_CFG(0x0,0x0,0x1,0x0,0x2,0x1,0x1,0x0)>;
> > > > > > > > dma-names =3D "tx", "rx";
> > > > > > > >
> > > > > > > > Using first parameter, it gets dmac channel. using second
> > > > > > > > and third parameter it configures the channel.
>=20
> --
> Regards,
>=20
> Laurent Pinchart
