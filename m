Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A29E463002
	for <lists+dmaengine@lfdr.de>; Tue, 30 Nov 2021 10:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240328AbhK3JuM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Nov 2021 04:50:12 -0500
Received: from mail-sn1anam02on2062.outbound.protection.outlook.com ([40.107.96.62]:37220
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240377AbhK3JuM (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 30 Nov 2021 04:50:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ewdWQ7BlbVQMwuEL4EVN/6PIyOUQ+j9FfU473mrgY4yJB69xSaXCh8LeECNUpYXv9J5dmuY7NnWyW66VAnpoLARPtWFoyrepgvpJ6Md/DfU8dCVHj4xY++n6w8OKvxROhuG4sT1xAE+sKRh5MC4P4MqSUGhtdaMkZAVHXMLgbMgQd7NpVh/HBKjIO9qGNDYwmchd27gocCx8A83J6SYBqsNDxTHh2wqI7fY62aLQvg77uLD0TPt9JQoqv4SLFX4Ml7tAszYbNOzSPb/et7YRyVUxKPRB+8tGC0wbfDoXVBQB2WnkgwS8ldnAlXoElxRcbA3EvMdftu9tPNGEJkCvMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQsAip0/xB8POiDFyeKGFjvM1KXDuRkc5qlFvS+j3kk=;
 b=CV3Fx9JwnuzvDKhKaJUBJ7WLQCIvhQkZ9Ub/mn9Ob+y4Z2AAAyY4mCtDf+AxkTb/kt/tGRFK3SYm3yrxlGi/BNJzLlf8YVzpu2+fHuGxX/2+2UParnQL2wg3/oZ7fg0ztfYI3uyiVIZoNJyIxEPWU9S/kmzf/Ua3P5y/F7/pLgnTLZRCTQdpHweqWRflcZW3V3gvYwrUcgj6U7OvQzPmumA1sZve2CHClOssxngeVj2siN9S3UlfUmu09c9BQvtwUwsTBftRekFOYyFcioxxHSgSge9lqqbDcybVM8A/dX6Ymt8OJWZXpNkKclMhcHfhnOzfMQnT14hwrIfV+J7m0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQsAip0/xB8POiDFyeKGFjvM1KXDuRkc5qlFvS+j3kk=;
 b=XrVEanh8NhxAiwLEaYUDKRmP2/YQwl6c9vNhcEjijpCjyj708qErLB4/3BFfqP+htLP0GncK5tVwf+GezIR0GYSpEzN/gHRir5ovRz/fOAjIqI7H701V2NugW6y2D/4ingkqhHSyS5/cfc2Hx/uR06SOvnZZnTm0eoZUOzNz1c3ONzt7e6EfPn47DbK/y72f5/P+IreeU7IdDZh0vKnEeJj6sYQW4gqnQHfNrHf1dEklbRwfQyN8HtA1fq/BXxoNkVzfMbqiLk/FcsFHqKxYWtWlIX6f1DKuUtqsLQMVIuNQMGkZafzgzHq+RMljlaHf54C7KaiW4LiqYncEqwx0/g==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 SA1PR12MB5587.namprd12.prod.outlook.com (2603:10b6:806:232::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 30 Nov
 2021 09:46:51 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ecac:528f:e36c:39d0]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ecac:528f:e36c:39d0%4]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 09:46:51 +0000
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
Message-ID: <f38d8538-8f1b-b6c8-2b51-a9e0340b85d3@nvidia.com>
Date:   Tue, 30 Nov 2021 09:46:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <1637573292-13214-5-git-send-email-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR07CA0064.eurprd07.prod.outlook.com
 (2603:10a6:207:4::22) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
Received: from [10.26.49.14] (195.110.77.193) by AM3PR07CA0064.eurprd07.prod.outlook.com (2603:10a6:207:4::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.8 via Frontend Transport; Tue, 30 Nov 2021 09:46:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c417cb0-9daa-441a-f1df-08d9b3e655a0
X-MS-TrafficTypeDiagnostic: SA1PR12MB5587:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR12MB55879D0CDBE7744E5AAE0613D9679@SA1PR12MB5587.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2bZorlscD8TlLS4NXAuDm5y0xgjtZhe7LQPdZwJKFisFxYTwoQ73tFs6zMo2HQWtpclXGPYXIZYvvV1OOs2aOx4urkClXlxApm6SpFAUFMplUB7JWBj99x9zMSNh5AtucLUK63WQ93plqMCFfbV+cPeTOVsbmBarYFi1zKOz7tSpCHF+PwDdCI9/W7SGzJDk6j2w/uQzTMn5Cf+JN8gYGFXe/v+6Ah0c5gvEVaKhFidjo5CbtXG0IJh3HjA8slnAWOcIMCBCg09nNzQWB/3qxWOs/vVWPn6F2xTZRPdLwmkZjla1ADmqN3ayPKNPefZ8bGJcOzyBLBANxzkc/YeJPKWDVANyJCIQQgt1MIU1PpqxdfXp/8MfBcK1ejlp0wCqe0ov/1RBd+cgnwLJM9csZ5WLnCBtYqCGAABmniFjuwvTd14dQ+tySBckPhUFGAfREObWqr0UBhT51/1Txe5XAr8Lwy2fjCe9Lj7czf4PPEwwHFHYoXpSoxNNzhBRDPWuPdX8MvZ5XmQH9NcURYroeLu2C3Ov8ia4hrN+d0PsXaIY/phO0ciwVQ3pv4TA8ztQT+5i2uSINGqMK3ABOxqy22aJAiOa29xASK3uS1ks+SyMPCjuZa+NnqgfdkjvvOI+vrgYish9G/a8uJOZUQr4T2wCr9Cek5meh0dbLYeOL37fxlf1NUOgoI1BwF0pohwDt++aDrxqYHEstHmJetFnx/eWRaW3j5SOkaSE2EwcftoyeDtCA5BQtleKqdyDhle36PXEytZnE23swGR1ZPTOBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(6486002)(8936002)(53546011)(66946007)(26005)(508600001)(956004)(186003)(86362001)(5660300002)(2906002)(36756003)(38100700002)(66476007)(8676002)(921005)(16576012)(6666004)(316002)(83380400001)(55236004)(66556008)(31686004)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGpxcU8yZFdZRjJENzR4TExiKy8wTHJDaFJ6UWZsT05iY21ad3Z6a0YvRVJS?=
 =?utf-8?B?L3l4Z2ZSY0Jha1RTUjRTcHoxbEtlRU9kZUcybGhNRDJqejdTRUpyS2tJTXlo?=
 =?utf-8?B?ZFQ5QkdRUWZHK1lSVmVUdlFPK3VVajVXY3dLZjdIYytuOXVxcTVaNDArMGxD?=
 =?utf-8?B?b1lHZityODR2Z2lIV3ZIdGJIck1kbm1ldDdkbDYwVWc5TTNtOXE1NmYwWFZM?=
 =?utf-8?B?Vnp4WVd4bThWTHI2b0xIVDl0N0VhUzBqSkdpdmJ2Nk1Tc3g3ZlNST0I3TklN?=
 =?utf-8?B?bTVvbXZYUlZoOGJaeHRFNjVFWFczSWhIeUZMbitublVGTXNzRy95M0FVdG1q?=
 =?utf-8?B?VjBPTW40aFRUWWZkQ0MvamxjWWdSZTVpWnVmVlQ5QXN3MUVnTmoyeTlYc1pO?=
 =?utf-8?B?TG1OeUwzb1ZxQkpURzBPYjl0ZnNhOXVkVXVwc2NnZ3ByY0RGaUcwdUdkQTZz?=
 =?utf-8?B?UXIvY0pCeDB5OGpvZk1TMWQ0VDlvR2p0dFpUMkxkTnNlR1J1dzhlZ1hwVzRG?=
 =?utf-8?B?SmFpeVZ0UkQ2M1BvMURYdCtYYkJSWERCUlFUYW5NUlRpY3JHMEFZaHB3b0Vm?=
 =?utf-8?B?NE9ZS244NWpBNHFZczRQUjB4QXpTL3Bqc1VOV3pzZE5USk1YOFE3NEFvT2Zm?=
 =?utf-8?B?aCt1bGlqUkdaM3NXM2RpZHJQN0lzRjdrK2Z3aThUbkUrUDBZdmN5bUVmTjRt?=
 =?utf-8?B?MzFjSFpZVmRvZ283cWhiR2M2NTJYNStoSDgyc0p4TzNUOWFYUGNNQVYzUUpj?=
 =?utf-8?B?eFI4aUxNYmcrdlVOamFpeWd0S0JhVzlrM3JRUDNEY0VJLzBDbUlycnAwT1B0?=
 =?utf-8?B?N0thVzVSdk02UUJHQXlsY212dm9Wa3h6cUVCZTJUMW51QTB0blNYbHRCdU5h?=
 =?utf-8?B?ejFwUm5MMEVqdy9aSE5YUHRGN0dqSFlaZlJ5S0FQcDh1aHY5eEU0QWVxWUla?=
 =?utf-8?B?VHYzT0E2dkg1d2lDb2hGZGNlRk9nL2VpZU5lR25LQkZoR0JkSEdaUkNPQTE1?=
 =?utf-8?B?QnQ2aVY3NXdUWW5oVll5ckwwMDJteHl1V2ROZStLWWJrTUtUdk11ZW1DeFNq?=
 =?utf-8?B?c2hQTDJRVHExTzlyc2tkZFlTbnJQa3pTVDJ5M3hNZE5oK3BmQjBJVTB3aHF6?=
 =?utf-8?B?SGFwRCtwbkFnTmdkbG9lVEJocVMzQnhndFRJZEs3S2o3MG1YVW1nNm50MjRv?=
 =?utf-8?B?ZDRNWWF4NW5hU1ZOYnRZMjkwMEUxT2JCQituaFBkUHp3cjVVc283RGsxQThN?=
 =?utf-8?B?alBtbXV2UjBkOFhNeTY4dWFiMjFyUHA1dXFkMlB4UFdPUGsyeHZ6c0dTR1RM?=
 =?utf-8?B?bEVhTDRwa0JUdzVGVmpsOG9ncmpqK3FkN2pLRnlpMDJsUjRkeVc0cUE2RWxz?=
 =?utf-8?B?WnpoZFRiOVQyaGlBRHNiN2VDRzhEa0dWRnU1NFIveUM2eDR5V0lXSUliT3E1?=
 =?utf-8?B?a1F5bzBReU9aa3ZLa3ZrdUJwVUFqQVphTGpSL0xjTTJ2akZPZ0FlbDRzclNT?=
 =?utf-8?B?RnRkcGVGdEUxaFY3R093V2pvTHE4STNxTEgyeHhiZzBIeTBmYWZSUDRJMHNN?=
 =?utf-8?B?cnJUckw2RGZDeGxTdkN4UU5qb2hUY0w0T3FqSzVrSkp6YkQzNmFUbWtWcFhH?=
 =?utf-8?B?Z3prY2VhVHdIN3BYUTEzeEN4L2NpUFN6SjlvOFVnQXVGYVp5a2lGM2E3NzEx?=
 =?utf-8?B?YUYySFlSNnlrcENmdzBXS0FRWVRqbXh6enRaT0FrZlhxOTZzNjR3eGNLc28v?=
 =?utf-8?Q?Q7LVVXJN28jFT0zO+rI8Xp+M5y+LRWfQyYh0ufl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c417cb0-9daa-441a-f1df-08d9b3e655a0
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 09:46:51.3193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oSQVwm0lpjM7E2HFG7q1Qk/AEBkTc18myqwFSZZkfHqVB42vteTTBwKFezUAlFWe3kgjxkzVQ9Hk2+xfhr5ZTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5587
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

arch/arm64/boot/dts/nvidia/tegra186.dtsi:78.3-30: Warning (reg_format): /dma-controller@2600000:reg: property has invalid length (8 bytes) (#address-cells == 2, #size-cells == 2)

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

arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dt.yaml: dma-controller@2600000: interrupts: [[0, 75, 4], [0, 76, 4], [0, 77, 4], [0, 78, 4], [0, 79, 4], [0, 80, 4], [0, 81, 4], [0, 82, 4], [0, 83, 4], [0, 84, 4], [0, 85, 4], [0, 86, 4], [0, 87, 4], [0, 88, 4], [0, 89, 4], [0, 90, 4], [0, 91, 4], [0, 92, 4], [0, 93, 4], [0, 94, 4], [0, 95, 4], [0, 96, 4], [0, 97, 4], [0, 98, 4], [0, 99, 4], [0, 100, 4], [0, 101, 4], [0, 102, 4], [0, 103, 4], [0, 104, 4], [0, 105, 4], [0, 106, 4], [0, 107, 4]] is too long
	From schema: /home/jonathanh/workdir/tegra/korg-linux-next.git/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml

> +		#dma-cells = <1>;
> +		iommus = <&smmu TEGRA186_SID_GPCDMA_0>;
> +		dma-coherent;
> +		status = "disabled";
> +	};
> +
>   	aconnect@2900000 {
>   		compatible = "nvidia,tegra186-aconnect",
>   			     "nvidia,tegra210-aconnect";
> diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
> index c4058ee..5bc74af 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
> @@ -49,6 +49,10 @@
>   			};
>   		};
>   
> +		dma-controller@2600000 {
> +			status = "okay";
> +		};
> +
>   		memory-controller@2c00000 {
>   			status = "okay";
>   		};
> diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> index c8250a3..94094f3 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> @@ -72,6 +72,50 @@
>   			snps,rxpbl = <8>;
>   		};
>   
> +		dma-controller@2600000 {
> +			compatible = "nvidia,tegra194-gpcdma";

arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dt.yaml: dma-controller@2600000: compatible: 'oneOf' conditional failed, one must be fixed:
	['nvidia,tegra194-gpcdma'] is too short
	'nvidia,tegra186-gpcdma' was expected

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

arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dt.yaml: dma-controller@2600000: interrupts: [[0, 75, 4], [0, 76, 4], [0, 77, 4], [0, 78, 4], [0, 79, 4], [0, 80, 4], [0, 81, 4], [0, 82, 4], [0, 83, 4], [0, 84, 4], [0, 85, 4], [0, 86, 4], [0, 87, 4], [0, 88, 4], [0, 89, 4], [0, 90, 4], [0, 91, 4], [0, 92, 4], [0, 93, 4], [0, 94, 4], [0, 95, 4], [0, 96, 4], [0, 97, 4], [0, 98, 4], [0, 99, 4], [0, 100, 4], [0, 101, 4], [0, 102, 4], [0, 103, 4], [0, 104, 4], [0, 105, 4], [0, 106, 4], [0, 107, 4]] is too long
	From schema: /home/jonathanh/workdir/tegra/korg-linux-next.git/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml

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


Please fix the above and make sure you run ...

make DT_CHECKER_FLAGS=-m dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
make dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml

Jon

-- 
nvpublic
