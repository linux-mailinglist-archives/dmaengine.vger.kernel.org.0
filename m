Return-Path: <dmaengine+bounces-7803-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3F7CCC960
	for <lists+dmaengine@lfdr.de>; Thu, 18 Dec 2025 16:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2C03F3008552
	for <lists+dmaengine@lfdr.de>; Thu, 18 Dec 2025 15:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D527359F82;
	Thu, 18 Dec 2025 15:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OG+x/DQo"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013004.outbound.protection.outlook.com [40.107.159.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29516285CB9;
	Thu, 18 Dec 2025 15:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766073402; cv=fail; b=hEwrZbgepbMtEB6ib2eulgVZ41Au01Sp8JGL6Xx6AplVGC8OtqvKcOdfFt680i5/9yoR/HRCrfG0IABh1u4jJxQDHPXmSsCZ+0OgwErovRdXJbI/fVaCa/EQEvz9yqR4ywIQEhLQ3scdg6FmKQLNjqNnJShY7AAAjtY+KHzEXBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766073402; c=relaxed/simple;
	bh=0i1pyQAPcjqNYjjD17FWXhK8EXSuxYLG2bQc6bdiGOI=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=d9lpjiOq7o8jeyYTMyLFayrjaH1nxPTFLgpLFoaGVNxj0LvTL1HPvDBz0f4rdiPNjoeGGbPhszHuG9D++HPhOv0ueaLiEYPXaTO5Sjh+K9noy0cbLryjFntyIFu9j7ADvuAZFr0gi5fyZ57lQ6tfP1+oJ9NTtNcgFQ3wNnRu7v0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OG+x/DQo; arc=fail smtp.client-ip=40.107.159.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SuSYG4cbEFDnI0pufktnVD6g0PWFpcUgJQzNgHX324dwJV05ua3uLd4e3ej+z5fbPSf+YHTJDTy6lmYKz40dv7CxQLQJk1lFwleoJ45Bt9FpKIKRHWVDBgVTpnWbWvrPuwPvDtaak/2yRzQ7hCHemJnHR64TH1Y26EjpYPeHpTLkKskW12T6wi0k9oq6ke6Pl7UmTLZYcP39a0PxwmGUALM+JKXX4/SScXmSDtJuP6tuxHG2Ogc6AUhuJ1nvk14hEV6VfwdM+/mVvSx47CTEDb/9UI1jhOEL153FEnrZBGJLi3HiIdZ23fP+EhWojxYcJoWYTowlr0xGT6ypGXdxcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rId2I2W6UtEuRN9qhq3Md+/X3shYapyFLYneDv283BM=;
 b=TG37OjaIF47HttUpoOyFcsHkjhkyzZmtT4MWOgxiax9ApuGlfCAwt0eMJzIAW52+X1eyO+iOCaUmgrqfxBv2V+gi3seSKQ6cErQrUvcA1AzKIJYqwQTqtTSeIpiv0YnkWU5hwa4b1uEWwvU08rgDpjYjF3iJElCByitPHnaVsWjL2h04wpWqx81l5e7hhvXyTOf47NveXVP00Tv+bLCRtyVfGYBREuCAAHDjRmyXlE6xfg/jXuUVCnzR618yr9hQRSSPMPK405Ed+END543BxcTg3nnKZ8LJCRTe5Tp8WFvlFe++t0qT08D0x5t7sPwQ2LV7KfjHhB8T9XeY/QVAJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rId2I2W6UtEuRN9qhq3Md+/X3shYapyFLYneDv283BM=;
 b=OG+x/DQou45ta9YILTO/Eh+P4PzYtY5SdMzDXx4jkzneSdmKShixXs66JpfxfxIPuSLe30vr3+Y2zPFaQUgP3bVAHRNhlOp9fnj4abKSEIPBCHSn0ZY9lngE6Y6F5krEU8/AHl0wG7g+UQDshsNnWFtnmmk4wzDUCnAmntxka6gfPlRr+uK3f2CXs1tn7g15pfyQRuUetuEDMxqBEfQiBl0tKluZ6oUQu/X6pUbgZyLGZV335kmwQOmnoc54UzwAKQj3TZg7OsvWyOA3pgrf9nhrq9MjsClb6k0T7p9QqD7MdZcwz1x1IykAkkXyYBijrl6NvHTXFdUYZnVoomjGng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by VI1PR04MB7037.eurprd04.prod.outlook.com (2603:10a6:800:125::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.7; Thu, 18 Dec
 2025 15:56:36 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 15:56:36 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2 0/8] dmaengine: Add new API to combine onfiguration and
 descriptor preparation
