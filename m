Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAEF56A021
	for <lists+dmaengine@lfdr.de>; Thu,  7 Jul 2022 12:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234921AbiGGKkO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 7 Jul 2022 06:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbiGGKkN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 7 Jul 2022 06:40:13 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2074.outbound.protection.outlook.com [40.107.102.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F3A3337E;
        Thu,  7 Jul 2022 03:40:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oRNaALu1c7phw0G/tnrfOzcWtsIJaV1oXYaskW9+CnziC+RM4Wn38a7O+9s1n/XjVqEwWZJOSWBYs2Ft/DmeEFAXDXRaNnkv8ok3U8saefGjmDP2SlG4v1/JdEpww6kgn6CGx+owqpKPmZzzW1um/P/2B3JOlkTxZT26norGGA51VZ1GB/oYqBUlgFx2R0HeCsPgHbeXkuolNCxcGOMScgM6MxjIeIqU4KETkck2go4+xniixdvZiUAQTk8e/Qq1YGM1SamH3VrPe76mT+FFALPTSRQ6YxxOVY24gNB5OzJ5gK1jl5RpV45Q8d9ki6ctrTjmKDxhdq4oYUbkzHT4ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zpd4JzlrHf5nc+lIdBYlhY2E3de2DXXiEO3CgUcoOik=;
 b=TMVsZzh7GMli3g1+8kPA3P2VkpeyCelhkSKyyONLpKw6yNAJBkbYvj9rU/XZy6WZgDGsaLVqOfhYcZQpQgD0Cx/DoiQW1Wd/b9TfI83sU+/X8A3t2g9RVDmo8GsthCo3iyPUrI80/VVN+qRhBDF5egApKZ5iVszKnEN0IoeLpB5cjY5zJn6vvoOCO/8Lx3A1r6C8PE2X4bvy/w7HuO+A1BcNwgyV+aF+KakmCCEuccC/C5QQG5owElhgCQg94IJCP5vjia5Fk8kX8LWWUZOL1G+r7/QhvvSpyt70OlZ/Rmm3hulsFGJ3RuhwHDa9WRVGxp/ugbzJ5JXFG34zOOjxuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zpd4JzlrHf5nc+lIdBYlhY2E3de2DXXiEO3CgUcoOik=;
 b=GMuk4j5oQePi+qy+2AwwObwN8RPseEjnkBlJl75i+yR5Cl3F9kp+zGERNiAcx7v4SvX0AofAd30NL/g0SsZ8oU+N3neW208irbjYRUJ3vzZxLGEyKfz81pjDLwBjWoqCQy5oRcxGUSBL6+9cOZg2YTMH9SaqR/Vl6djFKlP8OmOU+JOAVxQys+OJ3Sb+iLQ4je1IxGnPA0x0aA9NHUan3CWbI7J6avJWExKDLO3CRZEUznHnEL6kkaEAqan0BMzh4JOHEAfZbfol0fqGPISzLpKSSK2f7Hoh48X9712SE2ctCPhA9+IZ4rN253mAF+P6oOm+4lYhCpXNoIu7bcK+Hw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 MWHPR12MB1438.namprd12.prod.outlook.com (2603:10b6:300:14::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.19; Thu, 7 Jul 2022 10:40:09 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b148:f3bb:5247:a55d]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b148:f3bb:5247:a55d%2]) with mapi id 15.20.5417.016; Thu, 7 Jul 2022
 10:40:09 +0000
Message-ID: <1d0826ed-97e7-9571-b5e5-9da12286a626@nvidia.com>
Date:   Thu, 7 Jul 2022 11:40:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/2] dmaengine: tegra: Add terminate() for Tegra234
Content-Language: en-US
To:     Akhil R <akhilrajeev@nvidia.com>, dmaengine@vger.kernel.org,
        ldewangan@nvidia.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, p.zabel@pengutronix.de,
        thierry.reding@gmail.com, vkoul@kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org
References: <20220707102725.41383-1-akhilrajeev@nvidia.com>
 <20220707102725.41383-2-akhilrajeev@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20220707102725.41383-2-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0023.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::35) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79a87674-fe1b-4e48-e3ef-08da6005102f
