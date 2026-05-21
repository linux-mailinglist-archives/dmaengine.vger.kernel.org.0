Return-Path: <dmaengine+bounces-10702-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJWtKoZBD2qcIQYAu9opvQ
	(envelope-from <dmaengine+bounces-10702-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 19:31:50 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BE15AA4A4
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 19:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B9385325242A
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 16:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488FE37E315;
	Thu, 21 May 2026 16:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="exDY0JJ3"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010068.outbound.protection.outlook.com [52.101.69.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E2D3403E6;
	Thu, 21 May 2026 16:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779381052; cv=fail; b=d6lJ9LMESDFObPcYb6v6kjhObXk3yz2neFlqgrzLIf+bPwnkYmtG00+OgFT8xc/61URRtI7tTkGgUhs6BB0NnPXXZLNjHhVeMAZx5S7Hofuh8sYXPkFHZptRlhAqmTEqQodi/9xs4fyWaAnyPO2JphkjvmaXEyLs9CH8vKCCTzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779381052; c=relaxed/simple;
	bh=ZKI15aQmN28u2scIcpzPqL1zeTM+Hb3RPZc53wF4/dI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cO4fvfXOWoKdFUHt7dYeO/9WuoWY1c6eSx2TbMuf+dKubSLbz6xBmWN2D0zQ7rnsDkPVEVREfgiQW9wH8sfsAoUiFgQ3vwzrJb+p3++7mjxLVQ7QeYWRcc+SbJs11RXvPucun/CSC7v3KPprEpOOcdEYPavkmE8nVhOk8QjRV08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=exDY0JJ3; arc=fail smtp.client-ip=52.101.69.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m0Jq3IJ2PZxcI2idXDJPqg7OC4chON7PM9yeVYYITptjSuiSj/HXtPpBJ1YOGNLdFkpQH4RmNZDBrCYDgFXeyJ/MettC8RjpKolEDT7RU2DpGGUY2Ggb74m5eHnsN3T4ccWyRvBbDYibpV5Kdt6ElHwCfnwBK5EgcK5XcfgB5UHbzMi9nWufV43xsSTXHEdh7XpK4cYhH71jGGnkeqnX82m0hKDSqg3cg6jDN6TW80ljYF9MEKO2a1BXhur0ST2uOjnD9OvVU3vIancQmqWkNDIv3AIHZAikp8RFg14BB86Ae0NgxebnlvoxVBLaLX4whoX7yUSlPt50RgIugJOeUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/yyJc+HUjloXEGvj/X4sg/IXAaDKzHnnCPKZNs+jIbg=;
 b=ZF6T/0J6k12PM48I9FLH/cEqptj8DlCLIdKjhR8mREA7tnxXtxFjDRwF3ALuwA8NfaxIgW3CRui6GcGAgf996Hw4V3jhnhKRxcI08eJkoZXh+QO6MunVrjlrFz3tDLoGMUE8/rERCkXqX28/Lt0SVYvI4hz6yaqEFxnzHp2GZa9gHRmOyo80nR3PuPZcRspnXgtAigRK2y/y8kXIg04BzGzlD+G9DMX/Ufx3ZpkLjyG8oQc0DGtvYU6Gw9RG+r6RUL1D1s9R4HSwlIvsWxUbO18FkqRqSEWC5gYV4DZWLglkzOH2cvqfX74ahFZeft5Av7tBjoltdtdfryJCdN+FFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/yyJc+HUjloXEGvj/X4sg/IXAaDKzHnnCPKZNs+jIbg=;
 b=exDY0JJ3Yxzg/G+DHThR1qnKuWMXmCRj5YdmQUpJwr052DScy4UjJ7rg/e6IQnpmJkdgK5kaxVxOWxQlJ6NSyENUZ66MIENNBnzEmMAtUIZtXIRbYnv9XcTdSqwCptpIGSYIKqya7zS2RaiZ5buqJGMxlJdE2jOSlPun3SQnGinClLZPFwy5qnQXMP5JFdYJwDfeMluLlL3fv3/c4xtuK1wy+pms8pl9n3P6KM0PPVB9yiMOvG0fyeBD5JppAYTsKawMJ293f1Dab/Zr5/pJPuWxK5I/H9Ac7Ig32J0/Mm4oxVk//oBLkMV9uzuTDPW4vshkoThi9DzeA4fZ7dDJIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by MRWPR04MB12306.eurprd04.prod.outlook.com (2603:10a6:501:85::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 16:30:47 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 16:30:47 +0000
Date: Thu, 21 May 2026 12:30:42 -0400
From: Frank Li <Frank.li@nxp.com>
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dmaengine: mpc512x: fix dead empty check in
 mpc_dma_prep_slave_sg()
Message-ID: <ag8zMqEg-ucj65dc@lizhi-Precision-Tower-5810>
References: <20260521144755.3476353-1-maoyixie.tju@gmail.com>
 <20260521144755.3476353-2-maoyixie.tju@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521144755.3476353-2-maoyixie.tju@gmail.com>
X-ClientProxiedBy: SA1PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::6) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|MRWPR04MB12306:EE_
X-MS-Office365-Filtering-Correlation-Id: 511a491e-9d8a-4275-caa0-08deb756506c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|19092799006|376014|1800799024|366016|22082099003|18002099003|56012099003|11063799006|4143699003|5023799004|38350700014;
X-Microsoft-Antispam-Message-Info:
	p7L0SSmFycrmkKmBiKBJddEKND6vgjLacA5VoZsgUMQqF3Cy93CxNDrnUS8v0zfYhC+PirjBBr0boSZvcynRNwsjbylMcSiobspmvw5qiWLQDZpTKsEkqqfmTLX7lIKs7FLthQhhnSFIm06u6BIWd61/gOFBxFzHwC9Tx8GXrfSoc3iwpvhuXfys3+j5ZKdqgrbY0vGuZ0jXgZXMrW+o4w1OL8ty8iepWEm2fezHPEfwx7TpqgQ82XV8C7iOXtyP36LFntmpPE5L1gt0UyXGY/TzFUdDMv5naxcqVTbjJXoYK5byKWfvx8vmgXRgQeXN8SMG3tv+1hYb6GgQZZ0Sb2sAj5/+AYPS0s8zKJF5UTWn1ujrn7Z6QP1qWdZ/4z2KAaqcVZeCdUD4FFCygtVTeIPpUw897c1z5FqgXNHBlhTV3B5CNOFGXQJItE6KDx3xDFb8H6DrWZyA02zMwCql28dFHTEfDLbf22i8hpuIu327N77QlhfXAlikYv99CU93OlX5D4I38qVFZpeEcL86Fn15DTzmJqyuXQ4zDJrMxwMowUTfO9z6tR7UlcsEZowH9CuvZL8AB1mA8CJ+trOqU+gyxE/VcirVCKL+aSR0VHKyyin4aF6NF04OBzhTLdFDSKjKqBWAVG4aew0p5KVoecrNzkgCOeIeDTUQgyZSQnVD3Zfw3Z+z4I0+K79DaORGxNmhc3KYFhKfZSsx5totHDlrA68xm2o33Whnw6iTGoo+tHF/Z6tbhhLoxSa2IhMm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(19092799006)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003)(11063799006)(4143699003)(5023799004)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8QT1wMsOxBbLjjNS5ufUDM0m3bAvjcgAK5d31yjg/dJgH1mNTcMkI+ohCJ7C?=
 =?us-ascii?Q?Rw1opOSmkGtgWYbucChjSsgfhV2qhdB09bCBzEzZ5GVDLkYHmziTqNtFyVC0?=
 =?us-ascii?Q?QHb/PB6jp4WDdz776ckFkUgQb0WqrQqY88ubiZ/KSh+r8AcB/oFD2t71gSyG?=
 =?us-ascii?Q?92GfTd41ZrAIN4qvvB6Ox+2QTA0xvjtoduIa5daldpbKKMXbl/5RMfpwljej?=
 =?us-ascii?Q?dJ+hIIwCtdzbISirGu7c7ZNE40uBnyQFVHxkZ9/BhmMm3aYY7wd12EoAbncv?=
 =?us-ascii?Q?vfM4NIjQS59YVkXB35K+Ynh7AboC6pyMGOrzeNFLvqJ5WmVpzqAcHouVkT58?=
 =?us-ascii?Q?5ITobvkK58OzwIXPaLPBtTc1qJ5OJaai7bnZ8MY8Iiy1eJPubUTZyTfuagsq?=
 =?us-ascii?Q?I15wFB9cbjSfhuSTvvwSj0VMlJo+QS+RfczIOQTy7kB2tadqxD4iQed2P6N+?=
 =?us-ascii?Q?ttVliQCY9sfd8lu4SClFHNhIcJqUGsM6j3ZU+lziStHjVDuD0PMfAi2A3DQK?=
 =?us-ascii?Q?a9Z4i7ZqJoJasvGK/PhIKwq7PlOQC44DmSwdVuqbnc2ln4Hr1VgG6dva7slb?=
 =?us-ascii?Q?c7oFmeSyzM6JW4ugSe4zAX7ltoWKDweajy/igVZLQtWp+Opcw4uV+LWhMfbu?=
 =?us-ascii?Q?oCXAxS7OeyWkJnl85Aftjw+JyJRYBLSsD+8RPPTvtWFlVIKss2NV6cXUCe85?=
 =?us-ascii?Q?wC152tleLs1MPSCZfptwHAKEJ05hir0VXNfiltLBW8FvaWE5FkPqkxOWb9Ff?=
 =?us-ascii?Q?MiSorohdMCTiuM69qxtFVWRKgRh6kwKa+hrRD0Qae8FvokvigJscleYu2wGJ?=
 =?us-ascii?Q?xFuxowIFV32fAnUFa8URoenwQC6v+im5/dV44vidsdBm684sJsIJf+LNyrS8?=
 =?us-ascii?Q?v2xfyymM4uVHRq9zOG5df3M3K5U0t3UoETapIji2vXETMnSQg67Wc9jfeCT5?=
 =?us-ascii?Q?eGaTd8YI+1EQHkwwvvKd34Vm3TDCEZkoXhWKgO/9V238cOT1U5dHSf2hVtyM?=
 =?us-ascii?Q?3J8qO/T5KbBn1tk2GrjSk+jbt0Gj8mZiu592TufgvPRTZMpiYNh/fh/5U3rs?=
 =?us-ascii?Q?qE2YFQz0Rge0Z6X4nTS8bZ2O1+0n2JboiEsU/7T03w1PLGdZmlyoAv1T61bn?=
 =?us-ascii?Q?i/3RkI+ux1Sc6OZccy8AGz1U2FdMLDcIaHAcYiW8kPGQFQciDwhrdl1Rd+Vn?=
 =?us-ascii?Q?vDshOGbH8OY4Du4BqaRVmPOcRFfskWpQcKFWdBtXE5g2QHX7mbErj9d3crPc?=
 =?us-ascii?Q?8CvVxz8ddSofdlumBOE9c+QwjClHSlR/7w69dGgNtCtGZIDW6fLaWrQUV+fF?=
 =?us-ascii?Q?ReYdjpnSr8u4bWv79D90Y/NwODx7dUX1GvQMJp5bu1vIFazXqlPo94BcRSXN?=
 =?us-ascii?Q?OAFoOZlvwaVwZtwcYDcAGcQWAZFXdlPh4dSxI5oIUvNzj3wyuz1yQyBOjBdg?=
 =?us-ascii?Q?KK7IZUXU49CvFf3GksqLzQmtxnGkN6cT11NClkFa4HaCoZBmcGIN0ZoeZwfd?=
 =?us-ascii?Q?4dFs8URzduhww0buhfXhfiuDh3mYPaB1tnWLi1vGxFvRLaL6XFORgfs/Wd90?=
 =?us-ascii?Q?FIuIHMwyf2NI+JAWtqLqr94MinTEfO5V69XzcrcnpPwe8qogXQfN6Tq2dMZx?=
 =?us-ascii?Q?Dkc737a9kf1u/kOM0XBBmIN/bOW53Y1iEVYwbBVJg6WvW6khm4o+ERHjUWLf?=
 =?us-ascii?Q?h3AD8BaPTcar0GLlw7c6lcCFEVslAP/P9kEr7zhz2Suwu6TgzOwO8SDRLFqI?=
 =?us-ascii?Q?B46KnsvLOA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 511a491e-9d8a-4275-caa0-08deb756506c
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 16:30:47.8718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lkEC8S6SuiIScVK4z0QXzFFDH3zfNCWnVrORI5YxBOlzH7/9+3eRy/TnpYalNmQtw/uQCixDGktH68/BtVxcwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB12306
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10702-lists,dmaengine=lfdr.de];
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
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 63BE15AA4A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 10:47:54PM +0800, Maoyi Xie wrote:
> mpc_dma_prep_slave_sg() reads mchan->free with list_first_entry()
> and then tests the returned pointer against NULL. list_first_entry()
> never returns NULL. On an empty free list it returns
> container_of(&mchan->free, struct mpc_dma_desc, node), an aliased
> pointer derived from the list head. The recovery path (drop lock,
> scan completed list, return NULL) is dead code.
>
> If the free list is ever empty here, the aliased mdesc points at
> &mchan->free. The list_del(&mdesc->node) that follows then runs on
> the head itself, corrupting mchan->free.next and mchan->free.prev.
>
> The free list is reachable empty when the descriptor pool is
> exhausted. The author intent was clear from the recovery path:
> release the lock, scan the completed list to free descriptors, and
> return NULL so the caller can retry.

