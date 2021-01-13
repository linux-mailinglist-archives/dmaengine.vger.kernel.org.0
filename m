Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB562F5003
	for <lists+dmaengine@lfdr.de>; Wed, 13 Jan 2021 17:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbhAMQbf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 Jan 2021 11:31:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:45422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726880AbhAMQbe (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 13 Jan 2021 11:31:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E1EFA2339D;
        Wed, 13 Jan 2021 16:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610555454;
        bh=ZwgOhhI4AHfEU9tEg0jPf24FQ+Kv3s86YiZ+XYbhOI4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KzfB2jvUagyvI0d9iO5zuPGkkaIq4u7YgubiCGqQ/81nHbM9JzGBuGYrTd+zSklW7
         FrvEp6Jbhu+oC9nvdEP+6HzNfiUoFc5157zaQCkoyFw4/rZ57k+et9ux6gW3ZdH1OI
         NlyyJtHg5RALhgp62GYNCvZkSkkloTVNIPoZPcB9/+mkvMgO3PYEBM7w6VYox//O2p
         vDjxb8TlsnL2sHVwvZN2Ms/APPCJ/yTOkJhJfaxnuBmBK9KwPP3SyN5k0Q+gVuENnS
         m3Y6W6bD/+iBBTLlhrqvQCGCLN3YbMteOWUICAj5KaBxW0Jad5X3QWqWgPJQy3R+mJ
         ygy0xJKLzmIDw==
Date:   Wed, 13 Jan 2021 22:00:48 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>
Cc:     dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, vigneshr@ti.com,
        grygorii.strashko@ti.com, kishon@ti.com
Subject: Re: [PATCH v2 0/3] dmaengine: ti: k3-udma: memcpy throughput
 improvement
Message-ID: <20210113163048.GV2771@vkoul-mobl>
References: <20210113114923.9231-1-peter.ujfalusi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210113114923.9231-1-peter.ujfalusi@gmail.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 13-01-21, 13:49, Peter Ujfalusi wrote:
> Hi,
> 
> Changes since v1:
> - Added Kishon's tested-by to the first two patch
> - Moved the variable definitions to the start of their respective functions
> - Remove braces where they are not needed
> - correct indentation of cases
> - additional patch to clean up the ret = 0 initializations in tisci channel configuration
>   functions, no functional changes.
> 
> Newer members of the KS3 family (after AM654) have support for burst_size
> configuration for each DMA channel.
> 
> The HW default value is 64 bytes but on higher throughput channels it can be
> increased to 256 bytes (UCHANs) or 128 byes (HCHANs).
> 
> Aligning the buffers and length of the transfer to the burst size also increases
> the throughput.
> 
> Numbers gathered on j721e (UCHAN pair):
> echo 8000000 > /sys/module/dmatest/parameters/test_buf_size
> echo 2000 > /sys/module/dmatest/parameters/timeout
> echo 50 > /sys/module/dmatest/parameters/iterations
> echo 1 > /sys/module/dmatest/parameters/max_channels
> 
> Prior to  this patch:   ~1.3 GB/s
> After this patch:       ~1.8 GB/s
>  with 1 byte alignment: ~1.7 GB/s

Applied, thanks

-- 
~Vinod
