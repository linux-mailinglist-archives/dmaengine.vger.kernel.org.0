Return-Path: <dmaengine+bounces-9407-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKUxJ4jwsmlaRAAAu9opvQ
	(envelope-from <dmaengine+bounces-9407-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 17:57:44 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B2D276276
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 17:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E62D63217F4C
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 16:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6F23FE363;
	Thu, 12 Mar 2026 16:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="gOUcq0B/"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020091.outbound.protection.outlook.com [52.101.229.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC523FD13F;
	Thu, 12 Mar 2026 16:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773334251; cv=fail; b=MxrsJw/lnIkiVtddyJFVLfWTzqz/or8O0mGvXkXPlT9yCaNEnP4/m7EtmlXHT08G5ES+uRjaFsXf7UUKNTk4mnNu86xa2iS6Dkp7XQmxKI0qfJNRO962GxZfM2iaFtNVVaZqmnCV4URLY0MXmwRNGHpdiStlMPXfJIOk4gyWK4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773334251; c=relaxed/simple;
	bh=8RItrm2FU9WxewRnHNN6Y5e3vIhIssFp/dukGGv1AAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NSZHAuCpSUfSHq3vP/C3EU8UNAeMgKf7seHiFLAAoLEbtGvRKOQ5J5ALXdm/XMqbcLZHlwzjLIXSd1R1BSV/NXt1JLkj5wl/5DiReL/5SaaKJxWRbJHrQ8aVr4Hrk4ClKaDOSar0eZuLCnJ9ozvGUdD+7sK0LzyATNIGK+ROiGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=gOUcq0B/; arc=fail smtp.client-ip=52.101.229.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ClhP5yWn3x/xZMxiJkQ5prqZyTnHecsl/ng+ruh6rjA35y0/6xkI6q2GdD+n5bIlwwgpFp/mSb+v4ioELNyIAyLeP3wc1aHupEtraaN5HjJxQg1iyw7zxdpvpIHAYh4Wj1IuscEsBeHZSNKCX5vKHypCszyd7SdkoNl88yiNcpIfF+VKaFLUysRnDh1h7dwbZjqyGmofK+PdmdTuFvN1P3A2pMgaMDlm7aBlJ476+9nyiTZDLok40VQT90JGqaAADM7RvSKwVV1+gsyZ5w0IucDJMforKJheXyzjXLBpo4hyOikOjLQfmmcCe3X7UztIifciKcg6D3OWZeBCnwcfhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PNi1MkOWKGQnaowkzdZiofsqMmf/Q+GuHCrCK3dUivU=;
 b=Vws8rmZI+5OlEz24uUq9NsXDJA6LqMgRTkSHEojKLrJI08peDNBzik5162Z1wNHJzWzpHuoky1+byMHAKu+DOy6Rg0XZKP+RekaVVpkyl9r5Wt85sNEixfMmqA0O4x36MPjZe3OviHGyvWRjgJB45Ii/0PRRuZlKh4HRC0of2o8juMlXQK4kEZqXKaNHOimwvSDW3t2sBhdWWE2eg1/N3sQHiu5GrMD4JPa+lkh8B5nEJi97Z7dC1JZA0reasWTrh2D6LobL0vWqQ4kGOxi5rUyIid4rXP5bfMwD40R30muvp9GXLLrJFeU2yvQOUT+ngQkxYTiN3dMMhyDNsstddg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PNi1MkOWKGQnaowkzdZiofsqMmf/Q+GuHCrCK3dUivU=;
 b=gOUcq0B/J8NEpZXDSzh/qjPikTi+XA4/gNm6IeRUTJgI9U+qoDhFi36yVwABoX9IL6/hKFFNaBW5gZZVtI74tJ5o1b3SO6k8XELy5rmY0vmkQx+siZ98Fbsq8I/JGa4jeMnTn/w3ks/BRlk8zlkuuXXJRkuiiBTZUgYAblEcpKI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYCP286MB2018.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:15e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 16:50:20 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9700.013; Thu, 12 Mar 2026
 16:50:20 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Baruch Siach <baruch@tkos.co.il>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH 11/15] NTB: hw: epf: Parse control-layout version and DMA locator
Date: Fri, 13 Mar 2026 01:50:01 +0900
Message-ID: <20260312165005.1148676-12-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260312165005.1148676-1-den@valinux.co.jp>
References: <20260312165005.1148676-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0092.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::10) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYCP286MB2018:EE_
X-MS-Office365-Filtering-Correlation-Id: e320442e-fdab-410f-d358-08de80577245
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|7416014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	fM+AHO84IVnzdEvjdfGujk3fBUm7Ihlw24DxK66d6z1PkZKLW9wVEjxIw/1U51yEzPtYejAqI2C2pJSTvWmFm0VzFgpCkuZqRyak7ze1SSKHDBpVSHSA7DLie2IQl47Kq3siNTXPEfLi9hgPkWbBMh3oK9PVk3XLGFZUTfWhr98lq3janu+eDSsoFVMEpzhY6VcicosrgkweffQy2ooJJkUY5aaRPr9cjOvO/wxFjM4psJ6LO91F6uceYhXE6R3GZ7Xl0HGMXa4CqHZHHyuVHzSSWwnfSGLAyScNzfw3gr/3lvOnQjBBSBbQYri24OL7SPYWxrlLDEFhJuUpPbNafrS8AiRhfCLiyC6UAzGxfcfRR/VbWpIaE0CU8jiY0jwhPfre7t1I1M9MHRCAX7U8fYJuuWkMxjHgIFJO3HcNSBm2lX1IcjzcLAsX2MxCWMT0KmzTJwyKmWIxiwbCgCGcOTmbB6iTnc42/N7YfP2NZ58Gb6q2uefGqG3rG7cohgo8HvebnTvHdrkbqiC53bhkUnChr/uGUL6H39c+w3eilslfGpLlOYS+3jieOAgdP0eCXdEvmXtMxbRxKHoKKNVxkbITPMZJVzbojYkl5yK9Qhxk17Q27RPV8pCstU3t6CxRlEM4AnjQixJUlH3PMw+E7Y0TdzBzDPGPO4raqCE2JUxm/zqHAt9nf0QB99PHeVu8pHXg0mfEnioBy2JXbduUr3yxUWD+DBhhAkWxffLhbvkxoOuZ4hxUfKBnqq0tHqhkdlNAuzhFlrwyfgrEcJRJQQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(7416014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CVwS5+9fS8E+91cvUytpEXTtP3zjQ5leRbi9no85x9h9PxTQB6UqhH3Dq0Co?=
 =?us-ascii?Q?R+t8aCEhqHGgXnCerAzc5z/GHIYPq7H0G92Xqq1O4NiG519vCziVgGlb9n8f?=
 =?us-ascii?Q?ZQM2ppQ8ou6QYLwDVYsMv03KpleazpTNrZrNsYH9u9x1FK0JvWP/f+pzNUuD?=
 =?us-ascii?Q?Yx53FdyN15f62ceePOZ0RB8AnV8iMPhDWGcL3XlxXJooB/5MjMCv9DOqsIRC?=
 =?us-ascii?Q?9rjJ8ePhTxro3mwiIlquZCp9qjUGPJ5y1nXu/OHdR4HVBW9/Juqm6vUy+r3I?=
 =?us-ascii?Q?PbQgbrQaoeo7jQ9ufsYTd9LDGfMGvpwFUhYV04+clzgynkskDWVr6lnNP1OB?=
 =?us-ascii?Q?pmcYQ99c8yVgC0OJF7laJePEwMpgj5uybsNRMtN73usI2KKS1Nrb1/dMw4L8?=
 =?us-ascii?Q?/M9e352sbsg5bwxUYkm2o8jXR6/wYnB/hr4JJJjzdlcJdGtpY3MzQS3EHp/8?=
 =?us-ascii?Q?RATLWF9sxrarzGf17vPOGg4ZJW+oeSlwa+ref1auQjc0N5E1+1Cfx05yjOye?=
 =?us-ascii?Q?O5/8QWYzgF4ysW51u5GgoRQMbGKQ6jn5k37fnBASv76jljlgyP7B4n14tIZV?=
 =?us-ascii?Q?VeUBijA561DHswIS9MY0VWtGmgBbE30bDvy0PJ9zOBC2xmtitNkHd5TcKozb?=
 =?us-ascii?Q?jaNdKtInDz2JJNywr0hDUl95JPvfAV7801vIiAouk5ixd6Vn6JIyhwJfJZCO?=
 =?us-ascii?Q?WlL+b2gtjCwBBmiKTD7s564nT0q12SRT80FnvdxfIsW1iRiDmayaRT46njxw?=
 =?us-ascii?Q?B4OjQE2vjqhoUAVepmfEsmt+TXLHNoLsc08X7LZjJlKx+MgO/eQPQhL8/J4X?=
 =?us-ascii?Q?ORb82Xqk6+Y/z8kHUXM8fOcKE1BTHfQFyzJDr/VvL57qeWTWGxak05R5E9wz?=
 =?us-ascii?Q?iu10cmmYozmZinWfGaK3Hr9ltdJAIL2v7sd/RqYxXqMnMfnIfxB3bt1fSwcr?=
 =?us-ascii?Q?AzSX99prlp3XV8m+xy150pM7AJ8qpJ6STSDA1blHTzACgg2IRvejizBwQD+1?=
 =?us-ascii?Q?Mz6hgIGhiFuJMOh9KICiexWchnYmAkoPoJ99PJCow1hDghtITtluet+5nLL7?=
 =?us-ascii?Q?eOtT1LVKnDLIxfszx+M3nlFUDgZ/v1BVEtgNvq+bKcfv4KJuno0LfVj7DzBo?=
 =?us-ascii?Q?LCNhFcit8DPhNGHM6Pqs6fj0YcPa79gLy5gE1edg5bRBX2Mu53gZSX/fY/Er?=
 =?us-ascii?Q?MzA87iZHjACaJNYHFO1fUak8k+wrFlSy5Oli2GFA0DkoQw7UXzATqfkBZ4pK?=
 =?us-ascii?Q?8MmHvgR1Ah0CTGSNyQ/fWVMwn1zIR3T1GmXDGOn6MvPfnTuiZ9wqBBgWPD/F?=
 =?us-ascii?Q?neOBFCZr0GktAlfA2xU5vzpdEvWi0y8sveVyR4oDestv4EF2wTCAP1+Kj3+F?=
 =?us-ascii?Q?mAJ6vPYX15DIf1fz62hS/h5Wv1UIo6Cdn50WYAaU3G+ci8ldQd8Pel3/q58F?=
 =?us-ascii?Q?7UIRdjBKgt6SijYYEnq+v2zLVoo8g5rWBvZSHdS5IgVoCLv8Z3cSXyDULw7r?=
 =?us-ascii?Q?BpkBpiQtZLNxEo52e4BsrPsOTqPqQNjMcthgOZH65Ohm0r/Rj07q3gr4YVp/?=
 =?us-ascii?Q?gf86oQmV7NSgLqxuESiN3qZU9a3Zr3/0SlaJQtnhlZPjjOhFdReqeubcTLui?=
 =?us-ascii?Q?wSMMsxYSL6aRxilr+s9RmmFKkWwluvUtuP7FB0083oFGb61A/RKWYeqLW+Hq?=
 =?us-ascii?Q?Znni07xyXtWHjkUgntsM6qI1nfY0jA88qenjyFOiDCZkv3kQGmT6WNR5eiGf?=
 =?us-ascii?Q?AdvivQ5PVcBjIIvjUPDLsBAUsd2qZDyr9vziVZ2yiKsYMzbuM+mE?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: e320442e-fdab-410f-d358-08de80577245
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 16:50:20.1357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cMY0ztsUzdGiZ3EP5YNsWbP+4Mv1bxNmDveHzQ3rtSCFH7PrzqHy/wYqInDNSP9clRslozsm1ffhxlD5IIDI0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2018
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9407-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,google.com,lwn.net,linuxfoundation.org,kudzu.us,intel.com,gmail.com,tkos.co.il,baylibre.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,valinux.co.jp:dkim,valinux.co.jp:email,valinux.co.jp:mid]
X-Rspamd-Queue-Id: 45B2D276276
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

