Return-Path: <dmaengine+bounces-1067-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A015785FA3D
	for <lists+dmaengine@lfdr.de>; Thu, 22 Feb 2024 14:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C35811C2160B
	for <lists+dmaengine@lfdr.de>; Thu, 22 Feb 2024 13:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2660134CE5;
	Thu, 22 Feb 2024 13:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MNk6skOy"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7BC12FB02;
	Thu, 22 Feb 2024 13:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708609760; cv=fail; b=bbMfyCX9QCOM43RHV08YI0mM8eL+OQ3Ai4gdt+Dk+urllXXVeTyFN7KrUQFuJ8L4wJhMaj/oQEPDl4tflO2u3eIORa10imVEgddL537zUUec6uJJSePujMaTdFu3RFz3ouA3SlpDUHvI7BVhEoQKEmE7z1lOxXKC/zR93mSoOo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708609760; c=relaxed/simple;
	bh=u2u+RKOPk/b+/oX2/CNnrAcwG9B+52tYh+hlwVqHJAE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tNaTYswf2eLTXzZP0K3sAPes8W2/q5HT82Lj/b9LhSbT5f1LCyXS3YKcTz+wWODvXyVncFMi14t7RyyL+KCUKrFcA3gA2lN/Xv6RC9CsINEQJ5GbetqoIpZcQnNb5qUxqZSARw+Fwnotzz0PGEuvdLkfnGSVjg1yowTUxE7Bw9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MNk6skOy; arc=fail smtp.client-ip=40.107.93.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IHg0l+GRjcFFinWJhqrHu2wSt3edRG8KQu/DUjGDFyYFIEqUzkGidqLO3eUzFMOBD1QzRgV1xZGXS57mI38XHDx4tn94aASsi+8iDAuZfJIWc8+KTKhfVtg012CbmyFytjV7eYFOCVivSv2Ronaz9ZhpU1WYABTtjR8iMNfigUyALjTxUSzyIZtlieQvO8TshZp2wP5OAcjgD6suh1y7Y+pz/AaxP9URYuYkWOjcHhAJLWIINvlv1z7Y6G+zTkJRyVIBW2uvc022y2WvS0A1SyROZ9kved5//tgW7aP14lV1FRAPbQ+IbJYhrWk9XX7bmSXeC16oogtyiUm8I4nadg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fWMHuDnNN9eCVrEJNxLApp/pUScwgwmMTwv5pOUstXI=;
 b=eeYKcaapdL4b1iIdDlNEtLkQq6weiv3HWC6a1sxg4mJ4qMRwJgtdaQJo8lRyTT7Yqa5FH7Ms9B45Z0pEy5yGplw0yDYiWl+UafTC5714oByzYcegwrGW67vGMK4dVq0UFVRkIOkSJl7e7uy+hULACP+jc7VMzeL49OL8p5h1Ejh1bTsKVRh7BgPSHXxHTqi2Lmifjq8U68Pt4KjMPNAQlgFgITonLbernHaoHuFI41u61FvT+liAQE40cNu7SHBlCSj9+4DZWd6VFciMPtxdT32xa8RtAc1NEAIO8rUU31D8KnZj1Sec09TrKlWh9CEfYhXCvNky1KImIP7PlepUbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fWMHuDnNN9eCVrEJNxLApp/pUScwgwmMTwv5pOUstXI=;
 b=MNk6skOydsuE+BJ8a9LD267hyVzHoSIV052q1FPgDEvVGy0ritJR++luwI83TVL6TmMnXpbontLeeyuvdjJmzg0xV5FBqXfZ8jBKxNXtnthfgRiLZwSeuzxOeQyQZKjCmlEVv3deGCL04FPZaBrILeJ6rWqbpFsaM/fXib8hErM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DS0PR12MB7512.namprd12.prod.outlook.com (2603:10b6:8:13a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.23; Thu, 22 Feb
 2024 13:49:16 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::4238:15f2:f66d:d159]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::4238:15f2:f66d:d159%6]) with mapi id 15.20.7316.018; Thu, 22 Feb 2024
 13:49:16 +0000
Message-ID: <cd2783cc-5616-41b7-a6e9-b20cd71706df@amd.com>
Date: Thu, 22 Feb 2024 19:19:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: change in AMD ptdma maintainer
Content-Language: en-US
To: Vinod Koul <vkoul@kernel.org>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240222083004.1907070-1-Basavaraj.Natikar@amd.com>
 <ZddQHZIo8fLCoqec@matsya>
