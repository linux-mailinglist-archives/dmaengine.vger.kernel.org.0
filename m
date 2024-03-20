Return-Path: <dmaengine+bounces-1459-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F5B881805
	for <lists+dmaengine@lfdr.de>; Wed, 20 Mar 2024 20:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AAE8B23577
	for <lists+dmaengine@lfdr.de>; Wed, 20 Mar 2024 19:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED0B85934;
	Wed, 20 Mar 2024 19:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DOHFq484"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2083.outbound.protection.outlook.com [40.107.21.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03ED885958;
	Wed, 20 Mar 2024 19:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710963606; cv=fail; b=qSOI2i2D7fg0EMjEojf73TLnT6tm9VbonZ5QvMkZLFFRJ+uDW8BwT953uOb3qs4HQRADJGkpDSNl/H+9xlDCSt3UjIafDvpoqVWTItPvscPRKbwfuPwA/Y/io/IZdr+BAic1tBffgZWov+uNU5tikQtQtbSJ1rjzD5KifPUEvkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710963606; c=relaxed/simple;
	bh=RD54fy6EvB5yA1cGot29fboTtdoZAtYLVbDbCQcCHEk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=p4CMaM5jaeymsgwU4G05SRXikphFkFKcunBcWi8Nw2YlUq8vfDUsjLe7TtPK/j3Hw40rkyaR/i87HVw6DIG7puqPffpx2uSXL2XtpNB12ka2ajoyZ18hPy2xlyhu8cLnCAo+UgWJMZBNXQiWDdPo4IQ0MBgQB6NiO4M/xnrOUeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=DOHFq484; arc=fail smtp.client-ip=40.107.21.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IJqUWUoU5GMt4VyPZ3E5yqedcVUO1E6wyJJEDnH8mXr+m8XJyZ+PDChITBYNHOv7v8uz38xl7S56nTWCOD8xqHouQEX/gt2si5nviIjxkobd+34qwzeI1OfjI/vnZfiUaG45ni5F5kxBirByL3p3TcAoxbiio7YE0O2BQYkvOZ4QpKjwIQjey9mrIFYDoTv/sOk6fWPJgmWuJBPK7FXrInCNgfaL5mKiGboRdPt/ZJvjugYOilqi/XfD+E3ouRZPoZDp95/7FJ5Nn1tS0hpZEFq0wH1ym7LuusTLqyKffjHmHS1lbXatfy0A3oegYx3nrXlIhyG1KL6+O0lEe6p7YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TIZ6EwRFrxO5P85FAmjT2lH54p4aOD47pKj2tw1B83o=;
 b=WuP4X0wNmaAeRdmppZIguB2YdNOTEndzeQTgoRHmrY9PHFDCnbyxIMnr9ssGF0lrgfa7hlSnNoTf24p+cQmC74rEGLbH8lujDQQnqX0M1cNbPDDpS3/hpUDaN07GfWlGOINcD5COrO6zgwtHknOpjFsERCVrGwX84BtJCQZjRM1V3s3ZI1uwg3SQdBuZkQ3/hiQsun1sgFcx4JmThFDcDbGy039PdV5Ag/vdo1hQa1AEGJG1s+0MRXCOYTsYDbDxxAHz3WY/pbYr6Ljvar8IIn24ErjIeY1vxHaL9X3f9EFAtIWgvW4VQR8Z59BjoZDzc+uoyizHY0v8+wU57hkk3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIZ6EwRFrxO5P85FAmjT2lH54p4aOD47pKj2tw1B83o=;
 b=DOHFq4840yY3uQiHO+PDctb1QQibFqGlOLM78AsJ88yMwU45bVenwRCHs639Bj48KzbI+UDeeI6yRt+cgtPnkLDAZEtBfEMDCmYVUXhUsI8BQzzr+fMYOcJilZfEt3R8HENIJmrbCQe2VhcYf7vPQUmhzULZ6blh647ajgf7sxE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10176.eurprd04.prod.outlook.com (2603:10a6:800:244::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Wed, 20 Mar
 2024 19:39:58 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 19:39:58 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 20 Mar 2024 15:39:22 -0400
Subject: [PATCH 4/4] dmaengine: fsl-dpaa2-qdma: Update DPDMAI interfaces to
 version 3
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240320-dpaa2-v1-4-eb56e47c94ec@nxp.com>
References: <20240320-dpaa2-v1-0-eb56e47c94ec@nxp.com>
In-Reply-To: <20240320-dpaa2-v1-0-eb56e47c94ec@nxp.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710963589; l=13013;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=RD54fy6EvB5yA1cGot29fboTtdoZAtYLVbDbCQcCHEk=;
 b=8UOYoFU+8ub1i1EePtf+TM94DJSfqRZ3uMztyAeSlSOshqqnn/8h5930p0Vr1PycH7w1hdB7V
 SUrdW/JfWE+CxySawWxQddKsVZDwmDoTIy+dM0c4xGzxi4H4/HgBo5z
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0058.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10176:EE_
X-MS-Office365-Filtering-Correlation-Id: dd4c3187-3f25-4ad3-c151-08dc491586aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wBJaEFmk6wRF9u1hsTLiWcZPcVk8VVvtf2w1Gwyq/U0nX7mSoLlbO9YCCaDCAbou6IQF1aMIJaz4Ho1sI4MtP6yo1bXC9AeEM0YodrdNrztQmNYIGih8NK24vicQaXn6xuvG4Vn7hfUqNwc3VbZfegBk1vR6XV0QpAsuYalgjfrPyqun7IGqXivc+gmcm+C1SY67K5dm03sqkU12wyGO4oGpmGue2MgJe/rBEOC2PYCNnYKuZqBf0yO1hMiKD26W8gaGru67cfHYYB01ix0ukbNmzoFr1FiTHyeFJpBHOfa/bf9pkc/cJKoe1tCH1VxB5N6WXlSOsm9DKAF1ITJGFGMh5/u+Z08u/5S5H/7VzOaRCz10Hff+Gn+uGlDoONnAlVJCqe5MpTwAE5o8ar8I7QLY8q3z/yc5Cqj5hWwit+dL+Ks6riZg3UOZLYMnahZBPrpZ5Ea+PSLnTnb0P7dmALxv08QQTN51ooFnJgHMentuvkMIz2dJnPMXRaCqHbDU4OFVSInb3kNgQm8XtpWssifHwWjhrxbkycoqNdFf377Wonlj8+iE0WUazMMU9ZbOdkGqHJ4IGT4BMyO1+9GAdXRTES4xGTCm5KYhcsI5i3FB2KqLV5qOkvUmsBBtHqi6/6Rbm0DpyRIt1uZEGiTPmyl/uUboF5MbWDnggEVqn/CAy/Rsw+q/hy8Q0WpnqPWkkX9qC5+Yx9rnPIdHk1PMfYgSiN2ZrgJrxGvyuDeNWTM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(366007)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eG51SnZ0ai9tYnF1UTYzYTcxZ0FzSHUrejlrcWJNYUY2bjkweW5BbzRjeStr?=
 =?utf-8?B?WldYY0RGSlROR3k4YTQwRTlyZU5NUDNrUVdCZXU4TWlRNjI5M3c2WEdUemxa?=
 =?utf-8?B?VzV5anVNV3dmOXBrdWJmRTZqRFRsTGpsWUNmSUF2Mm1FMlJEMVd4YjNRU25S?=
 =?utf-8?B?Z2lUb0ZieFBzRVkvbEhsWVEyNitKRUtJalBadGkyZXZrLzQvK0Q2UEFJcTZh?=
 =?utf-8?B?dFNuUHMyOEMrMTF1eS9uRVBvSHZFbDFxNDhwNWwxUGFGSHdYVEVZM2hxQmVm?=
 =?utf-8?B?eDVaaUVBYTBUNVc1c1NKSHpPT21HS3JiZWVlbDE1Mm8vS1hhcUFwb0pVa2NJ?=
 =?utf-8?B?blJDOUlPQzNON1lNZ2hsYUZleE80Ri82VFZUK1lrQzA1d1J1ZFdhM0VNMXpu?=
 =?utf-8?B?R3dXcWxuQWpWdjRGWVRsS3MycEVkWUNweFU2RmNYZ1dMamhSUlVqaVJhaWJa?=
 =?utf-8?B?blpkUE5oa0tTMnNXbTRtdVZFSGhDZlNWcGVpMHppK2dmQjE3Uml5TEVleUhS?=
 =?utf-8?B?NEN2N2dtWGpONEV5R3FHZjl2NmhTUE5NT3BqVUc0Tzcwa2lES0xNYWFmM2Nm?=
 =?utf-8?B?WmIvU21nVlByOElpRlZEbzlZQUFqazMrUWdRMFFJbG9temFkbm02WDhaS28z?=
 =?utf-8?B?TFhuNzVkWGtCTVJiUTJINjRRai9Zczg3a2FqYncwSzFGZElnbXVSbUJraVBP?=
 =?utf-8?B?dHgwaGhSWVI5TnRRU1BYKzJzL1UveGdCRVY4UzNWaDFFWVYya1hhRnZJRWJo?=
 =?utf-8?B?YWVNcm5qZ1d1b1gvN2tpMFNicUxwWjBDVXBidGg4aE52R0VlWEIwQ1NwRnhG?=
 =?utf-8?B?TEhJYWJ4eDhpNEFZemF0dno4T01FU29nUGJuUGhBaXpQenFYdDhFeEpLMHFx?=
 =?utf-8?B?bFBTeHdYUk40b0hoK0ZjZm1kLzZvaUZFNDZYQ3kzeURHYnVlQ2xJeCtHU2xi?=
 =?utf-8?B?bHRSaVQ1T0IwWnRML0xzaWRSb2kyQXRKMDhkVmkwMUZveGJiaWFpZWw4eUph?=
 =?utf-8?B?akFHblNISDIxM1A5TENsR2RzdGYzYXFrRlkrU2l0WER2WUVOaDlmVW5VOHVE?=
 =?utf-8?B?VnloOEVyYmVGUkNCTjltcXBEd1VaaStZNXMzQkEzUGRFbitqN1haQm5xTERU?=
 =?utf-8?B?S1dOV3NkY2pJVnQ0MDVGK2s1TW90V0krVDJkRE0wcWt6UUpHVTBhcHQxdVpG?=
 =?utf-8?B?bEYzaTNWUVM0YWk1cVNiRkNGZUpJTzNYdFh4U01VdUZrN09NbTB3bWt6bkYx?=
 =?utf-8?B?Zi8xT2NMMlBrV0dNbmEvRjdVZ3VOaS8vUTF1OFdSS2luK3lCZkpVYWEvWTEz?=
 =?utf-8?B?UExTNFk4WnNYeHFDcWFsRXlDNUNUalBLT0UrTHNkMEtSSng3UXRZckNiR0x4?=
 =?utf-8?B?UWlKcVQvcHIyZFYySEFMSEV1cHdtWUlRVFNRbmpja292S0VIR1NIaW5rbi9D?=
 =?utf-8?B?R0JMeUVHZ3lxcVdIRnlreWFsYmJYdXBOOXlUMlhneWJrSmRvMUxvODR1Wm96?=
 =?utf-8?B?Q20rUWhONFF2Q3VwTHovQTJoajJUL2Q0b0xLWHJMS3VIY1NFanllaHN2ZXV1?=
 =?utf-8?B?bVEvcFZ4LzdnVFlHdHNqOGpVdXF6b3gyV1JjTXhRaGY1WXl0MHozS2tuRW0r?=
 =?utf-8?B?NXZFbEZJL0V1SFBRZWtmN0pEaHN6VFdVK0VYUlIrRFBBUVZrNXFQa3VxRE1T?=
 =?utf-8?B?aXhGTnhSU0EyNEdheHNjN0xESGthbEhvcHdLOGtUbWoyeGlQTDZqWmVkaXE5?=
 =?utf-8?B?NGZYMXlpTEJkT3ZLSkd3T2ZGdUtsZlUrbkJrS3p4MGc5SFVLN2lvZ1JSelB2?=
 =?utf-8?B?cVZsdnExZithYzliRVdEbXR0YWs1Mjd0N1BhaXdLMjJjd2lSSW9qSG9Gdmx3?=
 =?utf-8?B?cjRiZUY0a1dtR0RhYUFlVytvdC96dFNucS9jN2NVZjhobjd1QlBHelNqM1RL?=
 =?utf-8?B?MzBvUW1RMExDMzhKYzRCM0VDUk4xTktucHFIenNWbHhOdm1sWnVvM010c3Fh?=
 =?utf-8?B?ZVJZZ3BINHdPZjk0aHNnNGRFNTBLR0JDNWNHbDNzZ1VqMlNNMHdudXQyaVNr?=
 =?utf-8?B?YTdNdlRTc1lpSGNKUlc1eG9aRUpoRmZJSU15UGppRnhSYnVXQm8wT2dmNUlF?=
 =?utf-8?Q?JpWmZnXT7jMq2FBAPBISbPlYo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd4c3187-3f25-4ad3-c151-08dc491586aa
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 19:39:58.4535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DSZAlOL2icrH+OljIHKW9wHn6qunkWgH5KY1/s680Ya/R29unqoruf7SMh5oTRmbjoEBpw7+zl49pCToIjw8zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10176

Update the DPDMAI interfaces to support MC firmware up to 10.1x.x.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c | 14 ++++-----
 drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.h |  5 ++--
 drivers/dma/fsl-dpaa2-qdma/dpdmai.c     | 53 ++++++++++++++++++++++++---------
 drivers/dma/fsl-dpaa2-qdma/dpdmai.h     | 35 ++++++++++++++--------
 4 files changed, 72 insertions(+), 35 deletions(-)

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
index 610f6231835a8..7fbe925831b8b 100644
--- a/drivers/dma/fsl-dpaa2-qdma/dpdmai.c
+++ b/drivers/dma/fsl-dpaa2-qdma/dpdmai.c
@@ -1,42 +1,58 @@
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
 	__le32 fqid;
 };
 
