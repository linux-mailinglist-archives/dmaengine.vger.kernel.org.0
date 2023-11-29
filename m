Return-Path: <dmaengine+bounces-298-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3467C7FCD3D
	for <lists+dmaengine@lfdr.de>; Wed, 29 Nov 2023 04:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 675A7B21469
	for <lists+dmaengine@lfdr.de>; Wed, 29 Nov 2023 03:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F694C83;
	Wed, 29 Nov 2023 03:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="rt+IB3wc"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8AA1990;
	Tue, 28 Nov 2023 19:10:29 -0800 (PST)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3AT2vDVA004123;
	Wed, 29 Nov 2023 03:10:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=subject:to:cc:references:from:message-id:date:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	PPS06212021; bh=3V6pcQwgj2ulY3g6g2C4lKa9WjwIZhCjInnbdZt4a4c=; b=
	rt+IB3wc0zZz6sNHCIpchm06QuxH5KoXy3Vv/39po9rw/uVAndAin9d4VniH9Axs
	/4HU09s5T2g1t5cEhSow775SscT2K3WYHnFpUwqDtV9gj/DYQsKC5I0Ohr7Mrl4f
	MKIQT0aLP+iId46OTBm36rTPQ7hiKgYi2SlJuBO4OiKXAWYENYbaIqXlTLdJtmIy
	kY2dPAFG48Flw1AzStYZb4a5TW9mPeKUD40t9CUAtkKfCl9chMxEVmsQT+ND1yXw
	OZesL+QXPomCtEysi35Tg6NWxLGdIFMj3EVYNxXS++YOORxbi0sknlAH2do6Z73n
	8MwceUXK+z+bZg0AsLYZvw==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3unvm580n9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Nov 2023 03:10:19 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CD3ERWxZuu/TLB6lDoDTf5FJYFjiN2ZcyO/4Cok+17sC+qlNebticLh9BHRJ6skAUB7EzsttfTQgE6EKGhSCEdODVRqFPdGP1K8pQqHgABOtrfDvQWg0/mgOKPL2UKU9Cdycahi+c5MloyRygrQmQgr1sCzPNuUMO0YoMO2Gq4Gkhb/omzwO9mLnA/sY0oki7OYpkmPgHa3cNtzvAkYZcxCKykVPWDIgYUswsxz8fT3vNMcPkHcnRGMZegPGSYBxeOL1VHh+AEZRIv7SD62k7tjNnTg1GxD67+rh7aREAuHgQjJ12EFsUwvw3o5g/H0nGIOYAOMvaLxb4n9X3QiZKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3V6pcQwgj2ulY3g6g2C4lKa9WjwIZhCjInnbdZt4a4c=;
 b=NkCOm0aqCGebm1xT5vai/nEbfL/hVbHAMqLzLde1wQs+VtpRyf6I9QlTyMfYSdEU0nAcYqoc9gGUguRpbmHy72JkKV5IdVmClLWw3+1UZfYIb1l48SQOhvLjBocWIFKw+HD5v/hidLXbft0Xrlw0g+/KzCsb1EtdkswwN43l1zlgkOX/CVYUkUfIVFUmdxtV9sF8TngQZXrRbtk01SdIQ5jEIzBsjo6Vk8hslAAFUrIvW2Xpa0sOu6m2NZDyDkrHPU6bMGIqXne259IbsMn/rdvlRJM8r2jlMEClyzC593vwoXwRyGJdSglz4vZ7zOy2dh3haBKwZ8w+9vGx27oZ/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by SJ0PR11MB5182.namprd11.prod.outlook.com (2603:10b6:a03:2ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Wed, 29 Nov
 2023 03:10:15 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::7d7c:4379:e96:3537]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::7d7c:4379:e96:3537%7]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 03:10:15 +0000
Subject: Re: dmaengine: fsl-edma: dmatest timeout
To: Frank Li <Frank.li@nxp.com>
Cc: vkoul@kernel.org, imx@lists.linux.dev, dmaengine@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <64cde245-0e53-6559-0a3b-ffe0a5415519@windriver.com>
 <ZWYJgc/S8xMofmWw@lizhi-Precision-Tower-5810>
 <ZWZiY4Cy/GP8L+Px@lizhi-Precision-Tower-5810>
