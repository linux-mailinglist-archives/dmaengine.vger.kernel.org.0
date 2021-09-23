Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03CA5416819
	for <lists+dmaengine@lfdr.de>; Fri, 24 Sep 2021 00:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243469AbhIWWhM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 Sep 2021 18:37:12 -0400
Received: from mail-bn8nam12on2083.outbound.protection.outlook.com ([40.107.237.83]:17888
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243423AbhIWWhM (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 23 Sep 2021 18:37:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jgPzlN3S1QalZzDIO9juLfup/7crzEObsUy3XnM0eiqeDoUsMB6GXNm/IeUIIZySA3aRqVONEUIZg0WPw91seVM+fhxXkM4ZbNWOaRSa9AVr8WY4souSYS0hUNIFI96egrVzcl+0lIerY051YOWqDjFSiu1sYknE+jFpKaL5B85hUWljuezcP1qSaj7JWAfQ/HvOnWOKmDpP79552zI1xwa2471srpPsny5zAr6c/iZA7Uy5qdOscJBJnS10AVdjIRJsL663VLtRn6O59tqR6NmjhU8/JC/HPPV3E38wAHv1xuhZKrqPpG5p10p8eI9d0tdLt0kyd9M0qS+Qdo8bLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=sIGJ1ogq1TUVaP8+tad+A1tTToxgl3K2j5dCcXc/nh8=;
 b=N7nrc5qrBkSfJuKaGGqMiwLKOHm43hIv+rVXd9edpDPZE+aCFTCn/0x9Nb/CE6JXL5V6aZulpWdUA9YgzLoZwe6Y1Se2uSbqFZ2/HLWqPtXlBvr91seIgcK0b4wtYRBnOGHivh9WeBlLKZii4p6LCBImDRXbSpWK+YD6NMbGT/SmofJWoSAbu14k9qJBQgve01T+T3WKEyw0Nr+lpUeSG3C55aw01tivdLGjL9XC/thfpwokma5pAIpPt7qGeN3ODwl1GnD8vgDGhD00Ht2hWPvtAXWyNHXp30vfnHI1MzceJGF8YG7eGVj8mnmz0Cg1qA2RJhILYIFpgizvqrj9yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sIGJ1ogq1TUVaP8+tad+A1tTToxgl3K2j5dCcXc/nh8=;
 b=K+4ZKaR7dCabkef7yyq2ejchApCZ7AKUj/BP2oaPSolUdblJ+bMzC4VTWJVa31Ug4huxqsaJACrNWcju5rPiZ5ppLDkM/HF5ddjd+VX21KRp5MTiOOSCSSneqZGE3cadR4+i+FcaL7nJImTDAAOZMpCMQCUIn5+KXKxgC4APOrKN+PcJb30BlMtDoV7xVXYHXvOMwmOCgflEg1yRXaaY+LlYPAOZ6aisvceoIcnftQwBqQaO2RGRz4g9eCNwVaxhTryW5gBzcWDyAWdn3QMYXQrGmAOtb1E4yhjXWwK3BpeA8OPx2Ym06ClwtIsJrS0hQkwR153gpQfWGqkKMz1NgQ==
Received: from MWHPR12CA0043.namprd12.prod.outlook.com (2603:10b6:301:2::29)
 by MWHPR1201MB0064.namprd12.prod.outlook.com (2603:10b6:301:58::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Thu, 23 Sep
 2021 22:35:38 +0000
Received: from CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:2:cafe::8b) by MWHPR12CA0043.outlook.office365.com
 (2603:10b6:301:2::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Thu, 23 Sep 2021 22:35:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT023.mail.protection.outlook.com (10.13.175.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4544.13 via Frontend Transport; Thu, 23 Sep 2021 22:35:38 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 23 Sep
 2021 22:35:37 +0000
Received: from [10.26.49.14] (172.20.187.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 23 Sep
 2021 22:35:34 +0000
Subject: Re: [PATCH v7 1/4] dt-bindings: dmaengine: Add doc for tegra gpcdma
To:     Akhil R <akhilrajeev@nvidia.com>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <kyarlagadda@nvidia.com>, <ldewangan@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <p.zabel@pengutronix.de>, <rgumasta@nvidia.com>,
        <thierry.reding@gmail.com>, <vkoul@kernel.org>
References: <1631887887-18967-1-git-send-email-akhilrajeev@nvidia.com>
 <1632383484-23487-1-git-send-email-akhilrajeev@nvidia.com>
 <1632383484-23487-2-git-send-email-akhilrajeev@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <3e315955-20f7-6c27-5692-8d371bc92b25@nvidia.com>
Date:   Thu, 23 Sep 2021 23:35:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1632383484-23487-2-git-send-email-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 311c4b43-ad8f-44fd-3ebf-08d97ee2777e
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0064:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB00643C4814F7280A8E6EAF50D9A39@MWHPR1201MB0064.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: csaO8IHV8YmmhFYOHBIFx7+ZR42F3K6czImVTQ6kuCeKs7eajCrXqY8Mv//YEEtsvuEV+OwqXn5uYWNi5nHCjPLBtZSxhQe1DMDpCbirw+YhUzxBVGi7ffSlzdCvQ+9Xx2tlLUlmGYQoJN9ld7OdqcUN+paH3CrWtSY+VM+RvCv7Nv/IU5IJPAKlxrRA08+aJr84rNcL9X1V4R/mO+JiPlYpPmQWHdXvvSqp+VdrkKHoM1Mej2JOx185xN7ay/65a4+3BlM2qvg88cICXMBr53R/D38XDiRjnCn1qB6+rVcf7HaqfxYTTbhLqNS2a06jJOV50c26SMvaw2y6U7tEOHfNqH+m80piIx1z1g8A28Nm4MK6XBvWLpQO2PLqOJcwnMuqRybpdkdWrkj02OWFcfvFmWfLKi0eOMh11wuiK35VtMqBjvrbrmePza9ooRxB/+vwRXLgUoRZn8FPOigOSPxRl8hFUPLoNUyou8/6C4fRZVIgSweHKibC3DXxsNOfUVa+TIBlwiaNvmle0POl4tPFYaXEW1DsMeH5Iu3cNaCFUHMjJUZ+AlAZIceXcSYIPawyK4BaGcsQpTut/fitdx1tMWoP/7xnMyTI2R9cPrPJkARpOcI9hwPYRCRR14R5GdqsZCUKBgelasTd2EvhdDJvfaAVoBXa58OcbG/mV9J+cKM6fGl3SCkBuys2TMvhVabXMk/VBTYxZFV4rItDGgVJ51ZZbkOki+CWXWR/OHOBFFr0QsBgUp+xbUeh/xCnKqSnODxEiQ6EaU7kvpwDP/jx1aOgFXeoX7wFB13LLJgRoIl6SkI3kYO7n9E48HqMi45PJFXh1QNhNaKqowk3pVAGmiwuaaI0rqDL0/APUcg=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(86362001)(2906002)(31686004)(6862004)(47076005)(54906003)(508600001)(966005)(336012)(70206006)(70586007)(8676002)(186003)(26005)(16526019)(426003)(37006003)(356005)(8936002)(31696002)(5660300002)(7636003)(6666004)(36756003)(53546011)(16576012)(2616005)(36860700001)(6636002)(316002)(36906005)(4326008)(82310400003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 22:35:38.1397
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 311c4b43-ad8f-44fd-3ebf-08d97ee2777e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0064
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 23/09/2021 08:51, Akhil R wrote:
> Add DT binding document for Nvidia Tegra GPCDMA controller.
> 
> Signed-off-by: Rajesh Gumasta <rgumasta@nvidia.com>
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> ---
>   .../bindings/dma/nvidia,tegra186-gpc-dma.yaml      | 98 ++++++++++++++++++++++
>   1 file changed, 98 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
> new file mode 100644
> index 0000000..3dcf5a1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
> @@ -0,0 +1,98 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/nvidia,tegra186-gpc-dma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nvidia Tegra GPC DMA Controller Device Tree Bindings

If you ...

grep -r "title: NVIDIA" Documentation/devicetree/

You will find the titles all start "title: NVIDIA" and not Nvidia. 
Always good to be consistent.

> +
> +description: |
> +  The Tegra Genernal Purpose Central (GPC) DMA controller is used for faster

s/Genernal/General

> +  data transfers between memory to memory, memory to device and device to
> +  memory.
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
> +	maxItems: 32
> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    const: gpcdma
> +
> +  iommus:
> +	maxItems: 1
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
> +	gpcdma: dma@2600000 {

The upstream convention is ...

	gpcdma: dma-controller@2600000 {
	
> +		compatible = "nvidia,tegra186-gpcdma";
> +		reg = <0x0 0x2600000 0x0 0x210000>;
> +		resets = <&bpmp TEGRA186_RESET_GPCDMA>;
> +		reset-names = "gpcdma";
> +		interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
> +		#dma-cells = <1>;
> +		iommus = <&smmu TEGRA_SID_GPCDMA_0>;
> +		dma-coherent;
> +	};
> +...
> 

Please run ...

$ make dt_binding_check
   CHKDT   Documentation/devicetree/bindings/processed-schema-examples.json
./Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml: 
while scanning for the next token
found character that cannot start any token
   in "<unicode string>", line 34, column 1

For more details see ...
https://www.kernel.org/doc/Documentation/devicetree/writing-schema.rst

Jon

-- 
nvpublic
