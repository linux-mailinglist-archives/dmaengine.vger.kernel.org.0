Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D291640FC92
	for <lists+dmaengine@lfdr.de>; Fri, 17 Sep 2021 17:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240401AbhIQPiG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Sep 2021 11:38:06 -0400
Received: from mail-sn1anam02on2042.outbound.protection.outlook.com ([40.107.96.42]:6076
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237707AbhIQPiF (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 17 Sep 2021 11:38:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i65Q9VhxhSK+BIuQ0CCg6SpKQYFRFpeqMnv/HbGd3+sDZhkAdN2kkXjhf5oTOnvZ3GjyXR8uaMxQBQK1XdTtygAFKhPKb01RHHz0Qav3M6A6W1VzFRlOXws1+wIklhH3J0ytCG/z16C3+1zG9OhShWGqwxg4taVLmt6AyBcuKgVNoPtiGpZRuxXxq0JMiRO3pTOGqmdJWsBOQsfAq3TNpF3HmUn/FfYCjXU4jMCw6jGIZ2LJAyTONmkgvaRAIfeZeD/aigwp65PckM0lySwow39c6sAPWIJ7b0zdH1OnQhiDC2pUq9VVLhjgTM6sm380ZmY0xxz2TOr1GOoXTx6srg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=CAoGECnfvi1vEgZoH2yVzhglwIhsWmRwW1CtPNJWcPs=;
 b=J25Kf6/mpTGzWcqTGE/ifHv2C4nXC0ijwFBk0fYhjWADqn+SDjb9haoq9hQcG4WQ1C6BalHxwMiQWDvHtrFvWBTtUnm4fP+ARmYtMKZw3sE7xC/uBk0q56OIGvzmv7Ynljt0WY6xt0nfEng8WiUev2GJphAJlYf4Rmo7hmapt/2zhRJ9SlVkIOHokE5znI4OHEeX/WgJJqEMVtw3B5ky3CnB7FanWZTfwsxZHjZChGfU7B81fCeMWmZqlRv/sRQ1vAyRm8AOzkYBFCRSgd3gwd4VA/q+MTgQ1wYjmtF1k4W4d3zkvbNWd39W11B5lDW920D38OypFXq9p0SCrxNK2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CAoGECnfvi1vEgZoH2yVzhglwIhsWmRwW1CtPNJWcPs=;
 b=LhizQf/H/eH/lRnUTWmtLnuM6gI4TNaoU1jJZKSD3ayq9EuLCq+zxk+wqcv/sudBk8x7vRuVORC1t0YgFQq5OI2dz3pdbxn1j92jdFv9SMCTj1jRfrrf+H9g3rHYHhYu7DPp9G1RAnlEgwjf7A20DvLzmcmUPueuj2TkGfpMl7CKNIp5vrm8gaeIy3Z7SOwkW1PmuxKyNVd73Tk8uwnSn451vF6RvoNJ99Q2Ep2eHidwm/mfNWkmHk/XQATlZ/FzGLh7eQwkIlJfjjiGmKXZlTBEYFQ3gqjl3xyybJvexI+uPFE/5i0fZ4ShHNm/t+2xUnGPzsNeWuKwXfGjz+Leiw==
Received: from BN9PR03CA0952.namprd03.prod.outlook.com (2603:10b6:408:108::27)
 by MN2PR12MB3391.namprd12.prod.outlook.com (2603:10b6:208:c3::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Fri, 17 Sep
 2021 15:36:41 +0000
Received: from BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::88) by BN9PR03CA0952.outlook.office365.com
 (2603:10b6:408:108::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Fri, 17 Sep 2021 15:36:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 BN8NAM11FT008.mail.protection.outlook.com (10.13.177.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 15:36:41 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 17 Sep
 2021 15:36:40 +0000
Received: from [10.26.49.12] (172.20.187.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 17 Sep
 2021 15:36:37 +0000
Subject: Re: [PATCH v6 2/4] dmaengine: tegra: Add tegra gpcdma driver
To:     Akhil R <akhilrajeev@nvidia.com>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <kyarlagadda@nvidia.com>, <ldewangan@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <p.zabel@pengutronix.de>, <rgumasta@nvidia.com>,
        <thierry.reding@gmail.com>, <vkoul@kernel.org>,
        Pavan Kunapuli <pkunapuli@nvidia.com>
References: <1631887887-18967-1-git-send-email-akhilrajeev@nvidia.com>
 <1631887887-18967-3-git-send-email-akhilrajeev@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <fe8b4d60-0051-a11a-50e5-c188a9e9b346@nvidia.com>
Date:   Fri, 17 Sep 2021 16:36:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1631887887-18967-3-git-send-email-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee64a089-a0ff-4f12-5dc7-08d979f0f23c
X-MS-TrafficTypeDiagnostic: MN2PR12MB3391:
X-Microsoft-Antispam-PRVS: <MN2PR12MB33913712A3B25BB1586945EAD9DD9@MN2PR12MB3391.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: boLJDA8Ofd5+LvithNIRGkaA1ye/vkUDO0OM198fGzcBWz2lH7kht2+HtZrkdpiejpLkBGE7UMxVpU8/bpuUXmEBwdE2NjjsCobW6RJ8UYN1nHDrvFaCA4HwCAwW8A9fPzbaH5IIXVK9BaMQBPvj0Cp03PX7Gvy5UXlKqs/MYqdeqtnOXzHrS5RW3zI4fFDaxQWSSR4P7Tfe56buqj318NJ+4A7ijghg0PmceDKF/jVDuUNyhLg06tNWyj4stpOMpVPQMRdh4xa1vq+BJHEWSWl3doazV9pnfpxBYm8c7ik2k+JdDpLrnUoL2rVuLcGJ/k0v/clIpjngifdRg1HW6CkhQIuBZDnNV++A5OzqEMmXJgBygl4M1e36X4qkD5kmh/VPADMFFq8/ez18q+leVnlimHYWvzifhO2qaAIvXyEmfIc61Ko9fSmKNoUFPKVF5MMPOupIH4MQQBwNhhj33HfQ9hiTT7TjgqcReREejH1gN5nowAhaIUZoabcopbtj9BUqwG7PHLLkB0Jcph01FqtNS4oXuxg0AN2ZKVMxSjVx615iQgYMksWmE1D4k76/BQXHG6rIWPcMPoE/Kp8ZEk4OVG6lkheNoaRKj3zOtuY/U7F9Qf1169i9SkaxbNkpJDoALrtWrBSM0IgQZUdtEQGow0p7CkHJUHYJYRRDRGrsuhAbK6M4xhKCxSooH9xR1YjU0aKX8LYJ1vjdNcBv7JvQTHCtJsSzaLe8gFEEGVY=
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid04.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(346002)(136003)(36840700001)(46966006)(47076005)(8936002)(70586007)(70206006)(4326008)(16526019)(478600001)(82740400003)(107886003)(356005)(31696002)(26005)(6862004)(82310400003)(54906003)(186003)(426003)(2616005)(8676002)(2906002)(7636003)(336012)(36756003)(37006003)(5660300002)(16576012)(53546011)(86362001)(36860700001)(31686004)(316002)(6636002)(36906005)(30864003)(83380400001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 15:36:41.1231
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee64a089-a0ff-4f12-5dc7-08d979f0f23c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3391
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 17/09/2021 15:11, Akhil R wrote:
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
>   drivers/dma/tegra186-gpc-dma.c | 1375 ++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 1388 insertions(+)
>   create mode 100644 drivers/dma/tegra186-gpc-dma.c

...

> +static int tegra_dma_slave_config(struct dma_chan *dc,
> +				  struct dma_slave_config *sconfig)
> +{
> +	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
> +
> +	if (tdc->dma_desc) {
> +		dev_err(tdc2dev(tdc), "Configuration not allowed\n");
> +		return -EBUSY;
> +	}
> +
> +	memcpy(&tdc->dma_sconfig, sconfig, sizeof(*sconfig));
> +	if (tdc->slave_id == -1)
> +		tdc->slave_id = sconfig->slave_id;
> +
> +	tdc->config_init = true;
> +	return 0;
> +}

So you have a function to reserve a slave ID, but you don't check here 
if it is already reserved.

> +
> +static int tegra_dma_pause(struct tegra_dma_channel *tdc)
> +{
> +	u32 val;
> +	int ret;
> +
> +	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSRE, TEGRA_GPCDMA_CHAN_CSRE_PAUSE);
> +
> +	/* Wait until busy bit is de-asserted */
> +	ret = readl_relaxed_poll_timeout_atomic(tdc->tdma->base_addr +
> +			tdc->chan_base_offset + TEGRA_GPCDMA_CHAN_STATUS,
> +			val,
> +			!(val & TEGRA_GPCDMA_STATUS_BUSY),
> +			TEGRA_GPCDMA_BURST_COMPLETE_TIME,
> +			TEGRA_GPCDMA_BURST_COMPLETION_TIMEOUT);
> +
> +	if (ret)
> +		dev_err(tdc2dev(tdc), "DMA pause timed out\n");
> +
> +	return ret;
> +}
> +
> +static void tegra_dma_stop(struct tegra_dma_channel *tdc)
> +{
> +	u32 csr, status;
> +
> +	csr = tdc_read(tdc, TEGRA_GPCDMA_CHAN_CSR);
> +
> +	/* Disable interrupts */
> +	csr &= ~TEGRA_GPCDMA_CSR_IE_EOC;
> +
> +	/* Disable DMA */
> +	csr &= ~TEGRA_GPCDMA_CSR_ENB;
> +	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSR, csr);
> +
> +	/* Clear interrupt status if it is there */
> +	status = tdc_read(tdc, TEGRA_GPCDMA_CHAN_STATUS);
> +	if (status & TEGRA_GPCDMA_STATUS_ISE_EOC) {
> +		dev_dbg(tdc2dev(tdc), "%s():clearing interrupt\n", __func__);
> +		tdc_write(tdc, TEGRA_GPCDMA_CHAN_STATUS, status);
> +	}
> +	tdc->busy = false;
> +}
> +
> +static void tegra_dma_start(struct tegra_dma_channel *tdc)
> +{
> +	struct tegra_dma_channel_regs *ch_regs;
> +	struct virt_dma_desc *vdesc;
> +
> +	if (tdc->busy)
> +		return;
> +
> +	vdesc = vchan_next_desc(&tdc->vc);
> +	if (!vdesc)
> +		return;
> +
> +	tdc->dma_desc = vd_to_tegra_dma_desc(vdesc);
> +	if (!tdc->dma_desc)
> +		return;
> +
> +	list_del(&vdesc->node);
> +
> +	tdc->dma_desc->tdc = tdc;
> +	ch_regs = &tdc->dma_desc->ch_regs;
> +
> +	tdc_write(tdc, TEGRA_GPCDMA_CHAN_WCOUNT, ch_regs->wcount);
> +
> +	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSR, 0);
> +	tdc_write(tdc, TEGRA_GPCDMA_CHAN_SRC_PTR, ch_regs->src_ptr);
> +	tdc_write(tdc, TEGRA_GPCDMA_CHAN_DST_PTR, ch_regs->dst_ptr);
> +	tdc_write(tdc, TEGRA_GPCDMA_CHAN_HIGH_ADDR_PTR, ch_regs->high_addr_ptr);
> +	tdc_write(tdc, TEGRA_GPCDMA_CHAN_FIXED_PATTERN, ch_regs->fixed_pattern);
> +	tdc_write(tdc, TEGRA_GPCDMA_CHAN_MMIOSEQ, ch_regs->mmio_seq);
> +	tdc_write(tdc, TEGRA_GPCDMA_CHAN_MCSEQ, ch_regs->mc_seq);
> +	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSRE, 0);
> +	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSR, ch_regs->csr);
> +
> +	/* Start DMA */
> +	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSR,
> +		  ch_regs->csr | TEGRA_GPCDMA_CSR_ENB);
> +
> +	tdc->busy = true;
> +}
> +
> +static void tegra_dma_sid_free(struct tegra_dma_channel *tdc)
> +{
> +	struct tegra_dma *tdma = tdc->tdma;
> +	unsigned int sid = tdc->slave_id;
> +
> +	switch (tdc->sid_dir) {
> +	case DMA_MEM_TO_DEV:
> +		clear_bit(sid,  &tdma->sid_m2d_reserved);
> +		break;
> +	case DMA_DEV_TO_MEM:
> +		clear_bit(sid,  &tdma->sid_d2m_reserved);
> +		break;
> +	case DMA_MEM_TO_MEM:
> +		clear_bit(sid,  &tdma->sid_m2m_reserved);
> +		break;
> +	}
> +
> +	tdc->sid_reserved = false;
> +	tdc->sid_dir = DMA_TRANS_NONE;
> +}

