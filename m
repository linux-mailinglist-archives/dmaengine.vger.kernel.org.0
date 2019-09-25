Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C51FFBE643
	for <lists+dmaengine@lfdr.de>; Wed, 25 Sep 2019 22:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfIYUW1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 25 Sep 2019 16:22:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:42480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727102AbfIYUW0 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 25 Sep 2019 16:22:26 -0400
Received: from localhost (unknown [12.206.46.62])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0323221D7A;
        Wed, 25 Sep 2019 20:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569442946;
        bh=FeWdANdyaCOkftp2qJmI4f+6S0li6x65GitPCqwsNBY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jfeUw/WsvDm+BMsG27ObR5RZMSSduonTDjxMfHph/YRMtzfJTTohGixtshD3r5I15
         iDPw8kS11ruB0nku9cocJjspIabC2AC0EnW7rrd+1fQPgrLdLb7xJWzFI/G4rb1/Vf
         PGK7gCK0o/YnRcdxl4U7iIlng+WCjaRkkPBDdO4I=
Date:   Wed, 25 Sep 2019 13:21:25 -0700
From:   Vinod Koul <vkoul@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dmaengine: uniphier-mdmac: use
 devm_platform_ioremap_resource()
Message-ID: <20190925202125.GI3824@vkoul-mobl>
References: <20190905034133.29514-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905034133.29514-1-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 05-09-19, 12:41, Masahiro Yamada wrote:
> Replace the chain of platform_get_resource() and devm_ioremap_resource()
> with devm_platform_ioremap_resource().
> 
> This allows to remove the local variable for (struct resource *), and
> have one function call less.

Applied, thanks

-- 
~Vinod
