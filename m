Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 363D634788B
	for <lists+dmaengine@lfdr.de>; Wed, 24 Mar 2021 13:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhCXMd3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Mar 2021 08:33:29 -0400
Received: from mail-bn7nam10on2052.outbound.protection.outlook.com ([40.107.92.52]:8801
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233835AbhCXMdQ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 24 Mar 2021 08:33:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GXnQc3lTES5W3mlJgkzKCPLe/gU2P9toebKJP074KMZnVgVhLBY+fltnCzfxK+kmwu3FRKg9GpMmGBl3AzPJ0sjeTztw3lcgoa+pQMkgIgaMQEGhYMR4qv4falPuYG8CN354gLurIxgQK4yAK4RTkAcHjw0CM38KvdXXgN6gV8of5+SOxj+gHM1GJe9XG9xVdVUb82hW6/CFfMdWoTFHTLmwA1XHwU6bgQOYtxIJB3r/tzf2Rro08WcrOVhHlCWCMX5jkNauDM6SOfcbtPgguSIq7CHimLkceeWtJM5jATnuIlGyfdbRdiCWklzFJh2UjKI2Q/tQtKVGUAPdvMfCGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1zbCOVsrBTCV4UpDFsDa3iqUI+oyYiRw/V89n8IU5dA=;
 b=jyDSvucU6teqcj78nh1wckFBSyVLBlNPn+VtDo97WBjnbfYLUMMMHRXArCArMGptex4im7Hwjyab4/iwJfdczbVlyYgfY+uDHg9sjl0wUABK58GwIrlrBLqOqESaFEfowOEwszCifOMjuoreoeX5S8vkDogGYAYaPC4fIGYXsJq4ofT78FVmeHaCbmiFjs7RzzE9sKYFYS3sSd1ZEN/ViFbNaefkf2Jl9Iw6v0fKUrHmTCI09rHH3LGow4CpJ9X0fdazSNGLhCaE5pfIYHXKKCgqeYrThSWMlDVx/9SzJk55NaHU98ixlZZ/k76X+IUAYDcCMzNHrVR8ZRvmFEXxqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1zbCOVsrBTCV4UpDFsDa3iqUI+oyYiRw/V89n8IU5dA=;
 b=t0bKjnArbYzt7MublgXCCSEI8rnfKJjQaBn8QgTtL1c0YQ0nqlAJ7AfecZ46nHBkRm8jTYFcXnxRgw05aoK6Tqjq+dzt8SF0d4dMXbJUlh9K4Eu1XtIpAwFPvm5asoJopVKeBbHiJ9rocztQceC3SX2e/enMkdALPElLk5u9kMlXX8t8E/d6vhILlw8oc5hDLFdW5kaUF1lPgM3qatcry0vxpLeJC5xOJjzbXruoP4PWwGuLRCeLEKgrFZ3V07AiI5UnVAIp589fnhsS/VzV42vufxOn5AhDmtOERQem8TBNiBM6KbYx7ovGzPcnenb48Ike6T1+kky9T3rJHJVaWw==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1435.namprd12.prod.outlook.com (2603:10b6:3:7a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Wed, 24 Mar
 2021 12:33:14 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3955.027; Wed, 24 Mar 2021
 12:33:14 +0000
Date:   Wed, 24 Mar 2021 08:56:45 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH v5] dmaengine: idxd: Do not use devm for 'struct device'
 object allocation
Message-ID: <20210324115645.GS2356281@nvidia.com>
References: <161478326635.3900104.2067961356060195664.stgit@djiang5-desk3.ch.intel.com>
 <20210304180308.GH4247@nvidia.com>
 <CAPcyv4ibhLP=sGf3iNwoE8Qtr_5nXqcRr7NTsx648bPFWaJjrg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4ibhLP=sGf3iNwoE8Qtr_5nXqcRr7NTsx648bPFWaJjrg@mail.gmail.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: YT1PR01CA0045.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::14) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT1PR01CA0045.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.24 via Frontend Transport; Wed, 24 Mar 2021 12:33:14 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lP27x-001y7e-1A; Wed, 24 Mar 2021 08:56:45 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 170dfdd8-a12d-4e0d-39d2-08d8eec0fe7d
