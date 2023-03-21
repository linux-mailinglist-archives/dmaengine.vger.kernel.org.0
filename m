Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A9F6C34A4
	for <lists+dmaengine@lfdr.de>; Tue, 21 Mar 2023 15:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjCUOpb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 Mar 2023 10:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbjCUOp1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 21 Mar 2023 10:45:27 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2054.outbound.protection.outlook.com [40.107.100.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45870AD14;
        Tue, 21 Mar 2023 07:45:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gu6Xf4g6ZzSatI8dWI448CECDrz/xTsBehTL5tG9tMciFKb678jHHZFKOuJ0/Lo2++dMQWDiFjuQzMFYIznIxdlhhTaKUc9D1BhGJSZyD5n6ZlR8zu1LYoyGd4rL9+K3e7oWIdiw61gOrtQ26+jpSHvkSjFUjQj+5VHmPJULCn/RoaEfF1V8LRGEzO/CNV5MNomRM5vpnhowWBT/wzPuHO+3KhQRgI86/ArxEPWdZelCaJzLf7Lr80bMRcTA/7jyOdwoDeLVHGlmNSMxusiThJ0IvlWu5jqE+0bByGB5tMruK+G3u9dT37IEzhMtK4SzeaH3nhoAgwBfeh982rkVvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Fmi5SL3vUpDD6FRdfUr2rpWSu65rGznkxwBc2d52HQ=;
 b=nbixnNQxjsnyG+dvlkwtOsU0xtOdjo0eUHE4+qBDHFzn4taWROLzjs19dMUjR3lkiERBhw98dqnvhUAWRwWL92m0Kttv+HjPJgRvj0wcGuHij/6bJC015KBxqait5As791C2JxiFzNE6HENB1WENm4uEMq81fjOYFucAHRGYkQ2jVKThjp17qZrXAqhgwtoHnMtdGzIfURn2jjTh9AXBlf65Y5ehHCvbk9jwEJZRDe24IS8b/Y8uQ6z4OCCbh5v4c37GtEzzWkFq52NHJiWEQyLCoXkp9Ek47rwPh6hU2k+gRwfsvu5CtCUGrTBKDAusKylug8pvJ0OeQK4P1mRaDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Fmi5SL3vUpDD6FRdfUr2rpWSu65rGznkxwBc2d52HQ=;
 b=2kSe6DmJHiR5NcxfJUq+rO09HOUj/kTbpZVTVZd0P/bN+DVZUvkTtKZJ5ztzhffnvVxxyCTqOMWhFEWYl5Spp3wh0jelpqW/SD4f89mXwz0Uw03ucPK8LVVD4bpo4KzxPaMHzMWCBQQGuEZm3M8Ecds95Uh6HsQENZLDMnLkNbQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 14:45:19 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::4d07:7f52:c833:9603]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::4d07:7f52:c833:9603%6]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 14:45:19 +0000
Message-ID: <18eb81cf-5a86-781a-0a2a-457bf265e1f5@amd.com>
Date:   Tue, 21 Mar 2023 15:45:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] dmaengine: zynqmp_dma: Sync DMA and coherent masks
Content-Language: en-US
To:     Harini Katakam <harini.katakam@amd.com>, vkoul@kernel.org,
        romain.perier@gmail.com, allen.lkml@gmail.com, yukuai3@huawei.com
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, harinikatakamlinux@gmail.com,
        radhey.shyam.pandey@amd.com
References: <20230316093318.6722-1-harini.katakam@amd.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20230316093318.6722-1-harini.katakam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0501CA0004.eurprd05.prod.outlook.com
 (2603:10a6:800:92::14) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|CY5PR12MB6369:EE_
