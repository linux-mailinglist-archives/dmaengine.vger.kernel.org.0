Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDD541687B
	for <lists+dmaengine@lfdr.de>; Fri, 24 Sep 2021 01:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235628AbhIWX3D (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 Sep 2021 19:29:03 -0400
Received: from mail-dm3nam07on2076.outbound.protection.outlook.com ([40.107.95.76]:3425
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243400AbhIWX3C (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 23 Sep 2021 19:29:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WLMjiEi3msgJV10LjbPW8kjtTcwJvuqjQE5UME86IeFw+521C/dDOOgaXVVOHGcwEmCbhJEkA19SLGTIZ2Iq7Ymau06mNCuUJ20FPDB5SUIjTfvZ6J3DjPlLg7p+Ov8Fac8bRAfwrsZzT7+nfVKkWJbe9++EDK8GtP3qk3jqYbeJ2iFXxApBDWFEDjsZVkIA5eRvWKK5rbovzZftmOaTPSLKX4dWuntIGXoKm/xHne435JT+NMw7e0OTx1QOLJKLphCwiD5cWSslx9lRJQc7/m5rPKRHPkscZYGCZs7UYsURKnJ+DDXUdfv11Rc/fJLzRT5dhaPHnxdtK/+yMW5fow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=4LlLYbDujPWf4/42kOZGjVXVz1dVcAJHWot6R9nCjEM=;
 b=gjvhdXiUWp0iQGC3MP81FGB11Nc7D+dBTGrC0kO9+tFU2G4uzDBzPHvvjajaaBSgJfIp9e9wrzRmjdhH5B+dFHDwhfwmST/GJlTULN10GJpyjRxiD6fzDFYoTa63wcdjlLWoTVn48NVi2S7YfxpVS2lvN2F+ckMuuEWw7tPLwPTSd0Woov+/FAV7Dg/7JW6B1TkwnA0i+DAShYAuOMSNwvlx7eNTjsUoQ5AaqQgu8ZGquB/8pO833ilt/2qPil77DSo+7/we8QPmQvt9WmLjdX+J86tYYEeMZ/V9ZOMx5Q6l/8Rt1Fldsu/kYXfBGYXNr3+qx8d3x3ptusTGk5Q+ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4LlLYbDujPWf4/42kOZGjVXVz1dVcAJHWot6R9nCjEM=;
 b=sFg+871bkEX8ngXBsjLEG2RREDBC/zX0rGZtM2NFjiMdW/H1pIDXU0ZjXsJs+DmkkRu68/HZZmkcXWJbEmgwA43q+zL0GJzmoyHxhIIVPleW7FFwIoznboG9cDsx4MN0Kph3fZkj2D0pUlMdufzGiwJi5l6307RSCeAIjOvZanmSdUz5eCyMrPIWFjjeF7cfGzTm83vsUgqfWZUSJeKWZI0gb4k85i0C2FhMgFIZh/YbPKdJeoYT2mh+WWTd5EBnKfw1CtCs8ucR4E5udq+953DXDT/zc9QgKQ/bEhJBRuICvwNur6hB/XESGoIuhYmAA7ldshVFyWoB+W8/b/nDUg==
Received: from BN0PR04CA0003.namprd04.prod.outlook.com (2603:10b6:408:ee::8)
 by BY5PR12MB4324.namprd12.prod.outlook.com (2603:10b6:a03:209::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Thu, 23 Sep
 2021 23:27:28 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::f9) by BN0PR04CA0003.outlook.office365.com
 (2603:10b6:408:ee::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend
 Transport; Thu, 23 Sep 2021 23:27:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4544.13 via Frontend Transport; Thu, 23 Sep 2021 23:27:28 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 23 Sep
 2021 23:27:27 +0000
Received: from [10.26.49.14] (172.20.187.6) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 23 Sep
 2021 23:27:24 +0000
Subject: Re: [PATCH v7 2/4] dmaengine: tegra: Add tegra gpcdma driver
To:     Akhil R <akhilrajeev@nvidia.com>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <kyarlagadda@nvidia.com>, <ldewangan@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <p.zabel@pengutronix.de>, <rgumasta@nvidia.com>,
        <thierry.reding@gmail.com>, <vkoul@kernel.org>,
        Pavan Kunapuli <pkunapuli@nvidia.com>
References: <1631887887-18967-1-git-send-email-akhilrajeev@nvidia.com>
 <1632383484-23487-1-git-send-email-akhilrajeev@nvidia.com>
 <1632383484-23487-3-git-send-email-akhilrajeev@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <f166f8f2-8106-c229-8b2d-f97c484dbdde@nvidia.com>
Date:   Fri, 24 Sep 2021 00:27:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1632383484-23487-3-git-send-email-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db136c2e-b466-4067-0f70-08d97ee9b583
X-MS-TrafficTypeDiagnostic: BY5PR12MB4324:
X-Microsoft-Antispam-PRVS: <BY5PR12MB432487A142CA1FF1FF2D9F7AD9A39@BY5PR12MB4324.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rBjRH62EF43upQu/uokc12m4ngm89pdkhv11Wlby5p4LY0OZmV4Ot2B93oMmjrn1oqGpefIed5Z1OTfhWLii3HZxhOXCUc1HJLDSXhHrW4m+qpAfnBbraQLOzizeLDTptvk8h9gI3syn4rZeEVp/fldBHhx5bj/g/vNcvD4y4nl5jO0cFhBlyPH8s3CWeov+SUsdJUsscBe6cfZ6j6wWQ0yVMCImV4PbLBgtXkHHnBwkHyfJsaPd4hqddz2V2Hj++ABlw5ESkhIrytS7aAci2jBqbcl6wW+Nqjl+JS7Hhb0p58lmm9mW5QqguQ1YDL/8UiU/MXexEoMOJh0l9dHFXnLzKACcN/PFdR3W2uVUQnmk6cGZBEq1JFzjB+ZZOOMfunK4IK82ixCV5SHOCiEHGdwmGL1zdvzYkkmkewL34eAlFIcIoBW+Du8xt4HsUBk5FMaxDR1qsiH42elnKrheVMpsm9o90e/WU6a/68ozFuIYaSD+2eAh079VRk2uP4gCwDtGUBusdPe71L38D7Pt3Wsz4sz5bZ8xCRIq4NRR3V5smeTTPcY8i4VJhRLkHpip+fNqMsF24h29lDdsbYyWpQWtAjLdUfCUsQ2TgR13+W7j9LZa8WCGrvWm5/SkXCv6mgcXBETwRxIi8MdLr0sL3EjVRnl6PHDU6RP7hwR8rbZcfqwKrUe9VWIQoMDkcbNSF9MFvyMsrmcQ2S+htNm2dt8FCGTxavfqmzecpJIxoGw=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(36756003)(107886003)(70586007)(53546011)(37006003)(316002)(16576012)(31696002)(356005)(336012)(83380400001)(36860700001)(82310400003)(426003)(47076005)(70206006)(6636002)(7636003)(31686004)(16526019)(186003)(508600001)(2616005)(86362001)(4326008)(8676002)(5660300002)(36906005)(8936002)(6862004)(54906003)(26005)(2906002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 23:27:28.5821
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db136c2e-b466-4067-0f70-08d97ee9b583
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4324
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 23/09/2021 08:51, Akhil R wrote:
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
>   drivers/dma/tegra186-gpc-dma.c | 1354 ++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 1367 insertions(+)
>   create mode 100644 drivers/dma/tegra186-gpc-dma.c

...

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

This first case implies that the transfer has not started yet and so the 
residual is just dma_desc->bytes_requested.

> +	else if (tdc->dma_desc && tdc->dma_desc->vd.tx.cookie == cookie)
> +		dma_desc = tdc->dma_desc;
> +
> +	if (dma_desc) {
> +		residual =  dma_desc->bytes_requested -
> +					(dma_desc->bytes_transferred %
> +					dma_desc->bytes_requested);
> +		dma_set_residue(txstate, residual);
> +	} else {
> +		dev_err(tdc2dev(tdc), "cookie %d is not found\n", cookie);
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
> +		dev_err(tdc2dev(tdc), "given slave bus width is not supported\n");
> +		return -EINVAL;
> +	}
> +}
> +
> +static inline int get_burst_size_by_len(int len)
> +{
> +	int ret;
> +
> +	/* Get burst size based on the first set bit */
> +	switch (ffs(len)) {
> +	case 0:
> +	case 1:
> +	case 2:
> +		ret = TEGRA_GPCDMA_MMIOSEQ_BURST_1;
> +		break;
> +	case 3:
> +		ret = TEGRA_GPCDMA_MMIOSEQ_BURST_2;
> +		break;
> +	case 4:
> +		ret = TEGRA_GPCDMA_MMIOSEQ_BURST_4;
> +		break;
> +	case 5:
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
> +	burst_mmio_width = ffs(burst_byte / 4);
> +
> +	/* Get burst size based on the first set bit */
> +	switch (burst_mmio_width) {
> +	case 0:
> +		ret = get_burst_size_by_len(len);
> +		break;
> +	case 1:
> +		ret = TEGRA_GPCDMA_MMIOSEQ_BURST_1;
> +		break;
> +	case 2:
> +		ret = TEGRA_GPCDMA_MMIOSEQ_BURST_2;
> +		break;
> +	case 3:
> +		ret = TEGRA_GPCDMA_MMIOSEQ_BURST_4;
> +		break;
> +	case 4:
> +		ret = TEGRA_GPCDMA_MMIOSEQ_BURST_8;
> +		break;
> +	default:
> +		ret = TEGRA_GPCDMA_MMIOSEQ_BURST_16;
> +		break;
> +	}
> +
> +	return ret;
> +}

Something seems a bit odd here in the sense that if burst_mmio_width == 
0, we could still end up with a burst of 16? I am not sure I understand 
this logic.

Jon

-- 
nvpublic
