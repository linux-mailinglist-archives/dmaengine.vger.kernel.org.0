Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935025F6D14
	for <lists+dmaengine@lfdr.de>; Thu,  6 Oct 2022 19:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiJFRmx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 6 Oct 2022 13:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbiJFRmw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 6 Oct 2022 13:42:52 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DCFB274D;
        Thu,  6 Oct 2022 10:42:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yk1fTCQPoaqFLV7sYupu9IUv/KgCFuXI+snEH7RCZGo/hC3WD+u0BfkGjySbHL5mzFait2kkm6j0P8YiIq5hD4K97dRzS4tkhPQ5U4qc0X3SZa9sSRLZQbwQ9UuiQdXtWMf9TFs7LJa/QOtc6pP9UqwwlL9F8lAotbsMHAPcNLvvV+pmzQ+wVRojmFM5DJKEWeVKHi6sbnfFAMsBba8R0LqPyPLiIxcqZc6gMx09/m4Mpuqlo90e2hTObZbDuLxKU2yEwW5t8rGjHT8+hrcRARzswBZvGz+3KxSdJVe26PcdUx45FC+WVLKT0coL/Hu0RR2G3B0nCJXFlpOsQG6F1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GugUSR1Ts6HanG2FbAOsl1KwBKQKRMvFtMSkHG4Au4Y=;
 b=kisRH8T2lLS6AzZ+rik9Vw9LkBoffrQL/xWkLr3wnAM0WcFgWACbyk52Saxh8T8F7caF1CEhR/jVVf1haLVvyPBZKt8xkCOCyb4C7DuH3+PKT4vpvIlL+aBqYpej2uDvHp4vXVT9eg1ZaMdRvMv99OnmuG0gzUmQKNwPA5IGaVb487nKj3D0+dAcYQB1K3pKEBFFe8W1sXFHTX1lmXk4C2bwousearC2yobw7prmQnF4pObUB6YhllZPZvNmCMH0yvbG9O6f70k5w2aYQToXbYuU9ahjQCMi4yE8PtYiutFw0g6gysB16dN/c1oxkrlm79njAFROyRddfsFqAJX/nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gpxsee.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GugUSR1Ts6HanG2FbAOsl1KwBKQKRMvFtMSkHG4Au4Y=;
 b=nFyXH6bCrW4WWd3sNDaGBy8a6KC+iY97NrVbSpqcEjGA+xlvY4GjmVp4/mOuHZ3lZW+xsMavYzXnkr7FOcW/zbGF5PvMejgcxTRjfJeDtMPUGVEpG8WLEqNuDerpf29e565F5aU+XohgfXwah6kJ7mdsSpKalybxYuZxwfVqkuA=
