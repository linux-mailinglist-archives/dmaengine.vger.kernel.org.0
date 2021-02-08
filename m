Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 682BD312B21
	for <lists+dmaengine@lfdr.de>; Mon,  8 Feb 2021 08:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbhBHHe5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 8 Feb 2021 02:34:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:33632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229751AbhBHHez (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 8 Feb 2021 02:34:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7A22F64DDD;
        Mon,  8 Feb 2021 07:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612769653;
        bh=7TyKKVr8AyUm1jsKCCtx7TX3UogGf1VLNtMdZYu55qE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G7Az6K0blie4qbk6W+OmSAiRBXBb8s7jK2ZlbGUgcxaOOYHekFQSTz4Nc+kDQDyuO
         nYA3EpuafmQgO0KeOfVCJqxEqbXbLaZTV9T+GkcOgjgKZJBZU6hdpKpPTBsY3iDP77
         f+7IC5MVo827j341lOJ4noltUFLzjvqnmMTymdmMWDUXFALU80TQYtU/wm3rD9B4kZ
         7nB81Wt1nVraPRFkzsXQzfF+iBsB3Dnsm58LcymzfT01DBpp8mQOth49kuge3GL9Tz
         YheMG1xMXpA31Et5OftgIVV9o6FlZaa7PxngODydq+KBsKQHx3Eg0VMn3Kjb5P0tfH
         X1Z30lWzamknw==
Date:   Mon, 8 Feb 2021 09:34:08 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [RESEND PATCH v3 3/5] misc: Add Synopsys DesignWare xData IP
 driver to Kconfig
Message-ID: <20210208073408.GC4656@unreal>
References: <cover.1612284945.git.gustavo.pimentel@synopsys.com>
 <850ba8b075a65f753bbb802b9af23839624908bd.1612284945.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <850ba8b075a65f753bbb802b9af23839624908bd.1612284945.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Feb 02, 2021 at 05:56:36PM +0100, Gustavo Pimentel wrote:
> Add Synopsys DesignWare xData IP driver to Kconfig.
>
> This driver enables/disables the PCIe traffic generator module
> pertain to the Synopsys DesignWare prototype.
>
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
>  drivers/misc/Kconfig | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index fafa8b0..6d5783f 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -423,6 +423,17 @@ config SRAM
>  config SRAM_EXEC
>  	bool
>
> +config DW_XDATA_PCIE
> +	depends on PCI
> +	tristate "Synopsys DesignWare xData PCIe driver"
> +	default	n

"N" is a default option and not needed to be stated explicitly.

Thanks
