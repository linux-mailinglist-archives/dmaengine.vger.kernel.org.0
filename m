Return-Path: <dmaengine+bounces-7808-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E60F5CCCC3D
	for <lists+dmaengine@lfdr.de>; Thu, 18 Dec 2025 17:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8739A30FCF38
	for <lists+dmaengine@lfdr.de>; Thu, 18 Dec 2025 16:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7C8354AF8;
	Thu, 18 Dec 2025 15:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EQjx/97P"
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013071.outbound.protection.outlook.com [40.107.162.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2BD34FF7C;
	Thu, 18 Dec 2025 15:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766073426; cv=fail; b=uQXve/YPEbH0+di2mAclIJXPjw3Jwx3J3OwnPHI5hur/6LnoOYZuK8aGksqnCNtRqE2wBy50gKfZWW7/7VihgRdeWD7EqB8HXGbP2vVlBrin0qdIpq38Ng3Jzf96HkHQ8xBulsl73cIHRMHF7RdK3ufSjp3eA5M4Lg7gT3h5CnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766073426; c=relaxed/simple;
	bh=wsvexpWrSfWq9gITHBKIdAKuJwiqSfNp1PCydMlUpWE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=VJD8OtLu2G0CacOf1pLxqFUl1849AeTcqeLQSrsIAf/l1Msnb0wXPjRcX2xppbWQmPOjJwZnSqif+QHV17fs9fW41u5AyU3Jecb7sN12J3gwBXMOHk8nF4mUIOTH7716Vgp9C0Y0MGhwfiYMd67oC/8NRnB95hDVm8uoz6XGHPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EQjx/97P; arc=fail smtp.client-ip=40.107.162.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tNbI8Zmm8RlbopPsxegfx+U3JT/8rJvWQIbs5fCiUfZRUQx3xhhIKPiIJWmNP5McdjSAmbDsblebZPyA2vi/trgFbQaENu/iWTeDKgtnofKXTBgGHRpzDp5k1RLduwhD5noY6m8jBPZNkkkXmDe9lHm7pO0zPdb8n11CSq8gDpT1Qh8h59Qmj1TvgAI7I8I7RkXLkM2HnZoIi/8T3FVpQyauQzmATBf8CEj/bZ+R/e2GfxH8tjWDr7bhsuEi0EcS7Iw6ZuC4vVPuYwoQ6gO1xLrp8nJkgr9oFE9LgDKMDX6/jSMndVONobWh2Y8dq8hKrpLmPkc4eExmigRq83OAxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tqhR106ngVccyAu4+yIFjhQcMk1FETPFqjBdbGYSUqo=;
 b=eqMrRCFmH2vDI1O3r8kpPmBy7BMRZoZh9GfaVYsZA8Gz4fewpVo8HNWdnyqFxtXdiEByn/BjBD5VnHR7RchOAiEuxSgqgndp3fFe2ox5gNeRIxaSeTEu0uZqKG8BClPjCTfXIWfWKmMVuq50KfqKLNbiasgl+qvVHxaDqjo9w9zn8bM32ZJP/CTGqKw5ipCRBX03cDoj1kBnCOD8zLtBu2GO19cAc19auRHdkllH09HRagV9kSaatHG3MB0HWAzD29LqZYXBOHNsVFRbvOVyCdIbAYUcFVuv6q8D57LsIdHgaVuV466Pudu2rlM/KKYi2cdZriBH7Nl3W8xey+tlWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tqhR106ngVccyAu4+yIFjhQcMk1FETPFqjBdbGYSUqo=;
 b=EQjx/97P1Oo1d4cLsDJM3XUzkICr1nDU5ntwiPQ3xxRofcfWYcCnTgIYbWnRRT/oM3voThKlVw3v4jE/u+QPXLLCivNdh/qcuWGVu9KTCwJ3gtNflfWjMP0oKvT6FOdpr/b8NeDbSnCXtOxtFUMF6KQ5uzL/65gLvvqqXlV2c5X20NPQiy88S1ETJSPgpKv2Bfw39T/RTtTcc9Xmego3Hg4GrXGFCBCRtp3MduQklLzSLGhF/Cj5HNkbOLLnNPP46ptL8HlMVFIgc6+Gh5QK8C2hTLayQC+H1dHSGo60pA1XfG3+8KuE3vKVxK+opX8hcBEWcLdcPMUj5uGfxZR8yQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by VI1PR04MB7037.eurprd04.prod.outlook.com (2603:10a6:800:125::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.7; Thu, 18 Dec
 2025 15:57:00 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 15:57:00 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 18 Dec 2025 10:56:25 -0500
Subject: [PATCH v2 5/8] nvmet: pci-epf: Remove unnecessary
 dmaengine_terminate_sync() on each DMA transfer
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-dma_prep_config-v2-5-c07079836128@nxp.com>
References: <20251218-dma_prep_config-v2-0-c07079836128@nxp.com>
In-Reply-To: <20251218-dma_prep_config-v2-0-c07079836128@nxp.com>
To: Vinod Koul <vkoul@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Koichiro Den <den@valinux.co.jp>, 
 Niklas Cassel <cassel@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org, 
 mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766073392; l=1247;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=wsvexpWrSfWq9gITHBKIdAKuJwiqSfNp1PCydMlUpWE=;
 b=fM/sBW5mjAnCsihLWKpQ0RPNrFaeDiAw34tRSG587t9C4h2fq/D0Ue+DhKjWUh+0KFz4SevZa
 g8Lm3jJGdRnCpGON/s+3e0lBqAJG/BXfZqqj7UQ2FryWmDY6Y5R8loJ
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH8PR07CA0047.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::10) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|VI1PR04MB7037:EE_
X-MS-Office365-Filtering-Correlation-Id: 79fea860-c31f-4764-82c5-08de3e4e1496
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cXFUZVFZTlN1N2dHalY1ejgrMDFCaHN6Z05oNFVmckR1ZFIzSld2dXRSYzgy?=
 =?utf-8?B?RkJWVzNqRkx6S2xPdmVyUk5waEoyTmVRdmxDNDk2MGJRQUpldWVCVUNWZ0tJ?=
 =?utf-8?B?QkpGTDFIaHFsTnN5UnhIWTR2NzlrZkY1THBwbmFiYU9tT0J4dkwrcHo4ZnVK?=
 =?utf-8?B?NXBSMHZodEEwK0dVTUM2NVROZjJaVzlCMk5sTHZzT2RlakFGeVpZMHN5ajU1?=
 =?utf-8?B?WnRRZGxid0F2Uis1UHE5UXJUYnBIT3JuTlJESHBjai8rcGhUdllOb3Z6YS9u?=
 =?utf-8?B?QXdhR0pXSHdzZXhNRWNid2tpeFZsWVpabHk0SzZ2S25tNUkzbmV0eEdHNk1H?=
 =?utf-8?B?RWRkUjVNRXZWUFRVOTlyUFBqclgxK1JBWExOTm5Bd3NVajVCU1R5eVY1YkhW?=
 =?utf-8?B?a2hsdzNLekhkVFVFZUd6YVp3enBLSlhUME9KT3h4WHhTTUcrTjh5anl2NnZS?=
 =?utf-8?B?YkNPY09Dek1HeDdubEdESDlkY0IxNUJJTWxmekdldkc3Szk5UHliRXd3NmxG?=
 =?utf-8?B?MVZHdDNWRTBsb05sTmJDMmh6VFNxakdoanBNd1FZSDhtM25vb0puQkVhUjY3?=
 =?utf-8?B?VWFMNWFJV1hnSDNHVFlhQytXSkE2aUNiNEhPbStYeDVsVHc2dVFSd2E0ZmEr?=
 =?utf-8?B?TXpwL25WeW5kVmN1c3ZjZng3dkx2YlZyYXpZY1VoR1BUTElpTkVVdXkwaWpw?=
 =?utf-8?B?U2pmRzJZQTg1dWNTU05LMmtIdU82UWlIc0FHb3lUTmNTVTRXRU5xcDdsZDlN?=
 =?utf-8?B?cFl4cFZTWmdRRmV6cmNaWHFCU3d0NUtlVjRadDZHOU1ydU5YWXhhN2FDaitm?=
 =?utf-8?B?UTJ5c3JHSkw2dW9zZ1BmMFZyZnZBZGVpN2s0SXhaV3ZkNk1mdCtkUUFSWmxy?=
 =?utf-8?B?V3BEd3ZXczFDbmtYZFNHWXMvejBaeDdQSkJHVk1kem53UXpUaEs3THdQRXha?=
 =?utf-8?B?KzMrUDJJMGowblJ4L096WmpFanhLa2JGeVY3SFo5Ui9YVWhhZmt6T0JEampz?=
 =?utf-8?B?M1lkR29wQjcwank0VlJnWDJoZ093ZTBOQnJ6V0JZcWZZMGViMkV1MVhQSWF1?=
 =?utf-8?B?M0p0NHE4d0JlRnUwVHJyNUx4TGNLMXhWNG5UNWlYSk02ZnhjMEVYTnI1TFJm?=
 =?utf-8?B?REpPTFVPUE1rZVpQVU45YU84MHhOYVpJT1MrSlFJZUhnRjByTys2YXdveUdt?=
 =?utf-8?B?Zi9EdzFXSEJNVStKYlFPQW11WHB1YWdCcWJNbUNsSnNNb0pFNXdJdTZRU2RM?=
 =?utf-8?B?dTB6eFRhbGpDZHN0M2Q4OVoyT3o1Mno2aFBHM2Y0VnpWZGN2bWNHVW1ydEpS?=
 =?utf-8?B?dE1PTGlCcDFtQlBIOHd2N25OSVJINDZFb2Uvdkx2ZnA5Y1kvWm1GS1VPNmlJ?=
 =?utf-8?B?UVp4NE9ENEdDZDBwWmw3WjdoaDRzZU4veWFrR1ZybGI5Ny9aTXNoSURUVEZ1?=
 =?utf-8?B?QVpNT0FEdGhGdDZwZkluTlNHK08xdjJCTFRub0VyYmpnL3NSQ243OXVJb1NV?=
 =?utf-8?B?Qk5aYVVMaXdSbGxTOEt5eks2cGtYSVJOR3JvTGZXbFVkbElTYnpYZFRaOW1R?=
 =?utf-8?B?UnlZM3EyM0M2YlhhV2RyY1UrOTIyTExRLzA2S09LcmdjSk1oWndLUEZQZHhT?=
 =?utf-8?B?VFFDbHBpYjhXSlQ4bTNtdWhKODF5VnFUbHJpVUVDditiekVmc3g2V1VHTHhO?=
 =?utf-8?B?czBEWUIrK3pybEFvVEdiYjZoUS9EZ25aUitYSFViRVhyZHlnOEF4V3BDdFlG?=
 =?utf-8?B?OHR5a09oQ08yY1AzTVAvS1J4ejNyTjJWdTZodkRxcjBDbGE4V3NLUU1USHA5?=
 =?utf-8?B?V3h6NjBoa2dMV003aXg1bXpXWGVzMytnWGk0dy9ML3RITHBXUW5KVEovREdM?=
 =?utf-8?B?UFhud2lLaityTkgrUmtWM1I4QlVHcTBTUXl6SlpUZDdJRUhoMlIraFFIaGNp?=
 =?utf-8?B?QVlDMkhrSHU5VzlGeEcrVVA1Zk4wUnF5OGxjdDYwTTQ4RHpSdDRtSkc3angy?=
 =?utf-8?B?WmhraXBCa2tQcXZvWTJHYytPRVVLZGVHMUNzbDI4c3dCdFB1UjNCNUl3TWUz?=
 =?utf-8?B?cHVwOEZ0cU96Uk8yM1dHUkJWZUh1NEMzTWd4UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFNZK3E5RXFNaTlzMXIrdDlzdFd0WEh0T1JsejZ3TER0eVNJdVA4eWw1eWhE?=
 =?utf-8?B?c0lWaE55bldzLzVmMHZxTmpmNHlZK0tnSUVRT3k1Y2F6amhvbFJqMlc1dncv?=
 =?utf-8?B?ME4zSXFoNEpkSnlzOXh5RE5EVXN6Q1o2b0VMdUJadGg0dThvYXRDbU5HL1Yr?=
 =?utf-8?B?aFE2RzlsVHo4TnVpc3pwVkhqbFptTzBxZ1ROcWhDYUpIMVl1Mms1NVZYb25k?=
 =?utf-8?B?VmVFRHBHUE5ySlBLdXRWR0svWkl2Q1NIMjYwRW9BYXZTa3gzY05IeWxqYWY1?=
 =?utf-8?B?NjRPbU9NNm9RbDE0VWlIWHQzczZDQk4wVDRVMGhrclE5Vk5vaWZwK1gzYzFz?=
 =?utf-8?B?Z0tNYUtUSjhVclBNMG1XOGJJa250NnQrVlZnNmVxdEtLNjJ0c0dOQWRnazN1?=
 =?utf-8?B?aGs1bTNUQXRNM05aT2FJbEV6a0xXNmovczhMQyt5c2UxTDlZTVl1eFV0MFBX?=
 =?utf-8?B?WGhHOTYyQVBWaVBqdmVBeDB2LzlyYWR1MFFZMDJBS1N0WTAxRUJvN2R6bDV1?=
 =?utf-8?B?NXkvd0s5MmNvcUI2cnQxSERKWlBPM3Fvalc1NFRrbDNUeUc0T2M2NjUvODVF?=
 =?utf-8?B?QWcza3ErM2FLYVdBQkhBS2didGlidHMrS01kRWEwVDRpcjAwOXRTWjhkU1Zp?=
 =?utf-8?B?bXg1STFJc2l0ZkgwMHV3VU9QVGlkY2p5OGlnZUlEUEQ0bWhXMnZsMkhLdWJY?=
 =?utf-8?B?Rm5uNis4c21IdnVTRnE1bWFwVkxDcGFPcDR5UjRQZ2xUWlppNTV4U21MbURU?=
 =?utf-8?B?SE5HeGJrMENSN0FkLzZNbjI3dlNid1R3Y0RjRUppajVzRTNLa1dlQWlrVkNa?=
 =?utf-8?B?Z0dSdy9ZaFNLQXJNMmYzVktycTVnL2dEWDd1MG9YbkMvOHpFY0Z6ZDM1UU02?=
 =?utf-8?B?TlFkOHg5K3dQTHgyOXN3QmdHdEVpSUpad0hEWmZ2czJOeEc1alEwZURndXMy?=
 =?utf-8?B?R0laWXhOazZDM3VXZk5QUTl0bFZ3NzFRd2dKbFRhcndyd2RrcnV2R0JwZFhV?=
 =?utf-8?B?b2JtbDZCRjFZVTAwSGJ0L2I5aTN1a2xaVlRjTk1yNWsyMXVPR2dsU09zTGlX?=
 =?utf-8?B?VmUwR0VHZWRQVUlNaUhaOVExdnUyNTRoVW9YODZtdVVOMkZOT0ZHRnNRY3lj?=
 =?utf-8?B?RjJGTDZsK0s2Q29vRXh5Ry9qNkdySGc0cUFISDJGSmdIM01UU2cxY0pwaFlr?=
 =?utf-8?B?aFVpdE1lZitqcGZRWUZuZElvYmtwaW5CblQxSDRYTlJOeVFoU3BGeFhtb0o2?=
 =?utf-8?B?VDVMTDZKRFh0Y3MvRUJIUTZiMW5xOHdsMHdJOElSZTVpSGUvMHpuL3A3TWsv?=
 =?utf-8?B?Zy9iYk02RXoyQmZZT29pRXViM2Z3VGpOYm44azdlYlBvbmFzT001NXNYYUVw?=
 =?utf-8?B?RVpIRDhMcGxiNkVnL241RUtlblpObFVacDVNQlR2NC9nV0hYZFJDUXgzaUtB?=
 =?utf-8?B?c1RlbWkvejdMOXZ6QjNLd05lSDUyVHZXcVgwTEgvZWtNSS9MdkkyZmJid1Ey?=
 =?utf-8?B?OXNxZUhUazBKZk1sdVhsVHBTYXBLT0ZFNHNGMmRSTkVRaUVRaWN1M2x2Y2E2?=
 =?utf-8?B?RzlUZ2x3OEhDbFJnNVVndGpRUnBIZVZkWDNxRXRzakN2QkF4TklqUTZWUktq?=
 =?utf-8?B?QTNRdlRnTm15a1RZQ3M1NzlzYnkzYTdMVElkRGRXQXlVNTFTemxJbGJNeHcr?=
 =?utf-8?B?aERITklSa1RIU2QvYkowUEZPVGQ0WmovU1JwWE1VczJZamZ0S2p0UGxCSWFO?=
 =?utf-8?B?UFhtZm9QVnllRG51dlVXbkpQY3NZT01FUUl6NXdvbVlsR0pJWjNKMU9jbXFi?=
 =?utf-8?B?R0RaaDExSEowc2lNWEIwa0lJSkpXVjRaL054M0oyY1VEZytQUkRRZnlzYzBi?=
 =?utf-8?B?NTg2R2R0MXk2RnJlSXBWL1hyaFMvUmF4Q0MxU0Noa0lwbFRzbm1DQXhSZm1S?=
 =?utf-8?B?Q2MzcEFwQm50UzA0aUhhK2tJcC9MOTQvVXd1Q0JzeEJqcUxzRHp6cERZaCtZ?=
 =?utf-8?B?VCswQjdORWRHT3RTNjFnOE5WcTc1R08vRnJjV1V0TFBzNDMvb0MxaTZGUi9Y?=
 =?utf-8?B?ODlnVDdYeXpxdFhsVzM1a0pOVkhXbk1RNEliSnNjQWFuQm1JSnNKbmRMc3hi?=
 =?utf-8?Q?3hRsZ7Vk1+OhbTnm4J+Z+p5v8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79fea860-c31f-4764-82c5-08de3e4e1496
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 15:57:00.8273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bASuMl8kAQ7thzWmVHVqt/fHJ1/YKrfv7kOy3epQp0CUUi40YYrBVgfS2tDpOWsKbZIojK4A3Q9/ythDV6X5sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7037

dmaengine_terminate_sync() cancels all pending requests. Calling it for
every DMA transfer is unnecessary and counterproductive. This function is
generally intended for cleanup paths such as module removal, device close,
or unbind operations.

Remove the redundant calls for success path and keep it only at error path.

Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
This one also fix stress test failure after remove mutex and use new API
dmaengine_prep_slave_sg_config().
---
 drivers/nvme/target/pci-epf.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index f858a6c9d7cb90670037a957cebdcbf17dddc43b..56b1c6a7706a9e2dd9d8aaf17b440129b948486c 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -420,10 +420,9 @@ static int nvmet_pci_epf_dma_transfer(struct nvmet_pci_epf *nvme_epf,
 	if (dma_sync_wait(chan, cookie) != DMA_COMPLETE) {
 		dev_err(dev, "DMA transfer failed\n");
 		ret = -EIO;
+		dmaengine_terminate_sync(chan);
 	}
 
-	dmaengine_terminate_sync(chan);
-
 unmap:
 	dma_unmap_single(dma_dev, dma_addr, seg->length, dir);
 

-- 
2.34.1


