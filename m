Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B75F3D886D
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jul 2021 09:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbhG1HAM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Jul 2021 03:00:12 -0400
Received: from mail-eopbgr1400101.outbound.protection.outlook.com ([40.107.140.101]:22976
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229939AbhG1HAL (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 28 Jul 2021 03:00:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bZpitDnXoHb3SZUmd/8ckwlxPYyNGceKPvuP3aS7PLOI0OFmT4MtbGpGk+iM5k7P2W5vnDVQWwSSsXzfoz2bc2aAy/AuLFxIYWqLvc3hFiJO5qEAc81wJ6ZDcU2rz1WvR40pvu5et6cKNyvmTkot6lLSO7xqPVE2dDUlJlNuKvHfriO3qwAm5Ycx9b1pxhYJercr2vp1lkOVCFZuTKB+TjysLSOgOfEe0lQfrMdznZDUBgEKvkNv6BZPqZJgl3FF0rhVTxBJkborxhRF4Udqc8N40G/2oykT3Z6t6ZZ+qrMpZAhf3nKALhWR7fiAppuFb12+AydAfhdE61JYAwdYfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fn1VWGqT1iRoklpeB05ZYYotS+BvMOCfswEA/TFgltU=;
 b=VMjCxbzRbogEKm95y2xzxsp3MJ/pRjMbTM+dXjhVBaPgzcUNAfonzVBvPQ8GV0TnC3jXbBuplHi5ds3As02xi546vW9UNoB1RYVz7FQSoDdAjjTrLJ3ae+B7/SyCpdVXkgDnWmYrOCbWFWu3KA8SbaLjxV3glqE0sGl/N5vF7/L2fehHoORPWxG6wi9h/gTFyPKbFuMtKmK8OpwEDItI5a/NPivyGKCJnwS6YBI2bIsjgHakCBpAXwvbdYNLdIxz9VU4z1Lon6x8z/6ud9K+zE6pCTRTKrpcYubxiYeDgIpTbiaVh4LXx/3QSl/LmLy7CTjAMD/serZPPd4w58z5HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fn1VWGqT1iRoklpeB05ZYYotS+BvMOCfswEA/TFgltU=;
 b=KoLBRXladVYQ/0mAbdQ1KXLgcuW+IGwFRtDyYWUIToKnNL50jUaHcCdLa+IZiOx4yZaqBdSbxXn6IN267Vcvo57hCQdwW2LzM0eBrC3UToDKsL/6re6xFl5zFfyjtlhvXMaMBLhwYHrOZIboJOLFMNw9LNDVzbxAvr42yN3TB5A=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB5877.jpnprd01.prod.outlook.com (2603:1096:604:c0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25; Wed, 28 Jul
 2021 07:00:07 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c6f:e31f:eaa9:60fe]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c6f:e31f:eaa9:60fe%9]) with mapi id 15.20.4352.032; Wed, 28 Jul 2021
 07:00:07 +0000
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
Thread-Index: AQHXfIANJc0R/9gnn0any8kXgzWfvKtW0BiAgAAIXJCAAR/AAIAABG1Q
Date:   Wed, 28 Jul 2021 07:00:06 +0000
Message-ID: <OS0PR01MB59228D6F0AD7A51DAFFB512A86EA9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20210719092535.4474-1-biju.das.jz@bp.renesas.com>
 <20210719092535.4474-3-biju.das.jz@bp.renesas.com> <YP/+r4HzCaAZbUWh@matsya>
 <OS0PR01MB59224844C17A1EE620E2D18786E99@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <YQD3FLN0YEVk6rnr@matsya>
