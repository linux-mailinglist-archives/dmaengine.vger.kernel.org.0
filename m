Return-Path: <dmaengine+bounces-8034-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8ACCF5DE9
	for <lists+dmaengine@lfdr.de>; Mon, 05 Jan 2026 23:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70365302B114
	for <lists+dmaengine@lfdr.de>; Mon,  5 Jan 2026 22:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A51275AE4;
	Mon,  5 Jan 2026 22:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MeezmDH8"
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011047.outbound.protection.outlook.com [52.101.65.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC604C81;
	Mon,  5 Jan 2026 22:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767653241; cv=fail; b=SEYRsGK7wloHJSkE8Qzp/Epfb2JplCYIae0FtxeHVUJ/UoUrVMuwXOrcnMyeXghNo4D9wRxj+bl8LOJUy9rcYmt0MDGBnHyHzXAo6na/rGNdbDg0jdrDkd14PKXy9o4oIG4kDCeekqUNGVE/mhNdvaJVZFsBhToi/Rg7uPGi4oY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767653241; c=relaxed/simple;
	bh=BTAAbYG+QKYjszDRLlJnJ05AneIevK4Qx6xxLErTGdg=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=oIwwd8xlqw7ctJKh8m6Yxp7ImFoMKCU4LKxwFNToeJjDNIjH/a7QF56+qJaPKWCXGOHR8qsUdyHsB8v88aOqM550BEKq9A0NihQDsb8GgMNr1RCHVzxI8KDnApFlBQ/pDKXQF7uu3TM2tCIKQg0LYlt1BGOBEsIdCoLlP8vstPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MeezmDH8; arc=fail smtp.client-ip=52.101.65.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aJgGz/AFvv9ZRkEboakG9/Hqcqw5rxkxxsXl9Ja2jzJ+KbvWKQKtRgDX4li3Tt+1WgDkQZN0K/rAsqHOxC+s3RnMS2X9Go8RXkCEnvQXWSXtQoY1cM0/BqIzx1HB6pPrZ8wJtLBsiJ5u8WjvqvhUsYtdOv3Lj0EBpRanH0X0CcOEyl4qRkk0Qq+CYz02EMehDGssllwLG5eEcyZPYfuPCroEpiWFNjKhB4O8PT6PZvUXE0IB1Zap3bbKZM34sqjpZSaiqa5PBaL52puPtjkvfP4xI2jZbPKq6t3KMF0YmNYH9lDkSrHG8TDvjGxF87l4bWmSwDdsLXpwWy12m+FWog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oF9xCT2jhw1LPzeHHxO+1JnVZ4Io3i5qujf/Ewr1eJQ=;
 b=CBpC3/4wdKqTDSYCSib81Rv6kPWd/o4D+L+W8s6zvLdU8R8d6prdgUdmZrNR0IXIQjEsG/RWp19fyeWwspuQ4gFrhQup/7gCs+RgJoeUPcDv4t/BqJSQIN0pJe3C2m+w3xP9LbI4i4WhksBwMFKd/bpgEZbJR59va/kcq1oDTrTtCxcRMIuTr+Rf+GqMLU6CxsXPBbKAwU0KmDL1VxMUd25u01K2YQFtwqpHitdWHbknmCtrZ7dpuaEoEl1jMicZj5y3Yufnu+nF6DPHheIEcnBgyDjus1hGPyU/P9/FJaAPo0RpsHNDS6U/ExUIf0LQT4ytJ/qeI35ONIrifW5qWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oF9xCT2jhw1LPzeHHxO+1JnVZ4Io3i5qujf/Ewr1eJQ=;
 b=MeezmDH8Bj4XvOV+yqY6vNFs8sPszej+Ev3xibiE2h5FnErk5EVMmV43QR7+lYgBe2dLW7YWfEWIce4hOWG1mdsK4soNjFW/HRk472BxQAiB09RP4gjUW3UdA3HLD+IzLI3CrMED3G6dFDZD1vLlO2eVVsyOM1nSSGzawswRItkOuoCO9vnOAAcdPeZoOen5m/PSJQn3eYn9hQUETStheAAsi2lfy5wXoQa9z//d7u4zZW13gy4pdJyssE0DWq2Em94vwH97AITuA8xB+ur7mw0Ngzg9Sz9s4U3PvGXQRJNVzKSjMiFwvqErPPeTlGfptfr+gYDZcYy1rAkkFSx5Dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by DB9PR04MB8185.eurprd04.prod.outlook.com (2603:10a6:10:240::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 22:47:15 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 22:47:15 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v3 0/9] dmaengine: Add new API to combine configuration and
 descriptor preparation
Date: Mon, 05 Jan 2026 17:46:50 -0500
Message-Id: <20260105-dma_prep_config-v3-0-a8480362fd42@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFo/XGkC/22NzQrDIBAGXyV4rkU3mp+e+h6lBDEm2UNUtEhKy
 LvXBEoL7XG+ZWZXEk1AE8mlWEkwCSM6m6E8FURPyo6GYp+ZAAPJgQnaz6rzwfhOOzvgSCspeM1
 6EFIByVa+Dbgcxds984Tx4cLzeJD4vr5bzU8rccqoLEXLtDTcgLraxZ+1m8leSvBl8z82ZFuzm
 tVtU1Ycmo+9bdsLR9KLeuoAAAA=
X-Change-ID: 20251204-dma_prep_config-654170d245a2
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
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>, 
 Damien Le Moal <dlemoal@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767653229; l=2941;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=BTAAbYG+QKYjszDRLlJnJ05AneIevK4Qx6xxLErTGdg=;
 b=hSaHb2FmMJ1TlbFL8n9RCI4ichYcReYCcELRV50MJCoViTbJCCIkKUrSusdFv/H1uzFZ1vN+U
 jcSXJjImkYlDCQ0FWDVZ4HwtXN5u1eeUUIv7XWNumOtPh4J2Rn9kg6X
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0345.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::20) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|DB9PR04MB8185:EE_
X-MS-Office365-Filtering-Correlation-Id: 51135ebb-df16-4431-95c8-08de4cac5f75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eURDVGpmV0R4ZktnVUp5NE8ydUw0QkFLby9ObzdkTFJzOVVLNTRjd3VrUk9N?=
 =?utf-8?B?MVJHS2tBK1RUU0xEVEQxYTBybERHaGZDTjZoMTRreFY1MldNaUdOM3llN3N3?=
 =?utf-8?B?bEdOcGJ1SC9xdVVLT0lOVEZMbWJHSFI3dG5NMHQxUjBZQ2tzdUVabEd4aUFG?=
 =?utf-8?B?am8rOURwOHBlQ2h4dVJ0TmVpYUhvL0RtTjdXRlJpSkpQQWp1SU1DUWhMRGtT?=
 =?utf-8?B?d3dPUHhjOWRJamg1d3Q3U2hWWGFTMDlSbHJZdk03WHE0TFpycmtOaHF4U0Y4?=
 =?utf-8?B?ZkhPK3l6RzBsMllHcGw3ZDh2UTZXS2xET2s3WFA5c1FYQUlMZ1dPT2pTTGxy?=
 =?utf-8?B?TWVrSDZLSTRjc3ZRZnZXbUFlUHFHdUd1RGdrWkZHMmNuNGNCTEZGcW43NlF3?=
 =?utf-8?B?T213TmwwWE5sODdDM0FOSS8vUzNPK0F6T21ocExsdlF4am1mdm9lNitmTVIw?=
 =?utf-8?B?bC9IK0lWc2RJdDN6MjJDS05IM1N5Ly9wL0xmeDd3M2hWeWI3a0hCOUFQcGI5?=
 =?utf-8?B?RjhSeEhzYzk3NGc3T0F4ajl2MEl1OWFYL1Y1UlU1SmZiZUpLeUZmczljVyt1?=
 =?utf-8?B?L3BZKzRoSXNSKzdtUGZYNWFxNDJlSXdRbEMxRzh2NkdRellZQSt1WFF1alg3?=
 =?utf-8?B?OGlKZjZ5Y3FaRW5EMzdUc3M5QkplWG9NbktoeklZNmFNK1V6SFFiR3hCUXhN?=
 =?utf-8?B?M2V1QzVQYjByR1gvRHpqclJxRjRaaytORzFxM0I4Z1JiYk93REFtbnpFUitD?=
 =?utf-8?B?UDJSTXkxNFBrcWs5R0JWcGdPakhJZHdvdG0wN3FMK0xHald1YTdKUXBIOWIr?=
 =?utf-8?B?RllBUURnb0FRczE3TnJINGtIRlIrcm83WmlBRmtTdGxXZUg4ZklQbU15cXVJ?=
 =?utf-8?B?UzJhcXg2ZzZGYW5UUFdsaUdXeGg0WGxMdE1LbEhzVWw1eUNtQnJDRmt3MVpy?=
 =?utf-8?B?UmN5d1RHOHFOcUFvdjQ5WE1ab0lQeTd3aUExTkp5QXcvaFpmQjdvQ29iWjZk?=
 =?utf-8?B?ZUs2ZXBLeTVObWNyS2VXbENGUEFQbzJadDBGc0ZoNzBMOThwZ0YzVW9QTHlS?=
 =?utf-8?B?Z3UrZkZqOElhVW1Wa1B1Nmt5YVhZcDFVUnRZSTAybldJYm1OeEU1czIyT1Vi?=
 =?utf-8?B?MWQ2WVNCYzJpWFVYdk9MWEd0RXNlU3YwNC9wQ3pjVW9pWlBWZE50c2JKTk9i?=
 =?utf-8?B?RzNyV0ZVbnBwMXM5Q0hJYUFoTkJIRGRjeTAyNHB4Q3R3QmRzQjUzRmVlNzdQ?=
 =?utf-8?B?L0Fwa3BjVmVhQlR1YmkwVEZRSWRjVnhEeG9HK3E2MTVRTkdxbzZleGJLRDFu?=
 =?utf-8?B?aVZFNUpuN1FGdUZrdS9ZMEF1cGVLeVNTVCt1K1hyVE9ubXo3MzRGRDhpQlBP?=
 =?utf-8?B?MFB4Z3JLWEV6SmQyK1VzdEtKbG9BaENNWDVHMnN0clZLVy83NGg0WXlNRk9T?=
 =?utf-8?B?c1NZeEl0S252VkdTVGsxTFpGekpVdGJPV1pLYXZMOUM5QzJHdUhwVEVJenN1?=
 =?utf-8?B?UVZzUmFyRzBCNC9YUzVudVBpSzBiMXBlaGRBRTB6czhDN1AzQnVob3JEWWd1?=
 =?utf-8?B?aE9OYlprUy9CczRKVzBzbXZjS21SenVISVhxeXRFdUZiV0FHT3I4ajJmc0Vs?=
 =?utf-8?B?VTVlM2ZieFZQek1PL3dyUGlDT2hNWXZlNWZQSHp6RVJ5YlF2ZWpxNFVKMGUx?=
 =?utf-8?B?RmtGZUFVUitxcXc1ZGR0aXdUaW56S0ttNkthVHQ5Y3MwZDRzVFN1R2ZtREdG?=
 =?utf-8?B?NklrMmZiYUs2ZG9FdjVyYm9JU2N6Z05mcHhLSlN4c1JkTnRjaENXeXlzaGR0?=
 =?utf-8?B?aXhRckxOSjB4bkltVFQzWEMzQ0NicVFkWGdXNGsxNWdtNGQ0VkRvV1Rpaytu?=
 =?utf-8?B?UkY2Y01SQ083UUNuRlBIUlJrQmNac2ZiTTllcEloTm51Ym1Na1ZYd3N3dEFl?=
 =?utf-8?B?TFdWRlV2Zm1TL0Q1WWx6MWZUdFg0SHBIOEFQK3RIRHBlSkNzSlNSN0R2TTJJ?=
 =?utf-8?B?VjQwMFBCSmpCYk1mb2tjOVZ5bUtOOVNMS0RGbndDMW9QTlBQS1Z3MU1xUWx3?=
 =?utf-8?B?OHZiT2RUeklVWHVxd0tpKzQ0VjQzamxUTVNXRDl4NWhqR05ibElFMVhZUzI4?=
 =?utf-8?Q?9VY4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3dscTBDVlB5QnJ2YjZlMEpoekt1TUZXQmZYV21uUTBscU9mMlprYUIwclFs?=
 =?utf-8?B?OEVIRnU3b2YwSi9iNkhMa2Jka29GZENmWC9BN0MxcjJNQnkrZC94cVArVzNL?=
 =?utf-8?B?WFluN1BaR3dlRll6V2U0bjNPSVJWSkFWd2ZsNjVob24xSFdjNW9TSU4wSXA5?=
 =?utf-8?B?Q1BoZ29kU21YTEllV0dZL3N3L2xuelJKQ2Z1V1JtVGhVdmRxNm1IQVRsYjFG?=
 =?utf-8?B?ZWhMTmUwZ2JPSEhLZDlNRjA2ZlZFMENQRktWV3Z4TWRXeE1xVk4wam9remdN?=
 =?utf-8?B?QkdTdjBuRDFTQkEyWHRCektKcnpsNzNkamVWYUFaMXFCRktWVm1rbERJK1dh?=
 =?utf-8?B?dFhjRmQwUHhpdk5xVkxwVGt0Z283eTRKa0JLbEI3MWUrbk1JcE0wRTNUYmww?=
 =?utf-8?B?OU1WM2RSQlJuVmJ3REpuN21nUklEcnZMRzMvWDVrK1Zkd3MxUmttYmlpKzFH?=
 =?utf-8?B?dGtpb0tZN2RHNzd4KythQTZPRi9YalZiSXUvVDZqRC9mMGdQemo4RG0vODh6?=
 =?utf-8?B?eFFJS2MyNDE1WGdJemNZL1lHT3RzM2ZMaW5ndEt2Y2VkNVV3R0hSOWVtaHlD?=
 =?utf-8?B?WTlqcFBYeHV5VkNpVFdHaXg4c3FSL3poTi84bmpFWTluVE84bDl2a3VvTGsr?=
 =?utf-8?B?eVF4OVlHRHVraGVuSEhsbGI5ZHpKY3dVc0RvelpYZm5ZZ3VpTTY3RSs0Rjli?=
 =?utf-8?B?d1RpMk5TZjB5T1hoaitkWFBpR3Zvem82bFRxSnpOM2VlZ1ZFWXA1S1ZzYXll?=
 =?utf-8?B?ZXliZUlTTy8vTzliVEF5VGRIeFJ6OTR5Skw5cEVuL1dHUXc0SnRRb0pvbEsx?=
 =?utf-8?B?RkIxQ21DQkIyUm1nUGNDdWZEWnJ3NmtxOE81Y0NaRDdKYTMwYmc4MjZXVW1p?=
 =?utf-8?B?UjkvalRhaTlzVVJReFppU2phMW9LcGJtQ3RwMGwxdWV0ZGxldGR4aXRrdTZP?=
 =?utf-8?B?cVhBanBNd0t2b1d4Y3hJRXpBWFJkcVFhVTk2bmhRb0wvRHFWQ1FHbEpOVzVq?=
 =?utf-8?B?OTNIYUhlekI5cnFUNVQzaW0yT09ldVRuNHNyZDB1OVFvR2lGTmo5dkpVMURo?=
 =?utf-8?B?MGVCWWt3Q0tkNWZpLzF1YWRKZ0lCeEY2TUJQaUUzNGRnMDFSeTlYS1o4K0F5?=
 =?utf-8?B?akdKL3NrcU10OGZ1TmNWcG5WTlY0NTdpcUkxRTJPelhJQjBSVjY2bFE0R2FP?=
 =?utf-8?B?dkprVlljSnIwdTgzcWMwaGovdGgvdy9PM2NWQnd6aUlUelFNMEh2cWFMZUI1?=
 =?utf-8?B?M2o2WE1SbFBtdENZdVEybGsyejdKdGhQT2UycXJBSjZFREJSdlpNUE5jV1Mx?=
 =?utf-8?B?SDcyQkllZ1M3dHN6VWRpMFlLQ0R0c0VUZDRqOU9UQVdaWm1zS01TTzVyTlp1?=
 =?utf-8?B?ejV6eUErVkNGbjl5eU54K3lrZ3hrQ3c0RytrT1kxTEtsN2hTYlpYOXJveE1K?=
 =?utf-8?B?TEhRR29HcG9YUXlqV1RVTkt5d2VCS0Ric2c2YlBiam1KK3JvRm9jL05KUmI1?=
 =?utf-8?B?cXdTSVJQK0VXZEpRUDB1SXdGUXdkZXJXaTRnUGtnMXczVGJOejFQeEl6b1Ur?=
 =?utf-8?B?dXFYS3JjV2dDUTcrNWdGWHVsZGFMbHA2YW10WGRJSDcwVkxsLzUrM3RqWTVp?=
 =?utf-8?B?QmNiOWthaFRvNGNITHNQdHJ5OUJNZXZIdTk3RDRqVTczU08vUjY0WEk1Szl5?=
 =?utf-8?B?bkVXdit3WmlKQksvVVFkWk9NeUppSXp2K0JjQmZKZjQ1c3Y4L2NmeGhKaXdk?=
 =?utf-8?B?VFZQOVdFbURNaDdJZFJmQ2RmOGFuelk5eURuMXNoNnc1ZUdqdUJpQUduNmU0?=
 =?utf-8?B?bGxZZ2pCNEtFTGdXMk5iamNyYjZxN0lxTFlwdEYyRUpkVkZrbWdZaDRSR1lP?=
 =?utf-8?B?QTFhejVSc1dOUHR0c2FYSzFYaEFSbUhpb0lVM0xGZnIrdi9xdXdRMm4yQzMx?=
 =?utf-8?B?OU1WQnJ4RFhRMnRtV3ppNXhUSm8vczZxWDVmTHZjUlo2Nmp0aE5YZE52eVIr?=
 =?utf-8?B?ZjFzalBwZFZ3YzlUenVicEd6Z3BEYlg4SzNkUi9KUy9mL1U5SSswaDltTGp0?=
 =?utf-8?B?NzlXWFVpR0JHMCs2bmdKMTMrYk5nUFF2ZmVEVXJSOWJIV2ZHNXJVbWFOMjhs?=
 =?utf-8?B?aXNRdjJwTFVjanFuaDVydWtqbW1mNjdlWXU0ZUJvcWxRclU4MlVXVXFHU25v?=
 =?utf-8?B?Vm54eGhtazY3S2xqTHZVV0dJSDJiREU5SnZ6dmd6dlJGRG9VOVppRlpyUFgy?=
 =?utf-8?B?SVNqNC9td1c1ckk2ajdrYnFhQUNCR1lzOG9TSDFJVklvN1N4d2hqMFFucFow?=
 =?utf-8?B?VjJweVFEdEpxekZ6Z1FyN0w1R052MzczUUJ5dEpXYm1QdDRHSFRDQT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51135ebb-df16-4431-95c8-08de4cac5f75
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 22:47:15.4717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uUID86TVLAy1L+SvFhXcKmgDZwVuMsHpqCYZ7D/6XrwUqFON48q+E8nBVCKjVXGhxgiqYXzI2ZaA/HzUG7g6cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8185

