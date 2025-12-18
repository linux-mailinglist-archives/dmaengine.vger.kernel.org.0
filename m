Return-Path: <dmaengine+bounces-7804-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5A1CCC962
	for <lists+dmaengine@lfdr.de>; Thu, 18 Dec 2025 16:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 41A0D300A9DE
	for <lists+dmaengine@lfdr.de>; Thu, 18 Dec 2025 15:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72E535CB9D;
	Thu, 18 Dec 2025 15:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Q9OqZuSG"
X-Original-To: dmaengine@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012011.outbound.protection.outlook.com [52.101.66.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAA535CBA9;
	Thu, 18 Dec 2025 15:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766073406; cv=fail; b=E0QR02kOrqpM2zsY8rmtGE8EZTS4Fcqn3BWK8HhXA6PKAARlFGWQqtUILPOQlBZH67ACeNsg73HhfeBwdrYZve9CQpX+B553qpVoOByx8ZbHk4ZeolvzLzL3Mrt1VaOLf2YN+7K9zG56wulEq51dafkux8Q7JtaOHVvWnqlL4Ho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766073406; c=relaxed/simple;
	bh=HZA1aF7jqQNTRddoCdlzxCx0gUTRMagLnXlyZCQsCG0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=DdvSle49sPU+NFW7KsrBLwWsMQU7UKEFqw/2fSB7eWkWdPIHtEyo5eoRn2+x9X0/kPsyn3jJQQHcn3z8RAf3LP7g9Cqx/B+n+VvZZ4styTaF9jY4IzSy0T2bxDB19zKSiHUpBRv944MDjNRBI5LF5ny6Z2KAAlsgcDhdFjIh8fA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Q9OqZuSG; arc=fail smtp.client-ip=52.101.66.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AkSQcrrcm02MQsp2PWymGgwnaIeIjsa3vT97BW48CmoDqkyQTtqp8WJGyA7q6itRgQxQBiWb6WNtDwgCBAKnyPySLUe2yJLABztq+69kB3mJxBvPMfZeQrbNnERueg10nLLR2oVXN/qVY+PLbINaU+EUgQPN+cFoKj78lCl02W2KIwCnDT7OwSW9u9FXAz3ltRP1yLn9LNTCJPGG6cWHv8w+e60QFVWCmuV+ZrQh1l8ggnJH3RGvgVre4ARmFNOW2wkjaZzM3F0M71SK0OQqWIZRTrnSYF9KV8BovY2FVJmTZKphEAEvGCkZ366N920ihWvmUOF9d9srzhcdi7aLbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=esaztu5m9dArql79lY5xPsmQMDaBHjlrOrmSZIYmRfE=;
 b=gXGZ8awI32WpcU1H+ZzA6NLeZvrkvZ08EQkpO21lY9Y2KKs7S/1r9wPFl5MQ/atycLWA/lbjmlEMeRJeWu4UPvuJKfNMQF/CXgyB38pnSidAA+Ow5G7UnB8W4PgSEdBHo7mdicaBIMkPUVqBw5c6yp8SQ1FfFFju5DEbpHufMgBaXXhFt0FAwqYQ45iGY20YkvJLz6jJs9UBU0uj/QYwZwKsxdG8yyC50+KEHvdHi3h4juxFn4Sqb+NVVcO3KsqDZd8Cx2I47KO/C0acY79B1f+d5bnpBKRx2kgJJpFIsL1WMArcr0RIAtyDxSE9MWjJVK5rCTbhbpd2QSDanjisSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=esaztu5m9dArql79lY5xPsmQMDaBHjlrOrmSZIYmRfE=;
 b=Q9OqZuSG4wdXj42LmRuSRZZFtHguY2/qMBf+ie6KDObF/70wD9F5ZxcOoGQA4AZU6sKvEiJDywBN3CycEZD5NX4U2MLH6wBvdsqIov8oE0up6A9Sbsa2Tc48OI6iwwr2++Adw3tpPqe73AjbIVa6aq0fsVKy2n/iWuQ6SsQDrUyBBq5sugviE3xnxTkgVwBBGCYWvmG2BYNILmBdMJEDeUs1ey9UaP3+LocBTkqy+UQNdxZzLXAA37dBRcOVUIXqdtCNVs3Ap3lRYq5CQCxqH2Dd4AdBiWWHhBsiLi4n0igFNjYRfRxmnal3OXZp69wOsCTKVLcEq5WZ/DTvnUOoPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by VI1PR04MB7037.eurprd04.prod.outlook.com (2603:10a6:800:125::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.7; Thu, 18 Dec
 2025 15:56:41 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 15:56:41 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 18 Dec 2025 10:56:21 -0500
Subject: [PATCH v2 1/8] dmaengine: Add API to combine configuration and
 preparation (sg and single)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-dma_prep_config-v2-1-c07079836128@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766073392; l=8714;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=HZA1aF7jqQNTRddoCdlzxCx0gUTRMagLnXlyZCQsCG0=;
 b=MboqvRaFNRDNEZSMLvQH8AXt4tJC5JH58G3am++CmJqqSEhaObax6IW0+wcGNMeXqbkhNMJ+Q
 RSe2h8xS2pxBfl9vqzue8muehvbjIhERZoR+2NSyS2S09Tt7TcRIoEL
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
X-MS-Office365-Filtering-Correlation-Id: 6a67d886-5388-46ae-e050-08de3e4e090c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RzNWSytYbmVSakh3UmJHZXgxNStYcGRSZFNORFppVnZaSHJKU0lPR1pUQ1FI?=
 =?utf-8?B?a3B3Zk9VaUI1NHRhanQralBrQVFrbHVkZmhheUdvSG5ZaHR3UW1ldkdKYUJC?=
 =?utf-8?B?aEoyWFVHVTQ0M2VLbk9vUWFqdlY2eHRCYnI4ZHB0NXBSWUFFNEFUVW5qUGRG?=
 =?utf-8?B?aGJCdVpmVFUwdDR5NkdvVm5DQUkxUm1ERkR6Y2QzUVJvUEZOMkQ4ZE54NWZ0?=
 =?utf-8?B?YjFCajRPMEtQeVN4aE95RDB1MC9XcUlCWkU5SVNGQjllWHg1cXZZV3VnVUtO?=
 =?utf-8?B?MGJJQjI5VTAxUWVkQ2dPckVObkN4a0dHR21PalB0elRYOWVBdkY2NlBObnRO?=
 =?utf-8?B?SlozbDVWQ0J5dkZ1WGhIVHNvZjBGdm1rOFZkMTVyaHpjUHA2L0l0V0R4L3py?=
 =?utf-8?B?V2FhZGVvSkFGOXF0K090UHl4akJIVVNZYm1NS1VaMFhQTGRQTi9JenVZdUJX?=
 =?utf-8?B?RjIzODRrODJGWWVGOW5Vd08rZUFqV1FQOURyb2pFTGgxNE9IMHZXZTlCN0tZ?=
 =?utf-8?B?UGNrb2hFTFFxUGdTcDRobXdBSlVwWEdxL3dHeTZwU3JIL1NLTk9QYmhKREtB?=
 =?utf-8?B?RlZRODV5eFFRejlDV1NLWjhFM01rZkN1UjVsODg4QWQxclVJT0hVU2pXdlh3?=
 =?utf-8?B?b0ZVOVZJT25YN2N5dEdUcDNzcUk2bHpqS2Z5dTRPa3VHRGFXUEtyaHJ4TW5S?=
 =?utf-8?B?eWozQjM2ZEQ5eU1RcnJXSVF5Wk5oK2tRbEE5MmtnRmJvUDN0blNTTVdFTVJi?=
 =?utf-8?B?bWtUN0tWOVdoNWFLTDltV3R0MG02NDRnaytuaTIwM05yUkN5MC8ybDFDQ3lD?=
 =?utf-8?B?czM4NXhJRW5ldkV3MTZhQUNLcGhqNkViYWVaNGE4UDVRT05wVEc4eW5WaUhF?=
 =?utf-8?B?ZTJOTURaeTRkSzJXNU4ydDNpN1pFVm9uMWRPR0dENzM1K0hnYk14RnIwV2hn?=
 =?utf-8?B?TWFZUG5Bb2xxMXNsNFZMd3RmK1NQWEJVWnlPT3Y4elUzS2VJMG94WXNkVjdQ?=
 =?utf-8?B?eDVTanNhOUpWTGxJa1QyekZxV1lhUFd4Q1ZicHZYUzIyc214R2o4NHBBRjFw?=
 =?utf-8?B?RXFmSDg0OVVCcUo2UzlQYTVTZWlEN3l2ZFdHNXJwSFVPMmVaOU9ad2xVaE5Y?=
 =?utf-8?B?TWgxbm5nUU1XVlhhSG5paW5mV21BSUh3S0hCRSsrTnV2T1paTTRzZmVjRzBa?=
 =?utf-8?B?eGdkUkpwYTh4bkxEWW5NLzRtMlNjbE83RzhMNG5tSlI0cklJNnYwcFc3UU82?=
 =?utf-8?B?ZGExL3A1elRwQmE0RHIwMzcrNVFnV3dabHdzeVhMN1pYR2dsOW14VHRsckJs?=
 =?utf-8?B?UlRoaEdGNFVpekpCNzFCZExma3g4c21tYjdtVThpRkZwRFBFdjd1UUdnS0FD?=
 =?utf-8?B?cUVtYmp0MkxKZ3dRYjcwaUt1VEx5YXhLK0h1Y0dFVUJ3OEdBSG81SVcrUzhx?=
 =?utf-8?B?TzhCd2RmT0xyWEthakROMUl2RHdNOWlhWDM0Um9UcldqVWJaRkZtS01HcFFC?=
 =?utf-8?B?bHc0Z2FDK2hxNnhnZUJFR0NVVnUvU2NIVUg4MVdoU0RmRXFVdmo2em1CS1Z3?=
 =?utf-8?B?VTF4N0NjUXhyZDZYMVA2MzBXeVR3NTUvbEtTcUl2Ry9RaGNzSm1tdUp2LzBh?=
 =?utf-8?B?OUlCRmh2YnZONm9SZ0pkanRDdHh0LzdRYzdydlAyQmlhNUEyaGFZdzIwS1NR?=
 =?utf-8?B?QVJFVDZFbmlOVUFOQXhRMC93dExsZlRNd0FHRVQvcXB5dHdhNmwvYjhNdVF1?=
 =?utf-8?B?czVUYys4WnZlajZNeGthS3JrMGhGeDZLdmpsQVpOZmFjdzJLNUlLREI2Ukp4?=
 =?utf-8?B?ZWM2Ry8vR25IaWZPNnZDY21Dclgya2FBS1h3OTFmMG1wd1lkVHZBYUFob3Fo?=
 =?utf-8?B?R1daSWNCUHNmVUwzMGw2ak8yakh3Y3NyL0ovd2JWMElVejNjVkV1OEg2eUIy?=
 =?utf-8?B?Q3QrNXZxUXRJaFBvRzdMOG9vN2oraFc1K21mM2xvYTJnU2dxSjVWQkREVVdP?=
 =?utf-8?B?VFM2VFo0TkdYTS96cGc2TjFlZklTSkxpZnJZV2N2OTRIbmNBbzAyTTRNUDZ4?=
 =?utf-8?B?bUdraE00V3BRNU9xMEVtNk5qd1hwVDRyOHlyUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2M2ZXZHaVVDcjYzTjIxeERQVERhZHB5YWhIejM0aXh0QlJwSXFKSVBIQlpa?=
 =?utf-8?B?dGltbUlsb0xBcSt3THpNQ0xqT1BSMVorVUJDMktJT20vTFN4Y3hzbVl2Z3Fy?=
 =?utf-8?B?enVRU2sxQ0c3SkRWT1MvaWFIdHZwWkh3N3Q5eU5aNENxZ05nS09sTTRCV280?=
 =?utf-8?B?dkJVclJVMmdjR0FHSG44N0x5a0NteDlUZ3AxZmd4MTA1Q3BSY01Sb1FMVkhy?=
 =?utf-8?B?SjUwTDBNOFFhVXhuZmczMjcwM0xiWm0wK09KTmhkOWVSSy93bVRFdGJ6Yllj?=
 =?utf-8?B?TFAyWXhXOXZjT25ldHU1T2NUR2l4b05MNmZ1dWcrVk9WeDY5YW9uMWRKa0xi?=
 =?utf-8?B?akhmZ1RJb20zYWdzeTFTOXJ0N3pHWWk0RWJBaEdpV2JyaGlXazdLMDM2Skdo?=
 =?utf-8?B?Zy9BZWh1L2YwVldRYVlxWVFZekl0V1Q0NFppUHJUMHJSOXRjT0xFREZEaHZk?=
 =?utf-8?B?U0JSTG0yeHhjbW95ZWN4a0I4dkZ0eDEveVVqZHdSYzhxWE9OaGVnZDRZblp1?=
 =?utf-8?B?N1lFS0RtU3pFSTJRTXNsLzdkQlJUaitCNWFtUW9rcjFFblBWU0hodm5rT3Vk?=
 =?utf-8?B?Q0lQVHNSK1hNRXQrYTRveTlOOTE5Um9tVEVIeVZUbWg5K2dCdnRSd0hxVThr?=
 =?utf-8?B?OU1sZ0FJNCtHcnFtRUdud1pGSTZCaXB3OFMyQkR2RldRNFQ2b1YwS0E4Mmht?=
 =?utf-8?B?NEc5U3ZEclQwaUJ2SGpKRWJCWkdSRkMwOUxCTi9kcmF5Y1hjTnJzTmhtMzMv?=
 =?utf-8?B?S1JIMU45bDljblRzb0R3MW5HbGY4aGY4R0QvOEtzeDZMOCtiTGIrWFZBODl1?=
 =?utf-8?B?eUFIRThEQTZJZElSVXI0VnpPRElrTVQ0UEdFdHFMVkJVN2dtTDVMSGd3Njho?=
 =?utf-8?B?MnpQeW1zNkRBTVc0clJrZkRhVlcvS3FLa3hId0RLVFdKSStKb2RnWmxuRzBu?=
 =?utf-8?B?OVJReVJOWUhsZXNDSEltWXVLWkV4cVJjUFBvaGhLbkorcFJRb1VvS0g2YzhW?=
 =?utf-8?B?UkZKMlZaYUJWanFKSWdWVzJaTEFhU2NGZmx2R1djN1lMd0lZM25LbEJha0pz?=
 =?utf-8?B?d2Yxd1pQVDAzTG0wVjJ0eTFhWHVFWmNTOVpFaU55OGkzK0t5S1gzMjNvTWtY?=
 =?utf-8?B?YmtINGNSSEE1dEc5WmpxMmprK2NNZXlHZDY4VURYUTFJbXIvZE9SbnRtUHlE?=
 =?utf-8?B?WXhLZFpqVnJ6aGRmNmR4VmRKZk1sTVJYYWJIL0pZV28xaTNvMEdiUWFCWkh2?=
 =?utf-8?B?TmFNYlYrcFR1STYrR1E4NU1LLzAvRHZZenphc0M4clhLR3VHa0hRQjd6QjBz?=
 =?utf-8?B?bU04MENXUUFrc1RYY2w2UzFkZlA5RlVuM2VZSktHRzI4RStTcVAxeEhqSWtu?=
 =?utf-8?B?MG5HTVJiTDJsY2ROaDRFRFQyWUJ1ZERmWXVsck9KMERKc0lWZ0Zsa1Bzb092?=
 =?utf-8?B?amdmYlRXbnBTaFY4QU00SmJxbHRjS2RheTE0SjRwaWwwc2Rmd0FtMlN6TXN3?=
 =?utf-8?B?QThKQjlFb2hFaXNDM2ViOEhlWlVNY2crT1R2SE9NRHJsM0NjeDZxVStCU1VW?=
 =?utf-8?B?WGd5Rmt5ZnMrWWdGRjNiMTR1K2xYZHlBN0dlZEdFMCt4SVpOd05jZlhTZmVX?=
 =?utf-8?B?c3doUHIwM2JsMWVpZTFhdnlreVdnaTM3K2dZZm9DNkNZV3hyRkVteWtXUEt5?=
 =?utf-8?B?MmV0d1RnUWJLcVBrTENKUEJaR2txKzRrMHhVcUJBMzVBb2RSK0tYUXFoK2xY?=
 =?utf-8?B?VDRhL0ZhMml3RW9JQjRpclhxanVnTm5pZGsvcW5uYjhZeTAzUWJjb3E2dkVm?=
 =?utf-8?B?cnlCM2VrRlVkeGtKMTJaY2dBNnVaZnFKa0pmY0F2S3ZYdVhaazlVTHoyeDBw?=
 =?utf-8?B?bjBpVEw3T3hKRjR6NXBEcTF5ZzZnc24rUnc0NllEQ2FZS0ZqVUVHQml3UEhM?=
 =?utf-8?B?cHI3cnpVQ0VnZitmeXh5Y2dMdmNEZlRqU1BhSjJFRTRvV2lwU0dXaEx4S1pZ?=
 =?utf-8?B?RTRTNTdqZHZacU15U1c5N1FZcmthS0ZmejUyVUpYcmxIUzVFWmlUQVYvWUpG?=
 =?utf-8?B?STVVeW1xVHhBMVljOGwwWDNyOGgxV2hKMUdJY3ZORS9Ic2NsY0R2VHNNeWRp?=
 =?utf-8?Q?68IfhkGOJqJ4VHF+G5Xau6035?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a67d886-5388-46ae-e050-08de3e4e090c
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 15:56:41.4309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8M96Kql5sCvXmE7fo3t/jOEsj18gzHdxxw6WbGVkMKIawHCk3crOlXyWu8VnERpKIzuLPzr8P1IrJ1W6jg8Zsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7037

Previously, configuration and preparation required two separate calls. This
works well when configuration is done only once during initialization.

However, in cases where the burst length or source/destination address must
be adjusted for each transfer, calling two functions is verbose and
requires additional locking to ensure both steps complete atomically.

Add a new API dmaengine_prep_config_single() and dmaengine_prep_config_sg()
and callback device_prep_config_sg() that combines configuration and
preparation into a single operation. If the configuration argument is
passed as NULL, fall back to the existing implementation.

Add a new API dmaengine_prep_config_single_safe() and
dmaengine_prep_config_sg_safe() for re-entrancy, which require driver
implement callback device_prep_config_sg().

Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v2
- add () for function
- use short name device_prep_sg(), remove "slave" and "config". the 'slave'
is reduntant. after remove slave, the function name is difference existed
one, so remove _config suffix.
---
 Documentation/driver-api/dmaengine/client.rst |   9 +++
 include/linux/dmaengine.h                     | 103 ++++++++++++++++++++++++--
 2 files changed, 105 insertions(+), 7 deletions(-)

diff --git a/Documentation/driver-api/dmaengine/client.rst b/Documentation/driver-api/dmaengine/client.rst
index d491e385d61a98b8a804cd823caf254a2dc62cf4..02c45b7d7a779421411eb9c68325cdedafcfe3b1 100644
--- a/Documentation/driver-api/dmaengine/client.rst
+++ b/Documentation/driver-api/dmaengine/client.rst
@@ -80,6 +80,10 @@ The details of these operations are:
 
   - slave_sg: DMA a list of scatter gather buffers from/to a peripheral
 
+  - config_sg: Similar with slave_sg, just pass down dma_slave_config
+    struct to avoid call dmaengine_slave_config() every time if need
+    adjust burst length or FIFO address.
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
index 99efe2b9b4ea9844ca6161208362ef18ef111d96..276dca760f95e1131f5ff5bf69752c4c9cb1bcad 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -835,6 +835,8 @@ struct dma_filter {
  *	where the address and size of each segment is located in one entry of
  *	the dma_vec array.
  * @device_prep_slave_sg: prepares a slave dma operation
+ *	(Deprecated, use @device_prep_config_sg)
+ * @device_prep_config_sg: prepares a slave DMA operation with dma_slave_config
  * @device_prep_dma_cyclic: prepare a cyclic dma operation suitable for audio.
  *	The function takes a buffer of size buf_len. The callback function will
  *	be called after period_len bytes have been transferred.
@@ -934,6 +936,11 @@ struct dma_device {
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
@@ -974,22 +981,85 @@ static inline bool is_slave_direction(enum dma_transfer_direction direction)
 	       (direction == DMA_DEV_TO_DEV);
 }
 
-static inline struct dma_async_tx_descriptor *dmaengine_prep_slave_single(
-	struct dma_chan *chan, dma_addr_t buf, size_t len,
-	enum dma_transfer_direction dir, unsigned long flags)
+/*
+ * Re-entrancy and locking considerations for callers:
+ *
+ * dmaengine_prep_config_single(sg)_safe() is re-entrant and requires the
+ * DMA engine driver to implement device_prep_config_sg(). It returns NULL
+ * if device_prep_config_sg() is not implemented.
+ *
+ * The unsafe variant (without the _safe suffix) falls back to calling
+ * dmaengine_slave_config() and dmaengine_prep_slave_sg() separately.
+ * In this case, additional locking may be required, depending on the
+ * DMA consumer's usage.
+ */
+static inline struct dma_async_tx_descriptor *
+dmaengine_prep_config_sg_safe(struct dma_chan *chan, struct scatterlist *sgl,
+	unsigned int sg_len, enum dma_transfer_direction dir,
+	unsigned long flags, struct dma_slave_config *config)
+{
+	if (!chan || !chan->device || !chan->device->device_prep_config_sg)
+		return NULL;
+
+	return chan->device->device_prep_config_sg(chan, sgl, sg_len,
+						   dir, flags, config, NULL);
+}
+
+static inline struct dma_async_tx_descriptor *
+dmaengine_prep_config_single_safe(struct dma_chan *chan, dma_addr_t buf,
+	size_t len, enum dma_transfer_direction dir, unsigned long flags,
+	struct dma_slave_config *config)
 {
 	struct scatterlist sg;
+
 	sg_init_table(&sg, 1);
 	sg_dma_address(&sg) = buf;
 	sg_dma_len(&sg) = len;
 
-	if (!chan || !chan->device || !chan->device->device_prep_slave_sg)
+	if (!chan || !chan->device || !chan->device->device_prep_config_sg)
+		return NULL;
+
+	return chan->device->device_prep_config_sg(chan, &sg, 1, dir,
+						   flags, config, NULL);
+}
+
+static inline struct dma_async_tx_descriptor *
+dmaengine_prep_config_single(struct dma_chan *chan, dma_addr_t buf, size_t len,
+	enum dma_transfer_direction dir, unsigned long flags,
+	struct dma_slave_config *config)
+{
+	struct scatterlist sg;
+
+	sg_init_table(&sg, 1);
+	sg_dma_address(&sg) = buf;
+	sg_dma_len(&sg) = len;
+
+	if (!chan || !chan->device)
+		return NULL;
+
+	if (chan->device->device_prep_config_sg)
+		return dmaengine_prep_config_sg_safe(chan, &sg, 1, dir,
+						     flags, config);
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
@@ -1009,17 +1079,36 @@ static inline struct dma_async_tx_descriptor *dmaengine_prep_peripheral_dma_vec(
 							    dir, flags);
 }
 
-static inline struct dma_async_tx_descriptor *dmaengine_prep_slave_sg(
+static inline struct dma_async_tx_descriptor *dmaengine_prep_config_sg(
 	struct dma_chan *chan, struct scatterlist *sgl,	unsigned int sg_len,
-	enum dma_transfer_direction dir, unsigned long flags)
+	enum dma_transfer_direction dir, unsigned long flags,
+	struct dma_slave_config *config)
 {
-	if (!chan || !chan->device || !chan->device->device_prep_slave_sg)
+	if (!chan || !chan->device)
+		return NULL;
+
+	if (chan->device->device_prep_config_sg)
+		return dmaengine_prep_config_sg_safe(chan, sgl, sg_len,
+					dir, flags, config);
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
 
+static inline struct dma_async_tx_descriptor *dmaengine_prep_slave_sg(
+	struct dma_chan *chan, struct scatterlist *sgl, unsigned int sg_len,
+	enum dma_transfer_direction dir, unsigned long flags)
+{
+	return dmaengine_prep_config_sg(chan, sgl, sg_len, dir, flags, NULL);
+}
+
 #ifdef CONFIG_RAPIDIO_DMA_ENGINE
 struct rio_dma_ext;
 static inline struct dma_async_tx_descriptor *dmaengine_prep_rio_sg(

-- 
2.34.1