Nit: You can skip above two parapraph. This problem is quite straight forwards

Reviewed-by: Frank Li <Frank.Li@nxp.com>
>
> Use list_first_entry_or_null() so the empty case returns NULL and
> the existing recovery path runs as intended.
>
> The same shape has been cleaned up elsewhere, for example in
> commit fbb8bc408027 ("net: qed: Remove redundant NULL checks after list_first_entry()"),
> commit c708d3fad421 ("crypto: atmel - use list_first_entry_or_null to simplify find_dev"),
> and commit 10379171f346 ("ksmbd: use list_first_entry_or_null for opinfo_get_list()").
> This site was missed by those cleanups.
>
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
> ---
>  drivers/dma/mpc512x_dma.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma/mpc512x_dma.c b/drivers/dma/mpc512x_dma.c
> index 0adc8e01057e..f5934136efc4 100644
> --- a/drivers/dma/mpc512x_dma.c
> +++ b/drivers/dma/mpc512x_dma.c
> @@ -706,8 +706,8 @@ mpc_dma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
>  	for_each_sg(sgl, sg, sg_len, i) {
>  		spin_lock_irqsave(&mchan->lock, iflags);
>
> -		mdesc = list_first_entry(&mchan->free,
> -						struct mpc_dma_desc, node);
> +		mdesc = list_first_entry_or_null(&mchan->free,
> +						 struct mpc_dma_desc, node);
>  		if (!mdesc) {
>  			spin_unlock_irqrestore(&mchan->lock, iflags);
>  			/* Try to free completed descriptors */
> --
> 2.34.1
>

