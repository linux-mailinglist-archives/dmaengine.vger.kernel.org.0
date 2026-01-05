Return-Path: <dmaengine+bounces-8039-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB22CF5E49
	for <lists+dmaengine@lfdr.de>; Mon, 05 Jan 2026 23:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 444DC310C243
	for <lists+dmaengine@lfdr.de>; Mon,  5 Jan 2026 22:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D124C4C81;
	Mon,  5 Jan 2026 22:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OodmToiI"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013012.outbound.protection.outlook.com [40.107.159.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B5B2836AF;
	Mon,  5 Jan 2026 22:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767653269; cv=fail; b=d3o9jWlpKES9DgOzPPwtlj2wPTn+xBL9KtZ9m0JI4EhIZ8sc5V1OJnmCLFeOKM/H1ImGcf5q7JSIy40TKZY1FbP2z+TgaZA0NPW4GA2KLZTYDQtPqQMf96yBaWiaqiMCAa2ST61iNMtHADtvaaPFRls0Wd0n5t0vtay7V1dcih0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767653269; c=relaxed/simple;
	bh=zXV7+21VtVcaEhMU+rM/ABTnDHsLkjDDk8yblDSveHo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=FXAqnWh8gKRrDEzUhxy+wsOmUpKGYJELMB3bkpKAEIsUA6fzT9Se6jVY1G7tShUOPt68rgwwiUcnIqIGZdMs9Ku4O4IfsINVmMH52pbF92qNFtCI2wCaoSyVaeo3+z28cZrb6Etrz66LLm5x06u/lsZDFDapN81mj8KuUst5U8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OodmToiI; arc=fail smtp.client-ip=40.107.159.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nVpWqpEQFdB7sIvUMWqdX06tJ9cRz68oqjezDZkqipqHnY5tShh6ZKrTWMNi35iHRx91YkzUOyEwABPbNW/h21jLagfOeBSO2BMyozOOsg6tfUtvH8A5s4u9Q3IIEKMlEqKXNPyAuGtLpnXWqnSTVW6MJqmX8BprfaYZRL2wfgRMA3Cl3Aennjv0j2bdUZxwfxiiLlye625tm6/ZcEldkVSi1tbCGu+/4sykdaSvBbeqyNiA0xJIJdzCmv+DXW+y97E/tiXm/cR3zimyqJzIbWMeu8lFtzN6hIs+fLtyMsxOGMdae6EF3TX6yG0fQwEbA2051YrQoObqICHHGBjrBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/PYODnaAjpiUrf8sRatuQPrPaxZFVF1DE6UIoUsIMpU=;
 b=NQMGMW5FuZBsQsQq/43V3IIYKMq04x70Ys4fBFkAvS1wZez73HokC6HXBNfBHtxgM6b4gFyaL481ZdtdWmfRfaxj+EmRY8hDyfoxxmpujOInUVYribFIEZVj5uLbatfVizx7Xb1JSC9b5lLKUkwxQ/4TldcDBowgSsIQ3rtxKf+J4yCc7bCgtWg193GN1YbckaHlKw5hYjo3AOytnFBPJZ5pvszmw1Mz/pyM1/0pDctjHKSOWtgiqBLJLxN60Fw82m/688jxWY7/JOfrNnA0d4V+YHQjoTkO1b8gEBe0k8wXLtCfN7kwlsn4x7WepNr1HqRQtBllkrMRFguWJiYYGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/PYODnaAjpiUrf8sRatuQPrPaxZFVF1DE6UIoUsIMpU=;
 b=OodmToiIZ4sTJTye4EmimgaWhWFzCWgBo2CoxaMC084KH9KLAH+Y1cYJTRP2xATp3Ueg+6l5gmdepQgwmaiJxN6oIj93aQ0zzA3UmGYGhm+SEHEUMVDdUbJDPiGiGoqyodDLUk4ASl09VcgeOuvctwQGL8YXyeaZ0fugn8U49NtD9ilfaFhQWjCWRHvnh5VzliQ7fs6GOchN3Ryo1URwQPIhHe6OKlVuRNcF/55iTlfzAn7eS0shMiIaCBEdupZBZEf9JJlPuuzhPOMtrZr4RJcbrMcyDWcjv/4H1JWNtfdLiyxj9vdzrXs4ZH1UQwgR5ET9IVKeUUPwUrsEDA7rWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by DB9PR04MB8185.eurprd04.prod.outlook.com (2603:10a6:10:240::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 22:47:45 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 22:47:45 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 05 Jan 2026 17:46:55 -0500
Subject: [PATCH v3 5/9] dmaengine: dw-edma: Pass dma_slave_config to
 dw_edma_device_transfer()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-dma_prep_config-v3-5-a8480362fd42@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767653229; l=3033;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=zXV7+21VtVcaEhMU+rM/ABTnDHsLkjDDk8yblDSveHo=;
 b=yDPrYQefAH6EBZGtF+3Uv+1bKJPmlzle41TbASKz+3YGzNA6AFGI+/oLiOm8nY2E3xlePm97Y
 8lZPCDbb4zsAM9xVrCrJdy2B/24NTuex+XPjSjiOAr/De4tTuDKyo6B
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
X-MS-Office365-Filtering-Correlation-Id: 6ee6429d-d289-4ada-d895-08de4cac7113
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bWpFM0daWmtlRnU0UjBIWVJkMXNvVjN5dGU4QWdWV2haVEVVVnA1eisrbXBz?=
 =?utf-8?B?Q3M4TVJyS1hUdXRBZ09mOW0rM0tOL0NHRUpGWHNsd04vZ0ZQQ3NrUkxQQ3dm?=
 =?utf-8?B?RlNsZFI3Y0ttd0VESTlsMXp6bnFhZ25NdS84RytHNElVTDZPRnBpbi80ZlhZ?=
 =?utf-8?B?R1JRTFdRRDA3MGx3T3lhbGVhNXltRnAyWmpXWW80aVhpV21BdWZUaUo0U2cw?=
 =?utf-8?B?VGRheWFnNEJzM3YvMmNMTmxWK3RSS1lPd2p0Q2xLbFU1MCtvYTJzUk5EYWJ2?=
 =?utf-8?B?N2hvUGZIOEgrRWJ4YTE1RW1QaW91QWVrUGlPeE5iVFdpNzk4Q1YyZ2J1RmNm?=
 =?utf-8?B?VUtkS3UrRWpRRndMR2wzdkVvdDFKaUpKczVzVlN6bXF3SlN5QzFmQUY5NnBT?=
 =?utf-8?B?TkdGMkEwTVlyVGtMVWNHRitON0xHd3RZeUVCeWVqRHpwbFNxanFLM28yaUY1?=
 =?utf-8?B?QXQ3Qi8xdE1uWHNTcUVFMDkra0NFck53WkJUN3NXMzZVSnlUSTZNM2syTFND?=
 =?utf-8?B?cGhnVW05MDZKZEU4MkFiaXdlYU1SckpRVTFOMHNKdEdrYm1YamhPUzJVM1NH?=
 =?utf-8?B?Umx0dWdCYVVRL3B5ekt6UUlCZnh5di9LdHY3a2lObVFnSkhNRnBwK3VxV1Np?=
 =?utf-8?B?QXl4S3dIWU92b1JxMlpwOXVoSzZNZitQcVdFZHRxVDN0dS9wWU1RQjRlQnBn?=
 =?utf-8?B?NWRBK1RDWkRFOXFxSk12M2F0VjdlNzdMejNZSWw2MitLVWJ3TFRzVlFTSXNJ?=
 =?utf-8?B?RzZZR0p3Y3NLeFhZRmt2djZFVFgrcWZvNGoxaFpzMys5VnpVZnA5WEVPZ01o?=
 =?utf-8?B?aC9ER1dubFRvcmFSMkx5STdid0wyUFVFc2FBblprT0hnVFFsRGZwSWRpVFFV?=
 =?utf-8?B?eDU2aWlsYlM0WHM3QTM2czFFNEpUbHV4anZiSzFWWGUxQTNpaFFMb0RTN1NK?=
 =?utf-8?B?ZHRoREM5cG16SW9tN3owbWM1SVltZU1IMC9xSkphcldDNEtrTkJLVnpWenQ4?=
 =?utf-8?B?V1h2MUNvaFF3SUIyWFNBU1dGYkZudUxvWmh6bzJGUW4waGU1QitoR0d6RWU3?=
 =?utf-8?B?ZlhZdnVDbzRUTnlRbmRQZU50OFU0ZFhwMFNjMWVtbmtRV05JeDlSa01HTi9i?=
 =?utf-8?B?em9FcjhCWXFMdEhEWlNTMnJyV1EvYVVtTGdJRW9WSkFQTC9PM3RhYTB3eis3?=
 =?utf-8?B?bmR1M2hrSlcxbndWYUFoT1BYK0hSN0p3SkZhVW1RTSs3azZFKzY2TWhIcGVY?=
 =?utf-8?B?eXRXNTRXNnIrMDIzSVU0RUNaOW5ta2NsSUZpSGt4RUFwUG90SEtQNUpmUjM1?=
 =?utf-8?B?WXZpeHZ4ZUdyZ2NVVkdmbVBmc04vdm9oQzVKWW5qMVd0dnUxUlEzUXRrMWFt?=
 =?utf-8?B?U2ZkbFJMeVFnbXBTWnhacjNnekhEeExLR3UxT1hnNnVCWTl0YTU4czAwT3oz?=
 =?utf-8?B?TVU2L0VJY3A0TmNWcmFjU2dMbVdpR0NJTlM3MDJScXlRM3JUNVIzVlJQZS84?=
 =?utf-8?B?TDkrWDdCa3FwY1VIblV5UHJkSmszNXZtUUhzTVVWSnRDQ2lReWNrOVFnZDB6?=
 =?utf-8?B?c1VXSk9GbVNSeEFkVkg1aWlZVWMzc0M0WkNJK3JDcHlpQXdFeUJVZUFObHVK?=
 =?utf-8?B?M0g1dTYyV0UzYWJaU1VnekU5N1Q5STVFNUIrUUpENHRoVE1oYWZWNWxyUVU4?=
 =?utf-8?B?alFtTEorc2FkQzNxWS91dU52Vndvb0dJQnNnRU1hQXZGYUN6d0kvUG5vQ1JO?=
 =?utf-8?B?R3lKV3N3TUtGRnl0N0F2bFJjSnVlYXF6ZWJ3SXo3OXBjVkRCNVg0THRZVDVF?=
 =?utf-8?B?cG9FQnViOWVVYTR0YWRZcU9aSEtRN1p6VjBpV1hSbnVvTk8ralBvNG4xc3hY?=
 =?utf-8?B?alhQZDg1b3JZLzlzcERkNUEzM3R5cy81Q2Z3ZitFUmZxcmFhaWNlaEZ3Tzcx?=
 =?utf-8?B?Zm55bHZWMHh3M3dKYnVabklNeXg2S01TM2NyUE42NDE5Zk5UcFV1UkhUUGI5?=
 =?utf-8?B?d0NFODBySWtzUndPSW5NTXNFZXF2WWY3Tnh0V1RKV0VZaDFyVFlUdFBxc2tM?=
 =?utf-8?B?MEZlQW9jZ1h6bk45NGpYcmZ1eCtXMGh2cUtnQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NCtRY1d6dmIyNHJSNzJsd3htcjlJcHRUSGNjdzNZRGdTREJiR0lrYVRwNDVv?=
 =?utf-8?B?cjRIbnFvNmI5emFXNjFHb3NTU2M0MXE0WDVPTGlwYVpoSmRnYmpUVzludEdG?=
 =?utf-8?B?R2tjb09FLzZ2REFoR1pxcXo3bTVrb0o3bGlQYUNYWjFaZ2dBMnN2V2JidHJD?=
 =?utf-8?B?SXdLSk0rREJzWU5aU05YOXpRT3NnREt1KzUzMEVYTzBicWNIb1VWYmUvZkdy?=
 =?utf-8?B?NFZvTnpJV2x5UjZjRWMyVlYrYitHU0F5WXdJc0o2UlAvaWlnZXBVWWlxbThL?=
 =?utf-8?B?RFRESzcwWTc3VFA5TlJ5T2xmVHdDZ0NsT2xZQVpzZE8vSXVkNmozQ0N5SWJQ?=
 =?utf-8?B?WDJnNjlTT0cvUktNVWlGeTBNd01SQm5KUDhSTDduaGRsbWZGT28waG5FUmdl?=
 =?utf-8?B?WDNjNlg4Q2dSeUV2Sm54T0c0Mjg4Q0R3bUVLQTVsRzdmUmJXdTd0TzVBZE9K?=
 =?utf-8?B?cUxWZnlzaUQ3SUpGUHNCeGhieG13bG9tWUNBTlNWV0Ftd1RMTHB6bTNpS1V4?=
 =?utf-8?B?NWk1ZkRCejhBcmlTZFpVTDM3dmdxOGRXeEhMbnJDMWVNMmhRTEhHa3hCVUwx?=
 =?utf-8?B?Ykx0WHkxVWpHR0g2V2JKQzlVcmdNM3pmMFBEcGxEdXFVL2RyZ0FqS2ZjWHVG?=
 =?utf-8?B?UHFXQTlNdmJES0JBdXlSZzlucEExTFFRQ2lQUWpzQit1L0hyNncvcENidjB1?=
 =?utf-8?B?VGdlSkpTUTFCRnFsR1M3REQrcVdmOWhLZlZBMkFHcENDZ1p1akhVRVk5L05L?=
 =?utf-8?B?TzFQYnZzS3JOL00xMmRUa3JRZVdrOGRTQW80eEZGcEpYQVRVZHBQNC9ZN0Ew?=
 =?utf-8?B?S0x5aUdzR1REVW43cFBaQ0wxRzE0KzZHRENCZDFxK0hzVXh0TjVvam9JUEdl?=
 =?utf-8?B?SldXUEo4RVY0VlViZmkwYUVtL3lYaXJpQzRxMUtVWWtKdUViNEJaeDVYZVJn?=
 =?utf-8?B?bFl0dUJyRFB6T21IbWpDSzFQR01kVTlQcTBCNzFvR1JpUmFUanRjKzRHaWdm?=
 =?utf-8?B?cjk3Rkw3UG8rK3NIbGRCNGRVa2dKRWRKamRWeUpPbXlUVEZGTzF0TEV1V0Qx?=
 =?utf-8?B?TVJoaFNreGZ0eWhBN1NqUzVIbmNubUhrdlNzejlRdnlpYlJ0YWg3QUJrUGFw?=
 =?utf-8?B?Z2NabCtkb0xOZWRrUHlZa3hlM0lXLzRHazhiblVEditWcFF5cUV3cXZNOEsv?=
 =?utf-8?B?Z1dhZlFObXNhQnlQQVRkeU9heExYRHJOdTRlUGdhWlVINTQ4eXpjZTducm8z?=
 =?utf-8?B?cUhZTDBQdjg5UlBPandXNnU2YTdUNElpck8xaGhoaEhpMVFTRTEvRXE2Rloz?=
 =?utf-8?B?akxMb0w4WS84MjB4Y1F3aWN4UUNhajIrUmxONGtkZkZjL3hlMXkyU3VHb0xs?=
 =?utf-8?B?VFUrdXAxMUNXUXlDQ2E1clNzVThIdyt3RXFPb1huKzAvQm85TFF2VEJla3Ir?=
 =?utf-8?B?MkE0dnNidEVtWkJLOU1nYU9OVE50Ky9vUHMvcDR1R3BsemtJQVVQalZZRURH?=
 =?utf-8?B?SmdPbWhtZ1pSYlArb2hGRytKcEFRU05jWmRja29ZY3hQVnZRVGxTc1JBUXQ2?=
 =?utf-8?B?NUZzUk5SNkxER0FaTDhML1pFNm95akhtZVhDUzdFSjNYeVNsSThQK2dlOVU0?=
 =?utf-8?B?SkY4SW9ld0VyeEFxY29iYkVyaEpneldRV3RSZlUwOTN5ZkJyL2Q0MGd0dEIz?=
 =?utf-8?B?WjZMM2tWcXRXRktmUGFCcG9JUjQwVU1rOExmNkloVm11dm9tZ2R0TDlSS3hy?=
 =?utf-8?B?aEtlTkdSNjNxMXA3bThPc0JDaFBqM1B6OVQxNXF0U2lldlpkWXJheEFRNWVX?=
 =?utf-8?B?Q0JLVi9CL1dqYnF0bU5BUXg2VklHV0lxOHd4WVJxeXpZaXhUa3ltWU9VSEVl?=
 =?utf-8?B?NXRlZmcrNXkwRG1CZ2hEcDBmMmtyQVNxSGdobjY0WW1sZW1rUk1ldWo0ZjQ5?=
 =?utf-8?B?LzF1R3J1SHR6Z21pN2l6TVpqY3lLUVo5K3RXWlN5NzhjaHVVREFLWjd6cklo?=
 =?utf-8?B?RFhFM1MzNzUyalp3b0Jyb1B3TDhuVkFOMENrcXltOUJvbkZ1RjZ4TWF2cVI0?=
 =?utf-8?B?cWU5Q3pjNnp3bVdtRlR3ZU9YdUttaFNib2hUWDFZWjBjNlExRy9sOEs1Q3pQ?=
 =?utf-8?B?V2Z2RGx3ZTEzMVRHMklBWDRsZUJZVmF6YTRvWmFaaTRaVDJnTEppY1NFN01J?=
 =?utf-8?B?NkxoYmNpc1B0cjdXQUdHeHJnYk80Tjh3VFQ5YVhTRUdDMmdORnJ2b2dSOE13?=
 =?utf-8?B?dnp1bVJWUWZSM0tsZHlTbGlQcURJMmFJYzBvNHZtYVJsR2ZnZXdGMERybGM1?=
 =?utf-8?B?MURJcEZjcDZDQzlFN0hyYllJcGwzL0gzNzBwczJONWl6MTRYQjI5QT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ee6429d-d289-4ada-d895-08de4cac7113
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 22:47:44.9649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p6ne09EdsI8Oc9APv2IG96+fIi96FeeZo+3rTKs7Wk8VrUO2pkMItDClson+6IuqQipRPTZIUfSRYKYzmVl96g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8185

Pass dma_slave_config to dw_edma_device_transfer() to support atomic
configuration and descriptor preparation when a non-NULL config is
provided to device_prep_config_sg().

Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v3
- rewrite dw_edma_device_slave_config() according to Damien's suggestion.
---
 drivers/dma/dw-edma/dw-edma-core.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index e005b7bdaee156a3f4573b4734f50e3e47553dd2..71823c84639801a7ccf944c00ae54f1bcb068d96 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -230,6 +230,20 @@ static int dw_edma_device_config(struct dma_chan *dchan,
 	return 0;
 }
 
+static struct dma_slave_config *
+dw_edma_device_get_config(struct dma_chan *dchan,
+			  struct dma_slave_config *config)
+{
+	struct dw_edma_chan *chan;
+
+	if (config)
+		return config;
+
+	chan = dchan2dw_edma_chan(dchan);
+
+	return &chan->config;
+}
+
 static int dw_edma_device_pause(struct dma_chan *dchan)
 {
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
@@ -348,7 +362,8 @@ dw_edma_device_tx_status(struct dma_chan *dchan, dma_cookie_t cookie,
 }
 
 static struct dma_async_tx_descriptor *
-dw_edma_device_transfer(struct dw_edma_transfer *xfer)
+dw_edma_device_transfer(struct dw_edma_transfer *xfer,
+			struct dma_slave_config *config)
 {
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(xfer->dchan);
 	enum dma_transfer_direction dir = xfer->direction;
@@ -427,8 +442,8 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 		src_addr = xfer->xfer.il->src_start;
 		dst_addr = xfer->xfer.il->dst_start;
 	} else {
-		src_addr = chan->config.src_addr;
-		dst_addr = chan->config.dst_addr;
+		src_addr = config->src_addr;
+		dst_addr = config->dst_addr;
 	}
 
 	if (dir == DMA_DEV_TO_MEM)
@@ -550,7 +565,7 @@ dw_edma_device_prep_config_sg(struct dma_chan *dchan, struct scatterlist *sgl,
 	if (config)
 		dw_edma_device_config(dchan, config);
 
-	return dw_edma_device_transfer(&xfer);
+	return dw_edma_device_transfer(&xfer, dw_edma_device_get_config(dchan, config));
 }
 
 static struct dma_async_tx_descriptor *
@@ -569,7 +584,7 @@ dw_edma_device_prep_dma_cyclic(struct dma_chan *dchan, dma_addr_t paddr,
 	xfer.flags = flags;
 	xfer.type = EDMA_XFER_CYCLIC;
 
-	return dw_edma_device_transfer(&xfer);
+	return dw_edma_device_transfer(&xfer, dw_edma_device_get_config(dchan, NULL));
 }
 
 static struct dma_async_tx_descriptor *
@@ -585,7 +600,7 @@ dw_edma_device_prep_interleaved_dma(struct dma_chan *dchan,
 	xfer.flags = flags;
 	xfer.type = EDMA_XFER_INTERLEAVED;
 
-	return dw_edma_device_transfer(&xfer);
+	return dw_edma_device_transfer(&xfer, dw_edma_device_get_config(dchan, NULL));
 }
 
 static void dw_hdma_set_callback_result(struct virt_dma_desc *vd,

-- 
2.34.1


