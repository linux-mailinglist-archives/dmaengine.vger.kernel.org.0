Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B4B5E79E3
	for <lists+dmaengine@lfdr.de>; Fri, 23 Sep 2022 13:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbiIWLph (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 23 Sep 2022 07:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbiIWLpg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 23 Sep 2022 07:45:36 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on20614.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::614])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDC5DED62;
        Fri, 23 Sep 2022 04:45:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NuhR6fTF/7GVkLqydhQUBTrhmBskrzlv7IZzfSCp5j8cX8wmXcTfGn9/F72XBMKyvYZSebTUZU1BmIVd58I8X//Rei0ptE/n4lvLT7EuslH8xMKUmLIv24+QcgWAo9hsivxlL5idGMbESpcNMQFhKz2CeIm9EZl+4+97Ilpp2JRfP/M2MAqUWPOr9Ffv8Fdqgv5JTK3IpD0opDYzG1+3V77qYrDk8ki2dEzQKPZbERYFFSHpSmAFW8nfDyzlNcVUdPm/4HGYViB4OqtybYuix7HlkYLjb3WCZq2tHBr8ybn56bbe6Kc08WHxvNY2jCn+1M+YYXk7r27jOSxU/g07nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hoZtU3PqsuOhyogdC8b2iPRmiTid4cWDez6G3i2gSPc=;
 b=gLnmgz96yoxYuv1DQLSJRAuYWXndSGZh8OcHpsFMU3n0Gvz00DbnuMvAIDeUv96+mB3FrnYD04u5qG062ZogVnrPu6cFmC1GDD0G9zmk0fmda+odxtoL2YubA9hKijP0VrZsu2+N0ku5XX749TY+0NUAzhX9/i932rXZecEg01+ZC7RxXqmvx1vWjZ1MbQtgDvMshabGLOh/ezglIlfTyTt7j2zQBdIi11YHcYTVPssDTIYx45VEyUH+DiFcBWMnZmHzlPK4snxVFNL656QmKHelrxLIDia9tnwnOBsGlbyT+nKVjAakrAQXFecbt3k4uOmosg6UUj2QAAZ27CSkIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hoZtU3PqsuOhyogdC8b2iPRmiTid4cWDez6G3i2gSPc=;
 b=kFRlx3tBjd9r0LEmQ1507wNZTKp6/FxVz6fCjua9ncckIxHhpXragcHVO4+gm3HPDcMpOL+xGaop4xWWf8EMHtCvwRIZFD+FeFhNpPLyrtXXNP15tHekIUEvD0WIuAuorMxWo3A7niiPJktm+YXpSj7NpWwK4XIoL/8BJXYQFAWqJVp8McVAABnegc2DsL5vdC8nqRtLIefOx5lHKuBxXc/oeYgli1CqVS8Qm9LZxrK6LBipU7t+2UmX2hCMJU1VheXn2AV91HB3k0HrC1mKo25c94ggdeR/8kA0V/DyXXKPQID8WSxXMhArXA8vB4wQJFfvLK4JECL0RwaBgsKSew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 MN0PR12MB5786.namprd12.prod.outlook.com (2603:10b6:208:375::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Fri, 23 Sep
 2022 11:45:33 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b07f:53b1:426e:a29d]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b07f:53b1:426e:a29d%5]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 11:45:32 +0000
Message-ID: <d289e057-9709-1b4d-f64f-c3ed627cd0f7@nvidia.com>
Date:   Fri, 23 Sep 2022 12:45:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 3/3] dmaengine: tegra: Add support for dma-channel-mask
Content-Language: en-US
To:     Akhil R <akhilrajeev@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220919112559.58195-1-akhilrajeev@nvidia.com>
 <20220919112559.58195-4-akhilrajeev@nvidia.com>
 <8d15c575-a490-e1ed-7e97-5a5cdea0925f@nvidia.com>
 <SJ1PR12MB633958099C6DDAA4A428ECBEC0519@SJ1PR12MB6339.namprd12.prod.outlook.com>
 <d2b4a1f5-200f-2560-c249-709e4e2817b1@nvidia.com>
 <SJ1PR12MB6339660F292E63B2E0CDD85FC0519@SJ1PR12MB6339.namprd12.prod.outlook.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <SJ1PR12MB6339660F292E63B2E0CDD85FC0519@SJ1PR12MB6339.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0232.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::21) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|MN0PR12MB5786:EE_
