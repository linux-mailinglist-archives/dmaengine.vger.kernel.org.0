Return-Path: <dmaengine+bounces-3918-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2252E9E6948
	for <lists+dmaengine@lfdr.de>; Fri,  6 Dec 2024 09:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2151282E5A
	for <lists+dmaengine@lfdr.de>; Fri,  6 Dec 2024 08:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4481EE010;
	Fri,  6 Dec 2024 08:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="R5o7K00T"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2049.outbound.protection.outlook.com [40.107.247.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB651E0DED;
	Fri,  6 Dec 2024 08:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733474942; cv=fail; b=LgQ0IB9HwBUdGNZspgN4SRQH1O6gkDIyZmGDV+TyLKytJ/pv8pAFd4XT3L12NPuuOQ7IBh4o1bgFXO+wLh6C7dDfNCXzLlPOmo7ijlc1ifA59eKpXX+EKXrWakdukQlzHw/quTiwgt5kmNqCFS9i5hv96DhvKzp36jX95zk9jjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733474942; c=relaxed/simple;
	bh=WqouGkyyNK5aErJ1GW+A7KYFU+t8cRBaI6mb2tAx9/M=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=nL4Xv0wiJ5eUzqDwnLY/kslmTMWSF/dLf/l3cRTx7yIh0g8JXp7KOgIZs0P71J4xkkD0A4PEC2eyEBr/fFzFGymfrl2w29DfeTdQl1F/t2tfeNGOLSMd7qKRwp9GnDpw5vyWusIF2u+rr6NJacXRWEzCx547HfoHrNu/HlRx40Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=R5o7K00T; arc=fail smtp.client-ip=40.107.247.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T7gbdGMFFb9y9LGvW7HHdw+kr6qX6kSIzgmdRsPJJQFSOELS1gvvFAjR9yafXrJaqsOCofUjceBilzEvtYI7etOPxjNdFNiMSXVUtBzYGFjf25/x40ZMxVOc2H8IHLl83n2VkrLkVVm7y/A9ryy5DxAOzecYPes5UK+0PPIEY3xWD5yO+hYZ1AQP5tUiCVstY35vxL3ZW6AwSpDY7C7bF23bBsyX5CxWyXCzc8MXfI/Q7or/RyRoq2HtSQdTUyRMi2afeMWF7IuLKvAOxxSf52KUnKPg05DF8iTmi9w91RxAd+TTVnmYLvelEvITnPQnVOEN5DaNSAZUyCwzOQUiKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUppYOrY8WhOUuPH8pE8kHPU4JffIS5CwuyPUMWlDiE=;
 b=PmV0zL8TojpkrWmYAQj21ADHwnjv8yIUk4IYhgb42Gl2tjoCmR8osveqkEUJHYvGiuZCybUPSIQgWrAV5dkmX0Cg1HavppaXhGet9B1rCnc8VK9OW0U6r2C/NLCILkFuiMapxMcoUKXmEif5nV4sLXbXXVn5RIeF8C2dS4h1IQC1FRr0ktTmXX5fwMWJKSgnZ/dpQl04yjEVYI7VVAvmhIVnS/7aHxZmbmH9sA8wVPqxIPug+wtLBnXF4XRNFXR4tgTAo2QbzKGLaYbAD4B1qwtsKcGPX1jKb2rdMHPBtYICtD27ACisWTwbb/zDKRCeSZpKIfAKNP1HWacO/4FFIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUppYOrY8WhOUuPH8pE8kHPU4JffIS5CwuyPUMWlDiE=;
 b=R5o7K00TXaP8soSoQFy1DlzXN7W0hwGQzlLsizM23qpRBMnP0/4OCOfnO2KK1f2g2DpayVeuJ5OpTLJfY090ezo1lIpJ65ctyX4j8fFklOHx8rDxfBdpiMqHfOxQ1NCSx9uoKBWcuW+bbEI+XTUqE/P3Zas99lDvWZDtQi9Z8xy6wcXeXpMSaGuh6Hum7FcZLCd3zHNE8R/XJUqPHv8Mu/nLiuRgHgOXfPsT9At02Oa6hs1FSy6/eYy2rjEy4j7SqWraCVll8sak0295M9ic9fiQ//fILEf+RNIhlUZK/v2qWGDmfhUKh3XrbP3/XQLA1CeAksSjP6w9AXNeV2lsSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB10301.eurprd04.prod.outlook.com (2603:10a6:150:1dd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Fri, 6 Dec
 2024 08:48:45 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 08:48:45 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Frank Li <Frank.Li@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	imx@lists.linux.dev (open list:FREESCALE eDMA DRIVER),
	dmaengine@vger.kernel.org (open list:FREESCALE eDMA DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 1/2] dmaengine: fsl-edma: cleanup chan after dma_async_device_unregister
Date: Fri,  6 Dec 2024 16:48:15 +0800
Message-Id: <20241206084817.3799312-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0223.apcprd06.prod.outlook.com
 (2603:1096:4:68::31) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GVXPR04MB10301:EE_
X-MS-Office365-Filtering-Correlation-Id: b916d4cc-5efc-460a-ffc3-08dd15d2caf9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fsQ9U6pzrd5i0E5XP9ZQxjJJq63j4at+HN1Hp1049bSG+Gw0ItyjytdhR23E?=
 =?us-ascii?Q?ckwGu5rhJKhxEq7jsIZvuqElBT0skyIpJ31TMYBmq8di4wmvMNzH1e+U/eJ8?=
 =?us-ascii?Q?9WNotWgY8rZcXXqRWEj3VDdMxOq1JI/mnawOPR2CjO57cewmLjcC1EN290zN?=
 =?us-ascii?Q?VJ6Qd/ruwqJmWzCzc/wqOO/5jtErofRS6Czua9Bc5SZ1AAkHnE2ZKmilDmLB?=
 =?us-ascii?Q?t5LihjvMf6ofVfHgbmq3NvTVwOpvk5fiHcMjIF2iCMdNOzj/aYIjWx6f3yEf?=
 =?us-ascii?Q?eLjqCkQK5MYPJaR5FsGyFWIaHqX43NBxhx7UKRaKO3dAY7HIuKd2vqs1ZXzQ?=
 =?us-ascii?Q?eD0FJciY0r1pvgRMamBW62eleNoB+OK1lZQeQDllk/12CYXxqFk/l9J9Q7eO?=
 =?us-ascii?Q?/PFqBAuvSv7HHfL2nY2qiL2jhXcJppJN8x17kc5gKQptUeBG8eMnMFRwWkTY?=
 =?us-ascii?Q?5O42WG6rogqU3kFm/Ep6QSS492R9sWEbo6uQ+xa3HTKrxen6k6q9guQA6qso?=
 =?us-ascii?Q?2FyCINrzG7Cn80HL9j6/n1+hJBhtsFVX8OVxgQQioyWpNIvxSLO2g4E4pRxO?=
 =?us-ascii?Q?gMP3duEgz9fOSvQqyp/7rCsOJfGqxJXV8+m9NnABKo2Ujnzw4SFTAy8WtD15?=
 =?us-ascii?Q?l4nkVwaD7nskQmMYyBU3Oyfl731+6mPgn85MYhNZMvpcWoLyDkLW/XJeP7ud?=
 =?us-ascii?Q?tgZFiau+A7F1rNc3GTHxirn1f7IsbHrfNxhvtWLajSpAQwOMAw1JIMy7lNFa?=
 =?us-ascii?Q?FIfqiDISKu1Omig2ZEgHENtsqyn4glArK/61oEgsHLL+B0+tqnE/ucA2QrHH?=
 =?us-ascii?Q?9Wrj7d2N2xTM/zpcwcMkna2CQkNCDhMZw/SyoECQdQkeKSrgfTlcgD7A0Qrx?=
 =?us-ascii?Q?wPxC6D0YJJ8RpuiZB0GhyJ42LmUiuOQm7bdXbZpc6/jd3NfRoGf9kaKdtOsk?=
 =?us-ascii?Q?mgT82XpSk1q++MMmZEUoC16q5JRtoIShmEaZDDH6fK9F2joL3aKJMw2kAPbF?=
 =?us-ascii?Q?JZ+jELF926yotubc3+NNX1cL1DqLdJecn4XPvPI0RDkq6p4hpgPyhrY55HgP?=
 =?us-ascii?Q?3rOwCHF6bPFf4diXo4iUvETGWg/Vda0ppmwedajs71O1mZOHUvFv2L//lxUq?=
 =?us-ascii?Q?IIsSMhFbDjJh7gCiWzsb4wJ/VyJ3A+bk+i9pT6ZEGd8I1JvqDyk/EAMtwV7K?=
 =?us-ascii?Q?mJqVZhiySfi6Zah+VksxZDAB/i1odNRMTTWBjgTygvY35Byq5tXIUlM/JPq4?=
 =?us-ascii?Q?iRmsL1C1Bi/xDBYDyOdC6OWruNv3Qd/S2mvOX7pwtMPoTht1Szr7XgBjDgoR?=
 =?us-ascii?Q?DHWevnkbcnGigV/QRNgyEE+cGa2wkjUmUuSslQGWOU8C/Jy6sxmXKSNWujb1?=
 =?us-ascii?Q?WFP2MoZEgNQsmYQ4AjxnFsBbGQ6gmhN9jAaBr+OpyDNZVixBxg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7K9Y5OGKa1O0HBCCfAZLUGHNRkeusSYwJbTDERne1pyp+Rbvdhr8BUh1gVUh?=
 =?us-ascii?Q?niC890SK2MGMwVdixrWzebbU9u5oIwCtM4LNJx1boAACKC7cmbv+6ljcwvaI?=
 =?us-ascii?Q?kVQf2mWWkOhh5IJcaucQ8JObBPvxtxnb49hgv/hOU75BGgt/hPpsBibejA86?=
 =?us-ascii?Q?rroNEfXM0Q8kuPIH1E+mHhkE2WZC8hq2DtJul8MG41jgdP8ZR2izTW9859Y5?=
 =?us-ascii?Q?wMoOOVDIarUltBioJGqeeH5YHXqxvGIXMA47FprfV7HjZyw8GlqmHv6vOZSv?=
 =?us-ascii?Q?ZgrqQ5ETHF+m3QEBHoCMwJjrItrb095jLH/+oQrW4Gw7YT4hZFZcwRep45FF?=
 =?us-ascii?Q?qXvugWPsjVJDB9S802p9dalcqkXp44ErgaatoQ9XBjEHOjT3hGk8P95wi7uH?=
 =?us-ascii?Q?BSHGl3RqTgIh6/APb0zyJ0idAgPAwroVEwnPs9GJAEyrrPNOX5l91u3Qoyrr?=
 =?us-ascii?Q?evvftYT7fvevlzre8NNHqXsQDRS0rwzpgL5k+ajquGCVdOUzTYZ62YQ/Di3E?=
 =?us-ascii?Q?K1NgK9BRzt/TPX0SWsYGLan1TcpLDJZH0QVcgaArkgCcV+ji6VIODDD9zbve?=
 =?us-ascii?Q?5qqm9SjIhhssPtgH+OJZPhfNSOqOhsG6Z239ZswQkoU7nVg7o2XrWrIeX9Gh?=
 =?us-ascii?Q?YQu/w+UuejzEru51TNjhG6acl7nK4siX7XTxW4MSqwGojM/rrxTm63+CzoOz?=
 =?us-ascii?Q?IXUsCbaN7Hs+MROXlcH4879XU31FvyahBv0a347284ZlBsBH3wrTkfbhu6FG?=
 =?us-ascii?Q?qxfQ05dFHfteTNAW3Fl5ojc0/jmk3KyhbHvHupGZf7+ssXuo6NP09svuMUuW?=
 =?us-ascii?Q?CYqQZKWsJmKTF60qen0DYDJ45ioWWVwSBUxRxFa4HwXLKUOrdCS/Q3gDmZd8?=
 =?us-ascii?Q?AhMHQKKKK97DieKEJvzFX6ljLk9nmMd5EbX+oBRNXmnodK45O70U1nljK8Oz?=
 =?us-ascii?Q?ZsTcrC+AtNUcGrA8dEiBhEFnmUVFt2ah6tzDomkK841eTJxHh6lXKNiLhev2?=
 =?us-ascii?Q?3c4XhdNTPQx/J/9dsstuA0ap0HD7hSQtez1o9TsVkGMfL0FSmtLjRzlw0NtK?=
 =?us-ascii?Q?ubKYGzMpxJNv+TIKvhi4nLBOboHvSxAat/tWmapQgPu4qr3Cte6WOS0v2Ow4?=
 =?us-ascii?Q?kfFUMJcRN6u+4fLYfPUSop6C2wMLGWfzhiowjEboI/UevPUF+7qsWMX8s6er?=
 =?us-ascii?Q?gWEUYUXHUF0NtsBGeFlBDLvhy3gyFqrbT78ykHJzoX6STfFK9+12DoNr8jdC?=
 =?us-ascii?Q?mOqIH+1zdcgUZu46nZRgoD7WlXNS/gzzt8NsAR3zRxkoXfxlhl1WuGbeEi70?=
 =?us-ascii?Q?nreXQQk195UPPbUjR6//1Tmgi/jsY+ho/w6jhNGCfA4bwKQe0uG6c3Y7rYy/?=
 =?us-ascii?Q?OwzaNthR4vKOirtftYXaDbtwB6i1rBAHVHyZ8wxlS5vnS4qlkJ335VHolW0p?=
 =?us-ascii?Q?r1M0BBeEvhGXBMkV1IrlaOJggIh/jEFaC+8q0KaXYs0zupkisPTi8SPH2YuU?=
 =?us-ascii?Q?RgQV9JqCfQ44iNyVdSnK3K6/fg0YOUGWKWGxpDQrUaSjtuSRC0bGdYn4JXNs?=
 =?us-ascii?Q?5WSW5S/q6Pyk4mAS67RZElXZK3YzQ4OFBLacYC7h?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b916d4cc-5efc-460a-ffc3-08dd15d2caf9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 08:48:45.3267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VOQdu+4uiDpQ/h1D61salDfLBQGXl6zsmmKOLImHhUyx32oFF8fK47g4gQdfLsK4zdwlJgweXW6bLztAR0InOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10301

From: Peng Fan <peng.fan@nxp.com>

There is kernel dump when do module test:
sysfs: cannot create duplicate filename
/devices/platform/soc@0/44000000.bus/44000000.dma-controller/dma/dma0chan0
 __dma_async_device_channel_register+0x128/0x19c
 dma_async_device_register+0x150/0x454
 fsl_edma_probe+0x6cc/0x8a0
 platform_probe+0x68/0xc8

fsl_edma_cleanup_vchan will unlink vchan.chan.device_node, while
dma_async_device_unregister  needs the link to do
__dma_async_device_channel_unregister. So need move fsl_edma_cleanup_vchan
after dma_async_device_unregister to make sure channel could be freed.

So clean up chan after dma_async_device_unregister to address this.

Fixes: 6f93b93b2a1b ("dmaengine: fsl-edma: kill the tasklets upon exit")
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
V4:
 None
V3:
 Add R-b
V2:
 Update commit log

 drivers/dma/fsl-edma-main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 60de1003193a..3966320c3d73 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -668,9 +668,9 @@ static void fsl_edma_remove(struct platform_device *pdev)
 	struct fsl_edma_engine *fsl_edma = platform_get_drvdata(pdev);
 
 	fsl_edma_irq_exit(pdev, fsl_edma);
-	fsl_edma_cleanup_vchan(&fsl_edma->dma_dev);
 	of_dma_controller_free(np);
 	dma_async_device_unregister(&fsl_edma->dma_dev);
+	fsl_edma_cleanup_vchan(&fsl_edma->dma_dev);
 	fsl_disable_clocks(fsl_edma, fsl_edma->drvdata->dmamuxs);
 }
 
-- 
2.37.1