Date: Thu, 18 Dec 2025 10:56:20 -0500
Message-Id: <20251218-dma_prep_config-v2-0-c07079836128@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACQkRGkC/2WNzQrDIBCEXyXsuRbdav9OfY8SgphNsoeoaJGUk
 HevDfTU4zfDfLNCpsSU4d6skKhw5uAr4KEBN1k/kuC+MqBEo1Bq0c+2i4li54IfeBRno9VF9qi
 NRair2g287MZnW3ni/ArpvR8U9U1/ruufqyghhTnpm3SGFKF9+CUeXZih3bbtA+2bkhysAAAA
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
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766073392; l=2647;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=0i1pyQAPcjqNYjjD17FWXhK8EXSuxYLG2bQc6bdiGOI=;
 b=8HhtyQ8XKWBuKPkgJF63GLSdN58WTB+gusiMIttknghRpml+OUl1q4yC1vkrOD7VyruiFmof+
 svs4QG2nt2wAJgMCAguwZnN1GFsduE5VkQ2GHV8VehcVdVtSJVNQZuB
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
X-MS-Office365-Filtering-Correlation-Id: a037aec8-0c07-4a30-7882-08de3e4e0637
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MkNFNm5NZXFaOU92aGdSUFJ2K1ZMZmdlTWJpRXl6c0kybE8wNmc1YjVxUDJH?=
 =?utf-8?B?N2pQdmtRRU9UVFNLRlAvNGVYbTZONkM4R0RSNUxLdklhMklKVTNGRWg5c1o1?=
 =?utf-8?B?cEVNS1RTTloza2JDRHAxelVIZWF4TlpIU2JUZ1FYS1FnRVk3ajE0RUdRNzJz?=
 =?utf-8?B?ZjNDcHRMakE3bWVoQk0ybFcwWHZJbVdGM0E0QnlXZU51WnpkblZldXRlMVZt?=
 =?utf-8?B?b2lML2lxcVVTek81OTJxZWkwdmlPTmwvZ1FvRW1rQnlSWVMvaW5zQW9LY0tK?=
 =?utf-8?B?N2plV3htNHNQMEV2WWVXVEJCQXN1V1Mzbjc4MVNzNTBBMHN2RndPOTdiV0RH?=
 =?utf-8?B?U3ZpZ2hIb3JJRW9DbjZ1MU5QRHZESnlTbkNidUdtUk1HeEhBNkhKTGhSVU1K?=
 =?utf-8?B?Y3Fjd3pWc29lWElib0s0KzB3c3FxTE5YT1l4c2lrVk51Yi9JU2liWlpxWmhJ?=
 =?utf-8?B?Mmd3OFFRRUhWVVpDT2JNWnZTSzZ5U0M1K09CaFhqeVEyYWozVFRpTGpGYS9X?=
 =?utf-8?B?dElmZkcxMnpKbVVzN3oyaE80UkJuck5wakMyYlJXQmdHVjB3ekIxSXJxcWQ4?=
 =?utf-8?B?QnIreERnNzNWVzE4TCt2VXdEcjl2d3MwajFhRml6dFNmYkxadjhydURnamRv?=
 =?utf-8?B?dnY0Rjc4YS9xc1BRazdadGd3U2M0RHo2Z083cEFrT0h3dHRSUFdpV1k0MEtT?=
 =?utf-8?B?QzJhNnBocE16QWpoS2JkYmx5V2JkeVlObWhTc0ExVEdtM2pnd09RMjJHamtK?=
 =?utf-8?B?TWRQQlhLV1NQWDVSTzhzSGEweTdNakNKcmJnSGxhMXlFRU40d3dTNVZxcWYw?=
 =?utf-8?B?SHZiYzVHU0ttMjhpeGVQMFRmT1BoN0ZXbHc4ZFZndzIwOXEvSHh0UHdmY28v?=
 =?utf-8?B?eUgvOEk1SUVENzVQOWJndVBpQmk0eW00dSticGUyY0tWbVFnZzMzRVVlZjVp?=
 =?utf-8?B?Yng1OTE1SFZVY0xaa0d3aFc4STE1bjF4dFFWY1N6MDQrNUtXMWgvNXVyWnBr?=
 =?utf-8?B?NWtBTnFNeFptVmk4QVNtZWlhWTZmRUhvT25SZGh1a0ozZ0JUc1h6bElWYWVC?=
 =?utf-8?B?QU8vdTlXVHBaTHdydElDbzBTaHJNTGlWcWlZZTdqa09QRUllb2lleFdRUGlR?=
 =?utf-8?B?M2dGcnJabS90WGloYUVBNkRtZlJwWWRSZVBlZWFIdHUrSDZSNFRwM3JaVjN5?=
 =?utf-8?B?aFFNOWg5cWdKc2gwMGNQTEdhT010aUxaMUwwTFZwYmw1MW12WHphbjhGdUM3?=
 =?utf-8?B?L3VtWUdFQ2hLYzZaUzVxN0ZueFh5SE42VmNtZ0VOTWpqUy9aZ2h6Y21IRS9j?=
 =?utf-8?B?ejZ0ZW5CVGZvN3Fjd1oveG0vT3U5cDBuWUNWejBCQ2V4NDlpa0ZPKzUvYnFz?=
 =?utf-8?B?eHZLaTNNL0VsTHhwb1FiRWRzVXplZU96dFBqWVRWOE9ob0k2OUsweG4wZTlm?=
 =?utf-8?B?MmFtbnZaSktTRzdwNmhSaWZrbjVkTEppOEN4QzZHSnpmUGdHeGk3eUVtUU9h?=
 =?utf-8?B?V2hXN2tCdWdoaGRsTkQrZXpuL0d1b08va0YvQ3hsVTVJTlR1QlFXYjlyUzdD?=
 =?utf-8?B?L29ncllQMDR1Nll6Umh3eHFUOTlhaEtJS2orRGhUYVBnblR4VWZTcmlMWGwr?=
 =?utf-8?B?aWpDRXBYK2VSdDlEZ3NZVXpaRGJ4T3ArUW9lQ1FKVkN3cVRRb2FQYnRxclds?=
 =?utf-8?B?K3Y3OUMwWHpFZ1pOL3QzUnVHalRvN0t4QVBjWHdlZkt6WEVpbTRTTFdwYyta?=
 =?utf-8?B?c1ppMFVUTTRmaWNTMVlFRmxaMVJwZUpkMTVBSjF6dXdUM2tjenJTQXRaczd6?=
 =?utf-8?B?MTFzQVJVdlNzS0hiL2VNTGJoMkgwVDBXMlJKY2R6VkMvM2gzZXB3emh3VnVU?=
 =?utf-8?B?Qyt2QzlFMnFhTmo3QW5NRDhUZGpQT21SaHZBM0lJSlVLeldQTEprcUp5dEdx?=
 =?utf-8?B?UDVGUUF1ZFcwWElYaG81NmVORThHVHZNYWV0USs1d1JTa1FXb3hka3Z0VFJk?=
 =?utf-8?B?NmJzSnZuaE9wWlB1ZVM4SksvcTlLdk9rM0tNeE9hUmQ4MmRqcloxbk40b1BL?=
 =?utf-8?B?bXJESUxhV2VFdXY4NU5xSlU4RkxrdWRMQWIwdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzg0UTVtVFo3ZXc4YktkcWgyeHNicUd4VDNDSGZtQjN4djg3R21kQmlaTElB?=
 =?utf-8?B?d0NOZ0w5WnVUNGhlWENUUEk5MWVhMjBoSHFqZXFHL1R2QmxSbDlXYVZZWVpn?=
 =?utf-8?B?TC96UnppemRLeDV0aXlXckMzeGdKd3VmTWE4bTN0RnRoZ3ZJclViNlVMVDk1?=
 =?utf-8?B?UUlyZDV3LzZsNXBZSU8vVk4zUmp1SVpicTYrTjkyQUpEU1RhVFBJZFdZL29T?=
 =?utf-8?B?QVJFc3hCZTUvcDUxUmtUV0dPZ2VKYTJwaWxnM3RGWENlUUExbk9JNGJuY1BT?=
 =?utf-8?B?MkJZcDVHTHVZQk96K0lqT1dCUm5MV0dnWi9WVTFiTkdxVDVrKzFrSUxVeUw2?=
 =?utf-8?B?eVBUNURGcWdsa0NlbnZnRzFRaWtUU0k0ZVB4UlQweHFweGhZRW9HQWZhL2pY?=
 =?utf-8?B?OEhaWGVtSzZzd2lPMm1VWHIwRXpacTl2T2Q0S3EvSXM5ZjdDS2Izei9mNEFm?=
 =?utf-8?B?YzJvRnNEbDZlWThyaSsvay84dElnTnlpd0Zpa1lHWGIwRmdoTlM5bU1CTGQ0?=
 =?utf-8?B?SC9EN3VWaU1GY1gzbVZiajZ4bkdTMDNqaFNzbDFTc2tTSjNicmtnWHFJaWNC?=
 =?utf-8?B?ekwyZWRCOTRXaHJjVU9jSjJkQVBXWkp2ZThhZjJIZkY4THhtSk0yWG16a2ZY?=
 =?utf-8?B?di8zMEk1dUh0OUxPVm9XWEhiNE9LTENlZUJaWDNwV2hvWEh5Z1VlSGkxMGo1?=
 =?utf-8?B?MXdKb1hoU1ExQ2MySHJxdUxyeDRScW9IdlNBc3FWRFROS0tHbnRXcEpXcVQr?=
 =?utf-8?B?OHhsWUVhcUpUbGRsK0JoUkwzaUxEakFrSit6RlN3OStXQ2JLaG1EdStaMU05?=
 =?utf-8?B?a2hqMFNVYXZkWG1iWmtsQ29TajZpN2xQTXUxVDNLRW8yNkJGTHo5cGxySytt?=
 =?utf-8?B?elF3R1ByTDJIbm5KaHUxMnFWMTlEYWlFZi9HZzRzWmtvMEVTbTVhWmVLL0Nr?=
 =?utf-8?B?YWNubmwzNjlBcDN6cEJqd1YvVVhRY2VXc3NQTjVrcU0xc2NuT3RpVUxDSE5o?=
 =?utf-8?B?WE96cUREQm5qcFpha0NFendtbngxOFVoUVE0akRmMmxpbDZUSGNqdUt1eVhZ?=
 =?utf-8?B?d0UwV2FnbDFZcDJncjdoYXdQRjVDdGZtRCtkZHIvZzQ5S0RueDFFOHFNdStU?=
 =?utf-8?B?Q3lrV3p3M00xU2w1amx0Vk9DSEZWaVlmQ2tuTmxUNjVFZFB6bTkvT3NTbEJV?=
 =?utf-8?B?NkxmTFdMMEZQUkN6L0pYSHVQZkxOb0NvZ3VHZkZwZndBRHAwZ0x6TkVGT1J4?=
 =?utf-8?B?eDN1dGhTRWM4VnRyVERsSWxKc1pWb3pQaEoyOGlJRXVTNnVXTkRHWnh2aGUy?=
 =?utf-8?B?QzdsOUgvS2YxZndEd0oyYS96TXlTVnljMUZ4U3RlSHJtUkVsSktVeStVbkgv?=
 =?utf-8?B?em15UXRuNmRYR2FOenA5QVhzM3d4ZkVpRTRIRFYxdk1maHpqdTc1S3ZLclp5?=
 =?utf-8?B?ZVhReExvNk10VDNhTWRnQklMcDRUNSswM1BjbnFGYWpQY3R3blZ1dWRLaEVV?=
 =?utf-8?B?djFxM1Qya0pUSHhUdDNKKzFqNlhrUTBmaGZycUZMME0xaXgwMXMxbFlPaXUv?=
 =?utf-8?B?REV5YTYxbUtUTTZzUWdQUVR6K0l2MExUZUtVaE1tM0k3Qk9zekdNbUVyWGZk?=
 =?utf-8?B?WGZ4MGRxMG1kbGhWaWVDVGhna1pCc0FheHFOdS9wbGkrdzRGTXVLT05UT0tV?=
 =?utf-8?B?Mm5McWhQKzl1b01RK2o4N0hMSUl1cDdNNUdqZWZhcUxqZzdqaER3anpuOTZW?=
 =?utf-8?B?cno1RndrZG9mb0RDVnh6cXZLNklxT24wVFNzNWFWL0FWZzV2U2kwVXh6eDRY?=
 =?utf-8?B?OGtXVU1qZkxpd1djODA1c2drRzdSTWwxelpxTzMvSzlPWFowZ1ViZnV5UTIr?=
 =?utf-8?B?Nkt3dlEzMU1EQ2N3eEdWcjhjMUNkOWxvTDhXd1NqWGgyR3llWG1DY1hPZWN0?=
 =?utf-8?B?dXlBMWc4MzVLNjFQeGZldzBHV3lrcUpDNGF2TXYzcFFXeWpKelgveHNTbGdt?=
 =?utf-8?B?N29zRVdra1hneFRyanNtaHdlSkpyMU55TllQNTNUdFR2cGcycTJ3Y0lTYkFo?=
 =?utf-8?B?bGpTbjB4R04raXBVRHZ6ZjJpZ3FpRjdRRG41RmZBQlpCYWw5NStFVVA3eFl3?=
 =?utf-8?Q?4dAwFbGZoyW/JwZ5U823fwkLv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a037aec8-0c07-4a30-7882-08de3e4e0637
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 15:56:36.7066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NdL01sCncS5Zlj6QBgquSE24I29mCtEKJT8SL0Ck5AI7IigpyMMjzQ4Ylff63XyWJIjldT3toRUevlw9wmVkqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7037

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
Changes in v2:
- Use name dmaengine_prep_config_single() and dmaengine_prep_config_sg()
- Add _safe version to avoid confuse, which needn't additional mutex.
- Update document/
- Update commit message. add () for function name. Use upcase for subject.
- Add more explain for remove lock.
- Link to v1: https://lore.kernel.org/r/20251208-dma_prep_config-v1-0-53490c5e1e2a@nxp.com

