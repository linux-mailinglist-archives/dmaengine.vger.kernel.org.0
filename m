Return-Path: <dmaengine+bounces-1792-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7F789E095
	for <lists+dmaengine@lfdr.de>; Tue,  9 Apr 2024 18:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86A981F218D2
	for <lists+dmaengine@lfdr.de>; Tue,  9 Apr 2024 16:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B7B15358E;
	Tue,  9 Apr 2024 16:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ox3uxRxN"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2120.outbound.protection.outlook.com [40.107.6.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55983153576;
	Tue,  9 Apr 2024 16:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712680607; cv=fail; b=cwo+DxpeEnhuvIqdg8dV2XOznePpIaesBxTjXM5o3zfcIjyAWumkflj374mX6bxPhe9yeiVnDPP47u/XGfVufUcPXHWr6oW8wApLo375Kul9wiTFDDQIjC6XeLSLAiIHm4QeWHrTFYzrjHBUCAa+Dy9KJ8u3IowS0fy4NbbQjc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712680607; c=relaxed/simple;
	bh=Xm/f1e4CbNdDtNna9QRjORy29LQ/ya0a7FVojPUD5RI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=oJnWzF13pxB5G3yQ7uGU0h7hBx+mLCXWBnk88cafgMxdUQGwXHLvQmnM/ss2m94jVG9AA3FW4wJjzoi7PtrluZIeGQ3eN2202ncDU8mIxb1bu6d/Em1tCIUl4t26KNLuUCngNM/IXujVFqgDYd6WrzOBvrD19bD5Rs+A9B0ivqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ox3uxRxN; arc=fail smtp.client-ip=40.107.6.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hCQoGUlTZAl90GGNn9kNbEpQeLsgEHWWum0roGJHoMgtyk0vtWIfoQoK9xWSqiJkscaHA8TpQSL2o7Vuhu+PExXuJrvocfKD8288B1q2iM337Vbb557qnqtpPkfTkW8pjPnga0b6B7m1Q6aPu+oRNke1xujeqt2uJgmW10PaQ7IZiOd4bsnOtVxUy8MaGd/fqohiHnwsYlIM6qbj8RG2NUaTnKenb5mzCmnYuZhr6x1UuAzmBBQ9Q/k0phSeHY1PZmew+YYcyI3eSwd9LSomIp+s4dgLrB3hEXVSDvGMdPVsbXQhkjjVFkf7YfvN1ZDIVseKNm5zBDmrYFEMeczG3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EytkoVo2kJCII+IXVB7EBJhiPOq4ohxbGaoaVza8o9g=;
 b=HLsacKDJXaDoZFy3vWDh8IjTvGSeYzP1DTconw5gIL35WnCnuPRh3zt7qN/FI8rrGRNWy11EjxUNbcJYMoP9rHx6fP9Ay3Lel01lrz/yGdFSQoOw+wBXQEeAY5N9c5VqMmgV+XW0d6GUnhzYcgSaDaxjPd66R8jGxmSRtIK0tAGKF1TeyOb0y/wRMMRtbURsfqDkqjQB3Jqd0IkX49Kj0ozAQ7gVymFg0x3NFnDAaqYEmFrkzXphNjvXTuXWQJAccuYllMU4eAeNHyPFhflk7kvHb6xDeP66ypJJ4baY2meZ8xwDt4wjk4yY+0Fa73R0HuSnQt5DdtpcmUKtVIIapg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EytkoVo2kJCII+IXVB7EBJhiPOq4ohxbGaoaVza8o9g=;
 b=Ox3uxRxNRI0PAwOzDHYZE03KPmopJ8DASUHEQ1OFYBRDKk+zWzLdH2UuMumUSSosdq2yr4RpRoFTME2gUh06GYkiu9jGDlgO+pTB0dQRVW9t/OzxH7Kh+r8smvNbFTgrgiB0QsMJliY6Jot8KNwDcdt1etf621QA+/r4HGsFoKc=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8978.eurprd04.prod.outlook.com (2603:10a6:20b:42d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Tue, 9 Apr
 2024 16:36:42 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 16:36:42 +0000
From: Frank Li <Frank.Li@nxp.com>
To: vkoul@kernel.org
Cc: Frank.Li@nxp.com,
	dmaengine@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] dmaengine: fsl-dpaa2-qdma: Update DPDMAI interfaces to version 3
