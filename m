Return-Path: <dmaengine+bounces-1166-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E6D86B9D5
	for <lists+dmaengine@lfdr.de>; Wed, 28 Feb 2024 22:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FC6528C021
	for <lists+dmaengine@lfdr.de>; Wed, 28 Feb 2024 21:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC3E7003E;
	Wed, 28 Feb 2024 21:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EGsVrz3o"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2048.outbound.protection.outlook.com [40.107.15.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02AF224DD;
	Wed, 28 Feb 2024 21:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709155611; cv=fail; b=OAPqmpYQkLkrhCR0oi1RD9JIT9zt66IkWvCYA4O9usVe61yJPduD2FJqFGLD2IgsP48om6yHy/YntdkVYjE81pWHdZjnVHJThPkvXqxp3fSFTk0KklFVTAngL/FlxqmjajHDAnpC04Qkql4qRbfDxwrilnrggUQSyIESfhWqu0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709155611; c=relaxed/simple;
	bh=tvuf6feARiWHxR+sQ30dD0uZzRai+Znl3qZV7bNzqns=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BQdt0T7WQS7gBDpja2Pqr3Z43VvYPYmxnQrOXyuK8l9aXeYQ6+8NvXW57BCKa1uq2MPDItgf1YOD+tQP2ov+KAbP07jKveOMR6Wmmuei+3eqjGFprXEZL74zH6b5b1bE5MK/8G5rx//OfDeX6bNo7x/QMceAwMkyWMAkdSUT+po=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=EGsVrz3o; arc=fail smtp.client-ip=40.107.15.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WjHTvl/QmCVo9sViui2nOtuLQLHIxYHzRTHS+obg4FSs5eBEWdDdeHkV2b1ZYdL7Xon9qU9BgcOKUsVO435EyVbI96co0YcOG408Cf8A0OShlfJfigSrW5aLIW7czTTdwX6xzD9Ol38V2qQDTGe3Zdy0jVazG6st0/6rL5DAUjxuQeqi+UUb6+d7VRpOcfdyA6mvz0DXvKPcmLLFJUUvgOKiVaWBBx8kyT7dvCBxaYIX/cUuR9Lwd2+y/MdXuKUMwe3BdRGmquS+Pd90xlSEFpM/gnGYTda2nWpuKxM1D/Hzd14yXuvIeA3E96ciUEnB3Qi47ZKSsT9ZoKMiTo725Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dYp+AHlv/X8G601eKlSS9LH6WnwKJdC5X7bC0yZgiic=;
 b=KqIK1WghmM3KyXPWz4gJPAHscBclx/xoERb/eISEJ79sd8uUnSQ7GGM5xHn+7RUI/nDAms1QwUJ8c350UKkctvyvEP/9Zm4TbutVbtawc5azb069k4MuX5/FUjfOiixIMZrXsNwrFga7DX7HkGJuCF7DGHSchS+u2pUnvqnLN4Zvew79ZFuvtENNkEHchuJTGJu0TcTiTYeuPUW1cv+oBktCyIqWRi7CrWvM1HRUaOnPjyxItkfhTRxfiJ+34g0b0Ne9UgAccIYRQMiXVRUbs8LFr4B8DA5HBbZu5P/NCHWQJpFLljCUJ1wrPqcpk5RnY5RUPSf5wIJBOjmaNMEDmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dYp+AHlv/X8G601eKlSS9LH6WnwKJdC5X7bC0yZgiic=;
 b=EGsVrz3o6HRbdrTc1F0fareAKCp6vaxDtQlMvzf1SwGEofp59DxnTWh34YtGC3ImHVR7QjOtFuCUmJqPBwtQG/HmoMumCiqT525UQ8hAWVJVeRBRn3O+LYp2iJTA3yqyCkU0Y9QWGDk987MF5goN3Yb+0UxSw5udcYmv9N4TjoI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS4PR04MB9435.eurprd04.prod.outlook.com (2603:10a6:20b:4eb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Wed, 28 Feb
 2024 21:26:46 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Wed, 28 Feb 2024
 21:26:46 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	imx@lists.linux.dev (open list:FREESCALE eDMA DRIVER),
	dmaengine@vger.kernel.org (open list:FREESCALE eDMA DRIVER),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] dt-bindings: dma: fsl-edma: allow 'power-domains' property
