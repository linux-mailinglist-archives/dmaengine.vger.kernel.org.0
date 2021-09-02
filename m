Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCD03FEBFA
	for <lists+dmaengine@lfdr.de>; Thu,  2 Sep 2021 12:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241529AbhIBKSk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Sep 2021 06:18:40 -0400
Received: from mail-dm6nam11on2062.outbound.protection.outlook.com ([40.107.223.62]:2700
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242458AbhIBKS0 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 2 Sep 2021 06:18:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fol71Qk+zIYSoBH/YEfmm72dvAAQdE0woAkueMkFtfJyLVsliKewbgZb49RDs2DI8hbIvCittIfaaXFoqR65tN/e0WywnQOxC2pcCd0QHq9jjAqpo2Kbm2P8aAwbBjANwtdPQlG5/moYOIygAwQhmY0PJ1sK2OzsXmm7qqzUM35WCe+xhBZqoLZCY8WgEkXO36bmfCdW8DjMnKNbmAAm3eLeGu4GeVR1BPyUvbsqREU6uLIQW/n9BPXvpLBevxq7A75c5bW0s+a0f2Y+LbzPfi5urbPFHuDxKs+3t9Rgd5vanW5gQpreTGCXMsDN0sm4Ru8uZxzQO3XTJN8vIxO7fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=pHcU98o5HsJYZ4I6u/JgKS0yPWgkAwwLishlQQgmQnY=;
 b=CPCrWKQBPEFrXHiwPmwREbfqzYDN2BlUj5GEFAKuaydJVOVklfxaLOVIP+FkPg6ktyQcK9WjARQrKBMuh07ysDGBk+J9alDZtynkfjSpf6CbbaHdFguxf08imm7uZRt3osoAPE5Hb9wQbkTkz6r+Ck/rapccuKNfsDk9A6/5yNpZUZ+wB6YFT5QFRkVB83wKoSRtKup72nEqJA+xUS37gCn/QokhR7zc9Hr9garJ/2CFBNHamxMh53xLA1WCqamZsgzc/t/agBYDsZ+akuaw3dDsrevKrNLZGWGaVlawZXofYE1JmHe7L8ScHyvC1f2IZIQBhv91nX9aSW3L3kah+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHcU98o5HsJYZ4I6u/JgKS0yPWgkAwwLishlQQgmQnY=;
 b=lHY6mrMJurvWd28FnI84oCr+3D6eBWumC5AUd+Zcr4YPXPxzvq3/h2Q6gSPjpmzTsjFG/pFAEv8v6uNnP2/bK045Zv/I/B+ZgXo9R2XvW0q9ZXWZCM3aHqxaTfGD5+S4j56eW3YHYOnbG1/mRjf9/Z5G1k4DQJe2B00XqybrN0QQncWhlkUKYzDxbYDuUb/aD1C9Dwkr8cLpHYCffchTC1Nb8JlcCeo1oAUn5p1wY0nAcdr31/kfIwWE2iF007gAT8TndE9WLNf2U6sSx5tV5qSUJ+2c8Y7/4Pcv7Wm9cOAF7uJddz9e6EWBBwVYCo0pGXUfk1jidQLm65lEbZKtmA==
Received: from MW3PR06CA0019.namprd06.prod.outlook.com (2603:10b6:303:2a::24)
 by DM5PR12MB1737.namprd12.prod.outlook.com (2603:10b6:3:10e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.20; Thu, 2 Sep
 2021 10:17:26 +0000
Received: from CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::3a) by MW3PR06CA0019.outlook.office365.com
 (2603:10b6:303:2a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.21 via Frontend
 Transport; Thu, 2 Sep 2021 10:17:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 CO1NAM11FT023.mail.protection.outlook.com (10.13.175.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4478.19 via Frontend Transport; Thu, 2 Sep 2021 10:17:26 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 2 Sep
 2021 10:17:25 +0000
Received: from [10.26.49.12] (172.20.187.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 2 Sep 2021
 10:17:22 +0000
Subject: Re: [PATCH v3 2/4] dmaengine: tegra: Add tegra gpcdma driver
To:     Akhil R <akhilrajeev@nvidia.com>, <rgumasta@nvidia.com>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <kyarlagadda@nvidia.com>, <ldewangan@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <p.zabel@pengutronix.de>, <thierry.reding@gmail.com>,
        <vkoul@kernel.org>, Pavan Kunapuli <pkunapuli@nvidia.com>
References: <MN2PR12MB41438B94148A6D522C056771A2A70@MN2PR12MB4143.namprd12.prod.outlook.com>
 <1630044294-21169-1-git-send-email-akhilrajeev@nvidia.com>
 <1630044294-21169-3-git-send-email-akhilrajeev@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <470c9d2d-df90-0dd8-943c-7ebb7bc49be8@nvidia.com>
Date:   Thu, 2 Sep 2021 11:17:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1630044294-21169-3-git-send-email-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d8db0d8-37a5-4303-005b-08d96dfadcd7
X-MS-TrafficTypeDiagnostic: DM5PR12MB1737:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1737651465D1D4CEB32F0165D9CE9@DM5PR12MB1737.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xbonShn+ZRbjRCRc68Qm7NsVzITF2LtQzpcbzf7d5xtjhJAeum0kHQztLlDow7E7GKSHMRWP9MLfv+ctHjII60FtRbcse6f8tk0auMCXvtFr0yX4DPoIq7iXDocoJfSFoLcnpxQyJScKVwAkW9ad756hN6N7cmyIOlZd7X8rd3u6FD0mrwVfiKEhp68hwFt8ALzUQpH9tNHOCehFuh0RhjWXrELEc6jNHwM98io0LO+mFZYk6WKYCyCPA+vZm23FZG2CXyRPtdF/j4pH16Q/zyyTN3+XnjAXo0v7/GgwglhTmuv14FH0fAREpc4p9qQuTOBfXJJJNK/ZGm54eKUC3FlGewPYylqY2fi1k5s/KydpMh4fA6+WmLEOFCGplDr2/ercAuKNvifOmtIFaoztoiVCy/oglLi9aFl+/7sjsfbG8PMNSm7Qpewpg54INCNCPr0jSAzVFFc0jTsv46n1IYU7zaXeGIgD2aic6NvlXF3FzUkvQKyBb4u9SzoWMRySs+rP8iv4fu/UmrzemguByBBByHlg9RGit+kwYQ7VW6U3Bds0cTNltP0I9tv1w/GnK0QPGuKurtqkcxZb2IQCHK6VEM9rXkP/S2AUpGEm6G2RbNJOyCTkGBWdDaBhHeA9EujTY4hM3H/l8jH2iuPxK26UaVBRRfMNZJGvFK8Tw3INAY6v1FzGo0jNW/LF7SDpRApK+3Cw4r3mwl4pXf/wWwGMikdPJ0f9oLih3zlGgv8q9Y6o/BgkQ29VLEwRU+VH
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(53546011)(82310400003)(36860700001)(4744005)(6636002)(8936002)(31686004)(70586007)(356005)(70206006)(107886003)(36756003)(2906002)(6666004)(47076005)(16576012)(508600001)(8676002)(336012)(26005)(2616005)(426003)(31696002)(4326008)(86362001)(16526019)(316002)(54906003)(110136005)(7636003)(36906005)(5660300002)(186003)(21314003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2021 10:17:26.2875
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d8db0d8-37a5-4303-005b-08d96dfadcd7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1737
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 27/08/2021 07:04, Akhil R wrote:
> Adding GPC DMA controller driver for Tegra186 and Tegra194. The driver
> supports dma transfers between memory to memory, IO peripheral to memory
> and memory to IO peripheral.
> 
> Signed-off-by: Pavan Kunapuli <pkunapuli@nvidia.com>
> Signed-off-by: Rajesh Gumasta <rgumasta@nvidia.com>
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> ---
>   drivers/dma/Kconfig         |   12 +
>   drivers/dma/Makefile        |    1 +
>   drivers/dma/tegra-gpc-dma.c | 1343 +++++++++++++++++++++++++++++++++++++++++++

All the current Tegra DMA driver files are named 
drivers/dma/tegraXXX-XXX-dma.c. So we should follow the same convention 
here and call this drivers/dma/tegra186-gpc-dma.c.

Cheers
Jon

--
nvpublic
