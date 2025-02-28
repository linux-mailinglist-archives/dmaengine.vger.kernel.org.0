Return-Path: <dmaengine+bounces-4615-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3BFA4A0A9
	for <lists+dmaengine@lfdr.de>; Fri, 28 Feb 2025 18:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B166D176EEB
	for <lists+dmaengine@lfdr.de>; Fri, 28 Feb 2025 17:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A479271277;
	Fri, 28 Feb 2025 17:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YzvJjffZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012059.outbound.protection.outlook.com [52.101.66.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455E626B2C8;
	Fri, 28 Feb 2025 17:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740764559; cv=fail; b=RX6eyWykbtk4bwmXPWdEdGk6yTjjiHfRx0VKxVqxm/yWbi24StYOGr1UlpQO3mq7Fj4L477qvznk/KM0YABM3C8YxG7+pJ69gL9moVqok6yfocN+HjJ+CTts8GMcbNEcPGAYOM2Mzs3SVeHkrqJQCl/n0oCruIVZ03VJoLXtLvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740764559; c=relaxed/simple;
	bh=gH/+Meg9SqFjisDnsGjDvRsAol7EE4YGmz/s23d1II8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ubAaVI1pKxZyxymcJtcs8kM8vrMxMI5Y8ZQyzYphPvKJUJATUrA0VRJ61njcJXqVF8ers+BdST5sckwNNJm0I/pc6MBBAj7ud/0YPvTUFOZmbWTdaWc6tM+wGf071WQcWUpPrhcrZbWi9SXjtIxU5fkBTZO1YRpfCRPaMqzva1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YzvJjffZ; arc=fail smtp.client-ip=52.101.66.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B8ouS+e4o6kZ1ZXelNUy2NkHGTZ0b2rXUqL2vvO1oTSVQ/LvokiJT+VAWnMDezSBud9wQ8kUeHzNeTkAKonj6fQMd11nzMvmEOdbCCOuBsD30FXWkAW7094Viv/W4oGRb1woiZ2nHsiNs86LWcJWTe+EZX4UpuwiXPtTJnUqqGXPj58OMpNKno8WefEXCVqzQHl84ar/TvA4xazVHpUan79Yr2xWePEHnxSd/EM/0nFZq6XfKYMjiA03N+9d+Mbc69ZLwHBgrZG+YXrBg+AF9DzrSqS/QqMx+4CSw3FUPRGS+nK+JAdB8rjV5f1OmxEmdV/YpPHBA7Lo7s24NmQ68w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bob4Ccs36hVMdy86Ida84hn997Fa4U+grPHYSAXzdZY=;
 b=zP9f2//e4XdAU3ntSYsTmH3m769f5TXs6EgPIILDG+3OZkBw4ldO+ndFtoqtMcQmhe4yHA3wI03g2nfx6rCHQetwuhfFbML6zkQre7y7aUgSO3ehCVZRaptX9VCBdfmGKL/aTEMYOYIviw8JTLT13sTcYtZpyfk2nPsNx87nWYiXAX0CxYoJfH/eEODbGjJEPQVV1B+GothAjYmPSNF/QBfKiJwnJTCLuefDtxQmJA16o/r1c0ejR2bzfwk5J3QhDEuA29bkHJWz3dX3Z/pQ8D4lvWQ90uJJcrAUXbCdM0jYnPJT4VKa2HcMYuFVXRu3ksE9IJ2rqdVtcyJcTyeKrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bob4Ccs36hVMdy86Ida84hn997Fa4U+grPHYSAXzdZY=;
 b=YzvJjffZvI1cDA2Yn/7wGvv1hcR5AuZtOYqV1oKka5osM0WcBrVCfKA5u4GI2IXIdzdfAyxbYuyjSYnFGwshoGRe+i+mPlz2SF1ID7H1vBPU8Y6Sgay2t7dGRZYyMbyOrbSwb3t4u5cApj5xyG0NyLtAICl4V/u76fvA6yOykJw15CvsO6waIwC0wYN89RV3LflQ9ASpMwo+XHCr2f9RrfGSq8d+YwMPnpYy3ylBhyUlzPiV5ASaKIUAeLT/+FVTgT5ybq+AL+q1VRZZfC+urzINAw9repRD6PD6m8UXBWOAP/oqXT1uWNRVh1IDzS8HF678bQ1VF/Nc2sEcwRlXEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB10498.eurprd04.prod.outlook.com (2603:10a6:10:56a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.20; Fri, 28 Feb
 2025 17:42:35 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8489.019; Fri, 28 Feb 2025
 17:42:35 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 28 Feb 2025 12:42:03 -0500
Subject: [PATCH 1/3] dt-bindings: dma: fsl-edma: increase maxItems of
 interrupts and interrupt-names
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-edma_err-v1-1-d1869fe4163e@nxp.com>
References: <20250228-edma_err-v1-0-d1869fe4163e@nxp.com>
In-Reply-To: <20250228-edma_err-v1-0-d1869fe4163e@nxp.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: imx@lists.linux.dev, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Frank Li <Frank.Li@nxp.com>, 
 Joy Zou <joy.zou@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740764548; l=843;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=MjrDFtkTjr1zYv9ep4mHxsmw41jBmTOr7sklE9T8d+0=;
 b=/L1GzcwqJDTm6mFH5YVsNdda7/cvAhB0y2krSgFngeemmD1x3WCRXhWSJlaeXpLyWjqi7AZ8H
 oJ0Bt2YHps+BdMynWd+NFebN9Dx6mghL6jUjNHCroQ646jlgT9Q4eP1
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0012.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB10498:EE_
X-MS-Office365-Filtering-Correlation-Id: 744dfd36-651f-4072-518a-08dd581f4985
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QzN6Zm5YRFF6S1RDYUtHcEVSYWxvSWp4OGtHZmtMOUFrS3VPV0JqcjFid09j?=
 =?utf-8?B?T09sV0RObFRSamhrSkw0bE96R0VlekYxa3B0dnJZZE80QUIzRml6cHhkMDMw?=
 =?utf-8?B?OVMrZW1sNlgrdWF3Y2c0MjcvMGdTTGJFdlNJYjdtSWpyd0hRbWJIKzlrWEs1?=
 =?utf-8?B?TjZZSVhuSDlabEpCcldZbDRySkZFQ1JqZk5mekcralBpbFVZcWR0ZGZ0bTYv?=
 =?utf-8?B?VEJpTjhWQVBSS1UrUzB6N2FlOFl2eC9OYkpveGJ1a1FUNHVMUTJkRGxHN2Y4?=
 =?utf-8?B?dS95UDFVQjdHYWludXhScDl3d0ZybS9OcGxjS2VudEltVEM0VzBLQXZ4WERH?=
 =?utf-8?B?WjRacFJWZHZWRWs1cWVjMnp5YUpDSm8yWE5iOHBoZlNoZzI5T1lmaFdmVEk1?=
 =?utf-8?B?ZWlteUNGWkZKSkZCd0tCaHFLS2t1N083QUhabVZJQytuMFlzUUYyRkpZY2NK?=
 =?utf-8?B?N2plM2RsRVVpaGl1Z1Y3YU03Z1hJOUhYWUlQdzRscmJ0MnYxa3Bwc3VIL2Jt?=
 =?utf-8?B?emlFQjlnamFMS2FYU3l0Vm1kbDBJOUhKVHAxV0ViemxNUjI4aTVMSlhlR042?=
 =?utf-8?B?US9CU0dHamlnRXN3b0VPZDk3YlZMb1ovSiticytBYnNVZDBPRUNvNTJSREx3?=
 =?utf-8?B?MTYwZlJEZDVub1RlRSt0ZFczbGhpZXNQOG96R1dFaW1zRnVtMjJoKzZNRFBU?=
 =?utf-8?B?b1BCckxMbUlNUEJpd1IyUm9ISUIvMjNyNUY0L1RGdGpabE55aXlKYkF5Q0ZV?=
 =?utf-8?B?OEZpdzlpZndSQVREbU1nMTc4NVVRZHNyTS9LajVSSG9hdVd4YkZCVGNDUy9o?=
 =?utf-8?B?VnhMKzY0NVhJdS9UOGtGc0ZQcGw2UnArZGVKbXd4NndtSGxuWTdsNU0vb2hz?=
 =?utf-8?B?dE5lNE9YZjZjV3Jjd3RUdDN6THF4ZStDbnd3eEN3eitGQUduYUJBT3NLaGl6?=
 =?utf-8?B?ZHRjL3JQZmNnSWs1VmxVY0N0NE1DVkdyR0pqamxuNnpUSmhhYS9BdnJLd3RS?=
 =?utf-8?B?QWs5bXovY1lseXVWUU5DNDhUd3pORnlEa3N3d3dmdnpiSkhwUE02S3VsTzNi?=
 =?utf-8?B?R0RjWUY2Y2trMUlvUU8xVlZoK1EvZzJrNHlBdGZxVThEUHEwVXBPNnRMOUli?=
 =?utf-8?B?dklOK1pNVkZ5NTVxL1l5MW9VMkgzM2FPU0dHQ1dNNnRaaDNjay9UVGVkMGt2?=
 =?utf-8?B?SG9BeEFNSFpwYXJMb0pmMEdnL0tZazlKeFZ6eFgzb0ZDbjl6S1AwWS9HVFVu?=
 =?utf-8?B?SkVaR1o3QS85bXJucGVWYzNWUEdsa1pWWElSd1AvVzhwaElPb0ViaWtaendK?=
 =?utf-8?B?RmFUMGVDWlZ4TVhxUHQySHpMYzlSZ1l0ZnJFY2JYUnBzYytma0t2S1FyVEpQ?=
 =?utf-8?B?NUJFeTBCcG1vMzhnY1pkSzRmSENLUloxT3hDMi9UOVNsVXRJa0lCb2cxankv?=
 =?utf-8?B?T0hwV3Q0a0R0SWJlcXZWa2l1SGE3U0RGMVhSaUpPUGZOT1RIaDk1STdsVy9j?=
 =?utf-8?B?SWRkNEpOWnVpRmF5bkI4ZXpZWVJWUjg4bWJzSkp5RDlKQWxuZGhMVU4rR2Y4?=
 =?utf-8?B?Z2VZcUJWcXNBSkNkc2l3R0tWTkFGUXlSeWhpOTF3Z0lGTEtiYXo5NUVvS3BD?=
 =?utf-8?B?eFFTbnZzdU5BVEUya1dSYkxOcVJjcTdhaHdMSjQxNktJMWQzL3RDZDRhdHp6?=
 =?utf-8?B?b1V1Rk9wbzJOWTJSOVIxNXpmQnpOVjRITGVqVDVaN0w2K1VZaFpNMnlpQ2pv?=
 =?utf-8?B?VjE3N3d2VjgzQVJUa04rdXVSSHJrVlAvY2labUpjN3J5b1BVRUxTQzg0R1Aw?=
 =?utf-8?B?ckNkWlhXaHNjUU5sMlJzeGl6dHh1bDN6SUJGMUViZTAwbVBZTU1KZWdMVmFE?=
 =?utf-8?B?Y3p2VzRiMXNPWlBJWnhjMUJWaUVJQjBlcEtvcWVpNDNIT1NpMnFiSHczYUF5?=
 =?utf-8?Q?L00CvWf33GefABqa0XIGIrlHh0B+GyYs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVd2elRmTTBhWGVoWlB3ZnZDZTJFMVBEbTJlK09hSG1xUEZBRmswd1BGRGtL?=
 =?utf-8?B?Zm9tTjNMYzRlR3hSWXlvdjRXVGJ4TEhqd1Z3RWE0QldzSkFTUGxPdGxqa3BW?=
 =?utf-8?B?VmpzY1Q1cHoyUjUzUUM4Z0IxRld0Tm1sQXovaEN4QjlxdjlvcnQvN3FUVTFQ?=
 =?utf-8?B?dUZQMTZkbXlJdW9VeVFWK3lGY3JsZmREenFsVnMrbXF1K3daa0hnaTZLTlVl?=
 =?utf-8?B?anZKVlFESU1xaDVmL3VwSDM1NjFHRE82V2lCbjJvSzNhcVRYNDBoWWxmUjI2?=
 =?utf-8?B?VWdBR1Z3Z2luWWhGSzArVkt5U0pZTGJVWEVDVWVBRkJKTk9XVGtlL2o1Sndi?=
 =?utf-8?B?SlFhSitvK2dMZkhHdklJSnEyZzIvSk03Vld4c1hXcTYzQ0thVEdHQTNvamYw?=
 =?utf-8?B?VitwOXdKRU9xUFhZeUJuZ2I1SFJJT1BVdU5pNEovcXNmT2tJTlR1M01Gc0RX?=
 =?utf-8?B?RFRaSUJqTGRKL1pmdlI0ZkZnVkNYUkFLVDRHRVRZTnpUOHdpSzBIL3JPTWpm?=
 =?utf-8?B?OXMvR0tPTUpLRG1GSmVDU2NmcHNFUVlwRWtCVEFLSzhjalVLNkEwT0FlZzJ3?=
 =?utf-8?B?N0VCVDFOQ3kyblRTRVV5a0dKYlVLbmMvUU1QYnVrcWhsWDJ0UHYwYXc5ell3?=
 =?utf-8?B?T2hXTWF1Y1Q1eWEwblNXQldIeVhGcjhKdnFzVFFJand3cVNvb1lucTdrRnFD?=
 =?utf-8?B?RXRNU1MvQkZiYjJ3Y3NaL0Fva1BRaFM3Tm1ybFl1Szh2YnZXQm5DTlAxL1dX?=
 =?utf-8?B?MTVNUFdPbXM2Q2dqUU9sSlRwUEh0Y2lDTnYxRzMrZG1wOGdnTzdQUmdlMmZh?=
 =?utf-8?B?eEFidTBqYnpYaVFXeE10SUtCTUlYU2UwU096UFZsMzFMMmJhTkw2VDIzV1VM?=
 =?utf-8?B?S2ZCZzIyai9SMmZMdHhGY3pENUMrb3YxcWJUTEplOEZtb0t5dVRMbDhSQ0o0?=
 =?utf-8?B?bXVNa2J6V01vTVFLR01pcTlrTW1rdlBUNU1WQnd2VlRSc3J5WUhBbmN2TVRV?=
 =?utf-8?B?T3Z0c3NLVjBSMmVOZ3BMeFhMUk5xTkRPcUp1dTBUbkY1bHFpQ0d5VVFrcUxl?=
 =?utf-8?B?SmY0VE1uNUpydDUrWHhscnRRbVRsM3UwVHVBa1R5YWFqWmxBcVhFL0N0MGJC?=
 =?utf-8?B?QkdwakI3VEVqa3NlM2JMNkU1RE14TE1Zb0FEdnJEaGdwa0Z4L0pxaTV5RTJl?=
 =?utf-8?B?YzVPV3pBdkg5RFhaZkhvS1R6SFRUQUdMaUg3YUpwZzErUE9nU0Z4Z2FmWEI4?=
 =?utf-8?B?NFMxc1ZkRnpoVklMNkFmcThwajByVmQyT25ON1FzRFZPcU1SU25CelZtWTEw?=
 =?utf-8?B?WTFXT3ZJUncyNXk4K1RnalRoMmlMWW1TMTVqWGZhK0MwdnFLNHFtUVFOZVdY?=
 =?utf-8?B?YWw0OVVBcTdkbVVRdlBpYk1BUzBBOVdBbnBRYk4zL0NIVnNadHdVTXBnTnRa?=
 =?utf-8?B?S0JRQURHUC9KMEhZSWErUmtKeCtwL0dVZTZFQUJZcFZzbVVxaFBrU2JKeUxJ?=
 =?utf-8?B?ckU5a0xNVTRadkZPbjk1bCtDZjdmVlZEb1F3QUd0ZUZoUnRCaFRveEpGMWsz?=
 =?utf-8?B?UzRLY2FaZDFiWU5nTnFPdW0wSWtuUkRyamNHdDBWTTdjaVBuaDdWNmh2eTZW?=
 =?utf-8?B?Z1g2OFQ5aHA5blE2QzVQZ0pWT0QxK3BocVU5b2dWTW5FZGJWY3pTVWJyTXFG?=
 =?utf-8?B?bkFQVWVYY0YxQmE3L0JheUVrNVBRc2Fnc2YzaVMwUHdYRmFDVHZVVUZtbjcx?=
 =?utf-8?B?aDNjOHMya0dZUDNxMXlkdHBvQ3U1MUFCa3dHSGFONmNpV3ZvSlZmMTJrcUtQ?=
 =?utf-8?B?cDdtUWZ5YlQ5NDE0NlllNGNOV0dxeXVOUEZVamlnSzA5VUpsTVduV0FldHFM?=
 =?utf-8?B?MStWZGEvR1lTQzFEY05qRjhhM2ZRMllzWG9qSnFhUm9WeXIzaWozT2xsbjNK?=
 =?utf-8?B?S2Y3Qk04aENYMUFObW0xOG94aXh2a2FvU3hSUGlxSnpVK2wxUFQ0blFzSW9y?=
 =?utf-8?B?TlJQbWFiak9RZ1Ivd1EwMnZndEpwakt5L1ZVWmhQaGZIamd2My94ZXFMYi9k?=
 =?utf-8?B?VG0xTnRqSTFHZ0c3TFZUSWhnWWtuMGlvMldZMm9hMVRwekhJdCtVd3RkaXN6?=
 =?utf-8?Q?fuJJg42wYrIcXatE01Nd8xX5D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 744dfd36-651f-4072-518a-08dd581f4985
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 17:42:35.8092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dof+RY5DfneV1Sczs0RSeypLAqZ2ne0H0Qm+Rb7mFId4i/JJxPKcWWrDIJpoHtsg86RM5sMhGPxecd66SvKBKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10498

From: Joy Zou <joy.zou@nxp.com>

The edma controller support optional error interrupt, so update interrupts
and interrupt-names's maxItems.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/dma/fsl,edma.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
index 4f925469533e7..900170b3606ef 100644
--- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
+++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
@@ -40,11 +40,11 @@ properties:
 
   interrupts:
     minItems: 1
-    maxItems: 64
+    maxItems: 65
 
   interrupt-names:
     minItems: 1
-    maxItems: 64
+    maxItems: 65
 
   "#dma-cells":
     description: |

-- 
2.34.1


