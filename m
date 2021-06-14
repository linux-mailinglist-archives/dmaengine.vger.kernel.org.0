Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 198A33A6BDD
	for <lists+dmaengine@lfdr.de>; Mon, 14 Jun 2021 18:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234692AbhFNQfJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 14 Jun 2021 12:35:09 -0400
Received: from mail-eopbgr1410117.outbound.protection.outlook.com ([40.107.141.117]:6209
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234749AbhFNQfJ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 14 Jun 2021 12:35:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B+pMZDEVJxbLyBSwKBripH8kHPAy8JPgcFwHfAp4BMnZnEsi22hucrTE1Xlwa7R/jnSbWUtHGrYp5HJCXwwgX4li7Dw63gWtq310OJdsvt9hXeZAlI9hbNUPB6cfKZWa+XE9kzW/EjrczMI6ECzSk3VbKzZHURuXF06zjHstLQo79lR0NuUDSpOLuj7Ca1ZLq4A6IRf3ENswS9qS8/5CDKtt/H8bhUZCRagM9czfUMrIcocfRbBQzl2IbaaupTPCyP4duMwFkR37YMnu/eG0+sSDVMvlZTzXGZnv5HRQkUGCVN9pShE57m3JX6Xcd9HbYdXE86Zayf87S+6HUKFaWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XMY170Hirx/z4aIZhOjHMOjVGbAmOIrKW2/neHhvmnw=;
 b=nVURcXly69wdxKA80zdHsOZlW/M6aRrbEZEba5PGuGqW4sWkBhPTOzdK+uU/SpK5tOdz1Vm7mu0Zmbs/3vyGyDf5TrtlyKIOFb3RM33Hep75kgWXEppbu7CaYTORtXZk3XaQsSOJFSizwetZQtfeJvYXz85GPRyvjrqG4tyE8OaOxnpbgLqzRG25T1j0kMGj64tTS1EilstMsuJZX1ayl1Ibk4tB2VbmsWzUYxavV9VfTifEILK04xddziURd2sJPmV5FRc4INEzDGf3rbEJwbtfZvFRfOB4lswL0FLDbPt0w4MsNZJS7/qYtv2K8NTfAXyQlyhf1wCP67VqqBn1Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XMY170Hirx/z4aIZhOjHMOjVGbAmOIrKW2/neHhvmnw=;
 b=YgI2vtizc9VwVm6z43/5w99/JObMirNfgy6wg2BApvlh1xMC94RCDPRgrCv0JpB4XEBz45smwOGXJo02zgoLd2uR6JA0F6exFk6RWbWOJVhQ3NeV5WyqZFdZ0IL/yuzp26tEEdRWF6j2+GplwWqaJjbtVr1eUMou/rpgQ5CEPAk=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSAPR01MB5153.jpnprd01.prod.outlook.com (2603:1096:604:6b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.27; Mon, 14 Jun
 2021 16:33:04 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b834:5e50:2ce8:9ae0]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b834:5e50:2ce8:9ae0%3]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 16:33:04 +0000
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
Thread-Index: AQHXXrYS1Y35K9bUV02GRKgFCWvED6sTb4CAgAAIHiCAAB5YgIAAGraggAADZICAAABasIAAAroAgAAAsKA=
Date:   Mon, 14 Jun 2021 16:33:03 +0000
Message-ID: <OS0PR01MB5922D0054E5A5EEFF8B4A92F86319@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20210611113642.18457-1-biju.das.jz@bp.renesas.com>
 <20210611113642.18457-2-biju.das.jz@bp.renesas.com>
 <CAMuHMdUQRHtVFhqmgi5EE2TNobspM3tNTP10gz-yPDJSK31ytA@mail.gmail.com>
 <OS0PR01MB5922B2355864A98B14C6DE6D86319@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <YMdnzdCvX/ur9qVr@pendragon.ideasonboard.com>
 <OS0PR01MB59227DFC38FD6CF6C568A90E86319@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <YMeBDfrVLZxSkVnL@pendragon.ideasonboard.com>
 <OS0PR01MB592282EC4F5779A2169D6AB086319@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <YMeDoj5RFZgbbRSO@pendragon.ideasonboard.com>
