Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D56C911802A
	for <lists+dmaengine@lfdr.de>; Tue, 10 Dec 2019 07:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbfLJGGN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Dec 2019 01:06:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:52338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfLJGGN (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 10 Dec 2019 01:06:13 -0500
Received: from localhost (unknown [106.201.45.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B48E20652;
        Tue, 10 Dec 2019 06:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575957972;
        bh=7jrlVMx0ZzN8zh1j+zKOid+hTzkpiUjgtIFq4JSpg6I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ucQdf7FkoTg2736i3S9t5VD2PhKieI8Q8tXbvLnZ6AyrjXkUoVI/BQxM030+TQzSh
         NsiMdS5s90672ZogBXyNWkVA7C3Th101EqPWnUkbffMw+Ys7QJz3qJHJx/LkZzu7ps
         HAqM2s16ENGnXa/U3nL5678vjZABI7nvYINhU9Ck=
Date:   Tue, 10 Dec 2019 11:36:08 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: dmaengine: rcar-dmac: Document r8a77961
 support
Message-ID: <20191210060608.GR82508@vkoul-mobl>
References: <20191205133736.5934-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205133736.5934-1-geert+renesas@glider.be>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 05-12-19, 14:37, Geert Uytterhoeven wrote:
> Document support for the system DMA controller in the Renesas R-Car
> M3-W+ (R8A77961) SoC.

Applied, thanks

-- 
~Vinod
