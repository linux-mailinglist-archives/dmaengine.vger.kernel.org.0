Return-Path: <dmaengine+bounces-10684-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DFZB4I6D2otIAYAu9opvQ
	(envelope-from <dmaengine+bounces-10684-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 19:01:54 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2F05A9CA5
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 19:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 992013410DCB
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 15:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70411377034;
	Thu, 21 May 2026 15:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fayKN+QL"
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011019.outbound.protection.outlook.com [40.107.130.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB85371D0E;
	Thu, 21 May 2026 15:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779377615; cv=fail; b=dFqnCVTaxtw/xE6hZFwJbPbrW3HziQPeH3x304nMMOVL15pc2pLWkVBRjkzCzFTuTX0amBxvjmqlekmzdEQFdqPuo4CXWEYSXRrGTqCbVN4eKtsLH2Iwvo04uLM8h8Y0kr0fUpUcaNPtpy3hmsUPO4fRl2IBhHIv6lnMLERpOXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779377615; c=relaxed/simple;
	bh=+M2lx82T/SFuJPnO4V/KQr48tQ06j51TU6I9+la9R0o=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=gvW2fnmwo42UXpUqQC/3V9z9eePFVh30Oy5TS1uZfsW9hOXNg7HztHYUbuMLyPXdPRi1ceCQzr5vaivMkpVUYoEXwiTzjfjMQRTp6N35QuVRnSbujPysvV7X+eBepN+r5Fc0pFRn6FWFB/VVUQTUYXiul6ePg9GUsn/qSp7Maos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=fayKN+QL; arc=fail smtp.client-ip=40.107.130.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CHr7GEeYVF33cF+otFH3VvU1yKYDcZnNQB2s9T0ugzCPkHP3kt764FlvpRpUV29O3IZSdWO+EFBVbHXUMuAgFAgk7F6ZJBAPROJ+cig5E7GWQ/XNf+Yh9QQsIlH7shBVmEP5TudI26aQEc1GWSAAD5E4yoWLtP/pqvtdNLXs1v/ltAbiaCpc0TYjY4I56atZhslNzlbPVS9/yjndb3KP97D81a2QhlZFePgAFNQoRAXGY0hdMeC7Zn5lmtyyUxBFMSCLFAcnq3xl5fHqE/fNegOaeFYGL/AaDhuj6lZznlb4+FAp/wsZsT4AmNOvpG1eQJpM5EmHoLvq7NpdSfASWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXPk88HSDVKkbLLpzVW6jKOO4Jd50ksHFKn8+jGBYZw=;
 b=hxFzogvL4QgWTSszPpcQCbgFpNpR14A0aqnj6EtGxaWB277OSpzaAq4jgQsYKzoo/00Bq8NNDW6LGWRRMrUVG/XZ/EIVMJRtsVzCR6omNPgdbYTtVaKFHmrD0ddTe6MnuaNBpbhF00ooIxFpeUDcnAEofSPDLB2IHOOjQXIvBHiTp7JdLPSNDb90HhrATOH5Mwk16SrrRKrsLeYqzHsR3h7bYTCcfaOxJDEWO0BxEBqAhaMZkON6uCjcr6Pcx5TdgqHaUv6lM1gz/iKofDQIh2rusBw2WWAsAumGB8/L8Dq0Fx6XGYNkFUOUj30Mmf5KsPWoru7mhpnbsHx03wsxcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXPk88HSDVKkbLLpzVW6jKOO4Jd50ksHFKn8+jGBYZw=;
 b=fayKN+QLYwhQUyPNnurq2/Uo1cQUgTfg81YAWrwIKpKw2uwuvLSIapoxVGi6FpE1g0jaCNc9eGgCb2Vng3MKkD6otmnNUZ6wP3saYZo4IJApY+8oyOTmI02bhOUdryq9uTpRM9aph7ml6oONDmx8HyJnRYo0iq+bof/eKwBd7ukBQpZ58ND0SdCx27izJFsGVRONPIChzFhq6RMf3q0FFvyOTZKwv6rP3R3ackDw/V/eY+hM2wW+sOn1aBMZ+DEKgCH33N2TF/ggkP149DluEPcSLGFGmmgQi3l2sXmWrNSs7heSdeTJ4mI3l3lRUexNzPRJw32oQst/941sAm75kg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com (2603:10a6:10:623::11)
 by AMDPR04MB11581.eurprd04.prod.outlook.com (2603:10a6:20b:71d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Thu, 21 May
 2026 15:33:30 +0000
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de]) by DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de%4]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 15:33:30 +0000
From: Frank.Li@oss.nxp.com
Date: Thu, 21 May 2026 11:32:52 -0400
Subject: [PATCH v7 6/9] nvmet: pci-epf: Remove unnecessary
 dmaengine_terminate_sync() on each DMA transfer
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-dma_prep_config-v7-6-1f73f4899883@nxp.com>
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
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>, 
 Damien Le Moal <dlemoal@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779377571; l=1294;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=MtVHghBbP5ur9sdbIo7YfLXlw6DWbAENd28zNpiPwC0=;
 b=ySi4jH+KEWUWYvctTOHo8i7fV3xTs7WOrP+Rbgr82TnPnpRfLSzlb/qoZfrmlTPSP8Mp4BokC
 cj/3RpK8UOtAMcrHHXjEzX9tHLena+lqi+3ZGohX6Ito3vEcolXAmw3
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ2PR07CA0015.namprd07.prod.outlook.com
 (2603:10b6:a03:505::28) To DU4PR04MB11791.eurprd04.prod.outlook.com
 (2603:10a6:10:623::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU4PR04MB11791:EE_|AMDPR04MB11581:EE_
X-MS-Office365-Filtering-Correlation-Id: e86fd193-704c-4b90-8478-08deb74e4fcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|19092799006|11063799006|22082099003|56012099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	pRE4ZhFeUeC3zxT7KwEK3mKSdJNsUok5JGuB9fzhTKRLHavwt+b84ANZzPtGK3IULuQ0t1YYTs64n1veYpCAWGkaxZ/q5Sy8PuA2GN1Aap4H6VDEMfmvxP3fKw7wgvUeseHdm7QRY30aUCVNaVFBJZsCJwahbCY+yK0N6aWQnfA87R8ho6nQsZi33H26zH3CvdW6H6U0KyZCIZf9s0XQiQdq5wpPwdw1lQrtjkUIr2Ei85M1nq8c7ocYxlOU1RITMfnq/MpgiGT3Y0vbI0MSGEdO+8fiaeIGF8pOUyHYI0FI8FJ+Rt0AjcZwhTc7bx+evr/S3t8ksM6tBwZeOBtpe8u6s/z9pklyoDAQve+65b5eA04DNXr4V8cZibiMPIRmXDNGuBigg8DbY/Z7rEL7Mk/X9r5sMTVAIOdvw0HXP7iDMpfoCQSvgX0o9H2MBEMyv4yQNIhL7965a+5Uxhd9SI2Pm3nkfajCm9HvC78TOV+UL1mdpdmNeXOPZiOzXNveIXnWWum9CNJ9fKss2zp7VNU1eqZlLBELVibs+RqeB+Q1s8mKQCnpP0UisbM4YJdH/KYlXZmNpmmSmALmabZRWANfsRTDKX15Ug1XDTCUawzmEgXf7B67wGOCtXpBGRPNeUdP8euFtTx8MabG83oi9jU/1iK38CmMO28xcHFmYZ80j+QQ40fRgsUZUBkyV8LHM4bKaEXQRGlDUFJ68rAjkQt3r/pNuC+xKq3KnYmDd14=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4PR04MB11791.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(19092799006)(11063799006)(22082099003)(56012099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWxXY1g2djZOVGg1eVlWT1J6bGQwNUVNWjdQZXNZdnF4WUtWMEVsNVdMQkw5?=
 =?utf-8?B?WDQvZGZ0STA2NXFybGVEaEx0TVBpYzhMb1ZCTDZIMENYN0lUNk1zTEJPbjFZ?=
 =?utf-8?B?MHVvUlpsV3VRQjJlZENJbjNMd1dvQ1FRSDRsOEpxblJWV2ErSWduRXBrZGMv?=
 =?utf-8?B?c0Z1eVJhTDE5SFlzMjFCajdMeDRrSENaWXVLeTJTbzhCVDREZ0pnb3loNmRr?=
 =?utf-8?B?YUVlVzc3R2tkTWUwZG9UOVBveHZEZWFoVFh3Mm4vK3lHbEoxbVdCSjhuM29v?=
 =?utf-8?B?bUMxdU5CeXlmYzhmVU9nWWdLRWZiZW9DQWdlTVJnb0EvR1BVMThqVU5BMkZT?=
 =?utf-8?B?b3FFbzZiMHg5V1RCQjRLRE9nd0JlWTFDeFNLcmMyWGFBdExwZjNNNlpnOEk2?=
 =?utf-8?B?Wko2RWlMaUJqK29Ick5rbVVkZ1FONGlpZ3pUWXBrd1k2aHVYNllYcUNEK2RN?=
 =?utf-8?B?RUF0R3FKMHhVOXJIdktFZ0ZDU3FnTFI5SUtubUZCcmRSbnk5Z1JzRU51ZFRy?=
 =?utf-8?B?MmIweGRyNlRsbDFFY0RzL0p5MnczRVlIcjF2cnpPUE1TTTBWRmpPOTY1bkN2?=
 =?utf-8?B?ZEFYV1FOVDhWb1ZpUHNLSDRiU3FTNEROaEZuSExwcGRHOE1RVTAyTGV3c0xE?=
 =?utf-8?B?a2xZZFVZc29jOUhjNlZaVG5ienZOaU42eHBxNjlLazRWV2tVREpyMkFwOVo3?=
 =?utf-8?B?Zzhvc2Y0QmhBLzBJYVBndHd6dEpNRE9FOFVsbmV4R1FNQkkrR1ZSRFJ4VnRG?=
 =?utf-8?B?MmhYbGhVL2dBUjFKZGFmeUZlNWVwV3M1WWlTaTdIZU1PSkJFZDNsditlZjVn?=
 =?utf-8?B?Q2tLaEcwQUVyUnZQWS9PV0dydHVka0t5VmNGMEJZWGpjQnZBM1ZTaDZ0RkYx?=
 =?utf-8?B?OWZiV0pZc3B4UnBveU5WTlVkYlNhNitoV2lPaXVJaHZsZnFWZWNXbmttM3lU?=
 =?utf-8?B?SUZhaEZ0ZG84bEFhc3k4Wk4xZ05GNnNrTlRYOVpkU2pXNEUwQmx5bmd5NmVh?=
 =?utf-8?B?c1RQbEVsRGdiUXpTeDN4b0tiVzlrdm9HeGlJU2UrV205QjVyaU1YNkV3dCtZ?=
 =?utf-8?B?TXRuenRsQjUvTUxYenhzcnBxaytrWnJJWEh0TThGYi9WN29zVXBEZFM3Zkt5?=
 =?utf-8?B?cGpoS3ZPV1VVeUpkTHNBVkhMVjB3Mi9TK213b2c5RVBmakNma3loU29Celk0?=
 =?utf-8?B?UUNqM3FDMW04VmJuZFRpeHJ5UXNZOGNOU3dDTDBKL200YThuYnZTOEF5d2xW?=
 =?utf-8?B?T2pxUTl5N3ZoR1VyZHI5YUtPL1d0cGtHeXhwU29IdWt6VEhzb0xNUDBuVFM0?=
 =?utf-8?B?Tmx5ZVovV25JaGR0eWFNVFkvMmo5bFcwTnF6Ujk4Z0Zpa1RSb05RNGU0MG91?=
 =?utf-8?B?S1g3dmU1QnorSWg3WGs0UkZ2Yit4S0J5Q0JDRWp4SkVoVTY1WU45b0dMajdK?=
 =?utf-8?B?KzF3SUNnZ0g5aVhwRHJ0dUNMNEgvSHJGdjM2YWYwT2MxaFVUZUE5RFIrcDU3?=
 =?utf-8?B?cVNZSnhkYVlhUSsyNFF6bXByTCtzdXI5c2o5UjROcTVoS3VyOXEyQStRUVRt?=
 =?utf-8?B?VDNPcVI4L1BhNDk3NmxSZ01pTGw2RXNUQXYwWFFSeWZRNmhmRnlJWjdjaHVT?=
 =?utf-8?B?d1ZiT2JBMmt4RnY2UjRGNUIwZlVZT0xnVDVDSWZ5RXhmK2VJTmRNY2JjVlhE?=
 =?utf-8?B?ckplV2M3dDM3L0ZnQkcwRUFQZ1R0bTV2ZTJvYTNQQzNURVllaVVoYUQxeWU2?=
 =?utf-8?B?ZjZSc1A5R3lrZVg0UnJGRzRTaU81UFlZR0E3Q2RmS0NQRFBRdTVkZXV6RTU0?=
 =?utf-8?B?LzRhNTJwbFh0Qll3TmJwSmV5YmpXMjFySHBTd3AvcUM0VGVNNjlOeGQ1cE1x?=
 =?utf-8?B?bCtHT2VMUGZTaG5FbzNWdlp6OGI5bDE4RWRndTNON01acHVsNWJGU2hjalZu?=
 =?utf-8?B?SlpJNTNhVWNOUVNZbElsY3dkQUVQU3lsUFEvS1JsR0RIWW53N3FZZFlxNlZo?=
 =?utf-8?B?Y3JhSHlCZi9PYkdDSzBxWWdWTzdEZUtRaDloTUUwcE5XUm1qdUR0UDZrMlpK?=
 =?utf-8?B?cDlyMzVEak0yYUE3WEpHMmNia0ZOcTZxMzJLK0ZNVE9aSXFTd3ZJWHVBc1JH?=
 =?utf-8?B?NUI0dWdadVFEcmE5K1VGWU5QQ1ljdzh6V1hLUGtpRE1abU5hSTFMMHlVT1o2?=
 =?utf-8?B?UmVmVWlYcHVGczE3ZWNRdUc4bHFRNVVHcXQ1Y1FXbXlRZjFqV1FTSG8wTjdS?=
 =?utf-8?B?emhUYk94U3NpQ1lUZXRqYjgvRGIwZXh3QjIxLzhNYXhQd0ZJVEZoRnZLNDBT?=
 =?utf-8?B?aU1Qc25haEdoSjdJMUJlazRNVVh0WUFzN2xSaERsbGhubDVTbUpiT3huTmFT?=
 =?utf-8?Q?Jw25nJrON9m26jzaz6+fw6q0Ed89DheQM3dnA?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e86fd193-704c-4b90-8478-08deb74e4fcd
X-MS-Exchange-CrossTenant-AuthSource: DU4PR04MB11791.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 15:33:30.8753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 95FrwWicEHWZPlYUnOmJX87FJcaLm1THPmX7fQ+P2M6Wg2g6xwmALzRYqNvRHSzCUS655H7uvelE+61sHe687zodBvWn2duBtVfcofUeRccihVVNbhW+6bBjuvM9Qun2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11581
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10684-lists,dmaengine=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@oss.nxp.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:mid,nxp.com:email,NXP1.onmicrosoft.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7B2F05A9CA5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Frank Li <Frank.Li@nxp.com>

dmaengine_terminate_sync() cancels all pending requests. Calling it for
every DMA transfer is unnecessary and counterproductive. This function is
generally intended for cleanup paths such as module removal, device close,
or unbind operations.

Remove the redundant calls for success path and keep it only at error path.

Tested-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
This one also fix stress test failure after remove mutex and use new API
dmaengine_prep_slave_sg_config().
---
 drivers/nvme/target/pci-epf.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index 4e9db96ebfecd..2afe8f4d0e461 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -420,10 +420,9 @@ static int nvmet_pci_epf_dma_transfer(struct nvmet_pci_epf *nvme_epf,
 	if (dma_sync_wait(chan, cookie) != DMA_COMPLETE) {
 		dev_err(dev, "DMA transfer failed\n");
 		ret = -EIO;
+		dmaengine_terminate_sync(chan);
 	}
 
-	dmaengine_terminate_sync(chan);
-
 unmap:
 	dma_unmap_single(dma_dev, dma_addr, seg->length, dir);
 

-- 
2.43.0


