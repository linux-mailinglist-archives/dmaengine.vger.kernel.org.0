Return-Path: <dmaengine+bounces-94-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DB37EA634
	for <lists+dmaengine@lfdr.de>; Mon, 13 Nov 2023 23:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98CBC1F22AA8
	for <lists+dmaengine@lfdr.de>; Mon, 13 Nov 2023 22:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32773218E;
	Mon, 13 Nov 2023 22:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="J3L+PLKo"
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5572D631
	for <dmaengine@vger.kernel.org>; Mon, 13 Nov 2023 22:57:44 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B2C1B5;
	Mon, 13 Nov 2023 14:57:43 -0800 (PST)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ADBZ16A012916;
	Mon, 13 Nov 2023 14:57:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	PPS06212021; bh=4hGwZs/gkFgvgh64pmtZQPr1ae5vVRucOKAiY2toD9A=; b=
	J3L+PLKoF1KiB17wbXsGPjWVIhjxUXl9CWXkBdYr+RCAjQn7MXnoyJNcwKv46a/U
	k9ajtygNtM2UhtyOTXCkeBwHY8Znt0PHzybHG2L1U48TfJGDGsKTPSzoALoxFa4l
	cVJqdgo2ItSNyB40LD4RR7LE1ROdM/VZ64TMkHwytQGIAKAriTjZEStTe6OI9nNP
	SNRvGTh3i7Oo5qUpSa/WKrovGawzRdNq5L2Apuww+ZLtDoO37JjmddvS1BUuY52h
	ywLIYKjuxKwloRKMZFIOfwyurgexVmK0XGuCA3znT7yXCeW3JhfrKGsWy/FEoeQk
	4g08wHpA0nzsA1MAJ47JVQ==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3ua5s4sw6g-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Nov 2023 14:57:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KihoWP35qTwez3trQv9nGuiPrJvDJEPLXIQZorpZUzl+jooi/zlBx/PgX+yh2zLbxKvNEmoSRDQDNdHO8ZTXbJE8ngJy24Qrp3R2bQrsbQLR+3QVz6yYD4u3DgRkqMZKtYfE39gkrxsCwmX5t+YTesSfCl3IU4w+1SHxDQgL2QiYmDFIuSUprnUj/75roj5Ce8pZ751FISIPTxL4c0FLj7hd7uhK5HosaRij2+Q1IlDEcLQFX9eK6zfvY5FI1OUENSLqJg9pKgtzFfTTX8Hi/6nqerne6qcAidBxzWQLHn7W9brysm1UjhiyLJ6XTsbWQgM2ikLJNecB2gKPTQgD2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4hGwZs/gkFgvgh64pmtZQPr1ae5vVRucOKAiY2toD9A=;
 b=U8C/Vsx0vET+manC3mQuq65a6ybqAn0f33ggc4B2PUJNZGZPODmp3sjbmJ6TkOA1B7aEJcu/HBOfhdCkLnz8sen0zYGPpnXIowge66YnRtroLpUHafKsFxclC8uE1t8+qEnlywlUYg5SOPb+gKnDDEmbB/VltsA+La97F3qgUSgnbXA4BmHucHmtqeOAxL50udCfk5RU+KUjHoQK6ntLtRCL2RXgNklgC3euP1eWUybmvuen3hEwTl/GAqvQMKiHB3JQ414PWzYpNwmneMg9wtrFnqeXd94RF4l+hlBiPFqjCfAQZomOjZl5FjTd0T7n+3nMsWfmMIC8vPrvmEKuqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by CY8PR11MB7136.namprd11.prod.outlook.com (2603:10b6:930:60::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 22:57:33 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::7d7c:4379:e96:3537]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::7d7c:4379:e96:3537%7]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 22:57:33 +0000
