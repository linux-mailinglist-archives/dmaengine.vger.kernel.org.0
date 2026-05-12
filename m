Return-Path: <dmaengine+bounces-10374-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HXlBZtZA2r75AEAu9opvQ
	(envelope-from <dmaengine+bounces-10374-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 18:47:23 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DD985525040
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 18:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 80DFE309A815
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 16:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C7D3D25B4;
	Tue, 12 May 2026 16:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DJ7dufQV"
X-Original-To: dmaengine@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012024.outbound.protection.outlook.com [52.101.66.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A453D79FF;
	Tue, 12 May 2026 16:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778604172; cv=fail; b=vBavuxK2f7/aNhKsiC0XlLRFCVCbwdegjWMkRyUDIHJySxWZ3KWuEHYEMd+Zyxf8nBR4V6Fo/hJNlvUe3ib3Kcs285A+DwnbNy7iyaTAsZOU+a9huBIrhYNDpVuEr1OihJnTK22+YSF2xug+TSwBZvA1ulvyS2RlEi7WU67wQ7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778604172; c=relaxed/simple;
	bh=hltOw2Cx/9LlwBERE81ajsgDLN9LjUwIl3Trdv7n/4E=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=jesyTTja6C1ZZzZ/8kbo0/5ADCs3uwGuD8NRRJlJyP0dp58/Glra4AnFlAXH8vcIz2zaPnPXjnMnd1hw0Pu+sO+4UMDxlPb/3tUsaCnmwVFnqkkp60TDoo0NlRZGCVYc6eKdbA3rHJNH2Ixvb0TCM/e63QgNI6fEqhVA1sdBTGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DJ7dufQV; arc=fail smtp.client-ip=52.101.66.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WNDbwBHRht5S39CX0uq5f4igsyuUP39l3Fx89dW6kNmpfsQiGNdAuHPPApfr2kgWJO2lynvdgaIoG1t4N9eHTBRRUo0erPO9l3s6A6wuVR7oGHcxKllwRRv4jJKgfLA4I7vFJDQPFSxxxwZE2S1tud3vmCJov+JU5cNsgKJ78Sgw5IcsreN1AQiej3UfHNb4pBvV/MLURislvWgxWKoro81WFuykKYLYoWc3lyJCn+9wOg37GK9HKg+x8J4OYpxFOhEox4eK0ml4kPEDuX44deZjXfSnQnANVKMuaDmmB+fG6qAkQmqZFZop8cjnJHmduxgnFDyZE0d5OzCOW9dmwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NYI5Zc4jJp+5mbqb3XlY43lqPo1gBAB3vr+K/tK7l50=;
 b=H4dusD1qpeHHAvKuCPiv6/LFh9SWezLPVwGzvWZAFA0xed7ycW8Tp5K+U7TyBQQEW6itT4YXIOJ2yx83Z4y8vSuDFnQXucDef1PrF019NSyq80vKl+c5T0EMfo/Qu5eDyWQxNCgZDqnK4OPS1D5spJwxC9oH/BeQ6aIXiedywcK1+wR/FTVf9T5h0nRExjCO/5gzZBLLzQkAvZp9COjMtSA7ISwNvS6shnPmVnU2AUuHKQCkgIwN2Mmi/J3Z0uMj/tzHiJvCNu/s9qpo+whoVDJ43PVkPQ1J1o+rctHOvq8kIHWvQROLikXc4It+yXdNB0rKcoCv0lR8ziNghbTZKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYI5Zc4jJp+5mbqb3XlY43lqPo1gBAB3vr+K/tK7l50=;
 b=DJ7dufQVv7z4Fhn6948cUXzDwE+ifQtyxEhbgMckgxwGvhnMdKbOnqoCc8oi5Rk3VkzVpE2sGYCeQ92Z/+C+1IcME4J5AIE2fxaMQr0Ut2m7EVf6nMD5yb2BzpaCLmBRNGJC5958E1+himubtoSerLfiytcHoj8lrBrgAVrS65HrdtmYL7mkWUtcSgAK5+ErGefhkUXq3xXxYQAqPEnxUAECqkN99NTYCjUi8m3caQogscty+Xtj1xqCphOlTNzATAyz1ATTOnlajHabDeuu9mZ+8FXa6vzZc+pRgKVPncov1cox8UtMfoFYiqg6FsXSh0VquO1IFhcHjCiJYkf6cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AS8PR04MB8069.eurprd04.prod.outlook.com (2603:10a6:20b:3f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 16:42:47 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 16:42:46 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 12 May 2026 12:42:02 -0400
Subject: [PATCH v5 4/9] dmaengine: dw-edma: Use new
 .device_prep_config_sg() callback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-dma_prep_config-v5-4-26865bf7d935@nxp.com>
References: <20260512-dma_prep_config-v5-0-26865bf7d935@nxp.com>
In-Reply-To: <20260512-dma_prep_config-v5-0-26865bf7d935@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778604135; l=2239;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=hltOw2Cx/9LlwBERE81ajsgDLN9LjUwIl3Trdv7n/4E=;
 b=3+fabr9YksKR48iDfpdhyZ2/LTF7VuWhoR9cz5R+eh2vJfTe30DBwdx3gK2CVzUzBPXy5kZXs
 FM8/mrC+gQAAx8/54lEPFLoayuC3jE3PF0AeW2Ulzcl72kRity0+4zo
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0213.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::8) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AS8PR04MB8069:EE_
X-MS-Office365-Filtering-Correlation-Id: 22f4c76c-de7c-4b06-d7d4-08deb0457f30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|19092799006|7416014|1800799024|366016|11062099010|56012099003|18002099003|22082099003|7136999003|921020|38350700014|11063799003;
X-Microsoft-Antispam-Message-Info:
	hpT8x4WOllKEdq1tgZj/iCsiuscULYajqm5ZEFdBY2ySND4UvZogHAbLVns+oz4SEp94sSHL5MRIp7Viy1pgFx2XUNW8+O4/kLoqbjjaRwhmNaMFaiXXU9vJNwa+NkreUzbc1COea3qk/jX8rwO2cuuQJbFcvDO2CxFPl6PpWx777lI0Q9XRtUYKCQ9PX+eedlAlMVZ5Be5dx+TNGYqx6U0AlvEbIgvE3n8ErVIZiVETqQAjTvz/wAhjGcNJx1SqgmUiTkXKsqJ70DQBrGmcgksd/Rbu3OL6p0vcT0MLTgWdRQvro2exb4t9Oa1akInIo7EGhxVB/wl3C2KHSz2ANNG4kD95v4M/sL0oabGQX+eNri9y6lnOiQgj0h1a3AUgqbtUyciI+xZvLH22wpxf/bplB8xJcdJiaf6+IL9UmcruiOqJmJcJzrtHHy9IfQgBqf+dkGMOsa84vgIoJfA17O7GizzrnAkzqWcQax6L14q2NDG78dP9C5Ua0x2ckh0iDAjsdZ65HOUyvVgtqRQNnnmNTaGepMQPBzt0pA+TxlPtx8tATAVL9kPWJ8QZrRp3/rHF680LInpSGJ4C0swprqIvoFuWXuaucxuutBx3Kgi+SwfuQNpfh+IN9v4Es1i2MdfTuI3XtwXj+QeRuYjpKxE7CEiiKsTFMGF67IfOIGgIvKv4gTqnsifKkkZuiKPx0324/uRMjNyPb7E+VBMhacSw+PUQ/pZ8YHmSex80aYhzmFnc16+rBM2fvmg7lcE2MzSW/nNRikA3wc8FROQoNg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(19092799006)(7416014)(1800799024)(366016)(11062099010)(56012099003)(18002099003)(22082099003)(7136999003)(921020)(38350700014)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXpTbG5BYVJGRVNKMVJhL1paWC8raytSdHJLMnlJNnIvU3IzSG1hT2RQSmhy?=
 =?utf-8?B?UW16Y2FrS0FJb3czbVpxZ2s4UW4vOTJKL1h5cUY0ckZidmtDTW40WmlZU1da?=
 =?utf-8?B?OEVXQ2g5N0taSkRMWjFuMy9HcG5Lb2R3RkcxakkxSU9ma1ZDYXdpRWx3UW5z?=
 =?utf-8?B?SW9wbitKY05pYzYxMnRHZGFwUzNEc3FzSGt2RUF3dzdYa1l2bG12TEJDdnRP?=
 =?utf-8?B?Z2JZQjFCemFVWTZtOXl2QjJFeFJtYnFMUTVka0RiNERtV21KQm4xamZGMHVl?=
 =?utf-8?B?eXh6V2hQZ1BaaXdqbFVBWkxsOVltUmFPL1NFUWt3YnQ2TDk1cTlqNkxTMVAv?=
 =?utf-8?B?VFFGUnE4V240WWx1UXBlNFZZT3lxUll5OERIbHZJS2tyYlFsNmE3ZnFGcUN4?=
 =?utf-8?B?VnVBdlQyb2JhSWxUbXI0L2xMdjMwUlk3Z0M0M2taNHE5enNPQkNoWmNsNU0z?=
 =?utf-8?B?NFV4cVBQcHB5N01XV0xmY0llMEJNOS80RGFzOWNwMDUvQkJGWEw2bHlvZEJZ?=
 =?utf-8?B?NEI2Zk8yUHdKSXlyT1hxZnR6Zmx4YWhqeVEzNmtMd3ZlM1NBQ2xaUjI3M1pq?=
 =?utf-8?B?M2FOYzc5Sk9rOFYwM3lEV0p1aklybEM3aWRvaG5iNUVxRVBQMGxrcHMzSXo3?=
 =?utf-8?B?bHpXcEdOdS80THVudDJDL0Z0M20yaEFMZUoyaFljRjBadDlrdWVkUXh1emZH?=
 =?utf-8?B?NFV0TTBoODNjYk5HWjVTeEpTVldna05lM1hkUlUwYVEzYktTY05jczR1RE1E?=
 =?utf-8?B?Q2JlYUlrdGl5Nnl5WXBhU0oyY3Nha2l5VTFUaXpZR3IzQWhwNDRiRTRXT2VU?=
 =?utf-8?B?cDlya21vL05kWnU1R1NhZXEyK1o5dWJRM1EzUE50Z01pQ3NCeTZ2Ly9VMGFN?=
 =?utf-8?B?V21BaTlzdHBiQjZVRDExK3kzdmRJQU9kSTEzWFo3UVhpZkp1ZkVSZTNsNTNC?=
 =?utf-8?B?K2FpdUpNSVp0elY0NzFDc0h2S2tUWjJabmR3Mm5HVG03Vi9jMkx1ckNoWHdp?=
 =?utf-8?B?QkhWUXVGSkUrMUduM01CZmV5K2lCajRGNFNBeFdCVzdlMUg3c3ZubGFzWnhp?=
 =?utf-8?B?NTd5bzhoUUd6Zm8yRmdWbGREbmhjV3RpQnRVZHBvWWdKVHBUOVVJbTRLd3Jr?=
 =?utf-8?B?ekw0V1NYdFlPME5sTWs5a2tDcGdjQS9BaTIvTnZWKzVxUTlScjk0NFF3Ym5F?=
 =?utf-8?B?d2J5QVg3TE5DNzhGZ1pXTEgzMFBEdGpyeHAzN3E3T2pTRXF2MHNWY1U3c3pk?=
 =?utf-8?B?UHJhYUtmZTNhUFdGUFByTUdLOGgrdmo3bWtwMFBNVGRVNmdZSEFDTVFpY0Y2?=
 =?utf-8?B?OFRtMlhZQklTZ0lUTnRESFZEeFJoYWh3NEI5cEtYeFRIM0gvM0FyWlEvZHVo?=
 =?utf-8?B?ZTdPSndxTkl5SzMvbmhhbHlST21ZcmM0MDJCT3NKZlVQbmwvOU5Kalh1SStk?=
 =?utf-8?B?cDVTWVF6YnFUQUxINjI1MjBjY25Lb1dmR2NNWkJndlNYTXhzdWlaOStLK3Ew?=
 =?utf-8?B?cHc3L1Z3ZGE0aFY5MU9HeHpVTEFBQ0hvTEIxYU02QTdIaVprUVQ4Mk5MWldo?=
 =?utf-8?B?TFN5U3lrYlJRSDlWc3J1a244bDMwNDBjN2lTcjEzMjAzaFRPU0N5emoxNTNQ?=
 =?utf-8?B?RzdDYy9yUWpObE00WGNHMXdMbUhJRXNBRkczeWwwcjZNRkFqUE1zU0dhZG1O?=
 =?utf-8?B?dmt2ZktNZ2UrSTZxcXhZTVM2NmMxUzMxanZMeUxJSGVQdUZTZ1c5KzhBbWo0?=
 =?utf-8?B?NUNWNEpBMVhFcC9SNFEwTjFQRVEvK28xSG4rYnVhaCtrY2dVWmVocDZCcm9W?=
 =?utf-8?B?TE0zRTJSdnFEUFZka3JTK2dLSzlhY05ZdDBIZGplU28ySDdCWjFQbFRsNmp6?=
 =?utf-8?B?MVFBWEN6UjM5cVBZSm5wVGtFeUdVZzBNTG03RFZDVTBHQ3FpUm5CQU9Ka2ZL?=
 =?utf-8?B?NjZoNU9sV1VnVy85TnhYT0hFb0RFclNDd3NTRWRlSHNvdXJiblRIMTVBeUhE?=
 =?utf-8?B?eEtzWVloeklkcUZDSS9jZWFVYU9TUlVUcUZ3OWtrVTF4VnV4ejZVYmo5UFdY?=
 =?utf-8?B?VisyMDFrK2VXNFlYS2pjbTFEaU1HNXFnTkR3cTBoRGREV0hHWkNDaXNaWVJv?=
 =?utf-8?B?WFQ5M01Oa28wak1ib2lIYVhhaGdpSW9sRFRyY1ZYSkR0YWZib0ZsWGJiYkZH?=
 =?utf-8?B?MDNsWnJ1Szc1cHIrTFE4TGloMzJEVkVyalNnbVVlRE5xTkFBMk8xbEtBUm12?=
 =?utf-8?B?WUx4Y2kwaTljMGwxMUlpZmJHMFhmQWNyL1IzODU0a0xQZnVSWmd4a3dBK1lm?=
 =?utf-8?B?a1ZFdkx0aW1UdGJodjVsWExjQ01IM3dvTzgvLytsZmsrQW9BUllxdz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f4c76c-de7c-4b06-d7d4-08deb0457f30
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 16:42:46.7649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4t7oexY8fnHfhqllX2J8EM7VcoiNm4fHKq7LzcunDuJf21rvlacnXmtpxNgV94uAGRzkf8Eaqx6KoJunxnW+tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8069
X-Rspamd-Queue-Id: DD985525040
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10374-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:mid,nxp.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Use the new .device_prep_config_sg() callback to combine configuration and
descriptor preparation.

No functional changes.

Tested-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v4
- drop context in callback.
change in v3
- add Damien Le Moal review tag
---
 drivers/dma/dw-edma/dw-edma-core.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index c2feb3adc79fa94b016913443305b9fae9deef12..f7f58b0010e26b529ffb7382d5b166a703587c71 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -577,10 +577,11 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 }
 
 static struct dma_async_tx_descriptor *
-dw_edma_device_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
-			     unsigned int len,
-			     enum dma_transfer_direction direction,
-			     unsigned long flags, void *context)
+dw_edma_device_prep_config_sg(struct dma_chan *dchan, struct scatterlist *sgl,
+			      unsigned int len,
+			      enum dma_transfer_direction direction,
+			      unsigned long flags,
+			      struct dma_slave_config *config)
 {
 	struct dw_edma_transfer xfer;
 
@@ -591,6 +592,9 @@ dw_edma_device_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
 	xfer.flags = flags;
 	xfer.type = EDMA_XFER_SCATTER_GATHER;
 
+	if (config)
+		dw_edma_device_config(dchan, config);
+
 	return dw_edma_device_transfer(&xfer);
 }
 
@@ -970,7 +974,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 	dma->device_terminate_all = dw_edma_device_terminate_all;
 	dma->device_issue_pending = dw_edma_device_issue_pending;
 	dma->device_tx_status = dw_edma_device_tx_status;
-	dma->device_prep_slave_sg = dw_edma_device_prep_slave_sg;
+	dma->device_prep_config_sg = dw_edma_device_prep_config_sg;
 	dma->device_prep_dma_cyclic = dw_edma_device_prep_dma_cyclic;
 	dma->device_prep_interleaved_dma = dw_edma_device_prep_interleaved_dma;
 

-- 
2.43.0


