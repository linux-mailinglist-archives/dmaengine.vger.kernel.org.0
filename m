Return-Path: <dmaengine+bounces-1045-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D07A85B3AD
	for <lists+dmaengine@lfdr.de>; Tue, 20 Feb 2024 08:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0343F2820B4
	for <lists+dmaengine@lfdr.de>; Tue, 20 Feb 2024 07:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F395A0EC;
	Tue, 20 Feb 2024 07:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KC1ocfSe"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7436C2D79D;
	Tue, 20 Feb 2024 07:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708413186; cv=fail; b=clHy0jm7uf4izvvahjbM12V9rB0+JTkBT4l/L6j+q1A3T5kTGJbVyagb+bjn5G0grE2gA3uEzvM7ZQ7Gcl7CWxg1k577vLAeOgS6NWJH5f6tKsb7qRvjncCMy2XDYlUuBJVaq1W5Mrpw+buJoVjmuLhITamxS2BJjEEL2qRPFms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708413186; c=relaxed/simple;
	bh=GkuEmfXs493E/TWCFU/h7n1twPjufFuhFks+P+PVe+8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LNGcoOqZedWnX/V2y5vex72QxyPN6P2lb2DWrOjSxCbEohc3lkBONbnrSqfueoYnrlnSHIZxTaYXwhxJ8NSQQUkusQN9VpnZ0I8l0doPfjxgQ+cBSXuu2O02dKbst0dw3xJ0L56qcGb7oqqxPaFPqSGcc4GR04OYCeNUlImTI+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KC1ocfSe; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Etb8nhkaLZHvJedRUL+zHQYpFeCnOShSDdg+nmtW0ooYG3emsfGpMfRG21uM+LZ/fySS/nAdSZCNj93lExyGoYemykj+aXDXhk8yeH/PsneWV1O3TjNYNo/zTI2iTSCKYbN6n6MVd+md0PkILkrSjMGyy3rYsECopSkRb3ZkjB3meDjtYkaKee9VRmikaLMrqP02gHNVtcfqWofopk2MBE9wM/QJPZUh7B3rNKMeqrJi7svtWfzG0AMSTl6fQBXx4ZmzEYkC5oybzxIaM8TF9YjmvJ3WyH0jCLEgw+GLaOa2DP3yUQueP09V2w7ohbrE0hm2tKnrtgeJGezWnWNp1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rrw5aiqibl25OmB2gXnX5A+mwVZpo3BbnjvCPr0kiME=;
 b=WGnKErRWT1fnCBT/cU14/P4Pb96lekwjDumtSs5IS5cDX4vvelZTqX/NUSh6jDwHZAmwUislbEfxLYrlrZLYqiX5ZB32qRY4f8s+q8GAgfN3wS6KqnRah3JZ/vdn1FSGaF6zRKa87njkU13bMvba8SAysB33zHUGgY9Md065QgIrQvKYN4HoYyX5E+9KCIX9nBBwW8AaJrX8Jl8PvCdmWSX4q9eiR3S+dQjH46JJCStPIUFy217zj/1tW54HUKHGtZL6QU2iAFPRWn2v+22pa9IoVxn6y7XnBUhnoZtLSBzMuWe1681Z5THZsPKOqrSOX2refTdH9ZUPKBvCaUyxFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rrw5aiqibl25OmB2gXnX5A+mwVZpo3BbnjvCPr0kiME=;
 b=KC1ocfSeDEzazvDjXKHREbn8FYfH6SQzA1lI0KECsQ9ScuhhuFCK+kLnCKra/t/qqxMVwYLn/MvI+epfOGK5jjin7NXw+y/YFP/DDbk4e6HsXjAN578IoxKxc2ySs/WSAMTSBM5ZttxhUfZdk34HXQL94oWuu6xKSD2EgKBeQhs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by LV8PR12MB9154.namprd12.prod.outlook.com (2603:10b6:408:190::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Tue, 20 Feb
 2024 07:13:01 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::4238:15f2:f66d:d159]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::4238:15f2:f66d:d159%6]) with mapi id 15.20.7316.018; Tue, 20 Feb 2024
 07:13:01 +0000
Message-ID: <73ccc3d5-c40b-49d7-83a2-fbbe5741fd4f@amd.com>
Date: Tue, 20 Feb 2024 12:42:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: ptdma: use consistent DMA masks
To: Tadeusz Struk <tstruk@gmail.com>, Vinod Koul <vkoul@kernel.org>
Cc: Raju Rangoju <Raju.Rangoju@amd.com>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Sanjay R Mehta
 <sanju.mehta@amd.com>, Eric Pilmore <epilmore@gigaio.com>,
 dmaengine@vger.kernel.org, Tadeusz Struk <tstruk@gigaio.com>,
 stable@vger.kernel.org
References: <6a447bd4-f6f1-fc1f-9a0d-2810357fb1b5@amd.com>
 <20240219201039.40379-1-tstruk@gigaio.com>
