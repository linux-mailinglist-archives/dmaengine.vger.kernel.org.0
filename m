Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B76501AEC0F
	for <lists+dmaengine@lfdr.de>; Sat, 18 Apr 2020 13:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbgDRLV3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 18 Apr 2020 07:21:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:49954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbgDRLV2 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 18 Apr 2020 07:21:28 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 911CA21D79;
        Sat, 18 Apr 2020 11:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587208887;
        bh=77wH0JlbUKInqkEkZYANjIIPct4Xemzg7GiHD8oFtqY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NLB/ZicyUDIxey2fxqxQOXODT77sVJZQcqZKsU8IZeZMavmwzJxuF6Q9Yy9RgjJ2W
         ArPRj/TRmUCFc3SkqTl999PoABRpxWrTNHqIug/WXL/ELyPnO8AW7C/RZIAQy2IQyk
         ClGR2JVfFExTmtT9iTR5TJRakT0dLuyPppHumC+U=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jPlXJ-004Pmh-IF; Sat, 18 Apr 2020 12:21:25 +0100
Date:   Sat, 18 Apr 2020 12:21:23 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Alan Mikhak <alan.mikhak@sifive.com>
Cc:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-pci@vger.kernel.org, tglx@linutronix.de,
        gustavo.pimentel@synopsys.com, kishon@ti.com,
        paul.walmsley@sifive.com
Subject: Re: [PATCH] genirq/msi: Check null pointer before copying struct
 msi_msg
Message-ID: <20200418122123.10157ddd@why>
In-Reply-To: <1587149322-28104-1-git-send-email-alan.mikhak@sifive.com>
References: <1587149322-28104-1-git-send-email-alan.mikhak@sifive.com>
Organization: Approximate
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: alan.mikhak@sifive.com, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, tglx@linutronix.de, gustavo.pimentel@synopsys.com, kishon@ti.com, paul.walmsley@sifive.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, 17 Apr 2020 11:48:42 -0700
Alan Mikhak <alan.mikhak@sifive.com> wrote:

Hi Alan,

> From: Alan Mikhak <alan.mikhak@sifive.com>
> 
> Modify __get_cached_msi_msg() to check both pointers for null before
> copying the contents from the struct msi_msg pointer to the pointer
> provided by caller.
> 
> Without this sanity check, __get_cached_msi_msg() crashes when invoked by
> dw_edma_irq_request() in drivers/dma/dw-edma/dw-edma-core.c running on a
> Linux-based PCIe endpoint device. MSI interrupt are not received by PCIe
> endpoint devices. As a result, irq_get_msi_desc() returns null since there
> are no cached struct msi_msg entry on the endpoint side.
> 
> Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
> ---
>  kernel/irq/msi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
> index eb95f6106a1e..f39d42ef0d50 100644
> --- a/kernel/irq/msi.c
> +++ b/kernel/irq/msi.c
> @@ -58,7 +58,8 @@ void free_msi_entry(struct msi_desc *entry)
>  
>  void __get_cached_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
>  {
> -	*msg = entry->msg;
> +	if (entry && msg)
> +		*msg = entry->msg;
>  }
>  
>  void get_cached_msi_msg(unsigned int irq, struct msi_msg *msg)

I'm not convinced by this. If you know that, by construction, these
interrupts are not associated with an underlying MSI, why calling
get_cached_msi_msg() the first place?

There seem to be some assumptions in the DW EDMA driver that the
signaling would be MSI based, so maybe someone from Synopsys (Gustavo?)
could clarify that. From my own perspective, running on an endpoint
device means that it is *generating* interrupts, and I'm not sure what
the MSIs represent here.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
