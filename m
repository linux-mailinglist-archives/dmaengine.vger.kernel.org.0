Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 021F2D7306
	for <lists+dmaengine@lfdr.de>; Tue, 15 Oct 2019 12:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730318AbfJOKTW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Oct 2019 06:19:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:39602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729923AbfJOKTU (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 15 Oct 2019 06:19:20 -0400
Received: from localhost (unknown [171.76.96.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4D0E217F9;
        Tue, 15 Oct 2019 10:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571134759;
        bh=LVAubQ5a4tx6kJZJZxy2deaudXFrQruZncCOv4L38Mc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eq+Kcnom8n08MOw6Tu5+4FF+hrx6aSgIUwLuwIGc1H3goH3rgQNwA5srrcWaXrnPc
         Ujnb5hUX9a6V6glWMH2ljcibvyplBruPDS/vTjpfJy4XuDWtFC2+SRITOesr27mCcV
         OjO7Kwd/z/mA8ifT6WbtvRkVqtAQjjOCdCbaWTfQ=
Date:   Tue, 15 Oct 2019 15:49:14 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
Subject: Re: [PATCH 02/10] dt-bindings: dmaengine: usb-dmac: Add binding for
 r8a774b1
Message-ID: <20191015101914.GT2654@vkoul-mobl>
References: <1570531132-21856-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1570531132-21856-3-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570531132-21856-3-git-send-email-fabrizio.castro@bp.renesas.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 08-10-19, 11:38, Fabrizio Castro wrote:
> This patch adds the binding for r8a774b1 SoC (RZ/G2N).

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
