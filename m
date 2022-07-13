Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3797B5739FD
	for <lists+dmaengine@lfdr.de>; Wed, 13 Jul 2022 17:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236881AbiGMPWu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 Jul 2022 11:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236858AbiGMPWs (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 13 Jul 2022 11:22:48 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDFD45F7F;
        Wed, 13 Jul 2022 08:22:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y2bujd8mR7qitU4MCT33Wy0vqEKx+Mh3IXxxszlrIxD47UFomUAYMdv370wn633UbADEJ9Xv7I2pi+ydfBE1v0oAu+n6BptvczsyqtAgOsxeTWUVZalcRchWP5i0NEuvGmTWCASqLaGmYyNCK9d4RZaL9l2Xp9yt9yz3WRmFwIJABU4RCqbMM2VGSQe/Ggo+2mdiDR+oHpr5M9Vhu3pTEwN9gxB43izfaEE5DuZjWnqax5Bz2IqCDxEvQg7142W7R8x6u2X6RCpvYZySpBakC0eUWmEwk8KAHI2DaNSdjQdpvcerOKg7qPCrMov0KL/vYbFWA076Ca6IIvjy+jdFFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sfORWK8vNExvOxc6qagmtvuEA58ygK4A2xiB0dF6cK8=;
 b=QBNABtbQh0TcskmJs9ZyONd7DhFhbMxWL2WbFgACU5AVhqbzK0KDyoSW0VS9RFe5DpSeTSR73NLvF6Opjkx9vqvPceZTDx+mpBmDeq4FTkE3Ph4Xb1ryhBuinkoQyg/aKwy5+6jmxcOZxvAmks67wC8OwBquc4k3euAV2teo9+yr5x7ldXX71td9xFWHxL1udMmZK3Z7jTmD6/4N+14YJjUU/+ORqSnqp/pSq+w2E+kq6bRmdzT5rgaRx7hT0BNZlJ4n9w6SrUKpOB1F/Ri+ZgavtImVOog9MVRXbipSVi7xLKlQPZlNDskln0ZDsenYWNtX6DtDrDLzv0wDsphxqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfORWK8vNExvOxc6qagmtvuEA58ygK4A2xiB0dF6cK8=;
 b=iBivzNEPdkJIaLQBK7WPW0/89nyu21sb7M0535zo8QJrjDBbVaPnZns0hx1zi4u5dUEnvxAAPyv9bm9YmudCz8W/3SRdEpSFruiXgno3aWkhwa9X6OvMC7fr4Dbbl+AJ3eMjx8WK/Xm8kjt0VoV/6TVmIHHdCOo4EbzP93B6BhGBts1NE1OTO4VeRCAWJNx+W6FSewOj8NR6JCr0U74uPeabHRDHR3diLjTgYgVldzjaCADwYgWopF2GHeQidi1fU3uf27pRx73fLT0EM4KUsnJuPw0zv5EsHUaBbrhRf8UAakXwTATTCe4jxT/q/Kq3s4Swvrflmr+I41/igCLUwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 BYAPR12MB4792.namprd12.prod.outlook.com (2603:10b6:a03:108::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Wed, 13 Jul
 2022 15:22:42 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b148:f3bb:5247:a55d]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b148:f3bb:5247:a55d%2]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 15:22:42 +0000
Message-ID: <084ecc22-990a-c5de-d457-560ca309f35f@nvidia.com>
Date:   Wed, 13 Jul 2022 16:22:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 3/3] arm64: tegra: Update compatible for Tegra234
 GPCDMA
Content-Language: en-US
To:     Akhil R <akhilrajeev@nvidia.com>, dmaengine@vger.kernel.org,
        ldewangan@nvidia.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, p.zabel@pengutronix.de,
        thierry.reding@gmail.com, vkoul@kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org
References: <20220711154536.41736-1-akhilrajeev@nvidia.com>
 <20220711154536.41736-4-akhilrajeev@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20220711154536.41736-4-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0001.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::13) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1e83019-9c42-4a30-8fcc-08da64e3879b