X-MS-Office365-Filtering-Correlation-Id: b4046372-2036-449e-6c44-08db2a1ae45e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 39agWiRTyZzhiixWchuiGqGAUMlj49oz5bS4wPPjJ2YSq7emL5tLZdYPokr5VX+DjkM/gKb3XdBx2PRTDK0n9dPcDsV5uXu+e0q7/lkQQfFy/BvIpH8cKSGJJ5XElaJpr2Cs1wEiK70zVglcPs4/TGGKo87wYcWwif9wGCEb2ckc9DwsXTtDKIxbnWwYnR9juzk5NjscJENvadVXe0CQ0SAu1VQr64NC3g0cT3hbyCI2oV/SZwLBq4fIJ3JqHu0KDetwy89EmK4QMj34uLrO4Z+maHG/uJR7dXgRAj4g2yELcTQGK3k9Jl/qBpKXhLcowZQGZQ8UpHruiLOz2biNZn9ZSITxYUewqnVDZ2haTBeM+L7b/JspiCoa0BbFcVJT8nVNiGBX3VcPyoumr4UeHdEbuTylZcw1hgc6yYqEfMO3ZO3nsd7JOYcTvEawB+0Un34+f/kI8ZgJVStChP2yBxgP9kJEv8CxgbFA9sxNtvtDRui05Wblr08apEbnfib7NW5/j3DjcOGunU1w+rk2m4FRnPojxe6gABn4cRv6DohwPYb3pHI06JJOO5d1Kv1f6fWkDMQttmMVphvQH2871LjLcCwr5UbKi+LkB6V7l1fYh55aq4xoJDRR/Rlhs32QNovuRQYWmNDLKqx+BJD8Jg2MsW6rfSMFuxX4FF4A12McmmsTtJL4dXdZ3F7yfLNev+Y91tzOmR2kSX9Y7Z6oEj5S6SoVVZGFBwOeQsYQQTA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(451199018)(4744005)(2906002)(31696002)(86362001)(186003)(8936002)(6666004)(38100700002)(5660300002)(2616005)(41300700001)(26005)(6506007)(6512007)(53546011)(316002)(478600001)(36756003)(31686004)(44832011)(6486002)(8676002)(66556008)(66946007)(4326008)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWU0NXh5bnhmOVBZZWtJRUlGY0lVaEZKM01nUUNicjAzVWViT1J5L1BaSjVt?=
 =?utf-8?B?VEhteDZ6RS9QM1psUVk4OVh5b0VCWHZGZHpkVm90dnc1akZLek10S2dGbFQ1?=
 =?utf-8?B?bEdTZkxEd3dEWmdKaWU4MkI1cWpLdDJRb29hSGRHaE9TOFB4V05HMG1RR2gr?=
 =?utf-8?B?eis0bHZoblBJTUdhVlF2Z3AyUnR1dG1TQUJ2RVloeDAzRklOajFoV2M5MkdX?=
 =?utf-8?B?OUcyY25vWURjOWRzZzY2VWF0SXArWTNObW04S3l1WTJFeXRQSkJTZWhaWFBV?=
 =?utf-8?B?dkM5d0xnSXpBTkFVMXZwSTZFVUxCU2gwNWtZa2lSTy84N2xId2RoTWx1MFZZ?=
 =?utf-8?B?NFl0TUgyelBiTGtLQkpIdmVnUlV3OFZMeS9YSmdHNFE4bG5uZmhibXRIRVFJ?=
 =?utf-8?B?U3VtOFVuNXhLckxHVVh2UndLQlZ6Q0hRUWJqdXBYK0N1T04yMmxLUzdYY3Bq?=
 =?utf-8?B?VkNpT3Frbk9lMjVwZlVGVVpkWVlPOW9sa2x0eFJ0OXkzTi9RTHJHdHNadVpr?=
 =?utf-8?B?VkM1QTVrVlczcFFtcWFwZ0JESkNRNG8wSFBpWXlLbXZlREhIblg2SDlFNDJN?=
 =?utf-8?B?RS9pd0RZWTFHcE11UHdFSVdJL04wamc5Y1FIaGNWT2xYNk5FNVRQaW45TjQx?=
 =?utf-8?B?MEdqT1J1TFd0cmRreWtVU08wS1QvVVhRdjdVN0tnVmFpcXhxVS9LUEdxZ3Nu?=
 =?utf-8?B?UmNzazg1ZWlHZHJDalVEYThSTElrSTloQ3MycVBVR29nV1REQ0VQLzhHSTlS?=
 =?utf-8?B?OC9FSk9Jcmc1clpuS2U2VkFkeHFFdUZVQ3NRSFU3UXMwdXBaUVNEN1N5VnhD?=
 =?utf-8?B?N2pwZktZNHRWZG5xVGwzclE1TDRYWHhucW9BT2NrSFpYSWdRZllxNXRjQitF?=
 =?utf-8?B?Lyt2NUZXMUl6UVZlOTNlT3E0Zzh5VnZwQytNT2NTZnlnd0Y3MGRyTERGN2Nl?=
 =?utf-8?B?RTFZdzJDK0xrOVo4UElvRXFHWVNUaGlkOWNLMFI4SDdVcU1oc2JBWDg4WlVJ?=
 =?utf-8?B?bjJjVStISmNmK1hYVS81YitqTlBRUm9qSGJXQ0MycFZHUUQ3blVjWkt0OUJG?=
 =?utf-8?B?UUJuQWFMWnlnRWhtR2RLcDc4Wlk4TFZ6U1RvTmtrNi94MkNkTzA2NXpxa01X?=
 =?utf-8?B?eFROYk56MklpSnhKK2tBRFRlRmhpSW5jRDdjN0FLL1UxYUpxQnh5bTRPM3d2?=
 =?utf-8?B?VWt6YlF5WVQ4Nml1cFFyVjlZbGFTSUIxNUFVYkNOYkxIQ0lGRWo2Um9SRTg2?=
 =?utf-8?B?Q0xacFJ2OFlCeW00S3p0V1d2b1lvdHgxN3gwazQ1RTlWL1BDcWRLM1BMUWdj?=
 =?utf-8?B?VVRBYTB2cFN3WllSQXhFMTFvQ3UrTElybUNPa3I0eEFQb0hBLzlFUlZ3MVBn?=
 =?utf-8?B?bmNRMCtkK1hIZFlPVXNicmJxN01hbTNFaTRsVWJ6U3lFQ3ZPbVFDVlc4L3pn?=
 =?utf-8?B?RzRYT1FVR1ViZHRQOHl6eHFGQWVlZlh5ZVMyalczZm9KU3RnRllRU1VBY3Ju?=
 =?utf-8?B?N0I0QWFnOE1CQkFvRmZ3dzVGUHZ1OVRHQm4wRDdEcTBoQVpqTkYzRXNBMEVU?=
 =?utf-8?B?SUZ1dW85VXlUQjdKR2N6a25kY2FyeHFTVi9Ha1A1V3B1WkNQaGJ1L0RFYmJq?=
 =?utf-8?B?QjRxTG1UWEx5QTVwYjlobmVTak52WjJNMVYxU1oxNk9HcUtOanRUMHNuT05B?=
 =?utf-8?B?NUtSSWhpejEyMktJNXoyOGRweVkyQys3MlE3MkJwNGE2bStGZ0NPVE1Kd0Jr?=
 =?utf-8?B?YVhqYUU1M2w4MDExN1dBR1VudnFWUlFtQklSSWlTS1dsOE5uUm1qTmM2VHpt?=
 =?utf-8?B?ZVN5UWdtQUE4eElDQ3Y1QUdDS0tZenpoOGtWSkxDangxU0N6STVyeGdodGMy?=
 =?utf-8?B?Z3NTelU2bzFkQmhsUGRlbiszL0h2dURVeWh6ck1hSDExTG82TTJwRXlUQWk1?=
 =?utf-8?B?ZFFJSUI0RWpQb0RpK0tIYWVpdk9ac1Q1YVIxRytlQ1ZzeGRYdU1JbjBsT0FU?=
 =?utf-8?B?azFFTlJuNSswSUtsZFl3RWltY2oyOWoyWmJobytyTDhCeCtzRUNIOVRmaXdz?=
 =?utf-8?B?VFNoMlVjYlNLbVJXd0h2Vk94WkxXL3B3YjNXdStzc2x4TjlSNUhlbEl4bXNt?=
 =?utf-8?Q?rxVS9SLrUVP+qnp3VSLrPYWHT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4046372-2036-449e-6c44-08db2a1ae45e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 14:45:19.5091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DOd35rgEjnw4g42Rt6GDm3dagng44dQaLoPfciayA/9YWDTsqVakV9Qj37XNzuhc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6369
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 3/16/23 10:33, Harini Katakam wrote:
> Align ZDMA DMA as well as coherent memory masks to 44 bit. This is
> required when using >32 bit memory regions.

It doesn't look like description aligned with the change below.
You are using 44 bit already and the patch itself just checking return value 
from that function.

M
