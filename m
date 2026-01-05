Return-Path: <dmaengine+bounces-8037-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3214ECF5E2E
	for <lists+dmaengine@lfdr.de>; Mon, 05 Jan 2026 23:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C95F930DC14E
	for <lists+dmaengine@lfdr.de>; Mon,  5 Jan 2026 22:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7090529D29C;
	Mon,  5 Jan 2026 22:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FqG2PhnG"
X-Original-To: dmaengine@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012010.outbound.protection.outlook.com [52.101.66.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFD02D8771;
	Mon,  5 Jan 2026 22:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767653257; cv=fail; b=mbOWOkZcEm6h3921ZZzR/GRfPWUef/ADwsK525SN2239CTTjftAlVwEOhJVVccf2E/RDo6MqE1SmdhTh5PdV6i6urROD0+i6WpuPiUz76b0bG25V4Pa4vZLdYHbMP3uyBBn/HCfpXqtg4N0LneCl3mKtkiPcOoppvqmTzI8rHhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767653257; c=relaxed/simple;
	bh=THRhOrJebwYHSrLzHvW6aplke/njcscVbZWhunSBdVc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=pk+P0MwKhzI7G+bSZMUZsGwxjXTfKCuokDN5JMOkkUu6/0CQZ0loGCFBivcCZh+1OChZfSTW6iTRgBEWP9n9aiabBiESu1qYDPp+9oAwMA5ZRaE6u3f+l0YzgzDW0VvZGoPZO8rmFoQFS6iGlCjAskLESqc+K/mAsCaCTN5TzG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FqG2PhnG; arc=fail smtp.client-ip=52.101.66.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=igTo9WeVM9KubfB+pZ7NmSdJ6MKN2OBh1aKXa5h38lHNwIOOY22vx2/AdrlA6S2mqtm091yNRK40zeTOLJG1W9dKpQYeFrKVa/JP1JYbnYnuYNTiFnMuqtY0KzySkcx+nkpszYeDkDh/3GVzS5iJFlSu8Eeyf5NZ+Ab+rYdeDl/S/sxWNXaVzqYxxWaYXwd3QJAGRQVmUUqIQy4635gSic2ygvKr4XWEhPKTeJidupOf6nplh4GVDDjXpqdxBJaOWtl38Re1DDpLrGO7UeHFtdt8Ydz/7Amd4PunXNjMZUoopy5gR1TyZRNsinGE+sWEEH2Gsj9WInBFWW3ZHK5HOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1vgw36m+gbTDl6gUiBeTihu6+nCkaeii4/Dble4OKo=;
 b=rtwsvTSwQ/c2m0xrkzNXRSGJ+oncVVpPlUYm+Y3CPDZlj79fnuraLIEnl4F75e6zShwdE/zsg5Yg+j9YEZ9gJrP0XaQTayiyAJ/OpeCFHAQo7Mo19FhFNsZ1wAYP28yY+SN6GflPDywyPwfrV5fWS1mDL0wjLqUob0UsigTQXzaW5aBKjtEvkzdl1Y6f9sXqvscgUaBP9GUX/9RDSXBWaQYUX3CImLe/MB41BeowPnJqpjElcz3f4SO3UHjeHbjmzPlmXfmKvukcwfq0fGAP2iaoZJYwrsVAgQyDgO9VH5mu+HT4NCtwogYtyLdNIQlEeHyUyAV4I/eKWaPONNzFgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1vgw36m+gbTDl6gUiBeTihu6+nCkaeii4/Dble4OKo=;
 b=FqG2PhnG9pz4sFRfGCVslnBEVNlRU+bjZLNsd8FTPN4GPiNyjFspn6681sxb3W1X6pU9n6k4y915qqbK0M79ey4rCB06otmK4MyNTl6JVGRDtKUJPPZjdorlLuk7jI6h7wcgu7kbhqjlaOCnWJXe+cCTwPdwLviTnn0vmpxuvWMcv+KCrfBIaR4ea2sAPPIyq8sQDESMxYCh7HR3YALzP4l/UoU7wAo5JTjLkMHJb1UTA8qxJ1XQDVK4nuAFrZJ6NmXjXaBzQCH9HtQD6GI0EHl8IhM1VohdQ+eMKmiTw8JhPaVnNVkz8lmrUSrHwrmy0UPp30J0Ai/7oMK/u79Lbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by DB9PR04MB8185.eurprd04.prod.outlook.com (2603:10a6:10:240::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 22:47:33 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 22:47:32 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 05 Jan 2026 17:46:53 -0500
Subject: [PATCH v3 3/9] PCI: endpoint: pci-epf-test: Use
 dmaenigne_prep_config_single() to simplify code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-dma_prep_config-v3-3-a8480362fd42@nxp.com>
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
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>, 
 Damien Le Moal <dlemoal@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767653229; l=1242;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=THRhOrJebwYHSrLzHvW6aplke/njcscVbZWhunSBdVc=;
 b=2SIgRwMFNBmnVrtHneAo6N5xItz8nijZ/A1mOSa3msgYlD7TrnMUHdqCGUNdCFXOgMuAWcOQe
 YiBPSSm/7vcAy9bjtVT3m8IrrWAre22NMZXsbaHbT0OQ7z2forMcLoK
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
X-MS-Office365-Filtering-Correlation-Id: d4ae781e-94df-4208-9b0f-08de4cac69e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YzgxelJ0Uk9KS3lhRlRCK3RDbmpqNzRhVGxaOWUyUGs1MVI3T040WktkcnBl?=
 =?utf-8?B?VG9TMEVkQ21YTnI2cTVuTFQ0QlRhRmN3ZDRZU2NZSlNyMjBMODdNcjNTbUFu?=
 =?utf-8?B?cjBFdFRzR3hIODlLWDNOckhJWm1WRmcwOVVTbXRrUGtZajY5a0x3bmQ5SHBk?=
 =?utf-8?B?V0JwcXE5UW1scnA1ZTc5QjIrUG9RMFM1UHRpc1lrS3dTaUR6ZnNacG9rVXFl?=
 =?utf-8?B?T08xK3IvV21pd2dOWFNialVWWGVyQ0k5UzFtOGtSb2FRcUMwS0prOVRHeHFO?=
 =?utf-8?B?ZnZvVVNDYkY2azdYL0t6ODRkekhkUUtmT0N4TWIvM09tcWlWT0NoTTJtRE5U?=
 =?utf-8?B?dm9zMlRicEp3cHhhZWFUNUNaODRtS2piNk5pdGxxM1U4dkorMXk2aGZBS3ZT?=
 =?utf-8?B?dENxZWJjVjU5MVhHcHBBenpuaGpxUk5BWVJPb2E2WXZuVTQvTFRYYWVscGlB?=
 =?utf-8?B?WDBIb0JzWUJMTklvV283TjhhcjR3VElsRXM4ZXdKNmx2N1lBbHEzOE1BM2di?=
 =?utf-8?B?TUwxOUEwRDgzcEd4cVNGZkM1blFXOFRmbFZqcllvNFNVTjRweXYrMkU5MG9l?=
 =?utf-8?B?WDBhNlhFNFowRlFleStlb0RMNXdWUkZvQjNkZkJZaTYyM3Znd1FaTEtySXFW?=
 =?utf-8?B?dlZ1dHB4OEZMajBoMkhrYzJzZzMzMnBtbXpiWnlTTUU2bFpQMVlrZmZqRHli?=
 =?utf-8?B?NDNTTkRmN1dZQzNlUCtCcUZNelgvUTlZWElweU45RVE2RlB0blJvQ2g2WkdC?=
 =?utf-8?B?MmFka2xBVEdwWjNleWkyS0Q4UVEzaW1VQ1h6VjJUTCtMbkVFS3JSK1RSb0Np?=
 =?utf-8?B?TE1NbDhqL0FEaXNMOExJVzMwS1lUQWZneXhFK1hnSTlRN0hKVWd4TXJNMnRS?=
 =?utf-8?B?czNINy9MYUZON1NVWGx5VEwzaEVES0RkQWNWVE9zNWtoU3U1RHpKTm9Ga1Fr?=
 =?utf-8?B?TzFiWG15Rnd1QUpLUFE5Q0JiQlNnMHBTeituU1o4UWNaZ2hFNFl2VzVCWElE?=
 =?utf-8?B?QzM1QUtBTUIxTDQ5RHV2NjJEcDJRa09jSllMbUgySkhTQmdsd0pXaWNLSjVy?=
 =?utf-8?B?aTNkdXRLOG9PYkVOdXpHY0ZGaEpxZThCZ1hLRmFUWU1DNVZpam1udFB0WUl6?=
 =?utf-8?B?RWp6dWhVZGhMaVhmRWl4WWJFZWh4aDY5Sm9zQVlBQXB2VSszM09oZkFhdVI0?=
 =?utf-8?B?aEJTdnJ5VHJqNjBqY3BPRnY3Ym53OGRnL09EZHQ0bFRlUFQyYUkyejRnL1I2?=
 =?utf-8?B?L3UrVk9iUUMyZjdLczN5cFp6L25lYlZCUHhwa1lKNE9ybE5NWGptQTc2U3JY?=
 =?utf-8?B?anh2cFRVaHkyYnB1N3l4RWRjOVlYUW5YaUxiR1pRenBWYXExcXhwNWFoOU9i?=
 =?utf-8?B?ZjQ3a254alI1eitQNnpWTW1nT2FWcmVsWExZWUpiY2t4RzQ1L0tGWjM4YlU2?=
 =?utf-8?B?S3o3dnAxaEovSVE5cTNmSUt4ZUkzcEIwUVpnOEo3ZFhVdDZyU3VQRW5HS3pt?=
 =?utf-8?B?eDlrSTE3R1dSYVBiOWo5SXpNVmllUnI1eTN0Z1ozc3M0bjNlcENZaVJ2TFF2?=
 =?utf-8?B?c0xwdGljRllJMkR3TFY4SHdhcEFYc3pRM2l0Kzg2R3puamRSSnRSLzZYNFJi?=
 =?utf-8?B?WmVzYVI0dGt0MnN1aG1kbit0VVQ0L1ZiSHhvRnk2UUUwaE5rRmw3ZWxWWUpM?=
 =?utf-8?B?NzVLZG4vUmJSMzNYMnJNbmY0R2xkU3RXTWdoUWtndHN1cVNCcXJSZzhMVmVo?=
 =?utf-8?B?a0trYTlPOFlqMm1MTitIV0dOTEswdW5ML1U0KzJkbjl3OTZ1TWM0T1RyZGM2?=
 =?utf-8?B?YVdzRGFKUGJ4QU1JbGhjeDgwdjhCYXlvUW5oRnJPeU1ocHBjQXBWNldGRW0y?=
 =?utf-8?B?Uks2N1hMUk0vQjIveVdKcHhPMDREaFVra2RCTFMrRjdseG5MazNheUNDb3c1?=
 =?utf-8?B?bkd3Z0RkM25rdjZtaWkrTXROQURGaUVFTkIwR1Y3ODNMOXV0ZWlDeXZGM2RO?=
 =?utf-8?B?Vkd3KzFsR3c5WVdtYkVYK1FWbis5ajYwUG9pQ1ZtQ1VVMnVrbzRGZi95TmRL?=
 =?utf-8?B?dnpWNVpKWHF5SHVoSnZqM2dtSXJXVGxUVmNyUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHRDdHJBRGdub3RJYngwWGNYZDY1MktSSDRIKzBuaDJDYjNxUkNyY21WdGFX?=
 =?utf-8?B?TmhrOXRtSGloTC9kZGJQTEtHbXpaVDAxNkw4TXZxWmFQOXNSUW9CVVRscVRZ?=
 =?utf-8?B?OElkVksyMzVOdURGT0NSUTZLZ0g4TUtrMmJXNTFxUXhKWHVodm1wdFovaUFz?=
 =?utf-8?B?b0U5OXoyZ1ZBNW13ZWMzOVBFMnM2RWNUcTI1UzFGWUExSndQbURRdHB6NnE4?=
 =?utf-8?B?ZlR1TW85RSs2K25PTEM3cmR5NmduWVpQUUJtYUFsWFB1MktFVlMwY01KZkgz?=
 =?utf-8?B?aDI5czhBYWtTNlQ2OUJYckdvTTJBR1BaZFBGeFZhb3hvWGlLcW5Ddm5xaElH?=
 =?utf-8?B?NTRaK2pnRVJpYktTZi8vb0tWM0Y0NEpGSVJUc0ZRTXkzbXJ5YnFCczlxVHRZ?=
 =?utf-8?B?dXRWR2dLbks4YVIyS0d0cm53c3RFMFUxdjJLdjhPQlZmd09ySlNuRFZPTWFI?=
 =?utf-8?B?dXlzRVQwNEcvRXhxOTRERmREMjhRQTVJZHZEZUszc3R0Z24zUGdEWFJOc1R2?=
 =?utf-8?B?YzRCVVZQMi9vcTR5WGJDZWtIcWhScGtNaG44TlkzNnFKZlNwV1Z6ZURUeDlq?=
 =?utf-8?B?dFdXSWN3UDlUVnpEWmJadmhURGo0Z2VLS3RSOFFRQjBxTXZwSVJlSnpNRHUz?=
 =?utf-8?B?T2d1U2d3TlFLVGY1YmErNTFZVFhxU0FCRmFkVVhxTWtuc2wzZ1NJUzFVSDNu?=
 =?utf-8?B?Y2d3d1BDYUxRWDJmTHhzTVJFaXM0YURXQVA3dWRHR2UzL3pFZ2dkZjQva0x0?=
 =?utf-8?B?N3QyNUVwNWN6QWVEcm5ad0dzRlVYSG1iOGlyTmpPaHNOdkFXZC9MVUJVTkg3?=
 =?utf-8?B?cmFQSHBPNmJMazYwQ2RFWnV4aXBFcVRkR2xndEkwN3lZa1BNRjROdVBjeHNB?=
 =?utf-8?B?UWM2bUVoUm16MFN4MXZ6K2RQY2VONW9ucCtMaFRLREhKaXNGV0VNZEVYZ1Na?=
 =?utf-8?B?TzNIK2huaVhMUk1WaTEzS0tFUFdXcGFEVTFXM0d3OWtIZVE1QWFMRkkxQVBD?=
 =?utf-8?B?SzIwT25pS0E2azFNR0Rxam9iZGhtT0NWWDhyeXZRL2U4aEQ5UTBPRjNERjVy?=
 =?utf-8?B?ZHF0Vk53c3ZyNVlJU0tjLy92TlhOVnErMTNCTE16dDdmakE0dmFPWXZjUEdp?=
 =?utf-8?B?RGlJUWVlMldnUnl2cm5yYjUrWWlwaFVDMlR2cGJnSHZjT0xoWURXelVGL1px?=
 =?utf-8?B?dUlLVlB0RE9obE1MM0xTWDdBd20rS1lodXlnWTBSUnV2aEVlREp5QWt2aWF0?=
 =?utf-8?B?SGMvUVRVSDJ4WmlrVWNEdmg5L05VR3Z1d05NTnk0amYvY2VtQ3h2MW5YWVZa?=
 =?utf-8?B?Q0lUbWFSK3lWMWVmSnRzcUVFcGl3YmhBbyswMUdQMktnWHpLaGVTcC9sVmVL?=
 =?utf-8?B?TEVtNitLTGUzakwveDdLdXZHRThIRFQ0R2JoajRNcTlYK3F0MmdWZ3N0cjRN?=
 =?utf-8?B?TWVsYlNHZ0NRZXFxcjlLTTFZdlp3LzQ4ckxad3ZaRnVPaGJZTE8rZi9MZlE2?=
 =?utf-8?B?QnNGMVhoeVQ0RnZ5bzYwRytYTDRyNmpVZVE1OFI4N3FSaHdXRG9MczJjeE5G?=
 =?utf-8?B?ME9LQ3ZDNW1xbFBRN2N0clU2QmFBQ29ZOTM5bFJqNVFKTnd6cEg2UlRwQzNP?=
 =?utf-8?B?TXNXV0pkNGl5UzF6bFBPWDNVRnZtamw1VEQ2dmNxMk8yRUgxbWVqZnRvcmo5?=
 =?utf-8?B?K29uTzBvQVhucGJBZ1U2ZWtSNWN3dlBrbHIrNlJvMm9hVGY5ZnFoQWJhaWM4?=
 =?utf-8?B?MXJSMzh0RE5iUGpEUXJUNXBPcjVVQVpCR1RKV1FLTDJTNUw0NTI3RnV2dnpJ?=
 =?utf-8?B?WVRhRjNtdWplc2JGS2cycElUSk1lWFVPdWpGbmpiYmRQc3hTQUtQZTh0NFpp?=
 =?utf-8?B?dlF4TW0rWmJCRTBuZzJITTZuTmxkWXNoRW9GZHdEQUtYMDdCNlIyb2FzOEMx?=
 =?utf-8?B?UnNRQ1kzenFVby8yb1RWVmdjSEI4bXoxT3RXOVlHM05DaVpRTU5LMklGR29C?=
 =?utf-8?B?MllDaU5nck9ubEpGVVlSREhnczFWM0Q5VGlYMHJNODhkY200eGZRWE9CenEx?=
 =?utf-8?B?RlN3UlVmSDBKbzJpZzlXVWVJeWlacmFQY2QzTlk2bDZKRWlTL2NDYUF2U2ZN?=
 =?utf-8?B?QlNDOXVpZ2VpYUUvZ2hQMGVabC9Nd3NITTNKSkxKK0tVazVzVzV0RXo3dCts?=
 =?utf-8?B?ZFZEMGFsWEc2elY5QUloMXNoTG96Z2RTM3JXdTVyRG1rRDYrTUlqckM4U1Nr?=
 =?utf-8?B?WjlkWE5WYWJyazdEV0pRaldhT1VRWWU5TmZiZHdCVFB3Y0g1RGZGRmhnZVli?=
 =?utf-8?B?dVcyT3RzNjVEV1hZVzM1UHRXSFFiVldib3N3Z24vbzczaGl6YnFuUT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4ae781e-94df-4208-9b0f-08de4cac69e4
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 22:47:32.9005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mjvQDRW1IfVdO2hbNle6W2u/ojHlBcixPQT5H6Ko5khqpsuSVFp2nTZz2MdJkQOdO44vmmqiYwrkSwpBC7w+aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8185

Use dmaenigne_prep_config_single() to simplify code.

No functional change.

Tested-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v3
- add Damien Le Moal review tag
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index debd235253c5ba54eb8f06d13261c407ee3768ec..95b046c678da7ca4a0d9616acdd544251dc05aac 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -162,12 +162,8 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
 		else
 			sconf.src_addr = dma_remote;
 
-		if (dmaengine_slave_config(chan, &sconf)) {
-			dev_err(dev, "DMA slave config fail\n");
-			return -EIO;
-		}
-		tx = dmaengine_prep_slave_single(chan, dma_local, len, dir,
-						 flags);
+		tx = dmaengine_prep_config_single(chan, dma_local, len,
+						  dir, flags, &sconf);
 	} else {
 		tx = dmaengine_prep_dma_memcpy(chan, dma_dst, dma_src, len,
 					       flags);

-- 
2.34.1


