Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 813E06DFCED
	for <lists+dmaengine@lfdr.de>; Wed, 12 Apr 2023 19:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjDLRsy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 12 Apr 2023 13:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbjDLRsv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 12 Apr 2023 13:48:51 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91CB5FC2;
        Wed, 12 Apr 2023 10:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681321728; x=1712857728;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0lxne3zYl5BY3WvXzGdIsvRpaboZRt2CwLFg5V+U0Dw=;
  b=nInM8kdBjsiwolZQNtnqvH/DOUOIGKW7W/OHDqSVYAsCkVfkKlJEDmye
   2uuOcY5uZUIC1E9CzO85Knr9krUCkKqF9wTxemyz789pDq1sKa1GKB1MG
   3dGvnL7aJxYYD7jw5wELXyZEfauMaUSWLX/U/bR/8pJOGspkTlMLTNN4m
   zMmQu5WDzepuiFH5Nf22iwfv+Xlo8SnhjDo6C1D3Oy1EFd5JBpVE3eqHi
   7em/CZmcIWtBD6DyKcsORGb5K607RQpgpq0k2zg5hrUq+tPUbcYrAO0+I
   3DxjL9O+FQVZXLFsCFGqCe2np/iTo+Z3bCbbA3JDamGIxij0AqvnPrR/g
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="345762028"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="345762028"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 10:48:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="758331792"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="758331792"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 12 Apr 2023 10:48:47 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Apr 2023 10:48:47 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Apr 2023 10:48:46 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 12 Apr 2023 10:48:46 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 12 Apr 2023 10:48:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=exUkkZruVsPyJgwXeEr+qsO8nf37F7hlEkmCCsbdK7j116KfX97vo05+/dUGdWQaNAhABTklIy+r0GdmHTAq1QKP3TlivWdQ36vDjkIRZI3AIrM8lwqM17RILKn9gBiFgt9Th4ECW379niA06SGR6yeFX8zjTtWgMps1Q9Qgu4ioyHbdks+zl5ajV+fiNOsiL1FrRUK4EALiQS9RFVqIAR75cwtrLALRtfOWLZbXZIDa1gZF46Zp7bZOSiSoTh+Oc5poDe4wvuHS3E4CuF/q1L7AJd3U6MK0AaBkD5tpL1b6YFBkyUXrBxAqOgacqLTROLzSOKvU4ge3XMMW17ac/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qbK4FIZmM6o03l4Xij964W3rzm+azo0NKA+hxCJkKlo=;
 b=Hl/li2ynGpAtizwlNF+O3hvwSD5DRLtb+bCghBJizN/7+Q5VkJSySdESYvtKDAsNyREwLMrvxMZzIR67msWxjiNbl/KB9uHDewxZFwyiSq5qQlcRdU6O8rSo5ov64TQmev8f1eaXqpzC21SyTIP76yfeJk3QYjIX2jOQXH3wgwaQ/jUqKDt0g8KlY4wpOHTlkkBiZGdMqYdTV5Q1rUh12F77xPmHkLKC1NRLSWdSmtroJdhYsav0Ra4qh1vqmcpk9F04IxlhUzWREGd8VQRcUfM8tDFZDD+ayU/ZHVw51uW9pPtpZx4RN2YOqGfMV6SNFi0M5KQgnvBdfEqXxuIdJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by DM4PR11MB7206.namprd11.prod.outlook.com (2603:10b6:8:112::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.28; Wed, 12 Apr
 2023 17:48:44 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::4381:c78f:bb87:3a37]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::4381:c78f:bb87:3a37%3]) with mapi id 15.20.6277.036; Wed, 12 Apr 2023
 17:48:44 +0000
