Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61BAA6F218C
	for <lists+dmaengine@lfdr.de>; Sat, 29 Apr 2023 02:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346890AbjD2AOZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Apr 2023 20:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjD2AOX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 28 Apr 2023 20:14:23 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8C3B1;
        Fri, 28 Apr 2023 17:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682727262; x=1714263262;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5WPonNcfP6frtutxxZwghbVg2P/9H0T/f0zn0U+h8S4=;
  b=GHivXq+IJkXWgWowbR7Cd/soZa+kk/Z1KHecjgVA/hWYPQ9FO2wL1pTw
   vAl49nyxEjrknD73b35c9b3PtMZT3orRUS/vhkOgKmtUe1ANd4iej9SUA
   F+1vuaa2z6oaY0ps56YQ5qnUYjM4Y/QRo4ED2xAMREeplGQJlbbazy3Cd
   5iXua3WJeLmcZ38IL7nEz3N++Qzh20f9sh4lFbJ+/DovxmccDmYXvWzeV
   yXg8nGiZdjYWj2uUtJO0tyYdyqemg2BGQqHPczwjhOonjVtqkfobIIaNh
   OVG0HS5nUd2UDjhUKBqBUesI1N8kUs1z0ItaEL04XYWumJlSXdPLJfGXL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="434176809"
X-IronPort-AV: E=Sophos;i="5.99,235,1677571200"; 
   d="scan'208";a="434176809"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 17:14:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="694994936"
X-IronPort-AV: E=Sophos;i="5.99,235,1677571200"; 
   d="scan'208";a="694994936"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 28 Apr 2023 17:14:21 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 28 Apr 2023 17:14:19 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 28 Apr 2023 17:14:19 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 28 Apr 2023 17:14:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EtLQEVgmnCJs1XCWMtZ4O6PnXoHe9HOaJ62ElrTp6eMbv/Shaz6z/pW8ZWYlNbrzY5ccypGQIzFhATN/NnveaDpTYEX6h5oWnP0Wa4rohwwgQtQ4FYcXUmBf08DzlcARZptCPXUnfEkZhpHFCw7pSYg/hKixAeBaSrH7nYnxZ/2zboD8G8O4CVoIT0XfhuJaPh/bEC3ufvbfwOyHCvp1C5sMVU06uGK5N4wT1HkVOMSuwWI+fPmIyg1MsfXnemZM5Y5QArNX7/S7fNGuZTz5TvAorB4TVxdbxk8x0dOBdu+qCFdmzGAWkw3BJhsI1RVLYoN1jyT8RLYTgtuIY2algw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZhyQMc/g8TBaax2QTz/x+cVA5C0bhqPs9Ss1uegogBw=;
 b=bmi7QuzaY79FyAnlnVcIiF0xPOI5uchFu6XyHXUiCuDs6RVqUSHYCpwlxwx4RUeJInAxpO7ra81MhFFnyWm2yUqMbsgmkEgXlpqpRJ2M1usIsatDqHUUdNYp8+BFtvkSy6Tb14elygBesoWYFW4iNxaZ7Z5u08KmFJG3S/Ip8jGPFc3Dxd4xNbcHvA5Jb/uquHLnQ0sknFTR/wvKnv4HuLEZ2MA5ZwbOsUeqRpRWBBML4vAYzB3jHrGJ04JUNABHBfVxD5J+KpnxY96mz+9Usp8MbzQFyOnui1j21OMiNAsqSEXPm81SIJkOWIR9dpUTa554fFPsSXsf/eTss7x0Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by PH8PR11MB6683.namprd11.prod.outlook.com (2603:10b6:510:1c6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Sat, 29 Apr
 2023 00:14:17 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::bbe8:5390:54c6:b0e2]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::bbe8:5390:54c6:b0e2%7]) with mapi id 15.20.6340.024; Sat, 29 Apr 2023
 00:14:16 +0000
Message-ID: <d886d1dd-51c8-d2e6-940b-9e5041707c6e@intel.com>
Date:   Fri, 28 Apr 2023 17:14:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v3 01/15] dmaengine: idxd: add wq driver name support for
 accel-config user tool
Content-Language: en-US
To:     Tom Zanussi <tom.zanussi@linux.intel.com>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <vkoul@kernel.org>
CC:     <dave.jiang@intel.com>, <tony.luck@intel.com>,
        <wajdi.k.feghali@intel.com>, <james.guilford@intel.com>,
        <kanchana.p.sridhar@intel.com>, <giovanni.cabiddu@intel.com>,
        <hdanton@sina.com>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <dmaengine@vger.kernel.org>
