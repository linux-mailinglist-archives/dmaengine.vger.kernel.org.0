Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6FAC24762
	for <lists+dmaengine@lfdr.de>; Tue, 21 May 2019 07:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725793AbfEUFMy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 May 2019 01:12:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:58566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbfEUFMy (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 21 May 2019 01:12:54 -0400
Received: from localhost (unknown [106.201.107.13])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D867D21743;
        Tue, 21 May 2019 05:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558415573;
        bh=yRdHJ2XmIK1WbEUMMgmxiCl4z/bvxpUafqfuQkwnoXY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LVwjL/13xrfaEJ6AUBwZQFm+fa/btvzfRm/Y8CBLxx/5AoMRHbrbnsRRTHdWq8A+B
         6T40TTcYmIo6qFDmhzoTdegDWImPKepEQAkT+lfqy2H7mC97xyNji7IBtdE04bEq1u
         quivMZvg2u2AG9QBormnpyQNetqMXa1KkJD1lM3A=
Date:   Tue, 21 May 2019 10:42:50 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     "robh@kernel.org" <robh@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: Re: [PATCH v3 11/14] dmaengine: imx-sdma: fix ecspi1 rx dma not
 work on i.mx8mm
Message-ID: <20190521051250.GY15118@vkoul-mobl>
References: <VI1PR04MB45436C98D70C16635CF3CFDE89070@VI1PR04MB4543.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <VI1PR04MB45436C98D70C16635CF3CFDE89070@VI1PR04MB4543.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 21-05-19, 04:58, Robin Gong wrote:
> > -----Original Message-----
> > From: Vinod Koul <vkoul@kernel.org>
> > Sent: 2019年5月21日 12:18
> > 
> > On 07-05-19, 09:16, Robin Gong wrote:
> > > Because the number of ecspi1 rx event on i.mx8mm is 0, the condition
> > > check ignore such special case without dma channel enabled, which
> > > caused
> > > ecspi1 rx works failed. Actually, no need to check event_id0, checking
> > > event_id1 is enough for DEV_2_DEV case because it's so lucky that
> > > event_id1 never be 0.
> > 
> > Well is that by chance or design that event_id1 will be never 0?
> > 
> That's by chance. DEV_2_DEV is just for Audio case and non-zero for event_id1 on current i.MX family.

Then it wont be fgood to rely on chance :)

-- 
~Vinod
