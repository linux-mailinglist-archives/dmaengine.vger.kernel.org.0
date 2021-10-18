Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE8314310B6
	for <lists+dmaengine@lfdr.de>; Mon, 18 Oct 2021 08:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhJRGnc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 18 Oct 2021 02:43:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:48628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229708AbhJRGnc (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 18 Oct 2021 02:43:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B80A6610A6;
        Mon, 18 Oct 2021 06:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634539281;
        bh=r8XEynLedlIWszeP/mbPgfymrb5S0nlYbqhT0SweKEw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sFWblukFplM9dB5rMxU2tOgRVNWFx6irzLklFXr29XRxoox69/fsghoGa61S6DnUJ
         /A1lsAslAyPwMZNXVFaQ6luYHOwvBK8AGfisRMzrV4QcminDr9xfuS1cb9IdxDX9T/
         7xRKoTcty9rUIWOqKsdsO/yY3ejweIjoXrUBy4N+a3VcBnZ8qc07w1JoYYXD1Oui06
         zwW2pZtMQZUT2FMTAE7c0IF3PxIYFIEBl7lnf/OM1b10rPXyWQWt0UzNHDNAEEejf1
         +H0R/VpiaqVsEB9KDLCJLLh/XlU7RUGEstVgRcc2dccn9+7jcT0gCYy/Sf0XjvV1gV
         1cxNN0uGd2xqA==
Date:   Mon, 18 Oct 2021 12:11:17 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     gustavo.pimentel@synopsys.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] dmaengine: dw-edma: Remove an unused variable
Message-ID: <YW0XDf18XjOs5IYR@matsya>
References: <46e071be21fbc5ac5c35d4796a7e4249e94c3a77.1633847306.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46e071be21fbc5ac5c35d4796a7e4249e94c3a77.1633847306.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 10-10-21, 08:29, Christophe JAILLET wrote:
> 'head' is unused, remove it.

Applied, thanks

-- 
~Vinod
