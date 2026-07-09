Return-Path: <dmaengine+bounces-12240-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Q29HNIO/T2oLnwIAu9opvQ
	(envelope-from <dmaengine+bounces-12240-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 17:34:27 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 64501732F64
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 17:34:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=N0OhyW9C;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12240-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-12240-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 44B8130543C1
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 15:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BC341F7F5;
	Thu,  9 Jul 2026 15:33:52 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013043.outbound.protection.outlook.com [40.107.159.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1253A411671;
	Thu,  9 Jul 2026 15:33:50 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783611232; cv=fail; b=Q31O0nesWBj7qMG2emipA5KD0P6Jtt73YVjzCPtEG3QympzYObSVraMVdDWzCZcUM0XJnS/kB5N85FGVRK2Ih1UruXTAorNMhVWaO0piV9x6eCokFx1/W3prEII0pzSXcSJ+R0nz5X+gjDRo4sjHdoen3Xd9QP2YRfbRCC3ps80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783611232; c=relaxed/simple;
	bh=dUA/HZPMs5/Ql7dQJedTKkC1RTUFlgxfsWKnsGCaDmQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=fyU/O9Km1UARjVAzSlB4Rp7htLDxP2jlY/Lx9OcOBfz6VtPdQAddKweyWs17hj8ZOQBGEmtlx0WMuMXJa5wcuMFWs7PALgZ3eqdZb3s8UKpP5ZKqSLl2lepn5hNvwzaGu6Ly+JwVmbojI625fWVtj8CInYoWZOja9eUzbEmWmUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=N0OhyW9C; arc=fail smtp.client-ip=40.107.159.43
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hxZ878G7lseQSswDVjy8nIGANNU51G7vI8ZY9kgzmqdHbp/ZYK+n9IKfniehXrEYHngJ+zHu3XLmbAr0FRwFzuJ6h05fOAakq7KtCCWM8I/KDcr56Z5bhMVCb8Gf9VyAoaLfJ9UPxuiKHAsv7MDJg6oa8hJIjb4augDvhKx7ebBFm4Tcacgt4f3/ZK25TUc/j2hhfa4HcffBAa4CLjrrWLnzzf4i9E2d9hsZoD+T3hmx+iQ5PX+l4iW3KQQUjTHrDaozTHahWWl/+ttCT6BB5Y7DFwjXVBD8tB3eQ8Ib+1TEl+ZTnrYLJAQ39Fnu17eZrXVFbrVkL105CgCbX9fZ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z1dvpk9EzQP+zr+KnzasNIE+tSe4nwxuB7NxjPdW1P4=;
 b=N/uEZaEjtelBR7RMnpiX1m3wgynShnJxAE3IqyqLxhdQrKeLgOtD7oCnjyebrHolqQjQo5OJHdLxXxbPvFZYc/hm+90G8lytdM04nz6UuvooJ1I4fJmquJYF3kOQfHFgaIGJkcKe8jDyhQAnQHFrfGo6JuZJ46s7aJMaq0+g2lPTl5zAD+cldBYdaBn4Om0nHEmuPvkaAFfdxZO5Di3U53oaZyjsXpBoDpfn1yI5weO8vZHBvFEDBLroudvj8TTB25MNyPUFg7S4K1e6upmZGjzwLzoxAear5RW0eMf9dnwFWlidB5HJrHaK+ZPAC4kd1X1VCisVqhAN7ly2LKfJaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1dvpk9EzQP+zr+KnzasNIE+tSe4nwxuB7NxjPdW1P4=;
 b=N0OhyW9CXv4QGWLsdImSXg4tbOx9ChBZw8CC7hbBMGi5YRZgOC/hHqJ0kLuduWk5zw0iLA9UljFSzzVnd0FK8ODrcjp6PuTRJqQNxwMe9P+7/JbxCyQ7p5PnyDKnsXbP8qbbTcOOC0Ptxm7LrwRsk8Y7dLdstcQUSFLmlwEBzvRcLgvBt+s8GDCNqjdwl0ZTbSfsUgX6xNMONL6OONTVvoKw20dW4+JcWobhN5Pjsf5na1rKfO2moft27dT9pEUez631B5MEkdtDFZVTh7SjuQ6WwL+WL/2pLcRXWYPFOTk3b0cGmYqyx07Hj1iliGKHvEos3rAVa2TCS2z15+8M4w==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM7PR04MB6968.eurprd04.prod.outlook.com (2603:10a6:20b:dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 15:33:48 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Thu, 9 Jul 2026
 15:33:48 +0000
From: Frank.Li@oss.nxp.com
Date: Thu, 09 Jul 2026 11:33:31 -0400
Subject: [PATCH v5 02/10] dmaengine: dw-edma: Add xfer_sz field to struct
 dw_edma_chunk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-edma_ll-v5-2-e199053d4300@nxp.com>
References: <20260709-edma_ll-v5-0-e199053d4300@nxp.com>
In-Reply-To: <20260709-edma_ll-v5-0-e199053d4300@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783611213; l=1765;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=AWFd01V2qiIGFrrfkjJThL7/BfhkdZY8qigjsjdbG8M=;
 b=rB83ZUcbLHX3ldAHMb91hHFcrG4LbkTs+JIyBzZrkx4TedzHuXNlnrUgTwgaG71mGs8sCuDLH
 dAjBcGO8yirBxrgw9s0MXz7VSHiar04E/NEdNOIxzhTTL33jmFpjSMT
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SN6PR2101CA0005.namprd21.prod.outlook.com
 (2603:10b6:805:106::15) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM7PR04MB6968:EE_
X-MS-Office365-Filtering-Correlation-Id: c65dd4cd-a1af-4c74-9778-08deddcf782f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|19092799006|376014|7416014|1800799024|921020|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	xOKJ/mya9KBvUU7mYADOSR0P5Jf6ScI11m6YY3BNh1KfKtjZZ5mzvRKQ86dVcr/5D+1W9bsWFWLNtIS619SrCqYex/n7SdMmvK3HhqMHq2gF3NY0dPGssuv06dmZ4DXPVPlLEpuSqNiOiBN46mXzDOiiMKVp4oM8ealZT32sIzb97JRV7myGd1Wr2QHnvrh4wKj3YoIFwHBEaB3QDnt/8UVDqM4y1VpAycmUazfHhB93W9gOrEKn3WGuYdTiVTVHKh/ft2mpjFXxBBG+W5JJZWJReR++ibYDdiVQRNSdKHbQIF+PDEZV0hO0326eFFchE4IjhMx7KwJu9jFjKZmdlQJjasAq57KqOP7t1cYb2YTD8GGD+vTSZeOdF8auD6PSY6hB/T0up1VMj0psqgCvxVrYJLJi8D9skahywCnIAE3Ys/jIX6Fo7UKioIjcPgdve7JeCeP7CokIEcdttJ3s3iLnTdTlIXY9uzcPqe5mf2fcybZO7YnzfmrSF9XkbB4oH/hC06creOuM4p0LaD3vRBqDkDXuXthItDAlfFszUYsXH2muZyUgmeIxuRAojEhc6cdZIPaIbtbESrDPU5jTPyu1Ugrwm6LZEj1dvQVjvuiudAxF9NngqCE3mHE+Ai4o2kNixXYC+yajMud8IYVqZofU5QQe3MdjrgkzoznZNnDWACIgMpnH+P034He5PSMVQUar+RolWHP/YYU9kLaUaA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(19092799006)(376014)(7416014)(1800799024)(921020)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1NSWStZaGlyTVhzWXdMWlcySnpISmdmeW9mbmdSUDdpeEM1eEI5Q3Ryc05n?=
 =?utf-8?B?VDVXNFA4a0txOEtpOWxrUVQ4SFRmSktuNkt5V1dEdkhiZjQxdjdJcFUwbEVi?=
 =?utf-8?B?OFI3ZWIwdURtQm81QUJ4MER3UmR0b0NKYmg4L25ZRGxGbEhQNGtWNE1KcExq?=
 =?utf-8?B?RjVNbVdxeGZEZVl6THcxM2ljRTlnamUxZzVLNlhTTHJTbHBaNHp6STg1UTRZ?=
 =?utf-8?B?bXFiUjRxc2xqN2FGMUN0ZnkzVFJkWDV3OHRXNTZGYkYzK1V6QnVQTmdLY3Vs?=
 =?utf-8?B?NG5rNG14WWlodkc2TFA2eUhudm5uYlpQb1R0MGdkTElKeUtiZjNGTzFvd0Zt?=
 =?utf-8?B?dVE4QUlWQ1RaY0J2S2Zjdi9FaGtoUUFZRjA0anBJNFgrUHovaExSQlVUUWw2?=
 =?utf-8?B?VnlhOUpHUkFCTVVydjMxbjZKZWhJOC9LL2pHaDlHNHVrek4rdnlveHBJQWl3?=
 =?utf-8?B?alEybUJwa2xNQUxYZUZtazgvak53QVcrVHJpTXpHa01jL1laTW9RV3h2dGRI?=
 =?utf-8?B?ZnFlNExTTXhEY05BRG5NZzQ4dGt5dXUzZGt1KzMxQzZGVHJlWTVRNW91Rnc5?=
 =?utf-8?B?VnJZYURzSi8yd2pWUVdmc2NGN2NGMlFyRnpld3daNnRGVjQvaVFYc25GYmoz?=
 =?utf-8?B?VEgrdDBPaE0zVGtIcUdoKzJVWWNVSC83TG9HVW5nZ0NXV3pmazdJWEtlb3M3?=
 =?utf-8?B?UHRUdHRPOVFmY1JIem1kRnR2MS95OHFtNC9aQmx1eGZwakRSWFp3b1N5eGVS?=
 =?utf-8?B?OTEzZUFsbmp2MW1TeDkyWDBFNmE3VTVlelhSWkpIV1BkZ2ZnMWNXRHhCVENa?=
 =?utf-8?B?bFRMME5mVGdzbGQ2THFuTHBpYlF0NDFGZ3U1RitmU2h1c2psQ2NYTi9ScnBa?=
 =?utf-8?B?ak1tdlhKY1pEMVN3OWdqcmxldkk2cEZwZE0xdm5xbHpNd3Q1dUpmb25GYW5U?=
 =?utf-8?B?Qk54Q0tEOFVlMVkyc04xd0hTYnYydGhsUGFWZkdYMG1lNnVFZ1IxY3ZjZmM4?=
 =?utf-8?B?d1ExY3ZHUFp6bVBneUd6Kyt4T3hJdGhUL3ROQ1dhWFJpTExNVm8vc3V1bVZq?=
 =?utf-8?B?UnBZWlV0czc4YkN0MDRyMnEvY3VmLzhiQ3RkNHRUTHRxc1lrbWRiV3Z6K1FT?=
 =?utf-8?B?b2VGcUMyVXJSN3QrTTkxa3VRY1hTRnpvaFFiVkgvdURBZm1XWWhDV1p4RUtv?=
 =?utf-8?B?Q1V3RmRWbVU3ZmszNzNzZXFHNzd0M0tHczNrSGVUVEJNR1RlWGZTWlAxZU96?=
 =?utf-8?B?VzVXM0liSTBhcDVDV3E0QzIwTkljWktaaGljSS9NVlphSjlaeFprVXl3N1ZN?=
 =?utf-8?B?aytoaElDYjNEM0xJMDZUWDNldjdUNmE0Q3V6T01UZkQzT3lISTEySGI0WlVx?=
 =?utf-8?B?NmVwSi9SSmJKV1V4ZTNuUnNqdElaRnEwWExHcTJrcTVrcENhV2VlL3RFcGl5?=
 =?utf-8?B?MzZEM0MrU1BocWhJYXd4VWVpd2E3RExvODk5QjNmUnZpUmVVeks0WEpxdmdq?=
 =?utf-8?B?VXlTZ0VRTExONklqKzVTdURnOTBFeGJ2YVViNzAzQnV4d2ZuSGhwQlp6L3JT?=
 =?utf-8?B?bTdwbFJJUWpKQVo2dkdsNy8wZjN2dGdtZERkS3dKSE90V3p2RHFoRzZTTEMx?=
 =?utf-8?B?NktUY2wrV3RoSFZIU2NxOEtreGN1VTQvMCt4c3FoU081eVc1WmNRVG45dGMr?=
 =?utf-8?B?QTBpaW9EbktHeVIwNldXaVZqNW1oQXV4NDdIOUpXd2JHeEYyQW9nbFNMbkhl?=
 =?utf-8?B?VXBYdU0rbmtXaGpZWDdzVjhkWUZveVRHMXRhUVlMdWpBUFFWeVBaSDhVbjNu?=
 =?utf-8?B?cHRDa2FBdGhSaE1KNkdiUVBRa3FqblA2RFVVZk1qWkhCUzFmTzR3VFdNWmtM?=
 =?utf-8?B?MzQ1c1hFTEc2Ly9WQk9MRitrTjFoRjNnVW9KWDNQVmxrc3FndENTZGtNU3dr?=
 =?utf-8?B?UlFOU3VoTzgveHZiQTNnYlFialFyN0ZUUDJvbWExd2ppS3hjVytLVE5IZHZm?=
 =?utf-8?B?czdRRWl2dVdlSmJFT0h5T0hvZmVRMndmMUFpc1RSZStxVys2QkJDTDc1STJR?=
 =?utf-8?B?Q1hQTmdzTXgyK2RvR0xxTmZXY3htc2hJSW1QaEN0UVdHRUJxRDBsbHRaZTdY?=
 =?utf-8?B?dktmZkltTitBeloyQUNuaHU2L3pTVVhNVFVWVHJJaUQ2NU01NnMrTG1IZnpB?=
 =?utf-8?B?QTA5TWQrTGpvWDZLSm5zQTBGSFBXczA4dDBJd3MwQzEyLzBjeU91RVBHenFQ?=
 =?utf-8?B?WVhvdVorV3JkdTJVczZzTThNSmk4cERaUHJEODVlVFlCa1VKeGUwUVUxZWtl?=
 =?utf-8?B?NTRxU3dWazFpUVFmNnM3Ly82cGg4RFZ5KzVWeGhaWHpadnA4MDBxNnpxeVVy?=
 =?utf-8?Q?skKMBud4tCD/tBRnPywysGtVREiiWY9fX40Sf?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c65dd4cd-a1af-4c74-9778-08deddcf782f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 15:33:47.9721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xn0kiMrEmNBa0Ux33xIDJHSatomspKur1eUZG/nJSfGdjv2hIzSVOYy3Is6ixpsGc7UMucg2lC1Lbq6f9ejqwbvRSyHpvAkdh0uR0mflZjYlnogzJz26vdDHGRS+2/eo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6968
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12240-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,NXP1.onmicrosoft.com:dkim,oss.nxp.com:from_mime,vger.kernel.org:from_smtp,nxp.com:mid,nxp.com:email,valinux.co.jp:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 64501732F64

From: Frank Li <Frank.Li@nxp.com>

Reusing ll_region.sz as the transfer size is misleading because
ll_region.sz represents the memory size of the EDMA link list, not the
amount of data to be transferred.

Add a new xfer_sz field to explicitly indicate the total transfer size
of a chunk.

Tested-by: Koichiro Den <den@valinux.co.jp>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change in v4
- collect Koichiro tag
---
 drivers/dma/dw-edma/dw-edma-core.c | 4 ++--
 drivers/dma/dw-edma/dw-edma-core.h | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 1fec1b52e3d47..53469c8c8b82e 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -192,7 +192,7 @@ static int dw_edma_start_transfer(struct dw_edma_chan *chan)
 		return 0;
 
 	dw_edma_core_start(dw, child, !desc->xfer_sz);
-	desc->xfer_sz += child->ll_region.sz;
+	desc->xfer_sz += child->xfer_sz;
 	dw_edma_free_burst(child);
 	list_del(&child->list);
 	kfree(child);
@@ -527,7 +527,7 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
 		else if (xfer->type == EDMA_XFER_INTERLEAVED)
 			burst->sz = xfer->xfer.il->sgl[i % fsz].size;
 
-		chunk->ll_region.sz += burst->sz;
+		chunk->xfer_sz += burst->sz;
 		desc->alloc_sz += burst->sz;
 
 		if (dir == DMA_DEV_TO_MEM) {
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 6474cacf71953..db5f45bf048c3 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -57,6 +57,7 @@ struct dw_edma_chunk {
 	u32				bursts_alloc;
 
 	u8				cb;
+	u32				xfer_sz;
 	struct dw_edma_region		ll_region;	/* Linked list */
 };
 

-- 
2.43.0