pci-epf-vntb can now expose either the historical control layout or a
versioned extension that carries per-MW offset/size tuples and an
optional DMA locator.

Teach ntb_hw_epf to parse the control-layout version first, keep
accepting the legacy format, and use the explicit MW size information
when version 1 is present. Also parse the DMA locator and cache its BAR,
offset, size, ABI, and channel count for the follow-up enumeration step.

Finally, reserve the tail of the MSI/MSI-X vector allocation for the
exported DMA child so ntb_hw_epf only requests the link and doorbell
vectors it owns.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/hw/epf/ntb_hw_epf.c | 112 +++++++++++++++++++++++++++++---
 1 file changed, 104 insertions(+), 8 deletions(-)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index d420699ff7d6..6b427577b1bd 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -31,7 +31,14 @@
 #define NTB_EPF_LINK_STATUS	0x0A
 #define LINK_STATUS_UP		BIT(0)
 
-#define NTB_EPF_TOPOLOGY	0x0C
+/*
+ * 0x0C was historically NTB_EPF_TOPOLOGY, but neither ntb_hw_epf nor
+ * pci-epf-{v,}ntb ever consumed it. Reuse it as a control-layout version
+ * selector while keeping 0 as the legacy format.
+ */
+#define NTB_EPF_CTRL_VERSION	0x0C
+#define NTB_EPF_CTRL_VERSION_LEGACY	0
+#define NTB_EPF_CTRL_VERSION_V1	1
 #define NTB_EPF_LOWER_ADDR	0x10
 #define NTB_EPF_UPPER_ADDR	0x14
 #define NTB_EPF_LOWER_SIZE	0x18
