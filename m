Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB755332D8
	for <lists+dmaengine@lfdr.de>; Tue, 24 May 2022 23:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241833AbiEXVKb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 May 2022 17:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbiEXVK2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 24 May 2022 17:10:28 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF203ED1B;
        Tue, 24 May 2022 14:10:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e8X7lFSVDH2Ovk6l3UfcL4aeQSrhHC0t8s4lF85R3k92ywqP1sqLxeOUMOcFaWx7Tfql9roExFE+aaSF+nBjXjhN7b95QUtlKYa3UJ42p5o8azd9pV6tCA/vWe3hyrSGbZYrcJSTtP2i/vn99N0c6/xoLQg5JyCQzGup6+1axAnz46UTK3ZK5lpqwzSlqi9Zd/1oHyrlSQZynwAoJ0ywWE0ib9UxjYZg2yoQ0YU80fa+T8wki7ZO0ZVyOmRbj8CtAKO0hzqk7zcINoI84gERlIzJzZEEXCCRSVvbPXTQrmHAq/egtJr5V6W9SxeEGI6SYu+LX9OSHWmPxtWqAl7F9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uoND3vR1tlx2CwWTWHHuWIeR9mvgpYy8RMmF01/18dw=;
 b=CLLOL2wP02N/BsMeW96DNJyZs3iHgTJz6jKZ69K8tq9kivs8rs7RJ8FKZy10o5u0L9nBVqdkbUWeqae6quuPe1uDPiC85rPB93Fw7NLHTQOr9dU5eg3v+XGxiZTuG0ZBqK3CglZSH5hMgO20XYsp69IPfvnEn8fd957KSdoKtIP9buoSkm+qr6XIQgijYiNuK1ED98WpLsOxSs2MzFUrLB6/kbLz503vempqeeiTir2n4XbAe35cv0ESZxNBarAONdf518XGIG3rNmeIBKw/qeYvfS/O7ZAH8UjMqhMedVsEYCUsU/Vy8TM4c2bEax/TCJqwFZ8cGOhbCvUEiXhmAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uoND3vR1tlx2CwWTWHHuWIeR9mvgpYy8RMmF01/18dw=;
 b=TUqUZ2La0etA4WaCZsbWw74UCEZHTCje8LslumL7Q32gNoKuq2jb1G/WnFonnIcinnbzZCmVmRBRRIOYtdJKUS74qkPBZYrRAEaWc8s1eSzjlOSMIB5TgOxNP3SENGl3QQzU6MlCLLJsrb75+Hnbb9jgBWFvTmsTQfH1/PXA5Qzr2mRV5gQ9UEP+ad4x14Q2mIvPWPPdQDRc9kJgT7wMX3kbufPuH7miwgkFnwLJf84y/uODGEKCBtRXN7Fd7jfUACmI82VnNE34rMl3TKvAuCIdEHOY4/P9iWdqBtko+qfSSRWGeOGHTbt8OODsMOg9vprAX+KEZ9V53vCVVf4toA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM4PR12MB6160.namprd12.prod.outlook.com (2603:10b6:8:a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.22; Tue, 24 May
 2022 21:10:26 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5%7]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 21:10:25 +0000
Date:   Tue, 24 May 2022 18:10:24 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>, dmaengine@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Christoph Hellwig <hch@infradead.org>, vkoul@kernel.org,
        robin.murphy@arm.com, will@kernel.org, Yi Liu <yi.l.liu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v4 3/6] iommu/vt-d: Implement domain ops for
 attach_dev_pasid
Message-ID: <20220524211024.GC1343366@nvidia.com>
References: <20220518182120.1136715-1-jacob.jun.pan@linux.intel.com>
 <20220518182120.1136715-4-jacob.jun.pan@linux.intel.com>
 <20220524135135.GV1343366@nvidia.com>
 <20220524091235.6dddfab4@jacob-builder>
 <20220524180241.GY1343366@nvidia.com>
 <20220524134526.409519ac@jacob-builder>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524134526.409519ac@jacob-builder>
X-ClientProxiedBy: BL0PR02CA0125.namprd02.prod.outlook.com
 (2603:10b6:208:35::30) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f8d0641-3a07-4e84-a5cb-08da3dc9d283
