Return-Path: <dmaengine+bounces-3047-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9209096650C
	for <lists+dmaengine@lfdr.de>; Fri, 30 Aug 2024 17:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ADD8283861
	for <lists+dmaengine@lfdr.de>; Fri, 30 Aug 2024 15:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832A91B3B1C;
	Fri, 30 Aug 2024 15:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VJ3dg2EF"
X-Original-To: dmaengine@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011016.outbound.protection.outlook.com [52.101.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D671D1DA26;
	Fri, 30 Aug 2024 15:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725030777; cv=fail; b=OfHD4Q4yIhWx7+658VkJIp8yw3IN5U3JVL9SHvHx+9NK2eIVdyV3PAPu9uxQaNI+V42FCK9hthLN/egaLDAPXCHmoBD2SgeMXSkOLd7QDEIr4jPASaTjwQvh3b/0BB2TLS39pcToktbIX9dnCo8nnSQc2ZqrM/UdZ05sbQOQKic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725030777; c=relaxed/simple;
	bh=X47OW/5ExQFGlm7s+dDt4bj9FAGbPN4VB42EQ72GEV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o6V96CizVnlbIG2M1tiMCfYyeDGhn2YfTsJ5c5qvv9pLF2Y0k8agcAKZYpr6Xa+UBQJSDKnf5KjcOE1vAHGwVDtb2FMKkQhxTEer7ZwLXXGJBy2OiUKjm4OrlN+snqJWd8MFcQN8aaLopgufBvVzAcjfs/ZlPQD+N527HFHVJL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VJ3dg2EF; arc=fail smtp.client-ip=52.101.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=umbOl/bbv75VcFLu4UX/hgyfktQaLTH+bQPVmuP/rxv8MpJrI64sxdNptaRex1KEuJ+a24KUonAMYAtlKw1N2Euz1vV8DnNWtI7oE6tH0gRzscHiqLwdocrTEoJGmH8SarDRN78zcd/iPxw7Bp3BIJ8mjNhLF9RbON2xgWFnar6ClWl0hWvV2DbPVSyZjkFXuzXc4C49G0k07hErVYX5otj2T4zX08mgjahhJU+uYQNo1iBI5GT/rCaVws3T6K8J/emGpBo3OA6XhA+SftlN6gjqqVbdhJ7Vva8gp0xkq2zDp2IdOoKd8eiUQWV1mRkyhYB2rNonBAXrJX2n95aBZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=byCjaBIKnORTWbAon5LSZLuuEvy03+/ZalTV8Cqf+aY=;
 b=k1nV4fwuttQMKHQ/EJhZ1812Ud+GPVzMrzQpG95qmzz5toRAp0yuZcRMeov5+flYwdWNlTXeGGdWAwspSAQvObLoPhI4VpQL7o8Sm8Mdf/eAlDUlzxE3eQmVkUN17prSuPSZpoo4pX9c3qYvhWBJLCPP7ZnrZQbJWRUnOBa5n8SeBvR7M+ca4gyJ0zw3SXLvqha/yQZ1tHk6wwNU9lAvn9DHAtbRFaBUVC+DBwVrB1MYXpyuqJ1W67zIQfCRvaD58ioxqeqmpjaqhQAjmR4e5mTAz9rdk50JsifZ4cWpJrkd277kbFYWptnpA4z+iSmTbWn/ryKt0/Mz0K9pPX3fmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=byCjaBIKnORTWbAon5LSZLuuEvy03+/ZalTV8Cqf+aY=;
 b=VJ3dg2EFSn6j/jbJoR28sSXcZu15jRzlsMVOIbxUFAtsPfYZTlFeqwZ5vOzIjMXxrW7PZKbByBfG6rE71l/lf6D5fOTIjcW03i3saqkl4/s8gATl4AbhnHZMIbXwGHv5yVFqCp1dPmes7MVWYkar/2vP/fnN8S3XkQtuK/0+LZjuWSwpea99eG7Qw8l8lKwWwePWOWljFG4wb5Z1r+LMM7zjh9eF51yxGR7JETeTKP5GnijmnSlG0ndR48p8yVTEc5RSeKlLEfbC5NK3xCLMbm9qKrGiZ1DbSvw/+Sr/cC/vYCLzzwr/vuB8xVuzKmNbefoDVU2D5kEkomo7r75BnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB9100.eurprd04.prod.outlook.com (2603:10a6:10:2f3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 15:12:50 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7897.027; Fri, 30 Aug 2024
 15:12:50 +0000
Date: Fri, 30 Aug 2024 11:12:43 -0400
From: Frank Li <Frank.li@nxp.com>
To: Liao Yuanhong <liaoyuanhong@vivo.com>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v2 4/7] dmaengine:imx-dma:Use devm_clk_get_enabled()
 helpers
Message-ID: <ZtHha7SIuLQrBTa+@lizhi-Precision-Tower-5810>
References: <20240830094118.15458-1-liaoyuanhong@vivo.com>
 <20240830094118.15458-5-liaoyuanhong@vivo.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830094118.15458-5-liaoyuanhong@vivo.com>
X-ClientProxiedBy: SJ0PR03CA0270.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB9100:EE_
X-MS-Office365-Filtering-Correlation-Id: 9855f0ab-639d-4715-162a-08dcc90636b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cEoXt0Emu4DEoWaXQaQ2VXFxiGhmxz40NI8+SAeGc1LKR5eE2yTbV3cZ89To?=
 =?us-ascii?Q?bPb1URguKVbXloZb/sVptuSFiZLUb8jej2+56iqqZU+xM8Nva94sr5Xx4xuE?=
 =?us-ascii?Q?WoAfqu6Iwz5tWUScj/lt3NihqWZ3Agmof5NXyQ+xXWQstsAxITlO/CPR8nzH?=
 =?us-ascii?Q?k6tm6p/eEIM0j57pj6XTY26V4/nYoAhNw5LNfFcoQgE9rvKssXNl+knLzTMU?=
 =?us-ascii?Q?5t/8WKyXL5OMPUq1cqHI3blH58UhSnKvCbCKeZMafrzlqZRAiIy+sT/4YzMY?=
 =?us-ascii?Q?ArYy6sTVx/CVmBcmRO12QFu7k1oURhe0gvW1vYotirxTsuvgIXL3sK/Uk9n7?=
 =?us-ascii?Q?bBl0iv/rSOBXCjR3zBh6j8cqN49r9dKx0/usUkFFBwR+gqeqOr+ZSNIQtx3Z?=
 =?us-ascii?Q?LM3RLiVV3VWjWpDilGVUrWxVzf84Oxgy8I5XzDR7KTzdiZsOOZsIOSr8s1nd?=
 =?us-ascii?Q?bIMG4I2BPgNvZgJgK80G8jA9VgLjs/8WJPYoZL4BQhYJ+SgSK5hYlIyLLjIT?=
 =?us-ascii?Q?rfIQsquEUgajCnpkErWv3pY3TV66nSL6pbd3N4J7q3osnLIkvlMVOjfDnXKw?=
 =?us-ascii?Q?n9mcRKRrW9LF/MxDX7Qeex9rC63LOA3KZF+4ysB+2DH8sj3/I2mXWg+XBt1o?=
 =?us-ascii?Q?vG9qc622MaKhczevibvPvIrpKfkmAbs7S6lNHtYEoRdlKNBfUey9zkYQMNlX?=
 =?us-ascii?Q?2KmO8ybpT17nrBJglvV266MrHRmv8GUgj6mLtQIHyPH+OMIoJ87iBDA12ak0?=
 =?us-ascii?Q?b2aJ+uTogJnZFByBD7mp27n3fQjo1Q+lV8KlagbEpRmrJ0khlkG2Qh2HkPI0?=
 =?us-ascii?Q?E6wQj9tK9EHQNKf4s0MRMaTOkKIt+O2pGypadOYdalc2FpXgz5M/9MW+R8yo?=
 =?us-ascii?Q?mLbOh1uQiESza+laghXBItgicmsybaCSkUsFbBzHXlRPmBQUjdS1EAlUXoA/?=
 =?us-ascii?Q?uI4FOov1h/ZP4vCJ3otSQC7oU10fUcQShcobzQIYCFT73HecO6WDiWo27Il2?=
 =?us-ascii?Q?rTFlF92OZvuafhUFw6P+ypMzIAryFqbdpuMnzZTKZt4CVVRW+dd/UMb6dgcw?=
 =?us-ascii?Q?82ikzH/E9r7fMRJV59sJcKheqmbLjbZ9tGAixEtg0mWbuTcJdgXQeeqUrN9W?=
 =?us-ascii?Q?IfGw/tqwFwojALq3ZFsLCzxlWD8f9mJzYse6buvsNljlt76Xk4n6cn8Q6eBX?=
 =?us-ascii?Q?Qbh0IL5utRMGHVWH2vWJ/T11sT+Ab6l+6KjYVysSNm6L/65jdvtIIrcNe48Q?=
 =?us-ascii?Q?WfjbrnKP7ha1LfArTuySJp138Tu9UTQod9r1BhjGKeECygdh+QmkK7JW+Nl0?=
 =?us-ascii?Q?X33b4ZL3e2gWgnufCcW7aQOXO6CMQhyw1wQ4VNgNpLzNgfy7dHk4iKQA+Jtw?=
 =?us-ascii?Q?DkNDKzjXLn3Jd6z3hnC6BjqzOnWzNrk+BMCGOhYY6gz0bJL9xA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ca6DdOeeNu8O8R4pldsFJg+uYhbk6jMRfjHZIYyi4TE1wsHpjc4HvFtqrko5?=
 =?us-ascii?Q?7OlkNfbHKyNnSblnxy/h9D03k38IPxjsxMd3tBhz+fcxxT0ay8lRTI0Ya5HK?=
 =?us-ascii?Q?Qt3TvhkdsmO25AVTJf7i3MqVUQwWWzo/IMsNh/jg57+63i01QjNaBlKloTuK?=
 =?us-ascii?Q?PBS4+c7OuCQybDI26jCdMOdPuhizwa5W9+HD6KLJeoPQlRbrulj/u1gSZPpz?=
 =?us-ascii?Q?91dlg8DvlRQYEt0/wuE8Q887FW5/97Ssi/QqdtYZBYIegYJuJ6qucYLy1fCw?=
 =?us-ascii?Q?5m7/cS+l41QlNxuhQyDvD/vdTftdGbhlvC2BQi9qhNmQfdVzogVlkzPwkTkm?=
 =?us-ascii?Q?Wkux4vSmHWZkFyNArfHRxNErJVkUCB69UG9blMn9jjAXAsXhnB76KykMa9fs?=
 =?us-ascii?Q?plfmFG640+ZtnQ57mknip9dhQLoBkuLGWRBnZi86jNI9wlSWni9j8YHeQMuO?=
 =?us-ascii?Q?iNc4uUUDVu4wocBvoDYJIk/gsdBSrRY/HWata5ym3jNVJFbmY4oo1rKlLjlv?=
 =?us-ascii?Q?sQMIIivuvCmsvOaDNR1Jl5AMVRRtuh/oEhmYaewJT6AdTFS5p9TOspMJUZF7?=
 =?us-ascii?Q?ZgVPNqdB1lXbZTRM0x3VmdleqbOup/RecpoHaNW/AjB/OLT8iViOaG/86i4o?=
 =?us-ascii?Q?iGxhAkPis8fZ2cHfYmxYmKMMcdP5o3mezbcNJugauyocxmzOhXp9ZGQC3v3B?=
 =?us-ascii?Q?/sYDaRx+bSyGsv1BG6yDMngXgfyg6K3VMBPBaBgSz2tc/ajF/j7s4BOhPYlf?=
 =?us-ascii?Q?4qLEX2r9PXYgo75ZH+sbT54R6OGhQRcZdcMOMzhAQJoJ9ZE+SyVqFIxSOb+W?=
 =?us-ascii?Q?phuS57rfPaYfL8dEFVRHV08xxmcRVrN0x1hpvkGldV6k/srGCYrU0/mmdQFH?=
 =?us-ascii?Q?yYcCEIBq7vGmEURIEeYuhMvAbH2C9cMUK7kW1CItR8tiAZKW7aH1I8d0ayhB?=
 =?us-ascii?Q?ymfM/vhMszA66+hf7bjxLh1B+tHwHmL78DRYkZiOaWf5zX0G9/LVgFzXqK2o?=
 =?us-ascii?Q?ym+ZCmgC/JbMpBwYUMabtaKRdqicWIjP5DaA67X+K7TmPj8D/SDN5p/wSbHg?=
 =?us-ascii?Q?mq8xb6jN1/0DWUqmWmWVfkemuCSJldkTBxm+mFiIc6/edaiRl1hR1b+52HaX?=
 =?us-ascii?Q?l91p8UDPX0ksW6TFwKz50gtlSqPCdweJf9Yvh1GmF+4HvsSHjWl8dcEeA3kw?=
 =?us-ascii?Q?+JTxQmMgUC3ZQBhEASk8UxUzibrkfi1uHM05136W+xCyrT7l2s53nUV8RgeH?=
 =?us-ascii?Q?CqywiVxpuF2VIA0Bs18NwtcrKyTuhIjh30PHUvKQ1i6cbs/f1zbJABNZA6Je?=
 =?us-ascii?Q?42SdaqwyQTp1JWrK0UeKlDegpAa0AhlpPqA3p3buaZRazOdU/fj7F5W/Cl23?=
 =?us-ascii?Q?+CfYNP1UAh41FpZVgACLNk366bbezYgfagTP+uUmBiCEL3avXCz/UKX0Ng7L?=
 =?us-ascii?Q?dIugDLWEdFyCZ6vPMpJz+JUVfkXC4Duff8blt6e8YU1iHmb5NtR6VVohEcfS?=
 =?us-ascii?Q?GTcGOTiqjJx/FHr8mBWZVvYkwlyv//pmhc8IJ1iHk2jL0mEdv09xvE8BDVRA?=
 =?us-ascii?Q?ntS1j79IIA29HkxvXPWJ73ebSSKa/MCBqUd1Cmn0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9855f0ab-639d-4715-162a-08dcc90636b5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 15:12:50.5538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kqPw/tVmZJpF3mBp8yxJiNbB0dy+8IgIpfgBkTPtwtf3jzIFWPxJNVpBTa82Eeqg789tt6res/x9dQQKVSp4Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9100

On Fri, Aug 30, 2024 at 05:41:15PM +0800, Liao Yuanhong wrote:
> Use devm_clk_get_enabled() instead of clk functions in imx-dma.
>
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
> v2:use dev_err_probe() instead of warn msg and return value.
> ---
>  drivers/dma/imx-dma.c | 59 +++++++++++++++----------------------------
>  1 file changed, 20 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/dma/imx-dma.c b/drivers/dma/imx-dma.c
> index ebf7c115d553..7178e9643102 100644
> --- a/drivers/dma/imx-dma.c
> +++ b/drivers/dma/imx-dma.c
> @@ -1039,6 +1039,7 @@ static int __init imxdma_probe(struct platform_device *pdev)
>  	struct imxdma_engine *imxdma;
>  	int ret, i;
>  	int irq, irq_err;
> +	struct clk *dma_ahb, *dma_ipg;
>
>  	imxdma = devm_kzalloc(&pdev->dev, sizeof(*imxdma), GFP_KERNEL);
>  	if (!imxdma)
> @@ -1055,20 +1056,13 @@ static int __init imxdma_probe(struct platform_device *pdev)
>  	if (irq < 0)
>  		return irq;
>
> -	imxdma->dma_ipg = devm_clk_get(&pdev->dev, "ipg");
> -	if (IS_ERR(imxdma->dma_ipg))
> -		return PTR_ERR(imxdma->dma_ipg);
> +	dma_ipg = devm_clk_get_enabled(&pdev->dev, "ipg");
> +	if (IS_ERR(dma_ipg))
> +		return PTR_ERR(dma_ipg);
>
> -	imxdma->dma_ahb = devm_clk_get(&pdev->dev, "ahb");
> -	if (IS_ERR(imxdma->dma_ahb))
> -		return PTR_ERR(imxdma->dma_ahb);
> -
> -	ret = clk_prepare_enable(imxdma->dma_ipg);
> -	if (ret)
> -		return ret;
> -	ret = clk_prepare_enable(imxdma->dma_ahb);
> -	if (ret)
> -		goto disable_dma_ipg_clk;
> +	dma_ahb = devm_clk_get_enabled(&pdev->dev, "ahb");
> +	if (IS_ERR(dma_ahb))
> +		return PTR_ERR(dma_ahb);
>
>  	/* reset DMA module */
>  	imx_dmav1_writel(imxdma, DCR_DRST, DMA_DCR);
> @@ -1076,24 +1070,22 @@ static int __init imxdma_probe(struct platform_device *pdev)
>  	if (is_imx1_dma(imxdma)) {
>  		ret = devm_request_irq(&pdev->dev, irq,
>  				       dma_irq_handler, 0, "DMA", imxdma);
> -		if (ret) {
> -			dev_warn(imxdma->dev, "Can't register IRQ for DMA\n");
> -			goto disable_dma_ahb_clk;
> -		}
> +		if (ret)
> +			return dev_err_probe(imxdma->dev, ret, "Can't register IRQ for DMA\n");
> +
>  		imxdma->irq = irq;
>
>  		irq_err = platform_get_irq(pdev, 1);
>  		if (irq_err < 0) {
>  			ret = irq_err;
> -			goto disable_dma_ahb_clk;
> +			return ret;
>  		}
>
>  		ret = devm_request_irq(&pdev->dev, irq_err,
>  				       imxdma_err_handler, 0, "DMA", imxdma);
> -		if (ret) {
> -			dev_warn(imxdma->dev, "Can't register ERRIRQ for DMA\n");
> -			goto disable_dma_ahb_clk;
> -		}
> +		if (ret)
> +			return dev_err_probe(imxdma->dev, ret, "Can't register ERRIRQ for DMA\n");
> +
>  		imxdma->irq_err = irq_err;
>  	}
>
> @@ -1126,12 +1118,10 @@ static int __init imxdma_probe(struct platform_device *pdev)
>  		if (!is_imx1_dma(imxdma)) {
>  			ret = devm_request_irq(&pdev->dev, irq + i,
>  					dma_irq_handler, 0, "DMA", imxdma);
> -			if (ret) {
> -				dev_warn(imxdma->dev, "Can't register IRQ %d "
> -					 "for DMA channel %d\n",
> -					 irq + i, i);
> -				goto disable_dma_ahb_clk;
> -			}
> +			if (ret)
> +				return dev_err_probe(imxdma->dev, ret,
> +					"Can't register IRQ %d for DMA channel %d\n",
> +					irq + i, i);
>
>  			imxdmac->irq = irq + i;
>  			timer_setup(&imxdmac->watchdog, imxdma_watchdog, 0);
> @@ -1172,10 +1162,8 @@ static int __init imxdma_probe(struct platform_device *pdev)
>  	dma_set_max_seg_size(imxdma->dma_device.dev, 0xffffff);
>
>  	ret = dma_async_device_register(&imxdma->dma_device);
> -	if (ret) {
> -		dev_err(&pdev->dev, "unable to register\n");
> -		goto disable_dma_ahb_clk;
> -	}
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "unable to register\n");
>
>  	if (pdev->dev.of_node) {
>  		ret = of_dma_controller_register(pdev->dev.of_node,
> @@ -1190,10 +1178,6 @@ static int __init imxdma_probe(struct platform_device *pdev)
>
>  err_of_dma_controller:
>  	dma_async_device_unregister(&imxdma->dma_device);
> -disable_dma_ahb_clk:
> -	clk_disable_unprepare(imxdma->dma_ahb);
> -disable_dma_ipg_clk:
> -	clk_disable_unprepare(imxdma->dma_ipg);
>  	return ret;
>  }
>
> @@ -1226,9 +1210,6 @@ static void imxdma_remove(struct platform_device *pdev)
>
>  	if (pdev->dev.of_node)
>  		of_dma_controller_free(pdev->dev.of_node);
> -
> -	clk_disable_unprepare(imxdma->dma_ipg);
> -	clk_disable_unprepare(imxdma->dma_ahb);
>  }
>
>  static struct platform_driver imxdma_driver = {
> --
> 2.25.1
>

