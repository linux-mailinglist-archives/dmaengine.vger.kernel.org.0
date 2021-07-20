Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 142D93CF8D0
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jul 2021 13:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237675AbhGTKrZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Jul 2021 06:47:25 -0400
Received: from mail-eopbgr1410122.outbound.protection.outlook.com ([40.107.141.122]:19456
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237388AbhGTKrP (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 20 Jul 2021 06:47:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cyAUyzd6jBlzcBa7s0L2bJdtRPZS1Q7pRmIq71ocRPVaG4IfROyt3HIzvQbgwo+6mr9JJXwGE0EqnfYmL2iZqbbvvzUAHDiV7OnlhH+JnD8yNJ5TemvPqUIfroLQ1pQO3t3sFN8EGpTqDlc9YLWUgot9NFtAftSMJWpMO0R9AyCw2Vtqu5xTtv1iwpXtq7WAbhKey9ii2gmLnS5gW1Kiq5PvHAMF8dKcnG7EavnCX3GKHxVpSw63XDK0fH954xY2mNPh/s6HckszyVk/SoGcS3lEK2ObesYLQXhu0Zc78Vg4Iuk1kBAgLJj9WYQoF8JcBfYKriuzbZ37yf8X6aDWEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ScIXK1VYBt04gybucgJWUmNWQUAf+wyc1OIiWcLZqI4=;
 b=WodeMMRHej+nNxtF9HKcnqXUhJTeo6olHfK+x206LWnVcNruLfJoAYzXel8+t4A7z5Sjln+NMZU5fR4qW/Yi3wS9Tz0EzPa5bAHu8r8os4VFs1xBC3HQBlWPEkjAxpYiJpgZlKtuJav9MbUh6/uUHh4wl/JtVsNtAo+r4j6lM5/4nvpbbVKoWI7+zb//2jKZMoLHrg+06UpWtxXM9mZTrnOmqcfyI1ycVkkDuQCPYDDX2xM0xp39LOhZP9T3xymp4GDjmOhjOO0jHaMj7jvfQ0dIATfmgyStN+twhtvMJYWOB/VMc42PLLaQ0/4WrniLqdMWlZLKkSbDs/BdvI7JOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ScIXK1VYBt04gybucgJWUmNWQUAf+wyc1OIiWcLZqI4=;
 b=SXB9BsKlII2JehmPtr9os2O4wIwJBTFgJenyVe0k6naiB5+JefRfGE5pJxXjuzh8FQxjsvGXgExaZ5eCy8Sl2kHduryiFkqTH6y7HuswZso30EfOb8uudvQ/WGyAjVEION7eT8H1QgWgNXtN8jShkvejyIL4TXJGRcckkJFGPGU=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSBPR01MB3478.jpnprd01.prod.outlook.com (2603:1096:604:46::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.28; Tue, 20 Jul
 2021 11:27:51 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c6f:e31f:eaa9:60fe]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c6f:e31f:eaa9:60fe%9]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 11:27:51 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Rob Herring <robh@kernel.org>
CC:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Chris Brandt <Chris.Brandt@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v4 1/4] dt-bindings: dma: Document RZ/G2L bindings
Thread-Topic: [PATCH v4 1/4] dt-bindings: dma: Document RZ/G2L bindings
Thread-Index: AQHXfIB7fKy+DpCHFU6OwcVXg6WT86tKUDgAgAFrHWA=
Date:   Tue, 20 Jul 2021 11:27:50 +0000
Message-ID: <OS0PR01MB5922E54D778E51022D6A5B9286E29@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20210719092842.4686-1-biju.das.jz@bp.renesas.com>
 <1626702448.459307.1811207.nullmailer@robh.at.kernel.org>
