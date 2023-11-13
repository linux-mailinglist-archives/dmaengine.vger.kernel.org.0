Return-Path: <dmaengine+bounces-90-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C207A7E9CC6
	for <lists+dmaengine@lfdr.de>; Mon, 13 Nov 2023 14:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6199BB208F7
	for <lists+dmaengine@lfdr.de>; Mon, 13 Nov 2023 13:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B591DFD9;
	Mon, 13 Nov 2023 13:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="RtAwPCDU"
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A126B1DDF4
	for <dmaengine@vger.kernel.org>; Mon, 13 Nov 2023 13:11:46 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25356D7E;
	Mon, 13 Nov 2023 05:11:45 -0800 (PST)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ADCCLAg023674;
	Mon, 13 Nov 2023 05:11:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=PPS06212021; bh=eWXSEfEfus3YKhK1x2
	xdYhleqWxN6MtTE1dPm1YvChE=; b=RtAwPCDUST9vjRfq1A7vzQvy8+GTBm9CS1
	6lTHONDhHXS4PqdZbkmU73lyqJ0S2VS0u9Ft/gSIe1fbhYSxkPjlD5RxXCIuSVhX
	A9jT0RcJJ11x9EllXNKOAWBlvOTeJGlIrEYYIDUvNlV9+sr9sTZn7Nui+/F6lRwB
	wXz1Setk7e7ft3jE2Fet9sPqzg1Dv7h6mAM1TCnj0EeCF5quLt/80LOInt7iQjS0
	QylseFQ1qepv0o8vwHhCf9xIL1XJBNM0sfBRnaBK7MBdaRHG0KtuKlY7zM2MSl4K
	S74FaAri+z2Sk/5KVN+F8uJEZYOFci4hJI6Ui7LKE93QsNWNMGXg==
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3ua5s4se6j-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Nov 2023 05:11:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VVeZym3WcQUA7HpsQAYiy4eRMLz1geF/HxJkoIuXAOhoX+w3CLzN2mOOgRyJkzm8J5vvwqz1V/7hT5AQjXVZ81pxUDAr8PgFwI+qMHkh4qwfDGodLE9ntb/roDGzuqLM6vQe40hOncOD4Tnk/j5tvvTupSr/0lq6KKQ/+AbrqE4g3Tw6MZUTwIwfAisppwWTg3zCpdG4V4IDfHVnxFCnfjoqt2kmoa1u+iIpFLErKBI7AhZeqZPzO5DEzsDOUGvN1grp3DByJyMhWRWMyN8J9AFh0b0E7LGkEPYIf8vm3fRRnbPsjIoUzu9ltm0islyV3rYxbBVRVW9UpctWec7yPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eWXSEfEfus3YKhK1x2xdYhleqWxN6MtTE1dPm1YvChE=;
 b=hsQ7+xPu8O5Jg7x2owcy8JBpDovxZMp2GuRQdoxRwBdbdofnddN++lHKM+uji8v0pVO1APoKQEz21q8g/Px59f+1qZQ9lhFzpqDHHhue3kr9B2ee9URkkYoewpmTomAI9yHrzMfPx2SCdsvrqNDYlBu2YGz/vwKOE7OMpd153f4GtxSGw0JdFVRGmiMnrr7HpSYq3wX5txYbO95yrgEU4IXza/rBC0U9ZBFSXqee6DjpRAxzaM3ZPkS4oh9As/6hsCTuewSAW9E34wnA+QfSeY1d02Dwf7RQ1oTMLmpxLucn6qkUT5qBUqiZS1l1xa02S5jTwIa5C85mP+dRagK7Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by PH7PR11MB6772.namprd11.prod.outlook.com (2603:10b6:510:1b6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 13:11:19 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::7d7c:4379:e96:3537]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::7d7c:4379:e96:3537%7]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 13:11:19 +0000
