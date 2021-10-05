Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A6A421F94
	for <lists+dmaengine@lfdr.de>; Tue,  5 Oct 2021 09:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbhJEHpg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 5 Oct 2021 03:45:36 -0400
Received: from mail-mw2nam12on2046.outbound.protection.outlook.com ([40.107.244.46]:5473
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230526AbhJEHpf (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 5 Oct 2021 03:45:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7+nH9q18tbSAyzjURC4uDKeFuRn5Gp6SR0A1htoyCqQfiPGD1hsVoJO8R7I6djbwAF4+gHBmM3yf9gPzKZcP10P3AFxuNQ/sQV2VMMAaVS1Uati+l5Uzv8TQRbYhCdRV1TQmgt6w4jcs7O132JVmBt/SYg1Hf6JfKwtSnp/ILGwbY8xyCT5Y0mtm02K3iej98u4V47WL6+bCKk5ClmGoGNVDuXu13KhIcAo98o/SbkRRlB/fYbxoa0PliysR5yJvTwF1+KIOUFkBhv8xgBSBlDZx2IubwhEvdhfJD1UPOy2PEhiQJJQgfmVAsCRr+1mSGd3RSnLT1HB9T8hriyAeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=krkAw5kpTuzt/KeWJO1ijyHFH+PLpQHNHVzkpC1eJAw=;
 b=d5vf7TfwA9XXp7vsA8K095TDmnJbFJdbsunDQqLIMZ6ojYUtC1fdVOlM6wSZDOx+mcuyI4f0wMlY3mm05cRCKFLMd3Favd2fjUqUImiSlSRQt7fXKoZZvG2GHFdqS+B+ASxSQKKraHnhH+T+xwN+lZkjF8gu7fki7kppu/TwrP7erKsebfRhbaj1DKTbfpRgaDmVWyM739CL+7qB2ajPh3+8hc48qVnzhM+FZ7SEYwG342PFHTuKkbdrkZ/RpPHhNXp87hDTLDHpI7/U5Xkbp6SBhCcwXVskUvh7yHkJiyElbnFJy06JvMvN+SnEuhWN408rPEShVmJFu0kYqu1s9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krkAw5kpTuzt/KeWJO1ijyHFH+PLpQHNHVzkpC1eJAw=;
 b=fcj4REM1ozWWJRzFJPzkB5lnQUQ+YhTe3vhDY+VTg4HWI6z8nDGFe8afdemGiAQ+0XiyMGvU0PwyLmXjOokS7Ymh+tXvbqmJlFmuRwEaC91Yju5ahNQe1QMCZRrCxOcjMUH89eZ1GeWQfAgkvuGFJYSF+9sldeuaVP7FPhJA1S20XTJrPE0P8g0hUfvtFklRQqaKNW3rrqTT9VXCFJbMJauLAK8CRSb/Irk4EUSTEV/4i11oDXizWzQHz39G/9/UEectu/oH/uBHtzewd97YV4jF4Qu6TQNljX002JN7HS6tY3WViO+Tp0z6g9Cdwysfr8rz95sGRlqKIO/lT/v6Zg==
Received: from DS7PR03CA0150.namprd03.prod.outlook.com (2603:10b6:5:3b4::35)
 by DM6PR12MB3803.namprd12.prod.outlook.com (2603:10b6:5:1ce::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Tue, 5 Oct
 2021 07:43:43 +0000
Received: from DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::3f) by DS7PR03CA0150.outlook.office365.com
 (2603:10b6:5:3b4::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.17 via Frontend
 Transport; Tue, 5 Oct 2021 07:43:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT035.mail.protection.outlook.com (10.13.172.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4566.14 via Frontend Transport; Tue, 5 Oct 2021 07:43:43 +0000
Received: from [10.26.49.14] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 5 Oct
 2021 07:43:39 +0000
Subject: Re: [PATCH v8 0/4] Add Nvidia Tegra GPC-DMA driver
To:     Akhil R <akhilrajeev@nvidia.com>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <kyarlagadda@nvidia.com>, <ldewangan@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <p.zabel@pengutronix.de>, <rgumasta@nvidia.com>,
        <thierry.reding@gmail.com>, <vkoul@kernel.org>
References: <1632759090-7965-1-git-send-email-akhilrajeev@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <6f45ee92-d0cb-92d5-a7db-3466af3e13d8@nvidia.com>
Date:   Tue, 5 Oct 2021 08:43:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1632759090-7965-1-git-send-email-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df2db851-9d23-45ce-299a-08d987d3db2f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3803:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3803A57E346230A0AAB57879D9AF9@DM6PR12MB3803.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2EzvNpnZNmk/7cwAxkEFDOMFQIzX5jp4YqrFl0OqhK5oJ/+WA6le2TPRdtjpZkTWkxqEEIEvTJVeqOEVFZKuFnoxyMwZ3Jp4IayuBQX5DUo6GV8MDpcplFBwrGzgIW81E+qL2Gjfp3rvM+YqSVQrJBQp5xz+yUquFkVzfZ09igJ1aQSo2BJlPeUCgcpOuiAI8knCI1ce83lR1LCLddswKiNcOrTQSImp3Bu+x/0Tm/NnehG1jeVvEL7/D2MYZt0SsyYOHpc3wfsP7o+qjLiZ8MNLcnA/2cs7Ti+pSKdVOTTRhXyujY2Vgw68ShlEmPQOOiT/v9njvkrGnNo4EuwiMTVhJ9d6PMgrsItBbrrMf9GS+17+VDCeT8qC4R1qNGu3U3BZgpU1lPr4ujAPxzZ0BrZzz+vGp1OFsUjA/1hMFwr5V+lvs0NulkXGf6at/sajGG3Ssjsfn18+zZ+oV2X98l23JpoQy9jzUX/gl9kxssKc025bbkQ2xTbkItP6ehW+wFhmekkjjETnBuuyQM1YrMqFmztHbcxDZbaLSSuDgYzVeAAYPFoRyqJTabBCoXoCGqfecC34c23l/9NQJOKgPF6AnyVY8TPC80+qVhjA4k9gjHOJuJERk1C6OrIGstBiNBX6cwGSSTZzYGOIe6C77V2rQQB+KZMIJoFTkmikFKpmkQK3//y26oj/qgCY8A2OLrtBah7kSp9vrGBhoHYPRVmK3LHPCti3xjZ/YpyYi4zEIXzYnKcq6hfTlXb+K3qQ69qIwno1+YjOdlQckZo/wEAmkGAzmXpEOJbu0WBC5uM/frnRIDr5Y7suoUoGB8ciDiEUp62YjzOknPgrKeXSciOV54/TqYmWaTnww7u8xuU=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(86362001)(16526019)(70586007)(31686004)(54906003)(6636002)(6862004)(426003)(8936002)(336012)(2616005)(16576012)(8676002)(2906002)(186003)(70206006)(31696002)(37006003)(5660300002)(26005)(4326008)(53546011)(316002)(82310400003)(47076005)(508600001)(36860700001)(966005)(356005)(7636003)(36756003)(83380400001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 07:43:43.3247
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df2db851-9d23-45ce-299a-08d987d3db2f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3803
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 27/09/2021 17:11, Akhil R wrote:
> Add support for Nvida Tegra general purpose DMA driver for
> Tegra186 and Tegra194 platform.
> 
> Changes in patch v8:
>    * Fixed dt_binding_check errors in binding doc .
>    * Updated get_burst_size and dma_tx_status functions.
>    * Removed slave_id assigning in tegra_dma_slave_config
>    * dt node name changed from dma to dma-controller
> 
> v6..v7 - https://lkml.org/lkml/2021/9/17/652
> v2..v5 - https://lkml.org/lkml/2021/9/16/455
> v1 - https://lkml.org/lkml/2020/7/20/96
> 
> Akhil R (4):
>    dt-bindings: dmaengine: Add doc for tegra gpcdma
>    dmaengine: tegra: Add tegra gpcdma driver
>    arm64: defconfig: tegra: Enable GPCDMA
>    arm64: tegra: Add GPCDMA node for tegra186 and tegra194
> 
>   .../bindings/dma/nvidia,tegra186-gpc-dma.yaml      |  108 ++
>   arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi     |    4 +
>   arch/arm64/boot/dts/nvidia/tegra186.dtsi           |   44 +
>   arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi     |    4 +
>   arch/arm64/boot/dts/nvidia/tegra194.dtsi           |   44 +
>   arch/arm64/configs/defconfig                       |    1 +
>   drivers/dma/Kconfig                                |   12 +
>   drivers/dma/Makefile                               |    1 +
>   drivers/dma/tegra186-gpc-dma.c                     | 1298 ++++++++++++++++++++
>   9 files changed, 1516 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
>   create mode 100644 drivers/dma/tegra186-gpc-dma.c


For the series ...

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

I have a couple minor comments, but otherwise it is fine.

Jon

-- 
nvpublic
