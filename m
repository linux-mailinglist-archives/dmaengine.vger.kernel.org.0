Return-Path: <dmaengine+bounces-975-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0013F84CB85
	for <lists+dmaengine@lfdr.de>; Wed,  7 Feb 2024 14:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A837C2881D2
	for <lists+dmaengine@lfdr.de>; Wed,  7 Feb 2024 13:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC1076C77;
	Wed,  7 Feb 2024 13:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HZPKE38Q"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2065.outbound.protection.outlook.com [40.107.96.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203B976C7C
	for <dmaengine@vger.kernel.org>; Wed,  7 Feb 2024 13:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707312384; cv=fail; b=lutVk14J09LXel2a8e0DhXpPwZjL5CzzcHRRFzP+vuDPlVK+XauhROzNeIP00RPtc0f5wUdlPFHDQcV3ScugQHmBLH+CFYpkIJH4t1HVwltPp8InuywlcjBVtC/WGPnRWBU8R/IvbVOYenTpFnInVBN9M26uM6qPUxBo9z/DRms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707312384; c=relaxed/simple;
	bh=C+otcQTi+RWQTwLSQRdPd8k58K9Y+KmM9oiISZbPCyk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VTIiIpaLsRpgZ8JdE75o0qcTTrT2axAp5S3VGdGN9GGusfkifZhT6bfVa28Mn2QRrmCuQx/+u5dsY3aWYzYZtrMJTCYfg4hIwPPRv/TE56E3UxVHWdsPpJjtEiKa7t5RhQs3ZvBlfkYUBJ5TJohT9iFGiqcm97TdPwNBDa616ww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HZPKE38Q; arc=fail smtp.client-ip=40.107.96.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gKGyv1KR3u8FPv4M3qHLTwVh5AtTydmq0er/D0ev0hkg/nSdiZg+RJz+U5LAVrUHGgpojrk/ZMybYvZr+BCe2TryEF5toXSWt5YVhUXoLaY5eo9ZdDx4VCeAxI/KwD9NKj79GTSM3WL0/OqOjyjxd1ujc5xEJk0v2YX/OqEUna6rk2FTRR+/JgdN8nd1qtayeJKB+/H2UNP1llTSmey8vVVok78m/AlGghh0E/Ru8s+ZcLe1IAtfGGhnejE/sj0UMxE1CHi9LSw0jD8tvhQgLQtejt+AeP7b6bLEglI7qobr2unLEaaWtKN6iJoxNkXe7F6QU/uyBB8kP4HjDnzFZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iWzCf69Sf2+WJj+6LpXjr3nUu4svOxoM/rtmZUW55g8=;
 b=mzH1k+LSx7JDaK5egy/6cabpr/F+/8EPysHc2sF2ZRW+eUIpOM48vZcLptbtVgWUOD5pb51mjJJcpAmfxImgrDSEj3ZnHObFJWeP4HfLRZWA6KuPjuJipRV2vUhlD7kESAsX7K0DRRtfkUuXL1MeG09sNht5UMLVXD9QkUD/CM1pM1206nl8K9IW0knT/bRwAn6i3aubUNGP/fYEoESwOAbBnJDDx7hFk6hYnrOf1xDMu6miqHX8ycmH8BPFU0KuEfBhDXwV45v2WShkumaB86QuwK7xjwVyrvR9etj+9qL7JMsXAdIf3P1KE7ZWLcuEK9fTsDarCp+HbHsnqHpfxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWzCf69Sf2+WJj+6LpXjr3nUu4svOxoM/rtmZUW55g8=;
 b=HZPKE38QssUWFcWyumscciXXq+PZ6/7r7zskgElrQFAUB9AF/JewJcTlEsaay+h0Y1DlLQE/7m2BxBXGKZ3Z0g67dF5zMOw/ESh5Np7MbdCzY1N/dY5uU4Y3uoP8k2mYO1BFRGULM7h942seSs0G17RxGFSqOxXboUixwCpGZrE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14)
 by MN0PR12MB5833.namprd12.prod.outlook.com (2603:10b6:208:378::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.15; Wed, 7 Feb
 2024 13:26:20 +0000
Received: from PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::8f61:7cb3:f051:f790]) by PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::8f61:7cb3:f051:f790%7]) with mapi id 15.20.7270.016; Wed, 7 Feb 2024
 13:26:20 +0000
Message-ID: <6a447bd4-f6f1-fc1f-9a0d-2810357fb1b5@amd.com>
Date: Wed, 7 Feb 2024 18:56:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Using PTDMA driver for generic DMA
To: Tadeusz Struk <tstruk@gigaio.com>, Sanjay R Mehta <sanju.mehta@amd.com>,
 Gary R Hook <gary.hook@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>
