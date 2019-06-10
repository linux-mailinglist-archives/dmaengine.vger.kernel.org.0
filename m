Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6C603AFFF
	for <lists+dmaengine@lfdr.de>; Mon, 10 Jun 2019 09:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387900AbfFJHwT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 10 Jun 2019 03:52:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:37322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387781AbfFJHwT (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 10 Jun 2019 03:52:19 -0400
Received: from localhost (unknown [122.178.227.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C564320833;
        Mon, 10 Jun 2019 07:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560153138;
        bh=566FEgM500jFgUolDFJN/nCKjh9VN430drBBkiugyDI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ehNyv2lYb3LkmeSqt825HagV+Gtej25o1/2z8dP95DuBZROWrlvrcbKbkXhGsborm
         2i+xa4yUONZxd6SRVfOLWUNCDD548P3d/jJ3+qq4UHD2gutnfgr3mQcR2jsx//krsv
         UFSdQpnXMIGlyLQiT//1BebXQBSNxMCS30NjlGyQ=
Date:   Mon, 10 Jun 2019 13:19:10 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: axi-dmac: update license header
Message-ID: <20190610074910.GN9160@vkoul-mobl.Dlink>
References: <20190606105344.3405-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606105344.3405-1-alexandru.ardelean@analog.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 06-06-19, 13:53, Alexandru Ardelean wrote:
> The change replaces the old license information in the comment header with
> the new SPDX license specifier.
> As well as bumping the year range from 2013-2015 to 2013-2019.
> 
> The latter also reflects recent changes that were added to the driver.

Applied, thanks

-- 
~Vinod
