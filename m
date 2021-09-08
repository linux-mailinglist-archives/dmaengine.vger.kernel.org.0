Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3723403DC5
	for <lists+dmaengine@lfdr.de>; Wed,  8 Sep 2021 18:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349702AbhIHQqS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 8 Sep 2021 12:46:18 -0400
Received: from mail-dm3nam07on2076.outbound.protection.outlook.com ([40.107.95.76]:42240
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1346619AbhIHQqS (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 8 Sep 2021 12:46:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3ItZzFYmX4VT85nfbCalrc2gRALSAZ8D0vSMMR/O93iGCcbKoagzJqKpHAlM0mjwumlcsS/HIz30VkuINTAAW1NSxDgRN8D2ktV3jkCoVhur32zuerxCGt31Ia5dzgR2W4M6Pdq8sXgrryNAteHMwqZALDYyj3lDaIVSB63R/b+q559UfgCnUQ3JqxIERKyOa+2sw/8XHZs9uriVH5OqSq89US4RA38cd5sIhDbRsSE8a5JFa2GJViIpq+ARdSCE7JUtfALPJjZfLCcw59OOg5RpOxOrOM0AA312OiOKm/o2qCUXKX84tHl35gqg7H/j30k1r/YFGRJQzuTeWNa1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=YbAkEjjHE97kyI38nYY/30bFY28bUsuVbbSkTq+HNc0=;
 b=kzrAMzoUvWMkUpdVS4ESEd+gpPww+RmohpEodfxBK5dN5wXtWxmT7eHC8pjNLLGT2NgNO9fiBJ/pP8Af+a94/q4CIAT/ilHRD2jdQWKFw/wB2cFefkesrzHSS8VIR6CfXds/Oibi4alUWgT0GHM1NckxDaIoP5RmhK/GNhk+o35AE3hyUszkhAWUMrIn1jdQBKyLLqDVQXbi5rZoUpMW05LVvaxWr1pkAO8eQUWjTBbb6S+oiaKgwABmUBwyiIqd4pssAezhXxFvIgq5lK02cd//ft/GI8wqKPWp/uW+Iwc88OvCwF/BIGCampufDB7X9Vew0HPL/GKXTQl4SHuLKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YbAkEjjHE97kyI38nYY/30bFY28bUsuVbbSkTq+HNc0=;
 b=oWFaNnZks4WHlKoJD6BmxpEHhirCkatP+KlMQZiT8ewhz5XIM30/Rk9J3SBt3Ix+IRh8wko5bwMSi9m/vXnQPaGjfDSXW3+bG/xGuBFYc5OZFLPg+eXu8sDvNLJ7YFDvyxX7mSlR1uclX7++uWWAiJIFI0HiwDntOFGSGblMLacqwJazl+A0VJWbSJJosjqeNFPm3E6YkCNB+An5F6F3DpdBbmuvYfikJvM6nvZxMv+YzjxzrLf5PO4J8Zyfc5v1zVTvVf3Z+ZHS24WJX8RFKYTNZ/ek03dbgonETHya7SRgIYS2Bdr+epg7pSSh9pw/eYDazMwd3H2C+5sqTGXxMw==
Received: from BN6PR11CA0005.namprd11.prod.outlook.com (2603:10b6:405:2::15)
 by MN2PR12MB3360.namprd12.prod.outlook.com (2603:10b6:208:c7::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Wed, 8 Sep
 2021 16:45:08 +0000
Received: from BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:2:cafe::b1) by BN6PR11CA0005.outlook.office365.com
 (2603:10b6:405:2::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Wed, 8 Sep 2021 16:45:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 BN8NAM11FT065.mail.protection.outlook.com (10.13.177.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 16:45:08 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 8 Sep
 2021 09:45:07 -0700
Received: from [10.26.49.12] (172.20.187.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 8 Sep
 2021 16:45:04 +0000
Subject: Re: [PATCH v4 4/4] arm64: tegra: Add GPCDMA node for tegra186 and
 tegra194
To:     Akhil R <akhilrajeev@nvidia.com>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <kyarlagadda@nvidia.com>, <ldewangan@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <p.zabel@pengutronix.de>, <rgumasta@nvidia.com>,
        <thierry.reding@gmail.com>, <vkoul@kernel.org>
References: <1630044294-21169-1-git-send-email-akhilrajeev@nvidia.com>
 <1631111538-31467-1-git-send-email-akhilrajeev@nvidia.com>
 <1631111538-31467-5-git-send-email-akhilrajeev@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <81fb8278-a01d-c557-5080-6f5115f4682b@nvidia.com>
Date:   Wed, 8 Sep 2021 17:45:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1631111538-31467-5-git-send-email-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7237c22-ccf4-4820-5afa-08d972e80472
X-MS-TrafficTypeDiagnostic: MN2PR12MB3360:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3360FCE820F0F82A902A9B07D9D49@MN2PR12MB3360.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CGK7HZCsUyz25sjN728+C3crSHIelVgg7547zxYQC8x/O3AT49N6fgHLhfSL45L+HmXukqkOmdm+lQvsSatt5zhc9ZCJNauGxYKQ8DMSvmNSGL4WvTSnTP1w30kJAnZbOor81AuVmKnKR0IcHA3uW027Jsg1/4uDP94yzGQDHgh8rNSZfexHyQG4oq2BmxG1UPBqjwWQZwlSOuphqaJH1DQm7zMpGDbPaQc9LQ/BNZ+yy66j+dPYeoYjraWC7L9tbmycuNpgDzIz0X1VDA4j5XjBqCkAZuPGcYWAqUXQidN0j3ZCdJxp+ZpFl5TiYnVMPhckzexidhUJ2+2QaBHcLm2/gwdEgMIYwm6krO82vdVxvSEw/p7WtrwxuU7Cztl02+CJDXK0qhMKXb/D0zR+DiE78oXnb3nJFORWi3sjlOnXLdrjRq5/PGFDb8WbfEVXSi9UIEsCftGj3Eh6dOQ0DXAFAFDNNyMND06suQpgvs5Qic4eKr07veXa+ptl9p/t0U2ESKfL9BT5A+OkYvzW6pfydPkS3CkluDBYSeV6qLOH/x+a+yrNNqxRvF2+BsSKU96IHPAEe5DsemMalVnydRGyAvrJfcEFXYwH6JzVaBBf+ZyjJUuEODwLAqbypAhZs2D4PNSyv94tg+3ghQcuGQydda9sShk+9GpviOvUBVP3WpTuIR+452Gg7QS0BFmsvxsp1HA/SNVeD4f9M3YL9gtFQF9hQZ2YNdbuUY0yxlw=
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(5660300002)(31696002)(508600001)(2906002)(86362001)(36860700001)(26005)(6666004)(8676002)(4326008)(54906003)(316002)(83380400001)(336012)(70206006)(16576012)(6636002)(37006003)(82310400003)(70586007)(8936002)(186003)(6862004)(47076005)(2616005)(426003)(31686004)(36756003)(53546011)(356005)(16526019)(7636003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 16:45:08.0619
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7237c22-ccf4-4820-5afa-08d972e80472
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3360
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 08/09/2021 15:32, Akhil R wrote:
> Add device tree node for GPCDMA controller on Tegra186 target
> and Tegra194 target.
> 
> Signed-off-by: Rajesh Gumasta <rgumasta@nvidia.com>
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> ---
>   arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi |  4 +++
>   arch/arm64/boot/dts/nvidia/tegra186.dtsi       | 46 ++++++++++++++++++++++++++
>   arch/arm64/boot/dts/nvidia/tegra194.dtsi       | 46 ++++++++++++++++++++++++++
>   3 files changed, 96 insertions(+)
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
> index d02f6bf..f68291c 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> @@ -73,6 +73,52 @@
>   		snps,rxpbl = <8>;
>   	};
>   
> +	gpcdma: dma@2600000 {
> +			compatible = "nvidia,tegra186-gpcdma";
> +			reg = <0x2600000 0x210000>;
> +			resets = <&bpmp TEGRA186_RESET_GPCDMA>;
> +			reset-names = "gpcdma";
> +			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
> +			#dma-cells = <1>;
> +			iommus = <&smmu TEGRA186_SID_GPCDMA_0>;
> +			dma-coherent;
> +			nvidia,start-dma-channel-index = <1>;
> +			dma-channels = <31>;
> +			status = "disabled";


Looks like the comments from the previous version are not addressed in 
this version.

Jon

-- 
nvpublic
