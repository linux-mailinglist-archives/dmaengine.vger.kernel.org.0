Return-Path: <dmaengine+bounces-996-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AFE84FF00
	for <lists+dmaengine@lfdr.de>; Fri,  9 Feb 2024 22:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B666B265E3
	for <lists+dmaengine@lfdr.de>; Fri,  9 Feb 2024 21:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771E0210FA;
	Fri,  9 Feb 2024 21:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HcbP1jmY"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2061.outbound.protection.outlook.com [40.107.104.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699EB1B268;
	Fri,  9 Feb 2024 21:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707514589; cv=fail; b=Uq0EuL7W1Hdcj8QAH9oypCcSz/JujuuThgmnvjZlh7icCzCb1oYiCJZDLTBQlUZmoekrj1DUzlvYMX95IlJiHnBF8Vn1oRy+FCzz5uI9adg+XKgpAQePCG3vJVyjvcq6zuiUvZE6pPFbEdtWdi4O3qNpYCE+f39ZOxdyp8w46WA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707514589; c=relaxed/simple;
	bh=GbaRWCp2XVRkw+90MR10wsdT8RAC20inXAGjN/iPJ00=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t0lVwhnjXLAFw2unDKEWJd/jeuGb0C8HeUoTLjFLoUvtdToKXis1+mdIGoKo9dL/wVVFa/nlqBNanUX8m2X+YW6B23XNX4V+S0kwEdxbDoOott3+GBmGPn8MR0VSqjJy8U3IpokTFfFxj4e55YCWM0dW132gmn2EUDjVXWM0ReM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=HcbP1jmY; arc=fail smtp.client-ip=40.107.104.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g8JUdxa9rNo2/ZEdbUGOfHIDHjzmpVm2/Zrv41YIgQVbNnTofJ4yK4cquc88M5veHQuOCE6Z4ieDJoBuplc+059WSmiU6cdIoIFoDPW4Ycv+FbGW0HK4zJeFN7Ml4chERaRB/vaNmDzQNHgFVB1lPE8tmg6smpuyrW57ksr8qOWLzzElGgONaHE3+9NQJzlzOYbg5N8WHVoOiKzYczGj8g8zbVX3kZxx3Ka6/AzIqbq02o9vzkNRchkiGHlaThEUFxyC5lgXTwRR9RYXmrNkUiLCy6aHqfGDMqfx9hxX/7DEjxbmZ3NmAaTvcx8l5ffPHGeYmhHPHXqQchloV4c9OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YrP2/nQTL0M7B4BZ7DGiXO1mITOdYQ+1nQszWsa05pg=;
 b=j5T0CWIayPaUJv1a5/uAMnzOhSsYwWNHCs8azneL3lS3IA/Egye4cD4zQeDjYsGu/Tk+0zK5icJxjvL7/QOGVwxzj4EwyJ/oSmnLB2nekZnC0CQO8GIU5as6MnWreLLAg7GQkozesXJzeX6zqIT5t28M+FqKExqUNEb9nBveD894JN2lwcKjpt24x+AaSpAYLbolASgVEUuWSyMHGBju2JbqL1WUD6oGuNT7FzbMJP0GEqGgpo/TNxN1L7gajRRepl9iVPVuYcQolfgeH+BSglmcEE+r+RGQk8s3evTvCW1OSHXDeBBQ/snC9g41dJCBk94qxdEhRNK/4Ji5o1Sxdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YrP2/nQTL0M7B4BZ7DGiXO1mITOdYQ+1nQszWsa05pg=;
 b=HcbP1jmYkjZ7lZLtc0eoPhGmKf4pxBSR755zkHh4NMsQJ3C1DAi4xz0/5E7YZC5TDgirS2OB2068yNZ3toJWmsl+ZFVZ6YsanQZZ6p4AdVKljdYiY2TKsd0boRx1AiJSC35G3rT2ZRGykEE1tsddGJjZNlHTWGLxPhlW9/8V1Y8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8800.eurprd04.prod.outlook.com (2603:10a6:102:20f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.27; Fri, 9 Feb
 2024 21:36:21 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7270.025; Fri, 9 Feb 2024
 21:36:21 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Vinod Koul <vkoul@kernel.org>,
	imx@lists.linux.dev (open list:FREESCALE eDMA DRIVER),
	dmaengine@vger.kernel.org (open list:FREESCALE eDMA DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/2] dmaengine: fsl-edma: use _Generic to handle difference type
Date: Fri,  9 Feb 2024 16:36:04 -0500
Message-Id: <20240209213606.367025-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240209213606.367025-1-Frank.Li@nxp.com>
References: <20240209213606.367025-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::8) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8800:EE_
X-MS-Office365-Filtering-Correlation-Id: ad64102a-d4e1-43f3-3795-08dc29b728a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PPWZmHxlLSBktIlsC+IqZZUcKzORpXIEYj9s93+PqvfXyyZBq8z4MoOvA09QRLD0oPcLqHR5fm1luQCpsCSpm3ivx/EDq79aynYhNN7AEV6tfq52mtuT6M6cW8BCaRSDaBbKvB15rJ1tb3A6vuKM99DIx5j1y6TF/zYi0g9E7kqyqpZN7Nw4IXBCZoam726oQ7qDR5mZUo1EMEGXQZAel4kwDV1myJC1HWHFS9T2Cgf4Y2XuzLQ1FQvfxgv+FHRT88XssI+1xAYOdwQxeI7DmiWj74zaMw9NkfJR+Lfr90aknB/j4UrxVoiVO7Son6nCovqYy6fpG7rP7D+18BIWk81JmbeIj3sM+HzqpRQfSh9+hslm022Yfpx/6jm8Ue+UhsPPAlvQd1SURrqOExzm2uqbPL6cfArc4sqpCAQVEpNoggKcl4CFOZf3v+OFjfOFupoHHgzOeKSn1HvSwskLRdPVFNmqXOQ4Cj5Sph/g0hyOte12bNEVd7f28BZtdPVucIflgaRrefzbdNO5h6Hp0b/4bqYvfz+IkxfHPeh2BkBRfPgXyPvpZ2sKQl/74d3ZS59wawygnsLEZVKxdJ0/vJvqpe3ORrSE3bw/B1MWe2iDJgBPHUML536Fz7pQn5Ic
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(366004)(39860400002)(136003)(230273577357003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(5660300002)(2906002)(41300700001)(38100700002)(86362001)(478600001)(38350700005)(6512007)(6506007)(6486002)(83380400001)(1076003)(66556008)(26005)(66946007)(66476007)(316002)(36756003)(8936002)(8676002)(2616005)(6666004)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dxZVB4l0K7L0+DbAHWT2veJIeeIpBKevvTJdnJ3EGv28aP58LXV0X68JhPoA?=
 =?us-ascii?Q?lSA5nIgL2PhfYVPEbmJqw7/dIi9fZwJu36sMjm2Ww4b3GIs+Ct5uJSMEA9ht?=
 =?us-ascii?Q?s1cxlcECGzOq6n84bt2HxCkpm3fARegpfyOpahZRT5SUsUU8O+0Ss3J2YOUR?=
 =?us-ascii?Q?QG6H7gf4nhqwtHm9tR28DiupsdbibeNCb8kJeUEKyc3aaWXvF+nhzQ7/QxIk?=
 =?us-ascii?Q?x0T01lwvMSej+cRKpmnodGsbcasCGWKAaLETuHjnjrAGOF/c3bZNmZ9eklNB?=
 =?us-ascii?Q?Mz2monyvl5JqhSz57/J9UxcatoTHvDi55UH/jxqMe7feKZrsi6TNzlP/sIu6?=
 =?us-ascii?Q?qzlvEDnbYfgiCyHoQgMmX/+MixU/JzP2cIwiLC7aGOjWz+ItBXliuCAF3pFU?=
 =?us-ascii?Q?hRaBdGMfvnEZEr9NoD9KkiRiFf/fVm585Ct2rlE7VvGQaWGc7k2zzREKVDN6?=
 =?us-ascii?Q?/FLcVD7lAW6omeiHlGqHG/DbZs9mN7l0682GzlSFTP07qBuy2A5/0qio34uV?=
 =?us-ascii?Q?braAvy98TTACp3Gua01ptsr5z+ggyg1S2ZvbTK1G+bu900Qo/oHkqioJEJYw?=
 =?us-ascii?Q?em51uVnLY0GzYV5mxdh17daO4ZyG7ujKkPe7mawjh3O4wFDM89yf8VqonH9u?=
 =?us-ascii?Q?Ec5Zcnpn/Q/dbIVflUxrfgol6bkV/n/3Z6iWXhQDGkqi/HkCTBQ1wB+vwAv3?=
 =?us-ascii?Q?xvvN3AkDwx+1bhDcxjK2M7KSDgZkgRDA5icvQuoYEvYx+X0ieK4aTDIDAKvI?=
 =?us-ascii?Q?acPxNZv/9M//HFvaTlcxs5a4iVaMDkjJd/KKJPMPMNzI8/Sz9xzy1aI25kU7?=
 =?us-ascii?Q?bz85f410f4KX0j9DsXNvbsR172CF8D9cFzxAl8xiN3oQffOKS8f0IqVaRTZt?=
 =?us-ascii?Q?Nk2Q1oaTzlSw98muMEsZnU/3VjPJ/OfdkL5fI5Mq35IyJzhPOKueUPhtnqrr?=
 =?us-ascii?Q?TilvJchMiVnQUN4CoTgmRhyHHSRYQAsVcGb50UZXWXuRM0PngwFwV5mUMqgg?=
 =?us-ascii?Q?NIR0Xvhj8iv8/J9u8y8BtPeCOYUlxLTqzWHfQrYd51YY17byA2ky/iHhv4zO?=
 =?us-ascii?Q?WmAx2rLvS1H/go4f33IjBbwiBzCgsmJnd5abFUwSWqG2liJzzRiKioIKE4mr?=
 =?us-ascii?Q?QMNQpdTGQzCA8Do1rh52ZzyQIROFAZGhfEWZe7ce7v20wFCv54guFzGasMXG?=
 =?us-ascii?Q?4+Zc3T2JWsQxM5wDDAQJIo8GKEDNEnMXjHvL4sOV6Yo7SRaTOts8VrBGuGhh?=
 =?us-ascii?Q?A1/8+dfZMKg69XATEk7t9vE2XNV1p2a2+7pFoUeoTkb6TkYBEKcR4Q133pJT?=
 =?us-ascii?Q?U5fJORoNDFBqFZMVrDZ98zscZqlfoXMgKlkDpEPTntbLsI9+rnZsLh/FKTjv?=
 =?us-ascii?Q?u6uqtq7oVxIZM35P0yk+xk6Ofi9Bp2yADQ8cCvHpoJ8vRNf19RdnOTKF4Aie?=
 =?us-ascii?Q?8VhSoLlruPcpN+UFZegxe8en81veazpgpiE4eOD9fQOLxRylXCjBbusR/brN?=
 =?us-ascii?Q?x1V2MCEV0FKGgRHqiDP/3S2ImstixN6HGKGBeVK0fdnO/e30o5gsFG0M/Ug8?=
 =?us-ascii?Q?Aw83ATbWPpj+4rhzqVY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad64102a-d4e1-43f3-3795-08dc29b728a3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 21:36:21.8865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WyQrTJVvmTA2hqiSTvitVtZFD6nLytG/2Ze9aUCFVCbYUvTiwGPiMMfmerwSBIjsCJE0Yn35TM4eOXfh/Chnqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8800

Introduce the use of C11 standard _Generic in the fsl-edma driver for
handling different TCD field types. Improve code clarity and help
compiler optimization.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v1 to v2
    - Fixed sparse build warnings

 drivers/dma/fsl-edma-common.h | 61 +++++++++++++----------------------
 1 file changed, 22 insertions(+), 39 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 365affd5b0764..cb3e0f00c80eb 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -255,12 +255,11 @@ static inline u32 fsl_edma_drvflags(struct fsl_edma_chan *fsl_chan)
 }
 
 #define edma_read_tcdreg_c(chan, _tcd,  __name)				\
