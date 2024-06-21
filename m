Return-Path: <dmaengine+bounces-2499-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0828291229B
	for <lists+dmaengine@lfdr.de>; Fri, 21 Jun 2024 12:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B68331C21FCC
	for <lists+dmaengine@lfdr.de>; Fri, 21 Jun 2024 10:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3FF171E4B;
	Fri, 21 Jun 2024 10:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pKmEaza2"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2083.outbound.protection.outlook.com [40.107.14.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BB617167B;
	Fri, 21 Jun 2024 10:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718966441; cv=fail; b=NzmPgydl2UBNrHOBm+cT2OiRVLoOpnWTlA8JZLGp/P1qxi20s/g/lKNOMZgVqqXPhhn7zY/hjNiDBgCfnxdjDtpLITuTk6cv2KtjrV69RQEnl9augW8FtP7TAdtcLhBVy7atvlTItJdzqjLMmINLL5M+Gnb+Pk6/VBL2n8g5rKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718966441; c=relaxed/simple;
	bh=M2Krrhi7AbdmFWk7OUJA1ShorrCktlWRI27APepgLfc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=QPVZ2o3Ssf9jmlVPzXzjuv7tpknxWfHN/KCGpKncgCJOjhVUEZSC2UHp7dceIrTTxpdcbeYM2aD5YSU0xJ1O1pX/k32ltxfuhDDNW4lEZkqMb5fL/zIDe97rt28eq9peam6+EUufLCD8fRL01C95dWF1R9WqkU1zOP9TIMLwFOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=pKmEaza2; arc=fail smtp.client-ip=40.107.14.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NDUAQyKudAwzur/bkKbya5s+zxH/Mr/eArTaPJlDbnSXQt//2nyheGhND/I7yt/BtaK6BxgR4xR987tpl/Pg8KqvOgc0v0bdosLmUqCwef5ZVIMOv7rWNhGZMzq/PkwarNFnbiXUI3t5Xs+1BsE9SghbEI0Kn+z/t0upuVft/SGNrxzUXpT7uI+9Nl0BQiMqs+9kQSqx7g8St/HxuaYztOvfMn1rk0qDuwkrH8Q6M0+U9U32DjkM13qvIwSk2s2+RbWFiNon/EOBXruvLLg1K10zLgsPB/uowEm48H/xKp9FUCiqoGOPX1jTD4ZalwEL06PG0l8dzLBSFI6HchbWfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z93cy4BoCw+vSYw4D6HfGOB/F2Gk44qutE6UfHQCTcY=;
 b=GU45U0KnrvNFysmo0CdtIjfE8DIusCD06BtWLTt38PdzD9xQ030xoU57d1Qs2a7Iibr9zJIKJ/TnQSZ0mrbQo6DyEOQGFi5VsiRMJrbnP5yNVUc9jInzq4Td1cjjvpzmfbu0ypX04R0WERLf01fHnSBFQb7hlbfgY1Xvf0/KwWs5L03yJtaxP8d8VcdPZhEO1VIZnjnL+mVzUbYDpcv0Tsx9qIpp8cGbnaexUFnt6Suh7Zs/l37ZbLjT+FOf6K7vlfdSjA6Zg3fNbZYx+vGN+j6ajOlXfACFiR+dz17GceFS8l45q3+hmC6Rvk0h+24lAzdHQteq4MC50FX3pWZcBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z93cy4BoCw+vSYw4D6HfGOB/F2Gk44qutE6UfHQCTcY=;
 b=pKmEaza2eb3prkL7VpUFmCCi3W6Ixq1gduJicOr0cWRCfiY/4RugkDPGZTjs5Nq5mVVJr+6EIHY1x+J5uWkW1UKgE4tlVD8XhYg3CV4UV0NiT+JKGMWQyZZastJdHDW7oDZP0gawi/symnBYbjreNqea7lLocHa1xvDqMJj56xs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by PAWPR04MB9768.eurprd04.prod.outlook.com (2603:10a6:102:381::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 10:40:36 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%5]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 10:40:35 +0000
From: Joy Zou <joy.zou@nxp.com>
To: Frank.Li@nxp.com,
	vkoul@kernel.org
Cc: imx@lists.linux.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] add edma src ID check at request channel
Date: Fri, 21 Jun 2024 18:49:30 +0800
Message-Id: <20240621104932.4116137-1-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0196.apcprd06.prod.outlook.com (2603:1096:4:1::28)
 To AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|PAWPR04MB9768:EE_
