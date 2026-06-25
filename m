Return-Path: <dmaengine+bounces-11789-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0R7vEfJJPWpv0wgAu9opvQ
	(envelope-from <dmaengine+bounces-11789-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2026 17:32:02 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A036C714C
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2026 17:32:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=ib4Irpck;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11789-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-11789-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 900183013C40
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2026 15:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82359233951;
	Thu, 25 Jun 2026 15:31:08 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010011.outbound.protection.outlook.com [52.101.84.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4D826B0A9;
	Thu, 25 Jun 2026 15:31:06 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782401468; cv=fail; b=WHnyEh6nsajUjQYVOnLvBndl32yEQ+Nls21ltBN19Hizgr4K2RRhnw1UYWBqvCrizmcI9NbHuQbvsuTpR8V1Lo8Xbmpx0d68lTj68SIoO5xsVU+4j1KZvyR1GBl8N0GxKgsb/IgpI7V0cTpAsdD/l6V142NUtSkjpZ1AsIuhn7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782401468; c=relaxed/simple;
	bh=CHCCPNor1FH9ZyiedGsbOiam/tvAoBjdem0LnLMje18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pPjhFQ4VZmIE9cCVKZbIGwX/J4awEd4wmGAv20+jU3VqA4Uebm0BHDRkCUVSyplKGWLCH4j++fHjYAot/XrEBJWPDGeLD195bItepW/AQDeIokzS+MlxdhDaoPWLNxk98FHOogrIoe80Z28SV0cZMuzH1BqL5cfn4ivvmdDllNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ib4Irpck; arc=fail smtp.client-ip=52.101.84.11
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mwpqxGsBCoHPHmfnudV/3ZUyaeJ96leDSnF82qI4M68iZP591/TG+3qvA1vHfzFVFOkLS7rYdV/WJRwl0QvLNqtomx8HLkbhpXyTI4lNhdL0pzPmyvsls6OnV+KknzUQLmN4G1IoyoFOtqWP6fE65OetdIXfYFkZQzGtX+yXMG3MUfCT51nhnlEu8WlLipdAlEO2sqEqpSyG6r8v9+fN65tQqB102QJjxVQQzu5d7+u3m0nL6ABHtr4DRjgCh04OqbCk/GTaeZCHJd7T27ky1pXbyVpelFcgvbVMmIEtUxoGiW34AgXDQpd/Lfo1BGdAr2rpl5M0aIml36SZVaU2lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qC6x+Aqft9WVRSCQNF1CFjXkd20lvXxwx8hxFa1PTl8=;
 b=Hlxoqq9YEDRVPoMSNB7qy+RRMvh05ZjqDmVJLABiDt/9FMdNIYnbsgFV5RCrXIwUDlK4GsJmlO25LYV1RtuVeJXo/IxOOA061OaAu6lnmjM4vGh7+9iVOjGlIYl3a6ngvmdVpYZgpnTcljd/ckJN/OQZtR6prZbDy5W9D2swqYDUMnObYkTVIdOTMp2Uat9OS8EUU53IcJQ8We5VMfoTEYitfXTHNm+wNhw2V10+LFofXVTOvf3rzJ7J6rSRCYq13UyMIcQLM+VHh3Qc5F8UYUPP1tOB46fNJY/iPFR1Oh8egsDyAyLr+BLlDtQfsEYeZm6Q4YhrssGqkJ37AT2jlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qC6x+Aqft9WVRSCQNF1CFjXkd20lvXxwx8hxFa1PTl8=;
 b=ib4IrpckQR5RIvl5oV3niFbNHO3h5hw56T5IKOq3BJsMhy2rb2/pGRItygABCuHYVMzz9It/eUIe34bK/HNje8zkGCDeCN4CxTcs3bNXQHgxT73w3vz8Xz49/g4tOj7arGTrNchYde20z0FO0cGCxS8+9YPexoYsESQPcw/PxyiolF46dZSFDBG6k6O2jhyW9GTnHngFEpyafvnDXbywccGTPJFavl/KeXjQAANa1qIC/xmPOydyqtMAvRgFT9MXGOkFqxJQM+9lBKqTWFDQ6k/Cya8WEOQNK8romnBuhcwDsiGh7EBSsL9Va/nJiAL43VZkYqrNBi7fXmYUW1B74g==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AS8PR04MB8594.eurprd04.prod.outlook.com (2603:10a6:20b:425::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Thu, 25 Jun
 2026 15:31:04 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Thu, 25 Jun 2026
 15:31:04 +0000
Date: Thu, 25 Jun 2026 11:30:54 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Cc: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>,
	Angelo Dureghello <angelo@sysam.it>, Frank Li <Frank.Li@kernel.org>,
	imx@lists.linux.dev, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] dmaengine: mcf-edma: Fix interrupt handler for 64
 DMA channels
Message-ID: <aj1JrufD1vIZH06s@lizhi-Precision-Tower-5810>
References: <20260625-b4-edma-dmaengine-v3-0-44be00ace37d@yoseli.org>
 <20260625-b4-edma-dmaengine-v3-3-44be00ace37d@yoseli.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625-b4-edma-dmaengine-v3-3-44be00ace37d@yoseli.org>
X-ClientProxiedBy: PH7PR13CA0006.namprd13.prod.outlook.com
 (2603:10b6:510:174::19) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AS8PR04MB8594:EE_
X-MS-Office365-Filtering-Correlation-Id: a6e1df5a-4ee1-45ee-5855-08ded2cec494
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|19092799006|23010399003|1800799024|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	h/ZvNdJBifc3DQCk4O7wgt5nKk8gjUqubyi8zuQHkWZaP/KqKbnu+NgtZwkH8YOw1sGY54dHZr8mVpXKUwl/p2wsIsg+0J+89fXVIwhhvv6Oj94h9d75sJMAJjyGavMaa1H20oaG3Sjy3DBL4MFzpqLK6Kuil9NQqgKCvq15dK7vyYWHM43EModtSbAWj/NsqtLVTfRxlvVBYfW/cvepdQ+9t4/ecQ0cWx6pB/OjjGl8EUeE1B/AEwYz/dkU1luJzK6WsHtrMlJQYRRuUHWlCvyuJ2B2vuLaT+nXlN6Ebb3qw25mOLb0YBX57FAKiQuGD7vfiZV/COTevzef7aEaWQCxVMY2B9v177Ufsy3FA+pyEhpy0oeh8ofSfXNfHozefzzX2qOgazFWqy95eOX/Hx5DjLMb5YG26mXrDCwHEpRq+xn284bB8+J7632i3wSAKctavXTeoA8+CaJPL9JsoRZbA9glcwtXkB3L42fmzxPaK1EWbYvYc2eEGOOwxsdnDJzVPFnNM0C+SFPATE4Zfg1wsjfNsnWEQ4L67jxn1VN+d+x9ImxZNPQJjGccizEpjzkehsgAsQIKDp30gGVoWcVF1QjrymI+aLofvhRsty66lWpSNESA3dy21yWpvg4D7CfmT2nhSuukOc0apuk957vbmI7hDZAYwaqWtHXaIF4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(23010399003)(1800799024)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VA1K+IySKjIFNjlJFskn0vquzPmbf5YfOOEKISQRyoGcjKzdoIuqniiFuNCR?=
 =?us-ascii?Q?5Aw3xbf909Izlwfrl7UXfVgNLEk1uwtsPqt70yHvhkQZCPfs9nfEvmTZrciE?=
 =?us-ascii?Q?1EfR4dE5WogJM4ssJjh8fRA/i8XQz9EhqLhdAJ38wcCGGw6tEv4sQVpN9hGy?=
 =?us-ascii?Q?b/SgwTPrW3/roEdNjM84vJDJsBPG5UomGKhg/ukQyOWBxjUBpAQGL7d3Czhu?=
 =?us-ascii?Q?8zETakqeybELUJO9dxXuB48Ii2W8RN0yNRHWL2Lmy8kHZ7rApQ+nUTd7g300?=
 =?us-ascii?Q?gL0p/X/eEu6OpGb+pJj9DSYKPmZd7cb3Y4/qspP6JdyBUjI9AX/Mllle+/vw?=
 =?us-ascii?Q?N4XmqefGOLgiAeC/5yMjCjYdqFRXAT3IorJcSu6qhxU0lvPn14sNXF66qm2H?=
 =?us-ascii?Q?Yu8aRmCBPl37cUi9BkwgZi3M6xAcZ5O/jLUSchQpY5YxMxFvpJENi1qHm1Ax?=
 =?us-ascii?Q?rjKGQ5ZA7QLtCCA6GjK8aiFDkhU733lwlLIBYzAeS+hSYEyBca7AIAUFmHta?=
 =?us-ascii?Q?e75JTyLmZFMcS0JyQumhgqntYGO9npNJvDmeCJRdWf//1HecdIFXLhKe6Eqg?=
 =?us-ascii?Q?MxR51SgDPD83x42v9PO4IgLmmb+0uGB8li+8n2vnlpNXOTqu3UaWbqbHk/e9?=
 =?us-ascii?Q?xP3Y4zcJvwxdY7rbXNaEvEIFU6LiHP717w9Iim77a+3b3XzW8UfvWWItbSFD?=
 =?us-ascii?Q?S/BoyDq2MiYnMstDy9xdM7bAZ7bCxQa52h5gG4Nvnd7vAUS2kHpS6I6U3U7m?=
 =?us-ascii?Q?7hud4eoGr2GG1S/Y9Ouu+efQtJQD8uyTt1VzqA3CxgqCdQSlLTRqcP6jNIJN?=
 =?us-ascii?Q?E4lhRwVFuT4UgH21Pt0rPCojBeoHoW0d9nHlFQ5mAWzPvjNU4spDXBupL0Rd?=
 =?us-ascii?Q?hjtRhTNNyGt1MP6EXqtDg/+b11KJGjLQuj9YBcYKEHLU1jdybk2Xn1UJK8iA?=
 =?us-ascii?Q?u4Nq9tlSTnhNNTHF9JErm9rme+dAzfBkBWtMzgsr65wkCZbw04QqiOra1o43?=
 =?us-ascii?Q?bS3ZoAocRfkoWTdqmYbMNefJoIeimaeD/t87ixj/pc2b7wgYf3IejRN3GLS3?=
 =?us-ascii?Q?KwW67hwlTfzregy02DYVeRWh0f3p2kfr+8PWrRM1LJg1bpEulfHXaBnI/9zz?=
 =?us-ascii?Q?ONpF0W+KQ0nIHSmjrKBnZvyMPiD8S6L+uaCPQ21EpRQ1Zi85+ULhpIlAsEyD?=
 =?us-ascii?Q?2Rz2K0FAXYx8XvRSIFhYsNrTyjRMgbtPvNvuSTY3mIjsyh//IJd4oJ5NUpu5?=
 =?us-ascii?Q?cHKP6Ctp7EmWjHZRplSPnGVoMpeGigvCxxfgQzCPVclviFjE1aI5SxCnhwTi?=
 =?us-ascii?Q?x0P3saFLklic+x3i4aljc3jOEJ7hsq0Z2pHBFNMEyULjjIPmc3a3gBCk3SUl?=
 =?us-ascii?Q?77gWAxGJGEIwL1wsbmKw+Ujl4WUfTw2hv+gZsXWD6EM/4axszW016QHT3gPd?=
 =?us-ascii?Q?T9RkFzfkO2vEqax2wejJxqyYHPzUjKQItYAbGsNGk55pu8Mcs1mjSWZiu/7J?=
 =?us-ascii?Q?ry895uZxApBuhUrD0DVXQqjhq9N5GJCwcqhcX2AYMDVP9e/nUWfGmuc95CnY?=
 =?us-ascii?Q?oOD7UaUr+afIQuYPURlgwgWkbruqSZQ1jKIEvI8XWuuh+Hmt1lnKkpVSfMJF?=
 =?us-ascii?Q?fSIfwlYqCkHVGZMEt9PcRrkqJQtfCk+JhVAARU68JmITX07GJJ/IJoBQhhzq?=
 =?us-ascii?Q?sMG2CQhZWh+5XIiKN0PZ+UbXLfhpdVvR/X4XiTL21r2zLPrgMoKoKHP5s0ZQ?=
 =?us-ascii?Q?8nsmW2cMZWlEX0graIsYfXXjYkvE4IbFmsK9R5AVpsyJKjXeRZP4?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6e1df5a-4ee1-45ee-5855-08ded2cec494
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 15:31:04.0520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hLiMrsIHyURt2yrV5D4ZYGcmz6Nr07NeA/8Bid89qTwRWMo9ApMdGSmOnqd8lJgpIzdhdi+LmLcWRfjoQFDOM+Il0vvHrhATb0grr/uhxx9Q+h7/BQtcuEXkNdJPq6dB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8594
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11789-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jeanmichel.hautbois@yoseli.org,m:Frank.Li@nxp.com,m:vkoul@kernel.org,m:angelo@sysam.it,m:Frank.Li@kernel.org,m:imx@lists.linux.dev,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.nxp.com:from_mime,yoseli.org:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,nxp.com:email,lizhi-Precision-Tower-5810:mid,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 44A036C714C

On Thu, Jun 25, 2026 at 10:59:39AM +0200, Jean-Michel Hautbois wrote:
> Fix the DMA completion interrupt handler to properly handle all 64
> channels on MCF54418 ColdFire processors.
>
> The previous code used BIT(ch) to test interrupt status bits, which
> causes undefined behavior on 32-bit architectures when ch >= 32 because
> unsigned long is 32 bits and the shift would exceed the type width.
>
> Replace with bitmap_from_u64() and for_each_set_bit() which correctly
> handle 64-bit values on 32-bit systems by using a proper bitmap
> representation.
>
> Fixes: e7a3ff92eaf1 ("dmaengine: fsl-edma: add ColdFire mcf5441x edma support")
> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/mcf-edma-main.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/dma/mcf-edma-main.c b/drivers/dma/mcf-edma-main.c
> index f95114829d80..953b20f99f25 100644
> --- a/drivers/dma/mcf-edma-main.c
> +++ b/drivers/dma/mcf-edma-main.c
> @@ -18,7 +18,8 @@ static irqreturn_t mcf_edma_tx_handler(int irq, void *dev_id)
>  {
>  	struct fsl_edma_engine *mcf_edma = dev_id;
>  	struct edma_regs *regs = &mcf_edma->regs;
> -	unsigned int ch;
> +	unsigned long ch;
> +	DECLARE_BITMAP(status_mask, 64);
>  	u64 intmap;
>
>  	intmap = ioread32(regs->inth);
> @@ -27,11 +28,11 @@ static irqreturn_t mcf_edma_tx_handler(int irq, void *dev_id)
>  	if (!intmap)
>  		return IRQ_NONE;
>
> -	for (ch = 0; ch < mcf_edma->n_chans; ch++) {
> -		if (intmap & BIT(ch)) {
> -			iowrite8(EDMA_MASK_CH(ch), regs->cint);
> -			fsl_edma_tx_chan_handler(&mcf_edma->chans[ch]);
> -		}
> +	bitmap_from_u64(status_mask, intmap);
> +
> +	for_each_set_bit(ch, status_mask, mcf_edma->n_chans) {
> +		iowrite8(EDMA_MASK_CH(ch), regs->cint);
> +		fsl_edma_tx_chan_handler(&mcf_edma->chans[ch]);
>  	}
>
>  	return IRQ_HANDLED;
>
> --
> 2.39.5
>

