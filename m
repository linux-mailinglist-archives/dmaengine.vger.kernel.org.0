Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0D4C1B0556
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2020 11:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbgDTJOg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 20 Apr 2020 05:14:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:41434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbgDTJOg (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 20 Apr 2020 05:14:36 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08C692078E;
        Mon, 20 Apr 2020 09:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587374075;
        bh=+x/OfWUtv6vxKKGVV82g7KQURoCOuxYGmr6C4EACaJc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FWW6qJ6ZX323VPf6/ew/Zd9S7mctMMY46H2fDfg6+6MVwlnMW76TITYkYxo17RpuL
         1bkpH9ag5tCOybB9eJk99eMNiFqz+tcvkaCwHFFRwYDLMhmDlX+zxfz7nWQVw9LsSr
         QT+T6VJIQgoHmE4wiM2NUAwghoGg872domNLa8OQ=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jQSVd-004osT-CU; Mon, 20 Apr 2020 10:14:33 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 20 Apr 2020 10:14:33 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Alan Mikhak <alan.mikhak@sifive.com>
Cc:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-pci@vger.kernel.org, tglx@linutronix.de, kishon@ti.com,
        paul.walmsley@sifive.com
Subject: Re: [PATCH] genirq/msi: Check null pointer before copying struct
 msi_msg
In-Reply-To: <CY4PR12MB1271277CEE4F1FE06B71DDE8DAD60@CY4PR12MB1271.namprd12.prod.outlook.com>
References: <1587149322-28104-1-git-send-email-alan.mikhak@sifive.com>
 <20200418122123.10157ddd@why>
 <CY4PR12MB1271277CEE4F1FE06B71DDE8DAD60@CY4PR12MB1271.namprd12.prod.outlook.com>
Message-ID: <8a03b55223b118c6fc605d7204e01460@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: Gustavo.Pimentel@synopsys.com, alan.mikhak@sifive.com, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, tglx@linutronix.de, kishon@ti.com, paul.walmsley@sifive.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2020-04-18 16:19, Gustavo Pimentel wrote:
> Hi Marc and Alan,
> 
>> I'm not convinced by this. If you know that, by construction, these
>> interrupts are not associated with an underlying MSI, why calling
>> get_cached_msi_msg() the first place?
>> 
>> There seem to be some assumptions in the DW EDMA driver that the
>> signaling would be MSI based, so maybe someone from Synopsys 
>> (Gustavo?)
>> could clarify that. From my own perspective, running on an endpoint
>> device means that it is *generating* interrupts, and I'm not sure what
>> the MSIs represent here.
> 
> Giving a little context to this topic.
> 
> The eDMA IP present on the Synopsys DesignWare PCIe Endpoints can be
> configured and triggered *remotely* as well *locally*.
> For the sake of simplicity let's assume for now the eDMA was 
> implemented
> on the EP and that is the IP that we want to configure and use.
> 
> When I say *remotely* I mean that this IP can be configurable through 
> the
> RC/CPU side, however, for that, it requires the eDMA registers to be
> exposed through a PCIe BAR on the EP. This will allow setting the SAR,
> DAR and other settings, also need(s) the interrupt(s) address(es) to be
> set as well (MSI or MSI-X only) so that it can signal through PCIe (to
> the RC and consecutively the associated EP driver) if the data transfer
> has been completed, aborted or if the Linked List consumer algorithm 
> has
> passed in some linked element marked with a watermark.
> 
> It was based on this case that the eDMA driver was exclusively 
> developed.
> 
> However, Alan, wants to expand a little more this, by being able to use
> this driver on the EP side (through
> pcitest/pci_endpoint_test/pci_epf_test) so that he can configure this 
> IP
> *locally*.
> In fact, when doing this, he doesn't need to configure the interrupt
> address (MSI or MSI-X), because this IP provides a local interrupt line
> so that be connected to other blocks on the EP side.

Right, so this confirms my hunch that the driver is being used in
a way that doesn't reflect the expected use case. Rather than
papering over the problem by hacking the core code, I'd rather see
the eDMA driver be updated to support both host and endpoint cases.
This probably boils down to a PCI vs non-PCI set of helpers.

Alan, could you confirm whether we got it right?

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
