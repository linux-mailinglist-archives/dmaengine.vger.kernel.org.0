Return-Path: <dmaengine+bounces-6405-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F00B1B45DC2
	for <lists+dmaengine@lfdr.de>; Fri,  5 Sep 2025 18:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E05F1C83000
	for <lists+dmaengine@lfdr.de>; Fri,  5 Sep 2025 16:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9B023BF91;
	Fri,  5 Sep 2025 16:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="KUKtnD87"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010037.outbound.protection.outlook.com [52.101.229.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DF81C68F;
	Fri,  5 Sep 2025 16:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757089043; cv=fail; b=jAsY2i1SOoZZzTeD0MmH+gskIZnGShtXyJo3Bb1XW1w6n5FEtfBE4rtZoIERS9yyhNAjKG+jDwWMcYVVHomjP1qEYOmRYTaeaSDX5cgApjjXn72bhyI1FfAfD5FKsp8xmsFY+d3tXEEnCg+42tz8pvQJ/SXs+6VQ9QknqqaY0r8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757089043; c=relaxed/simple;
	bh=/YtnlMWUOI9PhMnJSQ+UNceV7cgubX6CDZwomAJfzgE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L6hLOR5N5+RoN78jN4+0zsZKhFMKkYDRWiybvHjGi6J41gD5kW5dL1zubkRP4Ph55zxFgK6V+RVKpGACMV6hhZ8P4biwxJK+anTeAwjSzs0KXfJ6RFaXS6uNw4tRm8Kun3xx2QdZCtvv0Bdg0bLzPc9R7FTXFvRIoLrMf7iiDzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=KUKtnD87; arc=fail smtp.client-ip=52.101.229.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RSQN2wAhSAce3+ghvA8naNsgbah3gaDiiSyqs6q4ibqW3Xx4fZS6a0PaD2MUtm4yb7yn7tv5eaABZctLIja//RRRUk6DCWEDHOGJECpuABHhIV1bTvSkhNq/KhIB2uuzTbSxPuhxYK3ISCbQdzgxU8763HGtWe6Tuj6eYAryDZNdfoKgz826vjTMXRaXqJ5pAMAFHtoJfoGvqE0aLUX2hLfIyHjau8Hoc5bqvGm/MtyNojfpxRB2Qtod56RLWZEVWkVInI1ADnJJQ0mYSmSDtmaA5/R14ug0dH+FtB8SSMkbUKQMHnW7Khb/aL0o7vLUaXzb1sTJgDiZ1m45EH9nUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19bqrp3hC/MybWnO72Sv+vgJGohSiwq2CcWk1fH4pws=;
 b=gUZDuAFnYZJq33MyL3z5GyLlRdABBqOIg1yCc48j586QGyimca5tSjxHv7ny0318Vluw1ZwNhS3E4pGfjXWBkaKv93uW+VWstB30xxyLGJ4zUvOvqSY4aETquHrgOakwsEY59ZVBb6P3f2jEzvG+3llE8rkXbJeG3bByTq20CtHl7+YuvNL9G1oLxz/yYvYduvQD+7bfsptmrIXcjtYeaxKsUTnS5Mp4c3j/6xPE4grmiCYnENqq+3mFO9UmssheICJV3uNH7fOA4NcH1q5IphO0Fw2zcAI5H1f2Ldh75OuU2qw3mNtCZe7YKTm/Tbrksa7nAlnAtH8bkmICkdceWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=19bqrp3hC/MybWnO72Sv+vgJGohSiwq2CcWk1fH4pws=;
 b=KUKtnD87To0jdDUoukrsJSpi8qmarImFa4kyojsMLtx/5fHockT+5XVTy5y2d9Kd8xlaKJ1Wj+NH67gV/Utv0NxTozNrQoKg+M9R/PNCUz32yxqiwTSX8bcDB2CrbjPmzPZNkUWpU7bOccAMP1vp/ecsN0SiVhnZkUW1bl9TlrE=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY4PR01MB13093.jpnprd01.prod.outlook.com (2603:1096:405:1dc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Fri, 5 Sep
 2025 16:17:15 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%3]) with mapi id 15.20.9094.018; Fri, 5 Sep 2025
 16:17:15 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>, Tommaso Merciai
	<tomm.merciai@gmail.com>
