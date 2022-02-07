Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC484AC6AD
	for <lists+dmaengine@lfdr.de>; Mon,  7 Feb 2022 18:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbiBGRBv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Feb 2022 12:01:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236445AbiBGQwC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 7 Feb 2022 11:52:02 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E25C0401D3;
        Mon,  7 Feb 2022 08:52:00 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 217FZLr0020213;
        Mon, 7 Feb 2022 16:51:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=e8jALhmKWLAdDmZgbl3TDtovSPOMgVyf7M+x7JNasIE=;
 b=qmGcFj9qF5mp1Ef8d5zijCpGqXBuKElkpSvY8849FkMqB0RNsY1m68CAKtvdJ3WLOnHq
 3WnjKqrPpw3vK4MJc/oktsc1FvTPn2liDaTp7ExquPiCSR8r/SW4ihn67czv1ZtGTCH5
 AjLwjNdCiks3zgjFEdtL63lsrDjhWXS6YzXHOHGA7urkkOvX9yWQk2QYMzHVdRubfxO2
 br+prtMH5edLrfdXtBydjzlN/ZICxpXYEILLsGqAD3J+YxDaxNaVlCyb1gdw3trfwX0N
 GPInp6xF6MF6LtKKwL+scNIJC+bV+xoJdHXZtlh8EzVXL0ttciXa23SKaET+5YihNUrr NQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e366wr82q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Feb 2022 16:51:56 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 217Gk1aC056820;
        Mon, 7 Feb 2022 16:51:56 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by aserp3030.oracle.com with ESMTP id 3e1f9dnej4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Feb 2022 16:51:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LLEFCrO4xf3PrhMLGbl1mJ2gtZ2uw4DOBbanIIymQLb3bgyPai6EDArsgpL6jjIkZJk+U5QMC2XwsbfHnAAzLoZjKDLLnRp09gnqdNWQKc2UbToqTLioXk7g/seeWcwXihqcAgiEq3Id7BfPW3JCvBpNziR1eRfUMZQLNF/QIhQ1FoGvMCl+GYAjF7lPEm5Z2uIvrNN+onT+XSf9iCf+Z96mKabAlB6WJwx9HIBj+t/HNowsGwGq75KWzjAeVJv0Zzr6+jid62Zng0pX2V7Z+qN6Hxrw4uZGegQM8LXv5UJyyQYdKWszS3Acs1gRdAtVrO5Ib2FGgqx3H4SQQq3eiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e8jALhmKWLAdDmZgbl3TDtovSPOMgVyf7M+x7JNasIE=;
 b=MFXiyjfhZd7240oW5707PfIyxjPRl030OXLrGjyJXWIWB44DlVB+nW7m1pAZe6v8z1ax3hq5Xl/n70OwE9wYq3l75N2uLIWN/OXYZsVUY09mUYzcKvyPlwj1aLe7+8ajZ3jVJk4B4Opfj/K2XYbrI1MghnFTSqD3zqNdLMzYzDFqpYPA+5i5QSqxFcKqr4guRPgsZMirGB4nvmzP8fw6OW2mpFHi8Xw4JCCBTa6i6+pDTGkOb7As7xc9EVa5mKrzJCfjUBo9+rMOEMQmkJn1dJMsICkibB8IK85V4ZFV+NwA2az5xD0pJ6+E88GCTfgq+k5VhoUPxLRE0iSAy/dUFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8jALhmKWLAdDmZgbl3TDtovSPOMgVyf7M+x7JNasIE=;
 b=PdMEL7RSHmxUoW9baT3ggtAY+8I8te45U3/Eamv7ssMkWCaSEc07exARhH0jopxJU1JisyiD3/JRlzBf4CfM+SOMrxWWWOonbeghr6dTJNx0AOI4iaag+wYnoFJJbTEbxKq4LNgdxukte23Qr8bY+tVKuDVK5kkwmOgpjjTZNps=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4467.namprd10.prod.outlook.com
 (2603:10b6:303:90::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Mon, 7 Feb
 2022 16:51:54 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8%5]) with mapi id 15.20.4951.018; Mon, 7 Feb 2022
 16:51:54 +0000
Date:   Mon, 7 Feb 2022 19:51:17 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Sanjay R Mehta <sanju.mehta@amd.com>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: ptdma: Fix the error handling path in
 pt_core_init()
