Return-Path: <dmaengine+bounces-11169-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ULNBGATfIWoPQAEAu9opvQ
	(envelope-from <dmaengine+bounces-11169-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 04 Jun 2026 22:24:36 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AEAF9643475
	for <lists+dmaengine@lfdr.de>; Thu, 04 Jun 2026 22:24:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=Czv1dI+D;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11169-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11169-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F2703018D58
	for <lists+dmaengine@lfdr.de>; Thu,  4 Jun 2026 20:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DDE35B650;
	Thu,  4 Jun 2026 20:18:13 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011016.outbound.protection.outlook.com [52.101.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D63F3C1981;
	Thu,  4 Jun 2026 20:18:11 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780604293; cv=fail; b=JiAuuO+Y8XEfO5S1MlauvK9lH4/x/Yosn5GRK/gg+O9UiMuhB5yBvo29/JOh6grWcw16Cw4V+JOJKod76tbdskIaQV3WkI9adfTxOMO8usyMVIUmiimRc3nXBqnFkKCgrciM3Yj6l/6YiLRsFouoDYL+vbmm1+dxmDjPHusWAog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780604293; c=relaxed/simple;
	bh=Se9++vVE9okS+zj7GGqD3rgXBC64gPMLU8sgcSg1IAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M0rKn30g5Hoc6scxj4U/llnsjBOFbCyUMYDGjuqnAMvUJRal/NAIDAHEr/i6QTarX8xxZhD73LMsUecY00Le0BhiefHJ2JP+0Lgm7X1k6ViZcVv/CKSz/j27jdCRtXLhtLVEvPLPum28Z1Rjk9IsroPZBLos+uQzNqhd1cy1ixI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Czv1dI+D; arc=fail smtp.client-ip=52.101.65.16
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S4+8QYxJaF5QwKzyauMZS2d7GNig9tbGRMWvBNAcG41wEEueiNu7t2lX4uVT3mZkiBCRzJylRBKZC85rkGC+zXl79YI1VWSoCyN4yW23+ZYRC5fvxQO6ZRygFuAzlFGqMdz4xKUsYAtV/hdGKZ02gcd1nQ2kzpqKETazYNkczJfdhT7M/uYdM7A5LRQ29RpDN6EegF1M3lZJsUQ8PWbmByY5MFuOSbMzlAs4K70qG82CueLd+NzgnjV0Bpx6QAjKQvg71syafRansNSAlrpTrjyS/yMBuvKlzOXDZfuVQhRmq7P0Q7gdNpPnELB6lTFQdf0wdEIBKg5Wg5/8sON1Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pV5cgqL48b8Dwx/5+kZgnVhWHumFJeRtNLMt4ZfeaPU=;
 b=NMLFJo+TTIDniCnfkpbR2SzpeJ1HCW+k0BBY205RjxRTvLZ9qJj2GczMMoCFWyn3Qh4L4LJk/yIqzExG/rMa1s9WCsbHt3XgLNmK5AOhDIOHD5j5I/27P8AQkfbL4bZW5O3bc2k2StWjopYNFBqHtAs5rl2za5yTDjle1cRYY3F756zqcaVRgtovntto9JL5uyG48zMdugQbr3nexS5TQL5DenNRzLv+9B6nV45EKLk3MKWDTQnGzMFAqYpRL/c+iSI0Py8vAXefah8Ilp66vKeusnY3l0wx4zriMMCWrJilSMzna8CSeQTIO9UwoqQ4mkyi0XPKr4ihDaFXfRqB3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pV5cgqL48b8Dwx/5+kZgnVhWHumFJeRtNLMt4ZfeaPU=;
 b=Czv1dI+D9so/L6fCIEJSjRtvdfCnq4jeypUJX/w1GePwwaPlhBHU216q2QlqGKUxBa4X7nJkb8BvfsSv71fyNCVl+IRIag2uD86i66hECojGhXitINeHIRupwDPb6lRpYsueBhh3CLmDCixt61oodXlw2mK/paGYZ0D/b3JHf40sGSA3cjDkEJAcjb7pFyfX106NOO1t3HToeo4nxoJqcgloIvfHYEybHCaBWrdHmfnrOKXdLNCy7Mm9DC+cGh/3zUN/IXXV5vH+zLfJor4H45ODi6kdF1DeGR6GyxE3GlkDtbZDZKPMEkZyWdaZY5G6qgK3GWq5hkJgIL0Zuku8hg==
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PAXPR04MB8333.eurprd04.prod.outlook.com (2603:10a6:102:1c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 20:18:08 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 20:18:08 +0000
Date: Thu, 4 Jun 2026 16:18:02 -0400
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/12] dmaengine: dw-edma: Add per-channel interrupt
 routing control
Message-ID: <aiHdevABZTFTZ0Pq@lizhi-Precision-Tower-5810>
References: <20260525062420.3315904-1-den@valinux.co.jp>
 <20260525062420.3315904-3-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525062420.3315904-3-den@valinux.co.jp>
X-ClientProxiedBy: SN7PR04CA0219.namprd04.prod.outlook.com
 (2603:10b6:806:127::14) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PAXPR04MB8333:EE_
X-MS-Office365-Filtering-Correlation-Id: a63a42a7-713d-4658-0951-08dec27664ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|19092799006|366016|52116014|56012099006|6133799003|18002099003|22082099003|38350700014|4143699003|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info:
	s0YkjOysGRYXQqMd1RcikIFV/jmjgr3AAuVqIVP1ax8jk8HsuTPRiutGVTAv/M0O7bq+alhWeQJLGVT6vrXjCrh9gIxBxKWaPyjZUA6hLEVl6yvoLbWeD30B4P2+aFjWQq+jhtWwpYXalednJMzMBs7ppfUDH+/YdBMca2TOHg9J4ZAW41a6FlcNLWNZEQOYHoTJENlyo0XpEmxUWsgR/rZ97TXewX45yI87jiUWmuH2i7uZjICXhOedXLbcgwp6LM+g11Sn1Mr4Q/FoQgETlyZpzZ+S+g4nENhVpAIe/lYwGmaav/8rE+FTeoURaU4PMWuZx5jLyK5536cBaGlggwqVugXKqNKsoI/H7c42TZvmiUPvrikpl4RfSjCVkXLWSiw2Dkhu9qQ/3/+PMQqnpOonExeHsWO1r29QwfVdNU/ckPyVodGFfhZPrGOv9mR2R5aUHJiC7OZRIRT/UkqrPViaGiYdIUpybZkEv1r3V0GiomWKdfdRAIambUQ8PHJtiev59DO5s4RjgM2P8KZyBJtVFMTsvJSDHzDvGdRkaWXDMC8SMl5vk1t1O8GWTdK1Za7Ybw0K6/squEfM5OLPuAyIJZUGUjcZ6QWO1wgXLVZ8GqXfwXla6EZb5l+/Qc7iKf5HDsiPQQFDIN2gLWTfEI92liIrn+Q2VWhxfuUlUuXSDfNVeQO92VPwsVosMGiF5ATCx6Qq0Na6iEQiUU1bHeXbKuImUq1UFaU8P/7dYCbtBoopgdbWZFEkQDTwKWYx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(19092799006)(366016)(52116014)(56012099006)(6133799003)(18002099003)(22082099003)(38350700014)(4143699003)(11063799006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N4a0Rfk6GhrXSFF7drW/3IFqeiw0fNMCQQeKmf3mcPWrtIatIwCw8qDvSTHd?=
 =?us-ascii?Q?PoQGrYfO7rs2tE89zVFYUzo7MXswNrbrS4HdtLIpSbZDNJMzwtJyAAkSvEmC?=
 =?us-ascii?Q?kaPI185ZHF5s8sBr845+n2C2UjWMClBfjvveg3EhKfQWzjOqkWrlpTyGTWrn?=
 =?us-ascii?Q?vOebIqw4R0cEoNi5m7MZPXW+mTTQqwjEDbV2M9VCQPJHvCk8WJycdIQcjkAT?=
 =?us-ascii?Q?4fSVhunINJzx8j/R4FZN2gPtmUq0q1Yjk6i6iW9ykv21+/rJtsO7Bym0l66n?=
 =?us-ascii?Q?7t2L7CiLyTmF6GnPZ5C4WqkRfpyI/5/SrkFnO7EJ7hPQN3BGQEnfYKb3voCq?=
 =?us-ascii?Q?BOnHqDDnVvupaZi/lV8B3J3X3sd4Cj2TYyvF9gMCqCYhZK3mWNh3tO4305l5?=
 =?us-ascii?Q?h/3mrT+0Pn1coUMcwdPqGENJW94RFSKUwhN8FqLU9OfeKy15atdgGLgc3QBE?=
 =?us-ascii?Q?rZY//vQ6/GHf5AAMvSEiE++8OZDnJylRy62bl0o5DMP41fK8egnWG6xNOO/U?=
 =?us-ascii?Q?qOxjqrkB3kr1CCvHS1EiTofKruxKuZwqe9x7hQGqbv87gU0GG0PtKmSOQEWA?=
 =?us-ascii?Q?EGRkKqtQGrJvtO2LSLSrIZx2GmJ3nDPVlOSFGr5GuWw8y/fFNUcDBQxzdlrY?=
 =?us-ascii?Q?YBzq4CTu/mM4qIL3M2dLgLQ65Jb1WctbONUp3YqoXIlXyL10QR429tS8hIDN?=
 =?us-ascii?Q?F4gsG+XVRcVAkG6VsZD71lZNfKyXr22IKnWBf1DCSL+Q75JoiCm0gqXK1Q5I?=
 =?us-ascii?Q?pdtnX5hhNP0etafmWEyjfBvizjeZdav+9GcJC/AKK240FjQURTF3khDIU+ak?=
 =?us-ascii?Q?Hfipw1VQ7dAa/oH64y7G4OTR51VaRQeBh0qVRRK6Me4dyIL1x4xp0ZGmNDfQ?=
 =?us-ascii?Q?LLBgvgqp2S+gMwPEqduTZh5l20pmnGE47EP9zs++gAfjRwNmxOUU4rKLMxx3?=
 =?us-ascii?Q?I3G4WM0U6TXULf4lmEQiFCoNwnX5mRKp3K2dNwhvCLezrzNAAn3bOu7V6ilk?=
 =?us-ascii?Q?QCZ2eOQLl6I/eTR/iKsSmSxrehWwxf/v9wJZJVWneMLA2AdrVV4a00UO9mGu?=
 =?us-ascii?Q?ndaRVjn0sTtnoMSzMq3UAv07tgWl3qTRk9xP3uitDUrX+Ex9f1EoZOhYJ2Rm?=
 =?us-ascii?Q?b2GjDNlGcDOO43Lwq291FI5rM8Dm6rqxeF/BceccPVq6aYts4eEVSlU4sYH6?=
 =?us-ascii?Q?RGy1fJG92qXqcGxxmCXt3yJmqyHDctkcu/QBVZM4WesSH0NYkjVoFBgCUXxY?=
 =?us-ascii?Q?8JocVS6rHyrrGMZhS+CWpYFSBeR1d9TDQ2jmuQPngnNB/+39HR2Soowd1pJ5?=
 =?us-ascii?Q?GTd7Tf9TpngGZGNc5sNgQ4RMZZo1bhCNybDVFKonfW92QHmi3gfwhYuV2vF0?=
 =?us-ascii?Q?Qn1Uhl91oRpyubBLcY9arlURTOTVtMeIRvTqNntRvnmcsaUeEDT1IlhxLKNA?=
 =?us-ascii?Q?BDYNFuXPIrQVEHpnCtz7Dh/tNuIL+gFFuYGty4Gz/6ydfMM+hfawGS3/d5FC?=
 =?us-ascii?Q?lJDkiFAvhgKziKRdROtb6uxbjyWJeTayK7H410nXpFY5Q1Bi4DKrmkIMzHgo?=
 =?us-ascii?Q?xoQh0nDCcJGexPVHSw+D9JTBdZaWLubEOxEQ05FLD24lVmWkMXTBvHgJqQQz?=
 =?us-ascii?Q?9v1mA4Rj5jHD1NCgwlh30m8Jgn6W8znurulWbV463kmAvh5g4AStdA4Wz4/r?=
 =?us-ascii?Q?fHoEpvns339vOaUEc6WGyhmm+tYfFXvBa8VcNV52pnjRMfq1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a63a42a7-713d-4658-0951-08dec27664ad
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 20:18:08.5488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wXnGanNaQZRXS7aHHrFDpgDxjDlpge5a2ypYKsY4T8DMcKk/w8WOYBPoZ8XBd0OPah7NPnIN5JfNZ8TiD0Ul3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8333
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:den@valinux.co.jp,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:mani@kernel.org,m:marek.vasut+renesas@mailbox.org,m:yoshihiro.shimoda.uh@renesas.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:marek.vasut@mailbox.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11169-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lizhi-Precision-Tower-5810:mid,vger.kernel.org:from_smtp,valinux.co.jp:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AEAF9643475

On Mon, May 25, 2026 at 03:24:10PM +0900, Koichiro Den wrote:
> DesignWare eDMA can signal completion locally through edma_int[] and
> remotely through IMWr/MSI. When channels are delegated to a remote
> frontend, the local endpoint side and the remote host side must not both
> service the same DONE/ABORT status.
>
> Add dw_edma_irq_config, carried through dma_slave_config, so a frontend
> can choose default, local, or remote IRQ handling per channel. Update the
> v0 path so linked-list interrupt generation and DONE/ABORT masking follow
> the selected mode. If a frontend does not supply the config, keep the
> existing behavior.
>
> HDMA native already uses dma_slave_config.peripheral_config as an int for
> non-LL mode selection. Keep that interface unchanged and reject the new
> IRQ config there until an IRQ routing model is implemented and validated.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
...
>
> +static inline bool
> +dw_edma_core_ch_ignore_irq(struct dw_edma_chan *chan)
> +{
> +	struct dw_edma *dw = chan->dw;
> +
> +	if (dw->chip->flags & DW_EDMA_CHIP_LOCAL)

suppose it should be pre channel config, why need check chip's informaiton?

> +		return chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE;
> +	else
> +		return chan->irq_mode == DW_EDMA_CH_IRQ_LOCAL;
> +}
> +
>  #endif /* _DW_EDMA_CORE_H */
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> index 69e8279adec8..08ec2bd7856e 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> @@ -256,9 +256,11 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
>  	for_each_set_bit(pos, &val, total) {
>  		chan = &dw->chan[pos + off];
>
> +		if (dw_edma_core_ch_ignore_irq(chan))
> +			continue;
> +
>  		dw_edma_v0_core_clear_done_int(chan);
>  		done(chan);
> -
>  		ret = IRQ_HANDLED;
>  	}
>
> @@ -267,9 +269,11 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
>  	for_each_set_bit(pos, &val, total) {
>  		chan = &dw->chan[pos + off];
>
> +		if (dw_edma_core_ch_ignore_irq(chan))
> +			continue;
> +
>  		dw_edma_v0_core_clear_abort_int(chan);
>  		abort(chan);
> -
>  		ret = IRQ_HANDLED;
>  	}
>
> @@ -331,7 +335,8 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
>  		j--;
>  		if (!j) {
>  			control |= DW_EDMA_V0_LIE;
> -			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
> +			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) &&
> +			    chan->irq_mode != DW_EDMA_CH_IRQ_LOCAL)
>  				control |= DW_EDMA_V0_RIE;
>  		}
>
> @@ -407,10 +412,15 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>  				break;
>  			}
>  		}
> -		/* Interrupt unmask - done, abort */
> +		/* Interrupt mask/unmask - done, abort */
>  		tmp = GET_RW_32(dw, chan->dir, int_mask);
> -		tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
> -		tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
> +		if (chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE) {
> +			tmp |= FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
> +			tmp |= FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
> +		} else {
> +			tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
> +			tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
> +		}
>  		SET_RW_32(dw, chan->dir, int_mask, tmp);
>  		/* Linked list error */
>  		tmp = GET_RW_32(dw, chan->dir, linked_list_err_en);
> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> index 3e15cf83b784..2bf2298711e1 100644
> --- a/include/linux/dma/edma.h
> +++ b/include/linux/dma/edma.h
> @@ -60,6 +60,43 @@ enum dw_edma_chip_flags {
>  	DW_EDMA_CHIP_LOCAL	= BIT(0),
>  };
>
> +/**
> + * enum dw_edma_ch_irq_mode - per-channel interrupt routing control
> + * @DW_EDMA_CH_IRQ_DEFAULT:   keep legacy behavior

Feel like it make things complex, most likely use pcie ep probe, it should
be use DW_EDMA_CH_IRQ_LOCAL.

If probe from dw-edma-pcie.c, it should be use DW_EDMA_CH_IRQ_REMOTE.

Add default mode, it make check logic become complex.

Frank

> + * @DW_EDMA_CH_IRQ_LOCAL:     local interrupt only (edma_int[])
> + * @DW_EDMA_CH_IRQ_REMOTE:    remote interrupt only (IMWr/MSI),
> + *                            while masking local DONE/ABORT output.
> + *
> + * DesignWare EP eDMA can signal interrupts locally through the edma_int[]
> + * bus, and remotely using posted memory writes (IMWr) that may be
> + * interpreted as MSI/MSI-X by the RC.
> + *
> + * For the v0 eDMA programming path, DMA_*_INT_MASK gates the local edma_int[]
> + * assertion, while there is no dedicated per-channel mask for IMWr generation.
> + * To request a remote-only interrupt, Synopsys recommends setting both LIE and
> + * RIE, and masking the local interrupt in DMA_*_INT_MASK (rather than relying
> + * on LIE=0/RIE=1). See the DesignWare endpoint databook 5.40a, Non Linked
> + * List Mode interrupt handling ("Hint").
> + */
> +enum dw_edma_ch_irq_mode {
> +	DW_EDMA_CH_IRQ_DEFAULT	= 0,
> +	DW_EDMA_CH_IRQ_LOCAL,
> +	DW_EDMA_CH_IRQ_REMOTE,
> +};
> +
> +/**
> + * struct dw_edma_irq_config - dw-edma interrupt routing configuration
> + * @irq_mode: per-channel interrupt routing control.
> + * @reserved: must be zero.
> + *
> + * Pass this structure via dma_slave_config.peripheral_config and
> + * dma_slave_config.peripheral_size.
> + */
> +struct dw_edma_irq_config {
> +	enum dw_edma_ch_irq_mode irq_mode;
> +	u32 reserved;
> +};
> +
>  /**
>   * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
>   * @dev:		 struct device of the eDMA controller
> @@ -76,6 +113,8 @@ enum dw_edma_chip_flags {
>   * @db_irq:		 Virtual IRQ dedicated to interrupt emulation
>   * @db_offset:		 Offset from DMA register base
>   * @mf:			 DMA register map format
> + * @default_irq_mode:	 default per-channel interrupt routing when client
> + *			 does not supply dw_edma_irq_config
>   * @dw:			 struct dw_edma that is filled by dw_edma_probe()
>   */
>  struct dw_edma_chip {
> @@ -101,6 +140,7 @@ struct dw_edma_chip {
>  	resource_size_t		db_offset;
>
>  	enum dw_edma_map_format	mf;
> +	enum dw_edma_ch_irq_mode	default_irq_mode;

suppose it is pre-channel config?

Frank
>
>  	struct dw_edma		*dw;
>  	bool			cfg_non_ll;
> --
> 2.51.0
>

