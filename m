Return-Path: <dmaengine+bounces-369-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E4B803A93
	for <lists+dmaengine@lfdr.de>; Mon,  4 Dec 2023 17:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E3671C20B19
	for <lists+dmaengine@lfdr.de>; Mon,  4 Dec 2023 16:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED0B2E626;
	Mon,  4 Dec 2023 16:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Nc3UwrLb"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2066.outbound.protection.outlook.com [40.107.100.66])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EA09A
	for <dmaengine@vger.kernel.org>; Mon,  4 Dec 2023 08:41:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FF2uXzWtMH3Av7X87lBOVcxXU64GDF94xWNDlDuasmsOGktUmyW3gHE6LwxQ/9bKE0U6F7E7w6+NR/Ly2nJs/HQm6lNUkAmPdCk/9wVAJey1LlmVMKHJf/ntQLNldvvqgSkZuieu/4zLBl/nD8iJpPs/h7Akl6fK9OBZGIm7Vo/dQ3FPCOcFGAqBYe9E2wF85KDs+ee8YbJeearuZvGXNIuEAuWx/Jq1s79eAWuseeXtoW83X649gl/gH+YA3kxAhlewkAwEgRtyv0j846enYJjepzEbXL+CnpaR7M6YoAPXJi56UqDELw2WcbjTb1TeudyHuSC4cAFMpCbQl0BAKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jZ+BafyCl5EuuW75v0DveQ2MI6iiIIJwQYuHRngxJ80=;
 b=Lpyixi8gpepjK8gQtnbDtGzmA1cXGWpKSvk7RahrOO+bgX3y+as0HCRY0Fvd2C4haugWCwhEgE9dZgh88cAJbhLNcodkb7B1vNVGMIxIWNGFRZ/r2xoMKezyOGCQTR7pzsV12tIG8eWnu13OeOuzniRWh79FJdbSrzibRMIkEctu9pTgyEia7D8NtFe2GGdwc5jiH/Xnc3R518b+7PO2XdOscrRlYmIBUhuFO19nL6izVi1pNHl8xXF7zB3KvvTmvvEYIp25ue3CFjx619mzMbZiEZZv2SAQrFS2p4GgkPQi2qbDKBdklqBc8Hg+mJ4+pP1Pf6hXhSWiiXH6JY96QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZ+BafyCl5EuuW75v0DveQ2MI6iiIIJwQYuHRngxJ80=;
 b=Nc3UwrLbuu7UWKW0o4AUFDQuUfZuyipJ3SqQrMMloVjH+y2Oe6NkIhdP7vVws2KTGs7uy04R5Unp6mhdpSLpHGdHjEd+sEn3XV9Ras+CAyPUCBYoCgy8q+6Dp5SYjzweZVJCZc2foiU7+laKzX+kFq6+AVHomweF6IlrBR06AmI=
Received: from MW4PR04CA0129.namprd04.prod.outlook.com (2603:10b6:303:84::14)
 by BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 16:41:13 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:303:84:cafe::4b) by MW4PR04CA0129.outlook.office365.com
 (2603:10b6:303:84::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33 via Frontend
 Transport; Mon, 4 Dec 2023 16:41:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Mon, 4 Dec 2023 16:41:11 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 4 Dec
 2023 10:41:11 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 4 Dec
 2023 10:41:10 -0600
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Mon, 4 Dec 2023 10:41:10 -0600
Message-ID: <ba61dfb1-cd79-ccec-5837-7daed3b23191@amd.com>
Date: Mon, 4 Dec 2023 08:41:10 -0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 4/4] dmaengine: xilinx: xdma: Add
 terminate_all/synchronize callbacks
Content-Language: en-US
To: Miquel Raynal <miquel.raynal@bootlin.com>, Jan Kuliga
	<jankul@alatek.krakow.pl>
