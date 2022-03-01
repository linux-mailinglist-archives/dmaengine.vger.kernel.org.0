Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026D14C978C
	for <lists+dmaengine@lfdr.de>; Tue,  1 Mar 2022 22:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234477AbiCAVIw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 1 Mar 2022 16:08:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233375AbiCAVIu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 1 Mar 2022 16:08:50 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCFE1D315;
        Tue,  1 Mar 2022 13:08:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9w7dedJNv48Q65J2trYmh8B+zLT4fICLb3kY0C/sbbGrItMcv9cFNqLfDoTC4oSHYde4KlU6lJx7WghiT4rmvbmEq8rTbt2ciyiLryfh8T8knxXielsuEU91bMa5aGdvNBpQ/d9ZI/YxeRaxqDIxhqrgOqMqlL+TajYslZ2EavtNonus0Z6EidXSapiTuWhW9l5/9sP8u1cp0oayLcOMJkK0EzMZsc7+HfMTRIYR0nQpx6z4TwQrzaBGYwT2ZWHvREufFDQfxDa45LsicoIVlnvp2GsSk3JJN1V02zuUJvuY8q6IFipLdP3l7z8z3SZqUMGX1JB478l6bWSdzCwhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0zHZTxQ5SrLb7GZ2Gp8PEj3WRGyfCT0SBPDGQeMBbs0=;
 b=kt+boPuZDjeiTdvjKzeik5c+uvxiJDFzTvDKJcKiwgVtt2SA6VaEopHTj99AMg6z1V2SOjjCVzfWXilf9AxZJCxEh1FbvvKqoF9vaYrMKtgDRzEN8uNBgWxqW2wzKuUuLqmbcxGHaprhzYWWnrIc3POEXeviCbC2AGL1O7Z2hoDYSi+1wf5bEsKGuLB6ks16aYKR/ICuyHsjEN1cGCJtHw+CD6ORNP16YaTRnfQpeFS2rmFEDZg3bMps7tNb+2FKiTPX/gMcZbsQuTU1HdpZtR4qMUr5OzaDEtw4ypAkwtjXODX06X2IyogDU3Jh6Leq7cfwkKLNQFgFZsVCb29gSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zHZTxQ5SrLb7GZ2Gp8PEj3WRGyfCT0SBPDGQeMBbs0=;
 b=g12E3Z9Yh3U01imqe05VBV4fgRcxABSA4zKKAJKQalfXgL01WYL6U3LcK9Z85D2R9dX6UVz8RPxIpgacvYPfn33ltiLI5WQ0lxWBSACcdv3WJeSi/G4pJz4Qc9zzspNEEIh8VJplfyRrJhf1ScO7ljJyGIZ5g+vbhv0M6klmBjI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1471.namprd12.prod.outlook.com (2603:10b6:301:e::20)
 by BN8PR12MB3361.namprd12.prod.outlook.com (2603:10b6:408:67::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Tue, 1 Mar
 2022 21:08:00 +0000
Received: from MWHPR12MB1471.namprd12.prod.outlook.com
 ([fe80::146a:ebef:a503:c2bd]) by MWHPR12MB1471.namprd12.prod.outlook.com
 ([fe80::146a:ebef:a503:c2bd%8]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 21:08:00 +0000
Date:   Tue, 1 Mar 2022 15:07:56 -0600
From:   John Allen <john.allen@amd.com>
To:     =?utf-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH] ccp: ccp_dmaengine_unregister release dma channels
Message-ID: <Yh6LLFAf+f48BBFa@dell9853host>
References: <20220228031545.11639-1-davispuh@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220228031545.11639-1-davispuh@gmail.com>
X-ClientProxiedBy: BL1PR13CA0421.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::6) To MWHPR12MB1471.namprd12.prod.outlook.com
 (2603:10b6:301:e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60e8bb29-c400-4451-f820-08d9fbc79131
X-MS-TrafficTypeDiagnostic: BN8PR12MB3361:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB33612D237ADB5207E1487D1D9A029@BN8PR12MB3361.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wEHFOzW6bbpnXVBQBAHF51RYgzZ/bwD05J5Y+SjmYjMMbe5Rl5Kuiq/3IGJJNDE70edJVQ8UWjTSxlqN0TUaQvW2789Mx6AtiyarIzDsBL2qfyfWD3iqQsLPGVLVM/H6FpdyqzGmHrcJhrNsq4YYbikrxua//eUFeRTLbDNlZOMMP7qyoSyOKe3o07ad6729Xij83DMLfvHmJED0WKXnVAe0EizpWfGOfqo5iikpa+varJAOl3iQ8Jd2lUnfVl8Yux/oOVZIXfSLWn5FCXaudkZjgkMNugE+HGos7UePTDE9Xc31Lq3/M0MYEm/8lYlWi5y318IhUchKLD0aKcb1BcW+X93aF43S9fUeUthL1LaBFbVSXFLYI2UN6h/GiVlf9c0xA4qU8DZkt8Go2abwkYywl04oO8a+cUm1eQd8Qejds9mLA5O3OaWQxaE4BP5yCmekSl955G878DeViRMArZTXcTl+rbkvuhFxQm5WbbAouQtTZvxq4Ld+xl5SJAmDT4LxGfdSZKS8VR7yaK1PyYcRc5LrVgzS7q20gUur/QVg6t0BUFZOeQaSfOzldcZsB25XuFnhBVLwS6slhe1JWDUil7CbcJu8c6bp0R5D6tE88Sz5NV/XK31UlVwPkRkCVa84m/KDCqluZc2NeVDP+NjRt81ct0L/83E8a97kD5/mBj9tsR1eHzM2vSBaMugqS8sxkuJ4HYvleidYbRpIjA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR12MB1471.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(4326008)(8676002)(66556008)(66476007)(66574015)(66946007)(86362001)(9686003)(6506007)(6512007)(6486002)(508600001)(6666004)(186003)(26005)(33716001)(6916009)(316002)(38100700002)(2906002)(5660300002)(44832011)(8936002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXhoTnNoaDdESlcybDEvbjBOT0ttdllXaXNtWlV6cWJMdkhIQkt0Zng0a1RD?=
 =?utf-8?B?Um8yWjVzWFVQdmY3czNFdU5GV3JLOEkwUmh2VXRzU0dJbnlTSUp3NldLWXEy?=
 =?utf-8?B?SThSdFRvSU1wY1dBVWV0cWNGN2JUUG1mMmpDL0g5UWlBVWpWMXZTajR1ZnpG?=
 =?utf-8?B?SE5BN2t0VVcrUHBuMVVHbFNJVGg0cG5qc0E5ZFFpaU5iZ1E4aStMWDZVVDh2?=
 =?utf-8?B?allnOFZ6M25ZRHQ1VUhxRnlhdzVoQTFDQ2VFVVViSVhtY3JVVU5jSGN1c0cw?=
 =?utf-8?B?U3h2REllcGo3dXJEZExIUTVuU05ZUWx5ejl0bWRVeUF5MFY0RGpnamIraEhx?=
 =?utf-8?B?bi9IbC9UZjdtVnViTS9zZ0Fva0xMQThHZDcrbEpIVVZjaEJINlZBV1VlVEt4?=
 =?utf-8?B?aHlsSjBCdnh4VXNjd3NoY0tSMUJDYnp1MzdBb01zbTJqWWVESFVNTjVoZVBl?=
 =?utf-8?B?U3lqQmZ6V1RJa2xRcUNXNkZTQlVia2cwb1JNN29hd09EVWRaSlBoWHN6aEw1?=
 =?utf-8?B?c3J0dm16TGZlRVY3QVNvaExBTlk0eFdSY2lUZ1hITTB3UEYrYVMzS2JvMHcy?=
 =?utf-8?B?cUJQYUNoMkY5akd2YktRMzJzTTJyR0dGQkVTTHgzTWVMMjUxWGN3UU1IV1F2?=
 =?utf-8?B?Ym0wY0I3YUlLUnVsM3EvcFZmRG1EMnZYSUZiYlZrOHV6N3dhV2hPWmdHZEJZ?=
 =?utf-8?B?Lzg2V2tKT0xJb3dGbUpjWkY0c1ZSWk4rd250U2NyaWE1eDNneVA3SUYrQ1Fm?=
 =?utf-8?B?bFEvWVRTRFhXOHpEbDlWamxwUjdZNEs4Y2N0K0VNT21VVTZYbWU4TjErRThv?=
 =?utf-8?B?eXZYSjJWRUtNL3pOUmxQSFE3QnNiMWhrbGt4QWFjd0NMQWdnKzNUMWdoMTBa?=
 =?utf-8?B?OVdtV1VyRUcyWHpoZE01d3RBMDZ0Q3QvR0dmUERqblNLMjJXem9kM0d0aGti?=
 =?utf-8?B?MjBDQlhFc3l1TzNkSHY5RitJSi9nTzhLWnNJYVVZQ2syZmlHREkzVTNTUlJN?=
 =?utf-8?B?N0VreHk4Sk82MWxJbDdBSC9rZHVCemVzVWlPc2hQa0hnWHNtUEFxNzBQbjYz?=
 =?utf-8?B?Yk5hbUwza3lMdU5zcE1VdXZwd1EyWjZZOVJRMmtiaEw3MmROT21aejB1R3Ny?=
 =?utf-8?B?eGN0UUE2S2tUaHZTN3l4QjY3TEdiL0MvZjZwTHhOKzdmUlB4QzQrR3NkNUQ4?=
 =?utf-8?B?MkNmNVNpQ1ZWeXcrVCszTkFxMERHeFJ4ZC9BMkpJQVd2SUo2b0dkdnRXZE1B?=
 =?utf-8?B?WmZET0tOMmh4RlZ6WVNNd2NDbm50Smk1N2VQYmRka3FxMmdKUDNaWmNpVCtT?=
 =?utf-8?B?WGpmTDFwWTdiSVdyaVlFdHZNSXdtNTJQU2preVpDcStzRnkwQ1c1SDFzWUxN?=
 =?utf-8?B?eU9WdjM5eGxzaWI5em5FK0JVVU1QNkhRWlRoOFlNUG0rbjZ0b0htWklRaHlC?=
 =?utf-8?B?a1RPV2NqNmxVNVpIUGJGU3BlNWZJblk3M2ljdE9rd2I5UjYxYTJCZ1hockpV?=
 =?utf-8?B?QTBpUGtMSW1ObVUwc1Z4YlBhOU5UbExUdWZsNXFrekZZcXVnZ3cvazBUOTVn?=
 =?utf-8?B?RUZKR3pFb0k1djhtTzNyZEsrdDBFQlBWRm1DTmt2N0xuSDRvamE0aEkzSnAw?=
 =?utf-8?B?RE9MYXdUaytTQnlyUFZQYnJpbG5JYWdya25xc2x4VXhtd1IvdWhPNjU4K21K?=
 =?utf-8?B?K3gzSFkxb1U0QWxlZzNWemdUWlZnM0lKTmpFdklMMU85bGxEbnJoUVl6M3hN?=
 =?utf-8?B?U1FMK1FISHpndWYvNWF5bjIvSExOYm44VkZUdWpadUdjYysrOEpIWUhXaEpu?=
 =?utf-8?B?WUVVZ05CTDBPZ25mQmxiL1FWa3duMnZoazZvT2tocWxsUTNyV3d2bXhhNVpU?=
 =?utf-8?B?Ukd2c29pczExM0FhR1lNMDJSZm5HYklITFY4VWY4bXJudDlrNUkvTERObWd5?=
 =?utf-8?B?T0M2dXBKQ0QyWmxVL1QvQ0dHUXYyTkRBVUtRSU1vN01lQ2dkZnE4dFJVbUxx?=
 =?utf-8?B?YkJhTldHTjNIQmVzeE5IT1ZXdlVQeS9PSmQ1TUdsWkpadlFMYzJQQzJFOUJh?=
 =?utf-8?B?Z0hCL1VraDYxODQ2aUl4Z0V5VlBmVCtPdUl5UDhDRWRMa3hTcWF0aU5keU9u?=
 =?utf-8?B?WDdBdi8yMkwyY2pBOFE4Q0p2NDVlOUtabWtuSlNDbFlKT1RYTDEraWhjRnRP?=
 =?utf-8?Q?zDukMJ80noLikqaGKfR/4nI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60e8bb29-c400-4451-f820-08d9fbc79131
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1471.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 21:08:00.5014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V5+0BPkIwsjg5hAkFmViivDEtIWoyLgWZgfldXPNlxxZD3JSjgf7gyLmtYlOTEw945nVTu3tAo79CojCj3HjZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3361
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Feb 28, 2022 at 05:15:45AM +0200, Dāvis Mosāns wrote:
> ccp_dmaengine_register adds dma_chan->device_node to dma_dev->channels list
> but ccp_dmaengine_unregister didn't remove them.
> That can cause crashes in various dmaengine methods that tries to use dma_dev->channels
> 
> Signed-off-by: Dāvis Mosāns <davispuh@gmail.com>

Acked-by: John Allen <john.allen@amd.com>

> ---
>  drivers/crypto/ccp/ccp-dmaengine.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/crypto/ccp/ccp-dmaengine.c b/drivers/crypto/ccp/ccp-dmaengine.c
> index d718db224be42..7d4b4ad1db1f3 100644
> --- a/drivers/crypto/ccp/ccp-dmaengine.c
> +++ b/drivers/crypto/ccp/ccp-dmaengine.c
> @@ -632,6 +632,20 @@ static int ccp_terminate_all(struct dma_chan *dma_chan)
>  	return 0;
>  }
>  
> +static void ccp_dma_release(struct ccp_device *ccp)
> +{
> +	struct ccp_dma_chan *chan;
> +	struct dma_chan *dma_chan;
> +	unsigned int i;
> +
> +	for (i = 0; i < ccp->cmd_q_count; i++) {
> +		chan = ccp->ccp_dma_chan + i;
> +		dma_chan = &chan->dma_chan;
> +		tasklet_kill(&chan->cleanup_tasklet);
> +		list_del_rcu(&dma_chan->device_node);
> +	}
> +}
> +
>  int ccp_dmaengine_register(struct ccp_device *ccp)
>  {
>  	struct ccp_dma_chan *chan;
> @@ -736,6 +750,7 @@ int ccp_dmaengine_register(struct ccp_device *ccp)
>  	return 0;
>  
>  err_reg:
> +	ccp_dma_release(ccp);
>  	kmem_cache_destroy(ccp->dma_desc_cache);
>  
>  err_cache:
> @@ -752,6 +767,7 @@ void ccp_dmaengine_unregister(struct ccp_device *ccp)
>  		return;
>  
>  	dma_async_device_unregister(dma_dev);
> +	ccp_dma_release(ccp);
>  
>  	kmem_cache_destroy(ccp->dma_desc_cache);
>  	kmem_cache_destroy(ccp->dma_cmd_cache);
> -- 
> 2.35.1
> 
