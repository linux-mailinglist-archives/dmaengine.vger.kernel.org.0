Return-Path: <dmaengine+bounces-12287-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WDVMKD+sUGrh3AIAu9opvQ
	(envelope-from <dmaengine+bounces-12287-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:24:31 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3464673867D
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:24:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=iDpRMSLM;
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12287-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12287-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB7833064D67
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 08:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273313F1672;
	Fri, 10 Jul 2026 08:15:40 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021109.outbound.protection.outlook.com [52.101.125.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C373F077C;
	Fri, 10 Jul 2026 08:15:38 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783671340; cv=fail; b=PBbmTJ3A24qDpmi+yvKJfIRoZM2eoI00Du+5BaFzn98Kewcox45myWchZuRbhnCjNmy8EBAHFu/CcF8Ew82B/qh3Elw9nzPCTHDjw4ryrT5UZ257w0YomYnvsXV6w3Mu7uLUbr6Ph9R7+OMLV+UdwhjoUw+EB2NOzmiIlFla1sI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783671340; c=relaxed/simple;
	bh=87Mi56zs6x+/foTeWZbyEoxJB5+XmWVMnc0D2d6xJzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XcIbfMQ9adA1+tUt7D9dPtlC4j/YNlulMACqA1Gz4OhO8sf1lgdJo8Kk37v9KRBrlPUqG9momxunbb1JtTkTKU0hEXQkvU7hL+5Q3y8UjJIzRVAR2fFFOJN+wZ6NMVXKHRJC8EGgP9lke94zDxI4iOxb5Tj+8ZcrYDjp/Evg2zk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=iDpRMSLM; arc=fail smtp.client-ip=52.101.125.109
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I/+glu6fRDXl6F5QzGo4kdIJqYK7sMqyLQXPe5Tb1ProTiTimWgTRs2hVxXyXWjuRWU7gHU2pwaW+rPAao40Qvvu3/YKwfenJqiO0k8SBNe8M2+vzbDfGE3rTmpYzjUzPgke9RUeSsFoYOCKRGUzjly27xnr6iJcndkHic5c2WO+Tz5ElLns1NkjNbIFGPaByLu1+UYPDRi9iqqayyN08fWqO9QKnsQBuGjjM0ykh1JBhEANJGbKfgwWVxcsLrjRZofOIjUxhFUtkCvakNSK2U/6CTwaRben3UnAjX76N/jZ11H7yhAQB5L0VZuT7zNo4pNsDoHIgMhxgw5JaNR0Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vnwah8BwHU6jK9arv+L3swOkgV4SpS0huuco/+51LZ4=;
 b=JT1fki+qJZ8zOjqsVaEzKdxDgefdk9e9SZU0APdO/fNE2nrjmpgUwjxDNO8e3RUZizOGolHIccwgijRIJHw/go9b/FDNgQVtERMWxA4cePC5G8eML8qBkcz1y/nODIR3S+E11qiVJTyA0/KxFUVwHAjuXlxluEnm0nAA+fQpO7w2mQZOyK4XdBN154zkJ1Ud739eHkKuQvt/8k2DwyASNH6TUTxdPkjGqMg8rOlPEOxudzMRPr6nMo3UdQ2KnkFlJrtyemRqJtQd04jDKMcto7cGbxHqv3PM8+rQHztg9mNzWwOK0ykyNvQ550v06Bqd+nCq3XdLKt0FYXHa6YsaSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vnwah8BwHU6jK9arv+L3swOkgV4SpS0huuco/+51LZ4=;
 b=iDpRMSLMFDO1A2fFj1DusH/Qf0349E52WA3JFBy+1aV4okmDsG/K5oARE2fNOIr7yuQoA5AyfJk89qUzvtlf8fgF3MTxUHXtG91JV+j3AaOkldpOrMA62vytN3MMv/4RX2Zp7UM8S6KMiI/wPOqdr/nW4ObeQTnqNsgBwNFHlPw=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB4074.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2cd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 08:15:32 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0181.009; Fri, 10 Jul 2026
 08:15:32 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 14/14] dmaengine: dw-edma: Program endpoint function numbers
Date: Fri, 10 Jul 2026 17:15:18 +0900
Message-ID: <20260710081518.2394357-15-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260710081518.2394357-1-den@valinux.co.jp>
References: <20260710081518.2394357-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0019.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::13) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB4074:EE_
X-MS-Office365-Filtering-Correlation-Id: a65dd1f4-40e1-4e59-56bf-08dede5b697f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|10070799003|23010399003|366016|5023799004|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	/5Ouw9D8+EMStllF8Syfxvf9QsxDP92mjyhRV0+qqT+7Ux5arBaF9DUBOGSVMXRSArHdRSvMuvK+0Q7uf6wuHcAce4FxD0kEKJt3I2ysL3bsMQ2PzetOa+GHmETTm2J4/eKAE6BMtIr/6uP483NMes/5Gb5vJdwH1Gw+4KDDxBJdZoUZinDfD3xBlajt67m1YLgBLCxxaTf09Wl4dudZmDYwcW9huSbKpoCYYphBY2i5lWCvOgEBA6FftEoPccXlJyjTPCaX7RZGgZY+ee2Yk9MdYz9ajufeQNUXLN5RpI3rW7ekvvnj0k/6O5lF3McKphStx2s22xmUqKMgynE8Os7YEUELLYpQ8SfLDNuozD1s7Bk/8CSBX+S3d5l/1/Rhapo+4G1rbxH6yJqDqs6Lvzj+BUc07Ao/irngBrl/Ozca7LXyZioxWyTduZR5Gdwo+9hmiMiGwp7D5zVWgKy17GnsY0HkRosshCNjQOW+QYGmVJVMzv+s1qQxD2e3uT3sx/ZVcNnKzCiWsc5DXtwSGfT52sURn1LpbP2AlwtOZZky6bsOBJXN2m/4kJqoyrqTBGDUFleSsa33N1xjcONbMWKrhgDDxqzodzEVlZ9rLOQMYTzig4f/ms005UomlINk1sYzw86JljNc8V3MideH/sxzaVmI9/0eVZuwlQN2/Xs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(23010399003)(366016)(5023799004)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5SDGRg5sZcrV3JYkUOgPp/04lPLIF2FX5Q6U6nJyrE1zPmEymcmn0tSwK8BU?=
 =?us-ascii?Q?8VvYhk/kOJYIDWNcmh7FSSnIZAcfz7kV2FOo2511A0hd/yOSXGlwoI8GQ89H?=
 =?us-ascii?Q?lEaGgTFdrf5sUrAT+h/jVSVWAjwmEmMmZx52lEHklKUCC/zLOERRUVgKqD/y?=
 =?us-ascii?Q?FIWUmQWC8dhT4vZGzJrwVXVDvAvpoTfOIMlqZUy5g+gdatqeoWgdl3xNdzcV?=
 =?us-ascii?Q?hqDqSIj5DGZFmB49GaQZ4y+xoz7s68njIFMaTkHquYkAotq2qdw4NygP/U0G?=
 =?us-ascii?Q?gYLaaETRd986+pxSm5tytYy4LYb4oZxRTHrRzoIj4JIJru9c1tTigcHglsEI?=
 =?us-ascii?Q?+itio9L/Gfk/5dtTvnwt2pNDcnGN+B9iQf7v/qPt6OmgSCZHv7lT3aY3rcZx?=
 =?us-ascii?Q?12VUhhSs77HjA5O2Hb8OAf3F61VfHBFtgGjeKQh7WqtE+vdnRapu7Pu2VTo9?=
 =?us-ascii?Q?/4kyhphh9VSw8heQexNG03z1VjQITi0iN4Ow8c0DfJXMHK6GSBAIuqfaTGF+?=
 =?us-ascii?Q?uB1WxYcv2lYPeuEiO5jZd1Awo16VTfD+/TCwzADAnMHb4ktNG9F17XXw6yvc?=
 =?us-ascii?Q?gGJ95WTA6hndLp6AUMx9uISv4p/kpa55EfbYvH4HFqLxHTDg1HmFPvjkBfF3?=
 =?us-ascii?Q?uoPoYY+dIRa9G95P5+BHETBakXKoYQb4Lk6q/vYyLiyj9VKNDHrXaan1PmWl?=
 =?us-ascii?Q?T0R6W3CAoLks0W8D2vhlNQAa68mUVVQfJWqqBbab6aySrv/UeMwdRAkPre8v?=
 =?us-ascii?Q?ctpEmseep4NwJvoAxtN1W+uqnjrXTgV8OnquQTiw1mpqr8ELg5Yy1NBE7FIx?=
 =?us-ascii?Q?cwprcbUTyUqzhNDVAXrF3fPnHP61HqK7uRflR8NeEz10Bbfx2KzgNenScAcN?=
 =?us-ascii?Q?uFCCmt583rsme7mdjX1Kcjy7odgmT0Rw0qNeSfARwE6Q1hfeB+Ra+i8F+wp0?=
 =?us-ascii?Q?XRsb2URKHzzVCgNugRyEk93CMXGa5HxhHDMCIiVYWkaTZ5LNqbZX6QgrUa2M?=
 =?us-ascii?Q?WbfbqKLMhxGB67GaEesBK1FPfxdAhMDqsBldayC/G55kJLLNeaNag68o9t7b?=
 =?us-ascii?Q?c8QZqPJ6m+m9YVRAxPwKML30Ru7PI/pbfwMibEwWC6aym6yz1OULbB6KUtOQ?=
 =?us-ascii?Q?mKWcmxDjrn4G1VALqe7UlmIhkEYWLSMqiwuFZSMvkd9R9TOH8oyuf8wu7Kx7?=
 =?us-ascii?Q?z4ZaTtJYnYEdOw7yxtLaPLwlKvqCTGzAyLzOCM4LqPP3XoCBOB308rXkOm9r?=
 =?us-ascii?Q?8tspni8jxe1/Kc4ZXxwGJicnoh8c6TLwDddstPlD+nZfOK2CaIReYAGdWwXk?=
 =?us-ascii?Q?9qtvgKtBGyX8UHF9pyEfjnjQ4BZgqPx6LpvBevUUdtsRBl9yrbVk33CbIosI?=
 =?us-ascii?Q?sU2n+8ZKgepZQPLAIrhhAaFPPSkpxtDWdSK7LJpSQfbQD2H1QWUKc+9bdTmx?=
 =?us-ascii?Q?F/uWIejE9+p24L/mYP+wgSF0zEqcQIXAdTk8vx9hh9WNAa/PD2ZIfogWk+0w?=
 =?us-ascii?Q?ydJeFXwVU9RY4KmEAfTwpQE/x2eNj1HSJjrmKisAhbxYDacKYNQoHf/Sglcd?=
 =?us-ascii?Q?iANiO5bK8pxJfnnnM402x3MOtscdE6gRrz/tqafndxo14nOe0jl3hSJ+ThgI?=
 =?us-ascii?Q?9ockTUQExNpCUPMN7HdByyOSVL6kYqr9hooztHFV3BjULgUn3av+7Tj6zQHt?=
 =?us-ascii?Q?1GJUiOptNWZNlaUXvGrdBg2mxnrOXJiYdIwbgKK67aavuto3zzZsS2mVg6xE?=
 =?us-ascii?Q?6MXIt9Yfxr3OtiEltAn+eGNmQKLUHn+0AF/zT6zdUUHq51xoUhgB?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: a65dd1f4-40e1-4e59-56bf-08dede5b697f
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 08:15:32.7170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TzGJdrgvl366FL1sIrBqEbzIBQkG25JDk688WNt5zSsEQx8DRX0dlNt3JW8LEJInm/wEXZ+BuYTjniepXeeElA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4074
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12287-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:mani@kernel.org,m:marek.vasut+renesas@mailbox.org,m:yoshihiro.shimoda.uh@renesas.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:marek.vasut@mailbox.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,valinux.co.jp:from_mime,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3464673867D

