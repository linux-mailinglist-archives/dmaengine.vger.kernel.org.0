Return-Path: <dmaengine+bounces-2500-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FD09122A4
	for <lists+dmaengine@lfdr.de>; Fri, 21 Jun 2024 12:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F23F1F22020
	for <lists+dmaengine@lfdr.de>; Fri, 21 Jun 2024 10:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAD6172BD6;
	Fri, 21 Jun 2024 10:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JRAZhS79"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2054.outbound.protection.outlook.com [40.107.105.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5703D172777;
	Fri, 21 Jun 2024 10:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718966487; cv=fail; b=Of1m+fjy9sSdNDlAImsHvkPSd3dhQGPOfsTiAM7BFJ5WnVHCc1a/KWjT0qoiAI7fOehkwl96VaOzkn25kNlKTozVHizcrN5KmkPVAqU66Z0QdwOiVIqy6z/U1MXYTvXX+pN2pJ/Xpk+1QjVZuCoGp2DTTVzcC1YfIn9KfGEHpZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718966487; c=relaxed/simple;
	bh=V2GZjVy9d6hIFC65fPx1jk85QtP6FXiWczCAh+s0dPE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VPw2UAa6YEaRATEbhPUUy83lt5KFwnO863FD5s3u7pnRWpzhMR7hhc2QQXy+C4D6UlFVpfMjqPLH3ylyAMEreym7VXGAN78kU2cbSZX3ZblEUz5KAshqSXDa9C2Se3LX3hXSwZ42yfRCLjAjSmcJoQsgRBNNPmUQdIV9wGEZuKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=JRAZhS79; arc=fail smtp.client-ip=40.107.105.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jjejqIEWGMkSOm0DqL335JBO/qg82zul5x2kDD1zjSBiddLFdrNeP5h5kxfvFqPnMohYgItKXNRbWwKq589d2eqo477iqmMAOlXSgufnPs7z1HVxmfzZ78YB8FsPwAq/uBh3OfcAEP+HGPeg10FDXYUSQZ0CxIVmGb5DYO37suXrRltfbGmGRXR1fgHsmjdSQWnT7M5wkSNDWUVmHbtj5GpXSsGV2DCNtKV/K5dEKEs5GnBfnF4pJPFpTjTOEVHY596brxtkanJEEDPdq65HQLJfVrccJKOyuAGdKPjycuX30FT3lcJDT+TX1MDquJnTj+tUqMJFpPUVJzioibrb7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yGVHcmKrcHmkrt25sIGDO9TlY8rLCNdFfdzBKqoDV3k=;
 b=LtcgU6GPG7CYtv2yacoVah2Cr+Undz9lV432oqE16ZmEi3dBLqG748/JC3HIe23BkdGn2pt787V3F4BExFWZYHy+CYcAM6S5zC3aysGaWXnbpDt8KMGbEHszGStdN/KKeauRLDXfK6z75HsY1O1LxHiEJcFIQIQ1ZDKloYHUEQdvjP1WjJRINu5YndsB+ktghDgBVPU1pIAlGgLhQglbt44LalTo0NuMJs96w/absk3o73gq+4UsHlvxvxw9dSlsbYwwJjJetrKmf2ALz1TtE+MRV1XwFVzwT6CYvuVDmZ12rSDScbbcZ4+V3U0Z+yezaF1O8psVimmlAZzbqv+coQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGVHcmKrcHmkrt25sIGDO9TlY8rLCNdFfdzBKqoDV3k=;
 b=JRAZhS791D8mWxZfPHmbeC7SOXSn9/PhoVK0PAbPSrfRb1rRudJG3sDsr3K1R77puatIRhAnbDphpmxU6h9UegHWlgYi7yx1dgVM4Ji/qpFLi2Ce8PG1mPcSjtUiIY5dUixr6TowFqQhf++TjHdwQPMD1UiBMoqKtFvwE8bqiNY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by PAWPR04MB9768.eurprd04.prod.outlook.com (2603:10a6:102:381::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 10:41:22 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%5]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 10:41:22 +0000
From: Joy Zou <joy.zou@nxp.com>
To: Frank.Li@nxp.com,
	vkoul@kernel.org
