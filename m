Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADE9B3D8D54
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jul 2021 13:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236073AbhG1L60 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Jul 2021 07:58:26 -0400
Received: from mail-eopbgr1410100.outbound.protection.outlook.com ([40.107.141.100]:35200
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234537AbhG1L6Z (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 28 Jul 2021 07:58:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UN+EaT1dKliHj9oyzER4Cg92QE1USgAucjt4h6tXNjvsxNuZPmHc4ICpEHRA4N8qTW2TXshWoaa5MYroKVIabYlOC425ACh9oOTpyrlR5dntpJbjEJoMNPL93ggLIj/Llyy0J9V31y5zUY6ExIEbmys2KlAh4ryeIV+lTnEZYx0zXFqh8doNhRbKcUoZAvYN+gcIalPppG0rPIuYoWvKNON0BxkakWzs9VsTDrhWbiwGIXOFrsMmGtsKEv/56+5xXdQuq9CFmWYNJuoNim5Ic6THpu4fbYxpgZucNn9AMZprJCYQByqNnpN3OmyGmhPIfH1pIO3Nw8fnGe5qQat40g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3SfNpzY39C5odOxaSmv1M16n2kRIz2Koo21PvU1ReQ=;
 b=cyWZx14ikYB1ktmAA1aRoBnw0iXdrG7jraS5w+6xty02Hr/P5awjkCrGapsaRkqySeOggDRGa6ERKVDXs2i+Q+Eeh25949j+j0YvJgvUMJq8rlh6+qT08swC6g/eddiKFKrbtHouT+626KF8Afk0/CShfVwu1gY/OB9AK7fXrfC2CS5iPBLy9dfUjtV5DBaXA/3R5yoDZWiW2449L3tZBXLQi9nH2BY9Q90NVgYLtig7BaxmFfNgDxsN3N5bUIgnj2ASGU39lyRtU3LkhZwGSWb2oHwXtdc1RAYBTbt4dkNCTQ80ozo8eNWbqaYdueh5X4LPqPAOQv83rEIHK/FsOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3SfNpzY39C5odOxaSmv1M16n2kRIz2Koo21PvU1ReQ=;
 b=R+T3Pv/ul3AWMoA3bkiybiu8wWuTQNnf2gqtaQ6qelB3zV2INSq1o2PiydkYT3UX8Agib4du5ivMR9yagmcwqf+Ero65IwMgx6zcKjCzq9HxGBHRoQR1lpdPqURdb6IAV7mCHQbJVxet84IRRoNVLweTw5Hh/J6BzZAtTB0emmg=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSYPR01MB5461.jpnprd01.prod.outlook.com (2603:1096:604:8e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25; Wed, 28 Jul
 2021 11:58:22 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c6f:e31f:eaa9:60fe]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c6f:e31f:eaa9:60fe%8]) with mapi id 15.20.4373.020; Wed, 28 Jul 2021
 11:58:22 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Chris Brandt <Chris.Brandt@renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v4 2/4] drivers: dma: sh: Add DMAC driver for RZ/G2L SoC
Thread-Topic: [PATCH v4 2/4] drivers: dma: sh: Add DMAC driver for RZ/G2L SoC
Thread-Index: AQHXfIANJc0R/9gnn0any8kXgzWfvKtW0BiAgAAIXJCAAR/AAIAABG1QgABLOICAAATp4A==
Date:   Wed, 28 Jul 2021 11:58:21 +0000
Message-ID: <OS0PR01MB592222F26C8684E8D88DA55486EA9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20210719092535.4474-1-biju.das.jz@bp.renesas.com>
 <20210719092535.4474-3-biju.das.jz@bp.renesas.com> <YP/+r4HzCaAZbUWh@matsya>
 <OS0PR01MB59224844C17A1EE620E2D18786E99@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <YQD3FLN0YEVk6rnr@matsya>
 <OS0PR01MB59228D6F0AD7A51DAFFB512A86EA9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <YQE542kiEGcYCCFO@matsya>
