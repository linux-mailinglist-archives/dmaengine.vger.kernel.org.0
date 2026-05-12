Return-Path: <dmaengine+bounces-10371-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODd1Lz9ZA2r75AEAu9opvQ
	(envelope-from <dmaengine+bounces-10371-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 18:45:51 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9438A524FA8
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 18:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 581773080810
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 16:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1473D25C6;
	Tue, 12 May 2026 16:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gtSlomO7"
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011004.outbound.protection.outlook.com [52.101.65.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DE93D25B4;
	Tue, 12 May 2026 16:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778604153; cv=fail; b=qd+Vk90ROr7xaFmq37S8ACcnuTT9j5NNArpayAAj51O09Ca+DwyxlIDEQlsoZA0RJSceyfeTdKYvvakTbTx7sQVi3JOn9LcdZzI2qdCq4j2IfEcyw3DDNrvaNwy5DxYNneBMv0IJoOktrjyq0w0h/VDFa8CAs170AsrmnsL1fPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778604153; c=relaxed/simple;
	bh=/9CUcavU8TiWfRc0jB2jMHL/FfWKCpbzEkEl4tJZN5o=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Heax/x0uF8nK6H/CBjsEFy+pT1Rs5STBGdaLuKCH395TfT+AaBfTdd5057lmTPwjNeEV5AmWW1cKiIdefXWnbWRwDYQnGR5rdVANX4basZkB5wGfXwrXSxhzsRWzHDC67IljJYUJgUvBikgjqXUGoW7IalDw31HGBTChaRxJH8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gtSlomO7; arc=fail smtp.client-ip=52.101.65.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sqUOJHW/g1T80K+3dKwcouRWc7y/Vqz+H/BBiAMTusCF6owt9q7GV4nK1CPe5qtQrrCAKgHRTlUMGqMYvSi1GVQnffG9ike0z8SjClka5+cAFa4Zq6uCQPHNmvULzlBpU7yrEqNiCwuJ4xwxGCdWO0vFtGl9XMULGGUgimVReEHUQEOTh7LdgpdwXNHO8AYuAkEYrS43SUefMMxoN67ZDFhWe3WgkY5kRIgFHIXPGgc0nQd/XJsf69AZfpIRYd8tnNo6FqV/23NlNR7NKoqCydN+2M6oBuNg4JE7zrHw1AAuZPLhV/saUdSSHdte60m/ENof9/Vty59aVF2ObmN+PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4enxMNT2o69moMLBGWa3aeC6sYCv9GnaCyk4BnOUaw=;
 b=JmNhP3XVhUepLzAnmCNI2yvlM0+hkviz0ysk8wU6vHJdjSRMpUIVekudyZkp2nu8EhNZbVPQl5YgHLi20lIT1vww8kdP0At1/xK1eJJms8Mjm6GaKgEM+x6z4PoNeH1WQc9na1tyegzXHAAJTZnlzm0UR48hHi2Vz3JETxfVF5PoxGPNY9t5mKAVoTt1xfuCiiaLuB4tficlwUkzgaKszsjbzABeA4P70Yyw9cetvWEpti0TwYC36k9cHdA8Xi1HQmXfN/FBAtzBhJLXH75fx4JMbu1KRg4YKvwcoCtSsleUMjWFJ0i/tsWSfqv8qWy4ptOapk+TS+8u/XJnxW1cDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4enxMNT2o69moMLBGWa3aeC6sYCv9GnaCyk4BnOUaw=;
 b=gtSlomO76eTHosYu5olmlzV2piXhoCsZtkKZ6lxlMqN/uMwsz6KaGRJe2gfMC3USdHNM//n7v5fAbjsnLwHAVDBZHa3T48GHIrx0IvNALz+VkqUndYkc+iZHilFfrn6h0ii1Sd1TO79+G3P4TzBVpdRoR/bIVLiOOAVcUmIbQVO3TJV/z5cJPsCz7rA1I7PdEzkJrvA3jrvbruApBkBqDn+heQEy0gguEf+t7U62u1uKH/K3TqkFgjZUqS0O6dQ75lx1MFw8zDfrJqDlzpCzWNWg/KlUxAKKndXNRrKGfOv4mKJGpKtyjUctL5RoUs0uIEnriMdnTwQ+QJ8XzC7UXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by GV2PR04MB11834.eurprd04.prod.outlook.com (2603:10a6:150:2d5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 16:42:28 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 16:42:28 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 12 May 2026 12:41:59 -0400
Subject: [PATCH v5 1/9] dmaengine: Add API to combine configuration and
 preparation (sg and single)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-dma_prep_config-v5-1-26865bf7d935@nxp.com>
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
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778604135; l=7383;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=/9CUcavU8TiWfRc0jB2jMHL/FfWKCpbzEkEl4tJZN5o=;
 b=x+HqzZd74KJsqWQsBONIJa1fqtfn0e228f/4RSDfJmcVn/09sIKR/FeQ6Y3LoU3kz+TIQceHr
 kwTU5YDzRC6AdZAe4tSiy59DnQFWRjL8wLsAsQebV0H1QCAhMFfx/CB
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
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|GV2PR04MB11834:EE_
X-MS-Office365-Filtering-Correlation-Id: 050d8799-8491-434e-d3e7-08deb04573fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|19092799006|11063799003|11062099010|18002099003|56012099003|22082099003|7136999003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	a+ma1fkhf/XTKaTZBk62u/hYRx2Tkq25iR1eTEnPr+vc4ENQQVd3XTDQKTfRJNdwdPh4yOuRDSvgk124THoF43qgjYK9lUsGyP7vI8RgCDH45qjiL8nwX0i1w8RnqSAqZrGtucoMBBDfamDYgKQGSlMmhQTN6FePw6vEFLVgHNVfB9Jf4fh+0tQSZUgcTbptY9Sv0YMS9P+0iqP709dCKAFcY04b7l2uR0poLdcykANUiPk7IJzch2Rx3TSVLkf4wXsnlUIlxaCssC+OCZx526U73Ojpau+tdftwHjqiX7p9brDyWVGwiR/hj2/JIUPIapkOkhkOykhFW3WqeBoPQEG/+1nShjWC8ilzadqNMMOOYl9nSeFU2tS3jr8lk8Mhb2ROXwid3OgFJe2Hp4pbqacW+K65wrX3Fq4zVis+0K0VKmNK92XthM4Dxl626ZUSjqGRoc5bDLSEAPf1E+rq4TOeNlLX+gxq4BUSnBHV3noi4tBROnGe7MopGoev25ZIWfSYt8mhlaANVV5edBnDyigOUTvsrTSWWEZjbZLb20mk1NtJcBfasct7rNceyDe6YZBOcbfFjx0zCtUToWla7xj+223RkiucyovjNqUhxn7FvMcypl1WC/tX5KNXhpc1yZm3Uf+RlTMTWV39gdKZgL9WOKyBJM39Au4rlGXT6vIBuWQh65Jxs68i3QniQjmsWFaDWBV6ug+Bd95Yiy2Thl00PvVKGLe8EZB/Jh6XO7avnosedcttFduNcdXxaQm+bYvKIFoJbHjOQy180G0/yA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(19092799006)(11063799003)(11062099010)(18002099003)(56012099003)(22082099003)(7136999003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXdMSThuakxMeEZTZTlBV0k3V2ZJV0g5TVlHME1IVXlTcnUwR1ZmdTF4UUJI?=
 =?utf-8?B?UUdvbytVbTJCbkdsTDZHbGNwbGwyTnB0UHh5Zm14VFFwRy9sZE9FL1B0eDdC?=
 =?utf-8?B?eFZSbmJxaWVZQkpvNld2TmxVMys5bzdaaHQ1VTZlSE9ISDRnTE5PaXI5VkRx?=
 =?utf-8?B?RFhSM28wcmFsbUZTNmlVekIrT3p4dlRyb1E4MFl6ZHMyNU5VS0tTc0sxbTNT?=
 =?utf-8?B?eEcrOFU3MmZLRmR6UjBHblM1cVdnRjdCOGVMQkhEZWFCcFJDN09zckkxZk00?=
 =?utf-8?B?Y0lMK0ZuSHRod1ZnQVZVR0ljVTZadk1GajNFTVRaYnZ6ZmFubWlkUXczS0Zy?=
 =?utf-8?B?UlZtcnUwZml5WVI5WjJ2d3JqMTZOcDBEdDM5cnNUNWRKK3M5blc1TDl1MW12?=
 =?utf-8?B?Tm9OSlYycDdoV2M1cXRRdXZFOGNmZUFMVm9nREd2NzVHYk5BS3NPNFZ0RTJV?=
 =?utf-8?B?OXZSNjNHNEhPRDAzWXdNRU5leXNGcXBRbk9xTUR4OXpVZElHQzVmQWxvVERC?=
 =?utf-8?B?TWNjRE5tcElNSUVDT1hDYUhLNXhWTWJSNWZlZ0VNM2o2MFhmOUZjVkdONFRG?=
 =?utf-8?B?elVFb1RCQWJJbEwxQ1VOZEU2VzdUaVRXbEtmaVBZNitUOGQvb0RZZHlidjJB?=
 =?utf-8?B?Yk11aEw1L0hwOUcrcWlINGNmc2RFWnAyRlE3N0Q0bU9rcE02anhvYXh3YWZK?=
 =?utf-8?B?VEhqNytxSERlVzVua0hkZTIrbnlNcFdiTFc5TnlEekZUVTNwa2ZnMXVJTU0z?=
 =?utf-8?B?OVZENGI0YUkzc1JSN0gwK1cwL3lna3NPVWhFZVZYMnJ5N2FGbGlNZUdoZjJE?=
 =?utf-8?B?L28yd3NUYzBkWjZhY0JUZGhTVFdLK1JRQTFGN2o4b0JUUGdrT2Rha3BIbDZR?=
 =?utf-8?B?QTBrVGJqbWdLbU81Y08zdkFkTkZVeEs3SEh4RHl1YSsvUEErZDVIVlVNNDdw?=
 =?utf-8?B?QXVxQnRkTVBmMmg4VjRseHNScktleEVlT0g3TG9xblpwbnZVbTFkODNuM1pX?=
 =?utf-8?B?Z09iK3JlaGtGM2hNMUN2bFROdWZOUkIzOGhrRUl6TlNBQlVvK2ViMElTNjJV?=
 =?utf-8?B?R2FidlY4cklMbjFzMmg5c0xkWUNwWmxLSnNROHRVMHQ2T0RRTnBUUlJMV0dY?=
 =?utf-8?B?Q2hLNWR1UndnS3BxTVU5UU9oZlVsMGdQOEc0OVZWNUU0YU1ieUpIb2JvU0lZ?=
 =?utf-8?B?akN0ZitRMWRtQzByNHVHVGlRMXJZNTRSUnNlYzVhK00rdEY4a3J3UTFqMWZI?=
 =?utf-8?B?bjc0TEJiS1d0VEY0emk2elVCUUhFYXJ6YVh4UEtNbzNLOWpYdExucXZXVTJy?=
 =?utf-8?B?Um1VbTdxVWdrZm1ML0Y1YXdRUGh2bjl6MW50bzAwZEovRjA1czk4NS9jSStG?=
 =?utf-8?B?OU4zVURKUG41b0JIN3U4RE1LMFRoeTU0SnVtZDlvam9RRmxFcHFuOGdqSWw5?=
 =?utf-8?B?K1VEajZBUEdCdXluZHZLRFE5K2l0QnRPelJRd2dVZVAwR29FS015ZTFYUXoy?=
 =?utf-8?B?cjVWTFRxOUhNV0V0UnI2UUNSdDVIYklmVDJJci9jVW5QNVdxb0w1VjY3b2lr?=
 =?utf-8?B?bUdOY3VBRGxBOTZ0U3BJYXkrZ1BYYnNLSTRzeDBLUXkvM2lJdWZ4RzJobTN1?=
 =?utf-8?B?UlMzMjVLZC9hSlBHL2Z1S2FKYjMvNFJFQXIvV3dyRGlCTFc2azFIUXRmcTQw?=
 =?utf-8?B?a3dlMkRNbW4rWnJvLzltYmtJRnh2Z25UWklYOTdkS0Z0R3RwdFRUeElaVkE1?=
 =?utf-8?B?QzFhR3dVZ1U4K0RVWWxGTmlaQ25qNTROQ2lkQm9RTzhQcE52SzJ6UGIxajBN?=
 =?utf-8?B?c2gzaWRJL2pIYythcXlnbjFacnZUamE4YzY5T0tweGRZdngvd1ZZOSs0aklw?=
 =?utf-8?B?TDRJR1NNeWpleVdBNG9lVHZnY1hzSktHMk13OExPeWgzUnREckI5bzJLeFJT?=
 =?utf-8?B?NnVUcUowWGU2VDN3b2R2R1VzQWFkdkhROFRSV3JEemsrRDkyOEcwK1BLZm5Q?=
 =?utf-8?B?WXRvWHowRmNuRUV1cXVnZFQzMG1Tb2htdkh4SUw4UzRIQ0FEaXh0MVFZUUUw?=
 =?utf-8?B?OUJnc0puZDdIOE56NW1saitCWHI2TWRJZEUzVTAybjhNcGRCSEFJRmk1M2FH?=
 =?utf-8?B?VzlsNXJMOTBkUTROdWtZd1RmOEllSU0vVDBxT0xacnJESHpoSU9HL21CczN5?=
 =?utf-8?B?Zmp1QWFPSGlUMktQSDdmS09sVU42MTF5dXJKL1NNbFFCTzh2NUpESGlxZFpH?=
 =?utf-8?B?V0VTcFI2MUs0aTBaOGVSZ1diZGFQaFMwQllpVkhWOHA1RHYxQUhXbkg2Ulpq?=
 =?utf-8?B?R2tnaEc0bml6VzVZWkVIZmYvNEtZY1JOZW5YU0JDdUY4Tk1vSnYvZz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 050d8799-8491-434e-d3e7-08deb04573fd
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 16:42:27.9661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9F8bnIrKjniO/hiXYGRmcCi0wG+2sGqWpMryMMV+R4iBNazFNHh/YDbHcr/uHx+t8VxsjExx1KARSAbqXAyHgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11834
X-Rspamd-Queue-Id: 9438A524FA8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10371-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v4
- drop context in device_prep_config_sg()

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
 include/linux/dmaengine.h                     | 63 +++++++++++++++++++++++----
 2 files changed, 64 insertions(+), 8 deletions(-)

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
index b3d251c9734e95e1b75cf6763d4d2c3a1c6a9910..defa377d2ef54d94e6337cdfa7826a091295535e 100644
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
@@ -934,6 +935,10 @@ struct dma_device {
 		struct dma_chan *chan, struct scatterlist *sgl,
 		unsigned int sg_len, enum dma_transfer_direction direction,
 		unsigned long flags, void *context);
+	struct dma_async_tx_descriptor *(*device_prep_config_sg)(
+		struct dma_chan *chan, struct scatterlist *sgl,
+		unsigned int sg_len, enum dma_transfer_direction direction,
+		unsigned long flags, struct dma_slave_config *config);
 	struct dma_async_tx_descriptor *(*device_prep_dma_cyclic)(
 		struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
 		size_t period_len, enum dma_transfer_direction direction,
@@ -974,22 +979,44 @@ static inline bool is_slave_direction(enum dma_transfer_direction direction)
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
+							   flags, config);
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
@@ -1010,17 +1037,37 @@ static inline struct dma_async_tx_descriptor *dmaengine_prep_peripheral_dma_vec(
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
+				dir, flags, config);
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
2.43.0


