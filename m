Return-Path: <dmaengine+bounces-2194-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E10B8D1FB8
	for <lists+dmaengine@lfdr.de>; Tue, 28 May 2024 17:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FA651F21AEB
	for <lists+dmaengine@lfdr.de>; Tue, 28 May 2024 15:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1052171E66;
	Tue, 28 May 2024 15:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dclh4WYw"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2079.outbound.protection.outlook.com [40.107.21.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D090C171678;
	Tue, 28 May 2024 15:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716908740; cv=fail; b=TypEz52KLzoH8Dol+6mqzz/kOmDNjtqXN/rsBAd6Menph7FyqJhMaXC3MPSQKy8pn+0iyIQhwa39y3vIGoMZdwl7ZSHQbZpjizq38+VPdueeeD23hBjn4k/Z2ta/K+xJFBKHpBJtvJ8UfKl3FA700aMzL4mBW+5mRZUJO+k0bxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716908740; c=relaxed/simple;
	bh=VOr84AnqqzofcvDM50OV3ocIanUdh7HOl1znfJTb/JY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pPASeZ8eH1iBYbsBevSAeMcAQKWUmhj1RSc0iP8WTE3s3BVo67TRk01++Qk8rwt4rzidsOdu39CZ1zWfvYUuXrpoCFGAs59i2B/bxIa1At3m+99UKs4Pgf6iM9fewLKuML1IGfWl5Hp0EafJVCo8+PfDR91ksgt2De/uhub+QRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=dclh4WYw; arc=fail smtp.client-ip=40.107.21.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IwZACWZTXEmrAoNZeiBIO7d0sS0R0pqnqaHrqyHqX/WmQI6vAnn48hc2J+5vDWE8BW4/HkWa+2VHQTYbGUCwB/cpDkIonDDAxloGFhs8fFepf1swpRrtKb1Dl6q+gCUb3/kFG6oK0kcdLI0obyMeexKkEjnxHWE2xGKJIODQF7jDr3UajFQc8Dy8Pnl4heh0TDvXz1UvF7uBUxndqmMOckjLhNxpnIJsuGY9rC0x74L2zE1xHsJ72XTjFBsvFuboUqCipJbpYO0f2YPM/RLWERRuVEH+VKOUsDzSI+H5gQXyr2AjaDD6SjI4I9QQHOgvovQZ2zgKS+67sAMUtAbEvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4AeUY3eilw2R3CrHxUiBRbshS3jYtrwETEILCXniSY=;
 b=feM5uExYYYGCwr336zjOqHxiTWvl9eGgHsyc2VdUxFNg5J0sd/1WeWnpQvVvQNDQOi48D5gK8qfvqPWtqblJiMSv7lyP/sKtHds1Qq6W6W3qx4t013LaURsR0ysOF3v+tdd9yzc5c3E8Y6cZvcrJVk8SKDNMfsEUBVRKWHgRt8Kb50OfLv2mhDjhABD/o1WtztcGDyDw1qCfb3Q8P+iH4XD5ZIxB3EyuX85JAaojk8wg1nznPpIkR9QeZR29/F4C6l/6uVV3JgHfxrCiUYNHoEP3Cwm2KqLT2SsZxd7mGTmCB6GrPLfkSgB3zGG8gSiA/EJ7gg0QZOUrXC8vWj/xBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4AeUY3eilw2R3CrHxUiBRbshS3jYtrwETEILCXniSY=;
 b=dclh4WYw/r6pSWmA+MIl6/FmTyEeLlOpJN9BQ1k4SvwwP0Hy0Kcnsqx034xC06qxNhgP4ESosfF5I1qtrCPPuL6xK9UbtgBVHcPIW/coZOOXlyn07KWXamUPCYkmT9EXIW+Cw7H7DHKE1ZHYGLHMq+gVPbcrnRUvCVY4weKqTQE=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB7522.eurprd04.prod.outlook.com (2603:10a6:20b:282::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 15:05:35 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::557f:6fcf:a5a7:981c]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::557f:6fcf:a5a7:981c%7]) with mapi id 15.20.7611.025; Tue, 28 May 2024
 15:05:35 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Arnd Bergmann <arnd@kernel.org>, Vinod Koul <vkoul@kernel.org>, Frank Li
	<frank.li@nxp.com>
