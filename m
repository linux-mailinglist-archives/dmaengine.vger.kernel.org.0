Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93EAB12788F
	for <lists+dmaengine@lfdr.de>; Fri, 20 Dec 2019 10:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfLTJzA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 20 Dec 2019 04:55:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:45860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727192AbfLTJzA (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 20 Dec 2019 04:55:00 -0500
Received: from localhost (unknown [106.201.107.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97E35206EC;
        Fri, 20 Dec 2019 09:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576835699;
        bh=ZvFZkSWKpFjRd2JXVMxEnSX/W0KkXIR4qevF9Q/DSjA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dGZ3PO/0HmLtt2laAvR9GI41mPKMF8qQXO3Bh25YGGwsdIG9D7V2w6UQ7cn7e9kMF
         o6E6mRXPYtow/dMGdGptgtUr3ZEcITFVOqfUj7RRH1R0xqhF2dOkLc3Kp/+PrkA05w
         pWkvuE+7hMV5IovIWAPjxsg+B3KzLR55tiAqM8e4=
Date:   Fri, 20 Dec 2019 15:24:55 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     robh+dt@kernel.org, nm@ti.com, ssantosh@kernel.org,
        dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, grygorii.strashko@ti.com,
        lokeshvutla@ti.com, t-kristo@ti.com, tony@atomide.com,
        j-keerthy@ti.com, vigneshr@ti.com
Subject: Re: [PATCH v7 06/12] dmaengine: ti: Add cppi5 header for K3
 NAVSS/UDMA
Message-ID: <20191220095455.GM2536@vkoul-mobl>
References: <20191209094332.4047-1-peter.ujfalusi@ti.com>
 <20191209094332.4047-7-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209094332.4047-7-peter.ujfalusi@ti.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 09-12-19, 11:43, Peter Ujfalusi wrote:

> +#define CPPI5_INFO2_DESC_RETPUSHPOLICY		BIT(16)
> +#define CPPI5_INFO2_DESC_RETP_MASK		GENMASK(18, 16)
> +
> +#define CPPI5_INFO2_DESC_RETQ_SHIFT		(0)
> +#define CPPI5_INFO2_DESC_RETQ_MASK		GENMASK(15, 0)
> +
> +#define CPPI5_INFO3_DESC_SRCTAG_SHIFT		(16U)
> +#define CPPI5_INFO3_DESC_SRCTAG_MASK		GENMASK(31, 16)
> +#define CPPI5_INFO3_DESC_DSTTAG_SHIFT		(0)
> +#define CPPI5_INFO3_DESC_DSTTAG_MASK		GENMASK(15, 0)
> +
> +#define CPPI5_BUFINFO1_HDESC_DATA_LEN_SHIFT	(0)
> +#define CPPI5_BUFINFO1_HDESC_DATA_LEN_MASK	GENMASK(27, 0)
> +
> +#define CPPI5_OBUFINFO0_HDESC_BUF_LEN_SHIFT	(0)
> +#define CPPI5_OBUFINFO0_HDESC_BUF_LEN_MASK	GENMASK(27, 0)

I think you can remove the SHIFT defines and use ffs() to get the bit
position for shift

> +static inline u32 cppi5_hdesc_calc_size(bool epib, u32 psdata_size,
> +					u32 sw_data_size)
> +{
> +	u32 desc_size;
> +
> +	if (psdata_size > CPPI5_INFO0_HDESC_PSDATA_MAX_SIZE)
> +		return 0;
> +
> +	desc_size = sizeof(struct cppi5_host_desc_t) + psdata_size +
> +		    sw_data_size;

I think there was an API for this kind of mem allocation of struct and
buffer attached...

> +static inline void cppi5_hdesc_reset_hbdesc(struct cppi5_host_desc_t *desc)
> +{
> +	desc->hdr = (struct cppi5_desc_hdr_t) { 0 };
> +	desc->next_desc = 0;

would this not be superfluous? Or if you want a memset call?

> +static inline u32 *cppi5_hdesc_get_psdata32(struct cppi5_host_desc_t *desc)
> +{
> +	return (u32 *)cppi5_hdesc_get_psdata(desc);

you dont need casts away from void *

-- 
~Vinod
