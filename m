Return-Path: <dmaengine+bounces-11919-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ia+iIfrdRGpt2QoAu9opvQ
	(envelope-from <dmaengine+bounces-11919-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 01 Jul 2026 11:29:30 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8AD6EB9A8
	for <lists+dmaengine@lfdr.de>; Wed, 01 Jul 2026 11:29:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=WfkWDHOS;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11919-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11919-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B05C830B79F1
	for <lists+dmaengine@lfdr.de>; Wed,  1 Jul 2026 09:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088113F39CC;
	Wed,  1 Jul 2026 09:26:46 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013051.outbound.protection.outlook.com [52.101.72.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80E53F0A9E;
	Wed,  1 Jul 2026 09:26:43 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782898005; cv=fail; b=B0Lyo+sX3NmSzq9cqN6DnxySTk6LtguqF3MHob6squcl+09KsRszx5s9VCLt+GVH6v3rkmtwwB1viJ0NhSyMrzoLABRt/IpMPfKAXElo1JmIaq8H2e732u7HpfNVc3XHkefZAD5ubYuXt/htJxVtGVYUeyCEW0jgGCzEptKLNsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782898005; c=relaxed/simple;
	bh=X9NKd3gcq7WUbZlGghw0trCFV2nSg6ZX2yRvQj4e/tM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=QZrySnoypXiaVQ5QjKMHBpc+pKm6a8QQXokZCu3QK2NBLBT6KJCQI4LOZqASKEpd+Jo8SeFPXf3RhdkcEzI4+gWPXrEa1g60DNxydXHwqbXOpt3au0nZ9zMo9VW/VFlpN8N4Zjp4bsOAMGhM+zXfrNjgRD8BcKR6ab/ExnncVH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=WfkWDHOS; arc=fail smtp.client-ip=52.101.72.51
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q5hmq9D1kQLxnCcT1NhSPhB1CU9u31TfWag061hMnsXrctbqGm0jczDUC8LvDOpM6jQuwvYZwHqggTbRKQNaVMTVyC/3IZiDlz/XVCPjx4uu7nxA+yhkUAbn3Y/5HstyM957n6JB07YYqCQPOicNNCli8BW783mOxYZImDkA/k5XwpxVe/pFtuk+XToXT3fehw06qeN5m75Li8n2Hcn88z9v2WeLVv7QF8mhhMEgNMvHKwf6eLHRlar4Seec+VgrJapfxKfI90eT2SeCmzgAKx7yQ1A6AA4HhaUkOrsrNkYatTiA8m5g48Ls1cJPPVnB0Su9jKgL8Pkdqn+eSIGdpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bJeIn26TDjufvlwaNAsulcS6RTfHD2DzG6V8mfEqT6A=;
 b=tzDMghUx+jV/fm310kw8lTrDPQ75/m0jgT81ny4azl44Lo3CELMl/Dj54nRejSvS3MozlZHmtY70n0aD7JSwXh6dTtdlbFV/VecPWTp5Ql1vLaoKlUrmBtHKR80a23131aIcnq6nIm5uI5t8ZRTfJ0gkKDUpJxBb9rEv+w1IBKEvSLvx6Rochef5hpTnA2Kj48ZOTfkuV7hs5Mwiib22w3E7iBgSQOygavt4SCOQNqqK+IzVaxmTuvtLuMPo1bFvOu2jGObX586GVD1IPncBwLW8Ix5PBHq/c6sU3hGYuF3le+1r4GL0Ebv60/3Z5kZd1P8dcgpVaDuWCwG5MPh+Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJeIn26TDjufvlwaNAsulcS6RTfHD2DzG6V8mfEqT6A=;
 b=WfkWDHOSN1aWXexz6hVHWJ55N9OriEuXIzLNPozg4CiBU/zLpFJGXz4/fJ42uDfuPMpnjiTgD3kVQXWv/Huwkz1GyBCum/Sxcr5mB0Y2kxk36YXrva1+SZNa/7I9iu3qMUWjKSvTngwagnSq6R/4WwlWOMqTdmZeRViUaMlPHFy7xL6nUmVYzExMw2nt4ySq0v4uQd5UBDaBGTrxP0PsOgqYhPSbKDJkHd0YbxgbtCAt88LvqDoq4HzWmtITqWYj2i4ueDBpMDeJhmg0CEip/lk0gXaL05KhYuL6PsRF1yCKnYHd5F/gjtU8rO0ImpZEQtI0q+EHya2brmGod9uLvQ==
Received: from VI1PR04MB5807.eurprd04.prod.outlook.com (2603:10a6:803:ec::21)
 by PAXPR04MB8271.eurprd04.prod.outlook.com (2603:10a6:102:1ca::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 09:26:40 +0000
Received: from VI1PR04MB5807.eurprd04.prod.outlook.com
 ([fe80::3da4:2827:d637:37de]) by VI1PR04MB5807.eurprd04.prod.outlook.com
 ([fe80::3da4:2827:d637:37de%4]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 09:26:40 +0000
From: joy.zou@oss.nxp.com
Date: Wed, 01 Jul 2026 17:29:26 +0800
Subject: [PATCH v6 4/5] dmaengine: fsl-edma: add runtime suspend/resume
 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-b4-edma-runtime-opt-v6-4-354ff4229c00@oss.nxp.com>
References: <20260701-b4-edma-runtime-opt-v6-0-354ff4229c00@oss.nxp.com>
In-Reply-To: <20260701-b4-edma-runtime-opt-v6-0-354ff4229c00@oss.nxp.com>
To: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>, 
 Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Cc: Joy Zou <joy.zou@oss.nxp.com>, Frank Li <Frank.Li@kernel.org>, 
 imx@lists.linux.dev, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Joy Zou <joy.zou@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SG2PR04CA0211.apcprd04.prod.outlook.com
 (2603:1096:4:187::19) To VI1PR04MB5807.eurprd04.prod.outlook.com
 (2603:10a6:803:ec::21)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5807:EE_|PAXPR04MB8271:EE_
X-MS-Office365-Filtering-Correlation-Id: 69b6794b-18a2-45d1-10a8-08ded752db99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|19092799006|11063799006|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	k5YSJRsdbOvc7Jf5fUifkgVqPqR6nAJlBArhoTDesG9I/t3bnDnlqMFO+/3XMKB+1F/52GB1+FvTqfxNdvkRqEfRGhDShFtNEtcGtMYGs4DDMOm6cR3OyWdhJdn2nMA8cAVgaui6ZDOMEbc2td476sj4ZppmNPI7b68voDZl2hjuczNG7p53P2UAVm78p8Qv1K5YlpxVm7Szdn+/BmIysm3h+86AhzcZstiKVaJvGLwq4pRDpVYbKMLFwNKON52umjBc254F4Njn9UEUZW3q5mgT6Px3xwFEmUdYhZRilSg1uCJZKb8PIqYe//QY6HwGUe00LCoSM4RFxfp7lLGXajt6gt1DZcPU06G/n3ofiEWYgcBYUReq/A1TdRHp3IrJ6gn03BKin44NZpFAUyZ8A4Rh48x5eKNYltmrY/uIsP4c8vf8H9Gxf9QhbWWTqCB8cYFwnDF6rJTDMfx/80h6PE5z5ZlwsPtLJMQVoICujJOb6XhL1gNLtxGa2/ywO30RQY88Worv1UXcXENgsWEgp0vUP0oAUJAMJljv0wKdSdCXy0JGfIvy0s2efLg3e2G52BOtGiZlU9x4Ef3KSC8jcsAcvcqrpSgxRCPYlFJm/BinP5zFGAAFSckj4dGAwSeqXQKRzRORIbTRA413vHSgz5WJRvan/YrMV4NfNArcfOc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5807.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(19092799006)(11063799006)(6133799003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YTNHWHphZGNicm1NMDlJeThNTXRiSDk1eDRjTjRZYXl2MDhuc0tYdTRlcXIy?=
 =?utf-8?B?T3c3SVFxMlBUSTVNYmpJVzhNVEJqbmpVVnROWVpySktkb3IzU01CeVJYZTR3?=
 =?utf-8?B?TEZmb3ZpLzRwSER5RFBsUDArN1ZsS05qYlJXSHp0L1NCWVBjOWo4WTN6T3Bq?=
 =?utf-8?B?UmFvMFB2aFc3Y2drUnlZLzFQcFBJOUE5RFliV0F0N0NhTFF0T0lJdENhYXdH?=
 =?utf-8?B?U1NIaUR5OWNGTGc1aVc3OVFnVWVhaEZGUnVZSWMzRVhnVlZQZXZMNk9tbGhR?=
 =?utf-8?B?aTloWlV5N01JdHNDSTRQT3B0ZVRNNC9VTVdEeXdKcVpyUmNLOVpRcWcyN0xo?=
 =?utf-8?B?cWVWWU5EZVpSb0NiUDJXSCs5L3FHY1NoNFU3U0EwSlJFdVBVWmZUM0E3M0Zv?=
 =?utf-8?B?YWJiUmpuMEFnSmpRemUvNE5kVmxQY2pmVWQ0cnV1bjdNZXR4L1UvWm9xY1Bv?=
 =?utf-8?B?WW5SSkRqU1dOc0x1dzRxS1d1a0hFTDNJSUZTd0ZzOUpMSHZLbi9tZzVyYXJU?=
 =?utf-8?B?a0FPRVFSR0s2dzNsbGVBakJITG8zUTlKbFV6cGZYUEtDUU9PL2JhUmo3SXN6?=
 =?utf-8?B?UWlpZEFmc3NsNWdESFZzMzJMd0dOTXoyRExSS0NzNFV2SXJmOEhVbUFvODll?=
 =?utf-8?B?amtFUDdTYm1ETmd0ck5hMjdlTGt2ZENkU1NRZDQ0QW9ZRTR2cUdkdVZmQ3Bo?=
 =?utf-8?B?RDFOdVRSUXhiTTlPaFJROUp5QURSMHZYdlpNSHJXMUxvRUZWMWR1RUxJbXRl?=
 =?utf-8?B?aEFKQW10QlBSRDBPQncvZUhvdERYZ2d0cnpWOFZWdENKdlJ0OHphTFNuMlNY?=
 =?utf-8?B?b2ZWMzRmNUZYbFZYT3BOTjZVNHJJSlZuM2J0bFBQdzJqU0Uzck9KQ3dPeEdq?=
 =?utf-8?B?L3A2aStLVUdWdmJ5cTVvOU1IZi9SaXJOS2pRUm02MGUyUEV4b0twVFFPaWpX?=
 =?utf-8?B?LzhGYmxyMVpLZTUraE9vREZQV0trWThWYnp5OVRLQjBsbEk0QTJOdHNYakt3?=
 =?utf-8?B?QnNiZy94Ynp6NmhzSGN4RHZoZUJIbVNaN05RaFl3d0tLeWJ4OUpxMDVMQjNC?=
 =?utf-8?B?WWphdTFPUkRTRVhrdFJvajNJMG81VmlwSlNHby9HWUlRUmthaFhIVEc0WSta?=
 =?utf-8?B?dFZPNUVzeDFOSE9LRmRuOElLRkY5RGYvWFJCck5yUEswbzRIVWhRTlUzUG9u?=
 =?utf-8?B?ZE9JTXUzQUJqZ2w0RFFyS2FXYzBOKzAva29EZ25tY2pCaERrSmFyRU1paURq?=
 =?utf-8?B?MXVrTmYrT3FmWklNd3R0RnZMK2pVM3ZOcnpJSnJlQ3RDRVZyT0M3eTlrVVNp?=
 =?utf-8?B?YU1VcDdZWjR5Z2IxMGpXVEJqOHM0WXg4TUFVS2NaNDVEYUc4RXdWd0h4SXZ0?=
 =?utf-8?B?Ni90cGhESTAxSkNqQ0Ixc2hZSGhMYitlRy93R0FQZitJQjJaNHBqNWw1U1FK?=
 =?utf-8?B?RjRCcTBiSkI3eVE3MG1nSXN0S051bDNybElzOSthMGRVWFBSMFV1aVBJWTZM?=
 =?utf-8?B?Y3lzUGlvNEliU1pFbnhUTG04cjJnTlhLeDhLclY4L1ZqeDR4MWFMVk9NVngz?=
 =?utf-8?B?OHN0MGs1Y1pHVkpRYTNza3FMOGFQdTZad0oxOVdIRU1VY05QMnJVSTlCRkVa?=
 =?utf-8?B?Y3ROck1RNEdCbTJkeHptY2tXR1E0bVZBS0t6cDlGNHBlSGp3Y0MzbFpaOW5H?=
 =?utf-8?B?V1Q2MjZYMklocjRVZE5jSUh0MVRhNkhQUmN2TnpUc3NyS3NUbElaQjMyYldV?=
 =?utf-8?B?ZThJVXI4czVWaDZQLzdIemR6dWpmbHJZbENadjlMSlhLbUc5dHlXVWdDSXZE?=
 =?utf-8?B?MGNTRDRRdWU1S2xQRDF2Skl5bWJOeEQwSWQwNWVPNStJcFJucVhsWTNMU29v?=
 =?utf-8?B?bytGdHVHM3BYYVROc0FKKzdORTQ5TC8xU0VZRkttSmIyc1JmS2ZCdHB2UFNG?=
 =?utf-8?B?S2hTWmNkbEJuK1BLOWhZWGhkNER2OTRxKzZDM2I4ZFN0TUhXazNDVlhLazFC?=
 =?utf-8?B?eWVBbmZRVHJJNUJRdGZuaEk2MFE4TzZoMGpvUU5WZG5CSjlJeFlSVTc5MnNY?=
 =?utf-8?B?b05MVDNiS2hJcVN3UlFmZHZsNHZManFDZ3Q1VVd4MnZET1RWQUM0L2xTR1Z3?=
 =?utf-8?B?Q1YrRGE0WUtmZjFHUmcyclUvdHBKU0QxSEVFRHNtZjV1QkZXR2VXVzJsRVRn?=
 =?utf-8?B?cmp4Q0prQU1RMXQvV3FlWEIrRWRKbXIzYW9kUTlTR0xKSFI4N0UrdnpMSGtJ?=
 =?utf-8?B?K2R5bVZUMVYrTDY4VVF0VVZ5NlVsV0liZmZ3U2xCdno4SmZPUEdGNXVyYWwz?=
 =?utf-8?B?ek5JcElRV0RHYkpRZmF5YmQ3TmF1NnJGUkNZOFFWdFAvYnNrYU1laC9rd0lq?=
 =?utf-8?Q?nDnp9JXRQ/mkzSpnRq6tRfKmpQkjtmYnSQPij?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69b6794b-18a2-45d1-10a8-08ded752db99
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5807.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 09:26:40.6738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XZRluzEzl7Sq3GoleAStJ3J8bAv9ExaWZEN76LzYI9g7HH+FPNBN9EFjFEaDO82IehwSsx5MBiQJBHYGOgSjCIqofuqs/9jcn4RpfGLZoHthH9SJFBlnwh+0Aj9dHfr6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8271
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11919-lists,dmaengine=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[joy.zou@oss.nxp.com,dmaengine@vger.kernel.org];
	FORGED_SENDER(0.00)[joy.zou@oss.nxp.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:Frank.Li@nxp.com,m:vkoul@kernel.org,m:joe@pf.is.s.u-tokyo.ac.jp,m:joy.zou@oss.nxp.com,m:Frank.Li@kernel.org,m:imx@lists.linux.dev,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:joy.zou@nxp.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nxp.com:email,oss.nxp.com:mid,oss.nxp.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CE8AD6EB9A8

From: Joy Zou <joy.zou@nxp.com>

Introduce runtime suspend and resume support for FSL eDMA. Enable
per-channel power domain management to facilitate runtime suspend and
resume operations.

Implement runtime suspend and resume functions for the eDMA engine and
individual channels.

Link per-channel power domain device to eDMA per-channel device instead of
eDMA engine device. So Power Manage framework manage power state of linked
domain device when per-channel device request runtime resume/suspend.

Trigger the eDMA engine's runtime suspend when all channels are suspended,
disabling all common clocks through the runtime PM framework.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
Changes in V6:
- add synchronize_irq() before disabling the channel clock in fsl_edma_chan_runtime_suspend()
  per AI review comments.
- add pm_runtime_get_if_active() in interrupt handlers to ensure registers can be accessed
  correctly per AI review comments.
- remove manual fsl_edma3_detach_pd() call when device_link_add() fails. The devres
  framework will handle cleanup automatically on probe failure.
- clear fsl_chan->pd_dev_link after freeing the device link to prevent potential
  use-after-free issues.
- move fsl_edma->drvdata->setup_irq() atfer edma engine pm_runtime_resume_and_get().
- Link to v5: https://lore.kernel.org/imx/20260513-b4-b4-edma-runtime-opt-v5-0-1e595bfb8423@nxp.com/

Changes in V5:
- remove unnecessary flags FSL_EDMA_DRV_HAS_CHCLK and FSL_EDMA_DRV_HAS_DMACLK.
- remove redundant clk_disable_unprepare() due to the pm_runtime_put_sync_suspend() added.
- use devm_pm_runtime_enable() to replace pm_runtime_enable() and add return value check.
- add return value check for pm_runtime_get_sync();
- replace pm_runtime_get_sync() with pm_runtime_resume_and_get().
- replace DMAMUX clock handling with bulk clock API for edma engine runtime suspend/resume.
- remove dev_pm_domain_detach() when device_link_add() fail because the fsl_edma3_detach_pd()
  also call dev_pm_domain_detach().
- remove device_link_add() DL_FLAG_RPM_ACTIVE flag and pm_runtime_put_sync_suspend().
- add clk_bulk_disable_unprepare() for clk_prepare_enable() fail in fsl_edma_runtime_resume().
- remove the extra space before RUNTIME_PM_OPS.
- add skip channel comments for system suspend.
- add clk_disable_unprepare() for dmaclk at the end of probe function.
- add clk_bulk_disable_unprepare() for muxclk at the end of probe function.
- Link to v4: https://lore.kernel.org/imx/20251017-b4-edma-runtime-v4-1-87c64dd30229@nxp.com/

Changes for V4:
- fix a typo dmaegnine/dmaengine in the subject.
- Link to v3: https://lore.kernel.org/imx/20250912-b4-edma-runtime-v3-1-be22f7161745@nxp.com/

Changes for V3:
- rebased onto commit 8f21d9da4670 ("Add linux-next specific files for 20250911")
  to align with latest changes.
- Remove pm_runtime_dont_use_autosuspend() from fsl_edma3_detach_pd().
  because the autosuspend is not used.
- Move some edma channel registers initialization after the chan_dev
  pm_runtime_enable().
- Add clk_prepare_enable() return check in fsl_edma_runtime_resume.
- Add flag FSL_EDMA_DRV_HAS_DMACLK check in fsl_edma_runtime_resume/suspend().
- Link to v2: https://lore.kernel.org/imx/20241226052643.1951886-1-joy.zou@nxp.com/

Changes for V2:
- drop ret from fsl_edma_chan_runtime_suspend().
- drop ret from fsl_edma_chan_runtime_resume() and return clk_prepare_enable().
- add review tag
- Link to v1: https://lore.kernel.org/imx/20241220021109.2102294-1-joy.zou@nxp.com/
---
 drivers/dma/fsl-edma-common.c |  14 +--
 drivers/dma/fsl-edma-main.c   | 246 ++++++++++++++++++++++++++++++++----------
 2 files changed, 199 insertions(+), 61 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index e1ca25ff228d..132b900ee607 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -247,9 +247,6 @@ int fsl_edma_terminate_all(struct dma_chan *chan)
 	spin_unlock_irqrestore(&fsl_chan->vchan.lock, flags);
 	vchan_dma_desc_free_list(&fsl_chan->vchan, &head);
 
-	if (fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_HAS_PD)
-		pm_runtime_allow(fsl_chan->pd_dev);
-
 	return 0;
 }
 
@@ -844,7 +841,12 @@ int fsl_edma_alloc_chan_resources(struct dma_chan *chan)
 	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
 	int ret = 0;
 
-	clk_prepare_enable(fsl_chan->clk);
+	ret = pm_runtime_resume_and_get(&fsl_chan->vchan.chan.dev->device);
+	if (ret < 0) {
+		dev_err(&fsl_chan->vchan.chan.dev->device, "Failed to resume device: %d\n", ret);
+		return ret;
+	}
+
 	fsl_chan->tcd_pool = dma_pool_create("tcd_pool", chan->device->dev,
 				fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_TCD64 ?
 				sizeof(struct fsl_edma_hw_tcd64) : sizeof(struct fsl_edma_hw_tcd),
@@ -871,7 +873,7 @@ int fsl_edma_alloc_chan_resources(struct dma_chan *chan)
 		free_irq(fsl_chan->txirq, fsl_chan);
 err_txirq:
 	dma_pool_destroy(fsl_chan->tcd_pool);
-	clk_disable_unprepare(fsl_chan->clk);
+	pm_runtime_put_sync_suspend(&fsl_chan->vchan.chan.dev->device);
 
 	return ret;
 }
@@ -903,7 +905,7 @@ void fsl_edma_free_chan_resources(struct dma_chan *chan)
 	fsl_chan->is_sw = false;
 	fsl_chan->srcid = 0;
 	fsl_chan->is_remote = false;
-	clk_disable_unprepare(fsl_chan->clk);
+	pm_runtime_put_sync_suspend(&fsl_chan->vchan.chan.dev->device);
 }
 
 void fsl_edma_cleanup_vchan(struct dma_device *dmadev)
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index fe02b68d75fd..3518dfb4292d 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -37,15 +37,27 @@ static irqreturn_t fsl_edma_tx_handler(int irq, void *dev_id)
 	unsigned int intr, ch;
 	struct edma_regs *regs = &fsl_edma->regs;
 
+	if (pm_runtime_get_if_active(fsl_edma->dma_dev.dev) <= 0)
+		return IRQ_NONE;
+
 	intr = edma_readl(fsl_edma, regs->intl);
-	if (!intr)
+	if (!intr) {
+		pm_runtime_put(fsl_edma->dma_dev.dev);
 		return IRQ_NONE;
+	}
 
+	pm_runtime_put(fsl_edma->dma_dev.dev);
 	for (ch = 0; ch < fsl_edma->n_chans; ch++) {
+		struct fsl_edma_chan *fsl_chan = &fsl_edma->chans[ch];
+
+		if (pm_runtime_get_if_active(&fsl_chan->vchan.chan.dev->device) <= 0)
+			continue;
+
 		if (intr & (0x1 << ch)) {
 			edma_writeb(fsl_edma, EDMA_CINT_CINT(ch), regs->cint);
 			fsl_edma_tx_chan_handler(&fsl_edma->chans[ch]);
 		}
+		pm_runtime_put(&fsl_chan->vchan.chan.dev->device);
 	}
 	return IRQ_HANDLED;
 }
@@ -132,13 +144,18 @@ static irqreturn_t fsl_edma3_tx_handler(int irq, void *dev_id)
 	struct fsl_edma_chan *fsl_chan = dev_id;
 	unsigned int intr;
 
-	intr = edma_readl_chreg(fsl_chan, ch_int);
-	if (!intr)
+	if (pm_runtime_get_if_active(&fsl_chan->vchan.chan.dev->device) <= 0)
 		return IRQ_NONE;
 
+	intr = edma_readl_chreg(fsl_chan, ch_int);
+	if (!intr) {
+		pm_runtime_put(&fsl_chan->vchan.chan.dev->device);
+		return IRQ_NONE;
+	}
 	edma_writel_chreg(fsl_chan, 1, ch_int);
 
 	fsl_edma_tx_chan_handler(fsl_chan);
+	pm_runtime_put(&fsl_chan->vchan.chan.dev->device);
 
 	return IRQ_HANDLED;
 }
@@ -185,20 +202,32 @@ static irqreturn_t fsl_edma3_or_err_handler(int irq, void *dev_id)
 	unsigned int err, ch, ch_es;
 	struct fsl_edma_chan *chan;
 
+	if (pm_runtime_get_if_active(fsl_edma->dma_dev.dev) <= 0)
+		return IRQ_NONE;
+
 	err = edma_readl(fsl_edma, regs->es);
-	if (!(err & EDMA_V3_MP_ES_VLD))
+	if (!(err & EDMA_V3_MP_ES_VLD)) {
+		pm_runtime_put(fsl_edma->dma_dev.dev);
 		return IRQ_NONE;
+	}
 
+	pm_runtime_put(fsl_edma->dma_dev.dev);
 	for (ch = 0; ch < fsl_edma->n_chans; ch++) {
 		chan = &fsl_edma->chans[ch];
 
+		if (pm_runtime_get_if_active(&chan->vchan.chan.dev->device) <= 0)
+			continue;
+
 		ch_es = edma_readl_chreg(chan, ch_es);
-		if (!(ch_es & EDMA_V3_CH_ES_ERR))
+		if (!(ch_es & EDMA_V3_CH_ES_ERR)) {
+			pm_runtime_put(&chan->vchan.chan.dev->device);
 			continue;
+		}
 
 		edma_writel_chreg(chan, EDMA_V3_CH_ES_ERR, ch_es);
 		fsl_edma_disable_request(chan);
 		fsl_edma->chans[ch].status = DMA_ERROR;
+		pm_runtime_put(&chan->vchan.chan.dev->device);
 	}
 
 	return IRQ_HANDLED;
@@ -210,16 +239,28 @@ static irqreturn_t fsl_edma_err_handler(int irq, void *dev_id)
 	unsigned int err, ch;
 	struct edma_regs *regs = &fsl_edma->regs;
 
+	if (pm_runtime_get_if_active(fsl_edma->dma_dev.dev) <= 0)
+		return IRQ_NONE;
+
 	err = edma_readl(fsl_edma, regs->errl);
-	if (!err)
+	if (!err) {
+		pm_runtime_put(fsl_edma->dma_dev.dev);
 		return IRQ_NONE;
+	}
 
+	pm_runtime_put(fsl_edma->dma_dev.dev);
 	for (ch = 0; ch < fsl_edma->n_chans; ch++) {
+		struct fsl_edma_chan *fsl_chan = &fsl_edma->chans[ch];
+
+		if (pm_runtime_get_if_active(&fsl_chan->vchan.chan.dev->device) <= 0)
+			continue;
+
 		if (err & (0x1 << ch)) {
 			fsl_edma_disable_request(&fsl_edma->chans[ch]);
 			edma_writeb(fsl_edma, EDMA_CERR_CERR(ch), regs->cerr);
 			fsl_edma_err_chan_handler(&fsl_edma->chans[ch]);
 		}
+		pm_runtime_put(&fsl_chan->vchan.chan.dev->device);
 	}
 	return IRQ_HANDLED;
 }