I would keep the tegra_dma_reserve_sid() and tegra_dma_sid_free() 
together. I would also be consistent in the naming and have 
tegra_dma_sid_reserve/free().

> +static void tegra_dma_abort_all(struct tegra_dma_channel *tdc)
> +{
> +	tegra_dma_sid_free(tdc);
> +	kfree(tdc->dma_desc);
> +}
> +
> +static void tegra_dma_isr_callback(struct tegra_dma_channel *tdc,
> +				   bool to_terminate)

Is it more appropriate to call this tegra_dma_xfer_complete() or 
something because this is also called from the terminate function?

> +{
> +	struct tegra_dma_desc *dma_desc;
> +
> +	tdc->busy = false;
> +	dma_desc = tdc->dma_desc;
> +	dma_desc->bytes_transferred += dma_desc->bytes_requested;
> +
> +	vchan_cookie_complete(&tdc->dma_desc->vd);
> +
> +	if (to_terminate)
> +		return;
> +
> +	tegra_dma_start(tdc);

I would be tempted to move this out of this function and call this in 
the ISR then you can remove the 'to_terminate' variable.

> +}
> +
> +static void tegra_dma_chan_decode_error(struct tegra_dma_channel *tdc,
> +					unsigned int err_status)
> +{
> +	switch (TEGRA_GPCDMA_CHAN_ERR_TYPE(err_status)) {
> +	case TEGRA_DMA_BM_FIFO_FULL_ERR:
> +		dev_err(tdc->tdma->dev,
> +			"GPCDMA CH%d bm fifo full\n", tdc->id);
> +		break;
> +
> +	case TEGRA_DMA_PERIPH_FIFO_FULL_ERR:
> +		dev_err(tdc->tdma->dev,
> +			"GPCDMA CH%d peripheral fifo full\n", tdc->id);
> +		break;
> +
> +	case TEGRA_DMA_PERIPH_ID_ERR:
> +		dev_err(tdc->tdma->dev,
> +			"GPCDMA CH%d illegal peripheral id\n", tdc->id);
> +		break;
> +
> +	case TEGRA_DMA_STREAM_ID_ERR:
> +		dev_err(tdc->tdma->dev,
> +			"GPCDMA CH%d illegal stream id\n", tdc->id);
> +		break;
> +
> +	case TEGRA_DMA_MC_SLAVE_ERR:
> +		dev_err(tdc->tdma->dev,
> +			"GPCDMA CH%d mc slave error\n", tdc->id);
> +		break;
> +
> +	case TEGRA_DMA_MMIO_SLAVE_ERR:
> +		dev_err(tdc->tdma->dev,
> +			"GPCDMA CH%d mmio slave error\n", tdc->id);
> +		break;
> +
> +	default:
> +		dev_err(tdc->tdma->dev,
> +			"GPCDMA CH%d security violation %x\n", tdc->id,
> +			err_status);
> +	}
> +}
> +
> +static irqreturn_t tegra_dma_isr(int irq, void *dev_id)
> +{
> +	struct tegra_dma_channel *tdc = dev_id;
> +	irqreturn_t ret = IRQ_NONE;
> +	unsigned int err_status;
> +	unsigned long status;

err_status is an unsigned int and status is an unsigned long. tdc_read() 
returns a u32 and so shouldn't these be u32? Do we need two variables?

> +
> +	raw_spin_lock(&tdc->lock);
> +
> +	status = tdc_read(tdc, TEGRA_GPCDMA_CHAN_STATUS);
> +	err_status = tdc_read(tdc, TEGRA_GPCDMA_CHAN_ERR_STATUS);
> +
> +	if (err_status) {
> +		tegra_dma_chan_decode_error(tdc, err_status);
> +		tegra_dma_dump_chan_regs(tdc);
> +		tdc_write(tdc, TEGRA_GPCDMA_CHAN_ERR_STATUS, 0xFFFFFFFF);
> +	}
> +
> +	if (status & TEGRA_GPCDMA_STATUS_ISE_EOC) {
> +		tdc_write(tdc, TEGRA_GPCDMA_CHAN_STATUS,
> +			  TEGRA_GPCDMA_STATUS_ISE_EOC);
> +		tegra_dma_isr_callback(tdc, false);
> +
> +		ret = IRQ_HANDLED;
> +	}
> +
> +	raw_spin_unlock(&tdc->lock);
> +	return ret;
> +}
> +
> +static void tegra_dma_issue_pending(struct dma_chan *dc)
> +{
> +	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
> +	unsigned long flags;
> +
> +	raw_spin_lock_irqsave(&tdc->lock, flags);
> +
> +	if (!tdc->busy)
> +		if (vchan_issue_pending(&tdc->vc))
> +			tegra_dma_start(tdc);
> +
> +	raw_spin_unlock_irqrestore(&tdc->lock, flags);
> +}
> +
> +static void tegra_dma_reset_client(struct tegra_dma_channel *tdc)
> +{
> +	u32 csr = tdc_read(tdc, TEGRA_GPCDMA_CHAN_CSR);
> +
> +	csr &= ~(TEGRA_GPCDMA_CSR_REQ_SEL_MASK);
> +	csr |= TEGRA_GPCDMA_CSR_REQ_SEL_UNUSED;
> +	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSR, csr);
> +}
> +
> +static void tegra_dma_stop_client(struct tegra_dma_channel *tdc)

