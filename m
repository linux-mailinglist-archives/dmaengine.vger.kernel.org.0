Return-Path: <dmaengine+bounces-1544-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A1B88D5D7
	for <lists+dmaengine@lfdr.de>; Wed, 27 Mar 2024 06:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07949B21D01
	for <lists+dmaengine@lfdr.de>; Wed, 27 Mar 2024 05:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE8911CAF;
	Wed, 27 Mar 2024 05:26:44 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2096.outbound.protection.partner.outlook.cn [139.219.17.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5B53DAC14;
	Wed, 27 Mar 2024 05:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711517204; cv=fail; b=n95OnhnNsJQjij7RxboxLqTwXNDAcR/0/IVQh/A8j780WKCkPLWfX5XKr50NzoSk2EiMWuY8pfA6GVtgNpGWQiDLBNdUXEpejjyOJPVtDvmoHhsLL7fS75EiliS/ge2zHsPluBnpLv2+0UJ+Q63Hu21pcKBOyzG0vfh48zJ9Cfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711517204; c=relaxed/simple;
	bh=4EfzZ+J3LtUadzufIba+d9vEgSQTSbnen8UI4pvu0qk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jakhfCj07wiKUUhHov/TkLg89jUDDksoPM8O1SCN4q1mKQNx8tK2opGnzOsmL+1XY8KLdHw8KRfotoL1jpMiS3LT1QLmslgGxJng271UblwVMj7q4Rql/+OTbE5z3rx8+ZpsYjxZcHD7NWcHTspzViY0I9WlTDWPIfh8pMPGNRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0DBr66auWS8Yk+OexvKKwvfix2LDbtcmLuZSyFGTuyhdYRcm+X84B3aELyC8DIE7NkmgLEpq1ztFabbraFiRElD1oBa3w8F4V6sTiQmzvxY519nDSTYu4nT/HufhM6G1p7/B1qaGjQZwYRBVol/vb0yALEk2Y9YX1obdbmHotS+gFSldYdgW0IgnodU8DNjcBIqj2sTrnB1EK30cot370MO/hqJRsJUqwnGBIbYOUPSlPCo7EOAOi9DU8lrWJu6NzaLv9Ek54tH/COiGBxGw85LaK5Gopq0S6Sq0JoRooD51v5yrWHshbkGjKuM9lsLaMEmq+j3KFbI1OvT/pMYnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EGFwBRqR0Ubnr6Qww0efT6ERK3Tj0upKezJN+tJoDus=;
 b=kg8ix1cWs3dakmnvvFeVSFINY6Px0rCCAqaCETudnzXK0ZrsOFvKMEqxxrNrIHmpj/WfVurk1yhNqviCj+MYMlzmy63teeIz/NShoim+SNKY72FCS1veqdbNCVYzLHaSLVrXBUjNVcauyNcscYdKkad8otu2iOqKp0hBWQ89DP+152w1NgEEArAHIEmYH2bz1onGYAe03x7p0BpVUceccB/Lz25utbKZpB48FStMMm+xCe7x77n4tvoWbrp6Iifh2Y3Q63a4DMUB9UePzp8mv3oLtSnDop+MDmBts4+LVs/1E2Fl4vLT+vRTUPmd7hbJHfa4ATJM/M5PHSb7GJaOzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:e::20) by BJSPR01MB0547.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Wed, 27 Mar
 2024 02:51:44 +0000
Received: from BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
 ([fe80::d0cf:5e2e:fd40:4aef]) by
 BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn ([fe80::d0cf:5e2e:fd40:4aef%4])
 with mapi id 15.20.7409.031; Wed, 27 Mar 2024 02:51:44 +0000
