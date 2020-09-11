Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAB3265F70
	for <lists+dmaengine@lfdr.de>; Fri, 11 Sep 2020 14:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725780AbgIKMWP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Sep 2020 08:22:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:60534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbgIKMSq (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 11 Sep 2020 08:18:46 -0400
Received: from localhost (unknown [122.171.196.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40B5F21D40;
        Fri, 11 Sep 2020 12:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599826726;
        bh=e2rLNpSSPlfXQApj1N9es8kEQ7VauP5rvTnqvzcHa2k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HykGSzWoqsmD4Z1bSb5m3kX97xVITp84kSYNdWZRbD+AAQdzwNf8EGROKm/9bkblp
         O8ynHNnBXggy/moRu5DoGYFVVjFtz5JP1p4bP8MDk8NDckOKNCkpcHLGOwRfW+5r+6
         Zvsot9U6douaJmHXEZp8pz5iq0WGByyHaSQFI5do=
Date:   Fri, 11 Sep 2020 17:48:38 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: Re: [PATCH v2] dmaengine: Kconfig: Update description for RCAR_DMAC
 config
Message-ID: <20200911121838.GC77521@vkoul-mobl>
References: <20200911095734.19348-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911095734.19348-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 11-09-20, 10:57, Lad Prabhakar wrote:
> rcar-dmac driver is used on Renesas R-Car Gen{2,3} and Renesas
> RZ/G{1,2} SoC's, update the same to reflect the description
> for RCAR_DMAC config.

Applied, thanks

-- 
~Vinod