@@ -526,13 +567,6 @@ static void fsl_edma_irq_exit(
 	}
 }
 
-static void fsl_edma_disable_muxclk(void *data)
-{
-	struct fsl_edma_engine *fsl_edma = data;
-
-	clk_bulk_disable_unprepare(fsl_edma->drvdata->dmamuxs, fsl_edma->muxclk);
-}
-
 static struct fsl_edma_drvdata vf610_data = {
 	.dmamuxs = DMAMUX_NR,
 	.flags = FSL_EDMA_DRV_WRAP_IO,
@@ -632,11 +666,12 @@ static void fsl_edma3_detach_pd(struct fsl_edma_engine *fsl_edma)
 		if (fsl_edma->chan_masked & BIT(i))
 			continue;
 		fsl_chan = &fsl_edma->chans[i];
-		if (fsl_chan->pd_dev_link)
+		if (fsl_chan->pd_dev_link) {
 			device_link_del(fsl_chan->pd_dev_link);
+			fsl_chan->pd_dev_link = NULL;
+		}
 		if (fsl_chan->pd_dev) {
 			dev_pm_domain_detach(fsl_chan->pd_dev, false);
-			pm_runtime_dont_use_autosuspend(fsl_chan->pd_dev);
 			pm_runtime_set_suspended(fsl_chan->pd_dev);
 		}
 	}
