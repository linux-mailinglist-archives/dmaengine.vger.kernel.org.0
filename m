Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E109B12772E
	for <lists+dmaengine@lfdr.de>; Fri, 20 Dec 2019 09:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfLTIcW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 20 Dec 2019 03:32:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:50978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbfLTIcW (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 20 Dec 2019 03:32:22 -0500
Received: from localhost (unknown [106.201.107.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E99F1227BF;
        Fri, 20 Dec 2019 08:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576830741;
        bh=hBWzx2yIsLDhvkyJawI2ZCRbOghi05yT23MBgF01k/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EHVWANNvlC3Dk/sWI4RHpbbVPN5qlthby8A4ORphYODzu08WzIloK8ma7wKqJ55P4
         M6vFsWoHicY+3Inil6sSALU5DspaucNFJ0ihPIpmuU49+pGZ8o/7ibrWK0+EaHxiFL
         UdiTJJIuNap/BD3JY06DG6MEBMy57lU3oGsPjtFc=
Date:   Fri, 20 Dec 2019 14:02:16 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     robh+dt@kernel.org, nm@ti.com, ssantosh@kernel.org,
        dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, grygorii.strashko@ti.com,
        lokeshvutla@ti.com, t-kristo@ti.com, tony@atomide.com,
        j-keerthy@ti.com, vigneshr@ti.com
Subject: Re: [PATCH v7 04/12] dmaengine: Add metadata_ops for
 dma_async_tx_descriptor
Message-ID: <20191220083216.GK2536@vkoul-mobl>
References: <20191209094332.4047-1-peter.ujfalusi@ti.com>
 <20191209094332.4047-5-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209094332.4047-5-peter.ujfalusi@ti.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Peter,

On 09-12-19, 11:43, Peter Ujfalusi wrote:

> +int dmaengine_desc_attach_metadata(struct dma_async_tx_descriptor *desc,
> +				   void *data, size_t len)
> +{
> +	int ret;
> +
> +	if (!desc)
> +		return -EINVAL;
> +
> +	ret = desc_check_and_set_metadata_mode(desc, DESC_METADATA_CLIENT);
> +	if (ret)
> +		return ret;
> +
> +	if (!desc->metadata_ops || !desc->metadata_ops->attach)
> +		return -ENOTSUPP;
> +
> +	return desc->metadata_ops->attach(desc, data, len);

this looks good to me, only thing is we should check if people are
mixing the modes :)

-- 
~Vinod
