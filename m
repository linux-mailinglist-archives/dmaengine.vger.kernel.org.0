Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F143F9681
	for <lists+dmaengine@lfdr.de>; Fri, 27 Aug 2021 10:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbhH0Iz0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 27 Aug 2021 04:55:26 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:54640 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244510AbhH0IzR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 27 Aug 2021 04:55:17 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17R6IoJY020751;
        Fri, 27 Aug 2021 08:54:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=lIkbv1fDmofjOyQPcN4tV1NAsqKFDoPhZu4GIcw0xK4=;
 b=PwrKZH0LHWKQIdvl3gXik9WMjNITpGYOdCY7mqoYeXIVEpFe+w1MiVAmJIdVubf81iwS
 tgMHV2oyMgwvJGGFa7RMevVp6IO7h63GtTSsITpfy0AmDaQ/6QBfRTkiC3atCPZvjwHW
 N70/mAjULA04EBDAoNOiugCejz5/5HZ2JoihZXnjgSgZQx2TdWiLKWAez+MB30UZTAyh
 6mLNqUzT7Nil1JcyfTCoZWUViMTALdAQNYd9ksZEuc1S5D3NiVow7YfdGKxJInJ3GXpi
 guEA4wzjWLBGBcfdcnrxVP/gBIYOmGQ41mA6O/LddvNoikbVyVl9uN876NDEZTrwDxSh 6A== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=lIkbv1fDmofjOyQPcN4tV1NAsqKFDoPhZu4GIcw0xK4=;
 b=M+Xn6R/55L6anags2T6Y0HTIOzOKK++6WXt+XgHsoInQqPauhIFL9Iz/G3mzCJLPAE17
 JCqclV3Z9j5oarhULVshAAPXXPJOyKJx2F1PIn0gjovIHdtt2W+1Kyb1BTAUgyDyvMJ8
 Na6JZ1RJgFS/SM/zTw8PF7X0mvoeYsKqccLi2wamFHJpFC4SP/4m0baRP8zGW3jbXl7h
 ZdIjRarKArk56vgBxUOa0mh8QlAkMsf4caQSfjiRtxA5e//GrKAC2fXIJoig9DQfioJj
 rBgcfNwuRkrRzPIcZJWuZZLvYbKLUx+sXT+Fl6xcnWTZ1T1ctT06tz7Cp3iyYUbDtacT 2Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ap4eku5fw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Aug 2021 08:54:24 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17R8pRMg049744;
        Fri, 27 Aug 2021 08:54:23 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by aserp3020.oracle.com with ESMTP id 3ajsaavj3h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Aug 2021 08:54:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UudWplS1eY6JFnj+QwH4B/k7Rxn63gEt8Z1wibwENr9r0zieQuVm0ci01waTBIkEWhK7+W26Fm8i88hTNW30RphdtK7K3cPhG3NM/tUO7g4QsJJedrl01+/yDabDVTAb7EnbrZ0k0QocYM92gQxbiF45BXkAMjc6ETAU04sOT33n5DYFALKkMSMqG/o8tdX/qeIxIrExbm/RY6Ff/dWw8wXwWdfHMdlieSJaPMRp3asSe0wo5p1JNX/cSjCxysVDa+5dOdHlFE4SfgYa8Y6lAPlkv+g2c1j+fLaAg50mKHg3hRJlmeGWaZ3PJHh7Hwz38SinfRbw9t9Xd7Ubp7reeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lIkbv1fDmofjOyQPcN4tV1NAsqKFDoPhZu4GIcw0xK4=;
 b=GRjbY2dRzf+IccBr8eMbVRUPSQnS2FbN5Pea9yaTngSRG5rM4rRWkvhQpEWwUemDUhYAI81n6oxE/LlbehQnZZ9zZSSWmEaBsXKnWfR7diNKK9QaPXMbkAqDJ0BVP+FXrQY3io5DxdxHp5KJ2PAtKBOkf1eVJknh2bKosmtmjOkFhHb5oUXoiCHyOdRcnqmCOeWxX9cLYFMackOn5nM4eVonMFV0jKq8fnxvR3UCXq4of3egXIgcJjFE+J4rVRlrEl5enz4ZJqiWm0sD5fa4tV6PVYtzeRmV+UbrP1glk1TAYELqa6htK727tw0KKFzgHSpzkdXDJqzqKgfVm3HUIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lIkbv1fDmofjOyQPcN4tV1NAsqKFDoPhZu4GIcw0xK4=;
 b=E6Rg/HawBHnBs4QNII0F5Qv1emzSAIFbZITEAQGaR7vHtGPxfQbZWAxNJ6hvouLN1AaFSanJlBGDAp6aHe6Tj6NM1WQeb2HUd+4g03o2zoiBh7Qei2FY6UPYuGgK3hNHB0QOs2XTzB39hfoQLjHm54VTTCNbpDXddEz2NOolo14=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Fri, 27 Aug
 2021 08:54:21 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4457.019; Fri, 27 Aug 2021
 08:54:21 +0000
