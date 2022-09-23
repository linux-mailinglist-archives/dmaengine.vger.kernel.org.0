Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144205E78B3
	for <lists+dmaengine@lfdr.de>; Fri, 23 Sep 2022 12:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbiIWKvP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 23 Sep 2022 06:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbiIWKu7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 23 Sep 2022 06:50:59 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7728FD4E;
        Fri, 23 Sep 2022 03:50:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WjuQjvY/CayD9FhgSiWg4+vbp/ITi6sI3hFGOZj8juNwXjrt7+nzBihgTkG1RDbZv4OQCAQMa4xNx97fpUjDNgqjI8AX9hvS13BGnlRTM2IQJv+d2JU/fkRzQk5QqOwatKYt8DO1QU8OKnaooOzdPjTN8rYrpA+KvNX5f8BXB74vGUNeX4UGLAghXMawZHlP4vpzv+L4CTbqfGmIgy3YCl6o8zVdYLQqOy+GZxZT1irii17shslq7Jvbr6DVYHA92qvRIsqj+1vLtn7lwK5IbemeBAGcafDjxv58iL3hBRwhn6O09QP5IGhmH/GUkpN+eLXmIzO+Zx+KYKmS27XEfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0MaP5PoKrY65eaPp8iat4ZoELDeWT8tW8rByDJSfjQc=;
 b=czs4snoduOeIfgYlheZW+sNGZDlbnW9bK1sBH9qIqE9PSrSmWaNy4znxXuNbmyMj+3y+4WQNa3+LtQEySegdk2OCgczNPmosN1uBZYCsS6hZumP8HQj95oX9kmuB5cL5jweFiDPIzEiPa0WiN7GsnccuFsZjrdhd/EgvbyayeozrVLPn5LPvJNve3C/VgrmvwcbWgnqlxpg+OwZ4TdIrZtRcvnv0elncF9WMN0XX10f1nVGJ9fQ0iXF3HG8JXue9c90R+YazOz7+tn3uJHUxr1BS/Fl2MIAxbjpt90czj4DXepY/DHGtNwuh1IM3IpdPLGGZby0Sr7pxBoRMM61xQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0MaP5PoKrY65eaPp8iat4ZoELDeWT8tW8rByDJSfjQc=;
 b=etunCUPBtYINEK7be9QWq9dG7Z76t19PlRof746dG+upbwqz+joielEgKFLwWqhtrLzLvJoAzxWf3uFUdH4xcD4EnZclv5VlLZemy0IlAKsizFrbI8N3EJfkGhfLQ/nDpfQyBDc3/2A2Du/uDay7q7zNABPTmSq4qSG0Gret0R3dw8/YJyjbt8kA80214jRpAh/imgX5zZLdfV39tuuV9YQ5InuVaRy6NsUQLM0QsmfaH+7U8JLhooIi9KsrHXsFx8Zw9VDxvwgfuJ/RqUD563kn41v3hJTtpumySNwFz8e5xSAsIkzl/gMXG13DEFM2vmZWFq+KQiRVWfFDV2WdKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 DM4PR12MB5183.namprd12.prod.outlook.com (2603:10b6:5:396::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.20; Fri, 23 Sep 2022 10:50:57 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b07f:53b1:426e:a29d]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b07f:53b1:426e:a29d%5]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 10:50:56 +0000
Message-ID: <b56bb804-4d1b-0db0-ff39-96728015f580@nvidia.com>
Date:   Fri, 23 Sep 2022 11:50:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 3/3] dmaengine: tegra: Add support for dma-channel-mask
Content-Language: en-US
To:     Akhil R <akhilrajeev@nvidia.com>, ldewangan@nvidia.com,
        vkoul@kernel.org, thierry.reding@gmail.com, p.zabel@pengutronix.de,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220919112559.58195-1-akhilrajeev@nvidia.com>
 <20220919112559.58195-4-akhilrajeev@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20220919112559.58195-4-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0101.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::10) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|DM4PR12MB5183:EE_
