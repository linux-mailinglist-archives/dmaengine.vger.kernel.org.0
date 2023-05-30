Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3920D71674A
	for <lists+dmaengine@lfdr.de>; Tue, 30 May 2023 17:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjE3Pl3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 May 2023 11:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjE3Pl1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 30 May 2023 11:41:27 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870B1C5;
        Tue, 30 May 2023 08:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685461286; x=1716997286;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kvRJRxjXGOo02BZRRIbAKwSVSIOaEaR4Nzrtexq6Kig=;
  b=kCJM+HXBOg4ja96ShQai+Ahk9KJq58UooSBzlT3vqPQd1G003+6sEVnf
   3EVUD8FhVq258xS3Am/zxL00ffVquJmJLoUL9N3jKkGzz2KC9WhTztGON
   Aba7GkaULIR5RSxNyWSMCpwkTHV5G4ftvqXq1aA8pgnRPcQBG1PJmmlia
   zdgevtYqt/p7GXqNFc31lyUXub61rj78ixkppZxRpk0uYrhUR2DVboIPC
   rEw3qsWEdCIGnl+6IjV2b4DaU7Yev0AFDas4uj2rziWKVFbRgj3dSixxo
   7ZhRSwmnRZPtoDxSXeT13jHzasIJZoABn0qILavlAuYETdZVAmFGnsS8F
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="357333177"
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; 
   d="scan'208";a="357333177"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 08:36:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="880814460"
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; 
   d="scan'208";a="880814460"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 30 May 2023 08:36:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 30 May 2023 08:36:49 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 30 May 2023 08:36:49 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 30 May 2023 08:36:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a8PVugxOs3qfFHkjdkBlNPrHFb3Ek124A4X72BJZzIjXCCLKZLTjfqa9MSQwd+e4lVIsbd/slcJMwgpdjRCkyGz+/XAEht35JRNrCvnc6Fizn4ry4rjssLQDPGnjAiyrkaMHGkkjDp6FjNLTM2lcCSp5driz91Hf5190kl2eDykywjLofBy5t9bsmRnJa0rhZYQM6KDdT3aANRz/YPqg05sO+uSXyBi8gxHaEG3vjBXUNJ0/Ev0WoCODLDNQFmB58Qu/AcJDvNScHQou2uDA97n2sGGMI30oy2vLZwGfFXxqo5hJ/YDeXB2j2+PLBPprrrrgNl/Ow0Dnf6CnpCxe8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7EQC9tzj6u65bDG8mGv79cw0M9QXrpHymkSavyh1KoM=;
 b=auUdVB56hwLuNPBtAbNJMiY5OGOq/tdelKeBkBpOz4TnbqY65rrrRzeigS2nEsV/NdnX1IpoDN8hFarQ2lYgBqnNkYHtbHNOVrNJl0ru8bP9FubReG+ESofB4+LkVCyqWa9ofBkpeSDe+NLsYFWCQEnrqTAFBuL7oYIoWKNHcnin+oJrpA8ECXTo16MryMhIBFd3Kg7lDUkMUnGyOoZVw+wP++7MVthSzG0UkqmYY4wNCUQzCMObcxCsNDrnyptwLDGjr1zpA6U7ZN6ZrTy/huUk6/FnxIG4FFYzQY2kn/uvkcxw+7lZZH2YyNZmryaPdqm17jo1P9Y+P2LGgTLM8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SA3PR11MB7433.namprd11.prod.outlook.com (2603:10b6:806:31e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Tue, 30 May
 2023 15:36:47 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6b5e:ef4b:bd3:36d2]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6b5e:ef4b:bd3:36d2%4]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 15:36:47 +0000
Message-ID: <c2b5dd7c-9aed-e72c-9685-66680885583b@intel.com>
Date:   Tue, 30 May 2023 08:36:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.0
Subject: Re: [PATCH] dmaengine: idxd: No need to clear memory after a
 dma_alloc_coherent() call
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <dmaengine@vger.kernel.org>
References: <f44be04317387f8936d31d5470963541615f30ef.1685283065.git.christophe.jaillet@wanadoo.fr>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <f44be04317387f8936d31d5470963541615f30ef.1685283065.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0006.namprd05.prod.outlook.com
 (2603:10b6:a03:254::11) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SA3PR11MB7433:EE_
