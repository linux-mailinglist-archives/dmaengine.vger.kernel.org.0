Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57B7E4310A7
	for <lists+dmaengine@lfdr.de>; Mon, 18 Oct 2021 08:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbhJRGjv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 18 Oct 2021 02:39:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:42976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229848AbhJRGjs (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 18 Oct 2021 02:39:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7F19F60E90;
        Mon, 18 Oct 2021 06:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634539057;
        bh=st22Yv9gGtGF5rK3Snj/UyFPreS8L4NVg4Ho2rtsOV0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jxMkZ6kXpsAnonQL+tFg0U7CdO+c7M9P2HlvwuT/kcm8QlJPxmF5v79YeYC7h88qH
         a8nG7aJPg1tCywaaz5wz7Fh7saYkGSL7rWiEDoSHsrxRwsYIte0Nxpxwbbe4OnLERt
         rOrfjeR5nXaunAvTw/xvEJ7xWpNmOl9aX8ovdiCg6WL7TZv+v1y0b2bt74YpD5TRIZ
         FOQoROwnHKpVzL33Wqvfd5UO6IvnGV2ZFAv9Kt2WrpfPtyibfse5pbjmPrg3osrl83
         1i8vQnAjJL0E++TBUyTMgmqETNXWfS4I0fnjQeqItEDvhw8pRxmu5q2V9bekyQwLzW
         j9uAis+YRBwwg==
Date:   Mon, 18 Oct 2021 12:07:33 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Paul Cercueil <paul@crapouillou.net>, linux-mips@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: jz4780: Set max number of SGs per burst
Message-ID: <YW0WLfbGFe4B0NIg@matsya>
References: <20210829195805.148964-1-contact@artur-rojek.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210829195805.148964-1-contact@artur-rojek.eu>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 29-08-21, 21:58, Artur Rojek wrote:
> Total amount of SG list entries executed in a single burst is limited by
> the number of available DMA descriptors.
> This information is useful for device drivers utilizing this DMA engine.

Applied, thanks

-- 
~Vinod