In-Reply-To: <YQE542kiEGcYCCFO@matsya>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 049c9490-b36f-4540-b4e7-08d951beff8e
x-ms-traffictypediagnostic: OSYPR01MB5461:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSYPR01MB54618F78C20C875D88D71F6D86EA9@OSYPR01MB5461.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FtwMMRTbZZiUJDcBLQ8g+5DlxBE76FmufV7oPNsJPaE7Ny05yF+mMNc1XLF1XzFenZtD+qVb1BFA1iO4jEiwTtywKxc9PV8kpHXZ/LL/0EkHnSpFpCqXdO4+qITdx7unBV8T2U9vGJshgfhwejb4FN1YQAuYRLISLcY29zwrsE3X1pb4mKzwQr9Cd6i5QjkRPXuPVYQQMXWYzhI4Jg52STEDCunXCSqxR+ULv5gbAoS2wdYK/9lT2g6qcKRwFEAa4sksKLHClvgSrRUyOM2+a9WV+SseVJO03LjtfpJP+PucG35HAQqPJKBRvKEnhj1Dj3J5aNkf54CxDPpiZNmYy8H7Y+8CbRa5ko5bJeHkTv25myoCFcT52lKWZlH/W/qIwMt3BShXiDFo2vjCeAtoen9F8dTEAmbBsXnE57pDRf3uHW9nRxiC+OYt2h0POtkDt5TvdU6fnerPvtna3O9jPsAzZYNlX9Z3WyxhEjGulcFK60WNAg3izz2JaHM5FbHPIS2fJrAP7dzje9EbjJXIA89TaIfaGudrC1eHZ3nS7TGdr/IygLFhRY9tSWepNC5xZc0INiHU9gJfPNecdj5cKMCNiESHwjEhVRc41Ruxhdvwx5hhn0qfhITNwgnulzfc4haFSbbCtm7m8qTPtQ2xKEbRPNZf1eGdi5VNUtUIADk6sDLb5gxGNoCUAQkqdP15HQ45YDz8yv9NWnjDREd+BA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(366004)(396003)(346002)(376002)(136003)(2906002)(54906003)(83380400001)(71200400001)(5660300002)(316002)(122000001)(38070700005)(26005)(186003)(33656002)(52536014)(4326008)(6506007)(66446008)(86362001)(66476007)(38100700002)(8676002)(9686003)(53546011)(66946007)(64756008)(66556008)(478600001)(6916009)(7696005)(76116006)(8936002)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?txfyYCUROvGMX3cpwYivq3HezJtDVlTNTxI14A6TMaTaRE2LefZ7Z65xOIrE?=
 =?us-ascii?Q?77QdK+dv8T7tSWrfBDeL0dOaFxmLT7rwN1uSM9aDydbj4MPSJ9fDPymINgUY?=
 =?us-ascii?Q?NQpv0ghA1MpD565v4GexVy7gDfV9sptHkayQJpA2MjDKPX/3vI0AqoEPpA7j?=
 =?us-ascii?Q?8wq7oCGXxqWhKcqwqYYQyAS5DJ2Bmj3vA6ny/VYUSjMVHEZV5ChadXS1cbtc?=
 =?us-ascii?Q?NI/cgX9Zs4icLctYOFeMmCf++qzMowu8lvfiMhLEC6VrUGza2xPU8pBqAt3u?=
 =?us-ascii?Q?OE/R955sxwECEMdQKD/HoJri2NPX0aNRfQ7BELCr89I4ZQjVPmUhB8LryIhc?=
 =?us-ascii?Q?4Or41GVFF8jZCrWQMkwbQo+rCf16WJNrbcUpq+0eOnbdJ3E78Dz2HjS0zSJh?=
 =?us-ascii?Q?aF+f+kmXMZyFVoqpJmHlPzpSX6MBcLQNsTRBAG9czrtvG3NbYT/lflnmuu4x?=
 =?us-ascii?Q?NV5HzRK/uALUiWlhRSNM4tI4OvRWClCWXCJYnan8frLsa0h91jiWJXcAreqq?=
 =?us-ascii?Q?4kP8CbVIPZ2rPtM0UIqKSVjKvFg+WNJbQBPKxmV0g4gp7Sm40wVEVA5vRsGg?=
 =?us-ascii?Q?31SRI4IEM2/1S9ljM2C7IwXEko9oCt6a8pIVP+6jBPNPZJGMDuB8MpWcvUCI?=
 =?us-ascii?Q?21k1VzGDiJ5Ce3m47sUfwubdxhxqc+z3QrYxxJPmosbcKnOahCw+MNSRtuqg?=
 =?us-ascii?Q?pT/Y0m6gaBbuUB335GhjJmKYnGFi7Wd5iOl+WdUomgkkw6TKjhMMfOe1h/F6?=
 =?us-ascii?Q?3thurRKTqIumrRr5LRHCga/h6czdMfM0R2LojWHyVIukVzkckRuMyA7dS6ug?=
 =?us-ascii?Q?mnuUqQF6Hw1F63ZQ6XrDmb61XjRDQo/5jFKWayJe1CKXF9r9RgeF2wgAZHhR?=
 =?us-ascii?Q?7zWifI6YyfgaFd8Bszx7bIV76g5WaOJypgmwHDj3+ko3x0MWUf65eROpAaue?=
 =?us-ascii?Q?PtnYlVTVKCMLUMhklY9E8eiP6nOuEbdw/0W18TVpkQPlyFaDGHrxVnbUbP7b?=
 =?us-ascii?Q?rA8KXau2p1ZOS15TA25aDhwRnsVSUpHZ0zCtYK8lEGP1KDYkZtdPTz8xenr1?=
 =?us-ascii?Q?bdokamsiva2gKVBoQNMIziMHFz2JXDz9FuW7TAa7kvibz1OMNbs7jkZiIu+o?=
 =?us-ascii?Q?3d3KWHKH5gMzyEwL1Ubf1LE0ykkALV5C0afR8AmhJasiD358gC+rHzmn8J86?=
 =?us-ascii?Q?0oaPYMRXozuzKh6en0Ey+HmxcvTCUxNINQWBGq7lwSRvf5P5/qQeZ0cADIUo?=
 =?us-ascii?Q?lpqiOXmVODLS6OZxWccS/GGH1VFof3wPl3cEt0esYY0zYeyPgKXK2D+PATsL?=
 =?us-ascii?Q?118UjzeLjIQsACEc6VR8JSId?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 049c9490-b36f-4540-b4e7-08d951beff8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2021 11:58:21.8035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: erTfs4PkbqngIHdwETHX8offXDgYlGUId2g0m9GF8pkGXVYkSmuJ0FYOOmNXRJnXexzGYgvkGpBEh2NXqpjd442WeuY1mD4zmL58wjv8hLE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5461
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

