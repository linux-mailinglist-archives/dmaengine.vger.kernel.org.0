Return-Path: <dmaengine+bounces-7538-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 403EDCADD85
	for <lists+dmaengine@lfdr.de>; Mon, 08 Dec 2025 18:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C628430BAD56
	for <lists+dmaengine@lfdr.de>; Mon,  8 Dec 2025 17:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171AB2C325C;
	Mon,  8 Dec 2025 17:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="m7yG+v6j"
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013005.outbound.protection.outlook.com [52.101.83.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA1B2D5432;
	Mon,  8 Dec 2025 17:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765213840; cv=fail; b=eNWAVuWRjNTFHCIyiBIEJwuIicuVVqaLPJLjeVLSmBX4ZY8Zds+fSl4IP1/BfGm3cHw75Vdhygf/PZNWD4C252bZdVHaakNbPQrCEDd3LnVx7v+Q8JpIcvxRsW8MH0x1uQv7WKQg3yWTXgAIYUUwYadFNwgtMq6y5UtftSqo86c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765213840; c=relaxed/simple;
	bh=hWlOtvneZAApMQjRRNEdbYyWF4Gy5t5MX/XKxh/jKJc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=taNEpQWFfPv6CF6ZOOvEoVtmV4Bi9boCTldfhKr11IPoG4M1kcFtJj5ScMiMC5qLdk70x4ZwrGIBiCHKnMHTuNwpy7PeDhSLRlZ+RADU1/6DwLc8hir2j+9S014poix1lF8YIdGx6d4xLJbIElrzOMpWaFguaXRkQcIXxyfPvg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=m7yG+v6j; arc=fail smtp.client-ip=52.101.83.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XAXcuKrcicr9DwPKt754kFxYjA8o4mSoU5SYVXYwVITRXdlBWeWNIhuO18FUEb/lsT/jSwbpEaukjF9zqIY2PmFoDxVMz2PECUDmLuKoQhpe5mG5h7kAO38NmkcF86KlgQZ7C3QtriEDkY1J4tmUwQXScKw0ikUYJ2s01/eQy97gu4KIix0AV+VDOWTAQjIxNlRwWl+I/wV9HbXSXddgumUlfJyCANZZTLSNdsZGPAoy9tnV9/WU7USukmPJ5f1Lyi0TDnh2vmhxCJP7atJJCGS4hlg3EZKg2CHmJakkpHHMQomiQgBIDbnWT9d+idATG62GCT8BzSjA+eaA0+ozqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/k+RuAEeWyAIL7qnSucDzdhqp8Zm998YDj08fVqNIY=;
 b=PS1XZGMw9b77z/T/lk/hlff8VQCCU7CSz9EnufZUDiLpNyWil/+nMSY/xXkpjHRC/AJQEarDca0TLpS4NEYtm2uxVHH3V+sYahbipniKrhQEUwGq3tUcsSQp3+lI7/7hYK+j5uzIVoKRf+BwwM0Q5xFGmfMgM5vVXuejo2Q+Kgp9nsVcX4blmhDsQYW+354Y9HpnZ1C4vs8N+7Jy5kWzSNUaTTufWw0T+RBEmHB+pai3Iz6ook+Kgt8OnBSmOs5Sb4yyiaCXrD3RFjHGI3gUTU9ui3NW9Hm9c9TVZoiLWoeWZlP9gRrTQc4P8ZUltrD2tr7haMdrFLpE+K8JgsCp4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/k+RuAEeWyAIL7qnSucDzdhqp8Zm998YDj08fVqNIY=;
 b=m7yG+v6j5uEsIBsT1FNr7A0kAtZoYD3VDmF3KUwL8HD+b/uHwi+Yoe/NJEWElEXk61JHUbTtytDu+RaB5ogSPK7hbqm97cR7OOeVnnqf8Tb7aU8wswdcTEy2THqCwsPDMmzI+ksx80Gze3Kmz5iCzzesdOwJkBNv5sUFLk5fd7P/nnAljlLLnrZ8l6NkoSZvm1Q0nQlbCll97NINqKv8KRsK+/5MwhIhTbKxh7FngSjfLlCofQzbYIwWbzm2fAR/fOG/SJ/S7Ww4N7y35b47W3v4ieIt94hTi8l3ZzDm3dxIetULiW2R2EXQGWOX7Nvuv9P1QYKfYyNmoAu7fgrI+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by PAWPR04MB9888.eurprd04.prod.outlook.com (2603:10a6:102:385::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 17:10:33 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 17:10:33 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 08 Dec 2025 12:09:45 -0500
Subject: [PATCH 6/8] nvmet: pci-epf: Use
 dmaengine_prep_slave_single_config() API
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251208-dma_prep_config-v1-6-53490c5e1e2a@nxp.com>
References: <20251208-dma_prep_config-v1-0-53490c5e1e2a@nxp.com>
In-Reply-To: <20251208-dma_prep_config-v1-0-53490c5e1e2a@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765213799; l=1723;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=hWlOtvneZAApMQjRRNEdbYyWF4Gy5t5MX/XKxh/jKJc=;
 b=uHH2tbdHjrpy0ecTsMNh1MGQw2FBpnT7t0YM6D8xXSVPkugl97fATQopZbAVoZGTWPIszLPJ5
 3Ludv2Z5B92D6HNfgxYqBXguvnP+tgWp8/N+u30VgS56vPSl+myT1m1
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH8PR02CA0036.namprd02.prod.outlook.com
 (2603:10b6:510:2da::28) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|PAWPR04MB9888:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e5c7f1d-12a9-4692-ef43-08de367cb2cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|19092799006|1800799024|366016|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MndlSjlmWUx0TjdZRDlHem95UGtibDN6TjdldUNFRk5CRFpvWnF1UXB5czd0?=
 =?utf-8?B?dGVvWUtsQnhLaVdPNlJTeG0zOEJxWjJuVmh0QUprbWQvMGJ6SGtBUEZCYkRn?=
 =?utf-8?B?Q3RaS243QkM3YVp4NGoxZzAxVFVOM2ZGQllZbEYxbDJVWjZIOVk5d3JDdjJP?=
 =?utf-8?B?SlZOOGhBajdkemFHOFhVOUo1NHY4bUgrRUdBbnVSbUFpOGkzM1MwalB5ajZk?=
 =?utf-8?B?ZW1YT25WQnAybkxqcWtKdU5VN3JTaVg1SFVqL09ZeFVPanNqb0w0cFVuVVBL?=
 =?utf-8?B?bnRIUFVuWlU5V2Q0b2lUU1JXZmlHdHZkOUtCb0JCRGRxNWhrblF6NW1JeTR6?=
 =?utf-8?B?Y3Qvbmd6M3BxWnZjeVJJVVdrbzF0cmpaaTUxRFhJa0cxQWZTeEE3K2JBV2Ru?=
 =?utf-8?B?WUJnNldMak04L2ZKNWxVMXhOdWtqRzB3M2ppNjY5Zmt1MnlrZlZWREFTM1pp?=
 =?utf-8?B?ejUza2dsRW43aC8rWG5OcVJOMzlXOGRGbkNSeDhmMWFqdUlCNTh1TDJGaU0x?=
 =?utf-8?B?MDY1Z2g0dURpOHJRVWN0bUJYZGFacU9jZC92WXR6aDJ6QjkyTURBL0VBV0lQ?=
 =?utf-8?B?QWM5QVhwRjYzak52cFA3aEdXMmxYTEVJdTI3Ymh6Zmh0WldNSXV6MFpkRlJj?=
 =?utf-8?B?alBOc2FkMk5hMUtoMTdidmIwZ01oS0xkOW5WaVlrOG9lY2FUU2t0R3BkQWky?=
 =?utf-8?B?UWpMckkvY0RPMElWRDI3ZThiRldZRWlVSjBkOE1lMXVUSENyRTJxbjlvNzRt?=
 =?utf-8?B?ZFFUTzBlZnFlZjJ3RlhMejdDR2NLcE5PZzQ2TThBL2FyK2xHVVg2dy9KT1B1?=
 =?utf-8?B?RVRYVUVHYnZ6UnNsOXNCa3ZoUXJYSytHdlRUWDc0MGhnT3dybkNIcGVlRzYz?=
 =?utf-8?B?ZGNrZ3ZJTytxamdWMXBjSE40M2ZLR09KSlhIR25KTU01V25qdTczZUhSSmZK?=
 =?utf-8?B?SUo4K2hrYVpabW1YVHFRUlZla1NLUDFUQmEyKzVrK1RrZHhzRlYxWnAvc0w1?=
 =?utf-8?B?TW9ERTJxeXN6TytGNGxrR2NFTjhZRitWaFZ6c2lHeDlKNnpXWEhGc1djbS9T?=
 =?utf-8?B?aGQ1ck9yZ3lSY3MvbllJWlJUcWdEazFmYmpqS0JFdUF6QzNJdC9NTmc5bjNP?=
 =?utf-8?B?cVBZdlp6RU1MSFMyR3QxU0hYM3B6OWJTRGhaT3ViWjRiZ2F6RWY3NDNLQ0Q0?=
 =?utf-8?B?cGhUNnhTZzZkUS9zRWFtRVRnK1lYeC9Pek11R3BZT3hTeElnaUh2QkRNejUy?=
 =?utf-8?B?NHc1eWJWNExmM0FEbXBvRXRWNWNRTHV6a3V6bk1tQnlFNXoyVGtFRlZ5eUFn?=
 =?utf-8?B?cHhUcXJHNGY0eVJTK2pRZ3FSckZMb2NDQllSOEEzbHVVNDcwbDk2c0F1Uzdo?=
 =?utf-8?B?QURkcVpscStKUVhLaGFhU3FLbWlLVDNaWVQ5M0xabm9tVnJxZXI1bzVMd3lk?=
 =?utf-8?B?TG1kYmExajM4MU5EWEhyUlZQWGd3WmlwOVdTRU5HeXJiYmdKUHVhYmFMczZG?=
 =?utf-8?B?SXBWMHNza0o2MHVzNmdaRU5iS2xOemptWnVkVnRpenU2TlFqdVA1am9lVHFl?=
 =?utf-8?B?emE4eHBzNU51STFHenlxN1I3Z05SaW1uYmh2cXlYMnZ6eDBnZUVLVTA4cVVM?=
 =?utf-8?B?cmRhRGhtWERvTldiRjYydEdIUnR2ZUllcUtxbkdjSGhBNUpyRE5EUC84bUE3?=
 =?utf-8?B?aFZvQUtBVU5IYW95NFFqZ0puaFFXK1Q0M2t5aFU5SDhxT3ArRlJhdXJ6My9W?=
 =?utf-8?B?aDIxcFJIcm00VnJJcmxSZHE3SEpiSHJ3UVNtRzNxdnlpYkh6dUg2dnpkMzh1?=
 =?utf-8?B?SktJcEJTeUtuL3pMeFpoeERvS05lUmN3ZUVNZzlyZ2FSWTVDME9oTnpWLzg0?=
 =?utf-8?B?RXBQbFpVd1ljWGFnaDJZZDZKT3Z0TGNLN0dqT0NHSklYejQ3VFI1TmM5cG1I?=
 =?utf-8?B?cXpkR093MkxyUVVhaUtUWGptakNPNEFhRUxlWEMxSG9HU1htTFRyZU9hTW83?=
 =?utf-8?B?c0VURzNuU3FqaElWQ2xERCtwYXVPTi82c0NJYWVxN0I0MEtDSHBiQ1R6SUF5?=
 =?utf-8?B?RmY4SnlCVTdCWlZSc3VoUkVLZFc4czROVGRVQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(19092799006)(1800799024)(366016)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QkgxaTRGckpEZ2pKc3ZkY0VoeDZGc2pZMDNVdG43RFJmYnZqNUxaallSOCs2?=
 =?utf-8?B?RUZwV0Y1NDFWLzkzVlRaQlkveitaU2NHeVlYTTN6aTlyMFVVRlBkQVZpZm9E?=
 =?utf-8?B?TVd3cHZBMUVpdmhwL056WmoyUitPMGdROG9pV25CR0lVL2ZiNlFyb2ZVdDUv?=
 =?utf-8?B?ZlVGdmxkTmgwQlIvQ1V5UnAzWTFUNTZ6MUZkakRWNW83SG52cXRYb0ZzQ080?=
 =?utf-8?B?TWVDYWlRUW0zdVQwWm9iOWlJSk04Qm51cHZ0ejdnc3FJREwrOHZnWkxPa2lK?=
 =?utf-8?B?dUY3T1VMRm1SNDQzOUVma05nUXloREpuQVZpbWFoQTdxV1FWbVJCNDBkcXVQ?=
 =?utf-8?B?ZUtGZnZxWGdzL3F0emlkMEhFRGMvakI3ZGQ5cE9tTVFwWGVyZHBkd3Q5T3VY?=
 =?utf-8?B?bmFMc0F1UGtGVjVQbW1pUFkzZDRkdEZySEVWSzlwZ2toeGFTYktmYThBblVz?=
 =?utf-8?B?Wm1tZG1jbkNLcmNCajU0cG81bUpSZURrWE1QVkYwTkV5VnBseThDTmtGeGJz?=
 =?utf-8?B?WWRDcnluSGcwTmJnUFh5VStGZGpVK2hkaHkrd3ArMkI0R0F0UmFnQ25MN1Rl?=
 =?utf-8?B?M2FiZndTbGhSam5kZStlTzB3Zy9SWjc3TE93V0U0RlVEY1FtSjByanpib2I5?=
 =?utf-8?B?UE9sT29QdHhoYnYxRXBEVnYrNzN1TlJ3N2NlSlFRRUxTMUppLzJ0VFJ4RTZM?=
 =?utf-8?B?Qy93WWFNbG1VT2VqRGJBR3UyUnN0SllYUDFyWHVyWjluVUVuQXRpdkV5elk5?=
 =?utf-8?B?R1BNNUtnU0kwV2xraDdSbk44eDlvSE1LT2Z1SEJob21EQkQ3aWFEdjJwRjhT?=
 =?utf-8?B?dkhIaVR3K0k0RmtwZkN3Y2lLeUxiRmxYYXJHWHhicW5lQWRjQ3BaejU2c24y?=
 =?utf-8?B?TnN0b0FnUFJGUWpoTzVib2FtMHNEaEhEZUpYS2tQWGVEZUtUcFd6TG1YMzRZ?=
 =?utf-8?B?UDdFLzFNRVgrdk5BcFpTMVA3UHRTVUEvaHlwVXByemF3ZEVBK3ByYjg1NE50?=
 =?utf-8?B?RlRnZVJLZ3A0WVIxajlqYjJXZTFzRW5oN2Rjc01Zcm52VzRRaWdUY1JDQk9w?=
 =?utf-8?B?UW1XOGdnUi91cnlYdW9GY21RMmNwdjgxSjlHZUFIQzN5QzJLcUVuenUvRkts?=
 =?utf-8?B?eFhCdFIwakoySTNiMkJ1MWNnbUZ2ajB4Q3lRWjlnbHJpa3hRc2t1dTU3cElq?=
 =?utf-8?B?czN1cEI1Y2ZnQW9Gc0h1bmdyU09SbXkrZmhtYStkVSt2cVFleGdaNzBoUkMr?=
 =?utf-8?B?Z083YytpSWdXeFNOY3BEMDY2U0pMVTB2WTFXWDB2K0dxTDVoYnJLbjFWbHlX?=
 =?utf-8?B?V0crL3Y1OG0xc2o2SkswRGY2TDdtcUpCMzZIRU9zbUxvakYxYWlUcng2U3d5?=
 =?utf-8?B?dERRSnFnUmJ1U1hvS25VL1pRUmFhYUhFQ1pxOUNiNHpzZExnVEdkWE5MMFVT?=
 =?utf-8?B?a01KM2FxcEJab1FnaWFRZEVyZWp2SUxnaG5hTXVLZmltK0VoalVFM0dzdjJx?=
 =?utf-8?B?RlVEUGhBS0pWSWMyRkx3YkYyN3ROWEQ2VE5DUXhEdmFDNWlEN05rU1NmcEZO?=
 =?utf-8?B?d3NsNmFMOUpTaDI4d1hmRm12TE1pazlIa3N3Z0w1N0lQTW1LYXVnOHpEQVNG?=
 =?utf-8?B?THVsYkR5U1pnT1F1MVlaYmp0S2tSWktJbEdRVXBkaVF0YlN2NUlXSHpLcXgy?=
 =?utf-8?B?R0xiUVlVT3BRenR2LzdKMmhVTGFHaG1wNGR1T1RnVVV1WDd6QXRLK011WGtW?=
 =?utf-8?B?Q3JoTUNyY2krYVhvVWFvcmczcjNlL2F2bGdnTEo0NHRKeStqbzdEMDlkMXRK?=
 =?utf-8?B?d1RkakE1bWxJbkEya25aWTZ5ZmV1MXdicVA2VkF2bkVLWFBETk1XUHJsMzh1?=
 =?utf-8?B?ZTRDalhQRTV6N090MUdTNW5ObXJPeEI4d0MzNi9rWTVPRDZIVFBvKy9nNHBq?=
 =?utf-8?B?VnNpeEpSNzJnNGZRVG1IQmV5MUlUZ2p5THJiU2tBK25hVTNWck1xVVowbmVM?=
 =?utf-8?B?NVRkdjRDQUtiUXI0ZDByYlJZRHZIVnMwSFN4aHFyYVVERVVGdWg5WlpTOC9X?=
 =?utf-8?B?bVFFQXF6enJnV3U5MHJpZGhCbTRjR04zSjlUSEdrcGs5bHFWZk44cEVKSlhj?=
 =?utf-8?Q?J5TnQG2GuG+t0fkIjg/lSnrIC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e5c7f1d-12a9-4692-ef43-08de367cb2cc
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 17:10:33.7739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5aiDeWVLAEWorSoSrn51cYyy+eDtXpXJccAGcfkPCIuVFztyvx8EqtXiIZxg6feUU+ZilBFdpHqJpa0Gap8KAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9888

Use the new dmaengine_prep_slave_single_config() API to combine the
configuration and descriptor preparation into a single call.

Since dmaengine_prep_slave_single_config() performs the configuration
and preparation atomically, the mutex can be removed.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/nvme/target/pci-epf.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index 85225a4f75b5bd7abb6897d064123766af021542..223716b00715be2a81935e6920666c723fe98fe7 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -386,22 +386,16 @@ static int nvmet_pci_epf_dma_transfer(struct nvmet_pci_epf *nvme_epf,
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
+	desc = dmaengine_prep_slave_single_config(chan, dma_addr, seg->length,
+						  sconf.direction,
+						  DMA_CTRL_ACK,
+						  &sconf);
 	if (!desc) {
 		dev_err(dev, "Failed to prepare DMA\n");
 		ret = -EIO;
@@ -423,9 +417,6 @@ static int nvmet_pci_epf_dma_transfer(struct nvmet_pci_epf *nvme_epf,
 unmap:
 	dma_unmap_single(dma_dev, dma_addr, seg->length, dir);
 
-unlock:
-	mutex_unlock(lock);
-
 	return ret;
 }
 

-- 
2.34.1