X-MS-TrafficTypeDiagnostic: BYAPR12MB4792:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G1z15tTz4eQ5rvxinZWbSBLirpCppvVwFjx8a++pSRaWAao3V52lDje4ZKxiSwmQ2pC1DG3g2AZGx2KAbM+CPmFeLsOWlueBiOIWm05Sfwz8AaNv8OOqezZjGSfEpojtugIs6yFBiGRpmyEkcC7a7LF8DSIUuh4KW00bHywxQLjJ8OZoYrte1NPrMjbDFSky0XC0D4yJX+OoXrEya0axX5TVvi/de7gAhAyr+mdxSI2xY2TrRM5dFnRbnXVqwZHjgp+BnDF7YR0fL6mlLs7G4GpVvSOYDcdZAlTHKbQ+ieLy62RXaxmsSG1vVXWy4ZXn5QqTrngmPZ8xohJWotvuUrunacAaPDb25RIQG2N3qe8ws9Wd46xURatNKGqt+iEtScpN0hOESpAxem29oN6F7uWcNanZf+MlRy6fwXhnawyO0dy14+kwo6yLNPooYrCNfOOjhbNAQzofCqqfBVf2mlAZa7UkmxTJjiwtsJoPec3GbvMZShdZDqh8O4/2JtEah+4Nt0wGydT36JGpOmB1XDPsR0Fl14IOji2iyGxH6a1AG+vpSVbrbrIvQF1d/OUd4zNnb02N3iXNtlXVrjbloCDmkPZ7ffcQhHqrcSaZHa0xitVnlTKUEL/TBq8Y9fil3EbBUO/WOFYL1HtvmXb6hkf45UpWWQwhi+J2MswmIHCQXCmugHB+7tIg5JXyIV2Jy7q7E9jmCyUI0Mlpew4X9AcN11QT9UEMhSGPz5nK1bzDU201yUa7sw2xHgE+IY3EcewSmAgqrSVfyujiMw3bOPkRrpSQar4omuDalb/kZMuAGH7U+NVAgWa+oDwc4XVj0xOfkXgrpfXtJVNVXKw7ojGOOOemYUoR+zV/GUhSKzj57k3o1ANHiDcS6yfAbSte
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(66556008)(83380400001)(66946007)(55236004)(31696002)(41300700001)(6666004)(2906002)(86362001)(53546011)(66476007)(2616005)(6486002)(6506007)(8676002)(4744005)(186003)(921005)(5660300002)(6512007)(36756003)(316002)(26005)(8936002)(31686004)(478600001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2N4TEduNkwxTjBpV0x5QjhTMVJxSW1YeG9pVzVmYUpGdTRqc1RKNm1BdVRK?=
 =?utf-8?B?WDBmWEM4QWdzNXRXczlFUWV0SHdNdXkwcDl0QW1ybVZBOWxDQ3ZXQ0ZDUGRL?=
 =?utf-8?B?YjFZSGlDVkh3ZGVYS1ArS1VXRUZ2MWZFVU5QdmdkWWdIS0FJcnJVaTVkSUdT?=
 =?utf-8?B?SlRHSjIvYjFFUWRNUXRhU29oOVRzZGE1MzFrZGRaUWdOcm1ZbnVRVHgxQW9w?=
 =?utf-8?B?NHFLTlBVNVhrYzRicFEycEI2Y2VBbGRxVVRWYzdWRG5wQ1o1dkhYU3VqUTY3?=
 =?utf-8?B?dmpEVzQ4Y1ZlWjVmL0NjT0lwWUpZdXQ5QjIrWWNPaTNmWXRvdkxsdUd5WUUy?=
 =?utf-8?B?ZHZLM1RsbHFhVWZBQTNBSTkvMWc5V1FwcmYxOU41akQ5bDdiM2FBNmJ6Q1p4?=
 =?utf-8?B?NUczTzZhUzNteXVEYWRDNUcrQURkdndOaS91ZWZlR2phVmhYcEFGeGdDREtx?=
 =?utf-8?B?d0pXTEpJWlNRc3d6TlpsTzlRVk80RERaZWVXODA3S2FYd0xOeTBMVlpFZ2Vj?=
 =?utf-8?B?UlBWNmo5QUNMcWQ1LzRYNllwTFZETHdxZENGY3RxWUtxb09RTFdLYlFCQyt0?=
 =?utf-8?B?ai9UV2xadnM1YWZCOWthMGd4akw4S0o4aWJRa3VMTGZ6bS81WEZUSk1UZHE0?=
 =?utf-8?B?MjAwSHhHSTdIYkEwWlljM1h3cDlZWXJpUlJmUXB5eVJ2QzFBSVByT2tuN1g4?=
 =?utf-8?B?NUlBK1dadUFHZUJqS3d5Q3FZZHpDVjFTcXQ0VDE4dTc0RklWbE0rNzBiS1pn?=
 =?utf-8?B?ckEvK2s4NjFaaExMMGo5MkdJa0ZxYkZHTmVFb25PeWh0dGpqUGc5TExLTkhq?=
 =?utf-8?B?OUJBZHAvM3A4Uk12aklSV3p2YW4vcWZsUzFvbVMzNzZRaHdURkFxMWl5cmFZ?=
 =?utf-8?B?YTJ4QjAxZmJBeHkxU1Y3WUlQbytmRTJaWFc3WUMvbFh4QTkxTHV0RXViaDd6?=
 =?utf-8?B?Rjd0THlLRzhrQTZqbmFwRXZOekZwNUh4TDJraTBNaXNzY3Q2L1JNQ1ZyTGxq?=
 =?utf-8?B?T3V4S0QyQUdkTklOQ1EyVEx3MWN3ek9oMCtNLzNFRTJ6blhFS1Naa1pUN0J2?=
 =?utf-8?B?Rk02TlBQK3lValUwd2VrbEMrWUczZ3lOTlRXUEFWaU1rV3hhRGpkOXdGRjNU?=
 =?utf-8?B?VkdJTjREc09ORUE0N21VcUFZS1NPM0J6VkdUb0ZEeklVdDQxNHVZU3pzbzJC?=
 =?utf-8?B?OXd3M2xkTVNJN2NxT0srTXJWczNZQzNleUcwNEg4eEhKaVVCQTR1SnpuUW5w?=
 =?utf-8?B?TTJaWkV0ZlZkd1VWMWlFcVBsaktWK2R4YlR2aUxFbU8wK1VqN29PdWpON2Jt?=
 =?utf-8?B?NW1RQ3ltTThUY2NIbDlJMW40RDNSbmtwTFVMRWxSd0NzdjRIY1QvZDFTTmM1?=
 =?utf-8?B?RkZVZnRETjl5aGVseVRDK3o5YUtxRnRqWlZNd09xSkJ5OWdGQmFlNDF3SzQx?=
 =?utf-8?B?RWJtcHA3TjYxeDlWK1dKMFd5dmtyc0RuTld0bjdUamtFRlBNQk40UG1uQ05O?=
 =?utf-8?B?TTYrK3V1UktQQmdzd1lxWm1OUVdsTUtEc0VOME8yM2hkVE50eXlPZmJXK1ZV?=
 =?utf-8?B?UnR3OXNJQ3kxV1VMMndwdTVaMEx2MlIxZzBiZzdOSno4cTJWc3pEZlVQaHlV?=
 =?utf-8?B?RUphZXJRWk04MVQxeEdQWUV4R1NhVzhGUkoyTExPTGxiQmxTN0xrcU8zYVcx?=
 =?utf-8?B?Q2RHUjdnUDU2dkUvOXIyRnZtR0dkZXFnMVdoTDBnbjZUamtHazlpQ0dFekx5?=
 =?utf-8?B?ODBJN1NWWkwwYTB4aFRmM3dYSFVOK0VITnFOSDZsaTlLWmM0cUtzZDVnTUYy?=
 =?utf-8?B?MUZST01CdEw1T2NVOUErOElCeGlRZVk3NmhYWkxyVXVlUGd0L29pbDYxVFdO?=
 =?utf-8?B?SXp3STBvaW1zY1g5bmFERFN4UFJOdWk4NFlaS3YxMEd6UVRmNnRGSWFsVlkv?=
 =?utf-8?B?NEFHQjNCN2RLa09hUzhmbmV3eWgwWmQ5Z3dENjVFaStDR3NVV0RZTExpT3Zy?=
 =?utf-8?B?dWpSWjkxVXppcE1yWS9mNEhOT0ttM3p2TmN3Nk9QdzZXcDlGVVVmWnM0N0Fl?=
 =?utf-8?B?bG8zenFwNE9FQVZNTGdkSnJCNU9rUXJvdHhtM1RYUkFpYVNZb2pBRFBjdWFH?=
 =?utf-8?B?Zmk1V0w0OVpSMzF1UHIvZkJYcThxaTlHS0RONFpsdXBJaHZlQ01hTC93MTVC?=
 =?utf-8?B?VVE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1e83019-9c42-4a30-8fcc-08da64e3879b
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 15:22:42.4175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wNvvizSpvhZHMxCYz8aKgwF68Eyd2hzbiQXDVqsSXZKi9a+I3O9bY8wkhCXPUMCyOsbEQm3Mzl6vR5xXZ5fGfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4792
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 11/07/2022 16:45, Akhil R wrote:
> Use the compatible specific to Tegra234 for GPCDMA to support
> additional features.
> 
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> ---
>   arch/arm64/boot/dts/nvidia/tegra234.dtsi | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> index cf611eff7f6b..c3d2e48994d1 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> @@ -22,8 +22,8 @@
>   		ranges = <0x0 0x0 0x0 0x40000000>;
>   
>   		gpcdma: dma-controller@2600000 {
> -			compatible = "nvidia,tegra194-gpcdma",
> -				      "nvidia,tegra186-gpcdma";
> +			compatible = "nvidia,tegra234-gpcdma",
> +				     "nvidia,tegra186-gpcdma";
>   			reg = <0x2600000 0x210000>;
>   			resets = <&bpmp TEGRA234_RESET_GPCDMA>;
>   			reset-names = "gpcdma";


Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
