Return-Path: <dmaengine+bounces-9107-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIjXN8lsn2mZbwQAu9opvQ
	(envelope-from <dmaengine+bounces-9107-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 22:42:33 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D48919DEC9
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 22:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 64195304AD24
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 21:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEB4315D49;
	Wed, 25 Feb 2026 21:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aJM43WdH"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013037.outbound.protection.outlook.com [52.101.72.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D956C318B9E;
	Wed, 25 Feb 2026 21:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772055730; cv=fail; b=ou+U7PeAbxxkAfhpVqz/EF+pQnf1KlLdaOjXsUlYWwkV8BhNzCkdjsShopqETc4y4aaKa2HwymxRy63Ti9kx52H4RJjJFyXD9spNS/vi0xuQ6h9mxqIEuNDHZLfe25ctwF7nqCq/czPyYiYVS4M26VpVrq1q2okLud2e3FvXMRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772055730; c=relaxed/simple;
	bh=KKRaBkjT+4vIHkAC3n3uengPctoDgGgvcn3B4rAOFt0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=K6zDo86CNjbfLZrsJrA7KmhzNy/w0PXIpuxBEs7xZwUk3VN50NGAJBaUmEUhD3nHv1oAcBbTTvrgv1pP0BlR69X7wIKP7hONTlGbe88qBCdv4xB9MAm1sB75GFb7qjNZUNsV1CUi4e9XUykSflpkC5PDptuVNl/JpFc8CMv/Nmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aJM43WdH; arc=fail smtp.client-ip=52.101.72.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wZ/a0wlVgTz8x1vmSbUGBK6p5+zD5VBjFO1aycRhM1U1/k54iaBtIoECZRizU1R5tOIPnsZchv8rvQyeiN8gZ5j0ZYOeS6Ea7qad8yVe5BqnHr55q1YSSbgqsut20njWcQlpDTqCXPiuSoEql5JiCg8nYq5/fgMZTKNMeYy1d3Te9TkJBeKH2Ed/C9iMM3wrTUChjJ0xR62qbZE9L4u+ThRIH2CMa0CeWWqwUDBjCcAU8PQD3MYIET9GZuLHKxsLRZ9sfTDwpt/E2STsPt6dtxjNnWJAaqqFgq8j66M6jlgHnQ9QXHMLE6S6eA3lxwPgtK0ClB6Wmq3t8dUtFb36MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pyZJGZIKC4jkVy/KcnKLofSMCMBlH+euYvp2xaBVAME=;
 b=BXiZkMyB/VIs/BKDhDpTjzPJBaY5K+bKsigKiRAvSz+/gQjc11HHUSp331cNTjbNJfWqCm/lRBmR2Zda5ERlqnDKNOgGtfv7krSF2ZMsgp4vlvfRG0p5b+sETQqgyDtgQ+KV96veAKcirhHiKNj0iEwv0WQ3PgnVG869Y/naPv/EmAXN8k/Ursl+oqHySCvZSWd9oXawrBplhruEfv42q/7E9Bt0hllTXDcSxb7T5hwI1jx4BhpobKW4itppaLa0xb3bNOcvxC1t5ZZiKvXCt/fq0kddTbMacZ+Nirc6DjIuXoReD9T63Uf2ypilnf856dRa2V94Su1RZFwx4TKN+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pyZJGZIKC4jkVy/KcnKLofSMCMBlH+euYvp2xaBVAME=;
 b=aJM43WdHiYnm/8RICf45r+5VqTgPncyESUtQaUk6M2+c0XLK9ZWsH+eWv1U1ye8B5ObJz+UntQda0yyAFWnOIvPG7MqhOMcS33dSnNpvlX344q0NHrhGbM/RFMtm9uWHCKwgr328v9C9XxBwcLzLwrjHroeRraxQLrNYexQaEqgu+fwiOy7ocahoRaL+z0RZmjeKfwU9kbP0PVOLcXBuQ0WIOUyvbJwsx+wmwlUb6g/m+9ypSbk0TuuHxenlgnT2aY+NIjOp3HTSBNLUctn2NqJb4aW31iXQAJdwuaS+T9ysO+ejgfKZGQx1APDQStj+Gr7svutys0JsER/+VXVLHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM8PR04MB7346.eurprd04.prod.outlook.com (2603:10a6:20b:1d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Wed, 25 Feb
 2026 21:42:02 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 21:42:02 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 25 Feb 2026 16:41:39 -0500
Subject: [PATCH v3 03/13] dmaengine: mxs-dma: Use local dev variable in
 probe()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260225-mxsdma-module-v3-3-8f798b13baa6@nxp.com>
References: <20260225-mxsdma-module-v3-0-8f798b13baa6@nxp.com>
In-Reply-To: <20260225-mxsdma-module-v3-0-8f798b13baa6@nxp.com>
To: Rob Herring <robh@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Saravana Kannan <saravanak@kernel.org>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@freescale.com>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772055708; l=2807;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=KKRaBkjT+4vIHkAC3n3uengPctoDgGgvcn3B4rAOFt0=;
 b=A32XAzgi9AOgH12sgbvjQeWdJDnEoClRDT1Ma9VjYsX1lkSvqG/QVfz45weJGoOuQE+uzsN8X
 dTKXn5Ng18jDntDW7/VkFbIKq4+WJVGfFEreSeZu/TZ5eMGbkTh3pPw
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH0PR07CA0052.namprd07.prod.outlook.com
 (2603:10b6:510:e::27) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM8PR04MB7346:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dbfebd4-2578-4788-e46f-08de74b6b5f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	ZNEi64UzQ3laFMJSnfZlSRHHGRCr4WD5XXCWFJpU5FEZutFBM0C+RdXbzMwt7MYd+65x4mlh620uiXPySxzz7CJnUF2qE0Dr/jtDm/gBIccyOVkje+jKk9pGnPVpotMSHmoZ0an6fa4p5YDnwnon0fTpjqW6laGQimJnV27rHq6b5brm0VdEhjIV1IXrMD9yLuRJDkNDLyihWeG19Wy1nDY+2hNzlAwEH+4qccbIObo8wkwwNx0pcyUyL1r9fSZ/WffWbOROXQTzrw7AgLppZwx3SFwFaJDy/hc6SzO6hWRUlYSb/mnz4tRqGDL+YbsWiTCIQKRqH3NI241YvBnHibkkjp8/ZpwxmSmsfWGpmM5obCr5Duf6qxOpDfh8U92R5i9aKY4G6AVackAF3gtbw+dWgLAoowitA3L75hLEbVs9XuSZxB1cxsYkqhEefjDqV/SKqBoV5hKbeZoORjZmawJR9s3Be/KRs4z4SySsBqLpLe2tfMHJ/pPBBJpCgdOb19NMIZqW7o1sRfXLLh4+kfgwny+40PT3rvVu+LP08GDK4qitEKErOd5X4SJreYbTOUPdwu5oWnhIdWq8t8qmCuFiHluJB7CNAqaHiHG2Od7rRjszLTVle9eGlfn8rxLyZzf6AKFxbOp0+a3f26uUVnZfg0tAM80kmS3/YCeexEWHv8u6Ef+XYHEP26tL/kjYQdJ1CCzFlCBGs3wpi10GCL1M73MQPOe98/x9VjzXlsUoRqikqBnhASlUz/iJsaMvqEhyIsBMoulWYDjQ9zr2u60ZgHMsD42ePpdcrHB9dBU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YVg3Z0pzSFpPWERoVG5vbVRXSkhCcTdUbC9yak8xVGlHSzc4V1hTdmMzeHBx?=
 =?utf-8?B?QzQ0emVHem9MM2hPYUxnWEJjc3lOd0tyV3hyS2J0ckd2aGlZdmt3c1hDRldJ?=
 =?utf-8?B?RDIrYzNtdVk1c01rdGtObG1qbEdJd2cyR1VUaVhKcTdkNEFCMG1ZRkV2dG0z?=
 =?utf-8?B?TUhabGZhMXJhUjZMQjRMZExWOVFkdm5sdkFKKzNxNHlCYUN5YnQzMUJyV21j?=
 =?utf-8?B?KzVIMy9QNHZrcGxFbDRveUV2ellDODFUOThJbUo2TXpoZGQ5ekNSa2FzNG80?=
 =?utf-8?B?cUU2YVFOa0ZSZnJrMngwTDRCZ21IU2VvaUhnbFlJMzkwQnRwQWo5NU0rQVAx?=
 =?utf-8?B?amhWaXU0dUR2Q1d1bm5ZQ3F4ZDVrN1ZpWDRLSVlyWUR6NjkxQ2d1dlhnVURh?=
 =?utf-8?B?N21WVFA3VUtsQ0JCTVNTNnRjUklkWUxTa2NNT3MrNEJGamNaOUNFMzhJRUZ2?=
 =?utf-8?B?Mzl1eHhuTTNlcjI0QStKWlBPWmN3dCtwMkxNbXN0enkvRHI1bmFEcnU3Tkx6?=
 =?utf-8?B?bitXWnNqWnNIanBvc1N6VDczVkwwMXdQUXprWkF2MWllbi9iVEJBd3B3K3Iw?=
 =?utf-8?B?VHBjNkdQaHVGTTRyM1pvSmdlaUhnQTA5RFM5bG9uQ1hoUXBnTE5BdXlMMHBQ?=
 =?utf-8?B?cGMyMzh1QU5RQWxTMklHRjk5SFdZaXl3MjNHakIvNUdPaUVvRXF0MzhNbmw3?=
 =?utf-8?B?elpVb3k2QllZWWR3TU9QcnlIUERKcFZKb25pR2d1aVp5a2VxOFM2ODZCLzVy?=
 =?utf-8?B?dmVZYlVkd3prZDZNVTF6ZnhEN1MvNm1pNktxYXR6Rkwvdkl3REJQaEhuMUhy?=
 =?utf-8?B?cXdRc1c1VGdGc0c2SlpBZFVwbHdIZTRicWNVQjFzOUdEQzBQZ0VaT1JVSlFv?=
 =?utf-8?B?S0NyZHN5cnAwNkVibVlDR0lpSlNRSUxEeWN0dmQxQjNNbnl1ZG1qK3R5Sm9E?=
 =?utf-8?B?WkRaQUNNckFOblM3Z0lEeFUxUE9wcjR0U3RZMHRYVXRpSWVwN3ZYQWF2NktE?=
 =?utf-8?B?SHpXU3YxZDMzdkFrbldEc1BjVzV1R21lY29SaHhmQmQ2N2ZlcFRNUTJHNDBs?=
 =?utf-8?B?c1pia1NwYWhUQzQ0L2dGZjJTTU45RXFzNFJuQWEzYmhhZlFZNEJVMDU1MkFv?=
 =?utf-8?B?TXpCdUxOb28xKzJVb0h4Ymd1S25ncG5VYlFxYWV1UmRhZVlHZU5RNFhsYlZu?=
 =?utf-8?B?NHZhUCt4L0RJL2M1V21XL1lBaVhzTHp0NGs1M2FtaUI0TkNRbGtZQ05SMFFo?=
 =?utf-8?B?QXVLS2xRWXhUQjNseXJYeDhhdHFKUTJCUWhxbW5BU3RZbjVUTllsMjRQODha?=
 =?utf-8?B?M3UwRW1xVEFEc0hQOHlRNDd3NCtjYTN1NFBxdFlveVJWcW5UNFJ3TnIxZjVo?=
 =?utf-8?B?dGc1ZWg3VjNpMmI4NUNFNUw3SGFnTjUzWjlQUnlOY0MzVGYveXlTNXZoMEFB?=
 =?utf-8?B?aUU2R2lCUlJ3cU9kZG1kL0JzZFU1VzgrMklvYmZST1lIMDdmMGJpYVZMYmFV?=
 =?utf-8?B?elVqeWtuekg3c3ZuZ2d2anpUa3Bnalg2RWtmd1p5cUo1OThUckdoU1Y4MFBH?=
 =?utf-8?B?OFVxRDVkWVp1b28rdGdGQitQZ3ZtRFRxUVplZnAxTEI3eG90Q2pGRHlWaTEv?=
 =?utf-8?B?aEJjdVRjVSsvOEdWWkhvUjRtaXQvdFF3VTE5V1RndlR6dm9sdzVqQldMa0Jj?=
 =?utf-8?B?L0xaa1ljOURxOUFaeis0QTdUTE1NZWpsVWhUekRIczVFQ2ZtOEYwZ2gxRk10?=
 =?utf-8?B?QnFXQnJINEg0WlJ0WDRQbkVJTHZkdzN6aHhlcmVZVWJPTE9nd3orK3lVZ2FQ?=
 =?utf-8?B?ckV0MXhpU2V4ZEUrTFpYR1FqeEc5Mll1Tk8yVWRuSEIzY1VDQ0Q2WGVtdFhS?=
 =?utf-8?B?bkFQNis2ZElLbndNVjVVamI5Vk5CbXhPM0c0UllRTTZqcjNLbktIYVFFd2Zl?=
 =?utf-8?B?UXhYVXgrdEtBSUdJaE1aVUozT0twR2RJYURFVWtRSWtjZHZLVnY4YWVQNnkw?=
 =?utf-8?B?Y204TU0yaWI1azhWWVVtWUJXTDIyanZzNWdZTTN6a2FTcENoNEdXdDZDVm93?=
 =?utf-8?B?MkR0N1pEWkEzb1MyVVBqWmFnQUo3a3VCLyt4eURWK28vR2plQmYyUGRZR0pa?=
 =?utf-8?B?VUNxZkxJR2xlTmhWbnhxVWNXK3NWVkY1THdaeHZYb1NxTUoxWEZ2bTd5RDhT?=
 =?utf-8?B?bTI0a2Q0UUtjWThqZlRuTlY5YmhudDJHTEUxWWo1a0E5eFFqZlRDQmFPV3BU?=
 =?utf-8?B?bk9VY2NGLytXNzllN0l2L00yYTlBT01BdENvb2ozd0o5UUtqWFZBTGNMNkxt?=
 =?utf-8?B?OEhVM2tHVXFQcWoyQXRxRVFhYjVzZWt6ZDVPRTNUVEdTVEVkU3d0dz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dbfebd4-2578-4788-e46f-08de74b6b5f5
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 21:42:02.0350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gUTuCdh3BkPtwryspUZDF0ZzGZaixGlekhoA2PVsVekycSWAr6/SDTVzaQH/8DCI4Sa3h36U0WYSR66KGRxBmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7346
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-9107-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,pengutronix.de,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:mid,nxp.com:dkim,nxp.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5D48919DEC9
X-Rspamd-Action: no action

Introduce a local dev variable in probe() to avoid repeated use of
&pdev->dev throughout the function.

No functional change.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/mxs-dma.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index 53f572b6b6fc62c6cb2496f0da281887f8fc3280..5340f831ae9dbf5423564e070735f5289c8d49de 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -744,20 +744,21 @@ static int mxs_dma_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	const struct mxs_dma_type *dma_type;
+	struct device *dev = &pdev->dev;
 	struct mxs_dma_engine *mxs_dma;
 	int ret, i;
 
-	mxs_dma = devm_kzalloc(&pdev->dev, sizeof(*mxs_dma), GFP_KERNEL);
+	mxs_dma = devm_kzalloc(dev, sizeof(*mxs_dma), GFP_KERNEL);
 	if (!mxs_dma)
 		return -ENOMEM;
 
 	ret = of_property_read_u32(np, "dma-channels", &mxs_dma->nr_channels);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to read dma-channels\n");
+		dev_err(dev, "failed to read dma-channels\n");
 		return ret;
 	}
 
-	dma_type = (struct mxs_dma_type *)of_device_get_match_data(&pdev->dev);
+	dma_type = (struct mxs_dma_type *)of_device_get_match_data(dev);
 	mxs_dma->type = dma_type->type;
 	mxs_dma->dev_id = dma_type->id;
 
@@ -765,7 +766,7 @@ static int mxs_dma_probe(struct platform_device *pdev)
 	if (IS_ERR(mxs_dma->base))
 		return PTR_ERR(mxs_dma->base);
 
-	mxs_dma->clk = devm_clk_get(&pdev->dev, NULL);
+	mxs_dma->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(mxs_dma->clk))
 		return PTR_ERR(mxs_dma->clk);
 