X-MS-Office365-Filtering-Correlation-Id: aafb4336-fd39-4303-6fcb-08da9d517e7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UoDeSm7HohHfFdC5dCHlQcn8amJp3GbTdxGgRVNpyZeROukErTgpN3AnrTQVTlvpyIx1HUjUgKqJbcRdK4K6m+8lSUAmHW4QBaobwwq6nAtempYC8xMtngO2fQuvwL1D2RHoNRFi/QGb96yLp5zi058+dAmcnQO/zQvJZBm2Jw4i919Ot1E5MRVURh+QWP0RHaII1DzKnsVyXC3v8XuppO4m5Eqc6m9GS11apTBMMJe0D1e5kgUClHBDjzVhTD/Lx/Ni77zhdBYochosyw/1IH6C0U7XA2QFtz2nBYoLTng/euvueXTKatfENxu0HX+5klYTMK1bbpDawPAFGNFrZVeoxbZF1Pd7dRBrBuwPX5ra6WwMS+D+L6FFhIBz7KXJRiXykkYaa6in7YTiUqOo2bB4SjXuSxDWiobo42y8j1EMFN3c1+lsZa3g/0aVga4QPkoyuOEGPWEsNwiBj7Gnqj3ldXH1IwF/yMI37UgpRFo6DOchdq7iJ0DdRHakOlXCTS34P3QTX0mDnm1YgEcG8xWICM+Te24gL3NE2X6YJZvR/6dyN5IfeG2MG+a67fRmOx0URYsurPLta7qUeHBL3D/pBYnWYesuZmUEL2iXwa/XcS7U/Uki/z60EFsjKwAkv9ibu0q8BSSXM8YaoZ3P7BGBIERe7YC1Q1o2LJf/iW6ppHr79YJqqHxzpr0zefawCJvWJ0uP3KRJWRBXD6WRFQisLRO4/PofvO+ii3cIRrNryKrwDi/HkVKbmA68BD8YBXFqm6La2qzzIkE8RyvJ18Crns434HtiWSYjMVkA+qM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(376002)(39860400002)(366004)(451199015)(38100700002)(5660300002)(478600001)(6486002)(6666004)(53546011)(8676002)(66946007)(66556008)(66476007)(83380400001)(316002)(2616005)(41300700001)(86362001)(36756003)(186003)(31686004)(6512007)(6506007)(8936002)(31696002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVc4MTc2VHVRS2tjbkZmMG1iNEk0TlYzdm5GVkRCY3NWU2VtTS93U3p6dnp3?=
 =?utf-8?B?R1hsdDNPQVpRMmlReGIzbGM0T1NWKzQxQmsrUEtiQzE4OGd6NjE2Nis1NHJM?=
 =?utf-8?B?RkRhUmdGVFR2N3lKd0hWMmxETU10TnR4UTZvQ09ZN3locURmUy9FN3FXRlZ6?=
 =?utf-8?B?L1V5VGg1UXZBYm45T1czaHNRTXlNUVoyWTNzaFJsaWUzWUJZTFg1T0o0RzM3?=
 =?utf-8?B?NXNDRUx0Y2FEZ1A1cDFHZUE5VkJCODFWV3ZTWDZ6U0VhdVRxTUhpbzhrS2po?=
 =?utf-8?B?R3F1enllRGh0MmZYODBNNVFhRlB3OWlHT1NkMnBrUFhFZE1HcGx5NTZUNEZT?=
 =?utf-8?B?RHF6QkVsQ1ErRTBxSHlSNXVwQUdTUURBM3JmTElUWDRSVlVvTjRwdXdFWXN4?=
 =?utf-8?B?NmV3VlJtRHQ3V3FtN29QUFNha1pjKzk1UncrejR6TVoyZU1kSUg5NzMreGhM?=
 =?utf-8?B?TWZmV1VBd0ZZK1ZEWnZoYjBsY3I5WlpHU3lHb2gxeHBwWTk3ZDNMaFhMUlda?=
 =?utf-8?B?bDZtK1kzL3B5MExYbDVYblR2WnhFL1Mxd2dHNjRXZUxYSzl1bTVQc3FUK3lH?=
 =?utf-8?B?dUZvWWIrNUFYcGhJcGczdkdBdjNwNTlnNVBudEZLbmlVTnlWcGcrNkNlcXFS?=
 =?utf-8?B?NnZWcmhtR2pKTEwxMDJJUzZNd2V6alNnaEVwd2RjUi9PdjNZZ0NGMVRHTmoz?=
 =?utf-8?B?RFYzUEMxR1k2blRDRDlsSE56SUtMcEUwdThsMDk0Y1JBREpFYkNOQlh3enUw?=
 =?utf-8?B?YlFLaWlzanJTcFdib2tnd0JGN1IzNjJOMkhsRHVuSVBWeW9tVjFSS0tCd05J?=
 =?utf-8?B?bVpSU3JUQSt6VThoL1JSTVl1Rklic2F4OHhYdDNRM0E3bFEySUI4ZlZObFBH?=
 =?utf-8?B?dVJnRjRJZGo5dG9CZWRTTXNCSHZsNFQ2UmQ5V0FtczRyeE1QMDFnRzJyUGI3?=
 =?utf-8?B?NDBGZWpSOGVvQlF2V3NXbWE4cUdhcXJKRHBMOUJuZWZlWTRwbXVNMVJTZUx1?=
 =?utf-8?B?VFlwSlc1c3AyVWM1RWk4Zks5UEtxdXJ4NmxSNEcwK0ppMnUxZitIUHVtTDhC?=
 =?utf-8?B?c21JT2lFdDBoYXNyWTdlU2t4MjljcVFsR1pLRGhLWWNlbnFJZ2dwZWY5ZGgz?=
 =?utf-8?B?M0lHWWhRNVZaK2Z3UmJkVCtHdFI1QXpBdkh4NTVWUXM0K3EyQkt0UkpiVUNu?=
 =?utf-8?B?VkxnRlBUOXJTL0cyWEtnQitaNmdhZzRPTmtPOEZZcHBsQ0orK3lMMzNFZVZB?=
 =?utf-8?B?UnNTekQ3bk83RWJ6TVVsVmh5VWlIUG1VWW16ZmZ5K2FDcDkwMmxLWVlweWRt?=
 =?utf-8?B?S2EySytmUG5CaGNOeERWWWNjVUtmSEFwMitFelpubkEwaHJRYzNNMTJxQTBT?=
 =?utf-8?B?WmQ5eEk5L2dKblJia0VBYldtNWs0ZGUrZEk5aUZpVnl1bW8vZHlsZ2JSM2hm?=
 =?utf-8?B?MDZ0RE80S2RHeE5BV01XdkdIL3J1N0lhQ0o1aXVHMGlodVRBaFRpR1hTRzY0?=
 =?utf-8?B?MFQ3NnNNZSsvT2g0VjB3RjNLTVpPTjc5YlZmcDFKUGMzcXlkSy9vY1M0NEtZ?=
 =?utf-8?B?MmFKQ3ZlZW52aGdtUFVyUjVpdUI0UUZLemJ3dXBUenNyRWhtd0FCTjdaVWxv?=
 =?utf-8?B?SFBvdkpBbFp3V2xXL3NRUW8zWW5Ca04zaTcwcjdaallzVEhoQlMzeGR6c2Z4?=
 =?utf-8?B?RTN0OVljMXJxOThpNUJCenFqRW1uSjNRV2pKR3YxenFWMFEvaG5qV0xjNGdC?=
 =?utf-8?B?UGhiUzVpNC83NExFeTRwbkJmempZTWRkVlRqYmRXRVA2M1VaUURFeXRaZm5D?=
 =?utf-8?B?QmEwSVRLelJScVFvYmJGbTkxWG94RGs0WUJJZ0NwN0pXWGNyR1BUbUUySitK?=
 =?utf-8?B?bnExVWFhNlNvS1Y2b243SUJ4L0Y0bmVtYU1mV2I1Zno2eVExNFpDTVlBUDds?=
 =?utf-8?B?czUyODA0LzlKNnYzaFVrRm1SSzljTGsyOUZzK2FFd3ViWjY3ODN4cGNJZTBz?=
 =?utf-8?B?bmo4MDhxVGtzL1F1RmZ3Vyt5Qlg2T3ZZTk9YNzNPMHhGK3JaMExmTG9LSHFm?=
 =?utf-8?B?Y3VnM0JXMFYzdEU1S29YckhCUHpRUVA3V1lFRFIrLzVsM0UyV3lpOGdBM1BJ?=
 =?utf-8?B?SEhSUExmajNSMWMyYmp5TFBsUnl1aytnUlpVMEJZY1gvSVo0b0RjWDYrRDFx?=
 =?utf-8?B?TE81bG45WVI5NlVUVXRpb1hLTUNJS0RZNjR3YklxclIyOXc5R0RxU3VDb3ps?=
 =?utf-8?B?djZSUmRXenlWWjlYUHpOck9oWVZ3PT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aafb4336-fd39-4303-6fcb-08da9d517e7e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 10:50:56.8661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p2xUh9YAATcJAvFRdQpZTb0jksrxajg6ooDZoBgx6DV6lIl0tP7xYBnjHXDzOqAGaMTwSsH9pzAtBB1942dAQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5183
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 19/09/2022 12:25, Akhil R wrote:
> Add support for dma-channel-mask so that only the specified channels
> are used. This helps to reserve some channels for the firmware.
> 
> This was initially achieved by limiting the channel number to 31 in
> the driver and adjusting the register address to skip channel0 which
> was reserved for a firmware. Now, with this change, the driver can
> align more to the actual hardware which has 32 channels.
> 
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> ---
>   drivers/dma/tegra186-gpc-dma.c | 37 +++++++++++++++++++++++++++-------
>   1 file changed, 30 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
> index fa9bda4a2bc6..1d1180db6d4e 100644
> --- a/drivers/dma/tegra186-gpc-dma.c
> +++ b/drivers/dma/tegra186-gpc-dma.c
> @@ -161,7 +161,10 @@
>   #define TEGRA_GPCDMA_BURST_COMPLETION_TIMEOUT	5000 /* 5 msec */
>   
>   /* Channel base address offset from GPCDMA base address */
> -#define TEGRA_GPCDMA_CHANNEL_BASE_ADD_OFFSET	0x20000
> +#define TEGRA_GPCDMA_CHANNEL_BASE_ADDR_OFFSET	0x10000
> +
> +/* Default channel mask reserving channel0 */
> +#define TEGRA_GPCDMA_DEFAULT_CHANNEL_MASK	0xfffffffe
>   
>   struct tegra_dma;
>   struct tegra_dma_channel;
> @@ -246,6 +249,7 @@ struct tegra_dma {
>   	const struct tegra_dma_chip_data *chip_data;
>   	unsigned long sid_m2d_reserved;
>   	unsigned long sid_d2m_reserved;
> +	u32 chan_mask;
>   	void __iomem *base_addr;
>   	struct device *dev;
>   	struct dma_device dma_dev;
> @@ -1288,7 +1292,7 @@ static struct dma_chan *tegra_dma_of_xlate(struct of_phandle_args *dma_spec,
>   }
>   
>   static const struct tegra_dma_chip_data tegra186_dma_chip_data = {
> -	.nr_channels = 31,
> +	.nr_channels = 32,
>   	.channel_reg_size = SZ_64K,
>   	.max_dma_count = SZ_1G,
>   	.hw_support_pause = false,
> @@ -1296,7 +1300,7 @@ static const struct tegra_dma_chip_data tegra186_dma_chip_data = {
>   };
>   
>   static const struct tegra_dma_chip_data tegra194_dma_chip_data = {
> -	.nr_channels = 31,
> +	.nr_channels = 32,
>   	.channel_reg_size = SZ_64K,
>   	.max_dma_count = SZ_1G,
>   	.hw_support_pause = true,
> @@ -1304,7 +1308,7 @@ static const struct tegra_dma_chip_data tegra194_dma_chip_data = {
>   };
>   
>   static const struct tegra_dma_chip_data tegra234_dma_chip_data = {
> -	.nr_channels = 31,
> +	.nr_channels = 32,
>   	.channel_reg_size = SZ_64K,
>   	.max_dma_count = SZ_1G,
>   	.hw_support_pause = true,
> @@ -1380,15 +1384,28 @@ static int tegra_dma_probe(struct platform_device *pdev)
>   	}
>   	stream_id = iommu_spec->ids[0] & 0xffff;
>   
> +	ret = device_property_read_u32(&pdev->dev, "dma-channel-mask",
> +				       &tdma->chan_mask);
> +	if (ret) {
> +		dev_warn(&pdev->dev,
> +			 "Missing dma-channel-mask property, using default channel mask %#x\n",
> +			 TEGRA_GPCDMA_DEFAULT_CHANNEL_MASK);
> +		tdma->chan_mask = TEGRA_GPCDMA_DEFAULT_CHANNEL_MASK;
> +	}
> +
>   	INIT_LIST_HEAD(&tdma->dma_dev.channels);
>   	for (i = 0; i < cdata->nr_channels; i++) {
>   		struct tegra_dma_channel *tdc = &tdma->channels[i];
>   
> +		/* Check for channel mask */
> +		if (!(tdma->chan_mask & BIT(i)))
> +			continue;
> +
>   		tdc->irq = platform_get_irq(pdev, i);
>   		if (tdc->irq < 0)
>   			return tdc->irq;
>   
> -		tdc->chan_base_offset = TEGRA_GPCDMA_CHANNEL_BASE_ADD_OFFSET +
> +		tdc->chan_base_offset = TEGRA_GPCDMA_CHANNEL_BASE_ADDR_OFFSET +
>   					i * cdata->channel_reg_size;
>   		snprintf(tdc->name, sizeof(tdc->name), "gpcdma.%d", i);
>   		tdc->tdma = tdma;
> @@ -1449,8 +1466,8 @@ static int tegra_dma_probe(struct platform_device *pdev)
>   		return ret;
>   	}
>   
> -	dev_info(&pdev->dev, "GPC DMA driver register %d channels\n",
> -		 cdata->nr_channels);
> +	dev_info(&pdev->dev, "GPC DMA driver register %lu channels\n",
> +		 hweight_long(tdma->chan_mask));
>   
>   	return 0;
>   }
> @@ -1473,6 +1490,9 @@ static int __maybe_unused tegra_dma_pm_suspend(struct device *dev)
>   	for (i = 0; i < tdma->chip_data->nr_channels; i++) {
>   		struct tegra_dma_channel *tdc = &tdma->channels[i];
>   
> +		if (!(tdma->chan_mask & BIT(i)))
> +			continue;
> +
>   		if (tdc->dma_desc) {
>   			dev_err(tdma->dev, "channel %u busy\n", i);
>   			return -EBUSY;
> @@ -1492,6 +1512,9 @@ static int __maybe_unused tegra_dma_pm_resume(struct device *dev)
>   	for (i = 0; i < tdma->chip_data->nr_channels; i++) {
>   		struct tegra_dma_channel *tdc = &tdma->channels[i];
>   
> +		if (!(tdma->chan_mask & BIT(i)))
> +			continue;
> +
>   		tegra_dma_program_sid(tdc, tdc->stream_id);
>   	}
>   


Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
Jon

-- 
nvpublic
