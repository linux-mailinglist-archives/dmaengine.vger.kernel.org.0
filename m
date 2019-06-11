Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76D593C266
	for <lists+dmaengine@lfdr.de>; Tue, 11 Jun 2019 06:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389646AbfFKEkn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 11 Jun 2019 00:40:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:39198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387997AbfFKEkn (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 11 Jun 2019 00:40:43 -0400
Received: from localhost (unknown [171.76.113.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FE6420679;
        Tue, 11 Jun 2019 04:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560228041;
        bh=J+Fxwsu/pcO3dKxlhALAnqXUVlSrG6+hNYmkU8z96/k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BvIvIzbhIKxLViV93wTgAmxFPFW53sBYOXcFngdkrZKFycty0CqODbe9uLLv1n0eb
         kkV29qHCkdug7QO0tqDin/Nn2fjCrAeYpWNFNaVY2I0sWznaCrZnWT920pLt8eU9ns
         gqvHcC7n/PLIvlx0dETE9mz9TFJS1vT/sUp4E+Co=
Date:   Tue, 11 Jun 2019 10:07:31 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: Re: [PATCH v5 15/15] dmaengine: imx-sdma: add uart rom script
Message-ID: <20190611043731.GS9160@vkoul-mobl.Dlink>
References: <20190610081753.11422-1-yibin.gong@nxp.com>
 <20190610081753.11422-16-yibin.gong@nxp.com>
 <20190610125534.GQ9160@vkoul-mobl.Dlink>
 <1560251269.9731.41.camel@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560251269.9731.41.camel@nxp.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 11-06-19, 03:04, Robin Gong wrote:
> On 2019-06-10 at 12:55 +0000, Vinod Koul wrote:
> > On 10-06-19, 16:17, yibin.gong@nxp.com wrote:
> > > 
> > > From: Robin Gong <yibin.gong@nxp.com>
> > > 
> > > For the compatibility of NXP internal legacy kernel before 4.19
> > > which
> > > is based on uart ram script and upstreaming kernel based on uart
> > > rom
> > > script, add both uart ram/rom script in latest sdma firmware. By
> > > default
> > > uart rom script used.
> > > Besides, add two multi-fifo scripts for SAI/PDM on i.mx8m/8mm and
> > > add
> > > back qspi script miss for v4(i.mx7d/8m/8mm family, but v3 is for
> > > i.mx6).
> > > 
> > > rom script:
> > > 	uart_2_mcu_addr
> > > 	uartsh_2_mcu_addr /* through spba bus */
> > > ram script:
> > > 	uart_2_mcu_ram_addr
> > > 	uartsh_2_mcu_ram_addr /* through spba bus */
> > > 
> > > Please get latest sdma firmware from the below and put them into
> > > the path
> > > (/lib/firmware/imx/sdma/):
> > > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fg
> > > it.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ffirmware%2Flinux
> > > -firmware.git&amp;data=02%7C01%7Cyibin.gong%40nxp.com%7C6a7833e8a09
> > > 344d9951e08d6eda35fc5%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C
> > > 636957683278190279&amp;sdata=RHeypEOREiPGmKveg6gYPy%2FMg8Dzz4JpcHsm
> > > %2Bbdxlzo%3D&amp;reserved=0
> > > /tree/imx/sdma
> > How does this work with folks have older firmware?
> The older SDMA RAM script(firmware) will break the uart driver of
> upstreaming kernel for these years, this is why Lucas raise uart driver
> patch (commit 905c0decad28) to use ROM script instead. There are two
> ways to fix uart issue: one is checking 'Idle Condition
> Detection'/'Aging timer' in RAM script and enable 'IDLE' in uart
> driver, another is only checking 'Aging timer' in ROM script and
> adjusting RX FIFO burst length one word less to ensure at least one
> word left forever in RX FIFO which is the trigger requirement of 'Aging
> timer'(So no need 'IDLE', 'Aging time' is enough) . FSL/NXP internal
> kernel go with the first option, while upstreaming kernel go with the
> second. Since Lucas's patch assume ROM script used in kernel and
> disable 'IDLE', upstreaming kernel broken in uart driver with older
> firmware for these years. So this patch is just for fix this
> compatibility issue with the ram script(older firmware) updated in
> linux-firmware(done already.), thus both RAM script and ROM script can
> work in kernel. Besides, kernel with the latest RAM firmware and this
> patch set can workaround ecspi issue without any function break which
> Lucas concerned about.

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
