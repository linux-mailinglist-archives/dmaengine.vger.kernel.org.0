Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D636ACD85
	for <lists+dmaengine@lfdr.de>; Mon,  6 Mar 2023 20:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjCFTFd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Mar 2023 14:05:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjCFTFc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Mar 2023 14:05:32 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2050.outbound.protection.outlook.com [40.107.101.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE12F1BEF;
        Mon,  6 Mar 2023 11:05:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oN9LCewpPzgHttI/AHWYdYGdVA/kKR6+VKYSo/MJm9YIONqqy7XHnBw642Zb3+VLCj+ftAN1GeUjfIGWC623jN6jFpX/EU/cMUP39zMPjvSu3s5VURXhRwZhvhjZlT/7sPuz7h9eYQCYBEmhRzzFtj7bulr70N6rvPp9Y1Vn4TxadpcV0PBExwGPbC2NxXRXhXGbMvATjSi2/5kJfJPQPeDM0DDosob0fYPlTLuVbS3jfPraUb4fL7SX07AFMMEkHern1uk4NJ2JdoYNd+ctNobe/maxHRxUvDSFOqlSn6fvJwOC8zz21KidLNxEEUoQuBCI64EinWNPQu6QhMWk3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DFHxZfYpZyyFea7x4zHHDa5KO7avl734oXubn9wOL9Q=;
 b=DIS2BDM6L/fasVo0JKXN5g7n2oLpg64KvuIN/k33vQch9nIze/1I/6+FCKX6l5SQ1HsH7whwa9WrnpEgKWSD0w/K+ekeikvf6pWwt1CFm/DjMEA9pYAoHd/BbSkFA1NIRgBPPujxqG8Ym43XM32Rup7Yvq9ZslV0UKJVS0PSyHkhMkYVLlY6XIbhL/d9H0K3ToaQ9U/Hf5fAYwBf21ftgi7I7V+y5dhjQGZMJkBK3xFaVTrFynWrEBXTpBj4ehphwgRlyfSirCeiHuLeGnQR0VN6SUj38IgxDAGn4mxDfEwh86HHwCDLDaOyQIfawEA5L+K2p4EMCyB5MmvJPfxEsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFHxZfYpZyyFea7x4zHHDa5KO7avl734oXubn9wOL9Q=;
 b=ZhpmQsZ1dP8RftTdgdZhIW4gb7FPW1j+a9HeKDuMJr0VKy4ZH4xhKG1/IUUy99xbG3M2VlukV2f89Ub1baTVTxOQaK1vxkskhZ2RTel786Qn+L4pkSEbA80IVs7EnLIcyEQbfIcw70QstffE6xbcW4CerayDVWzc8NAmLWksa+iXUuM5j1sKM4ORlOHEym2Dza43wacZh37AHTdx6J2G2LEjCKbpFqlpc9FFLTQmQPI0vMdJ6ltoYWL7iybeIMuIZF83c7SwliOcJAVGLYXvplzPDBJKoqrGHMUpri/hKmcDRQUJlP3fEE2zKkBWgttHd25YEMohn0zIJEBS0SrHwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6115.namprd12.prod.outlook.com (2603:10b6:208:3e9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 19:05:29 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6156.027; Mon, 6 Mar 2023
 19:05:29 +0000
Date:   Mon, 6 Mar 2023 15:05:27 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>
Subject: Re: [PATCH 3/4] iommu/sva: Support reservation of global PASIDs
Message-ID: <ZAY5d2MSXjWRGF0n@nvidia.com>
References: <20230302005959.2695267-1-jacob.jun.pan@linux.intel.com>
 <20230302005959.2695267-4-jacob.jun.pan@linux.intel.com>
 <BN9PR11MB52765C5E0DC0759880C08E258CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20230303134753.660d0755@jacob-builder>
 <ZAXkLN39VUSl+t65@nvidia.com>
 <20230306094408.2d675d5b@jacob-builder>
 <ZAYmS4Sx6bm+ziDY@nvidia.com>
 <20230306095759.1dd65cca@jacob-builder>
 <ZAYunPcgSOGFK8Qi@nvidia.com>
 <SJ1PR11MB6083DFA2C1D00B00C3918982FCB69@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083DFA2C1D00B00C3918982FCB69@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-ClientProxiedBy: YT4PR01CA0241.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::11) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6115:EE_
X-MS-Office365-Filtering-Correlation-Id: 50058e8c-75a3-4a35-679f-08db1e75c031
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5p4q97dSADPxXrWNoOhKSHEh6YvIFMnAT8ZqWAtD8m2vrzwWLgK4FARyfYDdD6JWhvAJRVmK5B5aWX6AQJeSCeBrlGRpfESknLcjriCzDkYpbTUdUlwGkpeLRnQWuagUCeQT77jc/egbkjQY6tEzNjN8z35TaTHevgixbpRFMSr7AyGEz9G/673torRAX4sdwGgjFLOZ/cGHNn2cvnl0kaHe1mfO9PNkCNkVmh+z/nAg+Iag/+aczkdMCUSGk6mmPkh+oGdEwa1WMismwZaqoPUS32Uy1PhunGBfFg9ENoTU2JE8NsBVtCMbkz9gQiMe6b7+FNzoT0NIsgmGhTG8Vn9TFRFNWd8T88Nr0bwmMDBSdoow1mNgR/UdTfhpzE+yhRVA7fFd8XRAotbizB2d9NKWkRUmFujQlCAYdKQ1oG29t5/TuY5sLTXhb8tqOWHgJTiPZMdS/f+EB1xvld8xHd4HNDfr3D5LT3m54DZLBFqdfd0RycHSwf8czt+xj9RjIOk+IQjZ84HKqHRV8kYppHDYBbtF5ysuucbw4PuxsZU765AoYYsF0+tX6wQOAgOQvf6K5ZB4M24qZnIu8qujJqlqfcbqudFk/sOuS74Y4cxMlPaQ3czfapAPHMsAU07j3kE8WAfRF/T5jPQzuYI8JA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(451199018)(8936002)(7416002)(5660300002)(41300700001)(4326008)(6916009)(8676002)(66946007)(66476007)(66556008)(2906002)(316002)(6506007)(54906003)(26005)(478600001)(6512007)(6486002)(186003)(86362001)(2616005)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?unyVmjb5+ONogE9RjVx5GQFDGMvPfebfunhxkuCIumJopfOhH/ts/tsv6q4H?=
 =?us-ascii?Q?WrjukCYiJMJQi7bvDcteyveGZDzjvCUC9QtOiPyUSOvUiI3nhMX1cPvS9IGs?=
 =?us-ascii?Q?jEgg7qMW+fEzz7mxzdm7UlJg9RS/6HEtazSsWvXuHi2KSM+pRoMemeMRTDWP?=
 =?us-ascii?Q?jlQzih03ofRxIN5D4Szh9LU57FyL5iqI0dp2PAaw5zM1YhtfmkdvJtYVr4UI?=
 =?us-ascii?Q?kE3u0j8F5egKdFFipjaWX4GfKz7BRFoHn+jTuOXGs4YaU7LOpAEWqbYdQoSX?=
 =?us-ascii?Q?kWa6OAmjo8SnxOvLxXyjfDJZo2VfeoxW8gSL4GZ4GpS6ZH+Ryd9Apl2xiOyv?=
 =?us-ascii?Q?VIRU40vMB+u2wKaMCSCfqX9j38+LEGyjwcxyPOBNY6sZpEy4TGKPZh8yWA+H?=
 =?us-ascii?Q?uMExfyTqMaznzklKWwSX+LH0v926BQMoRNaTeuyTqlzMkAIsDNChmHESF7qu?=
 =?us-ascii?Q?K/5c+DolgfIu2vInooZwdnQSpMvclTFBqet7asuC6T6IWglc07uoXbr5A2yj?=
 =?us-ascii?Q?U/ggvL9UOucgINd0eB+Ra7SEDRiE6PfvXhD/ZH169DfBG71AO/eQJWv7CmDO?=
 =?us-ascii?Q?MaDrX8bjgSWF6iaUX430mwoD+6RovGnFJd3+4PIqxbzDRGfy31GYk4jQOP5d?=
 =?us-ascii?Q?KCuTg1lnxjW3zZU+YcZmgwdYGur08C0v8cdHBl42yBNL+ktQ3NpOpMK4Dfsv?=
 =?us-ascii?Q?gmYu0O3wUwHruKGYKxW/85rrqlFDgW5+TuSjklXKl/4QWk8JH3el7TkcnAlV?=
 =?us-ascii?Q?Cvp5Qn7JJ4pr5q0P89sbjY+h3JT7FOm1NjDYFtzZPD/18Yh7pJDx+co20wXl?=
 =?us-ascii?Q?Le7989uGhXsV8I/t8G6PHlobKNFqcLmKeFQrEYxGwDHnMAzfM2kDZ4BsDWF5?=
 =?us-ascii?Q?sFCjRK+XKP4O7q7yiuROnFJuHkWuacKQSK+k5FSpY4fwja+tYyCIUgzGVhQi?=
 =?us-ascii?Q?F/ylTvRn431Ycjf1gvmEqF+oIot7L5NbTKkHCZiUSmi11f4f+kC1FaXIhGj8?=
 =?us-ascii?Q?PQHBYu1UPKrPTe3Z3KbcUkjwF4YNcvouDa6MW5bx+IYyGBApUoBH+qKJ+T4N?=
 =?us-ascii?Q?IRbjj/jeId83jsyPRNwpBcysMD8uaH0KFDDeWJZLXGY+pqGd+E2yFVLQG2If?=
 =?us-ascii?Q?tm2+Owm/C0l3qmMbmvEAGz86OV0CZgYXIBMQWhmE8BlxENLA7z45g8D5VDFN?=
 =?us-ascii?Q?xUfx5po/r2aEZsB07a9vY9l3lxdG8SIHXjDQSDiU+UoFL+AxibSSDGHiPDGg?=
 =?us-ascii?Q?AVOtPG8oA5sH6gtKX2NsSLZO0Wd/c0EHrKbNFYMPqejRzCi1wddKRvLGQsr0?=
 =?us-ascii?Q?u9Rgaw/XhNgqshVDNbhcqy35MoJd8Hz5OjkCVXcFjcRkhHE+FF2l+1Wd6I2S?=
 =?us-ascii?Q?RljgouYxCFf2oxNCPZz2wE4iTQDHks8OzDCFfdfRHxnXPw5RchdDKQgHV6Ny?=
 =?us-ascii?Q?3LfnvravSvOMec1J5whh+3TqC7LhWsNZ6BAjrEAgbo/0fc9A5/4M7FaTjch0?=
 =?us-ascii?Q?FYlQa4wqJBXvSRC+UP3qBXGYPWn6XVuB1WFDNFQTnjucgI3pI9Bgq6QATr6K?=
 =?us-ascii?Q?RY5r5R8SM4i3XLRvgHoWp3m0yo8jmql8MEk4FTAo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50058e8c-75a3-4a35-679f-08db1e75c031
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 19:05:28.9870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QTjgBEC/mSpJ4bj7WH4n+crEmVpHHymULwXk+jhCD2950ZtAGp/4+zg5IgLtG8cl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6115
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Mar 06, 2023 at 06:48:43PM +0000, Luck, Tony wrote:
> >> ENQCMDS does not have the restriction of using a single CPU MSR to store
> >> PASIDs, PASID is supplied to the instruction operand. 
> >
> > Huh? That isn't what it says in the programming manual. It says the
> > PASID only comes from the IA32_PASID msr and the only two operands are
> > the destination MMIO and the memory source for the rest of the payload.
> 
> Jason,
> 
> Two different instructions with only one letter different in the name.
> 
> ENQCMD - ring 3 instruction. The PASID is inserted into the descriptor
> pushed to the device from the IA32_PASID MSR.
> 
> ENQCMDS - ring 0 instruction (see that trailing "S" for Supervisor mode).
> In this case the submitter can include any PASID value they want in the
> in-memory copy of the descriptor and ENQCMDS will pass that to the
> device.

Ah, well, my comment wasn't talking about ENQCMDS :)

If ENQCMDS can take in an arbitary PASID then there is no
justification here to use the global allocator.

The rational is more like:

 IDXD uses PASIDs that come from the SVA allocator. It needs to create
 an internal kernel-only PASID that is non-overlapping so allow the SVA
 allocator to reserve PASIDs for driver use.

 IDXD has to use the global SVA PASID allocator beacuse its userspace
 will use ENQCMD which requires global PASIDs.

Jason
