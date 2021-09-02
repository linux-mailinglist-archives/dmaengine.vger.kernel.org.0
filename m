Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1440C3FEC8B
	for <lists+dmaengine@lfdr.de>; Thu,  2 Sep 2021 12:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbhIBK6Z (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Sep 2021 06:58:25 -0400
Received: from mail-mw2nam12on2056.outbound.protection.outlook.com ([40.107.244.56]:7937
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231133AbhIBK6Z (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 2 Sep 2021 06:58:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NPjKYjRmcPVLOaH7GpKIy17Qu3j77IqmWMVh96ERbcQz7taFVJCUpx+gjLgnFqYNwacfLf3n3IY+yL7UuJvUEdgiGYIIsMnxpZgnyTbq/6Fz0c2bz9II4eRw1YEsOX25MYy9J2DHUlnwQw52DvqCdmIDhRFdBXHRjbPTaQRfDVtxEMNNd4g5mep4DoSRworQQ/u7Q4qdApDsR5/DJPNRsX4GhUZt9flcF0uSZ/a19vNR26FP4Y1+2bTkSjzZhlW+dF96f+wFujIRaAtQMVI+QcMMXdNdqzeynYjYXeXmyRmMCdwMoFiQ/9WR89fPUQPIXVLrHawNqG4sa2mM9zSHRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PeW0MmJaslvMcOD7K6hWrM1/w+o+9+7kmnLEKhDPjLc=;
 b=Vs8tDzRPeuUMkWK03PsRzc3jTJJNYUVj92s2/CVfKTe2cvo9OTvdTO6LWziBmv1fnJG51QMYW6MhAAcQduMxlBPiCngiDzOsUZj4dsjtTmvoHF4xEQ7nngLuW4bUwzV45Xz1bNv6FuKKVedXAU/efbGq/by9U0h7NnQMiSxUzSWi9AJaeiYt8K0Za3UkG/ngzD8e1PpjnCWdFFzB5viX/vPY7CM84jjgNy4up5j5yLKIB/XIp1iQluigR78w79QrA5nJIIrD4GC+xzge7j9vynp884xetz3pL3he/eEybJ3o06crLou9IU1oG00Hk+SVnlfr5mHmfr6azEJowMj5Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PeW0MmJaslvMcOD7K6hWrM1/w+o+9+7kmnLEKhDPjLc=;
 b=cqN210zNjY3sJs3n8ahdodr08Wt9msD9LEH2frfNbAmZ/jhKaUDLy+6FP1z+4lPY5sSrqliE/LuypMaIAqTKJZedI9NQj2spwDLqhwv4JPoUr5Q/HsNXnVxDWxLbkPAFZHOwwuS9jg5yjlRFNL2anrrBX+JshTlEzg2uuUWm6pmRznzS5VSu26yCRBbO2YvXGNPIphHJVs6FO8hh+8G/vPFMQRtPpQVfd4dGdepNKyuO77z0ucmDEuFrTi2jb7UryepJzHOCneD0RNY9PBnOSwYMylFPq11cVzZ6YkPsqYE+P6yxC4wvi1Cl8y/9GjstrLqVIlwHU8CnqUI81hsliQ==
Received: from MW3PR05CA0017.namprd05.prod.outlook.com (2603:10b6:303:2b::22)
 by DM4PR12MB5376.namprd12.prod.outlook.com (2603:10b6:5:39a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.24; Thu, 2 Sep
 2021 10:57:25 +0000
Received: from CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::d7) by MW3PR05CA0017.outlook.office365.com
 (2603:10b6:303:2b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.6 via Frontend
 Transport; Thu, 2 Sep 2021 10:57:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 CO1NAM11FT061.mail.protection.outlook.com (10.13.175.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4478.19 via Frontend Transport; Thu, 2 Sep 2021 10:57:25 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 2 Sep
 2021 10:57:24 +0000
Received: from [10.26.49.12] (172.20.187.6) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 2 Sep 2021
 10:57:21 +0000
Subject: Re: [PATCH v3 2/4] dmaengine: tegra: Add tegra gpcdma driver
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Akhil R <akhilrajeev@nvidia.com>, <rgumasta@nvidia.com>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <kyarlagadda@nvidia.com>, <ldewangan@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <p.zabel@pengutronix.de>, <thierry.reding@gmail.com>,
        <vkoul@kernel.org>, Pavan Kunapuli <pkunapuli@nvidia.com>
References: <MN2PR12MB41438B94148A6D522C056771A2A70@MN2PR12MB4143.namprd12.prod.outlook.com>
 <1630044294-21169-1-git-send-email-akhilrajeev@nvidia.com>
 <1630044294-21169-3-git-send-email-akhilrajeev@nvidia.com>
 <4f0293e1-01de-8735-40e7-0622d185188a@nvidia.com>
Message-ID: <64505970-1d68-b4cb-490b-7bfa1c842a1f@nvidia.com>
Date:   Thu, 2 Sep 2021 11:57:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <4f0293e1-01de-8735-40e7-0622d185188a@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eba119a5-5e3f-4cdd-dc4c-08d96e0072b0
X-MS-TrafficTypeDiagnostic: DM4PR12MB5376:
X-Microsoft-Antispam-PRVS: <DM4PR12MB537609613ED034D764A1863ED9CE9@DM4PR12MB5376.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HiFOE/8Afk72yCKhos++UtGjVM27wl50mkCk2eWhUcmWSMojvxCW7Nd42ZIECNmTFt5t9508nusEdcnytw/joFAXw1tvqevq39A6bfXW+m1ypCr38b8yoVz8iX8iBmjgB6YHSghcsVsEBL9YnmGlSv8Z2hNKRkp3llOeCMQgucmbFwV44GaOVC53nJ+ek929gZOReRDycfoDycS94+08+lVwxjuDPXmzfAwS4tW/leTzY5zTt5Tnii0Ob94miDDI5IM7i3/WY+ZWHzJ7I1LW1U9AYstVReohuHbbkVLCcduc5XS0wZnBC6pvS9zOiV+NVEYypGWzp7UPRRFV+jfO5bUwPbfi201wzU76jZoR1A62g5on01xDEoGPVqU4wAB+o6DpbtEUS/ahUnft6i69ac1UUuBiuZKogQqjRHN+mFv/BaCk5HcFK5yP67ILw3IKa5d4mFPvVk1hZ9cXn2+NuTwlp7b4pz0B8kqMrj61uBWpDGFHWPcCWA9rP3dQANrhagKOwgGO5bKLD4oLcCJP7UraDjKEG+2godAf9QjxUktLQ1vd2fT9JpUGa6CZBqTKkdD4/wx1DHj/mjMsxnFgPiu5ZfGxzv/MS/0LkQtmz770GiAq+dGd+BC0gCMhCJCr/BHDYWSzvBfoumYhC7taoxLbt2CRJ+1T6W3uLLM5HA5evF46mor9ZN9/KZElpes14bijxgs/hKzuwr9lsn6WbY4kBjAXOmu0tbu7P3suBmM=
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid04.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(396003)(136003)(36840700001)(46966006)(426003)(82310400003)(316002)(478600001)(16576012)(26005)(82740400003)(107886003)(186003)(53546011)(36906005)(2616005)(31686004)(356005)(7636003)(31696002)(8676002)(6636002)(36756003)(86362001)(4326008)(70586007)(8936002)(54906003)(5660300002)(70206006)(83380400001)(47076005)(336012)(36860700001)(2906002)(16526019)(110136005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2021 10:57:25.1715
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eba119a5-5e3f-4cdd-dc4c-08d96e0072b0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5376
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 01/09/2021 21:56, Jon Hunter wrote:
> 
> On 27/08/2021 07:04, Akhil R wrote:
>> Adding GPC DMA controller driver for Tegra186 and Tegra194. The driver
>> supports dma transfers between memory to memory, IO peripheral to memory
>> and memory to IO peripheral.
>>
>> Signed-off-by: Pavan Kunapuli <pkunapuli@nvidia.com>
>> Signed-off-by: Rajesh Gumasta <rgumasta@nvidia.com>
>> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
>> ---
>>   drivers/dma/Kconfig         |   12 +
>>   drivers/dma/Makefile        |    1 +
>>   drivers/dma/tegra-gpc-dma.c | 1343 
>> +++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 1356 insertions(+)
>>   create mode 100644 drivers/dma/tegra-gpc-dma.c

...

>> +static int tegra_dma_terminate_all(struct dma_chan *dc)
>> +{
>> +    struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
>> +    unsigned long wcount = 0;
>> +    unsigned long status;
>> +    unsigned long flags;
>> +    bool was_busy;
>> +    int err;
>> +
>> +    raw_spin_lock_irqsave(&tdc->lock, flags);
>> +
>> +    if (!tdc->dma_desc) {
>> +        raw_spin_unlock_irqrestore(&tdc->lock, flags);
>> +        return 0;
>> +    }
>> +
>> +    if (!tdc->busy)
>> +        goto skip_dma_stop;
>> +
>> +    if (tdc->tdma->chip_data->hw_support_pause) {
>> +        err = tegra_dma_pause(tdc);
>> +        if (err) {
>> +            raw_spin_unlock_irqrestore(&tdc->lock, flags);
>> +            return err;
>> +        }
>> +    } else {
>> +        /* Before Reading DMA status to figure out number
>> +         * of bytes transferred by DMA channel:
>> +         * Change the client associated with the DMA channel
>> +         * to stop DMA engine from starting any more bursts for
>> +         * the given client and wait for in flight bursts to complete
>> +         */
>> +        tegra_dma_reset_client(tdc);
>> +
>> +        /* Wait for in flight data transfer to finish */
>> +        udelay(TEGRA_GPCDMA_BURST_COMPLETE_TIME);
>> +
>> +        /* If TX/RX path is still active wait till it becomes
>> +         * inactive
>> +         */
>> +
>> +        if (readl_relaxed_poll_timeout_atomic(tdc->tdma->base_addr +
>> +                tdc->chan_base_offset +
>> +                TEGRA_GPCDMA_CHAN_STATUS,
>> +                status,
>> +                !(status & (TEGRA_GPCDMA_STATUS_CHANNEL_TX |
>> +                TEGRA_GPCDMA_STATUS_CHANNEL_RX)),
>> +                5,
>> +                TEGRA_GPCDMA_BURST_COMPLETION_TIMEOUT)) {
>> +            dev_dbg(tdc2dev(tdc), "Timeout waiting for DMA burst 
>> completion!\n");
>> +            tegra_dma_dump_chan_regs(tdc);
>> +        }
> 
> I would be tempted to make the code in the 'else' clause 
> tegra_dma_sw_pause(). Then you could have tegra_dma_hw_pause() and 
> tegra_dma_sw_pause().


Thinking some more tegra_dma_hw_pause() and tegra_dma_sw_pause() it not 
very clear/accurate. I would be tempted to call these tegra_dma_pause() 
and tegra_dma_stop_client() or tegra_dma_stop_transactions(), because 
without having a proper hardware pause, you are simply ignoring the 
client sync events.

Jon
-- 
nvpublic
