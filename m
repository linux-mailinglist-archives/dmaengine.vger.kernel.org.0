Return-Path: <dmaengine+bounces-8285-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1842D25A06
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jan 2026 17:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6D0283051312
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jan 2026 16:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1663AA1AE;
	Thu, 15 Jan 2026 16:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VMuZc+FW"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010047.outbound.protection.outlook.com [52.101.69.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5BB3BC4F0;
	Thu, 15 Jan 2026 16:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768493269; cv=fail; b=K97IGgc0ucV59aquQ1kyoBnbzK6/wcWOl7UujWjS5tsvBdHfKoMZrze3MjbOtBQjY5ZrqbvTrxAC8IapUckYAZJNYxC2pnaKct7aDcIJgGZ/t2DUaECwjiiQRDbzcHpA6FNyDa2IORI+uZ1lSapYoNnD8h4lJQAR9qHxcKMuS8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768493269; c=relaxed/simple;
	bh=Mfrzo2V67IVQHgN9EPvBkJRZlHDrWUjyU3Zw+QzpNaU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=d/r0RlarJUHoIeps29W+yjKntpHUO/CYEf5vmvIguvJLigCx2BFBRhs5PzBRaTvoQfX7wFAUsJn7sI4nq0wSxluIuRu0AiDNXzMYW/2H5L1GwMtNSB8wyDZH/zp1zj7DQ/PsxCtPM9JRum8qac9/MbYeofxbsFOOJh45A38Gq4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VMuZc+FW; arc=fail smtp.client-ip=52.101.69.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tP6WhaceW9BY0sjy/XdAhc1cqbMEiXikmqJBG+Hhg44OvsUtXx9ubMLJ+R41e6jQxv2V9LYL2Vy51v2usXnqpEkunIN09JCkbuzFBU2OkG8cbfqz82E+L5mgu5awtXTYUwaIiZG/DuE2uoSdhPVobhuzvG0+yUioWUyxEGhCPVN+18NPONZLX/2H8FxAR32/tBDLfdltYZQqI3tvPf2rEh0gC2OYA33VEXbXiDwkg8C5GQmhcKL9hxDicgatakfF/oPDzpl+6DcT/Y7b06Lswc1yIti7UVPy6DDKSO800igAV0XaRMPty+0lvDrrivxW0XSCY38qVZ9ppzvd9ChrEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ZGvnht0+hVb22RH8M3p8kHrtPUeN9Pc3hEmUr6gpX8=;
 b=Krg8lVLUl27M/F1B4uiW0iCCQzpV+B4xaPKtlIURa47rhOLlQZE4TFcnWXIRkigaFWMbohSL25gKOqd1WrCXDSEA3o0+vTpWw82czLS99zOEofgT7nvzntPIS9iDTGsVevPeg+RdaoeZEJH/rRGcfj0Y5Oco+tAia0zYNgblMzP10A8rnR+BFlCsUHluyD8EExDVIxuh3sXBVNFnWDa7BZCkt8TgUSEIKT2v0rME9GZM5qf0JWu0JpKSv0gyKoPSU+PNIJmpguI4lfald+d+/rqcpywPXuzAmSzBgO1siY2r+hziVtITQj9DAyZdAqRaAIWAbHdtNKfBeBUPLRWu7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ZGvnht0+hVb22RH8M3p8kHrtPUeN9Pc3hEmUr6gpX8=;
 b=VMuZc+FWbMG32Tsw40/4PxsVKJTeo5ffvbZ6lVWGfjO7nyiQDZRnu5NP6up6so70bXN+7k9pBqrDBMmmR8lNmLq5/vB3NYT0DRH0ugLww5dKNmy2Qxv6DLPtMQd0l5ieD720cHWWJBBBKBDTgfE6L0027CEZAXANH9QK6jK60NenHm5V86zyeu960dEy2pxDNno3J7Uk42XiX8+NteHSlfuovwjmWINX94Evd9NIAzXlgV+yVjMkqufEhWHSF8YlFUKQkS6iIIX55sibZ9l15Z68wg8VOGQXqGS2UZ2/sh4SJmUc5jPpJixDGieIiFYiZmoQFOyDFoRUWRTFtFySFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8948.eurprd04.prod.outlook.com (2603:10a6:20b:42f::17)
 by DBBPR04MB7628.eurprd04.prod.outlook.com (2603:10a6:10:204::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 16:07:42 +0000
Received: from AS8PR04MB8948.eurprd04.prod.outlook.com
 ([fe80::843f:752e:60d:3e5e]) by AS8PR04MB8948.eurprd04.prod.outlook.com
 ([fe80::843f:752e:60d:3e5e%4]) with mapi id 15.20.9499.002; Thu, 15 Jan 2026
 16:07:41 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 15 Jan 2026 11:06:50 -0500
Subject: [PATCH v2 11/13] dmaengine: fsl-edma: Use managed API
 dmaenginem_async_device_register()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-mxsdma-module-v2-11-0e1638939d03@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768493221; l=1712;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Mfrzo2V67IVQHgN9EPvBkJRZlHDrWUjyU3Zw+QzpNaU=;
 b=CYQ6h81Ownm3R0DJXRzZPYkZsnx6aG2ATT9ObxFxonHekKvlmR9MLgDqnVuRCP7IQYjlq6UK8
 WhtnuuPeGZpDCbKUR4tmtHOt7w0+Sk7Oa/t/J0dHShf1RZv0PnfFYmc
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
X-MS-TrafficTypeDiagnostic: AS8PR04MB8948:EE_|DBBPR04MB7628:EE_
X-MS-Office365-Filtering-Correlation-Id: 023d4e7a-af4b-4906-5ef4-08de54503630
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q1F2N0VFNmZuSXhnZmp4VWNOUDFvb3VidE5BK0lMZGJXM08zS29xVjJOdFJX?=
 =?utf-8?B?WUNHSElEVTAvcVhiaHNGSGJYRnhGdGI2V3IyRjgzSXFYY0FiTWltbVJFenVj?=
 =?utf-8?B?RFFZdXJ0Q3I3cHBVMTZSUEdqblFXaFMwOElxS0RFSXJIYmM4eEhQcEZteE1N?=
 =?utf-8?B?ZzZOV2h4VVQ0WTErVTZNMWw4Z1plSWZNdWN6TjEzQU9KR3ZEYnVYdGk4Ujg3?=
 =?utf-8?B?aU1VdHpYMHRVa2xpT3NlZmMwQklWbVFuSUJrQmYxS1IyL20xbFl6YnZHSGQ5?=
 =?utf-8?B?Q2FaRUV5R2JrcXpxbU5hTDJaYjFDR3ZNWHgvQVFId1BPNlZwUUo3dFA1UGsw?=
 =?utf-8?B?Z1hCelkrT1pVYytkdUM4bkJ0NEw5ZzR3QVBnZDZ2b3BiUmdlTE43RlVWVEpI?=
 =?utf-8?B?cGZhY2h4VHRnNWh1ZkJKbmJITTdDY1JpLzJYOTVWWCtsUCtscVhjckNEZjQr?=
 =?utf-8?B?TGNhTlVyenJ3N3ZXOEJtSGpzWmZLUGxtL3RVQlNGRUdnQzl1SktHekNDVHhC?=
 =?utf-8?B?cWwyZEVYeXBMdWNndzRvU3FVYWVyUFQzSGJ4LzhwM3dKQ3NtVm9GdlFBU0Jn?=
 =?utf-8?B?UVdHNEtLSkhrQitSdG8rNWJxeGlFdURpZkhXZWtkZXZXSXNMa2w3dEhPQnpq?=
 =?utf-8?B?ZnV3QzIzQ3VJUGtwWVFFWTV5ejdSZVJjMmFVdlFlRmtCYUdxZ0FPT2tkaDlk?=
 =?utf-8?B?dmxZdkpiWXJrZG02Mnp2QmtqNnRwRVA3bUgyd24zeFg3MUthNjVQaDdqTzhk?=
 =?utf-8?B?TEVTTllxUTJaSjlqNjdvckpXcUpTUGR5Zy9vYWVzc2FWNHVnWnM0cUxwZkNH?=
 =?utf-8?B?Sjg4MkdkcVErL1hCQlZMRENRR0tvVmIwNGJ1OHA1eGxmTkNiRGYvcGRCT01j?=
 =?utf-8?B?MGVWMGNBUDZhK2Z6NjlobDNuVVR0c3pCWWNFOTZ3YjNOSXhVb2lLa1g5cWxi?=
 =?utf-8?B?RDZGSFJKREpXdi9TRHFNVDh4YlZMRk1zMEsvVE1hcW13SXdad2tmVngwZFN0?=
 =?utf-8?B?dXN4UEZhSUVVUkVZZ3BQMUxqL2oybXVOd0JJTmZ0S0NYcUdhTVVMMFd5NDFE?=
 =?utf-8?B?VjdzemtSVnl4dCs3SlRrVnVUSlhWTTFiS04xZGNqTWVra1lOcEFNVmtFaDdX?=
 =?utf-8?B?bUJJWllOK1JlQk5OU3BkL0VZd0FnSlZRMnlLNW9GYTd5L2JHNEl1ckd5aUk4?=
 =?utf-8?B?eWdoa3hCcXVROW5VMWRNNnEvQ0VoNnc5VjFzS2RhVnVOWVdpR1Z2T3Fibmcw?=
 =?utf-8?B?QWFURlVRVGVtcjVTRm16Z2U1LzJQa0dCUGtIR09oS2hiSnpraHFaQ3QzNFcx?=
 =?utf-8?B?dlpTVXE4SHVIS2JyWU0xUmtHNHZSSUpYbnZIODZETlYrTDErYmNuaFdXWWda?=
 =?utf-8?B?ZEJKeXhRS2oyazRNekxVMFRiVE1tTGRxbGpuckFUTmc0UU1Ea1BZNzBQb1Jw?=
 =?utf-8?B?aFNTS3Vob0dTSzNoTHJiQ0MzbWwwSysyVXhscVpxME9DcXkzbFU2dDNadG1M?=
 =?utf-8?B?VmNsVERRWlRDeC9CUXFQQkJFQzQ1VjIyend0M0plclBqNjlhTENsYnBvTWcr?=
 =?utf-8?B?TmFYYkZ2UzBUd0pUa0EvV1RtNWhUSEphcm1GMWV1eDZ0TWVYMFZIQXp4bXA0?=
 =?utf-8?B?aFNxRFcwTkxvd2JaWWFva2JUaVg0cUtRYnFNc2Y0UjBkMkdXdUtVMjBuVTZP?=
 =?utf-8?B?NERkUC9YbGpRS2dUWXkrQXFEb053eXkvSkFJMjV0UWVwSGdFSTBVYy9wdENk?=
 =?utf-8?B?R2R3ZDVYUnZJTFR2eitXbktZNjVad3RWYnVYcFVTTjhmT1RFb2tGRlRLYmlQ?=
 =?utf-8?B?QUdyNTRpRkdHenpTdlhnRE5hNTRmOCtmaWNiSHVqNXljSVBURXlxSlZtdjBt?=
 =?utf-8?B?RjRsa0ROdHIxeWprdVhLZkNHMHpoZTZRZ1ZrcWd4R1luVkV2U2ZvcXYrWUFh?=
 =?utf-8?B?Nnp4ck5ENU5JQ1RZbkVOKzgvT0tJS3lSSSs0U0NzU3QzVEozbFFCMUEyaVA3?=
 =?utf-8?B?enNZZGpFNytBOVJHZ2dMODlyTEdzdmI5ZURRT3ZJUDhyUHUwWTBMdWdKWGhL?=
 =?utf-8?B?S00xbE90S3RmamdpRHQ0dS92K3krUXBvdUpicTE2bmRxeTdZcjIrSndNbzBn?=
 =?utf-8?B?VXpHMkpaWm4rc3Q3UlF5TXpvV2FYUDBZdGNSeDE0UFd0Ui9aQ2xDMTdmS1dn?=
 =?utf-8?Q?QplUd/vXr88nyzZSA4SnjLo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8948.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dXAzL3N6NVhaU3VYWm95UFZDN1pYRm1wdy80eGxvUHJ1dnBKUkxKTHc5Wkp4?=
 =?utf-8?B?Wm9EcExRSVNrZUR0c0IwUm5GUkpFQ0YyUkR5Q0N2eis5RmhBSm9PbHYyUTFl?=
 =?utf-8?B?SHRrcCtsNnMyQVR3M3pUTUxDYUYwTm5iK3l0aERZUEU3NWNrOVVIbEx2R2Zk?=
 =?utf-8?B?THlvMnlJK0FQeCtFelBVNHFtQnI1UW9XdHQvYVhMQi8yVWR1bmQ1b3NFWkdC?=
 =?utf-8?B?dVFOdXFmSU5uOVFyZ2JsOVhIa3dUUXQxa3J1SkhmbWsvWUJjYmprY2wwRVR5?=
 =?utf-8?B?eHhLYytJeEJhdUJ2YUZxSzR4NW9ES0RPWGdQT1VPYk0xWk43YktBQndJQjFL?=
 =?utf-8?B?K01jT2NxNUhKemRnV1JScEFYV3h0Q1dBcHFxMFFhd0FYei9zMExTd3hjMXlD?=
 =?utf-8?B?aElZN0g5VTUwQ0RDWGR3RTN3aWhHaGFUT1IxeExSUUlzRHZ3SnRvYkJNVGpx?=
 =?utf-8?B?YlV3WFE4TTQ5MmdoU0pGR3NrV3JqZ3FxRkIzRk9wRE1OSUVMaUo5QXhuUXcv?=
 =?utf-8?B?bkNVMHE2L2hidjlyN2lTSUJyTXU1UXpKVXJoS3cwL3hnYzNOQ2xFcGRnTWRT?=
 =?utf-8?B?YjBkbUFuVlcwbmR3cVI3dWs0RmYyZ2RlMXRVTXhlTzJURFdOUy9ncEtJaXRI?=
 =?utf-8?B?RnQ3c2NZMk4rVFpOOGRPY3QxemhlbHR0MHg5TUc2U29CUXBzM2RPZXRWQlhT?=
 =?utf-8?B?UmNMQWswcU13WTBjdnJyME5hLzQ3MG9RZHNleVZWK2h5cGRCTnJ6SnJLMzJZ?=
 =?utf-8?B?OXNJQVJHUnlnVGg0NmdjaTVwUmY0S1l0Y1hqc0hXcnJTZ2ZTS3YxYmk5N3ZJ?=
 =?utf-8?B?THZ4R0J4TndmM1hkRnVDcHREQU1QT0ZETktQdU1WbGw2NFNWQUc3OU5qL3Q1?=
 =?utf-8?B?aTUzdkdha0dkOVhxZ3FBd0tlNUJrNG5CNGtoaExwTzBwQVRpSDZwbXViL0xp?=
 =?utf-8?B?REp6RDRCcGd5dlZKS3MzalBKYktQczFaUHJFQ3V2MXMxNk1HMkdjZ2tnMXJa?=
 =?utf-8?B?YTI1TThKQTRUV2NWby9DSUVPMG1KYWNuTEIwVlpMekYwNjZMWkhZblVFTXNq?=
 =?utf-8?B?VnlTNTZuaVdUVjc0NGhGbEtRQy85Q0xzakJabnB1NllBdlhBSnRjVmZUMzNF?=
 =?utf-8?B?SmVndmZ4MEJ6cGJjTnQ2ZXJBcXN2NUxnZjA5MEgrV1dmeVhrbUsxelBkYjRY?=
 =?utf-8?B?WW5qUVZXNXNla20rTXM4ajJReTFrUW1BWElIZTN0OTVqU1ZmQit5ZEJIMkMz?=
 =?utf-8?B?WEJ0ekFuMFFNalE2TWR3STdHQnpvd3lTUGV5cWg4TlRudWkxUENvWklFYWtF?=
 =?utf-8?B?NFZBam5aMkhBNkMzRjNQd3M5Z3ZKYnZ1S0l0T0c4VlN1eDdYRFMxdXR6bkhq?=
 =?utf-8?B?MzljcXZ2TGg2bGt1SkFtUzg5WGJXRUUzYWwyRmYxMUFUK3VpWExaNloxcm83?=
 =?utf-8?B?K2R2bmNFaEVFc1cwdVBjZGFtSHVPZndTMEJRSm96Um9JemM3ZDZZUHZaWXY0?=
 =?utf-8?B?ZGJ4WGpMejZ0SUxhU1djM0h6V0x2anRWTXEwSno5VkZxM2dYNEJDYWFlU3VV?=
 =?utf-8?B?aXFmSklYOGlwK1dpRU1tWkExTGlRUDlEMEpUeDNrZTB2aVh3L0NvY2FiUFdD?=
 =?utf-8?B?Z210RFNTeFVjV3hKK1c4alczakM2WDJQaEhhQjNpOC80MkdRWmhFUG4wTHlO?=
 =?utf-8?B?ZkFxZ0RualhUeVdpdUlYNVp0aTI5dVFBUTBCV3E1VEVBeXZ4MXpGU1duTnZx?=
 =?utf-8?B?SllVd21YVmJCanFRQ0NOZVU2OUJJMkRNd2N5eUh3MitnbGNtaHlkRkZUc1hC?=
 =?utf-8?B?a1BRMkQwTDlrODFUSDhMTElnWTlxdWNaNTVndDFIcUVnVlZIWXdOTStIRDJi?=
 =?utf-8?B?MVN2NmNmUXJxTEViQm9YL3NDZ0pBMGFGS1BwS0c2NElHM09meisxWG16cVBZ?=
 =?utf-8?B?cjZwZml4cXc4VHF1dFdPWmN0dHpwclNxakt5NG83L1VvYUwxNzNOQnViR2xK?=
 =?utf-8?B?K3dWZUJOd1FLUUJJMFZrTnhESFN5MXN2UTNuMGtoVUg0bktSQzJrdk9va2gy?=
 =?utf-8?B?U0dlNUl1M3dMT0Y2Y3VONUpaVkcwNFRJWlZJOVpKNFVTWm5hVVdXM3RKUU1K?=
 =?utf-8?B?TTA4UytqR0xLNzlNMi91R0hPRis1a0VWRzdxSzM5LzUxRm1LSk45ZGoxTXJy?=
 =?utf-8?B?UXFqdWtYU2NFaFpSMmRjZXJtUFV3NWx4dk5MVTlra2p5NTdrVFFqV3RXZmhw?=
 =?utf-8?B?clpWUmo2TjVtOXl5Ulh1WjBzUFhNYVVvNFNGdnNUVjBMUEhpOXk3U3RBWXBs?=
 =?utf-8?B?SWVpQzY2ZTZyaC8zVUN0c1ZrMEE3Q1FWSHB1Y1RtdGI5MU1FYVdxdz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 023d4e7a-af4b-4906-5ef4-08de54503630
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8948.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 16:07:41.7438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nuasXcQOI703UuibpAeEVhDcjXC5yxf+Dli6ezIm8265dCHNION4teelxSfDZk9crh9LhnsfxOempAF+/YR2kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7628

Use managed API dmaenginem_async_device_register() and
devm_of_dma_controller_register() to simple code.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-main.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index a753b7cbfa7a3369d17314bc5bc9139c9f8e5c27..c0305fd2ec06c41dfa8396bad6bfc225fd3861f0 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -882,20 +882,19 @@ static int fsl_edma_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, fsl_edma);
 
