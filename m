Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67F1CD0F9A
	for <lists+dmaengine@lfdr.de>; Wed,  9 Oct 2019 15:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731049AbfJINHX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 9 Oct 2019 09:07:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:52514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730858AbfJINHX (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 9 Oct 2019 09:07:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93620206B6;
        Wed,  9 Oct 2019 13:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570626443;
        bh=I2rgea/7x+I9Lx3vaph2jU5rGmbfis/HOE3Whtcl5Gc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wpql2t7DRox+tN+68b/NXl52k+vivrSRYuP3zdewsqx0dMDovNK1t5reJi+Bha0mn
         7wFb/lyFAosoXW0vqSMYI3vN5lg1PfzBik0pL+p8tkDfhQ5+ViFm4wuhEZmzP6q5+G
         U+hpMighEWE6Lj+9mZag00VXSixkLwtMVHuKMtQI=
Date:   Wed, 9 Oct 2019 15:07:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alexander Gordeev <a.gordeev.box@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        Michael Chen <micchen@altera.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dmaengine: avalon: Intel Avalon-MM DMA Interface
 for PCIe
Message-ID: <20191009130720.GA4148375@kroah.com>
References: <cover.1570558807.git.a.gordeev.box@gmail.com>
 <3ed3c016b7fbe69e36023e7ee09c53acac8a064c.1570558807.git.a.gordeev.box@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ed3c016b7fbe69e36023e7ee09c53acac8a064c.1570558807.git.a.gordeev.box@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Oct 09, 2019 at 12:12:30PM +0200, Alexander Gordeev wrote:
> +static int setup_dma_descs(struct dma_desc *dma_descs,
> +			   struct avalon_dma_desc *desc)
> +{
> +	struct scatterlist *sg_stop;
> +	unsigned int sg_set;
> +	int ret;
> +
> +	ret = setup_descs_sg(dma_descs, 0,
> +			     desc->direction,
> +			     desc->dev_addr,
> +			     desc->sg, desc->sg_len,
> +			     desc->sg_curr, desc->sg_offset,
> +			     &sg_stop, &sg_set);
> +	BUG_ON(!ret);

Yeah, a driver can crash the kernel!

:(

Never do this, always recover properly, to not do so is "lazy"
programming.

If this is something that is impossible to ever happen, then never test
for it.  But if it can happen, then properly handle the error and move
on.

Same for the other uses of BUG_ON() and WARN_ON in here.  Remember many
systems run with "panic on warn" so if a user can trigger that, then the
machine reboots, which is not good.

thanks,

greg k-h
