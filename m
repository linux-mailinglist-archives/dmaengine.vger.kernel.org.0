Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E32C27858A
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jul 2019 08:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfG2GyS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 Jul 2019 02:54:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:35664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726900AbfG2GyR (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 29 Jul 2019 02:54:17 -0400
Received: from localhost (unknown [122.178.221.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8639F20644;
        Mon, 29 Jul 2019 06:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564383257;
        bh=gq9+yL77uNFoxeDuWRLkhZsL8qHTXIIL6Xw0KxxfBik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lIKU+HFJG5/8NAY/gl40QYOM42l6ve7SuPfN9VyqJYpXKzXMWsbXkRGqvTQTEd8QP
         cYqA3xqs8btckUVzLkBrYzoui4tpISHuPtBoBibNlXt9ckmxHMZXnLHG/jl+eCdqKZ
         vUesjj/KVsanR5+r8YvxBmaSubGWPk9ltbKxxYEQ=
Date:   Mon, 29 Jul 2019 12:23:04 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Simon Horman <horms+renesas@verge.net.au>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: shdma: Rename bindings documentation file
Message-ID: <20190729065304.GI12733@vkoul-mobl.Dlink>
References: <20190724114946.14021-1-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724114946.14021-1-horms+renesas@verge.net.au>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 24-07-19, 13:49, Simon Horman wrote:
> Rename the bindings documentation file for shdma
> from shdma.txt to renesas,shdma.txt.
> 
> This is part of an ongoing effort to name bindings documentation files for
> Renesas IP blocks consistently, in line with the compat strings they
> document.

Applied, thanks

-- 
~Vinod
