Return-Path: <dmaengine+bounces-6486-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE0FB551E7
	for <lists+dmaengine@lfdr.de>; Fri, 12 Sep 2025 16:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 639EDAA7E3A
	for <lists+dmaengine@lfdr.de>; Fri, 12 Sep 2025 14:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC41630E0D1;
	Fri, 12 Sep 2025 14:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fX/jKAgk"
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013024.outbound.protection.outlook.com [40.107.162.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1D43064A9;
	Fri, 12 Sep 2025 14:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757687957; cv=fail; b=qjsbdzqE4ElfMSAOk2D+8Ye2L/Ob6M7cYyQNm2YhUYWy1evCgxFLpp2te7H1MDL17DQ2FRGCq3U4gI3ptIBl13aNOS7pI5dQljeAqPwKmrAwZbWPj5mKgXCEiUv8ze29RGouy6KE/VxDqGXN4BIo6Mggvyf/ZpkWTpUmkm86kgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757687957; c=relaxed/simple;
	bh=jlW6cGHO+qkr/npPTY74If9Hf/NLtWPlfC6P+/gIObQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lPo8ViM98IHMOkHzg64+vMkLiqOyqF2bmoiC9IGDPNYMOQFkxnZtHfAbdOW31yD6HsNjDHCPoNiVgratZsy8NNH7V3DzPq1X6ocRMfvCiEsmXWMYljcZ7hiHlseEcoXwo+Nc25UClSJ0ilH1G7EUfTrCS+V4pYmrxRoCsgh0wkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fX/jKAgk; arc=fail smtp.client-ip=40.107.162.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n0fPX6vU7pVwYvsHOjk1QWDR+HX1u8u29aCGbt9zT3zeo0//gg7tHwTMC/yD+DjGC3DPhETqW6rkAAljVFVvSmw6OF03K2MAraOYkmAF62LDCfaHpGpzT2l8nmz383Svis08C/NQQyIhr0f8f8ED5aT7af6ITK2fE1uoPwnNirz68GFOaZmzNWr4v2NsPGJyk6R+ChKYtN4Ca1c87gBNiRf4KDYebzzxAOZr6Ahfh05ZG39yg1Mh+bGMEKyCeE0ABKNVNht+43hs7+HkWUgIW0uBR+VMvb4VwF7KQetAhjIEWHVvTcleDKDcXQHNymRTaz7SAxMOzBk9qUhjgGTjUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95SXKGCLX4ekOF77KTWB/dIwFMEt/ZEEUnPlI437+fs=;
 b=xr/kMEKklgoQNQ1vMkaG6UUBnYFO9eWugr8iFG6YalGPEHpjAOXpfTrGSZv8sA4ZSlfFkECaTzP+GjL+9qsWWzVpNCEQswQtK2tX6jG99sexabyXdCJ2nim2seFqr7yTZgksirA41NMinc9qxpPS7SVnREPsN9XIwcoA0RGE818elXVyqKJGLtvsroe8TzW/vFTZjpkcOBpYw+R3H1Q9NIqzFW9aHdaazAlql4iGE+TZxxzTx0KFrPdiqi6HWIJgK3M2PISi7Mx6gp8ItBQnN7tbhR1fOiaFbrG0o2f8MOXVVhWv8J/c0u6bE8iEEdB+9kGQL7mi6R4cUoZ+pmBbGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95SXKGCLX4ekOF77KTWB/dIwFMEt/ZEEUnPlI437+fs=;
 b=fX/jKAgk5fjwL5pjcdE7am/4xa9RIf8nNXoWLssY88sZgvtPDE70/5DOGTtIH8xq0dEpRHqfNcZp3lhZU1ui8FHiC1ZRWwSkOvOS8XrxJNhLoJY787ttjzni+68OAa58F9dgZHArJdRnpPnY1NFDxlrxQGI86Y05jsnVeQbltmkaqnLLqnlwygE4p8mxlaY3gVxlZFdUr/UvFJlnXIAaSrbF/n/RaQuzHz36XsdOBWt+cQ9G1O5cqgh8i6M8PPRrCs6ONHt3bKVfw6ZPtdX+2ENZaYSsvhRmXrjEpzVYnQFwZ+EpJmpcY2PP+WYHmgBY7cYkIXrzomwM+VG3XJOQFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by GV1PR04MB10243.eurprd04.prod.outlook.com (2603:10a6:150:17d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.17; Fri, 12 Sep
 2025 14:39:08 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9115.015; Fri, 12 Sep 2025
 14:39:08 +0000
Date: Fri, 12 Sep 2025 10:39:01 -0400
From: Frank Li <Frank.li@nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jiada Wang <jiada_wang@mentor.com>, dmaengine@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/10] dmaengine: imx-sdma: fix missing
 of_dma_controller_free()
Message-ID: <aMQwhV7DrKPCwMuP@lizhi-Precision-Tower-5810>
References: <20250911-v6-16-topic-sdma-v2-0-d315f56343b5@pengutronix.de>
 <20250911-v6-16-topic-sdma-v2-1-d315f56343b5@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911-v6-16-topic-sdma-v2-1-d315f56343b5@pengutronix.de>
X-ClientProxiedBy: PH8PR07CA0048.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::19) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|GV1PR04MB10243:EE_
X-MS-Office365-Filtering-Correlation-Id: e5f472b7-960e-4d53-a62d-08ddf20a21d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|7416014|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w914735Qu4pGMysf/t9pv72afl9ab8ciDcal241uCCHkDIgnQe4CJd0/AX1W?=
 =?us-ascii?Q?CB5aMqq9y2CSBJ/x3ohyz3ER5GcZw3kyIG9I8Re/JzBYauiWNS95OWw+GWx+?=
 =?us-ascii?Q?4MKnTbySVB0mMBl4UQwCViIvoGFRBVWRqTY3Ue5RmOBhraiYNoDt9ZCTZeEH?=
 =?us-ascii?Q?Nw7rXcSM4+gpRqoGVDsnoavft/eaCA6X4bPTEaa48bLLkbPNYjy1jQIemV5E?=
 =?us-ascii?Q?ayuqEQFQt5S+CpIyKXFTdn/SGeh8zwA3Rs33ZAqeDAagZ6HK37h7kM6agem7?=
 =?us-ascii?Q?NkdxESt55XjZr247It/Zh4lb1zn/CMWC4pNzlQF2FSX4+4/C7lQ7jtzzF0pQ?=
 =?us-ascii?Q?KlnXvLxtx2NP+stppzr0FROFEdNzTlWOka0Lm0tEHdH5OpTlLVI7X7WY2JpG?=
 =?us-ascii?Q?rFV3HCWfk5aU9Jgng7PyP90VaTOB4aAr+iBcTPYN2/wzLngebonNdqt5RNSw?=
 =?us-ascii?Q?UKN7wHhxFzKEnCSvRsbnwvGVeGHjTtEmzX3DFaNv0SGH+f9PX9vYqluWmA6q?=
 =?us-ascii?Q?Z9Fw5hHzAfD4PTMnUHqExdee6BtteE/vncNDkm2Vpscew5TbuAEQGpMR6EH9?=
 =?us-ascii?Q?csW0+Db4XuQtULGttqng4vR4OpwrIgau2YxPDKJi+qs3alkpYR9HhlJjSmrK?=
 =?us-ascii?Q?y1EfBkB6Rv7KySr/x5OJ/0hu+5cLFQDwKb2RyLtwQ0MP3eqbj7Xrlnw5+Plj?=
 =?us-ascii?Q?JlF55tzAs76hPtu9BhfgDMqG/rOAZ4Hh2qCna/REKXwgzmjaQdsJ8ZH8H7CW?=
 =?us-ascii?Q?A9P5WmvQl4ySruSKOAIaSExccyc3h1F4ZrGKSFbhW8uvlGuW6UHHFFlN22V4?=
 =?us-ascii?Q?F9xIQ+aUvmrkXuBzUaMrI8va9H7+5mKaIphvOumYfV6OTKCpK3NNta1xWv62?=
 =?us-ascii?Q?UZkK1U63QxScy5o/+NDJM6cNByGNRkTZDbYrvd/KG9nM29USmZdhfId/mz13?=
 =?us-ascii?Q?s94HqWLLFy8LER28W1fYfNKe3uXKWcKIJT0iQ59Lshxzt39a18oSE46utvPd?=
 =?us-ascii?Q?XfbDw3X/f+PVUho/qZQgecr76MDbk+n8fI+W1SrF+fFOKr09E2V4m41GZiLC?=
 =?us-ascii?Q?qs857cX4aoyrVKRouj/pSHDR38EoYkujWb9DR1saZNaHWBVzKwlL/RfnmXir?=
 =?us-ascii?Q?aHOVeFYs5MDbeyCx3n0vV0wqAlBV0iOlObMoZXif2NDIFXcYUx2AU3N0FT2H?=
 =?us-ascii?Q?26JxNBIM6PbwVIVYeFCEmFpmzMwaaJcuzcVorWSMcOqeEq4OerbaMj41P4U0?=
 =?us-ascii?Q?Iq3ygEgwp26sBA7k9KotKbXaN3bLGGyueRSAAGoygwrdQX5OGlqUeYfPgSEt?=
 =?us-ascii?Q?0Y5ktSdgfn4qsNclV4SJdjqAmqFAFmCcJUMZqHj1NAritiTW6HuutRe4Figc?=
 =?us-ascii?Q?X89ZVp9OB9BPyzoAG/wSVuX+gwHnbGvWwj79vL/wbnFxGaGA05UpaXvpBf9P?=
 =?us-ascii?Q?lMU82gBVBubgXgKivdKdcQ1PDA/IxmgSmtToIoee9wlB5OwVdtVUMw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(7416014)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l3xkD3lllGw6MQOD27Gk+gwZ4XPwGHnS7HYl+O2jsD6v6pJH3yiBa4gWBGFr?=
 =?us-ascii?Q?4td7T/FW/Le0YPaYZj8pB55YE8e5ZJeGTEhiuHOGV8NKqTSmyj1/wPpFZN+B?=
 =?us-ascii?Q?pkTlSgff8O3py8Mhe4HoS4jJgAo/j54YeESHdTI3uae/gHRVBGSwUUXbtnbU?=
 =?us-ascii?Q?ZYPtXPgykUoVAc7ntKwFWqqB9EEqZBH+NKjZ1VvPw7NnLs5oi8IOowNeq2qk?=
 =?us-ascii?Q?1zySLGayKT+K43xnz9G6Xdo1RWjoKHVdMtKPu1qQi8CP+dbNZEMK9x5k1lAk?=
 =?us-ascii?Q?Uu7Vgwt9orpCV75hyeKAtfP2EuFb39+si8RIB+fuWpSquRo2yBU6QKxl0R9+?=
 =?us-ascii?Q?+KXktwmr3fLx6Pu1hZ9dEzbfVtULMPgnJldm8mE2iCZg8J/0eG9Qog6D3afT?=
 =?us-ascii?Q?kf/+emGkhzDEddtzuaACPTMEMO6GVn+o0yYsrn8Bhm7U34+Fz0F67KNQcJmA?=
 =?us-ascii?Q?WJvHMtJdtvFpP8Nat6BLBVqpZ59xRQ1G5OLjk9XVGpQ11cY3pd0IeyT0Qgx6?=
 =?us-ascii?Q?/Cukb9ATywqStcbXcp/Gza0KHYpjQXMvtZyxHGMqBT8VhyaZnaDJGjlAZV5K?=
 =?us-ascii?Q?195mhwS6434w+uJhiKYPNNiJXxgpeJqN3CUbvGKpPCnKKlRk5HnrZmC1RR37?=
 =?us-ascii?Q?ETirlNubvuyTbFM0FBdaDVe/kU0445mic/4UgOZvICDIB+qnAQi6ps3fUbDN?=
 =?us-ascii?Q?7SjSyrSzTERdZV+ZI6wdS8ktzNymwTWVcgk54R3GsHx2vWZKXMUYZZ92sKC3?=
 =?us-ascii?Q?mN/ymgkHH394vktdfbR6oZF/JtA9qdwlEk5ohlpEdfCDd8VivkkOC3elFwFw?=
 =?us-ascii?Q?CWvDkT6eNrAHTi/xHCQ4QKSCOo4reh6j5qqcOnHLq73Yz5ZwbvEQTlmlNuH5?=
 =?us-ascii?Q?rfTJSo0haKmvTJygOFh6hh9L+hoQMrm1Yog5VFhLCx3LxJF9oBVAfWQMpuJ1?=
 =?us-ascii?Q?qBy73CHNaBsB70KTAfiL/TG7bnhN8LnPdBXaIM48bJoi7JWMyFlM2KEITU5q?=
 =?us-ascii?Q?wnvmfal/sUHm3jsL8K1BIQ1f0dtk/RPWzJgwV5/yG2WGOfOXjABWhJFoTq4v?=
 =?us-ascii?Q?b1pE4VzfZg7GXCKc32Vh3W9MIJ8wpOZgVdWuD2yXriKpk4EFcggrXkQWWeHq?=
 =?us-ascii?Q?8q3I+Xz+7NXdZ1X8UNbR0Dy9/f2ScavBZDqbUje7Zg2zG+aiw4NKIwqPKTfp?=
 =?us-ascii?Q?PYdT9JB7ywB+MCwYJY+EouhRh7eBrzmLZZu7IWY+Xl9qqO9XFtx2j65Xy6Ry?=
 =?us-ascii?Q?vQ2sxP9rK6FL5VSrkN1JTYfdLOimtUOcgQpcBqMYF8nJbaX37BdEKCVUMC+b?=
 =?us-ascii?Q?GS9CLXZagxTuADGe2b8BFRyHuHhRyxZJzJ1ap+iF7UKAQXMh3ek/KFmJXd4w?=
 =?us-ascii?Q?6BJgGm76sjp0WYCp3ysZfwF108OSUTlEOaQjJ9eff6YnsUdT8f96UncL0voS?=
 =?us-ascii?Q?x5gPwyPrC8JNHztrQKDMlfMCu1c/TU+LtosXqdoN7QTeAQwjS1G5VQLG6ou6?=
 =?us-ascii?Q?LAzdvr36724idSTzCJ7Q20jaDFdzCJaluIJIkbn4Np2PgcQqLmOSalNiLSq7?=
 =?us-ascii?Q?wsvv4jTifm0bQVMQGzClSqaGt268D3H/i4629sjt?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5f472b7-960e-4d53-a62d-08ddf20a21d2
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 14:39:08.8533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DfwERywNis6lcovApoS7N6QkwkMBAvzY2a26Sd1vN64MjKRt+sNqlBhmkPGJyApOdhaHwNESt+l88TlAsQyl/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10243

On Thu, Sep 11, 2025 at 11:56:42PM +0200, Marco Felsch wrote:
> Add the missing of_dma_controller_free() to free the resources allocated
> via of_dma_controller_register() during probe(). The missing free was
> introduced long time ago  by commit 23e118113782 ("dma: imx-sdma: use
> module_platform_driver for SDMA driver") while adding a proper .remove()
> implementation.
>
> Use the driver remove() callback to make it possible to backport this
> commit.
>
> Fixes: 23e118113782 ("dma: imx-sdma: use module_platform_driver for SDMA driver")
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/imx-sdma.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 02a85d6f1bea2df7d355858094c0c0b0bd07148e..3ecb917214b1268b148a29df697b780bc462afa4 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -2418,6 +2418,7 @@ static void sdma_remove(struct platform_device *pdev)
>  	struct sdma_engine *sdma = platform_get_drvdata(pdev);
>  	int i;
>
> +	of_dma_controller_free(sdma->dev->of_node);
>  	devm_free_irq(&pdev->dev, sdma->irq, sdma);
>  	dma_async_device_unregister(&sdma->dma_device);
>  	kfree(sdma->script_addrs);
>
> --
> 2.47.3
>

