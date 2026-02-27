Return-Path: <dmaengine+bounces-9153-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Iw6Gz6/oWnPwAQAu9opvQ
	(envelope-from <dmaengine+bounces-9153-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 27 Feb 2026 16:58:54 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7751BA6DA
	for <lists+dmaengine@lfdr.de>; Fri, 27 Feb 2026 16:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 024633010DA0
	for <lists+dmaengine@lfdr.de>; Fri, 27 Feb 2026 15:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5701143E49B;
	Fri, 27 Feb 2026 15:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RvsXjMcJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013064.outbound.protection.outlook.com [40.107.162.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EA4332ECB;
	Fri, 27 Feb 2026 15:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772207713; cv=fail; b=oOrn9BAQN6yxSCJNQRtzzkOIxs8W6sGcLEwhqi1XD5x01C/4FBjxAXE6bkWuL94ZPzwcAAxz3M0q/VkX/XvxAAxEJli6Bnk/RUVMiwOqGfzhPoAGc1bodO28T7qYfJTKHq7DtnJX9yx4bVMj8Qvn4EP0QpFudKdzdRORUX7KIPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772207713; c=relaxed/simple;
	bh=umXzN3yOQUTa1bXhKqrtbCVr4BKmsKJ8l/qet4DwFak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lp/BszKVBYZqsSBvyMSzverGqWdYxZkdLr7qg69ASU90h0gZs8mMSKDK/e56dtdNLcPrLLAlwZ6BVvLhUqQzbUeS65AavTVWfM8VpsATPXnPK83j1Jan8y9tPWd18nmHFRm7Ph51ltgP8CmKc6VUd1/gj9pY9glg/xeo3O1nB2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RvsXjMcJ; arc=fail smtp.client-ip=40.107.162.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=skrH6DmPe6EDhdRGvGbgwyIC4BhPCrqGgf7d1sh8aWdhvClgt0A4rpOCnYudNkpmk8x6fiudW4fm6uwqmr9sNBzF0/cEf2JPbLMIMb4Yqg+TkclMS20wXFwonYATvUA2fJ2Yl5Mo4hpLBs0UyfxpJZIql6Pa9Bxru/f9ATaS2PQub6gPaZJgU3bN3q9hH5ZzL8xJ+hZPE2V7xPYbzJby+k8QkXgKzEgXYk0A4FjDSIiosyDXVsQFacJsKPH8DjaSTETxnmLM4khCDG8dMcCv1DQPjMn78RsK2NtOrfynes3OQaU5RWsITfudqz0x5lP5PE0tAHgbLqlP/FXhh8Y2yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJOKdYsix/gRystmLKYPtAIiuKug8ZNrULrkzA15NDc=;
 b=iYxoGU/USW6chjjvWhZqUOd6l3MAneKE+s3vicMuivGnSABVdvDVihJJp8kTZVwyxpQT38mIP2VR2X9AoXLDeiJgSVfvmqQtgHKIdN8eqwxOmIxQRtGUV+BoBkVvTsA3F4R3aSgYQz3GvX4txan+NZN2LfKhgVR8MhjYpJ61hwmw8g01hbvkg7cgs8g0zPiGlvQYmXHs+qI3JlYCI1cCk6GOjMQPltcxsrRuPiDmV+T1lsKyCu+fqRgvxyXSo23yFq+1wyZ/xYRF6Zyb+6LPlExzPonxLgSRcdjpDHmaIqWf2hy3Du5VKNNA98LlD39PQxmbYt/du+T6WXU5hbbgPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJOKdYsix/gRystmLKYPtAIiuKug8ZNrULrkzA15NDc=;
 b=RvsXjMcJSEkLrUFpX20aoEYdcONrJcORzMqNZsTlWYzoEYKpvX40CV5B9uJgTsCxKmvPi3ekN7aWAn9vIPCWhUwI0OBnRMf9gA4LnlXwpk7QW0yKfB+DWsqhCwf3BPUWHUktNK8DQZQ0TPg/ldrtlvQpTLJ7JUx6c+VANPvcHDiqWBUPFMLSxjEGglR29k4RXV3yNhIsiKB+QdZ1fogblkGyYCLp1oT262KglrYJlyQimDUWjptGCa1eSQl0LDyH607nKMEH/hVhbCXh7YraFV3qZluGz0mBv7n+S8SsGNL3iJIOFsC4o4ZCMfuscN6fCAm6uiUiFsVOw+SmVSDMBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com (2603:10a6:10:35b::7)
 by AM0PR04MB6867.eurprd04.prod.outlook.com (2603:10a6:208:182::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 15:55:06 +0000
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4]) by DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4%4]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 15:55:06 +0000
Date: Fri, 27 Feb 2026 10:54:58 -0500
From: Frank Li <Frank.li@nxp.com>
To: xianwei.zhao@amlogic.com
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-amlogic@lists.infradead.org, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dma: amlogic: Add general DMA driver for A9
Message-ID: <aaG-UvN_lTl6dv7L@lizhi-Precision-Tower-5810>
References: <20260206-amlogic-dma-v3-0-56fb9f59ed22@amlogic.com>
 <20260206-amlogic-dma-v3-2-56fb9f59ed22@amlogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206-amlogic-dma-v3-2-56fb9f59ed22@amlogic.com>
