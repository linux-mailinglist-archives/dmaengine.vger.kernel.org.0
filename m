Return-Path: <dmaengine+bounces-1895-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F158AA130
	for <lists+dmaengine@lfdr.de>; Thu, 18 Apr 2024 19:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A35DF1F2159E
	for <lists+dmaengine@lfdr.de>; Thu, 18 Apr 2024 17:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB27D174EC0;
	Thu, 18 Apr 2024 17:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="miUGmtJ2"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D17915E20F;
	Thu, 18 Apr 2024 17:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713461752; cv=fail; b=o7iDb3ye5y+As9iR14S4w/qiAqZ+QawlDyGrnii0ywrSvjtY6704J5vbKxWQBY/OAbxyNUgHt2SW3MciJwcKgaYcD1mjvLttvdtfECUMo792Zuji3+njTmdrveyhM+hLoCQyAxvk00wJEfCSJnbo4aWM6RKPP2zR6RGXdwUx5Gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713461752; c=relaxed/simple;
	bh=1Pr6EOipblG0g1zN/qd6G5sZOuQvd5mzrRiZl/OF3Lc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ScuDZJZIgEWPQ3yx0W7OznjvYmnb3IvkUKMGIJ/8uIhb+1/kpp9QySWoihcJ/ItNTDISR9oJlyZmnZJCTw0IN6KT9lbXyjw7uCoLRXyi3OzbKQOExY0Goj9w+EEnzp5HXKSR03lMTe4TBRbOV5jAnOpPoiPXQo2lSXn3K2bzhGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=miUGmtJ2; arc=fail smtp.client-ip=40.107.236.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AgEnSlX03q+sVRcFGQ5qEfgAQriJkR8tlXR56/JQd1NLcf5i6U79GPRiwPpGtKzPy7TwiUtLsgv4sdTX4BBVBVcqzntfw1G9X3rcTWouTHRiFOkJqSpK760lDjVOp6CVldfwVBgBrXIyi/voBNPnYuKj62Ef6qTAigECK7qNyGosqTOgTDpBZhYgSeZuIVMf6IfvwDNZITzVr5czeWDBXGCmuplp/F1vMc3I9p+FyiXoWTyPi2xVrRueDuqBXT46tfBp0DIibfpNeWAZTst7we98gQVaNMc0LKbs2y3XA9JTE3P2fsry0o08AWcWxm+fAbood7ZLfEnt1Roy8RJRCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlK5ulDczFrQEBZJY55+YmXXd2w8e11kcN7+h3FHP28=;
 b=ciDNI4+0VgD2zmGa62wEK0bW87kRPOB9PonQGCyNBUXm0oKYERYJd7uH0OFSForyAYoBLJn4oEQECAfGVuSBybAEbYxHjZu8R7NGvs61LYurCBp44VfDZnvU28C0GBTnBjSXKbS7v6BrJ9Hq58hmwstMnmBV/YUBJI4bHztboRP5v6B31quQrpdzWJg7fHMn31E3tS1qjVk8CFB5w+yw6FaIepDG954RfljT3xS9ZePUaUSTRMBoA9/7UxSDyLzXgdrtdIuFAfkV/TpfbQpZ4J7NxSfPWfDGDlBBLfr/Q9xgwvUpqoloTF7idsIrK9amNL988HQuYTnWeGAJpn0PfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlK5ulDczFrQEBZJY55+YmXXd2w8e11kcN7+h3FHP28=;
 b=miUGmtJ2QeZCE6DBsdGnWGGwxWPstwpqK62mjDwmEdX6yuxdFTzSgDdV90mfAh/FddwVjqlK1JU74ASccpnDW2lM3OLtWgE89VuDmV3HYo35IDAMh3AWzftHTkhOs7iGKfKvf+8IynHIfgD8VkFCam2nAN+TuALz6roWL0LZpaI=
Received: from BY5PR16CA0009.namprd16.prod.outlook.com (2603:10b6:a03:1a0::22)
 by DM4PR12MB8557.namprd12.prod.outlook.com (2603:10b6:8:18b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.52; Thu, 18 Apr
 2024 17:35:46 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::71) by BY5PR16CA0009.outlook.office365.com
 (2603:10b6:a03:1a0::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.27 via Frontend
 Transport; Thu, 18 Apr 2024 17:35:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 17:35:45 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 18 Apr
 2024 12:35:45 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 18 Apr
 2024 12:35:44 -0500
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 18 Apr 2024 12:35:44 -0500
Message-ID: <5e2e2539-38e0-1d3c-62c2-da986da1c68f@amd.com>
Date: Thu, 18 Apr 2024 10:35:44 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V10 1/1] dmaengine: amd: qdma: Add AMD QDMA driver
Content-Language: en-US
To: Vinod Koul <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Nishad Saraf
	<nishads@amd.com>, <nishad.saraf@amd.com>, <sonal.santan@amd.com>,
	<max.zhen@amd.com>
