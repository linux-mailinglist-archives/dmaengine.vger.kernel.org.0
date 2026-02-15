Return-Path: <dmaengine+bounces-8906-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMxIE7/kkWnWngEAu9opvQ
	(envelope-from <dmaengine+bounces-8906-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 15 Feb 2026 16:22:39 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D0D13F099
	for <lists+dmaengine@lfdr.de>; Sun, 15 Feb 2026 16:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EB1473005AA4
	for <lists+dmaengine@lfdr.de>; Sun, 15 Feb 2026 15:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D992DF155;
	Sun, 15 Feb 2026 15:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="hlyEB/jj"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021095.outbound.protection.outlook.com [40.107.74.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D932BCF6C;
	Sun, 15 Feb 2026 15:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771168949; cv=fail; b=kk8uO4mTj1jJzGB4KQtHgXCkPt5U8Shaskroi1Iz+TW61sNMrIenizlWZZKNi1vRFAxtcjWgJwW3kMZ8UuruNUGbLrOjWRU4LyKbJErfcRf37npA+Qh9rBsTWDqMYcxoAvIDarE1vGS8U9JFgYE3DPnxs7vVeNcaDM8R9AJevoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771168949; c=relaxed/simple;
	bh=i5MkyCimB2biEvsxTVlKp9CNF4LGxO6YdddzZ9y8Io8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MlwcJ7DCxQFbVpJHpmHY+O+MMeVNSK//KEHn6fnJBiiiNZBE+ff+TICrp7zIX/e6vVvJtx9pC9wTcL+oPaQ4cpxqIp8qgU9LXW2xSq+9bF2ENBdSB0uc83G0d7l150NkBhbov/tTNfsr1xTvTNR8kbkE9fN5u3fUK9a8w5n/oI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=hlyEB/jj; arc=fail smtp.client-ip=40.107.74.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HHZIAf0zfEdi4F/qowSgm5510taIznWBJyKkKkPypL0OtuIN6ANSxg8Mcp9dUoPHA1XPDpvNe3cHnz3NdxUJifgospVOQAzeI9zNR8wLXpdLVyTGUReEBKSdwiRnXbTRKQ7RrbIAPCxUz4jcsUpXP2U65XnpC+68FkcANwbnznMwQ9vulwaNLl1mwix3GZhg9CUGukLpMs3kAHwCI9YWDPCeWY8c5RkKziOnoGNLFhSxeEEs+96La1zoa0VdTv/SyQA2BaLVrD08mMpoYWNWnqZS22pYdU/BSo8n59kTZy60P/zvV2A66mA7nlHKuV4eU7rik4lkD/KzvR4XM8/rqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NY4ATHeEnjcUQbuv8dK2bcyHQtnXei/xhcfYi67dfLs=;
 b=THEdQia7xrW1Umrogpg1voLKJRVXjJj4xZ6L8bcz+JtC+YYZ0uoNyQ1E/yxRMFbbI3W7R/DIFPrZLgs2IoHsTn8RovhXnjK5cjzMVjfDFJcBVTkDCH4e9M8tBDziAsfELB+qdiDTLYjb1hGfsO1G1ZVAV4cb44oVfOCNzPaXwBGjejK+Oz8zsDkuINafFTXeBPMJrfRsL6Pb7ISoN4B0vv08OSKAbK96MA9UqxqtSw3jAjPyNe7hoInNi2OMF9uZb8wA2JjXbhpKKJM+LwPakRc9ORE2drgJeM4LZbm36yljdpV+eeecVbbjJJxSKPlcsjkEGic7h1I3k1TpoIqSJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NY4ATHeEnjcUQbuv8dK2bcyHQtnXei/xhcfYi67dfLs=;
 b=hlyEB/jjrQ/bYWokHZy1Va9FiPzIVCJBOmHacXdIpKHfEQR122RrPHJMWsnzJ9rbYwRVQ0y1KhKeZATWYltBJCV0OXGZNtDp5rFQFJi7hYfP5qDSwccprdK7hS7SgsFUiSreEOIYP/VfxBLNa+dY/n92WnhBwiqHt/8Vo1TPUfg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYWP286MB2340.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:169::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Sun, 15 Feb
 2026 15:22:23 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9611.013; Sun, 15 Feb 2026
 15:22:23 +0000
From: Koichiro Den <den@valinux.co.jp>
To: mani@kernel.org,
	vkoul@kernel.org,
	Frank.Li@kernel.org
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dmaengine: dw-edma: Add virtual IRQ for interrupt-emulation doorbells
Date: Mon, 16 Feb 2026 00:22:16 +0900
Message-ID: <20260215152216.3393561-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260215152216.3393561-1-den@valinux.co.jp>
References: <20260215152216.3393561-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0016.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::14) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYWP286MB2340:EE_
X-MS-Office365-Filtering-Correlation-Id: 74251e68-7b0f-4318-ba0b-08de6ca6048d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ExLYm66TPb4EJSbgsXF/9YCoFHMC2dneka0LuroI8+zTsTdygn+17XYhAQoB?=
 =?us-ascii?Q?kkg1TZb4kn2HnGWn6EOOlKuluFEf00Tv+Tw/6I6mKIJb8kQ4ynB4UJVhLRwi?=
 =?us-ascii?Q?iPOrqZjcLu41WQS05gRNNpjQUgGsjgliAiVdqX4Oj9i/iCzyDYf7l28iRaIm?=
 =?us-ascii?Q?H6tJxDqMrKaie+inH1CRplxs0FQVly5oLQuectbAPj37ZWhynZt0nIwR4F+t?=
 =?us-ascii?Q?3kYkl+KmL1bjfHUqpVme5Ubiryyu7dyE6fnpuaUdW4muBZ3jAPF0J2zqIAeu?=
 =?us-ascii?Q?YQpS3m1oxOHN7sqyCCFAdtkCd04vJrBbsTYCNo7BKTgPPSpux5wk0UMesMOQ?=
 =?us-ascii?Q?JL5CFfeFh8hiOyD0FYiCYP1zAKwNmok6TApskSSlZ12mO99cNh99OkvJm5L1?=
 =?us-ascii?Q?CsQdtfC0Pgora5WcMATlbq4Cu5tFqETbTczp0llM5c2xY91ebEXpaQuyGCkD?=
 =?us-ascii?Q?doyb7eaMLJL4MIxMqgUuDdinPx75YcHOz+bX35DCJrVXQ/oxQoxJwYFS8fS/?=
 =?us-ascii?Q?pCnaxyQDfOsdTiqqeUmXC+Lmsky/fF5rpZF+qk0lquy5MnREGG2Y2+srbUFx?=
 =?us-ascii?Q?OOStpZKluaNC6fiSq6PErMXB3Ez0zNPp8KQrGuXFPQ+BNyCtpI/fEw2EiHYG?=
 =?us-ascii?Q?UkRMlykRyfa/4OEYtjqxgFou4so86to8SCZxFx9to7vTTnzIVw8ttSrx3bs+?=
 =?us-ascii?Q?jYvnrKEacxvCKFM70adVf3sEj02qV3hzA10YOL/fE/uDH9drYGvdKzCLD6gx?=
 =?us-ascii?Q?QjSLCozXu1Vploy/Mwuwf7juSnMqPjoOwPbqdlrQAUaMc1uyVBWA8SQHM3cw?=
 =?us-ascii?Q?gn/L5XJAfLbrcO44XulioOJcia+iuhEhJnzERwwO1yyhgM5H3Sd0T8qAFzEF?=
 =?us-ascii?Q?Ky46UcxtC3vCx+2UexB/NeaeNhK6+0X6apJQzx0Cm8EtDE/+JXYSA8q+vg+V?=
 =?us-ascii?Q?VJXtYYe9nTCEec+IfJkF0eylaHCYYURz2YrVYay0zQfVjUkV4fdhNVfICcvX?=
 =?us-ascii?Q?sssuSWWRLboUsPQZfvasJKECKVVoo4IJLPL6BXbzwnWkq8PGXcOS1Z0+K3Fc?=
 =?us-ascii?Q?d4HGBJ7X0OA7qp/uXOIyK+N4+LvcgtuvjzO+GgApftMkItZd6KpPvtRhzKxh?=
 =?us-ascii?Q?vsDoa35uFC7MHOq+wAQFW6gcd9ZZ3Ilm1pPHK5JEHnphbHdo/mAQ832ZkuG6?=
 =?us-ascii?Q?ns2DF0CqFJRp/OekgqIwMJuaiZnnV3azZlkeEeyOM4oKacH5MOSbLNaUOUqJ?=
 =?us-ascii?Q?SRIOjQGhADqhU/0s0k3AzaijiSmAWCQseuqHoXnfOrFQ8/M5v5SyxvnGGbcV?=
 =?us-ascii?Q?NBnCTfB2BTmc/x4Fo0rl4tvCn7pKZzxIAFHZa/yLl2EOhbRlFUlaWD4Y2fOH?=
 =?us-ascii?Q?boAmH3/hdX+jNGMB+uzdTJjn7WoN0koASMW9LnNRymcOXOPnFJKMxtlNbZvk?=
 =?us-ascii?Q?aZ4eaFM7pMpwDdjpi2CHRNP/znFHW1c1L7Fpid1uddeVeUaHmcpLblmCcmMq?=
 =?us-ascii?Q?/Cc4MtWQ9Zx4yi7By5dnM7TwaS8C+X+eZG27LDwMriO/jbh6zketGNO7obNR?=
 =?us-ascii?Q?eXPjY78l400Q/awD6iM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xGSETjqf0t/Kj45hFa8lTaf1crZ+/2BqO5pkpjqEJdjfNoUYZjKNrDc1aHNT?=
 =?us-ascii?Q?uddThzIljqjDzQkg/wP0kwXJXuv58M0asbluldriVh3j/hm1vk4jbXgiJtUj?=
 =?us-ascii?Q?kIhrQDgJEmcA7mdgM8XU/MxNS6yTFmaFPg5vv0zlosb504KiLa5F1/DxiT3N?=
 =?us-ascii?Q?Jp2gru8Xlc6rYNBXJqYMnxwK8PxjxL7MnuHUhh4rIe7ONQN92e4EO0jRsnF4?=
 =?us-ascii?Q?0QnE6sVySLaHQyJhW9cpYR/AMFs+hWFYj/SodBhZrb+7crgIOvoIxd3+EBv/?=
 =?us-ascii?Q?Qt8rnUFsB+tmG7Y6tuwAtXglUws0z1efQbdghdcjUe0CWDOOnm3PrABCU370?=
 =?us-ascii?Q?+pra+SnAlhTNow4Cf4g/UalbcTNA3vI8Mz4RUhWNeG1yeMx8ts+Ixp71WlDV?=
 =?us-ascii?Q?JbkUt2Yj+Pf+xKAEak12+tSe2K5XSa6ii2IsZVUEhj0D9LJ0bZr7dMCp+8gF?=
 =?us-ascii?Q?z3CBSCja9IzB586xbvfPmTFrvP64wLwD0ydiIn+6vWqfbMYlfEk27Y3LECqX?=
 =?us-ascii?Q?VeBXcbS8mXrja2mJYP2Xc7BE6edKLnlCWaFyld9XvVJvYYYG/hInHVVWuLX2?=
 =?us-ascii?Q?ezHULl+cFcOguy+TKucqffFOfgo3vml8PAu9TkpkgRoe0ymDf7NViilK5pbj?=
 =?us-ascii?Q?pAPAT6vc8DO3E/NUKazE9xkyursQr2ZLOWMVYJ+ZOuScLJofXwrJSz6YfyEk?=
 =?us-ascii?Q?DawbJ40tAdlLls3ZWXZ/bRtNF4WpMF3mDQcxMMc8fuCDqhrGlumDv1xaI/gT?=
 =?us-ascii?Q?LImdpO/8B/9s6Uhk27YwUkM1wYmbSYtQJZP9CFfjyf01/484fsWDCrbQblmy?=
 =?us-ascii?Q?dO6k5TDX/rQS4PvL2GKc7v7/JcxQu8yXe2CThFA78zGLedHMPhJULSa7dFDn?=
 =?us-ascii?Q?30eYJaqmK2oLcrd3FwjEFegpwGoTRusvcRUXRYmmQFI7M/acvJ1IBfFcqBXy?=
 =?us-ascii?Q?JtOkdwMEHojMgNP0za8P5oyZuH4hn57aD4J1npEeVt3KgcbSsLWOrIcRvu3x?=
 =?us-ascii?Q?MolqFlFEvcp5cnXl9JdQoAcSTsdbJwXKjA2Ure/WdABRItHdUmNpem++/YzF?=
 =?us-ascii?Q?Vun/Zd9w87tIjoc1p4m89pHKsJmX4DtUkePDEce5Bw9CgAVtL7e3xWmaIQ7g?=
 =?us-ascii?Q?+ShFY0DvJycGPJSxKHaMzGXfVyd914maIni0ATtMhK01U1AHkWKktBq728oF?=
 =?us-ascii?Q?qAYkbqWXCPI490z7Z/AxcI13gU0KEtCobuX4EGyHH1BYe4mEpUPwZ7Kg8OpB?=
 =?us-ascii?Q?4A/Yrf2BKoAXV+lguH4FCj+NIB8Bc1mgs6s4377bJA/rgcQneg3SIPbax7JI?=
 =?us-ascii?Q?VKd1MGDf7c6uOdDkC44rNpzmlANQOzBrZQdqliElar17FxSM6Ct0wVvBu5Mo?=
 =?us-ascii?Q?5VCXF8cSG85R8T5SY1I+8V4Zm59rblaZlXvnLGblsXZhC3Ea6WebCqGUBrYK?=
 =?us-ascii?Q?gjTrnK8SbkAlaBpW6L7/uRJpKEMKbPFDM8RxqF5fcpJWTZQXloh8mS210TOA?=
 =?us-ascii?Q?I441PpB9En5yhzsv3yVEbEj5yiJ4PSTGUV/o/OA0OVqBqozcvDu4kPP16+jM?=
 =?us-ascii?Q?5SgMYoXMkdjJf6Vkd4sTUA6zSlhF9ycNlN7134RoNAzy/Py8gtMsDJzlzDf6?=
 =?us-ascii?Q?+PvZd37BMBcq9+RMBmCx9+5ynr5K3Hhtl3cb4p//pKG+gohr5Oa0GvfKPWfv?=
 =?us-ascii?Q?hW/mOdU90OKzJsHJFfrj6sVwg/1dLKn26CW17kbqpVH7JYMmPDmV49s+DN7N?=
 =?us-ascii?Q?AXLgP1twkIUP6ORiHQ+ZXGgaaIzYJoijyZwqdBQ/zfwXvPd6rskO?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 74251e68-7b0f-4318-ba0b-08de6ca6048d
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2026 15:22:23.0433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MMCj1tFvW5DdKwb7vKVtM4CYjvzvpG+QoZrmeOpEXDKaCJSO1Kqa0PxKplKIpnG2UbyCuaZSjU46qiuQNXGyAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2340
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-8906-lists,dmaengine=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[valinux.co.jp:+]
X-Rspamd-Queue-Id: E0D0D13F099
X-Rspamd-Action: no action

Interrupt emulation can assert the dw-edma IRQ line without updating the
DONE/ABORT bits. With the shared read/write/common IRQ handlers, the
driver cannot reliably distinguish such an emulated interrupt from a
real one and leaving a level IRQ asserted may wedge the line.

Allocate a dedicated, requestable Linux virtual IRQ (db_irq) for
interrupt emulation and attach an irq_chip whose .irq_ack runs the
core-specific deassert sequence (.ack_emulated_irq()). The physical
dw-edma interrupt handlers raise this virtual IRQ via
generic_handle_irq(), ensuring emulated IRQs are always deasserted.

Export the virtual IRQ number (db_irq) and the doorbell register offset
(db_offset) via struct dw_edma_chip so platform users can expose
interrupt emulation as a doorbell.

Without this, a single interrupt-emulation write can leave the level IRQ
line asserted and cause the generic IRQ layer to disable it.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/dw-edma/dw-edma-core.c | 127 +++++++++++++++++++++++++++--
 include/linux/dma/edma.h           |   6 ++
 2 files changed, 128 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 8e5f7defa6b6..51c1ea99c584 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -663,7 +663,96 @@ static void dw_edma_abort_interrupt(struct dw_edma_chan *chan)
 	chan->status = EDMA_ST_IDLE;
 }
 
