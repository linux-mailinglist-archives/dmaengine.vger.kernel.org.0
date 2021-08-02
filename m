Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B68E73DD0BD
	for <lists+dmaengine@lfdr.de>; Mon,  2 Aug 2021 08:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbhHBGrJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 Aug 2021 02:47:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:41404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229734AbhHBGrJ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 2 Aug 2021 02:47:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6976F60F11;
        Mon,  2 Aug 2021 06:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627886820;
        bh=rusHs7DnGFV9Lm/2QNoVAHy6+ABGVkY3Ql1sJ/q/ac0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ngbcaRspAKdysi3pypPlaZ1uvojuzwu6A9WP72L3TFD5kyXJAC8SMLelolUI9X2qw
         9sUhheOzU3kd5NAKNZZ2jaS07H8KhrWFMauuHUSwqTfY3ZFQZRugkX3FvosmgpK2VM
         XiIaqaZzhmoJKjEpW+2p34bD2X+7DQCze9ZZZi36vacVjAh0AEZChpzGehNm9HGaEu
         Dsp04j4FXSC54UGGUlIpwrjJE4152fTS8UiQwPHOwRN+EgpdaQfZRqDlVnMHB+q0VV
         lChNhNj5Rxu1B6kGoqUw7YvTxw2lhuUS3c4Bgux5LaDOFybMZgQrWk5GkqO5PgVCO3
         0zp3z3EmRsU7A==
Date:   Mon, 2 Aug 2021 12:16:55 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jordy Zomer <jordy@pwning.systems>
Cc:     dmaengine@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: usb-dmac: make usb_dmac_get_current_residue
 unsigned
Message-ID: <YQeU31f1VXqS4x5g@matsya>
References: <20210731091939.510816-1-jordy@pwning.systems>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210731091939.510816-1-jordy@pwning.systems>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 31-07-21, 11:19, Jordy Zomer wrote:
> The usb_dmac_get_current_residue function used to
> take a signed integer as a pos parameter.
> The only callers of this function passes an unsigned integer to it.
> Therefore to make it obviously safe, let's just make this an unsgined
> integer as this is used in pointer arithmetics.

Applied, thanks

-- 
~Vinod
