Return-Path: <dmaengine+bounces-11893-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JKyOBnvcQ2oPkgoAu9opvQ
	(envelope-from <dmaengine+bounces-11893-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2026 17:10:51 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C4C6E5C5A
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2026 17:10:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=ov4J91qL;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11893-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11893-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3AC03309B86A
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2026 15:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECECE287246;
	Tue, 30 Jun 2026 15:03:11 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010029.outbound.protection.outlook.com [52.101.69.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9161C1C695
	for <dmaengine@vger.kernel.org>; Tue, 30 Jun 2026 15:03:10 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782831791; cv=fail; b=tU6TzgYDfVWxYkqS7o04MHYI/52H5+Rk7brnlGzMYNvs42u/4PkDXezSL1gRboOOleCh68wvbdTbQojsajKo4MN2gnM6qQGwGGF+kOUFI5zY8YNOiO1QEPuq8JAOivU54AbGctiUbb3GyN5bxi9/03tRjIfj3AhTFuPcm+1m9jw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782831791; c=relaxed/simple;
	bh=YBKXtvOngA3vEx3NUN3wZ9vG7y8+jK1OmEWCzifyPEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KoSpUVfKVF5BfONeWJmUGAzn1dqTWOLecjerTEtdfLyTUwPoaOC9B2ZTlOOTKvMeS2/nOq/0YhAiNQyIOHRfaPfdTZFoktwp3VmQEQi4Bt/XZ+XLR/Mn0vaRxO63z1rHyQ6ihhebHoQZKjnWxSYhCzD23/J8FMYHQuKSLqfi/+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ov4J91qL; arc=fail smtp.client-ip=52.101.69.29
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hVduVpdiqPFQei4+mUylZLfw8+kyDiNoATVsxodhjcpgA5ZxkvSLc9nj3sDVl2ix5UxZuy9uuA0ElGcOsESJG7ZpcDGq+4pixL+05rcuCfuX4syExHVpx6m9nsgzYW7R/GLxFDieW00Wqf6dSn/21cXMqJT2J8x+vyTJTkwFwlsdWAb7vFjVs0/EhxSH1uNg/BViecOOxYRVXlU9VxgDmTYBpYa+TKHMbrn4Ki8dgCmJQvnSBXtovpv0uI58nzs/WrXOHry7vRQDuw45ZwRqTlR25/ASWPYeIgcMIl/YkOfcJMwlxhLearpNfFWsm1Q8DTWCUZxRmSbSly1PKZZyIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YBPJmZYuTBOIWuLJo0aJM6IRvbUYuSJCoy3Ttf17t9s=;
 b=jQAEKmalK0xJtvucRz8kKEepbzTrWpOhWc/aPtJZAL79bGO94xsHZvGyCpzznEig3no9KsXzJt+0hoX4zbUK9PoxwfjlH64hN0l4RGYzJeElfSXHeeebs/3BmIZ9MlBNAXnijfN41Fs4EfUz/OKXQHp6Of67qzhLjX6L8BD4ZFwelslk2O5gJ/51yKc6MIsuh8YKgs0PJXeajaP+YSyw2Nes0Soo4k2+vxeSZqydbxR4E/WTq2VVGTujsw2aH6UTOTI5T525dQ2d3xWiwtmKYFszaSrdeSCSa88dNu6nP8UPoEOzhWUoUXAN0QkPnYXALNr+BukxtrYVP6A6TLoXAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBPJmZYuTBOIWuLJo0aJM6IRvbUYuSJCoy3Ttf17t9s=;
 b=ov4J91qLq3JyI5eaw/vC9S1QTGkMp6ccA0XYXsGsHq/WYKMZ3bl7adKg7dfDJ7lzSGhEJpwdhhb94H9QDqEHz4mj8a7x1+Qx60GEKSqGy0ZvBgyKjfSuaAbUUG27ILEBHW+ANjYrrhVSEcyuCtGY1b3y1bZEqQT+oRsWzmtWoIv0d2WymuDoR0KIIlK2l/7Je1oseZfkgNj1HhYR1nc4ZO0WdPVMBUU3BRJrdQk5KPMPbWmklILPZDbKA6/1IDIEqY8skfUmvyxjJgadL//iJzhRztbCqCfZo5oQCsZBmmVlRsDbHkc+qGW1PFilJ6Dk1Ts422AvUjLm2hqD7wZmXw==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA2PR04MB10123.eurprd04.prod.outlook.com (2603:10a6:102:403::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 15:03:06 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Tue, 30 Jun 2026
 15:03:04 +0000
Date: Tue, 30 Jun 2026 10:02:56 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Vladimir Zapolskiy <vz@kernel.org>
Cc: Zhou Wang <wangzhou1@hisilicon.com>,
	Longfang Liu <liulongfang@huawei.com>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Zhenfa Qiu <qiuzhenfa@hisilicon.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: hisilicon: Return -ENOMEM on dynamic memory
 allocation in probe
Message-ID: <akPaoAElTBK8V9Oy@SMW015318>
References: <20260630144214.4080302-1-vz@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630144214.4080302-1-vz@kernel.org>
X-ClientProxiedBy: PH7P220CA0053.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32b::15) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA2PR04MB10123:EE_
X-MS-Office365-Filtering-Correlation-Id: d15d42a9-b9ef-4c57-6c19-08ded6b8afb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|19092799006|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	jBugKunnxvNHypbaGaLuAfYl8YjMCw2PNgi2hBhkq9NgcBWxPpo5otEGkC7K9XtA7QYTZckJtYCxMoO7m2Q991jYkE3krwjjjivV+eUEFswhKrseg4E3K1p/X3EqyLCzoL97yPgB0qQ2sINDD6NPcX1JhrSK/xaTLmDQqZ+hsBdr5fvsHczkenlWg5JkE+n/H0oc+kgUrpscnMWBh0kmybZ1t9uQcu2/NVQ+t+STZk1n+AOF63UnR+MFO6qmOtzANuaYkANZ8FP3dsnNAVQU73BF/dN4YmF9Z6wr052nBM9DdYeOIPDf3kfXULlLX/jVGJVVi0DzW2UkqOznerYQq1KbxPNX8XOB5jgrZNs9ZpxvB1CoK9i66DiG+In4JDe1XAnI9y/uhx6Iz4oVJYHCpZXgca1gE2nuUjHmfwpUQ3LBBlmKVdLys8Rer5EKVxPO8sVGG4J+yPa/wlKR/hrHNQGOYoFNOko86yINcc5hQAqT+6R4zA/+UE67AwMUEBPzcR4qc3cjgTm+HDSdjmVQSMr9SAttRBTbO8Aqusd5P+M83OyTR8o0mN3wT1DJSg+79SN47eZykUMdC8wjU4eMZMq/sKGMbGtQGh7Qts7DL+Uuvvl/eLo3sPxj2Fwdqhi0iYZQWA+vtr2ayZ3rVvAEfFmDqfLr/2xvw5Kzk456LXI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(19092799006)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2j2JwOt+ZCnC324czNPqxu3alIRsunFciDqeZYy8AsFTaJ21KsfIvrObO2Q3?=
 =?us-ascii?Q?0FxWvHWKzf0XhaaAYB/japVno+ebeURuozHE6hc3La+rySF8CMWEAQ8Pftqz?=
 =?us-ascii?Q?9kgBNQ+PfQhEnRproUVKWR8gypwxJw57a2zHJBS8TPrBzo2I3WfMNFZaL8NP?=
 =?us-ascii?Q?uvXbnlsN6Zzz1LCNyRUonSmX8ZdfpPpuFqwRL0ryzNMFTYIrseYNbv+ZfIYZ?=
 =?us-ascii?Q?bk3/JVpmRaA6PbwPbdt2drMZ1Z7YsWfZy57Gw7wy4+i+I77eerrvDl4/TDsP?=
 =?us-ascii?Q?bq4PmmYLtmmoVEmCUbWXDxdU2SyfaQKvRVpZb3njIEJVJs1hIX4m8XwVwvPZ?=
 =?us-ascii?Q?CoYINPKp2DEEEz9LUxL+SoVB6nEiyX7JkFB1NPh5HhJnrIZeoiaBTQatAtpd?=
 =?us-ascii?Q?7ME/oQoW60yg8P6Qo2R6wWDWDBFlPYlQ58rhwjSOR+TAMDpI8u1U8dJQkwzG?=
 =?us-ascii?Q?U5lhhxNYk1Tmdql55y25BS+MHnZ7lljI8XDsGLQDvLSd3zWqtj6WEdeqFt3A?=
 =?us-ascii?Q?oWPxh+s2RB/9Pgcz9MuuVyzJMXumfNm3V4iuwpP3ArHGm8e0F9UxplXI6mFJ?=
 =?us-ascii?Q?5ugxsKAUQ60p/Yk8ylttemSle+OIaRoTA2ISVSmk+nVKX3Lodj35VH7iJj4X?=
 =?us-ascii?Q?6YYDPAxgQg4zYlOpYUbcTGP1I98Eq7CB12wOiS7QQ/H5m34tRND18FapwU/H?=
 =?us-ascii?Q?4JB2dDfDODdxUwFBoYJuf1xT+RGczYizlHC4Pkd7AkX/X7DysV3nSoEe8pA5?=
 =?us-ascii?Q?sy37gGVyibLS/0+vDvzhEXbKtD9zshCEprWGhXPSCXyNs85sizTBwvbud/Em?=
 =?us-ascii?Q?qrPNLQgYNnBEA1Cr/q/9sbOvyVNjw6XjF3L9RQDlDr8tSv53OiP7pmgt2D6S?=
 =?us-ascii?Q?Yb3zjoNiSQpbHmeMzJ3w/IypXcufTUXSyKSpK/uTRKj3zVFx1Np9uoh7gG+z?=
 =?us-ascii?Q?sZPa/ylsAqQ5NKBNdtE/meks7NgKm4DEY9AFRTQCu1fAjjQBNRpKoAxffTyz?=
 =?us-ascii?Q?SZBFiJIk5Z2d9G07dtMBLA2kFA7mnvaTkV/sUC/LDWua4tCcZePNtRbcjuRS?=
 =?us-ascii?Q?BbmqmAddLFzQk4b+9e/OyrLeJZFHUPv+rH9LW+SIvB/o2w7XfgOdBiXxtTul?=
 =?us-ascii?Q?A4Zl+N3jHe42ni+ClyR9nSLi2f4TznmPgo88lTNN6YZhcVjG3StkkRBfWHVq?=
 =?us-ascii?Q?LD2SfZYmD1a5S8V7eiQ/7gpaxt/mycHqh62ipezOa5i4V5vUQwi5RgZJGS3V?=
 =?us-ascii?Q?LBNOy0uvaeu0tzeTcGwZdvidqgVkx9HWuYU1iC6Jv9VJcdPn+rTRNsT6bvl1?=
 =?us-ascii?Q?s4vVYikLxoxo9a59wEQSmM4p+66J7VVRWk1XqOBSIyxNP6zAT2GdBS9t1sRW?=
 =?us-ascii?Q?hjsj5cBEsxN3o6MhmsTRTmgPCEtm8aDSj0oxNv/OqRLr17XHrOme91/UCRBC?=
 =?us-ascii?Q?JqOR7h6F30LlXnfsE82OY2/j0uQC7Y1KKlNBCPbAgGNgFQ27NQIg11W7+2fG?=
 =?us-ascii?Q?ng++VQRoAqW8KeJUt/XoqG3Bq5npZJTogt2ANGZqVNqqZSJvkvTbooBzOZxS?=
 =?us-ascii?Q?2lODDSp6Jw6mWFnH9+niItY5mRc+iS64r9o8PVeFkeln9Nbq0f7ioxBO0Veq?=
 =?us-ascii?Q?izOT4QUiAj55YNM1RKAKtKnDOUgn/es2PVgGRUIs7JNdlJqVYT6m8xnM8qgn?=
 =?us-ascii?Q?xSo7br8RIgNsWxQad6zuqlr5PjdUqWxM13LDmLnqMWnO+05EKWjO6AnBNqh2?=
 =?us-ascii?Q?VrGtjGmFYTjdaP300PloPv+jkGh674FYQoGD0VkFBI51k30WlyVR?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d15d42a9-b9ef-4c57-6c19-08ded6b8afb9
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 15:03:04.7038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2lfsqYLvhNio0pU4GpXoQYBtlTLAgwppOwm/vnK630BtCmibVkStI3Ms860/91EVC3eNWkmkVNHApcZoegsnhjPj0KArY2qvWZ+2l39bfeo6diF4MU1DL2U5z40+PVRM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10123
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11893-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:vz@kernel.org,m:wangzhou1@hisilicon.com,m:liulongfang@huawei.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:qiuzhenfa@hisilicon.com,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,NXP1.onmicrosoft.com:dkim,nxp.com:email,oss.nxp.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 68C4C6E5C5A

On Tue, Jun 30, 2026 at 05:42:14PM +0300, Vladimir Zapolskiy wrote:
>
> Out of memory situation on driver's probe is expected to be reported to
> the driver's framework with a proper -ENOMEM error code.
>
> Fixes: e9f08b65250d ("dmaengine: hisilicon: Add Kunpeng DMA engine support")
> Signed-off-by: Vladimir Zapolskiy <vz@kernel.org>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/hisi_dma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dma/hisi_dma.c b/drivers/dma/hisi_dma.c
> index 28bf818f9aa6..c751a2e49e6d 100644
> --- a/drivers/dma/hisi_dma.c
> +++ b/drivers/dma/hisi_dma.c
> @@ -983,7 +983,7 @@ static int hisi_dma_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>         hdma_dev = devm_kzalloc(dev, struct_size(hdma_dev, chan, chan_num),
>                                 GFP_KERNEL);
>         if (!hdma_dev)
> -               return -EINVAL;
> +               return -ENOMEM;
>
>         hdma_dev->base = pcim_iomap_table(pdev)[PCI_BAR_2];
>         hdma_dev->pdev = pdev;
> --
> 2.51.0
>

