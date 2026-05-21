Return-Path: <dmaengine+bounces-10673-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0M+5KFgtD2r+HQYAu9opvQ
	(envelope-from <dmaengine+bounces-10673-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 18:05:44 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A974C5A8DE4
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 18:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FDCA339E2A9
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 15:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1662D9EE7;
	Thu, 21 May 2026 15:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="qUgWKSaK"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021082.outbound.protection.outlook.com [52.101.125.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBAD318ED7;
	Thu, 21 May 2026 15:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779375776; cv=fail; b=qERQmnD3uyAriFXG6yiGv6VQCo9LTGkIbQ3hTdmyPd7WeLDakvEIrmvM9JMhZ359nKGygFFiNSt2Ch7WV0Nzb0ItlVl9VltmGzCbSKi1wneL9UQiYOwUUUWOK4s7jwBYtn4aeoemGd3kyeUiBK9ZFEKzEvERrCmUn6e9sHz7gn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779375776; c=relaxed/simple;
	bh=tau85Bq2SnkP5NvF+hOfjKGVBNxG/fD52X2WlIJpN7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u5FpZ0SnsyYsYPZ4404kXdEa3/l4G/ezCPZfTW8bnt7qMs/9Yx+BM4TAJjhkZClDORAFcHWWhc4wGB1OoK/gzcIo0l5sE84GxxKkkbtWCao4sGlp10YI/1KoLu0OvD0fTZ+oFYZmdrmEusjUA558qCvLgDcfmsbz0J2qxiaCsZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=qUgWKSaK; arc=fail smtp.client-ip=52.101.125.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wm2ig5ohnhrYZO2XlE3cbnlXFJFqgBSlSONyHcTz05ziWxu4IN1/OJHLV4VbL40zq8PfEDHRB7NBZYqDOBWJvn3tb2a4YKKdPM2DspUnZpQPNzfdAHgaHWLgjoS27nbbg7WmcS2viB0lbUvtLF4WV13Z/7rlOmaTUW+/zjeEIwdo9fp76E+MU2zzbNinVSEVgSOHHDbLvJ1c+HwAJFT+BtLwI+CnQIyS6A0hq28oYgqoUW18BF7Sk+NVze8ltk88kg0bTDmYq9rd7rKeLxNqUD5byl7VXvZckqVevBuLKQxW8ORV//U/aFpmBoYZfH/cZnGWhomwxco3XlxblEik8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tNBn9ddQNa4HZXx0OjZlY/bg2LF/ht02YqA4ATiRmDI=;
 b=TRQTZA3/d1hyJqKmOldlWCy52mRkSRTh85ar/wXf0oZOnsrTxYgJ7E6hJ5xBO71U1ISuGs98EJJRB1YnKqoOWrhPYbEPbnyK7zQ7wAI12SOO//jV+hKhJs2nYaq3p9e2TUcRuJ6juZkzdaTuwV/BFOwJ/4R/aA5XJwCO6P2MnS6UAe+o2397QH4l78EpxKikYTYl6yolI25oJcbOaoyTyn1m+vIaSEIJRrfFCtdEWDjNwhjbmmMA487U4gYATO9TJ8eABU+PHHHCocctIT3zpU8EUCyfL/Lb8Fi0X8HNDTM9u3bCHIW21c8GXdnzN+NuGAyFHUa3pVkftJ0vpTWLWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tNBn9ddQNa4HZXx0OjZlY/bg2LF/ht02YqA4ATiRmDI=;
 b=qUgWKSaK9S1r7US0EuMnsJafsr0U62ecbslhUWgQsD+iGXsXDPLViKP03UZytReVTd0gjNC0w/vaUpAFUZKz7IWy0Gs6GUuh9nv21LGzZjmcfDPwxuIVQ7IurOKl6r4EyLy21gXITwmgd/Cw419z1HsJukQnv8blIr27pIZkefE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY4P286MB7639.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 15:02:52 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 15:02:51 +0000
Date: Fri, 22 May 2026 00:02:50 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dmaengine: dw-edma-pcie: Free IRQ vectors on probe
 failures
Message-ID: <xcrbweipase44isv6lfrgqos4mrfhc7o3v4f3lzlovekvsubim@yoz4kfxhka33>
References: <20260521142153.2957432-1-den@valinux.co.jp>
 <20260521142153.2957432-2-den@valinux.co.jp>
 <ag8ZDcAedIY-LFLn@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ag8ZDcAedIY-LFLn@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TY6PR01CA0030.jpnprd01.prod.outlook.com
 (2603:1096:405:3bd::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY4P286MB7639:EE_
X-MS-Office365-Filtering-Correlation-Id: b60711cf-0960-437e-d1a7-08deb74a079f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|4143699003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	OOfuF+s/YE+5j1MB1V0QHkB+fT2XEOvmomEDa9RYcWwzypcS1VljoM5qSXa0PMa0fnY/1yT9ZTKwFkdq+hRsEWIawSvk2R0DjDUgXNrYDyxCKNCBm3d8VkB4NZ0ru1J5Qk0bS0C+LQDnJYrIJ9n0sbnppf/Xz7YmhnRCs2Tq7FOX06sDEwFB8V0KR8A24H6DzLlWJRo7EQoge6wMZBjXhBPEdTs4wVjiTrU9jKYU+zFm4RqwYin9IIl+wSioLknqfBTNr/VbPcwd0lLWflSI7s+b1ruJDCbiXweV3cDK/FwSGPO+e7MQy80dHdFftTkgueZ54p6ROWRTncVSbyBsKF1ExnbhTc5OcdnOp7Da51ahe5j4jUimZ2hKD5899EZ7ajvSyPVPnSsY8BPkzV2CMw8r5eMvtFjE4OB4egh5eiEMW3JbFikHSCx1M5GyBLt4pK4rmjF02qPw+huUQ31N+UpiP8h2vu9FIJzqjRTb3ASooJ6KG9ix7zZ+FgQ8UbD/DCLNBcQRr1J8HCkDH6d4/iAkAJY82b9ByygFpraa4ZJgYx1stLV/YQluz8J+G/TlqDL0rp/VFLWfplNHba1Ag6MbfdL+RSJGct4mjdkIJ+d3r0CYWRNw4goYWp30SuaShWO5Qvn/6YyrGUov7akSpGJ5fK5hD1r0K2w0U/wzE6j3RXM8qeBhcVL93cNKLWIC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(4143699003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VmU/U1q9H9dhgmnEVHZxisXCPVKEmaH3w89o9HTMog6gRS5hlswZZdzMujJ9?=
 =?us-ascii?Q?AMwWdMqQN058FOXKP2qBIeSjS6Q2fxTKwGtbC/5Rv6r6BjlZqaSCnA1X/K0a?=
 =?us-ascii?Q?Zcy0XeCl3LF1KlQA3Xo34VMV4UjjisVKTifL8ZDXmYDcdeeC5US+ip9rC8e9?=
 =?us-ascii?Q?HEBsJzYKcgf8jPfJQ/U/4J/vqSdzwd9fWXDYg3MVhlUp2XVEGWaiuzJNQb42?=
 =?us-ascii?Q?Hm9iQg2PzvtEuPYMh0O1IvyA81mptm/BHjfH4svXdI0r3ciAX47a8E/wlRie?=
 =?us-ascii?Q?CWYFiZ5+xX6Qq3dHoyOcMznr5jEBw9wjv5OpCXUGp84CWYOLIAIjRp7dNUED?=
 =?us-ascii?Q?MjH1jCGxs3Y4joYjZ2kHjbc+W7ioblN3d7CDYpTfdxA7ol95upzWvEMMFmeV?=
 =?us-ascii?Q?ikexo7U/6QoIq/DZC+GGPBLO2nkRhxmQJJ4wpNN289LexhWUEXrmErvtUZFo?=
 =?us-ascii?Q?dd0aphogOvldgmbA7fxaLnCrRB8EfZJA0NoiiyAJ2vR/xfdJRz0CMsX0c00N?=
 =?us-ascii?Q?L1ZzQRqT/fGQ2m09rMNTA0TWgDDxwxBIC00b9x1PJKfTpyoQaOznn3VYHh77?=
 =?us-ascii?Q?ooWYdhF7ENPd7LFAVxW6y1VmPsZq0qFIXVw7L6Fx91Lcx5+Gs6MX+6Svqf2T?=
 =?us-ascii?Q?RuJ90NXIDQsa7NVfV5loUBXOJLUMaMeYGVbYw0+ZuzqBf+IUAYST9ReR16OK?=
 =?us-ascii?Q?1LGW28FWXqG25T7mElHPRcAJUsctXIr7hzuEpbMZfA7R89qApFHOIO1qa8WS?=
 =?us-ascii?Q?nm75FKYMDYarjzd0ff7DyfH48fyG6sj8M9ewhreTFpJygISz8bQve9es44Ig?=
 =?us-ascii?Q?C+yvc3UBLWJpC81EjebE67V9ciENhi0v6+jUMxCJKC3RCd75NTCQgJh0bHU7?=
 =?us-ascii?Q?a3gtEh5aptJTY8lmbChIm5RXufLEwEdqvjSPKxB3IkLPiH5ZWsDoX91tSIOc?=
 =?us-ascii?Q?Fj5GwuZeYLLMtHxKfiZ1yu5+T4ntIFO+hAWdYiM0rYPaqnCLpMJ0Je/UskuU?=
 =?us-ascii?Q?edAYkiJmAU8dEWdntJ+nubvvi2XH6dnKu30E6ecaG4jXZFsHRvUFlH608CU8?=
 =?us-ascii?Q?Lnq8Cw/wjC1kFd6Jqi/nIs5UHZ86EjDdqjNTc5PvtNsZjfL4bW9TMuZosD9w?=
 =?us-ascii?Q?PfErKhSOrGjw6cB53Qk8tsDtgWB6qon2L4dx79zL0m08nzJXhh7k82sU4dMO?=
 =?us-ascii?Q?lDzA7s4abuhtmY9hQ1+job9XcfE69qSa9pk/JH6gTh/meh685ysG8nxMY+Tj?=
 =?us-ascii?Q?cGqR9TuMpiDbbQdpJP9V33i6mCGKmHOVehvjJXAeRVGZk5pOBcUzIhQIGpY1?=
 =?us-ascii?Q?JcxO75GhN9pD62VpvYWoWclxgC4GrxJ1PykQ0iYQkKhQ2KGrxWdef7UV5hr+?=
 =?us-ascii?Q?TK2jKVxp9vVZuMZ1YIBDKI1n+a7vvdkk0AbhlX9PSTpJX1/qsdwmcAv2edDq?=
 =?us-ascii?Q?B0ULxyiBEewDCjRQf94m5vnO528BuUIMF7xgT+VBxJuV6RG9jj0y9UPYEgh4?=
 =?us-ascii?Q?aN4YkbHXdGDBiC1fugJqA4KVUaQQQnpWI+xyBIIpFVL93HPVGLTxtlCaJ2OX?=
 =?us-ascii?Q?/bz59LSiOVyCPAzuVgM7VEQeDf5yXTF+bTtcsCYrADNLJOo8kAPaTKVDR5tm?=
 =?us-ascii?Q?LpaucjLv2WgZrrzOgTdTxp5I8Pl+ugOtirIjeoJ/mQ062+gt/c2IFZAWIoyC?=
 =?us-ascii?Q?irMVkaSu5xHapKN80ryuJVuAyU24P/gxZd/6hsnM6ftuyF8RExpUkiUPdTpY?=
 =?us-ascii?Q?filC62ulXZtfVl9jMpG8LsxzTOz0ksnJ2+qfW/2LMZqIVku3IMBZ?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: b60711cf-0960-437e-d1a7-08deb74a079f
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 15:02:51.7030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hr7U7UACU1BkqwPrZBTQN0UUtpXSrByeQ/itiORnK4NE64/UQbYsIUwQZ95R6Ei0i4CCtmZ4O3GMw5I/V1buRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB7639
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10673-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:email,valinux.co.jp:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A974C5A8DE4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 10:39:09AM -0400, Frank Li wrote:
> On Thu, May 21, 2026 at 11:21:50PM +0900, Koichiro Den wrote:
> > dw_edma_pcie_probe() leaks IRQ vectors by returning without calling
> > pci_free_irq_vectors() in error paths after pci_alloc_irq_vectors()
> > succeeds.
> 
> I remember pcim_enable_device() already auto manage irqs.

You are right, pcim_enable_device() already manages the IRQ vectors.

Thanks for pointing it out. I'll drop patch 1 if I need to respin, or ask the
maintainers to disregard it when applying.

Best regards,
Koichiro

> 
> Frank
> 
> >
> > Route the post-allocation failures through a common cleanup path so the
> > vectors are released before probe returns.
> >
> > Fixes: 41aaff2a2ac0 ("dmaengine: Add Synopsys eDMA IP PCIe glue-logic")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  drivers/dma/dw-edma/dw-edma-pcie.c | 39 +++++++++++++++++++++---------
> >  1 file changed, 27 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> > index 0b30ce138503..87c31d01fb10 100644
> > --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> > +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> > @@ -410,8 +410,10 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> >  	chip->ll_rd_cnt = vsec_data->rd_ch_cnt;
> >
> >  	chip->reg_base = pcim_iomap_table(pdev)[vsec_data->rg.bar];
> > -	if (!chip->reg_base)
> > -		return -ENOMEM;
> > +	if (!chip->reg_base) {
> > +		err = -ENOMEM;
> > +		goto err_free_irq_vectors;
> > +	}
> >
> >  	for (i = 0; i < chip->ll_wr_cnt && !non_ll; i++) {
> >  		struct dw_edma_region *ll_region = &chip->ll_region_wr[i];
> > @@ -420,8 +422,10 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> >  		struct dw_edma_block *dt_block = &vsec_data->dt_wr[i];
> >
> >  		ll_region->vaddr.io = pcim_iomap_table(pdev)[ll_block->bar];
> > -		if (!ll_region->vaddr.io)
> > -			return -ENOMEM;
> > +		if (!ll_region->vaddr.io) {
> > +			err = -ENOMEM;
> > +			goto err_free_irq_vectors;
> > +		}
> >
> >  		ll_region->vaddr.io += ll_block->off;
> >  		ll_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
> > @@ -430,8 +434,10 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> >  		ll_region->sz = ll_block->sz;
> >
> >  		dt_region->vaddr.io = pcim_iomap_table(pdev)[dt_block->bar];
> > -		if (!dt_region->vaddr.io)
> > -			return -ENOMEM;
> > +		if (!dt_region->vaddr.io) {
> > +			err = -ENOMEM;
> > +			goto err_free_irq_vectors;
> > +		}
> >
> >  		dt_region->vaddr.io += dt_block->off;
> >  		dt_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
> > @@ -447,8 +453,10 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> >  		struct dw_edma_block *dt_block = &vsec_data->dt_rd[i];
> >
> >  		ll_region->vaddr.io = pcim_iomap_table(pdev)[ll_block->bar];
> > -		if (!ll_region->vaddr.io)
> > -			return -ENOMEM;
> > +		if (!ll_region->vaddr.io) {
> > +			err = -ENOMEM;
> > +			goto err_free_irq_vectors;
> > +		}
> >
> >  		ll_region->vaddr.io += ll_block->off;
> >  		ll_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
> > @@ -457,8 +465,10 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> >  		ll_region->sz = ll_block->sz;
> >
> >  		dt_region->vaddr.io = pcim_iomap_table(pdev)[dt_block->bar];
> > -		if (!dt_region->vaddr.io)
> > -			return -ENOMEM;
> > +		if (!dt_region->vaddr.io) {
> > +			err = -ENOMEM;
> > +			goto err_free_irq_vectors;
> > +		}
> >
> >  		dt_region->vaddr.io += dt_block->off;
> >  		dt_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
> > @@ -513,20 +523,25 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> >  	/* Validating if PCI interrupts were enabled */
> >  	if (!pci_dev_msi_enabled(pdev)) {
> >  		pci_err(pdev, "enable interrupt failed\n");
> > -		return -EPERM;
> > +		err = -EPERM;
> > +		goto err_free_irq_vectors;
> >  	}
> >
> >  	/* Starting eDMA driver */
> >  	err = dw_edma_probe(chip);
> >  	if (err) {
> >  		pci_err(pdev, "eDMA probe failed\n");
> > -		return err;
> > +		goto err_free_irq_vectors;
> >  	}
> >
> >  	/* Saving data structure reference */
> >  	pci_set_drvdata(pdev, chip);
> >
> >  	return 0;
> > +
> > +err_free_irq_vectors:
> > +	pci_free_irq_vectors(pdev);
> > +	return err;
> >  }
> >
> >  static void dw_edma_pcie_remove(struct pci_dev *pdev)
> > --
> > 2.51.0
> >

