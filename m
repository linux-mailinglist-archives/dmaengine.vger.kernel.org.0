Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60A44A6C24
	for <lists+dmaengine@lfdr.de>; Wed,  2 Feb 2022 08:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbiBBHQG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 2 Feb 2022 02:16:06 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:55514 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231972AbiBBHQF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 2 Feb 2022 02:16:05 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2126KwLE015797;
        Wed, 2 Feb 2022 07:15:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=RNACIWRbzpuyhNMPUPHQtcY/cNBkEaDuTM7C6cJKGtM=;
 b=NwNsz6F1hELb/kaVCx708B+zuy4Tk0I6HlvVpEX0tCd8FbULQQ4kfLRAFzBEQHbZtYG8
 MSjHU63o6hrn17rgJ4XNjLigay2X3BIydZO3uE4K8hyl9iV3RMaoCEKPwkcPmeBJKqMn
 8AGPKmq+mgg447zX/waz0z08kQBZebs9ePy9ByzGswxcrBvPvsWis7k2MFnnwW6flTpZ
 bXIAJ6qk6sxzVFz9/IJId0Dtu5kkt2zUN4/Y66psk+zM2wWSHDyWINPIiq8IuEnRb60e
 5GU448hz/MOzv+42nONbHr9R5EKipTa43knZtaoxzjhgvp4McpOpZ4YiJ2o3kN1wHaqZ cg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9wd4ac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 07:15:56 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21276BHl007984;
        Wed, 2 Feb 2022 07:15:54 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by userp3020.oracle.com with ESMTP id 3dvy1rkk63-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 07:15:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lkPPYSf5j8iDqnDsLrYq8tFsja4p7KVUvCgXxEuoz9B6H8forLa6l/blXfPFh4eoAH9krqfCV+jA+rA7TAKWp+sh4AVSmBAHg2Vo2ABNdL0JgNo19hkRBsma1KIZ4LK3Sc2DQlDq8AEVrhsGzh1K6Ydrb2DyFIuBjyGMgnYtpWF1S7Jr6L4CgzfBbPLKYHm+5MjUsmYOHa9wwGdPcNd4GAMEOu6m8anq5R6PJSFJO+FSCbbghvW047oCNzff8jePlRapn/u7WOD1ZuREO9Xq2OozK1E1Nixg572HLDICAdyqXckv+5tvJ+DJ/tKEPkLRzuacgpB5tzovfy+9U+Um3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNACIWRbzpuyhNMPUPHQtcY/cNBkEaDuTM7C6cJKGtM=;
 b=UB7KXX39uHVlWta7u252iGBA4iBtKGuAU/P3tuV37kqTrowmy+etmpHWoqkXHqsSB67UN8r+mACoLgTMiqyNf4aU+Z+wnRX7sz93+3ThaO0N+DKWTDbfP/9H+8OWFgEcWFkwDjzb7srl1hqcVbRXjCK4bsk8gVGnq+4Jq17Rd75KCLm3Uu9RJYHPxZqtkU7YSZ9p92fWaefG8SQM0UElt2jtbkER5x90w7HDSyghS+MurAdZAJ7uE+m4oHeXLbchzdN7Rjjdy2fBuwaVz1QZEo4zfSNl3nP5mP1Kja+OwmrVHfd+h3VwWdWo+EqOaMRyIhzwt3sKudRssEESLbPo8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNACIWRbzpuyhNMPUPHQtcY/cNBkEaDuTM7C6cJKGtM=;
 b=l9FTusCK1W33Ebe3kmq9YfHgzQALqeFlVFEjB2HYyparsRvaVD8hPKi8tbc+VN6NBn7laHhXMRujdn2tYXEsDnH2Mov8iGeJMukkMIWDdlRJc15hrrNK0YXl3Cs7M6Yfx5+1ZGEg3TKSBRTMrK74TfgXA4aWekNV6HfFqajgDyE=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com (10.174.166.156) by
 DM6PR10MB3274.namprd10.prod.outlook.com (20.179.160.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4930.20; Wed, 2 Feb 2022 07:15:51 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8%5]) with mapi id 15.20.4930.021; Wed, 2 Feb 2022
 07:15:50 +0000
Date:   Wed, 2 Feb 2022 10:15:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Sanjay R Mehta <sanju.mehta@amd.com>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: ptdma: Fix the error handling path in
 pt_core_init()