From: Xiaolei Wang <xiaolei.wang@windriver.com>
To: Frank.Li@nxp.com, vkoul@kernel.org
Cc: imx@lists.linux.dev, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dmaengine: fsl-edma: Do not suspend and resume the masked dma channel when the system is sleeping
Date: Mon, 13 Nov 2023 21:11:04 +0800
Message-Id: <20231113131105.1361293-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-Office365-Filtering-Correlation-Id: ddb9843c-fe4c-4c28-fb2f-08dbe44a06b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	las7F+cFOt9S41hAr99Td9ULQoSMukm2Ot7t2lC58XedlJPd8UNt+MM4IG7KdF9tHyFLu14vtu8f6tfpWOZjVN/fx4KZcHoxS+bguFtjZCpkokgk395hC/RCqfzMIhjsQHFty1ODoHjd+E67tq4GHyY570k8jUSj/T70rK1VOGKEmPJWnTRsx4TTsrNIJIy2YRdzQzRWGBrIWB3EumF7q60ux+4HNmk+rmMXKA8zlAdOTrcvjis0h01hxAjOKV2Tsy5ZTUSVH71cjmx7i8t05aEQVwqSkERePmPR6N2P0LrZefHJv2OvjVxmC8uPVg+OXz395sdIS/IHFwAFS1VNpDaVygRHc9u7cArH1BJlBOnGwCf/upsPpr25VV/R7xW5uUHTZ62RMvvOh6kEgd9W39leq3XUU/dIcDVDxX5Ykn2QLc79W5uNV4dY07Y9I3TyFK2S+PHHvCeWzTORET9FaWr6RMmh7kV5XztTPWDLxBrt1dxFyWE4bnIfO9novZOyPQ9d94GIFFUkj0JGxPLKGnv31XSXQSyGrI8zWNPjwaab5jeDSWfRxecaI1CtZH318EaKb58e0lBQc+df7zr9fYjTQKied/osyZc8oKwuyJ28Lr6foMBdBfD3yyIeLASA
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(39850400004)(136003)(396003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(15650500001)(5660300002)(86362001)(6486002)(478600001)(2906002)(45080400002)(6666004)(8676002)(8936002)(4326008)(44832011)(66946007)(316002)(66476007)(66556008)(26005)(1076003)(36756003)(83380400001)(41300700001)(6512007)(6506007)(38100700002)(52116002)(2616005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ZV34CJWj8FL8Fv1qSFRG5crmfL8+4JExaYwhR+/3ThGRSPzOoOkEUpYDLDTI?=
 =?us-ascii?Q?cuLiLxt7Fma41EYjXECJayznj8VAeTNOGEgE3S5wFlTP5xd2gyhJ5t117+S8?=
 =?us-ascii?Q?Vrjoxi5n7fG1Z+tdZdivap0fLBnQlQftzxh+geXlvsUI0HturcqYhIwk2Izs?=
 =?us-ascii?Q?njWLDs2HRkuycSzcovubVO3zW0ekI6LC7P4JMKkXWig2PVyC8Nw2672lPDhp?=
 =?us-ascii?Q?jFMX6LDf9MX/wj+ULS9pDVpekypuvqTNhh/UTJSXbm9UmK1mjQU32XOTCSGo?=
 =?us-ascii?Q?tgOvFyQGkNpUJ6zAIhFHI9hK/mD4Jr6dve0rQXFG7pNlJCGlK7ysZII7XoFy?=
 =?us-ascii?Q?7qVuefahXpZ9Vo3moLDDbYzXrsh2qjFCYsSTNHMmzcfvQ7z0WChX9zZeie50?=
 =?us-ascii?Q?mGPWeP1Jc+WPH8AOkJkFQMaUtwAgDdCx1QRh5wGoNr+Tx4ES3n1dN/5Nq/UC?=
 =?us-ascii?Q?9VgBYzA0+aqRtE6DeESecXL6v6S/uvdY28gDri0HYfkaOic5Nrv+HCoiMYL/?=
 =?us-ascii?Q?T7/mPWePFRMN6HhpKUZQdOurwkrl3+o6qHivE1PWNTibp5w7DoNAWxMZSWps?=
 =?us-ascii?Q?46P5QOVY5eiiDdaGs+ryco/XPRdoIycA5acQDiH+UOPBOBgqPYPV/MHc8cDR?=
 =?us-ascii?Q?lzmfeAJr1acHEY6LqR0KoMpASfMTrQrbBmRaZ/69Nh+Pfmh8+jhlu4ii7yJ7?=
 =?us-ascii?Q?hmYVcw0e0h9l1EbcB4uLlKkw/BFcqir0hCnRzLMn/q9ggTL8GuXHvbGGbyYT?=
 =?us-ascii?Q?VUNshVw55VilXWKxFUIz5NNj5kgYkaEqR4UpfQxgWswHLCff5vgt4ShnZbeW?=
 =?us-ascii?Q?6yuKTkJXjvWaEzgW/8dSi9+b8o3h/qtWVt3qiJkV/dEn/knnxw2nBkFxRude?=
 =?us-ascii?Q?1eVn/VpBqvoCq0h6sOvV1ySiu9gJqBct8PFty2sYJQ4mJCAGJByxWcjL28xN?=
 =?us-ascii?Q?QxIN82b5PtgFfKX/gYj2Ps1S9lnOXQo4eXlm0AlfjHHK1hmZMgPkJpEdkgnR?=
 =?us-ascii?Q?I4HHirl7eyQOFBvrlBSNd5xw16WSS1o0+OAWt0HkdbAulBAbUv3UihvoBkPE?=
 =?us-ascii?Q?Y0R2h5YuFc8eO1PUNNtxNtzea7Qig9oBNyr32+XGDa0DCvO2MuERrYrOWJs1?=
 =?us-ascii?Q?4pCwSAfUQicIBy/yNzypdZFeu08XzlOlQtz7eLrIo3KJBiepuRZ6FGqyoy3j?=
 =?us-ascii?Q?nxcv/JZ515lgVupZabhayA5kPPuRqcMaLshzRneWWHBijPUjB/gYP77CNrTd?=
 =?us-ascii?Q?FShMpn0THw3qQAQvyQ/ZcD5bQ4LHOsBuUbcgX1OWflfpKdxhi5L7SbPhJDKz?=
 =?us-ascii?Q?NgAXnRKd3QOTlWu2ZI3OkO1yKxZCBy+ITuBFsASRGVb+4MzQ/jqbseUHiZjc?=
 =?us-ascii?Q?O92FgQ5HimDIaxHHhETNwqxCtvhZnaypTeMsp872daYGbEkwqGRCdMoN1RMn?=
 =?us-ascii?Q?B8/w5v0YROXqSBDicdsno0AEW7BjD56vcDBVuHN/rbC24t17/FJhrqTUBXFd?=
 =?us-ascii?Q?JpxyTzuS6F8SEUBHc2hSaH5HjEOBEgt7dYiwo0Nf1+nSf9nmTMqyrs2lTs7R?=
 =?us-ascii?Q?iMpNdDa8JHKsyoWLP4a+vfrYyHSuS60lz/IUhMz5ITrGKXtWTOhZkDCBtx1u?=
 =?us-ascii?Q?Hw=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddb9843c-fe4c-4c28-fb2f-08dbe44a06b1
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 13:11:19.5696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +mW3UW1oUTHHcjJxax7UPaBnDnl5qGhcCX9y1VutOFzGiCHlIM2E+JJFk7EwJZ4CNL/sWHRpaS4UjTuZ9GOM9JiAaeRocnHESYW4s0f+no8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6772
X-Proofpoint-GUID: b3f1PH4D9TuUHKcSItKALT-DCaWiw4AP
X-Proofpoint-ORIG-GUID: b3f1PH4D9TuUHKcSItKALT-DCaWiw4AP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-13_03,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=331 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 spamscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311060001 definitions=main-2311130108

Some channels may be masked. When the system is suspended,
if these masked channels are not filtered out, this will
lead to null pointer operations and system crash:

Unable to handle kernel NULL pointer dereference at virtual address
Mem abort info:
ESR = 0x0000000096000004
EC = 0x25: DABT (current EL), IL = 32 bits
SET = 0, FnV = 0
EA = 0, S1PTW = 0
FSC = 0x04: level 0 translation fault
Data abort info:
ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
CM = 0, WnR = 0, TnD = 0, TagAccess = 0
GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=0000000894300000
[00000000000002a0] pgd=0000000000000000, p4d=0000000000000000
Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 989 Comm: sh Tainted: G B 6.6.0-16203-g557fb7a3ec4c-dirty #70
Hardware name: Freescale i.MX8QM MEK (DT)
pstate: 400000c5 (nZcv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  pc: fsl_edma_disable_request+0x3c/0x78
  lr: fsl_edma_disable_request+0x3c/0x78
  sp:ffff800089ae7690
  x29: ffff800089ae7690 x28: ffff000807ab5440 x27: ffff000807ab5830
  x26: 0000000000000008 x25: 0000000000000278 x24: 0000000000000001
  23: ffff000807ab4328 x22: 0000000000000000 x21: 0000000000000009
  x20: ffff800082616940 x19: 0000000000000000 x18: 0000000000000000
  x17: 3d3d3d3d3d3d3d3d x16: 3d3d3d3d3d3d3d3d x15: 3d3d3d3d3d3d3d3d
  x14: 3d3d3d3d3d3d3d3d x13: 3d3d3d3d3d3d3d3d x12: 1ffff00010d45724
  x11: ffff700010d45724 x10: dfff800000000000 x9: dfff800000000000
  x8: 00008fffef2ba8dc x7: 0000000000000001 x6: ffff800086a2b927
  x5: ffff800086a2b920 x4: ffff700010d45725 x3: ffff8000800d5bbc
  x2 : 0000000000000000 x1 : ffff000800c1d880 x0 : 0000000000000001
  Call trace:
   fsl_edma_disable_request+0x3c/0x78
   fsl_edma_suspend_late+0x128/0x12c
  dpm_run_callback+0xd4/0x304
   __device_suspend_late+0xd0/0x240
  dpm_suspend_late+0x174/0x59c
  suspend_devices_and_enter+0x194/0xd00
  pm_suspend+0x3c4/0x910

Fixes: 82d149b86d31 ("dmaengine: fsl-edma: add PM suspend/resume support")
Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
---
 drivers/dma/fsl-edma-main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 4635e16d7705..52577fffc62b 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -631,6 +631,8 @@ static int fsl_edma_suspend_late(struct device *dev)
 
 	for (i = 0; i < fsl_edma->n_chans; i++) {
 		fsl_chan = &fsl_edma->chans[i];
+		if (fsl_edma->chan_masked & BIT(i))
+			continue;
 		spin_lock_irqsave(&fsl_chan->vchan.lock, flags);
 		/* Make sure chan is idle or will force disable. */
 		if (unlikely(!fsl_chan->idle)) {
@@ -655,6 +657,8 @@ static int fsl_edma_resume_early(struct device *dev)
 
 	for (i = 0; i < fsl_edma->n_chans; i++) {
 		fsl_chan = &fsl_edma->chans[i];
+		if (fsl_edma->chan_masked & BIT(i))
+			continue;
 		fsl_chan->pm_state = RUNNING;
 		edma_write_tcdreg(fsl_chan, 0, csr);
 		if (fsl_chan->slave_id != 0)
-- 
2.25.1


