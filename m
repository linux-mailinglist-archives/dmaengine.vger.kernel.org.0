Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7B81ADC87
	for <lists+dmaengine@lfdr.de>; Fri, 17 Apr 2020 13:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730436AbgDQLxl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Apr 2020 07:53:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:52882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730410AbgDQLxl (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 17 Apr 2020 07:53:41 -0400
Received: from localhost (unknown [223.235.195.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 046C920780;
        Fri, 17 Apr 2020 11:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587124420;
        bh=c/rbJdi4bYdAFafdhrDilNV10AtbkTU0xeSBWfYgwCk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v5JT95G9uSRzM2zf7VY5lVEZD95zWBnXQH5XfR2a3Y6LqF/0Y7YDGMBreJtaTT8Ic
         bjiayscEPlzYfF2mqYo7prUsQ1ry/1i8ysf3StEqOMNuEX1T7RQ3wIkuAxPIqMf65E
         0h6ExThYl2PUDh9keQqkDPpXEP+TTe0/2z34X8kY=
Date:   Fri, 17 Apr 2020 17:23:36 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     robh+dt@kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3 0/2] dt-bindings: dma: renesas,{rcar,usb}-dmac:
 convert to json-schema
Message-ID: <20200417115336.GN72691@vkoul-mobl>
References: <1587110829-26609-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587110829-26609-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 17-04-20, 17:07, Yoshihiro Shimoda wrote:
> This patch series converts rcar-dmac and usb-dmac documantation to
> json-schema.

Applied, thanks

-- 
~Vinod
