Return-Path: <dmaengine+bounces-11384-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 46/WAvLEKGpdJQMAu9opvQ
	(envelope-from <dmaengine+bounces-11384-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 03:59:14 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5982D6655DE
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 03:59:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b="JV3nXzh/";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11384-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11384-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B38531419C9
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 01:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103E22BF3E2;
	Wed, 10 Jun 2026 01:54:14 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011023.outbound.protection.outlook.com [52.101.70.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66C433C195;
	Wed, 10 Jun 2026 01:54:09 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781056453; cv=fail; b=EU9VqS6ePi+RcH/zB30h5dWORtPNpssEN8RGxt3tHJ4hN5gDYK7ZYOfa+EQqRqnS6vYJdGkGNm/PNvwCsiyws0d9BE9gWF8cS7eQOt9O9KQy7HA6wv+h4hEWQsDiKuwDpGtKzAeXwASaIIxCNKfyFtn+w6OKUGK668DaZ+p1fTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781056453; c=relaxed/simple;
	bh=4YMXKgY50+lTF1h2ckTR3+YWVezx26wwzecxohVOXiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FKgOoCBZYVAqCDPTrpVq0nfsIPJjzM9j0Ead438JrOAuTeJrmzysgku2Vh138ZupDFlzkU0I6YAl2YmJaimuROFmqsf5LfX6p6qQrmTn/4PZDFqUKlWrop1rlCasu/pjkHiE06TpRVr6c9QfEDpcX4WNYWGd1EP2a9lk1CFbPOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=JV3nXzh/; arc=fail smtp.client-ip=52.101.70.23
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wxUrOD7uct9eWPKfC0KEMzS2MPr2GQSIwbpoJ5LYlY2Fl9RwYe1EAI/EASuhiD45J0Xdko2BU7l09kdWX0bO61cC3btDYh0QgTrORivrFp2tEkpkJZic9hv/ikTJuaJmF5qX1X5qty5/4i8eWuApb42edCQjj5ehacckrbQ3wIG1HTSSrYeSPjic5PDLkTm6isI8Y9s8JHRlm0FH6092hdIJBjx69mQk/iF6UhIEPshS6M/21U8tbKnV1wQSVIo/nVrrwkq0+f9anfKLLSUFBKbFCMk1VE1x/lO6MTPBWICIlJeOjgcUhUGiu/GOCv/zf+NmMX8q2lNckZxhM/Q8TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/7fNjcJHOzCHgLS24hGFpD6quFdomtH2wgEF6GLuJE=;
 b=Glc4vu0lcYZxCzo7eWXTFcNd9G3qJG/R0xMTesawHp5cVE9StZXh9RyU1EqJ2219rIXxErsC0zQdmcTvHMQfpcl0I29ckgabXY7m0c7MoMAm2z5Vac5gYVi0APcanJP3AwKP3XoyoADPzCCyst7wIXAE9CD7vHVZ0sl47tn3QnOvUY9XkAoIqQpq1RuJg2hQFZfCO2D9VIgzOOBkrBedeI2ZhhX4Xw2V16Ntg8lb0g2AGuRE572XhL5eIubxxaWGUGjb/6ZPSucFWszCmW7cRbEkZCYJWqsVeRkMhcbA/DL1c1k8Nkdf+8eAgSPmADTKp5PQyIwLzSe8KlWM2jgGKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/7fNjcJHOzCHgLS24hGFpD6quFdomtH2wgEF6GLuJE=;
 b=JV3nXzh/bEDV3xKrvn5YpZkzVAIC6KhYBX94K+n+tTmkznHF+isrraxHl0tLN4+yK8zcwOxyvqW5jnTgtJU86U83dS4OySzMn/rhLOYSD5zWwRNQb5i4bACDS1FK+lVdpxz2mQRxRAsrorSfDdui9mqg07apobIilkCWwyiz8hzRKkEVcV7H2zqaTkObXbBRZI4nrgtorBJExJo+dutU7mMGu1vsCOkIj2QohvU2lyHYRfkrqEyXZl2oz9WvlXmAbx9hN908P6FsRdznGoQLIttLVBtn/FgDyaEftndz3kAYF26AyOEbsHe1dLZ5p79NpuKlciN7H62O8VML17PCAQ==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AS8PR04MB8867.eurprd04.prod.outlook.com (2603:10a6:20b:42e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Wed, 10 Jun
 2026 01:54:05 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 01:54:05 +0000
Date: Tue, 9 Jun 2026 20:53:54 -0500
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
Subject: Re: [PATCHv3 12/15] dmaengine: fsldma: use devm for of_iomap()
Message-ID: <aijDslAqjvXl-May@SMW015318>
References: <20260609221926.35538-1-rosenp@gmail.com>
 <20260609221926.35538-13-rosenp@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609221926.35538-13-rosenp@gmail.com>
X-ClientProxiedBy: PH7P222CA0030.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:33a::13) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AS8PR04MB8867:EE_
X-MS-Office365-Filtering-Correlation-Id: 07c8d9fe-d097-43a6-f0e8-08dec693273d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|7416014|19092799006|1800799024|22082099003|56012099006|4143699003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	7+oHxjnWkZnGLNe+HRA/+/o46+h5a5OXRT0EWKNvK4FafbOBg4fr2hTRAT7Z5ezEXz+k8ouOK1IBkFHPDhDpwIHcf99eSm2U2iDWJO7MIBPwhAUrgpEhb55I8haH/5DLb3o+Q4qoysbAj6e1VWz+2nJNS3ISX9/OWTkLN3yo3w9gptkJpfs0NiAa3reklIpUoTqx093alGjRt4mBOA0S+WO1wkVnhdmZ7jU9zt85Zt5UbIAp0XU8e0YPNfY2UL9QMr1ek/VcTQziee8WYUSlE8TYdHWFpJMw8HD6BPfwPhV7GoX+fDJOvKDy2BYuxsgFBhxVK8bRP9cOiqcDTeQcCGjr2z3cQiGfhiuT4oj7J8K5klUK+ZW74mbZIrSsQ9//qvsu+9yhrFY0MMQYWL1WnWtXFc0I10QMmd9X2rLvYxyZfcEkIEF5BhU6tbTqH2gEULHYtJesjr6xw6ZXo0kWP5+oYgTvErfs8dEbpJQaTzXiaaXxcMl9wrgG3KDL8czfvx652HkB++2jnWMajC9Cfqc71RfNRhvt7OeQjonZODNmibvJ6k3vR4MC05xZ42Nh7YIPq+dUljjfIsgiSpy5caKRmGkhQMVKNvmWnRNsT8ODba1dqUa1jYkvNbC7YJYyfooUR0r89dTWmq17BgkMafOvPSk8dGj7mOe5GPhqBIYXkPE7Yv0/q1F4y27quBxz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(19092799006)(1800799024)(22082099003)(56012099006)(4143699003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BuX0GFI+2NMTUTFzvhizlZ7yjfdAyoikcDzgfygC0c1wCxTW1kRMWn9kLpjG?=
 =?us-ascii?Q?hWEVt7ONHT//gO8N/bpLI+GfhQPHeCQaz7hcmRMslT6g5/HJUufTirSbNIND?=
 =?us-ascii?Q?D6Is+9H/G9hOZBN/CICVNk7OiczYCMate8qS16IgFVuVJ5tCEb1ZEakiXJAd?=
 =?us-ascii?Q?4pbSJOSkOA7wB806iNI0r0ra2oZEOwwlW0K3X3NI+GrWwIbX12d4Sfob/ySg?=
 =?us-ascii?Q?zBN9S11alHvUzsOiR17jPhDg6LawkuzxjtSszE+BXFTxtEQNugAmFnM4K6fS?=
 =?us-ascii?Q?zNZxkOD3zmCETH+Xu8gG9btrMNyGpcBudXerN7tmX2WTK/y9Awa3RT4rx2sN?=
 =?us-ascii?Q?kfDXe9jx71sMaU/ytWDK/tGayqxMz3doT6VBqGqH+h7tyE2+uQV8MD2Dpdzl?=
 =?us-ascii?Q?6Mqs0VO0cyJXD3nYU4A0NoktmSSK2/Et9rgoNh6iEKT1gTA2RNLE466glKiR?=
 =?us-ascii?Q?ZlAcaF6+ys5qsOSba1NzBM8pPYXayUuARHNg7H9Tt++aj2O2EHQf6ZE6hdph?=
 =?us-ascii?Q?ThrHHq513fqi/Gbvv5r86gnspBosTKAVWhdqs1cvRf9fFO9S2TpkmySGWnGb?=
 =?us-ascii?Q?VBtqLt4gGvkKfgfHqF7YfHeaCk9+dMPCdYDquc3QPX1bsIZFbAJjTCBNftrs?=
 =?us-ascii?Q?nfjhALx4u0bNk+4/assk4/DkRWz11uUmCOEsR2EGqRr+ZPVnhArmVWWfaiWu?=
 =?us-ascii?Q?u6MsSr6ouZ0c+OCZ/P0EwPHThrxz6199sDnhOnvvowkWaLQI87nz2NE0KW6a?=
 =?us-ascii?Q?tbUMUtJUqgOBF/E47VvXO7mNKSiG+5c/UDQIDAK/9VlHOiBYhdNRYdVWu7td?=
 =?us-ascii?Q?LYyFDoTETKzneML3Jqc9DDgBBWkLUNLBJ+kdH9EmCXC7nvhloZIboy5AM8nP?=
 =?us-ascii?Q?MhGB7lZGuAglWqTile4U23ySfHth6EiSafV1y5I+iW2N9tQdjawPIW+YZKZf?=
 =?us-ascii?Q?ax6KMC8kUOSj4qlC9kKbo2lN+TSPf7e5IhFilc5Z7OuzhPBVhy6Cgr0TNSX9?=
 =?us-ascii?Q?rIE76Kky6L/KsKV0SwQ0MmdoRmiMMU0OLGVpkwWyKZtslXq/sEVA7XbTya8Q?=
 =?us-ascii?Q?hdUPomig7EbiIdUNL2ckrbFJrewvxF76yDl1a2xoeaWSVEUCekoqoNb96DSk?=
 =?us-ascii?Q?vZugNzrDsvWkjA8AVYZARrq27h8laVHsecgiuc6kp0L4FICLr324YIJVVchh?=
 =?us-ascii?Q?rpqnJeChLy4I9qmjraL+EYF8rkvtxl9UXQgrcTs/ccYmJSyErtr7RhuqdSHa?=
 =?us-ascii?Q?faDGBSrSFrZbw8j8EUJtNUXamk4jvWVBo7owomNObJyzpCb4O9Eq3aHs0veg?=
 =?us-ascii?Q?w9kPTDGqmEPKvpgqlGUnqazwwiwYQLvUltwcFnWz4NvlF47Ig8zcGClZDpg3?=
 =?us-ascii?Q?w7sKvQVdOx9QGv8uXM0bORcRgGzdW7WlchwA/s85g/hOSBNfV2xGCLEas4Wg?=
 =?us-ascii?Q?uGCe+eTyqjeek4D7+KPHia0f0UrWbM32+V4UcdyHzzUMkaZpAiVCGzweWXDa?=
 =?us-ascii?Q?uowzYAPmS0SWDwmw2NNiBbRDKBOwNjIYfoiJOQb6PkiSqkOExBeMElGZ/KB7?=
 =?us-ascii?Q?knGms+24bEEioUZQP6YcAvWZpjvCFmnyddNLAEXiufhplgodb4CLjzcXEuX1?=
 =?us-ascii?Q?Kv/ktxHdn/t5nmdap6u6RX/gGe/7MaMWnNEsqN78ALLbnoE9elKC5VQ1APUs?=
 =?us-ascii?Q?RsW0Ab/JiP64p3lzP5/OmOKR99ymWtA0SLwYfJPOBvS4CvP7gWPYJxLzLpiJ?=
 =?us-ascii?Q?cP7/qQHwwSbontCFpElR5Ypwb2U6ZS0RN97JxmByXYPp3pf4JUzs?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07c8d9fe-d097-43a6-f0e8-08dec693273d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 01:54:05.7002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6TPmMtXz0WAB1wJo01ez/vla938yO1k7xvAr+swEXjgNKtJ0+vvoqjOeb9YOHKvVVmx716i1nvEB4rKR5sG1kbqglN48DgBvuCi+XZjz42wsz5zM5KHSo2ook40z6IJY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8867
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:zw@zh-kernel.org,m:nathan@kernel.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:llvm@lists.linux.dev,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11384-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.nxp.com:from_mime,NXP1.onmicrosoft.com:dkim,vger.kernel.org:from_smtp,SMW015318:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5982D6655DE

On Tue, Jun 09, 2026 at 03:19:23PM -0700, Rosen Penev wrote:

Nit: subject: dmaengine: fsldma: use devm_of_iomap() to simplify code

> Replace of_iomap() with devm_of_iomap() for per-channel register
> mappings. This eliminates the iounmap calls in both the probe
> error path and fsl_dma_chan_remove, and simplifies the error
> handling by returning directly on failure.
>
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/dma/fsldma.c | 22 ++++++----------------
>  1 file changed, 6 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
> index 0df09789187d..a3792864f02a 100644
> --- a/drivers/dma/fsldma.c
> +++ b/drivers/dma/fsldma.c
> @@ -1111,7 +1111,6 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
>  {
>  	struct fsldma_chan *chan;
>  	struct resource res;
> -	int err;
>
>  	/* alloc channel */
>  	chan = devm_kzalloc(fdev->dev, sizeof(*chan), GFP_KERNEL);
> @@ -1119,17 +1118,14 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
>  		return -ENOMEM;
>
>  	/* ioremap registers for use */
> -	chan->regs = of_iomap(node, 0);
> -	if (!chan->regs) {
> -		dev_err(fdev->dev, "unable to ioremap registers\n");
> -		err = -ENOMEM;
> -		goto out_free_chan;
> -	}
> +	chan->regs = devm_of_iomap(fdev->dev, node, 0, NULL);
> +	if (IS_ERR(chan->regs))
> +		return dev_err_probe(fdev->dev, PTR_ERR(chan->regs), "unable to ioremap registers\n");
>
> -	err = of_address_to_resource(node, 0, &res);
> +	int err = of_address_to_resource(node, 0, &res);
>  	if (err) {
>  		dev_err(fdev->dev, "unable to find 'reg' property\n");
> -		goto out_iounmap_regs;
> +		return err;

you touch this line,

	if (err)
		return dev_err_proble(...)

Frank
>  	}
>
>  	chan->feature = feature;
> @@ -1148,8 +1144,7 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
>  		   ((res.start - 0x200) & 0xfff) >> 7;
>  	if (chan->id >= FSL_DMA_MAX_CHANS_PER_DEVICE) {
>  		dev_err(fdev->dev, "too many channels for device\n");
> -		err = -EINVAL;
> -		goto out_iounmap_regs;
> +		return -EINVAL;
>  	}
>
>  	fdev->chan[chan->id] = chan;
> @@ -1195,10 +1190,6 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
>  		 chan->irq ? chan->irq : fdev->irq);
>
>  	return 0;
> -
> -out_iounmap_regs:
> -	iounmap(chan->regs);
> -	return err;
>  }
>
>  static void fsl_dma_chan_remove(struct fsldma_chan *chan)
> @@ -1209,7 +1200,6 @@ static void fsl_dma_chan_remove(struct fsldma_chan *chan)
>
>  	tasklet_kill(&chan->tasklet);
>  	list_del(&chan->common.device_node);
> -	iounmap(chan->regs);
>  }
>
>  static void fsldma_device_release(struct dma_device *dma_dev);
> --
> 2.54.0
>

