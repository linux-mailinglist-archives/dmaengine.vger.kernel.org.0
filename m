Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B896656B4A0
	for <lists+dmaengine@lfdr.de>; Fri,  8 Jul 2022 10:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237290AbiGHImG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 8 Jul 2022 04:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237468AbiGHImF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 8 Jul 2022 04:42:05 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FF2823AA;
        Fri,  8 Jul 2022 01:42:04 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2687M664026398;
        Fri, 8 Jul 2022 08:41:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=eRVPtd5cTS1TNRpqFcneWnZyVcu2soQFVYu3E6HEA+0=;
 b=FmMG5dFaNZEbSanE9qDTaGNzNw3Kr7huUWhfOi6sr9zAQikmyaEyxfyovr1+jthUTCqC
 jZbo2VSVT90VlulkqQNmcym6rax4nQ9yUyUvgUErnAJMmCBzg7woSh3bylo6OhZYXhXC
 P4Vp0WistPD0gxpOLlJdITeH4GM2BjvdRx8PaJQVhx4iXIPKxpOmlvK2x/KN0mKeJPir
 TbQDBoJL2lgaJUj3E6KvNpGTbRkAi8csNmQPqL1YpIVuOHm64me9SYA6UC8j7QFP17Iv
 9knARXGIBr/FPxYPdJak7z0iQ8IjB4Q+rPuLa26meeZnGWau/+ntn0qc5zeYUbcIZn6z Cw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4ubyqf7u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Jul 2022 08:41:53 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2688ZMKV035053;
        Fri, 8 Jul 2022 08:41:52 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2044.outbound.protection.outlook.com [104.47.57.44])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h4ud6je1k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Jul 2022 08:41:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j2Rd0p6JLx/c0P0tfj0DIiu4eKyOeLLiKqDZY4Tp5LaUrK3oyJqEG1lPyQleOcXDUHiX2IlwzKLKZoMOWuqIqFUcPKTKbTGDj4ThLr5ptA7cnsS/lVnLYdIzlUWL+UXm+5hsFO27vNu40K3Zcv6m3goL1TCHaom09ej0Z/8ZzbgqIKUWdN0rpeqOUsk/e7wcj6rNpxQ6Q0zzVPSg3LGfY2cJT43DIH+prBZhgcitgt5+Kn11Fx/EmA0jCicZxXSZkdfxbJNF+EP8nY5CZwB7bLa8ALy3idACtZDgsz0+DavqsfplI/OqKasTYkJcd/oSwz3f/cc98YklMzwzISDILg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eRVPtd5cTS1TNRpqFcneWnZyVcu2soQFVYu3E6HEA+0=;
 b=mfVZ0B7Jy53aeCti/+7+Bx1x/CwTKTy2DfRM+7mCy2KeZf5Foc23KMxDjjkOAUyZMTeGKFgG71ZgNOOdCuDyagtMYnh4qHzU9rMR+LEjhql+Jdc98epc9nCv3GX4vy2zNpif52s5NZiRAS7OGJagJhN0upis2TY1OAQnoMaLi/MAGbTmv9kR/98nr/8zkDBRIRp1Scmzzxez11P/eMwz/F9G/mLgKMcxYtWQfB9eaEX0mBLRhLz5oTrCogLYz0jliEKKb1OxEhkdqies3nZr4AIWpdr54Ku1iLXvwR6qa4dU4q7sAzakfNCpMP6hvhBcy8h6u+nKGaGYRv28eOjZ7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eRVPtd5cTS1TNRpqFcneWnZyVcu2soQFVYu3E6HEA+0=;
 b=GNU1FQdJ1eZBfJ1KAdW/pTBfWS6BpFrHXEQ9AnIXsWxTt37lG9J3G+yX/MfZ2+o2DMNP6yLv1hFG6MITuFFHfUGkVv8b6/SttZbM7p5VsKgkrRzdk0hWmKdR3YH3S5sZZSAqj0Sj6Fdsiq1Vt3LqjVy/gTP3tTloYmIezyFO2Rk=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by IA1PR10MB6123.namprd10.prod.outlook.com
 (2603:10b6:208:3a9::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Fri, 8 Jul
 2022 08:41:50 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5417.016; Fri, 8 Jul 2022
 08:41:49 +0000
Date:   Fri, 8 Jul 2022 11:41:37 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Frank Li <Frank.Li@nxp.com>, dmaengine@vger.kernel.org
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shunsuke Mie <mie@igel.co.jp>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Li Chen <lchen@ambarella.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-pci@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] PCI: endpoint: IS_ERR() vs NULL bug in
 pci_epf_test_init_dma_chan()
