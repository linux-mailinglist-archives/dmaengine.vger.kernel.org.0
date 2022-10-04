Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730035F48AF
	for <lists+dmaengine@lfdr.de>; Tue,  4 Oct 2022 19:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiJDRiz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 4 Oct 2022 13:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiJDRiY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 4 Oct 2022 13:38:24 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2080.outbound.protection.outlook.com [40.107.212.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED86DEC6;
        Tue,  4 Oct 2022 10:38:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mGVQFQgkn/8l/w/1o91jtHUfgXlIbZnbdkM/LDoSe6Vv3GqSw9HrCsn3MAdUf1UK/4LvBU4M5o6gmxGn8pgaQpPHIbtE5CyIyIuYOoOPyMr96bLceU/8u5z1+k5buYDRflhIUldvV73SLrZoNJK1gXE50UMcdTwZrnNlulifPLUyBMTO7b45tdONbh+iMI4MRQArFNVp2jWGWibPoGDf22VveaKB4k5FaTE6NHHK6oUVTH6EDpsQU0Ga6llM+u/hTckeRqq3pu2m/3cB85Wl0J84+Gr8NNPzCJtOyzgZ3rUoi3uD+YNdgPoV1mBKc2vGSSPybZh5sL+hg5uu6o6EvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OIzdvgxby5kvRu23A6I9NvHerB1v6HgS+8u1CQIO7Fc=;
 b=jAVIDeNHe6obFkOUmKi16IyB5aw3ZJOZh20OWGG+4p/ukcWT35P0p4NZCTXpyz13zxPeF8tUu4VUk5XnD1Xhtr7KB5c5Ik+kbsk+vrJfDGPo8gWt4LdxXFvSbG+803U5LhzjXxLE4BYemVGE0tFIzynqFSk0ac6PHmeCclw7fFK96G7XxdCPym/PG1Pp0rVpCp7kXFauOhHauz3smQR57OEVb24nGGsCmJ6SUzAq4SC6/lzFMwqfI0V7Dba9hIwInxcswCbJ9RVpTGDtYCMyAwB8IqMXp4Fcwk6OauZ/1QUAjgw9QJrINHgCuKOzBD5mTF4s4bwd+NM5FP9jmdl4lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OIzdvgxby5kvRu23A6I9NvHerB1v6HgS+8u1CQIO7Fc=;
 b=MBsSzUIAZ/mblPcGVGiVRfMw03c5yZ+PIwJVD2mLOwZ2fsc/UbRymI7Z/vzPREzFT59AB+ogvEnGDb0hKaTb1HQCUykJs6yOowGn1kjrx7VRfU8HSL4XNVff+sWXunoXgXgZ8gF38S8uhxBdbrjBLT1yKRO8cIGwPyOsOx6pqEc=
Received: from MW4P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::7) by
 PH7PR12MB7353.namprd12.prod.outlook.com (2603:10b6:510:20c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Tue, 4 Oct
 2022 17:38:10 +0000
Received: from CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::79) by MW4P223CA0002.outlook.office365.com
 (2603:10b6:303:80::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.32 via Frontend
 Transport; Tue, 4 Oct 2022 17:38:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT049.mail.protection.outlook.com (10.13.175.50) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Tue, 4 Oct 2022 17:38:09 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 4 Oct
 2022 12:38:09 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 4 Oct
 2022 12:38:08 -0500
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 4 Oct 2022 12:38:08 -0500
Message-ID: <a0ab26b3-be2d-c1d6-e8ea-3ab9ad57962b@amd.com>
Date:   Tue, 4 Oct 2022 10:38:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V5 XDMA 1/2] dmaengine: xilinx: xdma: Add xilinx xdma
 driver
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, <trix@redhat.com>,
        <tumic@gpxsee.org>, <max.zhen@amd.com>, <sonal.santan@amd.com>,
        <larry.liu@amd.com>, <brian.xu@amd.com>
References: <1664409507-64079-1-git-send-email-lizhi.hou@amd.com>
 <1664409507-64079-2-git-send-email-lizhi.hou@amd.com>
 <6ba2221c-bbc9-a33c-7e62-85c2d87ceeed@linux.intel.com>
 <56f971da-5116-58dc-2df6-53ed465c8ec4@amd.com>
 <c86fb070-9d46-9558-f7ee-216fc657cf1a@linux.intel.com>
