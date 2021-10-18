Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4ED4310CC
	for <lists+dmaengine@lfdr.de>; Mon, 18 Oct 2021 08:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbhJRGs3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 18 Oct 2021 02:48:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:56346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230006AbhJRGsZ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 18 Oct 2021 02:48:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC31860F22;
        Mon, 18 Oct 2021 06:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634539574;
        bh=OGxIj6fUXR57qZl93oH0SgIGgyRDGE4htr4GhpWrAQQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g/BE4X6je8/B4L3JvcygUJPgPmJDNjmYXydHNIxPKPLqYDFuxsec23Q0a0ugcEzp6
         ZOM1FGdXB4uZDRntMKVF7nFcnEoQYVkgmBO8VnKdxCU/z4Bv4e+Um2oP1sq7C6Eek3
         ChrrgNvK/NlYgAYnWTFNWbvJtMccKuaaZTtiIW7Jwf/U9ECNV2CgjkjT6dX/eYrS+I
         rM78dbCincuhi8EWy32kbQMMsw0lIGphLBgIKvPTTby7VWv+/BUCoy3pIGQdWh0Xbx
         qqzyz4yZYFGxmaK7NB8Pp2gfG0RdkRVoDx6WHwuim+izsK5rtjQZy7pgoqqzjkWUFY
         XOJNGhNLnS3JA==
Date:   Mon, 18 Oct 2021 12:16:10 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dmaengine: imx-sdma: remove useless braces
Message-ID: <YW0YMrHDuBVH37eN@matsya>
References: <20210928151833.589843-1-f.suligoi@asem.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928151833.589843-1-f.suligoi@asem.it>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 28-09-21, 17:18, Flavio Suligoi wrote:
> Braces {} are not necessary for single statement blocks.

Nice cleanup, well described and split patches!

Applied all, thanks

-- 
~Vinod
