Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88B176B6D1
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jul 2019 08:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfGQGmo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 17 Jul 2019 02:42:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:48686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726282AbfGQGmo (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 17 Jul 2019 02:42:44 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE5092173B;
        Wed, 17 Jul 2019 06:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563345763;
        bh=gdDuhx3XH8+TSHfY6ArJLp5Y6SaNs0xxYcyAMFH/vBs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cSCitkGDSY4+BuSrf+dmfLSE7mRzd9XYhEbtmGyeE0CftZrcflTe6SHbBzEyQk72f
         NuMkjdmBKJstGxN9dX4ZgNL/GtiAuPDZJE3+7xsH913J0sP6ZpKAsZxXQjCwGM3p8T
         bmMWqKwSQKuvGPaIHoAwJBsgqAP0XIZPbEQFWzbQ=
Date:   Wed, 17 Jul 2019 14:42:28 +0800
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
Subject: Re: [PATCH v5 13/15] ARM: dts: imx6sll: correct sdma compatible
Message-ID: <20190717064226.GB3738@dragon>
References: <20190610081753.11422-1-yibin.gong@nxp.com>
 <20190610081753.11422-14-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610081753.11422-14-yibin.gong@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Jun 10, 2019 at 04:17:51PM +0800, yibin.gong@nxp.com wrote:
> From: Robin Gong <yibin.gong@nxp.com>
> 
> Correct sdma compatible since ecspi errata ERR009165 has been fixed
> on i.mx6sll as i.mx6ul.
> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>

Applied, thanks.