---
Frank Li (8):
      dmaengine: Add API to combine configuration and preparation (sg and single)
      PCI: endpoint: pci-epf-test: Use dmaenigne_prep_config_single() to simplify code
      dmaengine: dw-edma: Use new .device_prep_config_sg() callback
      dmaengine: dw-edma: Pass dma_slave_config to dw_edma_device_transfer()
      nvmet: pci-epf: Remove unnecessary dmaengine_terminate_sync() on each DMA transfer
      nvmet: pci-epf: Use dmaengine_prep_config_single_safe() API
      PCI: epf-mhi: Use dmaengine_prep_config_single() to simplify code
      crypto: atmel: Use dmaengine_prep_config_single() API

 Documentation/driver-api/dmaengine/client.rst |   9 +++
 drivers/crypto/atmel-aes.c                    |  10 +--
 drivers/dma/dw-edma/dw-edma-core.c            |  36 ++++++---
 drivers/nvme/target/pci-epf.c                 |  21 ++----
 drivers/pci/endpoint/functions/pci-epf-mhi.c  |  52 ++++---------
 drivers/pci/endpoint/functions/pci-epf-test.c |   8 +-
 include/linux/dmaengine.h                     | 103 ++++++++++++++++++++++++--
 7 files changed, 156 insertions(+), 83 deletions(-)
---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251204-dma_prep_config-654170d245a2

Best regards,
--
Frank Li <Frank.Li@nxp.com>