References: <20230428205539.113902-1-tom.zanussi@linux.intel.com>
 <20230428205539.113902-2-tom.zanussi@linux.intel.com>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20230428205539.113902-2-tom.zanussi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0292.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::27) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|PH8PR11MB6683:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d78147b-0654-4e70-bb83-08db4846ab70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r8v/wWpCJBMGQLM9rzN0gx5QjwbADEleuZsG6jL8T+CxGGsd7sULz9/GdK+3KVnh2zw++d/xIzOQdytsM1WGFuWZ2pBNlZ/vva7SpFLdJmmP1kB9VUiStIlqw06k/aMYBDIbb0pHM9D0cK8d9jLkw/8J1b8wvhVNMCSJdIPaVRBvIt9SD4HzbmD16mSMR6ZMVtDYye6hHIZW6lkCX5BjLzCi9qPhYHDJMbJKO0aAmSIRYf9Z2hU6f+yHcF7mBWAqUlfXrq6S7La53RHS1u8CjJLHUzEP4+aM5tn3cvGobsgd6WK0ESMv74YDWOHv5mQzis1sx3dURCacZcOpVVdxqgwvAH9kfnnCZRtm+4qrY2YGfOGbTUyyIqE5jRMJ03gxLP3QKApoHCUPp7VFYo30BN9dsYgJEIqP8GK0u7ZeVdYIF6TKt9BY+JNJrt4f3FqLrz45ORLDhToEJVpv3eSE483iH4MTxktfuLySE8hSAKi+0p+cM98BVJ5BXSew7CgdWayevIRAXv5yTB1TqV9KfU+R+MUmNnaKozhCMq/4CfnGt8+8u2DiMdAOurv4sCBYFm+FbYr7C7L3x7q55dHMtBS53uX/Cguc4D8cpI8cjt0pvMk/1KzVBcLu0PdknKj+r4cWe5ruKt0ZhgVBY7OAcg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199021)(86362001)(53546011)(41300700001)(26005)(6506007)(6512007)(2906002)(5660300002)(8936002)(36756003)(44832011)(31696002)(8676002)(4326008)(478600001)(6486002)(186003)(6666004)(38100700002)(31686004)(82960400001)(66476007)(66556008)(316002)(66946007)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTh2RUdFWGRXYzF4cEljb1gxWXNhSVBUN1hTVEtkb2hNU2RTc2NKcHdXVnVM?=
 =?utf-8?B?TnczcVA3QzdoRjAxcGV5eXdBZUFHZldPS0p4RXF0Ym5jbVVWcnNDU1V1dzI3?=
 =?utf-8?B?RTdGaExoMjdIcmRPaCtXYlpZSndIeDRWU3kvWUlpN3p1dXhKblRVV1RMV0dj?=
 =?utf-8?B?SGZ1RXlJZHVzaHdxY1Z0cjVYYW4zOTJiR3N2bk9tOWV5WWJCVkxKTnhBdnRW?=
 =?utf-8?B?VHBmQjd0TU41VGlJOXJCNjlPWkx1YmNwUWZCNko1ZkcwR21ORGpodHFUdmNr?=
 =?utf-8?B?M0lXMEt0bEN6YlZmQUZpQWxha2thMWtyRGFKeFpQUk5xUlJXOVFwektqVjNx?=
 =?utf-8?B?bmR5cnpVWnB6UTV3QkdXU1NHUkNoalZMRGFXL2U1a05yQXJ3QzFVclpTYlJK?=
 =?utf-8?B?aG1ZTGJacVh5N3Yzc1p4OVpnL05SRHplMGtpaDExdUJEeWlOUUI1RUQ2VXpS?=
 =?utf-8?B?YjM0Sys0OEgyZWhRYXFSVXorM1ZmbDFFM0JocGthc3E1RG9xV2hraitpczRj?=
 =?utf-8?B?NE5uS3U2cW0zMFNWTFcydFBTZE1XYlNzZEJLbFlaa2dkSVNRd0w0Zml3YkV0?=
 =?utf-8?B?bmVaY2R4NExhWTRnbEVkcWN2anE3NHZ6RW5qcVA3MldKU21hYnRPeFA5T2Vw?=
 =?utf-8?B?ODQwVm9SYkJSTjFuWmZJOS9QVS9EenREQWNGbUw2Z0V5T0M4dnJYZ1VMaFlY?=
 =?utf-8?B?YzIyV0ZoOGc5dVphL01OZEh5d1R2c1NSMzBmVkQ5VFVuZjlEcXBZVFNWV1BL?=
 =?utf-8?B?L25uR1hyV0xINXg4TmZuZmg0L2h4cDNjcTFCb2pnQ01mZm5ZYjBrSngzcVBX?=
 =?utf-8?B?VHZOazJVL3BzNUs1R0x1Njh2WTVmTzBGem1kSWlpOVo0aTVkaGNJam5LOG41?=
 =?utf-8?B?MkNUS2t6ZStWTGErY0JEbFdrcUtPa24vZEt1cmViMzdlSmNRcDRGeUozeDNp?=
 =?utf-8?B?NWFyRXQzNm45bUJyTTZTV3hPQUxveVQ2U09QWnlSalVoVW4xcTAySlRJQVlP?=
 =?utf-8?B?YVJqU1U0Uk9aKzM0dmZUbkdzdUpyeEZjdnIzc3FqZm40U1JWamQwK0VoTGxP?=
 =?utf-8?B?UGtGTktSZjVuL1p1T1hEY3k2Tm1rUDBKUXZkK3ZRTWxFQjBFeVhwWER2TWE5?=
 =?utf-8?B?enJYdWlacEtqZWpzaUJMTjJ0U090NlRsYXZFRkZIekd0Wk5oTzVtOTFzU25h?=
 =?utf-8?B?YU1FUHFVVHE3dU5xN0E5WUFBc0VxaFJ0MVlYTElEekxKdXpuZThKcU9QQXl5?=
 =?utf-8?B?V3V0QlVyQytFOUFGUURPV0t5VDIxUEc4NTAvb0F0cWRrUUpoclVNeDRFOFI5?=
 =?utf-8?B?UWJITHpuazJ1YWovZVc2K25rYnJibzdNbmdVNjVGNXlBdkJaZ3RkRHRWaG12?=
 =?utf-8?B?NjRpcnNGVWw1b2VSaTB1WjJqNnZwYjdXTWFGWFgwMFNLNG5xRC8rTnZRS2Va?=
 =?utf-8?B?b0dQbkJ0ejB1SnRMTTF0M2JjcmRQVDVaNzZnTStuUWpjc2FrRXR6Y1R1QTQr?=
 =?utf-8?B?VFg1dmpiV3UwOUtWZXB1cGY4UXVKY21KRkhKRHY5Qkc0VXZzOHUyMytRZWp0?=
 =?utf-8?B?OGpKMXBZeWliNmJqeUo0SGVJUVBQM25TK1Q0QmtuNm9Rb08vVzFpMzlCTWJC?=
 =?utf-8?B?NTU1WVF4OS8rZytkOUdWZ1Q4UEJGa3hkK1BlSnRrYjc2c3E2Y0FZVmNEeDVt?=
 =?utf-8?B?K0Mwc2Q3UkROMmdzWk1GK1hFZE9zWGtuZWthTXJaYXJyeUJKd01EQkdvTThP?=
 =?utf-8?B?UTJObUlLam5uK2V0MnRZVlgveU5iSGdjMGJaME1VMUJOZWVoU2VIWVlQMVFo?=
 =?utf-8?B?eWJ2dlp2cHRjSnFXME14aHVrdVd2VzFRbFVIODAwNzU3MGR2VFdVT1RGdjNF?=
 =?utf-8?B?TTlCZm9KSERPL1o5Y2NJcjdBQnFNdUtFR2V4dGsvWkRKMENrdldiemdxazRn?=
 =?utf-8?B?OFljb3Z6T2VlN0c3L1ZPSTRhVVY2Q0tLd1hwd3JERFBtY0wrM1FRR0E1UStN?=
 =?utf-8?B?NWw1d3dBMFJEbkJpaWo4NmpuK3ZXMXJac1phRWUwRGRtRzdtZGYxUytLRGVw?=
 =?utf-8?B?UU5tMHN3MGQ0VlBMc0xKMjRLdHNBeTMzbDlZOWNwcEdoYVRYTGNxNzZHMEpS?=
 =?utf-8?Q?wn9vMGN83L9+v3JZeoOh6bMsF?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d78147b-0654-4e70-bb83-08db4846ab70
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2023 00:14:16.6508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LpcCgUe9lxRFwtTh16PNF0wGoaNoQmINw4TyTJrNzHfQ1rBoc0KEKujOrDwuV1DMLlsNLl2si1E+ChRHtkijyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6683
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi, Tom,

