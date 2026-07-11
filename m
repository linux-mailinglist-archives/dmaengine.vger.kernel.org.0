Return-Path: <dmaengine+bounces-12347-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zy+8C9hSUmrFOQMAu9opvQ
	(envelope-from <dmaengine+bounces-12347-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 11 Jul 2026 16:27:36 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE2F741C9D
	for <lists+dmaengine@lfdr.de>; Sat, 11 Jul 2026 16:27:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=S3kZZAb0;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12347-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12347-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26B82300A116
	for <lists+dmaengine@lfdr.de>; Sat, 11 Jul 2026 14:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4206729C327;
	Sat, 11 Jul 2026 14:27:33 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013001.outbound.protection.outlook.com [40.107.159.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D72A23392E;
	Sat, 11 Jul 2026 14:27:31 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783780053; cv=fail; b=bq+lauzYF7NBdB1E3cx3C5xlxOuF8AJ3js+ebV4M/KRbNfVo9WZccJU98KtWsFhvMEBHJE1JYkQf7dDm7ukMn+QtRGrsMslBWhpcuUDBzKADcwffJoAYT1Q6vzpZWwtPZtLRF/GtxGqTHWjDtxqQZWkF3cRnjXApE+tUe66Bu7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783780053; c=relaxed/simple;
	bh=RJHmyHbuWYL1GIw7+mvYNhjI35oLYiYT1S6ow9gHxwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mfb3VfOQcjfyEhP3QJ2uxqWDkAzh6GrQF+meLyTJ65cgFq1n8zkUfLrX062vzbifY2FXd+sSLW/0edxxOHy6hr+GcP1VGm6GkJ0azNM/Yt48eIw3Bai/teu8xb6NviwfvaMD++uJ6Uo059JKY97UEePOq24IvA+B3omAvDTuXsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=S3kZZAb0; arc=fail smtp.client-ip=40.107.159.1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P5SjhDOO1hTOiQ7+owfuFJ6nEDDtnJ1SJZZwXd9FQxQTcgfHdWAd4eWCWOVjNfSuQNMoGUtGfSKDtCp8Tu5CMZHr34S1Jgssv8piUW4CxkQVL7dOjeOQ1GChED4jC3uuY13KwfgZZs/rMTwrxvWg7CgU+ijijVJaFfRR1g0dq4dqE1ykoULV2nj8CiYQun+TEW17Owr7BMnWtV0ruJYcyaiXzAiTmxBl1Y9L4OSYDROaNSwSvAbiHGJyHGNBVt1TkKkhvOwkogyBu2xXOWD8HWNqkDvpb0X+yN0GejBGhnvkfV+H2dxZOWwUPM6iBoQ/nqLAfLqBy48pptPYGVajhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pvx9tzOUNLS7HKi5Xg3546ae9I72O/1xG1sm+iWXGWY=;
 b=b1rk6kvbdUNzipxHUMn58y9DwCZ5XQ0rTgTi+pYkSgnE0HQ7OBJC5mgNeSngt2dM4xVjLhmkYK47i/YyQYKvRkTdx83i5Sgo1MHKPVqmvwntXSizrKSEa735BsYnJJPMuP3nCDTbkkh/BDt70FKDFA+kg8cIaIR5hH++54jRgAWljH5KLbEeS+tLW6AKqchLsIkYgDKvE4vqXWXAhwnqrjkfzDF5yoTO04MjcpZEZWRqhIv5wX8rzlPm8JoJeIV+paJXGHVNnxyWSHRm3usOCBckfZsxymsYTLd8LRRXrVUI5L69Ft74p0AghPEeYCrmiHi+aMmflnWYPuFEsGDc3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pvx9tzOUNLS7HKi5Xg3546ae9I72O/1xG1sm+iWXGWY=;
 b=S3kZZAb0oMGxgXKhrvSPHhVEr8dD1nt4ypVTVJTSU8NoX1Gib0NjSFoXcRb9SNQFpuKsQzPtgadMfdxygI7ieChBYG3HokwSj/wX8Wt6i9csX/vabaZ4Iux6YjekQy9UhRBOMh8Xy2E4aLXzp1caoXvGvDhUBOYAXtCIhxQyOWYFeYYdmNh4QJ/4/xoyUTqfwE/JC8QT7Ou4SSPrcjjuu6xhQWF8eLoFwpop3PJ3aG6VgcOjMvgdyPqN/ZLmaLAbAonWsdnRaVN2KX7xPm5AoPl/XCAVruBKqdJRMVBEOo+ooWJBV10zliEuukK+Rux8bjVu+yQTfBJLlhP70GnyKQ==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM8PR04MB7361.eurprd04.prod.outlook.com (2603:10a6:20b:1d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.22; Sat, 11 Jul
 2026 14:27:27 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0181.019; Sat, 11 Jul 2026
 14:27:27 +0000
Date: Sat, 11 Jul 2026 09:27:16 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Cai Huoqing <cai.huoqing@linux.dev>,
	Serge Semin <fancer.lancer@gmail.com>,
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
	Devendra K Verma <devendra.verma@amd.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] dmaengine: dw-edma: Terminate STOP requests without
 callbacks
Message-ID: <alJSxEn-OkE9lKNm@SMW015318>
References: <20260710080903.2392888-1-den@valinux.co.jp>
 <20260710080903.2392888-3-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710080903.2392888-3-den@valinux.co.jp>
X-ClientProxiedBy: SA0PR11CA0008.namprd11.prod.outlook.com
 (2603:10b6:806:d3::13) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM8PR04MB7361:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d59e074-e44b-4b8b-0c99-08dedf588836
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|19092799006|7416014|376014|1800799024|56012099006|11063799006|5023799004|6133799003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	lRyNPySRtPSKGgA1YNj+wo21h2gSenW7hZFjO+edOaNnDy6KLQ8BQzU7jTeu9RHaG49QPlX14SDPpKX4479TE0HIxfyArBurV47DSXO9mOZXYP6Gv8IvBhgCDra+GF9B9nbhv2ZYJuF/R8UmMbLYBMshr7SeAjTwG8sYiGAq627LZrTZMXgKJISI2sLP+J/Agayxw+krQ5ty8LxIpuVlLHwMFKf/JBwVN0GVLjni3Fbr3wz8hoBcKUh/MGYFEP49jIG3Geajq4Ee/Oqd+7KqTbYW4BJlYZ9Om3vl5/vIoLPeYe3DhXsYBKGdkwGDCFH2FhAMTodVoDAfQOglo9Fqjqgd3Hive4RzvUcdrnIpUYueq460fe5Q/j4o+8jorjb4hp655Md8DSoHDBWke8AFuOib1A+JCtWqkJZ7HrqrQow/fQYI1nKYIJme2TcLE0nBHRe222Yi43GFGlA5I/PTXzxA7GxvRFxiBB3CPxsUY0EPZ+tEewtldgzMehp4atdinc9LcHKX1hK8QoopV4hwBRo6JN8H73OFY5TG/QfqNDrWHfPTR4ZmviM34/i07osH3nEiT5AAn6x8QWCyy06PKtduKesOKdhO9709GGyCjN3ha7Ay7Zavrrd6QBXqDdslB8nrU/mIe/pUVZGLXTzWf4dkGVVw4aN0Hoyn/IGHFU4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(19092799006)(7416014)(376014)(1800799024)(56012099006)(11063799006)(5023799004)(6133799003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SDeZczxALUEnrLEXnTS1zDu8fyeWPHe7EwrosRmsii3qhb5ZfOk0hWoweSWS?=
 =?us-ascii?Q?+qeszP6ZQRfGv6reFAw8oEz75aZEbM4uRzqurKFsIuF07k+AkJokgJnXWtf6?=
 =?us-ascii?Q?T0hmtZa34aDzEvz7DwoWuinpT+b5y88ssxjJmLY5ruuouvNw2aB29n0nj9Ky?=
 =?us-ascii?Q?vsAO1V4Lup1Fr/vZ/Pjp5U3YpsYgoEfFulUKjAIsbESlBvL6gUGgSd7DcTV/?=
 =?us-ascii?Q?KjtztyhtjWguQDl/a3j44eEE3+1EcCk0c/Cs3hLqhmtCFuElUKNkGyYzyu52?=
 =?us-ascii?Q?TY1DVj1y3Kgd1je73/QcVlK/3ee5sZLtvhbAqDMDeC6q3wph0jih2skpb81J?=
 =?us-ascii?Q?qVG8SmPhVifrjL0NOVFVOJ2BTrqfjfMIut8Js94AkAMSvt8y0H4SggyNHXfq?=
 =?us-ascii?Q?yqcWCZ88u9hri3F2yrlnfipTnm02RrzKJsHGFX2n0GRkZ5TtWNEFong2M0ma?=
 =?us-ascii?Q?Jxh8sKoLTsYEWFHVbT1vsidgrERJJi/Gvw5NlEUlLIfmfripIH8fh5nRL/H/?=
 =?us-ascii?Q?z2m+Msn5gNz1rLrSvQjFGs1nQq5eDpfhEzJ/52nHQfgLPWUPcs5PISpwA/pI?=
 =?us-ascii?Q?gL6eOCjua0/Bi0alhxySlbkuGVx6dcWfNUs0yIUL5TgujvoMcT9tHa7Bcw5Y?=
 =?us-ascii?Q?gpWF4Ct4FqL7vQLypxa4+gCXYriv4S9xz0wcDvgc1uUD4iNXy7aMqHXzLBz1?=
 =?us-ascii?Q?FCVm57nqxT60idHq4vd95fJurkMlJevmtiFy4Tam2HM3rVJmsP6kA9juRJSC?=
 =?us-ascii?Q?o8iK6ww2vxLmgQzCSQFf41NQTy1gHX690hb9S4LcvZ202BBjSdbf5JL2j0mj?=
 =?us-ascii?Q?dda8L7a3hwneBrHs3aenBgvQNyAMHmEUH6Axf1Tl3TOWXQ3RBNGuOJ8SN6uB?=
 =?us-ascii?Q?R7K9qbIWenniISp6ylSEIlUjzF6R1j1PLl65+i3zRnGjDPz3lhZae5ATGmWR?=
 =?us-ascii?Q?UYht2q+O6D3rsmvRtJa95yvdR9QIX+3XCIAhhTsS035dlh3nI8Gq93Mc6F4H?=
 =?us-ascii?Q?/GXgxCFoAxTsCE49SRDuc+OB/DXH5RlgSQXseBn38Cq7tyKMTndoPfyhgPQ0?=
 =?us-ascii?Q?acV9EZ9u++2BgkLykEmyAeBanpbhpo7+2aaFHcvvXjPEO1TXHi3gxnt5D3V4?=
 =?us-ascii?Q?/RnapJXCFdQHCOFdRWR/C1ZTJyvzOGSFvnBWh9sldjR6N7Vb22PeAuL1Z4x7?=
 =?us-ascii?Q?XIXDRGZTAvtvt4NeJwRXmH2mmqIXLf+w7QpAXzsEQ262OgxoUGm7CVDkkKB4?=
 =?us-ascii?Q?7O6QMmSR36XdmExQrIMG1bpUOvRpxuIXelOb/j5alKE15xIS3mb9BDyYeZU8?=
 =?us-ascii?Q?z5WzTkxcuaqsjiogyIziZRNut/KtgKlMFv57erMDzbQtvyz8WuM9py/9jZGB?=
 =?us-ascii?Q?meJUBmkGE2q+x/AS7udPeQe9NEi4J++teEIvXeHhi5gkNJf7OT49Gz4GgacG?=
 =?us-ascii?Q?mlrCBk9rqrZmILTco4RkyExi1rGWT6S0gwtlLBjMhyeGxcdqUv8o+PolHADn?=
 =?us-ascii?Q?x+x1Xof4WBe1nm0vpp3B3ntnlmqU4Rk/EXgcYQWR+pMzUVXJpV/cLpMsZO7A?=
 =?us-ascii?Q?YOUBXCCLU18GZtSL1CRR93fB8dx/CXzjtPCeRq5ofzzAhxk3BMEAw145ejoq?=
 =?us-ascii?Q?ohxNROEkzcHObLbc5hR565BTPxQJbjqD5+tFMJ4hJN4y3x6U9Hk329ckZ5/+?=
 =?us-ascii?Q?+TTGjRlNIQaAyp3iVqU6+OpCIlgqqbVY0KVGkZzcBUv93dfbu5utlQdHEiNN?=
 =?us-ascii?Q?l1VIr+QUAfPA5a46D06hXmsjXluzo33pzZSIdG5XAlyDYhimMQzB?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d59e074-e44b-4b8b-0c99-08dedf588836
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2026 14:27:27.0822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rjqsn0snRLosXvXyFtAzNLlX1hdXkZJk4h5i14cvp9yOotQAYxH3fRIVHkDNMpRCEWDG0mjV38zjOFOKsUG/Mb7+LhxcG6W67fOPByiDJXUEKnM0tUMJMnu6ZFKTfgMu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7361
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12347-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:den@valinux.co.jp,m:mani@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:cai.huoqing@linux.dev,m:fancer.lancer@gmail.com,m:Gustavo.Pimentel@synopsys.com,m:devendra.verma@amd.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:fancerlancer@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,gmail.com,synopsys.com,amd.com,vger.kernel.org];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,NXP1.onmicrosoft.com:dkim,valinux.co.jp:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5BE2F741C9D

On Fri, Jul 10, 2026 at 05:08:58PM +0900, Koichiro Den wrote:
> The STOP request path handles device_terminate_all(). The DMA Engine
> client documentation says in the "Terminate APIs" section of
> Documentation/driver-api/dmaengine/client.rst:
>
> "No callback functions will be called for any incomplete transfers."
>
> dw-edma used vchan_cookie_complete() for a stopped descriptor. This
> queues the descriptor on the completed list and schedules its callback.
> A late callback after dmaengine_terminate_sync() can dereference
> callback state, such as a request object, that the client has already
> freed.
>
> Move the stopped descriptor to the terminated list. Complete the cookie
> before doing so, so cookie polling observes that the transfer is no
> longer in flight, but do not schedule the completion callback. Add a
> synchronize callback so virt-dma can release terminated descriptors.
>
> Fixes: e63d79d1ffcd ("dmaengine: Add Synopsys eDMA IP core driver")
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes in v2:
>   - Split out into this preparation series (was patch 03/17 of
>     the dynamic LL appends v1).
>   - No changes.
>
>  drivers/dma/dw-edma/dw-edma-core.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index 89a4c498a17b..4e0dc52397e2 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -201,6 +201,13 @@ static int dw_edma_start_transfer(struct dw_edma_chan *chan)
>  	return 1;
>  }
>
> +static void dw_edma_terminate_vdesc(struct virt_dma_desc *vd)
> +{
> +	list_del(&vd->node);
> +	dma_cookie_complete(&vd->tx);
> +	vchan_terminate_vdesc(vd);
> +}
> +
>  static void dw_edma_device_caps(struct dma_chan *dchan,
>  				struct dma_slave_caps *caps)
>  {
> @@ -673,8 +680,7 @@ static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
>  			break;
>
>  		case EDMA_REQ_STOP:
> -			list_del(&vd->node);
> -			vchan_cookie_complete(vd);
> +			dw_edma_terminate_vdesc(vd);
>  			chan->request = EDMA_REQ_NONE;
>  			chan->status = EDMA_ST_IDLE;
>  			break;
> @@ -856,6 +862,13 @@ static int dw_edma_alloc_chan_resources(struct dma_chan *dchan)
>  	return 0;
>  }
>
> +static void dw_edma_device_synchronize(struct dma_chan *dchan)
> +{
> +	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> +
> +	vchan_synchronize(&chan->vc);
> +}
> +
>  static void dw_edma_free_chan_resources(struct dma_chan *dchan)
>  {
>  	unsigned long timeout = jiffies + msecs_to_jiffies(5000);
> @@ -968,6 +981,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
>  	dma->device_pause = dw_edma_device_pause;
>  	dma->device_resume = dw_edma_device_resume;
>  	dma->device_terminate_all = dw_edma_device_terminate_all;
> +	dma->device_synchronize = dw_edma_device_synchronize;
>  	dma->device_issue_pending = dw_edma_device_issue_pending;
>  	dma->device_tx_status = dw_edma_device_tx_status;
>  	dma->device_prep_slave_sg = dw_edma_device_prep_slave_sg;
> --
> 2.51.0
>

