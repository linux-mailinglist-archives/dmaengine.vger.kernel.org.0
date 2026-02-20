Return-Path: <dmaengine+bounces-8995-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EmHO9e/mGnuLgMAu9opvQ
	(envelope-from <dmaengine+bounces-8995-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 20 Feb 2026 21:11:03 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5003016A90D
	for <lists+dmaengine@lfdr.de>; Fri, 20 Feb 2026 21:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5725302F724
	for <lists+dmaengine@lfdr.de>; Fri, 20 Feb 2026 20:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C99434DCE6;
	Fri, 20 Feb 2026 20:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RdoX1/DW"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013053.outbound.protection.outlook.com [40.107.159.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DDA2FDC3C;
	Fri, 20 Feb 2026 20:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771618260; cv=fail; b=bFLqqSSJGXAvzyR/fRwXEArf5oDaJfWs4oAnJ8FVGxDlWULWu+OauaxBivemAV15maY+cb5IsGdEeyw4ydDOVVbW+PU1XkN7T0xtxbkcxpK6DhxUdvn0B9w64HLHLcU9noo1G6CbRvw+8YWJYyr4c6LLU7WwNTz3YHfgDW4HFuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771618260; c=relaxed/simple;
	bh=ifibTgGE9oK26aGe52r/ZA9EjmqB0Ea7WYGNjxDOlIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CvAuzkfozyhNp1kyAe7cbhEUSMuqwwnxolicGqxoT8ielqLZsvLtMgjFjU4bpjdPCw6R5ZOXIOMDkKUNsGiWheMpA3ccOXMO2po5+O7zrtrs17RXavhgobprPH6r9XgARTtrpB1KOPfvfkIvc91g0mZHutpu3bQY4bkrgFLQPr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RdoX1/DW; arc=fail smtp.client-ip=40.107.159.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d3HHvkwQVv0bOu4MieNpqd8Hnjc+YxSTGs2MbZh2CGGXDiiQq2RQSQ3D5RN73UFuRQGR812XcuqQL0CQsyfWg9bKdeXNGl7c4UX3HKOCbQnJERAgOOoL56xy884PLPQ97CDstHYNj8Ot/NvDBYasNQzYzwHNSGS8RR9nBkVU90q+kpRiZDPmV9PTrRefmiwl7/bx3fCApiYL37jouMtTmrYkNJiy+YZhlE+dZr+abKdBS6kEQAxltKseTOYJOlRJGAYTPqqL9EZLODkvUEh6ipavILKxE11tdojWcPhZi4GxMIkj+IkoGulMzxeNKU5ZO1jjcC8HCqt8zFxk3kFDeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6E0Iqr4G4fvj5ThLgThvNKGsXyzIMoc/YsZlhikbsFo=;
 b=dHN+ZYINAuOFJODmpz4ia9bkRvn/6D0XHfI+gNEWNPVsGU4L0j3b/e6CdivGCj97t3MoluwHegiaro0mSKInLXRe1y8xjOM3zzeOE/OXTA6W7GEwer+fw3uq6H3+vBn3PYpqb205oj2DyaUPOy/jgIcZnOCVdNi4F0SJsgKB54D9QlhkBDU++fWYQMI5k+YV5E2qU8kAI9+9Y2B6lrE6rPGXH0+QDCCwky+KRl3/rP7pQMhsw3MafWIvU49bL95pN7fE7Krwo5wyPhtHet17eONxoje7J/5NDyhE1KdBILmtE7t4roNuHYcSr5ZJA6Wccw8UhstRQTSqzf+bi2sLqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6E0Iqr4G4fvj5ThLgThvNKGsXyzIMoc/YsZlhikbsFo=;
 b=RdoX1/DWhA7w8tuPRUuGoxa+9vT2wtISJ4Z5p72UWZBlpp4tHW2cM3hB+/mHmzR5NjEtnsE4D8O5/FTJku6Oz7nsdrH95aRz5yJhdQRrneezaxj18849/9ChtCHohHfu0scRpM0oo2gZhl9cGrTltFCSyPYcnK6uD7hxN3+1mvCOxPjD+Uop8NuXJ4hiWEiwX6TL3hdjgBqcr+lcVAz/rx5tpNb+zIy6/ZsLhtUn1uV4USDwf8czYGU1BBWoXe/wHR73lv02Yn/5QN0Zy6NNsvfbub1s3p0zevsFqUo2S8vZaJYv/oAEeJD+qFQmcUoHG2NOfuhK0RuqQKN/ebYvzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DU0PR04MB9636.eurprd04.prod.outlook.com (2603:10a6:10:320::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Fri, 20 Feb
 2026 20:10:54 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.010; Fri, 20 Feb 2026
 20:10:54 +0000
Date: Fri, 20 Feb 2026 15:10:44 -0500
From: Frank Li <Frank.li@nxp.com>
To: Max Hsu <max.hsu@sifive.com>
Cc: Paul Walmsley <pjw@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Green Wan <green.wan@sifive.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Palmer Debbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/5] dmaengine: sf-pdma: add missing PDMA base offset to
 register calculations
Message-ID: <aZi_xAe8o1dNTz3t@lizhi-Precision-Tower-5810>
References: <20260221-pdma-v1-0-838d929c2326@sifive.com>
 <20260221-pdma-v1-1-838d929c2326@sifive.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260221-pdma-v1-1-838d929c2326@sifive.com>
X-ClientProxiedBy: PH3PEPF000040AE.namprd05.prod.outlook.com
 (2603:10b6:518:1::59) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DU0PR04MB9636:EE_
X-MS-Office365-Filtering-Correlation-Id: 78635d46-5ddb-4a3c-b20f-08de70bc26e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|7416014|52116014|376014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cdQGmzWD3VeLCSzMeNmJRquOnK6fShO9vbTzax909uvxCzBRGHSOn3D+MCTU?=
 =?us-ascii?Q?xhZflSzvXB2dr5M06pw51DIxfezNFD2/7WkANAK5ECkUL2r7ja23FWzCfjW/?=
 =?us-ascii?Q?FTZezOX6dhFrExIqCB5k+R4yTGgSGzKjwrW1coUOqMKRqRBthRa1PSLFGJrQ?=
 =?us-ascii?Q?78TnBRuKxaSr0YpPudcAHLQRpTSoCHdWgOMiuaZmCGKIUp5ZfBcIoXkbfm0f?=
 =?us-ascii?Q?MKhViTtkB/s5ANFSF/k5AVoK9U2BxLHjgJAffNhOuv6agsXDxQbRNB2PEZWK?=
 =?us-ascii?Q?09YkyBEn90dRpfOvW/7kC8EzY+4If8b2VTi9tJzq47nphXmTIswAaKQ+avvI?=
 =?us-ascii?Q?/0wgbEdidG9hcE+ILe9mJQ6YKhakDBvye5jijldSk4wX991mdLgPSauWI3YQ?=
 =?us-ascii?Q?UxR2JF8HvC1DfpTz46NvFBkRWRc4LTgEDBsiEyT9K7EuXt2sitjK3ZOlJaB0?=
 =?us-ascii?Q?Coxv9T5wLMogEaWbXg83cKEmX83sGGzgdBlZyp3U0PwYH6U0HadZmmGm/zE1?=
 =?us-ascii?Q?cNQwWwSbs0Rb5/da/5FyvXL5pELaYSJN8r7842d2nuk33lkUYw4cCgOthqJR?=
 =?us-ascii?Q?J9vxidG0rrcTZSIgnTAl0Zb8EZyquCG28VYI1Cd1Q4vdonkuBH9J5IoasZzT?=
 =?us-ascii?Q?OtdJmu7rWf8CrrCqQvje5rKIJv3RDNN3LxkbgKOXqHFtdOFFQe2Pomq3CdmC?=
 =?us-ascii?Q?Go9OTakA6MuM1otjBmFtVyJ6g2RnwxZLhIjwOF3rI/MRcewd/I/Q0lMkYdKi?=
 =?us-ascii?Q?FbvkFJEkhLS8J6pRKzgpNTg2btDV631/RXZOb8co8FTvFbAAdNZ4xxmg8KG5?=
 =?us-ascii?Q?X+ZMyrdogeoCtDUkIef1L1nisxIJiHqyfKBOkROs8iIdgG+uDW8QIv6Q+5C1?=
 =?us-ascii?Q?tJ0HUENkhwF0UPRqgq7n3DWT+vMrbNdiYaz5vGFBMjR3BD+RYDYeNN2AlT6Z?=
 =?us-ascii?Q?H7TcRiTd+zW93heH7HtLMLj/RB7Da1qHCZcmOitHx4Ij+HFwyvFiARFZfIGN?=
 =?us-ascii?Q?c8kExbdFFQk27RJ4c775r8oBLunGKFKkQZx3oBAnhNZBGtur9gq496dK0BCb?=
 =?us-ascii?Q?AxOXJ3yLrcQGqpbvWU8TYawtQ23uW1/+ugjO06W8dYNrp4VvF20euoJvZjHk?=
 =?us-ascii?Q?aEgXQezVZL7vrop0guLbRJ/t67So44F2mWF+5IQNfSPpviBWl/m556itEl75?=
 =?us-ascii?Q?ZGvbQVnn7QIafzcKsrjC0a5D9iIQtiG26PQsCSsg7h2F60uhunBX+kPu2Ihq?=
 =?us-ascii?Q?HKz36bxs1/KPAvNufHZ65y0VJRrYT75IkEVWBgyYdRJ26I3dNvYSpEpd9Xgw?=
 =?us-ascii?Q?QYNsRZ0V7rgrlls7XUynthwGeFanNgTaV+naOJ04HTx7VM01h1/7Nq1rHZE4?=
 =?us-ascii?Q?bP9LvkuLYBAi76xqmGCmegBj7M8k5Dm1GX2uidRelpr1DQD/GvvYcuh/xe1e?=
 =?us-ascii?Q?3TCA+PuCrRGBVPZRiFL1vhMD9gRXsY6iwKHqkqnaqFW8Gyn+x4ZHzbCvQ3+6?=
 =?us-ascii?Q?qtm9qyTxDEAJfbn0ORSPpW+gXMUGk4pg4+jBXz++eLEYlGVhDL0kSqIUOqzp?=
 =?us-ascii?Q?8vMuXjlNEE4j/Xkc7pE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oaE/2JfsSaCgFXQjB9yBnu8CvQ7zF3fzWZ98NaD6fek3r2lVzNr3O+ny0fdD?=
 =?us-ascii?Q?+mRVSrO42RAhAFdX1lPYBoJi6yh3h/cZ/ecHy1gZKMSwlf335o5tz0CCh7dO?=
 =?us-ascii?Q?hBF/joOfg5iaodMRMe3RRTCEovnW5b1FeW5xZ2qZKXE8EQArBaxIKoNRUk9w?=
 =?us-ascii?Q?Hzgp5MP1ZNfNwB2ZJPgUAqmcvGTKANdEdnXs90U/wsioJ4REx5veSMyvfV5a?=
 =?us-ascii?Q?7jNaHSrs+ee1wQhGh+h+izQRP8WRD3oHaX9XNz5bpYkCsggFb6KijwW1JBCP?=
 =?us-ascii?Q?aKNB99R9oR5qmYd5M8Cn+9Kkf2VYMD37dLKXIbKsWnCcNoG58/+6NEgnupgG?=
 =?us-ascii?Q?qgXomJbO6ILWN/Vi+ez0IzO57YfTYZkcy+dM4yNB/pXHYLQZqFNMrU59alzI?=
 =?us-ascii?Q?bvZ22U+ibbKogfKB5kL5oONIKc5G4Y6Ux7u3nPkmMGs6ZYqBslERlXplq0uV?=
 =?us-ascii?Q?6gDNJuCrbLc7f0P+czi8w12fxvEzwFcmjB7y1D2BDJEsW2m7CsqX3umo1vAQ?=
 =?us-ascii?Q?AvbEPMuLIH7ZwOSy/M6N3G0MyPosF8R7d3tLbCjFzTxf1GLKZd0b6dYQ9cR7?=
 =?us-ascii?Q?xF4aQP6PiGx5cm2o+VCbVvgZ4+srvcr7fag+dZJp3AT+/wDd9xWbF95Rrk6T?=
 =?us-ascii?Q?qjUQlcOIBOkcQ7Em9TPIhWIV4PYXrAzjZzQjNQNo3qUeDUda08xxdLwJ0oQi?=
 =?us-ascii?Q?AFdwH4myk8ewr81iF+zc9EzgRf3LO9h0MIUmIPYXwOvqriq/vFIRqkJJTxK2?=
 =?us-ascii?Q?NKiET34hFs/A/bJ50oSTkaiTtdgNyR8dvqLFBXfDfY9iwECeF+la5lpsGbf2?=
 =?us-ascii?Q?d0Su+zO5zmd4/V6+0TTdkZ7w3Q15QMt15QvvB4Rkg5fO52eVrk+DHfltCQ/I?=
 =?us-ascii?Q?EqeBRl3AHgMEUemAKXQfRpwmRUCnmkZewSE+2Bg//eXpX18P2BN5dZrEQkjf?=
 =?us-ascii?Q?cQPi9ocH0yef86Z5mgX4JEX9RH5Gcth7EaYXTicSjGa6BRPcG8Yx/yUBkA4N?=
 =?us-ascii?Q?tVzHaVAwdrPE/3Fz8KzeMQZHkF0tKUEcf9F1QjWeRrCVD42avDSz9BFPzJQ2?=
 =?us-ascii?Q?HH0bMJlyYBGQMurJ3yPkJkMnT7G7weT8H7AgN4YHS/gayueshXrdyI0ZL6IW?=
 =?us-ascii?Q?U7Tm0ZnBp4Tw6CW3HsF3YW4c6i6E1hA3Pug7D8IilmiVs1pTOnt7EqopLmpR?=
 =?us-ascii?Q?YjqOyxmwiQNXxVw4iJelEs4uaLvrknx8crqHKKEP06wZ9Xgi5ySijvtjVlJw?=
 =?us-ascii?Q?BkJU+qxepWStEAKcI0FWXQF/bE3vdaUIQ1BeI5dLQhCDxXOLKbcu735mBXyd?=
 =?us-ascii?Q?Y6EPmgMkjw++cIsQ7q9g8klAnGitUe0w8bVBmok+6VavpYxr4LFltgbhJtfT?=
 =?us-ascii?Q?4KIQkkQtNBKznzQzQAGNFVdGKDusQASqg2zutn0bi6mqppr10jSEA54SSDP/?=
 =?us-ascii?Q?KGn6JjT69ejZ6IlqZ9wz1vHT6gSl+GSd2xx+TIw11Bmxbfg3Up8jg/O2ngAL?=
 =?us-ascii?Q?2jhgbCXLGPrWPvvEp6LE2ZoWATx0Ag0VpMjWvNh1AxM26wEyiq42GvY9fQ99?=
 =?us-ascii?Q?Ow8hVZg8B0HpxXtB5X9FWrBI/5iBwCVAA6HcaaYyXSFVpKJYg2kWLkv92rid?=
 =?us-ascii?Q?OYxSuOYt90neowq52QjsaijeUI2eBBX346f3O64GpOwD7BuYeQXZHA8zXhHi?=
 =?us-ascii?Q?vyJW3qTXe2P2w67FvCA8ySnzNv4iXYcNvQ+aJywRy5mGNyj+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78635d46-5ddb-4a3c-b20f-08de70bc26e9
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 20:10:54.4903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rJ0iNsBU3RrGLSpT/ruGHyX3CKwh4a/XE/BP4gmu9yv2xeKmkFLEmbP0VkZuAxlhdO0m65F+LPymLFn+Kw1Sfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9636
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8995-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sifive.com:url,sifive.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim]
X-Rspamd-Queue-Id: 5003016A90D
X-Rspamd-Action: no action

