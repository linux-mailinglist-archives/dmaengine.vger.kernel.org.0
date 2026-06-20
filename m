Return-Path: <dmaengine+bounces-11649-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9rLdBFfHNmoJEwcAu9opvQ
	(envelope-from <dmaengine+bounces-11649-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 19:01:11 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDEC6A943D
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 19:01:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=VQQ8CRzp;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11649-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11649-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E58D300ECB5
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 17:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDA625B086;
	Sat, 20 Jun 2026 17:01:01 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020101.outbound.protection.outlook.com [52.101.229.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16FA2571A9;
	Sat, 20 Jun 2026 17:00:59 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781974861; cv=fail; b=Kl3/ZHJEGoQ3XEtwYR0WZBcL1hqFpC/+ur0aQoK0zdvl5dRYE4PATdJm5tjVFhwZInJajQ7OLqD3FCJbIdklAQtoDYqgVAiGkhQFzAY63BrY7zQ3BA4CuI9qvZ+7iyHb8IptGOJOnZ9xQEJS7bSlEf1j0cnzn+0nPm18ZWjsGQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781974861; c=relaxed/simple;
	bh=PWlFiD3GsXSsRHlaicSBx461EDEjpMeVnFqCTKI45ag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cp26VrTCuK6+11cPzt8NXfxBMwJmBDIO0HG6ib08/JHYefW5XK3NvYinqKJ+Hs8mKO7DHGDWiO0L9IUud9UcPde93RNwHV4/BLQr8Deuno/AuwMlIKRfJVRSPq3lWKj2XEKsbLCOrXaY4JLUn+EhNsrOTOXUE267nhG7gR+XAbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=VQQ8CRzp; arc=fail smtp.client-ip=52.101.229.101
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pItavPI6j+qwszeLLFmQw0udBd+BO9w5cCXNbV7mkOWp6D2sETR/cieNoTN5EwK/VbJBcng8abrJKWNQekzcTq3ll3iYjEpmSyS7M/WqEkxCMGPnWayXZ4RWIeDZDBwDYzkBeUxrngyqUngEtZcrJHesoGAM46c8d4MLvKvmpe7jaxHJksuNqQmwMEQe9RHy3hz1t+vdR1n7F8cfvkhcxUwzD1pOmVABBNLn6aUpcMmWQ0n7OKhNEwR4tGL7keET4FEFnN9eXsiTftVs5AbMq93MooXvdWfRGPTg7pUmMTglZQ/sAirNHofg6qxlu/TLWr5KW/eh0Vuie8eOuwhNdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ruKdFXsnnnBz7G4EEFWs51tvC5VQ7x465H224cqB/ac=;
 b=HsvZSYOH9y/Y1xzo641HuzoeDdJ0/q8pfw3vTn1L2KDpp3UsIsmCCSoWpwZmIlJ413obKrlKC4NYWa3xdAbBQYxyezDRl3DahBjil3BIzA4EpQNp0FmY9NYF6yBVMIQwgx9sU/pLxadc3sgAvd4F1wEDOgJVohy6ZGLAFdbeV/htEqSnNSeRMAwbinNQshtwNn9RwRFLJYNwy0T1LHeLO4+Tnkso/ngN+dtcVZmpu8ZKWqkoaT4SmCSOpDdLS/OEVgBdH0GPeK78j89U6lUq92f+TFNSWsBzclBHgX11W8iI/Zo9nZXZ5ptKsfZWa74w3ydAj8Bujtz+ZrVSZTuZAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ruKdFXsnnnBz7G4EEFWs51tvC5VQ7x465H224cqB/ac=;
 b=VQQ8CRzpvC1RyBiG5MgjqlQPlSPVqE1HFNCnaaBAKKvF3bOumzrhqxgKEgLH5Ky3TuB7rdwN3Lhm5tfgKQjgIlwKB1Kh5SfCvRxE+z7RozTRahgyVoO4XJoDbCD9MwcqvgavvXGfOlk+zAAJnnNOaFCXmWUEzGvSXZV0cwdNfyA=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY3P286MB2673.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:254::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Sat, 20 Jun
 2026 17:00:54 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0139.009; Sat, 20 Jun 2026
 17:00:54 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/13] dmaengine: dw-edma: Add per-channel interrupt routing control
Date: Sun, 21 Jun 2026 02:00:28 +0900
Message-ID: <20260620170040.3756043-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260620170040.3756043-1-den@valinux.co.jp>
References: <20260620170040.3756043-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0057.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::20) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY3P286MB2673:EE_
X-MS-Office365-Filtering-Correlation-Id: ca5ff9a8-c0ff-48c2-551e-08deceed7dc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|10070799003|3023799007|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	/vrO6CL1qsPxjGStgcxsS2mPHQ+wogifcLygLHshNYt0xzbyZXF3Kxy+DcnmuKefJ/EOEVc/z9S/h/eiaf3DiLwXYJu5GgkGwBa6wV10YDUNVUacQjLSam5lCiDj6jDMJ+EUrORknuYtlFXBwQSGmohkW8FKo4pljgKqm7f8aVae+iFTk/6dd81ERd+j6duxqcmR6y2QmtftDKAa3zXujBtVNUb0KB706esm+I3rZtWWtBgXAskAGCfECInHf3jw0bEjr9DnldblM+6joEc+UE16VeqYB03gOyRs8yXiElqKSaR9qlrl1jTgVrzgk7iSyeQ1mNhFo2b9QsdWqSSgocM/4BcxWFLxnOxC0t5GzofLSSOareOurXwdKdDDtVWak3UAytnKppDgNFWtg6WhmV8uZyo/p4GEOlY0m5/NAQ1V27ejqqgey+fRHw53xFEW3d2v4e8VXeQKt3uynYA1468yF3vpT9c68pF8+hB0T4YhxzuXh13SU4ZKg9XnMWMvjKPzcU3WvTXorOMW23mrveHkBlEj3fjDiuLs716awuZtG9guyxqfrQNCvn+ID1vj33N8pAnd/v7pvD7BM3pe3+ccvW0Aa/ZuUW94vt6DrYZviXoIwTsMCJrFyTzvgT2+HTPmLEQF7p+ng37Ezy735soE7w4KjMV+VAfWMAt6iCc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10070799003)(3023799007)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CSWu7yePmv7XqqU9Toq/C1i1DgXhscXVkxGnroCfQOZXUKeUrP6xSh+mdZ5v?=
 =?us-ascii?Q?2JkLDyq/+WkQjot+mEu4MdFjs09XGE5cp86U6mCXfrEGtEUiYqrlBHws6gmM?=
 =?us-ascii?Q?ECERy9bqylYR5uBDYLyPhM8wxIXSGzQbq58iT6t2reUP/eTJu7xRPeoci8Yt?=
 =?us-ascii?Q?U+JWz7EquJT7BxsXQlMrnVRL4/p9q7gL57Vg5untzJ3Pe8T5z9Wv5dzqCTL+?=
 =?us-ascii?Q?BieDD0QlyHW5WC1uaIM1GFAL/RaPWvaTPRleZ8KxlghH2xNaHLCKOIGwAt65?=
 =?us-ascii?Q?Zm/EwPBBAF7xVjLASkUgIRj87dptW7LKw8kAo9xZxSGqU/ExlSsDo4E1byxE?=
 =?us-ascii?Q?TmFh03xP9lhuxjvCHv3ZiWP54JS8zogc61sPn4PLFeCW05FBbKth5/M7GCPM?=
 =?us-ascii?Q?gBODYHt/3NpnlrbE95ZgTYt1QtL8jppZPyEbe5d1girW/nolCtW3xEdVaoKe?=
 =?us-ascii?Q?CHCO6WrEQv0heEDLDtmtvo8bxob3tXDh65ue04WuLpCzPsADT3h5wm5b9nZu?=
 =?us-ascii?Q?TUzle9gTEYLyJ+d+ljJGMkAi3I7CQOt/qLl0MbjCBuGHFAuGz+p/JhMDTaUc?=
 =?us-ascii?Q?0tPTbG/Q4p/9nr0LOnKk1L3pag00WGxrHeDKlxpocS5rpnQieKT/3sHIoYAW?=
 =?us-ascii?Q?ykqV+RdAK8wP1QgCOF+xCnmH2ptqLKgt+oIFFBl1c4ACaVKJa0atHEOxM8bI?=
 =?us-ascii?Q?6Q7/k5gDwNcqr2Tel/ek3zLykVYz7zAeQmPB1WExvT0pueocNFOsTFTEXDqi?=
 =?us-ascii?Q?Wk2BE32d3kXYf+d//6AQUsCYa1yMIoRCN64ivclHOxe/Sp63dsxQARQcjz1R?=
 =?us-ascii?Q?UDkJa7eJIJ4GDTegZWIy5ujSIr/bi6w9FBr36bFIxslPORPwWAXcLiusS8q4?=
 =?us-ascii?Q?OudTyNpQuDYn8gRi6YJi+Znfoc8cWLewl5BwXzk5Z7ZGUqct5fzkzpoBb9XM?=
 =?us-ascii?Q?6V7ZuXTdhiXR3QnUWuZ9V3jNJ4uQYlQOxe33MYpuJCfSyNcYA/HlOozGoUBo?=
 =?us-ascii?Q?jqtH5ylO4FdfAL5yDsK02hFB1NVRe2y5eh/mOOvIMQI0xYxUvybovzIl3e9u?=
 =?us-ascii?Q?NKVHPGrqQw+yE499l4tPVWs0AIXA/TdYFq8FdVR/y6TkmGFvUmq/tG/dgDEL?=
 =?us-ascii?Q?jABlZvnlIbWW10iwl8oDdjkBeMHIiGPee5Ibeobf8SmNNfUvDlCAp2v+Evh8?=
 =?us-ascii?Q?HvcPWCSOuann1wwAQOgWymmTfCxLQ0FrsA9HeOuEESAd/s9JVnTOxIALs+fb?=
 =?us-ascii?Q?8gVJrCU39SmtYC2a17jecuEK2sftRkc1F2tMc21+rRPWs0VIdEtnUF29CZ1N?=
 =?us-ascii?Q?WKDe+NVUbYDSImOsB1T9dKyqrQs6vvr+xgk/A1CiiUywSe8koDgqGW5mbKAv?=
 =?us-ascii?Q?kXKrFSlF/QKtnoS1quggJ5pJuLs7yGh2vISvk9uaQ1LALpY9Q2X09NeMf30a?=
 =?us-ascii?Q?L4IYT9n94rPeJ2YYwS1lK/3REItsMzKdGavuzbBxOAY1ROZ2a2kjxUAOI1xZ?=
 =?us-ascii?Q?vrn+LsqbLRprNMPwStEDec2r3xx60COV+xgpaD9lrsdIWDkFbiLcsNM/DS2d?=
 =?us-ascii?Q?gzkFa7peuVm40MdFB458pvxUKZtSUjmK/zeisnzQxjxLgolvyDtrANvXuLOf?=
 =?us-ascii?Q?PVqxOsQUWnE+M+zlXLsJdPOWPVu7sygWSIwGaNt0qg7QKrVtdpUjHNxyCMNx?=
 =?us-ascii?Q?NRJHLIg6n3XOiUCMVNQ5GVp9iz/8D5ljXXCkRbkGIqX8DYqbZfLbmP6iIJi1?=
 =?us-ascii?Q?7HD9qsbWbTHzMmWTw6OzCG4jjiazt1+f+U6KiF4YO1ZoetyXy8h1?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ca5ff9a8-c0ff-48c2-551e-08deceed7dc8
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2026 17:00:54.6491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aHRXvfuF2UjMdrLKJQzcbr21ySzHlddUt/NIy03gTs0wQkZSWxkIgoN/D7Q79FfLuEsfvzbeLqX3F9WdloXOjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2673
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11649-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:mani@kernel.org,m:marek.vasut+renesas@mailbox.org,m:yoshihiro.shimoda.uh@renesas.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:marek.vasut@mailbox.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,valinux.co.jp:dkim,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9BDEC6A943D