Date: Tue,  9 Apr 2024 12:36:30 -0400
Message-Id: <20240409163630.1996052-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0055.namprd17.prod.outlook.com
 (2603:10b6:a03:167::32) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8978:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Mx86ZW+fg96ZmQqMWD/uOI7xLijjMW7+NWwsWP0wpFlytnQ0IMVtQ4AJCohgORz1H/zABI7AgBR12Ue6tjT1hxChObx3EXr8/JRB0u+T8yt9xqTAtr258Gr+DKPkRt0hSylNTN+R5N7P0ZAg+SEzOn2gLuHOFtgo5V6qsgACLdOG0a64yV164dPE+0AY3uQ4U/xld+PJgwnmJ/45f2NxpyjiDdoTe3+5WrHspubFE8D2dQOYFTe/zVcXC13eEpPjWlPck274G0pI3g2BMB7ZyrkyauUWYq/9VmyEzbtcKhE2HxHhbeNZc6cXZ0NK2IuQE5PQlQ1ssrNba81UjXyW1UovNJPfeWc2n7Cfh+EDyYedKqEbDrRAzHWrAjF5P/Ssf7587fWmhHr9LwD+VUOquVcj47njO5pU5UMmDtdY9vl2z/qsvoRNAWTnjy0glg72amIQSeeVoTLUs/t7VQN2s8X80XiDNOJFHpJHRsr8LiYigNzs0aDiEfXE3HPiDtLUOcw8MDUyhfcdzce7G59YifAhKEaz5H9Z02YI+xQ2S+6rW1AyKwMZGuVNDCkhketlihe6k2mXcoJQS1iwyQS6A319MxN+UdEbTYRAL1uQcqqiwdY0zrXjfak151N0K8ds5itKdiVBeQ/Ro+LLLeYXvzI5Hg2vUXYuAv8rwUedQ9iKHcfadefLkYwrMJ87PMYIzJJTp9iUWA1AyGs6kSk3AKBpYxPIS4qKtHenZmryMyc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OT8PqMpn2R+CVEQiM9UKY5zPG9/popMrz/MMoIlIe4HzfQMYjXP71wAmQKWh?=
 =?us-ascii?Q?rAjrpdGBgdcNEHU8lPNT6Djrzt3Ka8UkJbitXNhbABrz5vRCpMfNPy5Sd+zD?=
 =?us-ascii?Q?4hgGEX1WAG89EmXdzJPNAjj6OkwmGWntEPdYJ7GW//RKa7hErN9KElvI68Fo?=
 =?us-ascii?Q?5D9E+Hdv4tz0bGi0x/mbO4POqrfUmXPdu3wNYJfiKXxd3eR6v1PT6btmJLyT?=
 =?us-ascii?Q?Smz1ewUayneZyXEEVNWdsI95UyXbhdlaYVm7x1vS2sTIdamaDtemVC3Mo563?=
 =?us-ascii?Q?xkpDEpVcC3lnVTlnt1QpbiXmsYP99HiLx8Oq6uroZTNXgDoO5G7tutt+9HcK?=
 =?us-ascii?Q?7wGFJo1IFEYbl80oKxhwvGJv363bp9+2eVxQsT0sj1jDFIhv9QBl4X7CIdwq?=
 =?us-ascii?Q?lEr8CgfRp7VJAv/8wKWJ4n0j/HhLvvQZhaYr9ZgnvJ2GcG1ENuISa+SeVmvs?=
 =?us-ascii?Q?KJY72pjMZPcBLlyFk+F7HSSzOZeKbo9bjTt+MSSQhyD2yAaNmyLFuKAZFWpR?=
 =?us-ascii?Q?QrlQIssHkF7BhtIbbbOcm1EVyv+sZsGfxjZ+O/2mVc1GPWY8UleofxKZbDXd?=
 =?us-ascii?Q?ct8M9MLeft2KFORyp0KE/CpuWpEu4cEtijAflLm1dhX+5OuDI2zFVJrfQTMt?=
 =?us-ascii?Q?449VAS6OwH4RpbPnMM5ZeoSMk98K6AlfGF9pT/dLYrlUAVCvptemRGdaqPOc?=
 =?us-ascii?Q?EtSFeWiGTjxRAkHvxl/MqUmO/MoZj4jK/3ZoLXId7MtAWt/mG6ECsbt333hT?=
 =?us-ascii?Q?ZK0mKatgHWAyzA8LovDFP6dckeL0OJkuG90VqqJxnCCWgyH68bxoIPbjfE4U?=
 =?us-ascii?Q?IjmpygTlBgGXBieYl6YGatnHQWKhbpStSQtpz5j56/ljFSGizwN4zgyTU2P5?=
 =?us-ascii?Q?960BmkWk6hrjOnTCZKjDqCX9YfnXfHZ+cl5Xc0iEUFWB8axT1PuLPuIvogzQ?=
 =?us-ascii?Q?laNWUkw+BQv8qE1S950jGxhK3m+nOMT+J2rKIbK6y9syhI//TGDtD40DPfCo?=
 =?us-ascii?Q?gqIgWFvekf7N3qnxRADdjAq6+Px7hukI8VHlwy1vbQmWtYlij/o4K5fimlQU?=
 =?us-ascii?Q?kyUU6k1uJGYhSw7mSI6Z0zqbDOlRqxLEUNu3TRS48gl6qm8D+GbPDpH1iySG?=
 =?us-ascii?Q?IuiRH2E2SYuOoWP9DcmHCUkacgMyg5litvYtA6yZDEmXMpkGHa5TpI2mU4f9?=
 =?us-ascii?Q?YxefV22JU0SePneF9Rd0xc8fOGfw5Lz6mcrWj40oB/MeXe6tq9JPXHwvw3dQ?=
 =?us-ascii?Q?KZfb9cCA6MtVG+WF09gsF3WGBjI/p+zNGujT4winvmUz56mpjM/PhMxsQQ34?=
 =?us-ascii?Q?ooBqDgk8af/p+/0u3oaO57wWoRCo3mSggzgHeCSTXuzMYUDk21JHjIwWYxaz?=
 =?us-ascii?Q?e1igH5Vjn/ylUGYx2rbvZkENCwrdM/3RIIXJobNtNRNzpu25zmcAtsAyA/Nc?=
 =?us-ascii?Q?H3IL9q2Cf6LFkn+slvvGzlEZOTBVtrjwWtCGwtd/VeM3DUjm74IYxw21zoeR?=
 =?us-ascii?Q?u9hmsssz6fnbst4BP71QOgSYdtcD7ZCkGVCMmPLa1rfZdemanmLXm3prvgXN?=
 =?us-ascii?Q?SgIXnOmWGIWJQGu+75E=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b824cd0d-5fa9-4deb-161a-08dc58b33cee
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 16:36:42.6619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ibbVqVyiP8zy1civlXX6ipyj6aoBleIs4uaVi9ThSpBFZ0Hp1V86L+zKSHJfPXShUvacizwTXijEW9sldtkKnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8978

