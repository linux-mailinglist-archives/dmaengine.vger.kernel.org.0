Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E75D3349749
	for <lists+dmaengine@lfdr.de>; Thu, 25 Mar 2021 17:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbhCYQsZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 25 Mar 2021 12:48:25 -0400
Received: from mail-dm6nam10on2056.outbound.protection.outlook.com ([40.107.93.56]:20832
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230106AbhCYQsM (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 25 Mar 2021 12:48:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TtH71Au7/VOEq7bUobkp3LyiVc/nG0H/5dSzaE8ZrlmfX3SQ9pznJnEE7qTy5LY1jjRjoLo/wpSz0oUJQ7FBnYM54ShOcsyYWBNURrdW+T/sWKdUx+kVaXMFeDZYcRxaFM8/aaEneQVme1cpV5VPVaOnBTD+E/E1NDFGf3bldI/ozcTkWmHMwQZgN89SDXtpS2JAMqkk7iFRoNwNgdBxyXKCvnMwR/rXkwuAS6hPNioxIv9FuRAVvOYR6u698vD/qbJkK1ZOesHXe8a9QnYNAbagMdmiorE3vyjWwSuXnXoGBToFWg3IFgX+eSN5WkGpWkOcBWP1x3Hh3MVzgVXPEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lF5oZOeuxved+GTOyM6SbRpYnVq9o8eGK83w7wK+uQw=;
 b=T5cjbYQASh2d0Kumeng1Fos9tVlQIexyo7vuOviHY/fQzheDVbln8OcKSKszjCq+PGNR8tLhqdczOEDMLZLdRa1NoV5/XZE3hsf5tanOku8UqMqg91bMq6AXVJCZo2m8XZGQtBXDhvDVSxBxObq8PGhFg1spt4/BWLALHCqG7IN711qNFKIkZcBt1MxFQtDIIfXGYf/7CNPzTaXP2pXnrlHltA08nPhEpf7X5PnVRdqvaqRCj6q7shSOFyKeFvVB9floAnCLo6qv3IInoTnnMk5v1HXsJFbX3SVr/3vmaHhBX6fc+OsbrScdKSGnk4KAghUUk5x4obHrgoIT2kyOTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lF5oZOeuxved+GTOyM6SbRpYnVq9o8eGK83w7wK+uQw=;
 b=QEHMK6DamlkHMFNDsX3SpSEScC2PkyqpL6Is0coNP81cstrcd8BrvFdnDI6533utc/xk1gIoeMFPsZkdXXkin64XrCayur6f+K1FFj5WAbLQZAwR429VGSGJiBO52qEWwbK/U2pdvS0xK+/nR+29ZH/tWPc4jTujUDmbg3pSo8uNZ0MzEHFuwWsm+opknNUCwmaf/hXDzEiKyeA81S5AzYE9Lk1DvNWhGB982eXpzuTGaKg2mQ7gTkWuxSUBAzsywoBkYhtddZAG9X1kyk6hAQUcmxn0RrQmqv0swIO84pbxHKg9pXG42q1S/a0LffsuyDMVgf6FPq0zH25E9trxQA==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4513.namprd12.prod.outlook.com (2603:10b6:5:2ad::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Thu, 25 Mar
 2021 16:48:11 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3977.029; Thu, 25 Mar 2021
 16:48:11 +0000
Date:   Thu, 25 Mar 2021 13:48:09 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Subject: Re: [PATCH v5] dmaengine: idxd: Do not use devm for 'struct device'
 object allocation
Message-ID: <20210325164809.GB2356281@nvidia.com>
References: <161478326635.3900104.2067961356060195664.stgit@djiang5-desk3.ch.intel.com>
 <20210304180308.GH4247@nvidia.com>
 <CAPcyv4ibhLP=sGf3iNwoE8Qtr_5nXqcRr7NTsx648bPFWaJjrg@mail.gmail.com>
 <20210324115645.GS2356281@nvidia.com>
 <CAPcyv4jUJa9V1TrcVsEjf3NR6p10x8=0jZ1iCATLNiJ9Tz_YWA@mail.gmail.com>
 <20210324165246.GK2356281@nvidia.com>
 <CAPcyv4g2Odzusx621vatPbA041NXMmc1JK_3oSNM-EOPwDaxqA@mail.gmail.com>
 <20210324195757.GR1667@kadam>
 <CAPcyv4geTG8M2mxJNxN0wxZsQsLbN0U-mr1jjC=3sjyRWOuwmA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4geTG8M2mxJNxN0wxZsQsLbN0U-mr1jjC=3sjyRWOuwmA@mail.gmail.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: YT1PR01CA0135.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::14) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT1PR01CA0135.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.24 via Frontend Transport; Thu, 25 Mar 2021 16:48:11 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lPT9V-002ih9-T8; Thu, 25 Mar 2021 13:48:09 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f767eb6-bef6-407b-5db0-08d8efadc67f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4513:
X-Microsoft-Antispam-PRVS: <DM6PR12MB45136ED6F4B139BDCC830E2BC2629@DM6PR12MB4513.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qznH2pghpWWOq95pviEqQisPhCG22f0HV2a855wo9QQpT2ujpnU9v5/hyrhTc57j3vA1L60iDBrpF3GrFUpFxF1u6erG6qkWY807fiwIiSXV3sLeM2HZf6zvivJvz68UzS5MJqfL0sE8Y/YkNhpzFPEJLCAOy45xxzolCIMummxKjjYWiY9O2b3hF0zo1uDJDQ+6K8tvuMuXLjXjnkwg2MZ31t3qCZmt/NkAZravC9j+QzV+lqqm5dsZOhmEOUKGTgIpEvCaAMijKPKXqGbd4qpsoEYVqYFCPaBjSkYvoc7RN7xpQ3WJA3I7K+uGsNdQ2IVTTtQJtIgQ3g0lUr7HJRdFTeRU/qh/dow716/sE8cjhpG4Uu7F8EAyAjaL1idmN3UoDgWkzPj5MrdhENXLUUbW3cjR9XgbbSP9qlaBqbgiixKDQ4DsMBR2JVuxChfBTdyG7GRhowtAqHS5Xa0FvZNl5FU94WkA6eqon9vv23POVVUXxeXnVfAKBbGnZkUKUGufB74lYBz9mDDgE8jjIvQGVl4z+CX9Uk0ledYQyAUomeCBWNakKEB5R8tPrbf+aBuugiF22Vfyt5F/xY3iYfDmcUyLSggVzMXa7oydp4+Heo/ptuaoi1drw++GPBGJoiuZE14zGKOnT9BLzvn6SLIaHCRqkN9gR+8idO/Nq9PP9WqOmDQDU8JfAosIhdtGyTULFGpdG/yAZx/Wc9x+nNuH89peaDrVOssszVn4tFPv0LNc5b69idxuSLWkgb5S
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(366004)(396003)(346002)(4326008)(33656002)(26005)(8936002)(316002)(186003)(38100700001)(5660300002)(86362001)(54906003)(9746002)(478600001)(2616005)(426003)(53546011)(66556008)(6916009)(66476007)(966005)(83380400001)(8676002)(1076003)(36756003)(9786002)(2906002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?qAVYdtlcojH8v3YlgGdP937KRYdst2C/zhpHLYOyb3B/nuhyWS02TPysoMqZ?=
 =?us-ascii?Q?WImLLqhr8ROoGT6xYwddpTNUwyGR+EsIwTTzUx7PudGiBfvmYssnrY5bEfmL?=
 =?us-ascii?Q?K4Cy46uTElvnm3ZxFFPp8LuwdWpCVAQlbJ33LZDfCOuoVoYvKL3BQEgYdABC?=
 =?us-ascii?Q?XPLGSlL0ofGLXjUmnaEg7BGPYvoXzdwM+pesbfDD6rIr4KhJ/VRmGSyau+Y0?=
 =?us-ascii?Q?6v2r8/pv2UkwarNHpLWn+JhoCj0do1KG7IvJx4GzWk/2Hb9bsPEbMxdzJRuo?=
 =?us-ascii?Q?YrLDGuS3IpC5RM7CBAHbzxTI2KW0CvLt7Zu0UKhvgJMMjolXcRRJXFpwlRoA?=
 =?us-ascii?Q?9oHPfq+UdM3IrXVWHq0tjn+CXMLHSzNRw4akKSD+tbq0Z1DKQJYK9YJz+pmj?=
 =?us-ascii?Q?sHBUKKbUN1rUoy1TO86M9QOImgaoDzE2B5v4U/AzCAohuMZULUEgLhAWMy1g?=
 =?us-ascii?Q?hYhjfSXOwMQvdwkP7eE/xIv0+MUOLHjyErQeNgxe8WryLnXriDrh4gxVHyfz?=
 =?us-ascii?Q?8ELwr5+l9x+NRGKLDnsI8UxhfMuP4o68GOmy1C3hQaeQor7whfv4sHox1fiI?=
 =?us-ascii?Q?Wun5BeyBmKXHT0JBkgSoem5Yq0Ll6l7gmvyMkw0O7ryYgNU5Gbm25vdgNhqM?=
 =?us-ascii?Q?EVrYdL3yKyfUgrJvF7TQKbu2VfadW79IWazyx9KeksuKNa5NlSXOUfSNitt/?=
 =?us-ascii?Q?ShqNWpYHMNNZ13v32NooTHZtHKZ4ta/X0CMPuxqDZ8htto+bHwYj28MWddOi?=
 =?us-ascii?Q?OPUxKC41ivacOWbM4kSwGbSB89Am5xTsIml6/ViL6xbD6W2StoFyIr6R2oZl?=
 =?us-ascii?Q?MEVQ4S7fy4Q14/eTjfQvMxSoGbckaOkFBRwFvS/GO7I2QokaqKo/a9OomdWQ?=
 =?us-ascii?Q?h8oC5lawzT7WiQlQKOk/H5wE/Q7wYuUx/HqAnNPXJ/nv+sDN1FJVMr1zCWp6?=
 =?us-ascii?Q?sLEc+7tdCzxtuzX1kN9FVWCna77sVoblEvGwQ50uGq46nqNcXJvPXG5UMzkW?=
 =?us-ascii?Q?2QwV2Zz0bPgImd9nN3SykV9yjzUJpQxdhjNQPjjyx03/zk3k2MNpXvZ/uCn5?=
 =?us-ascii?Q?cGZAn7hXdHkHyFD8HMP4m01ldTnIcDwlSU6TTkPzmpAr+4GXgQpYftHkCx2N?=
 =?us-ascii?Q?+5+qKYagstTiCsJe3i2e7bY6AQ9aVbOdj1gGbfHUpNHvDzVZhq3QD96HlkHy?=
 =?us-ascii?Q?VpEHhvVMa6v9Vt9xNxqlUT/hCw/comkBwGrPZI8ktyzEQoM2+xkme18DH5BF?=
 =?us-ascii?Q?GMbCabCu7IdoIn15rhnHwpXJmJMOBg6lFb8/1qMes9qGgOXvUoHY6eVBvGO2?=
 =?us-ascii?Q?bLZ5fKkxANpNIAKFYES35UFe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f767eb6-bef6-407b-5db0-08d8efadc67f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 16:48:11.4120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZeFHmO8lhUfNkqHQiKs4cn03xDQiAHKp0MPqoXfTWdrnJSYTGsV2GfKdjrmvVnzY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4513
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Mar 24, 2021 at 01:00:04PM -0700, Dan Williams wrote:
> On Wed, Mar 24, 2021 at 12:58 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > On Wed, Mar 24, 2021 at 10:01:42AM -0700, Dan Williams wrote:
> > > On Wed, Mar 24, 2021 at 9:52 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > > >
> > > > On Wed, Mar 24, 2021 at 09:13:35AM -0700, Dan Williams wrote:
> > > >
> > > > > Which is just:
> > > > >
> > > > > device_initialize()
> > > > > dev_set_name()
> > > > >
> > > > > ...then the name is set as early as the device is ready to filled in
> > > > > with other details. Just checking for dev_set_name() failures does not
> > > > > move the api forward in my opinion.
> > > >
> > > > This doesn't work either as the release function must be set after
> > > > initialize but before dev_set_name(), otherwise we both can't and must
> > > > call put_device() after something like this fails.
> > >
> > > Ugh, true.
> > >
> > > >
> > > > I can't see an option other than bite the bullet and fix things.
> > > >
> > > > A static tool to look for these special lifetime rules around the
> > > > driver core would be nice.
> > >
> > > It would... it would also trip over the fact the core itself fails to
> > > check for dev_set_name() failures and also relies on !dev_name() as a
> >  check after-the-fact.
> >
> > Where can I find the !dev_name() check?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/base/core.c#n3153

I would just add error checking here, it seems baffling not to have it

Why didn't we use this simple device enumeration stuff for aux bus?

Jason