DesignWare eDMA can signal completion locally through edma_int[] and
remotely through IMWr/MSI. When channels are delegated to a remote
frontend, the local endpoint side and the remote host side must not both
service the same DONE/ABORT status.

Add channel interrupt routing state and initialize it from the
controller instance configuration. Update the v0 eDMA and HDMA native
paths so linked-list interrupt generation, HDMA non-linked-list
interrupt enables, and DONE/ABORT masking follow the selected mode. For
HDMA native non-linked-list channels, use the dedicated remote
stop/abort enables without local stop/abort enables.

Keep the existing dw-edma-pcie host-side instances in remote interrupt
routing mode so their IMWr/MSI completion model remains unchanged after
local routing becomes the zero value.

Note that the routing mode describes where a channel should report
completion. It does not, by itself, say whether this dw-edma instance
owns the interrupt status. A local instance must ignore remote-only
channels, and a remote instance must ignore local-only channels, even if
such interrupts are unexpectedly delivered. Otherwise the non-owner side
could steal the interrupt from the owner by clearing shared DONE/ABORT
status.

Suggested-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v3:
  - Remove DW_EDMA_CH_IRQ_DEFAULT; local routing is the zero value
    (Frank).
  - Set existing dw-edma-pcie host-side instances to remote interrupt
    routing in this patch, preserving the legacy IMWr completion model.
  - Remove an unreachable HDMA native check (Sashiko).
  - Clarify local/remote instance ownership after Frank's question.
  - Mark non-owner IRQ handling guard paths unlikely.
  - Add HDMA native interrupt routing while keeping the existing non-LL
    int config ABI.
  - Keep HDMA native linked-list local interrupt generation enabled for
    remote-routed channels while masking the local edma_int[] output.
  - Use remote-only stop/abort enables for HDMA native non-LL remote-routed
    channels.
  - Drop the peripheral_config IRQ-routing ABI; initial routing comes from
    chip setup and channel ownership handoff can override it.
  - Keep dma_slave_config from resetting channel ownership routing.

 drivers/dma/dw-edma/dw-edma-core.c    | 14 +++++++++
 drivers/dma/dw-edma/dw-edma-core.h    | 13 +++++++++
 drivers/dma/dw-edma/dw-edma-pcie.c    |  1 +
 drivers/dma/dw-edma/dw-edma-v0-core.c | 22 ++++++++++----
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 41 ++++++++++++++++-----------
 include/linux/dma/edma.h              | 30 ++++++++++++++++++++
 6 files changed, 99 insertions(+), 22 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 89a4c498a17b..7a24248b84e9 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -219,6 +219,17 @@ static void dw_edma_device_caps(struct dma_chan *dchan,
 	}
 }
 
