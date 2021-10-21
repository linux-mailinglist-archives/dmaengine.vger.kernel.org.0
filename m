Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1D22435B35
	for <lists+dmaengine@lfdr.de>; Thu, 21 Oct 2021 08:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbhJUHAV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Oct 2021 03:00:21 -0400
Received: from mail-dm6nam11on2074.outbound.protection.outlook.com ([40.107.223.74]:30433
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230095AbhJUHAT (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 21 Oct 2021 03:00:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7oWEZcoygN8F+j+pWRnd79jkbauMpMd0/qHILdvfqJBt1s0RSQusXVcoGFf3QwwDYdi0BWvUC7IrS6qXYFiJgI0Qxxgb5+iCb3KxDFxMesNDqksFvlOK4b4KTrsug6yVbOyh/Yx93i8ZVxkSGflBKCyqrfO+IB0BBjqZ94l20ocjQn5EAzL7Ka8SmVwbliXiI9mAUcyX+/yu+z2KkmarkMwXkZV7LozBG1L/Sa7T8zKD51QkwDW+pE8vUEFMSdlbQ6fDm2k6nLr3Q58j5yNozKclD8qoEbdB/CVSBodUx3dpsI6/KLZMgUojUd1At/KcAH7pkuT48oIyp8cFAIVZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=trWO26OJ4c57P3HDBrjYTdeGEBVemDYsEq/zhGXrtxE=;
 b=U6j7L5phu1M74UB/OsiHNaVyQPVz95TCdIsP2Inao7RUW/+588Jnmnz6Exy7YJYruaUBowVe4agUF1xInPO1FGKkriXY4/+tYxtA3M/bUbmL7mfQ/toT7hRekDyMq+B+zeEAPReywbtp1d614+4iKXM2TmUe/6lmY07LhIj7WEsX+Ia065bduQq/HgomS3DNfce9fqWbqJMwpAdLj9zCnB9wgvWx4M/n+9mJC4uthSDXbMhG+PgX0Ve7N/KWqix6zQgMnl6tsz0iwOy3Hx97J3H44FMxDyFixDyrjBoOCcLo+kL3ftucJFigfPtVyz3t05zqXBn4cncAHeUUNDxGKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=trWO26OJ4c57P3HDBrjYTdeGEBVemDYsEq/zhGXrtxE=;
 b=onV9zhWQ5duCYdPxAL00FvhIMCaHj26A6IsTLQsd4ZpHg8vtYjk0XAwILtQexXgOZlbnlpsSvK/s8AVmsXL6JHjtFP0NEbmpEURd1eZsm25tjSjEvhc6xOXO+tzk+OUTeJYP8J1Iqk84ZKwr4n9EET23JLYkCGnPFXpaFTenm/C6kUL4EtJF0CCb240+fqcvEQtG18ax/fyMS7SINy1E8D0W5bsuJxXox5N5moQmtckjBQuFm9e5jYZbRKdVvrD9JRtq76Dw8ik/uTDMm4pAkvJ+DkzbRQ9IPHZHZGaYUgIaPBF4pAxJK0kPUPamgIfgHaigr/JT7NxN69pA5wKOOQ==
Received: from BN0PR03CA0054.namprd03.prod.outlook.com (2603:10b6:408:e7::29)
 by BY5PR12MB4291.namprd12.prod.outlook.com (2603:10b6:a03:20c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Thu, 21 Oct
 2021 06:58:01 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::27) by BN0PR03CA0054.outlook.office365.com
 (2603:10b6:408:e7::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Thu, 21 Oct 2021 06:58:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4628.16 via Frontend Transport; Thu, 21 Oct 2021 06:58:00 +0000
Received: from [10.26.49.14] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 21 Oct
 2021 06:57:53 +0000
Subject: Re: [PATCH] dmaengine: tegra210-adma: fix pm runtime unbalance
To:     Dongliang Mu <mudongliangabcd@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Zhang Qilong <zhangqilong3@huawei.com>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20211021030538.3465287-1-mudongliangabcd@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <fe921832-79f9-7e6a-e1c5-a94b5d617435@nvidia.com>
Date:   Thu, 21 Oct 2021 07:57:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211021030538.3465287-1-mudongliangabcd@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58913f7a-a431-42e5-4be3-08d994601f28
X-MS-TrafficTypeDiagnostic: BY5PR12MB4291:
X-Microsoft-Antispam-PRVS: <BY5PR12MB429104B40631A32EFB23D6D1D9BF9@BY5PR12MB4291.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W/jerCgBRjFE4+2mpUZhfPx5ix4TrV05Eu4s0W7QjtZ4D+HyRyb4bKgtxBQMSw5qqJxXRb/vUgERosD//DKeX+3oWsnuR9FQbMZfQMsP1qT1XjolouVDyH+wj452HBpQqc6FhhCqpa9EK6yhZz/R9o/JaWtGZnO9g0AayKKulOFncElIo67eT8XJ03eDMtqXxls9ICrATWdQOvXqyp89SYINH+4uawc7HwgQL0unsyk1jfyzxJye1mhXgUctFq8VMm7LaDzdjtdjxPjbTR2sr0MOqDEBb3RWLmA1e2FzlnpDDblnmj+8kv+UG41fjRnY3hX1apWW9J6W1yFsZw6Ph3Hf2unY7nCXNUTAapmHr4iAzRAOn1HXNgy8vIXxgz3FNh1BnhKQy6FLZIX9D/OOGuk6HTpxS4pVd9rmt5y+aCLtnEevuPbkJcXU+IHwwl+2CELan0EQcLsCdSXg/5PXoOJq0O0mOjj6IXvRlv0G8Nb/fMbfKbAKWNUfmtqXz+wy0yfNDshqKwVDKgfcREwHA8+LqDuPstyMFpRV6lHOB/Xt1+7ZLcWEAAARqNMbn62z7X/ejCN6CxrpfrJ8fvvk+TZUyL5tZWOpVzbhksackVAHp0KEa5DXzMJzeSuHQAtJFQdduomnhiO/1YnA5H8Dx7g2r1wYv5FSML/l53EQu43xGr9dy8bKv6pyr2sIgiFcnk37/qoWDQRwDMQWZOm3TeqcEwLxDSJ4w3Yq8zcNo2s=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(31686004)(53546011)(508600001)(8676002)(7636003)(8936002)(16576012)(2906002)(31696002)(2616005)(5660300002)(36860700001)(47076005)(36756003)(82310400003)(26005)(186003)(426003)(336012)(70586007)(70206006)(4326008)(36906005)(86362001)(54906003)(16526019)(83380400001)(110136005)(316002)(356005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 06:58:00.8312
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58913f7a-a431-42e5-4be3-08d994601f28
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4291
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 21/10/2021 04:05, Dongliang Mu wrote:
> The previous commit 059e969c2a7d ("dmaengine: tegra210-adma: Using
> pm_runtime_resume_and_get to replace open coding") forgets to replace
> the pm_runtime_get_sync in the tegra_adma_probe, but removes the
> pm_runtime_put_noidle.
> 
> Fix this by continuing to replace pm_runtime_get_sync with
> pm_runtime_resume_and_get in tegra_adma_probe.
> 
> Fixes: 059e969c2a7d ("dmaengine: tegra210-adma: Using pm_runtime_resume_and_get to replace open coding")
> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> ---
>   drivers/dma/tegra210-adma.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
> index b1115a6d1935..d1dff3a29db5 100644
> --- a/drivers/dma/tegra210-adma.c
> +++ b/drivers/dma/tegra210-adma.c
> @@ -867,7 +867,7 @@ static int tegra_adma_probe(struct platform_device *pdev)
>   
>   	pm_runtime_enable(&pdev->dev);
>   
> -	ret = pm_runtime_get_sync(&pdev->dev);
> +	ret = pm_runtime_resume_and_get(&pdev->dev);
>   	if (ret < 0)
>   		goto rpm_disable;
>   
> 

Thanks!

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Jon

-- 
nvpublic
