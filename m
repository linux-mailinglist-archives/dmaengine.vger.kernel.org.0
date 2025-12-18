Return-Path: <dmaengine+bounces-7806-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E143CCCD2A
	for <lists+dmaengine@lfdr.de>; Thu, 18 Dec 2025 17:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64C1A30778EA
	for <lists+dmaengine@lfdr.de>; Thu, 18 Dec 2025 16:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0D034CFD9;
	Thu, 18 Dec 2025 15:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lnve/rVh"
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011027.outbound.protection.outlook.com [52.101.70.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A2534AAE6;
	Thu, 18 Dec 2025 15:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766073417; cv=fail; b=sbjQVzj77QGRLabXknZ1/xBmV37gl6znLcx4DqGFqdb0ybbK7UyVTDOakCkuBYaegY9NbmTdHmkxap71caV7pXxRf0SJH3ZcoNtR/hOVL6wq5GZKbM/5ZgT635QVFZQShjCkSiTW+/ZmYDv5n64KwJrawhT2Y/Uk6Sv2ThF4ukQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766073417; c=relaxed/simple;
	bh=/aczepkAFOD5+Qg2pxA8JDpR3ukB4cza60QV/QoIWQg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=u0wMnJkDJJlGaxrdGpnWxHrDiK7WhZS+HoPahsNO9h6BM2pE/4bLKzV1IXkNfEyzVrdGH83Q+YUOYUUHOSbkMgsG69hqxZ0tUmRlacvI8eVWGI1jHkOMD8fi1oUKoAGtSCUvoLJUw4VAIq9JJxurgxnMtMC07tZ54DhpUSQvuwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lnve/rVh; arc=fail smtp.client-ip=52.101.70.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fO1RZAKcpOrN1Ao+QoMJIvfBS1bB39JzPRB6GEWnvdpFRAWoqdzJJUEcffHregv4SmHWVtnTxIME+UlSprXhd+QuFCG794QNSjyooYZvMv2pM67FgT+XNfTVOVHLd6lHnaRwGmn8h9ijZ+1395POQQo8MNrLqjJ1U4aAMl/00sb4Qzyn2tlhwDqqYJt11X+CfjLSG4ztlXobWiPXRk3VnQXpf9OrWaR6Do3SyBxJOs5mk6WJBn1JJiB+oThv4NKYpUvkKAT7Zprfo5s3c5E7TWVLVsCBmqgtgkiL+xEvhrNT3KrI/T+3DLiHplwzBiBCozU8tHIiqC2nwjIy18XV5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gp8sPOIsFV+IkkfN/89V1un6TXHtZ2mLu6oYUSa4wtY=;
 b=CjwbxE9RDjXMAnSgiCJiZuYAy8td0yA1NoDSa7vFa0fubaZU8c7TRnsqFtaZuKCd6brRH356vP8XL88LyKh2neYMx5XKnlDS4jSWNgU9sGFn21ULGXCumeqzV7fzHa8s6j23LOlR5Si8C9jwh9AwobHrXNlJjqJRok8rAGSABIpoWXvYxN7Gn6bmbGL+6g2ZAS+VN84WtkgKrvelEnI21O/wSyiTLyonVSFrozThtxItYR0H7DuSLEUYPYZ7g54CoZmsKa8g/rhXzzweWkr1VQvd93Bq6/obHfIe8+e0rNH4WRbFfriQnYcs2qCbrFXrKUAoACiuhauZjqlVXDGaLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gp8sPOIsFV+IkkfN/89V1un6TXHtZ2mLu6oYUSa4wtY=;
 b=lnve/rVhYOZAChV2strDmZcADFYNQP/35RINP5UEN8rrtA2KPqbFnZ3JfqNpfvF8SnGEbmn6JOO75JeXuze2AOCJgWXmBrt4kjjeXHNkfNlLOdiK7hbcyv1hnXv9M0i63HLpwrCfYfmpr0jLIC8YHJY0gEZPZQJiweOL67uCsjeSZDEm3JsaIqESbY2KjokDHT0c4zNUBdwLBsj2MLEsZ13tIXwufC4J1PsAk7mKIrSJz2SeFSCYQkYb5rbVwn3+gOW4JM7MGnAdIXoq2Qi3aRslctwtPr9z/EDCz2O/6Wb7wC6kIhiq/hnszRZyrOD/1tnXKBxSPxnzdOJTwCqd9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by VI1PR04MB7037.eurprd04.prod.outlook.com (2603:10a6:800:125::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.7; Thu, 18 Dec
 2025 15:56:52 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 15:56:51 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 18 Dec 2025 10:56:23 -0500
Subject: [PATCH v2 3/8] dmaengine: dw-edma: Use new
 .device_prep_config_sg() callback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-dma_prep_config-v2-3-c07079836128@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766073392; l=2055;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=/aczepkAFOD5+Qg2pxA8JDpR3ukB4cza60QV/QoIWQg=;
 b=miigXUHxa1Kqf/KKfnRi7dmib01EHUEDJ9aaCqxiJSSVn5s00ZkYo+7c9Bl7RBXqcszSBrcrt
 gtwXvt0iBMvCxbVK6Y+D6N5tJCKT5g6DahvSnN353Ym1DYitEpNlQen
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
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|VI1PR04MB7037:EE_
X-MS-Office365-Filtering-Correlation-Id: f21ba697-f59e-4ba8-f795-08de3e4e0eb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WTNDMjdjMzNaOC8wL2xBWEt5UTRaTjRKc0NOZGdQTTBhUkc3V1ZvRjBiNDJK?=
 =?utf-8?B?U1F4cU9pSzVMeDJiOTAxTU5lbGx6cEVZWjc5aG5oOWljcmlzSDZlZXVDNnFr?=
 =?utf-8?B?bVdHVi9HSFBrZ2hBeXNOcklJSzd5K1pDVHltMHROVGtCLzhnYjA4aEVleXFE?=
 =?utf-8?B?M2pBTk5PODFlRm0yWjg2c0JDcWpXOEJMZmlkUER4UGhlUm1hWlExdXRMNGpk?=
 =?utf-8?B?NkJDM3Q4eDZKYlY3SWV6blZ2SkRoT2dIMHhHeVhwM2xVUmpxc2xBSEVIK3RF?=
 =?utf-8?B?UEkvY1BVVGt6bzN6cEkzckZoOGptWEozNU5GWkkrSHhuOFBGVWNiU2o1dWhG?=
 =?utf-8?B?Y3o2V1A3L0hpckNsUFU3MVdJZlRpTndvWUZLby93SnZsdGt2QkF4Z2gvU2ow?=
 =?utf-8?B?QlJZNkVsbmMza04yN0Q5RmRvdVRjRnY0Z3pFMy9RRXFrOHJJalBiaVhGYmI2?=
 =?utf-8?B?VW44NjFjNXExajd1aXBLY0Z1MFdrMVZyRTRxNlk2SEtWa0hMMTlTaGtCaEFv?=
 =?utf-8?B?ZGhiWGxJM0hOdzI2cnYyc2VTalliU2hmdktGa28ydzIxUE5pSWJMUDgyaGdu?=
 =?utf-8?B?MU82akkyRmxQb1doQndFVEFKb3lIUDUySkdrTXdyeXVsemdYcE4rdTNwYTVt?=
 =?utf-8?B?NEp4MVJlOU1Ic0F0eExGSzlQZVNFeW84WnlkakpxUEs4SFBWN3lIMzRDTGtp?=
 =?utf-8?B?VFpuNFZwODZvc2hNTUdUY2JVSXRONHM3SDZwVEtwdndIRVpQSlBVTUk4SzVh?=
 =?utf-8?B?OFU0ZGREc0ZnTDVuK2NFZ2dlS21RblFMYTlTblJYSFhUMktmeEpwYVp6VVVl?=
 =?utf-8?B?em5vd0U2d09laG8xTCtsS0ZJMEpFL2E1clRPR2FnZ2RJd2p5MkI3THBFWDBR?=
 =?utf-8?B?Slg4b1d3TUpEc3VwZG5taGVYTktvVjBpNGd5WVhBNnN0a3BUR1dxMlQ5eWhs?=
 =?utf-8?B?V1FlcC9PZ0VQa2MvNnE0QTlhSjdUZEViK2c3WDd5enp1Q0FIazFQTFBXTzVW?=
 =?utf-8?B?QngyK25GNnlDU3o3TU1HcVBVN0RQZElJQVRQcytCSTRWNVkyMDdhd1lVazhj?=
 =?utf-8?B?bGFCaUNDSXVMUGtpd3gwaHpQdi83dy9KQkdsVVlDUldiYlE2OFBmUUUzd0pO?=
 =?utf-8?B?aHRMS0xENklNc2U3NGxidXJEUytVbFBXRG5aTW9pQ1RXK3UyS0VFRmcxRjhV?=
 =?utf-8?B?aGpBdXNxTUFLWkhlMS9oaU1pTFNxRmRLKzNMbWVIV21tWkFOSW5MQldBSHZF?=
 =?utf-8?B?aXIwdUdHam9oKzFBSEltWjNCNXhCNW5EaDVPc0ZEWCtnZDJNRm1TOC9TQkZK?=
 =?utf-8?B?Mm5sdGVpMXl3N0gxb1liVlA2UC9tdHRWNFM2QXAyTEJJdTNYdGY1bXlvSVpO?=
 =?utf-8?B?R0pObFVNcHBCbjNHdTZ6Sy92YS93b2hjSXRwcTBZOFVCR1dTUVFSUTZBYjls?=
 =?utf-8?B?d3k3TjZOUndIU2tUT2t5blZKN29DemZGUWdTTEZSRWliUDdkVURaODF1ZEdT?=
 =?utf-8?B?NWczMFREbVo5Vm9ST21LUGIrRTJmRmU0K3lYRHd5clRGK2w1VW1xOUIycWx5?=
 =?utf-8?B?aDl2Yk92OTZhdFdwZUhmWGpyTTZMaXVTZXJrekRhNEJoRmRXZm5ldVZxc09k?=
 =?utf-8?B?RG9ndXovRU9IdnEwZ1ZuWkJERFAydHplOFNzTVMrZUc5ZkRNWjFla20xaDc1?=
 =?utf-8?B?cW1UakpOQms5TFk1ckthU2JKdHlwb1I5TEFFVHM0dWNXKzVRTkExcVpKa2V3?=
 =?utf-8?B?aFdOQWRuN2x2WXRmbnFOdzRFbE1aUXhkQWpCa05Hd2pyWGlOc3RqdXREU3RH?=
 =?utf-8?B?V1FPQnVPNjdXSFhZa1RBc2lJQ0hFTlduZXc0UUh1YWNCOWNRNC9kdkEzNXNB?=
 =?utf-8?B?UHl2MzhkM0FXTDV3bjBkZGk3MlhKVXNiaHZPckRyS09GTWF5WEpHcVluMVpQ?=
 =?utf-8?B?RHVwcHRTa3FFQXNNRGVRTkd2TDk0eXpyTS9yK2RFdXEvbUVDL3BCdGg1NjIw?=
 =?utf-8?B?OGlaZFV4SXBBRDdrT3Fqa3NBaEE0Mm05b1hSZWp4R1FNNkhwalV5SE1qKy9G?=
 =?utf-8?B?VGlMeTN5bWdXN2ZMVnlHbnBKdjFscHhTcFBiQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGdlVC9JVmFqNHVVQ1piSkpWeFRKZGQwejhILzNyWHpPdjhSQ1JoWmw4WUNJ?=
 =?utf-8?B?K0hFaFFTRkRuMDMwU1BUNnZSOVAvemdnSThuaXpJTXNBWWlSNVM5RnluSkNZ?=
 =?utf-8?B?Wm01L3VTSFBkbi9YVzdncmJzbXB4TEM0UzdHWUorSmhmU29UYmNaOWNQSGJy?=
 =?utf-8?B?WFlGbnVsSTlmTEtGdldyVXI0dm93MndlTndvSXFDakdIMDZIdnlPRVAzODRp?=
 =?utf-8?B?TTk0c2pUMlYxZE52SFYrcFJ2TW53cGk5RmZNd2R0Sy9UQ0lZd0VQbHowQUlk?=
 =?utf-8?B?amg3SG5PT2szeks2TEVGYi9wVVM2Z29SdDdCa0QxazlkdytvM2lOL1NIMkh6?=
 =?utf-8?B?S1VZYnloTHJJOTdKY2IvMExib2J4OCtBVWdRMzZjT2trSHZ2RklOczNUN3J6?=
 =?utf-8?B?cHRvNlNsL3JVTS8xaElqL3Jhb0xvczZoNDZWWWpOc1NBQVhaRG5UbnN6d3Fi?=
 =?utf-8?B?Y3VlMnc3ZEtoNEdRMWN5VDAyRFd3ZE1VN1dEZWQ3aGxxcXFEZzJ2cGhiSkdF?=
 =?utf-8?B?WXZVVExwWlFtekVwZkFiVTk1Q1RwV1NrTXNHMWJEdTI2dUNLWThFTWZXWUxu?=
 =?utf-8?B?d0YyaU5TUGh1U21WajlxT3NwejdldEZ2QWkzMFV0RmxBNkpkM3ZYa3JKS3o5?=
 =?utf-8?B?eU9tUGxDR2prL2syVkhhYmdiS3pFSDVnRnI1VDB2UXBzKytpOSt5UU1hZnBm?=
 =?utf-8?B?eXJENkZXWnNqU1BTaUpuTjBvWHN0OGp2N05ILzRTcWhON0RvYmc4RVdUMjFO?=
 =?utf-8?B?VzFLMEVVMFhsdXpDdHMrYTJTSEd3SnBYM0J5SysxYnEvMnpUeTNJWnQ4aUFF?=
 =?utf-8?B?UVduZm5sT1dIeitNVTFYWEJCbEUzemphYmVtZUNCNFdsd0NlNy8vb3pOYWZ1?=
 =?utf-8?B?Y3NNR1ZQR3RpRTlhc2NQOGh5MHdaamUyN2pXNU5VV0ZBQzdhL0JTT2RwcUJw?=
 =?utf-8?B?SnFWYmN5dXFxNWtVVDhxMEdtQkxKSXBlS3VrVTl2SW5yTHVJcmtia1NBeHVT?=
 =?utf-8?B?aEtKTGFtN3pNaVhEMno0UTJXdUJLY3hTMTJTdnhLZjQrOE5QSUFvcWhDaStR?=
 =?utf-8?B?VlRVZ3BodW11YVlZZXo1TUdUTlUyTmRVejc1SVVSUmVnbUp4QW1UTFVZTjQr?=
 =?utf-8?B?NzI5aEF6OGs3U0JuVWFRSmlxSStwZG9aLyt3cUo0cENDcVN1RGZVRExSRlNP?=
 =?utf-8?B?SGxKVW15dG0zQlI5eUdOdDBoRDlJR2JxZkdxTDdJS0xDWVVrR2JFT2kwQlJK?=
 =?utf-8?B?MHBzc1hjZVg4MTZEaFI4V1oxaWNWdkVibTRSd1VFczE3NTJCY05HbHVZK2NY?=
 =?utf-8?B?akpKVmZyOFhUdjhMOU94eTN6TzBYSTJpQVhmRDlHQUZzaG9PVEtGS1FvdGlY?=
 =?utf-8?B?ZXB3WG1ndTJlZnFTeHdjVWtaSGc5UTI1eFFzaTM1RmE1c1oyaXRIalo1MURG?=
 =?utf-8?B?ZjMrTlI1eHdISXlSMWhnWFZweitSSjBtN09CWWdRRlZaQ0o4ZTNBWDRrU0R2?=
 =?utf-8?B?U1Y4V2NIUG1JUm5wSzNmWFFIRWYzMXg4a1F2aW5OQnJ3MWtFUDVkNUZwWUUr?=
 =?utf-8?B?Ymd4dVRXWmxKNkFMRmlNM1NhcTc0MWU3NERxRGkrckZyOS93MlhHTkRkVjVF?=
 =?utf-8?B?Y1lXSXFkTmZwaDhLMC9YV0R0TDc3V1A2NXhEcEYydUhHYUxzdGkwK0JtbmN4?=
 =?utf-8?B?dzIxK0VqV0cvWVlxQkd5d1NLRUV1Wk9vL2ZmMHVSbU5mam5jMTR4c09maXU0?=
 =?utf-8?B?R3l0b1RHZ0liSVBjVVNUZjA5eEZFT2M3QzdFSi9XUGFDWHFOeVFIdk83YkZE?=
 =?utf-8?B?NFZMUW9mb0lYTk9iWVNvcVhOS29jaEM4T09mMlAzOFlSUzU2dkY1UVNGYzhW?=
 =?utf-8?B?UnNleXFhMzZXTm5GRmx3anVUYUVDUVZsS1VTZGpON3hSYWpCTzY3RTJIOHY1?=
 =?utf-8?B?OTFvZTIvZTh5MDI2UTdCUk1nQlNBWFFrYzI0bXRPbmgvVVplU1RkdUJaZ3Y4?=
 =?utf-8?B?dllIUVJyVnRLYUVXM1JEc2tubFZCNmk0UGphUVZsRUl5b0RNUHdZRmZtaWY3?=
 =?utf-8?B?eXh4ZmZaYzlHc1B2T2p1N1J2TWNYWEFZVWVFYkd1VC9vTU15WnRqajZ5Z3Yw?=
 =?utf-8?Q?w/WFGFk5xqtisFyHRhngfsBsg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f21ba697-f59e-4ba8-f795-08de3e4e0eb6
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 15:56:50.9596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uVXXa2/6dLXaIm5Cice1tHYQEttvxgo/sdOYtky+D3CLP7UWQMi0loOzzlqdBgYEAW9xUyoAToHf0Nq30rHZzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7037

Use the new .device_prep_config_sg() callback to combine configuration and
descriptor preparation.

No functional changes.

Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/dw-edma/dw-edma-core.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 8e5f7defa6b678eefe0f312ebc59f654677c744f..e005b7bdaee156a3f4573b4734f50e3e47553dd2 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -532,10 +532,11 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 }
 
 static struct dma_async_tx_descriptor *
-dw_edma_device_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
-			     unsigned int len,
-			     enum dma_transfer_direction direction,
-			     unsigned long flags, void *context)
+dw_edma_device_prep_config_sg(struct dma_chan *dchan, struct scatterlist *sgl,
+			      unsigned int len,
+			      enum dma_transfer_direction direction,
+			      unsigned long flags,
+			      struct dma_slave_config *config, void *context)
 {
 	struct dw_edma_transfer xfer;
 
@@ -546,6 +547,9 @@ dw_edma_device_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
 	xfer.flags = flags;
 	xfer.type = EDMA_XFER_SCATTER_GATHER;
 
+	if (config)
+		dw_edma_device_config(dchan, config);
+
 	return dw_edma_device_transfer(&xfer);
 }
 
@@ -815,7 +819,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 	dma->device_terminate_all = dw_edma_device_terminate_all;
 	dma->device_issue_pending = dw_edma_device_issue_pending;
 	dma->device_tx_status = dw_edma_device_tx_status;
-	dma->device_prep_slave_sg = dw_edma_device_prep_slave_sg;
+	dma->device_prep_config_sg = dw_edma_device_prep_config_sg;
 	dma->device_prep_dma_cyclic = dw_edma_device_prep_dma_cyclic;
 	dma->device_prep_interleaved_dma = dw_edma_device_prep_interleaved_dma;
 

-- 
2.34.1


