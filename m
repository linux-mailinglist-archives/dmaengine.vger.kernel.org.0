Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A63595CEF
	for <lists+dmaengine@lfdr.de>; Tue, 20 Aug 2019 13:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729686AbfHTLIl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Aug 2019 07:08:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:60104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729396AbfHTLIk (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 20 Aug 2019 07:08:40 -0400
Received: from localhost (unknown [106.201.62.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E43652070B;
        Tue, 20 Aug 2019 11:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566299319;
        bh=n+1G58DC0R+RX0lHsf/9dZq56zPf9tXcQyW4NsVl03Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bi8LHJYh37Gx1lyb3Livx4/OD76z6uOK+Hcjx2U8pJkywJeKDQCzBE+VoUMXlCPa3
         ABSoRLAJprx4PcRdx/0OUCEiPWyN3FYwvlOSncLyROMvBMCVez5nZQ7HS6qrRFzMju
         8yyvSFnX13e8wSxwrJ/NeiHgLLaJ0w525owahXUs=
Date:   Tue, 20 Aug 2019 16:37:28 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Simon Horman <horms+renesas@verge.net.au>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: dmaengine: nbpfaxi: Rename bindings
 documentation file
Message-ID: <20190820110728.GR12733@vkoul-mobl.Dlink>
References: <20190819135244.18183-1-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819135244.18183-1-horms+renesas@verge.net.au>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 19-08-19, 15:52, Simon Horman wrote:
> Rename the device tree bindings for renesas "Type-AXI" NBPFAXI* DMA
> controllers from nbpfaxi.txt to renesas,nbpfaxi.txt.
> 
> This is part of an ongoing effort to name bindings documentation files for
> Renesas IP blocks consistently, in line with the compat strings they
> document.

Applied, thanks

-- 
~Vinod
