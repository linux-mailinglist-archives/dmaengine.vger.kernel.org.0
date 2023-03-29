Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A4A6CD46B
	for <lists+dmaengine@lfdr.de>; Wed, 29 Mar 2023 10:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjC2IVp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Mar 2023 04:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjC2IV2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 29 Mar 2023 04:21:28 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDB826A5;
        Wed, 29 Mar 2023 01:20:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nUpGYNvlAytYLcOHEDTMaLvr9aRuVfgdfPbgyC3C5QdBVsRWt28yJXgaaAAb+6NaEFyfnH94d/4dYyKLGqPeBizlmCS+grr8b9voEM6AM+GmJwLYIVrVimNzCNpTGNjfZ5XUMRPcqF4D/fgTPO+t97E2/NltvE2+3TQ/uItlTugdPDG3KSaMZNnw3ZX1bdPYm1LqdBHljwR0qteokbaACVH2x06zVPfDgnj3p7Z/8Ru9dJRz/+zpJxcBLm5WG5DsxT/x6lHB8n+454bwlkFHMjPVRGddgv6pHnbbVnR/Kr8L7AJXIDSnQdYeB9WxJUXmpGgQT5sWPpiqrqGJwZKfEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5cN6WH3vjhQyLGR5OfyqxZrpxwkalNGRBMjxs3SLDRc=;
 b=iGd1371FtHXq0mjcXha9NXJhYIMLNa7ZPWCBgm+us2pnxPSrEyN3FTHyGjp/+BjhJvuILLVqTCMCbNi6Q94N7PHoJyCzEX/46dvW2Wd3u82Foxfa3gnPZeTS7zoU/6YDKVpz5OZAyYnIg44M3FbAnDhpajrRQyz6nloOh/vL2R+uHH7P3s4hoxtaXJwNWOH5o8l3sryEGGNY1dZH3O6jZuZTXWqOXMyn5F4CmDv5qY/11ilnU5qifDziZaQtuSqiuYSUm+wudb2G88CfdoFbH+aJ7pG4hJtQ998ocD6S/iBLghG6HKzJSAoLuzn9SA8C0f/Fdg79cFIOJi7ON8q7zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5cN6WH3vjhQyLGR5OfyqxZrpxwkalNGRBMjxs3SLDRc=;
 b=F0OGb3MCxxPPjmt3tlNibQuH7f6dS0zsAR4BeFtP5twDs5qeFLJBThA/id1ID4uIssjb6al6QNkTtzWK8Xh6opQbfcRq4ixT34ogP9Z5XjKo4IZBYYQaSPuVMgIpbjYxdDpS7FdyGAjVE6Ocy4E8Fa0MjCt+7B921+tfl+orv/w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7SPRMB0009.namprd12.prod.outlook.com (2603:10b6:8:87::10) by
 IA1PR12MB6042.namprd12.prod.outlook.com (2603:10b6:208:3d6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Wed, 29 Mar
 2023 08:20:17 +0000
Received: from DS7SPRMB0009.namprd12.prod.outlook.com
 ([fe80::57de:d785:91de:d205]) by DS7SPRMB0009.namprd12.prod.outlook.com
 ([fe80::57de:d785:91de:d205%5]) with mapi id 15.20.6178.041; Wed, 29 Mar 2023
 08:20:17 +0000
Message-ID: <ca056666-08df-7733-a7e6-70047ec2cbb6@amd.com>
Date:   Wed, 29 Mar 2023 13:50:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 4/8] iommu/vt-d: Reserve RID_PASID from global SVA
 PASID space
Content-Language: en-US
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Jason Gunthorpe <jgg@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>, dmaengine@vger.kernel.org,
        vkoul@kernel.org
Cc:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>
References: <20230327232138.1490712-1-jacob.jun.pan@linux.intel.com>
 <20230327232138.1490712-5-jacob.jun.pan@linux.intel.com>
 <41d31adf-577e-431c-c400-2708885400c1@linux.intel.com>
