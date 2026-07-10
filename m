Return-Path: <dmaengine+bounces-12298-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9rauMwOsUGrR3AIAu9opvQ
	(envelope-from <dmaengine+bounces-12298-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:23:31 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F15A73865F
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:23:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=mKkWMR7X;
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12298-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12298-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 214B83019CAF
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 08:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6088E3EFD15;
	Fri, 10 Jul 2026 08:22:12 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021110.outbound.protection.outlook.com [52.101.125.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA013EF0C2;
	Fri, 10 Jul 2026 08:22:10 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783671732; cv=fail; b=oHrIhwRTYeT7gbUeL0o9+B/kYZ3e0l1MKkv0InX7amnRu9qkLwWEWlBVpQmC/TC76uAbbihYkm0msyPGPIZNmvTnragTIZa0N7DwA167ErQ0w2K1T3sKJUEkJxTS4rnnHhjHrJnhvkMmdiFxG8mwyDoUz+DR2Mq3eUgdaw2HQ6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783671732; c=relaxed/simple;
	bh=nLIgmKi3pFRmMfvsOLhIPAXfQTlSc3TLo0fj9/k0TwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EOwlb/wMbT0+txLeZduqE6IsKAKt0WhN2rpdsSfhDJME1UdWLqhdhLjzW5yBfK78hYr7hZyS2rlW6ftkvYmFAPo+h9cKXz3uWmo5b6BJ0QdYanC87eIa+FEvnLeUCrVE6NBQr4zo7i2W2CB+I1PBxCXt+mNq86dPfc33VFK3I6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=mKkWMR7X; arc=fail smtp.client-ip=52.101.125.110
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T914EJkDYpb3V6lQ4gzsp3COkmuvoXYYihP7Sxg+cq79xbi0IbnCoXyFSENvDCruzXUm//HkO9jg4ToU9ZWYycCBi0PcFVAoHxmY/DbORhPxkYHJU2t88QCaDkLdQkF+JjBHWKYvftd60C6i8zToJ+7xpwwmG5qnJXC5kF1ZTglMFSMJXliHIjibILG0smNsO2HOlrZK7Pqjusex3BhD8gpPh4LEQuMngN/vkhjqrpoujiCgFBlkGRzcuXIAzeUeqR841N0MC09yK/mTLX7cOneGeS44v9ec9KOJnRpdXPCubOGsmqTSc6p7ak/Jw4UkvW6YvGGkLNtV3tmQ2JlC2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rdo49IMHSkkQEB56Ww3LbJWT+juM6C234qisNFIyB8s=;
 b=mbmXdhZbNDTXvl/Zsu4J8FVLZqcY24DO/ig+BITakVGssRcK3SM6kHU3k+E5920jX+bvzeRl7favkhKq0fIcF1JNci/nHCuvfhg1t2DLjDL8BjK+KMzNbPutgz2+FmMWHEnEUtnbdgrMy3NzKKsWqKk49ehT1lDjAgffBcPWTAL1/pJXA429Y55CThMGfMXRBSU9u0bI3XksQlo7/8BM0luZ/Dcc84dPFnEr+0sccI6vVu92/RTCz3k3ZvpKUdygTA1h6C5WoVNe3w5S4U7FkUJvzcQ0BTK7HS+83RgofDeU04zy5WfldvJxp/DMbNbfPpHEJ/vE7kAgswphoeygPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rdo49IMHSkkQEB56Ww3LbJWT+juM6C234qisNFIyB8s=;
 b=mKkWMR7XqYq/mt+ii9eRuJU+jed9kn5GjW6SESEuE23cRsuiUaTPCO9T3tU9OUfBOq0L75/x/cgWuc03DWX/9TcDyBAphYs2LvybBqXKJmURE9ozR/lkFU8mtBSVEyarz0EBexFSYtz+aYe5WJ5jFve692BlTJZ1g0LyJ63d0Xo=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB6531.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:323::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 08:22:06 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0181.009; Fri, 10 Jul 2026
 08:22:06 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v4 6/6] PCI: dwc: Implement endpoint DMA channel delegation
Date: Fri, 10 Jul 2026 17:21:56 +0900
Message-ID: <20260710082156.2395844-7-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260710082156.2395844-1-den@valinux.co.jp>
References: <20260710082156.2395844-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0176.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::18) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB6531:EE_
X-MS-Office365-Filtering-Correlation-Id: 15ab068f-5817-4090-8222-08dede5c53ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|10070799003|1800799024|366016|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	4E8Pq5ibNcl50v8aPTQiPjzWg9hRLxTfwono8tO01sjpPspkheUVa33dPUc4Pp6aUcfIULKIpRqHtF6zqHfR3FqjB4cz4cz/vBb3cPCxD7jBBExEHfl0mmUR93GCUnpZ2a6LH8/HvwiOMnYHYp9MJ2eYAXUONnOhyMChSUKmY6B1Lqrcqnrhk2YPbSdg4AQEy4XRHyjLACUqLGt+4gTapIE+kj1Xj5uEpWvd1jAn8T3CAbAFJdqw0XhLJm4LSwMPWi81H9xFoUodxDgspvO3CCch5XhBkWUtZY1O9vCBQxzu9fO1f6uIN9Gx34Qb0WQ7gRwTLhzD/qxVyNu+OZzzn0lbtROQCFlD25QnsoLXkPRazoPhsc53sxsF2LJqFiQ2OIxeNP74IYlCv84HGbI9aPe/fDuCLgtMlUj4QtufnrGqtTE3ubWjK28BrDH1l7+ABCmHAry61BQwBNZVYXIB/pCs25sYtxb8/LBpfRvZwRUfh2mf93pVyzWxTfHqNNm47ArrL9eHUhIvyYQoDZulAh4GCT+67FURGfYFvYg/gxThV6hoTSFJj3IMlnfY3gmb1yeO1XMqqrXzhNmjtVZuFM9V6qnjrm612pwqJRM9FhbXrxXBbimqx0ZZtwigxCjBjKx4x9j1+R50agvCasugDFtlq1Bn6THmF1IJPEyL5PU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(10070799003)(1800799024)(366016)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J1gNxp0tBAENpsD4qSUXW/TIt1jyWm4IS+WDDqHM7UJZsY6rLyowM+wTQWY7?=
 =?us-ascii?Q?l3dJjK0NWFE97NO8vnUftexjbL4+28Uh6Wl53uLoyWJIOBzY7wQAGq9M6npc?=
 =?us-ascii?Q?MpkAaJ/TUHrO3/4TpPFZpbdBc4sN1cMwjKup9hehMQvoBTsF9mej6GIvSZ3d?=
 =?us-ascii?Q?4L6YcWZ9Bm+3SR7qNZt6qoUkYyf/rITq+BHqNW+8Gvaj2mcZOCAhAmYkPZxa?=
 =?us-ascii?Q?apSEtYZlDMRdF3IlGdQHhMUnvidTaW2ZMkJpZSjaY/CRhjFcyUn6kLks1Q3B?=
 =?us-ascii?Q?nbfR25ic+tSbUMhuOXBRBUbtwv4dzBYjsZ/6/QgcvTJlKEinqlAZMKiuW8MV?=
 =?us-ascii?Q?FA1+m4KVVzI1JqpztunvYDgA4hFPpG1CBwHf+Q29PV3VTmMM3Nt+EdqOIGr1?=
 =?us-ascii?Q?Tz2xMXcIKf8vuD9Gv0uRSiQWJ0mfRPXBuEslDxEw+NofCF/ZYMvKmXzutK5U?=
 =?us-ascii?Q?/h+fDzSl6VWSb9HpcUFVoo4elIKM9B/cQE8ZVLjOl7rqTlNgqyITafJgSntz?=
 =?us-ascii?Q?9GeJV0QvBBn5hmyxOX+FIekQ9mzq7JVU4y0lkoGQVLsqVP8rciP6jbSWZRMV?=
 =?us-ascii?Q?MInDxnNZSDBIiwD2ZcXTGFE8Rb58+Ckuz+0Vd9WM9Ft4dT9XTg0qY8+ofjRU?=
 =?us-ascii?Q?Vj4g4U3RYZCBWBvtCpEobIVDA8mjzObeLFMNAKDItO25Tj0Dj2AFiv360ARQ?=
 =?us-ascii?Q?Shc1wUZiG8s+Lzy3Zgb2X0LcrgG0Fts1BeC9PnUAPRflgisy/uJ5Pf0uwgtI?=
 =?us-ascii?Q?shG8hD64AtFDeJQzxGR/jkMC+95XK0+K0ABFOxXUoqqsnUJauw7X/hzTmV97?=
 =?us-ascii?Q?pkIjPMeNW6hNiyQiRweQgnVnu1+E1s5P2r0iia504+DebT44Az+1XryxYsx3?=
 =?us-ascii?Q?r5EF1Oz2zo8kXqMA+tshLCgCYLmK916zsRMVx0zvdLZ4aAIq1XYjIFGp4sIV?=
 =?us-ascii?Q?JDrWn9qWVvCaoISWQveIGc2+ugmoPBVudNgksdlr24kpMsk9BwY6qAGqIySq?=
 =?us-ascii?Q?bZp1XrXik1OgRskJ4qEPPwQpBah7cx3dcsztSRGdvodvEjF0oTcHU5HKPccz?=
 =?us-ascii?Q?u1qW2ioQyhqH8Gevq/a0AzANTWTUD7M6R4nDKeKZyNf1lpT62+fz2selgJqV?=
 =?us-ascii?Q?JYQDNuXm2vvoP5lcwfxizZ8q10BJBGqYb3/5kysh/8OgWAK795b14QG+1q/n?=
 =?us-ascii?Q?mZD6mreSIxe7zfNzhZ1JxTsvdXCjTcw4i27Q8nELmCIuREXLOrLA2xrultn9?=
 =?us-ascii?Q?sqviAqATKwX2gL7YNgEqq+GPxMGpDwG2qi9O8jSZh31QtVjQP9lJW3CJi12E?=
 =?us-ascii?Q?bvX5i+b/hOaze7P0ZRgHw+0ltCaTYY6ObqTqeAHNuVcupkXf6R8Uh8JVdycJ?=
 =?us-ascii?Q?oROZqbxASoa+i2y5bRUx4wFygpw3NLsKVT8fX5mDGgSP2UDQKQk7yeWJqHPh?=
 =?us-ascii?Q?uAyyY0MposeR7ZECtQZiaavncspdWEmROsK+9tMRvkspTdcenQ+NNIGFY/GE?=
 =?us-ascii?Q?HVDYx3HvI5ox9Q580LzL1xOkMoZkTSe2Gh9pBQ23cG9zZkKdn8mMypBgjWQt?=
 =?us-ascii?Q?NscMU9wrDX2h2GomJNszz8pz6MMun45Dn9rXsMbPc6BVI/rYrRPgBi+WprRY?=
 =?us-ascii?Q?Kb1BG6j/Lr08CIkrwH75q5HiS6EtoeL8cPZbFbIXZYRLE5M+gtKBn6+T7Nm7?=
 =?us-ascii?Q?hkQ7QzDlU43sE1Wbkn6L8Gxq5uJ0jjfAClfqoBGJHOTIXueM47UfQm5iwSkI?=
 =?us-ascii?Q?Vh3ReluJPIgFxDo7Iqx5UqTvhVl4MumX/2Po5ktsneCJ/ScQw370?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 15ab068f-5817-4090-8222-08dede5c53ec
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 08:22:06.0092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CM89xTAIEC1HJLDr0TExsG5oXjAVoWkAt+T1DIBkHi+H7W86mxaskwf+TjagRqRRMQ5s4Hl9w4kyiuyykDqsaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB6531
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12298-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,google.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:jingoohan1@gmail.com,m:lpieralisi@kernel.org,m:kwilczynski@kernel.org,m:robh@kernel.org,m:bhelgaas@google.com,m:kishon@kernel.org,m:marek.vasut+renesas@mailbox.org,m:yoshihiro.shimoda.uh@renesas.com,m:linux-kernel@vger.kernel.org,m:dmaengine@vger.kernel.org,m:linux-pci@vger.kernel.org,m:marek.vasut@mailbox.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,valinux.co.jp:from_mime,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3F15A73865F

