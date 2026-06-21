Return-Path: <dmaengine+bounces-11685-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RJq4JMX2N2rYWAcAu9opvQ
	(envelope-from <dmaengine+bounces-11685-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 21 Jun 2026 16:35:49 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FD56AB15A
	for <lists+dmaengine@lfdr.de>; Sun, 21 Jun 2026 16:35:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("body hash did not verify") header.d=valinux.co.jp header.s=selector1 header.b=hTfmCaXm;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11685-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11685-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=valinux.co.jp (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 782FC3013B50
	for <lists+dmaengine@lfdr.de>; Sun, 21 Jun 2026 14:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2D136F429;
	Sun, 21 Jun 2026 14:35:44 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021126.outbound.protection.outlook.com [40.107.74.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F38F368D6F
	for <dmaengine@vger.kernel.org>; Sun, 21 Jun 2026 14:35:41 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782052544; cv=fail; b=CVnBoUCShg/2dr+JuSoB8i2uKEiKdXAiYOrtoYB5dW32/591YxJi7wU/CtTXNKKuhm+cUeQO4B70vzS8zT6BlbdGEpD5vdhobk9c6qzbZ3S125ICj01itncE09pNIp/LNYeQa0SZO+ow0WozEYHCtLkIyfoweHL7zoy/4F8wh6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782052544; c=relaxed/simple;
	bh=ao1cMbF7isrVCp/TzGurklCyHAihXJVCcKjWXK9Bj9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dqCfJoKWAjk1kK3yadEFfWmemzhYtUboIZyhbE3I3nvBBfrGVhoLadxUM6VAqwJP+LYzO+w0thjqiXLCugwECPFlYq3o5UXgCUKRPPaMROjGXWkCESeot/VAWFShOw1QI5pzrnZEzuSysLABq/uXvq84/2Ds0Qaf2Pd2wP6uXCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=fail (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=hTfmCaXm reason="signature verification failed"; arc=fail smtp.client-ip=40.107.74.126
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YjKHJR+cGteiLrSH7SkrI0DfgsEVr5o7GoWnKC9IosTt4FagxIrB/P9rh9AOiG85N6dsb3Ii/JtEJXSjeV0PDS1hH7b4PlUnm1jNsJWU15+QyO43G/rRXMYKqaFHHi3WjLrymdvLy7MvojU2oUVd+xzyWyI280VAPfjKCPgrYR0rYgYY7PsEK80vvnkD3BldcC7J5ISCfRXCzpgX33ZJNPwlTwxSkfflH1cYK/nQ32kk9ayykWn1yniBZhOwyFQCDjLF6e/u+xU3lJBzMLSwZicFIii0dkVzT89KMURC+bMSr8nRd3wSDhWhG1JAqZUUqKVpsDRK6/zqafh8oAG0nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pMVcVKHqJkfI4vW666Rhv585VAoJitcO0Eq+zytx/9A=;
 b=R+lHZ1I2gTkXay2JHp6qIZQrlzg/yKKjwomcwIVSZCnDfBulgkP4gtCOXRNIhK7wGt1aNGDi5+G7fkqF6fHETYnfI7gZaQPDPgJQ6DAYYzPMbQ+Az2aPHTvuFjDbeohZgUdkZmwPQ99R17whdl4LE96B11JGHbeOPIr3plg75yv5bj3eV4nY5kQA82nM5di7oy45f0wZbCc87pOOsKw1ASCWyUeCB+3IaKi6bRLOZUrZ6e6jORr0oMqye3kilyvd2sPZF/P6HaGonXz3M3ibvsOUFlKBwPYoXX9TO2tT0uNcZoaiHiKG1eijoJv+1nCoTm0nPOxrCQHMKIKaiR4qvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMVcVKHqJkfI4vW666Rhv585VAoJitcO0Eq+zytx/9A=;
 b=hTfmCaXmG+AlWNstfO2KYBRCyD2NnNNVWx6PrLh++Zaahadhn9+Ru6qySjjG1mAAiqUhGpwq5EgwkO9EDZq6OekaKY7JcwPDcT1Zqbxj92H+JRMZYphEHtRmfc3geEnTOQEXvWLyDEX20jwwh1DGgp0/r8HtCcwAInxJBy0ccgQ=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY4P286MB5774.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:2c7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Sun, 21 Jun
 2026 14:35:35 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0139.018; Sun, 21 Jun 2026
 14:35:35 +0000
Date: Sun, 21 Jun 2026 23:35:33 +0900
From: Koichiro Den <den@valinux.co.jp>
To: sashiko-reviews@lists.linux.dev
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v3 01/13] dmaengine: dw-edma: Add per-channel interrupt
 routing control
Message-ID: <srhpqgi4vitjhbehchlq7ri6yti6ghvlxjzszxad2lmfvr6vz4@aqfnmcew3zlu>
References: <20260620170040.3756043-1-den@valinux.co.jp>
 <20260620170040.3756043-2-den@valinux.co.jp>
 <20260620171353.436AE1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260620171353.436AE1F000E9@smtp.kernel.org>
X-ClientProxiedBy: TYCP286CA0031.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::6) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY4P286MB5774:EE_
X-MS-Office365-Filtering-Correlation-Id: b5434c95-93bf-418d-4eef-08decfa25ae1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|376014|23010399003|1800799024|6133799003|3023799007|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	/1aS6phgtEDY6veayhvrMrV0WFuknfolAtlJ7Q2eWQJ6A6AClHgQCXPVDNJ1oqleZM4dHsd0EN1XZkuNED9BSqMkYEhQcUWlgCSH3/pblAmA0aYW/Lcq1V1/KHS3kdlt5uEY9MbP3yGxRZXghGFSHkStTfV8oCUgq8fPdLjoPRy3oJ07WcWyd/a6tNdDKnqJg0tq77UI5ZfjXFVzGed2fPLSW4yu5+uadDPrXIpZ7G3UTL7aRHcu2ZKdLbl+DNx1M3NbaNk7qzppFf87MtzxWrrvxG/z7M0+AcxaVHLTQgjvTgYHw/PQQOJMJ85xJDpTL7zNNVnI1sl3lRtqw+6GmuGGEbUrpMvF5aAOJ9BPRBxQVgguk7+LzTm+bo/H3Ylu+gmmKyvqHfvkNj117bc8qLTfQkMrld98VhwTeBdK20/vCRIO8edtL9QVIKkNBw9TSCZZpgPFbFJHmU/Dx8PvvCdyTh5qzP2fA3PuPh1//XWAeDm7q/FFnmatq2g6cbFfagWfDGlw8iOIQoxR5wdcCqpta0gv1fPvMULokBQ0esYdrfF3MhzyYEwVz3ksf2aMmXeXIjmCOCmVMXjNIwPlPAeG2YDPZ0mGE7fJ4xLX6UI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(23010399003)(1800799024)(6133799003)(3023799007)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?dEx++/QkoTtcsjxXpVEaLmhlU3QIpUrGIIxS5aOrnEyO1HHIIBcVsQ+/ZR?=
 =?iso-8859-1?Q?pK9j3IrpOjQQtMK5n5C32TtDloSS/sVb3Gyaqs8bHO8UaUN+MahaWEnJHI?=
 =?iso-8859-1?Q?C6MS0B1bW4LLV6an81+ZcPnoalbhqhbnWlRh6dPGhjxpF5bJf6Yr4CYrdY?=
 =?iso-8859-1?Q?si64tz2+/QsdCdLTjzW2KqQqva9t4hOqjIADJnU41QjTMrpJcXyFCq6+Js?=
 =?iso-8859-1?Q?3m0qgV+Tb6S6adJsM+cfo4uek+X8YGc0cEZRcnz6CC3jzsvSPDtNibU1Br?=
 =?iso-8859-1?Q?vOa2a1aw823hwVpIP/+NVUTNLHNZ0D1+7pHhTVaEzTxxrOO2dCg9Kd5a69?=
 =?iso-8859-1?Q?/X31Lf8YphYmUjxt3Vh4BOljr9sA4uQCgTttgC7uqAoaUPdyEj4v6fQv6t?=
 =?iso-8859-1?Q?DCRzRrkU5k2S55bW+r0L6Oz9Z+pl27puEuYtJw6HOcofqPWmJZHFKUH6IZ?=
 =?iso-8859-1?Q?FO6DApIRfDlFse3B3ln76BzBGlKbWs7/zkgi7Lub0LPqiS3czXTS51Ozcb?=
 =?iso-8859-1?Q?0dCM2QVnluFBJ9Hul4jbEGchX551FMd55YGD6xIibCSwvixv1FUPDF41Sr?=
 =?iso-8859-1?Q?a6pBPBtE58LW2rws4feOmBcuRYAdwkNcT41mB1KNVyW/lRyI1/IVQiUqDC?=
 =?iso-8859-1?Q?A0/wd9Qu9S9OZMDylpzosyjIgcBwvWpH+dBqPir72Y4U+C6+FYcu60bsOE?=
 =?iso-8859-1?Q?ILni0K8ix9d390Jj+vt1erlxO+jYdym6q5jrc7JwG+J8kwjJZ+Rlo1oSqT?=
 =?iso-8859-1?Q?1t9GO8FbhInqPaOZpuAWd2a8PdWMM8m0GPRQkLClzliF3C8tp8y3HO9Kxo?=
 =?iso-8859-1?Q?bL/uCdpNsHaFhz+cA3s0NrRRGpVOPmWy9B66aXIWpF/vP5MI3QVe/Lv3ye?=
 =?iso-8859-1?Q?SnFhcgHqRJ5gkmLo9y2ZUoOShcj/Kg1YPFKZfBOJBpq3YXRBw1tfM6Eyuv?=
 =?iso-8859-1?Q?NnBu3wrB8wvkDglcvJ2fzG7ShJaVDm9dsIsYSfcu8pVRUHyCp9xvC0xu8d?=
 =?iso-8859-1?Q?H0XJpO1oO93xZKkaURjr3ywMzYmZCKtA4wmpcEac7L+3Mc0u9ejiWyq7VU?=
 =?iso-8859-1?Q?VKe0WDEcUqL1w02UZLhNu7DsDc3el/tAOwnn0k5KV33qiYqQ/1nGnsLoEW?=
 =?iso-8859-1?Q?gl+D+5GmWfmXhrgSFvLHvu/3yNrbUxX3H7/3KZEKyINo7jXOd55o8a5RIL?=
 =?iso-8859-1?Q?c268TJmajJ9ye6bFYz4mQm0yZcsIZQBX8WuKW1qQYdNXMLoFJ0nDncw86i?=
 =?iso-8859-1?Q?A2xNeN3KXz1mtcWxOLfuVbNPOK9YfLcMmj3LYcQFJkc5v5CQsQWKC+DgnA?=
 =?iso-8859-1?Q?w12g+PvOmvVySmwFngY94B+rlceIGCxBDX2U0beaiozaf4lkbHdEIAwqb3?=
 =?iso-8859-1?Q?/vcGj6i7F9tAe+x9qiz2i3awItFqg5UY8X+PWTyKbSyPvbl2MJvTxXYbHD?=
 =?iso-8859-1?Q?ujCGOrntzYSTs7fv6fwNb8p2FCC/03BUJOF0NL0TQIDcbi4+pb/JzrSwBp?=
 =?iso-8859-1?Q?VwvFHpv7aNI93zDZweqEb3EneMgys7kyME6QwaN+02LfyFvtJrrlCHavYC?=
 =?iso-8859-1?Q?5pWZ/MMldhXwlyGiM2rcsX/D6D5JpB9KrRTukYQbzqxYEtVnWscMzlhp8Q?=
 =?iso-8859-1?Q?cfSFIPqN7TEjhQ3/S63uPkIy6Ur7FOaqsrm04XWLCGP3m1LyX4qMPpgU0E?=
 =?iso-8859-1?Q?qf4iw7WlJD3puFcfsSxj5TFT0LyPUJZKq3Msicr1Rs3FR7TTki5SaerrDn?=
 =?iso-8859-1?Q?QnfDspGfxVykIKzl3HAz4ICzlDp2kB1rd3OmOOT3KkCWvgDdxs+KD+0y6x?=
 =?iso-8859-1?Q?QBNDVnyLeGBirHnUBpO/HK4Q0FxemdBZYBXDA1lNdo0qIYxT/K52?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: b5434c95-93bf-418d-4eef-08decfa25ae1
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2026 14:35:35.0070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jg/Z2vS69GHPHrg+V+0yK570JRSvER446v66yNRA6TM5lwogKtpt4cAZxAGLG1CIPXaLf13z+BEVp8nCYJWWWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB5774
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.14 / 15.00];
	R_DKIM_REJECT(1.00)[valinux.co.jp:s=selector1];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[valinux.co.jp : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11685-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:-];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 76FD56AB15A

On Sat, Jun 20, 2026 at 05:13:52PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] V0 eDMA fails to set the Remote Interrupt Enable (RIE) bit for remote-routed channels on a local endpoint controller.