X-MS-TrafficTypeDiagnostic: DM5PR12MB1435:
X-Microsoft-Antispam-PRVS: <DM5PR12MB14353AA90A799BE4BCA0947EC2639@DM5PR12MB1435.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jTwRR0pJrbozFXqNRbslAMYLUU4Y7q5Zvfwjq81sf2zp/LJkUi3j7NM7UVH9rORcrB1w6zl1EjNBTz4avMhPnGLoduAnCf+sESK2YK95VF8+SuzZ/seA5i/2G8TpmGyt/N39ElS96TAvG4S52/EWV9oQTDzqoOB8jVycechwBGEGEyFT8yKrwfMyD+oGw8PrggK7v4vZenXjrQMIEV8wIm6ZlFqpTRyoWeLsazfNvR0rDKk/ScyuiuV3uhTJplizwPRpwLf5zTvNjzricYOFEKelge8TIcIPMXAbhA3zGoH/q0wKcvgW8wx2y7xcTYnBcNj0jQcfT99eoJRZI5ogCLW3O0m6Fvw1brnODrOYdfZ5rj/AkYqJJ5nh3Ez7xvrkfkaJ8rkW5iFqEL0B27/iv9YONmJe3KliGxt0yPxklay2EsnGzWt+pELDv0XWxy7uYW0QTsvTg8wnawH2qjblFhnO3A8nhCFLmMSsVTqXReCkH2tSsIrKFQpfMU+HpiMTS9XlrYDDHYiuT5A3DsFBUfyGpp18Qz4ovKV0mZmHYFDwjvm4KEHgnDZwlh3DeVaJLG8g3n8ED0nt0l2GjcbpOOS5INQHUrbNC+/6+1+NSSXZNz2oEzVqexJB6s3FGs01NaFlUZ9ixdgZwAVXC/56AHsIEoxD8tWsOyavKeMC9JI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(366004)(396003)(376002)(136003)(83380400001)(4326008)(9786002)(9746002)(8676002)(8936002)(186003)(86362001)(36756003)(26005)(66476007)(66946007)(54906003)(66556008)(5660300002)(38100700001)(1076003)(316002)(2616005)(2906002)(426003)(478600001)(33656002)(53546011)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?BSHzhUWsoDo9CzC0YURzrI5a+E3SjiiDGReSeIuwIYBd1dGRmCYF7b3evrRX?=
 =?us-ascii?Q?1cY5A80SZCuHdNlCL1xt2UPk+8VrS2UIVX05UDs1C04lC5n9KFE1QXZ+Dqwz?=
 =?us-ascii?Q?NrTjF3cH5NpfDa7MF6msJ9skUW1UrfmVCTCuWrS9uvLZaXY5hX0DO6doMaEj?=
 =?us-ascii?Q?ei4EDT2jvtXH396k7naZc5b5Xxw6LMAZoadDz/YiSwZB4JskNdFjvW1cHb99?=
 =?us-ascii?Q?fcEPS/znP2lpuOqQzUx0VXfUa9q+tf+PIj0jiArqnwYbN0FrRmCSMS9GFMeS?=
 =?us-ascii?Q?E2jRVPpsSun9yv1wEmAd296SyzXDofn0JdDZxJxA26ugTHj/CnywbMftcvSE?=
 =?us-ascii?Q?HImNPq5uuSIpgDWqf0FypnVGCI4IoBawBMQUwis1hb91QGavv7pXS18zOp7u?=
 =?us-ascii?Q?m+wLYWSf2pPE9v3UTic17ukj0QRdX6Jjt4L/5YEXbh8u3lBItxoD0oBcSScE?=
 =?us-ascii?Q?OmUPS0Fd7BfK0z9PgeeXRN2G9WcULZ4JopKDNGljW5Ztpy4h6VHIK5Wd0efa?=
 =?us-ascii?Q?keT3dnuRNqW2RZDT+EO44afEj2Cyswg3L4yAOvblwgP7O6JItlT94j2XztcY?=
 =?us-ascii?Q?Ilex18zkCqqzbgheH5qnsegFJimycTYq19OVhL5j/UMpM0SPpp0TClQ7whMV?=
 =?us-ascii?Q?AMHjcb9NzlLEgZrkmEiBb4lqUgjdndkaOPiK20W3eeWwyYZfo/8O52mdhHzl?=
 =?us-ascii?Q?R1YarbNXNRSxp6DEwhRB7pqbzHgOAhxXGg/Ox1Z+oDPoF6DeTertnV75IsYY?=
 =?us-ascii?Q?JLOdHaEciBDybJeLtK6iNKEMVe9jSfQ4KLkpwZBDeh5n67+Gh69IP26fgRv5?=
 =?us-ascii?Q?T9dieb3psMu9uRjp0opbnv7KHmG8CTA5z5Z5yW/dPIecyp8ddvqdQQApUqhc?=
 =?us-ascii?Q?Qj971rvmjCZtCuex4V9fcoAK4TWM1K/qbZOc8IALGurQNItpGihOf2HHHNC2?=
 =?us-ascii?Q?otoIAwszfpC2w5YRW1WqJZGez81tvejsZ6HCmb94+RSh2ZRpNjvBdRxrnzAk?=
 =?us-ascii?Q?PZPxmrXu51ZootePVs8b3kk9C6RMsfqX/6IeiCE82HvS20Yuy/1EiUNEloZb?=
 =?us-ascii?Q?m1MUS6WrES+sjpBxgi+T8UPgUjvFDf5N8PeYxNzKZ68mSfUP6FvSYf+7778w?=
 =?us-ascii?Q?q+NkCp64XytdH5l+1ptnPW/IV8nUksl+M/W16RU/r2dC5WK+dBMafoGYb+tG?=
 =?us-ascii?Q?lBimlqD1fLt9Ia0mOtKkU2yikE66gurOWvPGtlvx11gxtrhwafFQpr+2VI5P?=
 =?us-ascii?Q?EiE8+X9lbEC/Zxt4wlDJYjWDj9a1sEjo9/JwxxVbLbZz/nzRCBTwOeVuvwl3?=
 =?us-ascii?Q?V2gWKoyblmhTelrPVw38XcTO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 170dfdd8-a12d-4e0d-39d2-08d8eec0fe7d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 12:33:14.6025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tIGRjGFVitC6j+O8o+stWDhUI5F4w+fo7Z/sx85KYTu7bn2LXdB4Jcts6N5UuaCu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1435
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Mar 23, 2021 at 10:07:46PM -0700, Dan Williams wrote:
> On Thu, Mar 4, 2021 at 10:04 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Wed, Mar 03, 2021 at 07:56:30AM -0700, Dave Jiang wrote:
> > > Remove devm_* allocation of memory of 'struct device' objects.
> > > The devm_* lifetime is incompatible with device->release() lifetime.
> > > Address issues flagged by CONFIG_DEBUG_KOBJECT_RELEASE. Add release
> > > functions for each component in order to free the allocated memory at
> > > the appropriate time. Each component such as wq, engine, and group now
> > > needs to be allocated individually in order to setup the lifetime properly.
> > > In the process also fix up issues from the fallout of the changes.
> > >
> > > Reported-by: Jason Gunthorpe <jgg@nvidia.com>
> > > Fixes: bfe1d56091c1 ("dmaengine: idxd: Init and probe for Intel data accelerators")
> > > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> > > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > > v5:
> > > - Rebased against 5.12-rc dmaengine/fixes
> > > v4:
> > > - fix up the life time of cdev creation/destruction (Jason)
> > > - Tested with KASAN and other memory allocation leak detections. (Jason)
> > >
> > > v3:
> > > - Remove devm_* for irq request and cleanup related bits (Jason)
> > > v2:
> > > - Remove all devm_* alloc for idxd_device (Jason)
> > > - Add kref dep for dma_dev (Jason)
> > >
> > >  drivers/dma/idxd/cdev.c   |   32 +++---
> > >  drivers/dma/idxd/device.c |   20 ++-
> > >  drivers/dma/idxd/dma.c    |   13 ++
> > >  drivers/dma/idxd/idxd.h   |    8 +
> > >  drivers/dma/idxd/init.c   |  261 +++++++++++++++++++++++++++++++++------------
> > >  drivers/dma/idxd/irq.c    |    6 +
> > >  drivers/dma/idxd/sysfs.c  |   77 +++++++++----
> > >  7 files changed, 290 insertions(+), 127 deletions(-)
> > >
> > > diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
> > > index 0db9b82ed8cf..1b98e06fa228 100644
> > > +++ b/drivers/dma/idxd/cdev.c
> > > @@ -259,6 +259,7 @@ static int idxd_wq_cdev_dev_setup(struct idxd_wq *wq)
> > >               return -ENOMEM;
> > >
> > >       dev = idxd_cdev->dev;
> > > +     device_initialize(dev);
> > >       dev->parent = &idxd->pdev->dev;
> > >       dev_set_name(dev, "%s/wq%u.%u", idxd_get_dev_name(idxd),
> > >                    idxd->id, wq->id);
> >
> > dev_set_name() can fail
> 
> Something bubbled up in my mind several hours after the fact looking
> at Dave's lifetime reworks...
> 
> As long as there are no error returns between dev_set_name() and
> device_{add,register}() then those will abort with a "name_error:"
> exit and require put_device() to clean up the name. 

