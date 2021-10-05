Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60CA4421FB4
	for <lists+dmaengine@lfdr.de>; Tue,  5 Oct 2021 09:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbhJEHww (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 5 Oct 2021 03:52:52 -0400
Received: from mail-dm6nam11on2042.outbound.protection.outlook.com ([40.107.223.42]:15489
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232630AbhJEHwv (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 5 Oct 2021 03:52:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I6Gty5cA7ptsz03LKfvdGwB9X4lZV2hVkEhhq4XEBGJRwI9aP/7FiCGD4qnm5Lu0QrQdn8eAS5yAzb0PP6jG1EoxPojz89WnRFK+rHjEHY0g2i2R8a9giDZkdYNlgBO4BILcuy6CYss6Rg5b6aTuU6nWUG5pKh2FjqfHC0KdD+HSDRwl9uVmqljUT6F41SGCcNPTleVNKKtocXPICj3S5l9P3DYWwKC4VLUx1RsDRm7dtpspxhncPLjK5krmPDvp8PV9nykH07Dsvwskz9bKikxf3f6Zlil1A7qjEb2fZyxAM87PLqy/R5jJS3fEhx54hHGHkmzOS5RHB8v+EzRIfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/6vlOk+9kYXlR6Fd/7LoQqHbv0rUPl8XnXrsU09+3JU=;
 b=fVMuAmpAdIn1x9UA0WeuTSIoWMSQhcWgYlW2UYas+Fea4oLiXgvyUdG60NC9re2WUk85KI4TabnV0ycp45KZMwy4EBGAIUNxNuCktVkxw8YD4vQLZx2u3FglsmT2obnnKmWWouqbbRbiw8tIC15Epvu43g9XsYU2yRpRx+ctG/R/GD6ya6MfMkrKB0nNJDnRbHKzMmpD1YlZImRiwc54J1lmYE2ESZMjiq8z7vVOjyO3NJAB7wcZjive+XpqrIsrXVsdFoINq5HyK2t3GUx3l/dEoG1zaHpFd9PJnB7a1Tl6J7X6jA6W1dJ4nWu8TiTfhh0tvYebjpALOXZRVBJ05Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6vlOk+9kYXlR6Fd/7LoQqHbv0rUPl8XnXrsU09+3JU=;
 b=hA/RRmNJBRjiwHoqcEeSwRdbqkIt0oSIMC5Aw/YLRXlxBoTguRw3apWlYk6Kf6W7jSq1aHMExI88V+dRj4uOg1oqoem3bO23VUVvr6BYKHOYSMeL0Po4KJzt7mkw/O1bjwZONKp+7hTeaJx0IJHG02eeJyWgr867efwD7RbXKwcbmdBPKaTwVIcux2LLJKwoCsCFUKCeKkGbVWDOhZVTfqpkrQ5F/Y5CYARCPdF/8Tt9vQ4l0DAoslyqcJnj9zOeHGC6ouxMZ3GPAG6QBezsdT2cwcQGpx7I961tzdEzuj41tUpEq/JDdS0UFJdklBBSW1oJko/GEa9gy/5LDUtqSQ==
Received: from MWHPR11CA0020.namprd11.prod.outlook.com (2603:10b6:301:1::30)
 by DM6PR12MB3227.namprd12.prod.outlook.com (2603:10b6:5:18d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.21; Tue, 5 Oct
 2021 07:51:00 +0000
Received: from CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:1:cafe::7d) by MWHPR11CA0020.outlook.office365.com
 (2603:10b6:301:1::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Tue, 5 Oct 2021 07:51:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT020.mail.protection.outlook.com (10.13.174.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4566.14 via Frontend Transport; Tue, 5 Oct 2021 07:50:59 +0000
Received: from [10.26.49.14] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 5 Oct
 2021 07:50:54 +0000
Subject: Re: [PATCH v8 2/4] dmaengine: tegra: Add tegra gpcdma driver
To:     Akhil R <akhilrajeev@nvidia.com>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <kyarlagadda@nvidia.com>, <ldewangan@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <p.zabel@pengutronix.de>, <rgumasta@nvidia.com>,
        <thierry.reding@gmail.com>, <vkoul@kernel.org>,
        Pavan Kunapuli <pkunapuli@nvidia.com>
References: <1632759090-7965-1-git-send-email-akhilrajeev@nvidia.com>
 <1632759090-7965-3-git-send-email-akhilrajeev@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <bd2fa473-7285-f905-ecec-5e97a177d918@nvidia.com>
Date:   Tue, 5 Oct 2021 08:50:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1632759090-7965-3-git-send-email-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 536fc25c-ba20-4fa4-0dad-08d987d4df3b
X-MS-TrafficTypeDiagnostic: DM6PR12MB3227:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3227685A14010A2230C8C499D9AF9@DM6PR12MB3227.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jHNpqAw7ZCxatABrO7aILKIW6JegihkKikt94Cy6YSp5/WRps6CZRAUC7wDqTxLREFZPlok/pCi/EUWNO2juQGNzJ+Rcyza+gj19zoBXv6Kt18lAVLe3z5cDAtPb2JAOLCEObmnIh00ornixzp7lCTpZ+smxOUWEVPar9DkLNp8NYXsRUIUoo0t3/1SjkDb3sUHvpo05gpE/UWX3moQFnu2UbLRHmRn7IJxReB6hx9QcaYu1ag5GDg5m1Xordez7H7fZTx2Lmv806DfztrMWMcX1TUmI5OS6hPpk+CczvztMRjfvarq5lOvbXI6aDQeAkldWBILgggnaoA1w/+y9JSClzWHfhjagI6BrHeHsBCmh7J0Kue+/WoaEce49W3VQ3ccGm/pBLuZGNQmmCoSLU//P5xwlFVZRB+vOK3bw9gkksTsjvJd+4jvrlLhdPXcnew96+09MVlurLf960XX3SFNtedjECBEN2F0gfFD45Wwpw2rM1bfUnjjhcK+0F+siKTBhVuam87R0B8AfchUel3Ofl9XPSoSkKe0APxjGoh6LjJo/5cnj87edwul5mkmAOisUmbDOQPnX3DLgt/fcnhhym15iaB8TB+jTtHKVMxojQKNZCwGK7VX3uKVu+TF3kleHO5lQg/HQI5nB2KYUS9xDYqysjNtpefmrCyx1PvP0yJx0C9dyEcEpcZYJ7UScjHC2W6oIKHyfUrElu3nKK0whqwi5o9GElKlneN//q+k=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(82310400003)(508600001)(2616005)(70206006)(54906003)(426003)(8936002)(336012)(6636002)(316002)(7636003)(356005)(83380400001)(70586007)(86362001)(8676002)(36756003)(36860700001)(26005)(37006003)(6862004)(16576012)(53546011)(31686004)(4326008)(5660300002)(16526019)(47076005)(31696002)(186003)(2906002)(107886003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 07:50:59.6658
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 536fc25c-ba20-4fa4-0dad-08d987d4df3b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3227
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 27/09/2021 17:11, Akhil R wrote:
> Adding GPC DMA controller driver for Tegra186 and Tegra194. The driver
> supports dma transfers between memory to memory, IO peripheral to memory
> and memory to IO peripheral.
> 
> Signed-off-by: Pavan Kunapuli <pkunapuli@nvidia.com>
> Signed-off-by: Rajesh Gumasta <rgumasta@nvidia.com>
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> ---
>   drivers/dma/Kconfig            |   12 +
>   drivers/dma/Makefile           |    1 +
>   drivers/dma/tegra186-gpc-dma.c | 1298 ++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 1311 insertions(+)
>   create mode 100644 drivers/dma/tegra186-gpc-dma.c

...

> +static int tegra_dma_terminate_all(struct dma_chan *dc)
> +{
> +	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
> +	unsigned long wcount = 0;
> +	unsigned long status;
> +	unsigned long flags;
> +	int err;
> +
> +	raw_spin_lock_irqsave(&tdc->lock, flags);
> +
> +	if (!tdc->dma_desc) {
> +		raw_spin_unlock_irqrestore(&tdc->lock, flags);
> +		return 0;
> +	}
> +
> +	if (!tdc->busy)
> +		goto skip_dma_stop;
> +
> +	if (tdc->tdma->chip_data->hw_support_pause)
> +		err = tegra_dma_pause(tdc);
> +	else
> +		err = tegra_dma_stop_client(tdc);
> +
> +	if (err) {
> +		raw_spin_unlock_irqrestore(&tdc->lock, flags);
> +		return err;
> +	}
> +
> +	status = tdc_read(tdc, TEGRA_GPCDMA_CHAN_STATUS);
> +	if (status & TEGRA_GPCDMA_STATUS_ISE_EOC) {
> +		dev_dbg(tdc2dev(tdc), "%s():handling isr\n", __func__);
> +		tegra_dma_xfer_complete(tdc);
> +		status = tdc_read(tdc, TEGRA_GPCDMA_CHAN_STATUS);
> +	}
> +
> +	wcount = tdc_read(tdc, TEGRA_GPCDMA_CHAN_XFER_COUNT);
> +	tegra_dma_stop(tdc);
> +
> +	if (tdc->dma_desc)

This is always true here right?

> +		tdc->dma_desc->bytes_transferred +=
> +			tdc->dma_desc->bytes_requested - (wcount * 4);
> +
> +skip_dma_stop:
> +	tegra_dma_sid_free(tdc);
> +	kfree(tdc->dma_desc);
> +	vchan_free_chan_resources(&tdc->vc);
> +
> +	raw_spin_unlock_irqrestore(&tdc->lock, flags);
> +	return 0;
> +}

...

> +static unsigned int get_burst_size(struct tegra_dma_channel *tdc,
> +				   u32 burst_size, enum dma_slave_buswidth slave_bw,
> +				 int len)

There are a few places like this where the alignment could be fixed.

...

 > +static struct dma_async_tx_descriptor *
 > +tegra_dma_prep_dma_memcpy(struct dma_chan *dc, dma_addr_t dest,
 > +			  dma_addr_t src,	size_t len, unsigned long flags)
 > +{

Spacing here.

> +static struct dma_async_tx_descriptor *
> +tegra_dma_prep_slave_sg(struct dma_chan *dc, struct scatterlist *sgl,
> +			unsigned int sg_len, enum dma_transfer_direction direction,
> +		unsigned long flags, void *context)
> +{

Alignment here.

Jon

-- 
nvpublic
