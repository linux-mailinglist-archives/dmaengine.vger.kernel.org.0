Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 336753FED0C
	for <lists+dmaengine@lfdr.de>; Thu,  2 Sep 2021 13:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234035AbhIBLgc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Sep 2021 07:36:32 -0400
Received: from mail-mw2nam12on2087.outbound.protection.outlook.com ([40.107.244.87]:15201
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230256AbhIBLgb (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 2 Sep 2021 07:36:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JlIhIWZzy58F2FvyvM6zLku0MYxKcgchiLApFJE2y/n/oPQZS+jSr6irETfXxvo7ZTyxJ+OPZvrQRL6n+QQb9XjhYia61ztVFo2ORrdTD0wwRdTHRU+py4iq7P0Nk7JIXcq6Gnpt1OEjHejBw3DlAOe2FTP0oIHFXj7VGQnW6Uk2l23GzMEfh0GMWtr5f9grAT9emBI1GugZfUfGAvhQsPvrMBNIwPEtu5o70BY0R/gcaqm/uUtMquDWcQbPQ3G982JQvQLSs1XsJUFoDSM3Ntj99LZDLAL7wOH2m1ajXH4M+6n+Epoc3JHt6yv4BBpwKx/pVOlUmm7/l0q+KtuD2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=W0kLkBWH8Ye/Hr4b2fXAhlS4Ff1BEZsn9hFqlnGhplI=;
 b=Cn6RUgeU46V5tsZMTG06cOyZqkgFyABLKBKwxcd5qw7dDdarxErbgLMF/ibTQ0fvQ5csK2u0zNH+wSkWy/BWEzpjYZ9coUYOPjbHou5CScB8BE4Xnm6W9/dz87eFgI2JMZe0DG0OpWQijzwoVLi9CLXnRp88Zvq+zWPHH6BCPTi5NGdGLFqXdGKyDEyZ2MIGBtPlJxSpgRvV0YS1sc4gKAyizWOhK+u/lf/VGqwBqtYUoxYkQDaTMAmrtp+i0wbajkreb/+JMD36x0NyfC3OU6052qLCDQr95DtSPrpCzEEy5dpish3SUYP/sx6NRL0mvfPe8R54aAmV1TQmFcCmWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0kLkBWH8Ye/Hr4b2fXAhlS4Ff1BEZsn9hFqlnGhplI=;
 b=Ppuxyr0lekFYd0lnrily3yxX8enZRz1bLl754ua8DYq66O82u1zTyHuTsr87k+rfQNVzYtYBbmJOPqYvn91VQHRDjGCrAKyCG6ShOuvRpYEiH3Tq0E6/aEQucsRpIoHtDuPslEFShNZILGQe4Gq1c62soePMkRE+nyq7KE4GmV7/yk9RFOVyVlND9Yq4SxKFI5nwaL7ho2v8Yt9CNjmWGgbESnPqY06Y0QJrubxo0NEwaWZezg82gCv8tniPMUWy4suWWyh7NnlmctH71uaKlU8WlQYGjBC9NopltA/grK9oJmHcYEmNyk/CzCje26GmhHvSaIGkUEixL6dkWsdImQ==
Received: from MWHPR20CA0005.namprd20.prod.outlook.com (2603:10b6:300:13d::15)
 by MN2PR12MB3183.namprd12.prod.outlook.com (2603:10b6:208:101::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17; Thu, 2 Sep
 2021 11:35:32 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:13d:cafe::c5) by MWHPR20CA0005.outlook.office365.com
 (2603:10b6:300:13d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17 via Frontend
 Transport; Thu, 2 Sep 2021 11:35:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4478.19 via Frontend Transport; Thu, 2 Sep 2021 11:35:31 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 2 Sep
 2021 04:35:30 -0700
Received: from [10.26.49.12] (172.20.187.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 2 Sep 2021
 11:35:27 +0000
Subject: Re: [PATCH v3 3/4] arm64: defconfig: tegra: Enable GPCDMA
To:     Akhil R <akhilrajeev@nvidia.com>, <rgumasta@nvidia.com>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <kyarlagadda@nvidia.com>, <ldewangan@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <p.zabel@pengutronix.de>, <thierry.reding@gmail.com>,
        <vkoul@kernel.org>
References: <MN2PR12MB41438B94148A6D522C056771A2A70@MN2PR12MB4143.namprd12.prod.outlook.com>
 <1630044294-21169-1-git-send-email-akhilrajeev@nvidia.com>
 <1630044294-21169-4-git-send-email-akhilrajeev@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <65f22625-89e4-771e-9292-5ac4d8a82266@nvidia.com>
Date:   Thu, 2 Sep 2021 12:35:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1630044294-21169-4-git-send-email-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b828578-7e9c-4d94-9269-08d96e05c57c
X-MS-TrafficTypeDiagnostic: MN2PR12MB3183:
X-Microsoft-Antispam-PRVS: <MN2PR12MB31839681895156AC032B6727D9CE9@MN2PR12MB3183.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L2i9skP//CjqMB0enIh38GX6/Zh7Nu1k/66XB2r1sp4I2iyxSPOHzfJo4213Jejb7cChRVDH34vsIsN4SftOtckyMqYMUwbGT1sPCTK2iOmugV8HPp3L9/X+2B64bvrLldlHyXL4WWRRttVBTDdNWYkyAXF9TV8TZVO5sbiJkcVSe4IOsPT/PZUm4+Bfr1QFEaQBeOAJpXePtfr1HRGcBA7cNr66t5s3e8JNJ5ltNtT5zJX4B6h0/ekoVhC3GedH/3O+56JGAYuDk8y24+vbC2bbhSOY5Cnv8BN16crsAOysqhd0jmpGvn+K44U+CWSqOZQfpYyjDK62/KicdmhCy2QuxrOjNX1jJt2VDRDefa5pj1POgXf9fk5fLXYhljBiNKFT9BAlTzmAggNVl/6hs7SeRe5KO9S8uUjqiqFq54I29LvUbmPyTbe32EbSfMUFGjOmmKkl9TH5RokIClxJbQExVcrcijEp9jZeZkxkmt2THGxVczGO2pYRKuEgF6k+MP6u/K9A3z+OD0D45tAVK3JSgucdDiZrGbvelyhdiYeCScsoYr/uzjjn4lV7Zr6fVfnIO35tUxQNGI3T+iRHvMr137nVOa+uqE6EGNxIYfkUE4q/X3gKsBrx5g3zHwSrsnVq9cGkjhkXCFu0sm7ezeNLuC9c8/YKbmut8K9UXWGqGcm6PjLpsOZn7U+EFEGoDEd99tH20LZvWXNJhB79szKhC/MCuS5Xb0yrJNNREyE=
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(346002)(136003)(36840700001)(46966006)(26005)(70206006)(2616005)(426003)(186003)(16526019)(2906002)(36756003)(70586007)(47076005)(36860700001)(53546011)(336012)(356005)(478600001)(86362001)(7636003)(4744005)(31696002)(8676002)(16576012)(316002)(31686004)(54906003)(6636002)(110136005)(82310400003)(4326008)(82740400003)(8936002)(5660300002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2021 11:35:31.5813
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b828578-7e9c-4d94-9269-08d96e05c57c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3183
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 27/08/2021 07:04, Akhil R wrote:
> Enable TEGRA_GPC_DMA in defconfig for Tegra186 and Tegra196 gpc
> dma controller driver
> 
> Signed-off-by: Rajesh Gumasta <rgumasta@nvidia.com>
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> ---
>   arch/arm64/configs/defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index f423d08..d247a7e 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -930,6 +930,7 @@ CONFIG_OWL_DMA=y
>   CONFIG_PL330_DMA=y
>   CONFIG_TEGRA20_APB_DMA=y
>   CONFIG_TEGRA210_ADMA=m
> +CONFIG_TEGRA_GPC_DMA=m

Again for consistency please name this CONFIG_TEGRA186_GPC_DMA.

Thanks!
Jon

-- 
nvpublic
