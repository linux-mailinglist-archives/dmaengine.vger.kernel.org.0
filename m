Return-Path: <dmaengine+bounces-11382-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rkYiGuXAKGpbJAMAu9opvQ
	(envelope-from <dmaengine+bounces-11382-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 03:41:57 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4DA665472
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 03:41:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=TX8iB0Cf;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11382-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11382-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF3F0310883B
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 01:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE4427A107;
	Wed, 10 Jun 2026 01:36:04 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010006.outbound.protection.outlook.com [52.101.69.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300D2273D6D;
	Wed, 10 Jun 2026 01:36:02 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781055364; cv=fail; b=Tjo4oe3E3xKae71vXW2CmS1WtYV2Z2CQIj2eJ/iXSXdPBVEuUbQUAxnN6fUAN/GCyk2D1frhTYbmcuIxDIPgRB+vfIyYOkYtSsS5HP1/0N21F1zGluzZBXkG2TNNKX0ASf0jGWX6T/qSQQXyWYLMDIiQWpnlP5eTMiyyOI1JyeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781055364; c=relaxed/simple;
	bh=NJGa/8Qg20swUFKvu7KKPgIqxIF3XCcfvM2fDA76O8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bAYesvNmvRIuKbipJe2muhKsSytNZs+ZLE7xfhtX8uujkPhKgLpgSdngu5ILg+ywarLSrqbibeZ5kBUthJv1DOR5KyZmlDNs+Fb+G3M2WjX7b1r9CizdiEC7ZmZQ1FfGmLCd3h73mA5TIEwvNFb87D/WUqustlVxWe9Vk2grphg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=TX8iB0Cf; arc=fail smtp.client-ip=52.101.69.6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HGa2W3ALa+i3EvNMNAMj+9L2viP7uFPwnJONoCaHawDtI9o/GJtmpPg6/68XMMiGAKaempVouDuXzRYBbuQTttsydSH0rFNVCr0DdR420yaN0hcTnl4xDsbmQCXpAspgI4vXSeptzc1i453dJj8i97pVJ3wE/HIfWys4XYoEZhMLIk2oXe0VDYdXF/tDBTU3cfH5CSkoBCEAWsE0OjEvL5yV5HgSQoxpmCI/agsyhoTQpFzAzApz25QHru9irE7LVLqBcEqHlb/86mEP5XFiQqP3F3f9///9EKfZeeoXoCUTTrHGkgUHC2AGmd7/Z1olwRe/PcQi8LWC1qwDXC6Ayw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNkzCEbBN0YhYHMENbI1gkIE12fW6IMc0wWT7gLN8yA=;
 b=JS+jkZiNwLv9Z4EJFQlSI3e4l+E47gqr8AkPCGMVJ3M4TW+JVDYgn5btI8CDh8BMgNX/ybvqEg34oFeUdtHjVk7gNCMzI+VD/WN7wy5+3c1F6Wm0fRp+u7Ed83iFX4lMv1Dkk+lY7CVsd2eJZyHLKCc3j9vVUOh8+bkpn/a4+ll01piykRpFeB+1ZD1cIvI3rIwozxLM06ICcu/v04HJ0o2K7nUNjivTG7aIgaabDMIX3tTk5z+zyDZZ/uSaATbw6oFkNF3pTZSY7RXyobEbTMhX6WI339N/WgMXxmpA693Uj9uqf1VycBkOrHY9YtJzriMEEG4KKQGFeeUPHE3Oxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNkzCEbBN0YhYHMENbI1gkIE12fW6IMc0wWT7gLN8yA=;
 b=TX8iB0CfPZgB6TnWPPnSYtERFOkAnQRKC0dIVyUB8DdKiJ7WQYAeMFRxmmFWXVCHMPTVUou/w7PknjGp3g29GHlOPcYCASxrPEadNx7FqI0xOk8FoiS2Sn8y28ZW5J/2jGKitEcjbJtXPeOPaAuQ2o5+YXzLme72jYEQY9wI3B9PWqkf0uRwOJe2arDAz2dKgxysqVWAH1dkcQe6X/NnlpDk5WHdHsIbkB86rEWVuYYBE6OuJPdJRrSeNq2CX8yetpPxSuxA8xQ8UBRoSZW483gXV9skURMng3iQym67rKYqX+fVkjavXmtIPkaqT3ICUvkoGrKwt2i61NBsCOT0Hw==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GVXPR04MB10564.eurprd04.prod.outlook.com (2603:10a6:150:215::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Wed, 10 Jun
 2026 01:36:00 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 01:36:00 +0000
Date: Tue, 9 Jun 2026 20:35:51 -0500
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
Subject: Re: [PATCHv3 01/15] dmaengine: fsldma: kill tasklet before removing
 channel
Message-ID: <aii_d2iifIoDetMW@SMW015318>
References: <20260609221926.35538-1-rosenp@gmail.com>
 <20260609221926.35538-2-rosenp@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609221926.35538-2-rosenp@gmail.com>
X-ClientProxiedBy: SA9PR13CA0117.namprd13.prod.outlook.com
 (2603:10b6:806:24::32) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GVXPR04MB10564:EE_
X-MS-Office365-Filtering-Correlation-Id: 7da9badf-c1ac-4001-7d92-08dec690a037
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|19092799006|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	Jx3eEHSMTHKwfTcxtSCDI4Dmwq+xdr9Y9mLglAoCZsGu4UORS2QAqRFb/kSX6PaT3/sS9ZdVPSy/V2/jknVaGp2q+pw/j2HTar97k8uLxuVG5G6+s1hkYsWZ/EvUWECL9F+Iyd8KKtZAwf+Zb3tNE80qwUapEZ3S0tYr4wYvR7TLe4KlUCvO7wDSuWArb5YRQwsvzJsBSyDNWUx9mKM/F/UT124oBnM5JWOVp/GOse4ibZk7G264UI8Gv68xP5Q1lAK5CIOUWCoZ3f5mJemmHLdXPxZqE/BrwXAhm1KJBGzVaQznss0hHb8RNCFWjS275aIXlpaJlyKx20ujCxkJMh6oc1MLizjfRaI/I9jfzkuN1rONUZ2P/qgk0c/PAoCr0uDl8ZJ+vRZfCW5yFW+eO79nFjkXi1LmkMho7R8Oxgs0TbMPHg/fh6utZXcHlFfuZWVWTp+I4QEPeGHdwaXya3KZTZ5blJBiHTHW2672R6WdATk+PUWUw93K4Yh+Geut0VHzhDU2BVRiVM+Yv4wydXkTn8o5aq0m+Nuwt38fkQmDg6Nl8TuvvV7rgeR7qTAQs/O3Hiv6f2eXrSwPzCkhgeC8W3TQStXdsEjL2wjzf2fhuqmRNvjpRgQrNSv+SP1EFRc8EMxEGuGoBKokSL0YctwYqgtDzUrXMUEI93W49+wcV862SmCfapNRG+Auv3bk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(19092799006)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xWfUij2NG4jJmomTiHC2Lt0bqJoRfizM7zKe3X9SlbPeamc7cF+A5E9ERgnj?=
 =?us-ascii?Q?WKdggLRp+p2eDYdsOkPKrzv/iD0yHOyhq9vMxgT8m58nqDadY/CAeCVw1YaD?=
 =?us-ascii?Q?wtWzLH5rKwRqkX/ZAc57zVcMu1EqZ051YYOjFKTnQckQ6DXmLru9SdFwixpC?=
 =?us-ascii?Q?a/MY0egmUuE1wSYyGrZ6z4yrUZmpjvEUiaBUC50skfARa/kn01J3TBjI0z6+?=
 =?us-ascii?Q?ZRsXsHL5NOiByk7wtn7ooGGPukSb2Uz+zRPKbzhlnbUww+8vljoWwF14AfBm?=
 =?us-ascii?Q?94infkg3EyibnPrlyE6Y0WMuGS4Iemq8xZ1GLbyWtMiFeWX1L0mZfKavywcE?=
 =?us-ascii?Q?RVWcHwxetz9sC1UFW+18u/liOZl+Cg3z8jIsPYTCeS/IZky4vr5Dgq+fSbzt?=
 =?us-ascii?Q?muIFLvkKGxBq/f2AQ4UQEzXIFPwN9aS82eMo6DPmK5FbTkAUD2phpYtZRKDa?=
 =?us-ascii?Q?3HvILHVNfJe2MSZ0vGfMJxRR86f+mtrycdWswDpjGiYRTWOdMwvdei8BCfbu?=
 =?us-ascii?Q?cHh6grqZEtMutK74gnl5vtkMI4T6iY5lBb7B8g3/3tfYTIqGeJTdbedsmWVg?=
 =?us-ascii?Q?b5lIPHikRXfXgbYxYhWprUIsvWYj2XQ/UzSo9tHPC+AM0IkPmSX7gZQxYjJK?=
 =?us-ascii?Q?iWx4ZqC2GNX0L4YBhwsKQnit42gHcspMnCtjibX4gSR+TT69K3qi6R1ih4iC?=
 =?us-ascii?Q?DA/JAIEebrG7RCMnB1G6KnBtHz4/Oj3D2mm2kwWqCqaZMoz/er1VfgNkM1jl?=
 =?us-ascii?Q?w/hCckaIfhpij68sc2b2Ie0DMZgSBt7WPov5/93wt3PHTtSWtze/A2lLubUW?=
 =?us-ascii?Q?kqFhXtX2WG8Uqmk6wbaivnrz0zKMHjizdFiCDW4UbdGhGwC3nUeYBTzLWvuX?=
 =?us-ascii?Q?tZefZ2PUsKaKkDaOHq2c8SpoQDyG5MzIaRly9jvigZEkGQXzfjxlEEKZqDvc?=
 =?us-ascii?Q?1z/XWxK12yMzWSXemO5LJvCcgCblWgEZNQ2TLZaMovjAu4YOpz/BbpahFB5+?=
 =?us-ascii?Q?1W+4Ao80tC5nIoAE/lw6Z3QooRVOye9b3Jhwv/wxTq05Lv4Xv9qlVg/pEdJx?=
 =?us-ascii?Q?Xw8LAXtD0DcgLldrFOARvuaCbL+wuNo27tDGiJ5voI4JSUGZL8c3JrG4rFlu?=
 =?us-ascii?Q?5KXk+LVzLvo0cdYILFtUS3Iic3hsUk3UxQmkB/ySDJwKQ5IBGri4oYAyvn2I?=
 =?us-ascii?Q?E+Jwu2RLX7VR4yeGW5ElSQKVLr1H217ohWCo43CWf4xn8LzqmPt8o2dnToVj?=
 =?us-ascii?Q?JFNR5OI+opnQNN+8uTS7ud+x3TFYpJFYwFDd41+PfCT9Wc/8DVCUoo9Klxuu?=
 =?us-ascii?Q?5WGvg4zZeKlvoNHOzCczrtdYOl4gYEL2cJ0cKdZR60bfH++OejXhOmZARuUk?=
 =?us-ascii?Q?sfEcOtwoZiGMm6ELugH3Aw3qNUKppX8f/HOmnZiZBTyhz2hwqaZaLaAqUhqQ?=
 =?us-ascii?Q?YdaXmZZz5Fhwu3Hda+5QRGms0oaxH1n9ZVJVxNbZY4/DDucjor8cWNiVEQAe?=
 =?us-ascii?Q?l4T0e+7cX9TyjYpyWgqDK9Qie8LlM1VEEgvDS4E97KEr/eZ5QK1DUmi1RuUK?=
 =?us-ascii?Q?ugReqQGK+uo2QGPbqJk01z7/WCJ1fA+PX6X9+6k06hvW1GyVv7lIxyc8wznJ?=
 =?us-ascii?Q?q5Yz6rbpZBzdgQAr2A7a4P04bavs+U32HysMZ/Nb7mYSqG417EofsOS27qZT?=
 =?us-ascii?Q?JVN3JwKSH/eSLYj6k/YPMM/ejn+gQNfVMyxvwmQHRsCajQB3Jf0lnpJpWymj?=
 =?us-ascii?Q?rdYTX/2xgeb0FjQaa91WcWYMEJxgPFX1ylku0XzAQLTuKn0ONChs?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7da9badf-c1ac-4001-7d92-08dec690a037
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 01:36:00.1869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WbC56Dvu4OV7dnAGHi+JJeBFYLfXgksZBy/qxL2BtrZ0lAjTSH78rE2MXnvRDfdO33yfzVgb9fz2kwgP+iwucXTSyIAhHtoaviXiYNK0eT/J9K+19O2aCd3hJrzs7BYq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10564
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
	TAGGED_FROM(0.00)[bounces-11382-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,SMW015318:mid,oss.nxp.com:from_mime,vger.kernel.org:from_smtp,nxp.com:email,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BA4DA665472

On Tue, Jun 09, 2026 at 03:19:12PM -0700, Rosen Penev wrote:
> Add tasklet_kill() in fsl_dma_chan_remove() to prevent a race
> where the tasklet, scheduled by the IRQ handler, runs after
> the channel has been freed.

Nit: please wrap at 75 char

Add tasklet_kill() in fsl_dma_chan_remove() to prevent a race where the
tasklet is scheduled by the IRQ handler and runs after the channel has been
freed.

>
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/fsldma.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
> index 22d62d958abd..0e2f84862261 100644
> --- a/drivers/dma/fsldma.c
> +++ b/drivers/dma/fsldma.c
> @@ -1205,6 +1205,7 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
>
>  static void fsl_dma_chan_remove(struct fsldma_chan *chan)
>  {
> +	tasklet_kill(&chan->tasklet);
>  	irq_dispose_mapping(chan->irq);
>  	list_del(&chan->common.device_node);
>  	iounmap(chan->regs);
> --
> 2.54.0
>

