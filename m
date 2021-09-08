Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 040CD403DBE
	for <lists+dmaengine@lfdr.de>; Wed,  8 Sep 2021 18:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349702AbhIHQpu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 8 Sep 2021 12:45:50 -0400
Received: from mail-mw2nam10on2049.outbound.protection.outlook.com ([40.107.94.49]:7264
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235056AbhIHQpu (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 8 Sep 2021 12:45:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DUjbfgFwbxDzuf+RT7t+pNXaGn2ACYUusBPRy7eyyFKzgZeXuUtY2DYXKHz07qcrXdYHlZfFqMt29H/jc9IVkF8QVkbrBkEzua9Pf7N6NjVBA1CaACSKqpn69dhBsLEbV9NeUIs97wXuBNIY2uRAJzR7gmw/XHOvu7BVSz10HvTDpc6jFf5zJjym4h2pJ6md2QvOeqBwL/Kn8LcdGElay0Xtlp63BB8Tq53N5R8XDN2NQ7xGRPjvxUUMy0ADcPPWcfESsXPd4Qqb/N76Cc/xummVo3GtfGS3qsux+TfVSeK8GqZRI3sVd2/rVUEtEmMjhU3g6TtIjav3FRC506cNNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=+sx20fih2VCqggiMG7KfvbebYpCn+yT6A841a0GRlSY=;
 b=kIfMj6YcphoIRQ8daQkl9SCjPvuo7v3tkw1MstG1DVdIQ/aUzd66rg3yO8lrpFsZ9jBKLIpDMChld6iKkRwMw0ulUMltUBWniJsxkTD3Id4OV0W2YjDms6Pc8fBdl7xysrA0Givx4gbZDfN7HoWDjMTwIEld1gMD26gkTlejFExv2W3tDAzPo8DRuWtBEb5Sv8uO7vabHcNFUx6O/M+jC2HY6+sGw663MRVdxctFmJy6ZfPUbQB4VwhCF7Qvqk2LlRNWvHVGZ8MfIhOhuGpmLF//okWciUypb5+k4qUAJAOt3/EqEzAC3tkF7ynS7KJ22/SvpGbS5ndvaGTyPgomAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+sx20fih2VCqggiMG7KfvbebYpCn+yT6A841a0GRlSY=;
 b=IFXEu8DBCAbOiE9L4TYd4m5JE2/c8sRIxcVmrNnywDzH7Lhwxu9DpFsGLKuUAPULm6W+gG2y4se94RITr0e6GFHSmTeAEZehs+1AOMws9Zd5SynaQknFlKRygUCO942Bw6B6vOvCc1jJaTAdpxEadmD1K/udZE5IJ13N17Smk9uHz7wv1/9pfSEgds3FLi3h4WuUgUboRolV1fNbU5okEp4Q/LPJm/O3rVoTHMbFTnDGbjbRbqqTeczFSZgbsqXwk4DFIP2f2lUo394VUHHYckO0LwMuK9cppiHa17S+t8CtqXwWrCnp1D+KLNUncxGi8/fi9Yhj743dQ+4FaaAb4A==
Received: from BN9PR03CA0310.namprd03.prod.outlook.com (2603:10b6:408:112::15)
 by DM5PR1201MB2522.namprd12.prod.outlook.com (2603:10b6:3:ec::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Wed, 8 Sep
 2021 16:44:40 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::68) by BN9PR03CA0310.outlook.office365.com
 (2603:10b6:408:112::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Wed, 8 Sep 2021 16:44:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 16:44:40 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 8 Sep
 2021 16:44:39 +0000
Received: from [10.26.49.12] (172.20.187.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 8 Sep
 2021 16:44:37 +0000
Subject: Re: [PATCH v4 1/4] dt-bindings: dmaengine: Add doc for tegra gpcdma
To:     Akhil R <akhilrajeev@nvidia.com>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <kyarlagadda@nvidia.com>, <ldewangan@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <p.zabel@pengutronix.de>, <rgumasta@nvidia.com>,
        <thierry.reding@gmail.com>, <vkoul@kernel.org>
References: <1630044294-21169-1-git-send-email-akhilrajeev@nvidia.com>
 <1631111538-31467-1-git-send-email-akhilrajeev@nvidia.com>
 <1631111538-31467-2-git-send-email-akhilrajeev@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <f65b59f3-00b4-11bf-5509-c47c4ed862f3@nvidia.com>
Date:   Wed, 8 Sep 2021 17:44:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1631111538-31467-2-git-send-email-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95af038e-adba-4842-5fbc-08d972e7f41b
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2522:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2522258339038DFD5304B688D9D49@DM5PR1201MB2522.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2f04lPfC/YOZgH8dyuuyxk+2EhPRd62QjlZif9OEdrFrkfy2DuozAQEM+fMFDvN4c1fqXog+xAucp+4M+hwqBrWTwjCvMw0iMlF4cDGPHW1kkJuElkIAS+45WvjPHSsjW/J0vObO+CeDaW2in9S/pDyxYPFmzLBl+pJnJffRzOQ06d+OnZ5LkA0ArdnUoWTidCVU4bvdU9gQkj0FkQNBo+ULMgSsL4YvHJt1dFZUrxo7mjuf4sQnetHETcwHBBuu5MqoX0FxP7fLvsSD5lOf4p7kvKJTtj8wxuSU9qicrzUw7fQp3Aa0b4enEWYkqekOzktjgI3yZbZ2FxsYD21+mFzANZfBbIHo4dH1SDPUeRRHA8dny0D4ZO7lfiJ3XZkJQ084s0sovuUkPeq1SeExfHP2Gs8SDbRBkPqw2ZtOXJu+nadQ7e5D1Qj+rvxCvlTtcCWIodiiv7hLrXQcrWJ79jWPLyTwU46QwuPbYw4md4UBuWPMgu+z9DkSv+V+bM+Ix5ugfFynKIihvIzN9aK9slD8Q0tsYwH+dfTxsh/o8I+7qqcp/SVjWXX1Cx5JFJNao6P6oL6CXBc0t3gO113yX9+eBXbQHclfzpCcz+ZaDUKGsFo3ucZ5d12gKn5V10RWXW6Rai5iF9m/GFJtaicSvR7A2GetwoYJWlEXGsw4cmAe8N91+GkPdL9wagjQF4m3DtZmOG8TdsDXDhOPfyJHFFcOG9m8zhkXRonIrTZlhJ/Fv6Aa0eRMTKHotRM2fwXoBAa3e/EY9O9hpOd/2uRjx/LCPXBr5YlWH4UHGA92Xt17rofmPjg5b+AIE9OmdyJux9thooAtOSRx7PjwZ4HNdyz80eXJte3YenDM3kegEXA=
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(39860400002)(376002)(36840700001)(46966006)(36756003)(53546011)(966005)(16526019)(26005)(16576012)(2906002)(37006003)(70206006)(186003)(82310400003)(31696002)(316002)(4326008)(54906003)(86362001)(2616005)(8936002)(426003)(8676002)(336012)(47076005)(36860700001)(5660300002)(478600001)(36906005)(6636002)(31686004)(7636003)(356005)(82740400003)(6862004)(70586007)(83380400001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 16:44:40.6423
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95af038e-adba-4842-5fbc-08d972e7f41b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2522
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 08/09/2021 15:32, Akhil R wrote:
> Add DT binding document for Nvidia Tegra GPCDMA controller.
> 
> Signed-off-by: Rajesh Gumasta <rgumasta@nvidia.com>
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> ---
>   .../bindings/dma/nvidia,tegra186-gpc-dma.yaml      | 106 +++++++++++++++++++++
>   1 file changed, 106 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
> new file mode 100644
> index 0000000..00c5582
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
> @@ -0,0 +1,106 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/nvidia,tegra-gpc-dma.yaml#

tegra186-gpc-dma.yaml

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nvidia Tegra GPC DMA Controller Device Tree Bindings
> +
> +description: |
> +  Tegra GPC DMA is the Genernal Purpose Central (GPC) DMA controller used for faster data

s/Genernal/General

I would just say

"The Tegra General Purpose Central (GPC) DMA controller is used for ..."

Over 80 characters. I assume that yaml files have that limitation.

> +  transfers between memory to memory, memory to device and device to memory.
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
> +	minItems: 1
> +    maxItems: 32

You appear to have alignment issues again.

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
> +  nvidia,stream-id:
> +	description: |
> +	 stream-id corresponding to GPC DMA clients.
> +	 Defaults to TEGRA186_SID_GPCDMA_0 if not given


Why do we need this? Don't we already have the SID in the iommu property?

Jon

-- 
nvpublic