In-Reply-To: <YMeDoj5RFZgbbRSO@pendragon.ideasonboard.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ideasonboard.com; dkim=none (message not signed)
 header.d=none;ideasonboard.com; dmarc=none action=none
 header.from=bp.renesas.com;
x-originating-ip: [193.141.219.20]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 079ff8d9-5106-408e-11a4-08d92f521552
x-ms-traffictypediagnostic: OSAPR01MB5153:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSAPR01MB51533489E89C2E1B4C966BCF86319@OSAPR01MB5153.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 70t/5aFLI7BS7xX0EIagTxoBkZ8dior3+ehEesHsLJFU8RoGb+yXTvhdb8Bw3pUnUc2F3jskF6GF4h//n5Src7QTMc0Jc8YIm+ypCUfUvirQX8do4Y4HZ4RYMNTnkBu5wwVdE8vpUPuLZP5n/0KfiMPMjjnZdTLzlLu4FC1LHDmW7sYUfBGbIX9XdF1CaBFvMrNJrIfhSaZIqr7LwcQXtqQJmgoHZCtm5IbcSoF36r7l1h7Lv9YeFfIQL2Ry6ZbZOmPci4LyHfeFe82TTTOHzUh6ySvhGtq6OBhDFzEyzUzult0SaOb3TlWbLz7GnQwhHsJuzuLoDd0ApA5ml5s1+TaZyEGcINlx8h5g77spwiyqlQVKpzvXY+kEEpwR5e3vOmoJsawkFhgny+nCDx6zKYEAfyoma/G45oB45nUXuu7ePvmR1upfn8kytDrSdWBH0ZouN8T8U+tvhuAzDViUpWwpM1GeTojxqUb8X+cHW8GaHZDN+5quJkZ4qAxSozBtBu2EU7HPpBcNwGlN74Va5plORFy6L5gkKofRJdxABrMvXNYuuIdfpLuXzBeRL9pjUw2J5ICN4hI1W0gcMSsdytXmtvTwTElNLrg7cFlumNKCsdOIEpJL3zrwEgIwfS5jhd2n82Vo5iD6pPKCFF/u2GLYG9c7n0MuPw1Ep18lpYpsn8oNmfBbtwpVmBPWcii30U63/8jYx1wrj4Gk5M/nwd1I4Q/bzmEcFMagUBv7Wvg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(396003)(346002)(366004)(136003)(376002)(76116006)(71200400001)(66946007)(9686003)(4326008)(5660300002)(6506007)(54906003)(8676002)(7696005)(53546011)(52536014)(55016002)(8936002)(316002)(186003)(38100700002)(6916009)(86362001)(478600001)(66556008)(45080400002)(66446008)(66476007)(64756008)(26005)(33656002)(83380400001)(2906002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ylM9FFZAV1Dfx9Se0llS/ij45qGO3/ZCJFynYyiBNW8B8NXkorZFpJcw9tp1?=
 =?us-ascii?Q?7eyvu5cq3Xj01alMBo0SmxXCT1QPc9kx9jcvRzHRGJLKkMH9ZkX8c5g7jgXk?=
 =?us-ascii?Q?/LkU/ogipo1A6yMzYKzBDAjEHByYdxX8fZBStEZtJ3YNum9NtxTjDw0w15n7?=
 =?us-ascii?Q?syzsw9gLAVAmLaC4Y4BEeU71Bnre8enuTYSu+MWbl+nGVXl89xxXpSNLTmX/?=
 =?us-ascii?Q?MbY9UHfv1+KFUpquOrE8b+yikj7ujDt4o0x5aF2akb22yjjQ0liXicJjl3Og?=
 =?us-ascii?Q?FdCm5BBAzXRyc4/Z4ZDtQVx9O00G69j58bsCpY+bdxvHuunlxIYGIwdzLd95?=
 =?us-ascii?Q?0McZTA4chDAT1Jy0PHr1j+rntn/xKykvwBIR4WrwivSGFbziPP+5cQkMxEzw?=
 =?us-ascii?Q?JO6mUmOdk/TQAJlmKls1s1U1fPKrLLcoi+jxZYCW1rBEYdB9F0bpQud8qaJN?=
 =?us-ascii?Q?n3jHv21kHZ7ohxOGj2K5xy6vjpOr0eiZ869nXdBHD5AuZsiXVBZa6xzE/tnH?=
 =?us-ascii?Q?0szabNbJuGJLRk9IaG3jrgx08ZMgvAqnAuXVRuacQRBIuRl3ZbLy1r5QtMZB?=
 =?us-ascii?Q?w4ZfzEIRzQU+07M7MFx0+IsC5fH+zFXQbNmCAOxRknHLA/J/WcEmRvmsRnTm?=
 =?us-ascii?Q?CPUXFulmvQ/gvdZHAZZI3JnbHStXRPV/NjNJF2TA2KaqzvP2xLOQqBgpD2o6?=
 =?us-ascii?Q?j1m80y7eeu0bQESMUL7JC2zz+WCZnDeadYTNLO/2d492n0yHLkviyvSSMFug?=
 =?us-ascii?Q?Ya8iEj79FA/KsNXlhTq8qkKNDJXLXfg/uOf7H8BXiSDoFdNLRaQxLOiFGeJX?=
 =?us-ascii?Q?ExWND1mLCg5axwImnTPmOYaX1brTwY3pNEytq06oTZQGkJyQQpcZSUoZ3QcE?=
 =?us-ascii?Q?QBWW3X9VUv8QWsjwB3UO0J4c0y+FJUYZA6mn6gqHVMM9xo3vTYRHV+LyEYYh?=
 =?us-ascii?Q?c88g6/oJAbeyX7JRKbf3QWAemlt6vRP2wlaC61j4ufvpvIlmEUFC9Yd05Dk/?=
 =?us-ascii?Q?BzTrnJkZKQsOYS/HFGKsSS3dke/gGRfb430L60Na1+Qd2UDIfzX6U+D+3e61?=
 =?us-ascii?Q?T+4rBD/DAWdbVF1dVwzZmUAStOQGRmwercOKQWYO8OeGpXSAqT5RqJD2ioCW?=
 =?us-ascii?Q?h9DN9bYR/fzUltDpUxrRkFt1W5rtSzDTlVPF4oWaPW2E7FrBL2M1K3Oi0bWB?=
 =?us-ascii?Q?1X3oESeB2Lci4hY7v/Wj3PNWiPvAxrUbGiR5K2ZOTZloU4/Z8L5J1cJ7/kv+?=
 =?us-ascii?Q?Vx+FMst6udhxONLxLvQu6kfycFkzA4kUVSLjl2oS8kg6+oj3QWSUET+1ClbZ?=
 =?us-ascii?Q?Q9EKfl/lx0ERR9d4t4qr9kSa?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 079ff8d9-5106-408e-11a4-08d92f521552
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2021 16:33:03.9138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rqhrEXni4Hj340jxpqWMdTyGSePDcKvRUZuT17LuvJH4P978hL9gWJgIIB8H0HKLBlMpzXgUZaiF9RGQ5GrDSvZYcnRfS6GlCcOGW5MKR+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB5153
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Laurent,