CC: Arnd Bergmann <arnd@arndb.de>, Fabio Estevam <festevam@denx.de>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] dmaengine: fsl-edma: avoid linking both modules
Thread-Topic: [PATCH] dmaengine: fsl-edma: avoid linking both modules
Thread-Index: AQHasPXbPAOa5CRUU0KFUL9aQ5g51bGsvqHA
Date: Tue, 28 May 2024 15:05:35 +0000
Message-ID:
 <DU0PR04MB94178374D1417FE6BC39DA8988F12@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240528115440.2965975-1-arnd@kernel.org>
In-Reply-To: <20240528115440.2965975-1-arnd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM9PR04MB7522:EE_
x-ms-office365-filtering-correlation-id: 80e1ff3e-a949-4fe8-91d4-08dc7f27a0db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?8srnNv5qYr+a+W+NyictVDN+O4lO6J0Vgl9LnClcyaHnx2A9ToGDlruCFNqB?=
 =?us-ascii?Q?Mx+cpaxlvh5TJ7Na2dzUtj5w2gsJx93+BFOGOk+DRk6QtCWQrU/46iVZst/s?=
 =?us-ascii?Q?9s9ZrCgyyQMM6L2PQ0ECyVmU8fv2we99cTJK8uZoslYBjg6oRJWNeRJZ3wyw?=
 =?us-ascii?Q?TecuRITnbzUT8YvJLBtEiHRYSMuk3RqKutrOYQdkUj+JMdqJvvlMe2pxs4ZT?=
 =?us-ascii?Q?XhzB04flks2KhK1Egy1qLADDnEx9oPn0/tKINmYFMQDYvOhGzmvUptuHwJvc?=
 =?us-ascii?Q?GTCMvoUXu7UfbEAjkM5IcWFatzDIhMTspIJFC/NBogXpHmo87EroWq18AWWo?=
 =?us-ascii?Q?d4anlqVEqg8h1jFge4s+iTl3qa8BWPgY/ybHRwUjAExH5akYvyHmeLNb4acR?=
 =?us-ascii?Q?4GoCBdbO6EZSndN4lUFZRvEg5DgbKd5JEh6Hk1BvMFJ2oHw7L9lAb12U478T?=
 =?us-ascii?Q?l28hFbVWZK7m01rwtMTKL3jL7dxKlc58bSupmQyXjx05E6uGKUXyCGZSoT+k?=
 =?us-ascii?Q?HGcf1Eb38/NnS2pJ1QJes7I194YVyqP06h/hcYcV4oDcso6iUtbetSvzlmeY?=
 =?us-ascii?Q?vIhNgpoGCQ5JyidlL2gpe01EPmDeF0sqOU7e5K7fG2KfHdw/7KXkqWHuEAgJ?=
 =?us-ascii?Q?XA60Qg6hvui5b7TPyYbt6wP15yACeGnKJub8OoZWIQQ46xpA119hzZs/aYpx?=
 =?us-ascii?Q?CRnfNioi7K1NHd+nUPGvxYOAkpIbrDfWUOsJOvImTZwETBErVWO2FgfnrMlj?=
 =?us-ascii?Q?fjwe7U7mFk8VHV2+zcaWRH7Ylj2ynLCtWuF1x47BQxDKbN59edLdxRiCIsc0?=
 =?us-ascii?Q?MQWCVWb/qi2348hpiY/s2JcPNpLHEEVLMOLeAJVYaHRwBKQFrZQIFBmESYym?=
 =?us-ascii?Q?Koea5YgazWKhv46LriXmGRsUWegMzx3U0dSvp0B34booFx57JusPQ65+IjMK?=
 =?us-ascii?Q?EtbaaaR1ct0pVOEEuN/1ZoWQtVpdZsCffzTBv6upJz9hCRpwb52gJFySqT7H?=
 =?us-ascii?Q?Ls7qlL27vDtAHq7pKqpb/PAafDn88pLIBAClF0fZhU4BvKp+pl/gebXwJT8l?=
 =?us-ascii?Q?tKqd7o0RcIEJfKMdVx5SbkF9RZSLdpXelD0gVodMN8jtJt1OvZW1dPIJDKWi?=
 =?us-ascii?Q?87EtWoumhWcxeAno4Gr2/OOJb9J3MbKfu4mWpMgX7JL+2ldSSUjihcyv4Et7?=
 =?us-ascii?Q?klqYczl0nZdEm/juBu4G99d8F6Ku4KBPDDWVOlIcl4Plf7VTY6quPMMMCv+G?=
 =?us-ascii?Q?+9Zgb/d5//bW3Mo9bEbyDTydG6GhYF86PqVyND3Jvg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?KGyMAdhoXjTQNBC4ITo97PJ+ysFQnQvdCrtHopiwax31J3OpRM1vJa/ZwyZz?=
 =?us-ascii?Q?+zp4uFaWbSZxzMfnx0RnwFJVAzT/+6mDpIWrjzsrYj7q6CfZOqdYBoa8UMGx?=
 =?us-ascii?Q?CGisVdWQQLvAn3U7k9pu6X/lc/DW3TKyUGzgRwETWXO293o86GkauHNmhgEP?=
 =?us-ascii?Q?TRgVFOZZQ9RNcFufJo+l5/CMfYuurbXyVJ5Q4Pf0MglgyNTU8mDRxsJz3UCQ?=
 =?us-ascii?Q?jUYSkYXEH3QzuWD2KVNhppOxVkt5X0XyPOFDvTFfX6EbUlXR2xP7irJB3KYp?=
 =?us-ascii?Q?Ibwxbg+hgnOF4O2GdZ2qoCN5Nwml1SpDI5axOVUNgsxbnB/q/0Ra7m/KiH1a?=
 =?us-ascii?Q?Fkn6STecQS0gGYqUFS9kN8ZnW3iBWW2oraaneuIF3YqTnDbtvTZ9HkhPDc83?=
 =?us-ascii?Q?M90co8DSqnSY9fMiaY3QYP9KJP3UsbSrL26F32Otzqi06WWOfXElaWvAF8ad?=
 =?us-ascii?Q?ZeWipKGnVEhJAB3gutwBMyluYrfW/56Y2wxxid0IxOES29BklVcT9kGtDB1m?=
 =?us-ascii?Q?ROWwLLrtWzvkxdtrFN8B/CfHCXz0QZ6eZ3bfGyGB9c27yMSVHqYLM9LucBeW?=
 =?us-ascii?Q?P0TP36jgnwwLCgbpOk5wUmoS4YtD/IFjkTTfSXUSglcraRrYdsUdvpkWlZ5C?=
 =?us-ascii?Q?vTc+omU2V3uF+ZQu3ySy01+nTiwQhUHp6vEapvmWYkQENE0G/P/OPjL7FiYJ?=
 =?us-ascii?Q?810V2rByH9KNtx5JxE4sx3TEvcb2N25siq2LMAE6PcwEzFiJIoQBYgxRgENY?=
 =?us-ascii?Q?vMQ/oDkOZ9g/4ITU8E2rJ2QbYRVhr+TPbDv9vdPdtzNzqUp3Ds/5j36sM+fv?=
 =?us-ascii?Q?INAZVi8B0hdtVeUiehYy+vAQkyMLyCPbhFOumQa5jIHBqXf2bRtT3dvOhuot?=
 =?us-ascii?Q?tmpo02JnvCWH3teei2N+JxP6bmBOJjlALLsca5l6oQjFE9Cz2TFy9ltRECW3?=
 =?us-ascii?Q?d+9u2hWq9ioR7Vsts5ea7zCeJUD3l20faujVLtluMkSzr39PByYtZl8QLJtx?=
 =?us-ascii?Q?LySsmF+9oK5LeR1KhGOYZPwRKgcrmqJRI27UVpK/Oe4l2FMulvx8BdctRW3C?=
 =?us-ascii?Q?osAprRXxohZIsa+0yio1Ks80FTQB2znUmzfv4jMC8HSitsAh2Br97wt6DPRV?=
 =?us-ascii?Q?Jf1Wp8rz+t/ubrUmFvQJhojazXuaOdQxXYAc4qPS9xpBlmTRGtue1bkFlagC?=
 =?us-ascii?Q?9Bb2N+v5r0GJLO2Gl2BLvp3KYXsVC536TlyBntN3FQomb77O91JeT2N3zRZL?=
 =?us-ascii?Q?nLpUZL/+rQnG6ZZ5AFqP3R1Zy7AX1bFPxr1ofvNVNo4+M7JeNoh4RD9iUCJT?=
 =?us-ascii?Q?D/dVUlOXhjaPvNW4j8hqLM40hzNH5+UAPiXQhuDFkITzoL45eJTHZbnrzOyi?=
 =?us-ascii?Q?VjYGXUcNx2EZdX7eJawTY+PoVD6kLLLjTBjIrdbtgbzmQNX530QGT3fZclvN?=
 =?us-ascii?Q?qs3TEx8gIMBaZTv2ZWyAbHoUvClKOC0a6YlUG//qE0RKpPjk3sPaolSbYSWP?=
 =?us-ascii?Q?BwX03aOXQ02WQXHpMCldRF/UEyth9w/AOsRNLEyA/06Gp+ZL7+YmhZKGDEOT?=
 =?us-ascii?Q?C53JUZdEhVkmdR1YMEg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80e1ff3e-a949-4fe8-91d4-08dc7f27a0db
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2024 15:05:35.8405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lsLn7KNnfYoriCoBNqbFsbEhy/bkjZRcVs6SySTicj2IdkrgImqsXFmxSu4IMeaM+cxiK99ADgy6JJ6qSkvVJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7522

