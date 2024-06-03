Return-Path: <dmaengine+bounces-2247-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 975738D85F5
	for <lists+dmaengine@lfdr.de>; Mon,  3 Jun 2024 17:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C05C283CC1
	for <lists+dmaengine@lfdr.de>; Mon,  3 Jun 2024 15:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA41B130A4D;
	Mon,  3 Jun 2024 15:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SZc1LeD7"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2053.outbound.protection.outlook.com [40.107.13.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978DD12FF8B;
	Mon,  3 Jun 2024 15:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717428217; cv=fail; b=i3RZF3wpuUBwTU6fmFoh0WsmlBwbyRuD/Ynvb5hI/8jQy0JEleJTa1XMHTzIwlLth5jrRqFeYVazbBwkWHUx8b6DcY2e5fI/Dv0L9uiX4lR+ncGXPq9gppSDRU/pYCZOHQI+NMVIa83guPyJr+lnfujF7/q5Nw5lwUZItyStvqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717428217; c=relaxed/simple;
	bh=3Iplv631NWl55AVG49oXrkiGJT/8mska1/a5dTVLp0o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uzDQbQCdBwgQECa8vkhdJI0KG8gr3gm6IUiX9j69t1rx3hNy8giVEGDvnu2fMYHAHeSCnaN/mL6195NNkaNMOl8nhBCvBGqgvbSWkkhes1I33JT3A2zvK/T06lXRoF7xAm/WayPPPuJA234+cr0C50luQnjFOPdds7JSKuxUX80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=SZc1LeD7; arc=fail smtp.client-ip=40.107.13.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZKNzyRnXejRJr3GJGYV9hav0FBxxwnba0f55cwKYjyDZ9xN6iP0SLY9FleCzw80Oz8UQvQf7+OYKe4169LhDdh9heFkOLN2HLOYzXZRt/u7rBZpTCF+N7l9UxsJdwmRusPfDK5+Imoo1k/dincJWSrNpyNN/DdflvdjjiikDK0aTLUlpZkgjQfcS0QkbjKNGgq+9LI476xg4aWBLr0cVyLP4wxCqVWueJLGG7snQLs9yj8ZE3NCnvCIJ6VrIyAqSVJQc158bWRG5WmJ3D6W5ave0wh3oPLD7lxYRJlXFPUVctTpXAEWU4sRpwXmyTGS4kmw6T1CRLOgAZAxsmVZiwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ro8mhtjonCwWBYscZA88GaoXM8W8XvWKbYlgOdmek74=;
 b=QlsRb7J8u/gW2DZ1pOeIL8cQcy5d3bpYiBjRXZwEl4gzDn+9K8cDGST3xnyqvD3eX9NqjMAmr0c1DWlFSp+fXex1k+/Mc2UVPH4HNbMHz2yCTfimqujfdYkJ9KP96ZaCtmzGx11PES1A88a2Idb1JhnDuBjivzLwZ+VOyFi7pUJXev/CX9VKAdbOIhqO2X1HP1r3HtTCNXgRpZsvz62Hqf+HaeaNlpYTM50+sTK1tDDmR3hJw6QVcOiHUSwQkkBpnJk80D4KwsnHmPCO5d5lcqFR0jupTZKfptrR4w3XyLnayuRoiO+DmvabXsfasB8KP7k9gpCWXMwg91k8q5UNHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ro8mhtjonCwWBYscZA88GaoXM8W8XvWKbYlgOdmek74=;
 b=SZc1LeD7GQ0AxSPOYZc1ZtBHEMVdg66nrAdWkKbOqtffuU055/fKLtUBOIlsovSyUO5uV0qsZ1Rf0QQtYIspUkSX4T9AP1qmjfaaflCKgo8aqmQF322vx/Nt41hR1PYMuC69cSWiWAtOakTfAbke1KA/sOPFY+b+PUyiRcaw6aU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS4PR04MB9243.eurprd04.prod.outlook.com (2603:10a6:20b:4e2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Mon, 3 Jun
 2024 15:23:30 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 15:23:30 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Vinod Koul <vkoul@kernel.org>,
	imx@lists.linux.dev (open list:FREESCALE eDMA DRIVER),
	dmaengine@vger.kernel.org (open list:FREESCALE eDMA DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH v2 2/2] dmaengine: fsl-edma: remove redundant "idle" field from fsl_chan
Date: Mon,  3 Jun 2024 11:23:16 -0400
Message-Id: <20240603152317.69917-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240603152317.69917-1-Frank.Li@nxp.com>
References: <20240603152317.69917-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0047.namprd17.prod.outlook.com
 (2603:10b6:a03:167::24) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS4PR04MB9243:EE_
X-MS-Office365-Filtering-Correlation-Id: 33bec09a-a198-4d57-15d3-08dc83e11ffb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|52116005|1800799015|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iiY3DCtHfnlWCIRW4g96TX0Q5Er6gRIcelPyaWn/5LA9mQHk6epkjJUBZkg2?=
 =?us-ascii?Q?vfZq4t8yprpfppLk4B+brQkhwkTdRUPma9yWFohaYGeK8LW5U54s+btwUyxa?=
 =?us-ascii?Q?J5S1U5u2IeMHy8G8qBtDNhhh9b7FB564PG/4IE+87BrRPGYwSiydLnHUs0kW?=
 =?us-ascii?Q?+UA1hnwLwMCcqlpUB777FliPP6vst9q6cEk+NJVqxYGiN5x1CbqcvI+Sh5n9?=
 =?us-ascii?Q?aHdZH0Y07uKOhQIHC+cS9b0euVtUVopJwstF0RRelsjHVAorY7ThKRTX/cBG?=
 =?us-ascii?Q?0uGW7Aeejgi5Lboc9abXG9YPMNhSyaV5v/iRz/fDmhu45PXufz10DjvbZJdW?=
 =?us-ascii?Q?5pzeoR27LkoPmDa9T3erNm+kBBshWdpljuTfNk7pVww8Fi5K2ka6qUF6FN0I?=
 =?us-ascii?Q?lmkvanRW16dqgdf6wU2Lrtma87yYAU88TlRpSqQLKuq1xXTC98ly2clClbyT?=
 =?us-ascii?Q?3Jk9rtg/Y8b8t8oSAKjqozP+js3o4T5skzlcDZ440ALwbfKAAEKaU5wQ3WtW?=
 =?us-ascii?Q?n1KGmK+giqfyNXEcuvYhGa4B1iCBhmoPFPxIeAhQyG5go5L2mIFiJ++IqNHo?=
 =?us-ascii?Q?sKK8tO0RMEkK3tLuIuwFzD1SYB2/OCrnmQ2ewpm53p7+c+8gUmF48yUPmCyw?=
 =?us-ascii?Q?To0ZsugwL4zQAjKbxPUkKXbMjx2H4M9GTGwpJU1y8dQXtXei+gSJbnXGftla?=
 =?us-ascii?Q?oPF4Ks+rLgcRfg6by5JyTUcRLyI4zCZgiXMVFizZJSnaasMQjbLtUB+6n51D?=
 =?us-ascii?Q?AHkC2HU/qdvyLePUrxYr23yZSJDK3Gn7p3Mk5jvREKinj7yIR9OPcz0pFlBz?=
 =?us-ascii?Q?aePjHxE3mWMtHLqcHBHS5U+I1hz/V2JlvyHYTXjdyd7fpHZLvc7nTlnXdE12?=
 =?us-ascii?Q?4mb2AxAlqNgFNsOPiDUo1ZUv8WPxFik2+IocnE1fbh7sPl/sVP5V02Jxku+8?=
 =?us-ascii?Q?5prsuVYJ4HZyIwJcJRMNl12iroGClkAyKvt7XVdSl3tJavDWGwByixxUnukV?=
 =?us-ascii?Q?ZsSqPvvS1Gnvk4QIiDhzzBvQJEqV01D914kSDCI6mOzrL1yK5bZyNAEHTTdJ?=
 =?us-ascii?Q?EAlAgH+zkCk3DmalDikp/ptDDYB1gb/4Cav4YgYsA//GaQN2PtF2o8Qzz6MY?=
 =?us-ascii?Q?dMyZYMcb5TXDgpPiPzoETtIm14zexnAfVLZvE4X8NYd2lFjCwPdDEPIJrgtA?=
 =?us-ascii?Q?rJBe3+T/0aAS+2VANNVx25SiB9tHhpUsN8lmVbgqrqMLMFswjGVTjY1JpIC3?=
 =?us-ascii?Q?DLhWbH/VoVUlaPJW046xOKfvH9OvLfxZLg0hleLlGrFu8pZ+Ro0qsMZhqmym?=
 =?us-ascii?Q?E6OTlY66vysh64gdg8nuybxberaDnC/6dnEdqyZdoVi/pQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jOqNb8Uk44LaxlZJ7esR4o005aPQJV9AksCcUEghqwtPLtIop+HmEZZ4gjH3?=
 =?us-ascii?Q?n9cvZlVgkAZkVIa2n49Amz/Tx8aAbvv1hcN1w+zAHYRZkiAQ8bR6FhwLeV40?=
 =?us-ascii?Q?grBYSxFU2NU+K+2bSh0NOOIQR68DJpypUQlZjqOIOhYOhks8T+VRc4nIgwZ5?=
 =?us-ascii?Q?RfNWM8aVRpg/qi9zH8pZ/AAbwhoJ1wZOJ1lMNVvFpRScAk9eHdFvi75UzPYA?=
 =?us-ascii?Q?1AAISzOCzRpHMN7v33agyyIpvK81RwrIGqFkr8mqwoXVjKzfUYRwJtWzZ7iv?=
 =?us-ascii?Q?yNr6xlo4ldzHmV9vD+nZ1d3tocjvVvOhXWK8R1yfhQ6qw3XxY3uEZVhTV1SH?=
 =?us-ascii?Q?OZZcqM/GoI208/8yPqXOuJ03+4yodbX45jPpklg1VjaKfg65yBu8vdD9wMbp?=
 =?us-ascii?Q?qxROAVYWuKaqx2HEbyyQFaLWj0lyEB8k5OzfrzCzk40TfroyvYAgErZgphzk?=
 =?us-ascii?Q?c29tO+9EoeBYLcfvc93Q939bvB96ctWxS4aX3mqIkCnMZkGlFO+GdjdEElLx?=
 =?us-ascii?Q?cqub/qGD9rkfUz33TgmEGCpbOVMir5TB+OVIxlJMvLN1bSUReiZcAIloOYQw?=
 =?us-ascii?Q?IOii8VOMVZjovCcNFwqa+e9mCtPjxBLEFQgk9znf0thv1CW/2PslbQHAFACc?=
 =?us-ascii?Q?7QoixeWYPESwTM6kBU60nNEFkZ+9slTplQaAvJiL5drdH8meeUMeIK/Lwqx+?=
 =?us-ascii?Q?bRmPhX41UFYA9Bclq94SwpqBk4qqnjOf2fAN+l5+vo1TOdFvydkTfOfkn9bq?=
 =?us-ascii?Q?NVHnnY82SWF5AQGY13nWLniDWavhpJ5vO2SiwPFTzveK6gPIe8+cGz/wZng3?=
 =?us-ascii?Q?4uDSFey3czNzN58No/H/iaPq7LyWHDidMRHy2K9Kxt4fgy/246/0AE2TI7fW?=
 =?us-ascii?Q?frKb/TIpaMoTy3SVkDzgBICqq/0JIIJ5ZEP/wkN1b20lnNK+i/z3V0IPgzsx?=
 =?us-ascii?Q?996txXJlxMDS0FdALuP6RrTtBQD2SFfA6fA8rgtI3CnUX9WHC9CExQworbPw?=
 =?us-ascii?Q?IqaioPxJZhp616AHKXucA4iJ/wdzZ8P9b2icCranY+6qOFmUDJQOz62XGs5Y?=
 =?us-ascii?Q?odGxEg6VpZyIOsrqjvNoFBcZrCZBzflg6T49m1inGd79TnP9UX0fO9bE0eWE?=
 =?us-ascii?Q?eqsOOuMPiQQSIdcuQ288GG6/jkps9uplxUFEu52KNtNB+3Z+zS7sa6vL6Eyv?=
 =?us-ascii?Q?4WujH+lybItnuux1Ff1M+IYrdCyIxv/Z3f9Cu3EeAvbxI3DYahTbQTUi2yyg?=
 =?us-ascii?Q?5xVjfJLBuus0YtTWwNPoiLQw8+v2w5Ull9pPvgRB8zebvCwGrK1mbETufC4Z?=
 =?us-ascii?Q?09sYbz9jbQLUCengcUbVeGPSK/HA8ZAuw5WtJfN+2lrrVXmkfvYcitKpXd5T?=
 =?us-ascii?Q?RlMgki3+xmNgZsIiNUEqvFIJDom1tW3jGine2mOvlgG9nQ1x2YbPP1bcIhE8?=
 =?us-ascii?Q?RKBCNWSrZYHnXUxG/nuOan8sRBBQFF15/+Njk9zBI6595GtSSmPqIjiKpaJ4?=
 =?us-ascii?Q?G/mZQYlwExSPAyDrreTaswodUxh2ZA49G7fKjeexCLB2jfNIn+e+6D6XCja6?=
 =?us-ascii?Q?QZIeWeC7/kbsTSHQjqsU0qQ5ZCTs4b66D82FKQvD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33bec09a-a198-4d57-15d3-08dc83e11ffb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 15:23:30.8382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1tfmqG6PXWkaKeSe4wWpWfOCRVd2SUMCNUKYUUv0DowveQcgp9+U6HiZShfd3wE9iGSay3g7CEbmPN5BKLHSeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9243

The 'idle' in fsl_chan is redundant as it's equivalent to
'status != DMA_IN_PROGRESS'. So remote it to simple code logic.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v1 to v2
    Remove "idle" at mcf-edma-main.c also to build error found by
    | Reported-by: kernel test robot <lkp@intel.com>
    | Closes: https://lore.kernel.org/oe-kbuild-all/202406011344.s3sPp61I-lkp@intel.com/

 drivers/dma/fsl-edma-common.c | 6 +-----
 drivers/dma/fsl-edma-common.h | 2 --
 drivers/dma/fsl-edma-main.c   | 3 +--
 drivers/dma/mcf-edma-main.c   | 2 --
 4 files changed, 2 insertions(+), 11 deletions(-)

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
diff --git a/drivers/dma/mcf-edma-main.c b/drivers/dma/mcf-edma-main.c
index d97991a1e9518..3ceb7b8f9a67d 100644
--- a/drivers/dma/mcf-edma-main.c
+++ b/drivers/dma/mcf-edma-main.c
@@ -64,7 +64,6 @@ static irqreturn_t mcf_edma_err_handler(int irq, void *dev_id)
 			fsl_edma_disable_request(&mcf_edma->chans[ch]);
 			iowrite8(EDMA_CERR_CERR(ch), regs->cerr);
 			mcf_edma->chans[ch].status = DMA_ERROR;
-			mcf_edma->chans[ch].idle = true;
 		}
 	}
 
@@ -196,7 +195,6 @@ static int mcf_edma_probe(struct platform_device *pdev)
 
 		mcf_chan->edma = mcf_edma;
 		mcf_chan->srcid = i;
-		mcf_chan->idle = true;
 		mcf_chan->dma_dir = DMA_NONE;
 		mcf_chan->vchan.desc_free = fsl_edma_free_desc;
 		vchan_init(&mcf_chan->vchan, &mcf_edma->dma_dev);
-- 
2.34.1


