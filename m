Return-Path: <dmaengine+bounces-12060-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7vsiB+bYS2pxbQEAu9opvQ
	(envelope-from <dmaengine+bounces-12060-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 06 Jul 2026 18:33:42 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BF7713556
	for <lists+dmaengine@lfdr.de>; Mon, 06 Jul 2026 18:33:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=mE9yOTjF;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12060-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-12060-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 57BBB3032B46
	for <lists+dmaengine@lfdr.de>; Mon,  6 Jul 2026 16:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A139B3AE1A2;
	Mon,  6 Jul 2026 16:32:07 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013065.outbound.protection.outlook.com [52.101.72.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F8A3BC68D;
	Mon,  6 Jul 2026 16:32:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783355527; cv=fail; b=biK2nTfm45r52DFT4bAilexrRTOk8omZ/6vjX0itG1wDpcn47XapBq5iOsC+heLVw4ouHgojK3PV7uqPf9dc9tgzMYVnB7Hmab1WBEZewRqqyNGvNQF2ZLEAG30CbN65cd8f2d0tj+k431MQepxoLz4UBBgVONXkofbCPnmLgKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783355527; c=relaxed/simple;
	bh=p1uxvQ6NxlCEVCSj7ZkTnnk/4LzC6h0jEcLgUhfuPzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XtO0ywjFvYi6BjSXqcSLNaXM/HEf38sXVCfjYxhYgUw//TuuAuUHP8NsvzyHJeUCGrIJ/5HAPkfluwTikGoq85m97COC760uyXxdQl+tgSp7jPbXunKD80byF24bdu6Y5BjrLiUEghojlJqy7ka/Z8nwEVkwiTHVrVkL5ct8/Dg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=mE9yOTjF; arc=fail smtp.client-ip=52.101.72.65
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kHNUucThWt4FiSdGhYvE94YIN/wZnjiT67fbgBDGY3oSMz/jlg27SnP5UjtQq7GtMk0wvtE6b94r7dIaJov/GwN3jXJ+FWhmQfyGhl170ML6yROZ1xnjykM5Y42NQqLmSY7e18Q63eAYwkxe4GBMH3SNY6j3s0n7u6d7Wv7DxamOYww7/DLvdTtRSlhXkWIqJNTWWYjeO53AxPKRQ8HY//Kz+w/zFxlT931vxPaXjx3OQnQqfToUSn8a5/rnpAb4WC7UBeWIBinkraZZ1WzacLgWZgFO5aC6CEsu0U9o97TOjaKX1y1OW0tbo1mk7AIBsQrV2qRun8fJAHJgZhB+lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05b26zV5jSO2zg8ZHuDXjLWZQl+FuHrOlCt22LdSjGk=;
 b=ZCV/yOvnemwEsTmNfGdnnll6S3/MM/agZzxBseKzjS9ZpfXipzLyDAI47v3p8CCq4wBY0wTxfP+MaGrYymlt/yuMyW1T+4DNrXb/3+knE7QPMI5LQ3qW/Xm4pFhqZXNPxhIoZPwghyVLcJi3aNkSvwTmE/XIGRBFIF78f7LX5lKgKfjpoIn09UxM8A66AQUL5E6578uHJLxvkYyb1/ORkDafaBG0Lju0RWIMgJWpFw2ehWpvQWhUnEePYA61jLDYHJVW2mw3kiU3O4Y9gsbVQE59WpAD9hvXsiErOUr7NREuT45V7KGVMweUGlSj0uZedSgZNLWoZ1ur6DIEaSvERw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05b26zV5jSO2zg8ZHuDXjLWZQl+FuHrOlCt22LdSjGk=;
 b=mE9yOTjFyewKRssE7hDBgBy9TOyjrR34mWfW5S1/Yp26CtRI2EbEPU440DJp60vkEjqHUgO7dtQn3dH98N3nknIchW2rH83iAW9j25PyCPVqedHRYt4Hr+204VkByLzlT8v5Q5GhiE+Okp0cgCout9w7mm+6FKBvxBud9HKV8fvc5ssRz9EC7GFQaNLRp+4zq6WjDKtseMjnIKhEChPIoKTZOXHEDwrgbRNeLSRHYTMiFo2QH6HpGmOuCkQHPRwymwGSx9p5id9g4m3ZIBdFvRjqV9bMlfGe06R0ysy96ReMMR84SwtIBP4eQLZI63YZsens/wgbjp6RkhQVZ20puA==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AS8PR04MB8149.eurprd04.prod.outlook.com (2603:10a6:20b:3fd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Mon, 6 Jul
 2026 16:32:03 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Mon, 6 Jul 2026
 16:32:03 +0000
Date: Mon, 6 Jul 2026 12:31:56 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Griffin Kroah-Hartman <griffin@kroah.com>,
	stable <stable@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Vinod Koul <vkoul@kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH] dmaengine: fl1-edma: Add error handling for
 devm_kasprintf
Message-ID: <akvYfEbgBzSSwJkU@lizhi-Precision-Tower-5810>
References: <2026070605-frying-fling-b9c5@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026070605-frying-fling-b9c5@gregkh>
X-ClientProxiedBy: PH8PR07CA0044.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::12) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AS8PR04MB8149:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a6331e3-875a-4cbb-78f2-08dedb7c1c1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|366016|1800799024|376014|6133799003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	4O5jeq1XD2M9q9KL4a/TeRazXns5ahw9/nsu532XOI1Noec30k9RVcakQRBlYU8I8muMb4rV0WNp8ev3Y7XT52gAUovrTC9aZhhIMHiYc8bUT9twbhsbDTbX7f+TlChjzbI8GJ3eknd4B3/RuRGb+AfMFzV6YuWY0xWinc5nJM2Pppw8k/lIlXkaCboJMBiDSC6s8JLUt3V2qRn+LVNHK3eGyXpltlbi5Ez8U1EU3tXl351v5uv9WhFM7AY5nMchR8H1boFm2mrUSerfXfPLtJ7aRk6ru61NlpOf3IG8yi5Il9YE//odVX4hDIQjv20Xc7TBVA8TYzpcfWd0dtj/PLh1l+BFD8Px5I0Q3GO90g7a6RBPezIPSbO1AHWBrACoBx0k2NQ0eeDV8AkHZj0uHUOJr7VDECk4Pf1L5JGCgN0m2NHRzKuJfr3R1Y+FBsnLcRp1IVrIoCmn90Jjxzbz2kp+23TAN83P3LVBtq1cZIVyDxeubjrwMEDhFbF5oxC72tk0FCyGO9QNscUddJC337SFS6Pi2VcFXNrO69I2DjSDfn/S4qu121FroXhgTjJnFLQeOW0f35KT53tTEK7cMdlBkfjPp9h3Kl3ZYfshow3hjt9nyWDCSvqbtG9kiLl0AXr7xXOoKi9h1fU82UY8FTSgA3+U3+chqlZCAbEdPeo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(366016)(1800799024)(376014)(6133799003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f0nfYYF+c3nszJx9CR2lhT7B499M1UJPwI69vO1CheeJcIwf76HNNoCWJlc9?=
 =?us-ascii?Q?uOeAyX6o5QAnfbL9qHgbHzzjeZbKay23GouCEnGvO67Hh+oqjYUtBQxR+Jh5?=
 =?us-ascii?Q?4JY7ygbHSi2sLjXRYGmGNDhrhV8gIrB6pqiZ3lam5kPXFJK650LypIA760Ft?=
 =?us-ascii?Q?YOY8D3BWbrWEQpKVx0R7d8msk7VKUD5+kQZP+tAGzK61Yx/Qbp40nFcaygQV?=
 =?us-ascii?Q?7aeiyb3ol0j9UgupuMrUXewkod8BT2IKT24hxanqI3iJR9wqasjvbHPnVn8c?=
 =?us-ascii?Q?CxIZ6r8WRaUrYOYSwUFRZt37Y7DYLoAIbR76U8k1H+DuEdok819phhFRwH10?=
 =?us-ascii?Q?U6a2Gj+YltvlWPH0X98U+Z/hafLbB+Bq94yfaq7ngSb5ywhefwVmleXrJrn3?=
 =?us-ascii?Q?XkWr/vY5StiVHhsEgmpB0y34riTwU5GMX/FrKqglpYf5Vhp/8kjlVQ90jPgU?=
 =?us-ascii?Q?QOQHTo6LsiZbP799pGgLZRYMIZS6coHnAhoS684WM9XaLlKsPfAiHUpgfqbs?=
 =?us-ascii?Q?x3K40zNCm/FUZCw6LzKn5C0rQyeKfQC8P26LzCwVCcGb5KdmfYndO3W3Syy2?=
 =?us-ascii?Q?yqcK9AA2yoAydzDFQqLcDGKi7sKCwD4bOV7TJdu/lI8mRUIjQaid+UEhK7m0?=
 =?us-ascii?Q?4hKGMH1bVn3IfusPCYedJFluuZyjkGcePQMS6XDetj2Xlr9hH/AJdhDD+hns?=
 =?us-ascii?Q?jgqQTagTLhQ1odLwq/iNg5a3/aqdzOnECXti6/V/FN6HdzVBGcDjMv+QLasE?=
 =?us-ascii?Q?PdzjexCi/uACUU908THXpFXqo75jVToaHrX5rAnWn+OJxssjoNMBl0IYDNw/?=
 =?us-ascii?Q?dQ/YioYdGKJ0pt+CkhhknjO2Xj7xl25mnTNYO8eYfrx7G2GR0LTzLbEaGrDt?=
 =?us-ascii?Q?XMMb2dFwrDiSkKUllNHz6V5LVyvNm/SK+1bJugo2mJbwOPbgPUHkt3qhcBr0?=
 =?us-ascii?Q?/gvKQKnqDiSOY2/E5GXab7+V4ZxCz11AFnibDA1NaqOu6SD+uMwk5wX1b3JP?=
 =?us-ascii?Q?BRoYIJ0eK4zzFVTKRi6pPBeLzeeUkhJ/U3Wc2UP5MpsEKRAakH+8/EBrFl3b?=
 =?us-ascii?Q?DZIDv9A0R8DUH3HKmR5HLZ2BYHgaXkciGz3448HuPa2iwyBq22w5Kw5tscbJ?=
 =?us-ascii?Q?SY72pfwX39BcoEs2O2/RcdhMebZTp+VaxVurUD7ihv+IuvZBibRGULvxDaLF?=
 =?us-ascii?Q?dRGGk0M95cbObmCyyKCCKuEQk6aLwq2Dg0ypB+s0Lldf5GbZ/R1emqe2UU4t?=
 =?us-ascii?Q?ghgJ76MBtM4pGbeqTarr9+n9HtuYt94Ogw+i6/kOvDbDV0UE2LSpUp0y4hir?=
 =?us-ascii?Q?T0D4GDqtuxTEAkMk0HIyEv+3gLmEvHmRSVdhBnEeBEta0qbKFlk+hgVnJY00?=
 =?us-ascii?Q?cGSj1VrB111O6bs1E/NSbwKliboLs2YJGYmrMbQi6FUg0JG7UO3N05Skw/Wk?=
 =?us-ascii?Q?SoF0U0+ImYMc7bUvKNZRrxHE0UDf1RBIzWw+r5a+Yh9P3/c4WLxiTdxMdYZH?=
 =?us-ascii?Q?Avka9bNyN5mONDfRf06m2Dx+q+RvV+KQBp3nVqtTM0lPnUnTl0Iau92JXcCH?=
 =?us-ascii?Q?sQqXqD6P2ec1HOa0/Au4rZCG/+doI8KeW+Yr80jsC7YAwuegCDmy0clwpLz8?=
 =?us-ascii?Q?MYXQJRi3Y5PUcKwmnsU9kHpeZNyfJF46YHPB0mBLnfMXlp2H0B21HrhR9XoF?=
 =?us-ascii?Q?WyDIdQ8qk3EMowtCIXk0uFj5gYd+WWXiB4jvQv2MjSzIka6QPUB3DRikOQF9?=
 =?us-ascii?Q?0QFSydVFcpSyriFxvQ6zpd30z++399UI4kS3NXuMNuSVfvRYQP4Z?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a6331e3-875a-4cbb-78f2-08dedb7c1c1d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 16:32:02.9804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oWhuZujctDVZ555G8x4o6QzLsQwtqgAAgoXjaoPLvtupECeh6HKmTLH3Z9Z7rPO0R7ZXUYCmysEquYKAHUrYFt2CzDdMLJRRBA1BilAwvDup0yrctB+aoYKlVXv4E2wn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8149
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12060-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:griffin@kroah.com,m:stable@kernel.org,m:Frank.Li@nxp.com,m:vkoul@kernel.org,m:imx@lists.linux.dev,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A8BF7713556

On Mon, Jul 06, 2026 at 04:57:06PM +0200, Greg Kroah-Hartman wrote:
> From: Griffin Kroah-Hartman <griffin@kroah.com>

Please subject tags

dmaengine: fsl-edma: ....

>
> Add error handling statement to fls_edma3_irq_init() for the
> devm_kasprintf call.

function need ()
devm_kasprintf()

Frank
>
> Assisted-by: gkh_clanker_2000
> Cc: stable <stable@kernel.org>
> Cc: Frank Li <Frank.Li@nxp.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: imx@lists.linux.dev
> Signed-off-by: Griffin Kroah-Hartman <griffin@kroah.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
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

