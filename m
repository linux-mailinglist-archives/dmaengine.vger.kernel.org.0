Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9C669527A
	for <lists+dmaengine@lfdr.de>; Mon, 13 Feb 2023 21:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjBMU7f (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Feb 2023 15:59:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjBMU7e (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Feb 2023 15:59:34 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844FF3AB0;
        Mon, 13 Feb 2023 12:59:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D23F4CE1D28;
        Mon, 13 Feb 2023 20:59:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 474F6C4339E;
        Mon, 13 Feb 2023 20:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676321969;
        bh=97GwXdgmJT1YSQKnlPR0dKRkb1n6yw9H6kKAtR7Zvck=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=dBtH4iD/rGftLfB+4Ugxh2h3cMKp2Fu7YvesX60QZz+GqO3y8jmSac3OesOb3DDho
         dVBJTW012BvMmyb04Mhw5UpqXcXuMsXLoMdZocFTgbXClr3jYMywTJG36otcYlsV/E
         1ZEEYIG0hx6YUu9Y9BVtmM9p04OQjZ/jo6Kgb4yFsFYIyq1k3e20tAIrhMAVGRwvBc
         Cw0kDAZ6iCo+Ae+udNLzHNYH+2hq1vA2Kb9hFvQsFHxVQ8B5tDsFsT+ZdP+5aKmVWk
         bu4E93TOwu3vrUz9fCkdXJ5CdySntwH3NJzlX1IVE0CmT/7gfGk3Q9noAe5MuwbrWe
         KJCzv7ALApIBQ==
Date:   Mon, 13 Feb 2023 14:59:27 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Cai Huoqing <cai.huoqing@linux.dev>
Cc:     Sergey.Semin@baikalelectronics.ru,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 3/4] dmaengine: dw-edma: Add support for native HDMA
Message-ID: <20230213205927.GA2930625@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213132411.65524-4-cai.huoqing@linux.dev>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Feb 13, 2023 at 09:24:08PM +0800, Cai Huoqing wrote:
> From: Cai huoqing <cai.huoqing@linux.dev>
> 
> Add support for HDMA NATIVE, as long the IP design has set
> the compatible register map parameter-HDMA_NATIVE,
> which allows compatibility for native HDMA register configuration.

Rewrap to fill 75 columns.  Also applies below.

> The HDMA Hyper-DMA IP is an enhancement of the eDMA embedded-DMA IP.
> And the native HDMA registers are different from eDMA,
> so this patch add support for HDMA NATIVE mode.
> 
> HDMA write and read channels operate independently to maximize
> the performance of the HDMA read and write data transfer over
> the link When you configure the HDMA with multiple read channels,
> then it uses a round robin (RR) arbitration scheme to select
> the next read channel to be serviced.
> The same applies when you have multiple write channels.

Wrap into a single paragraph or add a blank line if you want the last
sentence to be a new paragraph.

> The native HDMA driver also supports a maximum of 16 independent
> channels (8 write + 8 read), which can run simultaneously.
> Both SAR (Source Address Register) and DAR (Destination Address Register)
> are alignmented to byte.

s/alignmented/aligned/

> +	u32 watermark_en;			/* 0x0030 */
> +	u32	control1;			/* 0x0034 */
> +	u32	func_num;			/* 0x0038 */
> +	u32	qos;				/* 0x003c */
> +	u32	reserved;			/* 0x0040..0x007c */
> +	u32 ch_stat;				/* 0x0080 */

Weird indentation of control1, func_num, etc.  Is that meaningful or a
mistake?

> +	union {
> +		u64 reg;			/* 0x00a0..0x00a4 */
> +		struct {
> +			u32 lsb;		/* 0x00a0 */
> +			u32 msb;		/* 0x00a4 */
> +		};
> +	} msi_abort;
> +	u32	msi_msgdata;			/* 0x00a8 */

Again here.

Bjorn