+static enum dw_edma_ch_irq_mode dw_edma_get_irq_mode(struct dw_edma_chan *chan)
+{
+	struct dw_edma_chip *chip = chan->dw->chip;
+
+	if (chip->irq_mode == DW_EDMA_CH_IRQ_REMOTE &&
+	    !(chip->flags & DW_EDMA_CHIP_LOCAL))
+		return DW_EDMA_CH_IRQ_REMOTE;
+
+	return DW_EDMA_CH_IRQ_LOCAL;
+}
+
 static int dw_edma_device_config(struct dma_chan *dchan,
 				 struct dma_slave_config *config)
 {
@@ -853,6 +864,8 @@ static int dw_edma_alloc_chan_resources(struct dma_chan *dchan)
 	if (chan->status != EDMA_ST_IDLE)
 		return -EBUSY;
 
+	chan->irq_mode = dw_edma_get_irq_mode(chan);
+
 	return 0;
 }
 
@@ -904,6 +917,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 		chan->configured = false;
 		chan->request = EDMA_REQ_NONE;
 		chan->status = EDMA_ST_IDLE;
+		chan->irq_mode = dw_edma_get_irq_mode(chan);
 
 		if (chan->dir == EDMA_DIR_WRITE)
 			chan->ll_max = (chip->ll_region_wr[chan->id].sz / EDMA_LL_SZ);
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 6474cacf7195..42f2f25ef377 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -81,6 +81,8 @@ struct dw_edma_chan {
 
 	struct msi_msg			msi;
 
+	enum dw_edma_ch_irq_mode	irq_mode;
+
 	enum dw_edma_request		request;
 	enum dw_edma_status		status;
 	u8				configured;
@@ -224,4 +226,15 @@ dw_edma_core_db_offset(struct dw_edma *dw)
 	return dw->core->db_offset(dw);
 }
 
