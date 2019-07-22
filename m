Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDB770252
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jul 2019 16:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbfGVO16 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Jul 2019 10:27:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:55506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbfGVO15 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 22 Jul 2019 10:27:57 -0400
Received: from localhost (unknown [223.226.98.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AECDA2171F;
        Mon, 22 Jul 2019 14:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563805677;
        bh=ufpO/cIg3vENg49rkm26FM8UPrXHskQcxA4RS4RtOzM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zO3kDJZaiGx8OQDtAjQvGwDZPunpQ/sSohn2V0muKqiKEah1PmCQL0RhtF8hTbMfm
         XkJJm1SjcHiYH1EXldkxTarOlVtfukaZBeBOrwVgp3LLWq50ZNu6G7LtEwEzUWij+f
         ueScCxv6eEOdLQtPDsu/pe/RDOnvJgSBEh4g22y4=
Date:   Mon, 22 Jul 2019 19:56:44 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Stefan Wahren <wahrenst@gmx.net>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: bcm2835: Print error in case setting DMA mask
 fails
Message-ID: <20190722142644.GW12733@vkoul-mobl.Dlink>
References: <1563297318-4900-1-git-send-email-wahrenst@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563297318-4900-1-git-send-email-wahrenst@gmx.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 16-07-19, 19:15, Stefan Wahren wrote:
> During enabling of the RPi 4, we found out that the driver doesn't provide
> a helpful error message in case setting DMA mask fails. So add one.

Applied, thanks

-- 
~Vinod
