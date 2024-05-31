Return-Path: <dmaengine+bounces-2239-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C158D6B23
	for <lists+dmaengine@lfdr.de>; Fri, 31 May 2024 23:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01DF11C24AE8
	for <lists+dmaengine@lfdr.de>; Fri, 31 May 2024 21:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F57478C75;
	Fri, 31 May 2024 21:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EiMiGml5"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2055.outbound.protection.outlook.com [40.107.7.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF883BB48;
	Fri, 31 May 2024 21:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717189340; cv=fail; b=EwF+7Xo1nMPUeNFt8SEc2MKuenKiBF2vohziUs3SEXfYKTEhrQiHQOAYPgu+STgggs3ynxDp4pBXtUfRM9NKk8kqsWFUG90bcq5hQrGfWPB41M8o8r5+iXEkoF1vV+4umkw6z/9fu2bsSCLVpEeaZk5f6PX3hX7CjP4+NvdNzoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717189340; c=relaxed/simple;
	bh=B9usMufM/cKSi2dR2e9N7oRRS95a2+JAS73/tt6r+YE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HSG9BVGLr3n5BhJVKgU751gnydXqPnWgS2BRzsPNBMvXvj23Zvo+jG2G6N37GY3wvFc8G7x+C4VtG6yAAYqYyNfEgCwR1hRCdSEvtDhmhkNE/ZhRdA7H0DJ0iq/5LgaowB8MtsYgtuF04m37FegHcb0pIujngmK5RlUeuXqzX/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=EiMiGml5; arc=fail smtp.client-ip=40.107.7.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cjQI3cJRLJvNbbC1CxkZEWZ83J+/dEB/8wt5Suq85R2zjb4dABEnL6Xma/pbw4iK8eQ9S+yc2nUZ3ExjmttFbj0hG985m/UgfCSQbIBMfKGCa7L3n57RlhPyW46wiaqCq7iHLHViw6YBVAyMVA17S5ISxH+GHUywrkethF+9yah6K7o3SjNRnc38XOTv3ZiuyUNhHn+gSXmD2Newcsbj98P9E2ysZbUQ70ZdhI2LSdqXOWUuqxuFLzxFeWC8gD7ptuTAjQi5rN/0mB0SKS881J3dbq2DItaEHisB97V7hhX7i/IGh4vL6EqE3n/j8xNmmtTNijGx3qBo/7SoRZp2SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1e9ST5ojHmoOpizX5pWEyTGphsVCAuYfEYUYZGChEU=;
 b=MmwzgmXwuq0c+dFF4sxL7s6DjL61J+iSv1seILi3D0/TfBzLkvKjzdT598Io7aZAtxcvOKWUa9RbZoIpsRXat1A4BrME2Lnh9WzamntU1rGHFBaXsTUlv75mAQWB7vpELkATjcLeWmLwjjfv9aPo+ABYZ6OnB4cNrTUilN9AA2SaQByiRQwkhUcZC49DjJ8koR7zH8SEOl0cSDFM/eCkbrR+M1Yfbv1sgxPwzfbvSRpyI9y2EyFRLN/erkt2gJgHLaMP9H1wFbUf6g4ENwzKj3DkO2l3mX7brLiMXk9UDy+OzzzAvmvSBmoAbkDVdtaUbZH7De4vopMnkWVmfVhCsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1e9ST5ojHmoOpizX5pWEyTGphsVCAuYfEYUYZGChEU=;
 b=EiMiGml5jOH6BlxPME+x0XhzKcHZJdxqVeKg79VCjf8iYGc37a8WvxGajkMs63EzUzG/9PvOyYLagqNCRgD016DR3D67aStSv00valfB5c/0ZGnaGNQIOEV2E0XStixWgY5hZAP6d4S0wTTakMBz5fq3q/2Bg3Eu8gMQR1cewJU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9232.eurprd04.prod.outlook.com (2603:10a6:102:2ba::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.23; Fri, 31 May
 2024 21:02:14 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.018; Fri, 31 May 2024
 21:02:14 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Vinod Koul <vkoul@kernel.org>,
	imx@lists.linux.dev (open list:FREESCALE eDMA DRIVER),
	dmaengine@vger.kernel.org (open list:FREESCALE eDMA DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] dmaengine: fsl-edma: remove redundant "idle" field from fsl_chan
Date: Fri, 31 May 2024 17:01:52 -0400
Message-Id: <20240531210152.1878443-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531210152.1878443-1-Frank.Li@nxp.com>
References: <20240531210152.1878443-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0215.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9232:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c44edb7-94cc-4000-e6d4-08dc81b4f280
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|1800799015|52116005|376005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rCsJzYEucNmdrdf0MpbnM2LupAqVH9yDIofgJFkCanOUF96IQnryvX/3rKzS?=
 =?us-ascii?Q?/tX8fOi8ZdyiToMQdg3d6wRnz12b9HWPI84jzDt4oSU+NyadsNJ6N6DIwsic?=
 =?us-ascii?Q?x1wZGCQpg6bV5cT8PmvIIq3nia+8Jitv46K2o7fPiVOPylm/34n7NNphAoN5?=
 =?us-ascii?Q?r891TOgIl1ScbP/CeL1XnWQbKiHzi5I9PsCEJM1rdzIHK7Fgk5UtFG+Opz+5?=
 =?us-ascii?Q?CdMk13XvL6u9Kw3OG/XdHaUVE9aAV6XtT+g6tBRNP/V2FwqkiurgnbvrYwRa?=
 =?us-ascii?Q?z+I2zj1mk51gpWP0InuTJ2BvzNWPTIymryEiAk1/tbnZSZ3y4HNo6M/gzpMw?=
 =?us-ascii?Q?J7Wksb3Ed4jU89QnVMyeDgPcDho5Xyrdhweg+wuV0j2YJsa9GsGTTSjST6cx?=
 =?us-ascii?Q?jThjL6R88ZdsVo4aofpzfO4xH6kXr0R0aFTFREvx+P5JlciYL3P20VBbqMrA?=
 =?us-ascii?Q?I3LT5WMHmC3lJ83if5uLVWe8zda7tznrNlfwRm52JA8JSIbImc09nei3L5Lg?=
 =?us-ascii?Q?rv6qki7X4kNTpNIpLfzfE4uklw2vQA6fkShwoDCGqn+Au4eZp4P1GLD29k+W?=
 =?us-ascii?Q?ePcv9wwqpbmD3cgWvY7A2qZpwe6hCpy0JKwoez/GHg6yVKbfpusVz0Lyixwd?=
 =?us-ascii?Q?6LwH6JkrGDzsyZfan3v/dKHS79lTA0lR2rOL62UcuqRGrtDjOkxbZr86O7Ma?=
 =?us-ascii?Q?tEQ/VYI2CPNQxsjOZqJJZIfWqn8D7+A2ugfs53HhtOYTZDpxIVNaSuBhI6V5?=
 =?us-ascii?Q?tEY/VlJ13cVnZWo8esgwCBCyC6EU0EzM4Jrb+DLZabKhurR8K10z1dFs0gOZ?=
 =?us-ascii?Q?OLQxva5EZ+WEOzJgWlz1gxRCmLlZFINbQDg8XZZH50BWZIWP9IfYrmpfGoCV?=
 =?us-ascii?Q?qrXhsnxvTceV7jfYIHe08NCG1FrHxaCRDJRD07LCiLGrAzuWUM/mZJ0gDzw2?=
 =?us-ascii?Q?wpuR0NIjLQdQA9XC0cNXGq7IgCPDaM5WCQ7SbnTbPN+tkvU/nxG7FvtKTGLF?=
 =?us-ascii?Q?0okYLnqDi7ULycDSodDWedQF9mdOH53a2YSJpsmN2G8XwMRoh5nvpwOdKDKG?=
 =?us-ascii?Q?os4DRBhxoTNbqscwV1LdXbDYIWkieI4RIhqttxBgNQ2aNug6h/zFbcpaR73f?=
 =?us-ascii?Q?DHdPJlQLxzGzTQ+cPyKP8p73XsHtL7wDi37NgW7Er9ncbpYGR3U/sgXnzNrx?=
 =?us-ascii?Q?MIQiww77BRzO8Cx4HlG5jhFv38KYH43nUP98YKGfXWvSc6roUDa5tuPpKUNV?=
 =?us-ascii?Q?1L89h2eCxKMPiaO7bs2eYADcsO7rGEhttVA+UG02vOc48Yo5u/FCbB9cnbQH?=
 =?us-ascii?Q?IOWkFSQpaznwN6EJd1D44c0USHdaX+WNZ7XfEBPROot4cw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(52116005)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EXIFYLGA93Ix4dd4N/g3iQ/1cqQWSoF8h3rIucJn80Svd+DD+mUnTyKgNU8B?=
 =?us-ascii?Q?YUIu16Cx0G57SuO4G3cM7GoXVMDdr8v2YwzYrmYFUlyC1bJ7KkRiIy7190Fu?=
 =?us-ascii?Q?2cuxsCWAvGXEFwVQQs7E5fi+Tymr0zjKq+s1PyVBZc9ofbRPiqeUDi5VCPr8?=
 =?us-ascii?Q?SGEcGl9LgW4NUK3y2lKFD3G2M/bi7vCrSHMEoKAvnGiYZSEcSCl7972lNMN+?=
 =?us-ascii?Q?ZxEMBVnyvNxmuHmvhtyKsOflN0y7GD1zhpQpYsGGtiVEA+dIGY1Rhg/FD734?=
 =?us-ascii?Q?9StFyMVh4gVF9KG+WRvhfjoTkydInwctVJKuL2eSFOsygRq+PxYrH/z0GUov?=
 =?us-ascii?Q?hYKVJsUrmUPhtAJRYxzo1XHr0+fE3AOw33GvZKU7eWhQR0CGfDWk8Qgy0gzR?=
 =?us-ascii?Q?nFV+yn/v30lL/DQUp9E7thSr8QEhCd1krd7KbAgG7aAXY/Zsh8EGrxjaab48?=
 =?us-ascii?Q?55Dktku2TrWUCM1kHGBuSTk0FBoGRV8Y+bf2V9lbve1ZVCPjflIkU5RGviDz?=
 =?us-ascii?Q?6sawB5kngaZiPWhLLXTdQbpOtByfuEg62/GFTaM1jWOErCfTTNiQagvGjDD+?=
 =?us-ascii?Q?PLvxNL+uYK/wnrhnKh9Z3FaQkakrvcy36emlET0S467GzfaTzn1/pP+/OSpt?=
 =?us-ascii?Q?tLZ3zHplp67UiDftFEwDajeaQyYnEGcbjTyequJdBXOsud3SmtlCiNPL5f3c?=
 =?us-ascii?Q?/taRKcNQgwFflEWenjBoAx7SMxCdg7y62p0pvkZVgFrmdJRhpoEtADkFwo3s?=
 =?us-ascii?Q?Diz8rWkUMthncc7F8lokKrWEzcY9LV4PlA6T3+539P2ZpjZ+qrfKikYSHCX0?=
 =?us-ascii?Q?1QtChb3dEFpWdzOtatRZzYSp/9ULQLoCchDsspJDjgkBC1RINHGf2Dqj+5rc?=
 =?us-ascii?Q?P+5tjPVE/v6acJ2lOfrj7jYz0Owm+AVy9U7KP62ueGKhTfNzvtLuaF2S+u4T?=
 =?us-ascii?Q?kKnsvagCatdig2vwKokPbwQk9VgX1Gb7u9YY0Ay/YpUS3MGG00gM8qnr8Co9?=
 =?us-ascii?Q?fS/BSJduxshxgWlR95zCMGrf7KauX7IuHH5/Ukb+QwElyjYBcpMQEKr3pYLo?=
 =?us-ascii?Q?2kQtbh9/unt3DlRRwCfkbSel1P9cP5Awufk5S7txJ0hGC6KnAPki6HYD3tVs?=
 =?us-ascii?Q?AWv6M5Fyy9OI7hOo7Bf0IXKbDmIZuOKSB1LDZgjEDFofrKn0Zx/BQZh6tcQm?=
 =?us-ascii?Q?1FnSRsLRMJrfY7KQS3BYlInbvQ7EjL+kUTRr40G0Jpl1vfIM0oCWCsdPuaeH?=
 =?us-ascii?Q?FJZTsZvdAMnSs2LIyXtdkGXPwv9SIeqeu75GfUYKcqbEnTjuUA5OLbmWfgJu?=
 =?us-ascii?Q?+zdJjzdCuZs1SWGZUEmfxeUKZFUShwTG5LC6piAa9LO0RysOeaXHCD/suyHX?=
 =?us-ascii?Q?74iQrkaosqZrVv3TSBzitHNeYkhgzrNpjcKxudJRe6AARM/glN0bEN+9Yfm0?=
 =?us-ascii?Q?s9fwjaVIkf7vL23sGSlhFvH9ftL6SghqlLNds859wUni2A3y33wVc1UmRq/k?=
 =?us-ascii?Q?X2JCP9Z1HL3N7IKBT3yv31uAc86A3HIIoCo3Bejxa71jMKPhi0wMcl6mjNuB?=
 =?us-ascii?Q?XMKe4380ae0bFjLffvmMNXemVONuWzI3B6qsDGVn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c44edb7-94cc-4000-e6d4-08dc81b4f280
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 21:02:14.4004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K7FTN15LBo7Y5x7t61ZKpmaLSRsfrELfacmp5t8rme7l2aREtbe+BsZ/UvVP55yfix/c54x+PUtuMFHWCg8ltA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9232

The 'idle' in fsl_chan is redundant as it's equivalent to
'status != DMA_IN_PROGRESS'. So remote it to simple code logic.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-common.c | 6 +-----
 drivers/dma/fsl-edma-common.h | 2 --
 drivers/dma/fsl-edma-main.c   | 3 +--
 3 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 91a4c11b7cbfd..e31dcc127708d 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -59,7 +59,6 @@ void fsl_edma_tx_chan_handler(struct fsl_edma_chan *fsl_chan)
 		vchan_cookie_complete(&fsl_chan->edesc->vdesc);
 		fsl_chan->edesc = NULL;
 		fsl_chan->status = DMA_COMPLETE;
-		fsl_chan->idle = true;
 	} else {
 		vchan_cyclic_callback(&fsl_chan->edesc->vdesc);
 	}