Date: Wed, 28 Feb 2024 16:26:26 -0500
Message-Id: <20240228212627.629608-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228212627.629608-1-Frank.Li@nxp.com>
References: <20240228212627.629608-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS4PR04MB9435:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c344b37-1194-4677-5f7e-08dc38a3f746
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FIpsUqA+L1KPAdHPbGFs6vHkBtjUA0O41CaWnTr23p8WKxLecnzKGpmbKorjvqZvbcNBywecvrS32I/TkYtlOvJ7BQNu7DEopBA6f9VDD4esWoVyw3xd9PiXnseJZNvJAQpTWsB0gwVuFwQqfd3gh1KuzvJMujxxtH/xV/1+QGcBueqOFjK+yniUL38l8pEJwLN4InKV9KyrXuyJ7AD4lXPyJe05bOXD0HtBDqMPRJJK9+FTcDYyc57liUfRF1dmMsQQmM2BR5MKN6+vSXpRREUHKGazBbJ3FFn6q6q6jgdMB/upmcppt2UL2p3paOpHoMdRNUZMApt5epX2Tt05Cc1InM1Zungq04umWXRuZ55Dhfm0pks8UtaLcR63fCB7MX0Kjk0sKflC0G83txHBHYeIo6uWClhU7gBGBqWeivQm5+VKQXExJC82yPBJQWW+MvWo+veWnTeO41/N6GHJcAO6BbXwuh2At4sYjsRuoXqrcIVpuSm+xdEVgLDoJ9NzT/CzW7DxluMzprs5eTal1pFJ7iqMm3x1pMBhWrNqHl8f3NAXyIsV8vM8a/t/1KtqL0EMUyI1B5UfnhJuBtsRNy+W2xuAQ6Q6wh9TfcSBdk8Mi2c8rr3KqrkzQ7drvoJwO37ZWOz70KYw7rTb7Pahj4P+dNAeAEZTNmeRlsiA42WOqSxm8oL1mwVLIJocsCGyu1RP+jygT20dq3WpWVhR5uhA479BpqqJ1U1rpmGMVck=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D1dkMgKkvU4LfgdW/gfWnFueV9HYjucByDC0/MyGUq9nINcHOZKYPCimBgdX?=
 =?us-ascii?Q?/jSEP1taVc+yYDMRnsWUk9L3M0zuPnhpQmaZhYvnDxqhPgZwGcaITrD9enXt?=
 =?us-ascii?Q?Ko6EOBKPTuv+ZxGzK7lkBhtdq+AlbBU3EysyqiySmrPiLZ53SN31vJTBE6ha?=
 =?us-ascii?Q?L1Je77MP8GUd520+9J8ZukSCFeD/j2JqHMUFsgYK0I14rfpAVTHMl76XTs6B?=
 =?us-ascii?Q?Rp5Ss2O0YKSCmXJDcozbLPmG0nmlveYO0GjsDt2teayKSuWFrGQ5Ysm3HB6s?=
 =?us-ascii?Q?caaCVUAuHAYded483ygVLfGez3GrZJ91h1XG6PIvH/wBXEUx2IrE3//dhXlm?=
 =?us-ascii?Q?Kk4aZh6oGqSqbQzzPn6UBU92yPeX9r7CKx/R1ylh5neHSIUyX+Y8dvhedPHM?=
 =?us-ascii?Q?uLcUM6VapItWthmQWCWCwCHMRHoVzZPLCo6tUn0pmLtZYWarRfuYLH1Q3B0Z?=
 =?us-ascii?Q?Z7L1yHfotPfY8B61pWkVJU4T29lvt+i7E5fe/gZd62x71tE5Z3IebBilGurV?=
 =?us-ascii?Q?1RTopj1gZuYxqKrvfPmrgTciYJJwrZIIApwWyHLItydyJ8FE1EipLx767Vik?=
 =?us-ascii?Q?SLEzBNQuMexiF0d3Yw68dldHs1p0oWnUocEqccimUV9PiWmvLPzaGrXNL9kK?=
 =?us-ascii?Q?9oKg63bKuSLLeXPCQIV9xJi1mkEykHUkDZmPbI6+nqpR4oRxdnKMl+fwEXi+?=
 =?us-ascii?Q?I59VNR4mc9VGu/J6YvXs07TCaGnJhVz7hT78qkYbb3h67VjYFINTAQxVwwzA?=
 =?us-ascii?Q?bCuUIJ538ofnPdzMDzo3ENwDaXjkx8eznSIABZrsarYV65pDk7NdBOn1tXT5?=
 =?us-ascii?Q?pCpye1Z1qT+KRm6XGYA7vA5+/Xhhc0+0ryh7HxsZBZPo8PImYt2aFHxSOvtd?=
 =?us-ascii?Q?AedIGrQ+7LRTCi0Gjpef91WLlXwthys8UuVf4dsFwJb1Isb12p9dGf6Be3t9?=
 =?us-ascii?Q?UktrLMxxXPpAPvs5xziAQkHewXhWLsqc9xrCONaGCQliIk6spGhEmf4TokJi?=
 =?us-ascii?Q?p1Buud5R2vnOs083mYPLv9UVgpEHbO2B6DGB8sIC4v7+dbizG9SmiOmp9y3d?=
 =?us-ascii?Q?vQRtSjta+89jMzC60y8tTw7onNQzJg/VM3CodkAlGNpZ/+7BkYc32EnzsXn1?=
 =?us-ascii?Q?gafQt3Z+4PIul9GgA2zzU3a/HSfCGT0lq6I3kuoXAYOZSRHUrTdxDTXaCRjb?=
 =?us-ascii?Q?l3oZQS/54sfA7OAouEJ4gh9sEX+0+XVk3dxK3/enONCzlPT5Mx+89yApBw4V?=
 =?us-ascii?Q?F+JD9s156wu0OwZctdoWLGfJL7pP0lrBM5Uh/GdZ9X9XUEkpm5cMA6BcK46Z?=
 =?us-ascii?Q?Y6MwPay1DZsn0lz0ojyONXfOUo2h2djIMhZpTBI/e2OsV6HFpxppImjlAlg8?=
 =?us-ascii?Q?3wJNshsI0kA/M2ezSnShI4AABH1+5+5ogfVh/ogpIEWZDqEA8Rbsv/n8NyYA?=
 =?us-ascii?Q?wY1xpr56GDrbfHB19TfOXG8EzaXPBW3xg/qbgaupoHsQsyZFsoo3UbbX4ry0?=
 =?us-ascii?Q?hMdxqyFzw2KKeA7a42y009LfAPrKMq6OL1Atc5sMBLpy4BmzDfhxNnKGyViM?=
 =?us-ascii?Q?wqXua+MLEcjILDZwVyNDhE5dPRrZr4MoveHXcFeF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c344b37-1194-4677-5f7e-08dc38a3f746
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 21:26:46.2064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8S774YxKziWQMZoqO6JgDoNaFjgf7g21NZb8xkwKEClWE28hwut01oXNTFQve/pu6J+SVGc4+oaVIx1XT3/H/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9435

Allow 'power-domains' property because i.MX8DXL i.MX8QM and i.MX8QXP need
it.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/dma/fsl,edma.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
index cf0aa8e6b9ec3..5368f8a99a21f 100644
--- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
+++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
@@ -59,6 +59,8 @@ properties:
     minItems: 1
     maxItems: 2
 
+  power-domains: true
+
   big-endian:
     description: |
       If present registers and hardware scatter/gather descriptors of the
-- 
2.34.1