-static inline irqreturn_t dw_edma_interrupt_write(int irq, void *data)
+static void dw_edma_emul_irq_ack(struct irq_data *d)
+{
+	struct dw_edma *dw = irq_data_get_irq_chip_data(d);
+
+	dw_edma_core_ack_emulated_irq(dw);
+}
+
+/*
+ * irq_chip implementation for interrupt-emulation doorbells.
+ *
+ * The emulated source has no mask/unmask mechanism. With handle_level_irq(),
+ * the flow is therefore:
+ *   1) .irq_ack() deasserts the source
+ *   2) registered handlers (if any) are dispatched
+ * Since deassertion is already done in .irq_ack(), handlers do not need to take
+ * care of it, hence IRQCHIP_ONESHOT_SAFE.
+ */
+static struct irq_chip dw_edma_emul_irqchip = {
+	.name		= "dw-edma-emul",
+	.irq_ack	= dw_edma_emul_irq_ack,
+	.flags		= IRQCHIP_ONESHOT_SAFE | IRQCHIP_SKIP_SET_WAKE,
+};
+
+static int dw_edma_emul_irq_alloc(struct dw_edma *dw)
+{
+	struct dw_edma_chip *chip = dw->chip;
+	int virq;
+
+	chip->db_irq = 0;
+	chip->db_offset = ~0;
+
+	/*
+	 * Only meaningful when the core provides the deassert sequence
+	 * for interrupt emulation.
+	 */
+	if (!dw->core->ack_emulated_irq)
+		return 0;
+
+	/*
+	 * Allocate a single, requestable Linux virtual IRQ number.
+	 * Use >= 1 so that 0 can remain a "not available" sentinel.
+	 */
+	virq = irq_alloc_desc(NUMA_NO_NODE);
+	if (virq < 0)
+		return virq;
+
+	irq_set_chip_and_handler(virq, &dw_edma_emul_irqchip, handle_level_irq);
+	irq_set_chip_data(virq, dw);
+	irq_set_noprobe(virq);
+
+	chip->db_irq = virq;
+	chip->db_offset = dw_edma_core_db_offset(dw);
+
+	return 0;
+}
+
+static void dw_edma_emul_irq_free(struct dw_edma *dw)
+{
+	struct dw_edma_chip *chip = dw->chip;
+
+	if (!chip)
+		return;
+	if (chip->db_irq <= 0)
+		return;
+
+	irq_free_descs(chip->db_irq, 1);
+	chip->db_irq = 0;
+	chip->db_offset = ~0;
+}
+
+static inline irqreturn_t dw_edma_interrupt_emulated(void *data)
+{
+	struct dw_edma_irq *dw_irq = data;
+	struct dw_edma *dw = dw_irq->dw;
+	int db_irq = dw->chip->db_irq;
+
+	if (db_irq > 0) {
+		/*
+		 * Interrupt emulation may assert the IRQ line without updating the
+		 * normal DONE/ABORT status bits. With a shared IRQ handler we
+		 * cannot reliably detect such events by status registers alone, so
+		 * always perform the core-specific deassert sequence.
+		 */
+		generic_handle_irq(db_irq);
+		return IRQ_HANDLED;
+	}
+	return IRQ_NONE;
+}
+
+static inline irqreturn_t dw_edma_interrupt_write_inner(int irq, void *data)
 {
 	struct dw_edma_irq *dw_irq = data;
 
@@ -672,7 +761,7 @@ static inline irqreturn_t dw_edma_interrupt_write(int irq, void *data)
 				       dw_edma_abort_interrupt);
 }
 
