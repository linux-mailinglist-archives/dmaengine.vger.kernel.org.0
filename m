Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7594A49D0
	for <lists+dmaengine@lfdr.de>; Mon, 31 Jan 2022 16:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240252AbiAaPGv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Jan 2022 10:06:51 -0500
Received: from mail-bn8nam11on2077.outbound.protection.outlook.com ([40.107.236.77]:15360
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235301AbiAaPGt (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 31 Jan 2022 10:06:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LMxx9NOW1LgjVH3hjUnamlylyz7IE8u8O3H38HI+HEWxhAnkan7Sm8zTtj9YAIq3b5gMd1TLJ4O4yNShxwl+JbljF657QIspTIXu6Iou+z3sDRSEFxQ8zq9D/SOwzYjbquNz2cu5JnRK9dBOCvTOkYxWfSnv8/c5m68+CEDSBJcCMbbTkCo/keGcop+j5IQmBpjGcAAjMfdduGeEHD6wbpWSawKY9ejHagg4vCTy+F990IbLQnWQQVGfU3P59FzFqeFloGlkgFWJkxPSSM6rgjSdnBS+x3PDBjgEWu8PeBJDcHHVI/fEyaXbylruyZrdNr0CZjI/9ZbRATCQVg27LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RzDQtaows4MwA/TggZ2/O6YQfAgRZT5PNvnd64B+DKI=;
 b=U/4bkQj2FrJM+ivxLLPOtdU3LGakjQrLaaTfZo+qo8lXGpmGZbHHWSzEzEH680GOgMY4LCBBkw/CifIPdr6+TcK+SvW6VOX6NniSwcfBZECgHNliCDz5y2VuDHwQPO6EEbln6FXtrUDCOcYUGTgFiV3Tha077+/bH2ngSIneV0d0UaoImDehpLrE/qjR3pAfXFyKJ0bZ6m0WA1G6NddZAXGiWzJhc533rkhf/iayDKF/AQMBUVVrfdqwYPycdbZTVtrVETm6Owl7uYJ3nl9GkfAiBd6Dl9W2xv9ALrOkYVzG+9Rmc/NPxNbp7/35DYTuPUhVYqQKQQYKKpEhRoVHPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RzDQtaows4MwA/TggZ2/O6YQfAgRZT5PNvnd64B+DKI=;
 b=OP8pdY42g9y3mghnaG4rvwBHaF6hQmD51wpFAbKy8lN4pZDar5Cl07eyeve3oGn4Hpdutbr18WNjcUFo7cb79ni40oXBacAlrPzj6THjlpC0HxuhwuebRXLLGwlW6fhxcKp3v8lIF39kSrl+nBgfS8OLbDIoxr5phfyohDQe/xc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1242.namprd12.prod.outlook.com (2603:10b6:3:6d::18) by
 MN2PR12MB4128.namprd12.prod.outlook.com (2603:10b6:208:1dd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Mon, 31 Jan
 2022 15:06:47 +0000
Received: from DM5PR12MB1242.namprd12.prod.outlook.com
 ([fe80::ced:a3ff:fb2f:165b]) by DM5PR12MB1242.namprd12.prod.outlook.com
 ([fe80::ced:a3ff:fb2f:165b%10]) with mapi id 15.20.4930.022; Mon, 31 Jan 2022
 15:06:47 +0000
Subject: Re: [PATCH] dmaengine: ptdma: Fix the error handling path in
 pt_core_init()
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Sanjay R Mehta <sanju.mehta@amd.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        dmaengine@vger.kernel.org
References: <1b2573cf3cd077494531993239f80c08e7feb39e.1643551909.git.christophe.jaillet@wanadoo.fr>
From:   Sanjay R Mehta <sanmehta@amd.com>
Message-ID: <f1081199-cb12-bac2-7fea-f4d2e4808410@amd.com>
Date:   Mon, 31 Jan 2022 20:36:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <1b2573cf3cd077494531993239f80c08e7feb39e.1643551909.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0177.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::9) To DM5PR12MB1242.namprd12.prod.outlook.com
 (2603:10b6:3:6d::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e659cb59-70ab-428c-ae6c-08d9e4cb4d2a
X-MS-TrafficTypeDiagnostic: MN2PR12MB4128:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4128616B45F5F5FECBFB539EE5259@MN2PR12MB4128.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V+mK7CD2SdWa4gYEv5IwuzOpwXnzBKLvLdV+61vf0psEqrXU8satZaIyCVx9ILiUA58c22BH/hmFRMmE3jBiqASEZKRcw3jnsPMQaD7NOFjCNkfvoc2VHhBDsB6cLgBq9Ifro1l2mlBvLMzSzSOjaFEHpQwpkoALY0AqtrHNh1i5ypbBQu18GjnHWPe1rDk6icKNSgKqeoS1vZujas0gYxEziRgSFqixIHBiUiBWgBOayrbYqR3yeBM0ZHcUugImmQjTEw9nvKSa6WgfmF6TgmmCBe5x/CUHn5S568EyWWsoLyNC8G4t18Ptvvmh52qNRVXJUPF7ifetaEjBsn86qqrtYVhMM49xKsRCYN8VnTk8FVi1JjsEUYTeiJNUOyU8VgzuGuSDwrmuj7L+UpNeKyYOREtDSOHtmWOKWJfsETPTk0T/iPjXkOKQj3/QNPibLe4qH+7brt/Vnr6ie7U8oxzQ/I39ki6QXkXG+86oVyl4BKh1PANnS9VZ8qjcP/s3HOczvyui+dvpaemXA6XHD/pP+xnaYwVsTb55bE5dFMWzunX7DVn7LIjiFyFzcLOGXc7T/D2bFhjwmN1lm0AwoVwmMrQp2oi+57QH7CUbGybxDJqpomEkZHN2OA5+DsPC28O5JG9cIVB8/6scx9FwiLXhG8fBqeRHrCg4Xa4U6iP1PAo+iKaLe6w6dIHd4CNBULierunlKCm+4X7hcW1aKTiUx1lGKchcpv1WX8ZUw4A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1242.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(53546011)(5660300002)(6506007)(6512007)(26005)(186003)(83380400001)(2616005)(2906002)(8936002)(66476007)(316002)(31696002)(38100700002)(6486002)(31686004)(6666004)(110136005)(508600001)(4326008)(66556008)(66946007)(36756003)(8676002)(43740500002)(45980500001)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2FKcCtCNjRlL3JuYy9LeEdoNTIrSnhKd3VJMFFldVd6Um9Pa3ZLSDhiakRp?=
 =?utf-8?B?RndZWGJKWTJ0YjZINnU1TTdoc3U5ZFVLS0RwcHFocmRaQnNEaTVpZ0VTa05r?=
 =?utf-8?B?dVI0QmFSSk9uVGdaQjlEc0NaTWc3UVpTYll5MzkvYnJDME9QRmNmQ0E0aG55?=
 =?utf-8?B?YitWczlSWTB2cTZHcjY3Yk1QTWlrNFZjcU13Sys1WE1LaDJRNmhlajQzc2M3?=
 =?utf-8?B?Vm1WUk5qbnlHRk1GMThQZjF6ZUlKTXY3M1hZcVB2amVUS0lha1ROSFJQTis2?=
 =?utf-8?B?QVFZSlRQSW5QbENMK2pjaVQxVGk1Wlp1VzczUTNySG1MTUZPU3E2UU50MVVj?=
 =?utf-8?B?NXlUWG9kTGQvdXZBUVBDWTJMUk02UlQ0VHJyVlZJaHhkYzh6ajVWOElIU2Vl?=
 =?utf-8?B?cmVhdXZ1a0pOaUg4bERXNjhId1BOb1llRE9yUUZFRytadGt2YlJxV3Zzb2U0?=
 =?utf-8?B?T1ptUkQxOGhHOXVSd1pQejZiTk5JYmxHdURTQnUxaFRjVkh2WkgwenlYY2k3?=
 =?utf-8?B?NzI2TDc3ZG5zTmdpZnlDZ0tEdUp5S0JadFJzQlFiY2FLZFZGaVhwcElFOVV3?=
 =?utf-8?B?VVB5OVlsaHljNmpjOGFqUGo5ZVJwNnl4b3VqUWlubWxhNTFRMldObEhOcXBh?=
 =?utf-8?B?RmZUVjhVZ1RkR3NlOXliU0NweVhQS1JpU2lTeVRnUm5RR2Q2NDVuV0UrRS9J?=
 =?utf-8?B?VUZKMWhyNVc2dHVZQy9OLzV0bzNzV2hsUTIwTlFEL0tSaUZxUGI5WDJSZmhl?=
 =?utf-8?B?MlRjUUdXVy9oVUJyYzI4R1N3QXlSbk5iNmpoYjZQcWlSQXJqS2tFOTNIQXlv?=
 =?utf-8?B?SzdhK29zSmJRR0dnVGZUcW9iMHhhUWJub21vYlY5bi9Ic2RjYWlGUzdjRHhE?=
 =?utf-8?B?c1h6MTVvTmpicWlCOTZxaFBjK3MvNjVJYkU3ck9ucWR1aU9OV2Jmc0psY0U5?=
 =?utf-8?B?dlduU1NabmhLdXlCQVJXUnBDdU9CNU9uc1ZkVXk5Tkx4VkRzbGlhbllVK2Qw?=
 =?utf-8?B?UVFDaFZEcVBKS2dQWldQN2d5dG5Td3RhbElVcStPbTRFZEF6ZUI0Q29QSE1o?=
 =?utf-8?B?cTZKZXVBWHR3VU1Pb2FvamQ1elBZbDFsbzIyeWUxV09MOElKZ09xekZEd0xY?=
 =?utf-8?B?cUJBKzJ4QWJwVXR5aGZ4dGtaUVNUdUEyUFFBZE8zajBvNXdNVVFGNk1RUFVN?=
 =?utf-8?B?SzJ3N0ZMZ2RocnBEZlJkeEFSM2VKY0svNXBYQlBBSjVHSXVCa0lUT0xrb3NT?=
 =?utf-8?B?ZWVWSmQrSUc2bDQvTG9INEpKTmlFamJxZFJnaDhlVWhPWW5oQ1NPdUZ6cUFU?=
 =?utf-8?B?eVpnbDd0VU9Vem0weWx3cFQyMFYrbDZQZEVoWjBuRmZSWU0wZ05UdUg1L2d0?=
 =?utf-8?B?YjZtdEFHYVlWbkxhQ3NXZVNjUHlFWElqYVEweGpyZEZpU0VjOWpFMEM4dUJ5?=
 =?utf-8?B?ZmxWeEFnQ0FkWkkrMndrakQzL2VCZCtrSGpuZHczU2NkVFNRdml4R2xPMGNp?=
 =?utf-8?B?UnRsamV4WThLWDJlZm53QUFhSnVJRGhFUWNpOXRpWnlVNitXc2dkMC9yMDgz?=
 =?utf-8?B?RzlVUHRFVmRKbUh1Wm5zQ0FZVFNiZkRyWFNpa29tMTFaRGxGbHIzKzJheWU2?=
 =?utf-8?B?SDlwYkVVN0lieDYvL0JSODZaWEY4bkx1d3VOa3U1ck9BMnAvTEJuZjNnSnU2?=
 =?utf-8?B?TS9JUHcydGtTbGk0L282MEU5TkRtMnlTVUxVR0hJUVovdU9jMmg4QnJBckdh?=
 =?utf-8?B?bG5STFJ1TXh3RkdVazR6RnRZRHAyb2hqbnpyNTY2N0lTcUhkUG5DQWxtSVcw?=
 =?utf-8?B?dnhlYkdJdXI2ZHRrQjlmVXcxZXAwUDJHdTBYZndnWkVlVU5KTlkxdWxNZXpS?=
 =?utf-8?B?SWswZmRWTHlLOGdPT3ZwWnBWMVVnSkEvV2E2cXZnWUxZTXJ0STNqbDErQ2lT?=
 =?utf-8?B?dkhnMllZemc1NTBjdHVSaGlTK3YxY0MydkdyK1JjaytLWFhXTm5MZWtjNXV2?=
 =?utf-8?B?QVBnenZIWTlsc044LyszMmloZ2t1TEVIWVBiNDRQNzB0dmJGendRN3B4RFND?=
 =?utf-8?B?ZzFIajlqbUk3aUVDRlEwcEdMelRTVktYODBmMnlMRnVIREFrdUx3SlF2NFNM?=
 =?utf-8?B?eG4rRVQ5bkc2cVo5QUh0dzBHdThNNjhDTEFuZ2xPSmdKbEZJMVBkZjBmVFdS?=
 =?utf-8?Q?wZpgi/T5R4Yh3dXlCsK4Ovg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e659cb59-70ab-428c-ae6c-08d9e4cb4d2a
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1242.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2022 15:06:47.5335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZtfwaGOHF5W0OZWoU2giJy2X+QWmAJvkyHM3BgoqDmdOaV9Z6CXjJYo6DJzc7H3WYjdTAI8oyqXaHjsaaQq3WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4128
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 1/30/2022 7:42 PM, Christophe JAILLET wrote:
> In order to free resources correctly in the error handling path of
> pt_core_init(), 2 goto's have to be switched. Otherwise, some resources
> will leak and we will try to release things that have not been allocated
> yet.
> 
> Fixes: fa5d823b16a9 ("dmaengine: ptdma: Initial driver for the AMD PTDMA")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Acked-by: Sanjay R Mehta <sanju.mehta@amd.com>
> ---
>  drivers/dma/ptdma/ptdma-dev.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/ptdma/ptdma-dev.c b/drivers/dma/ptdma/ptdma-dev.c
> index 8a6bf291a73f..3fa2a6ed4b68 100644
> --- a/drivers/dma/ptdma/ptdma-dev.c
> +++ b/drivers/dma/ptdma/ptdma-dev.c
> @@ -207,7 +207,7 @@ int pt_core_init(struct pt_device *pt)
>  	if (!cmd_q->qbase) {
>  		dev_err(dev, "unable to allocate command queue\n");
>  		ret = -ENOMEM;
> -		goto e_dma_alloc;
> +		goto e_pool;
>  	}
>  
>  	cmd_q->qidx = 0;
> @@ -230,7 +230,7 @@ int pt_core_init(struct pt_device *pt)
>  	/* Request an irq */
>  	ret = request_irq(pt->pt_irq, pt_core_irq_handler, 0, dev_name(pt->dev), pt);
>  	if (ret)
> -		goto e_pool;
> +		goto e_dma_alloc;
>  
>  	/* Update the device registers with queue information. */
>  	cmd_q->qcontrol &= ~CMD_Q_SIZE;
> 
