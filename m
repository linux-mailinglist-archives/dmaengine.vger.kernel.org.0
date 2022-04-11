Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653774FBA11
	for <lists+dmaengine@lfdr.de>; Mon, 11 Apr 2022 12:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345595AbiDKKul (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Apr 2022 06:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243363AbiDKKuk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Apr 2022 06:50:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6F643393;
        Mon, 11 Apr 2022 03:48:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EDCD2B811F2;
        Mon, 11 Apr 2022 10:48:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD17CC385A3;
        Mon, 11 Apr 2022 10:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649674101;
        bh=ZUdz7fw+5Vlb3RKQ1h6dy1j8KMKHNLEbcvkUQ62y9dU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MvHNM0g3lXNBE9kUihn7J/tLkDXOJDj5L3QqW1SCSCqaklApC1LDaHpZmmMCQ8kJ7
         +m1XpCKi8FZdg+ja3B68s8m0RXwy6Qs6kkkMvUTkpQ0NW8ltkHV549/JqD6SbGphs1
         aLXW1cVnF0rfODlnxPGPJl89d6CHXzs/ZsAI1Y3avgER5guSg0r4hGzKKnMD78KHgE
         63v8O6X+jGnBdEEjfMGWVNm3EQn2IAJTBnudZQg2qN0j9TfRevTwJdBM5XLzL/r3np
         qTJaCbBdwMm54Vp8TWzwTxoTaN/PsdoxEeXRDf43TXSG/4PkbQbVzasJTRR7OqrrDT
         zoEDcewEIyy9A==
Date:   Mon, 11 Apr 2022 16:18:16 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Kevin Groeneveld <kgroeneveld@lenbrook.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: imx-sdma: fix init of uart scripts
Message-ID: <YlQHcAwd1DUGJGgz@matsya>
References: <20220410223118.15086-1-kgroeneveld@lenbrook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220410223118.15086-1-kgroeneveld@lenbrook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 10-04-22, 18:31, Kevin Groeneveld wrote:
> Commit b98ce2f4e32b ("dmaengine: imx-sdma: add uart rom script") broke
> uart rx on imx5 when using sdma firmware from older Freescale 2.6.35
> kernel. In this case reading addr->uartXX_2_mcu_addr was going out of
> bounds of the firmware memory and corrupting the uart script addresses.
> 
> Simply adding a bounds check before accessing addr->uartXX_2_mcu_addr
> does not work as the uartXX_2_mcu_addr members are now beyond the size
> of the older firmware and the uart addresses would never be populated
> in that case. There are other ways to fix this but overall the logic
> seems clearer to me to revert the uartXX_2_mcu_ram_addr structure
> entries back to uartXX_2_mcu_addr, change the newer entries to
> uartXX_2_mcu_rom_addr and update the logic accordingly.
> 
> I have tested this patch on:
> 1. An i.MX53 system with sdma firmware from Freescale 2.6.35 kernel.
>    Without this patch uart rx is broken in this scenario, with the
>    patch uart rx is restored.
> 2. An i.MX6D system with no external sdma firmware. uart is okay with
>    or without this patch.
> 3. An i.MX8MM system using current sdma-imx7d.bin firmware from
>    linux-firmware. uart is okay with or without this patch and I
>    confirmed the rom version of the uart script is being used which was
>    the intention and reason for commit b98ce2f4e32b ("dmaengine:
>    imx-sdma: add uart rom script") in the first place.

Applied, thanks

-- 
~Vinod