-(sizeof((_tcd)->__name) == sizeof(u64) ?				\
-	edma_readq(chan->edma, &(_tcd)->__name) :			\
-		((sizeof((_tcd)->__name) == sizeof(u32)) ?		\
-			edma_readl(chan->edma, &(_tcd)->__name) :	\
-			edma_readw(chan->edma, &(_tcd)->__name)		\
-		))
+_Generic(((_tcd)->__name),						\
+	__iomem __le64 : edma_readq(chan->edma, &(_tcd)->__name),		\
+	__iomem __le32 : edma_readl(chan->edma, &(_tcd)->__name),		\
+	__iomem __le16 : edma_readw(chan->edma, &(_tcd)->__name)		\
+	)
 
 #define edma_read_tcdreg(chan, __name)								\
 ((fsl_edma_drvflags(chan) & FSL_EDMA_DRV_TCD64) ?						\
@@ -268,23 +267,13 @@ static inline u32 fsl_edma_drvflags(struct fsl_edma_chan *fsl_chan)
 	edma_read_tcdreg_c(chan, ((struct fsl_edma_hw_tcd __iomem *)chan->tcd), __name)		\
 )
 
-#define edma_write_tcdreg_c(chan, _tcd, _val, __name)				\
-do {										\
-	switch (sizeof(_tcd->__name)) {						\
-	case sizeof(u64):							\
-		edma_writeq(chan->edma, (u64 __force)_val, &_tcd->__name);	\
-		break;								\
-	case sizeof(u32):							\
-		edma_writel(chan->edma, (u32 __force)_val, &_tcd->__name);	\
-		break;								\
-	case sizeof(u16):							\
-		edma_writew(chan->edma, (u16 __force)_val, &_tcd->__name);	\
-		break;								\
-	case sizeof(u8):							\
-		edma_writeb(chan->edma, (u8 __force)_val, &_tcd->__name);	\
-		break;								\
-	}									\
-} while (0)
+#define edma_write_tcdreg_c(chan, _tcd, _val, __name)					\
+_Generic((_tcd->__name),								\
+	__iomem __le64 : edma_writeq(chan->edma, (u64 __force)(_val), &_tcd->__name),	\
+	__iomem __le32 : edma_writel(chan->edma, (u32 __force)(_val), &_tcd->__name),	\
+	__iomem __le16 : edma_writew(chan->edma, (u16 __force)(_val), &_tcd->__name),	\
+	__iomem u8 : edma_writeb(chan->edma, _val, &_tcd->__name)			\
+	)
 
 #define edma_write_tcdreg(chan, val, __name)							   \
 do {												   \
@@ -325,9 +314,11 @@ do {	\
 						 (((struct fsl_edma_hw_tcd *)_tcd)->_field))
 
 #define fsl_edma_le_to_cpu(x)						\
-(sizeof(x) == sizeof(u64) ? le64_to_cpu((__force __le64)(x)) :		\
-	(sizeof(x) == sizeof(u32) ? le32_to_cpu((__force __le32)(x)) :	\
-				    le16_to_cpu((__force __le16)(x))))
+_Generic((x),								\
+	__le64 : le64_to_cpu((x)),					\
+	__le32 : le32_to_cpu((x)),					\
+	__le16 : le16_to_cpu((x))					\
+)
 
 #define fsl_edma_get_tcd_to_cpu(_chan, _tcd, _field)				\
 (fsl_edma_drvflags(_chan) & FSL_EDMA_DRV_TCD64 ?				\
@@ -335,19 +326,11 @@ do {	\
 	fsl_edma_le_to_cpu(((struct fsl_edma_hw_tcd *)_tcd)->_field))
 
 #define fsl_edma_set_tcd_to_le_c(_tcd, _val, _field)					\
-do {											\
-	switch (sizeof((_tcd)->_field)) {						\
-	case sizeof(u64):								\
-		*(__force __le64 *)(&((_tcd)->_field)) = cpu_to_le64(_val);		\
-		break;									\
-	case sizeof(u32):								\
-		*(__force __le32 *)(&((_tcd)->_field)) = cpu_to_le32(_val);		\
-		break;									\
-	case sizeof(u16):								\
-		*(__force __le16 *)(&((_tcd)->_field)) = cpu_to_le16(_val);		\
-		break;									\
-	}										\
-} while (0)
+_Generic(((_tcd)->_field),								\
+	__le64 : (_tcd)->_field = cpu_to_le64(_val),					\
+	__le32 : (_tcd)->_field = cpu_to_le32(_val),					\
+	__le16 : (_tcd)->_field = cpu_to_le16(_val)					\
+)
 
 #define fsl_edma_set_tcd_to_le(_chan, _tcd, _val, _field)	\
 do {								\
-- 
2.34.1