X-MS-Office365-Filtering-Correlation-Id: 6db3dbf2-f565-4a60-7a8c-08dc91de956c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|52116011|1800799021|366013|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CoyIIA9a7fbxieEvYbt72jpXXKQ36PWXeOj11iBflNbHd2isWw1dam0g0vRI?=
 =?us-ascii?Q?HX2znmMrW6vaP6o5lPOcxi2lw9uGrKC02Ip8Wm2v6HXqFlV2JFQJHctQNr5e?=
 =?us-ascii?Q?nAiYv3StB7LUjN6eliM7exUiIiJ2b92yofqwM4VYvimFcC+3bA6nm/I98Daj?=
 =?us-ascii?Q?6k0yogwS9a1YucWrRHe1f/O9+fuHLzx1L/utUlc4SHbPrnpQNfol5t5qCW6k?=
 =?us-ascii?Q?UlvjNXv66D072nZoM5JQVArTQ7lG5YY/X50ZuTlzyOqbR0lYfxwkeo5r2ryu?=
 =?us-ascii?Q?eN8JKs6dK40d2R8vNEWSm9w5sktc/uCSs3Bb8ndwrkUpPvoKiNa/G2Q0G2YW?=
 =?us-ascii?Q?zEPFyKRm+egbBK5rACJDecqjoXqmFRNoJgzh/Q4S3dvwo2WmUpq4r7KiEVUS?=
 =?us-ascii?Q?0g1aPTHAC23aP9kelQBDUc3FnavvbHbvifB92+QVqnVWABJgteIMrc2ktWlY?=
 =?us-ascii?Q?NanzMcvZvZ5P+D9CoKYPx7f34Fc2eD9wLUR/WOAxRdKsd7QzDPTtOCBedUTi?=
 =?us-ascii?Q?WE2in1IFGUBw47KnzZt9I3uTAPuhmbIWqL+arjePfY7q8iSnb0c/pHWN5shK?=
 =?us-ascii?Q?eZuQWML5OessMabUY9fO6OCTU/sgmmiroZu/UlvVPbLVcqMBVm1As15WtuZy?=
 =?us-ascii?Q?5WhywyWrVO8w2E55x5BsUdfu4pmoDq8tm/77YUD7LiVH9U+J8tuHqF/iRXVS?=
 =?us-ascii?Q?Cu+G+v0FyRQ7x+y4YT0lJ7zSd+HUjMt/a2FKAH8oYPsO/2ww/bHN9BJSW4F3?=
 =?us-ascii?Q?B8r5V+Vf2AzmrrIwSBq1uBLeCA4rAqa59ROw5aO0QdkW+6oBHc4zbJ+9qvZ5?=
 =?us-ascii?Q?/W4GnQmGtTUcpj3iRwa+r/PbrGcGPK7K9wyz8f2Y9XIFzdQGgQv4wi4yczXq?=
 =?us-ascii?Q?mHWwJqezuesY5fh7krCaSA2aed4+4sBAkQubWaBpiUYnC17+K3giaDIiFCAK?=
 =?us-ascii?Q?VKKWi3t/l1zeQ+Ce0YtfmfK+jTarNmujaxvmK74Zml9MmK9z18pW32A5n9/E?=
 =?us-ascii?Q?ipiRLxF9HQIW0Qxcu/HF6x045jk6FexUUoXRLEeN+mrsO61bAXhPzdnb9k14?=
 =?us-ascii?Q?iVtW7LsD5oVcCuzmKf5qNiA2u7FdaBZ0OKCbFT9D0ivFtxCk9lvwBOdgwl6O?=
 =?us-ascii?Q?3067IbQ8kQDB6mEpuFUfENca9ks4mJOAT7enO5N2vhQVqAWanCqauFJTfSGy?=
 =?us-ascii?Q?3adVEzUO/q4EcYjQQGzrxJ0Qpofx2gU+ZS4Uz3uCWpl8yjCIA8R40T/QzrnM?=
 =?us-ascii?Q?gh0F6vIyJHqJO1zHNM6LzcEJc0THLTF9mcosG8fStiLkz0irpet5CTFx3Y30?=
 =?us-ascii?Q?yXNGdi+1egp07Y2fKfOT5Xi0PuUqd6Iix97FP/fn2RJfT8CbcoK1cAg9e5fW?=
 =?us-ascii?Q?qVtaEIE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(52116011)(1800799021)(366013)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XKt6vadn0UpCOxMUsxj145WSGgsIK3koAjcl/jpv1nXXkYVee2n6p7Lpb3x5?=
 =?us-ascii?Q?c1WpuA0IW1boQvk2MMhEXIC/mQoCzBAPUby6XFEplq4TzjyY0OregT1qW2D3?=
 =?us-ascii?Q?8VdEjz0zWJT65Ja+5KKMeiiQmO4uleCpU72VePh/4/Klq5Ko9Ixncn7j2ohM?=
 =?us-ascii?Q?u0T0mFEI5RcVnOQwaxUmSTYz+ctuE7/qiPbINgXe78kicAsmQOZrrDdYtLqx?=
 =?us-ascii?Q?9bi2AEANrUfgo69Mflfpd8dD9R7Y1naYR0A+n/SY1JJXQvT1nrZSER7Sj+wa?=
 =?us-ascii?Q?VvV6+CIckDyfMMq2cM5Mo3pdFbmLMfi9FWaK0Xsb0iwhHULXfLQXjivykyaZ?=
 =?us-ascii?Q?OfwXdOsDvrGtGjFF2h8uN+T2iFKh5Odt5l7HwrBA/l5L12Zy8VF+mDfWVhwU?=
 =?us-ascii?Q?wMTCcZO9it9yH3qE2/w55kYYrXokf+Fe5v3VcNFZX4eGHed/nx0uvcDNQWcI?=
 =?us-ascii?Q?Gw84xSp15SIhWFjdaSin/4KJCpE7NlHW9MW39IiwRZTu0qCUYA0LE8PDkeu2?=
 =?us-ascii?Q?HfqHI4uhwsi5fK+JTVIlIJBekCQRDSHHw4+6Oe9Ie7x/YnzndPPFfr3hzAj4?=
 =?us-ascii?Q?aU28l5K1nFszc4Vkhebwd1wqoOza2tX1n+yW1HJB2aFIO7sjYgmdgsOgQ4/G?=
 =?us-ascii?Q?KaBl9IF4SVV7C3WQ/8RmAm8NrzQ4qMJpr6C1x3Hxj5KkCkI3q0ylP7Bmlp6a?=
 =?us-ascii?Q?gpyUIjayMeIG3GWAZ2x4BKprDrfX7Da1IKc5qvXnXWDtQ/8c1bS2TxSTnKej?=
 =?us-ascii?Q?RMd+kvvG5PF7kbGcaT5pwJlhm6LytMZLQ7CCG7S68jOAVEwWMQ6g+TlUcvCD?=
 =?us-ascii?Q?hMI99JOKxGbjqoBuMsNkS8fRQVjXht8q1qeKw2bC/jchYSk0eN4p1qT5eNYn?=
 =?us-ascii?Q?UCJLHK9FwsyXyRI5mnXr0ErNIO629bF/9/24U9Ss7VipXDZYFFGl7Qa2QrXp?=
 =?us-ascii?Q?HjTcso6zJTzJXuWNixMuxk8fivG+TmtjcFLTZ4YE40h0CvnJr6zfO/gXmbhG?=
 =?us-ascii?Q?VvuBObUZxMS3zQ1/MnLK+vbjqJ7FctqLD+l3q4i0+tHaFL4CNeulELHv+JW0?=
 =?us-ascii?Q?IkiHbcJ4a6F5jZXO3CLA7zkYcYE2DJlBDzHOQiYlt+aciu5lMkb1u4SOlHtO?=
 =?us-ascii?Q?KDKJgLvDuW6pV8CaNYVZ5NMrHrHnzbVpFGsBdCDLvaeRQNrdW3Ow2gGsF7t7?=
 =?us-ascii?Q?y3a7wvrI792CuoE1xvB9ggJDkrZvXq9onOOUJ81vUcdrYIi+cMZUhWIrp7DQ?=
 =?us-ascii?Q?ia8HH0noTJDMlfPlHhebjgP16GCLrbjjwsmTaMwsRhaNQvIyf6D+PBiqIQPV?=
 =?us-ascii?Q?vHBwSiMqQH99fwXGhwiPdyJfHCK6nDy+r6BIa9BJvYL5nPDh5iy8rYnkZEgV?=
 =?us-ascii?Q?sQvog7k0cZiC3g3KqcxuTX7/Vc9x6DQb2w0hUrAG+aWCP62M4L7cBPQ4I8qZ?=
 =?us-ascii?Q?Fn0IU8C5V6uedlV4AY6vCUgSSYUIWs5L3L07+XObYGNdD57Z5K+9cjlCZb2e?=
 =?us-ascii?Q?W0yu7FMAtJ8R7zR2f+CJYX9RhWSDOVmGR31B3momt3cQhhugKW0WC232Btck?=
 =?us-ascii?Q?bfFu+cOQsy4fIPHwVAAzYMelmdDTh7GM4LNlf2Jc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6db3dbf2-f565-4a60-7a8c-08dc91de956c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 10:40:35.8755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yYOZSjae7gjNsRwnEPBuVUndvobOoeb8KhlUQmn3ZgHKs0f9IbW2dO5Io/Z458nI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9768

For the details, please check the patch commit log.

Joy Zou (2):
  dmaengine: fsl-edma: change to guard(mutex) within fsl_edma3_xlate()
  dmaengine: fsl-edma: add edma src ID check at request channel

 drivers/dma/fsl-edma-main.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

-- 
2.37.1


