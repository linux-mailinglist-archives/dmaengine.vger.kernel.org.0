Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA90A323056
	for <lists+dmaengine@lfdr.de>; Tue, 23 Feb 2021 19:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbhBWSNN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 23 Feb 2021 13:13:13 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:15214 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbhBWSNK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 23 Feb 2021 13:13:10 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6035458e0000>; Tue, 23 Feb 2021 10:12:30 -0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 23 Feb
 2021 18:12:27 +0000
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 23 Feb
 2021 18:10:19 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 23 Feb 2021 18:10:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QRo8WLnXMNpCSNvgW+ZZXizLjyf9Y6YwUXvsf5EEaNZpA/5/6/w6dyBI8Bfuc4sRIv8wcOO88c8LQsz81NKHO1rQ2a/4CqLYpu1EN/DU3KoaZLO323dOlbT9pPHJECXY5oQL1l79OAzDSheUW3B2fOyfyS/YFBvhuwwEtWg18byYGjjr78NSUYVKSvkt22rivOsB4s+YPJpmW7ocswcg2gmVkotMF1lEUP7CU9/dG+D5bL2A87PA+usSoKE2lp6AKwjgBCTP1SxvCMlJQiSlAS0Lw95QnZvAHU8UwvG623DonM6gyU3FVRA4klkHNfQfNknBgODJ/uE0ScoqlLJS3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+5s+sMaHFSDMQxu+KIh8DesBJKne038ZuWPfz7gbLY=;
 b=cNQiay2aUaLbNqZY8t5GZqCRitCOuft+U5eOm2yAU3bPaCs/xTvu/OYZ08JBW/8F/435FE9Uth102DPtaX+qXoVz6mqUITnzQEkkqgQgMyjbLQIwT3JNDlnz6cOmki0nKeVve3uKdG+c7Tx2L0dcMZxcTRluSkyzz/DRaY5riMUKQLnX9NX1GlEhXUrh5rvt+3tWOstGYsRPWJKTWV5piTjigi3BaToJkWwjy73HC1bDfFvFsRBorWYLt1XD3qievJMVgKEDrM4Swrgso9ZWkYv52pOABhECkkHlJO3oAAplYr6IZK3zNHB62clx6Ejj0UxAliUKtX/jyLvzdRedUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4338.namprd12.prod.outlook.com (2603:10b6:5:2a2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Tue, 23 Feb
 2021 18:10:17 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3868.033; Tue, 23 Feb 2021
 18:10:17 +0000
Date:   Tue, 23 Feb 2021 14:10:15 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
        <dmaengine@vger.kernel.org>
Subject: Re: [PATCH] dmaengine: idxd: Do not use devm for 'struct device'
 object allocation
Message-ID: <20210223181015.GC4247@nvidia.com>
References: <161368391486.325538.12829531932377771231.stgit@djiang5-desk3.ch.intel.com>
 <20210223125956.GY4247@nvidia.com>
 <397867c3-0b0d-82aa-37c1-deccd24d8f6c@intel.com>
 <20210223170851.GZ4247@nvidia.com>
 <CAPcyv4j3RTBqVmAKSRVOzdQ8yZVMU0_yunSGSiV93rYwHBEx9Q@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAPcyv4j3RTBqVmAKSRVOzdQ8yZVMU0_yunSGSiV93rYwHBEx9Q@mail.gmail.com>
X-ClientProxiedBy: MN2PR12CA0013.namprd12.prod.outlook.com
 (2603:10b6:208:a8::26) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR12CA0013.namprd12.prod.outlook.com (2603:10b6:208:a8::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Tue, 23 Feb 2021 18:10:16 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lEc8V-00FSK7-OL; Tue, 23 Feb 2021 14:10:15 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1614103950; bh=4+5s+sMaHFSDMQxu+KIh8DesBJKne038ZuWPfz7gbLY=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=GGFCOoZ3CO6c+86TPezt7FSNtIGqF7JHyoApW/nLRtss0/7kVko6FTXJ21Q/lsVLa
         MmLpZbjoYYVTN0aNunqnX4tZCUdApoid9fxC569u70GVLTUPYAj1OwJ2n8O7BINE+p
         0n2kvxPS8lXy5wCKIYwdgvkZ+QOMLU20VxkIJIO4wiVkgEkWdfAOkSWZSd3kmkv+li
         4s8Lu3USlCPXKWS3A8t8Ar9JLthobKp8VxXjELK1ufVbMlp+XXOOPfSUqUDbX1vYpS
         pDZHhbGhCcrsrgFLctSPymcGwxWLhiNhy6sqm7k7tRvZ+icN4VrTpoTIOM8Nnq+RWE
         uKjpikrRWDRXw==
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Feb 23, 2021 at 10:05:58AM -0800, Dan Williams wrote:
> On Tue, Feb 23, 2021 at 9:09 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Tue, Feb 23, 2021 at 08:27:46AM -0700, Dave Jiang wrote:
> > >
> > > On 2/23/2021 5:59 AM, Jason Gunthorpe wrote:
> > > > On Thu, Feb 18, 2021 at 02:31:54PM -0700, Dave Jiang wrote:
> > > > > Remove devm_* allocation of memory of 'struct device' objects.
> > > > > The devm_* lifetime is incompatible with device->release() lifetime.
> > > > > Address issues flagged by CONFIG_DEBUG_KOBJECT_RELEASE. Add release
> > > > > functions for each component in order to free the allocated memory at
> > > > > the appropriate time. Each component such as wq, engine, and group now
> > > > > needs to be allocated individually in order to setup the lifetime properly.
> > > > I really don't understand why idxd has so many struct device objects.
> > > >
> > > > Typically I expect a simple driver to have exactly one, usually
> > > > provided by its subsystem.
> > > >
> > > > What is the purpose?
> > >
> > > When we initially designed this, Dan suggested to tie the device and
> > > workqueue enabling to the Linux device model so that the enabling/disabling
> > > can be done via bind/unbind of the sub drivers. So that's how we ended up
> > > with all the 'struct device' under idxd and one for each configurable
> > > component of the hardware device.
> >
> > IDXD created its own little bus just for that?? :\
> 
> Yes, for the dynamic configurability of the queues and engines it was
> either a pile of ioctls, configfs, or a dynamic sysfs organization. I
> did dynamic sysfs for libnvdimm and suggested idxd could use the same
> model.
> 
> > It is really weird that something called a workqueue would show up in
> > the driver model at all.
> 
> It's a partition of the hardware functionality.

But to what end? What else are you going to do with a slice of the
IDXD device other than assign it to the IDXD driver?

Is it for vfio? If so then why doesn't the vfio just bind to the WQ -
why does it have an aux device??

Jason
