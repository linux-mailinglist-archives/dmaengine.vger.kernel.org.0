Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B62540F51A
	for <lists+dmaengine@lfdr.de>; Fri, 17 Sep 2021 11:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343541AbhIQJqu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Sep 2021 05:46:50 -0400
Received: from mail-bn8nam11on2059.outbound.protection.outlook.com ([40.107.236.59]:21665
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238376AbhIQJqh (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 17 Sep 2021 05:46:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9sLoHAiR+u839okcf1g4WcPne7FvhSBjf5J6x+XV8MdiDG52RtxgsOV+JdgUlkiUogkoL2r7MMXwZu5aWlCAm31fG0tvc0b+5SghabMbqQo/xMuOpF4zTAodVI5vjHboi+FnICh5GBnkhvPGsDilS//cLnY3JyxI32Xd9LqkL4YJT8Z3uBKsd06Jc3ssSpwz5vLUFSyZVkJHr+6HFTaVFEEjN9mbBm1LJQNWPTQzGb9KyuOsv6tSqfj7AOh3HQE/V2c0iMHMqZDMgBu8vzAHMI4/5X5OzgRxLCZiknyma5W+Hr6fX/Mn6P68hOb1DKrrrsCXGEUuCicw2z0XKnIyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=djADTqzMnJs0heYe6UEXfi+4gn6p9TJjlmm84LByt3o=;
 b=NveHg0sT3lcT1DABPHq9UAwFe7hvG5tt1k5+/QsVv8A1+xGLJzmY0cT2ihQvCw53bklJERPQMVs6KLbzMCOVuMBKRTYXc1SI//lzOQGOm/XGKyIAl3r7tJ9J7uybnIkXE4bVvO0EN5NIgOep3iMxvNc059OgfSSsQ/Pgzj8uqyhZAegALq9xUKgcyA9/UnD+cdV9wV6QwJFHYW3UUgYzKFYCKAhNfCIQq3YrATCwG3VcnzQWggmtPXnQKE+vTT6mqSi0yl4CThx8tx6mqkVbr7w0/Z1zbqR7cIMRmp90WJzKIv7BgWgxGYyBRYMUdjudg1e1KZQoTnDnm1GPbxrnZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djADTqzMnJs0heYe6UEXfi+4gn6p9TJjlmm84LByt3o=;
 b=Y91PvMzMm17scBvZDPPgrQY7jxudxLcQO8R4TOTK46gEOxGaoJOoNLUtsuTsAlCtN9iYrsvDsWZGIPzuE5BKNXp6sXRu4HR8sK21DiQVyCbMv/EOiDMzFo54NmDkrHMexbfE6D4FKI871JsvuGCKjxL0kg8vzvqFVG2ApToXTI0BNaLRtYChYvrkjMxCQxawR0TXmfBFbedqj/U5qJU+eJOwaeyA0gXX/3lIL0+YPbveMUOwV+WmEcb6c84f5PuOuYExhLs7OFRXrZdf5DDBx9iQFdHbTdT9qkTbZSNuCG77TWVmXmmk0SWTq2P34awmQ7LmIX73Sybi3wJ+VcluVA==
Received: from DS7PR03CA0105.namprd03.prod.outlook.com (2603:10b6:5:3b7::20)
 by BYAPR12MB2887.namprd12.prod.outlook.com (2603:10b6:a03:12e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Fri, 17 Sep
 2021 09:45:13 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::b0) by DS7PR03CA0105.outlook.office365.com
 (2603:10b6:5:3b7::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Fri, 17 Sep 2021 09:45:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 09:45:13 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 17 Sep
 2021 09:45:12 +0000
Received: from [10.26.49.12] (172.20.187.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 17 Sep
 2021 09:45:10 +0000
Subject: Re: [RESEND PATCH 3/3] dmaengine: tegra210-adma: Override ADMA FIFO
 size
To:     Sameer Pujar <spujar@nvidia.com>, <vkoul@kernel.org>,
        <ldewangan@nvidia.com>, <thierry.reding@gmail.com>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1631722025-19873-1-git-send-email-spujar@nvidia.com>
 <1631722025-19873-4-git-send-email-spujar@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <4fe9ed3b-ea8f-cb53-8e23-e50bec6ebda0@nvidia.com>
Date:   Fri, 17 Sep 2021 10:45:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1631722025-19873-4-git-send-email-spujar@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ddcc2f9b-dcc3-43b2-779a-08d979bfd8e4
X-MS-TrafficTypeDiagnostic: BYAPR12MB2887:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2887283AC25B8DFA37EBB1ECD9DD9@BYAPR12MB2887.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w3j6kaNFA06TJNPArzCTon64UpTU4WJXhvmuY/UbZ54vXH2bGKdPFiQ8qUs+oPfEI/rMJWTFQtUsr2zzPTeqANewNGgypUpThiNCRK95yZrUVi3SAZgmLZRX47F99bZ/s25t2m8myJOCwZFJBETdyMw0A9eNT1sLvWsda9f4ZN4e24xwl2OxAX4fXp+MoQyPMn7/1QJvpXrS7qxx5tLUfSEMubmnMxTQm56ZKl9NZWUVz8LGxMlbQWzyfJqT7ob97iBCCjskXT7OL7HEB4+O0LmhsY1h2Vk0ymeYMnMh7x8va921nz2i7pDrH0W1ftp5jtqzjDHJJmK1a+bi/ZW56wwlXg5VF6ZllifpMVWJtf2Om2OCLEX/yagH8Wv7+D4CbrmiUNO6mLA987h+5xhBdjPzu4e9S8+qdYn23f5TvAb0Ks2QvDphBosc2yVP2Je8B6e2mY58pc9tmKGm1ov7L9ft3ijSUo6paFy44Z91IL6rs5jpijIK9b4UKy9+903kLNoQzgtj3PaQSkYncskMkUOidVHtlkrN5bgyLaB77fdms7GFLskO+gwH8pI27WHIbUxRHblxtYld3DAbkig3NxNkZXJpIexw85ySHSvXgSlURTYH41lTl4t6ZlNg37CV/OA/yay9icTDTFa0R3kELMGvpJU962ebsTSSOUt4qfin/OnYsX3EaOo7C+s5skE1UyK3KrjT9TtbHgpAPvSG24SvUMfITdPnucwKrLvaPX0=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(136003)(346002)(46966006)(36840700001)(5660300002)(316002)(54906003)(86362001)(36906005)(8676002)(26005)(8936002)(110136005)(31696002)(31686004)(478600001)(53546011)(70206006)(2616005)(36756003)(16576012)(82310400003)(47076005)(83380400001)(426003)(4326008)(2906002)(70586007)(36860700001)(336012)(16526019)(356005)(7636003)(186003)(82740400003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 09:45:13.3202
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddcc2f9b-dcc3-43b2-779a-08d979bfd8e4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2887
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 15/09/2021 17:07, Sameer Pujar wrote:
> ADMAIF FIFO uses a ring buffer and it is divided amongst the available
> channels. The default FIFO size (in multiples of 16 words) of ADMAIF TX/RX
> channels is as below:
>   * On Tegra210,
>       channel 1 to 2 : size = 3
>       channel 3 to 10: size = 2
>   * On Tegra186 and later,
>       channel 1 to 4 : size = 3
>       channel 5 to 20: size = 2
> 
> As per recommendation from HW, FIFO size of ADMA channel should be same as
> the corresponding ADMAIF channel it maps to. FIFO corruption is observed if
> the sizes do not match. We are using the default FIFO sizes for ADMAIF and
> there is no plan to support any custom values.
> 
> Thus at runtime, override the ADMA channel FIFO size value depending on the
> corresponding ADMAIF channel.
> 
> Fixes: 9ab59bf5dd63 ("dmaengine: tegra210-adma: Fix channel FIFO configuration")
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
>   drivers/dma/tegra210-adma.c | 48 ++++++++++++++++++++++++++++++++-------------
>   1 file changed, 34 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
> index 03f9776..911533c 100644
> --- a/drivers/dma/tegra210-adma.c
> +++ b/drivers/dma/tegra210-adma.c
> @@ -43,10 +43,8 @@
>   #define TEGRA186_ADMA_CH_CONFIG_OUTSTANDING_REQS(reqs)	(reqs << 4)
>   
>   #define ADMA_CH_FIFO_CTRL				0x2c
> -#define TEGRA210_ADMA_CH_FIFO_CTRL_TXSIZE(val)		(((val) & 0xf) << 8)
> -#define TEGRA210_ADMA_CH_FIFO_CTRL_RXSIZE(val)		((val) & 0xf)
> -#define TEGRA186_ADMA_CH_FIFO_CTRL_TXSIZE(val)		(((val) & 0x1f) << 8)
> -#define TEGRA186_ADMA_CH_FIFO_CTRL_RXSIZE(val)		((val) & 0x1f)
> +#define ADMA_CH_TX_FIFO_SIZE_SHIFT			8
> +#define ADMA_CH_RX_FIFO_SIZE_SHIFT			0
>   
>   #define ADMA_CH_LOWER_SRC_ADDR				0x34
>   #define ADMA_CH_LOWER_TRG_ADDR				0x3c
> @@ -61,12 +59,6 @@
>   
>   #define TEGRA_ADMA_BURST_COMPLETE_TIME			20
>   
> -#define TEGRA210_FIFO_CTRL_DEFAULT (TEGRA210_ADMA_CH_FIFO_CTRL_TXSIZE(3) | \
> -				    TEGRA210_ADMA_CH_FIFO_CTRL_RXSIZE(3))
> -
> -#define TEGRA186_FIFO_CTRL_DEFAULT (TEGRA186_ADMA_CH_FIFO_CTRL_TXSIZE(3) | \
> -				    TEGRA186_ADMA_CH_FIFO_CTRL_RXSIZE(3))
> -
>   #define ADMA_CH_REG_FIELD_VAL(val, mask, shift)	(((val) & mask) << shift)
>   
>   struct tegra_adma;
> @@ -84,6 +76,8 @@ struct tegra_adma;
>    * @ch_req_max: Maximum number of Tx or Rx channels available.
>    * @ch_reg_size: Size of DMA channel register space.
>    * @nr_channels: Number of DMA channels available.
> + * @ch_fifo_size_mask: Mask for FIFO size field.
> + * @sreq_index_offset: Slave channel index offset.
>    * @has_outstanding_reqs: If DMA channel can have outstanding requests.
>    */
>   struct tegra_adma_chip_data {
> @@ -98,6 +92,8 @@ struct tegra_adma_chip_data {
>   	unsigned int ch_req_max;
>   	unsigned int ch_reg_size;
>   	unsigned int nr_channels;
> +	unsigned int ch_fifo_size_mask;
> +	unsigned int sreq_index_offset;
>   	bool has_outstanding_reqs;
>   };
>   
> @@ -561,13 +557,14 @@ static int tegra_adma_set_xfer_params(struct tegra_adma_chan *tdc,
>   {
>   	struct tegra_adma_chan_regs *ch_regs = &desc->ch_regs;
>   	const struct tegra_adma_chip_data *cdata = tdc->tdma->cdata;
> -	unsigned int burst_size, adma_dir;
> +	unsigned int burst_size, adma_dir, fifo_size_shift;
>   
>   	if (desc->num_periods > ADMA_CH_CONFIG_MAX_BUFS)
>   		return -EINVAL;
>   
>   	switch (direction) {
>   	case DMA_MEM_TO_DEV:
> +		fifo_size_shift = ADMA_CH_TX_FIFO_SIZE_SHIFT;
>   		adma_dir = ADMA_CH_CTRL_DIR_MEM2AHUB;
>   		burst_size = tdc->sconfig.dst_maxburst;
>   		ch_regs->config = ADMA_CH_CONFIG_SRC_BUF(desc->num_periods - 1);
> @@ -578,6 +575,7 @@ static int tegra_adma_set_xfer_params(struct tegra_adma_chan *tdc,
>   		break;
>   
>   	case DMA_DEV_TO_MEM:
> +		fifo_size_shift = ADMA_CH_RX_FIFO_SIZE_SHIFT;
>   		adma_dir = ADMA_CH_CTRL_DIR_AHUB2MEM;
>   		burst_size = tdc->sconfig.src_maxburst;
>   		ch_regs->config = ADMA_CH_CONFIG_TRG_BUF(desc->num_periods - 1);
> @@ -599,7 +597,27 @@ static int tegra_adma_set_xfer_params(struct tegra_adma_chan *tdc,
>   	ch_regs->config |= ADMA_CH_CONFIG_WEIGHT_FOR_WRR(1);
>   	if (cdata->has_outstanding_reqs)
>   		ch_regs->config |= TEGRA186_ADMA_CH_CONFIG_OUTSTANDING_REQS(8);
> -	ch_regs->fifo_ctrl = cdata->ch_fifo_ctrl;
> +
> +	/*
> +	 * 'sreq_index' represents the current ADMAIF channel number and as per
> +	 * HW recommendation its FIFO size should match with the corresponding
> +	 * ADMA channel.
> +	 *
> +	 * ADMA FIFO size is set as per below (based on default ADMAIF channel
> +	 * FIFO sizes):
> +	 *    fifo_size = 0x2 (sreq_index > sreq_index_offset)
> +	 *    fifo_size = 0x3 (sreq_index <= sreq_index_offset)
> +	 *
> +	 */
> +	if (tdc->sreq_index > cdata->sreq_index_offset)
> +		ch_regs->fifo_ctrl =
> +			ADMA_CH_REG_FIELD_VAL(2, cdata->ch_fifo_size_mask,
> +					      fifo_size_shift);
> +	else
> +		ch_regs->fifo_ctrl =
> +			ADMA_CH_REG_FIELD_VAL(3, cdata->ch_fifo_size_mask,
> +					      fifo_size_shift);
> +
>   	ch_regs->tc = desc->period_len & ADMA_CH_TC_COUNT_MASK;
>   
>   	return tegra_adma_request_alloc(tdc, direction);
> @@ -783,11 +801,12 @@ static const struct tegra_adma_chip_data tegra210_chip_data = {
>   	.ch_req_tx_shift	= 28,
>   	.ch_req_rx_shift	= 24,
>   	.ch_base_offset		= 0,
> -	.ch_fifo_ctrl		= TEGRA210_FIFO_CTRL_DEFAULT,
>   	.ch_req_mask		= 0xf,
>   	.ch_req_max		= 10,
>   	.ch_reg_size		= 0x80,
>   	.nr_channels		= 22,
> +	.ch_fifo_size_mask	= 0xf,
> +	.sreq_index_offset	= 2,
>   	.has_outstanding_reqs	= false,
>   };
>   
> @@ -798,11 +817,12 @@ static const struct tegra_adma_chip_data tegra186_chip_data = {
>   	.ch_req_tx_shift	= 27,
>   	.ch_req_rx_shift	= 22,
>   	.ch_base_offset		= 0x10000,
> -	.ch_fifo_ctrl		= TEGRA186_FIFO_CTRL_DEFAULT,
>   	.ch_req_mask		= 0x1f,
>   	.ch_req_max		= 20,
>   	.ch_reg_size		= 0x100,
>   	.nr_channels		= 32,
> +	.ch_fifo_size_mask	= 0x1f,
> +	.sreq_index_offset	= 4,
>   	.has_outstanding_reqs	= true,
>   };

Looks good to me. The only minor comment I have is that 
'sreq_index_offset' is not very descriptive. Maybe fifo_size_sreq_index? 
It is not great either, so no big deal either way.

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
