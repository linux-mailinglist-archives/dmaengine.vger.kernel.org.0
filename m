Return-Path: <dmaengine+bounces-2603-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF6F91D853
	for <lists+dmaengine@lfdr.de>; Mon,  1 Jul 2024 08:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DCEE281877
	for <lists+dmaengine@lfdr.de>; Mon,  1 Jul 2024 06:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504175F876;
	Mon,  1 Jul 2024 06:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eqsyeIYQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2078.outbound.protection.outlook.com [40.107.103.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3250153365;
	Mon,  1 Jul 2024 06:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719816826; cv=fail; b=RSda2PnSKNUvHQdbPYhz3OC+VeoQ3+/MaYHYzbBAnSlkLZziG67UByzAL8Sq0Gx9bnE1Sd9qQVwy11RNrQAt4bg0CvELKXYPebk/yCtWkwDxx/Ll8M+fwLGIPBwHxtb/VUM2hnmPFim8b4re56+ZMp+RHbIPQjxu7kO/XlBu3Cg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719816826; c=relaxed/simple;
	bh=aHaElDJTewort6Rd+7fdaGEeH272bL3guiaaUbxnlfE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UqnKaNLQQCcQf3tf8QhOW4HqgFKTJAQV4KmESCwIBhTUallMh73saJHsuWeOvYqv/uv7UoUJQUrbvPl7cV9FlXm1Z6nl+I0Rt4sPwhy2VgoEVCs1SFSn3d5mm/KGeQlFafDe8gqxH6xBIKSqbopEvNuso+gWjfKetW18RldMAZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=eqsyeIYQ; arc=fail smtp.client-ip=40.107.103.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N8lgcfYnVPW0CP6LPPVKFnFljjuHg0sNq39uprV6HWAo30JqEC4tnzrEvitbfz7A1+HkXnzQuuTmJuLBDZbSby/ERi/pQHsq5dEE8qqjMKqSe8xfPgcNKucVCDnx0u+Y2oBEFXQvM+JN2jxTc8J0fwbKmPxORVPnOsxea72wPP1lYsh5emQ18925/bevJdWQGRmI1zEqp6W5dNfiU2AqO3QJetTl9sDEdnFJijMSuL2wEKFrhwqFdKTwXqF3XoKGhAyQ2RRGZDIz3pBlBpCLn4ZVA07pCIdKWdIdDXAMpqvXPi+6nOiVjgB/k/TDhvQY7VShM1W+zOSo2cXURivyLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixPUvjRV0+w0DM61woEtHzrBm2OT1JGYWtFDKWa1hXY=;
 b=RBJqrIqRtw121NQLc4MRDmFO1KpLMxLT4kFYtp8T/NygJpQ1WaCyvE0PyeDBTbVP+s70F4mRrpH0L5L+9dGQQnwvHv1Puv21R4KB13m1Hni1a5g9H0itBaikvuF4BDjKdBrXn+zdqqXrBuwRwi7gUX99zJNZVlBO858pyikpo1yi8nQVFGGgufzvfNNYZL9QO3EaxHf8Y33+iW66+D9OVN4VBK+5PQnsrU+ZpVa6phyhmDDSrxK/6RX0NQMNw9/LtzVSK6DLB//QZ5uWEH1EX+uleGfN0CFP6dqqV/BfVEYHMNkbPJGH22Edhvv7tB6aERnGZQyLzcu1iqUv1A+0Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixPUvjRV0+w0DM61woEtHzrBm2OT1JGYWtFDKWa1hXY=;
 b=eqsyeIYQca7zRL6r+MGhsL03BoVKfftYh6SHNdPOroJkeJT2cgs+wbEhdLNNG1/T6NjLXqnD3emfKqwIFF8e8L45nUSGckq3GDFudlgvdZaodgKb1ZlQ0JtlJxRp3Mg6mKIkn+lw6+V1PeTEj8ePj64UGBGn6CxWcfSK3eVS5sk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by PA1PR04MB10601.eurprd04.prod.outlook.com (2603:10a6:102:488::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Mon, 1 Jul
 2024 06:53:42 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%5]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 06:53:42 +0000
From: Joy Zou <joy.zou@nxp.com>
To: Frank.Li@nxp.com,
	vkoul@kernel.org
Cc: imx@lists.linux.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dmaengine: fsl-edma: change to guard(mutex) within fsl_edma3_xlate()
Date: Mon,  1 Jul 2024 15:02:31 +0800
Message-Id: <20240701070232.2519179-2-joy.zou@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6b2b3ce7-b28d-495a-2ec7-08dc999a8ba7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HCStHHYCX79HXDmoMPGJaMFX3O4wNXDzuGB06hlsLgHy1qW2Uxy54ZhW7kx1?=
 =?us-ascii?Q?1iJYv4ze0og1cfgKyKuFZeobxO3aMH/Dq4YZbHkT1gnlH7jWRcYpHYwMwev+?=
 =?us-ascii?Q?dInPAKXkeU7/Sbv8P3IDrib8pa2c5JeG3GDdm4yK9L6F16zbQzx3JVZNb5qz?=
 =?us-ascii?Q?vaROpbs0K7l0POSMthM8Ct2HUpiZDuEBt4n3X4OQmQGC/a26wk1wSlKFANsK?=
 =?us-ascii?Q?GtWKJpHGhwg4oUBYWWcb/avO5bp42DPhGlNjhVw48q3biUQnljzKvNIJQ5tm?=
 =?us-ascii?Q?Z4BSep4SWbPS6K4wUbvvNfSN2TzkrpB7Nc0c6uCJ2Sofi8TV67CD7RIuDkg4?=
 =?us-ascii?Q?ovIHrNr+A8/g0jL7t/l+oeagSTfpthmUlL4hb5teWyifiDcc1FBm8cVeOQZM?=
 =?us-ascii?Q?KPWv1KSOMXX1d1nsPmISBMMudZ7qO2JbRIqeZMnIUcO7QMWekq0OTsnn27iR?=
 =?us-ascii?Q?826q+2ZAGEzVRdWf4WVvjy3Y0iUnj+D8pyd7teSiDzgtvL5/M0o0xcFWMXfZ?=
 =?us-ascii?Q?HDrdii2/w1QWmLgKz9NAswLLQfjo1wNqu0BNFbOeCRcgn5vxJNJwLXLZvr+F?=
 =?us-ascii?Q?Y6E7MlLdNMSMyvMCoiSN9e/TKS1PHrkLEKY52PCnekTDAu9VDbk2nuk/BHQG?=
 =?us-ascii?Q?iKr/A21LYvmOdhUaj7BEVq9AX0U25fvZpYEjrX0eX9w2jZnNl9zhigfqCY0G?=
 =?us-ascii?Q?Am/lAgG7DpEn7z5QE86vYJbLMNuy5fw5NS5uKQB2oPx0pJy0Nsh+7TOJhEiP?=
 =?us-ascii?Q?NB1xXsKErKUDHpYhZA9wtL/NV6SCxr1iYfLJ3iuV1pKxDwxU/n2gdOUUix8m?=
 =?us-ascii?Q?ofUdeBm6fGzYeNQRrYnJKD4t0u/gkCw3QCHQZT3Dm+VnwdjIQIk3Wh8+kAlU?=
 =?us-ascii?Q?tET+mKw5cte7587M6e347BHn3FVRt1fdAB6J7azUN1bYf1Ys3WPyCLyWpcas?=
 =?us-ascii?Q?jkKv3I6zYNmbW7oZy8r28SEOjNtkp5iSp3OYWeWHnDa0DNinc+6S3F9MJ/MQ?=
 =?us-ascii?Q?A+D4BALgMICWS1CyIh5LYmU0LHlOzRYMQoiLTFibNxmQt+R0r2lrBzZsEcCD?=
 =?us-ascii?Q?6Y4lL7ebcUUw6yaOq4J2ZnLtZuBnOjSNOWsQwMO+dvgRXeSRXssMQ8zsQ5lT?=
 =?us-ascii?Q?BfLrKRjtkQxqxE7D+gJX+reqOe6msOMvSSMym4cffWkCRX7WBcA14hfukQdY?=
 =?us-ascii?Q?uCzkYc1vX8thVxjIoV2CReF4xFaNZ045chBL8kaupr4lKDQjNkyJ7cI4vbuw?=
 =?us-ascii?Q?yUoTmXz8FDH68fxDmj7LlH5D/hhO++KGYXx+WJiih2d1WmpE8uGlGCkUtt3I?=
 =?us-ascii?Q?PVmzslYgt1Aw2aotf0iKDSF7qM6N3ip0Mzb2WsoWRjun7Vc0jjtRSl1AqFrK?=
 =?us-ascii?Q?K+Amv+ku2ZO7bPMl/s3Pi23pqP8BaxfeaW7h1UQojBMYnwS0CA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nuoKtLCqls5QfXZ1dcoAS16FMJwh8DpxpgoyynEJPW0sUB8vut2jWHi5/FWn?=
 =?us-ascii?Q?Ii4XRUjpXUF+Q+3tqQL5swhpW0uZmGiTObptQMJfMFvxnmcGT8ecKWSbbzog?=
 =?us-ascii?Q?49zaKCGSFmib/Uu2+ECYC0bqlyzK+wTKg2OXnKYvr9Ss3akZhklWPkQXqS10?=
 =?us-ascii?Q?5P90aE7WEfLfDTL/RiCI0pPYksEwgSaXP2PZEcGs6X82G0CYLSd56mBJsLFq?=
 =?us-ascii?Q?oxLRCanggLaVlJc8IjeX6bavu7ben6vZph4wKPKQsZ6pnhkQ5lQk3Q2LvwkG?=
 =?us-ascii?Q?8vXYYZ+mTjSQh7zNmEUa3FAbs5eqcjd/3BTq/K3mIbd7VlEuccXhUocb0sHg?=
 =?us-ascii?Q?7z6l1lDeyyIKrz7HcwYqcbbZpdoZ/OLbyiybR7mT/RodGMIPHUnR9eEzTLev?=
 =?us-ascii?Q?TwskcCrayBrJkpBGe7n9PP0VuY99JVTPHIxBln0vxmdSWTVmLLhHI3+RpEh2?=
 =?us-ascii?Q?6TlOtYpXHvLpo344QQJ+BtUFuc3MePj3jecbdaTfjSwL2/BrmRi2VppNigMG?=
 =?us-ascii?Q?ObTLw982ak7ZuvJ5gOWa5U4/PmX4QXBdbHJ7rYcqMva4xSGW1nndapI1aWH1?=
 =?us-ascii?Q?Fugz33PSryyWZQgCfOxawablFPebbhtPeKBI8nc1Y1OyHL1LNsUE1VeXhN7W?=
 =?us-ascii?Q?KXaIdoNWo8AK+rKBD1MigkddtSv2Gh06NsObLXMfGT6HOyYobyFTJ7EJBIBE?=
 =?us-ascii?Q?+w11Y0f3xZLkAfVBvE/krAGd4sl7zGIxa1qKZmxEpLdfyAo6y7cAgrdBzhv8?=
 =?us-ascii?Q?Gw/inkLxTuKMAUc/J1bI8qPtCbPHxYzqdqxcCSCp1CKm1i3KOv+rm76+WpmD?=
 =?us-ascii?Q?vjnzYxNhTrSqW6l3XNuMVjdc7hCEUPxRlX5DytjcHydtfvUmlGQupmARBzfN?=
 =?us-ascii?Q?+6BjvRQJndvio/BpuQC19QUSnC9NQJzipHeVjti6n83WT8vLd9bm9z9XT5U/?=
 =?us-ascii?Q?DVv0haMi/Q6Y8Lt7/LclRp8qIXNaj4wDM8F33NNLhChQp+TA3gD8ECLS8jwk?=
 =?us-ascii?Q?v/ASwBtEjn7fUl/SoznTLI6dF5dSioT0OWCw2WpUU2AB7ZqYysnlrEvLnEQP?=
 =?us-ascii?Q?ySSRAvwkm29s7lISYUT3W8EC6g9a8gMnUl3aXnQD/yP5np761Qk/9rmi8AEB?=
 =?us-ascii?Q?0VpfWaJsB/VkbR5+kWDoGTB2AuQdibCXBoiUlQaC1zJIzG5K+Er4Vm8gbsk8?=
 =?us-ascii?Q?2Wa/CH1FiFVKSBzbxMuSSzcCr94TuYNI8J7IzmO+f2G0xUr8sZ3W2/aEew6p?=
 =?us-ascii?Q?BNo9v9PBz6D8iVk1u4Zh3uvkFc2owNTbFFd/Z5vhlV5/P15Nx6LS2dHTB3JH?=
 =?us-ascii?Q?jokinNoOoNwau/oYVL4NJ4yKLFhNXQBhFnLwjVfAHt7X8HtolldOLDHGk2+p?=
 =?us-ascii?Q?bN0KcycH0WbYq5zBK8WuUF/QUFQP82JXximGjrDr7Ewibl0Z6qhndDkyeWUF?=
 =?us-ascii?Q?d4cttzoVkIdPusylIG2jO+ZLuLIxDA0I9Qg8Mwg7s+D1lj/YIkxM2pVCBHar?=
 =?us-ascii?Q?WPpsYkHls5PUbUTAEPk3MTnwDpAnrhpKS06jfJl9l5vH1FAgMUgusLrkxt+a?=
 =?us-ascii?Q?WTSetgNLNKGZkbZnSQjcaLMmFW5W2bEBLgRB/sD6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b2b3ce7-b28d-495a-2ec7-08dc999a8ba7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 06:53:42.8991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XwxuPQXpASp2DNoKAJaq6LZ1RLJ3g9eCBw5ByFx5++vwsp9JLT/azVwhJR/V6pib
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10601

Introduce a scope guard to automatically unlock the mutex within
fsl_edma3_xlate() to simplify the code.

Prepare to add source ID checks in the future.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-main.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index c66185c5a199..d4f29ece69f5 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -153,7 +153,7 @@ static struct dma_chan *fsl_edma3_xlate(struct of_phandle_args *dma_spec,
 
 	b_chmux = !!(fsl_edma->drvdata->flags & FSL_EDMA_DRV_HAS_CHMUX);
 
-	mutex_lock(&fsl_edma->fsl_edma_mutex);
+	guard(mutex)(&fsl_edma->fsl_edma_mutex);
 	list_for_each_entry_safe(chan, _chan, &fsl_edma->dma_dev.channels,
 					device_node) {
 
@@ -177,18 +177,15 @@ static struct dma_chan *fsl_edma3_xlate(struct of_phandle_args *dma_spec,
 		if (!b_chmux && i == dma_spec->args[0]) {
 			chan = dma_get_slave_channel(chan);
 			chan->device->privatecnt++;
-			mutex_unlock(&fsl_edma->fsl_edma_mutex);
 			return chan;
 		} else if (b_chmux && !fsl_chan->srcid) {
 			/* if controller support channel mux, choose a free channel */
 			chan = dma_get_slave_channel(chan);
 			chan->device->privatecnt++;
 			fsl_chan->srcid = dma_spec->args[0];
-			mutex_unlock(&fsl_edma->fsl_edma_mutex);
 			return chan;
 		}
 	}
-	mutex_unlock(&fsl_edma->fsl_edma_mutex);
 	return NULL;
 }
 
-- 
2.37.1


