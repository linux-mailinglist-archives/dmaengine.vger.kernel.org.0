Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCCB64103A
	for <lists+dmaengine@lfdr.de>; Fri,  2 Dec 2022 22:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234309AbiLBVxk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 2 Dec 2022 16:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234290AbiLBVxj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 2 Dec 2022 16:53:39 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8731CCFD8;
        Fri,  2 Dec 2022 13:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670018018; x=1701554018;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=galUaJEwmi1dsA7dZNo2lr4x42ZoCBOKWG83G0IOj4c=;
  b=EdggGCJFyq4unIWNm4TAbu2hUSpjYbqiMk2TgwcxF4wwqm2rm49v7QXL
   iLmCGT/1Uf/HDExStdLAksLG2B7rwCb+nk7ddqlel88YsohmVhpddpsj+
   BslEa6I0n5bKFqxFo7cuQl5TAxDE9DZ8mHx9JY/ARltaI2/0wEVbwEPp6
   cNoAcKxzCZaC0erNPAUEz+m7AwbJkn2G9KmS3LQgogNDGpmyxSBWkCb9k
   Z2Xq22ZAjIE0rYr3ZGj4HymnRjAkTGASxSXKGqZ9FeZGcai+E14SuW9UD
   lSOW26F3naZM58CoHbL/B6eWUXmVcZ5i8JSiPskJ9tqTmpffSruYKdThg
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="378208766"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="378208766"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 13:53:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="890303247"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="890303247"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 02 Dec 2022 13:53:37 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 2 Dec 2022 13:53:36 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 2 Dec 2022 13:53:35 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 2 Dec 2022 13:53:35 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 2 Dec 2022 13:53:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DlghTEC/gRkGKEnblLyYMTHYVMmwfLCIdbhlVBWTuqiMgjlvd45hC2YmbVLTBbm5R7Zt0+d2UzgkSTin8qKq8GGOKxiJtTFi2kaPiL9xOKhFchkSEuXMRT28bjiaDwErOBfq6PAENXpx8/WN3OGTbbSLwWqBqZsE7QEnIErQ/EFDKMH/xfxvcInyx2kAnLHy9YK1IzdrXofeTNXtzlGzQ0PMj/gAMexstahLVe3jUwEnEcvz7uG6pPbTMWabHgTTSXbDGgh57syKNCLmwg0Ax0TX7X2HgmwlannLisUqij3V8C0DK0DYU6b9QuZvz+KLjgkAslJd3oVoHffyj/feuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xdFTK8qNDqH9eeX3y55VhOY+ELQ9QYPYyBNSYK+JZAc=;
 b=SBLUredDW7xOPi9AphQQn1+DrzeD18gJu4erQseWnWcTYe2cfY+5wbJN+6bFPqcIY5y5heNb/F3xUwVtVstKorA45Krayem5Uk5e1ffOIYUibssuV+x6o8WkWVBTm8Lms2YcaTN1Am0RqXWPidzxa1uKvoZs3ILMbpqDmIWX3ld0Dw1vnlc1dkPJ8P03KkHIGhnF9fy9txb8WhqKMeLnAMgWxlKTIR+9ple3wSQVWQH5qRzAnRJrnHRXckWIChELn36Mux8uOT+4t+CFWmDttX/nDsLPIIiM8Mfh9fsgC4IZQNpJesXIPzQcp4h4CeJbjRg1iTJOYF6Dab5wJs5pTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by MN0PR11MB6230.namprd11.prod.outlook.com (2603:10b6:208:3c5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Fri, 2 Dec
 2022 21:53:34 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::b518:90b6:52bd:bef9]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::b518:90b6:52bd:bef9%12]) with mapi id 15.20.5880.008; Fri, 2 Dec 2022
 21:53:34 +0000
Message-ID: <5bfbb7f0-03ce-0ce9-db94-75b304138471@intel.com>
Date:   Fri, 2 Dec 2022 13:53:31 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH 0/3] dmaengine: idxd: Error path fixes
Content-Language: en-US
To:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1670005163.git.reinette.chatre@intel.com>
 <IA1PR11MB60975EBC4B91546429A08F699B179@IA1PR11MB6097.namprd11.prod.outlook.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <IA1PR11MB60975EBC4B91546429A08F699B179@IA1PR11MB6097.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0030.namprd21.prod.outlook.com
 (2603:10b6:a03:114::40) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|MN0PR11MB6230:EE_
