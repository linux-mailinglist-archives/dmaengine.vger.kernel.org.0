Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD214892E4
	for <lists+dmaengine@lfdr.de>; Mon, 10 Jan 2022 08:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239927AbiAJH7V (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 10 Jan 2022 02:59:21 -0500
Received: from mail-bn8nam12on2078.outbound.protection.outlook.com ([40.107.237.78]:33761
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240120AbiAJH6E (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 10 Jan 2022 02:58:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J9PklOsdt6N732bTegFwaz1TtM0FH51auv8j9rkDFCljq1VFOvpVYllcr98FGy1kYgogI1ZZk3Sv+0jPu5C3l/SGtX+aduQlit1XT5BRs4PfuPm6U5vHk7W/Vxm7GvlkSWABaH7p+jtyU2AIISrMARFSM60NeqyHlC4vQZC2DxlNriwbtPqw89vun33XzlOAl1F6mFY2w1Bz0AtkKTeoszqnBRqqnyzeDhCeYVmvwFiduzGvOrbWtQDc1XZMOisGUQi/0wo/bCbyAHULqla4Uq/wQwfEbB8ud6Rtor1A+/S0wGaLwIGQnPm6WC4sV905G1/8x9awRYgkHrNiEqPkGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P6T2mXCMVd2P6bzZY1l3xNb5R4a4VvKy7zd08qtvMe8=;
 b=WdO0P4lQlgxpqZyUamcEPscLia4O2jsBMjRf/z3cUiLSE/TuKMIxSv+Ugs42ZDXUMQzEG7AGB6d+sDj9lg2RqkSf/jx8lLzICCB82TlH/UUVnzCcjJv9BkSeKt4eN9u71S7h7vHxs6ZJ9k29Q0AkdC7j67JASfDIC1/Sf3KO04TD93dsC2/z4KXp7hZkcst2YTgmIGLLwlCYusS5dMlsROHOv/NjX2OopkyZDbWE1SK2/4WOqeXbBVlozaMWc5U7L4KNlkBnKGTIjW+Nzpm2lZcj+PKSvcOnkvGaxtc/stkxrzmyJsfG/Z4rLWiSSYSD1KEcJkUHt+7UsNUhVRt/Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6T2mXCMVd2P6bzZY1l3xNb5R4a4VvKy7zd08qtvMe8=;
 b=0WET7jh31CtWeBjzs5/1CkMHP0/kCLTwvlXGL+/f3Zeyy948fAic6uV2fGFgxFgX8sftLatlX5QNmq08mtZqZdCNK+7jUKmXRckg29Od4o9LRa6Wh71jcHpbd2PZNhe2SkXwHZAvRMs3MWQNxuohHQWkkzD5mXzGuLCgXODSBpY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1242.namprd12.prod.outlook.com (2603:10b6:3:6d::18) by
 DM5PR12MB1147.namprd12.prod.outlook.com (2603:10b6:3:79::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.7; Mon, 10 Jan 2022 07:58:01 +0000
Received: from DM5PR12MB1242.namprd12.prod.outlook.com
 ([fe80::ced:a3ff:fb2f:165b]) by DM5PR12MB1242.namprd12.prod.outlook.com
 ([fe80::ced:a3ff:fb2f:165b%10]) with mapi id 15.20.4867.012; Mon, 10 Jan 2022
 07:58:01 +0000
Subject: Re: [PATCH] dmaengine: ptdma: fix concurrency issue with multiple dma
 transfer
To:     Vinod Koul <vkoul@kernel.org>, Sanjay R Mehta <Sanju.Mehta@amd.com>
Cc:     gregkh@linuxfoundation.org, dan.j.williams@intel.com,
        Thomas.Lendacky@amd.com, robh@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
References: <1639735118-9798-1-git-send-email-Sanju.Mehta@amd.com>
 <YdLfLc8lfOektWmi@matsya>
From:   Sanjay R Mehta <sanmehta@amd.com>
Message-ID: <38ae8876-610a-3c32-5025-1419466167e4@amd.com>
Date:   Mon, 10 Jan 2022 13:27:48 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <YdLfLc8lfOektWmi@matsya>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0087.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::27) To DM5PR12MB1242.namprd12.prod.outlook.com
 (2603:10b6:3:6d::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f019b829-bdbc-4435-3ac3-08d9d40eec49
X-MS-TrafficTypeDiagnostic: DM5PR12MB1147:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB11470E643E1F22FE5071B795E5509@DM5PR12MB1147.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lT4/y1w4D6MenoRJdIbpgnLLH31xvOD7tFFULDNf6m0Qku+WiE+cfCZr0OluKuSpP0enb6qRL9tAbz+kc3QO4xDqal8ZJrC+rcXtzdgMuS8rtTWL02slROjih4TAVKStTiX6SNWD0N4zxPeI2bRU3VMha/tGcyPq8bJcQnwmnOZqW6JCnRC/9zrIRIow3/gKk6kohalwBAzMXBFxAOZc/fAvUmyVpr87pWv0HCjYcnX3qUN6yMdOHTa0iuC+Jlk28zllKLCqbO6fFhOejhOxUHSKHpNay/4lfH5X70JYynXrFtNdnpvwVSPN1TadA1iydJFFzPTuucBa/rARcZ1ebEYnWl/ymUNoAPVQ/I94ZIrwCFxBmRWK9VY8qrxNbGMzDJZudXKYhZPHtw2mBVzEUcpNfH/4/Xjbm8YWDjyXOWc+fu5tJ1/EE+iEk7yq5wZJlEEp822/Ctvadb/Sg82+h4Yn+emgrTah/wD/O0fn1gjAyL5pQTaykeOCsbAGDG8yxh6Z22xCsDLp/0LIhoYi07VBnKgTy39BR3URIEb1AdEf0G9OS2rQJpujDEv6vvJD0Bxvg5x4iw/I40BtfcSpzdiSeWXhoXq5GAmRc0VhRPjgjRXxbXj5U5S0LUsEaEo0/hEuREUJUaOQHQG0ZaOTFdTmuAjXrc6l+E0FPQ87jCN26+v0a2QTEwGZua5iIKp9h4gEegqTEbKpzW68xSwpkTryKZRjjxkyOhYGsb0aQsw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1242.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(31696002)(4326008)(66556008)(5660300002)(186003)(66476007)(110136005)(6486002)(31686004)(6506007)(53546011)(6636002)(36756003)(8676002)(508600001)(316002)(38100700002)(83380400001)(6666004)(26005)(66946007)(8936002)(2906002)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXRBWDJwY0dTNjRYK1ZLSGloWmRXd2FjUHgrVWpKaW5xa2pmajhXai8vZUVh?=
 =?utf-8?B?bFN5S255a0FlNFFZcjNkL2VUWURZaFVoS21NbGtmYkxtQkdZYjVkVVVLRHhn?=
 =?utf-8?B?enY1dW5TR1pRdVdaVGJRWi9uMEoxdUJHbURZbW1SZ1JBbVd0eDJTZVdTY2hI?=
 =?utf-8?B?WDlkYVkwb3ZYZGRuNndQelRpVjlQczNPdlJ4NStRa1dTM1BJS0wrYXdkaGl0?=
 =?utf-8?B?RmF1NUdPNlNzRTRpS2VuZHVKeTRkOGRINjR4OFNRdGVwSkRiekZPYVNhblhw?=
 =?utf-8?B?RDM5REpORXgzYmhkV3lENE0rRmpacE5JK0k3Yk1XRmxab2h0N0NwTFAzaXdM?=
 =?utf-8?B?QzNpWGdWZzY5RXpmT3UwYVpLYlgrc05hcnE3Q2FKWTdHR09EYUZwdnFBdFd1?=
 =?utf-8?B?YzF2UGlheFJwTlRTY0hlczBhbjAwNVFzZzJIczVNKzdacnBpdFRoNm80TDEw?=
 =?utf-8?B?bzUvVkp6VTlRN1FtYzVmL3d4SVNKYjVaVkNRNjd0eGxMOGpSQmJHVnRENGJ2?=
 =?utf-8?B?ZWdCVDI2MzBGUDNoZlUzRmtJMk5nU1NSeXFqaVhUZXhHcUVPYkd1ZVJJbVZv?=
 =?utf-8?B?T1pXemZPdFYxaWs5RUNGL255TW1ZQ05BN25CVGlST1E1dzh3NmtYV3JLUnVT?=
 =?utf-8?B?UjdhbDBlVDFjWnhTSzdnMGZkSWFoaC9RVEtnRmhycGdHMG1oU1BZR0h1Z3ZC?=
 =?utf-8?B?OWhwR1RiRjFXZjVOVGgxMkVXUVZKUThVMGQwUkU4ajd5dm9xaVlJRUZmMk9v?=
 =?utf-8?B?ZFdvVldKTGRwZFRaTXZyZHQ2VFlkZVRaSHNhb1JVUXhneHFTakFlbExIOFp3?=
 =?utf-8?B?R09VSzNtWC9OZFMwYmFyTnBaUHZtdVNNM2VQN3RMMktYczBiMldyUGJMTXBv?=
 =?utf-8?B?SWg2RnQ1NVdLeldCa1BBejQ3a2kyL01zQ0swcnpUVlhPQk5QQ2dnUkR4U1BU?=
 =?utf-8?B?TE53cFRXSlNzMm8yTGRnbGF5a2Uza3duZUtmU0NSdGFySkZXeVY5MlpPeEtG?=
 =?utf-8?B?T2VYKzdiNGlRV0RpMEdRcjFkL0ZkUyt1bFZySkxBN1pqS0xqcGY2V1dRc2dM?=
 =?utf-8?B?UHR1VU8xRFU1aUFIRERZQ21DNE1oemU0cjJkdVdsbjJoYjA1TDR5MG4wZmwz?=
 =?utf-8?B?WG9Ka3gzMWowbUxISWtwbWY1MjVZWW9rQUFkeTZTYnlvUFR2YVMyMmJEeUwr?=
 =?utf-8?B?SXV1QW1URUQ1RnY0bFIxbTBMcGpmR3BWNWRSSG1VVTFaQi80UkZpcFZCbDVl?=
 =?utf-8?B?MWlmWWZFdlFDUmlvNXlQRUtML3RlQ0hXU2RsL0h3RnVPd1FYZVB4NWVLYnpV?=
 =?utf-8?B?L25ueWtpZC9JSXJXU0ROTzhPRzhZR2txM1NYVEF0eW5FcEJ2ZVFmNEdMQlZE?=
 =?utf-8?B?WWFrQzJPL2gyN1YyUWllN1JoS3hpa0VBK0pFN0lxY0hMS2w2S1EwYUR5R0Fz?=
 =?utf-8?B?RVR6d08zMjd0QU1RNWtUTWUveE9YM2pVTFhrUzBVYUFOR2hZcUZVZ1lkbzMx?=
 =?utf-8?B?bHRnWTlWRTlsM0lUN0J4emxOTWd1bFJwNHA2R0toa2d0NWFWcnY3aHJZQ3Zu?=
 =?utf-8?B?U0wrZVB5RFhoOWhMV1IyMHhVZS9uTzd0WXNPd1NQM1JsT0Y3M3AyRzQzbTUz?=
 =?utf-8?B?elkwc0FLUWkyYVlySmFxTERGYzh2WEJWNVBkeC92OWxHSFBMMFlLelVyMk1E?=
 =?utf-8?B?aFkxM2tBTXRES3RNaFZ3SnlKOElYeEpPVVo4MjJwNFFLZmw0emJ3NWtINFIz?=
 =?utf-8?B?MCtaV2IyZjVJZVI3dGlSdFVyNTY4eTFkcElkZFJOcDk1SmtlR3h3UFNDSmNK?=
 =?utf-8?B?ZVorWjNTaVJVWWdmTFFEQzRad3diQkNrVkdhMzhubytBRlFvenNSQzd3Y0d2?=
 =?utf-8?B?KzREOU93WHQzeWFrdVhscXErMGN0blpDb2RrRWM4WHBHdm5mcGVWb3Rid09P?=
 =?utf-8?B?dE80V3NSY0pLcjhSMGIra3oxRTZGcUJBd0l2bFA3QjR4cFhNK0FOWWxvYkd0?=
 =?utf-8?B?ZzZDZ3lRZ3VNbmtuMVhGWUtLL3FWM2FOS0pNeWVUd2M5amVTaUpyK3J4aG5r?=
 =?utf-8?B?Nkc1bmo1a0ZuR2hSaHVjbVpjUjBkVmJYbG9aeUduZUNzTUpBRkovL3FYNVRN?=
 =?utf-8?B?UjhGWklsU00xVHUraG9ocUxpS09qVzd5dTFHM1l4KzA2RkxGWG44Slh2bk1k?=
 =?utf-8?Q?zBEIorUKh8U9jzjuRxp3Mg0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f019b829-bdbc-4435-3ac3-08d9d40eec49
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1242.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 07:58:01.2238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uLiUpcg5sTONeblqWLVOWhHFmWk8cqu8AZb9c+O3PcyBHfUFlseyBrl6+PJlijszi4i8YH+shBvWFSHPNf10MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1147
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 1/3/2022 5:04 PM, Vinod Koul wrote:
> On 17-12-21, 03:58, Sanjay R Mehta wrote:
>> From: Sanjay R Mehta <sanju.mehta@amd.com>
>>
>> The command should be submitted only if the engine is idle,
>> for this, the next available descriptor is checked and set the flag
>> to false in case the descriptor is non-empty.
>>
>> Also need to segregate the cases when DMA is complete or not.
>> In case if DMA is already complete there is no need to handle it
>> again and gracefully exit from the function.
>>
>> Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
>> ---
>>  drivers/dma/ptdma/ptdma-dmaengine.c | 24 +++++++++++++++++-------
>>  1 file changed, 17 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/dma/ptdma/ptdma-dmaengine.c b/drivers/dma/ptdma/ptdma-dmaengine.c
>> index c9e52f6..91b93e8 100644
>> --- a/drivers/dma/ptdma/ptdma-dmaengine.c
>> +++ b/drivers/dma/ptdma/ptdma-dmaengine.c
>> @@ -100,12 +100,17 @@ static struct pt_dma_desc *pt_handle_active_desc(struct pt_dma_chan *chan,
>>  		spin_lock_irqsave(&chan->vc.lock, flags);
>>  
>>  		if (desc) {
>> -			if (desc->status != DMA_ERROR)
>> -				desc->status = DMA_COMPLETE;
>> -
>> -			dma_cookie_complete(tx_desc);
>> -			dma_descriptor_unmap(tx_desc);
>> -			list_del(&desc->vd.node);
>> +			if (desc->status != DMA_COMPLETE) {
>> +				if (desc->status != DMA_ERROR)
>> +					desc->status = DMA_COMPLETE;
>> +
>> +				dma_cookie_complete(tx_desc);
>> +				dma_descriptor_unmap(tx_desc);
>> +				list_del(&desc->vd.node);
>> +			} else {
>> +				/* Don't handle it twice */
>> +				tx_desc = NULL;
>> +			}
>>  		}
>>  
>>  		desc = pt_next_dma_desc(chan);
>> @@ -233,9 +238,14 @@ static void pt_issue_pending(struct dma_chan *dma_chan)
>>  	struct pt_dma_chan *chan = to_pt_chan(dma_chan);
>>  	struct pt_dma_desc *desc;
>>  	unsigned long flags;
>> +	bool engine_is_idle = true;
>>  
>>  	spin_lock_irqsave(&chan->vc.lock, flags);
>>  
>> +	desc = pt_next_dma_desc(chan);
>> +	if (desc)
>> +		engine_is_idle = false;
>> +
>>  	vchan_issue_pending(&chan->vc);
>>  
>>  	desc = pt_next_dma_desc(chan);
>> @@ -243,7 +253,7 @@ static void pt_issue_pending(struct dma_chan *dma_chan)
>>  	spin_unlock_irqrestore(&chan->vc.lock, flags);
>>  
>>  	/* If there was nothing active, start processing */
>> -	if (desc)
>> +	if (engine_is_idle)
> 
> Can you explain why do you need this flag and why desc is not
> sufficient..

Here it is required to know if the engine was idle or not before
submitting new desc to the active list (i.e, before calling
"vchan_issue_pending()" API). So that if there was nothing active then
start processing this desc otherwise later.

Here desc is submitted to the engine after vchan_issue_pending() API
called which will actually put the desc into the active list and then if
I get the next desc, the condition will always be true. Therefore used
this flag here to solve this issue.

> 
> It also sounds like 2 patches to me...

Once the desc is submitted to the engine that will be handled by
pt_handle_active_desc() function. This issue was resolved by making
these changes together. Hence kept into the single patch.

Please suggest to me, if this still needs to be split. I'll make the
changes accordingly.

- Sanjay

> 
>>  		pt_cmd_callback(desc, 0);
>>  }
>>  
>> -- 
>> 2.7.4
> 
