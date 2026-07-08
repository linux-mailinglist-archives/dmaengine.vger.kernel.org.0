Return-Path: <dmaengine+bounces-12148-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NsVnKnS7TmrQTAIAu9opvQ
	(envelope-from <dmaengine+bounces-12148-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 23:04:52 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 050A872A69E
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 23:04:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b="jNlk/OQ8";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12148-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12148-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A770304CA41
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jul 2026 20:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA0B3D093B;
	Wed,  8 Jul 2026 20:58:23 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013052.outbound.protection.outlook.com [40.107.162.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE3C3E5ED6;
	Wed,  8 Jul 2026 20:58:22 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783544303; cv=fail; b=QmLETJguaAJK75rcA8PzKlxiPbhdRLNj65Y9Prsk+B4Pe4E6VXxiEqvBo62M1FXQhCnjcgxpRZkK/BdgzS0iwF8HUBAB03JLfavFaVk6C77wXKruwoEWTMUnKq5VgpKGaLpmpBLzYkR3VUnsUK4MO8KeNVWMZqnW1+mnuYk5620=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783544303; c=relaxed/simple;
	bh=pzp0EwKoPFHYmBwWSlxxKQneG+dEZeplCM2NDYFKrQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o5swLjTTkuBNRq+Oxx43KhmWKfk2SThNed7cj4JfXPs3esXyj/1SfIsaahwlcmvLfLDc+ycrXOUhWWsA50xmktQS2754xrTv3b57Vs7jp68A+yvGA6O9N8Mb5fGcXW2DtzKBqgdEPUKAautKa0FnCs15aL4gRYcHm7mwP86vOIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=jNlk/OQ8; arc=fail smtp.client-ip=40.107.162.52
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yYNiEHYYwADSIdnc3LYcu9zSOLbboTU65bopzhTZj5t6a153aAGabfqWAyvvytT4PpTpOto9SA8VwzADlV+Dt7hrH1GOnUPdfzeLB4dEWbSvX0NjnW9Xcd/wElO6qc0EhkF0Kq1xAzxWyD2S3tTdrPiPB4UJhL31bJjNqB7CYL7LIZx7l0ZtBXDPj2RpdnsZgcUlhNU4gSv9Kn8kG+lyUJw8fA7Au8ZGIKZXcV9JkpJhTa6mjVE9pfP3dJh7utXHisFlmCHsr/a7YpmLFXEaYFuS+hReZHR2OmtOcNcyGNUnT3zRlau380X+LRxUbkxgtEGxpWL6Vmr2o+PHBuPjNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PGpN4MQAOW0G2+Qa5XwzwznJKpiVbFFo8X4MRmfl2zU=;
 b=uytokUHSfF5DqRZAYvr3gMDpcmrgxkIoX4WRNYdYBUlcCL8B4t/R4kLCDOslYKLc9joeTRFSpgSj2K+o4XZnSosDUA9bEL/TTgGmmNAz5EhYBgXRnPbJbGAZ/5ayVXl+1eZou3E5n6AdrWt72fvMaPuMoueLQQLc7+RxgW3GlS6xEjxXV37MPyPy6Rhb/qa+CFOsUbBpwnYo3LdfSMEZl6o8/D6C0wy1SzPV74+EHBRKVZ2yB6hQqBCqoWxVcEmvlU0LyPlf5rQiiH2Wk1MrYj0cE/4m5zlYQOjIu7OOpeHFE/FVgTJX8ALA/LBHk/ITDr7QM7+Ey5/uJohyZPpNYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PGpN4MQAOW0G2+Qa5XwzwznJKpiVbFFo8X4MRmfl2zU=;
 b=jNlk/OQ8fREFYb9z7koD+rCsv+fZE5ysdCrBWE+lCDsldaaNBXMrAT06fpCQmYtFu/cRDMR8svMwkZisUItvyaW8VdYIRMTD+g6WIRoPOdKZMevaPNV//QjD2WQJXwRtqLZB7ZPoiJ4c8e2Mw4pQiYa+/PAI8o3lnKOeZDLahxG6X7DqEjhFiGjBQd9GtQeU2ugw7yLrO2SMBPhGVMffKfd0sfeAphzmllDk9e4WtFqNa43kqHvsIAknHJJYWJeXyynCj97CW8I5Z/T0oYjd6bUCce39CCminRSzMciJ9J2Ztgyn2w4HBOZFH24TVnUDaZB5Klsh1pdiKLpDbOtzpA==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PAXPR04MB8815.eurprd04.prod.outlook.com (2603:10a6:102:20e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.14; Wed, 8 Jul
 2026 20:58:17 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Wed, 8 Jul 2026
 20:58:17 +0000
Date: Wed, 8 Jul 2026 15:58:09 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Griffin Kroah-Hartman <griffin@kroah.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable <stable@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Vinod Koul <vkoul@kernel.org>, imx@lists.linux.dev,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] dmaengine: fsl-edma: Add error handling for
 devm_kasprintf
Message-ID: <ak654b3IyRUHf2cw@SMW015318>
References: <20260708075736.47822-1-griffin@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708075736.47822-1-griffin@kroah.com>
X-ClientProxiedBy: SA1P222CA0010.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::12) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PAXPR04MB8815:EE_
X-MS-Office365-Filtering-Correlation-Id: 32b8a80a-1970-41e3-4855-08dedd33a258
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|19092799006|56012099006|11063799006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	OBQqLQmv8d6aCkyXd5ucWLKD9qX5fsdqpTq64iqNrouD34nfKkHStHmFIsYeEBL/D8t8kFs/Wa7BmmcavPtwJrixi5K7Dl0OQB+eKVPUHap4x4WZ86M0ll07gh3qT4y9T1vtiAsjXJkJxVv+qb4iduulKVGifSXy7pxCJ+0Uld9aGKzOPwwHUQ5U0zdIhbtslEC9R3uWa2THQnkpUJz6UpkrG51B+nVX680Vs4iFvAKi7Ad1gA1euKHQqtQ+79u7TvUwc8I4MRlI/80sYm03ZuymNnTH1Pn8r0wLIBXhabaiqpn7Yd1xzfjk5qxDDOVXY7aEAzz6O4qp2G+sm4joIXiRB/WKZzNuiWcSGmvZH+5LUsQpxaiTehT51ovX3VZaPE6COjXhNXWzi/LjXo80VcqI131ltA6FBgytZHtzn4OndWgMcZsOU3frusFu9UzOjaj4ghxoPjeaJVEQwcdc50UAXbulO+KARmPW2M5773IZYlsrdaFBJ26etzQnaquMx2S1aJYxQ1hm2GlgJ3jZw1FenAmRsYHcFHvFIVQdIlEyMjrS0X/0Kj/YPGrId+ZS5gjR7MkXq55Zp6v/vyiBg4p476Gby4clXiwLvq7PofUwzwJbiPOOg1FMfR3qjWTNDcRF+PFXyvfIbx+Alj6qtASiIK5rg/x5ltF/ut7ywZA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(19092799006)(56012099006)(11063799006)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mXmTI5DUyhZsw+I37Z7CS64xzyb87S7DJB28WjQ3HPYuB4XdKIdmfYYoT1y3?=
 =?us-ascii?Q?J1MAIFDz6Nhwm8q6fjtd9NuyuTmo3S2Bn3SdlKPK3fjWImQLUisappYLmEA3?=
 =?us-ascii?Q?rGcK4qruQRPrgL6aRDqUtx64BFrt90l+XSsWGsVO3Qc0+EF1OxsYLJigzuY8?=
 =?us-ascii?Q?ckw8vyqi20eLIJ9sSaV88L459HzIEjyf+8wTQ/CED610NPJDLgxN5m6uB9+X?=
 =?us-ascii?Q?z8Dm09MRhdIBgM2SgnsSvtSTLuuJj9r0gwCKNS3fy5UVTiQxC4DPAJpKgdOg?=
 =?us-ascii?Q?zINpp7+hbApNRGHghAFlGL4ULT8A98lQnhfI9O9MxXX2hYaDYCseNtpOv1iY?=
 =?us-ascii?Q?YaJkjh92gRIBDhd9HCXvAE9vARh2tFcYNBhKtvasSMZguA5IF7TKdxBcGPD5?=
 =?us-ascii?Q?kn212CUjO7aaFEs2F+Es33fCPT7hlf2wh/OI8icW+EGw0h8j+xGreQBetdAB?=
 =?us-ascii?Q?nnhNaYtwpHCgwJQY/AsLyU0YsiDrNpgCtm1FEg2KfcxpefdJ0hD/RTDS77jv?=
 =?us-ascii?Q?lFogQf+JPvTSv11FhS5nE+0NJ1Wnu5aNlXijeEMxEelcjH9iiYYIlTOro8rl?=
 =?us-ascii?Q?7faILzzszB9vxWkMLlCOpj8xoLk+bEG0h05afBaQ1rTjtlote/MRmje4Qwuv?=
 =?us-ascii?Q?sWFdol/5Iuwz/Ix9hYbxR7FX9YGpJw7b2Hbdo5++8pH85YRXFykuiiYDJ7YF?=
 =?us-ascii?Q?02MeP8ZFOMnJenEtwfvS3Ovr2SCO0mArX3/JN7WlqUGIwQKxcCg7+VX5MbIY?=
 =?us-ascii?Q?1cYH9rkuik2gIcESY3/Zyu1FlAZlnKLgQWHBSqPeE+Q44vYUg/GMVXcxtpv6?=
 =?us-ascii?Q?GguXsxqyueMpM+8795CoVfR+mWi3xPogBZ1+79vI30l8ulDdBpN4MzqRMAwY?=
 =?us-ascii?Q?5XP980p6Y820UpdrET4kPbwM6wHbNz4qjHkMDmU10mEQdGG1gxH7bUJE0n3J?=
 =?us-ascii?Q?l7h7UjF6JpcHNztxu0oBhP9T0m3eHXxeSz5efcqALi06hQpdaYYypHXZBPaD?=
 =?us-ascii?Q?WGv83qa1MvRh7CgBk4eBG4WGYMrGFzE28Vnt4zH0UqvquwG/Ho17rF1ZY+3/?=
 =?us-ascii?Q?aqYVMvYcAbkmlKhUOfKaotxtfBE0/iysHK4z4L+iwDVN4sAfmMnuCsyEXDyB?=
 =?us-ascii?Q?G7Ytav0wT9nwEV3uinSjsFf+kibz2xnG9hAEDwM93Jvkqs7rH6D45Ty8SS5C?=
 =?us-ascii?Q?8KV9ibE+mN49gKBuNr1cMERqriWIHr8eiQsFecSVlTcEnwv3wP0dvGey8bQ5?=
 =?us-ascii?Q?1hiVba3ALBtC4RN+c9APTJoTrg+i5R1NHhDkEIG7eHymCWyngTasYSwg2xI/?=
 =?us-ascii?Q?+YZRcovDA/2pL6AOVv3D/P+1Bz2cW8KZb7GPiBz9M+GiIATSNleg+I1swEOd?=
 =?us-ascii?Q?KkhoziannMyJfTNkfmcHFEKwxj2R1RP0kT8xzq8ukwHDtopq+4HbpoNzyt9D?=
 =?us-ascii?Q?kEF+II0TuhqOCwaQJ8Z89u7TDoLyKjCiv/C9Qv05cXhDJmwZedozj04oIwaT?=
 =?us-ascii?Q?ybF6PbshC9gmentDIDl/dKk1CShtYeuocdh9/DOoohWAjBNaihSh9nrWtlIH?=
 =?us-ascii?Q?k0njCi2zfkCQECvGrFePRZKcgtkT4oNJDkfoOFcDDmrILkRm839PZYb6hSWK?=
 =?us-ascii?Q?ONqzyy46f22e0sJbrk+AfnH1QERRABHRsbL92ydZMv/9Pwcj7YU3TE5xArP5?=
 =?us-ascii?Q?ULqBCHpYtDGzOWFT4VzPVCMbCIo0D7vzYWuCYSjfp0Rv+jJTzZNa0GAKEpMP?=
 =?us-ascii?Q?XroOnZAqJfjHNB9tJOUU+NiJs3xR/tYuME4k+LL/oEyVCKFAaWxF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32b8a80a-1970-41e3-4855-08dedd33a258
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 20:58:17.3749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6UrcUS5Iy3RoecHMW9s0mjbvQzNpoLkOz+1qEjGW/z/EQ9gLxX/UWGaHZ6r6+ix/fc5heRIM7fZrwMvfgOCuQa2pFCtKuAhRBSXpJ4JArDk1Ep0dsH6fG9XfNSP+Q4+e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8815
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12148-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:griffin@kroah.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@kernel.org,m:Frank.Li@nxp.com,m:vkoul@kernel.org,m:imx@lists.linux.dev,m:gregkh@linuxfoundation.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 050A872A69E

On Wed, Jul 08, 2026 at 09:57:36AM +0200, Griffin Kroah-Hartman wrote:
> Add error handling statement to fsl_edma3_irq_init() for the
> devm_kasprintf() call.
>
> Assisted-by: gkh_clanker_2000
> Cc: stable <stable@kernel.org>
> Cc: Frank Li <Frank.Li@nxp.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: imx@lists.linux.dev
> Signed-off-by: Griffin Kroah-Hartman <griffin@kroah.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> v2: fixed typos in subject and changelog text
>
>  drivers/dma/fsl-edma-main.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
> index 36155ab1602a..d9fb717b5b53 100644
> --- a/drivers/dma/fsl-edma-main.c
> +++ b/drivers/dma/fsl-edma-main.c
> @@ -414,6 +414,8 @@ static int fsl_edma3_irq_init(struct platform_device *pdev, struct fsl_edma_engi
>
>  		errirq_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s-err",
>  					     dev_name(&pdev->dev));
> +		if (!errirq_name)
> +			return -ENOMEM;
>
>  		ret = devm_request_irq(&pdev->dev, fsl_edma->errirq, fsl_edma3_err_handler_shared,
>  				       0, errirq_name, fsl_edma);
> --
> 2.55.0
>
>