Content-Language: en-US
From: Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <20240219201039.40379-1-tstruk@gigaio.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0048.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::23) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|LV8PR12MB9154:EE_
X-MS-Office365-Filtering-Correlation-Id: c5d10cf9-bcae-4dac-3e90-08dc31e35f91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	O7yVkrFY8BvF5kXT159wftDKKt3NYqLVceApjeUALOKy7FLL3ryNQyiQHwDbWUCyHx3VKvymi03k74Pme7evvdB6xC53CJAtcK5avELYwtN5giqRnfMxNJ1IbrlsaIV54WXpmYDf8bhOFJ6UbP6q96RM6LtiWAGfoHmXo15EZL7rR528WHZZL/b6rTospSy//pBfIu4PZwg0ymlRGa5QjxiZdSTpclW0UEWU07a+wflbA/R+AmcX2BtL35E8ciUUTceyV3Q60GDam2iNbS5UkE7CIKBwKgx7GZeuYotPv2qY9fcWnCcKLJJPpohIal8P0Dsh6Q1uPO6pZ6Dh1rrbEKUo7tcTbN02tiBBp0LrbJAJuB6qXKRO3LGJ/QAvCmAk3PMLiS1X/SwNVC3P9XpIjSUU+lYA9xQ+I2ADUlOqr29jdA67GK6vjVEqjj0ihRDwV8kRJ9ow0X5AuSnqsY2zRkLirm7sCdY4AjshBBrHj6ZZFBJnMu2ufSp6M4/nFQbvHg+jtkopD5hBFi9BgfiKmCnawXMtD6IDW/siQIQFvuc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MzB1UXZQSXlJSWwzWVMyZ3ZFZG50SUVUcHMrZk0xajNYSko0dEhFQU9JaVMw?=
 =?utf-8?B?UVU1aVI4dFZ3bTg5djdqWm0xV3N6bTBuRFFNTUlUT2V1ZWVielZ1MHRXYTJw?=
 =?utf-8?B?TVk2VG1MMHh3azkrRXJEMXcvNHpKZjZZYkdkaFE4ZVZxOFE1RnRhZzFudGhS?=
 =?utf-8?B?YWRHY1FxM25YUmZDOW9BcTB1aWZpcjFzYlhaamRUblliaHhqamNYVzBwUVU4?=
 =?utf-8?B?dmszZ1dUWExrdmdPMFBWcU42ZW9USVEyaDl6Wmw0eS8vTzk1U2FLaEJnMEZn?=
 =?utf-8?B?NWd5L3lWVDRaMXdMUkNWZ3lLTlBJT3J5VW1mMGZ5MUxpdXV4bWQxLy9YZ1ZC?=
 =?utf-8?B?MGNsUzd4QTJ3ZVFhcGxZUlB1NEFKMXFXVkFtLzFrYnhMMklqcVF6YXE3blc3?=
 =?utf-8?B?c3lrNU1wZm55Wkd0QXBLT3hncFFIbnc0aXhla2RKM3dGVFhQTm9QNEdLZlRC?=
 =?utf-8?B?SmdhNlk3aGVnT1hySDRId3RXMzFIa0lYME8vZ2xCbG5DL3lMZUpJLzV3UkI0?=
 =?utf-8?B?aFZDL1ZxbXBWUkRDSlJNNjNOcXZpdmV6N3o3cFljelNWaWlTWVNsOUN1bnh5?=
 =?utf-8?B?NDBaS0RmSklKdVozY1VUUG9wU3BKcGdIYnZMdFFGL1JhWk9TQ043bjlJYWs1?=
 =?utf-8?B?aFhtTjRxUVhKSWp2U3FVTFdsSUJIemljWUUrcWRielUydmV6ZFUyLzM4Mlh0?=
 =?utf-8?B?eG0rb29PZ1JGT3l6UTIvbnlmb1p3VGhLWGhQS3EwQWdvR28yYVJwK2NZVjdw?=
 =?utf-8?B?d3hXdkhKUk5HSUFHUFNqUzZFV3VIa3FYQ24rOS90OTlxRWprK2dkTituT3J1?=
 =?utf-8?B?REw1T1R5RU9CY1Ficmd3WTBvWFovQVEzNVBLbjFGWkpESlA1OXlocXoxYm9o?=
 =?utf-8?B?NXhPeXd6ODBhSG41REtUMVh0dURtZHo0SElXOFJNY2w5N25YdnhOS0ZYNElv?=
 =?utf-8?B?eXJwSXp5bHBzayt2SllPMHZPajhsTUw0T2pjR3l2eXk5L21odEZFRC9MaXl3?=
 =?utf-8?B?WmdSYUltZ3Y5TW81VVlZQ1QvcHAyNTJ4OW44OUlFQTl1eWR4UlpGMVhWQUVB?=
 =?utf-8?B?bWZ4cE5CN2Y5UVNqTXRVZ3dJK3ErSk02NFlTQk1WU3lBVHVnODJiRUIzcHBo?=
 =?utf-8?B?ZFZWRExKclVncE11NUc0SmFOTGs0MnYxdno4cklYTEo0NUNxUUJna1ZJT1pC?=
 =?utf-8?B?OGJHb0xjUTBlZUhvRHZndmFMdmJGbmR6RjJaS2dycGhmSXJQdE01U0lYdlFR?=
 =?utf-8?B?aW1KRG9rOFhUMmpHK3J4aDIwL2hjVjFlZWdIWjlmZE81WTlnK1hHam5BMnpp?=
 =?utf-8?B?dE5Fd1M0WXJ1S0hQc0ltRGJFaHFacXNDVnc0QjJvSVM1blRnSlk4RmIraTVw?=
 =?utf-8?B?V3dRem9pRzBSTW16a2pRMUY0QlZyQy9PU2h4elhBSVV5akFHTVBjTkZlOWRO?=
 =?utf-8?B?cSszbkNPQ0g4NUZWRDlEWjZLNGhXdTQyNERpdmhlV0xxRlRldHRVZVd4VXA2?=
 =?utf-8?B?Y3Q1dXArNi9SUzNIcjRoZTBaTm1kRDlnZVpKalRBVi9BS2FlVlRqZ3YvSFBL?=
 =?utf-8?B?emtnb1JnOXM2b1NHZFM3SUlUcFBLYXlIbU9BZ29WQWJySnlHTURXUUdSNnly?=
 =?utf-8?B?Sit2L1FURFJYN2IrZ1pXMDMxWkZJdGJlYy9mVkpaV3IvRWhQcXlKT216azVw?=
 =?utf-8?B?Tzl0T3V1UWtTUVAvV25DbWlmcmgzYk5ieWZtQjlhaWdWa3FKNVlJSkQvNzdD?=
 =?utf-8?B?Nmc3TUhXUzlCTlFacUY4SDlHQzJRWFJCSVkzaW9veHArVEdQaEJUV1h1Y3FL?=
 =?utf-8?B?NnpaNDJlN3pteGFUcStsM2hlUk9jdG5qUElTN0hOeUNwai9TWnduRm5TcWRX?=
 =?utf-8?B?MlBFLzRTQkd2dW0xdEFDekExaytYOHU3NlBvekRJVXo0MGVoM3VhSnN3cE1T?=
 =?utf-8?B?eHB2WUtvaldlaFp4d2w2Sko1VVFrY2RrbnNtb3NjYTVaK1NMb1FqN3pIa0tD?=
 =?utf-8?B?WFNRYkNIdGFVNi9zNWl4c0Z4UlZobSt1OVRzelhqMUNtM0J3WXljWDRRS2do?=
 =?utf-8?B?YW8xZWJ0VWxMckEwSXNXLzRKcGpXNElyTm1WY0NWRDJvWFpMRjdOSE5vT0NR?=
 =?utf-8?Q?BdKBcdkTu/btynQiJehWbyY9v?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5d10cf9-bcae-4dac-3e90-08dc31e35f91
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 07:13:01.3958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zJ4rLRxxD59Q7FCZ+1SZR43DGJOdBsX1YHxUhBRbX8n7RdOH6m9/DrpR8EKYt6rDxqzxzgag4uw0rzy5IRmHuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9154


