Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BED25F4776
	for <lists+dmaengine@lfdr.de>; Tue,  4 Oct 2022 18:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiJDQXl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 4 Oct 2022 12:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiJDQXi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 4 Oct 2022 12:23:38 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BE13AB1B;
        Tue,  4 Oct 2022 09:23:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nys3V9FC3lg164xpjAznx3Ujp6qbgvrR2JkhKpU5EKqRte/7+rvf3esOcuP4taSwkblE+gYuj4wXxx91S7+swb1z8aBmZTr04C6fe/fwsJCmRhenQlmq3zee7LVX9POaQO1TwSYYwQ5I62LWfio/YaxLjKTAxf5jYwNeY4lK+vGBY0kab4RqwAyiy1yvMak7pwy8pz8YiIzutCJLtKrhSqj38t264XJSmqlywvK6yClx/PYV4/PGWyslxJqQvor5tlrPGycDqO5zkWsNVlkLytdC4/168LvI4XSSoLdi8SCeoxb3SGuf8hPIYyHCa93NQSblrtkPJC1NLOi1G4O2Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FEWCgBSs58wLfvQNmf0uaByl7+FpIalQV8euEf+nzt0=;
 b=R+5RfqNEmsOTXo8NmuJxNVK4w3SYi3MtzHmLwQ4vKmWESgY4FUeFy3C4N7hkvTDu0FE5r0Bp90YxcKf59oAzvzFE2kAwaYMJrdljCY9nI7fAdsp7/5uY+0vAGSS5FOtuTRcMn6c+mwJG7kb8l6+DYSk4EsyE2URkA/T91zknJSyRN8FnHtj0GzD7OB//t8yMXi2f2FuPno3WhLG8oJGi1WqpnK8Pg6m3sX56V67iMiaNsQcU7xNRM6STUe6/cZA0Oh1xjuYI/YYObEERWWiWairzrMMf6g2fZrkpW8akhgAshkAMdReptc5/4S43/klCt9zxg0YY3SjY+SA8g2UW4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FEWCgBSs58wLfvQNmf0uaByl7+FpIalQV8euEf+nzt0=;
 b=vnXDYqy37N399jOfS1ygkC7hNVMmuHUC2QUssG6d8qDhXo8zq+oVQOYVWdgSTkkj7uCByU12I8AtRo6I6ft81heBXSQ4GOUSJ8kO/f+7GAS8whILQs4tuS/sMRa9slNPSusIEykMOyIwDyoJKKqv/x58jqaNKFiFD8oxsKdJxag=
