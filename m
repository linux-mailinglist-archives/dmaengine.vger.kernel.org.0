Return-Path: <dmaengine+bounces-1119-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7EB867C6D
	for <lists+dmaengine@lfdr.de>; Mon, 26 Feb 2024 17:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A28F829454D
	for <lists+dmaengine@lfdr.de>; Mon, 26 Feb 2024 16:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD2012C7FA;
	Mon, 26 Feb 2024 16:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="q/SWwKtA"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1955660BBB;
	Mon, 26 Feb 2024 16:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708966047; cv=fail; b=L3C4OORPDzODJKcVz3CtkHxFimCd891bKCYbDiWD2SxhKPqTggMfinK0bHoh6QRv8CL+JeJvOPn7kPMcSOjEokRYlZLN2G2/D16KUqQk066S9vxA20ojBWrQIeOjWbeEUpGzGYgNwGhz4qQSYHVxLkeAmdsiyzpUT7I+ooQA7BM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708966047; c=relaxed/simple;
	bh=tYQlMBB4p8+LTZERNpfzSLZxACRKlHqE9B99FU/YHtk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ml6jX/yuTiIdHFibHSXeNZAnaxpdtJX/w1UsoBm4A/elTrLx51puEh0BZYVDRtluAskPRCJdkakdon3tjKCl5FC3aa3jxm4jQ3C3CrSeyAmINEFvfZzwC4KMJoDEl4n34aUpFzI5Jih18KVubzcF6hiFboLrZPBR+0Dbjn0uT68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=q/SWwKtA; arc=fail smtp.client-ip=40.107.243.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cHR8shovFmUeypUWVu/xDleHKfzfjafZGuZ4IA6YF2wKm2swKFSnox/Hn9t8Fh379DtAM5zYJLkBcRUCk9PMw/VWAYEpEZfuknVqlb8vobg3/ru8kHXjRVjcL4Ky3t9TCM/64hKJ6rX+9RVfb39Pf5hh72CKVVD5nlFqjrPOvnRIjTj2r6C4xJlBdbg+sCd2me+cL0N1MtBa2/x8tnB368AjBZM+MAGY0noPPpclKf05hJla0DFJg2NDHIFOSkv54rTT2ixpPefpVjCLbIAJF/xTZ5Tg7VbMndj98NHOeqoBzUEOyPLrnB6qnvdccTBHhSrTrcw3m30BwSuAf5bS1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oICaJ6h61av1nf5yHrJ2E3Ja8hlM7ElI7k0iUu5n+C8=;
 b=Ot8SPfd6l+V2BkU2XCynvF+WiVQBGKafhkDAcQLj2R/jvtrDLSGptuzcCPxeAchSK5peCqqWYfRIYY4BP+nLeI/hUa+E5q7da15IxCw2qHLLTGWTAlmGuod5ZcOU5808cn7fzN8hzmucpA23BL1jSnqcD+SzgZUTrzOzIQsDgYNm12XFzl/CRr5rDjubHOP14YPy2noiNTxnp3fSBfMAMQSBtYL5fPiXs1j86f3fx3Kz5pPLY1F54PBeZbo7e4tZJ5wFF+5+oNqzIkLU8UVkoEAh9jy7TarqeV4PccRyjZurHBRHRFmFL1Ut5UtmdjyEtXvfq9fXKHL4gchJhZxpZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=wanadoo.fr smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oICaJ6h61av1nf5yHrJ2E3Ja8hlM7ElI7k0iUu5n+C8=;
 b=q/SWwKtAsovIKeYY+m6aaKvDsguxzIMryqofWaEWUmM/cRl+ObX+z3prbd5DZ0wHXPARzE0Ova3Xh6KD9vWfmwpreh2gYfaa3KYWBnwi2weIJ9GLnI0ImDLBlOlmqP7LnsLQ9w08OatJYJ/fnghglWB9IuUMUmigWipnlRl/GHs=
Received: from BN8PR04CA0014.namprd04.prod.outlook.com (2603:10b6:408:70::27)
 by BL3PR12MB6642.namprd12.prod.outlook.com (2603:10b6:208:38e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.31; Mon, 26 Feb
 2024 16:47:19 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:408:70:cafe::79) by BN8PR04CA0014.outlook.office365.com
 (2603:10b6:408:70::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.49 via Frontend
 Transport; Mon, 26 Feb 2024 16:47:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Mon, 26 Feb 2024 16:47:19 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 26 Feb
 2024 10:47:19 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 26 Feb
 2024 10:47:18 -0600
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 26 Feb 2024 10:47:18 -0600
Message-ID: <f4b55643-a28e-fc4c-8c94-692bc1370d0e@amd.com>
Date: Mon, 26 Feb 2024 08:47:13 -0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RESEND PATCH V8 2/2] dmaengine: amd: qdma: Add AMD QDMA driver
Content-Language: en-US
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, <vkoul@kernel.org>,
	<dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Nishad Saraf <nishads@amd.com>, <nishad.saraf@amd.com>,
	<sonal.santan@amd.com>, <max.zhen@amd.com>
