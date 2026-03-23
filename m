Return-Path: <dmaengine+bounces-9573-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHY0LYKSwGllIwQAu9opvQ
	(envelope-from <dmaengine+bounces-9573-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 02:08:18 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FB52EB570
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 02:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9785A30028F7
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 01:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BBF1E9B37;
	Mon, 23 Mar 2026 01:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="mca4tHc8"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011002.outbound.protection.outlook.com [52.101.125.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CEC78F2E;
	Mon, 23 Mar 2026 01:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774228092; cv=fail; b=g3ShJyGuFgjEAhUPLpzMq3OHotHIAr17Nzl4XxQ9v+Sosmpk2XV6zpA3A/tZDb9pkSdzxNxGpi1fu8BQU0Fws/5PPjpkQDFrkHgdjey9vJ+ocMZV55QLvRkU4cMDzBHtjLD8TGhc1BTGKZKOBjNviHzgExaQh076DISIszn3IAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774228092; c=relaxed/simple;
	bh=iopLQj1t3fWemVZjOeflhHO0x5jqMgDjFlQ+4zC4S8g=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=vEs1w/ksZfBihLDnGrLpVQK+okcmP6H6pTvqhRFD5R9HZN2S6Bif8qVMSi0o7/gTcqEYRck5lIlnqjVvWhDN+m8RdfZ7Wr0dRe8HdR7A895pseIXsThgdjE0vE1G5TbMHj0hwCqXsvFOBxPN23rwZb251l7gZtMmMBpvd3dqpAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=mca4tHc8; arc=fail smtp.client-ip=52.101.125.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VnxKN7/LquLLiPH9uG3I6F0Pxoj2ejfxR/+cl8OL3lx1HScgd1LZ3Lil3DViK4bhDZSqGCFFQJV6wvgMZKlrEjIz+yoTyHFsoGxX4bFxj3IRbrKEcwUXTaBDxCfdAiwvhz0XvHN7aW9WvSebs/C6D+5F9GIsxarpGLLOaHAd5V2hJZ6RnEhKkvyTofE0h3k9dUVyd9jN04nZ4byVDGdQJtcjaERNWm4yE8+JfX0Xm8zKWlfipwHA85FsdzmayfYWg+wPuM+9ZaU/KxUaqlW/hqx3gB6KGDESRtYVDG/zNO45vNlh2TZ2jE6fTbY1dDIQ3ndkzxEboiDQcvrfRP3dlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EnKIYOJqtQ7ZEXtQ2L3aGiLuF5Rqpmn2nTdP5nRVe/g=;
 b=N9EDKHqDkGrCFxAWCwoS81GXv2uqfxx9V0oh7dTuM32WgDiDo/UBdGmn6gc7oBBzwz9NzroMY+ueu5TbnRGw9AhSEXIdARLA0UM7meehrKKgn3CkeGwWywPC7t8Jg5PFOujvI8hBhaE6juBKBu2YAsRfCmTZPCySoDV2zwLA+sGC0WkxHiHjt+hlyyzLM63jCV9vyZU7L3YDz2xVsfBAo+o2O3eUpjLubdstEYYjqKjYiw9crMpL9yBFuL9S2DKoDK6iDUNQ6Ic5LNcXAwg8V2yYoHPbjqQE8LvbktNZ7Sd6KC7yan2cycmt1gyPC6n0Wq6vMT8gAuFmgK7fULdaSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EnKIYOJqtQ7ZEXtQ2L3aGiLuF5Rqpmn2nTdP5nRVe/g=;
 b=mca4tHc8cKk+VVX2agQY5fxZWH3JKqF+OcHKkEAoX7MHaZ9zMjw8iU89UqJtVrfydfqD8IlHNmj1zGMFsjaZzy3Vn6nksxh5a4CoqL7RWt+egwzKRCEeUbWrgy5+4puXf0umamm7gQwNugD0H8rauLp/E4LYI44IsCxsQmkc070=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TY3PR01MB11797.jpnprd01.prod.outlook.com (2603:1096:400:373::8)
 by OSCPR01MB15450.jpnprd01.prod.outlook.com (2603:1096:604:3b4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Mon, 23 Mar
 2026 01:08:07 +0000
Received: from TY3PR01MB11797.jpnprd01.prod.outlook.com
 ([fe80::1868:c915:c230:a383]) by TY3PR01MB11797.jpnprd01.prod.outlook.com
 ([fe80::1868:c915:c230:a383%5]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 01:07:58 +0000
Message-ID: <87jyv39wuj.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Vinod Koul <vkoul@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	John Madieu <john.madieu@gmail.com>,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH 10/22] ASoC: rsnd: Add DMA support infrastructure for RZ/G3E
In-Reply-To: <20260319155334.51278-11-john.madieu.xa@bp.renesas.com>
References: <20260319155334.51278-1-john.madieu.xa@bp.renesas.com>
	<20260319155334.51278-11-john.madieu.xa@bp.renesas.com>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Mon, 23 Mar 2026 01:07:56 +0000
X-ClientProxiedBy: OS7P286CA0021.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:26d::17) To TY3PR01MB11797.jpnprd01.prod.outlook.com
 (2603:1096:400:373::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3PR01MB11797:EE_|OSCPR01MB15450:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b3c30f3-62ad-4a58-c007-08de88789ee1
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|56012099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	yV0g4nSmlFX2qxF/onmtlNvL/g0uX8R4Ud21y/AcR98F+fplj6Ni2socqlcBV4lvHPJcyxVXv3b+Pw6WV1YAl6LCgSuq/5/PXkRmIu4sRxsYpK4REJ0zHhdeVaGiwmMXgK6HaB/SqeQSjw7u4I29qy3xdzEK77SBnWpNy04z44SGzx/8eRZRF1MYP/BCJkrYOSRt+A3h/9JZWhB87GYTmxuykZPb2SDi70K+7kZ82rk/LJNAAD87K3mVSjWNLyB9t4S27y8AblP+fAU0JSohBNZv5PJ2+1odMqpJDbN3MTz1icLyXorK8UuQHsMNOnkQRghJ1sFbIP0zYa4C22nzEnSy8bCH50YuAwrcEA9g91UtcsF0erzMo7fJ0lhyS/hDYve6cKztvpjsIDE2H/JjUhvuviWWNKxFe8JnPQWS/BR5xSQhsWICtH/fmmgKm3iD+IesI3VObCAv17ZWn5+QkI44AVtFPi49w0Nv9A/XYxiJsda8h3rYyd1mx/7jmDIkma0rK5yK7p9x95Mgzd/RMtGUJyNSUESNVfF865zPIHHOx3FlCTTCVN9FO1qqHL1vaTqDWazNVxyM0MRrloyiAAGBzVZPcy+64abaNovUz3LxgmbX8hBkJDtDjITlKMJp651YFcOkYxerhH2UgMmfDTHq2OWr9CVolj8d/ZEI0TH0IZcv8Wkte89bbXkbNdFvaiXKjU1IWsYUApkl9GcR7x5B2uYRMAKJRKHrV7yxrQYPgxQziJUZRR+T1Mjwefg3m3a4dPx3NxgE+iR3osfVO0GcMr91afkT7Q7lJsMwe5s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11797.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(56012099003)(22082099003)(18002099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JmqAoAo7PWlyJRQ25iGuO4yjrccASxElLBpWHJZIvXjW1LRFvJZJVs+bCrJS?=
 =?us-ascii?Q?E1QEI4ZQBc/IozsnOsBvUiY5HbLglB+4lsB2KfRMYeeIDsY0ENF6TeHU19xo?=
 =?us-ascii?Q?KYjMBmcs6MlyjTyDYNYUvqZThtEYqQ/q2+uWSbbjE/zS85QA58R7zXenSwZx?=
 =?us-ascii?Q?TYI1mupCE0zN6WKMTKeIxauoA58HjLgFKuKKr7gf3iMK96wgzW9VM6e1za34?=
 =?us-ascii?Q?6LO6z/KRY73ba/M/mKTOJz5sTXrCgHcb+IO9xdVX7G2UZfLWpeK9e7RiBzwB?=
 =?us-ascii?Q?zsvUq37S4Ym8kX2RFHwMH4QcYgg2tet/v06RbK7BiwEJY8ommPX3i6S9F47a?=
 =?us-ascii?Q?QiTc7tuV7PzQ3uy+87wHV7S9uOXsFTtWMRp6J19EQmCl2VfUtg9VX3UU1ztC?=
 =?us-ascii?Q?9jBMn8pt41i+N0sexrR8EYqChSkGMayBIQKGzVwH6YWmI8A8gQuQPipJ/IPK?=
 =?us-ascii?Q?b6Xj1p4av8fp1m1yHS/5jdwH5wvyySD8Wap20tN1mTnI04DQ6GsDABDCE8q+?=
 =?us-ascii?Q?2dsXlRP45ZPc+4zSxaWVnplwYYRuk7pDU7fwU3Z+Gypuxv5uElytw4FAOD/c?=
 =?us-ascii?Q?vuV8TbUpFnYOBV4WwRNfj68S2b7cEL1ubF1EyYd5ZgPPFxS5gPd4DuESWKAm?=
 =?us-ascii?Q?7ohVemhfRVj5uLXvJG6KDHnlzmOdUj4ZtwFP9ItDdH5QRs8LqCN+Kdex+aar?=
 =?us-ascii?Q?OD449UGMK/7BKkXK0OL5Unfne9Qc2/4qrstHy9TbAVwkihsBVp7JFD6uh0oE?=
 =?us-ascii?Q?zY2ZtUW/zz4HPrW4C0Hgi4UnKuawPetE/boQu6RChjbyyH3rXC1hy4OEiEhF?=
 =?us-ascii?Q?XgxQWkDafngYKPhuuKAy96xJRrHwHGx3p9hkFNiCDufAbGv3nY+J9ZXUz2VU?=
 =?us-ascii?Q?oiRA3zZNvh7OyYBTQtwSKBtXqucanQ0hYsxuv03WHFbT/Tmim63f4BIRAxQr?=
 =?us-ascii?Q?Y9xzNKMq+68M6977QeCubdY5Y6HpWxO4We5WRu2vJKXHuo3AJcJ0WUgElp+v?=
 =?us-ascii?Q?blYSahj6QdvSprVupUmgFrqB8l0Iygu9zcEyq8iMIr021Fxp/LOu73WOa4XQ?=
 =?us-ascii?Q?PREQYIr6ra1KM8wh77YLg2q8hYOQHLAsyxDSX1cOtxV0IZBRwZHaVD2aFw7a?=
 =?us-ascii?Q?Sg3Q/m+XxzraHeKCuUUTUTXphad/3Y0DVGQ6ojvHt0hd2agyasjxQ5KcVs9V?=
 =?us-ascii?Q?usJlrvrtCqbAFhgEoAXWwTdzzrYR/xfb+EBbkDGnHWeiSXyd8gq2k93MAXq6?=
 =?us-ascii?Q?0h5ro5KIPc13nz/Sl593vrhP7BQAdQxY6C9mGMh5Cll9WQIbWlfhw2AEiGlH?=
 =?us-ascii?Q?/N42MrcpzmxzO4knAaXShu3ws+1qVZE28EmSPPUUy/omUo4AFslI53GvPsth?=
 =?us-ascii?Q?5MQso+xoECozccDstv/qOI699nPxdXNrQY8TJgekX+0hz/6DNF/V5Z2M9uVd?=
 =?us-ascii?Q?/nydk2Cyp6AeEnmjOafoUAQb7+9XZVhZTXsAMI0P7pE2ga2071MRkSzJybYW?=
 =?us-ascii?Q?ElDLKqVVgEBcsHmsEEsZMNZIXyaVnNnK9Cu0bq2Aa1g7V3pucivwIqst7vgu?=
 =?us-ascii?Q?jYaV7eaT5VqMlPJ6VyWqVME+iF8hny2OL3Ml8s1N4kVB87PbsGr6YS2rK+DW?=
 =?us-ascii?Q?b7zk3DobFwk3llbQmGlDFN7RFg2BcWb/1liG/H4fA+Gk35tXxDahQ4nFsUJ6?=
 =?us-ascii?Q?rN6FrYf0sWkfo89lfxq7gL65FV/LvbyXFq9GXBNXvCrRk/cpXs6D7Xhl3LQO?=
 =?us-ascii?Q?yQAp273bmpGAcruPR0NHlNg3Rky0ilTQNdKCSIuJsAqoqw84AxCg?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b3c30f3-62ad-4a58-c007-08de88789ee1
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11797.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 01:07:57.9084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Chc8S7SlkIGRs4X/CNWgrbyIpUBYC1WAdi+Xdkb/+tOb3zQ7q5xuvkpSve8qdZer9KHmJxN2bo0eCLTnWGVxnAN7SU6caqqLFgdNULmLXbF+jxXe89GtUJMeiIGjg7WU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB15450
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_DKIM_ALLOW(-0.20)[renesas.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9573-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2600:3c15:e001:75::12fc:5321:from];
	RCPT_COUNT_TWELVE(0.00)[27];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[glider.be,kernel.org,baylibre.com,gmail.com,perex.cz,suse.com,pengutronix.de,tuxon.dev,bp.renesas.com,renesas.com,vger.kernel.org];
	DKIM_TRACE(0.00)[renesas.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuninori.morimoto.gx@renesas.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,renesas,dt];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2603:1096:400:373::8:received,100.90.174.1:received];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:dkim,renesas.com:email,renesas.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B0FB52EB570
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Hi John

Thank you for your patch

> RZ/G3E has different DMA register base addresses and offset calculations
> compared to R-Car platforms, and requires additional audmac-pp clock and
> reset lines for Audio DMAC operation.
> 
> Add RZ/G3E-specific DMA address macros and audmac-pp clock/reset support
> using optional APIs to remain transparent to other platforms.
> 
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> ---

I think it include many features in 1 patch.
You should separate it into each features.

> diff --git a/sound/soc/renesas/rcar/dma.c b/sound/soc/renesas/rcar/dma.c
> index 68c859897e68..d3123ae3b402 100644
> --- a/sound/soc/renesas/rcar/dma.c
> +++ b/sound/soc/renesas/rcar/dma.c
> @@ -496,24 +496,71 @@ static struct rsnd_mod_ops rsnd_dmapp_ops = {
>   *	SSIU: 0xec541000 / 0xec100000 / 0xec100000 / 0xec400000 / 0xec400000
>   *	SCU : 0xec500000 / 0xec000000 / 0xec004000 / 0xec300000 / 0xec304000
>   *	CMD : 0xec500000 /            / 0xec008000                0xec308000
> + *
> + * 	ex) G3E case
> + *	      mod        / DMAC in    / DMAC out   / DMAC PP in / DMAC pp out
> + *	SSI : 0x13C31000 / 0x13C40000 / 0x13C40000
> + *	SSIU: 0x13C31000 / 0x13C40000 / 0x13C40000 / 0xEC400000 / 0xEC400000
> + *	SCU : 0x13C00000 / 0x13C10000 / 0x13C14000 / 0xEC300000 / 0xEC304000
> + *	CMD : 0x13C00000 /            / 0x13C18000                0xEC308000
>   */
> -#define RDMA_SSI_I_N(addr, i)	(addr ##_reg - 0x00300000 + (0x40 * i) + 0x8)
> -#define RDMA_SSI_O_N(addr, i)	(addr ##_reg - 0x00300000 + (0x40 * i) + 0xc)
>  
> -#define RDMA_SSIU_I_N(addr, i, j) (addr ##_reg - 0x00441000 + (0x1000 * (i)) + (((j) / 4) * 0xA000) + (((j) % 4) * 0x400) - (0x4000 * ((i) / 9) * ((j) / 4)))
> -#define RDMA_SSIU_O_N(addr, i, j) RDMA_SSIU_I_N(addr, i, j)
> +/* RZ/G3E DMA address macros */
> +#define RDMA_SSI_I_N_G3E(addr, i)	(addr ##_reg + 0x0000F000 + (0x1000 * i))
> +#define RDMA_SSI_O_N_G3E(addr, i)	(addr ##_reg + 0x0000F000 + (0x1000 * i))
> +
> +#define RDMA_SSIU_I_N_G3E(addr, i, j) (addr ##_reg + 0x0000F000 + (0x1000 * (i)) + (((j) / 4) * 0xA000) + (((j) % 4) * 0x400) - (0x4000 * ((i) / 9) * ((j) / 4)))
> +#define RDMA_SSIU_O_N_G3E(addr, i, j) RDMA_SSIU_I_N_G3E(addr, i, j)
> +
> +#define RDMA_SSIU_I_P_G3E(addr, i, j) (addr ##_reg + 0xD87CF000 + (0x1000 * (i)) + (((j) / 4) * 0xA000) + (((j) % 4) * 0x400) - (0x4000 * ((i) / 9) * ((j) / 4)))
> +#define RDMA_SSIU_O_P_G3E(addr, i, j) RDMA_SSIU_I_P_G3E(addr, i, j)
> +
> +#define RDMA_SRC_I_N_G3E(addr, i)	(addr ##_reg + 0x00010000 + (0x400 * i))
> +#define RDMA_SRC_O_N_G3E(addr, i)	(addr ##_reg + 0x00014000 + (0x400 * i))
> +
> +#define RDMA_SRC_I_P_G3E(addr, i)	(addr ##_reg + 0xD8700000 + (0x400 * i))
> +#define RDMA_SRC_O_P_G3E(addr, i)	(addr ##_reg + 0xD8704000 + (0x400 * i))
> +
> +#define RDMA_CMD_O_N_G3E(addr, i)	(addr ##_reg + 0x00018000 + (0x400 * i))
> +#define RDMA_CMD_O_P_G3E(addr, i)	(addr ##_reg + 0xD8708000 + (0x400 * i))
> +
> +/* R-Car DMA address macros */
> +#define RDMA_SSI_I_N_RCAR(addr, i)	(addr ##_reg - 0x00300000 + (0x40 * i) + 0x8)
> +#define RDMA_SSI_O_N_RCAR(addr, i)	(addr ##_reg - 0x00300000 + (0x40 * i) + 0xc)
>  
> -#define RDMA_SSIU_I_P(addr, i, j) (addr ##_reg - 0x00141000 + (0x1000 * (i)) + (((j) / 4) * 0xA000) + (((j) % 4) * 0x400) - (0x4000 * ((i) / 9) * ((j) / 4)))
> -#define RDMA_SSIU_O_P(addr, i, j) RDMA_SSIU_I_P(addr, i, j)
> +#define RDMA_SSIU_I_N_RCAR(addr, i, j) (addr ##_reg - 0x00441000 + (0x1000 * (i)) + (((j) / 4) * 0xA000) + (((j) % 4) * 0x400) - (0x4000 * ((i) / 9) * ((j) / 4)))
> +#define RDMA_SSIU_O_N_RCAR(addr, i, j) RDMA_SSIU_I_N_RCAR(addr, i, j)
>  
> -#define RDMA_SRC_I_N(addr, i)	(addr ##_reg - 0x00500000 + (0x400 * i))
> -#define RDMA_SRC_O_N(addr, i)	(addr ##_reg - 0x004fc000 + (0x400 * i))
> +#define RDMA_SSIU_I_P_RCAR(addr, i, j) (addr ##_reg - 0x00141000 + (0x1000 * (i)) + (((j) / 4) * 0xA000) + (((j) % 4) * 0x400) - (0x4000 * ((i) / 9) * ((j) / 4)))
> +#define RDMA_SSIU_O_P_RCAR(addr, i, j) RDMA_SSIU_I_N_RCAR(addr, i, j)
>  
> -#define RDMA_SRC_I_P(addr, i)	(addr ##_reg - 0x00200000 + (0x400 * i))
> -#define RDMA_SRC_O_P(addr, i)	(addr ##_reg - 0x001fc000 + (0x400 * i))
> +#define RDMA_SRC_I_N_RCAR(addr, i)	(addr ##_reg - 0x00500000 + (0x400 * i))
> +#define RDMA_SRC_O_N_RCAR(addr, i)	(addr ##_reg - 0x004fc000 + (0x400 * i))
>  
> -#define RDMA_CMD_O_N(addr, i)	(addr ##_reg - 0x004f8000 + (0x400 * i))
> -#define RDMA_CMD_O_P(addr, i)	(addr ##_reg - 0x001f8000 + (0x400 * i))
> +#define RDMA_SRC_I_P_RCAR(addr, i)	(addr ##_reg - 0x00200000 + (0x400 * i))
> +#define RDMA_SRC_O_P_RCAR(addr, i)	(addr ##_reg - 0x001fc000 + (0x400 * i))
> +
> +#define RDMA_CMD_O_N_RCAR(addr, i)	(addr ##_reg - 0x004f8000 + (0x400 * i))
> +#define RDMA_CMD_O_P_RCAR(addr, i)	(addr ##_reg - 0x001f8000 + (0x400 * i))
> +
> +/* Platform-agnostic address macros */
> +#define RDMA_SSI_I_N(p, addr, i)	rsnd_is_rzg3e(p) ? RDMA_SSI_I_N_G3E(addr, i) : RDMA_SSI_I_N_RCAR(addr, i)
> +#define RDMA_SSI_O_N(p, addr, i)	rsnd_is_rzg3e(p) ? RDMA_SSI_O_N_G3E(addr, i) : RDMA_SSI_O_N_RCAR(addr, i)
> +
> +#define RDMA_SSIU_I_N(p, addr, i, j) rsnd_is_rzg3e(p) ? RDMA_SSIU_I_N_G3E(addr, i, j) : RDMA_SSIU_I_N_RCAR(addr, i, j)
> +#define RDMA_SSIU_O_N(p, addr, i, j) rsnd_is_rzg3e(p) ? RDMA_SSIU_O_N_G3E(addr, i, j) : RDMA_SSIU_O_N_RCAR(addr, i, j)
> +
> +#define RDMA_SSIU_I_P(p, addr, i, j) rsnd_is_rzg3e(p) ? RDMA_SSIU_I_P_G3E(addr, i, j) : RDMA_SSIU_I_P_RCAR(addr, i, j)
> +#define RDMA_SSIU_O_P(p, addr, i, j) rsnd_is_rzg3e(p) ? RDMA_SSIU_O_P_G3E(addr, i, j) : RDMA_SSIU_O_P_RCAR(addr, i, j)
> +
> +#define RDMA_SRC_I_N(p, addr, i)	rsnd_is_rzg3e(p) ? RDMA_SRC_I_N_G3E(addr, i) : RDMA_SRC_I_N_RCAR(addr, i)
> +#define RDMA_SRC_O_N(p, addr, i)	rsnd_is_rzg3e(p) ? RDMA_SRC_O_N_G3E(addr, i) : RDMA_SRC_O_N_RCAR(addr, i)
> +
> +#define RDMA_SRC_I_P(p, addr, i)	rsnd_is_rzg3e(p) ? RDMA_SRC_I_P_G3E(addr, i) : RDMA_SRC_I_P_RCAR(addr, i)
> +#define RDMA_SRC_O_P(p, addr, i)	rsnd_is_rzg3e(p) ? RDMA_SRC_O_P_G3E(addr, i) : RDMA_SRC_O_P_RCAR(addr, i)
> +
> +#define RDMA_CMD_O_N(p, addr, i)	rsnd_is_rzg3e(p) ? RDMA_CMD_O_N_G3E(addr, i) : RDMA_CMD_O_N_RCAR(addr, i)
> +#define RDMA_CMD_O_P(p, addr, i)	rsnd_is_rzg3e(p) ? RDMA_CMD_O_P_G3E(addr, i) : RDMA_CMD_O_P_RCAR(addr, i)

I think you want to create new rsnd_rzg3e_dma_addr() and call it,
instead of makes existing code complex.

+ static dma_addr_t rsnd_rzg3e_dma_addr(...)
+ {
+	...
+ }
...
  static dma_addr_t rsnd_dma_addr(...)
  {
	...
	else if (rsnd_is_gen4(priv))
		return rsnd_gen4_dma_addr(...);
+	else if (rsnd_is_rzg3e(priv))
+		return rsnd_rzg3e_dma_addr(...)
	else
		return rsnd_gen2_dma_addr(...);
}

> @@ -860,6 +917,56 @@ int rsnd_dma_probe(struct rsnd_priv *priv)
>  		return 0; /* it will be PIO mode */
>  	}
>  
> +	/*
> +	 * audmac_pp clock/reset management strategy:
> +	 *
> +	 * Unlike other modules (SSI, SRC, etc.) which have their own dedicated
> +	 * clocks, all DMA modules share the single audmac_pp clock/reset.
> +	 * Managing it per-stream or per-DMA-module causes
> +	 * reference count imbalances:
> +	 *
> +	 *   - rsnd_mod_init() does clk_prepare_enable() then clk_disable(),
> +	 *     leaving prepare_count=1 per module
> +	 *   - With N DMA modules sharing the same clock handle, prepare_count=N
> +	 *   - suspend does single clk_disable_unprepare() (-1)
> +	 *   - resume does single clk_prepare_enable() (+1)
> +	 *   - Result: prepare_count leaks on each suspend/resume cycle
> +	 *
> +	 * Per-stream management (iterating DMA modules in suspend/resume) is
> +	 * not worth the complexity:
> +	 *
> +	 *   - No power benefit: audmac_pp is needed whenever ANY stream is
> +	 *     active, and every stream uses DMA, so it's essentially always on
> +	 *   - Architecture mismatch: DMA modules live in io->dma, not in a
> +	 *     priv array -- no clean way to iterate like SSI/SRC/DVC
> +	 *   - Shared handle problem: all DMA modules point to the same clock,
> +	 *     so iterating would call clk_unprepare() N times on one clock
> +	 *   - Would require manual refcounting ("enable on first stream,
> +	 *     disable on last") -- reimplementing what clk framework does
> +	 *
> +	 * The correct approach is to treat audmac_pp as always-on infrastructure
> +	 * (same pattern as clk_adg), managed globally:
> +	 *   - Probe: acquire + enable (via devm_clk_get_optional_enabled)
> +	 *   - Suspend/Resume: toggle in core.c rsnd_suspend/rsnd_resume
> +	 *   - Remove: devm cleanup
> +	 *   - DMA modules: pass NULL clock/reset to rsnd_mod_init()
> +	 *
> +	 * Use devm variants that handle deassert/enable automatically.
> +	 * Order: reset deasserted first, then clock enabled.
> +	 */
> +	priv->rstc_audmac_pp =
> +		devm_reset_control_get_optional_exclusive_deasserted(dev, "audmac_pp");
> +	if (IS_ERR(priv->rstc_audmac_pp)) {
> +		return dev_err_probe(dev, PTR_ERR(priv->rstc_audmac_pp),
> +				     "failed to get audmac_pp reset\n");
> +	}
> +
> +	priv->clk_audmac_pp = devm_clk_get_optional_enabled(dev, "audmac_pp");
> +	if (IS_ERR(priv->clk_audmac_pp)) {
> +		return dev_err_probe(dev, PTR_ERR(priv->clk_audmac_pp),
> +				     "failed to get audmac_pp clock\n");
> +	}

rsnd_dma_probe() is common fucntion.
Is above possible to keep compatible with other SoCs ?

And, we are already using "audmacpp".
I think it time to update rsnd_dma_probe() like below ?

	int rsnd_dma_probe(...)
	{
		if (rsnd_is_gen1(..))
			return ...
		else if (rsnd_is_gen2(...) ||
			 rsnd_is_gen3(...))
			return ...
		else if (rsnd_is_gen4(...))
			return ...
		else if (rsnd_is_rzg3e(...))
			return ...
		...
	}

