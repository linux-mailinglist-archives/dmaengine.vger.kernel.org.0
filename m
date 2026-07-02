Return-Path: <dmaengine+bounces-11991-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dwz3M7bWRmq9eQsAu9opvQ
	(envelope-from <dmaengine+bounces-11991-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 23:23:02 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5886FCEC3
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 23:23:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=LJOSSMxL;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11991-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11991-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 180F6302E93C
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2026 21:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AEA391837;
	Thu,  2 Jul 2026 21:21:41 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013048.outbound.protection.outlook.com [40.107.162.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A64358381;
	Thu,  2 Jul 2026 21:21:39 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783027301; cv=fail; b=m6WFcUNGcCr4WEiU7xKGTxSJOPU8SW8nCMXeu/Jd7Kw6vU59qoS5gayC5jRfZ6O5+cAP6s1o//+KKnQV8ZX8frNqAww+eLJnuLw8ruMouOIVFzBy5/jK8QRYVlHKNzVftKkXpoAXwwqK2f6o9Y0C2w3Mbk/ErvZpfE+07jyCCN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783027301; c=relaxed/simple;
	bh=H90SbxUlmLpGjOE7Ffgp0YjE3D+Ajr22NDItGWZKsKY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=nGTQD1qndJP0CGrda5TTJDu1I1myvH0P2dvzR2nhMe3SUt2egVc0i+1MzEO83HpxcKhmxaNrEcjAmtlVAdrMQEUN3FCqRLZ2DvOYkRI1KUsDkb18DsujwaMx6tYDERKU1KAnWvIq95PSuQskn5XqDonIyTRG9owhPwbJFJ0A4JY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=LJOSSMxL; arc=fail smtp.client-ip=40.107.162.48
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CfT1mTQKaGmrmEZqUHdybC+NFxFGC0n2iHH6xD1YHleMjzun8hB9p/CUvMK9jFrqI3YnJZAuErXeQFCaCtOWSRshGHPIZKo2mTCCSKQ8sQcrAxEWlyf4Sp7fTSJRAY/KPvdYTikS48dkb61aYn6qpuwXySD/i0yOcTiBMNl21d4IHdK+1/AqR4Ah3qMiY8/xCAhpICl/LXR1l0BKYlnQl0jZrsOOQ7HgJxSvLJZ9qHdIIFBOhM1bg8n+gbjGk9SUWk6dLp+kxgQqDA3JasPOV+ee97TQ7yQq2gHYnbNE6r6fgKod/D4bEfVDFHOFp2QjkHO8zfY6pqSYixULTLWUoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pj+iGVDNfs9Hr4QIeUXqkSdFnCWIxMaI8N3ssAvMJ3Q=;
 b=lggYy4j0LX2QaYT7+CLLragxuP4HuMK0pKtZlqPdLL2Xt/r/iq6Zkdy8X6sHF5ubWYmZfOgQyWW5XYhABM3/3D7x64pzec2M51PlUS6WHmdr0wAjasprIMzW7De/FoaJ9v8nPc30EUcxr+eeesV1E+dOnlsCKePkAeLuaKigX8PQv7rVQqVq4Vr6us2pVAcGysABCNyZI6VtQKWXpR6fr06gGrxxo/A+SoRL9sU3SJGnEAEdy1ZUhxp23AlvPjrPH2o4s75U1xBUmRWM7xNE1pp3bZd2imF3gdIbZcE6HkBxhZZ9UHapZ4+con9mqLP2bsxB5J0X7JEKn1YsvVO4RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pj+iGVDNfs9Hr4QIeUXqkSdFnCWIxMaI8N3ssAvMJ3Q=;
 b=LJOSSMxLKaV7ajOnOnyz5k/F3idmN6g9f3y7U0gpTC5QSQomZpY5oXFH1WK4dPP1r+7ty6tqL1uOUZOpJ6Rz5r+9Pn9WDdee4G2/lfCQMijcF/Z4srt6PT5GRwU/n0/cs/W7TjyeFSC6OGN6nSe9/XK72xI6RHbYceXJMv5tn/shxmm+8/+7Ko3WKH+Y7sVMQm9RObhyxET9Gi9GZwNMa2u9KWoEfN0+zuKa0M1JIhssJ31bqQIlFcP/bCfGO/uQuuVnuRasAlJUDDKYhWWJGXtH/Ic6uxFCU+EP9pE6uInim1a7/sjR3E3FoT0qmd1qnUCJI4gIQF1RHLYoyA1NMA==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DB9PR04MB10066.eurprd04.prod.outlook.com (2603:10a6:10:4c1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Thu, 2 Jul
 2026 21:21:36 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Thu, 2 Jul 2026
 21:21:36 +0000
From: Frank.Li@oss.nxp.com
Date: Thu, 02 Jul 2026 17:21:21 -0400
Subject: [PATCH v3 01/10] dmaengine: dw-edma: Move control field update of
 DMA link to the last step
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-edma_ll-v3-1-877aa463740c@nxp.com>
References: <20260702-edma_ll-v3-0-877aa463740c@nxp.com>
In-Reply-To: <20260702-edma_ll-v3-0-877aa463740c@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>, 
 Niklas Cassel <cassel@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Koichiro Den <den@valinux.co.jp>, 
 imx@lists.linux.dev, "Verma, Devendra" <devverma@amd.com>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783027287; l=3479;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=vzz522NZxHKRPWVVX0B9KmMDkTiMJ0ntIYFB9dONZzw=;
 b=MQK5DqJJGysiAXLVzf470l5mfoZC2sj9gfE6hG4z/pyk4SogSzoIGG9pwoW1xxgYBnfMxjFFc
 kCVYOtH1DkEBhXBPkxWdLKjMllTvkqz75TGaFyVktTr9nQv8l7Mqqst
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA1PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::11) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DB9PR04MB10066:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ed13493-c3f5-47f5-2b1b-08ded87fe602
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|7416014|376014|23010399003|366016|22082099003|18002099003|56012099006|11063799006|921020;
X-Microsoft-Antispam-Message-Info:
	OEPubBzWPI2ISRLW/zrnlO1Qug2Ib8w9d5e64k8lKPrvkP+3Yf7wMrb17ZWYlF8YhSooYcpdqFBCp8VB/mkeEIdKT2RRSVhrCcXxmhj6U/792bu4HC+pydUAy+9PF7VnGvg28qs639fzRGCRMetA+1PcscfghS8OY8Vb0acSKYiC/1xBnKixezEjIsdc7s6rxMXa9xl2nW8k1YfMa7dmdGTZQSD0REv8bRRrC1xguFMDRK8LRWLaD+IMqwiJsdVi2BtgCiHu2XlgFTRagmoLO1FL6jzqa4loGqWJujpfmi/S38JMXxoutt8AwvwX8pmfxXjOUC67wDStIP/nZIBKX/AjRuH2OPbTAL2G0Q/Y30OvjW3DGUnvspF6VGbYDPPoelqnnBpb4z+P8UI1Pif21iJK/2jJjWndKYMCfHntDmFxpJZxoeJSZIH0wTu1gGR3jafbTSS7iHvxjSQK8JonuA2keW6Q42W7rqRhfGha/lFb8HCrfccMj425wVvFrOjxDsMYoJa3CoGWnTsqGoFEqtyUKcWtP4sRWQsNUk9s+E8VVLnDKP/uWgBlaU4QqksL0jA8qYavlYxUNwe6f3MH2ZnAd+5WRH/ae1uXK8yX0/rWcNE6eAJrnozOcrv/HAymKIjkZ434IL+AwXBeoOR2h8xPUcBI4aLMLO4LApRqNSkVr7e5QN/DwArgKC2t0y399j14dEWqkpYNA0nsy8VR5w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(7416014)(376014)(23010399003)(366016)(22082099003)(18002099003)(56012099006)(11063799006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDRVNFlnTVNpR3RNNGovNmR6U1dlc0dTdWMyNnNwZ1I0RVpudnlZU2VwaDA0?=
 =?utf-8?B?TEpBbURxR3RxZ21JRHptNE11UE4zYURIRHBxMkRibURvY2h6S2ladkZTL1dz?=
 =?utf-8?B?UC9TWkV5VEtkYVBiRnVreUJOQkJBckV3NzhQbmcrVkZoMm5lNUxpcGUwOFNU?=
 =?utf-8?B?VlpIY3VMK3loWmY1N01OODZhTUs4Q1FaSGsvbFFsU2RiSEx6Vk5FNEdST1NW?=
 =?utf-8?B?RlNieFRHWTJaZU1KaCs1Y2Y3ZVFqWUlrT0JzWGxBems3SkJudVVXSC90MEZF?=
 =?utf-8?B?a0UwbFhvVStybWlqM1hPZW5URFljMmJwUmIydU43YUdoZ1VYaXpVMjMySzRH?=
 =?utf-8?B?eGxBSUdoaEJDYzdrN3Q3c1ZkWFNQVFFCbWwwUFJaYXQrVmNlZHRzcTFub0xk?=
 =?utf-8?B?aWN6ZFRWc0ZXQWlyL0loV0wzQUJWQ2JNWnpGZDMvZDNHZUpXdTU0MDlrSlhj?=
 =?utf-8?B?ZUNhaE1SUXVTdjNCMDdmQlVPUEpYV1E4aTNNZ0lmWWIrQkxNdGhZSXJvdFB5?=
 =?utf-8?B?NUhydm8zaHJsTDJJcmxaSkFlamVaWTg4U2JEUmdIMUthbFcrbk96TXdHcGwv?=
 =?utf-8?B?WXRKdThBb2tsMy8wSVlEa0ErWWFIeDd4M1ArbElGWm5oZDJETjBRTFFOK1Fn?=
 =?utf-8?B?WXB1KzBnRnkvY3JkWjdiWGNJT25NSTdqNWtCektlSXpGWk85WStKbEsxLysr?=
 =?utf-8?B?SVBRcHNsUHphbXFhQ0ZKeDI4VnVQNFhUVzFDV25lN2ZCakFuaUkzSkhRUWJq?=
 =?utf-8?B?b0thQzlYOEJhMm53Q2JYTk5hUCtLaVNpMGJrNmVNQnlIZGduem9IOTc5MW5l?=
 =?utf-8?B?U012NWFUT0tib0NkampJV05kM3RoTDAxazBjWkVrZEZoVTE4QnJsOHhQWjRY?=
 =?utf-8?B?aVNzZE5ISjZ2OGoyK05ac1dIV0lzdU81VnF5V1RISzAyNURRUEs3SHlydmtJ?=
 =?utf-8?B?cUd0NmhnVUt4ZCtvMkFXMmNFNktoTTIva2JhMDE4ckE0TkNuSEJ6eEVJNHRS?=
 =?utf-8?B?T2RwbmlJclVhME1tRmZhLzBJRW42Q1VhL3FQbGdvZUt3NGJ5SG9uSWk5Qnk0?=
 =?utf-8?B?Zjk2VDVQamlmbXk5dzlqbnJtKzc5TzA5a3NUTk9BVllPeTd2eTM3ZE1mcGpH?=
 =?utf-8?B?WS9qVHVJL1pDdDBqdzczeDlWR2FzVExGNmJJSW91ODlnK1ZHNUZjeWN3Vkk4?=
 =?utf-8?B?UFBXK2JjajB0Kzc0dFNnUmlGYnJZTHVoSU5KMENhMzV3bzlOSkZ3V1pzN3VZ?=
 =?utf-8?B?ZWFLT01URFhidFJrb2dWVitwUTNQSy9UN25hbFVlRmoxdGJTeWRURE1zY29N?=
 =?utf-8?B?WlNzVXY1Rm1DaWZDN1RPc29oRERCSWIrS3pWS2hHK1E1LzJqSG95OEVEaFYx?=
 =?utf-8?B?WU1oL1NZMC9EOFpURWJiSnNQbEM2a3cvMlMxQUhLd1hMSlJXYktRVllBUVBN?=
 =?utf-8?B?ZGpxckYyYTU5VmlpRlhMYnl1MWI1azRvbTVIMkVBdE5VelRwTnptbzFnSUZ1?=
 =?utf-8?B?aWpNd2xwdnFkcVJISzRpV2ZUSEJHMDFYV1k3RERNYWZFaTk1WVNqblQvNXZo?=
 =?utf-8?B?cDJub1puMHZ4ZUZHSGpoMDNpMGRNY1J0SlZLVHRuWnVRRjhGbGhYQTVrbDR6?=
 =?utf-8?B?OFZLMFh4Wk9YV1J1VllsVWtVdHY5Zm1iUFhDUHI1ZS9GWWhTNyttcUNmQ1BY?=
 =?utf-8?B?aEJSdHYrVkRvSXV3Mlk5Zi9EcGlSTFBPbWxUUW5GRlgvelFONFNOZThTTXNR?=
 =?utf-8?B?ZXM4WHI3SkxSaTBGZzU0ajNVdCtzaFowRmZLSnZaN1dzOXFhcE83cWNjODMy?=
 =?utf-8?B?andDK2Y3ejFSVkJ2YjEvRFNMV3JEZGZLOEFUcEljNVV1SU1XR1V0MHJBNDdy?=
 =?utf-8?B?TkJXTWdhcCsxRkY0clBJVnV6cldEYWVYMzRtaE5PNWtsZGxJSTlGWFkvZXIw?=
 =?utf-8?B?UUxGdnpscTNLdnNKaEp6NjFVQUsvVGExYXlPNTdHR2NXUGp0anE1VUZaSHpN?=
 =?utf-8?B?cHlTcmlyK1B6NnpGaEgwcUw2ZDV2L2xZc2laa21JOEVPSmFHd1VtRjBIRHYw?=
 =?utf-8?B?cHlMWm5CaFNLOFUzcTU3bGxHS1RSeWVqTWlNWGpIZFJ0YUNwK0tCMmlmc1Jt?=
 =?utf-8?B?ZzFTQUdoZ2U4NzZoN0c3aDFYS0Y3ZWcvVVJMMnZ1anJFSlI4SmxyV2g0eFQx?=
 =?utf-8?B?Z0hKaXJjTGhUQmtudXQ3V0NRZWFBd21BTThwQnRKMzZScjR2WUhyYjFFZnAz?=
 =?utf-8?B?M2M2bDdSRjQ2WStQVGYyUWZzZGVqbnVLRGdGdTYxVGw4aHhseGxWdm1uTytp?=
 =?utf-8?B?YWo3NGFCbGswVTdRL0s1TjNSQTcycUhjWWpHS2s5VytrQjYwRmtIaXVUczFa?=
 =?utf-8?Q?szdM0SESpKJaVuSvt7VEucEq6+SmGKi50wB2q?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ed13493-c3f5-47f5-2b1b-08ded87fe602
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 21:21:36.7229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8957l5semFRgiTrf/JI4NQWnnk2d8MTr0+YojSymLWaPj1oJfs+76m4pryOPH2WU7Saa/9eQ1ztE0/Ex0E2L9xAVLNjitOrSlDFD5PFBZ1MLfwYDf/yO+ibeMHMxETU9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB10066
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11991-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:vkoul@kernel.org,m:Gustavo.Pimentel@synopsys.com,m:kees@kernel.org,m:gustavoars@kernel.org,m:kwilczynski@kernel.org,m:kishon@kernel.org,m:bhelgaas@google.com,m:hch@lst.de,m:cassel@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:den@valinux.co.jp,m:imx@lists.linux.dev,m:devverma@amd.com,m:Frank.Li@nxp.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[Frank.Li@oss.nxp.com,dmaengine@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@oss.nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[NXP1.onmicrosoft.com:dkim,vger.kernel.org:from_smtp,oss.nxp.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:mid,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6C5886FCEC3

From: Frank Li <Frank.Li@nxp.com>

The control field in a DMA link list entry must be updated as the final
step because it includes the CB bit, which indicates whether the entry is
ready. Add dma_wmb() to ensure the correct memory write ordering.

Currently the driver does not update DMA link entries while the DMA is
running, so no visible failure occurs. However, fixing the ordering now
prepares the driver for supporting link entry updates during DMA operation.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/dw-edma/dw-edma-v0-core.c | 10 ++++++----
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 10 ++++++----
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index cfdd6463252e6..ee5c3c317557b 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -284,17 +284,18 @@ static void dw_edma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
 	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
 		struct dw_edma_v0_lli *lli = chunk->ll_region.vaddr.mem + ofs;
 
-		lli->control = control;
 		lli->transfer_size = size;
 		lli->sar.reg = sar;
 		lli->dar.reg = dar;
+		dma_wmb();
+		lli->control = control;
 	} else {
 		struct dw_edma_v0_lli __iomem *lli = chunk->ll_region.vaddr.io + ofs;
 
-		writel(control, &lli->control);
 		writel(size, &lli->transfer_size);
 		writeq(sar, &lli->sar.reg);
 		writeq(dar, &lli->dar.reg);
+		writel(control, &lli->control);
 	}
 }
 
@@ -306,13 +307,14 @@ static void dw_edma_v0_write_ll_link(struct dw_edma_chunk *chunk,
 	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
 		struct dw_edma_v0_llp *llp = chunk->ll_region.vaddr.mem + ofs;
 
-		llp->control = control;
 		llp->llp.reg = pointer;
+		dma_wmb();
+		llp->control = control;
 	} else {
 		struct dw_edma_v0_llp __iomem *llp = chunk->ll_region.vaddr.io + ofs;
 
-		writel(control, &llp->control);
 		writeq(pointer, &llp->llp.reg);
+		writel(control, &llp->control);
 	}
 }
 
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 632abb8b481cf..1201f1ab5f359 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -160,17 +160,18 @@ static void dw_hdma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
 	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
 		struct dw_hdma_v0_lli *lli = chunk->ll_region.vaddr.mem + ofs;
 
-		lli->control = control;
 		lli->transfer_size = size;
 		lli->sar.reg = sar;
 		lli->dar.reg = dar;
+		dma_wmb();
+		lli->control = control;
 	} else {
 		struct dw_hdma_v0_lli __iomem *lli = chunk->ll_region.vaddr.io + ofs;
 
-		writel(control, &lli->control);
 		writel(size, &lli->transfer_size);
 		writeq(sar, &lli->sar.reg);
 		writeq(dar, &lli->dar.reg);
+		writel(control, &lli->control);
 	}
 }
 
@@ -182,13 +183,14 @@ static void dw_hdma_v0_write_ll_link(struct dw_edma_chunk *chunk,
 	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
 		struct dw_hdma_v0_llp *llp = chunk->ll_region.vaddr.mem + ofs;
 
-		llp->control = control;
 		llp->llp.reg = pointer;
+		dma_wmb();
+		llp->control = control;
 	} else {
 		struct dw_hdma_v0_llp __iomem *llp = chunk->ll_region.vaddr.io + ofs;
 
-		writel(control, &llp->control);
 		writeq(pointer, &llp->llp.reg);
+		writel(control, &llp->control);
 	}
 }
 

-- 
2.43.0