References: <1708707403-47386-1-git-send-email-lizhi.hou@amd.com>
 <1708707403-47386-3-git-send-email-lizhi.hou@amd.com>
 <530912d2-aa44-494d-bd51-dcac6147b78a@wanadoo.fr>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <530912d2-aa44-494d-bd51-dcac6147b78a@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB05.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|BL3PR12MB6642:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f817858-3b24-43a0-431a-08dc36ea98ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Io4Ow17aiCWb1d9sJtVK2Z/27w7Y1vNioi8K0YJGeU8Sukyrj/dlrgx7fJM5ZfSt++BeurAKi8ws8Uq45y1OfWuqUr5FNNVc803+xOj9RqaxP+7rgPUlFf+w/grClGuYdtLiIMPFBdVJIDtJmIKIoFrJNeN/KyAEE10rupmCJsLyt7SM62Odb/1YzR6+vmk4LLxTpqmc1pKwamMbxUkxzOqCCzjkUVAlqSk8VxiEd05b14rXFrfHyyWX8j8Ni2Pp40J8htmG967sR2BBynGJd9K5ipWrmOv1aIB9R+k+WnAenlnR1Y6bKxvNNydca3t/2+EYWpjhtbE388KcvkX5i5EghOM617/d9DQgzWQyyjaeGZ875ElCnWGOGIt6ZNRZnA5EnwoAJVR3jrjZ9EJw6hGGt424SGs5SgpHqFzAefnfjTiiveAqsdjSapRiNIPlfwaVDo56n98Fh+tTkgoaEoFhYabFJEGPhBIxX26GuFu8g2GQrA4zS+tmtKrk2cipiwVNAu4wtmeibmHqjAjHe7t4vw3AfQuFEV4F17/Suc+C8/QFy192+jpEqAUExEg9RUd3evEwjiYGyl/Aocd6yqgvs9fhPKOFtUPsmECUXoxG4EO8G6rMYmN7+TwVzpNJ3EIwrPB+OAZOu7DPlImxKeYkZPUE5GB+d+V0I/VTNyLYht9RuYKvcyx6XJ7PqqyErylbZvVTM/AD5Yxfvp8Uy2iNb5WyOd3b/QbjXBe6eHda5dosaAUVUdFHprsK2KRy
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 16:47:19.5519
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f817858-3b24-43a0-431a-08dc36ea98ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6642