Received: from DM6PR07CA0045.namprd07.prod.outlook.com (2603:10b6:5:74::22) by
 DM4PR12MB5916.namprd12.prod.outlook.com (2603:10b6:8:69::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.28; Tue, 4 Oct 2022 16:23:33 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::33) by DM6PR07CA0045.outlook.office365.com
 (2603:10b6:5:74::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.26 via Frontend
 Transport; Tue, 4 Oct 2022 16:23:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Tue, 4 Oct 2022 16:23:33 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 4 Oct
 2022 11:23:32 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 4 Oct
 2022 09:23:32 -0700
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 4 Oct 2022 11:23:31 -0500
Message-ID: <56f971da-5116-58dc-2df6-53ed465c8ec4@amd.com>
Date:   Tue, 4 Oct 2022 09:23:31 -0700
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
From:   Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <6ba2221c-bbc9-a33c-7e62-85c2d87ceeed@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT055:EE_|DM4PR12MB5916:EE_
X-MS-Office365-Filtering-Correlation-Id: 617124a4-56fe-4768-9af4-08daa624c826
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 29TpXfiJWs54y4rDto9uVLELfAfvIyJuV9tSKoRmfkgDcz0AY4+FO3aQQKxb8lq4vSMW5Wz9C9AIe6Y9im5rTZyno84NasVsDwnefT5CHbtv4aVMUpdyK5iAxOilC4gYQWctAzj9zJZkOsoTG1CLCNeRQKtc/DFknjOccf0YHlYeX4Gm6xX2+pKV/Gh0DzT29B4kAiOclYjEO9kaA0+x1vVBnmMV5LY9xlUobMjcPbj8wO5eHL08/JplPHhMjJkPmxiHyla3H2MPVApIiiGetyU5rxdtbPfl/DMuCFT/aasLZiZIWGm2Zzk7ibBu5ee0mbSql95gBJ2oPXu3D2yUbHiXhnoHnWD/BmqOY1FmVQWhz3hcX+EKZgOhCh2oOJuyf2Zp0zb6TT9+XEXsV4b6Rp3AhQuOZnzunKt5XUQAdszAErXjzE2dJ/b3hnfIs9Z6Jb+8dsyp6k+xlGr+KyAj0U67LknjmpFpLCfSUtsa4aTw4hLr4vDRBnSSW4UMywjrDyRUd+yTXYsbwkE5Mj6VBRypVYHUIdO0e78NObL6n6fJ9IE9QPkoSEEXrXsExnn0FU270s534rO54Vp929TMy1Vdo76TN3dONtw43aI2XfzGx7mlQf5zFXkdEwZHwNsIkZF5Dn6qT5J7/LpMrOtBoFqQOEECiOuEERIPrQfARk6LJh0foLFz9M8oFnY/Zy2YGr/nfFdN8EZmd1U3SgTholgxxdbWTPxdUAIVF9FkMnQ1f4DgzLD2O4ZqwiWtvAePl5epmtdojV+PVcfPCX2bNY7jUIn7axCUJPLoR3EdgX/WOuHqlGRW8VkNf22cxo2aODbIwZUTzELfLlQ2oDMqx7qPDtQALtiqMGQp/pKtTHChswGSgaTa7deFvYYZmlwH2MqA9S9SClBqVJbU2v2ccQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(376002)(136003)(396003)(451199015)(40470700004)(46966006)(36840700001)(31686004)(44832011)(41300700001)(2906002)(5660300002)(8936002)(82310400005)(36756003)(478600001)(40480700001)(31696002)(86362001)(4326008)(26005)(2616005)(53546011)(54906003)(966005)(70206006)(70586007)(8676002)(316002)(16576012)(82740400003)(6916009)(81166007)(47076005)(36860700001)(66574015)(426003)(40460700003)(356005)(186003)(336012)(83380400001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2022 16:23:33.2415
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 617124a4-56fe-4768-9af4-08daa624c826
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5916
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 10/4/22 01:18, Ilpo Järvinen wrote:
> On Wed, 28 Sep 2022, Lizhi Hou wrote:
>
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
>> ---
>> +/* bits of the channel control register */
>> +#define CHAN_CTRL_RUN_STOP			BIT(0)
>> +#define CHAN_CTRL_IE_DESC_STOPPED		BIT(1)
>> +#define CHAN_CTRL_IE_DESC_COMPLETED		BIT(2)
>> +#define CHAN_CTRL_IE_DESC_ALIGN_MISMATCH	BIT(3)
>> +#define CHAN_CTRL_IE_MAGIC_STOPPED		BIT(4)
>> +#define CHAN_CTRL_IE_IDLE_STOPPED		BIT(6)
>> +#define CHAN_CTRL_IE_READ_ERROR			(0x1FUL << 9)
>> +#define CHAN_CTRL_IE_DESC_ERROR			(0x1FUL << 19)
> Looks GENMASK()
Sure. Thanks for pointing it out.
>
>> +/* bits of the SG DMA control register */
>> +#define XDMA_CTRL_RUN_STOP			BIT(0)
>> +#define XDMA_CTRL_IE_DESC_STOPPED		BIT(1)
>> +#define XDMA_CTRL_IE_DESC_COMPLETED		BIT(2)
>> +#define XDMA_CTRL_IE_DESC_ALIGN_MISMATCH	BIT(3)
>> +#define XDMA_CTRL_IE_MAGIC_STOPPED		BIT(4)
>> +#define XDMA_CTRL_IE_IDLE_STOPPED		BIT(6)
>> +#define XDMA_CTRL_IE_READ_ERROR			(0x1FUL << 9)
>> +#define XDMA_CTRL_IE_DESC_ERROR			(0x1FUL << 19)
> Ditto.
>
>> +/**
>> + * xdma_config_channels - Detect and config DMA channels
>> + * @xdev: DMA device pointer
>> + * @dir: Channel direction
>> + */
>> +static int xdma_config_channels(struct xdma_device *xdev,
>> +				enum dma_transfer_direction dir)
>> +{
>> +	struct xdma_platdata *pdata = dev_get_platdata(&xdev->pdev->dev);
>> +	u32 base, identifier, target;
>> +	struct xdma_chan **chans;
>> +	u32 *chan_num;
>> +	int i, j, ret;
>> +
>> +	if (dir == DMA_MEM_TO_DEV) {
>> +		base = XDMA_CHAN_H2C_OFFSET;
>> +		target = XDMA_CHAN_H2C_TARGET;
>> +		chans = &xdev->h2c_chans;
>> +		chan_num = &xdev->h2c_chan_num;
>> +	} else if (dir == DMA_DEV_TO_MEM) {
>> +		base = XDMA_CHAN_C2H_OFFSET;
>> +		target = XDMA_CHAN_C2H_TARGET;
>> +		chans = &xdev->c2h_chans;
>> +		chan_num = &xdev->c2h_chan_num;
>> +	} else {
>> +		xdma_err(xdev, "invalid direction specified");
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* detect number of available DMA channels */
>> +	for (i = 0, *chan_num = 0; i < pdata->max_dma_channels; i++) {
>> +		ret = xdma_read_reg(xdev, base + i * XDMA_CHAN_STRIDE,
>> +				    XDMA_CHAN_IDENTIFIER, &identifier);
>> +		if (ret) {
>> +			xdma_err(xdev, "failed to read channel id: %d", ret);
>> +			return ret;
>> +		}
>> +
>> +		/* check if it is available DMA channel */
>> +		if (XDMA_CHAN_CHECK_TARGET(identifier, target))
>> +			(*chan_num)++;
>> +	}
>> +
>> +	if (!*chan_num) {
>> +		xdma_err(xdev, "does not probe any channel");
>> +		return -EINVAL;
>> +	}
>> +
>> +	*chans = devm_kzalloc(&xdev->pdev->dev, sizeof(**chans) * (*chan_num),
>> +			      GFP_KERNEL);
>> +	if (!*chans)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0, j = 0; i < pdata->max_dma_channels; i++) {
>> +		ret = xdma_read_reg(xdev, base + i * XDMA_CHAN_STRIDE,
>> +				    XDMA_CHAN_IDENTIFIER, &identifier);
>> +		if (ret) {
>> +			xdma_err(xdev, "failed to read channel id: %d", ret);
>> +			return ret;
>> +		}
> Is it ok to not rollback the allocation in case of an error occurs?

In this loop, the failures are returned by read/write registers. The 
read/write register failure indicates serious hardware issue and the 
hardware may not be rollback in this situation.

>
>> +
>> +		if (!XDMA_CHAN_CHECK_TARGET(identifier, target))
>> +			continue;
>> +
>> +		if (j == *chan_num) {
>> +			xdma_err(xdev, "invalid channel number");
>> +			return -EIO;
>> +		}
> Same here?
>
>> +
>> +		/* init channel structure and hardware */
>> +		(*chans)[j].xdev_hdl = xdev;
>> +		(*chans)[j].base = base + i * XDMA_CHAN_STRIDE;
>> +		(*chans)[j].dir = dir;
>> +
>> +		ret = xdma_channel_init(&(*chans)[j]);
>> +		if (ret)
>> +			return ret;
> And here.
>
>> +		(*chans)[j].vchan.desc_free = xdma_free_desc;
>> +		vchan_init(&(*chans)[j].vchan, &xdev->dma_dev);
>> +
>> +		j++;
>> +	}
>> +
>> +	dev_info(&xdev->pdev->dev, "configured %d %s channels", j,
>> +		 (dir == DMA_MEM_TO_DEV) ? "H2C" : "C2H");
>> +
>> +	return 0;
>> +}
>
>> +static int xdma_irq_init(struct xdma_device *xdev)
>> +{
>> +	u32 irq = xdev->irq_start;
>> +	int i, j, ret;
>> +
>> +	/* return failure if there are not enough IRQs */
>> +	if (xdev->irq_num < xdev->h2c_chan_num + xdev->c2h_chan_num) {
>> +		xdma_err(xdev, "not enough irq");
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* setup H2C interrupt handler */
>> +	for (i = 0; i < xdev->h2c_chan_num; i++) {
>> +		ret = request_irq(irq, xdma_channel_isr, 0,
>> +				  "xdma-h2c-channel", &xdev->h2c_chans[i]);
>> +		if (ret) {
>> +			xdma_err(xdev, "H2C channel%d request irq%d failed: %d",
>> +				 i, irq, ret);
>> +			for (j = 0; j < i; j++) {
>> +				free_irq(xdev->h2c_chans[j].irq,
>> +					 &xdev->h2c_chans[j]);
>> +			}
>> +			return ret;
> Remove freeing for loop and just do
> 			goto failed_init_c2h;
> And reverse the iteration order down on the error path (from i to zero) by
> using
> 	while (i--)
Thanks. This looks much cleaner than before. :)
>
>> +		}
>> +		xdev->h2c_chans[i].irq = irq;
>> +		irq++;
>> +	}
>> +
>> +	/* setup C2H interrupt handler */
>> +	for (i = 0; i < xdev->c2h_chan_num; i++) {
>> +		ret = request_irq(irq, xdma_channel_isr, 0,
>> +				  "xdma-c2h-channel", &xdev->c2h_chans[i]);
>> +		if (ret) {
>> +			xdma_err(xdev, "H2C channel%d request irq%d failed: %d",
>> +				 i, irq, ret);
>> +			for (j = 0; j < i; j++) {
>> +				free_irq(xdev->c2h_chans[j].irq,
>> +					 &xdev->c2h_chans[j]);
>> +			}
>> +			goto failed_init_c2h;
> Ditto. But use j for this whole for loop so you can just do while (j--) on
> the error path as the index variable won't clash with the previous loop.
>
>> +		}
>> +		xdev->c2h_chans[i].irq = irq;
>> +		irq++;
>> +	}
>> +
>> +	/* config hardware IRQ registers */
>> +	ret = xdma_set_vector_reg(xdev, XDMA_IRQ_CHAN_VEC_NUM, 0,
>> +				  xdev->h2c_chan_num + xdev->c2h_chan_num);
>> +	if (ret) {
>> +		xdma_err(xdev, "failed to set channel vectors: %d", ret);
>> +		goto failed;
>> +	}
>> +
>> +	/* enable interrupt */
>> +	ret = xdma_enable_intr(xdev);
>> +	if (ret) {
>> +		xdma_err(xdev, "failed to enable interrupts: %d", ret);
>> +		goto failed;
>> +	}
>> +
>> +	return 0;
>> +
>> +failed:
>> +	for (i = 0; i < xdev->c2h_chan_num; i++)
> As mentioned above:
>
> while (j--)
>
>> +		free_irq(xdev->c2h_chans[i].irq, &xdev->c2h_chans[i]);
>> +failed_init_c2h:
>> +	for (i = 0; i < xdev->h2c_chan_num; i++)
> while (i--)
>
>> +		free_irq(xdev->h2c_chans[i].irq, &xdev->h2c_chans[i]);
>> +
>> +	return ret;
>> +}
>> +
>> +static bool xdma_filter_fn(struct dma_chan *chan, void *param)
>> +{
>> +	struct xdma_chan *xdma_chan = to_xdma_chan(chan);
>> +	struct xdma_chan_info *chan_info = param;
>> +
>> +	if (chan_info->dir != xdma_chan->dir)
>> +		return false;
>> +
>> +	return true;
> return chan_info->dir == xdma_chan->dir;

Sure. I will change this.


Thanks,

Lizhi

>
>
