Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD70069ED9B
	for <lists+dmaengine@lfdr.de>; Wed, 22 Feb 2023 04:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjBVDqk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 Feb 2023 22:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjBVDqk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 21 Feb 2023 22:46:40 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDA41167D;
        Tue, 21 Feb 2023 19:46:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aWSo14345IWVsD7v0GMmj32HvcYJo3U3ZYl+4e4rdEygqAv6Oc6XpaNy/FunrSDpuVDpijuCWZ+WcMtTl3BsMlcPAid48aheBPgOthupcPahwHpTUbYv9mWPW1wFi/foeMqeVeKari6is2QQxuiWfkHux4Dt/UHbGuAf9YFHE4VBc0GqoRZgtxn4HsXm/Rp2jvGGJV+bNTuuh54vLnLNEJC74p0rchVVOt0FHBG32iaGnMoVy4NOL1L4T6ojpGihV6quATbkRUOzgEynW8M3n3icIRczr7GCghz4Cx+iv4aK9plICpeGpNK16B/M48MEhmaAVihRZ/EiNDAhF5WniQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Pjnn93H1Bjxr7dWM/sFBMpkrIkN8jtycrIBr5WJInU=;
 b=BQIxd1qzJY2NT3iT/MqU81dEawYcsmSwnDWDDePMkyLpYBUUaQ/vk3pEume58WFpnjL62l6JuuKKJSgQ0bjFq1SZdvdWsxItZUTk8iYwhU9okyjwt6fs8CQzygXbAo1okW0s5fEmgTW0ahNArmxurNLr7icuO6mIF3ci2bLfISmNOLyM5p4S4BimNGealIJ11Wc5DTi5RFHvRp02Iaf1eVNQ3ZLQl9e6DeFjcvQEm0bX8Dl9q5ax+ESopegpQCFsTtyrLe83QidSHRyOFfOA8oTQdfJT5MOVASDm/4dt41dvrtK+c2CqyV4Svwrjjvr62hBUHqB8b8nLGBpkaujpiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-m68k.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Pjnn93H1Bjxr7dWM/sFBMpkrIkN8jtycrIBr5WJInU=;
 b=2vxfYDmmM5A3sH69MjmEoaDGRdo82bLXhinkjgej8wlgwnzr+GWI6VDbHlEjm2Ucb6XoKXIgzGWCrs70yvNO+zEB6A9Hgjro32TQs4c4XdEP738yoM6G7S2cUkDL72N+wdM6eQzPQVICf0wmbynFBd8CF+EmlwYvG3PA4Ew46bM=
Received: from DM6PR07CA0087.namprd07.prod.outlook.com (2603:10b6:5:337::20)
 by CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Wed, 22 Feb
 2023 03:46:36 +0000
Received: from DS1PEPF0000E639.namprd02.prod.outlook.com
 (2603:10b6:5:337:cafe::d0) by DM6PR07CA0087.outlook.office365.com
 (2603:10b6:5:337::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.18 via Frontend
 Transport; Wed, 22 Feb 2023 03:46:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E639.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6134.14 via Frontend Transport; Wed, 22 Feb 2023 03:46:35 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 21 Feb
 2023 21:46:34 -0600
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 21 Feb 2023 21:46:34 -0600
Message-ID: <2ec1a8e8-6e85-4873-c1d1-61427b83a6ac@amd.com>
Date:   Tue, 21 Feb 2023 19:46:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RESEND PATCH V12 XDMA 1/2] dmaengine: xilinx: xdma: Add xilinx
 xdma driver
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <larry.liu@amd.com>, <brian.xu@amd.com>,
        <tumic@gpxsee.org>
References: <1675969514-3137-1-git-send-email-lizhi.hou@amd.com>
 <1675969514-3137-2-git-send-email-lizhi.hou@amd.com>
 <CAMuHMdXsUPAW5zKrsaTR9Tgv7kFdkz8s_QUjLXq6zDpoo47fRA@mail.gmail.com>
