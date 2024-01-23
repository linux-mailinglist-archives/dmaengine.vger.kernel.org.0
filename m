Return-Path: <dmaengine+bounces-808-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75981839667
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jan 2024 18:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A83A71C20ACE
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jan 2024 17:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8308E7FBBF;
	Tue, 23 Jan 2024 17:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XxnkR309"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2077.outbound.protection.outlook.com [40.107.105.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E246B7F7EF;
	Tue, 23 Jan 2024 17:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706030947; cv=fail; b=ly8e7ijWIlD/2MzkadGz0AsWRwQHLHn48S+1NbPoM1+983pyVsW3gUx6eH9W8W+cj1g9Tfhiorp4DFBhUNPS5RBDpRAggAmFkk+gW5dzdXzT3fP3l/oaon6VJUf7cJpiNuHi7ul37ehoriFlP09yzNPt/OpDQLKo/f7WXOomXf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706030947; c=relaxed/simple;
	bh=RxPSEEeZG5glZ7E6ehagg9TDFiHtrb0uWUlMR+0Okuc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=s2sFF+Yh6npoZmApCR8trmrMOI7K8+Bct8eMiTU4NRHQ8sUUzmdHhck7spAnXB5+9/H12cNFOiow2bbkz4FcpGY2oGSO3l3LVvDGHpu24WV/GCboB+Hw1+brjdf4ZThoN4E5K/kwIAVhB5LdHJPQ5fDff+aPJQ3zfvurVUJGWAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=XxnkR309; arc=fail smtp.client-ip=40.107.105.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QMYTrBmbIYnVSjnBf4LiHoAQZ3Kzu+3fmIPdWslWjvnXgG8xvpnxtIWPgDKtTNzVkncjNYmp7hW7aWW+IIH75ybBmvQY/L/+oa+k8xIa/d6pma8LFVmS80HjU2zVlU6fxbxesD4ioWgHQ/5oFtelD1t9tB/wgpvI7854EFfaNdQ10XbTJffOPEKIWotUZj1pv+Br2cu9e6qAOTQbvKS+kpgdtYwvEolOKlK6icYewBJkaio8nDYoMLuPOVXyREJ/Q5AwNOayT2+bq5tYQ5+dwPnBTHi7N9aTv9r9FcuMRd8BnELSVh/JLZSnxC0XtI/LP6N15P6Hcz/kONbPZbTC8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FaVRvLb3crWnNJztg5UYqFPbR1jQJLWKM8Jz4MY3efc=;
 b=nGbwMRSQiJdktgL6TEMoSUTnNley4dP4LLhWrcCYTscKeGb8Wqpj+2xN5ciABW3dG2rXHr0kRkhkFrFPkglUIPjvFYauS5ngRcGCtZ/xNb9bWv3BAyVn0otGCYBaekqnHE1bm4uEyfoAebCUVkDVQI85dE6ilK5h2VNtOEevGpZAaLHJp36Uhclbd5r7u/5AQtXSSa5I6TQb55SnRvuLAEViPH3Tuf7yAQj7CUinVeYOlrHr/VgNG3nAm1BSqzwjBY6slTeat8/OasRtpVXLLb3Hh1pwCw4kGRGbOOv2Q3SF/HA0LPBzGL05TgcD84nUIsVaj0JxWocZ5hXMXxSYlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FaVRvLb3crWnNJztg5UYqFPbR1jQJLWKM8Jz4MY3efc=;
 b=XxnkR309QTQMzaNbKPBWAInHEU+Y8Se6whlbqhDUTrJty9+cdZPBlSBTDQ9iX+HKXjxA0zQOoNg05qt7bnzBPdtihtIEYqlTHSQ43ApYfxNaJ1F4mYvpSa8b3qrGUXsJFcEjwjVVzzDH9eLZvSMIWDgtjkO08qEZbyBEaSWBtzk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7960.eurprd04.prod.outlook.com (2603:10a6:20b:2a8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.36; Tue, 23 Jan
 2024 17:29:02 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 17:29:02 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Vinod Koul <vkoul@kernel.org>,
	Barry Song <Baohua.Song@csr.com>,
	dmaengine@vger.kernel.org (open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dmaengine: fix is_slave_direction() return false when DMA_DEV_TO_DEV
Date: Tue, 23 Jan 2024 12:28:41 -0500
Message-Id: <20240123172842.3764529-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0111.namprd05.prod.outlook.com
 (2603:10b6:a03:334::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7960:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fea57fa-1b61-439b-06bf-08dc1c38ca31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lNIimTaQhFeebeh+kD7n9ggcjkb9N3sNGQGNfWG8hpX+kMUmbAk1VVR/Q3j7kqajA12zYoW0BVb5ADTe1oc8PO9aZAa13NWsaQBp04yAcd4KuAqQaSSOjKAMgMN0+SDJSpB9hqu3c0pKSBOjG7jMLwNu5JVSfua1ZVlYI0+D7sFEQItnBu71zWTsR8SGy1IHC0UMcQEFVpbooJwM+LjfeBFtEDKYArYYt25UovV55Iz/d97mD6DbWkgxADjY1pxSQvg3D043zsfZwowm3TGK2+YXxjmiwLKIFFOveV8iMRek4PBwJYzCYf8Yr0RSzG2q0bPoTN9Mc3SEF1xsf/0udeik3vKyQSxzeFhou4+Yr0fbkjXWPTkZXCy8aoPrCO0dfqSCt1U7aqVuvgTQihZBRnxgMG/yyC0o/Y70w8DQu3+WUiVpre64k0yj9ue2PqN5J6WYy/hWJyZHpWaGEhC8zRFxQNqZ6bfb+kTIlabA7mi/ZCI2HgLoVOQf4Em7FzsXXujkD9gC6cw4Xptxkt+pEsIMveUcieGIyUx2M3tPj12RPL1y/ZyOUnBcWsNJGyqrXiIbhwISGmg8kObwnMBK4Iz5oflhNrCgOtItXkTE9HXQm5c+tlKS6/C/FY9YWVOS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(136003)(346002)(366004)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(38350700005)(2616005)(4326008)(5660300002)(8676002)(6486002)(1076003)(83380400001)(6512007)(8936002)(52116002)(316002)(66476007)(6666004)(6506007)(66556008)(66946007)(478600001)(26005)(110136005)(38100700002)(4744005)(2906002)(36756003)(41300700001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9ENpJ0NufuoFyllsj+/dCyz41duxDhBvWpgP9HjVNTSRI0mhhGh7KJUq1f2R?=
 =?us-ascii?Q?ssTjX2dJ/jhSCStgNCb7f9lJbHwgE3jwzDN85ixY9aIi0u2WgYs2m14WtF2H?=
 =?us-ascii?Q?JJINHR/512SW8V4vq4gs3pIjKW61JBBZji1GdsUhj6HBR3uFNChFxTcqOg0r?=
 =?us-ascii?Q?ZrOJGKz/CV6nAaedYMla1fz4vo+euYW+lvoM7QCEP2rwf1RdFVR5InfYdfEc?=
 =?us-ascii?Q?rF7DLAnrwODwku46DNt2zPfJZ5VPcuJ5RxtD3umIsBoDKqj5DVMYjort25gR?=
 =?us-ascii?Q?xjnRFpZNuvrwiAaSYGrPXFyog56EbBMpp45GH+XWVnNvybS8ZGcqQf3DfkjL?=
 =?us-ascii?Q?Xo0N+d9DGnBo+yBY6jOGc3DCgfwtb2AfCgWPacNcW2pmi1ebGag7p+F+qxPf?=
 =?us-ascii?Q?fZBQU1Zb44T8+sO986vgKEdlDWh/wWfvhdc0FpyztzqGVypo6wGRtrXtSe4a?=
 =?us-ascii?Q?XfhJNj0zHt0pae+7a3LS6AZ+Wf8jr3+jY9XAuI2OePzwBk780X0+U99kgE3t?=
 =?us-ascii?Q?dmiz456itMPih+mvwxkqyDtCwyKxo9e6j4UFwgBHBigiG3wouyf7xidPQ+CM?=
 =?us-ascii?Q?hm/RvdDZOQ0h3DwCfR5zAaiyHfdXVgkyTRhtwgLRhvsVgbXudi4D5GlgfG/D?=
 =?us-ascii?Q?ESJpp6cPePAn043i4+EAZimNUWenupiTEF4t0+Yt2WBTTlcQhN22v2J8zADQ?=
 =?us-ascii?Q?T9kITKvY2KG6bRXg+RwD4idcz7ALZAdiTznZTRona9CkB/5gzLVBdxHugQLk?=
 =?us-ascii?Q?V6mHMTgcqe32WAn67GS1pyR076gOpyYYNWa+egwrnAEAjBvaCGn9d1LtAaOZ?=
 =?us-ascii?Q?PGPrPyDisFpdUtboUo4PT8YT/nUGCkOqdI1roW0MwKauzhjKS1STBgCcHJXo?=
 =?us-ascii?Q?xYkpJWAmbniBNtZIS0siZ3eH0C8D8ULfuxRBBKHtYQc7l0oS0sdvr9Hgu/IO?=
 =?us-ascii?Q?mKNLih/g0ftZ/2blmEZH/ObEZtzOgUNXJkfVk48CFAs7HIMsu4kWc4AXO/fJ?=
 =?us-ascii?Q?sli4ev6n7yfGqVrxLY3JYJySdVAQUOav/sHxwVG+LKK7UlAQ5nM2pjp2HLmm?=
 =?us-ascii?Q?qXplmATgrwhfx2gRuMZoQwEDBOSXdMadIAMpw8qG1vx/Px5+HGUm0aWawmma?=
 =?us-ascii?Q?sGBBlJdD66LTYDcZtsTlZhVWTVJeZY5ltLB/7sAqwBy5XlY9RI6EzJCNGKBG?=
 =?us-ascii?Q?BfVAoqquXK0jpsTTExz/Lho5+/Q/d6S8+1P2XeJoGpV5mHFp2QXYrVb7g97i?=
 =?us-ascii?Q?yrEtz/Kpv+9N06stExhERNfS6vSRDbtbpa1BiauSPCG98tKiB9UGmxK+C/QE?=
 =?us-ascii?Q?ugFFjGhw+fkfIX1nHBOPN2ufQ8ad+VYRO7xJ3LDX80DM51t2+BRv37kDUSRG?=
 =?us-ascii?Q?bDBTJW5kev/zyIso0Sud9ycXu7c7nPf7d6ieC8qdQYPJ+UYzX8UqbsUVUr6S?=
 =?us-ascii?Q?Dbd+bDCKzNJ03GN7D17b0ocyiekKEtaERaFuWqxT/QgTC1HNPmcInG+KM0BX?=
 =?us-ascii?Q?dGLOW1BXjA4Igm5tdcTRV7jsqh0uCz4GwOR9DUIBoTaxUYPVh1wlbz0th8I4?=
 =?us-ascii?Q?dC2tfxh/04MOVZJC0Yv1LbGJ1Bq3UZtXD+HGTCZA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fea57fa-1b61-439b-06bf-08dc1c38ca31
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 17:29:01.9625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DLcc1KkywJeGQd749MTlrRCs9UrMVZWJwVPeosYxIp3rydgpNiZ43umigjI29IbK5uUzhwxoi5uiWPq5gfuFKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7960

is_slave_direction() should return true when direction is DMA_DEV_TO_DEV.

Fixes: 49920bc66984 ("dmaengine: add new enum dma_transfer_direction")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 include/linux/dmaengine.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 3df70d6131c8f..752dbde4cec1f 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -953,7 +953,8 @@ static inline int dmaengine_slave_config(struct dma_chan *chan,
 
 static inline bool is_slave_direction(enum dma_transfer_direction direction)
 {
-	return (direction == DMA_MEM_TO_DEV) || (direction == DMA_DEV_TO_MEM);
+	return (direction == DMA_MEM_TO_DEV) || (direction == DMA_DEV_TO_MEM) ||
+	       (direction == DMA_DEV_TO_DEV);
 }
 
 static inline struct dma_async_tx_descriptor *dmaengine_prep_slave_single(
-- 
2.34.1


