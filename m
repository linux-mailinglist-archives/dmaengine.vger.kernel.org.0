Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93AF8458896
	for <lists+dmaengine@lfdr.de>; Mon, 22 Nov 2021 05:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbhKVEXz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 21 Nov 2021 23:23:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:40242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231375AbhKVEXz (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 21 Nov 2021 23:23:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6087F60231;
        Mon, 22 Nov 2021 04:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637554849;
        bh=B7KD529cvJfaNs5780+0sXyIgYGBNJj1081GK2QN5ew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OphBsWCD1ZE0MiYHDdC4iVA74iiWQNylTkXwEFhKLhvpCEOZZHH9imCTzSS2RKu+4
         n+LuX50N6Bf2iO+SLYlQHvbklCyiRrzAreNmF9kYackZlf0sUq2Pxw5ojA3MvGv7vK
         nvSBLfp/cJCfYeH+mI0SgNVKRQjaI1MkCqRBiri1lTfBSJ9Za9fzqflNh9G02rccPY
         BOuCwEEnWfqBi56yzx2/fkVWQwJHecHJsZMoLPtQLZ+xWW8fFvS4JR8P2mN3OX/QX4
         Iyg3pKagge7YPPKbeM4eABlcP2MRNIyO+E2QIxcFEWsQFMgBQ6wnhXnRQ6gu/jYTFQ
         xJrcERw9fZhpQ==
Date:   Mon, 22 Nov 2021 09:50:44 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     peter.ujfalusi@gmail.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] dmaengine: ti: edma: Use 'for_each_set_bit' when possible
Message-ID: <YZsanLUxiFpfVjZx@matsya>
References: <47a7415d3aff8dfb66780bd6f80b085db4503bf7.1637263609.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47a7415d3aff8dfb66780bd6f80b085db4503bf7.1637263609.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 18-11-21, 20:28, Christophe JAILLET wrote:
> Use 'for_each_set_bit()' instead of hand wrinting it. It is much less
> version.

Applied, thanks

-- 
~Vinod
