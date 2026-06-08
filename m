Return-Path: <dmaengine+bounces-11334-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cg2ONKL9Jmo9pQIAu9opvQ
	(envelope-from <dmaengine+bounces-11334-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 19:36:34 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8CA6594F7
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 19:36:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=uDmyXUJU;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11334-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11334-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9997D30AFE0D
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jun 2026 16:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366E333E360;
	Mon,  8 Jun 2026 16:22:10 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013057.outbound.protection.outlook.com [40.107.162.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B45346781;
	Mon,  8 Jun 2026 16:22:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780935730; cv=fail; b=FYaTY2E7DqSv7kZQOn1chohaTCEK75OGEO1EMkPKh2twVrms/tYYLwAqkSayPaRGqhhctjE857lua0/59cns4x2CUTJFq4imhxly9dYk94xTSav9lE9/h6Ff1w0S34X5MV99quuVPUdbyDqiRwxUARlp5PN+hLc2EYrNvRyiRD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780935730; c=relaxed/simple;
	bh=6yHPqAWrllX9JzFozglXCeXRKLmBra7+AViI5UT5Rgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Sj03NygHpxsryzvqp8jmlOQs+Z7rebmQnMBMWL/oXqs/xFKjCEqK5mmwb1M/FA7XF2OcUytHxCCDKI8xDT1IBAUbVEfgDjzIgzNBE8ltAjYjiND4blAfKeyi1FH+pvZyfki5s1vUxTd7UNXBliI+NIlZZbxAw8oNtFh2j+pyKmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=uDmyXUJU; arc=fail smtp.client-ip=40.107.162.57
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VU7MY8VffeCQc+K2h61U86UUsf1aUL+BxJJAMhvJNCn99NOdjJ8+airTRj8JiPM9AYlo2VEOiDxiAFx7r+u/oIoi3C0tuc0YLvlSCdMIGgaFkZLZWrzcTSpXTSbhYClF7+bt4US/t4qZnT0AUBdAKNzN0IO25QWbf20RNiRTFXzTRlAgaesZnZ/ivDDJN3aUv+IjKfaLgcdHbjOtkrUl8aufnuAlRIegweMKfzcdSyPED8FCpZII7ShgZYLd2LEfqTqGEl/PYYmTneYZidau95Fd7rrpjv+IhbonRWChYCS2/1nLQUPCp3GN96y4XV+0RQt/VIcYqgUjzTC0H09JBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NdzUs63C3MRmJ1RdV8f6qTrxa17TDcYqNwhfIwKzzg8=;
 b=zP1QvQm1Ru5pOcvSkwYwLRcL7on4BD8lzC1kXsw7ku3eDWuVKa6+V+m6VuA1HktImTlac9hL1fQj/kW7hBGmDBWQgbW/InMGK3zOU853J3jo0eNJjAya4o6t5lZqb37xzBT+dfoQpDubFPExSYtmRvGea+A4rOruDvTGx1wxUc4uPo5ERgP/DH8ijvZwD40j3gxveFmL0w/sRG8SYTc+fG2A8UhGApcVVk0qhmDIWJI6z2V1BXUuw1YjOgnOLOy96UNDVPVZzh+JIYDf7ICQoPbEZxENDOtwqaS0Fkf5MFYCNuKR9+3CpgVHPxKHDh6wAreDqTXl6UFvv9/UUDZ1rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NdzUs63C3MRmJ1RdV8f6qTrxa17TDcYqNwhfIwKzzg8=;
 b=uDmyXUJUaM+lJf36Z/p8yew30/DDSJjgmnbvDxYS86L7KYMILn9rcaBQHnbu16DUj8tXSQu7IDHuGtYcAWeJ/ei4pTHjfOGRFI6gChQAc1FFsb7CP9xPmD8jXEsMvOYuMNpi+VuYZXUx1aGH0Gp6JlYqK3wc+VDg3VG0nqFzFIOwrpFk1p6tck/tvySK6GlpyN24XL6VPf+b8tpQqKQcZTxDn6VnOOUsu0O8Pbpr0J1igze3vv0vPspNKn82sNQBSvoLTrWgjP3QDFjqN5YzXGfkYZn8mCCJg6cT6olcXPH6RRxIKP+HJZniWLdnoRAmdlANM+dkh326jzY5deG9cw==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 16:22:02 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 16:22:02 +0000
Date: Mon, 8 Jun 2026 11:21:52 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dma: fsl_raid: replace in_be32/out_be32 with
 ioread32be/iowrite32be
Message-ID: <aibsIGngwuzreZIH@SMW015318>
References: <20260608053441.12238-1-rosenp@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608053441.12238-1-rosenp@gmail.com>
X-ClientProxiedBy: PH5P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:34a::6) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GVXPR04MB12038:EE_
X-MS-Office365-Filtering-Correlation-Id: 28750292-34a3-46fc-c597-08dec57a121f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|366016|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	nKCYK3oAi70DyVuBTmJykF58egJeViwhQuFW/12xII85PLic+nsb80+pq2RfSwfbq6x6ZCpg4uyqu/de2wax2vct/kBy8qy9jsqbN8Hh72SkORJF+z45SToVh8pgco9p57nHlpHe4sAmgv/oIZv9y3ZZpGLPQgtoTOX1mid5ThlHHj0vXndhsbvebZdFd4vee5k4u9DOS40vdv9psmYQ/V1JgHEohto9rwjpgcAhT6F/VJai/nTGyuV3dHE13MhPo+X0j6Ks/4vIzxEKKOwMbWu6wU9ac4UHAFQf+9rmLaNfPsauDkIAoAKwEXLFWWu0Af7TFGvjKyW/t1WOwLAlj3I3N5UmtilYvwdHzfKkY/1uMhtMAIizB+U1AfKgEn0TlDuLcTrFxiUsw/DiS2CyWKEpUOrwxmpRKKiaWumOo8yRfm8j+qQ5d+28xswGg/XaSUmvHom7qGsvSiCXuOjdT7rsatzhxXVUz06RH4qrXMIH8J/VR1xXZbpIBJouFHFLZeYQCObWQRgwD+C0CSTIuA4el5W6gi0uKAfJzUK13bOLy1thwvzxEevDjME0NpnHpzHBLDc5+Y0iXwHZScNMfV2e753DO87ldpFmo5Uu40pnZBpOfz+4J8hL28zrR/S9ykSF12R9SeA5pT5UH+9nP+uQwtP0qGSWcMZ/laU1mBYyoRgugjt3kCgRsEwJdj0t
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jb3HeimotYFHCqQhv/x9r2rT8p8Yu1PTihKqWyHYAt9D1lV4bflbMPU8ougJ?=
 =?us-ascii?Q?VCbVVT6FmI665qc5BDEX6LK6DScaqJK0wF5fFK50PIfystbPx7Lc0raXBFX1?=
 =?us-ascii?Q?s05kmD5thon5sUlYchlv1HnkbQtkGvrWZV5I9sI3SuN0y0obDoKiTOAzjW0O?=
 =?us-ascii?Q?NbvhrmuKyePT42JlpGgxyk0Dyn7095YhQHI145M0syLIMC/8bSxOEMQQw1DV?=
 =?us-ascii?Q?bsET1rOyp3P2sR3HVifjHk3e6Sry5qnLfTtzXE9d7juAM83NlE2A5+7ehdxP?=
 =?us-ascii?Q?Tj5e5D57oX0nO2KrnwWwSBaCZ1XYbSCs0bhZsBrbG0YEkKGAYZhdngVIekRS?=
 =?us-ascii?Q?V40kEAibVm0tjzEU0eahm6UvkrDB/2WRqw6AJqeG30e/b+89A/X8cCip3zBp?=
 =?us-ascii?Q?azNi53PrO9eWks4+bY09LhQSXO1ZlHf12q0o66r16HeBU12HETkaPVLYcegN?=
 =?us-ascii?Q?3pVAVkQiQsGrnzcQAPlpg/7ZHtlufJuQ5m/ErcoWdRHgikjD+FBFc2UCCTQC?=
 =?us-ascii?Q?4XttTIB42rHPp9jOmRth6xMNWqKI9szZ8vlYF6b1wuV3YbS2DVJVnpT7VC1a?=
 =?us-ascii?Q?7ixMj+SF31eJDoCHEeSjFe8CIPxPd/VTjce0uay0xc3zruDBVRc/JfqoHKeN?=
 =?us-ascii?Q?jWmh0QUvRtXFDd13SIah2nuHgHxlilScFDwFSAlXMY4SfuvAbbYW/rSyD3lC?=
 =?us-ascii?Q?O8910Yu18TuMyd0Lidynl1mqFvolznN86z3A18whMqpu7mPV7XLq/pZ2Bjjm?=
 =?us-ascii?Q?4R64dE0MatESofWf8BV6C9ENlZWSruOB1OhVBnk8Z9T4vir5SLTszfZvlr5r?=
 =?us-ascii?Q?BpXFHhcENoFNU3ldDFoXoFjxzivn/sjH8FpIuPJm7os/tpGcNWCRn87hCNR6?=
 =?us-ascii?Q?6ZlAvv98moN4+onMzfYaBiaOKLcCLWKhF+L/qu1hLA2inT18ltsiGoIXm7fq?=
 =?us-ascii?Q?VoGnwuTv3/LksJsB1+LY6QaHmfkQQmgbCxX6i5qPwasY1cggNWt8NP/uV6dT?=
 =?us-ascii?Q?BnzfAfal29CQABzM/Ql92DYoQc0UYFHZ/+kKi/fKT5qQwgpjPsGMT11/9CG9?=
 =?us-ascii?Q?TnVoaFrgAM8NZIwgT/KXb0eGB+l4NOsGSDF4cNA1+fSh+i19/Bips7wazSxh?=
 =?us-ascii?Q?JQbFOaSa1qBsWBsgSU3/o8Vtw+3Xv+SbxfGlLanYTYIX7LLcYWj3WgLB5lZ4?=
 =?us-ascii?Q?2vs+CUKwMy7C5RmcwD+L1Cf4yOTesu8Hs9TKRtPZL2PTUrYlIHojZKfnex/Q?=
 =?us-ascii?Q?Ed6trBiyFZ0mZvcQdQFh4JrGt4fRUx+ielqeHGZJvl0d8N80+RK1CFV/liGY?=
 =?us-ascii?Q?WPCabTC5qlVg3wyX67BY5I6YoZaxWSMOcZm+4pJiKhgDQ6vpXjrrsl0UY92+?=
 =?us-ascii?Q?u/gh2mENJ/pDI0G5Nv2Xk6rVOE9M+RTxsielVvl1F+WiQaR8l8JAB7RdQR4L?=
 =?us-ascii?Q?ZbqIGevoWP/J+QqmAOQYyXBq2B36s5eTnRgIST7YemMQgklr3OkTAGCod4+t?=
 =?us-ascii?Q?ZOysWXiyrKyVn22qQvL2+2aAyH6uZwF61ZKqXKsNRui1fpLKS4mVxKe3mapk?=
 =?us-ascii?Q?FgG4wdZYjH42KIKnYvWxttH7spiZ5kXx4PvGikSuzQ3LcJaVLwb0rhL2/xLs?=
 =?us-ascii?Q?OSq1fR3N14f1SueSl8dpaIeOzwQ7ryMObZZiHguzoWELWgIuMIpa6XwfMMnG?=
 =?us-ascii?Q?dxGyHXYe23O+DZwzchG6ORobPC91Kztx1o1IsZQMzsV95VdeWw665bBI8U3a?=
 =?us-ascii?Q?UB8poGIEtA4w0AN6/2vcyff1VaLH87R40DbvvUA3I8eN9+wA7JLE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28750292-34a3-46fc-c597-08dec57a121f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 16:22:01.7750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6w/SjC8TRo8pwQ/T1AkpBQk/oyO+XhIVzkDjcZRcTWYLannd1BBlFvTcQYgvUdAzZ+RzRQnLJmOxg8KYmmALWCDvmgjQQM7+c+MO5gtKGUxmtkGr6+SZrVD8hndBfeVD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB12038
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
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11334-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.nxp.com:from_mime,NXP1.onmicrosoft.com:dkim,vger.kernel.org:from_smtp,SMW015318:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2C8CA6594F7

On Sun, Jun 07, 2026 at 10:34:41PM -0700, Rosen Penev wrote:

As previous said, subject should be dmaengine: fsl_raid...

> Mechanical conversion of the ppc4xx-specific accessors to the generic
> portable helpers.

what's beneafit by such replacement? Do you remove in_be32() and out_b32()
macro?

Frank

>
> As a result, enable COMPILE_TEST for extra compile coverage.
>
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/dma/Kconfig    |  4 ++--
>  drivers/dma/fsl_raid.c | 50 ++++++++++++++++++------------------------
>  2 files changed, 23 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index f16bd4059d84..302021540d76 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -242,7 +242,7 @@ config FSL_QDMA
>
>  config FSL_RAID
>  	tristate "Freescale RAID engine Support"
> -	depends on FSL_SOC && !ASYNC_TX_ENABLE_CHANNEL_SWITCH
> +	depends on (FSL_SOC && !ASYNC_TX_ENABLE_CHANNEL_SWITCH) || COMPILE_TEST
>  	select DMA_ENGINE
>  	select DMA_ENGINE_RAID
>  	help
> @@ -448,7 +448,7 @@ config MOXART_DMA
>  	select DMA_VIRTUAL_CHANNELS
>  	help
>  	  Enable support for the MOXA ART SoC DMA controller.
> -
> +
>  	  Say Y here if you enabled MMP ADMA, otherwise say N.
>
>  config MPC512X_DMA
> diff --git a/drivers/dma/fsl_raid.c b/drivers/dma/fsl_raid.c
> index 99945845d8b5..dedd4a83ac72 100644
> --- a/drivers/dma/fsl_raid.c
> +++ b/drivers/dma/fsl_raid.c
> @@ -114,7 +114,7 @@ static void fsl_re_issue_pending(struct dma_chan *chan)
>
>  	spin_lock_irqsave(&re_chan->desc_lock, flags);
>  	avail = FSL_RE_SLOT_AVAIL(
> -		in_be32(&re_chan->jrregs->inbring_slot_avail));
> +		ioread32be(&re_chan->jrregs->inbring_slot_avail));
>
>  	list_for_each_entry_safe(desc, _desc, &re_chan->submit_q, node) {
>  		if (!avail)
> @@ -127,7 +127,7 @@ static void fsl_re_issue_pending(struct dma_chan *chan)
>
>  		re_chan->inb_count = (re_chan->inb_count + 1) &
>  						FSL_RE_RING_SIZE_MASK;
> -		out_be32(&re_chan->jrregs->inbring_add_job, FSL_RE_ADD_JOB(1));
> +		iowrite32be(FSL_RE_ADD_JOB(1), &re_chan->jrregs->inbring_add_job);
>  		avail--;
>  	}
>  	spin_unlock_irqrestore(&re_chan->desc_lock, flags);
> @@ -167,7 +167,7 @@ static void fsl_re_dequeue(struct tasklet_struct *t)
>  	fsl_re_cleanup_descs(re_chan);
>
>  	spin_lock_irqsave(&re_chan->desc_lock, flags);
> -	count =	FSL_RE_SLOT_FULL(in_be32(&re_chan->jrregs->oubring_slot_full));
> +	count =	FSL_RE_SLOT_FULL(ioread32be(&re_chan->jrregs->oubring_slot_full));
>  	while (count--) {
>  		found = 0;
>  		hwdesc = &re_chan->oub_ring_virt_addr[re_chan->oub_count];
> @@ -192,8 +192,7 @@ static void fsl_re_dequeue(struct tasklet_struct *t)
>  		oub_count = (re_chan->oub_count + 1) & FSL_RE_RING_SIZE_MASK;
>  		re_chan->oub_count = oub_count;
>
> -		out_be32(&re_chan->jrregs->oubring_job_rmvd,
> -			 FSL_RE_RMVD_JOB(1));
> +		iowrite32be(FSL_RE_RMVD_JOB(1), &re_chan->jrregs->oubring_job_rmvd);
>  	}
>  	spin_unlock_irqrestore(&re_chan->desc_lock, flags);
>  }
> @@ -206,7 +205,7 @@ static irqreturn_t fsl_re_isr(int irq, void *data)
>
>  	re_chan = dev_get_drvdata((struct device *)data);
>
> -	irqstate = in_be32(&re_chan->jrregs->jr_interrupt_status);
> +	irqstate = ioread32be(&re_chan->jrregs->jr_interrupt_status);
>  	if (!irqstate)
>  		return IRQ_NONE;
>
> @@ -216,13 +215,13 @@ static irqreturn_t fsl_re_isr(int irq, void *data)
>  	 * need to do something more than just crashing
>  	 */
>  	if (irqstate & FSL_RE_ERROR) {
> -		status = in_be32(&re_chan->jrregs->jr_status);
> +		status = ioread32be(&re_chan->jrregs->jr_status);
>  		dev_err(re_chan->dev, "chan error irqstate: %x, status: %x\n",
>  			irqstate, status);
>  	}
>
>  	/* Clear interrupt */
> -	out_be32(&re_chan->jrregs->jr_interrupt_status, FSL_RE_CLR_INTR);
> +	iowrite32be(FSL_RE_CLR_INTR, &re_chan->jrregs->jr_interrupt_status);
>
>  	tasklet_schedule(&re_chan->irqtask);
>
> @@ -708,30 +707,23 @@ static int fsl_re_chan_probe(struct platform_device *ofdev,
>  	}
>
>  	/* Program the Inbound/Outbound ring base addresses and size */
> -	out_be32(&chan->jrregs->inbring_base_h,
> -		 chan->inb_phys_addr & FSL_RE_ADDR_BIT_MASK);
> -	out_be32(&chan->jrregs->oubring_base_h,
> -		 chan->oub_phys_addr & FSL_RE_ADDR_BIT_MASK);
> -	out_be32(&chan->jrregs->inbring_base_l,
> -		 chan->inb_phys_addr >> FSL_RE_ADDR_BIT_SHIFT);
> -	out_be32(&chan->jrregs->oubring_base_l,
> -		 chan->oub_phys_addr >> FSL_RE_ADDR_BIT_SHIFT);
> -	out_be32(&chan->jrregs->inbring_size,
> -		 FSL_RE_RING_SIZE << FSL_RE_RING_SIZE_SHIFT);
> -	out_be32(&chan->jrregs->oubring_size,
> -		 FSL_RE_RING_SIZE << FSL_RE_RING_SIZE_SHIFT);
> +	iowrite32be(chan->inb_phys_addr & FSL_RE_ADDR_BIT_MASK, &chan->jrregs->inbring_base_h);
> +	iowrite32be(chan->oub_phys_addr & FSL_RE_ADDR_BIT_MASK, &chan->jrregs->oubring_base_h);
> +	iowrite32be(chan->inb_phys_addr >> FSL_RE_ADDR_BIT_SHIFT, &chan->jrregs->inbring_base_l);
> +	iowrite32be(chan->oub_phys_addr >> FSL_RE_ADDR_BIT_SHIFT, &chan->jrregs->oubring_base_l);
> +	iowrite32be(FSL_RE_RING_SIZE << FSL_RE_RING_SIZE_SHIFT, &chan->jrregs->inbring_size);
> +	iowrite32be(FSL_RE_RING_SIZE << FSL_RE_RING_SIZE_SHIFT, &chan->jrregs->oubring_size);
>
>  	/* Read LIODN value from u-boot */
> -	status = in_be32(&chan->jrregs->jr_config_1) & FSL_RE_REG_LIODN_MASK;
> +	status = ioread32be(&chan->jrregs->jr_config_1) & FSL_RE_REG_LIODN_MASK;
>
>  	/* Program the CFG reg */
> -	out_be32(&chan->jrregs->jr_config_1,
> -		 FSL_RE_CFG1_CBSI | FSL_RE_CFG1_CBS0 | status);
> +	iowrite32be(FSL_RE_CFG1_CBSI | FSL_RE_CFG1_CBS0 | status, &chan->jrregs->jr_config_1);
>
>  	dev_set_drvdata(chandev, chan);
>
>  	/* Enable RE/CHAN */
> -	out_be32(&chan->jrregs->jr_command, FSL_RE_ENABLE);
> +	iowrite32be(FSL_RE_ENABLE, &chan->jrregs->jr_command);
>
>  	return 0;
>
> @@ -768,15 +760,15 @@ static int fsl_re_probe(struct platform_device *ofdev)
>  		return -EBUSY;
>
>  	/* Program the RE mode */
> -	out_be32(&re_priv->re_regs->global_config, FSL_RE_NON_DPAA_MODE);
> +	iowrite32be(FSL_RE_NON_DPAA_MODE, &re_priv->re_regs->global_config);
>
>  	/* Program Galois Field polynomial */
> -	out_be32(&re_priv->re_regs->galois_field_config, FSL_RE_GFM_POLY);
> +	iowrite32be(FSL_RE_GFM_POLY, &re_priv->re_regs->galois_field_config);
>
>  	dev_info(dev, "version %x, mode %x, gfp %x\n",
> -		 in_be32(&re_priv->re_regs->re_version_id),
> -		 in_be32(&re_priv->re_regs->global_config),
> -		 in_be32(&re_priv->re_regs->galois_field_config));
> +		 ioread32be(&re_priv->re_regs->re_version_id),
> +		 ioread32be(&re_priv->re_regs->global_config),
> +		 ioread32be(&re_priv->re_regs->galois_field_config));
>
>  	dma_dev = &re_priv->dma_dev;
>  	dma_dev->dev = dev;
> --
> 2.54.0
>