Why not return the error code from this function?

> +{
> +	int ret;
> +	unsigned long status;
> +
> +	/* Before Reading DMA status to figure out number
> +	 * of bytes transferred by DMA channel:
> +	 * Change the client associated with the DMA channel
> +	 * to stop DMA engine from starting any more bursts for
> +	 * the given client and wait for in flight bursts to complete
> +	 */
> +	tegra_dma_reset_client(tdc);
> +
> +	/* Wait for in flight data transfer to finish */
> +	udelay(TEGRA_GPCDMA_BURST_COMPLETE_TIME);
> +
> +	/* If TX/RX path is still active wait till it becomes
> +	 * inactive
> +	 */
> +
> +	ret = readl_relaxed_poll_timeout_atomic(tdc->tdma->base_addr +
> +				tdc->chan_base_offset +
> +				TEGRA_GPCDMA_CHAN_STATUS,
> +				status,
> +				!(status & (TEGRA_GPCDMA_STATUS_CHANNEL_TX |
> +				TEGRA_GPCDMA_STATUS_CHANNEL_RX)),
> +				5,
> +				TEGRA_GPCDMA_BURST_COMPLETION_TIMEOUT);
> +	if (ret) {
> +		dev_err(tdc2dev(tdc), "Timeout waiting for DMA burst completion!\n");
> +		tegra_dma_dump_chan_regs(tdc);
> +	}
> +}
> +
> +static int tegra_dma_terminate_all(struct dma_chan *dc)
> +{
> +	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
> +	unsigned long wcount = 0;
> +	unsigned long status;
> +	unsigned long flags;
> +	bool was_busy;
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
> +	if (tdc->tdma->chip_data->hw_support_pause) {
> +		err = tegra_dma_pause(tdc);
> +		if (err) {
> +			raw_spin_unlock_irqrestore(&tdc->lock, flags);
> +			return err;
> +		}
> +	} else {
> +		tegra_dma_stop_client(tdc);
> +	}
> +
> +	status = tdc_read(tdc, TEGRA_GPCDMA_CHAN_STATUS);
> +	wcount = tdc_read(tdc, TEGRA_GPCDMA_CHAN_XFER_COUNT);
> +	if (status & TEGRA_GPCDMA_STATUS_ISE_EOC) {
> +		dev_dbg(tdc2dev(tdc), "%s():handling isr\n", __func__);
> +		tegra_dma_isr_callback(tdc, true);
> +		status = tdc_read(tdc, TEGRA_GPCDMA_CHAN_STATUS);
> +		wcount = tdc_read(tdc, TEGRA_GPCDMA_CHAN_XFER_COUNT);

Is it necessary to read the XFER_COUNT twice?

> +	}
> +
> +	was_busy = tdc->busy;

Isn't this always true? Otherwise we go to skip_dma_stop?

> +
> +	tegra_dma_stop(tdc);
> +	if (tdc->dma_desc && was_busy)
> +		tdc->dma_desc->bytes_transferred +=
> +			tdc->dma_desc->bytes_requested - (wcount * 4);
> +
> +skip_dma_stop:
> +	tegra_dma_abort_all(tdc);

Do we need this function tegra_dma_abort_all()? I would inline the code.

> +	vchan_free_chan_resources(&tdc->vc);
> +
> +	raw_spin_unlock_irqrestore(&tdc->lock, flags);
> +	return 0;
> +}
> +
> +static enum dma_status tegra_dma_tx_status(struct dma_chan *dc,
> +					   dma_cookie_t cookie,
> +					   struct dma_tx_state *txstate)
> +{
> +	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
> +	struct tegra_dma_desc *dma_desc = NULL;
> +	struct virt_dma_desc *vd;
> +	unsigned int residual;
> +	enum dma_status ret;
> +	unsigned long flags;
> +
> +	raw_spin_lock_irqsave(&tdc->lock, flags);
> +
> +	ret = dma_cookie_status(dc, cookie, txstate);
> +	if (ret == DMA_COMPLETE) {
> +		raw_spin_unlock_irqrestore(&tdc->lock, flags);
> +		return ret;
> +	}
> +
> +	vd = vchan_find_desc(&tdc->vc, cookie);
> +	if (vd)
> +		dma_desc = vd_to_tegra_dma_desc(vd);
> +
> +	if (dma_desc) {
> +		residual =  dma_desc->bytes_requested -
> +					(dma_desc->bytes_transferred %
> +					dma_desc->bytes_requested);
> +		dma_set_residue(txstate, residual);
> +		kfree(dma_desc);
> +	} else {
> +		dev_err(tdc2dev(tdc), "cookie %d is not found\n", cookie);

What about the case where the vchan_find_desc() return NULL, but the 
descriptor is in progress? Looking at the above this will be flagged as 
an error. See the tegra210-adma.c driver.

> +	}
> +
> +	raw_spin_unlock_irqrestore(&tdc->lock, flags);
> +	return ret;
> +}
> +
> +static inline int get_bus_width(struct tegra_dma_channel *tdc,
> +				enum dma_slave_buswidth slave_bw)
> +{
> +	switch (slave_bw) {
> +	case DMA_SLAVE_BUSWIDTH_1_BYTE:
> +		return TEGRA_GPCDMA_MMIOSEQ_BUS_WIDTH_8;
> +	case DMA_SLAVE_BUSWIDTH_2_BYTES:
> +		return TEGRA_GPCDMA_MMIOSEQ_BUS_WIDTH_16;
> +	case DMA_SLAVE_BUSWIDTH_4_BYTES:
> +		return TEGRA_GPCDMA_MMIOSEQ_BUS_WIDTH_32;
> +	default:
> +		dev_err(tdc2dev(tdc), "given slave bw is not supported\n");

'bw' usually implies bandwidth. This is bus width and so maybe say 'Bus 
width is not supported'.

> +		return -EINVAL;
> +	}
> +}
> +
> +static inline int get_burst_size_by_len(int len)
> +{
> +	int ret;
> +
> +	switch (len) {
> +	case BIT(0) ... BIT(2):
> +		ret = TEGRA_GPCDMA_MMIOSEQ_BURST_1;
> +		break;
> +	case BIT(3):
> +		ret = TEGRA_GPCDMA_MMIOSEQ_BURST_2;
> +		break;
> +	case BIT(4):
> +		ret = TEGRA_GPCDMA_MMIOSEQ_BURST_4;
> +		break;
> +	case BIT(5):
> +		ret = TEGRA_GPCDMA_MMIOSEQ_BURST_8;
> +		break;
> +	default:
> +		ret = TEGRA_GPCDMA_MMIOSEQ_BURST_16;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static inline int get_burst_size(struct tegra_dma_channel *tdc,
> +				 u32 burst_size,
> +				 enum dma_slave_buswidth slave_bw,
> +				 int len)
> +{
> +	int burst_mmio_width, burst_byte, ret;
> +
> +	/*
> +	 * burst_size from client is in terms of the bus_width.
> +	 * convert that into words.
> +	 */
> +	burst_byte = burst_size * slave_bw;
> +	burst_mmio_width = burst_byte / 4;
> +
> +	switch (burst_mmio_width) {
> +	case 0:
> +		ret = get_burst_size_by_len(len);
> +		break;
> +	case 1:
> +		ret = TEGRA_GPCDMA_MMIOSEQ_BURST_1;
> +		break;
> +	case 2 ... 3:
> +		ret = TEGRA_GPCDMA_MMIOSEQ_BURST_2;
> +		break;
> +	case 4 ... 7:
> +		ret = TEGRA_GPCDMA_MMIOSEQ_BURST_4;
> +		break;
> +	case 8 ... 15:
> +		ret = TEGRA_GPCDMA_MMIOSEQ_BURST_8;
> +		break;
> +	default:
> +		ret = TEGRA_GPCDMA_MMIOSEQ_BURST_16;
> +		break;
> +	}
> +
> +	return ret;
> +}

This seems very complicated. I wonder if there is a way to simplify all 
of this?

> +
> +static int tegra_dma_reserve_sid(struct tegra_dma_channel *tdc,
> +				 enum dma_transfer_direction direction)
> +{
> +	struct tegra_dma *tdma = tdc->tdma;
> +	unsigned int sid = tdc->slave_id;
> +
> +	if (tdc->sid_reserved)
> +		return tdc->sid_dir == direction ? 0 : -EINVAL;

Is this really necessary? The slave ID should be reserved at channel 
allocation time and freed when the channel is freed.
> +
> +	switch (direction) {
> +	case DMA_MEM_TO_DEV:
> +		if (test_and_set_bit(sid, &tdma->sid_m2d_reserved)) {
> +			dev_err(tdma->dev, "slave id already in use\n");
> +			return -EINVAL;
> +		}
> +		break;
> +	case DMA_DEV_TO_MEM:
> +		if (test_and_set_bit(sid, &tdma->sid_d2m_reserved)) {
> +			dev_err(tdma->dev, "slave id already in use\n");
> +			return -EINVAL;
> +		}
> +		break;
> +	case DMA_MEM_TO_MEM:
> +		if (test_and_set_bit(sid, &tdma->sid_m2m_reserved)) {
> +			dev_err(tdma->dev, "slave id already in use\n");
> +			return -EINVAL;
> +		}

Do we need slave IDs for memory to memory transfers? Maybe there are 
cases, but there are probably other cases where we do not need one and 
want the transfer to be performed immediately.

> +		break;
> +	}
> +
> +	tdc->sid_reserved = true;
> +	tdc->sid_dir = direction;
> +
> +	return 0;
> +}
> +
> +static int get_transfer_param(struct tegra_dma_channel *tdc,
> +			      enum dma_transfer_direction direction,
> +				  unsigned long *apb_addr,
> +			      unsigned long *mmio_seq,
> +				  unsigned long *csr,
> +			      unsigned int *burst_size,
> +			      enum dma_slave_buswidth *slave_bw)
> +{
> +	switch (direction) {
> +	case DMA_MEM_TO_DEV:
> +		*apb_addr = tdc->dma_sconfig.dst_addr;
> +		*mmio_seq = get_bus_width(tdc, tdc->dma_sconfig.dst_addr_width);
> +		*burst_size = tdc->dma_sconfig.dst_maxburst;
> +		*slave_bw = tdc->dma_sconfig.dst_addr_width;
> +		*csr = TEGRA_GPCDMA_CSR_DMA_MEM2IO_FC;
> +		return 0;
> +	case DMA_DEV_TO_MEM:
> +		*apb_addr = tdc->dma_sconfig.src_addr;
> +		*mmio_seq = get_bus_width(tdc, tdc->dma_sconfig.src_addr_width);
> +		*burst_size = tdc->dma_sconfig.src_maxburst;
> +		*slave_bw = tdc->dma_sconfig.src_addr_width;
> +		*csr = TEGRA_GPCDMA_CSR_DMA_IO2MEM_FC;
> +		return 0;
> +	case DMA_MEM_TO_MEM:
> +		*burst_size = tdc->dma_sconfig.src_addr_width;
> +		*csr = TEGRA_GPCDMA_CSR_DMA_MEM2MEM;
> +		return 0;
> +	default:
> +		dev_err(tdc2dev(tdc), "Dma direction is not supported\n");

s/Dma/DMA

> +		return -EINVAL;

This return is not needed.

> +	}
> +	return -EINVAL;
> +}
> +
> +static struct dma_async_tx_descriptor *
> +tegra_dma_prep_dma_memset(struct dma_chan *dc, dma_addr_t dest, int value,
> +			  size_t len, unsigned long flags)
> +{
> +	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
> +	struct tegra_dma_desc *dma_desc;
> +	unsigned long csr, mc_seq;
> +
> +	/* Set dma mode to fixed pattern */
> +	csr = TEGRA_GPCDMA_CSR_DMA_FIXED_PAT;
> +	/* Enable once or continuous mode */
> +	csr |= TEGRA_GPCDMA_CSR_ONCE;
> +	/* Enable IRQ mask */
> +	csr |= TEGRA_GPCDMA_CSR_IRQ_MASK;
> +	/* Enable the dma interrupt */
> +	if (flags & DMA_PREP_INTERRUPT)
> +		csr |= TEGRA_GPCDMA_CSR_IE_EOC;
> +	/* Configure default priority weight for the channel */
> +	csr |= FIELD_PREP(TEGRA_GPCDMA_CSR_WEIGHT, 1);
> +
> +	mc_seq =  tdc_read(tdc, TEGRA_GPCDMA_CHAN_MCSEQ);
> +	/* retain stream-id and clean rest */
> +	mc_seq &= TEGRA_GPCDMA_MCSEQ_STREAM_ID0_MASK;
> +
> +	/* Set the address wrapping */
> +	mc_seq |= FIELD_PREP(TEGRA_GPCDMA_MCSEQ_WRAP0,
> +						TEGRA_GPCDMA_MCSEQ_WRAP_NONE);
> +	mc_seq |= FIELD_PREP(TEGRA_GPCDMA_MCSEQ_WRAP1,
> +						TEGRA_GPCDMA_MCSEQ_WRAP_NONE);
> +
> +	/* Program outstanding MC requests */
> +	mc_seq |= FIELD_PREP(TEGRA_GPCDMA_MCSEQ_REQ_COUNT, 1);
> +	/* Set burst size */
> +	mc_seq |= TEGRA_GPCDMA_MCSEQ_BURST_16;
> +
> +	dma_desc = kzalloc(sizeof(*dma_desc), GFP_NOWAIT);
> +	if (!dma_desc)
> +		return NULL;
> +
> +	dma_desc->bytes_requested = 0;
> +	dma_desc->bytes_transferred = 0;
> +
> +	if ((len & 3) || (dest & 3) ||
> +	    len > tdc->tdma->chip_data->max_dma_count) {

Why not check this before allocating the memory? Seems that we should do 
this at the beginning of the function.

> +		dev_err(tdc2dev(tdc),
> +			"Dma length/memory address is not supported\n");

s/Dma/DMA

> +		kfree(dma_desc);
> +		return NULL;
> +	}
> +
> +	dma_desc->bytes_requested += len;
> +	dma_desc->ch_regs.src_ptr = 0;
> +	dma_desc->ch_regs.dst_ptr = dest;
> +	dma_desc->ch_regs.high_addr_ptr =
> +			FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_DST_PTR, (dest >> 32));
> +	dma_desc->ch_regs.fixed_pattern = value;
> +	/* Word count reg takes value as (N +1) words */
> +	dma_desc->ch_regs.wcount = ((len - 4) >> 2);
> +	dma_desc->ch_regs.csr = csr;
> +	dma_desc->ch_regs.mmio_seq = 0;
> +	dma_desc->ch_regs.mc_seq = mc_seq;
> +
> +	tdc->dma_desc = dma_desc;
> +
> +	return vchan_tx_prep(&tdc->vc, &dma_desc->vd, flags);
> +}
> +
> +static struct dma_async_tx_descriptor *
> +tegra_dma_prep_dma_memcpy(struct dma_chan *dc, dma_addr_t dest,
> +			  dma_addr_t src,	size_t len, unsigned long flags)
> +{
> +	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
> +	struct tegra_dma_desc *dma_desc;
> +	unsigned long csr, mc_seq;
> +
> +	/* Set dma mode to memory to memory transfer */
> +	csr = TEGRA_GPCDMA_CSR_DMA_MEM2MEM;
> +	/* Enable once or continuous mode */
> +	csr |= TEGRA_GPCDMA_CSR_ONCE;
> +	/* Enable IRQ mask */
> +	csr |= TEGRA_GPCDMA_CSR_IRQ_MASK;
> +	/* Enable the dma interrupt */
> +	if (flags & DMA_PREP_INTERRUPT)
> +		csr |= TEGRA_GPCDMA_CSR_IE_EOC;
> +	/* Configure default priority weight for the channel */
> +	csr |= FIELD_PREP(TEGRA_GPCDMA_CSR_WEIGHT, 1);
> +
> +	mc_seq =  tdc_read(tdc, TEGRA_GPCDMA_CHAN_MCSEQ);
> +	/* retain stream-id and clean rest */
> +	mc_seq &= (TEGRA_GPCDMA_MCSEQ_STREAM_ID0_MASK) |
> +				(TEGRA_GPCDMA_MCSEQ_STREAM_ID1_MASK);
> +
> +	/* Set the address wrapping */
> +	mc_seq |= FIELD_PREP(TEGRA_GPCDMA_MCSEQ_WRAP0,
> +						TEGRA_GPCDMA_MCSEQ_WRAP_NONE);
> +	mc_seq |= FIELD_PREP(TEGRA_GPCDMA_MCSEQ_WRAP1,
> +						TEGRA_GPCDMA_MCSEQ_WRAP_NONE);
> +
> +	/* Program outstanding MC requests */
> +	mc_seq |= FIELD_PREP(TEGRA_GPCDMA_MCSEQ_REQ_COUNT, 1);
> +	/* Set burst size */
> +	mc_seq |= TEGRA_GPCDMA_MCSEQ_BURST_16;
> +
> +	dma_desc = kzalloc(sizeof(*dma_desc), GFP_NOWAIT);
> +	if (!dma_desc)
> +		return NULL;
> +
> +	dma_desc->bytes_requested = 0;
> +	dma_desc->bytes_transferred = 0;
> +
> +	if ((len & 3) || (src & 3) || (dest & 3) ||
> +	    len > tdc->tdma->chip_data->max_dma_count) {

Same here.

> +		dev_err(tdc2dev(tdc),
> +			"Dma length/memory address is not supported\n");
> +		kfree(dma_desc);
> +		return NULL;
> +	}
> +
> +	dma_desc->bytes_requested += len;
> +	dma_desc->ch_regs.src_ptr = src;
> +	dma_desc->ch_regs.dst_ptr = dest;
> +	dma_desc->ch_regs.high_addr_ptr =
> +		FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_SRC_PTR, (src >> 32));
> +	dma_desc->ch_regs.high_addr_ptr |=
> +		FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_DST_PTR, (dest >> 32));
> +	/* Word count reg takes value as (N +1) words */
> +	dma_desc->ch_regs.wcount = ((len - 4) >> 2);
> +	dma_desc->ch_regs.csr = csr;
> +	dma_desc->ch_regs.mmio_seq = 0;
> +	dma_desc->ch_regs.mc_seq = mc_seq;
> +
> +	return vchan_tx_prep(&tdc->vc, &dma_desc->vd, flags);
> +}
> +
> +static struct dma_async_tx_descriptor *
> +tegra_dma_prep_slave_sg(struct dma_chan *dc, struct scatterlist *sgl,
> +			unsigned int sg_len, enum dma_transfer_direction direction,
> +		unsigned long flags, void *context)
> +{
> +	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
> +	unsigned long csr, mc_seq, apb_ptr = 0, mmio_seq = 0;
> +	enum dma_slave_buswidth slave_bw;
> +	struct tegra_dma_desc *dma_desc;
> +	struct scatterlist *sg;
> +	u32 burst_size;
> +	unsigned int i;
> +	int ret;
> +
> +	if (!tdc->config_init) {
> +		dev_err(tdc2dev(tdc), "dma channel is not configured\n");
> +		return NULL;
> +	}
> +	if (sg_len < 1) {
> +		dev_err(tdc2dev(tdc), "Invalid segment length %d\n", sg_len);
> +		return NULL;
> +	}
> +
> +	ret = tegra_dma_reserve_sid(tdc, direction);
> +	if (ret)
> +		return NULL;
> +
> +	ret = get_transfer_param(tdc, direction, &apb_ptr, &mmio_seq, &csr,
> +				 &burst_size, &slave_bw);
> +	if (ret < 0)
> +		return NULL;
> +
> +	/* Enable once or continuous mode */
> +	csr |= TEGRA_GPCDMA_CSR_ONCE;
> +	/* Program the slave id in requestor select */
> +	csr |= FIELD_PREP(TEGRA_GPCDMA_CSR_REQ_SEL_MASK, tdc->slave_id);
> +	/* Enable IRQ mask */
> +	csr |= TEGRA_GPCDMA_CSR_IRQ_MASK;
> +	/* Configure default priority weight for the channel*/
> +	csr |= FIELD_PREP(TEGRA_GPCDMA_CSR_WEIGHT, 1);
> +
> +	/* Enable the dma interrupt */
> +	if (flags & DMA_PREP_INTERRUPT)
> +		csr |= TEGRA_GPCDMA_CSR_IE_EOC;
> +
> +	mc_seq =  tdc_read(tdc, TEGRA_GPCDMA_CHAN_MCSEQ);
> +	/* retain stream-id and clean rest */
> +	mc_seq &= TEGRA_GPCDMA_MCSEQ_STREAM_ID0_MASK;
> +
> +	/* Set the address wrapping on both MC and MMIO side */
> +
> +	mc_seq |= FIELD_PREP(TEGRA_GPCDMA_MCSEQ_WRAP0,
> +							TEGRA_GPCDMA_MCSEQ_WRAP_NONE);
> +	mc_seq |= FIELD_PREP(TEGRA_GPCDMA_MCSEQ_WRAP1,
> +							TEGRA_GPCDMA_MCSEQ_WRAP_NONE);
> +	mmio_seq |= FIELD_PREP(TEGRA_GPCDMA_MMIOSEQ_WRAP_WORD, 1);
> +
> +	/* Program 2 MC outstanding requests by default. */
> +	mc_seq |= FIELD_PREP(TEGRA_GPCDMA_MCSEQ_REQ_COUNT, 1);
> +
> +	/* Setting MC burst size depending on MMIO burst size */
> +	if (burst_size == 64)
> +		mc_seq |= TEGRA_GPCDMA_MCSEQ_BURST_16;
> +	else
> +		mc_seq |= TEGRA_GPCDMA_MCSEQ_BURST_2;
> +
> +	dma_desc = kzalloc(sizeof(*dma_desc), GFP_NOWAIT);
> +	if (!dma_desc)
> +		return NULL;
> +
> +	dma_desc->bytes_requested = 0;
> +	dma_desc->bytes_transferred = 0;
> +
> +	/* Make transfer requests */
> +	for_each_sg(sgl, sg, sg_len, i) {
> +		u32 len;
> +		dma_addr_t mem;
> +
> +		mem = sg_dma_address(sg);
> +		len = sg_dma_len(sg);
> +
> +		if ((len & 3) || (mem & 3) ||
> +		    len > tdc->tdma->chip_data->max_dma_count) {
> +			dev_err(tdc2dev(tdc),
> +				"Dma length/memory address is not supported\n");
> +			kfree(dma_desc);
> +			return NULL;
> +		}
> +
> +		mmio_seq |= get_burst_size(tdc, burst_size, slave_bw, len);
> +		dma_desc->bytes_requested += len;
> +
> +		if (direction == DMA_MEM_TO_DEV) {
> +			dma_desc->ch_regs.src_ptr = mem;
> +			dma_desc->ch_regs.dst_ptr = apb_ptr;
> +			dma_desc->ch_regs.high_addr_ptr =
> +				FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_SRC_PTR, (mem >> 32));
> +		} else if (direction == DMA_DEV_TO_MEM) {
> +			dma_desc->ch_regs.src_ptr = apb_ptr;
> +			dma_desc->ch_regs.dst_ptr = mem;
> +			dma_desc->ch_regs.high_addr_ptr =
> +				FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_DST_PTR, (mem >> 32));
> +		}
> +
> +		/*
> +		 * Word count register takes input in words. Writing a value
> +		 * of N into word count register means a req of (N+1) words.
> +		 */
> +		dma_desc->ch_regs.wcount = ((len - 4) >> 2);
> +		dma_desc->ch_regs.csr = csr;
> +		dma_desc->ch_regs.mmio_seq = mmio_seq;
> +		dma_desc->ch_regs.mc_seq = mc_seq;
> +		tdc->dma_desc = dma_desc;
> +	}
> +
> +	return vchan_tx_prep(&tdc->vc, &dma_desc->vd, flags);
> +}
> +
> +static int tegra_dma_alloc_chan_resources(struct dma_chan *dc)
> +{
> +	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
> +
> +	dma_cookie_init(&tdc->vc.chan);
> +	tdc->config_init = false;
> +	return 0;
> +}
> +
> +static void tegra_dma_chan_synchronize(struct dma_chan *dc)
> +{
> +	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
> +
> +	vchan_synchronize(&tdc->vc);
> +}
> +
> +static void tegra_dma_free_chan_resources(struct dma_chan *dc)
> +{
> +	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
> +	unsigned long flags;
> +
> +	dev_dbg(tdc2dev(tdc), "Freeing channel %d\n", tdc->id);
> +
> +	if (tdc->busy)

Do you need to check this?

> +		tegra_dma_terminate_all(dc);
> +
> +	tegra_dma_chan_synchronize(dc);
> +
> +	tasklet_kill(&tdc->vc.task);
> +	raw_spin_lock_irqsave(&tdc->lock, flags);
> +	tdc->config_init = false;
> +	tdc->slave_id = -1;
> +	tdc->sid_reserved = false;
> +	tdc->sid_dir = DMA_TRANS_NONE;
> +
> +	raw_spin_unlock_irqrestore(&tdc->lock, flags);
> +}
> +
> +static struct dma_chan *tegra_dma_of_xlate(struct of_phandle_args *dma_spec,
> +					   struct of_dma *ofdma)
> +{
> +	struct tegra_dma *tdma = ofdma->of_dma_data;
> +	struct tegra_dma_channel *tdc;
> +	struct dma_chan *chan;
> +
> +	chan = dma_get_any_slave_channel(&tdma->dma_dev);
> +	if (!chan)
> +		return NULL;
> +
> +	tdc = to_tegra_dma_chan(chan);
> +	tdc->slave_id = dma_spec->args[0];
> +
> +	return chan;
> +}
> +
> +static const struct tegra_dma_chip_data tegra186_dma_chip_data = {
> +	.nr_channels = 31,
> +	.channel_reg_size = SZ_64K,
> +	.max_dma_count = SZ_1G,
> +	.hw_support_pause = false,
> +};
> +
> +static const struct tegra_dma_chip_data tegra194_dma_chip_data = {
> +	.nr_channels = 31,
> +	.channel_reg_size = SZ_64K,
> +	.max_dma_count = SZ_1G,
> +	.hw_support_pause = true,
> +};
> +
> +static const struct of_device_id tegra_dma_of_match[] = {
> +	{
> +		.compatible = "nvidia,tegra186-gpcdma",
> +		.data = &tegra186_dma_chip_data,
> +	}, {
> +		.compatible = "nvidia,tegra194-gpcdma",
> +		.data = &tegra194_dma_chip_data,
> +	}, {
> +	},
> +};
> +MODULE_DEVICE_TABLE(of, tegra_dma_of_match);
> +
> +static int tegra_dma_program_sid(struct tegra_dma_channel *tdc,
> +				 int chan, int stream_id)
> +{
> +	unsigned int reg_val =  tdc_read(tdc, TEGRA_GPCDMA_CHAN_MCSEQ);
> +
> +	reg_val &= ~(TEGRA_GPCDMA_MCSEQ_STREAM_ID0_MASK);
> +	reg_val &= ~(TEGRA_GPCDMA_MCSEQ_STREAM_ID1_MASK);
> +
> +	reg_val |= FIELD_PREP(TEGRA_GPCDMA_MCSEQ_STREAM_ID0_MASK, stream_id);
> +	reg_val |= FIELD_PREP(TEGRA_GPCDMA_MCSEQ_STREAM_ID1_MASK, stream_id);
> +
> +	tdc_write(tdc, TEGRA_GPCDMA_CHAN_MCSEQ, reg_val);
> +	return 0;
> +}
> +
> +static int tegra_dma_probe(struct platform_device *pdev)
> +{
> +	const struct tegra_dma_chip_data *cdata = NULL;
> +	struct iommu_fwspec *iommu_spec;
> +	unsigned int stream_id, i;
> +	struct tegra_dma *tdma;
> +	struct resource	*res;
> +	int ret;
> +
> +	cdata = of_device_get_match_data(&pdev->dev);
> +
> +	tdma = devm_kzalloc(&pdev->dev, sizeof(*tdma) + cdata->nr_channels *
> +			sizeof(struct tegra_dma_channel), GFP_KERNEL);
> +	if (!tdma)
> +		return -ENOMEM;
> +
> +	tdma->dev = &pdev->dev;
> +	tdma->chip_data = cdata;
> +	platform_set_drvdata(pdev, tdma);
> +
> +	tdma->base_addr = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(tdma->base_addr))
> +		return PTR_ERR(tdma->base_addr);
> +
> +	tdma->rst = devm_reset_control_get_exclusive(&pdev->dev, "gpcdma");
> +	if (IS_ERR(tdma->rst)) {
> +		dev_err_probe(&pdev->dev, PTR_ERR(tdma->rst),
> +			      "Missing controller reset\n");
> +		return PTR_ERR(tdma->rst);
> +	}
> +	reset_control_reset(tdma->rst);
> +
> +	tdma->dma_dev.dev = &pdev->dev;
> +
> +	iommu_spec = dev_iommu_fwspec_get(&pdev->dev);
> +	if (!iommu_spec) {
> +		dev_err(&pdev->dev, "Missing iommu stream-id\n");
> +		return -EINVAL;
> +	}
> +	stream_id = iommu_spec->ids[0] & 0xffff;

Is it an error if the ID is greater than 0xffff?

Jon

-- 
nvpublic
