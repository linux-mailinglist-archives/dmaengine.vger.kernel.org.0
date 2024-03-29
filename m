Return-Path: <dmaengine+bounces-1661-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF75B891FEF
	for <lists+dmaengine@lfdr.de>; Fri, 29 Mar 2024 16:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84657289728
	for <lists+dmaengine@lfdr.de>; Fri, 29 Mar 2024 15:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D980B1494C8;
	Fri, 29 Mar 2024 14:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oAg9knPI"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2099.outbound.protection.outlook.com [40.107.8.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9351494B5;
	Fri, 29 Mar 2024 14:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711722931; cv=fail; b=dzSSYiieLrm+vwDfNP/9cgl8MJVdOSgPyLhBpLKhw93KbPXCxcjtkv0wKZC7LRzdTj+rHInunMKo4VbYLFfAklHM4f2Y/0cn9Gwz0TwmY2H6bQruB806yScoWR3oGoBtMLBuwtHUzNBZwDwoI77kI2mh+tF9u26V7WyxRe4kG/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711722931; c=relaxed/simple;
	bh=w3/LnRmOby3DOaAX14fhu0J2aAP8MxFdhxfkIy4OS0k=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=IoJbsxLbpLG2pJrq0Lrw6mTen94WixuADRNEIxwiZ+8Hb2QOAyuWc9KfdhJFp+svClS/olryMsXEwqSQ6K96PKSCv7OITd6r6PXcFyWBRTL8XAKcK0bWZLMJgC2lFEo9DaNXJ+FWyXZf5s4c/K1qpvux4xV5x5kH/8pcfgykkLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=oAg9knPI; arc=fail smtp.client-ip=40.107.8.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNGEkThWcG0p3qc5GctW2H10lrtAdBlXNMvA037dOG4YnuOApns0FVs7j/Yne3HxOaocvIk6FBYwA9gzUKl3izc6OV+pLnOxr9TepmGZJach8RiPEQOzJV23fupIRzuaVFKPObQ3Zw6vvUAX+bLE4Wos9pfjBfjdN6PqVLIwYnHQJQyL1bPHzBrSdhKAYUKGyXv1rfDpFx7ofJ7Jzr8/jAE6lP97C2ujbbnApapgagH+A1FHRFbwX+ewVJ1dLK9h/XlT4gmJKOX+Iu0kCzwIfG0PQylDFXk4eoYx+aODS9ddR23vK4qOE7QYL6yB5i3PCjDmmeTLYdo4RXW2UAZ2Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sOqlssOfhHPLSNxPWLykgfHC201TbPMyJDi1TZaFm7I=;
 b=NEZdDrx5DQ1C45mnfNRy0Wb3pwhTYlnXFbqniw4KivChzrxKjJ5OqRDGjOPKnZfvNNAalAhv4pOt+bAieFibPslZCt5gb3wdrnF4pef6vrjzcyHi2RelrQzmuQ81FtLdQ3a7fBZOVXwZYkZJnTiTfcLvygTGRqf0BHThECKeyA5bje/cpE1gL7s4I0+zm/nA92Ax3iQK5dGG56Xj+qBKM9PUHWHJu0Y3wrcP2shGM/pme7PSg/KsPyOGQ7WQT5pXxg712dOAkGgrxzQACo3DTBZb+faXqvhFJb39WOxt0PE3u/qqHmAW2alBlhZN8e4CxvfpUj1qGQgeCYrsUBb1UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sOqlssOfhHPLSNxPWLykgfHC201TbPMyJDi1TZaFm7I=;
 b=oAg9knPIdbXt9jpBCA9y+pd7Fy0W9uC21mXAO1P+sVIZMSjAIVA/RiDRKzslCvnowwToIR7ZYExDcb/QmThecNmu7a1JgB33Jl9W+mnIA28EbUPvv1NTrh9YM4rqa6HsPRyvmvo00ICkgStn2geNCD43ji774qIaZWrZVEldmzI=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM0PR04MB6897.eurprd04.prod.outlook.com (2603:10a6:208:184::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Fri, 29 Mar
 2024 14:35:27 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.039; Fri, 29 Mar 2024
 14:35:27 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 29 Mar 2024 10:34:44 -0400
Subject: [PATCH v4 4/5] dt-bindings: fsl-imx-sdma: Add I2C peripheral types
 ID
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240329-sdma_upstream-v4-4-daeb3067dea7@nxp.com>
References: <20240329-sdma_upstream-v4-0-daeb3067dea7@nxp.com>
In-Reply-To: <20240329-sdma_upstream-v4-0-daeb3067dea7@nxp.com>
To: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joy Zou <joy.zou@nxp.com>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711722904; l=778;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=w3/LnRmOby3DOaAX14fhu0J2aAP8MxFdhxfkIy4OS0k=;
 b=WRAmUvA5azocOYneepgzi5q+NuFA6H/EsMNNctRWBy9lT92rpqdKc1iYzd9XIEdmJ9UmP+LK7
 s4fUuedNPwpAWiFfSBIY54X3o2O9w6DgpIEwP/DEgxJAsEE13lTfIMB
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0153.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::8) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM0PR04MB6897:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aS4lFSxbTXkTvIGhKawgsh1u1heO6ATuEdSxmi0+ZGGEkZB2qllq6s5+aBw0EBvWe6mfk0CjOGGHuqQi/t7DogqnZ9+yCS8W6RNmBg+mjS1iIRBEUfkXs7dW87nx8De5zahnQeD2YNEkLZ6e69PF/9wxcqAfXsgPQ2l+b5WijNp3rMjKz8bR8Xs5h11ZSlShGzQwK5mTbwlqz6Dj2mtSWiudUgOw46nklE3qOJZJRcugLlTfS43LbM6+Weo2pIeB+nevXi3wOHHVovCc3U6nVpJybYBnqvyE3gZTpfij6aq6TLemgbTvEhpC1XQ3CISeJg0iYCLw+ijQF28l3aCti+BfQASjGiKjO3te0XPyDyQHmKlxK2+DLRvGna5i0hobA26WNw+ZH6SUVp0XM7VETGPXkBftGVZJusNcswepQJ3776wZpq6Jyh+S2T70K166hy2fWkZ3EsO3/JHlHoRS0Gk/qK/edjTAqSIbuZv9DaUF7kfhsQ7q517c47lmwqy7ThZRiIFdFRM9hSXReCnFjIOL6GlqXBo7PRQQy70lv4vOK9SLDFKo3He7BlyzGhq1ZSJz+95erutoKd5EcnuLRnYSFgeDaQRrN2jxNcCvj6VAKWAniaQGoCui029sqe7AHvENBq7TlARhpNH50wvnQ/CcQJRc+svWNLhA2e8bfJWhd6MQpgms8HLLUh58vSyNRtZ9zOZNF5rHLQp9lv2ck2kIfRD7ed4jxND2isHwXeA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(52116005)(376005)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TmVvMWZhaEtRQUc2RXh1TG9sMWd0b2g5VitORTkvenNSdjh1MXdpSlpDTnVx?=
 =?utf-8?B?ejR0MEFPZ3VWTHZ4Ny85NWhPUzFUSHFJOGhLSEtnWnU5dGJpTmg0SWJXelRZ?=
 =?utf-8?B?K1d0Q0dhcUNaYnlOM0hOQnh6Z1E2TXMrU0cyTVgyZDc0cExwQ09MemdTZjR5?=
 =?utf-8?B?KytYbll1UEg5WVMwMzlZdHhLK2ZjZElCV0JlcEUvNVAvVDNiRGpwN0tFbVFQ?=
 =?utf-8?B?MVp2ZjF4eGdlTU5zRTlHcjBsOTRMS3kzS05iZVVsYnZnREtwUlhqNEh3dDVo?=
 =?utf-8?B?MXlZZXI4MEpxMWNaSDJqNDhLc0R3VkhIcnU2ZzJlSUxVdzFvTk5YNkVZTnVD?=
 =?utf-8?B?N3V6MXUxSFJLZjNubVNVU2I1WmovSS9Eam5HTU5vcXY4SzlZS0JaRTNPR21p?=
 =?utf-8?B?a1crZzhGaSs1VkdTTm9FTFRFVzB6eTVRcXpIbzZUdFNzOG01eUl4Y20yU3l5?=
 =?utf-8?B?LzNPTlNFQ25rSGRmWVlNbEpaa0pJVmg5c3N2UUhZdmlWSWtlZ1FKbWZHNDFp?=
 =?utf-8?B?d2NVZi9XeVVsL2hwelZBWC9GRjM0R2ZOcHNHbDBNLzBaeVR1cTJRUlBHSUtD?=
 =?utf-8?B?STRMcDJDb1E0WGhaN2NRc3RVUklKQ3dhdE9zWXcxbXpqY3J2OGYrSW1iL0lF?=
 =?utf-8?B?NWlEUVZoZ2RxQm9pM29XSlAwRzRtMVJRNHV6Z1I3VzI5ajEvMmRxV3pKd094?=
 =?utf-8?B?N2kxN3lqbFRCUGtNMExueDlzTkZrZVdsOVF4RjNTdVRId1FKTFgwemJuSmxE?=
 =?utf-8?B?MG95dy9QbG5sQVFSR3A3b3Q0OUlwTzhjSnlvY3ovazN3bVB0TXhvNkdKRkI1?=
 =?utf-8?B?dkhWZEp5MnR2T2Z6TFlTbDg4UDRrS0VmYUMxNU5VWnlWUHlpYVlNK05kVVkw?=
 =?utf-8?B?ZnpDZGNvVm5EbmlJajQ3WDdGcmlibEZjb045dGZCUWEwZG1YekxpSk5zSTRV?=
 =?utf-8?B?RjE2WGlRbzA5V3B1OWdPZmh1c21PQkhwV2RGcHg3ZGc5ZTdYTFJ2UzVzQ3Za?=
 =?utf-8?B?amlBTk9pZnRKK29EcFY1UXprUW1iOUdHM25abU0wZUpLOGt6NVVUSzVObXd0?=
 =?utf-8?B?THcvVkFrUVFZRVphQzdEWWRud2J1a0ZPT01IK1l0UEVZY1pqS1NTRjhIdExM?=
 =?utf-8?B?bE9FcEFCWlYrRHMrb09CSGV2eXhHekwxVm9SVTRVU2FXWlZ3OCtTR1JkZXpK?=
 =?utf-8?B?V3pZbW9RbW1Kc0F1aWVMKzRDbkxrekg5Yk5CY2VQRHJtRjlzWEtITHUzUFRD?=
 =?utf-8?B?a3NFUFJEdklpUG4yQWlhMnowdlVsZkV0WGpTOG9jbmUyd3N0ZWtwcnNhUkJs?=
 =?utf-8?B?ZEp3V1QxS01YK0VkM0FuMkd4RHR0OUhPWTdDM2tyUEtMTVorb25DejR1ZHhy?=
 =?utf-8?B?WGVoMFR2M0RCamNudC9Wb0FObHV0dGNZWWJKbHZ5N1JQcVpGTmlMblpja1pW?=
 =?utf-8?B?WDRDZU5teEJ4T0NYZ253dTJkdGJTMmh3bjNIQkpXTFJoekk5Z1hOMldhSDVy?=
 =?utf-8?B?L1kwbnBzWlZ0VlBDNzJBU0VqbkxnVFpkbHNacCtEV2ZxeDRoZHhPQW41NVg0?=
 =?utf-8?B?MVpOMjdxa1gwbkF6TDFRQkxRNWxNU3ZBK0tmQ2pQaG0zRFhUemxMRC9zVGRE?=
 =?utf-8?B?V2YweEJoQ3VaVTlyYWxsTEtkemd4UjNCRGMxRXRDT3BuNS8waTUrMU1yUm1y?=
 =?utf-8?B?SUhUQ29JYlh4ZUZBR0RGck10VDdpLy9wMm1zNDlFM0NRbnhVQjZFWWMvYk5M?=
 =?utf-8?B?aEc0UDM5YmhtTWNhRElaazFieGEyaG1DQzNxZnB0eFRXcTU4REN6M05PRW5N?=
 =?utf-8?B?U0VEbjdQK0VWa2FPa01NazNjSFNVUks3TytIT2dKVkFTNHYzTWo0NCtUZFVJ?=
 =?utf-8?B?QjEwQ1QrZFN0ZFhHbU1oS0NxbjUvQW03N1pDQjhTbUV6eEJHYTJrNzdzZWZ4?=
 =?utf-8?B?VU5nZ25uM1lOYUJ5OGg4dWdveGxpRlZNb0tpWExWRlYzcUVmODlYWEE4RXRl?=
 =?utf-8?B?cFRhSWVyV0hCSzU3L2UvWktrRVlCdThkL0YyS3YrVytLNzlVM2VxT1J0ekEx?=
 =?utf-8?B?bHhobUNBNFNyVFJzOFl6bFh4NTBya3ZUUmYzeGY5MzlSL2xCWnhwaVNiY1Ur?=
 =?utf-8?Q?7cOklzS6pLE3Cl9ZYpmUj4INF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6453ddc-ec16-42ed-572f-08dc4ffd79d3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 14:35:26.9777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wrq9Rw+ITqunAQ6owL8TYZZm81DiwvAk/JZTSC+EA6AGCtub9xDygZOCubbhcl42ElvkZTtWckMV8xkfUkHOPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6897

Add peripheral types ID 26 for I2C because sdma firmware (sdma-6q: v3.6,
sdma-7d: v4.6) support I2C DMA transfer.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml b/Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml
index b95dd8db5a30a..80bcd3a6ecaf3 100644
--- a/Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml
+++ b/Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml
@@ -93,6 +93,7 @@ properties:
           - Shared ASRC: 23
           - SAI: 24
           - HDMI Audio: 25
+          - I2C: 26
 
        The third cell: transfer priority ID
          enum:

-- 
2.34.1