In-Reply-To: <YQD3FLN0YEVk6rnr@matsya>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8ab93ae-f713-42ab-5d63-08d95195554e
x-ms-traffictypediagnostic: OS3PR01MB5877:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OS3PR01MB58775CF14BFB7E55B49FEAAC86EA9@OS3PR01MB5877.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OI7yb0U4uNRPOmjGc1HlivOI3O65gUcBQcNot6gbdI7sOy54fKIMCrQA4CG24/NLjlkaelRxk9dO7rwgk2gTVaNMsNdm9fab5fOM0GxOYzPtjU23Ts1RI4WtMG7z520Lkwux0HqiEzrvnaO6mNAEc6+YzRMNEctvXJ+vGHZytS1d5mfFNa7wfSwvTKcAbznXnwbDuMycOOuAPWQW0BMr/L+4RYz4OI9zBQgl+lAPnsu7NIy+xr3pce820T0AwyZWE7FK2PD77DyZvi1DmPfbQbhG2cQYmGt43QoG45PYpbzgl2G/kpS/l/qqogtWIEIe4GOE7u9F/DJ22HlmZjLLsG4Ivi/7PZmG6mBe5EBFE12QNfQBq0g8tgo1go5SgEzwu94zTittvYl1UWV9i5E7UK6wLcuEAjEokvZtCqW5ZaNnr2M2IcCXw+gw4xZUQjvEqln9UBE1iqmBjS7yl1TdtVnLMxDW4Zlui80aKPNPkkocl0dOYahB5XICSZNefcVgMGRX0i9vgbuHGTh1eUQ9dAjVc0ak21m2OMKKA3ZBzU4R/vzL4UTrsxbEPvcck8P/RbxIyR82X2wPT66OhhXGFQOLsORPn2pqZFPPBGJbbYxkSOLUpUeLoOjD34Gc2rlQDaPnWMmnVuy3jscaX2L36xP5ZqZfHXj4yUHoo1IR75BYyTkrJsuK0St3nuj/tzP+KaAMa9bTu6zcx/iUcJlNcAcjlrDjvKk7OqKE39gXUCse8stNV4rEM8ZLEk3R3S2CKIEbSGPq9RzaF7dbReyGqmFPv0LnRULJboYJMSl5wgk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(39860400002)(366004)(136003)(186003)(316002)(33656002)(5660300002)(38070700005)(7696005)(478600001)(54906003)(38100700002)(122000001)(86362001)(71200400001)(45080400002)(6916009)(55016002)(2906002)(966005)(4326008)(66556008)(9686003)(6506007)(66946007)(8936002)(53546011)(83380400001)(76116006)(8676002)(52536014)(26005)(66476007)(64756008)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GyQZxtCu1Scrw85kUs9tjnxHGWLFg29DBpws6BImXBpzMVZUjG+wjVoFXcLo?=
 =?us-ascii?Q?X9AstWSVYo5JMOhYW/ofcx6YlDpY6xcJAwurGXcWRJsNEAnHV/mpB6FMIG/7?=
 =?us-ascii?Q?zMBwnmZDCgps+zfPSa8VmNTefCaKNdVxzEySd4TjcCFz6yca41ahSzqCR3Nl?=
 =?us-ascii?Q?Xt7MOM2UehzF7gkFgdIboVBuLQrwJf1q4hVcU4J/JHhNwWWEYVLIQV1JF/4D?=
 =?us-ascii?Q?Ukbj7nElz/y56tkp69Lb9yHqe0CsQuDadSzRRNbJuS9a5XPINACQlDPWrICv?=
 =?us-ascii?Q?I2XRirsaXGpMPccgBEKEDREZg1G49ASifWPNi59WPprkE5QczzpVWRD/ADuu?=
 =?us-ascii?Q?KX16ERWNyj2Ydd6cZyeH0TkUHIA352axzyZ39eyaWAY0De2HswYHMFyZqHYP?=
 =?us-ascii?Q?3zYxVd1sL3/8hwtKqF+WiwqZfjsTutdmtaoDoVYKhVUCeXYN9SWxAHOr+te9?=
 =?us-ascii?Q?jRET/yVn8QAYM4nTx9KhQ9/TOKsz8RctDvKqFT/z76PF/MPJLDKRcGGCxWS2?=
 =?us-ascii?Q?CFiR7RX2LTEXQDSWvLjGSOIkTw4Ube59Qyq+R0ukUSkajGJJrPobB5gkJC7n?=
 =?us-ascii?Q?xPhT4FHr09WEmKbEumXupQM7JNiDhgdn2XKq5K/URWAtCl89tp7TpdbciDZx?=
 =?us-ascii?Q?rO2bh3EtyXd9jAo09oL6ha11tIMMTb+sx1b6vd84WV1ShiwitZSU5ycUUgtF?=
 =?us-ascii?Q?Lu/XToq7Qk8w+7q5K26ERwZ88gTOgvi2zSuwltWmZWIb+xB2+D+wxX4HNktP?=
 =?us-ascii?Q?pW/jmsr0FrCiAL3mp2yYrCTJz5Vn9QwQnv5pRi027UfjivklKGSSYht2/UNM?=
 =?us-ascii?Q?K+D5wzXFwEBNxOuW1WEFYNTr9g/xiUzjMTpFrgRTMUVV27/9ZwKEaYK/BmM0?=
 =?us-ascii?Q?B5CASmW7FOsFWJMO34runeE+rDZrEoPj5ocQ9u5kHd5y726kHdsltHWpp8q2?=
 =?us-ascii?Q?ySgo54S4LVZlR9pUdZ9Q1FZEF+SUdufdhBCBC3X01DU4LSoIf0mNTxEgR03n?=
 =?us-ascii?Q?iSLsIqnpiZ+5Tdya/T1E1q84XuW6/sc6dmQr+x2nJiY6gs5AQcjlmaxasi/t?=
 =?us-ascii?Q?9p3Yf20ZcZYxjROWrZ4ockz3K0a7k4SKSB2BQD6KuGR82ENm+vMd/ToapMzm?=
 =?us-ascii?Q?I/Q2/AoRGejgOCDmFiWjuigDlyCd5wgTDga7Rxk+Tv1Tn2nTAqEvez6Vo101?=
 =?us-ascii?Q?kB6HzOUe5NP0qEolawIVK1C0cs/68SP3XvrCjKcqqbexv+Z6wdoBJH/43JpN?=
 =?us-ascii?Q?OrE+aB11G5q8Kr0X2/fQDSZhoPTFUolKViXY26p7kuTScKa4Z9RvXXmq8w3L?=
 =?us-ascii?Q?tGqwdgSKrobScl0CLGTDpksU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8ab93ae-f713-42ab-5d63-08d95195554e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2021 07:00:06.9984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZszrBXoSk/x9vf0UwJfgiwB0SG1FpUJUuG3g/eyfjPCXl5Ts+2OI1vfQGtBRbV8xvYad3JHdUvMwxh2+CCdvpH0Yubr8hgTL4U+J9iFUBvY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5877
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
> On 27-07-21, 13:45, Biju Das wrote:
> > > > +
> > > > +	if (config->peripheral_config) {
> > > > +		ch_cfg =3D config->peripheral_config;
> > > > +		channel->chcfg =3D *ch_cfg;
> > > > +	}
> > >
> > > can you explain what this the ch_cfg here and what does it represent?
> >
> > It is a 32 bit value represent channel config value which supplied by
> each client driver during slave config.
> > It contains information like transfer mode,src/destination data size,
> > Ack mode, Level type, DMA request on rising edge or falling Edge,
> request direction etc...
> >
> > For eg:- The channel config for SSI tx is (0x11228).
> > An example usage can be found here [1]
> >
> > [1]
> > https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpat=
c
> > hwork.kernel.org%2Fproject%2Flinux-renesas-soc%2Fpatch%2F2021071913404
> > 0.7964-8-biju.das.jz%40bp.renesas.com%2F&amp;data=3D04%7C01%7Cbiju.das.=
j
> > z%40bp.renesas.com%7Cf11070e86efc4c62799208d9518fc0af%7C53d82571da1947
> > e49cb4625a166a4a2a%7C0%7C0%7C637630500127702177%7CUnknown%7CTWFpbGZsb3
> > d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7
> > C1000&amp;sdata=3DfOGmnNWctgML5fHJxQwMvWr4BlsXI%2BXvVIbQv520G4A%3D&amp;=
r
> > eserved=3D0
>=20
> Sorry I dont like passing numbers like this :(
>=20
> Can you explain what is meant by each of the above values and looks like
> some (if not all) can be derived (slave config as well as transaction
> properties)


0x11228 (Tx)
0x11220 (Rx)

BIT 22:- TM :- Transfer Mode=20
Bits 16->19 :- DDS(Destination Data Size) --> 0x0001 (16 bits)
Bits 12->15 :- SDS(Source Data size)--> 0x0001 (16 bits)
Bit  11     :- Reserved
Bits 8->10 :- Ack mode  --> 0x010 (Bus cycle mode)
Bit 7 :-  Reserved
Bit 6:- LVL -->  Level -->0 (DMA request based on edge of thesignal)
Bit 5:- HIEN -->  High Enable --> 1 (Detects a DMA request on rising edge o=
f the signal)
Bit 4:- LOEN --> Low Enable -->0 (Does not DMA request on falling edge of t=
he signal)
Bit 3:- REQD --> Request Direction ->1 (DMAREQ is Destination)

Other values in this registers  for eg:- Bits 0->2, Channel selection is se=
lected by the driver

Can you please tell me which API other than slave config can be used to pas=
s this values? Which of them can be passed as
transaction properties (REQD??)to cache and use it.

Cheers,
Biju