On Sat, Feb 21, 2026 at 03:43:53AM +0800, Max Hsu wrote:
> The PDMA control registers start at offset 0x80000 from the PDMA base
> address, according to the FU540-C000 v1p1 manual [1].
>
> The current SF_PDMA_REG_BASE macro is missing this offset:
>     Current:  pdma->membase + (PDMA_CHAN_OFFSET * ch)
>     Correct:  pdma->membase + 0x80000 + (PDMA_CHAN_OFFSET * ch)

How it work at previous version? suppose it is tested when upstream this
driver?

>
> Fix by adding PDMA_BASE_OFFSET (0x80000) to the register address
> calculation.
>
> Link: https://www.sifive.com/document-file/freedom-u540-c000-manual [1]
> Fixes: 6973886ad58e ("dmaengine: sf-pdma: add platform DMA support for HiFive Unleashed A00")
> Signed-off-by: Max Hsu <max.hsu@sifive.com>
> ---
>  drivers/dma/sf-pdma/sf-pdma.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma/sf-pdma/sf-pdma.h b/drivers/dma/sf-pdma/sf-pdma.h
> index 215e07183d7e..d33551eb2ee8 100644
> --- a/drivers/dma/sf-pdma/sf-pdma.h
> +++ b/drivers/dma/sf-pdma/sf-pdma.h
> @@ -24,7 +24,7 @@
>
>  #define PDMA_MAX_NR_CH					4
>
> -#define PDMA_BASE_ADDR					0x3000000

This change belong to cleanup, don't mix to fixes into fix patch.

> +#define PDMA_BASE_OFFSET				0x80000
>  #define PDMA_CHAN_OFFSET				0x1000
>
>  /* Register Offset */
> @@ -54,7 +54,7 @@
>  /* Error Recovery */
>  #define MAX_RETRY					1
>
> -#define SF_PDMA_REG_BASE(ch)	(pdma->membase + (PDMA_CHAN_OFFSET * (ch)))
> +#define SF_PDMA_REG_BASE(ch)	(pdma->membase + PDMA_BASE_OFFSET + (PDMA_CHAN_OFFSET * (ch)))

why not set membase to pdma->membase + PDMA_BASE_OFFSET directly? are there
registers between pdma->membase and pdma->membase + PDMA_BASE_OFFSET?

Frank

>
>  struct pdma_regs {
>  	/* read-write regs */
>
> --
> 2.43.0
>