From: Xiaolei Wang <xiaolei.wang@windriver.com>
To: Frank.Li@nxp.com, vkoul@kernel.org
Cc: imx@lists.linux.dev, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] dmaengine: fsl-edma: Add judgment on enabling round robin arbitration
Date: Tue, 14 Nov 2023 06:57:13 +0800
Message-Id: <20231113225713.1892643-3-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231113225713.1892643-1-xiaolei.wang@windriver.com>
References: <20231113225713.1892643-1-xiaolei.wang@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0137.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::29) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|CY8PR11MB7136:EE_
X-MS-Office365-Filtering-Correlation-Id: a65f2aea-4bd4-455a-79a0-08dbe49bebcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Bf3JEcfO2xzk7rnNiCLBegozCsvfeV5Vi39TDPsqslzK8G0MEOQ+DnO17zouNSyGaFsvnVgJTraPKmfqqYm9LiUkLpnRxOjFY/qnK+3CoeiCnUV8kar2oMrIPMrbE8XRXgwLvasx5HGbYZy144NW2p1xJPtJZdM7aw1vMhCBXqsIt39Bm0dDuZswppEBHULhzL/2bG4LqBK1w/QCxJzCiyAf7SavGv1fhmhYf2T5d8o6BHB8zcf2J3h6yApUPVDJy0V2gtIhdoG1hYtY6uhEigW4SIj30IzwuX1j4ebJNF2dMUw0OdREbNt2R+12lbSslHYyG+VByyuIW2EG3LtZd/VDHaEqYOmLwzvsnE+wIuMYijM31Lh9Ykwy19J7iXFA0wluE7NTBIEePUvpn423E8VIhKK3QszvrfC69G+KpdGn0rRzd8847iJVB5Qz4T/4vUHYdNtZiIs6vUXSvuMVN2GTrE/RthxfQ/C2lpO/WkcEakzA9wRCtxzqGsfBsnnuL5JTN9xDKDbH4UWrDGDIW3GrLAReKG1PX3uVlWiAGO4YEScpE0yHdQSJEamOZteEsIaaGhTZn8gX7ziCh4HtmCrm+X2n4eY+qLiaZH1owrge95ekotryQFAIu73BC3BI
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(346002)(39850400004)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(38100700002)(2616005)(1076003)(8936002)(8676002)(4326008)(44832011)(52116002)(6512007)(6506007)(83380400001)(26005)(6486002)(6666004)(478600001)(66946007)(66476007)(66556008)(316002)(38350700005)(36756003)(41300700001)(2906002)(86362001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?AQfvsNzAsfPH7KKcWExd0xJI6/CYxzZGwSLRip3rhNCiYZ8ewHmLGcmrd4uV?=
 =?us-ascii?Q?RyW6vNuvBrGF6cn8mehCwXZsjwaW4Ojg3m4PMcUpCllarFa9FbLuRV4fofSg?=
 =?us-ascii?Q?xoEHiN8c5ry4G2RNIfMgYKmINww5M6rFJrtNYK5sxENOXsbi2CxtiTfVhiEF?=
 =?us-ascii?Q?49FXNj9jRh1kmWFetJn6FsHvAVKm1mdat8iw9uIpmd+oidfZGy9K9OCqBJ6P?=
 =?us-ascii?Q?vYQzs2Q4U+uZJ2ZMq6SnYqEbp02E+ZAr4vsBxxIismbICDgL68IzOUp8nMJ8?=
 =?us-ascii?Q?PYe20Ni05WxpvwbKyfPY7E9uEErvNFhWhBrqsoc5ZOrXQ3IJhfwouXD6wybj?=
 =?us-ascii?Q?Cftufj6XAnaTJS73EyTHTe93XzCG/FNcZgxBTW+zH6a4Q7jTw48looDHqRJE?=
 =?us-ascii?Q?VMPBEIc5sBaRG3/UKY8g5007w6foq9kt84Au1KXqvuHyaxRStzKqUhNI7ZXS?=
 =?us-ascii?Q?EDr15mG70MBo3w9YRHt8njLj+EPFtu7q2GzdIKTnGYIhfXEysxjOHhMzZitF?=
 =?us-ascii?Q?rMCd+yOBtyLQj1OxlWBz7vPi7NFEFM89JNZfhnQL9Tncy2DHj0u2ncPdheK9?=
 =?us-ascii?Q?1XIHJNizescceKjNfu9NOW63B6aBtRpmUfG4t8+rYsRCQrZHfjMkrrWrXrx7?=
 =?us-ascii?Q?mndqJoFWR3VDbelVnBu9kN3XxHPyHAI940y1bM+wWyGWlvMk2bxBdqIYXVzQ?=
 =?us-ascii?Q?JdH9dtnYs2W7dj6wr0dj6YECY0mchs7o2k1NY6UK6ccQZ564Z0eWnd3iXmDp?=
 =?us-ascii?Q?rU/XGGvSgwfdzkVTqT87puFcBuK/KUhb4l8FHDC7BkVp10ouLV6gEIhGHuOT?=
 =?us-ascii?Q?bJTHBciKd0M32apLkw4q96mve1gkzfceKxUL5sFM4QjeIb43u4DppF1YzTZC?=
 =?us-ascii?Q?1Wjmkzurg/1y3h99hBMachPSanCBCjQmZQzCQKbXaVjxcvdIj4Xd4gHwaQUL?=
 =?us-ascii?Q?bU1atHuWomaU2vOHi4WTFCFcwZYeRtdOe0RouL/C91mF8Xq1of1aQEotofru?=
 =?us-ascii?Q?7/hShFCmkbb1A3Uo9jdqUNDqyhjZrl1rub59nbA6E7Egni7mM0KTAt6Tw7yU?=
 =?us-ascii?Q?PtvW/qPfmd4FKj9Ei4BqwZb1QFeGAYwU9bNoDJjS41yxPECB/6Lw4Sy/Wb+G?=
 =?us-ascii?Q?t2VIgXXVcz0caAp9wDG3rwvseTN0zwl21PpGIcw2SXzm5pBh+ex/FTj23eCo?=
 =?us-ascii?Q?qa+XMsq6Txh1Aam85RKGfoOu+/PPJAPTkRYgMUItziwUaT1OZM9TGSVliHpJ?=
 =?us-ascii?Q?CEiba5BJ0sxrttfRwDiLM1NIafDJyhehYNM7TY430xD0owZFA3mNDKMMKBoB?=
 =?us-ascii?Q?s6plROSDYv53kbiev0c4GS2B0q40DHsb6k+2JQVyM4ce6b4bqBXFFFagRhCb?=
 =?us-ascii?Q?Q+iWKErjVnQLazqQTn+wAjpD39NN2rqa1ly58TuL6ZkHj+EONxtzN0RZljJT?=
 =?us-ascii?Q?Tab+w1pDDSF71MkAk0LZGllA9TMqxbNqVKzmbkW0woAefzs/TMIYMLlHXZDh?=
 =?us-ascii?Q?7w5CVp/9BRndO8OMdX+UQk+bivZXSoI/LI2pqPAIrzhxG0vfkanEJVC2n7z2?=
 =?us-ascii?Q?ZUZhHmfDV6/rTPqElFixIKKE8TG35FFnVHJ2Su16lF5wB36hGjxUDWfSUbxG?=
 =?us-ascii?Q?2g=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a65f2aea-4bd4-455a-79a0-08dbe49bebcd
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 22:57:33.1884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LuoO7h0dl7AfVHqy8ZHJ3DyaDHcetu8mqxlUgZnqftZm0xfWYfHKiUdRQSHOvCGJpwd8oA4VIqr/qOdg9MWRsWz5hAibHZFqCY9SUkHmIhQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7136
X-Proofpoint-GUID: MTQPTcT57abejzkFke0GyINJX-Gvzp7A
X-Proofpoint-ORIG-GUID: MTQPTcT57abejzkFke0GyINJX-Gvzp7A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-13_12,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=699 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 spamscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311060001 definitions=main-2311130179

Add judgment on enabling round robin arbitration to avoid
exceptions if this function is not supported.

Call trace:
 fsl_edma_resume_early+0x1d4/0x208
 dpm_run_callback+0xd4/0x304
 device_resume_early+0xb0/0x208
 dpm_resume_early+0x224/0x528
 suspend_devices_and_enter+0x3e4/0xd00
 pm_suspend+0x3c4/0x910
 state_store+0x90/0x124
 kobj_attr_store+0x48/0x64
 sysfs_kf_write+0x84/0xb4
 kernfs_fop_write_iter+0x19c/0x264
 vfs_write+0x664/0x858
 ksys_write+0xc8/0x180
 __arm64_sys_write+0x44/0x58
 invoke_syscall+0x5c/0x178
 el0_svc_common.constprop.0+0x11c/0x14c
 do_el0_svc+0x30/0x40
 el0_svc+0x58/0xa8
 el0t_64_sync_handler+0xc0/0xc4
 el0t_64_sync+0x190/0x194

Fixes: 72f5801a4e2b ("dmaengine: fsl-edma: integrate v3 support")
Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
---
 drivers/dma/fsl-edma-main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 52577fffc62b..aea7a703dda7 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -665,7 +665,8 @@ static int fsl_edma_resume_early(struct device *dev)
 			fsl_edma_chan_mux(fsl_chan, fsl_chan->slave_id, true);
 	}
 
-	edma_writel(fsl_edma, EDMA_CR_ERGA | EDMA_CR_ERCA, regs->cr);
+	if (!(fsl_edma->drvdata->flags & FSL_EDMA_DRV_SPLIT_REG))
+		edma_writel(fsl_edma, EDMA_CR_ERGA | EDMA_CR_ERCA, regs->cr);
 
 	return 0;
 }
-- 
2.25.1


