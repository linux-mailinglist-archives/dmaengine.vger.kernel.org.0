Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D31353230DC
	for <lists+dmaengine@lfdr.de>; Tue, 23 Feb 2021 19:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbhBWSf0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 23 Feb 2021 13:35:26 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:5423 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232810AbhBWSfZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 23 Feb 2021 13:35:25 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B60354ac40003>; Tue, 23 Feb 2021 10:34:44 -0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 23 Feb
 2021 18:34:43 +0000
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 23 Feb
 2021 18:34:24 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 23 Feb 2021 18:34:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HQzjfajQnQBptkkDyE96KFMbKv0cV6f5bZXaZhAxf6Hz3KIitRQHyNAQx5tEFxC93Fil79YNiBUCp79QCaEqNbV8y+tOigHiiNKtVDDbNa37M8YfZicHomPYvPig7KofSS8KupDiYejDtrtJoqV9R6lHSV/gJ4gwrn6T3sGHiT5ZmklJhHuXNkW/vFMhpgZl7IzL9K3v6yM4//X4suKXRXBU9WYROXN0mULHSL/7M9h16b/4WxwsfPIX5vLVuwASrQuNn0Qv4R9vKyAYcZOm6G+JkKcZClOEnNJTV5wSBAdW6YsbC22MHE+1UrY8v4umXnQM86mxxlloLcIOnqhz/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5QPPLL/GjSFWgWAL6LjtWM7nmgCVfhJvd7Ac0A5UtY=;
 b=MkmkzzCYeGFq2g9rAjI27mr34LQ4r3Hrvyxk/HtVHoeYoI+nuWjESDnBot2g2m/+awCBlPTbjLof6M+dDma5GNaoW6wF2C+7M2aWJtpIhFQB3NPgfVvgSevRgQCsj74wcPRLbu+TfTzTpm8yOPkn5cCalaiygB9WHYtLUT6zB/zzWKc/a2OK+O57o93GJ6fKJ+Xt9oIjbMPXPSrQjkGPWRyzP00LS4Gcv3RA2GBcArR5GPMUfVd2qMKLMbGKjAieZ6WWE3p3BxXmsRNV4Kln02qAg86B1Fd6oz01qmaQjXGsvjOoJvSSH4qT2pncE+UqMHt072uLYzJvxAqz8l787Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1340.namprd12.prod.outlook.com (2603:10b6:3:76::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.33; Tue, 23 Feb
 2021 18:34:22 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3868.033; Tue, 23 Feb 2021
 18:34:22 +0000
Date:   Tue, 23 Feb 2021 14:34:21 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
        <dmaengine@vger.kernel.org>
Subject: Re: [PATCH] dmaengine: idxd: Do not use devm for 'struct device'
 object allocation
Message-ID: <20210223183421.GF4247@nvidia.com>
References: <161368391486.325538.12829531932377771231.stgit@djiang5-desk3.ch.intel.com>
 <20210223125956.GY4247@nvidia.com>
 <397867c3-0b0d-82aa-37c1-deccd24d8f6c@intel.com>
 <20210223170851.GZ4247@nvidia.com>
 <CAPcyv4j3RTBqVmAKSRVOzdQ8yZVMU0_yunSGSiV93rYwHBEx9Q@mail.gmail.com>
 <20210223181015.GC4247@nvidia.com>
 <CAPcyv4gA8E9ehFQCnUkz72w-Z1qHV=f_Y8XK7O9w-P3_aap65g@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAPcyv4gA8E9ehFQCnUkz72w-Z1qHV=f_Y8XK7O9w-P3_aap65g@mail.gmail.com>
X-ClientProxiedBy: MN2PR05CA0058.namprd05.prod.outlook.com
 (2603:10b6:208:236::27) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR05CA0058.namprd05.prod.outlook.com (2603:10b6:208:236::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.9 via Frontend Transport; Tue, 23 Feb 2021 18:34:22 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lEcVp-00FSlM-3p; Tue, 23 Feb 2021 14:34:21 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1614105284; bh=V5QPPLL/GjSFWgWAL6LjtWM7nmgCVfhJvd7Ac0A5UtY=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=pMNiIp32ZjrND7D/FKGDBQMNr84zTBpYDQMvKj8zVpxmEXFdc7MTcA9s7Cn+1aDYv
         3JNIZBtL6U/6YHAla4fFjlXyrLktu3fOotnDGlYkvVhqyzdYffzbYxbjrdHShgauAX
         MkN1uis7YIKhExt1qIY1sinqKxs6n4JRV3VqHC0eQd5izTTOivtqodhPVCNYHiMYa7
         3ooiNa/6rHWklc4/vmxxgSUQYyjtV9kWGmT5VivWZcWDXzDGDVtepIxNEYAexJtnNU
         aPcUYsmAi0p8bwDFXqsJ0yjrEvKiMMDMFv7xslaFppg4gvXv9F4BArx+rPSnDKVvk9
         FnUHWBvCVCs+A==
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Feb 23, 2021 at 10:30:14AM -0800, Dan Williams wrote:
> On Tue, Feb 23, 2021 at 10:11 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Tue, Feb 23, 2021 at 10:05:58AM -0800, Dan Williams wrote:
> > > On Tue, Feb 23, 2021 at 9:09 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > > >
> > > > On Tue, Feb 23, 2021 at 08:27:46AM -0700, Dave Jiang wrote:
> > > > >
> > > > > On 2/23/2021 5:59 AM, Jason Gunthorpe wrote:
> > > > > > On Thu, Feb 18, 2021 at 02:31:54PM -0700, Dave Jiang wrote:
> > > > > > > Remove devm_* allocation of memory of 'struct device' objects.
> > > > > > > The devm_* lifetime is incompatible with device->release() lifetime.
> > > > > > > Address issues flagged by CONFIG_DEBUG_KOBJECT_RELEASE. Add release
> > > > > > > functions for each component in order to free the allocated memory at
> > > > > > > the appropriate time. Each component such as wq, engine, and group now
> > > > > > > needs to be allocated individually in order to setup the lifetime properly.
> > > > > > I really don't understand why idxd has so many struct device objects.
> > > > > >
> > > > > > Typically I expect a simple driver to have exactly one, usually
> > > > > > provided by its subsystem.
> > > > > >
> > > > > > What is the purpose?
> > > > >
> > > > > When we initially designed this, Dan suggested to tie the device and
> > > > > workqueue enabling to the Linux device model so that the enabling/disabling
> > > > > can be done via bind/unbind of the sub drivers. So that's how we ended up
> > > > > with all the 'struct device' under idxd and one for each configurable
> > > > > component of the hardware device.
> > > >
> > > > IDXD created its own little bus just for that?? :\
> > >
> > > Yes, for the dynamic configurability of the queues and engines it was
> > > either a pile of ioctls, configfs, or a dynamic sysfs organization. I
> > > did dynamic sysfs for libnvdimm and suggested idxd could use the same
> > > model.
> > >
> > > > It is really weird that something called a workqueue would show up in
> > > > the driver model at all.
> > >
> > > It's a partition of the hardware functionality.
> >
> > But to what end? What else are you going to do with a slice of the
> > IDXD device other than assign it to the IDXD driver?
> 
> idxd, unlike other dmaengines, has a dynamic relationship between
> backend hardware engines and frontend submission queues. The
> assignment of resources to queues is managed via sysfs. I think this
> would be clearer if there were some more upstream usage examples
> beyond dmaengine. However, consider one exploratory usage of
> offloading memory copies in the pmem driver. Each pmem device could be
> given a submission queue even if all pmem devices shared an engine on
> the backend.

But there are no other idxd_device_driver's in the tree, so this is
all some future imaginings?

Jason