@@ -239,7 +238,7 @@ int fsl_edma_terminate_all(struct dma_chan *chan)
 	spin_lock_irqsave(&fsl_chan->vchan.lock, flags);
 	fsl_edma_disable_request(fsl_chan);
 	fsl_chan->edesc = NULL;
-	fsl_chan->idle = true;
+	fsl_chan->status = DMA_COMPLETE;
 	vchan_get_all_descriptors(&fsl_chan->vchan, &head);
 	spin_unlock_irqrestore(&fsl_chan->vchan.lock, flags);
 	vchan_dma_desc_free_list(&fsl_chan->vchan, &head);
@@ -259,7 +258,6 @@ int fsl_edma_pause(struct dma_chan *chan)
 	if (fsl_chan->edesc) {
 		fsl_edma_disable_request(fsl_chan);
 		fsl_chan->status = DMA_PAUSED;
-		fsl_chan->idle = true;
 	}
 	spin_unlock_irqrestore(&fsl_chan->vchan.lock, flags);
 	return 0;
@@ -274,7 +272,6 @@ int fsl_edma_resume(struct dma_chan *chan)
 	if (fsl_chan->edesc) {
 		fsl_edma_enable_request(fsl_chan);
 		fsl_chan->status = DMA_IN_PROGRESS;
-		fsl_chan->idle = false;
 	}
 	spin_unlock_irqrestore(&fsl_chan->vchan.lock, flags);
 	return 0;
