Return-Path: <dmaengine+bounces-1622-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE1E8903D6
	for <lists+dmaengine@lfdr.de>; Thu, 28 Mar 2024 16:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 364AC2956D1
	for <lists+dmaengine@lfdr.de>; Thu, 28 Mar 2024 15:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E1312FF95;
	Thu, 28 Mar 2024 15:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fl/Zz0X2"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2085.outbound.protection.outlook.com [40.107.20.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47F2129E81;
	Thu, 28 Mar 2024 15:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711640926; cv=fail; b=C+fVbZevV65/p5JrpuSfMl7o4CWKSOCY0kf9bhP0yhl9lOv8A8neS486EeMfnLwv7C0Qx//ZrqMh4GUSYnBjb8uWWEZeEvWY2VgD8lCh/BcglBqWZ19zxNDUj3zQfN3f46LEeDitA9TFjrrJnAcCwfdJZLmWgP0YLX/K8Dulk2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711640926; c=relaxed/simple;
	bh=HFEf840cChStFOd184B+wpOQkKXRGELS4FqAgblF82I=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=rjpS5ngWkg6PG4+vfPKcOnB9o9jb1g2M5ELUw8b09F9xN5PxmM0IcINHekemnTBjGc7pg5BRCFLG99g/5F5mMUa7DPr6Kqcb+8zBjI9ajLGB16CIf93WpsK0SdCcizL+rWi8hqprIRUhOw4nRbOP6POO7snkAc2VH7fQkpURoW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=fl/Zz0X2; arc=fail smtp.client-ip=40.107.20.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nr7ffwfamO/vv0AmqUY0OvDvB0d5WK26sAQaTLszlsIj3m3iAhjB1Qm3u4W4RSp6ewS8kPfPDR+1ETCVWRvrSV9AWGvxnfiqtHscx+uAWRjIySVu/d1Isyd8y0Rah5X8+ZiOlHajXKgkCa988pTD8sw+dOne91j0FmbPemAWyhUT3TiGVqZZb71GohQJQwOOScGe5pnqiTsy3X+BkyTqFphvgzEPN2kAbB6qCtoW6PmLv4kihTpIpUeFmIgh2kM/aQ0KiVQylrj9DC8h0LFf/k9WhHnV4XWw42ZUKpl5axXx5Thg0TRp1q0pmivAlmBWfT6Fb4tnVLyNlOOoEb6nbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WkHe/8n3QtMDjxbwwuvhKNkqGevFly2mGicqDv0ysUo=;
 b=gPTzDOhEII02JCy5Kk6C2Y/81ytmX1yUUbJAMQicl/iLczN6L3zwq4K2jhGY+Z1QXung1e3XO82nGsn+E4X6vMqgV4cpWuUvBKWBMJXpY7ycEnR4lPtcPoXe1h9WzEIXbWw3/Ns97kQQmZ5eQc7uMj6bhIkaYwAkMy/8jhSGx2dz1rnmim2XJFpATtZ/oXJfgCGVPdHly0cI19+8wEEadSXKq6rvF5nulu7EbHA49fbSEtQeuHrjvAtHx4L3nDaCUtIzXFem1K+xjHqNQ3Olfk2HI5+ji6mVCRtr/C97Okf556Lt/ndS0caKEytbfWMXgS1PHF+MdiQXBf7ieLWLTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WkHe/8n3QtMDjxbwwuvhKNkqGevFly2mGicqDv0ysUo=;
 b=fl/Zz0X2Jol+Bzr6JSog259oYtdqw/JJzfW+dRFB+e80SHTlENlSyM6Lc0WNDEDbJA12KaiBiDdw0Lwt6oVjzMR4RlIrh+CB6VUzHYWAn/iWOtZDh3WxUr+pAKaF1CshLL83Y87Wl5zm+GukBn8VVTI5RThlEk0w/4w7O7wRLgM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10273.eurprd04.prod.outlook.com (2603:10a6:150:1a5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.26; Thu, 28 Mar
 2024 15:48:42 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.028; Thu, 28 Mar 2024
 15:48:42 +0000
From: Frank Li <Frank.Li@nxp.com>
To: imx@lists.linux.dev,
	linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Li Zhijian <lizhijian@fujitsu.com>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/1] docs: dma: correct dma_set_mask() sample code
