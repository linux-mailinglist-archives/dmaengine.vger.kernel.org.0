Return-Path: <dmaengine+bounces-11642-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fECdKIRoNWorvgYAu9opvQ
	(envelope-from <dmaengine+bounces-11642-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jun 2026 18:04:20 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D9B6A6EC0
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jun 2026 18:04:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=I4BNs9Xt;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11642-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11642-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25EC830CAB8A
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jun 2026 15:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F288D3C1083;
	Fri, 19 Jun 2026 15:55:25 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013040.outbound.protection.outlook.com [40.107.159.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4803BB119;
	Fri, 19 Jun 2026 15:55:18 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781884525; cv=fail; b=kOKoNJ+fbTYb6gZAouzNiRvoL+sajEU1zlukGT/FDkHS+XCmIgSo1pgiUyDvW3h8c2bwlV86px5QF4rHSSl1Epa2p480nr7holWQGb1l/1M+mBmv/qCxG8y64SPi4YnreLkgHXvf1K3v7Kijfqj+CYDvsGstrdy3L0VmyKJN3Bk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781884525; c=relaxed/simple;
	bh=L71oTs2QRwNNJryRuuONuWfZIh3rV56pWhgFv+srktU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZsG2cdTKXEMoe9j/rHf9Y17nrUkFQTjQ+nXqesjst9DzxLh+iyGamTtCkC/L8zaXUPdkN2H9vSTGOJKET6FRVX2uOJHsviYnijiKEbpY3G/imJZBmKHvCFY3GvgoDbscyjaYTOkTqKneHp9U2uS6Q/WyfPwOnkw73mKta8/7pgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=I4BNs9Xt; arc=fail smtp.client-ip=40.107.159.40
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cGDVCcRI+g9yda0uCjQUq+/44s5cGyE/5rc5U+E9geOYmo9nHQ1e9x8MuojwYdhajhS+UEdCK62brUb8GI544A66gqQUXkyA1c7HzbmKUclvqtBVUVg9NCr52JsJajbyYbNZpI6mylmE0pnwbd1ygN9EXASr7xoGdLa6QJ3ujdxCOwpdxhaPNLiyyJEk+Hp+KMgFnKVh/2ck7HtQMOG7wkyx4UBmgbRwMSiX7EuE7MQUbrVSld/ptt45Jlg+EpWLai7VwILpZtu/JIvKR/iWPZqwzetZx94X3SGMmaAy8K6Lc9SkTcbVDPvj93XfM58h+D5grRtpMmXUKJRHsZGbvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+JirTmQmlSgc4jir1v2XirqWQnmllRjVHuEutEx8HpE=;
 b=rpCRIDCg5pVI2QKqtuYgV4/5GwW5erKRqYGLhWm8mTu9EfT3v6oxwl3Fj5FIbF6qSZn0/1JZg8DojEqi7SXUJj2bAtmyitdhGr3noere/IA4GjFagYE6HNeMHT00ku7IeZ9QZIsp3v/cj9KPCI6lrsUe8vE4ofzPI+R3Xkn5ISq0H6w6nQgnxoNXmNdRj/Mzf47zLPZdDWE/S3R2wNkSbToFHkAxdwXhjhKIgux393ioRv3cnfK8oxIXP8vREdeje/rMNZQkBd/CiUIhekv4PVfvWol2hP+5QGm6YUZpbfST0sVTEAngrHPCU/LbH8EQjfdDbSN2rP9gveoQHsiFFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+JirTmQmlSgc4jir1v2XirqWQnmllRjVHuEutEx8HpE=;
 b=I4BNs9XtK4K/63np3wPoeyEqhgQXiPzG6cIFk9plp9O5IIZ45H9ZehHwxNjgABuPTjfQwXjon4fDSgfXGaNbBnDc7gWpcheCtb27XFH09BgxvkQ9JFXelV0qAUD8LWSGvbDDgMZ0moyQnMunMIneOwimSw8j4IOefTsld37sqJRbm4L6yshpFu2jN0xoXyXRvBlpimSj2Uk6zi9abiMJfEZMLhJfCwXxrfTV573rnJSJwbz9r+IwmEUJaen7JikskfbCt+ooVnMO4v8uVBqHm3fAGYLRbna9HmTsE3Vg24Ew7/GRHnH9YmRTa3FXHO9Xdz56qSNLL/dI1rhydHdsRA==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA4PR04MB9223.eurprd04.prod.outlook.com (2603:10a6:102:2a2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Fri, 19 Jun
 2026 15:55:15 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0113.015; Fri, 19 Jun 2026
 15:55:15 +0000
Date: Fri, 19 Jun 2026 10:55:05 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Yuanshen Cao <alex.caoys@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Ripard <mripard@kernel.org>, dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 5/5] dt-bindings: dma: sun50i-a64-dma: Update device tree
 bindings documentation for A733
Message-ID: <ajVmWar3_5DBWFw9@SMW015318>
References: <20260619-sun60i-a733-dma-v1-0-da4b649fc72a@gmail.com>
 <20260619-sun60i-a733-dma-v1-5-da4b649fc72a@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260619-sun60i-a733-dma-v1-5-da4b649fc72a@gmail.com>
X-ClientProxiedBy: PH8P221CA0058.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:349::7) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA4PR04MB9223:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e0529c9-b989-46ca-32d0-08dece1b2716
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|19092799006|56012099006|11063799006|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	pFKnhjph7KNvhwdJiRAXRPmjuktu2K2Bgc1gcr1cjsE7Gsn4rl7REmt+cMUZEktAzMmWOAopGRWwDM5q2IvagksBUA73qAXj5Jdg/36rK5GwCGlXA0zvujux7LrA5FuFrNf1z3aCRxqc812qvUXImhfGwnzk69NAneki5OOmiOyX4EBizFCOEaFAWiI6p1rOby2zrFfs6mFpDlc1ni79aKcX33yiTL6tujuipKqWLswttTb4/J47lYyoGD17mBJJ4u/yfEzkKpwltfrzSCMBow4/8IZ+5LRl3fPZOrSSmm+/fEQqsBYDxlCNNKSykKSC+yqkJWtUPiSZR35SyDIUzNnM+Xmy+9q8UjQogdyAhR14BU0iG+z5SrEVkxVk9Z2VLpX7bSCSQdlDFvsJlW1JEy+abKHYWNBq3VeaJwSmLWHroPZM1J8Ass5Je5SgwP9cRX3bOFx+zDAG52kAuqjWkIcEKiht8pGk+SjMVJYSE9hZHirJf9lIQd4mgeHUuL3tgPhyT9pt7W3tMC1D6MzoKzB9IehZA6NHnPkCq1L+GNk+/E2CoK2auTRK94Nr9IBl+7c8oUurXD4pUtU++Jnq+m8DoPaTI86qjwzdekvGgmVIi1KwhjcZ7Os5UHD6yOW/3lBs8Q5+utCtIkak8uZ4ezNQ0xQ7KAtpfNLzsfn+B8A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(19092799006)(56012099006)(11063799006)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0mrLyyGu1NJX2xckC1f57OdWohvrWIbsws64i4wyS+eOhR0558X3kG+EnXgJ?=
 =?us-ascii?Q?pUdDd4vI/aEJ7qc9N6vouzLH7esfBltSkFQqkJv2aiG6Mwn8moA1+nDGSWDU?=
 =?us-ascii?Q?VEUd0odhnn3RgTSnM5efteOVzjSW5VbFj3t+vrpCBVhzMBHPpcQsZy9HNJs7?=
 =?us-ascii?Q?o6ACmZ2wfoBzxnuNcCer8Zq5oJGt3gWCBwxDv8BLLlNTPZuMWS+8SW5coDh3?=
 =?us-ascii?Q?bibKfzPv+tpdWoD2aXEdCA5n44ay7y9S0EnEJt3Bg5FoCCPLyelxaxrRwGxy?=
 =?us-ascii?Q?duNqU5FCVebcAThhu7o2OYCAWygu+e6UZJ5oP4iX6Ih9KiIciBPhKDQ/oBxF?=
 =?us-ascii?Q?tqp/wsj70gu6EnSNpPVbwsWSN4Kw4dXTQMiliLa8S3vFKukLzodw49hUPy49?=
 =?us-ascii?Q?YXjneEpSnVZTBwxDB6f2Rz7M1Si/Go0xopKf0h7zi1PFX5dfnvhLLqDFTtvW?=
 =?us-ascii?Q?9FQ6pzn5Y9sTq4CAX3sqhvlTLmLUdD8VeKY/Do8PJTM7APyIDdfIZLSCulMm?=
 =?us-ascii?Q?f1ETtCpvoXXkajISXWh1s7jMJ6rZXAIDP3xFkzztMYE5p7UE6T+MJpuDh+ls?=
 =?us-ascii?Q?QtRj7x7f1Ft3wtGSd2SS7NYgifBcj5NLUvdlbsUKddtiyfCvaHvtXOnvnUqa?=
 =?us-ascii?Q?mE1jpN7EzT87C1zTMPPmBsZpaZOc3aMCOOhBe84eEj/08bx291+GQxVhQf9/?=
 =?us-ascii?Q?E/ASdh333ICMKDIyrNpfFRFyTAYsXl6wIDRZDFDrB9P5f5GNqhLZH2ISQQRn?=
 =?us-ascii?Q?2z7oksQx9J7lfCsW8bAK5ZksrpCa9G4PxWuo6sMtGwpOtxWIhb4K11LMn24K?=
 =?us-ascii?Q?KF5Dc5KoywUsWxG/qbODaPS7S5M6iWSsQcCKW9QY4ZjIJOCOiDr2OjvhWFRJ?=
 =?us-ascii?Q?jrrtmOVhl4dyMcG4zYJh7M57o0QRnr+dL0Glt/2+UsZ4rZkrp6WSMRrWKfz6?=
 =?us-ascii?Q?/agUG4lDSXxmd6ayZnbup2QoGhibogLcV82uqhJm1Y+phEk961nqERppFbaN?=
 =?us-ascii?Q?lFgcZrKe6lmYxfMVQdzlB3rA3sbTzn67vmliJwfk4TV6xcHCW55pI5bZKlIG?=
 =?us-ascii?Q?9B5vV++RE+njTqM3FbZDOShK0bBoSfdLi5tSCrIcHmEGZvUuPIU0a5wpIcsE?=
 =?us-ascii?Q?N7xFfO1+sAt5tc88Ehdt9fedwqXsRBEYR3M3w8fYzh9PvszQQAIn8Eq/HMeu?=
 =?us-ascii?Q?5t0EcqHylV36IqnwKDysTl9f4XF9C6slfIctybc7we1VKtZR9eH202R0Xrf8?=
 =?us-ascii?Q?3um8XLGA3HzME+7U85lQyqIpXOy+Un1R/oulQpeUTrTaQ9t9+F1/f3LQkaPy?=
 =?us-ascii?Q?6Q8/M5AO71VEmeVn8CcxANoo6/wlspaMVUsesKoqDXLqneLJKeow9V0Vc1bi?=
 =?us-ascii?Q?uat84lia75SQBJu+XB3rOsSDlvG7yL7jwWFpB6+n3zbWH3ybL1yw19g71bOK?=
 =?us-ascii?Q?N5I3C3rm35GqgIxydsjCiBRW1ETkPui7dsJBGldTnA/OLposrnaNo+AAGnbj?=
 =?us-ascii?Q?tr/uJ7wJ6HUViIaqY6JvXO0xJ4HzKBXJcloJQQJmlEaWJiB51y5q8KUeIzhV?=
 =?us-ascii?Q?S9iIuSAiWsCuylOy0No2VypiwJ8VFef95f1AQgDyyeAgwb2fHOs3pPhbXUzw?=
 =?us-ascii?Q?atbYgHNjNrD/g9hF7ty23oKQy5i8qYE6d604l74RT8aN2X2HjkY68lmJdljx?=
 =?us-ascii?Q?VifS+BMP6LEe2hBDcEouCIV9yICoBJx03pnkYH7FTWJJ/EDlqMBeaakiR77Z?=
 =?us-ascii?Q?DMAB05PeQyWEhvwA/Jksj2283M/zeJe3WLrSyBbO9qWpjhgW5Ch+?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e0529c9-b989-46ca-32d0-08dece1b2716
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 15:55:15.1026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cJDJ6hO6SFargB9/vOA8LEyYfQt63TxywIXPhL59jgnpayUi6BhllQ1Xf7NTHcjtAjcrfO3fKRTd8EN2tmJZsyl/9krULM4CiKnE3y9mzaJHbeElfN3ACY5OsM3hDQ2n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9223
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:alex.caoys@gmail.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:wens@kernel.org,m:jernej.skrabec@gmail.com,m:samuel@sholland.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:mripard@kernel.org,m:dmaengine@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-sunxi@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:devicetree@vger.kernel.org,m:alexcaoys@gmail.com,m:jernejskrabec@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11642-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,sholland.org,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.nxp.com:from_mime,NXP1.onmicrosoft.com:dkim,SMW015318:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 29D9B6A6EC0

On Fri, Jun 19, 2026 at 04:53:34AM +0000, Yuanshen Cao wrote:
>
> To complete the support for the A733 DMA controller, added
> `allwinner,sun60i-a733-dma` to the list of compatible strings for
> `allwinner,sun50i-a64-dma` dt-binding documentations..
>
> Signed-off-by: Yuanshen Cao <alex.caoys@gmail.com>
> ---

Sorry, this patch should be moved to where before your driver, which use it

Frank
>  Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml b/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml
> index c3e14eb6cfff..1cc3304b7414 100644
> --- a/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml
> +++ b/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml
> @@ -25,6 +25,7 @@ properties:
>            - allwinner,sun50i-a64-dma
>            - allwinner,sun50i-a100-dma
>            - allwinner,sun50i-h6-dma
> +          - allwinner,sun60i-a733-dma
>        - items:
>            - const: allwinner,sun8i-r40-dma
>            - const: allwinner,sun50i-a64-dma
> @@ -70,6 +71,7 @@ if:
>            - allwinner,sun20i-d1-dma
>            - allwinner,sun50i-a100-dma
>            - allwinner,sun50i-h6-dma
> +          - allwinner,sun60i-a733-dma
>
>  then:
>    properties:
>
> --
> 2.54.0
>