From:   Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <c86fb070-9d46-9558-f7ee-216fc657cf1a@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT049:EE_|PH7PR12MB7353:EE_
X-MS-Office365-Filtering-Correlation-Id: c4756f43-6488-469c-2cad-08daa62f3488
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MULqQHebcK8OxIweSOYsah2eJ6wfOKn8T5vGWwOTPqgs024/6qVPnVWvNM+1EYnoHxy3mO0T5FkWD4oeIHnubIBiRqMyjWnXTHGYHG2kIaJQDXpip5EUq0+JgjosbyCidtU8nM09+X3oRpIEgkFndm390fxyt4JtAWW4dK639/Hmhz/0tvS0j5PGoXdXqhbAeGfyRrZjRa4ipE7qDCFHI+8yP4ZtEUPd9UJuMdqRE8QKRZCf7UYMYsetD93o8QeesOANg97sl/sIpxsjiFDsZd9PJdzA95m+/mQTJghfFvIxsHzeQH/V0/+g8BtGaXNa7waYXxCC+RHZ5BsH1iBTCbtmwoFKFdkW2pXE4r7YFVm/DpcvWeRlFHINboVcDn7artW87lMV6x0qp5+WuKTR6l/u0aTwud5QgsUfVdFahd87ayLBtF3kEr8LD70UahCstxDBrx3YDUVcXxzpP9ZfaSVUsijD0l6N0vTVdBK+GhiN42/Dy4jUEPOQUOcOR4wAm+Ql3pOSjkxrS71XbUCyzqcAQL0qd/+tINITOtR93tsIiLAvRmIKUGUaZtlRC4oZToMqUblT7AzRTtXMdR6C2Q2hXIV4+cCG6bAwIBs0AmbFCJHKkwJNUZhQfUA4ahMxI/QgCja/vMpFYQJszhM3hnPfN1KUemYcLM4Ro+Fi0f1N6ICPNGCnfXWfkVdNyTmUZw56DzFfsan9a+DjosdihKflq/NiO5DU0nR6GvzWHuaz+OIhR7VLwgXW1X61Abj+mCX9DNnlB5Ki/WD/AQ72kyFlCUWiHA6m8uRBIHFRDiDMg+oBX56FQKAX4U5ryMn5EKeQYhWCHQ45O7IZ9TD/b759UPEMxP48aRTQmP7HirR1QTKOXvOY7Yy9ymnhOKgNzvomcWwGCy0OtuYUQVkgZw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(5660300002)(44832011)(2906002)(41300700001)(356005)(81166007)(53546011)(26005)(70206006)(70586007)(47076005)(36860700001)(82740400003)(2616005)(336012)(426003)(4326008)(8676002)(316002)(186003)(31686004)(16576012)(8936002)(66574015)(40460700003)(86362001)(31696002)(40480700001)(966005)(36756003)(478600001)(82310400005)(6916009)(83380400001)(54906003)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2022 17:38:09.9484
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4756f43-6488-469c-2cad-08daa62f3488
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7353
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 10/4/22 09:43, Ilpo Järvinen wrote:
> On Tue, 4 Oct 2022, Lizhi Hou wrote:
>
>> On 10/4/22 01:18, Ilpo Järvinen wrote:
>>> On Wed, 28 Sep 2022, Lizhi Hou wrote:
>>>
>>>> Add driver to enable PCIe board which uses XDMA (the DMA/Bridge Subsystem
>>>> for PCI Express). For example, Xilinx Alveo PCIe devices.
>>>>       https://www.xilinx.com/products/boards-and-kits/alveo.html
>>>>
>>>> The XDMA engine support up to 4 Host to Card (H2C) and 4 Card to Host
>>>> (C2H)
>>>> channels. Memory transfers are specified on a per-channel basis in
>>>> descriptor linked lists, which the DMA fetches from host memory and
>>>> processes. Events such as descriptor completion and errors are signaled
>>>> using interrupts. The hardware detail is provided by
>>>>       https://docs.xilinx.com/r/en-US/pg195-pcie-dma/Introduction
>>>>
>>>> This driver implements dmaengine APIs.
>>>>       - probe the available DMA channels
>>>>       - use dma_slave_map for channel lookup
>>>>       - use virtual channel to manage dmaengine tx descriptors
>>>>       - implement device_prep_slave_sg callback to handle host scatter
>>>> gather
>>>>         list
>>>>       - implement device_config to config device address for DMA transfer
>>>>
>>>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>>>> Signed-off-by: Sonal Santan <sonal.santan@amd.com>
>>>> Signed-off-by: Max Zhen <max.zhen@amd.com>
>>>> Signed-off-by: Brian Xu <brian.xu@amd.com>
>>>> ---
>>>> +	*chans = devm_kzalloc(&xdev->pdev->dev, sizeof(**chans) * (*chan_num),
>>>> +			      GFP_KERNEL);
>>>> +	if (!*chans)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	for (i = 0, j = 0; i < pdata->max_dma_channels; i++) {
>>>> +		ret = xdma_read_reg(xdev, base + i * XDMA_CHAN_STRIDE,
>>>> +				    XDMA_CHAN_IDENTIFIER, &identifier);
>>>> +		if (ret) {
>>>> +			xdma_err(xdev, "failed to read channel id: %d", ret);
>>>> +			return ret;
>>>> +		}
>>> Is it ok to not rollback the allocation in case of an error occurs?
>> In this loop, the failures are returned by read/write registers. The
>> read/write register failure indicates serious hardware issue and the hardware
>> may not be rollback in this situation.
> What I meant is that you allocated memory above (to *chans, see above).
> Shouldn't that memory be free in case the hw is not working before you
> return the error from this function?
>
> Check also the other returns below for the same problemx.

The memory does not need to be freed immediately. And it should not be 
memory leak because devm_* is used.

Thanks,

Lizhi

>>>> +
>>>> +		if (j == *chan_num) {
>>>> +			xdma_err(xdev, "invalid channel number");
>>>> +			return -EIO;
>>>> +		}
>>> Same here?
>>>
>>>> +
>>>> +		/* init channel structure and hardware */
>>>> +		(*chans)[j].xdev_hdl = xdev;
>>>> +		(*chans)[j].base = base + i * XDMA_CHAN_STRIDE;
>>>> +		(*chans)[j].dir = dir;
>>>> +
>>>> +		ret = xdma_channel_init(&(*chans)[j]);
>>>> +		if (ret)
>>>> +			return ret;
>>> And here.
>>>
>>>> +		(*chans)[j].vchan.desc_free = xdma_free_desc;
>>>> +		vchan_init(&(*chans)[j].vchan, &xdev->dma_dev);
>>>> +
>>>> +		j++;
>>>> +	}
>>>> +
>>>> +	dev_info(&xdev->pdev->dev, "configured %d %s channels", j,
>>>> +		 (dir == DMA_MEM_TO_DEV) ? "H2C" : "C2H");
>>>> +
>>>> +	return 0;
>>>> +}
>
