Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87E76C4C25
	for <lists+dmaengine@lfdr.de>; Wed, 22 Mar 2023 14:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjCVNqP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Mar 2023 09:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCVNqP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Mar 2023 09:46:15 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2A850720;
        Wed, 22 Mar 2023 06:46:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IWYpm+/spXhJrevR/GVpfZBktcWsZle5Qe3lmDgIQBXEp0Nx+IVFho0Hi8p1jYDQdv9QarLv1aypGc6X0FC1xcL0NdZxeTJscAa66K5tL+OQJHdN2+4eM7HqbItM6xV2h9pZ324hXC4gEewgeAkBs9A5XcNX6onAlv955UoaQsAZ54+UuPpBNEUhb0aMNuiWJmc1x/wac6WykJrMszvvv5Ivxz5s0RLvusZspdnFQGwp7vCRNDyk36Td6K1OU2IU6fA420mt5b7WHWIFLb0z5ZbeC3SW3ndU/9ormLllCquvKcGyBWdO2npQnaWIUPSMqh0pzCnGtvIu0/oIxBdu9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ultFKFMecxFpI+W/s7nys7r3AQRcPMpqRIglnCIc0Xo=;
 b=K1iXSHBExHuYSmroEDgZyDslwU76CSDt1pi6hIKG+54i9aN3V4b4jjNZnkgAbeTUPv5StXRdQU3EVv2IXtOrw4zQsTBi9QRCj7kE0aWzR9KM+vZvWZVcEcj8U6cdCZmrg+dRmbqfaCzbEhTetr3/wwk0vFaJUAhfmQbJqhE4ZSAyhwPcyqOG84SH5XdZGmblKVD57eawjXMeCGcl2PfGSbaZIBC+8mSUbwNIpFCY73Sz2VRlJkV2ex+PuBwK0nsTkAKB7wbA4JoozehK2BdBZxYAGZPht0RyHYy2hEsda595+IwpQwhwOPzsBUl8NGoV9iXW+bnhoNhdc716O6qteA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ultFKFMecxFpI+W/s7nys7r3AQRcPMpqRIglnCIc0Xo=;
 b=pfLmMoz7fQkAO846B6v+BIJ/IuQwjcxmWHLUgj3lr+WqDRXBCE6kVZz0KJpP3TenOd6EZ+MPl8ptzAgBMc0Qo+Gt2qd1Aapw82mmH5+OQNUOhs2HI0euZVs88ODG/7GCYoDf9AuoqrX1XLVYSXBCz8VoWgQv8K+rzZmyLjIr4vBunwHBudS9C2/X/9PtD6fSKsvqhnjPkjnGSrELEJf3uzkgMcA26EQ4HdBW4Vp0RD2Oy/LdCmtNq0HokrXBPI9WZ4Ikj+/WvHPqcVzp5rqZHthqi2BndN0v2HKe6TzLDf8acVf0zwPY3ygN8R3ZyYZUAvOiO1ApcudD2uYw+yaubQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 IA1PR12MB6305.namprd12.prod.outlook.com (2603:10b6:208:3e7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 13:46:11 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::5464:997b:389:4b07]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::5464:997b:389:4b07%9]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 13:46:11 +0000
Message-ID: <85946aff-0cf7-62ca-60f6-e95c65b67e51@nvidia.com>
Date:   Wed, 22 Mar 2023 13:46:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] dmaengine: tegra-apb: remove unused tdma_read function
Content-Language: en-US
To:     Tom Rix <trix@redhat.com>, ldewangan@nvidia.com, vkoul@kernel.org,
        thierry.reding@gmail.com, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20230322121001.2569909-1-trix@redhat.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20230322121001.2569909-1-trix@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0054.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::18) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|IA1PR12MB6305:EE_
