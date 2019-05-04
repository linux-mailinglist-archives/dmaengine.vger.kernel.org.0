Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61AD513948
	for <lists+dmaengine@lfdr.de>; Sat,  4 May 2019 12:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbfEDKlT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 4 May 2019 06:41:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:44562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbfEDKlT (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 4 May 2019 06:41:19 -0400
Received: from localhost (unknown [171.76.113.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DF7E206DF;
        Sat,  4 May 2019 10:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556966478;
        bh=WPgDsiRAWGl6cYk9+UaqVpxky1SOfv1Rv6gC/CxcwD4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vovh8+HfrdkTi4hHizRlpfdDnv2Q/kzZ0UN8KRs6wNciJaoNjZsMecpUkkT6lZkBw
         f4SBP5Ubuwh0hFgfYM1GLeGe8x09tGRo1bba5Ji+dyKiIT9wjb2lL7P5SvYey/fBan
         wT8wfIH/f6uNJwblij31iCmNr3Pz7VpBEqAedVuc=
Date:   Sat, 4 May 2019 16:11:09 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Barry Song <21cnbao@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] dmaengine: at_xdmac: remove a stray bottom half unlock
Message-ID: <20190504104109.GA3845@vkoul-mobl.Dlink>
References: <20190503131507.GA1236@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503131507.GA1236@mwanda>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 03-05-19, 16:15, Dan Carpenter wrote:
> We switched this code from spin_lock_bh() to vanilla spin_lock() but
> there was one stray spin_unlock_bh() that was overlooked.  This
> patch converts it to spin_unlock() as well.

Applied, thanks

-- 
~Vinod