-static inline irqreturn_t dw_edma_interrupt_read(int irq, void *data)
+static inline irqreturn_t dw_edma_interrupt_read_inner(int irq, void *data)
 {
 	struct dw_edma_irq *dw_irq = data;
 
@@ -681,12 +770,33 @@ static inline irqreturn_t dw_edma_interrupt_read(int irq, void *data)
 				       dw_edma_abort_interrupt);
 }
 
-static irqreturn_t dw_edma_interrupt_common(int irq, void *data)
+static inline irqreturn_t dw_edma_interrupt_write(int irq, void *data)
+{
+	irqreturn_t ret = IRQ_NONE;
+
+	ret |= dw_edma_interrupt_write_inner(irq, data);
+	ret |= dw_edma_interrupt_emulated(data);
+
+	return ret;
+}
+
+static inline irqreturn_t dw_edma_interrupt_read(int irq, void *data)
 {
 	irqreturn_t ret = IRQ_NONE;
 
-	ret |= dw_edma_interrupt_write(irq, data);
-	ret |= dw_edma_interrupt_read(irq, data);
+	ret |= dw_edma_interrupt_read_inner(irq, data);
+	ret |= dw_edma_interrupt_emulated(data);
+
+	return ret;
+}
+
+static inline irqreturn_t dw_edma_interrupt_common(int irq, void *data)
+{
+	irqreturn_t ret = IRQ_NONE;
+
+	ret |= dw_edma_interrupt_write_inner(irq, data);
+	ret |= dw_edma_interrupt_read_inner(irq, data);
+	ret |= dw_edma_interrupt_emulated(data);
 
 	return ret;
 }
