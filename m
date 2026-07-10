Return-Path: <dmaengine+bounces-12274-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pH0JD+KoUGoU3AIAu9opvQ
	(envelope-from <dmaengine+bounces-12274-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:10:10 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 551317384BE
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:10:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=ppxlGIg1;
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12274-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12274-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B32703022862
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 08:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2FB3EDE54;
	Fri, 10 Jul 2026 08:09:28 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020099.outbound.protection.outlook.com [52.101.228.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5AF3EE1FC;
	Fri, 10 Jul 2026 08:09:24 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783670967; cv=fail; b=ls3NNty+16veQkUJnfNRU4H6i4cHu8boDL025OavUuYv0ylvDt4Jp1yPY98nZEspIUSNe0K1A2aNkZiaaTSitId4WKTGtax4MHkWdgqwHSiTcQg/wiOugopom7++pboIusN+Cu7wAiP463hFXPUPViZnpHRxT3piJJEdR6uCl+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783670967; c=relaxed/simple;
	bh=vOv2kKC2LFA6Tli6D9iDpJCtk5vmYCuwgpXP8c2vX5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ENmi3o0FOw7PffmnqhXn+FZvP/WkEUGr6SnIx7jqm9lVn5eB9kgP90q/jnLepOYlO3rBQ5S0L4W267dgGRC4Lj9l/7Rc14gJZcvQ5ll2hrhzDd13IesXnJ4r0YYJe5yO3onHhn/ULSxqlM6oAcXUcJlBv1LN4fyX8X9a1Lhj63M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=ppxlGIg1; arc=fail smtp.client-ip=52.101.228.99
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=px9JdPZKYR/OTOBxS30KYGgIkYVeJ004hwG1rm+x05Y0ShWwWt5s4TdVqaM028AXJ/f6S/wNxu2UTVFjGKfcTw7sDpdSuzPisZCBq+EyOb/57nOR0dVh2BgsYz1PMQLhp5TnlEAFGfTrN7k/lnq3BBMbdzTJV47i1FzCK//UTrhaC+DcVLqWS/4Ayd3G5eeOJResgin9ZB0E/UcbxOAaYCF8HcVSGVO702eGbOQMwVkx1a5CRcdkzOurOvmZPADw7A5xVTD9WqxCaZ8gXsrrryOqPLkABh3GqeAQOU1/zkhHyIdREdEzKb8zV3nULo5Pf2QQOg18+ho+NZpTA94fHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hAeP5J7XdG/Q0tPRAxAxfYaVyzGEJPW9lXjvXEVWYlE=;
 b=VgkkqG6V+S79eSgTDH3c/hV6WgVLOrm9Tzge53Z+h50Ew7FVWKQVwU9A/8/fGvDt+7uev8taJJtsEhYFm+KOAzi8Mcrz/w9bFTA8NpZARF3AJdcfVfgSWvuZh3iss6L7o3DH4F6iPZqDnms3EY82qsTPfSlBvQLHheQeU5P3zWCuE4Sew8ree0i7afN27ETO/9eGgiwpXel/fiXtTpxjnMCSw5a56EAgWZPl1RqMcU5NOfv/fHdispVC68b0bqU8XdiDJJZ4BIDYx/yEEZOsnRk/LvMniRnYAZBk75Ho4CYZRbUTU+oKDbCndF08q6GfEyN8GRNvBqNCVoyXXOKAjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hAeP5J7XdG/Q0tPRAxAxfYaVyzGEJPW9lXjvXEVWYlE=;
 b=ppxlGIg11XRFoaNoN5n+1VjRW1u/BSaVu3M3cAYVtxxo2l/sU/W/9By5hIEYI/mc2pQWclbIMIbCrpWTzBo0nwE873M481ueXPDrfF7ejOmIEnjCn/6FRy4JD/Qgjx0Rex92PWdfsdlZK8gUqL4mofnL/MseW5DgvZy8nLPAFtE=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB6374.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:32e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 08:09:13 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0181.009; Fri, 10 Jul 2026
 08:09:13 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Cai Huoqing <cai.huoqing@linux.dev>,
	Serge Semin <fancer.lancer@gmail.com>,
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc: Devendra K Verma <devendra.verma@amd.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] dmaengine: dw-edma-pcie: Drop redundant pci_free_irq_vectors()
Date: Fri, 10 Jul 2026 17:09:01 +0900
Message-ID: <20260710080903.2392888-6-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260710080903.2392888-1-den@valinux.co.jp>
References: <20260710080903.2392888-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0084.jpnprd01.prod.outlook.com
 (2603:1096:405:36c::11) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB6374:EE_
X-MS-Office365-Filtering-Correlation-Id: a26a52ce-aa3c-4af5-de46-08dede5a87af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10070799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	W0RwPk75u3URLnvPDTt8ttLfMQkuVpWND8/2hDPW4VTz5F4O5LZY7POJSeFazfO7M2L7B7U39WJiu5nL7i9ziqRSVLEC3WPA4E6BAYd97RRmQ/ZnTiBJRCPrMA0z6vDYCrsqQjZSocyAvDvxxZ+AsvWzeevI2AUwSbhVC8wgxVo26OZpyMtzY/A4JDj4/z3UzmCZ1Fy7/BtSa6rTlTYa7gmQakbkB1H4bD74LAccafa5mf+PW+uBJXorN+63vYJ+6d3tIxfgfWW8O3F6NV/4xspeeizNumjcQ0BgrHG7okyWw9mhMu2/0t/j6o96KriBNAcianBhug/iw9T9LrwbQs78BoERRIctpjQH/8Vtl8sH0uTKFvzgPoGTmU09sRAyxDsFoWBSYCO6Y85/6EFXGhMrtTrQf59mazInPBw0BBOkh9UE/+v21QhKj5ZVOuoRsc1FdPQRAenDKpY7yHHoOwmcwwTOWXaS7mUYJyqoFB7ZCsF65Wtv8ngUPxEhZyssDShXIFiE1MOeewns7/z8AKmXpOB8wPkeYkR6JrSjTujQJoGpxKfSlc8FxZJCe9gvuyLamys+9OmkTOKGX5qMJdpKJnjnSmEaS9bcZl9a2Uj48MGKSCS8s1nwXCjpNprxuSnDqgFQ0dTMWq0w78TayBymL4GaijyrWNlPzVRgDZ4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10070799003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kn1xjEqJOPDE9d5ceDtMNUAMMlaFt9AkXu0Joa/oGnxhuCw284rGfq4reesG?=
 =?us-ascii?Q?VY1Z8jaeQ3uYu3H7iY5acdLHMYiIP1A6pFIbk0gsy5qia9XTmrDKQrAZv/n8?=
 =?us-ascii?Q?fm1JqpT3v3POoxaVPfrsXw/ju9ii3icEiGZH4q4yfsh4RIEVN3NdEtTUB0xV?=
 =?us-ascii?Q?fEWfUWyLnAMVMfyGWCsWpyUNdtXVDA2+h8H7A5C5x2darfQ5jljlIGOVND+T?=
 =?us-ascii?Q?CC5CnK5t9BF1RhIsKK1C0R7LrmcMbZJYI1Z6nD/lfUIh67ymbhB+n7y09Yzy?=
 =?us-ascii?Q?Rv27uo47uT7RciLmod5CYZ6xiCXnL1mX3D9LYXAv1Yz5pZnCwcd1tlzlVCwz?=
 =?us-ascii?Q?C6hE9/xHzvLUSmTRYGZ+dOuIHLP3mTYKosHbo7grSE118IxB6VDI+TAHSdAY?=
 =?us-ascii?Q?WqU1dUcYjDSMr7QwssbOtJhoaFNPNHh8ZEJozhPn4gDyZEqCW50QZs5qvptD?=
 =?us-ascii?Q?PsxjNruiRsl4fuiJcNIiefGNPQ1JybgLE37DCyGWBmSr+x8LOVbe76uXY9+F?=
 =?us-ascii?Q?+xH62oj6TgSgKS56/p1zeLyThUzToE0fair1L97Du/4RNTnWnAQvGQaMXeoC?=
 =?us-ascii?Q?KpuSP0lh6B4DwpgXxLuNMzukQaFYB02vs15zKetXlhrAUXJsu+wYjoKYljFX?=
 =?us-ascii?Q?TNxpHmzrOvBn4k70HUj1DZtHSYng4Xlov2pEAACUtRln9OJsLMMQ8s922UeC?=
 =?us-ascii?Q?fT7bk1GR6GBL6lHdrkR7ciql3msEMOO4pF9EgbHBabUSY/o5ti+z+WohJB40?=
 =?us-ascii?Q?gO1wYBTDhA9PHc0HynR5Oh3ISBnLjpdyciDpJFHeEXZg8U/lBlRjW/HwexnA?=
 =?us-ascii?Q?M4TustV4DVb/d60F0C4mRbYSWs5YyiT5qyVZ1e3LNUpYfy+fqDYiJyRZ147Q?=
 =?us-ascii?Q?TOiSuq3P924IH+BM0r2LgdqdRwDW3RH10auYuRu9LWT5Q27in+kbBYKmjPz2?=
 =?us-ascii?Q?Yo6a4ZD85sp5+biQAVL+a44b2R5Rx6Oy/m6fcNsYCFZiutirbD0HO8Po2kp2?=
 =?us-ascii?Q?gTGugJGDltQpI63kXAo62j3jXa5sXJoWOjOcW4X9dpgpIvQ1XGE2htNpdn6P?=
 =?us-ascii?Q?m/pJv0muEE1Z02FcI2YLqnmHUrO/4boDXKfPl32xn2tA/Yq1Qp3/ZGTFH1wK?=
 =?us-ascii?Q?nASwbtgpXvFZ1DY/KHz7knG3podvJnvdXGdrRr4/hoKbYXemQJ5wnXXmxCru?=
 =?us-ascii?Q?9s0FBd9dbUJ561VVss1vACPBKfnYwNp9/7Muf4K44BBig4pR5jmIP8E3OEl0?=
 =?us-ascii?Q?v9AHPwCrPsKn6joDR51moX3BkfbHpjfG/z+55Oo8JfOVRINozyvuuXL2wNuf?=
 =?us-ascii?Q?RUKgWyevyUbAJAWXXPbjbv3DaKDOUWFDbGzCGaLq1b7Jj1UNN1LRy/ercebv?=
 =?us-ascii?Q?7Q10xPI/Oas4U4Nn69ZlLQuj74PyYcdDo3kIaxY1gwlmCGlPoREux+vJk8xl?=
 =?us-ascii?Q?0vNmTXhfT+8n+MWlg/4FajjAdVQirLPA518S+pemrTpH/RC9MOvdborEL6mt?=
 =?us-ascii?Q?XgptYNpQ2kEW/t9zLkJXXPz9a6hEYDZmsESYVfcVTswJhUj4EjIao1gGGgzK?=
 =?us-ascii?Q?Nw+YcruJm2e0lXaMkglkQWDTLI1H0uS/U3sXmRbv2nms3p6tl1CKuo/IJWHk?=
 =?us-ascii?Q?xAobCBpbylysgLEXEHuQFT1fITR4q97P1zHh4n1HtAXlT5tUej7tLIFvNRD6?=
 =?us-ascii?Q?QOvgIyE4dpvho7xXifcOzmCVVVS1xocXHaITuneqzu9etFJWXeK2K7p7u/Hq?=
 =?us-ascii?Q?hs+yNtKpkVaBWXViZmFdH1sy1EorGKr7UOGIueohLm+fElLqtf2g?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: a26a52ce-aa3c-4af5-de46-08dede5a87af
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 08:09:13.8545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i5WYcBaDzFm2GTknxAS0qzTWJ5oXZb2cuaK0idbP/BEUzDyfuRJ86vhLp2psVbwy0ntXIUx9IgqIzRs+SPUPKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB6374
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,linux.dev,gmail.com,synopsys.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-12274-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:cai.huoqing@linux.dev,m:fancer.lancer@gmail.com,m:Gustavo.Pimentel@synopsys.com,m:devendra.verma@amd.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:fancerlancer@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,valinux.co.jp:from_mime,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 551317384BE

dw_edma_pcie enables the PCI device with pcim_enable_device(), so IRQ
vectors allocated by pci_alloc_irq_vectors() are released by
pcim_msi_release() on device release. The driver should not call
pci_free_irq_vectors() manually.

Drop the redundant remove-time cleanup and rely on the managed PCI
device lifetime instead, as documented by commit 03e4905402ae ("PCI/MSI:
Clarify pci_free_irq_vectors() usage for managed devices").

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v2:
  - New patch in v2, posted as part of this preparation series.

 drivers/dma/dw-edma/dw-edma-pcie.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 791c46e8ae4c..5e81a433a957 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -555,9 +555,6 @@ static void dw_edma_pcie_remove(struct pci_dev *pdev)
 	err = dw_edma_remove(chip);
 	if (err)
 		pci_warn(pdev, "can't remove device properly: %d\n", err);
-
-	/* Freeing IRQs */
-	pci_free_irq_vectors(pdev);
 }
 
 static const struct pci_device_id dw_edma_pcie_id_table[] = {
-- 
2.51.0


