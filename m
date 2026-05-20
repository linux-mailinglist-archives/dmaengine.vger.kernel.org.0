Return-Path: <dmaengine+bounces-10585-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aN+nBs41DmpN8QUAu9opvQ
	(envelope-from <dmaengine+bounces-10585-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 00:29:34 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D9D59C083
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 00:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B7B3830FCD57
	for <lists+dmaengine@lfdr.de>; Wed, 20 May 2026 22:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067573B6BE8;
	Wed, 20 May 2026 22:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="gmASWly5"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013023.outbound.protection.outlook.com [40.107.159.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAD83BCD38;
	Wed, 20 May 2026 22:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779314496; cv=fail; b=ASt6YHHCn7Z9TYRVe61ndyGFr/3Ry/XldQ2KZmGCjSgsfI4YX/w7H2y3cPDkLh4ctzxsQ+fuDY/FViUuASNK5vHOMf+nUedKeQNE43RqWff/pjNx7XPOOHZFhwNj1m9kCguZ1ZVSXQYlYDECov+8Wn2pFmBaqqn73rSkfj340zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779314496; c=relaxed/simple;
	bh=DAkxgfNuePAWypf4R/V/s8chDsIy3838bvIVaup0Efw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=KBqUBn9LiJGjgamXvcuOjYqXWq9wh1nlkZQVXDyIJr03VTqb9Vk+hLDDJrX+veGTrnGHPfeZhibXurgVcN/qM61z4wnDVhlTIrcBRYFSyTU2Ys/+69Hf0C14JlUQjAy2oYx1bHtIFel7OgJg8BN1NhAH4XQKjIFDmJ9tGMdFZfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=gmASWly5; arc=fail smtp.client-ip=40.107.159.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qYDWN+Ik8+pfhm7iaq05Hpq2udRYUxCWUKtMr4cXyyiiOrw8ZAckN9Co3w0Rl/jODXScO7TE4r06/h9LEyBKsyFADMI7UUUvdt+x6kR5v3EbotSzzdSd5mJUlpOOyo/5WJ1vk6AKs+c03mkGaMLuqZsGB4SEW55wd4H+yys0eWx3LWoAwM9B64h3kkDpytZp3p1LCqxsqFLZpN8UwEC/huDGYSKaOLnpS9fs0+KYpjPmnBfqxgqNisA4AwysGa88OCgTC6eXXauC2KHciYvcXP8BtSayYoAjtRbeI4/nmMJC3Yk+ZEnBBZg3xePJGi9RuLVBx2qEv+o2C4fHutbJJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PPnfyCZcbul8/0bvvhgrj/9ZvSy5WxlXajFEC2wQWs8=;
 b=FkyZRMzY7o6s6I0zfTdoJ8eZAN/PCCDl229+w8z8NnGZq8tslig825HjWtwOwkeI9NOgo+sJqcHwVjgawLzFdng8BzvFd3vExrhTX8cbczWN8VIVBeP6LOhjrryvtt4IShu7Dj2Wyi9wvtKUWzDnlKfU0UpWylLJS0ZZhq47tlTGvK9IdXhvCI67xbDeooh4QXaaQD2DsNx6O1auT0qv65IqAE+svNRVTSUxSeRGZNWVlAdMGagvBF8XL2Q9ZWnLiGBi1ZgZjHTU74z5sVlPpgTx0wHPgsQrpej8HOBT3MKmpUFCoqhWIXVGScGm+7Gv/5fgpuEnqKI4P2KBjZDdxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPnfyCZcbul8/0bvvhgrj/9ZvSy5WxlXajFEC2wQWs8=;
 b=gmASWly5kawtHwvBZjeoQMchonavAzaspatg6nwR7iRsJU6JeqxPSqNOSIcjNnm7i9QJOhxd+ufmHZuwcby4DWYr14LHJIsn23uP+qS1vNOC2cLAJKdtKtJ6mJC0MInAOsc2HUQ+9kRpbEdv3wdz+WCgr+Pyl0s5n0URDa0cF138m7sOp2mIEh8sN4UM2Fgo4u5czG7truuV+kZ/+54u9cJoLoz/UEMhpyYAVboi2g/UXZOIM5F4bNv5dwWbObDZ/F8AikKkfnsNRbVSN+CJK6yoXESkqXl+rt/oGCiiXg8V5D+hNOtQFHuWSIoT//9QX2DwvQCIBK+Uwmf9ANGglQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA4PR04MB8029.eurprd04.prod.outlook.com (2603:10a6:102:c9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 22:01:25 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 22:01:25 +0000
From: Frank.Li@oss.nxp.com
Date: Wed, 20 May 2026 18:00:49 -0400
Subject: [PATCH v6 8/9] PCI: epf-mhi: Use dmaengine_prep_config_single() to
 simplify code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-dma_prep_config-v6-8-06e49b7acb38@nxp.com>
References: <20260520-dma_prep_config-v6-0-06e49b7acb38@nxp.com>
In-Reply-To: <20260520-dma_prep_config-v6-0-06e49b7acb38@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779314446; l=4625;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=mxi7fNpqhewVwhRKTp8TaG2mZKrM6GhpOzyIZjOPKlw=;
 b=LjVhMKG8WU3w+jODP15nHcOZC7i3xaVdfBIIMLsKUeCPRMn4XeHe54abrvL8peRTJgS7mRvbH
 fXI5N8vDeOkBpBhX1L4tBxbDuik15C213nHBev0fQ99YXPP+JY9oFw8
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH8P222CA0026.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:2d7::10) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA4PR04MB8029:EE_
X-MS-Office365-Filtering-Correlation-Id: 8092f91a-0602-4d77-7ec8-08deb6bb562b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|19092799006|921020|56012099003|18002099003|22082099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	GWP1Mv348hM/hAhM7HfP8BtrOif0DMWpHSQL7ckDaGK/ckceZIWiGjFI8NERHqbRceQ5+foaJQXoPmxmCLdrdFmpVRoN8VFMpLAz6lkgtXd16X3j6XxiEqaNmykKFhMVYkubiihAtN96r0aNNAGEtoVZ0357FnIiGLydSyB9r5blF/hptWBOgGGgbE808AOKcSQ/8imDXS1JhJxl4UwaJnMNgnU+ySnzgCj+Eg5sBizXhq4McHMcpet65VlOjGNb+Q/JQdpF+SdRKChIZa8hRXjGkJw/JpLMFvJyNv9ugziFKCTJFFXxPmFHXVtS4aC9CGLC8oQ/ud22IfK5cx9kSMxiHe5lMl/VEt7q4fsq5PZa+1I8BI0+ybKPhhNPG52ZZdozu106+1DUMNBhgy7omeBh354U0gsh8Gu6Uu+KhSEixRbXuH55bF6DbI0dSzHM06cp6mI0/q/UAPF7JQe/XHfiIMUA4yBF5kwzJwr77rDKRhVGdPCkCS3JA2Se6hsabW1vlXX2a3Q7Rt9OZ8KDbXQfC84XeFaVbKSoXHLeOs0p/LHqSnhYaBEYpIDOPm1UXmXI2QAr79ViBfBZxq96cqlkxE61dpF2Rud9AsHcWntwufizskLAO/KZn8+rkowwGmQzV6UsswF1q3samPM5zu7GWpDnlsY9kRsGaaTz1euTkXu2SPO1vX3YxO9fN+h4j/zzaWsxNPF0zJL8ycZZD2NOo0Q9I55F5chdiXd+Tls=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(19092799006)(921020)(56012099003)(18002099003)(22082099003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OVZYVGpNRnlRQ3V5OVVSWHp2K1VHYm16TGVYVklsNzdEdmhvSmE4bkhnZ0Zm?=
 =?utf-8?B?OVJaRHpiVTZDZnZwMnpMaDVwSVRjQUFqYUoxblJ3TGttNnBydXlzaDE2U01R?=
 =?utf-8?B?NVlseFFIYVZTaFZjUG9mRFd6SjlDeHZxa09RbkhTa2hZQ1ErQXhlL3JlbFpJ?=
 =?utf-8?B?emROalM1eHgveDR2SmZQQ3psWDg2SmprdU9DM1BTVGQ3Ri9mNFJ4SWxJaDY2?=
 =?utf-8?B?R2dyUDZpRk9ZVmJudDVtc2hIVGFrNmRKTHVCUjBja1hCS2t5ZjNrWDRYQVJl?=
 =?utf-8?B?TDhhc3RqRndKbmh4d2ZLQW1peFg3QmM0YXdBeXlVNG5mSEErVHBaYzNCZWxu?=
 =?utf-8?B?SGx1M2tUQ3JVZE5UN0ZnNzlqL25qYVdpOVhoMmE2bmQ3VU9DVitUTEViODFX?=
 =?utf-8?B?aldkdlRteGJhT1lrSjZtMm1tUy9sN1RDUnRWbE9aVGc1NG8xdGJMVUw5aDVz?=
 =?utf-8?B?V085ZHp2SnVLRkRjZS9US3BGaDdYT29lSzdzNFQ5UFlsNm1mRFlqbzR4WDJE?=
 =?utf-8?B?N2JobG9wU0hDNVFZT3YyMndaTGRCb0oxaDZ0R2ZHajcyeUxGUkN1MFZtbjk5?=
 =?utf-8?B?ejdqOXh6RWFlM2hmOXAwWEx5N0xDdkxoeTcwamJkRGJzWlFvMkQwWGRiYWFo?=
 =?utf-8?B?K0hyRDhMN2RvOHJTZ2JLVTZWMnhQRUNKSUhYcFQ1alZXU0w1MW9VdURHWXMw?=
 =?utf-8?B?R01CU2dCV2syUW12S3FaSWpuWmhqTURpdDhEY0toVnlPUUdUMkZwV3dVTHRO?=
 =?utf-8?B?MlU5WXJISms1S284bURxT1k0UnRFeGlVWTQ5Z2pqL3pVbEgrb0J2NkljbVBt?=
 =?utf-8?B?TnpzQ2dhVmJUNmxNcW1oNVdsaldxam8rRlQ4KzJ0aDMwYnJwa2tGYmIyWmRo?=
 =?utf-8?B?M3JnUjNCTzVQcm5UUGtTM01QSEdUWXZGQm1jZXZCSCt2QWd1VXdiaHhKUTZS?=
 =?utf-8?B?MDR3Wkw1VDA3N01XZWEyYWx3a3UzOGNwbWo0RG5ldFhpZVNMZ2ZKUVpHcUgz?=
 =?utf-8?B?Y0paVmd2UklqSk9jZWRUblcxQjdrTzljbkNFUHNEeFVlaFpwNTZtMHhMVCtG?=
 =?utf-8?B?U0xpWnRlZmM2Y0w5RnpDWmdDTEFuNUE4RUFBcnFzOGJWd0dPRE5JaVFDUlNq?=
 =?utf-8?B?ZllLZzRjcWlKWnRVaVo2WkY4Z0I3di92VmJRTnVjbHZwMStRRGIzdzQxdFpk?=
 =?utf-8?B?aDRPSHp3aW8yc0tpUjU0eHJDbW1kakpxYlFzQXp0b3VPVFZZMHhhZDZkNTU3?=
 =?utf-8?B?Q0FXNTVQaGJxekJwVENDYS9KRnRGTG9ocFBqb0dwUjBjY1I3OGJINWVOb2F2?=
 =?utf-8?B?VitoYllYZ2FkSWE3eFR5TFVsWUpoY3ROMzM2eU80OGFnNTNPaXpObk5IaWww?=
 =?utf-8?B?M1FKZDNWSzQwME5ubU01WHRhLzd3eGM3TXFsejMvRE5WZG9CUnBEMzEzRHBt?=
 =?utf-8?B?b1gxZ3FhM0orNW4zcXNCSjhEUGRjQmNmZWdLRHF2aUlSRlRoL1JtaTIzUDhn?=
 =?utf-8?B?VnlrNVRnMzJPcERpdjB5bGR0YVhsT05sYVBxY1d5ak8vZHladE51bDBIVUZZ?=
 =?utf-8?B?SjlhcmZqVlU4Q1JWWldSWjh5V2dQdFpjRjQySWFRd3kxUUc2czA4WXhDUk1s?=
 =?utf-8?B?NTVOWDRHYjNxVEN6VTlvdnUzVG5qdzBwTGNrR0pNeGZGL0hPa05yUzNkUU5j?=
 =?utf-8?B?b09vUFMxS1NSM1NQSGtyMGFDUUlVdlN1REF6RmU3bHlOb2pZWE5tTlUxbnV1?=
 =?utf-8?B?UkRtRXg1YWVNV1htMWhlU0J4ZjIyNGdTUXoxQmoxU20wd0JkUVprRFRza0hL?=
 =?utf-8?B?enBncTRLZ21rVHM3L1FlZGhCT2FTNGxGd3l1SVNXa1BWMVpJL2ZZL0hOOUdy?=
 =?utf-8?B?cm9ycU5yRHMvd25TYS9JZGVwZWtZeHd4TnBHUFVMeDdnMXhjVlQxZWFUR25C?=
 =?utf-8?B?bXZJeXNXUWJBMnBOSktIZWxrangyYUJ2M0I3a0xjc2s1bEJJUEY1Y0EyRDVV?=
 =?utf-8?B?NnpvNUg2cVNPWXR3R0krVFFtR0kyLzJRL0p4OW9UUW9wUmZubmVIMVNXZEVr?=
 =?utf-8?B?bGpNb2FmeGR1blZhZGMwR0xZQm1RRlJvMmx1Qlg5SmZFelRZeDYyOTlKRFJF?=
 =?utf-8?B?VVM1KzdlRW0vdXpoekUwMitwSm5odDhiNzNROXdiVTJ4WjR5bVNDUkI3b3B4?=
 =?utf-8?B?cWo0RlAwK2JpZ3dTT215anhMYXVoN2IzWU95TERTYlRqUzdWcnpyME9WTm56?=
 =?utf-8?B?dkplSGpiWEZyQUxTcTRMYmVFRlo4NWJqMXR2Q2ZvWDFzN3ZVelMvTGdQMHE2?=
 =?utf-8?B?K3hzdU5wUGxpQjBqTUkzcUQ5a0JTTWxudlRmdFFRa2pNYXpWbDlrZVFUcFY3?=
 =?utf-8?Q?6xD9mj6GKxa/2JiLLBQJ4p82njhKfUXA+53Pe?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8092f91a-0602-4d77-7ec8-08deb6bb562b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 22:01:25.5901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8DBO24sNbporOjSe9QTNVCw1azi3+ZTOZ9/OhoPP6jk/s+njse5ZQyaYJYWh84Dbv8vXcybJBeoVzMspkMOQ04unRq3kw2UxGWaSKjSOA7l5rNrMl1Cc0TWDxyPWZYHu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8029
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10585-lists,dmaengine=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@oss.nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:mid,nxp.com:email,NXP1.onmicrosoft.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 26D9D59C083
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Frank Li <Frank.Li@nxp.com>

Use dmaengine_prep_config_single() to simplify
pci_epf_mhi_edma_read[_sync]() and pci_epf_mhi_edma_write[_sync]().

No functional change.

Tested-by: Niklas Cassel <cassel@kernel.org>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Keep mutex lock because sync with other function.
---
 drivers/pci/endpoint/functions/pci-epf-mhi.c | 52 +++++++++-------------------
 1 file changed, 16 insertions(+), 36 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
index 7f5326925ed54..c3e3b58fb86cd 100644
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
@@ -401,12 +396,6 @@ static int pci_epf_mhi_edma_write(struct mhi_ep_cntrl *mhi_cntrl,
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
@@ -415,9 +404,10 @@ static int pci_epf_mhi_edma_write(struct mhi_ep_cntrl *mhi_cntrl,
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
@@ -506,12 +496,6 @@ static int pci_epf_mhi_edma_read_async(struct mhi_ep_cntrl *mhi_cntrl,
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
@@ -520,9 +504,10 @@ static int pci_epf_mhi_edma_read_async(struct mhi_ep_cntrl *mhi_cntrl,
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
@@ -585,12 +570,6 @@ static int pci_epf_mhi_edma_write_async(struct mhi_ep_cntrl *mhi_cntrl,
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
@@ -599,9 +578,10 @@ static int pci_epf_mhi_edma_write_async(struct mhi_ep_cntrl *mhi_cntrl,
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
2.43.0