Previously, configuration and preparation required two separate calls. This
works well when configuration is done only once during initialization.

However, in cases where the burst length or source/destination address must
be adjusted for each transfer, calling two functions is verbose.

	if (dmaengine_slave_config(chan, &sconf)) {
		dev_err(dev, "DMA slave config fail\n");
		return -EIO;
	}

	tx = dmaengine_prep_slave_single(chan, dma_local, len, dir, flags);

After new API added

	tx = dmaengine_prep_config_single(chan, dma_local, len, dir, flags, &sconf);

Additional, prevous two calls requires additional locking to ensure both
steps complete atomically.

    mutex_lock()
    dmaengine_slave_config()
    dmaengine_prep_slave_single()
    mutex_unlock()

after new API added, mutex lock can be moved. See patch
     nvmet: pci-epf: Use dmaengine_prep_config_single_safe() API

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v3:
- collect review tags
- create safe version in framework
- Link to v2: https://lore.kernel.org/r/20251218-dma_prep_config-v2-0-c07079836128@nxp.com

Changes in v2:
- Use name dmaengine_prep_config_single() and dmaengine_prep_config_sg()
- Add _safe version to avoid confuse, which needn't additional mutex.
- Update document/
- Update commit message. add () for function name. Use upcase for subject.
- Add more explain for remove lock.
- Link to v1: https://lore.kernel.org/r/20251208-dma_prep_config-v1-0-53490c5e1e2a@nxp.com

