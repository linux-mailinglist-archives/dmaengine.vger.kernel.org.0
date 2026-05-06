Return-Path: <dmaengine+bounces-10239-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IUuBZ9p+2miawMAu9opvQ
	(envelope-from <dmaengine+bounces-10239-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 06 May 2026 18:17:35 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC2B4DDF8A
	for <lists+dmaengine@lfdr.de>; Wed, 06 May 2026 18:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 41F863004686
	for <lists+dmaengine@lfdr.de>; Wed,  6 May 2026 16:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D556495528;
	Wed,  6 May 2026 16:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KhKz4oqT"
X-Original-To: dmaengine@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010043.outbound.protection.outlook.com [52.101.84.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2123647ECE2;
	Wed,  6 May 2026 16:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778084083; cv=fail; b=T9Cj17ZxXucDacVOgvjPLiezvlZjtRES/kMOqtaIuuYwajixjhCAWo7jqUUL3etuS8kQdALS3pKE6ZV6m9QiLKAL46u38+RUwjQkYxzUhQ7M0SVPx7mwVgA1frJD8ir16D5oKOw6kMZ9Pkhwy57G+XQI8E+4JaRhtEMgeO2Bpng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778084083; c=relaxed/simple;
	bh=WJIEImC+1Je3usUyKw5wSEGhr2+w+jUzR7Cwjmguxks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fZCGLH7Aq7ks6srRZYiv7x8jTjZmI4Fy8WkWolI2c5zz8bsrY38ZDcjMolVhwo9pI12ag99iyp2ZnD7shZdeIM67dyU85YHieleNx5s0HlIdLuMOu+8Vrk9HccG5S3z2jYk4I0bIPFvErZRV7OktgxmnyAWG5UueDKY6V1vow2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KhKz4oqT; arc=fail smtp.client-ip=52.101.84.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JN9CkfIxiGlnTuWhXuHo2v6Zczt2GpnOjSEw8jfn2kvyklI6xIpXLlJKUzIzkXsuEh83a5PY1/x0NUber3Nq1y1hWVXpGNTuECer1krR2t69DqaFaT45zMsX1WjwRiHJBEq6aEs9zs5uB1tbLorhSFIymacVpsXcN7152HrAYaq6AmSG2n/YEw7oV9HZ6/TzZjX3zzorUMBRn5BdhBJKI9nOaPpQjyP/RVwEEphlXr5XmU4nlVgDr+3xmMYIreAuYOEIh7MfKdidOxu+gXzAdOqSLSh36E3FmbkZkZuRGgr4RagcxuMmz/JDiA2v3G1nM3q7VDOGlGJ7yEtqExd/tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pRaX83Y2+naYAgFERuHydt7fXvIyBWMsdjRxS4TM6EE=;
 b=e6oI2kHAhwJsI+VUoMZGpvdv7EsaniFLhhQgihGrzPSDBQxo6pugMeTZsZJBUEDY696XCuTQML2U+Hnv+bg4NRTbuRRh2I2P9XeH1EdJpQwKc4aY5riBua2I7N4/R4SJA31y8vrmBqrDSa8arF5GUsoqaVxY5E0cuccDt1/OTzDCnJNkgGk1pkF4+Mx8Y35uhUjDfo/W2RVcLddAQwYsQOavLDtJXYYJbGxqaRcsBwPiEb1kX50FqQvf1kvtfYHUMOUbgow4a9/CrYtAa1WJOaESjCUFPODFGHUeYuV7bL9V6atp4hbc7a7IEtxVfBgcu0f7xWu3BKPfooXlwUMU/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRaX83Y2+naYAgFERuHydt7fXvIyBWMsdjRxS4TM6EE=;
 b=KhKz4oqTb3XMcZe+uAt+Z8uOxFLBNnlf1QqOvCrNibyw7ezTlikSH/5Xpixgh7c2nnwpRsFmKqfV0HJUl0mroTo1aIL5rT1QYvIBc5Od4/9pEuZHxsvWDEBMZVx5tnO+YU4+dpeQKlYbRtDzzgQbmqSg36Padl344zMPndF2DDXe567aPWcfcCLbBQ5uaBzcuFhKrP2/4xczBDJQ1x1A2ZGQckXQ1bXpJtm5sM/AoLZpvYzNRsnP8ygTlBVl9QGircBFvHeiDKE/RvPbsukDrntMGG2qX4uZUX6kKe3B+nxGkp6fG+PcJXQ0v/Uzj28qhULPUNzKSXjenkCYEFdROg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DUZPR04MB9848.eurprd04.prod.outlook.com (2603:10a6:10:4dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 16:14:31 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 16:14:31 +0000
Date: Wed, 6 May 2026 12:14:25 -0400
From: Frank Li <Frank.li@nxp.com>
To: Greg Ungerer <gerg@kernel.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
	arnd@kernel.org, Greg Ungerer <gerg@linux-m68k.org>,
	dmaengine@vger.kernel.org, linux-can@vger.kernel.org,
	linux-spi@vger.kernel.org, olteanv@gmail.com,
	adureghello@baylibre.com
Subject: Re: [RFC 4/4] m68k: coldfire: fix non-standard readX()/writeX()
 functions
Message-ID: <afto4fL0CVVNtHDQ@lizhi-Precision-Tower-5810>
References: <20260506142644.3234270-2-gerg@kernel.org>
 <20260506142644.3234270-8-gerg@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506142644.3234270-8-gerg@kernel.org>
X-ClientProxiedBy: SA9P223CA0022.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::27) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DUZPR04MB9848:EE_
X-MS-Office365-Filtering-Correlation-Id: f7f81151-4fc8-4218-b53d-08deab8a8df1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|19092799006|1800799024|366016|7416014|376014|38350700014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	LPdN9kBnP+0LLDdNHXv0gxLjwP2FsSomTSPJHMECA4wojcwz/O22gultwvWQ3/O28+QYSr7VJohNcy2xsxMcyZ5Wb6VEl6YpM5T2AJEnNh/rpWz5ZMR6UZfmGFPdutiB9228A360EIeTnPyhDAzPuFT5VlnGe1MAdbzHjbDAmm8uZcLaW4qKfm5l+N9LvSlQohGhPqTWJ6y/aLUTEr3RY2rqsGIVAO8pyzaIWivN8qDYIUQXfJzCPy0qi/fbLPHjuFhfxh7AqLQkixWh9A+7uFJrNR1Q56iG3rm+7GSxhlxALXg05n6ym4/z3nthWNokS0QOqHUF4mck/fu1oYR+AHqCr/frbzB8o4WG956NeUxhvTboGYfC5H9+juCP6qp0/JJagVIFiHEl1q1UH8lWIQuK1dU7suztIJBYS/sXCHYxP/F+Z6pdiry3jtMsUUK1qcnUrLJvadttsVQ3R8KcxUE+vJ9EnKjbAdsq6vaw2eqSbFpM92Zz4G7nNyDUlJBdh/WSTNRNEBuITvZ6+hEV+mffTpGEuJmTciJ/0YvyDFJ4xcgZf8gSaGfQKhiBbK+fw+y0JdsnK1oXQEML9aIwjN+FjsAewCgJqTR3rjF87bVho113C1QW110lEpa6k7Yk65p23vbt1kolb/LKb79X3GNUW1ChylifnCoPlgKSbxM/mc+lqaE1yrYQbEaR82R5ZtvcQG5qG1tFbdxEO7OK2PphA/suUTsTWok0XY0CAtww8y9imD78jj22U85B0shg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(19092799006)(1800799024)(366016)(7416014)(376014)(38350700014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?116iICr6z1Z3Ci13kfktK3pb1iDefHT/kBJOt9ls3ffmyUXXGNMHEItpNWmx?=
 =?us-ascii?Q?qb29y2nDOfjykubre8+0mgumK7qNSe0UKeskbkpq98JAZlXDdIQZlsUS9WFH?=
 =?us-ascii?Q?CE0NHcbt7nE/LgVwxg8mj95PPsz3GBbnXJjisgqKq7wXCXGR/BNHFBm0p1RT?=
 =?us-ascii?Q?tS0iCsM9dh1wmt2BjLxMaoOQDlb+U6svBxPU95kTSBpC7NljMAkWkxNq5eui?=
 =?us-ascii?Q?OG6zI4VKEX1PlrdmStGfUPW2teS31+F9K1PymRyl6wQlMjl6UGfO5zQTsSxg?=
 =?us-ascii?Q?KmBnlQ6UYo5rH+Um4kA9DItXM8TR0WaNQY6bf6Un6NL/3a4C4NoVs0fX9Gfi?=
 =?us-ascii?Q?nMq5VQpMGmsr8UgDQYcUT/Z+x+PaR7pOjQlX/V2XKQHHVwdWdatD3VRYVgTR?=
 =?us-ascii?Q?3EGbR8+nadnYwv729JDExpfeC/V/YH9O9f/ioGsdsEVfZgTn/lreiZRahFo8?=
 =?us-ascii?Q?AJ7/7O6Ned2B4y6cT0/Ae4hNpKvGcGhG+hj+IRQhxtDn/vHU+J30MxOWIveS?=
 =?us-ascii?Q?ImeGAUkPDrQmpW+Q0kcXuPFhz1rc+9n0Np+YvLxPtDWaLRYthXBxMxiNhGEP?=
 =?us-ascii?Q?vQIKZpcWePm1va8bkNVnimIHpeTR5XgCsHTeJZj9Kb6gcDE3qVLGNv6dfi4n?=
 =?us-ascii?Q?7PFN3b72ToPTH7J7EpLonbPIcNv+57Unl/tIMXSni5Y4JrlAsZc0UOZjnLP0?=
 =?us-ascii?Q?wmF9IZTCP+swrgJb5uGarSmuTITkXUI6BwC/S0u4tLskhokThY7mwjxF47T0?=
 =?us-ascii?Q?Nv/66oJVjdd+I8J0VmkQSb+htVAgq15E2i8oFDOww76PQeg/j6byWwmuY0G4?=
 =?us-ascii?Q?RlLftuuknTXvr9Muhb8LpkbXfJEKKzOZtqiH0zrZrcF4TT9wTETnPkBebw8U?=
 =?us-ascii?Q?e+8JuMrYYxIj1Ry6ZFMcREQED+VuekjS82Q4QTwlnYzB3HbBtuXIiYY5Fxyc?=
 =?us-ascii?Q?ISu5ZV/eAyIch3VM/K3PdIafB5yQ3g9BtA4SlEwT0X5EZNr8bu0O/5Nfdk4I?=
 =?us-ascii?Q?IC6JiYzv/bCtmZeY/D0qiJmzbiPoXvczYVHr1fMYsahfOkB83pYZ1//Z3g6M?=
 =?us-ascii?Q?/fh72jDhxtvEtuoqxNOy1tHf7WCQUj65Za5asVfNWMAcsYJMrJLR15UeSis7?=
 =?us-ascii?Q?P+cx80Xi4HxImcjTy/wdoHOCYBX9szMCn8GcXmhDTPW+cGiezW8zh3DzzHbg?=
 =?us-ascii?Q?8ANrtohONDplwGgrlxQrxM4HN00b6QMzj1x+YlJJZBxThkpEWKD4FLlFAoeR?=
 =?us-ascii?Q?S/gCJPAdd04gUrV+ub9j6QNwcCOVnc9bNeBtmN2GSH7H32qYa4vD/k4E+VCV?=
 =?us-ascii?Q?MNrw6wS9awxggDrsSFO3/jPfluhgJS/gQU3L+bwJr6ucEvUqk8JDNn4iavBs?=
 =?us-ascii?Q?VFLcipJR6KhHYQbN4DMq8CFlmq79u71Gidzd8quExi9gRZBcmZ6VP085TA4S?=
 =?us-ascii?Q?Da+mOtglWYCdQ4Uhr5h8TAgVL9lXC9liUrChQKCrpMHpWzyX6jNG7urkoirg?=
 =?us-ascii?Q?12/bWePoiEC180pxW+ar0pQrK3jproOtqqrDOAb1I70tt6JjEyJ+YvwkDMTv?=
 =?us-ascii?Q?bnHD+qRT3e/4FmLoxBP5y/oFsr90rs6vEu3fRnZPMa+TPWMatDMlbTl8dTff?=
 =?us-ascii?Q?Ah0BxyRI/1fwQYGyFjWiQcLIPF9B/32jRyqNkHnM5uU60Mkz8zyNnP3W6CP8?=
 =?us-ascii?Q?mRiHzyGIuB1icO7Aj+yzY2YzB3PnpdonRDsshRq3dhrt5Mfd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7f81151-4fc8-4218-b53d-08deab8a8df1
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 16:14:31.0441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s2SuuVUQxbDi80Qx84QunaGp3MQLJlPoelqRibK79N+KXRxb6Ub21GJFDBD+L7FVL5LPGgPw7YDUtxV4s7ahFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9848
X-Rspamd-Queue-Id: 0AC2B4DDF8A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux-m68k.org,vger.kernel.org,kernel.org,linux-m68k.org,gmail.com,baylibre.com];
	TAGGED_FROM(0.00)[bounces-10239-lists,dmaengine=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On Thu, May 07, 2026 at 12:26:48AM +1000, Greg Ungerer wrote:
> From: Greg Ungerer <gerg@linux-m68k.org>
>
> Remove the local ColdFire definitions of readb()/readw()/readl() and
> writeb()/writew()/writel() and use the asm-generic versions of them.
>
> The implementation of the readX()/writeX() family of IO access functions
> is non-standard on ColdFire platforms. They either return big-endian (that
> is native endian) data, or on platforms with PCI bus support check the
> supplied address and return either big or little endian data based on that
> check. This is non-standard, they are expected to always return
> little-endian byte ordered data. Unfortunately this behavior also means
> that ioreadX()/iowroteX() and their big-endian counter parts
> ioreadXbe()/iowriteXbe() are currently broken because they are implemented
> using the readX()/writeX() functions.
>
> The change to use the asm-generic versions of readX()/writeX() itself is
> quite strait forward, just remove the ColdFire local versions of them.  But
> this of course has implications for any remaining drivers that use any of
> these IO access functions. A number of drivers can be independently fixed,
> before this final fix to readX()/writeX() for ColdFire. A small number of
> drivers cannot easily be independently fixed and remain in a working
> state. Those drivers are fixed here as well:
>
> drivers/dma/mcf-edma-main.c
>   Supports big-endian access by setting the big-endian flag of
>   the drivers struct fsl_edma_engine. But locally should be using
>   ioread32be() and iowrite32be() instead of ioread32() and iowrite32().
>
> drivers/net/can/flexcan/flexcan-core.c
>   Setting the driver quirks flag for big-endian access will force
>   driver to use correct access functions.
>
> drivers/spi/spi-fsl-dspi.c
>   Setting the regmap format_endian flags to use native endian will
>   force driver to use appropriate big or little endian access on
>   whatever platform it is built for.
>
> These drivers have only been compile tested.
>
> Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
> ---
>  arch/m68k/include/asm/io_no.h          | 68 +++-----------------------
>  drivers/dma/mcf-edma-main.c            | 14 +++---

Suppose it is correct, but I have not such platform to test it. it should
be correct if disassembly code is the same at access register.

Frank

>

