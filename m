Return-Path: <dmaengine+bounces-2604-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 925FA91D855
	for <lists+dmaengine@lfdr.de>; Mon,  1 Jul 2024 08:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06D281F22934
	for <lists+dmaengine@lfdr.de>; Mon,  1 Jul 2024 06:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF33155C0A;
	Mon,  1 Jul 2024 06:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hnw9EWLK"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2041.outbound.protection.outlook.com [40.107.103.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AA177115;
	Mon,  1 Jul 2024 06:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719816832; cv=fail; b=I6o4yICJ81S9QQpZB8rVzEykpFg06oRnBvPml1VO6M+6PNTwWqZiNzWIYkwnSc4nRM2Z3oyHWG2nrO3sjaaZ5cJ9zhiI170IcCZim9ETQ8Tiqf4/9AwRQA79UZlRQGGAR9QTErrQcCX1/4pukIgXiuvlddzVc7lKUxowDRK8bdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719816832; c=relaxed/simple;
	bh=NDTJIgAegFIozxC9+swgr7SUy0tnaRrm8nlGWqvt948=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rfi5tIo0SCKMWWlc+fNAmeXldPi80IKwYkBOOrs7KAQnEzDndBtD/gAK/epazMZPaJyOGrFQF9RCu4vwGqxzs58MG5YdB6WoObeo5BTy2dtsJ+OsSB4w1V6nONYHfWZoIcB9kkc1zyGdXviccy+/08Re9vR3E5oIBwLW5e/eaQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=hnw9EWLK; arc=fail smtp.client-ip=40.107.103.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZyDdk5OIcLcEntIbLSVsrWUjEiAVyl5Pm2YNh8LcOHqkFguy3l/RT+dCdJvtcYpI1RSODJblPBo5DkqWIZg6AxVXkwqWKJS16T0rr5fnjvXaexkmR5eXJsfh3snPoObYPfWi6ktRDWak5cAZhL5CvXR8Bv3HkXqYzVFi0uOn1qtnVjLR7GKTUNwGjM48USYsXZIodPKlEnQPlgWV6J7O+HleRy0Y3c/iinAcOpaC3zKjlqoy5sOXxdnsa8Y2UARs+4NT9GRPe0dzRk4bhFdVgheX02lUSvlEImanHdNGuPu2MkweWHlz5p8kQbC55w/pwJCC0KEOZfUDNwANubwgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vMMD/tAJ0S5PqEZIVxIaQvWS06U8Vo4nuziAsPM4FF8=;
 b=oW9vyPrjlPlgojjZ5+5LBLulmDho4XCElP91w3Bl73VHIGeg75NhL/QXEINmWzb6VrCMNDrCFEYJR2ggKsA6rqVRC+JukbUlW0/xNqM43/PPmodc2gQARlRxBW0XILL/bNCAHeLpNjRiJgpG9TN4bjwLAYG8UJyFkdHLIDnxLK5GzvxBDT/HW3f7E+oVAEGeNK2yIji2PGopU8E7GU4U+6zZUiL8d4xW23HT434TxdUDd9F5/Y7Qi4ZJnZ73nx13J/Qt70N3F7YS1Ifswk0XlCU8zi1vQGtC3qTDXmRKiiBZvHd3q/JJ4CaaeChzX+ksJseHg4rMHOcrJNXBK+VHOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMMD/tAJ0S5PqEZIVxIaQvWS06U8Vo4nuziAsPM4FF8=;
 b=hnw9EWLK2T/z83IrsK+XHYgoBLXcgwWPx6aSCRgDlAnyRo5RCRDX9Uh+BJoh9rRlUYdEVbXn9LsaY9qZnGrrfbfPatrPiC0RIuUKsdKcTBNwpOOoXU9tfohGW1ibIY/3+7XuUow7H3t4Z1i92ZHR4lWCHaHSsXpPNFMjoZlMPII=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by PA1PR04MB10601.eurprd04.prod.outlook.com (2603:10a6:102:488::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Mon, 1 Jul
 2024 06:53:47 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%5]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 06:53:47 +0000
