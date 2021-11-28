Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79155460282
	for <lists+dmaengine@lfdr.de>; Sun, 28 Nov 2021 01:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237078AbhK1AT0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 27 Nov 2021 19:19:26 -0500
Received: from mail-co1nam11on2089.outbound.protection.outlook.com ([40.107.220.89]:20064
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232401AbhK1AR0 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 27 Nov 2021 19:17:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dWp/BDlzWYtIlijhJHGAdirEHji82PxcKWfXztkaQKpoDqXL5BOFwLl+WyA2c93skSFj4afEPwub5dNGnErIFb+1bX6DP0G6UFJfuzy0WV37SzyfsWHmPiSk2qnBTqXSAw1GOp8EOwm1xSOwkk/xi1IAHDFLSbUUY32diGFe8ZhUTAHuHg9h6u4nibufDeBwOPZgvjZqmzfrqYBqMUtptxdAUAr/YWepdKyhDTAUBjzbof2iMHqRt1CLA+TtSSx7BHT6tSpOKCPfjcyM3Na7AhHNbXlgKuq2YCgUEw8gHsCuBv6OezzHP0FZujwt9gh0dgt6Tmg+R94kyjv4TkN2NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+TCrf6m63JuJDO+0D1p/tfBsj7N9yAJ5LYodPWa1UY=;
 b=l8ABiC0k02B21VElgstFudAgSmRPqVzyh7Iee/yuU77nqKM3xoQiLXqilmSU+ESYxjgDMTJgB7swawnXTSxI5GuIyMiKRyalLZE01J3qB0fSpHwpQiGVMakrof7p1zIN1pGUVYcQ8jKLEJU/kcw+8f7EFRHiHGs57K+oGi9WMinuUXCVFjPVYHtqzIDBGiUSUGdnKqSpleeTEfeOSeJirnDMzH1e57JvaRCzx5O6wOgioMJDIXczIBDh5WFJv9XvK3gHDd0/MitBZ6zYDAYshEyAJpOKuuQFNX5CTL0t+0hA84lygeJ3gA9dA/OXQ0Qnp2s7s5H99t5diB0Ti8D6GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+TCrf6m63JuJDO+0D1p/tfBsj7N9yAJ5LYodPWa1UY=;
 b=NiEsOrL+ZotAfsKDxVa5D74+vxq8x1irDDVEoHMBSetYoTDl7pi/hxgkvoE/B4tzCMfq6JbwJwuPUUZqv8Cm29/WVTyu3JMw6HfC1Zh1l6NcdNh/UqVyqpWVYFNcL2Xl1znh49/H7t3iWJeQ7DChqlRoSYogq6CNezZEhcQ+zb+kJc9yuxrs3hLdYMelKzRmIO2gqxbOJNBbcL2Kdk+l/nFFtCmMmBuPZ8hwS89IQ1ZZ6Jb9bPLj/m2eI262OkDSYutFmBuToRXj01oBDrQirQYlDkLH3hOHKFFddQJaeSvEWQwWz3TepWkUBoCsmcNcTiuwrucod+G2KwiHBAruzw==
Received: from BL1PR12MB5285.namprd12.prod.outlook.com (2603:10b6:208:31f::14)
 by BL1PR12MB5255.namprd12.prod.outlook.com (2603:10b6:208:315::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Sun, 28 Nov
 2021 00:14:08 +0000
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5285.namprd12.prod.outlook.com (2603:10b6:208:31f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Sun, 28 Nov
 2021 00:14:07 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909%8]) with mapi id 15.20.4734.023; Sun, 28 Nov 2021
 00:14:07 +0000
Date:   Sat, 27 Nov 2021 20:14:06 -0400
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
Subject: Re: [patch 02/37] device: Add device::msi_data pointer and struct
 msi_device_data
Message-ID: <20211128001406.GT4670@nvidia.com>
References: <20211126224100.303046749@linutronix.de>
 <20211126230524.045836616@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126230524.045836616@linutronix.de>
X-ClientProxiedBy: BL0PR0102CA0049.prod.exchangelabs.com
 (2603:10b6:208:25::26) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL0PR0102CA0049.prod.exchangelabs.com (2603:10b6:208:25::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20 via Frontend Transport; Sun, 28 Nov 2021 00:14:07 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mr7pW-003nEe-HR; Sat, 27 Nov 2021 20:14:06 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44bbdb6c-7155-4037-3ab1-08d9b203fe7f
X-MS-TrafficTypeDiagnostic: BL1PR12MB5285:|BL1PR12MB5255:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5285164E24B3F194758FC1F4C2659@BL1PR12MB5285.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Org5Xo6PEIdn8V/PU7GyUVqGVLfHETnxSpTXgjDqpFsuL50/2JdjJ+KmD1U5DhqQi90uSMzhmQDqemfeJ2vMnO7CZYrmssGerGhi5ldr8yKwsQPWXJXBjuQXV3WaFlTlqXDfGmo0qCmad80vGU859L/dBfnmz+HCq0LWtFWtQs+SAF+hqNYPZovgz8MgVuDr0GjvP97HF1DrJpYvRIma3AhsaEPZ2dGyfhgXKIskFO9PWGUEsDUrPd0F12ax6pDk+LeZZjHd36fBCMZD2atctpmAvoZOduRL1L6ijDACcKkH7/Ueml6HrPl0MvAz5uILpdYWTFJOkpKl7e+An1uLI5slefhyvMncJ8lM6+VjR0Bwf+545HKU5vPkmb27d1nJQXzFjm8vqCvqfSVFJvyfaTLnofRp9/f/sLTZyCRvcG9JJdMlDEYbWKRHryvqmVBuZ5AFmR1HvP31bYwiAzlaadER+ZQrdhEcTmzFN+jxKgxFrZYUJA1RerDlNYYpKXsnqeC4vLBTi+LJerXTCE4TMWwTZR4OA5TaTL4ZVV1uhnUr4kKMS27k/6IcIth6Rrf+e7BVSkAJPxYyl/mV0nBSlDpHI85ZBKnGZoNIIWaBDvhOv12ElSgHEvb9/iTl07uhoaROfQiUmjrpxdh5QUuWdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5285.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(9746002)(9786002)(54906003)(86362001)(33656002)(36756003)(316002)(5660300002)(8936002)(7416002)(66556008)(4744005)(26005)(66946007)(66476007)(83380400001)(2906002)(2616005)(38100700002)(186003)(508600001)(426003)(6916009)(4326008)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RRsHo0qRY+B4SlGd36X+60HpRCou+GDRqJcYrw0CyCgkGqJRqBsAtsAJgNW2?=
 =?us-ascii?Q?K3q7UaND7fYX3Gkb0lyEvv0TdAU4zLm6A84F+iAYAEQeMSutGh/uubKjiSTW?=
 =?us-ascii?Q?EMpYANrGxHencQ2D8JgtOu2ToZjnUwF1aHgThAQuCrrYyr7un0OygKYROA3p?=
 =?us-ascii?Q?mmbUJr8IXqcSS1WZqyf4GGlp/r1QAod9tducsO43drJYr/I16OD5XnkJm+xS?=
 =?us-ascii?Q?Fm6MtYsvT+8h8u9b4x40eIATHhlKYSF3Y3PuZa+FTfRvyYHv7O1Er3NCXZ7l?=
 =?us-ascii?Q?iy7jEKuxXky7Ycgmm9USg0L0LikCkyrT5zHx/hB4uQSOqgEFuBF7z7hCq89g?=
 =?us-ascii?Q?dBVwbcWvkA7gzSegC+HnyrND1+YW+LHsN/tK2Boq9IXkfB/QmuibG+6ZEFke?=
 =?us-ascii?Q?dIK8VxEHzMtK8Opo5tcarpOAwj806JQJML/RRANc4MZJvUBWaBv6anAyLAB2?=
 =?us-ascii?Q?12tgSlbtYUjTjH+3BTd40zcixD/RvGHt9nm/iuiuFG6ajW/aBDg0E2d/ozfx?=
 =?us-ascii?Q?LNjcp162/xAVEywoXWtTLtsLsIuv8uVqxH2MF8JsSd1B6cSATNHy9Q92a8G1?=
 =?us-ascii?Q?PAp+Br2TUFOfp/r3094epid4xy8mYBes8DKaNq+AMzAUgTV0mU/mZCaWlYW7?=
 =?us-ascii?Q?1EmyKpD4GX1iuVrzbu/dz3SXjt5IAYCi45jRLFYpQY66QJwtRPTMGAFz9Khw?=
 =?us-ascii?Q?zdKYxisLYNjGDfFofhITnoJqcts/QZOz+YhDjjQ03tfZS6NJ0clt21ncPlks?=
 =?us-ascii?Q?Fhtjjg250IGLJt4tznAiuxZy4uQ5pPCNU/94Dbot7fJDDBKDxN5q5jR5ao5O?=
 =?us-ascii?Q?LVXN+hiLYzDsJ17rx0gdJYIvSSqoVG95n5rmuXBdUyYzzYW/7om0NkJEz62P?=
 =?us-ascii?Q?FIETsaJt6IvhLX8skWsunRIr3e4CHeG0j1B+ec/bVfhRPbwHaFVFv5P80M5v?=
 =?us-ascii?Q?Zh/CcsKvbSqaspU0146aPmXWctaaXIYRaZPO76EnrUzlqyGOJy1eMS6yNqb2?=
 =?us-ascii?Q?NtaGQMGQ3z1xr0Hkwjq3gQyJq7vdZo47G8uy39MqO4dLw55WjoeX71WQStE1?=
 =?us-ascii?Q?DPHIMM53Yaz4mN8+HTh6NtmXP017Gf0i8go/9g62L7aWKO5M9GdZU8CxvZT8?=
 =?us-ascii?Q?ixgLO1umYOyNaxBYUlRW3nDsngj907cZDZ8j2dL40x4dxVE4JFi8bOayJCvt?=
 =?us-ascii?Q?m8w+qidHEhxJzsqG32yCw6gVRjkccTwVQERi6U8kLUGDM4WIVBNjHaA84fyO?=
 =?us-ascii?Q?rQxv10A7zDonk0tZnTnfKNkinClEBvOmhB6DZppz89ZE1raxzHe3unlU8Ruz?=
 =?us-ascii?Q?RnxgazabkhUH39jZm9peWZrg5yNNNEcqzGJHWnSS5chb3RiwM8duIrtBGSao?=
 =?us-ascii?Q?lbQsdGVz8mjG+uUzRadEUPvZj+7ihArCOH60jx1kzcKP5h/B3p4v7FZbgnXw?=
 =?us-ascii?Q?GJu0wXebsROsxkaT3iXAn6jwMYmY9tbO7Ep0IFNnXfGwjUohDeWWsktoEpvc?=
 =?us-ascii?Q?i4p5F1Mwa0jzvxK8yQsKi3ONFxRTh0c3omwx3IZx7C5sZwi04C2Ox+jr5e8n?=
 =?us-ascii?Q?HTSHbAbHLNoLSpUhaKY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44bbdb6c-7155-4037-3ab1-08d9b203fe7f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2021 00:14:07.5217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L2xi5fOw6dVj8XLGT4aUbG58aAdrDMITs1/raskUu7rf5W5niyEATarM7I9lYG82
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5255
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sat, Nov 27, 2021 at 02:20:09AM +0100, Thomas Gleixner wrote:

> +/**
> + * msi_setup_device_data - Setup MSI device data
> + * @dev:	Device for which MSI device data should be set up
> + *
> + * Return: 0 on success, appropriate error code otherwise
> + *
> + * This can be called more than once for @dev. If the MSI device data is
> + * already allocated the call succeeds. The allocated memory is
> + * automatically released when the device is destroyed.

I would say 'by devres when the driver is removed' rather than device
is destroyed - to me the latter implies it would happen at device_del
or perhaps during release..

> +int msi_setup_device_data(struct device *dev)
> +{
> +	struct msi_device_data *md;
> +
> +	if (dev->msi.data)
> +		return 0;
> +
> +	md = devres_alloc(msi_device_data_release, sizeof(*md), GFP_KERNEL);
> +	if (!md)
> +		return -ENOMEM;
> +
> +	raw_spin_lock_init(&md->lock);

I also couldn't guess why this needed to be raw?

Jason
