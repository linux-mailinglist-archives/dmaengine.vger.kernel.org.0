Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDB044A4A71
	for <lists+dmaengine@lfdr.de>; Mon, 31 Jan 2022 16:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379379AbiAaPVr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Jan 2022 10:21:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241253AbiAaPVr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Jan 2022 10:21:47 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C326EC061714;
        Mon, 31 Jan 2022 07:21:46 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id e81so27254954oia.6;
        Mon, 31 Jan 2022 07:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=oVZWckNIPsWHeKbXJ2sFvACBl5okPcSAEIsKC6XhxDU=;
        b=NXQ2vh5WqJcNrwvi+uhxOeXRwL3TuQvr8zI74nXKNlbA4THVcrFQe20l84a2F3rCSl
         fb+2O3VmewcReatZ19klOskQ2upf6qljRrD6n2B9Y4PhroYWW+XOfsdsfB3MZuirxQ9t
         X+vPYa1ikH13JYbnSKqVdMeH1jmxa4D6k59/FHZubOFHJbDfNxiaB8VfMIjtaMgLtJV+
         3A2GEeuqlrodVHjFD7y9lvjUf+N31nBGTmFabP1WX1nvXw95IBSd2qgNRGX0BxRvAmns
         3J8DZp0qcC/r7rrsLbS0TgQNcR7BR3VDw0NU5D6j9PO9dXHpEDeoVqLmRligf9NcdWA6
         MSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=oVZWckNIPsWHeKbXJ2sFvACBl5okPcSAEIsKC6XhxDU=;
        b=KywFr/OqYMsf3qiaElSRqlSWv6PhIuJkZBMaeZcZmCrMnwj09ZfcYxqGtcZ+jVolwZ
         KlB7ay/40xZ+j8S3irzoABlLB3gcmKr4gNvKvocXi2Wod3WPESxpYfZHJ8de7p88QCxr
         DrqidW7OpNKBtFJhjdth2pyPrGFKzwWo0mqOeP5hanlcFKmHpoWEjJ/ZSpDt4hLEEhfP
         R6a/d9heCj46D9wqtCpIj8AGC8RpskMOJp91B2Unpt5xFqa6B0xTpIxhdronb+AOoDEu
         5ht0V9CuMBAg+mOWDvkV9Wy0viP80Al/upgtdU5avyipYryyvjlt+i7C2JQirSaoCNgZ
         t9kg==
X-Gm-Message-State: AOAM530Cl83PjeZaRDrEZUBsw/MaSrRs2zOSzgRdmn2ZDhWPsHTdcd49
        SRu7+VoFIDWdA/ppoXmtVwM=
X-Google-Smtp-Source: ABdhPJwZ2DsfGoZh9WlCulrelJMyxXaQWZM7t1bPVVjVsAMl6JMrpJ5ac6K1xcqWaqkMGtPCEBWrHw==
X-Received: by 2002:a05:6808:211f:: with SMTP id r31mr12780920oiw.194.1643642506160;
        Mon, 31 Jan 2022 07:21:46 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d65sm9789045otb.17.2022.01.31.07.21.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 07:21:44 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c78df469-1a9f-5778-24d1-8f08a6bf5bcc@roeck-us.net>
Date:   Mon, 31 Jan 2022 07:21:40 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stuart Yoder <stuyoder@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sinan Kaya <okaya@kernel.org>,
        iommu@lists.linux-foundation.org,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Jason Gunthorpe <jgg@nvidia.com>, linux-pci@vger.kernel.org,
        xen-devel@lists.xenproject.org, Kevin Tian <kevin.tian@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cedric Le Goater <clg@kaod.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Megha Dey <megha.dey@intel.com>,
        Juergen Gross <jgross@suse.com>,
        Tero Kristo <kristo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>, Marc Zygnier <maz@kernel.org>,
        dmaengine@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <87mtjc2lhe.ffs@tglx>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [patch V3 28/35] PCI/MSI: Simplify pci_irq_get_affinity()
In-Reply-To: <87mtjc2lhe.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 1/31/22 03:27, Thomas Gleixner wrote:
> On Sun, Jan 30 2022 at 09:12, Guenter Roeck wrote:
>> On Fri, Dec 10, 2021 at 11:19:26PM +0100, Thomas Gleixner wrote:
>> This patch results in the following runtime warning when booting x86
>> (32 bit) nosmp images from NVME in qemu.
>>
>> [   14.825482] nvme nvme0: 1/0/0 default/read/poll queues
>> ILLOPC: ca7c6d10: 0f 0b
>> [   14.826188] ------------[ cut here ]------------
>> [   14.826307] WARNING: CPU: 0 PID: 7 at drivers/pci/msi/msi.c:1114 pci_irq_get_affinity+0x80/0x90
> 
> This complains about msi_desc->affinity being NULL.
> 
>> git bisect bad f48235900182d64537c6e8f8dc0932b57a1a0638
>> # first bad commit: [f48235900182d64537c6e8f8dc0932b57a1a0638] PCI/MSI: Simplify pci_irq_get_affinity()
> 
> Hrm. Can you please provide dmesg and /proc/interrupts from a
> kernel before that commit?
> 

Sure. Please see http://server.roeck-us.net/qemu/x86/.
The logs are generated with with v5.16.4.

Guenter
