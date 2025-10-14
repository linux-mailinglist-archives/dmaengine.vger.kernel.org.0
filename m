Return-Path: <dmaengine+bounces-6846-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E60CCBDA773
	for <lists+dmaengine@lfdr.de>; Tue, 14 Oct 2025 17:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D8753507BCC
	for <lists+dmaengine@lfdr.de>; Tue, 14 Oct 2025 15:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3FD2FFDF4;
	Tue, 14 Oct 2025 15:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="W6rLL/w7"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010039.outbound.protection.outlook.com [52.101.69.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F3E2FFDCC;
	Tue, 14 Oct 2025 15:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760456201; cv=fail; b=JXa5Plw2y0pjV39UfQE+vVq/sZDXDZQ/RI/S55AsTgEk//DhQhxsAUlWP4CDSAjqpkxD3rF3w3qxoM0egqBEekxAhtrQu0rGCOkXebRAofL99gy0aSs2sPyhVzB/6TO7DhnkH1S780CPeykIrxSXfh2s9INqg2yf3chIbB4hRPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760456201; c=relaxed/simple;
	bh=tPaEYcHt/8lfA6Z1CVeUSs5lcee77CVit4AX0u3t6V0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IutwG4nMT0ksLz9YoIpJZMm4MOXSy8cLQeRXthxjVhlyWvkl1mF1AuCqpzmnACIEyp9J3t1PtLl75Hs6PK8CNnlGKc+o93KBa65QhcYsJwgYrv5+AobLjfncS80Y1rtjkQOCxaIO2IjmVxoIOPHAwln95MqoAzkmUm7WseklPEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=W6rLL/w7; arc=fail smtp.client-ip=52.101.69.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xub/qexTsWHFKq3G3QIVotUyPZzZTEaMZE2keJY4aV1u2hrd5vneKXbIaropUZX8/kF7ETQnJkWxHRDpqxkAObZR3a5iRbUxjnVmg62+BIVYS1xVGiR/A6yLGvej3i0Y68O34a1FQIUQ2myPCpfSxFKzTNhSwkoZ4Rml+vl3Z+z5saAkZ5gkckHmXFBbqwmAUTmcyqJ+FNP0g/tWr18f4JHfCQgcO9mmZBK0p6p67PoW3rgqG/Y6oRfMYXqF6jFjqbfR5n5EJQwas6/DftxjtzlRvp/OHdOGaOikolhIVd+IfHMGhyeQrjpnc3T/HHn8Mre0ITEnvOGPRAmBeKr8JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BpcRW1UnGiBWoXFw3AUZO1xaoKlQKzG6gdgmeVVp5VA=;
 b=AYmkSyQbgJ3h0pJpdi/CvwvKqS9K5nM7P97jNfm3MgAV61Qu6rHJ3JUyhfD9QAabFoWxSrmYsw+8mtTvFUTX0ub2JpkIVJjaKh+Atab7s5fYn+Ps5EyabSjD0zXM9L+j5notF4ltk1HHvAXCS5LRvtxEQSOt3NvW+El1iztKP8eVoIUHNz6TGrLtJA17w7XGYJTPsVWTjCktb38t+Wth5PEmcA6lhFoAy2ZCIYNyDVVFwB1AokFZa32/gAWOJ9mQaSKCSdfc6E1zrTX9b/VpssUbLdk0IeXzt00RyYETvDlP/lIthnK6J43MthEbIVOtpYH21MbI9ofH8fd5MM2ozw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BpcRW1UnGiBWoXFw3AUZO1xaoKlQKzG6gdgmeVVp5VA=;
 b=W6rLL/w7CHsRXuS8UIiPPl280xEJo7aVGc1neROsnvtLPNgD/xic2488D0K4qBUcyxs9n8cH+w72eoNRWD1G8jAPx+AIGl8EbC2pzrU5GZla6T2uXuj3Qp2Oxw9alotSQhIohGB1DVtkV8pG6AhDb/2MvrvkKK2tgQpafyIS8HicLMWmMMk4h+39aiEOHTe1dyv+enylVp7zQVnBBywKVc2IoBrGQTZ7vsSE9b0nyIMm4iHqBMe4ZtD92RvEZNtVet/BtHBJRWSU5GEZLiWPoVs9od7VPAtNEIIULtmuDQq1KM++kmaE8zSF7BAHOS7CDLCr0QUQOmad/h3duWEp1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AS8PR04MB7720.eurprd04.prod.outlook.com (2603:10a6:20b:299::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 15:36:35 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 15:36:35 +0000
Date: Tue, 14 Oct 2025 11:36:29 -0400
From: Frank Li <Frank.li@nxp.com>
To: Zhen Ni <zhen.ni@easystack.cn>
Cc: vkoul@kernel.org, imx@lists.linux.dev, dmaengine@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] dmaengine: fsl-edma: Fix clk leak on
 alloc_chan_resources failure
Message-ID: <aO5t/dHjLsfkaFar@lizhi-Precision-Tower-5810>
References: <20251014090522.827726-1-zhen.ni@easystack.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014090522.827726-1-zhen.ni@easystack.cn>
X-ClientProxiedBy: BY1P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::6) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AS8PR04MB7720:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b627801-016c-4040-7ede-08de0b377588
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|366016|52116014|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IXzKyNc9jZJcDjwqUEl3jzUUL+1HfngvkYM9WSaj4VCoHHHL4DBA3iyfofX1?=
 =?us-ascii?Q?/CrY6Rxl0+yt8b+I6WJ3c2f6e12x7Uk2//ePHCofoAvkz4YUfrS4r4yjhb3T?=
 =?us-ascii?Q?uKd8yMOOR0MIiVjbqcvDF3cXYldxuiGZruztTJqhq/aZlLB7/2EmOEJhNpt1?=
 =?us-ascii?Q?dfIzSo+JYsmbar3OVEFcgb1ObZHFNKIuHFG0W0s7LSBZzwkewPjfXP2FQKcv?=
 =?us-ascii?Q?leIU0Z1rLPAHTNMa6MUBKNKV9wf0Q9f/BsjiY7HLtwXG80xpTVMCzv1rra8e?=
 =?us-ascii?Q?iI+DEOpay/zIWKN8Eo0YN14OchyMYBI5wDSVG8/4D9Y03aGvJOaIMBiO3kM/?=
 =?us-ascii?Q?NksePCH+eaKbKMAIPGodUiL4isjdjIs7ngkxDb4XkeSNXLCFpYLZfHfhjI+7?=
 =?us-ascii?Q?qPSrz3o3OOnRcB/HicSOHT9C7g0kQJv0GdXWqiCwDEoHmXhAVZi46WmEAfwp?=
 =?us-ascii?Q?pqG7KaJ+i3oO9uBn3hx8tgTWNaPYTTCbJtshvegoVQxkqrkSRvw60dXwNiOg?=
 =?us-ascii?Q?lFlfO3mhaTSm8f9eRvW8qpTkbpaGWu34McuDMwXJPBBSCsB82H4Wcwlmh85Y?=
 =?us-ascii?Q?w2/fUnn0D0qLbWtSqam8X8C/cJgtB0gb6cYitv2XUT+ev6iYhA0vBjwEr25g?=
 =?us-ascii?Q?xM9JStpVygiHcQjJ2weuSdokm7SJDB8eD0tRDS5F6bK6nHPO9A1rLlCvbfoY?=
 =?us-ascii?Q?O9yn5S2mY5XwPrswRXc9Y9Og5ZROWgy/pmMWL59FxZvUZ1j6tLxfamIMP5uX?=
 =?us-ascii?Q?XfxqLcpdWCOaEjgHyNGTbQhyunwoKBr9mIMcCHuzS9fj3/8xdVbWOauQpIc+?=
 =?us-ascii?Q?+DT9J09eIuUfpjWk4b2c7VfZLQnEN55SA68jL5aoSwMfGxFDf6bjJH3DKJMK?=
 =?us-ascii?Q?oaY9J1HC7wjNrovzRx85s43CDB0xEFx+nRBaMytjb2T8IgwZdkFocVLP13Ae?=
 =?us-ascii?Q?brF3r3DGVyAlp9SkYlo1KFpb6O/3Mo9Rg7RVgGGMObdM8XhIbcwUGuGz8s3j?=
 =?us-ascii?Q?+bSwbMMqufX6NAbxCSh1V7mcXron+fEDUyMkeSq7GYmZSyG722VaZLyoCuH7?=
 =?us-ascii?Q?GHfZsgoIhvlN3PrO/iLv9cekopK+m7dcSIAuUzUn8898Qr+DKC922St6uP9C?=
 =?us-ascii?Q?kLM74VlooOGW+S1cbTwkeTKNwC7mQyaNcVcgWtoj20ZhkOD7TrJlLtgJqYeZ?=
 =?us-ascii?Q?U2I3T3DUbd7Pg3QFg7wWjSBtiB85rPxAzcTnA0NL/EwtWNa2hPuI+PBKOc2w?=
 =?us-ascii?Q?AQonYeyX6LClxrX6Kyi23+b37Bu/EomsqyLXxUVq2BDx5KL/JWN4cE7aFytW?=
 =?us-ascii?Q?jC+h4g2Kfcw+j9msMdKhR0q/rdlSYgs0da3STzgse6dkFXp7x4dm/cMxUF+w?=
 =?us-ascii?Q?whYNxTSoix51SijhXoapTNxuzguUBgk3o/OidcT5v5Jjbir9SusmdDKlsXX4?=
 =?us-ascii?Q?S6QeY8FyUwV7xFiWEnrmncyUp8DZXBsvo/wsuY4064o0bobrecBjzdd/S0mt?=
 =?us-ascii?Q?qNUpq6gKD7NLJ4xMXrSjfGBp1sx/ZV088Sms?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(366016)(52116014)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EvDglpQLUNs4IJHJQWXVKkIFxpWaAK3jmsuOGSuBO7biIpDpx/MBYFYI5Ee0?=
 =?us-ascii?Q?DF7oMb8OIW0kVAQaQJT3QP0Wqr4OLtTmuiza+bq3KoN1dkdmYhL37jDi5z7z?=
 =?us-ascii?Q?WZYrtDtmqIRsBZ2MnStfDRlBTV0UGTuzZqIEyaDE7K1dEKufPUcbjhXNLEE5?=
 =?us-ascii?Q?Am/d35vctJQxclqVdjHK0yFyxuRlbn4bd82cRujA1uCHtWFnNYjVAIPeYtSK?=
 =?us-ascii?Q?RAU/KE0hlRtFfPDsBs1DX1bFmczrec88sNwMuv42n6a0WNAWJVusqSFew0sf?=
 =?us-ascii?Q?zATJhiyoGBF7pIKEI47fGTGEGtKNk6WuzJqad2EScF4j7lOKP+z7NhyRLtWL?=
 =?us-ascii?Q?VKUzdxXZNvz9S5+oWvX+L1D/GRFdeR7hsQzY+pyUzttaE5sqwKDJAbg2gpSF?=
 =?us-ascii?Q?9UQprbKnT8crR2pj9lcpO2UPB6cWXa+Jzdm5jese2grtMywqsQ1Pu6O3wlnS?=
 =?us-ascii?Q?v6J3+A94kR2UpLkT3uVjOUSyPnoRE+fdciGl/TY8HEmzF31h3/xopGyU5CPd?=
 =?us-ascii?Q?X0vTHkSaKBjF1uTM68xinZX5ErN8Vevbbg1QQhiYUUDk9s3CAUBP5aiiW3Fp?=
 =?us-ascii?Q?9HSgIiDeGV5X3lUJ6/Kf5uEDQfP6KdCYSXCbA5vpRl+nif9w77xWWkOSZBRU?=
 =?us-ascii?Q?Z8DzNzDhZmeOltkXsq4K2ruxi4Bk/XF7EivcGPhvNEWGSDfDJymVjaiFdeKe?=
 =?us-ascii?Q?o2mKdR3/VxJYi5OYZ4cS2I7hp5n20Olq/dDLORY5uCE7TZHMdTYF7ZkJLZNg?=
 =?us-ascii?Q?CocPbSEPwN+e3zVbMbMlpdKIZYlRHM69PLddwlCWBqWPocgCgHFmJRe9ogDO?=
 =?us-ascii?Q?+nQM6o3RktNevjDi1di64KfTmLRVTY5Z/jUwDOqjkwvP0776Pf9PGd6NhbDk?=
 =?us-ascii?Q?ZdkZ2fGidF1ykUJM8VZ6UO/lGPFMGGfMVRod7ATTrXoK8jIuDiCqOoZOPIbo?=
 =?us-ascii?Q?xepuse4b3xxvAmDOyvmURVsTAU1wafbTbYeoBrCYP55kVr3Q/lgJiyIvmQxw?=
 =?us-ascii?Q?PE9NNTBYD8GTB0Gi480bmyuuQ8kyQ8VB2QsB9hgRE4fNXJGScugfA72PCvdO?=
 =?us-ascii?Q?i66gq10DqtVSUFmoN9vLNzmXxAExOWCg0euOp9Wn+7B1/4RQPSm2myDR8nMP?=
 =?us-ascii?Q?U1RUTze5J5SuZN8uWPGRvGGQCCzPvYt/+J2gP0LT+Q5bQZOTDnpqsKEhDteW?=
 =?us-ascii?Q?6LONRmVrBFWe7KEVRQfuowY9ns+VJjZ41pnMRpbFweKgcbdsnOWJyAAkRiwa?=
 =?us-ascii?Q?sXUqR4Q4Y3AmfO6k+hl8yzCRbkw8LbcsTc+cKiK7KdrvlXND6wY3bBvpdn3I?=
 =?us-ascii?Q?lIdlMAO/YH7RG07LlaXFXKHPCkTkCHsT5Q5dWL2RiFwxE+rmRHnGzKYgcN6G?=
 =?us-ascii?Q?cYrXAAQg8M+mjChhdNmxU/L3EZJZ6xgJw8/sMKJzKUVfvmOErJvbkMbSPX/b?=
 =?us-ascii?Q?y5Cra+5JtEFrpF6XQ0Xt545CE7gVSU9a6/mW+nT5mjpErRhFzJxSgYAimlwX?=
 =?us-ascii?Q?N3hxcfCjs9z37Zx3abrcvQVFxSS5Vqgan+zm7Ep0UfM/cegsvBx8FSzVHATm?=
 =?us-ascii?Q?1QMTs9ybmug27d9I9eLix/IOSD0OciS0RAt4sqyJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b627801-016c-4040-7ede-08de0b377588
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 15:36:35.7401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uObp0nhLkgYpK3TXshjX0dcz4PUt76FddpqCni6G4/1dEOExwbTPQ3k8fnNDIivkvtpVEwM+04hgGK50x3ApJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7720

