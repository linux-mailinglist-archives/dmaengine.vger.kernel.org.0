Return-Path: <dmaengine+bounces-6803-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5E6BD10E6
	for <lists+dmaengine@lfdr.de>; Mon, 13 Oct 2025 03:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77EB23B60FB
	for <lists+dmaengine@lfdr.de>; Mon, 13 Oct 2025 01:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC4720E6F3;
	Mon, 13 Oct 2025 01:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="kN81OAYT"
X-Original-To: dmaengine@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011016.outbound.protection.outlook.com [52.101.52.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A2E1FFC7B;
	Mon, 13 Oct 2025 01:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760317633; cv=fail; b=Uf6gavo73W8Gm3OvE2KnDkYH3iL1H2xCnc6N3D8JupYqrUO/VK0kVsQ6ZMhDHyerIYVo3FgQ+7wff5Ew/t9nJ5LHkgJTe/RZkWCYsfp21ZA8E9LN0zdCn6ge6CdleFK6VkqR/bovzaYu9PwK2VzRey+EkRlYcSK0UW307dFibuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760317633; c=relaxed/simple;
	bh=KQB3hVcmg8aIhOTUPefl5/heRuBxNHSnaLX7gxmotSs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ovo6k5gvcYQuidhgwR0QqUyVbph4pvyG8XXcM/w7ZJqzo1rCHjen1zyAJWmdgiZhWX0ddGz8JX3VjfgsBdIvDlI2CO3HY1aHPDUOWCQMygdx3RqKrgN/Ke40n6Fnwh5LprK3jb732cds+BcV+YKa7OYR4q7NBbxkswwAq2E8w14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=kN81OAYT; arc=fail smtp.client-ip=52.101.52.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YannNNTSB5i6hy/+vSfrOx8+YtdeMrGoFv/TLbXCFetdF2BUijJ6l+OPMLo7Y4Ro2P05wT/b/27mYbMKkCvVzLvRuXzR3vD3ec6dpwmoaDTjDw6sLYsD4TXWjQ4HgfxVDk4jImkptao0kkuTqof96FUNk81UDLkIibTayUPVuU7tCxbv7p5oI043I4TT1UXC0JYvS201dwG6C4j9Otjl7WmUnArW2gpBVc1nzJ3autGHPS6Q8c1p5mfrocPEPIpBFhGsPKpkuyVxCbjzDx9OSbEimcaBTipFQ9HK1iiGzJ10rMZgZ26MFjldpQvkC7iahADgggN0/x0KnO2LXfud7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0gIfgTeJmxPJe8A9wPo797kjbEF+8lc7Tarp6ZgDNyE=;
 b=YLMZlqFCYcyZ2LQeks0i7Mlc+txziRvTsq889FJtLFq7D8jmKdsB/esBb+eCTp2Djjk2WviTUlhzWX0B+gCzUQT/RK9lbgnOr4rnAhvsDBOhCdvl6XAXW3UaE1kt6Hy4LHvZur84BWJoGPctMq2iphf+fXp3B3MNTPPkMMF3cEYa6R8eoyijIeDLzz1rtbDEfYgMwgVCk8GiBdxbTsQDFN7+M0Ohq9TW9rDcLDb7zwWwRNNW40feIUTH7L3/9DQkcbslXx1nn2N47GK7ZEq8bpXyr7PtQjiU+doPkGdTCTszc2XyA56Yamtcdp0+NpRGmFZW0j7GNDCnGTWrPDjEHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gIfgTeJmxPJe8A9wPo797kjbEF+8lc7Tarp6ZgDNyE=;
 b=kN81OAYTOFlo3CHNrW22N7FmdKlcrZNpSuPMGYG3pMPoGL+3RG+Eo3E/TFi4zHIYatMsIqY/HJHxRahaZEFwOXoM/AJjQe1VZIIdZxwUjotDxZW9M7uQBQNtg7Au5DdpSoz19g6gXD6JBfJnKsZAdWWLSF+Lc2+u+9EM/H5glelGMcXXxDWDDEF47077ThnbvcmFGSVrcZ9WzoQLo/WeZLds9lJv1tuftRsPZQ7NAC6BNTnacDLIrvNkUTkl+Pl/K6+/XNMTcQ0wU2TBiPVkFed1RX8eOLT9BcSt0qK5eKpVp2aiFXHxxoBUoiwC78lSS4Hb/9Gnj5mtgK4pyUgbBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by SA2PR03MB5946.namprd03.prod.outlook.com (2603:10b6:806:111::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 01:07:09 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 01:07:09 +0000
From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	dmaengine@vger.kernel.org (open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Niravkumar L Rabara <niravkumar.l.rabara@intel.com>,
	linux-mtd@lists.infradead.org (open list:CADENCE NAND DRIVER),
	Dinh Nguyen <dinguyen@kernel.org>,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>,
	Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
Subject: [PATCH 1/3] dt-bindings: mtd: cdns,hp-nfc: Add iommu property
Date: Mon, 13 Oct 2025 09:06:53 +0800
Message-Id: <7a11eee56abb2cd59df7ab337204d24665539269.1760316996.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1760316996.git.khairul.anuar.romli@altera.com>
References: <cover.1760316996.git.khairul.anuar.romli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0027.namprd10.prod.outlook.com
 (2603:10b6:a03:255::32) To MN2PR03MB4927.namprd03.prod.outlook.com
 (2603:10b6:208:1a8::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR03MB4927:EE_|SA2PR03MB5946:EE_
X-MS-Office365-Filtering-Correlation-Id: 037b1e76-fe34-45ab-4525-08de09f4d5a5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bVL8LvJXyF2h5BKf3tx4scrSNq/SrokWEqmf9iCKC4V7gMhUCOaGCau2ye5Y?=
 =?us-ascii?Q?ohO2wd0ONe06gvpi4oEHSewXwEkKM8bLyD/Or0pjMz64U/pcOmqTrGXt53zV?=
 =?us-ascii?Q?W8V1VTP5wOcG6KHASpKi82xx2V/wOR2N5jND6i3yTuP1JKFdad6p7Ma5mjHr?=
 =?us-ascii?Q?Xd1QOL3s44nMPkLkmCLCLf8Po09lJF3gxFLhCwu84xXdmD6oupA33VP27d30?=
 =?us-ascii?Q?H8xQGxEK1iAToqFRH81OMUPUm35mNTYxK7/d5jAQY8iCwICbidIn3/TXYlja?=
 =?us-ascii?Q?54meDdY03UA74qWUmPY1dnXzX3UVHgAuM+PMLzTLMaNF4BP6UV2wU80ESjbX?=
 =?us-ascii?Q?nBr3AZ1NKt14aDil2SLhfHjU9RKb6AOdBWOVzyZTi+5LwkFAXXQ/Fbam8N0B?=
 =?us-ascii?Q?uVHBpjC60I7Ov8+iXbDQYsSgIORmUKiLOnS3KbILGbHW4bm56D3IJ8ubOMS0?=
 =?us-ascii?Q?ycZQQPr8wLx7kYIhzDU4JfY54n9RdSPz90ZW76T+vc2i1WaLxDvPCUT/yzDf?=
 =?us-ascii?Q?fg+yBsNfc6eDp0gZpJlsCrj913WwCNMyIrahEJUqlJe5HLV2xGavijLTik0F?=
 =?us-ascii?Q?A04u+nw7hdVWapl7vnc3CFr8l9hd90J5HmOT7T4lembOLtaIClrz3qo/WdGf?=
 =?us-ascii?Q?VpoYd8X04K3/jMfEo+d8plppIrBpDfkNRBOpgcq7QmVqCXB2nWqpPVhNwurG?=
 =?us-ascii?Q?Q0A9BTzFaSXk+FUsM06ggD+bnbe3zrCQ7swpMfpHSW4TVpUgKQ22ErB0UVoM?=
 =?us-ascii?Q?N+iGxsvMG/uFTx+0HLgUJdktJRbvrnbFB2tdEJ6XG59VgDXZUGQD+Mhiz2rm?=
 =?us-ascii?Q?eloKKpel/JOiEcLyDhDBYNgwjdtGOyZMs2b8Hvxy0L1Pql1KD8xCJDMxpGVq?=
 =?us-ascii?Q?HDN+dHONvBUjlYxkHnJD9eYqHn8AmhOGmj0aHVCJqeWWzxo2ZHDS9C4RLlp+?=
 =?us-ascii?Q?fxh6R6/sVdo1DP49vbgs1IxrWqYRmZhOFYO18iMXQpyCMi0eK+JJUhMVSEKN?=
 =?us-ascii?Q?fyuEwOtIetx7WykqnqD95iMx69EQXFhtzcexrsdvO3DULSPGhBiDCmcoL1s9?=
 =?us-ascii?Q?HVlP/5I3Hts9sDAXZjIh43RyPbWfUE5D8qgJLsQyu0nU1j/NH+dI+oA49Ikh?=
 =?us-ascii?Q?BJI4cX2sHCOOXD23DD/PpXhVU61sz/llZ1fbX+07kN7RHUEkJEHiWd4WlpNm?=
 =?us-ascii?Q?r16kN8I+DaQpGDzndKtAX0/ozzgcSOl3NFLjbxKJFUouhHWxot+Pe5QWFDa4?=
 =?us-ascii?Q?BciiK2isLTroVOZNyNcCRPdvvY98S2ZzGXifQmJkkMHEzVmaVJCjgUtJ9F5Q?=
 =?us-ascii?Q?azMr0dHGf18X2SlD0AomW6bjjSbbOO+A9trWzr58hkJsrI9qKa9VDa648pGq?=
 =?us-ascii?Q?wnMsQ90rYeggWZV2SPmbgg7UsHP9J1OQisrxpxFVeEYfhFxgUap1T8OuOw3G?=
 =?us-ascii?Q?pAjQfJab47i3E3HUZF9bdJel4sbIAFKKNmhSjrewkLeKWoymnTIKAE10ynXq?=
 =?us-ascii?Q?gUzQz1kNxiLth2E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yyx/HkQ+PiECbzAjovoVhf+0Ek9qQKUZs8MK9vLcv6SH8jHQVeLapXa0RlIh?=
 =?us-ascii?Q?LrUwiVWJn/Gmk01JB12xsvUzNiUKXJC4sAbbpeMUaW51DSZc1hbxQS8ojiVB?=
 =?us-ascii?Q?4GONqR8tfOjs+U4AVGob43jGIA3M32yWs6fdcpvBcrmG0iL1LzMsQGPCnLgv?=
 =?us-ascii?Q?nuPd/ID9UKm/wXB8Q+yVirbAwhr6YLje0oBEdVfPCckfwHwmSQUrw+v3AtWE?=
 =?us-ascii?Q?gsRcpDdq7gDcVAa2cPv23O5KIaLMx8/Kgj6qPGMzTTOx8lLTKheIyvRv0I2N?=
 =?us-ascii?Q?vo3JtXIYUg0SxSuyCRfPsE8xDSodtizrWyeIe9TU/g7VEcA9LBLyCZbp2hTe?=
 =?us-ascii?Q?KEqMeSloOY6qovvqe6aLVfjdE77XKlD/LhfP8TDPbK/rOETt3ytgsHO3qDyx?=
 =?us-ascii?Q?NohDmPg1kWq2lfX/PKMlda+cx+uPB7VUJdnRnmnubO5rxJbt5Lx7M/D6K2+K?=
 =?us-ascii?Q?WfxdwfiYzXnedkVwsLX7dvy/fQSiXKO/qA42LQ9Ba9yrL5Q8B2GeYDXpAxEB?=
 =?us-ascii?Q?nCwYmygpRG//2al+D6rMTONInQ3RPGvdspzKWRGy1S6Yq//Q3Mrr2lJYy+zs?=
 =?us-ascii?Q?II9oV0tA7CHPANZImJXu24gLniIGANGpNtvE6lGrnk2ymJNLHzhIPymnd2yi?=
 =?us-ascii?Q?ryZNF+ATHeZiMuX4G6ZdVsp1j97K+r4bkBllkhscuuRcaE+JyS0DJFZMVFor?=
 =?us-ascii?Q?dPgbkKDGThtEq1gnO8t3JlIh5SejoEpLVmj1STLNZ6kNtfXFWca/OkuelV1z?=
 =?us-ascii?Q?XNNRdGG1K3h4S7BpAiLtzfetlUWKMUUi+Xmmt3hYbsiTGuxYjJe9UPFfAwq9?=
 =?us-ascii?Q?aLPWU8wND4yBQclmHggXYUP2y1Jpv4+DG0x0AQMWWiCTEVD4KkXHG2pj6xZX?=
 =?us-ascii?Q?+XXRClMDnCzbhnPR+/q+K93h1QxFN/ZNizdFXihPGLiCZifOQnw4uNWzvwr9?=
 =?us-ascii?Q?bIGr0DIrL0tFwGzUlc1U7wycFYaupBJRT0ymeUdaqwiPb4brRqUQX1K0wah5?=
 =?us-ascii?Q?zxB22u+hMg4QEpajAOg0ALS0UvuaKWxiqtOADfPewPxHx7fSS+lHMg0rb+Mz?=
 =?us-ascii?Q?5WFjT1fgEHObDqIAPwsU2cIKUBAKuJT3mWD+g946MBY+0flHvPHhHtEWgxgn?=
 =?us-ascii?Q?q1GeUQBdOfOv7Y0s1kMInTx6mwqxod0s6dE89l55q5hXn4qgR79mr6iSTLoh?=
 =?us-ascii?Q?XcS/2FOjWwMFviEy2bLevbKM60h3lblj0KcgGttiUMo94EcyIKfJmFeh9opY?=
 =?us-ascii?Q?oQBIzIJwc35wqU3xBRxETLKuEduoIFcV3r2LydNBnVXq6rWaO/V+gv4EIF43?=
 =?us-ascii?Q?WwasiOEufO0h/kQmLj2s+o82yP6mKMR3BmZCqPhK/SHq0+k37OiZeI4Dy5qD?=
 =?us-ascii?Q?JpBBERte/3PZUDXg0n5hvQkBb9flxRQOqTKHGABaC4BtyHN+pBxPyh7iaD8u?=
 =?us-ascii?Q?yix7xuSQDBE3v+yDdssQ8gXuJdIFmytLuSqFA7yuGZFqSSDbAdRXVHu4EHnq?=
 =?us-ascii?Q?CRm9AEtYY3j4iPWyaua+oZpoHW+tmD8jYnI2v9D75ncvsp5K/X85xtfoe9RB?=
 =?us-ascii?Q?C2oKhvTBRO4NI1wNDoG+JjsjCGVOkrCAPbXc1oCnPuSiHrLitvn1gGo9yaNA?=
 =?us-ascii?Q?MQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 037b1e76-fe34-45ab-4525-08de09f4d5a5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 01:07:09.7232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /VLmEYHo7NcBTSAwsFVZAYRZHfiBLdPwgmNG1i1u3NooZWQH3O2MT8FKKEFu2NzmsQfi2l5yO9yYowG2aF5y5dpaU9fGdQNtiD1ZbPBZZ4Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5946

Add iommu as an optional property that can be added to the cdns,hp-nfc
compatible node.

Signed-off-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
---
 Documentation/devicetree/bindings/mtd/cdns,hp-nfc.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/cdns,hp-nfc.yaml b/Documentation/devicetree/bindings/mtd/cdns,hp-nfc.yaml
index e1f4d7c35a88..73dc69cee4d8 100644
--- a/Documentation/devicetree/bindings/mtd/cdns,hp-nfc.yaml
+++ b/Documentation/devicetree/bindings/mtd/cdns,hp-nfc.yaml
@@ -40,6 +40,9 @@ properties:
   dmas:
     maxItems: 1
 
+  iommus:
+    maxItems: 1
+
   cdns,board-delay-ps:
     description: |
       Estimated Board delay. The value includes the total round trip
-- 
2.35.3


