Return-Path: <dmaengine+bounces-11531-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WaGGHr8dMGrNNwUAu9opvQ
	(envelope-from <dmaengine+bounces-11531-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 17:43:59 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 328F6687D1F
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 17:43:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=iaVNGtoL;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11531-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-11531-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1AC98302BEED
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 15:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A616407574;
	Mon, 15 Jun 2026 15:41:39 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021131.outbound.protection.outlook.com [40.107.74.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9D4408039;
	Mon, 15 Jun 2026 15:41:36 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781538098; cv=fail; b=GDgzfXudPqKwIiLb4zD081K66dNtFvatyKXjXOm2kLBT9pwrzNjwdgoaZU76sn4VEv6NiEirzP36pzMIoUziqMzKmxjiZxkv1eitSRszKiZG7HZnt4Cal/a4wUJnDomfb85BaaYEall0dMSfM7B3Ze4njqzlV8/I9XYENJLS4lI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781538098; c=relaxed/simple;
	bh=NmM+GovyiP2CtqtO20u9xuvq5pClONTX761BKpp5AAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GtGDeSISO70AimaDjSCYmndef6if1By0bZP5eKIaN/dG1zrTdqxY5CopHaAiMyA3AUtXyo2Khgh/ZsbsDx8o9kXVkWFMrG9egpu/1y4xZ6lWYBSMCL9Bf3AIT2kwLw7eclfWg/NKg3aDtrsfIiy6W4xz7XR4I6F1cemvP/+VUck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=iaVNGtoL; arc=fail smtp.client-ip=40.107.74.131
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UsBkEEjGVqoynZhE525H8Kze2n04w8wqgqeFgGC0AZXGD7VcktaARb4n5hp+IMHmm8tTUVj1D3ykJ1JXVGoIQDDX8LBOGSFPxCdhxl1Oo/6FHzOGwnVn4VoKlb2hTWGTQVjpBf45XnWnR97TgBJMBvZr5AX+wSNbwLzDz1xCxlxiYavovF6syDhOiqG6h8Gj42KPiaShGlCnh2hD3hbkPGxB1TjZfQQRTOZnrdg0sCnK8Tfx7Cx0K6hY84AXnNYOOm7kRaSyCSzsOZvfUfKAxX++4jbEEj4DlV0ExyvGr/6zKYaHVgKAW/P/Ov6kjeyDETzrSuFS4cKOpOsHCcgBLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z4jmz5fCdgA9Iliyb2swUtUffFzP3+g6RmJOpsGHMBg=;
 b=op3UmpB8z/iGNtDaowLfwyxIngWhKu9eigsImM6LPozGSWgDytzamhDiKP0y2zNKeO/ddd77KSv6ZmAXhWMFchhdrJUZzSSeqPee9XQkWRqxKJg5DVVX3cKiMv4avJsvhMnxmsIj41qJbsfF4IaUcShq6Qv2oI8IgpfpQxvingvDoBWwapRZCaqPWCSb/noFXOgKkug0eLlypws6ELocAFI3BHVeLxEDk9/xInefUfRU+ey3YGyQoMat9K1+kpmSdIOWJPlTkDIx4n+jNyuEd/+e18XMh90kTO6B/SYHgwrVOX/kh3g8/58xmUR4DY7RsEBYFB2jIj9r37NSWk8h4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4jmz5fCdgA9Iliyb2swUtUffFzP3+g6RmJOpsGHMBg=;
 b=iaVNGtoLO7r+eD2sjksYxbBxCrd3JAmaR5pLRKYxQkDdTuJhW/ljl/8opW9tz6f8z8fvxuMS7dqRUL5VKGPB/6z0rBqAH0fQ1lxW+xt0QEsGR3C1dXYN/tvtSHVwUL/PvO45lK9dbHf9edU0uLKT50Mog55dhBoolKmSYVg5YcM=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY6P286MB7549.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:345::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 15:41:28 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 15:41:28 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
	Kees Cook <kees@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Christoph Hellwig <hch@lst.de>,
	Serge Semin <fancer.lancer@gmail.com>,
	Cai Huoqing <cai.huoqing@linux.dev>,
	Niklas Cassel <cassel@kernel.org>
Cc: Devendra K Verma <devendra.verma@amd.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/17] dmaengine: dw-edma: Make DMA link list work as a circular buffer
Date: Tue, 16 Jun 2026 00:41:02 +0900
Message-ID: <20260615154111.2174161-9-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260615154111.2174161-1-den@valinux.co.jp>
References: <20260615154111.2174161-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6PR01CA0012.jpnprd01.prod.outlook.com
 (2603:1096:405:3bc::17) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY6P286MB7549:EE_
X-MS-Office365-Filtering-Correlation-Id: e35f4963-d3d0-4570-4253-08decaf4908e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014|23010399003|921020|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	pB/EzNyBrbzqIsfdXOIp9EFCU0dHDOZpgvp98ND0ABW/SzRE1Fxehpph9BNbxjkLVq0bKu0WONvhEXKnQ6vPiGGdaWysW87UjQgqGXpItyltTlMmhIjE9NHA+1Rbt7AzmRKRRcsXSYMigCbmfugxTHgGnlVgFcoujXMKup0oKFLQokJGeaRF8uRRWB8Eff6wHUoOBE2SoTFeMsxL4Gq3HVjTjZABAeWJNAj2wJXC/o2mf5f5IzBGOAOxvG4P9J/SKnIo6iKMCTGB6al0vnL0saqS0YxY/ylQXhU7v9vCjqHJSfNEOraA+cv21piURQSTAGSAs6ITX4dP4DmG1y6hCb2PKlPHPye0eJnG4trfnFyUoaN8G8XMBu1RCSTFyuTHAOlZ/ntMsZ5fD1AKHsamF+75dJwsHpJbqppsALPXbSkV3qU7uIOSRhy1USz+027PUZz2xkRBSNbl1JBi3IauGmAzKuY10/ZRqK/C+a1LcB7Y7BblCAEPz85wk4GnUskGug8qS5BV2gy8Im4YZAXlGFeENTL7TZiqVe2CeRUc6ALExfu/RS0Xg5UTOgOLnFZRRfnGA+jFZWdctkPEqC+iAxuMdDS1ALMaWh1f13SVxWAghh1gX2KGBPCDFE+7zJQqPk5KSo371BC64TTzA9cYUWf1GbYl2ukgq8K3TKIrZpF4iILCcmd7WrIdVg95jqf6f8tETJho+JOajhgr1aKFZ52jWk0R9/fUqAUYYrlapep6qxr0HtvylL9B9maYMlwl
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(23010399003)(921020)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ttW1yWkCTqxR3h3+U2nRIPW4MhWmTL4bvU85DeHPBKWjaVTnwu16WtJk9uU+?=
 =?us-ascii?Q?lEEwCZZLjqo+seM69YgXCpuDGwElUXK9kVLYxzYyk+q82pdtWvqKZdz9A1yv?=
 =?us-ascii?Q?flkX+53tnsjXZ4WYMp+uCToemA3G3iyg6RrtWtaQcsZRCJWXRaQ/sjhTQsPo?=
 =?us-ascii?Q?l0C4q2FNF1g53xuExnTq4zWbZWOJsl3vCDSnPPfFJYlhG7T4xPTXSnhYXYUZ?=
 =?us-ascii?Q?87opIvhusDrZOrWOav6CNBWm+oiHgVteqM5ZxdQvmDYLgYB/8visstT5MgY0?=
 =?us-ascii?Q?TyTZrbVDeAzkz1vWsp2h8lEhD1ldcYq4IHYu79IZR5GdoTU/1z+kHurDZpRg?=
 =?us-ascii?Q?2bVO8RBdsdRaXZEIMIsY8LVqhWjCYz+aEVtewlFfUNDJfZ4XATKtwF2Vm4wJ?=
 =?us-ascii?Q?D44/dFOL5sIA2Xlo4x+jbb0HjOI/8f1n9iNrgvJFgflysMw+P5T0ZAhL4tfk?=
 =?us-ascii?Q?CTsVIKZmES8od/ecXzvCUUujRwLsLnfo5kYfodHZm1kAqoIRtd+6Feuy+ZDY?=
 =?us-ascii?Q?Lducnpb8OO2D8NU2X5u2PUJiLYCQZpaBCl5qQ7CY+VurhKiwHxCskgWWAIVu?=
 =?us-ascii?Q?B0Xd1qe1mcGDCVX4SVQ1TUfnCF+dEwYeQ8Fn0siqoXXF9q0en28Ou7ch/VGy?=
 =?us-ascii?Q?hXVKG87vx8iKI9pJXwY4UlNm7LqAnkflfYRGw9FFR3WWiIDa9pyFlTfVoICK?=
 =?us-ascii?Q?f61BUdmx22evVK0J1ZQVynWXltQbv6Rt9z9MILEuQGseUH1sKahwI258P9uf?=
 =?us-ascii?Q?TnSCDujs8RTFOyPyguFHe2hGKmewN9FE5JJ5Em40nHEBNZ4i9UZsTrTJta6b?=
 =?us-ascii?Q?7kF+cK/MmjV31ac7FPBdew1TDYu7cqF8CcNwSia1JgUjf/zcN+StxRODhIfU?=
 =?us-ascii?Q?J1cbabvg+hO2Er00msBciOUAOOmkIHHNN/6350oCpCTaA9W7jXQwxheWNxF3?=
 =?us-ascii?Q?n4RntH7aXlm6N8Tz0MJvnPoXqhhl/zFqd1azzI3drv9e+BuakroOinsGf96A?=
 =?us-ascii?Q?u3wmX1YtCZlsP3ExSUg6YZ48BpU0b0N/5TGRcPO7RTiviTyIIDJNNPGwROhT?=
 =?us-ascii?Q?JxVzCzssw3UUlQm2JrumBid6uJqAuDaHes1+VYgG3j/k+PIVM+oznrqWPRps?=
 =?us-ascii?Q?uG5WJ1uJJUVziqiHGuPq2FLFwqXcCbfcBFdErS0e+B7bR7QqgxmU0wWPz+vU?=
 =?us-ascii?Q?6qs0TaRuOktV/fa4+mNnVo1GSM8C4Mnf2YeLaXGhmEfH8R/rg++WU5GS2u2Z?=
 =?us-ascii?Q?tToulJD9EjOkTUc74wgpIQpgzZrbrju5nY7iVKxiZJC2ohH4I+Gc0DVkzzdJ?=
 =?us-ascii?Q?nDuRfE+vDQH2L43zKYU0HKf13q0s4x7vPU6gWPLo/2k26Ie72NkjuwdteTTx?=
 =?us-ascii?Q?1Uo+SHdNHoavDgORDeBxVUZlwTFwBok2Q5dfHcx9SCkB7gb0XuFRZWdrJ3WX?=
 =?us-ascii?Q?lc/TsgFsOfMw5REzjVzMoRMgQ366MCvSNxOKW5yNDtwSEVUOE4egoCef6Xsp?=
 =?us-ascii?Q?WERqYejNEiqSuernC6Vsjhs5hX+URHJvkhldCpw4Qs1N8rX3ICO94W0dBI8k?=
 =?us-ascii?Q?b86YpfoCulyharTc6rqUx5yrXxFBE86mIBH9SswDweYIJGvo4AFAAUT8XCMc?=
 =?us-ascii?Q?+07G+Ab8uODhzx12jWHeLdD770f6+ajlceuDBdkIhqebILbZRcSFygEa2wWB?=
 =?us-ascii?Q?LC7tZTpFaIyyBjbZv6HDHJlTMSzOb+OFEQERWO0KVfIu/RXFIulhVwuzma57?=
 =?us-ascii?Q?sXcKs9SFY85wp/iSYW7sQRJ2TNxqbYepW4pvgg1Wp7uhdxRFChMi?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: e35f4963-d3d0-4570-4253-08decaf4908e
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 15:41:27.9859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6MZpe8suedTBaBg6t7U+As3HM1l39Q4/odYPwfDfxcgF0VBA2pVgCg8a/GRUHHP3pJ57DQVC29BBpk8WUtoIeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY6P286MB7549
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11531-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_TO(0.00)[kernel.org,synopsys.com,google.com,lst.de,gmail.com,linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:Gustavo.Pimentel@synopsys.com,m:kees@kernel.org,m:kwilczynski@kernel.org,m:kishon@kernel.org,m:bhelgaas@google.com,m:hch@lst.de,m:fancer.lancer@gmail.com,m:cai.huoqing@linux.dev,m:cassel@kernel.org,m:devendra.verma@amd.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:fancerlancer@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,valinux.co.jp:dkim,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:from_mime,vger.kernel.org:from_smtp,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 328F6687D1F

From: Frank Li <Frank.Li@nxp.com>

The existing code rebuilds the entire link list from the beginning and
resets the DMA link header for each transfer, which is unnecessary.

The DMA link list can be treated as a circular buffer, where new DMA
requests are appended at ll_head with the appropriate CB flags and ring
the doorbell, without rebuilding the whole list.

Switch to this circular-buffer model to prepare for dynamically adding
new requests while the DMA engine is running.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
[den: fixed partial-append start_burst accounting; refreshed the fixed
 link element before each new lap; dropped the unused first argument;
 fixed checkpatch.pl issues; polished doorbell wording]
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Based on the original submission from Frank:
https://lore.kernel.org/dmaengine/20260109-edma_dymatic-v1-3-9a98c9c98536@nxp.com/

 drivers/dma/dw-edma/dw-edma-core.c | 71 +++++++++++++++++++++++-------
 drivers/dma/dw-edma/dw-edma-core.h | 25 ++++++++++-
 2 files changed, 79 insertions(+), 17 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 5e41b1aab450..cac03c59bfe4 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -52,7 +52,6 @@ dw_edma_alloc_desc(struct dw_edma_chan *chan, u32 nburst)
 
 	desc->chan = chan;
 	desc->nburst = nburst;
-	desc->cb = true;
 
 	return desc;
 }
@@ -62,27 +61,64 @@ static void vchan_free_desc(struct virt_dma_desc *vdesc)
 	kfree(vd2dw_edma_desc(vdesc));
 }
 