X-MS-Office365-Filtering-Correlation-Id: 41e60e75-3c3a-4198-651f-08dad4afa891
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gAvn8k6uiDE70T3iVeujHP/1WH6gzXQX4gsiw/TTNrHahlvDSsC0mUEgySvUIWmcWnNZe/WxpR8439NxnvzjI30JpOwYCaZGBjhEJa5FFubitwbwuQhnE1WNB/uPQR1gHU0z5eayUC0g/0lomZr9EQkwiPXF1bMO6kpa88tzoXenacu4+5zBfRdP/d0OJroLEci6kznXBOH9dulrKLZLHz8KIFwIgUdLmYU7blMaHzTrrBeKhtra5fWCwVfpl6M/GfI5HbWDrhSz6Tgoi/ofn9Iw1371u1HZbxiL1b6xTaLQk/kZh8/3qbt/tBXflyVHbfcpBXa1FQO3+ulLKd79i193SVeJDeC62Un0i25gv1IrrtpFpqhF6YSTZayC0eOvkEz3dkc2YeiAnxGhiaQmT1ybA9gdKJl2kzgjQJ01WnHnekL8i7rGV31ULBC02xmrZBTNTaJB8Qzy3g/4kvkU4IJo83b9071UYwlfdMNKkNam9zjijC1bEbGAXgUITAn6J8QKzxyDkSndZznsjI0/fMgiYHtnFxk/5uGekCyO++mOoDGwgos12nmkBBpSM/NQb2+6BPBZdw8Y5w0iPgK12XUj05TasWt59WmQIk1++GQodfm/PBTF84X7Qwut0qFmFPmeAfm1Z1wVhZDvY2K8vHSQlxWTJoGiujQqnWQBJX8qkhv53zfzBdL9KWzTN4tlFlt63AHRX6wXmZe1iE8UU6ZibPLUxauEmDEoImCf1zI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(346002)(396003)(39860400002)(376002)(451199015)(66476007)(41300700001)(36756003)(66946007)(8676002)(4744005)(5660300002)(8936002)(44832011)(86362001)(66556008)(6512007)(31696002)(186003)(26005)(6666004)(2616005)(6486002)(53546011)(110136005)(478600001)(4326008)(38100700002)(316002)(6506007)(2906002)(82960400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clFPSmYrZm1vWXZYTnZXd0JJSkV5Z2dyVDNsQW1NRXFPQmZXdlZRNlU4MlJw?=
 =?utf-8?B?TWl6QjFEc3BpdXA5S2xQcFF2WXRhQ3hmZHp3UEZKY3NUbmxwZDZmYy9hMlZk?=
 =?utf-8?B?YUs1RlBadUhURVFrM2ZjcE5MUWpRL3duelVkYnBkeXQraXF0TXMrRVMwZXNE?=
 =?utf-8?B?NHdscXc2eUpJaHh4REdhTEdxR0N6U2o5MXovN2N6c3N2SktZbmRlL0NYVzlY?=
 =?utf-8?B?Wkh2SmVYWWNLWVUyNVlWSDUvWUs3K0x5aDhmK0lNaFRQc09vZmhpemVoUWJU?=
 =?utf-8?B?YkJBdGluWXdqTFFDTGlTbFdwV2sxb1dEZlhXMTVBWUtsamhwbGJJMEQrb0g5?=
 =?utf-8?B?cmx5eXVZRHNVSGVDNjdnOWtwWkFhY0h2c0p5cEx4eDAzVzlwMUxkWFk5TzQr?=
 =?utf-8?B?cmlHb0lIMHp1MDBUUkVnNDZrdGt4UmxwNVhmWGNtR3Rmc0ZMcGhCcGlzVWgv?=
 =?utf-8?B?QUo4VGJ6WUJXeTJwZ09LL0FjUUx0RlJGNGJqZmJ2RWxpL3FKa1ltdEtienB3?=
 =?utf-8?B?RVhvOTNlVFk2YjIzdWNSMjNyN1B4bWxzbDVQbzZoVWk2c3BSTVZkVVhHVmZ1?=
 =?utf-8?B?WFU3RURXRXRVRmp1WElTQzBmNURzU2dja1lIRGxCV2ZvcmY3RTdZdGJ2OGEy?=
 =?utf-8?B?TkFOcTduRlJOK2pZV2lpL21KTi9POHlZUmpjR3Nadms5WU1sam9FVmVZMEpT?=
 =?utf-8?B?ZE5rWU92czQ3aUp1QlhQeFJaRENvbG1SRUV3YlM2OEVDMnRjQi81Q3J1VHlo?=
 =?utf-8?B?THQ2WE5vbDcvZUt6REdleGdxMHdDeU1FbVMzcFpLd09HWm51Tng3Z01xYXcz?=
 =?utf-8?B?V1p6bjdhcEtvK0Zya1ZZNVE3dGFiWWtvd1BQdXdTY0RNRkJyRzk5MWV3TEFl?=
 =?utf-8?B?SmNnV0hJc1daVzl0YVNoS2NuTDl0cXpoakdsZm9DZitwbi9QMU9qOU9HQ0x4?=
 =?utf-8?B?TEdzZWUyQWRvSTFUeDhtUXBwNGdVRkRQb05PK2pCbFgwZ3VFL1M4ZGdoZk1U?=
 =?utf-8?B?ZUxaZ1dCdXk0Nk80ME5rZEcvZmt1MmdRTVBZenNnTUJ1NTEvTW1oL0thc0ZS?=
 =?utf-8?B?MHRoQmowcitoSS9qU0QvSGFRaXJFLzdXNmJ3d1U4T2N1ZTFlWDljcTUwR0ZR?=
 =?utf-8?B?L1hySExaZG4rMGt3ckVIeDF3ZjRYclhER2lkb2JWZzFTRkNHdm93TXdnNjRT?=
 =?utf-8?B?bERNNkRHU2VRSnhmVXVjT2lGSm1sYlE3VVc0ZUlja01KVWdSQlpPL2VWTFBN?=
 =?utf-8?B?c0p0QXFad1BYMC9BL0laNVR6dElYOFVPSFFLQ0RQZTA1c3lzdzVLM2oxN0hx?=
 =?utf-8?B?cG5JMnpmOVowM0Q1VHBqYmQxQ0Rkampla01lYWlhUGVERDZSVFBURUZjajdL?=
 =?utf-8?B?K2xGam5LNDYvcGVLdk11ZDFHZytTbjYyZTU5V3pBUmZ4RG5EUTZBVm44Qkhh?=
 =?utf-8?B?bCtSengxMTROK2tRZXd6WlZ5aXhMaHRtU0Q2MW91UE03K0x3dGZvNlVqZlV4?=
 =?utf-8?B?R1BPNUdYcVczeVN1Rk1IQzc0L2k1RGt6TUw2WE52Vis1TlBoNWUvSWRVYmpl?=
 =?utf-8?B?c09xZnZTbml5aTE5M2pUbHZ2NmEzY1I3T3ZwcGE0K3p6TWRkTzhvZGJacUtm?=
 =?utf-8?B?NlF4QVVqRy9WL243SXd5WHluMk5Hb2k1TytQaUN6eXhVTXlkbEI5ZWNxRDBR?=
 =?utf-8?B?T1FNdGJ3WjNaZnBGUk1KemFxV2kvbUpMMGVpckpjdXlBY1RBZ3VHSXZsbCtu?=
 =?utf-8?B?RnNIelpQbzdtOG5oQlM2RmZyNEJiWWhSWHh4bDgvdkh1T2p5Q2dvdHlNMGxu?=
 =?utf-8?B?Zys1b3EwcEpWdnF6MVAxY2dpOUtDVVA3eDc3Y05ab1JqMHA5bjUvRWJHUTVk?=
 =?utf-8?B?bS9wcGhvVmpUaUdJNE9JWDIzYXhwZ3JlMlhLVFlWeCtoVGFrcmhvbTdpLzdx?=
 =?utf-8?B?V2llYk0rODJPcUNncXR1VjNUMkd5aUFSM2lNUjBlRkpsb3JGSmtTdW52M2dJ?=
 =?utf-8?B?Vkw5NjhaU0dvR3RmdHYvM1N3clBXRDE0Wml2eGM4VjkrbGtNTUp3c1o2ODdX?=
 =?utf-8?B?Y3gvMWFiTVpuVFdTK1MwRzBBalEvZ2YyY3l0TWE1MjhOU3d3d1J5ck95TTlZ?=
 =?utf-8?B?S0wzUFZTNnFJSFVwVGE3K0JsV25odW42RmlPanRscjd2dmlsWnhvS0ZqZ3g2?=
 =?utf-8?B?bXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 41e60e75-3c3a-4198-651f-08dad4afa891
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 21:53:34.0062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V1OPa+G5VCuJ3RsX4bl9e0m7e+18e8C4hVpOsi6uLASmVbifZxIlsz0zPxwtkt6czi+Ay3/C1vTC5o1vlNH5ltd4N+JmSDX7fAg+j4du4PE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6230
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Fenghua,

On 12/2/2022 1:32 PM, Yu, Fenghua wrote:
> Hi, Reinette,
> 
>> It is not clear to me if these are appropriate for stable so I am not including the
>> stable team. Please let me know if you think otherwise and I can add the
>> necessary Cc. With the refactoring through the history of the driver I was not
>> able to identify a Fixes: candidate for all. Patch #3 does look to be a potentially
>> complicated backport.
> 
> It would be better to add Cc: stable because they cause series issues.

Thank you. Will do.

> 
> In patch 3, you may add Fixes: 403a2e236538. This is in 5.16. 5.17 and later support
> SVA. We don't need to backport to too early versions.

ok. Thank you very much.

Reinette
