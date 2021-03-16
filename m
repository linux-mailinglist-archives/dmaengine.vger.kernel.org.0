Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3E9533DAF9
	for <lists+dmaengine@lfdr.de>; Tue, 16 Mar 2021 18:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbhCPR3Q (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 16 Mar 2021 13:29:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:33270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238412AbhCPR3M (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 16 Mar 2021 13:29:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A089650CD;
        Tue, 16 Mar 2021 17:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615915752;
        bh=OIf1+FsV0wFNku7MnqunYcYLg0R4sm6sZwIlRyaahiY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VlGdS6dsJHOQWs2JzQocZ/2a4t1racggPnJzi1FSKeEiCw/KeJTH7iDmigr9tAqY9
         Fic03EfiKHeQrMGJUswBPu6Cz+5X5jXaPsSB1hxsz/xf7JVKmIFj4bIsB2pbHF5R2v
         AYOw10DqXq5nDvVAEoNyaXOJUWP5UsnG+ywE/Df4SZzhGJmP2D6lcsUrWDCd1/Bw91
         wLBCSTBOVRtV8TyvL5fb0qsNYj7U7Pd8nRj3ve3M+m+rBxt9LE8hlkBX5o6aTp46t/
         GDW93zHxQqz8Nq+jDX4JSgWPgIyQEIEINTOrrU56z58kXijDaaRExFPq6vMpPP9Ay/
         gieo6O+oBxdvw==
Date:   Tue, 16 Mar 2021 22:59:07 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v7 00/15] dmaengine: dw-edma: HDMA support
Message-ID: <YFDq41YjkZ9V5Gl3@vkoul-mobl>
References: <cover.1613674948.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1613674948.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 18-02-21, 20:03, Gustavo Pimentel wrote:
> This patch series adds the HDMA support, as long the IP design has set
> the compatible register map parameter, which allows compatibility at
> some degree for the existing Synopsys DesignWare eDMA driver that is
> already available on the Kernel.
> 
> The HDMA "Hyper-DMA" IP is an enhancement of the eDMA "embedded-DMA" IP.
> 
> This new improvement comes with a PCI DVSEC that allows to the driver
> recognize and switch behavior if it's an eDMA or an HDMA, becoming
> retrocompatible, in the absence of this DVSEC, the driver will assume
> that is an eDMA IP.
> 
> It also adds the interleaved support, since it will be similar to the
> current scatter-gather implementation.
> 
> As well fixes/improves some abnormal behaviors not detected before, such as:
>  - crash on loading/unloading driver
>  - memory space definition for the data area and for the linked list space
>  - scatter-gather address calculation on 32 bits platforms
>  - minor comment and variable reordering

Applied, thanks

-- 
~Vinod
