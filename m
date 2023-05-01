Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25FAA6F3637
	for <lists+dmaengine@lfdr.de>; Mon,  1 May 2023 20:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbjEAStq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 1 May 2023 14:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjEASto (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 1 May 2023 14:49:44 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BF2C6;
        Mon,  1 May 2023 11:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682966983; x=1714502983;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9rzWcK9DqjDrWrwmkHQj8VIbXvI+W2Q0m3zvpwS5a3M=;
  b=PCwG4Chycp3VIXJS2Sw7icoyEOAPpeY9G+ClC3N2dGFH6yS0e14Pwv5x
   vPjTJLMbIuEd8GzOP4NMccrZnuHTHWUzZp0QbLv/yMtWrDNE49xwA/fJ+
   ro5hH8HTmWorEkLUd3AtHnr3iARRJsl8DDyEvmFWX0eOWFeL0upUZ1JgD
   rPEs1Lu7SCW8tpzWl08hmGR6KwRlJ5ixbv5IijkzDw+CBAEpIdjFf3UYD
   kNf0P7qxSVKZUjsTOb+nPuFfjojArfbRsfRjNyllNsbf8YzmZpzps74rU
   NZ1l4KhesWqLyO9UAiuXOmpOz3NOBDho+noeV4YhBfuYKozJJZgFEvRtl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10697"; a="351182277"
X-IronPort-AV: E=Sophos;i="5.99,242,1677571200"; 
   d="scan'208";a="351182277"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2023 11:49:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10697"; a="728634254"
X-IronPort-AV: E=Sophos;i="5.99,242,1677571200"; 
   d="scan'208";a="728634254"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP; 01 May 2023 11:49:42 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 1 May 2023 11:49:42 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 1 May 2023 11:49:42 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 1 May 2023 11:49:42 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 1 May 2023 11:49:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DIgWOboA9Ngd1U3e0kaP0w7dTkEoELMkzu5aA7XT7m613XqvYV40idQhSr7jx8Ne6Q6h73M/t+3KvgCQi4N26IexvbJ5wh3iUZOsV3moaBJCHqwKLxzopzBJK2RcDV+k5id6Qc5irRLng43SqR2UevpvGSoEXZ0JTeMuZDWmBMIfExozVqzmldQJTyCrTDg+J58GZT0bSY6gmjEs9+lXWIG9kFdSmrIJevOXF0NuLrKrRYimjxXqQfF7JS7hIvBWn5ISq9FpXVq4mfPIUULnKZW0paonNwb1DCyN4T+qzEirubqC+y6TkRtfi6NfkZH+8cgFicRcEbmei5iDwxvcvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VqX7sD7U0LK1yZlFZQ0ID19TykYmfL0DmReuS4eyerg=;
 b=h3ExYDEu7lRSCTZaGX89FjH3hOx2cV6m9SateM3PYdj+9nbNIEOYN28NwWLOiS4Py8/i0DToRsHFZX2bo4xoAsqKlamQZRJSX2zzRpwUB+d7sFySxmIVNCsVH85Q380xNzi6FJrxhs1S9E2974MRWBnJqzS7jorQzK4AUu6IdAtSGRr7PhG/qreaCM5D/grAGY6nmdlxwBGxQfNMAHVjLUr9mf/9MLNr8ODbezMF7FZLLSoosqxVFe/vGetQpX1Bm3OKi1L7oDD3Z/A2/alMb1lcYYdv234dA5hA2HpxhsyERi3hpeXv8uqx8u9x18jlO/v/IflGHtiqe5xqIBoGjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by CH3PR11MB7348.namprd11.prod.outlook.com (2603:10b6:610:14d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.29; Mon, 1 May
 2023 18:49:40 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::bbe8:5390:54c6:b0e2]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::bbe8:5390:54c6:b0e2%7]) with mapi id 15.20.6340.030; Mon, 1 May 2023
 18:49:40 +0000
Message-ID: <e0a2ae89-7656-d93b-bc69-b5c0d23eda76@intel.com>
Date:   Mon, 1 May 2023 11:50:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v3 06/15] dmaengine: idxd: Add private_data to struct
 idxd_wq
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
 <20230428205539.113902-7-tom.zanussi@linux.intel.com>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20230428205539.113902-7-tom.zanussi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0036.namprd13.prod.outlook.com
 (2603:10b6:a03:180::49) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|CH3PR11MB7348:EE_
