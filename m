Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F027ACF4E
	for <lists+dmaengine@lfdr.de>; Sun,  8 Sep 2019 16:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbfIHO0q (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 8 Sep 2019 10:26:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:51384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727819AbfIHO0q (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 8 Sep 2019 10:26:46 -0400
Received: from localhost (unknown [122.182.221.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 334872082C;
        Sun,  8 Sep 2019 14:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567952805;
        bh=5OC7Bh5uXfbtr4JcrcU69cVhYn1EgLlh/jbSfCSkHnE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DupPeUreh77vAnNFkRHcvZkC5JEoXcFKq61YC4s2Sz1Xk2CDD3ymTVWmey73R7Iry
         j38HOr3x1SWw/XhxnU24p4fio+G3bqtEUX6juOJIXpWL0EHNI2mGqM5MNI5JXamb11
         +ihuCLC9yGbSxoa98lha+itpNuTROB8kw0w2KKk8=
Date:   Sun, 8 Sep 2019 19:55:28 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     robh+dt@kernel.org, nm@ti.com, ssantosh@kernel.org,
        dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, grygorii.strashko@ti.com,
        lokeshvutla@ti.com, t-kristo@ti.com, tony@atomide.com,
        j-keerthy@ti.com
Subject: Re: [PATCH v2 06/14] dmaengine: ti: Add cppi5 header for UDMA
Message-ID: <20190908142528.GP2672@vkoul-mobl>
References: <20190730093450.12664-1-peter.ujfalusi@ti.com>
 <20190730093450.12664-7-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730093450.12664-7-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 30-07-19, 12:34, Peter Ujfalusi wrote:

> +/**
> + * Descriptor header, present in all types of descriptors
> + */
> +struct cppi5_desc_hdr_t {
> +	u32 pkt_info0;	/* Packet info word 0 (n/a in Buffer desc) */
> +	u32 pkt_info1;	/* Packet info word 1 (n/a in Buffer desc) */
> +	u32 pkt_info2;	/* Packet info word 2 Buffer reclamation info */
> +	u32 src_dst_tag; /* Packet info word 3 (n/a in Buffer desc) */

Can we move these comments to kernel-doc style please

> +/**
> + * cppi5_desc_get_type - get descriptor type
> + * @desc_hdr: packet descriptor/TR header
> + *
> + * Returns descriptor type:
> + * CPPI5_INFO0_DESC_TYPE_VAL_HOST
> + * CPPI5_INFO0_DESC_TYPE_VAL_MONO
> + * CPPI5_INFO0_DESC_TYPE_VAL_TR
> + */
> +static inline u32 cppi5_desc_get_type(struct cppi5_desc_hdr_t *desc_hdr)
> +{
> +	WARN_ON(!desc_hdr);

why WARN_ON and not return error!

> +/**
> + * cppi5_hdesc_calc_size - Calculate Host Packet Descriptor size
> + * @epib: is EPIB present
> + * @psdata_size: PSDATA size
> + * @sw_data_size: SWDATA size
> + *
> + * Returns required Host Packet Descriptor size
> + * 0 - if PSDATA > CPPI5_INFO0_HDESC_PSDATA_MAX_SIZE
> + */
> +static inline u32 cppi5_hdesc_calc_size(bool epib, u32 psdata_size,
> +					u32 sw_data_size)
> +{
> +	u32 desc_size;
> +
> +	if (psdata_size > CPPI5_INFO0_HDESC_PSDATA_MAX_SIZE)
> +		return 0;
> +	//TODO_GS: align

:)

-- 
~Vinod
