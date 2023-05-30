Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA91716803
	for <lists+dmaengine@lfdr.de>; Tue, 30 May 2023 17:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbjE3Pw3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 May 2023 11:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232366AbjE3PwL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 30 May 2023 11:52:11 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3BE10EB;
        Tue, 30 May 2023 08:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685461887; x=1716997887;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=a0Tdf30kpmxehw8Uv3dkikJul/kVRyAJa3XF23oLvGs=;
  b=Vx4tQtCFGBehNgACUt31tYq8D9Ba2ILd6M+ZfdsRWVI/y7WhFjWZ9K7r
   K7RWxDVFkp74l4Qd5SMmIfyS72VmB767AzNPI+L+0qWr/K3wp1p8SdRfC
   1trmND6aUxx/SGZXiOZZZO2DRBd5LNG9bPqJLChAbkbC5K9v+n6O1lrQH
   QYZDDLzvNZaInj24pkVzBhI01OOPLw6KC8lsrpPIBMskDbTo87Ba0yKUI
   Mtuyj/am95+g/O957fKjY/FtwuEF/bGY5Uj4cmnRsTVx91gOLAWMnP+Ts
   VcqxoGPLxSkPuQGBAX8CMjp2qdscvwmkw8TuSEq7qtG9TfnFXfd+jADCd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="339546744"
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; 
   d="scan'208";a="339546744"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 08:51:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="830818774"
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; 
   d="scan'208";a="830818774"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 30 May 2023 08:51:27 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 30 May 2023 08:51:26 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 30 May 2023 08:51:26 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 30 May 2023 08:51:25 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 30 May 2023 08:51:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=edI/Ssh95Va8xvnxTcHmBJUOJyBsqdNw9w6r4M17Z+wVkF+LMGmu9gsKDLKs3kaacom8+/YWK1rYKe7pz2UDftPhh+2RKyBy5w/cxDg45PFIRYZ8GCud7Lp32dcSUEXY/qhwEDy0ijhxbyeBTjCYniPb0BjNIhi+TjvRLBjInmgeT3G+JjqxK6n91vpdBuARbMmWNfFttj6DEPzn2VrjkUqAQv/FAqWr/3TVue8Q/n7X5qQmAPj5i8ticLC6c0HdFckxZBLqKHmcjC35qEzG4LU8naiyNQKEI68FncpT9wEGoG5SqylGDpigYDYfSgOG0Mb8mxF7UUPv97Hf2W+EcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/pVSv/q61FWhVmD5U1n0RC22TXBLaxKd+Zr+I4x9M20=;
 b=YiQjQJJpz1PwCD7Idh4OJWJO8ziDRIaL2HYFupYa+XTjsb8OdUeuO+cPFu2ENCT9cBdWJHtq26F5nix+m5FIZT+N0ykp6AaCij6USNobMpe1M816nwIZWPfISaXTuF86e3xfpDQ6cNmEB1q+PcjyCX7xaE0Uf0tjFxCvKffQF5dFMfievCuRxPGuPgNKnKraUZoYo8mXf19jF+W6+KyhFPdS8TKKC9VLTbvCUOyzCHyccCOUpjFev7q7HZ47aUgRD4wktYBOe090yaSP4dr9kMstXo0xCynXngDQydnLH1hY+mdIwqc0voky9kDINpaTSWjRTCo2ZEkOx8Sm40ex0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by BL3PR11MB6361.namprd11.prod.outlook.com (2603:10b6:208:3b4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.17; Tue, 30 May
 2023 15:51:18 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::bbe8:5390:54c6:b0e2]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::bbe8:5390:54c6:b0e2%7]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 15:51:18 +0000
