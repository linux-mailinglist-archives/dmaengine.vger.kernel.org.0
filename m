Return-Path: <dmaengine+bounces-5003-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E08A98BC3
	for <lists+dmaengine@lfdr.de>; Wed, 23 Apr 2025 15:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5809F1885B5D
	for <lists+dmaengine@lfdr.de>; Wed, 23 Apr 2025 13:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D788C1A316A;
	Wed, 23 Apr 2025 13:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="pQIC/OIv"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010021.outbound.protection.outlook.com [52.101.228.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B497315AF6;
	Wed, 23 Apr 2025 13:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745416015; cv=fail; b=bGWrGoxn95ftGG8LUEYcKjTBA9Utla2ElPADS4k9IlGBdWOyK5Ni/gioKMMWYHMB6upYHzeMNqiTDasXM3KyQSNIem99VXnf5PHpbdhLe85V/p2WFKaMgS1JnU1GyUP6LLAq+vvc0fV/KnCjoI3U4Enix6gKjngWDQGKZKi05+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745416015; c=relaxed/simple;
	bh=xWo8cjZhR6nXn1gG2/Mb98xnl2sQG/XOm7VnwQWW/Vs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nWCHiD9MoBphuaPe9oCbfZSljJxbNBBR/UJKH0gAFEO+sWhGWHMEpxW6Ral2cVGBq4ND3sH7rwC9WMvSKxMAjgUWHDfHv/eZGjeTzcO9CyfWwlRvuAYL54S5drANZ8ulpD+0aBrOnrGxnS+p2FL1yRMVcg4Z6eiLOoKn6jR3KTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=pQIC/OIv; arc=fail smtp.client-ip=52.101.228.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t3IUYIbWHvT+C4/2Njx10nMsUseML696ncgIOC1q/0TksQgC5/dOd9MXviHJDTfUhUTZDXqJ5dKSJHFfKXXjqyvpeMrP+dAxtosewYvinzzaFuVknVKHWWCxxXLKtbZaAJFNfV12qcM8IFbYRyl8c0e3cmfiq0RY17h/kwShRyer2sZrHVbF1wlBoPhAB3nhAIsPOrj6EEvOxPIu3uwGhlgoc2W/5OGZwVZ7dtlfOdHxi05hHhuHZr0PgcNThNAdPVxmmIjVFvKpt4eBEWGtDTXputTwh8BDVAJvjH1vv0tKE3yIionWLW2H/fVOWfpFMUqq6r92AEMAxwfGH8y5sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H3XwtGHZB61MAi9vegwJJsObRFCCF6ZEKpOkdZwqcfE=;
 b=T/+agZtKNEnXKZXhuylQJWWYQ1w8kOA81rwzD18ZbqHWNdDgFYRae+DVE0l/Vf3LMR6XKN3QoARzL5OKxCKNpqNIZmX8twtDND+bBmxg3weoKzhC3gK07Qbz7X88nFyK8hIgQyYqMUJcwVFZVwLh30tWf/T6euxBt4JsaU/XZVGKxVrm1NIzLnTdMGZvO1Ma3WxmhmBDM9wmFj1TUmmFS6ZEYt/vdGY0T3gCgLo6+NQDz00c+QnPlfYTDx+SA+zqNfB8jaZfwiuTGEIbiNxTjDysfNud97Pw9NFe5yX+hxcxrER0YBxfO7/FuyBgEOGo+qK0oGk787nh2yqXBLxRLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3XwtGHZB61MAi9vegwJJsObRFCCF6ZEKpOkdZwqcfE=;
 b=pQIC/OIvCklA8x+okTWKmCMHhnBpFmT0O693NRLu8zqwiQplm1KjeTzbflRZx029/hJsVyu7fNJVjyCobfKObb5Xgk4/mjdTBFTiIs0VD2EmHi+8eiVE8ez9oLMEcxf2aZJYV2oDB2yDxVrbQtfuK54pa90bJfafOlxuDS7nGkk=
Received: from TYCSPRMB0009.jpnprd01.prod.outlook.com (2603:1096:400:18f::5)
 by TYAPR01MB5449.jpnprd01.prod.outlook.com (2603:1096:404:8038::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Wed, 23 Apr
 2025 13:46:46 +0000
Received: from TYCSPRMB0009.jpnprd01.prod.outlook.com
 ([fe80::8f8f:14d6:a759:4c66]) by TYCSPRMB0009.jpnprd01.prod.outlook.com
 ([fe80::8f8f:14d6:a759:4c66%6]) with mapi id 15.20.8655.033; Wed, 23 Apr 2025
 13:46:46 +0000
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: Vinod Koul <vkoul@kernel.org>
CC: Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm
	<magnus.damm@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	=?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>, Biju Das
	<biju.das.jz@bp.renesas.com>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "tglx@linutronix.de"
	<tglx@linutronix.de>
Subject: RE: [PATCH v6 5/6] dmaengine: sh: rz-dmac: Add RZ/V2H(P) support
Thread-Topic: [PATCH v6 5/6] dmaengine: sh: rz-dmac: Add RZ/V2H(P) support
Thread-Index: AQHbs62Wf/Y/Cx7CZEqSG0MzEkw3v7OxO6CAgAADv0A=
Date: Wed, 23 Apr 2025 13:46:46 +0000
Message-ID:
 <TYCSPRMB000932621B754A38F0FCBF8CC2BA2@TYCSPRMB0009.jpnprd01.prod.outlook.com>
References: <20250422173937.3722875-1-fabrizio.castro.jz@renesas.com>
 <20250422173937.3722875-6-fabrizio.castro.jz@renesas.com>
 <aAjnc+AxmAn9fxSs@vaman>
In-Reply-To: <aAjnc+AxmAn9fxSs@vaman>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCSPRMB0009:EE_|TYAPR01MB5449:EE_
x-ms-office365-filtering-correlation-id: a761737c-52dd-4eaf-288f-08dd826d4a01
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?h7KZY9pdDd0zKj6Cxfqgy2nd7HJYGS4ZIr2thWbtiqXNP/QnKMFsNuuZDI?=
 =?iso-8859-1?Q?Kzl3Zo0P7ImZOoMVqCxhOr2F7PS3JSeozD+wC/6671h+EkThB97GTD1/BI?=
 =?iso-8859-1?Q?bUSjFdzYYuGEIdCHJeGcnzDQtTfMgd0uVHNnc3z6BXIvgZxKdIErmvfp2h?=
 =?iso-8859-1?Q?z7wh9xVaXwwbSnELAuA+N9jFMPbFI4kVl3kCggNnIabEYqyuAO9M8vr3wF?=
 =?iso-8859-1?Q?Q7SL/C0R4/2f2L8e1fFQaIm8zjvED1deFfSrz/My5FZ6Sx3Smtj8HP1AHU?=
 =?iso-8859-1?Q?U23QnPhQkOkRLmUrLgY7Z1vQ1yEzweoxl1TOzL3HrtxpE09932/djTjIAx?=
 =?iso-8859-1?Q?fdI0df7PXwXnh4m/SWtk5rT8jbJlXEz77TT1DzjCRfLyJxVxB8EjfOkgpB?=
 =?iso-8859-1?Q?bskFZToIjVteDpI6+9lbxKlulISR4saa9404MvPn5Mz+8N7sagzPc0L1ac?=
 =?iso-8859-1?Q?DwIUuIG1vFJ/X0D+znmgtcFXuAsU77gdJ9cTqb6BWgJGZLgwsEYpf5HnWc?=
 =?iso-8859-1?Q?Y8Ht1MfQ0q658ral9HGoOaZqeauAjr81smO3aM1yqHUpUf/bWZkKcLrfX4?=
 =?iso-8859-1?Q?Mj0ji0rAIa8EZ/rMmveQ52CBtkYzRItpCV5YABOXv6uUMbzI0d4RKduRvk?=
 =?iso-8859-1?Q?91dacqIxlgtFtDXbo5FAs7vhJu8QtW2Rci1hTzywOQFW0OCLbFGp6BngSz?=
 =?iso-8859-1?Q?5QfOhv7azh9jfTeWQ0D/xw4THLIKMNibO7LBH080CoKUh6RgUm9zMYf24V?=
 =?iso-8859-1?Q?45B80ZIOiDit57Xpk4UzMScq4QwFAHiqUR1bIbLboZ9b0Ube0wgBPsL8v8?=
 =?iso-8859-1?Q?CtcYi2QydF6ub98dWI6lBz6mQCwqAMSLS9JAVDnd9MyF1N+KBGbQYOTe7e?=
 =?iso-8859-1?Q?OZhR92XzgFPQ9nQ3zDefj08EJP1fCSDZe8FORPLowGYzxoQD1w3dhHGr3d?=
 =?iso-8859-1?Q?byZMeOPrNaZ9PUhMi4+M79501qVBQSMsq6i7BmMLfAxichHZZcYuSxcz1U?=
 =?iso-8859-1?Q?ICveLY3VQazV56d0J7L3+5l7jcd/Ea8JUkzbPNVrDuWdollhCgQXJkf1GH?=
 =?iso-8859-1?Q?ywPHZ1Z0bgDjBVGsky7KcOk+nkZ71cJQVCMbDPCMKmljYvf86fF/VqNTvi?=
 =?iso-8859-1?Q?wn3IScd4RHUIRRbGvjxpBJ3fteBkOEtW6jzL0/2U+wgoPxkt3dkqTN02Mr?=
 =?iso-8859-1?Q?ev57kusxGs/Iz21LLvhEoll5kf0fEAEijSzzSX3l0A2wf3l/i1YXHOrh+U?=
 =?iso-8859-1?Q?wRPnTAImLsUiSnYhGGuu1rMvekiKnHbaaEJpwGzBYJZdI/pIzzvwENajyw?=
 =?iso-8859-1?Q?R9xw1FNOlOtipxPAx9h6QTKbloJdVY4MKGWKjarURFuuPPCSQ5FDKOPKKJ?=
 =?iso-8859-1?Q?m3E1gSWqJ47/And3SqIbaVk7n94bHYhBy+Ug99biLW0Eh8wi/Mj1nmVBfF?=
 =?iso-8859-1?Q?NJ/MY2/O8v59dNluZoARuq1PyWYf4lXd/i4KcUQL9+pjVlOgYECpOY6abf?=
 =?iso-8859-1?Q?DqemAC87gOLdMtL65tprEbWG33eropxuEgiiS7aHylRso+8QDjkAwh2nEA?=
 =?iso-8859-1?Q?tutEdCw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCSPRMB0009.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?rRWk5HQxPcmY5rToJ+8HB1iCfmSikGNERMYGBWvqQoEGkHbVCULd+fhOHp?=
 =?iso-8859-1?Q?8fUlAoUfrKj7eBUk6gzFjsi+meAm9vIuJTBt9cLISGJxDdrCDPDRQ3xMtC?=
 =?iso-8859-1?Q?3OLx6/qtxBpbY9Ct1L0g8koXUs5QJnxUb1kVL+mdCT1TcyzGDFXPnJnr1m?=
 =?iso-8859-1?Q?I0DFlhzfzrLn+xb2DdNMqibIDOlPKmzWAFgD5Ad8YvLlOa0LDZccyf8tq6?=
 =?iso-8859-1?Q?5vqQJYsomQAPCmg28GZ7n3yrrOAOQDV9PuczdilLwVFmpbJL43i2hLD7fo?=
 =?iso-8859-1?Q?alSH0Kv7XhpU1Mx6B+HWH7NiFpwPhEvh1ZvYO/AArm+Z//zxhj/E8+g5ha?=
 =?iso-8859-1?Q?3+Avo3MFYVyf3E9IHk+wMJ5jAR1Ehh38XP+qrQ5IFuPf8kxC/g0LEPJ8nm?=
 =?iso-8859-1?Q?/vCUQqs4v+3D5MN0OkP+HQm0EF4VOB4mnHRTd9SFcVDFjH4LJft8IqXzL7?=
 =?iso-8859-1?Q?+SJvG0WHaPEwh4ZcIMqhCLMndhabNHraEj61DUljaRrmiqq5hT7peHaC5X?=
 =?iso-8859-1?Q?g6THLMSJTHifV/ERugL/mSMLMN+e63076iMRZ7uiIvfdIU9HwoidRjCT7L?=
 =?iso-8859-1?Q?OyiO9ltMJgrHHYQRFf1EToLtSr2V6O6JIGIq6FqucMGp59ZzerhsL546+V?=
 =?iso-8859-1?Q?cln5ftQpLFUTiaMhTqt03VdW0whcHc9pIiwpNXeTXxzTEzJUOTimg2xygG?=
 =?iso-8859-1?Q?I2/p0A5QFvwMcjhsMbmKl7YPinZmId8JGO2i0niiSPO+FsSxgHVClvGi2n?=
 =?iso-8859-1?Q?/5Ym28x6s2fgNBZW6mNz0wdJl1CWcUlp593SApgGVWXwb5Mp1LZT90hHMz?=
 =?iso-8859-1?Q?6NL8HsAm5mepNKIpCXkOSzlYCBOTBYO+8jH0zyWsBBG1R2E6D5pMOvFvOT?=
 =?iso-8859-1?Q?hw8XnbRYSVAy7629Zrbd9bLoCmmfAUZJgYWOvRIX9shZxlp+KRW9zRFt4Y?=
 =?iso-8859-1?Q?Gn/L0QRYOZg1EPTRnDESP8t5RSne7nmtA/9ryfzhNuF9yt/z8FmBZExDYK?=
 =?iso-8859-1?Q?ijHSjAT/tagKzqY3bfICxs9N5/x9O9h/NGe1tOLnortr8bFrYWiwYxTAX7?=
 =?iso-8859-1?Q?TJRBT/vEqgmfw6fNCI1RSxCA1dN3S6KPiQMKpx1xob4KvKiE1pn6y4CxBz?=
 =?iso-8859-1?Q?f1EyXZBSTHPeYxNfwcyTwjPXLPK6hipWA8x2BG762yxH1/y2RmBLDhC6ll?=
 =?iso-8859-1?Q?ZVkEnzpijMYI2+M0IocaKBywvx8LQlDH3PaTHGx1YpO02cPsW8g7DbWqi+?=
 =?iso-8859-1?Q?+IqPL4N9fl2Gqx6lXJ0rLO6vEA698vZ57XvMqtcRyEdgFbC8J9RcQqEDC7?=
 =?iso-8859-1?Q?hY+dEJlqaKfVWTIZ7318+xUFFIDhdiyiTExlvMMOl1n3t9l2iauMek8rep?=
 =?iso-8859-1?Q?A5r/C5j7eOQOrtj3q500hPh+BATBe9kiD/BJRp5ilfIjVNH1fCVZ/+cDws?=
 =?iso-8859-1?Q?4AsK4p5aYLlw5DNH/5iKGqSf9lj6sdcCID7Tdeddl2yWwE/H2z4ZzyqQl1?=
 =?iso-8859-1?Q?vMpmcHDE4jJgtcjhqzddnAEv2TV1Q8d20P6i9CZxHGABDHY2yq/Cz0YpAy?=
 =?iso-8859-1?Q?QCsPJNFSzuR2mxOb7IQJDelUFjvGSbSFYaCnM+j1Kt6HjZq25tdclGhvsK?=
 =?iso-8859-1?Q?iUvcftP0tqGX/BK1nmbGAB7JeWkN3g0+OXvqqSA9RWzS9AQv4oHo7SZw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCSPRMB0009.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a761737c-52dd-4eaf-288f-08dd826d4a01
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2025 13:46:46.0891
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aFKk7YGbN7f0onrdXEIgyq/bTrFN5IuZ2CRBYVBSkPc0Tmqna/RPp7nDJ4IwQN48ml1z4miKhfr3PU7QmcCdnW7JC+qrIVIpnS2KbI+mcEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5449

Hi Vinod,

Thanks for your feedback!

> From: Vinod Koul <vkoul@kernel.org>
> Sent: 23 April 2025 14:13
> Subject: Re: [PATCH v6 5/6] dmaengine: sh: rz-dmac: Add RZ/V2H(P) support
>=20
> On 22-04-25, 18:39, Fabrizio Castro wrote:
> > The DMAC IP found on the Renesas RZ/V2H(P) family of SoCs is
> > similar to the version found on the Renesas RZ/G2L family of
> > SoCs, but there are some differences:
> > * It only uses one register area
> > * It only uses one clock
> > * It only uses one reset
> > * Instead of using MID/IRD it uses REQ No
> > * It is connected to the Interrupt Control Unit (ICU)
> > * On the RZ/G2L there is only 1 DMAC, on the RZ/V2H(P) there are 5
> >
> > Add specific support for the Renesas RZ/V2H(P) family of SoC by
> > tackling the aforementioned differences.
> >
> > Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> > Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > v5->v6:
> > * Collected tags.
> > v4->v5:
> > * Reused RZ/G2L cell specification (with REQ No in place of MID/RID).
> > * Dropped ACK No.
> > * Removed mid_rid/req_no/ack_no union and reused mid_rid for REQ No.
> > * Other small improvements.
> > v3->v4:
> > * Fixed an issue with mid_rid/req_no/ack_no initialization
> > v2->v3:
> > * Dropped change to Kconfig.
> > * Replaced rz_dmac_type with has_icu flag.
> > * Put req_no and ack_no in an anonymous struct, nested under an
> >   anonymous union with mid_rid.
> > * Dropped data field of_rz_dmac_match[], and added logic to determine
> >   value of has_icu flag from DT parsing.
> > v1->v2:
> > * Switched to new macros for minimum values.
> > ---
> >  drivers/dma/sh/rz-dmac.c | 81 ++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 74 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> > index d7a4ce28040b..1f687b08d6b8 100644
> > --- a/drivers/dma/sh/rz-dmac.c
> > +++ b/drivers/dma/sh/rz-dmac.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/dmaengine.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/iopoll.h>
> > +#include <linux/irqchip/irq-renesas-rzv2h.h>
>=20
> This does not exist for me or in the patches that was sent to me. I have
> dropped this series due to build failure after picking up dmaengine
> patches
>=20
> drivers/dma/sh/rz-dmac.c:17:10: fatal error: linux/irqchip/irq-renesas-rz=
v2h.h: No such file or
> directory

Sorry about that.

This DMA to work needs access to some ICU features, which are part of this =
series,
however somehow I didn't send you those patches. Apologies.

I'll send a new version of this series shortly (because there are some mino=
r
improvements to the dt-bindings that I would like to make, to address the l=
ast
comments from Geert. It should all be good to go after that as everything h=
as
been reviewed by the relevant maintainers already), and I'll make sure to s=
end
the whole series to you.

I am assuming you'll also be taking the ICU related changes as suggested by
Thomas:
https://lore.kernel.org/linux-renesas-soc/87a5ajk7hr.ffs@tglx/

Thanks!

Cheers,
Fab

>=20
> --
> ~Vinod

