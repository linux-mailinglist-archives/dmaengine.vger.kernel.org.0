Return-Path: <dmaengine+bounces-9113-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIB+EfZsn2mObwQAu9opvQ
	(envelope-from <dmaengine+bounces-9113-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 22:43:18 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F09CA19DF0D
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 22:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD583303B156
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 21:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905EF3176FD;
	Wed, 25 Feb 2026 21:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ROIs+MjR"
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013067.outbound.protection.outlook.com [40.107.162.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1620E318ED5;
	Wed, 25 Feb 2026 21:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772055749; cv=fail; b=FNTdi9BKkrX8GSSXL4Y9+f1l4W5IeypulRMAQmU9yQeB2Rez8XFQ6ChgGGyyPu62xMpm1Yg/d+J++trJofPli5RYVIygDPcoOADjli98zxR2IHQbvxaVpz6CwF0ztJXbkpz4zQxcqHqY9Vulg7P2OuYvBAK25YQdKO2A7NxtaNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772055749; c=relaxed/simple;
	bh=SGuYj8v9mm8IH4eLrwPATPPhGROfVawXfsHVGJsjHhk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=nU/zFQTUxZ35XdQyhRoh0rTMDzwkZ11NrheBgFslcqDJmG5gAhCmxpvBPXNLJix+pyqnNoINIdjeN2cmV/j7MEshrXrhK7r3UJ0tgKH4jYz/6hcheGn7p9eg2kQ1lVfDgoG1jFXd9eOoFPkRz7AiHE95NjHAqJ00NIehGuRVPxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ROIs+MjR; arc=fail smtp.client-ip=40.107.162.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XKRfFldpJYOFR+sc4Y1HIKeRW32c6CwowMetUrU8xqTm79wpk8J5ikn3AyyCfBAXgsWl6ATGN1uZZcqEShVEMl+BPfaKthJwEMLycUO3mEPDst6qv55bC/ge0+xRbbo+3ZAoLN1WMvsO/7hRrP2Kerv1FzPtap5aLM5V59JJ+dtvsj/EBrBkFpUmpAsSb53yaGS9yaVK9hsWtQPfjW6G9dZs5B7tAN7gCPPagrzUZWIv6JpHyZgnsSUvsRdaH0ale2195vE+VLhlwEqFYuzgL8XdCX5i5qnCPFapAx+ydFpkCITrkIwP3mB19tJJYVE9v3jG9G/2GXkeAW4HcV+vNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LjWHg+3eFg3+f+fEJK9ZbBeq6FN2GAhWPLRLdmuqDxQ=;
 b=HotGAWYs7bUdseUh28RQFg2H0cHyOfK5yctTFx0CfsRZKFW2ncl2FdOCwJgrNflHUN8sbhJOndGVz8SNP4mGMljYhxRcKRJ25ud6TYegB/S3WHYdjUHDOgVhsgYC+hLzg1TqT7yorWxmmi/4+NLnJZzwIOlncD2X1+0BsZLx0mg6InGeyCy2Li7ouwveUaJ1rJFrprbACxNIFJc/crOHuyig40liTX0eTx/crmbI5XYC46sqIrlYEWbz4Hj9kXC8AhCAUPKvLKwY1vZsrm/+di//bbH+iH1ayJOb+E8OqdMgTkE5Hko3FxRGUf2Kkt1u3NPdEeI1vpwh5Qr2IzpPgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LjWHg+3eFg3+f+fEJK9ZbBeq6FN2GAhWPLRLdmuqDxQ=;
 b=ROIs+MjRHDcZxU08jG+QM+4DNpfzjY7tbObWe9/7xNFKkF2C4qpw1k4Am+4MFWiU7KVX6lF3xcYq40Dqd9oD5S70drQBXDFW4O5jBaPnWnVqPloUdutVc9muoKMcQKbO7MfudlMvu4lNYqB7ntZNc5UL9GOEbQRLlYfIs3gjsqsXp858znNPOqQqGEW3y+kGAj+JAxB+eU89vXU+1RK6xEG8IiznB5WPrd8NOYmmAH13Zh783jan9UhNt6ny19EXs+Jg3CJf1V0GzHmtjO0x9p52iQv9KtekInhg2XaFRMOArd3dnniCUGPgzhkoxPbukKnGbg6CiyDdQrysfEk3+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM8PR04MB7346.eurprd04.prod.outlook.com (2603:10a6:20b:1d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Wed, 25 Feb
 2026 21:42:22 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 21:42:22 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 25 Feb 2026 16:41:45 -0500
Subject: [PATCH v3 09/13] dmaengine: imx-sdma: Use managed API to simplify
 code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260225-mxsdma-module-v3-9-8f798b13baa6@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772055708; l=2198;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=SGuYj8v9mm8IH4eLrwPATPPhGROfVawXfsHVGJsjHhk=;
 b=SGnpNv3T8qSCchJkgZLNjO+ZO1n97VdfXtulY4eBSYBsYMlXnAOPlRkt9bc73QmFFuOF4lgOc
 wBs8FMJRJRzCEd8MijArBQZ5J8Dnghi94F+oNM0YgO6sFhbdJBnQJBg
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
X-MS-Office365-Filtering-Correlation-Id: 1a682fc0-d5eb-4802-b723-08de74b6c225
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	tGy3Nm2J1uaOpWo6jSX4jPZB52kcLUguynB/YKGbpddNz2bdobHe4E2jkUB+8ftJLoDSZVQnb7Vxk7TuvxFt7tgABrlu4kSIB1Y1iLZnc7pUn/HajofkN9zsVKsAb6dNU+xlVIIqxCLlDM1YjGhl63KL0S0v4g9Qp1jeuNhkzHr6S00JHRkYrxTx9duxBi8qbnahs6cLoFSCjerhHYS/CAEuJGTZNKpyLLZy8qeUR8J1EbQaEmSCRL2mhU3m2QV/6juV7yYwguoj2XFlu5jO84LmykhsQJEnjcE+QLkZaO8YIPJGYsgPs/XOeSPVipBPMHbZr/uN9N/o9B/PY8htGE2XFBj825SvdmMpcSLgd70b1RyUvXWh2Ctjv+3JrlfZ0ifuSuTxV2ddv2NGcc7O7GxsQBOeum+lj99pgMJPY7CdV4/2aW8/suPZ1fewGUnqNFx7B4awTFXhmit6MHmot4UZxkwKf+ylS46DGKgcSgJwfu5W8ohuhQ8TVBgHXBeSg0I3tFiQvZ+Ly5yHsBVz2faKlwTz0dtnFqNPkFRB+NUfEaj9ufiEAFnK73Mjp3e5uLK0Kc3bTJv/Lfker+YKaHBVmK6vzMAKrfl1ZsDpWy8g+XArYzJVB/EtqwnjOasZtyriHIeNVJuNOABuoNUGuDuUc6skBdt0NPL63sW2RwJPO333ELDKHo1zuXkCT6cnhAZm3JGbZ+mF1dhjy2xTzICKDb/LJKShbX85MfYoLkFaWT56qeZ2BiiCjuNGyfxizfv5QdttsawFk4ko+fbPEzUIruB/0VuMTFsp3cFHzBM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qm9QYUV0WDR5RS9rVjNsS3RxYVB6QnpoVGZzSVFzOHFQeDhaRC8wbldJZkJ5?=
 =?utf-8?B?aU9JNUFydHB4dEYrS2FsVjg5M0kyLyt2Z3M3VDZnemgzTTdKZjJGcEdyL01v?=
 =?utf-8?B?S2s1RWpNTnhzaWdFZDdiSlExdDlDUC9LS1RuU1VuOWJlMzBqN2JKMWJkdTRz?=
 =?utf-8?B?R1pWYjlzRXF1RFZ4aENCOUVBU24zK1FzUUNpRngrVDF2d0E1S3hPT0JTcHB6?=
 =?utf-8?B?WUhGd09hL2RRZmZQZmFieFd4am1USkRJb3k1bWo0SmZ0Y0EyUXpPMmFWL0xH?=
 =?utf-8?B?TllVbHdadmhYTWFJV2FKTEZZVHVQanBlN2dPb1FBTU9BVnIwaDkzTVVGMFNt?=
 =?utf-8?B?MXo5YUdsenhuZXFQUDNDbmlsd2lCMkhKQjF0RWdpWFhkN1M1cDNlbHRYUnBJ?=
 =?utf-8?B?U2VtR2tmWmZkOGptTkIxSWI2UnorN2hUR3FnbWZFbkJqN3BaVUowOXR4R0g0?=
 =?utf-8?B?bDZnYTlMMTgyOHlqSVdKM0FTbGgwYXlQWTEwTmNabVh0V1pRWFppUGZrSmNJ?=
 =?utf-8?B?eU9YRW03M0NHazh5V3o3YXpza2twWktaY3QxbGhycGxqMmFmY0Rjd2JTTkFa?=
 =?utf-8?B?c0RjQ0JWNm8vempSbXRoVlhNRW9ndk1DQ09kQXZic0xPazc5eEJYVDA0T25m?=
 =?utf-8?B?WWEvT0xUZ2U0Ukc5YTZmQ1o2aUNrTExiSjdPakhxSGtHWmUzak5jaWNCRUow?=
 =?utf-8?B?dG45QVhJd21TRGt1QW4wSnliVVFQNE42RkdsRTRxVUE2cU1Za2xncDY2Q1Vj?=
 =?utf-8?B?eTFRZFVoclBISFJSV3hNWUVFb1cySEs3b3E4aCs4VWY5bTRwU2NDTXkrcWpB?=
 =?utf-8?B?cDUxQTRmZDROVzFac2V2a0lQVUswTTNZRHc3alVqNDRadWhZZHpSS0JINzIy?=
 =?utf-8?B?NFVOWm16THh3STZ1WEVFc0NZNHlWRHFvWCsvWUpCa1NNTVdyY25VZm4xL0pv?=
 =?utf-8?B?OVd5aDlIZHNyeUM4eVlXa0JVOUdHRS92Q1pBSDlGM1Bod3VrVUNKTG9lKzlk?=
 =?utf-8?B?QThnYUlMT0VjNnR6OHd6K3p3VTFzOStqWEN1S0xzajJJUHdLbW92bU9DVllv?=
 =?utf-8?B?K3VldlNTVUkzaUc4b2tOZ0x2djNkRmc2OE1IUlNad2hEYWhiMjM1YUcwRXAx?=
 =?utf-8?B?Q1J6N0dKTzAvQThCN2ZNSkFzbzdaaFA0OHI3b3VYSzBnRHZCOE9iNHZIb1l5?=
 =?utf-8?B?SGZzTWdNV2lpQytyd25iVk5RdVVYN0xCcDd0Q1JzTUoxNFdWUDY0VTBVQXh3?=
 =?utf-8?B?bjBLbDc4WkhVd3VpcmNWbHBYS29BUmtSUWwxNkhMeFhVWVZsRit2b09TeVU1?=
 =?utf-8?B?U29JaDJTdlpVQ1VJY1NyUzJlTDhOSnhnK2t2RFFWWWtTbEp0QTBiaXN6OHBI?=
 =?utf-8?B?anFCNGliaWIyOEwvb2NwWlAwZ3MrMWtZQk5yRnN4aHBRWlhOWUpSbC92Zjhy?=
 =?utf-8?B?L2QwdlZWajFhVG5ObFF6UkFuWTVkNVc3WURSL25qS1pPZUZwYUN1LzgzOXF0?=
 =?utf-8?B?b1BXd2VlKzk2ZnRLbTZuU2l3aWxMaDRqUG0xZllHNkUwdlAyUm43VTI4MWZQ?=
 =?utf-8?B?VGE0V0dhYTZKSkIwVDFvR1pzaEttL3JQVW92bHhqOFpxRzFxdXplZzA5N2lh?=
 =?utf-8?B?MEY0MG9DUDZjaFVDeVMybE4vZWpMN0dWYTMrelRRa1VicWNUQldObmt6Wmlz?=
 =?utf-8?B?MGphQzYvSDVlb0EzZDMzQjJYSkc0ckNZYkJ6NXNQTXZQYlpMa3BSVi9oZXNx?=
 =?utf-8?B?cVk3aGd3VVVjSEZSbnJOTmw5UytjUVRXTmRoUDRmR0FYTGxHSnZ3blFCKzNB?=
 =?utf-8?B?WTdSajZkZDF3K3hjVHZzNmp3T2plb0U2b0c0NmxqaEgvOCtYSlNjcksybFBv?=
 =?utf-8?B?QUN4MGVVRHpScFNITkpqWVRrNmg1LzZVTnJqb3Y4RjVLUFdRbFJJQWdSa1VM?=
 =?utf-8?B?MnFvb2dJeDNvUUlTSStXL1Y2alI5QitUaEV2dHdWNkFMZkV1K2FPVGNZbUda?=
 =?utf-8?B?OUE3SE9Oand1ZVJSSmY2elFwV2JFc2ZuRG5tTGpJZlZ6eTVLR2VETFBucnhN?=
 =?utf-8?B?VkxwSTFCQUJsUDhXenFmSXN2RU1NS202K1J3Qnk1R3ZvOFdPaTZVeUNHaVov?=
 =?utf-8?B?RURxbGRqeVBoejFZdUZtU2c1MndPTmlRSy9TNnJPU2M4d1pXQzJMcFhzK2NG?=
 =?utf-8?B?SHBzYUlIL2haSzg3cHJ3Q2loWk5NRlVXdW5FVXpGSUVCUmlNWWtWWDk3RDE4?=
 =?utf-8?B?UXd2d3hCODFCL3k4OWZ4NFVWL3FHTE1taTNyQUk2OVNobDdOZ29pdkpNb1RT?=
 =?utf-8?B?akUvbzBZRFdZcUErT1dlQVBzS2lSc3VnN3hDMVB6OEkyb2Z0R3VTUT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a682fc0-d5eb-4802-b723-08de74b6c225
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 21:42:22.5270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dt3b2lxRMOO9sB9P6LXGo1qRlN6yEMrYvrGfj+BfTyA6Gz7nPsfJhTddY5TGmgF/DjqmpTq0uTtRBQBuTiVzYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7346
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9113-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	SURBL_MULTI_FAIL(0.00)[nxp.com:query timed out];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,pengutronix.de,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@nxp.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:mid,nxp.com:dkim,nxp.com:email]
X-Rspamd-Queue-Id: F09CA19DF0D
X-Rspamd-Action: no action

Use managed API devm_kzalloc(), dmaenginem_async_device_register() and
devm_of_dma_controller_register() to simple code.

No functional change.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/imx-sdma.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 187e8e573fdf437a0d614548f1aa777a0ba3e24d..16b5f60bc748ad20380670da337846fdefb5fc58 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -2323,11 +2323,11 @@ static int sdma_probe(struct platform_device *pdev)
 
 	ret = sdma_init(sdma);
 	if (ret)
-		goto err_init;
+		return ret;
 
 	ret = sdma_event_remap(sdma);
 	if (ret)
-		goto err_init;
+		return ret;
 
 	if (sdma->drvdata->script_addrs)
 		sdma_add_scripts(sdma, sdma->drvdata->script_addrs);
@@ -2353,17 +2353,18 @@ static int sdma_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, sdma);
 
-	ret = dma_async_device_register(&sdma->dma_device);
+	ret = dmaenginem_async_device_register(&sdma->dma_device);
 	if (ret) {
 		dev_err(&pdev->dev, "unable to register\n");
-		goto err_init;
+		return ret;
 	}
 
 	if (np) {
-		ret = of_dma_controller_register(np, sdma_xlate, sdma);
+		ret = devm_of_dma_controller_register(&pdev->dev, np,
+						      sdma_xlate, sdma);
 		if (ret) {
 			dev_err(&pdev->dev, "failed to register controller\n");
-			goto err_register;
+			return ret;
 		}
 
 		spba_bus = of_find_compatible_node(NULL, NULL, "fsl,spba-bus");
@@ -2391,12 +2392,6 @@ static int sdma_probe(struct platform_device *pdev)
 	}
 
 	return 0;
-
-err_register:
-	dma_async_device_unregister(&sdma->dma_device);
-err_init:
-	kfree(sdma->script_addrs);
-	return ret;
 }
 
 static void sdma_remove(struct platform_device *pdev)
@@ -2405,8 +2400,6 @@ static void sdma_remove(struct platform_device *pdev)
 	int i;
 
 	devm_free_irq(&pdev->dev, sdma->irq, sdma);
-	dma_async_device_unregister(&sdma->dma_device);
-	kfree(sdma->script_addrs);
 	/* Kill the tasklet */
 	for (i = 0; i < MAX_DMA_CHANNELS; i++) {
 		struct sdma_channel *sdmac = &sdma->channel[i];

-- 
2.43.0


