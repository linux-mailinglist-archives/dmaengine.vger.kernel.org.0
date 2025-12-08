Return-Path: <dmaengine+bounces-7523-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D464CABC8D
	for <lists+dmaengine@lfdr.de>; Mon, 08 Dec 2025 03:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8A47305D866
	for <lists+dmaengine@lfdr.de>; Mon,  8 Dec 2025 01:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2628C26ED40;
	Mon,  8 Dec 2025 01:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="Ap4vMKiy"
X-Original-To: dmaengine@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011067.outbound.protection.outlook.com [40.107.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104632686A0;
	Mon,  8 Dec 2025 01:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765159080; cv=fail; b=RgokqXOZZ8SG5TdMrk+kx0OHI1SEHcA6WnnECx7tVJofCk57PygYVUtRbFEP0stCMMacsXfoRC/JFzrA7VGR0UacG0TI/2Pbl020KaUz7D8FRnFLgNOPjWL8lZz0ngMxWqt07qWBNYpzAeonColWgTlJAataXQKc64LNUd/IoNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765159080; c=relaxed/simple;
	bh=6t5RToTk5dcH817yA1N0utinHi0RXFKz/T/dEpgjTME=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K4ViEw3zuRzrAMUfRZ0I1e+eJ+93Hbs4Kxbh6kzn7ezIHBSZbk/kNhe45MZncGF4rdWlDRH7vg+11dvjFKuSmdAjVsZe4dm/X1g5e3zkbQctQJcsXG/Hq+xssiQKu72pCRG/bvC3uhH0ZJjvISR+5BOcTPABxanci4xhmSoTwog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=Ap4vMKiy; arc=fail smtp.client-ip=40.107.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=byzOC7r4G+sQUGQwFTDOvhv7PM7Wnd/Fey3BegwifRKLb4e+5DyOUoV5ZtsSPi5mvXlSDvcxM3LyDdM37Dn3vnbfij0XzJTuc7aCIfFNWrQatWtGIpH7iQuCfAuQfZTsn+dT23JL+gwI7DETJjep4p80cF5qWlhBBQsu5F5LzweIfdOc+tTPt39WNvALR4kNvWwV+iiJx5IUIPoDJYRO0w0UNFAThO4Rj+RHY+aVQDbTTEVJCpQ3flW9j+aCH0l1YR6YO3Ce0I9A3lHelPAm1yipKH1O7GLS9gaFPU5+WYwel+m001IbLG5A6iFtO6MpL5StQWcMqGWJeEanVlYG7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mmTnE8I5kIqzIGTTnjRjLEZk4I7cORLFXZ32RYQuhjw=;
 b=l5OZ1eWGo+anlISDEXpoUr2X4e9yxoXKIVlbn12EyY+SHYF9arQFAMo3UZzBLuVfPsUR96XhQS1LOiUYRNWrAEv42htZHnPmLFdg+b5lJSg83Z9+8X76LV6eeRned7qTBHpGEu+/RwMq7wZmMdJiycXDwLEIVRZxkRQZU4kP2DeYJgw3pzA6aAeoN3zS3PRVutJ8R/PDf1zg+bJUrPkiRqHuH5lprqv7Kip9UzuZ7xYoorqLRVwcBUtC84XvISnn79yHjJ+6ddNelSMV1wg29jXAUkTzNz3sce279rhSfLkmfFtoNyBy0VFl2i56xfEJEHyUh192TAVhKWzpkalp9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mmTnE8I5kIqzIGTTnjRjLEZk4I7cORLFXZ32RYQuhjw=;
 b=Ap4vMKiy6g6qwKBRW85Z44RlPF0vKMiCo9z2dzHE4lmVC28oEYLqPINtW6vH0SWpIH641x1r+6Cdc8PtBN/dWOcSfVprlY7H+y2JmeY7VcuqUv2Nr5hqkjs1V6t0Ddy2BO/ZHhfesCiPB0v1y5YTVit7oWvw0jolE1odw/dLQkr2T5BMujn5j14DqHFhnVALy2pHH/BydxCj1vFWQ8hTUHQm6DebtfSly2aNa6yoiFkIJHeHmrKIA+KZDfXRmokm1WTf6PoiKvoY430pWWCmqayYTetHx+TDEuLmfPO3a6jgaVBGboSFnPmPW8TA5dyCWSQvMsBL8wkTeeA9dIpiCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS4PR03MB8447.namprd03.prod.outlook.com (2603:10b6:8:322::12)
 by SJ0PR03MB6341.namprd03.prod.outlook.com (2603:10b6:a03:38c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 01:57:55 +0000
Received: from DS4PR03MB8447.namprd03.prod.outlook.com
 ([fe80::4682:710e:536c:360a]) by DS4PR03MB8447.namprd03.prod.outlook.com
 ([fe80::4682:710e:536c:360a%2]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 01:57:54 +0000
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
Subject: [PATCH v2 1/4] dt-bindings: dma: snps,dw-axi-dmac: Add compatible string for Agilex5
Date: Mon,  8 Dec 2025 09:57:42 +0800
Message-ID: <09c56ccbd5b9cfa717c7901ac35d9235458bbc30.1764927089.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1764927089.git.khairul.anuar.romli@altera.com>
References: <cover.1764927089.git.khairul.anuar.romli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0237.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::32) To DS4PR03MB8447.namprd03.prod.outlook.com
 (2603:10b6:8:322::12)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR03MB8447:EE_|SJ0PR03MB6341:EE_
X-MS-Office365-Filtering-Correlation-Id: 096a173b-64f0-45e9-0938-08de35fd33ee
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jjz6yNvJMzq3CZkSsZ3Ek6EXbXzEpTqfS5rkvEon6M+p3D/T6sWLQ9wZMCHX?=
 =?us-ascii?Q?4Ab5XwnTAOZOppYDuAOaGVRgR3wru91gqvHTGcFRJXTg8UDR6sQ/fiIwZ8D/?=
 =?us-ascii?Q?x0kBrgLKndKSVDdh2hpWOeqVU8jkwpU1I6UmRp2wpKJQxJcZ8Hz+dBlAv6zg?=
 =?us-ascii?Q?HpDHPL8HjuN8Ao0a9p18iDguCtt7sDfKdsWl9Z9V612XW60dN67JA77aWxtu?=
 =?us-ascii?Q?9OQsfYRfVwtB9g5avZPKXUHAQRV5i0dwBsAfSiAoRp926/mXr3dEsyFRAIKi?=
 =?us-ascii?Q?xKy2vJQ92At5w15P65cK/UC5GAmqAuAlqlBK3JUhtNDdZkdcmL6LnvJ5Nx6/?=
 =?us-ascii?Q?83eIEUDcglJjwRFZaQry7QOlCQUmE6yRDSxVt+zlEsFTCtVV4fAdR6yiXaFd?=
 =?us-ascii?Q?QGgpcOTPc7zAkukxuRKrlnjFlBIK7xr7xcpvhY7vdtqnSO0DpIU+HELVWLMd?=
 =?us-ascii?Q?Gu/wYWBQoKF5XRerN887ggF5/ioPPhiQf/f7+cHuwyXVPil28xCbV8TrCIsz?=
 =?us-ascii?Q?olwt8T4qA50ZiECVitKfIJTqfx/luvLp/+vo71aP9xJe69y+C26Nnd3hZ78p?=
 =?us-ascii?Q?7B2QxEFyPnzZY8KVoX5eH46Q8UkdgbI6h6LYoDNWWOFaEeAH/9aoVrr/tcZ0?=
 =?us-ascii?Q?600TQhrIbXFOWOj2IhBiSLfvbdO5azXF79wYwud17jbcSJ4/RTRyx0iXjE/X?=
 =?us-ascii?Q?Pgt5P50DG3IQXWVNPc+AJtuQ8b+5pEn9Y8NDifvpFe7I9cVKkyF37NHG5vwE?=
 =?us-ascii?Q?TQq3y69+dbuSdtiDSPHesz1zygEZRmfJ7XifraZ5eWLf3EkHwFsyN3DM+MS6?=
 =?us-ascii?Q?geJdUnLHY/H/hFEu/nRnYiNIet330E5h0sWLiLf5SA8xYuMKyCJ3hWSOrJsp?=
 =?us-ascii?Q?1F+vCi6i5vr3ViO1MM2ZIHsrXUieoshQTHlj/HKTW2gP11HKGupWwe9ijR3a?=
 =?us-ascii?Q?T6i2JGETEGgpDBsNxVDV7rKQJS1STu4gJzt7WjbcM0ODxbG/8aEOmF2qaUnc?=
 =?us-ascii?Q?vSkx15OEtF9CnZDJbyGmFmqyzOSherRpfnhM6K5sQdwGI6EOtjdNz9oVLhqc?=
 =?us-ascii?Q?v/4O9XO8L4bYYGC5erw+1RSopog+dPo6VLe5gxI0jqaRKb/MtChcFFbcOGvM?=
 =?us-ascii?Q?xTDtQr5unmutDGgt/BM5PH7XPia+Ty6WE9MzHIJwUnO+D2LRKi0Yz8VnYWBl?=
 =?us-ascii?Q?a8oGfm2NLz5zgjT46bHDXWZqPia60jiixNq0OKr55IgrQvN3UfmPRp90CN6x?=
 =?us-ascii?Q?f+Q7e5b5dSkL2PV5U2peAn8EDdgXWhmIk5kyx3sJZdBilVlxuQSgINVM5MsL?=
 =?us-ascii?Q?XDLb3sAmq0iYZ6RsWYHxJIqRPeVnGTno3xl2ol7R4tF9s5oYu2fRL9y1arkj?=
 =?us-ascii?Q?nzkKcQDVg9aQhsC0YusL2tuqxZ+syuy1osa09YvubFoBXLFTTNgpbrlbkHR0?=
 =?us-ascii?Q?DdAfXnz/iX4g4UQ/X62286B34esTRaX3uRtZY3YvblJmphkhZwQxXehCyz6v?=
 =?us-ascii?Q?gRLNqmCdiULa9wc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR03MB8447.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8gxhMtY41nwOp2aFCCtBtoD5Xb2kG/8mirv0Hjl9PT4Us0vFPqZMmK84Vm+6?=
 =?us-ascii?Q?p8csUruKMDlfQKwHgDmv/RXK3IQXKX/JRijN0kujDt6sdEQX3vEXncPDW3qQ?=
 =?us-ascii?Q?JydMOr+fp16LGVSGFRtTN2oh4vI2cgx6eoeirDw+RpxsNYtey2WFQpiN+8xP?=
 =?us-ascii?Q?pvtG3ipg1P7O+Lh2jkaIj17wgiYDPXQ45QJhsmpIhL+QTqgIayFuFahyyfyJ?=
 =?us-ascii?Q?HmW0zhwh3YJ5J67rz397TOELUxiiILjCOzh6iwtV+r70xq1aC2cLZl6PTWWI?=
 =?us-ascii?Q?oAUsVZdK/NTjozzDR/NrSVcGkv+/+bjzgzrdiOXJSXvRYi5ugyHGSxKxWMPY?=
 =?us-ascii?Q?LgLMhrr8EATAbeunK+pRMJEyt1LcJmb6JQKPbGtlKRDG3Kf7t05/GmPwhsOx?=
 =?us-ascii?Q?UVG02LzRawc2NBmlv52FGlUkbEJojCg7vvX+ofpWtbwpGsJijnoadmTpkM90?=
 =?us-ascii?Q?MAgL+ExZiwwEuqifRRBamHISQF4fsY+TSuHPrL7gQ8App++S7mjPBC2fipAW?=
 =?us-ascii?Q?vSqmZLEWyN+mSyhdeGGHjFOVv0m4t1JKTzp0l65Iz/EJoFhvnOwR56ayWzSb?=
 =?us-ascii?Q?BihpHO3YjKkL9lTh01UlSQGtgPtdSREh3Y3x8ggnmmB9hg5/lz3VUJ2uekXI?=
 =?us-ascii?Q?RJ8NZEOYjhcRbHE1u2d+WtaBxZUUePyUMe0wVQeT8vXrklf+TymkPCPjXnUh?=
 =?us-ascii?Q?qwPlBWmnI7wmpKvDriH8oFV4Qz2NDnZWerJk48gO6c9AlEGNRtSvtkQFm4rS?=
 =?us-ascii?Q?jHJ1+4GlbOzzrjbfG9A3Tz27oBkj7SSredYq9/R9UnNwkcnnjgyv7zE2SWkU?=
 =?us-ascii?Q?Mm/fn52ro92CHUmS5Mb7p1Xx2OIbbuROR3M//+6lVy3JQ9yLbwaWz88nMQ2f?=
 =?us-ascii?Q?wOpSu8JDpChCPnwRpDBFCRyYsmNapxxgYGAT6PtJxpuqeHuNkhoc3tC2CJxl?=
 =?us-ascii?Q?nQTAHol8UnoDzND7RWk6bmwT8TdtWlzUS5VNKKAQJ6lyieslIKeXQgUIEWgJ?=
 =?us-ascii?Q?j40gHjEUJ7RvFn8NHmvwyj2Cidt44E7/gJcwQjEgsp4fcwBcYypPfLT4yNfK?=
 =?us-ascii?Q?lVy7JCyGomnk5Bx7BOa9tpassvGAqMGtW+FmqK49iya9qY1aWsFzms7aWeDZ?=
 =?us-ascii?Q?SjzDthFoPIb1O+lbKwQCBJPiwF8bHVilvEnIT3l4hD2oSfwFQby0uY6ZbBNL?=
 =?us-ascii?Q?nwVCTvNFS6Hz7xdPhmTn9/uFw83g2b4IXl1qJ2qLKi21M94Z1Xh/kdycxV+H?=
 =?us-ascii?Q?Er/XJ5qykbULxenTiDAXhBO56uZg/AGpCokpH+IKZ/NH8uwoIXaUttj6ORxH?=
 =?us-ascii?Q?PdzWX0Bzzl0Q53Eau5JD6A6b30zt8kJQYUyDHXl/YxbdZpAesLdAsI18s8KZ?=
 =?us-ascii?Q?HwxIbD5Xf4CdyP8+D17QnKqbNfYQfJLRG1wBBPY5YohwTVSU23AkVyls8piG?=
 =?us-ascii?Q?WYaXng15S+RSerclTYGVrOFkjCFwxVdNXj7/TDcSIZqPdNzogb3gl8wSgpxy?=
 =?us-ascii?Q?ehhvCJq09Osw8LRUjk/6M0HXWw6CqF7gUl37Q1Z3eSajypsFRsgrsXIASwRo?=
 =?us-ascii?Q?DxyznuqtCdmXDf91ppDdPT92/uljTBsI8GFj4HoFUCqQUOd4D7Tcfs4/ia10?=
 =?us-ascii?Q?ow=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 096a173b-64f0-45e9-0938-08de35fd33ee
X-MS-Exchange-CrossTenant-AuthSource: DS4PR03MB8447.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 01:57:54.9750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ELdztetQDLaTe0FuAJg5DN4A23eaQa1blZBYIRuYoYACb/lywZ9FHExyoXlh+s7FvChCpnlzd0BVaIFhzrO08PRPVXplZFNdC6+9QjLlcpA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6341

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
Changes in v2:
	- Add dma-ranges
---
 .../bindings/dma/snps,dw-axi-dmac.yaml        | 23 +++++++++++++++----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
index a393a33c8908..1a1800d9b544 100644
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
@@ -104,6 +108,15 @@ properties:
     minimum: 1
     maximum: 256
 
+  dma-ranges:
+    description: |
+      Describe memory addresses translation between the DMA address and the
+      CPU address. Each memory region, is declared with 3-6 32-bit cells
+      parameters:
+        - param 1: device base address
+        - param 2: physical base address
+        - param 3: size of the memory region.
+
 required:
   - compatible
   - reg
-- 
2.43.7


