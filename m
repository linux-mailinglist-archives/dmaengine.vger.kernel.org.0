Return-Path: <dmaengine+bounces-1134-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA8A869D79
	for <lists+dmaengine@lfdr.de>; Tue, 27 Feb 2024 18:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 152371F24D55
	for <lists+dmaengine@lfdr.de>; Tue, 27 Feb 2024 17:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1754E1DC;
	Tue, 27 Feb 2024 17:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EIICawDe"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2070.outbound.protection.outlook.com [40.107.22.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7860D4E1CB;
	Tue, 27 Feb 2024 17:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709054536; cv=fail; b=k6ySQsaUuvaZOjQPwLFZ+/HqePO93CZ3DyVIF0+k+FVwWjOJ4uzB3BILeyVUYdevfpVCodO03R+SbnQSI9Kx3ZulkMuj0lkdj/pXCp1yGI+IsC951u+nSD+H9JTbtgbuCSOblfhzXXEEaqINd19z58B8viAg714NDnVigeRXM/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709054536; c=relaxed/simple;
	bh=UbmeASDkchIfwpXnKDa/WdgXq05VIW6kmkTfv1yNSyY=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=grinNRztdo4alshpOcz7qIu8zw4O4Bx6fHxo/2acPFIGG6OuHAEv6Ex7ZSb8ztjP6znyU55cZULVPcfESqyAxRiMrpV0cMKKOeVIPoNVTQlhAzLOv8rLiN6grmhvLBPD3QDeDTWjHHi4Lq5RFt8+WIZHQrMW6+xH1Ivl7BKHWbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=EIICawDe; arc=fail smtp.client-ip=40.107.22.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C5ko8FGKIYllZL2KiAmxTMukRJPJF1rKS/NY08QwheY3LToHE8L7Gud/e9p0KsBFq65rUk6psQLFcJByxqpiWokoeXIKzhPAdSw2gm99USmn6JSHR3+KCKoRQK70Wa1L/xrEJ9Moe5kF2Qmk8msMH6MGwuPtFBQQPpYoCI6TuFh9FOPoVMQgOTKme5p7A1uMx41cT0rs2tzCVflsqw9qbUR+XMzZxsdKJh3kX6DKXxGx3ez6s2OYpSDZd32yknHLnVaLijJKF7T1q6wpNohzwanv2+hIPZxW37XHpKXiRKlTYTO5Jkf7I1ekD0JFSJ4qjAbadqtP8TWIdHqF7SpydA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eAVzKQRBUzxXdyuxXMILtOp/Cc78HxdcM3EzeWRHNo8=;
 b=TW7m+h3Rw//AoKNtvX5aZ9z8KA+OLrYHZm8+HvhDdMfqnwbVnfL5oKerRaceoTL7qlcqfbe8/+jp0yI7CBDxcoLA3IxhnGCcbjV1SiWTtVJoJ9OEiIgnCaYcQM7PcyigB5jeHG6Tlh+Ms4emgrhw9A0H3r/wOWS+s3pAv8Z2mHBRtbs+/u7bz1GcPSestIf8t5oiFT7ZxzKYOzSBIMuhUiT9YZF2iTQHpmegM5q35V5zTvf9GxNRVDAF5yBERZ1IynatkezlR1WGmwXNWAFdAsABNrMk3m/drjRHRp7DeFtfTFepMXEBwl9uSIgl9NCPLbCAkcmKJo0GDM94IU/O4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eAVzKQRBUzxXdyuxXMILtOp/Cc78HxdcM3EzeWRHNo8=;
 b=EIICawDelrmBUGCR9+RKi8PjR0QtgSbeYSKbX6U3aIr6+avxeqv2+KGcRO6FnOsXxq3M1lrah2gLw5PQOGUTUlLc4sA2T/uFZL9RNX5aDu8iyoxFYc//uSX/whJAKMa+2ri01LCiN//o61hCzOnijUk7sySMI9fJ0UxCxQIvyYU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS5PR04MB9754.eurprd04.prod.outlook.com (2603:10a6:20b:654::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.27; Tue, 27 Feb
 2024 17:22:12 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Tue, 27 Feb 2024
 17:22:11 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 0/5] dmaengine: fsl-edma: add 8ulp support
