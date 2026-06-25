Return-Path: <dmaengine+bounces-11788-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GG0tAD1JPWpG0wgAu9opvQ
	(envelope-from <dmaengine+bounces-11788-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2026 17:29:01 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E9A6C70F7
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2026 17:29:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=mjAnPADY;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11788-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11788-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CE9030CB57F
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2026 15:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5F13E8354;
	Thu, 25 Jun 2026 15:26:14 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013044.outbound.protection.outlook.com [52.101.72.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0D13E834D;
	Thu, 25 Jun 2026 15:26:12 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782401174; cv=fail; b=Idw7ldouvPmqqnACPBG7od+zLctkfyUa4zi6p+wMj07ikoW15IHkKKnPS6H1FJHqfqEdqCT7ILAcaLwROX9jg70jyjvH+tnV7h48jxdRudKl5ECXIzut/h2ECLbA7FJwjfGQQgNX76JcfOYP63YNcb9VWeCKqU84NeqDJn6pSbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782401174; c=relaxed/simple;
	bh=+hCd7XAynNyxenodR/GbuONc478JpV8/ekgs6KG+CQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rbpHWj3026ckDXDB95TLi+m9dpgLZlRIstAcvBAtoqj/mRxwDIgqmSlO/6jjz9RNBf+mu8/Aa0FTfPDmYWYznChvml/zWWGT02XlqmdHntlLkkh51xYipCM0mYKhogjzKbEA1rl9o46R4vyZh2K79TgAuzNe/hhaAOM2GhoahbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=mjAnPADY; arc=fail smtp.client-ip=52.101.72.44
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ySsH8jy9NbEW014O+Zlxads7ue49IglBUc13DpnuFZgc6dEdezIACUYFAKkMdalf2AaYHUlPW6mBlDMYItdLP48yGLA+oqpOM4Fazf10Q+O/rEkmL8EDjRNNqdQutEtlUrN7yk0/hfVkbm+flmSvlcPwreIIeAm8fxVq1FOw7//pH8EAZbS2AYOtZmZ1ZGhdXIb1xA99nglPUhGiYTzQYyUH3EjXnQ6783b1Hv+54+2OpwGc0uqgoUhjM7Zg71hogqhOzNyRnu35mCfvlgtSdVYHmxWq+vU/TvfxwTlyHWubh1/DIRX+3rZvwCLSnDSa2FfYrcuVIqJRAh8L6/pr8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MlmPSSvHafZ5goTgWk0PblXyDfG5BvU1VKoCZ0vH/VI=;
 b=PZYwJr6uQp26bzjAnHV+deJMHnYLjff956zC4owx9tHHwwpwScVySNn8RQES31NmFYic2ap3aQCN1PW0exD0EvrcR0OlsnBVdH+zBvv11wsDkg+8U9laOEucm1z+cGCx0VtfBliGJcARxA9gmk05ODpg+TcDywHqQ+YroimPaO/nYXx1oqqyQkSRMxSu+sIDqOxzeJTvc1+pr4oOpOS7mpHGbeonrU0i9MnrixkU5fpCkQd+TRTRsfEooW0Jp0/ln909gjZm45tTYsFROs33axSeucQ+RR4h8NqJivgJGZ4ZvQsbMsJK5mZIZiE2QNUwaIYkmXoHPNg9AXC5j87c2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MlmPSSvHafZ5goTgWk0PblXyDfG5BvU1VKoCZ0vH/VI=;
 b=mjAnPADYiOg3o4cbl+Vr/P/vSau3X6Y1EB/c732vgRDhunKd92umWPgCGgcfET0pbwu/aFUYkrflABhoEhLv+wl3oLCMXzKIBkh6JXN7EAfyUnNrH/4rdaRp4Hl0Mn08fZtLQeLoJmN23wpcihLQA7TNLmbvoFqb5dV6a0tT/4CiVjnQ3HfeplGgWemhmpyfuT6YlScYKZUnIXpMMLlYS7pkke7JeltQzMtAbn61Ibv2sZz3lqq2bthqCrCrjVqdMT+80lEqKWd3AIsOiILSF0Mp4x12tFIp7fg2x1uxgva2jo1JZOqdc7f3gXxbN6PKrlwk/PxsWmRJRDAEjxE7gg==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DBBPR04MB7753.eurprd04.prod.outlook.com (2603:10a6:10:1e1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 15:26:08 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Thu, 25 Jun 2026
 15:26:08 +0000
Date: Thu, 25 Jun 2026 11:26:02 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Cc: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>,
	Angelo Dureghello <angelo@sysam.it>, Frank Li <Frank.Li@kernel.org>,
	imx@lists.linux.dev, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] dmaengine: mcf-edma: Use devm for per-channel IRQ
 registration
Message-ID: <aj1IimtQSmo9VNhQ@lizhi-Precision-Tower-5810>
References: <20260625-b4-edma-dmaengine-v3-0-44be00ace37d@yoseli.org>
 <20260625-b4-edma-dmaengine-v3-5-44be00ace37d@yoseli.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625-b4-edma-dmaengine-v3-5-44be00ace37d@yoseli.org>
X-ClientProxiedBy: SA1P222CA0193.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::10) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DBBPR04MB7753:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d733847-c0d0-4c50-f132-08ded2ce1499
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|23010399003|18002099003|22082099003|6133799003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	/Lg0sb+NmnnG5q8AB2CDjseAn1Ocz26JmezN1c8G2fyHephjXDLPZNAapXZHxc6JeUT9a5Uo7YzJGQMzV20Go0WvZlLuB8Z2PFqYFJmB1uLLSYbDTUCoY7DNorCeVD+i3vL4oa9nVUroNyndwLztUqqyMF+9ntP8hF+4/qRi6K5otVECK//wlQqMp8dx17VnlrXyv0ZVGbl4NyK4PJpP3DOdGZB8tv5x8T5cLWvV8uQCMUfHI6lirMpnLRiD+T47diLan3rkoB3OQt4ZsZwOkYV07IjZK5ur28AWwEZ8jwHzVv+9ZvZDqcp3Z4U9RlGwUvkLwLxaFjGxepkVjFaEtNmpKU1t6QWSY0XQ5V4pF36/Q3cgpKrYPASyHPgb2gySsjOWfdeVBvEf6kHgkfy7SdblBruxUHaF+8w8ijlxaRH/uB29DpBYyCf6mxUdBK0TaS/tQfOJcVSciXFRTHbsdcFE2M6hB4Fsg5MZmuWy/OxmVMcALoU/+LvPw9YFfcugpL6J8jtd48KM/lgmwrmmLbYgV9YPBO4agqDeo5wYXL9VIFwGbO3GFmCe8ZAeCuL71FwZtJwKWU8Vd3c1sBLnvqAV/XyJzjDUlE/L0yZVHn+CaR9HSoGLKL8B8/4uRkcfhq3Z+aYnQQLl4ybs1C8CVRT1Br1azk1odG28+funMnU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(23010399003)(18002099003)(22082099003)(6133799003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YD0VVjtANKf0ONcIoe73NcnC4T6iqSVloWh2jtl53wHqvr+buKn4HKcckzbE?=
 =?us-ascii?Q?1XKVYXdy5MRDuoA4qzyooSE++rQ3F2w5koD8/QdGK+Q06jhCQxvFJVMJOVxL?=
 =?us-ascii?Q?5OtT2PPVo6EvgJuBph4ME0Dshl7YiqWYDW2bksAA1tZJMrzI64kTGTGiHzCL?=
 =?us-ascii?Q?tfMJaWtoMl3HSgEMScNWHzfk6nqewGvgKOq0yBa2lYQNxk7YgqCH4HcksNVd?=
 =?us-ascii?Q?RSug9v2GztOXEwoaWaBe2R47m4u93kdKL7L9WgwIqGnRZpuppl6LINxzilVz?=
 =?us-ascii?Q?K2aXZsZ7myQggFZ73TPZCYwYI6sYacdoKSwhmhzwEYqNLyt6IxFXbDIrYG7w?=
 =?us-ascii?Q?BvGn7x4r1dUu/PejXYn+XfUNqNLkUWeNMUJI9EWcWWzW3yoz2pD23e0s/4Gm?=
 =?us-ascii?Q?nb2rd7Bq2ubp5heDzqWAq5fz2dD+Hd9ll8z+L6dJfeNePG6USW5vp88AEz2J?=
 =?us-ascii?Q?QRlRHqe3lT8wysLsisJ5BQJ2Y2RTL9vOURsG1dW9gaX76HN1lZzk1SNltIay?=
 =?us-ascii?Q?V/8W/KnBTUih8N7cpbR2GHFMvC1/LQzC82aYgHFTotF8Cu63ii+qbt2Z/y4N?=
 =?us-ascii?Q?j4uwa4Nh/dsceFhYtaInDi2jXqgAib5tQqZGhLOTNpWNXYcBlTgzOKxRn8nK?=
 =?us-ascii?Q?MKpsjvAxceoWqwtQ11QUBB+v3UJM36r/9TM/TOyhDL3LOMJS5Pr7iT8mtqhV?=
 =?us-ascii?Q?oi5qlcyBN2GYt9t+PSJbWeZJqKKf5oN4+BVzRTtJGacMvAZuskjfvpm9nO+N?=
 =?us-ascii?Q?8tXLpaTa9cNXXDBPfQ6LIT4XRSzd+jHi5yYH6sz2dTl/j2shm1lswTsysqmF?=
 =?us-ascii?Q?1lNOjZTyWHxXWW7nGqqqmtLsojGg9201U2kkauY+X3EO09MwMk8pKb+jkUq1?=
 =?us-ascii?Q?uhdof7IRU1hJc4bi+IiKC1BR2O2ZSnoqBZ6Prc9uT2yg0Da1M8Z3WQOE/1AP?=
 =?us-ascii?Q?lcFBtnv0EJ7UeVHwaJcaAUHSvo/QJI2JYnlRxH0pojSWQgi/5rYy/RnrhmZI?=
 =?us-ascii?Q?+oijvGpPM6nO8d7IkpHHb7tD9H8eFF+mJyh/oj1VBjEQTj9d0y8whg1H4kI/?=
 =?us-ascii?Q?McqvZKdGkhI6eRoC/7m5QQDJwDm6Jay10KjrtAMRZXhbtJMoxq1Q8KUlVK0z?=
 =?us-ascii?Q?GGS4Lc5GI7wKaz2fMiy9liS/fSxf0plgO17js+cTKmu/wF2+A8DFiu5aJJSn?=
 =?us-ascii?Q?OGFCEo+v/Pg/G98ujdFBKVfSEZQFOtBmUTtYGGi0sZEikxULKQPGHQ1cGvX3?=
 =?us-ascii?Q?xCx1ti6U6GTGAFfQ3NQ7BjhCIvj95kAWKnoaWz/Wn07a7hhqOycZK9Zeq4YD?=
 =?us-ascii?Q?meKB8J4xkumquNJR3Nlq/BJQawengVyYi1IC+T7Cj+t2ROi9zB25DSO1P6R2?=
 =?us-ascii?Q?Q6LKgEqQT1MoAeihpBMTOpK1Wj2H54r2OwcKoIANCMuVCbCZNw7iHN+1p/fE?=
 =?us-ascii?Q?X5ODsZq5wbEwQRR4UQ/iaJrbOITBr7a0RRRksrSCQchF5/pUSXIAttgdy/mO?=
 =?us-ascii?Q?QCUZfKt9yKT+iZWInMv6U2pIgF87PhH/Oh2TM2b2iQDpgkHBW6eRvg+U4HgH?=
 =?us-ascii?Q?8wpopjHIm9X1lMH5Qi/ElvUufZjWWZ4EBpKi1d+43dtvE+LA4jmXOLiDtHOd?=
 =?us-ascii?Q?vF5rQ+b3Vgnpnb5yCH4gRW7EKWzXfaPQo8uy+Bokk/faEHqhA4wI58PURsn1?=
 =?us-ascii?Q?JnvE3OHmCPf2YP7SMvZRaZ8CxIfWWzAkrmRmBrQPpiiPEHamvZ/YuGqAGsg4?=
 =?us-ascii?Q?Nju52oQffMBZ1TJ3x22CMv2VDtCVdyAjHrO9OBwtY7ugII/VYL8T?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d733847-c0d0-4c50-f132-08ded2ce1499
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 15:26:08.6842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TKFxF8OHkb19sa5MvJ6O2AhX9A49MNgnxyv2fCmGla95Ud39V0o4SBapQ1FQ7l4qssmE/APzcZqPuefzBAOWt80lPuEeNyI40rx7qbp4c/AxvEkBidwrS0RevIvtKQOP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7753
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11788-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jeanmichel.hautbois@yoseli.org,m:Frank.Li@nxp.com,m:vkoul@kernel.org,m:angelo@sysam.it,m:Frank.Li@kernel.org,m:imx@lists.linux.dev,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 59E9A6C70F7

On Thu, Jun 25, 2026 at 10:59:41AM +0200, Jean-Michel Hautbois wrote:
> Register each eDMA transfer interrupt with a per-channel name
> ("eDMA-<n>") so /proc/interrupts and debugging tools can identify the
> channel behind each line, and switch the whole IRQ setup to
> devm_request_irq().
>
> Using the managed API lets devres release the handlers on probe
> failure or device removal, which removes the manual mcf_edma_irq_free()
> teardown and the IRQ leak / dangling irqaction that the previous error
> paths left behind. The devm_kasprintf() result is now checked for NULL
> before being used as the IRQ name.
>
> Because devres only frees the handlers after mcf_edma_remove() returns,
> the controller must be quiesced at the start of remove(): disable every
> channel's request and acknowledge any pending interrupt before tearing
> down the virtual channels. Otherwise an interrupt could fire into a
> partially torn-down state while the handlers are still registered.
>
> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/mcf-edma-main.c | 84 ++++++++++++++++++++++-----------------------
>  1 file changed, 41 insertions(+), 43 deletions(-)
>
> diff --git a/drivers/dma/mcf-edma-main.c b/drivers/dma/mcf-edma-main.c
> index 3dab5d475d1b..119d49c829fb 100644
> --- a/drivers/dma/mcf-edma-main.c
> +++ b/drivers/dma/mcf-edma-main.c
> @@ -66,7 +66,7 @@ static irqreturn_t mcf_edma_err_handler(int irq, void *dev_id)
>  static int mcf_edma_irq_init(struct platform_device *pdev,
>  				struct fsl_edma_engine *mcf_edma)
>  {
> -	int ret = 0, i;
> +	int ret, i, chan = 0;
>  	struct resource *res;
>
>  	res = platform_get_resource_byname(pdev,
> @@ -74,33 +74,47 @@ static int mcf_edma_irq_init(struct platform_device *pdev,
>  	if (!res)
>  		return -1;
>
> -	for (ret = 0, i = res->start; i <= res->end; ++i)
> -		ret |= request_irq(i, mcf_edma_tx_handler, 0, "eDMA", mcf_edma);
> -	if (ret)
> -		return ret;
> +	for (i = res->start; i <= res->end; ++i) {
> +		char *irq_name;
> +
> +		irq_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "eDMA-%d", chan++);
> +		if (!irq_name)
> +			return -ENOMEM;
> +		ret = devm_request_irq(&pdev->dev, i, mcf_edma_tx_handler, 0,
> +				       irq_name, mcf_edma);
> +		if (ret)
> +			return ret;
> +	}
>
>  	res = platform_get_resource_byname(pdev,
>  			IORESOURCE_IRQ, "edma-tx-16-55");
>  	if (!res)
>  		return -1;
>
> -	for (ret = 0, i = res->start; i <= res->end; ++i)
> -		ret |= request_irq(i, mcf_edma_tx_handler, 0, "eDMA", mcf_edma);
> -	if (ret)
> -		return ret;
> +	for (i = res->start; i <= res->end; ++i) {
> +		char *irq_name;
> +
> +		irq_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "eDMA-%d", chan++);
> +		if (!irq_name)
> +			return -ENOMEM;
> +		ret = devm_request_irq(&pdev->dev, i, mcf_edma_tx_handler, 0,
> +				       irq_name, mcf_edma);
> +		if (ret)
> +			return ret;
> +	}
>
>  	ret = platform_get_irq_byname(pdev, "edma-tx-56-63");
>  	if (ret != -ENXIO) {
> -		ret = request_irq(ret, mcf_edma_tx_handler,
> -				  0, "eDMA", mcf_edma);
> +		ret = devm_request_irq(&pdev->dev, ret, mcf_edma_tx_handler, 0,
> +				       "eDMA-tx-56-63", mcf_edma);
>  		if (ret)
>  			return ret;
>  	}
>
>  	ret = platform_get_irq_byname(pdev, "edma-err");
>  	if (ret != -ENXIO) {
> -		ret = request_irq(ret, mcf_edma_err_handler,
> -				  0, "eDMA", mcf_edma);
> +		ret = devm_request_irq(&pdev->dev, ret, mcf_edma_err_handler, 0,
> +				       "eDMA-err", mcf_edma);
>  		if (ret)
>  			return ret;
>  	}
> @@ -108,35 +122,6 @@ static int mcf_edma_irq_init(struct platform_device *pdev,
>  	return 0;
>  }
>
> -static void mcf_edma_irq_free(struct platform_device *pdev,
> -				struct fsl_edma_engine *mcf_edma)
> -{
> -	int irq;
> -	struct resource *res;
> -
> -	res = platform_get_resource_byname(pdev,
> -			IORESOURCE_IRQ, "edma-tx-00-15");
> -	if (res) {
> -		for (irq = res->start; irq <= res->end; irq++)
> -			free_irq(irq, mcf_edma);
> -	}
> -
> -	res = platform_get_resource_byname(pdev,
> -			IORESOURCE_IRQ, "edma-tx-16-55");
> -	if (res) {
> -		for (irq = res->start; irq <= res->end; irq++)
> -			free_irq(irq, mcf_edma);
> -	}
> -
> -	irq = platform_get_irq_byname(pdev, "edma-tx-56-63");
> -	if (irq != -ENXIO)
> -		free_irq(irq, mcf_edma);
> -
> -	irq = platform_get_irq_byname(pdev, "edma-err");
> -	if (irq != -ENXIO)
> -		free_irq(irq, mcf_edma);
> -}
> -
>  static struct fsl_edma_drvdata mcf_data = {
>  	.flags = FSL_EDMA_DRV_EDMA64 | FSL_EDMA_DRV_MCF,
>  	.setup_irq = mcf_edma_irq_init,
> @@ -249,8 +234,21 @@ static int mcf_edma_probe(struct platform_device *pdev)
>  static void mcf_edma_remove(struct platform_device *pdev)
>  {
>  	struct fsl_edma_engine *mcf_edma = platform_get_drvdata(pdev);
> +	struct edma_regs *regs = &mcf_edma->regs;
> +	int i;
> +
> +	/*
> +	 * The per-channel interrupts are requested with devm and are only
> +	 * freed after this function returns.  Quiesce the controller first so
> +	 * that no interrupt can fire while the virtual channels are torn down:
> +	 * disable every channel's request and acknowledge any pending
> +	 * interrupt.
> +	 */
> +	for (i = 0; i < mcf_edma->n_chans; i++)
> +		fsl_edma_disable_request(&mcf_edma->chans[i]);
> +	iowrite32(~0, regs->inth);
> +	iowrite32(~0, regs->intl);
>
> -	mcf_edma_irq_free(pdev, mcf_edma);
>  	fsl_edma_cleanup_vchan(&mcf_edma->dma_dev);
>  	dma_async_device_unregister(&mcf_edma->dma_dev);
>  }
>
> --
> 2.39.5
>