X-MS-Office365-Filtering-Correlation-Id: b17f11ee-0542-46c0-b78e-08db2adbcbae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RmtQodHDwwD9+ewixnk/odLgnYbCIp4aePxdIhORAqCzgz7T93mo+I8zJ7xBmA9PUAa9hSQVpoyLYj4cA9KDYILYBSTn7pv9p0n5LvPK5THj4VfSovy9DkvX11mJSaUSDVBj0reS2TFWmTMdbhqN/cnnIT0YEokg+zeGLAQvY0PT34qtf2EFBKps3AT1eEVMGONVRYA7CcLXrz6xtfE8qN45A7Ny7TTSFC3ViPCI+o81LWNJLd0vmUieWNiB9frGsNShq0OT5Dj39B3DWo3yGM0Did3TYz/eKa3s8WGZkRLhqWHZ6wHWg2nCg0EGM/JP9JcAap6/uoRLGDXkGDePsh7hOt1VA3l5ziyyTDfH1DK6ettiQ1YXH3LWJKAtF475cf5WGDRHglgXQbsZex0AWFzPQKwDu9d3/95+86ja8PrnKocM4iFYhz0+7S317ipprwiCYvKZIEilZy3rrox7uoebq6sgMnZbUT9EKJN6s2SyNR/1SKUKpmVNUqNs0SyvXr3AqhpFykOLgzCUriTPmI3922SZ77i1LHSDb1W211Rv+UbpeaUAsfUwmlW95zLPWF2jq7TRXYJN+6TnRI2RiSDKa7BiOYTB44WLMXh63KJT5bG9Bxif/OOkZUNG99VC4jHcYgcedIJtXsWobOpPnBrrDVoQ3Av/3cXYuuJBg7+h76ayOX/8AsEPwvv2jl/uuH6MpXsOkgJRM7wOfxYhV28QyKokOvKiGf/FF8zXNwM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(39860400002)(136003)(346002)(396003)(451199018)(5660300002)(41300700001)(86362001)(38100700002)(8936002)(36756003)(31696002)(2906002)(4326008)(6666004)(6486002)(83380400001)(53546011)(478600001)(2616005)(186003)(6512007)(6506007)(8676002)(31686004)(316002)(66946007)(66556008)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGVEQkgySEVrL05xazVEcnpGb2xpYXI0ZDR2ZytzRGNGWXo2NCtNMU5Cc0pB?=
 =?utf-8?B?Q0luVVlsM3phaGFFc2JzTEtYQml2dTZJNzhOOFlsN2xHMFY2Ym05c1lCNlpP?=
 =?utf-8?B?RjlJWlhjRzdQMjVveEN6Ync4WEhNU25MbWI5T25UaGFhR3B6MTdjWGJVdE9t?=
 =?utf-8?B?OXhyOXU4dUY5dHdNMDcwUTRlQmw1UENYR3FTQnVTVmFKeFRBNlVqWG4wZWFu?=
 =?utf-8?B?dlJVSkZOWEFDVzRrNHFpZE91SmxTcFBWbnRqK3ZhakpDNGlHWDl6ZmV5ZzJ3?=
 =?utf-8?B?aFlPRFNFNDYyRno5bUFCNjFUdmE2aVdkWkhDMWloVXp2a2x6UmNrVFBMb1dJ?=
 =?utf-8?B?MlBic2NiTFI5dWRPRFU0NTVhdTlOUTN2QlFrWklJUlRPOFRTdG5zYTIvSGVh?=
 =?utf-8?B?VkFBbS9kV3B1djU1TkdYWjRIWUg3Ykd6OURrVVFBazM2UnN5RzNaeEFjaEZ0?=
 =?utf-8?B?L2x2VFp2eEhjWkxZVXo5OEptZ1RxZjluUkdFS05YNHN0cUtHR1NxQ3d1RXNQ?=
 =?utf-8?B?eWI4ZU5BUk5VaXFVK3p0SFhwanorQUIyU2k4NW5KRUVVa3UrSkJ1YWlHUm9X?=
 =?utf-8?B?UWtpK0RZR3NPdjE3L2JvWWRrT2dLTWVEZXE3RjlobmpNNURhdWwxNHlhcE9G?=
 =?utf-8?B?bFYrNzc0cXQySitEWVh3MEJsME1WTDZweEdUQnRHejdOMXltaHRQMjdMK1FF?=
 =?utf-8?B?dXdFTTFZVGVzUlRNZGxXOFJ0K0dYRnRIRXNuUGI1dDcwUmkrRlV4TS9RSzRa?=
 =?utf-8?B?NHJIaXZ3bVBwdkl4SEdYVnBjNXFwd2J0WDFRQUxXaDJKUEc1ejF2TCtuRDV2?=
 =?utf-8?B?WUhLeXlOdkRGMVI2eUdQTFVkN3B6YkIya09Lc1dUMnRSS3FzMFpyVG1xZUp3?=
 =?utf-8?B?NmJIMFZBMHhqSUt3YXJ3dXVhUGJ6OHdJOGpQTitnWXdWbzg2K3Awd3hhZnk1?=
 =?utf-8?B?d0VQcUNMS0FWbkxRUTczSEYrODkwQzJOZGlBWEYwbloxL2dKSU1yUGZnelVI?=
 =?utf-8?B?TFZESWJPUnRaeEs1b2h2MVJsQytjK2RhMkQzemFyOG1oQzJkQlNwc0QzTWp3?=
 =?utf-8?B?VjBtajdTSDJsbGlCcVh0ZW8wY2liN2pqd24ycVRob0xIRVV2bVZOQy95UXZo?=
 =?utf-8?B?cVRjb3MxdFBrcGViT2h5S2ZBK204aDk1Y01uMnBIc2lRRml6SFZQcWRkOW5W?=
 =?utf-8?B?NXB0Rm8wRktHdXlpcGJOZy9PZlVzeDA1dXIyU2tYc091TWpwNThucjRrbVhp?=
 =?utf-8?B?TmtoMmZqT3RNV0dxSjNmSmZ6QmRna2w1ZGNXb2NuVWVMaUlTSWtYYUtkVS9Z?=
 =?utf-8?B?eVlUbWhqeTM1NnR5eTRtODVranVRVU11NWY3ZmJ2dWgxMkFOSHBWWkJZa0ti?=
 =?utf-8?B?QWtZaEExMU1uUnNUN1QxT2dSWVdXNmhQaEE2Wklra2xHY3ZjR1pHVzZVcGxt?=
 =?utf-8?B?aWxBempRTXA5cE9KdzVlRldHNnhxUGY1Y0VmTmxjZVAxT0ZDVVEvc1hTa2kx?=
 =?utf-8?B?a28rUWRrOWZBK1M3UGxvUTMzQ0R3RGNVcXIyR2JNMXBOL2ltbjFTYlJKWStK?=
 =?utf-8?B?S2M1S0ZrZG9tcWhwUk9zZmlQYkpZZnVNbVpFQWpKaWg0OFJZb3hucTVuSFJu?=
 =?utf-8?B?K0xqeXFIaWVuUzhpOFFEaTNwem5EdVlHc3lUZEpreUg5UWg5NkxOV2RzZWs0?=
 =?utf-8?B?empTTnBKZjMrSXl3UWZCZDRFVm5RQzFSeDNiT1RkWmhzdktGYktuVXZMZE5F?=
 =?utf-8?B?UEFtT2NvL1dnTjg5VkRkN1BNRlo0V2psQ3U3Q0hOL2YzZHdlVXNLY0xGUmpX?=
 =?utf-8?B?cGVNVUEvZUNmN1RpZ0I0QU9Ub1VFVTZuVDBsZk1WNCtUWksyWi9ldmZ0TlhB?=
 =?utf-8?B?MjFWU0ZRYmJvMi9jM29wM3dUWVRLMGU4SnYrTDluZ2krR1pWQld4RmhLbjM2?=
 =?utf-8?B?VytCc1IwNURBcFBvMzEzYUhwMEFFckZSaEVnc2JvcnNXRU51UHVleVNDeUY0?=
 =?utf-8?B?TTBiZ213L1pKTnZERUlHcHcyUkx0emJDVnVmT0tSbVkrY0N4Umh1cUNPRTVT?=
 =?utf-8?B?dnk4akdsQVlhbkdmSXUwWDkvQVA4RnlsL3JIWkFjY2kva0M5R0I0OGk3d1N6?=
 =?utf-8?B?cU4vL1k5MFVQVnBvUmpzWkFFTlRDUDM2THp3TUd0d1lkL3Fzd0JIeDI0Smps?=
 =?utf-8?B?SVJ1Tkp1SjNRL3JtVDA3NU0xRGg5UUl4SnV1aXd2N2FBbnBoa2JmMEdPak5D?=
 =?utf-8?B?ZTZNeHhrSDdJNDFwRmZRREF3c1J3PT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b17f11ee-0542-46c0-b78e-08db2adbcbae
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 13:46:10.9454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D1r0XEGEzL4K4Jeu3N6pQsYF32v7vh+clG3FUv84nT1p6EVpsxaOjnHhjurJvH5YcOd/KeHx/Sj7UPjdSaQh5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6305
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 22/03/2023 12:10, Tom Rix wrote:
> clang with W=1 reports
> drivers/dma/tegra20-apb-dma.c:236:19: error: unused function
>    'tdma_read' [-Werror,-Wunused-function]
> static inline u32 tdma_read(struct tegra_dma *tdma, u32 reg)
>                    ^
> This function is not used so remove it.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>   drivers/dma/tegra20-apb-dma.c | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
> index eaafcbe4ca94..cc6b91f48979 100644
> --- a/drivers/dma/tegra20-apb-dma.c
> +++ b/drivers/dma/tegra20-apb-dma.c
> @@ -233,11 +233,6 @@ static inline void tdma_write(struct tegra_dma *tdma, u32 reg, u32 val)
>   	writel(val, tdma->base_addr + reg);
>   }
>   
> -static inline u32 tdma_read(struct tegra_dma *tdma, u32 reg)
> -{
> -	return readl(tdma->base_addr + reg);
> -}
> -
>   static inline void tdc_write(struct tegra_dma_channel *tdc,
>   			     u32 reg, u32 val)
>   {


Thanks!

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Jon

-- 
nvpublic