Date: Thu, 28 Mar 2024 11:48:26 -0400
Message-Id: <20240328154827.809286-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0015.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::28) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10273:EE_
X-MS-Office365-Filtering-Correlation-Id: c3c970c6-8270-4f40-5ecb-08dc4f3e8b10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MhXqa9Oj0oE+hw+8KShMDyCctySdW2mBu+I0rrreAZjZOOxadSNtN5G58ltVEKQKec4mGYb/wwc7w7NHiozs88QWKO8KAGmDQU9SuVQlgJNCS5idpyJTPqpIlyK6s+UgHyuSKKDM5TAJ3NtzNowXPVbNzvpBQpE2mtOolwpPzf4LErASi77qN5qWhFgD5xjZqlk/CSuleT2jT2pFbhdVUzGtDW2eBiY7jslOfMk65WUAQWlLbSg3R8XNdtJyfgRiyVPaHxEI09JEMOBq4baiDMMOsdv0VPnPBdn+jet7MvI3sbXSfCiQQYsYN58EJRrwlS12cuNDvHVf4J66OsCJ8Qno37Gf57ljATZ8DkRkdnCYN1aqRvnnRcD2wRBEHEQIyrCnbbjkIVLHH+DmPRf4X7Fb/V+445F4CJlLrVpELHprWaAZSg2a0lh66IqhBQG5lvM1zV5Z8Wg/tJdSWKp5+sMVlER+NYMsolXXRINmgWvmTbRCCAZZSiSkccU14bYtb342nXFlY17YucIvbHstVHQCmcJL67W4edbeMOkncJXh/HL65LXwrL9HC1Cf8yeh48zB2i5n90/oitVv+oDOREPj9/d/uRE56egAWPiYHWv0krsQi+37Kr51CJ33lZ6VG0H+teJ5AZ1eL+rmdCC8FP19Aw+Aj6UfsuDeApvpO5a1t3GukCIs2vxnIz6NrtNgKb7s7/C2avZza/lI6U38WPqu8GkedES+QoYwhbhx5rE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1+wYiuPjONw3ixlMq1LeyKjHSiQmEckqmGDq6NB34Jwh9BRhW6HRpD3JS9N+?=
 =?us-ascii?Q?O2V0IZEp2lfZxsxJCKa5octwdDbCTH9XXyfNJT4948q1KEQGpOPjbBetJvDz?=
 =?us-ascii?Q?sC7cYIOtZ19a3yDgLxBzw+qmAwMnPfhtms0kDnhnCwYnQwb+d7kO+KI5YPbi?=
 =?us-ascii?Q?C4yYdgLYqMOBv109gi1xFpBLmOZV1B6DCAthmZ8L7RMbuhFAHJqvS/lFL2tf?=
 =?us-ascii?Q?g6gz9yA86DM03RdQg/UbB2/isffSyOxeh+6Bygu22COTMNdQoVg1Pkla4iqG?=
 =?us-ascii?Q?7fQCQPi0onZye/9IBbgm1P4c/tzKxaQi0Tg2gTVVdXWhRi1+J2+WWxpYy620?=
 =?us-ascii?Q?LXS0MloWJhSI/HVl+qXEDEpFYyops6SHb2eZtkU98WfrZuQb+q5enWgHSaZS?=
 =?us-ascii?Q?Pjb6aFkEXgK76s4jK0Yu4sAE9/i5lA1XBuBndyJ7/5Mf1otPtLcFlb2u/pfC?=
 =?us-ascii?Q?sxFyBp1xmKjgjrZa9zGmCX7EhGVQopXia3b1EMQp77Bz6wBb6xXnVmywp9qb?=
 =?us-ascii?Q?xLEaNxlsLzZXTU6M3455wX9W0hc0fHHuxvX4jICF887unFW0+xW1yNkvERdq?=
 =?us-ascii?Q?TGy6MXH0Uc/RVp4yl2evuuAZxtaGbScPvTV8HT10BOvBcTXD9XV851xRkCP4?=
 =?us-ascii?Q?4O537acMRLffJ0a9RdSvCcycU2XLn7/kVXfqRUOteVicVNzeLrOKq3saRgyT?=
 =?us-ascii?Q?8OEntZIrtmgDMMAbFPznfQufs3wonEPJb7qy+iaLGYBVgNJbCfYV7SP695TX?=
 =?us-ascii?Q?LR7h4cKYG504JayvqQn7DW6xkWpTO2m7JygjnCOcTtvubvp4AZnMNrsUie/R?=
 =?us-ascii?Q?znlI5P7ieCaSLSENZ+cKBxvWH3gGyig2TF4VwSbdCh1HhV2DjYtzsk43LmrA?=
 =?us-ascii?Q?cdF938ec4Zm4+UG1EdtR6vkbiZAFf6yAJLJnAQx9fzLhGfUbFLhnf3eHEubr?=
 =?us-ascii?Q?6wbWBRpK9tlgjtiNi/scuKvwMXvo8OfgECL3Xv4uKN4l2TW2LP3B80KdtGh+?=
 =?us-ascii?Q?pwVYptAykrKkCsmSj4LLufLLHZmyjcdvYYW3GoV+e1IJDGpvsVKdFXvzH7/E?=
 =?us-ascii?Q?3Tlrh08G7E98ednuathASECx5OEYrgGuQ2H70BXFtrpfhFGOQX2wodEH8+CH?=
 =?us-ascii?Q?sS4tg6mY5v7j65hBub3R7pxS4OBoQ2rESv4fRrIU74U1keRI1zoMB/irTejt?=
 =?us-ascii?Q?YfbJ7POpVGdllXs1P+R89CNijBUFx27KXlu6MZXjH/Bd4MBtkU1WTrb6Ayf/?=
 =?us-ascii?Q?QY1MM+z5CmQ9LIR3XIyWK8Z8j6PY/fpPZCPaIVRYGWZ0RbcwO2rHbfoqQNbZ?=
 =?us-ascii?Q?78g9xzf844iV/7XvrJ+h6PNabHrjWVgEeQyWG/SqHyesorXj+LxrUt4J9lF0?=
 =?us-ascii?Q?ZnxgdVzP4qdHBgA0xqzJ+5B3r/Kn00WrAi4q39WJ1QZF8BeuTM4Q0ufXVGgb?=
 =?us-ascii?Q?kaz6R4VzUzjZZbWcDUHwWSCe8AN9DZqkhW140ge45xr9n9UV1k0gMtFNGM+b?=
 =?us-ascii?Q?4j9k8q2s3Cjrh+IzIWP0koZl3ECLmpSWkrsvGjnUkbkH/8oN4tB1BBFScY6l?=
 =?us-ascii?Q?GMCNxSnww/6L5ewe10MFF40xe/axkzarolwHeJGA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3c970c6-8270-4f40-5ecb-08dc4f3e8b10
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 15:48:42.1019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YZ37RoKBorA6FCWoyjJj07QaD2rThRhs79DKSEhcqvKzhbx/of0x3o3XWxKa7IoYUZSg4Cx7FXfgk8Eqr/eZ+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10273

