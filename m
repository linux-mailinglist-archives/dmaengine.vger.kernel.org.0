Return-Path: <dmaengine+bounces-9131-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIFGOVFooGkejQQAu9opvQ
	(envelope-from <dmaengine+bounces-9131-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 26 Feb 2026 16:35:45 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 454A51A8D10
	for <lists+dmaengine@lfdr.de>; Thu, 26 Feb 2026 16:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6450932B9CD5
	for <lists+dmaengine@lfdr.de>; Thu, 26 Feb 2026 15:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4783ED114;
	Thu, 26 Feb 2026 15:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aehyLZxO"
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013011.outbound.protection.outlook.com [40.107.162.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4223ED10A;
	Thu, 26 Feb 2026 15:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772119207; cv=fail; b=Fa8LyJamQiMW4Tcz/XT9+eiBn4nfZyBslvOKQ94BAy5zuKJ1McAOF0/zAhO68kzMs/yGNm7sn3VdU4NUJef8J5FjIsN5szW3/ojfy1Faxf1a0W/As9UYzCex4/xQVhLpClf5PdM4iPfVsF+2KnI2xmyP0sLvVpA0MosZjLWwUNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772119207; c=relaxed/simple;
	bh=2hjqAwD/toIpg2ZDnedHUo+qpf5HSFplM76rVOzFXDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d4PFAvRfTsQV8xohkfan0pK23si8A99uh49lWGTIwQnRiNS5IHvn7JJSCVn+DL0/cLtRGG9s35GtCnrX5lPA5iU3cMOPlD3xPksc1QpmF7ircDPSW8JgDpxz5h6l5lG9jR57lcl+c0QoCtlWn4mtCmabZq/K29m7RoEC9EJ5OoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aehyLZxO; arc=fail smtp.client-ip=40.107.162.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z2ZHYO/vX4cEa95iZNXQyXfzJVHScRVZ1KrUtWBC3PhwnVTxp8QL+uquKZDuY7bKmemXEVusVBao3y4Pm+oeN7l3Ub3bQ32Uy+IL1DYu8B5f1jf5zO5QmFM3hsI2IjPmgPUTNhjPc4hCNNbQXV1NUlXOSfqrsApDuY3jlchCRFSSwjTmywPRDd31EJIIRFMr6E2Ce8BoplEe9Q3raA5G3JnRiEazA6ziP6bTFaleOOKwO9HCX30J6aemrp/deTvh1WC+hOQdkKvVVW+f2eEkDEXE63YaT0zdOhTVGRyez/UtecrQXEoY5Mb8yoAW4FkQzizcgCv41cs7CSm/kVBkig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ykm5irBlH73U1C/g9DI93s1gkbFWzhYlRGjHsdqjGhM=;
 b=wxf4QN/fgiJOQvruj9y4RGt0arjc6W/pNgW0CYx3GEG6nLpLib9bV3nSYQ5llFD6T0ZqqglH5lqgKH1Eu5tPEdTLUaWMG0b0QrjSjrL8SihPICodqTuyH+XTpaOtRvTFZT7CeUL71Tq7a1AW3Usbqzj/PyUpkQpZha+0r2shUGsYV9vsADEsSPSseYEKcmzDkS/8OZO7ooNBx4+Rhcdr6H3LH/IbCtMyzN9m3uyY7No+yEC+l+aRe2wWMOJIXS1Wm8ebJEctP35yEJNkWaNMJ8oS/98pTxjdkjAnpO0Tlt802BPAsbXAEDIgq2wS0aECPPgO6bQdinkStV1IcsCzyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ykm5irBlH73U1C/g9DI93s1gkbFWzhYlRGjHsdqjGhM=;
 b=aehyLZxOy0PAvvIDsdasa3KRkyCvCNf3hjeVXnOyQey1gjjNBWZpFeiB0cfFoI0Pq+Lh9i8MSKVyFCV311T6BpRwVxBuve6JmVbHTrBwske4Xsx2QbY2RCB6/9WkWY4YaWPpqmG8GepKinUTQwCoHc+LULhIrLXPxjbOiHo8kMCONsyV5gQUtD311jb4xM2WENqFCXVSk0KMNKkGI2sp388wQhIdHzHrwV9JOevn90R/0RjQt4YFQZv6C06xF6TRBEPDpaQhS/32I4fQcriy9qxF20mEebokmUHHwdL0i4N26Fqvonknv7AzxZM9nF5xddl8KLED0b9uw2+mw8ZCWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PA1PR04MB11263.eurprd04.prod.outlook.com (2603:10a6:102:4eb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Thu, 26 Feb
 2026 15:20:02 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 15:20:02 +0000
Date: Thu, 26 Feb 2026 10:19:55 -0500
From: Frank Li <Frank.li@nxp.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH] dmaengine: fsl-edma: fix all kernel-doc warnings
Message-ID: <aaBkmzEqLP1Qr7Rh@lizhi-Precision-Tower-5810>
References: <20260226051220.548566-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226051220.548566-1-rdunlap@infradead.org>
X-ClientProxiedBy: BY1P220CA0017.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::6) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PA1PR04MB11263:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c8263e3-bda2-41ff-0e02-08de754a835d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|19092799006|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	q02KrVAi1F+AQmkF/g/Ctxs7Y1vebA8lOCySzoXhcDYpEAWseZjuwVPE1z2Ni5zcM1fUkl7efrwD6TVGfgdO9o1ckVdVpL67U3vf3hBhpwGf9XALq5CjaUPUh8Cd5b+1uQZbETMer16Uw06cY1oPXu3tNJ4Mu/sXrAACxKbBUtLt1DNQv+CypwlmrwrBhQ4F9ifiqOQAYcWIaetNCojncI4sQRDlZgPWj27KxoEVnA2xZqjWufF/KND4H8hxF05QaVLw0VfRvb5fWHF4BhazRyWJ7+ff2hJ09RWQe+dFNdhxb3ZlSv0JG9rQ3h/3+wdB1cXwlILzSo6e3iFeJRTQh9D3BMCI1AYFJ6kNUuOwi9l/o1vv2azpBrlZGnogQ6PlnTpHLWCSBH35tZ+9L87X9W+UGHFYgBQgJkP0ejfRoqOgWOioCgJOgQwSFFH6msY4ypgzZEWq3e3hE9Irx86jTGe6Ae8hArOsWYwbL3+DWotdwm6mD8v2aTcluQbSv1HZLZnhM3P2VJUvP+ZPNKsL/GCKQElBffOQzw60d4HC/g2fIsCusIMpJAk+2HfHUVAM/w3GLKq6puTKqdJfMrKHZ/N6rNFsbBROigVgh/R943jyY2ybPlPuUUK6pyRDQDzW23W18s6azdGqzQ+CuO9AOG6AStQblBuxeXiKq7wZdXltR3ZWVz13E5K4qyXz3xeKc/dznTZ3pDnoBiDH3UrhGHl5nOvdXN6bkjpKKTudEFFaqM/L/PvZHANtbnCZYoOm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(19092799006)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gjUNPY4AgpszWataGr6KZQTTedQ7FBUd53skyzheVOMLhLKigXqXGHhOeqWP?=
 =?us-ascii?Q?IJR2nYBuZ5kU0ItyFHpIR6A+/sQWdjGGARVqCYh16OEprhk64HRp3lSXqwGI?=
 =?us-ascii?Q?Aoh42PEhn3ARm1Gb+aZc2IIiAT6SE1LcG2BQ5SNZ6oQhPrdUnn4B91Wd7fWd?=
 =?us-ascii?Q?zipWE8VvjnO2O8x4WLNi7iCMU7tgvrYauCmb8P6jR8zo+QByyML6cZ3Ze9OT?=
 =?us-ascii?Q?vUVwpskW+qwah1zvRB5cF+MX6TIF4ERVNnRBM32oHXuGwcQT4iQa0KMHEmGd?=
 =?us-ascii?Q?6OtMxKgmT5DqIqc7LoKGy6VHQjZp1mFwnr/y+6YNdSORtHp/TIoU0CVhBhpz?=
 =?us-ascii?Q?qquET6iPvRBadpmeZHL0Z8NKC/URw0dPTn2Nj6NiInxDMG/KXIoEnYin9P7V?=
 =?us-ascii?Q?CUNIAz0DRvwk4VXi+/jbYahz3KaiX76GV4gv+JoMVpBC6lCGPNg+EV2Eog9h?=
 =?us-ascii?Q?ub58f4sKN1Fym/Ti1JivqueDaTESuoVoVFDz6NCMlQzHFLxE0+O9QCu5gxYL?=
 =?us-ascii?Q?5iPNbdk+uz2NI2dWbJaBptvrWZLpoq4MID6Ko36KXil6tQ+nTVilNAdCxnJd?=
 =?us-ascii?Q?aa4cRtMoa++WELuZzdLBbCBXS5PmAuxZh4afXltqvAT38aFu3YJ7Tgh8Bg83?=
 =?us-ascii?Q?aWFAeWONs7xA/eeCG7DSNl3vE9rvxkMOpLmdNNvozeIr5SBRfketf26aRek6?=
 =?us-ascii?Q?mXeJ0AbbXrcrlxFCsFpBDqd4YJV6alZwGeDAeRMz+GMO1fdgQC6mhQuZBB0C?=
 =?us-ascii?Q?Y5yGS5dzS5y0O4sDIGR6GxQAbuYlcgc/Ek0nTI2hUHF6JoqrTltx4aDH64z8?=
 =?us-ascii?Q?LjYCz28Ijhkv8klZ4mcov39NHWX6Sh7tjDw3uoBYDunk9/rgrgF6Cy1NytQ8?=
 =?us-ascii?Q?SsSidTmXr/KP5A8mgJtlzXeWd91oVfuzmWH5clwYLaDL0S+H7KXac9Y+tG0s?=
 =?us-ascii?Q?Tqa7/4t1HCPSctUulZZ1+FB52V0rkok1a1KKOYGJtxc0lhcwxRTGRq1PtSgI?=
 =?us-ascii?Q?YMTdPnCAf/h/osNMBNkbrJbyuVPYJQyYca7rRfP3hWV4cQSXImhuuIvUcmD0?=
 =?us-ascii?Q?Q/gPwhQQYAsUJUmeTntq0Rn9bfJ12WO0tRHsa0B6bP1VXYtskDECQThKDh3j?=
 =?us-ascii?Q?/5lbQUQj4UScqrZwZP4llvycpQDOt3szPoJnPE6Cn5+d+MmiHWnvjqwfVTSX?=
 =?us-ascii?Q?HVIau0n+q/hYFw9R/McH/tXk42FBN88AluY1GZfjvboz1LDMCJiF1HJ1+5Yh?=
 =?us-ascii?Q?4mBVDOo+xXJEonYLqBQIi2Yz0erglGrAjySQZtfFiKzbaWsixyhpEqnqHJxv?=
 =?us-ascii?Q?tm42pNynGa9UuHUi3vrXoLZG1ILuec7pgF+j1V6H+s4OLXosZ4ekjNw42uHJ?=
 =?us-ascii?Q?Lv8WjGgr9fHDg9A2cpghTwcKeLcd0VTJ7QFbVHhcm3AcnXpR39+RvoDNG+As?=
 =?us-ascii?Q?B9nTi0B9cUBSOvFIIbvH03ehDWASQ4kD00oOB3WbaxTNFt2aB6WaPt8oKDaa?=
 =?us-ascii?Q?Q8seo2LGPOPkKM+TLjGpzBZxbqjX52M+qBedhCjPXk/KjyOomxrBnjFb6ZYs?=
 =?us-ascii?Q?Ep26UYdcVMi8005JT1wgjuyU3BM4g7D8lFrXUTv5/N9MVNe5XfWPPVri70HD?=
 =?us-ascii?Q?XdBCzgGH8DOxxEm5y4nZcPPVqu5AGp5zF8LIBuMDyjWKZR8RTuKs7lssZ5Hi?=
 =?us-ascii?Q?LsOlHZD1B4Ny8hV1T1DVKCRs+WLlbxmR6C6hyTJ8KhI31lyajwfbNdqxnGqJ?=
 =?us-ascii?Q?5JlTqjiaEg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c8263e3-bda2-41ff-0e02-08de754a835d
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 15:20:02.6995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w2zgkSRR/vxxyH6ank0C7P6Vz9HR1B7cZFSyNTT6T0QFxmksfHkol9pM9ladrrvuRow9D22JGDI6J3hwPoYaSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11263
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9131-lists,dmaengine=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,nxp.com:email,nxp.com:dkim]
X-Rspamd-Queue-Id: 454A51A8D10
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 09:12:20PM -0800, Randy Dunlap wrote:
> Use the correct kernel-doc format and struct member names to eliminate
> these kernel-doc warnings:
>
> Warning: include/linux/platform_data/dma-mcf-edma.h:35 struct member
>  'dma_channels' not described in 'mcf_edma_platform_data'
> Warning: include/linux/platform_data/dma-mcf-edma.h:35 struct member
>  'slave_map' not described in 'mcf_edma_platform_data'
> Warning: include/linux/platform_data/dma-mcf-edma.h:35 struct member
>  'slavecnt' not described in 'mcf_edma_platform_data'
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Cc: Frank Li <Frank.Li@nxp.com>
> Cc: imx@lists.linux.dev
> Cc: dmaengine@vger.kernel.org
> Cc: Vinod Koul <vkoul@kernel.org>
>
>  include/linux/platform_data/dma-mcf-edma.h |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> --- linux-next-20260225.orig/include/linux/platform_data/dma-mcf-edma.h
> +++ linux-next-20260225/include/linux/platform_data/dma-mcf-edma.h
> @@ -26,8 +26,9 @@ bool mcf_edma_filter_fn(struct dma_chan
>  /**
>   * struct mcf_edma_platform_data - platform specific data for eDMA engine
>   *
> - * @ver			The eDMA module version.
> - * @dma_channels	The number of eDMA channels.
> + * @dma_channels:	The number of eDMA channels.
> + * @slave_map:		Slave device map
> + * @slavecnt:		Number of entries in @slave_map
>   */
>  struct mcf_edma_platform_data {
>  	int dma_channels;

