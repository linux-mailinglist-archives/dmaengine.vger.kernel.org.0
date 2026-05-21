Return-Path: <dmaengine+bounces-10678-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FdGJXwzD2qSHgYAu9opvQ
	(envelope-from <dmaengine+bounces-10678-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 18:31:56 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 264D55A9566
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 18:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72F65314BFAA
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 15:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4A733B6F6;
	Thu, 21 May 2026 15:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="R8i2JYhp"
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013003.outbound.protection.outlook.com [40.107.162.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86B321B9F6;
	Thu, 21 May 2026 15:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779377583; cv=fail; b=o5W7e8sBQ6/bxoWDBKz3vw/3nON6pfw4tXwSBK8vaUc9sYENlvOAcoOesh5vaBmCHOD5lYRzFB18JSpkMepoOhVBzy2yMCrO3ZD4V1nhf+Ym020GQReLU/Csnoj2WZ9zTSjyeagq1IN83/U69zKwkm5TkqPj4YniXMGWy2eNSmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779377583; c=relaxed/simple;
	bh=EqSqWNHLCLhACEcfeETKgoqOnqHrUco1zItPj5jXShw=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=d/WhSKJDUDUa9l1elMkl+mxCNxZIsaYatnUZGisUBS4hvrurqCryxUs8ECOf1R29r5RylUPqL/Z22JCuPnizWze+T/fccmnUtXGBY2MmPfmEMi5YqZ3GRttKv9+xFuGpuwJGq2KI/cIOGqjFOaNXRKfYqhG8Asf0cXixQpEnlmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=R8i2JYhp; arc=fail smtp.client-ip=40.107.162.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F5Nyo62mUGHkCH/byYDj6OsZpAzAsdW+47q+8Wbl6ObHwXdltaYfSBnvymfQs4UT/iyj2t5YcNLVl9MwRs7XbMMQmRLmj+QUYsnDPlZXE9LxqpQMS6c43mIW85kiSAEZplCRB9N2Mdt1tEWXHhxRco3V33P6oZlWxqMwldosfqOjIjIh+BdNf/I0JMCPqV3urvGHAZnuksrwxCF51njEJ8OhQdPAXdxpPNfzc7t937dMmHYX0kDMMqwwTqb/eo0+0qyA46epoxHJdu7jg6n4qdU0hzhkCxIAhIOCF5muQ6TO+Rg+nCHMMXg49jBpG6ChqMvrDoTn51agDRtJ4U60+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KRYN+U27T1WRdD/D4LeZl0b9Xs1eyHio+tV1VS8bOIA=;
 b=aR10KNryxfAN5gs2QIf+4LSboet4uAXm0Jtx0xf4fGaEdh4QWSFxMIvJFDOFUQjy+4UKvMFgaRGWoOwJJ/7GXeF+n4SaGyZddO3mzX2/PbdBLNvFZSwoPtDg/KiYOuYZgP0f0UdPhKwg5Hn15Ks0Zbahkt+ZhuM8TG03vPoRXvKokezzVcKXYB7k6rvHH5mRiS1O4ua69VHTHr//atDLHyVuvzPunsz+L7dtsFRV2CXp61fCNTGVzjupLPUeXf6qAaPQc8RySNxleYPchkziVTiCVpG/WzrzSiXi7fmEgSEd+Sf+0vzI49+/SPAA1V9hJXB4z/ASu0arjK3gYv/dSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KRYN+U27T1WRdD/D4LeZl0b9Xs1eyHio+tV1VS8bOIA=;
 b=R8i2JYhpl14EVOT6pEmtHXfD3JbJt5lwq5UVt+7Kl41BbwTMcwmG5X/W6uFZgCy/mawQnYF7eOZGQutwMW6E568G0ukQp9s0Stj1x8vBjP44xLzlsLAyoVloErKm/SB5TZHaFdmEeXJnwxOnXhBsUdDkSyouf232WZGlaKgGI6ExAef7NrPQU13uJsmZFBn0TGcbklSmSuBjxmSiWNk3qf09UCRJmDIDc+qXGHY/oSMem0e7vO2nBtCfD+VoMrgfqa/ttNNAog+b6y/6Ne9LUiBIGxIV9s7BkDp/S5NvVJLfstL7sX+y0eYnCqNA+vIiEYZ3KSkm6pRP6AJ3YiFAUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com (2603:10a6:10:623::11)
 by AM0PR04MB11853.eurprd04.prod.outlook.com (2603:10a6:20b:6f9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 15:32:58 +0000
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de]) by DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de%4]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 15:32:58 +0000
From: Frank.Li@oss.nxp.com
Subject: [PATCH v7 0/9] dmaengine: Add new API to combine configuration and
 descriptor preparation
