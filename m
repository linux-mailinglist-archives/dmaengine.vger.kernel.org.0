Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52910322F59
	for <lists+dmaengine@lfdr.de>; Tue, 23 Feb 2021 18:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbhBWRJk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 23 Feb 2021 12:09:40 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:6860 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbhBWRJh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 23 Feb 2021 12:09:37 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B603536a70002>; Tue, 23 Feb 2021 09:08:55 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 23 Feb
 2021 17:08:54 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 23 Feb 2021 17:08:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHq7sRWDKU+XsIyNonbZeKzScplELrbQESwONwDkO6NI4HwGJIDJ8uxrOU6MV+wjlLNA67USVtQzLV/CWvp++H8FgJP2C63vTU1JfMsDFc+WVmrHmGtQpfTnTFQm34Lso6894LT5uMMfhRM+9kxXOZLgdc3LOQhRImknY6yufLVRkCOSxpxVL7fhz5VIUtVI0tRtg9qWotTpaqK1xoCiVyGOJ+3s7jLqOV7n61kWyZlUaQwlX91CO1QHYP2+y2xkV9RMUbvCE8L0D5iNpcU56+kKRFziJdRq62adtZqFNT3XHhJ42rSx90xfUxjtxBkKS17/WDII5QEzrKUYq9j89w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGkgZLH1Bi1HP8oK8Ayomxc2Ho93Upixft9YhIZLVR0=;
 b=d+f8vlcyzRfK+ist0GWop16RLMiMZiP9pf9/b+OWPAn6WBXuWUzfavKBVTYGp6KQuylXQye4IC+55wXqE8W465EueVA8TPwber/+05nkaR1JZyiBHLXpeqLKRO4wAfB6Oe8tGSXTtumecuJCfoQ6P2+hbDBvKGOQtmRPP0diZhsbe/R83ER2B5i0N3Y0KVMx2NX0etwH2hFGJy1/RBN6lxFwLq54INsmU+UPE00FhBmlV+3V/hxKqH2dMp3Iqsdf3yu6qOIm3S2qLfEWhOsyp9RA8K1+wHgUTA6uSv9ooxVjWiFJ0T+Kp++lunmLLEbaxyDVwNhiW9AhglqURRtfxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3835.namprd12.prod.outlook.com (2603:10b6:5:1c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.34; Tue, 23 Feb
 2021 17:08:53 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3868.033; Tue, 23 Feb 2021
 17:08:53 +0000
Date:   Tue, 23 Feb 2021 13:08:51 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <vkoul@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
        <dmaengine@vger.kernel.org>
Subject: Re: [PATCH] dmaengine: idxd: Do not use devm for 'struct device'
 object allocation
Message-ID: <20210223170851.GZ4247@nvidia.com>
References: <161368391486.325538.12829531932377771231.stgit@djiang5-desk3.ch.intel.com>
 <20210223125956.GY4247@nvidia.com>
 <397867c3-0b0d-82aa-37c1-deccd24d8f6c@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <397867c3-0b0d-82aa-37c1-deccd24d8f6c@intel.com>
X-ClientProxiedBy: MN2PR04CA0026.namprd04.prod.outlook.com
 (2603:10b6:208:d4::39) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR04CA0026.namprd04.prod.outlook.com (2603:10b6:208:d4::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.28 via Frontend Transport; Tue, 23 Feb 2021 17:08:53 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lEbB5-00FRPh-Us; Tue, 23 Feb 2021 13:08:51 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1614100135; bh=vGkgZLH1Bi1HP8oK8Ayomxc2Ho93Upixft9YhIZLVR0=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=SoVQEQtrG8TcgZqWux6LOWeZFlsQDO00qtwDn08SVnHj6vuEjzJgZwK/xSl/5pzyS
         1Fotld78PKyFgF/IrHDVsfsM+Hvebr0nm2qN//K/LKe6X5ZYkuWVH41YrfnP2MhRZz
         JiG8F7FukNjEndR2vTuuFFFBmKiIzFJkPV3vvmFw9r3mZqwDFsoPt+9bOSspnnX5jP
         rkbU9a50jkHKo7ypGFXDmIZfedh08gxo6izLvXztn64V3V32UF+AWJfSBuFzarmcD1
         uf7XpxKVyBfoYnnjXYdSYgTjAt1GvpKWSM0gfp0lVw6BPi350m2QhqtQw0fPDujQ1V
         1oN5chXXBDBGQ==
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Feb 23, 2021 at 08:27:46AM -0700, Dave Jiang wrote:
> 
> On 2/23/2021 5:59 AM, Jason Gunthorpe wrote:
> > On Thu, Feb 18, 2021 at 02:31:54PM -0700, Dave Jiang wrote:
> > > Remove devm_* allocation of memory of 'struct device' objects.
> > > The devm_* lifetime is incompatible with device->release() lifetime.
> > > Address issues flagged by CONFIG_DEBUG_KOBJECT_RELEASE. Add release
> > > functions for each component in order to free the allocated memory at
> > > the appropriate time. Each component such as wq, engine, and group now
> > > needs to be allocated individually in order to setup the lifetime properly.
> > I really don't understand why idxd has so many struct device objects.
> > 
> > Typically I expect a simple driver to have exactly one, usually
> > provided by its subsystem.
> > 
> > What is the purpose?
> 
> When we initially designed this, Dan suggested to tie the device and
> workqueue enabling to the Linux device model so that the enabling/disabling
> can be done via bind/unbind of the sub drivers. So that's how we ended up
> with all the 'struct device' under idxd and one for each configurable
> component of the hardware device.

IDXD created its own little bus just for that?? :\

It is really weird that something called a workqueue would show up in
the driver model at all

> > > +static int idxd_allocate_wqs(struct idxd_device *idxd)
> > > +{
> > > +	struct device *dev = &idxd->pdev->dev;
> > > +	struct idxd_wq *wq;
> > > +	int i, rc;
> > > +
> > > +	idxd->wqs = devm_kcalloc(dev, idxd->max_wqs, sizeof(struct idxd_wq *),
> > > +				 GFP_KERNEL);
> > Memory stored in the idxd_device should be freed by the release
> > function, not by devm.
> 
> These memory are not tied to 'struct device' and should be able to managed
> by devm right?

If it is a pointer inside the kref'd struct then it should be free'd
in the kref's release function.

Those should not use devm as they already have clearly defined
lifecycles based on the kref.

Either holding the kref says the struct and everything in it/pointed
to by it is valid, or you have an inscrutable mess.

Jason
