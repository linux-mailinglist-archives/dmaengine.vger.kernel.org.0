Return-Path: <dmaengine+bounces-12323-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VfOcIO4kUWrH/wIAu9opvQ
	(envelope-from <dmaengine+bounces-12323-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 18:59:26 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A3E73CD40
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 18:59:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=q7VUP4Tn;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12323-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-12323-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B1A5A30B2882
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 16:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24B943F4D3;
	Fri, 10 Jul 2026 16:48:03 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011068.outbound.protection.outlook.com [52.101.65.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25BA43E9DF;
	Fri, 10 Jul 2026 16:48:01 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783702083; cv=fail; b=lQyBJJpuBL3Rgl1NFAT4WBIaq7QAqrqmmMCq5Hb2Lo9T+6A1Ycc27W/RVEDroJQxX6i/DElU9MUMVVbc2sy/BGY17OoA6EXgSOfsYs3r5Qom+xmj5sIkusbw/lKW3CTbKAxP4gXkEFSVzSb7QB5DT8wXFob4mUzBQOxe5vYO6wg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783702083; c=relaxed/simple;
	bh=LEdJdCACevNrxSBUJ8meqngfIrqiHsc5sZQnnH3iNDc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=C6fwnVRQvtNJSMrz0dHYxHsUpeHlNPdtDmbYR0Na09zNcIgPw2M4sCsxM5ExTuHUUjZAp4oDWbGWlWQ6fXouHB15Lcrllvtk+GXj3Yok7LpEN8QPFNm+dXL8N5wHSjqkMdurO5/LzSNl7iE1sIOR3zUWjG4o6I589FVwkPL8k04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=q7VUP4Tn; arc=fail smtp.client-ip=52.101.65.68
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WjXQWtf7xpb5WH/sqVpwIVVQV1YuzVm+2AyuADooFEOy6Jb3Xhgxpp/GMoTq4X3oX8ZtD/FM3H+vXlUY2MRGqGu3reK9mrDNtlcDYMYgAS5LfoF7oS0kqbBaFw/PI/ewXm24Wiovau1sVCMZ/PvqQanDa3UGAk7yCSWHPagGrMsHcKM2DFVUe7OLlzRFyQtnupduD15dcITYVSfXcNgdVAO8fdnuyXHQVubTkCBU4zFOToYMu7uGiL9iJzYkUmHC01aAQGEVmT+rWs9hIwuKh6Pc6FwOVDl3g87KfyI6iNZFXvfB+B8DWiVSjmR8OxZF0NhD9xgaRC0bea5/H6P1Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vdfg/n8nGgvFwcsy0j9MK+wCSiPdNNYD732a15idxaI=;
 b=bycDsh5CvkMi5sFnJtYEhqkIhCHmAENQUGOSd8j3FoMP0eWY6hJwPfMJhJxwKNrwXq1SknZZZuKcRNboIMDQ4QpdCsWsR6QadH0YgYSbighnwPYtTa1ZqwQEOXS1rVii8FMjUvTM00bTkqjpiVeZ/loLc6CL/tXQ2j2V2yMydAb0aSXqt2fWARFCMSld+TDVWYH0fJoyrwxe8P9U/Ea6FQA407Rb0ye9uoJywyz6v7W/T9csknZJoOly3ettQiAgaf8JORAvG9sFp5TQ2t4U8O3d13Qu/0UMIdwop0b9emhirTtIBosh5JsUddfTfRcaDhR3N35n1n179IZGNL5Wgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vdfg/n8nGgvFwcsy0j9MK+wCSiPdNNYD732a15idxaI=;
 b=q7VUP4TnsVOqtTVgU9hJq6FiW8+EvbMBsDxo3zMUxEO+951ycwwusxAbXKnudNw5gBTMsSJzfOIpVfX4daREN0EAAKd5PTqCYRCsK1wL5+8+K7cmWoqUKb+0J8D2CvjX2/GlxEhrTwntisj0Xp/p5e2jiiYKCM+k7WT10m74Iw5GMLLFj7Y57UQVtzV39vc3qZ6m+IgrC/Ha2BEV+KFAhcdk0nmB5ONVrrOQM9m/FXzoH4rPiH2B8/Q3mpJPbHgcMwwQEWTAdsbtcTcf9YQVgx9laiG6SmCWZUsLN1pQ9eKhzp9KRKMEc0WUTjgbg2HyREalCUgg4PotzhdMLjKosA==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AS8PR04MB8578.eurprd04.prod.outlook.com (2603:10a6:20b:425::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 16:47:58 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Fri, 10 Jul 2026
 16:47:57 +0000
From: Frank.Li@oss.nxp.com
Date: Fri, 10 Jul 2026 12:47:43 -0400
Subject: [PATCH v6 01/10] dmaengine: dw-edma: Move control field update of
 DMA link to the last step
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-edma_ll-v6-1-1471d278b73a@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783702066; l=3566;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=geWLY7+7Bq0r3OZ5EWJpTkJEDEWVSA01WcSxrlvbm7w=;
 b=tmOQu5eXOK5AQLatav66r40wIQoDOlxHy3nFk0mBmuzMAaWDR5zTKV0K6HeTRahoEdlZnru3Y
 wT2pPrQPY82B5HyvV1uYJcK/mhafsLQ5CmEXU+FUae2GK/d/3L3vU1v
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH8PR20CA0009.namprd20.prod.outlook.com
 (2603:10b6:510:23c::23) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AS8PR04MB8578:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a23e3ed-ea52-4eb2-61a1-08dedea2fef7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|23010399003|7416014|376014|366016|22082099003|18002099003|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	4/W4acx+hTBlB/RaTSE3aRYQsnI+8SkYZ9nM/cUiOc5YR4SUpp19fmYIZ5Hi77+1ozd5u0piOOVFwmp7RD73rSEIeAx4wdJOR2lkheuPiUZa2ICu54BzghP+h5+KiOOTytOEPGjkg7oogitIQ1LOCBIYEVg9Ajs0YBle2jPlxsn+c2TCKYh73tIx+zKGXqa6UVL5dT5UCC9KzRCm32Rkdzl74HENjhPUCHUNQpaCdRbR2Z3cEJodoHj1tSE0oZ3KIOr81JOK1QrConrkz+zJ0XTDMJoZsfBU/Y34sEDmbLMknVBT/y9W0gYbnLORcZizv4Bl4EPGBzGWqw2vco+9JAdy//d6pIXkjfMaphYVyCpRA2EBLapKoMi2XmanKZ2Ikv2g1+vAFbijaFhIbLmPYxJ2hCYZidtNuDb0hDwqnu6D6WYvjRUpP8SDUQnLEXAJTcRd/8p9pjdLWyNydmVEmUo/CGGKI+PINf09DirVsnC55wBjqpzD+rh9ngUTtaTZNwF3Xqs6C2j+yUlvXoPd262IQQLkkZlLqCuN36CzhrMUDSPYLGAMKtp5h1sVY9wDJtKvqbLhaHi6Ak7uDtTUh/FJNenHzIUKuQVkoPHDz21f35omhOvldD6e20hqE9CMYd2CRsMWy8MciU5YGvGzp0N9LLYIL7CWRMIglYIJ58gY8T7oqkv6snASmoMVZICggzQ84Mn1xxE51KNySEvyXw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(23010399003)(7416014)(376014)(366016)(22082099003)(18002099003)(11063799006)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ump0T2JKcmxpRDEzeUVvc2tXK0Z6dENNSWZ2Ti9WNDJPQVZqSjA3U2VZZElV?=
 =?utf-8?B?N09pSHI0STdCd0VEVDVzOEN6UEhaeitlTTNIQUl6bmNld2lZQlMza2k3Ujhq?=
 =?utf-8?B?aVJQVllSSmROWW9tVVY5Y0NNV3RUSmZRZGtXdHpQYnJlTnViQzRRQllWTlk1?=
 =?utf-8?B?eHMrNGx6a1hMdWRMZVR5R1FPaGx6VFRCNVd0K1d6VWJlVTZCRllHQWxnWmNi?=
 =?utf-8?B?cDdiYkJtYnhwUlBFeU9Sa09FUEQxak0rVTY3eXlsV3FOYXJHUUtNQ3p0NFpz?=
 =?utf-8?B?WXBNaVJuM0FZcnE0RW9QYXdZS0pFbGJQUXVJWHN0R0FTSGVPVEt6bm5vV01J?=
 =?utf-8?B?SXRmVklrMVZTM2NxN1doV1hzQ2t3ZUozUUVxUEZNOStUQUpRTE5DTGRYMXlL?=
 =?utf-8?B?eHY4dVA2RFVhdHMyYkRQeU5JSEdvNDFIMkNDeXlOUy9nV2dySHNjaVpuamll?=
 =?utf-8?B?NldFRGpsU2JmUE1ZaE1McHZqdkx2MVEzQkVySHlUM25QcXRBZFdIdGFFMmdK?=
 =?utf-8?B?dlYvZksrNkw4UU9mb2kyemZESGU5MjJDOW9ScXNCUjdhUHVlVWRDT2pIaHl6?=
 =?utf-8?B?WWdwT25EOUJSMlloTlZlTmU4Q0ZXdFFQdW4zbEtjaVExQUpWYjRmYU5ubThH?=
 =?utf-8?B?Tjg0OWtaNkJTWU1vVzhPMDZheVVDTlAxWXZSSS94dUttcHE2TitsekMwVTNB?=
 =?utf-8?B?OWlrTkUzMXhoUklUY0FZTVFFSGVFUlRYb1k2S01STjQya2NmYktGWSsvUjdm?=
 =?utf-8?B?cnFkNERIWFViOEdMUlVYRy9tMlc4dFFJcUI3RTZCQlNya09sMThlWE03dW43?=
 =?utf-8?B?azhMQlZFZlNkTjJxbG1XalBZazF6bk1VY0J0Nm5sNjhMaGFGcVM5U2tBWml4?=
 =?utf-8?B?NzVXWVVSWmNYaWRnRzIvWGszQklXTDErTVFJRG1uUWxnK3ZKVHZZVzlpNmRv?=
 =?utf-8?B?aEdmTkgyK2ZDclQxZG92dHlxVVNNN1ZVdXhaMFV6Qy9nL2VTSmJMc0dET1BE?=
 =?utf-8?B?SkxKRHlDWWpPSGJpQ1dpLzRPRXpVUk5hcU9MQmliVENldmxUTW9wdmFYbC8w?=
 =?utf-8?B?SVFMTStVdDhsNWlHZ29OaWd4aHBzb2JxRWRKVkVadGlTSFhHc01oeVNSTG05?=
 =?utf-8?B?ZEY1Q1J3T1FiY2x3bFFwNWVjRG5FU3V4ckpSc3k2YXRRZG5HMzgvU1M2OFhP?=
 =?utf-8?B?SFNIUlY0YXQ1REh5K3JrcTBjZFNWTmhhWEppVWwvcGJQQytubFdZODNOTU1T?=
 =?utf-8?B?Yit0UjYyNG5iZ2s5b0R3cW9GeGR1ZUxCd29Tb09nSGNRY1BTd21iUW5EYWVV?=
 =?utf-8?B?eExVZDlKbEZMdUlmOVBITDR0SHZjdnRRbUNCNzh1SDUvQkRwNUFsKzBOZzVQ?=
 =?utf-8?B?RU8xWmtCUnA2RVl2bUZ1R0M3eGMyMDV0UmdPRDF4OUNxMUtyNGhuNnU0dlF2?=
 =?utf-8?B?YmxpQ1FqYmY4Z2JHUmQ2WjUrVDEyVEFpcXVEV2YzdWtrQUVrT2RXRlVnU1p3?=
 =?utf-8?B?WGRoa0tQUEYreXpjeGR2TDMrTHlscUg3NWpRMVh4ZEhYaWpFZmxIQTM1YkNI?=
 =?utf-8?B?RG45Q3Z4NGxxMnpFYkxTS3RDV3dWR3VQMlh5K1hjUmVwTlAvMGZQdGtJanAy?=
 =?utf-8?B?L2REM0w2UTlSUk82Q2taY3lzSy93NmwwNUEvYVlCR0NUQWZqS2xVV2NXMExB?=
 =?utf-8?B?NWVCMTU1Qklza2tkMlJua2Z6SzlzdFA3V0tRY0grTG9oVjBVZWdxZFpoMHpa?=
 =?utf-8?B?VGNFdkxvQnFWY25XaGg4WHZHaGhuK2hJV0xkdFFDZHJwZHBzeE1tbXV5UzQr?=
 =?utf-8?B?U04vWVJHSzkxWGVxVUl2RStEY1I5aUoxTGlPeWRtaTB4bGIycUs2cHk0TkVE?=
 =?utf-8?B?S0IwR0lmZWtQM3BHRHNsdERudkFjekswS1BNOVlnNkd3UDBsU1lTMjJCclp3?=
 =?utf-8?B?SFM0Z0hublA5SFdIWk1QY0NoR3VPTW5NaENnSW1hNXdWT0VlVExhOUh1b2Zk?=
 =?utf-8?B?TTFITjZFNjBOcGU2L2h2clFZSUY1MHZ5R1ZacVBYNUFOQ1V5YVh5TUNxRTdV?=
 =?utf-8?B?d29rUmE5aExqQVpwQTYySGRIQTRlb3ZlRksxTGsyRDJ0NmVPOXZ2UGd4ZlpS?=
 =?utf-8?B?clBIOVZpYUJMdDBxWVRwZ1RDcnJ2WHRmU2xmUjB0eUQ5QXdNMFVVN3BFblZw?=
 =?utf-8?B?T05ORXFORXdFcTRnWktwTElwZHU3aXJxYW1CdnBxMFhrU0tqOHAyR3BmVGJH?=
 =?utf-8?B?Y2dZUk4wZUE2TmFHc010RGc1aTdwWmV6Zm1IdFB3KzljZXlmTnVIVWxwOTJD?=
 =?utf-8?B?VXNGc2lzdU0zbHhrenQ5cmVndHVvald4MVcrODNmaGxxMHJSTnNqWmVmQ3c2?=
 =?utf-8?Q?+V3NTre91oOa+LZ0aJMlxbeqCVW0dTR6ND+31?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a23e3ed-ea52-4eb2-61a1-08dedea2fef7
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 16:47:57.8898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /1ibwHyMDeLx789tnUYdB6NDPGa1LyUzNiqV8TOew/LLBFY+BC3y7GjqrD7TOuaZWYcQ10KMnIZibLkQwoBpM6OXTB7SeW+laX8YMC3EW4jDH0WaU5nLawF0NtyyLdbU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8578
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12323-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,valinux.co.jp:email,NXP1.onmicrosoft.com:dkim,oss.nxp.com:from_mime,nxp.com:mid,nxp.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E7A3E73CD40

From: Frank Li <Frank.Li@nxp.com>

The control field in a DMA link list entry must be updated as the final
step because it includes the CB bit, which indicates whether the entry is
ready. Add dma_wmb() to ensure the correct memory write ordering.

Currently the driver does not update DMA link entries while the DMA is
running, so no visible failure occurs. However, fixing the ordering now
prepares the driver for supporting link entry updates during DMA operation.

Tested-by: Koichiro Den <den@valinux.co.jp>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v4
- add Koichiro's tags
---
 drivers/dma/dw-edma/dw-edma-v0-core.c | 10 ++++++----
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 10 ++++++----
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index cfdd6463252e6..ee5c3c317557b 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -284,17 +284,18 @@ static void dw_edma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
 	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
 		struct dw_edma_v0_lli *lli = chunk->ll_region.vaddr.mem + ofs;
 
-		lli->control = control;
 		lli->transfer_size = size;
 		lli->sar.reg = sar;
 		lli->dar.reg = dar;
+		dma_wmb();
+		lli->control = control;
 	} else {
 		struct dw_edma_v0_lli __iomem *lli = chunk->ll_region.vaddr.io + ofs;
 
-		writel(control, &lli->control);
 		writel(size, &lli->transfer_size);
 		writeq(sar, &lli->sar.reg);
 		writeq(dar, &lli->dar.reg);
+		writel(control, &lli->control);
 	}
 }
 
@@ -306,13 +307,14 @@ static void dw_edma_v0_write_ll_link(struct dw_edma_chunk *chunk,
 	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
 		struct dw_edma_v0_llp *llp = chunk->ll_region.vaddr.mem + ofs;
 
-		llp->control = control;
 		llp->llp.reg = pointer;
+		dma_wmb();
+		llp->control = control;
 	} else {
 		struct dw_edma_v0_llp __iomem *llp = chunk->ll_region.vaddr.io + ofs;
 
-		writel(control, &llp->control);
 		writeq(pointer, &llp->llp.reg);
+		writel(control, &llp->control);
 	}
 }
 
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 632abb8b481cf..1201f1ab5f359 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -160,17 +160,18 @@ static void dw_hdma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
 	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
 		struct dw_hdma_v0_lli *lli = chunk->ll_region.vaddr.mem + ofs;
 
-		lli->control = control;
 		lli->transfer_size = size;
 		lli->sar.reg = sar;
 		lli->dar.reg = dar;
+		dma_wmb();
+		lli->control = control;
 	} else {
 		struct dw_hdma_v0_lli __iomem *lli = chunk->ll_region.vaddr.io + ofs;
 
-		writel(control, &lli->control);
 		writel(size, &lli->transfer_size);
 		writeq(sar, &lli->sar.reg);
 		writeq(dar, &lli->dar.reg);
+		writel(control, &lli->control);
 	}
 }
 
@@ -182,13 +183,14 @@ static void dw_hdma_v0_write_ll_link(struct dw_edma_chunk *chunk,
 	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
 		struct dw_hdma_v0_llp *llp = chunk->ll_region.vaddr.mem + ofs;
 
-		llp->control = control;
 		llp->llp.reg = pointer;
+		dma_wmb();
+		llp->control = control;
 	} else {
 		struct dw_hdma_v0_llp __iomem *llp = chunk->ll_region.vaddr.io + ofs;
 
-		writel(control, &llp->control);
 		writeq(pointer, &llp->llp.reg);
+		writel(control, &llp->control);
 	}
 }
 

-- 
2.43.0


