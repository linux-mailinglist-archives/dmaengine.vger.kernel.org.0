Return-Path: <dmaengine+bounces-10683-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FUWNKIwD2pSHgYAu9opvQ
	(envelope-from <dmaengine+bounces-10683-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 18:19:46 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 336EB5A91D9
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 18:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A3E433AB4A8
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 15:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A2837204A;
	Thu, 21 May 2026 15:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="epqnaVjA"
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011064.outbound.protection.outlook.com [52.101.70.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10968371D0E;
	Thu, 21 May 2026 15:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779377609; cv=fail; b=mfgCysH5Cr8LHUh0wPccd64rEbIP5wkBRAbXb0uYYTY1DPKahSgxxOkx10TlV5CcpBHPezq8NfWi/cccJBYUvIjwUfAPDx2/xf8q1VQHkeG7ifOVLXxn4VPW3DsL/8z+/YxvHe+oRnxqUTGrDvylBsfdgXlav1L6Nf8pcvr+apY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779377609; c=relaxed/simple;
	bh=iIX53NjUCPF1mDIkG5DU7PMIW0Upf2qtAbp2L7cxMh4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=t1ZAPmukjmLDz4evMHgWUcGMY7q6t9FDZz7b/YsgUE1iHXdIk514yYRno75YFtKKsd2Yg6RzhdD5JT1FxlCfk1qYUK0fSSdsNp7Xi35wVWNZke7HpzlhV/ZAL5WSYxwPl/9/bOHgbXz9DRJTYsfn0Zkb8WczDg7BOnDv1O5r4wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=epqnaVjA; arc=fail smtp.client-ip=52.101.70.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HEeo2JMMiKgSRjWViAbvcvD/RgX7zNy9zbYsIMxTx2J4xQKMTUaiHMgBZrVBQwGrt6H91uFI9SF7a7JDohy5gHINTw6CtDRMRww8hHDIImWvrm/ntdzO7p0YIpMW5GrWOw+zaBo5ht52U+5pjtG6zJ+BKR6YHktuBZBDMyUgEfyzneuLGfsVHXWQszOer9xe7qKMykbTp6+wy+2eRXNUJVHw1XK6fhiAY2rwOAKfQZ1asYhF1l2FEZO5WjYtd0n5qgaQBxGzFfMvaTe9qitlH5f6W6IvVCIFu2rYI9rimAJtbRwgGGXWa66BS5uKxbjl4QLgCjidtPm14GnwfQf/uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37bcc8TfgjTqfML06R1EwTBVyj48QWZJKxW9EQbmuWU=;
 b=HRPBnSNUfAUbvCaoRSS4dtzjGAkiTG/8sXjXXdWgvTkSVUYP+fx14ZXSEbn00sCC+h6GM803uSH8UUB/R2M7t8XI+I7dgJaFGNgThZPCmnQTbfhkzDo+++zJA2zrTlBIg3mw0raf7gdQ5+UauYcB1VDLLNf3SbxI7KFvl+INa2faZ1VQvA2cD8eFy2rgcDmSkOv0AkM+YoFIv9nyMs3z8Xdeaq8EPLX2z479OugByrJAobxp/E30Cvamdo0mS+cUkizshycISh9hvf6xGTFmSvB7LuDcgbYERgu/hg2VtVDUX+9gvHalTBXT0bokkVWxUNTymxgwJlZ6JDrQtGfZGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37bcc8TfgjTqfML06R1EwTBVyj48QWZJKxW9EQbmuWU=;
 b=epqnaVjAsQCdHfp/f2sJzQ33ylh63mHEXKPytav3HTPdy58CmHM5AuROqAi97tvGvTSagWr7hq4/x69QGQVBYiqgP2+s4s4InXMwfkTmQsSgewq9H+Qw6sY5RQrFRvJVUqRE2fk06K6q2HRq30SrxxLE9vFOHkg6UTGHDmmSEcxzLnFd3IZ/Vcl9sqNS2VwtnDQ+f0tESCLdspzOGaMtg2QzNZerHeMTkKUlFF91ffJfvlfcgDlsprlCK+WAERHANqfXToXkGR852aHhs6EqGdgnNsDzoG4G/9GJkbui984E4AgOyGRGcgz2+CDALgUiCaVhezM5RpjzSxviimVOvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com (2603:10a6:10:623::11)
 by AMDPR04MB11581.eurprd04.prod.outlook.com (2603:10a6:20b:71d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Thu, 21 May
 2026 15:33:25 +0000
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de]) by DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de%4]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 15:33:25 +0000
From: Frank.Li@oss.nxp.com
Date: Thu, 21 May 2026 11:32:51 -0400
Subject: [PATCH v7 5/9] dmaengine: dw-edma: Pass dma_slave_config to
 dw_edma_device_transfer()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-dma_prep_config-v7-5-1f73f4899883@nxp.com>
