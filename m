Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3737140DCB6
	for <lists+dmaengine@lfdr.de>; Thu, 16 Sep 2021 16:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238289AbhIPOcs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Sep 2021 10:32:48 -0400
Received: from mail-mw2nam12on2052.outbound.protection.outlook.com ([40.107.244.52]:42145
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234701AbhIPOcr (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 16 Sep 2021 10:32:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wn8xgHpWe2fkS6K8lvtZTvJFpiK5mA7zw3N6V4Mc5eZFCxfxHYhjjXOLaixxSJpcqSdmEezr672QfaDPCgHAstL6HZO6Wmqs2tULfA64r6Fo1TGUdBfaQPYNB5zBWrxX0POlLqUqaSR3SXsn64BnqEKI2bJmGbyFex7OFHprFNXvqSB74nLpQMOZ51LNnzUqStUGdpeLPKn67gGl+qa4b20owIDLtjWiqRN8q2TY6bAPw6IpiCYymIVrSWm3L6/E/CSL+v2fOT4uqol7mQLxDNGamU79LV2laas22mFvtKsZslURky1tTI6NFs7s2ZylpBr/wkNQcnftlfmlmBH1sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=9lC98kgXAnMHWK/7KlYghYv4Ptq/fhmd+Sfhj9VgDtw=;
 b=Kfu/2/Z/Qsq3FiW3mEihhCi8nJdGb4BpMV0+WPRZ+qYUDH7lFPsRdacr1EcFTBA5gNID6l9FKseE6KEoD9kA3XpPvIIWFnVcbtvaeUCTMqrgqW7RIs30hvfwgNXaOjqs4u8KEtYR3vvH9Bv3cBWYPj2amPXY87FyBSy9VNiUgBOE1Cxl6kPqZeOvJUpThLIdqHnmV03DD3wxGZZvDLC2nnerpx3ZVgEpdyBOIQDddPu74f0C5P1yscthimOAr4kKExrgypfcuxecHkAi6XmiWvwqBCg6vxfMfwzMUjQ0TqRwvvDd+oaQbylRayfMpjTeixHAlCA+lVtbA3ZJX7c1ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lC98kgXAnMHWK/7KlYghYv4Ptq/fhmd+Sfhj9VgDtw=;
 b=fxEVEYTpI77NaiQ/h1C82mwJSVi07sTn2vmUhvXiYo7rPrZxxIGNnZghg442D0K9EvesktOFfChBrBSN+DttuD9xjawkT9+1p0pdmc8W4Q3dQpbZs7dVttK0ShCQeDcUW7V3X6TVvybGlTd61gjSRB4Fr0MlTmC0ZFgzO1yqqzjtjVUUyv0DzAm6++n2WxGKaBN/0ySxxHjXH9AD8dJKduDdEc9NrUj3qdCg97egt6hM8QcKRuW63c2/0CPm0t+qkzzqHwD8wESKOdVvoBEsvjt9kttRHXkLAyumlIbP7X0fd7ZxWCaKHTAZ9AjATIOpmabMk3858c0rrCLGIVDKjw==
Received: from BN9PR03CA0372.namprd03.prod.outlook.com (2603:10b6:408:f7::17)
 by BL1PR12MB5047.namprd12.prod.outlook.com (2603:10b6:208:31a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Thu, 16 Sep
 2021 14:31:25 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::2) by BN9PR03CA0372.outlook.office365.com
 (2603:10b6:408:f7::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Thu, 16 Sep 2021 14:31:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 14:31:25 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 16 Sep
 2021 14:30:54 +0000
Received: from [10.26.49.12] (172.20.187.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 16 Sep
 2021 14:30:51 +0000
Subject: Re: [PATCH v5 1/4] dt-bindings: dmaengine: Add doc for tegra gpcdma
To:     Akhil R <akhilrajeev@nvidia.com>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <kyarlagadda@nvidia.com>, <ldewangan@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <p.zabel@pengutronix.de>, <rgumasta@nvidia.com>,
        <thierry.reding@gmail.com>, <vkoul@kernel.org>
References: <1631111538-31467-1-git-send-email-akhilrajeev@nvidia.com>
 <1631794731-15226-1-git-send-email-akhilrajeev@nvidia.com>
 <1631794731-15226-2-git-send-email-akhilrajeev@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <8bedb0a5-8d2d-a2fd-a816-9c19becdcf70@nvidia.com>
Date:   Thu, 16 Sep 2021 15:30:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1631794731-15226-2-git-send-email-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d22cd0c3-3770-4d35-91c6-08d9791ea9fc
X-MS-TrafficTypeDiagnostic: BL1PR12MB5047:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5047F9178CDF2F941A53CD01D9DC9@BL1PR12MB5047.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tQmV68vtauPMfw9E6RSFnPOYp38UJtz8y7x5W2y39Nw66IOz29ZML5HZWAiZ5Y3J99NHCTBnjsjUtc72SLPBIdomDo+IPso5ggbLRwUnLkFZ2pOKwgv0zjS9iaZhgPsgTPVPFl8LUuquWAihQ++yiEQYwM/kEp8nTja/rCPu+szs6cAgKCG6mnf1x1mImRKocdI4NAdzYS8NIzpFZ0k6dvmrz9g9Ll+K+D4gefabGn2oWtzOmhk1b9fSAAMpu/iNUOD0clnYIJzk7iXy2iNQhfUVPBmIBE/X2bcvZFhoXajx8zLMvD2sT2gSW0URNTBCFDliHmiKNPX/gxLWlo2NVvHuJiAqkGgK9SRyl95PO9JPQiVY7Cro9HbPu9ZDHEa7tgCYR5cJo/g8skdMu++/wdLNTMTRm4Z5jWT8LmUTg8WB0UjGoK2lJGWnDYdvQyUMaCXedZP4JZifvs+cFq/VpHnlkpquCTj08bPbeWgLsIgxLKD14rynFvcwwEP93EuviyTLwqfFAKU2gmjTSQO6Cf64fC34hPddlTUsFl+x4MvxPLsakeXoQBtHMfzUGbp9N9pSaLh0/CvtM24HEm/p6h319EFoIcIdzCKdSGC/GSbMbB6dwyd/lEP2Z0DomVVYI7woPU5ddWahz9n1lZInq59tFeIEsAFFs663eOxreYG8rH01a3LfSs6UmZDVRu8B5SeRKDRUt5JFk7cllTmLXycO2zBVEAkzIO0Qg2MoRAM1uYOuDZw6dXJLtnP2BT1KBIc1vXdSVaPhUJS2uzgaXQT2UKuwQtMDr6P046V/t5YOMFHzde6rW0Zd2DLWJqr4M4oyyDsjsY+3mSreIx3+Nql0E0aRqCC5JsJVMsX3E1s=
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(376002)(39860400002)(36840700001)(46966006)(37006003)(53546011)(16576012)(54906003)(36756003)(36906005)(316002)(70586007)(70206006)(7636003)(2616005)(86362001)(6636002)(82740400003)(31696002)(336012)(31686004)(966005)(2906002)(426003)(47076005)(186003)(82310400003)(478600001)(5660300002)(356005)(16526019)(6862004)(8936002)(26005)(36860700001)(4326008)(8676002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 14:31:25.5748
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d22cd0c3-3770-4d35-91c6-08d9791ea9fc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5047
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 16/09/2021 13:18, Akhil R wrote:
> Add DT binding document for Nvidia Tegra GPCDMA controller.
> 
> Signed-off-by: Rajesh Gumasta <rgumasta@nvidia.com>
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> ---
>   .../bindings/dma/nvidia,tegra186-gpc-dma.yaml      | 107 +++++++++++++++++++++
>   1 file changed, 107 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
> new file mode 100644
> index 0000000..cf76afb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
> @@ -0,0 +1,107 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/nvidia,tegra186-gpc-dma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nvidia Tegra GPC DMA Controller Device Tree Bindings
> +
> +description: |
> +  The Tegra Genernal Purpose Central (GPC) DMA controller is used for faster
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
> +    minItems: 1
> +    maxItems: 32
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
> +    description: |
> +      stream-id corresponding to GPC DMA clients.
> +      Defaults to TEGRA186_SID_GPCDMA_0 if not given


Does the value programmed here always match that, that is specified in 
the iommus property? If so we should not need this property.

Jon

-- 
nvpublic
