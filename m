Return-Path: <dmaengine+bounces-7567-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5CDCB4AF8
	for <lists+dmaengine@lfdr.de>; Thu, 11 Dec 2025 05:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA627301D60D
	for <lists+dmaengine@lfdr.de>; Thu, 11 Dec 2025 04:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAF8275870;
	Thu, 11 Dec 2025 04:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="Z6buROH5"
X-Original-To: dmaengine@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010039.outbound.protection.outlook.com [52.101.201.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770F3271A9D;
	Thu, 11 Dec 2025 04:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765428058; cv=fail; b=t7bozUs/kdHXpXo0TTKXhfsB2ztbhKvZmogMMOry4L3Hhh03A9rbeZiE/X8Yj1j7RXpLIUBDGmUEYFUwjE15VZQPkdNLEmVhxw0ZnGVTH9dZXGBTdkpZdREjqkQqINM/2mf7Gs7UMBjCGjiPDyqnliydhvrJ3Tg1OfORdHareHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765428058; c=relaxed/simple;
	bh=m061o02gBBggYmMsJuAAWEtIdwvtkRftDBx+9Qoga48=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=saw/peGRpxwQyYC1ggyqR3ahLTKHZMdi+bfsbk9/5y1EKujgiV8IMN4Fsn9jyXRIGEdCsZAkA0yaifWGp2p6WMmK506WfgXB37Ay2gOVGwAjfLTAfcKGsouUISUJPxKacfLj1rl8cjPK+I1qBagqHdKNnijxs/waZQC4PG1GMCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=Z6buROH5; arc=fail smtp.client-ip=52.101.201.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aP0IRg9sv6IrQTcLm/k+8kpTQy/JzSVgGxAXVva5wSfbjWE7BgDUSGnz5BtZJqrtRe88s5cXMMaLkesA/9vU9aAagDUaWbymCAN77PC10gB9ft879Z5umfuGJ3Ey4kh+NJRwOt967QIJ7X34GdCqqBzkxK80P7pt9Lq994KsUYFtRdbPiiY0sCJTd1DV3E/8wUrILXKVcbqj0phCzzATemkXqnZOKJkj3tgnbfdO9lCQ38wzIpMln+I7eINDpe7WEWRbKE41xQeJZ4k8DVKHChT6TKWvLw3tIOzlr65Y9Ly4nKQyUnGSf5+q4/hA0/Ls6ZwCj9CSqLiBQYCC1AIZ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R/2cdoiNU/x+XBzBaE2+QxCgm+heeCZpt0DfFWo1fB4=;
 b=R5RmfaT3WeLy9/yQ5eMzcuy09Jrf3MDilHEMc+LvKDci40KhQlAfbkhd0NT+0b0RYUJ7ZdS45nDh5utYuOmgRMXdXclntU/yGG+e/rsZ2j017xQx+5893pxokyUU9tuHRjWdGHCOyre3/Uizd+V3ZFbUqRZSzAbXYb1otsJ2GvWMtOeTvYTVP+c9mDD5923+iUwH/rl07GAkYm68/Wve7Eco72JSKq1Cy979XyGnryFMXIev8Zb4q2vEJQBLe7m7mXZoCMuPLjlkdGDOtffuusNepQ0AHubEA6ORHJmBgfl8ClC17nlqLlv+jSjXTsI/toWH1F0Ik3J+pXkBZUMxww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/2cdoiNU/x+XBzBaE2+QxCgm+heeCZpt0DfFWo1fB4=;
 b=Z6buROH5GY8luJlBPsaZHv6DXjKWwrDKfkZnbaq8Of79CDtdP35KrzhUkzoi+2Y0KoU6EVbPtw9y+Dl/dTrcXzFcMZmTboNYAlLlJlbzJyyIkOcaOA5KIwlh87mgw2MjZq+VcSmg2KpSJUZ1JGG3ZNPo6ZukXXbv+hzDg3gfl22kyYzKNCTEEts0JD+HoeWdyGFar8iIAdxUfmFixiFtoHAG0SLtdJMyLXUSOR3u+t4/2jL7V1T+QzSR5/FkaGuxKQaCj9xSUVB//dFCexY/Hy1zKsSBTZdWsY1g3TNfhabqvvrp5lR6nVavpn3pVs5WtQ4+BQiQI3bG1STqtcUoQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS4PR03MB8447.namprd03.prod.outlook.com (2603:10b6:8:322::12)
 by DM6PR03MB5308.namprd03.prod.outlook.com (2603:10b6:5:242::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.15; Thu, 11 Dec
 2025 04:40:54 +0000
Received: from DS4PR03MB8447.namprd03.prod.outlook.com
 ([fe80::4682:710e:536c:360a]) by DS4PR03MB8447.namprd03.prod.outlook.com
 ([fe80::4682:710e:536c:360a%2]) with mapi id 15.20.9388.013; Thu, 11 Dec 2025
 04:40:54 +0000
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
Subject: [PATCH v3 3/3] dma: dw-axi-dmac: Add support for Agilex5 and dynamic bus width
Date: Thu, 11 Dec 2025 12:40:38 +0800
Message-ID: <646113c742278626c8796d8553cdb251a4daf737.1765425415.git.khairul.anuar.romli@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6c0158f6-d68b-423b-6fbf-08de386f7843
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hulUxq0VWEv0PVQLzg2+vssYUb4VVM4tJkEuTPQC+OCbxLVHLu73WcAMrsjs?=
 =?us-ascii?Q?RHQEFH8P03AC5bFRAKvGQx8bWU8lNDqBu9lB8G1OMcMtruxHb7vJWbpnzyst?=
 =?us-ascii?Q?gb6edtxlUfRIWodY7zg5DCrwKOH9OMGL9kB6VCV2HzI/bbaMZcr8UdJk20Ga?=
 =?us-ascii?Q?RDb7miNDTFA2o9+S1WScsh+9zZtbVBWAmUsH9kyhmmkfUtcsaAjB7h2GuMa9?=
 =?us-ascii?Q?tVtw0HEcYQlNSqxFaK3KisBRG6MjngPIGsS882R9G4K113bbP5kZZxNeL4zL?=
 =?us-ascii?Q?tb8O78epeGoJlOO/QdcpjlW4vxDW0XMdwQNWoLBw3h5ZzVEZta0L+Tvd/sxP?=
 =?us-ascii?Q?X73SImXtaoCKBRuheGdI8Ggst0rc4OioQ81ET0sJOOxmxDgcUlRxHX+3y/3w?=
 =?us-ascii?Q?52uB2bUzuIQEYx8Iik27k1ASYnk5xyioHl1m9kXIh42dejEQUGY5jj2uHCo6?=
 =?us-ascii?Q?tJvrCuc8GKHVq9NanDmYshFeBVPlsUCMF4THhsUz0KRA8qTqqfzvPcO4sFmi?=
 =?us-ascii?Q?NtQzAGShzxWdYcDH3zoDyikTzs0vYujkI2i2IvHkrCC9QN45ri4VVe9Qspka?=
 =?us-ascii?Q?UMty3l1SsLlcj+E3TdqmnYiXA7qKKp1gUUK79+lYMyEIuZrBPHky2V2vxbgb?=
 =?us-ascii?Q?0dH0obIUZg5vD0nSNuAUiMmh7ssiaFE6Z5nEXqVbNaz2vebWAAA7gXvsXtQS?=
 =?us-ascii?Q?2QSgjz+C2hljBlJyI7tjtqzk8OlGxCb561Li7Hcmekl3qE30rTXtUaSiJMGx?=
 =?us-ascii?Q?w1bI8yxg06YpnYFWLKJT89j+M+vWTr7MIrisfq2aRAP7llaDNGsM2l3Jq3hY?=
 =?us-ascii?Q?wfYPI1V+L+HvnxX0odP4EeDGSACZSztVBeSmqdq2gRZB35oDit5pNNxWH332?=
 =?us-ascii?Q?fqA8kDlvmZvUX+TsqDjC7VoTQyTv/oT4Sx/s3KA2JII5tBz66RBdyDe+F746?=
 =?us-ascii?Q?cvzQmGKPPJJ/HQdBF/XOnbblLlrfZUzm7umRssTrACFxUbPk1DUCOAvkN0lx?=
 =?us-ascii?Q?Q7/KLsrDiPUoY2WmNOcMxcHPeJ8XY+Y5buk4xKS7R63pWftlr+T/HHuTO8sB?=
 =?us-ascii?Q?xdyy0uavgNSm1X4yiWZAP26/XHtaPYizseslSjZNeUf8ktHvUXodSvdU6WEs?=
 =?us-ascii?Q?pqLSvtk6ZkNplsVCzX8Qot41if5GcbTBGddmkcniedzlVmzFpjZMMQQ6HZa1?=
 =?us-ascii?Q?6ay9cM6k0yUA4TMgGWheweWaB8aq8H5R2c/gIGTxnOfa1bRP75KGaseLp7ep?=
 =?us-ascii?Q?KZos3xKTHpPuOojBDeTkMSOhr5YqvnEz9RJBmStB0p59ZR3cJPt+9zgVwcJr?=
 =?us-ascii?Q?FPx4FP3J903b9a0psulHF0BSUQzYlo3+CFytoEKEYSYlXG9XxhJpO7nUQts1?=
 =?us-ascii?Q?cAk5NN9Ik8nQfyHiUjLGtbetGVETRp46Twj2JfASP0EOSiv191vx1+QqK34P?=
 =?us-ascii?Q?yAirlpgUgiqqinPhm/6qRqG61iXGwMgwJQK6UqyaF+j2T5k56T/Yd9IgxmDy?=
 =?us-ascii?Q?tkbVEX0zNJ0dQHk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR03MB8447.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r9mfHsoZLQ56NsqN/am2qUpuvwyL86QAXvZ6edvQ5Bbc2Z9Af37spnm+Dx2o?=
 =?us-ascii?Q?UTbT00iI5Oqvyt4gPpogHsML4HeuDr94XI8nHP45Hrun823ndT9GQd+cbsaB?=
 =?us-ascii?Q?l8Kqlar930IBk91Gxw0I2Roa6NPW3eJqeRe6fKayGptHboGEQEEqpQ5CfWyh?=
 =?us-ascii?Q?Uul+w1K6ww9d6cTkFnLu04r+O39eyrvRVY7PNwLRjUPITTmu1OjPOhnsLcfp?=
 =?us-ascii?Q?ku5K0t7NtFe2R0/DSjYKdN6WH35NkRrulFWPNtZNLOWp8YoDOFUv0ER+NpAL?=
 =?us-ascii?Q?jPYTQuRwesfksKbQ4AaS6/xT+JAJjTuOMbR9Ji9EIyDxcqm6IRXMAFdrlnMv?=
 =?us-ascii?Q?4G4OYsKvV+COeEnpEdNmtcwOoPfXbJrXQxD9lluZxv2q1Ro+Hsjby8+mGP7K?=
 =?us-ascii?Q?5jWFK8Owmh/dUNGqPA/1R6nRr5bdo6m+ERQK7uOsqmOQTvn42J2S/C/CGHpi?=
 =?us-ascii?Q?woIhRJgyyINmJxq9R0rU/bWbXkyUQZbvV6bREH15kBKCGVWtvdmc9XKu00sd?=
 =?us-ascii?Q?e7/Y7ZhoIUPYVNw5BHZi+L/PXlyCrVh352W66HUDIDBXhaVvdO6boaEV4tLS?=
 =?us-ascii?Q?rhwUE/Lglu4zorh7hrGUcBd0ctois9Ee4GeQUyqxQp4dmGPst6jFDa0V0+xp?=
 =?us-ascii?Q?eBz7mM76p4zaSMrvJeqAIIACBx+6kkt2uYDHBm2oy4eENod3arT8dOxel2Oh?=
 =?us-ascii?Q?oqdmIBHicE9ZiNGOqLXxRURQbOFLjh5A80P7l9H3U1FLg69nvOnctA3SVRLj?=
 =?us-ascii?Q?h8TxpL+b9C8bj+xBmy7/iXeh8CDQEgKd+G3VFm625vlaOHpyTnG7OfXRVem3?=
 =?us-ascii?Q?5Hes1UjClK7JiSlLyV4G/SiEpjyzEBuha+U07QO0NeeqA/oStWbUMqxNfbaq?=
 =?us-ascii?Q?mNDqjM53ES2O84gUFspZ74cq2rxxD1RF3swdn3mIGzBPpGLJDCFQM2CzL4k3?=
 =?us-ascii?Q?ayX2CbNm6w0GnfSIHat+moIhI3Rb3Ul/nMBTfWW/UIfwpPKhbsgAyBXEUR3N?=
 =?us-ascii?Q?qe//JzKCW016mxz97I4Pr+KRAhnTRj7PYH3EL9AomtMfX8zZLu8LGj8GsqXi?=
 =?us-ascii?Q?kk85BxrUULnpf6wvHRDaY9L1x3rBkAm03Js3CFaM8cT3/opPZh8mp66E3P6g?=
 =?us-ascii?Q?U65DfY7uc9GNruV8hQWBIOsFKPVZXaXWzgSS0tai0zzPnVepRCmHvVjFHZET?=
 =?us-ascii?Q?kOSAE+V9KCjvU1USn6SHwdK7droQ4W48G/YyrvwSc0LQFE+sXReOfMoKVTxz?=
 =?us-ascii?Q?F0EU0HpGJB1AhW8e9Qp4WSi41XJW5FhjRyxhBaZ1EfZXxyCxMZ4iCr3cDZC5?=
 =?us-ascii?Q?CBG11zMOHTaynK8ijl5kFSU55qtJwvMVKfq4KIVizdCL2d+ycgjAfKcDXZfZ?=
 =?us-ascii?Q?CXe/fPdgDykx+FKVf2uT+J9LFTxivzHFRXiCCRIbgwP22NKgCXhGMoL0FsCf?=
 =?us-ascii?Q?ZcR67vaaZWi57oMIiUv561asvEHwXIprqEzH3hz997agf2rUwIonLR6Am2uo?=
 =?us-ascii?Q?GXKXSAC6H1qaZqPNgES+oNRVoyuQ52azYK+oaBsMVjdu3JoP7lmihwE5Prji?=
 =?us-ascii?Q?hCgJMPKo9Fr9sbMUP5eIOb3Qq/MWvf8UAFytKlVXCkvGzpAuZ8OPT8/4qLn0?=
 =?us-ascii?Q?aw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c0158f6-d68b-423b-6fbf-08de386f7843
X-MS-Exchange-CrossTenant-AuthSource: DS4PR03MB8447.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 04:40:54.5777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MsMHrhxaamtjbLYiMqFWmuCU0xTCyiBdKMvfe1dWQFKQ9u6dWXVnFDDr0U1X5e0HNl33Z4MA7UNK9wicxYbrGPhj1sxyHrWPPmRtDR4T2Cw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5308

Add device tree compatible string support for the Altera Agilex5 AXI DMA
controller.

Introduces logic to parse the "dma-ranges" property and calculate the
actual number of addressable bits (bus width) for the DMA engine. This
calculated value is then used to set the coherent mask via
'dma_set_mask_and_coherent()', allowing the driver to correctly handle
devices with bus widths less than 64 bits. The addressable bits default to
64 if 'dma-ranges' is not specified or cannot be parsed.

Introduce 'addressable_bits' to 'struct axi_dma_chip' to store this value.

Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
---
Changes in v3:
	- Refactor the code to align with dma controller device node move
	  to 1 level down.
Changes in v2:
	- Add driver implementation to set the DMA BIT MAST to 40 based on
	  dma-ranges defined in DT.
	- Add glue for driver and DT.
---
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 69 ++++++++++++++++++-
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  1 +
 2 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index b23536645ff7..96b0a0842ff5 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -271,7 +271,9 @@ static void axi_dma_hw_init(struct axi_dma_chip *chip)
 		axi_chan_irq_disable(&chip->dw->chan[i], DWAXIDMAC_IRQ_ALL);
 		axi_chan_disable(&chip->dw->chan[i]);
 	}
-	ret = dma_set_mask_and_coherent(chip->dev, DMA_BIT_MASK(64));
+
+	dev_dbg(chip->dev, "Adressable bus width: %u\n", chip->addressable_bits);
+	ret = dma_set_mask_and_coherent(chip->dev, DMA_BIT_MASK(chip->addressable_bits));
 	if (ret)
 		dev_warn(chip->dev, "Unable to set coherent mask\n");
 }
