Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57CF3F7005
	for <lists+dmaengine@lfdr.de>; Mon, 11 Nov 2019 10:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfKKJBF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Nov 2019 04:01:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:43026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726768AbfKKJBE (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 11 Nov 2019 04:01:04 -0500
Received: from localhost (unknown [106.201.42.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60B34206BA;
        Mon, 11 Nov 2019 09:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573462864;
        bh=z/j9crcHsk7S4aU9B2I6s0jBvYdfKN9sp40Q4ClK9J4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e69J39U/DZqIZdafDyLMGrY+J4YYs6R8wCZts1udWAxa3Xhh2I/nPeAbcxehxjL/F
         IlHNETuf6ciTeHdl4WU+En9BixkF7hVwiHh8IFPPhLOrfJAlgJNT8lmZaw7kmMydY9
         CTHYUhLs399fKoWZGmHus2OLDQB3QXS1NUL58kPc=
Date:   Mon, 11 Nov 2019 14:30:57 +0530
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
Message-ID: <20191111090057.GT952516@vkoul-mobl>
References: <20191101084135.14811-1-peter.ujfalusi@ti.com>
 <20191101084135.14811-10-peter.ujfalusi@ti.com>
 <20191111052828.GN952516@vkoul-mobl>
 <00777586-a3ac-2404-5226-e8c887936a32@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00777586-a3ac-2404-5226-e8c887936a32@ti.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 11-11-19, 10:33, Peter Ujfalusi wrote:
> On 11/11/2019 7.28, Vinod Koul wrote:
> > On 01-11-19, 10:41, Peter Ujfalusi wrote:

> >> +	struct udma_static_tr static_tr;
> >> +	char *name;
> >> +
> >> +	struct udma_tchan *tchan;
> >> +	struct udma_rchan *rchan;
> >> +	struct udma_rflow *rflow;
> >> +
> >> +	bool psil_paired;
> >> +
> >> +	int irq_num_ring;
> >> +	int irq_num_udma;
> >> +
> >> +	bool cyclic;
> >> +	bool paused;
> >> +
> >> +	enum udma_chan_state state;
> >> +	struct completion teardown_completed;
> >> +
> >> +	u32 bcnt; /* number of bytes completed since the start of the channel */
> >> +	u32 in_ring_cnt; /* number of descriptors in flight */
> >> +
> >> +	bool pkt_mode; /* TR or packet */
> >> +	bool needs_epib; /* EPIB is needed for the communication or not */
> >> +	u32 psd_size; /* size of Protocol Specific Data */
> >> +	u32 metadata_size; /* (needs_epib ? 16:0) + psd_size */
> >> +	u32 hdesc_size; /* Size of a packet descriptor in packet mode */
> >> +	bool notdpkt; /* Suppress sending TDC packet */
> >> +	int remote_thread_id;
> >> +	u32 src_thread;
> >> +	u32 dst_thread;
> >> +	enum psil_endpoint_type ep_type;
> >> +	bool enable_acc32;
> >> +	bool enable_burst;
> >> +	enum udma_tp_level channel_tpl; /* Channel Throughput Level */
> >> +
> >> +	/* dmapool for packet mode descriptors */
> >> +	bool use_dma_pool;
> >> +	struct dma_pool *hdesc_pool;
> >> +
> >> +	u32 id;
> >> +	enum dma_transfer_direction dir;
> > 
> > why does channel have this, it already exists in descriptor
> 
> The channel can not change role, it is set when it was requested. In the

how do you do this on set? The channel is requested, we do not know the
direction. When prep_ is invoked we know it..

-- 
~Vinod