From: wangxiaolei <xiaolei.wang@windriver.com>
Message-ID: <c9e3d4ae-4c2f-4f3f-14ff-35dd2318f8ac@windriver.com>
Date: Wed, 29 Nov 2023 11:10:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <ZWZiY4Cy/GP8L+Px@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: TYCP286CA0024.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::14) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|SJ0PR11MB5182:EE_
X-MS-Office365-Filtering-Correlation-Id: ee1ba80b-3e54-4cb2-2573-08dbf088b520
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	NEsOlUiybaEbJqz4sUQzYe5FauXMG/btJo/dKKD6IFu96B6Su+fv8KePtYzyntpf8jmTaLnSSfKUm/lRps9du/yxCjmFoMkHzRjK1mBbS9IrXj+SlBs3A0kx8gOf6q5CWHuPN2npHms9WkYYflrDrqCOJPQ68a7NnJAAQjtx9V+0qAqC9Gn+2DhXQgX3eUWExXUXeuRMNkMrq1MTZmMRzNa0mpq6T4qAhAH9R1169shdohjLl2KJDX/vWGi8V6qKAM4RSZ/eCq+v+etHqybtQp2ZBfLGV7gRPxsftFLDafDPFciya4Hah0e4SdMOpZAi8iNnN02yOFrpEKmfhcNQBP5GOEchg83j97IX2NRGF3qFzsaRa8aSyqj5dsEXcq6wVmEEmw1pnjtCHdYz1aeUfTsQhauSuq7BOLAwkGETnGomWXbO9x/lw0w3NE3so7V/G/w/+UNdmBZDmjktJOjyRRxlsiXOqFB34tFcm0a+j1+p3GSQ7UwmIJE6hotDtcvfEZcuLwMYPzcBQ2wTdDtYi93eG1GHNoNQVSKk7mRiMqBj6EKWiBPEzzhv8sI6fP6WOanTihXrbDL48U7eXrhLa8CEQZDVcMeS6K00R1WKMxDIPs/z+wguSOaxzjFQpIRu/tpEbfLrYmrCHX3q71ZMPNwj5MnKhAlrZjzcLoKnyEtVFpJtdUH21YaFGISwmdvxA/nkk796o2VZE093uj7Cmg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(39850400004)(346002)(376002)(230922051799003)(230273577357003)(230173577357003)(451199024)(186009)(1800799012)(64100799003)(31686004)(6512007)(2616005)(478600001)(26005)(6666004)(38100700002)(31696002)(36756003)(86362001)(2906002)(41300700001)(83380400001)(53546011)(6916009)(4326008)(316002)(66556008)(66476007)(6486002)(5660300002)(6506007)(66946007)(8676002)(8936002)(43062005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NWdsMjhUYkthKzZ1L1owUm9jc3Q4ajZ3aElabDJWUENzMEpVMnh1WXp0Kyt1?=
 =?utf-8?B?bnlTNS9KT2xmbmhmZFo1dlNlQlhpbWEvT0RteHVzZ2xvNWtBYWdYdXZFMVhO?=
 =?utf-8?B?dG0vM2xjemRCODZxbWc4TUw4Y3ZVTzdnSDE1UUFMWHladzNVOTFqQkxVYkR1?=
 =?utf-8?B?SVVxS3EvQi85M3FnQnJyKzhSaktRSHFGWnhySXRJTEZ6Q1Z3TGV0bWxYWEZa?=
 =?utf-8?B?QWovNlJjQld1UjhCNktZenRDbTFCTjBTdXR6YVo2WFZyai9mSXcwVDE3VFBG?=
 =?utf-8?B?SWJ3K1B1bkpCM3J5TEF4KzV3b29MUThGWXMwQTR1cDFDbTlJWlpSQ1J6Y1gv?=
 =?utf-8?B?R2hML1l4TTJ4bU4xUERGS0dEU1gzbk5YeEQ3c3lyTlVIRG9kYm9may9oL05u?=
 =?utf-8?B?SFJIa1RDRkJyazRicy9rOTV4NXM2TEkra0Q2NjVpS1JvbzRCeUVGWE5ySS9H?=
 =?utf-8?B?czdOem5JL3dOSnFtMzhiRndNUFl3TUxIQUU0bjZhR3ZLK3hLNjNMSTl6S0ls?=
 =?utf-8?B?MnJHZFJMZGhHS3ZwNXU0am4zQVkvbVRxSUx6ckh4YzM2REhaUHpzVGlYUnlY?=
 =?utf-8?B?S3V3bC9FdkQ3bVlJZmJzTUF1SU4zRVZzdGlzd3MrbVBkN2FjUHRnNFNJWlhM?=
 =?utf-8?B?ajVIY093RzgwMVJ0UHdCeG8zNVdDMVRnZktlL0tMeHVqTzBBNWphOGdSUENl?=
 =?utf-8?B?T1JSN3k0NUdpbS9QT2tkSVBpS0t0TGVNM09WWGd5YU52dXJYcHROaHhDRGoz?=
 =?utf-8?B?N2FsdkpNbTZGV09tVEYzdWFjY3hONENROTBYK0tYMDAxb1E3bitHbk5NbE1W?=
 =?utf-8?B?ZkZ2ZDl4VnpvTjJYTGJGem4xb1N2NkRaeTQyWk9kbjV6SWNXR3JvUXFSM09t?=
 =?utf-8?B?N3g5K2ZmZFBxTHk3eVR3V2FLaWF3TXExWkJSYzZ3VGN6VkpYb3ErenlYS2gz?=
 =?utf-8?B?aVBQbWYzV1pKYjU1R2FrdGYrdmhpZW9XNk1BRmp4L2c5U3Q0U2JJYVJhSzEz?=
 =?utf-8?B?NVd0UmdmdVhicnpqbmdObkVWQ1UyUXVndjRSUlVDTmtPRXc2OXFKV2FUSXhZ?=
 =?utf-8?B?bjNjSzJOdkhLaGRMMkt4Z1UxWGVabDl2WXgzeW00VzBqV1piQnR0RjRmbjFw?=
 =?utf-8?B?V1hnQjJXOFkzVDl5ZStIQmJsTnV2TWlieVpUMEhQdSt1eUJHUlp1TGFBeDI0?=
 =?utf-8?B?Qmk1Nm8yUStiVVh4K2VLQTlWYjYrQm1Fd1c2V3NCSVhrcTIrdU1ramxxck00?=
 =?utf-8?B?VEZFam9SWFNHbkhUSkF0cnVRQ2ExU0hxVkdodkpCdm9OTHZsdzMvU294VTI4?=
 =?utf-8?B?aGhycFJYQWVTbDBLdXBwVlZVdUViSDB4Vng2VnllT0U5b2VnQ1Z1NGRTMG5T?=
 =?utf-8?B?YkFFRG5haTdKb3o2cjMrNnFQTGV4QUNOdGNML3gvWFZFTmF3M2VtRnozdXNC?=
 =?utf-8?B?S3h5MVVzTzRhdE9BWDNsUnFzc0ExRzlSUEt6dGVOL2tTbCtPWUFhZVNNcHFn?=
 =?utf-8?B?MEJxWFA5TzJMdFNHKzdnSDlKamM5M0dIdUFPL0UySnhXQ1RtNnhDcjFhZ0U5?=
 =?utf-8?B?aVZEK2Y5UHBvNWhFNi9tUDhrTDIwSWkweGxkNXVZU0hSaGVqMWNPK3FiU2RL?=
 =?utf-8?B?UkZPTTgzY2xnMTVPM3lmTjZsdUMxMjY0WHd0dElKSmYwTWFKUEo2aGlnR1Jy?=
 =?utf-8?B?aDBFTmlXMVZsUkJaNm1rbTF2S2R2bktHd3hrRDRieTBTTmZLU3Z6d1JPcWFI?=
 =?utf-8?B?TzFhaXZXNGRiaVhDK3JJS0hKUjVHcnRBVW42ald0MjlrVUVyTlB0ajNrdEVt?=
 =?utf-8?B?YnU1RVJUMmpGeU9TZjM0Rll1L1lVZ1pKbzVpekMvc2tzK2hqNnNvUzR5RU51?=
 =?utf-8?B?OTl2KzJzWWFESy9ITlVnUlBGRHlBcFJHU1gwajZGOHpkYTJmazloNk9jM2pm?=
 =?utf-8?B?ek5IcDk3TU5ta29nUCtUUS9wU08xSUJLZjM5T0xJTjZTaFpicFZWNUxxQWhV?=
 =?utf-8?B?eFZUcnJ3Mnc5SFh2N1FxL1FpUnBCMDBzYnpvc3c2Z0xwNzZMRFhSd1VTZUpl?=
 =?utf-8?B?eFBCdWFDeVU2cnF1OFBoSlJvblBXaWZUWTlsQmNMUTY2U2xZRGx5dHJCbnZj?=
 =?utf-8?B?VnJ6aXZBSXBIS0NSa25VQmxnTDR2a1NPWkNwSisycnEyZ2Y3MjJKcXZINXBu?=
 =?utf-8?B?aXc9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee1ba80b-3e54-4cb2-2573-08dbf088b520
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 03:10:14.8836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nt5kbsYPvqtQ5Vq0kL4pMiC3L/mIr1citOL/0FQPNSHrdZ1UcVM+WpqPtC3fTE/Vg8zUuOxcZlBBHfOCNxhL5NF2OBVvZ9nKJSNv0BixqpA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5182
X-Proofpoint-GUID: 846hCD5ajtzCiXba6fKtBEKg2EgEOG3h
X-Proofpoint-ORIG-GUID: 846hCD5ajtzCiXba6fKtBEKg2EgEOG3h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=900 clxscore=1015
 impostorscore=0 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311060001 definitions=main-2311290022


On 11/29/23 5:57 AM, Frank Li wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> On Tue, Nov 28, 2023 at 10:38:41AM -0500, Frank Li wrote:
>> On Tue, Nov 28, 2023 at 12:43:59PM +0800, wangxiaolei wrote:
>>> Hi
>>>
>>> When I executed the following command to do dmatest on the imx8qm platform,
>>>
>>> I found that the timeout occurred on the current mainline kernel:
>>>
>>>
>>> modprobe dmatest run=1 iterations=42
>>>
>> dmatest use mem to mem transfer. It seldom used at actual system. Let me
>> check it.
>>
>> Frank
>>
>>> I found that the completion interrupt was not received in
>>> fsl_edma3_tx_handler().
> I test at imx93, it works. I supposed it is the same as 8qm.
>
> echo dma0chan0 > /sys/module/dmatest/parameters/channel
> echo 2000 > /sys/module/dmatest/parameters/timeout
> echo 1 > /sys/module/dmatest/parameters/iterations
> echo 1 > /sys/module/dmatest/parameters/run
>
> I add debug message:
>
> [  154.090765] fsl_edma_tx_chan_handler
> [  154.094711] fsl_edma_prep_memcpy 8d842340 8d839280 7104
> [  154.100063] fsl_edma_tx_chan_handler
> [  154.103949] fsl_edma_prep_memcpy 8d8419c0 8d838580 4288
> [  154.109265] fsl_edma_tx_chan_handler
> [  154.113235] fsl_edma_prep_memcpy 8d840ec0 8d838340 6016
> [  154.118573] fsl_edma_tx_chan_handler
> [  154.122508] fsl_edma_prep_memcpy 8d841c00 8d83a8c0 1920
> [  154.127791] fsl_edma_tx_chan_handler
> [  154.131738] fsl_edma_prep_memcpy 8d840040 8d838200 14784
> [  154.137272] fsl_edma_tx_chan_handler
> [  154.141171] fsl_edma_prep_memcpy 8d840280 8d838080 15616
> [  154.146716] fsl_edma_tx_chan_handler
> [  154.150598] fsl_edma_prep_memcpy 8d840e00 8d838f40 4928
> [  154.155915] fsl_edma_tx_chan_handler
> [  154.159858] fsl_edma_prep_memcpy 8d8419c0 8d838040 7424
> [  154.165203] fsl_edma_tx_chan_handler
> [  154.169140] fsl_edma_prep_memcpy 8d841700 8d839380 2560

Hi Frank

I followed your steps and tested on imx8qm, but the timeout still 
occurs, and the interruption was still not reported:

echo dma0chan0 > /sys/module/dmatest/parameters/channel
[  401.285217] dmatest: Added 1 threads using dma0chan0
echo 2000 > /sys/module/dmatest/parameters/timeout
echo 1 > /sys/module/dmatest/parameters/iterations
echo 1 > /sys/module/dmatest/parameters/run
  dmatest: Started 1 threads using dma0chan0

[  452.292899] dmatest: dma0chan0-copy0: result #1: 'test timed out' 
with src_off=0x40 dst_off=0x8c0 len=0x3180 (0)
[  455.362690] dmatest: dma0chan0-copy0: result #2: 'test timed out' 
with src_off=0x880 dst_off=0x840 len=0x35c0 (0)
[  458.433127] dmatest: dma0chan0-copy0: result #3: 'test timed out' 
with src_off=0x2200 dst_off=0x2f80 len=0xbc0 (0)
[  461.505112] dmatest: dma0chan0-copy0: result #4: 'test timed out' 
with src_off=0x400 dst_off=0x22c0 len=0x940 (0)
[  464.581047] dmatest: dma0chan0-copy0: result #5: 'test timed out' 
with src_off=0x8c0 dst_off=0xa40 len=0x2b80 (0)
[  467.653415] dmatest: dma0chan0-copy0: result #6: 'test timed out' 
with src_off=0xdc0 dst_off=0x1300 len=0x1140 (0)
[  470.721481] dmatest: dma0chan0-copy0: result #7: 'test timed out' 
with src_off=0x1ec0 dst_off=0x900 len=0x1980 (0)
[  473.792990] dmatest: dma0chan0-copy0: result #8: 'test timed out' 
with src_off=0x500 dst_off=0xac0 len=0x31c0 (0)
[  476.865088] dmatest: dma0chan0-copy0: result #9: 'test timed out' 
with src_off=0xf40 dst_off=0x7c0 len=0x1a80 (0)
[  479.937155] dmatest: dma0chan0-copy0: result #10: 'test timed out' 
with src_off=0x240 dst_off=0xc0 len=0x23c0 (0)
[  483.013144] dmatest: dma0chan0-copy0: result #11: 'test timed out' 
with src_off=0x6c0 dst_off=0x940 len=0x2e00 (0)
[  486.081045] dmatest: dma0chan0-copy0: result #12: 'test timed out' 
with src_off=0xe40 dst_off=0x15c0 len=0x2a00 (0)
[  489.153248] dmatest: dma0chan0-copy0: result #13: 'test timed out' 
with src_off=0x700 dst_off=0xc00 len=0x2640 (0)
[  492.226221] dmatest: dma0chan0-copy0: result #14: 'test timed out' 
with src_off=0x1b80 dst_off=0x1740 len=0x1840 (0)
[  495.300954] dmatest: dma0chan0-copy0: result #15: 'test timed out' 
with src_off=0x980 dst_off=0x140 len=0x34c0 (0)
[  498.373058] dmatest: dma0chan0-copy0: result #16: 'test timed out' 
with src_off=0x14c0 dst_off=0xe80 len=0x100 (0)
[  501.445433] dmatest: dma0chan0-copy0: result #17: 'test timed out' 
with src_off=0x880 dst_off=0xc80 len=0xe80 (0)
[  504.513108] dmatest: dma0chan0-copy0: result #18: 'test timed out' 
with src_off=0xc00 dst_off=0x3b80 len=0x380 (0)
[  507.585497] dmatest: dma0chan0-copy0: result #19: 'test timed out' 
with src_off=0xd40 dst_off=0xec0 len=0x2c40 (0)
[  510.661497] dmatest: dma0chan0-copy0: result #20: 'test timed out' 
with src_off=0x880 dst_off=0xd80 len=0x24c0 (0)
[  513.729262] dmatest: dma0chan0-copy0: result #21: 'test timed out' 
with src_off=0x1080 dst_off=0x1680 len=0x22c0 (0)
[  516.805534] dmatest: dma0chan0-copy0: result #22: 'test timed out' 
with src_off=0x11c0 dst_off=0x300 len=0x2700 (0)
[  519.873187] dmatest: dma0chan0-copy0: result #23: 'test timed out' 
with src_off=0x940 dst_off=0x0 len=0xb40 (0)
[  522.949304] dmatest: dma0chan0-copy0: result #24: 'test timed out' 
with src_off=0x3340 dst_off=0x1640 len=0x400 (0)
[  526.021006] dmatest: dma0chan0-copy0: result #25: 'test timed out' 
with src_off=0x1b00 dst_off=0xc80 len=0xdc0 (0)
[  529.089833] dmatest: dma0chan0-copy0: result #26: 'test timed out' 
with src_off=0x24c0 dst_off=0x2bc0 len=0xf80 (0)


thanks

xiaolei


>
> Frank
>
>>> I didn't find any special configuration from the manual. Can anyone give
>>> some suggestions?
>>>
>>>
>>> thanks
>>>
>>> xiaolei
>>>