References: <20260521-dma_prep_config-v7-0-1f73f4899883@nxp.com>
In-Reply-To: <20260521-dma_prep_config-v7-0-1f73f4899883@nxp.com>
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
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779377571; l=3048;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Bn5aqmUeZY3ewFQKEdMEUfnmGy7LGfvlckh7nlENc4s=;
 b=grFu+/LQBEDYg/UxxWFEpM6/7Wi/M5Fjy1TNRG3xpl2PceOpqUc6SIoo9ybHAZGwxVhbHRctY
 4YEquXMGifACtNXSFV0x0+Uwy7s2ajm0kxDyLSxMlqRI7aOg/kr36Eq
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:a03:217::29) To DU4PR04MB11791.eurprd04.prod.outlook.com
 (2603:10a6:10:623::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU4PR04MB11791:EE_|AMDPR04MB11581:EE_
X-MS-Office365-Filtering-Correlation-Id: 826c636e-ea89-4b5d-1dcc-08deb74e4c72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|19092799006|11063799006|6133799003|22082099003|56012099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	jZhBqWSf33DE+trUNZV1v+guN0zseai+egkjYQxawZr9754Q6PUvDPHQkC6GYCiavPcuRMUApAP+sd+a3x29LgoDkuSFRXEtSzAXOsFjO68XkTXiD8cfqGAuVRc6AZlIh96kvCaWjGt4QiIcDNKupr3J6rXjCNIUgj/zEwA6KLc5Cz4Y7MhQYjoMJMMJ9IPq1I2gAKqU4hcrQU737YAdoeRpchhw1EAV6/H8I/ubzMCmybGFJPJUoQOM6l8cEaI/aC/i2KvUcv0r+sYSV+22ql4+hDGyp3pfPz6n0dncnSsDCXiQI8Ee4d7OpycR04GhFjlvP+m3ZSOQT5AyKNLEXgUOj9CPNaVhStrsPdDR4ksJDSJ5xmShAUd6XZTjdRdwGah4iA5X/K8KP5tQjquOom3bUq67xgPCGwWUz6BP1jR8wZvPamQ2TjlzMMKHF1taz+FS/Bvo198eMEF/zHSPSrYseWWD9CjKmmCXpJaUFK17GZsyLokXPmhV896BOMbRdEb77qBM7Zc5l67o8K8RStCMyF5vBjFJckcjx/rVDDFc1UB15qiqaJiyZZsFfblKmN4b+KzSfRhfydG5Hta3DSXKyybsWEmYkWK8eTY6FNlIgNm9gPDsbxZhelnZ183HeBatoR0qHDKWh/ddLQVphCddPvbeQFpGk9geDPtf/P7jb5NDh0i/hxBZHPOzhoRfv0sknnO8nuB76PA1aMk5vflgODwriXgAyoFPHQ2ZiBI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4PR04MB11791.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(19092799006)(11063799006)(6133799003)(22082099003)(56012099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UTk1NmNvaEF2R2JHUnFwbm5wUFA2ODFtcFVxaFR0TlUzK0dsY0NRN04zZWpz?=
 =?utf-8?B?UXVlZ2FZdFRJeVdTL2MxL3A0Q25vdzhMdDRPS2dtQ0NVYy9RTjl1RklNdEl2?=
 =?utf-8?B?UC80dElSa2VDWDd5ZFVSTW5IRzhCc0RnOEIxbGV3YXFCWVF4ZnNSUFU2aUVM?=
 =?utf-8?B?eUFYRGtSb0tiUmJBSGJsT1l5VzFhK2t3R0ZMUlZ4Z0ZkenlOclhtUHMwbFFC?=
 =?utf-8?B?OCttRytPWUloaGlPUnpGNUQwRTR4YVN0eHIzYXJHNE90WWc4MmZjYVBXRjBa?=
 =?utf-8?B?elQyd2RxejBWUUM4eTZzVnM4VklOMXlkR0RQdkZZTVdWVThSZWpxZEZoYnpz?=
 =?utf-8?B?Y3ozK0wyNENHY2w1cUxHbjNKVWEzUzhnK2ljMlZBKzhPclBCek1KSGkyd0s2?=
 =?utf-8?B?eU9PNS9kM2QvbzE5UHIyYzAzSDA2dmRHVzBibk1LMGo5R296T3dtTFpNalBT?=
 =?utf-8?B?MWZ3NnBuUEhzc04vL3dXdEN3dVdUaE50dmtFem5rOXdRSkdYZXI2WE5nalZR?=
 =?utf-8?B?Z0gwL1ZkRm43OGtoSjVBbXV0R0JiQ1pHaU93aFBoTXlvbkJpekgvNWlCeEVj?=
 =?utf-8?B?d2RxUFJUdi80K25yV2RuQ1VScG5EQ2VueTZ4VUZWZHV6MXl5TFFMSG42Rkpx?=
 =?utf-8?B?ZlBOK2p6bW11cFpKdTBxSkxmcVdtK0hnUVZiblhVQ0w4aCtlZ3VCQlJWVG1R?=
 =?utf-8?B?d1lLN281OFp4ZndiVHBHcHhlZURjemR1UEZYWDFWQ0IrV2JsSUE5WW10N2RJ?=
 =?utf-8?B?a1MwN200VzNzRGhPZk43YkZNK2FkQ0NPVG5uemZLT3o0VFN0eXVkQVBGcWlO?=
 =?utf-8?B?M0R1aFhpSG5sVkNyNkFoMUdneEVmNDg2Y2F6UEpZbXRVcjBBaHdheWJoUEJV?=
 =?utf-8?B?SVZqWnEzcWE0SFJSaWFaWGFhL1V3eXV4dWxhUGlycjJhMEVIYmQ1c3IzaEpr?=
 =?utf-8?B?WktiNko0Z3F6cWlTNnRMWnFZdEMzTGRGS2pYYi81ZTRQUENxTU0xd2JtRHZo?=
 =?utf-8?B?NmZjak54VHFTNzNGNXZYZ0VFanBjQkRkSWl2THN1eER6bmNDb2RGbklRL2VB?=
 =?utf-8?B?TEFZSnN6WWNpYVNuclp0SGZFblpzTHd6Y0VUMDNHQkVoT0dVV21YZkQ3c2I4?=
 =?utf-8?B?djU4K0I4bEx0Q1lEdXRsMTVJS05IY2RqNUxqNi9GYSs0TmdKV2tEUG9JL21z?=
 =?utf-8?B?WFBCMFphOWNoUXRlOEVPTVVtRzBybUwzcFAxVnJMbEUyc1ZWVmgyUjlFNytX?=
 =?utf-8?B?Qk9OYWhrY3ZqTG9oSThXRzZocTkvRVFFd0x1UHFBOTkvS0g1cHpXb2tUQUZh?=
 =?utf-8?B?SFdlRHd6U1dhbVlTU1Jxdm12TVc0NkNNNnNLOWNuY1R2Q3VKSnR0L056VnpG?=
 =?utf-8?B?TDhwbCtkekJmc3ZoVlVDU0lUeXhBdng5eldaTjFnOXJpRFNHUFRUWHBrL29x?=
 =?utf-8?B?Ukd0Q3NjLy9wNTN2alovQlNBZXplOXZOVjZ2WUJoTjYyTEt4MlVuT1FHRlk4?=
 =?utf-8?B?RmVMdEJ0Ri9QMmtCYmVtbXBoRGlEalZhcnRiSE52MW1FbFBqQmVBQ3VueHhL?=
 =?utf-8?B?NzJ5VFo4TlpEQ2IySENIVVhWaGRqNWM5WU5heUZTYmtFY0hpdzZkR1MxR0RC?=
 =?utf-8?B?K2d6S0kvdHd2VEthL3ZjM1RoQlZvM2NlUlc0cXJlV1FyWlAzK1pnN0JFMnBi?=
 =?utf-8?B?dE1Zd213VkMyVlBTQ3Q5U0pRWXBBUEM4TmZhMlN6RXAxZWg2aThreWhicVNY?=
 =?utf-8?B?VXFSYTlBZE1WVHFWbE9WTnhheC81VDhUR3A1QkxUVFl0akNvU2hibUlRTThB?=
 =?utf-8?B?VTd1SXNqKzdZVTAvWVV5Z0kxTDlZYUhVSERoY1hKamRaUUZ0Y1l1SW9OWEw5?=
 =?utf-8?B?YVgvVTVVcDVNSWR2ZklvVVRBRWR0QStRdGNBbmRKRittQkI5ZVk2dVVsZU9s?=
 =?utf-8?B?TGFLbm9VNTVFREVxSDM1Z0dYRXJtRjNSU2cxbU1BYm16UmkwUzRPUUZMbTR3?=
 =?utf-8?B?cmsrcmdFWlFBU2pScHYwb1oycXdxOTlVUGxUMlh6T3M5SklrZk93dGZZSUx1?=
 =?utf-8?B?K25RdUk5RzgzclkxVm0wUjlScGNqOWt1QVdYNks2WndQdHFqZlluUkdINHZD?=
 =?utf-8?B?NDR4ZlJMT2FUWnZWSTJyZUdDcWx5UnBsc0w1T1IwelhDcWp1RDNmQjFCdVFO?=
 =?utf-8?B?eVErbUQ5TTczaGJkVml6UlUwZXoxd3lEU2VwcnM3QWphZkU3MzU1bWIrUHVH?=
 =?utf-8?B?TWtVYVMxTFpSTDhEZ2c1anRkVnlyOEZncnZsZzcvWVJIL2RwZjJRYmk3cXpw?=
 =?utf-8?B?ci9UNFMvRU9DbEdHVFRxbGRKVkxHdFB4MU8xUUFzOGVCaGs4S3A5NGdvYmM4?=
 =?utf-8?Q?eCh0sr57LoRauA1ADvfLkb16OK4jF6syQLIbu?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 826c636e-ea89-4b5d-1dcc-08deb74e4c72
X-MS-Exchange-CrossTenant-AuthSource: DU4PR04MB11791.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 15:33:25.3975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RETg8TMPOJKSxIk9mIuM6mX4DrihwDVnmKGk1Ndv2jimIJAqrPrBr3GqABsRE6CmLD243vjTNOSN8fkypj9Y9B6wU1jzQFBtYsQene62Yc5SMOc6mpo9vJToTDb1f/zX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11581
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10683-lists,dmaengine=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@oss.nxp.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[NXP1.onmicrosoft.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:mid,nxp.com:email]
X-Rspamd-Queue-Id: 336EB5A91D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Frank Li <Frank.Li@nxp.com>

Pass dma_slave_config to dw_edma_device_transfer() to support atomic
configuration and descriptor preparation when a non-NULL config is
provided to device_prep_config_sg().

Tested-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v3
- rewrite dw_edma_device_slave_config() according to Damien's suggestion.
---
 drivers/dma/dw-edma/dw-edma-core.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 92572dd8131e6..ba37bc983dcd2 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -267,6 +267,20 @@ static int dw_edma_device_config(struct dma_chan *dchan,
 	return 0;
 }
 
+static struct dma_slave_config *
+dw_edma_device_get_config(struct dma_chan *dchan,
+			  struct dma_slave_config *config)
+{
+	struct dw_edma_chan *chan;
+
+	if (config)
+		return config;
+
+	chan = dchan2dw_edma_chan(dchan);
+
+	return &chan->config;
+}
+
 static int dw_edma_device_pause(struct dma_chan *dchan)
 {
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
@@ -385,7 +399,8 @@ dw_edma_device_tx_status(struct dma_chan *dchan, dma_cookie_t cookie,
 }
 
 static struct dma_async_tx_descriptor *
-dw_edma_device_transfer(struct dw_edma_transfer *xfer)
+dw_edma_device_transfer(struct dw_edma_transfer *xfer,
+			struct dma_slave_config *config)
 {
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(xfer->dchan);
 	enum dma_transfer_direction dir = xfer->direction;
@@ -472,8 +487,8 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 		src_addr = xfer->xfer.il->src_start;
 		dst_addr = xfer->xfer.il->dst_start;
 	} else {
-		src_addr = chan->config.src_addr;
-		dst_addr = chan->config.dst_addr;
+		src_addr = config->src_addr;
+		dst_addr = config->dst_addr;
 	}
 
 	if (dir == DMA_DEV_TO_MEM)
@@ -595,7 +610,7 @@ dw_edma_device_prep_config_sg(struct dma_chan *dchan, struct scatterlist *sgl,
 	if (config && dw_edma_device_config(dchan, config))
 		return NULL;
 
-	return dw_edma_device_transfer(&xfer);
+	return dw_edma_device_transfer(&xfer, dw_edma_device_get_config(dchan, config));
 }
 
 static struct dma_async_tx_descriptor *
@@ -614,7 +629,7 @@ dw_edma_device_prep_dma_cyclic(struct dma_chan *dchan, dma_addr_t paddr,
 	xfer.flags = flags;
 	xfer.type = EDMA_XFER_CYCLIC;
 
-	return dw_edma_device_transfer(&xfer);
+	return dw_edma_device_transfer(&xfer, dw_edma_device_get_config(dchan, NULL));
 }
 
 static struct dma_async_tx_descriptor *
@@ -630,7 +645,7 @@ dw_edma_device_prep_interleaved_dma(struct dma_chan *dchan,
 	xfer.flags = flags;
 	xfer.type = EDMA_XFER_INTERLEAVED;
 
-	return dw_edma_device_transfer(&xfer);
+	return dw_edma_device_transfer(&xfer, dw_edma_device_get_config(dchan, NULL));
 }
 
 static void dw_hdma_set_callback_result(struct virt_dma_desc *vd,

-- 
2.43.0


