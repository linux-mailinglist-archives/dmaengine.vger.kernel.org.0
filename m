Return-Path: <dmaengine+bounces-8251-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 75655D207CC
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jan 2026 18:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DFA130A0DAA
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jan 2026 17:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071CF2F0C49;
	Wed, 14 Jan 2026 17:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="G2sNgWCm"
X-Original-To: dmaengine@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010015.outbound.protection.outlook.com [52.101.84.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2672EA482;
	Wed, 14 Jan 2026 17:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768410809; cv=fail; b=RLypQZfbGNcWTvC7X5Wzm6DyUPlPAxLhxnZ8BOGM1S69aR+wRRDqqQTWSXS7IVtIqSEXJ4GzvbswU4LFF7g6Mg0qOwWTUqyp8QRcQR0suqw4xa/cR3Q6gFIbKsrx2DE33OVOevcctduV/uBoZTttlyAceVSmqHoNU6yX3FYDcvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768410809; c=relaxed/simple;
	bh=HMxUaQN43fsTwQ617LIAHiXWsPUUzYeGGhCwt0b0eZA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=SNPXQC89KCaGAnBvXEujGl6AGLWTkwPE4Jy8zCAFJWwieSLKb0n8rzJ+EBPSTQT2ojzP0v9xOg527vUbZ5dupr7ooRa7bcSfdShAlTrBoi7zOm91y8J8hPMSkrAlTgZudDFtqnVYtO04lV5MiWvAiixiwLwR+6F2tzX8F7b9YQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=G2sNgWCm; arc=fail smtp.client-ip=52.101.84.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mrUDaAYnILxH+LMtNFDxzHpxz0hNWhG3Ea/dTZcRi99GWl/Vc7JG6gCLhAy1+5XLh8UWgpfB8k1rYkqPRt95Q6hl+6XSWJ2Yvu8TA1zENrnVCKnI6BzYlUoROMQkYTYADYN4bQIW0aTvhREHR4BrYDtHMtCGCoRpXcoCOGazC3xOVjb0Eczh3HkEphmcMLW3/fPwI11egzxW+p0OMHj6V5uxQhVPrQRsVoBM3wfhUck2mUv5JmRsaSE5XKcWx0ZZ2JgG3nti2Yd9OJ8giNAzOiD9NW3vlbruPQAZnTq3SBQMM6eKSLF4b02WZskyXXZJ9LEPjUFm+DBStOjWkJPZYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z76J7+bwXT1rKFSFuvxcuZW4UjCPB7lgQ8eh/NImVHk=;
 b=U7Ehvvx5JQIMUXZ/ulw0qScoPlxmE3b3B4b8S1nnqT2zZ4adHGM7HlMqTPWNHGuABO/SBT2MUBAtr+bOoP9bQhnoynzcktceqEugC1lvxjRM0x20lEpdVwE+v9PIk32BUJ44gXwb//ALSM9s4aSwtNxVq7mJ0HChxXI+lTjypPOyMQQfk2/1zeJZg/QOf7DJpNx4OmYK7HEc839oT3D2aj0vQTtOVU8n2jNNRWw9AYukgQOS3v3objWaVFERKcGA3mcH0rX9FNeYj/TsfjEaAGGcB+7m5s++CCj7pgalWcZRZVVugJx2CVBOP0LHWleJ3tBs12Teg2K6C6yHCseFzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z76J7+bwXT1rKFSFuvxcuZW4UjCPB7lgQ8eh/NImVHk=;
 b=G2sNgWCmh+uoPk9k/liPYH+P5LAxtQq98C1WX7Lep4Mh6f60LV/QNYTeVhrboDalL/TIpn3WDdZsLxt246Kbq7K1Z+a2Pybt0+XXdwHJlFtsofWJcRNT4UuzyRLL7aAoQd6QUNMG3IZAcE8uGv4NT4p9/let/aZGwYI7FnPzHRD0GG3yTy47RxRz6Kayk0yFzP8z/nZDz+sCOagFDDtfrHvUmjC1Oe1qNwzperF4ELZrNgRBf5iAHMVI5/6CTjlcWdr4Ry2y8hzQDUmqekNGPVVEhOCl2qsqoIaNqjEHBdbQJDNg6fJIItlOLW4twHAgWvBI+xiueSTn9ayN/rNSBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8948.eurprd04.prod.outlook.com (2603:10a6:20b:42f::17)
 by VI0PR04MB12155.eurprd04.prod.outlook.com (2603:10a6:800:312::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 17:13:20 +0000
Received: from AS8PR04MB8948.eurprd04.prod.outlook.com
 ([fe80::843f:752e:60d:3e5e]) by AS8PR04MB8948.eurprd04.prod.outlook.com
 ([fe80::843f:752e:60d:3e5e%4]) with mapi id 15.20.9499.002; Wed, 14 Jan 2026
 17:13:20 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 14 Jan 2026 12:12:45 -0500
Subject: [PATCH 4/6] dmaengine: imx-sdma: use common config at dma_chan
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-dma_common_config-v1-4-64feb836ff04@nxp.com>
References: <20260114-dma_common_config-v1-0-64feb836ff04@nxp.com>
In-Reply-To: <20260114-dma_common_config-v1-0-64feb836ff04@nxp.com>
To: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768410779; l=2289;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=HMxUaQN43fsTwQ617LIAHiXWsPUUzYeGGhCwt0b0eZA=;
 b=tpIErUEZu0mmk3kEFyDLrR0J9egLltsP0QN/UBF8nun92GY8jshHzdkF93Sokk/ClsuI5BrQs
 8Ae9qB1Pq6eDfYZHeqomoN5TYEvkcJHw+BM1QQ6Jc1lSPdbM5tB4gFq
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY1P220CA0015.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::10) To AS8PR04MB8948.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8948:EE_|VI0PR04MB12155:EE_
X-MS-Office365-Filtering-Correlation-Id: aaf57ede-9843-4df2-825c-08de53903761
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U1hjWk9UNnA5NDBMWkJoZlZyT1luY3cydlRxZDN4bTRIZ0hIUDN1QnpyMW42?=
 =?utf-8?B?eTdVVVBIR25TWlNkRjhEdjRYUFArQnpEcmtRRGxmVldiYWNwRnJrR2xKNGZa?=
 =?utf-8?B?OEoyaTk4VUZ5STJiRlRSUmZJTmRGSjVwZVIrTHlQMU5HTWY2TGtkYjlEWkZo?=
 =?utf-8?B?Rkx4Ym8xUVpQWDNlYXo4QWxBalZNYy8vMUJDa0ZMTlBFWXkvdVJmQ0R2dXYr?=
 =?utf-8?B?MFlzWG5OVzZNdmt0WjZ3NHJZSjJudkM1T01kVnByMVZBZTRHV2ppV3RjK2pT?=
 =?utf-8?B?WkNuTkZIckkzeEVTWUwvTE5ybDNOMHJXdzJyeDBkZ2MydW85VVRGUS81N1Ja?=
 =?utf-8?B?TDBZSitCNm9yb0kyYjVpOUpaWDV4ODVYeklMKzhTUkxOcng0VTZDZ3ZQcHJa?=
 =?utf-8?B?ZG9ud3M1QzdVM2IxTXhuL01ObHArUUxEQ1VyRkc4S1o4SjBRU0huU2M3WjVU?=
 =?utf-8?B?T2xIaHNlc2hpRDlTTnhtN1lQL1BkYnJZYlFCYjZ2NG95ZnVteWI2THIvLy91?=
 =?utf-8?B?N1NtdENoeFZ1ckVlQVdHa2gvOWVkNVVoTzhpQXdXRkI2UUk4YnJ5WTBTcGJ2?=
 =?utf-8?B?WEVMNmVFeURvZEZtdVdic0p5ekNMZHJxM3htZkgyTDNUalI5SWZGaWhTVWxz?=
 =?utf-8?B?VHZZcnptSHNVbmZjblBicmVzK1Z5WXJSTHNjMFpxUXJiQmpmNWprT3ltWnNL?=
 =?utf-8?B?dW9FU01FQjhYNE1WQUZxbmFGU255WXR3c0ZkWUxDY3c0ck84d2cyN2NWV0pl?=
 =?utf-8?B?S3Bpb0JyUDRtU2xlblhlcmhYRzYvR2xHZHNXSzhRbFVHZUxjTmRhV0lKbG9D?=
 =?utf-8?B?MTg4aHZseDEwWnNIbkd0YlpHQVVjaEhMV0p3Y3NaUVZSbm9OeWRWZDUxWXBC?=
 =?utf-8?B?bXp5TmZOY2NoM2o1bmVGaVFMSXJJdmMrWjh2ZUh3enFMNUlWODMvam4xWHN4?=
 =?utf-8?B?cURackNtT0pEVEZ3ajc1ZlIxc3Q0WkUrd2o5dFlGNExJR29jNzVUMUkweFU2?=
 =?utf-8?B?RWpSNEEwVGpPckJCT2FHbnFGb1pjNzdoMVV1WHdYZ3ZxaHZQS3dSbllTZXYr?=
 =?utf-8?B?SGY2WHgxb2pMTnczUUJUQTBQQXQvSHdGbHNmbjN2dHIvdE1qZ1I3VmNTa1dT?=
 =?utf-8?B?OXZKaFRmeFFQUElDY2xNU0ZvaHV4bUVkdjFBVE9wMWozTS9rNFljSnZSK05s?=
 =?utf-8?B?RHRoSENSZS9DdGc1bzVMdno3UnlDTVVwVnhYZU5PcTRSNFV4K1kxcHpQNkNV?=
 =?utf-8?B?bFpaTzFTZk9WdHBYTlg0NFoyZGFZUnJ4cmwxRTNXc3NvNzBSSnMyNFZidllw?=
 =?utf-8?B?Rml0MWhPbUpmR3k0Y20vYkRicm9mR21LcjRpN1RRVVJ3UDM0eHRkL3JiWmVQ?=
 =?utf-8?B?OGc0TGNtSGtxeTROazVXQ1JkdTJXN1lTcWRVTTdUS3RIUVpjcEIwUEs3VU9y?=
 =?utf-8?B?U3BnLytUU0dPQTI4cXRYd3Z3Vk52bjJXbFgxbENGb3Z0U2lXM1VMYVQ5SFlC?=
 =?utf-8?B?K1ZKWWUvK05XUnJXSTdMMzVIWmduNmJIb2ZQUnpjME40NHgySmxMcGhFWlMy?=
 =?utf-8?B?VVJFVFhnU1J1T2FSVmlFODhteTNkdktxVHJVdThMZG16VTVrSGNMT3Y3VlB0?=
 =?utf-8?B?ZjZzeEVQQUx1OG1VY2hlQlMwc2JjazlkME81bEprVjlZQXlXb1FZOUpyVjJq?=
 =?utf-8?B?VjhPUnJMWnNQdGQ4U1pZNmZvUWtYZGR4d1FoenBGNWh6Y3ZDa2pOdmhaVEZs?=
 =?utf-8?B?bkNFY3JqR2xZQXROWG5vMjJzZUQzMWpNeWc1QVB1by96Ky8rNUg1VW9ORFNx?=
 =?utf-8?B?azF4T1ptbkNFMGdBL05kS2haYTZxeDQ1VFRReW8yQTJycHFFRU54aVJzd1hR?=
 =?utf-8?B?OWhNeEN3SUxuSWVZcWFzRUtxZzRPVDRSWWlkMGlxb0J5TkwwQktHaWU1dEZV?=
 =?utf-8?B?Sy9TUWpwZ2p3NjdvQlY3bW9ud3o2K0tjL3hRU1ErTEZ0MTVsZTdPbXJ5aVpz?=
 =?utf-8?B?ZXV3MktNOFVOTUlaL0NJT2dHa0dCbm5heU1QaWc3amF6dEluNGg1UlJuMU1a?=
 =?utf-8?B?MURvd3IvaWlKcXBpeXZmekZWK3E4RmZQVXRoblV4TjVtWVB2eFAydkU2MDJh?=
 =?utf-8?B?ZFp1R084Rnh1MWZhbFljMjRYeWVvNjZ2TjVtOStzT2lYVmd1Qkc3dTBqOFQ3?=
 =?utf-8?Q?Oh/Zr5FBCwHcNQvv+Kvs2qY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8948.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SjVUcWF0WFpISFpFQm1pOXJGcGJGZklob2ZydCs0c1ZKZTFUV3EzK3YwbHQ4?=
 =?utf-8?B?eFRIcy9RS2dWWXZybTlYTmVNejBSLzB3RUtJem8zVUM4ZkVhMFFFTm5HeWVF?=
 =?utf-8?B?YVZYKzBDbVdpM1Awd1B4dUFQd2Z1UVhnWXQ2YWJYNFpjTGVnQjdEY0gvcHN5?=
 =?utf-8?B?eXZVRGVqWWZ3SWwxc1lMQkk2ZGpYRng0UFQyRWF6MC80RU9WOWZwcUdHY1RO?=
 =?utf-8?B?Tm5aQTZvK3cxQ2hobDFselJMbTd5UE44MWdBU25Mdmc4eXYvaVRibXdZUWdl?=
 =?utf-8?B?TzI4SzhCVUoycmtkaGdoSktNeDJwYWF2cGtrdnV3eEp4WUduK01UNitYczdo?=
 =?utf-8?B?ZWtOU25RTGgrM1F0N0RhN1BSU3VIOWtLYlh3bkU0ZkFnaDhqL012TFArYVc0?=
 =?utf-8?B?UzIvVFplc3NEaUloY21BTDFkcEszRnF5eEI2MTNBWGluV09Xanlla2x1UDRt?=
 =?utf-8?B?TE1XU1AvU1gyQ2FPdlRFdzBDS0RXMDl0bzVVNTVscXZYVi9FMDgybjVEWTFw?=
 =?utf-8?B?ZmZKbHdFNzVHYWVFRC9kNEZ1S05TZVNVeFVCc05iTVA4dG9MNFpsMkJ6cmN4?=
 =?utf-8?B?ajI0dVRnUmZ5ZjlUTHdKUjRzWFQydDNpWEtkRGJYNHVhbnRrd01GY29WWVYx?=
 =?utf-8?B?eU9aNWUvNlRkUHk2S2s4Rm9xTWxHcHc4dWtuRng1TFI2RXErZ0NYaE0yS3Bp?=
 =?utf-8?B?T0FYdGMzbXZaSEhOVXA2bEZzdklYeGNFbEhnL1VDcGkvYWh3aHk2ZlVXRlZV?=
 =?utf-8?B?U2p6R29MejdldWRBankwbDJVam5GM2RXT25Id1hrQ2lUSmJvQi9mSm5hZW05?=
 =?utf-8?B?UUdTV2hEVUVmRTZ5cTVRUmh4YXArUWQ2WjR5bnFNR2RsdEZtek04SWlMMlkr?=
 =?utf-8?B?TytoVHVBSXAyc2FKbnZuNGpaSDBObVcvdGRTYnc2OHpKRFY4dHpYK0pnN0Nl?=
 =?utf-8?B?SXFIOFZvU09uT2ZYK0hUajEybSsvU2U2NkxVUnVxQnRlZU9uQThVK09LaXhQ?=
 =?utf-8?B?ZXA4NWZGZG1IVldIcVhWTDZoVlUzQWlwQXdvenpmSE52dnZ2YWgxUnRRWWRK?=
 =?utf-8?B?TDBiY1V1VWJ1eUttUC9aeTM4MTk0WElxWDhwMjV6NzE5d1FZejVsSEhDY0RH?=
 =?utf-8?B?QjNrMGRYSVN3b3U2RHJKa0Y1UC9yQTBXc3BsYWhmcG13d05UeVQvdWgrWEVx?=
 =?utf-8?B?eW9DZmNVZmxSeUtMSkNyU3ArRGhFdXUzbzl4THV3YlQwNTd1SUNkcUhMRzZ2?=
 =?utf-8?B?TDdHcUNjRm5yUHhQQi95bXkvVTY4UzdqMk0yR2xmMkh2eHhpN0x2WVhXOW0z?=
 =?utf-8?B?QlN2RW1tS2xsMVBuM2YvcUI4bXZJaytTQTBRdzBrMk81UGttb3h6cDE5cGtN?=
 =?utf-8?B?RDZQeDl1eU40dENxSzlVRGZ4bmNBYjBBMmRoSGk2dW9GSW5semNsUnN3YlJ6?=
 =?utf-8?B?UWtDeGJHRVFYWkxxbWQwNFBUZ1d5UitVeDVnbHg5UGx1eldsb05mSVYzUzN4?=
 =?utf-8?B?VEV4TzZrcVFLd0hjRFp3NGd5R0s2QTlSeUxsUlNnVTRDcGdDbjZCaGtEQXFa?=
 =?utf-8?B?V2lsa05QenZENXdxQTNFUmNVWWVUSG02aDBDdngzTWw4NnhITzB2MkpIL1gy?=
 =?utf-8?B?QkdvbGR1RjZycEMzVmVpZEdUbnZ1dDU2elhkbkdIdnM0Z1JGTlZFQkJMQjVT?=
 =?utf-8?B?TXJSV2pNdFRTbmZkSk4rdDU3cCtIRjZLMmR5T1BVMlNVRUQ3QVdHT1ZReDd5?=
 =?utf-8?B?VlhEVlh0MGVMbG1PRXE0K2swN3l0akNQbmIxWGtTejRmV25RekxweFMvTlhX?=
 =?utf-8?B?UnZKbE53bGFDMzdQeUtqQWQ1K2cvdGhBeWo0Njh5dUFPT09PYW1YSlZ2T2ov?=
 =?utf-8?B?dVNnZU5EUERTTjh4c25BbkdJOUo5TnVIR3E4TEtwellzd2JVUjM3cjFKSDZx?=
 =?utf-8?B?TGtLdThUQU1MY243S1pqN2NQODkxank4UVZ1dElxVHdsbVZ6YkVjU2IrYWF3?=
 =?utf-8?B?OEpmaW5ZVzY4RHZ1L1J2blR2OGEwb250UzhUaGlkQk1jUkpxR2hjdnV1RDBS?=
 =?utf-8?B?MWs5Yi9tVEtvNzlxbzhDMHdxU0szTDh5VTE1cXp3YWlVaTZ6VHhTbk8rekFn?=
 =?utf-8?B?TXM0SEMwZXk1KzVOdnRtOWUvTHQvcm1oaFpMUUJPMCtRNXorNGpCZzgvRlhi?=
 =?utf-8?B?cFppTENNLzhZNU1wbkpFTmZPQ0YwVnBWcnh4V1FvWXNaWEVrRjVvUVhaOHVK?=
 =?utf-8?B?T3hGdUExSFY0b3pwVlBrREthdmU5SlpBTzBzd0RWODcyNHRZbkVPZkVINnhD?=
 =?utf-8?B?SU5DSWVKZ2s3WHJORTRscUl5Y0RBY3UyOVdWYXJPdVdiZWtpQm5KUT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaf57ede-9843-4df2-825c-08de53903761
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8948.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 17:13:20.4456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j3P9FtvCqWmztxnK23wJRZvcrHDK2Kvvjp/g6GlslNg7zD8/decCOqZ51WwmX12QNLQK5yGUuIcWaLFgNMyzvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12155

Use common config at dma_chan. No functional change.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/imx-sdma.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index ed9e56de5a9b9484c6598d438f66a836504818be..13a9522eb914bd7808a079fd661d99e8fcff6a0b 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -413,7 +413,6 @@ struct sdma_desc {
  * @sdma:		pointer to the SDMA engine for this channel
  * @channel:		the channel number, matches dmaengine chan_id + 1
  * @direction:		transfer type. Needed for setting SDMA script
- * @slave_config:	Slave configuration
  * @peripheral_type:	Peripheral type. Needed for setting SDMA script
  * @event_id0:		aka dma request line
  * @event_id1:		for channels that use 2 events
@@ -449,7 +448,6 @@ struct sdma_channel {
 	struct sdma_engine		*sdma;
 	unsigned int			channel;
 	enum dma_transfer_direction		direction;
-	struct dma_slave_config		slave_config;
 	enum sdma_peripheral_type	peripheral_type;
 	unsigned int			event_id0;
 	unsigned int			event_id1;
@@ -1647,7 +1645,7 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 	struct scatterlist *sg;
 	struct sdma_desc *desc;
 
-	sdma_config_write(chan, &sdmac->slave_config, direction);
+	sdma_config_write(chan, &chan->config, direction);
 
 	desc = sdma_transfer_init(sdmac, direction, sg_len);
 	if (!desc)
@@ -1739,7 +1737,7 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 	if (sdmac->peripheral_type != IMX_DMATYPE_HDMI)
 		num_periods = buf_len / period_len;
 
-	sdma_config_write(chan, &sdmac->slave_config, direction);
+	sdma_config_write(chan, &chan->config, direction);
 
 	desc = sdma_transfer_init(sdmac, direction, num_periods);
 	if (!desc)
@@ -1838,8 +1836,6 @@ static int sdma_config(struct dma_chan *chan,
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
 	struct sdma_engine *sdma = sdmac->sdma;
 
-	memcpy(&sdmac->slave_config, dmaengine_cfg, sizeof(*dmaengine_cfg));
-
 	if (dmaengine_cfg->peripheral_config) {
 		struct sdma_peripheral_config *sdmacfg = dmaengine_cfg->peripheral_config;
 		if (dmaengine_cfg->peripheral_size != sizeof(struct sdma_peripheral_config)) {

-- 
2.34.1


