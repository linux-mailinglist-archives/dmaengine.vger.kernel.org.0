Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02C3D3FEC57
	for <lists+dmaengine@lfdr.de>; Thu,  2 Sep 2021 12:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244817AbhIBKnp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Sep 2021 06:43:45 -0400
Received: from mail-dm6nam11on2060.outbound.protection.outlook.com ([40.107.223.60]:29408
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S245041AbhIBKno (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 2 Sep 2021 06:43:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0wCkCt4reZX5/pI1oN8+MTEdN7nOm1KB2z2zTQ0lxK9IoA+ilLncP3QHGdWuaXF2nROSELOkDBKe0uSlJ60AF0BIY34de8e2SquIFMCX/LEq0r9ACdz3SsB/x81IV1HGA5al6aG8LbzaEr7QngNyFB6UXydSZzOdaRcR0v46cWon37T5pfLo1UQ6UEmtFhFYz8x78WX1AtOH+ibTcGYR2iu3r0xiXPm0Y91+krv6/P6CSToF/FBUoOpvIn9apyB2yDMT8ZbwZpQu9ASIl+jWcbBjuzGF/YaicxTEPjGjWnh1NoXyMpzrBWTmnafcZab6pSISOtoAz0pdH0f1App5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOh2HwgVF+wTFJXT3cl5gelwYic0WEx4a7udXKw2BuI=;
 b=PaFrA0wqczXTHtKbWjV19EaEYzXjUzxoZfk3nKqw4UzWkn9znbTMXOYuuCgq45d9Ad7rIJf2vkCMvK7nbB8bk18f1Et/3ZQQodQuRLN8wd+2kUOW3NjTTL/L5tqKDKDwEwPd7Sgrvh0pulzH0tQYlmNIUPujs9tCAnmcqgexw7SPBR+PjkLPRwhrdn2KzEAcSNIQnLSWwVvns1W6Wccnqusus1PKaz9U596OpcLi/35PawEkuXGzC3g8/O4osAR/clnlos8MD2VvBbr5FlSa7VGyIuyaUpixiLuhbaj2jWXaGDmG9fjpi686sCk31LlLNwTowXZuU1NEH0ZuS6fFHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOh2HwgVF+wTFJXT3cl5gelwYic0WEx4a7udXKw2BuI=;
 b=XV0234FeEq7jC6u6zB9UZfJDFYm8+E5QGi8dCSQm9h7kkd/IuPwImoHt5ut7UXCkMp1C0jy/z5j2tC6mC+Sw+uArvDIH89M2vCs7oxNC8tguZBZTrvE3EoU7WFcSgMfgIssdeEpFy2daBTjvG3EW0ga9BCAb68N86nXBbtu99+0DZTI9tybJJysW9SigHfwS+Pd2RXJ5vKb8absgDJAdP4kY++aC9PvLW73eZlhiRJLExs9ADlS5agb7gVqY5xRwCsjnyniResKM0KqdbWS2JgRgVHtKNvx6ZneH47uaO7Lw7pME6cFoBk0ltEpQavHN8aaP+3741843y/RteTftPg==
Received: from BN8PR16CA0029.namprd16.prod.outlook.com (2603:10b6:408:4c::42)
 by BYAPR12MB3269.namprd12.prod.outlook.com (2603:10b6:a03:12f::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.24; Thu, 2 Sep
 2021 10:42:44 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::b6) by BN8PR16CA0029.outlook.office365.com
 (2603:10b6:408:4c::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend
 Transport; Thu, 2 Sep 2021 10:42:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4478.19 via Frontend Transport; Thu, 2 Sep 2021 10:42:44 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 2 Sep
 2021 10:42:43 +0000
Received: from [10.26.49.12] (172.20.187.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 2 Sep 2021
 10:42:40 +0000
Subject: Re: [PATCH v3 1/4] dt-bindings: dmaengine: Add doc for tegra gpcdma
To:     Akhil R <akhilrajeev@nvidia.com>, <rgumasta@nvidia.com>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <kyarlagadda@nvidia.com>, <ldewangan@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <p.zabel@pengutronix.de>, <thierry.reding@gmail.com>,
        <vkoul@kernel.org>
References: <MN2PR12MB41438B94148A6D522C056771A2A70@MN2PR12MB4143.namprd12.prod.outlook.com>
 <1630044294-21169-1-git-send-email-akhilrajeev@nvidia.com>
 <1630044294-21169-2-git-send-email-akhilrajeev@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <e5d01478-6129-6161-43f6-59f2c9322478@nvidia.com>
Date:   Thu, 2 Sep 2021 11:42:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1630044294-21169-2-git-send-email-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 018fe264-ed4c-438e-35ca-08d96dfe65a2
X-MS-TrafficTypeDiagnostic: BYAPR12MB3269:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3269CCF6E80419AE35981D72D9CE9@BYAPR12MB3269.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: haqh1gsyMtyinCxSyhVp2aRW7Mf3+gzz3K+Y1idE2fBTW2mrRbmkTo2dsiB1YqX0e02nGHWyuYA1OlUAAad5FrsDMPsgcDJQmdKsWe0ONTpLqMnpEBmYG3Y+U6Cb4pFi8KPxh9Oy3qGD0wCU9+ZERBCMYZ/sAPF0gmqrgEEdsJAPPSrZstdCdZM0aL9I1kETarkn+KAdxglCpcfa3RilSgrlhSnIhDL7E5eDlEn7OwMkWRS/8gpjBBq0n0f3V8jsTa6ThNqHM8ebSHwc7WrDzmD2b5amNaLt/pibZYJscnP8hNM6iC2dXbCvjkxiP2wi9A2lWriNzGqn/JDiQ9fnsewdAyCYr0m9Ryt3xL1cU4fpfFQtVOHbUnUMUhdqRzDQxyvui6SsJ0A/R+Eoc346I+zMKfFsYevp2GelJnTTBOjlsdit1hArweKA2kuff5lTuRHlrq2/21x0g4+en3m1Ndl5fJ5/mpSXAUpSavUuqwfTCtHMWQtBNd8ewqyBE1lu2Q0rn4dKRge0t5uJjPwmMeXamf4/WqGKOZSjskAsst2vmkhlVRbA5LLH8vr/Ta3dGVzXYsRY4w7DqSwhVU/8ovEWU1capd4j1U0UF4Ru2TbE8sQhKKNUHF1blfdODTfYXV4yM4klUCDDP/ObaWzPILa0uy7V41iCwXrgL83iCtNqtvty/BAo/XDNX23K+b0Czj6rvTB/TFZoeqb2Fq4ymzS9K2np/sJp3iGvrTS80Iic9qLRDPPBuvEHTCkyiRglw2xkghJ/l0JrwiS752xeF/Sx32/oFh5NirjY2XG+MRCABq9GAzLorssoEPsZE4HJT1Rxwt22MlOza9byVgrBOGsBH5KX4Bvlf7hz6KELaQs=
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(346002)(39860400002)(376002)(136003)(36840700001)(46966006)(426003)(16576012)(8936002)(966005)(26005)(2616005)(82740400003)(53546011)(316002)(31686004)(356005)(8676002)(31696002)(36906005)(7636003)(16526019)(54906003)(86362001)(110136005)(5660300002)(70586007)(70206006)(6636002)(4326008)(336012)(82310400003)(36860700001)(36756003)(186003)(478600001)(2906002)(47076005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2021 10:42:44.0388
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 018fe264-ed4c-438e-35ca-08d96dfe65a2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3269
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 27/08/2021 07:04, Akhil R wrote:
> Add DT binding document for Nvidia Tegra GPCDMA controller.
> 
> Signed-off-by: Rajesh Gumasta <rgumasta@nvidia.com>
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> ---
>   .../bindings/dma/nvidia,tegra-gpc-dma.yaml         | 99 ++++++++++++++++++++++
>   1 file changed, 99 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/dma/nvidia,tegra-gpc-dma.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra-gpc-dma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra-gpc-dma.yaml
> new file mode 100644
> index 0000000..39827ab
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/nvidia,tegra-gpc-dma.yaml
> @@ -0,0 +1,99 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/nvidia,tegra-gpc-dma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nvidia Tegra GPC DMA Controller Device Tree Bindings

I think we typically say NVIDIA in all caps.

> +
> +description: |
> +  Tegra GPC DMA controller is a general purpose dma used for faster data

Maybe worth saying that the GPC DMA is the Genernal Purpose Central 
(GPC) DMA controller. Also 'DMA' should be in all caps and not 'dma'.


> +  transfers between memory to memory, memory to device and device to memory.
> +  Terms 'dma' and 'gpcdma' can be used interchangeably.

Note sure this last sentence really adds any value.

> +
> +maintainers:
> +  - Jon Hunter <jonathanh@nvidia.com>
> +  - Rajesh Gumasta <rgumasta@nvidia.com>
> +
> +allOf:
> +  - $ref: "dma-controller.yaml#"
> +
> +properties:
> +  "#dma-cells":
> +    const: 1

Good to add a description here. Look at the 
Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml for 
reference.

> +
> +  compatible:
> +    - enum:
> +      - nvidia,tegra186-gpcdma
> +      - nvidia,tegra194-gpcdma
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1

I believe that this should be 32. Look at the 
Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml for 
reference.

> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    const: gpcdma
> +
> +  iommus:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - resets
> +  - reset-names
> +  - "#dma-cells"
> +  - iommus
> +
> +examples:
> +  - |
> +    gpcdma: dma@2600000 {
> +	  compatible = "nvidia,tegra186-gpcdma";
> +	  reg = <0x0 0x2600000 0x0 0x210000>;
> +	  resets = <&bpmp TEGRA186_RESET_GPCDMA>;
> +	  reset-names = "gpcdma";
> +	  interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH
> +	                GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH
> +					GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH

Please fix indentation.

> +					GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH
> +					GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH
> +					GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH
> +					GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH
> +					GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH
> +					GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH
> +					GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH
> +					GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH
> +					GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH
> +					GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH
> +					GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH
> +					GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH
> +					GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH
> +					GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH
> +					GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH
> +					GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH
> +					GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH
> +					GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH
> +					GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH
> +					GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH
> +					GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH
> +					GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH
> +					GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH
> +					GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH
> +					GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH
> +					GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH
> +					GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH
> +					GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH
> +					GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH
> +					GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
> +       #dma-cells = <1>;

Please fix indentation.

> +	   iommus = <&smmu TEGRA_SID_GPCDMA_0>;
> +	   dma-coherent;
> +	};
> +
> +...
> 

Jon

--
nvpublic
