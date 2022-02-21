Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945014BD7F2
	for <lists+dmaengine@lfdr.de>; Mon, 21 Feb 2022 09:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbiBUIPP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Feb 2022 03:15:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbiBUIPO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 21 Feb 2022 03:15:14 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2104.outbound.protection.outlook.com [40.107.114.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CFD1929A;
        Mon, 21 Feb 2022 00:14:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ItDBSuvASgmTVcrUQUYZeV3RTHKJLAx3H75mtrBuw31b1wqWFESTNsb+F6pjttwxxuqt+WRo8q+54VTBNW8nPsnR1ogByz4X8fTbF6d5YosPm6nF32N4cUJ2ugytqsk490CtB4TDn+3Bmu1/+tRGIRVBBsktQj+VgNbTgWhP1+hgxTS4hzcYTMSEJKQDZHcEU/3+vtSQOxXME186yR4MzcJ84gQHJuC9J/jE064XDh3cS/yLjDNwUb9PkPf5eDoE1XdBpq+oTju5DcentRri2BEXx8O4oBqgp9JFgl3+1h0vHG9yF1pwSwcVmcKENUiX6Wwiwd0u+7b6Gghpli9IaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bwzHKKe2JlKxOYywfyK7OzBn0d+ukEPfrBitMs6ztUI=;
 b=Ld9hiSFmyGn94pkqiYFirtUZv/WoI8RK20yOt9d0BS27m+LF+2k7c5OWBzodAMwc5wU4r5kqjpGhDJXnuTZqH6aURpQcTd9208hPWqoMuW2DDu2MfXtDHHs9qus73es3uWfkKT2Y2GRYMNnl2+zcOFdA9zU5YHwmMLxjq5cg2/t5w8xsXG72QsuyVCMYTVlgpPO3CL2TXRGTWBZxkWXfE8kBWhld9J38L12+7KgPOcnGSXhTj/kjp4PsLocBFMPAF3edgqbu9f541DcxmRed6LKf3THlbAkxyZ5s0yxILOOFni4H6fglJmztOuApCx0UGCsIIBOmYVO0f7C9o3C8Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bwzHKKe2JlKxOYywfyK7OzBn0d+ukEPfrBitMs6ztUI=;
 b=WGr88XS5fwSITUsY1Bvn8JmlkWsiSnsw6sUaumgEIVVG0XiBvGfVvCW49NobBhjI7U7Vcy66phmyq0C2bBYjPg1popziQ4HgegqSHUuWAVjt67Gus82dYamv8giE6x9nfmC57WavT9r+eXjtToe48tbUQBeqGgVKp3GROGMRb/Y=
Received: from TYYPR01MB7086.jpnprd01.prod.outlook.com (2603:1096:400:de::11)
 by TYCPR01MB5597.jpnprd01.prod.outlook.com (2603:1096:400:40::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Mon, 21 Feb
 2022 08:14:48 +0000
Received: from TYYPR01MB7086.jpnprd01.prod.outlook.com
 ([fe80::176:c92c:a852:ed2]) by TYYPR01MB7086.jpnprd01.prod.outlook.com
 ([fe80::176:c92c:a852:ed2%4]) with mapi id 15.20.4995.027; Mon, 21 Feb 2022
 08:14:48 +0000
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Viresh Kumar <vireshk@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Laetitia MARIOTTINI <laetitia.mariottini@se.com>
Subject: RE: [PATCH 5/8] dma: dw: Avoid partial transfers
Thread-Topic: [PATCH 5/8] dma: dw: Avoid partial transfers
Thread-Index: AQHYJPMfNzaMXGg9ukOz8Sma94IPu6ycRUGAgAFkUmA=
Date:   Mon, 21 Feb 2022 08:14:47 +0000
Message-ID: <TYYPR01MB7086F412B035A09AED2037A9F53A9@TYYPR01MB7086.jpnprd01.prod.outlook.com>
References: <20220218181226.431098-1-miquel.raynal@bootlin.com>
 <20220218181226.431098-6-miquel.raynal@bootlin.com>
 <YhIcyyBp53LnMbjU@smile.fi.intel.com>
In-Reply-To: <YhIcyyBp53LnMbjU@smile.fi.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 751b8312-98c3-41c7-0fc6-08d9f5123a13
x-ms-traffictypediagnostic: TYCPR01MB5597:EE_
x-microsoft-antispam-prvs: <TYCPR01MB55978B11E8888C72A2864BE8F53A9@TYCPR01MB5597.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fBvl6v9rjnR9OOV5XJL3qwnnlUV7a8xJ8fShfkO5mHBWT59KKiTAQGXLX2UJTM4XCQD3tAaSbeAEB/0x1/b9RPyVKxFi9B56DuKArZr3shYL3B6oUge0ux04GpCRHiC49yLTbKYk/JlfPMyHOSCHQoCYbyVnWpsgISSLgcdkOfWHHdpSiz6mheFy4MDywSwddjJffRIbr8KdP4w/5XvDswkp7LJRy+rfezAmgGAHxE3WiDLe7UU1AQxAFHPANkTwqMla6Li2J5ePakU8jw6iz5nbd7o9i1Oy3zAyi41ridgnmSVUCt9ctSvv+PhRoVRgkUiZc4BtEUOF+7dFZwJOFZincsQiimI9t21UeGAwR6BRLrQZCZ5d2+n1psL5/mur055tFKV0MGKrpxVoi3A6cAibMlKCWETmwF5HUOfSAIX+qdfN4VMQE+bWwkl4uzgoyMpJGF7TofcZhjnndvEMcRHdrHWIOKfTPk0n2Oe/H5q+t+E2z0UUufypVMbvs2mzqA8z3bk8hX+qYTI0vWvLk/yW/PP2WQYnCg6u7U/v7+IJGjx/vUHIbvTlxFordxlBntGfCkqFtsJp7NiX1vISsAeQHJaNJ5yAYyIEsBVUIj3dJj4IXS9gLy5a5Gx/udvNYEb6o31C7wZ3G/40Dozf2MApF492O9mpiIYaWhYW1QF9PxjPCIlubFoq44740eUdPZa4aaEW/pFNMETlYQvG+w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB7086.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(55016003)(2906002)(26005)(186003)(71200400001)(83380400001)(52536014)(44832011)(8936002)(7416002)(9686003)(7696005)(6506007)(33656002)(53546011)(508600001)(38100700002)(38070700005)(86362001)(316002)(4326008)(5660300002)(54906003)(76116006)(110136005)(66476007)(66556008)(122000001)(66946007)(66446008)(8676002)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jBUf9CsntXZIJSOxwUk7+1YtlKt1pT5oWkHimm8BCcw6qp9gcJPsGblUGGa4?=
 =?us-ascii?Q?sJzZ4yyvQELd3yv1DUjKJwQ9pIuYF8HasZR0Z2Wp7wsc1U9gbatnSeZCKxcg?=
 =?us-ascii?Q?tVGv2DRgT9SWV7bbF9r+quc4L5IW9Y65+icsUwWGPb2TQsy4YfcW//uFN6wz?=
 =?us-ascii?Q?7xHVwVUI8UcL8wZ+7BXv2yMdap0nkUTHTsO9q2f4OfnLbIagZY5fxnBXFC3d?=
 =?us-ascii?Q?LI4eNvaTqigcupp0zClA0YLPXWDlPMMDTH88GO6lfW+z8ZIlxKHvsJ1fid6w?=
 =?us-ascii?Q?y100+c6/lkyq34Og5WspIbczD9V4akQxfUaL57mZBWxDR+JN5xtJS+QIj4fH?=
 =?us-ascii?Q?A/i9n0AOZzBLmV4L85i9uDOKsOV+9pMda24JVygHxcNjUolFyPxgvrhBsPnL?=
 =?us-ascii?Q?HhfheQBHhx/x/dfy+QHxJLU7RBrwyBVrSus7x7aiDOu7NJKmYuhYGJAr/xUE?=
 =?us-ascii?Q?czzTRn96eZFgq34a7WeeKeE4ACmZvGlVpxUkGp6Ry0pQxZ2tN8gqW6T6c46H?=
 =?us-ascii?Q?+3l4IeDCWcDC6ShuAnpFF9QSUTXflHqr+Ype2StefJXY2XDHAF7Lr2rxMHwe?=
 =?us-ascii?Q?C4ur9VrctScReNxeXavPQ5vf6GNBOjXn5HLR/0ptzTrSOGWfpZBwirmbaorK?=
 =?us-ascii?Q?YYGYGbnMcBaNq1oQXefohbiW3j5fPsWHNTXKjObMkT63odQv9F4nX/EoVKcg?=
 =?us-ascii?Q?aCs2ERruOcernSk8ApN0s0wPHkhrhbFzkJdfiaPYH5Vec8n3sNNVoQ+sTmEM?=
 =?us-ascii?Q?iCrFkjtNg3BqUNnlCEZJ2HmEZ5OiyaiBBHd9CpA3L1hKqiSRnSvo0xEO06Ly?=
 =?us-ascii?Q?DGil0hloH5J7nUYbEYMQD+qtaIR47BcWUxBKvoWQThx73p3jmYMMYQz6LbH3?=
 =?us-ascii?Q?ehQLhKgQ+gwkQUpHdLSYS1GG0po3aHl6eSdeMZaKCK/MTSprLdp5gBGTSmC1?=
 =?us-ascii?Q?NJitGx2LKV+1xhhT66ILEdcWVAEmxmHIsTp1PfRni5Y0u39o12HLF2Sa9QcP?=
 =?us-ascii?Q?ljPyF5RpkNlo7TGl+dxBgi4SBDqQZcWjyfwMYNCiXh8QK0/FE2c94wwEbHUd?=
 =?us-ascii?Q?zYxe6QScRaYthWkiImWNkfPZpZ1gFsxeRsF7YQxenKKURhlgknUGqleuT8n3?=
 =?us-ascii?Q?jn1NJZbC0uYpTI+M3wsyFKrEAewjh3JGIsRqHwQ05m/ZrhH6ryybYCIPr6jv?=
 =?us-ascii?Q?mw6+vxmPlqDvMfDFOWWR+JXmzUI7NI63UmRHf8xCaCoQkkZDTtvUmV5p9Lc7?=
 =?us-ascii?Q?HRYTiAviOttw4pSe50uTPSDi3uVT0HbtZh86hHCiwape8FYdWyhfmTw1p6Ix?=
 =?us-ascii?Q?qBSBpItOYMJSMXM238T/XHSqo0nPfYdTxFzMJ6ZFvs/yAJCYD7Fn/LzRTmLQ?=
 =?us-ascii?Q?uIUB1ow5jywDEeiPwMWauNZoCmz8yHl3ifdZ+B2XGONlrvnzBE4swgUAReko?=
 =?us-ascii?Q?4/jG37HPDf0AMlhW60j7kFCPvv9YFvWhpxgRc4ZOB/iQGDqnT9hHsqHuRmMG?=
 =?us-ascii?Q?9Ib8a4davSJaGbWZrUN2IY2I36zLT9iD5tNaRvDtDxEpvECgWgnMx08mrrSm?=
 =?us-ascii?Q?ewnrfJ/c5xXd16tpEWNBBOGEf5ODYwCKPd4bXsh+MHpX7K0NJQkFBqD/JRa7?=
 =?us-ascii?Q?Cbk+vPlFgpz6nT+MBdjpilJkKqglKned8YQxyDJBZWNPQblhfcy6yKj0y6x3?=
 =?us-ascii?Q?w5II+A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB7086.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 751b8312-98c3-41c7-0fc6-08d9f5123a13
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2022 08:14:48.1242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g0bi+qcKLp3wf6kuudfwjL5u77mz/jBQu0tmf0cowDvybNKSe0n6zr+lymkuNbdm8wzDhSH1BMJdLT6EjQ3id0DTlzDYgeiV6G4CGdQeTjE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5597
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Andy,

I wrote the patch a few years ago, but didn't get the time to upstream it.

I am not aware of a HW integration bug on the RZ/N1 device but can't rule i=
t out. I am struggling to see what kind of HW issue this could be as, iirc,=
 word accesses work fine when the size of the transfer is a multiple of the=
 MEM width.

I found the issue when testing DMA with the UART transferring different amo=
unts of data.

> > +		if (sconfig->dst_addr_width && sconfig->dst_addr_width <
> data_width)
> > +			data_width =3D sconfig->dst_addr_width;
>=20
> But here no check that you do it for explicitly peripheral to memory, so
> this
> will affect memory to peripheral transfers as well.
No, this should be ok as this change is within:
	case DMA_DEV_TO_MEM:

BR
Phil

> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: 20 February 2022 10:50
> To: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Viresh Kumar <vireshk@kernel.org>; Vinod Koul <vkoul@kernel.org>;
> Geert Uytterhoeven <geert+renesas@glider.be>; Magnus Damm
> <magnus.damm@gmail.com>; Michael Turquette <mturquette@baylibre.com>;
> Stephen Boyd <sboyd@kernel.org>; Rob Herring <robh+dt@kernel.org>;
> devicetree@vger.kernel.org; dmaengine@vger.kernel.org; linux-renesas-
> soc@vger.kernel.org; linux-clk@vger.kernel.org; Thomas Petazzoni
> <thomas.petazzoni@bootlin.com>; Milan Stevanovic
> <milan.stevanovic@se.com>; Jimmy Lalande <jimmy.lalande@se.com>; Laetitia
> MARIOTTINI <laetitia.mariottini@se.com>; Phil Edworthy
> <phil.edworthy@renesas.com>
> Subject: Re: [PATCH 5/8] dma: dw: Avoid partial transfers
>=20
> On Fri, Feb 18, 2022 at 07:12:23PM +0100, Miquel Raynal wrote:
> > From: Phil Edworthy <phil.edworthy@renesas.com>
> >
> > Pausing a partial transfer only causes data to be written to mem that i=
s
> > a multiple of the memory width setting.
> >
> > However, when a DMA client driver finishes DMA early, e.g. due to UART
> > char timeout interrupt, all data read from the DEV must be written to
> MEM.
> >
> > Therefore, allow the slave to limit the memory width to ensure all data
> > read from the DEV is written to MEM when DMA is paused.
>=20
> Is this a fix?
> What happens to the data if you don't do this?
> As far as I understood the Synopsys DesignWare specification the DMA
> controller
> is capable of flushing FIFO in that case on byte-by-byte basis. Do you
> have an
> HW integration bug?
>=20
> TL;DR: tell us more about this.
>=20
> ...
>=20
> > +		if (sconfig->dst_addr_width && sconfig->dst_addr_width <
> data_width)
> > +			data_width =3D sconfig->dst_addr_width;
>=20
> But here no check that you do it for explicitly peripheral to memory, so
> this
> will affect memory to peripheral transfers as well.
>=20
>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20

