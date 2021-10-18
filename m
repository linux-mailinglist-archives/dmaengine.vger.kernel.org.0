Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50F7C4310A2
	for <lists+dmaengine@lfdr.de>; Mon, 18 Oct 2021 08:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbhJRGjP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 18 Oct 2021 02:39:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:42040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229533AbhJRGjP (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 18 Oct 2021 02:39:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED71261250;
        Mon, 18 Oct 2021 06:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634539024;
        bh=PEdlLhjMCVBBmQt9REdXYrhvMVe/FkFIfB6TaXtEL7M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dt0aTZtb2mC8AmAMMuvs0+MyWvP/WyTeJau8h+fqpu3Uz6fu/YRJzk9JImE3AKuiD
         Up/tO2pyn3LDTricOh+3fD/PBcwqLNDWCuygsSP4AMPIo2Dus//i20okBeAHptHNwe
         09D+HDMxAnXbrWQ2IyjbgK41TggDVWD7pXFtBXMstJ3qxdXXQzgEVVh1IfaaEzX3W1
         6n9o5gRwuDQGre+t4cNOxMMh3L1LYUXyVuZ9sFXECdyTPvFbgivUbNMEEUnCoW+eln
         ai5X8vjGrZ2yYH0avgsWsEuK4LNMmRNFB5uZEcGWCcpbaOt9X8GN0CwEfdq1kPslFi
         KXEPr3245lwmA==
Date:   Mon, 18 Oct 2021 12:06:59 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        dmaengine@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: sh: rz-dmac: Add DMA clock handling
Message-ID: <YW0WCyDAEi87Vsed@matsya>
References: <20210923102451.11403-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210923102451.11403-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 23-09-21, 11:24, Biju Das wrote:
> Currently, DMA clocks are turned on by the bootloader.
> This patch adds support for DMA clock handling so that
> the driver manages the DMA clocks.

Applied, thanks

-- 
~Vinod
