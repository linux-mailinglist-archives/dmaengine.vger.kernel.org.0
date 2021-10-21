Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8E9435B39
	for <lists+dmaengine@lfdr.de>; Thu, 21 Oct 2021 08:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbhJUHBP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Oct 2021 03:01:15 -0400
Received: from mail-dm6nam12on2060.outbound.protection.outlook.com ([40.107.243.60]:38496
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229854AbhJUHBO (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 21 Oct 2021 03:01:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mfJX7ug2GoBXr3mUIY80CMFjBqh/Kz3u303C3xAtpG+cF9u77o1yC2j5+zP0E6nKMBMfTQ7KAlHrKDsDy8Y6zNTba0BRp/ivB9yhO8hbmz0PwIAX35jGrk3BOddEkn1lBzn20BBToMkWqU5Rs6iShH3QzXyde9/bPyDjG+Mfy7kx5/TkQuJw82lFfcJJBQ2EPSrnkdyTukjoZpcM/0as6esWIi/1/thtbeCrSiYg4DbOepA8kMzANa71L4NqwEvQIF2qn3TEyCxrrZ4lJNGRs0ZxALby2PQTZyQQdJgVgjflNBJ9zydyc6LBjxtXRckTd2uxfE/YFNbE6g6lo3okCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=srU9C6ZWJ9Br7ElxCpyakRUUvADtngtegPRfArKJEus=;
 b=PHmhM1IgC5XPS8Ixw6eTZWarjNTFshGyhhWheKnH/tQEg1UdDEFq8qRMXQIl6tVmhqbzc9faCaPM6ovWWUKVZmyhNahFYKfoJLBPLUFChTaNXyaxMphMK3X6lLduXHzsLRZ3lG9bcuwXAAXCjWX0ejoVivjn6X0o5HyTA+fp4sWiWQX0BQw69G8tuuEHnl2kZp0HNMqv40C4aFFMBJiQoH2LA3pmm4AljHqWNuuee1cirPFmjCR0Sr8scQbamet15KKc9VnxS0OsIkR1OI3cqZhxP6wvQbhWL8fHBQolDxklBgPF9O69XmnH/T/i+V2c1e7lULNLFjlwWT+cN8O1ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=srU9C6ZWJ9Br7ElxCpyakRUUvADtngtegPRfArKJEus=;
 b=Vn1HNMUFVItr1OlfwPVmT7f2pbsJzYVVl/zolEWLZWcw20pT+mpgq96sORSAlNW6OCBPHK7rUZlAGwx1SKoLoSlMh43LjZsdWAuAkTJNzTJGZlQdpWHj++6eBvuwDeVEKWQOI2dmn1qTkeQR+OTEGGMKLSodeB/uxAYkClIXSU8sG57k4zMCKOfii3FePGN9IGJq3JXbQhzwOWA2zpvUperc1Ol2CnT0OBnauah2ZnIsJJGkZJ0GSucmCGAkTFQMzgYr3cFHrgifOn2jDvqh0IkhHJYvAD+i3YB4Sq8qZX8rpqD44xbyS364OeR+jaJWCKZFAQ7bsudKwIB+/OsMxA==
Received: from BN6PR2001CA0023.namprd20.prod.outlook.com
 (2603:10b6:404:b4::33) by DM5PR12MB2549.namprd12.prod.outlook.com
 (2603:10b6:4:bb::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Thu, 21 Oct
 2021 06:58:57 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:b4:cafe::eb) by BN6PR2001CA0023.outlook.office365.com
 (2603:10b6:404:b4::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Thu, 21 Oct 2021 06:58:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4628.16 via Frontend Transport; Thu, 21 Oct 2021 06:58:57 +0000
Received: from [10.26.49.14] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 21 Oct
 2021 06:58:55 +0000
Subject: Re: [PATCH] dmaengine: tegra210-adma: fix pm runtime unbalance in
 tegra_adma_remove
To:     Dongliang Mu <mudongliangabcd@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20211021031432.3466261-1-mudongliangabcd@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <a0f51171-2a8b-b931-eb98-63e92fdf9dee@nvidia.com>
Date:   Thu, 21 Oct 2021 07:58:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211021031432.3466261-1-mudongliangabcd@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c333981a-0586-4d6a-81c9-08d9946040cc
X-MS-TrafficTypeDiagnostic: DM5PR12MB2549:
X-Microsoft-Antispam-PRVS: <DM5PR12MB25490030A9D006FEC2DF8F95D9BF9@DM5PR12MB2549.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OXjMLxBVfhnS2DMid58PZJJQK9tk27x8okuYfiLo7BzbrAylWzvUbn+iOZNjj+jjVROJ2nkkZo/7fzbTwNPVVUrKsTb5f27O+xpQQvhesvc65P5z3ZTFmeP4H9D35m5g42gsUSaT65tsDdAHtDBoKZD8JP2NhJUV2LcFmCKtJE494scoEm53y6lbKiP4BWaM6iW6SbIL1xpCTOBoXaBhTbOcr16z1ACraP62RFYGz4oyWJi458NgGKhdIsXECIu9McNBGqAxuW7norTqXJBNcNLCcY+1f3hZGmuWCitjl8plKH3zs5Y8rbC68GRUNAAdCHgYyu7xsiOwzSfDCU9KcGlvDULl0XBefExAmx2VfuWIKjZYmjzyAiUdAmPip1nuT0ZtQgze64aqqep2YIwiR/0I4eEldLeXUpKQrUODe5xuzZQM9PG32rUUQ6gR11nu4lCqvb2GZuo6Zeo5m0/y2fnbM0ONmwE/G9c6n+fsMpGImjgOmC7c7WpJteI2/ot80io2FKehsIEISWHj/tIn+mh/MjPyb7nIuNJiWELzH0zAXkOK5EdDeMCJClvAJbFdngqkSVfwOhqHpx/MdDidr3re4FArgtkxoEL/y1/NHaogG30+oaiqAay1zTiDMc4rboZrkU+dLzEySlJuc7/HRi5xXd2qY8kt7ZGG97NnmoiA3BZ3Zb9pxtUVduNVy7y/rnqQR0jXkUs1Jz8b7qiJc3xUNtrdaU4UWW0k9cpjhfs=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(5660300002)(47076005)(4326008)(31686004)(36860700001)(336012)(82310400003)(31696002)(110136005)(4744005)(54906003)(70206006)(16576012)(36906005)(316002)(86362001)(186003)(70586007)(426003)(508600001)(7636003)(16526019)(356005)(2616005)(2906002)(36756003)(53546011)(26005)(8676002)(8936002)(83380400001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 06:58:57.2762
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c333981a-0586-4d6a-81c9-08d9946040cc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2549
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 21/10/2021 04:14, Dongliang Mu wrote:
> Since pm_runtime_put is done when tegra_adma_probe is successful, we
> cannot do pm_runtime_put_sync again in tegra_adma_remove.
> 
> Fix this by removing the pm_runtime_put_sync in tegra_adma_remove.
> 
> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> ---
>   drivers/dma/tegra210-adma.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
> index b1115a6d1935..7e4d40cd9577 100644
> --- a/drivers/dma/tegra210-adma.c
> +++ b/drivers/dma/tegra210-adma.c
> @@ -940,7 +940,6 @@ static int tegra_adma_remove(struct platform_device *pdev)
>   	for (i = 0; i < tdma->nr_channels; ++i)
>   		irq_dispose_mapping(tdma->channels[i].irq);
>   
> -	pm_runtime_put_sync(&pdev->dev);
>   	pm_runtime_disable(&pdev->dev);
>   
>   	return 0;
> 

Thanks!

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Jon

-- 
nvpublic
