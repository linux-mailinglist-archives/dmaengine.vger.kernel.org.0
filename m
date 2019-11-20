Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32C321046F2
	for <lists+dmaengine@lfdr.de>; Thu, 21 Nov 2019 00:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbfKTX0y (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Nov 2019 18:26:54 -0500
Received: from mail.skyhub.de ([5.9.137.197]:55652 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbfKTX0y (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 20 Nov 2019 18:26:54 -0500
Received: from zn.tnic (p200300EC2F0D8C0040FB9E04CC44F6A0.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:8c00:40fb:9e04:cc44:f6a0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 31F9D1EC0A02;
        Thu, 21 Nov 2019 00:26:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1574292413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=/XYqnRGAq6RG2RaGU9yxebpQvpxNBGiW9TEKW3oyXbM=;
        b=lKkjgQ2T4h40tR3ptv2+Ho1zJ71DoGz1OC7Y7iondHIz8kvLm6kBedwzbTyR4uSvpRbh40
        7CJGlyL06XPdxbchffvVnrrfvKU3JttbS2AeXxJUIt///Hbbq7bUNOY9eRowN8q6ZmMUiz
        PNA1yyyVk24Zt8TwOx/e0dS1er5Azto=
Date:   Thu, 21 Nov 2019 00:26:45 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Dave Jiang <dave.jiang@intel.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkoul@kernel.org,
        dan.j.williams@intel.com, jing.lin@intel.com, ashok.raj@intel.com,
        sanjay.k.kumar@intel.com, megha.dey@intel.com,
        jacob.jun.pan@intel.com, yi.l.liu@intel.com, axboe@kernel.dk,
        akpm@linux-foundation.org, tglx@linutronix.de, mingo@redhat.com,
        fenghua.yu@intel.com, hpa@zytor.com
Subject: Re: [PATCH RFC 01/14] x86/asm: add iosubmit_cmds512() based on
 movdir64b CPU instruction
Message-ID: <20191120232645.GO2634@zn.tnic>
References: <157428480574.36836.14057238306923901253.stgit@djiang5-desk3.ch.intel.com>
 <157428502934.36836.8119026517510193201.stgit@djiang5-desk3.ch.intel.com>
 <20191120215338.GN2634@zn.tnic>
 <20191120231923.GA32680@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191120231923.GA32680@agluck-desk2.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Nov 20, 2019 at 03:19:23PM -0800, Luck, Tony wrote:
> That's the underlying functionality of the MOVDIR64B instruction. A
> posted write so no way to know if it succeeded.

So how do you know whether any of the writes went through?

> When using dedicated queues the caller must keep count of how many
> operations are in flight and not send more than the depth of the
> queue.

This way?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