Message-ID: <20220202071530.GV1951@kadam>
References: <1b2573cf3cd077494531993239f80c08e7feb39e.1643551909.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b2573cf3cd077494531993239f80c08e7feb39e.1643551909.git.christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0010.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::22)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c7ff7dc-79a6-49ac-a6f1-08d9e61bd7b4
X-MS-TrafficTypeDiagnostic: DM6PR10MB3274:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB327404AD3A3674599379942A8E279@DM6PR10MB3274.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A7xK7cic+biTrhqwgoS9KOjV5ef5UYn7u4NmK5vbf41s6wgjfOrxRL26MpfEYHjlJoDBrz+bWnOVJZdTqGJyOt/rVNMQH9LSX7dhcvfWs/d0J+cIvyvIf1wiIyK0VrZbl2QLFrhMUcc/pq1SATapfr5FdweaOW+NZE+7uoOiA34AkHIqOh+iXDZUsCEdraAPMNPMi1LLVUj8d5MAmLlZZnEa7iNPrt2dMn+NXPF0EZxsey9jzyJsnkrvbuR919JXcE1YtVyfqWr97manXPx8UIG8eaHV8h4Y5KbI38dK4VRhPm9wG2CVv0ReiV1VMdUJW7d4YM9c19OLeZkooaL0nyJj/H5jROPOn15cexLuXEbfIUTCa9FgZq4r8TRTX5a18D3mrj6R2oqTrSK4lHCmTl1fLqOqKkxCAPk8JPFow3c6heIRwLPTthhinKIbhLc9Ys2XmCvQTL6dyTQ/eZ9Ygqek1uP88d2nDf9jvcsINcOdKFpul3Awckl22bQ79pY3XeaIGE2CIqZlIZnxzp8DCm6F3JqtwjghusDwqWYwrEjH3XuA1Fn6F5NXLRPNyd1p9bpcfx2HSDVt3Gacaa8LuPzkLE5xRWQZWBPO9nd/WxBchui7snLkcZO4Xp23ISWLDgDGMNrWyup1XNsAPB0H85MtI6nK7NOHr82MMbfE27Nk4fvS9APR+s+8HPqNnXEgnRbeRobQkb2jlUh/4WiN7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(2906002)(4744005)(83380400001)(33716001)(33656002)(186003)(1076003)(26005)(6486002)(66556008)(38350700002)(54906003)(86362001)(4326008)(44832011)(38100700002)(52116002)(6506007)(66946007)(8936002)(6666004)(66476007)(8676002)(9686003)(6512007)(6916009)(316002)(508600001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yaDvrehSiA7MQ4HntuTFsiRrEExzEdnv0SenfYjyMd6Cz0vqCjgwJ7DJlbCJ?=
 =?us-ascii?Q?TsKrHF5+NU7Kt/IZ2wrJfu1vzAlzF3EmMmzn7t2K3GX+Y5MJtbVQXusDz750?=
 =?us-ascii?Q?RBeHnT1XEPGFk70V1Qc/BjREPN7V1LTqHsUKxUxGkZekLeSAbrYLZRqa1vN2?=
 =?us-ascii?Q?Ch6N2TTuINFVaqSaQNcnLPE6rFPS9VMSLnfh98pJbsFLKUP2nAtICmL5z0f0?=
 =?us-ascii?Q?LLfuf2lh+WmI82CvWKXMz1vOKehMdaZEcHXHZDjEiJv/b5RIOtj/OSVyUXIs?=
 =?us-ascii?Q?w4zKkPGnytTVzzcJK6dGXaP5nQ63Hi3S0z+lDdn7oOFv64oW5EJfCQR5f1UX?=
 =?us-ascii?Q?5Acq4mX3MansHqF8yZgTRoe1xa8m9ss8Wz6TlRXh+c1keXu1cpzJBVmHzqs9?=
 =?us-ascii?Q?JAeVyqrgvo1sRNn1qAvTQKmWu42cQyFOX1XHO/0ejV7S/VZWEX0HmEqiiGJ6?=
 =?us-ascii?Q?awlhvY/YZNSBpe1X1gO5guN10uJcrX/7yDizVVW/kes78tYWHOyxLP5x44dL?=
 =?us-ascii?Q?GL7Pbdcu5vZXPBSMBpZSR7aPg7n2fKqtowPvPvids/r3qbC14/beYoRrfyPq?=
 =?us-ascii?Q?0s7YsHRSv0hCgOAckpqXxAMWdjPeB9lQqiKmdZFM9tIstqoJMuKBX7DvcLDI?=
 =?us-ascii?Q?z3Dzj3gHScYI7pzHZHFIRHAn0M5nJsR9LLMpVUAclHskHkURgey0dBSo7N9h?=
 =?us-ascii?Q?Lizt3d0SCxrQ/SdxDhuE3q+IsVspO3UOK4/rixcARBfrl3jXMuv8ftfkXyBa?=
 =?us-ascii?Q?M69Ycos1z0wQXTVF7yvTOVjrP/wxJ2fRNyRjLLDX/Bb6TlpI28/eGUZ8JL2S?=
 =?us-ascii?Q?1cVrGizBzy/xbRk9fDwR7lb47GNLNq3uEKF2jMmNGYDrXnYu6WNdMjban/5p?=
 =?us-ascii?Q?LhgMdFsPxUFT/drxxstGwdv/igiZLim4DIfMSraZHW8SYCIEwpyS/PygjFcP?=
 =?us-ascii?Q?gIKhcysm3TaJQqcNrQ/sDej/lNJ+a0RO7cSTjj6JZEeLNXoznmRfR0xdK3yy?=
 =?us-ascii?Q?H2fKlYkPkMIe5jHHv6DVXLdK6Jw6+rAuuzjkDzSwjQF6IoViJlfQuCgAsB8n?=
 =?us-ascii?Q?cr4YO7vg8Zv2bLTxIWqR9fUwI6IBYEAGz2DAwtSswQOX2z6vFDtBEihIwncu?=
 =?us-ascii?Q?qu3sUQWJKh3qnsO5uuMe7TAGqRfqIKO6r0Dgvzb7LBhOqf5tvL6Hmm5C2o/3?=
 =?us-ascii?Q?G7uDefR4pgtIw+dQwJJUk+Esv7sD5Zk486ozAE92oHfKJ8tr/unKHek+UiFc?=
 =?us-ascii?Q?rc4ib0LTpTOI8ZYwx6ZIz3OwzBhECB/UapHGngF8Gorp44yp/cYmBlMOx1d2?=
 =?us-ascii?Q?Ip8tRZJruFDJs6yt0XqcZnr6FSD1MtXHzkCp9idBVRZiEVf7p5/LfEJAX/z8?=
 =?us-ascii?Q?656ZAGG2r7NurB9gM6F8rmzfmLfLT+ojrST8D/lC02CeiSGHsCVY16uIHf+F?=
 =?us-ascii?Q?Eul0RppE4Iib/BV6emnxkcvqyI4LKkAok24ZnEEZaesEIPvR+bIZXHVYy+Mo?=
 =?us-ascii?Q?hJUjJLKPA0zLasd/zk4nXZ4Y1k+VjrKf5JLJ2xjPoCqKISFmdBDKSPjpD3FC?=
 =?us-ascii?Q?F3/Xjzr2DW5/RnEsZJTbWKRVqz2WvnpSQ+HyjAGldAtcAZ3yfMXaDDfCfyJ0?=
 =?us-ascii?Q?5uKNk9sejD4HfQULz+0/A2hxnU8Rirq3v/1YijccPfUbn6+jNVbwVQd7/f2Q?=
 =?us-ascii?Q?zK1X2E2jJUqeIOWXhYGW/M2Blmo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c7ff7dc-79a6-49ac-a6f1-08d9e61bd7b4
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 07:15:50.9113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GaPOMNIoBY5PIYJs+IPF48TpxJH1K7DU/+UoTjCUJJZ1HYj9j8EPCnz/Rk8q4uzQWMoCYalW4hXoXbpygqo7XBzZBbLhGRVJtvQpV8QeZ10=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3274
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202020035
X-Proofpoint-ORIG-GUID: iZdmXBwAeODmXHJKomkEcQj08AdkOnfI
X-Proofpoint-GUID: iZdmXBwAeODmXHJKomkEcQj08AdkOnfI
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sun, Jan 30, 2022 at 03:12:09PM +0100, Christophe JAILLET wrote:
> @@ -230,7 +230,7 @@ int pt_core_init(struct pt_device *pt)
>  	/* Request an irq */
>  	ret = request_irq(pt->pt_irq, pt_core_irq_handler, 0, dev_name(pt->dev), pt);
>  	if (ret)
> -		goto e_pool;
> +		goto e_dma_alloc;

These are ComeFrom label names.  It's an unfortunate style of naming
labels based on the goto location instead of saying what the goto does.

This is one of those cases where the code has moved on, and now the name
no longer points to where it came from or to where it's going.  It just
stands as a Hyperart Thomasson pointing to the past.  It reminds us of
change and decay.  Take time to smell the air in autumn.  Beauty is all
around.

regards,
dan carpenter
