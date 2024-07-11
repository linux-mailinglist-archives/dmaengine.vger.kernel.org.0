Return-Path: <dmaengine+bounces-2676-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5810792E7FA
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jul 2024 14:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7E8D1F20FDE
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jul 2024 12:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8B015B0F9;
	Thu, 11 Jul 2024 12:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="lPG0WJu0"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010055.outbound.protection.outlook.com [52.101.228.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB76715B57C;
	Thu, 11 Jul 2024 12:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720699723; cv=fail; b=mxS4xUcrPcmEPBHG5yQNx9KM5LsXJZx+LY9q/lMQSNaBvaC6mFKgDMfELF+Q+mJqygQFQBhf/DUNEVcrFoaCmgfFb9b+NVZEnL3fVNZJzf0mKlfX51Zx/tNll6DewBwlrYizSNfR4aXUCpKeSC67ltW8Cstpf10oKs3BKuyw+vA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720699723; c=relaxed/simple;
	bh=0M2lT4ZIZi9mxGq1Phd0sxpaKWdnEGsN5xPiCSPl20Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C5mgFrlAFyFWsgvO3wzGcgaPpIgHCUIHQNPRSGw24EzabSJrmOuNtQObFh4psY3rEA7DBYThWQmVyHoqfrdBcUHkA2qT2jFCKTrY9iBEKOTq6nGcAh02e5qpBm77PEz2QMGW+cv6BYSvwUkwwu5S9OlXyj+0flDFqUHcZbaWqG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=lPG0WJu0; arc=fail smtp.client-ip=52.101.228.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DsPISALKDRzX361LQEx7StmD3KpPj2tGNxsTEfcJHex+NlgqHXeHWBCmZRPWeEZqCZXiuLUNs8rBAF9yPcQxrLDCAfx/qfWf1S+k2TGpwovcTDXUoeHzU02Q5J+Nk/qaHGULD92hKFm7ma5508a6PjCxu0fqLHJZJ3YUDHpNCS731DR89zD1YgP3Y9Vd7HoExR/odQ8GpwBYCBBO1OjBJFSm4CI+qiyjjI820BxM6qg7kP+7JPJsxUyz0If1MPEMqJOEfuNCArTgXCCmwyMIRAdYvxASLjhUPMM1cFjXZ4yX80xHMMrVp2K3K+qF0Q8ZBLpfvb4ejc1PODy8qu6BGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mgX/RJn8y6SfNHIdaElK4Ykd30A5QcfXNVIBXFJGCYA=;
 b=hV75+QyXpH42RiIkDEbLfdmugw4HZs4QG2kLTodVhM80Vf9p9FiMeYhQwi9KLnd/UklSO1HNNWPolfsiG14quAGcQYTAYx1E/c5+4bbnidK1NmYqewJCqMt9jRJzzOyAUNevaecriugCTsOp5wkiR3Oh5JT3wFluSh4M7T+QPX6ntlx75uBKmRndtKri0h4ZXvvVng4wSGv+N80uSk8FD2B3eMZbTZTS6xCDPTOXKufz6qNAhfFDRGXD2JerM+eDgkR1HAF1jj5ehGPvq7DC/vJVrJoUxXptyjyr2DUBnbXMVVY+6RIdkg2dWdnwrTNm2zlN8pcTLaY2eIg++4l5yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mgX/RJn8y6SfNHIdaElK4Ykd30A5QcfXNVIBXFJGCYA=;
 b=lPG0WJu0wRgY98onLWVxBr29ukcP0Q03gINMqp4ECqExasDMVg40+NzlGaEfOWVS0TvzuYVrSx3jECuaNsdqLaXj6qtwfPwg6sIlZ4yezZ6RUBmOHdRLNlwxJ8/9xSberRz0N4u2YzwRIZV9QRlFsK7PfMTzjj+IRyh2VXNL6Pk=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYCPR01MB10994.jpnprd01.prod.outlook.com (2603:1096:400:3a4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Thu, 11 Jul
 2024 12:08:35 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.7762.020; Thu, 11 Jul 2024
 12:08:35 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>, Vinod Koul <vkoul@kernel.org>
CC: Geert Uytterhoeven <geert+renesas@glider.be>, Pavel Machek
	<pavel@denx.de>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Hien Huynh
	<hien.huynh.px@renesas.com>, =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>, biju.das.au <biju.das.au@gmail.com>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] dmaengine: sh: rz-dmac: Add support for SCIF DMA
Thread-Topic: [PATCH] dmaengine: sh: rz-dmac: Add support for SCIF DMA
Thread-Index: AQHayW5Pu7/Wfi1U8UuGY1oiE18WY7Hxgw3w
Date: Thu, 11 Jul 2024 12:08:35 +0000
Message-ID:
 <TY3PR01MB1134646892A5137DCAEEC7FBA86A52@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20240628151728.84470-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20240628151728.84470-1-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYCPR01MB10994:EE_
x-ms-office365-filtering-correlation-id: 22c70fd4-ab55-4f4a-91df-08dca1a230cf
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?SGKJYXVrXy7jqV/1bSWZflDFGRKbzdSsWoSWN17X1ivdyuGtTbc+ApIY+d?=
 =?iso-8859-1?Q?K/ffAHjkC4RLhFUhg0yMw0eb115TR09/ClWVCgTxP1R7lFSt8P/YeLrNJ/?=
 =?iso-8859-1?Q?zE83TE9ieHhFclP1meVm5yYZmGEMFI9dMp/nQ/zyATPMm2z63nzo0Xq3vu?=
 =?iso-8859-1?Q?CUzr1daSo2lIqDIGz87LZjs7iSBLY817Z9bgXzVbFPSG8Yznwce2/pYgUi?=
 =?iso-8859-1?Q?O7sSiX3Y1g8p/8X7Rl7tgkb1+NsXjrrD0sQM7HseHQ2E20UnfFpmukOnYW?=
 =?iso-8859-1?Q?CqKQFXJpa/UxY1EIJ92GJ7qullzL/lZ52Bhi1Y1OSJwT0yKMaoF1QXCf/O?=
 =?iso-8859-1?Q?wsA+ux72MN6VGss6d7W9a8JN7SNNXgc+iAjjbeKHj5OzcZrzUUlthnEXDb?=
 =?iso-8859-1?Q?ct/Hx5g38Y75tt++rJTXYdsq92JAbt5vlP5R5SmONBTfDzlmz9J0N0UebH?=
 =?iso-8859-1?Q?ElELMNnWfZbM+v3r4mMomTNChlRgGWQUXBRrLg4LN8JKalZ7GwvSERgqJ6?=
 =?iso-8859-1?Q?9X0mtKk47et3y3uTKeQKfME/lQMUQ5iq7HcfOD7UemzAiTgwNUO+a2LJaY?=
 =?iso-8859-1?Q?RRp4+yIfE4FlR+Hvz3Av+IhyX+CAW3SFweGp2snzfMHgfwT0qtEJVPqHQ7?=
 =?iso-8859-1?Q?PDsaAUpSp+yRpoSsN9vNIqFBdqfTuy/CHknKQlO+7xlyvjkqcUspfqwp3T?=
 =?iso-8859-1?Q?oENJVCayvqZ/x/KEAR3+jHeCU2apq6958RMDWaQIAtqgSrS8uoBb936efl?=
 =?iso-8859-1?Q?PlEDX/8LoadnFu4sWbpvBY2Opx2UIpx+qR9L3Cc5AFLyOkTKmpHPaRddKd?=
 =?iso-8859-1?Q?fWoQJZWpFOcu9OU2W9qpiJDEnYKIYxn5fXMimPpTTmtSM+HcFM1vsfisp1?=
 =?iso-8859-1?Q?YxOVwC/zWWN3mU8MEzVoFlgoeQFqP+QjuGucCXrqKBV3YyfUsxJ4DVqk25?=
 =?iso-8859-1?Q?N+k2bA48ZzzwrIZ3QSrsnSS4MQkOraagFVsBwiDpf+reLb5bGcjeuowkfi?=
 =?iso-8859-1?Q?j7nS2w1CgyzlkBtnnzOEeRtNonvlXNtIMQ+Cmk64gHNcxA2p+fqWhyfW2x?=
 =?iso-8859-1?Q?9/Kq5BkniK6YvhPP7wI2JhvlIiso8Jh2DXuj9l93ZT0CfqFDMbIwBLBTtX?=
 =?iso-8859-1?Q?FT3Vthi2xTtdB2b5L0BDGLJq7aHDtGo5ZyPQISbtSl/QGZCgMwO/XCIuER?=
 =?iso-8859-1?Q?OSdeQKqq9HZw9I+aPTRJw/hB2qZJ3Ing/SG9zbwxnKMNrExBZ0ZiqHTTm8?=
 =?iso-8859-1?Q?YA8RG69jGNwKFyh1TFOIkmZ6rP67EY8uZj4B9Ki2ue2pIROvEpnyqcjjk7?=
 =?iso-8859-1?Q?NM25DIKficN8KpUz/LmNSNP2rzT9NKrYlZrI3FCvD6PPbXUP8085/SLX5J?=
 =?iso-8859-1?Q?HgkzDs+0lSPXu/FvJyKyHXh0849H6R5Zpn98kMjz4vwswxyzdsURQn1gbH?=
 =?iso-8859-1?Q?6se2FNO1LIRTbbqickfkwarPBiNT76nhbhULfA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?/2paCE005OgzNDHPG16f13jXtLF9OAXH2RIhyfPjjJo12xff9ML9jRfhys?=
 =?iso-8859-1?Q?UGm7/tlZr1UZS1M5+9Q5poC5vd1nLMe9+wK/JJ68V8EUoGGZXH9f9S182m?=
 =?iso-8859-1?Q?8/bOsiUiof3TNJPfl2s0AGufC0DrbCuBdNzPz7IvRKkKS88q6EkEoZBvd0?=
 =?iso-8859-1?Q?gO1jL6wEi9F+YqwHKonZ89rDBs0DylrcxZd6/Pfn/dfVbMpmNIZogOWmoG?=
 =?iso-8859-1?Q?JtY3GflEPghJIaZn4aazO7v3qHVluQz4PywPL31JLpmJNoDrrm96msbrXZ?=
 =?iso-8859-1?Q?6C/bci32Obw3289sXMw6gowbSwXBQVaUwCvr2SAVwUpWTcybtRLRIPR8DM?=
 =?iso-8859-1?Q?atEVjs5eChsa287reLTGWeCU1AKT3IMZdbNk7yM74+EKj82Gn3OlVttebb?=
 =?iso-8859-1?Q?EsqR8rQAe/tKo57D16HjQvJXfBgtp6+FD2tigrTgLTG/Rz1iWDM9coeBBA?=
 =?iso-8859-1?Q?GSYBvqMy1qNyVR4Ea7Q+hh+YisafVv8SMiuVdO/JpPTnn5X3kLsGIkiuuK?=
 =?iso-8859-1?Q?UKmgdkQAah9QnKvI/0Upjl/sqgbpUYnQ8BIzfaCVUsIsYFvmiXAI1WmXQP?=
 =?iso-8859-1?Q?C0i7fdNSSQajqTTCbceCMD/Flf3TpxjfA/IGlSzy3yIr/SazpSGuLnxJ0M?=
 =?iso-8859-1?Q?9JbyXycea988oUAS7CFe7+C9Ju2Fe1h0XaV31dOoJbCHaAiG+pY8ab4Xxj?=
 =?iso-8859-1?Q?UXfkJdNyXLQ/fGwnlEHrl1O4nrErGtMpgt8h5QDHZm6pDGWFdYUet242zZ?=
 =?iso-8859-1?Q?bTWHlmr2fYJXvU8K6NtA9kS7onyv8bLAzBahrHgM9x3tuhc3WmleNCh/TR?=
 =?iso-8859-1?Q?0VzMBb7sTtFO+3ajzpRbu8v4+jKnFPfVhZmHJW3Kt0VAqW8LzNOqeOWrY4?=
 =?iso-8859-1?Q?oCUjsF4qhok+FBGP6MlDEtwbaI06SExi8LRyYmweUyh+2subec8yLAPLx8?=
 =?iso-8859-1?Q?Os97Q+bM0Ahv/7+Vh9+Hv2uk7obZYbejY2O+gmJKNRgwacf5Rh7sK3KRzo?=
 =?iso-8859-1?Q?XKb0FsmvJ/+dsbEEU4FvzmGJ02qyCZv1Dvrbf1vN2FRKu/TuohJxmhlIt/?=
 =?iso-8859-1?Q?HwL2xlFCP3qDbYaidab9Z4tEDDY0v4PlAATAvUvOqTsCCITkCRpreqQJS5?=
 =?iso-8859-1?Q?t6wpgzhkwDJ5n5ulv1BwNIM6Jg0HYbGgY/MZ7IiFIsFkOSxe0gHjTMJxlO?=
 =?iso-8859-1?Q?Y3Cdpgm6XCmYgh4Kike9ne9HLssxIxbVG23O4Ay2JUi6x8BkXAfRin2Qw7?=
 =?iso-8859-1?Q?jiHK7SnSLExtRwB0ib5kX4Z64tHZvfeecaW8pjfu2QGtiOk8zOtP9ZaeW9?=
 =?iso-8859-1?Q?NYFe0DPfbx9Jpt6eEDYH7xszFXtmTE2dP8l1APNM95XTc9kiVFbwoGXHG0?=
 =?iso-8859-1?Q?9U3ptU3HExHLBAXg11TIxGuXkxclXBh68wiDhByocZPOz6PZmhlfvVoyqX?=
 =?iso-8859-1?Q?/fHqwG9rN+K5Qk6P/qpNDMmFgjQZdJ0H8mjJyMykNGAhz8i4CbEBY5s+9/?=
 =?iso-8859-1?Q?FiHo6wcGYbN0tQXhqNhDfif/vAht11+khE00YlykJW7aXd+soRIQSNGztR?=
 =?iso-8859-1?Q?mr/hC+MtXLJdJFwQZIOjHz0D+5I/A1fjYGkF62/5k4N/Z1msD8n4fEPPmP?=
 =?iso-8859-1?Q?1H6YsG1noyKR3PmyE5TbSm6nxiOrFKCcBP?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 22c70fd4-ab55-4f4a-91df-08dca1a230cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2024 12:08:35.5150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SZ3F7HEQfvWTt7RTUUElVfnyOJYeAIWviNW3kRH4CTZSHmI/8OYWOEiLlXwpGwbKhJwBVUVrYr/q0tTbgNDLfzkjWhTXo9t6Qt1renAr9SY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10994

Hi Vinod,

Gentle ping.

Cheers,
Biju

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Friday, June 28, 2024 4:17 PM
> Subject: [PATCH] dmaengine: sh: rz-dmac: Add support for SCIF DMA
>=20
> The sh_sci driver supports dma with pio mode as fallback. When the DMA Rx=
 time out happens, it
> switches to pio mode and the timer function has the below dma callbacks
>=20
> rx_timer_fn() of the sh-sci.c:
> 	dmaengine_pause();		/* [1] */
> 	...
> 	dmaengine_tx_status();		/* [2] */
> 	...
> 	dmaengine_terminate_all();	/* [3] */
>=20
> Update [1] to re-enable the interrupt by clearing the DMARS. RZ/G2L SoC u=
se the same signal for both
> interrupt and DMA transfer requests. The signal works as a DMA transfer r=
equest signal by setting
> DMARS, and subsequent interrupt requests to the interrupt controller are =
masked.
>=20
> Update [2] to calculate residue, so that sh_sci driver can work on leftov=
er data from DMA operation
> during pio mode.
>=20
> Update [3] to invalidate hw descriptors for reuse.
>=20
> Based on similar work done for rcar_dmac for supporting scif dma.
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  drivers/dma/sh/rz-dmac.c | 193 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 192 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c index 65=
a27c5a7bce..3ef4dda51c8e
> 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -109,10 +109,12 @@ struct rz_dmac {
>   * Registers
>   */
>=20
> +#define CRTB				0x0020
>  #define CHSTAT				0x0024
>  #define CHCTRL				0x0028
>  #define CHCFG				0x002c
>  #define NXLA				0x0038
> +#define CRLA				0x003c
>=20
>  #define DCTRL				0x0000
>=20
> @@ -533,11 +535,15 @@ rz_dmac_prep_slave_sg(struct dma_chan *chan, struct=
 scatterlist *sgl,  static
> int rz_dmac_terminate_all(struct dma_chan *chan)  {
>  	struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
> +	struct rz_lmdesc *lmdesc =3D channel->lmdesc.base;
>  	unsigned long flags;
>  	LIST_HEAD(head);
>=20
>  	rz_dmac_disable_hw(channel);
>  	spin_lock_irqsave(&channel->vc.lock, flags);
> +	for (; lmdesc < channel->lmdesc.base + DMAC_NR_LMDESC; lmdesc++)
> +		lmdesc->header =3D 0;
> +
>  	list_splice_tail_init(&channel->ld_active, &channel->ld_free);
>  	list_splice_tail_init(&channel->ld_queue, &channel->ld_free);
>  	vchan_get_all_descriptors(&channel->vc, &head); @@ -647,6 +653,190 @@ s=
tatic void
> rz_dmac_device_synchronize(struct dma_chan *chan)
>  	rz_dmac_set_dmars_register(dmac, channel->index, 0);  }
>=20
> +static struct rz_lmdesc *
> +rz_dmac_get_next_lmdesc(struct rz_lmdesc *base, struct rz_lmdesc
> +*lmdesc) {
> +	struct rz_lmdesc *next =3D lmdesc++;
> +
> +	if (next >=3D base + DMAC_NR_LMDESC)
> +		next =3D base;
> +
> +	return next;
> +}
> +
> +static unsigned int
> +rz_dmac_calculate_residue_bytes_in_vd(struct rz_dmac_chan *channel) {
> +	struct rz_lmdesc *lmdesc =3D channel->lmdesc.head;
> +	struct dma_chan *chan =3D &channel->vc.chan;
> +	struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
> +	unsigned int residue =3D 0, i =3D 0;
> +	unsigned int crla;
> +
> +	crla =3D rz_dmac_ch_readl(channel, CRLA, 1);
> +	while (!(lmdesc->nxla =3D=3D crla)) {
> +		lmdesc =3D rz_dmac_get_next_lmdesc(channel->lmdesc.base, lmdesc);
> +		if (i++ > DMAC_NR_LMDESC)
> +			return 0;
> +	}
> +
> +	/* Get current processing lmdesc in hardware */
> +	lmdesc =3D rz_dmac_get_next_lmdesc(channel->lmdesc.base, lmdesc);
> +	/* Calculate residue from next lmdesc to end of virtual desc*/
> +	while (lmdesc->chcfg & CHCFG_DEM) {
> +		lmdesc =3D rz_dmac_get_next_lmdesc(channel->lmdesc.base, lmdesc);
> +		residue +=3D lmdesc->tb;
> +	}
> +
> +	dev_dbg(dmac->dev, "%s: Getting residue is %d\n", __func__, residue);
> +
> +	return residue;
> +}
> +
> +static unsigned int rz_dmac_calculate_total_bytes_in_vd(struct
> +rz_dmac_desc *desc) {
> +	unsigned int i, size =3D 0;
> +	struct scatterlist *sg;
> +
> +	for_each_sg(desc->sg, sg, desc->sgcount, i)
> +		size +=3D sg_dma_len(sg);
> +
> +	return size;
> +}
> +
> +static unsigned int rz_dmac_chan_get_residue(struct rz_dmac_chan *channe=
l,
> +					     dma_cookie_t cookie)
> +{
> +	struct rz_dmac_desc *current_desc, *desc;
> +	enum dma_status status;
> +	unsigned int residue;
> +	unsigned int crla;
> +	unsigned int crtb;
> +	unsigned int i;
> +
> +	/* Get current processing virtual descriptor */
> +	current_desc =3D list_first_entry(&channel->ld_active,
> +					struct rz_dmac_desc, node);
> +	if (!current_desc)
> +		return 0;
> +
> +	/*
> +	 * If the cookie corresponds to a descriptor that has been completed
> +	 * there is no residue. The same check has already been performed by th=
e
> +	 * caller but without holding the channel lock, so the descriptor could
> +	 * now be complete.
> +	 */
> +	status =3D dma_cookie_status(&channel->vc.chan, cookie, NULL);
> +	if (status =3D=3D DMA_COMPLETE)
> +		return 0;
> +
> +	/*
> +	 * If the cookie doesn't correspond to the currently processing virtual
> +	 * descriptor then the descriptor hasn't been processed yet, and the
> +	 * residue is equal to the full descriptor size.
> +	 * Also, a client driver is possible to call this function before
> +	 * rz_dmac_irq_handler_thread() runs. In this case, the running
> +	 * descriptor will be the next descriptor, and the done list will
> +	 * appear. So, if the argument cookie matches the done list's cookie,
> +	 * we can assume the residue is zero.
> +	 */
> +	if (cookie !=3D current_desc->vd.tx.cookie) {
> +		list_for_each_entry(desc, &channel->ld_free, node) {
> +			if (cookie =3D=3D desc->vd.tx.cookie)
> +				return 0;
> +		}
> +
> +		list_for_each_entry(desc, &channel->ld_queue, node) {
> +			if (cookie =3D=3D desc->vd.tx.cookie)
> +				return rz_dmac_calculate_total_bytes_in_vd(desc);
> +		}
> +
> +		list_for_each_entry(desc, &channel->ld_active, node) {
> +			if (cookie =3D=3D desc->vd.tx.cookie)
> +				return rz_dmac_calculate_total_bytes_in_vd(desc);
> +		}
> +
> +		/*
> +		 * No descriptor found for the cookie, there's thus no residue.
> +		 * This shouldn't happen if the calling driver passes a correct
> +		 * cookie value.
> +		 */
> +		WARN_ONCE(1, "No descriptor for cookie!");
> +		return 0;
> +	}
> +
> +	/*
> +	 * We need to read two registers.
> +	 * Make sure the hardware does not move to next lmdesc while reading
> +	 * the current lmdesc.
> +	 * Trying it 3 times should be enough: Initial read, retry, retry
> +	 * for the paranoid.
> +	 */
> +	for (i =3D 0; i < 3; i++) {
> +		crla =3D rz_dmac_ch_readl(channel, CRLA, 1);
> +		crtb =3D rz_dmac_ch_readl(channel, CRTB, 1);
> +		/* Still the same? */
> +		if (crla =3D=3D rz_dmac_ch_readl(channel, CRLA, 1))
> +			break;
> +	}
> +
> +	WARN_ONCE(i >=3D 3, "residue might be not continuous!");
> +
> +	/*
> +	 * Calculate number of byte transferred in processing virtual descripto=
r
> +	 * One virtual descriptor can have many lmdesc
> +	 */
> +	residue =3D crtb;
> +	residue +=3D rz_dmac_calculate_residue_bytes_in_vd(channel);
> +
> +	return residue;
> +}
> +
> +static enum dma_status rz_dmac_tx_status(struct dma_chan *chan,
> +					 dma_cookie_t cookie,
> +					 struct dma_tx_state *txstate)
> +{
> +	struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
> +	enum dma_status status;
> +	unsigned int residue;
> +	unsigned long flags;
> +
> +	status =3D dma_cookie_status(chan, cookie, txstate);
> +	if (status =3D=3D DMA_COMPLETE || !txstate)
> +		return status;
> +
> +	spin_lock_irqsave(&channel->vc.lock, flags);
> +	residue =3D rz_dmac_chan_get_residue(channel, cookie);
> +	spin_unlock_irqrestore(&channel->vc.lock, flags);
> +
> +	/* if there's no residue, the cookie is complete */
> +	if (!residue)
> +		return DMA_COMPLETE;
> +
> +	dma_set_residue(txstate, residue);
> +
> +	return status;
> +}
> +
> +static int rz_dmac_device_pause(struct dma_chan *chan) {
> +	struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
> +	struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
> +	unsigned int i;
> +	u32 chstat;
> +
> +	for (i =3D 0; i < 1024; i++) {
> +		chstat =3D rz_dmac_ch_readl(channel, CHSTAT, 1);
> +		if (!(chstat & CHSTAT_EN))
> +			break;
> +		udelay(1);
> +	}
> +
> +	rz_dmac_set_dmars_register(dmac, channel->index, 0);
> +
> +	return 0;
> +}
> +
>  /*
>   * ---------------------------------------------------------------------=
--------
>   * IRQ handling
> @@ -929,13 +1119,14 @@ static int rz_dmac_probe(struct platform_device *p=
dev)
>=20
>  	engine->device_alloc_chan_resources =3D rz_dmac_alloc_chan_resources;
>  	engine->device_free_chan_resources =3D rz_dmac_free_chan_resources;
> -	engine->device_tx_status =3D dma_cookie_status;
> +	engine->device_tx_status =3D rz_dmac_tx_status;
>  	engine->device_prep_slave_sg =3D rz_dmac_prep_slave_sg;
>  	engine->device_prep_dma_memcpy =3D rz_dmac_prep_dma_memcpy;
>  	engine->device_config =3D rz_dmac_config;
>  	engine->device_terminate_all =3D rz_dmac_terminate_all;
>  	engine->device_issue_pending =3D rz_dmac_issue_pending;
>  	engine->device_synchronize =3D rz_dmac_device_synchronize;
> +	engine->device_pause =3D rz_dmac_device_pause;
>=20
>  	engine->copy_align =3D DMAENGINE_ALIGN_1_BYTE;
>  	dma_set_max_seg_size(engine->dev, U32_MAX);
> --
> 2.43.0