Cc: dmaengine@vger.kernel.org, Eric Pilmore <epilmore@gigaio.com>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>
References: <1f0cdf3c-be91-427f-86eb-4982de13e446@gigaio.com>
Content-Language: en-US
From: Raju Rangoju <Raju.Rangoju@amd.com>
In-Reply-To: <1f0cdf3c-be91-427f-86eb-4982de13e446@gigaio.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0161.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::31) To PH7PR12MB6395.namprd12.prod.outlook.com
 (2603:10b6:510:1fd::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6395:EE_|MN0PR12MB5833:EE_
X-MS-Office365-Filtering-Correlation-Id: 450a5e5e-8247-4acf-e1b6-08dc27e05ef1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	viXMbhDpcgYO4PbmdxASIttzsDJ5YOAkYGxFTlKFT8ewtSV5II1APbVKDJeXol32tUTFFkp67Z7uE5Vj/Rw9SjOD+ri6K0NYUbt7ow5BWRBZGRtG6YeN8ONQSMwTlU6bCsAKn+9S0A/Km3dMSFDT8ezQamGdbJz86wHLRia5V8cdDltItOFq6qLoa4NrdZ7q0mJMBR2wHIUQbaqzBYn8TieB9WNrpZiVEv+NuHeAh4efvdPUmqkhS2vUtBVUv1jpcJiipnc+SoBjLa+CqEZAKiRb3Ng19uU5/u+TxWNwZYg8oiBwTVJfjmXQoIgbIg4kL/Rnuqc2pZM7dkxQCS4G4CU0dRahFZNlC4UGeQmqaxl3Rkn3wR1ZTwXjQipxRqtVWyDcB7QiLADy8D8VtB4gGvyBa6lGoNZlhz/JsG/jVIZuuaxcy+NjNVD8/gPO/Xel2LFcmTeFATpr3U6hQsksekHA9pwGMm9NF7MDoCw5ElI7IUqIhduoe8Tfk2nZ+qR8WGsNMKxFpfnojfkVIQ1cLZLOK73Bstc9u/hC77c1Zb9ysY9VId4TahoEvQ2yVbvO9ZKpPHdu66BxgcFTYU3OWjcHryYTPcO8Cz98znm62TDcTCVXo0VltSERyGfGvx2R4HSB0gf5LQ4JtB2aejaXyQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6395.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(396003)(136003)(376002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(53546011)(38100700002)(31696002)(86362001)(31686004)(26005)(2616005)(8676002)(8936002)(6506007)(6666004)(6512007)(2906002)(41300700001)(36756003)(478600001)(54906003)(66476007)(6636002)(316002)(110136005)(4326008)(6486002)(66946007)(66556008)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K25lKzNkSHBWQ0tSUWdZaVA5RlFJK1BlYjZlU2FJS2hobUpid0FmbFFZWjFo?=
 =?utf-8?B?N2c4czArRUNEbi9qRTJEbUlSQVl6c3RiQVNYVk1YSGZrVExvT21iVG00eDM3?=
 =?utf-8?B?cFg5bWNIUVZPVGtKMi9CS3pmN1lXeVRYc3lCcXJqaWhjL0lTWHF1ZUlTNnov?=
 =?utf-8?B?aERKTzRsdlVnb1RzK1FKZnBxb3RKQ0hJbEFpZFY4NHFBbmFPTHJ2SWlSTHNh?=
 =?utf-8?B?YVVmVy9ESkE1d1ZjYTNkK2dTOUgvY0JxWUZ3WTJTNm5YZ01QbHlycTVSMndE?=
 =?utf-8?B?MHhjUnBaK3Nqam1ielo4SHE0N1ZLZkFJdnI4VnZsdXdKUDJUTm0vK3ZYaUVu?=
 =?utf-8?B?ZklQYzQ3RC9PZG9QdVJjSnA2Q2p1MU1HdmsxQ3BVNXZhUnBMUWdjdHFwMCtE?=
 =?utf-8?B?UXhvV3Q4cm5XckV0T2pWTDF6bGFuVFhGZkNIS0pJeEh5MzEzc1dvM0ZsaTJk?=
 =?utf-8?B?QVRBWkswM3I4NkswMURiUVkrTjFlOVRwNGxtdDZlZWJsUG9OaGx2V1VGNW93?=
 =?utf-8?B?WkdNOVprN0Zxa1RKc3VlY0FkdnlxUlZEUzRoMHB4aEVGV3BFZzdvbTdieHpT?=
 =?utf-8?B?VkhOaEFmZDJjcmRVQk92Yk5WSWtOdi9VbXJFMEZjSGd4VEdCSkprckkyR09k?=
 =?utf-8?B?WGR0citnUEVxVlNoSlFuSzF6ZHRGMlVtMXdKWllnL2JEQnIzZ2wxZ2JEWE1l?=
 =?utf-8?B?dFFKMmFPWFpHS0VhN21VRlFSdW1tYjgyWEpnTndSVzVoQ0lVNENtd1B4Vnhn?=
 =?utf-8?B?SWhMM2pZaU1Ya1JBRGltRnBqaVE4VXJjMkN2b1NTczhLY0lyamFlWjRmWEor?=
 =?utf-8?B?S2ZUYzdXVzJFSGFobGJCeFEwU0lSbGI1L2FuWVZDUk04WXRQREo2aUdQUkpP?=
 =?utf-8?B?dVNNcnppU3poM2w3L1orTytERkc4UU9GVUpIb2FTdjJBK1ZHSjNwcGlpdFo4?=
 =?utf-8?B?NTY1OVVDSHV1QStYM3UyYjF1bE9PRDFmdXhsNHZMV2VGbVF3RDloa2h5dkZz?=
 =?utf-8?B?a1pHV3pjbWkySEdhbzVhT3FGWWVVNHB2enI5bjUrTWRkYnJaUDRrcFdCUmlS?=
 =?utf-8?B?MTMrWEV5UkZpV0h6Q2xjVWlQN0JFL3BaVjNLZ0FNTFlXdmMrZXVtdFFrNTVZ?=
 =?utf-8?B?d1FRbndlQXpCUS9QVk1tbUwyK1cxb1o5MVZYU0plb0VYOCtCaHB0Y09DQXZv?=
 =?utf-8?B?SkZiUXVNQkNLR1ZaNTlQbEd6azBTbk1sVUh1L1Q3QnVMSnlqMEp2bE5XM1Jo?=
 =?utf-8?B?eU1hOEZqS3I0dC9nbllZaDZXVVZUelgxeDRVZEZzc05yS3lTNnRueExQTFU4?=
 =?utf-8?B?QStEU1pMeHEvMTQ1eXhNOGFRUDVER01abVN2VXFwc2VNNWQ0Y3gvcVdqZklV?=
 =?utf-8?B?WnhrS2RNNjY2SFdZV2dMYUY4YUQ1MVdiR0I5VktUQzVRZHMyRzZzWkxCZCtG?=
 =?utf-8?B?VjZkL01WRzE2Si93S3FadEMyTVRkWXBaeGZkUlp4RmxZb2tjY1lyb3V3bWFJ?=
 =?utf-8?B?VFR5LzBPTURrWEdacDZQSG9nNDU4ekFpbWpLejZpN1Y2ZktyUk5wdURVT2RT?=
 =?utf-8?B?eXJwQ0h1aFFLMStUVjRHRkc4YjF5WFV0NnBVUEl6aUtNWmlNcU84Q202ekxZ?=
 =?utf-8?B?L0x6Mk1hcEhYK0d4bEZDSHByWC83cmd1bzVWQ2ExL1laNlhMVDBQNm5VYkxH?=
 =?utf-8?B?dnNpeERubHhYK2E5RldVeGllY1pQajFwRlc0a3c4S08yRHg3Q2RkQ203aDhW?=
 =?utf-8?B?SXV0WG5yeDFIamlqeU5sOGZsYUx2LzBpYmlPZURFSkNzK1F5T3RxZTVSL2oz?=
 =?utf-8?B?OGRQS1ZObEhyVTBlekhzUFBQVU1mcUF4SHY5VkVOK2JhMWtucGxEZDdDbkNS?=
 =?utf-8?B?eXN0ckZFbzcyK1pYV2xyNEZGLytzMnpKSlRRZmI1WWRtK2gwL3JZd1lqRmp6?=
 =?utf-8?B?Q0sxRldLZHFyNCtQNFNtZlU3UmdqU0d4T0xERk5ETUtLOG0xek9iY3VoL2ha?=
 =?utf-8?B?RXVxdFNLUkFPUkszRXVFTzlsTUs3MHdESDFjVmVaMDFyNGE2eDFsbVBWL3dT?=
 =?utf-8?B?YlJ0blVQQnJnOXg1RGRVTnZiUmJxVjlrKzlhaWdNYVJLU2N1aVZvbUphaFEr?=
 =?utf-8?Q?P5dMicpswjXFlvXLY2i4Qdffd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 450a5e5e-8247-4acf-e1b6-08dc27e05ef1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6395.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 13:26:20.2574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k2+sz8j/PX5FsCAR+17dtSrbUs5lJd0IYiZ5XsI6xx6pu33OGMydfymjvEKKy6cmYa5S1aZL1FHnKs0RJD0+wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5833

Hello Tadeusz,

Sorry for the delay in response.

The "ERR 39: ODMA0_AXI_DECERR" is a Decode Error relating to destination.

Please note that, the PTDMA DMA controller is intended to be used with 
AMD Non-Transparent Bridge devices and not for general purpose 
peripheral DMA use cases. PTDMA engine can not talk to anything other 
than NTB device.

Thanks,
Raju

On 2/2/2024 10:27 PM, Tadeusz Struk wrote:
> Hello,
> I'm trying to use the AMD PTDMA engine for generic data transfers,
> but I can't get it to work.
> It fails for me with "ptdma 0000:52:00.2: PTDMA error: (null) (0x27)"
> which, I'm guessing, translates to "ERR 39: ODMA0_AXI_DECERR"
> After some research I've found a note in drivers/dma/ptdma/Kconfig,
> which says that "...this DMA controller is intended to be used with
> AMD Non-Transparent Bridge devices and not for general purpose 
> peripheral DMA."
> My question is, what is the "ERR 39: ODMA0_AXI_DECERR", and is it even
> possible to use the PTDMA engine to talk to anything else other than
> AMD NTB?
> 
> Thanks,
> Tadeusz
> 

