Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA3815C0F9
	for <lists+dmaengine@lfdr.de>; Thu, 13 Feb 2020 16:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbgBMPFj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 13 Feb 2020 10:05:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:51156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726937AbgBMPFi (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 13 Feb 2020 10:05:38 -0500
Received: from localhost (unknown [106.201.58.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 682572073C;
        Thu, 13 Feb 2020 15:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581606338;
        bh=8h7ApCXX+TXuCTnHuQ6rL7GF7/ZIetlNjEEQZpp7WHE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U6tGLeaXMxUc18bxn0djoZdpPEafEFmdDJIovTwv85769BECoLGYFD6ffcEwtIyYq
         pcjajZ1W7l5MnjmDsf4sVfhvCit7rXanJRKwMF9j7FvKXpSaTE5B/bAGJ9Y7himYTy
         +uL0f3IW4CwLcvNPfSGrV38SVXjMbUm1J9oMPaLY=
Date:   Thu, 13 Feb 2020 20:35:33 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, dmaengine@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: doc: fix warnings/issues of client.rst
Message-ID: <20200213150533.GO2618@vkoul-mobl>
References: <20200204125115.12128-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204125115.12128-1-changbin.du@gmail.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 04-02-20, 20:51, Changbin Du wrote:
> This fixed some warnings/issues of client.rst.
>  o Need a blank line for enumerated lists.
>  o Do not create section in enumerated list.
>  o Remove suffix ':' from section title.

Applied, thanks

-- 
~Vinod
