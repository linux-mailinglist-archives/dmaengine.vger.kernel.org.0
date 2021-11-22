Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D5745892A
	for <lists+dmaengine@lfdr.de>; Mon, 22 Nov 2021 06:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbhKVFzu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Nov 2021 00:55:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:51204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229994AbhKVFzt (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 22 Nov 2021 00:55:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EA6B76023D;
        Mon, 22 Nov 2021 05:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637560363;
        bh=yZlM5qstEiP1LHLhPjYeGy9KpnHdDJ7Bx1EjYrpcMYs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lv8Hl0clZUywnbeVPcsOZW/Aqv89Xh4q1C4G/VWb47GgZdZ+NbVWx/1JCKRCKymDl
         41wI9ZL/czimMTfCwilnEG2FWn+LKP9uWtVWkJtVveZvMch6sRINJ0ihefb5ti7ZkD
         l43olsPJaV4SKAlLrYys6IwDXGCSENX1OluEYb7v6kvWGZlX9AwVTodhkTnxZypf7z
         7+YkgtjjB7tOWTj5qwvtzekOeGgF+xTR9HPwKerxqL9F1pXKcAjMxM6kqRAY0spukT
         gqpO9Wd4dKe9x+mh3Y5keoiuqr1FxejgDWt08GhlCgtT6JvaSXWAuIeM93LknDP/Iw
         uctzmT3+I1LLA==
Date:   Mon, 22 Nov 2021 11:22:39 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Tim Gardner <tim.gardner@canonical.com>
Cc:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2][linux-next] dmaengine: dw-axi-dmac: Fix uninitialized
 variable in axi_chan_block_xfer_start()
Message-ID: <YZswJ7eZO2LdJ3ST@matsya>
References: <YXZBxx8NObaf3x70@matsya>
 <20211025181656.31658-1-tim.gardner@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025181656.31658-1-tim.gardner@canonical.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 25-10-21, 12:16, Tim Gardner wrote:
> Coverity complains of an uninitialized variable:
> 
> 5. uninit_use_in_call: Using uninitialized value config.dst_per when calling axi_chan_config_write. [show details]
> 6. uninit_use_in_call: Using uninitialized value config.hs_sel_src when calling axi_chan_config_write. [show details]
> CID 121164 (#1-3 of 3): Uninitialized scalar variable (UNINIT)
> 7. uninit_use_in_call: Using uninitialized value config.src_per when calling axi_chan_config_write. [show details]
> 418        axi_chan_config_write(chan, &config);
> 
> Fix this by initializing the structure to 0 which should at least be benign in axi_chan_config_write(). Also fix
> what looks like a cut-n-paste error when initializing config.hs_sel_dst.

Applied, thanks

-- 
~Vinod