In-Reply-To: <1626702448.459307.1811207.nullmailer@robh.at.kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2d477d05-2285-4f89-5940-08d94b7168cf
x-ms-traffictypediagnostic: OSBPR01MB3478:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSBPR01MB3478A201A417A7B3B7FAD7EB86E29@OSBPR01MB3478.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VsgXF0cJJTt1n+rAE2xVP5kEy4FySVZpNijK1VolSOQbjev+hhLPx2UGlYmr3DyPiQLzeDf3E9RhovqfZjYumb5kQJ5fSG209cj02YMKVwCX+Yy1YtmQuWsXgwJCH0l5CiCAWkHbTSEB9N6GHXTEa/8+fNRIe3hF/80sMReg7D6P/3qXARptbO7TAZzmCYtYgv3dK/mBFw/vkb/CJIxTpirTigdv1wNDImQ63/YPYKYISlqJpfstdtxs0jHWpKLtBqGcq5xAcyoheUcK2pOTw5Z0NpeIdf7Zkq8De+yga+y+yJOauuok3leYWUexeafCYJu7o+jMT6micFkOmVnM1jEp+VVXllrzyfzxUmLXpJQ9YxYkaRmjTBZG+2LPxVOd2kf/17Hux+mojtEBmoG5eSjxJkUwekOsAwbfQnNhHgMfz76Chmv1Rjw8vcG6vfV3uOwqcY4jJuco+qkTZAGrG3g54U8BvWbIq8+DlAhwSWGMr7/EuiKltFMU0gjRURKJaxA54MTVw3mzoD6uMGFAsknte2Ur0h9llQvMy+oyEMvRR75JQnJsF8JgUq+3OVDTlNzOrGu7N7SwvLbNhUYWIkbUUr7ywbI2jX1x4rT8LX4jHrG6luOkWyA7416Otqd4oJZKoehMwfmgInq6zVSUVkI934AuKMPkuXafsjoBtkP/GW7kq/PGdaqDl9cyiH40p0Vn06PROCTP+nfCdXVLarzLoZOJDuw7x1ioGPfmcim2ZDM05m3NrcjQBqDBJk4wG8brQqEQ5IuOd6/zV8LPM0sQRKIVN8mR5RXNGyVgIAQXMS02CZ28/6nDG0HD9NM8Tj8E2oeKSYcMmauAeSS12A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(366004)(396003)(39860400002)(966005)(66946007)(122000001)(66556008)(64756008)(66476007)(316002)(5660300002)(76116006)(53546011)(38100700002)(9686003)(6506007)(66446008)(52536014)(2906002)(83380400001)(478600001)(45080400002)(6916009)(8936002)(54906003)(86362001)(71200400001)(8676002)(33656002)(7696005)(26005)(4326008)(186003)(55016002)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?e7SxQFeOhkobdmQgvjUjIQrCxvg+ignKitB1HeAFfxsPSyGSCeaIdfZqAspn?=
 =?us-ascii?Q?rImuckICUBK9wA5Hveeq29icxeTX7k85ySBSCN+09fJx2G39BIV6cyYBqUoq?=
 =?us-ascii?Q?nkGgeTCoSSGaOwsUACbcdA3slENbY0lHIcWLUN8WZD9XME8wD2D/TpinBYsG?=
 =?us-ascii?Q?AZ2qQgFpdrHAR+NpMpdf2Z/5vSzOfplkSPM4QcJ7EUCF5kMVtd2vytPsXLm3?=
 =?us-ascii?Q?J17kwJtN3jOn3tWVjYnNNXMOKxBjRYh28rLzT5B0AGKjXi/JmchpHTwIEksV?=
 =?us-ascii?Q?/vP9l8G8VrA2+1FVa5jXlUR37l2ITEWDvoMP8IEyyNRKdU7AYfrblKZVDdHf?=
 =?us-ascii?Q?Cl0w7r8Me9HynTlhhl+mvW9tF6uwZtia8CtRhGU4M2UYzrjUsQpU/DJxurJC?=
 =?us-ascii?Q?zG+2/2dSFlz/Tfp8THcstKH0TgcF5QS3Yh+IDYBGPrJXc39UdADiv9qsV0qs?=
 =?us-ascii?Q?ZPSE2u+BTZ3UaeW23v+FOkypiBOuWaOVIB3Z3VWiedx4Pt64Ep+yOt0VAnJB?=
 =?us-ascii?Q?w7yNlXOXCbBqtSivCQC8VT6HAzRJ1leIZvlAp5r4lySR3zguSvDRbTcOiHtW?=
 =?us-ascii?Q?9lDgD0hbt93jdod5+NMyYObw6eQ1hoICQqnmSN30pqjnuU6PW57s4ePY/m2H?=
 =?us-ascii?Q?A+4gYrRtBZSbdZCwofP6Hx8WIak7+jIGxEt54YbVFf0hHv/Rxr7ZBReVzwNe?=
 =?us-ascii?Q?NdmWlsnaxai1oRlTCb2zORbn21xh+/w7mo7uF+mMX8Ay6x1z86o/oJCz0VZa?=
 =?us-ascii?Q?gGJav+nZCzaTLjoUxeLUpiSijhV8osrSdoeGXG5hSOHcOQal1ixUeeH9ISS+?=
 =?us-ascii?Q?Dt4KUBjWSjB7uBiLPyMCxvQ5hUimw5KUMd9Lm1GmjxxjF5GnAwLskfrqyV1V?=
 =?us-ascii?Q?uzaBsdMasnA+L5rFIexobuhd3Dxz8GDgvQSbOc7wF9Lc3+BnNMQE5+YlLexx?=
 =?us-ascii?Q?mNSG0CPJwlYo3mSRVsMRJJbuHSNF14zujSwIA7KaDnO+UtllBumm1y9J+MR2?=
 =?us-ascii?Q?35dvzsm1bDx8KVvGI3E8UJSZxldbdK3jmVMW6Lf/YaX+B1Hm+Jy0II4aFcTo?=
 =?us-ascii?Q?4YGeMVgD23Nwi8wLTfXbIFm0cXlFTrvWHI1vmtntx0oTv4p17M9TVNmpyozN?=
 =?us-ascii?Q?zgj7pxoTgXRxw9WUlmg/5QuQGNCMkuYLfBr6dHKZ7MJfAbJ2ixmmfHb/xwYP?=
 =?us-ascii?Q?8TXLXjlhFT69mFf/r0qYObJPMbpanTB6ocplleMuZB0/MdAZHXcHWEX6/guT?=
 =?us-ascii?Q?owL4iEHG4lVZnh6yj+vNxzUukMjISFapb95UQ2qRzAMz2eViv/hdp8Q5WXwX?=
 =?us-ascii?Q?XVBdA7XtWL+bEi+l6HG34RZZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d477d05-2285-4f89-5940-08d94b7168cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2021 11:27:51.0018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JqXC3PTWcvPgOKMSZtrZ1c9XwjffhK3I7P2itCubF8WXNo1IR9x9cs44dxA4N2I9/9qyAx7fVomgmrRGzJm/BMPztFFt8/Rzff2y1v5+hnI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3478
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Rob,

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: 19 July 2021 14:47
> To: Biju Das <biju.das.jz@bp.renesas.com>
> Cc: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>;
> dmaengine@vger.kernel.org; devicetree@vger.kernel.org; Vinod Koul
> <vkoul@kernel.org>; Chris Brandt <Chris.Brandt@renesas.com>; Geert
> Uytterhoeven <geert+renesas@glider.be>; Rob Herring <robh+dt@kernel.org>;
> Chris Paterson <Chris.Paterson2@renesas.com>; linux-renesas-
> soc@vger.kernel.org
> Subject: Re: [PATCH v4 1/4] dt-bindings: dma: Document RZ/G2L bindings
>=20
> On Mon, 19 Jul 2021 10:28:42 +0100, Biju Das wrote:
> > Document RZ/G2L DMAC bindings.
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> > v4->v5:
> >   * Added Rob's Rb tag
> > v3->v4:
> >   * Described clocks and reset properties
> > v2->v3:
> >   * Added error interrupt first.
> >   * Updated clock and reset maxitems.
> >   * Added Geert's Rb tag.
> > v1->v2:
> >   * Made interrupt names in defined order
> >   * Removed src address and channel configuration from dma-cells.
> >   * Changed the compatibele string to "renesas,r9a07g044-dmac".
> > v1:-
> >   *
> > https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpat=
c
> > hwork.kernel.org%2Fproject%2Flinux-renesas-soc%2Fpatch%2F2021061111364
> > 2.18457-2-biju.das.jz%40bp.renesas.com%2F&amp;data=3D04%7C01%7Cbiju.das=
.
> > jz%40bp.renesas.com%7C0cbeffaf1b184c1b000108d94abbcd00%7C53d82571da194
> > 7e49cb4625a166a4a2a%7C0%7C0%7C637622992718168475%7CUnknown%7CTWFpbGZsb
> > 3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%
> > 7C1000&amp;sdata=3DmHxgj1z7gJVNfLw5QiY85Cj6PztxEcIlSpDPrKZdxQU%3D&amp;r=
e
> > served=3D0
> > ---
> >  .../bindings/dma/renesas,rz-dmac.yaml         | 124 ++++++++++++++++++
> >  1 file changed, 124 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> >
>=20
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>=20
> yamllint warnings/errors:
>=20
> dtschema/dtc warnings/errors:
> Error: Documentation/devicetree/bindings/dma/renesas,rz-
> dmac.example.dts:49.30-31 syntax error FATAL ERROR: Unable to parse input
> tree
> make[1]: *** [scripts/Makefile.lib:380:
> Documentation/devicetree/bindings/dma/renesas,rz-dmac.example.dt.yaml]
> Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:1418: dt_binding_check] Error 2 \ndoc reference error=
s
> (make refcheckdocs):
>=20
> See
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatch=
wor
> k.ozlabs.org%2Fpatch%2F1506873&amp;data=3D04%7C01%7Cbiju.das.jz%40bp.rene=
sas
> .com%7C0cbeffaf1b184c1b000108d94abbcd00%7C53d82571da1947e49cb4625a166a4a2=
a
> %7C0%7C0%7C637622992718168475%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDA=
i
> LCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DrQTzshu=
8s9
> UJughkXAwZKv2TPHU%2FKQ2ea1UI%2FW6P20s%3D&amp;reserved=3D0
>=20
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.

The dependency patch for the bot error is present on 5.14-rc2 but not on 5.=
14-rc1.

Regards,
Biju

>=20
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>=20
> pip3 install dtschema --upgrade
>=20
> Please check and re-submit.