-static void dw_edma_core_start(struct dw_edma_desc *desc, bool first)
+static void dw_edma_core_reset_ll(struct dw_edma_chan *chan)
+{
+	chan->ll_head = 0;
+	chan->ll_end = 0;
+	chan->cb = true;
+
+	dw_edma_core_ll_link(chan, chan->ll_max - 1, chan->cb,
+			     chan->ll_region.paddr);
+
+	dw_edma_core_ch_enable(chan);
+}
+
+static u32 dw_edma_core_get_free_num(struct dw_edma_chan *chan)
+{
+	/*
+	 * Max entries is ll_max - 1 because last one used for link back to
+	 * start of ll_region.
+	 */
+	return (chan->ll_end + chan->ll_max - 2 - chan->ll_head) %
+		(chan->ll_max - 1);
+}
+
+static void dw_edma_core_start(struct dw_edma_desc *desc)
 {
 	struct dw_edma_chan *chan = desc->chan;
 	u32 i = 0;
+	u32 free;
+
+	for (i = desc->start_burst; i < desc->nburst; i++) {
+		free = dw_edma_core_get_free_num(chan);
 
-	for (i = 0; i < desc->nburst; i++) {
-		if (i == chan->ll_max - 1)
+		if (!free)
 			break;
 
-		dw_edma_core_ll_data(chan, &desc->burst[i + desc->start_burst],
-				     i, desc->cb,
-				     i == desc->nburst - 1 || i == chan->ll_max - 2);
-	}
+		/*
+		 * Refresh the link element before filling the last data slot so
+		 * the next lap has the updated CB value.
+		 */
+		if (chan->ll_head == chan->ll_max - 2)
+			dw_edma_core_ll_link(chan, chan->ll_max - 1, chan->cb,
+					     chan->ll_region.paddr);
 
-	desc->done_burst = desc->start_burst;
-	desc->start_burst += i;
+		/* Enable irq for last free entry or last burst */
+		dw_edma_core_ll_data(chan, &desc->burst[i],
+				     chan->ll_head, chan->cb,
+				     i == desc->nburst - 1 || free == 1);
+
+		chan->ll_head++;
 
-	dw_edma_core_ll_link(chan, i, desc->cb, chan->ll_region.paddr);
+		if (chan->ll_head == chan->ll_max - 1) {
+			chan->cb = !chan->cb;
+			chan->ll_head = 0;
+		}
+	}
 
-	if (first)
-		dw_edma_core_ch_enable(chan);
+	desc->done_burst = desc->start_burst;
+	desc->start_burst = i;
+	desc->ll_end = chan->ll_head;
 
 	dw_edma_core_ch_doorbell(chan);
 }
