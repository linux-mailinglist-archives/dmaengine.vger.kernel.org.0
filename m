Return-Path: <dmaengine+bounces-11216-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2ZkIMEBQI2rPowEAu9opvQ
	(envelope-from <dmaengine+bounces-11216-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 00:40:00 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1951664BAEC
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 00:40:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=dyz3G1VI;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11216-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11216-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15C6F3024167
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jun 2026 22:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51EC3CC7F4;
	Fri,  5 Jun 2026 22:36:35 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013043.outbound.protection.outlook.com [40.107.162.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5546E3A7D6E;
	Fri,  5 Jun 2026 22:36:34 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780698995; cv=fail; b=QdFI4IlXnZarrmCL5aMlZDn1lQnAZ2X/JKzqzkd2ORjk/k9fGYMHlVC0Hfl1X7iyDB7Thu8Dq7jL/lQlrDnAN6olhaaQLQsDM3uDaS5Lru01i9aBBJTLCllAlop7oXhiZ8QMrOnmpeG5VJZMYMigOsQM3PGpHbM5Vxg43iyPt/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780698995; c=relaxed/simple;
	bh=DgyX+WKLzrED1YosEGBSXP1RbQSw3wetUyK4lj741P0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ISzNXAQftnx2PqBq4NF+nUCzaLnql0YMHRXS/grxfwW99OiVhdwhzHA3qRRcKC99LQdHWb5LVJ5M3Wunayoh6kXX9E1LSuH115n/NJMIcVhNTOM/rHi+RjiUC7TUJ4JY3IYYDKH36gO7sTxjT6Zvw2tsqzih/3QosWYHP6drBQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=dyz3G1VI; arc=fail smtp.client-ip=40.107.162.43
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H/xepDT1NbZ6VB6YUgeN5SeYLagbu+V4GdHR110nAyt7cVfhb+9uvC9g/A0FJ5KISoZd5f5KXFb5qwGAdhOF71lzjdHBbzODa/MnoXo9iWh9WJ06i6+KgcNsAq7+6ANPvQboqdAn9hZtmK9f++R1Rddz/C5GHpfJB6GnpUjcBePxgSUlJ1U7DDZmdaCSHvEapRAVyEnMP2++zJqy38PkDt850nD4VtouXkREueTvMOgLrZzbUdl8sO1dnvEgvfWabxnHctUgLJt0p9GZ/iaBToICUPwqpDfYQRNHduqJVt/fbfJV6U3iCZe5sKgiMs0SmZ28F9crOOGSi10xKz1qAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aI3mkGnXiqdnW9INK8xk/FTrSBHneMedRdvu9wX5BRk=;
 b=pOCrWVadqA8pAXyEBt7UIufzlSlnxloc5vRB4GeVL3KV0uEvdh4wTq5B684ExfqvuWf743vgLC5kKYWQ0yM6ESf20QQ+nncvTxiQKNnSo+1slcM4JQnkJbrIxXgYhwaxSn4OH6RQKsCdnhRejbcGIZ4ZGuaNdmxNH2cjgqYK0rablsEB/CoaTfyTEFHA3zm37qljKcjv8QBo3BFC7qXN7NTncHObD8M1wPWbOGf8pZYBNJ9xK1kDHxY0TbLs3pfblxixKm/oNWdxuM9z8gli59IK8GLt0TBbIZSTqucXWqzu3R/1m9t5iHdyjJsng1tw0tN4R20ue71qU3KSkCor7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aI3mkGnXiqdnW9INK8xk/FTrSBHneMedRdvu9wX5BRk=;
 b=dyz3G1VIGJaYiBFDA4Rg9SYzphdcygdyqC+WLD9Xs+Ah/aoVJ8YmRySQRkLMhNrPaHrkp/KAUZCtOhiFj6qsu4/hJ7UPuYC/nhVfXiGiisQhrMNcPI+hwvP3QYNKyO5YPOeB23xSGui6sH9xKhhm4v3k/2gQb9ZWVaAk6+QUFdbIh4dALkfgtKty8hbdzhExsjgLlfkLJ8gvvGkDkNQC2BZstxOANdPO+hQsaj2AEhpLKncRNOeiPJp5mACRTMG+e9+hG7XvmUslYejPiaQKnJm8Z95YoXvtKc/zVlUbux7rMj2NE1H2wCpahpzE7JxmppgV0rxP8qbRVrCwHqC88w==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI0PR04MB10463.eurprd04.prod.outlook.com (2603:10a6:800:238::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 22:36:31 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 22:36:31 +0000
Date: Fri, 5 Jun 2026 17:36:21 -0500
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
Subject: Re: [PATCH 00/10] dmaengine: fsldma: devm conversion, fixups, and
 cleanups
Message-ID: <aiNPZYzZRiBBZK6I@SMW015318>
References: <20260605220134.43295-1-rosenp@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605220134.43295-1-rosenp@gmail.com>
X-ClientProxiedBy: PH8PR02CA0028.namprd02.prod.outlook.com
 (2603:10b6:510:2da::29) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI0PR04MB10463:EE_
X-MS-Office365-Filtering-Correlation-Id: cbc49569-f02f-41ac-3f60-08dec352e3b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|7416014|1800799024|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	W+mpzvnZpg3TQTkIF917YX5MJ3GE40bREXdGiqT+FvhDUqxSMBLd/4bUdO1pPRImf9sF8MCPrFd9sn7aIDMYuoHTPigvLXmq71q/IzQyJ2+yIzDK/5Vli6s2bNG+w06sTsrfGz9m/v4q0kUqVfUG2ogfTCVIbdR7mg9x/lLB0Y73ChK5kJQJQfID1uWnanYM0gHqkoIJAmXDlckRY7hDFM5lR7p+/LZmyZ6pRzBGZUM0sscdfgI0qfLdP2nnBsUj+MqM34WIq3j/MyWEfYVL/286alemTRTcF5kWTPX68Imrg5vHH4TgFXSTtiOw3uVcgEJty/iGWxzeWZLyYV3/Ud3+bS6RojAEwdqFQeh24kZQKGPPeDljSAVswvsJvXdl0N5M6xqpKUTuAidNMczncCopAGXfLl/gkv/hePOouiL23wTjWk/s02ZV545WJvbWeCf9KzzpHsaSQP6uHP8b4ZPAOv1qssRKzWvjxDhNOEZ4ZOEZDJU7K5nWaw8skEQ0hAWXuHrnrKFYebhd+Dt3S+b9mqmHa/TAySWXzdqIwA2YhIujGrQ+91ImMaGK8ownbd7YQ0f54r4/ruoBKcs8E+mlM6QaUg6wjhLBhBsf5C9oYVZ8ccIQn48DqjGsEJlzLx48TirPzUgcADUTqP+OgCPf7kpopwAwhAtIMA+T16XOhg36V66vydvXCmXW3AOY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(7416014)(1800799024)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SFjA7+nXlfjL/HlMnqI3+wzse2klNHd8WvYBcnf1wsRzbLcylf7ZtLhccByQ?=
 =?us-ascii?Q?MBCUiET+yUGBE9As1OH/nUa68dEGVgSqg/eJ0ONa9ZkQ7bllHzLyN3XbGUCQ?=
 =?us-ascii?Q?CotR2WRJxEWD8tFrTji5ZR7P/RinI6OUP1Lo5w4cZ5EZg3Y2s3Vmo/KbkNi6?=
 =?us-ascii?Q?sNr1++o9eWHVc+g3vNdRDaokOTXkckFs68o4wgkki5rH8EhMtrwPCfTcWD+e?=
 =?us-ascii?Q?5sbR8cS1LzhLnX3cfTI5B4lcmLRH77RNwr42d1QkdjFv9YsJ3M6uM9fuwics?=
 =?us-ascii?Q?zUm3SR1JfrdiM2PV4WXVuypRI+5qapDUcEdzIFkI5Zk5ApIyuJZE55/fsKcZ?=
 =?us-ascii?Q?Hv7YQrsS8f//eAiRbICVcfNPpmP+jhpxsls2slvPmVcVRAD09gd2y55qeefi?=
 =?us-ascii?Q?c6pAYnAbZLTlw8m5HihsoOaYEzCj81rEQ2W4HPjdIfukBwUTPHU4guC0q+v0?=
 =?us-ascii?Q?F4iXFvzwIUoZ8KpfXEtef9lE9zxg/WqvelXWkIls6e//Uv1Ly1mVLCTEGM2t?=
 =?us-ascii?Q?xnQvvLIaYXmc97pFZYnv17BdFAKCTzGV44brdYPssEpzBrBMIcbKqrom6Lsm?=
 =?us-ascii?Q?A4b6/icGMkPRIvPOS18pvdTsDzBK83q3aOgvD8gShjFBrVkxQk3Mf+qL99Pi?=
 =?us-ascii?Q?hypGxGZZrQI+OBLkmUSA5sSCdBGg6Lvm1tOJhab9c6sPEGguAHpRDEUNCqcc?=
 =?us-ascii?Q?pMXr/cUPlDvLguIutHVBKIaycIA3bFCb3DI9ZgLXpt9m/tA0wXwRRzy6VR1S?=
 =?us-ascii?Q?2NmCiUfAMKi5xjRqrNDosnfVJSNERRKAFabCYDITic0jKqB8BjumTkKHz3Ss?=
 =?us-ascii?Q?XLmAF73/snji39l/TjVYHvHC1Yqb9+r39NGBvKhRNdNaEOwaWpMUuxorFdxd?=
 =?us-ascii?Q?bjd5rkZlHw7ekMkp4xBUyyoiO/r3MtzL9aNzJQuUmtnGPWYmkox1IeD9blwj?=
 =?us-ascii?Q?oyAoSnWpRvn79GoalNCzu5gU2soTLbhn9MeVF2gMfql2BFlTmNOLs5RKncbh?=
 =?us-ascii?Q?vax2gPNFoY51G/APVVpqJmNQxke4V+s/2S3752/+bMmmHKMu14LK8zq/o0QC?=
 =?us-ascii?Q?kIiS/sd1cChYUf6tQ+0SwBOvDUTib9D18cY3XEn26zGWeqr0Cgxxit/2Nwnz?=
 =?us-ascii?Q?d7ctm3BkWEvWr4yStkPEoP8L0bkDS+JFhJowdvWh5SGjXFjiv0G9bfirbxUu?=
 =?us-ascii?Q?SswTpdUyTdWcznExUb32AQeupjGbCZOMYDj9nQrtdpc/eCt9oip8WG8dkecA?=
 =?us-ascii?Q?H5dfqh5vsfjGvJXYMfWqF3iZ1taZqVKxYKqxBWTJz52nfX41sXkuyPlpplVX?=
 =?us-ascii?Q?Yk7UvfRP+4bhI693Zm8bdCqHbrN9ChIe3ny7aV97EdPJouG/2L3cVN1IVMMF?=
 =?us-ascii?Q?FXXnGKj1eDd500auqaom2ANvIdZr7Vv1rg0NP/lE9HMbIQHg3Xaebx5aO+wS?=
 =?us-ascii?Q?92eKUqYEfniJUekmL0mEII86ZNQWHsL+O8B2ySlazdAYeIWSqe8o/Oed9Kp2?=
 =?us-ascii?Q?81sy/07zXzffvXLL5Jhfio66dIDVkod2uiqzdAsxJvEk5cf5YebZcVeD8yZZ?=
 =?us-ascii?Q?UQmRXE/DzoCZyEY+CECF4ooF0p3wlcVQxkuVnA+PC1ec7Qf/r3B51SxTGiIk?=
 =?us-ascii?Q?ul/xUSXtAmPFgRju5mLhURg6rqukONKZsS8KwL0h7kY0OU9gCwH89p3bFAP0?=
 =?us-ascii?Q?gegTjPT0rlYcmAA1AxWa9oqPsxmmmVINnT8qp4Bo+rpR90NX6upJ1xm8R++B?=
 =?us-ascii?Q?iDwQH2TyFRiKfs4zO0z44DHV719SEzGCMstthyOm/wZA4k6ZmR0x?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbc49569-f02f-41ac-3f60-08dec352e3b0
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 22:36:31.1234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cp+myD7hxCFup4uPV7Ub4Ymfo35eXhw6BsHDoczYnSEFae357EWQJS9KmqkZJMcNXuIpO8a806N9mn4RfshnaZd4ctQjsGmgd9DxwliXnvg6KFR79kLaZympb7U/jjeS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10463
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
	TAGGED_FROM(0.00)[bounces-11216-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,SMW015318:mid,NXP1.onmicrosoft.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1951664BAEC

On Fri, Jun 05, 2026 at 03:01:24PM -0700, Rosen Penev wrote:
>
> Convert the Freescale Elo DMA driver to use managed device resources
> (devm), simplifying probe error handling and the remove path by
> dropping explicit iounmap, kfree, and free_irq calls.
>
> While doing so, fix a few issues uncovered along the way:
>
>   - Kill the channel tasklet before removal to prevent a race with
>     the IRQ handler.
>   - Check the return value of dma_async_device_register() instead
>     of silently returning success.
>   - Replace the powerpc-specific I/O accessors with portable
>     generic ones so the driver can be built on non-powerpc
>     architectures.
>
> Build-tested with LLVM=1 ARCH=powerpc allmodconfig.

Suppose this v2, please add V2 at subject after [PATCH v2 ...]
Add change log here or each patch after --- to show what change in new version

Frank

>
> Rosen Penev (10):
>   dmaengine: fsldma: kill tasklet before removing channel
>   dmaengine: fsldma: check dma_async_device_register() return value
>   dmaengine: fsldma: convert to platform_get_irq_optional()
>   dmaengine: fsldma: convert to devm_kzalloc and fix error path
>   dmaengine: fsldma: convert ioremap to devm_platform_ioremap_resource
>   dmaengine: fsldma: convert channel allocation to devm_kzalloc
>   dmaengine: fsldma: convert channel ioremap to devm_of_iomap
>   dmaengine: fsldma: replace irq_of_parse_and_map with of_irq_get
>   dmaengine: fsldma: convert to devm_request_irq
>   dmaengine: fsldma: replace ppc-specific accessors with portable
>     generic ones
>
>  drivers/dma/Kconfig  |   2 +-
>  drivers/dma/fsldma.c | 139 +++++++++++++------------------------------
>  drivers/dma/fsldma.h |  35 ++++++++++-
>  3 files changed, 76 insertions(+), 100 deletions(-)
>
> --
> 2.54.0
>