Update the DPDMAI interfaces to support MC firmware up to 10.1x.x, which
major change is to add dpaa domain id support. User space MC controller
tool can create difference dpaa domain for difference virtual environment.
DMA queues can map to difference service priorities.

The MC command was basic compatible original one. The new command use
previous reserved field.

- Add queue number for dpdmai_get_tx(rx)_queue().
- Unified rx(tx)_queue_attr.
- Update pad/reserved field of struct dpdmai_rsp_get_attributes and
struct dpdmai_cmd_queue for new API.
- Update command DPDMAI_SET(GET)_RX_QUEUE and DPDMAI_CMDID_GET_TX_QUEUE

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v1 to v2
    - Rewrite commit message, by add major change in MC firmware.
    - remove used struct dpdmai_rsp_is_enabled

 drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c | 14 ++++----
 drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.h |  5 +--
 drivers/dma/fsl-dpaa2-qdma/dpdmai.c     | 48 +++++++++++++++++--------
 drivers/dma/fsl-dpaa2-qdma/dpdmai.h     | 35 +++++++++++-------
 4 files changed, 67 insertions(+), 35 deletions(-)

diff --git a/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c b/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
index 5a8061a307cda..36384d0192636 100644
--- a/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
+++ b/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
@@ -362,7 +362,7 @@ static int __cold dpaa2_qdma_setup(struct fsl_mc_device *ls_dev)
 
 	for (i = 0; i < priv->num_pairs; i++) {
 		err = dpdmai_get_rx_queue(priv->mc_io, 0, ls_dev->mc_handle,
-					  i, &priv->rx_queue_attr[i]);
+					  i, 0, &priv->rx_queue_attr[i]);
 		if (err) {
 			dev_err(dev, "dpdmai_get_rx_queue() failed\n");
 			goto exit;
@@ -370,13 +370,13 @@ static int __cold dpaa2_qdma_setup(struct fsl_mc_device *ls_dev)
 		ppriv->rsp_fqid = priv->rx_queue_attr[i].fqid;
 
 		err = dpdmai_get_tx_queue(priv->mc_io, 0, ls_dev->mc_handle,
-					  i, &priv->tx_fqid[i]);
+					  i, 0, &priv->tx_queue_attr[i]);
 		if (err) {
 			dev_err(dev, "dpdmai_get_tx_queue() failed\n");
 			goto exit;
 		}
