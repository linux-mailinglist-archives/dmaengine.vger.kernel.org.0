Return-Path: <dmaengine+bounces-10664-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFSSOPolD2paGgYAu9opvQ
	(envelope-from <dmaengine+bounces-10664-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 17:34:18 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA0B5A86F1
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 17:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8D9C931561EC
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 14:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07F43E5A32;
	Thu, 21 May 2026 14:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KwJDInaM"
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011071.outbound.protection.outlook.com [52.101.65.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCFD3E9286;
	Thu, 21 May 2026 14:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374360; cv=fail; b=HdnvAYNiRutXhrYAmY6n9w2l2ZzyUcSMkYtW+mhH0GbAwBuLTim1WWjTx0fKd0uIgDUgbpl0EJ0EVrs8rNpErmTtDHeeiw0Yqu2g5kSw0Z6Y+WjhFA4hNNamtZvC56ELg82IfV6wiGC+iV8JWIZJpTFKAe9XUh5giwQzzrhAdfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374360; c=relaxed/simple;
	bh=7+tpQPfLDfaKJ50vdvW+rRcBJsaBh2xBMzrBhtv/8hQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y+sL0MuSrjcDJQNztDupWmO0yP0G9Xm3L+vZ/GTmQyvwYacCeJQI4k/OsX7IUjRggo/wZeOJXDN9mdkNKecwOu8QaAlndbW2zUbS9WbgWC298Rweq/SMHrmG7pGGpuWTwqtBIT2lw6TS1doDjgIIG5IrgxDtji5lRUHV7k2P00A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KwJDInaM; arc=fail smtp.client-ip=52.101.65.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bteTAJ1orvyAq9uftl6EKeHMDRBbKQ3e185CqeIAaH8nrwiBLHyhPXzWYyMmQai8c5lltRN8PKFGAEPcXXU9GMIU0SyT5888LeZfJQT9p5PAeQNbD5mP7cnehsEaj4xTDtK/3sPgjAdXjDFwOowC1EtSAGTzkMXQhwjm4xWRtXSinIBapI/CvdKHj0VW+jKTCHwl/Wp9+XutrZeJo219AXQawC0n2aV+Kx6ogUwsQAcpSevPq4ZFmPlFBox3J8lM4tyHre7WjeqdSxfr9OlObhXO6psiPQU33xTvOluhvGHE9Z7XjxC7d7pQ8huyrV/AXnDUZ5T/cFjdEST2nGcxzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nxwJitHc+qDrRB1nJ5sUCFY8CCer56etsSOx8On0tNA=;
 b=dU6u93UmLArUi4Uo7Pb3x0RvCVtYpn98Kz6GkKGsyxtGgfJw294MsNAKmKgSb1bwMb7luzLR8M9qA+hCo7EXmrpuEbAXoFfPkGALehJXVfG7p+wi3cskqqdbRiAB6cHMgz2WJIslkNyQJADcLIIIIlpi2ZMK4c/hpeldfV88a7D8InXzIJS8TImR3wb0BBwH0PdUvbZnzqLLXwR/gIVoBn/1qFFM4EJ/lRwY2y0c3knT6uUZ+e6829u4bIt7exdm1IJl4KKJ5c28H3Ki3o7E6y8yBG+x9MhWcho1Ldse/OQCKEHC1dilOpg1HavwwalnzHhkn+ITF/pAswBs0CIqlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nxwJitHc+qDrRB1nJ5sUCFY8CCer56etsSOx8On0tNA=;
 b=KwJDInaM0ShTXKb24Ry3bb1fK5nB31EqV4WKUZp89xd1w2CD31Ox8YZH+6+H8H188bR8j4FaF+zALb+rut/Tn+ytavkhUd7EnBru0l4t7MaxETii7ej3qlyLwcNxFY0nB9wSl82d8Qbs6nx9qxPEE6B/tW595Bm48TLJx6lntaKpf9+oTqAfWz4i0qICmxAIizK4z1i02mavqoryvcnJVNbf0UGeQz72WXgak3StDbNCDWrERN3zR655r746beynTVdPvbCZBqUTWauex8cqm3JgsdjW/IRMauocZK8lB11rDO/tBklFidUE27bjkPOrQmw3l9/Qw52z+iabGY7bkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PAXPR04MB9253.eurprd04.prod.outlook.com (2603:10a6:102:2bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 14:39:15 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 14:39:15 +0000
Date: Thu, 21 May 2026 10:39:09 -0400
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dmaengine: dw-edma-pcie: Free IRQ vectors on probe
 failures
Message-ID: <ag8ZDcAedIY-LFLn@lizhi-Precision-Tower-5810>
References: <20260521142153.2957432-1-den@valinux.co.jp>
 <20260521142153.2957432-2-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521142153.2957432-2-den@valinux.co.jp>
X-ClientProxiedBy: SA0PR11CA0115.namprd11.prod.outlook.com
 (2603:10b6:806:d1::30) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PAXPR04MB9253:EE_
X-MS-Office365-Filtering-Correlation-Id: e48803d8-c3cd-418c-6acd-08deb746bb8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|19092799006|366016|38350700014|18002099003|22082099003|56012099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	1JnhIe9r6M3S18mmvpb38EDkkCESEuZabYXAip9HM42h3r+t9EVyrRVjQiDgz8BMbM2sZQcX5WT8/kExB73SED8XgmB6oa8TVPl/iMx6tAXD1wbEQeK09HyRqP5AK5seW1qB1nHGV2+GP2T2EspO7ArBsvwK7IHE0TgzrAPYublfQrFClLkqsa7BsjTfbllsvf8xaM71TkXYifViq628ErsKlNZLhd2xQSPmglQWuWIo36TlXlTxTT76o1svWRcU7M8oARpOCCMhGWPboiNAy8zLML9ixjZRa9Od/e5j1en3w2dRLZViHIo4yoWkHVhP/9MgyZ2gjcEQisJhf/Ng68pabYlPaDVvlSZHo9eXt3sz6jL4fV14QKprHcsb3F0EX1GfVjkl+DUjQGEr6I/lx5GRrmW3mioJrkbLohbcIuOszkL4Frh4n+s/M1h8sMjSf4Jw9Tc2HXsA15QrdaPYnetR+SBv+580RdtVfF+Cir3p3wO3IlA4foPajeZ5MKe0+JkgzsTmarjud0sMGhqQJpx/aPnp9i6f6YofWw/aQFwQtXv512WG3PZehdbJ9AkMna8nMhjGLsdoXTEE3IxuJBhY+7kkMgzySXb91StGWfxqtSBkXWfexzDF1i2iG0miiCAlL8jDUu+wDKTuFUzveOJ9j4yHAAHVZHK9do/Rcc4UHIJ9IT0Xcc2i+7Ksyrowyuo2HklCa7AlmbxGV9FHFBww8ODMTSR0wuCsqUoF19GfLNp/7t2fG+RYqBoFiHmb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(19092799006)(366016)(38350700014)(18002099003)(22082099003)(56012099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?whPvbpnd5ZY1JxOgDZqNU4Qshk3dETF6l1uyTDC4CMbTpYqBZbLwsoVCEfIs?=
 =?us-ascii?Q?vbGVBgd0oXwKCNydFEfU6Y3o5EVEJ0QTWT9HF1UYeEOwjvI1KSlrHaqIfS41?=
 =?us-ascii?Q?6Q3KRxAFcMc1y1nYDO3CFf36+F7Dw4zri3642VcczfCcGY3WOdmFZ/1Q79Gr?=
 =?us-ascii?Q?bZHnlWLcu5LxXsP2Rz+GfcVV06dSVrkoQIhxGFufME2pLsFZiSDd6HmrOGSZ?=
 =?us-ascii?Q?uxCY26B8ZQgDKL116dtPt3P1vZDACshh1ofPtanXFWO99isLK+FPx4EtUwQe?=
 =?us-ascii?Q?k/i7Xv+AAn5f1iUpVbueiO4GflRYcrDGl1LhpxkaC/uAvADV3+0P4MqfJytn?=
 =?us-ascii?Q?aHhswm3dl1qwH1GpQ4DRvH/Aff66JhDHQe36Nx7gJKNygKRpwmo/8Andt1B/?=
 =?us-ascii?Q?xA+KdYiEaBv7Tyv9dB7GZV+L7j1o8G4swlev+cqpITbuIDuzxvsQHka1xPkQ?=
 =?us-ascii?Q?X2iSo5SvdBWg4cgJKt72R/JC8ncjhFPVJuKp/R8MzAJDZzLvCXeTPTKQ++eB?=
 =?us-ascii?Q?2lxE7qeD0HmkWGh5fB7LjDXkVNSxSN3R3ywaxaBK7/K8tSbsghWLhyS9JJRp?=
 =?us-ascii?Q?Vow8jGhAO3pgUKb3P97kLyFFRkJu25kuzxAwuYco/rSXl48eRT1/umnjk6f9?=
 =?us-ascii?Q?vFziQcjWRKouUHCS2q+RWhoGGy2fnEA0GmzBWywUnuHsYCsqzH5abR8FDhT2?=
 =?us-ascii?Q?Bn6uBGvA2sQ21RhRL4fALidTFrnV9bGNlyega1wrFHSH+2do3eE4UQKhPdPd?=
 =?us-ascii?Q?boRdr3e1Z5mzHQhQlXZNNAttGJmWCmnkoaegUEOmITHtfpB1RjHg60k5XBZB?=
 =?us-ascii?Q?mPXD1UiBhgs7Jv1q+qM8UKun7blkcQ6w6iDC8bepKFfdLwq2Kl8Wz1eTjIy8?=
 =?us-ascii?Q?5e7hXogq1FC6DYjbjaZqxEoTA6UcH2bJavpDQykwXFBRwLhhnNqeK5yn+rSP?=
 =?us-ascii?Q?CDm4aOWNn4ypUPrmQzOAXkXPLTrII+Ev8vIGL3VP7byZhNe/M7/gDSiMrVRs?=
 =?us-ascii?Q?omwxGazKFLYCJyo0pVsQKSW7WIOJc37wT3dYN4Cl+jO+pRDOzL16TOD0aZIG?=
 =?us-ascii?Q?ctOxqcfson5uovDIs8YovghXV8HbEvFHBGjLvy34ynkz93D4YOqsnDFQdrQb?=
 =?us-ascii?Q?PcXdeQaCTDa4Nw6MBrzS0G+tqrMN/jg6YI319iMezKhw2CigG0G/TCRf6KpJ?=
 =?us-ascii?Q?SJcgd0fX+5tFQkdJiMCi4nvUMuFOC0HFcQIF3KgxfEpLTsd6vl1s6ry9T/Ab?=
 =?us-ascii?Q?uVdhSfouoA1KqQ8OugnY9NNmiorviGmsWbs6Zq19eWaHPN59i8GOMkYtsCa4?=
 =?us-ascii?Q?wJDQZXCdP7fCS56e5mWoYnkPoxDof9qLXbed3h1qRWb2PXYi+tuPgtvidYYO?=
 =?us-ascii?Q?jkgKWg8Bw7E0qGUR08XCpB5Ci/3p76l8eYOgAarDZ8j7LeefDFOlCfHCGUoC?=
 =?us-ascii?Q?2ySJWyBsZVO6upvq5xB8Uh7xu9JAhhbPCJ4awO4BNSVKnA7lLhHcqdCbHIg4?=
 =?us-ascii?Q?b0KxExXlk0senLSQe9ftB+MCQi3zB5W1YG9HImNIaoscCMQXKcH56ggI1sIZ?=
 =?us-ascii?Q?DsUNTAmc+pXP1Dr1ciuOuY8eJ2OheuU0RwZfyBsd6o0M700qjYOnXgk15Kpg?=
 =?us-ascii?Q?Xdj/GDHqUtMgpOulytvybSqYsk0IqOp14cgAT63JY7gIkzgopSXFCIrf6IPi?=
 =?us-ascii?Q?jHJBNBwJc//6fd4K8mAp9h61BTdHJAgeS6ESKPFvfL2PlBALClfsdCoxGRKS?=
 =?us-ascii?Q?dtbiiedysQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e48803d8-c3cd-418c-6acd-08deb746bb8b
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 14:39:15.6887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LCQzzVlx6QN3ghEjsxNxAda0qKjeZBfJPME96oy4SwZ5XOUbolYZs5ECiAR5xrRFVNPogm1LfW5VTul9XDOpQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9253
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10664-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,valinux.co.jp:email,nxp.com:dkim]
X-Rspamd-Queue-Id: 8BA0B5A86F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 11:21:50PM +0900, Koichiro Den wrote:
> dw_edma_pcie_probe() leaks IRQ vectors by returning without calling
> pci_free_irq_vectors() in error paths after pci_alloc_irq_vectors()
> succeeds.

I remember pcim_enable_device() already auto manage irqs.

Frank

>
> Route the post-allocation failures through a common cleanup path so the
> vectors are released before probe returns.
>
> Fixes: 41aaff2a2ac0 ("dmaengine: Add Synopsys eDMA IP PCIe glue-logic")
> Cc: stable@vger.kernel.org
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/dma/dw-edma/dw-edma-pcie.c | 39 +++++++++++++++++++++---------
>  1 file changed, 27 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index 0b30ce138503..87c31d01fb10 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -410,8 +410,10 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	chip->ll_rd_cnt = vsec_data->rd_ch_cnt;
>
>  	chip->reg_base = pcim_iomap_table(pdev)[vsec_data->rg.bar];
> -	if (!chip->reg_base)
> -		return -ENOMEM;
> +	if (!chip->reg_base) {
> +		err = -ENOMEM;
> +		goto err_free_irq_vectors;
> +	}
>
>  	for (i = 0; i < chip->ll_wr_cnt && !non_ll; i++) {
>  		struct dw_edma_region *ll_region = &chip->ll_region_wr[i];
> @@ -420,8 +422,10 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  		struct dw_edma_block *dt_block = &vsec_data->dt_wr[i];
>
>  		ll_region->vaddr.io = pcim_iomap_table(pdev)[ll_block->bar];
> -		if (!ll_region->vaddr.io)
> -			return -ENOMEM;
> +		if (!ll_region->vaddr.io) {
> +			err = -ENOMEM;
> +			goto err_free_irq_vectors;
> +		}
>
>  		ll_region->vaddr.io += ll_block->off;
>  		ll_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
> @@ -430,8 +434,10 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  		ll_region->sz = ll_block->sz;
>
>  		dt_region->vaddr.io = pcim_iomap_table(pdev)[dt_block->bar];
> -		if (!dt_region->vaddr.io)
> -			return -ENOMEM;
> +		if (!dt_region->vaddr.io) {
> +			err = -ENOMEM;
> +			goto err_free_irq_vectors;
> +		}
>
>  		dt_region->vaddr.io += dt_block->off;
>  		dt_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
> @@ -447,8 +453,10 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  		struct dw_edma_block *dt_block = &vsec_data->dt_rd[i];
>
>  		ll_region->vaddr.io = pcim_iomap_table(pdev)[ll_block->bar];
> -		if (!ll_region->vaddr.io)
> -			return -ENOMEM;
> +		if (!ll_region->vaddr.io) {
> +			err = -ENOMEM;
> +			goto err_free_irq_vectors;
> +		}
>
>  		ll_region->vaddr.io += ll_block->off;
>  		ll_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
> @@ -457,8 +465,10 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  		ll_region->sz = ll_block->sz;
>
>  		dt_region->vaddr.io = pcim_iomap_table(pdev)[dt_block->bar];
> -		if (!dt_region->vaddr.io)
> -			return -ENOMEM;
> +		if (!dt_region->vaddr.io) {
> +			err = -ENOMEM;
> +			goto err_free_irq_vectors;
> +		}
>
>  		dt_region->vaddr.io += dt_block->off;
>  		dt_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
> @@ -513,20 +523,25 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	/* Validating if PCI interrupts were enabled */
>  	if (!pci_dev_msi_enabled(pdev)) {
>  		pci_err(pdev, "enable interrupt failed\n");
> -		return -EPERM;
> +		err = -EPERM;
> +		goto err_free_irq_vectors;
>  	}
>
>  	/* Starting eDMA driver */
>  	err = dw_edma_probe(chip);
>  	if (err) {
>  		pci_err(pdev, "eDMA probe failed\n");
> -		return err;
> +		goto err_free_irq_vectors;
>  	}
>
>  	/* Saving data structure reference */
>  	pci_set_drvdata(pdev, chip);
>
>  	return 0;
> +
> +err_free_irq_vectors:
> +	pci_free_irq_vectors(pdev);
> +	return err;
>  }
>
>  static void dw_edma_pcie_remove(struct pci_dev *pdev)
> --
> 2.51.0
>

