Return-Path: <dmaengine+bounces-93-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 333A07EA633
	for <lists+dmaengine@lfdr.de>; Mon, 13 Nov 2023 23:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A9CA280F3C
	for <lists+dmaengine@lfdr.de>; Mon, 13 Nov 2023 22:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20652D63B;
	Mon, 13 Nov 2023 22:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="U4muxILy"
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F882D607
	for <dmaengine@vger.kernel.org>; Mon, 13 Nov 2023 22:57:43 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D080E1A6;
	Mon, 13 Nov 2023 14:57:42 -0800 (PST)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ADBZ169012916;
	Mon, 13 Nov 2023 14:57:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	PPS06212021; bh=2CmEor3xq8MqRSVFSHUHsTnpoTWHXIo4ktJzjLyOOBQ=; b=
	U4muxILy4QhujOUbw47empRt4sTDOx0G+3YCEyMwSTsnecjccMa/55cfH4zczuMt
	NYZSw17f3OSdZBkt2g3KiE9CAJhqC2g7YT3lp3w8pUhLP4TlO3a5t/HaiAx0JUkD
	I+9eosGaiTgjAGcSH8z7qV+npLr1Da/yGDO+o3ifSEGFYIpfPkX6tbZG69E45TdD
	feD2922kPk/l9mE9++ioijRB5PumFqpo+S8T6oKwaUBq97EOHuRkPti7buGo960k
	8z1AujwNxPM1koLAXRrqq3j20+yfTLvdwp8Fr4dPOFnBb8o9a2IaO4rn61AeA+ci
	4Cr386T8K7q12iiGm1cjAA==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3ua5s4sw6g-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Nov 2023 14:57:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kEjwQCTIhSyWPRypl+lKD5koqdOeTpsmaUIAnqrguEvVgQuueItSwS+hzQNrGuipAd3tZkFkzvVd/fEPJV9YvPnRuPu02c1X1Tjy1SfesKq7Ef8o1WDzMWho7CGmB5XV5J6/efIBOf6gvYLfpdh6IgdROPtrmbuqbvqQNO1ggNlOnqY49pXE0HZ/AqpPCW0wE6P/8DbVvfmxwPCMHFi3xtC7PbRCe49lbMef/B8ViGulzQY8he3xigzzCdXDtnv08WaIdiofmMFMQGGpCqvg+k/ga6ZgrXNpoBz429FuWrDvbkP4W/p1uztbICQ/5PDnMI2v/7Lt7nJm4OfcbTLIeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2CmEor3xq8MqRSVFSHUHsTnpoTWHXIo4ktJzjLyOOBQ=;
 b=SRs4U28ZkPlHlDAiFbbN7AslMP4tt69uAiAffAovwk9XmJM7q60A4e/0pw7/Ridg+/SdQNZWl/+ZDJ7tHMfL8OeROoJaprVeEzziOLmRQBj6K/1Tw5QMZY16HnVKAGqk3O12RY6M2XE9HrG+Zz5Hk1qj4TJK7ooSY9byOmIz4/z7s4uRBuYENsG3r4lhInCkPRtRqF8KnZgzz8W2fQ77FeP+CaTXyKQ3YxeKbVRz/j0lzXsg4qQ8t9LAPO8hqrmIFJn082ndipTnO/HYqQf3aZKYZpXpKV3RGoJ8yuBhyS7dAbjvJsRkSfZXTSM0AQ27dbRX31211yRE/dMLWHX4OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by CY8PR11MB7136.namprd11.prod.outlook.com (2603:10b6:930:60::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 22:57:31 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::7d7c:4379:e96:3537]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::7d7c:4379:e96:3537%7]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 22:57:31 +0000