> Subject: Re: [PATCH 1/5] dt-bindings: dma: Document RZ/G2L bindings
>=20
> Hi Biju,
>=20
> On Mon, Jun 14, 2021 at 04:24:38PM +0000, Biju Das wrote:
> > > On Mon, Jun 14, 2021 at 04:09:04PM +0000, Biju Das wrote:
> > > > > On Mon, Jun 14, 2021 at 12:54:02PM +0000, Biju Das wrote:
> > > > > > > On Fri, Jun 11, 2021 at 1:36 PM Biju Das wrote:
> > > > > > > > Document RZ/G2L DMAC bindings.
> > > > > > > >
> > > > > > > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > > > > > > Reviewed-by: Lad Prabhakar
> > > > > > > > <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > > > >
> > > > > > > Thanks for your patch!
> > > > > > >
> > > > > > > > --- /dev/null
> > > > > > > > +++ b/Documentation/devicetree/bindings/dma/renesas,rz-dma
> > > > > > > > +++ c.ya
> > > > > > > > +++ ml
> > > > > > > > @@ -0,0 +1,132 @@
> > > > > > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > > > > > +%YAML
> > > > > > > > +1.2
> > > > > > > > +---
> > > > > > > > +$id:
> > > > > > > > +https://jpn01.safelinks.protection.outlook.com/?url=3Dhttp=
%
> > > > > > > > +3A%2
> > > > > > > > +F%2F
> > > > > > > > +devi
> > > > > > > > +cetree.org%2Fschemas%2Fdma%2Frenesas%2Crz-dmac.yaml%23&am
> > > > > > > > +p;da
> > > > > > > > +ta=3D0
> > > > > > > > +4%7C
> > > > > > > > +01%7Cbiju.das.jz%40bp.renesas.com%7C4b547e10cbe64b6f4d850
> > > > > > > > +8d92
> > > > > > > > +f2da
> > > > > > > > +0c0%
> > > > > > > > +7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C637592695286
> > > > > > > > +8468
> > > > > > > > +09%7
> > > > > > > > +CUnk
> > > > > > > > +nown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLC
> > > > > > > > +JBTi
> > > > > > > > +I6Ik
> > > > > > > > +1haW
> > > > > > > > +wiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D5Jh%2FxPaia5ZOY0CrViQC=
c
> > > > > > > > +rNtz
> > > > > > > > +uDej
> > > > > > > > +p8wo
> > > > > > > > +Nrx9iO0ht8%3D&amp;reserved=3D0
> > > > > > > > +$schema:
> > > > > > > > +https://jpn01.safelinks.protection.outlook.com/?url=3Dhttp=
%
> > > > > > > > +3A%2
> > > > > > > > +F%2F
> > > > > > > > +devi
> > > > > > > > +cetree.org%2Fmeta-
> > > > > schemas%2Fcore.yaml%23&amp;data=3D04%7C01%7Cbiju.das.
> > > > > > > > +jz%40bp.renesas.com%7C4b547e10cbe64b6f4d8508d92f2da0c0%7C
> > > > > > > > +53d8
> > > > > > > > +2571
> > > > > > > > +da19
> > > > > > > > +47e49cb4625a166a4a2a%7C0%7C0%7C637592695286846809%7CUnkno
> > > > > > > > +wn%7
> > > > > > > > +CTWF
> > > > > > > > +pbGZ
> > > > > > > > +sb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwi
> > > > > > > > +LCJX
> > > > > > > > +VCI6
> > > > > > > > +Mn0%
> > > > > > > > +3D%7C1000&amp;sdata=3D5qQ1PljM3e4Bn4%2FjdldYUHRBQL3jArJgRI=
A
> > > > > > > > +dLnh
> > > > > > > > +Jraw
> > > > > > > > +%3D&
> > > > > > > > +amp;reserved=3D0
> > > > >
> > > > > *sigh*
> > > > >
> > > > > > > > +
> > > > > > > > +title: Renesas RZ/G2L DMA Controller
> > > > > > > > +
> > > > > > > > +maintainers:
> > > > > > > > +  - Biju Das <biju.das.jz@bp.renesas.com>
> > > > > > > > +
> > > > > > > > +allOf:
> > > > > > > > +  - $ref: "dma-controller.yaml#"
> > > > > > > > +
> > > > > > > > +properties:
> > > > > > > > +  compatible:
> > > > > > > > +    items:
> > > > > > > > +      - enum:
> > > > > > > > +          - renesas,dmac-r9a07g044  # RZ/G2{L,LC}
> > > > > > >
> > > > > > > Please use "renesas,r9a07g044-dmac".
> > > > > >
> > > > > > OK. Will change.
> > > > > >
> > > > > > > > +      - const: renesas,rz-dmac
> > > > > > >
> > > > > > > Does this need many changes for RZ/A1H and RZ/A2M?
> > > > > >
> > > > > > It will work on both RZ/A1H and RZ/A2M. I have n't tested since
> I don't have the board.
> > > > > > There is some difference in MID bit size. Other wise both
> identical.
> > > > > >
> > > > > > > > +  renesas,rz-dmac-slavecfg:
> > > > > > > > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > > > > > > > +    description: |
> > > > > > > > +      DMA configuration for a slave channel. Each channel
> > > > > > > > + must have an array of
> > > > > > > > +      3 items as below.
> > > > > > > > +      first item in the array is MID+RID
> > > > > > >
> > > > > > > Already in dmas.
> > > > > > >
> > > > > > > > +      second item in the array is slave src or dst
> > > > > > > > + address
> > > > > > >
> > > > > > > As pointed out by Rob, already known by the slave driver.
> > > > > > >
> > > > > > > > +      third item in the array is channel configuration
> value.
> > > > > > >
> > > > > > > What exactly is this?
> > > > >
> > > > > What would prevent the DMA client from passing the configuration
> > > > > to the DMA channel through the DMA engine API, just like it
> > > > > passes the slave source or destination address ?
> > > >
> > > > On RZ/G2L, there is 1 case(SSIF ch2) where MID+RID is same for both
> tx and rx.
> > > > The only way we can distinguish it is from channel configuration
> value.
> > >
> > > Are those two different hardware DMA channels ? And configuration
> > > values change between the two ?
> >
> > Yes, REQD is different, apart from this Rx have transfer source and Tx
> have Transfer destination.
> > This particular SSIF ch2 is used only for half duplex compared to other
> SSIF channels.
>=20
> Does this mean there's a single DMA channel, used by two clients, but not
> at the same time as it only supports half-duplex ?


