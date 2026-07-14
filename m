Return-Path: <dmaengine+bounces-12507-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jYHLLfmMVmqw8wAAu9opvQ
	(envelope-from <dmaengine+bounces-12507-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 21:24:41 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 10577758363
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 21:24:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=Hkq4qtf4;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12507-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12507-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE7623114FE1
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 19:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CF743F8BA;
	Tue, 14 Jul 2026 19:23:18 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013061.outbound.protection.outlook.com [40.107.159.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8C937B01F;
	Tue, 14 Jul 2026 19:23:16 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784056998; cv=fail; b=OXn5SQkAgCZBx0ecze277a0qe1nRHabmT73v/Jfj5ufXU43XwjQTjfODUMBpqTeJC3BmvrN13Wxu89LG4yVTHNARCED26ojwYMtfpYeargfsvMoeP6TLwZL9WzftTXZ7JIVWCsp3C5KEUA66Ui+I/jn/geEeMcfqJXhGsM/ymuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784056998; c=relaxed/simple;
	bh=/EPUCIH0kqCQ+kUUvT5NjiPUmmIrYjPvj0exnUK50Co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oFpKoZ/R8SRYaQkWRCYcfzyNNU6E6VgjbT1wm6DVFL5H5y4rBDdXmyfbGNpFnVWmAxcfSFIMZmIoqTvWvejo9An0OvXy48woN6E7wGAVk0wDRwBmR4zxchsq1RYgo631p1vEV4aYp+SRN7S0t+92LakgCxkfUBX08CH+c3ksYIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Hkq4qtf4; arc=fail smtp.client-ip=40.107.159.61
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UDH1jRXT9JZFTAo32rOtWpPwWp934oKmA3Kdabv6GGJu/nrX5svnO0JdmlPPOUz2iTwuTpckJFEt1G+ybVMJ7RZmKon9oeJ3QT6f+VREZHx7f0sKhbEaK3bCFOdTBxSSm4HoW7bkYFykeJ+q0Uz4sbtfTpyM1bkbXNuqrSVuXtWEV+G50nVDpf8yBRgX9+IHvzyIDPZ9TOuw0cTVrqspJeVs6QyFEI6NmBar4PlMy3qd4x4WDM8q4Gh6iGGpFOTe2X+bgBhrt1OpvWebhAaLWEArX1HKDkX+jaaZcegVyLOPB2Ssloxo+9yJKPDVFPzVuPggVx8Gx5+VICDcOC08Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPVhlUI8CVgCPogB0NW0LF1XuytyOkaus5aN4GDkgMA=;
 b=k8f/pfIte2yh5YzHMdnaSbzgpkJnm6VO3KX8oOsRSp+8EaCJCedHjLNh/yRStqRlSqyUKj6XZ82GScXRw9PZ76/xTqnLq2UKGIr3UOaZ3nB2HeYC2H7UK+BUeH1RwEMblMku54hATZrJVxaTJFS7opD04otXipUaZ5opqjbSyzUJDidbAPkEbTuj20qTnO/4+M3o6aycrboaX8RXVY+pjOD5iN4W5/lqdYPuH7x+EP34/rUA15JKhnlP6a25vF0t6k6A1ceGlmJD8a0f7VRQZ06DZfT5W5isy9bEe3exZhYABNr9ZrXGWanNibfIGYD2xxXek05T5eSX/Gb4VC+1qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPVhlUI8CVgCPogB0NW0LF1XuytyOkaus5aN4GDkgMA=;
 b=Hkq4qtf4wVavONRID8D+LzbbPWvl9R3CXna1cHwwca+kpaZ0sPke2S3xkUGs1rnFWsosqM1uFlFp4lTXfNJIp/k7GpdMZR/w2TjwIi/OdaQZrE1XcFEb4g1+e3CjfV9Wrof1LNdfnEhqYV6HlHFmX+4hLBoEoZzzC6tqKUia0cCh8kJxtJGmgaoUzpsZmf/RM6jg7KWNjgYt++bcqa/pXxnQIxsoMgkifOz6nR/28RAn8pSiRZsS/gEvg8O+ZnVNa3z7oBD2qT1AmQTthqVmOgPgjXLRRrrrw6d9XpbtHEZ/4pCzORg/ib1b0CLCPL92j6jax/2vZZ+KTyVlkJVaLw==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AS8PR04MB7525.eurprd04.prod.outlook.com (2603:10a6:20b:29b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.9; Tue, 14 Jul
 2026 19:23:13 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 19:23:13 +0000
Date: Tue, 14 Jul 2026 15:23:06 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 03/14] dmaengine: dw-edma: Add core quiesce operations
Message-ID: <alaMmps9Q_jg7jK-@lizhi-Precision-Tower-5810>
References: <20260710081518.2394357-1-den@valinux.co.jp>
 <20260710081518.2394357-4-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710081518.2394357-4-den@valinux.co.jp>
X-ClientProxiedBy: SN7PR04CA0204.namprd04.prod.outlook.com
 (2603:10b6:806:126::29) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AS8PR04MB7525:EE_
X-MS-Office365-Filtering-Correlation-Id: 98b2f99e-67c0-4750-b0f9-08dee1dd58ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|366016|1800799024|376014|4143699003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	Zv9h6khZFMwJar/pi56eppcg8YJ73AOcQ50vQgH6oeNjpK25YK60LQvm563lGOpPZluPZzLspWBX8WZ96HuzFRPjbrVl+lnCKz7VGflBPHt+5wRq0tSfTgwl5BIHvtJP8ZMlKDIViiuAbxSIShE7moEl+MGnShYXKV3HJkcm3Q323mCnO78nEIxSJkagEIVyS2X53ybXXmPv55ftx8oKLJjOwIGMoT9G6uCr2GxLuNGZ0cMjGsNNkx9rTQomiBg8cTHqgsNxa/led7bGiCsdkdItpAiEqMMTYeawfg2wvKWhsooUG/Ry0ll7dJ+ssN50stzasIexTEbGmDFVuyeNLEKiswWMuCPo9LSv1OU0K6fPPNdoyE0JZ7LBSQUC3irABOqzXUY4e+rF4Myi3CEzSP/CyazHuZ8NZoLvkJGSDMvnGdciQN4c21SBRk3VOd8tSvzT4JjL3RZ3Mr879ixs98GuA9No0+yEmTRwXtls+VtLETtXY61uzGbmmeYtwHznzFLEg+aOgpa3iY0x7AAOArmfYrVtC1aP3KCIR4Dm2N1MLPkYC5Ilp6xPqQU/lKN4RCZanFSrUrRihIA8JCL3lpw3+xaabmMRC9J/ANrgpUCgYMEbAJaKcpqpOvP7BPmXVtW5gUgq6dxB7Kf7UvGcvIOzPRlCbG9lxUCJdw56A3M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(366016)(1800799024)(376014)(4143699003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ul12M5siLx/QKLO0jD55cCyIqfAZZm/hESP0t/RJZQbiTDYCemfPL8h9GMTt?=
 =?us-ascii?Q?WLudmQ3OBtbzLH50aGr7uAMPolNMaK1rdTPVlOPhI65286NBXAGjkGSjTXnX?=
 =?us-ascii?Q?Ii+t25YqpzSqx7kTYbypqwR8uvuwT99ebCAUkqKhqwBPadkNBpWTePclzPCf?=
 =?us-ascii?Q?o8n/9twyGiu1wFk9KT6eGHfrTxzg07Cix285b9NXHG4sCg4iphklyA14dIML?=
 =?us-ascii?Q?m2XUJUgiePxZb67ypcMGkSP3f8HYF2y+1zCCMr4sU6FDLzh4BUnMMEaERRNj?=
 =?us-ascii?Q?tyW5SEOiRofVx9yN3kC/zgD+SbG5KBTYoqlrRexQDZiY477GhpZlhyL8Ulob?=
 =?us-ascii?Q?3VbVoOybBRKDBjl4Z0YDtaui9HyQ0z5qrkJTWkYJOqz6vAha11vWET/kqLxa?=
 =?us-ascii?Q?J279RzIX5SQ3MldXG3wMx7LeAdDmRNhSWrwU6AGUxMECVD+UOUP1sCQIf/aU?=
 =?us-ascii?Q?7lDsKWbzqHEG0dXjZfYmsfR7nVKK/6xPp5EIYkZivVmDacnQN0zPgaZ2fFvj?=
 =?us-ascii?Q?6DaoKIr8/T9GlN/lLX3CP54RPJXPQ54Yo9GZNEd5ePaJzOCnZMRDEbNI/kzG?=
 =?us-ascii?Q?fDcwJWtURnubNfog2QsmwF3TL5gKjHszR0Sp1rc63B4LVI5flm5v3vx+6XoN?=
 =?us-ascii?Q?Rio6a9YZvMiezdLYqyCb9zAZque2+7h9FM8+yeTcvKwiGSzB2Jzzqk6p3h+o?=
 =?us-ascii?Q?zKs/GVl4ftigmUGxx7wWhutCrCt0XeWeY/kQVlM0GkqAp6Sy7VRxKwckOT2/?=
 =?us-ascii?Q?6AiPHjg0FzIafdRMZeSshOYSvZHYTLrYfQMMJRhcqeQ+b0MBArnGzA0Ekazo?=
 =?us-ascii?Q?eu3fUeYjoYyYTai83X8UPPfDsDGM5yg5AkjZrVM3fJL6pKLDacjXbqbcBXys?=
 =?us-ascii?Q?93X7+/eAXwvo0dzHnFfgY05/rH6G0okQBLDup1wr4Tu1uNl+SH4IwvdJc1uS?=
 =?us-ascii?Q?zUSc90EwcypocQ+iwJLTpRLjoTQTngvlY/s8STiAd3D63O57vYCxmS0lSlC7?=
 =?us-ascii?Q?nGv3pEAD6fjftZp9O7kEel69F7IeiZpSBvWDEhk02UsZ+TJ/AasK5GQOqrmO?=
 =?us-ascii?Q?K1RfyITPF9/vEUvquWnNddDx062BEBpWP4l4QEqGm10rFHOsF9Amnj0UM2ie?=
 =?us-ascii?Q?YsEGADBsma4dhrcR0Ajo1afhxCYducjhcFQ9zpb+GPFWsTHCWJaaUXbuzAP1?=
 =?us-ascii?Q?lVsm8foyTEGzf3U2mBk4iQ7jjzsaOlEVaNX5dWxPtIVu1xzrRSbZesTcB7VB?=
 =?us-ascii?Q?JjmOAHyrH62RWbf8AGLXmnbw3xP2dihTa8hpPNRlALO4QAAGjjBhpjYparYX?=
 =?us-ascii?Q?MDNIOMCiq7aY+PCIOmaeVda8+vXGwXs5bxAlJTasiQaNYMyjwkxITSej+iN6?=
 =?us-ascii?Q?wz8RT/7sx2D0klxfu0+TtLUhqhQwg7npD7MDeSR3pNTreN75A6riTlG0wgWo?=
 =?us-ascii?Q?slkKtXmRTdXIgsLh7Frg7ZsycK7QvNmJfjrwCL73kOc2P2N1V+mwnjmMwlxM?=
 =?us-ascii?Q?spVVJ0v8JizjOEwnCXbVBZL3rRobWAeQhGx85EKzhsq2PVwh/t7c3HuSlbgW?=
 =?us-ascii?Q?iw1VOU+MDUZlxs4bgtppA2SyA3FokjieiAVAmeU+vnS3CSReIB9epSUW7eFE?=
 =?us-ascii?Q?8U7LIrdTmf01t4Ncxiy+XPXeESZ770qsIeSLT2ZaHVOn2UNJXRUX+Zdptl0l?=
 =?us-ascii?Q?5dTxlrpNbOHFJFP8YF7rlgrE1rqbF2VSTwmSfKNd5ZsvTG6wge7nEs5xhycc?=
 =?us-ascii?Q?VydUJL9CcMPs7nl38QEt5HlRuXnPBHr7wZC0b5NdNOE7ibHJASOR?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b2f99e-67c0-4750-b0f9-08dee1dd58ea
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 19:23:13.0594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jcf3qLx1D19Dyhmetergkkj9i1cj9fnMadVn5QNcElokKpsVWf+olzbyX4kQuSWDrRgFg33iyhMBxYsTZbEhnwVJeJl3XNfjTA3aFYksJ18xR0BzVYFLpeRetemwL7Jg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7525
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-12507-lists,dmaengine=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:den@valinux.co.jp,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:mani@kernel.org,m:marek.vasut+renesas@mailbox.org,m:yoshihiro.shimoda.uh@renesas.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:marek.vasut@mailbox.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.nxp.com:from_mime,nxp.com:email,lizhi-Precision-Tower-5810:mid,valinux.co.jp:email,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 10577758363

On Fri, Jul 10, 2026 at 05:15:07PM +0900, Koichiro Den wrote:
> Add core operations that quiesce only the resources represented by a
> dw-edma instance, separate from the existing full controller off path.
>
> For v0 eDMA and HDMA compatible register layouts, quiescing one channel
> must quiesce the whole direction because the enable and interrupt
> mask/clear registers are direction-wide. For HDMA native, the operation
> can quiesce the represented per-channel registers directly.
>
> No caller is added yet, so this is a no-functional-change preparation
> for delegated channel reclaim and partial-owned remove paths.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes in v4:
>   - Mask and disable v0 eDMA/HDMA channels before clearing interrupt
>     status, so quiesce drains status raised during disable and avoids
>     stale DONE/ABORT/STOP bits firing on a later re-enable.
>   - Drop R-b tag due to the change. @Frank, please take another look.
>   - Document at the v0 ch_quiesce() implementation that quiescing is
>     direction-wide and callers must own the whole direction.
>
>  drivers/dma/dw-edma/dw-edma-core.h    | 14 +++++++++++
>  drivers/dma/dw-edma/dw-edma-v0-core.c | 34 +++++++++++++++++++++++++++
>  drivers/dma/dw-edma/dw-hdma-v0-core.c | 28 ++++++++++++++++++++++
>  3 files changed, 76 insertions(+)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
> index 3ea384706b1b..8657275d2484 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.h
> +++ b/drivers/dma/dw-edma/dw-edma-core.h
> @@ -134,6 +134,8 @@ typedef void (*dw_edma_handler_t)(struct dw_edma_chan *);
>
>  struct dw_edma_core_ops {
>  	void (*off)(struct dw_edma *dw);
> +	void (*quiesce)(struct dw_edma *dw);
> +	void (*ch_quiesce)(struct dw_edma_chan *chan);
>  	u16 (*ch_count)(struct dw_edma *dw, enum dw_edma_dir dir);
>  	enum dma_status (*ch_status)(struct dw_edma_chan *chan);
>  	irqreturn_t (*handle_int)(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
> @@ -186,6 +188,18 @@ void dw_edma_core_off(struct dw_edma *dw)
>  	dw->core->off(dw);
>  }
>
> +static inline
> +void dw_edma_core_quiesce(struct dw_edma *dw)
> +{
> +	dw->core->quiesce(dw);
> +}
> +
> +static inline
> +void dw_edma_core_ch_quiesce(struct dw_edma_chan *chan)
> +{
> +	chan->dw->core->ch_quiesce(chan);
> +}
> +
>  static inline
>  u16 dw_edma_core_ch_count(struct dw_edma *dw, enum dw_edma_dir dir)
>  {
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> index 14700ac42fa8..32df5d13ba8b 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> @@ -160,6 +160,20 @@ static inline u32 readl_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
>  	readl_ch(dw, dir, ch, &(__dw_ch_regs(dw, dir, ch)->name))
>
>  /* eDMA management callbacks */
> +static void dw_edma_v0_core_dir_off(struct dw_edma *dw, enum dw_edma_dir dir)
> +{
> +	unsigned long flags;
> +
> +	raw_spin_lock_irqsave(&dw->lock, flags);
> +	SET_RW_32(dw, dir, int_mask,
> +		  EDMA_V0_DONE_INT_MASK | EDMA_V0_ABORT_INT_MASK);
> +	raw_spin_unlock_irqrestore(&dw->lock, flags);
> +
> +	SET_RW_32(dw, dir, engine_en, 0);
> +	SET_RW_32(dw, dir, int_clear,
> +		  EDMA_V0_DONE_INT_MASK | EDMA_V0_ABORT_INT_MASK);
> +}
> +
>  static void dw_edma_v0_core_off(struct dw_edma *dw)
>  {
>  	SET_BOTH_32(dw, int_mask,
> @@ -169,6 +183,24 @@ static void dw_edma_v0_core_off(struct dw_edma *dw)
>  	SET_BOTH_32(dw, engine_en, 0);
>  }
>
> +static void dw_edma_v0_core_quiesce(struct dw_edma *dw)
> +{
> +	if (dw->wr_ch_cnt)
> +		dw_edma_v0_core_dir_off(dw, EDMA_DIR_WRITE);
> +	if (dw->rd_ch_cnt)
> +		dw_edma_v0_core_dir_off(dw, EDMA_DIR_READ);
> +}
> +
> +/*
> + * The v0 register layout shares interrupt control per direction, so the
> + * whole direction is quiesced. Callers must own the direction entirely;
> + * partial ownership mode validates direction granularity for this layout.
> + */
> +static void dw_edma_v0_core_ch_quiesce(struct dw_edma_chan *chan)
> +{
> +	dw_edma_v0_core_dir_off(chan->dw, chan->dir);
> +}
> +
>  static u16 dw_edma_v0_core_ch_count(struct dw_edma *dw, enum dw_edma_dir dir)
>  {
>  	u32 num_ch;
> @@ -554,6 +586,8 @@ static resource_size_t dw_edma_v0_core_db_offset(struct dw_edma *dw)
>
>  static const struct dw_edma_core_ops dw_edma_v0_core = {
>  	.off = dw_edma_v0_core_off,
> +	.quiesce = dw_edma_v0_core_quiesce,
> +	.ch_quiesce = dw_edma_v0_core_ch_quiesce,
>  	.ch_count = dw_edma_v0_core_ch_count,
>  	.ch_status = dw_edma_v0_core_ch_status,
>  	.handle_int = dw_edma_v0_core_handle_int,
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> index cc908ca24061..be22f9f811ca 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> @@ -73,6 +73,17 @@ static u32 dw_hdma_v0_core_int_setup(struct dw_edma_chan *chan, u32 val)
>  		     HDMA_V0_LOCAL_STOP_INT_EN;
>  }
>
> +/* HDMA management callbacks */
> +static void dw_hdma_v0_core_ch_off(struct dw_edma *dw, enum dw_edma_dir dir,
> +				   u16 id)
> +{
> +	SET_CH_32(dw, dir, id, int_setup,
> +		  HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
> +	SET_CH_32(dw, dir, id, ch_en, 0);
> +	SET_CH_32(dw, dir, id, int_clear,
> +		  HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
> +}
> +
>  static void dw_hdma_v0_core_off(struct dw_edma *dw)
>  {
>  	int id;
> @@ -86,6 +97,21 @@ static void dw_hdma_v0_core_off(struct dw_edma *dw)
>  	}
>  }
>
> +static void dw_hdma_v0_core_quiesce(struct dw_edma *dw)
> +{
> +	int id;
> +
> +	for (id = 0; id < dw->wr_ch_cnt; id++)
> +		dw_hdma_v0_core_ch_off(dw, EDMA_DIR_WRITE, id);
> +	for (id = 0; id < dw->rd_ch_cnt; id++)
> +		dw_hdma_v0_core_ch_off(dw, EDMA_DIR_READ, id);
> +}
> +
> +static void dw_hdma_v0_core_ch_quiesce(struct dw_edma_chan *chan)
> +{
> +	dw_hdma_v0_core_ch_off(chan->dw, chan->dir, chan->id);
> +}
> +
>  static u16 dw_hdma_v0_core_ch_count(struct dw_edma *dw, enum dw_edma_dir dir)
>  {
>  	/*
> @@ -365,6 +391,8 @@ static resource_size_t dw_hdma_v0_core_db_offset(struct dw_edma *dw)
>
>  static const struct dw_edma_core_ops dw_hdma_v0_core = {
>  	.off = dw_hdma_v0_core_off,
> +	.quiesce = dw_hdma_v0_core_quiesce,
> +	.ch_quiesce = dw_hdma_v0_core_ch_quiesce,
>  	.ch_count = dw_hdma_v0_core_ch_count,
>  	.ch_status = dw_hdma_v0_core_ch_status,
>  	.handle_int = dw_hdma_v0_core_handle_int,
> --
> 2.51.0
>

