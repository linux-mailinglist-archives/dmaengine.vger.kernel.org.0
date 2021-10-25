Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84AB1438E16
	for <lists+dmaengine@lfdr.de>; Mon, 25 Oct 2021 06:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhJYE0b (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Oct 2021 00:26:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:53952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229678AbhJYE02 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 25 Oct 2021 00:26:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C64D060F9B;
        Mon, 25 Oct 2021 04:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635135846;
        bh=Lo4ZXU3swrI/CoQaLW+tWAClSe9XbVcmKuRTaCOG7jo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lYiPFiPaqW6yqyFtyYgoFJ2Fwja8suK/ETKV3BQFokp2TWOZ4Gy36EkQ0QrtrK/Zu
         gO2nIKqSZxs55niusXgG6Fd+475CcSdJSU7vXFijh7G30J/lo8Ttu+yD7c2FSCf9xV
         dWOLX2Qkvs1RfgI3uzlICyURMniOVTR3kTBQnxYphNKvB0Igyn6D2YVgVrpnO67UU5
         vUUiM+72tTAJZwUYzjth7WwS0GZKAAkjfW2ElVGkOoM1+7BXrWObJlpBW3pwu1rnqz
         677GlAMqDfuQHcxybDsOR3Egi83sovmKYT8XNfxUORgysA6X0KiqFxB7yRfEsegG09
         qhfw5GP23VE7A==
Date:   Mon, 25 Oct 2021 09:54:02 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Zou Wei <zou_wei@huawei.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: rcar-dmac: refactor the error handling code
 of rcar_dmac_probe
Message-ID: <YXYxYsqpJbl4eS+j@matsya>
References: <20211020143546.3436205-1-mudongliangabcd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020143546.3436205-1-mudongliangabcd@gmail.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20-10-21, 22:35, Dongliang Mu wrote:
> In rcar_dmac_probe, if pm_runtime_resume_and_get fails, it forgets to
> disable runtime PM. And of_dma_controller_free should only be invoked
> after the success of of_dma_controller_register.
> 
> Fix this by refactoring the error handling code.

Applied, thanks

-- 
~Vinod
