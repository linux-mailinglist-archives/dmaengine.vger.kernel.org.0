Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D44E472F01
	for <lists+dmaengine@lfdr.de>; Mon, 13 Dec 2021 15:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbhLMOW4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Dec 2021 09:22:56 -0500
Received: from mail-sn1anam02on2088.outbound.protection.outlook.com ([40.107.96.88]:18115
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232048AbhLMOWx (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 13 Dec 2021 09:22:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bkm/97cJcKtiN5wM0AE1LG2we381O2MZ/R5ios3b8HJhroi9mmIpiNR9clxZ9h+sliK+3vy5r4KOnwcionVMfXgB/zsROv7hEWuPQpeLIo6EF1oqZpHmcS48YnsxOCFXm7/lPHijcad6Vaf5DcK2//ZpRzyvCKszsUIvCBcCyZKGcF9DZyFY93J0G8crUv05Cvpu35mZed1+NQbWKZ9joZ3nx9NY1SkAs4axAgYrkIZzjHrSCLBTZdQ19F/OJ1BuO6gee4azX4zyt3Mgx26Fh3lhk5cwzdofVsDNEbgKbqLs5b4sdV+tpZWVabaGw1kcoDYFYtN2vl0c3QkJvfz+ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yK24KfMozkMUMHxi4t/9xmHkQORWks/mpdbKTi8KK0E=;
 b=OL7qjTl+dPlLoYJvA9SGNwHscRx7Hd71VvgaSdNptbCwrC9+1WAdrtsVU0SHG/waJcOLCUwDC2cIJyAtDJyAJSRfyB+/SobJcZZNpwFTnkE9ILGo8de65gbRottbYA0FG07vurN27aWhwOkfRDqRTGC1PBClKLvaSj6RI2236J9YWmJJ43bJGxYK2dN69lgV38C4jHoTfc1y8Uxr2NawqPhxEI4k57cW3kwuGDiMP21iSOgVKxkDEm+IJkS74qSWND9YmnhURO17gnsYQ26O3L3bIHvKb1HWs3eIJOQ1LSkf4LFrefQe3e4Di9Mv/VCuHjVI0eJqqOfHc6X4YeOX4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yK24KfMozkMUMHxi4t/9xmHkQORWks/mpdbKTi8KK0E=;
 b=XO1MLBuYgdCfElpsLqvnvqjoTEiKQTwPXWaLY4cU9oW5OrBNNdEBw0R7+bXOz//a8c2axPjSFPX20qRjDWIaERma275CxfI5JL+YebWWuXQeT8PlsqvPz+m6glHmtF46ZP72tSQXR1EZ8hI7huNwhBz0wPt85v1IEGIG/Nku0zaaz6NHjByyG8THavFHWAkbiVnw6U/MF2LC05HQ60Cu8F511DzgRPpBukRq3IXA9cxs2JmsHONSTpVmRIAF8f23kdsPIJKc2HfSFMykmPllWGXn5UaZgvRc/wtYIljy476QfbaqzjT1IBGD61D/zN9o+WQ7+lHJskBVRMTBNljeXw==
Received: from BL1PR12MB5350.namprd12.prod.outlook.com (2603:10b6:208:31d::23)
 by BL1PR12MB5127.namprd12.prod.outlook.com (2603:10b6:208:31b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Mon, 13 Dec
 2021 14:22:51 +0000
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5350.namprd12.prod.outlook.com (2603:10b6:208:31d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Mon, 13 Dec
 2021 14:22:50 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%7]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 14:22:50 +0000
Date:   Mon, 13 Dec 2021 10:22:48 -0400
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Juergen Gross <jgross@suse.com>,
        xen-devel@lists.xenproject.org, Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, Bjorn Helgaas <bhelgaas@google.com>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Sinan Kaya <okaya@kernel.org>
Subject: Re: [patch V3 26/35] genirq/msi: Provide interface to retrieve Linux
 interrupt number
Message-ID: <20211213142248.GB6385@nvidia.com>
References: <20211210221642.869015045@linutronix.de>
 <20211210221814.780824745@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210221814.780824745@linutronix.de>
X-ClientProxiedBy: CH0PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:610:b0::25) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa1da8c5-cae6-4fb4-22a6-08d9be440b21
X-MS-TrafficTypeDiagnostic: BL1PR12MB5350:EE_|BL1PR12MB5127:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5350E370413999F60386C546C2749@BL1PR12MB5350.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 35Tpxl4cHaUSO1IhKQCml92Pwk9LFdtamtoydMjJDziXfMHzuC6KsBPNy5fJS+zDhw2Wlh+IVt9NNhruvoItwT2xBhZoxUVZi1U1GLLsCDZXC57zNd9mbesNaJ8sFf/v5y/YkiceG+ao9Nc8on00GG+Ar0dbzGlI21QZAxu88aMUaEko6VontlldfFSwUU2xtcxddntVzSHihKCatDJrPztWEqDIzwjpNe8W+DbWRjTpsPDWQemS5z9T7A8ROAYp0ReIVPUzfaQ4l81IZoFvmQfx+/jW2htHzza73+yVOdG8+TwCHVFijXWMKTXPAjuNmNvYxj8b9Y0pK0Fk6zLLDLo4ydjIpyrV9RatB4qWaMzW0D1miiiU/OONmwVY+ZMwe9bMBU/5ceqFDvNzV4tM8bPHtEVChQ5kM/AN4XVUA1K52gRxNAXP0DSa0dW3kUkSjbtSuBKdgRvU2pkhUFW/ICzci+a3X7r9W/2cOmkWFvsxijCV5S2/JGaPkZbd4AZ8hSzvLCk3GIR99VXAUFYvvkJCPS4nfVOVgztg0uU3gdlWjqDP2ufN7e23gw7Z6qzCW1J23vFBv9KW/OGOByrSOn0hwzbOU6z3AGRyN9B8IlqGe8OAb/fJtNdLiH+tYVAab68oQWT8QiCTW5IFup+GRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5350.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(38100700002)(7416002)(1076003)(7406005)(6916009)(8676002)(54906003)(5660300002)(4744005)(6512007)(2906002)(33656002)(8936002)(66946007)(4326008)(6506007)(86362001)(66476007)(316002)(66556008)(36756003)(26005)(508600001)(6486002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w07Q7xHudYgP5K3fklSjRYjabRdXPY0DZua12bI9cKqWSiXmAcBTMnnYsiaM?=
 =?us-ascii?Q?awQtxVHYbG91DXomgFe3Y9/s7hWNUfOrJ3WuNwWWmQpiVg+vXZ8eU/vOixUC?=
 =?us-ascii?Q?ve7U9DQI1pcp6RoxBav6IqDnNUs1fVZ8Jh0QzuYD9AD7I2HopxhiHnaMRxx1?=
 =?us-ascii?Q?pNrVBIdsLDGHHOBs1m8hwRm/huMDrCGPvCVyfRBjt/Zujutsfq6ROt0pmjEH?=
 =?us-ascii?Q?nGSmzS+KtGyAucHVkKnNspf5uTOkl8GIFd1rLB/d7EtH3T1Xw+WYsE+q2CSJ?=
 =?us-ascii?Q?kEDfg40P6ZTdiT0mAD+w2IzkCm9I9z+RBUz4zKlrUsJQczQKIcu6DmFyeG1Y?=
 =?us-ascii?Q?HX06i87iGo0wnd5p/fyKi4xGeCcMnfTHlSN2clQ25KZ8FxgNG+vho0LQL8eo?=
 =?us-ascii?Q?Rmyt8VHbhdDRHQjblaqFbSLCggRF6O3hgTa4Hw5MXkE05wOMsEuLxQDSGwwS?=
 =?us-ascii?Q?AJlwijXzTK2eXLcXmnDNGfoXGsh4DnsOfVLadaDIumdSbNoi+h17JNSvea2b?=
 =?us-ascii?Q?ccG7Be2yFXv+nONCC0oFDkNneVJdZwqHDER0CZafmyoW/YXepU3ODAD2bF2J?=
 =?us-ascii?Q?hsOhfF+ZIkL5Z4+4IUUm3YjKG+nwlo0UwSbe6L8S0xGxc4Bfcx6LB5bJyVYl?=
 =?us-ascii?Q?Yf+gK+Q6YQaBtksILIKsktz+kV/rRks7UyPgWi8rjtNa2Ecuhr80vG+vxoVu?=
 =?us-ascii?Q?Iqscg2kv66oCEY/YULaHY2Lb2Xhn4fGGfwph2G6Hs6Rn4b6b2i6I8bP7tRsg?=
 =?us-ascii?Q?dpHi0mEmryWdwfDBOFu4EAM1zWZwec/A3ZZNzkuZEOVR/cexMQftqK4Q91Gg?=
 =?us-ascii?Q?LYVPbXcYvK4aaMSoeBRLkk1V5fvUvbxM0NDnxVCgpdyd6vFravpyHysMEh7k?=
 =?us-ascii?Q?kvRrZsvPK2esmZsBUbcNGrsMSAfCR41XDaKP3plD7WCcvSyv6WkJz4ukScLc?=
 =?us-ascii?Q?3T+xpMJf65nFycz3WyaO/p/D0ItVYV1loLsyuC3pZC7pbwgaLguEH/TLPdnB?=
 =?us-ascii?Q?JNF+2+MK18uPJv54h+Ku51U0yJ0dsENrz68Gb/65uVmuavNhueDY2L1NpPj3?=
 =?us-ascii?Q?B8JkB6fCcUVvgeX+h6uZTYV6IYClvAY+NKHzcuiOuGqqm/6kYyaWbuFpENyU?=
 =?us-ascii?Q?LVHbfjkTAuwW7DUWHgc2xLaVmGlvDijWbC/W6v3kCy65lDq4TNob7qM8mPwb?=
 =?us-ascii?Q?mLNkiV7Ccd/TjFkLJ4wRzv2bRKx/UaXvhz0VYMIy/OywlVzDSetKqhYrLSxt?=
 =?us-ascii?Q?YW4UhuHDX/3tBqTrpiGw8GQt2T+B1YawaqB+CRuPoqIokk1Jwn5yXPka78U2?=
 =?us-ascii?Q?tjNZdmH7d+OnF7qDecmvOBYWp5cHl1LWjPQi0ILdNscRYNjVYwVI+D31fEaA?=
 =?us-ascii?Q?PH5saITWlTEyc/3e146a21NcIl/ScQ80ACXdD9s6KTGqD2J1qhAa6WZ1LzEb?=
 =?us-ascii?Q?up3vk12JMlhambWJ5vc86CPORoIc5WRGtng96lTAMAWNBoshRKAYV8bN9437?=
 =?us-ascii?Q?KXdpyo1hr/CN34v/F8IGsQP1VCLb70RDyGnWuC2jBML+EYnz+vKn5KdWbVgi?=
 =?us-ascii?Q?AnZj6NclHG3QKE79Uw0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa1da8c5-cae6-4fb4-22a6-08d9be440b21
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 14:22:50.5744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JapLzHME14gHzXjZlQNHkEcieJbQiuVCTbkP7m4IxstaQCCH8qZeTkkbUettVX0t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5127
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Dec 10, 2021 at 11:19:23PM +0100, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> This allows drivers to retrieve the Linux interrupt number instead of
> fiddling with MSI descriptors.
> 
> msi_get_virq() returns the Linux interrupt number or 0 in case that there
> is no entry for the given MSI index.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> V2: Simplify the implementation and let PCI deal with the PCI specialities - Marc
> ---
>  include/linux/msi.h |    2 ++
>  kernel/irq/msi.c    |   36 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
