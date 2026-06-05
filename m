Return-Path: <dmaengine+bounces-11218-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id czsJGKZRI2q4pAEAu9opvQ
	(envelope-from <dmaengine+bounces-11218-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 00:45:58 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C145064BB37
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 00:45:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=bHCT3aWz;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11218-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11218-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8746A3012C62
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jun 2026 22:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DE73D4117;
	Fri,  5 Jun 2026 22:43:47 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011061.outbound.protection.outlook.com [40.107.130.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C9F347503;
	Fri,  5 Jun 2026 22:43:45 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780699426; cv=fail; b=K4bV872OnXCbNZgNBRB/x9zEiqPypQZ2HByE3BfZtculKHEYMp3Y6mYqes1cXUe0xGkNgaRTFoBMk9y4iwEx6/NvWbJck9wn2vtHWyyW122ulvCOi0ZlYh5NWxY1pmPnXE5DzDlS5SXG/rM8HIJGVUoq2sf4PaCXCOfHiNFJo3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780699426; c=relaxed/simple;
	bh=61dFwS/Gk9C2BXwXYn/g+jPjr0+yLpLVDopJlkZjXWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XASwD/XP4+30Dvy9VrrJ6UMVRxIKrkMMQ72xp0RAi7xsEIP0OS2TqVgAU1RZgbxVJw3LM5e8tPmmk0t9rs5gqpbGHGPTb3njlVKHPMwDsF3YbMn15wQrIJM+lR6fWWp7weIlmTn0fqqgVuvG0syJbJYOocIrTLB27HA6zlmYvJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=bHCT3aWz; arc=fail smtp.client-ip=40.107.130.61
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q/S7nnmuZ3wzRZUkiNkJRg5/UUfo36QFdi8bnGwEZ45QLUsMDFNtq4OVWUOroxBrwGBicGBS2fpMDQl+gCbiWQrNWC/LFyhE1tKzm3W/86MnUHq8wWquCRGacrpjsZ6YoU/HjGRXneRgD6u+EGvnIxcBS/Tr8TdkUJVCNsOJT5Sr5mtKUlDI1i7YenaftU2FJU+V87ynQ2kDkDszW4OVJtziEtXOf+NDZD7ig19zgGnmCw2q4Yo+2Jq0FGqD94fmOeMtQmo1h+WZH+XkySJ5Ozvhz6NoTfkJTN/P/TRM+mb16EghEtJFmoTQqm6Ew1h5fHs+ftgap2JuKDjTgljdcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LKPnhC7CZhTHdEZX648uvSIelFl+wgRAFquwHFdE6rI=;
 b=UCiLthUdyAVEmRJ9lpbAW+U+NZ9Nun4pqdiv1FipNGCrxxb17KvbdJlj+jYmW5sRSbyIBP3rbPuispsSmQQirIoZS2rAuIgmsXtjbQuJwCL1t6l/10xcgR7C7ZnwdoqwQQxfZKXOpT7dijNy58gQkSJJvVDu6exyiWhE+VtJ6+SV10Dw+kqK1p/34n9uv9FxmZTILQcBLUFesyMLIqkH6nofugh+C/JaEHWv31WsxwChtfh/2N7c1IZNblPQMZEvCEfgbIS/aDLgKCSaEvjgohYa+tZqypE1Ugufkt40zRhM0ZHx4oyCFB4qKcqV3G6qNeYafyx2+vo3erzst7mNyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LKPnhC7CZhTHdEZX648uvSIelFl+wgRAFquwHFdE6rI=;
 b=bHCT3aWzny7Oh6CZthB0Ecn0RuqNREY5zb9AL35AQiGukrUj7gRpMErVEMU56Ae4VrNA7QNqilCUga9sVf8gVf4im81Rpd8oXKUPa124I8KUt6zM3Gnva8fveFrMi9075b5jJP9XC8NK1VJSKSHiPqx39NUnHVRh09dxT3JaimQuZ9C2Kp7XjdYGvZUK7O8ZzTNOzMTzR/YGt6V9PNQokpM+wA6G5kzcHC5WcfRqqWNNYghKMPBunrnKXHrW/C8wxMpRkRTcRSNAH/QF1MER4L7Ipw7RD2jnngRBuw0v6Ph3bEKKK3UxcgVtRvKDle7CF4spM81ZuXQ9AvRw1uvZrA==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV1PR04MB10535.eurprd04.prod.outlook.com (2603:10a6:150:204::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.10; Fri, 5 Jun 2026
 22:43:41 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 22:43:41 +0000
Date: Fri, 5 Jun 2026 17:43:31 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Zhang Wei <zw@zh-kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:FREESCALE DMA DRIVER" <linuxppc-dev@lists.ozlabs.org>,
	"open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b" <llvm@lists.linux.dev>
Subject: Re: [PATCH 04/10] dmaengine: fsldma: convert to devm_kzalloc and fix
 error path
Message-ID: <aiNRE5slgxecePKf@SMW015318>
References: <20260605220134.43295-1-rosenp@gmail.com>
 <20260605220134.43295-5-rosenp@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605220134.43295-5-rosenp@gmail.com>
X-ClientProxiedBy: PH7P220CA0157.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:33b::23) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV1PR04MB10535:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dccdbb4-7837-4b85-834d-08dec353e403
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|19092799006|7416014|1800799024|22082099003|18002099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	8jwuZ47r2k1C1/GVDFIENYCJKNpWfX4RnTW61sx6bdkHlT7pJbV9NKfKMKwjfJrAs5UJ9/WcRcwNH+YSekZX6szYz6vNLNe029QU7tdBgYPUDB7UWMTG13aKQPz3ZNGr+BSNvJr6pcjIsWSsUFiq9F9qb2Yzr0JVcAP/CG0zRLq5prZlBTxtUvIKFT4rlNsYamapkzOmP0dTg9WKWh8TF+N7KKLM8MvK9DN6W8pOv9V6pNert+1MRhnU0IXWH+yv876Wzfa+DD879kfjPvpqfUnCjawtYHqinghMqcP5bFCLBeWljHpVYk1CYf1wTYmAhzVCSCSEWm9qjmcR+EoR0PYkCuL1Ti1CqwfXBmk52QK5urYuFSmZVdAE6v+/zclurn5Pl/FazuRI/wdZn/20q0YT6PUXdlrNfx4mw6mWYM7EzQ31kdR1PrS41g+WkspwmgTKmyiKferiTfMOHJlCrXnZaSePQomNoe3hs23dc6PaJeH78glx3+LJhoDDdHnL8/yn+4b5z9mz+GQ+QyUKn8yb+v6LcSnzHqggflmFJCrnHw55jvHBEAWvlDRKQwI2Pb5hoMpmC2y6myXyHBuKOIzH7pnFU81H3JjJgnaisWL5fPN9qHS0FzfwLz218zLinXcbHhfQ7aL1wEvzo1VPmP21a/qyNkhPyRSp4LsyJt9CGILLKegaZPO8fcQLcZEH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(7416014)(1800799024)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P13d0Bp3oQ8FZTTiJzUORN5oLhU+grnhwf7X4FGeT5QL/Y4b/ffu9FEooBJZ?=
 =?us-ascii?Q?NdWi/9qzNoXkPyjwTOydi0wElg1ErarWt14HEsidjsaV2ydmhLyeKuDYuE0v?=
 =?us-ascii?Q?RINu3oR4qxblM8/OnkWsPmmcsjTmgY5OHjyeUWykJ4JvndZ4BZ3Z4NpamK7u?=
 =?us-ascii?Q?l7wv/JNjEjGDZTTOuLRau4GI4MbgWJmaz6+9awPT5xR7+rewjEBsslGYN77p?=
 =?us-ascii?Q?JuiY/ZGB/WwUewQ5Uh3n8rYHk4Nun/34RxZ/FchManEMJAhMcQTeFsY08UjB?=
 =?us-ascii?Q?QMsZdIuxAMOfEZ8e5UPkgtXmTT7t5lwGmXc1Wsnr4ONQpYbIoIN30pFtLNPj?=
 =?us-ascii?Q?urKgJnCjL9tj1/KBh3sKq1ArO+VLYVbDQ5f1P57XBmILd3wMk3fMiV2w/dV/?=
 =?us-ascii?Q?zpNh30s4er3dL8PuxuC2GoF4PnvDRgkaOfV+O2Zhrs8Vpi/VUtlMOYEMIYsf?=
 =?us-ascii?Q?rhctsvMEoiJr9vq2f1WiWLTiQGFOEu6ShSbfCJzY9ilkJGF3rSrnlXxmPAEa?=
 =?us-ascii?Q?3IlOnpbGw9dpGDRGdLIdt/q3geWI8GhHD9LlkPt7asVavSQYR5JzUEI1SBmG?=
 =?us-ascii?Q?2BGANEv9HSYtAAwwEO5Uyo0k7bxUg0Iu10CnxU7Fsk8j4bCEF7h+7mdpPIaL?=
 =?us-ascii?Q?aWYL9PCFmTtT+jSc8rq/7LxRdsL9u17GxyX3/+FJpynoaF8tlEuTEx2KUJu6?=
 =?us-ascii?Q?jqR2PtDkURFlNxTHkZSKl6B56cM6L1UWTZD9UqW6Fup5AtzR27SocBq/e0rB?=
 =?us-ascii?Q?4TvD+6pg7aL9p5j0J7r0EdWToC7vhLGH15VZQcZEXcyUbELhxrR8w6NePvM7?=
 =?us-ascii?Q?KE9jMMBufn3vj7PNrSvb7/QJ4kkbEmcDgp1qZCk/ZxglZ176Uh83flfNm6g7?=
 =?us-ascii?Q?P8jCA/RwDIvX0Eih54CAayb9LVxQiF36PWGb8TfWK7mr95iN7/TiF8MUSTQ9?=
 =?us-ascii?Q?bcE09BIWfEcgv6hmkClIkxOwPyPtcMS8dZduRUrUMkP2uy2IODGvfbhsIQ8+?=
 =?us-ascii?Q?BZlkAPuxYcPIgSniMn90fAQ+rbzxsguQfyvV4wFr4dq9wjdX5fJFlryRVTxj?=
 =?us-ascii?Q?K25uWLxlPZF02oYJ85fIjWdvQCX8l7DO6Io1C/DI1LnQ8ajVY+7Ni5G525bx?=
 =?us-ascii?Q?XfGTAMLsm3hn3Avn8G3gjVIfLqi17LW+NUXmiuUfDpkmykHkfSTUyHvvncra?=
 =?us-ascii?Q?lA1xogwbpwN5H+qeLbIRZnkk5AhF3LNmoaBeEi36QsTS/6KPwKgKJGtV8sPQ?=
 =?us-ascii?Q?Wptb2lwfDgVQ5fTOqTro3xMmEydKdkCuW1mOtfBpVyAayaWfHwD+oVyG3SSg?=
 =?us-ascii?Q?6TyCD0/zyRV6CyNpbNHGMdRXL18f9Ivw1Ln6YyAC+9x6eL+W1Dk7KpUApNRk?=
 =?us-ascii?Q?ILBz+VsIGDyOoePf9tGC3Iunq46zYbqlhL/evnsYOIcR6yYY7QBTghhDK8dU?=
 =?us-ascii?Q?MS//r1rUG+TRpO6P8PjTNi9QklkefO2oyi7ydZ4ha9Pos6DEHBZ5Cq0XyA2p?=
 =?us-ascii?Q?EJ1GGZGT+1hR31zHepffW74oQ79getMC6mBhLJIwQ9ttDmuFe4Hbcx2m/BtU?=
 =?us-ascii?Q?MfL8unObnK4e562lf2ldYB5PKag8VS1fZ4fEgsyGg5BsUUvgRcZhbNDONm+4?=
 =?us-ascii?Q?Y6w0MjdUySU8djms9GIbwalx4vhyk1biGrOE7tBACiUy8rbY4sm7KvHdVrws?=
 =?us-ascii?Q?Ry/Q/hHFiL9l5vROUfSSU73WTCy2ACVTT//YdvcWJGjQYDDbvoDZy6VvfuCV?=
 =?us-ascii?Q?FrFZ88C3xnMGrvXwWSur/2+dndrfD7KWxHaV1yIEW6mIKACHgc6t?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dccdbb4-7837-4b85-834d-08dec353e403
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 22:43:41.1175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y8Bbsw16ggZdsGdTDkr0ZbfC6ThDxIS7R4o3M2JvAEftS0g6FM2k3GX0fdGtYGE90LlYObEMBFRwn3/GxC6lcHYpvqvJoNVeHpjr0uppsrLTTCBvzP7JEB3ih1GHfLPi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10535
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:zw@zh-kernel.org,m:nathan@kernel.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:llvm@lists.linux.dev,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11218-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,zh-kernel.org,gmail.com,google.com,lists.ozlabs.org,lists.linux.dev];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,lkml];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.nxp.com:from_mime,SMW015318:mid,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C145064BB37

