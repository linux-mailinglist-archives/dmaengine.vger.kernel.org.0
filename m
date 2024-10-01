Return-Path: <dmaengine+bounces-3248-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E17B698B5F1
	for <lists+dmaengine@lfdr.de>; Tue,  1 Oct 2024 09:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E97E2815EF
	for <lists+dmaengine@lfdr.de>; Tue,  1 Oct 2024 07:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C033A1BD4F6;
	Tue,  1 Oct 2024 07:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="GFEMx4XU"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011025.outbound.protection.outlook.com [52.101.125.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674EA1BD02E;
	Tue,  1 Oct 2024 07:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727768655; cv=fail; b=jusxmbNODv2zh6tL2Va6bvsb5BvlDT5sID335JsOPocTCJE+ERjOJWvFyCxkFh293pBm+iIAfZHQAV7qCtg6lAFIOu6FgpSd+phSwgZfB0BR20E4R6WNd12Bf1e49kU8hg607siZKerNKURB8GeJUYxj+kjqWZvkjVvTc5BqtAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727768655; c=relaxed/simple;
	bh=VWtGxJcUk8taRxitMYgckVpJ1FG9lhx1wzNJPVy+oNQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pZ4OKx5yidjq4jLuIFeqDXfr2QIihVvperYvFXhVqXfkq/8U0d/9qhpyRstboZsekX7e3vjJ38muXBi8msGGDjdj1XHp3PvAQwKsJktirQitBpvPhyCDB8NLet3tw1Ff1AcE5YKJUqfOhvVlxA1ve9ll9zrvKfgu4z14HfU6uCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=GFEMx4XU; arc=fail smtp.client-ip=52.101.125.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uBhiX7khftM9k6/lUEuMA8xbjeqlfT7a2nTWAXh4kzT4hlyHXZn8zGQ6/UCjizIROiKq5h4mJMQBpF0nla/6Lh2RFoKyPBXhHWatkmCe+nEy8NhhD0qOj8XphwGA7TYCfnLavDTbO5ZjPKhQ9xwM7T5+9wLymDIxTmdTrY5TCfiGVc7pb2k2NZGiDyVdNSC97t9TdoWP3wZlnG0Q003DiMy4Glw0NLNlvi+jc/P9hXVgXbKYhmY7E/XLMFO4WDVSM/r48nU6CHCwCdcfJC806b2+LEwbncF30E/Tp9ww8boc9INlpi1uh8B2W687UFy4CdlAMjY2+PgDYl4rc4nxEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VWtGxJcUk8taRxitMYgckVpJ1FG9lhx1wzNJPVy+oNQ=;
 b=Yie068AcEulCq76Mu8uBn7VW++10cZMvkuTwl7E9wnjj//8FfXKy1PEUC+rG4omjh4mK7BJTBJCtyNk3B56IWEQPSKoZjFc0BHpX/LqQjpA52sf0f/o13krKQpN6sVVU+5zOlcNyNAtr5dZhoRNl6z+3n+9qQ9Zef/a0MlwiN12Q98P2KiNmy927Gw57FwxF2S69Idh3OW1VpY9VPPpgFmLS1ysKb535fHct6B+S4Q0vxWUMgOwIEWL0gyBn2VpnoQ7NuzXKlamMxrvcoe4fRWXSWCsDRB0HoxcyrtJdogPl3PDwNc+MGMCP1vpVEsVSxZ1zM/u8+i9PQ0EytA6JpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VWtGxJcUk8taRxitMYgckVpJ1FG9lhx1wzNJPVy+oNQ=;
 b=GFEMx4XU/vUFv1hpQIWQPn+M0Lcy1N1m2eXHN10weqiMizwt95DC0Xp0t5EcGQfbGv0zIzuZ5V9nZ+Lis9qkQeg+U3lT9q97DEopuXpF8EGfBjvCJcPbA0DCJQCpcgKPb5rkrG0WiSriNST/0blpceBHHzJZRaOXh6hEiKs2XAY=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYYPR01MB12676.jpnprd01.prod.outlook.com (2603:1096:405:15f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 07:44:10 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%5]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 07:44:01 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Geert Uytterhoeven
	<geert@linux-m68k.org>
CC: "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH 2/3] dt-bindings: dma: rz-dmac: Document RZ/A1L SoC
Thread-Topic: [PATCH 2/3] dt-bindings: dma: rz-dmac: Document RZ/A1L SoC
Thread-Index: AQHbE0luiOXfPR9hj0+3/qlabdUQ9bJwcWsAgABFS4CAAMw2QA==
Date: Tue, 1 Oct 2024 07:44:01 +0000
Message-ID:
 <TY3PR01MB11346FB3B2DED61B5C1105E6486772@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20240930145955.4248-1-wsa+renesas@sang-engineering.com>
 <20240930145955.4248-3-wsa+renesas@sang-engineering.com>
 <CAMuHMdWa7QXU+Ka6FipF6sbcn=UOnVtYa-+an4F7thprNt6ALQ@mail.gmail.com>
 <Zvr7Y6PxV9CqcbHF@shikoro>
In-Reply-To: <Zvr7Y6PxV9CqcbHF@shikoro>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYYPR01MB12676:EE_
x-ms-office365-filtering-correlation-id: 83e3c242-7120-4808-66dd-08dce1ecd116
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?EtC4iiNw2CVnOz2SnAZwEzCzAQ2UFK2oV4iUdiD0mUhA2BxCjx1lir7UiT06?=
 =?us-ascii?Q?gf0JEMjtZ1OOmVbMXfTQ0yV+A6kl09/RTJ9cLX4HBVN77EooRKLH2UshfRm1?=
 =?us-ascii?Q?6MPZ5OhubMxXsVYoU+fn2J12xa4mL3hdhGy7CaxE4e8+3CtmkFW1kW3Y6wxN?=
 =?us-ascii?Q?ysw3hVTNOgSTm6twz81BgF+P9QCvPHI7/OwWU7hJq/DyjVL7eBzuX3p6UGbd?=
 =?us-ascii?Q?rjP7UUrcXChjtaST+uaCFZTeOkVf7ZjSsoz3P+CiT++V/FXA9/zZGytbhN/u?=
 =?us-ascii?Q?9kmw3IbYOp4O5LdrMXCKYfKiLcp7Eze4CUbrUmOeAaJjrN4W+im9kbDcsqea?=
 =?us-ascii?Q?t2IFf84yLfRolWVt1kSh2explgX+HpuD3Czj/FqygirU9FTNOQCA2oVPGF9c?=
 =?us-ascii?Q?bLGgnTrOZvXsrW7m3zd7/DxwUf0z1a2cjS/qUIIiySgRVBkRidZuYFMZ3Kp8?=
 =?us-ascii?Q?v4tOfkxfhY7p4I/bsPdmjaQ0bgcv6ldp2UTfxjAtYofHA0YZuitSn+nrBeYo?=
 =?us-ascii?Q?H9moSOCbt59ERxs3Yk+moKIzZzUabWQ/gdadi7jI1fJQGTTElLCV6w5e0Yl/?=
 =?us-ascii?Q?Wr8k87f7f4ZNUaVn+OJwUO/7MRYSYA2OtO1klY2lHIcY9HSPrCWqMGWoKtDm?=
 =?us-ascii?Q?ZJBpYA6bYdarYu3guSaaNQ3So+6A+jzBwO+PZaVvXhNWL/WIVrXv+CpIXye6?=
 =?us-ascii?Q?X+g6P/ovoZn/rK7reXaW/H1+ERi3I0E5lJv+64EidpKfDk2sG52zjf881ZB8?=
 =?us-ascii?Q?NcJc6ZvJHuNCtQ4hMVAeZ+pwy6tQVwaN4z0xijtOAAaTNBE3LeM5Vq8W55Zf?=
 =?us-ascii?Q?L8GU+1vfXNXZ3Xm1v1CeRMnRSx5sormjNFw+uwpR1K5Mt6LR8fTNAnqegIFk?=
 =?us-ascii?Q?3KFWnIhFwEhhB5gYeLGVhOjLoCW4GjPA7lDx1Q/Kiy5cnKF3MavAgPmU5m2I?=
 =?us-ascii?Q?Pfdpfufbzv2/rsbZzCqosKcQGUtMl3bjYfvOfx0KKaDvcsi2EZ8+aCeSyCrY?=
 =?us-ascii?Q?Cqw+GynID2q0Xx5uc0WMgfLxzINa9/JH+kkyeAEzVeOSu0FSvKd8lrXWotM7?=
 =?us-ascii?Q?1ByauZp+Oil6dwoMcFHrU0QRlbWWFpwqCpmViwLfzMoQW3tky8OGiCBUQVRJ?=
 =?us-ascii?Q?ksP/vzQDrqh219mivmK67hXI0te83v3LT7t3+lN0Jlqvx9S3tlio8lM8C8ld?=
 =?us-ascii?Q?7y2bRNFtoT/ReUYGDz+QnZNgN3/8f3q9gALwG2wGQGeBCdq+b1FCB4TO++Iw?=
 =?us-ascii?Q?elg4uvI+qmGXeoMqp84fIOjt4fAC3/TASJF3o8N1R0C5LwhK6Ep9lEvGf8lT?=
 =?us-ascii?Q?KhOdHuwo7lBocjDbxm2Np61IWj59Cq8w07Dvj0E4a6/MKQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?TQJygcQma9UfgkABANoNwF4d/Rkg3qUFbtDHHdFnTLVICDisfHoNa7DksFa1?=
 =?us-ascii?Q?fDEftmSMZPFqCbMw7Em7G7MgpUXEldfL3Yg00YZC99BtcoSs1KfrfnZvgOrx?=
 =?us-ascii?Q?OvQNsCqWHYgW+rm/j/0LJT/DHrK6Y03Yqjbb/sRdql/aP5V5bALxVP0rqR8J?=
 =?us-ascii?Q?ePxCFl/p4cT7sbYa7c9Az6Isg8SWY1YL8LM1roICg0RdehU7QWBQNEr+jtTc?=
 =?us-ascii?Q?y1cx95w1y0MzerHgcdIM1wLUwrUMpSrz1kQX097F90hdw+GIYOUC8ruQbgZX?=
 =?us-ascii?Q?FDIBuBWMzwqxYhJ2VjXSPRTNqb4WQIItz7ydRGe071wkysDowwPFf+lmUW6K?=
 =?us-ascii?Q?6nwuf/6yELB3TFmOxRW//jJpvytlsez8vZwqQTZjwGt9ugfd5u6LWI1BZ7Sq?=
 =?us-ascii?Q?Nv9P2VZLFyMy1FpTw4TVqRj59F8mcIBmUHqHU/WEXei5NOe+VGCSDgvAe5ag?=
 =?us-ascii?Q?70iIiCskcnU6EpR97DSNUYCkzIz1kLJGs6p6RJ1AIf12CfX/JosC9cbg2iEO?=
 =?us-ascii?Q?/ODeDBfToQgVvhpuL8jMZBhJstuxESkGCT4f8JECSBPqcMMgmyxw5AVOn5Kg?=
 =?us-ascii?Q?rnLguEVQ9wiHxP9vD89S2rJDOMoVo1w1qrGkAogW1xAOtHOCQA2vb3dLuz0f?=
 =?us-ascii?Q?9iidxmgZKV4S2H5FWD+yeoZRKkxxw79SB1znCb5p3KzDM+n5eq3MRJUQiYC0?=
 =?us-ascii?Q?lRh5RB85WUjbZenfXi98Ak/5s6OXRnUg9FsbO2BQSrx/hAgyxmr36hiT8Q2q?=
 =?us-ascii?Q?pKA7XKJIDFygWcVfdlpSj7cZOfZiahaMSQMzyGF6szd/UaoInF31cBpCRuV8?=
 =?us-ascii?Q?C+F6QBa1v5IDBLFptC/1KNIu490JkeoroUFC1yuisfTOiWTPZOF3eB5NZDxN?=
 =?us-ascii?Q?8MjBLIprtlDvD8v+QyLItK9LS7NrGGjnwqVU4T91wDfan2nrtnpAR2UJY9yf?=
 =?us-ascii?Q?FzUzHo/7fS3StlH51Rp2mxvGtpam1gxgO0x97WiY5ENtAhLNkZNOM4pIQBU6?=
 =?us-ascii?Q?6mN5h7XQfZ4Q2QOBlQc453/LRSs8pKypRDX5/DobXI5Rmbo9YqsBT//iHrgx?=
 =?us-ascii?Q?KTC+oDXiAvAlurkIZu7Wc3Cta8hBqAqyDLBxgG1w3iTjFGQfo+gd7qvCBuws?=
 =?us-ascii?Q?IfVEhfNAVbNtBZa0Q5EIgZS74vTbBcdIa646xhj3Cuq3lcCwq/WrlBUHDJkK?=
 =?us-ascii?Q?EcT61zpHwZDGZtppUvqXb023+kCZJ6LS741OC9kEnAa5q34m2dhLSJcfufyy?=
 =?us-ascii?Q?fA1I0JZfisyAgRiJCjp+mKhKIiPTqstEG1XIIzZ5Yth9SurXNsmip9qsgMTw?=
 =?us-ascii?Q?ecf0UcGPckTDExHd+8U2FEgjQ+NZ+3WhSTobJPs5aqsZN7MR92D0Sg4Px1ks?=
 =?us-ascii?Q?CO68qRyBKW3Hh8bcBU5cec5LzU9Bg2PsTcU7eCJFpPkc2gWaJdvTnPDjOaix?=
 =?us-ascii?Q?rtT7aaT+W4u7RpxxBlXgFo64HEw72lE3vSBCbZvN0LqKnmasqoiSdp2TH1dS?=
 =?us-ascii?Q?+muNqadra9aVv0PwqkUArKLU2Gy8Z0QpxCUs0ymTxma5M7BAYIwuf0wn2Oww?=
 =?us-ascii?Q?EUzH1NXuCV8CkArBTNsgLwDQFBBOnHeY9YXxGizMCZ9z4o0xC4FmM1vgxbCE?=
 =?us-ascii?Q?sw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83e3c242-7120-4808-66dd-08dce1ecd116
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2024 07:44:01.5893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XcM2TzA0mURSuxn/0CQAsKLyWA3cUVpc2cRQ9K/JCgajELKQThHKa5UDNx1wh41SkrnUqXE/ciAKqzU6X1Rpmtv/XGGrzeK3PdBms+x1Ruk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB12676

Hi Wolfram,

> -----Original Message-----
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Sent: Monday, September 30, 2024 8:26 PM
> Subject: Re: [PATCH 2/3] dt-bindings: dma: rz-dmac: Document RZ/A1L SoC
>=20
>=20
> > > Document the Renesas RZ/A1L DMAC block. This one does not require clo=
cks
> >
> > RZ/A1H
>=20
> Argh, I managed to mix it up again. Thanks!
>=20
> > > -title: Renesas RZ/{G2L,G2UL,V2L} DMA Controller
> > > +title: Renesas RZ/{A1L,G2L,G2UL,V2L} DMA Controller
>=20
> I'd vote for your suggestion. Biju?

This list is going to grow like RZ/A1, RZ/A2, RZ/G2L, RZ/G2LC, RZ/G2UL, RZ/=
V2L,
RZ/Five, RZ/G3 devices, RZ/V2H and future generation SoCs.

So maybe some thing generic should fit here.

On RZ family, majority of devices, except RZ/G1 and RZ/G2{H,M,N,E} uses thi=
s DMA.

Maybe we can mention this as "RZ DMA controller" and on commit message ment=
ion about
"RZ/G1 and RZ/G2{H,M,N,E} devices".

Cheers,
Biju