From: Tan Chun Hau <chunhau.tan@starfivetech.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	Jee Heng Sia <jeeheng.sia@starfivetech.com>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] dmaengine: dw-axi-dmac: Add support for StarFive JH8100 DMA
Date: Tue, 26 Mar 2024 19:51:26 -0700
Message-Id: <20240327025126.229475-3-chunhau.tan@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240327025126.229475-1-chunhau.tan@starfivetech.com>
References: <20240327025126.229475-1-chunhau.tan@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0025.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::7) To BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:e::20)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJSPR01MB0595:EE_|BJSPR01MB0547:EE_
X-MS-Office365-Filtering-Correlation-Id: 0447202d-c34c-42a1-0e94-08dc4e08d646
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GYNl5/SHBiKMF2CkcFon/t8JSAj/1fP/YsDXj9bXkyckl0lC+ImBYSLj4ZzrdoqU5PktEsOgfBd5+cSvcm9bBDTZXqpenEXb9l/vDITcoB7u4LH0flrJHkwtNgcq7hkvAP71ankCJ5Smo/sj+rvq/afie1Cce1VDts+phqx1us+is5VCwi8G3TbXtz1BZ1m6EXdpND2tAMxHPxPcBu/+j5ZuvGO7fqy3PsWXhZwCPb99ozi9t7jdu40SSYRd2kFxDeyhh/i0NDhTO+wqaY+hzxaUZxyrB/kPAXTBCKTjuoP/PZt8Dz4Nz0xTWnRPJGGg92enJ1VsV1zl0dihv6VaEebcH3ODOaWyIJlqkn3vwHqf12P4aRERjwx9cA/B8Gy1TGyywk7iIaEmDtOThOsrWWy4l5tjH2Q/qbXEYdGjw9iGf+RZZYKAGFcLYm+J+JIaurNpycTdfxhcySr8GT7QuSXkq6YhHnMq8M1M0JN6jskKSpLBnStBqJ/2xSFr2r+cB2kSrUjoNOzJVOYiEOwExbKPfba1M3yjIZDCROW5s+xjsYmyj19sxaBKpCwCs+qOvQw9/pF1Z11+njez9OCCd5pvT2CHDHt6KOiwYcFpwSpkbhes3pgvNen2wSG+1Trk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(41320700004)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WsDfCM6dnmYqbzNdOmj4wgKeU1jzrLlvkmSxYieubIlskfdDkKNm256hcW+9?=
 =?us-ascii?Q?qb6C3nedyjJnWlaaFf2E/n6q4k2iMcIEkEMRc3iO71jPP8P/cgbCpzjJlmXB?=
 =?us-ascii?Q?h2AGAnkm6mCSFVa3lk1j6skKgJQ0dVBu+L1Cn+tC+HlJk4RVRkU4EwjW8fv7?=
 =?us-ascii?Q?khTMFwP5eCwWZLkYbixAPV5KpfYPwQcZPxPLBAvIjQlOvxVQgZu4ckZbRllA?=
 =?us-ascii?Q?5oSOQffGRl59ryN6ljjZ18t8QEU95oXDL04s4KXG0UuMPCPbfmJFpmzOxLXl?=
 =?us-ascii?Q?lMIuBikO0cXuHJzdynxEO4P4lT0USXjaOyKJdYUgR3aWCsAzjYvRlD4uMarj?=
 =?us-ascii?Q?cecO/N9EklcE9mcuNQ4mt8rBb0rnDtw4Bvb2ogTLWQIT2O1lMfr1wqBH3AfB?=
 =?us-ascii?Q?4FENRBFgfckzPIyECAUrtzwH2lJSIDd97WbcIR5QcvUragDwoNEsE0KNSoUX?=
 =?us-ascii?Q?63YOfja2+EGBMRgcx3kPtMAlLB8e6Tsm25ItFkOGYKlzzwoBdEKhTuqhTs/z?=
 =?us-ascii?Q?aEu9ie4TiZFY86Iz/+zwcbk8o1pDfSGGn1ztJmJMwKZnMsn1ge4OJF6mxJWs?=
 =?us-ascii?Q?BFOZbZaXNn/bsvki6PZS6O3u7U1n893LDWitYhtlTLxqnpfiN0VLp168FsQj?=
 =?us-ascii?Q?n+o+G/viXOKrz5xUPAvNhdcVr/J2ZnH8q+4uc2WP90j0cli2dxbp+52FOFSs?=
 =?us-ascii?Q?2JMrD0GkELqEj2rXErIuMUd+cLoXvEhQ+nTJeGrC1Jow7h8Ymyms3GGJBkAo?=
 =?us-ascii?Q?ePojCO6DGgwy26JHkVwzJ27KOO/V5jm3N2S0JEaxNGPeEfKrs5mZ8+UKyqoY?=
 =?us-ascii?Q?lqXvipCRKkO5oqGGqhwSBvkcHsjtV+TukwS1ECeYkpE+meeu72NpBH1HREMD?=
 =?us-ascii?Q?U8qFXroZwqhugScGl1Pt5x6ypNHa8qk81P+S+8QXb0LrEsjHckTAfEu3+RUl?=
 =?us-ascii?Q?vUwUrREU2J+2Ldk8aeddu8xJnT27u/IUIbMkOERtVhdF/kVG2KZBz2R9W9Tl?=
 =?us-ascii?Q?Q/LiLqnw9iWaUGr9rABGTPN31XQ2zvJ/lNM6bQ1kr9dzjJDptq6alOExRNTW?=
 =?us-ascii?Q?W1wJI9a4UC9pvK5HhH5XgEmJiLIxBXZIxfX6faDKkAXH2iwuZBtumUp0GKrV?=
 =?us-ascii?Q?+a6A5ty0Egcf1ifaNIEQgRKdkNy1O6iOrs6FH7fA8+DljMFMXA3T4mfAcvp5?=
 =?us-ascii?Q?q3/drMu/gRmAJafkGfgkFpPBCztUEVfKqlGhImC/TQdlciTc6ugjsxJ7ayEN?=
 =?us-ascii?Q?/YVeVP/v/gdT3hRqsz2dHfRWPT76p4ev21cj4/292app3B+tcH97ZaLbtdko?=
 =?us-ascii?Q?U/AKQlkzswFaCBVDMyjRHoPLjcaWifdYr6KDoNwb1VG/Th3M47KBYKSn0MQV?=
 =?us-ascii?Q?50rvRDoaXNpGTygKEQont00yvajZRhwEl7G3Fomyg1AnjzfbFW22ZNG7StN7?=
 =?us-ascii?Q?AojTCq6O9i9SS/YwuzxyxkMho4UvG5SWcZF/rblXsi5vyjv/q+6iZ6547gVs?=
 =?us-ascii?Q?Ccns08eoDPvVAzg0B5MxgSbB+qBbbx1JvHafAY4VrdBVOM8gMLPbzYB7Dql7?=
 =?us-ascii?Q?42CUmNV0uDIOTG3NvcBdALR/DrchcDpl5ybTWY+79tBcX2PGSclcZpzZ7/t6?=
 =?us-ascii?Q?ow=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0447202d-c34c-42a1-0e94-08dc4e08d646
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 02:51:44.3773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yO9xjQN/EehhluFKYgQUU6Jrlagr38ESUJfpRqgfcfpcxiCyxJpg+DD4oP+w0jye0oY7qNCPNB8TQfBTerC2i7nMnzRS4yX7yCFAPnCCUhk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJSPR01MB0547

JH8100 requires reset operation only in device probe.

Signed-off-by: Tan Chun Hau <chunhau.tan@starfivetech.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index a86a81ff0caa..abb3523ba8ab 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1653,6 +1653,9 @@ static const struct of_device_id dw_dma_of_id_table[] = {
 	}, {
 		.compatible = "starfive,jh7110-axi-dma",
 		.data = (void *)(AXI_DMA_FLAG_HAS_RESETS | AXI_DMA_FLAG_USE_CFG2),
+	}, {
+		.compatible = "starfive,jh8100-axi-dma",
+		.data = (void *)AXI_DMA_FLAG_HAS_RESETS,
 	},
 	{}
 };
-- 
2.25.1