Date: Tue, 27 Feb 2024 12:21:52 -0500
Message-Id: <20240227-8ulp_edma-v1-0-7fcfe1e265c2@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADAa3mUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDIyNzXYvSnIL41JTcRF1Do9RUIzMTixRzkyQloPqCotS0zAqwWdGxtbU
 AR/Ai81sAAAA=
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Peng Fan <peng.fan@nxp.com>
Cc: imx@lists.linux.dev, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>, Joy Zou <joy.zou@nxp.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709054529; l=1492;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=UbmeASDkchIfwpXnKDa/WdgXq05VIW6kmkTfv1yNSyY=;
 b=fAFNAPsiLcHhGjKoX9cWDAs5ibDlGQV6RWm7LS9ECzWJhrs3idY4F2K/9B0iRXJbK74Av/r/d
 DVghgm2vGc3D7rtE6+wXJYtvAU37p0Z8QeDVJO8N0/83r1dvWLJH5gT
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0059.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS5PR04MB9754:EE_
X-MS-Office365-Filtering-Correlation-Id: 57e8eee1-d929-4cac-68f2-08dc37b8a262
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7BKfbm2cPz18tHJ6THdMXr2+ePUaICImcYkIJQImC0DGbEuHV1MIG68sKo/E6nIy1CDddUFPyhtjpETTbV1RSTpx3enEdLaaGqxbY5xShUQuX8JwgcVqX8a8pLj/dEZx7sAkQqrKPq2NYGVucfaZMu9Gn7SZgzxUewrxQsFpXVFU6RIReUGlIOIA8c2+WZaF6+7irJqmL5vBVaigst6SHTujepgMzJwC3Rc4avU4CuE1mOA+MHO8SinfTDUjL+++GhpoObR6wv3Kz6c76j8ogFxNRThO7e97KLSNhTzsjSFIwW3tkA3NLH6u/Oup051R8BmmL2u2FrvmOWOOra6+4pjyVkaOwbtIDWKK0C8RWWFoakruqJ4Si11O2JO9R63oB3U9qCvaX2b4tcC2d/Gd27mUv+5Vtp2kjmcODu6uEP1pDk5KMoFynkhZi/+e7GwPh9ErWAaIFim3POmZuOxTOyRbSL34bz2cdDdUiL0gjXpgIsshUft/3PPY7/e/g9vtb6yX0TlzQof/uTn+jAbMyZuDfuw897XSf36fnRwEs9O+BcldzNITJDSYBjGCDD7R6anHvyGa/ifQDjjeaToud3w7xcfslMzggCgVTPBUxZcGNAzduaD72Rg49kDQCnaF/WXZylLfzO2k4y2/zDT8nkiT2vlkYkaAUfuAqg+tPFjHLY2yFwWIcagAZ0ygvlYC7eFGnpgral/I8F4+DJ8Kom1wwTbHIShdt6AiUrMR9UY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHlHTXlsTDdvR3RyUXpONmR5ZmdvUmpjMGJzMVVaQlFMVnBzL09mUjFlWWEy?=
 =?utf-8?B?bklRYTdwQ3F4WDZoL3JRays0eVk3VmNjcUYwQkVHSFZVZUVJeHNpN2I0UkNS?=
 =?utf-8?B?TVNaOG9sVkd3d2FYRS9maFEyZEVPcHIvOGNNd3g5b3lpTVF2YXJxNEM1dE1x?=
 =?utf-8?B?bGlOWmtsd2Q0K1JJNHUrUmc0RjFlQkhnV3Y1VytFZEVEWVh2eVdxYm1yYk1i?=
 =?utf-8?B?SENWWURZb3l1QW9rR0k0bVpFYzJCZW1DNjJwWDQybjdVNjdDRTFjdTgybUUy?=
 =?utf-8?B?WERhaWU0ODhNUi9ZaTduREQ1eDczWFVlZjFYUmZIK1BaMzB5OU5PV1ZCWjRS?=
 =?utf-8?B?dFRHQTVYVnFMZGZLaDVTcWRXdElxRDJlQXVnUmhtTUV5K1ZTbkxUeG9wc1ND?=
 =?utf-8?B?cDZHVWxyeFBzT1BHK3RuanlRYmJyVWZSVE0vbk1PY25lUS83UkRzTWhScFVS?=
 =?utf-8?B?NThaWExzVnZvd3c0eCtqYTgzT2lsNkdPdmNIeHV6WUdWa21VK1ZXa3E4TTV2?=
 =?utf-8?B?YkZYQ3FsVHJ0bWFqZFVsR3dyZ3JhSGJSbkRaMEcwMmFqejI3OXIwdGVSNnpn?=
 =?utf-8?B?N09QQk1KQzZSNm92WUNLcXZKb3FPaDhhOXN2ZW9DUjZRdDRweWppNllNeWVS?=
 =?utf-8?B?N3QwQnBBdDM3N0g5STh6Wm9JWXpHYmYrRTZ3K3ZyZU40eE40VWswTDR0M2Nw?=
 =?utf-8?B?cHR6ZXlCV0paaFgzQVZFUUVYZWt0aFFkTGQwSVJ0WFNjd3l4cG9VMmRic1lE?=
 =?utf-8?B?LytKWlJKOFJYREZ4TjY4d2FIdmxMbFluRnluTWp6YUZtNEZkbzJhQjVpemwr?=
 =?utf-8?B?VW1WMFBSV1VNSHhKbS9FTnpBUStzSW43TlFpc08xN3NTbnNkUTlSSTJpejdK?=
 =?utf-8?B?aGNML1h3M2U5cVI5RjlxM0tyeU41L2hRT2hjWGhzb1ZvakhxSkRiWFRQeWRI?=
 =?utf-8?B?NFllaFpXelZjVm02VWZ1cjNkSWl0U2JIRW9LckVRSVUyVGVQeFE0QzVuQmlE?=
 =?utf-8?B?QnZzRllpbnhBdEtLS1RyVDFrOTZlZzBiT1BDdnFkMjE1SDZjTHYzS1J4eUpM?=
 =?utf-8?B?blBTaEFWTW93MkdyYzRCcWdlS0lnZTJyRjhacmpudWdsQVV6UzRnVEx5WTdj?=
 =?utf-8?B?V3Y0cDIzZUVrQXdnd1BwdjFGczQ0cjIwY0UvTG12Q0FuUXhwS3RvUDhyYjYx?=
 =?utf-8?B?d1RyVnJMUFhYbC84MGUvNVJPL2FVTTJoVVlGalQ2VFVaay9IaGRKS2RhSSts?=
 =?utf-8?B?UlJ3Y3dtYVErVmdtSklYNHFxUzRXc2ZLZzBQUENBMUVneTYxZ1VBc2lIZUxI?=
 =?utf-8?B?S0dlYkNDOGRPM3JaOWlsWmNuUEhZQ0RrRzcrb09sOW5vSER3citIWi9Ocnlx?=
 =?utf-8?B?UktKRjZ6RlVFSXFySHNpUVRic2U4MkVUOXRmOXF4ckpXTlVxRytrYXhIQTkr?=
 =?utf-8?B?dnRaZ3lqc2NvZWY2bUhXcm5ucWFnTzFIM1pyOHV2NmpFRldkYi9zNEhPbTFy?=
 =?utf-8?B?ZmpyUEV1UVJKN00wbWI0QjF2YUZqckNpS05FamNsUnZlcWhSS0NuVCsrRXpo?=
 =?utf-8?B?VDVzdnZiSUpkdGljdkdsNDV0U0UwOUhjMmcyeDYzdXhtSW1XM00xZk9MZWhJ?=
 =?utf-8?B?ZEhkY29qZVNSRDVvQkhsL0JneW1vUE1UUm5zNjFoQTRwVWw0Q2hYQmx3TWEy?=
 =?utf-8?B?cnh5VmdINFgweVRhVzRLamtTdXpwUHFkS055bkVyMy9DeHVRVDVqVElxWERY?=
 =?utf-8?B?ZXlwdkpMRG43MTlyN0YvSDVIQVdmYUZOeWJHeDF1dWgzbU1mNXExWmcvc2xl?=
 =?utf-8?B?VXY2aGYwTVF6UmxIekk4V0x5bEpJcFpWR2lNOHZ5c0hOelk0WjFCM3JuWmVt?=
 =?utf-8?B?d1p6K2Z5eUxGQWhYS3RRUEVDOHFXdngwVkVYVzZMa1VzbHd6eWppelAxNmQ5?=
 =?utf-8?B?K1IwaXc0Y3JUUWF1QVZmZ2N5WVlxOS9UaE1uVHhuR2FLWG8zcU1saWJhZ01I?=
 =?utf-8?B?QXc3Um1rRzREMTZXUitkeGlXOTF5UjEycmdPTjd0YmljNmVTeFJSTWhqbmpq?=
 =?utf-8?B?bVB2am5vU1FLZTJkNTZ0cGRGMmdUbUI0U0RmK0NLZWNhME9kRUxGaEF1VGU4?=
 =?utf-8?Q?X3Vo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e8eee1-d929-4cac-68f2-08dc37b8a262
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 17:22:11.9014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 06N5PFCB8Ms7TJIKG/f83CGJmeDRTR658JlEYLtmYQUXyYQdfaL3d4QlRKeyJcpqpRmopmquNgwlDDDhDF8HLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9754