From: Joy Zou <joy.zou@nxp.com>
To: Frank.Li@nxp.com,
	vkoul@kernel.org
Cc: imx@lists.linux.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] dmaengine: fsl-edma: add edma src ID check at request channel
Date: Mon,  1 Jul 2024 15:02:32 +0800
Message-Id: <20240701070232.2519179-3-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240701070232.2519179-1-joy.zou@nxp.com>
References: <20240701070232.2519179-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0183.apcprd06.prod.outlook.com (2603:1096:4:1::15)
 To AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|PA1PR04MB10601:EE_
X-MS-Office365-Filtering-Correlation-Id: 2661ccad-a93c-4987-ef46-08dc999a8e25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9a3P44E/3X4ZJU1CFrrdvTRqfj9ZCPICekNBd6pFCrCYJsoPkeXKeXRsf3Dk?=
 =?us-ascii?Q?gBK6zJRS2he0LlJT30Bp5mGPDE3O5W0ifL0/WdMI+16QuLOQ5pV24qg/O1bS?=
 =?us-ascii?Q?cSgrPqn6xyAdxos21WzD4biW2oRFfeD6wWSHyQkMveds7sDhM5ZslBDl1phF?=
 =?us-ascii?Q?2JLyFPSXSeBwJ2GMqcOhfhFttGidET7pxodLCMuCNuDJl0TWFgDt1jKwDofB?=
 =?us-ascii?Q?W/KjHE4n41DGAB+BihKhPZrmYZJTKV43qNn7+8KJPURUzVEt05yp3KxggWFV?=
 =?us-ascii?Q?xFtdUv+LTbBNpEy2CxwNjQ7X2crnJkvQze0mbD2Jv2WrrLoe1/C8Q/k5F/n1?=
 =?us-ascii?Q?ozPhGNnPYZv8A7mDzmsyUapKNagsC2TXEu1vTRaTlyi58Rgdp8iWW99pXATd?=
 =?us-ascii?Q?XPYm6TzC33wKsefLL09pAyb5aAgzci5YdOaw1Wv/sm7sb3opScWHkEKbJozS?=
 =?us-ascii?Q?KTp2qWQlDFOGYdTljG2i3HYDvXez/mptUkAnXzYghUOF0pAi4Wo9YUFMmbZF?=
 =?us-ascii?Q?s6/QxSx14n7VGRWfN/2h3zzGjkEnMJJ1vD7oxeZ7jTyZVJYifH9r+6uEViGv?=
 =?us-ascii?Q?JpNp7vYR7G5fLb5MiFF4iqjZl3SJZyN+9aWgjqYy2ccfgiuN4fJdDsT1xpnf?=
 =?us-ascii?Q?SP/V88NvMad5pO7cJ6/3NyA1QJpY4Re7izj3TkQYMtUUpFrYf7nLKECDH91x?=
 =?us-ascii?Q?6H3NYGIs2dsIREtDm9TOzL6FQ/tye6WPyWYgRmDaB3DNu9eGE1jKrycDI1n8?=
 =?us-ascii?Q?Lu+c+nJ++R1i3rEWGk8zfMDck8x5qBw+50msM94c5YWtDI59hdPSFU6NFHur?=
 =?us-ascii?Q?3FSanB/OOKXe8pm16Mzpi5sopsTrxiHPg/p3VdoohIoKlWZxxJznl0pRGpi8?=
 =?us-ascii?Q?mljOQdu6sP5t+MmIvExuVLPC3jkV6ToE/RvLnLItNFCLFdVgbBh7uAr4MZW1?=
 =?us-ascii?Q?2UGiAW7l+/S8DKydjpoOqEOsTQjLHDp9d4fytuyFF56l7SlUU+qCDfWOuw5U?=
 =?us-ascii?Q?6FYjhpANI+4a4pEAxO0mQ+OhM3imay5AQ9R6o3uwjmNRV3jFBExuc6eOIZOG?=
 =?us-ascii?Q?iVzqfZtYW1UD/EC027aI0SQjrkcTh7b60+781SIVoH+FUo+lLFtb8xxxhhTJ?=
 =?us-ascii?Q?PP9rlzYn/LuZzzIF58L80TpO3tRLk2eYeMhTYy0fXrPFGcPaTw/IKAnZuS+0?=
 =?us-ascii?Q?h5VKB5c6IeZhxDPUq7y86ENaoCWpruJVM2RFzazGJi69Yw2XaOMRB8wqvGKf?=
 =?us-ascii?Q?lE7nHpJBt8aLVP+waTN1iR53ySCqEWmZ52ajWtHQAsMOpqlPlKgKMO1E1ebn?=
 =?us-ascii?Q?ZqAa+DhurEy5Y1KVuKrbAetqvB4bAts3oj6c3283SN27Mq9xVjQMo66tULpB?=
 =?us-ascii?Q?Adj7evZlyGXcr6wRJ7ye1MqfumPcbDwl2KpJFN07upKwsjkJNw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mGgwhffdRgo1ngpL3lW13vIXFThUlr8NPhZyKrXV2fyL5tLazz5qO3HZqVMW?=
 =?us-ascii?Q?mmV9YBwO8PWHO9uHFl8qY1ZgbRYClMLCRDMkmj0dftPiOZgyStMHra3pGR+j?=
 =?us-ascii?Q?4NwRdBh2CX+cmPfjb32w/pGaPAboNZ013j48Ds2qQdCW8VnIM565XU93IiRc?=
 =?us-ascii?Q?KF3VY/6q5+uu9T0AqDQkULV0a3ATBE0XhJacp5BY6B7BF3E3F2bGbPIDLRxZ?=
 =?us-ascii?Q?1WW5LklhgTmy0AWS+A0EeLk0VGaII6LbDo9+sVEKQSz+bY1e/CVePtE8GyPb?=
 =?us-ascii?Q?Xqspic1jPCMGkTG6XajiS2u6vbLrbUkh1oMXDDLRMZXi+fU27Kyzl88HrhNV?=
 =?us-ascii?Q?8nErZAHHbwnQ+l3Gi4+3oqa1jWuhScnDMeNkGzaZ6wW0ndhFYmy8sSzUq8Bo?=
 =?us-ascii?Q?XNxp1TRL64/9L1MetQqzCRrU5rrfkK8NNSIsNqVEMac2fSSDg73FY4JPc3sK?=
 =?us-ascii?Q?Qhsd/ybJCKpIZmSAi1wZArqR5B3noLFmUkwxoKlU/jOCnPZKc8AkW7KHtLkQ?=
 =?us-ascii?Q?7rvAJmOuh8zl7NW5uAz3aLzT/ytDwKuFGIW2drUi7rIjFahcHeiNEDOPahRB?=
 =?us-ascii?Q?dZ3iqA+/Cxz73i5g/pQ+r1//kXgnmhhOotbuuUzYTlJyRSUlLcfcmm5AO2Uc?=
 =?us-ascii?Q?dmyPJ3skkBk4ZfHZc33nrVyNgRqu+PuuNl+GjmDTbq7CH3dfsZi3ahwUxOVB?=
 =?us-ascii?Q?NyjEWv1Jnwknp31KpUpNpupsgrZpMQghjic5WgQIXGJxzmsilKX6F+dZ1U2I?=
 =?us-ascii?Q?HP1DfW45RpUBVK3XiVnzssloPabq+fEU3e0kZ3uxrYxMt/tq0UVyGd8ElEY0?=
 =?us-ascii?Q?Sx7FLd9mdh7XF+IXM4jR1GnsVN6bBf26CRVSB5HzmXj0dX0EKCNjMS7Qsecw?=
 =?us-ascii?Q?vdKF0KEJ/0D8balhA+CayEznelg7br6kmPIYqEX49lQB/xDRHumSVlbTwROr?=
 =?us-ascii?Q?qKRetQOOtelTegx+VRZqcJrL51URWsJHc0gq0FJ4e2yCqIYEmi+LRsPmgr//?=
 =?us-ascii?Q?l/1URNBbVi1SY2923NeKqkeZc9Ip6umqYwraa4bzUWkRhzMp1XrfsIyjkk/t?=
 =?us-ascii?Q?6Y7LWKGrMuVNZHVs0JRRygJECyzHn3QsdyQz/yEtJo+z/Jt7+RwY9RgJOxIX?=
 =?us-ascii?Q?QyWOQ/s8G7fIifEEzw29zJz0roSOqhfEDlA4pedCs4BbjZDUcHnVl8MfvLer?=
 =?us-ascii?Q?gfokVvCoVZgK2+BoMDaQO0Fb5MT414uoOkYQ29YLsC7cvlEyh5FgHkJQ+rKv?=
 =?us-ascii?Q?Sq6ZSsVC5FhhLWgV2WopBLCFThauNPr9Sglndh77txlMOLKsrRTWwjlWEq7h?=
 =?us-ascii?Q?tVauuNUWo08Sb7ywimzaK67xEkZPpLSr5VDrDTBm2TZkxuMcF+k/7gw4QOdj?=
 =?us-ascii?Q?dMC0rsOuAY2eCnP+dOotHRiIMNobOQ6JrYt4N3y1h00KR1SH+PTTWmpa3Viz?=
 =?us-ascii?Q?KzV3VuSOGK0lbfYzBo5PY38MV4uqyrjTH8g8yjdBGho4IB/VJ3HgA0ZgIho2?=
 =?us-ascii?Q?5LIXbD7Bu9AKmPLBNh43UUaVPx+7B41h2SgI9xkaCwVXRZNqTUnNtUAipvBF?=
 =?us-ascii?Q?5UQus1R2MrGM2yYJ0hu3uM00ZFYYld2tuRRphIGX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2661ccad-a93c-4987-ef46-08dc999a8e25
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 06:53:47.0772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O6Iq4NC87x7LDtX0AX4Jz5UrYSl4EsY3xv+SQL4RT/Ufc+2FqXpsh6K77HQNunoH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10601

