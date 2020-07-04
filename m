Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0BF21474D
	for <lists+dmaengine@lfdr.de>; Sat,  4 Jul 2020 18:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgGDQJM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 4 Jul 2020 12:09:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:55050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726682AbgGDQJM (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 4 Jul 2020 12:09:12 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDA2B20739;
        Sat,  4 Jul 2020 16:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593878951;
        bh=X+m5w31XgirTMtq+0fLAVoWC/VZ/4PksqUd3bRP4osw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PBrbiXvDtehCfX5k4RSS1bunkU9TjzLHpz75ntSnDLev19/7BPsM8T2FwwUBkb8GX
         BgT16U9iJujXeGG4tieMLxIgRkWiZo7qej694rBvYa31S5rjRhuhwxpPyBz5yq1h1+
         cCyJ/oei5B7r6m0I06g/K/Mn5qcrUcLIdnvEYixY=
Date:   Sat, 4 Jul 2020 17:09:05 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-iio@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-nvdimm@lists.01.org,
        linux-usb@vger.kernel.org, Eli Billauer <eli.billauer@gmail.com>
Subject: Re: [PATCH 07/17] Documentation/driver-api: iio/buffers: drop
 doubled word
Message-ID: <20200704170905.7e596707@archlinux>
In-Reply-To: <20200704034502.17199-8-rdunlap@infradead.org>
References: <20200704034502.17199-1-rdunlap@infradead.org>
        <20200704034502.17199-8-rdunlap@infradead.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri,  3 Jul 2020 20:44:52 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> Drop the doubled word "struct".
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: William Breathitt Gray <vilhelm.gray@gmail.com>
> Cc: linux-iio@vger.kernel.org
Applied to the togreg branch of iio.git.

Thanks,

Jonathan

> ---
>  Documentation/driver-api/iio/buffers.rst |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20200701.orig/Documentation/driver-api/iio/buffers.rst
> +++ linux-next-20200701/Documentation/driver-api/iio/buffers.rst
> @@ -88,7 +88,7 @@ fields in iio_chan_spec definition::
>  The driver implementing the accelerometer described above will have the
>  following channel definition::
>  
> -   struct struct iio_chan_spec accel_channels[] = {
> +   struct iio_chan_spec accel_channels[] = {
>             {
>                     .type = IIO_ACCEL,
>  		   .modified = 1,

