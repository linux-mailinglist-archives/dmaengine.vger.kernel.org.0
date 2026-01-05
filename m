Return-Path: <dmaengine+bounces-8035-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 621C3CF5DF2
	for <lists+dmaengine@lfdr.de>; Mon, 05 Jan 2026 23:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E296D3034934
	for <lists+dmaengine@lfdr.de>; Mon,  5 Jan 2026 22:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144422F4A1B;
	Mon,  5 Jan 2026 22:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jJDznWKm"
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013013.outbound.protection.outlook.com [40.107.162.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900782F60A7;
	Mon,  5 Jan 2026 22:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767653249; cv=fail; b=SrRV1zEZxQKaw6AUim05yADlWpmoK+kdjQJGVKJ9vDdduNSejYs5QsAjW8nibPAnzkYIXk4QnqoyfYUAnp2pHhaKf2WAIkEfgUYReRVvLOePYGwleMSzLUrPU2K2IUsxbL3GG9XZvKekYxxL2Dqqk/CGSCXoXqf73seVQyk8p24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767653249; c=relaxed/simple;
	bh=Wsp3uGnzxx0Wp3YeUhu72AainaVzttYYzmVBZXHB/VY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=qdqwlK0OS4uLN+URhKFHdpoUcHOy1mV7KyblE2jNFtvPVP8e9+tnjzOdsk/kkSssIik9gf2PZmHcD7rLg6eRf54ayHt0u2APy7T1GO45k0D3B/cgfgBAlfeJDqX+I5TZSAOWSDgsg6/Nap4G6FF43n3z2283TBU+q7yzNqApaas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jJDznWKm; arc=fail smtp.client-ip=40.107.162.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jbvYhGFp1XGuI0DMOWse6m3BhaoQ2oh8yZaTVVxtSxRSAyUELwYnmhFwk1b8f01PGI+r3JaJUsapzmUDgBX+vatdqMin//MAwXow5fVf1NPl4+22UC98MeFKikiiayspDyoUP+pQ8Qw+trbGuUkdJ2cxV5gw2JrmHlWheGXzwfQGJfiQUg075+MVhQpr8ZaT9+uGJOUOtmemQKfsgv2bqeMrz7SeuyLDlP5w0eted0FowEhMjYdmKJIASVGkeJtyLgjqTCKxXus2tNjrrxzmhK3WPfsQyUgNgNCng+xSot00h+3uirwp8g5GYJ3tlA+v54VyQlDaJqSFUskVSrRCig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2cMGSxa6ktWJdnMB15o56WjcLsA8Z1ybQc/EAffBaqo=;
 b=JqBIgTwZFjzTPUQNXpWFHB7kjAa6i14Gf8/JV+Re5eAHuwHVKECokNg4vJm5cratCuTcOPV5i1nJHk6tIOn4XpEYh89t95+0VBFRs0yy/7yIG3BQ5zAheyTnEBvybggJHmuWG33x8kn/r2zmE+N2+yxePA1sDzwzFw4COVlIh+uvh9dZui/QmrC92DBVFsn1xClsvLnZVDGIB9Gm9l/ytwTBPPnX23S5gr+A5hzvhrnsWZvXldwKZmkRxvnSf9m01T/Z/pCrXMuD+/7H94ZIIXnNoVAKgisFYfWWWnnzESMdAtSFQTpL0NnYs9wCqXjoVYFXTh1ZY8J0h4XDWaxZkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2cMGSxa6ktWJdnMB15o56WjcLsA8Z1ybQc/EAffBaqo=;
 b=jJDznWKmVaIwWpTmDhDrAIKmeq+HRgxqR1Rj9p3+h2Yay2DSOlCniRDgSsPYPXVkuFEjBEZqy4q+PsnGmZzNZ2Y6gilCRbvv9ju4T85M1unaXkxntXXNeXmbONeP9MD/HZfFDpRthqjO1GOPJ4Nx+piWNXD1KYiE4hPxxdJusuSPiHrKRSXBhzJJysc5NDw7ffj3v85DmZub8KS6/uHkWU6XvEDnoOZFhBiu0J+Q/pQMWTZi0+YLLUJUwLBvKWxoxahiZ8YJVPjqoeeIKuhJEZDr6u6V2KGv1hto/odP1VXtgVQc18l498NpTF/zuIBbggNZgNnx4Xp/uoip7nzuTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by DB9PR04MB8185.eurprd04.prod.outlook.com (2603:10a6:10:240::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 22:47:21 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 22:47:21 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 05 Jan 2026 17:46:51 -0500
Subject: [PATCH v3 1/9] dmaengine: Add API to combine configuration and
 preparation (sg and single)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-dma_prep_config-v3-1-a8480362fd42@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767653229; l=7304;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Wsp3uGnzxx0Wp3YeUhu72AainaVzttYYzmVBZXHB/VY=;
 b=TzJutTq/KRx8WJK3W2Jo5XkEj5741O0fPnb9egmDWz38bCxhWOZvXqAA68fx+kjjo0U0w7BWI
 65bnHm6CrnqAeCoG3xF0R68ayg9JsG8NrlJYYDv2rt59iCiCGlmD6dp
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
X-MS-Office365-Filtering-Correlation-Id: 65162cb0-7282-41db-d55b-08de4cac62f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VEpBQ2ZzaEFDY05pVlBXZXoxVVMrQnZOakE0REJDd2VXQ1ZLd21Cb2NGSkN0?=
 =?utf-8?B?NlFtSXo1eTV1QWZGUUU2SWtQekh1ZFREdTRmVzVlaGczcTU4eU1UaWZRSEc4?=
 =?utf-8?B?TzNkdW5ud3RrNkVUT21DMlZxMnhBYXlyWGlseTdraW52NCt2WHU2Rzd2WjBF?=
 =?utf-8?B?RnVXWlcyWFl1R2ZSMCtSQUx1SENINU9jcEhLbXJvY3RHQUY2bW1jbEF6Qkgx?=
 =?utf-8?B?bWtNeFZhU1NiS1JBMG9XMlhzVXRpRytld3pnVzlMcm80N0lzWmFGc2IvZkkr?=
 =?utf-8?B?YVhEQVcxemtrSU03MnYzNzFGMW8vWUIvTXFhZnNqL1pWT2lqNzJrdHdBWnh2?=
 =?utf-8?B?WW9zekQyODFLMlZ3QlNhbVI1SkU3N1NveWsyR253NlF5Y1JXcWpsRG1WRXpT?=
 =?utf-8?B?WFhwWGNlczJyU012TjY1Q2ZNSUpWT2p0dXpib3hoa3lERzlpdGw2WDRxaEZ4?=
 =?utf-8?B?ekhWdTlpaW5PRUFzaUl2VWdsQ0JFUFpIdmE3VUpKaVZXa1VlaXR4eHF1ditm?=
 =?utf-8?B?UEJ3R1k5V2JXZXVPaFVOSW45TjdxSDl1elljZ3JQbGhtWG9OdXdYY2N5NGhI?=
 =?utf-8?B?aUxGZ0ZaMnBpRTdaRDlmaU5ISlhobHREdGQvblNPR3hUNjBrdzhlRVp1bFRP?=
 =?utf-8?B?Y1lLM0t4c1g2V1ltU1FSSlVyNkxsdEVJN0pnZHk1cXRUN0s1azV2MUNFSDNs?=
 =?utf-8?B?RnZxZHFTdjN2MkRqMGsvRzdxbGNEUGpWM0NvSzV0MXZzZVY2RTlwVU1zTWEz?=
 =?utf-8?B?aEMyTzloSHlDWUhhYXU3N2NIL080NDVtc0U5RDBwK3EyRVN5L0tJR0pYVWpW?=
 =?utf-8?B?RThzdzdSdVZpNDRGMXhGSXA5RmJwZWJ5M1dQb2ErSDFMa2NOZENZRmNsaDZT?=
 =?utf-8?B?aHYyQnE0Y3VMQkdLWVRqaUZHSG1keW84NmhSNlpnRzF0UVJSMWM3T2JLNm5p?=
 =?utf-8?B?MG1uaEsvWHdTSHJhUUlld3NNMjBBZXVoM1pmSUMzaC9GanpkNWUxRnBMbEpF?=
 =?utf-8?B?WVg1dTA0UzVibmFlaUhJOWhwK09mVEs1K3M4UEhETUZTYzlYZCtyd3FDdmc2?=
 =?utf-8?B?K0JNT25uZHM0WjVYQ2VsZmNPbW5STjNONDhDTXdENUtYdVIzOWhvc3Y3bFRG?=
 =?utf-8?B?Zzl5OG5ZaXFzaVNqaDJEbElnZjZCUmVMMk9LaWpqMWRTaVJuTk5WeU45M1cz?=
 =?utf-8?B?R0JJbnU3aEtVeGlGdlVkRkZOYVRIRkhPRTNEMk9vQWtReStyRFBYNWRKVkEy?=
 =?utf-8?B?Qk1ZZm9EbnRHOHlHcHBFMlNNRGpJb2R6KzVlQmkzcGIrRFU0a0cwMTB5MGpO?=
 =?utf-8?B?K1BWeUNqaldNcUlHT01VMnM4N0U2MTUzamtvaWZ0U2JKbDZIak1PNVo4VHUx?=
 =?utf-8?B?TGxpMlJBK2o1UThEdDhNd1kxWEV0cU1taVh3dGpjdDBvaEZsWHMxQ1J0dXFN?=
 =?utf-8?B?UnhBOTIrQnZRS1dFb2lFNlN1WVgvREVjYWhOSUtBU2tQb1g4ekQ5RW5TMklQ?=
 =?utf-8?B?LzNCZTc1QVZCYUdqUFBuNDJpRHdqSml4UVI3bllnR2NtS0lseXpNQVlxbjhl?=
 =?utf-8?B?LzNtSTFObU1lSU96V2xqOVdGb2F1YmRON2tZT3kyblE3cjVyTzVBam1mUzRw?=
 =?utf-8?B?cHFSc2FpejVjNTVFOU9hdlUxNVAwQnJLVThpWUJ6UmU5bDBpVVJNY3EzRnNK?=
 =?utf-8?B?MjdDWHhkMzR1S1pneTBKNG9BWXlralpQVWJYVUpzYXJ3eFhSSEttUTNsZ2Z1?=
 =?utf-8?B?SHJRQkNpTVh5N1lxWTBtWnRlQXBNa2hsS1pSVVdCV1pnNEROK2JvOXpUM1hv?=
 =?utf-8?B?TjhZMjhzdklGYXNlZ2plWDN3ejh4KzNHYlFvZmVsZytvV01ZcVoraUpKMDZ0?=
 =?utf-8?B?U214OGF0VWlTb2lYRWVieFkxYmdCZEM2NWlnWnNkanBDSGRrb0JRek1tY0NK?=
 =?utf-8?B?bHhhY0JEY3NQekpvbFkzYTJKeDhCZURPZU83ZWpLWlgwc1pHNXEwTzdxNGtQ?=
 =?utf-8?B?eU1zaVh0S1lEN3dLMmVPT3c0MmtzbXNtNTgyVjlZUllQdEswbkNha0RsMVRS?=
 =?utf-8?B?RVVLanVrTXRrWkZKNkxjdzdqT3YzYnh1V1NJdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blVUaVZwM0lUTkdDMC9YRnRXT2swM0VTSjdrdkZOeTlNYTdOSkx3QUY4MkF4?=
 =?utf-8?B?L2s0TFhqd2pUR3NBRURHYlNPczBtSi92TzJuRUlZNEE2a0g2R2lWZ2ZYb0tJ?=
 =?utf-8?B?VEk3a0VubjNnYmJHVTBkYmhNcGdNd2pTT3U0S09nNkRuYkxUSVNoQkhVMC80?=
 =?utf-8?B?MjVkRFFQeHlMcDV6UGwrMWV0a09DNUtHdlRxNjg3SS9VTlRqSGduMzlpUExy?=
 =?utf-8?B?dHdwVEtWR2tFalplSmY4alJKRE02KzlNSytBRDEvYUdNK2U4dGJmdU1FR2RG?=
 =?utf-8?B?akY2aDR4di9NMzE5b3Nvb2VsOTJ6VmZkSW1JTVZScnc2d0ZwMWtoYThEUVhH?=
 =?utf-8?B?TkxaTHdWa2Y4bXNOV3JJcGVEK2YzVTdBWm82VHVjK3FvblFjYmdWWHhENFJi?=
 =?utf-8?B?TGtBZ3JqdXMzNDFtR212MlMrbkkvU0dzV3hwTUUyNXlaV1dEUjV4cGJwZ0Fk?=
 =?utf-8?B?WWdZaVNwNEJVbWQ3MXIzUTZUbVdveVlJaUx1cXpzYzBDa25NUHllV3N5SzNi?=
 =?utf-8?B?azlxVHBEM1BXaElrSnhUTkpWQ2E1b09BTVhzOXZrNVFKVm0rdTdlUUVJZXNz?=
 =?utf-8?B?M1Q1NEhrWnRGbEhxVm9sbTRHVlk4Y2ZlcE1aTjBDVCtHaGV4akZNajFsRkdq?=
 =?utf-8?B?UTFQQjJrenV3ZWI1Z2tHdkIwK1hDNjl2VXgwa0VIdUdIa1RUTURGTGNiSnVQ?=
 =?utf-8?B?QnNVeVZkNWJZYVBBZVdiSDJyQ0tnUXFRa2hpY0l1N05raXd5MU5XaTBOUTdR?=
 =?utf-8?B?a1pwd0pHcjZQKzZRSHJPZmE2WlZtNTAvRmdLRGhKVjJXQmNVUW9HQlVldno0?=
 =?utf-8?B?SVhvRWlqc0hWcmtKS1V4L1o5SkpyK3ZLdjE4SUwzVzBYNUNZR3FySWtIZHd1?=
 =?utf-8?B?b09GY0ZxbGJDclZWQU5aeHBreUZJODBOMUNiTDJHVDc0R013aVFBV29NK3c4?=
 =?utf-8?B?dzBXVTdZNERtMVQzN3hoRmlpczA4NUYzcm5JakJOSzVDSEdGODNocWJxZzdk?=
 =?utf-8?B?MUlETlArYnVMcTcwaXNjbUprdUlJREJHN1FCTWFvaFdTeHR3YmZ3SmJGNENE?=
 =?utf-8?B?dExVRHZVMnJaNDlRM21Vd0VLclh4ODdyLzNBVjVyUXRRSWtLcXkxSTFhUEtF?=
 =?utf-8?B?aTJJOHNpckw2UkhqdWRHNTVCajJWblJreGRYTXp3U2Mvem9NeUE0OXEyTnJw?=
 =?utf-8?B?Ly9MU0ZWc0E4S0drcGc4amVPNDB3Rzc2MWZWWFM3MFZIYUtFZjBrMnF0eWE0?=
 =?utf-8?B?dkFheDZYRW9KVGtjcGh6NVBYQ24rbkdWNGZQU2J5MTEyNndUTDJzL2FXeFJG?=
 =?utf-8?B?UHg3Z0kyNTJrVWtkVWZxQjRab3RzR2hXUHNEd0pQRUxyZE1PMWgvM21GalUx?=
 =?utf-8?B?YnlJNHkrR0tPdXZFL3lhWlEzbStuTmlTRTBWMHZRZ3VpUThKUEJpWTBSZ2l4?=
 =?utf-8?B?VjZpNG5RNllzbVNrdjI1UlNEemoydHNXQlp5cFBrUkdXampNd3RhSUJSZzdY?=
 =?utf-8?B?SkRCNCtzenJaZFVZZE5HR2JNdVBYWi96K2VZbytKNml6ZFBjVTFCM3RSNTht?=
 =?utf-8?B?b0FDUkRqRlZtZkFSWnFrUGQ3UDFIaG02L2tyOVhEM1lRc0hQTGt0ZjQzYW1v?=
 =?utf-8?B?ejJsU2JhczFLY1JjM3VXd2EzSVU0bkY0RFA0bWVqMjYxWDlOU0VmQVYzK2h0?=
 =?utf-8?B?UDFvQ01UUzlGOExVYnZrWmRZTUgxSC9qSHYvQys4cldRQ3pJZkE5WG1OajR4?=
 =?utf-8?B?UUVEQ1ZYYzQvVytRK2lpUUFJeUVWSFBzTjh4RUhVekNmM1RPaGczWkdsa0p3?=
 =?utf-8?B?M0JpNWJ6aG5JWmNuT1o0ZGtJbjRHVjRMeVNKMVdkWHNnUFVpdGlNb09qVWRB?=
 =?utf-8?B?RWVvOWlHT0ZQSVVCeEw1cllxNFF0WkpnWnk2YmtFVjdrQkF0anNBQlNtZUVH?=
 =?utf-8?B?YTZMYXNDSkFSRDl0U1M3ZGRMUDhaaERKWm1TQkJNTzFEVXo5V1dEQWR1cy9J?=
 =?utf-8?B?TXQwNGNmSXYwZTRxTmdHTlVSdmpET2xMSFAxdDZSQ01qOGc4Zk5HM2RxMElO?=
 =?utf-8?B?L1hITXBIa296OS9lMnZqU0JwY2kzZ292d0xNK3RMMFBlNWp2Y3NnaTUrYlNm?=
 =?utf-8?B?Wm5FbFUrSjZ6eXdmQnFsNXIyQVUxNldRSVJ3d2QrSkxkK0NOckVydzVjcXhn?=
 =?utf-8?B?a2dWTnlIeXhwZnM0cW1VaGwxdFd1WFpFMTNTbmFBQmUyN3dMc21ndFRiTjY5?=
 =?utf-8?B?ZDNGcnNtd3BnTG95WWZKQlJGVUlRMEJCSTUvK2R2OW94NWpXM2hqYUl2WVZM?=
 =?utf-8?B?SVZCNU5LL0FycjQxZnVrWFBiYnBsenlIYlRITGI2VzRnVk1iaUNMUT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65162cb0-7282-41db-d55b-08de4cac62f2
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 22:47:21.2404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UxDO0r1SOLbqIKRYYu0iRSc1JJQfb7qa6Cj0niHA2R9uaYY8ByExsWRda63y2fBQo+xDvs2htgtiGTChSzpV8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8185

Previously, configuration and preparation required two separate calls. This
works well when configuration is done only once during initialization.

However, in cases where the burst length or source/destination address must
be adjusted for each transfer, calling two functions is verbose and
requires additional locking to ensure both steps complete atomically.

Add a new API dmaengine_prep_config_single() and dmaengine_prep_config_sg()
and callback device_prep_config_sg() that combines configuration and
preparation into a single operation. If the configuration argument is
passed as NULL, fall back to the existing implementation.

Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v3
- remove Deprecated for callback device_prep_slave_sg().
- Move condition check before sg init.
- split function at return type.
- move safe version to next patch

change in v2
- add () for function
- use short name device_prep_sg(), remove "slave" and "config". the 'slave'
is reduntant. after remove slave, the function name is difference existed
one, so remove _config suffix.
---
 Documentation/driver-api/dmaengine/client.rst |  9 ++++
 include/linux/dmaengine.h                     | 64 +++++++++++++++++++++++----
 2 files changed, 65 insertions(+), 8 deletions(-)

diff --git a/Documentation/driver-api/dmaengine/client.rst b/Documentation/driver-api/dmaengine/client.rst
index d491e385d61a98b8a804cd823caf254a2dc62cf4..5ee5d4a3596dd986b02f1bce3078ca6c4c1fb45a 100644
--- a/Documentation/driver-api/dmaengine/client.rst
+++ b/Documentation/driver-api/dmaengine/client.rst
@@ -80,6 +80,10 @@ The details of these operations are:
 
   - slave_sg: DMA a list of scatter gather buffers from/to a peripheral
 
+  - config_sg: Similar with slave_sg, just pass down dma_slave_config
+    struct to avoid calling dmaengine_slave_config() every time adjusting the
+    burst length or the FIFO address is needed.
+
   - peripheral_dma_vec: DMA an array of scatter gather buffers from/to a
     peripheral. Similar to slave_sg, but uses an array of dma_vec
     structures instead of a scatterlist.
@@ -106,6 +110,11 @@ The details of these operations are:
 		unsigned int sg_len, enum dma_data_direction direction,
 		unsigned long flags);
 
+     struct dma_async_tx_descriptor *dmaengine_prep_config_sg(
+		struct dma_chan *chan, struct scatterlist *sgl,
+		unsigned int sg_len, enum dma_transfer_direction dir,
+		unsigned long flags, struct dma_slave_config *config);
+
      struct dma_async_tx_descriptor *dmaengine_prep_peripheral_dma_vec(
 		struct dma_chan *chan, const struct dma_vec *vecs,
 		size_t nents, enum dma_data_direction direction,
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 99efe2b9b4ea9844ca6161208362ef18ef111d96..4994236aaadc45dbda260b63abe1fef47aa3d51e 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -835,6 +835,7 @@ struct dma_filter {
  *	where the address and size of each segment is located in one entry of
  *	the dma_vec array.
  * @device_prep_slave_sg: prepares a slave dma operation
+ * @device_prep_config_sg: prepares a slave DMA operation with dma_slave_config
  * @device_prep_dma_cyclic: prepare a cyclic dma operation suitable for audio.
  *	The function takes a buffer of size buf_len. The callback function will
  *	be called after period_len bytes have been transferred.
@@ -934,6 +935,11 @@ struct dma_device {
 		struct dma_chan *chan, struct scatterlist *sgl,
 		unsigned int sg_len, enum dma_transfer_direction direction,
 		unsigned long flags, void *context);
+	struct dma_async_tx_descriptor *(*device_prep_config_sg)(
+		struct dma_chan *chan, struct scatterlist *sgl,
+		unsigned int sg_len, enum dma_transfer_direction direction,
+		unsigned long flags, struct dma_slave_config *config,
+		void *context);
 	struct dma_async_tx_descriptor *(*device_prep_dma_cyclic)(
 		struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
 		size_t period_len, enum dma_transfer_direction direction,
@@ -974,22 +980,44 @@ static inline bool is_slave_direction(enum dma_transfer_direction direction)
 	       (direction == DMA_DEV_TO_DEV);
 }
 
-static inline struct dma_async_tx_descriptor *dmaengine_prep_slave_single(
-	struct dma_chan *chan, dma_addr_t buf, size_t len,
-	enum dma_transfer_direction dir, unsigned long flags)
+static inline struct dma_async_tx_descriptor *
+dmaengine_prep_config_single(struct dma_chan *chan, dma_addr_t buf, size_t len,
+			     enum dma_transfer_direction dir,
+			     unsigned long flags,
+			     struct dma_slave_config *config)
 {
 	struct scatterlist sg;
+
+	if (!chan || !chan->device)
+		return NULL;
+
 	sg_init_table(&sg, 1);
 	sg_dma_address(&sg) = buf;
 	sg_dma_len(&sg) = len;
 
-	if (!chan || !chan->device || !chan->device->device_prep_slave_sg)
+	if (chan->device->device_prep_config_sg)
+		return chan->device->device_prep_config_sg(chan, &sg, 1, dir,
+							   flags, config, NULL);
+
+	if (config)
+		if (dmaengine_slave_config(chan, config))
+			return NULL;
+
+	if (!chan->device->device_prep_slave_sg)
 		return NULL;
 
 	return chan->device->device_prep_slave_sg(chan, &sg, 1,
 						  dir, flags, NULL);
 }
 
+static inline struct dma_async_tx_descriptor *
+dmaengine_prep_slave_single(struct dma_chan *chan, dma_addr_t buf, size_t len,
+			    enum dma_transfer_direction dir,
+			    unsigned long flags)
+{
+	return dmaengine_prep_config_single(chan, buf, len, dir, flags, NULL);
+}
+
 /**
  * dmaengine_prep_peripheral_dma_vec() - Prepare a DMA scatter-gather descriptor
  * @chan: The channel to be used for this descriptor
@@ -1009,17 +1037,37 @@ static inline struct dma_async_tx_descriptor *dmaengine_prep_peripheral_dma_vec(
 							    dir, flags);
 }
 
-static inline struct dma_async_tx_descriptor *dmaengine_prep_slave_sg(
-	struct dma_chan *chan, struct scatterlist *sgl,	unsigned int sg_len,
-	enum dma_transfer_direction dir, unsigned long flags)
+static inline struct dma_async_tx_descriptor *
+dmaengine_prep_config_sg(struct dma_chan *chan, struct scatterlist *sgl,
+			 unsigned int sg_len, enum dma_transfer_direction dir,
+			 unsigned long flags, struct dma_slave_config *config)
 {
-	if (!chan || !chan->device || !chan->device->device_prep_slave_sg)
+	if (!chan || !chan->device)
+		return NULL;
+
+	if (chan->device->device_prep_config_sg)
+		return chan->device->device_prep_config_sg(chan, sgl, sg_len,
+				dir, flags, config, NULL);
+
+	if (config)
+		if (dmaengine_slave_config(chan, config))
+			return NULL;
+
+	if (!chan->device->device_prep_slave_sg)
 		return NULL;
 
 	return chan->device->device_prep_slave_sg(chan, sgl, sg_len,
 						  dir, flags, NULL);
 }
 
+static inline struct dma_async_tx_descriptor *
+dmaengine_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
+			unsigned int sg_len, enum dma_transfer_direction dir,
+			unsigned long flags)
+{
+	return dmaengine_prep_config_sg(chan, sgl, sg_len, dir, flags, NULL);
+}
+
 #ifdef CONFIG_RAPIDIO_DMA_ENGINE
 struct rio_dma_ext;
 static inline struct dma_async_tx_descriptor *dmaengine_prep_rio_sg(

-- 
2.34.1


