Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C3F438FA1
	for <lists+dmaengine@lfdr.de>; Mon, 25 Oct 2021 08:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhJYGnU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Oct 2021 02:43:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:47850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229850AbhJYGnT (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 25 Oct 2021 02:43:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E7A6760EFE;
        Mon, 25 Oct 2021 06:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635144057;
        bh=1m8Qm6Ar8P58zbGlX/cdwDXzRK1atE7UaM/YE71m+8w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iSdqyhfOqhC5XOHj2Us46t1Wo8lkTPR3VIQOfBmip741WzHQm936QMwUUzT24B3Ka
         2tGOapQZO14Px7zrrosO5i6RjE/AdIBskw0F4UoBYky7PNehxfZKxWwGixjly2rTT3
         CggvpISYhMX1Dl1lTBkdeZa1RakXKWc7jxaNxsKPssLZclTVJIfcHufhgdLmK6LIiQ
         DMjs9ICD0TidG7hQGjbuyicEvJF/2g9Zcrc1cwaDMM/iCrH7vaeiLkSVdJR3oNz/Ma
         NxCmLbOYTO6/uwT5dxww+Zk2Fu0C2OKMAUeu3mVDLy+OpduIZQ3oEB2gKB/yy7osw6
         FSQAmRRX467zg==
Date:   Mon, 25 Oct 2021 12:10:53 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Angelo Dureghello <angelo.dureghello@timesys.com>
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-m68k@vger.kernel.org
Subject: Re: [PATCH] dmaengine: fsl-edma: fix for missing dmamux module
Message-ID: <YXZRdfcFXSk5Wi0X@matsya>
References: <20210901211610.662077-1-angelo.dureghello@timesys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210901211610.662077-1-angelo.dureghello@timesys.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 01-09-21, 23:16, Angelo Dureghello wrote:
> Fix following panic on system halt:
> 
> Requesting system halt
> [   10.600000] spi spi0.1: spi_device 0.1 cleanup
> [   10.630000] fsl_edma_chan_mux() fsl_chan->edma->n_chans 64 dmamux_nr 0
> [   10.630000] *** ZERO DIVIDE ***   FORMAT=4
> [   10.630000] Current process id is 38
> [   10.630000] BAD KERNEL TRAP: 00000000
> [   10.630000] PC: [<402f09ba>] fsl_edma_chan_mux+0x7c/0x12e
> ...
> 
> Some architecture as mcf5441x (ColdFire) may not have
> a dmamux, so dmamux_nr is set to 0. This patch considers this case.

Applied, thanks

-- 
~Vinod
