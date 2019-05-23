Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91CDC27588
	for <lists+dmaengine@lfdr.de>; Thu, 23 May 2019 07:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbfEWFfH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 May 2019 01:35:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:40194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725786AbfEWFfH (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 23 May 2019 01:35:07 -0400
Received: from localhost (unknown [122.167.116.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA71820881;
        Thu, 23 May 2019 05:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558589706;
        bh=axoFYG+Ewq4P5tKjbxbISXb6YfmQNDHpVw2dJGFc954=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bOWOSmD2i59EAn8qv2c2koqfOlVadTTmuQ4MnCpL4LVwqUJNOReOP/tQ7pGRtxI7F
         IOeCTIR+iMN671PifxwpfqUjP1b0Y2hCPJ3pomtULk+wIg5iVrg0aZQp14P3S5rtkI
         c6QbUl8TLEViprRBJ4rQR9wFq2uG6gATwE95NuJg=
Date:   Thu, 23 May 2019 11:04:33 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     "robh@kernel.org" <robh@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v4 11/14] dmaengine: imx-sdma: fix ecspi1 rx dma not work
 on i.mx8mm
Message-ID: <20190523053433.GU15118@vkoul-mobl>
References: <1558548188-1155-1-git-send-email-yibin.gong@nxp.com>
 <1558548188-1155-12-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558548188-1155-12-git-send-email-yibin.gong@nxp.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 22-05-19, 10:00, Robin Gong wrote:
> Because the number of ecspi1 rx event on i.mx8mm is 0, the condition
> check ignore such special case without dma channel enabled, which caused
> ecspi1 rx works failed. Actually, no need to check event_id0/event_id1
> and replace checking 'event_id1' with 'DMA_DEV_TO_DEV', so that configure
> event_id1 only in case DEV_TO_DEV.

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
