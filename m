Return-Path: <dmaengine+bounces-8282-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6203D259CA
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jan 2026 17:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 24A1C3040F3F
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jan 2026 16:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24673BBA1F;
	Thu, 15 Jan 2026 16:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JPJwUCPp"
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013057.outbound.protection.outlook.com [52.101.83.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169443B8D56;
	Thu, 15 Jan 2026 16:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768493259; cv=fail; b=JgyLdpTRmezzGQyuxXiR74dyKI3Wr+6WFHpVMlai3lpnAbfulJXOIpL/qe3nHUfYbqlsoiP5p3YINTQI0mNzV/76wlD2Oi1bM1jPyvIqn3KffWP4JvjCtEnRzmYnxr68+g44K+CfpnGOy71cZ5Rqrrxb91WzmvUTldbDkfSvZkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768493259; c=relaxed/simple;
	bh=21acKHcUXVlPMxacbQqXbX1vyZkf2kl/iSPe+XoSPec=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=pJGiIPxw60+ntDSAS1x3nOLLOewMauMFR+R52ZEKtZOxGFUuscRriJkt0yWw8UjlxEAiv7wDGLyps++s1U0ZXxKZTq9SUjrX4Z5uwfSfyfqNULc8CxMooxc+bWWjGfY30VAgv6KVc95HLa23Odb5Ni9htQ9urt6yY9cNRkrl/Fo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JPJwUCPp; arc=fail smtp.client-ip=52.101.83.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ArkzdXymSwdTrWZWZYbX0lpgXF/dkqiyQOldzORGo4NsHr/hRhKfaONZ2w/pMk2tJ88Lglrh4AMeuMkve3LN+OS93GJs2MUDj8YCnPnu+DAWK864O2+pa5Cw55U5b+q9RGm64rMKtPTiVoIUNhVFopxHO/XQp0bgZu8oSQnZQnZLkssi8rXf8w1XOZCb6WpRTosyTiJwxbYqPKfvaKKu8Gaz2eLXOvoekLBtLNKqfe8SE1EuE+LQ6yn5ILUE7lVut70aSgHl3j9o9cgP7vIjZ7vjqHvTEmdTjkBbJ8prJZ807G/Ks76QR3UqSttzHy1SnKkVbEHF5kpJpgX2qHGsDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LS97WSUBknWNAKTkbFQQbFes3npT1babZw9y8vo6ejc=;
 b=elG5Cht1c9FaCYxE9iMfGL/Hzpr/uzSa21nuS9okjekWebM9SAlljBk/96XMwu4iQO27kHpYyFHr//9dSLzmUaaPLxOAig8/B5iiYrspfDpTOQqn3obaL1a7dk9jCluVrSplzPIqBaUXKZAMVDoKkkQ/2C9U5w1FmvQZT0qsNfmcWrsQi2eqVCdeiHhZ5nGJBTE0WnpJIah1TXm/KecaCfiFh2scd6JWIsFIMaJ2UGkg5ADf0HXrETqQJpPc9qq92ekwGE9UFxkdw0+kgxDc4MC9oe+jsWr2LM1G2NkzY89M/3e1fbFXpeSvc9vFRA16gHK1w25m/uEkoGPgpO9buA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LS97WSUBknWNAKTkbFQQbFes3npT1babZw9y8vo6ejc=;
 b=JPJwUCPpKjwc0KFNL7vyM+up5/XsfUIYL5tlSVeD68z4MRJX8lY29cc6cGMusUg5hC6qczL24o7PSgQi6N0KE75CXCdae+XTaJ8RyAQmXLHDrfBf6chMd/UzC9eWAaPd/sXHz2foO5fQ8ocZ5j5lBbo+XuXsoM2uAiRgXpyGC+hEYbcseh/HzZvn3ax6f29uXVEYJIBBZcYe24jjaxr53+BfcSbVIglusIXnEEG0bAnPBqxnrNlqGyFyMZ80qVNSUkQan9BTDJYl+JL3zfxQ6iUzJQADtwtiPx31utVTyxG5HO/qO16Y8n6PNWZ3BvE1dFJEgb2PhMfI+dvL1N/vWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8948.eurprd04.prod.outlook.com (2603:10a6:20b:42f::17)
 by GV1PR04MB10197.eurprd04.prod.outlook.com (2603:10a6:150:1a4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Thu, 15 Jan
 2026 16:07:31 +0000
Received: from AS8PR04MB8948.eurprd04.prod.outlook.com
 ([fe80::843f:752e:60d:3e5e]) by AS8PR04MB8948.eurprd04.prod.outlook.com
 ([fe80::843f:752e:60d:3e5e%4]) with mapi id 15.20.9499.002; Thu, 15 Jan 2026
 16:07:31 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 15 Jan 2026 11:06:47 -0500
Subject: [PATCH v2 08/13] dmaengine: imx-sdma: Use devm_clk_get_prepared()
 to simplify code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-mxsdma-module-v2-8-0e1638939d03@nxp.com>
References: <20260115-mxsdma-module-v2-0-0e1638939d03@nxp.com>
In-Reply-To: <20260115-mxsdma-module-v2-0-0e1638939d03@nxp.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@freescale.com>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768493221; l=2225;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=21acKHcUXVlPMxacbQqXbX1vyZkf2kl/iSPe+XoSPec=;
 b=5cY3OE/FEP10aV6JrH/32FMJuuluvLQHbr5H6JO9kiQp6wbFrlxh8kbrDVHSzELKBBPWL4PYE
 4L+HrNBNNmpBdPzUirl9Fy37MrfpCTA0CmMerBcwgIds8t0mTqmOW6W
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:510:339::15) To AS8PR04MB8948.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8948:EE_|GV1PR04MB10197:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a894e6d-8522-431b-dad9-08de54503027
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SGNXZlM3VVlKbWp4TzZEQjczSG93S1NBME13REM0cWFZclRKUkNKdDlhVnVZ?=
 =?utf-8?B?NlpSM1lrMzI3bmFPa0o4YlVQT2JreGpEa0NYamwwTGVQVDVwcnBuaGJEQlAr?=
 =?utf-8?B?WXlZVU1CeVRMTEhiWVFlemtCanlEUzV0OEhWTjMwU1FqVGJHaXM5Y3BUZlJp?=
 =?utf-8?B?S0piYnZBT056UGJub3BoOGJ1a3p6M1I5S0h5NlJ0dnZZYitRTHZ6YUdTcnVm?=
 =?utf-8?B?clBXV2Q0aHJQZ2d6SUdkNmdVWm51SWlOa0dlNzQreEFlTGZ2S2JuMDlUWGdv?=
 =?utf-8?B?aW9ZR2xaZUFSWGRqc2RrTHR4YlRIK2cyc3RxOG92NHRZSHcwS2dSaWRoN0dJ?=
 =?utf-8?B?K2dLRUpYMkZiWUVYWFkyWXVXZHdUQm9TYmROM3pwODVUVURIODJka2plWEVY?=
 =?utf-8?B?Z0tlK2pDdW9DNXB0ZXpCR3dOa29nZUJyYStUUSs2djliM29RanBRaktNc1RJ?=
 =?utf-8?B?SXdYT1NEQ3JKQTM2dHNmTU9FYnJFVE5XK3BYVTBuSzZDRjVEUk43R0JSTkhZ?=
 =?utf-8?B?SFF0Y3ROT2JFc1UwNTJ2aWd3cjJPcTFSZk45Z29vZ01wM2ZwR2dpU0lpeHpV?=
 =?utf-8?B?Z1dqUExlRW4xRk9wVTdBM3NpRHNaNlJiQ2NaSy90dVFiN0h5V0huelQ2Y0Zl?=
 =?utf-8?B?K3o3MWU0eHd6bFFjSS9wOG8zMGJOTjJiRHpEa2E3d0JHbXpzaGhsMVBXTjFv?=
 =?utf-8?B?dVpEb3hVbHAwNGZiaCtmUWJTT1J4a1dJWTdlQVFWMTNtRXlWZGhCYmxLRXBx?=
 =?utf-8?B?VERmcUlTVWRZVzRodFZFTHBvNm9XOElJRmNMUmZ2UjRVRzF5cGtqYVVTcnZI?=
 =?utf-8?B?MkhtVFQxeGlGaXFBbHZQVjhGVERnNWZ6WW04Z3poK2QrQjNXVS9TalE3T3pJ?=
 =?utf-8?B?Nlp6TGlUeW9STzk0U011TzhURTBjL0tFbUpKWmwySkd4TUtTME13S2tjdWsv?=
 =?utf-8?B?bVRhS2w0T0o0NEwzcUlwdFFTakJnTjBqQ1ZtUHFuUXE3cTl0MW53cDB1bWxO?=
 =?utf-8?B?Z2VyUHUrbWtScEcrMElJOEFhOGRTWjgxRE1zQWltbCtvT2V5MEZwMVZROHpB?=
 =?utf-8?B?YmpMcENZWC9zeDQvTzUxb01EQU5MeEhiS2t2ZUxRWXRWWjBxdmY3aXZIbUhv?=
 =?utf-8?B?UTJvL1F5R0RWREY0b3VySGw0SUoxcm81eUtjc3F2NG1MamZNR2RXWFlNaVov?=
 =?utf-8?B?dzdET0JZVW90ZkFaUFEyU0p2T25yT3BFN2tnSW04UU9nUXhENWZqekJ4M2RK?=
 =?utf-8?B?ODh5Mm9kcXNVMVJTVkl2SjFrWFloRk8zVTBvN1pKTWNVaU1iNkNHcGIyMWk1?=
 =?utf-8?B?cG14L0FkVVEvTThDZXl1clFUb3dERXJhYTVVbDh0UjU2cWRWVksxdm54dUFP?=
 =?utf-8?B?MzBzMHcvZjF0VGtNQVRIRmQ2aGtaZWlyYXVET0RjaWliazFwMzJ2WHJ6Z053?=
 =?utf-8?B?S2pJRHF6dUExQndWSHZ5NmNmVHkvQkozL3JsMHVjVjN4bW5Pb2gwMWpZZUpV?=
 =?utf-8?B?ZGFJMnlHTVdLZ1FrSXZyN3FPc2l1UklCczFyTVNVL0w0czJmUjlqdHgrLzFI?=
 =?utf-8?B?eVQvb2dFdlZnY3NGWjA5Mkd4b1lQdTNTNWlWRFNsUCt0VjRyUFBpQVVwNTY4?=
 =?utf-8?B?RWZCSHNIYjNJUk5NcTlHSmNjZkNwNG9zaUN4VEVmcGZMdklLTFU5enpSbG5v?=
 =?utf-8?B?dEdLdm1mWjFuNHhUM3B1eEtxU2RjcTJLVFRzZmJDRGRPdTlWdXlQODhEazJV?=
 =?utf-8?B?NUI1NVZZb2xpUGZmc2hhWWM3ekQrU2JxUXpUUUVvYThCMG40aFNZbnAzQnd0?=
 =?utf-8?B?bE1nS3phcmVXa01MN3FzcnNkYmNoNEhzM2Yrc0ZuNGJJVTRoVndjL004SXBl?=
 =?utf-8?B?NHRROVNiRlBQc0pDUDhEREVBMk8rTGFjMjA0cThYL0FnSHpaV1JaNVJGYm5G?=
 =?utf-8?B?amFleWRpWkNrNGZIaHc0K3UrS2ZKb1JOaTVQK2NYbDNuSUdFSW8yVGdnWm9J?=
 =?utf-8?B?dVJSaU5Xd2JIRnExQVlCR0RxK2U0Vkc4RGt1OTNEb1d4bmkvbHdPMURnOFlJ?=
 =?utf-8?B?TThTaXdTRU5xZnFUMkJDZ2toelROa0ZvQTlXMGZLWGF2RzJqNkE3cmx2OUxu?=
 =?utf-8?B?YmlJbVN3ZGdUTEdCUEVmeHEvN2U1WnF2blJGV0lpOHM3WFdTYm1zb2JYR0JM?=
 =?utf-8?Q?Q3WwQ4EfM5EtQKPdnguUU18=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8948.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WlcyL3JhUEFvcVVhOTRaRit6MzBZbEN2dDNnNFhOZ3JZUzAyc1Q4MlI4ZHVX?=
 =?utf-8?B?dlEwVVFiUmprc2YyczR5aGpJYU9kNHJodlBuWGhMN3ZBL0MwUU4wNXAxZ3d4?=
 =?utf-8?B?VnVhUjdaVTI5NUVSM3A1NEwvRTE5cUFQRVN6bEczRGdkb1ZFSmZMcnlRSlZX?=
 =?utf-8?B?dy9vK1dnUGhBZ2dSWE45R3RJRk5nbVA0TmhPV3lxN1ZpZ0dIbm0rUGJhRFY2?=
 =?utf-8?B?Wk9jdE9nZk5VZGxqN2liVkFwU2MxMHpSMlh0blpjV0FZMFJTd3NXYnVKWG9O?=
 =?utf-8?B?QzByV05LdjdTK3R2MjRobWpaaWxBUjZZc0JRdXJZTlhRK0RFUEkwbFBkeFJa?=
 =?utf-8?B?MVRUQ0VBREx6VW1VK2NpRWtOZy9KbHhxa0tpdmtVYmpkK1QwUitFVUxCRklU?=
 =?utf-8?B?UDRrL1ludmo2di85YkxaUnlaUXllWUJ4d1VuOWl6NnZyNkljYlBDU0tSR0xI?=
 =?utf-8?B?MkRuaFFEaFkvSURMdHpCcFlhbm1rcUcveHVVUDhiV2NQOXpXVE1qU3ZsMkE1?=
 =?utf-8?B?am84YU1jZzVmTVRFQnpzWTlSUFU4WGpxdUhBWVlVNWNQQXdsTVBrVTBMbHRB?=
 =?utf-8?B?ZjRuMmhvYjVERkZXR25zM1hxaGVDR3BBRUxDcU5UcnZyY21ibDUrRlZQYXVD?=
 =?utf-8?B?MnlkOWdHemcrUVVtU25RK2YrbFhFY21uaEdobjl5aE1BUjV3QUZnNzB6YStW?=
 =?utf-8?B?dWR5T3lGV3RHV3pNZ3RQZnJ6TGFORFRSMW5PcWlzeDB5anZYRW5XRXZZYjFM?=
 =?utf-8?B?VDQ3cmx0VFQ5MCtrcmkvR3lLUnJOMm5zL2VhNlQzREY3UWhSTk9RSlhCaTVv?=
 =?utf-8?B?a3pEUldLRENYK25QQnFZZkQxS2RVUTY5YnUvUTUxZHQwc1diend6dWlqVDJO?=
 =?utf-8?B?bkxyb2pDR2ExR0N3SThmQWRvUDJBYktiZ2xjSDZha3RMbldLL3BFZ2NMSkFM?=
 =?utf-8?B?cWVqaFFCcmNTNlQ0OVNDYnBtZUVodmJjVEgrTWg3c0U0R3R0K1ZaQ3lYVlF0?=
 =?utf-8?B?ZzQ1UDVFZjRPRWpkUU9HbG8zZFBwd1RKb0Vqa3VBMk8yWWxsMFhoOFFCVTYw?=
 =?utf-8?B?a0Z5QnhJa3RBOFRrOVVpM1Q0U01Da2QxT09jS1M3MHNSMlNZYzk0a214UkVa?=
 =?utf-8?B?ckdORVU4QVA3bFk3ek9hUVFwUlJ5QkdZdzFlZE8ybkhjb29SSW5YamtuVklS?=
 =?utf-8?B?SDM4VlY0aStUb29TdjIyajhZRXR0WHRVbUFoS0kvRGdUcFYreVZ0OUdFZEZ4?=
 =?utf-8?B?QjRTYXd6TnBiVnJNRkRQOHlJdGtGVE13RzhONmQ3N1VvSE1qRkFSNkxCd3N3?=
 =?utf-8?B?MWNCS0RXUWNUY1hOd0E5UUZpV0s5VWE5UTB4azFkYjJzT1N0OWUzanBBai8y?=
 =?utf-8?B?ZGpBWDhJZUhKSS9pTi8xcGcyUmdOSUtoR3BOZ3pZMmFGazc5bTh1bm5heWVM?=
 =?utf-8?B?b0hOblRoemtTZzExb0xlZUhiWkVTSE1zS0owbi9Ub3c3NlJnWUExSytWNVBL?=
 =?utf-8?B?Q21FQ2VVN3JBQzluTXFPdjF0MGl3dlREWEdwcS9RSERmT1l5UkcrTUdKUlNl?=
 =?utf-8?B?MVZtbUl5dURhUHB2b1JCQlpFN0JKbHFEZWNvMFFXQVZObk03ZHJVZXhlbjFH?=
 =?utf-8?B?Z0dYNE5uTFYvZUwvT3NjRWlTWmtTVUJQNndkMzhtMzRVaWxPcWhSd0lXVjFa?=
 =?utf-8?B?aGNXSWVwejBMU1FDUFZ3QzBKQ0ZGRHg5V1FTNlRaRzBxRjVnL3dsSFp4dEJx?=
 =?utf-8?B?dTM4bXZxNDN5T09CY0YwNEM2d3JlOWJEN1FhY2tZckgxU0dJM0Fsdk4rM0lR?=
 =?utf-8?B?WnRUNjJQVjBOZnVQUndKMlJHK0NTUm1HVmM4dkJBNjA4WEQvNjMyM2hSa3Bz?=
 =?utf-8?B?M21jWU9SaGVBVDRXbXo3Q09veDl0b011UmxhT3dXUGc4N3N6N0NhK3ZLUVEv?=
 =?utf-8?B?d3dDR0cyUXZSblVWQm5mVTdMQTFxbjlFOGZKc09vMmNpRHVvN3h1bC82NXdi?=
 =?utf-8?B?eldrenM5YTVDcjIzaTNNd3p1bGp1YkljSUNnMWFyaUd1M2MyVitpMHVURlFE?=
 =?utf-8?B?aEUra2dDRUdBK2c3NU5XZHFTQWovODM1U2JIaUhLa2RyV3BYS28zUUlGMzdO?=
 =?utf-8?B?OWgxOWdWTGZETytteEg2R1Bnb0xTcXJJUmRDVm9MVEw2Um1DMFlwTW1YN2xW?=
 =?utf-8?B?RXJYTnRHZTNZTEUvU1ovelp0OGh1Yk5lSU5KUzNTWk00SUhMTTRQN0IxdzI5?=
 =?utf-8?B?K0N2QUM0NVBRWUJNZU1YM0E2VlFQRHRXZ1lvYXFBcERnNUhTNnlNTGtxMlFQ?=
 =?utf-8?B?d2MrWGdBRXdCdVlRTG5DMzVQZEY0M25hMVhPSnFGT0Fabk5Hcmg4dz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a894e6d-8522-431b-dad9-08de54503027
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8948.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 16:07:31.6946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +8UBwWQNo+BsPkxNbYmygtrJ9uX8FfLIUzulV0QoYMR9P0BHQrM+okx7Js6JG96V/xbT3hqXVWGVd/OOidY5wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10197

Use devm_clk_get_prepared() to simplify code. No functional change.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/imx-sdma.c | 26 +++++---------------------
 1 file changed, 5 insertions(+), 21 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index ed9e56de5a9b9484c6598d438f66a836504818be..f7518f567ecd707575e73803a94c2c1d4762f3f4 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -2265,34 +2265,24 @@ static int sdma_probe(struct platform_device *pdev)
 	if (IS_ERR(sdma->regs))
 		return PTR_ERR(sdma->regs);
 
-	sdma->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
+	sdma->clk_ipg = devm_clk_get_prepared(&pdev->dev, "ipg");
 	if (IS_ERR(sdma->clk_ipg))
 		return PTR_ERR(sdma->clk_ipg);
 
-	sdma->clk_ahb = devm_clk_get(&pdev->dev, "ahb");
+	sdma->clk_ahb = devm_clk_get_prepared(&pdev->dev, "ahb");
 	if (IS_ERR(sdma->clk_ahb))
 		return PTR_ERR(sdma->clk_ahb);
 
-	ret = clk_prepare(sdma->clk_ipg);
-	if (ret)
-		return ret;
-
-	ret = clk_prepare(sdma->clk_ahb);
-	if (ret)
-		goto err_clk;
-
 	ret = devm_request_irq(&pdev->dev, irq, sdma_int_handler, 0,
 				dev_name(&pdev->dev), sdma);
 	if (ret)
-		goto err_irq;
+		return ret;
 
 	sdma->irq = irq;
 
 	sdma->script_addrs = kzalloc(sizeof(*sdma->script_addrs), GFP_KERNEL);
-	if (!sdma->script_addrs) {
-		ret = -ENOMEM;
-		goto err_irq;
-	}
+	if (!sdma->script_addrs)
+		return -ENOMEM;
 
 	/* initially no scripts available */
 	saddr_arr = (s32 *)sdma->script_addrs;
@@ -2406,10 +2396,6 @@ static int sdma_probe(struct platform_device *pdev)
 	dma_async_device_unregister(&sdma->dma_device);
 err_init:
 	kfree(sdma->script_addrs);
-err_irq:
-	clk_unprepare(sdma->clk_ahb);
-err_clk:
-	clk_unprepare(sdma->clk_ipg);
 	return ret;
 }
 
@@ -2421,8 +2407,6 @@ static void sdma_remove(struct platform_device *pdev)
 	devm_free_irq(&pdev->dev, sdma->irq, sdma);
 	dma_async_device_unregister(&sdma->dma_device);
 	kfree(sdma->script_addrs);
-	clk_unprepare(sdma->clk_ahb);
-	clk_unprepare(sdma->clk_ipg);
 	/* Kill the tasklet */
 	for (i = 0; i < MAX_DMA_CHANNELS; i++) {
 		struct sdma_channel *sdmac = &sdma->channel[i];

-- 
2.34.1