@@ -39,6 +46,13 @@
 #define NTB_EPF_MW_COUNT	0x20
 #define NTB_EPF_MW1_OFFSET	0x24
 #define NTB_EPF_SPAD_OFFSET	0x28
+#define NTB_EPF_MW_OFFSET(n)	(0x134 + (n) * 4)
+#define NTB_EPF_MW_SIZE(n)	(0x144 + (n) * 4)
+#define NTB_EPF_DMA_ABI		0x154
+#define NTB_EPF_DMA_BAR		0x158
+#define NTB_EPF_DMA_OFFSET	0x15C
+#define NTB_EPF_DMA_SIZE	0x160
+#define NTB_EPF_DMA_NUM_CHANS	0x164
 #define NTB_EPF_SPAD_COUNT	0x2C
 #define NTB_EPF_DB_ENTRY_SIZE	0x30
 #define NTB_EPF_DB_DATA(n)	(0x34 + (n) * 4)
@@ -101,6 +115,15 @@ struct ntb_epf_dev {
 	unsigned int mw_count;
 	unsigned int spad_count;
 	unsigned int db_count;
+	u32 ctrl_version;
+	u32 dma_abi;
+	u32 dma_offset;
+	u32 dma_size;
+	u32 dma_num_chans;
+	u32 dma_irq_base;
+	u32 dma_irq_count;
+	enum pci_barno dma_bar;
+	bool dma_aux_avail;
 
 	void __iomem *ctrl_reg;
 	void __iomem *db_reg;
@@ -375,6 +398,21 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
 		argument &= ~MSIX_ENABLE;
 	}
 
