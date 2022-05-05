Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F89051BBC1
	for <lists+dmaengine@lfdr.de>; Thu,  5 May 2022 11:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352339AbiEEJWI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 5 May 2022 05:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbiEEJWH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 5 May 2022 05:22:07 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0476F4D9FD;
        Thu,  5 May 2022 02:18:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JIjwFAs7SW43qBKqEozZAKKympDued21AwfBd2QYfLmLMWoal5ZxCvZ+6D5e590lcxiEbJKsRrm0KX5v3ZRPzfq5JZDmiaTfk3Hh8qq3OnAi/SEf2wOepVxb04fHZNAht02HiISr4dvwKLJ3sG50lZg4s7m/8TBJv7oA5DNN42X87ytOjvyscZVYhDadWetseKod8rL+tFbPsQLVcGE7bFus/o1o56Cyyr8pebjC6bASkw7L/xdsI84APT+naDrE5SAyFEfxWsgpdtSiU082IEm7UX5MAQmqFqMgdO+ioI/1rRjzos4QJP2X3fw8C7xj1Vmm2stfk3o5zHKmnaaE0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6GSpSnEAMsxJSYDW6H9NTXvJ7nLBanF8JevWH9MAEBQ=;
 b=ZPiQENDRequ8hBIyQy3AmqqSkZeYcTcqglglUBLlkNv6n5ZAMs2wckmAtbNMORI0UNX1qiQJxi13S7AokySBnNwZSNL9+Z2JNqyEezCzhdHpBxCvnOysjcmgvF+c/P9EORfrFdpMMvib3yWS617pJ/aPC3ZuBxurG+YQbbXAtV6ITHw+tIzf0hjumHCSeeVXn8vPpsV1FrMuDuGvkxb87yKdi5xM5BHaipP8ZccyGhRtjiTVboD0ltotjpJNEv3UBwbQy7noO/Dj2cSb04vdUh+K6/tIpoyr1gFXCSTCVUfIVJn80tijXGt56t5c8f+ILX2VtLF/cJ4tboB1LV8ImA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GSpSnEAMsxJSYDW6H9NTXvJ7nLBanF8JevWH9MAEBQ=;
 b=M1fw4i6aOxEIXeEEnB75GaMSQpBZDTjdpUDDxJ9JE79aGsuaTouvoLoBMMbXkc6K3O0qZb5rk0lCJcKtAdeOEci5xgGlRYuJ48UAgDvxWdjSNFZydZSFHzVhrttyQwXP/lG2sjdq1KOIxW5b+YfrC+I7EVwQk2g7W2EbmT7nFtaEdZ0TpGAUqMIx4hAOPXMNgBEZH/lYjuSUjKFxO2W14h7x7WTiOJJjlTGdJxfkBkxxtlA3VfDTm+8DowoAxsHunnnYP9sJDzRDGOPiMNnQ/ZNa6HmOAvxRUeA6nv6cpK6l1zVgdfWygsxoUqnbl6ow8xiUtz0ba3zbN67sj8aGvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 MN2PR12MB4191.namprd12.prod.outlook.com (2603:10b6:208:1d3::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.13; Thu, 5 May 2022 09:18:26 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::a4b2:cd18:51b1:57e0]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::a4b2:cd18:51b1:57e0%5]) with mapi id 15.20.5206.025; Thu, 5 May 2022
 09:18:26 +0000
Message-ID: <7673dbb7-6a85-6ab6-f1a4-a6f4724c0b90@nvidia.com>
Date:   Thu, 5 May 2022 10:18:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] dmaengine: tegra: Use platform_get_irq() to get IRQ
 resource
Content-Language: en-US
To:     Akhil R <akhilrajeev@nvidia.com>, dmaengine@vger.kernel.org,
        ldewangan@nvidia.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, p.zabel@pengutronix.de,
        thierry.reding@gmail.com, vkoul@kernel.org