The eDMA/HDMA transfers the driver issues carry a requester function
number in their TLPs, but nothing ever programs it: eDMA v0 leaves the
FUNC_NUM field of the channel control word zero and HDMA leaves the
per-channel func_num register at its reset value, so every transfer is
attributed to function 0. That is invisible in single-function setups,
but once the DMA block serves a non-zero endpoint function, its
requests must carry that function's number for the host to attribute
and translate them correctly.

Record the function number in the chip data (PCI_FUNC() of the probing
device for dw-edma-pcie) and program it per channel.

Endpoint-local chip instances keep func_no at 0, so transfers issued by
the endpoint-side driver remain PF0-attributed. Delegated channels are
programmed by the host-side dw-edma-pcie instance when it takes over the
channel, using that instance's PCI_FUNC().

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v4:
  - New patch in v4.

 drivers/dma/dw-edma/dw-edma-core.c    |  1 +
 drivers/dma/dw-edma/dw-edma-core.h    |  1 +
 drivers/dma/dw-edma/dw-edma-pcie.c    |  1 +
 drivers/dma/dw-edma/dw-edma-v0-core.c | 10 +++++++++-
 drivers/dma/dw-edma/dw-hdma-v0-core.c |  3 +++
 drivers/dma/dw-edma/dw-hdma-v0-regs.h |  1 +
 include/linux/dma/edma.h              |  2 ++
 7 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 0d38de4480a0..d1af44124075 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -1016,6 +1016,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 		chan = &dw->chan[i];
 
 		chan->dw = dw;
