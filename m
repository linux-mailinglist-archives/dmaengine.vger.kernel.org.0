Return-Path: <dmaengine+bounces-9117-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PpqLjttn2mObwQAu9opvQ
	(envelope-from <dmaengine+bounces-9117-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 22:44:27 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 563B319DF57
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 22:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F1F1630D4BD0
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 21:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E77318EDE;
	Wed, 25 Feb 2026 21:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WkuBVefZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011036.outbound.protection.outlook.com [52.101.65.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28C93176F8;
	Wed, 25 Feb 2026 21:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772055761; cv=fail; b=nQGXE2FOX8w9v/8tsQvcavOUTSLagI1fYRK3nxZ7PSBBPnCv3vrnSLW6X4y/FPjef36g6b8sbK8TJZ43L4YTFuYACUxcrHlaayP6GsJ/7L+IAmBTDJPAdbkpON0PInGx+SrQmWrFhbg/HoEvX3yohafWYjLMga0GjOuFsEKECGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772055761; c=relaxed/simple;
	bh=gY2Y7IlCtzZRw/+mVgZsxbVKsW3Vj3C5YGxgrl7lCNE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=u0RyfQPeFyZiyxDIn9A7ALdGTfjCoFYxEYUYh7eCJiaGXrBJtGV6I84L+TQzMP+3KMB6Xb5+w4KoHi9XAq/LjIcXGzOOkVmlfk4sIA8xvclS4hBhwEy0r0V4txESS0/zVk9ajygZMauLZ6yJIJrHUXeN0GaZN7bKofarHWf2+PM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WkuBVefZ; arc=fail smtp.client-ip=52.101.65.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HmUirwMCEmtbE1+aTaTAIPFhoVfltjG1oyUoZSI0Hh6SED6qv7m8rv7pc/yscHgx7Zx2n5WUJfmgUTogMmEiOtp6kGSUqcJ5VXO+hTaXCQLhHfHsptEEClRsL2E4tIetM8mZdrd0cEF0QL8eUvOGc4hDujHGUlVlrMR6N94mXXM91CoMkcshvMl6nT6E2779DySZ6lCOHfncAK9X6h7rQydRcw91MF9k0L/RjlyDZ0eHvC2Z/NJ/JuPyYfROVc9lA7xQR6XbJDlkS4gjBf0j6Gjk7rP6BMfIv/wsecImRaywtXQE/kZxR3i1D9pTKVpFMZLEdZbRNlm+vsEtx/J+Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGOFHg/hll7O/++dlfRJ6QHtxIAr58DEfZz4IdkJ1LA=;
 b=n62t34kS752cpyqo/BH3+vZZZlQVfz5E6+zHGRgI1tcSMY0iE7B3Mg031tea/X602KD7OtGfVUMsDfSKcbEujHov8eHPgtcBtkphQ3y3drzGDsPNCN+1LnnTkKzAZBX3lA9xdMZAo31WGFpeMdFfexeEfg1Yq72KxEjDPpQ2DzwW5flpUD3wlcdOTvAFCgBx5x+CCCHtz98Zh14PUlm8SjGN+l9ZWGPjQMINvT6C2SNFzkzrsu7wjNqLjPKrGbBs+tAqiSY97K2P2yBmLQP0xXngrsi85MBdSldMKPwPxG3jowlfIU3NsA1GghM72nmDmC711lWTqqSkE1me1eULXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGOFHg/hll7O/++dlfRJ6QHtxIAr58DEfZz4IdkJ1LA=;
 b=WkuBVefZQJHr9xoepRNWIAFDqvClFT29dKEeirPlN2Q/2wmi7EN/mM1bA6OemzPLoIZgePU/iIUalgsA29Yjt832fb0bOQPArVjYGXYZ/O77h/7s9pD/vaK77gpBqP3+QE+/rB9rr+veZ4SbsRAANA3xY14OUmUxtqbxKejTFlMwq4CrHpL6M15MlW7TZNbx9bnpYGLZHsDfW4s6S5Jfjg/dKs/2WegNA3LrU+9c9qp9SM54spYWYg9uvbY7vQ0pEQGNs5ZIzELQZXSOvFnBi0gLk6qr/TbwTr/nuQFBTScrol7Yi/bwWV0OR1evPG719uIa0fKq49D0+a3HCVdEXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DB8PR04MB7196.eurprd04.prod.outlook.com (2603:10a6:10:123::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Wed, 25 Feb
 2026 21:42:36 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 21:42:36 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 25 Feb 2026 16:41:49 -0500
Subject: [PATCH v3 13/13] dmaengine: fsl-qdma: Use dev_err_probe() to
 simplify code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260225-mxsdma-module-v3-13-8f798b13baa6@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772055708; l=2838;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=gY2Y7IlCtzZRw/+mVgZsxbVKsW3Vj3C5YGxgrl7lCNE=;
 b=OH8Eb5lNdlnhCVSjNWODakWr7mSTz6yTZFTYbU2/Qa73k1WIq11BNucQZLHqeyp2tdcmBDQVx
 FvZ1NdjQToCDGwt5zDexyIq5nZmb5lZNkOQiD+Jo4LTjJ/MQQZVstZr
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
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DB8PR04MB7196:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a5475c8-3528-45c4-2197-08de74b6ca31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|52116014|19092799006|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	Gtjlm0FChUXnK0QtFa33JQNieSkWsgXRKGE1SVyyNcP5lNMDMXJJjyOJzisZHvZW9pHJKreB1M0Km6MsxSFdMVTGbHQSD2kZjab1vvlG+TBjicplZDDQmwjtm5U7JvQM8vtCBXUBZD127xbVMaYv//N3WN3RhV7BYLX+nW1jBcuO5VZig7mAlJL4IrTOpCQG8UwsA6ED8NX/Zy0j1mhEzuacUe+kEFqiqKrNsgS8U4NYo+h5hxDRl47MAfoxf1ZYvm+tcqHq1Ji6GwExuWSLA0kE6nTHFkl36h/e5BHri9Lv+V3u4cWR5xb3vs/H6/UblDhDLksN8M5zFSTaoG0chxokj/5uqAllUKfuk6bS80BBXk3ZqwPrYP/AKbzHWUhwdsNIIWVTJ6LNxtqjoNG9Vaus8IKMPfzHJvSOWuJ4xX91dRimUtM+Y8xCxSPs1jDKGWKlcDQJooecvpepC4Jj9ozeRJscHrs1MPrzNiDcqFuOowiG7ozxtEv2ucj8k/c40QxMlmcCbVFdwI7SQcybZAdOOrqFRejTBaoiHorXkyR+Liff6wL8MSh8ZykF4u/fi09TxPIdQkUMiVTNeoPKTKG1Qzs1N60r9iNR4jpZRsXK/iwolZXLEwsuyjIon+UV3OXF7DSEECGWdk1oh+BfzQ5fWT1N7dla5R06XXcyJ6ey43OuN419dTHTqX/NnTjdMAXbvtJQlloTs5WEjkFfZnCc1M0H/RANs6Gge+RQlwoXUE/tVrPb4txTQj4Nd8YNn0mmhBS+7a0Q1JkQxOxuMb5GiiGCftzjBccTCAJ2axc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(19092799006)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0pJOFdWWUFwdjhJSERlYW5VS2pYQ1lvZ0xUR2tKbnJOakZwaXN4NTc5T3Jy?=
 =?utf-8?B?MWF3SWsxdmVDK09xSXVSc2pjQnBjMFJYN0ZDSWNYT1R4UCtGNEY2Y2d1N3Z0?=
 =?utf-8?B?c2wxeU9keGFJbXJKS3NxNWFMSUtBa29DSnhwS3FtUEw0ZjIyQjJvb1RNUFo1?=
 =?utf-8?B?QlBMdndpaEkyQnU3YS9TUWhZejUxN2VDbFFjbUJwODJaRFlWRUZwc3IxUTYw?=
 =?utf-8?B?bzZVaXIwQnp3eHVCMDJGT012ajhUcmN3bnRnRFRhVGliTVlDOTRnREI1ckw5?=
 =?utf-8?B?RFZ2bDc0TktCendlVXpsM0EvMlh1dUJKemhlNXVlSUp0L0JPRUVWSTdYT2pF?=
 =?utf-8?B?SmNtUCsxVjVRSUNUVkk3b0JwT0RvY1lrTEg4ZmZCNG0xdHJ6SDZjUEs0WXNQ?=
 =?utf-8?B?MzJyKzdxUGZueHdGUlo1aXZvUHdxRjBSNGNnY0NaSGJMcFE1UXcvMm1Wb2kx?=
 =?utf-8?B?M0NOWnZqalpPV2RCN1dOWDczWE4wMGRoOHdkQ0QvTXM4VVd4SHVOODk5Y3Jh?=
 =?utf-8?B?TlIvcVQ1MHJlbVROeG5nQTF6R014SjVyTklFS1djSGdFY2libS9JaWpqOWRO?=
 =?utf-8?B?aldvRDdqem15RFNvc1RMZWZBOVo3TmxSSFZJbk43Qk45eTVHOEh5aXI5L0Fw?=
 =?utf-8?B?bkRjb0lTUXFCcVZlcm9JcVRNRlgvWGNEYUkyRkI1b1UwWDBsZERCQld4a2xk?=
 =?utf-8?B?djhDc0krT254Y2FVcmdCcGdzTng3UWNDdUI3NTJTb0xKbkZhcWIwdHF5akU5?=
 =?utf-8?B?ZjAwY0R2aEJWeUxFTzlSSStHd2NPbS94L1ZPbzN1N2UwWVZtSDJRRDZBcFdy?=
 =?utf-8?B?ZVY1UEN5c2hxMGp3eVFYZTNJeVBoMmUxUVJncTVBMEhHVTJobTVLcFkwTzZp?=
 =?utf-8?B?cVRHcDZWY1l0MmZvQzNSSU5jRnV1dlFNUjFoQVNCMUlaaGtmMGE3YzFRZy93?=
 =?utf-8?B?NXR4M0xBSTVXSTU4Qy9PNFBkOFErMEd6ZjZFUjNCdlVYUmN4VGc3emNkNnR4?=
 =?utf-8?B?RWx6V1JQWEpveHdCM0xhOEtVb1JiTVJEc3d0bDRBZDZHVGhPKzVDNFg2bDBq?=
 =?utf-8?B?THpYTFhmVzh1ajRDbUFhSTNUVG1sNTRsZTdjYitQQ05Vc3FZOExHeDZxOURY?=
 =?utf-8?B?cFJOdFZTQWhVeWlqSTRYT3VwUCtGY29PVndoU3Nwb0ZBUExDUm9nejlyN1RB?=
 =?utf-8?B?emE4akZKcC9IeHkwd3VWekcyTHU4eC9ldkZtL29OSUdSRExNcEx1YjBMb1Ju?=
 =?utf-8?B?RmJrUkhySUVnOUd1WnVCdE45TDdRN3FubWNaV3BTVldiQ2lVK285U1h0WUN1?=
 =?utf-8?B?bjBLRStJa1ZzOXphd2xsWTJtQllaMldsY2piK0NXTFFDYVgwOHlDaDNvYkRJ?=
 =?utf-8?B?MkRZWC8rdkIxU0QwOHdiSDF0RmtFZzViNHA3T1ZLWGRocjdYS0ZHeStEMGE1?=
 =?utf-8?B?ZndyQjRJeis4OXlJM1JZeDRHeFl2RE1QSkNZTzBRdDlBMDU2ckpZV0tCUm1I?=
 =?utf-8?B?WFBFK2RPYmw1RWpMMDM5S0lvbGhaczQraU0vN2hWRTJrOWUwTVRWZlpOZktY?=
 =?utf-8?B?ZkxHcnpUL3UzYTh2SjUvMXpIRkZCdkpRREViT1VSUi9XV0p3LzV6azZYWGhB?=
 =?utf-8?B?UTNPQTBhcjFTMER4Ti9jWFhBNTFQY01UVjN4cEpJUXAreHdLdXU3eG1IMktF?=
 =?utf-8?B?WTNwMHpLem1yUUFCcVROYmJEU2FSWXRTYjdFUW03NFE2TUVaSmt3bElkZk5p?=
 =?utf-8?B?M3F2TERUWGV4ck4zeHJpSEdHcUVOLzE1WkxoS1dRVmV6QXlxYXNNd1VENloz?=
 =?utf-8?B?QzNyUHp5VXN1ZjQvMHR2bFpZanp2Yk9tUVhBYTBRa1p0SHFZdmF6Z1JzSy80?=
 =?utf-8?B?MWFaMUxkTWd4alFodWRqaHZDNExJMldJTlYyQWM0aUdSd2JpOVJFR1lZQ2hs?=
 =?utf-8?B?TGRoUzVQWjZFOUVHdkZEU1JlYUFpT0o1bWZFOHlWU2JTdGRiZnBUdkxXTE5x?=
 =?utf-8?B?Rys3eUdXdlhFL2RCMXRGMXFtcVRkWFZyWHRWMEhWN0h2bWFVL0lQc3dDak9a?=
 =?utf-8?B?UlFnZnU2bzRXSzZNSUdqdlR2UjlJK0RaZTRLa1hOUk5zUlY3ekRXU1hyZC9K?=
 =?utf-8?B?YU1XS1NHVGhyZ0NRWW8zR3JRQ0syS1pub1lrUHBKVGswc2FtVzgyZ29tMklJ?=
 =?utf-8?B?QVBxUHRmQXZneDYxdngzTmZJNW1EZG15aUNYcGFQcEZDMmJsdlgzQ3c4VzFG?=
 =?utf-8?B?YkhUV1ROeTROY2g4VkdJaFFNOTFiWTFNRnkxb1R4ZmEzU0dsY3c1RndIOHRJ?=
 =?utf-8?B?ZE9yN29kcjdzWVJOZ0FTdTFZU21VWWdNVkFmVkszNkJYVmxFMGhyUT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a5475c8-3528-45c4-2197-08de74b6ca31
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 21:42:36.0154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cxAMn9kLvzmWLVSOBtTQIUYmdCMjtUPy3Fns/Nk/fpRdt2yTgB1SAYkAcFqcjrzEhldlIo2RBxd+17auoYhCKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7196
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
	TAGGED_FROM(0.00)[bounces-9117-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:mid,nxp.com:dkim,nxp.com:email]
X-Rspamd-Queue-Id: 563B319DF57
X-Rspamd-Action: no action

Use dev_err_probe() to simplify code. No functional change.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-qdma.c | 47 +++++++++++++++++++----------------------------
 1 file changed, 19 insertions(+), 28 deletions(-)

diff --git a/drivers/dma/fsl-qdma.c b/drivers/dma/fsl-qdma.c
index 0bbff9df362f87ca7cfa09c668ad5996111a424f..df843fad0ece50c148b6a45d2c1c6ddb413d5c24 100644
--- a/drivers/dma/fsl-qdma.c
+++ b/drivers/dma/fsl-qdma.c
@@ -1127,22 +1127,19 @@ static int fsl_qdma_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 
 	ret = of_property_read_u32(np, "dma-channels", &chans);
-	if (ret) {
-		dev_err(&pdev->dev, "Can't get dma-channels.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Can't get dma-channels.\n");
 
 	ret = of_property_read_u32(np, "block-offset", &blk_off);
-	if (ret) {
-		dev_err(&pdev->dev, "Can't get block-offset.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Can't get block-offset.\n");
 
 	ret = of_property_read_u32(np, "block-number", &blk_num);
-	if (ret) {
-		dev_err(&pdev->dev, "Can't get block-number.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Can't get block-number.\n");
 
 	blk_num = min_t(int, blk_num, num_online_cpus());
 
@@ -1167,10 +1164,8 @@ static int fsl_qdma_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	ret = of_property_read_u32(np, "fsl,dma-queues", &queues);
-	if (ret) {
-		dev_err(&pdev->dev, "Can't get queues.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Can't get queues.\n");
 
 	fsl_qdma->desc_allocated = 0;
 	fsl_qdma->n_chans = chans;
@@ -1231,28 +1226,24 @@ static int fsl_qdma_probe(struct platform_device *pdev)
 	fsl_qdma->dma_dev.device_terminate_all = fsl_qdma_terminate_all;
 
 	ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(40));
-	if (ret) {
-		dev_err(&pdev->dev, "dma_set_mask failure.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "dma_set_mask failure.\n");
 
 	platform_set_drvdata(pdev, fsl_qdma);
 
 	ret = fsl_qdma_reg_init(fsl_qdma);
-	if (ret) {
-		dev_err(&pdev->dev, "Can't Initialize the qDMA engine.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Can't Initialize the qDMA engine.\n");
 
 	ret = fsl_qdma_irq_init(pdev, fsl_qdma);
 	if (ret)
 		return ret;
 
 	ret = dma_async_device_register(&fsl_qdma->dma_dev);
-	if (ret) {
-		dev_err(&pdev->dev, "Can't register NXP Layerscape qDMA engine.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Can't register NXP Layerscape qDMA engine.\n");
 
 	return 0;
 }

-- 
2.43.0


