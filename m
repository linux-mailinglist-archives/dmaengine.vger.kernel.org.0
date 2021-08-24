Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC403F5EE1
	for <lists+dmaengine@lfdr.de>; Tue, 24 Aug 2021 15:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236443AbhHXNZF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 Aug 2021 09:25:05 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:61076 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229601AbhHXNZE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 24 Aug 2021 09:25:04 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17OAU3tS025089;
        Tue, 24 Aug 2021 13:24:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=Qkz8PG9yK5pTHtEv476B64oeHdLE7OL8Yxg7wZdyYh8=;
 b=sUZQ0DOQMLdalsQMWlx22CnxDhLNn0Q0tqSlvQYU/QM1B9rTMTBjVl2F07zAigx5eS81
 F9zcd3mpfnd/2l8RFBtIDKnwEBVpRoIGhRZ0/bOGgQJ55hie7kQYL5uLoJHo4mVpTtPZ
 rYEeXXlrjc1Re/cT9TpqVVvlb22bhGH8zkKmsx6+ArJsdBU+7MyBObRr9hAygODSxTiL
 6s5PY1HWundcjeEpNikUJLMlYTgdn9KFQXkVysy+9xbzfaBsuyyCK/tL00qANl2DNTHg
 E8+Wa7hhIAB9Si+9WQM8UPChYi706VErSkHn2GkPrxEz3zVVWLFcyVga2s8nNx5F5OpA Zw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=Qkz8PG9yK5pTHtEv476B64oeHdLE7OL8Yxg7wZdyYh8=;
 b=C8wbXHHbwWfELkxMJI53cCA+fb92A6NY9GcOMFm93Vo92KXaY5V6dZ8aPy/uYugdo+tq
 VM9QAouV/TW4koNuK0dnypvnl0SAQBHp4PiQZQdtnPLm4FrmS90yGUOaMjVLTGwOEbwE
 wOOq7cNwDHl59ueeUJ6HPU7GC5JUhh+eWO0RJdpLvJllEBGc4ZNQGOBwwH0T5aPb0ElF
 R8TF62S6yJrDIw2i2AIIeNZGd5lpql0bAnFtf/DnI3YFK15t2mouOLy0tqJ9Wso+zgN/
 9Pq2blkn81KA1jiv4p8HS/k3i/R77sw/EM4lOuSTNctvHqLlWGYoCDtv3DrXgtdErAr4 PQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3amu7vs1c6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Aug 2021 13:24:20 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17ODBEfL190527;
        Tue, 24 Aug 2021 13:24:19 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by aserp3020.oracle.com with ESMTP id 3ajsa594h4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Aug 2021 13:24:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XVBKbNwyn7nsBF/xMoh9uUAeH4a2bKu8QXUYb2BBHVrYqPAwrByUI+p0ZDIkaVdYluP89x26+GVIaPoJW1nli/4l2K56ErcrUgL7yzrMjEVLFJdJ/vV0Clwd5yZdA8CNhtrPa6JJdzxu4fksB6aMn/tvxXLgOAci1nNDqpOxGBMF4nQp2hf+6X0esLc1mF/bFdV8LN0pghzo0dRn+jPN9SxATDu+dl7z5C6mFUZDIzlVrW5hf9T9IapMtanyos/CX1CnKERNWBESfKtjQBISn5WDGqCkyQZLdcFhM4QLxJXJbM7cEUZ+dEXLHqsSC58ncwub2WixJt5yLUYRFGFXLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qkz8PG9yK5pTHtEv476B64oeHdLE7OL8Yxg7wZdyYh8=;
 b=AasGkkqgzeEP6dmaOW8ka2tpNLGXZJGiiZMdMJ1xDXaZOZmhhRxFQ7l/Hnfrw7uorToSsf/RBWK26FcaSV69naPkCrQlMe9ROza6AjEOYYzwa7nq5+BlOyJgyg2KNT8awZuHw0FcOovhIHIu0i75U0vaRqnbq/Vt+IVkSFoW78aOFm2KL5HNyuJy637yFvBUJ1VUD70gWgDJs/OYIX9rBEkU3X+8oJUhKE/p8fEUecyPN0en/ksy4Qiw+l95p6olpy0g2i/LcmQP/ICUsmM4rZo6Pru0+HaNCcTLGUopuKL5cOrM8j2/ft5uT28S5yLmSMcX1A9VU5C9mKcTtxNxLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qkz8PG9yK5pTHtEv476B64oeHdLE7OL8Yxg7wZdyYh8=;
 b=UzuKWZDyZVrEnez7xxj4U/h42CtSwqObKmEcyx4YyaCejju6616H4JFLxsnm0pSWp3AqY41qqEMdOtsbhKD3O4ppXVI/1cL53R+bUGPhENemGwrr18sI9MIG88Itac6H9v3qAaDvNUEY0Kkmbv6OCP5w7oPD9Z0TyO5zCUqLeEE=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=oracle.com;
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by CY4PR1001MB2360.namprd10.prod.outlook.com
 (2603:10b6:910:48::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Tue, 24 Aug
 2021 13:24:17 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::784c:a501:738a:143a]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::784c:a501:738a:143a%2]) with mapi id 15.20.4436.024; Tue, 24 Aug 2021
 13:24:17 +0000