Received: from BN9PR03CA0902.namprd03.prod.outlook.com (2603:10b6:408:107::7)
 by IA0PR12MB7602.namprd12.prod.outlook.com (2603:10b6:208:43a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Thu, 6 Oct
 2022 17:42:47 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::a6) by BN9PR03CA0902.outlook.office365.com
 (2603:10b6:408:107::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23 via Frontend
 Transport; Thu, 6 Oct 2022 17:42:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Thu, 6 Oct 2022 17:42:46 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 6 Oct
 2022 12:42:45 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 6 Oct
 2022 10:42:45 -0700
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Thu, 6 Oct 2022 12:42:44 -0500
Message-ID: <e04c498e-c3f5-9b0f-14cf-56057dd77d4e@amd.com>
Date:   Thu, 6 Oct 2022 10:42:44 -0700
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
From:   Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <4e4481e9-0eb9-ac28-b9ff-348adb4dc866@gpxsee.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT034:EE_|IA0PR12MB7602:EE_
X-MS-Office365-Filtering-Correlation-Id: eb2a5daa-24f1-4e8b-eca6-08daa7c22dea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: grSX+Lgdfp7hlwysN6GjtDdisJvUyFYC0r+3vwAtUymOQTAQ6UE49j/9GOi2Jtlp+NxmtC9OspUSxeTZ4FPrPDmr0r32n9XY4XaxCUK70HKUGWFJzLonjCB6kL+VMB7bs4DNcn38/hsmGunu6TfdAe/I1G+ZmY5+pW+DOXki/qLosAk3azOTvc8hm1XLzSMDZvyBQo7nrEtrHWO69q5OJ57DvqsjdnTdyi6xucdvIwJBUFmV8oV8/Xizl18MX/MLUQtbBxWi93uZCsZd8lOVZSlhDY8NdoRkEYDhhFW3U1zZthYvNsiJfXXnyuxr2OLnEmWG14lVmzmLfABl2TQKdL6X/lUIszj7W1qG785eKi9TX4JGJwo/ihRtRVPnzATyWHgkR5jjpyehyIJUpyIXSRFPCeROj+7XnlWoBfG1EsmlYssnb02AY5oI9A89Xe+qZ3bKAgykK/76WHST2kbUJs8HyqAaikp+F0eZcBiLF5jnEicxnwVahyTdsze0jSzthbCUyl/HTuGd6NpHd+JzBxSFcU1kSD352q8mnDH6Dzn47vA/Mc5AeB07Flhc0QA7XCX3CIrPT9uj3KvC1hj5TC1eVpS4R3m5r+pQwsFK3aSroD+SN/BAAo28rJ3epLQ0N/5BzisqZOcBG9VMiP6gjOvLNtjevXEbnceDOLLUxgHu/NxV9rQgG/CvPtrwSe+51QhD5eyWjZ0TMB6bwbrFeBqm/HukegMzeMgcn1yVshNW4H87f9hR6iPRqpjZ5zG08i7ijM/Z+r+eQi8N/Jwc5umW9NYli2oPf0jcingod8xMOiOzUSOC44aL2aGw/eCNMJIf2XeHM99UcKfmP8w7T+DZ1I74/fE9vEenocBa94Gg89oEO6gTKYRxCA7RB/EqeNbtNwq+MC9FLZjwPB4MMw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199015)(36840700001)(46966006)(40470700004)(40460700003)(16576012)(336012)(5660300002)(110136005)(36756003)(8936002)(2616005)(53546011)(83380400001)(31696002)(966005)(54906003)(36860700001)(82310400005)(426003)(70206006)(66574015)(478600001)(81166007)(356005)(82740400003)(40480700001)(47076005)(86362001)(41300700001)(4326008)(186003)(70586007)(8676002)(44832011)(2906002)(316002)(31686004)(26005)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 17:42:46.1586
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb2a5daa-24f1-4e8b-eca6-08daa7c22dea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7602
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 10/6/22 09:37, Martin Tůma wrote:
> On 04. 10. 22 23:43, Lizhi Hou wrote:
>> Hello,
>>
>> This V6 of patch series is to provide the platform driver to support the
>> Xilinx XDMA subsystem. The XDMA subsystem is used in conjunction with 
>> the
>> PCI Express IP block to provide high performance data transfer 
>> between host
>> memory and the card's DMA subsystem. It also provides up to 16 user
>> interrupt wires to user logic that generate interrupts to the host.
>>
>>              +-------+       +-------+       +-----------+
>>     PCIe     |       |       |       |       |           |
>>     Tx/Rx    |       |       |       |  AXI  |           |
>>   <=======>  | PCIE  | <===> | XDMA  | <====>| User Logic|
>>              |       |       |       |       |           |
>>              +-------+       +-------+       +-----------+
>>
>> The XDMA has been used for Xilinx Alveo PCIe devices.
>> And it is also integrated into Versal ACAP DMA and Bridge Subsystem.
>>      https://www.xilinx.com/products/boards-and-kits/alveo.html
>> https://docs.xilinx.com/r/en-US/pg344-pcie-dma-versal/Introduction-to-the-DMA-and-Bridge-Subsystems
>>
>> The device driver for any FPGA based PCIe device which leverages XDMA 
>> can
>> call the standard dmaengine APIs to discover and use the XDMA subsystem
>> without duplicating the XDMA driver code in its own driver.
>>
>> Changes since v5:
>> - Modified user logic interrupt APIs to handle user logic IP which 
>> does not
>>    have its own register to enable/disable interrupt.
>> - Clean up code based on review comments.
>>
>> Changes since v4:
>> - Modified user logic interrupt APIs.
>>
>> Changes since v3:
>> - Added one patch to support user logic interrupt.
>>
>> Changes since v2:
>> - Removed tasklet.
>> - Fixed regression bug introduced to V2.
>> - Test Robot warning.
>>
>> Changes since v1:
>> - Moved filling hardware descriptor to xdma_prep_device_sg().
>> - Changed hardware descriptor enum to "struct xdma_hw_desc".
>> - Minor changes from code review comments.
>>
>> Lizhi Hou (2):
>>    dmaengine: xilinx: xdma: Add xilinx xdma driver
>>    dmaengine: xilinx: xdma: Add user logic interrupt support
>>
>>   MAINTAINERS                            |   11 +
>>   drivers/dma/Kconfig                    |   13 +
>>   drivers/dma/xilinx/Makefile            |    1 +
>>   drivers/dma/xilinx/xdma-regs.h         |  171 ++++
>>   drivers/dma/xilinx/xdma.c              | 1034 ++++++++++++++++++++++++
>>   include/linux/dma/amd_xdma.h           |   16 +
>>   include/linux/platform_data/amd_xdma.h |   34 +
>>   7 files changed, 1280 insertions(+)
>>   create mode 100644 drivers/dma/xilinx/xdma-regs.h
>>   create mode 100644 drivers/dma/xilinx/xdma.c
>>   create mode 100644 include/linux/dma/amd_xdma.h
>>   create mode 100644 include/linux/platform_data/amd_xdma.h
>>
>
> Hi,
> I have rewritten our V4L2 driver to use this new XDMA driver, but it 
> does not work on our HW (where the previous Xilinx XDMA driver derived 
> from the Xilinx sample code worked fine). The driver is sucessfully 
> loaded and 4(2+2) DMA channels are successfully created. But when a 
> DMA transfer is initiated, I get an error from my PC's DMA chip:
>
> AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x000a address=0x36a00000 
> flags=0x0000]
>
> and no error from XDMA.
>
> Does the driver expect some special FPGA IP core configuration? Or is 
> there something else I'm missing? My code is quiet similar to what you 
> use in your XRT repo on GitHub (there is btw. a bug in the XRT code - 
> you do not clear the dma_slave_config struct before using) but in my 
> case the DMA transfer triggers the AMD-Vi error and timeouts.
>
> The code of our driver is attached, the relevant parts are in mgb4_dma.c
> and mgb4_core.c.
>
> M.

Hi Martin,

Thanks for trying this and got a lot thing works. I have read your 
driver. Could you call pci_map_sg() before calling prep_sg()? (and 
pci_unmap_sg()) after transfer complete?

example: 
https://github.com/houlz0507/XRT-1/blob/xdma_v4_usage/src/runtime_src/core/pcie/driver/linux/xocl/subdev/xdma.c#L103


Thanks,

Lizhi

