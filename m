Return-Path: <dmaengine+bounces-8150-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A79CDD0AF10
	for <lists+dmaengine@lfdr.de>; Fri, 09 Jan 2026 16:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 768B73020C1C
	for <lists+dmaengine@lfdr.de>; Fri,  9 Jan 2026 15:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C551F363C57;
	Fri,  9 Jan 2026 15:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="c01nG1m2"
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013063.outbound.protection.outlook.com [52.101.83.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858F8363C45;
	Fri,  9 Jan 2026 15:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767972544; cv=fail; b=quicJYQ5sQYenK2oiszcgNem4FpRXK+/F3M3e0NhEXi8/xMPj1okFQ/8/5IZEjnnjW2u4lkKGJUVh8qGxPs3kTsaPi+a6viqKz5ZlOoidwdBjSy486oYx7j/iPIIgJ86gt3mtztf5U2+/T08qJqWW8GgaMBmTAY4c6S9ojv2C8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767972544; c=relaxed/simple;
	bh=Ee8HiqhZVyhqwGOSxl3X+NNbfup5c8f2QFFTSVFP+54=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=RJDFvvVmf+jOO6k7cPTzrF1Wj8/ZTHY72z/BA4rh0qupMRX1LQTexXY5Jc8LIMHmHxE9Mc8wPYRx9rxPjofPm+nDybQ+CRb0OVuqqWHeotlowZl638j56wUHFeJHXbb7h+6pJQGrb4lqw9jZh/GVU/zhUrO1/HrvsEs/COfFouQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=c01nG1m2; arc=fail smtp.client-ip=52.101.83.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gLssE+uYq5kqHkwFPgsUCGF8O5aqCrxUxOZSazzlLyF7eEWbje+n/FbhjgJfGhU+q/TNYEJnvxKrbT4NiALmDjr9bhhH2T6tzqzOVr+xvO7Cv/+Bop639nKk4it0trBVKhygxWI6CIMwyGnsALQ2bH3nMARqv6XFPRbKUaEaOjVCNX3gcF7QR2cp1qax3ac6YAAGmUW/yY2j5SCjBKjMBlzNRVnewTt1nnCVgpiPAhypwdssvnlQC+5XUfWTKPuSnbIyBlIU3GRyZjWSxWVJyc4fygC3sf+dVqyI4nRTXaWEnxASK9iNNX+RUk/gEBT0k/1DqjyGGcIOCaZ0KfjaDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQA20LNG7+et9xWe1UisxhvgvcTKC8YogQGNwTftR70=;
 b=Tb3QhlfiOBipUE94cPFwe3XdT11DXE9Mrz8TlUBq7NtFvfc9NzQzGzVngFCgwjlJzPAxi/+L+RVuGQ5qic/EmXsi1//A4HVVzJXmNY/XP3v1jFl9MfF7aP7Yj2qQvQQ7V7OB8jR2nPoWLJdNeZx7H5K8eSf/IpUbtGeE4yfg0+5eXmkmwp9g6F9TO3JR0Xf8ga/XsjEItgFeBlW4C5hkTCfSccdthI8rhkwEvMA/lcN7YJLgQ72Md5rNJn+A9vvd0ThMIVHM8tvejiAYt3nYzVdowoEpGqBwqkEZ0woZMtFsPJUCiaFDMODthoUgle9tUv83A4Uml49owCn6i+1GVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQA20LNG7+et9xWe1UisxhvgvcTKC8YogQGNwTftR70=;
 b=c01nG1m2aZWeNoI+vUGE53JbyNACf4014KM1/ybFWjmEW0tynrYJrwVHaQQ8Eqi6XnGzUNyg0LOQ7VKNuDF1uZUymZWHl9qCWNDbM4fy1U4REfGktJsm1r4XF/MW4lHAKszDhvhsxr3X411bkvTyPxe4UMizGTBD/x7MgNsJRWhSL7tlSAIxFZeG7tHU0GHKmlmNBBtrraamIoasPx4Kthmye62jOE1DFQzv4aH5UDDYKUmpx5Iq5n+ccV1VY/9dfgfsEz2YUH8wcpAKsj9Gi+AUYw7kf0HrSWsEzdFvnZlMRiN24gh2opw+7MRYmWSElgn7ig1hkXfIHBQ6N2JJrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8957.eurprd04.prod.outlook.com (2603:10a6:102:20c::5)
 by DU0PR04MB9371.eurprd04.prod.outlook.com (2603:10a6:10:35a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Fri, 9 Jan
 2026 15:28:59 +0000
Received: from PAXPR04MB8957.eurprd04.prod.outlook.com
 ([fe80::9c5d:8cdf:5a78:3c5]) by PAXPR04MB8957.eurprd04.prod.outlook.com
 ([fe80::9c5d:8cdf:5a78:3c5%3]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 15:28:58 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 09 Jan 2026 10:28:22 -0500
Subject: [PATCH v2 02/11] dmaengine: dw-edma: Move control field update of
 DMA link to the last step
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-edma_ll-v2-2-5c0b27b2c664@nxp.com>
References: <20260109-edma_ll-v2-0-5c0b27b2c664@nxp.com>
In-Reply-To: <20260109-edma_ll-v2-0-5c0b27b2c664@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>, 
 Niklas Cassel <cassel@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-nvme@lists.infradead.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767972522; l=3587;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Ee8HiqhZVyhqwGOSxl3X+NNbfup5c8f2QFFTSVFP+54=;
 b=+/VfuBRPihJbNiL5i71lNUfTIdc3UcXtKb5WCUAviwxtolbwKxe8jn2tCTjA0SH2pM2SL3JXf
 p2Uo7EY1d5XCfhV4OoO9nuiBgbZU6V0wjl4zu3ETljnlUIS90tJ4qrU
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR01CA0069.prod.exchangelabs.com (2603:10b6:a03:94::46)
 To PAXPR04MB8957.eurprd04.prod.outlook.com (2603:10a6:102:20c::5)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8957:EE_|DU0PR04MB9371:EE_
X-MS-Office365-Filtering-Correlation-Id: ee7dcc18-663a-4322-bb44-08de4f93cf0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|7416014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S1VlQ0hxZkpOdDJWY1gwdFdkN2h6SGgvbTlzMXRNVTViTWlGTkJ0Z0gwM2FV?=
 =?utf-8?B?S3VINFlLc0JndkF3RFhsRjQ1MlJSWWk5dUVteWV2QTBYaXc1TjRpa2ZTTzZQ?=
 =?utf-8?B?SWtrcXlUVC9TZCtQSEkvblUxOHVDeEJrajM5V1VjMVY0MFNkR2lwQUppV3Ux?=
 =?utf-8?B?dkdTWkFGazRSL1U2YmdMcml0UVViUDdPVmZMQmc3Z1dtQkp4ckRtbStsV0w0?=
 =?utf-8?B?a3NyZFhEZVNKam0vU0puUHdaV05CNFpGWjFqU2M4aDZmckdmcVZQR2lVT05k?=
 =?utf-8?B?N08zV25neDBQVWJ6a0FVWXlOUmY1VjdKRXVqeFZlVE0yZXFtTkNkN2NJYVRE?=
 =?utf-8?B?eGhwOE9hTVdSdDR3TW9OYW1WUjE4VW1tbWN5d1ppeUR2MTA0LzBGTFZ2anBR?=
 =?utf-8?B?RlN6cDFldXAxYk93UTI1VE1LdlZJdTBtY2tGT3cyczBmWCs2T1ZvZWdNd1M1?=
 =?utf-8?B?NWpBaVcyUmxuTWlwUUVncUYvYS9LbjZ6S2FYRThHdGVNb2crYzU1U05UTXFO?=
 =?utf-8?B?OER3cldzM055aEZVQjh2RDNRV1dBQ2J1L3JpY2FtcFE5Y3Z2eUZucmowd1FX?=
 =?utf-8?B?UjNmeXVmZmRka20vYW12S2c3TmRXakQzUFpIWXlBeXRNSVpmK3ZxQytNeWhN?=
 =?utf-8?B?aitCcVhicnBQNU5WMC82M1c0T2ZwSnZzQTFROXF0NkNQNEdhM1ZOdis2MnhJ?=
 =?utf-8?B?QTcyVEd6SzBOVEdsSXVOTnpPaUl4QWpDZkJTaUt0ZUJ0bkhyVk9lMndxZXJw?=
 =?utf-8?B?R05EWkFMS3Z5ejZlTlNCMEQwSkM3N09ZZm9pTHlTU3l2Y05OUS9uanQ5dzZh?=
 =?utf-8?B?TGdyU2FDUDZiOGJ1NnlwVkw5clV5TGF6bGFjNTV4M2JlY0RIU0RpRlFweFh2?=
 =?utf-8?B?Nm9BVGkxaVNGUGQxNmltN0w1Wi9Lazk1RlNmRzJjL1ZsaGgzTjgrN21ETCs2?=
 =?utf-8?B?SmhsV3lMK1drRVdvSlNWS2lXSFVob2xaZW1INk9zNkZRQXZ3b2kwU0RSVnVU?=
 =?utf-8?B?cjRhVHlWcTRjR2lHR2Q1dTJSTkw3ZGlyNUJvaG01RjRaTXdqV2VucldLdDN4?=
 =?utf-8?B?ajdSOVVDT0dPNlR3d2w1YTVpY3NDcmdWVnhKRHBKQTBZUmZzK0p0RjB4R0FV?=
 =?utf-8?B?ZjhaRXh3MzlFMU1xdlltOVhXOFpMYmJ1VCtFVUQrNDlnOFFnT1MvY043U055?=
 =?utf-8?B?WWZPWHM0YWdULy93dHpsbEg1RE9FZW5hVVVwQ1VaK2F4bDc1RitQSEkwNmlC?=
 =?utf-8?B?SXVoQjE3QklGQXNFRjFiS2g1UHovN1J4VG9yK00rcjNtdHhNWVJaZFZSRVYz?=
 =?utf-8?B?Mldick55MDZucUpRSThIeUpTblZiSmF5b1hyMjYxd1pRZmZnS0xIUEY4OWY3?=
 =?utf-8?B?OVZzNXloRzZQUTk3NC9GQUF3TVJ6eXlWaVFhSzlSL3hvalUvcXZjaW5UTmFh?=
 =?utf-8?B?T2VxNXJaTjZGZ3piVTRoT0V1cGtPalBFZkYva09TM2Exb0x2M2lGUGlxS1RM?=
 =?utf-8?B?TnhqSFhwc2RPTjQxSFpJeEhBWDlEVy9naDJ5eWxjalNOVjB6MDdVU1hvRVJi?=
 =?utf-8?B?a1pmNlFaNHQ1YnJZcldmT1IwYU16VDJLYmF5clpocU81NWgrN0dQNzJlSUZP?=
 =?utf-8?B?eE54OUxHWTlLZ09NdkRZc0hNV1FYaWVXOXFRdWZEQmV4UGZxOWRNM3BOT2kw?=
 =?utf-8?B?dXdFNjdwd1pwN0hPenIycVpURnZTS2tSbzlZWnJpaFhIakh5L0I4RFowbE1i?=
 =?utf-8?B?Mjc0QXU4ck9pNlRPcGxGQXQwLzhuYUxmak1IVVFzWm5yTkVYWGc1WDc2dS9D?=
 =?utf-8?B?blR1OXlwbmdZWFVyWTc1d1NrVzNHLzJGR0M3b0p6b1ZVYmh3TzlVL09iZGpX?=
 =?utf-8?B?VllKd1R2ZGVQZnVSV080Z0hQTzlleU9TNzZyanBmUDBuVmg5N2tyNEZqb2NG?=
 =?utf-8?B?U2tRQXhZL0hGNVBiRnltVHZSZE5DSzE1ZzZSYnhkNjBjdFhPK3lBNnBDN3hG?=
 =?utf-8?B?czlYWXNhL1RFRUg2N0Z3cGsvR1VEblIwOUw3MUgxNW51d2dWdElzajFEUnc2?=
 =?utf-8?B?RTc5T293WmovNkhwV1NzcXlQSXhrcEwvZFhqQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8957.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUdqakV4bzAxRks4djFkVytGdFRGQ1Bac3RoTmMxUERrNm5MT0w3VTV6VFNP?=
 =?utf-8?B?QnpOTGVybU1HUWJIWldLQkR3MnZHOHhDVTkwcGlWbm0yWUVNUkN0N2Q0NUhJ?=
 =?utf-8?B?aVJHM3V5VGg3blI0K253cmxuWmcxL2VmSGgyTlhrUjMvcm9YNFp1dTNvUVJ4?=
 =?utf-8?B?SHUwbE1uUFBqbEFQQ3BqZDExQm1SenJ2S1VBNVRQMGpKK2wvRmpIRWZlTVE4?=
 =?utf-8?B?dlpWdC9BUWVIUThrN3IvQ1A5Q216MHM4Y2RnVGFMTDFlZTR5alZzRklrK3FM?=
 =?utf-8?B?NElLWVJ1QWlSSGdmcWl2anRlOVgvMWFrVVQ0QUFlVkZDTFNHNEtNd1d3aklU?=
 =?utf-8?B?RGdsWXlmR2pVTUpKeWd4V1E5eTBBb1plS0hlT1h3STVNYUtkUGc1RWxWa3Zr?=
 =?utf-8?B?QmlQcVdDTWh5Vk1HNVFTSXBHTG9zWUZoUGh3RDFWeE9mZVNZZjZxelB3c21V?=
 =?utf-8?B?Wm1sMkZ0SUM5aFdibDc4cnk2bWFCMVZXbnpMZnIwL29QUzYwdXFOTGlac253?=
 =?utf-8?B?UDJETjcvL0pHV3cyM3M1YTB2SE1mTDhkcFA4c0JRMGphYm40Nk1IUzNwLzhz?=
 =?utf-8?B?Wk4rdEs1Tmk5Rnc1Y1kzdVV5emJoL0JQMTA4K3hWenFGSnBHcnBua2lYOGQz?=
 =?utf-8?B?NytWTjBwVEdNN0RVcE1nSWorWkQvNFVudEhVTjIyM0kxZ25iczh5a1JDb1Z1?=
 =?utf-8?B?cU8xK2hJb25XTGl4YS80ZjhhYmNTRW1ZLzFtTVVEeGRmVEpkdGdNeGg1bjZ6?=
 =?utf-8?B?Z2tGTGNtUGRoWUxndFNMMEhtMlBadXNDSVBocWpERHVUTGNia2dwSHVYRFow?=
 =?utf-8?B?MnFNVG1WV1RCakFFc05TcUwrWFMyZzJHdDFSQlllSThDUmh5QjF0VVQ2TUlP?=
 =?utf-8?B?RzRYWi9SSDJMODV3MFErL1dLUFQrMTZ5TVNGcVNoTTl1dGdzakNaemZxTlAv?=
 =?utf-8?B?NVduaVFNNDFzUDM0Qll0S1RTamUybjhNWjFhUjUxWWZ6R2lBbWxaRnBsYWV3?=
 =?utf-8?B?ODU4akZIQ0NFNHhURlQycnpVZWtSL1NBMEM2VEE5WDIvNUY4eXpDTWJZUHhj?=
 =?utf-8?B?TjlnV0hWa0p3MWxBdnF3U3VTNXY5a1FYUDd5WmJBOEwvMTRTNytqNzJ0bFVj?=
 =?utf-8?B?bktFMDlkNW4yNUN4T1Z3NTFaUk5MV3BjdmIyeXBpaUc5VXhmaS9hUkZhRWw0?=
 =?utf-8?B?NGFENU9neHZkYXNNdWk3U2tZNjBZdUdnaEhFdC9UOGlSelR0bGlnSlc5ZENl?=
 =?utf-8?B?dTVmVHoydXRlTWFFK1YxOXBUOWx3ZUpBU0ZuTWl6ZnFjZVR3dHZ0amtYVTRJ?=
 =?utf-8?B?OWtkTWtmVE9VcHhMTnZzaW9QSzlBSG5OQzRnNmh1djlFL3FGNFFESGxQTjBN?=
 =?utf-8?B?UGttU2FhbjhBSGtVWlFJYUVzeVhRYWxNN3hOYlYyQ1ZGaEt0UDRCbWFBWHpM?=
 =?utf-8?B?akUrR1lxM2hLSFIwOXBqTzNUSDlQcUoxYU9XUFhsMzlRM204OHBBMlltaHM2?=
 =?utf-8?B?bDdkVHQ1MFdnYkY3RVBCRjh6QklhbFBhcitPSjlTdmpZTGJ1NjZGby9xU24w?=
 =?utf-8?B?MVNXRU84N0I1STNYT0VNaEQrV3VRRUI4emE1LzFOb1hhVmVNalRiZXRaMU1H?=
 =?utf-8?B?QWRDOThxRVJtTys3dFVGcERPWG92RlVlTElWdFJGYU5ub1JGVGxBdjF0ME9T?=
 =?utf-8?B?ZGZ6eHoxZ3V3cTBncWNhdUVOeFVZTmdGamh2Zk0wcnl5MHFxblpOZzg2ZkJq?=
 =?utf-8?B?L1M4dG5HaGx1RTNnbUxKUWpKWlZmd2d5UmVDQWlwcloxbjRaRk8vNEY0dlY0?=
 =?utf-8?B?bDVUREV6QXJnWEg5cU0zM01oa0duR0RqTk41cmpQRFZXZU9MSWtTSk0wckl5?=
 =?utf-8?B?TTNlbzRML0g1QWh3ck1ic3BTYTd0Ump3YU9mbjJpc3Q1cGRJQS9hbmVZQzBv?=
 =?utf-8?B?TzRBUWdmOVBMUjV3M3VmVFpJR3BRMWJzckZjbmtLSEZsb2pTYkl3azl6OGNs?=
 =?utf-8?B?b25sSURQR1pCMk1pVEZKTUxnVExYZ2JzMVpDQUhub0E0Skc0eXdRQ2lCMVJs?=
 =?utf-8?B?cHhCMHpwUmZSQVQ4YkdydkNmdk5QQVlObzJ1dVFaNWdCTE0xV2J4cFh2SWtE?=
 =?utf-8?B?WlJrdmRsYW1vSnpoNHB5UTArV3ROTGxoTWREVXlNV2dqSmg3V1JEM0NhWFRv?=
 =?utf-8?B?Y0t4Q3pTN3RQOW85SVdKOUZOcmc5R2w1S3I4TzlobWJzbUYvTG1rcWlkZ1Fp?=
 =?utf-8?B?ZjNOdHpQelUvZXJZamtVUDBaODdEcVFBcTZxNFRPaVR6a1RIZllyM042VGRH?=
 =?utf-8?B?MnIveVNvMTdQNVZGNzFxK0FoYndrUUJMTStxVzFSOWNIRWhSR2ludz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee7dcc18-663a-4322-bb44-08de4f93cf0b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8957.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 15:28:58.8212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vcx7Hv0NCemT1CpBu1W35yTedm/2wqeR5NGktv77PZQb32P0tfmd/4HxGDrHUeRFPjG5f/+h2JgCxbzCg90pxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9371

The control field in a DMA link list entry must be updated as the final
step because it includes the CB bit, which indicates whether the entry is
ready. Add dma_wmb() to ensure the correct memory write ordering.

Currently the driver does not update DMA link entries while the DMA is
running, so no visible failure occurs. However, fixing the ordering now
prepares the driver for supporting link entry updates during DMA operation.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/dw-edma/dw-edma-v0-core.c | 10 ++++++----
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 10 ++++++----
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 2850a9df80f54d00789144415ed2dfe31dea3965..1b0add95ed655d8d16d381c8294acb252b7bcd2d 100644
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
index e3f8db4fe909a1776bb5899e0b4c9c7a9d178c05..f1fc1060d3f77e3b12dea48efa72c5b3a0a58c8b 100644
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
2.34.1