Message-ID: <20220207165117.GH1951@kadam>
References: <41a963a35173f89c874f5c44df5530dc09fea8da.1644044244.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41a963a35173f89c874f5c44df5530dc09fea8da.1644044244.git.christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0040.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::28)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60964233-7065-464a-450d-08d9ea5a2503
X-MS-TrafficTypeDiagnostic: CO1PR10MB4467:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB44674D901CDD2EBD1E5F48288E2C9@CO1PR10MB4467.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2+da5AfjTbkm31IxuFlQUTIonXsIlZfqv7XfqxOFJtF0Tc3U+sfXjgkprG8W5j9AvIm/Mk7vFNP5MrbOaSgEKwA7pTe08+9ucTzlRF5FxxHEqGm/Pv/63SqXcdE24HE8kQLAHVcYlgFvXAjfRZH395U9/+n5+7FGLQ6GnOHsdBhpgVEx+coL1IVgYE6HsV55GXZN38b87euTodEya4VVYpzWzyKN8PEl6bFjRiY74GwYQXlmCgqKQqu7AWmgC5QKVkXNLNheAeF/3ZMl4rxJpspD1qZ5nyC6MwBQEvXT9cYvwjCec8Ba96kPAfxy0m0UugvNwBP7UXdQq+3pgfmkgPKR8ff9KaGMLacQy8G+fNy+ZpeGrxUq2JYTK6Aub1c1z9rIfN3y3OsjvsL+mDGPySZZguGFZ+BQ4RWP8gUz115Q07eCcaNbJOMNAaMiPYsfCFXDTIqp2ur1rEgdixf+8DFNhXpvzFY83ncWxC+zsGohvE/y7lWbpZmg11OyxbSkQb/lPxdhvzYeaWNnuZTxRXhtMWB+Sim1ovP8a1l41L7lrUPrRXXn753iIKKpMPRZn1PYpeE1eANukUkptjHMra91LJoMVwdGOKjUpwLEm3aU1OkV74KHt97rq+j5cTCDfYkwKrKBA2fthtBa7HGLlEoID9N26pdPYo077pex9uGCS33aAh+GKcEmZzkNR1CR0Tu8aQxosqq8DwKRE4bhqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(4326008)(1076003)(186003)(5660300002)(26005)(33716001)(33656002)(83380400001)(86362001)(66946007)(66476007)(66556008)(6486002)(8676002)(9686003)(8936002)(6666004)(2906002)(6506007)(38350700002)(38100700002)(52116002)(6512007)(4744005)(44832011)(508600001)(316002)(54906003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?92fgW7zpezzUJfz50dVv0q8dJ5lCjEq3aqWaMSxfXCZO5CkIZI/6D9e8mDD7?=
 =?us-ascii?Q?/oKS5WPTOkjjbAinzmhLSMezSXmzKEVNsnoCb9jLkTJKhx0+B5i6zp6jUgXa?=
 =?us-ascii?Q?DrdDN0749qHuyVL0BVtiZCOeQfZEelelTFObxHouizvkg5wRbgEogaSoNbWk?=
 =?us-ascii?Q?1NC/XlsjSE7NVOrLvoCSin9b4I/Fpfw7hVdP/k2WYOpv/2hV+yiBGfgOCkCt?=
 =?us-ascii?Q?sbhmMpX5bIQVEWLz+GcskwvPzbV592hwzoMWw3kPA+Itx4I5uYYsdG6mnVIf?=
 =?us-ascii?Q?R26o4jT3oHSNzphjsglVB+50HZrP+fJXYdVyFeXv/StwOLTOXjuLbFZ9QjdG?=
 =?us-ascii?Q?olHAP3unhSLoNInX5HbTpzLYDfIntpVmAdt7ois0AOYyIvBvn2E2zQe9RVcX?=
 =?us-ascii?Q?p/1VHKjKL3NCXVTt0v2zXzlpl3XCMyHOwHB55v8ym8QO8oSTlLpyujHLliT1?=
 =?us-ascii?Q?ud/y2v6vtnXk9YJQh9IaeIBbLLcoxRETH+cwE3Ugteu//zMAWp86bPqKGdI0?=
 =?us-ascii?Q?CxLmYQ2qgdW7TJj7xpW042BUY/squloPQcuW/D4qgkZIkHkvqoF0YcKCoQBV?=
 =?us-ascii?Q?23C4oo4ohjXHqThqLw4DbM4t7I+I/C4D202BViT6bI2ugM630CacjtQMTyyZ?=
 =?us-ascii?Q?j/eUtF9dTlaJn1rJJIDDsGwlB9qZ3stbMw3FF4orUnjv68fl+L97Bw8nF7KR?=
 =?us-ascii?Q?Yg+SACvdhcEg6HFDoOfCHUSgBQsqlHcZofvo1W2sbto7v5Z+x43jhlrbVxzl?=
 =?us-ascii?Q?J7vgh+RV3dU8J95XfBF40aompOMqpHgmje2RaavRmicV8bAvHpYRbmyaHmak?=
 =?us-ascii?Q?tMxQQJjJrY9xCBlO7Dogkl7bI2cUOor0as2s4XBVB0vHIupuFjJVUzsRXKpG?=
 =?us-ascii?Q?M6HLp75j6uBCWf9bt6i/pwu+jpUGwr6nYn7B18NPDA2+dQIHdedcRHrrZR8D?=
 =?us-ascii?Q?9qb88BLK5bLxz6HlRwXnOyh/O7Wbl03P1GG826dcwEGzgaw5ZycVfnzR9KNr?=
 =?us-ascii?Q?qW6nKBHZRH3ZeHEcm9PEKQAjMr+u5HcPGs56Ad7COBXhoXcOFPUsYO0NBkzX?=
 =?us-ascii?Q?7We9Y71zkytzkAuSXMyk7ogdOy8izvAxlbZt4mMh6A9T3hvme+MFoVumGri1?=
 =?us-ascii?Q?EV9TjGdcIDCMNN3d3ZmwwuDDAaXl4qd0r/OgPw3IE5owBPIWACijGZ6yJOK2?=
 =?us-ascii?Q?8Fn2+6PfrVayVcAM6DFjCzev25dCf/8neRtgBAKPdEIxXL95WC4jJTYKOVT9?=
 =?us-ascii?Q?vxG2uEvY9MlzcDcCwmCqA1njXOWBn69q8lNy4JNmiMRXPg+kVTwHIROKWTsn?=
 =?us-ascii?Q?aeL1NdzFhwfRLxePoQHd8bwOcIRiktin0reAbajbtu/+U8Up5H/rxiFf+fTh?=
 =?us-ascii?Q?ZYjG5gZ/SRquLCCRQCddzufSz9t3XntxAiN6MkcsU0jpsDWiUAERodNk5kKw?=
 =?us-ascii?Q?X72JGszT5X8EgTYrivuCmQPF0d8KoKGHNfSmJYyfXxsv+bqcLuMt2OIxdpd8?=
 =?us-ascii?Q?3F7tHBWRvEvut4sEdVLBFq/QtUp3NYJF8AmpoW9eNVzoSg/UBi4QRkj2i7Os?=
 =?us-ascii?Q?EhMbzwYGvavBg6kFgChrH/qOYQpKCcZSLzHymZbG/6DFohJnlCSTfRiTDTY9?=
 =?us-ascii?Q?Ik7iN15mbldEBXvVR7Hg2mBfQ3lBsDyPL3lcCUdBqcOMtY4grbRa9DxFeD3t?=
 =?us-ascii?Q?T6Q+pw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60964233-7065-464a-450d-08d9ea5a2503
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 16:51:54.3719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OE4y7XTf8qnYCC+GbLct1ctTLraoDqTDn5TDTSeCxzgiFKlbIREoBIfvLRfV+gl5pMR8Z0LI3+/t7TAu62IaLWUBGdklGCEwxkye5eeCdX0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4467
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10251 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202070104
X-Proofpoint-GUID: HoaerdAjmfyZF1BCiZtJvG6-_o3FvM4W
X-Proofpoint-ORIG-GUID: HoaerdAjmfyZF1BCiZtJvG6-_o3FvM4W
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sat, Feb 05, 2022 at 07:58:44AM +0100, Christophe JAILLET wrote:
> In order to free resources correctly in the error handling path of
> pt_core_init(), 2 goto's have to be switched. Otherwise, some resources
> will leak and we will try to release things that have not been allocated
> yet.
> 
> Also move a dev_err() to a place where it is more meaningful.
> 
> Fixes: fa5d823b16a9 ("dmaengine: ptdma: Initial driver for the AMD PTDMA")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> v2: update label names
>     move dev_err(dev, "unable to allocate an IRQ\n");

Awesome.  Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