@@ -667,23 +702,8 @@ static int fsl_edma3_attach_pd(struct platform_device *pdev, struct fsl_edma_eng
 			dev_err(dev, "Failed attach pd %d\n", i);
 			goto detach;
 		}
-
-		fsl_chan->pd_dev_link = device_link_add(dev, pd_chan, DL_FLAG_STATELESS |
-					     DL_FLAG_PM_RUNTIME |
-					     DL_FLAG_RPM_ACTIVE);
-		if (!fsl_chan->pd_dev_link) {
-			dev_err(dev, "Failed to add device_link to %d\n", i);
-			dev_pm_domain_detach(pd_chan, false);
-			goto detach;
-		}
-
 		fsl_chan->pd_dev = pd_chan;
-
-		pm_runtime_use_autosuspend(fsl_chan->pd_dev);
-		pm_runtime_set_autosuspend_delay(fsl_chan->pd_dev, 200);
-		pm_runtime_set_active(fsl_chan->pd_dev);
 	}
-
 	return 0;
 
 detach:
@@ -691,6 +711,36 @@ static int fsl_edma3_attach_pd(struct platform_device *pdev, struct fsl_edma_eng
 	return -EINVAL;
 }
 
+/* Per channel dma power domain */
+static int fsl_edma_chan_runtime_suspend(struct device *dev)
+{
+	struct fsl_edma_chan *fsl_chan = dev_get_drvdata(dev);
+	struct fsl_edma_engine *fsl_edma = fsl_chan->edma;
+
+	if (fsl_edma->txirq)
+		synchronize_irq(fsl_edma->txirq);
+
+	if (fsl_edma->errirq)
+		synchronize_irq(fsl_edma->errirq);
+
+	clk_disable_unprepare(fsl_chan->clk);
+
+	return 0;
+}
+
+static int fsl_edma_chan_runtime_resume(struct device *dev)
+{
+	struct fsl_edma_chan *fsl_chan = dev_get_drvdata(dev);
+
+	return clk_prepare_enable(fsl_chan->clk);
+}
+
+static struct dev_pm_domain fsl_edma_chan_pm_domain = {
+	.ops = {
+	       RUNTIME_PM_OPS(fsl_edma_chan_runtime_suspend, fsl_edma_chan_runtime_resume, NULL)
+	}
+};
+
 static int fsl_edma_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -738,10 +788,6 @@ static int fsl_edma_probe(struct platform_device *pdev)
 				     PTR_ERR(fsl_edma->dmaclk),
 				     "Failed to get/enable DMA clock.\n");
 