Message-ID: <YsftwaVowtU9/pgn@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0101.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::16) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 660ec22f-4ec8-40ad-c100-08da60bdb30c
X-MS-TrafficTypeDiagnostic: IA1PR10MB6123:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o4H0Sbq4lEloEwBUt3qnWix/K6Vf8ur+k8X6nzqzKzO+c4M2ncxECqEuz4anTMJB5CgUd9z7yicjLb6L05X9J/6bm/ORGON8eZHAKeSKN0BMZ5ONzYza3ihMxO+XdVjmo4GA/UFmTE5hICkjZjE4fk/HJN+v51TfVtBVp4xh/5UfM+YRqVs9Rv7Q8Ijr+h7f/cPRK3d/sc6DePBwjQeLuUaDTYLjiv2Bfde1Lmscgh3YjSLL4h7wopcKJXHjrqBW1YQDDgpisPJkZGll8BWhrnqsVR4UBaXrcMRMGmm0lX3qSoAa5w5hWX7wYleq3O+gFzeuXnJETFndmzbQBU6ywzRZPZa2+mG2+HMF+VCvvxteTJIEKlWMO06Cj9UCS7pGiPsEmcU/PCICnBaHPXZQudi9kkS/9QYCeOQ0suO5mI7FxFkTpSEzD676wDX+/VDuiSoXoyHDoU4Vzyie29Ivcz4kYzkUMtU/43aU+L/l+QGm/0K6ERyGpBjOZAiXuvM5V5UkiQNCm2rvGK3a/haQK/NCm10nMsvt0x6BfjS6vpBYOmaLKaSX7nTTg6Wtueq75c+TBBJhUNIX1v2tTQZrMUm1HW9wKSPF2CTZ+zkODdjGUS8Dxgi0SZ0E0yshjvZfO8mvx6dkCkOClusP13NX40H/tVQSB/hTd2WG2GIQpo0xNqWRmRRWw4bTAcwSLnaQHOV1QXS6GmqwFfd8tR/UDmxKI4ldp67Ta/8F8H++FTumzerPvzz5vfKc1W9EFLCzZFFneOOtGlOkAH1wPiBrT+0Xb19Qh4+d2J4hw3anXvj6dtFgVNl6as+QEgIGBWUd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(39860400002)(346002)(366004)(136003)(376002)(478600001)(2906002)(5660300002)(6666004)(8936002)(52116002)(44832011)(33716001)(6506007)(7416002)(86362001)(26005)(6512007)(66556008)(54906003)(41300700001)(110136005)(316002)(38350700002)(8676002)(38100700002)(66476007)(6486002)(4326008)(83380400001)(9686003)(186003)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cj7/tXDtO/tcF6KITWHRL58rbDslxHMmazv5sKdy2PSIkrrkgc5FuYRhKaJ9?=
 =?us-ascii?Q?VzvZNDq19kSls+tmCRosplA8TXF5Y8br0ggX1cmiy2p6N7FDy0wPGTUacXwY?=
 =?us-ascii?Q?3Acard0lKnjpu512FxeEfRgIjEWWS73Xu/ybDC1aNoSFXvSedwx+kM4Arycx?=
 =?us-ascii?Q?/gYEoVZjT2HoyvKh9Y7csO8IRtz17Zo7o6/5Stxn8LUh8ZZzXdEpYS8ClaAm?=
 =?us-ascii?Q?5PPeo45mv/V391xp5aAhZqoDhYu2rVkeyfi8qlriywdetUsnHVEy4ytn5Gyb?=
 =?us-ascii?Q?SswXHUSsL8vP2q4Pry5W5JOYG4I/mIotTORMHRiQz054fjHajBIPa6bsmwPj?=
 =?us-ascii?Q?4Iy6J5YOdqEvsJmuSq7nlOV7mhk/YNqgvAOQxKhnfjB72ZSnUoVUA67JYy02?=
 =?us-ascii?Q?XCMp3Z6SqR+SbJQOKdia2OsSJ27dmmOAqAwpfNExblJP9oBXS3yZIEHGwG19?=
 =?us-ascii?Q?xSRc86c9rKTxbp6S6Kb/Jmlt0lzyXJKRNtu+QMDffJuc0CAqWF1iqPvuBFaD?=
 =?us-ascii?Q?LRF3Q+S1ken0D+pllL9mVQS3FexoSl2TKwSINcU8vVp9lacc2Oi68GA/zK02?=
 =?us-ascii?Q?dxK6lqyRuiDDL1k23Bihy0/XBzeotomLpF4br4yd+GN0PtLNSQodcDMfYgb4?=
 =?us-ascii?Q?vBIMRzMIdfNoGRLKqHGTOmKMOtbAaqnIK0yxbY5VYuHvxH6So2LJXuSVhmQY?=
 =?us-ascii?Q?FOHrHlry1ziqfdf4pWEiPsHFwFPXVvJW5sj6VQCheHblHLJlzFQ6AMsUL09w?=
 =?us-ascii?Q?rb+mHrkPNRrIQmMGZXCPXWrViPq0gcKF3JwNZF8ohM208bmdJkEU3w3zJRse?=
 =?us-ascii?Q?8VLiMYpUS2WGsH2aL1EmnAaD8vcJQGawIeobVmRXzIP1G3HkKKEzEuhmGbHZ?=
 =?us-ascii?Q?w5r2+xVIOOPZ2sXHYkD8U3GFL8ULE2mHJZesDGp2gcqyebzdbSKQCCCH7Og+?=
 =?us-ascii?Q?quKvXfUaSKEErlqJpvcr2H41Lrfxoumx8UZT9JAJ+4Cu0DMFafc0XrrFFhuv?=
 =?us-ascii?Q?Pe3MTLgsc+1kUh+gQig6tKk3F3Ux7PBud3w+y4SnSKgdqEjDetHFuc3JyhdF?=
 =?us-ascii?Q?jOo3qK79KH66amE7J+taAPWPtIfFjoGov8+gcKE1IvBP8m0KAgLb8CL+771y?=
 =?us-ascii?Q?VDDhcvpmDlSgE0AWMEf1VNcn2hqOCW2/GpzoONUmXUBonfe3QheTukiqIx4i?=
 =?us-ascii?Q?6Sj4bWDUNciIjna+UiecV6C1AB6lH6oqwfrNIMkYUQm8V4mjmxbDij7T2l+j?=
 =?us-ascii?Q?CvfvZ5gjerrhMi+NflJF197+xsACpUr5OYNf58iYn2fZkCjWponCXemdSsSb?=
 =?us-ascii?Q?R6nVn5WgG+tvi6uU3iYikb3D3rLRc9Q2t63QyTZnELhXvtH1s/8xuFoShk3L?=
 =?us-ascii?Q?GnG55ynShY8QWbBcM10VgVyy12k+xgbv2wTklOvdqAXTZ6MLgF/8rCrZc1ET?=
 =?us-ascii?Q?0QmA2T87tb5Lbh2xunHJSTIIFhqHM2JxOYsrESkpy//w6KK1dEGRL5Jxwhxc?=
 =?us-ascii?Q?gKDpQc8Rt2vjYkUp8A7MWdBNNI4FH4qy3KYL/USNy1ObmjksQcxmgd4TmNLg?=
 =?us-ascii?Q?yvlBtG56ndsWfehBvaFdLO8jJ9Tz1F1DHrNIygrzm5bdF4jjwbpOuk7FCd3Y?=
 =?us-ascii?Q?hw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 660ec22f-4ec8-40ad-c100-08da60bdb30c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 08:41:49.8357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4pLLbpk6A0hcTQKmXsC/W81HeQGDtId7yQR8GXBfLv07ZLPDbD4LYvzkuebEsgtNeJo8LpfNCGLN24dkyMx1UCngJIR3IVIozBauDq0cWa0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6123
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-08_06:2022-06-28,2022-07-08 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207080032
X-Proofpoint-GUID: 4fWCsGEiYA9zHd-PWdkKdVGikgpGkuUD
X-Proofpoint-ORIG-GUID: 4fWCsGEiYA9zHd-PWdkKdVGikgpGkuUD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The dma_request_channel() function doesn't return error pointers, it
returns NULL.

Fixes: fff86dfbbf82 ("PCI: endpoint: Enable DMA tests for endpoints with DMA capabilities")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
It's surprising and unfortunate that dma_request_channel() returns NULL
while dma_request_chan_by_mask() returns error pointers.  These days
static checkers will catch this so it's not as bad as it could be but
still not ideal.

 drivers/pci/endpoint/functions/pci-epf-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 34aac220dd4c..eed6638ab71d 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -221,7 +221,7 @@ static int pci_epf_test_init_dma_chan(struct pci_epf_test *epf_test)
 	filter.dma_mask = BIT(DMA_MEM_TO_DEV);
 	dma_chan = dma_request_channel(mask, epf_dma_filter_fn, &filter);
 
-	if (IS_ERR(dma_chan)) {
+	if (!dma_chan) {
 		dev_info(dev, "Failed to get private DMA tx channel. Falling back to generic one\n");
 		goto fail_back_rx;
 	}
-- 
2.35.1

