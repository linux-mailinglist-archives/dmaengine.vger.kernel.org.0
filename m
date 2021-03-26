Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3235734B334
	for <lists+dmaengine@lfdr.de>; Sat, 27 Mar 2021 00:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbhCZXzj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 26 Mar 2021 19:55:39 -0400
Received: from mail-dm6nam12on2061.outbound.protection.outlook.com ([40.107.243.61]:20192
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230134AbhCZXzh (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 26 Mar 2021 19:55:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VGHI4FELcFJvtZQD2W7Fcz7s4Zzvl6HV25T7gczLDByg6jf05s7mgVPLEMB8YSsN35aFJDDjuxhiO/Kbc6WknP76G374XeeZRy7z2yL6VT2wueVSoZmWSrY9TY2up3FuYfIkAHD/ZsVrR7Ru80Sr0pOFC9DaVkeOLVoSapHQsZriMbvjPK9feHDP+QwxoglmxZxcE+H8+LYBYUmwh88vpeTKdJqUOhrwyiC4U2ZV5707T29HK3+Reavz+rV7YcSbc4dFBUj8uOfvseN1aevir76isbMnQVcLBhXlEXNYwWcyTx2j1I6o5WZpm5ZQBBKeCbsMDXSTjz47yxnYn92VHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=srPu4Dn6LkMSPjXMp/g+51T8cpAbdDOY6w/86VgVB+c=;
 b=UKHsSLQYw49FqT9FQvrg+msmWMW10bxdTbHlbvoYlBMgqiIR2ywqPfz6gSBvbctelFSkqwPZn7f55mHKFkNFvhtmntyiyA3zoArt7aVYFB39p2qEFv5qS5PayOZvqxsAwkLy9ouzqDYW2CxJIJOAVUlPV356S/1sn2Q2J7lp3JTOuQvxQ9SnHw9Ny6/qlQ2foxm07r++so+WmE3+U+lNjtE++BAVdM4ZznnmJAzMCCLcQgr+9nutUW97Kw9eNwV7GNNpWkqVZ7MIaZmmqv2+mZMbXkYGG/WWiC1IFhdQiu1MfZfqoYWedh2MQeSwn+YsIw6nxghyVszGG/WQxoes0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=srPu4Dn6LkMSPjXMp/g+51T8cpAbdDOY6w/86VgVB+c=;
 b=slTWdNDYPzjLP4tS9envhtqHToRiO4/EsiNedbiui+r+PZ8bNLaZZ6ev2koh5unGsSGM60cOcv869u22cGspr2GCGir3s7FiB68jWEgQL9AGhxhT7365wd17SdLWFg03r8zLy3wZV6m5cysFyx77MVil5Iy1Kp3TCWKjW88+PgY8xdgmUZpqGEQlLAcO1JTMlbFBVRecjPuEuxqLn9A882Hf0TTF4Od64VLG0KajLTFYbdhnkwy1pnoRGpw1k3hXuliv9UY+4qdtZ1yYJmCMv9U+67ffCDpnsrZ3YajSMCxDKPEZ7oeGQhKT2Lbyrvs4FzcRRCPcJeYClPBZuP+O8A==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3209.namprd12.prod.outlook.com (2603:10b6:5:184::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Fri, 26 Mar
 2021 23:55:36 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3977.029; Fri, 26 Mar 2021
 23:55:36 +0000
Date:   Fri, 26 Mar 2021 20:55:32 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Subject: Re: [PATCH v5] dmaengine: idxd: Do not use devm for 'struct device'
 object allocation
Message-ID: <20210326235532.GV2356281@nvidia.com>
References: <20210304180308.GH4247@nvidia.com>
 <CAPcyv4ibhLP=sGf3iNwoE8Qtr_5nXqcRr7NTsx648bPFWaJjrg@mail.gmail.com>
 <20210324115645.GS2356281@nvidia.com>
 <CAPcyv4jUJa9V1TrcVsEjf3NR6p10x8=0jZ1iCATLNiJ9Tz_YWA@mail.gmail.com>
 <20210324165246.GK2356281@nvidia.com>
 <CAPcyv4g2Odzusx621vatPbA041NXMmc1JK_3oSNM-EOPwDaxqA@mail.gmail.com>
 <20210324195757.GR1667@kadam>
 <CAPcyv4geTG8M2mxJNxN0wxZsQsLbN0U-mr1jjC=3sjyRWOuwmA@mail.gmail.com>
 <20210325164809.GB2356281@nvidia.com>
 <CAPcyv4gwqkzOHQ-xJ2At0Rc2k_S1X43XB607k8f-Djf7T-O3eQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4gwqkzOHQ-xJ2At0Rc2k_S1X43XB607k8f-Djf7T-O3eQ@mail.gmail.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR02CA0016.namprd02.prod.outlook.com
 (2603:10b6:208:fc::29) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR02CA0016.namprd02.prod.outlook.com (2603:10b6:208:fc::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend Transport; Fri, 26 Mar 2021 23:55:35 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lPwIe-0043sH-Vh; Fri, 26 Mar 2021 20:55:32 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bfb37490-4113-4fea-42b4-08d8f0b2a654
X-MS-TrafficTypeDiagnostic: DM6PR12MB3209:
X-Microsoft-Antispam-PRVS: <DM6PR12MB320972EF07B6CF22EAA18CBEC2619@DM6PR12MB3209.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3PY9Wyzv3CzNr3MD4pXi1A8hpZwAO25FtktXpHLkml6Gi7oZAPPvxmrPI0aBVUDf1evVGSftj65/UhAtVA4aLVuE3Iq/18alYNLqdvgmse+2C3/C6VqD0thbMmgEimNXrjdGsvkVJCSqMy5VyoWjzXqAMjgzOF/jWdWZohxoZpaXvJjGYpt3yS5yDcmvGPQ2un4qo59KmG5+9/aaR26dafwf7n4yFZDkhwqIVfJKC3FDd2Zz41xw4+CBnuS4AK93wZ26d+Qwr8/FeUVUcpu1wD2VuZn0Qa7dVzj1JJHEEKcf5APr+fAA0eiahG+DZ9wnBWuaAWq2Gq/BVaF9O31ceXgNuTy8Dr6IdMlcjTgmzZtF9zK1ZtK6CXvzKbFjM3fxNCER4ErZoGUpPaNMmGO/Ayp7HqudkVXUNTiKBrzg9HDtskPUfvARVFPvrojtasJvnHeRPayqTdUKO9S+pXC03VXW+Y74+Kj2sfAep5W6S4SV3j4A6ztrRqgmdROGc/d2X8AF6waWY9w7NWL+UnZOr7g2rpsf6eNz0Azmma4DsE+Iwn1uj4BT09MoBdXcq/rb3K+gr1C7eDzDWg0KyqpQKBvYhApLFRyI+LiJL8tb5iEBpESslniay13vOeXyViaKEN+WSLrrctL0RxMu8O2vjU0blRtN4VVb6bnFsmGDuEc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(366004)(346002)(136003)(36756003)(54906003)(1076003)(8936002)(6916009)(5660300002)(8676002)(478600001)(9746002)(9786002)(4744005)(4326008)(316002)(426003)(26005)(66476007)(86362001)(33656002)(2906002)(2616005)(38100700001)(186003)(66946007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?yy/Kdi3HflLAZHyoe9yStCM8p4k5MT5/P1C5O69/wZ9CO3ujcaUQ1Darb6O5?=
 =?us-ascii?Q?CX7z7pa0UOy2QA5MQM7JfAaiQIKgeTnenKPCMfjlYhRCn3L0D82y5Rt20H7h?=
 =?us-ascii?Q?1WaWxcmGsU+Wtug7jyIceSksKaPXacDXXjY2zE86bQ7r2wInWeHTO34gQ3BQ?=
 =?us-ascii?Q?J4FNd5ZpNWYzoXiBjnMQn5ao0oB16e2SDYX2oF2nxMJl/zkuSa165xfGAuvW?=
 =?us-ascii?Q?Vn9yqbRnsaO0WDV+ZILpCiStO9lOn0nul7y33uHDPTnOPg4mL1x85axasXe8?=
 =?us-ascii?Q?0CoX7SEFupb/y1AXxQOwh5nDy9YV5VfavF5I7T5r1KInV1hMQVATKQX39FMo?=
 =?us-ascii?Q?8PsMm/veKQacSeF2tPfwtGNRrpf87YLlT7oFviZ841FxVFjz9Jb3sGVVg1rQ?=
 =?us-ascii?Q?NyADtbVgqc+41vHj7+CL/OzdboFDc059sCwNGzRHtJnxk4vPODorb+MmgtTx?=
 =?us-ascii?Q?aeEKnuRFFWlKtFSsiDzCP6lGFMKm82bqUEx7W4vNj2sXla+hkxKp4QYsHLM3?=
 =?us-ascii?Q?QJwXqzaZA4pfTOmxTbYM9QNLykJiRQB8P5Fvea6K7i7rbcgU6QdrwwFa3Qoh?=
 =?us-ascii?Q?K36wZAPPYlPJkJiNyGJ260eJ4+lHr8neiF55Sn1/K57hI+jQ5j7FPhY1gcBZ?=
 =?us-ascii?Q?HYpCG54eth87C5Kj1LbKGsD12zVETrlkiyQKugs/aInJfLokEvYU8dH43chI?=
 =?us-ascii?Q?1e/ajAiAJkxQI3Or9seYhXztP2ZvmLiSOPLXyXiOdTM7IwzlT6W7jGg+oopF?=
 =?us-ascii?Q?2UG+HGXDcsPkIk3nJneOiKv5+IOqSsiBftFxlwRcr+B+GxgeDlEPE14nyE47?=
 =?us-ascii?Q?rEkL3f0wGn9LTytIh0rAt+2Ylio50DMlneM2+oCsL9K9Mn+H0Er3XG9EVMIS?=
 =?us-ascii?Q?nLujH+cN9ePmrG0/VH4zWpl53UCwZLrmj/46UwRiLUOtDdMymBLky7xyrWed?=
 =?us-ascii?Q?dYZVYoHEoXwsFeEOHtLt6UbRrCNYUPlCP2r5Xpkjwxab4A7qEZdmgweFmx5A?=
 =?us-ascii?Q?IDa2BviAHCLyBM4nS95RpEsIae9s/d3Snz3LoBU/hEho5WFZvJaa08cL7PUs?=
 =?us-ascii?Q?Tgt+0O93IdHYCPYRA2Ehx55xdOuDXCZVKp787WZrnQ91XS+7R4Bf6Xhkfaaa?=
 =?us-ascii?Q?J7D/awnW5fJMSfLZ4c5KEMwVyKV/vB7XcFpgsiNZH/T+KYkyitsQMEgNdDBZ?=
 =?us-ascii?Q?/lP8qbPE1nO/1b1F98s7E4DuNr1HBbOSNg9SEtTKz1KA/g1mBUJubZ3WYtR6?=
 =?us-ascii?Q?i0x2W5sikFo/m1zWdngLBmjPUyH0/0WeEXfbqNtprr6cxpJSrpGK7O8Wka2A?=
 =?us-ascii?Q?wm/3QyJKAGr2GuXmBHZJrDh3vzUnJQcA2eu13zxdtyn5Lw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfb37490-4113-4fea-42b4-08d8f0b2a654
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 23:55:36.0858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UDKPsFkq8d/9hTPeT/Z1FgbkkE0yxMQC77nz/fWnGRdXdwsPKFlhtvMQxQGuT4XH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3209
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Mar 25, 2021 at 11:02:46AM -0700, Dan Williams wrote:

> ...but aux-bus may need to contend with namespace collisions across
> users, so that's why the modname prefix is forced in device names.
> Also how would aux-drivers differentiate what they attach to with a
> single bus provided name?

Oh right, because the name comes from the bus, makes sense

Jason