CC: Brian Xu <brian.xu@amd.com>, Raj Kumar Rampelli
	<raj.kumar.rampelli@amd.com>, Vinod Koul <vkoul@kernel.org>, Thomas Petazzoni
	<thomas.petazzoni@bootlin.com>, Michal Simek <monstr@monstr.eu>,
	<dmaengine@vger.kernel.org>
References: <20231130111315.729430-1-miquel.raynal@bootlin.com>
 <20231130111315.729430-5-miquel.raynal@bootlin.com>
 <674c7bf3-77dd-9b44-a2cb-8e769a2080df@amd.com>
 <f2192d19-08e6-4f8b-b15c-f8bf44f9058b@alatek.krakow.pl>
 <20231130202339.5feac088@xps-13>
 <d27730fb-1c45-41e6-8cad-da172adf99d0@alatek.krakow.pl>
 <20231204120253.2591eb0b@xps-13>
 <5ab105ae-2c10-45db-b5ae-f58e2f9ce8da@alatek.krakow.pl>
 <20231204153621.76f30a8f@xps-13>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20231204153621.76f30a8f@xps-13>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|BL1PR12MB5874:EE_
X-MS-Office365-Filtering-Correlation-Id: eaa407d1-573a-4f4e-58b5-08dbf4e7d336
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/Bv5qztjBSjajtXYs01WuZXZ/ntJf8GPGvsMc0Gd3E3Q3teTkfe4iDrUU5lnimY2owGkjdH8sQSELLHuIegmOEYGr+IuW0E9+Mk5f5gS3a0TXXqaVxiEanXiHJsD6BLdyZ1p9pGDJph0pOARjb3P3dereI7q5FGjvxx+j5/9uy2KUONaZ/Pw7FU330zinBPCT4+1XAsrkG80qf1ucjlPjogHxp8dZ912WsZBVmJYl/b+Dz6bVknJyONf9rJ107LrJXnlvu4mvjGQ3wb0gx978IX+J/RnwAel0EBtJPUugVSDp8P/tVIk4f0P5zOmOcjt8UZb3x+JOk5zQ0BJDZ8fuASQPqCMAG381H/j9vBWMYGvCUfdPMqBzIJnShSsiMql/xeoR8aF8epYukJhZyBGAYN8t9CsdcnNjb2744QW5O+uIJ8nodF/ULCszRVZL6s/4gV1ZxVraGWlAGQXzEbUtR5b1Afn33tanaXctcwo4JsPgtaxdCLheLppr7CYb64a5DPqog++KAsE9OeXclwVQ1hvbKNBTLxDK4DL2ecqEFnRnVdIefWyCkBj+Ovea4WeKwr91TNsRt6dM6tBk6ikMGAoLlrHJp7PhozHAGAbslRLE9vmOVNMlZmBeOLEoMb/payyMxqcclpEJMEQZc4R/MRkMFRSxuSCSD7ymgNekwmH+caoweXp05i0qhg9wIz66OwQs3OYTXy3dyMPIKDE4fgP+AYBGCXD+iaktjXwdxx4nHBGHvQbL+1JHqYxbCJdz5WyqHyRn1fHVr/ssfChm+ITiw2TwNNZ0vp3icTE+z763evrl7KQmUQmZEsGVgX1
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(64100799003)(451199024)(186009)(82310400011)(1800799012)(46966006)(40470700004)(36840700001)(40480700001)(5660300002)(31686004)(316002)(110136005)(54906003)(40460700003)(4326008)(66899024)(44832011)(70586007)(16576012)(70206006)(41300700001)(47076005)(2616005)(26005)(426003)(83380400001)(336012)(66574015)(36860700001)(8676002)(31696002)(8936002)(86362001)(36756003)(2906002)(356005)(53546011)(81166007)(478600001)(82740400003)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 16:41:11.9671
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eaa407d1-573a-4f4e-58b5-08dbf4e7d336
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5874


