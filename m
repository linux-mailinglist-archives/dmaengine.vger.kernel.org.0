Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5A3B3D3B40
	for <lists+dmaengine@lfdr.de>; Fri, 23 Jul 2021 15:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235005AbhGWMyt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 23 Jul 2021 08:54:49 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:61682 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234972AbhGWMyt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 23 Jul 2021 08:54:49 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16NDVepG018448;
        Fri, 23 Jul 2021 13:35:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=eU5+D3JMmde4K6YGJdT+HcWW+yxcfAQ1WGWSeEH83L4=;
 b=AYoKKb9QVLIZXIX/rj+a1VW9pU4mC4SorRLqlX3kK/5DKgh5S8AfcvMI5FCPI+gYbq8D
 nYvT65lw2LifOgdPIGo3EOaBgjjqwBz3Y8XxofE6VBI/Rg01E/2IPn0IMDxUvI9ZDmGJ
 pga14+915IX7k1tyPnW8ip7TFLHu8UXlr2q4j7bKUWmJEeuoz78p2z2QWXyDm9cOihGY
 YyddMqVVaXUN6nQKP1FtWZsqCM/DOoVISRgreYrguoiYMsnnIDGjOYaFlsyinUAkMV4J
 aWjK281CPLVOjwEVzSf/Egs15vSDKJJh/hUqkXRWxE0hR/AVnLu6u2KZZ9/r6kARaedJ 3g== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=eU5+D3JMmde4K6YGJdT+HcWW+yxcfAQ1WGWSeEH83L4=;
 b=iR0YYfCTmjcb0eY2RZxT94yriNMqC0IxehZb6EjWkMeLimIMgYFeJufqUqojE9JbZLFT
 ouB8u4KComyVL9/zFizO+3MzMkgw1q/8ubsx0FSG98ksByHjizjdRAMT0sUxj2zg4G0A
 5wdV+soEjEQsDD0uRaCtQFhWQaOl+rZiYJ4q/hSw8YbS2DKb2Ms5DmoeWkB7o7Y5I3tN
 JoyaSoqUV5jj+D10oKvJdvI8SP0TQR6gHEO1PTt3tck/AG6gQBUBVYTucw0fWairwZ0u
 D2iTWzftyBk3Tg0mIEU1E2n1S6nIqQzIFi6tBE0YWkYVmQrP1HmTV9PrYAJ6g+ZvrR4G RQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39ya57agpr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Jul 2021 13:35:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16NDUXfC167305;
        Fri, 23 Jul 2021 13:35:20 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2043.outbound.protection.outlook.com [104.47.73.43])
        by userp3020.oracle.com with ESMTP id 39v902r47j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Jul 2021 13:35:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eLG8twplZuLdZJ2c3vPAp9UDjANndE+P1SpnL+X/ut+EiZXpXtaQWGIfbNf8yh1OmWUsatO5owMcM7dm2gogzVfx3080Eb/p3A1m0rQKScCCZjqP4B3teAwCatfV/5kHK3jYuqCDWoi3HeOIVMqQ8R65yHNSeg44R6ShUxf24YZDH/kprmUgvb8DStM1d9IEX0eC+ZFEJmfC3F+gr4zxv1nYkZM8ZK71b1efqUi3jR2EvZR2IrKS6toPuuyAL7naduvSsuEpC6qnoZTbGH4bXysX5U5Hs3f/+dffeDIM6ZzvPzMLCtZasq0lNHD8gTI6bTJsz8rkaoXW+XyIVep7ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eU5+D3JMmde4K6YGJdT+HcWW+yxcfAQ1WGWSeEH83L4=;
 b=lyZjPL/uBxYRuwwP0g07E5LVQGQ+ZcKspWrTO5umD6QT1Gqm4naFI7yTH2IL9GJ59y9O0c2iIqNNctTvyKVQ9CDxCFN9FCBAU+gSKtKto8xKnYSfdla2Jqa1K6n4qQFEkBIG4AYklsuzMy6DcVPIaGu23zMT1jNNWPR3xx/v3WWvQBy2tvdU5cJQC1rIVr3TTXrJLBrsSA36EpoF3rUJUr2hMFGaafyFQnegB8VH+6j2KPWp7tFjxGfHeNNz0KIm7zGO/ceodZoo6PFWm56OQJLTDqa9Z8Nz8XcX73rsb6L5znqhLXifDEipRQAs8Y2wcpWRvbBf9afxxvq1moWM5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eU5+D3JMmde4K6YGJdT+HcWW+yxcfAQ1WGWSeEH83L4=;
 b=CoVAmOjlA6i52JpWMZuHSHYZDtvDNNJ9rzrx3tWtCHmUwD+hthfnM4+H1zSOOA/x3jZFYVE5Zh4HhO+5k2goohBNW7FFVdmOLrpu9AoZxKALafW1CveQ18vQtUu8HpGRtwNJ5QHJJ9dZnfYquj4C42SW+wK58XgtsUAeGDLh3Yg=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2207.namprd10.prod.outlook.com
 (2603:10b6:301:36::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26; Fri, 23 Jul
 2021 13:35:18 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4331.034; Fri, 23 Jul 2021
 13:35:18 +0000
Date:   Fri, 23 Jul 2021 16:35:08 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     dave.jiang@intel.com
Cc:     dmaengine@vger.kernel.org
Subject: [bug report] dmaengine: idxd: move dsa_drv support to compatible mode
Message-ID: <20210723133508.GA18022@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0053.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::22) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kili (102.222.70.252) by ZR0P278CA0053.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1d::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.28 via Frontend Transport; Fri, 23 Jul 2021 13:35:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ade0c605-afb0-49c2-576e-08d94ddeb626
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2207:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2207D560CECE8B7006F988F48EE59@MWHPR1001MB2207.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HTiUUM7AiwRbAy5y7+4AmHtZ5r6gT32vT2NHFReMsohWN0IBopVOlWcUVqqA0PdEToQrjc4qBz9E7M1zVNQGGB70g7Tf2Y2TKlwo8KcQKUdcHueyYcseukTR8wW9gREQnXNXm998Xp3UNx0jCmnrnlzBWNdQLC4uIrOhQyWcF4o8mVoPj+95TaJ4YRyu6096y1QTbaxYT2Htkm4jpfNBAIUJUp1Ipz5zz0tJJSgzG+w8F7Yp9Y+Q8Dqii9X9t1XowqKkY3KDLijBhskC8f2uThhIMI/0MViq+iDQXr342o28d00K7ubucBjjuHifalNWxEas2KjxWff1BFIOq//fniph49YHHqLbXx9QMIJ5zdiyDEV0wZSPqyfSW+bnkE37iin8himPlaEq5bnC7RGeaGpSRWURGup/vKNlMRwgb+EkPc2omtpRYa7oSkYsm5x+xYAxNmZDs7OzKIDJuOqDjmcIv2sS8M7AFcC14uagNthgB9kUxkjdgM9j7lznUTpTXynZ8NCxEH7+jSdRn4MofeYGcqWvx4fFoIj8FasK9B80I/q0XaZrUXcYMmM4yJPCnbrX5711Ko20klEL9Xg8g9+8dO3nZvO6O7GoWI5G0DvFWpz16UaCRlCLlRiPrcWeRRP142Z3Z+6Yz0dUk44SHzipO+I18Dj8iVe535ONqRRAj+AlTAreD3O3OBzzdzV9Y0ITGS+Bhvc4fi9LxC5MEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(346002)(396003)(376002)(136003)(52116002)(186003)(956004)(5660300002)(316002)(44832011)(55016002)(6916009)(1076003)(9686003)(66556008)(86362001)(6496006)(4326008)(8936002)(6666004)(26005)(2906002)(9576002)(38350700002)(33656002)(8676002)(83380400001)(66946007)(33716001)(66476007)(38100700002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QD8qEUZHqRI2li43QEEvDhhD6BRInIa4vMDSXQwyc8ty16Y77GRvQJL55ngZ?=
 =?us-ascii?Q?M82boEHZxKm8P+bmHx6+XKFJOLbpxUMT+7B4ncchAOVdsjSWO7V143x673eU?=
 =?us-ascii?Q?YJ3p2BI/XjAnSdooQX0k/DyX2xahLyg26zYrKdkNJRp1QvHF3SbPW2q9Tp+t?=
 =?us-ascii?Q?0on+X52mvZ1xerVGhJ7jMobmrV+y+ARTAd2ndX1SDrCKqSx5TCQ2pDbmX3tg?=
 =?us-ascii?Q?4Y35F+eUWHHytoHg682r2K1h5DfNFrs6aDyCZ7I7PBG8fMTKrUdr04iC30GU?=
 =?us-ascii?Q?9PHXWssmnqpGVOULQSYbbitrNme7KpVJN4qwvwDZHZfs7LqIN4cVisIsdKQH?=
 =?us-ascii?Q?C9CuYQ1hsOL6VJnS+7/wA97YoFHSNiydLbGawcIC2eC0c3d+olYr+l2hCFrF?=
 =?us-ascii?Q?sw6owrNRkofL2PnS4ejV686adSyl/Eemucy0StEmSwNd5wdkg1tvDjPexHKK?=
 =?us-ascii?Q?suhQvRmHCs46VrSqA/uZMHwkU7+fQmtoymj5qoDCkoKc6EIY91Fq+ReDv+ct?=
 =?us-ascii?Q?lxs+eRePC/oklfYdg9mo9fxrmbTOakvaCZLJPPckO3mDqjW4F5OjHBgQklup?=
 =?us-ascii?Q?IfnSsLwExw4syCmulTpSjxsRysGdP3ae8RyPIwo+rjhoT0nCMwor6WaUxsQ1?=
 =?us-ascii?Q?sNQXtM8ZQZvFTXgcUiBzrBccRypiUWvRUbOdpqWVkkoxRlfpRACbVjmV9xQ2?=
 =?us-ascii?Q?VL8/G87vOMYl+d5kzl3aIwA5YDUslfv+zIhkw3VBfc+EyyPkfFRbpLOwwKbd?=
 =?us-ascii?Q?vr3bsyC772No9rjA8giacyOhMIYjTKnFaLIuatEHGV3AKmwdBWebfegPD6iZ?=
 =?us-ascii?Q?nh+bk7bv9davG7eIELOEH8ZG6Hqoy56EXQz+Wy0WBiAKyIoL2gIBMDmQMdQC?=
 =?us-ascii?Q?C9PD4p4iAch2UWJtz8xLZKitLTsllTqAFslK1RrlSas0KADcldZ5135VsFgz?=
 =?us-ascii?Q?mLp+FGZhdQE3Q1Vqg2rsR0UZGL5ZW/Y8yuJIBd/6fO8l5RCkmUUHZyzNV07Q?=
 =?us-ascii?Q?ZX8Yl7ANawrPwsz24bWSc1HP47l9NzQErOS5bh8om0yzcNyrH2zF4X9buOTd?=
 =?us-ascii?Q?h3FDtjsFk4YyMQYbHyGeJaUODA0HMWCgIF+Gm0E/lfZzO3EiLl+c0SefdRa8?=
 =?us-ascii?Q?BuD7wUyvZ+767DkCMuMjG4R6khoI84KrtKwWKUVbsP7FtEQw5ZOmMRiabAE8?=
 =?us-ascii?Q?tJP+F7Zb+e1baosDLDZmiLNmHAcU8huFs28JMK5TfTtAXQwWsT3R0LFACF9j?=
 =?us-ascii?Q?RmlBMwdLVMJo9Nyq4a9JmEN78xpN8VZN09Noi4Ld80GN31Wj0HLOe3xqbf9y?=
 =?us-ascii?Q?gfNByMqJlnPC6oAw4f693QC3?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ade0c605-afb0-49c2-576e-08d94ddeb626
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2021 13:35:18.7867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zQ9vMLj5a9zfNGFOEREr5lir0Gt392tmq+5Y3WKdazuWHC+SHgtfJEo+yW+i5Wl32i/PG2KgOjW7y1o54RQSYnwozsmRSwG4QN6df5JMFYE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2207
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10053 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 malwarescore=0
 adultscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107230081
