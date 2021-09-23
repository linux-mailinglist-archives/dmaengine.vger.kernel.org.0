Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 170E241686B
	for <lists+dmaengine@lfdr.de>; Fri, 24 Sep 2021 01:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243507AbhIWXVm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 Sep 2021 19:21:42 -0400
Received: from mail-bn8nam08on2057.outbound.protection.outlook.com ([40.107.100.57]:36704
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236363AbhIWXVl (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 23 Sep 2021 19:21:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lzEMje1UujpQnooxM+UjUbE5eyx2KIjiahr0xgEYfJrpQh6vd6NQdOaRZyTf3uB3Dofyiv2IhVaX5g7Q6IkBISYmjZLA3nXWc9bJ9GJknA7wr39N/sKlGAfXI/3wtluGSRv8GnyLiagXd3AlgObFiQlyc7EI4j3cI86kPdWGP17VW46Q1rZ3erY+KzletQVu99+WFBTdj6Gf8aFm7M8lsgUjWkXc5IaSq1Mebl5OVm+c9C+FoIygLvXiaDJnfIvreFNpeccXgb1Zk72daGaHK++gUrMIxXK+o76Ll/vEz4xv98CvfcqS6mcfLrEMHIOf+xw/4lWIwy/Q7zw+ua/c6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=7Dxd0TIG1GXdS8oRX+eYQ7myA4OTFGApfP2v/dTYjcg=;
 b=MaWxlg+Vwvz02iiav5zl+uSGA8tG9dmtMsVkc+8ylIP8xhG2zufCeO7P+oqiHXLoVlm5dNCkRwh0ndVro6gW4z5kZg3fTqSGt8PXOChfCLW0/3wdZGZ2/+sLefK2n7Nkl7lsBbV3j7LUWCsacT9Nwq6cYcEMCNLUMLVJbiI+SYtrxsT3YP9XRDSQrJ1Cq/uFIY0vaVwTuVzs2+p01CtNEmiEzdSsjv/vG3ri5K5nYrRn3IgpGB9D0QCYa+nQLzEdVQZNmkTN+NUCinIaxRVIt2SrIz34yvg4xR72171oLb4cGxAlSi9COE351JUFI5W1IkZPPRMrPcBpdIgtLT0X8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Dxd0TIG1GXdS8oRX+eYQ7myA4OTFGApfP2v/dTYjcg=;
 b=cnhLvNYOkF8QR+Ux2Ilj1YWXnYX6agXFjXwI68/MlyE6gCY4uvYk4VL0hSlQmeWzqQSB55N2IsRo5etN1mw1xW62Q6EsI97Te5R7Ei43LVo55IT1jVFxo/pPHD+TKDZ1lfh1xlccTbEPN0Ts/EGo110QqT8immU/PUaWQdBwds9L1zn5j1luTVEqPpRomgfdNnPBQF1MQIWthQ513r+M5DsOeBYogMSS32k5vSLzUXwMZE81XBWcT4ywPkoNv+qjQEHpiDFJW6aObdB3k2Ru/GbrQqQ1VPmTUX7CQxvzIIcqz9c6oakx4A/Fxin2aiW7XE5DlIWZr71eCHZ7BzDVlg==
Received: from BN1PR12CA0012.namprd12.prod.outlook.com (2603:10b6:408:e1::17)
 by SN6PR12MB2669.namprd12.prod.outlook.com (2603:10b6:805:70::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Thu, 23 Sep
 2021 23:20:07 +0000
Received: from BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::60) by BN1PR12CA0012.outlook.office365.com
 (2603:10b6:408:e1::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend
 Transport; Thu, 23 Sep 2021 23:20:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 BN8NAM11FT033.mail.protection.outlook.com (10.13.177.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4544.13 via Frontend Transport; Thu, 23 Sep 2021 23:20:06 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 23 Sep
 2021 16:20:06 -0700
Received: from [10.26.49.14] (172.20.187.6) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 23 Sep
 2021 23:20:02 +0000
Subject: Re: [PATCH v7 4/4] arm64: tegra: Add GPCDMA node for tegra186 and
 tegra194
To:     Akhil R <akhilrajeev@nvidia.com>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <kyarlagadda@nvidia.com>, <ldewangan@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <p.zabel@pengutronix.de>, <rgumasta@nvidia.com>,
        <thierry.reding@gmail.com>, <vkoul@kernel.org>
References: <1631887887-18967-1-git-send-email-akhilrajeev@nvidia.com>
 <1632383484-23487-1-git-send-email-akhilrajeev@nvidia.com>
 <1632383484-23487-5-git-send-email-akhilrajeev@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <c983e6ba-e17a-3149-8c56-7dc953fbcf7b@nvidia.com>
Date:   Fri, 24 Sep 2021 00:20:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1632383484-23487-5-git-send-email-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4db1b774-a3c3-409f-c570-08d97ee8ae2c
X-MS-TrafficTypeDiagnostic: SN6PR12MB2669:
X-Microsoft-Antispam-PRVS: <SN6PR12MB266921461FFE96454C0D5072D9A39@SN6PR12MB2669.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3lPDmDg5awBQtR9uA9nNwNckWmwynl2OmjYK+NiVxsgSkfB3olKlqILJJpHM3SEvbgEw92JtmTES8aYYKXHtAijuoUR/PI4jtxdbZ7Hcy99BbJdlU1Sm++n5a9vavzJk5Dg9JQjvi1P3QXzaqib8OLdeLThcBemAgHQwtflVj45jCCZjnt5afvBIRp979w5qtqERehvcbWtue5a/Jfo7Mq13hTZKKWQv2BP4exybfbrZtpiask37RTpQvH7IAz/OvX5ez8oH4GEt8g6lzl+el6ZlrutYTblbZO62/6caC7jozQiIMCK7sC3TkPp8rcMDdPFAH/5amClFg/ADcMF96+1UqvIXE51GroBF9lLYm/EB+tgZ/Gu73ugtH65EORnsq6RNN6UiUWID6zx677UdnmUjZBC30jsyr1rLA6pRniiZmM8oSVBVKRZzAywDqEARC7IX7msqayOZI9kcbxguuvXuQGFmgaaXxwDcb9889c7BRME8j8CKEMkKwYVAS6bAivJaVahk54qrlkTVxjxJkwRrHf+PUJnCbG4f/oovMGWBWZiU+JHiS1Dua0pjaxAru19vjP+AdQ1B9daBxp5VLWzjIRyzf0Oyi/SnACuxVyX2LTh3tljLY05DEiLoWugi8wf4tA/ZoVR9DYwbUYAhYcDRMPh/NR+s8yvIiJukgeVxf/cVHb5aWOC6FwOJixtftgBlu1VtiZmw0Im8s92FEYab37H2uunIJzeYUc1PMqE=
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(508600001)(5660300002)(8676002)(6862004)(356005)(7636003)(8936002)(37006003)(26005)(83380400001)(316002)(2616005)(54906003)(70206006)(16526019)(6636002)(47076005)(86362001)(82310400003)(186003)(36860700001)(336012)(31696002)(4326008)(53546011)(16576012)(36756003)(31686004)(70586007)(2906002)(426003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 23:20:06.7648
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4db1b774-a3c3-409f-c570-08d97ee8ae2c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2669
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 23/09/2021 08:51, Akhil R wrote:
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
> index e94f8ad..6f62d78 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> @@ -73,6 +73,50 @@
>   		snps,rxpbl = <8>;
>   	};
>   
> +	gpcdma: dma@2600000 {

gpcdma: dma-controller@2600000

> +			compatible = "nvidia,tegra186-gpcdma";

Please fix the indent here.

> +			reg = <0x2600000 0x210000>;
> +			resets = <&bpmp TEGRA186_RESET_GPCDMA>;
> +			reset-names = "gpcdma";
> +			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
> +			#dma-cells = <1>;
> +			iommus = <&smmu TEGRA186_SID_GPCDMA_0>;
> +			dma-coherent;
> +			status = "disabled";
> +		};
> +
>   	aconnect@2900000 {
>   		compatible = "nvidia,tegra186-aconnect",
>   			     "nvidia,tegra210-aconnect";
> diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
> index c4058ee..9988717 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
> @@ -49,6 +49,10 @@
>   			};
>   		};
>   
> +		dma@2600000 {
> +			status = "okay";
> +		};
> +
>   		memory-controller@2c00000 {
>   			status = "okay";
>   		};
> diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> index c8250a3..27571da 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> @@ -72,6 +72,50 @@
>   			snps,rxpbl = <8>;
>   		};
>   
> +		gpcdma: dma@2600000 {

gpcdma: dma-controller@2600000

> +			compatible = "nvidia,tegra194-gpcdma";
> +			reg = <0x2600000 0x210000>;
> +			resets = <&bpmp TEGRA194_RESET_GPCDMA>;
> +			reset-names = "gpcdma";
> +			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
> +			#dma-cells = <1>;
> +			iommus = <&smmu TEGRA194_SID_GPCDMA_0>;
> +			dma-coherent;
> +			status = "disabled";
> +		};
> +
>   		aconnect@2900000 {
>   			compatible = "nvidia,tegra194-aconnect",
>   				     "nvidia,tegra210-aconnect";
> 

-- 
nvpublic