Cc: imx@lists.linux.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] dmaengine: fsl-edma: change to guard(mutex) within fsl_edma3_xlate()
Date: Fri, 21 Jun 2024 18:49:31 +0800
Message-Id: <20240621104932.4116137-2-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240621104932.4116137-1-joy.zou@nxp.com>
References: <20240621104932.4116137-1-joy.zou@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: c197540a-15b0-42ee-6039-08dc91deb176
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|52116011|1800799021|366013|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kze4IQT23MAYgI3MTCUyrkRsIqleWAbAaJKF14gXggVYtndwc8TaWHK6TzPZ?=
 =?us-ascii?Q?nDQikTWsnd72y3mdbCm25CTle5Q16OwXt58dCsMK0g4Hg4pBTS6qk/YS2N7Y?=
 =?us-ascii?Q?CbEV6vZVRqs5imv5cwLQHM7dKOR5zc+nFDvN7kR2gE7ZP7hgAVNV/cNiY8xr?=
 =?us-ascii?Q?rN9ja9hDInF2OAxs8ocqilv1xJTuP9yoRjfeIThzJQ48vJp9LGLZBaZ458wq?=
 =?us-ascii?Q?WpNYnSyhIa5e//Qjn+uMPNGO+i4fI8Po2U6tUNJV83yrQFbbE8yf4x1e1MTv?=
 =?us-ascii?Q?y2i3BTYo2gDMa7lZNnp0kle2yGmT/Afo80atuZjBFmrLV7VM4FuZIqMlxJ9F?=
 =?us-ascii?Q?W8KHcGRx6y9z1d1qufUd5xJfkkAkngYZpN8la9qF3BS3+nizu7laI7tK2H9/?=
 =?us-ascii?Q?yxTpnT3NQJjg8f6Y6Hsh7s1419SJVFgoieu5H3T0gCh6Iga37W1VXiohyP8x?=
 =?us-ascii?Q?UhM6GlkjJ7WKDyKphtBj/E0IzzozO/pXm0qN5NVvCWX4OZzD3hQSyalOfBgv?=
 =?us-ascii?Q?yBraH2vu1ZMV952xykW7aSRy0gY8MeWDWPkLoSHvaFgWUulNgStbRrAAPSaU?=
 =?us-ascii?Q?gwCETjktXD1b5l+hn+Ml/vbjdKPdVXOgL7ywRDIhxqyHOHSOtR+0jjidbzTb?=
 =?us-ascii?Q?mu1Gi8s9LSuVZqHaozA5n9/wsQssxq3Q918PpS65aJZEE0jQ1WxXFaN4JSsO?=
 =?us-ascii?Q?MQ1RxXmlIAArkLhP/6udY87Xqexo3eCjxyRMyd0gi95zGU+X6aXMNwZ5gFEv?=
 =?us-ascii?Q?X4+1KYOeQf5Z5RVCVKyEJmOSIkZYNBu5vjCH48J7PTiyhrZVXL3Ykhk62c1d?=
 =?us-ascii?Q?06rjNrFfAblP9ke7j51QIO0dePaNQ/22nN9HOpfOM4YW8Rwh3R44NiR+RSi0?=
 =?us-ascii?Q?KNCOkSicT2nUzyD2rYb1avYDPvKTvMOrg1XJITPAg2M11Z2DGfmK+p7JYBAd?=
 =?us-ascii?Q?nUi0MiiQmEKAgEoBVHh5/9TyE5bffNlB92CmY9utX5/pjMTjv+hjNjV4YiOC?=
 =?us-ascii?Q?pSyuIlFTOJvCZ31Kxk+ZzDNi8UXOghry/T1wK8cYMcBGuqPx4Dr3TkKBHTk4?=
 =?us-ascii?Q?oLeeED8OKUX6mf9hyzOFz/KHO105y117fq627qQRtNw30yDzvSnLZOsJ0lem?=
 =?us-ascii?Q?lBLAfXuGkmRBuZJgvDjAL1J5B1aY9NXBFCKxP4g6QXdxGDFlnE4zul6UaE+3?=
 =?us-ascii?Q?Vu2gETUV3DesEg3jj/WaCK+DJs9Q/BoTz9SjpD3EXMF8HUHZ6/OtaiqGBnSm?=
 =?us-ascii?Q?ZAFfTTnr7Y4d/7LGRSPtABl/g/RFZvLEC9FXlqHejgH+uxJv1sj2JkYHjPKo?=
 =?us-ascii?Q?NFKogPBE9waqLzdTa3r99QhP7GjRxATWuHFHEuPJtZnn0ySC+FSCk6yN7Z4i?=
 =?us-ascii?Q?cTsFqEU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(52116011)(1800799021)(366013)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RAXXMsOweIH3y08WWTajwzszBcGCk2YhPBo5AHhzw9zz6+sBPKnFey+9Obmj?=
 =?us-ascii?Q?UqErQEr2Y6g/U9VchdeuoNSaZwFYn7o13u+CjzCCdXgATJcKkejYOzBf5Sm5?=
 =?us-ascii?Q?VwpNwF3lMczYRTMg13Av/lSDiXdqHjvKVhOiFNxag0PXJelgU3WG3YB4FLSd?=
 =?us-ascii?Q?1R/wedTaFGqQzsPH+zBUONn90uYS+rvPxQp1P5K55EOEPRqybsUiA0tmZNDa?=
 =?us-ascii?Q?yC68IFsx0AV3OZLtRfjcY5gm4dgpu93zsAmNl+L5iNCbR5wLHHVQ+/0MZlE1?=
 =?us-ascii?Q?PXd3cRCi8FqwHl3truRlKIh78GHEIpK8HiKAlB1JF/m7aTR31Eh3tZ5+cCjE?=
 =?us-ascii?Q?77/aU9yV9D49Lf9nvT7HDdO25zd4GkuFNbv62KFC/BHEXlZShMPE8m9yNTjv?=
 =?us-ascii?Q?yPjca/McCnoWs0+zugLDOfh/63MW2ohLadCahxllrVs4gvXf+pSpINJcq0uy?=
 =?us-ascii?Q?1ybZjCm+ZbEIUt1i4poTPrG0361eEY4Qcblw1Ch4j5M6vayuMIeWh8bfzY5f?=
 =?us-ascii?Q?VzYcnqBnOcDwclgwzF1KbWRXXCrW3pW6RYLqaVO1vlYK1FDM3Vy6byEtuS3F?=
 =?us-ascii?Q?A0cZJ04jOXPmQQnoG1WIUMz0sArpq/CweLKO2S5bxYCBGYu0LE1rqpyyZ1C/?=
 =?us-ascii?Q?RWUw8jEARQzRTDOWBvEjLGLUYu+7B8XyKDSYqiht1NZOdIGtYob6ZqvpjbOt?=
 =?us-ascii?Q?6/n4v6FYop0vQpxoc4o5ZjONUhltaxN1JBg5NBycTHIjOcsDe4WKAswbky21?=
 =?us-ascii?Q?ZX4er4ARubQa3KSScH4eN+wWvxEgB+6fqROV3vnfBrcf1nsk0U8cag9/cRF4?=
 =?us-ascii?Q?PQc0EZjpwwie2fxUzY3f4DovuUNqu6gUkAUvqlrQ5hzB3jCAr3/GJEZNfgX4?=
 =?us-ascii?Q?lDPy6MuLTVikA7/7knOXOxEEXMLd7+PdWEkhgoq4ww+AN7UPSxoQgfg+DREi?=
 =?us-ascii?Q?cVYfBRUDOZjrC1/mJh+xXoUTq0Mk9BZLIkHKbOSA+ptmQc9DuorNtcW9lL5N?=
 =?us-ascii?Q?ZAfwWHDowSBLiSPURIkVSk2Axro8j7krrLSOJkbVjwOBeMZThdzHll8/6eAc?=
 =?us-ascii?Q?CAg6KuINo/ATreCLPsISo/dpJom4NRSpl53oRaZl+XpMTuW+9pzu6SBPIQSz?=
 =?us-ascii?Q?hcTWkcol0b2CczPbOW9nSuvD8ind0iLh4G0yo/2pyK6hDOD9OGL5pP9mBMKw?=
 =?us-ascii?Q?vQb7KpGCh8LZPqsWzyGPtGZ032QAKXHPDf5J5x+m9DmIpxbAVc/Sb2WRp8CZ?=
 =?us-ascii?Q?hhxhJIXXGdlO/B6vksbhwq5ACyYpd7ezY3dETxAn+8VaT79SjXBTAhtfrXpO?=
 =?us-ascii?Q?EyO7tjWU7pLn15on+dtmf9XPP1yAN8jq5cZflfWjWV+iViGjp+rnkItPeyVI?=
 =?us-ascii?Q?rLXrhgCFrz2ljcMDxRpawrHO+ZFQBQqJH8ee5hiTctDLpoMzBw8E9QwBIs/J?=
 =?us-ascii?Q?qR5s4UnVRdkvbYfw/fdIguddAmQTvmMKsTOEkJ7wXl0f0Pga9/QzrnnNCGtB?=
 =?us-ascii?Q?cOUCrRk/F29ydruSKcbQs46yg9YzE7VMVnT6PsOEFs252yNFT7npZSuDNSY+?=
 =?us-ascii?Q?rubckWrrdKEXY85FN9Dy01J8I/RBMqUE+nuT8Z6w?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c197540a-15b0-42ee-6039-08dc91deb176
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 10:41:22.7311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EPYjUtshK0CGyLV9qNE+2KU4l+dgepBKHEG+h5IWeCuIg9iD6Pj2ftBkQzHeVITq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9768

Introduce a scope guard to automatically unlock the mutex within
fsl_edma3_xlate() to simplify the code.

Prepare to add source ID checks in the future.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
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


