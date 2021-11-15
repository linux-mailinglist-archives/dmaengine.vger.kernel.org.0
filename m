Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E633F4501D5
	for <lists+dmaengine@lfdr.de>; Mon, 15 Nov 2021 10:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237215AbhKOJ6x (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 15 Nov 2021 04:58:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:46708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236975AbhKOJ6u (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 15 Nov 2021 04:58:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 30E7861BF8;
        Mon, 15 Nov 2021 09:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636970151;
        bh=zO8rrj1Vi14Uipx7unEIoASJvIGIajWvOMxp9QEDdrg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=pS0ejTv+o5S0A78mbmJ7yuvuLRvB9d4xUmNuDZkoNE6OFFDakUf4rUvAzBprhdror
         c/bShp5CLYeQozZylztfdFxkqVWVq+5ygYNbn+4A0s2ze6/IhIUKtVg/V7FX57xSK9
         o+TBkdXts4C2lwVOyzZSJbu6XtvG/R75Me0SQNeR4Q87t1+Qhokvme1DEyAn+zBc7+
         nJMjetgrrqNxHehwqI7KLrMF3IzGgf4PNgOkpTsytZe7548iWlWgbHxmlfyaqoC8CS
         sUf/B2fdljsPIZbKzs7tinYeZ8/8ttY26uNUOwdT55UgKOo0wK/ocgfuCEg3N311BC
         phUkTUj1HGMig==
Message-ID: <b04bb9803d59d26e4f32adc9518d0ec1a9456273.camel@kernel.org>
Subject: Re: [PATCH 03/11] mmc: bcm2835: stop setting chan_config->slave_id
From:   nicolas saenz julienne <nsaenz@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andy Gross <agross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jon Hunter <jonathanh@nvidia.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Scott Branden <sbranden@broadcom.com>,
        Takashi Iwai <tiwai@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        alsa-devel@alsa-project.org, bcm-kernel-feedback-list@broadcom.com,
        dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-tegra@vger.kernel.org
Date:   Mon, 15 Nov 2021 10:55:42 +0100
In-Reply-To: <20211115085403.360194-4-arnd@kernel.org>
References: <20211115085403.360194-1-arnd@kernel.org>
         <20211115085403.360194-4-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, 2021-11-15 at 09:53 +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The field is not interpreted by the DMA engine driver, as all the data
> is passed from devicetree instead. Remove the assignment so the field
> can eventually be deleted.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Reviewed-by: Nicolas Saenz Julienne <nsaenz@kernel.org>

Regards,
Nicolas