From: Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <ZddQHZIo8fLCoqec@matsya>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0209.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::20) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|DS0PR12MB7512:EE_
X-MS-Office365-Filtering-Correlation-Id: 2316f087-c241-42af-5666-08dc33ad0f60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	098JXyoxA6bq+4NWKQC4xQooiWgXRUD4GPDy9WEeIFJrpbnHg5xkh1wZyh4MH3JXMAtLalt88HU2Bhy8OJG6yNiGR/6089AFWm9ZlBUsrJkoqHTvoNx4AzmUnAYKNOieT9LD8oBk7DoAkggyPD0M12zciSgaEwBrJ6MDdfgxBA9iQjXnuXorVvFoaeiVCRYiIgmCsqvV/057lGJJgnjCSWKJOpHRT7KLekCCrwahvNEJjxmXOp+AYy6gZ9gPrRaacykZVbraVC3gygiOdqBJrOeeECOJVdyADh4YvtweyFywVgWIizuiP33SmEVI5bk00TbicABpHY2jgZ+i4HFXQsKuZg6tKWHuhrCWZb/+OIVzNuivLj3dzMuipIKKSNWU2kbsCdZEU0Zd0EK+OTNGRiyI1HBsjWp05C0TOsEDmCzLco3/MAJYOemqETa10Tn3wupMD3kbLdSW5keb/tdYDkuDaYF1zSqdBE2bSMnJK3wgJjddHSclchesSp5d6r1C/sH71xWET6ghaadSt48eEQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akFSSFQ3M0VxNTZHVzJXTlBGMU5nV1h4YUdVcEV4VzdpaGc2UGhCd3NRMzUv?=
 =?utf-8?B?dXc5REwvdkxnbTV3SmorbVhWOGVzV21ZS3luT0U0Umw4YVJJWGFMTlBVdTA0?=
 =?utf-8?B?b2poRjNsN0tnVUZKY3UwVTk3S3ZwNDZ3VWc3WVJXaXNMUjhLN2VMWXJVM2Fw?=
 =?utf-8?B?ekpwOStVZWJDK0FCMlh6WERaYk16MXlwSzRuOFNMd3lwWC9YSGtUR2h0ZXpU?=
 =?utf-8?B?WGh1dEwweGU1RTFyclIzbTV1aUF4QUE1SVg3bEpuU2MxRDlDREorT2xnZnJW?=
 =?utf-8?B?S2J3QlhoY2JCSDhiNmtxYmlYcXNFeDNQdkZQeEpGeGZXUjF5QUc2bXJrM3RJ?=
 =?utf-8?B?QnpsZ0YranR5S3dKdldnQTc4QjFOWXZKYnRJUG82ZjB6cFZTUzNiUkNMUTFz?=
 =?utf-8?B?QUxQWTFmOHlzTFBheDVjajhCOGFzbGFqQkFJMkxVdE15WWxNWHd1cFhPdGFJ?=
 =?utf-8?B?SVZtbS9BRUpaNUtRa1E4Mk56RU56RkMvZ1B5RXFWVjFHY2hLRlcrNmVuRlhL?=
 =?utf-8?B?ZFg4MnUvdkVLVThjU2d4alk5b0pteEpLNWNRWW8vK1kwQ0xyZVdmUFlLRUk4?=
 =?utf-8?B?RG1uejR0a2NRKzlnU0ZLbjE3QS9wMHh2WE9DQ0ZZUUo2aU1sdHlUY2o0cFhC?=
 =?utf-8?B?L242b1c4ZXdTa0pZYVJJcit1RXhsbFp2QTllbS9Gb0xzNXNUL2dvNk4xbzh0?=
 =?utf-8?B?SDcyV28zZmVPZkZuSnZpTlRpcmEwbDJCWG9GMVRiVGMxb3BxTzFqZFhXTExy?=
 =?utf-8?B?ZlVEQ2dCcGltTnN3aG5uS01MV3UwZ3A3bWdjRlU0L1BVaGhSM2hvZk1weERj?=
 =?utf-8?B?ME5Zb2REenVraEFGekN0M3dldEVJOUVBSE1SdnFMQXEvaWtIaDhMeVh5SmVY?=
 =?utf-8?B?MnJCdXVseENqVmVUZ1QvME9BRXFDU1F0Uk5CUWFNUVQ5akh0SnlmNVUrV2ly?=
 =?utf-8?B?YXNGZ1pSR1hjNnUwMDhJWGl1MXZmYTBtaUtFRTNabDExRFQxbW9vQ1Jhb0xW?=
 =?utf-8?B?N0llWXZyNitNa05MejdXZFpGeldOcXRsdjlndktnOWZTa0tQTzVJVjIyNnFt?=
 =?utf-8?B?Zy9taXEvMStVeU1qYXBuOWZIUWFxU2VQcmRtVW1KQUNiYmdpM0pXYU52dnFG?=
 =?utf-8?B?SDlmSld0Z1JUYjdENkIzaThwMnpOZmZCY3djVFZNZTZUa1dWUHJnbU9hREwz?=
 =?utf-8?B?UkJDb0NSa3BER1pZN2ZqdTgyWGFDOUNMU3phVlUrUTR2aUFIdit2WWg4QjhG?=
 =?utf-8?B?VnpoVHlvSlNjZzFmU1kxMHR3aVhuMlRITitDYlpTeWk5NVhwdENMcExHbnFl?=
 =?utf-8?B?YUpHSEZkNTk4VHBWUUhnUkEySDV2aVFpd0pwd3RWcS9YK1JrVGRZQmxISHl4?=
 =?utf-8?B?c29SM1Z4Mk94aUlBWGFlSWZiUUVKcFJrdk9JQXo0UTJ6ZU80dFhpbzF5Z0Jp?=
 =?utf-8?B?M2ZRdHJ1aWZZblFSOFpOWXloR2tFQXl5N2toOUJXbzR6K3EvQjVQWkNRMTFF?=
 =?utf-8?B?VXFNejdadzFkbnVNNGFPVFRMcEx2UjBvU3JNVHVvdXNHSEptSnBBVWUrdHdh?=
 =?utf-8?B?alRCT3Bid2ZvcXdwZjA4R3ZUcmdBUmtHeHR5ckxqamVpTTNuc0dTZW1laG90?=
 =?utf-8?B?dDdDQ1djQkRObUJzRi9vRUlUMlpRa3c5dlBIWTltd2FrWUdRcm5TMWhTT01J?=
 =?utf-8?B?R200TGNlak5tL2w3THV5V0dLb3l3MndYdG1BbXNnQUFIWkhadzJnN2FxUzV0?=
 =?utf-8?B?TWFpQ3BpOVZrUmNpNVgxenF3R2pwekpYaWg0ODZGQVFpeXNORko4cVI2aUhs?=
 =?utf-8?B?TzhpVVdSK0FGUzZrL0c2RFg2UGVjM0Z2WmxVMnRRK005eTFmQXRYTVJNRSt5?=
 =?utf-8?B?ejEweEJTekxUenViN0EzZ3ErcUlDdjZWTS96RkFHWHd5UTUvK1JmTzlpSmRW?=
 =?utf-8?B?aXJqcVVDWmdYRElGcmpUNWEyL0FTck54Z3ZFRlB3WmhFbGFWZjNlTjIvcGF0?=
 =?utf-8?B?Yk1ZT0FYQ09YQTFFSzVOd3dyYzQzMnVxay9La1ZpMnVlY1dnTkZUa2NtK200?=
 =?utf-8?B?VmZPbnUvd2R0WWJ3VThUWWVGa05tR3gzZW9nUlRsSEhtcktIdGJCanQxOGJm?=
 =?utf-8?Q?AlC8QZk4UD5l6MKMS0/umDToC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2316f087-c241-42af-5666-08dc33ad0f60
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 13:49:16.3405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9BaEkwHOVZskUCUWoB70oeD1GWK2afqJk1OEBhvS9a6QwF5BTtyWfMyZWJzYjeKxjMnSriO0a+c2doCz6Jthiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7512


On 2/22/2024 7:16 PM, Vinod Koul wrote:
> On 22-02-24, 14:00, Basavaraj Natikar wrote:
>> As 'Sanjay R Mehta' stepped down from the role of ptdma maintainer, I
>> request to be added as the new maintainer of AMD PTDMA.
> Should you not CC Sanjay?

Sanjay left AMD below email id is invalid to CC.

Thanks,
--
Basavaraj

>
>> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
>> ---
>>  MAINTAINERS | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index e2c6187a3ac8..becd09410b8c 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1034,7 +1034,7 @@ F:	include/linux/amd-pstate.h
>>  F:	tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
>>  
>>  AMD PTDMA DRIVER
>> -M:	Sanjay R Mehta <sanju.mehta@amd.com>
>> +M:	Basavaraj Natikar <Basavaraj.Natikar@amd.com>
>>  L:	dmaengine@vger.kernel.org
>>  S:	Maintained
>>  F:	drivers/dma/ptdma/
>> -- 
>> 2.25.1


