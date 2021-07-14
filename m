Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A29513C7D9E
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jul 2021 06:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbhGNExF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Jul 2021 00:53:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:37828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229451AbhGNExF (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 14 Jul 2021 00:53:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5278561073;
        Wed, 14 Jul 2021 04:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626238214;
        bh=wxvKXBZPj073EBoe4vQksUb0liAuR+H7uq0nObvPZLM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NRvFRfEKvF5iAmCrevcP4Kkv5DzeS0kQf4RZSZeXRyWyGJqUffocVue0p9K6ye/uj
         aogMJtSD5C21IblexGcVJpDjznWQcpA1nFEfWppX8BCSGHKcUj32LfKmehUpgTs2bL
         btnt58Ts8ENGznwp+c0GxYJusQpwssEG3NKn0k19XPe6gk6Dx+TdWqESZ6LoXV/CYs
         4FNSFQ5UV/bIfzs+HFE6qcQKOMMn5j1NgjB//Y4Go9MaLQnE2i/bOIUM6DIfSzKbxB
         N47tzyQQ5DKh2hPOt8MeDTHwgOorWjQm7uNtzqQ+FSUWV6YBDS0o1GTcuxnpEQey+X
         HGRxhrl5c58xg==
Date:   Wed, 14 Jul 2021 10:20:10 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     pandith.n@intel.com
Cc:     Eugeniy.Paltsev@synopsys.com, dmaengine@vger.kernel.org,
        lakshmi.bai.raja.subramanian@intel.com, kris.pan@intel.com,
        mallikarjunappa.sangannavar@intel.com, Srikanth.Thokala@intel.com
Subject: Re: [linux-drivers-review] [PATCH V2 1/1] dmaengine: dw-axi-dmac:
 support parallel memory <--> peripheral transfers
Message-ID: <YO5tAlVshNLat2jt@matsya>
References: <20210709095133.26867-1-pandith.n@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210709095133.26867-1-pandith.n@intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 09-07-21, 15:21, pandith.n@intel.com wrote:
> From: Pandith N <pandith.n@intel.com>
> 
> Added support for multiple DMA_MEM_TO_DEV, DMA_DEV_TO_MEM transfers in
> parallel. This is required for peripherals using DMA for transmit and
> receive operations at the same time. APB slot number needs to be programmed
> in channel hardware handshaking interface.
> 
> Removed free slot check algorithm in dw_axi_dma_set_hw_channel. For 8
> DMA channels, use respective handshake slot in DMA_HS_SEL APB register.

and why was that removed, maybe a different patch for that?

> 
> Burst length, DMA HW capability set in dt-binding is now used in driver.

Another patch...

So, too many changes below for the description above, pls split

-- 
~Vinod
