Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5366C3552
	for <lists+dmaengine@lfdr.de>; Tue, 21 Mar 2023 16:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjCUPQV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 Mar 2023 11:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjCUPQU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 21 Mar 2023 11:16:20 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE7F39BAA;
        Tue, 21 Mar 2023 08:16:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XSrhtYw06b8FaC9l+7Ia1TFqKsBI3rCtTSy++PXkEJXsU0Eowwhp5a4U99ZB1D6U6UOv1FxnyqV+HTnoXGYdBUTO2PunHJepiTEOVUCQbia5DtAdsucJ9x/IiHY/P8LD8zorf2NkEVqVUbUwsWvaMYStMypRCeWh8jYn6cjBO9Hxd5j8VpRyPIx8lz/6susWeH8Va/Yd8e52/wlOKdeo1Lq6nEXH/FMw6mCnu2jf9tOqK4Sdy8HainGbqv+iyDQHe4DVReUCdbKwXEmnUUlax26yJBzfHnBV11soz+7D7XUw2L10YeKT5c8RAV0i1qaI7JG3c7g99K5DQ+HV5317hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4pm9nNK21oHIzYPiAFtg8LGGMHdRXgFKe28vc82rIZI=;
 b=jDMGzKgQKdx0rkY1Iwd3lztTWFRIZ7YOruXPzLGIY/mxNfSj8u5tY3FDmNsifUkJCC4+wcnsRZxL2Nzu/iBoNqMDNhGrO7gQ0KPVVX1COzcf2pv6NNRtw96JaFgsaPLqD9C7Dp8hCdL0wxdroYezyGFDL1i/GrEFGz94IPH4pCc5UoaNX1GcHjRbbCCo/ei+QvlOUn0QhF9KpJNnSwXMlgdnB0NFsXaTaCRNGV97/NrLnPF50Ft2KKSccTcFr6NvVD3IDBOZE2faLEcbum8Gey7ce/E6kWHtdtuECXJr0ScUq+ci78WvuwrDuMIp6TJlM6ZBDsSt8btD0kZVBoiDoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4pm9nNK21oHIzYPiAFtg8LGGMHdRXgFKe28vc82rIZI=;
 b=fvNhypvBRQY/tj0SOBaN+RK/sT36k/zE94GBGf+asEcw75hTjh8fZISQWtetGzwtioKG5nt2Y8jsdtZ2mX107jpe8FHVn+vjMlhtm6wpmg+G/kP+9rHqtqjjbc7cwboISR4wubab05TvZ/Qg2ftcWOwnyjZMrzOvceI/sPltwAc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by MW4PR12MB6949.namprd12.prod.outlook.com (2603:10b6:303:208::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 15:16:11 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::4d07:7f52:c833:9603]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::4d07:7f52:c833:9603%6]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 15:16:11 +0000
Message-ID: <1e44aa00-9896-8869-1707-fe8e5815e9c7@amd.com>
Date:   Tue, 21 Mar 2023 16:15:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] dmaengine: zynqmp_dma: Sync DMA and coherent masks
Content-Language: en-US
To:     "Katakam, Harini" <harini.katakam@amd.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "romain.perier@gmail.com" <romain.perier@gmail.com>,
        "allen.lkml@gmail.com" <allen.lkml@gmail.com>,
        "yukuai3@huawei.com" <yukuai3@huawei.com>
Cc:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "harinikatakamlinux@gmail.com" <harinikatakamlinux@gmail.com>,
        "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
References: <20230316093318.6722-1-harini.katakam@amd.com>
 <18eb81cf-5a86-781a-0a2a-457bf265e1f5@amd.com>
 <BYAPR12MB47737C53AA67606A94B223C59E819@BYAPR12MB4773.namprd12.prod.outlook.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <BYAPR12MB47737C53AA67606A94B223C59E819@BYAPR12MB4773.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0081.eurprd04.prod.outlook.com
 (2603:10a6:803:64::16) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|MW4PR12MB6949:EE_