References: <20220505091440.12981-1-akhilrajeev@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20220505091440.12981-1-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0236.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::32) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5710b4a9-1dff-4bf8-6b23-08da2e7835b8
X-MS-TrafficTypeDiagnostic: MN2PR12MB4191:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4191E944EB8A10F68D358FCCD9C29@MN2PR12MB4191.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6igkbylM8C/YzxKiSZ37JAUIt9chz28l7tM6YnlsrTpePJOdRLV1Cv1YldP1SpDpyu7DmHvZoXbT3BbNVu8rF9LVoNYG+U4qei/j43EZSm2f9Sz8seBNSsKzNKzq70PAhbLxC86JL42JYkrn/rZKjOBxZxfJ54S4aRiObLfQMUTOtflDVTBhHx7sZTzhEEN8/5h3Y3tq6cWAD+uy1V9zMHkrW26Y8A6SkvbP/PGaeGvDztSKlqzWLhLDIjwLDyr0tLr6px3fKh3I1u6/8txYcjQV/TnfmnItqVbCquutdUvNQBC0ONmUH5AjXs/cnRWhT5vWYuTeuzrFjKjft16F7CeEZaA3qWtU2E+4yz7WgaWIPwyMqeHLOTLenn1dVFlAaubObNPCJkt/GZga9KzuKvhhuGHkWTPa+OayaRgmqkN4U0fx7fjt5nTfcWn91VTh1010bbo2/78GeIFeVIDsjApEca+crc4OD8lavdKZciYAB2wE9Yg/ssP5iWjgWrSzqOTsXFzUoJO4nCs5nil71ayDi29lbxIFHl1d6GFEaguIxxlSRmQglmOA9fc3Mt514YgGp00A84sut5ZAuW4hp3JwkjznsYHKXHDUrexC9k3NIA3kXETgjl78OxoFM7tuSg3AAxDxBCOKVl/MnKfVfKc0jdechpMfeIwI9rXXD0gN8flVhq9tAKIwFowQSaMWwMWagx8Gbldqx/Zo9TzSVlkBxST8xBfcM9zBLZI9VaY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(186003)(83380400001)(31696002)(6486002)(508600001)(6512007)(6666004)(26005)(53546011)(2906002)(31686004)(38100700002)(8676002)(6506007)(55236004)(66476007)(66556008)(66946007)(36756003)(8936002)(316002)(5660300002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFBDeEt1M29nMVBoUWJoYnRpbHZWNkM2b2xtSTJ3V0ZTZ0RpK1RHeCtNTUow?=
 =?utf-8?B?bzE5ZmwzV3pTVVU1Y0lXV1cwVzRFT2ZiZzR2UFl5RDNjTHNvdWhzTU91a1ZG?=
 =?utf-8?B?dmFleEFidUd6SlN1Kzl3N2JXWktaamhsVFlrZmRKYmNKUFltdjlqT3cxYXRr?=
 =?utf-8?B?aDZuNEJCL1prTWJzRU80cGYrcXRzeDRpem9JNkxYT1ZOSUpmbFY3aDRKOWdk?=
 =?utf-8?B?Zk5HUGtuNFd2K2cwanIwd2J1ZFF3VHBxTmpXanVWUEZqTDZpakdMODJxekJ2?=
 =?utf-8?B?NEhUVkJ4NHdKNjVoenJWdXdLaEpFMGVmYmwxZDN2ZkFkaUpoRng0QzE3cTE0?=
 =?utf-8?B?cmx0ejdnMlJtd3o3OGlqZFdnalp2c3R4dW1VaVJEdGVhdTZSeWJrSmRNVUR0?=
 =?utf-8?B?TzhranowNGVvSmo0amhGYWhWeDh5Yit0SWhQVlRIbmFwclhOMTM1ZkFHZmdt?=
 =?utf-8?B?aER3aFBidWQvMEo3a1l6L29ZMCt2NDdtdysxUHVESC9MbUNvUU5Qd2VuMU96?=
 =?utf-8?B?WTk2MGh5Mkg0Y0llM3pEdmhMTTBpYXA0Ry9jcEw4M3JNS1JXSDR5YU9HT21z?=
 =?utf-8?B?QTA1YStsSU5ZczY4dDEvMHN3V1hmRk9sVjBBa09LN1dVVytVZnNseFJlNnc0?=
 =?utf-8?B?Yjh6cUEyVGdGN3dNQjc1a2w5SU1ZRXhlb2lYcFYyb1JEeThKR3IrR3Nqc3hn?=
 =?utf-8?B?QUowVGFHTnhOMERiaVlWRjZsTDNUd0V0Ym9TWEY5NDdEYkV0eFYyMVhjay9l?=
 =?utf-8?B?U200cXBvRFFVU1R6d2xwSTY1L3ZnM3VKZHhKb2RteGVLR28zNmVOV3RUeHRt?=
 =?utf-8?B?S0tucmk4aUxMWlhhODllVGtiSG5ZcFJDa1YwQXNFUjFTai9MVE9GR2pyQnlI?=
 =?utf-8?B?SUFlbXVyYWRueG9sUjRVUmcvd2tETjdYUXlXamVOS0ZsWWFsUTZ4V3JlNGgr?=
 =?utf-8?B?b3Z5bk1sVCs3VDUvL0dkVjBaSmdtMVJ1dG4zenBjbnVLdm9DOWczSFR0U3A3?=
 =?utf-8?B?a2o0UUNxUys0a00xWWQ4eU0vbC9tVDVZWGo3bXdUS3lBNnBCYWtnZktLMlZ3?=
 =?utf-8?B?ZmFrRXc3NDlkKzcwVmNiRUpzTEkzOHRKOHNncTNxeG5KRkhmOE9tdXprSjF0?=
 =?utf-8?B?cVdXdk5QUUI0NXZReDN4dXc2Z2dtclc3V092MFdOZmgrVGRaWjdETk54V2F4?=
 =?utf-8?B?SXl0MEZ2QkxjUjcwRnhEWFRjYUJTZWFLOWd4RGRPYzVHKzcxYk1KdlI1Wk1O?=
 =?utf-8?B?QndyWEhCak5wR1djSkx5QzV2ZWRuRFMyUmhyQ0huSjZOaHB2ZHpZZDMxQ2Fl?=
 =?utf-8?B?S0tkc0lDZXdnTDdMbHdnNnRoa1crZUZJWXdlejJnSFVHWjc5a0dsRGczZUlU?=
 =?utf-8?B?U2RGNE5tMnJIdER5R1N4Y3Z5SVdMQWFwSG5QQWpYUkZaeEpUMllHMkNmT0Q2?=
 =?utf-8?B?NExiY25SaVBtMUVvalo0VHV2QW4xYTZ4dFZpQWl5UElndVZza3pKbms1cjls?=
 =?utf-8?B?MWovUzlCT2ovQXFWV2NKRUFZUHhOdVdZZVQxTm5zZHZGdzZjSDJRZGdiREE0?=
 =?utf-8?B?alBpWGVialBrUllWMFhRcFZGaUk2RkVESXdyKzF0SDRPTWxVZVhMRlpEWkEr?=
 =?utf-8?B?SXBneUtoNEpaYVZxMVZ1NThVcFNzOHhHamRTMUdBNHVpY2MvbGZLeENpVzF6?=
 =?utf-8?B?K0lSUDMvYllPeGUxRWt4RUlZK01uVkZ2bzJ1WXFtZHRJYURNTnM5eFBVRzNk?=
 =?utf-8?B?N2w1cEN5NmxxOXhrWEJiZ21hQXhSRGVUWFdXc0ZUakx1QUtNV1VOWFE2SVZW?=
 =?utf-8?B?ei9VN1FId2ExV0dhelRaR1o0SXhyWTFsVlM3Q2s4Q1EybmJvcFNzcCsybUwy?=
 =?utf-8?B?ajhQK0xCdXI1SXNJbVptU2ZwaHQxeGNiaDhoZmtoNVJYRFM5eHFHRzNEcVR5?=
 =?utf-8?B?WVJ1eHNLcVFKbE1CVTV0VXR2aDZJVjZJaVd5MCtsNlduOUZ0S1gvemFNMnBp?=
 =?utf-8?B?MnNjSXpSZkh0MXJFczZKM2xmNWhwRFNxQWwzTDlUMlNsaUJQNU1rQnFuQURw?=
 =?utf-8?B?YVdPNUhsYm90S1I4U0t4RmZKbGJCSG9lRlIyb3U2b2FmV2h6YW9CZ1MyM0ND?=
 =?utf-8?B?MHpSem9VeGhRc0xPMUIvRFFlQ24wRVlDS3JYS3F6YkE0RmpjT2hhekt6MnBH?=
 =?utf-8?B?azVIQkdDUlZRUGg2bndVK1NlcWpNOFBtbXB3UVljd0FSak5ST3Jjc2lDSDFE?=
 =?utf-8?B?aGxteHdLY1RVT3hxdWdMT3I0T2pwQ05BdDh4ME5NUHBDN0hmZFZ1RUMxMnVH?=
 =?utf-8?B?Wk13cFdoL2crS21XYUhCNHhiem9aY2dWNTZpMUZLLzJFV1lVRzBBUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5710b4a9-1dff-4bf8-6b23-08da2e7835b8
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 09:18:26.1858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NCtsg1wWnDK3Akq0p+BJLpcsnw6Rm0ff0U5xdyCoFfFcMXYR3mdgrZx23CuOmVjzRuvxpRwLdkQuaHRsaKeQKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4191
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SORTED_RECIPS,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 05/05/2022 10:14, Akhil R wrote:
> Use platform_irq_get() instead platform_get_resource() for IRQ resource
> to fix the probe failure. platform_get_resource() fails to fetch the IRQ
> resource as it might not be ready at that time.
> 
> platform_irq_get() is also the recommended way to get interrupt as it
> directly gives the IRQ number and no conversion from resource is
> required.
> 
> Fixes: ee17028009d4 ("dmaengine: tegra: Add tegra gpcdma driver")
> Reported-by: Jonathan Hunter <jonathanh@nvidia.com>
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> ---
>   drivers/dma/tegra186-gpc-dma.c | 12 ++++--------
>   1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
> index 97fe0e9e9b83..3951db527dec 100644
> --- a/drivers/dma/tegra186-gpc-dma.c
> +++ b/drivers/dma/tegra186-gpc-dma.c
> @@ -1328,7 +1328,6 @@ static int tegra_dma_probe(struct platform_device *pdev)
>   	struct iommu_fwspec *iommu_spec;
>   	unsigned int stream_id, i;
>   	struct tegra_dma *tdma;
> -	struct resource	*res;
>   	int ret;
>   
>   	cdata = of_device_get_match_data(&pdev->dev);
> @@ -1367,16 +1366,13 @@ static int tegra_dma_probe(struct platform_device *pdev)
>   	for (i = 0; i < cdata->nr_channels; i++) {
>   		struct tegra_dma_channel *tdc = &tdma->channels[i];
>   
> +		tdc->irq = platform_get_irq(pdev, i);
> +		if (tdc->irq < 0)
> +			return tdc->irq;
> +
>   		tdc->chan_base_offset = TEGRA_GPCDMA_CHANNEL_BASE_ADD_OFFSET +
>   					i * cdata->channel_reg_size;
> -		res = platform_get_resource(pdev, IORESOURCE_IRQ, i);
> -		if (!res) {
> -			dev_err(&pdev->dev, "No irq resource for chan %d\n", i);
> -			return -EINVAL;
> -		}
> -		tdc->irq = res->start;
>   		snprintf(tdc->name, sizeof(tdc->name), "gpcdma.%d", i);
> -
>   		tdc->tdma = tdma;
>   		tdc->id = i;
>   		tdc->slave_id = -1;


Thanks!

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Jon

-- 
nvpublic
