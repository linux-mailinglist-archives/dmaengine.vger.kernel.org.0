Return-Path: <dmaengine+bounces-7534-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F679CADD1C
	for <lists+dmaengine@lfdr.de>; Mon, 08 Dec 2025 18:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 42FB13022813
	for <lists+dmaengine@lfdr.de>; Mon,  8 Dec 2025 17:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9012D3225;
	Mon,  8 Dec 2025 17:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QEvooD+Y"
X-Original-To: dmaengine@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012030.outbound.protection.outlook.com [52.101.66.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B422D73B1;
	Mon,  8 Dec 2025 17:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765213817; cv=fail; b=UY45KV2oJ2JSR96QRbJe4aJsAoP6a0D19KxSmTJQNeyZB9y2KMp3cHARPbgclc6Co0RCVzdmepwm27O+mziseNmmfEtXXrgdvdSOXtgYIh+v7Nm7yuKUxyfRFlN6EkNWZt1pxXPxmXLKXdKEFfY22rgY1gs6z99GfMT9Ic7O2cc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765213817; c=relaxed/simple;
	bh=Eox/qeRp0JkD3nRCMDFMBSR+bStDd+o/TRcMaBC2Phs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=YN7VFqe/acPKyOm3uoGNFs6q1J0XA9pHkf1NWEDdWGej6T091lTK7Djr15jKHYBpL48PhbkMP44Xb/TazBLHrtExHR2+jPOWfVNqZng5m8Z69ptKmKaAsYuqWg7VLcGAgatLSEz6u8+H/N01Ug7wOsicIKW3VADYQ8Xk4BLVIVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QEvooD+Y; arc=fail smtp.client-ip=52.101.66.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pe62CXL/XSahokTZLrsgYNN2/hZDiDby8AXHHKcFKLtBv3a3xOG5CrP56IbPPrM4YQ/dd1jVAwAQQbnKmWHl0I0Fzx4Zldsf3qy9edOcaA+6qm7PlvnTN9gCQ3Q+N3GqsIN0MEyEKZQteCa/io2YiElwspqUuHrHbpxIiM/EbAs7PsSwqJnO7Arq9t8cZ7K/POfTvlMVtPWNXTUVeI2EaGsPyJAgent/+rnOE3DPm43WYuvIKnPkdzA8Dx43P165Qk9VZtJ68fOdoMx4ECY2a8RxexVC60js92OueYM17fWKbJtTaxwcGMaEXnl6a4TuBCO4OgPMYtfEyF6tzAiCrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2fJVpdzgwSmV/hBqFwUmzoaWWNBF5sDl9czNC/bhLFY=;
 b=YSxWhe8oXNOOMwJ8slFzgx/1t5H/Nib2LOEvbwgijmEQ/eSe9MEG8aeNw+c0pjEel9/6haZXn6YGcEXPtuoLieQ8yEdeZ0rPAWfT68q6JW/iTUgLm1Y8AAQZ1qU2jzJSwU6R71M/2ez0MDkhPjjxm3UV6WcWeLbNWkAPqkFSHn1ZIHWL58+IXSwRLDyoFi/lSa+NkrPUwM5K2g0fL0HRVyPVD81efHxKAtss7D4+0pBq5gKPh9g7EdC8FN9Xlb4r2AJEPmZX1vxdQ9Y0hA/zpHRUVSYUVl078Ci7W0Ct9z8Av3UVb5nMIJZaGNsdIdsFdiGKs4BEwOCRPp9lmCSYyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2fJVpdzgwSmV/hBqFwUmzoaWWNBF5sDl9czNC/bhLFY=;
 b=QEvooD+Y9xgWOpTvtkw1Ut+MfT+ICyixjiuQ9On3lgZJvhsRgQUPxuL9X9jKhlFsgjYimOW7m0TFO41MV2oyEn6SkHeapy0Evt64jWhUma0mOe4Hhh3h+teqzsaIHZRrwe+fGdePDUHUJEpjIXy94FH7N6isImDeGg8KygiNEN1B0WT18jD6JvAEMEtRa3jT26YXUAYeNfME4an7ELII1m/ToTXxhG+wJTMAoDxSUOCptQebjyh97L/brxG5VatcTonnBWbZ9H75Qy2O57CXAfzEynGM1ZgYJMw2i0T0NlYAcioJ2TJWQjACzVgafzLC+7RyAEENBDeXN1ywJY2e/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by VI0PR04MB10318.eurprd04.prod.outlook.com (2603:10a6:800:21c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 17:10:14 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 17:10:13 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 08 Dec 2025 12:09:41 -0500
Subject: [PATCH 2/8] PCI: endpoint: pci-epf-test: use new DMA API to simple
 code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251208-dma_prep_config-v1-2-53490c5e1e2a@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765213799; l=1113;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Eox/qeRp0JkD3nRCMDFMBSR+bStDd+o/TRcMaBC2Phs=;
 b=HARH/xayr/MnXdJd4K0NJeBkiB6UrR4hioyPirISfkl5S0cag7rEDK/lO2zaGqeudwkpiTtG5
 BAW+xxPUcnYARXlDCu95I65czGamtlMI2oeTBYk8gxHL6p0WXGPooAq
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
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|VI0PR04MB10318:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d4d8fcc-8a50-4d6f-9d04-08de367ca6f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c0hteEdyODBydHRpRExZQmxyMlUwSmR1amgra2ZHSWxCQ2xXNU5qUjVTVjVD?=
 =?utf-8?B?dVh5UzlxSWZBbFNpNThuUXllUS9zcjJTUWJJbFhZcm5Nd1prdmdDaktiOEla?=
 =?utf-8?B?VlM3KzVQMkNnK0VaN3REQkR5VUJ5Qk90amtmR2gyeU45ZHpRZWZOU2YxUkJl?=
 =?utf-8?B?bnF5NkkwM1JpempzQXdKakFvZzdiemFnRWNKQTVYQnJ4Tmc5L1RWVTc1bjNH?=
 =?utf-8?B?dEREakVnbkRkWVUvR3h6ZGhDYzRzRW5wMjZsU1VpeGxtZlMrSXdKRWtUZ1N2?=
 =?utf-8?B?L2I4a2xGdkZ0TlZ3d3ZyQkZJbmxqVXF4MmUvQkRsVnVWUnFZUTU0ZzhwdE4x?=
 =?utf-8?B?eHN5WTRTcVlzbW83eVBndkZ6T0RnU1FyRDlydFNaaDVtVDZDSGgybEhUNUpz?=
 =?utf-8?B?aldBckkxajBRZDduSTl0UEk1VVdjUDBXK3QwVFp4U1VCRS9NLzBtTzFmNkp0?=
 =?utf-8?B?YlZXK2VqSVN0cVJYYWFDb1k4cHpmN1Q4akVBcVFKQlVoMWVtSUdxbGRYMms1?=
 =?utf-8?B?NmFnYmZScDZNSnMrYjQ4ZlJydmErOTBmOHZpYmFtdXVUek5vSlpicWloRVFB?=
 =?utf-8?B?TlA2QmsvNWg1T3hGWTRuMmJjSWpXbUhCd0JpYmFMQnZFSklBWXUxdTFteDZl?=
 =?utf-8?B?dCtDanBpVGJUbmI1SjZ1aXk4WlhoZ1I4S0tyZHFVOUU1eDA1RU94bm1WTFlt?=
 =?utf-8?B?SXlNY25ONVRMN3BNdi9BK21wbXJWMWl5UXM3eVFveEVZVEd6N2liek1PUUM1?=
 =?utf-8?B?Nmc0RnduWllQUGoyOTlMV3RxMFBhbzV0TnpzcGU5N2RnSUdiZ21GU1hsTjNt?=
 =?utf-8?B?bWFDcm8veENHMFRYVUsyNVpmSWNSdCtLZjdWOFJ0TTdEYWIzV3N1SkVNRkh2?=
 =?utf-8?B?bjdIU3hUSExETEJzS0RSVXFxenVLM3FlWFY3dzVseTB5UDZxVGo0ZDJzbFNG?=
 =?utf-8?B?V0xBVXQxLzZMd0xpNjFFVy9xajBsN1A3M1hSRDNwdHFOMTdrellCSE5VNDQw?=
 =?utf-8?B?SXhLeHhKcjQrNDdaWlZkUGxselIrQTNwWmtnWElrZ3FOV3p6eHkvQmErQ0pl?=
 =?utf-8?B?SWV1UGZOSFFXMmZYcGppVGJ1VWJOb0JDeUdXS1E3aW43ZlJNKzNiRHJ4Tkh2?=
 =?utf-8?B?QXk5dWRhU29UeFJPaXM1NTFpMjFMeHovZHkxeDlDU2NDckpFa1Zrc2dQNkJE?=
 =?utf-8?B?dUpjd0ZnMWM5MzhjelFXWVBFZnM0L1k5YjFHSVQwRjhxbm54dTlQZTl0T1N4?=
 =?utf-8?B?YTM3Vmt0U3dyNVdxQk1nYWlIMlBUeEdqWjJrS3FXczg2ZjlLUmpHakVvaXFt?=
 =?utf-8?B?aDVsMmw0aklVRjErSmF4UDdybnRGa0p1ZDB1UmVaaUdKMDIxZHJwaUwzTXY3?=
 =?utf-8?B?V1pjWG5pVWJ4dVJSQy9uaXNyL0prSU5MYXl5MGREYkI5Y2p4aGpMc0JOSng4?=
 =?utf-8?B?dHpFdVluc29jd09icEtUa0M5K0hyN2ZsdzA1SXc1cys4YWhwWWo0eVZtS2lz?=
 =?utf-8?B?OEF4ZkR2RmtYSCtRdmdJZjlhNzFoanZ4d2phcFJ1WlEwbUZ4aDVueEJLY3Zs?=
 =?utf-8?B?SVJoQVh4bFZKWjJZcXV1cGIzVWVPMkl1V0gyNS8xaElSL0JvUFRoWXRRUkxF?=
 =?utf-8?B?N2pHdXB5WHFsdmVCMXdYUHd3b2JndVNxbC9YZnltOHlURG54SnBYa0V6amFv?=
 =?utf-8?B?VzF2VmNHait3bW4rTXVnVGZNTlNSeUsrbDhiRkNrdW00U2dZN3N5aXpua1J6?=
 =?utf-8?B?Q3JodkpINXlKVURKNm52RUZXOCt6TXJWaVp0aHV2RVNmdC9sK2o1TGVqM3Rp?=
 =?utf-8?B?djgyRnIvSHJnQisxUHVWU0IxaUVaeDc2ci9ZWmp1M296dzMwaUdIUnQ4RHRh?=
 =?utf-8?B?aC91WmQ0M3A0bmM3TWcvaGxwN2tPRzJKRENXaUhMOFoyVHZzMVBTWTlaMG4y?=
 =?utf-8?B?T09lV1JSczJXWXhxbVcvUzU5RHJXWG14UmJqTVlwaTBEZjdUTnc4K1lIL3FR?=
 =?utf-8?B?UmZlNzZXQzhVcDZjbk5ZdEx0TmRxU0l5ZmJQWGVkQWs4cVNLVEZjMkcwQ1B5?=
 =?utf-8?B?K0VLT0xSbkR5Umx4dEdjL053elpWRzVVR280QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWkyYmtwcm9zWCtMMVFnSlowb3NaMUVtK0puZXFwaEFVUjM0ckpFNktNNlNh?=
 =?utf-8?B?R3FqZTdCOU1JMzRIMXFuL1RsdUU3dGRhOUJsdTNnNDl1ZXlUVFBzemFhYlVV?=
 =?utf-8?B?dzJzYkxMNk5LTzBLL3o4aldwakYxK2UwT0xiZTFWUUFEUEV4R1haS2dDeTk4?=
 =?utf-8?B?NTU4WlppOWpXUlpzYjdpOGQxb3RTL21sb1dadkdNVmI5cm1iRUFNVDJaVVQ5?=
 =?utf-8?B?QzdBSStPNnBCUDNUemxFbHJiMHZySllFNFdBeGpZN3QwUXVvelh6SktwVDRZ?=
 =?utf-8?B?aHA4dlJuaG9Kd0doU1pVTm5UdUN3MU9Qa0o0ZEI1NDVNeU1YQTFJWWhkRnFR?=
 =?utf-8?B?M0pYaWNKZjlWVFVPc25DQk9OYVdFbGc5ckp6dmIrK0pxbFBkSXJyT2x4S0s5?=
 =?utf-8?B?WWl1d0ZZRlExZWZOWjlNamNrVFdvMGp0eHlqTFI4cVAzMlFVOGtzdUw0R1lN?=
 =?utf-8?B?V1dlcmtnVDRrWU05eUFFc3Y0ZzdNZUd3VXhjZlBMTVdRUmlZOHJiTXhsUnd4?=
 =?utf-8?B?ejkyWWRpaXdBSFJBdjNJWkxvak01UE5wazE4QTRjdGFodUNvZTFtTUg0QzhN?=
 =?utf-8?B?QWlaOXZ6amJKdkZSVmo1RkZoKzdVUkhibCswcngxUmd2ZTRJaStPZXJTcUs1?=
 =?utf-8?B?bHpjcENxSEpweDlvUHEwcFEvcVZZVmw4NTZkdUV6Y0t4bCt4M3VIa012N2dC?=
 =?utf-8?B?OTJVU2pDck5PZkNUM0oyK2VpM01qYkgzS1JXRVpGL3N6R0NiYVozRW4xMUJ3?=
 =?utf-8?B?VThrTTAwdU04RzQxQmdmTGVqM0loM2cxSW1HbG0vRWM5WFppSmZsRnBOZUtU?=
 =?utf-8?B?R2I3RXdlN2RTekNGbTZkMWJoRTJabzU5MXBnV2Vacy9pMTRpSG5kemxIa2VE?=
 =?utf-8?B?dGtUakRrMjR4a0x5aGFrdFQ5QkZGYnl4WXd2bzM0RUlwODl6ZjNHQkVHRDhT?=
 =?utf-8?B?cHJYU0ZhSS9jSzhDRkFZdWVodE0ySHpkUEEyNmtoWHFNeXBPZGVhOXlrVzh6?=
 =?utf-8?B?Vll1K0NCMi9iSm5CUXlZbTNCNUVJS0owbmM1aDlNU2lwZWZNeDh0RVpPSDdE?=
 =?utf-8?B?aGRXQlJuSllhZ1E0NGRRWjdrZjNqcGZJQVorVWdLc2hxeGhFV3dFKzNEYSts?=
 =?utf-8?B?bFB4OWx5WGEvc0g2bC9JaGJUVzJ5WnNsV0tGRDEwTmN2SEp0d21tS3ZwcG1S?=
 =?utf-8?B?NDNERExzZHowWGY4M2dFeS96bnZpMWIwR210YWI0NlU1ekpoU3JIRjBPSXVq?=
 =?utf-8?B?WEtzTlErbHAvVlhzc0tVMW9xNkZSb3lpekpremFDWnp1WllORVRjWXNPNTFa?=
 =?utf-8?B?SkExZ0E3MEtiY1ZlcVdBSFpwbUdHbXNWV3gvend2dlAwVzcrNy8yVDMwQk1H?=
 =?utf-8?B?SkpmbUNQOHc1bytEVStHdEljZ0lFNzY2bWUxd1dldW1hUXpERXNSekV3b2p2?=
 =?utf-8?B?YkFiZzg1VVdSbGFVblBKV09NbVMvb3ArQWtnYW8rTGxBOElZTnJqdHBreUhn?=
 =?utf-8?B?QWdVVzN2dldiRFF2ZHU5RDVWM21jaktGRVdlN1FhbmNWL0JsZFRpWDM4MnZ5?=
 =?utf-8?B?czljbVdvZFpQQk5Ya0ZBNlR5NWhQSTM3SEc5bnMyVjBaS1I2MHB2MUY0L2Zz?=
 =?utf-8?B?OVg3Y056WUZKeG1xdzBJRVFRMElDL3ByTVc2Y2RlS3RLK0tTUDhNOHNUZE9u?=
 =?utf-8?B?dWtodFQzQ2Q3RGdwTE4vYnYrQi9SazdzNXZzamE2d0YySklITzJGOEEzcE5a?=
 =?utf-8?B?ZHFDNVhnQzJhcXE4Vks3NjdEODJMODlpWGxQK0ZBTnNRVnpFa2hGVTUzdStY?=
 =?utf-8?B?UDJncTliNHhUbXBtM2huRlNYb29NU2VpTXMwbWJtZXRtSG9aVkwwNjhaT2lU?=
 =?utf-8?B?MUc1RkZPeklaWU5yTXgycE9kWmh1KytLY3pESmx6Q3ZBUlRnTEFHWUFhNjgy?=
 =?utf-8?B?U21SOW80MzkxQTR3cGVlaHJlTmp0NDJ3TTFDU0s0RDlUQkcxcXVFVlZGNW0r?=
 =?utf-8?B?MzFCSzR2bmVPeWZ5bXVIVThPMk1uT0VjcUg3dVZSaTFtMnV0dTdsV2RNNkh5?=
 =?utf-8?B?ckZrZ3dZTXF5a1BldzlJTjgzZHl0eDJYZFZkOFU2bWgwV0UrZEhRQmsvKzRE?=
 =?utf-8?Q?Trj8+9+zojTIjXr9W/vB75DaX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d4d8fcc-8a50-4d6f-9d04-08de367ca6f1
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 17:10:13.8749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wT/KeLVPHwI0j6Ev/YZjnGqE0hjphqznTU/BWyxG7Fz7j3whVi/tPegBGE2YTMRvGjpYIaRWdOKKibXQv271ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10318

Using new API dmaengine_prep_slave_single_config() to simple code.

No functional change.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index debd235253c5ba54eb8f06d13261c407ee3768ec..eef569db0784d37bd6468b87fd951a5a0799ae69 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -162,12 +162,8 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
 		else
 			sconf.src_addr = dma_remote;
 
-		if (dmaengine_slave_config(chan, &sconf)) {
-			dev_err(dev, "DMA slave config fail\n");
-			return -EIO;
-		}
-		tx = dmaengine_prep_slave_single(chan, dma_local, len, dir,
-						 flags);
+		tx = dmaengine_prep_slave_single_config(chan, dma_local, len,
+							dir, flags, &sconf);
 	} else {
 		tx = dmaengine_prep_dma_memcpy(chan, dma_dst, dma_src, len,
 					       flags);

-- 
2.34.1


