Return-Path: <dmaengine+bounces-5762-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB787B021DD
	for <lists+dmaengine@lfdr.de>; Fri, 11 Jul 2025 18:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 969E2189EF12
	for <lists+dmaengine@lfdr.de>; Fri, 11 Jul 2025 16:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE4C2EE999;
	Fri, 11 Jul 2025 16:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Y7aPz3Jf"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1251754B;
	Fri, 11 Jul 2025 16:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752251605; cv=none; b=GSTTSOKpTZ/u1pny0Ar3VYrUpc8wZNmpGd9JgJzzE6wR2glS6ykFyFIXVAEcPtRVdPHGkG6tzL7ne9vzXH/5/Z/7JQ4vyMFOhg12tyAAUj/r3xdMG+L1izxnFhTBJMdMFhnW66WiVfmOPvUXWuUUfmjcudySd0sgX8bO4n2TMtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752251605; c=relaxed/simple;
	bh=XG5abc7CS7VnytVJH/HvUNby7/R7oK4gnS5cLchs1ZU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dF/ZlnuDNMBphQ5XU1DqOdI/sia1E3P7GIyUpNpl6nP9wuwvrUqggCQJdTC9GsbYpDsPNxRaEtJEdFi4c+jEe6S+NKAUfO0FTCAeceoqy0tKdbMNUp4gYN8CLL3pvlk9d4Eq8DTzgTI3+XCrV/ITAO6yb6YOF9bNvwKHSsPHpPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Y7aPz3Jf; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BDJKNc014448;
	Fri, 11 Jul 2025 09:33:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=weVSx5nTAJzS7WG1pVy4uy+Fj
	quA7iSMq3ImIuaswwk=; b=Y7aPz3JfLG9hdUHXvRWBTSvjO0ixe3zfq4U3BKt96
	FEqnW0ekdmexEwF0Pxbdk30sqeYeWCuPCGTiCYkv69dgeUpxIk90hAnEJG2jgdxR
	NFWGEdICcucPAVluv9pne36OrzXzxoBExCZBL0pUDRZj0HA5JEso6i3TvhElHYpL
	8VX21LTLXCE3aBCIty9EdTFa2c9pVgE6hYOrxTYJpJMXKP0qXYJROUz5/yjFhQlL
	SUc12CSFUIcsRDbfhuoUVR8bn7OQD6cabvfvBRtw461W5W8V+4fruc+28gIO1THA
	rvPT2gaGcPMpDfNYa23J8C3zh5+lgYn98idtwLh4OnRAQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47u3d2rcva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Jul 2025 09:33:10 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 11 Jul 2025 09:33:07 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 11 Jul 2025 09:33:07 -0700
Received: from ff87d1e86a04 (unknown [10.193.79.61])
	by maili.marvell.com (Postfix) with SMTP id EBA6A3F7043;
	Fri, 11 Jul 2025 09:33:04 -0700 (PDT)
Date: Fri, 11 Jul 2025 16:33:03 +0000
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Suraj Gupta <suraj.gupta2@amd.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <michal.simek@amd.com>, <vkoul@kernel.org>,
        <radhey.shyam.pandey@amd.com>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <harini.katakam@amd.com>
Subject: Re: [PATCH V2 4/4] net: xilinx: axienet: Add ethtool support to
 configure/report irq coalescing parameters in DMAengine flow
Message-ID: <aHE8v3Q6sIcczbhk@ff87d1e86a04>
References: <20250710101229.804183-1-suraj.gupta2@amd.com>
 <20250710101229.804183-5-suraj.gupta2@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250710101229.804183-5-suraj.gupta2@amd.com>