Message-ID: <0b94a3de-913d-51aa-0916-7d0d4bdc015b@intel.com>
Date:   Wed, 12 Apr 2023 10:49:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v4 00/16] Enable DSA 2.0 Event Log and completion record
 faulting features
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>
CC:     Dave Jiang <dave.jiang@intel.com>, <dmaengine@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20230407203143.2189681-1-fenghua.yu@intel.com>
 <ZDbn9322i2DVpnQs@matsya>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <ZDbn9322i2DVpnQs@matsya>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0335.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::10) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|DM4PR11MB7206:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dabe511-a031-47e1-82cb-08db3b7e28e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: alNtokqpSqhzIjauPrhlKm2fpuqPAlmuwE+sGdcY3x95DvbsJ+Sr2NooVnmUJlYqNvhVOyxKcXGOuSeb3GuuWZOdFyRAYfZ0ZOO40hRI8X1dK8gzeLeRgND98n3v88MxLHbB9WY2u84Lr1l2iq96UaIxr+5eQJE2UuXXZzvuSyz6VbJtOWGlMjKDmCyXHhMEIXyLeCtnO+CNSVH+YkfcO/Z4LhlBDsGyp8ulktQ8A620aXHVGu3ON45MOMBGfxls065nslaehyLp6wlVsZgRDv37mKUP2gaB0n7EJtxJ8Dq/ghIxIcF9vhCM1YBxSRHZHLR3nfjNLj7ciXH/DdxqfRjiTIQ3L/sXWP32ezLwgUKSCX3t7P/BYBp1iJs/2wkqzEuYb48qLr6TV/Wd9CtwSnJXwaw/x/Njg8w6T/dwPLwRygaKgHARngegKz9wlVjTYhCvGtji8R4xpDuWaacpiVd1sbZ7qJYL+1bJT7kYCEAIaJ7uOAF3PyFve2owAvSJVDnzKYMUYh0hmuGoO4u8HXKWhDfdOF8KN+eTz0Au0ZTZcQ/G1Jk56mwAIR1KVAaJheKNkIrRBqpGpGoADUs+oiz945O4/bPC1WaIdynNTUNA6o/Pl2kzoCB5H54SSEFGmc77JO06u2H0MNvpqbGhPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(366004)(396003)(39860400002)(451199021)(31686004)(82960400001)(6512007)(6506007)(53546011)(6916009)(4326008)(6486002)(5660300002)(86362001)(6666004)(31696002)(8676002)(36756003)(8936002)(316002)(4744005)(44832011)(41300700001)(54906003)(66476007)(478600001)(66556008)(66946007)(2906002)(38100700002)(26005)(186003)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFVRL0VKMk5JU1JWdjA2N1B3eTk3UzZWQ2xBcU5zSUNsUGlXMVlIU2p2cXJI?=
 =?utf-8?B?RnJTQTBRWTZHM2VKejZpdTRKWUhRandsODFTcVB3Z1JPRFowZzN6OEZQd3dR?=
 =?utf-8?B?WlBScGp5Q0JvMG5kNUpUekN3L2poY2pmN1dZTjhOeElxdmVLajhyOWdXNFE5?=
 =?utf-8?B?ZGhXQ2w4MXNzQVdicFNYaFJUMStOUDl2VHNsT0dCS29Fd29jM0t1dGhOT21F?=
 =?utf-8?B?VWJOSWowL0ZFaFU1eVpDelJrQ1JPdzd4WUxhQjdISDBheHAraHVvdldIZzZD?=
 =?utf-8?B?aHJoaTBtVjgzVHJiRldESjlQSUVmQnRuVFBSYjZQd0pQL0owSEtHc2RLZnAy?=
 =?utf-8?B?M0Zpdm0vYmxRdFFQWW1vaTVqNjVrM1pCMWV5b3V5SHhXaElZTHhRbXhzWHBZ?=
 =?utf-8?B?YUtCSnFBNWZvRDE5US9CT3RDMzQwU0FlOFIxQUNXblBtdUovNElSN3ZCeVJm?=
 =?utf-8?B?bUxnMW5QR3BEc0pBZ3NxUlFaYVk3ZjhJQXBha3RXbW1LNHRGNDFwbC9oRFN1?=
 =?utf-8?B?R2tjUWFwZzJDYUNqYXZnSHk5ZDdwajFvMW5TYUEvalNsR2VQUHlTSGNlYTdp?=
 =?utf-8?B?Q3BmbEo5UXYvcmg0VTFFdE83aU1jL2xSQS8xREFkY1Nib1drWG4zbmtVc3Bt?=
 =?utf-8?B?OENFeG9VakdnNytyR09FTTl5R0o2c3U0RmsyNmsxK2ozckwxZm54N09JRXRt?=
 =?utf-8?B?eEg2TlBWRDY3ZFd2bzdYaS9qL3VRY3FmTWhXRkZZajd2SFFFVGc3NGM3OTNh?=
 =?utf-8?B?KzlhWDkvc0xpS1liTUI0RHo1L3ZENjBhTE55K1dUdkVVZmlGaWRzcG8rQ3RY?=
 =?utf-8?B?ais5aGtJdnBCemFHZ1EzOThmcDJ5M0NXanJmNXByOC8xYVhWMHRoU1Y3V1RG?=
 =?utf-8?B?eEtzSjNKWTFwTGxMMXAxSHg0aTIvK21HajBSaWlkMERrUXZYMnAwZCs0RGY0?=
 =?utf-8?B?aXltVmNNRmE5UHlMZnJOdkZiOTNQQStFVFBVU0pzTDJHNzdCMXlWaXJ5NGVt?=
 =?utf-8?B?ZG1OcVVPNit5Um5LL1BmUU9ZbkhUMlZyaEd1cTRTRGRmVWMyVFR6S0d2OHp5?=
 =?utf-8?B?R09ZMGxJQWh6VURIV21GNXBOelJocWVkYm1JWVJnUkxaSWhRMTYrT2wwNUMw?=
 =?utf-8?B?ZWhpYlhUOUt5a3hTa212NmlNWGFOaU9CSTh2REVtRm5iWlI5bmc2YWtiRkNi?=
 =?utf-8?B?YU5DMDlKV1BNaUE4WTBhSE8yb0pSY2tJMmVXNW1CRnNKZjZJL2ZJZmlxMG9F?=
 =?utf-8?B?Q05rd2ZTMVljdDZraU1kdFd2d0xTbVFBODdQZzZPNDI5QVNvdTdVU3NQZUdt?=
 =?utf-8?B?eXBSRUlxYkpKVjNucG5PK2RmQmlPY3RQOVFOelBQVGdYaHFrWFF1OWFxVEdK?=
 =?utf-8?B?aldNMlA2aWtwL1h3R1o2eDNhdWp5T3NKSmF1YkI4aGRwTGhORHlNbDA1Tjl1?=
 =?utf-8?B?LzFtYmNQUXRVMEszWTluZG9Rem9tNVk0QTRPRGpSZ3czMFhBTU1uNGJna0FP?=
 =?utf-8?B?b01PRkJPUjQ2MTFzWmJaa0VCT3lYTXFSWW9XVGxXTzNReEVmV1dpSWtXajll?=
 =?utf-8?B?a3l0ZWJteUExUzJibGFNbGIyMnNmTjFGWGVEeE1iRjJhWVZIYXk4WG9mUThK?=
 =?utf-8?B?ZXB6Z2pmOUV5LzFGeE1aUFVCcU5nQVQrTkljNmVqaUlVSHhMenRaZzhNeXds?=
 =?utf-8?B?YThuTUhSbFdNUCtJNktsdlhrYm83K01QQWZLcXdpMndKSzcyQzRVcVhQYVJ6?=
 =?utf-8?B?MmY3RDVWdEw3b2JQeEtXQnN0VXltbThhVE1ZMWZvTWpieWNERUNLNmhibHJW?=
 =?utf-8?B?QjhrVWg2S3JNb2RLSlhaNDFYS09tdkRwQUZ3allLejNmei8vbGkzVVZZa1Jy?=
 =?utf-8?B?UUZtUGdNK3UyMHNZOFF3d01MTmgxcHRXZ0NBaG5OZEI2cUQxY1p1S1RIK2tW?=
 =?utf-8?B?Z0FmM05ESVJlMmJyTzNxVUFVbTRvWXFPbTJXVmpuYS9tZ0V5NDQ5STBPMW5V?=
 =?utf-8?B?MVVBd0JpMGd2ZldoY21JYVRLNkRWZkZWazFOK0ovNXRUZnptcm9DZGhDTnlp?=
 =?utf-8?B?ZmdhM05reFVCR3h6UTc3RSswR2tVa0F6bnRNZU9LWFcxazZweW0vODFYRWNF?=
 =?utf-8?Q?Yqfudsy8PLgJ71EVueChD58/5?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dabe511-a031-47e1-82cb-08db3b7e28e7
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 17:48:44.3888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pGm9S9HhTMqlvDsHX8nIzJmUmt9QSxEMFRjkvF/k55RkSGYwhGwzI7yKF0YKXMyiXNRuQWLtNaQWnNq1nDkTHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7206
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 4/12/23 10:18, Vinod Koul wrote:
> On 07-04-23, 13:31, Fenghua Yu wrote:
>> Applications can send 64B descriptors to the DSA device via CPU
>> instructions MOVDIR64B or ENQCMD. The application can choose to have
>> the device write back a completion record (CR) in system memory to
>> indicate the status of the descriptor submitted on completion.
> Applied, thanks
> 

Thank you very much, Vinod! This is really good news!

-Fenghua