+struct dpdmai_rsp_is_enabled {
+	/* only the LSB bit */
+	u8 en;
+} __packed;
+
 struct dpdmai_cmd_open {
 	__le32 dpdmai_id;
 } __packed;
 
+struct dpdmai_cmd_destroy {
+	__le32 dpdmai_id;
+} __packed;
+
 static inline u64 mc_enc(int lsoffset, int width, u64 val)
 {
 	return (val & MAKE_UMASK64(width)) << lsoffset;
@@ -113,18 +129,23 @@ EXPORT_SYMBOL_GPL(dpdmai_close);
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
@@ -224,6 +245,7 @@ int dpdmai_get_attributes(struct fsl_mc_io *mc_io, u32 cmd_flags,
 	attr->version.major = le16_to_cpu(rsp_params->major);
 	attr->version.minor = le16_to_cpu(rsp_params->minor);
 	attr->num_of_priorities = rsp_params->num_of_priorities;
+	attr->num_of_queues = rsp_params->num_of_queues;
 
 	return 0;
 }
@@ -240,7 +262,7 @@ EXPORT_SYMBOL_GPL(dpdmai_get_attributes);
  *
  * Return:	'0' on Success; Error code otherwise.
  */
-int dpdmai_set_rx_queue(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
+int dpdmai_set_rx_queue(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token, u8 queue_idx,
 			u8 priority, const struct dpdmai_rx_queue_cfg *cfg)
 {
 	struct dpdmai_cmd_queue *cmd_params;
@@ -252,11 +274,12 @@ int dpdmai_set_rx_queue(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 
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
@@ -274,7 +297,7 @@ EXPORT_SYMBOL_GPL(dpdmai_set_rx_queue);
  *
  * Return:	'0' on Success; Error code otherwise.
  */
-int dpdmai_get_rx_queue(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
+int dpdmai_get_rx_queue(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token, u8 queue_idx,
 			u8 priority, struct dpdmai_rx_queue_attr *attr)
 {
 	struct dpdmai_cmd_queue *cmd_params;
@@ -287,6 +310,7 @@ int dpdmai_get_rx_queue(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 
 	cmd_params = (struct dpdmai_cmd_queue *)cmd.params;
 	cmd_params->queue = priority;
+	cmd_params->queue_idx = queue_idx;
 
 	/* send command to mc*/
 	err = mc_send_command(mc_io, &cmd);
@@ -295,8 +319,8 @@ int dpdmai_get_rx_queue(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 
 	/* retrieve response parameters */
 	attr->dest_cfg.dest_id = le32_to_cpu(cmd_params->dest_id);
-	attr->dest_cfg.priority = cmd_params->priority;
-	attr->dest_cfg.dest_type = cmd_params->dest_type;
+	attr->dest_cfg.priority = cmd_params->dest_priority;
+	attr->dest_cfg.dest_type = FIELD_GET(DEST_TYPE_MASK, cmd_params->dest_type);
 	attr->user_ctx = le64_to_cpu(cmd_params->user_ctx);
 	attr->fqid = le32_to_cpu(cmd_params->fqid);
 
@@ -316,7 +340,7 @@ EXPORT_SYMBOL_GPL(dpdmai_get_rx_queue);
  * Return:	'0' on Success; Error code otherwise.
  */
 int dpdmai_get_tx_queue(struct fsl_mc_io *mc_io, u32 cmd_flags,
-			u16 token, u8 priority, u32 *fqid)
+			u16 token, u8 queue_idx, u8 priority, struct dpdmai_tx_queue_attr *attr)
 {
 	struct dpdmai_rsp_get_tx_queue *rsp_params;
 	struct dpdmai_cmd_queue *cmd_params;
@@ -329,6 +353,7 @@ int dpdmai_get_tx_queue(struct fsl_mc_io *mc_io, u32 cmd_flags,
 
 	cmd_params = (struct dpdmai_cmd_queue *)cmd.params;
 	cmd_params->queue = priority;
+	cmd_params->queue_idx = queue_idx;
 
 	/* send command to mc*/
 	err = mc_send_command(mc_io, &cmd);
@@ -338,7 +363,7 @@ int dpdmai_get_tx_queue(struct fsl_mc_io *mc_io, u32 cmd_flags,
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