X-Authority-Analysis: v=2.4 cv=IOsCChvG c=1 sm=1 tr=0 ts=68713cc6 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=zd2uoN0lAAAA:8 a=h5FfL-nQyzRpBboDPhAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: InQXqwIkokwSiAMgvfhgn7dowwjQmtxY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDEyMCBTYWx0ZWRfX/MBWRrFeqXla hxfZRzZuzYhlwTTVmrEzUt3toe/KXKVYLfRSBz1PQbS4vmgTTegu9ldaQd2xU3ZylPdTHO0RbqS HfU4YiHDzKLUwEZMlQ7ZAxJ3hZWPXtGAMWAgxvkT59t3m/32soaEUgCQew3VHCxn5tyMAbhbun3
 sUvf3TVfA17GLOzAdmd9VJpz3aXVKo8edCkpBf7oAqusk+45r696KjDMQ4uS3SmISObWHBp2KQE CrbvXwxr/mUkeEm2vhNjnB8e85fbkfF5KYunlIwQsPUCmbYFef+sZjP9qCxB/yiSJeCtKUMT3tD o8UiDH3mASrdSXEDiXvrh/hOA3eFmkuXgvohIpkFViT5MW1sOZtK5wUnipv8yh9hxfqsiet8rVv
 Ra+MIHFR6Zx1/z51Chg0Dbiq7eqOXGMgANjTPKBTccENUvX7EijlgbMbwn0Wm4PsmYFSKNQW
X-Proofpoint-ORIG-GUID: InQXqwIkokwSiAMgvfhgn7dowwjQmtxY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_04,2025-07-09_01,2025-03-28_01

