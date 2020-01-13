Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14475138EC1
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jan 2020 11:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbgAMKON (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Jan 2020 05:14:13 -0500
Received: from mail.skyhub.de ([5.9.137.197]:36366 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbgAMKON (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 13 Jan 2020 05:14:13 -0500
Received: from zn.tnic (p200300EC2F05D30079493D5CC5A0A656.dip0.t-ipconnect.de [IPv6:2003:ec:2f05:d300:7949:3d5c:c5a0:a656])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C93B61EC0CBF;
        Mon, 13 Jan 2020 11:14:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1578910451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=uyzwFFgXjMyE/RLASJQrmO0cgJJvf3zehRKlqFezuOI=;
        b=HM65lqkXVXxmqN2uYJ5CfMDjkPeZpYqMkntGHVO8IzhYu54898W9e5mhlmyqtL2gGDdWCa
        Iwe/Kfh4DKbNvSUmTN8SByJy82eXK9nFC5BpARLpkh/4iKlyD9NSum4q1a7uHLTo/DC2CD
        Tjd0kXRfMGkUsf7ql1D5Y3+h7Fa8aJ4=
Date:   Mon, 13 Jan 2020 11:14:03 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, dan.j.williams@intel.com, tony.luck@intel.com,
        jing.lin@intel.com, ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        megha.dey@intel.com, jacob.jun.pan@intel.com, yi.l.liu@intel.com,
        tglx@linutronix.de, mingo@redhat.com, fenghua.yu@intel.com,
        hpa@zytor.com
Subject: Re: [PATCH v4 1/9] x86/asm: add iosubmit_cmds512() based on
 MOVDIR64B CPU instruction
Message-ID: <20200113101403.GD13310@zn.tnic>
References: <157842940405.27241.1146722525082010210.stgit@djiang5-desk3.ch.intel.com>
 <157842965854.27241.2519525691634439881.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <157842965854.27241.2519525691634439881.stgit@djiang5-desk3.ch.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Jan 07, 2020 at 01:40:58PM -0700, Dave Jiang wrote:
> With the introduction of MOVDIR64B instruction, there is now an instruction
> that can write 64 bytes of data atomically.
> 
> Quoting from Intel SDM:
> "There is no atomicity guarantee provided for the 64-byte load operation
> from source address, and processor implementations may use multiple
> load operations to read the 64-bytes. The 64-byte direct-store issued
> by MOVDIR64B guarantees 64-byte write-completion atomicity. This means
> that the data arrives at the destination in a single undivided 64-byte
> write transaction."
> 
> We have identified at least 3 different use cases for this instruction in
> the format of func(dst, src, count):
> 1) Clear poison / Initialize MKTME memory
>    @dst is normal memory.
>    @src in normal memory. Does not increment. (Copy same line to all
>    targets)
>    @count (to clear/init multiple lines)
> 2) Submit command(s) to new devices
>    @dst is a special MMIO region for a device. Does not increment.
>    @src is normal memory. Increments.
>    @count usually is 1, but can be multiple.
> 3) Copy to iomem in big chunks
>    @dst is iomem and increments
>    @src in normal memory and increments
>    @count is number of chunks to copy
> 
> Add support for case #2 to support device that will accept commands via
> this instruction. We provide a @count in order to submit a batch of
> preprogrammed descriptors in virtually contiguous memory. This
> allows the caller to submit multiple descriptors to a devices with a single

						  "to a device"

> submission. The special device requires the entire 64bytes descriptor to
> be written atomically and will accept MOVDIR64B instruction.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

but the above can be fixed by whoever applies this.

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