@@ -91,6 +127,10 @@ static int dw_edma_start_transfer(struct dw_edma_chan *chan)
 {
 	struct dw_edma_desc *desc;
 	struct virt_dma_desc *vd;
+	int index = dw_edma_core_ll_cur_idx(chan);
+
+	if (index < 0)
+		dw_edma_core_reset_ll(chan);
 
 	vd = vchan_next_desc(&chan->vc);
 	if (!vd)
@@ -100,9 +140,7 @@ static int dw_edma_start_transfer(struct dw_edma_chan *chan)
 	if (!desc)
 		return 0;
 
-	dw_edma_core_start(desc, !desc->start_burst);
-
-	desc->cb = !desc->cb;
+	dw_edma_core_start(desc);
 
 	return 1;
 }
@@ -569,6 +607,7 @@ static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
 							    DMA_TRANS_NOERROR);
 				list_del(&vd->node);
 				vchan_cookie_complete(vd);
+				chan->ll_end = desc->ll_end;
 			}
 
 			/* Continue transferring if there are remaining chunks or issued requests.
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index d68c4592c617..46af4ea3ae5f 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -60,9 +60,10 @@ struct dw_edma_desc {
 	u32				alloc_sz;
 	u32				xfer_sz;
 
+	u32				ll_end;
+
 	u32				done_burst;
 	u32				start_burst;
-	u8				cb;
 	u32				nburst;
 	struct dw_edma_burst            burst[] __counted_by(nburst);
 };
@@ -73,9 +74,31 @@ struct dw_edma_chan {
 	int				id;
 	enum dw_edma_dir		dir;
 
+	/*
+	 * New LL entries are appended at ll_head. Entries between ll_end
+	 * and ll_head, modulo the LL ring, are owned by DMA; the rest are
+	 * owned by software.
+	 *
+	 *   software-owned      DMA-owned       software-owned
+	 * +---------------+-------------------+---------------+
+	 * ^               ^                   ^
+	 * 0             ll_end              ll_head
+	 *
+	 * The link entry points back to the region start. ll_head == ll_end
+	 * means all entries are software-owned and previous DMA work is
+	 * done.
+	 *
+	 * Software always keeps at least one free entry, so the ring is
+	 * never completely DMA-owned.
+	 */
+	u32				ll_head;
+	u32				ll_end;
+
 	u32				ll_max;
 	struct dw_edma_region		ll_region;	/* Linked list */
 
+	bool				cb;
+
 	struct msi_msg			msi;
 
 	enum dw_edma_request		request;
-- 
2.51.0


