Return-Path: <dmaengine+bounces-11716-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vGYbD5rmOGpnjwcAu9opvQ
	(envelope-from <dmaengine+bounces-11716-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 09:39:06 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB9F6AD4E1
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 09:39:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b="iV7YXq/t";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11716-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11716-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 42F01301DC32
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 07:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E103E36E47F;
	Mon, 22 Jun 2026 07:38:56 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021102.outbound.protection.outlook.com [40.107.74.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FE3345CAF;
	Mon, 22 Jun 2026 07:38:54 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782113936; cv=fail; b=HdUC0lMCpO45L5fhcXZqg/I3rlfwR6MLxe5iWXRzwrbJlvZJU9NuvYkBzQEUsHA0ejaVfNZKkAJYeWZubHRphjQfH7aPtDoaTnTwWac3I4v+1nNpO+0PtLL4dCLwi168A4AnXw321vz68d1rkEvZhQtiJ+skgY0MWWAKMIo7jtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782113936; c=relaxed/simple;
	bh=XzoRJKkl4kE8hAYAAgv1ybxv7Y1osYc1q9672JijAL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r12Ykm8xVjfSX3U1F0mTOswmjNF1T3PzybPmsQ+Z9SPjwW1DwivOJgWlsRiX6cNlixBaRFAq6LEuasB143LDZxXtjEBCoLXLYhrP097n8e9TK5sy6FSV8F0RVxfUwWx4Tu5Xuk4DgB1fqC8f2VMALqjlWH5fKooO1fmYKBSJAF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=iV7YXq/t; arc=fail smtp.client-ip=40.107.74.102
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=geb6lPpxt/XYMkKr4xjzGsW67W7pLGCXOVqRvZPoWbKSGHGJ1FfZLVRvi9vqDssTovhVjz8G9d4wuTBSkcVO1DF/Z04qh6p6C7AjIoyZV0LaT1LAMESMvhIPumc0ss1JsShrKhNkAhPSTC+sEM3y90MwXMxIkidadgbjZUVAE+mWX3MgU0m+SaBI/JnwFi1HOO+YVgxN9hG1XJlsc1vnSegi3xqvzV6PfzKzfIiFwhmb+mURkTPyo9BVNi98jFMoiUC1gKKjINeel3sPbvnIVdSfUJuxlMovHFDp8VHJXoZPH0oD/2GZGGkzBueDA1EBTuP8JJJjoZ9fsq/PHMT6yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ikj14hoCPDfp2e0TW+2YoMFho/gorAYy9S7bY09D0XQ=;
 b=jKz+dx2BOXuRy7oimOsqr2t/fcCHssnsXYqiYsnXMmsty/ACPBxlT1KGygsQEa/7PADBy8hWxycjtueGzab7gk+z9HxmKYfMUUrE5YfGVV2R3lW41gUcc+E3g2iUe3nrVGaXj81rfjzHGBW1m9h4AdVALAaiM3683O0xC061HIjFGCBWCYm6OeUq8uIvBCzIrpabjY+E4TW2+rtla4Aw9QDQX6wSDZgpyX4+B9OCKdHlP4+8+W5fTUQvPWHcdGvurpYT0wHRZXq4xi+buVUimPXPYUfxdItjYh0pVLjSYr6QI2aBY8udzULRqroWcoJCCoegLWhw+k8ITSMUHoRfow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ikj14hoCPDfp2e0TW+2YoMFho/gorAYy9S7bY09D0XQ=;
 b=iV7YXq/tLlIlosXSi2Cv43U+H+pE9DzrXhxdq/+7F2o0Y15PTzJA0Z+pseVJIwo4rpMKPGUo1S00m0TCX5sBGeBRNuosuPaLmsPzXeKCxXlQ1WY2DwUATQYTa6RXphE2kq0PTceRir1PGmK9lr4HJX7SPub1qoeVCQKziP+ROv4=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB4331.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:107::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 07:38:51 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 07:38:51 +0000
Date: Mon, 22 Jun 2026 16:38:49 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.Li@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/17] dmaengine: dw-edma: Support dynamic LL appends
Message-ID: <tau5svk3bcatzeapqeb6mun7dxi4ifk56g5ltkk366ljozjzit@vepneiac3f26>
References: <20260615154111.2174161-1-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615154111.2174161-1-den@valinux.co.jp>
X-ClientProxiedBy: TYWPR01CA0041.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::16) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB4331:EE_
X-MS-Office365-Filtering-Correlation-Id: 72e5d0a4-ebf9-4be7-55df-08ded0314de6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|23010399003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	XqJffLY/96s2xJzuU7q1YumxMsP2yf92gZ1O7ncjfJZiGCc8k1D3sld5gIDtXGXahAuZv2HzKsdstQch3OhcDFgRxdYAehy+fhPVvQ+A3VKECpFhjvWOAAxwPk4GtjFS/Odzz1WvrosOX+8ewddjgP0WiTAAd1MOszHal0Kbg5/1Azs0uIF8P9T7GiqamxHNNOTcnKwkXHnCvIXLnCcAos5dIc8plZgCE4CEZtXdUjhKmgGRJzPQ/ERxVORLOKlfddKITZiHFYFNEVZqNVhyF0HobTVY2vwGy9MXaOeslKXBpUYc8kHMnACBzgRbokfpO97q7xusBkAsrqHQWfLl0oCuQRSupcNprBCstE7+iUxStoCRiMti/TTdyV5b1jBx2djIKuctOFXVZmygoya/ZlJjGNj38TYvn+rZqHoAagkvyYlG724JC9+WJvSlKUdCo/32dpVJlfO8pRzyF7rA37O0otgR0c57IioJ9GmsbLMfOoMnO5v833vNFkesDeOgPx6yoCsd19N/Zz1CXT8uTBF3QCOG/nuJLJzuK26AI2EMHk4N/kSuCqBCcY4NVL3dKpCI9AczAno9QVbJX4cqDYsCYhZjc+CB+7+qwZMjzfMfDwrCNhqo65gEcf9GKbQ8kmWWNjTe3ZBaE1gd6n7DC6niwupGS3UcWubYg85NW2Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(23010399003)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BHWvVWUZvqBbdPkFGEFyUUorfRw6TBom+eP/UFT25yuIslKten5Jy2SC2AaV?=
 =?us-ascii?Q?heqKxUjZ2a07gydEBiouev+wFezp7Uk8BzU2V8gQL3NztVd4YIODNHk/FnKo?=
 =?us-ascii?Q?3A91xX+NtIJdaHSZfdF7HHgXhbf1S2jPYCWo2/pf27A86K3XJoK2pStoNmDb?=
 =?us-ascii?Q?q+sKQ2HT1S/+9KOAOYclnoRkEmVEOli5p/q7yyMdNxGcJRodR2sr8dzZjoKN?=
 =?us-ascii?Q?t+ZebuYwv/0pZBZSKKwUt7NjWipYWsOLGgpPiF8fPefUg93Aph+KYxVc5PCy?=
 =?us-ascii?Q?RYqMNON0Aa0NZPfFYIiPA399CInxjB7Uuwzq6TYqqLsJ0OLW7IedV5tGqNOf?=
 =?us-ascii?Q?sZKcD0ed11dt4LZ1CqPi+8vM135lqT0zVXPTsdIjyiMJpu2UWPKNKg4l1KjO?=
 =?us-ascii?Q?grfzyz0pP4YDqXbzJL/8HgTfZH901JfkxdYNMCiXfdIUN7EKw0X13YQ4PCKj?=
 =?us-ascii?Q?NPC18uPeoB4Hen6351GS0M7azLeUJlolvprftZi6qtVqqI/Xwfzg7eYBijBj?=
 =?us-ascii?Q?0rCKf0uMjdlDx05qsnOCTuE0iUrgGVIsPtamMNpR/MC0TVFn9GZ+6JTe70hL?=
 =?us-ascii?Q?YTvgD7qS4kKts81L3LleLxiw1xmPTO8Mzeh0NC8Ne9FTPdTx1rjdhzbAImUk?=
 =?us-ascii?Q?Vuyg53mYIMAiOfna25TjfxJPZ1jkXzmHqMR2TftTfQ+5ESNdmVTKbsjCmM+O?=
 =?us-ascii?Q?9H+zUOcG61M7XQBeI4mkOgaOK+D7FmYdyjXSc/iuIvHW0H50CEjd2zq5hM9B?=
 =?us-ascii?Q?UUo2ezIIL2kgu4dPPstkcYcuahmfGhOzG5QyOLHWa9bNnrtCmAuxoIgS3nei?=
 =?us-ascii?Q?sJIiGZ2frOalfGcS2cqB9m8gfnRyzP9xOjy9GcB6L9DQhX++DvT3hXHMbZs+?=
 =?us-ascii?Q?+7iSI9iq/WY486+hZK823M8YFSk0alm9eP8lyDOimW0sQ9ZvuP3WKmnaVdTh?=
 =?us-ascii?Q?2hmzV6J+2PGAPf1eFoEb+Q3vUwAmZ4kOVdp7QWBu1dblfhCmAPnc2x5yitWi?=
 =?us-ascii?Q?vrnS6crLHiCNkeJUmbT2imqexUFYBiXG82rYncMNWehCDWhjsaUxRxENfMBg?=
 =?us-ascii?Q?qdCItsctCOvpo5nfXL1gtpz5+UBllvAHFM7Jjn/xZVzEeh3KZURkz7LS0xjI?=
 =?us-ascii?Q?Kx7nwyvRJvdC8RV2yn+I1X/wESAzVJYNeoLgcRAShVmdtaIVOEYA4EiVYS0i?=
 =?us-ascii?Q?XPV6WWw+kllUV2eA4E1NZAIdW4uZGlZg3fALLVWUWJkB7aQJofeVbj6PncES?=
 =?us-ascii?Q?niF3FA+9oQ7v/ZUrxXjj9LC1duxAIIl/rpLqB6/TJmUXWlv02jAk1zVi9w/u?=
 =?us-ascii?Q?1sSPzp6ov1vhnFbi9zlyDl1CSeaTJiXAqKDrZVzhzCoQzNGC5VhbYNNR3Jip?=
 =?us-ascii?Q?3K4y5/mPJIduzCn7j2w3WMMMFVGW5F2r3zglxoXaoYrXcjeLEUwgL77whBTx?=
 =?us-ascii?Q?3Pn6xkaoMrKcXIqU/NpYzVTpTHPfX1FX5eubvcZGPr3fi5pDWFg3tcF7RYca?=
 =?us-ascii?Q?j7axC3rrBHLLGD19XEn7B6U0sFVAEx+Xt2B2Ok8bV4JzS6zOCRoU16nL5FwG?=
 =?us-ascii?Q?SG39SKY2sFNxUL6Mgmnp5Yl5HfWCR6DE9LS9arhl1M6uilbEMeWudWMFyXFl?=
 =?us-ascii?Q?v3VlsS4tj8b9twyyMOfIEDbs+UuzoS/xV33aMKORaTU0uVNbOBOXF3w1OdJH?=
 =?us-ascii?Q?iis5jGa24tHWEG5v4pfVwQ9hjZNrDCskwwS2kQ9cFGPva/VZ9oUPdr7fg3Yo?=
 =?us-ascii?Q?6mz+b6XgUk8E8iB822onZ8pbf2A0ZKCbJYUVrB5NsaZ1GEiVeLgf?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 72e5d0a4-ebf9-4be7-55df-08ded0314de6
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 07:38:51.4274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8xx5OE/YKEShx4l0nxnoWpiPbc82RWRVgfqjXECLcNgMuwXZO7PoHI3XgV1ZdqWNuZ9+4sMB/8f/i6sZaQx/cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB4331
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11716-lists,dmaengine=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:Frank.Li@kernel.org,m:cassel@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,valinux.co.jp:dkim,valinux.co.jp:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1AB9F6AD4E1