X-MS-Office365-Filtering-Correlation-Id: c1ca0936-a9d4-4f5e-a212-08db2a1f3476
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ykirO1kBPR4Ml7OqqplAxPQvQ/jqSsNEQRVecuo6U7v0nuiUNcw57xMM7GpVz9nMy1lZmmn40qvb7Vx2MUDyPbChXAb98U/hVRjayH7M1mIfvWO0ZFR5qEpfPPcznInyA6XWyYpreHGR/j0+20+CLTdXeT5T1hZM9O+eL+9FTFy2yjefiQJ1MDVMpA1EU22MT11DYvgzugMOQ6Nu14tmnpEBEBW0/GswtHMXxflbvVpj4VM9JgDxPtNfvzzIFhoguLuoGQaef/nORS47MMLEbpofE6rEd3JnOvngGS3dV1E9hY0QtA6tmwBPzhQU3kIA8HWZxzAtCg6A9mKfNMXQHs6K1teKjQcWd0FN+teuZ2KiTc6OaoQaIkDD68zKyfNKm/tq0QpZao4stNtUnvN0ULKAFpSQpoh+wCbCBOsx2RdW3Um8VqG3TP0oG9onYIhQsXTkTys6+k5rMmQs6fv0GO3dz75PIshWuHYPzRtzZkT+6/z0C+dnTN1ALdmQQ+vW1s2Q6dtQXek6UwZoPJNlIPek51Dgj1m3RRi6b680KWM3laDODGowWH4oPo/HfBJKa32oHOLIm3r1tQKdYAy0ZWpTmxb/4RoVWAMXbyJC9b/0TwxWNVEU0D+rpnaXCIbYhIwUkoxEy5yIn0Ar4Cgcid1TIIb7fdRMsEgvd0YZeaOz/8wlcisIQFDl37JAIXkW9eRXavMgzn6SPTAsNuiYRRZ6NLMMwtGbT9VsV2YjvkM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(451199018)(5660300002)(44832011)(41300700001)(86362001)(8936002)(31696002)(36756003)(38100700002)(2906002)(4326008)(6666004)(6486002)(83380400001)(53546011)(478600001)(2616005)(186003)(6512007)(26005)(54906003)(31686004)(6506007)(8676002)(316002)(110136005)(66946007)(66476007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEErd21XT0QwNDBMQllqZ3FDaGJxVEQwSXA3RTF3RkZUTXFjVmtPSU5WZ1Za?=
 =?utf-8?B?c2h3QnU2aktpcnpsL2licHgvR2hhcXppVHpVTlpxeTlnT2Zwbm1tVStGdXI1?=
 =?utf-8?B?cldUSDViZFlRVVNYcFh3RXk4QU1iWDVxZFlRbGRkeXhGSkpKVFRqb3hwZHJL?=
 =?utf-8?B?clRrTDlDL3FkWThhK1RQdTJjTWtrTjBkeHRUQlprRk8vSjFxLzJPM3kvYmxF?=
 =?utf-8?B?OE00OTh4ZkVKSjdhUldPK1FZRllVTk9iNzVDQnNLS1E4Tk16bUZvUENXNldW?=
 =?utf-8?B?bmpocUtwSVZ6d0FXdEJXNmM1eTg1MysvNG9VdENoZWpjaDIyNERZYTVaSXZM?=
 =?utf-8?B?NFA2ZEZBalpMR3U0WWFHMHNCYnE4VFZ4VjVDcm5qY1NGVnJWdjA4YmpRbnpD?=
 =?utf-8?B?NWxWMGVXKzh5SWJoRFhiSHhuZnJJY240SUV1ZDhWTjNqV0UzZmNOSGVSdzha?=
 =?utf-8?B?bjdYeTRnaWFpUStCTUhIRll6VU8yVVZHTUZvSHFNK0UvaWd5YlptRWNiR2Z1?=
 =?utf-8?B?cGM2MjNUc2d4SzFBVEd6Z09EbkRWSnlUcHUwUjZ4R2RNQ2NVMUxSaW1kRTA5?=
 =?utf-8?B?ZlB2RklPK3pBTWduc0Z0NDlOTFRjRm5nckczTTlwOHRYY1hUMStTSmZ2VG52?=
 =?utf-8?B?blh4RGcyaTY0WXQ5cS85UVBCbzYwbHNzejFkMi9lK2tjWTc1QUJSZlB4Lytu?=
 =?utf-8?B?NEZpRnhHcmNNTUNWZDFGNy9uZTB4NkYrLzFSWHQ4bXVWdENIQzgxTzVXOC8z?=
 =?utf-8?B?L1JXUWZPVGJJOTVqRy9sb0JoZ2ZXcUZrNzVPVVkwMTFwUTh1Ujc3MFlnT3ls?=
 =?utf-8?B?dTAxejNyWUM4anNUVTZOME9GTXlaN2xtMm1qd2tCdWtMdlIwaThUS1d1TVJi?=
 =?utf-8?B?MlpSY1d5cmUrWXR1SUEvR2RLbWY4Z0pvcXlEQVRrMk1BRFJqUEN0ZjNPd28y?=
 =?utf-8?B?aTR3VUtWR2JNNzZyZ0dwTUh2cmhKL2JWZGZWNHlxOFFQajBGbThGaGxQampa?=
 =?utf-8?B?T1VTQnhVSUMrUkljdVBINGltZEJKNWZ0NUFWSnVJekJ2dGVuRnJjZ0dXSGlL?=
 =?utf-8?B?c0FWaytzUWgwODF0cUZLblpSRUtzTjdwQUJwbnRLU0JMZ3BnSDhOKzhKQTU2?=
 =?utf-8?B?VXJ3azdJMTM2M0lyT2NTMmlueUQrZVdoTnJiM0wvS2hPR0UrOU1rTS9WWXQr?=
 =?utf-8?B?aHBnMk9oUHkwdm1qSnA5aFRoMnVlU1Foa0dlRlZ1M2owWVBicWFPcGw2YTc5?=
 =?utf-8?B?ZVRSeVVxSEN4R2w5NFpPbVdjQ1FvaldVOGFlTWFFU01BR242bVgrT3pWRGVZ?=
 =?utf-8?B?NHBSTmJGNXE5MUhHQ0VqdVg1d002NjZkWkt0TCtwaXFIemxNRE5Bd1BiU0d5?=
 =?utf-8?B?QXduR1FsbzBRUlpSbFFVRVZueEwxbVRSYzNlT0FlTlVhL0tHOG1vRXZxQlI3?=
 =?utf-8?B?WXVPRzRQMTVaTVdMd0NuUEdRQkEzemUzQURUMjNwaktVdFFmQmhSenJ4c29j?=
 =?utf-8?B?anpCLzFvT09ETjZpWGF0UlJCTjJMdHQ2UmRHejFpL0laRFhuSVpkdFJPeWRx?=
 =?utf-8?B?UEN6UE9QYlNVRi9ZUFZsV2MxaS9IWDJUekxkK1pFbC9UTFc3Uks2S3dZVTFH?=
 =?utf-8?B?TmlxNS9rMjZObU0vOTk4RFBNbC9obzFZa0FlYU14NVNOK09jbXBNUUNuK2ow?=
 =?utf-8?B?bEtTY29lWDZBNW5CZVpBREVNN2pLbk9HK3VRNHRxV01zdVg1eWFCQkVjellM?=
 =?utf-8?B?NWEvVW9zOG82aWx2ckxRMzM3UmkvU0VKSk5OQjZmWEkyejhQYldvMmRNK0ln?=
 =?utf-8?B?dmNJemlhakx3NXJPQVFjWFc2YXJ3MmRUUk9sRlNMKys0di9vN2dtZDZTSDFU?=
 =?utf-8?B?VnA5N0pFWDdWZWhuaUdNK0J4bTZLb0hXTWRQRlgxQW1sNTVuQlVPc0JtK0JH?=
 =?utf-8?B?cEVHbXViRWtldFgxY0oydm1MQUF0UWZuV0VRSk1yN1QxaGVUQklIRVA3bWxq?=
 =?utf-8?B?L3lhM3hlTjNWM1Y2R2N3UWdsZjBZS2RQc2c2YnFUcHRDaEl2SWJOeDZmNi9D?=
 =?utf-8?B?WDBRTjByYitCODlQWVgweENGN1FMU2hBaHVOcTNkWmxGY1pSQ3I2S3NKc1dH?=
 =?utf-8?Q?PmXuziBIP8BUgCxGJmksfOR2d?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1ca0936-a9d4-4f5e-a212-08db2a1f3476
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 15:16:11.6693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dQO5iI1F6KEnvZvaQtd75j87sIz0AnOhJEpSk55wSVrmIMu50avpg6hWhOrljrz/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6949
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 3/21/23 16:04, Katakam, Harini wrote:
> Hi Michal,
> 
>> -----Original Message-----
>> From: Simek, Michal <michal.simek@amd.com>
>> Sent: Tuesday, March 21, 2023 8:15 PM
>> To: Katakam, Harini <harini.katakam@amd.com>; vkoul@kernel.org;
>> romain.perier@gmail.com; allen.lkml@gmail.com; yukuai3@huawei.com
>> Cc: dmaengine@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
>> kernel@vger.kernel.org; harinikatakamlinux@gmail.com; Pandey, Radhey
>> Shyam <radhey.shyam.pandey@amd.com>
>> Subject: Re: [PATCH] dmaengine: zynqmp_dma: Sync DMA and coherent
>> masks
>>
>>
>>
>> On 3/16/23 10:33, Harini Katakam wrote:
>>> Align ZDMA DMA as well as coherent memory masks to 44 bit. This is
>>> required when using >32 bit memory regions.
>>
>> It doesn't look like description aligned with the change below.
>> You are using 44 bit already and the patch itself just checking return value
>> from that function.
> 
> Current code sets dma_set_mask; I changed it to dma_set_mask_and_coherent

Ah ok. Then

Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