X-MS-Office365-Filtering-Correlation-Id: 8924b55a-d066-4df7-44ea-08db6123adcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y9B/Au4D5eEvIThtRfqqj+5wzwh4iG4vNTYu2z4XDQ29hJI2bV3jfAfcTtJgZgygfhsb+sYkyX3lAtuaCLV8iUSlMIG0iMhy6HE1NShw1fxis0Ic/OfPK1JKm3JKpTmDR+1k4jYzNh05n2PB8uZAIH0nSri1ypoCSxvsioMA2X1CcEYq4iZLq+Jyq/iyHXeYUbbyNp3Bu79KOb+qhEcdGvQr7mL6xTJSfA8DfAqd6bQVe8D63NL6wDLEInka3a6vAFm4kUjoHf3PxSBEaQbbctMg6bMq7vh0g9plMa0SVmtgCoXI7DqMOJGUzYadcq3CjcvALZR6qtfe+8HNOukYpgPO38yE1wDG1INUQLiIfWhqfUyGI9taGRoiCk38OQu6TAzGbMXCZMqiHHdNPn75Cc40Fprs1zdlnN37WRE6uIre8h/j91bXL3lOiNEa3SyLkVFS/dyHrJXcg5qCsarCTR30WnbqjwrPK8Z5335qcgh7KHfWZk8+7vkRundnoR+XMtDHsE+KqVdleIcxb6P7cvWyzn8OI7j/+YwyI4ELUrG0WDMc2eknDoicbAlP7dtjz9wUZoYie8bpuRfXGuSvIhISNUoMwK84nNkqO4NkXbrCZGB2z4bWDYLPL1B/Np06vZDvnK/o8mmxXlB2HNbjtw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(366004)(376002)(39860400002)(396003)(451199021)(186003)(26005)(53546011)(6486002)(6506007)(6512007)(316002)(4744005)(6666004)(2906002)(5660300002)(41300700001)(44832011)(36756003)(8676002)(8936002)(478600001)(82960400001)(38100700002)(31686004)(31696002)(110136005)(4326008)(86362001)(66946007)(83380400001)(2616005)(66556008)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmlWZGNabW1VNEhkUFBlb0FqNm5BMEtCN0RvWU92OWR0bEUrNUx4SzhpbnBP?=
 =?utf-8?B?M0p4ZWhPTXZ2bnV4dDBQVEx0SFdyclFLZ0pITWkrNFdXSldMd291NVJreWJO?=
 =?utf-8?B?WUFpR0UrU21mSXBlQnV2Mys2Q2xTUDJaaGlGRVk4QlZGNlpVVHR1UGs0eWJw?=
 =?utf-8?B?Q1krK1pFaGJ3YkFPTklvcDdkSHhEYTBEVGh3clpGMWtLWStEem9FbzR0Q0ov?=
 =?utf-8?B?RG9KbWdkUTRya3JwL2Z5dk9ta0VHWWRrUEIyeGlMSjMydjNQUjloMUZ1Njht?=
 =?utf-8?B?UDRIRVEvcFZ3dXpGTGtQZ1l6dVFDY1hTNTdXaGlLREwzL1htUmFhaG1ROGJU?=
 =?utf-8?B?eFpIbnF2RGdEaVBoWjBaV3NTRkNiUzArZkg4S2FTS1N6TzdQQWxSZEgyU05C?=
 =?utf-8?B?dUdPOC9oRDJvblpVRFYwN3VDNmhJK0FtL0doN2x1N1FkMTRUM1VicTFOS2JM?=
 =?utf-8?B?U3JzeWN3bW4zQUhTNjR2UHREMUdqY2dVRVd3Z0o3c0UraXNvcTZLTS9oWldu?=
 =?utf-8?B?YVA2Ni9rb1VXTWcwSzJ0RVYvY2ZpSUdPT0xHZ3hJaDJJZk9qL1I5cXM5SWk2?=
 =?utf-8?B?NlFzZUdsNTArVng3OEs3MmNNaW54K00yVkpEcDJlQTNva3FLRmdteVBaQkRz?=
 =?utf-8?B?SW95TnpmZHpQNHBJV2l5Sk9nK2FBeGhMRk1CNTRNOXZ1N3Z2OVM5dHF6c2M3?=
 =?utf-8?B?Zzk3ZlViR2ZBZ29lOGZxWnlUV0dKTUp4Y0Nsamw0Q1N5QUcwY2JzdU00ZjFQ?=
 =?utf-8?B?Uk1qQVFIamVHSHhVK1JabGJIcENUZzdlZmwzNkw2OFREUWxmbW9hR2s2RnFP?=
 =?utf-8?B?UmhLZ1dLejlqZUo5a2ltcmVIQ09SL3grTllMTlFDbzlHWDFKcHhRS01JOVNH?=
 =?utf-8?B?TitSVGdveUNTRFNhVE5BOVlKK3RLUytzZGttUlFwQTAzTVVJZWpaNi94dDZa?=
 =?utf-8?B?MVhVczN1MUpJa0pVYzA1UGx3dXV4TEgxY1dTb3o3VmR4TEJhc0JOb2lQWDlz?=
 =?utf-8?B?VGFVM2ZaWEgwYWNXbmxWNmV4bC9ISHdWbXM3Q3BDbXRLbFBhRWFnUkdWc2U5?=
 =?utf-8?B?UitleEpXVGJUeTlyNUZDVEtxTURxSVpGbStyOGhGY0p3WGxqa3pjQjhVbHFn?=
 =?utf-8?B?QUV4NUlOaW5pSGFaTmZZa2s1aTRsZnZmWUZiRTlxVHNITlM5Z3FNeGI3ZjdG?=
 =?utf-8?B?bmtxSy9oUjFVNVJ1ajVqREh3dUZxUEFCQjVLeHEzaGx2T3ZielJGZFg4MDVY?=
 =?utf-8?B?UDJvbWY1L0l0aGZSckt1Sm5JVm9tVTNLNEt0K2lsWmV1c1VoZ2FzMWlkUzZz?=
 =?utf-8?B?VGZmTGs2U2dTeFQ1bGYyYkxIQjRCbTFTa0U5Wm5WZjRBeVpocHZiWi9lYkk2?=
 =?utf-8?B?U21hbmVZN01XZ1psZVFDQmJWZEE4NjZOT29xMXFITkw1L2crRnpRRnlMN3Zu?=
 =?utf-8?B?dmdKRUR2anJYN3VlTDZVS2l3enREaWUyZVVUSU4vdk0zaFdrblYwK01KRFhR?=
 =?utf-8?B?ek54UUtrc24xQWdKck9UdkFHakpIMWxaelQ0cWRtWDJIK1c4SmExdlg3Y3Rt?=
 =?utf-8?B?QmZDS1hRYUpES08rVENqMDRzUm5qWThsMGcwZzFDUERJczJiRFc4ZDNpb0hV?=
 =?utf-8?B?M2pFQnZuS2lZcVIvOWs1WjFtTEhPajlzRmxrT1dDTHVSZU1KWm5jL2lvUnM3?=
 =?utf-8?B?ZzI3L08vVHJUUUNoNyttM0lUVjhac2VPdkJzVjZnVHVMLzZDSjd3THZ4S1Ba?=
 =?utf-8?B?SkZZME9hZDVhclJrTDdGSHk4T1p6QWgzdXNwYURkd25zYXNlVGRUV3hRL3ht?=
 =?utf-8?B?eGN0TWdoTlpBc2lMZ3RRQ284alRaNjlMc1I3SVJBSSs3M1kvTnowOW4vakQ2?=
 =?utf-8?B?Tkc0U1VIbWtnTzJBMzVCbmRKK3RJTmxnTXVxSS91Skhkbmg4T1huMGVYNGZX?=
 =?utf-8?B?V3o3bjR2ZFlQOXFVZ3I5UmxTcVJFZVBLUWVpSnFuR01pemZHT1JhdFl5Y1Zj?=
 =?utf-8?B?bENsRUJUVkNyQTV5aldZcDlheWVaLzJ0dFVYTnlEdHFhRXh2N1lCN2thRXNX?=
 =?utf-8?B?OHZtTG9KaEFnTzNWYTJwb3dqK3ZXQnBkbTJWT2FrSHhuclFnbVkrSjV0NTNU?=
 =?utf-8?Q?FNDZ0KMVrq0hTlLhybvSgM6in?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8924b55a-d066-4df7-44ea-08db6123adcd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 15:36:47.4114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MYa84G8vCpsNSnB9aTeljs5zwFXCt04LwYUjp+NZbVKxx543Z9NhGvUUI+7mIJvY21qr9lWYCdU6A89ZS+NQ6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7433
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
Acked-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/dma/idxd/device.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
> index 5abbcc61c528..7c74bc60f582 100644
> --- a/drivers/dma/idxd/device.c
> +++ b/drivers/dma/idxd/device.c
> @@ -786,8 +786,6 @@ static int idxd_device_evl_setup(struct idxd_device *idxd)
>   		goto err_alloc;
>   	}
>   
> -	memset(addr, 0, size);
> -
>   	spin_lock(&evl->lock);
>   	evl->log = addr;
>   	evl->dma = dma_addr;