X-ClientProxiedBy: SJ2PR07CA0008.namprd07.prod.outlook.com
 (2603:10b6:a03:505::8) To DU0PR04MB9372.eurprd04.prod.outlook.com
 (2603:10a6:10:35b::7)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9372:EE_|AM0PR04MB6867:EE_
X-MS-Office365-Filtering-Correlation-Id: 846d4c10-36c7-4dd2-2bdd-08de76189385
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	wctaxQ55gBZmAY4vecWy6DvzeG6ZIjsWqnqLQwoRHk8Xu9Dk0gQvJdl2L4DoP12migrpBI0+vJF+J76myxsChrpxV4GUiJliJPb3Li/+VAMwu2suXqFkqMP73GILR3Gkf6UoDjGk36kdrCM4/Ld5PrRJgUHAphoeCUKdACbXuLPY2oK0OoEEcyylNXsgvR5FqG/qhhbz65tWAX+G0gCPvL8kruL/pbTF6Vd3zCPzPM8n031ONlh4FTlJ4S15sOujm4uSiZMqQr6mPsSwV76MSuGGQnsZ27DQJqyDcOnis2OorvpNQqWw7/5jWogxr1+9ZgDSrWt6R9wGd3BYC1IwaVBG2KaP0D1abg/5msZAEvwKshmEk5O883ydKp1jdJgI8EUy+Qm+558yhCKTfm0SxW4EtM5l8/deyaHztxpBMa04IFbXC5arUrrf4MMuvIb5gswLRj0cbuZShr/P77I76km81onKGUKFHiJrvFmYtKYV2z3P77XCV/YkD8l8SV3+wyLbApYvAyhbOy0UxoaMouCr1lHCJBLoc3WtCxEK8xEcnO7l8Zszvv5aLrQbpx6Zf3g/lyvNT/2vM9qYzhWB16RcK0DnWZy4GAaFsti/1JcSGFNlDuD/CzyLaURBFEzK+ca++WgJ38Oe2/nn/HyME4VM9JD4g38r4olUZaK19p6Zs3mXWWRJjGID3p5hQUQieEDkj+1k0jQIRvui66dXN1AieVMeWE2lEu9WyidP+iLugaaylducxOr5vc4IdXoB+HysM4jQK9QO4duxwoYk6eGZ/DcFq9jcmFWmaRIBe7M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9372.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eCwAfDWtcQ/QvLnxLPtHfWvtOt+TAXgi4eiF6OuM7rZuK9Bf6ADFwSxdMg9N?=
 =?us-ascii?Q?eEQZNgvgmFXr7q2EiuKDg3i7nm4figoW0Z5SqcrAmyrfYfs4+fTLwlGV/V1T?=
 =?us-ascii?Q?4rdRY0pEsJP59LgQ7+ldtyaBhh3KE5ze2k/jJ5sHAxirY0UwBkkInZNNcnu3?=
 =?us-ascii?Q?djFCg6E121BZaXchGzoYv3DGOBLzvHch9UaLUz2ltwzutF1RTBpPoeqMQLko?=
 =?us-ascii?Q?7lkIArQcB6FcZ4boMkiv0ORPIGnKXPEFJI/XKcnVLTnKiW3VUxVmemM9OoTN?=
 =?us-ascii?Q?0v9A1TiODH/flCOe30nExSFOlbDW0gHUMrh6RwnZ/JWjFGt/JGhKOFeM7EQY?=
 =?us-ascii?Q?FPPp2O9ZtT8RcpEotlMgu1mqA2vF74/gsySKvlFHBUsWk4CogU4pe+W0ZwIA?=
 =?us-ascii?Q?gjS3zvmxE3eIYK4IW/WafVWNdku4beM4MakpyQhV9D4fXcG7YytgbSB8DfWm?=
 =?us-ascii?Q?BFo8PChDwOrWP/RX6b9C29IQake2/3QcsUSF9Hjv+S0EdAIFCMp1jggMq8ex?=
 =?us-ascii?Q?NzVmNWo+YCgNcfrNxC5rRwVzsI56/OBYvnonU7kj1sEqRenLw4gslte0Htz/?=
 =?us-ascii?Q?aXYS4qvsQDtWUjV17eS/94Y3hxb5MRBR3jpgEUE8SFNQrunXvUiw3/J4CY9U?=
 =?us-ascii?Q?AP8eVX6Bl46pZkWzKDFTOKiubyfediZi5IsZwDsd/5ivBX1KM8eQGceAIPgO?=
 =?us-ascii?Q?zoR6YkIA37/YdvKWRiZfxpZJvJxK0z1uUiFFaaguUg3R9oNg5QNIImHumcU7?=
 =?us-ascii?Q?XYdghSl9w/ceECaUo53Ojv+981QV7Jci82sPVTKFSRApRhAHC9n3VCWa8YGc?=
 =?us-ascii?Q?xGJQA0n/H9uVK3rnx2aDAZ2R7e8Z7I7huL7+Kh4R/kWPg2OfkuQQ4x5kKLhE?=
 =?us-ascii?Q?P7xG6FlX4Dl2emvPUqqVQU+dtswRZq/8Y+JEaBjB2hrpRiE8lggPSIWkQLR1?=
 =?us-ascii?Q?8QGpJrfQZq/HdqegHfPTZRJaRTPaWRzz3xEiZVaDghNX9is8bFKwCgXqnxzC?=
 =?us-ascii?Q?NdOg5Dc/mhhQO8ags9/1fq71YMASlOHwLcAbRdmk8s/nh/wKxVlZsQzvejk9?=
 =?us-ascii?Q?HlXj3TcIfgvk3UuE39VkA3uydDdzoUxDf49VuAfsU049A9x6Kk8K4DWSrq6/?=
 =?us-ascii?Q?ubdvl+1IjF4MMD082+Dep7iEa6wWdFzveUQ7IXNqQJMRWr91bTPx6UW9mWXQ?=
 =?us-ascii?Q?exZB9KzRBHTrEjCCP7zbNG4kQccwnMpHNcRcoFLQWIDHI0uHcZXz7gH1mLc5?=
 =?us-ascii?Q?O9223or7AguaXM3aSM6sj9pszuf4Kpi0qHWnLhJTkDy+kwAMkvxolfNjbhAv?=
 =?us-ascii?Q?ALfIZ5y4m9HtvGkn4u2RrbVHnYkVFH6+DxJaffnA8zJqBi5cNdQZ386IvylL?=
 =?us-ascii?Q?fV/XVoMDaFMKO4OXhWtDSo0cn1i705Gk8Zeku/UqLj48VoLxB/MPBnNR6KyR?=
 =?us-ascii?Q?SB1EqNfDDLF7UR4YYpwH65s8kXqrv2Yr0H3A5FsPL1+EqVhCAPv/c3Ux1och?=
 =?us-ascii?Q?VwIB4vv3O8akjE8Ivg7EWb2Ezh3DL/icS6DjSWEgrFP5RA+O93pX5g82DUfR?=
 =?us-ascii?Q?DMru4fApkVeGkZ2Cq8Xr+XFTz+sgGSlVC3btJjpogSSY6cvAszWSmXH0hj5x?=
 =?us-ascii?Q?LtGpxVNaXedBBd4YVJUf2sKtxNGoF4MSbFNpPZv08OsbqPXM+S3jBpE3v826?=
 =?us-ascii?Q?7AuCt9aozi7Ahm9nNldzs7w6OZqo5UFNi5cdC9lYzFXxndo3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 846d4c10-36c7-4dd2-2bdd-08de76189385
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9372.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 15:55:06.2407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1rUQd+hZdWVN/ZpKfan2V280XNERIICqrT0nZJTSY82Wwzb3ztDMoUV37vSv1LJlWS2jlqYxdhmi6FFKHjGPNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6867
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9153-lists,dmaengine=lfdr.de];
	URIBL_MULTI_FAIL(0.00)[nxp.com:server fail,amlogic.com:server fail,sea.lore.kernel.org:server fail];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4D7751BA6DA
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 09:02:33AM +0000, Xianwei Zhao via B4 Relay wrote:
> From: Xianwei Zhao <xianwei.zhao@amlogic.com>

