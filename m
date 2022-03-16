Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD894DACA5
	for <lists+dmaengine@lfdr.de>; Wed, 16 Mar 2022 09:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354597AbiCPIlS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 16 Mar 2022 04:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354590AbiCPIlP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 16 Mar 2022 04:41:15 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEF364BEB;
        Wed, 16 Mar 2022 01:40:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1Q72gHW4895xo5TTJAa2Zj+WA1V4TgsyITRIjV8TNnZF+4aM2wmJxWdV3EqE9j3u41oKj3XN2mraPU8r4EpME2XHmQwzM3efWsHgps/r0XkO5dQ93QYtZppDZd6SU9IQAL+v4vcvzjZ1puwF62tRC+/0OTFCkBLsPFj+bQtecrvOYyJmcP1nKyFRh3xR7gbdIyRZOV/k8nHt/7i/J1MFnDwoxIOZHl8J6Gw+YtD5oc6wskCTlWkYoUDPnwIiLh5l7Q4i1Mm158AXF9/qRkE4OwkAP0EurDM6NEWV2J7E23LYAK8nLKBM72Wdox7mHGq0jkKC7+5WaOeq9fyrP1CQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mL8C9D9hSY4FVzJH1yDIyNx6XY+Gdi06fFseMNumVz4=;
 b=i3dDFfc8fP/cxqrEs3wUM/mbJHlF/kveqP00mG2K8KHARBAsImoYF2j+mCN62VJ8AM6Nky1AhKhc8bdc48StRjL+J4cRIl3ltwgCl7oU/Edz3TVSgnnSOejTNMt9+HuS7VqTmHbHXTIFWOxUip1b06PCVKTO11qtR8tBqgXK/Ts23OlfC0B2DAlV6o8wykhdBdED1BpmnzzaLldRnwdJVWe+wGAlwzU0UXXXofap61SgE9UTnrHh9IgdZEz56hRmdJ0prtdhP4q/SjdPY3Us7ue+5ChzYvaXjMFPVgg9QcpAFTMqQGc/QMcQWlM7oheisbQYiexVARSf+3VDjI7ehQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mL8C9D9hSY4FVzJH1yDIyNx6XY+Gdi06fFseMNumVz4=;
 b=Y63YXyJmibZnuzJasCBjP6ic52Cw2wGNrtwsQt93qRsJE2sP4kDAWgkbyy1XgjTahT2/VQTkHNWFHYDEurBl77Cfr8MJ9CTWfKSJVd1IPMuicfo39mlsz6HlKv7V909T13ztaduyLADouyHpV/P/mR9sazayrRa4sZBMH6oBB+yXIWy5s3K9m1z70Ka/vrX2cr0aFDDFUtf/tXyvtbHhT6d4LLV6pgiWPjAsTU9gXAwzMNKQmfw1Y/Lgpa9Lnp+lEXo8wcsFPXpgLPVcMztRFO9GaECaZk1W8pPsbbMYpzRUhZ5ElbM4YetVkckvYau3lk3j1M/qGqXqJA1GZ50cEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 BYAPR12MB3608.namprd12.prod.outlook.com (2603:10b6:a03:de::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5061.26; Wed, 16 Mar 2022 08:39:58 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::88c:baca:7f34:fba7]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::88c:baca:7f34:fba7%5]) with mapi id 15.20.5061.029; Wed, 16 Mar 2022
 08:39:58 +0000
Message-ID: <723e6f66-b3f0-2ebf-f2e6-30b7fb8c7437@nvidia.com>
Date:   Wed, 16 Mar 2022 08:39:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v22 2/2] dmaengine: tegra: Add tegra gpcdma driver
Content-Language: en-US
To:     Akhil R <akhilrajeev@nvidia.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        Rajesh Gumasta <rgumasta@nvidia.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>
References: <20220225132044.14478-1-akhilrajeev@nvidia.com>
 <20220225132044.14478-3-akhilrajeev@nvidia.com>
 <DM5PR12MB1850D8FF27CCC948A2259FDFC00A9@DM5PR12MB1850.namprd12.prod.outlook.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <DM5PR12MB1850D8FF27CCC948A2259FDFC00A9@DM5PR12MB1850.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0032.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::20)
 To CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f1496d2-9a43-486f-50b1-08da07288d95
