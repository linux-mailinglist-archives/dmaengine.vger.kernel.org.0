Return-Path: <dmaengine+bounces-8284-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 440B1D259EE
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jan 2026 17:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DA745304BA74
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jan 2026 16:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8763BC4ED;
	Thu, 15 Jan 2026 16:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="We1FfH0c"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010047.outbound.protection.outlook.com [52.101.69.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC2C3BC4DE;
	Thu, 15 Jan 2026 16:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768493265; cv=fail; b=HITGsnTTjOe9O46OWl+yNr3sBtHkWR/iLMumlcjKFsKLEGPvKVYbywxl2RiRu3hQVkjxqWLGI3Z6lWf83yJcyJHrNzIDyN9wVQvHsBjvNQIoKL7C4l8M1ZnWU1N1xc0gSKNgGsYRYzlRkXN8Ux1XpoW1UqqSDviwZe5UaO14fy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768493265; c=relaxed/simple;
	bh=r+IbCiI25ZoU6GRJDU7U1RA50qUD/Z8BZWI6/kAZFcA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=auBhSQ7lQVEo2CzmzaOUw+8EN94ppZGA5N7IrPqfyCym22OSsey/s/5KFyRx8g6LjA8nVsKlIPn8qEPsffOFV3RqmacCAzj3hIFKui39rMUcvQOc12sFrA9eB16uIYkwe621dsAZhy67M8JvgsYnEgOv5bOpZPF5fQ/irkPJZdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=We1FfH0c; arc=fail smtp.client-ip=52.101.69.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fwuzhHd+TtVNeaosOe9cYXKBmGGRBZv638mtby+H3j1d3vIuwX9Xl7fQswJI7OZOgEZdjaeqWwNWxRuAeD/0WzyvidU3qx54Zx1OPjrD/XMyAsP3WEHkz8rgcXX0WjBCSaMi7L+pc5wNpxmdmtKkP4s+KteoYn3nyg+BSuunZY87UTTbp/U5nQBLMTSV/1reJEoTNbICLFG7dOCQq8G/8J1Hnv56J1ozFYAmYYlG3aGDI1oFWqlexJ8CuQpUEznLsN2K63FgJruM42rPb+1sJtT5GwiqY2eMxfWyiyTdmiOcTu1F6kg39oaFV9Vt/1qvOOfqU0g7hwy56wS0ac/GJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gaBMwLFkSlCHfw3N6fsoNN2r/JfR+CHTYdcr6cQb2j0=;
 b=Reboqk9T8hNjNF+h+ilWDM+OAGaN3R/04CyhJ1ocrAmdVpnMjwJ3FqiM3ZfR7Ua2jwh9s6Rv1PMekOzbpVnSm2LgY4d3L+1wenzzDUGS3bXZHYFmEgrgzQliFa6lTv6A2DH58Cnyi4b4IGOn43LwoF0vJmtyMiu2eLfoIbbGxcpDvNx2Mg0Gd3UXd37Ev07skADok9+JZM077+S4GK/KVc8ET+VZpv+uDQpAWaTlROSjmGTjn4dD8nzkCH5EhFltt0WB1vKKtj9ix3jDcS756+ruRoXbxZSv+gupu3NOjBmbCLgPFfmbqckqfbrT0X++scXh6xcA/GtT0h0W/GmDew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gaBMwLFkSlCHfw3N6fsoNN2r/JfR+CHTYdcr6cQb2j0=;
 b=We1FfH0cKs+zBDKoeE6i13yIeZdgr5nRQDm2u1ywurSkFU2nceuxIUwg7Birya8CoNHK817rfJXNsliflBpxQRvHESh5uGT9A/pMcqphx0vS2HOWeS1AVUyKHD0461YcwvsLHHCwODvLb0it7JH8Cmfp+EmtTuX3G/7V61ZUy07T2VAgQuchUWSdFNe4Rrk747FT2vx4Xd40z7BxhvTBz0aqigoTDLHIQcWrBavREyzx0B8xLV2QnyM40htNiVPyPPiXfAIttBcUYyxs3sGr4qnlA3Z9ux47SfSskvu0VZ2vo2vSTvSjOpqe1eUbpsxApMSkgdo0+hYzG6rx8e40GA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8948.eurprd04.prod.outlook.com (2603:10a6:20b:42f::17)
 by DBBPR04MB7628.eurprd04.prod.outlook.com (2603:10a6:10:204::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 16:07:38 +0000
Received: from AS8PR04MB8948.eurprd04.prod.outlook.com
 ([fe80::843f:752e:60d:3e5e]) by AS8PR04MB8948.eurprd04.prod.outlook.com
 ([fe80::843f:752e:60d:3e5e%4]) with mapi id 15.20.9499.002; Thu, 15 Jan 2026
 16:07:38 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 15 Jan 2026 11:06:49 -0500
Subject: [PATCH v2 10/13] dmaengine: imx-sdma: Use dev_err_probe() to
 simplify code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-mxsdma-module-v2-10-0e1638939d03@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768493221; l=1223;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=r+IbCiI25ZoU6GRJDU7U1RA50qUD/Z8BZWI6/kAZFcA=;
 b=LRJ9TiB7htknIVkwo04rDnqEJO6ngzKAATY7F8kjBqps2QOhOz503tV4/C7ijVtANHi6pR8EC
 AyQR/V+/sXqDeQO893Ypp5mo6VgjXI3hQZPDjuE88Fi3LzqOBRvPmJW
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
X-MS-Office365-Filtering-Correlation-Id: 8ec627ee-32d1-44a2-d38c-08de54503431
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OWIzUDMxeGdlUFFNbktWbEt2bWZhQ1pPSEYyTWlKY1JmcG92bDRBYVVxNEtq?=
 =?utf-8?B?dVpNR0pqclRXcFdLb1BpNWx1Qk51a0pLcm1Fcm95SWw5cXhweXdsN3JWUU1t?=
 =?utf-8?B?aHZlSWprMnVWUXNXWWkvQm52R2ZEakVvZmlNM1ZFSEZxQmF2OHJJM0dNYWFN?=
 =?utf-8?B?U045K2VDNG0rTm5SREpxcVlyakRkVFJTL1ZyYWtLMDB1S2laeTZPWHZpMGNK?=
 =?utf-8?B?aGZjTGJHUk5XRkFYeEd1UUxKMHVJRjZSWHNhVmtQaWExc09uclZEYU85aFhK?=
 =?utf-8?B?UHVKbC92Qko5VmRnd2RQRC80enRNTmp2Qml5S0tERUlNSGs5S0hXZURRNExj?=
 =?utf-8?B?V241RWhEWjhWZHRhbjdhcEE4Uk1SN2ZsSVMzWHdnR3YyTGE1TWZrR0p6U1Vj?=
 =?utf-8?B?a1AyQ09rUHh6S29BNno3YldwSnN1aVNvSW1Kek5SeFBiWkJZY1RORzA1MU1K?=
 =?utf-8?B?dHdWalhTTEl3Z2tVaXpCSmtTSjZVQVJzSVppb2l0T2JoemZSc1RFbElhdnkr?=
 =?utf-8?B?bndRUm5jL1Y4Mml6YnN3MUo1cGQzbi81ZStnTmpTU2ZxQ29jRWVBMzZOUlY1?=
 =?utf-8?B?dXAvNzFqbEpPcFFMZDFHZWM0R0hWWGQ1QTBrUnFvYVZhenFYeWVEZUtmbTFz?=
 =?utf-8?B?elR6bXNBUVFWQlNYTzZSaThOSHB2NVU5NStvdkcyZHhLMHRxYjNCMDlNMVNV?=
 =?utf-8?B?QzZBQ2lVWTg1aEEwWHU1andPQ09jeEI3RVlMN2Yyc0dTNTFjdFg1N1BpK1lr?=
 =?utf-8?B?QlVWM3EySFRUTitKd0QzZEZyOVYxa1M3UDZGbm82ZUNqK0RlcE9oTVNseURE?=
 =?utf-8?B?V1E2Z3k4NWJTTUt6VElvclg4N3B2TWJrSi9aQ2Nmenp4TmU3TVQyRmRUdEVu?=
 =?utf-8?B?S3UzT2tsU1h1V1hDTk5NWW9VaFk5enJseEtwc01HWGZrb3htNFh3ZEMzMGpM?=
 =?utf-8?B?NUxWWFpsVjdTRDlXSW03NzFtTkkzQnVzZ3FzTFhseUNRRGs1R1VJNUxIOVhG?=
 =?utf-8?B?cUNyYmViM242cG1uZEFBUEJPbXR5UnltQWdBaWRjRHcxK3BQY0RHZHU1T0xv?=
 =?utf-8?B?cm9LWHpZbjYvUktnckM4MldYRk1PYncyVTZaZWV3K3h6UWZsdU16MHRWK01E?=
 =?utf-8?B?Vm5XUEJNYjdINTVmSEpJNUpBZE11NUhpd2ZZdElKdVlZd2ZjemsxUnFJVC9O?=
 =?utf-8?B?dUdZVVI5VlR5ckJQc0h5dDNzVVpUMkpxNytwWkhsZVFkSXJOU1hjeWE4cnBK?=
 =?utf-8?B?TmtDaWt5RVYraFJ3MzA3QVhNTHl3OHBqTHBRTE9waXkwOFN6MUc1bDMvT0o3?=
 =?utf-8?B?TGxESVRqbDFxOWlqWjZoUC9vSzhBNVZRcE0wODd4akNRVmRmOHlHMzYzNmF0?=
 =?utf-8?B?bkVRQnNGL1BrUGZUK1lRVXNaL3hDVmhUSThteEhHL0gweSt0RFo4eFNnVFk0?=
 =?utf-8?B?UVMvRlVpbVQ1OHdhVFdGa2gyMll0eURCcHI5aHpnODUwdXBQRHhtNGVMMXhC?=
 =?utf-8?B?b1hRN1FpOU9aQTkvd2ozb0F4R3NUK2dSOGlxZklCM3FtbFlpN2ViaWc3ZXV0?=
 =?utf-8?B?WFJIcTFnbUc4Q1k1Yzd0cFRMV3VTMnVGR3ZDaWhReGZ1VTM2dkRmQlFUVHFl?=
 =?utf-8?B?enhBY0Jwc2ovUzBNZHFCSXkyUVNDb1ZpMjNNenlxWHFtem81OTM4dHd4RDMw?=
 =?utf-8?B?My8xZXBJMEN5RlM5OFNWQm9idlNwd1VyRS8yUm9Cb2pQbXd6U2o4TEJ0Z0FW?=
 =?utf-8?B?Qk8xaHhScnZyTWcwdXhZQk9KTTBUTjIwMlJ1WkJyNy94WW1RQ0EwR3pJeGxJ?=
 =?utf-8?B?a29ITVlTcFVVaVB4UUY4NFowQWIwZ2RaSEYwUHpIdXpTbEwwcjF0dFJ1Q0pH?=
 =?utf-8?B?QXhNSmhrNnNCcDU0di83aXVFaEd2eDhQS3lLL05wbWNkOCtzQjNabHZNdW5x?=
 =?utf-8?B?ZThFRzVKTC9iNEl5aU5ibzBqdURtc05vdWdYc3RBYlZPdzBON0pwaCtIc1FE?=
 =?utf-8?B?UVdFaDR5KzBIbWhxSzBudDBPcGE5U0lZSTY2VFNIc1dHMk9lbklXMWJvVHVs?=
 =?utf-8?B?SXRCV00vcTdYODQ1RHFYeVdBdzBpNVEvUU1ody9ZV3FKenpaQWwrVjhmemdV?=
 =?utf-8?B?SmpQMUJEdjRJRW1JZ0IwQnRYRVZTNS9VL04zSFNsTS85U1VQYk40Sy9SSzcy?=
 =?utf-8?Q?ESzd7ACHmGo5R6EvRe4T4d8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8948.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UzBHeFRGUHBsM1dDTkhva0MxTzJERjBwVnpDS09OUjJLcmlxcGx4YVptUEIr?=
 =?utf-8?B?R081a3VJclRkZTByODZBNnhVTnFYM1dIZDFXWDMvUiszNlRyd0I4UWlsSjNm?=
 =?utf-8?B?UG9ScGJUbmFVd0ppV1BHbG55SXluNGtJc0U2SXJkNjhFNU5weGt3VEZSakMr?=
 =?utf-8?B?ZjdCZnB4bTM1K1k1aGk0NGEweDNOcXV0N2lXeWRYSzlGUGVEa09rS2tCd1o1?=
 =?utf-8?B?Ukl4UzE2NTBNa3lYM2VoRFFtU25SNWtGNkNrYS9meHBhVUZrWkFmSkp3b0x4?=
 =?utf-8?B?Z1RtMUc2bEoybjlwa2l5QTlhK1RoR3JCK3RjOWg5Rlo5Vys0QnRRbGNacGJU?=
 =?utf-8?B?b0JNZGg4UmhZbzZBeFk3c3BUUmNPN2czemdaR2NTWE9LUm04U1Vyek9YbzZ2?=
 =?utf-8?B?Wng1bHliYnptTnFRaEhGR1NnWThRZUQ2WWlIbzUwanNEOU9vdEdMZlRmZjdu?=
 =?utf-8?B?ajhYbFRueFdEbFdkUjZKaEk4WmVmQU0yOHlRSUdnUngrTmhpaEhCcjZ2aUEz?=
 =?utf-8?B?WTBXaUVqUDdXai9sVG5ocmpVRWdSTDQ4TGRBbEFUQTZrMjNwbnVacURIcjR5?=
 =?utf-8?B?a1luWWJtRW9hcXRYR2JKL1ovOGdjbk9SbW9udWo5dFFOVDkvc2ZCR1JNeGhn?=
 =?utf-8?B?dUxaMHpQUzd0Y1IwaXVENEQxYnMxazZZazRkRjdla2I0YjRMNjdWVzU2ekpR?=
 =?utf-8?B?U20wTndWb3NISERVa3BadGdVV1RLNG0wcjFlTERJcm9kbE02ZXlUY3I0bSs1?=
 =?utf-8?B?b21UTGsyZUlPa2lKUm9iQ0VRQXpORkZqdE1nUlQ0U3BuaXF1blFhekwrSjFs?=
 =?utf-8?B?aEJCK2Vac08wdVowUGNkRWxkdjV0eUx3OGZPNWVwbjhaMzErU05iVFBIekJ1?=
 =?utf-8?B?ZFdINnBDZFlsdmNTSTdwZ1NKQ2Z2RG5XN2tvZEJGVGxFbzN1TEgwQmwrR1ZP?=
 =?utf-8?B?MFhMR2o3Lzk2VkZqWitaMGFCK0JJdjNPZ2ovdUxuT0xtVDdYQWhzQTBGdHY1?=
 =?utf-8?B?c2VIYWRyVDhiSk9DUXJaVzhkcHlTRnJZLy9Dc2M0SDF0U1NUQTlBT2hIaUxk?=
 =?utf-8?B?c2VES1hubldyQkpHTmRwRm5FeDJadWZ6YWpFVFprbHRJUVNyYmpDZC8yTXIx?=
 =?utf-8?B?S2htTTFaeHh2MmRMeGNxTlJ1VVFnTlNKZ1JIT3l3NXBnRUVGa0hKTUt3Q1hR?=
 =?utf-8?B?alNhWk5PcUUwazlib0FRdWViUE41V2VrWnF2TGEzRE1aaGkybHQ4enhFbU5H?=
 =?utf-8?B?d25HR1phV0FqcVV2MW5QZUFEMUpiU0IrbU5XZVlVQ1NabSt3Qk9DMmNWSHFB?=
 =?utf-8?B?bCswaXc1MFY5T1JOTHl6YVVoT2FoQUxnZVBRU2JNdlR4MXU0VndWWnA0Q1ZY?=
 =?utf-8?B?YXlRNk5acm50U1JPUW1MUFFibFE3S0dJcDhGWGE4eTBhUUNyWjBheTRreGZM?=
 =?utf-8?B?ejNYNitVbTJlRjV3YkIvRHgxTlhGcXR4aCtyT2V1VUduRThqN29ZbGNJZ3F6?=
 =?utf-8?B?MXE5MFlKT2owWkppR2dmN3JSZDYrQlc0cWtsSGV6ayswMGJCRzFwb2tUZVJH?=
 =?utf-8?B?bGxDZkNFMXUzblUybVhxdWpxWDlOT2w4VC9hUDVISU92b3dTUHFrTW14TFUv?=
 =?utf-8?B?M3k1aDJMWEF1VytkMXBWRHhUNnJ6bHZtUWFqd1hHdy9SM1BZTm53cUFkN25s?=
 =?utf-8?B?OU1LM0xwSzZ6c3g2YWFpOFhybTVyUDROWHRYeHpyUmpCL0FwSTUweDl1TTFJ?=
 =?utf-8?B?Q1dsZ0NCQVBqOFdWYVpnYkcxS2wyYmZ2MXkrU3EwR2EvVHBYQld2VUhsdWpz?=
 =?utf-8?B?Vmt6YjR0L3FpVTRhVWdBaG93YXl3N3BMOHhSTFRiZjJFYVozQ1ZJTFppWWJP?=
 =?utf-8?B?Z3J6WGpaa3NXQWFsRHJPMFp6WGhwZ3gxbk9JYkloWjJLVi9lNXdQNFBRbSt2?=
 =?utf-8?B?S1k3ODNjOU5hSTkzZHFlQm1qOGZDcXVPQ3hrQzZ4dGNWYTUwUFQ2aEFNaERz?=
 =?utf-8?B?dW1oS21aTlJqNWFSNFEvc09XOHppTitsQVFmVU9aR1FQcFU2SVVmbklBaGxN?=
 =?utf-8?B?d0M1UkRUc2JPS0d0ejNIQlNSQjA0S285d3hVenJMMkFtT2huQlVHdFYvL0d0?=
 =?utf-8?B?N3JreDRiVVdtNkFaZDdqUVVUSFhaVDh2a0xwa1pOQ3R0NHpHOUhTZ0JGZFpt?=
 =?utf-8?B?ZEVFMEdnRlBPYlpVYkExcVJGRjkydCtrYTBGUENrT2F3UDAwNUNqSDZnWlhM?=
 =?utf-8?B?NzlyQmF1S0dJTW85TEZ4WU9VVnhpbTRublhZbmRkY1VuVnVydmxhVWFnQ2lT?=
 =?utf-8?B?R21kSkdKb1ZydmwwVGlIRVc4TkswMUpmaGVlbFJJdmxLMWlWTllodz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ec627ee-32d1-44a2-d38c-08de54503431
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8948.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 16:07:38.4031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TkMoSRaWi16iKp5axq4OlKbibgCN55/tl96PhA5VtBePcW2EsvsBxp5rT/PHmjVIQ0XGQx15mjGOH6ut5UyukQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7628

Use dev_err_probe() to simplify code. No functional change.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/imx-sdma.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 95458ea188e3b0fc4e4f861df567c1c7524a3029..543ac44873696a2091e5aab0f47bd1af2af9d1ad 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -2356,18 +2356,15 @@ static int sdma_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, sdma);
 
 	ret = dmaenginem_async_device_register(&sdma->dma_device);
-	if (ret) {
-		dev_err(&pdev->dev, "unable to register\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "unable to register\n");
 
 	if (np) {
 		ret = devm_of_dma_controller_register(&pdev->dev, np,
 						      sdma_xlate, sdma);
-		if (ret) {
-			dev_err(&pdev->dev, "failed to register controller\n");
-			return ret;
-		}
+		if (ret)
+			return dev_err_probe(&pdev->dev, ret,
+					     "failed to register controller\n");
 
 		spba_bus = of_find_compatible_node(NULL, NULL, "fsl,spba-bus");
 		ret = of_address_to_resource(spba_bus, 0, &spba_res);

-- 
2.34.1


