Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6669CA7B41
	for <lists+dmaengine@lfdr.de>; Wed,  4 Sep 2019 08:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbfIDGLE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Sep 2019 02:11:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:58052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbfIDGLD (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 4 Sep 2019 02:11:03 -0400
Received: from localhost (unknown [122.182.201.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 593FD2339D;
        Wed,  4 Sep 2019 06:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567577463;
        bh=VuZZHQLylN2oeX17s3iJ894CYFarojWPOt6CcbYnzds=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ndERszuOw8awsFsPJwytEzSeC8FdBPPSkTTAQt4QB3xwgtBXQyjmHilxHTlcRunTz
         JE5rS6o/rq4hGJdED2dz7Mci/H6opKNNKAIU9EQ8ckH2rDmce8B0POi4vbQMbwSZYj
         p2FunHoGj+czL+ePsE9UhVem90+VREZcejtuB+h4=
Date:   Wed, 4 Sep 2019 11:39:55 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 0/2] dmaengine: rcar-dmac: minor modifications
Message-ID: <20190904060955.GG2672@vkoul-mobl>
References: <1566904231-25486-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566904231-25486-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 27-08-19, 20:10, Yoshihiro Shimoda wrote:
> This patch series is based on renesas-drivers.git /
> renesas-drivers-2019-08-13-v5.3-rc4 tag. This is minor modifications
> to add support for changed registers memory mapping hardware support
> easily in the future.

This fails to apply for me, please rebase and resend.

Thanks

-- 
~Vinod
