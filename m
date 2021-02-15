Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED0C31B5B0
	for <lists+dmaengine@lfdr.de>; Mon, 15 Feb 2021 08:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbhBOHlE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 15 Feb 2021 02:41:04 -0500
Received: from mail-dm6nam11on2063.outbound.protection.outlook.com ([40.107.223.63]:9409
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229595AbhBOHlD (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 15 Feb 2021 02:41:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B6NSMq6zVhAUjORCyHXZtXmo+31Ze0w/JUry9RAenV1k4qhdMIgvG2/io0BfGdpI8wdC1ls/riF+YOXNzBKB9vJj8at/pp2S09HPHXyTqsamC97a8Epwq2DbmKZT0CN6SbiGX22PU7Zvef6TqbpWsnovat98EAa++KF/fvqiQuxdi+1EyMyx8dprX5V5MhHJJWz5/qp2DGoSy5+8sXjHjS8W/gKveyQ8OGeQxsBs49V2NfDx4IPivYxSq2WnCDiH2rscjzaVHhfymmug1BXbthaWg1LucmC1EGm39HOdm7DAkuqS2vK5nhkh6RHc0LRPMzmPbxZNlV3Nck3OIbN2WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iy1ma/CSQCNGjGBNkIrJ5mN3/i2iYqTNM5dM1SzrWb8=;
 b=MMqjrEg9KsF6OIru5ezzAwYA4/I7TlROoRikPCpFV/VLnV873ukjokAim8aDzfwPzKBdt3KjQ06DyP0Fx0kXDcDCqTtHUwoua0Iu4TSNeYuPJTS87mfTmS73BmOhW94PU0NvKgaZBi7nrkgRpag6OHq3iGsrMFdWoHc4c6c1YwNs7owiWlvlfDJx238Mr1TYSIbuaGalKo3FaR5r42DBs2gQeO3IqNsbUtc25MlKcA6thzbWlO2s6999h3J8KLccP++CJsJlawWi4crLFfpK3xkXp60P8u8k7ZdhsDzOaBYAp1xPVaUGXozn3d1av4AjVgQV+AHAa3AEhH/oCfEo9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iy1ma/CSQCNGjGBNkIrJ5mN3/i2iYqTNM5dM1SzrWb8=;
 b=R12B/2hWPhe+f1EQmbdMzHRMp57DCJksbXnV0hHULugbobkJMZ2uyZtm8MUILiDl9+gH857LFwhxRCPXzXlsweV1wt6k+qvZTi4JIuA9A+96AOIbrcHlAvVip+gJ+GEBzpsSdf2v1nG4uq/eKntIrkzos83XMgOjOtfXjVaX494=
Received: from MN2PR19CA0033.namprd19.prod.outlook.com (2603:10b6:208:178::46)
 by SN6PR02MB4445.namprd02.prod.outlook.com (2603:10b6:805:aa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.26; Mon, 15 Feb
 2021 07:40:10 +0000
Received: from BL2NAM02FT062.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:178:cafe::7) by MN2PR19CA0033.outlook.office365.com
 (2603:10b6:208:178::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27 via Frontend
 Transport; Mon, 15 Feb 2021 07:40:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT062.mail.protection.outlook.com (10.152.77.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3846.25 via Frontend Transport; Mon, 15 Feb 2021 07:40:10 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Sun, 14 Feb 2021 23:40:08 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Sun, 14 Feb 2021 23:40:08 -0800
Envelope-to: michal.simek@xilinx.com,
 vkoul@kernel.org,
 dmaengine@vger.kernel.org,
 laurent.pinchart@ideasonboard.com
Received: from [172.30.17.109] (port=50402)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1lBYUK-0006b6-Je; Sun, 14 Feb 2021 23:40:08 -0800
Subject: Re: [PATCH] dmaengine: xilinx: dpdma: Fix compilation when !HAS_IOMEM
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        <dmaengine@vger.kernel.org>
CC:     Vinod Koul <vkoul@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
References: <20210214034319.11569-1-laurent.pinchart@ideasonboard.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <a72ad176-991c-0884-b99d-86aa9ef948a8@xilinx.com>
Date:   Mon, 15 Feb 2021 08:40:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210214034319.11569-1-laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da37190b-4567-46d8-486d-08d8d184ec89
X-MS-TrafficTypeDiagnostic: SN6PR02MB4445:
X-Microsoft-Antispam-PRVS: <SN6PR02MB4445DAFD24E691F304BB84C4C6889@SN6PR02MB4445.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yNsvHysQKAoHYafMJ2jV+U+bMi8kCEDZtqICY1RlajCfNzM1eGzx1y8y0k92ZTFoMaJAM+D+Cbdox3506a9EriGGEcDq8MuGUt0dplgMcXh0RpBJy8qlRuTo+PC5IQk+duzCEmS2lgk3kOu18RlvIoPZ0hLAYV3i1dgIQgUwfPChyvFy0lrBC3QwuIIB69Q0B60IGK5GBtIe3nNDH4sKF0yg2HEwt7ELhAR0xrK3VQhajmaPg2H/2WM+wW+Klr9wv/04DaJrUhTzYDDWIUxSFSuDWB6MXsd/uDQVfBc9cb7/X4nzwgB+GhIhlCofOQk9SKs92I8a4PTOHWEOMJ053cgqo/VILsA0Aav9YmVFiLRutZQYfqJ3uKSs0q/mEZrwQ8ak+OqxVT5goy2HyIOsQE3yb9/92XYCFGywoul71t4k/HfgZkwPvzMW7KbifVCYW7cj+yxq4u7wdF4Q3HKYSKXCjldTu7XmL4B2kGDoo34UJROH/mCsTuzTA9tHtsfczUNWKHi6DxvMUPUmEVoN2HH45azeZnigYvOgLc4w6zbtlIdbGktPRrMhuEAnQ8QdrfBvInO7pak0PJbQ5aQ1Zv7e+6VTFR9XmREBnlirmWZzyYGszFvoFC8YDYa6dcZALtNhnHzOjlO2ICUOVfE/5sk2X6JWV0kf7lVqfqeaFmM1i+YonXj7B4qSFD0mZsekwtqxi9C2NWGMbuZAL28jrA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(39850400004)(346002)(136003)(396003)(36840700001)(46966006)(107886003)(7636003)(478600001)(36906005)(82310400003)(316002)(82740400003)(4326008)(9786002)(356005)(70206006)(70586007)(47076005)(110136005)(54906003)(336012)(44832011)(36756003)(26005)(2616005)(426003)(53546011)(31686004)(186003)(8676002)(8936002)(31696002)(5660300002)(36860700001)(2906002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2021 07:40:10.5824
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da37190b-4567-46d8-486d-08d8d184ec89
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT062.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4445
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 2/14/21 4:43 AM, Laurent Pinchart wrote:
> The xilinx-dpdma driver uses the devm_platform_ioremap_resource() API,
> which is only available when HAS_IOMEM is selected. Depend on the
> Kconfig symbol to fix the error.
> 
> While at it, also depend on ARCH_ZYNQ to avoid cluttering the
> configuration on other platforms, unless COMPILE_TEST is selected. The
> former would be enough to guarantee HAS_IOMEM, but with COMPILE_TEST we
> still need to explicit dependendy on HAS_IOMEM.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  drivers/dma/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index d242c7632621..205bc888d49f 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -702,6 +702,8 @@ config XILINX_ZYNQMP_DMA
>  
>  config XILINX_ZYNQMP_DPDMA
>  	tristate "Xilinx DPDMA Engine"
> +	depends on ARCH_ZYNQ || COMPILE_TEST

Zynq doesn't have DP.

ARCH_ZYNQMP here?

M
