Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 031C4438FB4
	for <lists+dmaengine@lfdr.de>; Mon, 25 Oct 2021 08:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbhJYGsQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Oct 2021 02:48:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:50088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231362AbhJYGsL (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 25 Oct 2021 02:48:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8AB0C60EE3;
        Mon, 25 Oct 2021 06:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635144349;
        bh=7+3Z11f0cDWTPdg3Z01O1Q1dpJslpStItpjZGPBcBMo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=it3E4cthtYvRPJmDDPgZLfo5QFVgL8/q2XH7R1kMn8oSQSCyVrpm5cc9/ZJ/+Sq7F
         Dc5lzoZTUuvM3udDK4HLxJN3qlUcqNMlU2U7QwOTtUVMot5u6BbbqZroxoCbx4tmvG
         UJjpd0kZC2/E5wDBrg70/adTgJJmSCFOkfnv5x6LVDHSfB9weMX6WTXtqpdfSGB/HU
         Si/o4wNCilW1GlEQrFoKYN2ju1GemnzYmbSq7denBkEQgOQOc4reNetHWW0iovmPBD
         i9fYbRpVF8mgUNivki1pEa6z/9SNPEJmycj1dgLKvnSA9AfyIRuPNmMbjVFNTk9ecO
         kW6RypDb8JuAA==
Date:   Mon, 25 Oct 2021 12:15:45 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     dmaengine@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][V2] dmaengine: sh: make array ds_lut static
Message-ID: <YXZSmQO9kQiZiCYj@matsya>
References: <20210915112038.12407-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210915112038.12407-1-colin.king@canonical.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 15-09-21, 12:20, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Don't populate the read-only array ds_lut on the stack but instead it
> static. Also makes the object code smaller by 163 bytes:
> 
> Before:
>    text    data     bss     dec     hex filename
>   23508    4796       0   28304    6e90 ./drivers/dma/sh/rz-dmac.o
> 
> After:
>    text    data     bss     dec     hex filename
>   23281    4860       0   28141    6ded ./drivers/dma/sh/rz-dmac.o
> 
> (gcc version 11.2.0)

Applied, thanks

-- 
~Vinod