-	ret = dma_async_device_register(&fsl_edma->dma_dev);
+	ret = dmaenginem_async_device_register(&fsl_edma->dma_dev);
 	if (ret) {
 		dev_err(&pdev->dev,
 			"Can't register Freescale eDMA engine. (%d)\n", ret);
 		return ret;
 	}
 
-	ret = of_dma_controller_register(np,
+	ret = devm_of_dma_controller_register(&pdev->dev, np,
 			drvdata->dmamuxs ? fsl_edma_xlate : fsl_edma3_xlate,
 			fsl_edma);
 	if (ret) {
 		dev_err(&pdev->dev,
 			"Can't register Freescale eDMA of_dma. (%d)\n", ret);
-		dma_async_device_unregister(&fsl_edma->dma_dev);
 		return ret;
 	}
 
@@ -908,12 +907,9 @@ static int fsl_edma_probe(struct platform_device *pdev)
 
 static void fsl_edma_remove(struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.of_node;
 	struct fsl_edma_engine *fsl_edma = platform_get_drvdata(pdev);
 
 	fsl_edma_irq_exit(pdev, fsl_edma);
-	of_dma_controller_free(np);
-	dma_async_device_unregister(&fsl_edma->dma_dev);
 	fsl_edma_cleanup_vchan(&fsl_edma->dma_dev);
 	fsl_disable_clocks(fsl_edma, fsl_edma->drvdata->dmamuxs);
 }

-- 
2.34.1


