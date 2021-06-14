Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8B03A6B97
	for <lists+dmaengine@lfdr.de>; Mon, 14 Jun 2021 18:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234589AbhFNQ0o (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 14 Jun 2021 12:26:44 -0400
Received: from mail-eopbgr1410115.outbound.protection.outlook.com ([40.107.141.115]:64128
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233044AbhFNQ0o (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 14 Jun 2021 12:26:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dpqWJ7AmtOf8NU4zbelvarnznLVrk/aw7s7xajqAzBYrVIIsB+iu1iSuB1X+y9B7CfpLmftkcLZZVHv9v7jdlrOhDntQOE5lBZQVqPs4IcdqWLRFR0bpnsmt5wz4OWPsGbcNXPwQRWLRmRYtGtcOHmIzaJlpi1v5RYF6fi9LC6L0Qxa/Zz9dTCSjw87z621wUQ6c5eGxgPk/u0VTOP1bxbeOOAGuzGuY22MYSVN8k9Gr1igbXmoVOqR3jrya7mAZSqnIEHgsOci01IeGrjlDlVveO4SzyAiVLZDHOvgtUrcJurHmytfDYHjQM6o00OgNN+53GB4kJUQ4x0+jwlBC1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTNjS07g8dtkdejdY8sSO+7BU09TOFjYST6+EgWQuwk=;
 b=KYva+HOKmczBlnV3ZmKm0gbYddeDtAvCPVbPBb2UDmoXunAdXnFoKYsr3foYgJ+1e5BhOOqg4DQgqAnesCqPiSR/FgQ+Sy38lngfBZowz3azMac6E3d23ljU1f3Cs5S7ypkFtyXzJZemfc1qXkK1ZlKq8tGRCpY2wJF2m7HwV+sqyZCtJx6UakV8Ju80v57y2XqD6lxzYsfqXXfGDlKPkd1PmodITx/NDGWTE9Azab0DQNAOn3JMCgeLZFv2Iqfs9QgigMCogYAQEh2YqtpWv8QxD9t4pU8VwH1Ulrxdy/Dsl74bgwa8s2yKuCvBgcAEmY+RigMWlFPsKzNGDxF+dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTNjS07g8dtkdejdY8sSO+7BU09TOFjYST6+EgWQuwk=;
 b=UcNbO7WvEOnY+gVVft26WfECAbuBYMK7PC9s95Ahjl7SptSldpdq+fXpHU23yRsn9S5FTxxArJkpiIEVgb63J+pNsrqYT0ml5TBEdSF519pjal3f+tNepmevG2Q6iRKe6IsUgjaiDijvVMVFVZR4An0RQGf7cjJ7ylK5VkiUZXw=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB6181.jpnprd01.prod.outlook.com (2603:1096:604:d1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Mon, 14 Jun
 2021 16:24:38 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b834:5e50:2ce8:9ae0]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b834:5e50:2ce8:9ae0%3]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 16:24:38 +0000
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
Thread-Index: AQHXXrYS1Y35K9bUV02GRKgFCWvED6sTb4CAgAAIHiCAAB5YgIAAGraggAADZICAAABasA==
Date:   Mon, 14 Jun 2021 16:24:38 +0000
Message-ID: <OS0PR01MB592282EC4F5779A2169D6AB086319@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20210611113642.18457-1-biju.das.jz@bp.renesas.com>
 <20210611113642.18457-2-biju.das.jz@bp.renesas.com>
 <CAMuHMdUQRHtVFhqmgi5EE2TNobspM3tNTP10gz-yPDJSK31ytA@mail.gmail.com>
 <OS0PR01MB5922B2355864A98B14C6DE6D86319@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <YMdnzdCvX/ur9qVr@pendragon.ideasonboard.com>
 <OS0PR01MB59227DFC38FD6CF6C568A90E86319@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <YMeBDfrVLZxSkVnL@pendragon.ideasonboard.com>
In-Reply-To: <YMeBDfrVLZxSkVnL@pendragon.ideasonboard.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ideasonboard.com; dkim=none (message not signed)
 header.d=none;ideasonboard.com; dmarc=none action=none
 header.from=bp.renesas.com;
x-originating-ip: [193.141.219.20]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 55e8cb04-de8f-4551-e92f-08d92f50e7f1
x-ms-traffictypediagnostic: OS3PR01MB6181:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OS3PR01MB6181A26C400B0DA645F5C8B786319@OS3PR01MB6181.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pQUZy6NtzWpMRMbNTtQFjnMqEOG1WqqRERveT/zzzkWTIWwvgYm9jk/jQp0N99M7oBEJbjmz2LMNUfRqEZ0PTh6QgKds/q/PuWEQYoNTNF0A5BFpmj+pU+tj35xr7KXEFZ78GPVjZ750TKCDkVEElpguGXnk9MVQjYaPQSSHYpzBgvCoNdwWhScwkP834uyh7PJunx0ydPHY9RrVvkwNTJNJeuBlOSd7WD1hm+hsX1+eF+8BgkdFpFDtrZRBiZ6crEoIvGyCOG+KS+DGNTgES/w/kqLN9/z+dMznOFVxYcxCwGzvlOvR9yKiexEOeliNvREX5buuZZEhJ377gYpQa+d8Oma96li4oAObZAwdngNQ1/oBwnF0KkKgQqY+eCZLctJGqF5k5U2hd2ZWXPWvDLslyfY9ueQVN2qotJH9lTk0mlvGYQppkLhAObLoExu0v9GIrM9BmTsi91VPM8AMrBcvO4VUUslauJDECkUmH1KL4kGMqITjLlX+WMt5IrDC1QRXIrN8hQXdkTNfLzEuBqrGYtsSv802jQxNKB3DcB5OmFcuy8VmU20UaRQoXA+SH0AHGQuG65KjUXJiGjEzyh6ODIz0+nOpE03vOb9BwcHEuNOLKWkgp/dUlfZzUtJehP8oTMKPztzuMgfVLJLmNiMQRbY5O0uhJApJD4i5WXNWRfUZYQ0VeOCpl7T0IxEKehWpsBBqX1Spfvzk5F3XSEW/slLsqpx39S3x05iueX8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(39850400004)(136003)(366004)(8936002)(66946007)(4326008)(26005)(6916009)(66556008)(66476007)(33656002)(53546011)(66446008)(6506007)(186003)(7696005)(64756008)(316002)(76116006)(83380400001)(2906002)(9686003)(55016002)(86362001)(71200400001)(52536014)(45080400002)(5660300002)(54906003)(478600001)(8676002)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?9sMLnMG/yh7UcJ7cKrHuUzLZwIAxqUS09b9N9KIMMoYlfkoa2mOk8PXRYYp3?=
 =?us-ascii?Q?YLPwEs3zOg6GxnWojQmvGTfxfNeihArQkHa4UnBRtLtPgUc76EePI42kfsFa?=
 =?us-ascii?Q?++QM930MShDUrQG4kb/5TsBo8Zh996UegOUYcFmrvS0+SrnthvzXjZPgKewt?=
 =?us-ascii?Q?EgCYQiHR+X3xtaE3mkQHDGGwIp+JyvnTjaZgKjH2+FEXwjdPQwj1YVSS3Au9?=
 =?us-ascii?Q?ybnl555sQkZ6aiUnsH733jBzbQc2rSwaAcKv1812QTaONcRh2dp0tByM4ynh?=
 =?us-ascii?Q?TVEmLh1E1Ajv8X5fk9aQ/6uwXi/xgDD3Q/58WjBnojSsMpFTyQ0uKxo2bXJZ?=
 =?us-ascii?Q?dOMFXjpbmyU2DQmWqAj6b3HVMe7ZTfVPtbDiQkljbfXXdk+mI70ZExUW9VNL?=
 =?us-ascii?Q?uKzeqaxzXs7gFE0xl2bHuIoZRyh1FnbmKPgSNvYJgEgbujAgnPrwNYOsllkQ?=
 =?us-ascii?Q?ioe1MJHXICb9PF9+/olBBUDCn+GyswoEBEigbsyzlAZDE7BBdUpH1RVPJkBx?=
 =?us-ascii?Q?v46QefKa+2sM1hsniJ49naNMBNwBaA4Uj+p9Yq7iGZkuMdAly0SHZBnqe8VV?=
 =?us-ascii?Q?4umn0Izo3hUFYIvWGGE4WyusglTlziaNpsYuBZyzpu3vQUiF78vj/jG4sKL8?=
 =?us-ascii?Q?E17ewF5aCk9jv5QmXBNTd7ZXHaohQ9LfDqPVAEjNX8GXXlyLA1Qz1k4aIhDC?=
 =?us-ascii?Q?IswzZ6M34WUQiDmYLzZq4DL/bI3+4QtHL3KAVxawQvGYZX5g8/8Ns4k/WXyu?=
 =?us-ascii?Q?F7vJuCUqgDkb9R/CGVY/k1uB1yqwRw//aXSBOnxmWotyAYirfcUBCYwm4h7B?=
 =?us-ascii?Q?YOeU4X386ss+HtIXLBdEupdwn547bKMpec2x6pkmB/Wa6E3j78dC7LaB0U+Y?=
 =?us-ascii?Q?I8bISYtwZNT6Lr0godb6DkGJhM7mizGPNYYofGHeE4duclkeRHgnqMwSODli?=
 =?us-ascii?Q?ASwZe5urH+2H4K1dCFN09DSooj8q7UXGqhCoH1HCwot4s/X7gh9txFB4tPYF?=
 =?us-ascii?Q?pHSmpeWqokYYdoWY3RMKwEcC1T4FXgEGRD35Kt8JtHCEzdBxREl7uh2rmPeg?=
 =?us-ascii?Q?jN5yceXq/87WAOTXz9aAKbOYR/+K//cmaTz+R9o0/yAL8Wa3ESFbfuyKd3Yy?=
 =?us-ascii?Q?rGxj3tkt2vlS7D8LndQLGUXT3CjvAF1ffGAxzhzk+nIDtGnCgxc5ztiRXMIr?=
 =?us-ascii?Q?WMQ73U0OW96BYOLLPCMY/J1XbmA3AMjWJproi/qOnkHsiYX/8njnzEVliMWg?=
 =?us-ascii?Q?bB4WF9C+rji1uZtfnEQVt2G/LHxgw0BPh9ExqW9pTm+tLC5J2cuKMLAcdQyj?=
 =?us-ascii?Q?hCufZKyEZmtO8PDWn+Phlix1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55e8cb04-de8f-4551-e92f-08d92f50e7f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2021 16:24:38.0325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1kOZ9ZhQ7NPHPqkplBFFPx8GkRd23iatrnydjgcuHDPU+aRJQtUvohOrf3GgAXy8QecXD++5jLkF8CxpG91gVfj5hIPRlwB2ialHrc9vKwY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6181
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Laurent,

> Subject: Re: [PATCH 1/5] dt-bindings: dma: Document RZ/G2L bindings
>=20
> Hi Biju,
>=20
> On Mon, Jun 14, 2021 at 04:09:04PM +0000, Biju Das wrote:
> > > On Mon, Jun 14, 2021 at 12:54:02PM +0000, Biju Das wrote:
> > > > > On Fri, Jun 11, 2021 at 1:36 PM Biju Das wrote:
> > > > > > Document RZ/G2L DMAC bindings.
> > > > > >
> > > > > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > > > > Reviewed-by: Lad Prabhakar
> > > > > > <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > >
> > > > > Thanks for your patch!
> > > > >
> > > > > > --- /dev/null
> > > > > > +++ b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.ya
> > > > > > +++ ml
> > > > > > @@ -0,0 +1,132 @@
> > > > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > > > +%YAML
> > > > > > +1.2
> > > > > > +---
> > > > > > +$id:
> > > > > > +https://jpn01.safelinks.protection.outlook.com/?url=3Dhttp%3A%=
2
> > > > > > +F%2F
> > > > > > +devi
> > > > > > +cetree.org%2Fschemas%2Fdma%2Frenesas%2Crz-dmac.yaml%23&amp;da
> > > > > > +ta=3D0
> > > > > > +4%7C
> > > > > > +01%7Cbiju.das.jz%40bp.renesas.com%7C4b547e10cbe64b6f4d8508d92
> > > > > > +f2da
> > > > > > +0c0%
> > > > > > +7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C6375926952868468
> > > > > > +09%7
> > > > > > +CUnk
> > > > > > +nown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTi
> > > > > > +I6Ik
> > > > > > +1haW
> > > > > > +wiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D5Jh%2FxPaia5ZOY0CrViQCcrNt=
z
> > > > > > +uDej
> > > > > > +p8wo
> > > > > > +Nrx9iO0ht8%3D&amp;reserved=3D0
> > > > > > +$schema:
> > > > > > +https://jpn01.safelinks.protection.outlook.com/?url=3Dhttp%3A%=
2
> > > > > > +F%2F
> > > > > > +devi
> > > > > > +cetree.org%2Fmeta-
> > > schemas%2Fcore.yaml%23&amp;data=3D04%7C01%7Cbiju.das.
> > > > > > +jz%40bp.renesas.com%7C4b547e10cbe64b6f4d8508d92f2da0c0%7C53d8
> > > > > > +2571
> > > > > > +da19
> > > > > > +47e49cb4625a166a4a2a%7C0%7C0%7C637592695286846809%7CUnknown%7
> > > > > > +CTWF
> > > > > > +pbGZ
> > > > > > +sb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJX
> > > > > > +VCI6
> > > > > > +Mn0%
> > > > > > +3D%7C1000&amp;sdata=3D5qQ1PljM3e4Bn4%2FjdldYUHRBQL3jArJgRIAdLn=
h
> > > > > > +Jraw
> > > > > > +%3D&
> > > > > > +amp;reserved=3D0
> > >
> > > *sigh*
> > >
> > > > > > +
> > > > > > +title: Renesas RZ/G2L DMA Controller
> > > > > > +
> > > > > > +maintainers:
> > > > > > +  - Biju Das <biju.das.jz@bp.renesas.com>
> > > > > > +
> > > > > > +allOf:
> > > > > > +  - $ref: "dma-controller.yaml#"
> > > > > > +
> > > > > > +properties:
> > > > > > +  compatible:
> > > > > > +    items:
> > > > > > +      - enum:
> > > > > > +          - renesas,dmac-r9a07g044  # RZ/G2{L,LC}
> > > > >
> > > > > Please use "renesas,r9a07g044-dmac".
> > > >
> > > > OK. Will change.
> > > >
> > > > > > +      - const: renesas,rz-dmac
> > > > >
> > > > > Does this need many changes for RZ/A1H and RZ/A2M?
> > > >
> > > > It will work on both RZ/A1H and RZ/A2M. I have n't tested since I
> don't have the board.
> > > > There is some difference in MID bit size. Other wise both identical=
.
> > > >
> > > > > > +  renesas,rz-dmac-slavecfg:
> > > > > > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > > > > > +    description: |
> > > > > > +      DMA configuration for a slave channel. Each channel
> > > > > > + must have an array of
> > > > > > +      3 items as below.
> > > > > > +      first item in the array is MID+RID
> > > > >
> > > > > Already in dmas.
> > > > >
> > > > > > +      second item in the array is slave src or dst address
> > > > >
> > > > > As pointed out by Rob, already known by the slave driver.
> > > > >
> > > > > > +      third item in the array is channel configuration value.
> > > > >
> > > > > What exactly is this?
> > >
> > > What would prevent the DMA client from passing the configuration to
> > > the DMA channel through the DMA engine API, just like it passes the
> > > slave source or destination address ?
> >
> > On RZ/G2L, there is 1 case(SSIF ch2) where MID+RID is same for both tx
> and rx.
> > The only way we can distinguish it is from channel configuration value.
>=20
> Are those two different hardware DMA channels ? And configuration values
> change between the two ?

Yes, REQD is different, apart from this Rx have transfer source and Tx have=
 Transfer destination.
This particular SSIF ch2 is used only for half duplex compared to other SSI=
F channels.

Regards,
Biju

>=20
> > > > > Does the R-Car DMAC have this too? If yes, how does its driver
> > > > > handle it?
> > > >
> > > > On R-CAR DMAC, we have only MID + RID values. Where as here we
> > > > have channel configuration value With different set of parameter
> > > > as mentioned in Table 16.4.
> > > >
> > > > Please see Page 569, Table 16.4 On-Chip Module requests section.
> > > >
> > > > For eg:- as per Rob's suggestion, I have modelled the driver with
> > > > the below entries in ALSA driver for playback/record use case.
> > > >
> > > > dmas =3D <&dmac 0x255 0x10049c18
> CH_CFG(0x1,0x0,0x1,0x0,0x2,0x1,0x1,0x0)>,
> > > >        <&dmac 0x256 0x10049c1c
> > > > CH_CFG(0x0,0x0,0x1,0x0,0x2,0x1,0x1,0x0)>;
> > > > dma-names =3D "tx", "rx";
> > > >
> > > > Using first parameter, it gets dmac channel. using second and
> > > > third parameter it configures the channel.
>=20
> --
> Regards,
>=20
> Laurent Pinchart
