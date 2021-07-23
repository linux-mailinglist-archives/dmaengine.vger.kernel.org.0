Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 796033D3232
	for <lists+dmaengine@lfdr.de>; Fri, 23 Jul 2021 05:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbhGWCk3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 22 Jul 2021 22:40:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:58182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233459AbhGWCk3 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 22 Jul 2021 22:40:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2CDB760E74;
        Fri, 23 Jul 2021 03:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627010463;
        bh=TkGSmL7/KKxewmFkRjaFIwQ3Fq+1SkoEmyPTlz0kCqQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uOspOOUbUL6HJUQyNuEsXGRd+FUxMXAqCPXK/xrGebH0WKzkU5PCCg1K+o7IPV9jB
         Mnwoe3gbTJ1K/lf18JrEZL6H3Y3y42T66h9HQNrZIEJtBIAW4MHHtd6DxhqTPAYBy1
         h7fQTQqdamIQ4mkLKguo0TpjXS12JtdCPGT/STdkaalyZRe+PEo6LGxlac1vzmhxt+
         2kuQ8OaVE3MQN04mveI0QydDaYTf/wXJ1Dl8F9o1IWfAiAl6n14nDpNdphLXmqkWCZ
         EAdija2Cz3ne6AXZilExbFKYlkTaiU6P1wAN599vChw59D/QJ6OFn/jOztfTKHvh7X
         mVrO3mYcoj2nA==
Date:   Fri, 23 Jul 2021 11:20:55 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     vkoul@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        robh+dt@kernel.org, catalin.marinas@arm.com, will.deacon@arm.com,
        festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com,
        frieder.schrempf@kontron.de, m.felsch@pengutronix.de,
        l.stach@pengutronix.de, xiaoning.wang@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v16 00/12] add ecspi ERR009165 for i.mx6/7 soc family
Message-ID: <20210723032054.GH28658@dragon>
References: <1626258052-22198-1-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1626258052-22198-1-git-send-email-yibin.gong@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Jul 14, 2021 at 06:20:40PM +0800, Robin Gong wrote:
> Robin Gong (12):
>   Revert "ARM: dts: imx6q: Use correct SDMA script for SPI5 core"
>   Revert "ARM: dts: imx6: Use correct SDMA script for SPI cores"
>   Revert "dmaengine: imx-sdma: refine to load context only once"
>   dmaengine: imx-sdma: remove duplicated sdma_load_context
>   dmaengine: dma: imx-sdma: add fw_loaded and is_ram_script
>   dmaengine: imx-sdma: add mcu_2_ecspi script
>   spi: imx: fix ERR009165
>   spi: imx: remove ERR009165 workaround on i.mx6ul
>   dmaengine: imx-sdma: remove ERR009165 on i.mx6ul
>   dma: imx-sdma: add i.mx6ul compatible name
>   dmaengine: imx-sdma: add uart rom script
>   dmaengine: imx-sdma: add terminated list for freed descriptor in
>     worker

Applied all, thanks!
