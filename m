Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80ABA5739F7
	for <lists+dmaengine@lfdr.de>; Wed, 13 Jul 2022 17:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236290AbiGMPW0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 Jul 2022 11:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiGMPWZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 13 Jul 2022 11:22:25 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4274B45F7F;
        Wed, 13 Jul 2022 08:22:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AYjMV89XbnBdpQMBsvc3JazleYeJ/x5Z5GCfx5wpoNzawUI5WZvryOZ8Ds7CT5bLrhEbpnVCg7d+GrEgJ1YNZweaiauLzNsUT4fN+4Yk6FBjLaWh1ssjZ5/UU6hQ5asN74geM7XRx58kfTXcyo9/YexadL4cPxVQvN6iAcuHKJLo9oP8lDarPCTSPN989A3wrgD81/8gP7zBsmOK1R8rZUcXVq1DBD01hzabR/VwxhX7Itnj+5Bf56Po8v4H/5Bq7bNGFiF8IDuifA2HEillWLLxxYWKM7yTYZ4zv5buxnOW6jEMdbiFJtGuAkaPNQnkpfsj+Lyevk50ZGek7koGzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=93Jo//s7Mee1aRRaKPNxCn5UirrA+TVL65lKFO5P4vo=;
 b=AoJJxZ8Ccxtjx3MMWzHUTJHkXIWZMLzWHv/CU86A+LAMbDZuChQ45S9e/4OK4tqTfv4XUN3+1jWPlwh/8/EMMrEbm0UchhORTNRmLY05zSTbq+2LmjD6d3DKBr7CtT8mvTpyb79H9ba4pKS08hhZWR1HcNJSMEKwjy2igHMvRJTYtQYQnKNANnrC/I4Bxxg8HigrUMC6bq2is0v2JRb+d4juVfgZF+iZqnvByvX1ygxI1qbWQhdpcXJJa00IFInlfhwnGIYi/7Y4Sn7MQ8n4n9eSLvFYiD4bLYLWsUd++Jx4DElznASz3zcxzmP++W1QRU9p9+5f93XkUIRtC6aB0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93Jo//s7Mee1aRRaKPNxCn5UirrA+TVL65lKFO5P4vo=;
 b=BiQUjEEnGRK+T8th0f9FkK9oksDeCz6pB2aOBxz0v0Cdx7VKFDOkV26HrxosVnWFIthbUcVkXEo5I8BaNmyIZiqU/qpIQsANvsmXnGDhPXyp3Y+SEPklxR3ElEcgOIe+v9LavMDoU6Bl/pp9Pa12797DoiVzCgUkA1I2/oGKSrho1mvCuRPSQqxWv2NWs/wF+atvXZRGyemByvuRHc4FoCucVswSO4Rd4kI3le4RiOTcMjGz70gm2aBZl5WcFInBj2UT/q7OqCMD2Nw/gvhhJqKvLJhpa8fSeXJfYQz+ELlb5Q8FKfFufSigCdfBjBSrXr7Unssi/l1sITL7fKrSwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 MN2PR12MB4608.namprd12.prod.outlook.com (2603:10b6:208:fd::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.16; Wed, 13 Jul 2022 15:22:22 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b148:f3bb:5247:a55d]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b148:f3bb:5247:a55d%2]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 15:22:22 +0000
Message-ID: <3d299b69-ed76-19bc-a7bb-038ad0d0df8c@nvidia.com>
Date:   Wed, 13 Jul 2022 16:22:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 2/3] dmaengine: tegra: Add terminate() for Tegra234
Content-Language: en-US
To:     Akhil R <akhilrajeev@nvidia.com>, dmaengine@vger.kernel.org,
        ldewangan@nvidia.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, p.zabel@pengutronix.de,
        thierry.reding@gmail.com, vkoul@kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org
References: <20220711154536.41736-1-akhilrajeev@nvidia.com>
 <20220711154536.41736-3-akhilrajeev@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20220711154536.41736-3-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0008.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::20) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a2c0bbb-29aa-444a-3cd2-08da64e37bb7