This is a false positive.

> --
> 
> commit df5a2947e52cc02cfc126b63bc365277ac3752fa
> Author: Koichiro Den <den@valinux.co.jp>
> dmaengine: dw-edma: Add per-channel interrupt routing control
> 
> This commit adds per-channel interrupt routing control to the DesignWare
> eDMA driver, allowing channels to route completion signals locally or
> remotely. It updates the v0 eDMA and HDMA paths to configure interrupt masks
> and generation based on the selected mode.
> 
> > diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> [ ... ]
> > @@ -331,7 +335,8 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
> >  		j--;
> >  		if (!j) {
> >  			control |= DW_EDMA_V0_LIE;
> > -			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
> > +			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) &&
> > +			    chan->irq_mode != DW_EDMA_CH_IRQ_LOCAL)
> >  				control |= DW_EDMA_V0_RIE;
> >  		}
> 
> [Severity: High]
> When a local endpoint controller delegates a channel to a remote host, the
> irq_mode is set to DW_EDMA_CH_IRQ_REMOTE, but DW_EDMA_CHIP_LOCAL is also
> present in the chip flags.
> 
> Because the check in dw_edma_v0_core_write_chunk() explicitly requires that
> DW_EDMA_CHIP_LOCAL is not present, the first condition evaluates to false
> and DW_EDMA_V0_RIE is never set.

