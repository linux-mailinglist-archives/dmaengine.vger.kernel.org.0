Return-Path: <dmaengine+bounces-11905-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9+yJNjV+RGonvwoAu9opvQ
	(envelope-from <dmaengine+bounces-11905-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 01 Jul 2026 04:40:53 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9CD6E947B
	for <lists+dmaengine@lfdr.de>; Wed, 01 Jul 2026 04:40:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b=gktQqGYt;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11905-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11905-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=altera.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ADFBA3044FE2
	for <lists+dmaengine@lfdr.de>; Wed,  1 Jul 2026 02:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9943630BF;
	Wed,  1 Jul 2026 02:40:42 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010023.outbound.protection.outlook.com [52.101.85.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4700636167B;
	Wed,  1 Jul 2026 02:40:40 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782873642; cv=fail; b=gXhqvOm/MChHII8H+utG0ej/bwEYB3zgjlAADKItuALG70x2VfVfbN8/NS/wFdA6GV1Lh5Pmvj0aLaDT78H+WUaXcPjDlKDTY46WdvVKuOdNhfdDWtzCYTPC/U47D1TaMud21RSQS5KTwRoKk/pFhrgUJH5jzBBBZhWpefaQ1zA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782873642; c=relaxed/simple;
	bh=+JwgcmSnqMsOyGmOEgzqb7DEo4+fFGCSLkEQSU/Lqgs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PDD2J8sXdI1jgOVo8WGgIbNaUHhpcvqIZk0tTm3wm698drMwUG/TWa/sEiLHw1EQ+nAiCGLkP7bNSy4hXS8xqwl8erc/YhwphJEtZgbX1V1O0GKESM75sg/LY27m8d336GDb9ZJTi//q0NqLfeQcSHlYcUymnnfC2DT7MVbc25Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=gktQqGYt; arc=fail smtp.client-ip=52.101.85.23
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FnMBEBMiHfolVE1k1bt7x7/cvbawHVkayflMHbPeIz9g3DfcJjKpk527L4TJlD0WIUrsdUdCBAkXB4shAxo315HVPvu6dnusDgA7XWDHuN9ed7kp2D/KU8bNXq5RG//3+O6VOpTSu4WJgi7JJvF1KvhuPa8Vtnl3aHlZUGJ6rK4HEXOWWqBcvQECaqoHlNuVfmcE7J9kAMdvAU0wpGl7VTBfywdAvMMKsp9dxZV2dnVQoqJN7VbPgNk7Ofd0/uLnoVUeWWWgxim5ZBRBgilqdC38wg7tPLHpgMgQ55CLMiQvJRMixH4FxzbNgARWF/0yCD7iVgSflvZt9sW9Ul7ZTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sw28N1Prm95WJ+ynBfZZBue47cwSx5gqxE9Ce5hSHDM=;
 b=sHbuMRCAT2cSCcKPDCQNUQXESh94VV33ArDcQLMIX0OeMb87GU1CCeYShj0SbTZJUpic0jzZ4m+SGs6zPwToT0b3FFbROBD5wXSd17unZcVzMWTwp0HogzQ3FjegOlRG6HmyU+Nv3gWJ8B3bxfkIsNh4WgTJYRMHwH8kKo4FlEfMjbbgcoJIV2qHzSbgQA+L9mg5IGHJ8N4Wqf3jabVLbHuEVMfUbQIU2Zq9Y0ssIE2feGv742r0yrYtWzdepG4NpKdZjqa7RDhWUPQnH/V5M0hHtdCP54eMMc9aBUbGiSXPI+PDkeHQl4eFFGn/gCYxZAWccAXEZqGg3dOG8FymnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sw28N1Prm95WJ+ynBfZZBue47cwSx5gqxE9Ce5hSHDM=;
 b=gktQqGYtWTaGC/kXHIKSa1PU5Np52tiXmDObRf135vIQOCvHkb9Oiv6u2cecz+idJztgnBIJJMlU1PeqEmyPfgvWSTPgcspLTHgzgEnKf4KJLqhpvjMBJXpHH5resuFx/cU9iRch8YqAKAruo+c78NlUNIfy6cSHAhaoQX/flprhyIaXt44AWskIwi6nK5EnXZMyLt+A3mlcI4M09K4SDmtKxWCbSb5umrgDIrw7Fd8SiNUOGAYHHolhq3kRzqF6gYkIo4Xmv7hph88Eiw58UEFTv6SXOO6K8a1K2TYLNgDwhDIb1FCN1glXJS04nj3l1OsBtmfISiycNu75hT5oKQ==
Received: from DM8PR03MB6230.namprd03.prod.outlook.com (2603:10b6:8:3c::13) by
 SA5PR03MB989125.namprd03.prod.outlook.com (2603:10b6:806:4d6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 1 Jul
 2026 02:40:38 +0000
Received: from DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::abad:9d80:7a13:9542]) by DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::abad:9d80:7a13:9542%3]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 02:40:38 +0000
From: Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>
To: Olivier Dautricourt <olivierdautricourt@gmail.com>,
	Stefan Roese <sr@denx.de>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>