Do some small clean up.                                                    

0c562876972ee dmaengine: fsl-edma: remove 'slave_id' from fsl_edma_chan    
d9b66cb5fdf62 dmaengine: fsl-edma: add safety check for 'srcid'            
aae21b7528311 dmaengine: fsl-edma: clean up chclk and FSL_EDMA_DRV_HAS_CHCLK

Update binding doc.                                                        
23a1d1a6609fa dt-bindings: fsl-dma: fsl-edma: add fsl,imx8ulp-edma compatible string

Add 8ulp support.                                                          
dmaengine: fsl-edma: add i.MX8ULP edma support

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (3):
      dmaengine: fsl-edma: remove 'slave_id' from fsl_edma_chan
      dmaengine: fsl-edma: add safety check for 'srcid'
      dmaengine: fsl-edma: clean up chclk and FSL_EDMA_DRV_HAS_CHCLK

Joy Zou (2):
      dt-bindings: fsl-dma: fsl-edma: add fsl,imx8ulp-edma compatible string
      dmaengine: fsl-edma: add i.MX8ULP edma support

 .../devicetree/bindings/dma/fsl,edma.yaml          | 24 ++++++++++-
 drivers/dma/fsl-edma-common.c                      |  6 +++
 drivers/dma/fsl-edma-common.h                      |  2 -
 drivers/dma/fsl-edma-main.c                        | 47 ++++++++++++++++------
 4 files changed, 62 insertions(+), 17 deletions(-)
---
base-commit: 2d5c7b7eb345249cb34d42cbc2b97b4c57ea944e
change-id: 20240227-8ulp_edma-12ee2648d74b

Best regards,
-- 
Frank Li <Frank.Li@nxp.com>


