Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5FA143968
	for <lists+dmaengine@lfdr.de>; Tue, 21 Jan 2020 10:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbgAUJXI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 Jan 2020 04:23:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:38694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbgAUJXI (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 21 Jan 2020 04:23:08 -0500
Received: from localhost (unknown [171.76.119.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E467222522;
        Tue, 21 Jan 2020 09:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579598587;
        bh=wZZNyw6+oSP85Yme6UFz+brQhhEAm7nf6YggeNNFXbk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hD0mrIThL3GK+lN3Da5Lcqodqf9BQLQ723AJxKcFmJbqXTzxWFURHsvF2cR2CemS7
         6G1Ngi1Mf3iubDjp8y2elwS0n5J11S9qQpivGpUf6ivaRDb2Wym53Jhi/h2TWc3fYC
         jrnVKBluZKmM0HCSNA4GF7f0djMZCzeMNn1w1uDU=
Date:   Tue, 21 Jan 2020 14:53:03 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Matt Porter <mporter@konsulko.com>,
        Arnd Bergmann <arnd@arndb.de>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] dmaengine: Miscellaneous cleanups
Message-ID: <20200121092303.GI2841@vkoul-mobl>
References: <20200117152933.31175-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117152933.31175-1-geert+renesas@glider.be>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 17-01-20, 16:29, Geert Uytterhoeven wrote:
> 	Hi all,
> 
> This patch series contains a few miscellaneous cleanups for the DMA
> engine code and API.

This looks good, thanks for the cleanup. But it fails to apply, can you
please rebase and resend

Thanks
-- 
~Vinod
