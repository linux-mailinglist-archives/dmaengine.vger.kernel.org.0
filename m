Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 165A2701FB
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jul 2019 16:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbfGVONy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Jul 2019 10:13:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:50824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727880AbfGVONy (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 22 Jul 2019 10:13:54 -0400
Received: from localhost (unknown [223.226.98.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD30921911;
        Mon, 22 Jul 2019 14:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563804833;
        bh=b4iTL+3agj7PdCdScIUEXy95wqTx7S+Qv3Dd4gllawk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eyU0TbjkLPjAt4SKfuS+Oy2g29st+OImzk3jxkbNVHbnCXheuvi9j/H5VgAjS9b9I
         lgkyLvQ0q+ytR4rjQnJRJml0i1R9Z/6g2q13TUNUPrvJm7f0aktVS3Sei390FQ0Dfc
         gyqkdZuJOpJ66NWOODc3HNZDmt4y4VCGU+x3YVAg=
Date:   Mon, 22 Jul 2019 19:42:40 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH 1/2] [RESEND] dmaengine: omap-dma: make
 omap_dma_filter_fn private
Message-ID: <20190722141240.GT12733@vkoul-mobl.Dlink>
References: <20190722081705.2084961-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722081705.2084961-1-arnd@arndb.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 22-07-19, 10:16, Arnd Bergmann wrote:
> With the audio driver no longer referring to this function, it
> can be made private to the dmaengine driver itself, and the
> header file removed.
> 
> Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Link: https://lore.kernel.org/lkml/20190307151646.1016966-1-arnd@arndb.de/

This seems to point to older rev, my script updated it to latest one.

Applied both, thanks
-- 
~Vinod