---
Frank Li (9):
      dmaengine: Add API to combine configuration and preparation (sg and single)
      dmaengine: Add safe API to combine configuration and preparation
      PCI: endpoint: pci-epf-test: Use dmaenigne_prep_config_single() to simplify code
      dmaengine: dw-edma: Use new .device_prep_config_sg() callback
      dmaengine: dw-edma: Pass dma_slave_config to dw_edma_device_transfer()
      nvmet: pci-epf: Remove unnecessary dmaengine_terminate_sync() on each DMA transfer
      nvmet: pci-epf: Use dmaengine_prep_config_single_safe() API
      PCI: epf-mhi: Use dmaengine_prep_config_single() to simplify code
      crypto: atmel: Use dmaengine_prep_config_single() API

 Documentation/driver-api/dmaengine/client.rst |   9 ++
 drivers/crypto/atmel-aes.c                    |  10 +--
 drivers/dma/dmaengine.c                       |   3 +
 drivers/dma/dw-edma/dw-edma-core.c            |  41 ++++++---
 drivers/nvme/target/pci-epf.c                 |  21 ++---
 drivers/pci/endpoint/functions/pci-epf-mhi.c  |  52 ++++--------
 drivers/pci/endpoint/functions/pci-epf-test.c |   8 +-
 include/linux/dmaengine.h                     | 117 ++++++++++++++++++++++++--
 8 files changed, 177 insertions(+), 84 deletions(-)
---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251204-dma_prep_config-654170d245a2

Best regards,
--
Frank Li <Frank.Li@nxp.com>


