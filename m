Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F27BFF6E1D
	for <lists+dmaengine@lfdr.de>; Mon, 11 Nov 2019 06:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfKKF2f (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Nov 2019 00:28:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:40028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbfKKF2f (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 11 Nov 2019 00:28:35 -0500
Received: from localhost (unknown [106.201.42.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FEFE20656;
        Mon, 11 Nov 2019 05:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573450114;
        bh=4yaDpNQuxUENXy3kqRG8Msg475RHYza2D5Myb1olFzw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ekDLb5RvoW/V2AB1uG3TZ5tiCoHfyYQx2wS41vt4ZM7sqJncKYBmdH+svDUZOAZJ6
         /vYdChQb2GsXpa6hL9MT52Obq/g7tTTZAWgrxtJIdXuS+r3bFTDY8uxp4MNboPZGHS
         0iZVlpF/Q+jGJC5Ds85Ksx82RhG3TJ8pBNYJP/ik=
Date:   Mon, 11 Nov 2019 10:58:28 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     robh+dt@kernel.org, nm@ti.com, ssantosh@kernel.org,
        dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, grygorii.strashko@ti.com,
        lokeshvutla@ti.com, t-kristo@ti.com, tony@atomide.com,
        j-keerthy@ti.com
Subject: Re: [PATCH v4 09/15] dmaengine: ti: New driver for K3 UDMA -
 split#1: defines, structs, io func
Message-ID: <20191111052828.GN952516@vkoul-mobl>
References: <20191101084135.14811-1-peter.ujfalusi@ti.com>
 <20191101084135.14811-10-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191101084135.14811-10-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 01-11-19, 10:41, Peter Ujfalusi wrote:

> +struct udma_chan {
> +	struct virt_dma_chan vc;
> +	struct dma_slave_config	cfg;
> +	struct udma_dev *ud;
> +	struct udma_desc *desc;
> +	struct udma_desc *terminated_desc;

descriptor and not a list?

> +	struct udma_static_tr static_tr;
> +	char *name;
> +
> +	struct udma_tchan *tchan;
> +	struct udma_rchan *rchan;
> +	struct udma_rflow *rflow;
> +
> +	bool psil_paired;
> +
> +	int irq_num_ring;
> +	int irq_num_udma;
> +
> +	bool cyclic;
> +	bool paused;
> +
> +	enum udma_chan_state state;
> +	struct completion teardown_completed;
> +
> +	u32 bcnt; /* number of bytes completed since the start of the channel */
> +	u32 in_ring_cnt; /* number of descriptors in flight */
> +
> +	bool pkt_mode; /* TR or packet */
> +	bool needs_epib; /* EPIB is needed for the communication or not */
> +	u32 psd_size; /* size of Protocol Specific Data */
> +	u32 metadata_size; /* (needs_epib ? 16:0) + psd_size */
> +	u32 hdesc_size; /* Size of a packet descriptor in packet mode */
> +	bool notdpkt; /* Suppress sending TDC packet */
> +	int remote_thread_id;
> +	u32 src_thread;
> +	u32 dst_thread;
> +	enum psil_endpoint_type ep_type;
> +	bool enable_acc32;
> +	bool enable_burst;
> +	enum udma_tp_level channel_tpl; /* Channel Throughput Level */
> +
> +	/* dmapool for packet mode descriptors */
> +	bool use_dma_pool;
> +	struct dma_pool *hdesc_pool;
> +
> +	u32 id;
> +	enum dma_transfer_direction dir;

why does channel have this, it already exists in descriptor

> +static irqreturn_t udma_udma_irq_handler(int irq, void *data)
> +{
> +	struct udma_chan *uc = data;
> +
> +	udma_tr_event_callback(uc);

any reason why we want to call a fn and not code here..?
-- 
~Vinod
