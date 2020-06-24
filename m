Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19DBB206ED6
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jun 2020 10:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390314AbgFXITf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Jun 2020 04:19:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:39314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388296AbgFXITf (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 24 Jun 2020 04:19:35 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C9982082F;
        Wed, 24 Jun 2020 08:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592986774;
        bh=fgExhjyrAR43tXlRTdI8WWUCluEJes8lAjTFdOgFp4k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LxtM6dbYSDQRM+QVzBP+DtFg54XGuBddaQfotfsLmUwsFBddn9lvxwBc1myBWsHhp
         y1ZpueIOm0Qaf8SQjykmjIMSVc4K2RehGwVwWYrrI+fFS+rDcU/NJvVWkg/av/Ow1d
         rffA+NB4C05F+x/zJCrKohwnzJTywKbJSxWpUt40=
Date:   Wed, 24 Jun 2020 13:49:29 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sugar Zhang <sugar.zhang@rock-chips.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/13] dmaengine: pl330: Add quirk
 'arm,pl330-periph-burst'
Message-ID: <20200624081929.GU2324254@vkoul-mobl>
References: <1591665267-37713-1-git-send-email-sugar.zhang@rock-chips.com>
 <1591665267-37713-3-git-send-email-sugar.zhang@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591665267-37713-3-git-send-email-sugar.zhang@rock-chips.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 09-06-20, 09:14, Sugar Zhang wrote:
> This patch adds the qurik to use busrt transfers only

s/busrt/burst

> for pl330 controller, even for request with a length of 1.
> 
> Although, the correct way should be: if the peripheral request
> length is 1, the peripheral should use SINGLE request, and then
> notify the dmac using SINGLE mode by src/dst_maxburst with 1.
> 
> For example, on the Rockchip SoCs, all the peripherals can use
> SINGLE or BURST request by setting GRF registers. it is possible
> that if these peripheral drivers are used only for Rockchip SoCs.
> Unfortunately, it's not, such as dw uart, which is used so widely,
> and we can't set src/dst_maxburst according to the SoCs' specific
> to compatible with all the other SoCs.
> 
> So, for convenience, all the peripherals are set as BURST request
> by default on the Rockchip SoCs. even for request with a length of 1.
> the current pl330 driver will perform SINGLE transfer if the client's
> maxburst is 1, which still should be working according to chapter 2.6.6
> of datasheet which describe how DMAC performs SINGLE transfers for
> a BURST request. unfortunately, it's broken on the Rockchip SoCs,

s/unfortunately/Unfortunately

> which support only matching transfers, such as BURST transfer for
> BURST request, SINGLE transfer for SINGLE request.
> 
> Finaly, we add the quirk to specify pl330 to use burst transfers only.

s/Finaly/Finally

Below looks fine, pls reorder the series and have binding patch come
first and then the use of binding. Below looks fine though

-- 
~Vinod
