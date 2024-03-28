Return-Path: <dmaengine+bounces-1625-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AA889064F
	for <lists+dmaengine@lfdr.de>; Thu, 28 Mar 2024 17:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00FA21F28324
	for <lists+dmaengine@lfdr.de>; Thu, 28 Mar 2024 16:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0403BBF9;
	Thu, 28 Mar 2024 16:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BAq5l3fC"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321752A8D3;
	Thu, 28 Mar 2024 16:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711644581; cv=fail; b=V8brkBOZHPYJLlHP3eQa7w2vtxOFXSWoozQ1FFuXkYlIU+HpTqSTx703p9ht3FA9ROlHON/ZO1HJMwK5Fueepd4ih36aQS/L7531OUn32BG4SzsO3Ta/0ppXQOKETV7P1UXqdv1eGMHDJEUXPwq5115Q+sAn0WZJFlTUwnnBab4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711644581; c=relaxed/simple;
	bh=H8qQZvKjP/xZzUtA8M54dIhiFexlnmPVlE/3gJ73bWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Lywtu/sitnZCqhbBdhAUhPkbdI63nPOimMjrnZQNVumP5mRKAK5GIjCBM0NQm+XrM7rotfhdhAH53VVnxxV11xH5hQAqAyiV+oyY8MgHcziXy5DjIPWzyGi5B3tNbAtfgAHxdazjyEzdt+yxDLtiH0oahvpZ/ZgQRUr7MBqJ1Iw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BAq5l3fC; arc=fail smtp.client-ip=40.107.92.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gnFO9j+VDoAG/OZ4uV8FROL4vjoEOkkIVU9GlE9DWvD2IwkU4JdvFWC5CIgbJXpjpBqLf02YXi7aXOK8T0C2TAAmqaVs/tZJ4SaKHje+EYioPA/lguUwhH+SqDTreexTAWEZZmhzVQyFSWI6Z2EU2RiTqhbM9Pg1PWzL5JcUZf7LnQoVxw8RivWhIRX+O32dfqn7/ag1cayKztwa1KObkKnynW0ErxGW70nKvWt1tJXhtNXVVoXBpWBpWZKx/TTL8D21rwybkUib+i4ijc2PfCdvg89Js5uiMLzDJ2Kt2aGK2W8WdfY0zfBD8ToqYvvkEWSIzrCJbVM24Az91/alFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sz+JJ8M6UaHKqaNSwPwHZC8UDY3ykb/E75Tw7AheXAM=;
 b=ZO1vxfXbAKfGK3R54UZWnZxO/XU5AvN3nC0nya5GFS8LdBM+SZKy/lRtFcDltrqhJqzScG3zrFjqDF/onMuEBSN5tNzttOSb7GLAovNgK8umIvPtFJQ07eFK9gIEMvp/Sw/MkW7i3sI6zm9oUT4HshHhpPxT9l3wULK0EQTodnWM7bEHqXkRaO1C7SQXkcPgN8fuM8NYa1yXQ3f28sgz/RmcZTSHabfeE2Xdrr/WabgLic5I7UDspVnBTQQgX1CdX77oyqWjCM4MtLA3GHzUEsUpvDduu/COf3DVmWS3ugu4kBegHKeFSYwlQvKznL6x69zc/SeJ7U2LZkpyAk13Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sz+JJ8M6UaHKqaNSwPwHZC8UDY3ykb/E75Tw7AheXAM=;
 b=BAq5l3fCxMJGIs0cYBdvH1l9zRMzeDk9H5y6PtPtUy6nXFW0rGBwiqlHkCxZHUVSiz4vJf6CfbD5i7fX4EAekMZhyQIHxaL8E3hOo9IESt43zKMR/1uD/vUenedQTJw0BT5XSMgMebwF+GYUoSFl0n9jJZSnlnW900nEOysSTgM=