Thanks for the feedback.

> Subject: Re: [PATCH v4 2/4] drivers: dma: sh: Add DMAC driver for RZ/G2L
> SoC
>=20
> Hi Biju,
>=20
> On 28-07-21, 07:00, Biju Das wrote:
> > >
> > > Sorry I dont like passing numbers like this :(
> > >
> > > Can you explain what is meant by each of the above values and looks
> > > like some (if not all) can be derived (slave config as well as
> > > transaction
> > > properties)
> >
> >
> > 0x11228 (Tx)
> > 0x11220 (Rx)
> >
> > BIT 22:- TM :- Transfer Mode
>=20
> What are the values, here it seems 0

Yes, that is correct single bit. 0 means single transfer mode, 1 block tran=
sfer mode.

>=20
> > Bits 16->19 :- DDS(Destination Data Size) --> 0x0001 (16 bits) Bits
> > 12->15 :- SDS(Source Data size)--> 0x0001 (16 bits)
>=20
> use src_addr_width/dst_addr_width ..?

We support 128,256,512 and 1024 bits as well. I will extend enum dma_slave_=
buswidth to support this in another patch.
Is it ok?

>=20
> > Bit  11     :- Reserved
> > Bits 8->10 :- Ack mode  --> 0x010 (Bus cycle mode)
>=20
> What does this mean?

DMAACK output mode is coming from HW manual, A big table of around 230 entr=
ies for on chip request with dedicated values for the above bits.

0x000 -- Initial value
0x001 -- 001 (LEVEL Mode) (001 for MTU,PWM,CAN etccc
0x01x -- Bus cycle mode (010 for OSTM,I2C, SSIF)
0x1xx -- DMAACK not to output(SCIF)

>=20
> > Bit 7 :-  Reserved
> > Bit 6:- LVL -->  Level -->0 (DMA request based on edge of thesignal)
> > Bit 5:- HIEN -->  High Enable --> 1 (Detects a DMA request on rising
> > edge of the signal) Bit 4:- LOEN --> Low Enable -->0 (Does not DMA
> > request on falling edge of the signal) Bit 3:- REQD --> Request
> > Direction ->1 (DMAREQ is Destination)
>=20
> how and what decides these values
> It is now hardcoded in the client driver,=20

It is SoC specific, coming from HW manual. Each on chip peripheral has it's=
 own values.
Even source address/Destination address of the on chip module is also part =
of that table.

can we do that in dma driver
> instead? While deriving most of the values?

If we add this in DMA driver, it won't be generic. We need to prepare a big=
 LUT(based on MID +RID) for all the peripherals=20
If SSI then use a value from LUT, SCIF then another value like that.

So please let me know how do we want to proceed here?

Regards,
Biju


>=20
> --
> ~Vinod