@@ -1461,13 +1463,24 @@ static int axi_req_irqs(struct platform_device *pdev, struct axi_dma_chip *chip)
 	return 0;
 }
 
+/* Forward declaration (no size required) */
+static const struct of_device_id dw_dma_of_id_table[];
+
 static int dw_probe(struct platform_device *pdev)
 {
 	struct axi_dma_chip *chip;
 	struct dw_axi_dma *dw;
 	struct dw_axi_dma_hcfg *hdata;
 	struct reset_control *resets;
+	struct device_node *parent;
+	const struct of_device_id *match;
 	unsigned int flags;
+	unsigned int addressable_bits = 64;
+	unsigned int len_bytes;
+	unsigned int num_cells;
+	const __be32 *prop;
+	u64 bus_width;
+	u32 *cells;
 	u32 i;
 	int ret;
 
@@ -1483,9 +1496,61 @@ static int dw_probe(struct platform_device *pdev)
 	if (!hdata)
 		return -ENOMEM;
 
+	match = of_match_node(dw_dma_of_id_table, pdev->dev.of_node);
+	if (!match) {
+		dev_err(&pdev->dev, "Unsupported AXI DMA device\n");
+		return -ENODEV;
+	}
+
+	parent = of_get_parent(pdev->dev.of_node);
+	if (parent) {
+		prop = of_get_property(parent, "dma-ranges", &len_bytes);
+		if (prop) {
+			num_cells = len_bytes / sizeof(__be32);
+			cells = kcalloc(num_cells, sizeof(*cells), GFP_KERNEL);
+			if (!cells)
+				return -ENOMEM;
+
+			ret = of_property_read_u32(parent, "#address-cells", &i);
+			if (ret) {
+				dev_err(&pdev->dev, "missing #address-cells property\n");
+				return ret;
+			}
+
+			ret = of_property_read_u32(parent, "#size-cells", &i);
+			if (ret) {
+				dev_err(&pdev->dev, "missing #size-cells property\n");
+				return ret;
+			}
+
+			if (!of_property_read_u32_array(parent, "dma-ranges",
+							cells, num_cells)) {
+				dev_dbg(&pdev->dev, "dma-ranges number of cells: %u\n", num_cells);
+				// Check if size-cells is 2 cells.
+				if (i == 2 && num_cells > 3) {
+					// Combine size cells into 64-bit length
+					dev_dbg(&pdev->dev, "size-cells MSB: %u\n",
+						cells[num_cells - 2]);
+					dev_dbg(&pdev->dev, "size-cells LSB: %u\n",
+						cells[num_cells - 1]);
+					bus_width = ((u64)cells[num_cells - 2] << 32) |
+cells[num_cells - 1];
+				}
+
+				// Count number of bits in bus_width
+				if (bus_width)
+					addressable_bits = fls64(bus_width) - 1;
+
+				dev_dbg(&pdev->dev, "Bus width: %u bits (length: 0x%llx)\n",
+					addressable_bits, bus_width);
+			}
+		}
+	}
+
 	chip->dw = dw;
 	chip->dev = &pdev->dev;
 	chip->dw->hdata = hdata;
+	chip->addressable_bits = addressable_bits;
 
 	chip->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(chip->regs))
@@ -1669,6 +1734,8 @@ static const struct of_device_id dw_dma_of_id_table[] = {
 	}, {
 		.compatible = "starfive,jh8100-axi-dma",
 		.data = (void *)AXI_DMA_FLAG_HAS_RESETS,
+	}, {
+		.compatible = "altr,agilex5-axi-dma"
 	},
 	{}
 };
diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
index b842e6a8d90d..f8152f8b3798 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
@@ -71,6 +71,7 @@ struct axi_dma_chip {
 	struct clk		*core_clk;
 	struct clk		*cfgr_clk;
 	struct dw_axi_dma	*dw;
+	u32			addressable_bits;
 };
 
 /* LLI == Linked List Item */
-- 
2.43.7


