Return-Path: <dmaengine+bounces-9100-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFdQCFk6n2m5ZQQAu9opvQ
	(envelope-from <dmaengine+bounces-9100-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 19:07:21 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CC68D19C051
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 19:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 89BDF3050907
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 18:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10922EAD1B;
	Wed, 25 Feb 2026 18:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Kz5TkNCs"
X-Original-To: dmaengine@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010026.outbound.protection.outlook.com [52.101.84.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1249D2EA47C;
	Wed, 25 Feb 2026 18:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772042818; cv=fail; b=CjeDGyae53CJkXCR5WAkmR//QTg0faa85IfOK7oPsyW5w7H125FZuXCt9F/o66atVskB/z5o6TgHxZZG4zNS4N1S3BLc0huArcgbPHQQRGW54EFBpASziMGYGscB6oUEUzkwanlaN0tE87UF5VB516FwLgXPBLE5JzR408rBazQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772042818; c=relaxed/simple;
	bh=RiUwEbA9qYUl6XGMcpCwem0AAOvpmtxae8iQbMD8dm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NOrRSLDY1MCRQPBlIv6dxyAsRakvF3gJa0LVg2q6Q4r1cwHrF1p/No28P1YiYqOGd6ctnrwLPxIK52TtXbS15jCs6vtAlqTB7MkvpZ+LWYxcWQCxQZwn3CkWg5zdqictX63gdGXGqGtZ8aIBBK68e0fK1205hV3n0F4tTFNgfQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Kz5TkNCs; arc=fail smtp.client-ip=52.101.84.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OlldD87Fnh6lzaMZ+MbfucxbK3J3YzfmSBuVM/Rz3o7RwA4cyLVGhDq7kyTzApFjgSUslCjZjVlNJcAsmCrEqzzd/ABMQDSGK1xFZRyk8EH9kKQc7KIvAgkZdRhXdvzGC4HGAJ8dX/gM+lqmDgrUVCdZCCZ9Oi98sVT3IPGOuqrMsf8HSDGk59EZN7Ur3ihq5d1m+CN8edKFVBmbvwKH+a1s/FphYRjPU3pf+Ogo6iN6sto8xxANurhploXumEBnbKzuox6qZuanfB+6Y8vPaba+Fjs0SxGcCe45QKqcTBq1z+tKUZdlz+fuBjXhjr68FflFml1YocUICBjOisRnVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lpGSBBukOtcQduhjRqMcnnG7qIZfVSTpPUFYcesUu/4=;
 b=PEphWXqpueKac4dji8Grs+dbNcHLH3zjjlkZApnp5STMXEbD2PVmvO+BG7ImpCSq5CL/DcX6kkp/N5TKizAbK4zd/HVBuLOFoW/f5MqGka7IoIv8LCVsG0RNK94zfZLhjuhUSe3ITHmck0O0htsLuAd5CK8mk7dJLxwIK/s/FFtLAIpcWo6YCDgGgwGpDVaiyFHFfPjFZ3kYJMQpW7g9aoBHec3fLL+//qxR38D9bkpkzZ1CykSuliobU/nGIM6Hc4vmBtp0m+sMi25PmBZscDVUJ5r4dxtHIR9dG548/MvkduPloIaMSyZpWn9S2DhH9Xr/iTqGY54xJDM40E2SiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lpGSBBukOtcQduhjRqMcnnG7qIZfVSTpPUFYcesUu/4=;
 b=Kz5TkNCsArsTXvKSmPk/FqgMOdzsrcfecjaoGewn78PhAURknz314PJy9qu8glt2hMF+EZgkwCXzCdJXflYO6Yb8YulUJsC9IeYQdXFmVTemngDg4vnGro7RP9hPgaGlmIBy1fei6nsk2EIcGEtXIq8V0+PVknhak5+8NIkr4tdPp/Y2MQ5kwG3GbT3Y39lOyQ0xYkfv8lfaBI+wFwnFMCApbST1ojdy8QJ59ZdVLaangPQWSHTYvQLQnbXlCUlW8weuViYZZqAd4z6eMS9wICCBLnJdo6SjezXunP2rRUoqRbi/wldDWmKqFS9Y05rIkXJ8DX/eQozi3lqPuqRTyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 25 Feb
 2026 18:06:54 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 18:06:54 +0000
Date: Wed, 25 Feb 2026 13:06:45 -0500
From: Frank Li <Frank.li@nxp.com>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, dmaengine@vger.kernel.org,
	Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
	devicetree@vger.kernel.org, Keguang Zhang <keguang.zhang@gmail.com>,
	linux-mips@vger.kernel.org
Subject: Re: [PATCH v3 4/6] dmaengine: loongson: loongson2-apb: Simplify
 locking with guard() and scoped_guard()
Message-ID: <aZ86NVKUpn3TV6Xi@lizhi-Precision-Tower-5810>
References: <cover.1771989595.git.zhoubinbin@loongson.cn>
 <004809811f510b067f1a3cda2155386db3b4275e.1771989596.git.zhoubinbin@loongson.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <004809811f510b067f1a3cda2155386db3b4275e.1771989596.git.zhoubinbin@loongson.cn>
X-ClientProxiedBy: SJ0PR05CA0190.namprd05.prod.outlook.com
 (2603:10b6:a03:330::15) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM7PR04MB6821:EE_
X-MS-Office365-Filtering-Correlation-Id: 1793f94c-7f3f-485a-d9f2-08de7498a857
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|7416014|376014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	swlw4QWw7uZH/Snh9UtZzGucUAxp2AVGoxdC0FnVhptG6Ta1yqsbbLcPRVWqvIrPvzM89N51CJj8Qa5z77hs8m5Dzoeqmmeuu8I8CPBdO2ahvp8iv//fZj94+Gid7bFgYs5F87gDw9i2WC5ez4utBKTu7zrtehNquAzI5suHf0s7x2YTsCjldC5MEqnUQAGAFBsR0sU/VxPO5rxaovLzpuzWTyneXoV8BXZwjc8WlsDVtqh8Ebb0StcrozOYIiObJmBiMBtIkU/URNuwVzROpeDOAIuWp73uoTC7Z4tNReRsN2D4GeAsgGe6c4YjBZl4IFHd9LDiDgka6gy+s+syTJ4p6/sJS14zebfJziQbSgwuEEtfj3QmC+aisnxY5fzo9yx/4HV65M28k2JVPAirEM85wKfO+Ug+Trxi0Fz4NZN5T4ATBT8o7Vy+UUsrsyHjrlwQ3U7cUHyg8Tv1B8qHyUVFtmaUuZR406hmIcZdNTzA/dDXanhnBmwmdGjfJC1/4j+U6nfGyvZDaaQKq7J/cIci8q00AUSaHt8KsYgG/7afN5jcVtCeCYCtuiipHnJaTCyMe/2sjPbRo3iuLCmau0+GVkFTKFFquUwxVPih37VwmxYp7KcIlM24bQ3ifWUhwl2IupfPhM4QHvfYe0MknlAUxTPLxRRMFcLNb1SYABpxqi4IIKZH6ll/crttKn00X4NzwyJu3OaWAThDK2HBM0ATWQE5i07RatD73bSbv73ORUveoPKFzhpuClWRI3WA/Z7zK7KF3lILGICShGpoTLUq/dZeqpbUUYvthpjnk1Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(7416014)(376014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H9QYUzAu/UR7oiPnOkQ1IBTdO2PfTdkDyJOmdNy+/L91uPqxt0MkDuQRBr7z?=
 =?us-ascii?Q?pkjPLOBZbUZn7aUzqykclFi3NUJG6DyicsNdC6bvNhSG3/ZcUCioj2q4UJ3c?=
 =?us-ascii?Q?Xuw2UT6wteOa9OOifM/mfdKzlJ5K5Yr3lOaz1mFX69E+Xl4n0TWNkZ5I2pn/?=
 =?us-ascii?Q?1WB6DgXd2w8p1IusbMOeDgiebj1BkQ6X6Frd8EOoOxwbKlbZXapkBag1p+gH?=
 =?us-ascii?Q?9/mjyYXoUx91WwJpUMw8tNnDCUbXGoCvxLu/QC4LtuVPw8fC+ImdNJDSutp/?=
 =?us-ascii?Q?CGgWXa7babfWY3oURFYJWGAHjOUnG3YI51GUOgwGXL8VGYaSEhnXf1QNsx4s?=
 =?us-ascii?Q?7gsH5ynnd9HwkLnf2f5mAY3zmf5oh/rN4/AXjfPIZXFIJ5tRkPHTXDLFBvpS?=
 =?us-ascii?Q?gpN8W9I2lWZxbZg4DuXYITLX6qYalIWHebsun7o5zynfhYQ3o41hl/9a/yL7?=
 =?us-ascii?Q?reaWsk4dkd/SjAyJExqgwxJ65t7krdZa0HwVEzrmrw8Z+tRwwyM549n0q1Xb?=
 =?us-ascii?Q?D3BQMFDOowzjHfHTwI46hG9z/wGCoHNxdRzli0yp0zAMIAUxU37l2dq9qbwQ?=
 =?us-ascii?Q?4x3pFLd3iym3RsdbWWGdm2ORJNK4m7Ubp+g5Kx5FFA44AIDE6GIgROZLIrAo?=
 =?us-ascii?Q?hKceocgNxH6WKuSUouI0ju6gjCnxFLkeN2UvaDkHkt9IsB+9+yZ+kFAeesL4?=
 =?us-ascii?Q?6qHVAeYlQPE5vRQAizCDjgtopEsAzWHZHPf7w7Sbot1jN7sVNGToJiyuSUq0?=
 =?us-ascii?Q?d2Y7x0iMmoPItmbEbTL8GS8Nvogxjs2iaq01Gizson6vxCU+pHDfYq7kHiwU?=
 =?us-ascii?Q?ZGXhC9wG1w88gbMLKfpNA/XZmnp/ZsD9dl+vGzWTK+TW5QzrTWsvXnyLR042?=
 =?us-ascii?Q?3M77wr9jpKpZRClqusTRBEUYd7kzkCJjfrrofu/LgUt3Hw18/InD/HHwOZ8K?=
 =?us-ascii?Q?gH9CnFcFEV0X4+1jpgZekIXJAEz+yYnlqWK1I/D3QD9p+I9Jyk5q5QmEct23?=
 =?us-ascii?Q?RRhVnqNb5VGoCH5BV76YSRj0uIV2wmS22jrk9xSyQ/YqcNhbPFB7j2vfYCmy?=
 =?us-ascii?Q?RcowVd1rpS1YfJRSDjOmpD0H4ybeibxmTpzJ48B3b8vG43D0YgcgwOeBYTNg?=
 =?us-ascii?Q?7mSw/Ib0UD7cMzwXxj/9bpfwIDD0YSDhhxerscZaGg0n5xi5Ch0BMDi+qc7e?=
 =?us-ascii?Q?nROwG9EBYx/L41Z36bfdpugT6Znd8swcm25JDOsetuNfeeeesFKW1cBZiWRK?=
 =?us-ascii?Q?latUzmJk62+Bjje8ZEo5AdJ/TBkjgdii3RBZwAW0BFzWRNFDJLsUU4DK7g26?=
 =?us-ascii?Q?wlZnxOj2tpVcixzH9JkX6q7qz7ja9g1pi7slEVsGLTLd4fv8/l/Ta4Bnfn7Q?=
 =?us-ascii?Q?lPZ5rukkSQwTllN0pgoWsFs5IOLzHImCC8egnE769IAiLKtAaBX42VO2uKGq?=
 =?us-ascii?Q?FoMMBaTWkP2xRTOpABZiI9phsDVwJ/qy9fED3O37OLnPM0CVZJyMwJGXwx18?=
 =?us-ascii?Q?np5Gg96tZP982fhPOKH6NHe5+UwPAvC/uf3Ei88xHyH4lclaWtSBR/eBm4KI?=
 =?us-ascii?Q?fijryhfmYGflg0TVHMFnRsiyqOUfZcyArALKc85hlapNlCPQntFC2jwVfQlO?=
 =?us-ascii?Q?dkG+MT2ra4vyukuq7pIJelruM93hcCPPwzXfJfpcNev8mZcbTNdpwPpqxQK6?=
 =?us-ascii?Q?mudeQX58Q+8M5anasLwOnwRaDNvI/JtkD5kusDeBJQRQS15OjY+q6plMoCB2?=
 =?us-ascii?Q?qqCGLdU5Wg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1793f94c-7f3f-485a-d9f2-08de7498a857
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 18:06:54.3122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FeYwbH3gQ+XQUcM2Chsou0ZNXExskcwRpvBfDrn0Grv688I1p+99KG4POnSQkXm7VKZbLxpUq09iOfcmVIRKlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6821
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9100-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[gmail.com,loongson.cn,kernel.org,vger.kernel.org,xen0n.name,lists.linux.dev];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,loongson.cn:email,nxp.com:email,nxp.com:dkim]
X-Rspamd-Queue-Id: CC68D19C051
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 03:41:09PM +0800, Binbin Zhou wrote:
> Use guard() and scoped_guard() infrastructure instead of explicitly
> acquiring and releasing spinlocks to simplify the code and ensure that
> all locks are released properly.
>
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/loongson/loongson2-apb-dma.c | 62 +++++++++++-------------
>  1 file changed, 29 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/dma/loongson/loongson2-apb-dma.c b/drivers/dma/loongson/loongson2-apb-dma.c
> index adddfafc2f1c..aceb069e71fc 100644
> --- a/drivers/dma/loongson/loongson2-apb-dma.c
> +++ b/drivers/dma/loongson/loongson2-apb-dma.c
> @@ -461,12 +461,11 @@ static int ls2x_dma_slave_config(struct dma_chan *chan,
>  static void ls2x_dma_issue_pending(struct dma_chan *chan)
>  {
>  	struct ls2x_dma_chan *lchan = to_ldma_chan(chan);
> -	unsigned long flags;
>
> -	spin_lock_irqsave(&lchan->vchan.lock, flags);
> +	guard(spinlock_irqsave)(&lchan->vchan.lock);
> +
>  	if (vchan_issue_pending(&lchan->vchan) && !lchan->desc)
>  		ls2x_dma_start_transfer(lchan);
> -	spin_unlock_irqrestore(&lchan->vchan.lock, flags);
>  }
>
>  /*
> @@ -478,19 +477,18 @@ static void ls2x_dma_issue_pending(struct dma_chan *chan)
>  static int ls2x_dma_terminate_all(struct dma_chan *chan)
>  {
>  	struct ls2x_dma_chan *lchan = to_ldma_chan(chan);
> -	unsigned long flags;
>  	LIST_HEAD(head);
>
> -	spin_lock_irqsave(&lchan->vchan.lock, flags);
> -	/* Setting stop cmd */
> -	ls2x_dma_write_cmd(lchan, LDMA_STOP);
> -	if (lchan->desc) {
> -		vchan_terminate_vdesc(&lchan->desc->vdesc);
> -		lchan->desc = NULL;
> -	}
> +	scoped_guard(spinlock_irqsave, &lchan->vchan.lock) {
> +		/* Setting stop cmd */
> +		ls2x_dma_write_cmd(lchan, LDMA_STOP);
> +		if (lchan->desc) {
> +			vchan_terminate_vdesc(&lchan->desc->vdesc);
> +			lchan->desc = NULL;
> +		}
>
> -	vchan_get_all_descriptors(&lchan->vchan, &head);
> -	spin_unlock_irqrestore(&lchan->vchan.lock, flags);
> +		vchan_get_all_descriptors(&lchan->vchan, &head);
> +	}
>
>  	vchan_dma_desc_free_list(&lchan->vchan, &head);
>  	return 0;
> @@ -511,14 +509,13 @@ static void ls2x_dma_synchronize(struct dma_chan *chan)
>  static int ls2x_dma_pause(struct dma_chan *chan)
>  {
>  	struct ls2x_dma_chan *lchan = to_ldma_chan(chan);
> -	unsigned long flags;
>
> -	spin_lock_irqsave(&lchan->vchan.lock, flags);
> +	guard(spinlock_irqsave)(&lchan->vchan.lock);
> +
>  	if (lchan->desc && lchan->desc->status == DMA_IN_PROGRESS) {
>  		ls2x_dma_write_cmd(lchan, LDMA_STOP);
>  		lchan->desc->status = DMA_PAUSED;
>  	}
> -	spin_unlock_irqrestore(&lchan->vchan.lock, flags);
>
>  	return 0;
>  }
> @@ -526,14 +523,13 @@ static int ls2x_dma_pause(struct dma_chan *chan)
>  static int ls2x_dma_resume(struct dma_chan *chan)
>  {
>  	struct ls2x_dma_chan *lchan = to_ldma_chan(chan);
> -	unsigned long flags;
>
> -	spin_lock_irqsave(&lchan->vchan.lock, flags);
> +	guard(spinlock_irqsave)(&lchan->vchan.lock);
> +
>  	if (lchan->desc && lchan->desc->status == DMA_PAUSED) {
>  		lchan->desc->status = DMA_IN_PROGRESS;
>  		ls2x_dma_write_cmd(lchan, LDMA_START);
>  	}
> -	spin_unlock_irqrestore(&lchan->vchan.lock, flags);
>
>  	return 0;
>  }
> @@ -550,22 +546,22 @@ static irqreturn_t ls2x_dma_isr(int irq, void *dev_id)
>  	struct ls2x_dma_chan *lchan = dev_id;
>  	struct ls2x_dma_desc *desc;
>
> -	spin_lock(&lchan->vchan.lock);
> -	desc = lchan->desc;
> -	if (desc) {
> -		if (desc->cyclic) {
> -			vchan_cyclic_callback(&desc->vdesc);
> -		} else {
> -			desc->status = DMA_COMPLETE;
> -			vchan_cookie_complete(&desc->vdesc);
> -			ls2x_dma_start_transfer(lchan);
> +	scoped_guard(spinlock, &lchan->vchan.lock) {
> +		desc = lchan->desc;
> +		if (desc) {
> +			if (desc->cyclic) {
> +				vchan_cyclic_callback(&desc->vdesc);
> +			} else {
> +				desc->status = DMA_COMPLETE;
> +				vchan_cookie_complete(&desc->vdesc);
> +				ls2x_dma_start_transfer(lchan);
> +			}
> +
> +			/* ls2x_dma_start_transfer() updates lchan->desc */
> +			if (!lchan->desc)
> +				ls2x_dma_write_cmd(lchan, LDMA_STOP);
>  		}
> -
> -		/* ls2x_dma_start_transfer() updates lchan->desc */
> -		if (!lchan->desc)
> -			ls2x_dma_write_cmd(lchan, LDMA_STOP);
>  	}
> -	spin_unlock(&lchan->vchan.lock);
>
>  	return IRQ_HANDLED;
>  }
> --
> 2.52.0
>