From:   Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <41d31adf-577e-431c-c400-2708885400c1@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0012.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::21) To DS7SPRMB0009.namprd12.prod.outlook.com
 (2603:10b6:8:87::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7SPRMB0009:EE_|IA1PR12MB6042:EE_
X-MS-Office365-Filtering-Correlation-Id: 2747a8c8-637f-4b30-6971-08db302e6d54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fkp4Mq1eNhXJuqEchVZIZqn9v7WP60rROGb9PXtdQ89ANCHEOlA1cetjIibHVzJywbefOpArboH/+U4mwP6NXAmigNqiHRi5nJ3cjSYtaInO+8Kk0cDjuKSI2Lr30AhaFJYMnyPmvMFwzuNJadYgxEUIqLwT9MNOewxE6f2Dg+ykj8Rh6UEuztQu7C2zjlJ+kgicw0vjjbqj222Vt+a0hygIejnUA7Jfv46BSNFad1kvLE7s/10IbVRhRAEmkoclhOVJ4Twziykva8AxjnCkjhwFodrxyn7MXAEKMthVi7nfLmtR/Ek2RXZgwICI1JmJILG2zvwTh+XAp5QuYQNWd+fzL46EcupfWS+HG2B23CcrpvIOBYdfUArnkbnM0/kJuUj8U0ZyJ4YhXLhnWPa2+txCgefUauy2795AwDafqyD/IDPpR4jvsbdd8MjQZC8RU5kln81zx4rnuW9wJwsJoMur38GKGTIS8rNyXMaFHpfnS6vWeZh/pwfMOodcL5srB4wyiqM4y1mbsWJ1df1WPBwEq3WC93Am9HD0YMd/I+kTlcGfivDCo6ydRxAUEtzYXvfj4lfrARZPrYujxT8/iT0cnvk3v9mgtL3TO1OuQQpgw3JtLVAXkR++1oIficG7x+uf9ZkkeU8Wkey+RmXlzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7SPRMB0009.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(451199021)(66556008)(66476007)(54906003)(6512007)(4744005)(5660300002)(31686004)(66946007)(7416002)(8676002)(6666004)(41300700001)(2906002)(53546011)(44832011)(2616005)(4326008)(38100700002)(6486002)(36756003)(31696002)(186003)(478600001)(83380400001)(26005)(6506007)(316002)(110136005)(8936002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mm1xcHJjUzE1cFdMeTQxQUFkR0h0NlFnTkxxT21mWXNmMU9ENGVLRmQyWEFY?=
 =?utf-8?B?a3BlZzVHQ0JVOGY0NjJ6WWtPS1l0YThHYnBwaVhPMnRLQjVYeFNqbks0V2VQ?=
 =?utf-8?B?b2FXTjRCWXJwVzdNaW1hVnMwTEZyQjVDcWFpVjc5SUo5dDROb09pTnk5c1Ja?=
 =?utf-8?B?Sm0yRCtYRjFXTVRBWGdyY0FLUTdZMUxMbnczZWd2d3lwemZXbVRmQUIxR1Fz?=
 =?utf-8?B?QmFTWW9xeVFDZjRYc3VXZVBuYXM3NjFiNS9Vb0hYVlIwYThPbjlpMVV6MVM5?=
 =?utf-8?B?YWdldzVEYWhLZENCYU8rY0FYQ3dhbEhvTFpraWlyS00yK3hTYVR4cnR3NXls?=
 =?utf-8?B?bnV6VTR6Uk5aU0dJWnJjWkx6cnRQMmc4ajREK2RTQmVqQkdvQU1XcWxDMkRQ?=
 =?utf-8?B?VG9qazEvZmVnQ2M1ZFJtZTZRLzJ6aWJNL0lnRlp3bkNrSmI3RmdNZEVQRGdS?=
 =?utf-8?B?d2x6UDNyRkh6WUxhN0thMFZ0UlhIMDRoZ093V0hBbjRpYnUxNVFVY1diWFQv?=
 =?utf-8?B?THJEOVdQTWJDdHl4cFE1dVNiZVJhaUFkVXV5WUlPSDU4ZUdpSndYVktmUEcw?=
 =?utf-8?B?Q1k2Z2xDOFFtRDlSUFdEZUVwcEU3ZGx1K2tWc3BrdWlid3RXSWVUQmtyNCti?=
 =?utf-8?B?V1BudHg0VllYdkg1TXNETFVGMUVpTmZuQnR6Zlh2WlhCc1pkUWpubnptWTZx?=
 =?utf-8?B?Uk03ajF3dmVDZWFKQmFqcFNWN2ZPRS95MzJrdUFTWXRHSTRaVHlKVnlHN1lW?=
 =?utf-8?B?TllmTDlhZXYvR2xkTmhTbjlTMjN6OFRiMjg4ME9KNkFsTkJqeUtVSzZZRmNY?=
 =?utf-8?B?bUIrbGZNNmJmQmlkUHJjbEZyMk4vejczMVhQUDd0eCtkTVNRN096dWF4T3BZ?=
 =?utf-8?B?eHRBRHg5dFBEeVNUbEtOUDJoMTRYQnVSTVIwZ2haRmRTU09pZ0U5Zm0rMFB1?=
 =?utf-8?B?aGxVeEZnWjZad3BBeXpIS1hhWndtRW4xOVM4T1ByeEhvSmxiUkhxUFdaZHFE?=
 =?utf-8?B?Qjc0cDZDY3puNUw4KzNnTGcvR2huOThXVVBkeTVRalk4NjJOeTJtUGRJaGJI?=
 =?utf-8?B?WmFGaEIxdks2aG1KdVVWU2piRHU3THNSamVxRW9YR2RqbVRPZTcxVWVEYnR2?=
 =?utf-8?B?cXFaMkhOMjFCYjUvTkZxZkhYWWV5OXA3QTFHeklDeDhmMnhDcW12MzlsK3dS?=
 =?utf-8?B?TGJOQjVhYytHYndCbUg3SEs2aFhKSGt3cUlOcmN4WURzcXE2Y09HT2pQb2tt?=
 =?utf-8?B?bitKV2VOaDNNSVF0VWVEd2JBK1JKYVBXbDRLWnovbmxEK1h5K21uenJ1eGgx?=
 =?utf-8?B?amdmTnlLbVVMbnMwaSt6em91S0x0VVZTdWU1OTZVaGU1bzAycmQ1bWkvdHgx?=
 =?utf-8?B?OGtrcVRRZDE3NVZMSThNeStYL1JIc3NHbXU5eEdpUTdUa254ODU1WEV2WDhq?=
 =?utf-8?B?b0JWeDVNZGlYMGJuZ0ppeDMwZEYyU3Y0STNTeUxoL3QrQytyeFBNSnhQVEdH?=
 =?utf-8?B?RWQ2RFRJakdYSTRHVkd3NEFUQjV1QnlTUW51U1Y2UTZidkwxMjhldnYrMjZN?=
 =?utf-8?B?eW9ManltZnRpd0N3NmlrVTBQRXh3QVBJbGswSTNhbnRSUzNzRkVLRjJndVNs?=
 =?utf-8?B?WXRyT1VnN0FCZ0RYa2Z1SkR5UkNSSFpGc0syTVRIN0dxOWpQcGhSL2Q4RlZs?=
 =?utf-8?B?MnducWliY3ZSRlR6UXdtN2JORlBON0J3ZHV5Y0J0VkFyZ2hRN0Y5OU5vY2Nh?=
 =?utf-8?B?UGVLVFBEZm4vQUYyK0dxQW03R0g0azJFYlltWnV6MS9tRzM0OHRiaHQ5blBU?=
 =?utf-8?B?OTV6Ym5OQ3dGeVpjc3JVdlBybFY3d01BTHNMLzlSTkpvanFiSXlYOTZDUUk0?=
 =?utf-8?B?OGl2d1cwbkM2ZjB5RkJiOU9tK0ZlaThxQThnbVdKYjB3SlEyL1gyeXRxOWkx?=
 =?utf-8?B?QWl6U1VtV3JMRmxrVEE3Q3hFb2R0aS96bDErN1BJNnZPMEtncGhJWUhYUFE3?=
 =?utf-8?B?bDZLT1g3QmJLengrWjZsUmNTMXlCT1VFMVVab21FajJBSk13STU3OUI1M3p0?=
 =?utf-8?B?UzZjUUpxMTlBYnZPQVV3ZS8yaG55OFN0eTRpYjJnNm1yZDJxcEVkQWJjcmN5?=
 =?utf-8?Q?lzq6WU02h1CMXhtjUv55yLWWx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2747a8c8-637f-4b30-6971-08db302e6d54
X-MS-Exchange-CrossTenant-AuthSource: DS7SPRMB0009.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 08:20:16.7864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5teV2hYhlqEP5dUY9KWpOlhEOhhemXjsky9RNfUHoF+X37sazsUJLon79YZpKX0ZhaVVxkLIMCm86s176ZKcow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6042
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 3/28/2023 10:50 AM, Baolu Lu wrote:
> On 3/28/23 7:21 AM, Jacob Pan wrote:
>> On VT-d platforms, RID_PASID is used for DMA request without PASID. We
>> should not treat RID_PASID special instead let it be allocated from the
>> global SVA PASID number space.
> 
> It's same to AMD and ARM SMMUv3, right? They also need an explicit
> reservation of PASID 0.

Yes for AMD driver. (Requests from the I/O device without a PASID are treated as
if they have PASID of 0).


-Vasant


