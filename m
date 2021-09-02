Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 665153FEC36
	for <lists+dmaengine@lfdr.de>; Thu,  2 Sep 2021 12:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243444AbhIBKhN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Sep 2021 06:37:13 -0400
Received: from mail-dm6nam10on2086.outbound.protection.outlook.com ([40.107.93.86]:10304
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233714AbhIBKhM (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 2 Sep 2021 06:37:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IjbOo0r2y8zIDokaU9X1Xr0DIyjd23EuxIWwL8lePeNiUT5r4X6ltn7Ng/WonE6KlSX9c5EVYVeZ/CQrqZ3FeJ1ETrLZG46Zwh95cwfTQI68u1qtxI95smaS6Z/yvsFVeUagiIy1drXHsw6H0sndP+dnWGjSxxwuX2dVIh4jluY/8HHMkXaG/zC9S5+3c/Asbc1Eo8VdmiV9JnBFFncxuPWXS4C6iS3k0nGVin8xtwWMTJua5/3V8hXJUugC/Rib72m/HOD7lHtzj5JFMSyHFbg5Q77OKdT/aR9e40fs/mF41ic8h9gpp0SZQ9AdBcltjt+9+S+uPS5+Ye98bH/7Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3ua5a5nyAISgEgNHLX/VYF3FhSd6h1QvQ3AIgQXrnE=;
 b=IPn0VF21rUqiQuW0XFNIHGpS1VhM95eQdNtb2J1bV89jQx2O0dfFqCZCrEnavwtrThrEPNL2wsffYlcy6gXNjJ11mQa8nxGuQMglAJw3l0ci0i1HY8A6HTEIaoa0dcQBPw5xyxspoCwjdTKzmyx7fEtWLmGW8K2wLI1x4icjiGxXGPRUFQXPFLE2Bw43oGV0Mgrrtqxw4lRA2WSwNSiXvT3cEDWhzdO1P1QJ4BzvzyGCrhnHm3ToHtZlTWM7vwA/lCE69eUZS1lMX/ub5l60R8Wsjy1nm67qPG9CsrrFL7i+AOcGlOzd/qIglO/6y2qVflAo1fL58r5FgGhRwHa8vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3ua5a5nyAISgEgNHLX/VYF3FhSd6h1QvQ3AIgQXrnE=;
 b=ljtqRp+5gqLZFuGpqp645/Z+dFmT02q1HPCwdc9sqs//S4+NW9ASe+YgkHyZu/zkAbkXsGGVdbTzXdb+rhv4lwKTN7E4xXFjMoT76TfM0YFmjgYzwjr19iCdSvIAHEtMd/odH9r+07sGDoLA/5hbnFfdLwv8ekabvtq3W0rkYAHvw1GGsNetqCOKEjJQJ8RlpWD1u0ini3nsPQ3RHbQK0Ghtr7ir604E7UjJS+hwEx5IQQC115NqZfYAHryEMUfqh62APKbxrwRjjDDhAVH7iihTEzZ1HOkYjxECmIkxUgejcjudGHQPedsbGF8BkAfpOj1wXzbKTwGr59gS4gZ4BA==
Received: from BN6PR13CA0071.namprd13.prod.outlook.com (2603:10b6:404:11::33)
 by MN2PR12MB4374.namprd12.prod.outlook.com (2603:10b6:208:266::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 2 Sep
 2021 10:36:13 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:11:cafe::2c) by BN6PR13CA0071.outlook.office365.com
 (2603:10b6:404:11::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.6 via Frontend
 Transport; Thu, 2 Sep 2021 10:36:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4478.19 via Frontend Transport; Thu, 2 Sep 2021 10:36:12 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 2 Sep
 2021 03:36:11 -0700
Received: from [10.26.49.12] (172.20.187.6) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 2 Sep 2021
 10:36:08 +0000
Subject: Re: [PATCH v3 4/4] arm64: tegra: Add GPCDMA node for tegra186 and
 tegra194
To:     Akhil R <akhilrajeev@nvidia.com>, <rgumasta@nvidia.com>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <kyarlagadda@nvidia.com>, <ldewangan@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <p.zabel@pengutronix.de>, <thierry.reding@gmail.com>,
        <vkoul@kernel.org>
References: <MN2PR12MB41438B94148A6D522C056771A2A70@MN2PR12MB4143.namprd12.prod.outlook.com>
 <1630044294-21169-1-git-send-email-akhilrajeev@nvidia.com>
 <1630044294-21169-5-git-send-email-akhilrajeev@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <744b7d8a-5869-9dc4-75a0-36c696c54e36@nvidia.com>
Date:   Thu, 2 Sep 2021 11:36:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1630044294-21169-5-git-send-email-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62d03701-0a29-43aa-23f2-08d96dfd7c3e
X-MS-TrafficTypeDiagnostic: MN2PR12MB4374:
X-Microsoft-Antispam-PRVS: <MN2PR12MB43742A0F4D3BD5E09C7F57C0D9CE9@MN2PR12MB4374.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HOYtZCkjX0h+6iHGN5Bjg/IS4e7OERXnPLkke7775MjGgBDvCLbcIsHFPjFywVek0X46FWQthNIP6xcVnK49sl/ramkOWXVlOfrpngavlxFBSAi22wtuuDdJWQWzfN5lqcw5Vel2V0uuTytkV1QXgyxf4WITHhBASakxvYzyIjKHTNWmP+/GX869Ch9G0RmGjy3QTT4RBfZngxrXDb6/+vO0FwztSga//TVTqIDWbjmDlQ5b8w3vhtkFqaTSjMJcObtC3bq6s9KJpwsKzRJrhJR12jHjxoYsEZLUA2zcvBZB9mv9TYAPuAhsgMe5JtsxPJMNSyUIKn19PSF0R2Bx6yMLZO3HjKU6Ye1jCoGutWGB4p9PUQSbtzPyNFsnDEamf6ptDhiN4sUdYkgyKK6LiLOta+WjjW95Y8/YFSZhCEzwK6KJ5zEu2HibOl4swAvv8f6wrWvONm+KHgkgfGAshW83O+ng4UvbigduZtq6xzEWYQ2t3NL7yp0uTn1aefCExJi/rxj2UkTVKcrwxoCZscvo9Ubgce4YDsYgpWhNl221FWhW40od44uW1q/4NKDG+e5x9pRFApMKh70g42acKBUJAUidH7XPjc8kyRW9+UhcieJiVyCVVLx6Z2DvgTzOdT0/MQ0DkZWKuvErioRq9tV4B03fZvLq0tzXJZBhtqY7UYBb3j+MrCk8/EjUerhgx3rT56E5Lc+ZD5keRpWmx8kUrfyK0G6TKYsE5oT1Pfo=
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(136003)(39860400002)(396003)(346002)(36840700001)(46966006)(83380400001)(8936002)(356005)(316002)(36860700001)(2906002)(478600001)(110136005)(36756003)(31696002)(70206006)(47076005)(426003)(82740400003)(86362001)(16526019)(70586007)(336012)(6636002)(31686004)(8676002)(5660300002)(2616005)(4326008)(53546011)(186003)(16576012)(7636003)(82310400003)(26005)(54906003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2021 10:36:12.6657
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62d03701-0a29-43aa-23f2-08d96dfd7c3e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4374
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 27/08/2021 07:04, Akhil R wrote:
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
> index d02f6bf..9b565155 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> @@ -73,6 +73,52 @@
>   		snps,rxpbl = <8>;
>   	};
>   
> +	gpcdma: dma@2600000 {
> +			compatible = "nvidia,tegra186-gpcdma";
> +			reg = <0x0 0x2600000 0x0 0x210000>;
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

The above two properties are not defined in the binding doc and don't 
appear to be used.

> +			status = "disabled";
> +		};
> +
>   	aconnect@2900000 {
>   		compatible = "nvidia,tegra186-aconnect",
>   			     "nvidia,tegra210-aconnect";
> diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> index b7d5328..bc85c91 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> @@ -72,6 +72,52 @@
>   			snps,rxpbl = <8>;
>   		};
>   
> +	gpcdma: dma@2600000 {

Please correct indentation.

> +			compatible = "nvidia,tegra194-gpcdma";
> +			reg = <0x2600000 0x210000>;
> +			resets = <&bpmp TEGRA194_RESET_GPCDMA>;
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
> +
> +			iommus = <&smmu TEGRA194_SID_GPCDMA_0>;
> +			dma-coherent;
> +
> +			status = "disabled";

You enable the GPC DMA for Tegra186 but not for Tegra194. Any reason why?

Jon

--
nvpublic