From hardware perspective, it is 2 channel. For eg:- playback/recording use=
 case.
You cannot do simultaneous playback, but you can do playback or record sepa=
rately.

Cheers,
Biju

> > > > > > > Does the R-Car DMAC have this too? If yes, how does its
> > > > > > > driver handle it?
> > > > > >
> > > > > > On R-CAR DMAC, we have only MID + RID values. Where as here we
> > > > > > have channel configuration value With different set of
> > > > > > parameter as mentioned in Table 16.4.
> > > > > >
> > > > > > Please see Page 569, Table 16.4 On-Chip Module requests section=
.
> > > > > >
> > > > > > For eg:- as per Rob's suggestion, I have modelled the driver
> > > > > > with the below entries in ALSA driver for playback/record use
> case.
> > > > > >
> > > > > > dmas =3D <&dmac 0x255 0x10049c18
> CH_CFG(0x1,0x0,0x1,0x0,0x2,0x1,0x1,0x0)>,
> > > > > >        <&dmac 0x256 0x10049c1c
> > > > > > CH_CFG(0x0,0x0,0x1,0x0,0x2,0x1,0x1,0x0)>;
> > > > > > dma-names =3D "tx", "rx";
> > > > > >
> > > > > > Using first parameter, it gets dmac channel. using second and
> > > > > > third parameter it configures the channel.
>=20
> --
> Regards,
>=20
> Laurent Pinchart
