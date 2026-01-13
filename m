Return-Path: <dmaengine+bounces-8238-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66094D1B28D
	for <lists+dmaengine@lfdr.de>; Tue, 13 Jan 2026 21:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 976003022187
	for <lists+dmaengine@lfdr.de>; Tue, 13 Jan 2026 20:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD3735EDD1;
	Tue, 13 Jan 2026 20:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="d5wvD7Ik"
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011055.outbound.protection.outlook.com [52.101.70.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A4728467C;
	Tue, 13 Jan 2026 20:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768335002; cv=fail; b=L0F7lh3F0XVzMdCSqS10fO7SpdT7vO2HaVrzZiTQAh5Q9QDu0E69LmThd7xrUWSYdkhK18kMCFoGSLEyWJ2ACz+fCTaw6ozKDSZ4FDOJSp61vfKOUIUeYwEK9+dInpMDAuSf536RpEOWw4EJHgWDKwixwaEOHtA7YBqmIL5DbPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768335002; c=relaxed/simple;
	bh=YeY0pX31FUs4Bj8QlRzgZ82UFho7yXnkZtqDyO6pGlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YtzGj36pHvzIruqWv2vbEURrlYnmnV1LaVMrbcTuXkxNochhF6ToLC0Xi92I0K0K+RE8M8hWx1ny54VRsEkyMr0pcqThR7BNUg1fap67RigjaQlUTao7wo8HJVzJtSaksi98sg13ug9rcHPAVmpbz/PqkMr2OiFZhQ7F0SUivj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=d5wvD7Ik; arc=fail smtp.client-ip=52.101.70.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UADj3YKglxf8Zs95BAtUY31pzTqRJP8kSpAb+SCDU/+cGvyYed+3LblQiy8V/wPSxcHMsa5zWr0zc2ziVaWCMeG/x0bU0kFyYNW1duKe4+in/Z0M0lX9njPBM9DuNH+mSZWuG5Fm8vDanBU+jhAX9LvO5Iw1a13L4eK9MsHY4itJabOPS6i3brmOImP7o0yOa9zV7tMsP9W3ATUERvoUkAK9bGAhykqjJheMrEMoWLuYPqFzxFoZCk3tHtOJgY25NE3OKSouNdY2dOd8Q3Ze64g1+WK6Mjte+ATVUhr+Dc5NYzgQGgXfA8iI+KJYtlOH5PypZpNea6uZzKhdPjwD5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B52LdnTZixGUO+4Qmgc63C9FWNbWvOHkCS859ksJVRA=;
 b=hs+ElQaTHm03/8Mejz9hNL24WzpWe+y2VYVlzf60sNCeisP0Z2c4JaxvmsVO87c3eSiHwFSbu6kC4DtaQy75o3R7DaWiDC9yby4Lg+GW8v287GaCujDbLIv+s88ciR9UxsMK1vPyE0mRHUgVdOkBFEUALezt0hXYOEN+5oRen6IprZAeJALLQ9h+munPDQfVLgRjOgg/C2IHGboPwXamAea5q1RNf+Zyi09aoAjY8/JgFUqxGVDbD5u6393RbJtvGjmPJqa6YUn7jMOtZIzOJFx29mM09mjJp/XyjPVIwz2rGFmH7JANk3zU3qBq8EqzmzcUIUApp8UWK481LD/euA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B52LdnTZixGUO+4Qmgc63C9FWNbWvOHkCS859ksJVRA=;
 b=d5wvD7IkpAGLxjhXfKhRhSDtZe3gitCjs2LT9Km7ed6APT58PFmdAfD6mxe8ck22CnKgGaJRU5hdI3OXQuvGrzQqcYBUzyzrS4vdjDs4J8uQse1hhdnF0KmZ3EubWze0I3ooh9FCkcXAwYPubDx950ePsGos/fI2t2/a2h1zCsjl++wWjXunymN0ZfLce9tbGIv7kpPiI4H57EhZmCdqB2L4s4HPubxuWf0N9boxHiJDo9P/ZUlOZs1vcBWEVb2VQnGnd3nQVD2DV25Vlmnxpf8VuaqqhiH8312HSoat5yTJLkFZ6LJc8vy1W0ck3qe51wnA/HwhIoo3NcVPLA8Zgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by DU4PR04MB11816.eurprd04.prod.outlook.com (2603:10a6:10:626::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 13 Jan
 2026 20:09:57 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9478.004; Tue, 13 Jan 2026
 20:09:57 +0000
Date: Tue, 13 Jan 2026 15:09:49 -0500
From: Frank Li <Frank.li@nxp.com>
To: Jared Kangas <jkangas@redhat.com>
Cc: Vinod Koul <vkoul@kernel.org>, Alison Wang <b18965@freescale.com>,
	Arnd Bergmann <arnd@arndb.de>, Jingchang Lu <b35083@freescale.com>,
	imx@lists.linux.dev, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: fsl-edma: don't explicitly disable clocks in
 .remove()
Message-ID: <aWamjRXwLuirU465@lizhi-Precision-Tower-5810>
References: <20260113-fsl-edma-clock-removal-v1-1-2025b49e7bcc@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113-fsl-edma-clock-removal-v1-1-2025b49e7bcc@redhat.com>
X-ClientProxiedBy: PH8PR21CA0001.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::25) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|DU4PR04MB11816:EE_
X-MS-Office365-Filtering-Correlation-Id: dee8e13b-4bf5-405d-9cc1-08de52dfb95c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|19092799006|366016|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XvpHSTiR/SkhIrYFrW9uTCoRQJl4YWBHfQp5KqiDR7IecoB9eSpP5NEXBv9G?=
 =?us-ascii?Q?KWbHUnYJvUcir0z5LT7Q71cTHJvPF2n/H64UN614KG9ulLjpo68mhbtYuW45?=
 =?us-ascii?Q?G0hnyiV2G6G2fC6PuHwvaMsV7gPia/2Fndefz3M8Y7sDYSSAVygt6qOvG6a5?=
 =?us-ascii?Q?c1Vc3uuUFRDtZ2Xa+tvaucMb7wJVdpycpu6BaQS3tT/ow524k6ytFF8Uqx6L?=
 =?us-ascii?Q?iVDRQfKSTItGFjtRHmjdV4HI/9TM2dWEHAS2F6Rr+jISEjd58uBLW8mR992l?=
 =?us-ascii?Q?2xxhepl3Jl3wjXzvPGi2y2QaFCOl3HlGGVYr5B0sTOd4yuJJX7hbSMPK2i28?=
 =?us-ascii?Q?Kl/sTgOiitbgSFcZn3y5YKPdkTXyfHsckpapFji8lP7brENL3F2VEKVWUVS1?=
 =?us-ascii?Q?PyhGZAKY6/DkkMLxMH5aZbKGHXuYIJlBcsOVBmmH0gq9koWkHKslr7wuS++L?=
 =?us-ascii?Q?ghR0oozr1HS7kKAA55WmTSx0OgchdzEZ7caLnyXfrEcwGMDI6c04t090d7hc?=
 =?us-ascii?Q?ZUqonE0o16WHYQLrcQ5xyErOmIFiG7nEprehdAzzxJLH6gotvpAWZYwJ0gMu?=
 =?us-ascii?Q?73Lh3yxIprN1vrUemHsx2okY6zT9gDp+ABDxHC23C2FpfnvPturwgD/NRJum?=
 =?us-ascii?Q?ydrkHymJl1XNor2+99qf4zTgT42gYYpPlfUKCXlxXt4aMfJBsTM3AsSQJHJj?=
 =?us-ascii?Q?nKalEOocCnj707Mlv/w5qlGstCNGKbWvUvK2Eoq0N93axM2rr3bmnvTsddGL?=
 =?us-ascii?Q?iywPUb+cj7AYnN2vXzGDDOcxExKeEmuEMaozEe6oON2Eiu3hM5LjEm098fNg?=
 =?us-ascii?Q?VTbDqJmSWmTKCx57ar8X4AYjP4NuuswMhh0MFScp+IRddN25dOskK/lNVkoY?=
 =?us-ascii?Q?2XPkDORDog0ok1mP11WvmbECIu5bvzMccdkosdGRqpsnnzXpFGuCNO1jxwoo?=
 =?us-ascii?Q?r8sA5D0INwKVo1hQao5+1KQ+VPIwWa3o2SRYbgRTO3nbaNhx3dlLsRNiq5uN?=
 =?us-ascii?Q?9C4sD4KgUlobNYql539/Wmi7nP5LW0Hy9SW4N1QhO9AioMo+je3LKrgcxEwQ?=
 =?us-ascii?Q?8uho3xoCXDFbdVJ/f12Q36DdK84SWSzpo53G5ZvB6FhfzKpPtYJ7ZNNSfi91?=
 =?us-ascii?Q?mDG57m/41YQuftW/J7tWSYpT2qSDKheABMlLWpt0kEW9qMheNB/H6DHK4+fe?=
 =?us-ascii?Q?SKGF+M/ImlPyQZb3A0y+Ql6Lp8rn6xokryR0+PjxY0EgWCobbgNIAjHNY0GI?=
 =?us-ascii?Q?SbZlvf0RmBR/LN59f+ajFWJV8vfcXqs6+KQizEtWkfhFuxKI1Wz4Rk1rTbq2?=
 =?us-ascii?Q?9BYN9MgSPoaUUTaIc6Hv9cfoylBozIcywOj+8D8WLB7PeAGwcqUdZuvvt6hZ?=
 =?us-ascii?Q?xPa2+q3S6gXGLHXvPz7kt0PXpbpa6b4TRoAnfHVQdYviVr22w+xgrmsDnGlF?=
 =?us-ascii?Q?7N5gPvyMEHcVb8Vjf8vdQZmBkaFRt9V+U+2V+spJzgpl/rq35eH10TNsKwR2?=
 =?us-ascii?Q?5VI3k2AdeXD2PmjQSMwxAUEaxcWJzw5y2CMc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(19092799006)(366016)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4LLnyDW/VM1x++D0rNxvj+Ym2LeJNhe8dRZn1mHArjCfS2zM66ttmxanZ3ny?=
 =?us-ascii?Q?XRfWRFyOq1T+SoyieEey85IEr1hPVooUkZ/nYbeKaBDaBCI9y9eItbihIGMa?=
 =?us-ascii?Q?RIPHWv4r8EbDGOgEpJN8KtNv7WKoGKUu1tYNaDXF8JnwNh+XcKg0ruxPFnjA?=
 =?us-ascii?Q?BWn2bzn3HL9GmniEmWnJoBMrRYDByzy/4Cf2hXd64+jH4Fy6r/vrIqGG6esN?=
 =?us-ascii?Q?vSQLzBqHQUsUwkqqSm/Xs4vh6JQ3mDHYYj/GT8nY/H0tqIsjaGjrlQ9PuApm?=
 =?us-ascii?Q?p+D+7oNsXhepfbbslIp8YkxDvKBfdexsDcoWOkQ96Q7wb9nKVaPHz4ffxNML?=
 =?us-ascii?Q?+fE0j79KORmVoPaTdcXUw/ERAv4OCaKsOPF/VaKiceQNJdBFd09InPAiMXIB?=
 =?us-ascii?Q?V1lwY53914hd607j3cKhAeLMBGDrDQUxLHemlY3sTsM0ZPP2HC8czIbsGHCt?=
 =?us-ascii?Q?ExoNKUQzwLuF2wwvGPJGhYllAQUHWyN0gqsszuVHOZPFxowQaIkfnPWk6wCX?=
 =?us-ascii?Q?14VxetQO+0IajiwcDg2Q3KGxGoTjU7BMgC5CGqmZZfO0rMXasXsu44Girkwk?=
 =?us-ascii?Q?7qCaaY6KPknBfZhqtGRht2cHwL6efnF0g2fIGx20VeKP2BS5zaGNtd/yjogX?=
 =?us-ascii?Q?pRAYh4oy8b5DxWCiO/a8zLo/MdVRtvIt4YduZTvPMG0g9kr8kvBm6dPaT8Uq?=
 =?us-ascii?Q?WRShIsbt35XJKGYeQHpLVFEZ5SoVoDUdYcd1ELCu8yy/mQlQ24RmC6WR19Ga?=
 =?us-ascii?Q?S7awJ3jog4zTz2Jzd44DVUCcwTwH+L4HbjbN6DDnrpJ+DOhxm3jy1EeGHej6?=
 =?us-ascii?Q?QwbJHBheMzQrCMdRzP07wBlvC+ml7iuOjbCPwm5qZQiwxAgvVyYBrwhtgv/K?=
 =?us-ascii?Q?Nz1X7KXxSG11JskjCGMOHOU2PqmOlJiqMiLteLmOLyUa8HX90w8+0q8cqiKD?=
 =?us-ascii?Q?0ahDY3c2lJQotFi+6tkr60DwfV1aX9rccx1qvuVZZcJEwYVL+a4M8y6Z7Rzs?=
 =?us-ascii?Q?R2jjQ3M4EEwu1uO8kR5rRyJWbw7RFWw+GlI455jaQvoUCLi4/gn2bybpCCMm?=
 =?us-ascii?Q?zTgQev/PjIqBUZtdWjakGczFTjr3IoCAp7LQ72wqkVwZLAlDwXV7PmgvNcEU?=
 =?us-ascii?Q?oiZpb2hricgG3HL0hIWkFNfwIbVsCw6ONl7jSU5mNVdiELj7gBc2blGXzQqp?=
 =?us-ascii?Q?6XIpa/AMWdsSmVFXGLeiXv/WTLdRpggH2Q/3Bt6cVm313gfVQKoAn15h1Acy?=
 =?us-ascii?Q?h1i6CA/1Gbek2cyvoJkuHETU/VBPev8eqkTFMAn57XixhBfPQVc7v5c8pvb5?=
 =?us-ascii?Q?VxDIbQOF1lvE4QpkwkoncHDDtdKGSFcFDwNOlLp2peU+D84AY/6id79nAfmJ?=
 =?us-ascii?Q?mWeH9yw9fmy+XocT7SmE0Hi8SNtwo86Tn4BRP6V+PP/s46bh/dzCEXwLQ8k4?=
 =?us-ascii?Q?XoRNj3X9K3nDY9LDH3XyEgNh5KV5P4eWn7KtAoM4jhpWcIdO2pX0AcMfKVHk?=
 =?us-ascii?Q?lzr9ElBf6CvkjI+0ekLZq40vD4XhAmWuCDu7UVI5uUha/R2ynrITOoFRBtSC?=
 =?us-ascii?Q?+nSCYRz9IChNuXB5zjMJPxBigXkcZZ9jAPUTaCxdvmOKB7REvpD+v3DZ1Y1B?=
 =?us-ascii?Q?dH3SRkRnp/YoRCkyJ4LfDOoMc9S19CadtpyEPkZUCe5KiT8tzI8mjeKmLILT?=
 =?us-ascii?Q?Q4gn0CKlxZhdJwZFW7Ff/cbV0+9eRNuLRgZBNP6ft0wiOwoc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dee8e13b-4bf5-405d-9cc1-08de52dfb95c
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 20:09:57.6076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BDtTjg9Bm6kt8ebJ4GO80fVSMr/BruJorLAfzx6zXGQaWw53cTcxYXozeCdJIlSlB7Jn+Jm1xASvs/HEMiXRWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11816

On Tue, Jan 13, 2026 at 11:46:50AM -0800, Jared Kangas wrote:
> The clocks in fsl_edma_engine::muxclk are allocated and enabled with
> devm_clk_get_enabled(), which automatically cleans these resources up,
> but these clocks are also manually disabled in fsl_edma_remove(). This
> causes warnings on driver removal for each clock:
>
>         edma_module already disabled
>         WARNING: CPU: 0 PID: 418 at drivers/clk/clk.c:1200 clk_core_disable+0x198/0x1c8
>         [...]
>         Call trace:
>          clk_core_disable+0x198/0x1c8 (P)
>          clk_disable+0x34/0x58
>          fsl_edma_remove+0x74/0xe8 [fsl_edma]
>          [...]
>         ---[ end trace 0000000000000000 ]---
>         edma_module already unprepared
>         WARNING: CPU: 0 PID: 418 at drivers/clk/clk.c:1059 clk_core_unprepare+0x1f8/0x220
>         [...]
>         Call trace:
>          clk_core_unprepare+0x1f8/0x220 (P)
>          clk_unprepare+0x34/0x58
>          fsl_edma_remove+0x7c/0xe8 [fsl_edma]
>          [...]
>         ---[ end trace 0000000000000000 ]---
>
> Fix these warnings by removing the unnecessary fsl_disable_clocks() call
> in fsl_edma_remove().
>
> Fixes: a9903de3aa16 ("dmaengine: fsl-edma: refactor using devm_clk_get_enabled")
> Signed-off-by: Jared Kangas <jkangas@redhat.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/fsl-edma-main.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
> index 97583c7d51a2e8e7a50c7eb4f5ff0582ac95798d..093185768ad8ef09270ae02c99d0ee2accc183bd 100644
> --- a/drivers/dma/fsl-edma-main.c
> +++ b/drivers/dma/fsl-edma-main.c
> @@ -915,7 +915,6 @@ static void fsl_edma_remove(struct platform_device *pdev)
>  	of_dma_controller_free(np);
>  	dma_async_device_unregister(&fsl_edma->dma_dev);
>  	fsl_edma_cleanup_vchan(&fsl_edma->dma_dev);
> -	fsl_disable_clocks(fsl_edma, fsl_edma->drvdata->dmamuxs);
>  }
>
>  static int fsl_edma_suspend_late(struct device *dev)
>
> ---
> base-commit: 7d0a66e4bb9081d75c82ec4957c50034cb0ea449
> change-id: 20260112-fsl-edma-clock-removal-4e5882ecface
>
> Best regards,
> --
> Jared Kangas <jkangas@redhat.com>
>