Date:   Fri, 27 Aug 2021 11:54:10 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] dmaengine: sh: fix some NULL dereferences
Message-ID: <20210827085410.GA9183@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0078.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::11) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kili (62.8.83.99) by ZR0P278CA0078.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:22::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20 via Frontend Transport; Fri, 27 Aug 2021 08:54:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac81195a-6cb1-4d62-b4fb-08d9693842f5
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2365378187FD8167D4A39F0D8EC89@MWHPR1001MB2365.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 59spxdrRoqAlHA+763mTy9Dl81pyaoulwPuh1+iAhwvZQY3s2Z1ZqUKrFssVCjYgRNVe+Z4cBElz43SULhhoifId/a3anqxsRGyzwOxZ3qpCM2oZHwCGFDgFKnIv7K3mvmL99HqPXPm2lUP38V288Rrx4nIdTGfs+D79eQ/1ksuZKgjngCMIq6NGTK2QJyr2Mg67oLZ5zYw8M2X74CdUZIYQt1AzRtpo7PUNUWkUdVt6UqiRecDGBt36tgDS5tczIZbheJ6vTvQqdXgfMudThGIle4UCYWXsHh19SY1RovAMWhSlOFMsO0CIPDYq2WUrlT5Ph9p8bf5IPRXREOAtrkAQvRMbtnUuiut6UTo4E1cul44XQ0+D/faQv24GMrJjhieq3+bbNf+5QPb/vn/FXLpRuheYZwHDOt/kS+O3H14eq0q5BI9foVoT+LPiBUwhJe0EIdWFmE7070Huj0/JBVo6vTQOD7u5zJTWPjlI6mIH5MSPw+VjuyjjQ4Nz+cXfFiS3ZyZQa0hcQheDW3vKkvbq+oIIJI+WDpQ8DwmSzre4b6v8OmTb6LTzP6R30dIBjWJ7pxoufahh0yBa+Sy+KT+GRo+dQ1GiPKRst0rr+by9LrPkhqiuJK29HD1/Oby7Qk6Nh+Yq9BT1SFEudHWWO2qnTBOpNMK214yK5pztiEZ6J3RFbxsU3PHngyNZuix7eqFFnlnXSTzpXtdA8xkxWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(136003)(376002)(366004)(346002)(66476007)(66556008)(26005)(66946007)(38100700002)(83380400001)(86362001)(55016002)(5660300002)(44832011)(6916009)(38350700002)(33656002)(2906002)(316002)(6666004)(478600001)(9576002)(4326008)(956004)(9686003)(186003)(1076003)(8936002)(6496006)(33716001)(52116002)(8676002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5WRh0eYGBPFhjkeDB9SgJP8x7TOW9FzzHF6GCBNWEXRDSurh/OytU6fK90l5?=
 =?us-ascii?Q?SEewM0nWVKe6qbL16Bq6ssAcS9UKZl3XhTEoXIQYR/DimLY2vjsLEsTXLvPp?=
 =?us-ascii?Q?y5wRe83Mo+dv7NtiTlGoewn2T+soiMTbrTmuYc2UXWUe1boDiq3OtAFf4arm?=
 =?us-ascii?Q?3pvXZ0cVn1P4pCjUsiTSXG60qAoPoTpft2g4Az+1uGvCzP7yLdEA9OCeJb/k?=
 =?us-ascii?Q?vwNYIGONC8+DbPS4sbquxBzFFiw+X/Xzo7BePrUs/iU1OwM42KxEP9o5kIO/?=
 =?us-ascii?Q?gl1rJH/P1y/hcUhsLaB3HiSkTESGpK8L1VKAa9PRzqZR1sc4189gJcHdUR8w?=
 =?us-ascii?Q?b6TR6hzZp4SQQLem+4Q5nxLWVPurapor9pmwmAv/pUDMJzJG3FYps2G46lS9?=
 =?us-ascii?Q?c1oNqJ5omJ1wT+g2FOVomsGfzOx4UHRUBzRd2yPe6jks5nGINccWcyPqzqwY?=
 =?us-ascii?Q?b9VzxP1kJNcBSl08YX1/ejjAe7BNxiTUWzP4nKk1WGDYHELdU1xCFGBKREeF?=
 =?us-ascii?Q?MTZ9bzioUEnEQd0352eljj+dRzRK6Qm1wAyE8SVPqjDbSWih6P9rAyaeTgsf?=
 =?us-ascii?Q?lVGuVGHWGaI0JNqAXgrblb8ux1hhsF2S0C0cs1a8nDGWzLsDP2iS2ZZWmDsj?=
 =?us-ascii?Q?DEce8NSOvbhrsgzrAYrFJos3E8q9bYIn8Lcxqb4XrIYNqJb0Rm9+fjL1Zp/H?=
 =?us-ascii?Q?JpPde+u6gK8fMmi4HzoyCOZZ8PFNZT26sLxKG2T7T1+NM9oMSWNwhDZnLXF7?=
 =?us-ascii?Q?NyGNVDTORKlK1EOGb+CPWRYclO0J5Mcz1xw7C343W3zvRDxob+lBfp5q8/lH?=
 =?us-ascii?Q?zea5DouE323BkjYQNH4bYsRb6v5idaYNcj1rKEaRqNa58k/BmwdQOfTCF8Zo?=
 =?us-ascii?Q?wYLy6WY8u0OnRUVTR7lJ4sNP67f4dGcXOd0ipVRgMa2nRVk52cQUE64oXuLH?=
 =?us-ascii?Q?fM2HegVwO+LVF9OWdcNR5ID1By4sy7AUzrNm034Qp+B68/Z6wNJpR2fs+JRI?=
 =?us-ascii?Q?HcEXctdsj+mFrRrhJRF66QBbQqrtKHsdhsrKTFn2KCGHacM2/EMkVEb4UD/T?=
 =?us-ascii?Q?FjWHh1I+s8pV/S/V5wiGQgkwjN/xehvhIwZCoW4/gGu7HBj32vr+XRRT7iK/?=
 =?us-ascii?Q?E8objCUsWpoLkIs+nzDEtUetE+qCSgKcv4AsfBNAUwz8AuJ3dTVFkbwRoUyK?=
 =?us-ascii?Q?ag48GNAqXTbgAh42IE65MmR3t7QTUQ7EpS07tzRGI3KjWvgDef1vnTDviCDT?=
 =?us-ascii?Q?2Wvot0Of8G8GvUH+ewKZK08EWhYSoIVawh8PDbXugoIds5mvE82N/o1zUplq?=
 =?us-ascii?Q?aLWUwZkKvmPUJZR0uEbfP1ef?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac81195a-6cb1-4d62-b4fb-08d9693842f5
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 08:54:21.3127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YWsHB93xnggWXXWV3ZnZOFPK6HtJ8NPYtYyVwHU/uIy0rJju+EwR+1sAiX0O4Nr+u3z6i/jTVQ2mrbzGeBKj+3m3G1+McQ/11s8ZOFfRcq4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2365
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10088 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108270057
X-Proofpoint-GUID: z_nFV5DbUXQqpQJqk_Gh-Id21rtqH8re
X-Proofpoint-ORIG-GUID: z_nFV5DbUXQqpQJqk_Gh-Id21rtqH8re
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The dma_free_coherent() function needs a valid device pointer or it will
crash.

Fixes: 550c591a89a1 ("dmaengine: sh: Add DMAC driver for RZ/G2L SoC")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
This means that remove() has not been tested.

 drivers/dma/sh/rz-dmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 11986a8d22fc..7c1db6a5b365 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -921,7 +921,7 @@ static int rz_dmac_probe(struct platform_device *pdev)
 	for (i = 0; i < channel_num; i++) {
 		struct rz_dmac_chan *channel = &dmac->channels[i];
 
-		dma_free_coherent(NULL,
+		dma_free_coherent(&pdev->dev,
 				  sizeof(struct rz_lmdesc) * DMAC_NR_LMDESC,
 				  channel->lmdesc.base,
 				  channel->lmdesc.base_dma);
@@ -938,7 +938,7 @@ static int rz_dmac_remove(struct platform_device *pdev)
 	for (i = 0; i < dmac->n_channels; i++) {
 		struct rz_dmac_chan *channel = &dmac->channels[i];
 
-		dma_free_coherent(NULL,
+		dma_free_coherent(&pdev->dev,
 				  sizeof(struct rz_lmdesc) * DMAC_NR_LMDESC,
 				  channel->lmdesc.base,
 				  channel->lmdesc.base_dma);
-- 
2.20.1