On 2025-07-10 at 10:12:29, Suraj Gupta (suraj.gupta2@amd.com) wrote:
> Add support to configure and report interrupt coalesce count and delay
> via ethtool in DMAEngine flow.
> Enable Tx and Rx adaptive irq coalescing with DIM to allow runtime
> configuration of coalesce count based on load. CQE profiles same as
> legacy (non-dmaengine) flow are used.
> Increase Rx skb ring size from 128 as maximum coalesce packets are 255.
> 
> Netperf numbers and CPU usage after DIM:
> TCP Tx:	885 Mb/s, 27.02%
> TCP Rx:	640 Mb/s, 27.73%
> UDP Tx: 857 Mb/s, 25.00%
> UDP Rx:	730 Mb/s, 23.94%
> 
> Above numbers are observed with 4x Cortex-a53.
> 
> Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
> ---
>  drivers/net/ethernet/xilinx/xilinx_axienet.h  |  13 +-
>  .../net/ethernet/xilinx/xilinx_axienet_main.c | 190 +++++++++++++++++-
>  2 files changed, 190 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
> index 5ff742103beb..747efde9a05f 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
> @@ -126,6 +126,9 @@
>  #define XAXIDMA_DFT_TX_USEC		50
>  #define XAXIDMA_DFT_RX_USEC		16
>  
> +/* Default TX delay timer value for SGDMA mode with DMAEngine */
> +#define XAXIDMAENGINE_DFT_TX_USEC	16
> +
>  #define XAXIDMA_BD_CTRL_TXSOF_MASK	0x08000000 /* First tx packet */
>  #define XAXIDMA_BD_CTRL_TXEOF_MASK	0x04000000 /* Last tx packet */
>  #define XAXIDMA_BD_CTRL_ALL_MASK	0x0C000000 /* All control bits */
> @@ -485,8 +488,11 @@ struct skbuf_dma_descriptor {
>   * @dma_regs:	Base address for the axidma device address space
>   * @napi_rx:	NAPI RX control structure
>   * @rx_dim:     DIM state for the receive queue
> - * @rx_dim_enabled: Whether DIM is enabled or not
> - * @rx_irqs:    Number of interrupts
> + * @tx_dim:     DIM state for the transmit queue
> + * @rx_dim_enabled: Whether Rx DIM is enabled or not
> + * @tx_dim_enabled: Whether Tx DIM is enabled or not
> + * @rx_irqs:    Number of Rx interrupts
> + * @tx_irqs:    Number of Tx interrupts
>   * @rx_cr_lock: Lock protecting @rx_dma_cr, its register, and @rx_dma_started
>   * @rx_dma_cr:  Nominal content of RX DMA control register
>   * @rx_dma_started: Set when RX DMA is started
> @@ -570,8 +576,11 @@ struct axienet_local {
>  
>  	struct napi_struct napi_rx;
>  	struct dim rx_dim;
> +	struct dim tx_dim;
>  	bool rx_dim_enabled;
> +	bool tx_dim_enabled;
>  	u16 rx_irqs;
> +	u16 tx_irqs;
>  	spinlock_t rx_cr_lock;
>  	u32 rx_dma_cr;
>  	bool rx_dma_started;
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index 6011d7eae0c7..2c7cc092fbe8 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -54,7 +54,7 @@
>  #define RX_BD_NUM_MAX			4096
>  #define DMA_NUM_APP_WORDS		5
>  #define LEN_APP				4
> -#define RX_BUF_NUM_DEFAULT		128
> +#define RX_BUF_NUM_DEFAULT		512
>  
>  /* Must be shorter than length of ethtool_drvinfo.driver field to fit */
>  #define DRIVER_NAME		"xaxienet"
> @@ -869,6 +869,7 @@ static void axienet_dma_tx_cb(void *data, const struct dmaengine_result *result)
>  	struct netdev_queue *txq;
>  	int len;
>  
> +	WRITE_ONCE(lp->tx_irqs, READ_ONCE(lp->tx_irqs) + 1);
>  	skbuf_dma = axienet_get_tx_desc(lp, lp->tx_ring_tail++);
>  	len = skbuf_dma->skb->len;
>  	txq = skb_get_tx_queue(lp->ndev, skbuf_dma->skb);
> @@ -881,6 +882,17 @@ static void axienet_dma_tx_cb(void *data, const struct dmaengine_result *result)
>  	netif_txq_completed_wake(txq, 1, len,
>  				 CIRC_SPACE(lp->tx_ring_head, lp->tx_ring_tail, TX_BD_NUM_MAX),
>  				 2);
> +
> +	if (READ_ONCE(lp->tx_dim_enabled)) {
> +		struct dim_sample sample = {
> +			.time = ktime_get(),
> +			.pkt_ctr = u64_stats_read(&lp->tx_packets),
> +			.byte_ctr = u64_stats_read(&lp->tx_bytes),
> +			.event_ctr = READ_ONCE(lp->tx_irqs),
> +		};
> +
> +		net_dim(&lp->tx_dim, &sample);
> +	}
>  }
>  
>  /**
> @@ -1161,6 +1173,7 @@ static void axienet_dma_rx_cb(void *data, const struct dmaengine_result *result)
>  	struct sk_buff *skb;
>  	u32 *app_metadata;
>  
> +	WRITE_ONCE(lp->rx_irqs, READ_ONCE(lp->rx_irqs) + 1);
>  	skbuf_dma = axienet_get_rx_desc(lp, lp->rx_ring_tail++);
>  	skb = skbuf_dma->skb;
>  	app_metadata = dmaengine_desc_get_metadata_ptr(skbuf_dma->desc, &meta_len,
> @@ -1179,7 +1192,18 @@ static void axienet_dma_rx_cb(void *data, const struct dmaengine_result *result)
>  	u64_stats_add(&lp->rx_bytes, rx_len);
>  	u64_stats_update_end(&lp->rx_stat_sync);
>  	axienet_rx_submit_desc(lp->ndev);
> +
>  	dma_async_issue_pending(lp->rx_chan);
> +	if (READ_ONCE(lp->rx_dim_enabled)) {
> +		struct dim_sample sample = {
> +			.time = ktime_get(),
> +			.pkt_ctr = u64_stats_read(&lp->rx_packets),
> +			.byte_ctr = u64_stats_read(&lp->rx_bytes),
> +			.event_ctr = READ_ONCE(lp->rx_irqs),
> +		};
> +
> +		net_dim(&lp->rx_dim, &sample);
> +	}
>  }
>  
>  /**
> @@ -1492,6 +1516,9 @@ static void axienet_rx_submit_desc(struct net_device *ndev)
>  	dev_kfree_skb(skb);
>  }
>  
> +static u32 axienet_dim_coalesce_count_rx(struct axienet_local *lp);
> +static u32 axienet_dim_coalesce_count_tx(struct axienet_local *lp);
> +
>  /**
>   * axienet_init_dmaengine - init the dmaengine code.
>   * @ndev:       Pointer to net_device structure
> @@ -1505,6 +1532,7 @@ static int axienet_init_dmaengine(struct net_device *ndev)
>  {
>  	struct axienet_local *lp = netdev_priv(ndev);
>  	struct skbuf_dma_descriptor *skbuf_dma;
> +	struct dma_slave_config tx_config, rx_config;
>  	int i, ret;
>  
>  	lp->tx_chan = dma_request_chan(lp->dev, "tx_chan0");
> @@ -1520,6 +1548,22 @@ static int axienet_init_dmaengine(struct net_device *ndev)
>  		goto err_dma_release_tx;
>  	}
>  
> +	tx_config.coalesce_cnt = axienet_dim_coalesce_count_tx(lp);
> +	tx_config.coalesce_usecs = XAXIDMAENGINE_DFT_TX_USEC;
> +	rx_config.coalesce_cnt = axienet_dim_coalesce_count_rx(lp);
> +	rx_config.coalesce_usecs =  XAXIDMA_DFT_RX_USEC;
> +
> +	ret = dmaengine_slave_config(lp->tx_chan, &tx_config);
> +	if (ret) {
> +		dev_err(lp->dev, "Failed to configure Tx coalesce parameters\n");
> +		goto err_dma_release_tx;
> +	}
> +	ret = dmaengine_slave_config(lp->rx_chan, &rx_config);
> +	if (ret) {
> +		dev_err(lp->dev, "Failed to configure Rx coalesce parameters\n");
> +		goto err_dma_release_tx;
> +	}
> +
>  	lp->tx_ring_tail = 0;
>  	lp->tx_ring_head = 0;
>  	lp->rx_ring_tail = 0;
> @@ -1692,6 +1736,7 @@ static int axienet_open(struct net_device *ndev)
>  		free_irq(lp->eth_irq, ndev);
>  err_phy:
>  	cancel_work_sync(&lp->rx_dim.work);
> +	cancel_work_sync(&lp->tx_dim.work);
>  	cancel_delayed_work_sync(&lp->stats_work);
>  	phylink_stop(lp->phylink);
>  	phylink_disconnect_phy(lp->phylink);
> @@ -1722,6 +1767,7 @@ static int axienet_stop(struct net_device *ndev)
>  	}
>  
>  	cancel_work_sync(&lp->rx_dim.work);
> +	cancel_work_sync(&lp->tx_dim.work);
>  	cancel_delayed_work_sync(&lp->stats_work);
>  
>  	phylink_stop(lp->phylink);
> @@ -2104,6 +2150,15 @@ static u32 axienet_dim_coalesce_count_rx(struct axienet_local *lp)
>  	return min(1 << (lp->rx_dim.profile_ix << 1), 255);
>  }
>  
> +/**
> + * axienet_dim_coalesce_count_tx() - TX coalesce count for DIM
> + * @lp: Device private data
> + */
> +static u32 axienet_dim_coalesce_count_tx(struct axienet_local *lp)
> +{
> +	return min(1 << (lp->tx_dim.profile_ix << 1), 255);
> +}
> +
>  /**
>   * axienet_rx_dim_work() - Adjust RX DIM settings
>   * @work: The work struct
> @@ -2120,6 +2175,40 @@ static void axienet_rx_dim_work(struct work_struct *work)
>  	lp->rx_dim.state = DIM_START_MEASURE;
>  }
>  
> +/**
> + * axienet_rx_dim_work_dmaengine() - Adjust RX DIM settings in dmaengine
> + * @work: The work struct
> + */
> +static void axienet_rx_dim_work_dmaengine(struct work_struct *work)
> +{
> +	struct axienet_local *lp =
> +		container_of(work, struct axienet_local, rx_dim.work);
> +	struct dma_slave_config cfg = {
> +		.coalesce_cnt	= axienet_dim_coalesce_count_rx(lp),
> +		.coalesce_usecs	= 16,
> +	};
> +
> +	dmaengine_slave_config(lp->rx_chan, &cfg);
> +	lp->rx_dim.state = DIM_START_MEASURE;
> +}
> +
> +/**
> + * axienet_tx_dim_work_dmaengine() - Adjust RX DIM settings in dmaengine
> + * @work: The work struct
> + */
> +static void axienet_tx_dim_work_dmaengine(struct work_struct *work)
> +{
> +	struct axienet_local *lp =
> +		container_of(work, struct axienet_local, tx_dim.work);
> +	struct dma_slave_config cfg = {
> +		.coalesce_cnt	= axienet_dim_coalesce_count_tx(lp),
> +		.coalesce_usecs	= 16,
> +	};
> +
> +	dmaengine_slave_config(lp->tx_chan, &cfg);
> +	lp->tx_dim.state = DIM_START_MEASURE;
> +}
> +
>  /**
>   * axienet_update_coalesce_tx() - Set TX CR
>   * @lp: Device private data
> @@ -2171,6 +2260,20 @@ axienet_ethtools_get_coalesce(struct net_device *ndev,
>  	u32 cr;
>  
>  	ecoalesce->use_adaptive_rx_coalesce = lp->rx_dim_enabled;
> +	ecoalesce->use_adaptive_tx_coalesce = lp->tx_dim_enabled;
> +
> +	if (lp->use_dmaengine) {
> +		struct dma_slave_caps tx_caps, rx_caps;
> +
> +		dma_get_slave_caps(lp->tx_chan, &tx_caps);
> +		dma_get_slave_caps(lp->rx_chan, &rx_caps);
> +
> +		ecoalesce->tx_max_coalesced_frames = tx_caps.coalesce_cnt;
> +		ecoalesce->tx_coalesce_usecs = tx_caps.coalesce_usecs;
> +		ecoalesce->rx_max_coalesced_frames = rx_caps.coalesce_cnt;
> +		ecoalesce->rx_coalesce_usecs = rx_caps.coalesce_usecs;
> +		return 0;
> +	}
>  
>  	spin_lock_irq(&lp->rx_cr_lock);
>  	cr = lp->rx_dma_cr;
> @@ -2208,8 +2311,10 @@ axienet_ethtools_set_coalesce(struct net_device *ndev,
>  			      struct netlink_ext_ack *extack)
>  {
>  	struct axienet_local *lp = netdev_priv(ndev);
> -	bool new_dim = ecoalesce->use_adaptive_rx_coalesce;
> -	bool old_dim = lp->rx_dim_enabled;
> +	bool new_rxdim = ecoalesce->use_adaptive_rx_coalesce;
> +	bool new_txdim = ecoalesce->use_adaptive_tx_coalesce;
> +	bool old_rxdim = lp->rx_dim_enabled;
> +	bool old_txdim = lp->tx_dim_enabled;
>  	u32 cr, mask = ~XAXIDMA_CR_RUNSTOP_MASK;
>  
>  	if (ecoalesce->rx_max_coalesced_frames > 255 ||
> @@ -2224,20 +2329,76 @@ axienet_ethtools_set_coalesce(struct net_device *ndev,
>  		return -EINVAL;
>  	}
>  
> -	if (((ecoalesce->rx_max_coalesced_frames > 1 || new_dim) &&
> +	if (((ecoalesce->rx_max_coalesced_frames > 1 || new_rxdim) &&
>  	     !ecoalesce->rx_coalesce_usecs) ||
> -	    (ecoalesce->tx_max_coalesced_frames > 1 &&
> +	    ((ecoalesce->tx_max_coalesced_frames > 1 || new_txdim) &&
>  	     !ecoalesce->tx_coalesce_usecs)) {
>  		NL_SET_ERR_MSG(extack,
>  			       "usecs must be non-zero when frames is greater than one");
>  		return -EINVAL;
>  	}
>  
> -	if (new_dim && !old_dim) {
> +	if (lp->use_dmaengine)	{
> +		struct dma_slave_config tx_cfg, rx_cfg;
> +		int ret;
> +
> +		if (new_rxdim && !old_rxdim) {
> +			rx_cfg.coalesce_cnt = axienet_dim_coalesce_count_rx(lp);
> +			rx_cfg.coalesce_usecs = ecoalesce->rx_coalesce_usecs;
> +		} else if (!new_rxdim) {
> +			if (old_rxdim) {
> +				WRITE_ONCE(lp->rx_dim_enabled, false);
> +				flush_work(&lp->rx_dim.work);
> +			}
> +
> +			rx_cfg.coalesce_cnt = ecoalesce->rx_max_coalesced_frames;
> +			rx_cfg.coalesce_usecs = ecoalesce->rx_coalesce_usecs;
> +		} else {
> +			rx_cfg.coalesce_cnt = ecoalesce->rx_max_coalesced_frames;
> +			rx_cfg.coalesce_usecs = ecoalesce->rx_coalesce_usecs;
> +		}
> +
> +		if (new_txdim && !old_txdim) {
> +			tx_cfg.coalesce_cnt = axienet_dim_coalesce_count_tx(lp);
> +			tx_cfg.coalesce_usecs = ecoalesce->tx_coalesce_usecs;
> +		} else if (!new_txdim) {
> +			if (old_txdim) {
> +				WRITE_ONCE(lp->tx_dim_enabled, false);
> +				flush_work(&lp->tx_dim.work);
> +			}
> +
> +			tx_cfg.coalesce_cnt = ecoalesce->tx_max_coalesced_frames;
> +			tx_cfg.coalesce_usecs = ecoalesce->tx_coalesce_usecs;
> +		} else {
> +			tx_cfg.coalesce_cnt = ecoalesce->tx_max_coalesced_frames;
> +			tx_cfg.coalesce_usecs = ecoalesce->tx_coalesce_usecs;
> +		}
> +
> +		ret = dmaengine_slave_config(lp->rx_chan, &rx_cfg);
> +		if (ret) {
> +			NL_SET_ERR_MSG(extack, "failed to set rx coalesce parameters");
> +			return ret;
> +		}
> +
> +		if (new_rxdim && !old_rxdim)
> +			WRITE_ONCE(lp->rx_dim_enabled, true);
> +
> +		ret = dmaengine_slave_config(lp->tx_chan, &tx_cfg);
> +		if (ret) {
> +			NL_SET_ERR_MSG(extack, "failed to set tx coalesce parameters");
> +			return ret;
> +		}
> +		if (new_txdim && !old_txdim)
> +			WRITE_ONCE(lp->tx_dim_enabled, true);
> +
> +		return 0;
> +	}

Very big block of if and else conditions and looks confusing. Please
simplify using small helpers for TX and RX. Also write a comment what
you are trying to do with new and old TX and RX dims.

Thanks,
Sundeep

> +
> +	if (new_rxdim && !old_rxdim) {
>  		cr = axienet_calc_cr(lp, axienet_dim_coalesce_count_rx(lp),
>  				     ecoalesce->rx_coalesce_usecs);
> -	} else if (!new_dim) {
> -		if (old_dim) {
> +	} else if (!new_rxdim) {
> +		if (old_rxdim) {
>  			WRITE_ONCE(lp->rx_dim_enabled, false);
>  			napi_synchronize(&lp->napi_rx);
>  			flush_work(&lp->rx_dim.work);
> @@ -2252,7 +2413,7 @@ axienet_ethtools_set_coalesce(struct net_device *ndev,
>  	}
>  
>  	axienet_update_coalesce_rx(lp, cr, mask);
> -	if (new_dim && !old_dim)
> +	if (new_rxdim && !old_rxdim)
>  		WRITE_ONCE(lp->rx_dim_enabled, true);
>  
>  	cr = axienet_calc_cr(lp, ecoalesce->tx_max_coalesced_frames,
> @@ -2496,7 +2657,7 @@ axienet_ethtool_get_rmon_stats(struct net_device *dev,
>  static const struct ethtool_ops axienet_ethtool_ops = {
>  	.supported_coalesce_params = ETHTOOL_COALESCE_MAX_FRAMES |
>  				     ETHTOOL_COALESCE_USECS |
> -				     ETHTOOL_COALESCE_USE_ADAPTIVE_RX,
> +				     ETHTOOL_COALESCE_USE_ADAPTIVE,
>  	.get_drvinfo    = axienet_ethtools_get_drvinfo,
>  	.get_regs_len   = axienet_ethtools_get_regs_len,
>  	.get_regs       = axienet_ethtools_get_regs,
> @@ -3041,7 +3202,14 @@ static int axienet_probe(struct platform_device *pdev)
>  
>  	spin_lock_init(&lp->rx_cr_lock);
>  	spin_lock_init(&lp->tx_cr_lock);
> -	INIT_WORK(&lp->rx_dim.work, axienet_rx_dim_work);
> +	if (lp->use_dmaengine) {
> +		INIT_WORK(&lp->rx_dim.work, axienet_rx_dim_work_dmaengine);
> +		INIT_WORK(&lp->tx_dim.work, axienet_tx_dim_work_dmaengine);
> +		lp->tx_dim_enabled = true;
> +		lp->tx_dim.profile_ix = 1;
> +	} else {
> +		INIT_WORK(&lp->rx_dim.work, axienet_rx_dim_work);
> +	}
>  	lp->rx_dim_enabled = true;
>  	lp->rx_dim.profile_ix = 1;
>  	lp->rx_dma_cr = axienet_calc_cr(lp, axienet_dim_coalesce_count_rx(lp),
> -- 
> 2.25.1
> 

