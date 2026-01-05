Return-Path: <dmaengine+bounces-8042-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8A6CF5E1C
	for <lists+dmaengine@lfdr.de>; Mon, 05 Jan 2026 23:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 52B7230318F7
	for <lists+dmaengine@lfdr.de>; Mon,  5 Jan 2026 22:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DFD30E831;
	Mon,  5 Jan 2026 22:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ec1s1ZvG"
X-Original-To: dmaengine@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012029.outbound.protection.outlook.com [52.101.66.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E2D2836AF;
	Mon,  5 Jan 2026 22:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767653288; cv=fail; b=RDXR0Z8nj9rNeyZOGNdBaeKcclNdOKfXPxW75lmUyijIMMkMtI7X7gRy8pPMdRCSnpCfnmiZTlctZeomO7QOEQV6F7kSodAAhDanImQWTlKgCx3o9Ijb+bpB6HiCeM4Gi3YLsItmnrk84RGHHQzVt8WMrSPOcPO+CA3GoNsTvGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767653288; c=relaxed/simple;
	bh=y2+PfL2H7b1FUgjqeANH8jwnoWP1hvs/HDEhP+Ko9ic=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Fjka8zD8Sju79KQS1hZl29Umb31Wky3A1wN8gu3yN0jNLT0RSWUeNLpEbd5owbwrnrrpLooJob9wN16AkOKGVP7jO2iJ/AIOCaAA9HqFhDH3TVhBC6eGUINtDz7bs+0WTl3oaWeToBQlGIKDuSMLiSpW/QghsOtayZWFGJgjT/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ec1s1ZvG; arc=fail smtp.client-ip=52.101.66.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Leauxuo0JEAxO0yCH6KC+x2pf0OvADzqTkSQAeai3qb0EzWrGZXHHIJq30b2lomMD/l5isyz5doXzP8ub1z8Jaa0O6MvANvI67LlzAvMFnxZG0pIsurxBGXdwWLuoCnoPOWqhUOgfAj+XDM/typGVtzgGHGYkaoJ51SuvbXCN9L/2EQkqa7CeeVlHUGN38XQI4BrLWy3a7pKWg7dQRkKOXWIwqOXeDTjqrt48IwymAhdvDYAB4ToH3YDw1gVZZ+SfxJDep2NO5xYw8nznfv8aXcwhH0h21QvX9VOKyWtX2ZCOpOBleAoRQt0TRKMdyVmSiT39RwcboQZsj8Nah0uGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bwjk+7+Yxg8aO8dUdJlfm7y3buwrxqjEUHZvv97CBHs=;
 b=v3inQd4f5jib0fvt9rjmgZ/94OnKiSglyM3wHsj8LlvQN7+80OgEak/ZuY4POzw18eb90ySBaQWu/1XZT6hDZZM9L0JMUuKl57pMs3Cp23qzPSqYgtwStjrs4KZ3fMEQuOs13wzs0YWCgTRl1rEN8diC+rCN/o8nk8WbdPumG58AdpLhJyFL6fKtCigowpOiTM0uACrs6+uLhkT1Zn8VjsCzmEC9FDhhZjAWoM4EJo36gTz5JyCLqvYrvPnauQ1DLZ+g9STx9nEWxJP/xqewJ45wgabDiozYOufJEUwXWRb+HrDjhrhSQDCuu9bRffTiWRPWqPLKAUxELhMQZm6v6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bwjk+7+Yxg8aO8dUdJlfm7y3buwrxqjEUHZvv97CBHs=;
 b=ec1s1ZvG9RU9ofs3zz6ZxFKmY1Xm06RaCpNcar+hqr0eCL3dkdX9dbPnrk0yCAZWeaMLBenPrOzPcva8Xdkf4rQj/EFuzAmse23YjuD00kbnmF157FjARjrXn17TAAINrOMYctBE2VPS22uMPjG3mqlDWu9VZTom3Jvi9KisbDJiBSPwuiR2tyEEK9LgPG7pePY6H03rqcDXaq/1zfbxIT5/L1XBRFO+N6useN5WahRjjxos1xkiL24qkc8CkcjoW/c2kDi1uPyWTekm5MEUHuC5lX659m35Q/7z/ILIXATOpdgJn4tCDZLHltjxvcXn0VyyQKKTjY+K7rni4T6m+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by DB9PR04MB8185.eurprd04.prod.outlook.com (2603:10a6:10:240::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 22:48:02 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 22:48:02 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 05 Jan 2026 17:46:58 -0500
Subject: [PATCH v3 8/9] PCI: epf-mhi: Use dmaengine_prep_config_single() to
 simplify code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-dma_prep_config-v3-8-a8480362fd42@nxp.com>
References: <20260105-dma_prep_config-v3-0-a8480362fd42@nxp.com>
In-Reply-To: <20260105-dma_prep_config-v3-0-a8480362fd42@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767653229; l=4628;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=y2+PfL2H7b1FUgjqeANH8jwnoWP1hvs/HDEhP+Ko9ic=;
 b=hSCqwVYMPtIfM27Pf9YHAI8OiVJCS420SUhHRvJ5EF/mf8FQ278XQEP0Q5xz8l8YPitODaWqt
 odYBdOP0X91A8bgCizQpZgcF9Wt0fKaYyG1i8ylbuBhMtLut8Jcup26
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
X-MS-Office365-Filtering-Correlation-Id: 257eea07-be76-495d-c725-08de4cac7b80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NTBFMnNtbk16VDJrdmdTbDF1SGk2VWZVZ1plcG9ZNkJydm5VcFhTR3pxTEM2?=
 =?utf-8?B?Tks0VXdQb0w1b0tJa0JXUGRDMjhIaW42NnFvbkhuR0tEb3hvM0cxWDBWTFhT?=
 =?utf-8?B?WmlmNkd3MjZoN0RGK2xQRjVoYWhiQnNhL0FTZTlQWHUvYXlxK2FuQ3Zrbi9D?=
 =?utf-8?B?b0w3VFhWa2JZMTZlbFBlK3oxSXF3Y094V3lGQkRkU1ZYVUNiemU5TTRGVEJC?=
 =?utf-8?B?eGVZd3l0d215TktYY016L1lxN0VWb1NLMXBLdDVIMHRqNm9VL0w0UExhblYy?=
 =?utf-8?B?NThVSWhkVW03Smp1MHRVeldGa2QxTSszczhwVTUySlhpWTNlYmRpdGo1Tjcw?=
 =?utf-8?B?cERjaGZhWjRxTXBzUkpmUXRHVEtKU3dpREFyeEZyVkZCalB1U2ZPZWg1V3pl?=
 =?utf-8?B?WXduaVhzZWdXMGJoU1A5U29YSmU1M2I1RXVTNzZmVzhvOC9pemNSSThGTDZM?=
 =?utf-8?B?dURiWjlRZ0h1emM5V3RWbno0aE9aQkx3V2UwZXNHZU4rUTdtaSs2VGU5VThy?=
 =?utf-8?B?dXRBeWhFQk95djBWcnQwbWY0L0swTDJjd3VWWkFZdmZiMElhYi9NcG1ib0pj?=
 =?utf-8?B?NW1MU21IZ1MxWmtjcU9MakdiWDlUSXhzbFBhN2J6RkV4aHhxVGdpM09oY2c4?=
 =?utf-8?B?SnNQYVIycnVrN3ZaaE04cnBBV29iNTMwVFROMmJIUjR5N2pyOHNXeERZVnJX?=
 =?utf-8?B?VEhvMk85RnFodHQ2MVRJY2dIK3JnSStKeTdteENtdXpOZVRkZWNRRWM1cEc3?=
 =?utf-8?B?SGJ2VE5HS3pKbFVGc3hQbW1NZktNQ0EvMVNRVXlDZjFLckljU1QraU9tT3BQ?=
 =?utf-8?B?UEVpSmdJa2FJay9mL2N6S0l2a3RaT1JRUXRzTHpld0RONzU5b2pXdUtOblZR?=
 =?utf-8?B?eVlraXNSNEl6Sk9hemw3NWVuS3pncWZFNnpXVkpnVzFCL3Nyc05seko0T05O?=
 =?utf-8?B?T3dRY2pETjdNN2s2VVhTbUNwVFhLeldpaDdtbFJEWGM0WnhQY3NBaEs4MVpi?=
 =?utf-8?B?Zk5LT1dYSEgwTlEreDA1aU9WaEpFV0RkNXBEUWdYTmpKb3J5cjRZV3dRaEhi?=
 =?utf-8?B?czAyZzZHYXE2SUlxNitxT3k1bmhodFZESFliN0ZZUVlyYzBFbStmR1NGVTNo?=
 =?utf-8?B?VktrZ0dka28vYTRFUS9hYXFlNzN5cmE0R29KYjNYbXdTYU5KSFE2VDdIRVQx?=
 =?utf-8?B?Y1lYZGhJS091RG13K0U5ZHVTOC9wdlZ3SG5vdkgzY0llcFJocE9UUzBodGVS?=
 =?utf-8?B?U2svSmZlNExPNDFtQkNCd2k3ZzBSekxrYk05RXN6SFJQQWFnNk9OdlgyZWxX?=
 =?utf-8?B?SWJhajBhQXBNcnhEMS83aGZJTHhyd2RKSlpNaXExOGRhS2ZMaVgxU0FjSklL?=
 =?utf-8?B?K1V6dEhpY3hSS2xTWmthY3lISGtyWE9vd2pQV0hOYUZiMG9aSEhGUVZ6ZmZq?=
 =?utf-8?B?eUVQSjdVWjlJRHFFdU1vVkI2aEd3UEFqc0pQNTJLTFY2bTVlalBwaE1UeDBy?=
 =?utf-8?B?S3lXaC9XRFA1T1BsaXpOeEF6RG9mcjk5dG52cmgxS3R3MEdMWGJvbzFaNjAz?=
 =?utf-8?B?NmEyRVgwY3NuSVh0RTNocWpmSkZtVXhCbk9rTlhJUlBPU0VRNTgwNE5CbVBk?=
 =?utf-8?B?SzE1TlI0NDQ3RlVldmlUeTUzbjNnenNYYWp4S3l4UUh4bm9iTW9mYURjSkU0?=
 =?utf-8?B?b05VVS8zQWZyTTI5VDZYK1NiUlB5aEJuRjQvZ2o5UllVYStJSlZ3cTBFSkh5?=
 =?utf-8?B?OWVNUjNudnJrdlBnWTkrSnJwMFZZZ1YyMVE1V1R3NFdDay8wLytYUjRyVjUw?=
 =?utf-8?B?NVk1QkNyNnNBdlVGUytITHNxUUdzWHdzUG5DNFc5eXJtWk5HUXFsSmpIaExV?=
 =?utf-8?B?Qm5CTVBRUXFYN0FBUVN1UnJ1bWc5bGVmZXMrTnNERkNSNExEaE0xcVFDWEdu?=
 =?utf-8?B?eE5rTUZvRTVwd3ExQktTakJndUhUUFRUcTV5YnJpV1hFU2tYUHNZZGVPWnJ6?=
 =?utf-8?B?VUMyL083VmlMWkJyN04rV1QrWTRNRmpXSDY0NGRhQWJ0Zi9NMVFpUWRTaHVD?=
 =?utf-8?B?emdjVFhTWnFHQ3l1UXE3RVdwcGtqeHhWaVdodz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3dCSURqaUV2U1M3RUJmbnRZVzJKRzI3ZXlrcEY3VlZSdHBuYVd2TEgzRFFH?=
 =?utf-8?B?UU04Z24vUGFVRVBlOFhZNmV3NUxBejFmNG1jcW9Za1B4WGUwTWxQMDJuc2pN?=
 =?utf-8?B?ZlVqQ2ZRY05xOFNZampVeE9kR2xyZjJlaEhKTlplS2FiOEEreUkrWkQzOVpM?=
 =?utf-8?B?blFhd05QQm8rTk04SVJOaGhvN0dNTWVJUG5lUW1NK3E1SE9mT25CVC9LNjc5?=
 =?utf-8?B?Ulc5MmxhWncyNEd5S2NwMHoxdTY0NjA5MXUwbndUS2NCT0lKcVptQkZ3cGYz?=
 =?utf-8?B?UU51azQrU3BJYmRKMXZVNVh1elMrYmlpYms2U0p1UkZmUlBMTUdOcFQ0R01P?=
 =?utf-8?B?blRTaGh5OWtUS3V4N0l3VU9xcTc3WmNINGVjS3RocXZoa1orZkoySkk0NUFh?=
 =?utf-8?B?NmFxYUtOVHdmb3JnaUVjWmNqYXBYbnVuN0d5bUhDTzNmQlNWZzRpM3Rlb0Rj?=
 =?utf-8?B?ZEhZRGErRDBWNG04ZGJuL09ROHRVanJaNnBtVDM1ZVZuQUMyQnl6b0FxYVQx?=
 =?utf-8?B?VjAxV0o5RXpNSnJhUmlEUUFXVWs2QTFLZjRETmZDd2tpeDNUd1dTQlZwaURZ?=
 =?utf-8?B?dVBhVGE4NlVubjNybjhyY2oyeXFpK2w4WjBOcjA0YlpSNEdWYkZoazNLcDlv?=
 =?utf-8?B?MWZFRk9NVlBjcDFmVmZtR3N5YmVqRFQ0Zk5DU1ZZUjh3QzVoQ3dhT09VNnkv?=
 =?utf-8?B?S2FMYnpxSFJZTmE0ck5sNnZnTHovOVJnWXk0ZnFiWnZpYVBQM044YXd4eTdK?=
 =?utf-8?B?V29ZNGZPZkVhWHVQRG10S2lMYVVBTjM4c1o0bFNVb1ljWmhkN2VURjZCYVEw?=
 =?utf-8?B?bDFDMERrOStiTVVRaUJFSHduL1N2TjAwZ3NKdUxYaUlCeE9id1kxdlJIbUpK?=
 =?utf-8?B?TzBPN2UrakEvWmU2b3NWZVlleGp3UGg1Q3VFZmJXZjEwcmZibTBhRGFOR01v?=
 =?utf-8?B?bXhGd2ExdEdPMDdNc3JRRXkxUzMvQzVjbGlzQ3h4d3pKK3RCQ3EzUURTSFRR?=
 =?utf-8?B?OEhjY0ptTVluelVkUjZZRE1EancrM2ZqRzA3UDBwL3ZIQXlvQVkvT0NDbUZH?=
 =?utf-8?B?ODNqL3E3V0QyRG1lNTk4V2dDTFNKY1pJVjZDelpkRXpJR1F2TXg1alVxN0Qr?=
 =?utf-8?B?R2kxV012ZnlEN1k0VmVTM1d5cTlPVkxCUi9saUZLaWUxZnFOaFJWcjduczM4?=
 =?utf-8?B?azdpeGU2Y3BZU2liL0JHVmt2QjdNWnN5KzBZWDd6WjZZUnp1NEN0SndGeURj?=
 =?utf-8?B?VzlLT0Qzc05VeE51ck4waXdCY2o5QnRhdDRUNjJ0RSs5aVAyNUw0NWdGK3VE?=
 =?utf-8?B?MGEzdDhHSURIeTQwWXd2SWRiaTBMVjVrTkFNRVhodEJVeC93aEZvSUZVdDFC?=
 =?utf-8?B?Ykpuekh5UFljZHI2eE9yTk43S0tUZldGU2JzazhtZ2RSN0EvZko1Y1ZnWTFE?=
 =?utf-8?B?Yk5OeDFUWlN5akczWC9JMGNpcTkwYzBlbzFwb1Q1R2dzMmMrVEY3aU1ORmdU?=
 =?utf-8?B?cDZkNzUyejdOOHB5Tm04ZktWeFdqaXBZMHBvdUlFNjFHTWtRdE5Ycmk2WGY5?=
 =?utf-8?B?Rlh5TXhkL2dRWXptTWt0UlNBNVB4TnpndkpSSzJtcEJmZlZERGF1ZlM5Q3dx?=
 =?utf-8?B?OXZTQ1lHY0F3aTNXa3dza2FWNHNYREZ5V29YQXFzWW5xVmV3RmFSb3FKUWJ5?=
 =?utf-8?B?RXV4VHZiLzNDZ0VQbVdTVHVvYnhiRVdSbFIraXV4Y0R6TmMzVXNVUlB2aW5n?=
 =?utf-8?B?ZERtR3NUeXpDSm5RcGNqZUFtOGc3VEpwemM2eHBmNVRKekpSVzVmaVlaaWFJ?=
 =?utf-8?B?dGpRZmx1ZGlYQ0hhTkpDaVF2WXM5R0p4WWovb1J2YTZVWG1tdytvdzlEQmVD?=
 =?utf-8?B?Y0dxdG5OeWFlNE5zZGpQeFlCdWJUamt2TE9kQzcwUjBBWUxTb0ZMVXdIbDN2?=
 =?utf-8?B?OXBxb0hPeEYxb0hkK2gyMGR4RHMxTmpwMXFyT01DN0tFUkZWRmxySTRrbzJ5?=
 =?utf-8?B?Wk81MWRybXRoMFFZb2huWTBjZWhpZkQwR3dCb0IyTThVRDZLYmt6Ti92T0lX?=
 =?utf-8?B?cVRTdWVIYW1jMXhQd05hNDlycE9EcmxTelFTMjZ2N0RFbUNmN0hPcWlTL2hN?=
 =?utf-8?B?T0gwSmY3TklXUTR4cS84Q0ljU3BFZFB3aExCcXVsT0VBdlBrMWFvbGRLSy9R?=
 =?utf-8?B?YUV4Mi9TdDF6TzlHd2w0ZGpIR1NxZHNNMENaRk8rSGJwL01iQ3YvYnpRTWEz?=
 =?utf-8?B?bHJZdS9xWnhyUzBwa0NKV2xidnpCeVRrdFQzR2pOQ3k1aVlmbE5Sd05kWE8v?=
 =?utf-8?B?TDZQZ29YR01LTDYwQVcyMmZ4WFZvbHJhVlZRSWxvSEo4Z3R5YW5IUT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 257eea07-be76-495d-c725-08de4cac7b80
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 22:48:02.4232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AY2zQKp7tEX4znMn4sK0YJpFxwojtt6F2TCC0yV6Z2/rY7v7ILauc8faw8L/5dxYQ12u389qWdhD1/B4n/iOXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8185

Use dmaengine_prep_config_single() to simplify
pci_epf_mhi_edma_read[_sync]() and pci_epf_mhi_edma_write[_sync]().

No functional change.

Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Keep mutex lock because sync with other function.
---
 drivers/pci/endpoint/functions/pci-epf-mhi.c | 52 +++++++++-------------------
 1 file changed, 16 insertions(+), 36 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
index 6643a88c7a0ce38161bc6253c09d29f1c36ba394..0bf51fd467395182161555f83aa78f3839e36773 100644
--- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
+++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
@@ -328,12 +328,6 @@ static int pci_epf_mhi_edma_read(struct mhi_ep_cntrl *mhi_cntrl,
 	config.direction = DMA_DEV_TO_MEM;
 	config.src_addr = buf_info->host_addr;
 
-	ret = dmaengine_slave_config(chan, &config);
-	if (ret) {
-		dev_err(dev, "Failed to configure DMA channel\n");
-		goto err_unlock;
-	}
-
 	dst_addr = dma_map_single(dma_dev, buf_info->dev_addr, buf_info->size,
 				  DMA_FROM_DEVICE);
 	ret = dma_mapping_error(dma_dev, dst_addr);
@@ -342,9 +336,10 @@ static int pci_epf_mhi_edma_read(struct mhi_ep_cntrl *mhi_cntrl,
 		goto err_unlock;
 	}
 
-	desc = dmaengine_prep_slave_single(chan, dst_addr, buf_info->size,
-					   DMA_DEV_TO_MEM,
-					   DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
+	desc = dmaengine_prep_config_single(chan, dst_addr, buf_info->size,
+					    DMA_DEV_TO_MEM,
+					    DMA_CTRL_ACK | DMA_PREP_INTERRUPT,
+					    &config);
 	if (!desc) {
 		dev_err(dev, "Failed to prepare DMA\n");
 		ret = -EIO;
@@ -399,12 +394,6 @@ static int pci_epf_mhi_edma_write(struct mhi_ep_cntrl *mhi_cntrl,
 	config.direction = DMA_MEM_TO_DEV;
 	config.dst_addr = buf_info->host_addr;
 
-	ret = dmaengine_slave_config(chan, &config);
-	if (ret) {
-		dev_err(dev, "Failed to configure DMA channel\n");
-		goto err_unlock;
-	}
-
 	src_addr = dma_map_single(dma_dev, buf_info->dev_addr, buf_info->size,
 				  DMA_TO_DEVICE);
 	ret = dma_mapping_error(dma_dev, src_addr);
@@ -413,9 +402,10 @@ static int pci_epf_mhi_edma_write(struct mhi_ep_cntrl *mhi_cntrl,
 		goto err_unlock;
 	}
 
-	desc = dmaengine_prep_slave_single(chan, src_addr, buf_info->size,
-					   DMA_MEM_TO_DEV,
-					   DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
+	desc = dmaengine_prep_config_single(chan, src_addr, buf_info->size,
+					    DMA_MEM_TO_DEV,
+					    DMA_CTRL_ACK | DMA_PREP_INTERRUPT,
+					    &config);
 	if (!desc) {
 		dev_err(dev, "Failed to prepare DMA\n");
 		ret = -EIO;
@@ -502,12 +492,6 @@ static int pci_epf_mhi_edma_read_async(struct mhi_ep_cntrl *mhi_cntrl,
 	config.direction = DMA_DEV_TO_MEM;
 	config.src_addr = buf_info->host_addr;
 
-	ret = dmaengine_slave_config(chan, &config);
-	if (ret) {
-		dev_err(dev, "Failed to configure DMA channel\n");
-		goto err_unlock;
-	}
-
 	dst_addr = dma_map_single(dma_dev, buf_info->dev_addr, buf_info->size,
 				  DMA_FROM_DEVICE);
 	ret = dma_mapping_error(dma_dev, dst_addr);
@@ -516,9 +500,10 @@ static int pci_epf_mhi_edma_read_async(struct mhi_ep_cntrl *mhi_cntrl,
 		goto err_unlock;
 	}
 
-	desc = dmaengine_prep_slave_single(chan, dst_addr, buf_info->size,
-					   DMA_DEV_TO_MEM,
-					   DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
+	desc = dmaengine_prep_config_single(chan, dst_addr, buf_info->size,
+					    DMA_DEV_TO_MEM,
+					    DMA_CTRL_ACK | DMA_PREP_INTERRUPT,
+					    &config);
 	if (!desc) {
 		dev_err(dev, "Failed to prepare DMA\n");
 		ret = -EIO;
@@ -581,12 +566,6 @@ static int pci_epf_mhi_edma_write_async(struct mhi_ep_cntrl *mhi_cntrl,
 	config.direction = DMA_MEM_TO_DEV;
 	config.dst_addr = buf_info->host_addr;
 
-	ret = dmaengine_slave_config(chan, &config);
-	if (ret) {
-		dev_err(dev, "Failed to configure DMA channel\n");
-		goto err_unlock;
-	}
-
 	src_addr = dma_map_single(dma_dev, buf_info->dev_addr, buf_info->size,
 				  DMA_TO_DEVICE);
 	ret = dma_mapping_error(dma_dev, src_addr);
@@ -595,9 +574,10 @@ static int pci_epf_mhi_edma_write_async(struct mhi_ep_cntrl *mhi_cntrl,
 		goto err_unlock;
 	}
 
-	desc = dmaengine_prep_slave_single(chan, src_addr, buf_info->size,
-					   DMA_MEM_TO_DEV,
-					   DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
+	desc = dmaengine_prep_config_single(chan, src_addr, buf_info->size,
+					    DMA_MEM_TO_DEV,
+					    DMA_CTRL_ACK | DMA_PREP_INTERRUPT,
+					    &config);
 	if (!desc) {
 		dev_err(dev, "Failed to prepare DMA\n");
 		ret = -EIO;

-- 
2.34.1


