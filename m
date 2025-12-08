Return-Path: <dmaengine+bounces-7540-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0B3CADD9C
	for <lists+dmaengine@lfdr.de>; Mon, 08 Dec 2025 18:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8110730DF967
	for <lists+dmaengine@lfdr.de>; Mon,  8 Dec 2025 17:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9389D2D8364;
	Mon,  8 Dec 2025 17:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Wp8+bfBz"
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013001.outbound.protection.outlook.com [40.107.162.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3AE2D5432;
	Mon,  8 Dec 2025 17:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765213848; cv=fail; b=DJBk38TM/e8xwhL5Nu2gFn3PoKBZ7+ibv6gBV4oiroaZhgCNjtLzpSoBN4E9z7GtqGfnTaFT+3loTBtk9O2pBWPMxqGV7xYtgcDV/MUWPmE6ueJBemdeldzstWG6AFg/G+Jm6n0XNimHCqLvSrhe6MfpwaHUx3Rd/INmrEsg0zw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765213848; c=relaxed/simple;
	bh=uI/FTwhlLA2v5cGJPepnQoEJ0HhkCDL8rgc8/R4uoxc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=bAROt4MITFC1idn7lbXq5XMxCbS+dsbInc1LW+DPSio0Spv1oDGjgJReS5aaOzu+5D/7r/4W74HKeV+uDULbubUrByZCAl7+5guLXK8G9kR7TMuOfvtSa9EczaiZkEVpBD2Q6NtzZMO/tNcCWGRaoxMXNnGYnZSqS4Vajnv2IC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Wp8+bfBz; arc=fail smtp.client-ip=40.107.162.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IdsHQpvX12hhZYKEca62MJdQMh1a54exvmCY1H7p2kiUZ5BkARZoEXFFUg2PSOR+7C8KFwqixuLPXYWl+rYtkh3kstnHDQDlCZZ4deIRPOfRdjnNq1McA4+G6vOIDiwXtMCs2R0b35YtV+eOBwW5Quqwt3Ao2K6xg86hDdnJIzcySLznJNaL1zhRisndw6oSh9CCVUZUF81aMuFMBLDUGg4BpL3SMhB/CTASLJS4H3hdD6l6F64m9cXqMp3q+kvOOAlviA0j4D/d3equE8SWnOrWcKjHE3+qobwoJOvKm9u2sdDOsfa/hnxguuzpi9sVRVunCSd2MxNAM3w4ALWt6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xs8yZnqOabVBEXqm3NXuiT9v+Cd9usEZTuBQBZk71B0=;
 b=cnS+eC37TEsJ5c9hSobLSArvEBE67bp9VwOXrf1Ngar8smHdEgwgldyAdGaqZ9h0epbBtTQrb5/oeheKzd1EAQ47/Nk60O6e8CP1WTo1/kahndlZHC7cHo4CgLOCJv+myYYKp5iQW6Wpq5EfxdIBGmjd8Vn8eCReVZB3PFChBSQtqGOLB2lmkliyOMorAka9ec/FOT1ipgWrZT4rCoJgt9fi+SzUFmmuMmaF/IqQTe+do/9EFqcJuUJjeis1RznomMNkb50DQyjCubMkZjLgKdjjb0cXmSUOK2qv1e60uSJZzdK5CVvnfFiwIYmX96zYQ24nQr91wE/n0+SaQ0TJiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xs8yZnqOabVBEXqm3NXuiT9v+Cd9usEZTuBQBZk71B0=;
 b=Wp8+bfBzCi1UMpTORcIwGdxq7iLA9sZPnw7YgyklgLMUPDXSzG27zUnWL3o9ZHFtvkwFWRUUy5T0UhU4VOru7lt8Cqn/OgpCPiIBPkMNA6Ee+Ad48xphiJMWam3LaJp4VcH0EakCZT+6Jlz6H9XmP5OGIisOpoLHAb30Ow7hJd1mYFCOh8/9evJWwb2KiGr3pxeU9TosuSKld0ti5GnQhYG5hfQ6joI8b7bkmNGN8uyScOUjYuxbevj9L33z5+mEqCaQHG7h7QShjgm1tR3drHSdUBUkesE5j6Ks7zCA3y8AcABs4hm4GeU82McYEqZfaiSCPA1zHfZI7uvuyz4iAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by PAWPR04MB9888.eurprd04.prod.outlook.com (2603:10a6:102:385::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 17:10:43 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 17:10:43 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 08 Dec 2025 12:09:47 -0500
Subject: [PATCH 8/8] crypto: atmel: Use
 dmaengine_prep_slave_single_config() API
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251208-dma_prep_config-v1-8-53490c5e1e2a@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765213799; l=1013;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=uI/FTwhlLA2v5cGJPepnQoEJ0HhkCDL8rgc8/R4uoxc=;
 b=NJvfMFtSyAekS4RsdTliRSFgHfPHM+Om4WikO2X1TdMnN0K6PvlejzXZGx3IxKzKG7iDnbBgm
 Vlethj0OatABQZMXsgyLCAuvz4Canb6JGUZLfjupzPWjrPaWzIEFi/l
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
X-MS-Office365-Filtering-Correlation-Id: 294742f5-e570-4a51-da6e-08de367cb89e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|19092799006|1800799024|366016|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?emtZMlpISkFyUXpsRWZsdFFoVTUxMFNBYzB3OFA1SWN2OGtyN0MvME1CT2k4?=
 =?utf-8?B?OUtTbE5oVDlJQmloWW94cmV0VDlXQXVzcGo2L2xYb0dRTHZNYVpwT0dBQk9a?=
 =?utf-8?B?Q0N6c1k4WE5tRThnaHY5c09iSHJIZTBPdkpwV2pkT08zdWpqa0hwdU9UallT?=
 =?utf-8?B?ajFZSzFRNEo2RzYxcm9PWHpQcmdBWTMyb05qdi9VYzlrVm1lTkFPUlZLMmgw?=
 =?utf-8?B?dGdCNFQvMW9zcTRMYlE1TFVWV3I1RHgyZThaUUh1WE9PUHBXMVpOOEhYbGw3?=
 =?utf-8?B?S0podzBGT1l0TVAvaVR4b0VTd0kwRGR5WFh3d0NLR0NEYkpkMXlwUXQ2QWhF?=
 =?utf-8?B?a0JaK1I5VUVqZDkxeUFQdDE2aDVwZ3lNRnVpTGJueFhSWjcrZDUxM2Yrdlpa?=
 =?utf-8?B?aG13Wi9zSXdZV1c5bDcyRUZKUXRlSXQxS1ZXZlhQZ1R1VkdjbGxQbXB5R3ZS?=
 =?utf-8?B?RklQODFNR2J6WnpPVTZsSjk3dkJhR2I0RU1MVUdCSDhVYThUbERRY0czamJu?=
 =?utf-8?B?UDNBdGFjZ2YxWjE4WlJMODhFZmhhdGVZOVRBNHZ2cVNRRWZOWVI5MWJrWHhl?=
 =?utf-8?B?bFA2czR1NzR3VmJZMGFmaGVIL0ZMNWNvSlBGMnNxZ3RUOWpYbm9qb3RERC9J?=
 =?utf-8?B?aHk1Z21KK1hkbDZhOHdCaVNMQnBlWnRoS0JMRE1ZN1BCR3hVNmJFemFmTHFE?=
 =?utf-8?B?R2tCNko2Y2p1c0pKYWNHWG1YNXZsYTJSVS9RczIweldKNiswUFFzcU15aTRL?=
 =?utf-8?B?SnJEMVhTQ2Uya2FoSWRYbUQwOEdOUDhhR1M4UGljUTdHL25TVXlIQ3d1YytQ?=
 =?utf-8?B?aFgvZno3ZmZNOVlYQWU5Vm0zVDJlcEpZV3B4SVdFU0I2QlZxZlhaYkFidmVw?=
 =?utf-8?B?cWorcG9iOWVydkJ5SDE1eFcrY3FXTmNCdzJzSGNjRzhzaks4SmozbW0vVHlU?=
 =?utf-8?B?aUNITXAwRGE2RUhENklKNTdobk1tZWsxdVg3c09vK3lZd2YxQU1oZitUZ0Y4?=
 =?utf-8?B?UDYzRjB0dUhyb0ZWeGN5WmVTNkgzcVFLcno5amljZWRrNE4vVVFod2pjNWoy?=
 =?utf-8?B?QVR1MzZFNVVUa010cm9lM0U1UmYyeUoxTUFycTZ4czZBNkgvYlVaSmhjOTNU?=
 =?utf-8?B?TlRqb25WQWI4M1JjNkdOcWltOUo1MTdYclRrdDk4THpQQUl0VXRIT0lyTm10?=
 =?utf-8?B?NzRFL2VCWkdkV0RvY3oxdEppNEFKVWY0Z2Y1WjQ1Wk15czNhWlplUGxXazFv?=
 =?utf-8?B?SVN2d1FZZmovazd5UVd1YWVodm1abldSbDFZbnhLZlIxOGdLZitzNElmeTJ0?=
 =?utf-8?B?YWFQTk1OK3hZamVMcmZvcmNGTEZXNE96ck52aCtLRVR6d0RCOEVLSkI0ZmdV?=
 =?utf-8?B?YmE4anQ4MFNLVTZGTE1BYi9oMzRERUphdG1pRkZtdUh5djRTNzMzaTEzaElj?=
 =?utf-8?B?em9jVnBqMDVKZHJSaS94d254MGFWVG9wN3VzdVJzVHN4VGtwVm5PTURLRDNw?=
 =?utf-8?B?WlozVXZJUE5FZTlpanRXTUw2SHIyeXdXZDhXYWkzTXZoZE9CVTA0czhJQStK?=
 =?utf-8?B?eVBxZkQxeHdUNlRzTEt1Z2ZHTTZSQ1BKMHgzVXFtbndFV1lqd0lIWFpXb3cz?=
 =?utf-8?B?aFl2dlFyZHdaZ1dYbWxGa000RzVSMjdRVVAvZm80K2Y5T0RFQlQvc0hJZWJY?=
 =?utf-8?B?UFpWZ0xReVl6V25MbDJkMjIzQkFLZWdIOXpFV2RXdFBYS2VzNzcxN1hrdGZ0?=
 =?utf-8?B?amZ5REJKL3BIaHptR25lKzh1TEw2UVFlVHpiMmwxbFBpQ1ZtVWw0d0pob3Nj?=
 =?utf-8?B?eVNVZ3VGUkk0VnR1ZUFhQU1YTFVkZnRwNVh5MVZZcFpzS3pTTWVVWFRiL2NM?=
 =?utf-8?B?WHY1RUxKOFZacGZ3TUJ4YjlCcktiOUpFanRoMmRwOXd6c1V4NVpJQ3JEaERz?=
 =?utf-8?B?WjM4TGNObkJVdU9iUVdrKytCaVEwR1p5VlMxeVFtdHJSQ3Z6MXJzRTMvUGVw?=
 =?utf-8?B?S0kyNktzY3paYU8rU2hBTnZ2d0huWE9QYSs5THVoUFRwcFZOeVJ0bHFSZVVN?=
 =?utf-8?B?WGxJNEwyTUlKSUtYSzd5dzdnK1diZyt5T0VHUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(19092799006)(1800799024)(366016)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eTREVjlnS3dEaXdoby9kSno5K1ZyVXRENFQ5Q3ZoMDgySmlOKzBjNnJJWnNq?=
 =?utf-8?B?NEdFeGcrWGV3WlREZFNKbyt6TFpaMXoyYkkvMXU0enFvcmZvSXBDTUp3MnJ6?=
 =?utf-8?B?Y1M4dUgrckhKRXV2UEx5ZmFHdnNPR2lldE0wQXZYcjhMdXFuR2xnc0dhMlla?=
 =?utf-8?B?WncyQWg2RGxwTGxrZUlhUWpXQ1lERHZmeFZhSXU5T05zQ2phaWdGbzlHelFM?=
 =?utf-8?B?NmFMTWR6VkUxT1BNRmVDMlFxUUVZTXg2dUpHOUVrYzltaUgzMWpEY3RLYmhy?=
 =?utf-8?B?ZndmVDUySjVZSmJPSjVjZEE0RXBRSXpleDVNMnF0VG4xZ1dPSWNaM2g0TGRn?=
 =?utf-8?B?ZGduK1FmcmdNbVUxL0srbEhsYVlRdE9QamxicGVkT0daVzU4bjNvaVNGNlRq?=
 =?utf-8?B?QWRwRlVWa2tSQk5wbk94MWo3MHYvQlN2NlBsQ05sK3NZTkpQN3EvMk5XQjVI?=
 =?utf-8?B?NEE2MTh5TzUzZDdHa2VSVFZLbWMyakxDT1FZaWZ3WmxHNXc5RzJCTWtoWjYy?=
 =?utf-8?B?U3IyaVphTjhib3VGbWtoekVRbW8vQnNUdDNTWUcybG5ieXBGWHE3Z3lrL0d0?=
 =?utf-8?B?aTZvVTRJMlBtNFBsU083TlpQU2c4RWU3ek9UNW1IQnV2eTR6Yk1PUTJXNVBG?=
 =?utf-8?B?TTVtcjJaUEpBYStuNnJ6cU1McFdaZ1lyKzVTRG4vOTBVOEdYSDRmS0FkRnpL?=
 =?utf-8?B?RmQ5TE1zMGp0b3cwbnJ5N0tway8yKzJwNGpZTnhMVEJwZ3FncUFQNWpBMlRq?=
 =?utf-8?B?eGgwRTdQazBJQWtuM1NlQnI2aEhmd05HcFZHRkoydjI2VS85R1hXaElCN29U?=
 =?utf-8?B?NXJpRmJ5SUMwbXlWL3JzN2tJK0JUZFYxdGkxeUtNNm9RYms3YUJXeStGVzVo?=
 =?utf-8?B?TDgwY0szTHlzdFBNNFp3TDlOczhVbURkRktJTTlHYmVuTEZpa0pkR3BoZ3FX?=
 =?utf-8?B?ajVNQ1F3YlhRMThUZWZyeE5ZMTdLeFgvV2R6RHV6enNlT200THJvSzlvMWdm?=
 =?utf-8?B?TnlYTzhydzJqVkxvbWhSdmVhQTk1K25nZWV6ZTRUTEU1aDVPbnpOenBhTStw?=
 =?utf-8?B?SkZYaGw1Y0xqY1MzTzFxL3psMmNmclpZVEVGdm1CQ1U4VThjcHFTcDlNcGM4?=
 =?utf-8?B?YkFsMEZhdHppZ1FyRkx3UUNXRnZxZHdoL2NHTjVVQ056dnk5eE5pYitRVFAx?=
 =?utf-8?B?U1o4V01DRTRaaHd3VTA2RDI2Q0ZhbzdIMFA0MnVqcHVoSUJXZHUxd2JUS2Qz?=
 =?utf-8?B?d0xNdWgrZ3ppYjJxSkpESERXL3JlRHNreHQxNjR0VjZTbGlJWkoxQXBWdUcy?=
 =?utf-8?B?WW0wcWZndEg4OS9qWUxORHdPZDJiWVowbHpoNGo4UWczd08vSGFRSzBNSnlR?=
 =?utf-8?B?M2hYdnJSRlhqdFFVRGZhMmxKMmVQL1ZhUDloakdjNzhyVWIybWQwdUNROWZH?=
 =?utf-8?B?SnNFUENRZ0R3d1QvT1dHemRIWW9Mai9tTGJZNi9HS2xqT2I1aFFJaGd5Mm5u?=
 =?utf-8?B?VStsNTdVTG1WZWxwVkFaY0JDbWt0VFJQOTg3U3FndCtUVm9SaElFRDhpN3J0?=
 =?utf-8?B?Q2tHT3I5eDViVEdqSmttdldJS1N6djN1cFlEYzJUZDZCMSt4azRSWVJhMTl4?=
 =?utf-8?B?azJTN09CVysvTHhhaUdkajNUUmpHSjFrZkQzVEhJRDY3NllHOWltaVhJTllF?=
 =?utf-8?B?RDhsdWRPTWluaVMyMmRUQVVQUkc5R0N2RGhkeE1QamtYOXlFaWxvZ2xRUExo?=
 =?utf-8?B?VGl5QWFtVElSMnl2UnhLSitVYm9VNTVkdGtnT0I2MjF6RjBYdVFEZHJ4MzNI?=
 =?utf-8?B?OFNXaXhKdXVkZjVHU3JnZ3JBclo2aGJZY1NqOW9McVYzRGI0MmYzSExBcnBa?=
 =?utf-8?B?SytVSEEyTUZFc2M4YjE4c2dKaGd3K1lpb1laaTR1Z081TytxWTlXd3ZwRU5u?=
 =?utf-8?B?Nld3Ujh2eWhWWWt1Qys5YTZpK3ZjakVERTRnWGNDc1c1Z0VMRnpCVVBRdDBl?=
 =?utf-8?B?WExGS2Q0YzRKcHhrR0l4WUZIaDVWVnMyVXhlK2NTV1BJV3ZkZnQ4VDlDTTls?=
 =?utf-8?B?WkZnU1pjdmd5dlcwQXp1QlVyK3pYUU1RdlNxazgzWm52V2tkaHFFSkFnZExL?=
 =?utf-8?Q?syjk4BOlbaLfHxZMC/zO1kpSD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 294742f5-e570-4a51-da6e-08de367cb89e
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 17:10:43.5663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TDbsD6eZ8l9SKjRqvI37EX38vvPVZZVPSt3NbMTGCu+nh0qRpbn7WQ3KAP3k4KZSFntEUYlPQnEm+PPtF/XktQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9888

Using new API dmaengine_prep_slave_single_config() to simple code.

No functional change.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/crypto/atmel-aes.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/atmel-aes.c b/drivers/crypto/atmel-aes.c
index 3a2684208dda9ee45d71b4bc2958be293a4fb6fe..14d46186865a1a6d8a11486b8f3aca92341fb1f9 100644
--- a/drivers/crypto/atmel-aes.c
+++ b/drivers/crypto/atmel-aes.c
@@ -820,12 +820,10 @@ static int atmel_aes_dma_transfer_start(struct atmel_aes_dev *dd,
 		return -EINVAL;
 	}
 
-	err = dmaengine_slave_config(dma->chan, &config);
-	if (err)
-		return err;
-
-	desc = dmaengine_prep_slave_sg(dma->chan, dma->sg, dma->sg_len, dir,
-				       DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	desc = dmaengine_prep_slave_sg_config(dma->chan, dma->sg, dma->sg_len,
+					      dir,
+					      DMA_PREP_INTERRUPT | DMA_CTRL_ACK,
+					      &config);
 	if (!desc)
 		return -ENOMEM;
 

-- 
2.34.1