From: Xiaolei Wang <xiaolei.wang@windriver.com>
To: Frank.Li@nxp.com, vkoul@kernel.org
Cc: imx@lists.linux.dev, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dmaengine: fsl-edma: Do not suspend and resume the masked dma channel when the system is sleeping
Date: Tue, 14 Nov 2023 06:57:12 +0800
Message-Id: <20231113225713.1892643-2-xiaolei.wang@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: ca043563-5f4e-4224-6f14-08dbe49beac2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	aNv05OYFRsJqXb8UY0xqHXXgLPqhd+Q+FvZX27B7SS1dqd29BrvcYaItccbXKm2eQk0Ce/vhnZ0RKhcM1INlvPELww9uo3kgmdy7V2LxyeSRBQ+wQLDd31Q0+cFLq9kCqAvT1i8KKz8X4oCK3flhTThLPhJxqkMHwx9C/lJ0F+8H5zE3XcazNkRlpshm+mHEWJXL8+sr3AyvQbb85icv33FaVDlDygZs4r/cHYvt2vH0liwqAZO7v7f4b32yXKKTa1iAhn7qcpSOMubTs2ZMJSQuNMFnFoHXyP4tBlpaUKNg2rbQVJ1Ompj2Btl8HTwbrG3JES+dMG8AuAU5yhHwS40UHSxg1qHh3SWrl1DGih1uOCIGhGzjpiQ667K5kK3pcoGoMq5QRJAjIidwCMB2pYC4PFx58OHz410RhwuCVT6rlX8bvc3EChl5xcOjLDYNVeCo7IRkyBCEQBx6aAuam2yWPZbovVgnbWEEgDTM0HpMxIEA8gP2F2II8D1+OP8vZgRcQNwx10hzFKOCbgR0/kHZybZsjPfCkX61c2PvoHI6UN2guyS7eD9D1kEKe7XjQNY1hsGiWUBWt3HHB85lCpCEcf8l20nyGJEssiLwb8cTiI+JNRIH0Bju2zJ6c27y
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(346002)(39850400004)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(38100700002)(2616005)(1076003)(8936002)(8676002)(4326008)(44832011)(52116002)(6512007)(6506007)(83380400001)(26005)(6486002)(6666004)(478600001)(45080400002)(66946007)(66476007)(66556008)(316002)(38350700005)(36756003)(41300700001)(2906002)(86362001)(5660300002)(15650500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?kOpG5+fQuBW67/aT29RROlfDJZ9Pp/7/bGD5L53gw+YHnrmOZCNgHCklKBP4?=
 =?us-ascii?Q?+zQ3C8kKIVndZD7COzuohbxllrXFPq1HFEF6cHbw0o7DxWLN3CQf/dzgvEOv?=
 =?us-ascii?Q?PJrEU+E3zo5CoAnps4UuLoTsah5/2kSBdqK8CQh5XQA5wp/eVRWQc4Ye9Zq4?=
 =?us-ascii?Q?LuEG2JtiwpsboDRJFZPyPJ1F6GiqrSXfYVMw2Kc7ewHruyWHrCEvGr9PKw4s?=
 =?us-ascii?Q?05uVN7c4+Q4DxK6Nl9wY92t/vgX8Ym/Btg1LLCRLh4Qn62kwVhcPx+qoGyyN?=
 =?us-ascii?Q?ADXUrl79jVCaKudxiHDJhd5JhTtSi8prclEmN9WL6NXKaxCIh+AQYU++dkq4?=
 =?us-ascii?Q?tbIWHitNRhrphxViJ+jhaW4NxW44lF4vUIu4iGtgoIn17zxQf+P+KIxTCdsq?=
 =?us-ascii?Q?+Loh46c15JT2A+WFH2I/CTijW3KS4Jt6BFd5O8bwv7XADbkzUIHGz/Pbc7td?=
 =?us-ascii?Q?ugBhcNlOvw9WfNyqM0qe6VSSOov7JimaFxm30V2wls0tVEV8nG66p88Bqn93?=
 =?us-ascii?Q?4zkt4hWc1Ju/3Tu/9RHPImqKj+d9FlPP6nwjME47ICkHwfSuMyql9yemE/sd?=
 =?us-ascii?Q?do1vuXGRkPtVjj9BCFXV1OsXSIYt11YdZn++MzrUVM+ThvPdGOSu14e+oN72?=
 =?us-ascii?Q?rU760bYzlTl2wfmiphROsJnRIxsbJW2Sq17HlRlyMb8lSB3JSnnr3X04WXXY?=
 =?us-ascii?Q?QeyDzpfP+R3cg5/OWy9vBxiUpVHf5y4aBREFExkGEoaCBxIGWkxau7CMh7OA?=
 =?us-ascii?Q?K6FRpO6WXAVnpwIN/OPKM8drYFUzKA9f6FuZCOfkJQtDlbyhl9u2GE+pg7vi?=
 =?us-ascii?Q?kMjTz0SfRHdiMiler+qWt49/dZXAJvYE0/IGOGRFq1AD9Q4Bh2pTCNpkexdk?=
 =?us-ascii?Q?is32/TFij2YyUQ5Nhoy6aOBzBujuI0rSgzfHrSS0bde0xsyrrX4FMAx1naTU?=
 =?us-ascii?Q?B69J6Tx8kuFxCKQwsrzHNhokXGw3bdb+7fm6he+6ADMvp/jzSuuh6nWKH53j?=
 =?us-ascii?Q?j7Z6IA737qZjF5jGVJRMo282Mp4EBpnJ5PvVtSKbKliZ9QkYi4pKWGiKjRh+?=
 =?us-ascii?Q?Okb5VWMLdTm1AV5TQ4H7V9KglPx4mkiSAew30e1Vkp8/GGSG1e8XToRzqaWY?=
 =?us-ascii?Q?1C4topGCNldFN78b/3zOjONPlEye9Tr7i4L01NXN5EBEy/mHKAYcine9+hdY?=
 =?us-ascii?Q?mtnHL86vKzWIFy9lvFfgt/n2vWn/7QsyJ8Lfr57mJwvwu8uwUMqzx9Jxbp+K?=
 =?us-ascii?Q?Zzk2W/kSo90cT1UEEJhqfAOYTNEbxoPqoMfaHaLY+GqSjUa7klvVso755AqT?=
 =?us-ascii?Q?ySaMWNuEf5pph9T6Z1QALX1OAyg1Y/h30Vhbvw2QWgLyZt4k2bQ92nuIqOt/?=
 =?us-ascii?Q?LrBmbBY61dyz7k9F870pBiHBzzK4c260LXIdZ32ED1HMvgGTLcnXjHoiDdBt?=
 =?us-ascii?Q?FvZB2Zuo5fWfG7+idy6I18Q9s9z3HixYmgYzOCJylMMJwsW/eejcTh5Pa12v?=
 =?us-ascii?Q?j5/8ZIu91hbv6ojdnYvsNOgCyLE0fTCMoL5HfUfCkBIxiYrygZT3cJOEsgrN?=
 =?us-ascii?Q?TQGv7mXs1fKmUDi/jHMjB5WPhv5bo4RtklQa08cSogeljYUpJDkCMUqoVRKJ?=
 =?us-ascii?Q?Cw=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca043563-5f4e-4224-6f14-08dbe49beac2
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 22:57:31.5025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NMq0zsy8bpv5Exl1h2vnsiJDe8EtSnP8nIIi1F9ksjzzd+Bbe3Mb+zvY3m+j4eBCzt25+DyrNDgw+jOWk/4UyomD+rPdRYptwbcotE0Mi7Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7136
X-Proofpoint-GUID: Vgil4NOfyQxG45gJ99mKVxJCUOUphf_R
X-Proofpoint-ORIG-GUID: Vgil4NOfyQxG45gJ99mKVxJCUOUphf_R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-13_12,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=468 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 spamscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311060001 definitions=main-2311130179

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

Fixes: 72f5801a4e2b ("dmaengine: fsl-edma: integrate v3 support")
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