X-MS-TrafficTypeDiagnostic: DM4PR12MB6160:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB61606417AC340CCE17F19529C2D79@DM4PR12MB6160.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1ap+tRr2Uu3l7ADFPsRN+RcDF5xvozgCx6S53uWCIZakzy/jrZE5yicHuTVJPtfjOwht0q7QkR7QAJ/UAzekE/XoQh6HHymJj6ekrlOUozKQ/NXpYT2+kmqIbDa/gFvCl027exL07z+kktXgiNzSt1tvg3hnTYkDeroScUSE1w/RulyQPnC2wu0QWpQjmzdseZuQmtivf6iskyOqM/j/8XqKoVqstIpAEpkFq4cYT1EBTa8Qp86N5aspXDDDNjWWK5pT1BLXv5SWbFZdlueO7YX7pvfuRYnX3rP0cj98z740EMO5akC1bo7nAXyWI+YEEaHfj+mDXvOsIV2hx4khYUgyDQbeBZ3ydAS8l3J0iGUdMQHAcFUeCfA6dB4X8qWzCC37jNnVXwIbZj6BGZ+p0JjoK7M84VUFWDHPwvzoasFVLOwBb++WL2hvs2e/60PBfF+AKXD7fGnyqCbDF1RxGi7ZJWQyG1hTJd1zT5/gOO1KTxFwGm1wFR1ctBe0E9puOzaLrZiQMDsVn4EZJV9arahpdNl4kjHjB4B4+T/sYcBJbuXTfGvLBIEST/TNQAxaIRgAuuXGnF9DQd+Zk70DiDkoQH3BJzFDVFLdbfSnMjD21+KoD6sf0GtglM0jEMmIPEurwVlSYecbP5xsCMCNYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(36756003)(6506007)(4326008)(6486002)(5660300002)(8936002)(2906002)(33656002)(2616005)(66946007)(186003)(8676002)(66556008)(38100700002)(1076003)(86362001)(6512007)(26005)(6916009)(54906003)(66476007)(316002)(4744005)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Zx26vZXawVyb8s/ajm9gjsPBn7cDxG9+CH7FAjQZ0EgIy2rL8INyTeSnsCVT?=
 =?us-ascii?Q?SRoyUcQ4sl2e5kAR5RFo7uKD46v4M4ttXXq9LSoJxNL8XmCEvEpotMNRsCS7?=
 =?us-ascii?Q?ZxZKjdfYxAZ5wG6Mo5rfADaNknnUlQHXbhN6ODQ4teVcUrJTiLFopd3Odo/S?=
 =?us-ascii?Q?xrujivH4Kyg9Zlnj++H8I79EBaEHwJChUiBitpUIXynM7Ue+J2Q0j5fgSpLb?=
 =?us-ascii?Q?GtrY1oLLHjqcZArF1VMH3RU4SVrBGVhueVQRP5IoB8Cd/5ccKcGqoZcVb+g4?=
 =?us-ascii?Q?wtVWJP4yfYnBNu92Zhnut85h1klpzgrLB9GFqoOU/FRSwleJ0QMaebRohY1j?=
 =?us-ascii?Q?ISq9ZWc86WAf/eF5ih18WgPuwZH2Ba1nCseQKeeP/J3xEGPNpleBLWRmg9mN?=
 =?us-ascii?Q?4suuJz0Qudp2r5r6sMj9UeO8eHMALKgaZ/Mkxh/9EgUORpoQ/8h/K1KPRvwo?=
 =?us-ascii?Q?rCv7O9GIy9yISaJRop5YNdmwCzLfvY1AdqyGxmtQ+vWxT8HtyFGmDiRmzFbc?=
 =?us-ascii?Q?U0q2XDbuNrKtttfXqaJdOmtnKrCC+plwBAABSCvEqOm9ipEg9FSPAAHvTICq?=
 =?us-ascii?Q?tFpMdZthmFx9BP0m8KPg9dOhOfAVP2sNznkENB28j0p7/SaUtWi4J6KPQBQt?=
 =?us-ascii?Q?CGtcSc53v+Cpl0AQFDm6MyTxb3fWJQMVpAkECm4xCPE5hQGITpTHNzJDbA4o?=
 =?us-ascii?Q?Qli7SU+T89VH7tmhuCuivQuNbC3x+sbKUG4ZMh8fffGUoNs+DihkrYY9S1e0?=
 =?us-ascii?Q?h18xJnk9GJuJoUhRWb3dz6zUWmFAqzf3tq2ACvaF2sBkHc8hDLGX3B7dXJfQ?=
 =?us-ascii?Q?gyywIHbiJiZ3rMPLwGfZdPRW5eMAF+3+/6Aq9LLgyBjWYfaLidfiQUc/2GqQ?=
 =?us-ascii?Q?nzgurFRpqV1L2/Bk8J8Rhvi67JRMkiWOOaG6W2K7xWIoB+LudJPqjiwg1VgZ?=
 =?us-ascii?Q?Zc32DLPkUpB4wjw48uzrtH8q2cXJ67xNQw3NPunMBLxDvldSWHXw91OVyab2?=
 =?us-ascii?Q?VCMj6HXvm3tvOOVr0aZcMyhkO0K6cIa6N0x49K5VNyl6v+Td5t1h6k3qpyGn?=
 =?us-ascii?Q?tOrEer8GH3CRLS/zktSwg6t61Fp6Phil/C+VDNEehHO6wwe2nJrULdjtz5sO?=
 =?us-ascii?Q?Znuk9O/KFimrLBIZ4XUrAWU5KFIzxMmNCScd7K/BNC47+pDefEqr9j2/IZr5?=
 =?us-ascii?Q?1TBIr/t58zE8xTVCV1g0qhwiuZSneUPraAJ8AML57m+XT2Qe2fol8lRZXmpS?=
 =?us-ascii?Q?r1Xl+PTmxAXNIHckQYXqhKEtM2rzULt6mppv5xiX8KP3oAR/HXywlykRJlp+?=
 =?us-ascii?Q?FzVlZtRhwBdGP78kme9KvQkQYoap0XlJWgC8CBwI/jOy1HNmqfnQp7LmxK5E?=
 =?us-ascii?Q?oQnDL0bChYaKut0ISRjRxZzb4KowflS2fwAj67Hlod4NWwZkf+UYEhkgSARX?=
 =?us-ascii?Q?8TzzcG7uLew4CPNmzQwBAKlPKE4x1sbAHeg0Wh6/YQjNuSreFMWbGaE4KXO+?=
 =?us-ascii?Q?0r+Nqup3LRnF3t5nxptyrBI3CukHytdvPgEJBLCyVKT0cVMV1S1iIzKhtDdK?=
 =?us-ascii?Q?EhrxULzssB/GMYsD681aPqXyjKjR/ODBaYlfKSgEguaAu4fOF92LKSMs2Zum?=
 =?us-ascii?Q?tb+xIs2+jVKNgYw5lHliLOKKW7Bo2bNWLaCxGBpc9RJTBPCExaH3enxqFMRj?=
 =?us-ascii?Q?CM3teMfivt9dh/k/OreLCA+6m3SQL3NO0RAR71Z52rD4HdcKmZKvnEbJbVSz?=
 =?us-ascii?Q?IYHKxd8nsw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f8d0641-3a07-4e84-a5cb-08da3dc9d283
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 21:10:25.7317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +iIsfLbgRcMqZ+cQ8aqCh59P8V0eAQ3xJr1GaGTWl//PgmPRikn2j/9ZDNbzNhbu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6160
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, May 24, 2022 at 01:45:26PM -0700, Jacob Pan wrote:

> > The idea that there is only one PASID per domain per device is not
> > right.
> > 
> Got you, I was under the impression that there is no use case yet for
> multiple PASIDs per device-domain based on our early discussion.

The key word there is "in-kernel" and "DMA API" - iommufd userspace
will do whatever it likes.

I wish you guys would organize your work so adding generic PASID
support to IOMMU was its own series with its own purpose so everything
stops becoming confused with SVA and DMA API ideas that are not
general.

Jason