+static inline bool
+dw_edma_core_ch_ignore_irq(struct dw_edma_chan *chan)
+{
+	struct dw_edma *dw = chan->dw;
+
+	if (dw->chip->flags & DW_EDMA_CHIP_LOCAL)
+		return chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE;
+	else
+		return chan->irq_mode == DW_EDMA_CH_IRQ_LOCAL;
+}
+
 #endif /* _DW_EDMA_CORE_H */
diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 791c46e8ae4c..70ea031147d1 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -419,6 +419,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	chip->dev = dev;
 
 	chip->mf = vsec_data->mf;
+	chip->irq_mode = DW_EDMA_CH_IRQ_REMOTE;
 	chip->nr_irqs = nr_irqs;
 	chip->ops = &dw_edma_pcie_plat_ops;
 	chip->cfg_non_ll = non_ll;
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index cfdd6463252e..1781ba4f022e 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -256,9 +256,11 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 	for_each_set_bit(pos, &val, total) {
 		chan = &dw->chan[pos + off];
 
+		if (unlikely(dw_edma_core_ch_ignore_irq(chan)))
+			continue;
+
 		dw_edma_v0_core_clear_done_int(chan);
 		done(chan);
-
 		ret = IRQ_HANDLED;
 	}
 
@@ -267,9 +269,11 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 	for_each_set_bit(pos, &val, total) {
 		chan = &dw->chan[pos + off];
 
+		if (unlikely(dw_edma_core_ch_ignore_irq(chan)))
+			continue;
+
 		dw_edma_v0_core_clear_abort_int(chan);
 		abort(chan);
-
 		ret = IRQ_HANDLED;
 	}
 