+	if (irq >= msi_min + ndev->dma_irq_count) {
+		ndev->dma_aux_avail = true;
+
+		/*
+		 * Reserve the tail of the vector space for the exported DMA
+		 * child.  ntb_hw_epf only requests the prefix used for link and
+		 * doorbell events.
+		 */
+		ndev->dma_irq_base = irq - ndev->dma_irq_count;
+		irq = ndev->dma_irq_base;
+	} else {
+		ndev->dma_aux_avail = false;
+		irq = min(NTB_EPF_MAX_DB_COUNT + 1, irq);
+	}
+
 	for (i = 0; i < irq; i++) {
 		ret = request_irq(pci_irq_vector(pdev, i), ntb_epf_vec_isr,
 				  0, "ntb_epf", ndev);
@@ -504,21 +542,32 @@ static int ntb_epf_peer_mw_get_addr(struct ntb_dev *ntb, int idx,
 				    phys_addr_t *base, resource_size_t *size)
 {
 	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
-	u32 offset = 0;
+	resource_size_t bar_sz, mw_size;
+	u32 offset;
 	int bar;
 
-	if (idx == 0)
-		offset = readl(ndev->ctrl_reg + NTB_EPF_MW1_OFFSET);
-
 	bar = ntb_epf_mw_to_bar(ndev, idx);
 	if (bar < 0)
 		return bar;
 
+	bar_sz = pci_resource_len(ndev->ntb.pdev, bar);
+
+	if (ndev->ctrl_version >= NTB_EPF_CTRL_VERSION_V1) {
+		offset = readl(ndev->ctrl_reg + NTB_EPF_MW_OFFSET(idx));
+		mw_size = readl(ndev->ctrl_reg + NTB_EPF_MW_SIZE(idx));
+	} else {
+		offset = idx == 0 ? readl(ndev->ctrl_reg + NTB_EPF_MW1_OFFSET) : 0;
+		mw_size = bar_sz - offset;
+	}
+
+	if (!mw_size || offset + mw_size > bar_sz)
+		return -EINVAL;
+
 	if (base)
 		*base = pci_resource_start(ndev->ntb.pdev, bar) + offset;
 
 	if (size)
-		*size = pci_resource_len(ndev->ntb.pdev, bar) - offset;
+		*size = mw_size;
 
 	return 0;
 }
@@ -610,14 +659,61 @@ static inline void ntb_epf_init_struct(struct ntb_epf_dev *ndev,
 	ndev->ntb.ops = &ntb_epf_ops;
 }
 
+static int ntb_epf_parse_ctrl_version(struct ntb_epf_dev *ndev)
+{
+	struct device *dev = ndev->dev;
+	u32 ver;
+
+	ver = readl(ndev->ctrl_reg + NTB_EPF_CTRL_VERSION);
+	switch (ver) {
+	case NTB_EPF_CTRL_VERSION_LEGACY:
+	case NTB_EPF_CTRL_VERSION_V1:
+		ndev->ctrl_version = ver;
+		return 0;
+	default:
+		dev_err(dev, "Unsupported NTB EPF control version %u\n", ver);
+		return -EINVAL;
+	}
+}
+
+static void ntb_epf_parse_dma_locator(struct ntb_epf_dev *ndev)
+{
+	if (ndev->ctrl_version < NTB_EPF_CTRL_VERSION_V1) {
+		ndev->dma_abi = 0;
+		ndev->dma_bar = NO_BAR;
+		ndev->dma_offset = 0;
+		ndev->dma_size = 0;
+		ndev->dma_irq_count = 0;
+		return;
+	}
+
+	ndev->dma_abi = readl(ndev->ctrl_reg + NTB_EPF_DMA_ABI);
+	ndev->dma_bar = readl(ndev->ctrl_reg + NTB_EPF_DMA_BAR);
+	ndev->dma_offset = readl(ndev->ctrl_reg + NTB_EPF_DMA_OFFSET);
+	ndev->dma_size = readl(ndev->ctrl_reg + NTB_EPF_DMA_SIZE);
+	ndev->dma_num_chans = readl(ndev->ctrl_reg + NTB_EPF_DMA_NUM_CHANS);
+	if (ndev->dma_abi && !ndev->dma_num_chans)
+		ndev->dma_num_chans = 1;
+	ndev->dma_irq_count = ndev->dma_num_chans;
+}
+
 static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
 {
 	struct device *dev = ndev->dev;
 	int ret;
 
-	/* One Link interrupt and rest doorbell interrupt */
+	ret = ntb_epf_parse_ctrl_version(ndev);
+	if (ret)
+		return ret;
+
+	ntb_epf_parse_dma_locator(ndev);
+
+	/*
+	 * One Link interrupt and rest doorbell interrupt.
+	 * Remote DMA interrupt is best effort.
+	 */
 	ret = ntb_epf_init_isr(ndev, NTB_EPF_MIN_DB_COUNT + 1,
-			       NTB_EPF_MAX_DB_COUNT + 1);
+			       NTB_EPF_MAX_DB_COUNT + 1 + ndev->dma_irq_count);
 	if (ret) {
 		dev_err(dev, "Failed to init ISR\n");
 		return ret;
-- 
2.51.0