Subject: [PATCH] dt-bindings: altr,msgdma: update maintainer
Date: Wed,  1 Jul 2026 10:34:55 +0800
Message-ID: <20260701023455.36330-1-adrian.ho.yin.ng@altera.com>
X-Mailer: git-send-email 2.49.GIT
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:a03:217::24) To DM8PR03MB6230.namprd03.prod.outlook.com
 (2603:10b6:8:3c::13)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR03MB6230:EE_|SA5PR03MB989125:EE_
X-MS-Office365-Filtering-Correlation-Id: da6d825c-8f26-4749-1378-08ded71a22ae
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|1800799024|376014|921020|18002099003|55112099003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	j1bYB/NvsQF1cvECesC6oglKPtsPuO7pfKNVnMj6wjMb6B6PmoEKqH9VDHim8Gf/7uijQoZVfsUlBF5QfNGwYKgHbozm6uTwSX8/pu5SZoQQUIYmN8P/XSftI3e/HZDfibgUmohGd1fIRQ5EDLFIuMTVt3N121JYnL8VUm90U9/cyUGyls385hnJrgFslzEPqR1wF+g23oKx2L3SnrTpc9hW6LMyRteCVrS12fAY/YZFAvUpECs1KUVIRDKT17r63xfR7yuYpr1gmmXrdMaaaRK3c0f3+qSAGKQEl9u66Z+CjIX6+WL1l6yQceR3KNeQRZfkHky6R6f5aiPV3dqT5nqkfkgGXyCCyuhjrFdxEtrmx+vT7MV7DGInpqMceCWooWcttR7Fkg21Ld3SEWhZFwBtcduXRhTSXW3cmIynNcUsXYKHPGQpGUBYEwXT7/r6OXacF939ekyXF11o7WNpp4VEvKWxd0KnNtV2EATOJ1uTM7rEQnXyvgSOQamCRuUATH5uYI2/vypxbksmxhUMz4VHy/dT+t3cJ65GZhK8rYBEWB1a63pVgGrG1HpEAD3y2m2z8JWCQE51idGysCBQfOG5ltVNY+v/AFh4KbGDVDVGhrJcY4QjW62bvynyrzFsoBSkg1aiBj0HshRie/XtDue6ouptpI3EPxZ6wp3nxbM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR03MB6230.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(1800799024)(376014)(921020)(18002099003)(55112099003)(3023799007)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SY1EqPc2gg/Bo8z5Go2/o7myj+ZTAA9XUSQUhJDqid9naf7qFMkQvxbVHcXg?=
 =?us-ascii?Q?CsFoUiawwUA8zAASz8yq+eGaq0+spLO6c8hM0Fz7f6kUxca0xAi4x2SQxtq+?=
 =?us-ascii?Q?BLQCl7/Rms4QP1ohm9d9K9kqwcYymo27DWqI1IZF0NZ35VoKVQTV2SpaMkPL?=
 =?us-ascii?Q?cosAWl0Y9bLzxTGWU1BBJCVCaPPPQw69olCaOswPP8X4g0UtxttZ4c4/t7gH?=
 =?us-ascii?Q?b2gCfa1bHehoePjNSIvqQQOXZV8v7pvZU+MM88H9t9J3gDBDdyE87GqRcp5Z?=
 =?us-ascii?Q?Ac+c+Nos7i1Po80Ur1p+ZvRUtmOvt0vQje99Gxcx4tHiYWaYHEgFUwk+ytwe?=
 =?us-ascii?Q?XZDlPlgyFI3wgrQH5jYmsQYeZLBDKGdVDKevFRvghqkz5KNjBTJUs46Dvq4E?=
 =?us-ascii?Q?1dKH8veLS1Guae4O1aNA/KIc7uEGSdqxpoEDL/MaGD4+ESH+1Sk4GACVa38P?=
 =?us-ascii?Q?8szpXnIb14PUd0uDPv9ZS0ca5US9wXPDt/Tf0wBYoMHW9Y605JDoine6jNhh?=
 =?us-ascii?Q?RyTank3V1Bz/1qVfUL3vdRAa0R6C+fuKVNgT+0h7L+bc5rXPOkTPhuuxhxkb?=
 =?us-ascii?Q?cAJTdu+efIRxs4BTJnJVWN0+yrdkCNYWOlvFBqsNhww0QBh4WAcJNdVU8F62?=
 =?us-ascii?Q?omy6p4Olt1//eAXUIn1bUGY5XYos8PLPNS/A92k51m0EmdKtrgEQeinPukcC?=
 =?us-ascii?Q?CBKg4frGsqXqeKZ5pgupwZqV9NwWdscpphirWzRU/Yy2dAmBMyseRqwYTdOy?=
 =?us-ascii?Q?+2NWLAWs2q/yr4HL6ZLk/6TNta6S4QiEBoxwtV1N7vN3aScSNKqomi1b6ABi?=
 =?us-ascii?Q?ETnk2qvOYDN+H6IlA3oJV285Bi6Pq/+VnGfpBUppJt6vtoO3qumUcL/9MIf0?=
 =?us-ascii?Q?Jq3Q0rqZg0Iu07UVgRC1dkujbEFpj2jvxCmgRCpKwh+zQtiuBZORBqwQThYM?=
 =?us-ascii?Q?Jt9cEeVnIcM1OKt8K0ld8iEgteeykXmsf0gmB+FsrxYk68XQ+/9G1Zzk0NWL?=
 =?us-ascii?Q?ME19e3XAReQmxQB9HY99fd8SkcMSR5nSbFxawIdqUXeIc56YLt+9dX+iOVZn?=
 =?us-ascii?Q?JAolyQqK2XryPcUyy25AT6U5MWD7L9cLByataULgkJRQZWqZp6H3H1hSQsq4?=
 =?us-ascii?Q?LmOJuOQ50EaJk7SlhNrec8udL3x4hsIz/dijiFEYiWR802upDC2his4mWWSL?=
 =?us-ascii?Q?iptaWlYRr+KKRL3EnhmlWoAvljMbf/IN5awVpRygZ1EywJ5jKj8EHKn1Biug?=
 =?us-ascii?Q?jhZagIznEEdTnL1iVi6FRFXoIXR+oXatt+iRX7RBSo8xyG4CKsNXCS10Y08C?=
 =?us-ascii?Q?LWX+sGcnT4+wZm67LGKCf6oyhuKYrh73S6Um2AegJHf3ncGk7oRKa/JPMfQN?=
 =?us-ascii?Q?2R3gpk2wVK9LPf+O8LPgKLkTsIc3nnYw/oL8D9MMCE3Nd1ML7LWmJMa1/wNk?=
 =?us-ascii?Q?8Qdk/5w2A0wLPnpg6zaOObU3rrIo69BnM6MCmkweMTztkk7HdYb9uxjrq5de?=
 =?us-ascii?Q?4V9tpoJVtMk9xlF87DIoTWQ0wOghHUzW33NKcfq7FagYCBvC3p6L2nLVi5Cg?=
 =?us-ascii?Q?35ahsIQtGFvFq3dufg39qXpjtziKNh9EvxpD/DUHhoN9NM8CuK7C+poIh38m?=
 =?us-ascii?Q?NyKa9so0K2SmLDBzqTiTH/q/h+cMan5xXdkjUMznucoQ8N2p7q++FB6VDfX1?=
 =?us-ascii?Q?5EFX/Mvsxy4HMGBH/EuLYKPVW+fqo7+Ykwgp1YdO+1e0GYWEvA5NuS6b/nyz?=
 =?us-ascii?Q?VBHl9hlihz6E2ETylGYHiIuEJmz5ReY=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da6d825c-8f26-4749-1378-08ded71a22ae
