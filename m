Return-Path: <dmaengine+bounces-926-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BF28462DE
	for <lists+dmaengine@lfdr.de>; Thu,  1 Feb 2024 22:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 159061C235A2
	for <lists+dmaengine@lfdr.de>; Thu,  1 Feb 2024 21:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09AA23EA89;
	Thu,  1 Feb 2024 21:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NpIFy/Mn"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2077.outbound.protection.outlook.com [40.107.249.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14AB3CF52;
	Thu,  1 Feb 2024 21:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706824230; cv=fail; b=IJHsHvyQPakeLhCpU7m8L4YJHx9Y5v2U85e+VdyzFnlt5uQ5jXaxc2B/x7EL9o2yqFLydeCjiT3bjEbbN92Ku1U3HgEUrnJwmI+QRVdWIm00ejW+0Oso2rHbTlm/OTjO/5I7ea4axSKh+4mR5q7KNycg7xIce9M9cUo8q1dNKdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706824230; c=relaxed/simple;
	bh=+sgzXZ6wrai6p/OJVLcc/9mU2C9z1v5phrmmohegIvc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=RcpDviLMDrhh8fUWEdw6ligXXO99mE+YGT/+dFvtKMbEPioui2LwjSGHP30nk7FgU1IQ0tT9/9izJq4TBRzfhl5TzExw/hJZjMamgIffRs3jDNuVjcXNpiuAq2YWQbSGLUWX26k8MOgS5BRu9Py5bp2JomDOg439D710PbUzYds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=NpIFy/Mn; arc=fail smtp.client-ip=40.107.249.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jeemQG24Ru26SstA/JOH8sjNGSVlZiVEVRSElfnMa7cQfHK82AFujH9HJBue7GM56cmKlOE4h5pnUk92g/Ilbj4Xh+OL0PEQeDEH4FmWRSALk5txeaj2AYqwfWpePo6CT+h7Jv+4paflefwywlsLCozNASGMzN3fYuagrozw3xOwdYkzTNCyeh4+6ZVQGSiGqGmHFx3EPa36fJARfD/X9h35gpDhgoj8hXrUzg7AnIVyIp5/XJcv8N6DEN4dL+3MpZQtUDZInHdC5oBmDO6MAGk7kHL2wUqXvTtiOgdFF4pEJRh8tGw7LMvS6Ndm5Q9tT8h2gwqVGQYwTiOSTSLrjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2fgD/OI7XfZudyXypwCaYEqf83+SYsjJwljVuc2alok=;
 b=kixCqBX1fA6EJQyrnETzb5sMWwzxdvRwia4qKYdzWKLmLutNOkVVWxVsjynXJ1IqST4S+8BfjsCjnu2kTis/ttNVt47SmuP3wZiQIBLfbW/CLg2j0bPP3bem/gjjUD4jYUd/cqcej6HUY55DB2G8SHrBEaAypX9Yp+RzKbdwmB7VVmDnKtQNoPdOwnYsbim18HNEIg2Zb2SJUDcxtRl3C538eDdyyQYIhnGpKGPjYr08pLr06VYzpLS8XvatXr+L6FgEWwldRKRctvPgoQhYh0ynvvxPsPwVvqj+r/DJaC9uDWkX8ZFmyjyKEtPWovKNnmO257f4MpJ2cBIFX+6PGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2fgD/OI7XfZudyXypwCaYEqf83+SYsjJwljVuc2alok=;
 b=NpIFy/Mn4mrbwlIYKMBgGZzCFJI1MM13wpzCddfhJymHz+qS687BPlewo3qu/voF34qTjr9PZZ7g/mj6eEcDRn7F3FmN30pM7ZJnpT61dd/85QjU27Qm+yS/Bi59RxI5+EDTsHJm5UVIpJGos0nIWAtwCWeOwXiYKzEv1mpWrZU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AM9PR04MB8588.eurprd04.prod.outlook.com (2603:10a6:20b:43b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Thu, 1 Feb
 2024 21:50:25 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::9b0f:a9d8:1523:5759]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::9b0f:a9d8:1523:5759%4]) with mapi id 15.20.7228.029; Thu, 1 Feb 2024
 21:50:25 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Vinod Koul <vkoul@kernel.org>,
	Wen He <wen.he_1@nxp.com>,
	Peng Ma <peng.ma@nxp.com>,
	Jiaheng Fan <jiaheng.fan@nxp.com>,
	dmaengine@vger.kernel.org (open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dmaengine: fsl-qdma: fix SoC may hang on 16 byte unaligned read
Date: Thu,  1 Feb 2024 16:50:07 -0500
Message-Id: <20240201215007.439503-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0080.namprd03.prod.outlook.com
 (2603:10b6:a03:331::25) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AM9PR04MB8588:EE_
X-MS-Office365-Filtering-Correlation-Id: a14b217e-165c-4e61-009e-08dc236fcbdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	euabv4t4y1f7nyIxvqHwWa7zDmPl7ZtwILh9aAb42CSYEuZuULYB7CcMIrtcD2otI2IpHU9GQeym4HbrYUBGYWdkVj0YRe6iuOTGIvEIwPFMlpF2T7zfTXvc2+bI/M49k7wSMBOD3mZNGDLDnUNleQ4BFuSizKU25rJSFaaikLYYxzvs0hTv8SPegNZRGN7ceX6mrESJKRUJThkIKB54It6QnXLwS8gu9zN/4hw93d5Up0MDhDG5OQedhu/iiiMIdd+aRVBp5VHIMzFivBWult8pg/28wSHsrqheduMXk3oHMF4dUUeUJI0WsmntSycFC3AEMDQZWXdCuqcnHnpjGpDI0Nqfs9zV1hSyoc4zT18C/9KDFaBbR8wuQqSIMe/joUrqraEWoNJ+WkKjXtGK6S3vQAUARtXFlxeeCjnl2U1PCcCvXWvmJfKFhPOX3KJ352rUK7zKKeslMWCCrcQC6LgL5OEkqMZLeD698yDrgGbCyVxGL9X6YCZOkGZSh26xxnxd4R0sRevhB28bVmd95QNOc/xh2m2xYGJVDyqgDoDkuXRDD6lubTFeHWAHFMizLGS8dV8/3X6Zy3XYuoilGc12qISdqopwKkbSZH4E32dSEhs1RzniyM+vVpRu4pE9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(376002)(366004)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(83380400001)(86362001)(41300700001)(36756003)(38350700005)(38100700002)(26005)(1076003)(6512007)(2616005)(6486002)(6506007)(2906002)(478600001)(66946007)(66556008)(110136005)(316002)(66476007)(6666004)(52116002)(4326008)(5660300002)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2txkl33G31AGo4q3pTvRy68lCRhbo9HmS/u4hJKcp++nQ7Q3kCTvsvEu0W1s?=
 =?us-ascii?Q?7QWddg0RTndI6ju6EC1j2j/aGNa7fUCOR6N29Z/Z1WJmz7Z/U0oYhoq35IEY?=
 =?us-ascii?Q?fCjnIg3vkePRPo7XSpBsvtXP1zVHxw420kajfwCoaD+/gUJlGmt8YYsXc7lf?=
 =?us-ascii?Q?CPBKNA6h+khsCQq4r8PZHJEiEYyytMGS8XoCWZG377RMN7bQdKnq6FiQ2Cs6?=
 =?us-ascii?Q?j4PrUJxDlV2+lo9ddpnTcdMYtc3ShLAzigBnYnOdxuDg5U+ReP/sW2iwaEcJ?=
 =?us-ascii?Q?93COqw57cOIflqGu0K/FApE45m8C//JASfSS8nazzRK2nu1KU9dR0JcaZ12p?=
 =?us-ascii?Q?R65pgCy3OJSPGp1kFJmWZ8LRYYPSZadbdgPsSynQsJEQAHLe/2rkFf4HvKvo?=
 =?us-ascii?Q?6HV2utq9ZgZK6ZA+EovLfF22twWHutz0shMALSSjD4ABVE2NPfWa591ZGtdi?=
 =?us-ascii?Q?6wLFk0r0PzoPumjE43ZVgPg2J+Y+he+1jLkrz7yKnAZjNwNN3CzurHZfNnes?=
 =?us-ascii?Q?N4SedQf9Tt4LACwIeWDjVlbD0pMI+jADBWfcPNtL8qBBtBFhRooSUC76Mu5l?=
 =?us-ascii?Q?FGJoFvS7XRR0Rb29lpkAgOysrTvtf66Yud3xHeRD8ABG3jzMpg11yaherK8E?=
 =?us-ascii?Q?IWSgbUMrrMX3PVwLinUtNUAe01lM55bKJ1wZHI02qPh0i7AWQ3F4+8eVxfcV?=
 =?us-ascii?Q?KrAfoD6bat5+AvXRuRf65yvKsA9K+jw0qnAz3p1VZGHIjzBq8PyLbxu/pFsT?=
 =?us-ascii?Q?IgK+x3dr9fQgEDNR/EQiUNuAWuN9uQxj607pVj4pPLQHsBu2qWK3q41hcLXQ?=
 =?us-ascii?Q?hsMhTjiKTErpIZPggrhbW6+2FOEGXZ9zn/CUZdigTyI1lWNxg3AfK26i6IF+?=
 =?us-ascii?Q?UqzhXJhdxYMa1KCyxSzs2WMBwcWtu14zV76Z+zGQJ57ZcPAR0qYL4utaUVrf?=
 =?us-ascii?Q?3S1/fV8eCOVms56UpOCz3LMP10BwxRZUdVZclEBn1Q/jxEOmKcVV2ijD2n3l?=
 =?us-ascii?Q?axxMngj+XPtwdXK3vdBRRo5rQZJF3x707dFx88/aFu2aPeoi8MGMmiz/uyGU?=
 =?us-ascii?Q?dwFEOugyTpDz4wUTCnb4gVh3VWzkmr4cIMnbwVEM8paRm5UdJSrZUDHwVnB/?=
 =?us-ascii?Q?kuFAdNCgrq0oS4DsvxiEHZrUPRM+heHSdX+xpBbr0M38rrVC7E4Y2pN4mNGd?=
 =?us-ascii?Q?1G6qtKh3yD/fu0fkFABRO1IcZkdYY/jy+CSzJNMUWKD/r0XjtCotTCuKW4F4?=
 =?us-ascii?Q?2508Ki1cuLC3n9WC2ThqIe8YK3sywU9KVXGoiqdXO48MLUJYPwnoKZOSvA4X?=
 =?us-ascii?Q?BSp4jStA+y0rePzpP0qYOeEJm15kB2UYuk/6hN3x+BShWl9c0pFolCSo13q2?=
 =?us-ascii?Q?3Hry8KV7xKwbM3yTibSSDjQA/RQCrU+XuMvEfhWH/BpjBdThOJCqZfO8aC0k?=
 =?us-ascii?Q?GBu6SOzyQk2MLijJY6rqOos57ikVfaUnA5na2iFkcqR3sBVslm9zcd4BgFnh?=
 =?us-ascii?Q?5B63dXmGkYr1sLUQY65TZFhY3XJzWaRYXxG6RRWuOshFCXXeouQfKcB3XIIT?=
 =?us-ascii?Q?cZuBssbaPlWx/e/pr3U=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a14b217e-165c-4e61-009e-08dc236fcbdd
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 21:50:25.0053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GRhFbE3glhya7CDFlR8azY891ZUfGxBI0k8KZRi2LwQ3QNNf4CspLVULITBae0YlXEwJHmzSAD8OlHQyiq/J6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8588

From: Peng Ma <peng.ma@nxp.com>

There is chip (ls1028a) errata:

The SoC may hang on 16 byte unaligned read transactions by QDMA.

Unaligned read transactions initiated by QDMA may stall in the NOC
(Network On-Chip), causing a deadlock condition. Stalled transactions will
trigger completion timeouts in PCIe controller.

Workaround:
Enable prefetch by setting the source descriptor prefetchable bit
( SD[PF] = 1 ).

Implement this workaround.

Cc: stable@vger.kernel.org
Fixes: b092529e0aa0 ("dmaengine: fsl-qdma: Add qDMA controller driver for Layerscape SoCs")
Signed-off-by: Peng Ma <peng.ma@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-qdma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/fsl-qdma.c b/drivers/dma/fsl-qdma.c
index 47cb284680494..11d10dcd8b45d 100644
--- a/drivers/dma/fsl-qdma.c
+++ b/drivers/dma/fsl-qdma.c
@@ -109,6 +109,7 @@
 #define FSL_QDMA_CMD_WTHROTL_OFFSET	20
 #define FSL_QDMA_CMD_DSEN_OFFSET	19
 #define FSL_QDMA_CMD_LWC_OFFSET		16
+#define FSL_QDMA_CMD_PF			BIT(17)
 
 /* Field definition for Descriptor status */
 #define QDMA_CCDF_STATUS_RTE		BIT(5)
@@ -384,7 +385,8 @@ static void fsl_qdma_comp_fill_memcpy(struct fsl_qdma_comp *fsl_comp,
 	qdma_csgf_set_f(csgf_dest, len);
 	/* Descriptor Buffer */
 	cmd = cpu_to_le32(FSL_QDMA_CMD_RWTTYPE <<
-			  FSL_QDMA_CMD_RWTTYPE_OFFSET);
+			  FSL_QDMA_CMD_RWTTYPE_OFFSET) |
+			  FSL_QDMA_CMD_PF;
 	sdf->data = QDMA_SDDF_CMD(cmd);
 
 	cmd = cpu_to_le32(FSL_QDMA_CMD_RWTTYPE <<
-- 
2.34.1