Received: from DM6PR07CA0075.namprd07.prod.outlook.com (2603:10b6:5:337::8) by
 CH2PR12MB4054.namprd12.prod.outlook.com (2603:10b6:610:a6::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.32; Thu, 28 Mar 2024 16:49:36 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:337:cafe::4) by DM6PR07CA0075.outlook.office365.com
 (2603:10b6:5:337::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.37 via Frontend
 Transport; Thu, 28 Mar 2024 16:49:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 16:49:36 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 11:49:35 -0500
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 28 Mar 2024 11:49:34 -0500
Message-ID: <fd6ef776-d861-0dc7-2809-27868ca894e3@amd.com>
Date: Thu, 28 Mar 2024 09:49:29 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/3] dmaengine: xilinx: xdma: Fix synchronization issue
Content-Language: en-US
To: Miquel Raynal <miquel.raynal@bootlin.com>
CC: Louis Chauvet <louis.chauvet@bootlin.com>, Brian Xu <brian.xu@amd.com>,
	Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>, Vinod Koul
	<vkoul@kernel.org>, Michal Simek <michal.simek@amd.com>, Jan Kuliga
	<jankul@alatek.krakow.pl>, <dmaengine@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20240327-digigram-xdma-fixes-v1-0-45f4a52c0283@bootlin.com>
 <20240327-digigram-xdma-fixes-v1-2-45f4a52c0283@bootlin.com>
 <b59dd8cd-fd75-5342-d411-817f33e0ff48@amd.com>
 <20240328012257.4a5955f2@xps-13>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20240328012257.4a5955f2@xps-13>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB03.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|CH2PR12MB4054:EE_
X-MS-Office365-Filtering-Correlation-Id: ff2ec159-ca4c-4536-c5aa-08dc4f470d1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5cC7V/W98U6Xk3tUiPPjPUcHZAcY+N6r9xdEt7YTMOH5vqeqcOnDLMuGWEXLM8rCSzXqNIed0AqJSEgUeGZuo3fkRvOK5/aOU9vvlpP1mlfpsv1XKJvFtduxf7oIAX6y2+kOb7/rItRpYDQOXN2FPF45gP8UzafwYW8liujGGWgPuhtJ0vbB1KKLlDYVNJVMS+WONvfi/rjy3WlvCylkcjg19lOTUo9CueKq2VHlG8ntKaPqtsUcX+oOqzcqyThvXJo/H9b+Dtx2XOXf18r2pPsJGXCGQp924EvPQuCwgkPQ+KIXoQng+uj0v+UzLGWu3toXynnxoAu7i1Uu+yBD/YuNxKsFoKCkMTRXgc+9SWP1PT3TCI9aP1dR1qtYOptD1KUIPAvAa9JAUE49Z5WLHHzhl8VeI3rAU4BsNPpukH1p3C0sFVmxsKwEOM3zMrpFjYCOBLnuT5cL716Y1kkZG+YJkAGtLe2GQcCslNMoL4E/Jr7+QCCNAUFu0aCNCAf3ijLw6Nz6cNKzqEmpoWoJ4DWox8Ca1HKZDF87QQUDUysrx2vfpCMIov8+jELwUR23824Or/bq1lpKtqB8QuwkW2TnCRpmj2y6iO5E4UZROkMNkttWDXOoopswdOifG7S8tXlOrmxOpCjmB91m9yl9x6dNvQVzNN+NYIiq++9neapoJ17wTSFOsjgPeJYsYnUIfC2Baj0QUnqIumhcZnHPItdsyoyr8D2SpyTM5reZzxyR/9yK7KB34OEbRFNrMZ0e
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 16:49:36.0379
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff2ec159-ca4c-4536-c5aa-08dc4f470d1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4054


On 3/27/24 17:23, Miquel Raynal wrote:
> Hi Lizhi,
>
>>> @@ -376,6 +378,8 @@ static int xdma_xfer_start(struct xdma_chan *xchan)
>>>    		return ret;
>>>    >   	xchan->busy = true;
>>> +	xchan->stop_requested = false;
>>> +	reinit_completion(&xchan->last_interrupt);
>> If stop_requested is true, it should not start another transfer. So I would suggest to add
>>
>>        if (xchan->stop_requested)
>>
>>                   return -ENODEV;
> Maybe -EBUSY in this case?
>
> I thought synchronize() was mandatory in-between. If that's not the
> case then indeed we need to block or error-out if a new transfer
> gets started.

Okay. It looks issue_pending is not expected between terminate_all() and 
synchronize().

This check is not needed.


Thanks,

Lizhi

>
>> at the beginning of xdma_xfer_start().
>>
>> xdma_xfer_start() is protected by chan lock.
>>
>>>    >   	return 0;
>>>    }
> Thanks,
> Miquèl

