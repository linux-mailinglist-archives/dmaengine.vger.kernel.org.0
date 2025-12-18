Return-Path: <dmaengine+bounces-7811-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DF4CCC9BD
	for <lists+dmaengine@lfdr.de>; Thu, 18 Dec 2025 17:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EA09305F3A2
	for <lists+dmaengine@lfdr.de>; Thu, 18 Dec 2025 15:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CE9357A51;
	Thu, 18 Dec 2025 15:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="labW2YVU"
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011051.outbound.protection.outlook.com [52.101.65.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71368357A3A;
	Thu, 18 Dec 2025 15:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766073441; cv=fail; b=nEoaIy97XYT5tb+yIrhYBLKN390UnWRkinl3dMKeePjw+yQOLCsDiTXlGciJhCSg/qBEPQi8K8tE16MpByC1FqPvqR2fCYJeanDCm/Ou+jhavULzrHGnl7Id4m5L47HHIBb6UjwDDGLT8GDb0pcl5KLysyF5Pu1lRxeK9u7cyGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766073441; c=relaxed/simple;
	bh=W22vmKstXYkmIGhE5qiPeFJ0wc/jLIRMR6F2v6Pa+AA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=GB3ZawnsgnXx45JDK5pdWC+Dnn23Kr9Zcm4zxQ8fM4pHmeXL3ipxUHvOBkvNZDWJZOWCtVB3xjGp7NBdja3QmnoaYGkX0aguBSUlXya0TQLqQq+V52qEsZqMrFUZM/A9b9tv1Mb9uMWMvjXrj3EgTlT7GRvhWWLg+ta2jhH0dsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=labW2YVU; arc=fail smtp.client-ip=52.101.65.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kvIDQzqF8+lpXUGKM6KB725SYAuRYcH2yGFFidoaRcA9rnM91w5fNtSCgdBB6biOORGTMvwmwxnJBj9xDOkO2rWWYRKexEfmTNCe0hmMoekjeZk3Et3A4TChybXlp/ZfLoOzZ4RZDu7Fl2QPK6dQpky390fgboTJ7EIlxP5meN/BIzXKU/lNx3qzPr/7ZoRA/ETqXd10mPFc+0dBID48UtqQb0OxBKQXN4oRqlJOnwyjHAwJInRtrx8cGLA1sz4y461kyuX4EapuORPzXHo9Yb1lskfd57ej0pBbKuYCY7MEtw89Tj8HsfoJXl05GDVokNFF7u9Ab9S2urbvywS5gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XC/ywaSProtu82uFSFteem/sxrv8h4ktguruv15MNyM=;
 b=f1ycH2s7On7JHFUOHgVr2+nDaIyjoerT977G3XvvVLRPcf0x22pWwr8hip+LXOlp7Qtd7Zt3zohmWjldLGqcBMJ1OttsfzZSZ1H9gLL6M65tYpztzjAfSbEpGfdmMWCDh2HCc7skIcGWrjHX7p6Y9GMkGUG+6viaBHjl2i2CjrEgX7P/ckitbZ3by9w2tN9KfOZiunxe9fjbdX6ISzK7eBeEGZqdFLICyxYjd6JouP4JqSysh5Tu0X7NIK7Yxw0RQGSVh1HjZCX2aVy0DNb67xU9r57K4s6E4KWknU1glVAXFGfsqJbBBeJa1VZXsoPF31I9/sBIEFOKuL16UXM3fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XC/ywaSProtu82uFSFteem/sxrv8h4ktguruv15MNyM=;
 b=labW2YVUcHoWZFMchySMe6AetODPxFebNJ8Qpub21crs8bYRpBCIncRTLoG9xQqU1+MMAhqN8LOSP5CKGeg/c2gOKs385RVpl+C7O3y4tqibKkSgV3QBPueDzbp4NX5jvUHT0dpPfhYoL09dCIBVJrbvfEHPtP878T0ZzRSfQo9CPN72g+fCjZM9Wuq3aVqkjlvGquv+1S+T7M16k4Xw0IzBzbYaPrJE/rxLJBP7uZQAly2m6N0rszRw8s1Mb72rVDdJjqifdgotk6PvL0cL6DXEDzWYvbB8iACh37+DW/bwC+uJSVE4OwU3d8cr7mbuNX5tqt7mG8vXWXwcOTYIbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by DU4PR04MB12130.eurprd04.prod.outlook.com (2603:10a6:10:645::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.8; Thu, 18 Dec
 2025 15:57:15 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 15:57:15 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 18 Dec 2025 10:56:28 -0500
Subject: [PATCH v2 8/8] crypto: atmel: Use dmaengine_prep_config_single()
 API
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-dma_prep_config-v2-8-c07079836128@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766073392; l=1301;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=W22vmKstXYkmIGhE5qiPeFJ0wc/jLIRMR6F2v6Pa+AA=;
 b=Sb6SkBG10+k5aSqUJGbzTric1Cp8+M9fX3NiUR5rfrdTMw/RsUAKbayS7baxKVJrhg69DHZ+y
 AAF5zbz9AIID0XyYjzovqL+e0chQJsS2Xpz43YI4S/IzmXzz7bXogUk
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
X-MS-Office365-Filtering-Correlation-Id: a2d15870-caea-43dd-dfa6-08de3e4e1d38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OUNmcFZPYUJKN2Y1TjBqWWdKV3J1bHFXRzhCdERaMjF4eVEwajJZK2NIQkhy?=
 =?utf-8?B?bHJPUjBnM3p6NElJT1dvOGxGaVN0dHJLRzc3cXR3TTh1V1FQc1Y5QUVJU2gx?=
 =?utf-8?B?OFpkUFlGSVFhYUtoUzFzSHJpaS83RU5OcVg5OHRFNTV2VTlvb1JRSE82M2xQ?=
 =?utf-8?B?cngzb3pTTFVIVkc3RlhuK283TU9ITjV6VnlCalltai92QlhvN29Zck43RU1o?=
 =?utf-8?B?enpiU3Q3THVxVUI4UGUwNGs5Y0RKZjlPU0J4Z1BQSXUzUFhuUWwxb1BVdnBk?=
 =?utf-8?B?R1Ryc3hnOU9lUUtET0VDVWFWSHVhZ2NHRy9FeXZkZ3B5Q0ZrczZWZXNJanI1?=
 =?utf-8?B?RHNicmFHTXRvK1ErNmNvR3haT0h6bFFhK01UR0JpSk5SRklVN00xK1MxNkdv?=
 =?utf-8?B?NFNrVi8wM3pGSnJtUFZGMEVlZSszZFI3VXB1T3dKaW1MVHdWa2d4REhhUzdG?=
 =?utf-8?B?OWNRWXEwc1ZUT29TdnB4VW5JMWhFaklXU1dWQjRzQlRBWkE3T2xjdElvZlN4?=
 =?utf-8?B?ZjBEWkl3OEMvbWJzNzFqUlZNRDRnL2poMmwyYncrMUVOY1pEbGlMV2Yxa2h6?=
 =?utf-8?B?NWZwNktHMERzbWdNNXZNQmJxUmw1eTlqWnNIdG5lRXhHYTF2NVgyYnF1N2FM?=
 =?utf-8?B?ckxTM1BtbjVramF4aFA4R0VkcDdTamQzaTI4aWhCMTZLTThMZEdBSTFGOFR3?=
 =?utf-8?B?MFA3cTRrNDVJMHBWM0Z2TituQ3liTGZJS0lGaEc4c1RTcG9NdmlJbWZ1UGdk?=
 =?utf-8?B?RzV2VzdJTTdJY3c1SUtsRXdHWWtyc0JzelJqMTVJYksya3BRRUx5MFdDVnhS?=
 =?utf-8?B?Z3RNVW9CZkJQakluWlMyVGNKMi9VaFZsZDk0Y0VRT0lpTnkyaE1LVmxBVW00?=
 =?utf-8?B?NWkwbGlpRTBralhrRXBFNktkZjUrbG4veGx3NXI5RmJaM3pCb1k1amMvNDJx?=
 =?utf-8?B?L1pvRFd1TkRwdVFWckhmaWtCZjQvQ0JUY3lJbjJZNnpJdmI4VktQcWdvQkhB?=
 =?utf-8?B?WE14RktrTFg5TGIrZVJ6QmNxR3pocTJ1ejBMSUJ4ZHp5WXhJK2ZMQ25tMzFD?=
 =?utf-8?B?RGtKdTRXV3R2TW9oaDNrbnVkM011YUFiUXVXZzA3YldYUzVpTVI2Z29pUEJh?=
 =?utf-8?B?aC85amsrUTJuWjBicjZTNXFFQm1ycGJpRlpPODRuY3ljY24vS0UyTzZPZTJ1?=
 =?utf-8?B?clpGVkNLSTMvbkRNNHo3QzcxWVI1Z3QyRWxuS3o4NlhiOVpaWGlxUjczK0Rt?=
 =?utf-8?B?anJaSGJOQWFQR3ZWWEgxa3VEN2NvZkd1Vy9SSTg2RmNka1RNcnpPajZxOXdQ?=
 =?utf-8?B?Z2wzbjRBWjZwR0hyZkFlQTZZa1pmbkk4R2tlaENxQjFXVERpVDVqdDJFUHNp?=
 =?utf-8?B?ZzA3eU0vRlcxd3BHaE9yV3FYb0VCZkZObXlmeEkwNXpMbVRxczJhOHZGNDhi?=
 =?utf-8?B?WHZqTjdsd0NvSU56R2NGbHNPdFgxSGJaWGVRMFlyRVZLaDRYS1ZvZG5ETmhN?=
 =?utf-8?B?VkdBVkdnVVFUbHU5eFQ4MytjNmRjbmxpZ2I0MkVxRllPeTAwc0ZoZFh1VkJG?=
 =?utf-8?B?Tm1RTnc4MEkwTVhyTkZIa2tvWFlKNC81c05QZXRYRlFhc205MnphSm1kVTIr?=
 =?utf-8?B?SEZKTU1wOWRIOTRIcnlsaHRydTdLUVZnNlpONHNVM3R5T3JkbzE4NERIMnE3?=
 =?utf-8?B?NVNkUWs3SWEwMi9iUjRqWDJINktBMklBVmpvK05kMjgwVEtOZmRuVFl4Wm9R?=
 =?utf-8?B?akUzeDJPQzRIQlB0bWlhR05yN1Y0dEc5ajF3cGJQRmVCT1ZjNEJUK05INzBO?=
 =?utf-8?B?aHhjTFdMTlRNbUI4ei9sN3FtK3dKT3lld2Zad2FOTFIrMGNKUS9sTlZLYUFI?=
 =?utf-8?B?eSs5clg5TTRHeHpnaUlJSWFnN2lvR2VnYTN1NWY4d255SFU1dU54Q0tsSWg1?=
 =?utf-8?B?Qk4wUFVYVW1EZGwrU01idTROMkk5TEp6OCs5WTQwY0doUVdvbEZpWnVjdUN1?=
 =?utf-8?B?UVR1SFdRUHdEY2p0aTJBM0VNUGpkZUw2T1cvRTdvcWE5c1NNZDFkcFVtMmRF?=
 =?utf-8?B?RERDRVlMNFpHMlF5M2pFYkllOFJ6dDFmR2pNdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWJLYlhLZ3JGSUQ5MjJ4RWU3U2dXay8yK0JFQ2U2VnFNa1kxa0pSaW1waGF2?=
 =?utf-8?B?T1YzeWt0dis1N3BhT3BSa1MwOUhaR3JmS0I3RDhHVlpIWXRGcWZTMncrZjc1?=
 =?utf-8?B?Q2RGdnpjY1Znc0ZXbitsd01adUY2VngvVXhNOFc5Q1RGbjIrYm5EN1ZPTmlw?=
 =?utf-8?B?cVYzZ0c2T0FiNmlTNC84YmNmWkMvTTBUQ2doaFROWVdvcnppWTJ0ZFNFbnZ2?=
 =?utf-8?B?RGlxQU01WXlkM2dhdG9Qak9UTndzTkdiQ1V0L1JSbWk2ZmJsYkNCVDFrbk5s?=
 =?utf-8?B?MXkyTk9SU0VKY3FiQUxNZkt5MmlaUXhPSnNxT2cyLyszKzB0M1JadmlIcEdI?=
 =?utf-8?B?MTV4RWh3RG0wZSs4eTJ3cy9GSjlHblAvbitaNWFwYTQ1cHUwRk1UbFRORFFG?=
 =?utf-8?B?QkN6ditaR0dQcTBLMW5RM0lRK2ZMcmlMSFNsbWVPQXZuVE9mNmY2UlU4NFpn?=
 =?utf-8?B?YUE3U3A3Wkt4R1M0dWlnVzZFYk56bCs0eVNLNVYzblBRTTJkNWw3WjJNNlUx?=
 =?utf-8?B?WU5iK1JoM1ZneWU4SkdCZmMvbThEd1lUVVBXOUVvbE5VVGU3VVhPOEhEOEhu?=
 =?utf-8?B?Z1FIcWI1NlJyRHVmRFI1QjhUYURNVGliOWl0ZUVSbjFsbHBTMkRVN2w3NXd4?=
 =?utf-8?B?SnRnQjZ6ZzYrNHNPN0dUYlNzZmNCTEhUK0VBYngxZXl2MmFPMHJHWFNjVEpP?=
 =?utf-8?B?elZ2WTZ5Q2F4T2FybnZJM1BhZHJtV3ljMUpXbmVXWk1ka084emU0dXUrNWJU?=
 =?utf-8?B?dWJJcnJlWjUrRy9FNVdBQTBlVnlWY0xzY1I5YjdWRVNlNWVqSFZhWmRGTm1j?=
 =?utf-8?B?VXF3Z0FxOW1UTDF3Z0hyYmZHQTJqSHkzUWNuZnVqU3dmODNabnVzOUkvbUF0?=
 =?utf-8?B?bFlpSzNqUkwvMmtRaFl1dzBnMnRWRE9lVFUvNVlVeFlIaDdiUVEwWFhBeFBU?=
 =?utf-8?B?Q1RpNDdlSGdVY3VTVk8rRFJBaG9FRCtDMC9Ob0FhNjhZU21ic3JWWVl2UDJk?=
 =?utf-8?B?WXdEenRhK3VPQklSR2M0WU5raVRBNm0zMVU3NDgvRW0ydFE0Y3JCK2l6eEQ1?=
 =?utf-8?B?bzN5NnVyRDZKczc0MEtlOUpxQ28vcnhIT1RHVE5aN2JjbDh1Ni9nKyszcHdR?=
 =?utf-8?B?MzVDNko4MHVNSGlPZU5KVE5STVp0YWZMbG5qWDBFak93M0tIak9KaEFYN0Rh?=
 =?utf-8?B?K2ZBaFFsTk1Ja1M4WmdXWUJ5RlB2YnJhcUllTkg0ZmEwaGp6ZXI0VXhYVVp2?=
 =?utf-8?B?cTEyb2p4blNwWXU1TjBDbDMrb2U5aFBYa0tYY0VsMCszR0dnU2R2N2E4bmZ3?=
 =?utf-8?B?YnZlWDZpdUwvaGc2MnBVTFVnREZkZUc3ay9UaG1vS1p1TEs2L09hQ2VQNzBF?=
 =?utf-8?B?VnorYndOa3I0am5MNlFnOGpidUlWNjFaaFZtU3pjU0Y3bmhxVjhRcXBNZzMw?=
 =?utf-8?B?UmF2STljTVNGamFtWGVMOFdzZGdJRUk1K2tFRjltbVJSbGxYdTY1ZG13TzFI?=
 =?utf-8?B?SXVVZXNJTzRRVzhYMnk4d09ySWdTZFFJODcyczJ2MzZ4NVRNRHJYbDdLNW1t?=
 =?utf-8?B?UTZOOUF2QnZaS3gvM2hRWW1YVERCYTN6WW5RN3dIWDhqYTFLMEF3QUJic0ZP?=
 =?utf-8?B?a0lhazllV05TRkVsRnZHL1N6dlh4b25wRDM1Y3hNTG1SR0xQWUxORjM2cFZz?=
 =?utf-8?B?c0I4UVRXRDcvaGlody9PanpHZ1I2blZxbC9ORU9CSDRIZlAybnArVmxMN3Vj?=
 =?utf-8?B?QkkrWVo3NXJjQXdpYnB6blFMQU9rQjNPb2huZUpEazA5cE52RFV2bTN3TW1a?=
 =?utf-8?B?U2d1NGNLY2lPbFg5bjVFS3VRRU9aeS81SVdVSFJ5eEF1aERBVFYxM3pNRTBK?=
 =?utf-8?B?dlhCY2JoeGRKYjdrQjRTWGVtNTczbVVQRVBHNG96KzI3Y2xNSDc2YVJlSkJx?=
 =?utf-8?B?WHZOVldPZjlXMWlRcE5hdFFDTkxIWEpwWVorVFRFamh5bnBOcW5VZSt2b0tX?=
 =?utf-8?B?M2JvU05WY05uYzhtWS9FOVhaWGRqdmV1NVhjVnZ0cHpmcldQd2x5cFg2UmQ4?=
 =?utf-8?B?R3A2SXpBUjRpVm5wWklCckh1VkVRSmZxdzdnTEw4L2ZFbGdReERFSWdRaldo?=
 =?utf-8?Q?sQRsHChp/udB+OjtXnEgLu7m3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2d15870-caea-43dd-dfa6-08de3e4e1d38
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 15:57:15.4442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yreKFOVxsbtD9/EU0TkAJOkvfL57Jq1Ter1Kcs1omXg7IzMwVAXL9eBjzOXrQiCBOHDmdMtBWtAPjXijwxuEig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB12130

Using new API dmaengine_prep_config_single() to simple code.

No functional change.

Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/crypto/atmel-aes.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/crypto/atmel-aes.c b/drivers/crypto/atmel-aes.c
index 3a2684208dda9ee45d71b4bc2958be293a4fb6fe..e300672ffd7185b0f5bf356c2376681537047def 100644
--- a/drivers/crypto/atmel-aes.c
+++ b/drivers/crypto/atmel-aes.c
@@ -795,7 +795,6 @@ static int atmel_aes_dma_transfer_start(struct atmel_aes_dev *dd,
 	struct dma_slave_config config;
 	dma_async_tx_callback callback;
 	struct atmel_aes_dma *dma;
-	int err;
 
 	memset(&config, 0, sizeof(config));
 	config.src_addr_width = addr_width;
@@ -820,12 +819,9 @@ static int atmel_aes_dma_transfer_start(struct atmel_aes_dev *dd,
 		return -EINVAL;
 	}
 
-	err = dmaengine_slave_config(dma->chan, &config);
-	if (err)
-		return err;
-
-	desc = dmaengine_prep_slave_sg(dma->chan, dma->sg, dma->sg_len, dir,
-				       DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	desc = dmaengine_prep_config_sg(dma->chan, dma->sg, dma->sg_len, dir,
+					DMA_PREP_INTERRUPT | DMA_CTRL_ACK,
+					&config);
 	if (!desc)
 		return -ENOMEM;
 

-- 
2.34.1