On 2/23/24 10:50, Christophe JAILLET wrote:
> Le 23/02/2024 à 17:56, Lizhi Hou a écrit :
>> From: Nishad Saraf <nishads@amd.com>
>>
>> Adds driver to enable PCIe board which uses AMD QDMA (the Queue-based
>> Direct Memory Access) subsystem. For example, Xilinx Alveo V70 AI
>> Accelerator devices.
>>      https://www.xilinx.com/applications/data-center/v70.html
>>
>> The QDMA subsystem is used in conjunction with the PCI Express IP block
>> to provide high performance data transfer between host memory and the
>> card's DMA subsystem.
>>
>>              +-------+       +-------+       +-----------+
>>     PCIe     |       |       |       |       |           |
>>     Tx/Rx    |       |       |       |  AXI  |           |
>>   <=======>  | PCIE  | <===> | QDMA  | <====>| User Logic|
>>              |       |       |       |       |           |
>>              +-------+       +-------+       +-----------+
>>
>> The primary mechanism to transfer data using the QDMA is for the QDMA
>> engine to operate on instructions (descriptors) provided by the host
>> operating system. Using the descriptors, the QDMA can move data in both
>> the Host to Card (H2C) direction, or the Card to Host (C2H) direction.
>> The QDMA provides a per-queue basis option whether DMA traffic goes
>> to an AXI4 memory map (MM) interface or to an AXI4-Stream interface.
>>
>> The hardware detail is provided by
>>      https://docs.xilinx.com/r/en-US/pg302-qdma
>>
>> Implements dmaengine APIs to support MM DMA transfers.
>> - probe the available DMA channels
>> - use dma_slave_map for channel lookup
>> - use virtual channel to manage dmaengine tx descriptors
>> - implement device_prep_slave_sg callback to handle host scatter gather
>>    list
>> - implement descriptor metadata operations to set device address for DMA
>>    transfer
>>
>> Signed-off-by: Nishad Saraf <nishads@amd.com>
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>> ---
>
> ...
>
>> +static void qdma_free_qintr_rings(struct qdma_device *qdev)
>> +{
>> +    int i;
>> +
>> +    for (i = 0; i < qdev->qintr_ring_num; i++) {
>> +        if (!qdev->qintr_rings[i].base)
>> +            continue;
>> +
>> +        dma_free_coherent(&qdev->pdev->dev, QDMA_INTR_RING_SIZE,
>> +                  qdev->qintr_rings[i].base,
>> +                  qdev->qintr_rings[i].dev_base);
>> +    }
>> +}
>> +
>> +static int qdma_alloc_qintr_rings(struct qdma_device *qdev)
>> +{
>> +    u32 ctxt[QDMA_CTXT_REGMAP_LEN];
>> +    struct device *dev = &qdev->pdev->dev;
>> +    struct qdma_intr_ring *ring;
>> +    struct qdma_ctxt_intr intr_ctxt;
>> +    u32 vector;
>> +    int ret, i;
>> +
>> +    qdev->qintr_ring_num = qdev->queue_irq_num;
>> +    qdev->qintr_rings = devm_kcalloc(dev, qdev->qintr_ring_num,
>> +                     sizeof(*qdev->qintr_rings),
>> +                     GFP_KERNEL);
>> +    if (!qdev->qintr_rings)
>> +        return -ENOMEM;
>> +
>> +    vector = qdev->queue_irq_start;
>> +    for (i = 0; i < qdev->qintr_ring_num; i++, vector++) {
>> +        ring = &qdev->qintr_rings[i];
>> +        ring->qdev = qdev;
>> +        ring->msix_id = qdev->err_irq_idx + i + 1;
>> +        ring->ridx = i;
>> +        ring->color = 1;
>> +        ring->base = dma_alloc_coherent(dev, QDMA_INTR_RING_SIZE,
>> +                        &ring->dev_base,
>> +                        GFP_KERNEL);
>
> Hi,
>
> Does it make sense to use dmam_alloc_coherent() and remove 
> qdma_free_qintr_rings()?
>
> If yes, maybe the function could be renamed as 
> qdmam_alloc_qintr_rings() or devm_qdma_alloc_qintr_rings() to show 
> that it is fully managed.

Sounds great. I will re-spin another patch set to change this.


Thanks,

Lizhi

>
> CJ
>
>> +        if (!ring->base) {
>> +            qdma_err(qdev, "Failed to alloc intr ring %d", i);
>> +            ret = -ENOMEM;
>> +            goto failed;
>> +        }
>> +        intr_ctxt.agg_base = QDMA_INTR_RING_BASE(ring->dev_base);
>> +        intr_ctxt.size = (QDMA_INTR_RING_SIZE - 1) / 4096;
>> +        intr_ctxt.vec = ring->msix_id;
>> +        intr_ctxt.valid = true;
>> +        intr_ctxt.color = true;
>> +        ret = qdma_prog_context(qdev, QDMA_CTXT_INTR_COAL,
>> +                    QDMA_CTXT_CLEAR, ring->ridx, NULL);
>> +        if (ret) {
>> +            qdma_err(qdev, "Failed clear intr ctx, ret %d", ret);
>> +            goto failed;
>> +        }
>> +
>> +        qdma_prep_intr_context(qdev, &intr_ctxt, ctxt);
>> +        ret = qdma_prog_context(qdev, QDMA_CTXT_INTR_COAL,
>> +                    QDMA_CTXT_WRITE, ring->ridx, ctxt);
>> +        if (ret) {
>> +            qdma_err(qdev, "Failed setup intr ctx, ret %d", ret);
>> +            goto failed;
>> +        }
>> +
>> +        ret = devm_request_threaded_irq(dev, vector, NULL,
>> +                        qdma_queue_isr, IRQF_ONESHOT,
>> +                        "amd-qdma-queue", ring);
>> +        if (ret) {
>> +            qdma_err(qdev, "Failed to request irq %d", vector);
>> +            goto failed;
>> +        }
>> +    }
>> +
>> +    return 0;
>> +
>> +failed:
>> +    qdma_free_qintr_rings(qdev);
>> +    return ret;
>> +}
>
> ...