X-Proofpoint-GUID: mgD-alfvEC9wv3Ep7BKMTwJSTG6dfM-v
X-Proofpoint-ORIG-GUID: mgD-alfvEC9wv3Ep7BKMTwJSTG6dfM-v
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello Dave Jiang,

The patch 6e7f3ee97bbe: "dmaengine: idxd: move dsa_drv support to
compatible mode" from Jul 15, 2021, leads to the following static
checker warning:

	drivers/dma/idxd/compat.c:66 bind_store()
	error: uninitialized symbol 'alt_drv'.

drivers/dma/idxd/compat.c
    33  static ssize_t bind_store(struct device_driver *drv, const char *buf, size_t count)
    34  {
    35          struct bus_type *bus = drv->bus;
    36          struct device *dev;
    37          struct device_driver *alt_drv;
    38          int rc = -ENODEV;
    39          struct idxd_dev *idxd_dev;
    40  
    41          dev = bus_find_device_by_name(bus, NULL, buf);
    42          if (!dev || dev->driver || drv != &dsa_drv.drv)
    43                  return -ENODEV;
    44  
    45          idxd_dev = confdev_to_idxd_dev(dev);
    46          if (is_idxd_dev(idxd_dev)) {
    47                  alt_drv = driver_find("idxd", bus);
    48                  if (!alt_drv)
    49                          return -ENODEV;
    50          } else if (is_idxd_wq_dev(idxd_dev)) {
                           ^^^^^^^^^^^^^^^^^^^^^^^^
Presumably this condition is always true but the static checker is not
smart enough to figure it out.

    51                  struct idxd_wq *wq = confdev_to_wq(dev);
    52  
    53                  if (is_idxd_wq_kernel(wq)) {
    54                          alt_drv = driver_find("dmaengine", bus);
    55                          if (!alt_drv)
    56                                  return -ENODEV;
    57                  } else if (is_idxd_wq_user(wq)) {
    58                          alt_drv = driver_find("user", bus);
    59                          if (!alt_drv)
    60                                  return -ENODEV;
    61                  } else {
    62                          return -ENODEV;
    63                  }
    64          }
    65  
    66          rc = device_driver_attach(alt_drv, dev);
    67          if (rc < 0)
    68                  return rc;
    69  
    70          return count;
    71  }

regards,
dan carpenter
