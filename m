Return-Path: <dmaengine+bounces-10660-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDqEJnsgD2qnGAYAu9opvQ
	(envelope-from <dmaengine+bounces-10660-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 17:10:51 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 889AA5A8019
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 17:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 58D00305AF36
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 14:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253D73BD228;
	Thu, 21 May 2026 14:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="nncORnXH"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020089.outbound.protection.outlook.com [52.101.228.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09D93093D3;
	Thu, 21 May 2026 14:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779373327; cv=fail; b=PJNhW1Jb/dJTaWYq3VhQx5OUJ0fDpPAzSbWR4CCHIx4SLP8Bgae7PKpU+e+f3+PRfjZE5pnYYcSah8/D7w6XnEqwyXbv5G7JKZ26d6WzuM2oxsy+2SrlnAaaUHhDltsiKYuL0tD+JW6nAzvPpzXC/JsiitnmMfhAU/FjeXAUp7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779373327; c=relaxed/simple;
	bh=/dfUdUu+0QkJ3/n5gMc7xPvryI/LGij88z0sIM3kEug=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AjfHonHOVja1yxYWlt6HSu6zAP2S6zQ9oIbO84XWpRed8W6ZU+UUAfoPlPENiGniYi4sJEQDEoHHuZi9fxPCWo5fX6uDK0xyKG07GizNJSAhsoXMk/8Z+FCQTcbO1H23T1F4NNoqFWFuzIpGCR5xKNVVqrSWZPM8+AM3NL9ES3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=nncORnXH; arc=fail smtp.client-ip=52.101.228.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J9fr4oAPD5bKhEXxi+i6Rb0a7jbutrmqDpsIp0/g4AoPN3dElmJkAGgRA8V89dbV6RnEj5HL5MIVuu6Nqt/VK1MWjW8GtcqzgD2KqOvDMjg5fl1EKqtLTQPaQmaJHe+tmvEXsKFWC2VTFnUyAUGfGVSStFQJEnMimpBGYztLnw/kNcdqQ3hs2qjPFCjeFDNVvdY9DJXwC1re7PaXmlFcDCvWf6dx+EmZNcjeshaaeQYROopI4q+tvyj9DvQfg8qMBQI3ZWfmCZ5JTpCk7g/AZlB+ITBzJAr2qLuqYMoENL7VuJFbaJorDTuxURTNdz0ROTkWaiJeyRaJ5NXZge74Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=piN/lkaG0/qHFvooOhzlckE2cejxjBEYZiVJIrsnQ1o=;
 b=i8Qbk8H9b3doQIZc/OFzrT0NI24n/Rrk+TaZNtsrlX18qaXmQCioZbdHPjTJuKeAPzhZOCyEaeRUbOfFUvXmHQ4W+BJEXWC63b5K3xJ1MfWKqTPnJ9U4EjNouUAixHix9K7sOq1k7esRacFPDbZeCmuxrQkW16Iv5ZT3WJstcP7EWkueTLUKmD2FrnVZxjK770cxxfT9asWDQVab+0/CxmpO5Y3/+O6whR0oWSQgPOVlo5osqsYBna3gVabGTlBdbekjgaYOL2kUDYxvAqxH34iw8j8HMRO3K6QkYICURN8jbncJ1P/1bze0ImOp3LItoaF2JJtlWgiZpSg4sIeznQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=piN/lkaG0/qHFvooOhzlckE2cejxjBEYZiVJIrsnQ1o=;
 b=nncORnXHWjG8n87aboeqx3PhmDJoKdYDsaTEge5a/OB49iHdWx162NnL9UJyftxCWOpjjArt9kghMCLyCa1vP5Yf/BaEr6eOTElvxIXG+edUC4SbwHxh98y7JGuqCBMZvMPQs15lviNZSXXVNeey1QMLcrYNNy3jRGOJAERJbDU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB6259.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:32c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 14:22:00 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 14:21:59 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] dmaengine: dw-edma: Fix probe paths and register races
Date: Thu, 21 May 2026 23:21:49 +0900
Message-ID: <20260521142153.2957432-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0015.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::15) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB6259:EE_
X-MS-Office365-Filtering-Correlation-Id: fbdbb905-a77f-4d93-3bca-08deb74451e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	k50nXNi/NLtdb6Wy4veCbSUPJpPw620EqrhqxJXjIBZKBTpTBQctARQs2eZxHs6E6e9zF2kUgnSHg9DBnbQ2ENhvkAanD1U/LU9Hqz0mkvqhO2cNGF/PogkIxXynNxtA7OyZKcgmcL3dMyqu9RhbzZQqvwzrOjCeh+IRPvoVEqRGY89TvHgS++3dzSR2xnnR7l8p8cON1MsjDbns4KRVJOZ1bSZOz8ZbwjoevYs/xS3iy+ZqUv3rinhq0trZY7uE8JtuhtC4Ki/6CZQczAt2IxP7LnmRey58uT3fLuu+SpQ/N+NXhT2Uq1HqwJqUh8qyUD/bj5S/vFr3Ki++lFc/vcNc7AAYnMq85/FD1GyzmF5szzhrj/baI4EG25sL7ThWJndenQtngFPHXp0MpIvpbqAfAhuseTpHtBdzZV0mjV2ng1p+EGxkbmJfBjYHmWaYtdJLyGm11Uu+F++ZeZnAsp+b1s+m/8SmIjXY2Ywsi0sHqPlXCtmRDIA+ul8N2pPhfKJ+KU3SWiQAbB1oa7XjMFVTQaFk+TUn3+BJKOJYiLJSk+fuJXemmfN2L0WKfgii9Vjot7tooEMCtQBLaS8pVZ8eB573Vr36CqHMC9pIbZ1haQZP+Hw/CJISjxIGbCLnLDsfKQwegXnk1xel/yKsh+nIg/etngKmgJTlUZ3NECE6tXpxR4h8KfdpXEyrSYvD047UyfCICaiZn8i66He6cw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2rE1puhcS1fsA+eI0w37wxkoFrt8S7M/JXi8vShN1+lB9gAoO+CHTgEG/QQl?=
 =?us-ascii?Q?vDhdSHJEKA5tmWjrtjiL+C+OeBnlx4VjUt6FDuzARMp0ZNAPfZFwJbDda11B?=
 =?us-ascii?Q?nrRnRAG16GaS4QvSlJXI08DDdR7t9yThQblraTE0IK4yOt2qxGP0I82yOTxh?=
 =?us-ascii?Q?MG2rx34qAYxtrTw5P69ffAlu8AN9aw6N95fYfyJrbx+0Gn87PnWUcXoGST4s?=
 =?us-ascii?Q?XQ/sMIyWHgtePG2g9ue5pHb+9X7Ao2Boj8lqhGaEMhAjwxA3OBoJMmSIRPqY?=
 =?us-ascii?Q?ac9Xp+BPjAy8fFpeUSVwwOJVFc72/Q9PVlO6B8EjyriYh1Zxj632QlX1xeai?=
 =?us-ascii?Q?pJd36ZoH+xv1kVmpticC9eg71WzndAUbQdJ882/I/qGoiceI2O+42RS75w67?=
 =?us-ascii?Q?Gw+j0UXO8e8IkE+OqL9AkPo+xq61aiq73iIdDnAh8WNcX4KqbpoNTz0PPkNo?=
 =?us-ascii?Q?kl/T6AZGTWunbERAof7ssLkr8rzKvHEg95kBJjJ1P4AnDIHMuDO2+MW6Tm9I?=
 =?us-ascii?Q?3PkLC1RVDa7H1ELgEZHB/lnNvcyHjXXtmv9xUZi9szurvRxFOGh8rISITFlY?=
 =?us-ascii?Q?e9KpaQuCS8og195QLPgEA8FmRLjL/BaVUGTaOT3PFCmQ4iPe6U0/EjkIS9n8?=
 =?us-ascii?Q?48e1ZsYd6jhiOgKhU73AJRPxfBfsItWNcu9jO+hJr1FNbgjwoaoN4Ca3Iwek?=
 =?us-ascii?Q?sOZgnljyaiZgKyuJ3Xro5wEKHZqTrJweYyHvB0OgXpR8DLJZuD9ndT+TxXlw?=
 =?us-ascii?Q?M0rsnZd6ezyQFOodNLkKpC6q8k4LkcC2OCoUrDeFrA7YUCbAEUMqMVD4mB3L?=
 =?us-ascii?Q?JOLQgJs9+gN+Uvoeaf5c3iJNYKGCZVm80oDcpI7qDCQC4fjCuplnzQu4OGZS?=
 =?us-ascii?Q?+K0KNBczlwlNRemC8d1hc0YcbzmrQz/XPNpi24C7DoRK1vjbgAfOjznHtEjN?=
 =?us-ascii?Q?e4YXtZSxe+SFfVs6oRAJtV0nH87hTApbMlMa9fYS0VnOn4JTvylRmvS9ppPh?=
 =?us-ascii?Q?Rc3aAddi3zyh03QZthtqff2M8wc2STkh8hyc6ctou73GqmwSDBD8oxFtX4BT?=
 =?us-ascii?Q?tnd0UXNBQ+W0sgQJaKwXsKdy+SevJ82B0E1Op+Un/A0P+WXuMp93jBvAb+he?=
 =?us-ascii?Q?YuIJvgZXO14/KBSQ6yps8xjtKuKkF23SvF08IrstSiupzHiy+NRMQmOhxDDh?=
 =?us-ascii?Q?nf8xg/rna2dFBtrznuYdHGNl6QgxYYhmiAwTZjCi4/ocYVjZkA098l9CfWx+?=
 =?us-ascii?Q?kKhcsgvOQt7RVBT3Hs60UARRnrcuUKPMhoEQ9UGvbkDA8puMNBzfLbZH3CN8?=
 =?us-ascii?Q?6p8CEltU4KfE3qk6Om86HJ96NPg7rsrgtjZPGWu+IDD9e+KA/O5zVq23JVsc?=
 =?us-ascii?Q?8E26EHmooRIqe83HIcHKeq5csGNy8DCDzXEBFrxai1p6gLKOKoS07VOKbTi7?=
 =?us-ascii?Q?6X4daZCSO+xwaHYT/ilscgsGmi2HCi4zxfVbG2SgnwmGKPgGvhqVPZ3qrdCS?=
 =?us-ascii?Q?5+/sA/PlAWfe0zGQxbI8ID0zr4Tc12sc4qQY3yTn7DeH+H3MM6z6K5D5KHNV?=
 =?us-ascii?Q?m5Tjm684opwxsuzUUBg+dgbE6RFbgf+dbIWQJIOqGWYm3AX91+S+cbrH3F6M?=
 =?us-ascii?Q?e7ec+hzWyCQ9zQZnIg4nKStj9F8WCoUIXQcObKyUhNYCVbpUjzxp34XOyKtW?=
 =?us-ascii?Q?oNKgg7luMyV/Yj38QLg6k4ZU/DziDP0aDMh0xiq4v+WB1hcXMfpbdoQFY6pv?=
 =?us-ascii?Q?tH9a/Zu9cvHiJ5mp0msNmsUtLPwqRO6LjLLP1jsjKs+yhRIZT+KK?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: fbdbb905-a77f-4d93-3bca-08deb74451e4
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 14:21:59.3444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KsY32cH6jcmi9KaAihLHGvNkJUhpea1gwaug1Qdcj3TKSUXeBEDE9L+zZD4hekJM+Y8ySyeUFoCkAzxbSP69sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB6259
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10660-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:mid,valinux.co.jp:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 889AA5A8019
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