X-MS-Office365-Filtering-Correlation-Id: 6853e45f-881a-4516-1b5c-08db4a74d1c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1PtAvNHiaVe8UkZbDAqJmqwKXeGSwvYm3B0Kta7Sct74wdCkC4810LN/YqFL7E1i4hVKIRRUqAE2/qFPhudDU+4QX8bz6bk5JjQCZGSiOjpNjWQ6tnTCafE3nk2hFdQXIy/vuK9nAvW4ygbdZbCJLTIU2Ln3e0bsiCPpz3CIGGiI9ZNjMjGE0glQp8A4wLwA5LrJdqSLV2yaPlm7ZoVf0CzNdQAhGaMg3UwxdpAJMQgjiQ1nUde2BXTrHOkIVEUnLij+92lAJGDHwD+1ABRtthFiy4VSWG44JGivoRQdAGe6seezrvBxAu//YSJGXn7DuR16ZLkfpg0yIQhTi4qAjkjr8Be9r2ja+jIqBJm0uNIGKm6f8sNFjz07QnmXV6B+OVrej13+Ejblmq+JUYIxHImPInkXJMsAd/XO8OaIfBYHhpvaImhOQeyygan/VEYebaYcizbJTcvveHnBCBNDggPVpCCWcKoiSWLtIjQDrg/xP9SxbNQDkppmIA9w+Xu6g1rhGn7ts+QS/Owjv/JRhJvkQWXFRFMMtpQdzMXpfPpQte2dj2rfmkgfZaT9jkJZvwzqd5mPDBfhXTc0LZMxgRNLg8QXRTmT/XQ0jwN+SzUjWzOXEU7B5mbYnIMJjCONY7ZFaGL1XV+3osplMr3F3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(396003)(376002)(366004)(136003)(451199021)(5660300002)(8936002)(44832011)(8676002)(82960400001)(41300700001)(316002)(558084003)(36756003)(31696002)(86362001)(2906002)(38100700002)(31686004)(186003)(2616005)(478600001)(83380400001)(6486002)(6666004)(53546011)(6512007)(26005)(6506007)(4326008)(66476007)(66946007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Um5hb2lvQUk1aHl2SjJJQTR5R1d4SmxZVlpBRGZNNVUyWkg4L284ZG5jZWhp?=
 =?utf-8?B?SzhMVllSUm02SmlFaCtTbjQycDc4ZllQRVJnOGNoQVY0d0sycTZnbWRYalA5?=
 =?utf-8?B?V05DN1QxY2RIK2FHMmY1cDhWb1k3MFRXUU43SnZrRWs3LzFqY1dNeEVSWFhD?=
 =?utf-8?B?M2JBMkR0SjRTUFRQVkR6SHZKdzV2cDdVM0wyR3RrZ1pwM1l2cjRFNlNCYWZ4?=
 =?utf-8?B?UUZCbEVSTWZORmdYRlVhbWgxTzR1dEhLS1o1RVlyQisrOEEraUFmYWZzSE5l?=
 =?utf-8?B?cjJvc3ovaUEzZzFBNzIwMU4rUUpGMDFQUVgycEQ4SFpwR0h1MHhYUTMvL3Ry?=
 =?utf-8?B?L2IyTndsK0tSSXZUMWkwUGtqeUdRM2VCNFlBb3I4WGEyeHo2N0hQZ0lYUHd4?=
 =?utf-8?B?ZnE4VTY0U0FmcTMwbm43a2RvQ2dmdmE3bi9jQk0wckRvSHY0M2NXWjBrWlAy?=
 =?utf-8?B?Nko0TFIra1VPUE1ZajZQSGpHaDJZaTI4L1cyT2JGRmFMTFRQTlFiSDlmWWZ6?=
 =?utf-8?B?NHRiWkd5N1F6U2UwWkEvcS9FME1rejFIcmdnMHNVOThTYzNzM08xd0FJclh3?=
 =?utf-8?B?dHQ3NUdMMnphNkVVYkdneVNiREg1Q05zdk5LVStNRC9YTTViR1RCZHlCWXov?=
 =?utf-8?B?NFNrMnB2RU1UQ2Jub3hEQ1JNdUl3bmVzZEhqQ0s2L2phckFRVXJRaXVZQjBQ?=
 =?utf-8?B?L0d0Z1ljUkt1b0NIb1p3YWFlME5PUUdFOTlmcExKSERORi9YanJJMjJScVpD?=
 =?utf-8?B?c3dMMVZJcDBZbGlGTXlUTkx6eVdScEFlMHFUVXFNZjZTRmJ3TEh1cG1UUUJz?=
 =?utf-8?B?ckZOMGQrTi9ucUlTK0p4dEtsRTFxejZ1VjZnOEV2VXp1akZ3ME5Ea2Y4K2k5?=
 =?utf-8?B?RjFJRXFlL010N1lOd2NEbWxMV0JITytQam42eE4wRzNCVGxtbUhoWXcwaDF4?=
 =?utf-8?B?dEoxdzFGVGIwUFU4Wjd2d05ycDc5TnAwQjEvVEdGUDhuaEZrUTRJcXBIY1pW?=
 =?utf-8?B?UFpPNjNObXcwT2VDYVZkT1I5VzJsRG15S0ZaMzlYL0hiTENjaFYxb0doN1lD?=
 =?utf-8?B?VmFjbGgvWnZJMEs1WkNWTXhyMC9DZXZDZnhMR3NqbEt1eVZwMDlpU2V6aGY1?=
 =?utf-8?B?RXJjWjJrUk1zeXNvR0liZG53WlU5c0wrSmYvdlRsM3dtZzRDWWcyb253Q0l3?=
 =?utf-8?B?ZjJhTHc2amZ0UlR5ZEFRN0o4SlhEVHc4QmdrbWwwVmVxc1FqM3RML09MVGdJ?=
 =?utf-8?B?NksxREsveFp6VmFQUm04SS9mbUh2VUJBL3BUMzBDcUhXSW9KQmllNDlmUzBC?=
 =?utf-8?B?T3JQRHdRdXdJMThTNmdFZTlCdmEzQjF3NnFYcnorK1JwVVRGcUx5ZldDa29y?=
 =?utf-8?B?ZW1uUFVoVFVha2xwa3ZoQU96bUFlM1ExQTNpNzNwV0hkVW5QeUExSGNrbGNT?=
 =?utf-8?B?ZFo3RGRJT202WUJoTEJDUXpwMlRERFFxQlg2THhWd3I3U3Z2WGRKVm1teHdX?=
 =?utf-8?B?YXAyQ3FaTm9GUTRROElpcEJwdmRucGt1SWMzUzlGK2tobXEyTlZYWi9RMGxs?=
 =?utf-8?B?OVNHbFVOSmJ1aTFSNkF5d1FmZmtGTnJLSFpTdmMwUlQ3RGNnemhwT0dpU3Ar?=
 =?utf-8?B?cHlQN0JNOHg2MGg2YUp3RFByWEpTYkZNV0xGcEVTb0YxODQ1OVlBMG95bXds?=
 =?utf-8?B?M0grUnJiT2wvbWhjY1VqWDF0TzVYbXA3TWNEWWt6aUVGMUJ6bjdGMHFCQVhT?=
 =?utf-8?B?WkRwR3FqNVpNSkFtRmQvcW5zOEF0ckk1SjNpTE4xS3VSNVNab2JjZzM2RkQ1?=
 =?utf-8?B?aVkwa2RBR3NiR2wycTdIZEZJeGU2d010dlFmaWFERG5RMGl0NGY2UVVxS0RD?=
 =?utf-8?B?QXFydWlJLzVRVllVTFQ0b0psTElxQzRkRVJWc2lVNFcyU0FjSk9tWVdhd09I?=
 =?utf-8?B?TzI1alFQOCtEOVRxb0V1bFFBQWZMRzVjdTZXM2RVMTNaUEVmaWJpWE9PaHA2?=
 =?utf-8?B?b21veHNpanBmcS9jMnB2M2l6dmFDTm1vbTk2a3dmTHRCYzlnSjNXMzhKaGVZ?=
 =?utf-8?B?c1ZMMmltSXhQZzgzN3BEVkdkT3IrRmUvVjhTaGR0ZFk5QnI2dGplUnVoZVFh?=
 =?utf-8?Q?ejDxKYdCzvJKPNNZ84ZVIJ2Xp?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6853e45f-881a-4516-1b5c-08db4a74d1c1
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2023 18:49:40.1579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BKDvvBBhrQgltc+vgD+EwvjAfNuL2h6tchhRwwedyPTO9u1nrCNEf+yUkAwoDIavGk4i+Nrp3QKgtAfuuYCWoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7348
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 4/28/23 13:55, Tom Zanussi wrote:
> Add a void * to idxd_wqs for user-defined context data, along with
> accessors set_idxd_wq_private() and idxd_wq_private().
> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>

Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>

Thanks.

-Fenghua
