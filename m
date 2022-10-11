Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1835FB76E
	for <lists+dmaengine@lfdr.de>; Tue, 11 Oct 2022 17:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiJKPi6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 11 Oct 2022 11:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbiJKPiP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 11 Oct 2022 11:38:15 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2077.outbound.protection.outlook.com [40.107.95.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2BADABF33;
        Tue, 11 Oct 2022 08:27:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B0V4NBZC+dLu5D1YF/5f6HjarybPV4MFcaiMm9qVP2EPL2UmtHW2IppZ7tLjXDt3FODKwgbSoXqPdLfSgZirOGZDjOautQzb7EdvJ6gmV/DtFYMST9znDIRvm0i9+SYacQ1viFAffu/0zhGNoHoa7RFeElTbf4nPEYJUoZ5kggjFLF1Y10mxLpzLz2HIT2nyM9FPq3E4yzBsWkJXNkkw12H4Pj9ezH9yUFv7fsKX6Ijw2DnZ5xprD55dR42UxvxGSTSojnK/vtc53QrkQf5z+6xOt5v2rTXGqXyjp12H7yZIigetgYXNDz2y3W5vWrxjptXFqBWJt+ioY2ui6KyhLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJ3w/PM4Or/Rd9AhEZJJNcScg4Nt5ibPsHYfLATCJp0=;
 b=UGEd6uiq9sFdZmSzi4vQT5oybjV8PsXGQCneJhf6dhkPRQA4+lIvvsWXMTxaR0HHLc/+e7RtiMOQ1PUGPkapCvCeaE+sc7GwCDIIwB7HMVwaonZAkiIT9gpwJSAhjt0e7AHHQ/ekzuysHANofVVNe39x18xqT51XnNCdxOV4Z3VcStdDelBzX91zbBXWm0dmyYRJE/5rP5CLcNpAAL77ZpF92EVzsghPRHi7J/ekHMJRNptI4jT+SG9QlGLjKEXdaOY1IXz6Ys7lq2qlM5RN8kJ5j+Maq9xNNyadtj/CWvMRf6huHQ+EEXebWPG9vJFWqEvJtHn9du5NuNlmE2egKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gpxsee.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJ3w/PM4Or/Rd9AhEZJJNcScg4Nt5ibPsHYfLATCJp0=;
 b=0vB2Rvjas86dEQlQuCe9MhyPBooln1v0TIRPN8VrDaL5I24/ziIfdWXX2uuzj1r1x8CQxs1atTDnlpLH0m5dtmu/Qyl733zmrjFtIfHEAZG3hgLLWmkLTEaHwjb16jkQOkueyzMJBFVhtxkZIxA9Bz/3QsZAi4BXCCxjcAk9zBI=
Received: from BN9PR03CA0797.namprd03.prod.outlook.com (2603:10b6:408:13f::22)
 by DM4PR12MB6568.namprd12.prod.outlook.com (2603:10b6:8:8f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 15:27:07 +0000
Received: from BN8NAM11FT099.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::7e) by BN9PR03CA0797.outlook.office365.com
 (2603:10b6:408:13f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.20 via Frontend
 Transport; Tue, 11 Oct 2022 15:27:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT099.mail.protection.outlook.com (10.13.177.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Tue, 11 Oct 2022 15:27:07 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 11 Oct
 2022 10:27:06 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 11 Oct
 2022 10:27:06 -0500
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 11 Oct 2022 10:27:05 -0500
Message-ID: <8e513116-f718-b537-f2b7-dac260ab7177@amd.com>
Date:   Tue, 11 Oct 2022 08:27:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V6 XDMA 0/2] xilinx XDMA driver
Content-Language: en-US
To:     =?UTF-8?Q?Martin_T=c5=afma?= <tumic@gpxsee.org>,
        <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <trix@redhat.com>
CC:     <max.zhen@amd.com>, <sonal.santan@amd.com>, <larry.liu@amd.com>,
        <brian.xu@amd.com>
References: <1664919839-27149-1-git-send-email-lizhi.hou@amd.com>
 <4e4481e9-0eb9-ac28-b9ff-348adb4dc866@gpxsee.org>
 <e04c498e-c3f5-9b0f-14cf-56057dd77d4e@amd.com>
 <c04fce1e-63b1-c698-4ac8-746617600f5c@gpxsee.org>
From:   Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <c04fce1e-63b1-c698-4ac8-746617600f5c@gpxsee.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT099:EE_|DM4PR12MB6568:EE_
X-MS-Office365-Filtering-Correlation-Id: 32626f96-e716-4faf-435a-08daab9d0ed1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s8A5GcBtzLoh3J5i4K0OZroY+Wu5/PCx48wfpUsVNS0APr3AA3Z9a0Z8xsdh2GlJadq0x5mPv+fw0yGmKiBzcHNw682UPdBn0b1/r+IR18kBXqR2ZZCl3SQuqb6PVlaKhQZoN6HTTfF/nC/haQV0LzOPvqevv+qEAGMPBtqkzVIbtcMgvPKu+6FK9K2qXmnePYGU4nswB0NFJCetnlBBlg3EQy7IYiheQ17SlStX6rtsTbiaLnMWrmC2NL9jPM+lzeGPC3YltF94LSynA8TPVkqLWCvToNfpOl/KdelevpihjKC2e7Jxrun0c9vw8RlXdNsieaGF2srQ6C0Ept/WFNQOCOItnCsa+6OhmwGrirIhW7ou0QjEsNdetcpkKbqycfvJGgOq3B/wVO0Qycbi492YPFQKcph3ikmpJdZsoBG9MKUNodNnWVj+4DwhBzp/H9c+hjVtZLfegSlHLTIti//hL3eJoo4YN+QGJoK51dKNIpxjCfQRdptYdk6XgG2CVBPEbMiMAe1WYe8xqlm1AqRVAJ7FLmFDAzDtihhhcnbMBPyyHDYe19+Bbh1zGqscOzsxFlN7ylk/I3rO4oOB3KjYVgaVcREK8JJOUknA/Phk2mx2IrqRhImfiEWENf/uS47gRWIxO2xOSq9nz3+4JZVGgvyS8CN+a2PdpXwrc8pi2yOIbXLum97PHGAWSeYh3B3/ef1qudrXL/7ChNhyNyuWopu6zOTefe7tnzHs8V1IjI7vvevif+7ZFtYDoRNTotN2bzYK/hsLMQal3bQXxrTdKZ48uTL3b7tCM9adJAF2Mb+bmwUOR5f0QsETg8e4VkLR63HHNs5uiL9oN7fadPC4kFhPDCExxQr004Wx8BIUz5chT33WbpcMlIr8GD5phIdXMjd8pKD3OkXSqfzSpw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199015)(46966006)(36840700001)(40470700004)(41300700001)(356005)(82740400003)(5660300002)(83380400001)(426003)(8676002)(70586007)(2906002)(2616005)(70206006)(4326008)(47076005)(26005)(31696002)(36756003)(336012)(66574015)(186003)(8936002)(86362001)(36860700001)(40480700001)(82310400005)(966005)(478600001)(44832011)(316002)(40460700003)(53546011)(16576012)(81166007)(54906003)(31686004)(110136005)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 15:27:07.2844
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32626f96-e716-4faf-435a-08daab9d0ed1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT099.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6568
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 10/7/22 06:21, Martin Tůma wrote:
> On 06. 10. 22 19:42, Lizhi Hou wrote:
>>
>> On 10/6/22 09:37, Martin Tůma wrote:
>>> On 04. 10. 22 23:43, Lizhi Hou wrote:
>>>> Hello,
>>>>
>>>> This V6 of patch series is to provide the platform driver to 
>>>> support the
>>>> Xilinx XDMA subsystem. The XDMA subsystem is used in conjunction 
>>>> with the
>>>> PCI Express IP block to provide high performance data transfer 
>>>> between host
>>>> memory and the card's DMA subsystem. It also provides up to 16 user
>>>> interrupt wires to user logic that generate interrupts to the host.
>>>>
>>>>              +-------+       +-------+       +-----------+
>>>>     PCIe     |       |       |       |       |           |
>>>>     Tx/Rx    |       |       |       |  AXI  |           |
>>>>   <=======>  | PCIE  | <===> | XDMA  | <====>| User Logic|
>>>>              |       |       |       |       |           |
>>>>              +-------+       +-------+       +-----------+
>>>>
>>>> The XDMA has been used for Xilinx Alveo PCIe devices.
>>>> And it is also integrated into Versal ACAP DMA and Bridge Subsystem.
>>>> https://www.xilinx.com/products/boards-and-kits/alveo.html
>>>> https://docs.xilinx.com/r/en-US/pg344-pcie-dma-versal/Introduction-to-the-DMA-and-Bridge-Subsystems 
>>>>
>>>>
>>>> The device driver for any FPGA based PCIe device which leverages 
>>>> XDMA can
>>>> call the standard dmaengine APIs to discover and use the XDMA 
>>>> subsystem
>>>> without duplicating the XDMA driver code in its own driver.
>>>>
>>>> Changes since v5:
>>>> - Modified user logic interrupt APIs to handle user logic IP which 
>>>> does not
>>>>    have its own register to enable/disable interrupt.
>>>> - Clean up code based on review comments.
>>>>
>>>> Changes since v4:
>>>> - Modified user logic interrupt APIs.
>>>>
>>>> Changes since v3:
>>>> - Added one patch to support user logic interrupt.
>>>>
>>>> Changes since v2:
>>>> - Removed tasklet.
>>>> - Fixed regression bug introduced to V2.
>>>> - Test Robot warning.
>>>>
>>>> Changes since v1:
>>>> - Moved filling hardware descriptor to xdma_prep_device_sg().
>>>> - Changed hardware descriptor enum to "struct xdma_hw_desc".
>>>> - Minor changes from code review comments.
>>>>
>>>> Lizhi Hou (2):
>>>>    dmaengine: xilinx: xdma: Add xilinx xdma driver
>>>>    dmaengine: xilinx: xdma: Add user logic interrupt support
>>>>
>>>>   MAINTAINERS                            |   11 +
>>>>   drivers/dma/Kconfig                    |   13 +
>>>>   drivers/dma/xilinx/Makefile            |    1 +
>>>>   drivers/dma/xilinx/xdma-regs.h         |  171 ++++
>>>>   drivers/dma/xilinx/xdma.c              | 1034 
>>>> ++++++++++++++++++++++++
>>>>   include/linux/dma/amd_xdma.h           |   16 +
>>>>   include/linux/platform_data/amd_xdma.h |   34 +
>>>>   7 files changed, 1280 insertions(+)
>>>>   create mode 100644 drivers/dma/xilinx/xdma-regs.h
>>>>   create mode 100644 drivers/dma/xilinx/xdma.c
>>>>   create mode 100644 include/linux/dma/amd_xdma.h
>>>>   create mode 100644 include/linux/platform_data/amd_xdma.h
>>>>
>>>
>>> Hi,
>>> I have rewritten our V4L2 driver to use this new XDMA driver, but it 
>>> does not work on our HW (where the previous Xilinx XDMA driver 
>>> derived from the Xilinx sample code worked fine). The driver is 
>>> sucessfully loaded and 4(2+2) DMA channels are successfully created. 
>>> But when a DMA transfer is initiated, I get an error from my PC's 
>>> DMA chip:
>>>
>>> AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x000a address=0x36a00000 
>>> flags=0x0000]
>>>
>>> and no error from XDMA.
>>>
>>> Does the driver expect some special FPGA IP core configuration? Or 
>>> is there something else I'm missing? My code is quiet similar to 
>>> what you use in your XRT repo on GitHub (there is btw. a bug in the 
>>> XRT code - you do not clear the dma_slave_config struct before 
>>> using) but in my case the DMA transfer triggers the AMD-Vi error and 
>>> timeouts.
>>>
>>> The code of our driver is attached, the relevant parts are in 
>>> mgb4_dma.c
>>> and mgb4_core.c.
>>>
>>> M.
>>
>> Hi Martin,
>>
>> Thanks for trying this and got a lot thing works. I have read your 
>> driver. Could you call pci_map_sg() before calling prep_sg()? (and 
>> pci_unmap_sg()) after transfer complete?
>>
>> example: 
>> https://github.com/houlz0507/XRT-1/blob/xdma_v4_usage/src/runtime_src/core/pcie/driver/linux/xocl/subdev/xdma.c#L103
>>
>>
>> Thanks,
>>
>> Lizhi
>>
>
> Hi,
> That's not the problem, the sg is already mapped by V4L2 videobuf-dma-sg
> (https://elixir.bootlin.com/linux/v6.0/source/drivers/media/v4l2-core/videobuf-dma-sg.c#L285). 
> With the original XDMA driver I was also not mapping the sg and it 
> worked fine. And yes, I have tried it anyway and it didn't help ;-)
>
> So there must be some other problem in your XDMA driver.
>
> M.

Hi Martin,

I got a AMD server and debug this issue. And there is indeed a XDMA 
driver issue. My DMA test passed on this server after fixing the issue. 
I will post v7 patches and hopefully that fixes the issue you have seen 
as well.

Thanks for trying the driver.

Lizhi

