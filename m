Return-Path: <dmaengine+bounces-9738-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GG3ACqmnymmx+gUAu9opvQ
	(envelope-from <dmaengine+bounces-9738-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 18:41:13 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8848E35EF04
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 18:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E99E30191A1
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 16:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09B038229B;
	Mon, 30 Mar 2026 16:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NEX+sU45"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013030.outbound.protection.outlook.com [40.107.159.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657A219644B;
	Mon, 30 Mar 2026 16:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774888745; cv=fail; b=OGq4yI8HXqy6jVM9ptx4JLLU8N2VIvRMQXfRncZUDbtq53J1dUGJKlPWlJpN5c4so1u0BpVKp9c4BChl08mAq2+SPCx50SVhfzt8/LBttnCLEbcFzKAM0Xhwl3SgtmZgjMfygdbBMzneNyPFIsyX9owS6GO46ASQY8btOkcsEsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774888745; c=relaxed/simple;
	bh=2DFm9h90KeOB6p1F7LPJbesEt4TbPFZvXKW5RxRxjDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QPky56yvgkXWyURja3zopamm1JTVd21lqk3M5360sswN0VuZbxW5SULflebLTQ5SWDsQ+498/Vg1HX+rmOxc/u9DTdibfutJQHpMh4A9O+TP4jJ9cREsYc7+LmRTnv9jliGkTxs/eTi9QHfsRQBq/xqltTRDtvN2EQn8t++OMJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NEX+sU45; arc=fail smtp.client-ip=40.107.159.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AevDMHgWqTpjftfnmU4g7Y+k3eP5ysmsjBxErFn8PQ9ZG1w+7jc7g9hBrG3cxFDO42YY6aFIrka8Z8Z8WA6cYCYhW1upqK4Ye4b968mZKi+fpspsY1ZHzDZ4WMdMUnobBykoWpVqmyPMQzqGjEsvCdQUhYjUN3igg4aOQNmrQyNgkpOmqKf+pICf0nGAqZpgdoH+yGy1h4Kz9mlFMzIi3FBZLmUBQDR62aU1ZJRAsmbbDrw/+3G805zHogYCT7ccMUcG1ajG1tKuhmif5+BNMjumCRiXTrqPq4g89HB3Jlzjxds/OMMdzms6snvmfYp8pTOBHh3xELFfPCQu0TgXeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dUZOPC9xDAOtB0gLaCGZ8CVXwW8bdNbIx0NIOs3EE4M=;
 b=H96eCV3w3GnNhA7auTd7ft58JC3hVVfWjTJ19JYdOSltlIBI86lh6jVEdMsqBitlip2STiRMY+tOf2Ar4O6h/QIYbOZF0oWaC5IGpg1haqPOoJ/qCK3tpkUIoVzFiQ/Soe6s1pZhoS4UmI4FVPFzdKRNSIq1qurym+VkhqJ1ClhuKb9z2sOo9k2xOstNA+lWbWao4WV3nL7KD4PYkFXL12WEd9PtWabJTMM/IRCLSJSzkFmLm7d4wFrLt9X6CweioEICIwJQRKOHc/w1gIg2KCqWVF18clUWSIQwJ57mJj/sPzdmFMaTwboFEoume4kMfBt/iHsG7yvFdDqZfNAjFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dUZOPC9xDAOtB0gLaCGZ8CVXwW8bdNbIx0NIOs3EE4M=;
 b=NEX+sU45f3j8uDeINDKCSwtjcSwzyRg53T3EheEEw+17VP7tCDzlD8X3yEBCHUdmLL2FhURy6LiCZxnYK4nwV5eiBslU9ZKS5nmnVGJo5Z9qy8aA83PhLW7rMsUTG82k+zs9lkwQ9HgMhWFUehYKn2PenanNL/JY8nofJAiSmaQ72ZPczv5X4+X97vEOeNper+vesEFx79FDInn3uhEI7ptAl87e4HxBwhRizKejeZNG5qtFKrUdhZ2sc5lCWhvQjQPWe96prYSdtzdgpwSvDBmp/JiIkkackNjCaKb7QxN7eDAk/lopVjV0Jwa/QUGiHwMkVoffzITPLg0bhwdnFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PA4PR04MB9271.eurprd04.prod.outlook.com (2603:10a6:102:2a6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 16:38:58 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 16:38:58 +0000
Date: Mon, 30 Mar 2026 12:38:51 -0400
From: Frank Li <Frank.li@nxp.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCHv2] dmaengine: idma64: use kzalloc_flex
Message-ID: <acqnG90crIEzRfAC@lizhi-Precision-Tower-5810>
References: <20260321034931.9950-1-rosenp@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260321034931.9950-1-rosenp@gmail.com>
X-ClientProxiedBy: PH7P220CA0017.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:326::9) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PA4PR04MB9271:EE_
X-MS-Office365-Filtering-Correlation-Id: 73cbcaf0-c409-4b90-908e-08de8e7ad750
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|52116014|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	MWRVlxGAzQyS7fzURCAnAB5RSRAI41dN4WSKMI3aW8Hvc/pfIQK0tJu7Jn8rNWzabe5bfGM5rdXfcgtTzBLZrNkiz6og8HJFtx6jMDn4JaDc9cG83s8HWghxARgppY4aEvzzVFngoAe4qD1+x7sVCmprwk08551Sm4KFOOCA4oMCpdIIM9bnjMhqpXwxZ4eRbAqLfakdMaRQ2GfZoK71jfxXNt9yjhe3UZGCzPGz7X0TjvTulNcb0vj1ABQ9sfbc8T3e35IIZ6OSSpfeviTkEK1UiU4MyIJBieIfGPj8WXKSbwYX21zkxjvxikMpJyk4J/b6ROM4s+XOqtEzVMQic+f1pKpnxXZ0Jr8jCKgcSiHgFMlBkF8cmroKyBW1VkR5kfEyeSXk7ruLl1xbzNGRaPO/QlruwFeFSq0H60EQCaz2a5xVCOkqShhKCVzOCveudEqzG4SZU6qbQFa7k51Q9Y/NKHmXR0q5ziO/KFrUkpNpYD2IZXCSH96kDAR2wDJD2tFy7OaSMi6A7tSuJLoGarsaY0iN3XYTPA55k6p2Ivfkluhw/V8NmGtvjt5dlpeRnuYsY3MkqylR2bsWcnMNc5q9mJK8RS6SEVn8ZVnla0Vs7jQ75NwlyxcjIwIWoikkI453bO6l2MHrZfn+wP//d4XNNlrNvS49XVoGfrKS+soR/8RtgQC6BkZzJhs2a3DYeWaVu5wMMHijXrKhGIvPdesIMsCjjT+W7m48SzJh5fDIr2Mj+MK0/NKLxdKTpLab4o/bZzc0DxuQM1UQOfd14awGp+Dw4TaP5fKwGlLeafk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(38350700014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7i6x9ieI0irlpqWBPLKyP36q9YFWWlCfNbNAcsQo6DJf6yo3UKEmIj/Dmvgq?=
 =?us-ascii?Q?X//Un3ktL0K7y5dmPqiyspVPzOOCswIwiKGMl+1DkPdo0tC4lYOZXadT8zoe?=
 =?us-ascii?Q?v7BuShPD0RuXWru24gAPD/n/GRccWfE2GBmXjlffSMDTqZVaLLgCPeVFSbrj?=
 =?us-ascii?Q?rV2LUa7U1zxcMjzBP/s/ORFnnlw1Y9Kzf3C67rPLtxL9Y+p/JT+sN7QadjmW?=
 =?us-ascii?Q?ntTUUvIN17yRoYkfESUW6lqRJn6T6ESEjVNcZTbMIf0BJDaDyILpEPH65xiX?=
 =?us-ascii?Q?R51M3ssLwHzJZDdK6u+8g/7jKzMGhapmLc03f8CgM1oK0vEnOCr5n2zJGBZx?=
 =?us-ascii?Q?XBpW+oZQaNoYw+QnRlUXU0o4Nu6QzfegMVNr74xsd0l9BdbsNLcN62g4b165?=
 =?us-ascii?Q?O8f0kCw8Lp5vUlrlD2QXdO2gN94rPyVDX/7U8AhvoJWQFcjQ3Oc8/Tfs1AA4?=
 =?us-ascii?Q?e2IQntWZnxdV2BWL5sdMNujARM5r3D2lPRIaLi4DeE15M1BjT4CFqDnaTOOj?=
 =?us-ascii?Q?NnzwjLxqtGvxn30bs/QflPByPbnDio7CKNS4LvTKVo+hQkITIzXGeJu3qy1N?=
 =?us-ascii?Q?kVFDkeIBAsARN0YjAFBbjhnmTOu3gcxkhe0kk+fzAVZ+OKm8RC1NhDezd/Wl?=
 =?us-ascii?Q?helLPsoitNiOB7yyT/xna/lmGKRHn+J+aqWsiemeiXq01+5bgCn+/ERg+Seu?=
 =?us-ascii?Q?/y7ATZ4TpF8AX7K6fnbolhcrBqO5FqhhNoCReSY40bUg+/k3z/hWYq3qBkZq?=
 =?us-ascii?Q?c8O7pimCMDCxxBeCZQ+UhL83By7tXbUwxaGImul7DjfoUo3XaJN2tkTV8sSh?=
 =?us-ascii?Q?r1wu5MT1NSkJthYZ1D47+Qq4chNGtrORxNnk/bkra2e2oQkGy3KK0NHyG+ne?=
 =?us-ascii?Q?2ApfHtD37oOHMPljXLX/AkJyKipZT5honQA5eX+iD6Dh5Th7guqs1maOh1T4?=
 =?us-ascii?Q?jg88NvtKpwkNzPjBipdv0M9zH5FyOUhN+ec5h7uNrS6FONpA8rGfF7/dnGOG?=
 =?us-ascii?Q?IBksitDpuZwltCZAtRlJKBiFtw2DI0UMKfMsGXUO7j9LEch4xLbaKdJzPMPw?=
 =?us-ascii?Q?U1mtkeZxeK/8lRlZeVrx+czvEOiUeInirpWW7ubroZrwMVTVNlOS9im1ae5u?=
 =?us-ascii?Q?Csw8YmE8m2nYofsX79Uaw3Ww7VRelMF680yjtQ6GszK9Bpuu37/UbVd5WOLU?=
 =?us-ascii?Q?id19R8NEfBrZ+4VmB/lnyVHCuvnirpv8kehWA3G5SLnY4C3EOTgAzaCKt68t?=
 =?us-ascii?Q?mYaPqrpYXBkLsy1ebun5wSKd0Z7qVH0kpsK94np9T1ogs1iek7DxN8St8cFP?=
 =?us-ascii?Q?DPBFQdEPLPA4VMA9CBeipAWr0ig+xb87Rcr1fvnnpQmSgLc7/lfg2/yAUVr/?=
 =?us-ascii?Q?muKXWjKg8pGua4/NQIuyLi0SmmCg7LKJXhwRGhMoa/BunfEIFQrFXa6EkeEx?=
 =?us-ascii?Q?0TGlar1Je86kINRbppujeX5LJlEfMegGhoLmhiOuXPIqw3lgTCGV7mKVA0cu?=
 =?us-ascii?Q?3SpreBlxVM5sLxl4YtUFEM/4cqmvcLfv4yp+4noIILDFO2GrmK1uOXkvYJfw?=
 =?us-ascii?Q?gLAslrORKGy0gZ563yI+LYmegkV8yzXfnPzCsqYff8/py8T+JJo7NU4qOooJ?=
 =?us-ascii?Q?yjTX+efJKDWlcyqAtiy6CV+wnmws/4oLoYjL7c+oD9vETyLghSJJQ8jUjQNE?=
 =?us-ascii?Q?wM4B+/9sYHh7PXIqW8ZEAAB6DxsdVneeM36Wv8OPB/HnckaMMNXZpPblvKRf?=
 =?us-ascii?Q?Wz8HsmwZGg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73cbcaf0-c409-4b90-908e-08de8e7ad750
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 16:38:58.5122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lJXo1VImDGlBUfmCKRoiJ9DSAKCsIlo2Xw+9NAmlQIm6za1SdQPZVN3/DPhnyzcJsjWetCi5ZczMG5gCM+d5nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9271
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9738-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8848E35EF04
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 08:49:31PM -0700, Rosen Penev wrote:
> Simplifies allocations by using a flexible array member in this struct.
>
> Remove idma64_alloc_desc. It now offers no readability advantages in
> this single usage.
>
> Add __counted_by to get extra runtime analysis.
>
> Apply the exact same treatment to struct idma64_dma and devm_kzalloc.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  v2: allocate with GFP_NOWAIT. Was mistakenly removed.
>  drivers/dma/idma64.c | 30 ++++--------------------------
>  drivers/dma/idma64.h |  4 ++--
>  2 files changed, 6 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/dma/idma64.c b/drivers/dma/idma64.c
> index 5fcd1befc92d..d914f50ec309 100644
> --- a/drivers/dma/idma64.c
> +++ b/drivers/dma/idma64.c
> @@ -192,23 +192,6 @@ static irqreturn_t idma64_irq(int irq, void *dev)
>
>  /* ---------------------------------------------------------------------- */
>
> -static struct idma64_desc *idma64_alloc_desc(unsigned int ndesc)
> -{
> -	struct idma64_desc *desc;
> -
> -	desc = kzalloc_obj(*desc, GFP_NOWAIT);
> -	if (!desc)
> -		return NULL;
> -
> -	desc->hw = kzalloc_objs(*desc->hw, ndesc, GFP_NOWAIT);
> -	if (!desc->hw) {
> -		kfree(desc);
> -		return NULL;
> -	}
> -
> -	return desc;
> -}
> -
>  static void idma64_desc_free(struct idma64_chan *idma64c,
>  		struct idma64_desc *desc)
>  {
> @@ -223,7 +206,6 @@ static void idma64_desc_free(struct idma64_chan *idma64c,
>  		} while (i);
>  	}
>
> -	kfree(desc->hw);
>  	kfree(desc);
>  }
>
> @@ -307,10 +289,12 @@ static struct dma_async_tx_descriptor *idma64_prep_slave_sg(
>  	struct scatterlist *sg;
>  	unsigned int i;
>
> -	desc = idma64_alloc_desc(sg_len);
> +	desc = kzalloc_flex(*desc, hw, sg_len, GFP_NOWAIT);
>  	if (!desc)
>  		return NULL;
>
> +	desc->ndesc = sg_len;
> +

This patch is okay, but suggest use sg_nents_for_dma() later

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>