On Tue, Jun 16, 2026 at 12:40:54AM +0900, Koichiro Den wrote:
> Hi,
> 
> This series is a reworked version of Frank's earlier RFT series:
> 
>   https://lore.kernel.org/dmaengine/20260109-edma_dymatic-v1-0-9a98c9c98536@nxp.com/
> 
> After discussing the HDMA test results with Frank, I am sending this as a
> standalone series that keeps the main dynamic-append direction, while adding the
> fixes and HDMA handling needed to make it work reliably on both eDMA and HDMA.
> 
> Several patches are kept from, or based on, Frank's RFT series; the individual
> patches carry the corresponding attribution.
> 
> The series has been tested on both eDMA and HDMA systems. Both completed the fio
> test set reliably; performance results are shown below.
> 
> 
> Dependencies
> ============
> 
> 1). [PATCH v7 0/9] dmaengine: Add new API to combine configuration and descriptor preparation
>     https://lore.kernel.org/dmaengine/20260521-dma_prep_config-v7-0-1f73f4899883@nxp.com/
> 
> 2). [PATCH v2 00/11] dmaengine: dw-edma: flatten desc structions and simple code
>     https://lore.kernel.org/dmaengine/20260109-edma_ll-v2-0-5c0b27b2c664@nxp.com/
> 
> 
> Performance measurements
> ========================

Hi Frank, Niklas, all,

I am looking for a good way to stress PCIe controller DMA engines, such as
eDMA/HDMA, and measure their upper-bound throughput.

nvmet_pci_epf is useful since it is a real in-tree consumer, but it is not a
very direct benchmark for the DMA engine itself. So I wonder if
pci_endpoint_test would be a reasonable place to add an opt-in DMA performance
mode.

One possible option I have in mind is:

  - a new fixture, pci_ep_dma_perf
  - opt-in execution, for example with PCITEST_PERF=1 environment variable
  - a few variants such as single and sg, possibly with a few knobs:
     - PCITEST_PERF_NUM_WORKERS, to use multiple EP-side workers
     - PCITEST_PERF_NUM_CHANS, to use multiple DMA channels
     - perhaps other knobs for SG entry size, number of entries, etc.
  - the new tests: READ_PERF_TEST and WRITE_PERF_TEST

For the other possible places I could think of, this still seems to fit best in
pci_endpoint_test. For example, extending dmatest does not seem to fit well
because this needs both EP and RC side setup. A separate kselftest also feels
like it would duplicate a lot of pci_endpoint_test code. That said, I might be
missing something.

What do you think? Any thoughts or suggestions would be much appreciated.

Best regards,
Koichiro