-	ret = devm_clk_prepare_enable(&pdev->dev, fsl_edma->dmaclk);
-	if (ret)
-		return dev_err_probe(&pdev->dev, ret, "Failed to enable clock\n");
-
 	ret = of_property_read_variable_u32_array(np, "dma-channel-mask", chan_mask, 1, 2);
 
 	if (ret > 0) {
@@ -772,15 +818,6 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		if (ret)
 			return dev_err_probe(&pdev->dev, ret,
 					     "Failed to get DMAMUX block clock.\n");
-
-		ret = clk_bulk_prepare_enable(fsl_edma->drvdata->dmamuxs, fsl_edma->muxclk);
-		if (ret)
-			return dev_err_probe(&pdev->dev, ret,
-					     "Failed to enable DMAMUX block clock.\n");
-
-		ret = devm_add_action_or_reset(&pdev->dev, fsl_edma_disable_muxclk, fsl_edma);
-		if (ret)
-			return dev_err_probe(&pdev->dev, ret, "Failed to add cleanup action.\n");
 	}
 
 	fsl_edma->big_endian = of_property_read_bool(np, "big-endian");
@@ -826,21 +863,10 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		fsl_chan->clk = devm_clk_get_optional(&pdev->dev, (const char *)clk_name);
 		if (IS_ERR(fsl_chan->clk))
 			return PTR_ERR(fsl_chan->clk);
