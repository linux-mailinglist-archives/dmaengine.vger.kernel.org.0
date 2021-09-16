Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0A4840DCE0
	for <lists+dmaengine@lfdr.de>; Thu, 16 Sep 2021 16:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238483AbhIPOfY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Sep 2021 10:35:24 -0400
Received: from mail-dm6nam11on2065.outbound.protection.outlook.com ([40.107.223.65]:13601
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238693AbhIPOfU (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 16 Sep 2021 10:35:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B75F6+tZP+nHBB3+gZFtwnWlNY0eVgSDxneJNVoqnMsNjcugWypSPROlDDJIck1ehnd0JmlWXCF+zNLiy8Abh5iAcQOEVZznkuuOYJLREqtMMeAF0/OU+PegntnOpapPoYoaQ12llHqJIq1Ov51+T/vf/ZiXaicErP1rIfCIphhEuAgEYp0xqaDZJEmivLhyw/VPVPxxSHXztoziEXBoTJu4kZKQvXeoS76dF1WjPHVbbysDREpmTrcUPmoVSFLzZHXYPJfp3t7d709G/Vy6Gi9Zoj51rGdsKwWPz/Q45EH0lZ8fUjnKIu5Re8QOm3bHkLHtbIC09BVrkg17YX5jvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=sjmM7nf3FkC9/CKW74tEGimD9wlfwGW9KfAR3EshCow=;
 b=h0Wr9fV2kyg7Ml3edWVBPC0NnoVt3/mC77yP0gLnE6d5mvFVYFmHCRpttHYMqVz0kuJB8n2WPEeLtW43ShXCdit+6BznPlCyK9ynVKiebicQPY1cFh7lLyorh9yOpV5w5BqVIhdAByUpRGGU2ba60uHByaqF2c5rDA55NS+Aur3j4ywM4EzYKsIrSQkQTycDXjqzWX3C54w3qAGdJdF9pyGZHWOSMlMPiSowIvimlF3VUoESU7qevB0eJgf4wYZMhoQEbGer4lCkr75bwHfTV+LWykb/0GA3GQKj5J+ZUiKyXKanE/QVJWnACYPyIf1OzYUsP4gshyl9mSpl/g3WVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjmM7nf3FkC9/CKW74tEGimD9wlfwGW9KfAR3EshCow=;
 b=U+1D5Z24mViRIyWQ/JvV7j5S9Lp2Y9sWEXDFZz2GCW73Rk4BBY7rkToXbEXsLnZ3wC0tLc/R4MK9kRI/A6nlQ3d+CO5TtBa9dCko/HKFwszJtDvbWoOsrqed0Pg4ntPpzdudJbCSTe4l2u73LfIGz3TBW3HspQC6tHR84yX0/K/WJ5Ym8H0F/944/8/LBEp7+JXdLO+udihEd1tRSHvpRozoBgmlSqdx62nvZ08GdwYQ71KVvbJ6KbrSGJHyr7ABFLV0oD3UtxsnSOaedHIutPbBn1y/2rrPasj2nx8kgpHjMHRcJBApYhIKTFzdHwpEHsJkLn/PsLni3mL+RgZS5w==
Received: from CO2PR05CA0090.namprd05.prod.outlook.com (2603:10b6:104:1::16)
 by MN2PR12MB3885.namprd12.prod.outlook.com (2603:10b6:208:16c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Thu, 16 Sep
 2021 14:33:58 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:1:cafe::ec) by CO2PR05CA0090.outlook.office365.com
 (2603:10b6:104:1::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.8 via Frontend
 Transport; Thu, 16 Sep 2021 14:33:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 14:33:57 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 16 Sep
 2021 14:33:57 +0000
Received: from [10.26.49.12] (172.20.187.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 16 Sep
 2021 14:33:54 +0000
Subject: Re: [PATCH v5 4/4] arm64: tegra: Add GPCDMA node for tegra186 and
 tegra194
To:     Akhil R <akhilrajeev@nvidia.com>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <kyarlagadda@nvidia.com>, <ldewangan@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <p.zabel@pengutronix.de>, <rgumasta@nvidia.com>,
        <thierry.reding@gmail.com>, <vkoul@kernel.org>
References: <1631111538-31467-1-git-send-email-akhilrajeev@nvidia.com>
 <1631794731-15226-1-git-send-email-akhilrajeev@nvidia.com>
 <1631794731-15226-5-git-send-email-akhilrajeev@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <36e2f2a1-8561-4f31-214d-fbc65099ada5@nvidia.com>
Date:   Thu, 16 Sep 2021 15:33:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1631794731-15226-5-git-send-email-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 308e27a3-29ca-49f9-1b2e-08d9791f04a4
X-MS-TrafficTypeDiagnostic: MN2PR12MB3885:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3885A843EEAECED32D8AD234D9DC9@MN2PR12MB3885.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xz42zcPUJBa2HjhCA/Kp2cqG8GTE0B6zrFxeZo/eXSI+t+lBbKnkeNj7dG7jJteML9MtMDItD4XWhJ006wbTOMCKoYeYiV/ikJ5oFdXkQosuIZqUwiFDwRCz21HWEhJMwacqtiH1ZcdrprvGswTwWq8asL5yn1lZ/anWoVG7bfr4ZqI8iuED/BkAV5K9AuJ1G36MSXf9FPUZ5FGRNXsZcmliXXOFQrJ3dqZDq4IlA9V9J/ntvxH44FrgKkD7F1wA5esv9e37efj+4B3mnaPj2Og6/q+4vWpeFN7hlMnNYX0vigYjCecdm1BM/NYZ/TJB60GuwDYNogc4ytBQv/3aFA7f/53Ps6NZY4CZ7nY+rnWwtv/LLBszDO4nox2Di1uB3lTsJcPKWjZYwowQM+7SvHkmo9aPI5BgubUsVRYk3QzPJUF3lGj4yK53S2FRiDfBZ0QgiZGj9OEhWS7QgZCKczr8g2HGmZznoMQZ4hOjWwrvKn1jrDF5xkOQ4K0HfqGAPogpcnLjJn88IT5vaoTPrBSj/fLCh7R+SnfffEsqNBgcCi9e9ETGnlh3PTkwzw6Bax8nRzkJwvjPPGucTLHG6QyRlB4TKom2Y9CWpvOaS3zPV6rpLKGLXlNlwu2fb3j37PqwTFaAaKsdijXafLvNeUB68+mnJF3qtnp4rkuib/xV033WY+iIGUnqWvj0yJqVK/8EiYUmQMSgAQCp/4A6ar28PS+kYfIGs13gh8H9UpI=
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(6636002)(26005)(36860700001)(8676002)(37006003)(16526019)(6862004)(186003)(70206006)(86362001)(336012)(31696002)(16576012)(36756003)(8936002)(5660300002)(47076005)(54906003)(82310400003)(7636003)(31686004)(4326008)(53546011)(2906002)(356005)(426003)(36906005)(2616005)(316002)(70586007)(508600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 14:33:57.7407
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 308e27a3-29ca-49f9-1b2e-08d9791f04a4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3885
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 16/09/2021 13:18, Akhil R wrote:
> Add device tree node for GPCDMA controller on Tegra186 target
> and Tegra194 target.
> 
> Signed-off-by: Rajesh Gumasta <rgumasta@nvidia.com>
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> ---
>   arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi |  4 +++
>   arch/arm64/boot/dts/nvidia/tegra186.dtsi       | 44 ++++++++++++++++++++++++++
>   arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi |  4 +++
>   arch/arm64/boot/dts/nvidia/tegra194.dtsi       | 44 ++++++++++++++++++++++++++
>   4 files changed, 96 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi b/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
> index fcd71bf..71dd10e 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
> @@ -56,6 +56,10 @@
>   		};
>   	};
>   
> +	dma@2600000 {
> +		status = "okay";
> +	};
> +
>   	memory-controller@2c00000 {
>   		status = "okay";
>   	};
> diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> index d02f6bf..efa6945 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> @@ -73,6 +73,50 @@
>   		snps,rxpbl = <8>;
>   	};
>   
> +	gpcdma: dma@2600000 {
> +			compatible = "nvidia,tegra186-gpcdma";
> +			reg = <0x2600000 0x210000>;
> +			resets = <&bpmp TEGRA186_RESET_GPCDMA>;
> +			reset-names = "gpcdma";
> +			interrupts =	<GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,

This is not typically how we fix the indentation. You just need to align 
the subsequent lines with the first line in the property using spaces.

Jon

-- 
nvpublic
