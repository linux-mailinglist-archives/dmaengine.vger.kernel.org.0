Return-Path: <dmaengine+bounces-919-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD13844497
	for <lists+dmaengine@lfdr.de>; Wed, 31 Jan 2024 17:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 350F71F2E7E7
	for <lists+dmaengine@lfdr.de>; Wed, 31 Jan 2024 16:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5C012BE8D;
	Wed, 31 Jan 2024 16:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="B5CddxTw"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2066.outbound.protection.outlook.com [40.107.6.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA76F12A145;
	Wed, 31 Jan 2024 16:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706718817; cv=fail; b=aLqY/pasNAb9UD0s9Zmqlto99aKbq7h27qbGPaX/v7PMlAeAc7+wJXjHfYbvb4ow/n1Uzzo8C/980MH6wyp+8Ej+F/eS7PvaHOd7V6xDxiA9TpsaD2AGHMqfZxZuUicv5MnXRuYuBTgAeGd58pJoLUwXWvQRr5pudNburbwiGBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706718817; c=relaxed/simple;
	bh=+1urk1vsF5xfCYYWzWQE/lyw6Tovca1mfkINlfV8MN8=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Mf1gpoKLqBwSTXsxne8FmOsyBwQOSavJf8Zga9MnFz16xKXSTHNZbZ5DibPTRd3ajCSC/Sz6p0G/KWRFL9rzovpe03qyBSUdIoBuhFHRKw+1haD3FCEEsNlDItnf0shYM66f+TywkEm48z4sucKDQz4RmsbyHE81uxM6i7xoe7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=B5CddxTw; arc=fail smtp.client-ip=40.107.6.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TnbGswE4ciX2qksCdQFt7tJmoeO+Wu6VQySGhuDge8FYx6+n5JpLBpJsX3Rp5xfyumLzZnWLr/ScZdeybXV4UZMnn9Soas0jQ5nrDm9MOhqQxRE0rdAMRz8pBFkBWPGZ+hdl12VDBJV5Eya0IRWn1TuWyuveB3KdahYnLbgMF68cSJKSJbkLH8tB8HzbADTpimb/YVnUpG9mK2OOR72VaVh49PeT9xuC203A3TYEP3HnJd47zFy0ZpWv41XSnP+SEoNoYt1O1ssPEphkhh4xi/RzAD5cWuISENJa4XQ2tPMWk3C0SUPz4Qis0jdFh7/+N4NxdZCxr0/KI8OqDC1ipg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T5oHcMxoP6YTkKo/eiFf5661pgcErMc0NurojzoPGrw=;
 b=UChyUrZI3jd5ZqtVuAdu2h71KysFEGgYp/VN4HB7s8zA3m182Xm9wFBOr5dW+UvcgDDFJORJiuX46rX8lcPyQmJTEDS33IvMQAaSi6aYBQrFi3VZCh8dgCApeuZlavVrfpkMmuLz0WGsslDljNLtmSbULz/4dy2Hs43PV081tkE0pHC2ritpxhP2hLR9XV0m+N8aCb3f65GvV4mWfRs3zbDaun/hFdvGK7bGn4JRWBlkMAnRep3SClCxszT3tagDGS7OFfTFR/1SpKZkL1a6D0dpzwMv/+Mq4OEudsONVG8mY7cqh4obvw573ZlnXOaz3v2jQM/xd32FPvw4EXXJ/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5oHcMxoP6YTkKo/eiFf5661pgcErMc0NurojzoPGrw=;
 b=B5CddxTw3e6nuIEqRl0wuQOlZmHQTE9+N29Aws5MtN8fYKdAt1kCYjxfaBrIF15PKpWnzmsHaCr4Ni4x4VGU/r7nRnWCpxTsDchLEGCip+eOMd+olv6bm19d3VjYedR1rue2rn0kZoNbuo8k4/GF+oijeGjMR5xLj9XRUbtHtvw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM0PR04MB7108.eurprd04.prod.outlook.com (2603:10a6:208:19e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23; Wed, 31 Jan
 2024 16:33:33 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 16:33:33 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Vinod Koul <vkoul@kernel.org>,
	imx@lists.linux.dev (open list:FREESCALE eDMA DRIVER),
	dmaengine@vger.kernel.org (open list:FREESCALE eDMA DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/1] dmaengine: fsl-edma: correct calculation of 'nbytes' in multi-fifo scenario
Date: Wed, 31 Jan 2024 11:33:18 -0500
Message-Id: <20240131163318.360315-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0119.namprd05.prod.outlook.com
 (2603:10b6:a03:334::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM0PR04MB7108:EE_
X-MS-Office365-Filtering-Correlation-Id: 704db99e-a2f6-4fd1-4e0a-08dc227a5d5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bxbWQgfkh1hlz8DZZcTIGjcMLdWhV7DCpCuJV6eL0oXmzF9sRngEwufi6Id7BWjPqOVsPQOKICsIjnEY1lAZnvSxOp8Hb75ODvX3Jb8AIxVOLwI0HdyYCfWd8/MEPJ92i/fkeEAeF8qcXOltPVx3HWMcB/JyA+Z0XN0L65bmGhHjwTJsb+aBTd5WmA8UUtsjzg3LaUUSeFHkaAjaQ3cp9YEUAYrnTWoHWs+CRkPZP+oQ1ECmbrWvvklz/si5mBnCrgNXpTouvC9EFQOYaPeiDH9jB2+NvTBh+MELEHliqKt+NT2eGQ+rou95qglGhs2VEh3HMKItGm/eF35ml57w1E8ZC/EoQQx6NctDFkUjhYk5SoWigldjPO7RZnK9sX3VgQRa6hkBmDJL4rs8wONh7Cn9DUo2SPKg+4toQDHVgctgfLYX6CCK/icEwnBdf9cbXr5m37j7cm6Isl3mcn97VQtuDqHclBbpodpbhFhJzGMO+tm5ramJfbJa3lFeJxmH/dcLy8Mh8a4CFCiZJC9fm2Nq/6iDLccpUmOSpTUlsSrF85kNSpqCLRzIn/pinJCY1HgW0+NbUZTTfv0jDk3q1sbXyo/+hwK7H8fw2/b7OhveU/dfTGMAh0NHWuUewiXG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(136003)(366004)(39860400002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(38100700002)(83380400001)(36756003)(86362001)(478600001)(8676002)(8936002)(6666004)(66946007)(316002)(66556008)(66476007)(6486002)(1076003)(6506007)(26005)(2906002)(2616005)(52116002)(6512007)(5660300002)(41300700001)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?arrs9/CF+V9hlCPYogNR/imVp9Gzy2rSXW5sqdAr45xrFWKmAP8gHAlM0GOt?=
 =?us-ascii?Q?uOoTYZfqkmYI4YBMC04aTp5B1TiPgczei+QGi3uxSjo8Ex0PgzZxcrTfsyXo?=
 =?us-ascii?Q?cVeTrDGailNRXJL3HDYluskLQcQHHNjIM9UukB6/euOsR0m6ZcPj4fNCHkBm?=
 =?us-ascii?Q?CJ0Dw811m2P+ATZdZwb83NGO0wwTpU1OWOCpsMNgaaSjuSzybr2qxMwkiuUS?=
 =?us-ascii?Q?snQICee/slBshAtA/f7QJCw75QGNgTll7ZgJeeC357Mew9vUwlFlZ2MA8hxQ?=
 =?us-ascii?Q?BR/ChlfufTHjPlCqRdgho2BHi5dBT/qFIuQrmGVrIno0yfgXeYrprFFIspCg?=
 =?us-ascii?Q?L05VRssKtu8i/PxDt5p2W88dBfnyz9t0e4Nip2rOoWlm9bYAxS2w6ieoQnoZ?=
 =?us-ascii?Q?OHt12Yl1zlExbCqWFMVFCJAAy2+T8OSUvjkNmf9j3cc8OvlXkCAnqpDa/Tk4?=
 =?us-ascii?Q?+OUqPR5UfcJ0MjilCBh6KfrP5TzqvMTg+7PrLV4OddNLpLSmkN1rz9X3cJId?=
 =?us-ascii?Q?FMnE526BtXxPQQm4SjDOWRoR0YIpYHdVirHqa3SGS63SaaP0FUfl6xhb4Fco?=
 =?us-ascii?Q?aBeHvsPdtrT/MopF65J0RuLh9dy7fpyCKOGlCx2ujr2Z3IVDpVaNPLpFzj8h?=
 =?us-ascii?Q?BQkWxlV1VQUWNc4lcndrQz6hX3ckyunalQDG8g9+uULB/pIlc84W5hnVxy4w?=
 =?us-ascii?Q?kMZZx8rrTnhlYqjgLsEpSlh1IwiQV23cVlehIVWvoxWNrE6PdFB5nNi2EUPk?=
 =?us-ascii?Q?NDE2vPVJdj+GJkOcz9iSp2uNODaC6udEv6/YYMKt22fVsfUegfWESGYUWU62?=
 =?us-ascii?Q?lcpKnx4vejyA72nUwlJEO2KAd9ltc/PciIKbXH7LuzLOEbvzcHQ2cs9WGyT9?=
 =?us-ascii?Q?XD57MoffsyMfXb0egpE0niPtRD31sSnz1HpSdxruY0vlA6Df+9yL0Q0ElhO4?=
 =?us-ascii?Q?OqxVdt6mOAxbwz1Wv1FMTn/MdBtpGgdmmXJxofbhzPc3EhFjixTqsK4UzO/e?=
 =?us-ascii?Q?YvcborRu5uYglqc+YHs5a2rxUTdNUatgWq/NKtqJiCy9p76zu8dOE9Tjb1M7?=
 =?us-ascii?Q?zJtblxggivfJBz20ZHHYrHYvoIVC0Tk2he+jKPYPMpo8wdcCbTpOJZK2D4MM?=
 =?us-ascii?Q?PMTZusQm28K5x8dVekbKYjnEAHI8afslSzOG1RC0k/EiLrQ+QIaAV3L0tPtK?=
 =?us-ascii?Q?kUc2Z3T83EOBglY4RTZIIWMJ7eKDA/3EJA8TO6zJsO+h5SKySFzZDDpNRptX?=
 =?us-ascii?Q?GzfFaUgd/WDF5Py+OccRZYDMZF6P+/b3uA6qUx2u08HMKLa3G1HOheoOWrk8?=
 =?us-ascii?Q?D5/T7PO/MX4NDy5sK7B9/c2A3yc0OHzUupjS5dDHmtBgoX3CSORpJktLNC7B?=
 =?us-ascii?Q?7Z6k7hjqZag/eITXFMixVe0WYZBFUHC1zCEnOOhBVLrhoASi8e08wI54dh0K?=
 =?us-ascii?Q?ANLXDbhnq1X/plLo+awJKLKDTcJjWhjJjPhaYY/brrX/RGB+7hTYWOpry9J8?=
 =?us-ascii?Q?Z4hXFn1dWUyjfuaZFGmnFi/SWkVaMdoEdyXRP0uVs/bRmIQThqwgoI3I6mMc?=
 =?us-ascii?Q?vKajUBjpwZmEd4v7PmGCsrVsoYhRHZ1QfkkG8xy0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 704db99e-a2f6-4fd1-4e0a-08dc227a5d5f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 16:33:33.1313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +QdPH8TBfuh+4lR5MwaXHPlx7y3vg6rV9Ox8kZgZHWc0LFmf+4lNWq1LYawREN0nVJ2TmhpzxjvWgYGtMJqFdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7108

From: Joy Zou <joy.zou@nxp.com>

The 'nbytes' should be equivalent to burst * width in audio multi-fifo
setups. Given that the FIFO width is fixed at 32 bits, adjusts the burst
size for multi-fifo configurations to match the slave maxburst in the
configuration.

Cc: stable@vger.kernel.org
Fixes: 72f5801a4e2b ("dmaengine: fsl-edma: integrate v3 support")
Signed-off-by: Joy Zou <joy.zou@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index b53f46245c377..793f1a7ad5e34 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -503,7 +503,7 @@ void fsl_edma_fill_tcd(struct fsl_edma_chan *fsl_chan,
 	if (fsl_chan->is_multi_fifo) {
 		/* set mloff to support multiple fifo */
 		burst = cfg->direction == DMA_DEV_TO_MEM ?
-				cfg->src_addr_width : cfg->dst_addr_width;
+				cfg->src_maxburst : cfg->dst_maxburst;
 		nbytes |= EDMA_V3_TCD_NBYTES_MLOFF(-(burst * 4));
 		/* enable DMLOE/SMLOE */
 		if (cfg->direction == DMA_MEM_TO_DEV) {
-- 
2.34.1


