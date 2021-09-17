Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0C0840F521
	for <lists+dmaengine@lfdr.de>; Fri, 17 Sep 2021 11:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbhIQJsi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Sep 2021 05:48:38 -0400
Received: from mail-sn1anam02on2082.outbound.protection.outlook.com ([40.107.96.82]:36288
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240503AbhIQJsi (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 17 Sep 2021 05:48:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cg17iX6axcyYaXQ+Iyfa48zmvq3k2YKS3og8O+7yKhd4/yPJ98nroqni/Zsn3HmWVVM/Ocx+c1m2E3Y9AZyh5PlTDo3HhECr66zkbQgPOdDcG6h8on2yx/5l63Gcyr/8ca+AMdVgv9biIHElg8b32+vgXBDZGM34L+/NTlXK4HwtXKWG4pgH3GG/2sIKCBVJURCmdUDo7hj0x3d7ovdwmzZl8tCyjMhpSLCPf1VpAM2hk3rdXPgwmeZwPB0XsFhZaFM0XjwwPoJcLf8uvK2VrB4yYgm6znt6Xg15N1F8oWiuqjYbxVIVr1y+u3XBE94kLtqcLPzQvIZL+scyIb/jIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=gBbpXpKKhDan5lNeFjKM5i++E67poUN6g1iMmKWAIuA=;
 b=C+ibfD8bRFoqnNz97zkNg2vfGciexew5aA6Us3WpXPLHpBlMTOwg1NMs/+s9Tp18E+f2WHku2sgjqzbbFKM/Y+g3kvAr/kan3hkrLKVscCjVreZWDJ67O81ICkKmLAuUQbHavDdo3rgyNWBaK8EwtCE2ITYa/nSKMLGQ4UPp+sduXjU1oYCGlZejxvV0I4ueMR+301u023iKghz175s+SV4WsjRm1OMlSM+qh2JdyMQ1hwxhsuYTRClRYUYxSlJ/hrNvoyNPktQlcIWx6vbQrRHVblpTyP5g52Cbr5VXqnyduw6FlpKxWYSfrmdDgwWCkl2XwdL1vtmr0/fDEVht/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBbpXpKKhDan5lNeFjKM5i++E67poUN6g1iMmKWAIuA=;
 b=qHlJFXYNN8EU5yex+1xRVrmDowmONY7wunxaIU3fSHQpqLUG9SqrX4Lja3s1qWxi9W4Th3QIFbDBzrLgvLBMKMG/o+6130Rk4E6gieOTJeRUsGHEtt1K2FLDgmE68ysh14uS/cToJ84u4IrJoJBHtClsZIvcTXm9QfvuTqQDzQMX9hBxMOfGEOuztinmmMPlo7pvLE5WA+PXwediA8JxdBtMJi3uSyY6nvFvBIl3/43Iuq8dHLIOfZP2BQnljj+0DZAhjM6cwWQbeyRJz+00AXF9qYY+4PAC7bB1DI6J9lN/e+o6UIt7AtLMJQP1M3xkqxlnoU1o3UMZFctEIoZ1NQ==
Received: from BN0PR03CA0048.namprd03.prod.outlook.com (2603:10b6:408:e7::23)
 by MN2PR12MB3279.namprd12.prod.outlook.com (2603:10b6:208:105::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Fri, 17 Sep
 2021 09:47:14 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::f1) by BN0PR03CA0048.outlook.office365.com
 (2603:10b6:408:e7::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Fri, 17 Sep 2021 09:47:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 09:47:14 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 17 Sep
 2021 09:47:13 +0000
Received: from [10.26.49.12] (172.20.187.6) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 17 Sep
 2021 09:47:11 +0000
Subject: Re: [RESEND PATCH 1/3] dmaengine: tegra210-adma: Re-order
 'has_outstanding_reqs' member
To:     Sameer Pujar <spujar@nvidia.com>, <vkoul@kernel.org>,
        <ldewangan@nvidia.com>, <thierry.reding@gmail.com>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1631722025-19873-1-git-send-email-spujar@nvidia.com>
 <1631722025-19873-2-git-send-email-spujar@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <b067015e-4f3e-7546-e333-d0fcd8b95ce4@nvidia.com>
Date:   Fri, 17 Sep 2021 10:47:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1631722025-19873-2-git-send-email-spujar@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f76bda7-f78d-47b6-3e00-08d979c02136
X-MS-TrafficTypeDiagnostic: MN2PR12MB3279:
X-Microsoft-Antispam-PRVS: <MN2PR12MB32794532587F3EA1160E6A1AD9DD9@MN2PR12MB3279.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n01sD6SKwlTjZ5Ib1cl2timrJF6HYGYI+F/+0mawcJe5otGX1ejpaHiyn50l39L18LKvaUc2ydWibc7jN64xmkdWlkyiSzyPhj5eEhbdQuc6T53frPlS0tzvcChr2ZW7J+eU8fstOW3HdSoRo2E6BrQzY3kPhJmNWVEoh75rGKQxjS8mBqb+QQpgGKgXZD/HWLEHSCz2pJ/6TnHT9ujLzJZ0+H2j42PZ1NQyHjgUtBWEnXKzUJVwOo+K4A05OVLYRIcyRws0Fe6qrG3IAHmnH2yRZuQxihQ9ZIr3G0qx2OQEAFekWOVrHrBVz4t4EFEYpnJ2cG2NR+DDDCSrKmCrrz2mbk5OTsYLmRdP9gXCc8pkqwC+EFmFkLY87z+6syYdA5NllEkgwduJklM6tN0R40dCrqaNABtbkfrBrQudK3tXBajGN0VQcEj5xhJAMXXHzQ+wKpe3PFeuUDuy++VC2irgFCKaRH46KNvAQ8JwbDbB4dnmOUjj9x/3Dxz/kZZjut99OQpwMJobUfv0Ho6T38Oxi2FSLH73w4ZZ68CDAEiJ08EfbcP01fqJe/3N32Yk++uTOoGfnYdk6oSuzTFzSMdj+ACPxWyv2ATcC2EEuMhaYnNveSjEQ0wGYgC0JAMwicjHBfKuQ43iTwg2nbjEH+C7bbE5GNvlhcaCoyc8m6t9/ISQ8TCQdd8MabTQeEnuJUVaF+BckjWKAo4nGiZSvM/UaMD5rKgoOYe2fQ6qTADo3hrlvlntYYgjCWIZr9Bue+uxWWa33WnQzmrKivtIjQ==
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid04.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(54906003)(110136005)(83380400001)(356005)(8936002)(316002)(16576012)(5660300002)(36756003)(82310400003)(31686004)(47076005)(2906002)(36906005)(336012)(8676002)(70206006)(26005)(426003)(70586007)(7636003)(186003)(16526019)(31696002)(4326008)(508600001)(53546011)(2616005)(86362001)(36860700001)(169823001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 09:47:14.5841
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f76bda7-f78d-47b6-3e00-08d979c02136
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3279
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 15/09/2021 17:07, Sameer Pujar wrote:
> The 'has_outstanding_reqs' member description order in structure
> 'tegra_adma_chip_data' does not match with the corresponding member
> declaration. The same is true for member assignment in chip data
> structures declared for Tegra210 and Tegra186.
> 
> This is a trivial fix to re-order the mentioned member for a better
> readability.
> 
> Fixes: 9ec691f48b5e ("dmaengine: tegra210-adma: fix transfer failure")
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
>   drivers/dma/tegra210-adma.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
> index b1115a6..caf200e 100644
> --- a/drivers/dma/tegra210-adma.c
> +++ b/drivers/dma/tegra210-adma.c
> @@ -78,12 +78,12 @@ struct tegra_adma;
>    * @ch_req_tx_shift: Register offset for AHUB transmit channel select.
>    * @ch_req_rx_shift: Register offset for AHUB receive channel select.
>    * @ch_base_offset: Register offset of DMA channel registers.
> - * @has_outstanding_reqs: If DMA channel can have outstanding requests.
>    * @ch_fifo_ctrl: Default value for channel FIFO CTRL register.
>    * @ch_req_mask: Mask for Tx or Rx channel select.
>    * @ch_req_max: Maximum number of Tx or Rx channels available.
>    * @ch_reg_size: Size of DMA channel register space.
>    * @nr_channels: Number of DMA channels available.
> + * @has_outstanding_reqs: If DMA channel can have outstanding requests.
>    */
>   struct tegra_adma_chip_data {
>   	unsigned int (*adma_get_burst_config)(unsigned int burst_size);
> @@ -782,12 +782,12 @@ static const struct tegra_adma_chip_data tegra210_chip_data = {
>   	.ch_req_tx_shift	= 28,
>   	.ch_req_rx_shift	= 24,
>   	.ch_base_offset		= 0,
> -	.has_outstanding_reqs	= false,
>   	.ch_fifo_ctrl		= TEGRA210_FIFO_CTRL_DEFAULT,
>   	.ch_req_mask		= 0xf,
>   	.ch_req_max		= 10,
>   	.ch_reg_size		= 0x80,
>   	.nr_channels		= 22,
> +	.has_outstanding_reqs	= false,
>   };
>   
>   static const struct tegra_adma_chip_data tegra186_chip_data = {
> @@ -797,12 +797,12 @@ static const struct tegra_adma_chip_data tegra186_chip_data = {
>   	.ch_req_tx_shift	= 27,
>   	.ch_req_rx_shift	= 22,
>   	.ch_base_offset		= 0x10000,
> -	.has_outstanding_reqs	= true,
>   	.ch_fifo_ctrl		= TEGRA186_FIFO_CTRL_DEFAULT,
>   	.ch_req_mask		= 0x1f,
>   	.ch_req_max		= 20,
>   	.ch_reg_size		= 0x100,
>   	.nr_channels		= 32,
> +	.has_outstanding_reqs	= true,
>   };
>   
>   static const struct of_device_id tegra_adma_of_match[] = {
> 

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