X-MS-Office365-Filtering-Correlation-Id: 59de3676-4b34-4e87-ae92-08da9d591f0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TVGYpYIf1yg6clyWYg0Fc5nkH1x9Z1yvW1CXiHm9h7auwPHUEQOeQCgMrsGl6MU/4R88rTJP97a1+inAQIOY/07uBvpCsHr5Wh880HcNgR4Jt0ZP/I/aRmx0TXPfjFODK4BtPapWWZ3dRr2i3cM0Xxlga7ev+t/QUKA0P13vmrmrr3b4iZMOY4Z9XO3evAgzLPPnAjTYoydYGFDp6RQ0QNs3wOV2KntEDY4iJrya8Xt2iUnAQYQrMaqyg45nEOU1sUD0ypwu0mW47ZxghMx3gDAuvzxSNG3qnAaZWv1yy3fsqKhmyqjDfLd2neIlWFndslGIBoADZNk6mv+/WjFt0mVfeNCwVlkwsRtantFR/SfxsGW05mBborAnlZpYlbjNBMTv1Du3krFJycR/y9JFUexBy+wEsPsjDMPDuuMQpkwuZ63qnXF5xucOKx/G7ff7fbdqn9jKcMbWisW2tcLyo6rtKSm1cA1NbH/c8/YXeZbypkm2wScnWs3vz6/3vNO6ExmTWHfeku77Hmtr4nNk0bHjcsk4M6DIdR0pFSBG0pzTgppVPopxpZFCzGa/z1dvgsLg8MP149OFxvO9BKUVCH0ZX/ByJq7brFZ0wbItcwj3dk5rDtkJFA7BEOYvvFA3qr54bq6OwZXWg/ReTrMVovq850s81rg5Mw08csLhW13RQJuVSFAvuJL2/yms6drXFEo9nH2zjRCz6Yqc2m/RMTuI+cKGb14ZT3rhEORwDn2O+fk1Erx/grONZxkfjqxPh6xRacedowX0ZckscQFmh6apwEpVNv52byma3QIJWM8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(366004)(136003)(396003)(451199015)(6486002)(4744005)(8936002)(2906002)(31686004)(41300700001)(6666004)(2616005)(6512007)(38100700002)(66476007)(110136005)(53546011)(8676002)(66946007)(66556008)(316002)(86362001)(31696002)(6506007)(5660300002)(186003)(478600001)(36756003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekdkSm1hdnM5bDVKOW91dHV0RXZxcCtONTRweTdJSzZZVGhyT2wvZWVEZjQw?=
 =?utf-8?B?c0dRalU2cU5tZkFlS2VxTmZCZFlQWTlPN0I3UWkzZ2tacm5ESTRyR3NVOTFn?=
 =?utf-8?B?K0h5K2x2SldSVU5xMWl4US9WYS9Yak9xMTFQRkpGa1E5bkE1dHJxK250QW0x?=
 =?utf-8?B?cEVrc3V1REFiQlROTDQ0MFYyaHdhY2t2VkdyY2JMeWI0WUloQjN0aGM4V0pE?=
 =?utf-8?B?MEp1OHI1dm5jSnpQZ2FtUUtiVjNHc1dBTHhpR1pPWW1lSzhhcXQ2NU9KOTlm?=
 =?utf-8?B?QWdWUEVtbnIwM1hWZGMxSkh2cXkxL29NNFpjVjBkM3ZWME1iaFVDaFk1alJz?=
 =?utf-8?B?MTN1K3JlK1NWQXI5bFdQMCtHb3FpM29zbGpTSDVtRDhUemF4ckxsREpFRWxF?=
 =?utf-8?B?amRnajZDVGs4YjNLKzVGNDVNZ0NiVnlvT0Mxa0JFNERYcHNjOE1ybGl4Ulhq?=
 =?utf-8?B?aE9KVkhJTS8zMkhhODZBbnRQdFN5RjNmOTdiTVRneEs2eTBBUHUxbWJlaU14?=
 =?utf-8?B?SWx4ZExJeDgvQ2FGNFU0NVU0ZXdpN0VBUU1SWU9QSXpoVXh5YWg0dDJCbnZQ?=
 =?utf-8?B?cFZOeEU5OFVVY1NMUXNNTlpDMm9UL3B4OWRCNmFoNlhML1hFdUd6QzU3eU42?=
 =?utf-8?B?NkZSbkU3eWl2RjV5YVhOaFo2TXlYc2FOZmRlWHlMYWM0VktLVm1vMVRmMXpm?=
 =?utf-8?B?c2hMT1pZQnpQWFJrNFV5Q3I0MDhvRnVBVytxTHJLWkp4eUErM0J2NHM4STBv?=
 =?utf-8?B?aGRLRW9CUnJsQmMzU2dzSWl2VEgzMDFwZTNCSjlIbkpsN0tHbURlZllsWER2?=
 =?utf-8?B?QVN5cWErWE9saU9XTmpKdjRpd3V2cXJxVE5Tajl5K1MybmxJaFhkSis0RFlv?=
 =?utf-8?B?R2Rhd3FTNTRnOUIxUkxNMGg5S1AyVjRLN3lqbkhRVTdWWVZQeXloTTVwcTRW?=
 =?utf-8?B?MW52WWduT2V2cE5YaFhoR0gzWmJyVExBYVExY3RJak5BVUJtMlBKTUtEMElM?=
 =?utf-8?B?M3JpcmNtcGl3V0xpVXFTRTN4RGk0TTVzUHdvWm9IeUo1dVB2TVFaV2M4TVZW?=
 =?utf-8?B?U2tSZHpjUklXb3NRRGZ6WElHMVNKZmwrNW5OR0FiSWd3UERzOStTZEhwWDA1?=
 =?utf-8?B?bS80c0sxdzBITkNheGVFMjgxcmFpQm9sdDhXeHVTVTh5bFVibjRYSTBEVGxo?=
 =?utf-8?B?bndhZ3E2ZjNNWmQyMC8rNThVQ0pOeU56TU9zYVBXdnQ3QUdCLzgzdTlHaVhl?=
 =?utf-8?B?ZlEyTTVHQVF0USs3WkFDakFyR0RsZmNQUnJtZHVDUlh1a213U1ppS3JkcVZ6?=
 =?utf-8?B?N2R5WDBpbWZzdVRpYjJGUERCbU1tNDloNkxSOGhEZHRvSjNzTmk1YW4zak5T?=
 =?utf-8?B?SHIwMmhVVDkzUTl4WE5VNndMZU5pQTFnWFB4ZlFXdS91cC9Md2ZubG5zVmo0?=
 =?utf-8?B?NlMrS1VyZ3QxVzRzdGpJTjhKLzdtcWxUUncrMVpuQ2NsRUpKNWVTY01KVnhF?=
 =?utf-8?B?MzQyYkxaSU93cW9XT2hkLzFwY0NzQndzbk5UMnhpRVkwbEc2SUN6MFkvYUkr?=
 =?utf-8?B?YzFMOVJxRmhZWkora25XZWY1cU5Wa0JaNTQ5QU9BZ05SZGtOaEF6Q0dVbnRV?=
 =?utf-8?B?QzVWTVYwNDdPZUE0Yk1sUGl4UktPWHN6YXJVbFhRYWhMZVdoVG8xK1dRa2h6?=
 =?utf-8?B?Z2I0VVhEL1F1VGhyWTV0RVk2aVRtMWNVOUdWZW5iU0FoL1RxMGFYT3NaeEZM?=
 =?utf-8?B?R2lGN0R3R1FKQy85d0hPOEZ2MnpadnNjemptZkpZbHNFZGZvR0hhTkdBRGZV?=
 =?utf-8?B?dXJuc0ZmcVprQ1pSNWo1L21EZ25mZys4R2ZVS3RkVlg4a25DZUx4WUdlaWpV?=
 =?utf-8?B?aktQVU54a1VMWS82S0MzYzVDWnZHMHlXUmdReUJBN2lJWElHUXhLbHZpSDk2?=
 =?utf-8?B?SGZKVVI5QnBoZkJDYlBkNEpVNUQvWXh4U01FMklMalExUUJpd3EzQTUzbzdn?=
 =?utf-8?B?RHNEbjk5N0locGM4TDJSb0hTYkJCZzhuWGV2clR3SCtVSDNGamFpNFBPQXhh?=
 =?utf-8?B?UFBTczcrbmptMmQyQ09GbnNkWDhSSXpWNmxaYitRN2Jub0JoaFljOUUrWXVX?=
 =?utf-8?B?UHlpTG1Qd0ZLWHRtaTYyNXc0dm5QU1FtQ3dkYmYvTkpWZk55WFB6UENiUVBF?=
 =?utf-8?B?YTA5b25iYkZmalcxM1k4d2dtTWRQVkhYSGpid2syTTM5NlhwaXljZTRTOFFW?=
 =?utf-8?B?cCtCelVDWUJHN2V6OC9pTjZkTzlnPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59de3676-4b34-4e87-ae92-08da9d591f0c
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 11:45:32.8058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QM/V3P6BYKiIU/UnafUhr71reqdjUZEhm09JBF01VQuPKGOG22Mp7vrNS29xsSthzMRzo8IeZ44BubNd5vY3rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5786
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 23/09/2022 12:09, Akhil R wrote:

...

>> Ah OK. I was wondering how this worked with 'channel_reg_size' but
>> looking closer I see channel_reg_size is always SZ_64K. I wonder why we
>> even bother having this parameter and don't use SZ_64K directly?
> There is an offset from the base address which the per channel registers start.
> Although this offset value happens to match with the channel_reg_size, this is
> not actually the per channel register size.

Yes I see that, but I mean why do we even bother having this 
channel_reg_size parameter? Does not look like we need this (currently). 
All we need is ...

  tdc->chan_base_offset = TEGRA_GPCDMA_CHANNEL_BASE_ADDR_OFFSET +
                          (i * SZ_64K);

Jon

-- 
nvpublic