On 12/4/23 06:36, Miquel Raynal wrote:
> Hi Jan,
>
> jankul@alatek.krakow.pl wrote on Mon, 4 Dec 2023 14:13:13 +0100:
>
>> Hi Miquel,
>>
>> On 4.12.2023 12:02, Miquel Raynal wrote:
>>> Hi Jan,
>>>    
>>>>>>>> +    vchan_synchronize(&xdma_chan->vchan); +} + /** *
>>>>>>>> xdma_prep_device_sg - prepare a descriptor for a DMA
>>>> tr
>>>>>> ansaction
>>>>>>>> * @chan: DMA channel pointer @@ -1088,6 +1154,8 @@ static
>>>>>>>> int xdma_probe(struct platform_device *
>>>> pd
>>>>>> ev)
>>>>>>>> xdev->dma_dev.device_prep_slave_sg =
>>>> xdma_prep_device_sg;
>>>>>>>> xdev->dma_dev.device_config = xdma
>>>> _de
>>>>>> vice_config;
>>>>>>>> xdev->dma_dev.device_issue_pending =
>>>> xdma_issue_pending;
>>>>>>>> +    xdev->dma_dev.device_terminate_all = xdma_term
>>>> in
>>>>>> ate_all;
>>>>>>>> +    xdev->dma_dev.device_synchronize = xdma_synchr
>>>> on
>>>>>> ize;
>>>>>>>> xdev->dma_dev.filter.map = pdata->
>>>> dev
>>>>>> ice_map;
>>>>>>>> xdev->dma_dev.filter.mapcnt = pdat
>>>> a->
>>>>>> device_map_cnt;
>>>>>>>> xdev->dma_dev.filter.fn = xdma_fil
>>>> ter
>>>>>> _fn;
>>> Not related, but if you could fix your mailer, it is a bit hard to
>>> track your answers.
>>>    
>> Thanks for pointing this out, I didn't notice it. From now on it should be okay.
>>
>>>>>> I have already prepared a patch with an appropriate fix, which
>>>>>> I'm goi
>>>> ng to submit with the whole patch series, once I have interleaved
>>>> DMA transfers properly sorted out (hopefully soon). Or maybe should
>>>> I post this patch with fix, immediately as a reply to the already
>>>> sent one? What do y ou prefer?
>>>>> I see. Well in the case of cyclic transfers it looks like this
>>>>> is enoug
>>>> h
>>>>> (I don't have any way to test interleaved/SG transfers) so maybe
>>>>>   maintainers can take this now as it is ready and fixes cyclic
>>>>> transfers, so when the interleaved transfers are ready you can
>>>>> improve these functions with a series on top of it?
>>>>>    
>>>> So I decided to base my new patchset on my previous one, as I
>>>> haven't seen any ack from any maintainer yet on both mine and your
>>>> patchset. I'm going to submit it this week.
>>> Well, the difference between the two approaches is that I am fixing
>>> something upstream, and you're adding a new feature, which is not
>>> ready yet. I don't mind about using your patch though, I just want
>>> upstream to be fixed.
>>>    
>>>> This specific commit of yours (PATCH 4/4) basically does the same
>>>> thing as mine patch, so there will be no difference in its
>>>> functionality, i.e. it will also fix cyclic transfers.
>>>    
>> Okay, so as far as I understand, you'd like me to submit my patchset based on the top of yours.
> That would be ideal, unless my series get postponed for any reason.
> I believe the maintainers will soon give their feedback, we'll do what
> they prefer.
>
> I believe Lizhi will also give a Tested-by -or not-.

Yes, I verified this patch set for sg list test and it passed.

Tested-by: Lizhi Hou <lizhi.hou@amd.com>

>
>> I guess maintainers will be fine with that (so do I). If so, what is the proper way to post my next
>> patch series? Should I post it as a reply to your patchset, or as a completely new thread
>> with a information that it is based on this patchset?
> You can definitely send an individual patchset and just point out that
> it applies on top of the few fixes I sent.
>
>> I don't want to wait with submission
>> without getting any feedback until your patches are going to be upstreamed.
> Of course.
>
> Thanks,
> Miquèl