X-MS-Exchange-CrossTenant-AuthSource: DM8PR03MB6230.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 02:40:38.7076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lv/LJAOBfXbTD2z8p/J1eNPQbOq8RvsJV8WlVbJitZboOCqaF+YDtjwRo8UnkpTa/pUarg2ZsQhnGhGxHuqehGYcz3SmXgjZMEoc7RAzzo8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PR03MB989125
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,denx.de,kernel.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[adrian.ho.yin.ng@altera.com,dmaengine@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-11905-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:olivierdautricourt@gmail.com,m:sr@denx.de,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:adrian.ho.yin.ng@altera.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adrian.ho.yin.ng@altera.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[altera.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,altera.com:dkim,altera.com:email,altera.com:mid,altera.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4C9CD6E947B

Olivier Dautricourt has stepped down as maintainer of the Altera
msgDMA driver as he no longer has access to the hardware. Replace him
with Adrian Ng Ho Yin as the new maintainer.

Signed-off-by: Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>
---
 Documentation/devicetree/bindings/dma/altr,msgdma.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/altr,msgdma.yaml b/Documentation/devicetree/bindings/dma/altr,msgdma.yaml
index 391bf5838602..bea302b89453 100644
--- a/Documentation/devicetree/bindings/dma/altr,msgdma.yaml
+++ b/Documentation/devicetree/bindings/dma/altr,msgdma.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Altera mSGDMA IP core
 
 maintainers:
-  - Olivier Dautricourt <olivierdautricourt@gmail.com>
+  - Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>
 
 description: |
   Altera / Intel modular Scatter-Gather Direct Memory Access (mSGDMA)
-- 
2.49.GIT


