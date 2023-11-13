Return-Path: <dmaengine+bounces-89-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6896E7E9CC4
	for <lists+dmaengine@lfdr.de>; Mon, 13 Nov 2023 14:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 888331C202DC
	for <lists+dmaengine@lfdr.de>; Mon, 13 Nov 2023 13:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C3A1DFC0;
	Mon, 13 Nov 2023 13:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="Q1azMx8J"
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFF01DDEC
	for <dmaengine@vger.kernel.org>; Mon, 13 Nov 2023 13:11:46 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251B7D6C;
	Mon, 13 Nov 2023 05:11:45 -0800 (PST)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ADCCLAf023674;
	Mon, 13 Nov 2023 05:11:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	PPS06212021; bh=olQ92dcB6vP/6vAQYokPPi+X91EBt6OBucsVRmpfMcQ=; b=
	Q1azMx8J8RofgP3eGJRpJ8mjXqTBWhSKOlKAezEEFA6EJzPWwTLVf9EFtn5Y41Fl
	fMyMw45X3JGo/OZkBCjJK2R4Fe3/1e/jLBxrUswxAJgYhbJNeUhhUdx1YkZCmP/K
	9NGl8FmXxeTKQxkD6W6kZlG1m2Yfa/IK32LPgDDfPbK3BLxhk2ko72wkuWy+UfHw
	6slujhkICptEyM3HG7hysh2fbRid6ZQv0IVT/uAxMcEPioHHxRf2KhY8E6zEgC0r
	VgxTsWrW7O4U2OZMJzZ8JtFd32MEcXyQiieDmvPS0GHxdYWpXTXMT8jmfeFS5jyg
	IyfCYjy5Qr84kudZpD593A==
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3ua5s4se6j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Nov 2023 05:11:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STo7Sghu9QpOsAu3FjU3psWdHZtHtgtPpTduLpbM95uAXmYtrWpjoB61wU/XdqUTZqGmVhbei4lvABG2F9zWRj3sCWYkm2z/Sg8KaLx3/3tyitwdkvvx6su17vRbVcPcNHs5Z1vTvixkUtZz3eHHZVHuAIoDm0X8vNsLJIxEbKeBOBG7v3YlGX19LKd4BmehHUGxr7vpG50PnRPnARSdBLEfR8tzU55im/H7M19gzymrhgXVjw1jgd3mF49quWbd58sfV4jy1+vEavSDOimG7X1nI5yLqcJ9i2KX6+I//Apv/biNPnjhTelzOUCl32xPh0SQEE4OmMgEQO7Gg7ZSaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=olQ92dcB6vP/6vAQYokPPi+X91EBt6OBucsVRmpfMcQ=;
 b=BWwu2QldYcnB3ZhsQvH4n9V75kqNcvjICSxgyHiqzO9uMYxEQe3Qi9GmsxGzA3p+xFVslh/oOYxH+yzyh5yCdjAHEvUeuVbqdKkPYlgfJZcDVxwreCOxLaG40ylA6yXf7Ug6n971YoKxcdBdTDJEOWfMM2zYHvMp3rpbCVPz4n2xlPmMzLfRu/O6TezPQoHwdLYONWAS+Ba2ke6clThXFo2WhPyr9jiNyLGocqbX1KzYUw+XY5TBlMG1E0T5ucFCVlheyTuq+nnaRDJ51u7Pdr76L2qSd+q4sZ65mpAb0Qf8X9T6pKIn1eXXEsYZP2I1pXGFb4h8+1vVzZOupPLvYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by PH7PR11MB6772.namprd11.prod.outlook.com (2603:10b6:510:1b6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 13:11:21 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::7d7c:4379:e96:3537]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::7d7c:4379:e96:3537%7]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 13:11:21 +0000
