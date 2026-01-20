Return-Path: <dmaengine+bounces-8406-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KJoI3HRb2mgMQAAu9opvQ
	(envelope-from <dmaengine+bounces-8406-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jan 2026 20:03:13 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFE849F5F
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jan 2026 20:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C7E5A43350
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jan 2026 17:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F39427A06;
	Tue, 20 Jan 2026 17:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="FjpT2J/O"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010009.outbound.protection.outlook.com [52.101.228.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C132426EB4;
	Tue, 20 Jan 2026 17:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768930515; cv=fail; b=J+9hrXEiIsBP29uuNCXPccqDA5FLcKA4swvASESFc5ve6mTf/F2HfMBfDj9QIDzfDOTg+PVFo0UKi8NpHuwlIP1bwXOVGxNTK6RuB6ZUQFC+3q0xZWDhER4rUN9bfVfdo8TYBkTUGE8J9znRfHlSzxS58Fifl8913ktgpCePLlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768930515; c=relaxed/simple;
	bh=I3v6RaTEHOymIxOY82McOSbYhHkdPunZ657PU2Zivzo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=omHd2iMLXJvfjZoESMXe3lbicqBzPxCpLbBfKfQ1BMNoD5VGpeDRTaOcIpvMaDEfEOT36v8lkfB9H9mBtAP918IgVazd8sG/BAGrXcdAgDSZoh9+SoYYEdq+3sfqP6UcP/keE+8Or1cA4MvtF+c6yG+7VrMeRirfm+Sxq8O6zjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=FjpT2J/O; arc=fail smtp.client-ip=52.101.228.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nNRgacB72vLk4KyZXhRgkeOet4IjOMW6GsLVuYfLN5QnyJruhH3FqIuu08NtwN0qk/1Wn6BsWele4v0iYenxoR9yfAdxaWi3Xkkrd6PYvBaopBRLRQSTGR1p7+xjE2I4hi/gImybQoph5e99qoYUhD9iv10C5sDfnHOhI+EwE43iZsNo4LQXeX8tGlgdRKvy2L+JTB+5uTbFd57ZPoaChG0Ivo3aawV7PfqEPwkCI7gHU8T7cgX/ToCQvmygWOcXgWkIR9kiiOMk63aMD5mwgWDRSPWAIz/bJF+LzvzE+IFFfNiJadN7eKhRrSACOL+2njU6pxKjkK0NqRfpmw0AoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qg1fWAI8BBMp6GadKSC7MROaRE146KpCk3QE+u4ObPo=;
 b=MlymmsqYI6GsWEjBuDFRjB5sFxAtwNONfIkjY1LV3WqbS5d3sGlIR4JwE/MlbteIXE3iRUSysYI67lfweGyFhyasv3QgPMNV9BZyphN8R7+n+oApoR27d6JY4+FlSi1d4FihvToTm5Fc+TcK4ooF+XGBsW8607+v5dtKHstMgQNt9t/aNhCUo3Dma9Zs5cojQMSrH5KsBYzMVNqF3kQPZGx97kmVGzSU3U8pxhWsrZfJ22bfM+bPkyOdN60XWJxVA4Qpl4L45WE9D4hx+nRQxVcgQn25E4iJ9mkucAn4cMlyuVblgdmEc0HmkaVK0waBMKN+R3tTV94wN0rHgj0LMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qg1fWAI8BBMp6GadKSC7MROaRE146KpCk3QE+u4ObPo=;
 b=FjpT2J/Okje9PSWnnWtETSndgqaR7ZPVvQKHL1J1jZjzR1Z2RMrnCsqnhRCRQYtgv4+sRB8R7GfZD5l1+t1IO4zqeipp71VFKGSoS1KX46B9lSUNHTNNe/nyE+m/7ePGsZGTdq7NFT3KPs2nJXCQdAYEINppHadcKNqRlS5rM/4=
Received: from TYCPR01MB12093.jpnprd01.prod.outlook.com (2603:1096:400:448::7)
 by TYRPR01MB15468.jpnprd01.prod.outlook.com (2603:1096:405:285::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 17:35:10 +0000
Received: from TYCPR01MB12093.jpnprd01.prod.outlook.com
 ([fe80::439:42dd:2bf:a430]) by TYCPR01MB12093.jpnprd01.prod.outlook.com
 ([fe80::439:42dd:2bf:a430%4]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 17:35:10 +0000
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: biju.das.au <biju.das.au@gmail.com>, Vinod Koul <vkoul@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
	magnus.damm <magnus.damm@gmail.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>
Subject: RE: [PATCH 02/12] dt-bindings: dma: rz-dmac: Document RZ/G3L SoC
Thread-Topic: [PATCH 02/12] dt-bindings: dma: rz-dmac: Document RZ/G3L SoC
Thread-Index: AQHcihADZmPRIipVFkmXiZLu8mkLp7VbUhKA
Date: Tue, 20 Jan 2026 17:35:10 +0000
Message-ID:
 <TYCPR01MB12093D0B9FDAF5EBB5BA4F1E8C289A@TYCPR01MB12093.jpnprd01.prod.outlook.com>
References: <20260120125232.349708-1-biju.das.jz@bp.renesas.com>
 <20260120125232.349708-3-biju.das.jz@bp.renesas.com>
In-Reply-To: <20260120125232.349708-3-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB12093:EE_|TYRPR01MB15468:EE_
x-ms-office365-filtering-correlation-id: 52c4aec4-2409-4daa-b132-08de584a430a
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|7416014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?TdLifEC2TSGyoLYInEE4qd0iGooHzXkfoY5S5Ft+Wz1PqdQPWbUwEyUfZMyP?=
 =?us-ascii?Q?cpTiNv/z735MUux/pZaSqp1RBEy6a5LO7JQ+7zB7EoimcPbwcR33Eu15DdpZ?=
 =?us-ascii?Q?nYV5cjcyPvSzfb/yFM+N2AHsSsfzhhlLsuNahqvkfR54P3FwyTaT453mjnMM?=
 =?us-ascii?Q?d/9vU74Rz57poPfKFFs5gHaMIg7RwqEUkxQiGWx/s54UesSO9D7+wjSk4DCr?=
 =?us-ascii?Q?c7O+jonLWSOtObMulBjPBbYup31eWM4gsp1+Kifi3rQSvCntZlWrWQBLqtwj?=
 =?us-ascii?Q?fas5LPoI4JM63nkxpp78/Z+tm8MXKdO3DAmJZXyxnML6YNNO3xSZTEM0yrmB?=
 =?us-ascii?Q?xPpJvZhZ45Bke6KVJRkiFIpyV3meURhT4xh6HqHobBrHy6FYjkxNltCMOxeY?=
 =?us-ascii?Q?tSZw+Ba0wNZavY8UUp59KkC0dF+5Ifixgr8l+9pVFl/Ka4ANGzGASq/8sd62?=
 =?us-ascii?Q?7AUwfEtH9/vwoU8PxXL/9ScUktVex/f5cUV40OxTObGjwSP3H0i6YUGZXi7h?=
 =?us-ascii?Q?u9tvpdY1oSeuyxgH2JHtJ4KaX59q3itvkhrb0jH4r65sB+llZNQbPlxydbZC?=
 =?us-ascii?Q?465ZvrDf3KVs0jJcpJTFj/n4TDIAZEzB7HrCl5vVGeHvuQxtNu11bLBZfvpK?=
 =?us-ascii?Q?JhZjYaucUrKS2ipN+Rlt7zrt4ym33rVHvZ/tnY1eL7DnLdeZKTOs7mCtgAVy?=
 =?us-ascii?Q?7mAN/cPoCQYFBAfowxJWqVH4UDY2qpaegiq7mNUj6QmpRHlBuM8rzeaSFU+G?=
 =?us-ascii?Q?pDxYcHHKE2BygXk4x0H4qgJ6nCPOlkGx0Aa3gKclS958IbcNs0puN0kXXVHo?=
 =?us-ascii?Q?3nSXEa8uHsvN+dx3KjCeqHGyHSxpMwuEmUyTtwIyV149TCCDmWQOBHF+lmx7?=
 =?us-ascii?Q?0zXQ+NeOOXy3n8My+8Q/6by7RI4I5a0aztyerIUsv+camzYKBI6OtB6W3cBJ?=
 =?us-ascii?Q?EgK4mjnsXII2bGGfe/kK4I6VyMs5xU+93/LxWgPLuuTM378h3HARF/Fz45hh?=
 =?us-ascii?Q?cu7v3mcQ5HuGl0Vwaqq7v4dztHjAwVXmYH8cx+lXCBjjhk5Hi83T9InkxaN+?=
 =?us-ascii?Q?0snpW7pc0yn+FE69dT2EzzrU37VA0V5bkk52kGOH1AHyjk5Rf8W2Erdkftk3?=
 =?us-ascii?Q?ae4Y5yY2HD/hgdbx/uI3tkgEmxR4cZnr9wdUdEKRH4JQ4sS5ziQm+LyPfxRj?=
 =?us-ascii?Q?P/++FqvpYRo1Mup8tBII6s7cOH1K6yqzSGeKDVPlb9hKyn7r82edJbkV05Yh?=
 =?us-ascii?Q?Q4utCx/O1Kav8sLSZnCHsJnCxMMDiwrImEWgUIci0tmB8T6y4FU54t+gUlPv?=
 =?us-ascii?Q?pwAiS295ONkahtsdXkisdii2NxvvjE+zDpTTlcr6k8PW4EdzAbBsqml3ZSWJ?=
 =?us-ascii?Q?e88cRD/89j5/A2riZWAcTb7QRdG3X1ySPXP7pWGA0iUqZp6Lsn5YkUQFYSK4?=
 =?us-ascii?Q?nmgH8A9NO8TTgbyUDw0fwHqlYRiU4fYewpLkrOdKyM4edCnzdf7w0PrZ/Oyj?=
 =?us-ascii?Q?9FkUeae/qmFNORB0FTVrHDFvDFheiILLJj/bNzTOCdf8dAMORVzXnqS/RSYd?=
 =?us-ascii?Q?AzHt1Vad+GIvPmr/A8ncShrm53jO7xHhvSG0M4q0AkjHyDrBzzlzFkFV8FZF?=
 =?us-ascii?Q?78MwwZEIGm9md8FujhJcFwc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB12093.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Mwi8xV7H8KLSb1W03KlY518MSWCfhFeJLC8FyfxaADZAIwtmuUsKxeIC51mp?=
 =?us-ascii?Q?jQ1lT4vlboqVyeohp2rdVZz/jToJcIW38I8QJPRn1YZ2AYxuuN2mGf1l+fS6?=
 =?us-ascii?Q?Q/QaVActA3iBeI+BeVEm+qKNts+E3KHYXtZJOkAjFlIY16RFWn4d9Qp1k8M3?=
 =?us-ascii?Q?bbJqvXtU4OmcpH15GfdiX5fFOON5bosWmqk5/tz4/YwRjzH3QfBd2mgBMn7f?=
 =?us-ascii?Q?+rDWZ4SZq4+LHJGfWxzLYe1XwztYpKciqya6cfDUkwu5t8IglM9GVdSrs0Bb?=
 =?us-ascii?Q?hE1kOX0kT3arBFUtdFZx87vQJlGr6dYzrE3ztdVgw1uhaKKEQp/OrdkcL7KS?=
 =?us-ascii?Q?0zppM+bjjolbWSXagdI2lMdqwnmXpQ2DF/xf+4pbH/GahyT89b2yzCLimG0Q?=
 =?us-ascii?Q?pubjjKSjMjgdlOI95GdX2+S1zXl9pQXFpLmJ8wABSXXN/MtOBntdcUlasI8A?=
 =?us-ascii?Q?DESbKMVDvXIETRiym9Y8Qmm68yWk9d3ysMkXSs5FfEaU5Nt1FxjwOVsADnQx?=
 =?us-ascii?Q?aqsgMCigrrW5/E6ijLUqGqhzYmdi90V+Jm1gXZh3v9PMKtIaJ6pwZK0oXQL/?=
 =?us-ascii?Q?wIY8kkipOiRRFspa5bwM4F85oqgBUCf7TC6cm3wIkOeNMuxtG1R2NbbpGA4g?=
 =?us-ascii?Q?q0PjUrNGApqBTtpJ7yMsF7LFU8xI4DZXkVpr4VALXhv3cifbG9SrbQMuUEnW?=
 =?us-ascii?Q?LRrkPg9e4yv5B14kROYFBOBwg3tceUXDB4cd7YHVBJg8Q2tK+tJog/ARzU1Q?=
 =?us-ascii?Q?ucSe/HsayhwuMYOoKQ/+UsSZ/AM7CujZ7C6A3UggqfE8pybEl0oa+soCFtCt?=
 =?us-ascii?Q?fE8DAXv5XFsBeEpBodrIIc+R8ctAiHonYbbwXSEMEXaxJSj+GwnJRErA4Cjn?=
 =?us-ascii?Q?sdicJMr5Ewt4AsScGfEigAHojTGJqmNfJ9lFFtpV6cIExAqa1tVoyJg5reio?=
 =?us-ascii?Q?1Ad3nSCONnW/KhQBbKTYViUD2vVHSsMUtchRGt8eSWsWPtZwyqDtY1qnaFqM?=
 =?us-ascii?Q?H+kfLAcvsKU6ZrBjvHSHjYXcnV1oo4p9wthx2/HuasTPEkXI/s1TDAVnFLv6?=
 =?us-ascii?Q?FPcW1p1161irwPvvTI1Gn5Nidy4jTyaobIKbH9ZMTbDumvtfMfpLdv7B9u1a?=
 =?us-ascii?Q?ofBofAPyiqvLtBytA3rQfDRtmlWkMEVFfDeSKo53gtF+Uaw/0bFsoCDbV7VP?=
 =?us-ascii?Q?NVuheZDMb+9JYdNoDSmzf3CMSpFshjuovdRKwiA+L9LJm+kmHJ1CpVaFspTC?=
 =?us-ascii?Q?5Jj59waZozqV7DIfy5Xh/E1szqrgdJ1l1KqVNU3dDI0dEa8dFBI4XXLfx5tk?=
 =?us-ascii?Q?S73Ngj4h4iy8aoco/0T21q6cWcVAsgzAyGzf85T52dKRkNO9Y5hqI9WpVgPd?=
 =?us-ascii?Q?uVcX2z8P4TcN3xG+vHgOS43Ohu+EJWsppJWI/S5LKW0aEWs51Av4a9BR79mA?=
 =?us-ascii?Q?bhcl8aiBzfe2AHumLFnTJFaM5c44NV9KRkkhWbCCpsSS3JgsYG3fqh6iP1Sl?=
 =?us-ascii?Q?fGDUnfyGG7MurxLhNhldu5OvAMK3vUK2jR3hc5i0BiG0azDJYBZcKwYyrR6y?=
 =?us-ascii?Q?y/YbsPivDZ29Hl4i0AbBnTll7n2ugimK2m/fxKOqSmLoS88XW0yzpoV2Yle8?=
 =?us-ascii?Q?P+UOpF0n5kvqHu4U4AEmN4erbA4gAoffdusaUozo2iNi4iZ2WUFGLq6nMO65?=
 =?us-ascii?Q?A4pUUJxax4xdDtdBYm4l/TeG5av/BB8yS9a734Hq83LEP0lSPvppDy9x9oRP?=
 =?us-ascii?Q?SMvdZs4tO4MmN/Z+f9vddXKtM9YZHpk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB12093.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52c4aec4-2409-4daa-b132-08de584a430a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2026 17:35:10.8369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uNumr1+jQDaYvpt3hy8EyIAb7sv+sgHpppcwTodaKzZj/2qkp9ybkZIBffm8wtIWMDidoa3ktxQujmAaSm4Gw9NO1WzM2wMHKjkjG+b8tpw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB15468
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[renesas.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8406-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,glider.be];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[bp.renesas.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[renesas.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fabrizio.castro.jz@renesas.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[renesas.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[dmaengine,dt,renesas];
	RCVD_COUNT_FIVE(0.00)[5];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,das.au:url,glider.be:email,renesas.com:email,renesas.com:dkim]
X-Rspamd-Queue-Id: 7FFE849F5F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> From: Biju <biju.das.au@gmail.com>
> Sent: 20 January 2026 12:52
> To: Vinod Koul <vkoul@kernel.org>; Rob Herring <robh@kernel.org>; Krzyszt=
of Kozlowski
> <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Geert Uytterhoe=
ven <geert+renesas@glider.be>;
> magnus.damm <magnus.damm@gmail.com>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; dmaengine@vger.kernel.org; dev=
icetree@vger.kernel.org;
> linux-kernel@vger.kernel.org; linux-renesas-soc@vger.kernel.org; Prabhaka=
r Mahadev Lad
> <prabhakar.mahadev-lad.rj@bp.renesas.com>; biju.das.au <biju.das.au@gmail=
.com>
> Subject: [PATCH 02/12] dt-bindings: dma: rz-dmac: Document RZ/G3L SoC
>=20
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> Document the Renesas RZ/G3L DMAC block. This is identical to the one foun=
d
> on the RZ/G3S SoC.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

> ---
>  Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> index d137b9cbaee9..e3311029eb2f 100644
> --- a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> +++ b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> @@ -19,6 +19,7 @@ properties:
>                - renesas,r9a07g044-dmac # RZ/G2{L,LC}
>                - renesas,r9a07g054-dmac # RZ/V2L
>                - renesas,r9a08g045-dmac # RZ/G3S
> +              - renesas,r9a08g046-dmac # RZ/G3L
>            - const: renesas,rz-dmac
>=20
>        - items:
> --
> 2.43.0
>=20


