Return-Path: <dmaengine+bounces-2246-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF2E8D85F3
	for <lists+dmaengine@lfdr.de>; Mon,  3 Jun 2024 17:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 506A4283A06
	for <lists+dmaengine@lfdr.de>; Mon,  3 Jun 2024 15:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7B012EBD3;
	Mon,  3 Jun 2024 15:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="be3XoV3e"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2053.outbound.protection.outlook.com [40.107.13.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F086E619;
	Mon,  3 Jun 2024 15:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717428215; cv=fail; b=nOptLJ9DZrHvYmIw5BPsdgBsmtLg3Yuvr8kTcS1qJBLmZul/U2lX95iJzo/h6pgMLrBKAx9RIHOZqzXCCg8hbUSbX51eRt50uTETKWchDk5KipLMgmXrCyOWfXPDC0CpfS/fjXzABK69F2EwVKQ+Z+7M4GF+620nSp5pNFpdRac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717428215; c=relaxed/simple;
	bh=MFtbZEszoucBOxaL9lKLBe4xABYw9wV1+pzyzDYxbpg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=lvLyUq1jeI0JuvyI8ZmIP7GUXbjqcRlrdB8Vvy60iFCn2hu0LasRG2Kv8W+oLaN2lwJnRhAzE1jcv6XApC7WgA3Eo7/3AvD11sCLNfy/an4zKBKF4b/rKPLwAS8KTeljl/CBhEFsJb5aSDO2HBqeuuiLzffEFxnzxIs1o7W4zys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=be3XoV3e; arc=fail smtp.client-ip=40.107.13.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kKVmWGiB0dZSWv1oNCLzFnc8Gv6aniN1dqljVg2g4t/HJAYdcCL60lq0dgqsHGoR19wtWlgA5pxEYwvkB3HGfvb8pzBVe5Yiyb8RYLoFRo05Qhea59IL6Jbl36McKZnILXD1j/zBMdOWwpcUyMCN5PlP0p6VrBIuwectUnS2k5Q9AoR+Adc5Ys9t9JvUluggTynOCL8iGNS90RG8oB2dDmJUF5tmNmXG4ZWJVVZgDCnL3QbPd+YRJAgqhiZAzuWHumDC698porhuHvznX4WCw7d5T6JIsqIkrZyyPobNpyj0NEedTA5eoZsX/HousJY8w6OETWblM1OhgkpGxCwWNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qg8msxGWes7E4J8rZBoQO3c/1eJ64BOHF9/VN0Tz4BI=;
 b=Ap7pYR5mM3CJGsRGeNdNDhlGgmJ0hx9sP2VHW7MH1mooOSoOvNnFVe2yp0LqxQcypsYxIx3xhDsWXvekaypMoIpg3Jmo+Ptv9JGbO3bMC4HitUmTuE3LyfjORz14kyRhPvch+Qhdr9q7TVXD7OpXhR6HyMJlJKN/zpYse1FuHnPiF0em0OcyMrCxrkvBkH9XVm+/aMhqv4LdLpEnxqKVuzhCmoBWJoO/63MO/lFKWSIIESrs3KPPJhYkNzx+hJOWGjwr6kFsupspu7oMFpIrPNaPFNXnQxephOLlDSpLePXB0MsCpu6qEAoYE14KD3qdTzv8PcCmTWiCrVYchlsu5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qg8msxGWes7E4J8rZBoQO3c/1eJ64BOHF9/VN0Tz4BI=;
 b=be3XoV3ek74fplkJvGKqiRqn9oOROJaTwGdrLUNUHBJGe77CqpM73hvpZ81ZkM4ITXLuMcUquiVxobavBEy5BeJjmyP5QMJPfPXb8Z7VFqqnzXi7raN3uD2x8I8bIHQBNYAfCnnaIvKMjjmAqTS+nv7nh6i4JDhb2kjKDSqYI+Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS4PR04MB9243.eurprd04.prod.outlook.com (2603:10a6:20b:4e2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Mon, 3 Jun
 2024 15:23:28 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 15:23:28 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Vinod Koul <vkoul@kernel.org>,
	imx@lists.linux.dev (open list:FREESCALE eDMA DRIVER),
	dmaengine@vger.kernel.org (open list:FREESCALE eDMA DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH v2 1/2] dmaengine: fsl-edma: request per-channel IRQ only when channel is allocated
Date: Mon,  3 Jun 2024 11:23:15 -0400
Message-Id: <20240603152317.69917-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0047.namprd17.prod.outlook.com
 (2603:10b6:a03:167::24) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS4PR04MB9243:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c191bbc-fc3e-4e9f-eb1a-08dc83e11ec0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|52116005|1800799015|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tpnJMHirqVU3x2fIxn4tMHNsRpEcdOKlgyktwGXoRdlv/UCu/ND4V0mXm0HG?=
 =?us-ascii?Q?pBlVW2hoHlng/fgG5A3cRMZ9kFl6bK/CVZrm6pK4ubyWkNWjUlc+SY5WsBoY?=
 =?us-ascii?Q?3uZJmboe5SgO/U16OSOZUPOf9gB2YdKL0RizwzmFa44gPEhAHCWQbv1G+VXu?=
 =?us-ascii?Q?XGImwigD2nvrq+3jVN+es8vDJ/fI57RrVUSci744sLvzMqP4K1JqLFFuDMl5?=
 =?us-ascii?Q?gtyWbBgc1EefwqcHsuqqii5N257GU3LZe00+RICojEsILYdUPyb0YWz+W/6f?=
 =?us-ascii?Q?7VllLwjiqb66K85QoJN4jNxFDUnrwq/KHzLHNq1IAVdfqEf6W+JEtRRz1b5v?=
 =?us-ascii?Q?he5t4i85x+7pgPKVCWVSLPwM1XXNfqo3hK6yXgYvRP/rMx9+VEBnlB0wXj7H?=
 =?us-ascii?Q?foiaJK38U00cT6IvCt8jbQyfROBomeGpGCvM5+sLGNHpnMClWMOC4IDw7Sp9?=
 =?us-ascii?Q?cQIy+Tp4yoor/PuBFu/JdMtjqfJw44Lphs8u5XTu84h3UdXcK712w3yJ857J?=
 =?us-ascii?Q?MdyB2psJtgIUdrhCKKgesc5sUnyf2lihcI644r5asWxBLUjYRj7s/KUvxysU?=
 =?us-ascii?Q?+HOjGTdXWZdRrtrqYKvVHSjiei5pm/YlKiWuGc7VJzhso3u65EzyHUhH65K9?=
 =?us-ascii?Q?C5KhnPsDQTqj/CFRQOB/Le8HbmV6wl/W9Ss1suu1SjlxNZhDpIlFgk3esNSp?=
 =?us-ascii?Q?bt/vhjKKsi4L5pxXpB33vFrs+IWR0XwyOtOZqgfV4opNmcscSvYAOH2uUFPn?=
 =?us-ascii?Q?1YGi7mE+jfwTDGFh90NVYILWYbmjMQZxMP79VGkK4SiODRWbVpH4yHPPoitq?=
 =?us-ascii?Q?34i4u5Sm4ZaUaTNB+48XK56OZavwUvnYi8HTC7kjvBYALa6icaHU/5ho1g1V?=
 =?us-ascii?Q?rpGZsNLtcoSyVXosPP+pwHN3Ei7pKhIYL2m15A4iGKpo2EWj8TQvqrkZhCvL?=
 =?us-ascii?Q?DrdX8Dlpr6nHr9iMBUXH5HrWvFseIfQQYE4O1+/1aVG9Zu7ugtISj7bA/fZa?=
 =?us-ascii?Q?0qhtwnWeobctlkgJDU7XpTm1Cs05yDSxeDfHteO0sy00RBEal3poHgW/U/TT?=
 =?us-ascii?Q?e6ZMRu00lxIt6wMjtZtMTf3qYX9O9Vx4qYaAR/GCoLm2aVlRfKmcTq+OHkT/?=
 =?us-ascii?Q?JF7hdlSWU7hrcpfJH9b8096pfRwZK+8AGvB0GQDiPmNt74164EjueqzYFy8u?=
 =?us-ascii?Q?I+8TtTOwCLCU4XDuwM4exFuY0TbcrfIANm2joFOLOplWZrC3N46AUKabE6ZA?=
 =?us-ascii?Q?B2XtLmFNMcLRlXb3EiewTrp1cS56z6l5Qum5SQOyyy7+KQfRLFsZsdTcfnIS?=
 =?us-ascii?Q?njteTVqtG8v8qC3YOhIK72+GEaTrnd1jkSdUOj3cSrKvbw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6xrbuavkf1eqPdjqNYSrGogdI9GcMcA5JsP9+4hZS0m6hCX+x1W48WhHXqFY?=
 =?us-ascii?Q?J0AW+b/BLUScv2syKUkgUUCN5D510GiAkLkUsnjGHvl4Szy3nAXSHhSqRgYv?=
 =?us-ascii?Q?wYSOOmJ6WI92xqhRT72zd3WitkCyRGhY11acVu4BvSuGIdfspBjWo+/0Eslx?=
 =?us-ascii?Q?EMVmY0e2jS1SatR5uOhxhksmiTRyxIcG0tTfRNJhbopXsi0NS+/kOWSGKYAN?=
 =?us-ascii?Q?7UEvocP1YGBsq0Zc0anOuQEcjVhJJ2YUjX1CxLF3QoFjgcrNVK9bNVzIvEDF?=
 =?us-ascii?Q?qCZ0qqmmqL6Z5dLRfP8X/eoAvXAngHp2/Oj+kpVmwaUEUtoFSh5TNImeLG2r?=
 =?us-ascii?Q?iglR/prktzlleoeP9rvVeQaiSLl2JkgZ40Mf/eqv1vqNbQmWjQsyHNkoSx59?=
 =?us-ascii?Q?6xo+utCqb2bcEuiSu95BdjZRlXjd40A/Tlx1V2zGrOYYHii9i3VToZFPg19/?=
 =?us-ascii?Q?a5kzdjCKO4A2uanL8CX1pnjKhmJ39UXC1B8ZCa/6agZ3rERntJYHCDyAhXXy?=
 =?us-ascii?Q?Hbq1/IDEWaUPqvk0jG4w2Ew+Ii1B1xZNyplbG3tErqQWlq49WO3UtlNL4n3M?=
 =?us-ascii?Q?JslLQh/TuN5uIjqfUJofxA/zdpbQOlxmBPhQlGdT+CucmiqRgSd0BxHpFM9i?=
 =?us-ascii?Q?5h7Vgkq0R7s7LGv6phI93IIHqC1pbEG0WoR/sv/eECaZXFa3Oh8X7S8CDWzs?=
 =?us-ascii?Q?hY49uT3oAovm1hP36JAJG5q8c/FsTNERYW4xQO9dc9m/r0eRLy4GRo7jCYR6?=
 =?us-ascii?Q?m4GaUXlKS239zEnhNI1wubCjCPurN59kyr86uvCHe5g/x6QCmu8B/xnPA7FR?=
 =?us-ascii?Q?Ih7DbuRvccvVNLo+zsRFa9Fi+c2bhxudlQiCUW0/V3XCc9Z+GKJi+nevi7rh?=
 =?us-ascii?Q?+jjyq6d90ncfyCnm0VY9a0JLDl9aD9D8GR01SVXyU8LeFmxzIpbu3gh9Cl3a?=
 =?us-ascii?Q?S+3u9keCXZ6p6VTzSYKhPSOXuEhXeS2m3nld9z/8osRLX+LduEpdXQRJdtJ0?=
 =?us-ascii?Q?H+LSgRyBWbvDurjIjqQlecVGX0W51MfX7KNb3oL5R8fbnZ6dG2q+73L4dDIP?=
 =?us-ascii?Q?qnPSVhAbvg6LFATnkwhIOLmaPPMrZxcq5eF7DsElqBvXi3UXHR5gymJeu+fT?=
 =?us-ascii?Q?zYwzRMFY2go5VSUoWG5TLJX4jA1/J01szI8hajofdOh4ubyPIAZgfYIXnzju?=
 =?us-ascii?Q?moby03XN6pI0dkpSuJDyU/D1fhR4kM3TmYbXziFpeKBL4ixt9oyEFRwDkOZI?=
 =?us-ascii?Q?ErNJspcpQ61O10YV7WqorFH6wWqZ8OivFTYnrPMAxBI0ORidwXnwqCQE6QsF?=
 =?us-ascii?Q?6maxjZ2w9CfUNof9NFUiO/P5uF6X2shcWOY5DTLBW8mfR0MsgLPzdcf88BXV?=
 =?us-ascii?Q?RmndRT+55aEb2n/x47pFkj6RoWllACArR32LVx91vFW71unx+HjO2u3aUIpU?=
 =?us-ascii?Q?8pjXo9xnqg5emr6d6+iulyGOb3gKbNfl8ik9KMtA4CfKVh1JAe6v5kQ+ayLT?=
 =?us-ascii?Q?zc6miUtteYG5lc/BJf/t/FD2Hgo0cx9W4aXL4EJEvZSxAQUfcdudJgPVLbOM?=
 =?us-ascii?Q?Rp3Ue5ggsASKcpxSR2SytbOxAnlgNWT+mKPJX0XC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c191bbc-fc3e-4e9f-eb1a-08dc83e11ec0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 15:23:28.7925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: So0bVwWmhB5IX3JFrJzxcwZeqdpQLB+TTO8QL6OQHfCgZP/hPi+YQiSZ1Q0+hxpidxxTaxHzcEri15sisAZ/zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9243

The edma feature individual IRQs for each DMA channel at some devices.
Given the presence of numerous eDMA instances, each with multiple channels,
IRQ request during probe results in an extensive list at /proc/interrupts.
However, a significant portion of these channels remains unused by the
system.

Request irq only when a DMA client driver requests a DMA channel.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v1 to v2
    - none

 drivers/dma/fsl-edma-common.c | 15 +++++++++++++++
 drivers/dma/fsl-edma-common.h |  1 +
 drivers/dma/fsl-edma-main.c   | 29 +++++++++++++++--------------
 3 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index ac04a2ce4fa1f..91a4c11b7cbfd 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -805,6 +805,7 @@ void fsl_edma_issue_pending(struct dma_chan *chan)
 int fsl_edma_alloc_chan_resources(struct dma_chan *chan)
 {
 	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
+	int ret;
 
 	if (fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_HAS_CHCLK)
 		clk_prepare_enable(fsl_chan->clk);
@@ -813,6 +814,17 @@ int fsl_edma_alloc_chan_resources(struct dma_chan *chan)
 				fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_TCD64 ?
 				sizeof(struct fsl_edma_hw_tcd64) : sizeof(struct fsl_edma_hw_tcd),
 				32, 0);
+
+	if (fsl_chan->txirq) {
+		ret = request_irq(fsl_chan->txirq, fsl_chan->irq_handler, IRQF_SHARED,
+				 fsl_chan->chan_name, fsl_chan);
+
+		if (ret) {
+			dma_pool_destroy(fsl_chan->tcd_pool);
+			return ret;
+		}
+	}
+
 	return 0;
 }
 
@@ -832,6 +844,9 @@ void fsl_edma_free_chan_resources(struct dma_chan *chan)
 	fsl_edma_unprep_slave_dma(fsl_chan);
 	spin_unlock_irqrestore(&fsl_chan->vchan.lock, flags);
 
+	if (fsl_chan->txirq)
+		free_irq(fsl_chan->txirq, fsl_chan);
+
 	vchan_dma_desc_free_list(&fsl_chan->vchan, &head);
 	dma_pool_destroy(fsl_chan->tcd_pool);
 	fsl_chan->tcd_pool = NULL;
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index dfbdcc922ceea..c5a766da02b88 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -172,6 +172,7 @@ struct fsl_edma_chan {
 	int                             priority;
 	int				hw_chanid;
 	int				txirq;
+	irqreturn_t			(*irq_handler)(int irq, void *dev_id);
 	bool				is_rxchan;
 	bool				is_remote;
 	bool				is_multi_fifo;
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index a1c3c4ed869c5..82ac56be2d832 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -65,6 +65,13 @@ static irqreturn_t fsl_edma3_tx_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t fsl_edma2_tx_handler(int irq, void *devi_id)
+{
+	struct fsl_edma_chan *fsl_chan = devi_id;
+
+	return fsl_edma_tx_handler(irq, fsl_chan->edma);
+}
+
 static irqreturn_t fsl_edma_err_handler(int irq, void *dev_id)
 {
 	struct fsl_edma_engine *fsl_edma = dev_id;
@@ -228,7 +235,6 @@ fsl_edma_irq_init(struct platform_device *pdev, struct fsl_edma_engine *fsl_edma
 
 static int fsl_edma3_irq_init(struct platform_device *pdev, struct fsl_edma_engine *fsl_edma)
 {
-	int ret;
 	int i;
 
 	for (i = 0; i < fsl_edma->n_chans; i++) {
@@ -243,13 +249,7 @@ static int fsl_edma3_irq_init(struct platform_device *pdev, struct fsl_edma_engi
 		if (fsl_chan->txirq < 0)
 			return  -EINVAL;
 
-		ret = devm_request_irq(&pdev->dev, fsl_chan->txirq,
-			fsl_edma3_tx_handler, IRQF_SHARED,
-			fsl_chan->chan_name, fsl_chan);
-		if (ret) {
-			dev_err(&pdev->dev, "Can't register chan%d's IRQ.\n", i);
-			return -EINVAL;
-		}
+		fsl_chan->irq_handler = fsl_edma3_tx_handler;
 	}
 
 	return 0;
@@ -278,19 +278,20 @@ fsl_edma2_irq_init(struct platform_device *pdev,
 	 */
 	for (i = 0; i < count; i++) {
 		irq = platform_get_irq(pdev, i);
+		ret = 0;
 		if (irq < 0)
 			return -ENXIO;
 
 		/* The last IRQ is for eDMA err */
-		if (i == count - 1)
+		if (i == count - 1) {
 			ret = devm_request_irq(&pdev->dev, irq,
 						fsl_edma_err_handler,
 						0, "eDMA2-ERR", fsl_edma);
-		else
-			ret = devm_request_irq(&pdev->dev, irq,
-						fsl_edma_tx_handler, 0,
-						fsl_edma->chans[i].chan_name,
-						fsl_edma);
+		} else {
+			fsl_edma->chans[i].txirq = irq;
+			fsl_edma->chans[i].irq_handler = fsl_edma2_tx_handler;
+		}
+
 		if (ret)
 			return ret;
 	}
-- 
2.34.1


