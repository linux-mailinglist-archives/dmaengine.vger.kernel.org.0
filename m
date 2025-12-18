Return-Path: <dmaengine+bounces-7809-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DD8CCCAB6
	for <lists+dmaengine@lfdr.de>; Thu, 18 Dec 2025 17:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A69E2307D35B
	for <lists+dmaengine@lfdr.de>; Thu, 18 Dec 2025 16:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9343570B2;
	Thu, 18 Dec 2025 15:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IHfi/H/Z"
X-Original-To: dmaengine@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012010.outbound.protection.outlook.com [52.101.66.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D46E3559E9;
	Thu, 18 Dec 2025 15:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766073430; cv=fail; b=XK8BhW005O0AsVgnEdDDS2P8JOkJMCRHPt0+WzbN1EqsdI6XxQspY8PaT/He9OljCHNUpfjQJWyu6dIuiFWYsQ6vuuJM1IoqyRCbW35mGN3hSgL4wmkLhzRNH1CAR2z/6rG/pFW/zQ63jTcEcTG+q0NbnYAwWN232cbN4zcK0jw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766073430; c=relaxed/simple;
	bh=nxyMYRFpqLMceFvkP3xrvPMquEbKBxsILsn5+eXX/u0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=PY7Dn406XLzVZNdQxxKNRQho510WDTsb5P4whF/OuEzjRzE8ZH3cGBvMobB/sYiiCw2q4uH6GkUpviwvbG1DEEXrwq1OjjkBt27KNhYvG3ISnY6F/TXjNBP39FTlYLv2r/PrJVMQ8FbuhHH8RJyDpPOSYGZcPAH53Q/yrR3Q3jA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IHfi/H/Z; arc=fail smtp.client-ip=52.101.66.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lf9QP0jNwlKZCWCeV9QJyXaIwGIkKZH4jOCYtz4hsr+1LdfI+GEhBiCCXosVf40h0B+SEGHmmi5IdPSH2A4+xs0kA4giOchXmCR9sOQwfeDjqkMMyi50mPCDBsl29cXTybvktjD5/8xEvqeetQ/tZbSpDyXvrP95oaQ8Yr0fwfToa3bHW4uNDpLDgQ/9WKXOEGjN6w91hiYBZ3eDt6CoDa0SPDab0CNCyJDxKLh1s1S0oNciwkpbrq1PPUP4Za8jD7hNbQeQclVMuStk28nbw/64O6Lf6+pJAhOgSDwihFUNYLVD2n3Hfktl02Ueo7i7/FUuN58j9P3qjuyCwK5jvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQjf/nSl5p3ekFNC/NxGppsmn3EwVK4fxx0mNazpZ8I=;
 b=oEMpRohFkPfj+hzu2pM/xJIIcpIuEtfveFSDOht/SphvTLmb4pfobF42mtfPukXk24oCVNRiPoOWMDgOTZgMHpgr+Xsc8DvGd3vHFbpm9beKuWJq9xwCmuWA/yKd/5XUoNxKl/phzWR2GMvsafrqiomeN2sgs+epI3c1QNkfWAOCIP7ri/ZpSBzyshY2cnIj4FbBkyTM44IdovNLxOFCFZYk4kNt5dV3I+LXUTybStjTudjtiCFfmD0mH7/RwlS+K3jBmejCujn3tuka58g2EaERl4SYOZWgzWR854L8inxvpQR0/lXM2wG5z2Wzr+zz0SDlbuyAKaRFJABpGh9XUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQjf/nSl5p3ekFNC/NxGppsmn3EwVK4fxx0mNazpZ8I=;
 b=IHfi/H/Z4LphbmwN+c4+MRjUVdBeo+NNXA+J1WHtTEKrULC4zmgrQqlZwoTBLuIzEiLaIFT4vCfKZv7Yr72roN/DD5w1ZJehzm978zwzB8VeoXwTv9y/eyyKT+5x4X0qykNxxtEMK098N5E5a2Zfyho1mV+6zTcUkXiRWriYiux+h6HyozXb27SjFzJIQ0TfdurvkkYATV7nBZpYvDEmn3OSzfUbYIM3KqDyn7MXzkarBEAYQskkAfGCC+aWUm0Imt6U+xmK2Kg40V/XgaMc55vJBTiNzd6NBuUrUE3e10Ys1IOuhxSL4zs5cHi0dibz90CY7RnCXy17OdPQsKeOqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by DU4PR04MB12130.eurprd04.prod.outlook.com (2603:10a6:10:645::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.8; Thu, 18 Dec
 2025 15:57:05 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 15:57:05 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 18 Dec 2025 10:56:26 -0500
Subject: [PATCH v2 6/8] nvmet: pci-epf: Use
 dmaengine_prep_config_single_safe() API
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-dma_prep_config-v2-6-c07079836128@nxp.com>
References: <20251218-dma_prep_config-v2-0-c07079836128@nxp.com>
In-Reply-To: <20251218-dma_prep_config-v2-0-c07079836128@nxp.com>
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
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766073392; l=1861;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=nxyMYRFpqLMceFvkP3xrvPMquEbKBxsILsn5+eXX/u0=;
 b=JkhXNLxraVjHm6eSLbdxpXxWrHdaGTRysL7yFqELJqU9p9p7mpk/5hqkDyqQPqbreJ6GvNB4a
 izc7wwb193RAo+9X6F3/s4uJOEpzAivGAho1p5nJhBBgh/1tXwjSLRP
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH8PR07CA0047.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::10) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|DU4PR04MB12130:EE_
X-MS-Office365-Filtering-Correlation-Id: d096fbb6-d576-42c8-d26d-08de3e4e1774
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YnYrUExmOU9pYzhmMWdrS0MxRGE2blNZZTVxQStkU0I3TTN2VXllQnhPWUdt?=
 =?utf-8?B?QWpSdkMyTVZOcTRvYndqald3Sml0cGhPL2hBeHR2bWxyK3J0VlhCTE9YL0oy?=
 =?utf-8?B?Mm1laWl1WGFqN0xEUmhSVFo5MFhIdEhZM1NjWmpiSXZ4QUFYd2haODlVSG5i?=
 =?utf-8?B?NXhvUWkvdEtQSENzU0tmV2NNb3dtdG1DQVp3T3BuM050RXZzMkJMRFo0Z1Nz?=
 =?utf-8?B?WjVOallaZTRQck1kM2RJUXlJalVZWVBpVDNSQll4K3A4NEFxcmFUdHZlejhW?=
 =?utf-8?B?dGkwRHVJMSt1SFVpdDAxT3NVZmR6Ym9QVGsrcks1L0JHOEptNVdWcDNYeHZR?=
 =?utf-8?B?ekFTUS9jV3BCaVA3ekphT1NoYU9jZUo1S2dPYm5mZWR2dW15dXBldEcwTjg1?=
 =?utf-8?B?ckVvRmNXVWdleWlDK0FRR2hPRWgzeHIvRklGQjV3c012RW9WdlJjOG1qWDBD?=
 =?utf-8?B?cjg5Si9jTzN3b3hyVHVKY0dnaThicFNudTE2dTF2NUdUMG93c2ROUmFsY3pJ?=
 =?utf-8?B?c1FPWmtXMUEvNnRBTk04Z1JDVmVqSEN1MW1qSGRQNFkzK0dWakZTd2JTaWRX?=
 =?utf-8?B?SklrUkcxNVVVSEVqZHdzM2U1aisveW1XaGcyTlBsc0UvYjdmV0h0b1VhUENP?=
 =?utf-8?B?enFqMXVnTnNkd011QXRwTVpGa1lBTWgrdXVQOEpOZ2dGWHVkMGRodFl3cjFS?=
 =?utf-8?B?VEpXZUpsTnJ5cVJCNkkwSUJub0ZDRzZzTlAyNGg4alVGMVpJUnVCYUVaNk9m?=
 =?utf-8?B?ZS84MG1aVWkyekJwT3Z4cGY1b1oxMTRxdGRUOEdJRE9VSjNPWXFvTjJXY3Qr?=
 =?utf-8?B?V1pwYVpaVGlDVjhMTngyS2JMQVRuK3RkMzVRTGg0TmU0NFFuRHUyMy9GNnRE?=
 =?utf-8?B?UkgvWHRXWkhyWmkzVTJ5emMzenJ2NU1NZlA0VWdyeU10eUgvNTR1WStqM3Jk?=
 =?utf-8?B?SkxaT0cybFEwby92OWptQTlNWGtyOEJYV2tGdFRqOXJiTXVvMEE3RFdvd2Ix?=
 =?utf-8?B?bVVMSnpmSVBYQVhGVmVJU0VvcTdSRG9QQVU5RHFqT0lYOExoNWIySWNLelUy?=
 =?utf-8?B?RkJnRXlLaU01Qjl0OXVvSXEyR05qNEEvWmxBa3pQL0NRSmE0Q3Z1dTlnb3B5?=
 =?utf-8?B?TVBxZ0RTWDBzRDhKSFJKZkxsWkRJUlZDVGZrbjMyakFNTHF5RVNDaHFDT0ow?=
 =?utf-8?B?SllGa3FiNVZmMEpEUWsxV0xPcUthMVl3UXBxajhpNEVNdTY3ZnNJT3ptdTB6?=
 =?utf-8?B?b0pXVXZKdjVpOUp0SWNEaE5OTDNuUThMc1IyWmIxcnhzeGgrUXBuMWxaYkVa?=
 =?utf-8?B?b0w3T0tHNGd4RU53dUI5UHN2a0tZaWxMQ2NXVDZ0VXkvSXVpWjZTNUhuSGIy?=
 =?utf-8?B?N2pOWXRCT3dBQXc4VHJWYWx5NE9OWmZHWUcyV1RpeUNKZGhaZ2xuN0tzWlBl?=
 =?utf-8?B?VnoyT2dXcjdVcXNISE5NdzlsWWg2eERCUEpTYWQ5M0tnbnRWR2kvZzQ4Zk9w?=
 =?utf-8?B?NEdsZnNqZFp0T3NDc0dYRHFHdnVhMzdQcGFyTDRlc2xqVlJqLzc0L3k0cnFk?=
 =?utf-8?B?N0dQbUtwTDh0bDVVcHd2N0NxNFJiZTdLSHNvRWk0OG82VUJXOUlmdXgvQyt2?=
 =?utf-8?B?T2QxR3VFckVBc2xsZDQyMWtuVHlhZmpWT2xBMklGOW5JV2MvQjR3ei9OdE02?=
 =?utf-8?B?OXRnbmZtbWYzN2VBTUZRaFNSRFJtbGtNd0pYek5QNk1RRjN0dXYrVGdwdFda?=
 =?utf-8?B?VkdXSzRTd0hBalpzMlErTDQyM1NSdmpJY0VJYW9aZXVIN2p3eHVNWnl6cmk2?=
 =?utf-8?B?VWdWZWs2WTNDNkRRNElOdkFocjBpOThCajZ4YzhvdFpFM1YwY0E4MjMzdDhl?=
 =?utf-8?B?SlJmVVFIbDlxQ0dWOHlCS1hqazNnYUUxRmZTK0NLTFJBT1BHOXkzVnhuVnpw?=
 =?utf-8?B?bUlJWnNqMUM0SUNVUHVKV0NWVjBpVVY3Y0owdi8vcjAydzFZSGUzU2lvZVdZ?=
 =?utf-8?B?ajdrOCtvdlBMT1pCTytuaGdiQzhBYm9VVjV6c2IzUTFRM25jbjlBWXBxdk0x?=
 =?utf-8?B?UW1rNnJCb0lBYXBWTmlTWnNaNzRMVzdScXRjQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGIyVkdqRzFxYTRPYXN2Z1o1R0tCcWtLRnRaV0RYTDlhcUNhazB1RkdBNzdt?=
 =?utf-8?B?b2tvQktZbWFEdzlKbWk1YzQ3RE84d1h6SWR6Y0M4bUcrR01zRmkrVHhNMnph?=
 =?utf-8?B?VjBZcGJjLzhIc2pmVGEyRkxPcVRnU0hSVUNnRXlKNHgzRmJGQ3pFeTJFTGpa?=
 =?utf-8?B?Ly9pQkVVUDFPNmFieWY3UUJ5ZDRHUDM5Zk5nSTJncGxqRVcxelRNdkljVHAx?=
 =?utf-8?B?ZUJzTzhUZFU2VG1vZUtXdC9rbld4SXBaYlhPYWM5YWNLeVVHUzhFSXE0VjR0?=
 =?utf-8?B?TVJmYkhVQ3dPa1ZhbkU5b0dmbWVrK0dpbEFQMUlJWis4ZzZOZ2p0YkpRQ2tI?=
 =?utf-8?B?S21acmh4MU0wR2laQkVmT2NYWFdOSld6NEZpbysza3V2blRVOUFzVktKTk9J?=
 =?utf-8?B?dG5lYTMzdXd3c0tmM21oZWFvUHY0ZkQ5UUNoeXVOdE9pSVRXL0RVRnUxSmFk?=
 =?utf-8?B?a3FWL2VpcGxDM3MyVzhJL3RpRU5EYkI4a3RXQStTKzgyenJoNjFEbkdDT0sy?=
 =?utf-8?B?emJ6SzR3Ulh2N1VDMm5UeU1ZWk5LR1NHcGpkNi9TQVVHdEU4eEZQN00rMUVM?=
 =?utf-8?B?bzljbnVHZkUzMzk1cVRHMXFEUGU1djB3S1VSbHRraHZwczRrV2J4N1dnM3o2?=
 =?utf-8?B?S1JJNTFsdncrSDN6eXVOT0NOa3FTSkFITFJOTlljRTd6SkJldUIxRjM0WDFV?=
 =?utf-8?B?ck5nUG1pcEZJY3pFUGFpMk1ZNmxJNm41Z3JMOURSeFJBcDhKNWhCMkpIb000?=
 =?utf-8?B?QU9UNThjMTcxTXBXR0xNQTdQRnNJZkhaSm1TOWJSYW1jZlhwMno5UWo5am4v?=
 =?utf-8?B?T2o4Q013TTdwbU5naFdiQ0NnZ1lSK0JGcG9CWXRtbDFrVGRnM1ZYQUJUQlRZ?=
 =?utf-8?B?R3lDOTBZU0RBbUhUc0wyMytZTGROT3R5QnZvb2x2MmZiaFNFd2UzTWNVamtH?=
 =?utf-8?B?RFppcVRIdy85QzBDZjArbnozcFVrVXg1TG9jYVdtQ21lK1BNUTJBa2dGVG9V?=
 =?utf-8?B?b0Vzam9vM2gwdW1vQXZiblgxNnY5ZXJFWXplRDZhUHVrMnowUmk2dlBESDgy?=
 =?utf-8?B?S1BwWlRwSTNJaGt5Q2ZaUnl3L3RhY3ZqdStuaDBnWlpEU3BnaGo4Rkkyb2NP?=
 =?utf-8?B?Y2h3T2VTU2NCL293cHd1eFN4enBKQkdBMWZLbDJpYmgzS3UrS0l1d2prMnBh?=
 =?utf-8?B?OWxxWDdQZWF3U3Z1dTM1SFFxY1BnOWlBQkk1UjZSS25LVlJQYkRraGZ2K3Z1?=
 =?utf-8?B?S2NCRmk0dGZDN25wRjBHL1IzRE8xUCtlSkxTL1JNUFN0bkMzU1llVzZvOUtR?=
 =?utf-8?B?ZGVWamlSNjYvNFhUQ3B0K2UzRnd2WkpmY0g1RVRaSkNEUVQ2QnB5YUgzYk5w?=
 =?utf-8?B?N25KUXhBei9xWTNLeXdzWDJYRnR0L1hUMi8ycG15Zk41bWwyZnVRSFFZQ3l5?=
 =?utf-8?B?dXZrRWdJc0lnbVp0RjY1SDNPR0MxWmZqRjZxTCtqeXYwSU5RQXcrKzdSQXZC?=
 =?utf-8?B?Z2JyZ1F3ellLWmpxbDYxTlgxdlhPU1AwQUIrdnc5SUZJZ0pKaGRheFArYjA5?=
 =?utf-8?B?RUh1RDBJblBPN3UzU3FRd0FERlNSb1MyRzhCTDJ5UTdBMnVFdk1ValdCT3JG?=
 =?utf-8?B?QjZGMGd0eDJOZDgrUEVJVy9zWS93cXlVYTRRdjVpYWtiOWRXdExWeW12RFN1?=
 =?utf-8?B?OVExV013cm9SdEJTbE9mNnlWcTRFUkpUUjlXWGRvM1BUa1kwQ0tMYUk1aTdV?=
 =?utf-8?B?K1lpbHRpTUR6Z0pOOEVIb01LNFFCMjdJU0lnZDJGaXVUNW9GeXRxM2w0YzFa?=
 =?utf-8?B?VTZ3elVzWWU3NC9kcHVPNFFEeFhONDY0VzFCbkw1SkpGaXE3Y1A0Q1NHZ0tn?=
 =?utf-8?B?UFNSeHRUbUo2MEhHc1JhV25WbVhaY2FzajkwMWNyRXFLMVo3Wm1FdVdMV0pN?=
 =?utf-8?B?NUFCRGZKVGNERnVRRUl2dmNPUTJVR05PYjhjTFphcDUzZk5pVVF5QkRhZDdJ?=
 =?utf-8?B?MnBJQjdRbFcybDBmTkRLaFBhU29ZcEhzSG1EMWV4ZktaTHZpS3VNVFE0eWNL?=
 =?utf-8?B?eG5BSlJZM1g1b0NEK2JCdXlOcm1rWWlVcGN5MmpIMkFnNWZlUFYxZlM0WHc5?=
 =?utf-8?Q?wBLSHFDLQnoLZFD3XKJ/ClB4n?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d096fbb6-d576-42c8-d26d-08de3e4e1774
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 15:57:05.6419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BwfmYCtxQ/trx466t053ugpUL0LQPTNW5R2rKU2BRKLFvY+pNd5pti2QiieUG30SR5NJgT6uk0n7Y5UYklUeZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB12130

Use the new dmaengine_prep_config_single_safe() API to combine the
configuration and descriptor preparation into a single call.

Since dmaengine_prep_config_single_safe() performs the configuration and
preparation atomically and dw edma driver implement prep_config_sg() call
back, so dmaengine_prep_config_single() is reentriable, the mutex can be
removed.

Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/nvme/target/pci-epf.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index 56b1c6a7706a9e2dd9d8aaf17b440129b948486c..8b5ea5d4c79dfd461b767cfd4033a9e4604c94b1 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -388,22 +388,15 @@ static int nvmet_pci_epf_dma_transfer(struct nvmet_pci_epf *nvme_epf,
 		return -EINVAL;
 	}
 
-	mutex_lock(lock);
-
 	dma_dev = dmaengine_get_dma_device(chan);
 	dma_addr = dma_map_single(dma_dev, seg->buf, seg->length, dir);
 	ret = dma_mapping_error(dma_dev, dma_addr);
 	if (ret)
-		goto unlock;
-
-	ret = dmaengine_slave_config(chan, &sconf);
-	if (ret) {
-		dev_err(dev, "Failed to configure DMA channel\n");
-		goto unmap;
-	}
+		return ret;
 
-	desc = dmaengine_prep_slave_single(chan, dma_addr, seg->length,
-					   sconf.direction, DMA_CTRL_ACK);
+	desc = dmaengine_prep_config_single_safe(chan, dma_addr, seg->length,
+						 sconf.direction,
+						 DMA_CTRL_ACK, &sconf);
 	if (!desc) {
 		dev_err(dev, "Failed to prepare DMA\n");
 		ret = -EIO;
@@ -426,9 +419,6 @@ static int nvmet_pci_epf_dma_transfer(struct nvmet_pci_epf *nvme_epf,
 unmap:
 	dma_unmap_single(dma_dev, dma_addr, seg->length, dir);
 
-unlock:
-	mutex_unlock(lock);
-
 	return ret;
 }
 

-- 
2.34.1