From: Xiaolei Wang <xiaolei.wang@windriver.com>
To: Frank.Li@nxp.com, vkoul@kernel.org
Cc: imx@lists.linux.dev, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dmaengine: fsl-edma: Add judgment on enabling round robin arbitration
Date: Mon, 13 Nov 2023 21:11:05 +0800
Message-Id: <20231113131105.1361293-2-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231113131105.1361293-1-xiaolei.wang@windriver.com>
References: <20231113131105.1361293-1-xiaolei.wang@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:3:17::19) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|PH7PR11MB6772:EE_
X-MS-Office365-Filtering-Correlation-Id: fad7cfcd-87a3-444c-da33-08dbe44a07f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	mldjm0/+nTiqOBTJZp6qClQYRBIq18k3cZw3LyENq5KvNcaKRejY8M3cYLHtP9HQ2xmMOS49HG7m3VxDEY6QBec8W5KusFPXPSvEGAYlvYf5GPKzuQ9vOzNJWC8wdX0B9ZyyomSLni8DNO3fq4qAac89LCtjRu1C/boQPWnD7E2GMnMxQ7Ect+ThvVQsAAw76X7LlgOoVL3CW82xjwVNbftAvJ0QE097263wUpEHO0HcjyzlbJZSeas9FuKJnvyfgdv4ePwMLSkQaMHrMMb2GUlTE9Jmr8nzXLpFUXcUpPYeU+5mbOnM3AbAc1fmtG9DcHmeaMow2xfLZNkmE1MLAKohcjRhgLAG4Eurus4H82lK/uiubrPkox0Dd0rWLy0iTHQQFi7bzYtjahECEGiEItBk3vkl1Mpl9otf913WgdJ/bDwEbVMGUYOejmGehib0ep19JzhawO4PyUsl5BqKrt/JL5neAzVZIzvxRYsAOYYeqNtHrlupOGoZTHKXOBUFW34En2tcZZQqBn75dOrl7emREzv1bEmpE3NCS113MEOHzcoGYxIIcbeY02ZBkkYjykMQpjXome5dDAIMDHDvy8bQ1JIq6NEtKw6j0OWxlS7twOvV54w7G1WhumVO+SHB
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(39850400004)(136003)(396003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(5660300002)(86362001)(6486002)(478600001)(2906002)(6666004)(8676002)(8936002)(4326008)(44832011)(66946007)(316002)(66476007)(66556008)(26005)(1076003)(36756003)(83380400001)(41300700001)(6512007)(6506007)(38100700002)(52116002)(2616005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?J9p0zMXdxqaZo/rKzQ2BOEdJ0fS7APm/TgKr09tRwZZydbbWpdEpu6MD14zF?=
 =?us-ascii?Q?dwBtbt+nBbJavLcsfn5ssVjX7j/WcR8d4e5TFPz2VKhjB3SGvFB6REVKDvtR?=
 =?us-ascii?Q?N1u5mTbJS6/qe77nBriS3d7V2wpretFmVvCanU20ysBk1W/ejd88+m7UPsy0?=
 =?us-ascii?Q?AIYhvrjysW/P1oWREJee5m9cf4WGPlIFYOnpJZkXQlYz/6HjYaeRlWJ4hb4Y?=
 =?us-ascii?Q?4NhHXoaiKVJYGmB+i6IQEkYrIQPt1F37bmylWopcCKfJyRFCnV09YbYl+o3t?=
 =?us-ascii?Q?7IMGwrb1HdHSJZ9hr0yyDPMOhkKewcIFrKkqO07FDY4ujdY5iup5NBKZ/pvm?=
 =?us-ascii?Q?7xq28DHV1f9p32LJfrdzUUnjIZmAB09NJRe9L+HtqGz8SssTHHdP8LnHoXkv?=
 =?us-ascii?Q?5RrUUipT5tsQVaRjsz+Ho0hixXexHoBMjmAwKIvWfaqb/sQ8rnKZ6ExZNGhk?=
 =?us-ascii?Q?v/ddGdWJ09tqUyW2t85+lBci7MihQGdE4WBLFhQh062alFDKwZacxT0jrNba?=
 =?us-ascii?Q?jAAb2QD+RXXOJEUl7WLUaxyMGSnP+4MG1IMsAWczSQr5ISJfzNMztK/vIljZ?=
 =?us-ascii?Q?FDy1a4ndFrAlOr5UNO7oWchbzSnDt88o1idVCaPcEr6mrT67bL2NCtr19Zn3?=
 =?us-ascii?Q?1+35d1wxkwF4JVCOwgfFt2bLgpu+ut1S8dplw4g0y9I43e7kk26CaJoTN5xy?=
 =?us-ascii?Q?vljZhl//BRqvC8F7esBs3q7YCRAoXlEaJDDvL9Sxe/a+88KHUpf9QlSg1YCl?=
 =?us-ascii?Q?NOvwhdef4vnLFb5mebs+tN8hZfn3j6PZ+hClzLyMzLKL++QLrUYTHcC/LhYT?=
 =?us-ascii?Q?YTE7WbjkF1L7TcDoPrMDGwa5HZxOB5XOdDQC4svittSqhiQCs4gfh9Wi29AU?=
 =?us-ascii?Q?65+rvRSMCB78UVhiNYnc4HNo5/Xdn7FmgdD47dVz3vS2WamiZYvB/o3/lGg4?=
 =?us-ascii?Q?25awlaNyamkEVEc6kFSKdR7Uxxg9Fo1pm77IDt7jLKWEoIoLlVBFIjGVxckt?=
 =?us-ascii?Q?ql5kNG5v7xQjynnwNUnYBzdSeKjw4lO+x5Na3MO/hlLlqIcZIU+oBW/wd3aR?=
 =?us-ascii?Q?PluDq0r6xa3fQcYtQYCXbvA+9jkfkxP0RHvd8V8JvrF0f5H2aAg1wZ5Mn7it?=
 =?us-ascii?Q?jhuwMz7f6nbo0nYTsHBQtVaCecRn+PK5nt0qIB5IdceD+xlGd75qY+53utBl?=
 =?us-ascii?Q?sCfjRn+EMqz0UqY+tTX/e1hhMHEHDRS1EKu/wZzUUd4K5KLqETHO6906u2rG?=
 =?us-ascii?Q?pIQWETkn4jXEM8LU8Fd2jOlwh9Ga+MFcpynK0khV9MMlQ7akauc19mZnHA69?=
 =?us-ascii?Q?7XCbFZxqksM5vgp20ReXG1A06HBmtSRuEMQyBQhB+6EMLbmE5kecgY6YWrV6?=
 =?us-ascii?Q?Gwa1boi4DC0nfxmO6dP3UlnhMCy1f3LiT0hbU9Qt1X/cizltgVAGu0ZoTPLh?=
 =?us-ascii?Q?A75wHDCHVPlv7nNHUMo6eMC4IJYW9pYjznPFBWyGObJbuhkYOx9Vr32JFHXb?=
 =?us-ascii?Q?JFA0ymUKzJ0fPK1p27b8biryPhn13X7k2VyVUKOrpBRXkwBWsxFqkX0nK+qU?=
 =?us-ascii?Q?lWXvfzj/OvodNa+c8bhvZawJH13xYGPjVL9wqyEmD8N2b5OvRz7rtXOSHHxM?=
 =?us-ascii?Q?kA=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fad7cfcd-87a3-444c-da33-08dbe44a07f3
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 13:11:21.6948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DCgPlPAvEKis+F1DFGKFtiG4fWrb2/7b9/siiGBXz0zCSJe/hVhL7ZZ1+nldR11aix0yFQaUrLxwrqhazlLGHy+BIPkQ9stkW4ZZ3VISGAM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6772
X-Proofpoint-GUID: wkhA0Nc4Iy08eMopc8DTCoMZMKLdi8Ts
X-Proofpoint-ORIG-GUID: wkhA0Nc4Iy08eMopc8DTCoMZMKLdi8Ts
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-13_03,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=607 clxscore=1011
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 spamscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311060001 definitions=main-2311130108

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

Fixes: 82d149b86d31 ("dmaengine: fsl-edma: add PM suspend/resume support")
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