This series fixes pre-existing dw-edma issues flagged by Sashiko in:
https://lore.kernel.org/dmaengine/20260521063115.2842238-1-den@valinux.co.jp/

Note: Patch 4 was based on a patch Frank posted in January:
      https://lore.kernel.org/dmaengine/20260109-edma_ll-v2-1-5c0b27b2c664@nxp.com/
      Since it has not been merged, I included it here. Frank, please let me
      know if you prefer a different handling.

Best regards,
Koichiro


Frank Li (1):
  dmaengine: dw-edma: Add spinlock to protect DONE_INT_MASK and
    ABORT_INT_MASK

Koichiro Den (3):
  dmaengine: dw-edma-pcie: Free IRQ vectors on probe failures
  dmaengine: dw-edma-pcie: Reject devices without driver data
  dmaengine: dw-edma: Initialize IRQ data before requesting IRQs

 drivers/dma/dw-edma/dw-edma-core.c    |  3 +-
 drivers/dma/dw-edma/dw-edma-core.h    |  2 +-
 drivers/dma/dw-edma/dw-edma-pcie.c    | 42 +++++++++++++++++++--------
 drivers/dma/dw-edma/dw-edma-v0-core.c |  6 ++++
 4 files changed, 39 insertions(+), 14 deletions(-)

-- 
2.51.0


