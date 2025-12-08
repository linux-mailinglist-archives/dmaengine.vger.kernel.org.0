Return-Path: <dmaengine+bounces-7537-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 080ABCADD46
	for <lists+dmaengine@lfdr.de>; Mon, 08 Dec 2025 18:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 32B4A302EA41
	for <lists+dmaengine@lfdr.de>; Mon,  8 Dec 2025 17:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3312C0274;
	Mon,  8 Dec 2025 17:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IYLMs8t+"
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013005.outbound.protection.outlook.com [52.101.83.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D0C28CF7C;
	Mon,  8 Dec 2025 17:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765213835; cv=fail; b=EpxgfFOEJ32X32X/W21fgZLR8v9zy9/NE48V48wVBEZb8PV/FhyfBbIpJ1dZhWjHxJY2Fqf5Wq2FO4vHWN3WMsGCp9mLWHXrZu6T4yRu1qeUd5jOWUHzll//WW58aqBtKxVn/5tzdvDi37xMMWwtw2CmI2kYt1ftFM1x5bCIbwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765213835; c=relaxed/simple;
	bh=IJh1Qbp5W7RDpCr5dicrtDsd7uM0WGf9xOVKpHAHi7s=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=pWpfmtUND4BtRy226Wcd5KeturkwwFzonqcIl7JtjK5swlmxXTe3+j2Cid3BlkGA780rfGcrtzXc3sx/hUcW1ZYP9zNsLzQMLttPqLbr6YCHkPLU2+1SX+B9FQ6KncQm14xMZvEdIli3BXPNDwgtCcK/iKHuu7zpawnYZI8Hxng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IYLMs8t+; arc=fail smtp.client-ip=52.101.83.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y46+LR1XUuv5RKM8b3pe3pNYXb+yJPZa8rq03RbN9I2N8x3hUStWYxGWaicb3rX6hgjrd3Z7AQAJJerWwsnZYKF5uvsHX85Vt/9M7sGBiyJ0nHvvfooEmsueEFpqjfAxYkNGIox0U9b7JIt9BuaShIZ59ir/t4YmcDk2Qg+O70kBjzuwhx6LYkEJe0UICGli4Zoh4CasLqomh6w4IYpgEP5piwSxK5QYAhQFJ4Ne79S/96SfhG15Vl4TWs9RK+qw0SVnb+3D/obP+An8fj0geHNp3iQtBPog7YCL/T2mM47u48e3UcL+dsjq/LJNTz93N4zqMc7aAffIrIYOdVeKyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TRdCGT+eEdPdBw147jxorxPFEN3H52Xy30rmfdJ9byY=;
 b=LO+Vcv8uYy+Ee81Eb9elwQqGv/HMbVV031MbppzCRIX2Pq3YEy2BIhsAXvCi/1yMBdWUxWH2G7QK4ATJ1BUDBclv733VNQLcFpyMNqGu8XhAsfFcWDsDHpZfqDtYCpWJAsW2pWTO5BBUma05qQHNl77N1QUR1pKgLKHm7f2AzmmbQkIJmnxKAhPxDrhH6TN3aLykZH2j5NbK2Z6AR3sKosKdAyMuRau4YmyCg6x3jfWHZjMsxjiPZssE8qXqA6lExnWFDPQIuDnzwHif78GTvgw+CN/uDtxfy1Ym4uYLg5W4JK962hLVr2RSrMRg9aA9JIPaOS2JcAIke5EjSBmZOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRdCGT+eEdPdBw147jxorxPFEN3H52Xy30rmfdJ9byY=;
 b=IYLMs8t++TxL/inpQVvpwP8Jw+m2SnbhWXfgGBH8lYladBk5gLVGKqiqgzLB3abSE4D0yiktSRHhodVTSCbveRsmpIUETKq/X/CmHys7h4YqnMAstN4OfGLUA9+1R5BZbcuZUhdqlwLluL6ANkTyNfCki+RVRFv+O8F0bTdDriip9BWj816ZY87lUhJxr5On41mS6jheCkips2V/nZuZ5cc1Hi2S1WJYuBftS2Ko3exKPVDajF0VY/Ze7OIc/thFeE9Z1fqdN1WrRFn0+I+51HBnxzClgESEURotz2u0qzh2ojzVbUbOD+auAgkesS7cO4evn3BEbo5sZLQWs3EQqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by PAWPR04MB9888.eurprd04.prod.outlook.com (2603:10a6:102:385::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 17:10:29 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 17:10:28 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 08 Dec 2025 12:09:44 -0500
Subject: [PATCH 5/8] nvmet: pci-epf: Remove unnecessary
 dmaengine_terminate_sync() on each DMA transfer
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251208-dma_prep_config-v1-5-53490c5e1e2a@nxp.com>
References: <20251208-dma_prep_config-v1-0-53490c5e1e2a@nxp.com>
In-Reply-To: <20251208-dma_prep_config-v1-0-53490c5e1e2a@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765213799; l=1002;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=IJh1Qbp5W7RDpCr5dicrtDsd7uM0WGf9xOVKpHAHi7s=;
 b=X0Yamk5fkbfv3ZPG3HXB67rQka8olIH8HybMvei6F6aLsdTzv8nTR1X5kmWAmqN1Pue4d19/f
 /Leb7zrZgiLDQk152rRlCrK/mqgKTCr6TohZFteG34Ymw9np6aDAbcr
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH8PR02CA0036.namprd02.prod.outlook.com
 (2603:10b6:510:2da::28) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|PAWPR04MB9888:EE_
X-MS-Office365-Filtering-Correlation-Id: b1518120-00a6-4e19-6a1b-08de367cafc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|19092799006|1800799024|366016|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WC9ZaHZDOEMwektoQTZaREpZc1lGeEtXdWtZNG1YKzg3MnVMMmdMYkpCWVJI?=
 =?utf-8?B?ejlxVkx3b0lGQlVURzVDdFlic21RdU1tSTNRNHRYUURIdkIwd0dISS9pdE03?=
 =?utf-8?B?YVdKZFRhMDlzNnBoRStIYmxyeVU5T1gxT1FpVlNaZGdIMGtnSnovNG9KZW5t?=
 =?utf-8?B?VGtXMDZTTlNJY0NaVVQvTlRSZ25WanRZdXpadDh2ZU4zdkxWZjM1NVpWMjV1?=
 =?utf-8?B?eEdodm1zYTlIVk94RFNUaDF4alBhUGN2cUdRYnd3ZFJnbDNUdTJZKzlSVFMy?=
 =?utf-8?B?ODc3cm0xVUZlVklXeGl3T3ZvYmQrd2EwKy9JbGFqckVvbytQeFc3WWNraU95?=
 =?utf-8?B?c0dUSVRjb1lNWmlLbEIycnl3c2RUbnI5bG13YmlhMEZ5TjB3eU53cm9uazZQ?=
 =?utf-8?B?VjM5MDlRSnVyQ2gybHFueXhraVgxUVZtYlZ3YmNrYnNqREF5MGpZQU1Dbjdm?=
 =?utf-8?B?UVhKR0xyS1EwTE9hWXMrMmgyTkVJWGt3eGFKV1ErWDkybllBeGpFcjVjUHQ5?=
 =?utf-8?B?UllzbVF1OStqRk0zYTRteUtyRG02NXBzbmFIUmpmbzJiTmZpSjJ3RFc4SlpS?=
 =?utf-8?B?NmNHUXVhVTlFNVhPNzYzdVhMMWxKQkttaGNsN2JxMEpKc2dwNXpIVGtxTWpj?=
 =?utf-8?B?NmRSMjc0ZFQ1elUvTkY0TjJ6VTJuRGp3RXEzcy85Q3A1UVFPRTBmYitGMThK?=
 =?utf-8?B?MlJIV3Y2WDlQL0NMcGdQcDIrcEJsWkRVdDBILytrbW1ySEFnYXM1eXRndjEr?=
 =?utf-8?B?R09DVWdwRTR4MlovUDFpcHZxUG13K0ZVenRmSWIzR2dJZ2NVK1RQSHZpdDdo?=
 =?utf-8?B?UE9XOW5DTXRGQWx1WnkxbTE4aFM0UUJjYTAvVG1oalpwa0R3WU43M1BTdkpL?=
 =?utf-8?B?ekFwakNEZThSUVBtTWxBQkhTV1pTa2ovM3l6SjQra1BHc3FpTEhtRnoxRFI3?=
 =?utf-8?B?WVVSNnFWd0xvbmtqSjJraTc1QlJkVXc0TVlzaDgrOXVXam5HWHBLMWRyWUVO?=
 =?utf-8?B?QjZCdjcrNWxYYkpYSlNyZ2txMkNnL2FOTXI1ZG5sOGxQNzB5SjRiMnJ6RnRH?=
 =?utf-8?B?VTF2U2xOY3FETE5MbWJxRithYmwrS0REZXJmVDFQK0QwaWVOTDZ6S3N2QWZF?=
 =?utf-8?B?Y2s1NDd6QitqbWFjM0hWZ1ErS3YvSmFPbXA3UVRkMzBLQnNxdVFKdk5KMWdR?=
 =?utf-8?B?RkM0ZWhtaTJWRG1RMW96YU1yL3lUbnBudUJLMW41cGRKREtaaG84Z2dIVDhn?=
 =?utf-8?B?dVZrK0Q4UG5WYlVvRTBTWU1DSy9qbFhJUm5yTHp0ZTRBQkJNcnJEOW9JTHhi?=
 =?utf-8?B?aVNidUMvYUJlNUVmQmZEOTc4NERXaldGbXQrVUZQTm1ONTdUZDBzNEg3bUc0?=
 =?utf-8?B?T3BuZ2s0Z0kzS2UzSkhNdGRpdFdzRjNsdmhjcGEzSkRHa2xzSFdHM25CWUlG?=
 =?utf-8?B?andBOGxyZlAremFCZTFYVVhuL2JaL0tJUDhKYUtySzV1WFRRUzZnZVRzei9p?=
 =?utf-8?B?dVNkUWV2cFF1eGxndmJqQUlWenZEVnlmd3AvSFd2NEYyN1hPanhVK2w1Vzlz?=
 =?utf-8?B?NHlZVG56dVdxb1d1YnVBekkzSmVBZk45bWxRVk9MWFZSWFl0NFBkdEEvRWVC?=
 =?utf-8?B?dURTT0EzVWcyMkdYYTVYTVB5alBBOUYzaHEvMExOaHcvbVRPV21ZUjZ2OTlr?=
 =?utf-8?B?anMzcHNlZUZKV0EveHkyWGVxSzcrWktMeHhiQ0thbFJteUJnQmw1Tkg2WThs?=
 =?utf-8?B?bzNZNStmQm9iSXBzQWNFS2lORStOOTVZODk2ZDE1L2FZYnhFZlF4ZmZIbWtZ?=
 =?utf-8?B?VEhwVHVHNlJlZDZMTkFGdE81aWlIVzFHZWh2VGdJSGVPSGxEOXBmSm5ZNG1H?=
 =?utf-8?B?VmlWTnhIbUVLLzIzSmpSc3YrWURhT0xtNEpJVU11L2FMRjFFUWtqTGdZZ2lI?=
 =?utf-8?B?ZU81VXV5OWsvbms0b2ZodHN3VU8ydEFJNW1MS2EvU280bWowcDl5L3h4dGZw?=
 =?utf-8?B?eWFSSEoxQ0JyWm1IQTBKZUJQaVFoV004OThHT25nMS9ZUlZiSVJEYjQrRW1Q?=
 =?utf-8?B?WW05NG51YWdqZHc0aSs3Wm15WTRWNFl3cUFNUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(19092799006)(1800799024)(366016)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0l1aGlncHlxWEdoOFRjRDVQRnRwamhhRXkyZHhTZXBKWk9QWUVwcHpOeTQz?=
 =?utf-8?B?QXJaK0duTU5iK0pMemhNSVRzZXZpcFgxcXJjR21rQ3I5RWJBdjFtaUpmM1dB?=
 =?utf-8?B?V25ZUDl5M3E5andwMXd5bm5ISzl6M25GekJvOThZOUJIQVAxWFh6Q2ZsVFA1?=
 =?utf-8?B?OEpBNzBNSmJQNTMybTBtcGdMcGYyLzMwNmZKQy8rWWllUXpVTVNpWjBYVUoy?=
 =?utf-8?B?VzFFcE0zcjIzMHRjSWE1ZXJkUjlUcjRxUjRJc0tCNjFOZ2ZYMkJMSzFqcWdw?=
 =?utf-8?B?eVZEb01MTnVJV3Yrb3Q1L1pyMHN3YUZpcVhUUmFJUHZNb3BRZkxGZ1h6cWNP?=
 =?utf-8?B?eEtxVVVXYmNRa0FKeVV3bk5OdVBvLzN6eCtIT1dYQXVrR2dyQkVJWHc4Y2l6?=
 =?utf-8?B?QU9KMnNyU2xUNTZyWEgvTldjeDV4OGh5V3R3R0s2d3F2dklVdytVdjN3R2Va?=
 =?utf-8?B?N09FaXBWbitFaXpET3RYbWNCdU1HMXZkb01Mc0kwcmRwSTBxYmNJRXRCVUw0?=
 =?utf-8?B?bEhSbnZ6MzY5M29QMi9QdW1xUWVEcW40bzE5YWhYVytCb3NGdjYwc1YrWHZO?=
 =?utf-8?B?OEtvMGlodWhSOWMwclJIVmxlbm5rWkh0dWhETFlRMS9WbmZGWnVxQVZXcDJU?=
 =?utf-8?B?dCtMSEQ0cTZVeHdMUDJrdHdEUkNlOTdQOWUxT0VmT0JPcStxRk02UlhocVlE?=
 =?utf-8?B?LzVtTlMrU1Axd2VtUW9sRW9icjE3bmtqQW9rbHVvWW9qYVZVWG9xblJGcUZp?=
 =?utf-8?B?QlNwcUVBQjBNa0N1K2Q2Ykc3cWdwYmxyRXZ1dExYV3VzcmZ5RnF1aHRlTW5u?=
 =?utf-8?B?QytEcHlkRy8vVXA2RWhtc3dMc1VXV2VPOTFPK05zKzJ2VTc4RnVzSytIYjJ3?=
 =?utf-8?B?UmhjRmkxZHBZOTZUZ0pDajZyR3IvNE9NT2Z3UEZFbllFUlNLd25EbFZvK1hI?=
 =?utf-8?B?MmVPS0NBTERleVVseFlteVoyaWJ2L2dwYmNKaVNRRXhMU1VPQTFocUtzN0hr?=
 =?utf-8?B?Tmo4cHlCbGFWb3RlcW9taVlOZHEvalM5K29Vb0VqTngrMEhJVS9zWmFKcUs3?=
 =?utf-8?B?ckNWZzRDRXJUaVpQTzRrT2JjWnIzc1JLUHVvT1g0dW9sUE9hVW5VWmp3K0xx?=
 =?utf-8?B?QVAzVm52eVRWNEo5UGlJeHlCTlc2dndmakZldnp1VWRpTHNNcmUzZzJ2bWdH?=
 =?utf-8?B?QlFKTGI3MFFNdFNhSVNnODZmaEFQNVpLMEVtWWZGZzdNakVVOVNhTkFtR1ZP?=
 =?utf-8?B?cEI3YjBqUXcyRVREbzl6OTJqNktsSFY0VXB0WndKWDNJUVBkcjRMSkFaeHVT?=
 =?utf-8?B?UXNabzAwVHdNWEJKVzd5YmtaM1lhMHNYK0tmSmxMbXhPMWRQaEoxMFpqc2dQ?=
 =?utf-8?B?eFBoNzdpSmxwUkRoM1E2VXpnOWhOZ1YzQjlyaHpkVERSajdGVnlJNnQwQlhN?=
 =?utf-8?B?K0dmM2h3R0RGaGZjbXM4NlJiMUtMS016VUFMci9MRmtpOENENlRoV1Y1dUtP?=
 =?utf-8?B?WitxYUtNWWhDVkhndWsvaWdjUmh0anhINTBIT3B4VlJGOVc1UDg0UStvd0p6?=
 =?utf-8?B?RTlRcm1FUzdFejFRNGJOdTlWUWJSejFCY0wyWnVFTlhDOEdyRHZnejV1STR3?=
 =?utf-8?B?YjYwbjZoRDVtUTIzWHFUQXN4WFF1NW45NEhCWWVoaTcwTnR5bTdYSkJvb0JC?=
 =?utf-8?B?a3cxWGJXWGFReVErRlZOa1ZETjk4N2JNR3JucHE1WVl1Rm5UVTUxMDV5RWxF?=
 =?utf-8?B?NGwxUVJIdWNIYnRrQWZiYVhvNkNDalhxMEVyeWhIemRiUnIvNzdoYUhFL1pl?=
 =?utf-8?B?OSt5NE1mVy9nRXlWTFlJOXN1VmtxQnlWR3BWemIwcjd5MGpjYjhHeFk1cElQ?=
 =?utf-8?B?T3lyZkRGaDkzd045YXIxeEZXdGhMUUtTclk1YWNCU2lsZDB3cFB1SHY4R05k?=
 =?utf-8?B?NWJTU1ZrS3pQZDFrd0pBMDAwN1hSWUVxVkJwOVN1QVYwSGhHR2VPSWkwbmN6?=
 =?utf-8?B?ZVV1TGg2NW9oR0JkcmVLUy9XSjFNNU53bVY5UFB5TWRMdDVRUUJmMThOQ2xt?=
 =?utf-8?B?dVRienFoT0VoU3g2TlZzQTFPbTlORVo1aU4rOEk3OWhzTFk1VmVHdmFOU1Mr?=
 =?utf-8?Q?/fr4dHgJBLRnqbU7kA43PFIVm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1518120-00a6-4e19-6a1b-08de367cafc8
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 17:10:28.7738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d9TC5ElnXVA75UZC3awxVfAd0pSrSLnYCKwVlMRZLBDd+RZZnrfyLTEr3xQaCWH3607VU16JxSdLDNBxuhGzpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9888

dmaengine_terminate_sync() cancels all pending requests. Calling it for
every DMA transfer is unnecessary and counterproductive. This function is
generally intended for cleanup paths such as module removal, device close,
or unbind operations.

Remove the redundant calls.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
This one also fix stress test failure after remove mutex and use new API
dmaengine_prep_slave_sg_config().
---
 drivers/nvme/target/pci-epf.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index 2e78397a7373a7d8ba67150f301f392123db88d1..85225a4f75b5bd7abb6897d064123766af021542 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -420,8 +420,6 @@ static int nvmet_pci_epf_dma_transfer(struct nvmet_pci_epf *nvme_epf,
 		ret = -EIO;
 	}
 
-	dmaengine_terminate_sync(chan);
-
 unmap:
 	dma_unmap_single(dma_dev, dma_addr, seg->length, dir);
 

-- 
2.34.1