There are bunch of codes in driver like

       if (dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64)))
               dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32))

Actaully it is wrong because if dma_set_mask_and_coherent(64) failure,
dma_set_mask_and_coherent(32) will be failure by the same reason.

And dma_set_mask_and_coherent(64) never return failure.

According to defination of dma_set_mask(), it indicate the width of address
that device DMA can access. If it can access 64bit address, it must access
32bit address inherently. So only need set biggest address width.

See below code fragment:

dma_set_mask(mask)
{
	mask = (dma_addr_t)mask;

	if (!dev->dma_mask || !dma_supported(dev, mask))
		return -EIO;

	arch_dma_set_mask(dev, mask);
	*dev->dma_mask = mask;
	return 0;
}

dma_supported() will call dma_direct_supported or iommux's dma_supported
call back function.

int dma_direct_supported(struct device *dev, u64 mask)
{
	u64 min_mask = (max_pfn - 1) << PAGE_SHIFT;

	/*
	 * Because 32-bit DMA masks are so common we expect every architecture
	 * to be able to satisfy them - either by not supporting more physical
	 * memory, or by providing a ZONE_DMA32.  If neither is the case, the
	 * architecture needs to use an IOMMU instead of the direct mapping.
	 */
	if (mask >= DMA_BIT_MASK(32))
		return 1;

	...
}

The iommux's dma_supported() actual means iommu require devices's minimized
dma capatiblity.

An example:

static int sba_dma_supported( struct device *dev, u64 mask)()
{
	...
	 * check if mask is >= than the current max IO Virt Address
         * The max IO Virt address will *always* < 30 bits.
         */
        return((int)(mask >= (ioc->ibase - 1 +
                        (ioc->pdir_size / sizeof(u64) * IOVP_SIZE) )));
	...
}

1 means supported. 0 means unsupported.

Correct document to make it more clear and provide correct sample code.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/core-api/dma-api-howto.rst | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/Documentation/core-api/dma-api-howto.rst b/Documentation/core-api/dma-api-howto.rst
index e8a55f9d61dbc..7871d3b906104 100644
--- a/Documentation/core-api/dma-api-howto.rst
+++ b/Documentation/core-api/dma-api-howto.rst
@@ -203,13 +203,33 @@ setting the DMA mask fails.  In this manner, if a user of your driver reports
 that performance is bad or that the device is not even detected, you can ask
 them for the kernel messages to find out exactly why.
 
-The standard 64-bit addressing device would do something like this::
+The 24-bit addressing device would do something like this::
 
-	if (dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64))) {
+	if (dma_set_mask_and_coherent(dev, DMA_BIT_MASK(24))) {
 		dev_warn(dev, "mydev: No suitable DMA available\n");
 		goto ignore_this_device;
 	}
 
+The standard 64-bit addressing device would do something like this::
+
+	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64))
+
+dma_set_mask_and_coherence never return fail when DMA_BIT_MASK(64). Typical
+error code like::
+
+	/* Wrong code */
+	if (dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64)))
+		dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32))
+
+dma_set_mask_and_coherence() will never return failure when bigger then 32.
+So typical code like::
+
+	/* Recommented code */
+	if (support_64bit)
+		dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
+	else
+		dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
+
 If the device only supports 32-bit addressing for descriptors in the
 coherent allocations, but supports full 64-bits for streaming mappings
 it would look like this::
-- 
2.34.1