On Fri, Jun 05, 2026 at 03:01:28PM -0700, Rosen Penev wrote:
>
> Convert fdev allocation from kzalloc_obj to devm_kzalloc to simplify
> the probe error and remove paths by dropping the explicit kfree.
>
> While at it, fix a goto target mismatch introduced in the recent
> platform_get_irq_optional() conversion: goto err_iounmap should
> be goto out_iounmap.

you should fix it at platform_get_irq_optional() conversion patch

Frank
>
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/dma/fsldma.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
> index 0d28f8299bf8..2efa16d12679 100644
> --- a/drivers/dma/fsldma.c
> +++ b/drivers/dma/fsldma.c
> @@ -1213,18 +1213,17 @@ static void fsl_dma_chan_remove(struct fsldma_chan *chan)
>
>  static int fsldma_of_probe(struct platform_device *op)
>  {
> +       struct device *dev = &op->dev;
>         struct fsldma_device *fdev;
>         struct device_node *child;
>         unsigned int i;
>         int err;
>
> -       fdev = kzalloc_obj(*fdev);
> -       if (!fdev) {
> -               err = -ENOMEM;
> -               goto out_return;
> -       }
> +       fdev = devm_kzalloc(dev, sizeof(*fdev), GFP_KERNEL);
> +       if (!fdev)
> +               return -ENOMEM;
>
> -       fdev->dev = &op->dev;
> +       fdev->dev = dev;
>         INIT_LIST_HEAD(&fdev->common.channels);
>         /* The DMA address bits supported for this device. */
>         fdev->addr_bits = (long)device_get_match_data(fdev->dev);
> @@ -1233,8 +1232,7 @@ static int fsldma_of_probe(struct platform_device *op)
>         fdev->regs = of_iomap(op->dev.of_node, 0);
>         if (!fdev->regs) {
>                 dev_err(&op->dev, "unable to ioremap registers\n");
> -               err = -ENOMEM;
> -               goto out_free;
> +               return -ENOMEM;
>         }
>
>         /* map the channel IRQ if it exists, but don't hookup the handler yet */
> @@ -1313,9 +1311,6 @@ static int fsldma_of_probe(struct platform_device *op)
>         }
>  out_iounmap:
>         iounmap(fdev->regs);
> -out_free:
> -       kfree(fdev);
> -out_return:
>         return err;
>  }
>
> @@ -1335,7 +1330,6 @@ static void fsldma_of_remove(struct platform_device *op)
>         }
>
>         iounmap(fdev->regs);
> -       kfree(fdev);
>  }
>
>  #ifdef CONFIG_PM
> --
> 2.54.0
>