+		chan->func_no = chip->func_no;
 
 		if (i < dw->wr_ch_cnt) {
 			chan->id = i;
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 8657275d2484..1cf95ab27071 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -78,6 +78,7 @@ struct dw_edma_chan {
 	struct dw_edma			*dw;
 	int				id;
 	enum dw_edma_dir		dir;
+	u8				func_no;
 
 	u32				ll_max;
 
diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index c1585c8ce11f..bb477dc0fb03 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -473,6 +473,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 
 	chip->mf = dma_data->mf;
 	chip->flags = match->chip_flags;
+	chip->func_no = PCI_FUNC(pdev->devfn);
 	chip->nr_irqs = nr_irqs;
 	chip->ops = match->plat_ops;
 	chip->cfg_non_ll = dma_data->cfg_non_ll;
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 32df5d13ba8b..441fa8f67d5a 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -25,6 +25,8 @@ enum dw_edma_control {
 	DW_EDMA_V0_LLE					= BIT(9),
 };
 
+#define EDMA_V0_FUNC_NUM_MASK				GENMASK(16, 12)
+
 static inline struct dw_edma_v0_regs __iomem *__dw_regs(struct dw_edma *dw)
 {
 	return dw->chip->reg_base;
@@ -159,6 +161,11 @@ static inline u32 readl_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
 #define GET_CH_32(dw, dir, ch, name) \
 	readl_ch(dw, dir, ch, &(__dw_ch_regs(dw, dir, ch)->name))
 
+static u32 dw_edma_v0_func_num(struct dw_edma_chan *chan)
+{
+	return FIELD_PREP(EDMA_V0_FUNC_NUM_MASK, chan->func_no);
+}
+
 /* eDMA management callbacks */
 static void dw_edma_v0_core_dir_off(struct dw_edma *dw, enum dw_edma_dir dir)
 {
@@ -474,7 +481,8 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 
 		/* Channel control */
 		SET_CH_32(dw, chan->dir, chan->id, ch_control1,
-			  (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
+			  DW_EDMA_V0_CCS | DW_EDMA_V0_LLE |
+			  dw_edma_v0_func_num(chan));
 		/* Linked list */
 		/* llp is not aligned on 64bit -> keep 32bit accesses */
 		SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index be22f9f811ca..ea9f18c8d707 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -375,6 +375,9 @@ static void dw_hdma_v0_core_ch_config(struct dw_edma_chan *chan)
 	SET_CH_32(dw, chan->dir, chan->id, msi_abort.msb, chan->msi.address_hi);
 	/* config MSI data */
 	SET_CH_32(dw, chan->dir, chan->id, msi_msgdata, chan->msi.data);
+	/* Configure the requester function number used by outbound TLPs. */
+	SET_CH_32(dw, chan->dir, chan->id, func_num,
+		  FIELD_PREP(HDMA_V0_FUNC_NUM_PF_MASK, chan->func_no));
 }
 
 /* HDMA debugfs callbacks */
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-regs.h b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
index 7759ba9b4850..2bbcc7fabb0a 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
+++ b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
@@ -24,6 +24,7 @@
 #define HDMA_V0_CONSUMER_CYCLE_BIT		BIT(0)
 #define HDMA_V0_DOORBELL_START			BIT(0)
 #define HDMA_V0_CH_STATUS_MASK			GENMASK(1, 0)
+#define HDMA_V0_FUNC_NUM_PF_MASK		GENMASK(7, 0)
 
 struct dw_hdma_v0_ch_regs {
 	u32 ch_en;				/* 0x0000 */
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index 3c33d12d1cdb..64044451d182 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -116,6 +116,7 @@ enum dw_edma_ch_irq_mode {
  * @db_irq:		 Virtual IRQ dedicated to interrupt emulation
  * @db_offset:		 Offset from DMA register base
  * @mf:			 DMA register map format
+ * @func_no:		 PCI endpoint function number used by DMA TLPs
  * @dw:			 struct dw_edma that is filled by dw_edma_probe()
  */
 struct dw_edma_chip {
@@ -141,6 +142,7 @@ struct dw_edma_chip {
 	resource_size_t		db_offset;
 
 	enum dw_edma_map_format	mf;
+	u8			func_no;
 
 	struct dw_edma		*dw;
 	bool			cfg_non_ll;
-- 
2.51.0