Message-ID: <549bd3cb-d0b9-2440-bdd2-5dbf530afb74@intel.com>
Date:   Tue, 30 May 2023 08:51:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH] dmaengine: idxd: No need to clear memory after a
 dma_alloc_coherent() call
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <dmaengine@vger.kernel.org>
References: <f44be04317387f8936d31d5470963541615f30ef.1685283065.git.christophe.jaillet@wanadoo.fr>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <f44be04317387f8936d31d5470963541615f30ef.1685283065.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0006.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::19) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|BL3PR11MB6361:EE_
X-MS-Office365-Filtering-Correlation-Id: 0002a483-48c8-4864-1065-08db6125b513
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3h/q6gs6v1H9UsXSIy9kyc8J4aZt/LWzqP7dlcriSzsCnWioU6+0TOM83dPc1ZgA4037H9EYb23fVawb/EXjm45DcMcvdk2ZriOObCDNokl71JzQ1olHylD4Wqmkv8Yhug6EStP6qd9q+NP9LQYKSffolJQlPhcmGl9XnknGqBv5YR1SCeYihN/h9o7Xp2DoWmALyDx/up+gewSuC3auaKff9rhu6qGxua2EwdqyjF4oqo22fvf9MzudX8b8ZG+cBBGMI3xRNJ7TWvVyCaiMHJEO0DFFMn9XQgeZlmleQ8Ha55mzaplsjrSDaFXYvv8buaCIZZBYo+Y/K59tpXzkLJBNUR5EpWD5/RIGq1HU7hlhA46Kmdu2ZwyMwowt5g1BH4ZzpN19/p5UXMRE05gPNMBzf7ywQXF93BJgrcxisAtuLdOpWR3faRLT7cDQrr2RwQWn06oGxglLJX0cVXBSo5wKAcRFkwjK+1PPqvufC/8hcLeatQl2v8WOmRQ3xOaE77G66gEFjOkX7RfMob4HvZwi5IK7ewFUqB7KR6juTLNLu4TcTPzpAPpv+cTHqHoK1xBRJyLGNdMSVQRluo1DS1u9KuedKxbxYdLCzEUaP650mMni6CgAqVVWxQPcO4qRAu77acsrN2W8khetmWjseA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(39860400002)(396003)(136003)(346002)(451199021)(6666004)(8936002)(4326008)(8676002)(6486002)(316002)(41300700001)(66946007)(5660300002)(66556008)(66476007)(6506007)(26005)(6512007)(478600001)(53546011)(31686004)(44832011)(110136005)(186003)(2616005)(2906002)(82960400001)(38100700002)(31696002)(86362001)(558084003)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVJvWUJweHlDVFpJdUxCdWg4cld2MDFWUmlZN1E4ZVQwME14U2FFS1JveXp5?=
 =?utf-8?B?WmwzSlk1ZWtURlNvSGRjclBmNjVzeGZnR1ZBeDVKRGNCRjNnVm1KYndUZVFj?=
 =?utf-8?B?YTR1N0RHY1htSUw5YXp4MmlBamYybHRrRUM3ZEM0ZHZ3UEtFejM2M0hwVlZr?=
 =?utf-8?B?UHRsUTBjSG5KMHRBU2xGUWpqdFJYUHdFeGRPMUNOS1I4M2xmcVpIY0pxaERv?=
 =?utf-8?B?QW9MQU14bkVPZlBrS3pqNlIydExhQ1VZYjRRcEVKRzIvR3d1YmF1WTZjcmpy?=
 =?utf-8?B?dHlrSFZJNmVOTjEzT3VHdjliZDdwSldVcjRrME42d2c0ajc3bHZ0ZUVLejlZ?=
 =?utf-8?B?NitxV2RvNlFQcDI3QkRFOHJUUEdLVW50cDhTT1IrMVFqVTVHRTZZN3VZdEIv?=
 =?utf-8?B?VFpZemNRSzZlUFFMMWtjQzQ2VUU2eXRYTWVwMlRtclVxM1o2enRGM1QwWHZ3?=
 =?utf-8?B?TlJmcmVnSTRJemhxbG1HUWdRZ3YrYkVNNktZZFVyYU1CMXVHdi9pc1plWndn?=
 =?utf-8?B?UWdiZnVYZFVPRFUzTUZsZUtFcG1ZSEhPZ011eWozclg5bmhNeGgydGJiZjNr?=
 =?utf-8?B?c1d2RmVucERySVlxZnBTVXRUdWw2ZmZGODJveHkvd1JxT0hSeW1TQ1VkWGFt?=
 =?utf-8?B?VDNuRzgyRWZncTRsbHlTZFlmZWNQQVoyK2k5VjNXS3hSK2VCUXpLYjZTUE5t?=
 =?utf-8?B?dTN5Q2tKMzFpZ0hFb1hUSjdLWGJvV2xzT3NNNUd6VWJlTHpJVDlSSGozcThz?=
 =?utf-8?B?Zm5LdEE2SGh2aGVFZlhhaDRvVkRWb3Y4bCt2OEU2V0VOeEZIS3AwcFlQbVQ2?=
 =?utf-8?B?TkRrVWl5S2V2enRpWGliMUpQd0pXY0pSRXdyelhseUhuU2dEay9ocXJWb1FC?=
 =?utf-8?B?Z1duTForS2ZoWkVDSGlURmhqMDlHS1NiZHlXam5xcGNYckZWNkpHaC85OFVm?=
 =?utf-8?B?Qk9qU3ZFaEJabWJWdURMWUFSRy9ybERtUlo5MGdOY2xtQmNPQlFIZFJWcEtV?=
 =?utf-8?B?MTJGTEQ4S21Eait6azlHNUhaY3NSZElIaUc3NlhvRTVjcFpIeVJPRkN0NHBy?=
 =?utf-8?B?VGw3V3JvYnpMWEwwSlVjK3REQlZOTmdJTG0zbzZQL3lWZ0kyb0Jwc2VBekRy?=
 =?utf-8?B?b0hHMGx0dHFwOG5ObXRBOEFqVUpicG5WN045Ri9qa2E1QkQ5S20vNGFlZDli?=
 =?utf-8?B?U1hkWVpJL3UrOUpnRkFHSHBXa1IxUVJOcDFJbW15b244V09tVFhnM0MxL3Bp?=
 =?utf-8?B?Ykx3Ti9DUzVWVFZtOUdlNFM2R05SanR2UGJtTVo5OW0zSFk3djNzNjg0STRX?=
 =?utf-8?B?MDJSRmxTdnBxUlh6d3BZZjF1Y3c2U25NVkJ5T2RBK3E5dmYrNTBsTVU1c0M3?=
 =?utf-8?B?RFREdkNMa0ZtWlFka014SHFNQXgrL1NDK1lLR2FLYXdzWVN3SUFreEJQMWxD?=
 =?utf-8?B?YXNoOE9rTGdialhMc0ZIZkFzczcrVHlNR0tPNllhaWZ5WVhKWG9zbGM0ZDVK?=
 =?utf-8?B?cnh2YU43K1d5ME1tUHI1S1Zjb2FVeEI3WS9wbm9UVzRSWTZnb2hxUlhCampL?=
 =?utf-8?B?UVRnd3A1Q2pDL01sZnJjK0xxY09mWmFJT0lUT0h3cS82QUJWbitnWHR2Zkk1?=
 =?utf-8?B?dWorY09BZWdQdFpUNm5MV3JNdFROSVduTVZVZEtoL2JtdmI0YUZyak9raTI1?=
 =?utf-8?B?c2QzMVdJc0s1d2hZRUI2T0M0MU1QbFBycGphL2F3elF1c05EYWg0Vk1FczZm?=
 =?utf-8?B?QTJQRHYxWUNRUk16U2hTVThJaEpGNjVEY0srTHU5R3ZENzV3US80MXB0QTcx?=
 =?utf-8?B?V2ZpZ2hKNE5uTERBT0ZrY0xIdDkzb0diNXV1R01rcEF4Nm1BTzgzT2hOQ3Fi?=
 =?utf-8?B?cnZnZUVSQW8wbWMreU1tNWtwNkJMSm4ySnZmV0QvblpYOVFxYU9nTWpMYzBE?=
 =?utf-8?B?TEx5bVZtMVRnbkI2NmFUaEhXbVBPUzlrWmNPYW5GTFhKeDFDaC9sMmwwVmxY?=
 =?utf-8?B?THdpRHdaZ1dwSktmYnlGbFdNUDR1TWNoclRJRFpoUUx1eVkydlc4S0VkTW1B?=
 =?utf-8?B?RHZTbmkzOUkrQWlIaXBNWU1oazd2NnVUQUxYVnlQUCttMklhcTVDTmhRbjlM?=
 =?utf-8?Q?UXkWrQDfCLo47B3AyC2E7C84V?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0002a483-48c8-4864-1065-08db6125b513
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 15:51:18.5720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AuIvlhDtP34G1b97ZyP13ZfwABqpAJaPRMQgdCPFh1PKVZjBSwYBQhoPVU6/NdgUm2i++E06O3humKVHg5i68A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6361
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 5/28/23 07:11, Christophe JAILLET wrote:
> dma_alloc_coherent() already clear the allocated memory, there is no need
> to explicitly call memset().
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Acked-by: Fenghua Yu <fenghua.yu@intel.com>

Thanks.

-Fenghua
