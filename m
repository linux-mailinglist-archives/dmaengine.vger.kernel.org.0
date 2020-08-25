Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7116251B1C
	for <lists+dmaengine@lfdr.de>; Tue, 25 Aug 2020 16:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbgHYOq0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Aug 2020 10:46:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:57818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbgHYOq0 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 25 Aug 2020 10:46:26 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 974EB20782;
        Tue, 25 Aug 2020 14:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598366785;
        bh=phIsJ/MZshaAlE7qLzNtXsogO0cQbIqmLvgOTmSUSss=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SRGf5E4eKTD9RhFmfUB66zeCi2Ide/AgEYRHSPsOek5yAe83ekR/2mSvo8JavyyHQ
         1zH0c6aN3f2ZhOox3VOLsAA9SkpZ2wHJRAzFlxIZQBeRmDHX91C3CPWYtPTJ9ljkgj
         +WE5+K8H2BW4bWaSIn0aPMRU8H4fumeyzg4YTsHU=
Date:   Tue, 25 Aug 2020 20:16:19 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        lars@metafoo.de, dan.j.williams@intel.com, ardeleanalex@gmail.com
Subject: Re: [PATCH v2 0/6] dmaengine: axi-dmac: add support for reading bus
 attributes from register
Message-ID: <20200825144619.GR2639@vkoul-mobl>
References: <20200825124840.43664-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825124840.43664-1-alexandru.ardelean@analog.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 25-08-20, 15:48, Alexandru Ardelean wrote:
> The series adds support for reading the DMA bus attributes from the
> INTERFACE_DESCRIPTION (0x10) register.
> 
> The first 5 changes are a bit of rework prior to adding the actual
> change in patch 6, as things need to be shifted around a bit, to enable 
> the clock to be enabled earlier, to be able to read the version
> register.

Not sure what happened, I see two sets of patches in this series, maybe
duplicate..? Better to resend a clean version..

Even PW shows 12 patches https://patchwork.kernel.org/project/linux-dmaengine/list/

Thanks

> 
> Changelog v1 -> v2:
> * fixed error-exit paths for the clock move patch
>   i.e. 'dmaengine: axi-dmac: move clock enable earlier'
> * fixed error-exit path for patch
>   'axi-dmac: wrap channel parameter adjust into function'
> * added patch 'dmaengine: axi-dmac: move active_descs list init after device-tree init'
>   the list of active_descs can be moved a bit lower in the init/probe
> 
> Alexandru Ardelean (6):
>   dmaengine: axi-dmac: move version read in probe
>   dmaengine: axi-dmac: move active_descs list init after device-tree
>     init
>   dmaengine: axi-dmac: move clock enable earlier
>   dmaengine: axi-dmac: wrap entire dt parse in a function
>   dmaengine: axi-dmac: wrap channel parameter adjust into function
>   dmaengine: axi-dmac: add support for reading bus attributes from
>     registers
> 
>  drivers/dma/dma-axi-dmac.c | 138 ++++++++++++++++++++++++++++---------
>  1 file changed, 107 insertions(+), 31 deletions(-)
> 
> -- 
> 2.17.1

-- 
~Vinod