subject should dmaegine: amlogic: ...

Frank

>
> Amlogic A9 SoCs include a general-purpose DMA controller that can be used
> by multiple peripherals, such as I2C PIO and I3C. Each peripheral group
> is associated with a dedicated DMA channel in hardware.
>
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>  drivers/dma/Kconfig       |   9 +
>  drivers/dma/Makefile      |   1 +
>  drivers/dma/amlogic-dma.c | 561 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 571 insertions(+)
>
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 66cda7cc9f7a..8d4578513acf 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -85,6 +85,15 @@ config AMCC_PPC440SPE_ADMA
>  	help
>  	  Enable support for the AMCC PPC440SPe RAID engines.
>
> +config AMLOGIC_DMA
> +	tristate "Amlogic general DMA support"
> +	depends on ARCH_MESON || COMPILE_TEST
> +	select DMA_ENGINE
> +	select REGMAP_MMIO
> +	help
> +	  Enable support for the Amlogic general DMA engines. THis DMA
> +	  controller is used some Amlogic SoCs, such as A9.
> +
>  config APPLE_ADMAC
>  	tristate "Apple ADMAC support"
>  	depends on ARCH_APPLE || COMPILE_TEST
> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
> index a54d7688392b..fc28dade5b69 100644
> --- a/drivers/dma/Makefile
> +++ b/drivers/dma/Makefile
> @@ -16,6 +16,7 @@ obj-$(CONFIG_DMATEST) += dmatest.o
>  obj-$(CONFIG_ALTERA_MSGDMA) += altera-msgdma.o
>  obj-$(CONFIG_AMBA_PL08X) += amba-pl08x.o
>  obj-$(CONFIG_AMCC_PPC440SPE_ADMA) += ppc4xx/
> +obj-$(CONFIG_AMLOGIC_DMA) += amlogic-dma.o
>  obj-$(CONFIG_APPLE_ADMAC) += apple-admac.o
>  obj-$(CONFIG_ARM_DMA350) += arm-dma350.o
>  obj-$(CONFIG_AT_HDMAC) += at_hdmac.o
> diff --git a/drivers/dma/amlogic-dma.c b/drivers/dma/amlogic-dma.c
> new file mode 100644
> index 000000000000..cbecbde7857b
> --- /dev/null
> +++ b/drivers/dma/amlogic-dma.c
> @@ -0,0 +1,561 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
> +/*
> + * Copyright (C) 2025 Amlogic, Inc. All rights reserved
> + * Author: Xianwei Zhao <xianwei.zhao@amlogic.com>
> + */
> +
> +#include <asm/irq.h>
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/device.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dmaengine.h>
> +#include <linux/interrupt.h>
> +#include <linux/init.h>
> +#include <linux/list.h>
> +#include <linux/mm.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_dma.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +
> +#include "dmaengine.h"
> +
> +#define RCH_REG_BASE		0x0
> +#define WCH_REG_BASE		0x2000
> +/*
> + * Each rch (read from memory) REG offset  Rch_offset 0x0 each channel total 0x40
> + * rch addr = DMA_base + Rch_offset+ chan_id * 0x40 + reg_offset
> + */
> +#define RCH_READY		0x0
> +#define RCH_STATUS		0x4
> +#define RCH_CFG			0x8
> +#define CFG_CLEAR		BIT(25)
> +#define CFG_PAUSE		BIT(26)
> +#define CFG_ENABLE		BIT(27)
> +#define CFG_DONE		BIT(28)
> +#define RCH_ADDR		0xc
> +#define RCH_LEN			0x10
> +#define RCH_RD_LEN		0x14
> +#define RCH_PRT			0x18
> +#define RCH_SYCN_STAT		0x1c
> +#define RCH_ADDR_LOW		0x20
> +#define RCH_ADDR_HIGH		0x24
> +/* if work on 64, it work with RCH_PRT */
> +#define RCH_PTR_HIGH		0x28
> +
> +/*
> + * Each wch (write to memory) REG offset  Wch_offset 0x2000 each channel total 0x40
> + * wch addr = DMA_base + Wch_offset+ chan_id * 0x40 + reg_offset
> + */
> +#define WCH_READY		0x0
> +#define WCH_TOTAL_LEN		0x4
> +#define WCH_CFG			0x8
> +#define WCH_ADDR		0xc
> +#define WCH_LEN			0x10
> +#define WCH_RD_LEN		0x14
> +#define WCH_PRT			0x18
> +#define WCH_CMD_CNT		0x1c
> +#define WCH_ADDR_LOW		0x20
> +#define WCH_ADDR_HIGH		0x24
> +/* if work on 64, it work with RCH_PRT */
> +#define WCH_PTR_HIGH		0x28
> +
> +/* DMA controller reg */
> +#define RCH_INT_MASK		0x1000
> +#define WCH_INT_MASK		0x1004
> +#define CLEAR_W_BATCH		0x1014
> +#define CLEAR_RCH		0x1024
> +#define CLEAR_WCH		0x1028
> +#define RCH_ACTIVE		0x1038
> +#define WCH_ACTIVE		0x103c
> +#define RCH_DONE		0x104c
> +#define WCH_DONE		0x1050
> +#define RCH_ERR			0x1060
> +#define RCH_LEN_ERR		0x1064
> +#define WCH_ERR			0x1068
> +#define DMA_BATCH_END		0x1078
> +#define WCH_EOC_DONE		0x1088
> +#define WDMA_RESP_ERR		0x1098
> +#define UPT_PKT_SYNC		0x10a8
> +#define RCHN_CFG		0x10ac
> +#define WCHN_CFG		0x10b0
> +#define MEM_PD_CFG		0x10b4
> +#define MEM_BUS_CFG		0x10b8
> +#define DMA_GMV_CFG		0x10bc
> +#define DMA_GMR_CFG		0x10c0
> +
> +#define AML_DMA_TYPE_TX		0
> +#define AML_DMA_TYPE_RX		1
> +#define DMA_MAX_LINK		8
> +#define MAX_CHAN_ID		32
> +#define SG_MAX_LEN		GENMASK(26, 0)
> +
> +struct aml_dma_sg_link {
> +#define LINK_LEN		GENMASK(26, 0)
> +#define LINK_IRQ		BIT(27)
> +#define LINK_EOC		BIT(28)
> +#define LINK_LOOP		BIT(29)
> +#define LINK_ERR		BIT(30)
> +#define LINK_OWNER		BIT(31)
> +	u32 ctl;
> +	u64 address;
> +	u32 revered;
> +} __packed;
> +
> +struct aml_dma_chan {
> +	struct dma_chan			chan;
> +	struct dma_async_tx_descriptor	desc;
> +	struct aml_dma_dev		*aml_dma;
> +	struct aml_dma_sg_link		*sg_link;
> +	dma_addr_t			sg_link_phys;
> +	int				sg_link_cnt;
> +	int				data_len;
> +	enum dma_status			pre_status;
> +	enum dma_status			status;
> +	enum dma_transfer_direction	direction;
> +	int				chan_id;
> +	/* reg_base (direction + chan_id) */
> +	int				reg_offs;
> +};
> +
> +struct aml_dma_dev {
> +	struct dma_device		dma_device;
> +	void __iomem			*base;
> +	struct regmap			*regmap;
> +	struct clk			*clk;
> +	int				irq;
> +	struct platform_device		*pdev;
> +	struct aml_dma_chan		*aml_rch[MAX_CHAN_ID];
> +	struct aml_dma_chan		*aml_wch[MAX_CHAN_ID];
> +	unsigned int			chan_nr;
> +	unsigned int			chan_used;
> +	struct aml_dma_chan		aml_chans[]__counted_by(chan_nr);
> +};
> +
> +static struct aml_dma_chan *to_aml_dma_chan(struct dma_chan *chan)
> +{
> +	return container_of(chan, struct aml_dma_chan, chan);
> +}
> +
> +static dma_cookie_t aml_dma_tx_submit(struct dma_async_tx_descriptor *tx)
> +{
> +	return dma_cookie_assign(tx);
> +}
> +
> +static int aml_dma_alloc_chan_resources(struct dma_chan *chan)
> +{
> +	struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
> +	struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
> +	size_t size = size_mul(sizeof(struct aml_dma_sg_link), DMA_MAX_LINK);
> +
> +	aml_chan->sg_link = dma_alloc_coherent(aml_dma->dma_device.dev, size,
> +					       &aml_chan->sg_link_phys, GFP_KERNEL);
> +	if (!aml_chan->sg_link)
> +		return  -ENOMEM;
> +
> +	/* offset is the same RCH_CFG and WCH_CFG */
> +	regmap_update_bits(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, CFG_CLEAR, CFG_CLEAR);
> +	aml_chan->status = DMA_COMPLETE;
> +	dma_async_tx_descriptor_init(&aml_chan->desc, chan);
> +	aml_chan->desc.tx_submit = aml_dma_tx_submit;
> +	regmap_update_bits(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, CFG_CLEAR, 0);
> +
> +	return 0;
> +}
> +
> +static void aml_dma_free_chan_resources(struct dma_chan *chan)
> +{
> +	struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
> +	struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
> +
> +	aml_chan->status = DMA_COMPLETE;
> +	dma_free_coherent(aml_dma->dma_device.dev,
> +			  sizeof(struct aml_dma_sg_link) * DMA_MAX_LINK,
> +			  aml_chan->sg_link, aml_chan->sg_link_phys);
> +}
> +
> +/* DMA transfer state  update how many data reside it */
> +static enum dma_status aml_dma_tx_status(struct dma_chan *chan,
> +					 dma_cookie_t cookie,
> +					 struct dma_tx_state *txstate)
> +{
> +	struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
> +	struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
> +	u32 residue, done;
> +
> +	regmap_read(aml_dma->regmap, aml_chan->reg_offs + RCH_RD_LEN, &done);
> +	residue = aml_chan->data_len - done;
> +	dma_set_tx_state(txstate, chan->completed_cookie, chan->cookie,
> +			 residue);
> +
> +	return aml_chan->status;
> +}
> +
> +static struct dma_async_tx_descriptor *aml_dma_prep_slave_sg
> +		(struct dma_chan *chan, struct scatterlist *sgl,
> +		unsigned int sg_len, enum dma_transfer_direction direction,
> +		unsigned long flags, void *context)
> +{
> +	struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
> +	struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
> +	struct aml_dma_sg_link *sg_link;
> +	struct scatterlist *sg;
> +	int idx = 0;
> +	u32 reg, chan_id;
> +	u32 i;
> +
> +	if (aml_chan->direction != direction) {
> +		dev_err(aml_dma->dma_device.dev, "direction not support\n");
> +		return NULL;
> +	}
> +
> +	switch (aml_chan->status) {
> +	case DMA_IN_PROGRESS:
> +		dev_err(aml_dma->dma_device.dev, "not support multi tx_desciptor\n");
> +		return NULL;
> +
> +	case DMA_COMPLETE:
> +		aml_chan->data_len = 0;
> +		chan_id = aml_chan->chan_id;
> +		reg = (direction == DMA_DEV_TO_MEM) ? WCH_INT_MASK : RCH_INT_MASK;
> +		regmap_update_bits(aml_dma->regmap, reg, BIT(chan_id), BIT(chan_id));
> +
> +		break;
> +	default:
> +		dev_err(aml_dma->dma_device.dev, "status error\n");
> +		return NULL;
> +	}
> +
> +	if (sg_len > DMA_MAX_LINK) {
> +		dev_err(aml_dma->dma_device.dev,
> +			"maximum number of sg exceeded: %d > %d\n",
> +			sg_len, DMA_MAX_LINK);
> +		aml_chan->status = DMA_ERROR;
> +		return NULL;
> +	}
> +
> +	aml_chan->status = DMA_IN_PROGRESS;
> +
> +	for_each_sg(sgl, sg, sg_len, i) {
> +		if (sg_dma_len(sg) > SG_MAX_LEN) {
> +			dev_err(aml_dma->dma_device.dev,
> +				"maximum bytes exceeded: %u > %lu\n",
> +				sg_dma_len(sg), SG_MAX_LEN);
> +			aml_chan->status = DMA_ERROR;
> +			return NULL;
> +		}
> +		sg_link = &aml_chan->sg_link[idx++];
> +		/* set dma address and len  to sglink*/
> +		sg_link->address = sg->dma_address;
> +		sg_link->ctl = FIELD_PREP(LINK_LEN, sg_dma_len(sg));
> +
> +		aml_chan->data_len += sg_dma_len(sg);
> +	}
> +	aml_chan->sg_link_cnt = idx;
> +
> +	return &aml_chan->desc;
> +}
> +
> +static int aml_dma_pause_chan(struct dma_chan *chan)
> +{
> +	struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
> +	struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
> +
> +	regmap_update_bits(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, CFG_PAUSE, CFG_PAUSE);
> +	aml_chan->pre_status = aml_chan->status;
> +	aml_chan->status = DMA_PAUSED;
> +
> +	return 0;
> +}
> +
> +static int aml_dma_resume_chan(struct dma_chan *chan)
> +{
> +	struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
> +	struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
> +
> +	regmap_update_bits(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, CFG_PAUSE, 0);
> +	aml_chan->status = aml_chan->pre_status;
> +
> +	return 0;
> +}
> +
> +static int aml_dma_terminate_all(struct dma_chan *chan)
> +{
> +	struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
> +	struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
> +	int chan_id = aml_chan->chan_id;
> +
> +	aml_dma_pause_chan(chan);
> +	regmap_update_bits(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, CFG_CLEAR, CFG_CLEAR);
> +
> +	if (aml_chan->direction == DMA_MEM_TO_DEV)
> +		regmap_update_bits(aml_dma->regmap, RCH_INT_MASK, BIT(chan_id), BIT(chan_id));
> +	else if (aml_chan->direction == DMA_DEV_TO_MEM)
> +		regmap_update_bits(aml_dma->regmap, WCH_INT_MASK, BIT(chan_id), BIT(chan_id));
> +
> +	aml_chan->status = DMA_COMPLETE;
> +
> +	return 0;
> +}
> +
> +static void aml_dma_enable_chan(struct dma_chan *chan)
> +{
> +	struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
> +	struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
> +	struct aml_dma_sg_link *sg_link;
> +	int chan_id = aml_chan->chan_id;
> +	int idx = aml_chan->sg_link_cnt - 1;
> +
> +	/* the last sg set eoc flag */
> +	sg_link = &aml_chan->sg_link[idx];
> +	sg_link->ctl |= LINK_EOC;
> +	if (aml_chan->direction == DMA_MEM_TO_DEV) {
> +		regmap_write(aml_dma->regmap, aml_chan->reg_offs + RCH_ADDR,
> +			     aml_chan->sg_link_phys);
> +		regmap_write(aml_dma->regmap, aml_chan->reg_offs + RCH_LEN, aml_chan->data_len);
> +		regmap_update_bits(aml_dma->regmap, RCH_INT_MASK, BIT(chan_id), 0);
> +		/* for rch (tx) need set cfg 0 to trigger start */
> +		regmap_write(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, 0);
> +	} else if (aml_chan->direction == DMA_DEV_TO_MEM) {
> +		regmap_write(aml_dma->regmap, aml_chan->reg_offs + WCH_ADDR,
> +			     aml_chan->sg_link_phys);
> +		regmap_write(aml_dma->regmap, aml_chan->reg_offs + WCH_LEN, aml_chan->data_len);
> +		regmap_update_bits(aml_dma->regmap, WCH_INT_MASK, BIT(chan_id), 0);
> +	}
> +}
> +
> +static irqreturn_t aml_dma_interrupt_handler(int irq, void *dev_id)
> +{
> +	struct aml_dma_dev *aml_dma = dev_id;
> +	struct aml_dma_chan *aml_chan;
> +	u32 done, eoc_done, err, err_l, end;
> +	int i = 0;
> +
> +	/* deal with rch normal complete and error */
> +	regmap_read(aml_dma->regmap, RCH_DONE, &done);
> +	regmap_read(aml_dma->regmap, RCH_ERR, &err);
> +	regmap_read(aml_dma->regmap, RCH_LEN_ERR, &err_l);
> +	err = err | err_l;
> +
> +	done = done | err;
> +
> +	while (done) {
> +		i = ffs(done) - 1;
> +		aml_chan = aml_dma->aml_rch[i];
> +		regmap_write(aml_dma->regmap, CLEAR_RCH, BIT(aml_chan->chan_id));
> +		if (!aml_chan) {
> +			dev_err(aml_dma->dma_device.dev, "idx %d rch not initialized\n", i);
> +			done &= ~BIT(i);
> +			continue;
> +		}
> +		aml_chan->status = (err & (1 << i)) ? DMA_ERROR : DMA_COMPLETE;
> +		dma_cookie_complete(&aml_chan->desc);
> +		dmaengine_desc_get_callback_invoke(&aml_chan->desc, NULL);
> +		done &= ~BIT(i);
> +	}
> +
> +	/* deal with wch normal complete and error */
> +	regmap_read(aml_dma->regmap, DMA_BATCH_END, &end);
> +	if (end)
> +		regmap_write(aml_dma->regmap, CLEAR_W_BATCH, end);
> +
> +	regmap_read(aml_dma->regmap, WCH_DONE, &done);
> +	regmap_read(aml_dma->regmap, WCH_EOC_DONE, &eoc_done);
> +	done = done | eoc_done;
> +
> +	regmap_read(aml_dma->regmap, WCH_ERR, &err);
> +	regmap_read(aml_dma->regmap, WDMA_RESP_ERR, &err_l);
> +	err = err | err_l;
> +
> +	done = done | err;
> +	i = 0;
> +	while (done) {
> +		i = ffs(done) - 1;
> +		aml_chan = aml_dma->aml_wch[i];
> +		regmap_write(aml_dma->regmap, CLEAR_WCH, BIT(aml_chan->chan_id));
> +		if (!aml_chan) {
> +			dev_err(aml_dma->dma_device.dev, "idx %d wch not initialized\n", i);
> +			done &= ~BIT(i);
> +			continue;
> +		}
> +		aml_chan->status = (err & (1 << i)) ? DMA_ERROR : DMA_COMPLETE;
> +		dma_cookie_complete(&aml_chan->desc);
> +		dmaengine_desc_get_callback_invoke(&aml_chan->desc, NULL);
> +		done &= ~BIT(i);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static struct dma_chan *aml_of_dma_xlate(struct of_phandle_args *dma_spec, struct of_dma *ofdma)
> +{
> +	struct aml_dma_dev *aml_dma = (struct aml_dma_dev *)ofdma->of_dma_data;
> +	struct aml_dma_chan *aml_chan = NULL;
> +	u32 type;
> +	u32 phy_chan_id;
> +
> +	if (dma_spec->args_count != 2)
> +		return NULL;
> +
> +	type = dma_spec->args[0];
> +	phy_chan_id = dma_spec->args[1];
> +
> +	if (phy_chan_id >= MAX_CHAN_ID)
> +		return NULL;
> +
> +	if (type == AML_DMA_TYPE_TX) {
> +		aml_chan = aml_dma->aml_rch[phy_chan_id];
> +		if (!aml_chan) {
> +			if (aml_dma->chan_used >= aml_dma->chan_nr) {
> +				dev_err(aml_dma->dma_device.dev, "some dma clients err used\n");
> +				return NULL;
> +			}
> +			aml_chan = &aml_dma->aml_chans[aml_dma->chan_used];
> +			aml_dma->chan_used++;
> +			aml_chan->direction = DMA_MEM_TO_DEV;
> +			aml_chan->chan_id = phy_chan_id;
> +			aml_chan->reg_offs = RCH_REG_BASE + 0x40 * aml_chan->chan_id;
> +			aml_dma->aml_rch[phy_chan_id] = aml_chan;
> +		}
> +	} else if (type == AML_DMA_TYPE_RX) {
> +		aml_chan = aml_dma->aml_wch[phy_chan_id];
> +		if (!aml_chan) {
> +			if (aml_dma->chan_used >= aml_dma->chan_nr) {
> +				dev_err(aml_dma->dma_device.dev, "some dma clients err used\n");
> +				return NULL;
> +			}
> +			aml_chan = &aml_dma->aml_chans[aml_dma->chan_used];
> +			aml_dma->chan_used++;
> +			aml_chan->direction = DMA_DEV_TO_MEM;
> +			aml_chan->chan_id = phy_chan_id;
> +			aml_chan->reg_offs = WCH_REG_BASE + 0x40 * aml_chan->chan_id;
> +			aml_dma->aml_wch[phy_chan_id] = aml_chan;
> +		}
> +	} else {
> +		dev_err(aml_dma->dma_device.dev, "type %d not supported\n", type);
> +		return NULL;
> +	}
> +
> +	return dma_get_slave_channel(&aml_chan->chan);
> +}
> +
> +static int aml_dma_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct dma_device *dma_dev;
> +	struct aml_dma_dev *aml_dma;
> +	int ret, i, len;
> +	u32 chan_nr;
> +
> +	const struct regmap_config aml_regmap_config = {
> +		.reg_bits = 32,
> +		.val_bits = 32,
> +		.reg_stride = 4,
> +		.max_register = 0x3000,
> +	};
> +
> +	ret = of_property_read_u32(np, "dma-channels", &chan_nr);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "failed to read dma-channels\n");
> +
> +	len = sizeof(*aml_dma) + sizeof(struct aml_dma_chan) * chan_nr;
> +	aml_dma = devm_kzalloc(&pdev->dev, len, GFP_KERNEL);
> +	if (!aml_dma)
> +		return -ENOMEM;
> +
> +	aml_dma->chan_nr = chan_nr;
> +
> +	aml_dma->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(aml_dma->base))
> +		return PTR_ERR(aml_dma->base);
> +
> +	aml_dma->regmap = devm_regmap_init_mmio(&pdev->dev, aml_dma->base,
> +						&aml_regmap_config);
> +	if (IS_ERR_OR_NULL(aml_dma->regmap))
> +		return PTR_ERR(aml_dma->regmap);
> +
> +	aml_dma->clk = devm_clk_get_enabled(&pdev->dev, NULL);
> +	if (IS_ERR(aml_dma->clk))
> +		return PTR_ERR(aml_dma->clk);
> +
> +	aml_dma->irq = platform_get_irq(pdev, 0);
> +
> +	aml_dma->pdev = pdev;
> +	aml_dma->dma_device.dev = &pdev->dev;
> +
> +	dma_dev = &aml_dma->dma_device;
> +	INIT_LIST_HEAD(&dma_dev->channels);
> +
> +	/* Initialize channel parameters */
> +	for (i = 0; i < chan_nr; i++) {
> +		struct aml_dma_chan *aml_chan = &aml_dma->aml_chans[i];
> +
> +		aml_chan->aml_dma = aml_dma;
> +		aml_chan->chan.device = &aml_dma->dma_device;
> +		dma_cookie_init(&aml_chan->chan);
> +
> +		/* Add the channel to aml_chan list */
> +		list_add_tail(&aml_chan->chan.device_node,
> +			      &aml_dma->dma_device.channels);
> +	}
> +	aml_dma->chan_used = 0;
> +
> +	dma_set_max_seg_size(dma_dev->dev, SG_MAX_LEN);
> +
> +	dma_cap_set(DMA_SLAVE, dma_dev->cap_mask);
> +	dma_dev->device_alloc_chan_resources = aml_dma_alloc_chan_resources;
> +	dma_dev->device_free_chan_resources = aml_dma_free_chan_resources;
> +	dma_dev->device_tx_status = aml_dma_tx_status;
> +	dma_dev->device_prep_slave_sg = aml_dma_prep_slave_sg;
> +
> +	dma_dev->device_pause = aml_dma_pause_chan;
> +	dma_dev->device_resume = aml_dma_resume_chan;
> +	dma_dev->device_terminate_all = aml_dma_terminate_all;
> +	dma_dev->device_issue_pending = aml_dma_enable_chan;
> +	/* PIO 4 bytes and I2C 1 byte */
> +	dma_dev->dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES | DMA_SLAVE_BUSWIDTH_1_BYTE);
> +	dma_dev->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
> +	dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
> +
> +	ret = dmaenginem_async_device_register(dma_dev);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "failed to register dmaenginem\n");
> +
> +	ret = of_dma_controller_register(np, aml_of_dma_xlate, aml_dma);
> +	if (ret)
> +		return ret;
> +
> +	regmap_write(aml_dma->regmap, RCH_INT_MASK, 0xffffffff);
> +	regmap_write(aml_dma->regmap, WCH_INT_MASK, 0xffffffff);
> +
> +	ret = devm_request_irq(&pdev->dev, aml_dma->irq, aml_dma_interrupt_handler,
> +			       IRQF_SHARED, dev_name(&pdev->dev), aml_dma);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "failed to reqest_irq\n");
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id aml_dma_ids[] = {
> +	{ .compatible = "amlogic,a9-dma", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, aml_dma_ids);
> +
> +static struct platform_driver aml_dma_driver = {
> +	.probe = aml_dma_probe,
> +	.driver		= {
> +		.name	= "aml-dma",
> +		.of_match_table = aml_dma_ids,
> +	},
> +};
> +
> +module_platform_driver(aml_dma_driver);
> +
> +MODULE_DESCRIPTION("GENERAL DMA driver for Amlogic");
> +MODULE_AUTHOR("Xianwei Zhao <xianwei.zhao@amlogic.com>");
> +MODULE_LICENSE("GPL");
>
> --
> 2.52.0
>
>