-		ppriv->req_fqid = priv->tx_fqid[i];
-		ppriv->prio = i;
+		ppriv->req_fqid = priv->tx_queue_attr[i].fqid;
+		ppriv->prio = DPAA2_QDMA_DEFAULT_PRIORITY;
 		ppriv->priv = priv;
 		ppriv++;
 	}
@@ -542,7 +542,7 @@ static int __cold dpaa2_dpdmai_bind(struct dpaa2_qdma_priv *priv)
 		rx_queue_cfg.dest_cfg.dest_id = ppriv->nctx.dpio_id;
 		rx_queue_cfg.dest_cfg.priority = ppriv->prio;
 		err = dpdmai_set_rx_queue(priv->mc_io, 0, ls_dev->mc_handle,
-					  rx_queue_cfg.dest_cfg.priority,
+					  rx_queue_cfg.dest_cfg.priority, 0,
 					  &rx_queue_cfg);
 		if (err) {
 			dev_err(dev, "dpdmai_set_rx_queue() failed\n");
@@ -642,7 +642,7 @@ static int dpaa2_dpdmai_init_channels(struct dpaa2_qdma_engine *dpaa2_qdma)
 	for (i = 0; i < dpaa2_qdma->n_chans; i++) {
 		dpaa2_chan = &dpaa2_qdma->chans[i];
 		dpaa2_chan->qdma = dpaa2_qdma;
-		dpaa2_chan->fqid = priv->tx_fqid[i % num];
+		dpaa2_chan->fqid = priv->tx_queue_attr[i % num].fqid;
 		dpaa2_chan->vchan.desc_free = dpaa2_qdma_free_desc;
 		vchan_init(&dpaa2_chan->vchan, &dpaa2_qdma->dma_dev);
 		spin_lock_init(&dpaa2_chan->queue_lock);
@@ -802,7 +802,7 @@ static void dpaa2_qdma_shutdown(struct fsl_mc_device *ls_dev)
 	dpdmai_disable(priv->mc_io, 0, ls_dev->mc_handle);
 	dpaa2_dpdmai_dpio_unbind(priv);
 	dpdmai_close(priv->mc_io, 0, ls_dev->mc_handle);
-	dpdmai_destroy(priv->mc_io, 0, ls_dev->mc_handle);
+	dpdmai_destroy(priv->mc_io, 0, priv->dpqdma_id, ls_dev->mc_handle);
 }
 
 static const struct fsl_mc_device_id dpaa2_qdma_id_table[] = {
diff --git a/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.h b/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.h
index 03e2f4e0baca8..2c80077cb7c0a 100644
--- a/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.h
+++ b/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.h
@@ -6,6 +6,7 @@
 
 #define DPAA2_QDMA_STORE_SIZE 16
 #define NUM_CH 8
+#define DPAA2_QDMA_DEFAULT_PRIORITY 0
 
 struct dpaa2_qdma_sd_d {
 	u32 rsv:32;
@@ -122,8 +123,8 @@ struct dpaa2_qdma_priv {
 	struct dpaa2_qdma_engine	*dpaa2_qdma;
 	struct dpaa2_qdma_priv_per_prio	*ppriv;
 
-	struct dpdmai_rx_queue_attr rx_queue_attr[DPDMAI_PRIO_NUM];
-	u32 tx_fqid[DPDMAI_PRIO_NUM];
+	struct dpdmai_rx_queue_attr rx_queue_attr[DPDMAI_MAX_QUEUE_NUM];
+	struct dpdmai_tx_queue_attr tx_queue_attr[DPDMAI_MAX_QUEUE_NUM];
 };
 
 struct dpaa2_qdma_priv_per_prio {
diff --git a/drivers/dma/fsl-dpaa2-qdma/dpdmai.c b/drivers/dma/fsl-dpaa2-qdma/dpdmai.c
index 610f6231835a8..a824450fe19c2 100644
--- a/drivers/dma/fsl-dpaa2-qdma/dpdmai.c
+++ b/drivers/dma/fsl-dpaa2-qdma/dpdmai.c
@@ -1,32 +1,39 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright 2019 NXP
 
+#include <linux/bitfield.h>
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/io.h>
 #include <linux/fsl/mc.h>
 #include "dpdmai.h"
 
+#define DEST_TYPE_MASK 0xF
+
 struct dpdmai_rsp_get_attributes {
 	__le32 id;
 	u8 num_of_priorities;
-	u8 pad0[3];
+	u8 num_of_queues;
+	u8 pad0[2];
 	__le16 major;
 	__le16 minor;
 };
 
 struct dpdmai_cmd_queue {
 	__le32 dest_id;
-	u8 priority;
-	u8 queue;
+	u8 dest_priority;
+	union {
+		u8 queue;
+		u8 pri;
+	};
 	u8 dest_type;
-	u8 pad;
+	u8 queue_idx;
 	__le64 user_ctx;
 	union {
 		__le32 options;
 		__le32 fqid;
 	};
-};
+} __packed;
 
 struct dpdmai_rsp_get_tx_queue {
 	__le64 pad;
@@ -37,6 +44,10 @@ struct dpdmai_cmd_open {
 	__le32 dpdmai_id;
 } __packed;
 
+struct dpdmai_cmd_destroy {
+	__le32 dpdmai_id;
+} __packed;
+
 static inline u64 mc_enc(int lsoffset, int width, u64 val)
 {
 	return (val & MAKE_UMASK64(width)) << lsoffset;
@@ -113,18 +124,23 @@ EXPORT_SYMBOL_GPL(dpdmai_close);
  * dpdmai_destroy() - Destroy the DPDMAI object and release all its resources.
  * @mc_io:      Pointer to MC portal's I/O object
  * @cmd_flags:  Command flags; one or more of 'MC_CMD_FLAG_'
+ * @dpdmai_id:	The object id; it must be a valid id within the container that created this object;
  * @token:      Token of DPDMAI object
  *
  * Return:      '0' on Success; error code otherwise.
  */
-int dpdmai_destroy(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token)
+int dpdmai_destroy(struct fsl_mc_io *mc_io, u32 cmd_flags, u32 dpdmai_id, u16 token)
 {
+	struct dpdmai_cmd_destroy *cmd_params;
 	struct fsl_mc_command cmd = { 0 };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPDMAI_CMDID_DESTROY,
 					  cmd_flags, token);
 
+	cmd_params = (struct dpdmai_cmd_destroy *)&cmd.params;
+	cmd_params->dpdmai_id = cpu_to_le32(dpdmai_id);
+
 	/* send command to mc*/
 	return mc_send_command(mc_io, &cmd);
 }
@@ -224,6 +240,7 @@ int dpdmai_get_attributes(struct fsl_mc_io *mc_io, u32 cmd_flags,
 	attr->version.major = le16_to_cpu(rsp_params->major);
 	attr->version.minor = le16_to_cpu(rsp_params->minor);
 	attr->num_of_priorities = rsp_params->num_of_priorities;
+	attr->num_of_queues = rsp_params->num_of_queues;
 
 	return 0;
 }
@@ -240,7 +257,7 @@ EXPORT_SYMBOL_GPL(dpdmai_get_attributes);
  *
  * Return:	'0' on Success; Error code otherwise.
  */
-int dpdmai_set_rx_queue(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
+int dpdmai_set_rx_queue(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token, u8 queue_idx,
 			u8 priority, const struct dpdmai_rx_queue_cfg *cfg)
 {
 	struct dpdmai_cmd_queue *cmd_params;
@@ -252,11 +269,12 @@ int dpdmai_set_rx_queue(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 
 	cmd_params = (struct dpdmai_cmd_queue *)cmd.params;
 	cmd_params->dest_id = cpu_to_le32(cfg->dest_cfg.dest_id);
-	cmd_params->priority = cfg->dest_cfg.priority;
-	cmd_params->queue = priority;
+	cmd_params->dest_priority = cfg->dest_cfg.priority;
+	cmd_params->pri = priority;
 	cmd_params->dest_type = cfg->dest_cfg.dest_type;
 	cmd_params->user_ctx = cpu_to_le64(cfg->user_ctx);
 	cmd_params->options = cpu_to_le32(cfg->options);
+	cmd_params->queue_idx = queue_idx;
 
 	/* send command to mc*/
 	return mc_send_command(mc_io, &cmd);
@@ -274,7 +292,7 @@ EXPORT_SYMBOL_GPL(dpdmai_set_rx_queue);
  *
  * Return:	'0' on Success; Error code otherwise.
  */
-int dpdmai_get_rx_queue(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
+int dpdmai_get_rx_queue(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token, u8 queue_idx,
 			u8 priority, struct dpdmai_rx_queue_attr *attr)
 {
 	struct dpdmai_cmd_queue *cmd_params;
@@ -287,6 +305,7 @@ int dpdmai_get_rx_queue(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 
 	cmd_params = (struct dpdmai_cmd_queue *)cmd.params;
 	cmd_params->queue = priority;
+	cmd_params->queue_idx = queue_idx;
 
 	/* send command to mc*/
 	err = mc_send_command(mc_io, &cmd);
@@ -295,8 +314,8 @@ int dpdmai_get_rx_queue(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 
 	/* retrieve response parameters */
 	attr->dest_cfg.dest_id = le32_to_cpu(cmd_params->dest_id);
-	attr->dest_cfg.priority = cmd_params->priority;
-	attr->dest_cfg.dest_type = cmd_params->dest_type;
+	attr->dest_cfg.priority = cmd_params->dest_priority;
+	attr->dest_cfg.dest_type = FIELD_GET(DEST_TYPE_MASK, cmd_params->dest_type);
 	attr->user_ctx = le64_to_cpu(cmd_params->user_ctx);
 	attr->fqid = le32_to_cpu(cmd_params->fqid);
 
@@ -316,7 +335,7 @@ EXPORT_SYMBOL_GPL(dpdmai_get_rx_queue);
  * Return:	'0' on Success; Error code otherwise.
  */
 int dpdmai_get_tx_queue(struct fsl_mc_io *mc_io, u32 cmd_flags,
-			u16 token, u8 priority, u32 *fqid)
+			u16 token, u8 queue_idx, u8 priority, struct dpdmai_tx_queue_attr *attr)
 {
 	struct dpdmai_rsp_get_tx_queue *rsp_params;
 	struct dpdmai_cmd_queue *cmd_params;
@@ -329,6 +348,7 @@ int dpdmai_get_tx_queue(struct fsl_mc_io *mc_io, u32 cmd_flags,
 
 	cmd_params = (struct dpdmai_cmd_queue *)cmd.params;
 	cmd_params->queue = priority;
+	cmd_params->queue_idx = queue_idx;
 
 	/* send command to mc*/
 	err = mc_send_command(mc_io, &cmd);
@@ -338,7 +358,7 @@ int dpdmai_get_tx_queue(struct fsl_mc_io *mc_io, u32 cmd_flags,
 	/* retrieve response parameters */
 
 	rsp_params = (struct dpdmai_rsp_get_tx_queue *)cmd.params;
-	*fqid = le32_to_cpu(rsp_params->fqid);
+	attr->fqid = le32_to_cpu(rsp_params->fqid);
 
 	return 0;
 }
diff --git a/drivers/dma/fsl-dpaa2-qdma/dpdmai.h b/drivers/dma/fsl-dpaa2-qdma/dpdmai.h
index 3f2db582509a1..1efca2a305334 100644
--- a/drivers/dma/fsl-dpaa2-qdma/dpdmai.h
+++ b/drivers/dma/fsl-dpaa2-qdma/dpdmai.h
@@ -5,14 +5,19 @@
 #define __FSL_DPDMAI_H
 
 /* DPDMAI Version */
-#define DPDMAI_VER_MAJOR	2
-#define DPDMAI_VER_MINOR	2
+#define DPDMAI_VER_MAJOR	3
+#define DPDMAI_VER_MINOR	3
 
-#define DPDMAI_CMD_BASE_VERSION	0
+#define DPDMAI_CMD_BASE_VERSION	1
 #define DPDMAI_CMD_ID_OFFSET	4
 
-#define DPDMAI_CMDID_FORMAT(x)	(((x) << DPDMAI_CMD_ID_OFFSET) | \
-				DPDMAI_CMD_BASE_VERSION)
+/*
+ * Maximum number of Tx/Rx queues per DPDMAI object
+ */
+#define DPDMAI_MAX_QUEUE_NUM	8
+
+#define DPDMAI_CMDID_FORMAT_V(x, v)	(((x) << DPDMAI_CMD_ID_OFFSET) | (v))
+#define DPDMAI_CMDID_FORMAT(x)		DPDMAI_CMDID_FORMAT_V(x, DPDMAI_CMD_BASE_VERSION)
 
 /* Command IDs */
 #define DPDMAI_CMDID_CLOSE		DPDMAI_CMDID_FORMAT(0x800)
@@ -26,9 +31,9 @@
 #define DPDMAI_CMDID_RESET              DPDMAI_CMDID_FORMAT(0x005)
 #define DPDMAI_CMDID_IS_ENABLED         DPDMAI_CMDID_FORMAT(0x006)
 
-#define DPDMAI_CMDID_SET_RX_QUEUE	DPDMAI_CMDID_FORMAT(0x1A0)
-#define DPDMAI_CMDID_GET_RX_QUEUE       DPDMAI_CMDID_FORMAT(0x1A1)
-#define DPDMAI_CMDID_GET_TX_QUEUE       DPDMAI_CMDID_FORMAT(0x1A2)
+#define DPDMAI_CMDID_SET_RX_QUEUE	DPDMAI_CMDID_FORMAT_V(0x1A0, 2)
+#define DPDMAI_CMDID_GET_RX_QUEUE       DPDMAI_CMDID_FORMAT_V(0x1A1, 2)
+#define DPDMAI_CMDID_GET_TX_QUEUE       DPDMAI_CMDID_FORMAT_V(0x1A2, 2)
 
 #define MC_CMD_HDR_TOKEN_O 32  /* Token field offset */
 #define MC_CMD_HDR_TOKEN_S 16  /* Token field size */
@@ -64,6 +69,7 @@
  *	should be configured with 0
  */
 struct dpdmai_cfg {
+	u8 num_queues;
 	u8 priorities[DPDMAI_PRIO_NUM];
 };
 
@@ -85,6 +91,7 @@ struct dpdmai_attr {
 		u16 minor;
 	} version;
 	u8 num_of_priorities;
+	u8 num_of_queues;
 };
 
 /**
@@ -149,20 +156,24 @@ struct dpdmai_rx_queue_attr {
 	u32 fqid;
 };
 
+struct dpdmai_tx_queue_attr {
+	u32 fqid;
+};
+
 int dpdmai_open(struct fsl_mc_io *mc_io, u32 cmd_flags,
 		int dpdmai_id, u16 *token);
 int dpdmai_close(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token);
-int dpdmai_destroy(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token);
+int dpdmai_destroy(struct fsl_mc_io *mc_io, u32 cmd_flags, u32 dpdmai_id, u16 token);
 int dpdmai_enable(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token);
 int dpdmai_disable(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token);
 int dpdmai_reset(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token);
 int dpdmai_get_attributes(struct fsl_mc_io *mc_io, u32 cmd_flags,
 			  u16 token, struct dpdmai_attr	*attr);
 int dpdmai_set_rx_queue(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
-			u8 priority, const struct dpdmai_rx_queue_cfg *cfg);
+			u8 queue_idx, u8 priority, const struct dpdmai_rx_queue_cfg *cfg);
 int dpdmai_get_rx_queue(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
-			u8 priority, struct dpdmai_rx_queue_attr *attr);
+			u8 queue_idx, u8 priority, struct dpdmai_rx_queue_attr *attr);
 int dpdmai_get_tx_queue(struct fsl_mc_io *mc_io, u32 cmd_flags,
-			u16 token, u8 priority, u32 *fqid);
+			u16 token, u8 queue_idx, u8 priority, struct dpdmai_tx_queue_attr *attr);
 
 #endif /* __FSL_DPDMAI_H */
-- 
2.34.1