X-MS-TrafficTypeDiagnostic: BYAPR12MB3608:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3608F376814CF22B2A822347D9119@BYAPR12MB3608.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2umVBtCdFJG+ONSqz2TVcmKKWR6HkEnRGn1rF/P3J8uRSdPufFpYy6mSQZBJh0POq7hBgTgvRKa/+Op5an5+TLviwf/uyiFbEKpEBfbDcaN3JG23T/OPdxQwbynsOkptzkZ64eKpXkiZp0zigwFsZKj8BfiIHo2lX6WtQgn9KLnUlM+M5BU7r154mJoI3lfCyLJX+DmCS2Ej5aseb9ewnTZEi6ruUOBRTTcptEcrNSJWeAuM9holQP+w6VMUkAPNF1NB8HdWXtYPjIj1kppXstUrBjHxWDqseumMEHsbCpSqG2jSAwDfSC2WAtWdXo0HZ4kVSV7QCCrz0sYPcLH50CTMfa72ND/44bz7V33yngs1ZvA5NntbD+1ldsK6ea57gYOkGJuxj5asPB/eyHOeO/t4qtxh43D8RBJ8u5zsJIdZx6wxNqmejpfn4WwYhBgdoptupuhNSrQZMKDLP6+jL3Kp0t8GWJrRw6XjE6kUkN1Ch7u3g3dsYAqgqw5hCJbwF9Z/9jsETNTr6vVS2R+spaJIIz1DQnM9eQsAMxZso6YnsgyzUimuko4Wre8kDRCVjaryhzPnzHZ/kgDJJL6fCDwMRUg1zmAxA9lxEBxoYqoDOYUU0+BoqgeAmGpDg2dhE5ED1TbjWwddXSNilWmIbxpaCZcTb4BhlBHJzjsKfRtl68iqySiGtnA8p+Q6uPPXZ7KMHHJ4Y1qQRtXCO/fZMeKS+oyLBCFMCZWAxrH2swNetwR3tLBodaEXi6D7bAKv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(38100700002)(6666004)(508600001)(921005)(86362001)(66556008)(66476007)(31696002)(66946007)(8676002)(316002)(26005)(186003)(110136005)(53546011)(55236004)(6512007)(2616005)(6506007)(2906002)(36756003)(8936002)(31686004)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1lHSFRXUERHMG1qM1ZOUXU2YnpHb056ckMrYmt6WmIvSm9OMWRUaDU0ODB2?=
 =?utf-8?B?VjgxanVnRW9JTHg5SCs0YXFmUTR0bGJtTVljWUozZEppTnZ5ZUk1Mk5BTU5B?=
 =?utf-8?B?V2VqeHhKUHh1NFRKbExBZEZQeE4xUE91OUhHQ0JhOUdIZ3B2NDRNRjNpYm10?=
 =?utf-8?B?cjEwTkRaSVdkK3J6NCtmczg4Q1VySFdOQVFURzhPODRVU2FhSFh6OVNwa1ls?=
 =?utf-8?B?QU1PUVJGMTFwVUhmdkYrYjJ3Qm9CY0V2U2VlbUt2NDJZMHhoV3VaZXhSQTF2?=
 =?utf-8?B?RzBKc0oxZHNHSlBoV2QxNUVhemkwWmVJYVVHdURUY2hYRHBYSGNNd1VSbnFm?=
 =?utf-8?B?S2FYa0t5aFRNSWcrUjJmUlB4QUpEQTBBNnVRZkJIQUtDazNLdWNFMTFtMW9r?=
 =?utf-8?B?cWtVTWY1TUx0NExRNTgrZ3VmaUVhdXVzWmNaMFRZNUpRbmpxQjFQZldMMUFQ?=
 =?utf-8?B?Ymg5a1hpenY0QmVvRmhtMkRHTXcxWDZoN0pvV1BMMXdWQm40TExvVnEwQTRa?=
 =?utf-8?B?SS9YWEs3UUhKeExoWGQ0U2UxSURhOUJHNTNQU21DanhEaDFGRHlVN1JNRk9o?=
 =?utf-8?B?UDFRbllIb0M5T0FQSkxBL0VHQ1JxVFplTVlMb28zQ2ZHaXZMWXYvVW0zZzJE?=
 =?utf-8?B?dGZDbWg5Qk1GdUQ0UWt4OGp1N2VVangzZzZyUWVnMXIzd2ZYTWpLWFBPdUY1?=
 =?utf-8?B?YVJ3Vm1aSExlTWt0NTNFVXdFdXcwb1Y2eVpILy9SVmpIcW83dW1XMUpqZkl0?=
 =?utf-8?B?dlQ0MmdERno2VjRxRUJzRUNPb0dGMVArTm5xeEZUMk9tOUhHSkVDMjhwQTFX?=
 =?utf-8?B?RTlNUDBaWHdDSTlGYW52RGNnL3FCaCtLZkFqMGdKMmRIS3RwZHJmWVo3YW5M?=
 =?utf-8?B?eitrbTVSUDVaTWZVdEhMaEFVdmVnbUZGZkExejVyU08yZHk5eFIzYy94TTVi?=
 =?utf-8?B?czdQV21hY3ZmRXNrRGxrZnp5dnh2NUYzNWh4WGJLRE9yVjlEbEdKUDdobUlH?=
 =?utf-8?B?YkJGd3FpZ05ETEZrZGJpd2N2NHlkclQwZmxEcVRtSU9NQkx1WmMwbzZnOGYw?=
 =?utf-8?B?MHYrRGtOSWt4dHpIZVBlUWFFNnNFNWpLQzVqakhkbE01SXQ3QW5DV1AxR1RB?=
 =?utf-8?B?enBSMnA3WmVQcnlsY2R4OFhmSytwZXZGR1JybnZVV0MrTXdsMG5HVW83ZDIv?=
 =?utf-8?B?S0VZckw3b3hCWWdybVFsNHlNWHY1OU4rbWI3S3pNNWQwaE1JMVVTT1N5c0ph?=
 =?utf-8?B?ZDVidFJXWUppOWVvQ2lyUXo1SWp1anY0SUhFM2p4UllTTkh1SktPdGRld3BG?=
 =?utf-8?B?dWtkdzNmNXZaK0xvU0M0TlVQSVMvbU9zZVFHb0k3U21RSVhKWGxIK2x3R2RL?=
 =?utf-8?B?cVNlRjJkeHZ3NUlUZXBTaUwyWklsY1NKVTNCT1BsM1VqZkFOaU5wUmlqOG1Z?=
 =?utf-8?B?VndUUlFpVDhLUkZCN2p2VXFHaCsybHNodHdCRGkycGdoV0paSlNycy9lQmsy?=
 =?utf-8?B?Z1ZTZ1dicUwvamYxdnlMcW4rUFMrK3EzMEhLMm1YNkwwemZhOG02a3BVdytt?=
 =?utf-8?B?U1lEMnNlQVdvSFZCelFrb09UT09LcVFpcENBMUZBWUNPMWJxbXZLNmxXZVZp?=
 =?utf-8?B?S3VwWnRvNUt0d1h1SHBqU1pxTCsyekxlN0gycC9ncmQrMGpBQVNjR0FKbUZo?=
 =?utf-8?B?OWlvK3hvUWhIbStaUlNadGlIcllzeWU2bjJ4UFByWXp5ZU5XaVhQOUZSMWNp?=
 =?utf-8?B?Z0t4MnRPRmg0S1IrdEswc3Z1b3hzdXpiaDFOVHJVNUMzN05wT1FodHZmRkk4?=
 =?utf-8?B?b3pUOG1yTlZwUnRyY1pONWVnTDhsTlNLN2Mwckl1anpPb2k4YlJyVGhTWWhV?=
 =?utf-8?B?SWFIZXZIZ09OZzlqT0hHa01RUXpSeEF5aktpdkxWWkY5K1Z5NVBqdER0dTRh?=
 =?utf-8?B?UTZhWGZrT0IvdGREOXVZd0sxNVJkUGk2blpVM0dOSUI0bGlnVldhR25aQ2M5?=
 =?utf-8?B?YjMwTzdhUXpRPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f1496d2-9a43-486f-50b1-08da07288d95
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 08:39:58.5724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /TnsCsspnYx2elNO6MNcgJH+AbaGd0/QQc4bC4AOlufUGjfnr/EB72JJZz7eQoXPxML98CRbZYN9XrPkKaY32g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3608
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

OK to queue this for v5.18?

Jon

On 09/03/2022 08:03, Akhil R wrote:
> Hi Vinod,
> 
> If there are no further concerns, could you please help apply this patch?
> 
> Thanks,
> Akhil
> 
>> Adding GPC DMA controller driver for Tegra. The driver supports dma
>> transfers between memory to memory, IO peripheral to memory and
>> memory to IO peripheral.
>>
>> Co-developed-by: Pavan Kunapuli <pkunapuli@nvidia.com>
>> Signed-off-by: Pavan Kunapuli <pkunapuli@nvidia.com>
>> Co-developed-by: Rajesh Gumasta <rgumasta@nvidia.com>
>> Signed-off-by: Rajesh Gumasta <rgumasta@nvidia.com>
>> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
>> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
>> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
>> Acked-by: Thierry Reding <treding@nvidia.com>
>> ---
>>   drivers/dma/Kconfig            |   11 +
>>   drivers/dma/Makefile           |    1 +
>>   drivers/dma/tegra186-gpc-dma.c | 1507
>> ++++++++++++++++++++++++++++++++
>>   3 files changed, 1519 insertions(+)
>>   create mode 100644 drivers/dma/tegra186-gpc-dma.c

-- 
nvpublic
