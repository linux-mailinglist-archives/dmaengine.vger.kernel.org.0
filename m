Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB59464EA7
	for <lists+dmaengine@lfdr.de>; Wed,  1 Dec 2021 14:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241930AbhLANTp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 1 Dec 2021 08:19:45 -0500
Received: from mail-dm6nam08on2076.outbound.protection.outlook.com ([40.107.102.76]:45281
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234027AbhLANTo (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 1 Dec 2021 08:19:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jS2H3KN0PXU+brqmtrZbDv/ohxYoHMAhjJ86Y6ddPTqbFNyF6OSXNtR+bQmfL/hk6YGE7E8gDA8iRX3CZJTu5JYsMyfdQiKsQ3uufbfzYrDZqru4DIftZf02wXqlyhaDFeuv5CSJFxyHLxny+Fi/HOx38Eo4R9Xs8EJchTLz/crKj9LEDb4hV9p6LPA6/k2HBtZeGqLTsb190GXW0GqR6QGi4fy77JYcVLHzO89KVC1mlDLDWyqEodNUHbcL+QFc0FWVqxcOJylonporrQozDjqs4yCp+yjVQBxNsf07rflSV3sLMX1rulTSx870xESDDci4+N0ePggHJJfia0/oPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kpGwY6icSbm3PKsB/DHf9RGJ2BwdUH/zsCShU5aqGok=;
 b=H+o2Zlh92fcMsLIaGe48kqcFzHSo5qsZe0SK92mCuNrqQf1ewqsNyt3uv5c0y9HBwg7bCkoeVjNWbWfFiXV4e8l9ukpjbjn8Z2nGzkk/yPyEdYFsqGAIFIkyB37w8kqYsrh7g01q1OQvqCyfQImER3YDyL19KYrl5o/Gl3xlyfCByoHRJDWHWlC3hJckxG4/zUtykNfRGLX0sXpNvwbpoMCMW48iIE3ZoDbgNcNHyh0KmI3G8SHaE5DYVarujTLsRhaqnjSRv8hFXlIGg/XtKkjIPWe4bo2U3TLt9QHago6QFOw7Gl0fPUjcWDh/lH3+qAVPJJi0EgiiEgM2GcRXew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpGwY6icSbm3PKsB/DHf9RGJ2BwdUH/zsCShU5aqGok=;
 b=GohPwRrqUZHT8e0q+hX8xq67ELUYqmk7dNr7+3tpW1LOsWd2QLFNm7967riJ8eoeizoZh56ddcnXpqztwI2vaBN/BFDayQ7cfBhS5X6rDqfHplzMKNRiMBxNUuOXJkM8XCqhhOcnjjpqyeSiiAvwYWklzTgVyLRFrE6FSvhJs2lgtDS/hy02KFA69zFc6CrJrl1dNLzhcP1Iow9PmoNGGeMt+8dZy5EnYPFZ7zTaSvGL9L4X7T67nZBQcoDCUATtP/TmANWPDyLxRuoYiIYAxL7oyJofSXNx2/WUrohMQR8mc3QbjaKRbFncS+iOjFuotbf6u6qBXghMcKfT5p+xBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 CO6PR12MB5409.namprd12.prod.outlook.com (2603:10b6:5:357::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.23; Wed, 1 Dec 2021 13:16:22 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ecac:528f:e36c:39d0]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ecac:528f:e36c:39d0%4]) with mapi id 15.20.4734.024; Wed, 1 Dec 2021
 13:16:22 +0000
Subject: Re: [PATCH v13 4/4] arm64: tegra: Add GPCDMA node for tegra186 and
 tegra194
To:     Akhil R <akhilrajeev@nvidia.com>, dan.j.williams@intel.com,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        kyarlagadda@nvidia.com, ldewangan@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        p.zabel@pengutronix.de, rgumasta@nvidia.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, vkoul@kernel.org
References: <1637573292-13214-1-git-send-email-akhilrajeev@nvidia.com>
 <1637573292-13214-5-git-send-email-akhilrajeev@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <088fbb31-71f7-6e8d-ae33-a56d98f2403b@nvidia.com>