@@ -973,6 +1083,11 @@ int dw_edma_probe(struct dw_edma_chip *chip)
 	if (err)
 		return err;
 
+	/* Allocate a dedicated virtual IRQ for interrupt-emulation doorbells */
+	err = dw_edma_emul_irq_alloc(dw);
+	if (err)
+		dev_warn(dev, "Failed to allocate emulation IRQ: %d\n", err);
+
 	/* Setup write/read channels */
 	err = dw_edma_channel_setup(dw, wr_alloc, rd_alloc);
 	if (err)
@@ -988,6 +1103,7 @@ int dw_edma_probe(struct dw_edma_chip *chip)
 err_irq_free:
 	for (i = (dw->nr_irqs - 1); i >= 0; i--)
 		free_irq(chip->ops->irq_vector(dev, i), &dw->irq[i]);
+	dw_edma_emul_irq_free(dw);
 
 	return err;
 }
@@ -1010,6 +1126,7 @@ int dw_edma_remove(struct dw_edma_chip *chip)
 	/* Free irqs */
 	for (i = (dw->nr_irqs - 1); i >= 0; i--)
 		free_irq(chip->ops->irq_vector(dev, i), &dw->irq[i]);
+	dw_edma_emul_irq_free(dw);
 
 	/* Deregister eDMA device */
 	dma_async_device_unregister(&dw->dma);
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index 270b5458aecf..9da53c75e49b 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -73,6 +73,8 @@ enum dw_edma_chip_flags {
  * @ll_region_rd:	 DMA descriptor link list memory for read channel
  * @dt_region_wr:	 DMA data memory for write channel
  * @dt_region_rd:	 DMA data memory for read channel
+ * @db_irq:		 Virtual IRQ dedicated to interrupt emulation
+ * @db_offset:		 Offset from DMA register base
  * @mf:			 DMA register map format
  * @dw:			 struct dw_edma that is filled by dw_edma_probe()
  */
@@ -94,6 +96,10 @@ struct dw_edma_chip {
 	struct dw_edma_region	dt_region_wr[EDMA_MAX_WR_CH];
 	struct dw_edma_region	dt_region_rd[EDMA_MAX_RD_CH];
 
+	/* interrupt emulation */
+	int			db_irq;
+	resource_size_t		db_offset;
+
 	enum dw_edma_map_format	mf;
 
 	struct dw_edma		*dw;
-- 
2.51.0


