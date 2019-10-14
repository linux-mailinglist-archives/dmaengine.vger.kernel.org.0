Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F225D5CAE
	for <lists+dmaengine@lfdr.de>; Mon, 14 Oct 2019 09:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729880AbfJNHwd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 14 Oct 2019 03:52:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:42764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbfJNHwc (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 14 Oct 2019 03:52:32 -0400
Received: from localhost (unknown [122.167.124.160])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EECE2083B;
        Mon, 14 Oct 2019 07:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571039552;
        bh=rweeonjsw8naho+gNJqiuevBJQ9nomUKksfa/8xkYEE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xRr5m15W9V2AyaaXcUOaS4y83v8iLxDYvC4KyhFR/JjOMNJZeNFud5/sHeO+GoEcD
         PISP2XOFszMT47lhxk5ES81Ah0uyFQVTSKtPSv7wAgJdCeUHF2NiM21NrfUSyKj873
         wDHFPEtFEmgSN4z4RNgJqz1LNAFqUOVDTt0KLplQ=
Date:   Mon, 14 Oct 2019 13:22:28 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     dmaengine@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Dan Williams <dan.j.williams@intel.com>,
        Long Cheng <long.cheng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] dmaengine: mediatek: Use
 devm_platform_ioremap_resource() in mtk_uart_apdma_probe()
Message-ID: <20191014075228.GG2654@vkoul-mobl>
References: <366e776c-8760-eeb7-c248-7380c9f4fd34@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <366e776c-8760-eeb7-c248-7380c9f4fd34@web.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 22-09-19, 13:14, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 22 Sep 2019 13:07:41 +0200
> 
> Simplify this function implementation by using a known wrapper function.
> 
> This issue was detected by using the Coccinelle software.

Applied, thanks

-- 
~Vinod