@@ -795,10 +796,10 @@ static int mxs_dma_probe(struct platform_device *pdev)
 		return ret;
 
 	mxs_dma->pdev = pdev;
-	mxs_dma->dma_device.dev = &pdev->dev;
+	mxs_dma->dma_device.dev = dev;
 
 	/* mxs_dma gets 65535 bytes maximum sg size */
-	dma_set_max_seg_size(mxs_dma->dma_device.dev, MAX_XFER_BYTES);
+	dma_set_max_seg_size(dev, MAX_XFER_BYTES);
 
 	mxs_dma->dma_device.device_alloc_chan_resources = mxs_dma_alloc_chan_resources;
 	mxs_dma->dma_device.device_free_chan_resources = mxs_dma_free_chan_resources;
@@ -816,18 +817,18 @@ static int mxs_dma_probe(struct platform_device *pdev)
 
 	ret = dmaenginem_async_device_register(&mxs_dma->dma_device);
 	if (ret) {
-		dev_err(mxs_dma->dma_device.dev, "unable to register\n");
+		dev_err(dev, "unable to register\n");
 		return ret;
 	}
 
 	ret = of_dma_controller_register(np, mxs_dma_xlate, mxs_dma);
 	if (ret) {
-		dev_err(mxs_dma->dma_device.dev,
+		dev_err(dev,
 			"failed to register controller\n");
 		return ret;
 	}
 
-	dev_info(mxs_dma->dma_device.dev, "initialized\n");
+	dev_info(dev, "initialized\n");
 
 	return 0;
 }

-- 
2.43.0


