Return-Path: <dmaengine+bounces-12422-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Dt14KOstVWrokwAAu9opvQ
	(envelope-from <dmaengine+bounces-12422-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 20:26:51 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BA974E778
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 20:26:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("body hash did not verify") header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=gZYZV24e;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12422-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12422-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C477130DA1F8
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 18:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E1E3537CE;
	Mon, 13 Jul 2026 18:22:46 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010010.outbound.protection.outlook.com [52.101.69.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA4E34D915;
	Mon, 13 Jul 2026 18:22:44 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783966966; cv=fail; b=BwopoeOYqPo7YNB3okfAf7YLdKijdXo2A7roeNvJ1dsbEuGOs/FnwrakHKgdw1KchOMVuh9qWnmfyt0/bwzMojpvsS34yHl5bCqNArQPCsmYfpNW+UOGXurNjmana5lUZi3jhqDC6e24ZJg8tvPMokOqu4gVMk1BFHshHPlHwJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783966966; c=relaxed/simple;
	bh=ZBTakGzLoUAf9bYD4ocpxAIDgzxwxER5luN2nO6ebd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dZ6kl/D9p3ZtY4rDJZTikh+7A4/d50w4h0Z/uk5mYq7Mj3VT7vgC2LYlSL2J4+05BLBzX0XzK7KrfQXSO2xzNXjDQ3CpqHe78DDpeNRuGo+kCg3BSZ34eFCPvLGPM0iGgdIC7nj/k/rUehya/tknwGy1mfunqEqewAmEl7uFkPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=fail (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=gZYZV24e reason="signature verification failed"; arc=fail smtp.client-ip=52.101.69.10
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QxeF4AyyjFI/fCwKC/H6ZxcOiLUzwagHS+3T0/N+FXTQHTN6drg9iLJ4MhzqlbYGwNUPZfm/+ar/NIxLkmIUMT6Ybd6/XJk6dvvu2aBmFy+fgNSLKdGm+19eGm3tbYH7xVkm4M1r+QnOk8rTt9tAAKrgMGgbduXHqPHpcALc28KUic7Yj/+2LuDqmkcR0/0HNhYXBGPU01Wz6dh74MMkAe1R98W2Rcx00QBeA2vMdoMZmUfW0abBNfM7n/cbk6kFQoMbApEcR2ZYaJMHsTtW7HspL01FVkiMtu25y3JT+53REv0UhPqSpwWiCXvvz4JNP979NzXe6Ngk2o11vEPDQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rx6wbK2YEAnQoyUq/Z2S8HR+2UOhbfY3BKMGChyDMpA=;
 b=rGQ+kNCCPllv6s4Lncd97p6AqhBX2jys+v/ZMwVW6axDTH/Fyon2B/0b9Ikm58CzYVdsFR7cNv9kJ5ZY7LsYMDOcmIavVygPn1zmPpLZx4z8yHnf8IO+FMPx8T8S3MaTRq6tzqpOb8LRQYgWBqAQn09z8y5SmCosm8vCknhjaNkwK2BNgaqgl5t+qybrCkzzF7P1ADRLQzOGTBc/1LKC1dgzzJbIZZxp8Wv4eRcMuX6FqsY3BQQ3p0+J3WGY65YXhPyv5chnuTqxileQpgsv9zY7gV+/86Xz32FM4cJqYY/WEXXf1E0Yu8xPMwhsJUsp4RzFq+LSYCJtr/ecycS8Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rx6wbK2YEAnQoyUq/Z2S8HR+2UOhbfY3BKMGChyDMpA=;
 b=gZYZV24eN0QkSxK08ctV8nFuw1evkyDFvkgRgPi2Q2/tPIwf5DGXCe9cVsi1illBk5trb6kLpxtGioGgGw78WimvsuqUB7QNC008m98QD/GOKf7pWuuTwq20uK/4kHt03+af8Aj5PbKxCmUD5EqP1qDc+7vDZwwpAv2EMYHJONCcsPUzbdnWYHysOZjeK0Uj56EktIQqFmRxemwENRMOJBDwWVITPUtjxZ/V85/i02YolzmdjJDyi/ikLL6POs9brPA+qxTM9kbhkN56/ADdn4vK0lJhsgYfzmjhGdqddatDletMEkihZ65op+XAgbClJ2t2i0gbgqAdHHjNh3mntw==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA4PR04MB7646.eurprd04.prod.outlook.com (2603:10a6:102:f3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 18:22:41 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0181.019; Mon, 13 Jul 2026
 18:22:41 +0000
Date: Mon, 13 Jul 2026 13:22:33 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: sashiko-reviews@lists.linux.dev
Cc: vkoul@kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
	imx@lists.linux.dev, Frank.Li@kernel.org
Subject: Re: [PATCH v7 01/10] dmaengine: dw-edma: Move control field update
 of DMA link to the last step
Message-ID: <alUs6X2OnZjzE4dF@SMW015318>
References: <20260713-edma_ll-v7-0-6fb7498c901e@nxp.com>
 <20260713-edma_ll-v7-1-6fb7498c901e@nxp.com>
 <20260713171252.03DA81F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260713171252.03DA81F000E9@smtp.kernel.org>
X-ClientProxiedBy: SA0PR11CA0200.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::25) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA4PR04MB7646:EE_
X-MS-Office365-Filtering-Correlation-Id: 35c79370-0b92-4f81-f38f-08dee10bb9c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|366016|1800799024|376014|22082099003|18002099003|6133799003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	RIHhQ3zzBw8bmHm2AV78wTTF7xKRrwVdm+HkxnRvGbKbuGGQQB6QjKOtvYIcrKNVlg5UaNsMwngV17h8me0VebRnc2cA6KUUAIBMyeD/RrmrN0WEP4OdJK4ElbI4h7GE+8apZH3BvLb3j37zz+gz+ckC1aI6HA2FVuNHdPO9jDil4QWXgeL7YO+K1EcKWC3FkMsStKL3s9LtAMGIyVBaVBxDAxfXRj2/beFmDXNlrfGKU4hD/sUGKxH9lR7w/6Jo8/18a9PjV05AzA5+9dE5736gmHoQopqkbLYsN3w4lJBI/2NPfXELKVyOJNltXiMNu7Vodun9T+SU4G+X1xnSiAkBjZ/DLqsQJryavmbsn1wEJGUZo3ZcwhvkMNhW2bf4tTq9EGRj4p04iEYZM1b6aQwVqDnORsMYSUsegiU4wSjTm0p1qVxiEkArzSE2O+ovUlwphAA7uD+NA65UT4OtTAnnkF+Q0U0669S+y2RlheyOif7dpBhB554IVHfTL70j5JNymiA73vPeDT/PBBHeg3+knqVslyt2vOhmy0Tt2MKAMsfb9PQt+c2WAaqPwkrZuaLKZqvkX/S/HbUv9ni4h/JyqayS9qmBs+Tbo86fBvI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(366016)(1800799024)(376014)(22082099003)(18002099003)(6133799003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?03dvk2u8LMZzxeuyaZLaYklySi5YNGU4o0nU69AhFZG8bjxnvqUxPQ9KRb?=
 =?iso-8859-1?Q?n3atiRhNgdM5B+mI/RZw7xuc11OFo7fqkeUtHkiMSeGfGOENz6tjq1jrYC?=
 =?iso-8859-1?Q?+9ho+FSy3PYwb6hAZ1z55uvQFUb01tl711tLd79x7BG+8DQiL5kuc87O0B?=
 =?iso-8859-1?Q?SQTKQPmgMX//aoBv9pNr3g/2Ml0n+QlNn3kTCNj1WL1Ji38iyArPe8uqKr?=
 =?iso-8859-1?Q?BBiKpwNa3aVhuW/AAzsu591hTVmw5f96Wmmcxz6X7RUfg1TKKtgv9I1Hl8?=
 =?iso-8859-1?Q?X6n3QWJFujteMRtt8xpuWdaDNDPLl7bDNg+/+4Ia88WFaSJCHzIS0NNtwY?=
 =?iso-8859-1?Q?VTU+zh8Qm3OxG52/sjaLcPyFFExdhyY5m1bJHaOQx5psAcMrP2oIrL1d6j?=
 =?iso-8859-1?Q?ErciNx3NVOCV50SEBGnwYLWI+3RGrgyppy9/2fzRu1MFWeOa9qc2wRvA43?=
 =?iso-8859-1?Q?1eyOtrBiweQJlS+0ofaegB9eIlHOaNEz8Q0YubEKWCfPUCkKxdln/LJoDG?=
 =?iso-8859-1?Q?2bflC2zt4FtTSZxeqG+Kh47jMmZbQMYuNa+56MOrcsQ8DKpXqAMSndoFyD?=
 =?iso-8859-1?Q?RqRppFfkjQ/bsayDMgj11LneCtFWYjS9fy3jRtBOk4eYyliw9L+R6gs4wx?=
 =?iso-8859-1?Q?VYE3uTbs1mFE5esUJi7B8XM/QMztq8WACd/N8s6PcLiQxnw8qJ9c7S4bhf?=
 =?iso-8859-1?Q?jRRj7JVMGa20AVEEg6momrxP46lWkGn1wl1Ak5cF6Q9PJTlLtQJWrSdK+E?=
 =?iso-8859-1?Q?vF2Zu4JEicvSmiLZliKUwWJge49QbC5zISm1BeFIqhMO1w25IMVS4V9hVR?=
 =?iso-8859-1?Q?nnqC2zy9bu5KUqtSQHDyOevWc+g9Xj67yvtunOXWM+mVM5htgDiWx0R2up?=
 =?iso-8859-1?Q?VGKcaCP/VPiqFOYjPbypeatLeXA/iLcXQ5S1os8G3wAbmkTvH/W6OxKtZ3?=
 =?iso-8859-1?Q?LOv1qMPtoWWru74McxhhfhHN4r0iNxVytsjqusV5oAzNopmBjdQDufwyXg?=
 =?iso-8859-1?Q?+4EURRVLWOe3XuQyFaricC1AmB/VKMRXo76Y1srVfstnJVHTq1ALZ9ohtY?=
 =?iso-8859-1?Q?xh+eH4efEPlCsma+UuPDL1EfYi5VYaXQLA58W5cAAQ33Fynu2hc2/7KJZp?=
 =?iso-8859-1?Q?VaVf+pfe2dR06ssi2Dty2xBxRxO8yk32330n4m00y6Vb7bwnRUaieTH+YH?=
 =?iso-8859-1?Q?pJccazO5FfACTiZU3xpLwSrkg5mWSVZtNA9b3ah+hOaJtdN4kjSvsuqoXy?=
 =?iso-8859-1?Q?zycXwMEeATl9CCd/5wkHGTieI5dmnjPbVfqfNqDg2GIj9pINouiDljrc68?=
 =?iso-8859-1?Q?pm6bsiJqI8C1Jhpaj1lIeEzivWhnXYyDdC+3/SaB9Kt6C4i2iMjr62xVZ8?=
 =?iso-8859-1?Q?2zda6iT+TvAsx9oDiI2KO+WxjxE7zY5YOwp7JDxQg3XejgQz+GViNuZ75i?=
 =?iso-8859-1?Q?OqfpPM4D4n6fwlHnLGn4S07DxKMd8EDxPivP/QmvD246FaBgKWMBxaehY6?=
 =?iso-8859-1?Q?iAIqC8Ry5m6Xs0iJ8lOuZq4JYqDVZT7whT65cbIYdHjX40h9WsB3bSWs9v?=
 =?iso-8859-1?Q?Yy6DiW2uHPJDRTWTgZPR4S7rxj+F5992eLaeRw850X/NW4NcJt9ASKMpfv?=
 =?iso-8859-1?Q?WLMNPqU/MqivuljKuVoHYBVEMMgLTd1y6KM3pCGqH/lRUELhbwc/GyU1i9?=
 =?iso-8859-1?Q?J7ocwM7MxXw/VBKm9Mjk74Th/VRqoHG0eyk8McMxUUrXOBVvaeo30xiCtd?=
 =?iso-8859-1?Q?DflPXLjamPeM5hjT4XH/Rg9BhAp58jpJBJ/Ok81XuZysyGa7Qrc5EuhNha?=
 =?iso-8859-1?Q?pj7sw+ZoSisMYxYR7/njEUneeOHWtx3XwS4oosKRK7BmRiXUn7qF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35c79370-0b92-4f81-f38f-08dee10bb9c4
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 18:22:41.3562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6NkRjhMuFZ6BBe7j6WtdSqXe28ZVputtwFDLXZeU+TXR1OqGWigIKA1NO78pk6/1drWHrqS7sAqjPoSbVD4o3v34hdIWvRGZDK/cNeGU7ZdKrgt9J4yWsCckl05vDWn8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7646
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.14 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12422-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:vkoul@kernel.org,m:linux-pci@vger.kernel.org,m:dmaengine@vger.kernel.org,m:imx@lists.linux.dev,m:Frank.Li@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:-];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,SMW015318:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F0BA974E778

On Mon, Jul 13, 2026 at 05:12:51PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Non-atomic update of the DMA descriptor trigger field (`control`) due to `__packed` struct layout and lack of `WRITE_ONCE()`, which undermines the safe concurrent DMA updates intended by the patch.
> --
>
> --- Patch [1]: [PATCH v7 01/10] dmaengine: dw-edma: Move control field update of DMA link to the last step ---
> commit bd1de63f1d8dc07b26abcdf63111eb18b82af133
> Author: Frank Li <Frank.Li@nxp.com>
>
> dmaengine: dw-edma: Move control field update of DMA link to the last step
>
> This patch reorders the initialization of the DMA link list entries to write
> the control field last, followed by a dma_wmb() barrier. This is intended
> to safely signal readiness to the hardware and prepare the driver for updating
> descriptors while the DMA is actively running.
>
> > diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > index cfdd6463252e6..ee5c3c317557b 100644
> > --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > @@ -284,17 +284,18 @@ static void dw_edma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
> >  	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
> >  		struct dw_edma_v0_lli *lli = chunk->ll_region.vaddr.mem + ofs;
> >
> > -		lli->control = control;
> >  		lli->transfer_size = size;
> >  		lli->sar.reg = sar;
> >  		lli->dar.reg = dar;
> > +		dma_wmb();
> > +		lli->control = control;
>
> [Severity: Medium]
> Will this assignment safely guarantee an atomic update for the hardware?
>
> Since struct dw_edma_v0_lli is defined as __packed, the compiler might emit
> byte-wise stores or tear the write instead of doing a single 32-bit store.
> Without WRITE_ONCE(), the compiler could also potentially reorder or split
> the store.

This problem is not existing because each field is 32bit aligned.

Frank

>
> If the goal is to safely update descriptors while the DMA is running, does
> this need to use WRITE_ONCE() (along with ensuring proper alignment) so the
> hardware doesn't observe a partially updated control field?
>
> >  	} else {
> >  		struct dw_edma_v0_lli __iomem *lli = chunk->ll_region.vaddr.io + ofs;
> >
> > -		writel(control, &lli->control);
> >  		writel(size, &lli->transfer_size);
> >  		writeq(sar, &lli->sar.reg);
> >  		writeq(dar, &lli->dar.reg);
> > +		writel(control, &lli->control);
> >  	}
> >  }
>
> [ ... ]
>
> > @@ -306,13 +307,14 @@ static void dw_edma_v0_write_ll_link(struct dw_edma_chunk *chunk,
> >  	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
> >  		struct dw_edma_v0_llp *llp = chunk->ll_region.vaddr.mem + ofs;
> >
> > -		llp->control = control;
> >  		llp->llp.reg = pointer;
> > +		dma_wmb();
> > +		llp->control = control;
>
> [Severity: Medium]
> Would this also need WRITE_ONCE() since struct dw_edma_v0_llp is a __packed
> struct?
>
> [ ... ]
>
> > diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > index 632abb8b481cf..1201f1ab5f359 100644
> > --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > @@ -160,17 +160,18 @@ static void dw_hdma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
> >  	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
> >  		struct dw_hdma_v0_lli *lli = chunk->ll_region.vaddr.mem + ofs;
> >
> > -		lli->control = control;
> >  		lli->transfer_size = size;
> >  		lli->sar.reg = sar;
> >  		lli->dar.reg = dar;
> > +		dma_wmb();
> > +		lli->control = control;
>
> [Severity: Medium]
> Similar to the v0_lli struct above, dw_hdma_v0_lli is also __packed. Could this
> store tear and cause the DMA hardware to observe an incomplete control field?
>
> >  	} else {
> >  		struct dw_hdma_v0_lli __iomem *lli = chunk->ll_region.vaddr.io + ofs;
> >
> > -		writel(control, &lli->control);
> >  		writel(size, &lli->transfer_size);
> >  		writeq(sar, &lli->sar.reg);
> >  		writeq(dar, &lli->dar.reg);
> > +		writel(control, &lli->control);
> >  	}
> >  }
>
> [ ... ]
>
> > @@ -182,13 +183,14 @@ static void dw_hdma_v0_write_ll_link(struct dw_edma_chunk *chunk,
> >  	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
> >  		struct dw_hdma_v0_llp *llp = chunk->ll_region.vaddr.mem + ofs;
> >
> > -		llp->control = control;
> >  		llp->llp.reg = pointer;
> > +		dma_wmb();
> > +		llp->control = control;
>
> [Severity: Medium]
> Could this assignment to the __packed dw_hdma_v0_llp struct tear as well?
>
> --
> Sashiko AI review · https://sashiko.dev/#/patchset/20260713-edma_ll-v7-0-6fb7498c901e@nxp.com?part=1