Check src ID to detect misuse of same src ID for multiple DMA channels.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-main.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index d4f29ece69f5..f9f1eda79254 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -100,6 +100,22 @@ static irqreturn_t fsl_edma_irq_handler(int irq, void *dev_id)
 	return fsl_edma_err_handler(irq, dev_id);
 }
 
+static bool fsl_edma_srcid_in_use(struct fsl_edma_engine *fsl_edma, u32 srcid)
+{
+	struct fsl_edma_chan *fsl_chan;
+	int i;
+
+	for (i = 0; i < fsl_edma->n_chans; i++) {
+		fsl_chan = &fsl_edma->chans[i];
+
+		if (fsl_chan->srcid && srcid == fsl_chan->srcid) {
+			dev_err(&fsl_chan->pdev->dev, "The srcid is in use, can't use!");
+			return true;
+		}
+	}
+	return false;
+}
+
 static struct dma_chan *fsl_edma_xlate(struct of_phandle_args *dma_spec,
 		struct of_dma *ofdma)
 {
@@ -117,6 +133,10 @@ static struct dma_chan *fsl_edma_xlate(struct of_phandle_args *dma_spec,
 	list_for_each_entry_safe(chan, _chan, &fsl_edma->dma_dev.channels, device_node) {
 		if (chan->client_count)
 			continue;
+
+		if (fsl_edma_srcid_in_use(fsl_edma, dma_spec->args[1]))
+			return NULL;
+
 		if ((chan->chan_id / chans_per_mux) == dma_spec->args[0]) {
 			chan = dma_get_slave_channel(chan);
 			if (chan) {
@@ -161,6 +181,8 @@ static struct dma_chan *fsl_edma3_xlate(struct of_phandle_args *dma_spec,
 			continue;
 
 		fsl_chan = to_fsl_edma_chan(chan);
+		if (fsl_edma_srcid_in_use(fsl_edma, dma_spec->args[0]))
+			return NULL;
 		i = fsl_chan - fsl_edma->chans;
 
 		fsl_chan->priority = dma_spec->args[1];
-- 
2.37.1