References: <1709675352-19564-1-git-send-email-lizhi.hou@amd.com>
 <1709675352-19564-2-git-send-email-lizhi.hou@amd.com>
 <ZhKd7CHXHB7FadY0@matsya> <aa6a63c0-7cce-1f49-4ae5-3e5d93f98fe5@amd.com>
 <ZiAA3C4wXaAHcJ1E@matsya> <14402251-5731-1e52-e787-734d3eb3c801@amd.com>
 <ZiFTheOik-2jsfXP@matsya>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <ZiFTheOik-2jsfXP@matsya>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|DM4PR12MB8557:EE_
X-MS-Office365-Filtering-Correlation-Id: 1630190d-ddfb-4caa-e8b7-08dc5fcdfab7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	D8Uy9IBGhJew4SY8vgILqQj8end/62+KoB8DVPNqJea33kyTuUCWrRrjtyuQ+IRnGN7rSyEEFQv0MUDv9k9Y8Qr2z/53IrZ45yXD3W4WxMG3TT8QPOhsn9wwdRt122yzJFyDZ0jX2+KYUX28S1fbeLcncUhaJN0saCvEEM4IQP5zUyQAraU6pVbh4Eg68kq5vHfNm6O3leNawEerrPI4lF5OOKz54k1q5G/9/BsGn+wSVTBF9EUwy4HUUABWm3jmUHan/aJxUBSmH9GY+qPzb509lgTZXDpDIn9V2/HrzNS+VXMXeD38PWiaeSVmdGrsXxNUYlp2l22POF2HeYhyULViGLycfYWFsDtgZWh0bGfbGu/Sg6+EH33Vf3FZ0TphuO2+vOeMU7+NpxM7g5okxA22PLx1QkrK7XT+pzVuYGQ9bD8/NxbF2Waay7W+4KN/PQdHW0GIoZiq/tA2c2QOgZ2YkPXr5AFKj7/vwar6OhkH2KEegYL1PfW3nrJR4wr1Q7q5Ee3C6zthzYxHzf9EzoqrEqqG17oOTARhdNSsnXYXWb7iQ/eo25R87WFulV8c7lxuBehNqdDvtbzr4pcxMet4ZHak/xltrKhz/aU8e0H9MaVqji2p0vb/jr+7LRD+YbWYsNJVR2C7KuXEeoNe3TAGL4t+fN4JcpimhFsOlTq4nPSRj0SA9TLVadqWegqh+qpwbNO8IT2lEfITioTuQA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 17:35:45.7808
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1630190d-ddfb-4caa-e8b7-08dc5fcdfab7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8557


On 4/18/24 10:08, Vinod Koul wrote:
> On 17-04-24, 10:53, Lizhi Hou wrote:
>> On 4/17/24 10:03, Vinod Koul wrote:
>>> On 08-04-24, 11:06, Lizhi Hou wrote:
>>>
>>>>>> +static void *qdma_get_metadata_ptr(struct dma_async_tx_descriptor *tx,
>>>>>> +				   size_t *payload_len, size_t *max_len)
>>>>>> +{
>>>>>> +	struct qdma_mm_vdesc *vdesc;
>>>>>> +
>>>>>> +	vdesc = container_of(tx, typeof(*vdesc), vdesc.tx);
>>>>>> +	if (payload_len)
>>>>>> +		*payload_len = sizeof(vdesc->dev_addr);
>>>>>> +	if (max_len)
>>>>>> +		*max_len = sizeof(vdesc->dev_addr);
>>>>>> +
>>>>>> +	return &vdesc->dev_addr;
>>>>> Can you describe what metadata is being used here for?
>>>> The metadata is the device address the dma request will transfer
>>>>
>>>> data to / from.  Please see the example usage here:
>>>>
>>>> https://github.com/houlz0507/XRT-1/blob/qdma_v1_usage/src/runtime_src/core/pcie/driver/linux/xocl/subdev/qdma.c#L311
>>>>
>>>> Before dmaengine_submit(), it specifies the device address.
>>> Hmmm, why is the vaddr passed like this, why not use slave_config for
>>> this
>>>
>> This is because the hardware is capable to process multiple vdesc at one
>> kick off.
>>
>> For example, there are two pending vdesc: vd1 and vd2. If there is enough
>> free
>>
>> space in hardware queue, the vd1 and vd2 can be put in queue, and do one
>> kick off
>>
>> to transfer both vd1 and vd2.
>>
>> The destination device address of vd1 and vd2 could be any valid device
>> address.
>>
>> desc_metadata_ptr seems helpful for the per vdesc destination device
>> address.
>>
>>
>> If using slave_config, it needs to call dmaengine_slave_config() and
> That would be the right thing to do...
>
> - set parameters and call dmaengine_slave_config()
> - prep transfer for vd1 dmaengine_prep_slave_sg()
> - set parameters and call dmaengine_slave_config()
> - prep transfer for vd2 dmaengine_prep_slave_sg()
> - submit vd1
> - submit vd2
> - issue_pending
>          - you see you can issue both as you have space, so do that
>
> This should be done always to maximize the dmaengine thoroughput

Thanks for your comments. I will change this.


Lizhi

>
>> dmaengine_prep_slave_sg() with a lock protection. Is this what you would
>> recommend?
>>
>>
>> Thanks,
>>
>> Lizhi