> Subject: [PATCH] dmaengine: fsl-edma: avoid linking both modules
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> Kbuild does not support having a source file compiled multiple times and
> linked into distinct modules, or built-in and modular at the same time. F=
or fs-
> edma, there are two common components that are linked into the fsl-
> edma.ko for Arm and PowerPC, plus the mcf-edma.ko module on Coldfire.
> This violates the rule for compile-testing:
>
> scripts/Makefile.build:236: drivers/dma/Makefile: fsl-edma-common.o is
> added to multiple modules: fsl-edma mcf-edma
> scripts/Makefile.build:236: drivers/dma/Makefile: fsl-edma-trace.o is add=
ed
> to multiple modules: fsl-edma mcf-edma
>
> I tried splitting out the common parts into a separate modules, but that =
adds
> back the complexity that a cleanup patch removed, and it gets harder with
> the addition of the tracepoints.
>
> As a minimal workaround, address it at the Kconfig level, by disallowing =
the
> broken configurations.
>
> Link:
> https://lore.ke/
> rnel.org%2Flkml%2F20240110232255.1099757-1-
> arnd%40kernel.org%2F&data=3D05%7C02%7Cpeng.fan%40nxp.com%7Cfb9b0e
> 6533054fee3d0d08dc7f0cfbe4%7C686ea1d3bc2b4c6fa92cd99c5c301635%7
> C0%7C0%7C638524940949353893%7CUnknown%7CTWFpbGZsb3d8eyJWIj
> oiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0
> %7C%7C%7C&sdata=3D88jDqMK7okvOsZaMXT02p7coSRTr2r%2FArF1rbAp9P4
> w%3D&reserved=3D0
> Fixes: 66aac8ea0a6c ("dmaengine: fsl-edma: clean up EXPORT_SYMBOL_GPL
> in fsl-edma-common.c")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/dma/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig index
> 965fa49668ff..b3873d01a2ab 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -394,7 +394,7 @@ config LS2X_APB_DMA
>
>  config MCF_EDMA
>       tristate "Freescale eDMA engine support, ColdFire mcf5441x SoCs"
> -     depends on M5441x || COMPILE_TEST
> +     depends on M5441x || (COMPILE_TEST && FSL_EDMA=3Dn)
>       select DMA_ENGINE
>       select DMA_VIRTUAL_CHANNELS
>       help
> --
> 2.39.2


