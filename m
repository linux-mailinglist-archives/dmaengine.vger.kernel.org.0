Return-Path: <dmaengine+bounces-12406-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BKRmB/UbVWopkAAAu9opvQ
	(envelope-from <dmaengine+bounces-12406-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 19:10:13 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 668B974DE1B
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 19:10:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=S8c71qBI;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12406-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12406-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D37253052888
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 17:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66789344D90;
	Mon, 13 Jul 2026 17:03:55 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013050.outbound.protection.outlook.com [40.107.159.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E660343897;
	Mon, 13 Jul 2026 17:03:53 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783962235; cv=fail; b=DDSdYeFNrae0vVeC1cwPLY8f5vONekMFduueoOEpha8zbe3ydjOBMzLNsaTCDzCIdXZyFKRyV9xNsgcYeq+UK9W5zHxIFHScnBQ1JXLuWH9gLxcL5v7jMnxZeO85LVRaFlOkHRR/gYMjdWXsXqJxmOJ5pqYsx3aB2gkglstpA0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783962235; c=relaxed/simple;
	bh=VIXcVHpy7kQfTjt492TSNc7+MpbBhUvCSi11vcu5Na8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=nQaS1vNv6FPaxC1lnL6k39g1FYEXM/R0Oqxd8xmZzV/rGYih+YVPIKwLLZLR3QW36+k8/+VLSFQxacEjcaaiF9c+jebyDC1a1dbNAriTAp0MabCRMjMZuRPrVKPcoNN9FmljskjfKmNUB9uSKkeLpQdM1794cXf9z7HJfI4dVJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=S8c71qBI; arc=fail smtp.client-ip=40.107.159.50
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LvCQ5ZBGG9ITX+EssH/77M/4zp/Ju/Hgj/xgc1UF0lxKVDEtXAXASmoMVaOE9GW88IvdV2JjJvpaKqwhiwGAx1DWMixw26FJuoJpQOnW72ERfY7S1BuDmpK6LHmVw3Mz6VOA9sagYZHjJ2j3Dn0Z+FdWqIdfRKq7QNYhLMamFV8i1K9wUtvIS9+F4jfO6W122fcxOuK1+p3YY5wgk9xKh7jjwyWaSvaJ7DxnyI6h4YAw+F/UMwCddSyiARoha2/QRITYBw0bKrwRsYyQH3N10GSxYWs5O/nf/mSPaqMAqKPA46uOCn0ymBivb+FnDhz03TwbZg9Ny1EUBYAQaHLbVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7PzXi9IEpwj1JLyF90STiidHK2In80PmZYLlF4RHm1Q=;
 b=KELN6qlLO+fsadxTiQ8r4BTZ9bTuc0SNx0vWfVFpVbcofkBf+xWVFGGu8PSMTFLipYAPmW2k0AVxG2H4YzVZ96CTy4JlUA5/4nlQBOMrNdW0Nu9e/Juyvjdf4uSL5QJdkAhsdYVGA2+NtBCxvQpvVn7Y/fIHDeOw/rS+C+biaBLBJk3cjPFIsa/x2UqHWEd+QUE9Qk6PyA++zXe0Gi6qGVRZAp58nsYKYH3rJgZoyg/T0iiAFiIM7xfNGDJ4ss3Qg3WoWVGTZT7+49Qw91u5ny2za6brjXQMEsDG4hlBWs8R6AzJhvnLmUZSwplmLCKjaBC1ZqqcWGMEBTOB/Hu1mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7PzXi9IEpwj1JLyF90STiidHK2In80PmZYLlF4RHm1Q=;
 b=S8c71qBIOFYXf3iSjWWGSLI7YvvMT+0/Mgq7VwPzdzeFYHMLzQdvElP6yuUVe0Q4KjYaQkj09YntuYp3utYlhmQ0lN4Rc1ejJMkTA0fJGdAMdyxgCPrgECCiCesb3lue1HbNHRMCHra+LEO+OoP10vnX2i3Fy/DvsnQfWiJtT+Y60Et50pRpu+msG2NAwEqyXgMcMDBX4FXCES5nUGEtz4bS1djQBk2aQKYAtuhBstGCX6I9rOZeBgccf19QRC5SzGubRJ5DyWw11TnB+H/H98hpGxUmd1aLpV2X4WSzV5MyNiqN3uSMF+2Xb72Ay3lHyJf5KsTE/p2nZZ0wD47P4g==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA1PR04MB10228.eurprd04.prod.outlook.com (2603:10a6:102:454::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 17:03:50 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0181.019; Mon, 13 Jul 2026
 17:03:50 +0000
From: Frank.Li@oss.nxp.com
Date: Mon, 13 Jul 2026 13:03:23 -0400
Subject: [PATCH v7 05/10] dmaengine: dw-edma: Add helper
 dw_(edma|hdma)_v0_core_ch_enable()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-edma_ll-v7-5-6fb7498c901e@nxp.com>
References: <20260713-edma_ll-v7-0-6fb7498c901e@nxp.com>
In-Reply-To: <20260713-edma_ll-v7-0-6fb7498c901e@nxp.com>
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
 Frank Li <Frank.Li@nxp.com>, Devendra Verma <devendra.verma@amd.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783962202; l=8113;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=3qvghJAxIihdXBmc5CTD6vHaRL1InntJReUGZqSdZ6k=;
 b=/iDy4mUX3kveiaqKuCW7gasVbHF9DMTqIdgo1MhAJIRzj4vmzzwPI4NYStX8z9fW0T5ptOOxw
 uYqHyGrdM6oCxc2hrxx71Eaf/1MjXBIQjRn89aFqE4W7PyXnGCQArDx
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA0PR12CA0019.namprd12.prod.outlook.com
 (2603:10b6:806:6f::24) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA1PR04MB10228:EE_
X-MS-Office365-Filtering-Correlation-Id: 731fd28e-0d9b-4694-6fb2-08dee100b5f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|19092799006|1800799024|921020|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	ezKWwQeDqpNrJ0X44iiUpAs2MA27ea7hFyqvn3fxJZms88oexnnwI69dYBFM1tPP224E7gseZKUZsz9G79HT23PVfL1VRH75sjR3SgGhk40f9lK8bv+retcUjwpWBaqDt7htasXfANfLxloLzNp4sTiHefWDwzmq1S2ARUTjdl0+ZD0U0FpTVb1S5x4p+hAhu/Xmu2Bp4V7CMlqWXLNwu0mDwTgIAprRscf2Mtj4+ZgW2racSu4L8JF00oHiK/e7bCOzmaKMoFDqQnqPocg6g/mPblH5oQ5rGLige4DZh/8UyUToAApWjB6DfjdgZ3l0Dbqys5wJXXl9VKWnPCZ6Eq7x4BHZhDlMYrW454aAiXuvDzP8bXJ+w5iuR7sZAkBKWOt6eK2rlcAiHM64sejIeIuk1AfGr8CJbRiqBOKTe2usDyGvQa+nvmWnbH0qv4CJsJdz9XYeMWOIVln16tUIwLUA3OJ3eV4T1qk2fMnZkR4Gib8IPA6lNMQjkfgMzcpb/gwuLAasax6Pe5DtjO6RnO1vxoB5p/ViuekeAQiUS0gHiAKAhjkNxzzWlZ0ZMhs2hx+FVagDgt+VGqDTgPgE6Un+OT/Wm5Ep+Ti9TTkctQSHlZ+aluNfz3v10uxs15DVI78y3PZNe216nEqFfjTKgZ85q0TrQgLzlm7gH4fPU2lW8gC//r4lYzqX8FAWkINFNvwyd/sWINOdBZ1HKJLHhA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(19092799006)(1800799024)(921020)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?by96RTJDOGhySUNic1RzU2U2eGo4T0pXYnJjSWVZWG1FUmpEb0tmZkRjaTY2?=
 =?utf-8?B?K09UcHhoNFNBbzcwaWxIMTZlMUU5Qi9MaHF2UXFjSkY0d2JwUk9hbWlDbXpU?=
 =?utf-8?B?OW5pVHFicldUQmVuSXE1a3hPQkRIci8yYWR0bzlpanhSNytDZW9tczBETVFJ?=
 =?utf-8?B?VlBBdS9kTUZoM3N4eDVEWGtEcnl5Vzc3Sys3bHRpK1ZLSWlpbzkzNzV0VmRF?=
 =?utf-8?B?ejJqZTN6My9vMWVXejJwNXYvYm1WZVU3ZXpRdUZoZ1g3TkRxZFVFTnZrdE9r?=
 =?utf-8?B?VGxqZGMzUFZpVnhzVFhPSEhrNVBZUjZwSXdsaGtXNDNvRWY4RC9Ram5sdHcy?=
 =?utf-8?B?L2hCYlowTWNoNmpDUXF2NE5tK2dxWEF3NHRLeDF6bXBIUUVxY2w1SXd1OUdi?=
 =?utf-8?B?RWVmdXlXMlNkaUZJTUp6ekdwN1dhTHVqR1J2aXJQYWhQUktESHQwK2hhZlhC?=
 =?utf-8?B?R1VHbXIzS2xPeGwzenJPZi96bUVLU0lBTzRDK0J0OUNlZElmWktQanBUVFdl?=
 =?utf-8?B?TW5YdXV2dTJBbWFoMEhzNThtTnZINmRaVEJNK3BiQ0diT1MycVBWcTB0blNL?=
 =?utf-8?B?R0VXSFlTRkhmdzVYYm5RdjdjenAwNmg0QTQyN3k4Q05WTWxEN01nKzQ5cXNL?=
 =?utf-8?B?U3JzY1dzUG03N25qbVdEd3hDdEZKNDVRU2RTRWdVeGFac0VGaUJ4STBlV212?=
 =?utf-8?B?Zm1ZQlVEUFNFS0syRkp5VDBKTG11THFoMWVNQmF2Q3ZpbTVENG1DM25VU0NM?=
 =?utf-8?B?Qm5yMTZmd0lQdDVNTWx6d2hKaTdTYVFjaXBHdEc3NFJkQnhwQ2kxeGdiWHo2?=
 =?utf-8?B?SEl2a2NDMDU1TE1vOWcvOVVOeFJoU21UZUpjREZRbWE1Z1hhbkx4b3o4ZXgr?=
 =?utf-8?B?bjg2Ti9tbUFFbE5QLzVaTFVINXBUTUlaaTdrb0JJVFM1cGk1a2I1c3VmTTlz?=
 =?utf-8?B?cnBLdjlsckZVR3YwK2I4V0tlOSszanlBUXVxWW43Yml0ZWRJT1BidDlRYXpv?=
 =?utf-8?B?TDZ5WHNEUGdyaGdoUnljdDIxdTlOT2w2UTFxYmxjaUNGYU54VFQ0YUFxT0ZO?=
 =?utf-8?B?bjk1YmlyM0lZVVk4ZUd2VVQyY1JiSGQ1ZFJYcEE1UGNLR0ZWRDBDd2tqbFVF?=
 =?utf-8?B?QVlZV2tkN3BEMkZvSnMvMjdDK1hRTmpjSlNHaWJsVnVrQm1KTEgweHhobmdC?=
 =?utf-8?B?eHBLaEJyczBEUTBFZmpyL3hXMVJ5NHNFaHpieTdkVkRvWVR0WVZZWlhNazhu?=
 =?utf-8?B?Z295R3FmVTBiSlROVElRdDh6Z0s3aGtaQ2N0NGw0UGRxSXpRa01vcVdSZW85?=
 =?utf-8?B?Nng0RWlRUG44Yzlrb2J5WWhVRmxVY2VCZ2VOWW90MlRTYmxtYUVYT3JESWJM?=
 =?utf-8?B?Zk8xS3ZQUUNnUHkvbW5TdFFLTFNkWnA3ZWxGcHdCZ2RmVEFDbnZ5aExCaVdJ?=
 =?utf-8?B?ZFNHbXBhbGVFZDBwcWdIbjJTN0dlRWljOWZ0eGJSR08rcFgyK1ZjNzdVRG56?=
 =?utf-8?B?NHQrVyticytUZUtqRWgrbVBCY1ovTkhIZFI3OXkxNEJ0RVUzQUNRY1V3Qlk2?=
 =?utf-8?B?T2hGU1VNbXg2dUpXZ3ErWS9oLytjVStBeWpRNUVKMTFuRmpmT1F1dWtuUnVU?=
 =?utf-8?B?a1U3MnVUNVhyZFFPMmVIUU1iOVlSRlAwdTN0R0JveC82K2R1ZFR2U2EwVDNY?=
 =?utf-8?B?aWIvUUlpdjdyYkcrQUt6ZzVCdkJpUzBCTXNxWG9EdTFxK2VlUXFOMUZ5Nm1T?=
 =?utf-8?B?aTBMckNtYVpmRFFBSTQvSXBhanNhYlRhakVZclRDVVdjcW5jOFlDMUVGTUVl?=
 =?utf-8?B?ZGlrS0VSNDYrVmpiK05Gb3VLcWZvTzdjVmtSUkZyWTlOUExFcUVCVEhDSWhv?=
 =?utf-8?B?czZ0WWJmOHpyZ1YrLzF3dXA1ME5QRVp0QWpxbFJHUThuQzNKSWlWWkp3OHZS?=
 =?utf-8?B?dHJGbjdiRUkraEhyUlNrWm1oL1J4Y3dsaTVvWHhwc29xVWtyaGpvMWZVWHZV?=
 =?utf-8?B?VFM2bnVzNVlUR0tydDhJRlhvTEdPdjVEVkNJdDA0cVNoc1ZhZXlwTjdScDZY?=
 =?utf-8?B?cFNNZlh4U2tmK0M1K2ZWVFBUeXZPb0oycEZLd3VBSUpsWXlwaGpwbEtlQ0Uv?=
 =?utf-8?B?QUc5bGxhUXBXY0tOSVh5OEs3T2lxZFV4OC9kRHNZVXQ1VkpCeU1nWnB2UUJP?=
 =?utf-8?B?eDNHVnl0MlY3QmQ2a1pXeTd4WEJpdXRsYytMNXlRcDZSWVJxTnJaQ3Y1Y3NX?=
 =?utf-8?B?K2Rub3lhaDE5dGVJUTNvcWFMdzNMck1nNndkWU9FWExZaFNBelV0dnhiaXpV?=
 =?utf-8?B?SVk3WHNmNVBXU21PdVUxRU9LMERZZXZYUlhUYmM3TStXaTM2dTl2VVNPZmpn?=
 =?utf-8?Q?oC457UMbA6+Rsh/wkwiWSMA151m+Mhly7xRhy?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 731fd28e-0d9b-4694-6fb2-08dee100b5f0
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 17:03:50.3722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D3DBcLS5esvugS8yoJ5N2ANCOJqroRV1XxyZA6eMn1nf1GHqx3u+S0Xh3TVO+GRgnDheaoJpePdlr1eL+3WpMYPfhaBVQAjXRBCGPi0h7cCSVaVI5mD8QXP5O2xrQ4sa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10228
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12406-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:vkoul@kernel.org,m:Gustavo.Pimentel@synopsys.com,m:kees@kernel.org,m:gustavoars@kernel.org,m:kwilczynski@kernel.org,m:kishon@kernel.org,m:bhelgaas@google.com,m:hch@lst.de,m:cassel@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:den@valinux.co.jp,m:imx@lists.linux.dev,m:devverma@amd.com,m:Frank.Li@nxp.com,m:devendra.verma@amd.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[NXP1.onmicrosoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,oss.nxp.com:from_mime,vger.kernel.org:from_smtp,valinux.co.jp:email,nxp.com:email,nxp.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 668B974DE1B

From: Frank Li <Frank.Li@nxp.com>

Move the channel-enable logic into a new helper function,
dw_(edma|hdma)_v0_core_ch_enable(), in preparation for supporting dynamic
link entry additions.

No functional changes.

Tested-by: Koichiro Den <den@valinux.co.jp>
Tested-By: Devendra Verma <devendra.verma@amd.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v4:
- collect Koichiro tag
---
 drivers/dma/dw-edma/dw-edma-v0-core.c | 128 +++++++++++++++++-----------------
 drivers/dma/dw-edma/dw-hdma-v0-core.c |  54 +++++++-------
 2 files changed, 93 insertions(+), 89 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index c341aa5343417..8d38867cd9983 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -318,6 +318,67 @@ static void dw_edma_v0_write_ll_link(struct dw_edma_chan *chan,
 	}
 }
 
+static void dw_edma_v0_core_ch_enable(struct dw_edma_chan *chan)
+{
+	struct dw_edma *dw = chan->dw;
+	unsigned long flags;
+	u32 tmp;
+
+	 /* Enable engine */
+	SET_RW_32(dw, chan->dir, engine_en, BIT(0));
+	if (dw->chip->mf == EDMA_MF_HDMA_COMPAT) {
+		switch (chan->id) {
+		case 0:
+		SET_RW_COMPAT(dw, chan->dir, ch0_pwr_en, BIT(0));
+			break;
+		case 1:
+			SET_RW_COMPAT(dw, chan->dir, ch1_pwr_en, BIT(0));
+			break;
+		case 2:
+			SET_RW_COMPAT(dw, chan->dir, ch2_pwr_en, BIT(0));
+			break;
+		case 3:
+			SET_RW_COMPAT(dw, chan->dir, ch3_pwr_en, BIT(0));
+			break;
+		case 4:
+			SET_RW_COMPAT(dw, chan->dir, ch4_pwr_en, BIT(0));
+			break;
+		case 5:
+			SET_RW_COMPAT(dw, chan->dir, ch5_pwr_en, BIT(0));
+			break;
+		case 6:
+			SET_RW_COMPAT(dw, chan->dir, ch6_pwr_en, BIT(0));
+			break;
+		case 7:
+			SET_RW_COMPAT(dw, chan->dir, ch7_pwr_en, BIT(0));
+			break;
+		}
+	}
+	/* Interrupt unmask - done, abort */
+	raw_spin_lock_irqsave(&dw->lock, flags);
+
+	tmp = GET_RW_32(dw, chan->dir, int_mask);
+	tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
+	tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
+	SET_RW_32(dw, chan->dir, int_mask, tmp);
+	/* Linked list error */
+	tmp = GET_RW_32(dw, chan->dir, linked_list_err_en);
+	tmp |= FIELD_PREP(EDMA_V0_LINKED_LIST_ERR_MASK, BIT(chan->id));
+	SET_RW_32(dw, chan->dir, linked_list_err_en, tmp);
+
+	raw_spin_unlock_irqrestore(&dw->lock, flags);
+
+	/* Channel control */
+	SET_CH_32(dw, chan->dir, chan->id, ch_control1,
+		  (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
+	/* Linked list */
+	/* llp is not aligned on 64bit -> keep 32bit accesses */
+	SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
+		  lower_32_bits(chan->ll_region.paddr));
+	SET_CH_32(dw, chan->dir, chan->id, llp.msb,
+		  upper_32_bits(chan->ll_region.paddr));
+}
+
 static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 {
 	struct dw_edma_burst *child;
@@ -366,74 +427,11 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 {
 	struct dw_edma_chan *chan = chunk->chan;
 	struct dw_edma *dw = chan->dw;
-	unsigned long flags;
-	u32 tmp;
 
 	dw_edma_v0_core_write_chunk(chunk);
 
-	if (first) {
-		/* Enable engine */
-		SET_RW_32(dw, chan->dir, engine_en, BIT(0));
-		if (dw->chip->mf == EDMA_MF_HDMA_COMPAT) {
-			switch (chan->id) {
-			case 0:
-				SET_RW_COMPAT(dw, chan->dir, ch0_pwr_en,
-					      BIT(0));
-				break;
-			case 1:
-				SET_RW_COMPAT(dw, chan->dir, ch1_pwr_en,
-					      BIT(0));
-				break;
-			case 2:
-				SET_RW_COMPAT(dw, chan->dir, ch2_pwr_en,
-					      BIT(0));
-				break;
-			case 3:
-				SET_RW_COMPAT(dw, chan->dir, ch3_pwr_en,
-					      BIT(0));
-				break;
-			case 4:
-				SET_RW_COMPAT(dw, chan->dir, ch4_pwr_en,
-					      BIT(0));
-				break;
-			case 5:
-				SET_RW_COMPAT(dw, chan->dir, ch5_pwr_en,
-					      BIT(0));
-				break;
-			case 6:
-				SET_RW_COMPAT(dw, chan->dir, ch6_pwr_en,
-					      BIT(0));
-				break;
-			case 7:
-				SET_RW_COMPAT(dw, chan->dir, ch7_pwr_en,
-					      BIT(0));
-				break;
-			}
-		}
-		/* Interrupt unmask - done, abort */
-		raw_spin_lock_irqsave(&dw->lock, flags);
-
-		tmp = GET_RW_32(dw, chan->dir, int_mask);
-		tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
-		tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
-		SET_RW_32(dw, chan->dir, int_mask, tmp);
-		/* Linked list error */
-		tmp = GET_RW_32(dw, chan->dir, linked_list_err_en);
-		tmp |= FIELD_PREP(EDMA_V0_LINKED_LIST_ERR_MASK, BIT(chan->id));
-		SET_RW_32(dw, chan->dir, linked_list_err_en, tmp);
-
-		raw_spin_unlock_irqrestore(&dw->lock, flags);
-
-		/* Channel control */
-		SET_CH_32(dw, chan->dir, chan->id, ch_control1,
-			  (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
-		/* Linked list */
-		/* llp is not aligned on 64bit -> keep 32bit accesses */
-		SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
-			  lower_32_bits(chan->ll_region.paddr));
-		SET_CH_32(dw, chan->dir, chan->id, llp.msb,
-			  upper_32_bits(chan->ll_region.paddr));
-	}
+	if (first)
+		dw_edma_v0_core_ch_enable(chan);
 
 	dw_edma_v0_sync_ll_data(chan);
 
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 156b1cc225091..31bbdc6a40642 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -194,6 +194,34 @@ static void dw_hdma_v0_write_ll_link(struct dw_edma_chan *chan,
 	}
 }
 
+static void dw_hdma_v0_core_ch_enable(struct dw_edma_chan *chan)
+{
+	struct dw_edma *dw = chan->dw;
+	u32 tmp;
+
+	/* Enable engine */
+	SET_CH_32(dw, chan->dir, chan->id, ch_en, BIT(0));
+	/* Interrupt unmask - stop, abort */
+	tmp = GET_CH_32(dw, chan->dir, chan->id, int_setup);
+	tmp &= ~(HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
+	/* Interrupt enable - stop, abort */
+	tmp |= HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_LOCAL_ABORT_INT_EN;
+	if (!(dw->chip->flags & DW_EDMA_CHIP_LOCAL))
+		tmp |= HDMA_V0_REMOTE_STOP_INT_EN | HDMA_V0_REMOTE_ABORT_INT_EN;
+	SET_CH_32(dw, chan->dir, chan->id, int_setup, tmp);
+	/* Channel control */
+	SET_CH_32(dw, chan->dir, chan->id, control1, HDMA_V0_LINKLIST_EN);
+	/* Linked list */
+	/* llp is not aligned on 64bit -> keep 32bit accesses */
+	SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
+		  lower_32_bits(chan->ll_region.paddr));
+	SET_CH_32(dw, chan->dir, chan->id, llp.msb,
+		  upper_32_bits(chan->ll_region.paddr));
+	/* Set consumer cycle */
+	SET_CH_32(dw, chan->dir, chan->id, cycle_sync,
+		  HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);
+}
+
 static void dw_hdma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 {
 	struct dw_edma_chan *chan = chunk->chan;
@@ -232,33 +260,11 @@ static void dw_hdma_v0_core_ll_start(struct dw_edma_chunk *chunk, bool first)
 {
 	struct dw_edma_chan *chan = chunk->chan;
 	struct dw_edma *dw = chan->dw;
-	u32 tmp;
 
 	dw_hdma_v0_core_write_chunk(chunk);
 
-	if (first) {
-		/* Enable engine */
-		SET_CH_32(dw, chan->dir, chan->id, ch_en, BIT(0));
-		/* Interrupt unmask - stop, abort */
-		tmp = GET_CH_32(dw, chan->dir, chan->id, int_setup);
-		tmp &= ~(HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
-		/* Interrupt enable - stop, abort */
-		tmp |= HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_LOCAL_ABORT_INT_EN;
-		if (!(dw->chip->flags & DW_EDMA_CHIP_LOCAL))
-			tmp |= HDMA_V0_REMOTE_STOP_INT_EN | HDMA_V0_REMOTE_ABORT_INT_EN;
-		SET_CH_32(dw, chan->dir, chan->id, int_setup, tmp);
-		/* Channel control */
-		SET_CH_32(dw, chan->dir, chan->id, control1, HDMA_V0_LINKLIST_EN);
-		/* Linked list */
-		/* llp is not aligned on 64bit -> keep 32bit accesses */
-		SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
-			  lower_32_bits(chan->ll_region.paddr));
-		SET_CH_32(dw, chan->dir, chan->id, llp.msb,
-			  upper_32_bits(chan->ll_region.paddr));
-		/* Set consumer cycle */
-		SET_CH_32(dw, chan->dir, chan->id, cycle_sync,
-			HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);
-	}
+	if (first)
+		dw_hdma_v0_core_ch_enable(chan);
 
 	dw_hdma_v0_sync_ll_data(chan);
 

-- 
2.43.0