From:   Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <CAMuHMdXsUPAW5zKrsaTR9Tgv7kFdkz8s_QUjLXq6zDpoo47fRA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E639:EE_|CH3PR12MB8659:EE_
X-MS-Office365-Filtering-Correlation-Id: d34806a2-16fa-42f7-4f00-08db14876532
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aELbZQ5iuVGLq/AVk9KKrrEsByEpB0tUPOvxR/jXq2CxNvsRTFafymHcoQQciXHYU1/vYdTdPekjwKdqah+8WCIp1WmgCIFG8ihHTWkaV1PWLXV667DuXPykboinlU4QYQOhwtGv1OUj8hWoaVtzREVSIHXa2DdrlYbvC1zWb6owoVfPsjU9RDuz6yyHU5kwIY4ubFH5I3puyJIzEFMUsLpWHw0TVx39ZuFSznjuFGZJbMqiR15G0SpHilB83VC5vDSCz/bPqFMEuAfrvi8S33rYTSN5Md1gbC2vwloR8sLcycLvBc/G79ZVIiD1D/qAZbQelFtxPQWGfEz4tXDLrIGvTxNFYKSqi9j2QCkHe3WzfkD+sQG3F+0oOiAsHy2uHJlvPsbhjAvCPkxHpx5J57aqHrPF8HDEf+rkCzpIySDhEivsR+9sk2CketeIdFjuIIDMUum9ktS/WqSHKx1uLDD9/eO2r+73nh9FjpJOcPiVWQa0nFX+Dx6mq3Vn0svVvtKxQq4tnXJOcwMnaKLhvvhbB9/Bh3d9kTOn2OK4LXODLUG2H0eHg2E3CmvPcCZWMwqZg55vkgrm2Is2y0bYj095Z7d5ftUELoE3ViT2qgMGQRijsWpc2onJ7qAsi1oHWisXRrnccQtHWWU7edJp8L3yJy+KdF/+H57SQzScVWCpPq9DUhziD4NsmszEd1H5O4Tvd3GMgLCsPYPQkchfrblf95oEogJTr5jOqIMCPxF5abDW+oowFJYrcl3JNntdV0GQ3MVnmvm4mAi8Mx8+I46bguflK+CRhJgHWlV7Q+Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(396003)(346002)(376002)(451199018)(36840700001)(40470700004)(46966006)(81166007)(31686004)(36860700001)(82740400003)(2906002)(5660300002)(8936002)(44832011)(82310400005)(54906003)(26005)(186003)(41300700001)(83380400001)(426003)(8676002)(2616005)(356005)(36756003)(6916009)(4326008)(70586007)(47076005)(70206006)(40480700001)(86362001)(478600001)(31696002)(966005)(316002)(16576012)(53546011)(40460700003)(336012)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 03:46:35.3212
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d34806a2-16fa-42f7-4f00-08db14876532
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E639.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8659
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 2/21/23 05:25, Geert Uytterhoeven wrote:
> Hi Lizhi,
>
> On Thu, Feb 9, 2023 at 8:18 PM Lizhi Hou <lizhi.hou@amd.com> wrote:
>> Add driver to enable PCIe board which uses XDMA (the DMA/Bridge Subsystem
>> for PCI Express). For example, Xilinx Alveo PCIe devices.
>>      https://www.xilinx.com/products/boards-and-kits/alveo.html
>>
>> The XDMA engine support up to 4 Host to Card (H2C) and 4 Card to Host (C2H)
>> channels. Memory transfers are specified on a per-channel basis in
>> descriptor linked lists, which the DMA fetches from host memory and
>> processes. Events such as descriptor completion and errors are signaled
>> using interrupts. The hardware detail is provided by
>>      https://docs.xilinx.com/r/en-US/pg195-pcie-dma/Introduction
>>
>> This driver implements dmaengine APIs.
>>      - probe the available DMA channels
>>      - use dma_slave_map for channel lookup
>>      - use virtual channel to manage dmaengine tx descriptors
>>      - implement device_prep_slave_sg callback to handle host scatter gather
>>        list
>>      - implement device_config to config device address for DMA transfer
>>
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>> Signed-off-by: Sonal Santan <sonal.santan@amd.com>
>> Signed-off-by: Max Zhen <max.zhen@amd.com>
>> Signed-off-by: Brian Xu <brian.xu@amd.com>
>> Tested-by: Martin Tuma <tumic@gpxsee.org>
> Thanks for your patch, which is now commit 17ce252266c7f016
> ("dmaengine: xilinx: xdma: Add xilinx xdma driver") in dmaengine/next.
>
>> --- a/drivers/dma/Kconfig
>> +++ b/drivers/dma/Kconfig
>> @@ -735,6 +735,20 @@ config XILINX_DMA
>>            the scatter gather interface with multiple channels independent
>>            configuration support.
>>
>> +config XILINX_XDMA
>> +       tristate "Xilinx DMA/Bridge Subsystem DMA Engine"
>> +       depends on HAS_IOMEM
>> +       select DMA_ENGINE
>> +       select DMA_VIRTUAL_CHANNELS
>> +       select REGMAP_MMIO
> No platform dependencies at all, while this is a platform driver that
> relies on some other not-yet-existing driver creating an "xdma"
> platform device?
>
>> +       help
>> +         Enable support for Xilinx DMA/Bridge Subsystem DMA engine. The DMA
>> +         provides high performance block data movement between Host memory
>> +         and the DMA subsystem. These direct memory transfers can be both in
>> +         the Host to Card (H2C) and Card to Host (C2H) transfers.
>> +         The core also provides up to 16 user interrupt wires that generate
>> +         interrupts to the host.
>> +
>>   config XILINX_ZYNQMP_DMA
>>          tristate "Xilinx ZynqMP DMA Engine"
>>          depends on ARCH_ZYNQ || MICROBLAZE || ARM64 || COMPILE_TEST
>> --- /dev/null
>> +++ b/drivers/dma/xilinx/xdma.c
>> +/**
>> + * xdma_probe - Driver probe function
>> + * @pdev: Pointer to the platform_device structure
>> + */
>> +static int xdma_probe(struct platform_device *pdev)
>> +{
>> +       struct xdma_platdata *pdata = dev_get_platdata(&pdev->dev);
> Platform data? No DT?
> Do we still accept plain platform drivers?

The XDMA driver needs to support both the non-DT and DT use cases.

For the non-DT case the parent PCIe device driver will create the xdma 
platform device and pass the required information to the xdma driver. An 
example is 
https://lore.kernel.org/dmaengine/5fbe6029-61d5-bba4-556b-2282153f21dc@gpxsee.org/ 


For the DT use case, the xdma device will be populated by the FDT. This 
part is WIP and will be enabled with future patches.

>
>> +static const struct platform_device_id xdma_id_table[] = {
>> +       { "xdma", 0},
>> +       { },
>> +};
> This table is not needed, as the single entry matches driver.name below.

Thanks. I will create a patch to fix this.


Lizhi

>
>> +
>> +static struct platform_driver xdma_driver = {
>> +       .driver         = {
>> +               .name = "xdma",
>> +       },
>> +       .id_table       = xdma_id_table,
>> +       .probe          = xdma_probe,
>> +       .remove         = xdma_remove,
>> +};
>> +
>> +module_platform_driver(xdma_driver);
> Gr{oetje,eeting}s,
>
>                          Geert
>
