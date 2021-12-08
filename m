Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0061946D760
	for <lists+dmaengine@lfdr.de>; Wed,  8 Dec 2021 16:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236324AbhLHPy6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 8 Dec 2021 10:54:58 -0500
Received: from mail-mw2nam12on2068.outbound.protection.outlook.com ([40.107.244.68]:8896
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236310AbhLHPy5 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 8 Dec 2021 10:54:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kY0G6Zm47GMAJceB2SGeMH4IoTa7S7djXvm0vi1zJH1G1anxJKI2S4kaZyB8iY+2lcjO7O266m2Ibo8vxRkHr+8Cul/fIJRzO7G1TiohAszV+2iwB1x2UGYrjaGZ/cOW67HAP/qcNQuJs8behChEGfxzbDKb2DAfjbP3G1UfHS+ZmVa/ztJHcfU2J4dhSu3q1laoS8GJwbdTa40G625fUplqxzf3k6Q/i7j6yT2JdQTTOvdBPSJIvwlxl7xaX4IyFfKV8S/gibTVkUsauUlXOJua026CuRnDDSfX+0Nqm+JSLrTto7U/7DcP0pULYVWwypesEzbs5JrqzixcNEBs7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s348dqgICSc7yc8kd+csRUb+Z7Y5Qb2f67t8v+cpqVA=;
 b=Xn7+yNcgsexG4ZNFuUU8o6XmsOMndZaItMfL8fnKmJyB7fMeE6rD4a96TKohqhtyNATFMukfquFeH94d7vWsiPlz27A82XU52K9u45ZQKdd9qReR4BXP4uqXg9fvWia1XAyeEE/rL2q4TvVnVRNY3fY8ZRZuiiGv1T4XMUSAcJ1NfxL+FvnKUgjkd229aeRfOqlluRKciiOeY6Le+6bmwbc8HlQoGoIUl/hR5m53K0LNoSRTobZa3AksD2ReQmkMHJ1P4MgQIiqc3zi+OraVrx+WOmtM5YGKpWw3+40Uf53vDbPI6+EAkZ1vtwpM2KXXA29+TFbw0F15uvoV7LZBbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s348dqgICSc7yc8kd+csRUb+Z7Y5Qb2f67t8v+cpqVA=;
 b=SHX6bn5yxH4nBdIdtC6bJRK9LmOS0i6qYvX0aBjWvciekEMDOVvvVYmYU9sUnmwKEkMONMkq7vInjVMJGZouSw+O56OLMhHHblMKexduO+eo2i1V7PT2JoipageT7v/aKK0lzNtTbdLUlvy0wCUXShpFCm/FmvPgnFjo8mXHwqXRt5+eK4cJ8gTYkXgqoK6fV7A9LV48Nz6po6RPw86zJFpHRHJki3noPV09cQjt9F6bHLlzHEOQKmSyQBjr++RG5aH+kgdUmyFktFDIZJ4YMlh3bO+FreHal5lfKlK3ZPvL6wNu9XBTpOrTbDVTy47E6zr7/ihEbM9vTY8MQF6ZsA==
Received: from BL1PR12MB5189.namprd12.prod.outlook.com (2603:10b6:208:308::20)
 by BL1PR12MB5160.namprd12.prod.outlook.com (2603:10b6:208:311::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.19; Wed, 8 Dec
 2021 15:51:21 +0000
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5189.namprd12.prod.outlook.com (2603:10b6:208:308::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Wed, 8 Dec
 2021 15:51:20 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%7]) with mapi id 15.20.4778.013; Wed, 8 Dec 2021
 15:51:20 +0000
Date:   Wed, 8 Dec 2021 11:51:18 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Cedric Le Goater <clg@kaod.org>,
        xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        iommu@lists.linux-foundation.org, dmaengine@vger.kernel.org,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Vinod Koul <vkoul@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Sinan Kaya <okaya@kernel.org>
Subject: Re: [patch V2 24/36] powerpc/pseries/msi: Use MSI device properties
Message-ID: <20211208155118.GW6385@nvidia.com>
References: <20211206210307.625116253@linutronix.de>
 <20211206210438.967630948@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206210438.967630948@linutronix.de>
X-ClientProxiedBy: SJ0PR05CA0164.namprd05.prod.outlook.com
 (2603:10b6:a03:339::19) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08eec224-a9ff-4738-cd24-08d9ba629428
X-MS-TrafficTypeDiagnostic: BL1PR12MB5189:EE_|BL1PR12MB5160:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB518981CB1F689D384A7513D7C26F9@BL1PR12MB5189.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VCqGL0o0dzwUbbMYtl0SXKEqmDeUvriX9Z+GvFis7dXZPoNLN529CY/pq6f5mmzJFrHU49V1fUpfpnlKvcJo6+9tG4Y8O8g3qWWeP0s/Gs8dSIVPpGHUDKJyA2jjbAhYSgkZMByQOMc+C9RzXtlUhCdRVFb1FWjRDk959zdO+d5Gzup/YpxD3pJd5QGw1RG95fz1X90qiWSnSu6vWaRrQG/Eu5DnXd7x5yL1A+2oMHvpYHzlEnkJkejfzv0vqKqRduI/ux8SmxCMwBaDoWc0XiLh2maLrgNZXKVDiwr4YU5kH2Q0I12MDUuoRTlH2c1h9y93BEgOLuii/0WeNoh1A2qTTC57pZd36lZKfp0HLSzV+DiqqZXjOwJ5uwJFuunvzbee/axYJiC7mwq03S/PwtguNqcUKbC0xGx0SFdY2+/mOobDaYUxw14fFZjNwTN28O+FZp34vY3cHi+qtxvmkwTt1VsyAnxrsOxc4LMwb8e7RLYOGUC6BsW7BXOGLAGwCZsy3GCHnHAsOp08OA1wlUS0iEBk9OnwfwuJ77a8+UJYuv2DGu/O90wI2HfrNWvXcKpnIRF5cAbf7boR/cKcHGxSWuSy6cF8CLK9naQhPjMbT5xpKhVzpI4/Ju1kvLVnCLXo5QjCaAabXqDeVHazsg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7416002)(5660300002)(186003)(8676002)(33656002)(4326008)(8936002)(2616005)(6506007)(508600001)(38100700002)(26005)(6916009)(83380400001)(86362001)(316002)(36756003)(6486002)(4744005)(1076003)(54906003)(6512007)(2906002)(66556008)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nY99BlSX7EPurIJ0DhJ4K6f2jifD5yJUaDogsJAS5oVyyJK1VQHwpPYWwfEC?=
 =?us-ascii?Q?yYG3+B2kBS3Y24wHwcM/qPNU98SBtDRURPMmdjlCYuYzL3mk4mOz3irTJa2u?=
 =?us-ascii?Q?yzBv8Nv8jqvEJkzYlHtWmV+70WvJcdJDZdSx0XITebXaZCAK5dfftnrcmNOi?=
 =?us-ascii?Q?/YM4N42f7gZo7cassvjt1dl74hhh/mt0tlYxiuwluD1fgLxzCiJFpZ70vACO?=
 =?us-ascii?Q?zti7j+C2q4zCAcpA5rT7rpZ4QH0HbYqjOefQ4ZC+QGfnDmq4HfBLqERI6Gsd?=
 =?us-ascii?Q?cxKk0yIWll1jJrpeXXofwnm8lELo5ObqBOaQyelhagZwL5C3ag+q8fEwp1gx?=
 =?us-ascii?Q?3ecOG/o7+Gyx3lvA5HgOVriRMBOCl1vA2e1TY5RMGW/gaCaIagp7DDREePCW?=
 =?us-ascii?Q?PMvTgFyveK9hakcH0e0n9U6bwGqwQyC5pvus6FODgXOFc2Dk0dbrNxgbp/SX?=
 =?us-ascii?Q?OGkNOm3pF7Uc+7lO4tGuNZCAHQ6sk5vgT5YZbhfZmSpXL7rw3xzfReyHGjeL?=
 =?us-ascii?Q?7U8lRmExV3KdQJ3nQ0oNRxUdCi2lJqyv4v7x3wQ7AViAS4tkTzrjd5YC4Tyc?=
 =?us-ascii?Q?KV8QECRsyKgluEuZWrPfGA/wZUyA7m/aN3dx3B+jC9h/XbkfdvdHGR0mvHRM?=
 =?us-ascii?Q?kdFggDFIbYeKoJj/0ANwjvm4VgZbRwLlcSiZjquug5ioK33cYTbcz6aEfcbA?=
 =?us-ascii?Q?WWKbXkfoGiPIbOktWJJWtVMaT3Rm0vBdJRJBq+c5BrKMPA9Ha6jWk/wcP/cv?=
 =?us-ascii?Q?lZ7Vtd33/EgfQNYH/RtIiAmssI6NhflU2wbB3PCFftjPOmE52++8IzPfKfqE?=
 =?us-ascii?Q?KllrkM8Tm3Mwb/q7M0dKkJ60/CCt6ufFyhJi9MiqfY8PXDjLsQ0ILXRqErEL?=
 =?us-ascii?Q?x5oCETlb5pvJx8jnpQX8WEDmOVA3jnUQ/Aa5Uvt5eGogk1filUZu2GcpE2mO?=
 =?us-ascii?Q?uts+14sNYh2jHBhAz6g4AeI0JaYV44beFvoRRiOD8HC9vhZX5qrEMN4NefhJ?=
 =?us-ascii?Q?v1FvyqZIfiOjDRuIn7d6BNLlFMwtPoTL2Swg/AdGlcYykKzbho7o9HVbxVX1?=
 =?us-ascii?Q?Vp1ptU4Rcjpk/hMzRkZRlaYG8Ukamyzhpt8QYRFPmnu0TZSYwJLcyssPtC7V?=
 =?us-ascii?Q?KnIAyXz6Vcg6/UG8tUXrcBZEIAE4VpTj6YsTqFCKLEHko3GBa/6UGrU1VdLk?=
 =?us-ascii?Q?zzg/7BB05pnPOVlZJuUJMcKMZRhpt7c+Aju1mJSgI5CwuM/jzt25DkQAN55r?=
 =?us-ascii?Q?E8Nkkk9Y/Fuj5pN3sgeUFlL0XUqSGAFTJyHvStZCmILQqEznIR6QPIs8pNdF?=
 =?us-ascii?Q?At0/9TDLbkUkLRZjs/atuXxzu7TQgKaPjdUi5vpTQveSa0PGRKnndah98WKO?=
 =?us-ascii?Q?YNynFI1u8JcmjZmVOEKkkMx5pTBLx0rYC+HAbFzwCVTyrtK1dfdJPvSki7FE?=
 =?us-ascii?Q?UhUVWsndfNs//1gjdAb5mj4O/pA3tVfjgfatM4H2637f4rPNi8l6/VnLdYXR?=
 =?us-ascii?Q?o9SDnCwJYduoVadyvJjTqaQNxiMH1IGZJTFx5B+ZIJhvJizoc1wlJ6ciypP2?=
 =?us-ascii?Q?cj6VYWZwIyGZr0NhT2Q=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08eec224-a9ff-4738-cd24-08d9ba629428
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 15:51:20.6617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4LtoikyL2SFNcGJqm9Vjd9iRvQA/N54LSatbf3mvYK8ybnzLr+MKENqYbbBEHszW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5160
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Dec 06, 2021 at 11:39:34PM +0100, Thomas Gleixner wrote:
> instead of fiddling with MSI descriptors.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>  arch/powerpc/platforms/pseries/msi.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> +++ b/arch/powerpc/platforms/pseries/msi.c
> @@ -447,9 +447,9 @@ static int rtas_prepare_msi_irqs(struct
>  static int pseries_msi_ops_prepare(struct irq_domain *domain, struct device *dev,
>  				   int nvec, msi_alloc_info_t *arg)
>  {
> +	bool is_msix = msi_device_has_property(dev, MSI_PROP_PCI_MSIX);
> +	int type = is_msix ? PCI_CAP_ID_MSIX : PCI_CAP_ID_MSI;
>  	struct pci_dev *pdev = to_pci_dev(dev);

We have the pci_dev here, why not just do something like

   bool is_msix = pdev->msix_enabled;

?

Jason
