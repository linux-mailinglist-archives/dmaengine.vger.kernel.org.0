Return-Path: <dmaengine+bounces-8040-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4A6CF5E58
	for <lists+dmaengine@lfdr.de>; Mon, 05 Jan 2026 23:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7E6D3122C2A
	for <lists+dmaengine@lfdr.de>; Mon,  5 Jan 2026 22:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CBC2F90E0;
	Mon,  5 Jan 2026 22:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CN9MxiWo"
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013004.outbound.protection.outlook.com [40.107.162.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C151F4180;
	Mon,  5 Jan 2026 22:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767653276; cv=fail; b=u+a0goXEzB2olv5MF6e9jwo9P0rZeYWeKUDkslx6wqBTXhW4aE1gOpVZmDhlrEH1TscbiXDAulUUKCd/ubFw3SUswmtql8WYNbNk3bxNS9C8jAUUmqLYSHFwYWfvjzQE82GFlQ7OlTJCOfrBBsBIwJEfyMum1C348k4V4+7oTYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767653276; c=relaxed/simple;
	bh=ewejcruFbomjZgPOCeq5HHbbhhrn5qa2Jbl57FOSR28=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ldI28iiHSvmbUjcT2T+BG4rG8Lcj0358/PV+Vl/Hmnqux1GsJJwuQASe98Bfg0rg6UTuQ67dHoToty2ZgfAS8M4ktKpuciUTOZGAWudVU6DxoqbCfhYUXRadD3yXORtkgLQdVueeyLkwlGVf2AraxGeMSyf+7PUJKPk71S2lLps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CN9MxiWo; arc=fail smtp.client-ip=40.107.162.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ccyBD9e3wIeAFO5KhYS3pj0+81FldWSMZuVCxdL1ZEbQQH2zfeetjbymTcl2yyWRXMQTb/N4+0scPRgn75Si5uAqEHSSrNjWoY0BovqEM/NTVFOYFS4xQBLh98a0bnLdZxKGP1Fy7CnkSj1huLaOp1bpFLqHIP4RdoflnMSogex+SYpj0xkzB6CK7fU4Ihju5p8YR6/G0CZ4O00djsxZIT3Q7qpcXhaVWsbGwsuWpfMYqikF+aDt1ROuW3V6kIXl7C9RpmX5KhwUyv8cvKvAY5weNFZLJV+YrTcxASxB4JCoQssbwClV3Qny694HmGrWGQXw6LtKDXyWAzZU3FtmJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bjo8TTTGAcC0CcTugYF/TIn/PBNqQnvXoDiOf2W6Kro=;
 b=BESDyEZtgRbmoD+l/jQ/ToWJZ8LDGJFWeb/SyUyWYi0701FttdC4foO6HwD4RZIpmxzYQdn7dqOf2dI3/GGpvJ/QOz6W7MbiJMLAnVl8nxARCpctwPXjqv0CzESnFHluAeILPduGztD6lY772sQSVegZcIXT8c5jGjHi4HuH0u09cI7W6hyg3nx0DI2bdoiWBC3hasyE0JxF6ulBKGbqZDEGnr8p2pCfLk32/4D1AAAPIY4Q3u3zLij3EKvHPqPRz2rhNPmNmQnu5ayWzJZjSxiU5sIvgzh/K8jW0CsQthUbESTTqF94NWIoqrY/0eZ2sauGrh3WgkJPkVT0R5lkWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bjo8TTTGAcC0CcTugYF/TIn/PBNqQnvXoDiOf2W6Kro=;
 b=CN9MxiWo4vG7zaXkuF6Eh1lja1aDTtup5NlqALwmsKdk8N9S0FdvSff3vTowvJgjNq9ZRPL0LcKbWxcgviQTHnthevOlWY/1L1GZu6DHt9opOGhJ8hYESiSH4aWC2BRphYpGBcHaM3FIy6anJvSrpr5sHKIRfnTx3fxvp+qqYONkKsN55DeyhbFZxmnMIKpgSxB2tXLR4mwm5168lIIHQLsJNIuaonsRn5F4dap+L7ZN96UN/DV2XpmVSBuo5wYMIjktLTTCANQcafkJ2ZI1irTA/6rVM1venALIWSLfsIzTCEtyNVRIqNFYzGQ8bcH1oovPINb/OqCxqad4AZHb7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by DB9PR04MB8185.eurprd04.prod.outlook.com (2603:10a6:10:240::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 22:47:51 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 22:47:50 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 05 Jan 2026 17:46:56 -0500
Subject: [PATCH v3 6/9] nvmet: pci-epf: Remove unnecessary
 dmaengine_terminate_sync() on each DMA transfer
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-dma_prep_config-v3-6-a8480362fd42@nxp.com>
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
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>, 
 Damien Le Moal <dlemoal@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767653229; l=1297;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ewejcruFbomjZgPOCeq5HHbbhhrn5qa2Jbl57FOSR28=;
 b=8i2ugaRKBKyDDJj7h0IYeYwjuqzVlQC+icao9r2teUTT+gVm6soMtQ9YF1z+BYZEgoua9LIzq
 vJh3ulri1bECWCXyX80wEAbsEbaafaVCPoR/vi/XF5WcJ4586wuA1GC
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
X-MS-Office365-Filtering-Correlation-Id: 785a143d-9148-4640-9ba7-08de4cac74a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cFNsSjYyUlJNSHBTc01BL3pNVHdIbFBoY3lkMFcybDdtWGozQXJwbkZqY2RT?=
 =?utf-8?B?Q2Z5Wkw5WEFLb2pWMHhPUjdzTG9jSFdwQ0k4bWprRkFwVXRGZ0Q2ekN4UWxK?=
 =?utf-8?B?SFI1dXpDbGtGdVo3RUViQ1NIZmIyYVhzb2VVQ2tZOGVqdkNEREtrR0w5Yk1q?=
 =?utf-8?B?ejg1aWs5T1kzMDlGajcvVTVrOEZmdHFkckxNWkI4eC9XOXNoUXZVNjlPWHdE?=
 =?utf-8?B?MmdHUkYwOUZ1S3VJNzdFdWN2OWpnUDhqbWc0OVNVSHJXYXdwVFpmMlZTV1Zr?=
 =?utf-8?B?MlorS3VPWXc2ZEZPMFR4d0Q5K3RJeCtseFJoOG8xeTh1eFhFUWthOTREelJN?=
 =?utf-8?B?NWNUc21rSjhyYmxHZ05JZkp1Nkg1c2FJSDdVR3JOaWdyaDZVMGd5Q0U5RDhY?=
 =?utf-8?B?VEhkRHNFUTdNZnVIT2xtOEN1aS9hMnVvb3lZbzFWc1B2RVJGZ1JmY0NYRTMr?=
 =?utf-8?B?RHlSRXh5REhjZlE4WFZFenV3aHdqZmV6VXVaaDMzd24vdlJjSU5IS3VmbDlv?=
 =?utf-8?B?bDN3UHhTNTl2UGMreC9ENFN0Mk45dmtVVDZ1REpFNUxIL2RMWGp5V2hJUjJv?=
 =?utf-8?B?RHQ3RDZKTUtYY2VoSGxWdEZPY3BXRUsweUV4UE9DeFBOSWgxcGJ3akdJZHRY?=
 =?utf-8?B?dHErKzMyRy9IWUFicEh3aVZTVVpIV1pLVU43bTNFYS9QSXRUdENpT0h5emdz?=
 =?utf-8?B?YUx5RDd0NEVLb3B6d1hwYTJjdHduNzQ0ZVp6WkVHM05LTGxxeTZ6MmlJRDRt?=
 =?utf-8?B?cTM5d1dsWmVkNXdsVDB4NkJtQnVTZWZkOVpidWV5T2ZqN1U5TGpPMkpjZENs?=
 =?utf-8?B?L0RGblRZcmh2Ni8zMFVlMC8zaUtlOUdrQTRJRTZGR2pwUzhaMnN6b21pRlRR?=
 =?utf-8?B?K1hZRkJKOXBqd0JWL01UTy9HckFOSWFjUWhNazRlTSszc2x3UGt2djBiVkpp?=
 =?utf-8?B?SFZ5OCtKSnczenJDL2dJK3FqQ3hGeWJVcWFwR0Zwdm5HMWpoUmJ6R29mK3Rx?=
 =?utf-8?B?blF5MCt5emV5b0dCa2xtNnJmcC9oT3FDUGhoVTNJaU9FUzBSaGpUOHc1L2tn?=
 =?utf-8?B?ZkRiUXJ2NWYyeUh1TTc4cFFRb0R0WVJzZUc5OEY2NnlPTUprKzcrdm1RT1h5?=
 =?utf-8?B?Tk9MZVRwaUlSb2dheHdaZzVIV2E1ZFprQ0hqa3RldENkdmJlZWwyaStTcE1y?=
 =?utf-8?B?VVM0WTR2SURVK1BEdFM5OVkwdjFkOVNtUlBtU1ZvVGo5YVFWeDZOeEh4b001?=
 =?utf-8?B?cG9CZU9WcGgwcjgyUkxGTERpY0NpV1g5VENoWE91Zm0vei93UnFMT2V0dW04?=
 =?utf-8?B?VFU1ZUhZaFg1VEdRVVVQWnNqaldmalpkMmVaeW5ZZkk5S1lvaTNTV0FTcTI1?=
 =?utf-8?B?ZVFrdXZPSGxBV0ZINnVUWU9GaWpEY3BGemZVRXZhbFp1SkRZcXpaMUcwUk1m?=
 =?utf-8?B?bDBlZDYxUVVmVk9HL1VlUHdodEZRejM1akNMUHdBZmpnbm9YbEZqb3hqOGtq?=
 =?utf-8?B?SDNVNEpYQkh6NFRXNllIanJzU29pU3ExalFsbWRNckRKVXhjeUdHRCtsNHJQ?=
 =?utf-8?B?a2ZJd0NLcVVJZjlpTWlyTDBmamd4TTdacjMyTjQ4RXBPdjB1c3RqWlZYWEY4?=
 =?utf-8?B?ODRnK1B4UkRwR1p2TkdFcFp1WmZvTmk0eVpFWTJqRVZETzZ6cC9MQlBoeklv?=
 =?utf-8?B?Y1NvSThpOWNMMjU2WHM0RVFoQml2Tm4vcy9qZklaR3RqaHdDNGdEWmdFenp0?=
 =?utf-8?B?L2xMSWlMM1ErWElTajZjOGlaemJSdTh2VEl1NFJ0R0JJcFppK1FoVDl6N0ly?=
 =?utf-8?B?c29XUjBkRmFFd2c5Y1FkanJyZURCbkdjYW8zRmJvUkNZNUlmTko0QnZzRlhm?=
 =?utf-8?B?VU1uZ1NQaFNUMzkvOVBCelhwbmk2LzUwb2xHSjRXdTVabmNEejVsRnhmb0hq?=
 =?utf-8?B?NzF5TWkvcldJT0NkYTNwVWx1Yi96TzhDclFUeTRQWVZkV29OdTRzVnQxaXpQ?=
 =?utf-8?B?R3owV3c4ZlJ0N1RxZCtYS1pHZ3BkcE9FdnhVOTR1eXkrQ2poMmRta1hySlox?=
 =?utf-8?B?QnNyLzVxYURHV0ZybEo1TXp3enJkU3FIcGhaZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGpxMGkyL2NNT3I3UzRKSnV0dmRkSlZoVUFTdzdiMnRSN0RhYmNlZ1l4WGpP?=
 =?utf-8?B?SGIyWmttTVFzSi9DMjNMbUlFY0xZcEROdlc1SnA2a21oM010SXVlTENYaUg1?=
 =?utf-8?B?QzJINXVRMDg3alBGeUtybkQwcWpjV2htaGNPVEtTSDZaZmJLdUxKQWMyUDJ3?=
 =?utf-8?B?Ylg4RUJ5U0hmVUx3OXIybVR5T1k5aiszTmxhUHVXQTRPT0YvRjR0RExsL1BY?=
 =?utf-8?B?RFJQaDBmRXlrVWVWRmJUUkEyRGR6NzZ1aVdTUXdPTjFlRHBoV0o3ZzlEVWdl?=
 =?utf-8?B?RnNRQ05EK2tRcVdvTEtzS3NsN0JjcHViNmczT2lkS2JCUDJ5RDNTMjgyTVhD?=
 =?utf-8?B?U1RiMzhicTV4YStuRFRZeW4zZjV1OTkySTF0MkNRNVJia3Blb1FpT09NS0pK?=
 =?utf-8?B?YzJKb09zdHpubElQTWo1WVkyK01VaWFDd0t3d2FaUlEyREdvSmJvZTFoNitM?=
 =?utf-8?B?d2lTd0w5Q1JreEJKN2NoNE5GUFpIa0t5L044bnFzRnZxaldjT0tpUGRTajV2?=
 =?utf-8?B?anBBdGRsa0kyZ0x2QUZFQ1c4SVdSUGxPYXE2ZGpySXczc2lHQkVBdlN6US9N?=
 =?utf-8?B?ckNKUmV2UEJIeS9HUk9iUmlMcU13V1VYYlNXUGJwSldzUVNyVkdqOGl2QXd0?=
 =?utf-8?B?Mkxub2lhUUNlREZIdzZSMlZicGhYUkNDZE5TK1NHMng5ejk5TTVqV1daTzBY?=
 =?utf-8?B?Y001QVQ3cDJ2cU9UbGlGUU4rcUllK0F2OHVsTmx3Q05TYTdFbkRiZG1STDZT?=
 =?utf-8?B?aUg5aXVNQlpud1NZRDhHT2ZZMDU0aFluY2VPeVpUd3JheDVCN3FDSVJxcnow?=
 =?utf-8?B?V0w5bjhPVzlTODZwK1NYdXBwQUVjVjlOQ1hDZ01zZCsrZ2hmVHdSZnhKOGE3?=
 =?utf-8?B?L2lpNDZQUlNRRVRic3dzcnMvOU96REVIM244b1ladlhUbFh3d1ZCVlF3emNR?=
 =?utf-8?B?cm1qbmYxTG5IbVpacXhjVjN5b0F1WmRNRHR0VFZmcHZlMVVOdlMxaUIrM214?=
 =?utf-8?B?NFhSYVBhaDZJK3VsUE04VU5qZlpmS3I2WCtTT3ExNTIvY1V2RzBiK0VVR2pY?=
 =?utf-8?B?aFBCaDN2OTZsM1l4a05yaWhXMVk0MTBZdWJGdGhMMThGSFhMZVFEY2RiN1J2?=
 =?utf-8?B?Y04zT2ZGN1RmWmkxZHlOaEdMYzBzVjNzOFI3R1VPTC9nVndvK0o1ZzI5NTNG?=
 =?utf-8?B?RzBlQngxOXJRNjkxMFk1NzNqbEtMTUJ4Vys2aHNNUlRxMlFaUWd2MVoxRisw?=
 =?utf-8?B?L0FJbk1TNUo3S1hMYjZyQ2s0VmtDUDJ3cE0vZk5xQ2tpb3Y1RTZ4NkVib1Ay?=
 =?utf-8?B?Y09FVGxhTFBacVEycjlHTkVCdkV3Nk1nSTAxcGFlQUJKOXhJNHRqa3Awa0Nm?=
 =?utf-8?B?WDFmVSt3RXlIM1ViUmJsdFFXeXA5NWttaXNhSXcycyt0M1hxUURaaDFzbmhP?=
 =?utf-8?B?b0M1RndXZk9Wc200cnpBb014UnkvZk0wTE5lUVdkelcrb1VtL3Y1eHQ5MkhN?=
 =?utf-8?B?Qk1kWlJLM1hvendSNHFvYU9GTmU5TDBMM1J6dzdOaCtZYUh1b2E5MjFZWmll?=
 =?utf-8?B?dU9wWDgwS0RBMGlhQkNWVm1rKytVeFRmaTFzSTFvdmpwd25lWEJuKzZrTXlR?=
 =?utf-8?B?YUV2VzZuRHdzcENEb2lXK1N2dXRnU0d5WGRSY0tGcjhpWDFJUkNFbUh1akxU?=
 =?utf-8?B?ODZ6QXp4T2FDYUhkN3hkQ1FKTU1OMysxZnE2elBabThad1VZWGVjQVJxQTJS?=
 =?utf-8?B?SngrbllJYW9haEdUUmtDU1l2UHZ4RkcvaXRIdkdzL1YwTEdQd1NpWitoNkdt?=
 =?utf-8?B?SCsyaE82Vlk1WG9kV2ZyQWpWSUpTU2taNjBHRWQwRFRQN0JIbHZzS2RpRStS?=
 =?utf-8?B?bENLYzFVOG92MXBxRkd3R1ZzTjhtb2NsOGx2TXJhVVJlaHBVVzZ4eTl4b2FX?=
 =?utf-8?B?eU43RnFaWDJudk5PUFluSE4yV3JSRDI0L2VoYllWckN4YW5mTWRYaC9tTFhz?=
 =?utf-8?B?UjhUT3h2dlA0MSsxOTkxTUlvVENtSWpOOE0vRUxmK21FUFQzSE8xb3gxbS82?=
 =?utf-8?B?Y0VBaDNROXN4cnJWREU3eEVEYklhZVVGOU9UdktjSW52VW94Zmo4T1A0MUJM?=
 =?utf-8?B?Z052bzZJTEVXckxzN1BxdjhXUW9PK256M3hmdGpjWkp0OXFXRXNYZXlJTnpz?=
 =?utf-8?B?OEJ2V1U1L2pmZTB0VkFVWElFQTBXamhFcWZVUG1yTkRjVGFjRlBkRGdUVWps?=
 =?utf-8?B?VjArZDdNejQ3ZnBJVEtJWWFhTzVnVkRPYWxJTzRRa09NdmFydUg4a2FFR2Vy?=
 =?utf-8?B?TFRxVVpFUzFqTVNDdDR2SVZjVGFmWXZQR0Rza1RUcW9hTTlFekxPQT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 785a143d-9148-4640-9ba7-08de4cac74a2
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 22:47:50.9133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Uk12dKf3FZ4+4mD1NPeBQKpOFstcodsweXrNmIw2qF3/qbQnQfeF/C5fNaQ/2FXLOBxsh4JuS80gUZR0cqF4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8185

dmaengine_terminate_sync() cancels all pending requests. Calling it for
every DMA transfer is unnecessary and counterproductive. This function is
generally intended for cleanup paths such as module removal, device close,
or unbind operations.

Remove the redundant calls for success path and keep it only at error path.

Tested-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
This one also fix stress test failure after remove mutex and use new API
dmaengine_prep_slave_sg_config().
---
 drivers/nvme/target/pci-epf.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index f858a6c9d7cb90670037a957cebdcbf17dddc43b..56b1c6a7706a9e2dd9d8aaf17b440129b948486c 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -420,10 +420,9 @@ static int nvmet_pci_epf_dma_transfer(struct nvmet_pci_epf *nvme_epf,
 	if (dma_sync_wait(chan, cookie) != DMA_COMPLETE) {
 		dev_err(dev, "DMA transfer failed\n");
 		ret = -EIO;
+		dmaengine_terminate_sync(chan);
 	}
 
-	dmaengine_terminate_sync(chan);
-
 unmap:
 	dma_unmap_single(dma_dev, dma_addr, seg->length, dir);
 

-- 
2.34.1