-		ret = devm_clk_prepare_enable(&pdev->dev, fsl_chan->clk);
-		if (ret)
-			return dev_err_probe(&pdev->dev, ret, "Failed to enable clock\n");
 		fsl_chan->pdev = pdev;
 		vchan_init(&fsl_chan->vchan, &fsl_edma->dma_dev);
-
-		edma_write_tcdreg(fsl_chan, cpu_to_le32(0), csr);
-		fsl_edma_chan_mux(fsl_chan, 0, false);
-		clk_disable_unprepare(fsl_chan->clk);
 	}
 
-	ret = fsl_edma->drvdata->setup_irq(pdev, fsl_edma);
-	if (ret)
-		return ret;
-
 	dma_cap_set(DMA_PRIVATE, fsl_edma->dma_dev.cap_mask);
 	dma_cap_set(DMA_SLAVE, fsl_edma->dma_dev.cap_mask);
 	dma_cap_set(DMA_CYCLIC, fsl_edma->dma_dev.cap_mask);
@@ -891,6 +917,64 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, ret,
 				     "Can't register Freescale eDMA engine.\n");
 
+	ret = devm_pm_runtime_enable(&pdev->dev);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Can't enable eDMA engine PM runtime!\n");
+
+	ret = pm_runtime_resume_and_get(&pdev->dev);
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret, "Failed to resume eDMA engine!\n");
+
+	ret = fsl_edma->drvdata->setup_irq(pdev, fsl_edma);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < fsl_edma->n_chans; i++) {
+		struct fsl_edma_chan *fsl_chan = &fsl_edma->chans[i];
+		struct device *chan_dev;
+
+		if (fsl_edma->chan_masked & BIT(i))
+			continue;
+
+		chan_dev = &fsl_chan->vchan.chan.dev->device;
+		dev_set_drvdata(chan_dev, fsl_chan);
+		dev_pm_domain_set(chan_dev, &fsl_edma_chan_pm_domain);
+
+		if (fsl_chan->pd_dev) {
+			fsl_chan->pd_dev_link = device_link_add(chan_dev, fsl_chan->pd_dev,
+								DL_FLAG_STATELESS |
+								DL_FLAG_PM_RUNTIME);
+			if (!fsl_chan->pd_dev_link) {
+				return dev_err_probe(&pdev->dev, -EINVAL,
+						     "Failed to add device_link to %d!\n", i);
+			}
+		}
+		ret = devm_pm_runtime_enable(chan_dev);
+		if (ret)
+			return dev_err_probe(&pdev->dev, ret,
+					     "Can't enable eDMA channel PM runtime!\n");
+
+		if (fsl_chan->pd_dev) {
+			ret = pm_runtime_resume_and_get(fsl_chan->pd_dev);
+			if (ret)
+				return dev_err_probe(&pdev->dev, ret,
+						     "Failed to power on eDMA channel %d!\n",
+						     fsl_chan->vchan.chan.chan_id);
+		}
+
+		ret = pm_runtime_resume_and_get(chan_dev);
+		if (ret < 0) {
+			return dev_err_probe(&pdev->dev, ret,
+					     "Failed to resume eDMA channel %d!\n",
+					     fsl_chan->vchan.chan.chan_id);
+		}
+		edma_write_tcdreg(fsl_chan, cpu_to_le32(0), csr);
+		fsl_edma_chan_mux(fsl_chan, 0, false);
+		pm_runtime_put_sync_suspend(chan_dev);
+		if (fsl_chan->pd_dev)
+			pm_runtime_put_sync_suspend(fsl_chan->pd_dev);
+	}
+
 	ret = devm_of_dma_controller_register(&pdev->dev, np,
 			drvdata->dmamuxs ? fsl_edma_xlate : fsl_edma3_xlate,
 			fsl_edma);