On 2/20/2024 1:40 AM, Tadeusz Struk wrote:
> The PTDMA driver sets DMA masks in two different places for the same
> device inconsistently. First call is in pt_pci_probe(), where it uses
> 48bit mask. The second call is in pt_dmaengine_register(), where it
> uses a 64bit mask. Using 64bit dma mask causes IO_PAGE_FAULT errors
> on DMA transfers between main memory and other devices.
> Without the extra call it works fine. Additionally the second call
> doesn't check the return value so it can silently fail.
> Remove the superfluous dma_set_mask() call and only use 48bit mask.
>
> Cc: stable@vger.kernel.org
> Fixes: b0b4a6b10577 ("dmaengine: ptdma: register PTDMA controller as a DMA resource")
>
> Signed-off-by: Tadeusz Struk <tstruk@gigaio.com>
> ---
>  drivers/dma/ptdma/ptdma-dmaengine.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/dma/ptdma/ptdma-dmaengine.c b/drivers/dma/ptdma/ptdma-dmaengine.c
> index 1aa65e5de0f3..f79240734807 100644
> --- a/drivers/dma/ptdma/ptdma-dmaengine.c
> +++ b/drivers/dma/ptdma/ptdma-dmaengine.c
> @@ -385,8 +385,6 @@ int pt_dmaengine_register(struct pt_device *pt)
>  	chan->vc.desc_free = pt_do_cleanup;
>  	vchan_init(&chan->vc, dma_dev);
>  
> -	dma_set_mask_and_coherent(pt->dev, DMA_BIT_MASK(64));
> -

Looks good to me
Reviewed-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>

>  	ret = dma_async_device_register(dma_dev);
>  	if (ret)
>  		goto err_reg;