Date:   Tue, 24 Aug 2021 16:24:07 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     dave.jiang@intel.com
Cc:     dmaengine@vger.kernel.org
Subject: [bug report] dmaengine: idxd: support reporting of halt interrupt
Message-ID: <20210824132407.GA6072@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: LO4P123CA0116.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::13) To CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kili (2a02:6900:8208:1848::11d1) by LO4P123CA0116.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:192::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 13:24:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 966c0464-ce5e-415c-4c88-08d967027912
X-MS-TrafficTypeDiagnostic: CY4PR1001MB2360:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1001MB23609BD5406E8AFFEE2409798EC59@CY4PR1001MB2360.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bbNJ6xVJ1RnhoxRBxnauFgNq2ufscxOnvmwRTJ26Ef/Gs5a1ZeporjeADbieW0lGEdcpHsM7qdUDLGEhqoN+5HCvL8soGdDakCa+bdFfEuEsce3Iirtjxh8i9tLmbjJEKQjY+BREpq7QAwOIe+KJ7zbg49Sp8fU4LeIVhwJCWfh0KrJv2kP7E8FDsJCaWCQr8Wi5cwyiImC8hi8Uk1G21hmE0/L+T58j9uH7YJAd+d9yxY2FfzlA4/KZ3z9ALWyJ7dv03j5IZ22HgNZnUDE9Nv77PCjXYPde90j0Jj5zbgwLhYSIbK2MlbKulSOkqY6HH8nPBHd0uk2HVpXfBfgcANCHNFmQPoie1SJhq+2iQ0WnV4khSEHUuOnMxvyIxZUr3p2rJ1TrjuwgsvKEkgQrGz8+lsnjItvTnItucg6kMhAceH01kF96pnUqZz7gUJU7WHPHw7ownaCX9SlPB2fLUtqwND22y6x38aKsGTFtzLo7kyZKZ8ruDc7PX3VqI4UBLyCNskqJvGHGBqF+xP07J7RRNQyppljHq0auLnHBbXtvg8ODXBbORZUMcFpJ9GrsANhoK4sXshAkIgl3CB8SKdaAyDvco75SsCpW7ld8Wh6u7zmUhcIwztGiiF7duaw1IkTSmOEIIdAUWP7knPTtoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2358.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(346002)(376002)(396003)(366004)(5660300002)(33716001)(186003)(86362001)(9576002)(1076003)(2906002)(38100700002)(8676002)(9686003)(55016002)(66946007)(4326008)(6916009)(8936002)(66556008)(66476007)(316002)(33656002)(52116002)(478600001)(83380400001)(6666004)(44832011)(6496006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fWGsZhiYrChf/i8dp0+4Imy+cWu+8+2HfCAEsoQGBzEBqFI3QP2VDFEZx9jx?=
 =?us-ascii?Q?08QZ978CXqzeL995r8uvmrDhwLRrYdHyiAOFswIx+1o4O0ncgX+uG5Uv5KGR?=
 =?us-ascii?Q?+0n2oJxs0gL1jFSy49Ot8l0vwMuyZOcC7TiSRVKVEb4b6am/PLb+Rc2YeH4a?=
 =?us-ascii?Q?ogk6+8nRwhc0UOlVLjRzJaW/KNemIrUMj6ThlQk8kQrg/sY1I9Ft0m8lcDIa?=
 =?us-ascii?Q?6RwfGBGcTzfjgZBzmJyFoyTt+z/RdroYkPGbHEkFQhDTdOSrCEBQscP4rtLL?=
 =?us-ascii?Q?ggEwrt/zeh+Q3H8ePT0XDdViNxiZTwkpZ8zjv/VJlWIvdHdNs2aG+0nzfdoc?=
 =?us-ascii?Q?LxJEkYvh/obluyogBaTuqTgROGE2KO8tcBouCkbEn24wlHuTzu7eLypOT6tp?=
 =?us-ascii?Q?apUNUrKYZ1p82Z42wu8L+56vB+Va0tjiIak49WIaQCtEILVAu7cI9aRLut+g?=
 =?us-ascii?Q?urkJtMHu9fAtjQOx8A1/lTNDHaB7+PMf7VvUb7HBotiQ4PLRlECPJUDAzKiu?=
 =?us-ascii?Q?nnPEQh9BrZavvyu4yfxTVShOOKcEBRMSc+/8A0oJNTvt93ttUvirqkK4O6q7?=
 =?us-ascii?Q?Okh4Nz0dXYUDT7amqwXe/PgcCDwTQ6xCoWjOpbCtS2u16A7RH4Ss1wZ5e9ux?=
 =?us-ascii?Q?bnfimpd9Rp7hQLamVlW4rr6pZMMMkxc2rh3Uvlm5U/Byy5uRXRcGKeNHQCrP?=
 =?us-ascii?Q?PFQ8BOKXZvQcc60m8+EgftujAuSPEYZnThnndRysRk94Yaab/syPwNiAfy0a?=
 =?us-ascii?Q?aNo8RlQmyU2dDXzBoD02WH5DKk5HHnEGMS+MbZ4H9qExm0HX+mEfGXR8amAi?=
 =?us-ascii?Q?tbbuhjLWXfEqSetn2I75Hvltz6LVqpFNfnqKDmerFoVVCP8NSTMcsPgljMeR?=
 =?us-ascii?Q?+kw1/Mo3ywqNFz1t3yTDoOVynJAAC/N99magDauThfxmaUh4H8lKYgLKMPzz?=
 =?us-ascii?Q?/r3JJKYbMqOp2ntZLI1CL63XffpOUPkNuaH1rsoAIDrIozZ5XWrEUnNW48So?=
 =?us-ascii?Q?PcLGg8VU6fCAb6adVrFj5g61Y2DOeTmiFKVMABbM9GBJ7+7RSQzODEjuSo+F?=
 =?us-ascii?Q?wdAtzMu3h6BOSIjbsHiH6PCEUmjC3vuxLFuvWwMDtArJXFom5Z0Z7oV52f7v?=
 =?us-ascii?Q?6sQkRA6u/qNi7KSOu4rErac/ZjR2oDha9U7sFka9SWumphlbsvuyB1SFgSeC?=
 =?us-ascii?Q?Jwvun/F3VeKDd6p5l16FxrOhjRWmQ+MUWZ3YR7A0K7+nAEAAP5oowqSW6qiB?=
 =?us-ascii?Q?RQt0R58zeNzKvKb3R8i/jQylPJ7iI4N4XNepayUSRV8S4VW2ZYdTqHuwO0tU?=
 =?us-ascii?Q?h3+X894AIegRNQHLbNPsXlYfPTKSDPXjaXeU9w6Av+8vorv/CYRMBtOjBkbu?=
 =?us-ascii?Q?NF55CZw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 966c0464-ce5e-415c-4c88-08d967027912
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 13:24:17.1531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l5hOx2H2723JZDr5he5xBQ4A2PlVofFvQ4+gm3XDzXUpecWx/1Whq0hDsG4oa2NQtvMtRO5XEqZbD2zd2uUBaHvD8ODU4X1hiFAAayINHEc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2360
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10085 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 mlxlogscore=972 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108240089
X-Proofpoint-GUID: 1te6VQWJG3ZHd8sCCcup3T3mICUALiIc
X-Proofpoint-ORIG-GUID: 1te6VQWJG3ZHd8sCCcup3T3mICUALiIc
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello Dave Jiang,

The patch 5b0c68c473a1: "dmaengine: idxd: support reporting of halt
interrupt" from Apr 20, 2021, leads to the following
Smatch static checker warning:

	drivers/dma/idxd/device.c:431 idxd_wq_quiesce()
	warn: sleeping in atomic context

drivers/dma/idxd/device.c
    428 void idxd_wq_quiesce(struct idxd_wq *wq)
    429 {
    430 	percpu_ref_kill(&wq->wq_active);
--> 431 	wait_for_completion(&wq->wq_dead);
    432 	percpu_ref_exit(&wq->wq_active);
    433 }

The call tree is:

process_misc_interrupts() <- disables preempt
-> idxd_wqs_quiesce()
   -> idxd_wq_quiesce()

drivers/dma/idxd/irq.c
   124          gensts.bits = ioread32(idxd->reg_base + IDXD_GENSTATS_OFFSET);
   125          if (gensts.state == IDXD_DEVICE_STATE_HALT) {
   126                  idxd->state = IDXD_DEV_HALTED;
   127                  if (gensts.reset_type == IDXD_DEVICE_RESET_SOFTWARE) {
   128                          /*
   129                           * If we need a software reset, we will throw the work
   130                           * on a system workqueue in order to allow interrupts
   131                           * for the device command completions.
   132                           */
   133                          INIT_WORK(&idxd->work, idxd_device_reinit);
   134                          queue_work(idxd->wq, &idxd->work);
   135                  } else {
   136                          spin_lock_bh(&idxd->dev_lock);
                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Maybe take this spinlock later?

   137                          idxd_wqs_quiesce(idxd);
                                ^^^^^^^^^^^^^^^^^^^^^^
Sleeps.

   138                          idxd_wqs_unmap_portal(idxd);
   139                          idxd_device_clear_state(idxd);
   140                          dev_err(&idxd->pdev->dev,
   141                                  "idxd halted, need %s.\n",
   142                                  gensts.reset_type == IDXD_DEVICE_RESET_FLR ?
   143                                  "FLR" : "system reset");
   144                          spin_unlock_bh(&idxd->dev_lock);
   145                          return -ENXIO;
   146                  }
   147          }
   148  
   149          return 0;

regards,
dan carpenter
