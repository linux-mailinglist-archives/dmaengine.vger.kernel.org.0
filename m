Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6914326FAF
	for <lists+dmaengine@lfdr.de>; Sun, 28 Feb 2021 00:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhB0X6k (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 27 Feb 2021 18:58:40 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:1831 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbhB0X6k (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 27 Feb 2021 18:58:40 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B603adc870000>; Sat, 27 Feb 2021 15:57:59 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 27 Feb
 2021 23:57:55 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Sat, 27 Feb 2021 23:57:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gizqySAmQl4UPXuRgwph5uqDn03baBGDmnKaqcN2B086bbyesuRuoBh7CXgOqNz5zbEJdkaFUETjY78SdvQAjGwY6A+Ki8MpZuZM615jd4R75BCFpPaK08ip3zM3yz61kYpnwLInDx/gOir6qFSJXwPc/eHGzjJbzapjsy3pqsGVxECgUiND3atgESYjjheAGpjG57yDAkSUuNCR9XEvX7AScIdFSOEmLqRyLiZgybQplBYjNnRc5Efpp+KnBNIYKITE6QAU57l97ik1TeZRKQ8siR5coalB7RaVcQlzK41Cu84o/ir9Pa+YIpW1hwP7rKETA3xcBN9x2bHrWqHm2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPuyQPb7dJydZSCrSv0P5GT2wmZyDDI8igDrVtzdJwo=;
 b=jfeJeyo46Ql9AaSlQih+/Kx2K+SxH5e72Bnwz24Tm62RzIWY8llJ8jWB1/duLp9Ld4zK4azJX6MghKYEixlykO9s9ysHD+52FJjROFBqFKs39HUHU948TXCe0Sdfcic5oCf/JlM2TmK4LNLavSGA1eLijJbOrXgEGI67sQOm5OHNdEMyY+rHYvo9ohRVnnYFwxKQUjuL6xx+KHOaX84kzxgcxmYqIU5GMxnSWDSob0YwYOAf6rY9aDRLEM7fmxhnIGrzb9dqlDt3ChlnCnzdoBGh8B5Z8sE/WbaBJvRk81hO7ip5+JyuY6cZxUmkFVEy9bi3gYejPUCNVfaTjlY2Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4041.namprd12.prod.outlook.com (2603:10b6:5:210::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Sat, 27 Feb
 2021 23:57:54 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3890.026; Sat, 27 Feb 2021
 23:57:54 +0000
Date:   Sat, 27 Feb 2021 19:57:52 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <vkoul@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
        <dmaengine@vger.kernel.org>
Subject: Re: [PATCH v3] dmaengine: idxd: Do not use devm for 'struct device'
 object allocation
Message-ID: <20210227235752.GD4247@nvidia.com>
References: <161420602220.1987219.16867019403434743794.stgit@djiang5-desk3.ch.intel.com>
 <20210227013641.GC4247@nvidia.com>
 <1482a4fc-3359-e807-d8ac-8fa7a2e110ab@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1482a4fc-3359-e807-d8ac-8fa7a2e110ab@intel.com>
X-ClientProxiedBy: BL0PR02CA0102.namprd02.prod.outlook.com
 (2603:10b6:208:51::43) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL0PR02CA0102.namprd02.prod.outlook.com (2603:10b6:208:51::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23 via Frontend Transport; Sat, 27 Feb 2021 23:57:53 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lG9T6-0022Gx-1H; Sat, 27 Feb 2021 19:57:52 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1614470280; bh=xPuyQPb7dJydZSCrSv0P5GT2wmZyDDI8igDrVtzdJwo=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=doNLhoPg8fMH9HnqmqwfDpAdtQTc/I7sLEpeHg08a61ss2wBxJDMcWPYpg/feMvFd
         s9PtvE3xrgZtrqz7WKH7aAKccDrPOybgGdm6joPFKDoXLXidIWJMLlUL20VlmN5l13
         7Qj1254cPbdNKVCMnabPBj6GPh9QGgSmwOUt6x/8PQ6XCJ2VuwRwMFfieGz9425ski
         SHYRCQVgpDoLsd77gKgWPy5WfiwQARC0LMDuwDYgb/yxoecqwIkOHD1I55oeIse96o
         k6ka+dgBdQo2mK/KnHuD9Bz7HuR8hLsJq/z87KuyNcF1TtWisS2K8Y/8hrcuhTacJh
         0uYeBFvmgJ+3g==
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sat, Feb 27, 2021 at 09:27:26AM -0700, Dave Jiang wrote:
> 
> On 2/26/2021 6:36 PM, Jason Gunthorpe wrote:
> > On Wed, Feb 24, 2021 at 03:35:19PM -0700, Dave Jiang wrote:
> > > Remove devm_* allocation of memory of 'struct device' objects.
> > > The devm_* lifetime is incompatible with device->release() lifetime.
> > > Address issues flagged by CONFIG_DEBUG_KOBJECT_RELEASE. Add release
> > > functions for each component in order to free the allocated memory at
> > > the appropriate time. Each component such as wq, engine, and group now
> > > needs to be allocated individually in order to setup the lifetime properly.
> > You've tested this now with kasn and all the other debugging turned
> > on?
> 
> Only with DEBUG_KOBJECT_RELEASE. I wasn't aware of the kasn tests. I'll go
> test with those. Thanks for the thorough review. Really appreciate it.

I turn on these things in my debug kernel builds:

        DEBUG_ATOMIC_SLEEP
        DEBUG_BUGVERBOSE
        DEBUG_KERNEL
        DEBUG_KOBJECT
        DEBUG_LIST
        DETECT_HUNG_TASK
        HARDLOCKUP_DETECTOR
        HAVE_RELIABLE_STACKTRACE
        KASAN
        MAGIC_SYSRQ_SERIAL
        PERF_EVENTS
        PRINTK_TIME
        PROVE_LOCKING
        PROVE_RCU
        SOFTLOCKUP_DETECTOR
        STACKPROTECTOR_STRONG
        STACK_VALIDATION
        UBSAN
        UBSAN_SANITIZE_ALL
        UNWINDER_FRAME_POINTER
        WQ_WATCHDOG

Jason