@@ -780,7 +777,6 @@ void fsl_edma_xfer_desc(struct fsl_edma_chan *fsl_chan)
 	fsl_edma_set_tcd_regs(fsl_chan, fsl_chan->edesc->tcd[0].vtcd);
 	fsl_edma_enable_request(fsl_chan);
 	fsl_chan->status = DMA_IN_PROGRESS;
-	fsl_chan->idle = false;
 }
 
 void fsl_edma_issue_pending(struct dma_chan *chan)
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index c5a766da02b88..b846cfe0a7fc6 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -150,7 +150,6 @@ struct fsl_edma_chan {
 	struct virt_dma_chan		vchan;
 	enum dma_status			status;
 	enum fsl_edma_pm_state		pm_state;
-	bool				idle;
 	struct fsl_edma_engine		*edma;
 	struct fsl_edma_desc		*edesc;
 	struct dma_slave_config		cfg;
@@ -456,7 +455,6 @@ static inline struct fsl_edma_desc *to_fsl_edma_desc(struct virt_dma_desc *vd)
 static inline void fsl_edma_err_chan_handler(struct fsl_edma_chan *fsl_chan)
 {
 	fsl_chan->status = DMA_ERROR;
-	fsl_chan->idle = true;
 }
 
 void fsl_edma_tx_chan_handler(struct fsl_edma_chan *fsl_chan);
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 82ac56be2d832..af05166ed251f 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -544,7 +544,6 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		fsl_chan->edma = fsl_edma;
 		fsl_chan->pm_state = RUNNING;
 		fsl_chan->srcid = 0;
-		fsl_chan->idle = true;
 		fsl_chan->dma_dir = DMA_NONE;
 		fsl_chan->vchan.desc_free = fsl_edma_free_desc;
 
@@ -669,7 +668,7 @@ static int fsl_edma_suspend_late(struct device *dev)
 			continue;
 		spin_lock_irqsave(&fsl_chan->vchan.lock, flags);
 		/* Make sure chan is idle or will force disable. */
-		if (unlikely(!fsl_chan->idle)) {
+		if (unlikely(fsl_chan->status == DMA_IN_PROGRESS)) {
 			dev_warn(dev, "WARN: There is non-idle channel.");
 			fsl_edma_disable_request(fsl_chan);
 			fsl_edma_chan_mux(fsl_chan, 0, false);
-- 
2.34.1


