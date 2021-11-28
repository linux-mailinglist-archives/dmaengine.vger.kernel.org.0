Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 414DF46029B
	for <lists+dmaengine@lfdr.de>; Sun, 28 Nov 2021 01:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356623AbhK1AoZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 27 Nov 2021 19:44:25 -0500
Received: from mail-dm6nam12on2074.outbound.protection.outlook.com ([40.107.243.74]:13216
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1356720AbhK1AmY (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 27 Nov 2021 19:42:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FkoDlLpe8gk/rOuXCNZs5vImIznaaYm1UjjgSAUOmXcJWxoJyJyABCgeLlGsJMjPA6jWCbNNZGvDLrUSRx33qWf8DDFkkLGTZ3kxPAZJbQ2Y3Fj0Nfl7BNe2DvENHcgHsNkYJFR1F/B3Kn1pacpEJGMVpKLKaDu4Cz/1y0ljmkTi6lZnaZqeyo1b0ZgKImv3DCIIkUNNMiINARK/Z6sLvTkJEnEufI6pQOa5pWmG0V71KDKiTrma3WhmAewV/yRygUGMTn5RRcv209gNR33RxMh0+kxojtlJgbvUSn+AhpGU4Q9qabBA2D3KYMRveZLV5uhmqzplE7toZc6lUuQoHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tz4cpaIwFwSIj7EnQHsvxDTuJb0X+4M1u9/QqVv1eVo=;
 b=mQ69ugxjNGno5DUeUESQ5/MrJXU65afZgKW44GsPh/GkTq/t/wuofUAM5Pyd/IyrtYUAfQltNPMx9E0DNfEvvD/hN4hkZ0qw2FJxi3sVa2BCI1iaUHe02+7PLyRb+0IPCWek9kG2NC5GoxSzKftNdxohRlYoWlTQf3U7qplLFu4b9YwQLsYPQoSiY3sh7nUpASh115WgnPdWg67s44hfXYQ6FApfJDrwf1GR52qNqRDdXyj6VKnJqSZ13hHWe0IJEBYQO05jOsCPzOU2pibXelqTy/OIuTckkCMYazVgi4FxqgI3a2Ls91opEhPZNANdjt9dSaEOrCdGUKGwx6Xknw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tz4cpaIwFwSIj7EnQHsvxDTuJb0X+4M1u9/QqVv1eVo=;
 b=AMJGjwdI0LwyFtJQuBWNLqriiAD4cIxSVD0j3xB6kSL5mrL+MV7TWvJHBtwNEQpIktMP4p0pioq0xH+q29C257hmtBEGETWZFHdrt/sjXFT/tqd3+OtSsMVrK/BCk5xY1QaToZlFjn7IWDZ9pQhAi57UOqXRjDRtd29t02uRr8PeQwtAUEHjX1R8+1iTcx0LYd4+PMpa9RS8adKIdVaTtAsXreZw07zjOP4DEBwXRSW2jLiPKFpnxJOPE9TZZHndvAFDxUFCqMiffwA1r+fs9zEXyJ9EjE+0lSKXUkpShzMrZdmcfuNHVtLgtAtRgpK5pEJphukqHWRlXfyrEHdVhA==
Received: from BL0PR12MB5508.namprd12.prod.outlook.com (2603:10b6:208:1c1::17)
 by BL1PR12MB5142.namprd12.prod.outlook.com (2603:10b6:208:312::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Sun, 28 Nov
 2021 00:39:07 +0000
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5508.namprd12.prod.outlook.com (2603:10b6:208:1c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Sun, 28 Nov
 2021 00:39:07 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909%8]) with mapi id 15.20.4734.023; Sun, 28 Nov 2021
 00:39:06 +0000
Date:   Sat, 27 Nov 2021 20:39:05 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        iommu@lists.linux-foundation.org, dmaengine@vger.kernel.org,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>, Sinan Kaya <okaya@kernel.org>
Subject: Re: [patch 00/37] genirq/msi, PCI/MSI: Spring cleaning - Part 2
Message-ID: <20211128003905.GU4670@nvidia.com>
References: <20211126224100.303046749@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126224100.303046749@linutronix.de>
X-ClientProxiedBy: BL0PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:208:91::11) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL0PR05CA0001.namprd05.prod.outlook.com (2603:10b6:208:91::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.9 via Frontend Transport; Sun, 28 Nov 2021 00:39:06 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mr8Dh-003ndX-GD; Sat, 27 Nov 2021 20:39:05 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c2fd1b1-3b57-4471-8ac1-08d9b2077bf6
X-MS-TrafficTypeDiagnostic: BL0PR12MB5508:|BL1PR12MB5142:
X-Microsoft-Antispam-PRVS: <BL0PR12MB5508568AF0E7403C0116375FC2659@BL0PR12MB5508.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VTTPo45AbnTQ9Zu0VMI5BBlrWx/0NkRfKNETYyLh9peRo0I/rLcmkol++Ht5BVq5//3ejeZ+zoVIza1i8gT0mdbwjl7dVjwbZ966AOHLG2qsbH6X5xWL2u109KCTf7nFt5mAZ4vwLAfT9xXEASoaGgUvvUzHiEumbW1rdSPVuivYG8D6/bsZVwg9U8WSw18w6mighKihtMd8svQoIERNBFf3GQkwrM0gltDEJIsjLUm3D0AddLxruLdIkcEj9EEX5HmqAoCjegKcp2B2KfG5kuBz78qaGIxclMHpG8ApHo4/H51/r61dMkAtpUClY7CwOSQ6QTDtKj5e49/k3X6bTNKrgu94zwifIUBGtSaVHxrOOfYPncJsCSau5YXXAwqDobVnopJCwMHt4gCjobYY22mDu1AtZIs/dxGHf/CqvUGsrPMKsBDvt6ZeffmFwHjztPweu0MYO08+pawhS8TPcrMt+P5NW3oaSDbd1hq6oWCLV8Uytv7WstyMSX1AyPKTcvF7ZqO2Fg4D3PSO6f2flNaWMGp1Ub1EoyrUPPxRlqiZ+nPO6phiOlbQK6Bb9i7qLnY9NyddaiEeaK8jMu4xBnlNiOsVHXsFM2yWdeUslEF1KUPzUR7OXkrk0pPSCuja4l2/SW5g+k1HqcQlbnfR75l4fYWhpOule1fos0Ks5bOhRsNqgpEabHIUNpANSS9yOCHFGslD4oHA8L0xKqiYOmyqoRoEFp/RB1JYrdK6iqw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5508.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(33656002)(36756003)(26005)(6916009)(5660300002)(38100700002)(8676002)(4326008)(186003)(9786002)(426003)(2616005)(54906003)(2906002)(316002)(66946007)(7416002)(8936002)(1076003)(508600001)(9746002)(86362001)(66476007)(66556008)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XAyuai/FfcqzYUyutbGOfi1yy1QcxAzOxUc0MYm0LIl0gNBWEQwEGEedtq5R?=
 =?us-ascii?Q?yw0ClOnO+bMqMiERVsTw1V7SL7iui97VbXKdQ9KwoimuA6IHqXsCFYx6sf6k?=
 =?us-ascii?Q?wFmW6VG9TCbW/BVU3QeoVu2zuTmtJNfiiwbOUjssAqJGOQoSqhe45s2iFlBL?=
 =?us-ascii?Q?ihwaT3JmkIzPpI2QVtZBmu9xuCN9Z3+Igf8Pio70cI1yAlk7GTMRw18GR7PB?=
 =?us-ascii?Q?WIoXJN1a6OqKeu3ophJmlL9rOxGa85+WjZ486L4jTDd51UU9m0SB3AsEiWp6?=
 =?us-ascii?Q?dr7SCkenEirUTQOX+tc5jBrNJpHTi1X4qJcr1qe2nri2nxQmK0VTG137RMKk?=
 =?us-ascii?Q?EVtynFgFJngKbHiTbGzr7dW/ZYh68gyRXKV75zyjhJ6UtNaQh1cTEcBnavb7?=
 =?us-ascii?Q?pmt1KwbIvtaUTQsRDDAMFILv18wGP6FGar9CpZDyGpjx/gOSDxI+6ZfJBZ+h?=
 =?us-ascii?Q?kpZdCf5nzfLUOpgcYw1/rtyvJyv+9RNVhv3+i6IpD1aU9jzKAS9Xs3G59RCj?=
 =?us-ascii?Q?Cc8Ivcgyb6cCFnL2zUAJw5pQ8Lzhy6Dq7JB8XNjEcb2jnz/MIB9Bi7NTLWYJ?=
 =?us-ascii?Q?zIn4eSgSFmkQfgdmndsEwC4A8Wrt8iiP9WtvKzahOOP/Pj3AX4z9u6XbA5St?=
 =?us-ascii?Q?X0o8ekXyLkuv6nNySte8Chpv+UGU1gYJs1spLKqyKlJrpxWRDCN3tkL2qu2W?=
 =?us-ascii?Q?IE0iN7T7eZiiYbJNLxF94XpyjecVDtcA3S5DhiHvFKVkQdxB6+RyZ+GvtGUu?=
 =?us-ascii?Q?hifcIeUj+ssk95ihRwob1db/MpiUDM04XcW9kxVEJZG73JqEpXYVWjiReaZF?=
 =?us-ascii?Q?swbQ1nNy0Eon1oX0oxLce/D6rjUuvQfIBsCP+X/wczKZAeER+Z3wWEeWlDCh?=
 =?us-ascii?Q?q4nwVkvumqGv5gkw81OzlZl18C2RpAJE1MzU+x+Jz9tCfaSTFLzq3agB1NAF?=
 =?us-ascii?Q?m+eR0LkaVaf6qRHEpq16OgaMbzMAb/L6kGyGeeaojxtb7bqD13IapJU/Boha?=
 =?us-ascii?Q?5h7JUzWa98p4jx2IU1nsR9t3DF2NJp2WucHAVujePbWZUy0rN8i5EZnX5REx?=
 =?us-ascii?Q?9560Fc77hz7W9SCPmg0oLpOXDso/j9stqjwtusHeyxKwCvcGbD9erBFaQHUQ?=
 =?us-ascii?Q?Gn3qRpjklY5NmDcU08p24PcoL3+bSgjCpvmizdUv210WCWK89AJDkTGk0/a9?=
 =?us-ascii?Q?3tH2q5NWeQKfhpD6azbTEFOapx/RLmFo8TfuE5SbK+UUd61bsuL7GMuJKYI8?=
 =?us-ascii?Q?MSjq7XBYeTfCDK6hWhYzAOIX2LpjePGGKNHCCTNilujkodrYs384bd1dBz89?=
 =?us-ascii?Q?i91BVJ3qL4onCYoXUCQp6dbRHHApeeL2mW4vcQHJTwLBuyLGdRbvR37rBWRn?=
 =?us-ascii?Q?4zeK4ZxFqN/DIfDXBoTT+T14eC1yXiLxi3948WcqhE/ujVGaZAkL3LXyet8u?=
 =?us-ascii?Q?XKs4hH5QIiTbeSwGLpHoRYph482nMzRlMgxW2vf9SgCfubWzmbZYoGByZ/lZ?=
 =?us-ascii?Q?HFlet1uDNPP1LX0LV4qQ/RWXhhqHXksXiMyFL4j7uRdmDSNq00JRzZjPSCoG?=
 =?us-ascii?Q?cSzvkVvvwNDexh8OjVY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c2fd1b1-3b57-4471-8ac1-08d9b2077bf6
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2021 00:39:06.6235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xrqlAexVn5snThqU+O4W7p/UeFb4IBeJhx1NbfCGCxt53/579dmiNnEQzYixlyVY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5142
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sat, Nov 27, 2021 at 02:21:17AM +0100, Thomas Gleixner wrote:
> This is the second part of [PCI]MSI refactoring which aims to provide the
> ability of expanding MSI-X vectors after enabling MSI-X.
> 
> The first part of this work can be found here:
> 
>     https://lore.kernel.org/r/20211126222700.862407977@linutronix.de
> 
> This second part has the following important changes:
> 
>    1) Cleanup of the MSI related data in struct device
> 
>       struct device contains at the moment various MSI related parts. Some
>       of them (the irq domain pointer) cannot be moved out, but the rest
>       can be allocated on first use. This is in preparation of adding more
>       per device MSI data later on.
> 
>    2) Consolidation of sysfs handling
> 
>       As a first step this moves the sysfs pointer from struct msi_desc
>       into the new per device MSI data structure where it belongs.
> 
>       Later changes will cleanup this code further, but that's not possible
>       at this point.
> 
>    3) Store per device properties in the per device MSI data to avoid
>       looking up MSI descriptors and analysing their data. Cleanup all
>       related use cases.
> 
>    4) Provide a function to retrieve the Linux interrupt number for a given
>       MSI index similar to pci_irq_vector() and cleanup all open coded
>       variants.

The msi_get_virq() sure does make a big difference.. Though it does
highlight there is some asymmetry with how platform and PCI works here
where PCI fills some 'struct msix_entry *'. Many drivers would be
quite happy to just call msi_get_virq() and avoid the extra memory, so
I think the msi_get_virq() version is good.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Thanks,
Jason