The key point is that a delegated channel is not driven by any EP-local
consumer. The EP side calls dw_edma_request_delegated_chan() only to reserve the
exact HW channel, so no local DMA engine client can take it while it is exposed
to the host. pci-epf-dma itself never submits DMA transfers on that channel.

Transfers on delegated channels are programmed by the RC-side dw-edma-pcie [1],
after the DMA register window and descriptor memory have been exposed through
the BARs. On that RC-side instance, DW_EDMA_CHIP_LOCAL is not set, so the
existing condition still sets DW_EDMA_V0_RIE.

So the EP-local channel having irq_mode == DW_EDMA_CH_IRQ_REMOTE does not mean
that the EP-local instance will call dw_edma_v0_core_write_chunk() for that
channel. It only means that the EP-local instance must not consume the
completion status if a local interrupt is unexpectedly observed.

[1] The protocol does not exclude other RC-side consumers for other vendors in
    the future. dw-edma-pcie is just the first supported consumer for the
    pci-ep-dma.h protocol.

Best regards,
Koichiro

> 
> According to the commit message, requesting a remote-only interrupt requires
> setting both LIE and RIE while masking the local interrupt. Since
> dw_edma_v0_core_start() correctly masks the local interrupt for these
> channels, does this prevent the DMA completion event from being sent
> entirely, potentially causing the remote host to wait forever?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260620170040.3756043-1-den@valinux.co.jp?part=1

