Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 955D946D76B
	for <lists+dmaengine@lfdr.de>; Wed,  8 Dec 2021 16:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbhLHP4w (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 8 Dec 2021 10:56:52 -0500
Received: from mail-co1nam11on2040.outbound.protection.outlook.com ([40.107.220.40]:62817
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229497AbhLHP4w (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 8 Dec 2021 10:56:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bPoI9M8FsMEfUdP/lJaGkIu9zGmEvn5jCzsN39LhwfCxbZgJ1fhoJvPJEHu7j97fkgrvFL//5sNOwdEl4zoGJ+/b7mAmnuYRgWNWxx7klaBbeBL/hbXuPmW8zxbM7H7tPBln9RQ0dta7CD0ssO8UNSrctBlJdtjjk3A5OLZeltmazrbtb3R1UlXeY3MHcEGgCYm++cs/UceksA2v4Y96m8Ga72pstP0lAzHqG99UMi2Mlo3jqrndJ+wpBP4qBcCWCELFim64e144KLci83eCVe5A8xmJP28diRvmYYhejlbzPNuDurYP3k26LBIgEIciWqyt+ZONrAkvhsffWKscQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tppcOWK/iYgP5gOW8nSiftuOjDZTY+zjbu0iAuHUUJ8=;
 b=bbMDwzO893FmmO4kkYUe+ti63WC6//Ikg/ovjtzy8S2RwcwARm/C5peLaBlzaSO27VY/JVO28MRnjavwk4+nFG7cUgNOGxeDolFmqUvAN4oyuVz6mzjwl9DYcXw5IFK4g3PDH/0T6pzflt3d7LO0YPnb8Ggwdk+Bca9SDQnj4yysJ4Xvf5XsnbJWt6sogBQAZCoYzmXNQU7juzFWIG5boCInY3ALOJ/XcZALh2SuPzFzBq3H+kja0e3Zc+ShqVOshPt1ghV1PKcIxKbI5rqesggo//a+G+wTxgJL89YW6aoC8PTqyGEdrZgBsvCgJpBnWiE5wdWR22HCSiqnYhudGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tppcOWK/iYgP5gOW8nSiftuOjDZTY+zjbu0iAuHUUJ8=;
 b=rXsM27sXMEqyW23/RKjKbqbdiwHov4gMtJREF9oL60X6SMm3D0AVcU1E9svRyja5EJ2CBZGdyDiFX0ItGs6Gpt4JJOkceyRcMkd8avP/rW9jS8IVR+UHhZQJf8yOGV7ftkFvpSvTGNoeN7Yu+FxAIVkBqWEXzv4dGlcvfOXaK8OC2kI/r9+SrQGhVG1aQZMbCyqXany77Ne/JdoooOMqdjSJHdmr4VyTVD98BjmIzWVovGI9Iq0+YeXqGx519h+L6TM1NN8jEPZZk+IafsVXT27fudRwau3RTCXYnXHunFUViAzh9WLkkCKCpXdITobBTqOan3DpIh/cF+XyFj2HpQ==
Received: from BL1PR12MB5191.namprd12.prod.outlook.com (2603:10b6:208:318::21)
 by BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Wed, 8 Dec
 2021 15:53:18 +0000
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5191.namprd12.prod.outlook.com (2603:10b6:208:318::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Wed, 8 Dec
 2021 15:53:17 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%7]) with mapi id 15.20.4778.013; Wed, 8 Dec 2021
 15:53:17 +0000
Date:   Wed, 8 Dec 2021 11:53:14 -0400
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
Subject: Re: [patch V2 20/36] x86/pci/XEN: Use device MSI properties
Message-ID: <20211208155314.GX6385@nvidia.com>
References: <20211206210307.625116253@linutronix.de>
 <20211206210438.742297272@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206210438.742297272@linutronix.de>
X-ClientProxiedBy: BY5PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::26) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43f9df46-1668-4fa7-d610-08d9ba62d9a0
X-MS-TrafficTypeDiagnostic: BL1PR12MB5191:EE_|BL1PR12MB5112:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5191BA1792AA41855E031560C26F9@BL1PR12MB5191.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tfKqL1Eh6gt/aJUT+Jk9Jkog1K+2le7U7i+UM6vEx1fr9oykw5VliXHuas3QP9Ve9+Usy/eQNVTiaZUcLZ4TVwLriCr9hfLczSGhVWdHgXzIJUHwTRd5FDqgkpnZTBZM2Nq/3cQ+PqEQ+d8RKiEMwFP7BXecw9h+jOmt+lUDkNQ2nqVNLIruVwBGC8Tpxhb9BUtAdJOH4cEoASzEGO85AqjF1zjb6As+kRXO+7y2ZU4gxN2438eXPVocvJqZx/0eagKFLo1LqBCi3vDQOzhYQADyN37lvrTi4I5SNG/CQbjOjTOKEzIhgz+cgRa7qZw1PjlbX05TpoEnkY3Qa4LIsXpuAbo3eVNYdS1b6yg8CM2e8clIzYvLH0PKcEI1QSWAcuEWmXScuXmVF8ZEUMS451zzjRnhp4Zb5H0t1I88b1Tndi7R0/6He17yrGyJLfNbokzdMSvlV+/3HLSWynqf+VgdQv/ZHg6/jWM8cZGwXhfICAoEgRuF2aMEGp+CHNjNQJK+XrT/rcIN7yM5u0hihMynIjqNGyoJN9579FIOKc+rk7rFeLgsKHvKM8AGMm0V1e5zz8/z+UKDs6HThvzs2Zg/VdGkBVEWyqEVISjf5UTPZjHedVqIpf5A7O39+fyfL6LfCY/FdK92WMzznvWvZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5191.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(7416002)(66476007)(1076003)(508600001)(5660300002)(33656002)(6506007)(2616005)(66946007)(6486002)(6512007)(4326008)(83380400001)(6666004)(6916009)(2906002)(38100700002)(316002)(186003)(86362001)(26005)(36756003)(54906003)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/Mw5OshZas/5yQYnYiSsLmUIdxOR1fNgwqja5eEqlKcr0nIA/i3TKThMtR1Q?=
 =?us-ascii?Q?WoXZ0CIpHgPkHOumqIg9l1/oAskqbB3PdBB3SZyLtfJEnmukwMEJvnkEq1CR?=
 =?us-ascii?Q?C3bUTFDAsZ2y0jySEHfeqM/a2D4KKxs+ML17NUQLbDv6NZ7R7AlsgOVSQ8Lg?=
 =?us-ascii?Q?5LG/69xv1j1961JA8xqrCVuxHhZVuBINKVj1vyRs+4EpIMgzk52YY/c1Xn5P?=
 =?us-ascii?Q?rRmxuZKN8AoDJfO438Zs/OnI3LK2nOCZMvbYqycptFXj8Kwk7ULCXa7iDhMD?=
 =?us-ascii?Q?34fYXg9+8znhFC86q+1Sx5lkil6omRIcRR67WVRml9hNKR758T9dt6kPfY4E?=
 =?us-ascii?Q?ai+3X8A0xaoVQ0fhyZ7QPIzRMm39/tiN1xfITM5RprVXVtCOUWLVzXWBNotg?=
 =?us-ascii?Q?Y/IvPsWEV5/Z3w8ph0CDahTXfUqR2mujkea4s/J4HeoTPB6kkpEFhlMKM+gr?=
 =?us-ascii?Q?wQgolP/LZamlKl2O7grRY1T1OMvKyfjTOxcjAbVmyImLzaEOlUl0ZPwDa7vv?=
 =?us-ascii?Q?4kryUFgzKAT5WyIPCN2k6jPHypRBRsjsjD2ZYKk8/qus9iIS6fhi+OmcCG6g?=
 =?us-ascii?Q?SavVQBwVr/D9el0zPdoeG8WIjUlWq6NCECKujZPAyi3cUjuXCFj+Nzl2M3AO?=
 =?us-ascii?Q?9oBcSolEBMsvEZRrHNSQ5SAwMxDLothgXu2m0rEMbZtp3nLmMocatVzrW5PR?=
 =?us-ascii?Q?Yu4GUVUwX0yTJzeKdnk9YOOn5deH7y5dLf3NaipZvBsgAUpWbkqpOSyckPNS?=
 =?us-ascii?Q?Yw1xmWft0Nj8TntmvEjWmB07C3ocztIIiddtV3cne5egHr3GflcZlkbs/R0a?=
 =?us-ascii?Q?nCBVDdBPVPp6jMcyDujYOW4jLbj6QizOLxd2gl+7PkqZhWS/c8gcFHlv8FcB?=
 =?us-ascii?Q?HaABwIqqawF9q/R0mcjCclIBsrMnHqPooLsg6x7/l6KBt3j0SUE5PjiwZnYt?=
 =?us-ascii?Q?quSM7Te1lFORv6LKJXhsZn4vmxeillY9+vJcvxI3Q0HINXEnPhmL7E6H/CDh?=
 =?us-ascii?Q?i7tg8j1LARChRc0iXmqc2ighQTLVokOQoMZqrTeSvwJUdVX09Y7C/axEeCg7?=
 =?us-ascii?Q?HcubfyXHM9pENNV+bLvJJjgNjVK3G4IHu/87Uz/5Kat/2jXXRNulDQONiZYD?=
 =?us-ascii?Q?qselEeHSjWaetRpPJye1fyVNYfdtyxkUO2xtzrqd4Do0po70T4CJBP/xhswK?=
 =?us-ascii?Q?3gsxlLSVLaNZI6U8liKBVASyrwuCtoOHR0cDLPsMHAAgiIdifzWVbt+juZE/?=
 =?us-ascii?Q?aQ+nCsvX++tQRHez013BLtyE4SCXYwlX6FZpH4VyKe22M4PFfisxqRKhubKu?=
 =?us-ascii?Q?fEVASUrI7jRKiZ26NtbOawaBd+0QmvAKCwnzKKNbtkmCOc2yNss6ZAhxloRv?=
 =?us-ascii?Q?1CCyQTtyu2FmCHe9rLlcb4rS4FkVDbsGC5Erl0niz6/hKcKlhwNPJVtoCYKN?=
 =?us-ascii?Q?1re++Ma3FMzxFP5xKtVLlPiI/ziTDXMpibzr1Z+xk0SpM/FYu4wmK00cZAuv?=
 =?us-ascii?Q?8YmQsIzXh8I4loS6oB/zLRlmgZ0O1xv74YGNGVfQMsxESZpm16Wvw9KZmBKi?=
 =?us-ascii?Q?ri0mUpsX0Qz+0uXqiSc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43f9df46-1668-4fa7-d610-08d9ba62d9a0
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 15:53:17.2424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uAH1bFkRGXLOaZGNzvkVMqJgZJFq9xfcEU+d9QzbuL4Om25nvRL111rKzHuRt5b2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5112
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Dec 06, 2021 at 11:39:28PM +0100, Thomas Gleixner wrote:
> instead of fiddling with MSI descriptors.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>  arch/x86/pci/xen.c |    6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> +++ b/arch/x86/pci/xen.c
> @@ -399,9 +399,7 @@ static void xen_teardown_msi_irqs(struct
>  
>  static void xen_pv_teardown_msi_irqs(struct pci_dev *dev)
>  {
> -	struct msi_desc *msidesc = first_pci_msi_entry(dev);
> -
> -	if (msidesc->pci.msi_attrib.is_msix)
> +	if (msi_device_has_property(&dev->dev, MSI_PROP_PCI_MSIX))
>  		xen_pci_frontend_disable_msix(dev);
>  	else
>  		xen_pci_frontend_disable_msi(dev);

Same remark as for power, we have a pci_dev, so can it be dev->msix_enabled?

> @@ -417,7 +415,7 @@ static int xen_msi_domain_alloc_irqs(str
>  	if (WARN_ON_ONCE(!dev_is_pci(dev)))
>  		return -EINVAL;
>  
> -	if (first_msi_entry(dev)->pci.msi_attrib.is_msix)
> +	if (msi_device_has_property(dev, MSI_PROP_PCI_MSIX))

And this WARNS if it is not a pci_dev, so same

Jason