X-MS-TrafficTypeDiagnostic: MWHPR12MB1438:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gc+gGd0KP10fSH5V8bZkPt0fk5OYTYVZAo7fcANFrmznrJLC+bRSu/kNrcAwNKhYj8h6tkZqDiie86zevOn83UpiuBickiHbOhYUeC+s74xzzKj4Xs8Yu0PuWDrNTOtxQmkkfITBMeX9qEufaKELGKWCl61NfY9CuzaC1FKwlROpvvHftQwO5mRW0rCY2dk4jI5OY2bWWmiZ5/iGN/eNHw5gyF5askGc5XGLw/4tUvzr8CKVczTebLD4ZkOAHD2zKd/YqeUOMm4m6/seOQOIwicIpuKukKgWS+1bRLfv7ldfAnJfY3t6rzu7vyUN95YhuzMlWc5AeBcnZtZYV5MKv92CbemuM5u2ZP2WuaIrw4kj/bQe9WJIhfMNZdiAARUgviOOUQY0yoaHdW7Ay80Xe/qsLW7SFwx5ujCM7hJBBVrBw6ct0JIaLVaSROEun7gWghCOYxn8xs8nf9jCpNjnE9PkJxvtHTfGKYk15ZwqSM35pj9cVQb7s7kNadTC9qar7GadlTcTYdqSz4BnSNQE6jNNsq3DVFsw4uBv5EzXABpwS+IbG2kWF5JiNyc/P/jYV3bFrbVk/IEtvrBdiDY9kxBQlng4x1ZkzYEAc9VDvzocMOGYga8pVvnb1hhqkNAUOZ054eyp3307W4tUmojtRNi2fvNN4hSMVgtQrBCa2uOftt7tNdgu5FenW1pR/VCeLcV6yLN2bspBaKMFJjcQ6wU+uEzODbr4CBQAKn8orPEr8hKnKszM75juQDJAW71s1Mpp9jHqKGkFbGZGYm0/YUDScatmFpu2P20pK4bYRc6YU4lu0M3oKtQMyL1XK/lyzcag7vufSHgZdULn6xSZEbR08IpPNxPks1CIZoxjyAQG91E7Zm/Wt6IgZTNcYGRx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(5660300002)(186003)(6666004)(41300700001)(31696002)(2906002)(86362001)(6486002)(2616005)(478600001)(55236004)(26005)(6506007)(6512007)(53546011)(8936002)(38100700002)(921005)(36756003)(66476007)(66556008)(66946007)(316002)(8676002)(31686004)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OW9kZGRWWUJrMktmSjZ6ZUNBRE9tNFo2WGxuWmJaZytESHl1NjNsTU5IK09I?=
 =?utf-8?B?azB5bGtPM1Rtb2g5MCtZUmhZL1lTenRmZmRHN2srakU2VkpHK3YwNGdMQ1py?=
 =?utf-8?B?L2ExUmg5d3c3TXUwMXQ1cTV0bEhncE56b01Jd0NBdTN2ejF4czJ6SGFyN3V0?=
 =?utf-8?B?TzRiVUFFQ25HOHk5OUhkNTFiTkNNNG0vdldZQnljMDVOK1l1bW9ZZXo1bHZ6?=
 =?utf-8?B?Y21KMHB6VXdBSGc0cSsxR0F6ZERheWdOU0ZMTWk4MGRkclRma2VtUGhYMWgy?=
 =?utf-8?B?em1pT3VnUmNYNERPZlJPcG5YTUYyNWlqbzN4TENWL1dXVzEzRXBkY1BWQ1hn?=
 =?utf-8?B?eXY5SklZL0pZUDNwVjN6Uy94SlkyeCtTNTNvQU9yT25YN3dGVDA5NmlBL1Nj?=
 =?utf-8?B?UFRFR29GVGU2cDg5K3ZTaXllelo2dFdYeitISWN6TXRzUldMd1owanFJNjBC?=
 =?utf-8?B?eVlZT1FwbjY3eDA1ODhad1FwQzVQOVZ0Wnczd2dXV3FVZ0wxa2FnLzJUT3VN?=
 =?utf-8?B?T3k0Y05kVElDT1EzR0hiaEdobC85dDAyLzljcGlmUitjUE9iZWRmZ0liOHBi?=
 =?utf-8?B?SllsdjdoNjdUMHZTQkM1TGtuSFA5dVg4YW1RTU1reitoZlNvUCt0dTQ1N25G?=
 =?utf-8?B?aGdFUk9ZRzBaUm1INmE4ckZ2Qmt6Q3VsSmhMQXlIa2pzdXpGcnZ4OW1OZUdl?=
 =?utf-8?B?TE0rWW9FaCtvNDlRenNQeFV6TitTOUxVam40Q2lIVCtzWUtsSjVuLys4WVNl?=
 =?utf-8?B?MlNHU2c1OWhja2gyWjdvMFBFVTdseC8yRyttanAxeFR4NHQrdWJZbW9jSFpz?=
 =?utf-8?B?NW1UblRsRGIyZitrVnp3VmNEM1lRYlBOaHYyWjhMU0hid2hHNlZrY2ZGRnNW?=
 =?utf-8?B?ai9jZGxCcHZFZ0xnT09QZnAvRUVkWHd2Y1R4Nm9qK2lwaWRMam8xV2w3Wno5?=
 =?utf-8?B?OVlmejBsWXcxWVk5UFVrdFY1WUdEUjVGUHB3UzNyZUdIK0VOZmQwRDRrRGZN?=
 =?utf-8?B?ZU1XTkx6U0g0RE1VRCsvV0RSWVVYUzA2VTJXZDNXWVlzd0xaeTFaNHMrNU5L?=
 =?utf-8?B?OTAwcEZVc3JUZURYQmsxM1paZks3UWR0eWNoNmU1ek1GQ1RGOU5seUJEcEZY?=
 =?utf-8?B?YW4yMlVUT0RyNlJlSjJJU0hpZlFuNEtNbnU3d0dBcUVTVHZDUnQ1UjRxb1JC?=
 =?utf-8?B?Y29oQVVEQU9HYlNjTngrWlFtN0llc3RuVWtuTnlqUzIrM3VURkc0MkxhMG5W?=
 =?utf-8?B?TWwycmVlL0FiTHFqVHNCN0hMMTAwenJNZXRCTnM0MWQvb0wwY1VaOS94RWl4?=
 =?utf-8?B?MDYzUHlTT0FQbllSRTlCcW5aOFBzWWFuekdycjE1clhqNys5ZCtsRWVJeGRT?=
 =?utf-8?B?ZUVOSTB1NnY2ampCT2dSK0tHTUVJS0V1ZnB5WGJDbWxXcGNLdDZxaGRkY0lN?=
 =?utf-8?B?SVhLeW1tSkJidVhHNDhRUFkyQ1hvYVREOGVuL0RNYWNBTUxMMlRzdm00dU5n?=
 =?utf-8?B?TmorM0s1Z2RSdFI3a2dPTWM3NGRPcmJpT2pkYnRNNVFrSENNUlNUZkVaY2cw?=
 =?utf-8?B?VW5qSWlnb2NHK0E4ZmY1MmpsRi9wdGx3R1pHR0M3YUc1Uk1yNC9BQnNzK1ND?=
 =?utf-8?B?STVtelBZb3g1SllXblBoYmV1K0IzZEpBNjNGMTNjcGR5TGNqUFdoYUNPS0tl?=
 =?utf-8?B?YzBJeXR0M3MxUEFSN2Y2blVjK0dFTUVHUm80VEd6NWxjZDhmcFFDVHJkR3Rv?=
 =?utf-8?B?VlAyUS9YTDVEaUlQTTB3bFpCSytxZnlqd1h4OUpCT0M5bTcvdkkyWUdSRGRH?=
 =?utf-8?B?VUUxd2p3b3F1WC9WNFNOTzQ1N0VzVXBhSFVtR3ZKZnMyWEVtSnZaTTRzVVZa?=
 =?utf-8?B?dEo5aGplNG1WNW9NS3MyL0ZmeVV1Q0xwLy9zeEsreWh1bGtjTnlHVXB3WVlt?=
 =?utf-8?B?dGZkNkZVTGphZVhiSFIwaVpoQWROc0tDZWdZMFVybEl6Wk42V2NlOWdid0do?=
 =?utf-8?B?T3JtMGxsTHdtcDY2MitvNC8vV0tNUHR6cllNNmQ1Mk11c2hpb0Z2YkRjN0VZ?=
 =?utf-8?B?SWo5OE5CR0pJRldCemZiSW5EU0sxMVdKVlhVaVdDQTF2b2EvVzRuK0c5WFJx?=
 =?utf-8?B?T2VVZktaYmRlbnREMXY5UzZxc2RoYmZyUldWOWkyVTIvSjc2SHhOVjZLdnVD?=
 =?utf-8?B?NXc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79a87674-fe1b-4e48-e3ef-08da6005102f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 10:40:09.1679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qHXrLHBUYwYnr0aKGxUHrtU/HObq/iT2nbdMYfPQa1YYeHtrMd4F1Jq2f6zT2TXJapTJJ0vv9YqfA4cGrNZapQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1438
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 07/07/2022 11:27, Akhil R wrote:
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
> dma_pause() and disables the channel.
> 
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> ---
>   arch/arm64/boot/dts/nvidia/tegra234.dtsi |  5 +++--
>   drivers/dma/tegra186-gpc-dma.c           | 26 ++++++++++++++++++++++--
>   2 files changed, 27 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> index cf611eff7f6b..83d1ad7d3c8c 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> @@ -22,8 +22,9 @@
>   		ranges = <0x0 0x0 0x0 0x40000000>;
>   
>   		gpcdma: dma-controller@2600000 {
> -			compatible = "nvidia,tegra194-gpcdma",
> -				      "nvidia,tegra186-gpcdma";
> +			compatible = "nvidia,tegra234-gpcdma",
> +				     "nvidia,tegra194-gpcdma",
> +				     "nvidia,tegra186-gpcdma";
>   			reg = <0x2600000 0x210000>;
>   			resets = <&bpmp TEGRA234_RESET_GPCDMA>;
>   			reset-names = "gpcdma";

I think that this should be split into two patches.

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

The commit message says that "add a new terminate() function that 
ignores the outcome of dma_pause() and disables the channel". But I only 
see pause being done here.

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

-- 
nvpublic