On 4/28/23 13:55, Tom Zanussi wrote:
> From: Dave Jiang <dave.jiang@intel.com>
> 
> With the possibility of multiple wq drivers that can be bound to the wq,
> the user config tool accel-config needs a way to know which wq driver to
> bind to the wq. Introduce per wq driver_name sysfs attribute where the user
> can indicate the driver to be bound to the wq. This allows accel-config to
> just bind to the driver using wq->driver_name.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> ---

...

> diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
> index 7ced8d283d98..505118fc19de 100644
> --- a/drivers/dma/idxd/idxd.h
> +++ b/drivers/dma/idxd/idxd.h
> @@ -214,6 +214,8 @@ struct idxd_wq {
>   	char name[WQ_NAME_SIZE + 1];
>   	u64 max_xfer_bytes;
>   	u32 max_batch_size;
> +
> +	char driver_name[WQ_NAME_SIZE + 1];

It's confused to use "WQ_NAME_SIZE" for driver name size.
Maybe it's better to have a new definition "DRIVER_NAME_SIZE"?
BTW, WQ_NAME_SIZE is 1024 which is unnecessary big for storing 
driver_name[] in the structure. It would be better to have a smaller 
size (e.g. 128) in DRIVER_NAME_SIZE.

Thanks.

-Fenghua
