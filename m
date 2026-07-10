Return-Path: <dmaengine+bounces-12332-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UBnhIgAkUWqb/wIAu9opvQ
	(envelope-from <dmaengine+bounces-12332-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 18:55:28 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8464973CCC5
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 18:55:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=m5yFrB+A;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12332-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12332-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A86D73002513
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 16:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF58247CC8A;
	Fri, 10 Jul 2026 16:48:49 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011013.outbound.protection.outlook.com [52.101.70.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D9147CC67;
	Fri, 10 Jul 2026 16:48:47 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783702129; cv=fail; b=cxVueCjUsfk+YNryN5e+i62LA2N1SLdSOc1A3BTp4ChVCK/fGmeM//hU3Z0mtKHydiQcQvtYbM0yaH2O+YLuU/qCSGtkY123Pf8Dclj2u4b2LhVeNNa+1PX5Ep1VF+rCSMBFXJ7r5KHAKrC46mEg3NIhsNHNvV01wsN6A8jhApU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783702129; c=relaxed/simple;
	bh=N1fVtrUEC4Kl7K7CckIQ8quavpfEDFchGO4ptlvTgOY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=GkF9SF9B0A/Kc/VTWUWI6V/ksKpgOpsLVIGCI0wUN5RbGBgoktDa/tnkmCc/qhdojyrQa0/D8tSIaVVZiHGH5L8+JySszC8aRr5U8JYBoL9Ig8mNjQoCWXrFWaZe8aidDkW6U7VD8VJAHoITKLGhTCjRp80GlDi1yQWBWnEPjps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=m5yFrB+A; arc=fail smtp.client-ip=52.101.70.13
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jn1HtTwZ1CR4/Msmk2DviH+FVYGjN/X2dc3RJYX21sy5I2ePV6NEcgCfNbyFXwBU9ZM2ApLyp+mpTmmswS1FfQqh2fDRdDQMIlwgU7qPhqfcT0M4Vjw+WP/+m/TS2fr4vBHLbvFqvqwwhozPFHNTRF7Gh/i6Yec4p+fX3TByYTX30k48BdptPFRD2lRAmOEZBPZdjRwyB6Lj09EXQdKQX3bEGYhB8hGXDRyKHJ/YjCsOUWD0WLcJnzc147NF6+A65bn6/VZljjyRC4cp9NMIC0PcmWOMzMKiYNioXpISDb/ocNAunYcoPKAtaRC4fy7FFfoKiyBhNk3bST6cTEIx1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PMFopFcTiKB4Xle22oaUXIrNpbJESZtx72kTeJAvylc=;
 b=vhcZ1O9i21X1nycKvn/nf2cZ0MacMouK4pVPi8rVCd73QaXYq5/ibdAbal+BBjrEc8KeHMmP9j44oasXUhRp3QlolFc2cLqSwbuJbJMYEO3JXJR7aVy7WYjnAUiP6S4lf8IsnC3Lz2izii+Ov3vg28pWu5EnaHgL424WDLbRqU/UDqRz9ZwbjfPJDZsYRTvyF1eiglXWeBW4WxQsUlctZVVypBZoCxcLUuySfW3Y8LEvnfjlkiuokVXdBZh/QM03qcdtCmJgH7yeVyK5EhJsHveVXGPjgqumMlxFa8SOb+B70+Ed/iRAaIGU1syqaS2O9GdvZL28XVweRtMqj+TGpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PMFopFcTiKB4Xle22oaUXIrNpbJESZtx72kTeJAvylc=;
 b=m5yFrB+A9snE9/ZD0He79EW0TE63+XvZRbhSyNYqLoxtTjCQVkv8Ubij8VEM82w6mvoVj0KLmZNEfFnylHLTtjR+8cObX789p+h6Nfo0RQN9H2dF1HN5gGrWCLOQexa5i15rzU7isCnnamLRZNsuQmMNph+QrIRyLxk+Q6viDaNDwfTfIVg7P8yEU71x22AJq7t0SzlsQpAFoP6rWr24Nw4LNB+Grn8QoqGxm6R4zn7QuGWTVPvCDU7DVgPhoEYEhu58+4hoAm22gpXegaVIpAmhwlmcMoI1PagfxQmpWkEe/ujlk/Z52J+KcSrt37jJi3HBaq7E02U3GyJ3tlC+Dw==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DU0PR04MB9345.eurprd04.prod.outlook.com (2603:10a6:10:355::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Fri, 10 Jul
 2026 16:48:44 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Fri, 10 Jul 2026
 16:48:43 +0000
From: Frank.Li@oss.nxp.com
Date: Fri, 10 Jul 2026 12:47:52 -0400
Subject: [PATCH v6 10/10] dmaengine: dw-edma: Remove struct dw_edma_chunk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260710-edma_ll-v6-10-1471d278b73a@nxp.com>
References: <20260710-edma_ll-v6-0-1471d278b73a@nxp.com>
In-Reply-To: <20260710-edma_ll-v6-0-1471d278b73a@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>, 
 Niklas Cassel <cassel@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Koichiro Den <den@valinux.co.jp>, 
 imx@lists.linux.dev, "Verma, Devendra" <devverma@amd.com>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783702067; l=10681;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=BYhKp4J+oVexGhJgGuYRS4bgHP0tBVlFbYcuTz71Uts=;
 b=huZvFZDlNNWAltc+GH5BC4SVQrhQKZikcKMAc5Ogm8W+ou2lpuLaRKc2WUzfhfNuQ/0r70GJx
 1dSSJmEhysbCkwxjV7Ej1D29mnFPSPqCUaopMvY3GXtB0aMp8vnfH/1
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SN7PR18CA0029.namprd18.prod.outlook.com
 (2603:10b6:806:f3::28) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DU0PR04MB9345:EE_
X-MS-Office365-Filtering-Correlation-Id: 637642d0-fd81-481a-5cde-08dedea31a4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|19092799006|366016|23010399003|1800799024|921020|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	25ROY6o6g4pwwdQ7BX2nFYvqxusm3Wh/F+yRa21V7XwBEu0hZDYSkFZI2y8xCRUsIwWKIn81hTONrFTl39vZl5J5rK5Aw5bLeQl9oNX5Xt/lTPYaAktg00Fz2hVZ57w4BPOLTjWHTMywtFsJpOIcrPWJR6TF5A0+hmbpnBIh4IBCqKdyrPA9ov3/a79pdOroKS2q8F2/ELuuk7MB4Wyww1lwSfzRbXBQzEZrlFYDCmS8ckbFhVHgkIRQq8yQdZ8czlglz3RyvhC63XXdMedIXYbIMAUeOwQRULkLKxE5ym8adEdljt2KOvgmrMKrQWHjyhsSezTmGx9BimnE1BbddtJYfkUeVcpht29JJLkK3G+wQZrCAcr9fHvwcWot4tLfEIHiID5bl6duvWbYtkZeZUjSf3wYkorPwMXonhNOXWZ5Z+/8TTZ/RgktF+j0X8zJApdvHZbz4bLEOvNIr06aCjGkJTwwVkJxUEWq+4SRZdL1IwgWwBXZKv/B12ZS3YjIj3/tV3PAjxpl79HxsjB/5s3Renc7epV5cjruO9SdnzjEoBYVQ61fz0BUJlPdoN/PvbTO2K9R4iYkA2EWu0D4XPODxoozJYJY6S0ZcH8V9tXzPI+bK8W3Ipd3h3CCz1CbFM//drE6zVA7qSYC4B5+D+M76BzKnh51aG35jClDg8fsKT49seJZHeNTC6rvD2auPnr6UxHKFIbDEw1EbRJrGw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(366016)(23010399003)(1800799024)(921020)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUhqbURYWDdETGEraE5QMHVURzZtdDQ4bU9NSXdKVGhCNG1NaHVwbkVTWlBH?=
 =?utf-8?B?REZyQkpRQ0NDTjlCcW53ejRleGsvVDJSeC9wRlMzNnkzOVFicnB2bHpQbUYz?=
 =?utf-8?B?UUp6SlhJWWUxNnNJaUV2UzBPN3lpTHkycDM4c0plWElGMzdrSWd0aHBEOUg1?=
 =?utf-8?B?a2pNb1UvK0ZvTG01WFhBSmZuTHJ2UlBzN1ZNbTNNL1RtYU53NHFscTJVUSts?=
 =?utf-8?B?Ulk4d0h5OGprQXRlZmFhaUVXdjY4MFJXN0tLSGg4SjVKeExKcGozU3ptbHFM?=
 =?utf-8?B?dWJ0cXBES2ZxeDhZcnBENi9HRTN2ZWFnVFd6NG1vbndETjkycHl5dlpWVEhw?=
 =?utf-8?B?VGVuMjdCWXllb3lML3hhb0xPUU1POHBiVzdRcTRwODVHdkJiWU9RYjJuTEZs?=
 =?utf-8?B?WWM2b2ZvaXIwVjJYeWd2RHhTd2R0MHdxVWRtK1Q0MHN3cDRyYUh3bXNRMFIx?=
 =?utf-8?B?VExDWUVIV25QcHZFQnpRbmNERUpZMlY3cCtxdmZuNzdaajJLL0JMY1Z3R3Jw?=
 =?utf-8?B?VFdrTUx5Wm1oTzNkTm9Lc0hGd3Rhc0xqc1ZYdHZOeHlySzJ4SEM5QmVrRmRH?=
 =?utf-8?B?a3RQUG5saXJITE9hVTZsWXc5Wmk1ZE1VR1M3QmRmcGVzb1Y0V2NxT3EzTUhm?=
 =?utf-8?B?MERTcE8yK09sVThZVmduNmJtL2tGME5LNCtIdk02ak1CZjVzeEhkcGhNU1JK?=
 =?utf-8?B?MGNuQjgwQldsWDd1WklEN2FiWEFlcEx2V2p3cGQ3K0lxcW5XUm5kSWFVNXkx?=
 =?utf-8?B?NGNWYU9OWDhHQjhPZHN2N0l0RW1GUGY0Q1RBd3E2cFQ4V1RBZjYrMXo2RDFR?=
 =?utf-8?B?STNCa3BXUDJrRWVlRzBXK25WNjhlSjNkTE43YzN6ejBCNC9USWE2aXQ4T3JY?=
 =?utf-8?B?QlpYOTJxamd4R0RmT2MwaHFmaVlhWnI2bFFUSVFab1N3eEthNXNUKzlCZTVu?=
 =?utf-8?B?anBMaUhKQUkzZHFLU2MrTG91Q0pMa1o0ODVnaytkTDhCWFFtS2pVOGNGNXIv?=
 =?utf-8?B?NE5TZ2JuVmFPQjhndnhoa0xHRWY2Z1lwb0NnbXNLNGFRNW05SnBQOGR2dDBq?=
 =?utf-8?B?b2NxZ2tqMkpJQzBydE5aZHNxejVKOXVJMkF1QU9NSnQyMjBEelVpaVA3elBF?=
 =?utf-8?B?cWJFWkVNdWtzeS9WK2ovVXVNanAyZXFBWWUxbXgxVnovTlJHSCtZWWQyNU5G?=
 =?utf-8?B?aHhMY3VPNGtROE91SU1ONHlMb2hiRGpxeVpQMkxUU0FEKzB0c3VYR2pGSGpk?=
 =?utf-8?B?NTUzZUdneHEvdGtxNUZHZUFudk5tcEdpNWw0OVBHekMrd2J6aHRIQXFTU3Zy?=
 =?utf-8?B?SmJnU2owS3JHNHFhbGprdE9nNm4zcWFENjVKN0ZFQzVXa0VBTEtCV1NVN3VQ?=
 =?utf-8?B?bFJHTWhUU1NOTjl5eGtTOUJZMUVha1ZCZ2E1YUZybjFzemdIRTVCZVBRc1RF?=
 =?utf-8?B?Z3I2VU5DTXd6VktmTkdLVGRxcXRBMXBmNEx3YUR2NTRUQ3JuT0xNZ0xDWnRH?=
 =?utf-8?B?bkNiNkdmVnJld2E0K0xIK2QyRXM5TmhwZm5BMWxrczlOcTI5YnZHV29wM2dh?=
 =?utf-8?B?OGN2V2ltU3MrWWdyR2lQclRhRkdybnkyQXlkMVVxdFZhQkwrVWV2SkUrbXg5?=
 =?utf-8?B?ZTBMS29GNWJjNXU1MU96V1Ewbm9OUGt0VXRjTm52T0Q3Q1Z1WFBObmdXeUZP?=
 =?utf-8?B?VVNlTzdzRW5rWXJmRDV3OHVjWTg2Z1gyYmgyUmxqRTd1WEltN3lTTzFNSmhW?=
 =?utf-8?B?Z2JBSEJMUjBpYTM0bjRKV05KdUsrRTlocU9zZyttdkM3OWFpR0RyVlh1eitB?=
 =?utf-8?B?bUxOSkxWTnZrWE9WaEVmSjljdk9STkhpakpTQ2U0UjVqakRvMWM5WG5odGV6?=
 =?utf-8?B?UnArRFM3aVNjZU81N0l2bkJyVURRV1Q1Rm8rM003dDd0RzNPY0s5WEJPT1gr?=
 =?utf-8?B?aVRlSGtoNU5Vd2UySnF4TzlXNE9lRXJwdzFtd2ZpZzZ3TWpmZ3I5OXV1R1JR?=
 =?utf-8?B?ZjBTd2tqRXpEdjZNajJLaW9wajhUcFZPb2dhb05pTCtTcDR5T3kya3UrSndF?=
 =?utf-8?B?NTArSGxySzRCOUVaaFF5Uy9NbW9JUkdMZzc0Q2NpcmU4dGMxbjcxVDdseTFp?=
 =?utf-8?B?dnp4eGZPdHc5ei9DTWhxYzBsU291eTJLS1I5NnNGeS8rSkwvUTlBcjgvdzNj?=
 =?utf-8?B?Rk5HTU9wR2JvVGREZEJ0Zld5ZHhPZ1kxR1E5bjYvTVJpZkl3RkV3R1Z4cnVw?=
 =?utf-8?B?VnQvR0FQS0VocStjZDZzbmVhR1d4SHl1T0QxVEVROTdtb0wvazZYWXo0ZXdy?=
 =?utf-8?B?bmU4SEhIb3JHQnZBaG5lUm80aEFZY0c3ZnhYZUkybnVnekdYbEpXcFIxSVd0?=
 =?utf-8?Q?zK04+IVCoKgTAWAG32SlMCdZf+0KoBmBxRMhv?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 637642d0-fd81-481a-5cde-08dedea31a4b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 16:48:43.8568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sGL43GkHS9p8oJ6WImZjs5uXxbEOYUkEvXDW6PlOX5ufg1V4aWfLhmw7Jpz1xbx6KCPy6Js1pDTl/WyvuXiT5Fm+kDU1OxAgWLD4yeGq+uo1UvDjrBWgjUSfvYraW33g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9345
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12332-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:vkoul@kernel.org,m:Gustavo.Pimentel@synopsys.com,m:kees@kernel.org,m:gustavoars@kernel.org,m:kwilczynski@kernel.org,m:kishon@kernel.org,m:bhelgaas@google.com,m:hch@lst.de,m:cassel@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:den@valinux.co.jp,m:imx@lists.linux.dev,m:devverma@amd.com,m:Frank.Li@nxp.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[Frank.Li@oss.nxp.com,dmaengine@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@oss.nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:email,NXP1.onmicrosoft.com:dkim,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nxp.com:mid,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8464973CCC5

From: Frank Li <Frank.Li@nxp.com>

The current descriptor layout is:

  struct dw_edma_desc *desc
   └─ chunk list
        └─ burst[]

Creating a DMA descriptor requires at least two kzalloc() calls because
each chunk is allocated as a linked-list node. Since the number of bursts
is already known when the descriptor is created, this linked-list layer is
unnecessary.

Move the burst array directly into struct dw_edma_desc and remove the
struct dw_edma_chunk layer entirely.

Use start_burst and done_burst to track the current bursts, which current
are in the DMA link list.

Tested-by: Koichiro Den <den@valinux.co.jp>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v6
- use size_t for nburst, start_burst, done_burst, to fix sashiko report
integer overflow problem.

change in v5
- fix double substract and done_burst -1, found by sashiko AI
- remove unused field chuck_list, xfer_sz and chucks_alloc, found by sashiko

change in v4
- fix loop condition check in dw_edma_core_start(), found by sashiko AI.
- collect Koichiro tag

change in v2
- remove debug code
- move "residue = desc->alloc_sz;"  in if(desc) check
- keep inline to avoid build warning
---
 drivers/dma/dw-edma/dw-edma-core.c | 147 ++++++++++++-------------------------
 drivers/dma/dw-edma/dw-edma-core.h |  28 +++----
 2 files changed, 63 insertions(+), 112 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 202862a828b4d..30eeb7bffad80 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -40,82 +40,54 @@ u64 dw_edma_get_pci_address(struct dw_edma_chan *chan, phys_addr_t cpu_addr)
 	return cpu_addr;
 }
 
-static struct dw_edma_chunk *dw_edma_alloc_chunk(struct dw_edma_desc *desc, u32 nburst)
-{
-	struct dw_edma_chan *chan = desc->chan;
-	struct dw_edma_chunk *chunk;
-
-	chunk = kzalloc_flex(*chunk, burst, nburst, GFP_NOWAIT);
-	if (unlikely(!chunk))
-		return NULL;
-
-	chunk->chan = chan;
-	/* Toggling change bit (CB) in each chunk, this is a mechanism to
-	 * inform the eDMA HW block that this is a new linked list ready
-	 * to be consumed.
-	 *  - Odd chunks originate CB equal to 0
-	 *  - Even chunks originate CB equal to 1
-	 */
-	chunk->cb = !(desc->chunks_alloc % 2);
-
-	chunk->nburst = nburst;
-
-	list_add_tail(&chunk->list, &desc->chunk_list);
-	desc->chunks_alloc++;
-
-	return chunk;
-}
-
-static struct dw_edma_desc *dw_edma_alloc_desc(struct dw_edma_chan *chan)
+static struct dw_edma_desc *
+dw_edma_alloc_desc(struct dw_edma_chan *chan, size_t nburst)
 {
 	struct dw_edma_desc *desc;
 
-	desc = kzalloc_obj(*desc, GFP_NOWAIT);
+	desc = kzalloc_flex(*desc, burst, nburst, GFP_NOWAIT);
 	if (unlikely(!desc))
 		return NULL;
 
 	desc->chan = chan;
-
-	INIT_LIST_HEAD(&desc->chunk_list);
+	desc->nburst = nburst;
+	desc->cb = true;
 
 	return desc;
 }
 
-static void dw_edma_free_desc(struct dw_edma_desc *desc)
-{
-	struct dw_edma_chunk *child, *_next;
-
-	/* Remove all the list elements */
-	list_for_each_entry_safe(child, _next, &desc->chunk_list, list) {
-		list_del(&child->list);
-		kfree(child);
-		desc->chunks_alloc--;
-	}
-
-	kfree(desc);
-}
-
 static void vchan_free_desc(struct virt_dma_desc *vdesc)
 {
-	dw_edma_free_desc(vd2dw_edma_desc(vdesc));
+	kfree(vd2dw_edma_desc(vdesc));
 }
 
-static void dw_edma_core_start(struct dw_edma_chunk *chunk, bool first)
+static void dw_edma_core_start(struct dw_edma_desc *desc, bool first)
 {
-	struct dw_edma_chan *chan = chunk->chan;
-	u32 i = 0;
+	struct dw_edma_chan *chan = desc->chan;
+	size_t i = 0;
 
 	if (chan->non_ll) {
-		if (chunk->nburst == 1)
-			chan->dw->core->non_ll_start(chunk->chan, &chunk->burst[0]);
+		chan->dw->core->non_ll_start(chan, &desc->burst[desc->start_burst]);
+		desc->done_burst = desc->start_burst;
+		desc->start_burst += 1;
 		return;
 	}
 
-	for (i = 0; i < chunk->nburst; i++)
-		dw_edma_core_ll_data(chan, &chunk->burst[i], i, chunk->cb,
-				     i == chunk->nburst - 1);
+	for (i = 0; i + desc->start_burst < desc->nburst; i++) {
+		u32 idx = i + desc->start_burst;
 
-	dw_edma_core_ll_link(chan, i, chunk->cb, chan->ll_region.paddr);
+		if (i == chan->ll_max)
+			break;
+
+		dw_edma_core_ll_data(chan, &desc->burst[idx],
+				     i, desc->cb,
+				     idx == desc->nburst - 1 || i == chan->ll_max - 1);
+	}
+
+	desc->done_burst = desc->start_burst;
+	desc->start_burst += i;
+
+	dw_edma_core_ll_link(chan, i, desc->cb, chan->ll_region.paddr);
 
 	if (first)
 		dw_edma_core_ch_enable(chan);
@@ -125,7 +97,6 @@ static void dw_edma_core_start(struct dw_edma_chunk *chunk, bool first)
 
 static int dw_edma_start_transfer(struct dw_edma_chan *chan)
 {
-	struct dw_edma_chunk *child;
 	struct dw_edma_desc *desc;
 	struct virt_dma_desc *vd;
 
@@ -137,16 +108,9 @@ static int dw_edma_start_transfer(struct dw_edma_chan *chan)
 	if (!desc)
 		return 0;
 
-	child = list_first_entry_or_null(&desc->chunk_list,
-					 struct dw_edma_chunk, list);
-	if (!child)
-		return 0;
+	dw_edma_core_start(desc, !desc->start_burst);
 
-	dw_edma_core_start(child, !desc->xfer_sz);
-	desc->xfer_sz += child->xfer_sz;
-	list_del(&child->list);
-	kfree(child);
-	desc->chunks_alloc--;
+	desc->cb = !desc->cb;
 
 	return 1;
 }
@@ -337,8 +301,10 @@ dw_edma_device_tx_status(struct dma_chan *dchan, dma_cookie_t cookie,
 	vd = vchan_find_desc(&chan->vc, cookie);
 	if (vd) {
 		desc = vd2dw_edma_desc(vd);
-		if (desc)
-			residue = desc->alloc_sz - desc->xfer_sz;
+
+		residue = desc->alloc_sz;
+		if (desc && desc->done_burst)
+			residue -= desc->burst[desc->done_burst - 1].xfer_sz;
 	}
 	spin_unlock_irqrestore(&chan->vc.lock, flags);
 
@@ -355,13 +321,11 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(xfer->dchan);
 	enum dma_transfer_direction dir = xfer->direction;
 	struct scatterlist *sg = NULL;
-	struct dw_edma_chunk *chunk = NULL;
 	struct dw_edma_burst *burst;
 	struct dw_edma_desc *desc;
 	u64 src_addr, dst_addr;
 	size_t fsz = 0;
-	u32 bursts_max;
-	u32 cnt = 0;
+	size_t cnt = 0;
 	u32 i;
 
 	if (!chan->configured)
@@ -418,17 +382,6 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
 		return NULL;
 	}
 
-	/*
-	 * For non-LL mode, only a single burst can be handled
-	 * in a single chunk unlike LL mode where multiple bursts
-	 * can be configured in a single chunk.
-	 */
-	bursts_max = chan->non_ll ? 1 : chan->ll_max;
-
-	desc = dw_edma_alloc_desc(chan);
-	if (unlikely(!desc))
-		goto err_alloc;
-
 	if (xfer->type == EDMA_XFER_INTERLEAVED) {
 		src_addr = xfer->xfer.il->src_start;
 		dst_addr = xfer->xfer.il->dst_start;
@@ -452,19 +405,15 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
 		fsz = xfer->xfer.il->frame_size;
 	}
 
+	desc = dw_edma_alloc_desc(chan, cnt);
+	if (unlikely(!desc))
+		return NULL;
+
 	for (i = 0; i < cnt; i++) {
 		if (xfer->type == EDMA_XFER_SCATTER_GATHER && !sg)
 			break;
 
-		if (!(i % bursts_max)) {
-			u32 n = min(cnt - i, bursts_max);
-
-			chunk = dw_edma_alloc_chunk(desc, n);
-			if (unlikely(!chunk))
-				goto err_alloc;
-		}
-
-		burst = chunk->burst + (i % chan->ll_max);
+		burst = desc->burst + i;
 
 		if (xfer->type == EDMA_XFER_CYCLIC)
 			burst->sz = xfer->xfer.cyclic.len;
@@ -473,8 +422,8 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
 		else if (xfer->type == EDMA_XFER_INTERLEAVED)
 			burst->sz = xfer->xfer.il->sgl[i % fsz].size;
 
-		chunk->xfer_sz += burst->sz;
 		desc->alloc_sz += burst->sz;
+		burst->xfer_sz = desc->alloc_sz;
 
 		if (dir == DMA_DEV_TO_MEM) {
 			burst->sar = src_addr;
@@ -529,12 +478,6 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
 	}
 
 	return vchan_tx_prep(&chan->vc, &desc->vd, xfer->flags);
-
-err_alloc:
-	if (desc)
-		dw_edma_free_desc(desc);
-
-	return NULL;
 }
 
 static struct dma_async_tx_descriptor *
@@ -605,8 +548,14 @@ static void dw_hdma_set_callback_result(struct virt_dma_desc *vd,
 		return;
 
 	desc = vd2dw_edma_desc(vd);
-	if (desc)
-		residue = desc->alloc_sz - desc->xfer_sz;
+	if (desc) {
+		residue = desc->alloc_sz;
+
+		if (result == DMA_TRANS_NOERROR)
+			residue -= desc->burst[desc->start_burst - 1].xfer_sz;
+		else if (desc->done_burst)
+			residue -= desc->burst[desc->done_burst - 1].xfer_sz;
+	}
 
 	res = &vd->tx_result;
 	res->result = result;
@@ -625,7 +574,7 @@ static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
 		switch (chan->request) {
 		case EDMA_REQ_NONE:
 			desc = vd2dw_edma_desc(vd);
-			if (!desc->chunks_alloc) {
+			if (desc->start_burst >= desc->nburst) {
 				dw_hdma_set_callback_result(vd,
 							    DMA_TRANS_NOERROR);
 				list_del(&vd->node);
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 4950c57fca34f..3c958ca05144a 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -46,26 +46,21 @@ struct dw_edma_burst {
 	u64				sar;
 	u64				dar;
 	u32				sz;
-};
-
-struct dw_edma_chunk {
-	struct list_head		list;
-	struct dw_edma_chan		*chan;
-	u8				cb;
+	/* precalulate summary of previous burst total size */
 	u32				xfer_sz;
-	u32                             nburst;
-	struct dw_edma_burst            burst[] __counted_by(nburst);
 };
 
 struct dw_edma_desc {
 	struct virt_dma_desc		vd;
 	struct dw_edma_chan		*chan;
-	struct list_head		chunk_list;
-
-	u32				chunks_alloc;
 
 	u32				alloc_sz;
-	u32				xfer_sz;
+
+	size_t				done_burst;
+	size_t				start_burst;
+	u8				cb;
+	size_t				nburst;
+	struct dw_edma_burst            burst[] __counted_by(nburst);
 };
 
 struct dw_edma_chan {
@@ -128,7 +123,6 @@ struct dw_edma_core_ops {
 	void (*ll_link)(struct dw_edma_chan *chan, u32 idx, bool cb, u64 addr);
 	void (*ch_doorbell)(struct dw_edma_chan *chan);
 	void (*ch_enable)(struct dw_edma_chan *chan);
-
 	void (*ch_config)(struct dw_edma_chan *chan);
 	void (*debugfs_on)(struct dw_edma *dw);
 	void (*ack_emulated_irq)(struct dw_edma *dw);
@@ -170,6 +164,14 @@ struct dw_edma_chan *dchan2dw_edma_chan(struct dma_chan *dchan)
 	return vc2dw_edma_chan(to_virt_chan(dchan));
 }
 
+static inline u64 dw_edma_core_get_ll_paddr(struct dw_edma_chan *chan)
+{
+	if (chan->dir == EDMA_DIR_WRITE)
+		return chan->dw->chip->ll_region_wr[chan->id].paddr;
+
+	return chan->dw->chip->ll_region_rd[chan->id].paddr;
+}
+
 static inline
 void dw_edma_core_off(struct dw_edma *dw)
 {

-- 
2.43.0


