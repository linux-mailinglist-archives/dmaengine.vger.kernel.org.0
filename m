Return-Path: <dmaengine+bounces-7565-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32482CB4AF2
	for <lists+dmaengine@lfdr.de>; Thu, 11 Dec 2025 05:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3012630124C6
	for <lists+dmaengine@lfdr.de>; Thu, 11 Dec 2025 04:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EE325C704;
	Thu, 11 Dec 2025 04:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="hdwNvIOM"
X-Original-To: dmaengine@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010034.outbound.protection.outlook.com [52.101.61.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAF77E0E4;
	Thu, 11 Dec 2025 04:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765428051; cv=fail; b=L+ErSDx2GL/7kTbPCXcncTb3AMR0aNfe8O9xBPxwxmiiR6GG9jOgv/do7CSIxR12NeSHFpMLBSYzIZPxvrc5e3KJPuwdap9pDkef+UTEbfcRMPoF+TW0Rl/Yf9ez4RcS1pB2oeJPkwehiv3bwIWGMmNzokD7gO7YAimbctmmotk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765428051; c=relaxed/simple;
	bh=OSphNoVlpfugBXIlUG63MWg5Q9/tkyraAEsZ3wikBNE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C+nNlYDfCviQEfrfo2hQrB3IqlFEK+QVkRAJRu1RiavrFtBxOHudFIogwqYLZ0mPdugKvcwnDqSSvg2kGZU2buCtTkfavH6GRCWnJc8M9bBU+nzsSYKj/b9pMP+WUzDgVHy5N7l2/ibqW/T0a1+dYNb4oeFe69zrYTlDhAqfd/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=hdwNvIOM; arc=fail smtp.client-ip=52.101.61.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UJx/yodpurNHGgbhyuXhpfiEwScunZG1MMC3U0pcmqUoE1nzOS0sIYaaFb/b9n/lRbRM2aWzVTs5HnidlCiaNb0a+6urC6q5A43V6cidKu8DjpDMaSiAD4d5eUUR44LzPR9ofQV1HPfZa0IWn14c/ukPI8cOnghyBM2a4HtDFr2LhoEILgglQdKcJJuMHqVR6KaN1t6DNyujTWrnYno3d0w0VXN3odXtE8mq5B4ZHuIGv0NkgDjqxTMHVyoBknhPuGKW5cg5DYtU4lvGyvHJ7T+8xNqI4u7XTLAhOh1vKSrA4byTiU0uh+XAgy3F5qFWVrC2reU2G9G/TpQNunVvOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v2CooBQgRkqX8zJVL+x88lDmzHqxBCknqi3mgw1c0Og=;
 b=ylKyNSU1aLpqj+GRR1eFXXbwaol76ohL0qH3UJyn8zTiWAj8eyENDH/aLtBuXiCPC9Ipr5ISE+C7gtqSnORzUbVf7Ty4ZO8ASgqaRHyJbFl0i2KDIo1FfpEFxuDukjdy+nmTcDL4JQDte7lmTAXBckMLrBABiZdT8eK/MxdUV2SSkciM3TsCk1ctjEJ8JqlCLWFK1NeE9MF63LgLbsTDawBKkfIjPFi3Owlk1k6nz+2uCu7VhgiU9/2roZEeB/XO90+jxOaQ9hOcHdnCgJOSIIPYm/b3vF+xRAOa0RYaJwBN0CptfScFomNCfqZ4BTbjs5YQagnyYot9+5S8IfMd8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2CooBQgRkqX8zJVL+x88lDmzHqxBCknqi3mgw1c0Og=;
 b=hdwNvIOMBp5JeKIE2ceSeUS7ucd78+MG+troipC2/m+DC0Z2lWoESBKR3p4uxthW8XUAsqfD7KQFovFDxOb5twOHPa1NoFGfYozwqmJ3svyCUJPENdV2J5AtIsaaDrZLcHcyCOhzsaZE1gbC2KgzDirDVwYG++I0g4f8O+vsjWXRmZbahvGeSN3aTYen0sUW+hHAPYXUhH07VaEWBfHBDjW6wL0SoM42gUXRu4KGMvWbo1Cqqhj+LWcPQ9Czl7eJhw+QKc3kv6VbojcsNJO49f1MO2J6aqIbnY9IGhUfO8sXWmicKIA0ID9XafgQJHclDb3Ar2Up3GpTl3kxB6xuTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS4PR03MB8447.namprd03.prod.outlook.com (2603:10b6:8:322::12)
 by DM6PR03MB5308.namprd03.prod.outlook.com (2603:10b6:5:242::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.15; Thu, 11 Dec
 2025 04:40:47 +0000
Received: from DS4PR03MB8447.namprd03.prod.outlook.com
 ([fe80::4682:710e:536c:360a]) by DS4PR03MB8447.namprd03.prod.outlook.com
 ([fe80::4682:710e:536c:360a%2]) with mapi id 15.20.9388.013; Thu, 11 Dec 2025
 04:40:47 +0000
From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Subject: [PATCH v3 1/3] dt-bindings: dma: snps,dw-axi-dmac: Add compatible string for Agilex5
Date: Thu, 11 Dec 2025 12:40:36 +0800
Message-ID: <21ceb1207564d9962c90d8235282f1e462df6875.1765425415.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1765425415.git.khairul.anuar.romli@altera.com>
References: <cover.1765425415.git.khairul.anuar.romli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0060.namprd17.prod.outlook.com
 (2603:10b6:a03:167::37) To DS4PR03MB8447.namprd03.prod.outlook.com
 (2603:10b6:8:322::12)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR03MB8447:EE_|DM6PR03MB5308:EE_
X-MS-Office365-Filtering-Correlation-Id: af1a3e7a-bae4-491d-1f08-08de386f7446
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MapZV2KYVH7zuQ1u4fF7+1EYqnwjNp6sKRG7T8Vfxp+EMPKUgMGuaFu03FNC?=
 =?us-ascii?Q?DJBRr4pqzLYJH4RAMuWLiyHmmYoni9J1G6Pw5nI9GdVnHh0KUDdMk7d7eyRq?=
 =?us-ascii?Q?uU6xeuSBgO5h8BIYChI17CASwUzHOZxjFcRr7082nEtDTT+b2YfnuuzGC1W4?=
 =?us-ascii?Q?sf99k7dySV82VVroB+D3xAIDMAMPY5I4ml/BjcUIBOBkS5LZaQclFZXr4G7I?=
 =?us-ascii?Q?5Peloq8WtiJ9VM6XDkRirMZeG+ZF89rCYcCQCKKkCBLreoQuKt4ePjhQTbgu?=
 =?us-ascii?Q?lDwQkmj6F2kCnbOJ5jjctquT1Tp5x7L3852Qyn9Qbx3/0EeexuGp9C8+SlOC?=
 =?us-ascii?Q?uK0fG3YZboD71zxUx88juttzcjJWB6rhZ0+2t0oDaFXsJpFWKN7ZdpEhloCH?=
 =?us-ascii?Q?QTtnH2RZc4wjWIydqxXrmFeo5kVNg7mv1HBZhnc1xtb2dLKrVaEIlKt4xioc?=
 =?us-ascii?Q?UdK+nQhse0RN5o366b6i9jhii7nqer8yJC2TiyYhV1AYvRc3rYqiuurs7+RG?=
 =?us-ascii?Q?9R89rusyqy8D5fDhKTNQiELJ3iiNXmIm/qA6EAyoT3FA7m1FNZNDDIn+7Acz?=
 =?us-ascii?Q?Zs7xdtShEyXzAIJrU4rJu6uOSecuucDorKIULNwy2ZyUPUkmTj2VahZ1PSOS?=
 =?us-ascii?Q?QiLYoF7D9GUrzcQxi9FTzVT9prkAKSQShcm+OsIkYpIYAyZsGrt+WsiWFct2?=
 =?us-ascii?Q?AlEfnEpOCoLT+3X4uN84rZTwInFrw0uaL6SPXvjoo/jFrYjfLTBaZN/8A2Jv?=
 =?us-ascii?Q?Q8t1NMLoAqJqQsyQAFjZ1YHk+gadqpAEpLrmAQpEWi2atkGWy/IGfcviDnGm?=
 =?us-ascii?Q?5NriLs7vuMkNlstz0g4yTHfjWSczcP881jzOKczQ3Yp/e9V/iF4MviRh1Gf4?=
 =?us-ascii?Q?lsezPpBn5a6Fg975TofTWaMyQ6y3mTK7tNMKe9apgYi53Hx8h6cWCL4G8IGf?=
 =?us-ascii?Q?a/znJnD397wFqW9FLt2zhs370+UGUx8iTD2cpU5j9pYigEY1pYdgEu8VVHZF?=
 =?us-ascii?Q?ZYPOBYpWLxubjcjkp/Lc1ghXBx0wjWKeLEdpuPH08i0DgYEoTP3BmepasuWL?=
 =?us-ascii?Q?Et27FZNn5sNVdR/odWyY1IIGsqxvRAQhMuIdSoFqf9pHzQUds6tGCR25cdlK?=
 =?us-ascii?Q?bC2y8duMBHe7yPHBB/HZNnrWnT7tURBiVylpPaX8/PvwPskpOG3FgyRmd4Ii?=
 =?us-ascii?Q?mvi6ZbVzSoPY/dNisSHrSEbRgTPkX+1RjZ2bNBsrrdyi5Ri55NIS1iQg9OI/?=
 =?us-ascii?Q?Mw1mxlkrQwGqVk5dz0qM6TQ0dhRkE98OQx1PoWfzWfwmGZ7At/9IILvDhZfB?=
 =?us-ascii?Q?hI/ZPPuegjMtcnhvyzN6z0En5YWZXt+4dtTjaFHo4bKUEd6xgAKQbu2URQVW?=
 =?us-ascii?Q?GWkkVlCfCtYzjcDyNM1euTSGV+jbb7JZ0Asu97FjCLpgwxfgkTptdiMOJ2Nh?=
 =?us-ascii?Q?1jttFPbLX5zzfAna3Y2R9nPwke09Y4k4Q9aeP91T3BUzt+I7r17RQtSViUFe?=
 =?us-ascii?Q?qDZiZFaN1YrFgjI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR03MB8447.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XTTpiCqF5RWFHJovr7VF1wAkFJJrL0FhJIYyd9q7tR5xZfLjstMGmjpXrDmf?=
 =?us-ascii?Q?C6+bdh/zHw6v2ajTWkEqNPjHZX4n2XzYbEzvI8VSGVPCN+uOGVoF5PlO/jPD?=
 =?us-ascii?Q?jZF6V8+TYW0GY945GzSYBJf73q/KJxeTIFTHFxcOfUM50JaiErm/rAs0ahat?=
 =?us-ascii?Q?AjmqJ52nMl6SDXKjiD4hwOrR3OqhbBO5KPxFqgSP+K/XalfiTPuinPZRZ7lY?=
 =?us-ascii?Q?mBAl2gcqfIxT+cTDF++sySYVUfa2YaZNLnCHCC/z6X99VT2HPeKHE+Y0JlKE?=
 =?us-ascii?Q?nCSziU1Umh592VFGlkSAIxIhMtLaYYNJFgKCXZB6g2pSanRHMyoQZwHZhVmW?=
 =?us-ascii?Q?o40yT9Np1IVFpPUuB8tz5PeHR+kv9vjzyeymg4l5YEcjbVISpT1SYOpoQFaZ?=
 =?us-ascii?Q?+8ZoXtWt4uV4t04Ea2YU8JR4x6VYu43AcZh+2+1MRyQlcD5iURJJ3+1kgYHd?=
 =?us-ascii?Q?VjXObiM7/Jf/0t3ZI1iz+R0CNSniWMTj1rDsCPRkKPgpEx51RIyAbf9V8Qv2?=
 =?us-ascii?Q?s6ScO+SnYhMzX/VDmU56SYF/Ricbotg51AfIZNvqnSNsH058ffuTxS0irX/4?=
 =?us-ascii?Q?u8a17a6PiSoY3IjStWfjHUZwMH90mKoaCa2CpUhLKafUnfDCmUSI3BYAkycA?=
 =?us-ascii?Q?mAXANiC8bgvSP/Vc/JIXDPrwMkizYepEuC+OpchBwQCGNPvgW+Ya666NBqPV?=
 =?us-ascii?Q?DAWl+ZT/DKYC0Q8ON3xHrKYTrlQNyHJNILk4JpqTAnFfIBv54tXrx7k/Eo3m?=
 =?us-ascii?Q?WGmPRfsBRqtL4yZt5gpKjBBlx/SVXuEl+bWEffurGV51BZtU+QEphTvdIbl+?=
 =?us-ascii?Q?hJLHDkc8hdyJ6xu8saRHrsXPwsS2iTIpkVkSxH5K9mp1fN3kqQsUAKdV3I2w?=
 =?us-ascii?Q?B6SzXmC+TaHv5lY5+4jWgtfLnmHEiGDy7cmOUZY4IpzjZxrd3m01Cn1cXGba?=
 =?us-ascii?Q?cKWk/HxSI72Fk3QjwC4kMoT68uMmPQDa7hILYGIkoibMd0xZtvknz3SHcPgB?=
 =?us-ascii?Q?vDbF4/nyYe4wdrVtsk8c4toEUD5k9WzhOnSemad1o8UiZzmz7iIDCLXKQJEd?=
 =?us-ascii?Q?UXu2tuMFCbsivBfbnt6mo964pB2uV1dbBDzyJKD7t+j0Ex9EqF6MGBon7c7z?=
 =?us-ascii?Q?xRTVgAt5OVqxmwZXLZSTKTH4WqLBpaLW6xHXG5Z61rBWKw5FokKU7+8oBWdU?=
 =?us-ascii?Q?cy5q3TTsgmpMHnsXQoVucEObIHtYFGHjlKkYzcwvXgndnbgkzgV1Jv0Tto2f?=
 =?us-ascii?Q?sABWL9ZjzU+vNdteu50JEfvaDrCi6gdr8HnuCBSpk1m7v371g34Hdtq57zpu?=
 =?us-ascii?Q?+GJtSy04GLb848OOZBrcP+ljQ0GI6R2FRwRUiDrgPVxFSDiZc6clDpNGC4Mb?=
 =?us-ascii?Q?tWLPAM56mYYXL++zCfipcs2Yr2f4WHHzZI3yl3O2CCZ2iyeoBqh9f7hCCKBS?=
 =?us-ascii?Q?CjtiFMjq1HUzdzT/Ib+uq8ChEV76cOtJw8edRCHW4vj74Rkoi3Y90uLqiJu6?=
 =?us-ascii?Q?7qjYm2RRhZPQCooKzpIToGzUbk89ok8WhbuLOVFHC3IJfMqgJcKmeOz7ujpj?=
 =?us-ascii?Q?wuD6lp3gazj8iOlv3NGKpvpXU4EYU5mNi8aJh78MCmOlP1/LrOK+LOKF9uQk?=
 =?us-ascii?Q?uA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af1a3e7a-bae4-491d-1f08-08de386f7446
X-MS-Exchange-CrossTenant-AuthSource: DS4PR03MB8447.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 04:40:47.8773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i7CdTNZgIAZSK+kFOPFcKfvAT/Qa2zl8UFfCcKw2Dm4tPOEse683Bc7YNRa9rG+lY16gwRLOrrTpO/EFAInAzss+PfJ/46m32GW9xG3ZqqE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5308

The address bus on Agilex5 is limited to 40 bits. When SMMU is enable this
will cause address truncation and translation faults. Hence introducing
"altr,agilex5-axi-dma" to enable platform specific configuration to
configure the dma addressable bit mask.

Add a fallback capability for the compatible property to allow driver to
probe and initialize with a newly added compatible string without requiring
additional entry in the driver.

Add dma-ranges to the binding schema to allow specifying DMA address
mapping between the controller and its parent bus.

Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
---
Changes in v3:
	- Simple dma-ranges property with true and without description
Changes in v2:
	- Add dma-ranges
---
 .../bindings/dma/snps,dw-axi-dmac.yaml           | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
index a393a33c8908..1f4dcf3092c3 100644
--- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
@@ -17,11 +17,15 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - snps,axi-dma-1.01a
-      - intel,kmb-axi-dma
-      - starfive,jh7110-axi-dma
-      - starfive,jh8100-axi-dma
+    oneOf:
+      - enum:
+          - snps,axi-dma-1.01a
+          - intel,kmb-axi-dma
+          - starfive,jh7110-axi-dma
+          - starfive,jh8100-axi-dma
+      - items:
+          - const: altr,agilex5-axi-dma
+          - const: snps,axi-dma-1.01a
 
   reg:
     minItems: 1
@@ -104,6 +108,8 @@ properties:
     minimum: 1
     maximum: 256
 
+  dma-ranges: true
+
 required:
   - compatible
   - reg
-- 
2.43.7