Date:   Wed, 1 Dec 2021 13:16:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <1637573292-13214-5-git-send-email-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0501CA0064.eurprd05.prod.outlook.com
 (2603:10a6:200:68::32) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
Received: from [10.26.49.14] (195.110.77.193) by AM4PR0501CA0064.eurprd05.prod.outlook.com (2603:10a6:200:68::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend Transport; Wed, 1 Dec 2021 13:16:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e373ef2-840e-4010-128e-08d9b4ccc443
X-MS-TrafficTypeDiagnostic: CO6PR12MB5409:
X-Microsoft-Antispam-PRVS: <CO6PR12MB54099A60B5BB70C737334B58D9689@CO6PR12MB5409.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JhEl2EfoQgUzjcCLmZ95A++hWl1H6LPzi7c3e/f0Ch120bQGeNwzS+CgU5+GiXHE4JIcZ1knVLZikVC8X7No+hM115+bDi6lkr2EmL3EaQSxz6vltf7JXMSKB1oiMQtm9+WmwT99O7dvy517DQKZcZ/SYVHLm8QbHiRiRDcyr/+eu/B2z5p0xg81kTfmoUEW5yBnGuxFE7YJO0CklHaBxvzxlkD3O6hb5+gd5Zkrw+yPCAMnC6/FZeCBnV9CdlDtF3OZn0TKfqa/97pzOc680A1+NxaOWzQMVmB88V9dViiipBum2g/w9/HcT7pjRacIdJEXlhydvKEA0RoxZGcTkSUe6hYXewWkZJYyeO9/mtSiVokGAdyIQEWnpQPrBxcILYg4Df3eKZRP8z3A73CRZkLRHtFDoEdJHbyJebJet4Nuhoq5vujB1kWPaOVhn7a3ksD8wLte9OnhLlEKZ2ihy4/9tjXg4aW54EZFNxHQnN5gh3oXbnFQ9DzfIz6wf5GERUZKs8pChbpAYFAqxUTyNChBfmajPm3Rf8kFof85f/q1+xmiQ6eUH1+3uwePQf0NdXxv3//xbHNvWD1ot2HKnNgqmHxYB4Pz4jxhUgIVB2NcejINAQi3xT7NadvNQH4t/NygJ7hVGs57c9vU16s2NatVsnsjSZcrWMFLp4w36vB+FoX1wyITzI8Qz/d5j3gXdns0aMI8DpMyhzU3j4HBUexTOoBP0hDNxfeCQ06eqGgnMtXdZWcmhzIAvyfZMtqUjn6uXaeOjS6HBp4r9VufmA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(66946007)(53546011)(8676002)(36756003)(31686004)(83380400001)(6666004)(66476007)(66556008)(8936002)(26005)(38100700002)(316002)(2616005)(921005)(16576012)(186003)(31696002)(5660300002)(55236004)(2906002)(6486002)(508600001)(956004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1NKOWtQSXJJZmxjcTRrUzZVQkNURFVVQlBkRzNEUGhqMGJFa2dVNS9peUNq?=
 =?utf-8?B?L1ZrUGZ2VHg0eCtWWklxSmlJZUlNUFBYWU41bzVaTEtscXl4ZVpaUUg0Umli?=
 =?utf-8?B?WTdsTzdHUDMrWC9zSlp2WkhKaldWUk1rdkxhMy9GNVY3TjlMV3pwU0pZc2xR?=
 =?utf-8?B?VWI1dnBGaVVTU0l6SEN3eWZUQXB0Y3ROTWY2djNLa01VL3dmZGN4dDcrbzNi?=
 =?utf-8?B?V2hITEdXdTNNTklPV0w2SEVwcVpuTTAzUndXa25VbnpaK2VzOFRQZmtoQ3E3?=
 =?utf-8?B?anR4Y2RKaUQ0YlRST3VkNEZmcm5WWGNCRWpPcnY3UFdPcE81TVpZeGlhZFRH?=
 =?utf-8?B?SGtkTCtGQkkwbktGVTM3LzVPTTNnaU5YTGFlOEU4ZzR2cExmcVd3SjRVZzNl?=
 =?utf-8?B?ZkprL05KeE94RXFRNElCSW5CL3pKWVpqWHU1Tm4yRDAyRGVJSnhSNGFYZUhX?=
 =?utf-8?B?ZE9wVy9COVFVanB6VTZGdldubzZSRGZXWng5MGQzdFBJa09Xb3JPRGI4MWFC?=
 =?utf-8?B?NEltR3dlUWVua3RWay9yM3pBME0rRzRJOS9TaVVBTStVNUJuZWQ3K0pIWmp6?=
 =?utf-8?B?dHBBSmlZYmtBQjlkRFVWaEtVZ1FRMGoySWgwRWRtdUllTVdoN2xtTFA5cHBi?=
 =?utf-8?B?cllTcHpyQTJiNGZoRnlicWpnalV3M1I0S2svVi9CSVh2ZGs5c2tIZzZoT2Iy?=
 =?utf-8?B?ZEZxcTdOT2NNMURhZHpLa2FaOWdyTmxvR0hHYnZlRmc1ZEFhV2syMSt4SnhB?=
 =?utf-8?B?OFlaOWhFalFsWjVBMzE1MTlqcXZCd00xUGJDYW04K3V5cHJLejUxR1ZmVjZE?=
 =?utf-8?B?VnVHR2t6c1dMMDg3K08zbGFiaCtTTVJCZ3oyUFh0dkZWQWZwRURTNERjenhW?=
 =?utf-8?B?Rm1hMy96eWorWGpGQnNoaTJhTzdHREdMbFhsZTlTVnVzM3V0a0VBaUVSeTAx?=
 =?utf-8?B?RjBzT2kyUmZ5dTZYREJ4NkJ6M2ZJRFFieWZsanZ3aUduWU5HNFdyT1BGQnBI?=
 =?utf-8?B?cDBZSUY4blcxRHI0U1YvTFhNYmhWREVVN2NBeVBCNkxPZEpsODBHVjMreUdn?=
 =?utf-8?B?UjAwVHR4QW05R0NSMWhFRmQvYjl0S1YwVUo5cWdSc1ZKTEpvMW5jRWVxaE5j?=
 =?utf-8?B?c1ZKbnl4YnFra2NpVTQvVWZvaHpUNlJxL09DeFdOMFROZ2VZaTUxME5Ddlh4?=
 =?utf-8?B?RHJEM2xvcS9sRi84aU5ER0VPU1A0WndIMWJjd0VUcUxudHFFemVsK2pUd1Nr?=
 =?utf-8?B?NjdGdVZyV0RxVXY1T1NkZklFaEl3eklFc0t2M2Rxb2ZPUVVDM1pXUFpwYkdE?=
 =?utf-8?B?SEFrUjBpSHRVbW4rQkwzc2x6YTJLaXh0TUpmRDFDSktTenlaS3FqSUdDVmsz?=
 =?utf-8?B?enRpQWlzVkdaZXZyMVk5YUgrRkZUWWpGK2Z1ZiszK1ZCdUpGWTcvdGg4UE5y?=
 =?utf-8?B?dlA0aXYrZC9sOHVqU3QvS0NiRDM4bytoRXVjM1Z6RGpDY3ZBUEhMc2NEUmxF?=
 =?utf-8?B?RXVGdnl3aHZWREE5TzhLT21RTkxhQktQWHF2Vk15WjBiQSsySEVnakkzZDFZ?=
 =?utf-8?B?NTUybzlTbW5qMy9lV3hIa3dWMVdpVDYzR3ZCcVZESHJudkR3bnd6RGViZE14?=
 =?utf-8?B?Z2RiN242M3ZQWlljVHlvRHorUzREa0dVZExqaHVqcUFDWFptcGtQYWpXWG13?=
 =?utf-8?B?cHQ4em1EbEoxd0JLZ3lqQmtacU9ualdSK2lYOFphem52NXN6Rlloa3dPNDhC?=
 =?utf-8?B?dlFCNzNzU3VZOFZnSmljbzZBSmZJaGNWbHdmZklnTzZscWtPZWphMlRlMFF6?=
 =?utf-8?B?SE94aEpvVnJNUkFoaGo0QjBHSmFxTTgyV2ZaeUtjYmRJNWlmUmhOeTdUbmhz?=
 =?utf-8?B?NENaWlZlUkIyajlSbDdDSTdNKzUzU29jVmdINTMwcXFYMzN4eFEzUEt5bUww?=
 =?utf-8?B?QVR3QjI2MlN6N2xldEs3ZGZHOHMzNmd0d0R6VGxPa0FlczR1TmEzOENYTmRt?=
 =?utf-8?B?U1pzTU1RNHZvdTRVa21DR2hJenJvOWljYmpna0tMWHVQUkdER0Q0eUEranlU?=
 =?utf-8?B?cVA1djlkVXR2VjlUZ1U3K0p6bHNZMW1MVDh0OU5OKzBkV0ErRFgzRitTRVl5?=
 =?utf-8?B?WWVJMU93WDEvZDhmOEVsMGd0MjJLNTJoOXVvdDFhb1Q3VE5USk9VSXMyWFBX?=
 =?utf-8?Q?rRcUt7wstSjtAc/yRQpUKOk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e373ef2-840e-4010-128e-08d9b4ccc443
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 13:16:21.9894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e4tSiuDplKRUjcud6LYfx/U0ssNM5Zrkl5811MMEyh8Jkcqa4JvK99g++8kBdoQk8XrQWISmXnIkxg+TiIjqPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5409
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 22/11/2021 09:28, Akhil R wrote:
> Add device tree node for GPCDMA controller on Tegra186 target
> and Tegra194 target.
> 
> Signed-off-by: Rajesh Gumasta <rgumasta@nvidia.com>
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>   arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi |  4 +++
>   arch/arm64/boot/dts/nvidia/tegra186.dtsi       | 44 ++++++++++++++++++++++++++
>   arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi |  4 +++
>   arch/arm64/boot/dts/nvidia/tegra194.dtsi       | 44 ++++++++++++++++++++++++++
>   4 files changed, 96 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi b/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
> index fcd71bf..f5ef04d3 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
> @@ -56,6 +56,10 @@
>   		};
>   	};
>   
> +	dma-controller@2600000 {
> +		status = "okay";
> +	};
> +

I am wondering if we don't bother with the above and ...

>   	memory-controller@2c00000 {
>   		status = "okay";
>   	};
> diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> index e94f8ad..355d53c 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> @@ -73,6 +73,50 @@
>   		snps,rxpbl = <8>;
>   	};
>   
> +	dma-controller@2600000 {
> +		compatible = "nvidia,tegra186-gpcdma";
> +		reg = <0x2600000 0x210000>;
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
> +			     <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>,
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
> +		iommus = <&smmu TEGRA186_SID_GPCDMA_0>;
> +		dma-coherent;
> +		status = "disabled";

  ... just enable here. This is available for all Tegra186 SoCs and I 
don't see why we don't enable it here. That way, when new platforms are 
added for a given SoC it is present by default. For example, for 
Tegra194, you have enabled for Jetson AGX Xavier, but we also have 
support now for the Jetson Xavier NX platforms and so we would need to 
enable for each platform we have.

Cheers
Jon

-- 
nvpublic
