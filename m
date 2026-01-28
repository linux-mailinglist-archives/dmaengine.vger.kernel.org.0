Return-Path: <dmaengine+bounces-8567-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDlEEjRRemnk5AEAu9opvQ
	(envelope-from <dmaengine+bounces-8567-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jan 2026 19:11:00 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1DEA78A4
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jan 2026 19:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4130A302585C
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jan 2026 18:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2DA378826;
	Wed, 28 Jan 2026 18:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XY7JJicm"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013046.outbound.protection.outlook.com [52.101.72.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20933783DB;
	Wed, 28 Jan 2026 18:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769623573; cv=fail; b=UG/YdtVSMlnmZCj3hv3tesi8q5kCWeYqvF9WiHTjV+uSpqBV9dPzPtlSLfasCFrNWIchGR3RSkVQSE19Dt4ur2o3pwaVdTtM9BKJwEExTQU8BWmZwzIpUW/oNs8VNMaQWT5I8PMmoLH8ZjWHGChkjiS6ippZD4Y1N+cywUblJVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769623573; c=relaxed/simple;
	bh=wOXQMNIzbVOutah0EmLhmjIneZqWHqMTuYUyly6i+gs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=i+/1P622yBjjb56/hFitDmbsB+l7nJ0S/il7Wa1+SMaUUwoW77chluBZUR/PgUTnLbTFdWIO25HajZo2UBTQ55Tq1+D3NEQaF8SIhgtrsPVMBLAsUrjdv9qSzFyVTTPHoSePw0V4UAYJPlmF5YtOkk0Pu8HyqlT/J3eRKlWfazw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XY7JJicm; arc=fail smtp.client-ip=52.101.72.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oW0BA2bF88G6ATg5y4O3x1dGEv76HszuNhs1zgx0f48h2i3wG7tPcAzLT8QtgXx7GfRsj6Pv+DHtcqTnDxUH673qD2UJhRvMnhWWg94vaZuoBekFuR/UF+Ux6bNyRXWcucZgrUaoFbDWH4KQuatVS8e+c1DltjaGo8pnPoJD2vHT+xclEdaCo7C2ao+5dUEI6e4PpzW82AVIG2OS0zGUO4WefNhTRDwhSZCBRoWS6ZsoiwR/zL/dLISYPl1Df/P6w19PRacIfY28LLiWxTt4Jn0qW5VyTQKyFwgOBDs/LjJfF5+YC1KMMLhCusXSlv58gRy9hhydquC+DHKPTNhdog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O91igY/QhRawhuVExvoeVFdm8g0MsNxV8roTZdvm3yg=;
 b=d6xlSkmLIbbe7CphIxgsKDO2RrOk7PfkMbQqGA1aOj3kFGcA+pbzQPxrxhlKgifEakCNEeNvaUuXJZKXCXqww3mGxuPvvm0jkCkKAgFcbPEYQJzsGADMYJidyTDzbwdDBrK/xWtcFC0fh0GX559yYgRKZHfE8A+kI/J+MusulooYtguJr3jb6n13UapaD/Db2ZEcFDOAJcUacMCcWO82J0qHgdX6kr4HbQsk9xolA/5Ul1NPMYErF0lDCtCTqjcIcR4jDgMZP9SpmKHIAsWJx2yJF4uRWJyWGqrbRFUTmxhpDzVHz7314VhG/x+7VKHueNYU0QowVvrzmVPvkJDX9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O91igY/QhRawhuVExvoeVFdm8g0MsNxV8roTZdvm3yg=;
 b=XY7JJicmEYP1mx6+dowXcU+5VCR6NMEByLi5SMeN75whlBlRmWW73tED+Wp2Iyua4lJWdLSpMPgyqkYuNuf/uyILUQ/Jk/2eI3/z/Lx4xcTcLDSVgWYUkmwSgmRGfD01hDIVwj40CxZeTJ+mbwAZ47qwg6sUd0kA64a5PlybttaXi4FXQFPTEXQrbdAUTggw0yBF80rAWSfGmxk/Ro1iN3VhCUweGgicjKFP33EoPp/WXafrq1VjvjqKzl8jt0nxBP2buWWjbJ5BomeiEmlqNOtqoIOKmEYDx8mQAkM/e5Qd8x1kx3L1DpSeC2CYbMBgdf3zMi/ynljtmNbEf3tujg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM9PR04MB8145.eurprd04.prod.outlook.com (2603:10a6:20b:3e1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Wed, 28 Jan
 2026 18:06:03 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9520.005; Wed, 28 Jan 2026
 18:06:03 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 28 Jan 2026 13:05:29 -0500
Subject: [PATCH RFC 10/12] dmaengine: move fsl-edma dma_[un]map_resource()
 to linked list library
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-dma_ll_comlib-v1-10-1b1fa2c671f9@nxp.com>
References: <20260128-dma_ll_comlib-v1-0-1b1fa2c671f9@nxp.com>
In-Reply-To: <20260128-dma_ll_comlib-v1-0-1b1fa2c671f9@nxp.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
 imx@lists.linux.dev, joy.zou@nxp.com, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769623546; l=10194;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=wOXQMNIzbVOutah0EmLhmjIneZqWHqMTuYUyly6i+gs=;
 b=ZZJT836zlVqGJWpbJbAAvxYJNVAdGySK/XqskzQkW/EUaGd+tGTy8EsD3+PPlwn/aI9WhVEIV
 SsB5MY4+p5/BOnwmb6wqFMIc/5RWJDg+pf30OODoFtCfh7JaeBXIKWa
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA9PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:806:20::14) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM9PR04MB8145:EE_
X-MS-Office365-Filtering-Correlation-Id: 81e7129a-ca19-4173-9aa2-08de5e97e63e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z3NHR2xMNnRaQVhmSkl3TFBkSzhlME1raVl1Z0dSVTg4dVFOVS9halZHc2lL?=
 =?utf-8?B?ZU1neUNuZWRyTEtGUUwxNDdneDhlWXA2Zm5GYmtjRFlKZnV6K1NBMU56VEtI?=
 =?utf-8?B?dmpZNkFtOE90NFA5Vk82ZWVNTDQrNlhGL1BWOXB4TncyczBVdE5KSWJoN0l0?=
 =?utf-8?B?akgxOGlXU0s1TFhiMWlNV29rb2pxaHp3K1lMOWVHdDhpQXhqL0Jwa09sZjE4?=
 =?utf-8?B?L3pnMWpOanlseEU3YVdybU82MnB2bVUyZERhbUxwRkhhTHgrZDBTNlFHRWhK?=
 =?utf-8?B?czNUY3VOZ1FVTURDT3htN2tCMllDVDZwQUdRclZvcEVHMzNjVERodVpmTmFV?=
 =?utf-8?B?MFNxbkJUbmROTGxTZm9ISSt2TFZtT045R2MvNGdwVHZWNDh6cU1pbm8yZGlC?=
 =?utf-8?B?Q3JyTkZxa1ZVcmZyNlNlUWlpVlAzMDdLM29vUzBvQWhIdEZoNVRCNW1jWVBi?=
 =?utf-8?B?dVJjL3hPK3ZsNm9NeEtIcUR5THZYQjl1MUFyaGwwQjc1V2MyUTcwaHRueFFZ?=
 =?utf-8?B?QnU0dXFxUXAyRzZNU1cyR2dzWkNsZ3ZNN08yYnpBNm9EY0QyeU9HcWp4d0pB?=
 =?utf-8?B?cStHQnppeituQ1JBK2ZVM2NSaUs2dFNoRkdlUy9nWDdGT2JZd1ZaKy8zeHV0?=
 =?utf-8?B?QkZuNWZuRUNnTlhLYmlveEswUHhGTVVCUnU5cGNRcmYrOG5OVU5ibGpQZS95?=
 =?utf-8?B?aWU3a2FzdTRyczRwRUM0WWJTSGVIQ2o2UTl3QytOV3VDZkgrWXpCbDZyelBa?=
 =?utf-8?B?N2JDa05tUU9PVVBCT09KOHNVaUllRWFvbDE1M0NsL3BhbUpzWUNNYjJ3V2Vi?=
 =?utf-8?B?TENQdTFnT3B4elIyOHhUVGNURTlXMktvTTB6anhsYy9tRUFMNytlemJZTit6?=
 =?utf-8?B?L1VkM0RJdHkvU29XT2hmcncrcE1tN21NUk9VbE00RDR5bWZaK2pvc1N2UFpV?=
 =?utf-8?B?TzNLTEFOQnIwYStnSC9QTktGVHhZVFlZSkJoc21RYkFYNGVpcTFtOEVseERN?=
 =?utf-8?B?cGxkanVJSDZxdWc3dTh0ek4xUHhXdmFZR0pTTlYza3hsRVFLVGhPOW9va3Bn?=
 =?utf-8?B?dkpHbGl3NkZWemFrZTlVbE5lMi8xSk96cFJqV2pvaE8raWdXbFp1TUlGYnEv?=
 =?utf-8?B?UkxoL1d0OXlZYTk5c2o5QndFRGRTTDNWemgweW95V2xhM0Z1M2FZOXprNFJR?=
 =?utf-8?B?dmhFK08vM3BBN2svVm5ONVZ2SlB3NUd0Nk56NE4wR3d1R3FYajFtUUdxYk56?=
 =?utf-8?B?enIxM2lqMnhqM2xYK0VZdGZsdng5UG8yMTR6WEtxZ2twWjBkUmRaVU1oSS8y?=
 =?utf-8?B?VFBSSGRaemdqTVJtZ1duNWFsbXRSWGZzOHZUSTUwMVNzNlhtaXJUVHJURHRz?=
 =?utf-8?B?VzZGZTBudDRLeVF2dE0zSThuazhuQ1hwSUZ1Qm12UzJULzZIaU5KMHhFQUxG?=
 =?utf-8?B?QWNOVzZwMkM2Uk9jRW1La0d5M2V3UjhZTWlPQUhSZUNwenprakY1dmVBYU9N?=
 =?utf-8?B?R2JPSFBGNm1LaHZMU0pJS3Q1WXB1WkhWWXZ1emhKNFhJOEhGdW5IcFBNWXNP?=
 =?utf-8?B?dHZwUWE2QWVPellQakJpcm9hVzF1ZHJ2L1V1eEwzOEpXYUxOdk0rL0RDOFla?=
 =?utf-8?B?dVZkREpIWS9oenJoTWo5WllIcVd0Zi9YREE3UFFKaVhWV1Q0NmdEYTUzdWxi?=
 =?utf-8?B?dll0TkorSkR6dDl2WmZjc28xMXRwTjdJd1RnTEYyWlM5M3hVamFyYmdWSVcr?=
 =?utf-8?B?bWE0Mzl3S1NGUGpCNnVVbjY1N283a2lIUmxXSUg5Z1pISGZNNGtiQUJoREtH?=
 =?utf-8?B?dVZidUVVU2oxQlZrbmpuZTN4ei9yODZVYkdxTzRzUWc4MzFqaDRzbWJqUGVk?=
 =?utf-8?B?VFRWN2ZVdWlWdVk5ZmtyZDVRZkxIbi8wU210WHJRdk5RNFhyZytldjZFMWd0?=
 =?utf-8?B?SnQ5ZklFalNjbExDeGxBdkZEQXVoSVdkNzg5MVg3Ny9nT3JtR2JYcmlrKzVC?=
 =?utf-8?B?azdCaXFySEQ0cUYyS25SMFpmKzM2QStUSzltUGt0SGtUQ0pIWlNaY004M0R1?=
 =?utf-8?B?NldmaEl3MUZJWldpSVR2cTlpT1lpUkNrZ1BCcms3V1JvWGZRN1ZJV2FtL0Rj?=
 =?utf-8?B?d3VtM1NydzhtRHRJRVJiVEhjbGJhT1p0ekNyNS9iSDZwNDY3Wm41V3VtdHFi?=
 =?utf-8?Q?X7b1Co4Q8MPU+Lq3UwyxbXA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHA0eFJFZWFIT3VIbERXdkhHc0NUejFhVExhR3V3NWM0NHluSFpkZ3d5Zll6?=
 =?utf-8?B?aXdDZW9XMVJQYnJZTzRhVXdWdXMvd3hFaFFjZEV6SjFDWkd1ZHpkZUh0OWpO?=
 =?utf-8?B?SFNrK0xjUTJuQi9XNUhqUkFTTWViZVhGRDJnYXdYOHFjcnd0NU0ycmJDS0tp?=
 =?utf-8?B?bXYrT3NqSGk0NGxUaCtJakxwZmxWcDg0dGswS1Y0eFNjUVVIbWVndElCTUZv?=
 =?utf-8?B?L1MrVHpOaEVvZmU0ajhQS2plOVJuUFBudldRb0U0VEtDZWNtZTZrckM0U25J?=
 =?utf-8?B?cTlCU0M1WHc1UStaTm5lSXF2WVFScEorZVl6dDZQL1BnRGd0NkJrdDdiTTk0?=
 =?utf-8?B?dVd5N2RPZWJxcXQ1RzZEWWQ1TnZyaFViaUVsNVFjTVNuRHJtbTlTSUFqSzhI?=
 =?utf-8?B?Ukg1T3pmRFNCbWtDeFIxdnV0eW5YU0Fad2hFUGxqK00zQUI4TDFIUWd0Kzkw?=
 =?utf-8?B?U2ZmdDh6bktFMDhYYUVIRlFqbFJhbUxWUEc1b0pGTmlXa0tlbVBKTm82Sjlz?=
 =?utf-8?B?THIyQlZQaUVqbE1ESUZOcStSdDkzYk5LRVcxSXpvYllDMUJ2RG1vKzBzcEJn?=
 =?utf-8?B?UW1VN3pLbGRqU204WTZHK1JZM05PcW9LanI0NllhSlFlYjlNQ1RnWi9LNHdp?=
 =?utf-8?B?MlhZcm1JcWJyQklZT1dmTHBtdUJBYlk0c3lybk9kYlhLNnVjdk9xNHIxYWFG?=
 =?utf-8?B?aWFZSVEwMTlQcXBBNGI3VEE2VkdmdDIyRm9TWDhTRVBlNTVLSHFYNlppNjZt?=
 =?utf-8?B?TFdJbit4d0dhMDUvanBreExEL3hNYlJ5MHRNQm0zYVNwSjhXQkNXaEpZTk5y?=
 =?utf-8?B?dEg0bWVyM3VTYnI0dzNSSDlhQStONDFUTTMxM1VScnVlSEVVbHo1NXNrZTIv?=
 =?utf-8?B?WWozbUo1anYxSW5YL25Ha3JUTEU1bHdJb3ZnZWJZSjZkKzVFZUhVYlp0MEI3?=
 =?utf-8?B?YmJjOXFQRnBZa2dWU3BKcGJ5dDh1QjdkeGE5TU1yVEVtZXV4SDhBK2NacThy?=
 =?utf-8?B?QTVmZWpSZ3QvNVlWQTcxL2J2L3hPMTg4WldnVHN3bDkwTGE5VlFtMzUxNkVx?=
 =?utf-8?B?RkVaNXhPb0E0eFFweE1hRldLbXpuRUE2RWNVaGQzYmVTdTRjRk96a2J5Zk1K?=
 =?utf-8?B?OXJqa1pvZVQvRWRiMFpQSmk1WTdhL0wrOEZQRUpDY0M4cHJIelBHdnk2TFNP?=
 =?utf-8?B?WGd2b3ZFcXVGWGxtOVdQSjFXRm92Rk9tOG41b0tMWXIvYllIKytwZDJLWm1Q?=
 =?utf-8?B?TVRKOUQyRmlEYlZRb3FNeW1MYUFxYVBNekprN1pTVVBaVUtCYWVINncwMnZY?=
 =?utf-8?B?cWEwK2t5UmJJWS9FbTdBa3l4ZzJCaUZwSFF5Q0pjM3p5eVN3Um41YStpL1pI?=
 =?utf-8?B?K21jTjhHeWhTRXZKR2ZQWURvTkFWcHdFY1V2Y3Ntd2x2WXMvQStiK0plOHJY?=
 =?utf-8?B?b0tjTzZzUHBGeDR3eWkzbmw0ZHZKc1FzL0lMRGwrRWllblhpT0lLZFJWTTB0?=
 =?utf-8?B?SHRLalRHajNXNDh0cys0TXU3TWQ2TzFMWVhJWUJoaVRYTnZqeGVzdUxWZ3lR?=
 =?utf-8?B?UXM3Z21mVFFZR1lrci83eXRnbVdWQ2llVkZFMUpRSit4T1J3VElLVEcyZU54?=
 =?utf-8?B?S21STDZrOGRJMnhwMFVodGFJcmFYL3V5bkFVelh6SGloMXVtWU1wRm1zMHlo?=
 =?utf-8?B?MnRUbjI2V2Q2YWZEUjZPOXhtVzlVZzRmTmFoWWNHaExVeHhlQ29nZkhpc1B3?=
 =?utf-8?B?aGNzY0xOam8zTFBMVW9HTEFJMnI2QzgxSVkzeStBeXdpRVhXVk1WSHZWS0Fy?=
 =?utf-8?B?QVFWNU1Ma3MwVWZwMUNkRmovaGlzODJXWitSODRlR2lpTmpJQ04yRjJsbGwx?=
 =?utf-8?B?eVFxMDhSVmNPNUZxTjZkQjFnSUVKKzQxbHRrT2VyeDhLbVJtNHRtdkYwZ0lY?=
 =?utf-8?B?anIrZmtlZHNUMHVqdFovdHJQUTJtZXBONTB1U3hOYzFTZTAzQkhwTXBoVWor?=
 =?utf-8?B?eURVcUZ4d3lybmxaWG8wRDRVNER5SnowNmlCWGFaNDhjZDd4WDgrVkVZZkoz?=
 =?utf-8?B?YXYyWUZvL3BvcEE3ZkRCaTVRMFF5dm1McUc2SjQyZjdJVmZab2pPNTFoU1RK?=
 =?utf-8?B?UWxGSy9nQndyNi9pbHdnaUMvRUx6N3dqcGtjUkVGblpPMmVkSmpwRjlzTEk5?=
 =?utf-8?B?QnBvekRITmJYb1A3dk9CYStGY1BoK3dtaHBYbFZtZVlYb0dlbGRFZzdDWGFW?=
 =?utf-8?B?YmRCdEFqYUthVmo1Um9WM2dXekxWYUl1ZkV6Um1vcTJLTXp2eisvZVJXV2hy?=
 =?utf-8?B?ZTBWa202dGdUQjdCU0RIOVVPWHIwdnNLNkNITzNiQ05uK1doVVg0QT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81e7129a-ca19-4173-9aa2-08de5e97e63e
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 18:06:03.2399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BNIm1kDDJGpXZIes2VVFJOMWzGxc3xepm/i58RkTGBtUKbLO0kOzQB6Ftzfn72FZtFkPdLGGWSez9BsWh4dJ6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8145
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_FROM(0.00)[bounces-8567-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@nxp.com,dmaengine@vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[nxp.com:+]
X-Rspamd-Queue-Id: 0F1DEA78A4
X-Rspamd-Action: no action

Move fsl-edma dma_[un]map_resource() into the common linked list library.
These helpers do not touch hardware resources and can be reused by other
DMA engine controller drivers.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-common.c | 85 +++++++++----------------------------------
 drivers/dma/fsl-edma-common.h |  2 -
 drivers/dma/ll-dma.c          | 64 ++++++++++++++++++++++++++++++++
 drivers/dma/virt-dma.h        |  9 +++++
 4 files changed, 91 insertions(+), 69 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index a8f29830e0172b7e818d209f20145121631743c3..ff1ef067cfcffef876eefd30c62d630c77ac537a 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -264,65 +264,9 @@ int fsl_edma_resume(struct dma_chan *chan)
 	return 0;
 }
 
-static void fsl_edma_unprep_slave_dma(struct fsl_edma_chan *fsl_chan)
-{
-	if (fsl_chan->dma_dir != DMA_NONE)
-		dma_unmap_resource(fsl_chan->vchan.chan.device->dev,
-				   fsl_chan->dma_dev_addr,
-				   fsl_chan->dma_dev_size,
-				   fsl_chan->dma_dir, 0);
-	fsl_chan->dma_dir = DMA_NONE;
-}
-
-static enum dma_data_direction
-fsl_dma_dir_trans_to_data(enum dma_transfer_direction dir)
-{
-	if (dir == DMA_MEM_TO_DEV)
-		return DMA_FROM_DEVICE;
-
-	if (dir ==  DMA_DEV_TO_MEM)
-		return DMA_TO_DEVICE;
-
-	return DMA_NONE;
-}
-
-static bool fsl_edma_prep_slave_dma(struct fsl_edma_chan *fsl_chan,
-				    enum dma_transfer_direction dir)
-{
-	struct dma_slave_config *cfg = &fsl_chan->vchan.chan.config;
-	struct dma_slave_cfg *c = dma_slave_get_cfg(cfg, dir);
-	struct device *dev = fsl_chan->vchan.chan.device->dev;
-	enum dma_data_direction dma_dir;
-	phys_addr_t addr = 0;
-	u32 size = 0;
-
-	dma_dir = fsl_dma_dir_trans_to_data(dir);
-
-	addr = c->addr;
-	size = c->maxburst;
-
-	/* Already mapped for this config? */
-	if (fsl_chan->dma_dir == dma_dir)
-		return true;
-
-	fsl_edma_unprep_slave_dma(fsl_chan);
-
-	fsl_chan->dma_dev_addr = dma_map_resource(dev, addr, size, dma_dir, 0);
-	if (dma_mapping_error(dev, fsl_chan->dma_dev_addr))
-		return false;
-	fsl_chan->dma_dev_size = size;
-	fsl_chan->dma_dir = dma_dir;
-
-	return true;
-}
-
 int fsl_edma_slave_config(struct dma_chan *chan,
 				 struct dma_slave_config *cfg)
 {
-	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
-
-	fsl_edma_unprep_slave_dma(fsl_chan);
-
 	return 0;
 }
 
@@ -611,9 +555,6 @@ struct dma_async_tx_descriptor *fsl_edma_prep_dma_cyclic(
 	if (!is_slave_direction(direction))
 		return NULL;
 
-	if (!fsl_edma_prep_slave_dma(fsl_chan, direction))
-		return NULL;
-
 	sg_len = buf_len / period_len;
 	fsl_desc = vchan_dma_ll_alloc_desc(chan, sg_len, flags);
 	if (!fsl_desc)
@@ -621,6 +562,9 @@ struct dma_async_tx_descriptor *fsl_edma_prep_dma_cyclic(
 	fsl_desc->iscyclic = true;
 	fsl_desc->dir = direction;
 
+	if (vchan_dma_ll_map_slave_addr(chan, fsl_desc, direction, cfg))
+		goto err;
+
 	dma_buf_next = dma_addr;
 	if (direction == DMA_MEM_TO_DEV) {
 		if (!cfg->src_addr_width)
@@ -649,13 +593,13 @@ struct dma_async_tx_descriptor *fsl_edma_prep_dma_cyclic(
 
 		if (direction == DMA_MEM_TO_DEV) {
 			src_addr = dma_buf_next;
-			dst_addr = fsl_chan->dma_dev_addr;
+			dst_addr = fsl_desc->dst.addr;
 			soff = cfg->dst_addr_width;
 			doff = fsl_chan->is_multi_fifo ? 4 : 0;
 			if (cfg->dst_port_window_size)
 				doff = cfg->dst_addr_width;
 		} else if (direction == DMA_DEV_TO_MEM) {
-			src_addr = fsl_chan->dma_dev_addr;
+			src_addr = fsl_desc->src.addr;
 			dst_addr = dma_buf_next;
 			soff = fsl_chan->is_multi_fifo ? 4 : 0;
 			doff = cfg->src_addr_width;
@@ -676,6 +620,10 @@ struct dma_async_tx_descriptor *fsl_edma_prep_dma_cyclic(
 	}
 
 	return __vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc);
+
+err:
+	vchan_dma_ll_free_desc(&fsl_desc->vdesc);
+	return NULL;
 }
 
 struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
@@ -695,15 +643,15 @@ struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
 	if (!is_slave_direction(direction))
 		return NULL;
 
-	if (!fsl_edma_prep_slave_dma(fsl_chan, direction))
-		return NULL;
-
 	fsl_desc = vchan_dma_ll_alloc_desc(chan, sg_len, flags);
 	if (!fsl_desc)
 		return NULL;
 	fsl_desc->iscyclic = false;
 	fsl_desc->dir = direction;
 
+	if (vchan_dma_ll_map_slave_addr(chan, fsl_desc, direction, cfg))
+		goto err;
+
 	if (direction == DMA_MEM_TO_DEV) {
 		if (!cfg->src_addr_width)
 			cfg->src_addr_width = cfg->dst_addr_width;
@@ -725,11 +673,11 @@ struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
 	for_each_sg(sgl, sg, sg_len, i) {
 		if (direction == DMA_MEM_TO_DEV) {
 			src_addr = sg_dma_address(sg);
-			dst_addr = fsl_chan->dma_dev_addr;
+			dst_addr = fsl_desc->dst.addr;
 			soff = cfg->dst_addr_width;
 			doff = 0;
 		} else if (direction == DMA_DEV_TO_MEM) {
-			src_addr = fsl_chan->dma_dev_addr;
+			src_addr = fsl_desc->src.addr;
 			dst_addr = sg_dma_address(sg);
 			soff = 0;
 			doff = cfg->src_addr_width;
@@ -780,6 +728,10 @@ struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
 	}
 
 	return __vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc);
+
+err:
+	vchan_dma_ll_free_desc(&fsl_desc->vdesc);
+	return NULL;
 }
 
 void fsl_edma_xfer_desc(struct fsl_edma_chan *fsl_chan)
@@ -887,7 +839,6 @@ void fsl_edma_free_chan_resources(struct dma_chan *chan)
 		fsl_edma_chan_mux(fsl_chan, 0, false);
 	fsl_chan->edesc = NULL;
 	vchan_get_all_descriptors(&fsl_chan->vchan, &head);
-	fsl_edma_unprep_slave_dma(fsl_chan);
 	spin_unlock_irqrestore(&fsl_chan->vchan.lock, flags);
 
 	if (fsl_chan->txirq)
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index f2c346cb84f5f15d333cf8547963ea7a717f4d5f..7cba3bc0d39537e675167b42dda644647bf63819 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -164,8 +164,6 @@ struct fsl_edma_chan {
 	u32				attr;
 	bool                            is_sw;
 	struct dma_pool			*tcd_pool;
-	dma_addr_t			dma_dev_addr;
-	u32				dma_dev_size;
 	enum dma_data_direction		dma_dir;
 	char				chan_name[32];
 	char				errirq_name[36];
diff --git a/drivers/dma/ll-dma.c b/drivers/dma/ll-dma.c
index 313ca274df945081fc569ddb6a172298c25bc11c..66e4222ac528f871c75a508c68895078fa38cf7b 100644
--- a/drivers/dma/ll-dma.c
+++ b/drivers/dma/ll-dma.c
@@ -99,12 +99,35 @@ struct dma_ll_desc *vchan_dma_ll_alloc_desc(struct dma_chan *chan, u32 n,
 }
 EXPORT_SYMBOL_GPL(vchan_dma_ll_alloc_desc);
 
+static void
+vchan_dma_ll_unmap_slave_addr_one(struct device *dev,
+				  struct dma_slave_map_addr *map,
+				  enum dma_data_direction dir)
+{
+	if (!dma_mapping_error(dev, map->addr) && map->size)
+		dma_unmap_resource(dev, map->addr, map->size, dir, 0);
+}
+
+static void
+vchan_dma_ll_unmap_slave_addr(struct dma_chan *chan, struct dma_ll_desc *desc)
+{
+	struct device *dev = chan->device->dev;
+
+	if (desc->dir == DMA_MEM_TO_DEV || desc->dir == DMA_DEV_TO_DEV)
+		vchan_dma_ll_unmap_slave_addr_one(dev, &desc->dst, DMA_TO_DEVICE);
+
+	if (desc->dir == DMA_DEV_TO_MEM || desc->dir == DMA_DEV_TO_DEV)
+		vchan_dma_ll_unmap_slave_addr_one(dev, &desc->src, DMA_FROM_DEVICE);
+}
+
 void vchan_dma_ll_free_desc(struct virt_dma_desc *vdesc)
 {
 	struct dma_ll_desc *desc = to_dma_ll_desc(vdesc);
 	struct virt_dma_chan *vchan = to_virt_chan(vdesc->tx.chan);
 	int i;
 
+	vchan_dma_ll_unmap_slave_addr(&vchan->chan, desc);
+
 	for (i = 0; i < desc->n_its; i++)
 		dma_pool_free(vchan->ll.pool, desc->its[i].vaddr,
 			      desc->its[i].paddr);
@@ -112,6 +135,47 @@ void vchan_dma_ll_free_desc(struct virt_dma_desc *vdesc)
 }
 EXPORT_SYMBOL_GPL(vchan_dma_ll_free_desc);
 
+static int
+vchan_dma_ll_map_slave_addr_one(struct device *dev,
+				struct dma_slave_map_addr *map,
+				enum dma_transfer_direction tran_dir,
+				enum dma_data_direction data_dir,
+				struct dma_slave_cfg *cfg)
+{
+	map->addr = dma_map_resource(dev, cfg->addr, cfg->maxburst, data_dir, 0);
+	if (dma_mapping_error(dev, map->addr))
+		return -ENOMEM;
+
+	map->size = cfg->maxburst;
+	return 0;
+}
+
+int vchan_dma_ll_map_slave_addr(struct dma_chan *chan, struct dma_ll_desc *desc,
+				enum dma_transfer_direction dir,
+				struct dma_slave_config *cfg)
+{
+	struct device *dev = chan->device->dev;
+
+	if (dir == DMA_MEM_TO_DEV || dir == DMA_DEV_TO_DEV) {
+		if (vchan_dma_ll_map_slave_addr_one(dev, &desc->dst, dir,
+						    DMA_TO_DEVICE, &cfg->dst))
+			goto err;
+	}
+
+	if (dir == DMA_DEV_TO_MEM || dir == DMA_DEV_TO_DEV) {
+		if (vchan_dma_ll_map_slave_addr_one(dev, &desc->src, dir,
+						    DMA_TO_DEVICE, &cfg->src))
+			goto err;
+	}
+
+	return 0;
+
+err:
+	vchan_dma_ll_unmap_slave_addr(chan, desc);
+	return -ENOMEM;
+}
+EXPORT_SYMBOL_GPL(vchan_dma_ll_map_slave_addr);
+
 struct dma_async_tx_descriptor *
 vchan_dma_ll_prep_memcpy(struct dma_chan *chan,
 			 dma_addr_t dma_dst, dma_addr_t dma_src, size_t len,
diff --git a/drivers/dma/virt-dma.h b/drivers/dma/virt-dma.h
index f4aec6eb3c3900a5473c8feedc16b06e29751deb..0a18663dc95f323f7a9bab76f2d730701277371a 100644
--- a/drivers/dma/virt-dma.h
+++ b/drivers/dma/virt-dma.h
@@ -24,6 +24,10 @@ struct dma_linklist_item {
 	void *vaddr;
 };
 
+struct dma_slave_map_addr {
+	dma_addr_t addr;
+	size_t size;
+};
 /*
  * Must put to last one if need extend it
  *   struct vendor_dma_ll_desc {
@@ -35,6 +39,8 @@ struct dma_ll_desc {
 	struct virt_dma_desc vdesc;
 	bool iscyclic;
 	enum dma_transfer_direction dir;
+	struct dma_slave_map_addr src;
+	struct dma_slave_map_addr dst;
 	u32 n_its;
 	struct dma_linklist_item its[];
 };
@@ -304,6 +310,9 @@ vchan_dma_ll_prep_memcpy(struct dma_chan *chan,
 			 unsigned long flags);
 void vchan_dma_ll_free_desc(struct virt_dma_desc *vdesc);
 int vchan_dma_ll_terminate_all(struct dma_chan *chan);
+int vchan_dma_ll_map_slave_addr(struct dma_chan *chan, struct dma_ll_desc *desc,
+				enum dma_transfer_direction dir,
+				struct dma_slave_config *cfg);
 #endif
 
 #endif

-- 
2.34.1


