Return-Path: <dmaengine+bounces-11168-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FtJ5I/TYIWpMPgEAu9opvQ
	(envelope-from <dmaengine+bounces-11168-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 04 Jun 2026 21:58:44 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1608A6430FC
	for <lists+dmaengine@lfdr.de>; Thu, 04 Jun 2026 21:58:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=ZThHTNgJ;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11168-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11168-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1ECDE3038117
	for <lists+dmaengine@lfdr.de>; Thu,  4 Jun 2026 19:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFF73C1974;
	Thu,  4 Jun 2026 19:58:42 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012000.outbound.protection.outlook.com [52.101.66.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D487630F533;
	Thu,  4 Jun 2026 19:58:39 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780603122; cv=fail; b=P7vR9AVtpwfhaOmXHyYDI5TSdrFrUEVlj4pT+ab9lHqbyvzqiHliEoIOllT/WAR2PriRFA0LDKN9Do3AbygIPkuKZsRSE7C5wT29NNjv/hKDM8Fvc7PPo1NAt1TQFy2vI0qMSGBOuHN4vv978aSilD6/WqbaLJFMtOM3dq3rLFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780603122; c=relaxed/simple;
	bh=brv8sEDIp9GRG+os7vPVwOdmX/KyD0Ktbhjq1jcVO+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=up/ebhJJGCIztnXkwJeoOGxFDjuc5SWiTchluwveF0XjQT72Z9ZibSEWLAB8G1nYmYTIzRaHE+fsnBZ4C9YM892ITZH+NM6aRmQ2QwNzkckKlBrbhA97+8UuPATQHx9rf1xkLYzpR5xTLGXDiEtCS/oUe1goOkfabKfpSVo1+W4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZThHTNgJ; arc=fail smtp.client-ip=52.101.66.0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PvHBYdmsrrMPHcAkOnaVfZdidpWRTthx5buDpUJa9TBMI+uj75Yksqu/mRBfEyGEbPcXUiFUbjUgwGx8iGSAMxhLC16snc9rG7IsCr4KhAnNzX4F3LiQxWPgCLtI8A1Ax2Y/D/zMQqZhGh6ZHAzifTE/tvtkHI5j9S41oZY1BdePlkOMhELCZ1v2O7IKHHaVABWmYIm98bpZt2ek0uaxD6fYAmSi9kSSeh3/URPv9Wg2RTJ94HDU/O5y9K0lzjaOXXoMiGRFvejRuXYGCz2x99C91ahPhOJEs4NwnoI4HcZxjmBZlGzrsIQXyzbZnfQKAKY5gXelPYHc9MbkwqIvQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbPShTSgdfhM6BPgeVzINxWXnSR41uztgRXmTXq6ue4=;
 b=tkkSmG7eAQMrl+pdmYnYebZu5B35bPmaKKoOaIQ7B2U57et9unq6xsud91bC7ugdc8/OjixK1pm4EczKkJUduIUoRcTJWz2ApvrNPY79zx7SY87kwc20apZvgpaEzpFC57OOPJg6o2HbuhxkW1BhWETanc3Xqpg2wWs+0UYrLfETP7Cb+W58MFjOTmkmX8e6p9DYpF+SZRHMMFv2FBdAroDDDXsyjKpJqBN4a5tWriQOmJnuXdkenkJGAc6u374kDNtdNsJmLPZbOwRl+AvraUaE3N2ION+Ssgkdc8/JBlBuS3HwcdIa4ihzMJj7IbArh78aRGK3VhrtvOWqFhE4mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbPShTSgdfhM6BPgeVzINxWXnSR41uztgRXmTXq6ue4=;
 b=ZThHTNgJnBLAwzerhzC2RDu3XdDyNkzPy4SqlqMvFIFpW1y3KrWAFpeow2aYWldW/lhrupVJyojD3BzA4FLmabnmfeXZam9MK2FKZC+Ajb3pEm30QvWM1i9YoMigpkECm3VU5SgbdWsJ+5pbVMpnYA+HunItchiRL2ucgdhD0nTzPLFqCTpPnOWibf7BFf5XaY+Rnti8iD+zi1x2xqF4ftkvvs1pZU3JkjZTeDbDmH4FYlTB6/e01a53SOgcGrYLhj3ZnL8ALsxfuf4L2tgFnceeKjoLqiFvRlwLaj8k7dGiUJdipRF15LZpp91QM1s3pCGbfD8ldcmq7hvOmkAe+A==
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DU2PR04MB9018.eurprd04.prod.outlook.com (2603:10a6:10:2d9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 19:58:35 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 19:58:35 +0000
Date: Thu, 4 Jun 2026 15:58:29 -0400
From: Frank Li <Frank.li@nxp.com>
To: Devendra K Verma <devendra.verma@amd.com>
Cc: bhelgaas@google.com, mani@kernel.org, vkoul@kernel.org,
	Frank.Li@kernel.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, michal.simek@amd.com
Subject: Re: [PATCH v3] dmaengine: dw-edma: Enable HDMA 64R/W Channels
Message-ID: <aiHY5V937ygrQ7Zt@lizhi-Precision-Tower-5810>
References: <20260603144147.3249691-1-devendra.verma@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603144147.3249691-1-devendra.verma@amd.com>
X-ClientProxiedBy: SN6PR16CA0045.namprd16.prod.outlook.com
 (2603:10b6:805:ca::22) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DU2PR04MB9018:EE_
X-MS-Office365-Filtering-Correlation-Id: f7f7b323-fabb-49fa-57e5-08dec273a955
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|376014|22082099003|18002099003|11063799006|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info:
	Jr93IncF3QhtVN1iGVaWS8g5WTfgEdkBqSZiN3O5aTdflTSy/Ra25KTLutgpfeQ5lrweeuFUzcVxvTpIzNgZbUfzHwPy5kUaDRKSiMlnTXE6hiCeI3NJ/in3ABJDd3pTi8T4LqfQ7P2BxPrPxQjcmhyRMMakok/VywNBuGyrTqZP/tg/3NT238ZuK7j67rnN35jKJ5crubHJ/0TQSd73bWFIVZVpHFEBr/ErhnyajfzD+XROK8qSzK3mxPLqFfOriVzxtksexqp6ZdrBTtDhIRjgOsAc2jPyyRSX2BVrQZIZNVPm5L9x6Tkxh5kEt46RSfhm3sMd71Fc4aXUjNHh5FSE2O/8LY0y612IbT9ZrorKamGymG0UVbpR9hlaSVbI8orFmBgobT7SWE771eF1pcrDK9gr7hEQ7OYlamNREJPRZ11Bk3mXnLe3Sdat2qg1d1qaKQOaqFR/+IcryVtz70xIWRNvbxIs8RGZhQOJNGX3dcoJBCJ+eU0XP6BxhlqYOhA32xXxXLH5xxK3abKYTW+8pQZXEJuHdyr5Z/saALMe3WUvNpbF95k+ajxkhKbcYhzk7kcVdf2aZ6MHUYtHkXsry2EhsDZuVNkS9Xgev60cHnbe3pfFLZC+oF5NtVDGE05TXE9M31TO2u4pmqacith0HUncG5GoDGdlY4+HlVoaqwHLn0BBw36boFLJXYRvNYMPMIQuFOu5snlbSMHpyf27QtoDTVSJdpvozyC+DRsbWvJ6h4avGfM9iRkw7t5O
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(376014)(22082099003)(18002099003)(11063799006)(56012099006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ias1WtbVxY/vt8hI1UbRfUB/e6mMIsKhHjLec5o0AwmUcuLtkkPsGr1YGKHh?=
 =?us-ascii?Q?2G21ZC4cGgwKWi7ny2T6BNWC7DMtwv9vGfG7S/UAhQRgINCUFao/xZSFg878?=
 =?us-ascii?Q?Amo+fEzVTFpHq9gPOrMJEnort33qAzT6RL9tcr8hq9IpT/NjWKzgvUU/20a4?=
 =?us-ascii?Q?OHuOXoXCVCDqbP9vR2qEwuw8oR68kWQG4NMpAtQakKnuKS8xrtRsuN/ox3ij?=
 =?us-ascii?Q?alre678oeCw+X95q/pXDweSomEB9DSgzNg+vBT3RIBmN9SLghN4Vzk5TGb8S?=
 =?us-ascii?Q?EDi3omliIvYCThdoybPP7kJ+888T+LoYDxxb8ywF8MlYUYgxfhkWulSKojTQ?=
 =?us-ascii?Q?/lp4hKYcFESwBfKIPBx8QI2RpIHjejynCaZDwFtwJf71Yg7AgjLNUZspsbDE?=
 =?us-ascii?Q?8R6uW0XMPDV5m1rTXSY/uAGIRCTltvNuIbWVr17p8KRAeUkLvolT21riINo1?=
 =?us-ascii?Q?1acD9VNQQFOOM29hX1bUYQTy9rod4qhJPGq+G3ERGoJULlBlPNvwIbq5AmAA?=
 =?us-ascii?Q?6ckBt3pat8jN9QSQxktLloP27lN8bfBH6ZxaPq39n3XYFksq3JG1hwZ3esPG?=
 =?us-ascii?Q?uCbtbyhtnANMHmG44sg+rWcUn7qzW2LDMkqvP9pfuggFGjQ9p/iL508w/v41?=
 =?us-ascii?Q?jb4UMZ4dJeN8iVzEZai8LTtD0iCNx8px+7iZRcAnvNn34AKNNWjSrcJWf1/l?=
 =?us-ascii?Q?dGYs+7Jw6zo1n/78NdgfF5kWhXuWFWV6ojrR+fDwmb54FPyr0JhiWZaZq4s4?=
 =?us-ascii?Q?W2QSIRgo8efRoI9mK6DuBeAxNvU1Y5EqaVaQNgKPj0aH0ro+1PoQNuh2Z5Pq?=
 =?us-ascii?Q?+1KCT+9V0dnBZqp/OMUeqaqqtduUKoaTCQJh2TBfCW8WcGgW/YUuhzFXNeXT?=
 =?us-ascii?Q?XAdcVL2rovygSngjuN5ycPlXNyqE7b7qM06oko4+5l2EIAgsLgC8xSs2V1pH?=
 =?us-ascii?Q?YLUKNe0na2tWLuDKrselkLhPFr3zREZItFn7wHhNUzu8FyieKirgYXInBDVH?=
 =?us-ascii?Q?3nKL8tYYw+IzJeE63E62K+HSaf4rpNq2Eg/pS6P75g/mPuywfoIp4ORpvyVO?=
 =?us-ascii?Q?UVUq62suEzz9pYY4/51SXU3+9z5WSARgnQwUqJR4zU6ABWC6n1i6UvHpTjLY?=
 =?us-ascii?Q?sVE6H3aryv5t80OcbF7h6vyv0Oqd07/wpEnMdL1P08gJcYnPy83hXhBzKVvc?=
 =?us-ascii?Q?sJUjQPSpU/XrAFHa3S7T9leUULFK8TYw8bvxnu+ULV80uSdQRy9ev7DfkiKB?=
 =?us-ascii?Q?nnMffTXr2eNC85kH3h6sl0i6ln4CfgJRjCLv/NX3SYXpdACbyNnZuFWcD0eT?=
 =?us-ascii?Q?iOkhcRe1qamcHE2oCor9BadDcTfZcltsLJOl36OswdArR2TlPEGO9lQxBAYd?=
 =?us-ascii?Q?FPMUaB4wEk9cAiZt8b677C6xKVAjDK3y2/M2bZ+xNPgKnc7TN7xhq5SMfkZZ?=
 =?us-ascii?Q?b5HjDICaYwhB78O55HUrQf3ak2Lxj7CsBEk/wFL/V/ElMK+tAHBx1npJ3Pg3?=
 =?us-ascii?Q?b9/EEhBkbXWdi2Z5gBzBXhD2LM/BDA26H3Mm2sO6oTJSFW3Y1wnMfjMzYeGI?=
 =?us-ascii?Q?Hbr0h46nwyqLHadSj7QAJgQ6Mi5HDhpaqDpZ3u1T7Bs79g8iwIg2vNOr0yJE?=
 =?us-ascii?Q?5eKKyZz0QxRdGoopBqDfHrtVTINx4YDo5f/KRbC4oA0Fw0fb+Kj/r8K6ZNdB?=
 =?us-ascii?Q?htHxnt+ADzSr0Sm5pbizXdL4hyy8Qu6rT7LEABg/qLAmJOwprlewyw7WhJJG?=
 =?us-ascii?Q?NPJgfoNlHA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7f7b323-fabb-49fa-57e5-08dec273a955
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 19:58:35.3067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kBv5Ul7ujXGGeGxe6kluvzdwblPCMvP5Kw7wxOAaXJyOFvCH4Qbm74X+oaGxfHe10iVuA89McLeyM5sDf0fz4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9018
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11168-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:devendra.verma@amd.com,m:bhelgaas@google.com,m:mani@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:michal.simek@amd.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:from_mime,nxp.com:dkim,amd.com:email,lizhi-Precision-Tower-5810:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1608A6430FC

On Wed, Jun 03, 2026 at 08:11:47PM +0530, Devendra K Verma wrote:
> As per 'Designware Cores PCI Express Controller Databook',
> Section 7.1 - Overview, HDMA supports 64 Read and 64 Write
> channels. Current controller driver supports up to 8 read and
> write channels only. In order to utilize all the channels the
> controller driver need to have the channel related structs
> and variables as per the number of channels supported by IP.
> Following changes are made to enable 64 Read / 64 Write
> channel support:
>
>  o Defined HDMA specific macros to reflect the channel count.
>  o The count of ll_regions and dt_regions in dw_edma_chip and
>    dw_edma_pcie_data shall be in accordance to number of read
>    and write channels.
>  o In dw_edma_probe() configure the channels as per the channels
>    of the IP used.
>  o Changed mask types to u64 for higher channel counts.
>
> Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
> ---
> Changes in v2:
>   o Fixed the pre-existing bug related to GET_CH_32
>     interchanging the channel direction and id.
>     This bug was not caused by any version of this patch.
>   o Fixed the issue when using for_each_set_bit() for mask
>     of u64 type.
>
> Changes in v1:
>   o On review recommendation of sashiko bot, in the function
>     dw_hdma_v0_core_off(), the loop iterates over registers
>     as per the number of channels enabled and not on total
>     number of channels supported.
>   o Changed mask types to u64 for higher channel counts.
> ---
...
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> @@ -53,13 +53,24 @@ __dw_ch_regs(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch)
>  static void dw_hdma_v0_core_off(struct dw_edma *dw)
>  {
>  	int id;
> +	enum dw_edma_dir dir;
> +
> +	dir = EDMA_DIR_WRITE;
> +	for (id = 0; id < dw->wr_ch_cnt; id++) {
> +		SET_CH_32(dw, dir, id, int_setup,
> +			  HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
> +		SET_CH_32(dw, dir, id, int_clear,
> +			  HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
> +		SET_CH_32(dw, dir, id, ch_en, 0);
> +	}
>
> -	for (id = 0; id < HDMA_V0_MAX_NR_CH; id++) {
> -		SET_BOTH_CH_32(dw, id, int_setup,
> -			       HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
> -		SET_BOTH_CH_32(dw, id, int_clear,
> -			       HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
> -		SET_BOTH_CH_32(dw, id, ch_en, 0);
> +	dir = EDMA_DIR_READ;
> +	for (id = 0; id < dw->rd_ch_cnt; id++) {
> +		SET_CH_32(dw, dir, id, int_setup,
> +			  HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
> +		SET_CH_32(dw, dir, id, int_clear,
> +			  HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
> +		SET_CH_32(dw, dir, id, ch_en, 0);

why SET_BOTH_CH_32 not work for 64 channel?

>  	}
>  }
>
> @@ -79,7 +90,7 @@ static enum dma_status dw_hdma_v0_core_ch_status(struct dw_edma_chan *chan)
>  	u32 tmp;
>
>  	tmp = FIELD_GET(HDMA_V0_CH_STATUS_MASK,
> -			GET_CH_32(dw, chan->id, chan->dir, ch_stat));
> +			GET_CH_32(dw, chan->dir, chan->id, ch_stat));

why need swtich id and dir here ?

Frank
>
>  	if (tmp == 1)
>  		return DMA_IN_PROGRESS;
> @@ -118,7 +129,8 @@ dw_hdma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
>  	unsigned long total, pos, val;
>  	irqreturn_t ret = IRQ_NONE;
>  	struct dw_edma_chan *chan;
> -	unsigned long off, mask;
> +	unsigned long off;
> +	u64 mask;
>
>  	if (dir == EDMA_DIR_WRITE) {
>  		total = dw->wr_ch_cnt;
> @@ -130,7 +142,11 @@ dw_hdma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
>  		mask = dw_irq->rd_mask;
>  	}
>
> -	for_each_set_bit(pos, &mask, total) {
> +	while (mask) {
> +		pos = __ffs64(mask);
> +		if (pos >= total)
> +			break;
> +
>  		chan = &dw->chan[pos + off];
>
>  		val = dw_hdma_v0_core_status_int(chan);
> @@ -147,6 +163,7 @@ dw_hdma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
>
>  			ret = IRQ_HANDLED;
>  		}
> +		mask &= mask - 1;
>  	}
>
>  	return ret;
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-regs.h b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> index 7759ba9b4850..48e40efceb2e 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> @@ -11,7 +11,7 @@
>
>  #include <linux/dmaengine.h>
>
> -#define HDMA_V0_MAX_NR_CH			8
> +#define HDMA_V0_MAX_NR_CH			64
>  #define HDMA_V0_CH_EN				BIT(0)
>  #define HDMA_V0_LOCAL_ABORT_INT_EN		BIT(6)
>  #define HDMA_V0_REMOTE_ABORT_INT_EN		BIT(5)
> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> index 1fafd5b0e315..da7a5cc93ad4 100644
> --- a/include/linux/dma/edma.h
> +++ b/include/linux/dma/edma.h
> @@ -14,6 +14,8 @@
>
>  #define EDMA_MAX_WR_CH                                  8
>  #define EDMA_MAX_RD_CH                                  8
> +#define HDMA_MAX_WR_CH                                  64
> +#define HDMA_MAX_RD_CH                                  64
>
>  struct dw_edma;
>
> @@ -89,12 +91,12 @@ struct dw_edma_chip {
>  	u16			ll_wr_cnt;
>  	u16			ll_rd_cnt;
>  	/* link list address */
> -	struct dw_edma_region	ll_region_wr[EDMA_MAX_WR_CH];
> -	struct dw_edma_region	ll_region_rd[EDMA_MAX_RD_CH];
> +	struct dw_edma_region	ll_region_wr[HDMA_MAX_WR_CH];
> +	struct dw_edma_region	ll_region_rd[HDMA_MAX_RD_CH];
>
>  	/* data region */
> -	struct dw_edma_region	dt_region_wr[EDMA_MAX_WR_CH];
> -	struct dw_edma_region	dt_region_rd[EDMA_MAX_RD_CH];
> +	struct dw_edma_region	dt_region_wr[HDMA_MAX_WR_CH];
> +	struct dw_edma_region	dt_region_rd[HDMA_MAX_RD_CH];
>
>  	/* interrupt emulation */
>  	int			db_irq;
> --
> 2.43.0
>