Implement the EPC DMA channel delegation operations for DesignWare
endpoint controllers. The DWC backend uses the local DesignWare eDMA
provider to reserve the requested hardware channel and returns it as an
opaque EPC DMA channel handle to generic endpoint functions.

Validate the requested direction and hardware channel against the
linked-list channel counts before delegation.

DWC eDMA/HDMA generates DMA requests with a programmable requester
function number. For delegated channels, the host-side dw-edma-pcie
instance bound to the exposed DMA function reserves the channel and
programs its own PCI_FUNC() into the per-channel requester field; the
endpoint-side chip func_no does not participate in that handoff.

Reject VF requests because the RC-programmable DWC eDMA/HDMA register
window is assigned to a PF BAR only.

Reclaim releases the delegated local channel through the DesignWare eDMA
provider, which returns it to endpoint ownership. Propagate the EPC
quiesce request so bind failure paths can release unexposed reservations
without touching DMA engine state.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v4:
  - Lift the v3 PF0-only restriction on DMA resource exposure and
    channel delegation: dw-edma now programs the per-channel requester
    function number.

 .../pci/controller/dwc/pcie-designware-ep.c   | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index dd47537f390e..fa0513585f6a 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -1056,6 +1056,59 @@ dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	return 0;
 }
 
+static int dw_pcie_ep_delegate_dma_chan(struct pci_epc *epc, u8 func_no,
+					u8 vfunc_no,
+					enum pci_epc_aux_dma_dir dir, u16 hw_ch,
+					void **data)
+{
+	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	struct dw_edma_chip *edma = &pci->edma;
+	struct dma_chan *chan;
+	int ret;
+	bool write;
+
+	if (!data)
+		return -EINVAL;
+	*data = NULL;
+
+	ret = dw_pcie_ep_check_edma_vfunc(vfunc_no);
+	if (ret)
+		return ret;
+
+	if (!edma->dw)
+		return -ENODEV;
+
+	switch (dir) {
+	case PCI_EPC_AUX_DMA_EP_TO_RC:
+		if (hw_ch >= edma->ll_wr_cnt)
+			return -EINVAL;
+		write = true;
+		break;
+	case PCI_EPC_AUX_DMA_RC_TO_EP:
+		if (hw_ch >= edma->ll_rd_cnt)
+			return -EINVAL;
+		write = false;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	chan = dw_edma_request_delegated_chan(edma->dev, write, hw_ch);
+	if (!chan)
+		return -EBUSY;
+
+	*data = chan;
+
+	return 0;
+}
+
+static void dw_pcie_ep_reclaim_dma_chan(struct pci_epc *epc, u8 func_no,
+					u8 vfunc_no, void *data, bool quiesce)
+{
+	dw_edma_release_delegated_chan(data, quiesce);
+}
+
 static const struct pci_epc_ops epc_ops = {
 	.write_header		= dw_pcie_ep_write_header,
 	.set_bar		= dw_pcie_ep_set_bar,
@@ -1073,6 +1126,8 @@ static const struct pci_epc_ops epc_ops = {
 	.get_features		= dw_pcie_ep_get_features,
 	.get_aux_resources_count	= dw_pcie_ep_get_aux_resources_count,
 	.get_aux_resources	= dw_pcie_ep_get_aux_resources,
+	.delegate_dma_chan	= dw_pcie_ep_delegate_dma_chan,
+	.reclaim_dma_chan	= dw_pcie_ep_reclaim_dma_chan,
 };
 
 /**
-- 
2.51.0