Date: Thu, 21 May 2026 11:32:46 -0400
Message-Id: <20260521-dma_prep_config-v7-0-1f73f4899883@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ4lD2oC/23PTWrDMBAF4KsErasyGmkkOaveo5Sg30SL2MYuJ
 iX47lUCoTbq8s3wvWHubE5TSTM7Hu5sSkuZy9DXYN4OLFxcf068xJoZApJAUDxe3Wmc0ngKQ5/
 LmWtSwkBERQ5ZVXWXy+3Z+PlV86XM38P08zywiMf01WWbrkVw4CRVB4GSSOg++tv4HoYrezQtu
 NHiH41VBzBgOiu1QLvX8qU1CKBWy6qdVRakxhwV7rX60wS61apqS15GRO98zntNGy2w1VQ1aqv
 JZxM7SXutNxqh1bpq0El13rjg5ebvdV1/AX7zvZXiAQAA
X-Change-ID: 20251204-dma_prep_config-654170d245a2
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779377571; l=3667;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=EqSqWNHLCLhACEcfeETKgoqOnqHrUco1zItPj5jXShw=;
 b=DWwLZm6WsUOL5cnDsS3eLl15w+m104uYW2p3YDHMNPoG8U9MOp8MaIvHBvXPEI2veFit11fkH
 yD4fzzgqlskDt4RzPpuMay9097PKIwVX6TubYMQWSaasOANcVrV1yIE
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ2PR07CA0016.namprd07.prod.outlook.com
 (2603:10b6:a03:505::16) To DU4PR04MB11791.eurprd04.prod.outlook.com
 (2603:10a6:10:623::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU4PR04MB11791:EE_|AM0PR04MB11853:EE_
X-MS-Office365-Filtering-Correlation-Id: 688098a4-50bb-48e4-4dc8-08deb74e3c10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|7416014|376014|921020|56012099003|18002099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	+2Ho6F1+2ijW/O70OlzpoO61gku4cofM6lQe6B8hwNCOTZ6SdMuAXH65Lrim+Pfpu851mg78sGE4jD9539xAnRS/Ue4I2knSsYO/hgdwL6W2zBFVWMWrv4CfauT+Ls0sxWty51zZKW6SZmXNVwFrqnRju6fOkSG06oT+IeycQZ7AlnGSy3ta905rETRnkTn3gZX/YTwtgDtdhI+fodRqSgfhkgqhlyeflv0Nf5fdYL+tsMaeZVJhYgeCJRgVwYX6CpI0dYF8EBDIgITKAjve/eoRqXW+kN8+ZfLLeTADvphRg015x7iLSlQWNLBqT4DdP4HlVAf0dhmKitDTOXj/M8kjimZb8kivVpzx3dtOm2fd0ELkhDbb1tk6wZYTsryS98R6rGTfK1jLxv01DJn4rOZDtFOUw8LEWMzfcJ+gpQ2JpmtmOr26Pa8hBDwBQDfNucHmttrQK2qm6yYJD906WmAOBKwJ5hEggTIRsGcmFQeWt9GbJ/sbmFhrokaCJLa0VCR6FTzhBljvsC5pCPIV8VZOcYQzt+CelS7GXletUHBUIbDTt8nopQqeWQnVLThxbjzEJ5or7D4EcNWpTxDjn/X5gYcy6tdBTmbrkTbOxJZPblyHxPR7H4WVSTL11YJcTIZUWSbMuJ3H10qMrwoKCkYknRJrTyQ/xy6bIN14EN0+95Hp0BPKdH0ZD9mq0hzs
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4PR04MB11791.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(7416014)(376014)(921020)(56012099003)(18002099003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3pyS3c1UVlWdkZURThKcUFLQWRDKzIxVnRlMzJKek9rSmRXYWFESjgwSTFX?=
 =?utf-8?B?TXFRM3ZET1pPTVlpRWlTTU5iREhKSVFaMVA3M0svYkZRUnVobXVieGpzaTdr?=
 =?utf-8?B?Vm56Q0RUbzRCYkN6azM2TG5tcFk1WkMzb0hZMmRLNVkxdHlnQUhHY0QycUZZ?=
 =?utf-8?B?STEwMEt3ZTlmN2IycW5GcU5Qd0N3WFdETElQZ0F4L293N0ZOSHdQWi8xTk90?=
 =?utf-8?B?Rlc5dytVVGM3cGdIemZNdEovRzRCeWpnazBDVTZDQVgycVR2SXNFZ29zdk9h?=
 =?utf-8?B?N1hSWU1lYlVIeGllZThJQ0YxMERJMzA2YTFGYVVtNS96aEUvakpyeXhqN2hi?=
 =?utf-8?B?VHY5RjFpZ1R6bFJQMGNvbUN2VUhpRVN5RXNkQ3hGMnF1OFJYeUlmTytRVitD?=
 =?utf-8?B?VDhUM1Q3dVVqVXo1aGo0c0tDVFhNTmxBV3JBR2RDQytERUV4NWtoN1BpT0x1?=
 =?utf-8?B?ajh2YXB5V05ubDMxUDludU90SlkvVGh1aC9UbmwvdmlkVUNSQXMyMkRhNjVk?=
 =?utf-8?B?bDFmWjNQUGRVWkZVQ1hhcDEzT25XaEtqUG9EWnJ1cEVCVHk1NExtbk5ZTUdP?=
 =?utf-8?B?THhES3Q3YzhMRGlheW1uZ0dmeTkvclBDSXV2M0sybVliNmZhM0NQbmE4UVFa?=
 =?utf-8?B?TUNZMmVHTkZUVU5yUW5DYVNkWU9IR1ZPYlVBRXZNbERLRmpZZ09uWlF5TU94?=
 =?utf-8?B?SXNUNzBqUFJjQUh2OWV2Rk5BcVVtTEtTSm4zQUtBVTFVTXRwUXJ2MCtOeUpV?=
 =?utf-8?B?YTR6ZXpWblRQd3VvY0M4dmlSbGdRM2pxV1BQT1MwSmE2elpJbHB6Rm1zeDFU?=
 =?utf-8?B?TVNQRkpXTmp4OGNCY08zbXoxKzlmMWVwS04xZDRUeTJGUDlkYmQ1OGhUcnF0?=
 =?utf-8?B?RVRWODF2bU9pd1ZXWllpOTZPZVNiQmZDNkNZWmhkdWx5Tk9QalJXTVZZejBy?=
 =?utf-8?B?U3Q1c3I1OVFzL0hLRXk0MkdSNXJIdXgyU2NDL2U1N0QyMStZQ2cvYzFidU54?=
 =?utf-8?B?clJkeWtvUExra05nY3ZSM2FFVTBHdjl3d0twVzNtZ0tmcDhWS1pyRGo3QjFI?=
 =?utf-8?B?enl3alhsWkV4QlVnN0ZuQVRnNkNaRHkxMEhFVnFaQ2xUdGtlK1diRHJqazN3?=
 =?utf-8?B?c2JhSnNDRVZlNnNPUmxGUGhBbWpFbi9VVHhFcmtsY3g3d3JLbXd0ZWowdFNt?=
 =?utf-8?B?Rk1UQTVQREllelFiRG16Q1BCSzI4MmI4cFFMOE40L3JGZzZMMlYvQ0xJbXVx?=
 =?utf-8?B?Q2NRZHIvUWp6RDlUUGF0TkNKdkJqblVad2tjTy9RamVkZGE3R0htOGZna3Qw?=
 =?utf-8?B?ckRibWZTMlExUVM3OFVPZGhPR3R4Vm0rMUM3Y0ZERDRnYndyOWxia1Qvc2hZ?=
 =?utf-8?B?ZytwR3dNZFVxMEc2K04raEJwR0s1aTdkTUsvbStMdklxS3VpdTk1U1MwR1Qz?=
 =?utf-8?B?MGlwNDNkQ2c2aFpLcmlEOEJHcTB5QUZweDhPcFVVc0Nubkl6WDB3OHVBMDFW?=
 =?utf-8?B?UnE2SU45Zk9XaGl4bGV4UWNmK2dMU3NVc2xKblBNRm42MnhEdEtZQzk4R2Fw?=
 =?utf-8?B?ODhEQ3UwRm42WS9ZbFNBcEJHUmdTbGhnZU5FNXpUZW4xVzVrTFNGcTEzajRm?=
 =?utf-8?B?STBSNE04ZEJ2aDg0Rmd3OUVqMU4relp6S1dpQTdvT2tBMmZiUG1JQU95ZUNw?=
 =?utf-8?B?eHEvdkhZd0VZQ05INzVnbWZtK0loRXhibGlwSnU3VDI1ZUY1ZFJDNjdGK0RO?=
 =?utf-8?B?cjlDbllmUngzTEZsM2QvbHVLUWtGY2xxVUE3bE5tUFh2aWtHZ1hvbitPdldp?=
 =?utf-8?B?NWFCbDhNbFB0RzVSUUtHQm5yOHZzSTFrS0REODB1UnoxQUF1YmJpbkI0T2dH?=
 =?utf-8?B?T2FJOVJMRVdlTHU2OCtqSkFCeVJFVnI3Ym5VQmFvbFVjbGFXK0tobzZCMVl3?=
 =?utf-8?B?b0VTUElaLy81VWI3TG1VdnlHNjR1T21heURMQTlDSFl3c0V3Q3dRQ1FJUUM5?=
 =?utf-8?B?QjNGakUzTi9xdVEwb2I4T3RnQWFMemlxNXFkbzNsQ1MvQVVDWjd1b3RJNzFI?=
 =?utf-8?B?SUxLSmtDNFM5eHc3L0hQbUg4V3Z0WTE3K2l4eHlZeTFDYitWZWtmTzJzZWdB?=
 =?utf-8?B?MytZU2orcENNTWd5QkVXVzFpTVFrSE5RcVZSWTVwOEtxUFNQNGxlaWc0cTd4?=
 =?utf-8?B?NWN6UGt6dVRLZnZWcUhSWWJ5aTY4Q2VkWWhLb3NXVEpqSmpxL0Jjd3o5YVA3?=
 =?utf-8?B?aysyZEhGOGRwMnh5S3c0OWo3eTN1Wkg1YkxjdmF4YVV2RmdZYkx6Y3JmbUJP?=
 =?utf-8?B?YVJVM3JWOVh0MnRtb29Ba2NSRkpXWTFUUHpKZzRIMDRTOXRmeVpTQ3IvS09y?=
 =?utf-8?Q?tmhYTDFf6ge167qv7Jn4sdhkdMoGU39nMvxJi?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 688098a4-50bb-48e4-4dc8-08deb74e3c10
X-MS-Exchange-CrossTenant-AuthSource: DU4PR04MB11791.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 15:32:57.9227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LgxAsvb/9A2Xjm7mjfks+o2EJ7KvvOLyzRvJ6PCdaryuHsa6k0da0QxJ9KOLAAprbBImb3vL3zFQLBdlkGw4X4BNL/hpHNTaT1F1grcrcMPrx+Oa2spxbgOIlHgzTqpU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB11853
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10678-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:mid,nxp.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Queue-Id: 264D55A9566
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Previously, configuration and preparation required two separate calls. This
works well when configuration is done only once during initialization.

However, in cases where the burst length or source/destination address must
be adjusted for each transfer, calling two functions is verbose.

	if (dmaengine_slave_config(chan, &sconf)) {
		dev_err(dev, "DMA slave config fail\n");
		return -EIO;
	}

	tx = dmaengine_prep_slave_single(chan, dma_local, len, dir, flags);

After new API added

	tx = dmaengine_prep_config_single(chan, dma_local, len, dir, flags, &sconf);

Additional, prevous two calls requires additional locking to ensure both
steps complete atomically.

    mutex_lock()
    dmaengine_slave_config()
    dmaengine_prep_slave_single()
    mutex_unlock()

after new API added, mutex lock can be moved. See patch
     nvmet: pci-epf: Use dmaengine_prep_config_single_safe() API

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v7:
- Remvoe dma_(rx|tx)_lock() in nvmet totally. (sashia AI)
- Link to v6: https://patch.msgid.link/20260520-dma_prep_config-v6-0-06e49b7acb38@nxp.com

Changes in v6:
- Fix sashaki AI report problem, detail see each patch's change log
- Link to v5: https://lore.kernel.org/r/20260512-dma_prep_config-v5-0-26865bf7d935@nxp.com

Changes in v5:
- collect Mani's reviewed-by tags
- use kernel doc for new APIs.
- Link to v4: https://lore.kernel.org/r/20260506-dma_prep_config-v4-0-85b3d22babff@nxp.com

Changes in v4:
- remove void* context in config_prep() callback
- use spin lock to protect config() and prep().
- Link to v3: https://lore.kernel.org/r/20260105-dma_prep_config-v3-0-a8480362fd42@nxp.com

Changes in v3:
- collect review tags
- create safe version in framework
- Link to v2: https://lore.kernel.org/r/20251218-dma_prep_config-v2-0-c07079836128@nxp.com

Changes in v2:
- Use name dmaengine_prep_config_single() and dmaengine_prep_config_sg()
- Add _safe version to avoid confuse, which needn't additional mutex.
- Update document/
- Update commit message. add () for function name. Use upcase for subject.
- Add more explain for remove lock.
- Link to v1: https://lore.kernel.org/r/20251208-dma_prep_config-v1-0-53490c5e1e2a@nxp.com

---
Frank Li (9):
      dmaengine: Add API to combine configuration and preparation (sg and single)
      dmaengine: Add safe API to combine configuration and preparation
      PCI: endpoint: pci-epf-test: Use dmaenigne_prep_config_single() to simplify code
      dmaengine: dw-edma: Use new .device_prep_config_sg() callback
      dmaengine: dw-edma: Pass dma_slave_config to dw_edma_device_transfer()
      nvmet: pci-epf: Remove unnecessary dmaengine_terminate_sync() on each DMA transfer
      nvmet: pci-epf: Use dmaengine_prep_config_single_safe() API
      PCI: epf-mhi: Use dmaengine_prep_config_single() to simplify code
      crypto: atmel: Use dmaengine_prep_config_sg() API

 Documentation/driver-api/dmaengine/client.rst |   9 ++
 drivers/crypto/atmel-aes.c                    |  10 +-
 drivers/dma/dmaengine.c                       |   2 +
 drivers/dma/dw-edma/dw-edma-core.c            |  41 +++++--
 drivers/nvme/target/pci-epf.c                 |  33 +-----
 drivers/pci/endpoint/functions/pci-epf-mhi.c  |  52 +++------
 drivers/pci/endpoint/functions/pci-epf-test.c |   8 +-
 include/linux/dmaengine.h                     | 149 ++++++++++++++++++++++++--
 8 files changed, 208 insertions(+), 96 deletions(-)
---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20251204-dma_prep_config-654170d245a2

Best regards,
--  
Frank Li <Frank.Li@nxp.com>