@@ -331,7 +335,8 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 		j--;
 		if (!j) {
 			control |= DW_EDMA_V0_LIE;
-			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
+			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) &&
+			    chan->irq_mode != DW_EDMA_CH_IRQ_LOCAL)
 				control |= DW_EDMA_V0_RIE;
 		}
 
@@ -408,12 +413,17 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 				break;
 			}
 		}
-		/* Interrupt unmask - done, abort */
+		/* Interrupt mask/unmask - done, abort */
 		raw_spin_lock_irqsave(&dw->lock, flags);
 
 		tmp = GET_RW_32(dw, chan->dir, int_mask);
-		tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
-		tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
+		if (chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE) {
+			tmp |= FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
+			tmp |= FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
+		} else {
+			tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
+			tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
+		}
 		SET_RW_32(dw, chan->dir, int_mask, tmp);
 		/* Linked list error */
 		tmp = GET_RW_32(dw, chan->dir, linked_list_err_en);
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 2beec876b184..7ba6bdbffc17 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -49,6 +49,26 @@ __dw_ch_regs(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch)
 		writel(value, &(__dw_ch_regs(dw, EDMA_DIR_READ, ch)->name));	\
 	} while (0)
 
+static u32 dw_hdma_v0_core_int_setup(struct dw_edma_chan *chan, u32 val)
+{
+	val &= ~(HDMA_V0_LOCAL_ABORT_INT_EN | HDMA_V0_REMOTE_ABORT_INT_EN |
+		 HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_REMOTE_STOP_INT_EN |
+		 HDMA_V0_ABORT_INT_MASK | HDMA_V0_STOP_INT_MASK);
+
+	if (chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE && chan->non_ll)
+		return val | HDMA_V0_REMOTE_ABORT_INT_EN |
+		       HDMA_V0_REMOTE_STOP_INT_EN;
+
+	if (chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE)
+		return val | HDMA_V0_LOCAL_ABORT_INT_EN |
+		       HDMA_V0_REMOTE_ABORT_INT_EN |
+		       HDMA_V0_LOCAL_STOP_INT_EN |
+		       HDMA_V0_REMOTE_STOP_INT_EN | HDMA_V0_ABORT_INT_MASK |
+		       HDMA_V0_STOP_INT_MASK;
+
+	return val | HDMA_V0_LOCAL_ABORT_INT_EN | HDMA_V0_LOCAL_STOP_INT_EN;
+}
+
 /* HDMA management callbacks */
 static void dw_hdma_v0_core_off(struct dw_edma *dw)
 {
@@ -132,6 +152,8 @@ dw_hdma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 
 	for_each_set_bit(pos, &mask, total) {
 		chan = &dw->chan[pos + off];
+		if (unlikely(dw_edma_core_ch_ignore_irq(chan)))
+			continue;
 
 		val = dw_hdma_v0_core_status_int(chan);
 		if (FIELD_GET(HDMA_V0_STOP_INT_MASK, val)) {
@@ -238,11 +260,7 @@ static void dw_hdma_v0_core_ll_start(struct dw_edma_chunk *chunk, bool first)
 		SET_CH_32(dw, chan->dir, chan->id, ch_en, BIT(0));
 		/* Interrupt unmask - stop, abort */
 		tmp = GET_CH_32(dw, chan->dir, chan->id, int_setup);
-		tmp &= ~(HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
-		/* Interrupt enable - stop, abort */
-		tmp |= HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_LOCAL_ABORT_INT_EN;
-		if (!(dw->chip->flags & DW_EDMA_CHIP_LOCAL))
-			tmp |= HDMA_V0_REMOTE_STOP_INT_EN | HDMA_V0_REMOTE_ABORT_INT_EN;
+		tmp = dw_hdma_v0_core_int_setup(chan, tmp);
 		SET_CH_32(dw, chan->dir, chan->id, int_setup, tmp);
 		/* Channel control */
 		SET_CH_32(dw, chan->dir, chan->id, control1, HDMA_V0_LINKLIST_EN);
@@ -293,17 +311,8 @@ static void dw_hdma_v0_core_non_ll_start(struct dw_edma_chunk *chunk)
 	SET_CH_32(dw, chan->dir, chan->id, transfer_size, child->sz);
 
 	/* Interrupt setup */
-	val = GET_CH_32(dw, chan->dir, chan->id, int_setup) |
-			HDMA_V0_STOP_INT_MASK |
-			HDMA_V0_ABORT_INT_MASK |
-			HDMA_V0_LOCAL_STOP_INT_EN |
-			HDMA_V0_LOCAL_ABORT_INT_EN;
-
-	if (!(dw->chip->flags & DW_EDMA_CHIP_LOCAL)) {
-		val |= HDMA_V0_REMOTE_STOP_INT_EN |
-		       HDMA_V0_REMOTE_ABORT_INT_EN;
-	}
-
+	val = GET_CH_32(dw, chan->dir, chan->id, int_setup);
+	val = dw_hdma_v0_core_int_setup(chan, val);
 	SET_CH_32(dw, chan->dir, chan->id, int_setup, val);
 
 	/* Channel control setup */
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index 1fafd5b0e315..c0906221a7c7 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -60,6 +60,34 @@ enum dw_edma_chip_flags {
 	DW_EDMA_CHIP_LOCAL	= BIT(0),
 };
 
+/**
+ * enum dw_edma_ch_irq_mode - per-channel interrupt routing control
+ * @DW_EDMA_CH_IRQ_LOCAL:     local interrupt only (edma_int[])
+ * @DW_EDMA_CH_IRQ_REMOTE:    remote interrupt only (IMWr/MSI), without
+ *                            delivering local edma_int[].
+ *
+ * DesignWare EP eDMA can signal interrupts locally through the edma_int[]
+ * bus, and remotely using posted memory writes (IMWr) that may be
+ * interpreted as MSI/MSI-X by the RC.
+ *
+ * For the v0 eDMA linked-list programming path, DMA_*_INT_MASK gates the local
+ * edma_int[] assertion, while there is no dedicated per-channel mask for IMWr
+ * generation. To request a remote-only interrupt, Synopsys recommends setting
+ * both LIE and RIE, and masking the local interrupt in DMA_*_INT_MASK. See the
+ * DesignWare endpoint databook 6.30a, Linked List Mode interrupt handling
+ * ("Software Programming of an Endpoint's LIE and RIE Bits for Linked List
+ * Transfers", Attention).
+ *
+ * HDMA linked-list watermark interrupts have the same LWIE/RWIE guidance. HDMA
+ * non-linked-list mode has dedicated local and remote stop/abort interrupt
+ * enables, and the remote CPU programming examples use remote enables without
+ * local enables.
+ */
+enum dw_edma_ch_irq_mode {
+	DW_EDMA_CH_IRQ_LOCAL	= 0,
+	DW_EDMA_CH_IRQ_REMOTE,
+};
+
 /**
  * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
  * @dev:		 struct device of the eDMA controller
@@ -76,6 +104,7 @@ enum dw_edma_chip_flags {
  * @db_irq:		 Virtual IRQ dedicated to interrupt emulation
  * @db_offset:		 Offset from DMA register base
  * @mf:			 DMA register map format
+ * @irq_mode:		 default per-channel interrupt routing
  * @dw:			 struct dw_edma that is filled by dw_edma_probe()
  */
 struct dw_edma_chip {
@@ -101,6 +130,7 @@ struct dw_edma_chip {
 	resource_size_t		db_offset;
 
 	enum dw_edma_map_format	mf;
+	enum dw_edma_ch_irq_mode	irq_mode;
 
 	struct dw_edma		*dw;
 	bool			cfg_non_ll;
-- 
2.51.0