IMHO, that is gross. We should not rely on implicit error handling like
this, it is too easy to make later change and not realize that
dev_set_name() can't be moved.

> I'd much rather drivers depend on proper dev_set_name() ordering
> relative to device_add() than pollute drivers with pedantic
> dev_set_name() error

I want to go the other direction and add a WARN_ON to dev_set_name()
if device_initialize() hasn't been called yet.

IMHO the initialize and add pattern is a bad idea just to save 1 line
of code. Look at how many mistakes are in IDXD alone. Lots of places
get the very tricky switch to put not kfree after register fails wrong
as well.

> handling. Unhandled dev_set_name() followed by device_{add,register}()
> is the predominant registration pattern and it isn't broken afaics.

It is very fragile, and IMHO, wrong. As a general pattern drivers
should be setting the name very early so they can start using things
like dev_dbg().

> Only buses that expressly want to avoid fallback to a bus provided
> dev_name() would need to make sure that dev_set_name() is successful.

Yuk, now it is bus dependent if the shortcut works?

People need to code this stuff robustly! Call device_initialize()
early, check the error from dev_set_name(), do not call
device_register()

I *constantly* see drivers using these APIs wrong. Look at how many
bugs are in IDXD around this area alone.

Making it more subtle to save LOC is the wrong direction.

Jason
