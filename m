Return-Path: <dmaengine+bounces-2106-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D0F8CA099
	for <lists+dmaengine@lfdr.de>; Mon, 20 May 2024 18:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE33F1F21719
	for <lists+dmaengine@lfdr.de>; Mon, 20 May 2024 16:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6984453E0A;
	Mon, 20 May 2024 16:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="H2TB/QeS"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2072.outbound.protection.outlook.com [40.107.22.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4B71E889;
	Mon, 20 May 2024 16:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716221952; cv=fail; b=n6SH4Jyp1T/Qg4J/R9hyafNuJ5gwGMV3hT0xjCKoC1L4/hJKykg+2g7PWMV0xH++MpmA7Whyo2ji1DFXNkmcbCwGeBucVK0JCpURNN0DFWFj0zEm03DW4K61Tsjtw9/maI/C5yWgqy7sR87e7jR0d+VKlHGhm0XcsPOXhxwcht0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716221952; c=relaxed/simple;
	bh=/tHi6sAAtf0NioXwYvT3fl43yUep9qGBaQxaiZr/VO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JnjUwKb4bUozh8hoG9CUSKwj+16llpnFOxA2zQlyKcS3P2eYxhE/Sl1HH6sQzS2M20e3dLCmkeTiGytPwkHOtDcCw40r1o06yMMWAlJZ22GCdyumNUkELgwRvExJ5+b2Q4pFTAPi/m70/+s36JvgPe9SUwZBX4tGCfTIpsgzgNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=H2TB/QeS; arc=fail smtp.client-ip=40.107.22.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K7rRn1fSN6w9FGzNaY1nqN7Tmp4gv2Dpmc3dZ3fNXWG8SC5vnRfi7wVccz0gsUhqtx/s3Wj/BYyzxhFCpEQAno4ZPwNm84ZdLL9WZcRkGE+J/jysEWj3VbMskmPlHDy9IFC0cktWNsitqgJwKsPHHhYnrqM9PdKlYj9kv6M8WuC05+sSz2FujKYf8oDDgvrcihluqqzZPkAEW6dINRaqFhQZb6R9xpoJI/+6NgczaEeFB8MomXFoxOCx7Nrpb2gca4WL7RHIjoMdAwqhM3bRjowNRZIUWRkd0uP55E36MxBvsp83UrlPxvAJg85qmj0bCUhxMqH225ksy2EX2FOEDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a9SNZCNqI0t7E6ms/mZkxA3BWNTSiwIinksHjknmizs=;
 b=T3NIL8W0VUiMCwTgKmxoEr+/lxRw64oSTOdbXlgxoASHB86JWRsHrp03HjPa9oHvxOn2WBTl5S5PYcTitEvz57T9uPj/ewtY4XW9aOqcIHNszKeLmIXWVx1yMAIl+OgyXIyISPlgWG8a8LtPFaLQ+mMRgyTtqVxFOcZxEcDN8e8ZE9+aZDhp57l7A2UgXxeF20Ne7MQdl4SdGKEn+feBTZfwzLs8MZoVVLtMRXSSoj6DbXtvSlXgVLZPg09ZMzQH+Hd1Kaws3sApojtvUOGfuyJ5Jp4fEUN6M1iq9vo4AWZPhvm1pty58xMMxamLJ7OsqKysyFk/OEPT/SdWLiLOCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9SNZCNqI0t7E6ms/mZkxA3BWNTSiwIinksHjknmizs=;
 b=H2TB/QeSU7OGZ9PgzoTCSxGD6rpleGb/0LDh71l2M2TUPuf9f3+0E+9WAAs3vTwrytBOwzdhZmBA0F1+8WViftkQ/goLVV5TNHzJ1c0cZQvU/qdz9WutxNCyDCVmcgqzfKwbjgaYFDapPwoCjqyp7FQdx1EE15ucAYvNJ8OE9DE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7727.eurprd04.prod.outlook.com (2603:10a6:102:e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Mon, 20 May
 2024 16:19:04 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 16:19:04 +0000
Date: Mon, 20 May 2024 12:18:58 -0400
From: Frank Li <Frank.li@nxp.com>
To: linux@treblig.org
Cc: bryan.odonoghue@linaro.org, vkoul@kernel.org,
	linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dmaengine: qcom: gpi: remove unused struct 'reg_info'
Message-ID: <Zkt38n0/OED7VHJ6@lizhi-Precision-Tower-5810>
References: <20240517234024.231477-1-linux@treblig.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517234024.231477-1-linux@treblig.org>
X-ClientProxiedBy: BYAPR07CA0103.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::44) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB7727:EE_
X-MS-Office365-Filtering-Correlation-Id: a1e8dd33-81a3-425f-088c-08dc78e89167
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|1800799015|376005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kPBkTZX7W+AdZ4eFF7TbJQWdxfXqklfboHC5tLQA4A2AiGLeMuvHTUe7X/Xw?=
 =?us-ascii?Q?SgBTVC27TKvJ2cN3GykAtKrEbe/8Dpbot4eN2zat52Rk2N/PsmbGQnj6ebuJ?=
 =?us-ascii?Q?2G0bupAsWY0sELrkqyjNqU2DmKa+tYTfzAod3qbGWJAplAb9voJ1J1tv+DXw?=
 =?us-ascii?Q?SQbPXG9T8bOP2N0NeQKZ4IP6w7Thb1hcfXAQGgxXtQJ3YSy4GqOvDgmUTfyU?=
 =?us-ascii?Q?UmjuraBF1W0wRb6u2/KBD86FSE/9hpi42AQCe21Fd9p19TNX/myLbcsLjFTq?=
 =?us-ascii?Q?9lS1vvq5oPQ+aYbwnXURQlc7ObkKWoKAR0xq69LlT+KWq5fO1A4Zp4H9KoMf?=
 =?us-ascii?Q?NHOJ4egRAcZYbr81dqvg8kYrx3sA3JnAOCciC74KVNBh+1JbVArXZua1xfn1?=
 =?us-ascii?Q?AIK0oAvN7ZI7XYXCguioQiOCmud9QgpbGprLSnSr9/CLgm+V7EyAzZFmoQMN?=
 =?us-ascii?Q?w9D87kTRgtO7TBnMJXnTUwzx/x6AKuGQuq2Nndp0mskJXFQNcpHefsG97cM/?=
 =?us-ascii?Q?m9j7t7giviRFZPpFHBAKHwOjfwkmXp7GMM0l2GcEJdCGLom7AbfWLJZ0NOaw?=
 =?us-ascii?Q?NZZjEqC9C5z4XsS7UaPgYPDEB3wQkiZ4b4rGJALAnYt1XmRYSWQRweWLaKiB?=
 =?us-ascii?Q?Z1Oqxlg1KT2z4uPVbR1Hb4RFBSFl/MSvk1oxO4qndm6EADz4ELf7nbCXuP/o?=
 =?us-ascii?Q?C7rjJhOxW5mkr4ylYdAAhJwdnb1acGGWtTIfrpcibK/BkyExzIauzgTPOnJK?=
 =?us-ascii?Q?SUo1D8xRjkhJZnTDcqD68Hln/l244Mhe8H6wVrto/HonXM4KmWSPtvc56vo0?=
 =?us-ascii?Q?SuR5UL2XC/SZmVUEJs/GOSKJWiepophUf3NhlINdwrIu9kFlQUwLf2DrpuHG?=
 =?us-ascii?Q?rV9DwkGIm1pdS+jZNwZqWbJ0zonENqwsnLmgaWc0Kh4RQ2CknwcWqFonzANs?=
 =?us-ascii?Q?sjX4gfNHYvWds79qySuJn3teMMWLLkavLLjhAJeuIePE5LJ3gjgChyOobgN0?=
 =?us-ascii?Q?oCun4nL9cH7Adl57Ud316LNZc4zB4NaojNci14W1GV/9KL5OxnjnHla2Z4Rd?=
 =?us-ascii?Q?YcJuFAZoo8+cjtDWWPFgWhCh7R3WrovoJAL5JbbY9bsO8rdkZq8Z8Ic/I2Aw?=
 =?us-ascii?Q?CevY4f2Nen0oHyQ4UErHQ8PAbnW+TbxmSvZ+hEOlGcXgzro8hCJrbrQHg9iE?=
 =?us-ascii?Q?+QYuzBbrDAAio9fsaoa+tyvfuyH2npQMx+UM9uACLk0qBfnxwPV426SETXhe?=
 =?us-ascii?Q?BiK7MgdvGZPkCquT1amE1au77uw107wixi+JLor0/JbK0azlJITbf63/083o?=
 =?us-ascii?Q?371OBtgh0eJ/rHAR0XYcK3g3IHCJKU5pXusYY4RwJ467qQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rjckFNjnkPpluUMernvUxBdDJkypI/YTbEYxsAsPtpfm3bbBx9GQfwFAB5/V?=
 =?us-ascii?Q?zPdsjURjGODrdD9Rz8QWqakHv+/GtSLU4x8l3CGdw2jYUqSHfRGicSiF3Nfo?=
 =?us-ascii?Q?sdJJUWpVIFA1hrOjMaoWHEXCDHaZCnoiFsltPDzAmgEKwCWqHHvO3A3khCKJ?=
 =?us-ascii?Q?UfFyc6ShKdiWnEDvh0CEE9G7tlwT7TFO2ZL4V2N/IU/Vv6wl9VLfieF4Hc97?=
 =?us-ascii?Q?LEUoDdMVYwlw37fO9SUxahhwxNrkqCpYabSKb8fzSIEYl02tjJFvASdGOBJb?=
 =?us-ascii?Q?/1RBHSoEqUKtTgTmgkMeEfyvtnIfQcBzW11B+lPj1/2WmZK1+ZyXVzUxdWHY?=
 =?us-ascii?Q?HBhr/++HtS4KZjm8PxTVPhiV36mOCJDxlWqmpBYtqZDS8B/W+SYxSSl2T2Ow?=
 =?us-ascii?Q?lhl2BVpC5BcbKOchDwEkwvv+kkX4X44x0lY1n2mTudSpQCQQ3kGkEmSbWzi/?=
 =?us-ascii?Q?6knXWK1Zx12ED5vsxvr1bo5m/13PNdzBPTzGG1DeUsou3YyqPcdyKHm2iFWG?=
 =?us-ascii?Q?gparJ3KvaZFfq04CoztVBLJZ2r2eZOZygUT1+9oOvLhGHaCmRbqbMOPASDng?=
 =?us-ascii?Q?jeQQF7fkHY92kZhGEtkgNJ2ye4cK8MdkcBdlgkAe6hU7i7YgrIPPWWWjQ+Xu?=
 =?us-ascii?Q?zz0pN9FYgjbQtFlvOUxyPS/9hcQJcGje81hIwpfeMbM+YUXoQhQGJu3X8Par?=
 =?us-ascii?Q?EHeN6QuqTSynuXUvZXeqk4aNAmQUVBSAkFU3nyxch3q4v9LIPlsKdSfPvh21?=
 =?us-ascii?Q?/xGaTcxsB4CYduhwFWIRZt10mXw4b+l8WqOpTlR846S0cL8YzwqTkhWX90/W?=
 =?us-ascii?Q?rPsy0CebjwHAB5Gnb9IamA947+ubKRO/t4Od9vzd5HYivdsZrUx0zJBRQyoc?=
 =?us-ascii?Q?xQdPMifHxHBESUAtr8WGPyHyU6cL4yqJi0r+EG6M999bHIcSjZGu9qt4mQ+0?=
 =?us-ascii?Q?dTCMY0VPGbujQ17qKz8gu8KgprHP6qpUUS6trLd3K+6LG2HtMk6oi13RBiB6?=
 =?us-ascii?Q?DJxRP6xDDh/G6lkl4K12k3/MEQUuQBiV7QILkL2Wsz6SjuWre5kJ5icG5LTU?=
 =?us-ascii?Q?vpiDzy9OwANUXrY9XUdolY8Fn0bu6l4jjhYJHkkQro9GJdA0E3ZPGy+ElXp0?=
 =?us-ascii?Q?JXKOhOA+LxaJNE2i14Ma7la8X/Ut7KIEJlbTC8rH85W7pau7qhPDHnRkyD39?=
 =?us-ascii?Q?m7qnDrZa5ztVGTrmkQDWjZpkdzyN2Aak87JLExG7x2DWTy/r/7TipYynk9BB?=
 =?us-ascii?Q?mgVu6w4pQXDRANpiKRL5kLmlDGDOaYSt4y31kquV/T8leTHkCjv4Ht5LJ2Vs?=
 =?us-ascii?Q?yn+iq2Apxet7fec1Lm8U1Ra1v2m8B/zErUjM+B4wscFkqBdQHL8MqOnCjYDM?=
 =?us-ascii?Q?ht737VqRGJ+wN09cwECT9g1+0hd11pPJJbRCxlhyvcyl+8/ehbS5KosHXvNS?=
 =?us-ascii?Q?3Nu34iwnt3RltiSa8WzBfpNF4qDv8lD21rCRy6RIcql5tFGEr4nvQ0yHVqf4?=
 =?us-ascii?Q?jPioa4TJCQJkHeC89qzH4e8qv5LYHriVnwFTmXtVhWVn4QsXazKWXlCR7xvk?=
 =?us-ascii?Q?0HN9YKYMd2EqR2xgcDY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1e8dd33-81a3-425f-088c-08dc78e89167
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 16:19:04.7937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SJT9i3SAV19hnz0ABg+w8hJV3kwBPR2nwlbve8qqfaGrHs268XJ3qwJKF7lUuyjJo5kolW2rFE2kHVvaPkWroQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7727

On Sat, May 18, 2024 at 12:40:24AM +0100, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> 'reg_info' was never used since it's initial
> commit 5d0c3533a19f ("dmaengine: qcom: Add GPI dma driver")
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/dma/qcom/gpi.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
> index 1c93864e0e4d..639ab304db9b 100644
> --- a/drivers/dma/qcom/gpi.c
> +++ b/drivers/dma/qcom/gpi.c
> @@ -476,12 +476,6 @@ struct gpi_dev {
>  	struct gpii *gpiis;
>  };
>  
> -struct reg_info {
> -	char *name;
> -	u32 offset;
> -	u32 val;
> -};
> -
>  struct gchan {
>  	struct virt_dma_chan vc;
>  	u32 chid;
> -- 
> 2.45.1
> 