On Tue, Oct 14, 2025 at 05:05:22PM +0800, Zhen Ni wrote:
> When fsl_edma_alloc_chan_resources() fails after clk_prepare_enable(),
> the error paths only free IRQs and destroy the TCD pool, but forget to
> call clk_disable_unprepare(). This causes the channel clock to remain
> enabled, leaking power and resources.
>
> Fix it by disabling the channel clock in the error unwind path.
>
> Fixes: d8d4355861d8 ("dmaengine: fsl-edma: add i.MX8ULP edma support")
> Cc: stable@vger.kernel.org
> Suggested-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
> Changes in v2:
> - Remove FSL_EDMA_DRV_HAS_CHCLK check
> Changes in v3:
> - Remove cleanup
> Changes in v4:
> - Re-send as a new thread
> ---
>  drivers/dma/fsl-edma-common.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
> index 4976d7dde080..11655dcc4d6c 100644
> --- a/drivers/dma/fsl-edma-common.c
> +++ b/drivers/dma/fsl-edma-common.c
> @@ -852,6 +852,7 @@ int fsl_edma_alloc_chan_resources(struct dma_chan *chan)
>  		free_irq(fsl_chan->txirq, fsl_chan);
>  err_txirq:
>  	dma_pool_destroy(fsl_chan->tcd_pool);
> +	clk_disable_unprepare(fsl_chan->clk);
>
>  	return ret;
>  }
> --
> 2.20.1
>