CC: "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Vinod Koul <vkoul@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
	wsa+renesas <wsa+renesas@sang-engineering.com>, Fabrizio Castro
	<fabrizio.castro.jz@renesas.com>, =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@baylibre.com>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/4] dmaengine: sh: rz-dmac: Refactor runtime PM handling
Thread-Topic: [PATCH 3/4] dmaengine: sh: rz-dmac: Refactor runtime PM handling
Thread-Index: AQHcHnOvowQ8m3mNHEC/UNhIO+mIdbSEwncQ
Date: Fri, 5 Sep 2025 16:17:15 +0000
Message-ID:
 <TY3PR01MB113463D1C0F25F3F10A5A0F3B8603A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250905144427.1840684-1-tommaso.merciai.xr@bp.renesas.com>
 <20250905144427.1840684-4-tommaso.merciai.xr@bp.renesas.com>
In-Reply-To: <20250905144427.1840684-4-tommaso.merciai.xr@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY4PR01MB13093:EE_
x-ms-office365-filtering-correlation-id: d5787a09-266b-4d9d-0193-08ddec97adc2
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?q3xbH7pddE5yJFNy3QKU/8QirFwW9UNkg1eX/JSYnnJPPVNDZwpYruoDvm?=
 =?iso-8859-1?Q?Kego3+65bjSyW0Mfs0QKN1N0+A4kX5bMLuXblK7b+uRL0ZjmKC1N94QDFP?=
 =?iso-8859-1?Q?kFbR7A8Lxmu1SUAod3EP1romZfdvYLHyxnrXEO3Ae3z+VMyv74bLb3KXqb?=
 =?iso-8859-1?Q?LwrI/FKo3SljJpZnVBLehWROjIF/NrO6K7pslCjBChEzCPcsufZSirGa/U?=
 =?iso-8859-1?Q?Dwb0uid6HxSom0n4iVXsdkXuwgvKaFGAh8T6n0n89+L209Gs7/REM1KtXn?=
 =?iso-8859-1?Q?fqyZLiKjMjoUncYdjC5fhpcsgHRd7tQumc4UrM9cYd2Ywvi3zyowLCVMkF?=
 =?iso-8859-1?Q?4ZWmiv6V7NhIWXIN2aTX6ZgDLYiblX7BISWaoGjdOmGSwSaezURptVALIi?=
 =?iso-8859-1?Q?61owEc9vrpv2V4UaRkZbZ0GXyg3Ur22jsNvlrE4LGapPSiY8d57u2QqMbi?=
 =?iso-8859-1?Q?pnQAo32Mm3e2q3McVhleeQlonO0HhtLzloEWcu8lZmlIBgC8PBGDBoch2z?=
 =?iso-8859-1?Q?dCTwvZbLQziqvm1Si0poQTLfVSWu/fBymrIiq9ERLSwh7Q4LJcNexH+1af?=
 =?iso-8859-1?Q?uyPhJbyCo9Wyk+tAxDEW0AkTyRRPnL94OA5wSR5YJ0W0Ds1vbA2InGriZ5?=
 =?iso-8859-1?Q?M8WsO/jJ6LXRd0ZvjvSsz85CDFmyd8KRV7GWsAD0ui52He43mnRGiLjsl0?=
 =?iso-8859-1?Q?Yxz+z9jbvESnGcONlk2nraCJnbs+LPt1ZRmx2T0bMTNmuyH2J0WIuPUrOi?=
 =?iso-8859-1?Q?U3DDcvL7NQzJ3JWoMVWhUlEfs09zUOOQSlTa7FmcITGM5gB3qzcknTEU9r?=
 =?iso-8859-1?Q?MCRWC6d7v2NsU6Qq70xxZQc5mRSiVJUKpBHNu9NUKvn/J+waxgQQJf/Z5x?=
 =?iso-8859-1?Q?Kr14aRmMz0kvBmeWkISMvjIj6ySW8Q2KSNapI5FzdBkvC6MVcWeINRWDv8?=
 =?iso-8859-1?Q?TKGDvCiX/GL7gUkTd+sK+p7rZ/XiEZZHoUyWga55jP4K4MFgyE3E/AJ/8b?=
 =?iso-8859-1?Q?046Cy5h96I6h/0J75/tx04AkkErXkmNN3OxwammXV++1g0iaYe1v87w53J?=
 =?iso-8859-1?Q?/0CxL9OIXERZevK7dWuTqWE2lFQRQn1cg3NZbY6C991nitz9bFEyIKVTs8?=
 =?iso-8859-1?Q?LjNe3LfcfCa1H7q9IPmiN8XnaR/EvVK9a/4XqhT7cEJv8yw4evQu/rTLrd?=
 =?iso-8859-1?Q?jlnT6/VZXGbwQverQndejXLnZk9lJgsPVQCHXfGmysMr6ojjqwK5RWiALd?=
 =?iso-8859-1?Q?3pe9FXathGmWH9BWtKyKG0oE9MfsKtZNCokrw0O55q6fcBFK9pFrootihH?=
 =?iso-8859-1?Q?XfmJNluCzq/YL0TvF1gIW9YD7bL0IivLKCQxQuHWQ7zxPeVpetT2RuKQT/?=
 =?iso-8859-1?Q?Y3kh4eoD6UfuxGjFwWpPjogONzsGqO69JrTzi+MkuP0bFNgbbfSjkvU75U?=
 =?iso-8859-1?Q?PN65iHlidiR41/2r1HFD8xeLYjbQodomDgfrYdry+2SVtDkhlFehUZVihd?=
 =?iso-8859-1?Q?9XdarXP0vnlCn+WSA/9jWJGPc2sVr7fmXEOdUtOxJ2EQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?iFGwU2l34Q3mXVuKtR5ua9uypwN+hk+hb6QCUJjy6tXkbNEgKu0gP9JnEk?=
 =?iso-8859-1?Q?3X0zDYbmmaxCMjY737QkHdj+Hzq5jDbwcGyemPcviM4aJr4UlLeexdmzeu?=
 =?iso-8859-1?Q?Iw1JmqaNe+QnUjdb++RsvnG/3svngsJ0j8lFwKnZTwUKjMob4Ek0lkkVYv?=
 =?iso-8859-1?Q?S91KZjxNK7ssFarw9E85PgairxEFap5fCLH/8Nl+QkcSnERXdFjezoRxla?=
 =?iso-8859-1?Q?UzPv49WN4/O5wDW09MDGZd/i7d2Z/dmwtYkg9DUTdAg+6oy2PRO9a+sXgc?=
 =?iso-8859-1?Q?UMwA1EkXSLJeqYampmAo3xp+eg3gzz5/ETHgieKjNyUzhzRtVBSX4GNYdK?=
 =?iso-8859-1?Q?mqxHEYSJSyGWVHJAPgtGSCcz9m8/yiSBZDboLoU0rw+34LdMVww2fAa1bV?=
 =?iso-8859-1?Q?J5kai48m8YASROL2vykKPp1HT4YkH3j3IfUmjEoHQVF9nyb5BdrQDsnfdH?=
 =?iso-8859-1?Q?M/N9zjG3X1zROlXp0GTO9MSrytG07rqV4+gfdoj5XfJtbLcSCAK3DZAp+o?=
 =?iso-8859-1?Q?fBDMvujW5RZUKFJZE9lpS6qYFbh34YPB+OM3GFULDPPydZk5Oe/Xop268Q?=
 =?iso-8859-1?Q?08IY/i+c7hy2ZnViYB7x4xo619SA59ppr7/04jupmx4xVxf35AOWYDIeEB?=
 =?iso-8859-1?Q?hYuSvgsLFQMtaht7PwmIsDaW7Mvur0Nds+cpxTKeDtBson4oTYvY49/GzT?=
 =?iso-8859-1?Q?ivNOq/0oz31K0EgYCx1ENUXqwgj1aVlXv1VZt9BYsaYDBEigj02Oqi6w0h?=
 =?iso-8859-1?Q?Z74dcS3mB8QuzNpUKmo8mTXuJFhXU3eF6VpB81MpiqVLmBgAjVTDSjSX2g?=
 =?iso-8859-1?Q?bYxPWbT354xPmf4o8j/YNGbRxW5qlWuFhTimDnHb8t2ppvLWYISE2Hof7k?=
 =?iso-8859-1?Q?5yPP1rdEX7evDdjTLqkldZvRird3ONMxWv8/VZ/zRZVpGC4IagR+/b8EKx?=
 =?iso-8859-1?Q?Vxgh5T/FRFljTTwl5i0FPJ+MN3q5BWv/HtGBDmcoujae5QR/4dSvTbexTO?=
 =?iso-8859-1?Q?a4MA9oZfE1ne3p8PhkNFip0gbybDs3SSw7nnbF+ZZA0FIzvl3xqCRhZPG6?=
 =?iso-8859-1?Q?Wmp+0qr3aKfmTi1hx8g+S5pSGaFxcmdukho5bHuMLeZlQmaNRrhMJxEhsi?=
 =?iso-8859-1?Q?ThhRd0qJIiWfQ91DNraMRG8W/aVTiLcCnRs+jaoddhxow6aH8KYoYgnUz/?=
 =?iso-8859-1?Q?2ED2NpHfl0yaXEmrj4UQUSQ1aHx+7AXgg75rj9nB6dWNrrkyYjhGyCoOJa?=
 =?iso-8859-1?Q?sGEsO7H5Er2HmIyU4sYxhgrL+Fn6dNFJMNGmfNMyUklQLaLaRLA7GIPrdR?=
 =?iso-8859-1?Q?APWIlkehysfsFx3cAsVnsRD2mScT/GWQ66kCXMkod7xKYDFJHtnoiVm30u?=
 =?iso-8859-1?Q?CNGmK3B/iln8e2/XhpdPJ4Za0dsjQLr4SBsZjUS+hrK/f0UBKdqP06eWFa?=
 =?iso-8859-1?Q?TQWoQ19tpjK4YdI5INMEOXSHakd9KZEBAwpjQDz5W/X7rd7lOZ+eQUX71B?=
 =?iso-8859-1?Q?ta6cAP4TuZErsHcUVGtsnl5bj+kej+xzU51S790/7Tu2dcP13txKsUYysr?=
 =?iso-8859-1?Q?xjj1N3SBv4cPu1AXZqM0MLyiA1orok8Um4mQ0j+jv9bAyhX2rEfP/GRoqx?=
 =?iso-8859-1?Q?b1fgAbl7fxmOgTwizmk+yZxc/t887BcWYAzyM4hUBQ/x6yjDxYt0VXcQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d5787a09-266b-4d9d-0193-08ddec97adc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2025 16:17:15.5799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CFYgkdR8GNagzE9LpdRPUc+mEYDV4tg6jnxxFO5YLaWfDc7VZUokjI3KobMVOHRUN8eyrT/lmnOt/I4YX0Ikv1zKmDManbebUm74Zgl3PsQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13093

