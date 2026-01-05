Return-Path: <dmaengine+bounces-8041-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDAECF5E61
	for <lists+dmaengine@lfdr.de>; Mon, 05 Jan 2026 23:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07D80307D834
	for <lists+dmaengine@lfdr.de>; Mon,  5 Jan 2026 22:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342D7311954;
	Mon,  5 Jan 2026 22:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CA7asBhU"
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013005.outbound.protection.outlook.com [40.107.162.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDA330C62B;
	Mon,  5 Jan 2026 22:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767653282; cv=fail; b=moBcr4A1awzEhdeO8zdRyHKcLohdXiU2awnDU/s9z+aKZaNle4346NES04j4pRWYNCT7oj/iEJwt/leihCgjS4oLUPXGdSa/JvxVWFgDJagT82AL/GQOfp1+VIEMYW8OnEjXRrVHfv5aiT80hruvJRXeM9EPTZQBJNGszzZI35c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767653282; c=relaxed/simple;
	bh=yXmKgWAZqHe6qd/69hAbQxcOWyMkMi3R1BS7Iv+TrFc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=i20d63K9oitZk3qMvT1JNteycf2Z5l27sCP3J8nO+bwzP9f7iQe4Kh5Ru+UcIImVHJdptxkRCVVPsqgFKboh01g3fwiXcdWwaCPE2HhUs1cz936dqX7DZg1mHusnnWauaPFCBGkGBBZd2+OIqM0gbH1yYZSrk2onudCQX4lHqOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CA7asBhU; arc=fail smtp.client-ip=40.107.162.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HQsLQsA8LOhQEjcem2T1+hiJSnvQB8ICDMoMIs0cVpptySRwfAtusTM3Q95qZW6/261nxfCzOrsITMsmHiD9BdMdpJkHRYZYf0HwmQU9rciXuE5hBv7OwQ1JXDV/zxlgZ0SlFD1cB59seYlZh5Z4We4wQZOMyXeJpRExrC+JA9X1qWnD83bCo5u27JiVXQ7CZ/CgR3K9oP2bs5cIb4gtPIPSLCY4PnRdkf5ugf9zXBInrjaQbPtLNT7wRM5Lsjn176swdBrfL6d6K43qv6IXIv6FHGlXQFk0glSS/OF3DdWhlwelXataMxONgYtr1lStjvyUKEptgFRthz5w5gFZjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ENrfJQ39lgQsd9W6FP4tnLJDLC9UpDI7fpf/3U1ezNs=;
 b=kAdUB0UGzaJob2v4c6SzAfU6vaz+MWoXuamt6dC8m1iCWC//6VlzbXSk8EBTlsVLQkQD8MJ8YC04nfnQ3yqUmec/hhQtXT41vKBAuosUIN9V9Ja3zTHD4PoJqcuivHaDoRh1uJyrWqkGzgVyMWvJtFyRxfKhs9AC6cIc+LZKEyh9czKlRW2fWQByzoiUTT6eP8LDBCnyD4yJBhy800b59bmAIbcicADhVtL7+plr0TgTb7+j1Dt7f0Gzxm08szdMQT8un1cH2kY4gAuGT5ZvBBm+oMGO9oTT0irhAD8RWf+z3ZW/ZATrdn2qluJfEH+sex5XHq4kWDRm33o8Ii0OjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ENrfJQ39lgQsd9W6FP4tnLJDLC9UpDI7fpf/3U1ezNs=;
 b=CA7asBhU3W59huPFa96cvvbUbtUtWALoJ6tfXhI78AAx/kQPtgxgOZxiIItkztlNBjCsQqrW0qJbCthsbl2WHh3/iYKAt6OwxBOd1/VSe4QlimlWuAAToiAtUkUJ05A5J26WP9q+IYzC6z+YsSFlQ3/IzOTRvrYok1WcVAPjnYFLYlrpg08CHBnCTXp53m8jTYT4it0012il2bs60FAfMXpQIAmf6+fZiaPub767Vg6JMpQhxpeIrmqsESlJZBCwVI9gbS1brh5DPIcJYHdZho5XQrdmRLtHLQLpNmx3orbjKFFPn69i4Q2paYP9JYS/LLNdpLB5WklfyBymeUuVPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by DB9PR04MB8185.eurprd04.prod.outlook.com (2603:10a6:10:240::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 22:47:56 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 22:47:56 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 05 Jan 2026 17:46:57 -0500
Subject: [PATCH v3 7/9] nvmet: pci-epf: Use
 dmaengine_prep_config_single_safe() API
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-dma_prep_config-v3-7-a8480362fd42@nxp.com>
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
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767653229; l=1756;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=yXmKgWAZqHe6qd/69hAbQxcOWyMkMi3R1BS7Iv+TrFc=;
 b=PP68lpG0Gvi1xOpZqBUJibsLEn/fLPkdQMUJ/MHBsLIHitQsxZKlVuHRORGTDjAnOI5PrpFxv
 HxGEbAadnP1D1zH9LvJOiNJiWbB/73iCaxhsK72P8aMdL8xLRYWfPVP
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
X-MS-Office365-Filtering-Correlation-Id: b8206449-8f4e-407a-dab5-08de4cac7815
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MURuVWhibDhDVjhRMjY3UHd4Q25IS0hpbENGWTVKNDRmUmZEMm0zTWdYWWhH?=
 =?utf-8?B?Q3RwaExzSXkxdW5lZjJ5S0IrbDJWUnl6WkxTYWF5WS9yTTFXMVRWOEdRUm5F?=
 =?utf-8?B?K0pha3BXVnVLZnRnNFE5UjQ2ZFg2UlBwVUNxU2xDTnRIYXBWVHJJQXUrek41?=
 =?utf-8?B?N1FkYUlDdWZ2ckFDbEp4MjI4N05FM3hJTEVUNmFLT1BrengvY1dLVlFQcG5a?=
 =?utf-8?B?NlNwcGhyclE4ZFcyMEpZT3RHMWJEbk5PQlpiN1EzSWoxeUdvZzk3aFZtRFdV?=
 =?utf-8?B?VVhPdnVOdjhiSkxHTHJpZVlQZi9sZm1kempvUWowUDJtS0VOSElvR09Ub2gx?=
 =?utf-8?B?djRzcDFNdTVab3ZpTWNBdUFXVWVVdWZ5UlVidG8vMkVDRlF5NFZDYmNoQmpN?=
 =?utf-8?B?N2hUQ0lUbmVQZlNyR0RKaWIyalhVVER4citMUGdFay82N1M5ODVocUZoclRM?=
 =?utf-8?B?QkY3Y3c0dVBUOWZ1T3Y1RHJvWExiODBuTWgrdTRXUUE2ckI4a2kxeVB6dGhu?=
 =?utf-8?B?NjlIWWp2TWM2RDFvMDg5cEYwMTdiMFhQOGx6KzJabzN0aEFzRno1S3lERVVC?=
 =?utf-8?B?bnVOYVpLRi9TWjd2QzRIMkxRTTMrOGN4RWxYajdSbnlJZlN0aHI5cUMySk9C?=
 =?utf-8?B?aFVRckUyekRINEdrUENlYWRTU1ltS3pxakwxTEo3cTd3aFBXQzBHc1RUcjVn?=
 =?utf-8?B?UWNWUXo2R3BBVGF6UzIwUSs3VzBxU245VXRwNGNXWU5aL3VXSmE0bDZlRUw0?=
 =?utf-8?B?TEx2Qzd0NURQeS9jK3g1QmdUOE8xSFVzOXFYK0QrRENUMU5kVnI2ODYreDBv?=
 =?utf-8?B?d2tZcXRkVGQ4bEk0dTIwZWVIKzN4c1NFaHZ6LytlUjVWZllWZEd1OHN2d3FT?=
 =?utf-8?B?b1hvMUZtQVZOWXFmYUkwMElkZnZ5cWo4NmVTZXlDMjZDRlhqVVRxK2tmR0VT?=
 =?utf-8?B?Sk1qNTFiTjlxWDIrWTRIYWx5bGc4QUlMcmI3NXEwSlAyZkpFRVVEbnhJeDNK?=
 =?utf-8?B?eVFOcy9oUys2WHc3L0YzMEZYdXkyY1d4RVcxN3p1QTVQVGg4bFV1MVVWd3Vs?=
 =?utf-8?B?eU5MenRmSU55YVBJcVp6cEY2QW96OFNvMEhPMXRvS21EcWJhZ1pBOSt0YmpQ?=
 =?utf-8?B?L3psSFIxSE9OeGxXV3kvV0lXREYwQ0wyNTRSMHZmQmdYWlZON2lDZXluaGJx?=
 =?utf-8?B?Z3pQYk9RMTFTalZNa0tjbUJFazZPQUdVamtLdVk2V2lKZzEwODB3TDVuUE1q?=
 =?utf-8?B?TDZIT01WZjRGUCtBclRzMXNrZHRLc0RHVmFXeUdXak1ybktDbHROS1hWYWFo?=
 =?utf-8?B?WktDeGF3S3hTSXhraWE4QnJYWU9ZNDFXa0tUQ2RJR3Q4RUdXajRCR0VWeDdO?=
 =?utf-8?B?blZLcnRoUGJvZDVndVFoL0ZrS21URFYwMDZxMjhaZjFXcUVxZG9WUWx3T1dl?=
 =?utf-8?B?UlRFTzhYSUNsYVh1QlNZSHZBUXMzUU5FNFpnb3QxVHFUOFFzem9LclZXNXRO?=
 =?utf-8?B?TjMvNFU1Z2pzcVdQc0NRRHhQQVh2cml5cEQ3MEZERnFiQ2czRXRTcjlOWnZz?=
 =?utf-8?B?T3VJd3R4aThBRUQ5eDhlTXJxVS8yYmtWaXBVQUpXaWsxajF1cXRsd01MeUNI?=
 =?utf-8?B?UHBpK0xwTkZMTE8zRVpPckU1S3JpTTUvWFJ2TVAzcm0wenJTQkdXT3hBVjZr?=
 =?utf-8?B?dWxhN0h4UVZ2V0s5N2RzbmpsNGc5MHFIK1k4eTJ6YWRBTTVUdFdmdzRGZUwv?=
 =?utf-8?B?eHozUld0N1hIODVROWY1bzJrcFI2WUJ6YVQveExJRnl5SXIzSlloQkJUMXNz?=
 =?utf-8?B?dmQxdTJUTmdkbTlOb3V4NmpPRHpKcG1SZ3hEVVBIdkNLMU5nWVVvaldQUndl?=
 =?utf-8?B?M3k4d0F2bjBWT3dFVmhZMWZDTmZEenM5d1ZGd1ppWmdSNldCb0lDOXhQRmor?=
 =?utf-8?B?aHh0YVFPeWhUS2pSZWI1S1BtdlMvc2I1RkxKLzEzTkpxYTlET1k5MG1RL3Bi?=
 =?utf-8?B?bmpBMzIzMEdVMXZSOU51bHNGL1pBOXFJM1dwbHpWOHBpdGlVK0RJUXhXRDlj?=
 =?utf-8?B?eUNtbjg0TDRVVzFxTXVjamxlODkxYVRtWTdlUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWtZRXJjV2dYaXZJNG8vM0hndjBHTVZKUjhWNmZIWWl5aHcvaUVwbjdIVHJq?=
 =?utf-8?B?NlhXTGJrZDRPK0lPZE1USG9QYnlDeGFKaGNkWVZhVE5ZOGN0Q3VmaWl3YkFv?=
 =?utf-8?B?MTlwdmI3YW1HYm54a3BwRk5LZXNZZUUxNDNPbmwvN1FOalN0RjF5UVU1N3NX?=
 =?utf-8?B?cU1Rc2xBTHBCd25kbis4cVI3dzg3MC9tK1RrK2t0bmVDUnpqeVBjb3hmWlMx?=
 =?utf-8?B?dWNWZGhTK1Nac1h5VGdVRTBNdHBSaFdEaGMzUFNmcXVpQjA4Sm1sSVFKSThT?=
 =?utf-8?B?bGV6WGZVWnBrMDhBRnRTWE85S1lWekQwbE85eU1KazJQalZEZGZqMDliL2lT?=
 =?utf-8?B?QWJ1T3lDMkI3WGRSYnkwczBTbHBrdGVQODFHdVdhR3BtTVc5aGZWOUpGYng1?=
 =?utf-8?B?UzAzc3RrdTc4WDVzckNIOWIrWmtRRGNuTExRS2ZuVXdqSi9kZHZETnlUUTJp?=
 =?utf-8?B?ZzJieG0xazFvOE1JbGlxcGF6czh2TFBiNFMvU1VzYnNqTXovUU5kMWtxOWhz?=
 =?utf-8?B?cWlkMVZtMEFNTWNNbXVvblR0dDRtSlNzUVVCMlJvdll3UXN4Ky9YellOYVps?=
 =?utf-8?B?WElid0V1Y0I5Mi9EbVBQQVFFZUVmcnoyZUhXU01ydXhMcGRGblBHZjVwT0lr?=
 =?utf-8?B?eTJLY0NtT3FWOCtxSWFDNWR3NVNSRnZSTWlKRng3ZjRYRjVuWXRWclVnazNM?=
 =?utf-8?B?SWp0bS96MUhRdzVJU1NGRmpFN1NSNmFLdGJUS1hBYi9oOFFCTGlCVitEbUZK?=
 =?utf-8?B?M2trV3BMTFNXU1grd3l5SnlwM21INi9YYzQ2bFpRcGd1ZkFrNGx6Y1pqYUcw?=
 =?utf-8?B?UUdnT05uQk1PeTFWZTR0aExDVytaOEpaNDZZYy9ZWndtOVJXNkxXVkFDNHl0?=
 =?utf-8?B?Ky84alVKRVRnQkRNVGRWa3Y5WFNKc2FsQURUTHJhZ21adHpWUk5OcGxEUXh0?=
 =?utf-8?B?UkcyTi9obnNwQW1DdEEvK01YNEcvMWo2NHAwc0FKNlZBb2JXZXVOOG5vNFdW?=
 =?utf-8?B?N3pRQ1pSWnJhdFEwTEpLUzROQVJDVXNQMU9IcUdYVTVPaHppU3FWZmhGQ2pB?=
 =?utf-8?B?NmExK1d2K3Q1R3RBRW5YL3Z5Mkt4QTQwbmtWRnRBZVNQQ09rVmw5TTBocE11?=
 =?utf-8?B?SW5pT3JBd3ZBSmVIb25wc3RjREtzczYxNlNCLzQxZ0pQR0JkR1pDWSsvdldK?=
 =?utf-8?B?YVRmd2gyY2xzckxzTmhKN3lRTTRJZi84bmNVTXhWSDl5NGFQNFhBOUxsQ0Zm?=
 =?utf-8?B?UlBwVTQ5RGE1eVFJYkR3RjREOG1hWEo0TzFvUmhMUVdDVTZWYS9weUZzMTFa?=
 =?utf-8?B?VWVkTmRMazlmSFVYSHQwd0t4TCsxZk9wbXVxUW5kNVVRUnlsYS9WdnpkYmNw?=
 =?utf-8?B?NGlRUDlRSFkwSDA5SmE4VS91TTR4QXpYWllJV29UaSs2ZUZ2VmRpaXFqRG5M?=
 =?utf-8?B?aUhPRlhQTzBMNGdLOVpvTGp0WmhBY0p1SUJUS0RzU3dnV3ltT1BxRS92UVpV?=
 =?utf-8?B?cmthb0lhNWRsSWtyVjMrVy8yR3A1WFVTODRQTEhSa0ZvK1lJOG1YS0VBUWdy?=
 =?utf-8?B?NjdHVUpESS9nM1l2azE2eHNDL0NLK2F6bFVIc1VBT3I0TXdubU9WMXcxK3ly?=
 =?utf-8?B?TEVxdGpyU3E2NVc5Qnl1T0FqMTFmT2RacWdTOTRuTzZRYXZJbnRKNjZVWDgr?=
 =?utf-8?B?bVpyZXh4SER3MER1dktEWEZpbzZ3SEFIVEVuK3hjWi9Vd0VSayt2Z2xCK0pN?=
 =?utf-8?B?ZHFtMjk0L2dXZlNLdU9ONGZIQ2dFRGcyU3ZSNFZLYThpMkEwbENNWHhaZ3g4?=
 =?utf-8?B?ZXh5am9pbDV5QU9ZTHZ4cmRpQ0NKekZ6c01Bb2xVK0JnRjdEY1o1UkFaYTFP?=
 =?utf-8?B?bDFGQlNsbUpjeW5abzBBcHRBM0FwTjE2cFpLV29ldHpxb1Jaa3o2V2tOTTNY?=
 =?utf-8?B?ZGpiaUQ4alYvZmpUUVR6NndUMDJJYVhQNTNqUlFzUGF5dDI5Mm1mTytTT0Mz?=
 =?utf-8?B?dVlibjc1NGdkcTUxT1FZTkdmOVZoZkRRSG04Zk5YUUV6SUtOeXpCYUZmMkRL?=
 =?utf-8?B?S3djRUdVd0RPWElUQ3FRWTFtS1l4cm11bTJsZ2R3QXl3NG8veVlXR1hkeWU1?=
 =?utf-8?B?ck9PNVk2ZUxLYk9lRFVhUUdGVWFQb3RIdnFkcXJwNkpPSnBZNnF2OWg5RnpF?=
 =?utf-8?B?MkhiVDhqaFdncjJZUWFFd0VMTEJzOUp0RVFmdSsvQ0ZhRnpIRXA0TjZnZUJL?=
 =?utf-8?B?M0p1bE9FVk00N3RtRG4wWFRCWlZoSE1yMXFjNkpSSlgwcTJlK29BbGpWVjVt?=
 =?utf-8?B?RTVKdkJiaGxWRjR1QThrMW5HUVZ6T1hoNXg4c2g0NnVDd214U3B5dz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8206449-8f4e-407a-dab5-08de4cac7815
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 22:47:56.6889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8jaKRyy+5A/WlfT2uNVqOWPKY7RXzGlOrT5/w6Rq3P7LlTkMaQCxxOTwWykuHSWuQk/lZoZq9qbEIn6omde9+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8185

Use the new dmaengine_prep_config_single_safe() API to combine the
configuration and descriptor preparation into a single call.

Since dmaengine_prep_config_single_safe() performs the configuration and
preparation atomically and the mutex can be removed.

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


