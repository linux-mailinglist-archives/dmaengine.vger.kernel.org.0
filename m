Return-Path: <dmaengine+bounces-10033-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2bdsNM7P5Wk4oQEAu9opvQ
	(envelope-from <dmaengine+bounces-10033-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 09:03:42 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE86427968
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 09:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5E946300463E
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 07:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EA038550E;
	Mon, 20 Apr 2026 07:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="N3Rv4VFX"
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011043.outbound.protection.outlook.com [52.101.65.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389643822B1;
	Mon, 20 Apr 2026 07:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776668618; cv=fail; b=ulFoxTHd5y2eL/vyTGmF3ShkXLauRUYM7iq/KgAPpyJrMhoVFYURnQE43REknlYpV3w3Bvz9vFraM6KWktsz7Hs2+3C+yY/rtPhiXgSzCemMRWmTDVUUnqs72C9ddejaH1y9ls9gg2mY/67fyEQnItLmjE9vxd5EhXytdaKWeAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776668618; c=relaxed/simple;
	bh=NVJtHk3wcnHrEnYA7OldXrt/H4WBQX3Jv/ZhcFCslF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Sd1gYDjPNRAuZkQgNxxH0Kyoof7AYPmKq7I3ubaZrelaHrCHCx3OlPF0eFbGWx6AJZsxAmuEY14wfUT0cRrwG6yEWCT2crbS8nTUDrRVaWQ8Iqwwe3Yba6lQ/4yRdozudqxpYvJWnu6vTRBwJOKr6t1YZS1UqwU/+/vIYyiFxk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=N3Rv4VFX; arc=fail smtp.client-ip=52.101.65.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EjR6IhGOWbZsH+LC2FQm1x5vifU8/3tfBQ+RFiCu2/ux+Mk+/aeYNJ12eZsViST+3aXqX2cGmYTQAdzUTFjFShc9DoHXdSbxXY5gVblJ7G1RAL7Ot2AbUmHnImdaFvG2n7AlMWX5LSkYnsCIm+pu4J8wfihG3OjxrjFNNK1wyg2SlqbAH0tkS7esLwjobS1fNHOSHkH9O621c8gXkRh5wDRNGYTqFWSNWVJsWAlwfPxuV03NaQzZpL3VBX+Kb8k5jfsdMU1uj91dGiY2rnsv471w4Oi9VNGR+a5nMoJz3+x823lvwhk9PKoVE8ogVG8Thw8wHrjjlnR2HoJds1txuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qb8ZU8FFlY99jxaYEZGb6RY/r42VXEJzwzswA4ulKac=;
 b=kYltF7+dNLeZsEweAeZqvFf3Oz/+6hdksKP4yVedXDHIn8KngOcJ3X68kCECyWGgLYluuvwfv9L9Bz4k8sWN6UrXJHTzDyjAXZsFNq98CV2ZMUyQsmWAs4cZOhR1OsfbGkiDss3//9/S8n3aUeNGQd2PkLQXppvZQ9GzEUdVZImNkFJr6iNhscimdCNzz8PoJQeWNf23m8yAwjQXAxkxMYleaSIOPzz2HWpKAIH1vT6e2g7Lg4zq+vYnaGSWlvslb/AGnvxXXTwHG0E6PXebaFwBIEeIJFQQwZQ5b09pywyVEcqKG9CwuQAvTO6Zu2u5/zNfMYFPpR61tqBeCUFrcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qb8ZU8FFlY99jxaYEZGb6RY/r42VXEJzwzswA4ulKac=;
 b=N3Rv4VFXkiSHM8wYBTHFap7FKCiIl6a6Tl7jWMlWfFEH9kXjI/bu19L507u+V4eQtqZcbx3hsjQFoc901bE6VB3HWLYXC4uRdZxyTBAEn9wRBAWAK7yjo9eYwI/UF3CfqGeEfuN38mdt0n77myw0ffOuVLzuL3rfyGocZLX/0SpOKo7OjOJjR4yc3LV65kFEny5TlKL8fkk6V377vXT0w99ysObZb4j4c84ItZtoin1PTiIToThyGn9MH5bpG7ztc1P5BQXDOhiZVHqetWWNWo/d0jVtfBE6ivlwX1SQ8FTwIvw3PUJEpn2QJEFam0E6RwlIgEtDWI369L6+ZWB2HA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PA1PR04MB10771.eurprd04.prod.outlook.com (2603:10a6:102:493::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Mon, 20 Apr
 2026 07:03:28 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 07:03:32 +0000
Date: Mon, 20 Apr 2026 03:03:25 -0400
From: Frank Li <Frank.li@nxp.com>
To: Nathan Lynch <nathan.lynch@amd.com>
Cc: Vinod Koul <vkoul@kernel.org>, Wei Huang <wei.huang2@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Stephen Bates <Stephen.Bates@amd.com>,
	PradeepVineshReddy.Kodamati@amd.com, John.Kariuki@amd.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: Re: [PATCH 06/23] dmaengine: sdxi: Allocate DMA pools
Message-ID: <aeXPvc-9pRSNFKAR@lizhi-Precision-Tower-5810>
References: <20260410-sdxi-base-v1-0-1d184cb5c60a@amd.com>
 <20260410-sdxi-base-v1-6-1d184cb5c60a@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410-sdxi-base-v1-6-1d184cb5c60a@amd.com>
X-ClientProxiedBy: SA0PR11CA0160.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::15) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PA1PR04MB10771:EE_
X-MS-Office365-Filtering-Correlation-Id: 9001952c-5b33-4d4f-e464-08de9eaaee94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|7416014|19092799006|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	f/T+CG42+OxoQLq6bpaFV78Es+zy00za5JtyDYaolV5EmIv9QbmQwnN70df6uwXZMa7asp7q/b5eHklNh7BegqDoDyIe4nt1A8ug/8UOLEgPAThh8o9bP3JVeuLAa2jm9QcF6+LL5OHHFxXOfDt8sj8xsLwMd7z/isj7lw80tKXyH2hhYykm85Uh1PNnsC/d4Vgw7pU1oskHPHUMvZiNpRDnCIAxDTwXH9cCJRuD68o5IJdcSZ4Ur9ehuyaKPvU4NlpKXCBd7eZcGJ8ClnR7iXlh8ywYgwrzJZ2QySiqpVHTLQGNhv+OPM5PYr1o8M1DRrL6+5AcawP0jwKyipj8Cw/P26v0qylwVWJ9W0xfFsepW3VEW+kz25YamAo2h1cmGCmgBhMxsaXFvNPcv1aqNAzEWhV5BLPHnTT7gfDxvzPaDHh+MVQBgFHNJQCGsCMR4rBneybNN1XXrExaFbEmcDXiIB9Im2oypvCd5nwxeJ0NPBrOeScjsgge+n6QlPlSY9LY2yIgF5yyeyiaIjvIGfhs1vi7az4yAq+hqc28IOeJ45Hlqxd8byCQJbbCfPzqkkkooUvjY+7/AfhC8q9DYxFfuwK+7EClkesWBocuoPmex3V9K7e4knIW7aRwzvHes2wpEhMEWL9SgWrQTDNkK/ZW+Tu9or+gywoEM0znr0OiLM5Rq/gHEdeT2AMfHlZn2evMvpuynQsa3HlCZ7wsFOn/R7DgPwcsfIp/1vAificaqWqU2UF39qghsPqQ+vhPFburJCy1jvnMnzbxM4k3C8EclVg/zlQk7rK7x+wvVOg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(7416014)(19092799006)(38350700014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NkVHrZGjyNgVskLQIFuZJHBv2RKuuinIgCz3hzjlUvD/NUMYJu0M7Vmt6jjb?=
 =?us-ascii?Q?je1uKvB8rf6rBmcg9p6qiAVjKHfOFRNzEDunYxc+tIP6yl4IOzQogCRUrnkh?=
 =?us-ascii?Q?H12UuzTUUD/gzrIDNXxqGbgkbrHrStUHA5u4ypZEnSuJ2faRllRYfszY7jwG?=
 =?us-ascii?Q?wQ/1FZ2o9XzdJVL1UbLXetzDsAyei2/u5ltNLScEqje8cDZqLsBox2Kyctkn?=
 =?us-ascii?Q?pqhZr7TZtzgjimK26jPw8s3PRYGAwUDKsbNHSA6xWabHobRNjwRDtjSX/QMV?=
 =?us-ascii?Q?Imx1RZMhsK19Jq2GqcNMwRI9FMlpCGiRz+pNCyX3CA1W9IMAvyx0v1slqktj?=
 =?us-ascii?Q?aDtTMDMcdz4R/limTYmGYl53YIDLQ/rbErFxvEndRlL+7VeqYTaQ6J3bnROU?=
 =?us-ascii?Q?tPyO30u6si9yPdOCr6jHoQdpM+G1IMX5TzuGAfYm9Dm3TSLC54Uh3m2gIHQC?=
 =?us-ascii?Q?q9C4EL//Yg7hEPFUIlcB63u5H1g9bi0V7gCCdq4c36Ng5Ih9xVv/ld2SbEdr?=
 =?us-ascii?Q?TJeW6EPsZMFZAJo41oQ36unp2tjrh13JZww/ZYti9j3byiS+qWpp3PPRT0XK?=
 =?us-ascii?Q?uULEZSCHuciBhYfN3/ZQunMetP7Rb+qcmMDL/zhBuuETSHUkBBnGnIXndSc3?=
 =?us-ascii?Q?J4fLKRkWvyPUBBvNg9s+zQ1b/YW3LmYiIKWTGt3aoorXdzmeltL4Xjmu1Spo?=
 =?us-ascii?Q?QepTlxj3U4rr7nlHKTuSGy3905qtBZoctIE99MnUHVKYcWufYBZG30vg9+5b?=
 =?us-ascii?Q?fC+D2B1nzplvErSOyc32nhsrwxOUIn6t1yCrp8yvDWDfwb/wCeJNyw3AFsPw?=
 =?us-ascii?Q?xxNYoVtwcYwmNoIFpDq8h79VPAFjF0H1Mv+hAmgqI4w94wGihM2F7cjuP38v?=
 =?us-ascii?Q?zkM2OUNyFTt72hpvt4jy+Pv0IWvIzg6rQ8//+xgHtFO7gJPSN5gn4TeiQ8qR?=
 =?us-ascii?Q?aQTUVv3ZzrXpPFEmR4I9v8t1KgyfP/MwPz2KsiI3rxgASbi5bKa9Dr+KuDWm?=
 =?us-ascii?Q?oa8w6breucCc3Rvh6mNoe7XZP6vES4FbB/haHaNbVpztYCk9LBMoGKZVDxRV?=
 =?us-ascii?Q?1krlf4+FLMrOLhPrHImF+gSBLILON2Vh6vsEH6wRoeJh1I4KxEk7cELVQuB9?=
 =?us-ascii?Q?wjkgjcRqaP/Ky5Zu+fNEKbvjDxbOIp6lBKmjJ2UEKJdCY65gEApOTIH/ikAy?=
 =?us-ascii?Q?/CJhhY5jfc0obGr5kQAn4XdEFYbZCXxp1Ip+dSbKlpWszb95hmie/niAKr4b?=
 =?us-ascii?Q?h2LEbit5Ehhw8ShBLwtq5WimoQtoXjLdrJfxDsf7na/BBEALM0AIrTf1QPbb?=
 =?us-ascii?Q?hDd13zuvh8aKGJFYHwIswgJa+XEYTyAfQ39Wa08b4e+XX0D/cMu6SKJo/mC4?=
 =?us-ascii?Q?hIgwMdnXPr3uwOnT2TQeK5/cW8GrkFBmtr0wGLf6tJBCOvTZkqmll8MNL0i/?=
 =?us-ascii?Q?4+pU517BfmkrfdHH6iBGJKrq4QN0kuIMQ+ukZQ5/24fs3SHWjIMI026Is1Cn?=
 =?us-ascii?Q?fJD1Hr8uNJGTYn4rVYRM/JS95KObACth5Oj+xKn+633lj0MVM56ojFeYkYSg?=
 =?us-ascii?Q?caujW/TXPdq8pIUX8JaFtUVBev0+RtsX0dRprUq8X6HoDSHPjmZ688zBDC3+?=
 =?us-ascii?Q?ubM62ObKjHR13m4QOsJZQJhOjbE8jKf7Iy/+AE4CNSI6FtC7ysbb3Z6HM9B0?=
 =?us-ascii?Q?/Quzi3u4WSXzwpeoNiJDOftDwt8LV5BroLdf2Xv5boTARM7l?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9001952c-5b33-4d4f-e464-08de9eaaee94
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 07:03:31.9723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DJ13rLNITyI6l7lDFkGP3NSEj+tGZpbKPP9087tAPen0Rr1mTKUzVeBNCVKJt4adNfoCiMxGCB3UuDjNWKrS7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10771
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10033-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,nxp.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6FE86427968
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 08:07:16AM -0500, Nathan Lynch wrote:
> Each SDXI context consists of several control structures in system
> memory:
>
> * Descriptor ring
> * Access key (AKey) table
> * Context control block (CXT_CTL)
> * Context status block (CXT_STS)
> * Write index
>
> Of these, the write index, context control and context status blocks
> are small enough to justify DMA pools.
>
> SDXI descriptors may optionally have 32-byte completion status
> blocks (CST_BLK) associated with them that software can poll for
> completion.
>
> Introduce the C structures for context control, context status, and
> completion status blocks. Create a DMA pool for each of these objects
> as well as write indexes during SDXI function initialization.
>
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
> ---
>  drivers/dma/sdxi/device.c | 34 +++++++++++++++++++++++++++++++++-
>  drivers/dma/sdxi/hw.h     | 28 ++++++++++++++++++++++++++++
>  drivers/dma/sdxi/sdxi.h   |  5 +++++
>  3 files changed, 66 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
> index 7e772ce81365..80bd1bbd9c7c 100644
> --- a/drivers/dma/sdxi/device.c
> +++ b/drivers/dma/sdxi/device.c
> @@ -9,6 +9,7 @@
>  #include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/dmapool.h>
>  #include <linux/log2.h>
>  #include <linux/slab.h>
>
> @@ -188,6 +189,37 @@ static int sdxi_fn_activate(struct sdxi_dev *sdxi)
>  	return 0;
>  }
>
> +static int sdxi_create_dma_pool(struct sdxi_dev *sdxi, struct dma_pool **pool,
> +				const char *name, size_t size)
> +{
> +	*pool = dmam_pool_create(name, sdxi_to_dev(sdxi), size, size, 0);
> +	return *pool ? 0 : -ENOMEM;
> +}

This helper funciton is not help much!

Frank

