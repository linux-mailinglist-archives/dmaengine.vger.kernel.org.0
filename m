Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2026B6EA
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jul 2019 08:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfGQGsS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 17 Jul 2019 02:48:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:58286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbfGQGsS (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 17 Jul 2019 02:48:18 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 324A42173B;
        Wed, 17 Jul 2019 06:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563346097;
        bh=8TSSlUu25GjlJzJHNZqy/p5YiZiWAHnMkii3qUW77U4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D0LpctmEwrX5bVBj5X7YXhz67Pxjo1xVya1Hf9znqpNoxiieBGTu5Y2WbceKpJUEd
         TKYZIIp1j+bC4beGFn+jeJoS7H0C/8XkjhCNEccoOKibeYPTddnITwtrR6yhP/cG8x
         LSS+8R7QWlz2u3K7HKNK+29Pdw25isOSbybb6omU=
Date:   Wed, 17 Jul 2019 14:48:02 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     yibin.gong@nxp.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, broonie@kernel.org, festevam@gmail.com,
        vkoul@kernel.org, dan.j.williams@intel.com,
        u.kleine-koenig@pengutronix.de, catalin.marinas@arm.com,
        l.stach@pengutronix.de, will.deacon@arm.com,
        linux-spi@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 14/15]  arm64: defconfig: Enable SDMA on i.mx8mq/8mm
Message-ID: <20190717064800.GC3738@dragon>
References: <20190610081753.11422-1-yibin.gong@nxp.com>
 <20190610081753.11422-15-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610081753.11422-15-yibin.gong@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Jun 10, 2019 at 04:17:52PM +0800, yibin.gong@nxp.com wrote:
> From: Robin Gong <yibin.gong@nxp.com>
> 
> Enable SDMA support on i.mx8mq/8mm chips, including enabling
> CONFIG_FW_LOADER_USER_HELPER/CONFIG_FW_LOADER_USER_HELPER_FALLBACK
> for firmware loaded by udev.
> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>

Applied, thanks.