@@ -902,6 +986,7 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	if (!(drvdata->flags & FSL_EDMA_DRV_SPLIT_REG))
 		edma_writel(fsl_edma, EDMA_CR_ERGA | EDMA_CR_ERCA, regs->cr);
 
+	pm_runtime_put_sync_suspend(&pdev->dev);
 	return 0;
 }
 
@@ -924,6 +1009,19 @@ static int fsl_edma_suspend_late(struct device *dev)
 		fsl_chan = &fsl_edma->chans[i];
 		if (fsl_edma->chan_masked & BIT(i))
 			continue;
+
+		/*
+		 * Skip channel if:
+		 * 1. Runtime PM already suspended.
+		 * 2. Channel without power domain, and the channel source ID is zero,
+		 * so the channel isn't assigned.
+		 */
+		if (pm_runtime_status_suspended(&fsl_chan->vchan.chan.dev->device) ||
+		    (!(fsl_edma->drvdata->flags & FSL_EDMA_DRV_HAS_PD) &&
+		     (fsl_edma->drvdata->flags & FSL_EDMA_DRV_SPLIT_REG) &&
+		     !fsl_chan->srcid))
+			continue;
+
 		spin_lock_irqsave(&fsl_chan->vchan.lock, flags);
 		/* Make sure chan is idle or will force disable. */
 		if (unlikely(fsl_chan->status == DMA_IN_PROGRESS)) {
@@ -943,19 +1041,56 @@ static int fsl_edma_resume_early(struct device *dev)
 {
 	struct fsl_edma_engine *fsl_edma = dev_get_drvdata(dev);
 	struct fsl_edma_chan *fsl_chan;
-	struct edma_regs *regs = &fsl_edma->regs;
 	int i;
 
 	for (i = 0; i < fsl_edma->n_chans; i++) {
 		fsl_chan = &fsl_edma->chans[i];
 		if (fsl_edma->chan_masked & BIT(i))
 			continue;
+
+		if (pm_runtime_status_suspended(&fsl_chan->vchan.chan.dev->device) ||
+		    (!(fsl_edma->drvdata->flags & FSL_EDMA_DRV_HAS_PD) &&
+		     (fsl_edma->drvdata->flags & FSL_EDMA_DRV_SPLIT_REG) &&
+		     !fsl_chan->srcid))
+			continue;
+
 		fsl_chan->pm_state = RUNNING;
 		edma_write_tcdreg(fsl_chan, 0, csr);
 		if (fsl_chan->srcid != 0)
 			fsl_edma_chan_mux(fsl_chan, fsl_chan->srcid, true);
 	}
 
+	return 0;
+}
+
+/* edma engine runtime system/resume */
+static int fsl_edma_runtime_suspend(struct device *dev)
+{
+	struct fsl_edma_engine *fsl_edma = dev_get_drvdata(dev);
+
+	clk_bulk_disable_unprepare(fsl_edma->drvdata->dmamuxs, fsl_edma->muxclk);
+
+	clk_disable_unprepare(fsl_edma->dmaclk);
+
+	return 0;
+}
+
+static int fsl_edma_runtime_resume(struct device *dev)
+{
+	struct fsl_edma_engine *fsl_edma = dev_get_drvdata(dev);
+	struct edma_regs *regs = &fsl_edma->regs;
+	int ret;
+
+	ret = clk_bulk_prepare_enable(fsl_edma->drvdata->dmamuxs, fsl_edma->muxclk);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(fsl_edma->dmaclk);
+	if (ret) {
+		clk_bulk_disable_unprepare(fsl_edma->drvdata->dmamuxs, fsl_edma->muxclk);
+		return ret;
+	}
+
 	if (!(fsl_edma->drvdata->flags & FSL_EDMA_DRV_SPLIT_REG))
 		edma_writel(fsl_edma, EDMA_CR_ERGA | EDMA_CR_ERCA, regs->cr);
 
@@ -970,6 +1105,7 @@ static int fsl_edma_resume_early(struct device *dev)
 static const struct dev_pm_ops fsl_edma_pm_ops = {
 	.suspend_late   = fsl_edma_suspend_late,
 	.resume_early   = fsl_edma_resume_early,
+	RUNTIME_PM_OPS(fsl_edma_runtime_suspend, fsl_edma_runtime_resume, NULL)
 };
 
 static struct platform_driver fsl_edma_driver = {

-- 
2.34.1


