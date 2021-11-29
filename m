Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46EDB462493
	for <lists+dmaengine@lfdr.de>; Mon, 29 Nov 2021 23:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbhK2WVd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 Nov 2021 17:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234155AbhK2WUF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 29 Nov 2021 17:20:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1A5C07CA2C;
        Mon, 29 Nov 2021 11:57:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B092B815C3;
        Mon, 29 Nov 2021 19:57:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29009C53FC7;
        Mon, 29 Nov 2021 19:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638215819;
        bh=DhEombK07QwNpXLoXCpOa6HpTzpV1NgajiSa+1qwN+k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=G/KxpR0xy14HXlT475qhaNwJrIxGYP/VsTeY+NiH1U2p2H5PmALhUHuDP4hkjOS5h
         3lXp3PDufcrlUvBTVZO9d7j9TiJl8STfLCuiDcBUD6jBV4smCa81kBrpO1mnSocjVj
         3U24gDeDb89Eh7BebiuM27eb+200niBO8f6FyxLRunkHUAEZlsfdRqCc+vFlwQ2dmK
         f+jw49pRuDRaEzpLkQ4lkOdH6W9D/uKM0E46vuo4PqfGRCoGtbv/w39lmFHgbN6fG7
         J3gSGPvUHbqdR9AK5MlvAOb5Nd8471kkNOtChSeIIjWtYkYiqys+s9OLB/cRpTVjRx
         ICNuZdXwRdytw==
Message-ID: <ec986700-48b7-6b35-b404-efb578dccb3c@kernel.org>
Date:   Mon, 29 Nov 2021 14:56:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [patch 37/37] dmaengine: qcom_hidma: Cleanup MSI handling
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dmaengine@vger.kernel.org, Santosh Shilimkar <ssantosh@kernel.org>,
        iommu@lists.linux-foundation.org,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>
References: <20211126224100.303046749@linutronix.de>
 <20211126230526.111397616@linutronix.de>
From:   Sinan Kaya <okaya@kernel.org>
In-Reply-To: <20211126230526.111397616@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 11/26/2021 8:22 PM, Thomas Gleixner wrote:
> There is no reason to walk the MSI descriptors to retrieve the interrupt
> number for a device. Use msi_get_virq() instead.
> 
> Signed-off-by: Thomas Gleixner<tglx@linutronix.de>
> Cc: Sinan Kaya<okaya@kernel.org>
> Cc:dmaengine@vger.kernel.org

Acked-by: Sinan Kaya <okaya@kernel.org>