X-MS-TrafficTypeDiagnostic: MN2PR12MB4608:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VjiyMjvndk/Foc3F4TAbYuIPka9OihO2ze0KdGPb0DrJxxhruc43nm4dC70X7/WLlBCjgresyITh1EHpXezJ2ul55jS6hPeIoxWi9Mo98wHJnM2twLjSKJrzEpWF9Pu56N0feDtc3zpDmX/6D5pnfAtzux/Qb+swq/bDEqDjlp7Z/6wXNMrMBvEpRnDJZzul33SQ6kiUmdpGIe/2IMlsZA4/ilyxlKWb6DdsZ/RseRhqgTFzTPPRNxzro6Zf9CcrKJdkVR8VViI5/6zAXy9cMggJW/Mizo/V5hbBxLwLQIqcC2DkPUG6rOIc75RsodiH81HOKXhta3jHpa6HGb88HzsO4Jxhb8NGLQ4Atewku57MhwIBbt2gr5pSnc1nohuxm39Ag+0LUyNB4CGfbm9J0d99UbL8DN9lr9thKoeULxjB/FWGqnX2o7NKjx4j7rYWPS4CHSiM+K2s4F7VpJQ2wYK86A3q3YtZxqcFiSRsgynH/P67FO5bXKcKz+r5M1W5VNWpoWhuNWYdUqQZvI9xAgl3tkAtVOBdELeOA4Kya7vuwg08tYszRhzoOM0moxOXodnOARArz9kYGlnYlUQQ4CZ+YE1F5tfRoLT3bhaYpRQctUdXbwNOugovR+o0Eyt/vbkDi/cyDe/H6vCK8b25PBNKcYN75GueyX+xihalaYznf8JKxQvwYuyTxUeWVtiWGqmweJjTqpboBTA94P2Hd8H1lO2gy/YLLbcex6FrVbm4LGWOEPI5Jo3pbPuA9sC7DhkEyMjucBF20Nd/InljbKy85+C6V7yO4cDK97sj0QcWmq4331/KwwYRTwbymEuHMZe80SM2oyGEeCKFfsAJblmIAlw/VPxbd5Wx5L6ijQHqpdan70lD8NTVPfrvCq8b
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(366004)(136003)(39860400002)(346002)(31696002)(2906002)(86362001)(36756003)(31686004)(8936002)(316002)(5660300002)(8676002)(921005)(478600001)(66476007)(66556008)(53546011)(26005)(41300700001)(6512007)(186003)(55236004)(6486002)(38100700002)(6506007)(66946007)(83380400001)(2616005)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1dsem9UWHV6ZFN0bGJ5cEJscStJSkJia2VSM0xuUDlnU0xhb3Q5eXd0SzN2?=
 =?utf-8?B?TjlEd3dYTEZEUDEvNUgzMHVDOWhsTi9zMFg0aDlrSmdVTGc2aXFQL3Uzb0Vn?=
 =?utf-8?B?UVdvajB2MVVyU2V1ZU5Ea055UTQrMnMxWEt6dlhCTmZuUGNmeTNuVDIrRi9K?=
 =?utf-8?B?U2tHeHpPMG8xWWg4eDh6N1llQ0xPam1NWGVMY3pkbzZOaVF6eTlDS0pLL05N?=
 =?utf-8?B?R0xFZmR5RlBTVlpKZkRadWxXYWVrZ2VzREhubUdVc0g0aHlRRXZ0MVlhMEo4?=
 =?utf-8?B?THpFdHpxcm1TSWFSUTJlVkxHSUQ3OEdZMnc3ZXpXQTRUQUpvaldaVGJMM0NC?=
 =?utf-8?B?OFpjM1F5VnJUcjREczdYbXcyWnJiajdlRDFQTUZPcGxQNVlMd0JrZlpQZ1RL?=
 =?utf-8?B?anBKalpVSUlyTFRmZ21jN1RHYUQ1YUJiYXlvMmVybHJJbUR5L09aTGVmYnM2?=
 =?utf-8?B?UGptazZxay9zeWNhSGN0Umo4QnhTUTE0SjdGYVhhTkJYdEU5ZmhaNDlDekYy?=
 =?utf-8?B?M3RCMW5Oam9ORGs3cTNMVk1FTFJRU1NGTjRQMU12VGZWSGkvN1YvZGUydXpz?=
 =?utf-8?B?S3cvS1ZKSUcvZGRBdDFaUTc2ak8wdkduaWJZc0VkS1p6QlZqWDlPbmtNdXlJ?=
 =?utf-8?B?WEpSY09md3Vjb0l5azJIeHFqNlh1N2puL2FIUDlVOG1ROG5EblpydW5ISzRz?=
 =?utf-8?B?N1JoU3NsK2s5Wm00eVI1VU9qakgyOEtsdENGcDh0NlpVZHJOWDVJZjFEREwr?=
 =?utf-8?B?YkJnaDUzcCt6TTFuUFhneVZHZWRnaDFqdFBwSXpadUp4T3NPYWxoeTRPTnNH?=
 =?utf-8?B?SUZsWkxPVDJXSTYyamoxQTVHQkZaQ3V2TG5uekMyZ2lUZkp3dUNzbnY1aVlO?=
 =?utf-8?B?dkU0Y0k5RE1ESG9KSmc1RmQxZjhOcm1JT0NnTm1VSVZhNStaeUM5dGFPZFhX?=
 =?utf-8?B?K25ISExEMy9RM0dWcHVzdFNUSWNoSDNHMGVOTWVMZkx4d29RaURMNlpwR2hx?=
 =?utf-8?B?STZOZUJPL2lqN2RRc1dtRDV6cGxlTUdLSm9HV0YvMWM2T1FVdXZkUi83enh6?=
 =?utf-8?B?Rlp1MDRBNVhBWWJJMW9MVGN5OTRFTFI3OGpuc2FUUndwVWRPSDZvVXczK3Zz?=
 =?utf-8?B?bUdGb3lmOGtTb2RORFd4b2lLd2tnVHlrVjhVRjlKa3RnaWJ0OFNBUHMxM2g0?=
 =?utf-8?B?dmZmanRRRzB0MjlPVERESmRXTWdRWlRyVnB5Wnk3cWV4T0kySVN0WFFyTlRy?=
 =?utf-8?B?SVgzcTMzam0wUU9EcTkzMlFXYkNTQjlKNVJ3WVE0K052UU1CZXBlT1R5ZGgz?=
 =?utf-8?B?TDcvcTNkRCtET0hTNUFLOTZVNXRCdVNybEtoQmdiMjEzMXp1R1ZVaUFhSVQ3?=
 =?utf-8?B?dWc0cENZeWlOSm5hV0FFdDVTNThIRGpXcGwyVktpTVBoa2dPdWNLZTlia2FU?=
 =?utf-8?B?MkxNKzBROTBMUWQxTmkzUlFheHQvcU5YZndQSVF1VnNCQksvRitzdTB3djg1?=
 =?utf-8?B?WG0zM0hxR0xMNlJybmRwWmt5V1lmNTdiYXNYYjlVNk1oMlVRaG8rMGpsUmZ0?=
 =?utf-8?B?N080Y3ZhZUhQYzZiZkRpaGRUd3FsdVp4WE5BdXZUUGVPTURFcjJXL3NUWU1q?=
 =?utf-8?B?L2FCZU9mbUtIWUFDd1dXcTdrbEJONG5nb1pEWDhBZlN0cjBpY3VhTDQwTU1W?=
 =?utf-8?B?bTYxRkZmUjM0QnVVTGRKcUYxNW9manRXK1pPSHlick1sZ21wL09xdTRadWhh?=
 =?utf-8?B?TGZ2TWFYOWlGOEhCckI1OHRSZ2RYeDdYZlFoUXd4dmJuc1NuMDdYeHZXM2ZL?=
 =?utf-8?B?ZUF4eVN1bEFSWGpmZFdweHhwaGd1OXFZYitUWmQxSGpCQm5hQ0FIMUMzdW4y?=
 =?utf-8?B?TnpOZmY5b1JpNVVGQTkzL1RveWtYWTBmR2ZtVi9DdHBUV2hUTjBtZmZWOVJj?=
 =?utf-8?B?SnJNMGtoQ2lYdXkzSE40dVdBV1dndzFoSWhIMFdKRFlRcmlaMEx0THU1VDdj?=
 =?utf-8?B?TGsybXVLNTdGQzE2NlVuTUpIeHRPTVZidzlXT2N5Nm1NWTArT2RUaE5naHFJ?=
 =?utf-8?B?a25GY2dJQXVySWVQeEZqM0pTdUg5U0NmSzR1bFZPd0hZdFNLRVR6aTdLcmU4?=
 =?utf-8?B?OUNadzZRbmN5L3E1RlBBUjROMkllcHdSbDlsOW1HcDlrWWVRYU5FN2IwUHA0?=
 =?utf-8?B?QVE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a2c0bbb-29aa-444a-3cd2-08da64e37bb7
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 15:22:22.4961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iolkbt7lknWN1/y7T/1ZIgohFC2q6wqNmtylaLofuJbqf9Zu7N6CNfLiBQckTyMJncN0VLJCK31oWrwfCq84tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4608
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
> In certain cases where the DMA client bus gets corrupted or if the
> end device ceases to send/receive data, DMA can wait indefinitely
> for the data to be received/sent. Attempting to terminate the transfer
> will put the DMA in pause flush mode and it remains there.
> 
> The channel is irrecoverable once this pause times out in Tegra194 and
> earlier chips. Whereas, from Tegra234, it can be recovered by disabling
> the channel and reprograming it.
> 
> Hence add a new terminate() function that ignores the outcome of
> dma_pause() so that terminate_all() can proceed to disable the channel.
> 
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> ---
>   drivers/dma/tegra186-gpc-dma.c | 26 ++++++++++++++++++++++++--
>   1 file changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
> index 05cd451f541d..fa9bda4a2bc6 100644
> --- a/drivers/dma/tegra186-gpc-dma.c
> +++ b/drivers/dma/tegra186-gpc-dma.c
> @@ -157,8 +157,8 @@
>    * If any burst is in flight and DMA paused then this is the time to complete
>    * on-flight burst and update DMA status register.
>    */
> -#define TEGRA_GPCDMA_BURST_COMPLETE_TIME	20
> -#define TEGRA_GPCDMA_BURST_COMPLETION_TIMEOUT	100
> +#define TEGRA_GPCDMA_BURST_COMPLETE_TIME	10
> +#define TEGRA_GPCDMA_BURST_COMPLETION_TIMEOUT	5000 /* 5 msec */
>   
>   /* Channel base address offset from GPCDMA base address */
>   #define TEGRA_GPCDMA_CHANNEL_BASE_ADD_OFFSET	0x20000
> @@ -432,6 +432,17 @@ static int tegra_dma_device_resume(struct dma_chan *dc)
>   	return 0;
>   }
>   
> +static inline int tegra_dma_pause_noerr(struct tegra_dma_channel *tdc)
> +{
> +	/* Return 0 irrespective of PAUSE status.
> +	 * This is useful to recover channels that can exit out of flush
> +	 * state when the channel is disabled.
> +	 */
> +
> +	tegra_dma_pause(tdc);
> +	return 0;
> +}
> +
>   static void tegra_dma_disable(struct tegra_dma_channel *tdc)
>   {
>   	u32 csr, status;
> @@ -1292,6 +1303,14 @@ static const struct tegra_dma_chip_data tegra194_dma_chip_data = {
>   	.terminate = tegra_dma_pause,
>   };
>   
> +static const struct tegra_dma_chip_data tegra234_dma_chip_data = {
> +	.nr_channels = 31,
> +	.channel_reg_size = SZ_64K,
> +	.max_dma_count = SZ_1G,
> +	.hw_support_pause = true,
> +	.terminate = tegra_dma_pause_noerr,
> +};
> +
>   static const struct of_device_id tegra_dma_of_match[] = {
>   	{
>   		.compatible = "nvidia,tegra186-gpcdma",
> @@ -1299,6 +1318,9 @@ static const struct of_device_id tegra_dma_of_match[] = {
>   	}, {
>   		.compatible = "nvidia,tegra194-gpcdma",
>   		.data = &tegra194_dma_chip_data,
> +	}, {
> +		.compatible = "nvidia,tegra234-gpcdma",
> +		.data = &tegra234_dma_chip_data,
>   	}, {
>   	},
>   };


Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