Hi Tommaso,

> -----Original Message-----
> From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> Sent: 05 September 2025 15:44
> Subject: [PATCH 3/4] dmaengine: sh: rz-dmac: Refactor runtime PM handling
>=20
> Refactor runtime PM handling to ensure correct power management and preve=
nt resource leaks.  Invoke
> pm_runtime_get_sync() when allocating DMA channel resources and pm_runtim=
e_put() when freeing them.
> Add pm_runtime_put() in
> rz_dmac_probe() to balance the usage count during device initialization, =
and remove the unnecessary
> pm_runtime_put() from rz_dmac_remove() to avoid PM inconsistencies.
>=20
> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> ---
>  drivers/dma/sh/rz-dmac.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c index 0b=
c11a6038383..4ab6076f5499e
> 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -455,7 +455,7 @@ static int rz_dmac_alloc_chan_resources(struct dma_ch=
an *chan)
>  	if (!channel->descs_allocated)
>  		return -ENOMEM;
>=20
> -	return channel->descs_allocated;
> +	return pm_runtime_get_sync(chan->device->dev);

I would check for pm_runtime_resume_and_get(chan->device->dev) first
If successful, still will return channel->descs_allocated to comply with AP=
I documentation
rather than returning "runtime PM status"

@device_alloc_chan_resources: allocate resources and return the
number of allocated descriptors.

Cheers,
Biju


